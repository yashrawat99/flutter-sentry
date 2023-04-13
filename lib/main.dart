import 'package:flutter/material.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:sentry/sentry.dart';

void main() async {
  await SentryFlutter.init(
    (options) {
      options.dsn =
          'https://98b64d7a34dc4d4fa457c9f6afc95488@o4505005435518976.ingest.sentry.io/4505005439713280';
      options.tracesSampleRate = 1.0;
      options.debug = true;
      options.enableWindowMetricBreadcrumbs = true;
    },
    appRunner: () => runApp(const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(
        title: 'Flutter Demo Home Page',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    try {
      setState(() {
        _counter++;
      });
      throw Exception('IGNORE::testing flutter app');
    } catch (exception, stackTrace) {
      Sentry.captureMessage(
        'IGNORE::testing flutter app',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

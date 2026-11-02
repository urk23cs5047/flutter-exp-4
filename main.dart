
import 'package:flutter/material.dart';

void main() {
  runApp(const MileageApp());
}

class MileageApp extends StatelessWidget {
  const MileageApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Car Mileage Calculator',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
        ),
        useMaterial3: true,
      ),
      home: const MileageHomePage(),
    );
  }
}

class MileageHomePage extends StatefulWidget {
  const MileageHomePage({super.key});

  @override
  State<MileageHomePage> createState() =>
      _MileageHomePageState();
}

class _MileageHomePageState extends State<MileageHomePage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController distanceController =
      TextEditingController();

  final TextEditingController fuelController =
      TextEditingController();

  double? mileage;

  void calculateMileage() {
    if (_formKey.currentState!.validate()) {
      final double distance =
          double.parse(distanceController.text);

      final double fuel =
          double.parse(fuelController.text);

      setState(() {
        mileage = distance / fuel;
      });
    }
  }

  void clearFields() {
    distanceController.clear();
    fuelController.clear();

    setState(() {
      mileage = null;
    });
  }

  @override
  void dispose() {
    distanceController.dispose();
    fuelController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Car Mileage Calculator',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Card(
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.directions_car,
                      size: 70,
                      color: Colors.blue,
                    ),
                    const SizedBox(height: 15),

                    const Text(
                      'Calculate Your Car Mileage',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 25),

                    TextFormField(
                      controller: distanceController,
                      keyboardType:
                          const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      decoration: const InputDecoration(
                        labelText: 'Distance Travelled (km)',
                        prefixIcon: Icon(Icons.route),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null ||
                            value.trim().isEmpty) {
                          return 'Please enter distance';
                        }

                        final distance =
                            double.tryParse(value);

                        if (distance == null ||
                            distance <= 0) {
                          return 'Enter a valid positive distance';
                        }

                        return null;
                      },
                    ),

                    const SizedBox(height: 20),

                    TextFormField(
                      controller: fuelController,
                      keyboardType:
                          const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      decoration: const InputDecoration(
                        labelText: 'Fuel Consumed (litres)',
                        prefixIcon: Icon(Icons.local_gas_station),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null ||
                            value.trim().isEmpty) {
                          return 'Please enter fuel consumed';
                        }

                        final fuel =
                            double.tryParse(value);

                        if (fuel == null || fuel <= 0) {
                          return 'Enter valid positive fuel';
                        }

                        return null;
                      },
                    ),

                    const SizedBox(height: 25),

                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: calculateMileage,
                            child: const Text('Calculate'),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: OutlinedButton(
                            onPressed: clearFields,
                            child: const Text('Clear'),
                          ),
                        ),
                      ],
                    ),

                    if (mileage != null) ...[
                      const SizedBox(height: 25),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade50,
                          borderRadius:
                              BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            const Text(
                              'Calculated Mileage',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '${mileage!.toStringAsFixed(2)} km/l',
                              style: const TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

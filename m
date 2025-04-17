Return-Path: <netdev+bounces-183788-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 01431A91F4F
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 16:17:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 888C57AF456
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 14:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4626D2512C9;
	Thu, 17 Apr 2025 14:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="QbyKW375"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2052.outbound.protection.outlook.com [40.107.223.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FBB4245021;
	Thu, 17 Apr 2025 14:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744899448; cv=fail; b=gL5ccci7t0XJJd87ZZZDKVyLZjXWtj/wJ4i7GAgA2ROYZT9HVhhbojZdG0nuiBV2OxZB0kqx937C2+gqTGOp3e1Tjig1oaRaAWEIYWCCpJ3HJnLB6GzN2jTgiosDQRGnbloIP7J41zlVR/Oi2KYcewf6oj2GcYYakaAUttFelFo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744899448; c=relaxed/simple;
	bh=xEbbZ/qkMQED3mUjovmYnGCVNWw8V6nRofh0r3/j4L4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bwyB7FwXSWdkLUjy+vUUGoSJeuodH38f8P26W78Q0sl6upL1UIXAHfhgRqnNRVjXPxtqv0XyuEqnv62EQhJi4NBlzAaXEvD+3VjVjZ0Bz/e4MSHxyYwIsT6TLTVwuobIxjEVti7ZViJEaJL0c6haFrkHAalCVjyBn4xHFS7t6y8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=QbyKW375; arc=fail smtp.client-ip=40.107.223.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bpzx+5RklGoPb6r9eQk9TTM24mLDMhHFC007KR+3wscrT4EqQw056vo/n8t/5rqTPMLYpG0qn/pyyLG/QH1Ebiy6yxiZxPtpkr9xh/n2k6gnPA4kjIlWBk8mjqg2nwMDLhSgqSpmGyXMWHFtFnim2WObu4ZnYjCdo/goMs+IlIkWpVlkE9eWDazDsxE1U269HWr3dt6i2PYinjYswOwyfS1YSyeZfaMwc4Icb7DckVf/w5Zz4qaPMRXU6hiNWJHWSVYrvE5Lvx/YZaJpL3LoxrzAimEg44rRkoJaYiHveEGH89WEOtJL1GxqO9BWGTls1kBItVNyMKbMRFzaX5pSJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xEbbZ/qkMQED3mUjovmYnGCVNWw8V6nRofh0r3/j4L4=;
 b=ruYK8SwxKpls/raxe0bMMuDxaEI6RBs/VMHM4KP+Ec4d/iY2E+TsDRvnzE4jmgZkOHyKIGpUcQFM59/pqGvuNKoTIU1SVxh29CuV7oE7kB+EeE9SCevGhwQQa1QOMYM3JOdznTwbaFuWqOiiXirVBKKsqP1hMQVT3XRXX/kIac17TnyOM082UBvdcQIhJYFA439NYat32anzexN4RPiwy0A+mZm456PYbf+8PUs6km5x5/7VTFmTLWhRJ1E1iFij7X6kBC8MHWX+ObGqhchL6iUHXq/uv+Jb33sS73+7PXkihGa3Aa8NwWTHra4lbgzIbMFpiTIHjtRgfqN9j21nyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xEbbZ/qkMQED3mUjovmYnGCVNWw8V6nRofh0r3/j4L4=;
 b=QbyKW375rmtMCWMGpxsd3Gnfx3RzUfkwkX86tH2/t7lcc+PV6z5IJjUD94GpzP4RS76otf7pYOylTwBh0uV8ztdE1/rI6JMfdCXU7xslV2BmJoHl7yQEhCJRHEV81bLSJ+IdEdRvdMqLxRb0nd2nxUJ/qGklg4UxQ3otNMEPKLCxwASriVHfDHxF/kLXq68laVDaysa5UR6w30bDGKnFnHHIi9Ohu2r41LC96lLOL0fmMg/1S6zmjCWSs5gHSixLkcAUY/qmQRHdmGWcAgoNhd95nieKoQihGeaeZahke3Jpprwo2F8PGMqyEXW6Hq8ORXlDyjPP3QvLD0AyXHLibw==
Received: from DM6PR11MB3209.namprd11.prod.outlook.com (2603:10b6:5:55::29) by
 DS0PR11MB6376.namprd11.prod.outlook.com (2603:10b6:8:c8::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8632.32; Thu, 17 Apr 2025 14:17:21 +0000
Received: from DM6PR11MB3209.namprd11.prod.outlook.com
 ([fe80::18d6:e93a:24e4:7924]) by DM6PR11MB3209.namprd11.prod.outlook.com
 ([fe80::18d6:e93a:24e4:7924%5]) with mapi id 15.20.8632.030; Thu, 17 Apr 2025
 14:17:21 +0000
From: <Thangaraj.S@microchip.com>
To: <netdev@vger.kernel.org>, <fiona.klute@gmx.de>
CC: <andrew+netdev@lunn.ch>, <linux-usb@vger.kernel.org>,
	<davem@davemloft.net>, <Rengarajan.S@microchip.com>,
	<kernel-list@raspberrypi.com>, <linux-kernel@vger.kernel.org>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<UNGLinuxDriver@microchip.com>
Subject: Re: [PATCH net v2] net: phy: microchip: force IRQ polling mode for
 lan88xx
Thread-Topic: [PATCH net v2] net: phy: microchip: force IRQ polling mode for
 lan88xx
Thread-Index: AQHbrrnF1NHCR4iO/kqLmz8BohiEhbOnkk6AgABWFAA=
Date: Thu, 17 Apr 2025 14:17:20 +0000
Message-ID: <ebb1fe9a31abc4045b2f95072c6d3d94ee83239e.camel@microchip.com>
References: <20250416102413.30654-1-fiona.klute@gmx.de>
	 <fcd60fa6-4bb5-47ec-89ab-cbc94f8a62ce@gmx.de>
In-Reply-To: <fcd60fa6-4bb5-47ec-89ab-cbc94f8a62ce@gmx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB3209:EE_|DS0PR11MB6376:EE_
x-ms-office365-filtering-correlation-id: ef30c7e7-0c0d-43a2-6ee8-08dd7dba913e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NTJMaEFlNWdpOGFnS1BqdE1MTlBoS05qUlZQck0rYTR1RTNKV1haUU4yLzJL?=
 =?utf-8?B?NVorSnE5Qk9wQWczSzdBditFczBrQ21WaEhXSFI4bC9aM1ArWmtGRzE3VDU5?=
 =?utf-8?B?dTVvR1RMNXQ5T3ZlQVpNQy91ejlSNUZzMHFWbjhIYVlXL1dRMnBTQTMwRXd3?=
 =?utf-8?B?d3kxMThwT2tnT2NnNE5SaW1RcENNWlhmQXBPUWFZQVEzWmxkOUNSUHBteFpw?=
 =?utf-8?B?RlVZTDRYaEQrWXdJMW85WGJoR2RSVVk1cTZWN3pPU0ZJYS9sWlJheGF4TzJ2?=
 =?utf-8?B?a29NdkRmVVlZOU01a1RuYzc5QlVDd0tmRUNNTWFDaTUrTFNLY3hsUko0cEtS?=
 =?utf-8?B?b1JNL01JUXNQVE95U1VYSjBpczdMMzNiVEJVWmlVQ2dZUThFQjRQQjN6c1BR?=
 =?utf-8?B?Zi9QU1RoYmpmdEZ2SHN2QUNnMFFKZi83VEJLQk14cG5NdUNXRC9Edkc3dVh1?=
 =?utf-8?B?N0l6WXJISkFPTGhxRmpCVzA2R252VDdTcmdWZGxWaTJxUmo5QmRkN0tBRUxP?=
 =?utf-8?B?VFN2SGFTNnlSNU01UHk0RS9KQkNmOWhuczE0Qy9KSEYvd3JmdjlMRjV0bnJr?=
 =?utf-8?B?SWdJZWU0STJtUVB4SmxHb21VeDVkWnpRejZrbVIwMHlGeGQyeHEraE10YjNm?=
 =?utf-8?B?dm9rcXpwWEJDYUhSeUh0NTY5cGNmVDhkcmJ3OHZWTFdCendaZHIrTmJCdG15?=
 =?utf-8?B?YmVzQ3JvWHdka2E5UkJkSE5QQm1KU3N1ZzJJZnM1UzNQQmZsMjFHK3RkNjRo?=
 =?utf-8?B?bnZIQmJpM0NnamFiYWw5UTNMeUpPMytQbWh5OGRyUFF4cHh1L05kbGlJTHl6?=
 =?utf-8?B?aWhNakE1Rkg4RUt1RFMzQm5RdExUTkg5Zk1CUjllWks0dVkrekc4b0NjNXJ3?=
 =?utf-8?B?K09Kcnh3ZGRhNW0rQ21sKzErM21jazhIbFdpdThxTVhXWEJsWkdiZENDRThv?=
 =?utf-8?B?TkU3bmw0VVllUU9OcHRFYzZyMUZ4cThqTmdGbTVPd0wzOE9DKzVFMmdrckFS?=
 =?utf-8?B?VnpOeDNLVGZmRWRVeTBPVDhCNkI2NGl1Ykc1WGtidzhrUXd0L3pYVmF6TDJl?=
 =?utf-8?B?bDJiVTJWTGgwclFGd1FIYVFaMU5CY2hEeVJpK2tGV05ZMnIrZjZiSEsrSTEy?=
 =?utf-8?B?VWdzeHhoR0lnQnhucFhJbDROL1QrMHhlTlNraFJtTWoxVDRUNm5HRnNjeEsv?=
 =?utf-8?B?b2RlM1I1elV5aTUvZjFBY29qcU5yZ1I1QXlDaU1FK1dRbW5qSjFBd0QwQW45?=
 =?utf-8?B?WU5lWFBGdkVwN1ZtL2VuV3dsOS94bU16Y2Y0czkybnVPdSsxWlo3eGJqbkUz?=
 =?utf-8?B?TEtlRm9wRnRHWWlVRFY1bXFMSDZnMTFNRnVabmpycml1NVF3eDc2RkFkU2x2?=
 =?utf-8?B?b0pQR05SVXgya0ovNExYR0NBV2E4cGN4V2dqWWtPVFRxUmFZVWc4ZUVtR0sv?=
 =?utf-8?B?K2ZiRXU5QTQxMFVIbEtIRTRFZ1BPekdhZm93dmFUNCtVczk2L21oYVhtRksv?=
 =?utf-8?B?Y1BLR2lOci93RjlHM3VJUEQ0MktGd2RMUVZYdm5SbEhDU0toampEODNDVnpl?=
 =?utf-8?B?a0ltTEQ4UUxoM1lYeEVodUNERlZqM2JQekttME5BNmZSWkhHVndOUEp0Q3J5?=
 =?utf-8?B?ckVHNVJSeUIzUWNHRi84TmVDUDRrYW40ekRaNTRGMWtSK29UVzFvVGM4MVpR?=
 =?utf-8?B?d1FVenduV096dU5EZVI3VytiZHhweDJKVkhUcyszMU1pd3hxZXh1OHNIYWFp?=
 =?utf-8?B?a3h5WFZTRnJzOFRqOUYrYnNneExJV3hwRk1XeExNZUdjOHVsbklwd05Gdk5D?=
 =?utf-8?B?TVFMeEFWNnJDTmV6OFd1YlV3OW56Zm5EMG84RlRJQ0VTRjdienZibmE0WWJ5?=
 =?utf-8?B?MlRGUkp6M1R5VHl1TFllVjl3ZWlpcFlDamJTWjhDaEplOEg5S3pxUmhuOXh1?=
 =?utf-8?Q?iOH4vRRAFhF7ElehmjvCvO6q2roli8bN?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3209.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NzlrZE12bUhUWlBGYXZQMjc1KzNKRjFDSVZZV0h0TkU5ZHVxZS9zcXQ4N3Jj?=
 =?utf-8?B?ZG5BaFhLMktydXZOc2ltWnRLSzZOMVZ2elMzbWx2RENvTGxpRENyTWp0Mk1H?=
 =?utf-8?B?NG9VQzNIRHZuNVBtTG1UYit6cndVZVE4SEpqL201eWRCZWk3NitkMVExeTZO?=
 =?utf-8?B?YVdnYXhCdjZ1RlpTWVBNOUFQT0Vra2hSNkZNT2I1N2l0c0lUWFJIMmZRclA3?=
 =?utf-8?B?ekF6UHBJNEtIUFNSYWpGRjl1SjhYMGNId2tTdjZralRJS2Z2bkdnemNlYW9F?=
 =?utf-8?B?WWxqdFR0b0xxdFFtZUxqeGU4dUdZb1JHditiZ2k3czV2ZWxNY1l6UnpKdzhh?=
 =?utf-8?B?TEc3R0ZVOTluMWovZEtXSHBxTCtGT1dwdnFZZzhDV25yaW1zMW5oQW80OUor?=
 =?utf-8?B?Q3gvNWd3eWw2QXRwM3JFd09QOUlFZml1R2pwbEsyL0FYMmxmWVg3NTczWEow?=
 =?utf-8?B?dGJBdU1zWEdJZUJta2RaQTAxTHlnZk1uU0IzZTl4L1VIditxTUFmb2FhdWhX?=
 =?utf-8?B?RXRvNkhQQ1dpQjNLRjVMUVN4bVNvdVcxb0kwbmw0aGN1eVNUM1NtcHIyTHJM?=
 =?utf-8?B?MGZtUmhWU1hCeXFZcUhpN2N2dktBUUNjYWFxYmNCSnJsREZWaURFb1RTd3J3?=
 =?utf-8?B?ZjRCMlZZWStJd2ZNMEZZaDVyYVArdXc4TkE1T2xNcVQ4UVJXd3d5REhZWUc0?=
 =?utf-8?B?RHc2RGpRMjJUdFpoQWtJYTJ3dG5jZEZKVm9qamFzS2hrZHlqV05NTmpoZlZn?=
 =?utf-8?B?dklUWTg3YXR2ZFlQcDBrMVBoNXRvNk9QUUhCNnJjWjRObmR4WGN3akVQVXBs?=
 =?utf-8?B?WWJSSDJ0QUk3TXR4b2F3VXhhdXNlWlpDMXVack1oMi9SOWIzM01wejAxM25o?=
 =?utf-8?B?clhUK3d5UFB0OU84bjRWd3dKNnB6Y1RSaUZlUFh0aCtMQ0JLNmJxaWRVQkxQ?=
 =?utf-8?B?QTR5VVZYR0dmUU5lcW9qN1E3RmRnR3hteGFPRzdIbDVUaG8waU5hR2tMNmx0?=
 =?utf-8?B?N1pXRkN4aWZTQTJiL2dIWDdnYVQ1cVFGcEZ0U09lMkpFTDJOS21tUUoxNWgy?=
 =?utf-8?B?VW1oNWhHM3pjc3ppRTJadEg3d3dqR203eEt6ai9uOTFvZzRFVDFKTTRVZk1m?=
 =?utf-8?B?MXFxR0lUK2tXWjllM0FhTVFZVHZ2eUhtUjcvQmJYTytETkdFL1ZZNUJsclRZ?=
 =?utf-8?B?NHdLMHdiUElDOEIxamNyRDEvN0tKb0U1NnRPOVlqY0ViZUFoekV4YzZkbnE1?=
 =?utf-8?B?bnhPTHVwMFNNRG9pNGNuQU13eWJRSHVwcTlNUFBsQnY2c0xWbzJ3OFN6V3Ru?=
 =?utf-8?B?d0ExTzNtb0VSV1BVelZMM24yaG41VG5ubjN1RlVINlVwd2M1UTdKQUR2aTZL?=
 =?utf-8?B?WUxvbXQzdnVqYjJ2bCtTM0dtZnFNRTdHUXJGbFRSeGpKbmVoT0hnMHZQYWJJ?=
 =?utf-8?B?cUxQVHRnZjdQMUdkdGhFYnBmdlBsTWliRDNReHVHRHgwc3JtbnZwL0xqNWVV?=
 =?utf-8?B?bEd2QXpScHg5UEdHcHh1MmtWN1doaytIWnFWM3pvdVM4WlVQaFBLVWJmQmEw?=
 =?utf-8?B?TXhJT09mUisrbDRxRHRsVEYwRFMram1CQWovY21MVzBTbERzWU5rc0tEWE9Q?=
 =?utf-8?B?Qjc0SVVKV1R6MmpsRkI4ZFptdDRRdFVrTnVKeWovL0FYSlFsRm5xMEJ3RWtH?=
 =?utf-8?B?Rnp5ajJMSkcwVXA3MDV3Q2xjY3lYNG9VTm9YVjJ4N3c5ZlcvK0JFR09vYnYw?=
 =?utf-8?B?UGxmM1VvWTk5MlAxRk43TWhMWDNsaDREUmUrVGdxUXVjSWEyT3pKY1E2Vnly?=
 =?utf-8?B?azF0MDg1NjJuRkxDTEIvdnMrNVZ6T0o3aXNESG1KSC9qOTRkcnNyZWhyc0Y4?=
 =?utf-8?B?YnZxb0ExNkxuNVNVK0lkdGwzOUdUK05nN0VnZDBtWnB4TnBpNDA5R3pROVlO?=
 =?utf-8?B?emRQaGNQYlV0MHhSOWhxSDZxTjZhV1o1dm1vQmduR1BJWFZnNElpeFVuQjJQ?=
 =?utf-8?B?eVlOR1lGTktQbFVBbjd5TEdtRlQrZXhLMDBPb0N1T0xyanNtc2dGWExhRkcv?=
 =?utf-8?B?VnEvRDdkejJPQzVBSlNZSFlVV1ZWTTkwTW5BT1k1V3pnUldqRk9xRC9EZEF5?=
 =?utf-8?B?NW1NNko2aU9qcGZmQk5XU1RqZENBK2l2OStGb0xYaE9jZ01tUVFka0tONUti?=
 =?utf-8?B?R0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <94BEB654BDE5B242A7F17F2F6266E5FD@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3209.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef30c7e7-0c0d-43a2-6ee8-08dd7dba913e
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2025 14:17:21.0444
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Pkt9dDSayYm71vWGtdsbKzC3TZrR3LRf6/totCritH9Sv3EQV31Z6M2Ev0ANJ/93KXPgbOmGlei5atTfI1LIproqnK1D8w4xtUJ6+3wT42k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6376

SGkgRmxvbmEsDQpXZSBoYXZlbid0IG9ic2VydmVkIHRoaXMgaXNzdWUgd2l0aCBvdXIgTEFONzgw
MSArIExBTjg4eHggc2V0dXAgZHVyaW5nDQp0ZXN0aW5nIGluIG91ciBzZXR1cHMuIElzc3VlIHJl
cG9ydGVkICBzcGVjaWZpY2FsbHkgaW4gUlBJIGFuZCBOVmlkZWENCndpdGggd2hpY2ggd2UgaGF2
ZSBub3QgdGVzdGVkIHJlY2VudGx5LiBBZGRpdGlvbmFsbHksIGNvbW11bml0eQ0KZGlzY3Vzc2lv
bnMgc3VnZ2VzdCB0aGF0IHRoaXMgaXNzdWUgbWF5IGhhdmUgYmVlbiBpbnRyb2R1Y2VkIGR1ZSB0
bw0KZHJpdmVyIHVwZGF0ZXMgaW4gdGhlIExBTjc4eHguIFRoZXJlJ3Mgbm8gaGFyZHdhcmUgZXJy
YXRhIGluZGljYXRpbmcNCmFueSBwcm9ibGVtcyB3aXRoIHRoZSBpbnRlcnJ1cHRzIGluIExBTjg4
eHguDQoNCklmIHRoZSBpc3N1ZSBsaWVzIGluIHRoZSBpbnRlcnJ1cHQgaGFuZGxpbmcgd2l0aGlu
IHRoZSBMQU43OHh4LCBpdCdzDQpsaWtlbHkgdGhhdCBzaW1pbGFyIHByb2JsZW1zIGNvdWxkIGFy
aXNlIHdpdGggb3RoZXIgUEhZcyB0aGF0IHN1cHBvcnQNCmludGVycnVwdCBoYW5kbGluZy4gVGhp
cyBuZWVkIHRvIGJlIGRlYnVnZ2VkIGFuZCBhZGRyZXNzZWQgZnJvbSBMQU43OHh4DQpkcml2ZXIg
cmF0aGVyIHRoYW4gcmVtb3ZpbmcgaW50ZXJydXB0IHN1cHBvcnQgaW4gTEFOODh4eC4gDQoNClRo
YW5rcywNClRoYW5nYXJhaiBTYW15bmF0aGFuDQpPbiBUaHUsIDIwMjUtMDQtMTcgYXQgMTE6MDUg
KzAyMDAsIEZpb25hIEtsdXRlIHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNr
IGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdQ0KPiBrbm93IHRoZSBjb250ZW50
IGlzIHNhZmUNCj4gDQo+IEFtIDE2LjA0LjI1IHVtIDEyOjI0IHNjaHJpZWIgRmlvbmEgS2x1dGU6
DQo+ID4gV2l0aCBsYW44OHh4IGJhc2VkIGRldmljZXMgdGhlIGxhbjc4eHggZHJpdmVyIGNhbiBn
ZXQgc3R1Y2sgaW4gYW4NCj4gPiBpbnRlcnJ1cHQgbG9vcCB3aGlsZSBicmluZ2luZyB0aGUgZGV2
aWNlIHVwLCBmbG9vZGluZyB0aGUga2VybmVsDQo+ID4gbG9nDQo+ID4gd2l0aCBtZXNzYWdlcyBs
aWtlIHRoZSBmb2xsb3dpbmc6DQo+ID4gDQo+ID4gbGFuNzh4eCAyLTM6MS4wIGVucDFzMHUzOiBr
ZXZlbnQgNCBtYXkgaGF2ZSBiZWVuIGRyb3BwZWQNCj4gPiANCj4gPiBSZW1vdmluZyBpbnRlcnJ1
cHQgc3VwcG9ydCBmcm9tIHRoZSBsYW44OHh4IFBIWSBkcml2ZXIgZm9yY2VzIHRoZQ0KPiA+IGRy
aXZlciB0byB1c2UgcG9sbGluZyBpbnN0ZWFkLCB3aGljaCBhdm9pZHMgdGhlIHByb2JsZW0uDQo+
ID4gDQo+ID4gVGhlIGlzc3VlIGhhcyBiZWVuIG9ic2VydmVkIHdpdGggUmFzcGJlcnJ5IFBpIGRl
dmljZXMgYXQgbGVhc3QNCj4gPiBzaW5jZQ0KPiA+IDQuMTQgKHNlZSBbMV0sIGJ1ZyByZXBvcnQg
Zm9yIHRoZWlyIGRvd25zdHJlYW0ga2VybmVsKSwgYXMgd2VsbCBhcw0KPiA+IHdpdGggTnZpZGlh
IGRldmljZXMgWzJdIGluIDIwMjAsIHdoZXJlIGRpc2FibGluZyBwb2xsaW5nIHdhcyB0aGUNCj4g
DQo+IEkgbm90aWNlZCBJIGdvdCB3b3JkcyBtaXhlZCB1cCBoZXJlLCBuZWVkcyB0byBiZSBlaXRo
ZXIgImRpc2FibGluZw0KPiBpbnRlcnJ1cHRzIiBvciAiZm9yY2luZyBwb2xsaW5nIiwgbm90ICJk
aXNhYmxpbmcgcG9sbGluZyIuDQo+IA0KPiBTaG91bGQgSSByZS1zZW5kLCBvciBpcyB0aGF0IHNv
bWV0aGluZyB0aGF0IGNhbiBiZSBmaXhlZCB3aGlsZQ0KPiBhcHBseWluZz8NCj4gDQo+IEJlc3Qg
cmVnYXJkcywNCj4gRmlvbmENCj4gDQo+ID4gdmVuZG9yLXN1Z2dlc3RlZCB3b3JrYXJvdW5kICh0
b2dldGhlciB3aXRoIHRoZSBjbGFpbSB0aGF0IHBoeWxpYg0KPiA+IGNoYW5nZXMgaW4gNC45IG1h
ZGUgdGhlIGludGVycnVwdCBoYW5kbGluZyBpbiBsYW43OHh4DQo+ID4gaW5jb21wYXRpYmxlKS4N
Cj4gPiANCj4gPiBJcGVyZiByZXBvcnRzIHdlbGwgb3ZlciA5MDBNYml0cy9zZWMgcGVyIGRpcmVj
dGlvbiB3aXRoIGNsaWVudCBpbg0KPiA+IC0tZHVhbHRlc3QgbW9kZSwgc28gdGhlcmUgZG9lcyBu
b3Qgc2VlbSB0byBiZSBhIHNpZ25pZmljYW50IGltcGFjdA0KPiA+IG9uDQo+ID4gdGhyb3VnaHB1
dCAobGFuODh4eCBkZXZpY2UgY29ubmVjdGVkIHZpYSBzd2l0Y2ggdG8gdGhlIHBlZXIpLg0KPiA+
IA0KPiA+IFsxXSBodHRwczovL2dpdGh1Yi5jb20vcmFzcGJlcnJ5cGkvbGludXgvaXNzdWVzLzI0
NDcNCj4gPiBbMl0gDQo+ID4gaHR0cHM6Ly9mb3J1bXMuZGV2ZWxvcGVyLm52aWRpYS5jb20vdC9q
ZXRzb24teGF2aWVyLWFuZC1sYW43ODAwLXByb2JsZW0vMTQyMTM0LzExDQo+ID4gDQo+ID4gTGlu
azogDQo+ID4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvMDkwMWQ5MGQtM2YyMC00YTEwLWI2ODAt
OWM5NzhlMDRkZGRhQGx1bm4uY2gNCj4gPiBGaXhlczogNzkyYWVjNDdkNTlkICgiYWRkIG1pY3Jv
Y2hpcCBMQU44OHh4IHBoeSBkcml2ZXIiKQ0KPiA+IFNpZ25lZC1vZmYtYnk6IEZpb25hIEtsdXRl
IDxmaW9uYS5rbHV0ZUBnbXguZGU+DQo+ID4gQ2M6IGtlcm5lbC1saXN0QHJhc3BiZXJyeXBpLmNv
bQ0KPiA+IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnDQo+ID4gLS0tDQo+ID4gdjI6DQo+ID4g
LSBhZGQgY29tbWVudCB3aHkgaW50ZXJydXB0IGZ1bmN0aW9ucyBhcmUgbWlzc2luZw0KPiA+IC0g
YWRkIEZpeGVzIHJlZmVyZW5jZQ0KPiA+IHYxOiANCj4gPiBodHRwczovL2xvcmUua2VybmVsLm9y
Zy9uZXRkZXYvMjAyNTA0MTQxNTI2MzQuMjc4NjQ0Ny0xLWZpb25hLmtsdXRlQGdteC5kZS8NCj4g
PiANCj4gPiAgIGRyaXZlcnMvbmV0L3BoeS9taWNyb2NoaXAuYyB8IDQ2ICsrKy0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tDQo+ID4gLS0tLS0NCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCAzIGlu
c2VydGlvbnMoKyksIDQzIGRlbGV0aW9ucygtKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL25ldC9waHkvbWljcm9jaGlwLmMNCj4gPiBiL2RyaXZlcnMvbmV0L3BoeS9taWNyb2NoaXAu
Yw0KPiA+IGluZGV4IDBlMTdjYzQ1OGVmZGMuLjkzZGU4OGMxYzhmZDUgMTAwNjQ0DQo+ID4gLS0t
IGEvZHJpdmVycy9uZXQvcGh5L21pY3JvY2hpcC5jDQo+ID4gKysrIGIvZHJpdmVycy9uZXQvcGh5
L21pY3JvY2hpcC5jDQo+ID4gQEAgLTM3LDQ3ICszNyw2IEBAIHN0YXRpYyBpbnQgbGFuODh4eF93
cml0ZV9wYWdlKHN0cnVjdCBwaHlfZGV2aWNlDQo+ID4gKnBoeWRldiwgaW50IHBhZ2UpDQo+ID4g
ICAgICAgcmV0dXJuIF9fcGh5X3dyaXRlKHBoeWRldiwgTEFOODhYWF9FWFRfUEFHRV9BQ0NFU1Ms
IHBhZ2UpOw0KPiA+ICAgfQ0KPiA+IA0KPiA+IC1zdGF0aWMgaW50IGxhbjg4eHhfcGh5X2NvbmZp
Z19pbnRyKHN0cnVjdCBwaHlfZGV2aWNlICpwaHlkZXYpDQo+ID4gLXsNCj4gPiAtICAgICBpbnQg
cmM7DQo+ID4gLQ0KPiA+IC0gICAgIGlmIChwaHlkZXYtPmludGVycnVwdHMgPT0gUEhZX0lOVEVS
UlVQVF9FTkFCTEVEKSB7DQo+ID4gLSAgICAgICAgICAgICAvKiB1bm1hc2sgYWxsIHNvdXJjZSBh
bmQgY2xlYXIgdGhlbSBiZWZvcmUgZW5hYmxlICovDQo+ID4gLSAgICAgICAgICAgICByYyA9IHBo
eV93cml0ZShwaHlkZXYsIExBTjg4WFhfSU5UX01BU0ssIDB4N0ZGRik7DQo+ID4gLSAgICAgICAg
ICAgICByYyA9IHBoeV9yZWFkKHBoeWRldiwgTEFOODhYWF9JTlRfU1RTKTsNCj4gPiAtICAgICAg
ICAgICAgIHJjID0gcGh5X3dyaXRlKHBoeWRldiwgTEFOODhYWF9JTlRfTUFTSywNCj4gPiAtICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIExBTjg4WFhfSU5UX01BU0tfTURJTlRQSU5fRU5fIHwN
Cj4gPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgIExBTjg4WFhfSU5UX01BU0tfTElOS19D
SEFOR0VfKTsNCj4gPiAtICAgICB9IGVsc2Ugew0KPiA+IC0gICAgICAgICAgICAgcmMgPSBwaHlf
d3JpdGUocGh5ZGV2LCBMQU44OFhYX0lOVF9NQVNLLCAwKTsNCj4gPiAtICAgICAgICAgICAgIGlm
IChyYykNCj4gPiAtICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIHJjOw0KPiA+IC0NCj4gPiAt
ICAgICAgICAgICAgIC8qIEFjayBpbnRlcnJ1cHRzIGFmdGVyIHRoZXkgaGF2ZSBiZWVuIGRpc2Fi
bGVkICovDQo+ID4gLSAgICAgICAgICAgICByYyA9IHBoeV9yZWFkKHBoeWRldiwgTEFOODhYWF9J
TlRfU1RTKTsNCj4gPiAtICAgICB9DQo+ID4gLQ0KPiA+IC0gICAgIHJldHVybiByYyA8IDAgPyBy
YyA6IDA7DQo+ID4gLX0NCj4gPiAtDQo+ID4gLXN0YXRpYyBpcnFyZXR1cm5fdCBsYW44OHh4X2hh
bmRsZV9pbnRlcnJ1cHQoc3RydWN0IHBoeV9kZXZpY2UNCj4gPiAqcGh5ZGV2KQ0KPiA+IC17DQo+
ID4gLSAgICAgaW50IGlycV9zdGF0dXM7DQo+ID4gLQ0KPiA+IC0gICAgIGlycV9zdGF0dXMgPSBw
aHlfcmVhZChwaHlkZXYsIExBTjg4WFhfSU5UX1NUUyk7DQo+ID4gLSAgICAgaWYgKGlycV9zdGF0
dXMgPCAwKSB7DQo+ID4gLSAgICAgICAgICAgICBwaHlfZXJyb3IocGh5ZGV2KTsNCj4gPiAtICAg
ICAgICAgICAgIHJldHVybiBJUlFfTk9ORTsNCj4gPiAtICAgICB9DQo+ID4gLQ0KPiA+IC0gICAg
IGlmICghKGlycV9zdGF0dXMgJiBMQU44OFhYX0lOVF9TVFNfTElOS19DSEFOR0VfKSkNCj4gPiAt
ICAgICAgICAgICAgIHJldHVybiBJUlFfTk9ORTsNCj4gPiAtDQo+ID4gLSAgICAgcGh5X3RyaWdn
ZXJfbWFjaGluZShwaHlkZXYpOw0KPiA+IC0NCj4gPiAtICAgICByZXR1cm4gSVJRX0hBTkRMRUQ7
DQo+ID4gLX0NCj4gPiAtDQo+ID4gICBzdGF0aWMgaW50IGxhbjg4eHhfc3VzcGVuZChzdHJ1Y3Qg
cGh5X2RldmljZSAqcGh5ZGV2KQ0KPiA+ICAgew0KPiA+ICAgICAgIHN0cnVjdCBsYW44OHh4X3By
aXYgKnByaXYgPSBwaHlkZXYtPnByaXY7DQo+ID4gQEAgLTUyOCw4ICs0ODcsOSBAQCBzdGF0aWMg
c3RydWN0IHBoeV9kcml2ZXIgbWljcm9jaGlwX3BoeV9kcml2ZXJbXQ0KPiA+ID0gew0KPiA+ICAg
ICAgIC5jb25maWdfYW5lZyAgICA9IGxhbjg4eHhfY29uZmlnX2FuZWcsDQo+ID4gICAgICAgLmxp
bmtfY2hhbmdlX25vdGlmeSA9IGxhbjg4eHhfbGlua19jaGFuZ2Vfbm90aWZ5LA0KPiA+IA0KPiA+
IC0gICAgIC5jb25maWdfaW50ciAgICA9IGxhbjg4eHhfcGh5X2NvbmZpZ19pbnRyLA0KPiA+IC0g
ICAgIC5oYW5kbGVfaW50ZXJydXB0ID0gbGFuODh4eF9oYW5kbGVfaW50ZXJydXB0LA0KPiA+ICsg
ICAgIC8qIEludGVycnVwdCBoYW5kbGluZyBpcyBicm9rZW4sIGRvIG5vdCBkZWZpbmUgcmVsYXRl
ZA0KPiA+ICsgICAgICAqIGZ1bmN0aW9ucyB0byBmb3JjZSBwb2xsaW5nLg0KPiA+ICsgICAgICAq
Lw0KPiA+IA0KPiA+ICAgICAgIC5zdXNwZW5kICAgICAgICA9IGxhbjg4eHhfc3VzcGVuZCwNCj4g
PiAgICAgICAucmVzdW1lICAgICAgICAgPSBnZW5waHlfcmVzdW1lLA0K


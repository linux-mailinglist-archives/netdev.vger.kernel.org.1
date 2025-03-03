Return-Path: <netdev+bounces-171141-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA7E3A4BB1D
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 10:46:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA08D1893CFD
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 09:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7DFA1F150F;
	Mon,  3 Mar 2025 09:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="nXLgl7bl"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013002.outbound.protection.outlook.com [52.101.67.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98BDB1F1510;
	Mon,  3 Mar 2025 09:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740995190; cv=fail; b=sat12+eegrV5h2dlEWB6c+W7GZCY9Y2aX0FE0o6Ex5AGgNkOSkYpZb1Ra0GYZ0hynNJ2mxfmjFc6aspFYIeTa5KbdTPfMk8jFPLkBQ0GZ6H6Q9W4CqmpuvU8aSjsGjCKxdD8gzJ+ih7+TLQC7VQWqsKFpo1Gg4aXeyoyiG9AzN4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740995190; c=relaxed/simple;
	bh=1/6x4XtHpS5fH31S5PmBIbN8HiXcLNh/iX1mfXMVuNs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kKcHAyJ3Vgj4calTlh38sQARSdhoR06dsB1BcguM3IebzMU/ygXnXpfSGqqn9SfvQMM6BK0wpRo6pryBBWg0It2C8livRhv6TirM0KcFGaxGBWoD8EvEdel/vxl+QRcMab1GkQKYuvV6kdqsbQXwCKmU80Db4e8bzyGt+TH5ZFo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=nXLgl7bl; arc=fail smtp.client-ip=52.101.67.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OZPN9YDuJYU5aajYn+d8mG2ke0ZHdcym0IxcHYl9fLKWbKueIDY8vtlUNZfK3TG1gafm+QH1PfEisLdof4HSHuPvVMeCAN3uN9PUhaac4sebk3zUVimBqC7a9JYI8EJMtXMpolc9yEyoYVKjHK6X81wdwmmH3HaYUof7ktMgW4sBPUli2Ttpf6my0ITA+pTCeyo/C0Sjr3n0qilbaKi7vAAdbhpa7qk1oxnWn7eKpTAXrfHitaHpqwvbMy0AcQaN00CFU9WiR0kAYwsEjRzNkJ3tPD2HNCJ+KntJGH24E6OOXPxdJzStGFVLJFvxQoTiSQzlxtohjr2jV01VKjwyNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1/6x4XtHpS5fH31S5PmBIbN8HiXcLNh/iX1mfXMVuNs=;
 b=L580WDEgzQ2R+ODXJPHQOmdN43A0PlGJVcnV5Q/pB6lCAoJmhx4VhkZvdMKPa4Zo9ZcFCgfeSb8lrBaawV/Np7FWhZa5wBBjmZzYs62SQB5sZZ1AVA1bjHq579sO3xDCMzpfAEZRv/T74iuOsizSitP9Og/NE8ByCyK1y2HN+4UV4uuTuQUZTiMOz7Rs7WFIEja5GoeOnByY3iBLJCkcwL8oSyuIXBbPjQVWpbI0smsgH35UPy5mqAB9YdCPoprUQfGeqycMZKeRoqgVoNcDd8pJyZ74KAeH9W7H1inTNo5JMrTkvhDzTOts7QboBEmADz7XZZFfyjKilTvNShSS7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1/6x4XtHpS5fH31S5PmBIbN8HiXcLNh/iX1mfXMVuNs=;
 b=nXLgl7blIdYhnNEx0BKgGIWk8qhBTtoi1i3DBDMDkE8EHBSNGvWzmSiIB3xGi1R6ENjvyeZ+Uwx6c0BduK2VStIsSqeG68amh2oIOTtc8yWxVOlGH2gaNVIlg5iE/9xK32KaLvC4LIJx4RbLKxQm085z6yP4+pxi+XDpd/9taBUMY7p8kjwucBklhsqSlmjhLNn/5BGJhIRUi6oF0ViamKD+2WIdWewlpwMO7wi9MqZf2Sezo0YQuh5DxDTUi9P0kYMtVInXcTocNU83JCQQtG0oRAp9HJtaRuhW4T/LefrZ1cjW99EVbGxUjaCTceIruDgOx+QUTo3u1OH5nBQ/yg==
Received: from DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:47f::13)
 by AS5PR10MB8079.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:673::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Mon, 3 Mar
 2025 09:46:23 +0000
Received: from DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8198:b4e0:8d12:3dfe]) by DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8198:b4e0:8d12:3dfe%7]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 09:46:23 +0000
From: "MOESSBAUER, Felix" <felix.moessbauer@siemens.com>
To: "pmenzel@molgen.mpg.de" <pmenzel@molgen.mpg.de>, "davem@davemloft.net"
	<davem@davemloft.net>, "jdamato@fastly.com" <jdamato@fastly.com>,
	"romieu@fr.zoreil.com" <romieu@fr.zoreil.com>, "frederic@kernel.org"
	<frederic@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "kuba@kernel.org" <kuba@kernel.org>,
	"edumazet@google.com" <edumazet@google.com>, "leitao@debian.org"
	<leitao@debian.org>, "pabeni@redhat.com" <pabeni@redhat.com>
CC: "Bezdeka, Florian" <florian.bezdeka@siemens.com>, "Kiszka, Jan"
	<jan.kiszka@siemens.com>, "bigeasy@linutronix.de" <bigeasy@linutronix.de>
Subject: Re: [PATCH] net: Handle napi_schedule() calls from non-interrupt
Thread-Topic: [PATCH] net: Handle napi_schedule() calls from non-interrupt
Thread-Index: AQHbjB+LWYyGAH4uCkODOR8MYQhfOLNR/HEAgABGtoCADubXAA==
Date: Mon, 3 Mar 2025 09:46:23 +0000
Message-ID: <52beb53fc2bec333f9e36775413eac1ee8fb080c.camel@siemens.com>
References: <20250221173009.21742-1-frederic@kernel.org>
	 <Z7i-_p_115kr8aj1@LQ3V64L9R2> <Z7j6Tzav6u6Z0A8B@pavilion.home>
In-Reply-To: <Z7j6Tzav6u6Z0A8B@pavilion.home>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.55.2-1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR10MB6828:EE_|AS5PR10MB8079:EE_
x-ms-office365-filtering-correlation-id: c28ea37c-583f-42ff-e2f8-08dd5a384243
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018|921020|13003099007;
x-microsoft-antispam-message-info:
 =?utf-8?B?WjJudkFyNXFNc0s5L2oxYVBITG4ydEJrd05KTDUvVzY5ZzlpQUtMZDduSGpZ?=
 =?utf-8?B?Ymg5T1NzRWVxWEZzNFQ2R1RvOHliR3BxNVhQSXBhdS9PSjVhRXFma2pIZU9C?=
 =?utf-8?B?YkVWbzNsM056ano5cTAyYkNHTzA0ZWJUK0Jkb0NCZnpJR0t3OWxyUWhQVnN1?=
 =?utf-8?B?VkluUjNmeEhQNHpoWS9jTkhMb2NXT3JqZG1QcEN0WXVndHZNSnFKdTlCME1T?=
 =?utf-8?B?SE51UktQUkM5ZTgzQXE2eWRxbWUxblB5V0xZZk9zazVyY0wvQTA4dkRBVmRK?=
 =?utf-8?B?aGo4WGFpeWI2SUFmVzdZbUw4RE8xa2NRQlNmaHN6WUVrS0tiZUJITUNudFkv?=
 =?utf-8?B?bjkvaWRYNUhrT2doRDJhTmFib3dXYW9BMHB5c1FLZ2sxeTRQc3huaWZ6ZXRv?=
 =?utf-8?B?QiswN2p4UGJGai90REVhaHRWWWs5VmM4OGNaK3p5R2J2T1lYeGRpaUVOSVdh?=
 =?utf-8?B?OWdLWERUb2JkeTgwdkNCemNWNmxUVVM0MGU3eENyRzg1UGtXQnp4SmM4aTlW?=
 =?utf-8?B?WnZWaEsvdURiVEJBQTlYYVJTQytrVFhycVRianpGNi92SVd3U3RVbmlUNExJ?=
 =?utf-8?B?ZzdkeUkvbTA5RURrWWhiRDhZbkFuRlUzaVlZNWZ6ZW0ydUJ3Y0JwNWp6Ulo0?=
 =?utf-8?B?TzNsNzlvbVkxZFZ1R3ljN3l1M3ZTOWVTOVhscGZjNVFzRzMyaW1PTW52aFlx?=
 =?utf-8?B?TE9aZmlMTzlraVJjU2dSbi92YTVVelVNWmFVSWRrZmxZZGIvUlo0dUhyb2Zj?=
 =?utf-8?B?S3NUS3hVN1FFeDgybmFDNjhYMW1HbUZLYk5vTUJQWTlZdmZOTUd3RDErUzBQ?=
 =?utf-8?B?eEUxV0NOYnM1Y291UEhnOUltMGJ0UjNIVkNpT05xdlh4ZGpHajc1L2g3eURW?=
 =?utf-8?B?bXVGU0cxcHMyVVpFK2Q5a1BPZjM2bHF4ME12NEJnYWdoMXcxU2dIRDdHZTgy?=
 =?utf-8?B?OVVhV1BtNjNPeDFhSmQyK1czNThTRDJvQUJ1b1BXMk1vRmg5eEN3R1FCQ1Zu?=
 =?utf-8?B?OVVuNGs2a25YUGNRSU53Z0NvRWphcGcvZnp1WVkwRkJXYWx1VGtBR1hDdXhL?=
 =?utf-8?B?eWJ5emdrSU5WVHFQVENWSTBaUEszektaa0pXNVgvNzNqQWtqdEF3QzFIeGFv?=
 =?utf-8?B?ZG9vR0JSQ1loOEtJZnpidk10b3lCOExkUWNBa3lCNVExWFR2TUMvcEtscTRE?=
 =?utf-8?B?ZlRXUkdKQ0YxajlETnFRM2xBN1ZDb0lVN1FrckI0eUo4S3hFdHhhQTVIR2JN?=
 =?utf-8?B?SEtyOGtPWEgvUEVXS1lCeEpwK0daeUxmenU2MFpQN1BEMkd5LzJ6cFZXUTRJ?=
 =?utf-8?B?STJOak10ZGNyM2dpZlMrclFMSkVRaUJHbnFLTE5NdnNiTVpPSDBZUjlnUG1M?=
 =?utf-8?B?Mk03WElMd29mYzVZR2JXMUZGa1hyQm43QnlQY1hmVUkwbVBTNXM1OTFWcldS?=
 =?utf-8?B?TE9HQlhYRW9ROEtMck9FZVFrQ3NOZDNsWUYxLzJBN0Rlelpvc0FaOEJ1bDBT?=
 =?utf-8?B?MlI1QVk4WjN1d3JXaWd0VmNGa3BVa01SWFk1VzFOdkZyYmMvYmgyQjVuVmNW?=
 =?utf-8?B?Tm8yczVHVHNCZkNYaWY2aFBMek5NNXZUbERNZWQ5b2ZvQWdHWGZTM05ZQlVj?=
 =?utf-8?B?VHA1MlpXNWdITmxBdHJHSFk5SkFQNUZwdkdvWTFNeUtGa2pIWDZ0UUYvalNl?=
 =?utf-8?B?QUNqU0xoVTdrV29XS1ZidTQ0QnVSOVhGbm5ERnRMTGRZaUFuVVhjVHZ1WUIr?=
 =?utf-8?B?eHZJSlN5K2d2dmM3cHhOWG51NGRvZjRyUXBmZFdpNlVtMjRGOXozOGxKcmtE?=
 =?utf-8?B?eGYzZ0h4UDhydDc0eEc3WFlFcFpVMys0UWZ4eG1PeW56cUlpRFpSSkhMbWps?=
 =?utf-8?B?aXExamFYd01rNTJQazJaVEtySUdsSUgyR2lZVTdyb0NnYXc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018)(921020)(13003099007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YW5YTGY3eWQ2WUM0MWRKVFZjZ28xTGtNNUE3THY3Y1gwaVV1R1lLK21UT1Vo?=
 =?utf-8?B?cGt1RHZIL1M1VkFFeTNHbkNNTVJnNnFBdEg4QlU3T0tiUG9kTGNMV2JvWFY2?=
 =?utf-8?B?QzVqU0JOcUdqT2xRVWtSMW1Waktzbm9mNTZZQjJ3NzJNNW5WUjVhMXl4R3I4?=
 =?utf-8?B?ZlFUQ1dkZTYzY3RFTHRMWXEvZW1vMzMzQjhsUU9ZZHA3eU5GN0FTdVpIZVlO?=
 =?utf-8?B?QjdrNkkxcm12Q0E0c3NGZ0ZQbmVkbFd6UVNNRXVOQkdRVWxudVAzeUNiaXB1?=
 =?utf-8?B?OE0yNW9FeUZicElIZ0trbmp2VEp6cDBGU0YxWm5ZMFBkTC9HdGFOUVdtUTQw?=
 =?utf-8?B?SEJuRk8rdkI4bklkN0pBS2hkSjkzRFNaNExrSDFndGFFbDZRdDlIL1ZyNEww?=
 =?utf-8?B?ZC9sM2hqaThyOENQMFlBRTJEbnU3MmQ2dzE4THJ3c1hYRlo5Uy85aHZFNUIw?=
 =?utf-8?B?QkZoenROTWhnSG84dzcweHQ3dHR5Q0xoSlRGSXdlTURXY2tzWWpKS25EMnpn?=
 =?utf-8?B?Wnhlekp5Z0xyZ1REVFpBU1pFSkxyTDdydFJKa1JIK2JlYjh4eVdqMVV3cWtN?=
 =?utf-8?B?eWV1N2lUajdxNmpGaDlTSlFnMUsvOGUycmh1R2NNdUQvS0U1cmxEcmovZGpM?=
 =?utf-8?B?eUZDZnFBNVZ4UVZtWU9tZHBMaXMreUl6UmpiQUd1UTVSMkNUYy83TWtEMm1z?=
 =?utf-8?B?bEErSjh6d1JkTjRwRTlQL2gyMDRyZzdFZWlVWnZLaWg0MDJVdXBjM0puTUdI?=
 =?utf-8?B?WGRQTDNaT3RBdHd0ZDM2WmJhYmxDenN2N3ZEV09zbzhwWXFIcGR1eFlvK2NK?=
 =?utf-8?B?dXZnbldFUWZnM2RiSlpsemg0T2xJbFNWUGcvS3hidFYzYjVyaUNja05oOTVU?=
 =?utf-8?B?M3JnaEY4Q3g0VmdMTlM5d1REMVQ3alVYUlVwY1ZQb0I4WjJOUklWZ0xucG5B?=
 =?utf-8?B?VjNDUFI2NHAxYVFCTXdEN0ZSam9NcE1MK21CSzMxRkFsaHJrY0R5NXRrWEs3?=
 =?utf-8?B?amovM2tpUDBKeGlQWHRrY0wzZ3BRODA1V3Q0cy9GSDdESXNybjFVUzhpc1A4?=
 =?utf-8?B?VDVuNUpKMVRVcDdEL2VNUWhiRElqMWtRNG9ZVStCb2E3RXNTb2RGbkpNaGI5?=
 =?utf-8?B?b2VJTmUyNDRQdGdtMG1HWTVXWkNIajFvMFZydEJqd3hPcTBvdk5YZGtlQ1c5?=
 =?utf-8?B?aC9ldG1zbk5hemlPYW5rbVMxZjk5NWZMcDF0WjU2bGFJQXVGYXY2bTI4SjFY?=
 =?utf-8?B?bFpocUdwUi8zZk1uK2hndEZGMEtBV01ZZUluTEpoUG5oNThRZUlwcFVzZVU3?=
 =?utf-8?B?YmxNbGFtUXJsZGtLandFRVVHLzRyYm1OMEFrRHhkRkJXV29TOFFVVFhmUjQx?=
 =?utf-8?B?Qkg3dVBMSjQwTXY0VWJoZzdPbDNRdit0b3FFV2JDakV4K29rNENsWVh0QVFt?=
 =?utf-8?B?b0hmR0IxQ1RNeURPQ0ZRYk9RQU9tY05xQ1VjeUZma1c1b0lXTWNRSmczRHpC?=
 =?utf-8?B?TDNnU2Z5ekVQWElzVGdNeTBSR0tlS2JraDdGOXVhQk13b1FqZUdkcEtzZStF?=
 =?utf-8?B?TXZPVWczbHBJeWMrVkk0eDRHOWNuYUpMR3pYRGFUMUpzdStFUENtRmtzVEFL?=
 =?utf-8?B?MEZ6aHlGVGQ4VGdRZGQ2Ly9mdlA4NjYyYjduSkFDdk01VXRrRmJOK05pL3Vy?=
 =?utf-8?B?U05CZzA2MnNyK2RNMmZCdlh2TFkwS3ZndlhVMHJnUTJmVHYzVFdzZ2I3UVdo?=
 =?utf-8?B?RUNBemRYQXc0dGtEMnhzc1orR1VDL1pkelBTTW16SEcyWGovekhCWVA0eHpF?=
 =?utf-8?B?am5xU1NPbTd5ZldrU0lwU3BYZm1hYnpiRUJZNGFQS2ExNElzOC81eXo2V2Qv?=
 =?utf-8?B?eFYrdDZZZWc5NXhHK003NGtMa2ZQWFlMRjl2a01XNXZ0c2lmQWxYeEp0Slhi?=
 =?utf-8?B?QkNPWHpJMmE2aGJVcXl1OVRTUjlxL3B0NkRpcWNieU1TZE9rVGVjNHF5bUZB?=
 =?utf-8?B?SEdJcnVsSGE3K1IrMlJlMU82VUVuWUtHR1RqcDFxRkxYeWN6eGNxb29IejJI?=
 =?utf-8?B?UUNwbWFuL2hkMGpDTXhDOFczUmdhdndiY1Q3Zi9sd1pYUlZkWW5ocVNXbW82?=
 =?utf-8?B?VVpPWkY3WHNsNlU1ODFFd1pCb0k2S01BVmRGTFUxaEhhdzlGWU15OURBc2xL?=
 =?utf-8?Q?m3CIaTOmepPYW7zWlmpDVh8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6ADA41A52F7E27478DD44F3103CFA976@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: c28ea37c-583f-42ff-e2f8-08dd5a384243
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2025 09:46:23.2700
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n9KbqeSQe+qgL3hKxByzn6HLE5XfM2N0CYZTsnYLyiKEanCV55816kD+cx1gla7t5lh119vGicLpErVu3RBm27rdVYRv6ALGEunTFQDfj0c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR10MB8079

T24gRnJpLCAyMDI1LTAyLTIxIGF0IDIzOjEyICswMTAwLCBGcmVkZXJpYyBXZWlzYmVja2VyIHdy
b3RlOg0KPiBMZSBGcmksIEZlYiAyMSwgMjAyNSBhdCAxMjo1OToyNlBNIC0wNTAwLCBKb2UgRGFt
YXRvIGEgw6ljcml0IDoNCj4gPiBPbiBGcmksIEZlYiAyMSwgMjAyNSBhdCAwNjozMDowOVBNICsw
MTAwLCBGcmVkZXJpYyBXZWlzYmVja2VyDQo+ID4gd3JvdGU6DQo+ID4gPiBuYXBpX3NjaGVkdWxl
KCkgaXMgZXhwZWN0ZWQgdG8gYmUgY2FsbGVkIGVpdGhlcjoNCj4gPiA+IA0KPiA+ID4gKiBGcm9t
IGFuIGludGVycnVwdCwgd2hlcmUgcmFpc2VkIHNvZnRpcnFzIGFyZSBoYW5kbGVkIG9uIElSUQ0K
PiA+ID4gZXhpdA0KPiA+ID4gDQo+ID4gPiAqIEZyb20gYSBzb2Z0aXJxIGRpc2FibGVkIHNlY3Rp
b24sIHdoZXJlIHJhaXNlZCBzb2Z0aXJxcyBhcmUNCj4gPiA+IGhhbmRsZWQgb24NCj4gPiA+IMKg
IHRoZSBuZXh0IGNhbGwgdG8gbG9jYWxfYmhfZW5hYmxlKCkuDQo+ID4gPiANCj4gPiA+ICogRnJv
bSBhIHNvZnRpcnEgaGFuZGxlciwgd2hlcmUgcmFpc2VkIHNvZnRpcnFzIGFyZSBoYW5kbGVkIG9u
DQo+ID4gPiB0aGUgbmV4dA0KPiA+ID4gwqAgcm91bmQgaW4gZG9fc29mdGlycSgpLCBvciBmdXJ0
aGVyIGRlZmVycmVkIHRvIGEgZGVkaWNhdGVkDQo+ID4gPiBrdGhyZWFkLg0KPiA+ID4gDQo+ID4g
PiBPdGhlciBiYXJlIHRhc2tzIGNvbnRleHQgbWF5IGVuZCB1cCBpZ25vcmluZyB0aGUgcmFpc2Vk
IE5FVF9SWA0KPiA+ID4gdmVjdG9yDQo+ID4gPiB1bnRpbCB0aGUgbmV4dCByYW5kb20gc29mdGly
cSBoYW5kbGluZyBvcHBvcnR1bml0eSwgd2hpY2ggbWF5IG5vdA0KPiA+ID4gaGFwcGVuIGJlZm9y
ZSBhIHdoaWxlIGlmIHRoZSBDUFUgZ29lcyBpZGxlIGFmdGVyd2FyZHMgd2l0aCB0aGUNCj4gPiA+
IHRpY2sNCj4gPiA+IHN0b3BwZWQuDQo+ID4gPiANCj4gPiA+IFN1Y2ggIm1pc3VzZXMiIGhhdmUg
YmVlbiBkZXRlY3RlZCBvbiBzZXZlcmFsIHBsYWNlcyB0aGFua3MgdG8NCj4gPiA+IG1lc3NhZ2Vz
DQo+ID4gPiBvZiB0aGUga2luZDoNCj4gPiA+IA0KPiA+ID4gCSJOT0haIHRpY2stc3RvcCBlcnJv
cjogbG9jYWwgc29mdGlycSB3b3JrIGlzIHBlbmRpbmcsDQo+ID4gPiBoYW5kbGVyICMwOCEhISIN
Cj4gPiANCj4gPiBNaWdodCBiZSBoZWxwZnVsIHRvIGluY2x1ZGUgdGhlIHN0YWNrIHRyYWNlIG9m
IHRoZSBvZmZlbmRlciB5b3UgZGlkDQo+ID4gZmluZCB3aGljaCBsZWQgdG8gdGhpcyBjaGFuZ2U/
DQo+IA0KPiBUaGVyZSBhcmUgc2V2ZXJhbCBvZiB0aGVtLiBIZXJlIGlzIG9uZSBleGFtcGxlOg0K
PiANCj4gCV9fcmFpc2Vfc29mdGlycV9pcnFvZmYNCj4gCV9fbmFwaV9zY2hlZHVsZQ0KPiAJcnRs
ODE1Ml9ydW50aW1lX3Jlc3VtZS5pc3JhLjANCj4gCXJ0bDgxNTJfcmVzdW1lDQo+IAl1c2JfcmVz
dW1lX2ludGVyZmFjZS5pc3JhLjANCj4gCXVzYl9yZXN1bWVfYm90aA0KPiAJX19ycG1fY2FsbGJh
Y2sNCj4gCXJwbV9jYWxsYmFjaw0KPiAJcnBtX3Jlc3VtZQ0KPiAJX19wbV9ydW50aW1lX3Jlc3Vt
ZQ0KPiAJdXNiX2F1dG9yZXN1bWVfZGV2aWNlDQo+IAl1c2JfcmVtb3RlX3dha2V1cA0KPiAJaHVi
X2V2ZW50DQo+IAlwcm9jZXNzX29uZV93b3JrDQo+IAl3b3JrZXJfdGhyZWFkDQo+IAlrdGhyZWFk
DQo+IAlyZXRfZnJvbV9mb3JrDQo+IAlyZXRfZnJvbV9mb3JrX2FzbQ0KPiANCj4gVGhlcmUgaXMg
YWxzbyBkcml2ZXJzL25ldC91c2IvcjgxNTIuYzo6cnRsX3dvcmtfZnVuY190DQo+IA0KPiBBbmQg
YWxzbyBuZXRkZXZzaW06DQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL25ldGRldi8yMDI1MDIx
OS1uZXRkZXZzaW0tdjMtMS04MTFlMmI4YWJjNGNAZGViaWFuLm9yZy8NCj4gDQo+IEFuZCBwcm9i
YWJseSBvdGhlcnMuLi4NCg0KSGksIHRoYW5rcyBmb3IgYnJpbmdpbmcgdGhpcyB1cC4gVGhpcyB0
b3BpYyBpcyBjdXJyZW50bHkgYWxzbyBkaXNjdXNzZWQNCm9uIHRoZSBsaW51eC1ydC11c2VycyBs
aXN0LiArQ0MgU2ViYXN0aWFuLg0KDQpodHRwczovL3d3dy5zcGluaWNzLm5ldC9saXN0cy9saW51
eC1ydC11c2Vycy9tc2cyODMxNy5odG1sDQoNCg0KPiANCj4gSSBwcm9wb3NlZCBhIHJ1bnRpbWUg
ZGV0ZWN0aW9uIGhlcmU6DQo+IA0KPiDCoA0KPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21s
LzIwMjUwMjEyMTc0MzI5LjUzNzkzLTItZnJlZGVyaWNAa2VybmVsLm9yZy8NCg0KSXQgd291bGQg
YmUgcHJldHR5IGhlbHBmdWwgdG8gaGF2ZSBhIHRyYWNlcG9pbnQgdGhlcmUgdG8gZWFzaWx5IGdl
dA0KY2FsbHN0YWNrcyBpbiBjYXNlIHRoZSB3YXJuaW5nIGhhcHBlbnMuIEN1cnJlbnRseSB3ZSBh
cmUgdHJhY2luZyB0aGlzDQpieSBhZGRpbmcgYSBmaWx0ZXIgb24gdGhlIHByaW50ayBtZXNzYWdl
Lg0KDQo+IA0KPiBCdXQgSSBwbGFuIHRvIGFjdHVhbGx5IGludHJvZHVjZSBhIG1vcmUgZ2VuZXJp
YyBkZXRlY3Rpb24gaW4NCj4gX19yYWlzZV9zb2Z0aXJxX2lycXNvZmYoKSBpdHNlbGYgaW5zdGVh
ZC4NCj4gwqANCj4gPiBCYXNlZCBvbiB0aGUgc2NvcGUgb2YgdGhlIHByb2JsZW0gaXQgbWlnaHQg
YmUgYmV0dGVyIHRvIGZpeCB0aGUNCj4gPiBrbm93biBvZmZlbmRlcnMgYW5kIGFkZCBhIFdBUk5f
T05fT05DRSBvciBzb21ldGhpbmcgaW5zdGVhZCBvZiB0aGUNCj4gPiBwcm9wb3NlZCBjaGFuZ2U/
IE5vdCBzdXJlLCBidXQgaGF2aW5nIG1vcmUgaW5mb3JtYXRpb24gbWlnaHQgaGVscA0KPiA+IG1h
a2UgdGhhdCBkZXRlcm1pbmF0aW9uLg0KPiANCj4gV2VsbCwgYmFzZWQgb24gdGhlIGZpeCBwcm9w
b3NhbCBJIHNlZSBoZXJlOg0KPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9uZXRkZXYvMjAyNTAy
MTktbmV0ZGV2c2ltLXYzLTEtODExZTJiOGFiYzRjQGRlYmlhbi5vcmcvDQo+IA0KPiBJIHRoaW5r
IHRoYXQgZml4aW5nIHRoaXMgb24gdGhlIGNhbGxlciBsZXZlbCBjYW4gYmUgdmVyeSBlcnJvciBw
cm9uZQ0KPiBhbmQgaW52b2x2ZSBuYXN0eSB3b3JrYXJvdW5kcy4NCj4gDQo+IE9oIHlvdSBqdXN0
IG1hZGUgbWUgbG9vayBhdCB0aGUgcGFzdDoNCj4gDQo+IMKgIDAxOWVkZDAxZDE3NCAoImF0aDEw
azogc2RpbzogQWRkIG1pc3NpbmcgQkggbG9ja2luZyBhcm91bmQNCj4gbmFwaV9zY2hkdWxlKCki
KQ0KPiDCoCAzMzAwNjg1ODkzODkgKCJpZHBmOiBkaXNhYmxlIGxvY2FsIEJIIHdoZW4gc2NoZWR1
bGluZyBuYXBpIGZvcg0KPiBtYXJrZXIgcGFja2V0cyIpDQo+IMKgIGUzZDVkNzBjYjQ4MyAoIm5l
dDogbGFuNzh4eDogZml4ICJzb2Z0aXJxIHdvcmsgaXMgcGVuZGluZyIgZXJyb3IiKQ0KPiDCoCBl
NTVjMjdlZDljY2YgKCJtdDc2OiBtdDc2MTU6IGFkZCBtaXNzaW5nIGJoLWRpc2FibGUgYXJvdW5k
IHJ4IG5hcGkNCj4gc2NoZWR1bGUiKQ0KPiDCoCBjMDE4MmFhOTg1NzAgKCJtdDc2OiBtdDc5MTU6
IGFkZCBtaXNzaW5nIGJoLWRpc2FibGUgYXJvdW5kIHR4IG5hcGkNCj4gZW5hYmxlL3NjaGVkdWxl
IikNCj4gwqAgOTcwYmUxZGZmMjZkICgibXQ3NjogZGlzYWJsZSBCSCBhcm91bmQgbmFwaV9zY2hl
ZHVsZSgpIGNhbGxzIikNCj4gwqAgMDE5ZWRkMDFkMTc0ICgiYXRoMTBrOiBzZGlvOiBBZGQgbWlz
c2luZyBCSCBsb2NraW5nIGFyb3VuZA0KPiBuYXBpX3NjaGR1bGUoKSIpDQo+IMKgIDMwYmZlYzRm
ZWM1OSAoImNhbjogcngtb2ZmbG9hZDoNCj4gY2FuX3J4X29mZmxvYWRfdGhyZWFkZWRfaXJxX2Zp
bmlzaCgpOiBhZGQgbmV3wqAgZnVuY3Rpb24gdG8gYmUgY2FsbGVkDQo+IGZyb20gdGhyZWFkZWQg
aW50ZXJydXB0IikNCj4gwqAgZTYzMDUyYTVkZDNjICgibWx4NWU6IGFkZCBhZGQgbWlzc2luZyBC
SCBsb2NraW5nIGFyb3VuZA0KPiBuYXBpX3NjaGR1bGUoKSIpDQo+IMKgIDgzYTBjNmU1ODkwMSAo
Imk0MGU6IEludm9rZSBzb2Z0aXJxcyBhZnRlciBuYXBpX3Jlc2NoZWR1bGUiKQ0KPiDCoCBiZDRj
ZTk0MWM4ZDUgKCJtbHg0OiBJbnZva2Ugc29mdGlycXMgYWZ0ZXIgbmFwaV9yZXNjaGVkdWxlIikN
Cj4gwqAgOGNmNjk5ZWM4NDlmICgibWx4NDogZG8gbm90IGNhbGwgbmFwaV9zY2hlZHVsZSgpIHdp
dGhvdXQgY2FyZSIpDQo+IMKgIGVjMTNlZTgwMTQ1YyAoInZpcnRpb19uZXQ6IGludm9rZSBzb2Z0
aXJxcyBhZnRlciBfX25hcGlfc2NoZWR1bGUiKQ0KPiANCj4gSSB0aGluayB0aGlzIGp1c3Qgc2hv
d3MgaG93IHN1Y2Nlc3NmdWwgaXQgaGFzIGJlZW4gdG8gbGVhdmUgdGhlDQo+IHJlc3BvbnNpYmls
aXR5IHRvIHRoZQ0KPiBjYWxsZXIgc28gZmFyLg0KPiANCj4gQW5kIGFsc28gbm90ZSB0aGF0IHRo
ZXNlIGlzc3VlcyBhcmUgcmVwb3J0ZWQgZm9yIHllYXJzIHNvbWV0aW1lcw0KPiBmaXJzdGhhbmQg
dG8gdXMNCj4gaW4gdGhlIHRpbWVyIHN1YnN5c3RlbSBiZWNhdXNlIHRoaXMgaXMgdGhlIHBsYWNl
IHdoZXJlIHdlIGRldGVjdA0KPiBlbnRlcmluZyBpbiBpZGxlDQo+IHdpdGggc29mdGlycXMgcGVu
ZGluZy4NCj4gDQo+ID4gDQo+ID4gPiBUaGVyZWZvcmUgZml4IHRoaXMgZnJvbSBuYXBpX3NjaGVk
dWxlKCkgaXRzZWxmIHdpdGggd2FraW5nIHVwDQo+ID4gPiBrc29mdGlycWQNCj4gPiA+IHdoZW4g
c29mdGlycXMgYXJlIHJhaXNlZCBmcm9tIHRhc2sgY29udGV4dHMuDQo+ID4gPiANCj4gPiA+IFJl
cG9ydGVkLWJ5OiBQYXVsIE1lbnplbCA8cG1lbnplbEBtb2xnZW4ubXBnLmRlPg0KPiA+ID4gQ2xv
c2VzOiAzNTRhMjY5MC05YmJmLTRjY2ItODc2OS1mYTk0NzA3YTkzNDBAbW9sZ2VuLm1wZy5kZQ0K
PiA+IA0KPiA+IEFGQUlVLCBDbG9zZXMgdGFncyBzaG91bGQgcG9pbnQgdG8gVVJMcyBub3QgbWVz
c2FnZSBJRHMuDQo+IA0KPiBHb29kIHBvaW50IQ0KPiANCj4gPiANCj4gPiBJZiB0aGlzIGlzIGEg
Zml4LCB0aGUgc3ViamVjdCBsaW5lIHNob3VsZCBiZToNCj4gPiDCoMKgIFtQQVRDSCBuZXRdDQo+
IA0KPiBPay4NCj4gDQo+ID4gDQo+ID4gQW5kIHRoZXJlIHNob3VsZCBiZSBhIEZpeGVzIHRhZyBy
ZWZlcmVuY2luZyB0aGUgU0hBIHdoaWNoIGNhdXNlZA0KPiA+IHRoZQ0KPiA+IGlzc3VlIGFuZCB0
aGUgcGF0Y2ggc2hvdWxkIENDIHN0YWJsZS4NCj4gDQo+IEF0IGxlYXN0IHNpbmNlIGJlYTMzNDhl
ZWYyNyAoIltORVRdOiBNYWtlIE5BUEkgcG9sbGluZyBpbmRlcGVuZGVudCBvZg0KPiBzdHJ1Y3QN
Cj4gbmV0X2RldmljZSBvYmplY3RzLiIpLiBJdCdzIGhhcmQgZm9yIG1lIHRvIGJlIHN1cmUgaXQn
cyBub3Qgb2xkZXIuDQoNCldlIHNhdyB0aGlzIG1lc3NhZ2UgYXQgbGVhc3Qgb24gdGhlIGZvbGxv
d2luZyBrZXJuZWwgdmVyc2lvbnMgYXMgd2VsbDoNCg0KLSB2Ni4xLjkwLXJ0IChEZWJpYW4gLXJ0
IGtlcm5lbCkNCi0gdjYuMS4xMjAtcnQgKERlYmlhbiAtcnQga2VybmVsKQ0KLSB2Ni4xLjExOS1y
dDQ1IChTbyB5ZXMsIHRoaXMgaXMgYWxzbyBhZmZlY3RlZCkNCi0gdjYuMS4xMjAtcnQ0Nw0KDQpG
ZWxpeA0KDQo+IA0KPiANCj4gPiANCj4gPiBTZWU6DQo+ID4gDQo+ID4gaHR0cHM6Ly93d3cua2Vy
bmVsLm9yZy9kb2MvaHRtbC92Ni4xMy9wcm9jZXNzL21haW50YWluZXItbmV0ZGV2Lmh0bWwjbmV0
ZGV2LWZhcQ0KPiANCj4gVGhhbmtzLg0KDQotLSANClNpZW1lbnMgQUcNCkxpbnV4IEV4cGVydCBD
ZW50ZXINCkZyaWVkcmljaC1MdWR3aWctQmF1ZXItU3RyLiAzDQo4NTc0OCBHYXJjaGluZywgR2Vy
bWFueQ0KDQoNCg==


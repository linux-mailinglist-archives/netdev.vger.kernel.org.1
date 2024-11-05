Return-Path: <netdev+bounces-141877-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90CA39BC96F
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 10:38:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2054D1F20585
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 09:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F83A1D041D;
	Tue,  5 Nov 2024 09:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="J5WwjnbI"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013004.outbound.protection.outlook.com [52.101.67.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F381CEAA0;
	Tue,  5 Nov 2024 09:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730799528; cv=fail; b=RUcxeslT+2hjTU47W6Bxlo6q3FfAOE3VOm8Hls18q7k9XHDxBV73exO4WT2SX+zBBqam5y4LOBynivqnlF3t3VhhEHcVwj6ZlIRPZcflPHW1rHO5IDnM/LqNIy7BY+HTQqmdgHsdhQ6E5R5yKaa7gmD1R90i7xXrx5PedtB1weE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730799528; c=relaxed/simple;
	bh=jvtPP4ATcPToTNrC0zjuRG/L9dGgLAdyWbOAchNmaDI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=k6sPvELYFdK1Pi/yu8hH6rCy/Q5199qnMUy2LRJU4mwNAtamLFGz3BwRS+/x70F3ttIvXc6iT2uxtHfoW0E0NDv3PYsIob3OwqQD57NA6OccxHTW3SzOkRlJAxulUtL2ENy8YRk8/GN8VQ8tujccfltHufFyDMxns0DQJcxkeco=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=J5WwjnbI; arc=fail smtp.client-ip=52.101.67.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A2gQUiHpwkqk9ROz/lhcRsS4MSWureLvaxuU5KLx9YmkyrXVJU2c7xnk7gFMjWfGatCjAzHnqKz/XByJlX98GW7GKsQeNRcwLM3Z43qnRS7ZINLeMg1VaN9b0IexR0BjM+0kjEXAKNyOCoqj/kqQpIJ4fNYdk/sHYHcFY2tDzfWfN+neAa1n10CKZuvE9GsqpOvDIOSF1oFB1yrLjkEhzQWpRMKlwpJH4+Dhqpys0baFCwjvGVsBpQdk1N5Qo6UMoWf4ZKobiOvWiKBXYQFMsE5IIqfyYg2IYrUnLqFBI6C0hefIn1Fa3eUL/mNM0T/pom05aqiLrkTuUU2Ln/gaxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jvtPP4ATcPToTNrC0zjuRG/L9dGgLAdyWbOAchNmaDI=;
 b=HVTKxr7X+5nAkUTFxPIYDCDi2w7nUIlle7shTfWdWW87/vVDFGcQH1d2M4Tc2SodT28/oahub1A6BQ3o0F3H8X2o7r7feMk/Gl7imrugWiJHJ3lbm1/NJ+eZOTx9qfhYlmqI9VAiVUIykNSQOYXWjYHLV3jjaTwVFL7naVJoJ6UL90dIRg96+C4zWgil3YTAWDo6rBi8xQB39gjSk4L7OFsgKbIYvqnveXjF/j77wuuBYCVFc+f88tGbGI6b/dW6rc7VH0mAKw8FuxgaGEjL48gxZi334j0yyb9Mhp01jaqWKubUkuKnXwElMWXTpalih0HTZ+G7eLD279MyUd24Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jvtPP4ATcPToTNrC0zjuRG/L9dGgLAdyWbOAchNmaDI=;
 b=J5WwjnbIftNG9dsZtz/7ygFQrVINs7+E3iiO+xRO2b5q9JpMnM498fa57n5p4Owhc0AoYx9j40TYVqzPo9uArWwE0mfPXQJIP4QfS4IY6ddWPnv1vHCHZ/pAD9EnqxIc7RanQ5dNju142D09rQCnmCmmztV6ameAkRqGvOHlO70LyPT9NwYErbr6FGoRtr1NZFoD8mU2j1pae510XvwcWsFCEF++4HkhaAYvvY96LOcbDchShsd/CzHMQNp3IT9EAg309fnTTunBC0zIBbem9/T9/6VlICtutwCBKn2LzPHbFh9CyRe453QHk68hOSql5XMkm7r1Lwd6lcNf144zIQ==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by GVXPR04MB10408.eurprd04.prod.outlook.com (2603:10a6:150:1db::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Tue, 5 Nov
 2024 09:38:36 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8114.031; Tue, 5 Nov 2024
 09:38:36 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Colin Ian King <colin.i.king@gmail.com>
CC: "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Claudiu Manoil
	<claudiu.manoil@nxp.com>, Vladimir Oltean <vladimir.oltean@nxp.com>, Clark
 Wang <xiaoning.wang@nxp.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S .
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
Subject: RE: [PATCH][next] net: enetc: Fix spelling mistake "referencce" ->
 "reference"
Thread-Topic: [PATCH][next] net: enetc: Fix spelling mistake "referencce" ->
 "reference"
Thread-Index: AQHbL2V+FFTJVzKP+kKig+tBCpz81rKobejA
Date: Tue, 5 Nov 2024 09:38:36 +0000
Message-ID:
 <PAXPR04MB8510A37D42D9C64CB1EF637D88522@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20241105093125.1087202-1-colin.i.king@gmail.com>
In-Reply-To: <20241105093125.1087202-1-colin.i.king@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|GVXPR04MB10408:EE_
x-ms-office365-filtering-correlation-id: 451a5623-e51f-48a5-375c-08dcfd7d9f41
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?S0RsU1RHM2RsM2ZVeURTdytWYVMxc204NFl4cTNIMGZ0VjRlWE9WWkhmekVY?=
 =?utf-8?B?MDFOV0NkcnJyU0RiSUtHVjlIU1N4dG1uZldXeVVEV1NVMlVXb04vcWVUU2dC?=
 =?utf-8?B?Mk5pditTMGplbVVsbEs0QzNsQ1hRcXdPNWdiV0RtUTAwRWNkY2dmd25HY2Vv?=
 =?utf-8?B?N1loZUdiSVVMYk04WW9renVqbTFXK1hYUG9yajBhODZyRWtXem52M2hVYkNZ?=
 =?utf-8?B?QUlCcG9GbE92Q1lCbkhEK1NxWEFoNkp5dUcyMWErOEZCeitUbjUrVWlHU3Vw?=
 =?utf-8?B?QzdKa211RjVoZTBiTlovQ09KK0FRRzNYeHAxcCt2TG9pcUY0ejM0LzJiS1F3?=
 =?utf-8?B?L0JQTjdmNzRha0JWNWJjMmNnWjZTUXY0bWsyUm5tR0poNTV6SjZUVEdXNEhi?=
 =?utf-8?B?cGZtdkVkYkhKSkF1aEZuQ1owMEJhOGxSMEdMNWVhVy9zQ2ROVWVQem1ERkZW?=
 =?utf-8?B?ZHJudFdibjUxWFVWTldCL1lnNjgzNXFRREdlSGpkVGZvbjF5bUw5VTJERUVN?=
 =?utf-8?B?Smx2S2g1RllEOHlnY2QwZm5kajhRbm9QUFdMUDc2c3I0K3ZVaThjTjg1VHNl?=
 =?utf-8?B?VHFpY1AraWY3T0pUQVA0VWNNYnJncUNUcXQvcVdDZEhxUEFUdWlzdGlsUG9v?=
 =?utf-8?B?MzB6T3hkdnhHeVB5RThLa3R5OTdlN0UvMHA1bHpxVXM5UWV6bGpYUFFzZDNJ?=
 =?utf-8?B?NkpSaGM4T2dBaG5YVnZLSEttUHFqOUFDMlh2WDJnaHViL203SGxYUGNqSVhF?=
 =?utf-8?B?aWF0QWpBU3dDci9BNkppcS9VYXNsVWU3dS9sUTgwczFzcC9odEU3YzZQcTZS?=
 =?utf-8?B?cmRuMk5jME45TUJTWGQvUENiWUhzc0pPYXVILzBvaGE3TkYraUsyZHFaVmt0?=
 =?utf-8?B?SEwrUUFzdVV1RzFKWGRIMmlNNkFGWmxRbG5kOGRTVjlaU0lPVS9zOXY3a1g2?=
 =?utf-8?B?SjBwVGxXME9GYXl6QXpKMFpoZmtkeC9xbUticEpMUU1KYVBicnR6bjMxZHg2?=
 =?utf-8?B?RVk5ZE9rVW1FMjhvTUpWVHRUZmlFdWpIL2t2R3JyMmJwSUpBcksxcWo3cjV4?=
 =?utf-8?B?dWt2QzNidTJDWXQ1YW9ScXpqK3ZjTE9RNm8raFJyWThMTWxKc2kxM2dkbWFC?=
 =?utf-8?B?VG1WT1IrN05ZanZTK2lYNnRwSVdGazFvSVRYb3ZNeVZVUExiYk52NnJMalRz?=
 =?utf-8?B?b3BYK2ErOGxyUG5qQW42L0JnUGJuNTdlcFhjMEpwZkVWb3VFL0pMM0V5Rk5L?=
 =?utf-8?B?eFNtMkh5MEhCc2ZoWVR2MkM5TnZsSzJyREJqWVp1MlNHVWVlV0l6VUFBNi84?=
 =?utf-8?B?cUdiVGRISUpTL3pVajNMVTNsc1VVbnllaUMxazV2WU9IS0M5d2ZJcUtxeC9o?=
 =?utf-8?B?RDVhTjZsRkdYRjFmUXd1QjlJd0Z2cXA5QWtlbVBTdU54azhPMU5BM3UzOXhh?=
 =?utf-8?B?a0lvdENmTU1zSGhLY2ZBeFRxMGw5cXRid29jWmxRV2dRbjdGN0VnamNITWNS?=
 =?utf-8?B?ZlMwYWV4Vms2b1RTakF6UlRQN2hIR1dkV202U0c3L1ZLVWtxalRQeUtUYWMv?=
 =?utf-8?B?VFViS0t4djdyV0N5bDgySmJBSHlybVFkTjllOTJLVml2QjlNSVVFMDFtNm9I?=
 =?utf-8?B?dFlCV1dKVzJuaGd0dVBzTk9DRjdZd2JlakZjODRWMTNLWFJLOHluNmgraUlB?=
 =?utf-8?B?SHhuOWJ0QkpWZFRZQVhyZExDbVZycHpoV0hLTnN1YllLcGNjUW5PeFZHQ3k4?=
 =?utf-8?B?OGQ4Mzdlckh6dzI3T25UT0IvWHI4OGwwY2pNSzhjTjl1aEVDbWJ6WFVnaHU2?=
 =?utf-8?Q?DQrDFOyc+Bun2/2KF3hJ6ylPFNFTWXy4C7N34=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?U3FTS0xza1gxc1V2UFpVZUl1dmtCNjUwRWp2Nk8xU2dVN1RoYWFrL1dwTTNF?=
 =?utf-8?B?RUFnNDFoZkhqczNyRE93M1poTlJieHUzaFhHN09YOEthc0JJWWxidlY4azIz?=
 =?utf-8?B?WDFhTGdpY0xDdUhweUVpSHNnUEZ4MTJwRzhHcWlFcW9uV0hIemJpZVlCZHh6?=
 =?utf-8?B?MDdXUEZTNEpjV3lkMTZqWG55VEROYkpqY2V6bExmQ2o5Wk5GdXpMTGZ5QzlR?=
 =?utf-8?B?azhXSDUza0lWelhJWm51Wk8yY1FoZ2IrRDBsRWxEcWg5QWZWNTFhZ0VkWHJ6?=
 =?utf-8?B?MWhJMkpXK2ROSzNsVTBQSGQ2ZnhZSUpOZ1h3VXhQMWdRbmVkVjFZZzZWME9J?=
 =?utf-8?B?SURQUVpveGd3dU5jcWl5SGJCbFNHVUlSNmE4ZHVQR1U4enhFNTF4Wml1TUVx?=
 =?utf-8?B?a3RwVnk2eloyaUk4dEVqVVBoeFVuSmpYVWp2Z2VUMjNBNXYwVkNsRFdVUUIy?=
 =?utf-8?B?eXFKR2o5QkpYNE90NWxtM1VUSWYySE9ySGR2cUxOYVB6RDFuNUpXMTl1VHA4?=
 =?utf-8?B?aVRBWWFOdnV0QWJTRGlWSEc0dWdXQ2xWR1A1bllrWXRLQTJPbm8xaUJtL29N?=
 =?utf-8?B?U0dJYm5DQ0FIY3J4YlhGckk3bUkyRTRDUk04dFZ4WUZycWVGdWNZeUphWUpQ?=
 =?utf-8?B?NHl5dm0vOHN1ZktqbEROWkFldWZWWlRHQlJkakQ1ODZLdndSdFJPSEwxWDZk?=
 =?utf-8?B?dGNJRnhmaWp5WnlLSzFIZGxONDYxaXBWb3JWWVNNcDJlSTh2N210WmNQOTg4?=
 =?utf-8?B?U2M2RW9qQUFHbXgwZ0xOeXVmRlF5dTJjNkFudHhOUmxhNWI5R2NCWHpnOEdW?=
 =?utf-8?B?Y3hpVVpYWWNDVWFvL214MWpzSUt6WGZ4aVN1bTJDN0VyZWkzb2JmMEo1UnRB?=
 =?utf-8?B?YU1ydkN0T0tXT0FmcG4vU1VhN0p0K295TFE1YWgvZnYrSU52c2FFOXVGRkNF?=
 =?utf-8?B?VTR0RmZRZC96UGlGczJCbEwwMTlzbWVYcHlTb2YrWitGTU9UeGVvMmJJaHF0?=
 =?utf-8?B?SjdwNWN3enYwZ3poNTdEUS9PVFRJdzlKTTRVbWpnRkhUR2EyelgvdUVhRTRu?=
 =?utf-8?B?R1NVY3NPYUVwLytxNExodG5LWFNrNHJUV3FJb3pLQXhWM1dUa3B4djgyNnR1?=
 =?utf-8?B?OGxTemdmNG14VmphN2YyTVRFYjR1ZEZ6SFdhaFJMby9xTHJnSmJMTzNFZ2Yv?=
 =?utf-8?B?ZXNFZkdvYkF1RmJ0WTB0dmRHMTQ3aFVsaWFiblZNWDF1dlRlK3dEMUZESVVu?=
 =?utf-8?B?TFlnVnJkRy8rdiswNEQ0d1BBakR3dHRYTGJLdy9WNkdCYkkrclpjdWllR0dY?=
 =?utf-8?B?c3RmcnZteFUzbXVPc3pudU10ckoxeWp0cDNkZVFoYnpQUFQ2Z3JhTS80N25z?=
 =?utf-8?B?MjZEZlBmN3NZb2QxcHljR3FJR0tjVjhtaVpiZGJrbW5EUmtSVmJOTFVUS0VL?=
 =?utf-8?B?TmVqdmE3UzVrSVRVaTk1MFJ2UTZ1alpPaUxzRVA3M2RlVGVWWE1hZlE0eDA2?=
 =?utf-8?B?MDBybldUUnZ5dDYrNVFSeFdmcXhUSEM2bkR5Tk5vOEh4Z2J1SmorbDYrZXVu?=
 =?utf-8?B?VFZzN2pZaERIL09WL1FUWWxkMUt1bEZTS01oUjdKZi9udlZHdEZPcTlhdWJF?=
 =?utf-8?B?bWNaR3JZNmJOWlhNclY5bGVvWjFucVo4ek1sNEl4UEJnUW81cGFVZFlhVm5l?=
 =?utf-8?B?U1lmZGl6Sk5XelFhWm1yb2liMy9YekFlVEp3OVlyWEtPZWsvT01qL3hGbTYy?=
 =?utf-8?B?WWR0RHlKdmtCb3NKQnJjQ21hNGNCVTRVR1hDRElnRDVHalZxUG92MFBRVTk2?=
 =?utf-8?B?eTJ6aUwyS0dXR1BBdG1wdnVTUWJzTkZjbmxZSTZOZkxjemkwU0FjZUl2SHpw?=
 =?utf-8?B?UStQRkR4YmtKTDZSVFJ6aHBUTjhyaEpZSWdxMHlibUZHRFZIU1NCUFBPa2lo?=
 =?utf-8?B?NGhsQXNMeWxEQzB4ZnVkanUrdGkvZXRaR2I0bThpbFV5UllZL0JqVTBQRjRm?=
 =?utf-8?B?TTc5Z2lsZkg5MFcxQ3RhOEQ1YlhjUTI3Q1pMNVZZWVBLc0xqWVVKL2JsUCty?=
 =?utf-8?B?RWxhVExWODRFYzlHck8wd05DTlVVcWxRZEdkUndQd21LUXUzWGk4MDdwWnRk?=
 =?utf-8?Q?KD3c=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 451a5623-e51f-48a5-375c-08dcfd7d9f41
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2024 09:38:36.4228
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G3RkbDKjltwiDdg7VsF1qphkdaxRuNMebiM6yxavaBtf5tondmNKxeQdiSHOv4BYU03xRnZ5OBZ2vqpI0PYI9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10408

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBDb2xpbiBJYW4gS2luZyA8Y29s
aW4uaS5raW5nQGdtYWlsLmNvbT4NCj4gU2VudDogMjAyNOW5tDEx5pyINeaXpSAxNzozMQ0KPiBU
bzogQ2xhdWRpdSBNYW5vaWwgPGNsYXVkaXUubWFub2lsQG54cC5jb20+OyBWbGFkaW1pciBPbHRl
YW4NCj4gPHZsYWRpbWlyLm9sdGVhbkBueHAuY29tPjsgV2VpIEZhbmcgPHdlaS5mYW5nQG54cC5j
b20+OyBDbGFyayBXYW5nDQo+IDx4aWFvbmluZy53YW5nQG54cC5jb20+OyBBbmRyZXcgTHVubiA8
YW5kcmV3K25ldGRldkBsdW5uLmNoPjsgRGF2aWQgUyAuDQo+IE1pbGxlciA8ZGF2ZW1AZGF2ZW1s
b2Z0Lm5ldD47IEVyaWMgRHVtYXpldCA8ZWR1bWF6ZXRAZ29vZ2xlLmNvbT47DQo+IEpha3ViIEtp
Y2luc2tpIDxrdWJhQGtlcm5lbC5vcmc+OyBQYW9sbyBBYmVuaSA8cGFiZW5pQHJlZGhhdC5jb20+
Ow0KPiBpbXhAbGlzdHMubGludXguZGV2OyBuZXRkZXZAdmdlci5rZXJuZWwub3JnDQo+IENjOiBr
ZXJuZWwtamFuaXRvcnNAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwu
b3JnDQo+IFN1YmplY3Q6IFtQQVRDSF1bbmV4dF0gbmV0OiBlbmV0YzogRml4IHNwZWxsaW5nIG1p
c3Rha2UgInJlZmVyZW5jY2UiIC0+DQo+ICJyZWZlcmVuY2UiDQo+IA0KPiBUaGVyZSBpcyBhIHNw
ZWxsaW5nIG1pc3Rha2UgaW4gYSBkZXZfZXJyIG1lc3NhZ2UuIEZpeCBpdC4NCj4gDQo+IFNpZ25l
ZC1vZmYtYnk6IENvbGluIElhbiBLaW5nIDxjb2xpbi5pLmtpbmdAZ21haWwuY29tPg0KPiAtLS0N
Cj4gIGRyaXZlcnMvbmV0L2V0aGVybmV0L2ZyZWVzY2FsZS9lbmV0Yy9lbmV0YzRfcGYuYyB8IDIg
Ky0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiAN
Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ZyZWVzY2FsZS9lbmV0Yy9lbmV0
YzRfcGYuYw0KPiBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ZyZWVzY2FsZS9lbmV0Yy9lbmV0YzRf
cGYuYw0KPiBpbmRleCAzMWRiZTg5ZGQzYTkuLmZjNDEwNzhjNGY1ZCAxMDA2NDQNCj4gLS0tIGEv
ZHJpdmVycy9uZXQvZXRoZXJuZXQvZnJlZXNjYWxlL2VuZXRjL2VuZXRjNF9wZi5jDQo+ICsrKyBi
L2RyaXZlcnMvbmV0L2V0aGVybmV0L2ZyZWVzY2FsZS9lbmV0Yy9lbmV0YzRfcGYuYw0KPiBAQCAt
NjMyLDcgKzYzMiw3IEBAIHN0YXRpYyBpbnQgZW5ldGM0X3BmX25ldGRldl9jcmVhdGUoc3RydWN0
IGVuZXRjX3NpICpzaSkNCj4gIAlwcml2ID0gbmV0ZGV2X3ByaXYobmRldik7DQo+ICAJcHJpdi0+
cmVmX2NsayA9IGRldm1fY2xrX2dldF9vcHRpb25hbChkZXYsICJyZWYiKTsNCj4gIAlpZiAoSVNf
RVJSKHByaXYtPnJlZl9jbGspKSB7DQo+IC0JCWRldl9lcnIoZGV2LCAiR2V0IHJlZmVyZW5jY2Ug
Y2xvY2sgZmFpbGVkXG4iKTsNCj4gKwkJZGV2X2VycihkZXYsICJHZXQgcmVmZXJlbmNlIGNsb2Nr
IGZhaWxlZFxuIik7DQo+ICAJCWVyciA9IFBUUl9FUlIocHJpdi0+cmVmX2Nsayk7DQo+ICAJCWdv
dG8gZXJyX2Nsa19nZXQ7DQo+ICAJfQ0KPiAtLQ0KPiAyLjM5LjUNCg0KVGhhbmtzIGZvciBmaXhp
bmcgdGhpcyB0eXBvLg0KDQpSZXZpZXdlZC1ieTogV2VpIEZhbmcgPHdlaS5mYW5nQG54cC5jb20+
DQoNCg==


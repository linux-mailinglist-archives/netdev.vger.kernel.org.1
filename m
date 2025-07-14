Return-Path: <netdev+bounces-206571-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 50E28B0380C
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 09:33:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8CA3A7AD54F
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 07:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39429233715;
	Mon, 14 Jul 2025 07:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="IXyPpOIq"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012047.outbound.protection.outlook.com [52.101.71.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA9B944F;
	Mon, 14 Jul 2025 07:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752478370; cv=fail; b=UdXe7KSLdsaPLfNIWw0EEtOil+F9lM2SgnW3NmoGhVVQBPiB8j8KURAxI4g+QpNhHpIhXkcQjXC61O/JRQxU42HPEeb10oU4vn8oC6ycVMPDQTzL0J/7ftG2YImJyRF0lMhENe928htg3br6yvc43xtTnWSEqBLgF45yAOGFT/g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752478370; c=relaxed/simple;
	bh=E3TItuBbGBGKcu0WB/xFW1NADb/DAIezgTRUM063rnQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ePcIadrjA8P0EiCugZiecKN8f1La9FqSMUota+4f3EQWgFhc0b7BJtb4ugMcHu+03oA3vjT02hz9V1BgFHYw62wScophY129yoX4a7m7RWiLhOOFnrwbflRtrHDFDFN7ZFFKl2ZiApfBq7PoISSYzlrHoUkAG3DAmcupUxBlzSs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=IXyPpOIq; arc=fail smtp.client-ip=52.101.71.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p9ADSiWywbn+6nCPJQMSSb1hR3SQt6K6Lcbxiy4kUkQo/rFewsO9zfss7a10aQ+6V/TgiJVei7yyglZlGDJDiMd8YM4zBulv41FEO+4mryTEzlKRzP0eBP30PuY18/6vuG9iQb1dn1v3P1/jkSx0CwaggxSvbXNtUhZLRjzFf2m+MybSoXXUBD/NN7+gpdbPRMHrzC1neejr05kltsDP6UW79j8wdkFqchbgJpPfCtpeozdiiQ24YlXZ41OKs+pO1LZ2wbvUPX5+C2Ithxvh8XlnHIgyrN5BAc9xu9Z/6rJi+zHFJDmNdplcqgftabkFuhmW2roQm0gGFnMpksdnZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uY7cLQC2yktLZgt8Puf8j7lNP2KdQaa4sBn35lk63So=;
 b=VnvF5Ia6rbO0Yqhdd8Sss+IywjwBRXn1BD4lsV8RXgA71alctJwVlzfMtrwX3Hn7MqPw8KKabgPCUM0IDrjoke8O3DPR9p+AeT60cMkFTvYX8xAyat7Jkbiud34YQTGB784jVrVnk/tGYUCjXXuLWLBhMLvU8R2yC0okr6aqqTGD3vnCE5kaiv6nobqT90JQV+I0RvJMbHG+/Am8tHwFa8rdneOYSNgjstTTcFgMH+g6pGlb+XRPo0niahGJqWMja7Nyj3rB+L2iYlmjUWFHpyZ2WYFTg8lEyfwcmw2qbC5njB6nxVm1mxugFmgLYDJTF6SAoGJ89sqIstWKU/9eTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uY7cLQC2yktLZgt8Puf8j7lNP2KdQaa4sBn35lk63So=;
 b=IXyPpOIqMKsNdEAV50CgFDRH7r7/r+zdUV1o+OIs/ohn8PSfcb052/XQ2jpCjlJyC7ZjcT/hufWyYYOmv6nlObE0skUELAliy4byBO90BsC/1+B5bN5gPq+UeOTO/LelkHkxmbgwJc7pY0bxCpXSyretYzGbTbQhfaqrWHCItsdnoUOP7pDKfJtyVw2kjMIzANdfiAcqrw3QnbuuRLIs0AME+qGkDBUuOFi8bDFzCMeE4FnQrzb9Wz87R5Erq9irp0VI6RAQHfJbWWQNJ88KVJpKsCZ7bD1+RBJWTToR3BN46wmGxs5JU5YSVWex8I7YTfsE9xN//5tukBRqNtob8Q==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AS1PR04MB9335.eurprd04.prod.outlook.com (2603:10a6:20b:4dd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.25; Mon, 14 Jul
 2025 07:32:44 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8922.028; Mon, 14 Jul 2025
 07:32:44 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: "F.S. Peng" <fushi.peng@nxp.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"richardcochran@gmail.com" <richardcochran@gmail.com>, Claudiu Manoil
	<claudiu.manoil@nxp.com>, Vladimir Oltean <vladimir.oltean@nxp.com>, Clark
 Wang <xiaoning.wang@nxp.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>
Subject: RE: [PATCH net-next 01/12] dt-bindings: ptp: add bindings for NETC
 Timer
Thread-Topic: [PATCH net-next 01/12] dt-bindings: ptp: add bindings for NETC
 Timer
Thread-Index: AQHb8jPWk5neHXUn3Eeo02nqDOVTYbQxImMAgAATMMA=
Date: Mon, 14 Jul 2025 07:32:44 +0000
Message-ID:
 <PAXPR04MB8510C8823F5F229BC78EB4B38854A@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20250711065748.250159-1-wei.fang@nxp.com>
 <20250711065748.250159-2-wei.fang@nxp.com>
 <ce7e7889-f76b-461f-8c39-3317bcbdb0b3@kernel.org>
In-Reply-To: <ce7e7889-f76b-461f-8c39-3317bcbdb0b3@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|AS1PR04MB9335:EE_
x-ms-office365-filtering-correlation-id: ac64bcb0-3ba8-4f55-e49e-08ddc2a89fd4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|19092799006|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?XFUKb+l14pa68ti0Y6Qg9YBLILv3EKfjBvL6gX9xb1+JGIO+J7wYxs97k6C4?=
 =?us-ascii?Q?exAxuYZpl9Ckk2Teys8PD5kskOFJNBleah1B5PTl0xWqL6vGtPhakJsMm2RZ?=
 =?us-ascii?Q?pplU1lQp4y7AqWhgx40ORNyun0JGklqIhb47F46y7TYVbU/ulA2Ul/UVBp4J?=
 =?us-ascii?Q?TVhjqbmFfkpUg95DSlEKrs6Ni2BK99OprbUqxh60p7y/iHmmnx76llLp6b0F?=
 =?us-ascii?Q?UyutvWpc54dExH4REt6++hLNoirW6mJH1Fe7ptJZF5pHP0+p/hv1qRM/W27f?=
 =?us-ascii?Q?h0LPRq6jCEw1ZRxi9NYBcX9od5Y1P9dhGKVd+b5rvRbD8IHi0wHr9AedluZu?=
 =?us-ascii?Q?B61JgdeMvemZio8aebmJZgpPpYJlwJOhpllaq7tgznZLc9HNInQqIaHwXcQ3?=
 =?us-ascii?Q?zY6qHBDCjrQ6CVxsAaBqKgnNCeWHWJWpM/MvrgRSCb5QtgRen9QEylUDX2Nc?=
 =?us-ascii?Q?nsiRz71BWj987vHbYzNXSx6M68SiM/vRbQWMvhf89lMsDab+NDK6x8iQRYPn?=
 =?us-ascii?Q?KFZ/7QLjnyj2rirzyjMqmdMqaACY1CKOHXICGh5Rr9ZG/EPwA0Iw27wtrBUu?=
 =?us-ascii?Q?Q2wKeNKdjt+n7x8VUE7XDqYHZ4f09VY+PBh1wLNXZFoyupUHUIlF3KZjgG8d?=
 =?us-ascii?Q?Txj1sOw7S0YVsB/uhDbXLb0AAxtkQthkwbH2KMuNFGL7xw7vPcoxWsUXJs1O?=
 =?us-ascii?Q?3zInhtjerZ90HKbykyT9b0enobox2ccic/O+gUkAe877YGfNOqlygUKcekTt?=
 =?us-ascii?Q?6epn4MI/i8jhfBr9IXb2O4XuiopAVtaH+gM51PkDkFq+LWE0C3HvmfcSSgFU?=
 =?us-ascii?Q?CmTOaN2pzW0hsoAfCeOpSyvVRXvE6EtYP5YTY207fqTJrFnwSFR2PzfFUHX2?=
 =?us-ascii?Q?wypxknCcLqiN8arCM/exYvk2yqWDnDAELKt5tlrtnCZtyFg9FJyR7UAUGjtE?=
 =?us-ascii?Q?t9l+4j9Q1cCHK8U3MUgVTzzuNqDKH90YPaSHfOEHo32Gqva47OkIbuJHCw80?=
 =?us-ascii?Q?xVMBnO3Zo3KNwCCsy1bMlmxxJt7TdwYlIEu5HZ87MBsDfiGkLIVPItCKF1ze?=
 =?us-ascii?Q?30jn268vpHj9LUvDu3KrNKZ1d+mFwHVNw9ypC2p1Cu9wzaRaKof2IbPjyr4S?=
 =?us-ascii?Q?4gSyC5UQtK8k56GATsRuY/6aYEtBZeZpKdteylwA13S/OvV2p1s0fnogeMGb?=
 =?us-ascii?Q?EiwQUOId19W1atw6wKeP69pUQjYP2USEUl527ufHPA0xyS21wXexsj78w0yj?=
 =?us-ascii?Q?/DdITxntIFsvdEA33EBWXWHpSw8iwoS+Yylof3DkGm1xMh9dvsPirgyZCP1w?=
 =?us-ascii?Q?aXMxSFnzJacVqZQZoewKNTeC7aHgDw2sPa4VYeRBgY6P5vplEAaEikxx2nWk?=
 =?us-ascii?Q?xMpYM3B2xkrDEHABUqFM/S1GnQm6IdqXOMd+qMps8V855v4OxJADUA8Xngi6?=
 =?us-ascii?Q?UTcXDftfMK8=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(19092799006)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?SNQHd6Zo6meZEtXItekJZ29PommF6RJCxGvNtXRUOmQYLiXLMdrg9SeF90D/?=
 =?us-ascii?Q?Q1MVm+OWMy8AkXLdGe/GBazhHAcN/+s8ebj9nuvkfHUdp3HjRQ41nTd7lA6b?=
 =?us-ascii?Q?nVZRAWyOCjr6pJQVNhVago8xjEZMtTTwqw/GP9YskuOpHX3WirFJt1DwaD+c?=
 =?us-ascii?Q?fo4/pmN5drsqiW4Vjzhz7SwBpOAyv8XxEp/RYLXKnS86qrTFHaFryVyC6Sp8?=
 =?us-ascii?Q?XGv9lSQmd4nvm0msYG6p50ks+RE2AbcSziBYYwWg+HdMUwAHfVwKrZUGKnx9?=
 =?us-ascii?Q?yOV/LczyxdAnwPeTzEj4N81SKuE/Ph+aqdKi9HK+Klm8rICZQaMDqFf0Wgtu?=
 =?us-ascii?Q?VNpwOtNR9INQ3r1YOjBP1wTt5GZPfCtLYWlQ0rYgacumYsKMIIDuJbgSa85W?=
 =?us-ascii?Q?43bD4ddsD2JrDnKmuKyrT+wTBt8C6ZJovxH1iJ3L8zWGfdb/T9S4kR1Fbx1r?=
 =?us-ascii?Q?h31/bGmSjQov1l4N6cUi0imdnCnGFE2ROPHjrbrtgf5yXaWb8aj/YdpJVEWf?=
 =?us-ascii?Q?TEZm4ckqUY4LPu4WcFKuiG39QI3azPXROe2rPtEHf/vOZW5pSujbBF1rO24S?=
 =?us-ascii?Q?7oRiFBk5OpHIHieyirn+CBE8AqjulZKCqB28woGiF0UI8jgcGRJaeiAayvj+?=
 =?us-ascii?Q?h+zShfxiQOmhIpiNsNRdTXz56i2oLK0uBtIVX9Kp73MKZmPB+dAOdWk6m917?=
 =?us-ascii?Q?Ta6X7X3aEQHf+zIrJDAt7tVaontlKmfGni934fRwtiUQRXzcvXc/DUEljuW5?=
 =?us-ascii?Q?Tda4ILcao6jnMDqDdGvWCk/SoXZklYDzskU4Yf8yLzwJRUJA+pn1RIS4FeiV?=
 =?us-ascii?Q?k54Y7zx0qz014ZOdCXq5f6RXs+FmG7Y9Bd96EERx2lYCB8YhqVuwTuHT00db?=
 =?us-ascii?Q?QqJfFv7zzCoGNio1tnRVh/vvO3DiBv+14uKwDzL6dQwcNneOD8QukD5XQG1e?=
 =?us-ascii?Q?6aA5ghnC9CDXaVgnDQZ+KVp+dETaHt0V8f2j746mBnC9RqrROOq35ecE4e0W?=
 =?us-ascii?Q?BjVfdxxFdHwFmq2mekbF/Gd4ksiI0KjfpEFYVj5g586Hul4/UCkjvVKFpIzJ?=
 =?us-ascii?Q?S2+OtVSGNO8SAM6berIIAR1D61nK8IL2jm3rYy2YgUZm6zckxDZ8Y/yLyEk5?=
 =?us-ascii?Q?auhQBvM5Fla3GrCA+JexfxFMY6h8U8Mlc7HQg14ylIWcbDt60fIIB2DHEBv3?=
 =?us-ascii?Q?ze3ZzWmtnXulTrs1iaHyamZf1XGesYuF/Ej71rYl8bN+kIje5Z5Y9M1mpf3B?=
 =?us-ascii?Q?c3LDpRZAlCmn9MA2EiBLNheyXRo00tNyBc7Mubqw//XLUO53iL27acmxP4bm?=
 =?us-ascii?Q?4Mk0+hxD7wxIaQPIInMbNAGmDudEfLNNORzil4Vi8XniqEk8zZhxKxvDZikd?=
 =?us-ascii?Q?N0dcdohkHXBz7/eq8vO4d41p5g34dKySNyOs/aD2yckWksgowbrz7ugAI/sv?=
 =?us-ascii?Q?6ks3DYCd3wTcvRfdVKDpK684YwtrAljNrOya4Zjfm/U3xEtqFSpBxzNe2v9b?=
 =?us-ascii?Q?CKlZZ6Np1YJ+xPN0aJqbswkxiWy0R9Lw6BGC+OWpUSR91S3Yi14B0Uj9d8ep?=
 =?us-ascii?Q?AMvDO6JjLAvuv0fV89A=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac64bcb0-3ba8-4f55-e49e-08ddc2a89fd4
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2025 07:32:44.8142
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lVuqaN7wPqLtTrPxIrnBue3oKQsAUSlrbWelEYWN+jcOfptPaJtan6oYGbitIcW5d/kCiFUYDfWv/UzFPloksA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9335

> On 11/07/2025 08:57, Wei Fang wrote:
> > Add device tree binding doc for the PTP clock based on NETC Timer.
>=20
>=20
> A nit, subject: drop second/last, redundant "bindings for". The "dt-bindi=
ngs"
> prefix is already stating that these are bindings.

Okay, I will fix it, thanks

> > +
> > +title: NXP NETC Timer PTP clock
>=20
> What is NETC?
>=20

NETC means Ethernet Controller, it is a multi-function PCIe Root Complex
Integrated Endpoint (RCiEP), Timer is one of its PCIe functions.

> > +
> > +description:
> > +  NETC Timer provides current time with nanosecond resolution,
> > +precise
> > +  periodic pulse, pulse on timeout (alarm), and time capture on
> > +external
> > +  pulse support. And it supports time synchronization as required for
> > +  IEEE 1588 and IEEE 802.1AS-2020.
> > +
> > +maintainers:
> > +  - Wei Fang <wei.fang@nxp.com>
> > +  - Clark Wang <xiaoning.wang@nxp.com>
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - pci1131,ee02
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    maxItems: 1
> > +
> > +  clock-names:
> > +    oneOf:
>=20
> Why oneOf? Drop
>=20
> > +      - enum:
> > +          - system
> > +          - ccm_timer
> > +          - ext_1588
>=20
> Why is this flexible?
>=20

The NETC Timer has 3 reference clock sources, we need to select one
of them as the reference clock. Set TMR_CTRL[CK_SEL] by parsing the
clock name to tell the hardware which clock is currently being used.
Otherwise, we need to add another property to select the clock source.

> > +
> > +  nxp,pps-channel:
> > +    $ref: /schemas/types.yaml#/definitions/uint8
> > +    default: 0
> > +    description:
> > +      Specifies to which fixed interval period pulse generator is
> > +      used to generate PPS signal.
> > +    enum: [0, 1, 2]
>=20
> Cell phandle tells that. Drop property.

Sorry, I do not understand what you mean, could you explain it in more
detail?

This property is similar to the "fsl,ptp-channel" which has been added
to fsl,fec.yaml
https://elixir.bootlin.com/linux/v6.16-rc5/source/Documentation/devicetree/=
bindings/net/fsl,fec.yaml#L186

The NETC Timer has three 3 PPS generators, and each corresponding
to an output pin, but these pins are multiplexed with other devices,
so the pin of the PPS output depends on the design of the board. This
property is used to tell the driver which PPS generator/pin the board
uses.



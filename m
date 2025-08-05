Return-Path: <netdev+bounces-211670-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E5A2B1B159
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 11:41:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC04E3ADFE6
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 09:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 906B525F96B;
	Tue,  5 Aug 2025 09:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="H/q9t/eP"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013034.outbound.protection.outlook.com [52.101.72.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846DD199939;
	Tue,  5 Aug 2025 09:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754386900; cv=fail; b=lnyBA0SkPrQHXMhi7ZxlLZkfOse0Bgz5mXsM337hPxl+utSxAitRI4+guasFXxHB4O/E2V6C59tWsa3Reasgec1dzVkzWIoqqc/JM6wa2PmwNCKR+7ozL/Zo6lMEMbdryr/fub1eSsOacTyf2QbXbLZt3JuTmU65I7aKNpygymM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754386900; c=relaxed/simple;
	bh=CzxZkB0+geCtf14so7oKrHim0ksWMrv4d9uq0D0J82w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SUzNSBg5VC4iVKiZGMBlkqiHHfaUehHKZJro+tQltlYbnmFP1KKcf7WzphE5sNIS7OnX0OR21I+sK8y/9Jvq6RNDnbeFSVn9xS4XlQVPG3xThFRLy2f/Bb6YTq4nSWQ6AY48r3p3fw+uElYh0x8qz0uJ4GGejWB68hrVl1BmXHQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=H/q9t/eP; arc=fail smtp.client-ip=52.101.72.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mtx/3xyP3GgbWORt9m5AmzCn0MsOkzCYUcITLwYO7ueANKXeabxnZ541zGM1O/y/y0SGeD1DdiSvkQawk6ZjZmcxzt3UUGPEUnelfyO+l+yAP1/or3c7ITHVRNAPYVxFJBv26kMIUj5uq11ESn8j1CJqazImYd6OXU8HcFDxAuTxFjfm0j0v6Njz3o/Z09OseBZ4jxav5Rt0PzQKtf5ZgYCgyna6LoloVfIRkPA2Lx1JAhFT1t8PsM86JH5K8VtUfbBrz5dmVzNL2NXqdOx6jeACPKpfuJ7bY7G3Zi874gR4fiNqp6jmb1xpxWdNXcY76Podx14epaLclV5S4ID44Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V2Hx/8wxJDdAYxqEmX9yaKxkfBWUsaXYNyjmrvyc9h0=;
 b=jt1QMavxYelabXoq4jmGJwPmgvD2pcN7cQ12cLme7BZIAOSBf1NA4mtUO0FMkMZQPG44THCsGzkfasaETs1ggiOCWsV/7aFDv0PJzlNz5jM6LrFW3yLz39LD2vwnKx1k0Vwlxb7Y7Z9ra+03hgkD23PtgjleSkhlIhHok/ETGX7XwMxOwAJeFbLTxF1cW/KV9QsB8DbmW7X3IASuMmGgDfD0JWWwSKXbnkxTwKo5oxyBD09sOwCcgnpu7P8s96qpyzZjegwHhYw5+DjGl6gP05+fN1tNDKH0XVoAEFl10/ooQJ6qOtCFulDw1HNV8PMBTshuPL6/k3FJDESSVIl1JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V2Hx/8wxJDdAYxqEmX9yaKxkfBWUsaXYNyjmrvyc9h0=;
 b=H/q9t/ePsKfFVbePiWs82k3zxbbTpdUsr/+tO/4ABSxPeFjRxWnNtHTgifp5K4QUY09vQgrEqpitc1yjdMIzWKH0VRZg14r+ocCXQ7Y+lEMTw5TzXR3d+slkmr4eJvkuz8tcnlOSmevCQhG7lX0m6XzT/ULB/0Mt4PuTBhZZQU5Mf7pB4LqMZxNn/0tMDETm3sPPGca3X7KdSCMh8deIF5sP/8Ah47YPjbpF06o/X9JimUP5TOyQ5T/Ek+8o+VdiNd1fKvoKAVKR/mEjcsH0uSWL3DB9LzjfHf9Zvc9297WA7Q+3wuAjFjbJQwBbWPW8ixJZfWCVFbALst8cVqDZ+g==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PA1PR04MB10892.eurprd04.prod.outlook.com (2603:10a6:102:488::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.17; Tue, 5 Aug
 2025 09:41:34 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8989.018; Tue, 5 Aug 2025
 09:41:34 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Waqar Hameed <waqar.hameed@axis.com>
CC: "kernel@axis.com" <kernel@axis.com>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Claudiu Manoil
	<claudiu.manoil@nxp.com>, Vladimir Oltean <vladimir.oltean@nxp.com>, Clark
 Wang <xiaoning.wang@nxp.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: RE: [PATCH net-next v2] net: enetc: Remove error print for
 devm_add_action_or_reset()
Thread-Topic: [PATCH net-next v2] net: enetc: Remove error print for
 devm_add_action_or_reset()
Thread-Index: AQHcBewLX+RoKINOEEahszryOQU6MrRTzZKw
Date: Tue, 5 Aug 2025 09:41:34 +0000
Message-ID:
 <PAXPR04MB85106B490CE2569F661F5F538822A@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <pnd5xf2m7tc.a.out@axis.com>
In-Reply-To: <pnd5xf2m7tc.a.out@axis.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|PA1PR04MB10892:EE_
x-ms-office365-filtering-correlation-id: 149caa8f-1247-43e7-3f44-08ddd4044418
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|19092799006|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?8BOs97nAcqbOgmB9fTfKGqWtE/nF89FWD7A8To3ne41vdMLn+jENDyqz9t09?=
 =?us-ascii?Q?6fhhPmQSfM3f7q/QqEV3u5SjpFAzf/0EuFNMHesC4gvHDoKOkoF0/K6hhh5p?=
 =?us-ascii?Q?Bwc0Lm2oHVFaNx0yk8SoxLTp0P9g1cdrykGcIzdi+WPXfreBMMmA0FN+AkRC?=
 =?us-ascii?Q?AvL4LSPPEM0KUb3EYJ/eksb/dI+PyYld2zqx5U6YeBtljWS5qh5f9zkMfw1x?=
 =?us-ascii?Q?N1k4PHhBcT+IRfYpP6oAVW3bY3Ui/zOd/azErhLREF40sgc9xrz4X36Z96su?=
 =?us-ascii?Q?BDpWykPYLAqXP5KMJ7lUqnV3J1HiPqd46a6Au4pWUb3OL9zlwE+s/FQ6Ox5a?=
 =?us-ascii?Q?bbtF6sZLPyOyUQKJsmXSOOq95A9Ao/Ogtv+kKrZcTuMeC1U55hVgxyFVyWF+?=
 =?us-ascii?Q?ky8K4uW0tHIDI4+QpP4KSkkNjKHrsqwQIQBM3afHFHQeA1VwfbMfjn7i6E+p?=
 =?us-ascii?Q?zrlMzY17q30uc+RzKt0PA2DKKcQH00OxRT+3hFKS9BJG9pBIxB7hZzz3oW1c?=
 =?us-ascii?Q?zortc75iJjgiH6nDID1X4wHfuM5wlBK7nCErD2AdrF42k4Y/lqlyDGbHimJT?=
 =?us-ascii?Q?B+rVhRhUMDw3by/2natq2IJpTqx1Lbp8hdH9pUJCAwzcdiwl7HJFBdQ+tr3c?=
 =?us-ascii?Q?IKjp8BIifAMV6HJtStbZmLHdJe56XIYK0C04t2o0Ko+/FCU60vBPothNSZSr?=
 =?us-ascii?Q?Z572i4wV5sQb+vOc9Lic1j1jE1JeY9EERx9xTR3eNZoZKeOVhoCr3UwEaUD6?=
 =?us-ascii?Q?qLiC+PQA5uz5Fel134dCr1d3dNNLyqHUI55a2zcH3IkHVRqx+Ek+2PVV4Tmx?=
 =?us-ascii?Q?+WE2QdWze6gZbFRM3B/NxmAlM65o1Psbvkse5p/GRman+5UeAgSwzgHdFKjk?=
 =?us-ascii?Q?borw5xvTx498yX0rDAim0Bal4veRsyTD5f/4h3L0XPgFeaOW5d3G4gUyTEUz?=
 =?us-ascii?Q?cv44M7dJUBvTxbuYVEdo37PKcRCEdJ6IlhZbH5SfvoiOHginfNTRk8Q3dXDS?=
 =?us-ascii?Q?Z1o9jeb3PzvEgr46r6J9iAhfddc7j2U5nkxJS6wmXpIFIpLvOqEuT/qjFl1B?=
 =?us-ascii?Q?ZWz6MkT22rLWZ5njyNl+DrgtSjw5qkzkWOTg/eyaRkuYMi3PY2wK0DS5/Rcc?=
 =?us-ascii?Q?bw6649W6V2SUH5CmEoAkaUTZ3tpOAYi5b86uOwpSyhhCwMcXTN5fSKGBJAIa?=
 =?us-ascii?Q?3tM7YDxJMCPalyvKdl1pIHKctnUg/01aUPOK03HNVkNXT+dvdSoQxetEI53q?=
 =?us-ascii?Q?EzE5ji9T/yYxELzDEA2rN1BQ5P0Ql0LlAIxhwv7rToEzE5S7dhBgJVPkHj+K?=
 =?us-ascii?Q?V11I/e0nI2Fvxd5uajKVEKD8Gx6XVerzKfpmjB+kLFPr0ppNSRSSAKyPSypl?=
 =?us-ascii?Q?lQNYeaUpsv0fB77lfEdobA/TOG4uhya4jvAy/VEbKxGrpmbp/Idn9kVedDwO?=
 =?us-ascii?Q?Jmctau7c58I=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(19092799006)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?N9mTLtxC4Au431QIFx1YbJFHb+P2B3KO8rzWtVuZ3j1Sm+2zfvo07itYsjhz?=
 =?us-ascii?Q?kQDAM3YQ/Tvq9cpSiYIwjh3s8AjmG0oeu4+cQnmfdP4+C5oClBlFJjw57QGE?=
 =?us-ascii?Q?mAwzJjB8ySL5ZO0OlWJdu8rHKK3IoTRzgPeIEqZZov5Emvs7OzBX/Ui4e/IX?=
 =?us-ascii?Q?W/+3OtrqqycK/D9tqX1F8SE63Hxa3hLhWfNLW7m6tM9bz5zqxrbYzmLIcXWQ?=
 =?us-ascii?Q?GYulkb5WCJ2PIpoNvhW+SkDVYlelw1vDLt38Se8aCSatSXmt3AC0rgQTOS3E?=
 =?us-ascii?Q?pWVwjtJWzaipdlI9vuV+wZjzJdEbeZP+9g8/WXrwTqRwqs1enJWd+E9+xgxc?=
 =?us-ascii?Q?EfsKnroI7qWTmZdOyFYPmUBmHAdCEvOHgA8dCrIfgfFC3anesD8hU6f144wf?=
 =?us-ascii?Q?1Xkbs5QRste1I2jYkHpCf/zS4d25+LOESJlknwM09DLjfwLG/H29T2Ip/39n?=
 =?us-ascii?Q?OI+TJoNXXJE0oevbyyu29d+UNgHTMsqdwH8KXnGDbt8OQjw4klvUw2+jBSbb?=
 =?us-ascii?Q?2odX24SViWnNralL+q4KyPhoN/cblMWU41Vq7eT7ENSvomPcORbBf0yRuQX3?=
 =?us-ascii?Q?G5HJNdAQLQpa1wrMQMIfOQ19NrtRc0S+mAf5nFclfshfgmLvb0q6NVMirnR1?=
 =?us-ascii?Q?bBdiV0ld0AyNxQJCVZO5egddOVGFX21rtAZthALxV32bwKr3NMD9fBLVp+pG?=
 =?us-ascii?Q?XNkCXW9ezqlEdLOz6q2bJJUlixXJCngBKQGIcSkgjczKWObkgMillACmSl/Y?=
 =?us-ascii?Q?FNQ763MsDCvEZtIKxgteL81nKPmOJU+RGj5hq5Xyp9dxuf4h8TXYOAJ8faep?=
 =?us-ascii?Q?fq1678FheoEK9NUwrHLbM5rm7UvnF2Nnd4IEkULGONdF0gRIRAgCfISSoXgz?=
 =?us-ascii?Q?YUb3Eqp7nau1+n8Qa/LxBQcfn+VMYBGoUJftqFugeMUsHuS/HLaLFJwo3kMa?=
 =?us-ascii?Q?L1u9tI4p6ihuL+3TfS5WaY1ExE2hvmN/3AV3CuaqsufsDA2/RXckwuLg22AL?=
 =?us-ascii?Q?FIGkJOtItSjwJoR8QEYjVmLWmHPxY0e6GVjmFhSw7XF8teqbcLTl6ePuI6w1?=
 =?us-ascii?Q?Zhbvfd+c+E7ZJdzScwhuUV00G55Y4R0qmTipdGDYgsaqg8Gutif7Vax4OleV?=
 =?us-ascii?Q?SmDi8iLmr5upjUNYXpOaFdUW6oQnGtHyCkt2Ym7epveh/WibTtzMESf1iZAy?=
 =?us-ascii?Q?31HqBz7WQPz3X8ORt0qaMDWowgj/vwd5+3XDaswyG1OvppQfh+nK0ZWz9mkf?=
 =?us-ascii?Q?Ei/AvI7TYRrM8YvCe6NuXOsmdxlCT3eYBCeOvwsFd2Phda/Wb4Fuwp9XfOfk?=
 =?us-ascii?Q?7p+HHRpAxYFgTbC1buq0Pxsyz1SHuSU0kjGizy1tQ8zfT2y2eNxzBU3iZZBg?=
 =?us-ascii?Q?KBpgQGWZB8yqa//tsf7exx3VvHWwWG0R67GXa2LAjQ9e7SRN9RSA65b2eKiJ?=
 =?us-ascii?Q?JhEJUdCYMuTclq5VSwyQe18OqN+QXB4qpj3H0ht+Ft+S7e/6JhX1nD11mKrw?=
 =?us-ascii?Q?Wz0583G/P4BUGK91JCREkAFw8oaRZdUOmxpqtIhPQABHP0PT6x6TWrO3Z7Rd?=
 =?us-ascii?Q?ptOusew+7QYfVzSRoGE=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 149caa8f-1247-43e7-3f44-08ddd4044418
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2025 09:41:34.3498
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 49SwbibQbc7rhd/rabXBN4/gZy11dMnBLdtdksPFq6vGS0n1Z3AHBOrFKygeBGWfLwrp5sDLC/ogMV+RvDylnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10892

> When `devm_add_action_or_reset()` fails, it is due to a failed memory
> allocation and will thus return `-ENOMEM`. `dev_err_probe()` doesn't do
> anything when error is `-ENOMEM`. Therefore, remove the useless call to
> `dev_err_probe()` when `devm_add_action_or_reset()` fails, and just
> return the value instead.
>
> Signed-off-by: Waqar Hameed <waqar.hameed@axis.com>
> ---
> Changes in v2:
>
> * Split the patch to one seperate patch for each sub-system.
>
> Link to v1:
> https://lore.kern/
> el.org%2Fall%2Fpnd7c0s6ji2.fsf%40axis.com%2F&data=3D05%7C02%7Cwei.fang%
> 40nxp.com%7C5c6c1234f2944165bdbe08ddd4032c43%7C686ea1d3bc2b4c6fa9
> 2cd99c5c301635%7C0%7C0%7C638899832279054100%7CUnknown%7CTWFpb
> GZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIs
> IkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3D7ejNp6ZnP7B9o
> gBefpQdq1%2BGCH9vqHogvsU%2FcJZbWzo%3D&reserved=3D0
>
>  drivers/net/ethernet/freescale/enetc/enetc4_pf.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
> b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
> index b3dc1afeefd1..38fb81db48c2 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
> @@ -1016,8 +1016,7 @@ static int enetc4_pf_probe(struct pci_dev *pdev,
>
>       err =3D devm_add_action_or_reset(dev, enetc4_pci_remove, pdev);
>       if (err)
> -             return dev_err_probe(dev, err,
> -                                  "Add enetc4_pci_remove() action failed=
\n");
> +             return err;
>
>       /* si is the private data. */
>       si =3D pci_get_drvdata(pdev);
>
> base-commit: 260f6f4fda93c8485c8037865c941b42b9cba5d2
> --
> 2.39.5

HI Waqar,

The net-next tree is closed until Aug 11th, please resend this patch when i=
t
is open. :)




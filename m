Return-Path: <netdev+bounces-226181-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 310C6B9D7EB
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 07:55:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51A76323F8C
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 05:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B58E32E8B6C;
	Thu, 25 Sep 2025 05:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="VHrjDMlJ"
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013009.outbound.protection.outlook.com [52.101.83.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC012E7F07;
	Thu, 25 Sep 2025 05:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758779698; cv=fail; b=uzTa4BgfIflWmeCapb2/gvybGNz6lLactCdWME3jLCBhNjCyZuwR8gGih7u/NmitHb2GFKaVHvup5A6bFVISQFkKEDXw5QAc2wo3BzxQ1s+q+ZyC2/t7MKI4gZyLUgY6g6fK3Vu/9d7B17YeN02DkkCRhy4K2l6Nvgxdoflb9PQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758779698; c=relaxed/simple;
	bh=AQnTR2SkbbqaVcar4w9WE6dvcTJtiBUCx2N5/OxC9NI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tKxSZoGOvarun7MTfkFqMkM/3kdbP9LTz+gK+JlvRzpH2bcrGfdLd6p5UMtCtYzOR9t//b4CRfJLECjHLIJSLlKk6lTvzTwm1mT9tAlEgpymc83NyTIaDe4Fi9oJAvJHGNJ9L1K6wOsqok4wiXI0bg3tcRyzgFAWDrgAPube7cc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=VHrjDMlJ; arc=fail smtp.client-ip=52.101.83.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aR8OY05IwBDulPLLIc5MnDWcKDbQs1jj8FwuEhOz4DPLO0r4MaDG59Oqz43ZLLlcb373Ie2wHer71nHqGCE5NJMz9anixa4PIlBoweft+HFgNo8IC53ACO2hIsdPAVW1Aq/dhlQwI2yVyrog/syFGS3b+/aVuWBBbP99oF2g3riLgVOk/6nIhC1jFJLh2HJoNA9nx/XT3Wl2ilN408AucJPhh5fR+qiIpODioGtUvFDwuSegpNXTekPQib7Hgzk4dEWNTj01Hwr3Bm3IvuZWj13Z4seFdjIxY0gWuiVvI+8jiY+JgAZ74Lhta8dGm8I+FeiUXpPm+F8V07dF3ztrWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nu4M/f6YQU0bFNV1YHr+ELn6Db4pmDBnaNuEIlYnJXE=;
 b=k0TFKNxsmC4PKcAW28KAgx0hJBa6SpihpwhRxE1Or57yYx0lzqaVqW17kVy8y63E7X1iczpFQwuOX/6FCKsZa3cWJOKjM2lOSIYHaCcjgqiY66y8cbtEt1g7WznNtbVJ2plpqlvGaKBwEr7m6NA6m5AQ9x3SIo3Vz4I4WkM78/Z3nzZjRi+804h7Xm2N64yTiA+opeGI8VvXFRVcdHVxAFqRa8yaksAFNpxPsD10B4dBRJhDrAxJW7BSy46GW/1yqpaoMsK8XMJa2/w7kIk3R9Uh9nODCpNtBL0zmdhG7zWBF4rUVv7Mdpb8KkhNvpAYFGNkErBSjsOB1ZfFRXj/WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nu4M/f6YQU0bFNV1YHr+ELn6Db4pmDBnaNuEIlYnJXE=;
 b=VHrjDMlJnUhBzLSPK04sOR2lcPKyxGH9dPU9SIf68wPExs1D+KHrLBnjW8Ih9o7OR7sQ6iZeWSlSqj99EU+Mz+QFIndC+WaMZDE1Zg26J+klmV0tZ2U0GhkxhB/fbJCGFlrPLVLvn8AkqvmPkffWUjAN1Us6BOPjxIbENRUr1iQeg7JxStLWRmxlozjQMjH2sj3JVR/fsKF6l1FuKphLdvpsV4+rH0rjz0p5oyoAsHo8hdYMW87/mYTqPC5HXFfTwbna0rPZfphOyHCMXEzWqS02NVk9Yic1yDk4wajFrywXOKIdpuuDRiAWYY+XOG+0mjWKzhsSvqud8F6hOAbjUQ==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PA4PR04MB9296.eurprd04.prod.outlook.com (2603:10a6:102:2a7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Thu, 25 Sep
 2025 05:54:53 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9160.008; Thu, 25 Sep 2025
 05:54:52 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Jianpeng Chang <jianpeng.chang.cn@windriver.com>
CC: "imx@lists.linux.dev" <imx@lists.linux.dev>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Claudiu Manoil <claudiu.manoil@nxp.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>, Clark Wang
	<xiaoning.wang@nxp.com>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, Alexandru Marginean
	<alexandru.marginean@nxp.com>
Subject: RE: [v2 PATCH net 1/1] net: enetc: fix the deadlock of
 enetc_mdio_lock
Thread-Topic: [v2 PATCH net 1/1] net: enetc: fix the deadlock of
 enetc_mdio_lock
Thread-Index: AQHcLcHw4jtdzBkrmke9Q5d6GBD3MLSjY8lg
Date: Thu, 25 Sep 2025 05:54:52 +0000
Message-ID:
 <PAXPR04MB8510C7281930343839ABD93A881FA@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20250924054704.2795474-1-jianpeng.chang.cn@windriver.com>
 <20250925021152.1674197-1-jianpeng.chang.cn@windriver.com>
In-Reply-To: <20250925021152.1674197-1-jianpeng.chang.cn@windriver.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|PA4PR04MB9296:EE_
x-ms-office365-filtering-correlation-id: 517252e6-b0b0-414c-7823-08ddfbf80bd3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|19092799006|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?3w8TxmuNlTJQP8EX1taAnIk/FEszl6VolUaZW1kLbrB5DxNwq7+KuNOIRrPw?=
 =?us-ascii?Q?4lsX49IsvhZkZJSd7rPKwlePGwrVOfqs+JBe34mBNAxcdt9jnCxnrSc8mDSq?=
 =?us-ascii?Q?dfBr/GM2U1uUluW5qmMN2Eg07b9NnKFxOtkkZzd/ghB2GwnIbhcXQ2G/9NkP?=
 =?us-ascii?Q?atAOGYfkp3lT4w70pgTg53qx8GFxgDZk4PgXzf4ivR+GWS38U/1Dhu/UITNs?=
 =?us-ascii?Q?tXbDd8t56hOGxVvZFOXZ4Ol0Y60cIQ9pdXW6YdQoaDkUABEllwHBuCKKlXKx?=
 =?us-ascii?Q?AuBS0P1YOHbZMV0QvFl6Nds4veJ/2r2i+bzBraFpuySLPWf3m/IMClxq/ZBY?=
 =?us-ascii?Q?zO7Pn8Ddq2Z6htGt3almUCwYPLo/RtQ7JXjw4DWfvolKou1oHHGVTLmx3OXJ?=
 =?us-ascii?Q?SA+Tu7vSnQFnzodAMWJtaSde8rFOYzZ7lJIsUmJO5mlmIzhupo298n6L/r64?=
 =?us-ascii?Q?XFj+Cm/vo9b7vEo0tNq/xMwhcyFgrcxbJhK5+MwRPe22fDGL+BT++cPzr1zv?=
 =?us-ascii?Q?0sSe0BrW3NBT8y4tb4rOImL8sRaZEsvpCJVGyuKOnoHWTef4PDDu/qgYrCVj?=
 =?us-ascii?Q?dmU+fswWk2vEbVECertR71c72kx8irDHnhH9bAe8eBKWXRoo7MQjX5/3ctvs?=
 =?us-ascii?Q?BOg6pTkgxqH8bvrpmo6/iAFQRHduzpSF7ZHcTsU88vysIZ5J/akLlDIR6Opc?=
 =?us-ascii?Q?eKl6YwNUmS+KYYj+ITfNoQqtPKj1ZPNcQZrJCIFijs6gUlPYaBCXtCdrs05X?=
 =?us-ascii?Q?46EbUAhSwQn4FLf0eN++hBROP03+KmRMzzkij+htEDD3bCDYyxysB97Q9Qyn?=
 =?us-ascii?Q?6kbZgpqBIwQQFy4YVafLD1GR4L/wKSdrcHHCFKc5BNLtWYYdk3SP52ii+6D6?=
 =?us-ascii?Q?0ht/sQk7LJvQRpiY8aeQ8dBV2S57gMZrcBiBplI7ftdEg6dtxqmP5+haFVVO?=
 =?us-ascii?Q?zPgexjc+IZTcy1vTtDWR5fjdf8C84BbmXubH3nXr7d4jOnXwToTvxMGbW8uc?=
 =?us-ascii?Q?iisLMectCICX1JfvaocLDemUaepGS4i+ErBaYb//Irn7n/HUj3w2yu6t1Evl?=
 =?us-ascii?Q?cM3hy+q09FwOlMNKbwfiWZaABmdpm5EgeuIgyDbUp1g1PEjqHuWgiRaxGiP5?=
 =?us-ascii?Q?h6F3pHqOFDE8TFalM80nd2Hsdc4kRLYoJwk8j+lVb6p9/nYxYP6KvG+ULhIC?=
 =?us-ascii?Q?065z5UzXFm3fZuMtVdPGqPp7QjKp9lfVu9kfrqQbQSRCAn2rRCiSXKZehEHc?=
 =?us-ascii?Q?g08euLlgYXB4hSUSPrs/W9Jny4XqRraMr/CGkzsh7dz3DKOWatimypbV/8y6?=
 =?us-ascii?Q?8AK2PgoM3RFXIJivBpKeShzEmsb8K9Ul/X/Utfo+8comNRqsyserFdTGItCr?=
 =?us-ascii?Q?a1Px8nAY0UJE8cKdBn9FL/oPshDG4j/9FC9eiEcn/D/hmwivjO+F476k4T2D?=
 =?us-ascii?Q?VrjJh1t+sFY=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?TBWdZNztvufcofgdrof+pp0NJY0Ax/cGftUW99MIa3HTgOLu0OD2LAu3F/kR?=
 =?us-ascii?Q?EonRCcl4eezRdaHDUvJ97aZ1FuvssAlXV8MOtOdmMfnyL3T0FpCCwyOQAP14?=
 =?us-ascii?Q?SjjZE7ncdQi5Q/WT2c0EruxixW89vfhQp3Jcc86W39dPCLRIRQ+PdgQXioPW?=
 =?us-ascii?Q?qRrBZbiayAo1k4t82Jlh6g8dsBufjjXboq8wx94b7HSpbFBX3MLhaqtqE4j8?=
 =?us-ascii?Q?GTT60p2yr8dhkZtglL0uoRhir7X9pK/VXCe2aSGs04RTzw8Vs+pwTZIb3dAg?=
 =?us-ascii?Q?aFsj2esDDLNCf55AuHivnHHtz82l0uvcFm/MFGWCNlVlkdEwVsvCaxyGXTke?=
 =?us-ascii?Q?U5MlEHQ++9wkuk2xhW+HPb0I9ykGtcF+eX9P3wyE7P7Kuqq4CCVUXJwcRHS4?=
 =?us-ascii?Q?NaY7StsatHIxr4zGkZ3I2hnM6C3Qhs/jjQRg5olG2dcTS91GUwaUd0cQewj0?=
 =?us-ascii?Q?iVmbKpaECK03N4arehaZlKnx3Ojx/ObCZxr+MKe7RiSQtjlK0mTfkICEUa+f?=
 =?us-ascii?Q?5yuvtC7rIcQjj4ZX2joqNn+OKMUBfO7YHeIuCbrW2da0ZtSTK7sAU5xyStjr?=
 =?us-ascii?Q?71Lz3CKti1r4c/bzhW67DTHCKfTcLu8TKMTWpRbyURYBA3R3wncDDtzVITHP?=
 =?us-ascii?Q?Ck5ErTI6NuE0EBkiR+U4yuDy6Ul7ow2iXQ522p3sIt4pT8cpA+zwHJiBzFw7?=
 =?us-ascii?Q?Khwd1crL9+VcBJ+cVcniK2Ki6qKYHngcvtB9yzJNo+ePcgMF5frmiZoTDD1B?=
 =?us-ascii?Q?ER3lX//skmbEm+C7QzH8ECz7cenCxfYfmayiwtEofn1Mnz54eI+c5+dZNFCB?=
 =?us-ascii?Q?mwwd9xPSXBP1ZH0Psbfyubf4vyI8tK0iJ31A8YPtCHhzV/LU38tyc+nUVSp4?=
 =?us-ascii?Q?o+S6Jw25G+2nfz0M5fo/GsCaAB0Ns8VFgdCpTKnObWxXY9e0javyl8xY8tfu?=
 =?us-ascii?Q?8z+W7rTD8Likr3hCgjJJxMzAQLOYfDbiTvusaR9/X6xfBLZao/vBeC6lOcxe?=
 =?us-ascii?Q?wUTv9hZa2mtuzpLCS/ITYd5IKLR10zDrcNyyEo5F16JNI6K4Bq2tZ/krtX4e?=
 =?us-ascii?Q?T3nc3NAbmtLhon76CrYLbA5BjWqRZoxFZb9WEpAnO8P2NywpOlcoV9QKcmAL?=
 =?us-ascii?Q?BHXWmoH4BcXfjMB3lf/vFDukdR5s9B93V6XWnYboQZUrShvKrKa+YaXEZHyC?=
 =?us-ascii?Q?Dw94qjIC2AgEBIvS33uwM04Mqx7ADl4TifBDlZ4VFc5X2xzjXxb/W7L7C6kz?=
 =?us-ascii?Q?/fZEqT3gZ9hBAwNyO3hnAr3CgTWnzh7ycKirmcxG3RWSE5E0uwkZsEQ+5fZT?=
 =?us-ascii?Q?RnYBhAvsOXEpAKTYifDhIrszbknAlgTc88TpaVQpm51ROePQ4DD/zQ7Dpdb6?=
 =?us-ascii?Q?OCR4SrIENHCmofEc2OqDpgzPVw/dQ63i1lrBSCUDlrvbVw5oZRmNLs3neg2d?=
 =?us-ascii?Q?00b1Hy6vri6QLLBQXBVCZtQH2wXBRCn4Wobe/+mVpIXfH6PBI3zC5OMjcdya?=
 =?us-ascii?Q?0R6iefWeFcMVQ+AlUAP6qHcrxQCOENrhpeF5bEcdzNJHQNTSJ1On0+gMC8mq?=
 =?us-ascii?Q?dZsMVwkWe978dyRv+yk=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 517252e6-b0b0-414c-7823-08ddfbf80bd3
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2025 05:54:52.4974
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d+DcX21fudLIEeOZHyne+5nx0F8fo+lMF0vsMozhayWE2ifi067nYhN1uejjeIfrBBr77FxNc43KwP0sOHPuPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9296

> @@ -2068,7 +2081,6 @@ static int enetc_poll(struct napi_struct *napi, int
> budget)
>                 v->rx_napi_work =3D true;
>=20
>         if (!complete) {
> -               enetc_unlock_mdio();
>                 return budget;
>         }

Nit: It's just one line, so please remove the curly braces.

And please note that do not repost your patches within one 24h period.
See https://elixir.bootlin.com/linux/v6.17-rc7/source/Documentation/process=
/maintainer-netdev.rst#L15



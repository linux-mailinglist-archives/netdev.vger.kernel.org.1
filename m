Return-Path: <netdev+bounces-197306-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B8BAD80BB
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 04:01:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43D4C1E123A
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 02:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6B6D1ADFFB;
	Fri, 13 Jun 2025 02:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="BrVJMvHK"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011021.outbound.protection.outlook.com [52.101.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633771A01B9
	for <netdev@vger.kernel.org>; Fri, 13 Jun 2025 02:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749780065; cv=fail; b=lq413rJ2C8GcW4Vjp2h6QjQJ67ERJ+iDxk2ZC4Ck+xaReYmWAYUABXU4eg1qOPQTi2wz5iQwBjCE9/oveIx5fMZ8HzSmC1oI9AHWtOZoDI9OAf92GaztoAK7SicdH3aV5tncRr24CyNZJPbCDN5qQT2DDO40iAsufOGJ908zW5s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749780065; c=relaxed/simple;
	bh=j8ZI9uwOjdCG//h3zk50Pynj7qbRIm4EjPP2opTsbH4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UiindCUBme+mwzwsfahTKEpdr7nnHiPEO8bPj53wjPT2CPHaqurV904uXcapDMlBsS41XmAWGRf7HGPvEyTIrRXk+wXbKuiuMoTa3CsxrN9CytvjL+7tM3YLW/tHoPAhNLBJl98/PLQSWU6LFDuYtiCJnnee1VjI2f+IvO6mm1A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=BrVJMvHK; arc=fail smtp.client-ip=52.101.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uuk+cT5DxJYajPFVV2cnqRg/Yft5h5odEUXIIHkQRx7RGs7CGj20iCudYJFWXEcV7BS+h8qLHni+0IT4vYJH28wETO7wAhWh0UjOECLgkZgpNxU37KH36kEDZy/oSsgcgjvZOVo036ZWpmsxyTpvAgj5J6QEijDr6jIIjFBay2W5J4P43oVr6/Zjlvky14Bgdq/0x+ODQPjBC+3qB4YaGCmrkyAExP2Bi2WETNKQqQlSHSp57ECSGNiK/zstwSyjlH6WJ9T4ROjN1meTsGgKMZiz34+58qXs3RsAGEsWOUZLahncCrBnqzKiPy41nun3eR0l8HWmG6Pr6No/NfDKlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aktmNOdESK9khQKlMrugukiAzxbNBDAhXXU9qVmhmc0=;
 b=eqCJUVsEqbbQC49LzPzgSUk0XCgbYleISqdqdkEl0yXF3CAarLS+dVnbmbGf3YeUmArDIfShjAqKL46VDOVk8a0km5c7LVFm3q+A9Dx0cIOzU4tSoC1vXKBMFJYyfiulCjy3IyTUUA6BGmxsYRr8UbR2Y6SoqsTgO3v5+0WfIB/FFnLcC3O2G466uDtb9g9EW3Hmb/DT1v5vim9RUIxFB1US6T15N78SctV0FnlEjnJqnhC2dsC/Q1dJQvlTkaj+7QCST2c73LPDfjQSZgdzYFcgv85eUja2TT+Jbzispn1DfP5DXW7cRs0LcdjcDoT8M7ViG6Qkw4kZaWU2Lju/rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aktmNOdESK9khQKlMrugukiAzxbNBDAhXXU9qVmhmc0=;
 b=BrVJMvHKtOyalK1ItMhbayU99yrdM8a5uVki8quhClT78JdmWPrBkGPLXE2JZHaLBttTug0M2W9SN6pES2HNpz3E55jdX6Qju2THtr6dlD71K7VoEeI2X8hzlcBWfTm0TF1/Tx0W5WkrxeTTovDhqkvRcn/V0Zqk4gDJatSSoGg4292QnEROydzYi7Y2iQ5iRo5zYAg5Tt/L+tJemiALDkiqEGWSZQJapHs6gjpjZ7EpIT6kmQI2XJm71Id3lGYI72BxhzpgrkZKZLKDOMI07BPgpqyIy6bFO5a8VPzSNaqgD9NvDVJ9rxtvqq5OS/m9Q4r6rythlPGL8CokGKwScA==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AS1PR04MB9629.eurprd04.prod.outlook.com (2603:10a6:20b:474::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.18; Fri, 13 Jun
 2025 02:00:59 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8835.018; Fri, 13 Jun 2025
 02:00:59 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Jakub Kicinski <kuba@kernel.org>, "davem@davemloft.net"
	<davem@davemloft.net>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "edumazet@google.com"
	<edumazet@google.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "horms@kernel.org"
	<horms@kernel.org>, "bharat@chelsio.com" <bharat@chelsio.com>,
	"benve@cisco.com" <benve@cisco.com>, "satishkh@cisco.com"
	<satishkh@cisco.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, Vladimir
 Oltean <vladimir.oltean@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	"anthony.l.nguyen@intel.com" <anthony.l.nguyen@intel.com>,
	"przemyslaw.kitszel@intel.com" <przemyslaw.kitszel@intel.com>,
	"bryan.whitehead@microchip.com" <bryan.whitehead@microchip.com>,
	"ecree.xilinx@gmail.com" <ecree.xilinx@gmail.com>, "rosenp@gmail.com"
	<rosenp@gmail.com>, "imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH net-next 5/6] eth: enetc: migrate to new RXFH callbacks
Thread-Topic: [PATCH net-next 5/6] eth: enetc: migrate to new RXFH callbacks
Thread-Index: AQHb2/3GrmQm5TFp60SixkKtWRMON7QAVTzg
Date: Fri, 13 Jun 2025 02:00:58 +0000
Message-ID:
 <PAXPR04MB85102339387BD2294CA8BFB18877A@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20250613005409.3544529-1-kuba@kernel.org>
 <20250613005409.3544529-6-kuba@kernel.org>
In-Reply-To: <20250613005409.3544529-6-kuba@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|AS1PR04MB9629:EE_
x-ms-office365-filtering-correlation-id: 17e37736-aab6-4abf-cc7f-08ddaa1e2434
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Go4fbITvU6+QOsNI+fLxz2eLDrt16eUpQE1cKYKSwJMRKbOkJ/bJFtCg5xz3?=
 =?us-ascii?Q?drZi/wMhvoahude9kzF8XpPzjr0ZTtvhAAefs0cqHkgXj+1qBiZWgVXpFdDI?=
 =?us-ascii?Q?1qcUsf1mjQlV95zNR2LB4FgLZHqvJDqYLNmdw/9wYuUCEcoy0dj7wb1+yMbs?=
 =?us-ascii?Q?18yZvJq2ZHUP7KB5gS12L/+5SguvhHXprfInd5DKu0MumZK192ZvT1nU4TaA?=
 =?us-ascii?Q?HRJ+Z0e/WzxL8qAZh51H8MBH8NAIoaOTHQP9vUIYgZwx8wqIo059IOiP3rRk?=
 =?us-ascii?Q?mSCDfY3VNKS5g652OWj+OQt0CB5qmkUoa5ed/GanfpXdhfU+9aU0+uOQpnPV?=
 =?us-ascii?Q?xDCGqYL39TnBv1RDbOLH6ng64P82KJ1FXcf3sRONVQsACnz7oYJ1TqN5j7pI?=
 =?us-ascii?Q?Nq/adHV3+QKDYoSrdjg2gcEbCMdzAScQpOW2exMMUHFi8WGe5zQONS6YKghi?=
 =?us-ascii?Q?B/nLlzwH9PlfvzhsBSBVQhqhxbkdA3XaUVyeatmTOFq4LPFHy/OzPbWhYLe8?=
 =?us-ascii?Q?higVSA1jzPn6K+c95f6QDIpXGa1oSeP7RBruRP6nXDxOv1Pmyf923QhIViVY?=
 =?us-ascii?Q?t0oty2w+5j9N02mcHaGFIFSjpdiPp+MTAr+0BIMN7n50aeEMamFkMgb1QcI6?=
 =?us-ascii?Q?RRx3LMQwkhvHZkzamDiMF0aWVgkuAGIzSay+EsyeEkHutfRZU/+b/tXY/G7C?=
 =?us-ascii?Q?5kWrEn7Coa/wGxF0PHAG6/yNWbd4Qnw+SITdHBeZOQR3dzGNlDiJxrMcWMNg?=
 =?us-ascii?Q?0QQZkoAS7W9Ie8AulqPqTm0/dsS/NACu5SM588t8zFOV++bFtWH8PIUpuejK?=
 =?us-ascii?Q?LikdtJPjBG9fJa0gMInkL4WnDgg2jC/y6CVE7HHjvhKL2pvr8Ok/soU4okb9?=
 =?us-ascii?Q?cjxeFxiEtKwMmbVqN5cQUhnBp/4EdHTgyuMy1Vs3Yoq10eNZDcM9CGWDLglP?=
 =?us-ascii?Q?d1Zw1iMpA1Mv55GP/lJ1gpaux0Qti8a3G/MT681P1wk5N7NLdHxs7zgs7009?=
 =?us-ascii?Q?G8g0Jrt5ALaONnwK4QXm+7glX1MKMA3NHuY1EU4LcTjkKXHNSwTuAH9TSUlj?=
 =?us-ascii?Q?4W8GdOHXCLl06AmjVfX/ab6x7gvJNQ7Jm91prOYgFf/J7K6KpW4ExLWYERbF?=
 =?us-ascii?Q?BWnDlmlycCgH6nOOFwPVKUfVFxwyYqWuD+zEuE0jwk1aIizMTumIL16jym0s?=
 =?us-ascii?Q?xoP/zljx8iUCIbAxhOIxmrPIf3P1a9ucfe6NpyvIxipvEiD6ewY8m/uLNfGu?=
 =?us-ascii?Q?gkpeYNQZU8QP4v6aRMlhQdjdWsAlBecthygY2UQzBFtBhFyknzAQJRsU96nc?=
 =?us-ascii?Q?ZdZ+HTG46MbMtM6v/3csH5AOxkfI+7E9dIQj48ws1T5gY5NhJ5TeKkVYZkNN?=
 =?us-ascii?Q?OIRO3YDLwEsReb8rTxaWejLjCRddQjXL9wUEBX7dnUH7c1K03zv1XRgITTeq?=
 =?us-ascii?Q?NdaPd4AtSqzYJD5f7TOQM3H6GHysukLMfotvUqFiSMSrDKGynsLA7AmpqouX?=
 =?us-ascii?Q?38vXiCuDJUl8f/k=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?9b4sh1y1gsHwjgE4OglI+bFkOznlFWJjUFwwcTTW1laEY/4eiTotmQqnPgFq?=
 =?us-ascii?Q?oy2FXzVJGNxlddgz6v6IFJ2vBeRmd2+SqjqzZkYYwjJ3gmoAtlLCLmaT7byB?=
 =?us-ascii?Q?zy6EjW/5KwloEx9ICN7lhdi2Y+TnNWJTBqYx6KzrGH+4Z+x+vSJKkFapyvsJ?=
 =?us-ascii?Q?ENfjXhk8GDlBwkmVTnMHgchXoGP00Vemxaf83TJt2OU9pNUm2fek4LSzlTYj?=
 =?us-ascii?Q?1D30Q1r3qaLRg51pu/+Ug8hsYxcgK3fTf7bWQwgJZJNSpLlLOHJT/7vUG1G/?=
 =?us-ascii?Q?+eCaAnxLs8VUJccVQM7TRHlVCccTS0taAMIvY3BP/PA+XP0b1SqzM38r1WCq?=
 =?us-ascii?Q?uoWWY5XMvKzDOcoS5zS+1FKJ+q6tjJfFT5P0paKXjKm0s84aN9ybPrGEz1Vn?=
 =?us-ascii?Q?IPHMw6I/cTfYAH86y715NSq08fL6oEgmjD5tr7gRIOc4ofz3TerWd2dJX1xq?=
 =?us-ascii?Q?kF4TKWyDGyIV+yTB1+B+SCGzeCC+s9q+7PWci2/YEMxZMxkRL4I6AhpHokAt?=
 =?us-ascii?Q?0bxzDKGPhaJhZPLFRc6yfNL162qcdsqUy+iYeChmsmTUKmMJoAP07sFvAKvg?=
 =?us-ascii?Q?NxgN8maeqGtiqfV+s80e70OWCtcCk3bIeedHxICAhafLEc4WlzO1N35c1Wiv?=
 =?us-ascii?Q?V64jCVEcJeoJYcNEQshpeLPh7vwBmPEsrM2GYeEohBSjdv0HqpQnF3jpCO+W?=
 =?us-ascii?Q?LRs1T1Ds6HPOm14zlSZV9h562XUhY/xBxeHX6WnF+1Zpxt6VINzl6p7UQLAB?=
 =?us-ascii?Q?Y5E4VsAY/hOGicGmspq0D1XMNFH5GKkvMd29CyT4RJWV3f9vhHZR83TS3kpk?=
 =?us-ascii?Q?mQnFafHZWUODAThReN7y1aSpNHBdTPzJ4mY8+bEReeNA5GnKl4MLbbUQmDs8?=
 =?us-ascii?Q?l83C/JE49Ub7LMXKIbZduxkmM2MngLW2sXxkna6GIbHRbeQ1HWAeqQqKg4ni?=
 =?us-ascii?Q?P1Am92XjINgIXm4Z2MRTYfNdUKNAsySEzEQn2SBKhnqx7f/lEI50jpUTv4By?=
 =?us-ascii?Q?8dqvh4KGeXTgvCQnIlD1wjq+en22RVcj0nHYnIy65hIeyeb//TRjoFJSiAwp?=
 =?us-ascii?Q?Vtl734Vd0CfmwVBRuCRbjC9PV7mCcYWqnwCk1diyKuopN02btnywtdK/loKV?=
 =?us-ascii?Q?cYAvXNY0/+pUz7He5T5pCu4VXta+gNrk2EqWML+Wb2vsc/uyDYRfJgkArItp?=
 =?us-ascii?Q?8G4kgdjy4dMjm3/OO/OEHcUmtOL1TZfHs5ktx1eQOOXDMTwpXsd90OlMKR0l?=
 =?us-ascii?Q?v+qvowNfuMdWyeuu71TfynEAKGLDljSuL836bB/rJEcWUFVi75OG91taVYkH?=
 =?us-ascii?Q?lZOeWYN8bdKPOHKPyDwUxG6gQwVnTAOxaUqzcUKdHYXRpZq0qJ1WWTRtT5J8?=
 =?us-ascii?Q?+OIxUYi3PYO5XBz4mt1VpbzG/ww76/URzKXsTPfyuo4JSRbQmk4rqWz/lnB5?=
 =?us-ascii?Q?mMK8b9J553Ta7l1kb4O/XXjHPE1d6xj1l/9CgODGpHUWnOJKe+WbR11SVwvt?=
 =?us-ascii?Q?wvDZrCGcQ2o0fUJDPoS8wf3hAQ0RB0vW/q/uycjWMno0IMpmmcbXzrzO6/2S?=
 =?us-ascii?Q?M5O5MpmtZ7VaD8nyT5k=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 17e37736-aab6-4abf-cc7f-08ddaa1e2434
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2025 02:00:58.9073
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Id4m1GnJAcMnoe7rMxM1IzHgaDQkYsUBmVHS7DJ1LrJWb8IEJ5V8PniZySy6kZVd6K98ZvchotaEti1dLvAXtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9629

> @@ -1228,6 +1224,7 @@ const struct ethtool_ops enetc_pf_ethtool_ops =3D {
>  	.get_rxfh_indir_size =3D enetc_get_rxfh_indir_size,
>  	.get_rxfh =3D enetc_get_rxfh,
>  	.set_rxfh =3D enetc_set_rxfh,
> +	.get_rxfh_fields =3D enetc_get_rxfh_fields,
>  	.get_ringparam =3D enetc_get_ringparam,
>  	.get_coalesce =3D enetc_get_coalesce,
>  	.set_coalesce =3D enetc_set_coalesce,
> @@ -1258,6 +1255,7 @@ const struct ethtool_ops enetc_vf_ethtool_ops =3D {
>  	.get_rxfh_indir_size =3D enetc_get_rxfh_indir_size,
>  	.get_rxfh =3D enetc_get_rxfh,
>  	.set_rxfh =3D enetc_set_rxfh,
> +	.get_rxfh_fields =3D enetc_get_rxfh_fields,
>  	.get_ringparam =3D enetc_get_ringparam,
>  	.get_coalesce =3D enetc_get_coalesce,
>  	.set_coalesce =3D enetc_set_coalesce,
> --

Hi Jakub,

The .get_rxfh_fields callback also needs to added to enetc4_pf_ethtool_ops.


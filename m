Return-Path: <netdev+bounces-206491-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D874CB03479
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 04:30:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E74761897266
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 02:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40B711C683;
	Mon, 14 Jul 2025 02:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="gZWr4AlR"
X-Original-To: netdev@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011024.outbound.protection.outlook.com [40.107.130.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252C11C1AAA;
	Mon, 14 Jul 2025 02:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752460206; cv=fail; b=FLy16cYPgqnQNsrnPKsB1EVwEBv8pRym1idBFwaKRxmY/D/p6270cTV5kk9CadMba62psVYNTbBf+NUJvVEa7lE4pbgDwa12FiqzYlFqbWKSqXL17WYhWVlQjAGcmer+jMPdUW2IfMV3Aq6D2I770KYpgCK3rYbKPUmUxhjbFqg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752460206; c=relaxed/simple;
	bh=vkdVAYIDoN1juhBJzdowszzrfGLrLMNGJiZuO6fR+rs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SKbYwUzRAKdI/xirxwDbRX748+WQfZgs6SaSHtjyAeRNLy1hj/jTMk5WI1da7UClfOQPDsXVzmcE89ZUOcY5wbypFt/0L5hJM81RHpYUVHAHbpX5yhf5J8aTqxBWHSHAj4P8YktLn7iR77OtXHLpWMczoqdDmebz093w6CR86Kc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=gZWr4AlR; arc=fail smtp.client-ip=40.107.130.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gGuiXCYz2tY6TL4tVJYSMNT0d+ToTrALk9980CZ3Z6bPnnmwJNvmxQrRRbDNB1p9tFL+7VFPiVYu8vrEHJTSf/OfneGhVY6CZ8Nwm7nIbdef7fhI/PpDj2hcKDJDLZhFVMDrxhVs7XsVXehAvq5Yb8twYgHS5y1FWsMcQemi16mpRgdz8sgDEqhpJ9f1rHIP8pv+aYiPmbsXLcdkdqkpeV0A/c4Y6MaVl7JrFT/9hrBs+tUXBq7kEkOCeoakdlRlMkwzelV1Pfy2lUFSDOkK4lP0GwVZZm8IQEByS89xf3OQlCbkhFuKhvh8fIRksPWQ0XM6dmbgI9qpvKRHLhJR6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oPxPhlgBkr6/ePJ6zBqVBAKZ0QfjW/b97S2t2c5QD20=;
 b=Mglxc0KnG1mq7Z4gbKlK7xw9GAKjmhVgL08ZdchuVIbmLGDieLAKWyQtA6HPmHRYg1lM+iFbxY60fns6xgICA6bOvXn9+DA0EkKlLXxd703UcKH3XEuD9kL2bUnGNmsXMji12iAf2y89ifyGK+eLNgxwrbhqj1dOvFtoK3L+uPCjmCWV+7fkFN3JB3GiQZpC1QT7sczOso86wUTZRJc+rPSwIqmniuCxqW1x7RYhTGMxcS1j0hb9gHq1KGC954pBNXg3LBxgNS3i5snWifHNNEuT4CxbW75J9b4Fv+0cAr121q+LMapMzkBF19obG14CjW/a2beevsfEvCipDbYK+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oPxPhlgBkr6/ePJ6zBqVBAKZ0QfjW/b97S2t2c5QD20=;
 b=gZWr4AlRT0J9RTTJ9jmbOtiLB6y/hGvqLZzKtZ1jhR9nzOgGx/6D2Rp5+EPEcgZ7kSfELtFcVVOCuMM4YQ0oUrmpl77F3CAyrHC0aiznhHjNk3Q1+ypdN8jdLqiKW9GfoyX57U4Yb7l62uLRWEfnkcyuPHEdR/K5I/nG/9m5glzeLdaf+PophNr1U+lE8QR3BWZlcKU9LmJDA5RWRgssNQyo2UsLtpHd05DluBWx7NHzpwcDsGhpYiMlm7LoTAVFBe7DWOURqAXDxN8ltrXfWB3dyQtb8MyJid99YYg6t55OEACm06TRXl+LGMvEquTzMvVDKunqBIZ6P7ORJR604A==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AM9PR04MB7633.eurprd04.prod.outlook.com (2603:10a6:20b:2d9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Mon, 14 Jul
 2025 02:29:58 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8922.028; Mon, 14 Jul 2025
 02:29:58 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"richardcochran@gmail.com" <richardcochran@gmail.com>, Claudiu Manoil
	<claudiu.manoil@nxp.com>, Vladimir Oltean <vladimir.oltean@nxp.com>, Clark
 Wang <xiaoning.wang@nxp.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, "F.S. Peng"
	<fushi.peng@nxp.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH net-next 02/12] ptp: netc: add NETC Timer PTP driver
 support
Thread-Topic: [PATCH net-next 02/12] ptp: netc: add NETC Timer PTP driver
 support
Thread-Index: AQHb8jPan87Rdn8VMEKOXtXyIvr3+bQs6gOAgAP3z+A=
Date: Mon, 14 Jul 2025 02:29:58 +0000
Message-ID:
 <PAXPR04MB8510CF6159CECAEC10A638848854A@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20250711065748.250159-1-wei.fang@nxp.com>
 <20250711065748.250159-3-wei.fang@nxp.com>
 <9f65fac0-e706-4a00-bac7-20c3ee727f69@lunn.ch>
In-Reply-To: <9f65fac0-e706-4a00-bac7-20c3ee727f69@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|AM9PR04MB7633:EE_
x-ms-office365-filtering-correlation-id: 76909f76-6ba8-464f-3564-08ddc27e53bd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|19092799006|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?y7FRxnABsJyNCrlfPpiO4APqmkjsahpa3UQLKJLBPHh7gn05xzM8WVvhAnUY?=
 =?us-ascii?Q?W1Vm0fgl4t+Oz+9NcB5LGfYDPorp1tfjqPTl77mwydr+iC75J7RjDZHR1j0e?=
 =?us-ascii?Q?ZfCuaWZN4tEYu+pvdqoDiRzhW5AQuh+5VfNAD/1G8uT4MUhBREZtp4i42vVk?=
 =?us-ascii?Q?GtsSpvOyDOYHG/gprB12SypaSImf/XxLjS1Y6T2b1CLXtK0kbPuX54jKPny3?=
 =?us-ascii?Q?EY/IB2jipxTi9MnKm30dITQ2zan2MAemv/0JDMIF2Hy1hTtvH6QUHFPNKIZo?=
 =?us-ascii?Q?kaoYrvqx+SPwOBJS4lQWeSZOKYYCj8bpb1e1Ex4yatpndOri3kZxuUPTB9NB?=
 =?us-ascii?Q?rVVc69+fPY+hYPb1Fxwa3WuG1HcDZAQ4EuW9mnT2rR8kPMH2zvmxuiB4RViC?=
 =?us-ascii?Q?qcIO5PK7ad7rXgs8SPh6bm+RJS+lBmHB3iQbyYmAEclaSs8K+cJEjWsjgD6C?=
 =?us-ascii?Q?FEaBBBNXRAYoMzPipupt2W4m549c7YUZKSEnI/bD5LnQupjXbBrUoiWplLkI?=
 =?us-ascii?Q?0gteojBEH4QOvj51MsLfp8zWH9YMQ+ZPrT5ctnPHRPRla45ApeD+0YzM98ey?=
 =?us-ascii?Q?tsZCzOrELMLHf/bTmnTGmn6sF5owqJH8iRkSLxkXL7rUfxmr2/+kpxuHrBwi?=
 =?us-ascii?Q?wlshNDUIVrtP9aTwHEQV/PmKk8uYn4R8GxPxA4MaDYEEVGO6nk0N7QazTsIB?=
 =?us-ascii?Q?sAeC8/uaXiqKYjEl6dGI2iSa8lvaHdqXVWOoJToG2GlnIUZwEnmH/hIlxhpo?=
 =?us-ascii?Q?YWn8MW2JFn1JDuD6uRc29dN4IN91rqT+4x+4fuBaoQPPoOWyhEQp7Xt271bn?=
 =?us-ascii?Q?KRIlnGmXdy6u77JMIihc7edqI5jG/QLMad5qS/NN94RsFdWijJc2xIGJBLpq?=
 =?us-ascii?Q?AQrVt9AFEgqzksnyL69Sa1h51pJcJfMzUuoK4WYrN6iyGc8WiLTS6/pChAMx?=
 =?us-ascii?Q?FDZ/YPREtkog+qWOgsxfbGPUZ4yIajR2JBAacqoaDYPjF9lN/V+iU0xGNMys?=
 =?us-ascii?Q?H4u0D2Ouc28mhzzUw55Ahe8s14Jk89q2fGwSQuGZeWt/3coDX5muDpR/T0V6?=
 =?us-ascii?Q?UdhEco2451Bg6TN6xo0W3+tnaRT9saTOwGZT0WmXv/zjj5bY07sUzKMkPsO1?=
 =?us-ascii?Q?wldxv8UiU8KQ5YeJA5hBOb8wIkAFA4EgM60FphCofJMu/k37i3Ttpv0bPJSm?=
 =?us-ascii?Q?V4fxmOvcs3S35SuA8pbAgPgNjjXyybCfldZXsHD1flUlNpKZyzCTMN8QKCbD?=
 =?us-ascii?Q?KIXHOsa76UbENQ9sxIIKUjK5rnRTiiH9OfTBkmpn4iuvojcrIrf5TJVEFRgA?=
 =?us-ascii?Q?oZt3lmauZTirJrWKcBEkylAWAWCc6cM63x8/Xe7squSo0k+waY6he/PL4KEq?=
 =?us-ascii?Q?meQe9cMZEXJr+xCYyjjMRZ4PQXnwOEwXzWsipiTMcjHT3qQiaUhJlpA/eeto?=
 =?us-ascii?Q?gMtpUzdItsuAWa8ibGs7rmSna7J1rVPtV+4B1YLeHMaXDKXvBMXYiQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(19092799006)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?P3nEieoFZQo01xjreQQZbW/2mW/7CGXumADTBnTzcawikmDKVHPN2q9mU/hp?=
 =?us-ascii?Q?kMLsgfD4HuISwEfKhbnnzRcx3s1wNvL10Iu4P3e0WP4Gw6VF4/UB90FCJnJH?=
 =?us-ascii?Q?dvJejFp/IKQfmYprofLx4X58N2OiV4pxZBp7PL0BFN5QBMjRYhIUr+Sn+lQJ?=
 =?us-ascii?Q?FujIRqw1kA9Zxa5QXxTubC77vHK0LIhCPbT1HHBngOHbFu4qRBlauMwf0OUi?=
 =?us-ascii?Q?84l56MeMEq4n0w2f/9GwcNvxj9C1ZU/TlG8CnAou8IyWecrKfYuxAlEROfXn?=
 =?us-ascii?Q?N9QhZEJuhjyVTnySdeAMAF1LCgiLah+S2SBbbot71vz1nr9O2kFljdldS/3j?=
 =?us-ascii?Q?WiT/asBH2F+IuCAn6x2GPWlZzH61yeD7u9pS0NJE4A+pcOtNiEN/MqYnT4wA?=
 =?us-ascii?Q?+y+ZJZiP3fBO2AgX/ZjANsX93ni5FulRxtbHa45Pu8wlEAesAsXr8fWjP+El?=
 =?us-ascii?Q?y3lJa8Ti4cpvZipy69NwvVFLA7KV3j+m5/T/sHkOxkjmr1EtEelOYMmaFlVK?=
 =?us-ascii?Q?pI0l7tbW3nLdPk4TJEzGT6idOkL+6+FLPi87KCdApKnktIOgfLTCOTXVvLeL?=
 =?us-ascii?Q?vcZkOrINDPUTjh48HW0DVaTSqpUpgt4lrhd8XihvMmQrOCRl5yEGSQBWZtYm?=
 =?us-ascii?Q?bvmQEGfbXPtMqaDtXoC5WcMwJpNfzzVbhzglvdKHgQa2tBsS0N+E/9t73HuA?=
 =?us-ascii?Q?o3hnLvR3Ef3YLO8FRkuqMWy/2YsVWOyIP1L6ITXp2JsFZx+CEes6G8CnTdc/?=
 =?us-ascii?Q?CO22KtmRR/81GoKzASRNpJQOPrmEQiH88cg0Wpm9OBToWEKMm4r1svdDoz+B?=
 =?us-ascii?Q?kSweAZPiWYGkAEmcaA0DTHLLVHn7p6EsYRKmCArysqgCm6k8DcvxGPAhdAB3?=
 =?us-ascii?Q?NPLNKnwL1eD6Hsd7MxNqelRSQjF+i2rk1ENqS0FUNPYJLDdU6t5vtmMAfM8T?=
 =?us-ascii?Q?xbg4dnIRRH5U3sXDHmVxwZIlEnf+T/DGpOIU9MEJwTQfJKhT4nBTwGS3AL3W?=
 =?us-ascii?Q?1NG5VEdkbR445MrCsMlqd2bijnvl1SiqQdybXl8IJBHx4mHbHxPuQdxtVIYZ?=
 =?us-ascii?Q?Ctdk2xJjJC7tjhp4+dqVYcAA0xg6/x6OnCWaFAKN82vgqbKBQcyHjJ0RcWQO?=
 =?us-ascii?Q?mJvsjN7/r+kv25+C+6LlgMO9/d17H/PZOSbj0M9np4hgoO3hWi1IQHI7CvzN?=
 =?us-ascii?Q?po1nA5jSc6/8WaEl4xy+0xFK7Nxj0DRuVLl15uE6/+GoKp6y+2NoXri0a3Iq?=
 =?us-ascii?Q?DhaTPcowJ3CNBty8Sa5wWa5FDMIvC6hZz0CzOUXJFsmuXrzDPWlszQICento?=
 =?us-ascii?Q?LZIarWqol41UmaYNb9vEBolyHPBskfKqtXME4JlVYZtKBSGFf6rcXxr6KeZX?=
 =?us-ascii?Q?QfBl1OIpsmHtUdffGJ3v5Z+cinbPudBk1sC/QU6a9t3ZSmU7THvse7mYaxrU?=
 =?us-ascii?Q?NGM4a2uP3lFZzFHTQ2gCGrRNvwr+lBk5uQUKEEd6qWU6H/SZDN++iA3q7spD?=
 =?us-ascii?Q?aVkgptcbsfVrkMJQzgvRMXWPA7tYMGH2TF33c7fmYZxJGEux3H5Z+OAWjSyu?=
 =?us-ascii?Q?Bc4w3mfGsQ8RIhToZ4k=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 76909f76-6ba8-464f-3564-08ddc27e53bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2025 02:29:58.2484
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wSqhccFD2/EnmIiXgZ7l/i0VKe4vVLg5t02kHmXK0gP6jSSvAIaTQbfPfQh85ED9SztNxZ3iUekfbyGrN02y3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7633

> > +	of_property_read_string(np, "clock-names", &clk_name);
> > +	if (clk_name) {
> > +		priv->src_clk =3D devm_clk_get_optional(dev, clk_name);
> > +		if (IS_ERR_OR_NULL(priv->src_clk)) {
> > +			dev_warn(dev, "Failed to get source clock\n");
> > +			priv->src_clk =3D NULL;
> > +			goto select_system_clk;
> > +		}
> > +
> > +		priv->clk_freq =3D clk_get_rate(priv->src_clk);
> > +		if (!strcmp(clk_name, "system")) {
> > +			/* There is a 1/2 divider */
> > +			priv->clk_freq /=3D 2;
> > +			priv->clk_select =3D NETC_TMR_SYSTEM_CLK;
> > +		} else if (!strcmp(clk_name, "ccm_timer")) {
> > +			priv->clk_select =3D NETC_TMR_CCM_TIMER1;
> > +		} else if (!strcmp(clk_name, "ext_1588")) {
> > +			priv->clk_select =3D NETC_TMR_EXT_OSC;
> > +		} else {
> > +			dev_warn(dev, "Unknown clock source\n");
> > +			priv->src_clk =3D NULL;
> > +			goto select_system_clk;
> > +		}
>=20
> That is pretty unusual. Generally, a clock is a clock, and you only
> use the name to pick out a specific clock when there are multiple
> listed.
>=20
> Please expand the binding documentation to include a description of
> how the clock name is used here.
>=20
> I don't generally get involved with clock trees, but i'm wondering if
> the tree is correctly described. Maybe you need to add a clk-divider.c
> into the tree to represent the system clock being divided by two?
>=20

Currently, for i.MX platforms, there is a fixed 1/2 divider inside the
NETCMIX, so the system clock rate is always divided by two. Another
solution is to add a " fixed-factor-clock" node to the DTS and set the
"clock-div" to 2. Then this clock is used as the system clock of NETC,
so that we can remove the 1/2 divider from the driver. This method
should be more appropriate, after all, future platforms may remove
the 1/2 divider or replace it with another divider.



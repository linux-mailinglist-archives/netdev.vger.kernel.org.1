Return-Path: <netdev+bounces-129593-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B52AE984ABC
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 20:13:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D49321C2116F
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 18:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C957A1ABECA;
	Tue, 24 Sep 2024 18:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="XtcjqhYr"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013059.outbound.protection.outlook.com [52.101.67.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9952A1B85F5
	for <netdev@vger.kernel.org>; Tue, 24 Sep 2024 18:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727201616; cv=fail; b=Ww+bW/jSj3Iff3iSRBQVLKchTfQs88Q2cYXM3KkYyeQ7+NXduhlAVk8m91PN9MCt635yQzDzUdvD6Za3tMji37IYS62vCYRFc5VelqmyyT2qfP1UV80i53hRtEq5e1xNwmYQplGMZj7vrBzSr4/M4M/ISJC8HjO1N72vndOk8Uw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727201616; c=relaxed/simple;
	bh=IId8id6CJuAhTE/M4f1Hs2Uy15l7IUOvA9KJrGd/fr8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CNlZHm1dQFUPd5ODKcOeOvfbxlXl0/Nc30ZsGb7IJCfc2UUKoOhcgFAksW+0VxfZVxnSnD1mS83TtGlSVtEDX+GZF6TX42rQ9VhIuGD8dhGS9pBXeSmFT8QQPc0iz7NxJZRByGHb3bF6o1L0Q9RSqRJelZbHHln6gHN8rfTy18I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=XtcjqhYr; arc=fail smtp.client-ip=52.101.67.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sGOYFr1cB7vblfz9kyYACo8VQTcho0EJzkwg8biuP01lIgI1ra9EUmep5yxWF+FqfL0vPiYFD+k7GSm/GsDMYsVQzYEpVaqZNiqMcslkYy59WOQURSJVV3MHGGWw3vCJHoRknjpt9lTjSmTWa5o29362bKIW7+VCQ7myZ4Dyu/l4g4ZYjEm2rW2B6EVncgC5LtABbA4jWGpfKxN5ttiguQRZBqwU5WRGS7PObk0Joukr3Oc1x5lvUajxqEzEepi3kBMIdehKxWuKQW+Rz1d7eM90/egsMcLxWVf6uYhfPUOppehDnBdwYdcrUGU7fDfYbrREAxwlXVOZA/QuKoznOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9mKzhTiMhes2PTe1cFyWTpREhSOL9LL4xr8NWdNErj0=;
 b=k4bz+RyNQZdldH0KM/625EnahWafHNyJv7xXVgKOqoZaPJaXxYA5nrWX5HqTnwuJXvuNDr8hbuOjiJpuV71XFEilrM43AWOPLBPVmwwYX8YQMUY8DtWkZrczeRyiusavFiheH2DaP+GUYG1NxT1iCaQ+fK6+xv/6RHjqhEf15o0qTfw6/o3WrQNLfwyUIppAXZOPiSD3AdlHaC+4JBvPuFS3zbbmsR0uri9j3qgPkfjqjADqSfkQLMGkBmap+Bj2ZFw6oL2eesPv/EEo59AZ9nVIrsAiytNEzJQTT0Qqp8+OJda/8RMfQydxbw6FSJ5rkzO8thyPXgQmGJ3+Za6kWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9mKzhTiMhes2PTe1cFyWTpREhSOL9LL4xr8NWdNErj0=;
 b=XtcjqhYrUzTmDA1SH1YR9whhs5mVaB3I60saPzdGfV0NCqyNmSZpAJztnpOE9O2JlFGv2eyKSDwDASapEdMYV5eZpQ91loLuxpDSq+o3K5vzsK0bSi3HA/HGA6GauqXmKbPukI/7IKAObcKJPWYFwQmBH1KTDDSACFlF0UB5JfMgi1opDYSoIi1tjqupMMtYtFAX37sPORq6cMWkCStQj0l6Jmy3lGGkvjuQEH+sTTDkKYJ04rEJtl+HTC894DdpbmXKj7dlVvV8Kb+xFIJ8N0X7mZXn4WPMP0jUw7Z0IP3ShxJxAoNsqmJak4dd4/SH2PiB040Ueg/QHJfMP02/mw==
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11)
 by AM9PR04MB8356.eurprd04.prod.outlook.com (2603:10a6:20b:3b4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Tue, 24 Sep
 2024 18:13:27 +0000
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::21bf:975e:f24d:1612]) by PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::21bf:975e:f24d:1612%3]) with mapi id 15.20.7939.022; Tue, 24 Sep 2024
 18:13:27 +0000
From: Shenwei Wang <shenwei.wang@nxp.com>
To: Serge Semin <fancer.lancer@gmail.com>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	"horms@kernel.org" <horms@kernel.org>, Alexandre Torgue
	<alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, Ong Boon
 Leong <boon.leong.ong@intel.com>, Wong Vee Khee <vee.khee.wong@intel.com>,
	Chuah Kim Tatt <kim.tatt.chuah@intel.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-stm32@st-md-mailman.stormreply.com"
	<linux-stm32@st-md-mailman.stormreply.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, dl-linux-imx <linux-imx@nxp.com>, Andrew Lunn
	<andrew@lunn.ch>
Subject: Re: [PATCH v3 net] net: stmmac: dwmac4: extend timeout for VLAN Tag
 register busy bit check
Thread-Topic: [PATCH v3 net] net: stmmac: dwmac4: extend timeout for VLAN Tag
 register busy bit check
Thread-Index: AQHbDq1z8pUOmzp+VEWMWWK/FnEpiQ==
Date: Tue, 24 Sep 2024 18:13:27 +0000
Message-ID:
 <PAXPR04MB918588AD97031D9548D24A9B89682@PAXPR04MB9185.eurprd04.prod.outlook.com>
References: <20240923202602.506066-1-shenwei.wang@nxp.com>
 <fcu77iilcqssvcondsiwww3e2hlyfwq4ngodb4nomtqglptfwj@mphfr7hpcjsx>
In-Reply-To: <fcu77iilcqssvcondsiwww3e2hlyfwq4ngodb4nomtqglptfwj@mphfr7hpcjsx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9185:EE_|AM9PR04MB8356:EE_
x-ms-office365-filtering-correlation-id: 3de3a1c1-3fcf-4106-db3c-08dcdcc4967d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Gb330NNF+r3vVToz2o75bBv9mAYmv+P0OgUNrEnQbHNYReuCzhrpU2yzdRhk?=
 =?us-ascii?Q?T/WVmFjyvSbYdIKA3iiwPq5i1MQDQWlxfmBuiLPLR88jOj2y4z4K34Dw7FXF?=
 =?us-ascii?Q?fTZbdn+8GP+kX4xNDrXWqII3zPzhdEeyNf61XmcS8qtEqVKj4ilWg82oGiip?=
 =?us-ascii?Q?iCpQednAUHhRKRYwzHqy4l4eiNIJZHgtE/YXl4guST1NFNuTgDjc6ySXse7j?=
 =?us-ascii?Q?sWXZ/eX1WolBXO/Cy4ir01X9Qo3/WHhf0BpaKa9+rAFfhFvSTGt8MHwQsfBu?=
 =?us-ascii?Q?FBL7QTn0o2v8WQ+TCVU9wqrgC7BunrbRKO6axky9Ys4kceGvqustnUw6ZhGs?=
 =?us-ascii?Q?45nqX81Xij/vNUO4sf3DPwrg10ts24db8p66Y1NMSe0dq91AoAu7NSPptHs/?=
 =?us-ascii?Q?hoI7KQ70EfAI+q2tF2VCHrSaYK3Nj5xxyUXxPb4/KZlcrHJd9bta+rtRbPkX?=
 =?us-ascii?Q?iZUCTVsO/YKROk5exi9jbf0EOSmMhEqELOFTjN949ii7kjXCnZdFmW3Mm/XS?=
 =?us-ascii?Q?QFUESWhpWNYATvLdsy4CBd7oGivvJXxKMC2ptwaG/807t2KiNu30z1/GN9fZ?=
 =?us-ascii?Q?1dLGaqDuxOoigm83Swn85fH8amb9ukNcwYzFfsz2quML3+9fFYT/62DENl+F?=
 =?us-ascii?Q?dioGPS3s+bmoH4ZzRdSV2w3S4n0f/veA8FqOUDGp/DFbGCwf4i6Mp80L6mfq?=
 =?us-ascii?Q?hV90NuHPqcyKespF41fUpz/+35RRCm+ugbJTW1uV9xTu1G9OXy+PDLd64iXQ?=
 =?us-ascii?Q?9hEjWf5mJ+4VYyrer6sjhKXDUFXzxjiUwWor/UdcspUraBBnLESNLWejYHTQ?=
 =?us-ascii?Q?brRsDheq7TmXvJBw1aF01gytcKrLfjhaIuIh5kPbpci+4C+sN7VjtjE9dvhz?=
 =?us-ascii?Q?VAEQdN9X2B3KKNVSFz+xKJHM3OG/LqtbRzzkj5etclwAwXpRfzQXcFVVE53d?=
 =?us-ascii?Q?D1tBZbiYLblF+V8Ia7EbSSBEZe4KX9YIGC/M2+nuhyP7i/uEz3N/RwKt2TeE?=
 =?us-ascii?Q?eTXOeRE4XImPLFM7g03yCKOchd2a15UoLbauDTq8O6h7a910P/4syB/LvvnI?=
 =?us-ascii?Q?0HKoLj2tjs3xQTBNo6l6PFAutaysFo/WR57O18R4w7a/MtLqC5oIBztvewCH?=
 =?us-ascii?Q?Fc/rgu/b+zFsdrYGnkdsSigS0I+Zg6C9EvU0tICzhnQIh4Kr5SfAU2IlRQeX?=
 =?us-ascii?Q?v1BFFEpPWm2R3vc9fT1AdUmYF6CkxpFN0i18d/tCCGy9P993uKERjECcTp/d?=
 =?us-ascii?Q?RaBAR2aSAVsZ4bKCtpqOoBotSTEPYtmh93E+1GbaJ+Dd3pcrVyh3HnF/Cg1q?=
 =?us-ascii?Q?8y8e7ZUf3yAnKJwUmtuaHyZx+bjuISvqrcjuxZPivQo4XQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?PGI4KhTWx1xtctoiNmuYIyZzTywSR5EUskSD0npHHVIHjQncPSmYpPepZxHX?=
 =?us-ascii?Q?oLAriBk9Ld30GsFYGjvUjbliRuZGFB/RlfBZ5t5WNyqpOLNJkiZ7fUG8/+Lx?=
 =?us-ascii?Q?JoCFZjIM80w8/wVZZMxcwskL7RcZJ7RsX0RVXexJ5skKDdxkhg9gg6OAOnxo?=
 =?us-ascii?Q?UUcWttSoHajmBwYCECcrx+RCBbPIejESLkqAzaIg5Cttx6mYj1VmfAUon/xy?=
 =?us-ascii?Q?qi0nrDSpHKJIL/3wp22bB1BJqXEQOAO3AFIqlXvm1bHif9pSAPA6oTPuDUZD?=
 =?us-ascii?Q?zUJ/EezCalvi8N739o9FP9pj9ZKeq+1PgWg7FlWV+bFRZN5jGraCOyT0uqrd?=
 =?us-ascii?Q?Gao6GbjQELqhU3rge2RcP0AA91Bby9uX6A0kV8UhixwF/AxNTiO1buMQXfx4?=
 =?us-ascii?Q?OlfgavhWyGWiSCDRZhX0pVdWQQ2lgUaE2tQZ+8wHQnNwEZQeTCEUOtulqp4e?=
 =?us-ascii?Q?RfCk/Cs2/Re4IJ2uhWag95GUFe2vqjl1PvkQpBv9Z6+f/iUgjmn/Iw0ue2FB?=
 =?us-ascii?Q?jZd8/V1oHPk4t7Iex6aIs6iG4q/XG6z7HFPcNdQXO9PoM5aW7yyNpXq6hzc7?=
 =?us-ascii?Q?9mwzNLYJ/9ffslo0y42tFjaGNNeLUFduJO4846NiIdA0JAusklQPyes/Qr2R?=
 =?us-ascii?Q?gcM2sJ0+u1h/c+CJAcIKymsMvBbGHmxWL4IMVv8Ayq0Q1O8dMM6/6aC7Obn9?=
 =?us-ascii?Q?STwZJL6rN47RNiOgAh7eQVglTYKfGgkCQw+nSsJieS/YFgpyFtmLKjpmISuy?=
 =?us-ascii?Q?4c1Dgt33rUs36wdbyx0I7WD1TzON/QJDvuQayiZY4KqKEIGJoyzjzoDP4XuX?=
 =?us-ascii?Q?+h0RjqQrlLnjmMJVcno9Fha7J6hVw8oU1nqaqx217OsmqYsCus8XNsUljNgY?=
 =?us-ascii?Q?cC5BFv6xAaKjB7KPftCv6ewk1v5ZCmqSzn2DYQ1iG9xt+bU6qHz95NZRjYwI?=
 =?us-ascii?Q?KimHo/MEt1bxWohC0J1PR3F6Ddt78M3anUvivmCxYnNCsNg3GRL4DwIVr0uN?=
 =?us-ascii?Q?M6OorbAZrKwhbmPhFu46m/dqSoLkjNNYPeXq4drgJ//uDU6oxcB0kGbHoL/y?=
 =?us-ascii?Q?862MaEZvSQnkbZ/mwDEGwZQKV4iYNELQONe/qHFU8f5FRSBa0az3evoNJCgR?=
 =?us-ascii?Q?VJqqUIsNAWXbTYXq7H16zgHs+H8SMbRk00/mf60lWcPJNB0a8VUkkDpk9U3h?=
 =?us-ascii?Q?f6E3j5BFkiuwWZgOXYcwgG+78YAzgcIjY/nC8NsYLsrW+T9SZBq/gS9Yw9GF?=
 =?us-ascii?Q?lFucRBFSB0l6ROLNO9JXBSVmQ5bXGTKZW5csmolnAXqwGiIowRvRIMmi7bNY?=
 =?us-ascii?Q?XETl9/aHJflp4ahtzlpGW21wn7dyzSQaE6nHVZCUscVcpUxcx5f9NpthX5+A?=
 =?us-ascii?Q?pdDZJHf1AlZWpC7aougZQ64JLbUCgZTxaORIadfhgMsHsaj3AWUAe0S3Ws+t?=
 =?us-ascii?Q?JuekUSlsgNFpNhrlZSfAfTAczJcNDcT3YlE6YD6Bfw9i6SsPPBykTIh36SGq?=
 =?us-ascii?Q?up1A7H5Q3xi4vNzZf5XFKsd2y/rSICMalj/f0SOnYpULWpHt+gw2cr5XwmQJ?=
 =?us-ascii?Q?50AIR8VkUFadvLVPFURmoyVC4Y/ry6xlhCHyjjRj?=
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
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9185.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3de3a1c1-3fcf-4106-db3c-08dcdcc4967d
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2024 18:13:27.5931
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d17nC532y3qTfMNa+I39KjnvrVTMbqrnTMZ12M699vcFrvGfgQUVlhdynKu2sZNdeJuhZhbuIAqIeFT5cPU+nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8356



> -----Original Message-----
> From: Serge Semin <fancer.lancer@gmail.com>
> Sent: Tuesday, September 24, 2024 2:30 AM
> To: Shenwei Wang <shenwei.wang@nxp.com>
> Cc: David S. Miller <davem@davemloft.net>; Eric Dumazet
> <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
> <pabeni@redhat.com>; Maxime Coquelin <mcoquelin.stm32@gmail.com>;
> horms@kernel.org; Alexandre Torgue <alexandre.torgue@foss.st.com>; Jose
> Abreu <joabreu@synopsys.com>; Ong Boon Leong <boon.leong.ong@intel.com>;
> Wong Vee Khee <vee.khee.wong@intel.com>; Chuah Kim Tatt
> <kim.tatt.chuah@intel.com>; netdev@vger.kernel.org; linux-stm32@st-md-
> mailman.stormreply.com; linux-arm-kernel@lists.infradead.org;
> imx@lists.linux.dev; dl-linux-imx <linux-imx@nxp.com>; Andrew Lunn
> <andrew@lunn.ch>
> Subject: [EXT] Re: [PATCH v3 net] net: stmmac: dwmac4: extend timeout for
> VLAN Tag register busy bit check
> >
> > Overnight testing revealed that when EEE is active, the busy bit can
> > remain set for up to approximately 300ms. The new 500ms timeout
> > provides a safety margin.
> >
> > Fixes: ed64639bc1e0 ("net: stmmac: Add support for VLAN Rx filtering")
> > Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
> > Reviewed-by: Andrew Lunn <andrew@lunn.ch>
>=20
> > Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
>=20
> Please note, you can't add the R-b tag without explicitly getting one fro=
m the
> reviewer/maintainer/etc. Please read the chapter "When to use Acked-by:, =
Cc:,
> and Co-developed-by:" in Documentation/process/submitting-patches.rst
>=20

I apologize, Serge.=20
I made an error in how I utilized the r-b function here. My intention was t=
o explicitly=20
include you in the next version of the patch.

Thanks,
Shenwei

> > ---
> > Changes in V3:
> >  - re-org the error-check flow per Serge's review.
> >
> > Changes in v2:
> >  - replace the udelay with readl_poll_timeout per Simon's review.
> >
> > ---
> >  .../net/ethernet/stmicro/stmmac/dwmac4_core.c  | 18
> > +++++++++---------
> >  1 file changed, 9 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
> > b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
> > index a1858f083eef..0d27dd71b43e 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
> > @@ -14,6 +14,7 @@
> >  #include <linux/slab.h>
> >  #include <linux/ethtool.h>
> >  #include <linux/io.h>
> > +#include <linux/iopoll.h>
> >  #include "stmmac.h"
> >  #include "stmmac_pcs.h"
> >  #include "dwmac4.h"
> > @@ -471,7 +472,7 @@ static int dwmac4_write_vlan_filter(struct net_devi=
ce
> *dev,
> >                                   u8 index, u32 data)  {
> >       void __iomem *ioaddr =3D (void __iomem *)dev->base_addr;
> > -     int i, timeout =3D 10;
> > +     int ret;
> >       u32 val;
> >
> >       if (index >=3D hw->num_vlan)
> > @@ -487,16 +488,15 @@ static int dwmac4_write_vlan_filter(struct
> > net_device *dev,
> >
> >       writel(val, ioaddr + GMAC_VLAN_TAG);
> >
> > -     for (i =3D 0; i < timeout; i++) {
> > -             val =3D readl(ioaddr + GMAC_VLAN_TAG);
> > -             if (!(val & GMAC_VLAN_TAG_CTRL_OB))
> > -                     return 0;
> > -             udelay(1);
>=20
> > +     ret =3D readl_poll_timeout(ioaddr + GMAC_VLAN_TAG, val,
> > +                              !(val & GMAC_VLAN_TAG_CTRL_OB),
> > +                              1000, 500000); //Timeout 500ms
>=20
> Please drop the comment at the end of the statement. First of all the
> C++-style comments are discouraged to be used in the kernel code except
> when in the block of the SPDX licence identifier, or when documenting str=
ucts in
> headers. Secondly the tail-comments are discouraged either (see
> Documentation/process/maintainer-tip.rst - yes, it's for tip-tree, but th=
e rule see
> informally applicable for the entire kernel). Thirdly the comment is poin=
tless here
> since the literal
> 500000 means exactly that.
>=20
> -Serge(y)
>=20
> > +     if (ret) {
> > +             netdev_err(dev, "Timeout accessing MAC_VLAN_Tag_Filter\n"=
);
> > +             return -EBUSY;
> >       }
> >
> > -     netdev_err(dev, "Timeout accessing MAC_VLAN_Tag_Filter\n");
> > -
> > -     return -EBUSY;
> > +     return 0;
> >  }
> >
> >  static int dwmac4_add_hw_vlan_rx_fltr(struct net_device *dev,
> > --
> > 2.34.1
> >


Return-Path: <netdev+bounces-248792-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 74818D0E843
	for <lists+netdev@lfdr.de>; Sun, 11 Jan 2026 10:47:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4A129301CEB7
	for <lists+netdev@lfdr.de>; Sun, 11 Jan 2026 09:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEA72331A54;
	Sun, 11 Jan 2026 09:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="XYatEM5a"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012057.outbound.protection.outlook.com [52.101.66.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C181F419F;
	Sun, 11 Jan 2026 09:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768124501; cv=fail; b=QijBZRBok9NDp4ce42fg5pAMTqkFkRhAcETZ6bvOgVrV5iytQuAdhmBJk35Lz097NGmpuDgQpy6JM2F4qkw/MiqxXIp+shwOa4mmIq9JIu+brWI8SvqJeL1bWVYc8aFfIyBlWMbHwphd25KVf1ALUSlS0jmEW6TGOiLjzVpDoKY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768124501; c=relaxed/simple;
	bh=e2camJ5lgJM4FJmxdPZqFJEYOWJ0akQbhpgf1gpxr2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=vBBkOcJRUEExglTlFqjMa2e7Lnrs3AsYAFBSyj8bk0itM8u1OmQ/2vnORE/fhW7m7cjf6OuOfAoxFOs5gmvxwBEjl2JwVNvuDA3JgN5CIhWaDgeuOMrneI3+G4kq237takvoSNDcZ/iRDfOg6rQFKIrRUPiUTSQkCxsv68X+pDo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=XYatEM5a; arc=fail smtp.client-ip=52.101.66.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VhKDh55Q8Xfd3Wz11JTKQTOWKKo128tGWf/4DRCVPqq0D023L9qesRu66OOtwI/QmXYNU4HGIbTavrQJfY091CYwazhci+NmP3IosAGR8e/PwYw9aKA0KMCpkAZZtBoPgb6xD11jP+Q6E7+a/Irfu5mJd9dyin/LZytvYba6QasU4MY1qp+SNbgXLfyMDHpOfeCmm9V78EQclTtTz2ZsMX6SJFbluzLRbCuyjKAHwS2QPYhkQkfXckQlZ/g5frmZptQswk7Gipyyu4rb0qSV7Msyn41FbLLazh11z2UEKufi4/A4K35IGkcz/o7zCpGHL41mqt78XV7Ke8JIhm7g+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aTAmZ/5tqjmnEV/2MiGo5IWWUzc0YCXJAidzq74XjOQ=;
 b=YCzdY7ktQxyqu0Flxmc8o6U9XOQlDlU6hYsIz/5tIICYYNLVSt4FLNLk8sks6hjy6mpUJAfkCFFitBJ9chCrOEFszm8PXgf2OFKBiL8t35QJYWyQqJjXyfkKPFmn67D9PZ/PcCfQXxOfnYJoyzD1bn0OgHtrXipl4GTn4saAhIxnEnPbyYL270WdDBFqnx+Thv1+Rl9z6X/jNbWvB92e+aWpScSGvW1N29m33RwqB4uIaTjh9k91XLtQ5yT9IrPVTR53LGtBJwLXMOsu35hgGtGQvah6Jnb8+EF+hZGkD75Pjc0nWv3YUCR9cef/qCHjbv+8787jTuX7Sl/cc8N8xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aTAmZ/5tqjmnEV/2MiGo5IWWUzc0YCXJAidzq74XjOQ=;
 b=XYatEM5a8Bp10WEdyM/YLgKM3LFq90k0F/2uGrm+dVB84asvhlYCvawsDPXndpyXFzte8XbgH3RmfDBFiQuYvyRi9rmTwXD/RKfIFSlhLwq+KMiUik4QQkv5txWmewM8nmdtvV9BddU1MQEA3wajFVdEDI7PUoDJ35cCf3f2+ex/JfwVli5Cvv+uOh6SPJO02U/I3bdGqYG9d9Doe3iGW9eIXSepiYmB3/9DCeoccmq1rXGoXtR6gocaOAzJVe3chVL/w1zMfYTXLLpELl4r6vykOMqG7O4lBEJqUL1ClM4rGtl78lMQah1OSoiIKcQ2Ar0S9ed0yMzFbteqDzsdZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by AS8PR04MB7592.eurprd04.prod.outlook.com (2603:10a6:20b:23f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.6; Sun, 11 Jan
 2026 09:41:15 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9499.005; Sun, 11 Jan 2026
 09:41:14 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-phy@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Daniel Golle <daniel@makrotopia.org>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	=?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Eric Woudstra <ericwouds@gmail.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Patrice Chotard <patrice.chotard@foss.st.com>
Subject: [PATCH v3 net-next 10/10] net: pcs: pcs-mtk-lynxi: deprecate "mediatek,pnswap"
Date: Sun, 11 Jan 2026 11:39:39 +0200
Message-ID: <20260111093940.975359-11-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260111093940.975359-1-vladimir.oltean@nxp.com>
References: <20260111093940.975359-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1P189CA0004.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:802:2a::17) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|AS8PR04MB7592:EE_
X-MS-Office365-Filtering-Correlation-Id: 23914a17-3738-4912-3f8f-08de50f58fea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|7416014|52116014|1800799024|10070799003|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0AM3NsNcYNmTab5oZ/Xke9cdM26406FjdriP4qWBzK80T1uny+rwhncJufPU?=
 =?us-ascii?Q?hE+2g/jDYv3BR0JmTF0+lEL7EtAos5AHiSOLasw78amFKvfa6TDwnsRrEHNX?=
 =?us-ascii?Q?G8amZIDnU/OqI+LbugXAHBL2EZ+PEIrnwEyax4upwYFhdNakhTgM4eYRMYGp?=
 =?us-ascii?Q?N33/YQFj8toLOYTGM+3HjFBhCjNaiqMru014cTQxGgfGPesDgpGZOfVNoasW?=
 =?us-ascii?Q?K69Ug4UZPfUQGXHetnhWzaAZdpALwkYi+H13coqlUhlkDa/Fbgc5W0/ld/SO?=
 =?us-ascii?Q?aPTfYE4lrpz9yRSikeZq3MWLTmXICo/eGw53wRXuj44hO4gIuNtogrGSNJa7?=
 =?us-ascii?Q?kgwkrYMwpOgx12VCVBJiNS4R/Iq2VUTdQoKQTDW2CqpKeW/HYlwJrO8O1rL8?=
 =?us-ascii?Q?slaAUcE7SOOxmYibXAoy7xEqTbCj4VTkojOkQHGSH/O2P8iu4WiP3nqr9cVP?=
 =?us-ascii?Q?E3aZABBeJBW8qlOMWiTRfBPM2P7N93JnRuJCopt2iAgu6QW9bunBG9DWgYLZ?=
 =?us-ascii?Q?Ujn+RNltECoUJV9o59ofopuv3/4VV0/G9TEyWdVia542fTBjTzclgul7fYni?=
 =?us-ascii?Q?O+2dePk5x2kwYYRR5SqlMZHmFgzIl+UtXnsxFtNfEBfgcQCHXkX/BmJC8pn4?=
 =?us-ascii?Q?JedFsLYfdVjXho7IIXf/iae0ecCoWk/kAEBi5GFl2b4ZHNwp9WJFUU1fI8+S?=
 =?us-ascii?Q?z2zclCGTO6GXu+xMV8lDfrHR8KLU/u3UcLTwjCiTEilzLNewNpFpSk6iEUR0?=
 =?us-ascii?Q?yAiIP5mJgRkKq2aSJtm1RK+QkrJmYuSLskQgOGf2/kqDsdwl7SeO3rjG+vCA?=
 =?us-ascii?Q?L9QTTG/Gh7U1aI1QjaGxJzrzgKTDnyYXRsg1lC0eBey19XFj8NSaFLtXz35r?=
 =?us-ascii?Q?qDCgtet5W+Q2VzmPXgj50zQr7A4mJP9p7a8WEI97GGtgXleLphNDVZiJwTD9?=
 =?us-ascii?Q?Z6djR89rtnLbexPAA6A9yBUNQpyk2IwamfSDwLmKznhPvVUjkoVhtK9FB1Zg?=
 =?us-ascii?Q?Xhk91T0Lh+Ma1kA397jX3UEQ+nv3noDQWhe6+gFFBh+LufKccbqjP0PCK3bC?=
 =?us-ascii?Q?NFO5AJqru5CdF7ZVdUO/I+vSlAMUJqcsqaoSbibGLwvZokPFtcJ7KUmIKvna?=
 =?us-ascii?Q?wMVe9hv0kTTGDn5F77akpL1Cx6qY7kZMZxo6yIXbdCAmLl/nP4ZLM0U//Bnd?=
 =?us-ascii?Q?z4Zg563nrtfQjPqijU80XbD0gbiVIYs+hbpaAwaQo7B8WjYLDz/7Smo5PfMJ?=
 =?us-ascii?Q?0TAj8HXeirJIL/U1q/s6WvGHiEhrIktt3UYqvl20uAGq6NhGJajEpUn24rd/?=
 =?us-ascii?Q?JXWyneNvjMZEHRcyq+DaPpz4+HC6afSjInEOP1MjQAjxTwZWyL+fmyg8Zt9C?=
 =?us-ascii?Q?3U+oTx3lHR7cgmgNr6KWI3Had/w5psV5OQyCaRLpKPUxFq8rFf2/gQJFa0Hj?=
 =?us-ascii?Q?JCfcuYcc+mmmv52s+17HxIKC68CVO8KueVI1VsPWLc+fjlFG24mhSw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(7416014)(52116014)(1800799024)(10070799003)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jhAcsCXyu1hhAVATM7Oi9YGcZEHHf4tRAIBgH9VhmQ/pbOop1zOvtFxT0YMo?=
 =?us-ascii?Q?+RhqG2BDGl9ezOzOgB2YoxiKgpYPrk4J/GVt54mClJwaH0nkmLZNBJpSkEBT?=
 =?us-ascii?Q?loPgQyju5Wp0EE42J5hOQyE5W9Fh9OxXNkqNqNT/mFVYLmeqamQXekyI7IMg?=
 =?us-ascii?Q?gBDIS3B+EMScISEfyccF1g7OcGvnsm7UKgPuKYhxH6j0X9BKEAiO1qIe3qQW?=
 =?us-ascii?Q?CTQ2ThD9uMr0p0dW93hSL+T7m0Y41TiEzRgSnTSvJmrpJSBF+VohRdRE2igE?=
 =?us-ascii?Q?490gpLTfTPcXNVhh8oVfyESERwS+NeYzTiWiu35GEt05eW7ag5Vp4LQVtubs?=
 =?us-ascii?Q?9YJ9N0aXaAB0Oj+uBA3Dqu7qnwlbsnHW6I+QQfwGh0h+aNsN4dlXfCcAKcyv?=
 =?us-ascii?Q?nM0DCdkN1lR6Cu60rbKxJTE70toQqbDVNW1c3yjsmoGNAbEUgwJyG9XBDkwh?=
 =?us-ascii?Q?fU05eoSd7W4hkev+clqhcPIZHkKknHsjvkOmd8jFqA9c52ug38jJomZ5mhSX?=
 =?us-ascii?Q?TahpvvCbqFT42dvybnfYFTTa3BgByi8VE93Ii57/2QyplEUARJDwoN8wCI3d?=
 =?us-ascii?Q?oe7q+hbuNbxi03iTB9mrVRpt/vgRSfx8S4H4dwduwh7aPbKvvi4r6vzD+AL9?=
 =?us-ascii?Q?Lp/IhhBgTJRbR0PpUZczkQw2XhkE6zSe0DPZ9pisLeKPtmLlQP2lrDFqJgRB?=
 =?us-ascii?Q?QDU2Jr/8EHxvM9cN+Lu7XNFBPZLuk3R0hbxQ8/6NU+sVFWhpi0nF3/R3gXDp?=
 =?us-ascii?Q?Off2Bbjx0WYfJ52+QKAFVPzEKK85K1njMedbwCno5s7FkRm9MVjYE2nKb7fX?=
 =?us-ascii?Q?h/zNht0JDdFTQ4tcyq3kRGdIqAGh7FiyuA8F5KUoNH56wuVz4HcGSCekhB5v?=
 =?us-ascii?Q?Mf8q7xrpf4Bl3PqpPISIhgcafFLpxk7psbICv/SmJZi4WjZvAR+rf17NvmK/?=
 =?us-ascii?Q?QPFnFbtE6xoA59ut0q9qJtEdNMCSs107+xbLI7UcmgjFTx3rnJelfW3aKrMI?=
 =?us-ascii?Q?tWaJUQ4xIL6EVMkqffFczCnCxLekOyKN5eGn8Sz00S7HRmp251yp4aZyRGsf?=
 =?us-ascii?Q?nCV4kwhkpud2SEK8fxFXaSJ1ydDpGJStiqTjtS2IBWro8r+onVThh6UgoJ3r?=
 =?us-ascii?Q?c8/UOlYOIYTRhGY6Iov/4oan8oNYDoOw6sJwkPaEqFZzO0W68mUROzlbgShh?=
 =?us-ascii?Q?atjlasuYz5OurGxqO2ymWlKPNu4vyW5O8Qu7nXVneMRWM4dx7YFNjIEz9fKy?=
 =?us-ascii?Q?t/Pjv0vg2xgZcd8ZGsu6GKbHHcA4EIp6zaIHH8Giu467z0C/OFDNwuNuulD9?=
 =?us-ascii?Q?WMo/s5ddj7JY28jTkCEgLt4vym70zVJYcVuSYpnh1FOGlbZH7BG4FKKbpRbP?=
 =?us-ascii?Q?6tb/L9hJilyns3W11BwnVv/P54cHI2nYUkylJznXcs/DjwBseGAlpXXgP7QQ?=
 =?us-ascii?Q?52vA2FTq4vS8JKun1uVy8Ug5XlrMukoN5lDus8LGTP247ws00lsttQ5fIQCB?=
 =?us-ascii?Q?03Uo2aIFbfpVdzZsH3/+XjMeo76xXbTn5kiHOkeOfh4t5fEaWdsI2S/VYNju?=
 =?us-ascii?Q?kQ388ZFelWzW3KYh+4mCrqwrVnaBBD/N55NzaVkEMgzycEkjUhFSGqd5IlTJ?=
 =?us-ascii?Q?hcB6IAgHC/K/ZpB6aaZZgrNmrbM4xc0LvGctUKY8Vp4IB6YJrFYlP7YwhJk4?=
 =?us-ascii?Q?6MjVNrlNq7i3zXgB29RGssiqRMuAeTUUsW6TkWzbE/W3bRf0g+gp6rakOFBF?=
 =?us-ascii?Q?y62KOCEpuNFxfc2mCt/3dZ99g/HwL9oko6wmSmVQrqLXCTirCPIa4LrWniI/?=
X-MS-Exchange-AntiSpam-MessageData-1: 3r5i+xguCCqBr5GDstiOcTRfm2JtpqZ2hfk=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23914a17-3738-4912-3f8f-08de50f58fea
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2026 09:41:14.6229
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /0SUqxY/kLdZSwuv8ux1a903thKISnMIV2957ctETC/mpfIeR/IihmU54p7X5SzXbsRYQ63UMzX83k+zW3JKiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7592

Prefer the new "rx-polarity" and "tx-polarity" properties, which in this
case have the advantage that polarity inversion can be specified per
direction (and per protocol, although this isn't useful here).

We use the vendor specific ones as fallback if the standard description
doesn't exist.

Daniel, referring to the Mediatek SDK, clarifies that the combined
SGMII_PN_SWAP_TX_RX register field should be split like this: bit 0 is
TX and bit 1 is RX:
https://lore.kernel.org/linux-phy/aSW--slbJWpXK0nv@makrotopia.org/

Suggested-by: Daniel Golle <daniel@makrotopia.org>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v2->v3: s/GENERIC_PHY_COMMON_PROPS/PHY_COMMON_PROPS/
v1->v2: patch is new

 drivers/net/pcs/Kconfig         |  1 +
 drivers/net/pcs/pcs-mtk-lynxi.c | 50 +++++++++++++++++++++++++++++----
 2 files changed, 45 insertions(+), 6 deletions(-)

diff --git a/drivers/net/pcs/Kconfig b/drivers/net/pcs/Kconfig
index ecbc3530e780..e417fd66f660 100644
--- a/drivers/net/pcs/Kconfig
+++ b/drivers/net/pcs/Kconfig
@@ -20,6 +20,7 @@ config PCS_LYNX
 
 config PCS_MTK_LYNXI
 	tristate
+	select PHY_COMMON_PROPS
 	select REGMAP
 	help
 	  This module provides helpers to phylink for managing the LynxI PCS
diff --git a/drivers/net/pcs/pcs-mtk-lynxi.c b/drivers/net/pcs/pcs-mtk-lynxi.c
index 7f719da5812e..74dbce205f71 100644
--- a/drivers/net/pcs/pcs-mtk-lynxi.c
+++ b/drivers/net/pcs/pcs-mtk-lynxi.c
@@ -11,6 +11,7 @@
 #include <linux/mdio.h>
 #include <linux/of.h>
 #include <linux/pcs/pcs-mtk-lynxi.h>
+#include <linux/phy/phy-common-props.h>
 #include <linux/phylink.h>
 #include <linux/regmap.h>
 
@@ -62,8 +63,9 @@
 
 /* Register to QPHY wrapper control */
 #define SGMSYS_QPHY_WRAP_CTRL		0xec
-#define SGMII_PN_SWAP_MASK		GENMASK(1, 0)
-#define SGMII_PN_SWAP_TX_RX		(BIT(0) | BIT(1))
+#define SGMII_PN_SWAP_RX		BIT(1)
+#define SGMII_PN_SWAP_TX		BIT(0)
+
 
 /* struct mtk_pcs_lynxi -  This structure holds each sgmii regmap andassociated
  *                         data
@@ -121,6 +123,42 @@ static void mtk_pcs_lynxi_get_state(struct phylink_pcs *pcs,
 					 FIELD_GET(SGMII_LPA, adv));
 }
 
+static int mtk_pcs_config_polarity(struct mtk_pcs_lynxi *mpcs,
+				   phy_interface_t interface)
+{
+	struct fwnode_handle *fwnode = mpcs->fwnode, *pcs_fwnode;
+	unsigned int pol, default_pol = PHY_POL_NORMAL;
+	unsigned int val = 0;
+	int ret;
+
+	if (fwnode_property_read_bool(fwnode, "mediatek,pnswap"))
+		default_pol = PHY_POL_INVERT;
+
+	pcs_fwnode = fwnode_get_named_child_node(fwnode, "pcs");
+
+	ret = phy_get_rx_polarity(pcs_fwnode, phy_modes(interface),
+				  BIT(PHY_POL_NORMAL) | BIT(PHY_POL_INVERT),
+				  default_pol, &pol);
+	if (ret) {
+		fwnode_handle_put(pcs_fwnode);
+		return ret;
+	}
+	if (pol == PHY_POL_INVERT)
+		val |= SGMII_PN_SWAP_RX;
+
+	ret = phy_get_tx_polarity(pcs_fwnode, phy_modes(interface),
+				  BIT(PHY_POL_NORMAL) | BIT(PHY_POL_INVERT),
+				  default_pol, &pol);
+	fwnode_handle_put(pcs_fwnode);
+	if (ret)
+		return ret;
+	if (pol == PHY_POL_INVERT)
+		val |= SGMII_PN_SWAP_TX;
+
+	return regmap_update_bits(mpcs->regmap, SGMSYS_QPHY_WRAP_CTRL,
+				  SGMII_PN_SWAP_RX | SGMII_PN_SWAP_TX, val);
+}
+
 static int mtk_pcs_lynxi_config(struct phylink_pcs *pcs, unsigned int neg_mode,
 				phy_interface_t interface,
 				const unsigned long *advertising,
@@ -130,6 +168,7 @@ static int mtk_pcs_lynxi_config(struct phylink_pcs *pcs, unsigned int neg_mode,
 	bool mode_changed = false, changed;
 	unsigned int rgc3, sgm_mode, bmcr;
 	int advertise, link_timer;
+	int ret;
 
 	advertise = phylink_mii_c22_pcs_encode_advertisement(interface,
 							     advertising);
@@ -169,10 +208,9 @@ static int mtk_pcs_lynxi_config(struct phylink_pcs *pcs, unsigned int neg_mode,
 		regmap_set_bits(mpcs->regmap, SGMSYS_RESERVED_0,
 				SGMII_SW_RESET);
 
-		if (fwnode_property_read_bool(mpcs->fwnode, "mediatek,pnswap"))
-			regmap_update_bits(mpcs->regmap, SGMSYS_QPHY_WRAP_CTRL,
-					   SGMII_PN_SWAP_MASK,
-					   SGMII_PN_SWAP_TX_RX);
+		ret = mtk_pcs_config_polarity(mpcs, interface);
+		if (ret)
+			return ret;
 
 		if (interface == PHY_INTERFACE_MODE_2500BASEX)
 			rgc3 = SGMII_PHY_SPEED_3_125G;
-- 
2.43.0



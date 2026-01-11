Return-Path: <netdev+bounces-248789-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E3767D0E811
	for <lists+netdev@lfdr.de>; Sun, 11 Jan 2026 10:44:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C82803058A3F
	for <lists+netdev@lfdr.de>; Sun, 11 Jan 2026 09:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3365A330B2B;
	Sun, 11 Jan 2026 09:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZgYW2ABq"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012057.outbound.protection.outlook.com [52.101.66.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ACD7330678;
	Sun, 11 Jan 2026 09:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768124489; cv=fail; b=dPMsmwV2F9+MfIQZXwmZLt10xoK/JLUg+3WOB5ddrwKxoSHs+dOUbV6+DMloBOl8EpEE7Act6L/SdqW2uWV1k5m1D6XbkCAZ/aqeHoqKg7pgIJ7hQIVTs3jadJdzrUUalch+6aQ35dhPoaNISkyfxjvXGPWBwlNF9nTtexQBtgw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768124489; c=relaxed/simple;
	bh=bE1bBZhAhdqHUieSZDoaN7fAVNyBUZEL0p/Z0G5WW7s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nrpzu6e9AY9nlRUL3+mN5SMPl8m8VQypS+hWTRhtmaVV0eYNFHiCYQ/ud6TYL/Xb7lBk+N330/Z7aS1pThtFbpr4PeDtpF03QcixB14ChMGlNhERpZ7ubXsmlwp4MSZW9M5fZtv68Hw60imbF/LNDLtkI7lgZ93wXKwBcfmIyL4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZgYW2ABq; arc=fail smtp.client-ip=52.101.66.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lbTywzpm1gqVoxuG+xL0DjoXZrbOMlRXOf85acxEvUA/yrtt5S5ozzGa0Ixos6UZTMVM3XdCRTcYwlVA/eRNxdjZnlF636VtcRvH9rTvAmtKOsWamRSamGRTzonSO8hNvy83Cl/kBVZ/ECdIkYZOq1f0wptPxlan86LP5MHDhV9ClUE6v+qfVUDHm4mFSrr4cQVVOd2nBnD+ZHMSM/924j5+LjrLsIwahScI8BHfuDoTu2HKXlAjPg7ccXaa5bA56Ybe6ajb2HUBFtL5yakO3Q7q7mltbpaNA0i3Q6FuntblCsr+wOq4RnAHGkvvUTMQNFTg+JTQOy9P+g/jF5oXDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NArgE9NrSpiWIqx8n6fMKmdiS6b2Oy3KRwqmYnPUzM0=;
 b=WeUdnhixEett7WaNRkWNRARxQXz9N1ztpHl8NYtqpdpfAhLjDuoR7BDqi1zT7dngXG4lqoqs/cQkyaSAC2FOYgGczqsQKWYU+F40asD2kJh8OXpk5950VwFvMCIYrvXf5qq+FHXw7ydLBigWOok3LPZHuy3GpcPqRNx0mFscNRp50GZ3HaETlSoSxZdD/JTxH0ubGg9ujx91otbh5deRwVYhj2pioApAeOGwcDJ7znggbFvncMcs0Hu15NzPnPT/yUMlVqR+Ab+GsADjNJ+ckl3jnekNK0ssHeYM0mhYpnTZFzsAwKAB2cphWVG3PT6rbwPm5/q4/TCBlRPzn7RzAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NArgE9NrSpiWIqx8n6fMKmdiS6b2Oy3KRwqmYnPUzM0=;
 b=ZgYW2ABqFIMxYeRteoPOf4Xlk2JNOjncUJlpjUmFpznYvA3mL5WZwzGXvGCIaS5MEweHwYUBIv4s6rUku1qc1JPoXPaW+ahZc1maZ3YUMJs0KlhOXq+xLuRona6l1xyczF4DTaeoXnODldu61bCSzy1onzKEvHA8NXDUaGc55dPaYGEX0u4s82PczbkrgWKvHmdi7zsui6W4FVjG9fR6d62Mbsmm6KsQYRiM3N1StJuiPU2105TnIXCWIe0CRtBEqxQjgcaQ7xtcEWLZf+YQUjaAFSca8cOwZ/vHso3j9tbBcTuFFMm3xTocR52vGSl+UXAxI+LwU0J9j2m+Hfl5sQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by AS8PR04MB7592.eurprd04.prod.outlook.com (2603:10a6:20b:23f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.6; Sun, 11 Jan
 2026 09:41:09 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9499.005; Sun, 11 Jan 2026
 09:41:09 +0000
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
Subject: [PATCH v3 net-next 07/10] net: phy: air_en8811h: deprecate "airoha,pnswap-rx" and "airoha,pnswap-tx"
Date: Sun, 11 Jan 2026 11:39:36 +0200
Message-ID: <20260111093940.975359-8-vladimir.oltean@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: eb4789f2-9164-41fa-e1e8-08de50f58cf1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|7416014|52116014|1800799024|10070799003|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DGWjuE+m6j8zUL/YAZ++3jGc8VQvKhxqLJ5kxoZ0QMCtlNC36CjTAc5kr0Sy?=
 =?us-ascii?Q?9gCvCYJ+MkQ7fFyUXUCOr1eHxYQhop2nyh6/sqR6RHeDoJ6hnxusTArxE3KT?=
 =?us-ascii?Q?VXZw1uQeM15kKAF52e7i5edrrkq7c3q+LVIPHQzKtsi/T/ZEY2psirsqhYyw?=
 =?us-ascii?Q?9/OBTy4awCp03nw4nwYTSqlp4Nr1gQwANNPcHxRZLZuHRYaT5ek/gFwvacCH?=
 =?us-ascii?Q?AuuB3ezoQFig8eqqBKDlG5L7RlcnjV14gNaAW4Ofzdb2NZ3Cfqvc63/jo4DV?=
 =?us-ascii?Q?svWpvbaaCj5TKem6ICq+jCj8pT5uy+qK5hIwe9ZWyUOmvgJDO+UtY0sKqT43?=
 =?us-ascii?Q?Jf0rp8X7QhArcOkcw3N7iqZ8EKjv9+QulL8SBvUyAdV1Uy84QHlJLXUd4F2p?=
 =?us-ascii?Q?avRd+HnsqLuzc9oT9WhdEU6f1TFQKm7lKxFezsCAKU1TZoTJAxIG2tfV3T2q?=
 =?us-ascii?Q?Wgj0oz2ZV+RiHfq2JdE7YeYjUqwZDhZW0ItSAMpVjgzbEnsRtflry6YyxbaG?=
 =?us-ascii?Q?F2zUdMVrHrkZmE1Q/EuzQPXANLmANZja90MO1ajckOIcFT7RlQMArww+auIV?=
 =?us-ascii?Q?bNKxk6Z4rav/0d7QVknKpYrLC8a7lMcWoi2wXdgD7Utk30D3S2PzQmLuya93?=
 =?us-ascii?Q?WsJfg7XW6s3iKi+8dgFF5qDVBWxfxM4t/rMNvJK1Nt8JdhRK1hVFK1Cqokjb?=
 =?us-ascii?Q?seWkR1MkPNJ1czYAe4e1PC/no3hxnVfR8snaL9NylTSzjngHmewXPjOavwPs?=
 =?us-ascii?Q?4Z2EK1Qr7/zc6dfrRM7ZfyMnXtROqWUQvUTJiawrx5fFzxHRab/kqSx7tY7v?=
 =?us-ascii?Q?EvQMomhy0N5TCvc3cXbvIEEBNgs4dO2grjLQ6UmhgypzEvtrcqkme13njD81?=
 =?us-ascii?Q?Lw/SYXY4Vmppmn6ekIMWkKVCR5gnFhbof0Lv1fFpFKstDLHq87I7tpQ9/GZ0?=
 =?us-ascii?Q?cY0ecl5G9o2HTHBtk/+gBi8e2Jh38ihTU11xy3zjencp0f00XJg01VFroaiP?=
 =?us-ascii?Q?dyPfnWL6oMt+LGEjzIaCvQBTIHnvLsnvcZnlEt534zZPGVzufpnotXhBBBRF?=
 =?us-ascii?Q?aOqb2NzQfr13AQRb5rMVh7yp83CaPFCD2gAcq/r8PlAUbxKp124amwUs+VQw?=
 =?us-ascii?Q?n7LYMxDJmx5zuxtXLBiWaaMqCYasE7Iuwoqjkoc/O7NtK2/ycbMJ4rz8c+NF?=
 =?us-ascii?Q?t7RuP8+xii/JPfeGlW+RzTxIlj7/WlwF2CPqtQ/ppqzHfQHXi3pgnzRs2TEs?=
 =?us-ascii?Q?m509QhcdpR1RHJ5nYzhfrxqBpZ+FJir0xubFzEAz7BPTLMyGntpr3MJ9Qobc?=
 =?us-ascii?Q?0YP+ervLvFrs3AnFaBfV1r1ogJH24r9i4E54cdC2QmqvFjhDV7yBFSsBwTFc?=
 =?us-ascii?Q?+jTF25zQeWkgP7apoOjHfdWXKVlRSJmmyKMcjxeDlUnjQjhxbZQyCXv1Pye4?=
 =?us-ascii?Q?1+sGEB2DewhHOTsR/09akHRqys4PLtQ2?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(7416014)(52116014)(1800799024)(10070799003)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YCb8lofYiGreHdl479X7mpE0qUbX6+riNXKfwozCa7ac6I/KqYxJG2UfiRTf?=
 =?us-ascii?Q?mKAT9rVrAVYkxS9EIE8JwQacFCnAjRlgLDlxaYaONPJL0zxTyjudX7AfeQ3F?=
 =?us-ascii?Q?FhK99gDdybFbA1sk+RRozNGIXgY/6yB2cXzhUIrVNuit4Z7YdrW+qi0F2/yU?=
 =?us-ascii?Q?/MAanAEC+uTBm8PbBhQSxPpT0oe4Q6eukJTwrMG+o0G/o+/dZ8oo7BgvxnAx?=
 =?us-ascii?Q?mnYttQ2/a1mjGIO5MBo2ylQaTlPb57gPWFl9QjxYCKcmJym9F0j+olhDwdzQ?=
 =?us-ascii?Q?YoNXsDrcLdPmfS2yZO/y+Mg9ZXnht4+G9iIk5sd+BBc/r49N1WkMZYsfcfnb?=
 =?us-ascii?Q?wicWr/MF21PKcMdAj/O0zR+om5/ngj7CpaCq9N5k7kzTGkir/vLg/ce2l7/q?=
 =?us-ascii?Q?YuVJghmu1kLe5Ka8UsOEAK73SHqhpYczzYD5g+mM+9KK+B0CVajIF+y4Rzck?=
 =?us-ascii?Q?byPby8OVO9ZmHwYBurVKAnnCxrFRFs/SiuQB6PFP4Tt3X4loguQ/48k16bLq?=
 =?us-ascii?Q?YCJTX7hW5lB0A8+UIJ7W9Sa6tD0IVTta/GqdN/8UK0a+aQ7vZ+npB1k2aH8r?=
 =?us-ascii?Q?euD3IUG0kZqDKRzNUDXFamfmB7ljkCbeAVxBlIjC3wRAWAfiBdY/dnBOnsEF?=
 =?us-ascii?Q?k174Gr3yothNAxlMNKhCkckx7SXJQz5JFqwSeajXDsI98ycNKFqEUbWq6C8n?=
 =?us-ascii?Q?PXknlMFrYYovS0gf/8sk18gGS/XUDioPXMK3g967Lu7sBtoI1R6hfri+54X9?=
 =?us-ascii?Q?V5hs0WKlDCHrncZlR1CJi8be8SoSHWFWEb+WccpMYhfWSSKmQRUL+q23dNJy?=
 =?us-ascii?Q?uY+eCq0YTWBgPNynEL73ETpJsQLjphZvTK6oqbkD1qjSMb9C+07fVBXvJDHq?=
 =?us-ascii?Q?3HWPui7saX7Q3Pj3xulLUEJhSfbnxlgoxirbnh0QQMEFSc2t38AjDtt4WOPz?=
 =?us-ascii?Q?XJ8kTjlw1PD27FR7+sOkGq5bRHP4sEcbxMGE+GyvoIT2CqFC0TVeCzoJ2nTB?=
 =?us-ascii?Q?fW6yxpEQWaMGbMUTZMp1Y2uQNYGISvoyP+bmalTvVbQx5iQAmKPt/vAhp3LW?=
 =?us-ascii?Q?ShO8Po7ta0RASEeSNTjx4eHQjxfM5h5WWLEV/A7Dl0NiTM3yw3PWLNlqiLL/?=
 =?us-ascii?Q?+FNnDaNTNw+ix1RnhNttiJ1CNf40I1wx5V5bjHfFU6HoNK4ouc5OO+hqpm1p?=
 =?us-ascii?Q?pnQOc6flAkXeAUhDUzSzxHP04Lsg8ewQiT1Z2qnp8dlHKtmCWCeTwBujprE5?=
 =?us-ascii?Q?JWLYVc/Hi8tILoSSR55SZccHgPGUJVwtzADmw9Vf2Cr7lRa1tZsXWt85lO4D?=
 =?us-ascii?Q?ev3TYP7Ws2+fJZ7RE/YfIa8BFtjYX3uKPBRNHjQMY7QbYuIs6VAY8sWOIo/7?=
 =?us-ascii?Q?TtGdFMozrPanRPL5p33dCm8pGpTawmqcA58xjPG5MSt46UZR4P0Ev+2FNxVM?=
 =?us-ascii?Q?WdHhiiM24VhUISAAqf3Wv6vWOq8mqfsF54/FtBb9RXky+3Opi2wwnRnssQKS?=
 =?us-ascii?Q?j3bRoHpbZMNZo/cvxrKJFjy+Bc29JhUW9V39jvpvd6MawZ/WonU3UQAdwgqQ?=
 =?us-ascii?Q?Js+vdgURUYpqYmyqiZVOL2GyrvaakR1Oja6WLpCtq+KiEwwHIN9xuSufauAN?=
 =?us-ascii?Q?/IWM28KBH4qlfJfUX4E+5ArKPZi6hHd9DwGfiBrwn0zZ6xHXyqZuJKZP0t60?=
 =?us-ascii?Q?6MAXjapTd5EeQftIjtUD4MYi9f+Tq31l7gcSTKZGSdnZ7yCBwX5AN4FebHSq?=
 =?us-ascii?Q?gt1RoxpmiC8artcvkD65kwGSyrc+twjV3X7yPWGZxkAuFyzv4E0MyyyoWrwR?=
X-MS-Exchange-AntiSpam-MessageData-1: GOurBUGPA9xS0JeD4Y4WHwxEKFY4QnPLc5E=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb4789f2-9164-41fa-e1e8-08de50f58cf1
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2026 09:41:09.6329
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HNbZ/cp5gbDVvdmdtpDwtVPfqksMmaPSN5901F/81DLab3ZDKV2E/bz91Svwe239lTjxQhKXp8zoU1fsavtP7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7592

Prefer the new "rx-polarity" and "tx-polarity" properties, and use the
vendor specific ones as fallback if the standard description doesn't
exist.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v2->v3: none
v1->v2:
- adapt to API change: error code and returned value have been split
- bug fix: supported mask of polarities should be BIT(PHY_POL_NORMAL) |
  BIT(PHY_POL_INVERT) rather than PHY_POL_NORMAL | PHY_POL_INVERT.

 drivers/net/phy/Kconfig       |  1 +
 drivers/net/phy/air_en8811h.c | 53 +++++++++++++++++++++++++----------
 2 files changed, 39 insertions(+), 15 deletions(-)

diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index a7ade7b95a2e..7b73332a13d9 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -98,6 +98,7 @@ config AS21XXX_PHY
 
 config AIR_EN8811H_PHY
 	tristate "Airoha EN8811H 2.5 Gigabit PHY"
+	select PHY_COMMON_PROPS
 	help
 	  Currently supports the Airoha EN8811H PHY.
 
diff --git a/drivers/net/phy/air_en8811h.c b/drivers/net/phy/air_en8811h.c
index badd65f0ccee..e890bb2c0aa8 100644
--- a/drivers/net/phy/air_en8811h.c
+++ b/drivers/net/phy/air_en8811h.c
@@ -14,6 +14,7 @@
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
 #include <linux/phy.h>
+#include <linux/phy/phy-common-props.h>
 #include <linux/firmware.h>
 #include <linux/property.h>
 #include <linux/wordpart.h>
@@ -966,11 +967,45 @@ static int en8811h_probe(struct phy_device *phydev)
 	return 0;
 }
 
+static int en8811h_config_serdes_polarity(struct phy_device *phydev)
+{
+	struct device *dev = &phydev->mdio.dev;
+	unsigned int pol, default_pol;
+	u32 pbus_value = 0;
+	int ret;
+
+	default_pol = PHY_POL_NORMAL;
+	if (device_property_read_bool(dev, "airoha,pnswap-rx"))
+		default_pol = PHY_POL_INVERT;
+
+	ret = phy_get_rx_polarity(dev_fwnode(dev), phy_modes(phydev->interface),
+				  BIT(PHY_POL_NORMAL) | BIT(PHY_POL_INVERT),
+				  default_pol, &pol);
+	if (ret)
+		return ret;
+	if (pol == PHY_POL_INVERT)
+		pbus_value |= EN8811H_POLARITY_RX_REVERSE;
+
+	default_pol = PHY_POL_NORMAL;
+	if (device_property_read_bool(dev, "airoha,pnswap-tx"))
+		default_pol = PHY_POL_INVERT;
+
+	ret = phy_get_tx_polarity(dev_fwnode(dev), phy_modes(phydev->interface),
+				  BIT(PHY_POL_NORMAL) | BIT(PHY_POL_INVERT),
+				  default_pol, &pol);
+	if (ret)
+		return ret;
+	if (pol == PHY_POL_NORMAL)
+		pbus_value |= EN8811H_POLARITY_TX_NORMAL;
+
+	return air_buckpbus_reg_modify(phydev, EN8811H_POLARITY,
+				       EN8811H_POLARITY_RX_REVERSE |
+				       EN8811H_POLARITY_TX_NORMAL, pbus_value);
+}
+
 static int en8811h_config_init(struct phy_device *phydev)
 {
 	struct en8811h_priv *priv = phydev->priv;
-	struct device *dev = &phydev->mdio.dev;
-	u32 pbus_value;
 	int ret;
 
 	/* If restart happened in .probe(), no need to restart now */
@@ -1003,19 +1038,7 @@ static int en8811h_config_init(struct phy_device *phydev)
 	if (ret < 0)
 		return ret;
 
-	/* Serdes polarity */
-	pbus_value = 0;
-	if (device_property_read_bool(dev, "airoha,pnswap-rx"))
-		pbus_value |=  EN8811H_POLARITY_RX_REVERSE;
-	else
-		pbus_value &= ~EN8811H_POLARITY_RX_REVERSE;
-	if (device_property_read_bool(dev, "airoha,pnswap-tx"))
-		pbus_value &= ~EN8811H_POLARITY_TX_NORMAL;
-	else
-		pbus_value |=  EN8811H_POLARITY_TX_NORMAL;
-	ret = air_buckpbus_reg_modify(phydev, EN8811H_POLARITY,
-				      EN8811H_POLARITY_RX_REVERSE |
-				      EN8811H_POLARITY_TX_NORMAL, pbus_value);
+	ret = en8811h_config_serdes_polarity(phydev);
 	if (ret < 0)
 		return ret;
 
-- 
2.43.0



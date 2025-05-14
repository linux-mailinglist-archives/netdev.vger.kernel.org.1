Return-Path: <netdev+bounces-190483-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09E68AB6FAA
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 17:26:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9AB517A6E16
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 15:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDE98283FCA;
	Wed, 14 May 2025 15:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Am/LjUsS"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2068.outbound.protection.outlook.com [40.107.21.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290CF19341F
	for <netdev@vger.kernel.org>; Wed, 14 May 2025 15:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747235991; cv=fail; b=iu5i60au4AweV4U90M4NokxNwpo8uOGyxOZrHHKdPriwELHQEFP4zgzyfjSLVb8KexZe0mWpf4RgqdIVvj24MOBZxFi8B8iSlJciDfgdRsNbjPEnqjz37XQsfMZHa4a0NnDzyrCVPic30TTc+zBLaKH3BEvDDs2mCJi7jlAxusk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747235991; c=relaxed/simple;
	bh=uRKNDEyrQVOnbG35058zI+xE98auqkDA37RURLbKTm0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=YqC/6HCSSnRL+5ZphhYdwJAXOcxsE886rJoHcujm9FubzZuYWH3uh1/Hnvz8pYQD39jeUpOgOOjPjDz6ufAKzReAROtOyYXccI1RXXpqMuwExHTAG9Am66Sa/wEUo1SS61nroeaQOl76TTNrXe0ZjemMOKjFnlEXtsdygMTh+4s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Am/LjUsS; arc=fail smtp.client-ip=40.107.21.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ysa5NPcLbzZA1Ed4MsLj0ar+w9hZPiDHkaRT9EQK+5STZI8v5zlQPg6acru8kHhht0p7G5OuhqgtCtLuzVuI9+ThUkoz557Gd8Sn7tQGsuZaVnljzvb/SkQdl9zxOWqhuKC0qlNiZLyJChHMJ53pqCLWwescgeN+SfsJJG129wijvy4oKWjvnMk9ec5p9gKb22zyOaJevQAjtPDVlg1tvlm/D0wEaULFJOfVXwbs1FzHwNQ9VovvD4cgpN9MVw07javgzjE2NF/xY50PQ8/FYkuWly3jjCw4tfOE5MRPFrji1Uy74Pr8qsLj39TV+bEZk2NeNS6KZIQM30rqpA4IyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aUL3m2n17oaVFk9kBNzcSttAJi2Ub2E+qNcxwD/VZwY=;
 b=StSBXoB0DccT0MHmYCwYu1zif35++37svNlyVHQwm/9vR5mTmrFUPO8Mhe78ivXg1XUbn05pbFi1HNaw+1ksJyr1MJdr7xX+YqSOHf29y9hGUdMZXVqUScbhH2Iyt1CH7gIJMAZrIAOR2SgxyK2UPpdDYs9F9a1b++I7UYwSN0OBNlXwrQFnVtRoQXY2Iu7emLvlMs7kXTyWajnSDwB3Bjb3jKnz7vUZHHhw6BOTp/dE3oaXKs5jxUZJT58KF0nwa4ihCsuQsXlTv3kJsh5Yv/PPiPhBCXbbnPBZIBYUaUHV7pkdg0THbA0DyasrSTo1YN48Mku65VhhEwjLwRMMEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aUL3m2n17oaVFk9kBNzcSttAJi2Ub2E+qNcxwD/VZwY=;
 b=Am/LjUsSuv8iVWf2a/I5+x8MvLto7vUOyBXS+5vs/W0B5QsIa8YtfbLmIaxAsOMsjk0PeV8cTCrqUkc8egvJZWK69GALimR60U5Iw4wZFKW/2BRLaXnM9qu/bPBP71k9f2qjOllzjS8MlHV8U9OtXYOUdFjoMhGKPTdYMqE0ATEtmGxelo4XXQ1DJxQPvhaH14bEcb2322+43JPMoL2swZWkGNNdS5kgOpVkFNOJCmIsCJhNMYdQ/EJtiMNrtxSZzCoikNmIiZ2Qy9p2G+axMEWQPFWXgi5fCQHXBQgMPYXq1H/PEGGIUC8gwfLiohjsO+iqiAQSWi5Qt1Cj76HwkQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by VE1PR04MB7231.eurprd04.prod.outlook.com (2603:10a6:800:1a9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Wed, 14 May
 2025 15:19:45 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%4]) with mapi id 15.20.8722.027; Wed, 14 May 2025
 15:19:45 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: Bryan Whitehead <bryan.whitehead@microchip.com>,
	Raju Lakkaraju <Raju.Lakkaraju@microchip.com>,
	Vishvambar Panth S <vishvambarpanth.s@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Richard Cochran <richardcochran@gmail.com>
Subject: [PATCH net-next 1/2] net: lan743x: convert to ndo_hwtstamp_set()
Date: Wed, 14 May 2025 18:19:29 +0300
Message-ID: <20250514151931.1988047-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1P190CA0018.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:2b::31) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|VE1PR04MB7231:EE_
X-MS-Office365-Filtering-Correlation-Id: 37d90105-e5aa-4543-2323-08dd92fac1e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gafqzPEX/orgIeMvqq5cyu5PLWFcuQ0WmRDLXErWAiI0cg2GsatKOWKmQxO7?=
 =?us-ascii?Q?2c+DLeHm8qa4w6omUpeMwONTmh477Eqxg7Wtpn/MINV/Oh/yVlsKcDYru2fC?=
 =?us-ascii?Q?wJ1wNKlgeiEtF4w5o6UO3VfSPM3QGRLx2xmIGQiYR4O3vqpKfAdhKONCpoOi?=
 =?us-ascii?Q?SdR15EXaurZuX62gbPU1JGWubY2rydOtlKxHwkLgLuWsSNHJ/M6qxRvxTs8y?=
 =?us-ascii?Q?ufhiH859RW5mdKVWff6pK7qGg7rHX3GD+8hxzq/wCNBHNTj1oDpOIUI7PKU8?=
 =?us-ascii?Q?tXSfo5KWVMCHoAJoDrG8JFBnNTMDjE0gelrNzRlF28nBYeiBtaklD1kQUdfr?=
 =?us-ascii?Q?wmrzdNdjZZ3+eRPP+RAYUISnLJUlT4Q1o+VK/GzZsz42T4ppIH4H08IJcUwf?=
 =?us-ascii?Q?g4MK4A9LKU/KmLN1JZt6Zs51EDZuGFvfzIbBCrfhaSayIFzpNn7oXv7H80I4?=
 =?us-ascii?Q?I1g/Dqz6tSZRyYR7RDikOt/CtB3mlxUCx+iOtZe3XNdbZO8uRhitkVVWoaFW?=
 =?us-ascii?Q?zMElZ+1WCW+n9dYiQLuBQ2mOnHFwO+w3UK1kdVuK02l6IhBNT4JY+dHgcK4+?=
 =?us-ascii?Q?2AM7gY5onWFWvwVWZNoesuzlRlPl2luaFHvScRYkV1Yx6yDpl7S0AXdTwZOq?=
 =?us-ascii?Q?sGsxf7JM1RiQP17woDsSZmYRYXOloECbearVT9La86pcV5lLl2k95/F56AFL?=
 =?us-ascii?Q?xUqJpHHhsvkGxE22qW46WW2KBhwRCw/4f5QDy6eHWrBR/XocFFFHTd8qtjef?=
 =?us-ascii?Q?qM2OUzeLaMymy+XrJ9vbWsYmXOxYyfCVJ5dxL8HFjqET/nwaQ2BR2QsZxHiU?=
 =?us-ascii?Q?tSO3fOJ8dDc2PeMnVqFOxED/GoYOF1gBHbBux245nGfFxxsjOIUvmXoynVPp?=
 =?us-ascii?Q?vNEKFvdeikhWmhUjhHP+XAoW5Zt+omaUHXj4CsddpXK6R1OT92GsJxRYdyxG?=
 =?us-ascii?Q?ojDRsLUcwweVksDeBVwAKpmu6N6FgOetk9QhHIbWOW6YlitmT+jc4d0bk6JQ?=
 =?us-ascii?Q?WkJTLQFKl6wMigxSUw4OBIt3irQp7VsWEU+ZSmKMqKLF3SuaNhByDsVF3MX2?=
 =?us-ascii?Q?9jjdp21EhCG7bBXneE6DQY1tBLzqnjuqdMTT3RMZ1//g0+EGvxShg8f1lss4?=
 =?us-ascii?Q?/N3mxxr7sNJc4oww3bjrQDpI2S8By/SmL8fJjcw3zmbKG6uA7uxMZT7qMqzs?=
 =?us-ascii?Q?w4ykhm1lpla2P5VnldCXiUTMglpBcbf03UZRXj4MFByawjcfJo0+D0FKPtne?=
 =?us-ascii?Q?r/9Z5XV8SeIuLrZlCxdllMxM6X9w1onXJumirXPv2YGaezrSM70W7jK4euCD?=
 =?us-ascii?Q?eqTn3JR82bXGtyZHmInNo126b0j5ib4BI18gXHUwUnh94F55ekcJFN4UoRHC?=
 =?us-ascii?Q?JZEvWcp+ihqSh6wFqcN4BUivs5etRN0OM6kNkI2Edk/gOLCpRaG8C0jqaWCR?=
 =?us-ascii?Q?YEgHc12FxIMfmbyiJ5xGwc748Ln7AztnhziD2d9UowsQG4S8PG6zuA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Isyy+RhzR9hkkyOE8ULcN3q7FWv/GtHLNyIE+ujtSh4ZRVjS1bDRvIBQ0H62?=
 =?us-ascii?Q?xGGXOZLKX2qgU1nps4Dh+qDp2wXUqYHb/NYiK2D2fRJoqvesR8UKsZUryDS7?=
 =?us-ascii?Q?3epQKw24bcILzOAIqKf2swDbqYzO12e4fyuNqxP1CZjwjieNnjBZWxrpioI0?=
 =?us-ascii?Q?cgNTfeJlWwbwILsrDCT93OgAXYCPDBVr2F+anxkNXp0pQSV0rRnTo6gROvRE?=
 =?us-ascii?Q?SRCIq1ZkGzvIzqmCqV2Rm5IXLuYjNTH4I/dvUff5XLDKIOvKaGYfRnhs0G85?=
 =?us-ascii?Q?eKPoVWFFLMg8ktmnVOJSlGGtHW8MuKFkN4sUTHe/rjXEsK9Vszj6rEAsojmd?=
 =?us-ascii?Q?Il5f1qF6BSKG+hWTkSF6Z5wst9RqacgKvdxPDrd6sgdcoh39ZT7y0IxWYGpk?=
 =?us-ascii?Q?YyKDt+H4zj6Oy78aCfIC8Ac1qOQID9hiXs04MudL0WUauJwVio92IAl8E3vF?=
 =?us-ascii?Q?pAf2mCdJukmzDZPHpmE2tGBXIPcIyllffrhfFxFCOf1Fce1m37gCIRjK+eHf?=
 =?us-ascii?Q?NS2P4pNKVWFgEaKQDmKa8a5vKXxzzPxYD1w1XJahpciN8Ev8UCxuk13QijSl?=
 =?us-ascii?Q?EVBBkUEDX7mxWHBx9PBNEGtrWmxHqMif/8+KbZvgHNouct3MI409XWJIZxde?=
 =?us-ascii?Q?qCR3Slz+65jHXjUIbWw9VcJaCdJsYhLtZpTRCctdZhqTOQvj59areDu7cAKj?=
 =?us-ascii?Q?Evdw/WKVjln3411mKiBcg5oKqQhufSiQ7H/edlYOoZ7QOZJQCAj+HnWwjI/H?=
 =?us-ascii?Q?xOqagvyd7rxptGzMoz5Jh12t5ccikEdD699NIww3oP6QuTX9ql5cg0nmnhOY?=
 =?us-ascii?Q?ri74HYvv5gHxgHVcpbcSFmq9yvdKHGIbHZLB9o8jzu3HyJx0Ya7Pckr2WbGy?=
 =?us-ascii?Q?Pt0SgkrtkcCociHgGwMyouDoHdkBf+OY2aX6ogQTa5Y88w0zqwzMKCpF22E8?=
 =?us-ascii?Q?rwKfL03m3gwhmfkVORAApkBuaAKsqhZPkIPaur22U/IuLYVY1U/6Chnl9tL5?=
 =?us-ascii?Q?fpiTKg9sg1tUL3e4u3EVWcYjBBqKp4Mn/5mvjTjlyEXy5wTqtEsWczIYldCN?=
 =?us-ascii?Q?oVST2ULeHoVAuDrJDX6MbOkhT+QqQX0PucHelNQWNWAKQOdTnTZl2pyhTOyc?=
 =?us-ascii?Q?tDPbiMd9GBkoamZ1APCLKeOyRyeNHBdPjLtgKVxmrySUJ6mdMOeYMtqXK/Ga?=
 =?us-ascii?Q?nq0QhkbgC66UUHyaoRA+jA+BzqiCrOAuHacs7maZLISChgrb11U+VKarZ71Q?=
 =?us-ascii?Q?6net9J6qZZjkNlxGOC7kGu7PaY+BgGB/1YTyBLsVYyGG/lTNQIRgXNlIusGs?=
 =?us-ascii?Q?7kGn6sZ1PZxcW5TZ6G9vfO1mVlRou3wNI78zze/AY9wn4sSAwEEqh7OfEu+1?=
 =?us-ascii?Q?eTE9dv7dJoG0XM7vHnd94bcIsA6q6ulEKmmJJHzi2sA1lh5+351SflWczH0B?=
 =?us-ascii?Q?Elw0+jE8xYMBDvOuuaeoneHnD6kdQQRmG6GPb6MZOi20BYCGL9fgCy68uOHl?=
 =?us-ascii?Q?ICKaCf8qFGRufSt98c7m/rQn1u50upZAOal1qLGKwxF+Yar3cZYTMgdufFrd?=
 =?us-ascii?Q?ZXLM0ek11/wAUtIJQACeH1gPvnVAJjBp+oGDmwlOUuxHquY59tDVzq5sZwAG?=
 =?us-ascii?Q?Wg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37d90105-e5aa-4543-2323-08dd92fac1e3
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2025 15:19:45.0526
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DFWVl+9F8SJmZWeVbRfytkvvW3cYzfl/MQPNYsNDeXuNaCsga1DmWFnmOA7u3xDEiOmgTa1dLvxyHhhEND1ATQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7231

New timestamping API was introduced in commit 66f7223039c0 ("net: add
NDOs for configuring hardware timestamping") from kernel v6.6.

It is time to convert the lan743x driver to the new API, so that
timestamping configuration can be removed from the ndo_eth_ioctl()
path completely.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/ethernet/microchip/lan743x_main.c |  3 +-
 drivers/net/ethernet/microchip/lan743x_ptp.c  | 32 +++++--------------
 drivers/net/ethernet/microchip/lan743x_ptp.h  |  4 ++-
 3 files changed, 12 insertions(+), 27 deletions(-)

diff --git a/drivers/net/ethernet/microchip/lan743x_main.c b/drivers/net/ethernet/microchip/lan743x_main.c
index 73dfc85fa67e..b01695bf4f55 100644
--- a/drivers/net/ethernet/microchip/lan743x_main.c
+++ b/drivers/net/ethernet/microchip/lan743x_main.c
@@ -3351,8 +3351,6 @@ static int lan743x_netdev_ioctl(struct net_device *netdev,
 
 	if (!netif_running(netdev))
 		return -EINVAL;
-	if (cmd == SIOCSHWTSTAMP)
-		return lan743x_ptp_ioctl(netdev, ifr, cmd);
 
 	return phylink_mii_ioctl(adapter->phylink, ifr, cmd);
 }
@@ -3447,6 +3445,7 @@ static const struct net_device_ops lan743x_netdev_ops = {
 	.ndo_change_mtu		= lan743x_netdev_change_mtu,
 	.ndo_get_stats64	= lan743x_netdev_get_stats64,
 	.ndo_set_mac_address	= lan743x_netdev_set_mac_address,
+	.ndo_hwtstamp_set	= lan743x_ptp_hwtstamp_set,
 };
 
 static void lan743x_hardware_cleanup(struct lan743x_adapter *adapter)
diff --git a/drivers/net/ethernet/microchip/lan743x_ptp.c b/drivers/net/ethernet/microchip/lan743x_ptp.c
index b07f5b099a2b..026d1660fd74 100644
--- a/drivers/net/ethernet/microchip/lan743x_ptp.c
+++ b/drivers/net/ethernet/microchip/lan743x_ptp.c
@@ -1736,23 +1736,14 @@ void lan743x_ptp_tx_timestamp_skb(struct lan743x_adapter *adapter,
 	lan743x_ptp_tx_ts_complete(adapter);
 }
 
-int lan743x_ptp_ioctl(struct net_device *netdev, struct ifreq *ifr, int cmd)
+int lan743x_ptp_hwtstamp_set(struct net_device *netdev,
+			     struct kernel_hwtstamp_config *config,
+			     struct netlink_ext_ack *extack)
 {
 	struct lan743x_adapter *adapter = netdev_priv(netdev);
-	struct hwtstamp_config config;
-	int ret = 0;
 	int index;
 
-	if (!ifr) {
-		netif_err(adapter, drv, adapter->netdev,
-			  "SIOCSHWTSTAMP, ifr == NULL\n");
-		return -EINVAL;
-	}
-
-	if (copy_from_user(&config, ifr->ifr_data, sizeof(config)))
-		return -EFAULT;
-
-	switch (config.tx_type) {
+	switch (config->tx_type) {
 	case HWTSTAMP_TX_OFF:
 		for (index = 0; index < adapter->used_tx_channels;
 		     index++)
@@ -1776,19 +1767,12 @@ int lan743x_ptp_ioctl(struct net_device *netdev, struct ifreq *ifr, int cmd)
 		lan743x_ptp_set_sync_ts_insert(adapter, true);
 		break;
 	case HWTSTAMP_TX_ONESTEP_P2P:
-		ret = -ERANGE;
-		break;
+		return -ERANGE;
 	default:
 		netif_warn(adapter, drv, adapter->netdev,
-			   "  tx_type = %d, UNKNOWN\n", config.tx_type);
-		ret = -EINVAL;
-		break;
+			   "  tx_type = %d, UNKNOWN\n", config->tx_type);
+		return -EINVAL;
 	}
 
-	ret = lan743x_rx_set_tstamp_mode(adapter, config.rx_filter);
-
-	if (!ret)
-		return copy_to_user(ifr->ifr_data, &config,
-			sizeof(config)) ? -EFAULT : 0;
-	return ret;
+	return lan743x_rx_set_tstamp_mode(adapter, config->rx_filter);
 }
diff --git a/drivers/net/ethernet/microchip/lan743x_ptp.h b/drivers/net/ethernet/microchip/lan743x_ptp.h
index 0d29914cd460..9581a7992ff6 100644
--- a/drivers/net/ethernet/microchip/lan743x_ptp.h
+++ b/drivers/net/ethernet/microchip/lan743x_ptp.h
@@ -52,7 +52,9 @@ void lan743x_ptp_close(struct lan743x_adapter *adapter);
 void lan743x_ptp_update_latency(struct lan743x_adapter *adapter,
 				u32 link_speed);
 
-int lan743x_ptp_ioctl(struct net_device *netdev, struct ifreq *ifr, int cmd);
+int lan743x_ptp_hwtstamp_set(struct net_device *netdev,
+			     struct kernel_hwtstamp_config *config,
+			     struct netlink_ext_ack *extack);
 
 #define LAN743X_PTP_NUMBER_OF_TX_TIMESTAMPS (4)
 
-- 
2.43.0



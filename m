Return-Path: <netdev+bounces-149420-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 568439E58F6
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 15:55:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CB311881F31
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 14:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34B8F21C190;
	Thu,  5 Dec 2024 14:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="RzbyizMD"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2085.outbound.protection.outlook.com [40.107.20.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3927621C165
	for <netdev@vger.kernel.org>; Thu,  5 Dec 2024 14:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733410538; cv=fail; b=s4JcGp90Xqr9xQ8netoal0L7V03r5bFiJYS4HGXc5Fd0xmnGsL8EMz78OPbC8LSVrrcFWiTbdqT/A0cA2OH9M7PZlRvj2g7toVEv8CocpR/OT/rrPlHxysGLBzpCNmJV+b9ApFBmfRfFKuuLzrx27LQKi1Wpnz6eBosIi+UVFzU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733410538; c=relaxed/simple;
	bh=Su63kE4Tlc7E06tbNfggqL228XAIuyc6GeErYwjK7Bo=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=IHfJFBpEvb5c+af/WA2EdH+7gU9+WWNkmB/pDn4NuKFyAZSYZFLmagOa5GAwsV1b37kM70CTJcYzwdl70VUPozFOQGNR+2HCS7vkwp8N/Dx+8lF4T5HEUbodp07J8eXP5ePE7ckHGoJKQSgwZ6wGOsWChi0O4kzliJVHQqmrGio=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=RzbyizMD; arc=fail smtp.client-ip=40.107.20.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iLc136rMEuBHCcmlxBEyfP/AgUfyPZa92l3kvxWIO3wFmIBgcwDZs5mBbVCH31imKQGvVnJgBcNwCgpIi3LVKuvAmOaNI6L1iYoqXq3VpSPPLVAkkeSzHz4BnXmF+Pwiq7NpM3ndeNFHBdw1BfTD/ziklrFsqngGTl/OhUCZfFjXUpofXXuDVJZ3y/6K1Pnz1YNfELBumUlqM8Y7PSQ6gnr66jyAnBhG5xB46BRdjIScVWGMPufuabTi02r/PcgTx5Ntn6WbWr0UG9o4iqWQRjIEiB/76h07DBfxZTX1Pq1d/cEMQQDusWFU0OV2iiwbmmIW3SIAdtyrffcmP/UIhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/D3TaNvfZqyQPGzUBC8eJjX7CeqgUtIxmS7dAR3jYW8=;
 b=mINFK5+EwxPpa1aY5etAa4LZomgVVkqj44EZvggvOulw5q0hJfwlYECRoHyxpx2ERYGztBxu+vSSJsxrT+JPtNiDCwTHY2eVveCeL6hmW3Y28KeDViohaC8ugtOLOlVqxXbehB4Pk0N1J/h6sRzsy8/T/9xle4KwwToDzxG6okTeajZAd2uoGetXZVHB/5q4HHtLA5+0Qf7u3YRge4jIBLO8GTpzMGVt41FmOsPTtsw3m+TfTfkx+lrJcHjAxjw5UvotWeUS1nknbVqqBo/L333DdukNrp3G9PuqM8ymNYkVdD5N1DWpat1SXzuUZeIriqo2TP1XpDBZdUhUFO3dDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/D3TaNvfZqyQPGzUBC8eJjX7CeqgUtIxmS7dAR3jYW8=;
 b=RzbyizMDW1z1tXkudZ5eSzCBd0ACJPJFrGtYjkHW9PswGkX3TMvoP5OVyveZYXOSSm/qmj+vFjLk13QyDPKl9navB203KrMEOTOCkKEL0lKkn6x3kHUyR14a2AJqSVCJzAACW8QYX5EMWAzcsg408qIrsl57HXxbPzDG5/LzPBAzff0hdEIGRuQmCSv0tIY3+8qBBpzKqDmpPSyEEgq5MUCPcHP63oNfqO3ZPXoWsO5i8z2HlxqUequ8Uy9PGPHtd94q+UVBNLPuoNg/3jg3D4FvA3zGOFoI/klP2/dUSuYAqd4+KR76SUfJDPQlgUDp9ra0LAJ1mNkwgByl/ftqcQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by PA1PR04MB10443.eurprd04.prod.outlook.com (2603:10a6:102:450::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Thu, 5 Dec
 2024 14:55:28 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%6]) with mapi id 15.20.8230.010; Thu, 5 Dec 2024
 14:55:28 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Xiaoliang Yang <xiaoliang.yang_1@nxp.com>,
	Yangbo Lu <yangbo.lu@nxp.com>,
	Richard Cochran <richardcochran@gmail.com>
Subject: [PATCH v2 net 0/5] Ocelot PTP fixes
Date: Thu,  5 Dec 2024 16:55:14 +0200
Message-ID: <20241205145519.1236778-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR10CA0118.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:28::47) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|PA1PR04MB10443:EE_
X-MS-Office365-Filtering-Correlation-Id: cd1ecea6-4922-4529-e35f-08dd153cdb91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xzVVb/ZrGzaSj7lnE2pBivR2eh0Sd5zd4Rh+WVtT1+bbkM5JOai35HqbiKj1?=
 =?us-ascii?Q?zCMYJQElMNcE+QpRk8PMFOIei1ZTZ/SdKV+a7g4mHhWuIp2zUMBbGvaB1JVh?=
 =?us-ascii?Q?ZFGErH4xn61ZsC3dAzc4ChOK5NsQTf2iOjvTKy8C3t1XlgYr3z+J8zYyiaqJ?=
 =?us-ascii?Q?XlXERy1I26FPls1HRooDlzgDq6gucClGQsaPVmAdYzGAoISQFn+shSVIIKUx?=
 =?us-ascii?Q?d4Nm2qeTIEF4JSh/F0xJFD/l3mff2faFUtDvDcGs7HdfN3vdxZJsMaNfDj/5?=
 =?us-ascii?Q?MmdJkTinWdTvFl3InzYYtFm5FT4ldFJDekkhgMPwOyLzeK8OTOfkXYKK9Gwy?=
 =?us-ascii?Q?B5qMq+dJasjFiqHyCkEuw/B3RL9qks8jzaHuuPbVZXGRqgabBj4yp4QXcXh9?=
 =?us-ascii?Q?aBTy6xX9iLXlEI66Txw0ZtHPbZ0LxrPOKjSm3R+juPBL4Oy/uwc3x1uOUcG5?=
 =?us-ascii?Q?zdv/zSyzDpo8dYKCQlw7TyvZDoufAYWTv5Sdj7uBDl2irSFb5H6L4AMU+PAS?=
 =?us-ascii?Q?4fRcKTinJpQ6ZT2WfaAeGTspxG0+EuyXEXnRh75zZdWcwuebiARgUsw4r0Gg?=
 =?us-ascii?Q?IqRa9BMnzJQQHfCHpR68ygwZ3uuKgx4DREyUihtbPHXAk2QYIGYnpOezRVK8?=
 =?us-ascii?Q?pHMMbnNyHVxdbEzpQMj0hS6r9xSEcUBpPKVNH82uVi6B11OBPYitHtjjc/dl?=
 =?us-ascii?Q?82WHcUfwZYKdtzXPXGsaGDjrmmTikfi9Z7e+Wvtk8gEgxmcXzhq7oLxI9VV0?=
 =?us-ascii?Q?Q/F1dsxB/p6SUvlbrVO1aN0ni0XbB+9nAOe6GRoXzRo9poveGutaXvoI7ope?=
 =?us-ascii?Q?4MISqj+hARFLcILqo04MHW7oeex+foYIslK6hy5u4ebIyBpbo9Oh6U2aDcKK?=
 =?us-ascii?Q?xshA1TMa34Pur8p4gD9Cqo78tOKCNgo4iNp5geIyQdLSz8IpBnBLmur8QIhR?=
 =?us-ascii?Q?7yYJvHY8cQeCEeBzOiOEIX4/QaSfdB3XukLg9FcopHKd4+VHUbHNZ6D0DTDF?=
 =?us-ascii?Q?ajvvDAsSCa4MYVzaoIGLZ9h/xgD57MoP3+71T0hpzsjNNG7QxebmiZuanG4H?=
 =?us-ascii?Q?+P//UYrWYNr+nsom2Mzed21tx/2nuGz5n+RSLqsZY40wkaUhDUVl9EcWSTio?=
 =?us-ascii?Q?DePWmlvWNGbFkvHUDhyQCGvKAJe50LLOO/ooT/kti5IQhCn+ktMjTtBIhErU?=
 =?us-ascii?Q?LmPxTPkOv6D3rJkxn+svBjMgIpP2Gp7vvdEv38XOUdnXOV7gM+w+VzTsUsks?=
 =?us-ascii?Q?FB3U9uTVPTR/W2udIlFxNBMpsH5qfLQj6kHg6fDhhNZkYoIpA0GIaSyG1+qi?=
 =?us-ascii?Q?esiX5rZ4gquIVxaFs4UgXHrXTCpCG577pvmZTuM2z25iXln+AZN+q9UoH4+y?=
 =?us-ascii?Q?pT4MvB/+N7TNF+vCdD+xFk7JT9y8hdews4b0T15bkZER0KVfEA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IdM85AzwQJUl/Bap21Lc7Fdi4X5K+vt8BwsGs5KhRjLEPWajgYLbxMqEwab0?=
 =?us-ascii?Q?hTQOkah7R/hp2VtyJE1AoRNmM/jfYGRzQzBBrbxlSoUZiWuNLrdU1uXFwsbv?=
 =?us-ascii?Q?NDFWzs2tqIKGs3j4x4i5uSPoX2SAFxi84Cj+mRoLZeHreniSAvcKj1/WDpxN?=
 =?us-ascii?Q?SMfFZfbw6nb63r1niFGRvv4QucOPmRqNMQvH/xxfvfOu+xU19PbS+Mr8rv9y?=
 =?us-ascii?Q?AUtQ/x79kPAFCby4TPt0jta8LXMWdD2I4uGFjwNxOdrW3463QVoaP5GRtQqd?=
 =?us-ascii?Q?JZBKnwIIv5wCww/9jQrXFgJ8P50Uoo/89vv3Y6fkm+WJNErw2AnWXGg9lPKp?=
 =?us-ascii?Q?NaAaldMfU3qcsNqDPNizihwdxGGU1XztZLHsUBOUgXGw5GBwpKd2u3irdvIu?=
 =?us-ascii?Q?BbcAW7QrmfBNGrerkA5MGXeTtD+nzCcagZzV8Iel6EqsqNvWxSKmoKM+9wIF?=
 =?us-ascii?Q?7opnT4r1d8ogOowWXSBGnxj215w564Alb4YNT5AWjrKfyPL1H8kvtVnKBrOR?=
 =?us-ascii?Q?4Swg9KNPeoyYNO1clujV505bzXZifpcCkMg4WnzPODUSSo2oY6wkWmHBJGyn?=
 =?us-ascii?Q?rjPi5uIp5NcKSbRxM9rnKL8b8Ompnz7XH8eG4hGTUNdgKqj19pWTjhUlfKUq?=
 =?us-ascii?Q?FUBUoZE9U/zs2zqs4808Yce/B2TPhkGgn+fDMgDCJceQ3HoPTwhGmEFu7lKH?=
 =?us-ascii?Q?1y5pHNqWUZcU9QzwUFv+ei7kJRiWZeEfunT7yLM+XRAJzuyKKOvTDNRC+jEY?=
 =?us-ascii?Q?rHgybGwdZqIFT8crd6Q8+t/Zd+0ph5Qf9jmjlahB6m6zAs9jrM0Iv1Uyd8l/?=
 =?us-ascii?Q?/Hrwtjs8ij6qKLO+W/xwNLFPT1csYjHSgShx/PGhlvwWNXpxKFcqojR38xeT?=
 =?us-ascii?Q?siWux7NVq9GN60sjageY6Py9FUjdE/deQyVJFm9fuDOTIDpu01xKFivsuHqM?=
 =?us-ascii?Q?PaPNfSyEBNsvTxdtrrsyEzCSn98rviXW1C3MizvtobNPOcbJdcPG510Lgps/?=
 =?us-ascii?Q?NjuGPCA/lIlA/9tvNp7mXiS4c0cjMRE37brgAdijYHWXWGZ6h3CLQVSNxOH/?=
 =?us-ascii?Q?Zd7QuOVXrR5MCQh/Qb/k0cH8bJt7zK/T/gDXfkD3mvMTk5rTdKRb+3DO1qOz?=
 =?us-ascii?Q?2fobMq4jPT6eL/vFp8B6DRZqtuuohVQCNiuS2/usHDbW9s6d+lnMWKcuNIK9?=
 =?us-ascii?Q?iUbvPQElDnIyeGhq5aQ1q4EBQoj//PgEvnisNHNZBoVHUFMLplGUapKNDWab?=
 =?us-ascii?Q?h0RwZXCv0tpDzUjJ4GGKowkiOQasfxfnq7iW7q2ekja+0kgiBBVg6yazDA/D?=
 =?us-ascii?Q?uLnRsWS+eW9c2TOvqD7fy6esx8u/OqQiEI4B1YML+0lyMYSXqlw88rHKt9EG?=
 =?us-ascii?Q?uk84umNwsTOrn5ocW50O0WcYbz52WjHFz6o2yi/FyVw93lunM/6q/ctYmXY6?=
 =?us-ascii?Q?P2z+pmhLM7F7kQmPR1CLrdT6m6RuvbJEUMxJHKEW/2W33VXg+Bp2/+1tMvit?=
 =?us-ascii?Q?eD/ARrkqIJS3dQHV5i+UW+MIDWeyZC8Rgo2AChA+mU1MqFH8sHvQYSokQHP+?=
 =?us-ascii?Q?94iirmiSu2mHDHwLvf9m1lHE7nFIlaTOYA7Tv4DnAIGK1/U+qulbqXFXaLA6?=
 =?us-ascii?Q?SQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd1ecea6-4922-4529-e35f-08dd153cdb91
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2024 14:55:28.5958
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9DfaIN2xfreZL3KoGfNZoHFU6HpUJhP1uwhtCWYmRgL//b4ouRySOgHJtmK6je0Gs58K9mksQrSptWJMziQ62g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10443

This is another attempt at "net: mscc: ocelot: be resilient to loss of
PTP packets during transmission".
https://lore.kernel.org/netdev/20241203164755.16115-1-vladimir.oltean@nxp.com/

The central change is in patch 4/5. It recovers a port from a very
reproducible condition where previously, it would become unable to take
any hardware TX timestamp.

Then we have patches 1/5 and 5/5 which are extra bug fixes.

Patches 2/5 and 3/5 are logical changes split out of the monolithic
patch previously submitted as v1, so that patch 4/5 is hopefully easier
to follow.

Vladimir Oltean (5):
  net: mscc: ocelot: fix memory leak on ocelot_port_add_txtstamp_skb()
  net: mscc: ocelot: improve handling of TX timestamp for unknown skb
  net: mscc: ocelot: ocelot->ts_id_lock and ocelot_port->tx_skbs.lock
    are IRQ-safe
  net: mscc: ocelot: be resilient to loss of PTP packets during
    transmission
  net: mscc: ocelot: perform error cleanup in ocelot_hwstamp_set()

 drivers/net/ethernet/mscc/ocelot_ptp.c | 209 +++++++++++++++----------
 include/linux/dsa/ocelot.h             |   1 +
 include/soc/mscc/ocelot.h              |   2 -
 3 files changed, 130 insertions(+), 82 deletions(-)

-- 
2.43.0



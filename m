Return-Path: <netdev+bounces-148812-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C9B09E333B
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 06:45:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5BA1B21B96
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 05:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7893C487BF;
	Wed,  4 Dec 2024 05:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="TM17WF1A"
X-Original-To: netdev@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2052.outbound.protection.outlook.com [40.107.247.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BBBB155A52;
	Wed,  4 Dec 2024 05:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733291130; cv=fail; b=YXHaBSSs7q4DKjk9LS1xbEn0LoRjIJDXHEx6uP8FFePrGFlTBNiB0io/ZaJUnnz/lz01D9YKilj229UFA2vx/qzvBgHBe83WkDfBow5N5V7a2Przql4TO47TY00cbl7RBRT1ykBAeEKcdqsupv9vDvVo6ufodj6roFqOmRIF9RA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733291130; c=relaxed/simple;
	bh=AS05XkgoUAQOGtWCGDLJYvfYRlEDVjKbS+P86O6OkNM=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=nzrQPyIJ2PvT2fnmbSHMgRmcHrJi+ksCzR2jXVa2J0vZS23ID5eaLO98j+rIRWtwCWBiDkkO4SBPhGeiFCtDPBOlEBEUFQxBa902846Us5K+Lke3T45jd2sQXFuDtN2JEaUnYTmohwl9z4sfXXEq6CdeehcA8s+QhOcJADUMu3k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=TM17WF1A; arc=fail smtp.client-ip=40.107.247.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iGB/DILfuwXrHTU4Rrsh967tRW26BT57DyxRI/F/K91CsPc4/HM6XMeWjUa6BYSECo0/xdryAqGeW9gwAZf7Qthp3mNderiKiQDG+i1caRWGy6EBULuZSzWpsJICh4w52Oap52d7Mq4T+n4uAbRO3TzGjVCUO4d77hmnrUkqgREY08z/Tgsu9/yH4FeSAKms25V4gfQuKTCgIsOYlP9ev0phbhJ0Mfr021Tb/EFwtQOnE2yf2QlHcw/KBWDeBkoJFpzb4jhiqs2iH5TBAoHNztuWPu8lHtqFiCTA8+GUJVFXlNilb8ooX7qjcMrFYvnDPBY24eqc2v5SkavL3D3mKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nfBXWqcF39OuFgZw8dXPY2TJ34K3BcB1ZBJHznHVvtw=;
 b=vN/1xYzdwga2VDqLp8VdUb22RQcNmeC2L9PVwzvc20WHUM6iXY0HbJrlt9E756tPdreYsP5TDj9tOM5BerYwGj+LzjASx1ddEyf+l/YwFsjp5vA+mGr2h4qTngSCIPINo2S3Rm333cT0iL5O7izbyKeAgxCb6qPUJgxumxY8aYS4/h+2LdCwK1crjPzdMTudJ/O8KE/9629/0PbM5liV+qyOojuqb+6sEDKmqt722uwIIdA2DV8uQfdwCiYe0RKTOjG7Dg7hZTrxzkGKFQDISJZTtVLHKRi3glvWdg6XVqoxHvhlDlivw0/nhQ+BmY2avUgIjAoHo4anSapg4HY7AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nfBXWqcF39OuFgZw8dXPY2TJ34K3BcB1ZBJHznHVvtw=;
 b=TM17WF1AqOtwrzeYKj0GkRY5AsSUuah/G8aJiadGqhJAoUvWXu8YL3u8RUCK0hERIP9ubZicCG1ZRRZxkon6RLjXCvRyAb07T54kwETbU28Hrc9tnda7Hyi59iq+RiaLiSjKfOf65C9KAi5gn0+5Skmj9QMxHd1f/vqaReqxba49hR3dTx54dtjq3sznDMpOXYgB7pmKCPfG8fM/G+albv865IQxg4A8rl47JyweLIYf7/xFFybGLjqJIXFQiW3x6w4B8at6tIDfecHPCG7Ef0cpx9yj43qJpJVwvSsxeDs/GxN/75vfiU1nDgp/GTfBOEFh9yRTBP3nYOQSxlCHOg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PAXPR04MB9154.eurprd04.prod.outlook.com (2603:10a6:102:22d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Wed, 4 Dec
 2024 05:45:23 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8230.010; Wed, 4 Dec 2024
 05:45:22 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	frank.li@nxp.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH v6 RESEND net-next 0/5] Add more feautues for ENETC v4 - round 1
Date: Wed,  4 Dec 2024 13:29:27 +0800
Message-Id: <20241204052932.112446-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0051.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::6) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|PAXPR04MB9154:EE_
X-MS-Office365-Filtering-Correlation-Id: b54cac01-b6fc-4869-dac2-08dd1426d831
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WbJc5aXBAZjDrP5J9z2kmdasiBUEafrZPF10yQxdJTOcTdCCg5y01IOgNfV0?=
 =?us-ascii?Q?JYudVXMcbSfJzkwLlI7m/EVTwjLCPWm25dhlslJ1I68TwHeO+/I0cvNZ3Z5B?=
 =?us-ascii?Q?eeYqCjqaIGo1otjqaEPwQmb/v5WLxOUxsVzc4Khf5bKFP/2kHgmIm367/zZe?=
 =?us-ascii?Q?xpu7zXcaajGTDpb6NEceVHHwV5ZYQ1TMZLhdZ4lfARvoQZAqxxeojWGsfaFu?=
 =?us-ascii?Q?NlJbtDYYJEtTsOvUx6twG09VFOTYgq5iRACQc4w/o/w2gWO7IcVO1lr5CBIv?=
 =?us-ascii?Q?NveQo9XkEibpNXlLbZchiOzzMf2KSDi5vdEV/hWWGIqe4dchqa4EGpTxRano?=
 =?us-ascii?Q?5RsojJn3S6s+MGXE+maoN6UWmRwHY/xaY8D6nFoMVzg68Br+IG3/9221AqDx?=
 =?us-ascii?Q?0yDNygU+YPcfip/VW9AFWho7hKP8gCyozqXUgBB4q1N7GuX9igZVQycpGcdH?=
 =?us-ascii?Q?z9MDk26jpZaObE5+KrR57A6YF2j6XNvb07qbaBlQirUiI61BufEr7mcD9RyV?=
 =?us-ascii?Q?sJY1IQYgj0y1nIbfZkPd+EJg1U7OcM0S+cWJ75nvLz9LbZDzKZjYohajioIU?=
 =?us-ascii?Q?4mJi314PLP+zu42JZtV3pe8HZAC3f3hyNo4hq1NrEAD3ssEd5Fp0e3oY6kAl?=
 =?us-ascii?Q?KGdZxdhguD+M4O137qYWae7+fge+kcy5URg3NaUXa7gejg7bJvwYEGlVW4mL?=
 =?us-ascii?Q?E5OaZreeD9pZ8wg9Ys2Z+3cHzwv9VjhlhYaVfrle4LCGI80Os1IRK0vwLy5f?=
 =?us-ascii?Q?Fgg0lqH1IfdBHycTc8U9nvsrgjimsD05eDlzI+tck6GJaQeEg5Xm5oNlnU9s?=
 =?us-ascii?Q?VCToALZMwOXX+lc80OuDyW53EDSK8IDipU69wubM7l7VP5b+QPjM/EKLv9MO?=
 =?us-ascii?Q?aPiwdw/7Topn3stpkWPvqZxV0CdVPwIaXC3FsDZp5cQaSp3yB09Okwz4ZF6G?=
 =?us-ascii?Q?I/8T0/elKn2OPSXkxOiZ2PmGpYbuoIYj3JFiXeI/aeS6u5bDHkowRXsOlvWu?=
 =?us-ascii?Q?YkI0inkZDT6+1m0qLeyXtFHrycRb/27Y/Rc91pzU7AdoGIembZtjwA9kMvG6?=
 =?us-ascii?Q?mMrq3n7bWNXMeZhXx/TgZNnCM3dut+57dVRvQ0omnzZrfYsxLF2rQnjBzxdH?=
 =?us-ascii?Q?OOZ/b9eAubTunEyoLaF1lW21iKFqLScSbTecHqcMQKn0S4YmA/G3m4kAFuP0?=
 =?us-ascii?Q?9OphAhLpARQLO0dERSruCJcQv19ZmrMRay0vhTs3Wt3CGipZDKFwgY4uPoiY?=
 =?us-ascii?Q?KVHpG3tYLelHkZigzjmBZ1TmZKxoOVaxXE+0e21qeDZ4ZEik9uOSPlbzbkSD?=
 =?us-ascii?Q?fXXtZt9SUh55YfPcaqzd6vu54WSRmGPOw/7pSfI1GuBDNTs1yyJWHYi8Arto?=
 =?us-ascii?Q?tNHT/NCLwBwYl+qIZ00LrKGYt0swfKBLbXSos9OrIC6IjaZMQg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lfXFXtw3bGsdXosuunE6VrKlpfATUCc8MV2a5MHw5ezCHnrIb7k+nKUGrAph?=
 =?us-ascii?Q?RmPdlUg6mpSZ0eSccrwplBfyYLdhpUASP0/NzD7VAfJUQRZB6pQCu+bF/3zy?=
 =?us-ascii?Q?fUydXLeXYOf59LNDBNBJl+LgYEgqvoTYKAPSR4lw4WBhoePevbduB2VvnrLx?=
 =?us-ascii?Q?2eHImgI3s/i9+CH3Ra5eHlkRM/0KtaOqqHl90qtEhqE74StDXg47FHwdkuPN?=
 =?us-ascii?Q?iZ/ADdUpTE/JZ8zWROjaVoYuXneYTcv+/xDfvFjXV6gBjho7EqCG05vKJIn6?=
 =?us-ascii?Q?JtM3xp5pTgUKcZWCb+zFpOIFdyHZ4OYTuBRnnHhAbrvseZcTZiZXf3jr04p3?=
 =?us-ascii?Q?kftX4AJnLnRfwmxYzP7ZvLtYO5SNMqh6+dMtqOI2xsa96+R21VYqOP907DE3?=
 =?us-ascii?Q?kienc2XjdD6mpjJ3NW9tz8MZNzgMHH+Tc3A2p/yXJA2I1X/kAgRdOByexsyx?=
 =?us-ascii?Q?fjT0zkTTC0vj/9urXceO5B377lDhoUsB/CU0AiL6u2n+6dLitL8wLfMDPuxi?=
 =?us-ascii?Q?O4U79mF9qjhMdrWaLkiy04jvgMKL1weew0bWXILJSWLGlO29cuHjAigrGWnI?=
 =?us-ascii?Q?0GTxbiuWZ5zwlDOjojUj8ux1JIJpzATV+oaaIHrbD9E3Tc8E4pDpBIHyd0Kx?=
 =?us-ascii?Q?mQCthAHahmfvbZLhgr3hHSGnnM+ZjrAK2JcJOcjckGFk0Z4+pbJZgax0vQkf?=
 =?us-ascii?Q?Qb8RCn+IJIQAfJr/Cu+Y+rmLFPpCkjxwIEOrc+DnxC6HB8w6/5Kom1B3HbkN?=
 =?us-ascii?Q?XDs7QFearssSfRvXDtWJ23BKGlWQf6bCSZjidJiA2z1GJeTaCQHeMX/7bnbW?=
 =?us-ascii?Q?B8NX5AQSJpntrAHLmM6xoUhdSdgy9eIalMTXTUnObiYA1Q2LhnEuSDH40EKt?=
 =?us-ascii?Q?fH2ftX1Ix+7Ung+p91R+HW0PMaszBAL3KyTWNr/89Gru0vgOac6Veieq5WeE?=
 =?us-ascii?Q?+wV4olENDVXu0pjifvfF9w3i9gweO+uO7fWJ1WKmr+G0Cnn7ljKIzXmoYfEF?=
 =?us-ascii?Q?6X+Tsau+rBIfO80GMPGRSJxcSJMgA1y1zQngH5+Fad41LfyaejjcvTdq+bPY?=
 =?us-ascii?Q?NgPa+uP1jOxf/Xshz5lIG66LYh+oz1rrFHqdukeH+eTwlO7jE2QU4skcLRMQ?=
 =?us-ascii?Q?Nup5mZGq4Jr+KxYbQ2sy/Pf9uaUiumN2NrOBX7Zb7u6j8mB9yepLsh4aBmHf?=
 =?us-ascii?Q?klVnwKP+MC0ATGcQVsKTdDkJt/sZ/PIpedafNb6sLlFKNGP/HOeNEP9SfKOa?=
 =?us-ascii?Q?3jPuKI717dQOGBv5q8z2bG9AcAcrEH7z4OfgA8nr84tqFjJfOeZ9SXPCqxHW?=
 =?us-ascii?Q?inyWBglf/3GS1YOAzipwNRM0q0ld2GWnu5FIxmol6PSaasBkZ1eK99OgqlLf?=
 =?us-ascii?Q?DGlZV8g2wqzqYf62q7jur8oK/jh7+PRkbyhT0uk9CnPwk/XPpiDFKeI2a5sw?=
 =?us-ascii?Q?611SRhfTHXkp5YVVQ86Z4VRNyn/EiHjYkaeCka3VCtVPm4Wda/a6kkrsxTOD?=
 =?us-ascii?Q?JW37AqHH7OnEFctpxopKFhSwmc0HByBio2eA0kbosJGTNufAaNhhs+58WN2U?=
 =?us-ascii?Q?60zLOnVwE+fgkJ8fvM/UeUtlHXO8bjxx7Ke4yGKb?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b54cac01-b6fc-4869-dac2-08dd1426d831
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2024 05:45:22.8927
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uPTR9OSa7UoRjMYnaTs10qy8CqFdz8UFLONOlzHv+YYbnLnBIDazlRNpSo9W+tKqWnO7vA655ygDcU14x/4SLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9154

Compared to ENETC v1 (LS1028A), ENETC v4 (i.MX95) adds more features, and
some features are configured completely differently from v1. In order to
more fully support ENETC v4, these features will be added through several
rounds of patch sets. This round adds these features, such as Tx and Rx
checksum offload, increase maximum chained Tx BD number and Large send
offload (LSO).

---
v1 Link: https://lore.kernel.org/imx/20241107033817.1654163-1-wei.fang@nxp.com/
v2 Link: https://lore.kernel.org/imx/20241111015216.1804534-1-wei.fang@nxp.com/
v3 Link: https://lore.kernel.org/imx/20241112091447.1850899-1-wei.fang@nxp.com/
v4 Link: https://lore.kernel.org/imx/20241115024744.1903377-1-wei.fang@nxp.com/
v5 Link: https://lore.kernel.org/imx/20241118060630.1956134-1-wei.fang@nxp.com/
v6 Link: https://lore.kernel.org/imx/20241119082344.2022830-1-wei.fang@nxp.com/
---

Wei Fang (5):
  net: enetc: add Rx checksum offload for i.MX95 ENETC
  net: enetc: add Tx checksum offload for i.MX95 ENETC
  net: enetc: update max chained Tx BD number for i.MX95 ENETC
  net: enetc: add LSO support for i.MX95 ENETC PF
  net: enetc: add UDP segmentation offload support

 drivers/net/ethernet/freescale/enetc/enetc.c  | 333 ++++++++++++++++--
 drivers/net/ethernet/freescale/enetc/enetc.h  |  32 +-
 .../net/ethernet/freescale/enetc/enetc4_hw.h  |  22 ++
 .../net/ethernet/freescale/enetc/enetc_hw.h   |  31 +-
 .../freescale/enetc/enetc_pf_common.c         |  16 +-
 .../net/ethernet/freescale/enetc/enetc_vf.c   |   7 +-
 6 files changed, 407 insertions(+), 34 deletions(-)

-- 
2.34.1



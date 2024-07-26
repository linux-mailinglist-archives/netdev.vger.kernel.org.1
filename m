Return-Path: <netdev+bounces-113253-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1EA293D561
	for <lists+netdev@lfdr.de>; Fri, 26 Jul 2024 16:53:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C49DC1C209A4
	for <lists+netdev@lfdr.de>; Fri, 26 Jul 2024 14:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 767E01CD06;
	Fri, 26 Jul 2024 14:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Xtn0TUe1"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2061.outbound.protection.outlook.com [40.107.104.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369C912E78
	for <netdev@vger.kernel.org>; Fri, 26 Jul 2024 14:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722005619; cv=fail; b=KxGxC7OT6GA5rD6thXCMHTAezl3u9WZOgBlHO1lzPqXBaGuSFEErxUP7HRHDH3c0iVja+v5MSf02gVaVZYfRN6qqWnOt3L9R7RJN74SK+j6rC1YVOeZ8lrfosKDZhF4/VqVUrDCbvGmlDr0oFhQGVqY7E1xWMdDuLL/vqJlAr3c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722005619; c=relaxed/simple;
	bh=+19D8SZBEnIJimcQVw7R3ia7De114b3ChGjp4tG9dEY=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=kJjTXKzDtth8GgHP/zA4wL3S7S2keFAvfVJzcF9u5c5SPMsLzuOQ09cB7cJNIy0eKTQ55Zay9/+48i3LCSkcCpTK4DyYYgQRpZl+Udt7rFI3FiGRkUW1f4c7jjAVce7s+gJgvS2VZdf9b66RdJqdpZG3z8YAbkKncK8SkrdfozA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Xtn0TUe1; arc=fail smtp.client-ip=40.107.104.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hdofkb9DsE7mzakBH0uKtZzyfy2CSOsYRfm+cyNws7O6uTK1rgVuKUneHnWYdL4Xd3Xau9xsId4XB3XJh1dTap4H/eNDb1/FI9ApqK3zAUGjRHsh0/28qJWF0iwWBh0Epraa/MK6U59PFlpVXky8vwLM2N/SRjxYF8raWvOmKMZ3e/5Ynz7q1aa4XYH2lmTpcJlFiwMgERGp9bPni1i+oDxwJI70spdVtx4KR9VlNIqXxGbyM0+KzTvh4MNhyrZbHjfV90eXlyLilNaucdZN8m9wM4pbNo8/xEX5qN6ceektcjliXuMY9f88Df5f2VkfhoH/2IJvyrQWcGg0Mg2M5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3WDRHxygI85pWB87tWV0kkyJ7b2Mzkm8EtdRbYOV8H0=;
 b=iojomG59k/lZ4JlqraKFm+N89/qaFWRStAZ6CpyGUeeq1lMfV6rzsH1iQxQ5NuYHN3hBUbNQzpaxaBTmLmMos5gAtFNz4MF62GrIHXn9NfOCa/Pqs7R22/dSx+SifaJVxHLieGfgaUt9wavLag/YNS77lHdzXH+gyy8JMnGH6FUUmZzkuu2Dm68dsKaAo5uWTiz6KuM5MvG3SHeXyV2isbGlihAV+89NwQodbewVnHQty/yqU16IjldAKN5uTzxpj6cixB58xkF1kVfT3/+1pgKpAaJ0X13jwNRR0gorIevxq8F/FuLD8h2z0kmgCwwFUjehkNvwyWOIf6tNZcd06g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3WDRHxygI85pWB87tWV0kkyJ7b2Mzkm8EtdRbYOV8H0=;
 b=Xtn0TUe128IOXUZ2G7tYFKXrGKrReP+sYryAUEDZ1Oxg9hlBH5utMl9YrscdpsgRTyxmQ4p6XgqSxK60LRLYlHlqbMaUca+ypb7otWoNepJ7EK+mRAtmsg3ZSoU/2iPjnbaRF4RVogpNaMZiBlskpaXCwj13G7U2LyQF7kaByB+zhnnSMNqAVrVR1at1jyGehx3z+rczjFEWT0BeBLgHpFyvBwFZ4gDEH5y7bZRmWHC7U2WN/d4pZ2uL8cmmE91Lm7JZYZWo0H/CPmsbpAboyVWhVJpCobUyQsG99JBVBk8gkQuxiUjm/18gpgwrZmIEmGXf41et4y4zckZDZaw62g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11)
 by PA4PR04MB8013.eurprd04.prod.outlook.com (2603:10a6:102:c4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.29; Fri, 26 Jul
 2024 14:53:33 +0000
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::21bf:975e:f24d:1612]) by PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::21bf:975e:f24d:1612%4]) with mapi id 15.20.7784.020; Fri, 26 Jul 2024
 14:53:33 +0000
From: Shenwei Wang <shenwei.wang@nxp.com>
To: Wei Fang <wei.fang@nxp.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-imx@nxp.com
Subject: [PATCH v2 net-next] net: fec: Enable SOC specific rx-usecs coalescence default setting
Date: Fri, 26 Jul 2024 09:53:12 -0500
Message-Id: <20240726145312.297194-1-shenwei.wang@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0025.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::30) To PAXPR04MB9185.eurprd04.prod.outlook.com
 (2603:10a6:102:231::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9185:EE_|PA4PR04MB8013:EE_
X-MS-Office365-Filtering-Correlation-Id: a0b9a520-b0de-4fe6-7f2a-08dcad82b88d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?54+IrPqa+rqDqGFB+vq3HUaSNekUlSGxynZ6ZK7T7+d6h10h1kS+ha4gN1ct?=
 =?us-ascii?Q?xzeKro4QV7vQ+zPxkBy4vv+ajxjYQ4t7yIgkbMkg7xE82ZjlUHRk5P/JKRNH?=
 =?us-ascii?Q?qGZHXuNwiTudUWssNhoAyxCEEp/YN6pwsjx12QWD16d9XotpYYqPirV4uYpp?=
 =?us-ascii?Q?jfKryXoVISSz4T1BipLcvxLG9d2HgZ7n9yRr2ygmir7Qzm4EsLg07j1zc46/?=
 =?us-ascii?Q?EZ/R1IUhrGsfC3GJfIFF31stQGS/cPZIwlyDgbC5zYz8cxbzURz8juh8aIRf?=
 =?us-ascii?Q?IPqRRnISbiC+F8vkwsDBQ4Sx5u4uJvZEFAX8hWB2Tmg3Mn6Dlx81gfTGdwpE?=
 =?us-ascii?Q?ABWON804FaDVet8vBkXl8YaNFKoWsRAXb4WJda8a5MlGJGqTXwPp+7I/Zn3u?=
 =?us-ascii?Q?4IIjnp+r8q6JGC2PB57pDcLjfcd5lbXu4czeNdHNf5o81pdpA1K5LAFujKFx?=
 =?us-ascii?Q?zJI5hUDRm2uj8SojTetw51Q4yjMivVQHUn4KUxL4UhY3lHPWfsnzZS3a74Ue?=
 =?us-ascii?Q?wUdUzFz3HoKU7+zNNuSk4vctVeY2tQ9FR3q2w+n2BmuG5ScqTxRoqVWrnhKR?=
 =?us-ascii?Q?Ob4594pL1TOEFAl4TYNJOwSI+mAv/76lof5xACk9HEzjR2zWMVBUwmdQoXw0?=
 =?us-ascii?Q?nqMQWM3IeqlOUJBgBQy20c33fsC3yO+kNtq2feZxtkAXgD6g1PSdDT1rsSTg?=
 =?us-ascii?Q?RbR6knecPK9UVz3nsuGKScofXtL2sO7PG66+O9itXNjIfgz9Y5GAMI8LYijC?=
 =?us-ascii?Q?tpmsCUNFPxPGdZ8HOLFQ9pOimPtvzBe0g3yHP8tQJzEwibRI6legscXwC0LE?=
 =?us-ascii?Q?4Obg3pRi1bP/T7q0pkkpA+lgtcwJTHk9UkXjZ8q6rSuyzVwecRi3dVUbkZ7d?=
 =?us-ascii?Q?gCSGsRhPnuoxuK6ogA/bT5Y295A7ARqzE8ucZ+/KCRwZVn9bWziTTsPjMae/?=
 =?us-ascii?Q?4zNnOxTkHEGYz6mpdeRqS0nbmYXL5KsryY2hJnFSIWC3HpS+tU3Vpg6oUjZz?=
 =?us-ascii?Q?ZXEvUnzqmTt48LJYF75O5nCkrCXO0XkRH4lQhKPA8ihiWBzgQ9R2PeIaYEkY?=
 =?us-ascii?Q?8f2yAqKFfVRBLehkxgoHKayumbUqFG7OaLF5ky0+DOlwP9lFeuO7PvrjlHVY?=
 =?us-ascii?Q?6S5hyTUM2eZF/gwNYsm4Q7zvfWk9FZ00qnJPaP/3oQGV/lNe9Tz4ZpeqS+gQ?=
 =?us-ascii?Q?V+3S3fYC8e75LErIe1hHqioES0y7+Bj0s9U2q5mZ7PA99kMypqt+thqp4xxY?=
 =?us-ascii?Q?fB/q82OUQNL9v6j24admhs09XYGipnVCEBpSimzMDReETdulDWpwDHWP5q/p?=
 =?us-ascii?Q?1ui27cdh/eIHvMrDo/mltFahkL7hX58XRk5l81z+u33MIvqfMuTNwRZ0Vat+?=
 =?us-ascii?Q?050B56r+EsnBmC9iwDnzUuTK14j50VoEZzEOxqd1KMEkyfaY9g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?emBGZZoZXrgkI2W6LApefYrk0uYfSoItqORC4tGwhNsgSyL2iXOUWtaYvRpB?=
 =?us-ascii?Q?W/D4ONGmmVPNi4xkiOUY20L5iRDVR7CGEE3V8vHDWk7EL5mlnlJeHmwHvRs3?=
 =?us-ascii?Q?2txvHj7UVGKAmNkQ1BRDWYZkl6F7+Gm1v6R2X6lctvYG1jTdiHQZLrdp40Q+?=
 =?us-ascii?Q?3WwUD3jfOTNbOCLoem455i1TaoRRdlEWFeY9D+ZJhnsDh30ElJpNZlOdPygK?=
 =?us-ascii?Q?RP2iwfSLY0HCrVf84q9Iv0sp8xG5bDVUDpQ8nKoosFpokqEox3XCH756XrjE?=
 =?us-ascii?Q?lUQAlnyNB6dp5Oz3xPTveHlJlua5s27kf7PQHA9vHob+M5HJUcozWUjhvx30?=
 =?us-ascii?Q?ewrdOjUEL9uvLONdyGAoR0mtcGk9LQyCm273DkV0QJgMt96wX0/na7cEjg/Z?=
 =?us-ascii?Q?B9R41kJdWovu5wANNe+81W2uAQWv2ZeHlbVb1a66rkRTF9sq8EVaH6RQcW1p?=
 =?us-ascii?Q?muTEKtG+sy9Qmey0guleZrlMGXtwC/PrtoCRiTm6x8z9wSXFPkvv9g/oBafy?=
 =?us-ascii?Q?636/WgCeaT9jP71i9+zNZYLfZmlDHjFdtZqL59h2Li9CZapqt4b8pTMB5hYX?=
 =?us-ascii?Q?uVKNcjcR1AMYlpByuKUz5cORIupUSa1TC6rRw86ZkFnr9mbVAhy1xLSHGaf7?=
 =?us-ascii?Q?tQmYTRjKIaGVJBhLR+yN3wZTHzJcMhY2pGdvgpFJP5P6dNjUezHhFTfUYOB+?=
 =?us-ascii?Q?37r8OP3IekS5+MD5JV8Rs0QTRcQBi+bbw2YQGWeeNiZRsUHpimsSs168d5Ug?=
 =?us-ascii?Q?41vCU4x5Ex4izFXbWTRaP85xo5xLoGGfdW2hjlmeDMmwh7H8v2mBP1V6QC1X?=
 =?us-ascii?Q?m8e2xOtm++WDOZALG457lBicCm/b7OIo2zCjWmYrq0hYqdMTlk3Jdgx9w/dd?=
 =?us-ascii?Q?GkAwIx67lm3QekjLzHSbNzdJ8v9cMT9QpB6eV0ciL/p7+Xk7Uw3xpUKVKOAc?=
 =?us-ascii?Q?fbEdsOWTcNElzv+AZLIdAFGHkx4fPmA5IJAewRYxhGO0GPHLus/QiOMEDz2W?=
 =?us-ascii?Q?VJFXdIieN8bLtKPGUiZI+deS1motamCMnc6Pr8MclSWCcfSKLsH6IONcqBvr?=
 =?us-ascii?Q?6cltP14faj+ewUOrlWfY2imDQoLFHwyLKIC3n+YEXdYRO/9oKHgdPvJS/2u7?=
 =?us-ascii?Q?D+w7GMnTwAvmDjvfUceYSoYcjXbEC6AbVOPfFX8zoO78xKosZ3E2DgNnwwMM?=
 =?us-ascii?Q?0Tsg2g7k5CAyAt6a63Ht/lqaO9DUwQ+7fSRIPTXiGvio+qdvKx770Kg/NeAH?=
 =?us-ascii?Q?gZjx0bREQsoljEfHuxx1oJA0RxaZj4mFuMY7E3bAcm9jyCEiZLHO+0wbAVKB?=
 =?us-ascii?Q?T7HLUdwBd23o/lUBYKzuVtQXAjOMXgxT0QWQNGwjrNnzyVZoOe6D7rjWm92E?=
 =?us-ascii?Q?tkVFSW862nRMlAXBJ7hS2fYYiMTZrIuHF8n3rQpLN0V4RN77u+mHhj8woqHb?=
 =?us-ascii?Q?HA9ZRgty7rctZ0yCxLVHe2HcRmym7MbBfm17mlhEipKgpMFnrkU1OrUB4vtm?=
 =?us-ascii?Q?th+cYHsWzBFsw3H3MKDrUBRJIdIugxwtw1TJQ0nf5ChCTVK8igOAf2j1/g86?=
 =?us-ascii?Q?cuXxNTJmS2TI8dcmxkG0l+qTK8KPHW9XLn4fI7Yh?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0b9a520-b0de-4fe6-7f2a-08dcad82b88d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9185.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2024 14:53:33.6034
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XkXAj2VQSjfvdR+DkcpaGOMHGwUMc6B14Bf+SYlYZA0J7g/6fYtlLVFNy5jl826EKwt/mVyK/ZHYExkkw20Yyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB8013

The current FEC driver uses a single default rx-usecs coalescence setting
across all SoCs. This approach leads to suboptimal latency on newer, high
performance SoCs such as i.MX8QM and i.MX8M.

For example, the following are the ping result on a i.MX8QXP board:

$ ping 192.168.0.195
PING 192.168.0.195 (192.168.0.195) 56(84) bytes of data.
64 bytes from 192.168.0.195: icmp_seq=1 ttl=64 time=1.32 ms
64 bytes from 192.168.0.195: icmp_seq=2 ttl=64 time=1.31 ms
64 bytes from 192.168.0.195: icmp_seq=3 ttl=64 time=1.33 ms
64 bytes from 192.168.0.195: icmp_seq=4 ttl=64 time=1.33 ms

The current default rx-usecs value of 1000us was originally optimized for
CPU-bound systems like i.MX2x and i.MX6x. However, for i.MX8 and later
generations, CPU performance is no longer a limiting factor. Consequently,
the rx-usecs value should be reduced to enhance receive latency.

The following are the ping result with the 100us setting:

$ ping 192.168.0.195
PING 192.168.0.195 (192.168.0.195) 56(84) bytes of data.
64 bytes from 192.168.0.195: icmp_seq=1 ttl=64 time=0.554 ms
64 bytes from 192.168.0.195: icmp_seq=2 ttl=64 time=0.499 ms
64 bytes from 192.168.0.195: icmp_seq=3 ttl=64 time=0.502 ms
64 bytes from 192.168.0.195: icmp_seq=4 ttl=64 time=0.486 ms

Performance testing using iperf revealed no noticeable impact on
network throughput or CPU utilization.

Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
---
Changes in V2:
- improved the commit comments and removed the fix tag per Andrew's feedback

 drivers/net/ethernet/freescale/fec_main.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index fb19295529a2..820122899691 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -99,6 +99,7 @@ static const u16 fec_enet_vlan_pri_to_queue[8] = {0, 0, 1, 1, 1, 2, 2, 2};

 struct fec_devinfo {
 	u32 quirks;
+	unsigned int rx_time_itr;
 };

 static const struct fec_devinfo fec_imx25_info = {
@@ -159,6 +160,7 @@ static const struct fec_devinfo fec_imx8mq_info = {
 		  FEC_QUIRK_CLEAR_SETUP_MII | FEC_QUIRK_HAS_MULTI_QUEUES |
 		  FEC_QUIRK_HAS_EEE | FEC_QUIRK_WAKEUP_FROM_INT2 |
 		  FEC_QUIRK_HAS_MDIO_C45,
+	.rx_time_itr = 100,
 };

 static const struct fec_devinfo fec_imx8qm_info = {
@@ -169,6 +171,7 @@ static const struct fec_devinfo fec_imx8qm_info = {
 		  FEC_QUIRK_HAS_RACC | FEC_QUIRK_HAS_COALESCE |
 		  FEC_QUIRK_CLEAR_SETUP_MII | FEC_QUIRK_HAS_MULTI_QUEUES |
 		  FEC_QUIRK_DELAYED_CLKS_SUPPORT | FEC_QUIRK_HAS_MDIO_C45,
+	.rx_time_itr = 100,
 };

 static const struct fec_devinfo fec_s32v234_info = {
@@ -4027,8 +4030,9 @@ static int fec_enet_init(struct net_device *ndev)
 #endif
 	fep->rx_pkts_itr = FEC_ITR_ICFT_DEFAULT;
 	fep->tx_pkts_itr = FEC_ITR_ICFT_DEFAULT;
-	fep->rx_time_itr = FEC_ITR_ICTT_DEFAULT;
 	fep->tx_time_itr = FEC_ITR_ICTT_DEFAULT;
+	if (fep->rx_time_itr == 0)
+		fep->rx_time_itr = FEC_ITR_ICTT_DEFAULT;

 	/* Check mask of the streaming and coherent API */
 	ret = dma_set_mask_and_coherent(&fep->pdev->dev, DMA_BIT_MASK(32));
@@ -4325,8 +4329,10 @@ fec_probe(struct platform_device *pdev)
 	dev_info = device_get_match_data(&pdev->dev);
 	if (!dev_info)
 		dev_info = (const struct fec_devinfo *)pdev->id_entry->driver_data;
-	if (dev_info)
+	if (dev_info) {
 		fep->quirks = dev_info->quirks;
+		fep->rx_time_itr = dev_info->rx_time_itr;
+	}

 	fep->netdev = ndev;
 	fep->num_rx_queues = num_rx_qs;
--
2.34.1



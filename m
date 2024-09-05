Return-Path: <netdev+bounces-125615-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 693D596DEA4
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 17:43:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 248AD283557
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 15:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 082B719E96D;
	Thu,  5 Sep 2024 15:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mGN/93BB"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2081.outbound.protection.outlook.com [40.107.237.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F88F19D895
	for <netdev@vger.kernel.org>; Thu,  5 Sep 2024 15:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725550962; cv=fail; b=P55WS0zA9eoIE8ctQ2gjHX3myb4bR2wBFAEPcWHh+ICCYZEXzAqQ6DWXms3PoqlN1+lo0mswIF6bzb2TWPu1jMeSKa4SA3i1n46XKKjbXwZAvbnY/FEAJHvqItxukYLwEFOLu3rEo8OcEXbwbewAmuZrHvAcCHvpM/KBOE12uPw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725550962; c=relaxed/simple;
	bh=on5fYF16aFJwZ8siTecCrKCVc4xheeKEl6q2x+u8iQo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=db7a9pZ7LJ0Y7z5op22og3r93rVLbMOst+aafZUD7pwrel0CBgkGyJmRf6F8u7+/9gQEdoN0kuXyZjWe52xxf5x57k4tbP7AzXN6SDu/uxYuCdcM1prSNSp0wGMfGOssCtoLMejTc22Fv3S+9Ew4r+tOxGFdxhB58wVGCQclJpA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mGN/93BB; arc=fail smtp.client-ip=40.107.237.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V/Mnhjy9w1AOhgQHhpn45Kn/ooKv96W93HX/B6pfaQHnnq/JhTSImSjNjjzy4YOdtyrBwPcGPV4KTOoH85c9k2Szy91JNjk6EpvaFdoyLWR5oPl2JBfsxlM4Uq2UKAo8Xdvue4nn180wY99RMIYfOW5ZlOCgki0ZavH/jlyFs8Uz33cehIH5jXOsBC4NRf8nsRRHaZyPWBpS47A2MRC8vTdvw/A/mJW7javTU9skvdEP2O0gICynxP3IKFcsoCZnTyXsLosXbwXyn+U2FdP1QDvOz5/65Ky3g+15PAVtHl/yDHwRX70FK+ISWtb2mUdBEthVwXaH5MWPvrw4HCAufg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pT6CByYbaiGSza8Panu2Twm08oVI32j5QqKA1qkzDCM=;
 b=QPbnCthq0COvVFh8dtKemOyJPvAqOA8Bhubq+FH1lOr6Ud3KSXjAVcYwtRHCvYZ3q1E/Ke1vG3F8ZjvSd07Uj/wazaFKYMKMmw4+GFO+NnuGeLr/Tw6oZbPnEigELS2f4UmaPawUGmDL97DenXB39JnPICM6C0dlXnRnIac9B15RrEKLISkleA+8QHpBLm6GFA7vEulnSiIhtvo1IOrO72CMp/L8vJQMnjFYEPI4ZHvUL0dwKbKHHETOMIOddVb0i2PohxKDcrKgf7dNmYIIZfmNLOY23Ij7VEAKhMnY78Y19Nygs7IWePwLMBQOe+greBnMZLQjFOI3GWqdmGCO8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pT6CByYbaiGSza8Panu2Twm08oVI32j5QqKA1qkzDCM=;
 b=mGN/93BBkbfaA8eivuq8LYjYx9np14yAjUbtGjuk25z1m5DOMnPLOMUPhdrFZAHhP7mz+GaMD9ZpJnQuTDyrbpjdILPWTmBs6+7GCFf+/VTuvzL60Y97zzO6Gxb0TZPxllNyJCG3U+5a9uboaYc9JayhLoAQs6FaKAl1FeGOM1I=
Received: from BYAPR07CA0096.namprd07.prod.outlook.com (2603:10b6:a03:12b::37)
 by CY5PR12MB6407.namprd12.prod.outlook.com (2603:10b6:930:3c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Thu, 5 Sep
 2024 15:42:37 +0000
Received: from SJ1PEPF00001CDF.namprd05.prod.outlook.com
 (2603:10b6:a03:12b:cafe::4f) by BYAPR07CA0096.outlook.office365.com
 (2603:10b6:a03:12b::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27 via Frontend
 Transport; Thu, 5 Sep 2024 15:42:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ1PEPF00001CDF.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Thu, 5 Sep 2024 15:42:32 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 5 Sep
 2024 10:42:30 -0500
Received: from xcbecree42x.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Thu, 5 Sep 2024 10:42:29 -0500
From: <edward.cree@amd.com>
To: <linux-net-drivers@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: Edward Cree <ecree.xilinx@gmail.com>, <netdev@vger.kernel.org>,
	<habetsm.xilinx@gmail.com>, <jacob.e.keller@intel.com>
Subject: [PATCH v2 net-next 6/6] sfc: add per-queue RX and TX bytes stats
Date: Thu, 5 Sep 2024 16:41:35 +0100
Message-ID: <fe0d5819436883d3ba74a5103325de741d6c3005.1725550155.git.ecree.xilinx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1725550154.git.ecree.xilinx@gmail.com>
References: <cover.1725550154.git.ecree.xilinx@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: edward.cree@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDF:EE_|CY5PR12MB6407:EE_
X-MS-Office365-Filtering-Correlation-Id: c8e5e01a-d0f8-41af-9874-08dccdc15b2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vig36wj7kHavGepxoc9AyCzQjS/ncuzs7Wf2NMYNpHn/YZwVHt9UJbNloZ8B?=
 =?us-ascii?Q?OL5E+TdbrecAE5YSy/Cwnq1F20215xTpBbQ6U5wkkS/deORSBNEGPg8Q3xcN?=
 =?us-ascii?Q?m7awIkBWCrzbKJSzf6YONVyhc6Gq9B20kIdwnD3nenWdaA5bEItROiIHTLYa?=
 =?us-ascii?Q?JycT6EYtIxe1Lc/exXFA8GUmINENzq1hhYm0B83BQwvM0k3VG1VtiPWpWpLC?=
 =?us-ascii?Q?2itbC8Hq2397eWCWGfFopZdUIvxKUH5D/0nFH2ADvEzcpy780uuCs99Jr5Mj?=
 =?us-ascii?Q?RPMpc0GI8/VyDd+6YfQ4ij9mqwrZA7ZhuWDkPzbvDX7kgB9TfInEPbJivNve?=
 =?us-ascii?Q?AavDukUaZl4dc0GVgeHHbYjbDjSTgvE9RlPjQ5hCEzD9ojbSyBpLiSg9CHtT?=
 =?us-ascii?Q?pMXe9Ve4yj+CJhAraDCez1Hgye5obY+JRG23RrRnmgS9Jd+D7VxUWsPIXUDc?=
 =?us-ascii?Q?TYQKlEs8Hr71GksQp5c/kegBrYTPugtGU8rfLByfc1iWIdBpZYT2wfso/y2S?=
 =?us-ascii?Q?m5I9QeyGJJrCfZczJ52gt4qlMIQNdSDZxf2lStOylm/k/QqX1BD4/tLYUC1e?=
 =?us-ascii?Q?6CEDwyXuG2tk8zTL0K8MoRQW8F3CxbZAizFf1a1kmiTVdlK26moz5tEsuQVj?=
 =?us-ascii?Q?aBu1N/HrmPJNEyl7jUT3KH5s0ZqDpS1M5LeW1HpNEFiPtMNTXT528fR6y4pD?=
 =?us-ascii?Q?ZRykRm2KzI0rMj3Px7XdMlmwJh8pS2TaNHtHWIIiG1NGGYqpqAzTpnGPvCBr?=
 =?us-ascii?Q?v2QrlZC7dX4ljRlqU8iDUj1LqAQH4QRAlbErwqNmOE6AzIUx3GS3SxssElDX?=
 =?us-ascii?Q?3++E2PzOi6gsYf5oKKY8AZm81rQ0uQvByJJWO8qOveYmK9lx8Xjp55o7J+69?=
 =?us-ascii?Q?5XrQ9wJffIejHUqYh49dzzS5FCjozfsc6L9PQNcAPllWyp8rsAPVbEnOtU3t?=
 =?us-ascii?Q?RyQgIi91RG7pGH01gVdqEYitX6GgNu0X61SDmczznYGKIRnLXqh9xulrAWcM?=
 =?us-ascii?Q?/h568NPvXM42PCPJV1c7tfS9qbzySMMi5TujkoOwkEy4xWvWBBz0K3dtE1Ky?=
 =?us-ascii?Q?Wyh4tokhQHWi+DWF2//b+0opIwfcl2BkXsVDXN3xWiRHPpXkL9SBooJWFigj?=
 =?us-ascii?Q?wGloA4boGB37fVYRtI29yMj3+CTzcc7xpVmgy9z2szfmCxW4jeynxPkTkY55?=
 =?us-ascii?Q?8IyMkAtdXDz2x4BBQpzhrU2bRXpsiphkDERAFpRiGlGWf6MVhlBxdBCorigL?=
 =?us-ascii?Q?j2fyhm9pfManzdnOD6WinZaGJ9qDJcFF2AVO6MFQ64r1ACqXdlHJRkO89iX+?=
 =?us-ascii?Q?rikOZceLF+68PpeDsXZ/am4dOPsDOARwjuWOOC7s7LYU9AR/OOBes487Eph9?=
 =?us-ascii?Q?3J07VbTgJNKtvvMmjmJvyZopm7tRcXOu+SSGXMqPz9UtAppUoelTYXNGzjAy?=
 =?us-ascii?Q?hdfoIAUsZPxBHnAytIwWTVLN8m6ywNdh?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 15:42:32.0458
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8e5e01a-d0f8-41af-9874-08dccdc15b2d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CDF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6407

From: Edward Cree <ecree.xilinx@gmail.com>

While this does add overhead to the fast path, it should be minimal
 as the cacheline should already be held for write from updating the
 queue's [tr]x_packets stat.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>
---
 drivers/net/ethernet/sfc/ef100_rx.c   |  1 +
 drivers/net/ethernet/sfc/ef100_tx.c   |  1 +
 drivers/net/ethernet/sfc/efx.c        | 10 ++++++++++
 drivers/net/ethernet/sfc/net_driver.h | 10 ++++++++++
 drivers/net/ethernet/sfc/rx.c         |  1 +
 drivers/net/ethernet/sfc/rx_common.c  |  1 +
 drivers/net/ethernet/sfc/tx.c         |  2 ++
 drivers/net/ethernet/sfc/tx_common.c  |  1 +
 8 files changed, 27 insertions(+)

diff --git a/drivers/net/ethernet/sfc/ef100_rx.c b/drivers/net/ethernet/sfc/ef100_rx.c
index 992151775cb8..44dc75feb162 100644
--- a/drivers/net/ethernet/sfc/ef100_rx.c
+++ b/drivers/net/ethernet/sfc/ef100_rx.c
@@ -135,6 +135,7 @@ void __ef100_rx_packet(struct efx_channel *channel)
 	}
 
 	++rx_queue->rx_packets;
+	rx_queue->rx_bytes += rx_buf->len;
 
 	efx_rx_packet_gro(channel, rx_buf, channel->rx_pkt_n_frags, eh, csum);
 	goto out;
diff --git a/drivers/net/ethernet/sfc/ef100_tx.c b/drivers/net/ethernet/sfc/ef100_tx.c
index e6b6be549581..a7e30289e231 100644
--- a/drivers/net/ethernet/sfc/ef100_tx.c
+++ b/drivers/net/ethernet/sfc/ef100_tx.c
@@ -493,6 +493,7 @@ int __ef100_enqueue_skb(struct efx_tx_queue *tx_queue, struct sk_buff *skb,
 	} else {
 		tx_queue->tx_packets++;
 	}
+	tx_queue->tx_bytes += skb->len;
 	return 0;
 
 err:
diff --git a/drivers/net/ethernet/sfc/efx.c b/drivers/net/ethernet/sfc/efx.c
index 4b546f61dfaf..6c709d92e299 100644
--- a/drivers/net/ethernet/sfc/efx.c
+++ b/drivers/net/ethernet/sfc/efx.c
@@ -638,6 +638,7 @@ static void efx_get_queue_stats_rx(struct net_device *net_dev, int idx,
 	rx_queue = efx_channel_get_rx_queue(channel);
 	/* Count only packets since last time datapath was started */
 	stats->packets = rx_queue->rx_packets - rx_queue->old_rx_packets;
+	stats->bytes = rx_queue->rx_bytes - rx_queue->old_rx_bytes;
 	stats->hw_drops = efx_get_queue_stat_rx_hw_drops(channel) -
 			  channel->old_n_rx_hw_drops;
 	stats->hw_drop_overruns = channel->n_rx_nodesc_trunc -
@@ -653,6 +654,7 @@ static void efx_get_queue_stats_tx(struct net_device *net_dev, int idx,
 
 	channel = efx_get_tx_channel(efx, idx);
 	stats->packets = 0;
+	stats->bytes = 0;
 	stats->hw_gso_packets = 0;
 	stats->hw_gso_wire_packets = 0;
 	/* If a TX channel has XDP TXQs, the stats for these will be counted
@@ -664,6 +666,8 @@ static void efx_get_queue_stats_tx(struct net_device *net_dev, int idx,
 		if (!tx_queue->xdp_tx) {
 			stats->packets += tx_queue->tx_packets -
 					  tx_queue->old_tx_packets;
+			stats->bytes += tx_queue->tx_bytes -
+					tx_queue->old_tx_bytes;
 			stats->hw_gso_packets += tx_queue->tso_bursts -
 						 tx_queue->old_tso_bursts;
 			stats->hw_gso_wire_packets += tx_queue->tso_packets -
@@ -681,9 +685,11 @@ static void efx_get_base_stats(struct net_device *net_dev,
 	struct efx_channel *channel;
 
 	rx->packets = 0;
+	rx->bytes = 0;
 	rx->hw_drops = 0;
 	rx->hw_drop_overruns = 0;
 	tx->packets = 0;
+	tx->bytes = 0;
 	tx->hw_gso_packets = 0;
 	tx->hw_gso_wire_packets = 0;
 
@@ -694,10 +700,12 @@ static void efx_get_base_stats(struct net_device *net_dev,
 		rx_queue = efx_channel_get_rx_queue(channel);
 		if (channel->channel >= net_dev->real_num_rx_queues) {
 			rx->packets += rx_queue->rx_packets;
+			rx->bytes += rx_queue->rx_bytes;
 			rx->hw_drops += efx_get_queue_stat_rx_hw_drops(channel);
 			rx->hw_drop_overruns += channel->n_rx_nodesc_trunc;
 		} else {
 			rx->packets += rx_queue->old_rx_packets;
+			rx->bytes += rx_queue->old_rx_bytes;
 			rx->hw_drops += channel->old_n_rx_hw_drops;
 			rx->hw_drop_overruns += channel->old_n_rx_hw_drop_overruns;
 		}
@@ -707,10 +715,12 @@ static void efx_get_base_stats(struct net_device *net_dev,
 						net_dev->real_num_tx_queues ||
 			    tx_queue->xdp_tx) {
 				tx->packets += tx_queue->tx_packets;
+				tx->bytes += tx_queue->tx_bytes;
 				tx->hw_gso_packets += tx_queue->tso_bursts;
 				tx->hw_gso_wire_packets += tx_queue->tso_packets;
 			} else {
 				tx->packets += tx_queue->old_tx_packets;
+				tx->bytes += tx_queue->old_tx_bytes;
 				tx->hw_gso_packets += tx_queue->old_tso_bursts;
 				tx->hw_gso_wire_packets += tx_queue->old_tso_packets;
 			}
diff --git a/drivers/net/ethernet/sfc/net_driver.h b/drivers/net/ethernet/sfc/net_driver.h
index 2cf2935a713c..147052c1e25a 100644
--- a/drivers/net/ethernet/sfc/net_driver.h
+++ b/drivers/net/ethernet/sfc/net_driver.h
@@ -233,7 +233,11 @@ struct efx_tx_buffer {
  * @cb_packets: Number of times the TX copybreak feature has been used
  * @notify_count: Count of notified descriptors to the NIC
  * @tx_packets: Number of packets sent since this struct was created
+ * @tx_bytes: Number of bytes sent since this struct was created.  For TSO,
+ *	counts the superframe size, not the sizes of generated frames on the
+ *	wire (i.e. the headers are only counted once)
  * @old_tx_packets: Value of @tx_packets as of last efx_init_tx_queue()
+ * @old_tx_bytes: Value of @tx_bytes as of last efx_init_tx_queue()
  * @old_tso_bursts: Value of @tso_bursts as of last efx_init_tx_queue()
  * @old_tso_packets: Value of @tso_packets as of last efx_init_tx_queue()
  * @empty_read_count: If the completion path has seen the queue as empty
@@ -285,7 +289,9 @@ struct efx_tx_queue {
 	unsigned int notify_count;
 	/* Statistics to supplement MAC stats */
 	unsigned long tx_packets;
+	unsigned long tx_bytes;
 	unsigned long old_tx_packets;
+	unsigned long old_tx_bytes;
 	unsigned int old_tso_bursts;
 	unsigned int old_tso_packets;
 
@@ -378,7 +384,9 @@ struct efx_rx_page_state {
  * @slow_fill: Timer used to defer efx_nic_generate_fill_event().
  * @grant_work: workitem used to grant credits to the MAE if @grant_credits
  * @rx_packets: Number of packets received since this struct was created
+ * @rx_bytes: Number of bytes received since this struct was created
  * @old_rx_packets: Value of @rx_packets as of last efx_init_rx_queue()
+ * @old_rx_bytes: Value of @rx_bytes as of last efx_init_rx_queue()
  * @xdp_rxq_info: XDP specific RX queue information.
  * @xdp_rxq_info_valid: Is xdp_rxq_info valid data?.
  */
@@ -415,7 +423,9 @@ struct efx_rx_queue {
 	struct work_struct grant_work;
 	/* Statistics to supplement MAC stats */
 	unsigned long rx_packets;
+	unsigned long rx_bytes;
 	unsigned long old_rx_packets;
+	unsigned long old_rx_bytes;
 	struct xdp_rxq_info xdp_rxq_info;
 	bool xdp_rxq_info_valid;
 };
diff --git a/drivers/net/ethernet/sfc/rx.c b/drivers/net/ethernet/sfc/rx.c
index f07495582125..ffca82207e47 100644
--- a/drivers/net/ethernet/sfc/rx.c
+++ b/drivers/net/ethernet/sfc/rx.c
@@ -393,6 +393,7 @@ void __efx_rx_packet(struct efx_channel *channel)
 	}
 
 	rx_queue->rx_packets++;
+	rx_queue->rx_bytes += rx_buf->len;
 
 	if (!efx_do_xdp(efx, channel, rx_buf, &eh))
 		goto out;
diff --git a/drivers/net/ethernet/sfc/rx_common.c b/drivers/net/ethernet/sfc/rx_common.c
index bdb4325a7c2c..ab358fe13e1d 100644
--- a/drivers/net/ethernet/sfc/rx_common.c
+++ b/drivers/net/ethernet/sfc/rx_common.c
@@ -242,6 +242,7 @@ void efx_init_rx_queue(struct efx_rx_queue *rx_queue)
 	rx_queue->page_recycle_full = 0;
 
 	rx_queue->old_rx_packets = rx_queue->rx_packets;
+	rx_queue->old_rx_bytes = rx_queue->rx_bytes;
 
 	/* Initialise limit fields */
 	max_fill = efx->rxq_entries - EFX_RXD_HEAD_ROOM;
diff --git a/drivers/net/ethernet/sfc/tx.c b/drivers/net/ethernet/sfc/tx.c
index fe2d476028e7..1aea19488a56 100644
--- a/drivers/net/ethernet/sfc/tx.c
+++ b/drivers/net/ethernet/sfc/tx.c
@@ -394,6 +394,7 @@ netdev_tx_t __efx_enqueue_skb(struct efx_tx_queue *tx_queue, struct sk_buff *skb
 	} else {
 		tx_queue->tx_packets++;
 	}
+	tx_queue->tx_bytes += skb_len;
 
 	return NETDEV_TX_OK;
 
@@ -490,6 +491,7 @@ int efx_xdp_tx_buffers(struct efx_nic *efx, int n, struct xdp_frame **xdpfs,
 		tx_buffer->dma_offset = 0;
 		tx_buffer->unmap_len = len;
 		tx_queue->tx_packets++;
+		tx_queue->tx_bytes += len;
 	}
 
 	/* Pass mapped frames to hardware. */
diff --git a/drivers/net/ethernet/sfc/tx_common.c b/drivers/net/ethernet/sfc/tx_common.c
index cd0857131aa8..7ef2baa3439a 100644
--- a/drivers/net/ethernet/sfc/tx_common.c
+++ b/drivers/net/ethernet/sfc/tx_common.c
@@ -87,6 +87,7 @@ void efx_init_tx_queue(struct efx_tx_queue *tx_queue)
 	tx_queue->completed_timestamp_minor = 0;
 
 	tx_queue->old_tx_packets = tx_queue->tx_packets;
+	tx_queue->old_tx_bytes = tx_queue->tx_bytes;
 	tx_queue->old_tso_bursts = tx_queue->tso_bursts;
 	tx_queue->old_tso_packets = tx_queue->tso_packets;
 


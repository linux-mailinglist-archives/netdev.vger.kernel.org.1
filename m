Return-Path: <netdev+bounces-122787-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6B9B962921
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 15:46:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C95028422D
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 13:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 207822D600;
	Wed, 28 Aug 2024 13:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="L2etoc4/"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2074.outbound.protection.outlook.com [40.107.95.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2933A1DFE3
	for <netdev@vger.kernel.org>; Wed, 28 Aug 2024 13:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724852763; cv=fail; b=pFK2tt68HvEZ+/6++Km9IJTQ9oJvKhleUFcebZ2il5Wi46BSaXAeBort+nKGGpU1kqNjHwzeYRnazvrgJ938/U2U2qC7hn3qE6eIWKR2S6+U/oGLETj7NaUSKzZcHDvTi0mSZ+Us3oy0H57KNuRlaUAB7NBqvLf4ER1K8XtwO0w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724852763; c=relaxed/simple;
	bh=AlPgx2TkTLWjeDDUns5chyOH8xCUsAgzc/pY7s5GoZk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e3ujn5h9ozOlLqucj9cygdLt4P1NM8VUWkAuzH+YkgczoGkcrxL0R9BTaTUWs8VEwBF2VQgCpikxLK8kI8Irzmw4oaIJLQJpAZMTRgPnAW3QmaqaoR24hIfEAt9wvF8ek4dmpF7z6Av8J4jEHTjIXcqfz+YPpextbdwpfAU6Wc4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=L2etoc4/; arc=fail smtp.client-ip=40.107.95.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IXeO2jlC+9mYH7fbALy9WBGDnWvc3nxUOzdbdAHtrVpQYkuV5HZ7xEUZ2nxgU0/5gl07t9e7inwDtMXKC2XRGr0r7KnqzXRVOwdXWDmq3bCmnrCZYVommpN22sKuLSTW4VgY0yGLE2chT63/1W+sArwoXuk+++Vgiq4Y18WryQZstprR3lXzxD/F6Kkk5c0qUMDfHY7cU2uWf3mqGe9khfBv7LWfKudxoUaww2GqUa3xp99XRN1bN+vth516ajW4L3fhiMqWyomBAPVQSsK7z1T6p0LghzVJxFXll86Jf+1vXdKlyLpgweljnvh8GeS5/SEKc49UiVIx5DFds92nPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KlWnmDJkQwQnLTXFtESBviLWmbFO2A/nS2TG0yBpnxs=;
 b=aIS2tnmMZ6WNiruuLo5Vy+b/962qkkXtdFYK8bVPeoe2ivecQd+e0hC22cebvlzIfQoHBIzjab6SFGfIxarPKtY5KQewO478tNvYmJdDOJF2EvJndqZfnSc/3hexDZpPn9wf5/y3iZw8MwiaJDIHdsjQ7oWzIZTDmNYihZcYQN182+aN5XVkl+e1IRO+EBpiSjj3kHBKUkLKxHKi5ckpGi5hqYbIJFH5RNW3XPS7VWizcAYQdmBlBs9OfrNe4YTcTjlcUNvMdr2vc2TCMU+qBbXOTGHyS3AlE1PswLGNN6fD+3MUHOoPGkovSo2cXaw9hgmnv/PIwoXolxG4TkhKbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KlWnmDJkQwQnLTXFtESBviLWmbFO2A/nS2TG0yBpnxs=;
 b=L2etoc4/wUYV2X5c2kfksm/0s5jmfSj/MGNyp189gMJBRJPpaVrmsZZhXUPaoDsmjg30vfKkUG2ldzHKrByhlJZvmsPWVjSW7abMpQuZovkj82z/zshlxoeTwQdIrbuIWz/L86UbP9wATk+RxKplyi1jqcgMvVYq0cV90pDGdAw=
Received: from BL0PR02CA0142.namprd02.prod.outlook.com (2603:10b6:208:35::47)
 by DM4PR12MB5867.namprd12.prod.outlook.com (2603:10b6:8:66::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.28; Wed, 28 Aug
 2024 13:45:58 +0000
Received: from BL6PEPF0001AB76.namprd02.prod.outlook.com
 (2603:10b6:208:35:cafe::8f) by BL0PR02CA0142.outlook.office365.com
 (2603:10b6:208:35::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.27 via Frontend
 Transport; Wed, 28 Aug 2024 13:45:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB76.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Wed, 28 Aug 2024 13:45:57 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 28 Aug
 2024 08:45:56 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 28 Aug
 2024 08:45:56 -0500
Received: from xcbecree42x.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Wed, 28 Aug 2024 08:45:55 -0500
From: <edward.cree@amd.com>
To: <linux-net-drivers@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: Edward Cree <ecree.xilinx@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH net-next 2/6] sfc: implement basic per-queue stats
Date: Wed, 28 Aug 2024 14:45:11 +0100
Message-ID: <54cf35ea0d5c0ec46e0717a6181daaa2419ca91e.1724852597.git.ecree.xilinx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1724852597.git.ecree.xilinx@gmail.com>
References: <cover.1724852597.git.ecree.xilinx@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: edward.cree@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB76:EE_|DM4PR12MB5867:EE_
X-MS-Office365-Filtering-Correlation-Id: 23d270be-d31b-4066-9d7a-08dcc767bea9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?igJXuUc4azV3a5odn/DBukwROEkDSsLamtoC+WAzdWZX+RhP9Fc95PR5o17m?=
 =?us-ascii?Q?NXw96MM2KWUgKAUcz0KOjyNA1v9P1Ja/SVbpRCHmQRmkRBWcN+IaQGWLEQkJ?=
 =?us-ascii?Q?A20nYg8m32QUjuYuEfsLcg9XQvTpvcLCmZ1ccpaj8HBq12rMKPumxKWvvG9h?=
 =?us-ascii?Q?sT8Nz0FcVU31X/TYKfoON7GlyMndUIK0qbSdiL/NM3ek5TfkainMYg/EcSbb?=
 =?us-ascii?Q?ynhoc1RYyFZOnAYPvLX4ktL1hUcR0brDkCeai7f5in5NL8OT1Ym2WVVrN+e9?=
 =?us-ascii?Q?XK8h/sU0XmDqujBjsGJmhpIkaQPgyOs4pBxeTOM/BWe7t9Il2CIve1uwl8z6?=
 =?us-ascii?Q?bN2d/BN3aElCLu25U9W7A+kK08cV7MIXTTDLHrtst9zxylCH4k87zCJjXj1S?=
 =?us-ascii?Q?OOZKaB1Au8shw70qbQciyDSnviJEFDfwFG4GXirIET7NGtoNHnYAukmBBjiV?=
 =?us-ascii?Q?XmnA63FA2EdOIkgIm2DaPYVWjUSdwG48QW5k8PHhkHNEM7CWFfTxfG6d+MIP?=
 =?us-ascii?Q?4ciHlq3bgJcdPu4tiQkA8LpjWjANMUrw2v53Id2zxe/k+aLI0n/CMjFlfoEL?=
 =?us-ascii?Q?7Q1kvpf0wagjWzDu3vHezcjapiFx69vT8cGFNaXrRVBXnlGNvNpRxzv8MN+z?=
 =?us-ascii?Q?md0Zx2lYiQymzxZP1w1fShuKZeOCWb4Rlv/o7ljeuwCdp0C6v5YzMzSmmgbf?=
 =?us-ascii?Q?aUm6ERsL/rZTNiANwQ6rsOT/DXITtftykEOfFMKGhXdLLPOD7kRgwSRwgHb5?=
 =?us-ascii?Q?SlVckcbzgtJTCEp3zSDlBWwCrcLILNemjfqJfuftPLxSn0LTif/gIEJp1Q2L?=
 =?us-ascii?Q?DBIgn6svfGVHjk36ympThIUq+BMa7xbEj97KtFGt+89wlu3YWZbu+NEdEV4K?=
 =?us-ascii?Q?LiowJWFLWAx52eTCQ1RONd7KAKD52dAMiqJy6S+o78q4a+fP6SO1JSNBQaNu?=
 =?us-ascii?Q?XpJZCTcJY643gTadwgsa2J/AncNuJhwQl1wo4pL1r3EVghpDJXzLwVxCzGuh?=
 =?us-ascii?Q?ZPdeayWnpIwxT+15U2Hwd4BWRY6HfSf7MkVyR5jmVIspe3OFOrfbMw/7hyCh?=
 =?us-ascii?Q?jvi0VqQI095+zkQvICzDYIoNdxIOlcy0iYtkZS46H1qjblV9g9dyp3VneGQl?=
 =?us-ascii?Q?gPV9NoY+9PR1nv+j3Gvpw1mK8a/RTJdDpuxvs/Chz11oBZeDNl/9rV6J1Gm/?=
 =?us-ascii?Q?DFOKe2pJj+WgB0rCbrB2YZaMfkaSKxKEX6b64XORei3keq+ZPFUlCOLtpVPl?=
 =?us-ascii?Q?re7Lq3Oe3+s8S4I3nXg1w2q+S0UNS6qaTq8VhsFhkhKejWQODyuXJMWuV9qe?=
 =?us-ascii?Q?Qs0WF3f64BCTmQoQGcWY3zN+j+L71YXNSzvHwTZiaPTX8/rvcML7YPN9WKWD?=
 =?us-ascii?Q?hJ4br26m/2e0BiTiPuvgRg1NOAyyxyrnFx42ekxINRjoskwFFnZgPUftduTz?=
 =?us-ascii?Q?hsEDLC9VbKRtef6Uf3S/PYad4+1mHkMX?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 13:45:57.3488
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23d270be-d31b-4066-9d7a-08dcc767bea9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB76.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5867

From: Edward Cree <ecree.xilinx@gmail.com>

Just RX and TX packet counts for now.  We do not have per-queue
 byte counts, which causes us to fail stats.pkt_byte_sum selftest
 with "Drivers should always report basic keys" error.
Per-queue counts are since the last time the queue was inited
 (typically by efx_start_datapath(), on ifup or reconfiguration);
 device-wide total (efx_get_base_stats()) is since driver probe.
 This is not the same lifetime as rtnl_link_stats64, which uses
 firmware stats which count since FW (re)booted; this can cause a
 "Qstats are lower" or "RTNL stats are lower" failure in
 stats.pkt_byte_sum selftest.
Move the increment of rx_queue->rx_packets to match the semantics
 specified for netdev per-queue stats, i.e. just before handing
 the packet to XDP (if present) or the netstack (through GRO).
 This will affect the existing ethtool -S output which also
 reports these counters.

Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>
---
 drivers/net/ethernet/sfc/ef100_rx.c     |  4 +-
 drivers/net/ethernet/sfc/efx.c          | 72 +++++++++++++++++++++++++
 drivers/net/ethernet/sfc/efx_channels.h |  1 -
 drivers/net/ethernet/sfc/net_driver.h   |  6 +++
 drivers/net/ethernet/sfc/rx.c           |  4 +-
 drivers/net/ethernet/sfc/rx_common.c    |  2 +
 drivers/net/ethernet/sfc/tx_common.c    |  2 +
 7 files changed, 86 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/sfc/ef100_rx.c b/drivers/net/ethernet/sfc/ef100_rx.c
index 83d9db71d7d7..992151775cb8 100644
--- a/drivers/net/ethernet/sfc/ef100_rx.c
+++ b/drivers/net/ethernet/sfc/ef100_rx.c
@@ -134,6 +134,8 @@ void __ef100_rx_packet(struct efx_channel *channel)
 		goto free_rx_buffer;
 	}
 
+	++rx_queue->rx_packets;
+
 	efx_rx_packet_gro(channel, rx_buf, channel->rx_pkt_n_frags, eh, csum);
 	goto out;
 
@@ -149,8 +151,6 @@ static void ef100_rx_packet(struct efx_rx_queue *rx_queue, unsigned int index)
 	struct efx_channel *channel = efx_rx_queue_channel(rx_queue);
 	struct efx_nic *efx = rx_queue->efx;
 
-	++rx_queue->rx_packets;
-
 	netif_vdbg(efx, rx_status, efx->net_dev,
 		   "RX queue %d received id %x\n",
 		   efx_rx_queue_index(rx_queue), index);
diff --git a/drivers/net/ethernet/sfc/efx.c b/drivers/net/ethernet/sfc/efx.c
index 6f1a01ded7d4..e4656efce969 100644
--- a/drivers/net/ethernet/sfc/efx.c
+++ b/drivers/net/ethernet/sfc/efx.c
@@ -22,6 +22,7 @@
 #include "net_driver.h"
 #include <net/gre.h>
 #include <net/udp_tunnel.h>
+#include <net/netdev_queues.h>
 #include "efx.h"
 #include "efx_common.h"
 #include "efx_channels.h"
@@ -626,6 +627,76 @@ static const struct net_device_ops efx_netdev_ops = {
 	.ndo_bpf		= efx_xdp
 };
 
+static void efx_get_queue_stats_rx(struct net_device *net_dev, int idx,
+				   struct netdev_queue_stats_rx *stats)
+{
+	struct efx_nic *efx = efx_netdev_priv(net_dev);
+	struct efx_rx_queue *rx_queue;
+	struct efx_channel *channel;
+
+	channel = efx_get_channel(efx, idx);
+	rx_queue = efx_channel_get_rx_queue(channel);
+	/* Count only packets since last time datapath was started */
+	stats->packets = rx_queue->rx_packets - rx_queue->old_rx_packets;
+}
+
+static void efx_get_queue_stats_tx(struct net_device *net_dev, int idx,
+				   struct netdev_queue_stats_tx *stats)
+{
+	struct efx_nic *efx = efx_netdev_priv(net_dev);
+	struct efx_tx_queue *tx_queue;
+	struct efx_channel *channel;
+
+	channel = efx_get_tx_channel(efx, idx);
+	stats->packets = 0;
+	/* If a TX channel has XDP TXQs, the stats for these will be counted
+	 * under the channel rather than in base stats.  Unclear whether this
+	 * is correct behaviour, but we can't reliably exclude XDP TXes from
+	 * these stats anyway because in EFX_XDP_TX_QUEUES_BORROWED we use
+	 * the same TXQ as the core.
+	 */
+	efx_for_each_channel_tx_queue(tx_queue, channel)
+		stats->packets += tx_queue->tx_packets - tx_queue->old_tx_packets;
+}
+
+static void efx_get_base_stats(struct net_device *net_dev,
+			       struct netdev_queue_stats_rx *rx,
+			       struct netdev_queue_stats_tx *tx)
+{
+	struct efx_nic *efx = efx_netdev_priv(net_dev);
+	struct efx_tx_queue *tx_queue;
+	struct efx_rx_queue *rx_queue;
+	struct efx_channel *channel;
+
+	rx->packets = 0;
+	tx->packets = 0;
+
+	/* Count all packets on non-core queues, and packets before last
+	 * datapath start on core queues.
+	 */
+	efx_for_each_channel(channel, efx) {
+		rx_queue = efx_channel_get_rx_queue(channel);
+		if (channel->channel >= net_dev->real_num_rx_queues)
+			rx->packets += rx_queue->rx_packets;
+		else
+			rx->packets += rx_queue->old_rx_packets;
+		efx_for_each_channel_tx_queue(tx_queue, channel) {
+			if (channel->channel < efx->tx_channel_offset ||
+			    channel->channel >= efx->tx_channel_offset +
+						net_dev->real_num_tx_queues)
+				tx->packets += tx_queue->tx_packets;
+			else
+				tx->packets += tx_queue->old_tx_packets;
+		}
+	}
+}
+
+static const struct netdev_stat_ops efx_stat_ops = {
+	.get_queue_stats_rx	= efx_get_queue_stats_rx,
+	.get_queue_stats_tx	= efx_get_queue_stats_tx,
+	.get_base_stats		= efx_get_base_stats,
+};
+
 static int efx_xdp_setup_prog(struct efx_nic *efx, struct bpf_prog *prog)
 {
 	struct bpf_prog *old_prog;
@@ -716,6 +787,7 @@ static int efx_register_netdev(struct efx_nic *efx)
 	net_dev->watchdog_timeo = 5 * HZ;
 	net_dev->irq = efx->pci_dev->irq;
 	net_dev->netdev_ops = &efx_netdev_ops;
+	net_dev->stat_ops = &efx_stat_ops;
 	if (efx_nic_rev(efx) >= EFX_REV_HUNT_A0)
 		net_dev->priv_flags |= IFF_UNICAST_FLT;
 	net_dev->ethtool_ops = &efx_ethtool_ops;
diff --git a/drivers/net/ethernet/sfc/efx_channels.h b/drivers/net/ethernet/sfc/efx_channels.h
index 46b702648721..b3b5e18a69cc 100644
--- a/drivers/net/ethernet/sfc/efx_channels.h
+++ b/drivers/net/ethernet/sfc/efx_channels.h
@@ -49,5 +49,4 @@ void efx_fini_napi_channel(struct efx_channel *channel);
 void efx_fini_napi(struct efx_nic *efx);
 
 void efx_channel_dummy_op_void(struct efx_channel *channel);
-
 #endif
diff --git a/drivers/net/ethernet/sfc/net_driver.h b/drivers/net/ethernet/sfc/net_driver.h
index 4d904e1404d4..cc96716d8dbe 100644
--- a/drivers/net/ethernet/sfc/net_driver.h
+++ b/drivers/net/ethernet/sfc/net_driver.h
@@ -232,6 +232,8 @@ struct efx_tx_buffer {
  * @xmit_pending: Are any packets waiting to be pushed to the NIC
  * @cb_packets: Number of times the TX copybreak feature has been used
  * @notify_count: Count of notified descriptors to the NIC
+ * @tx_packets: Number of packets sent since this struct was created
+ * @old_tx_packets: Value of @tx_packets as of last efx_init_tx_queue()
  * @empty_read_count: If the completion path has seen the queue as empty
  *	and the transmission path has not yet checked this, the value of
  *	@read_count bitwise-added to %EFX_EMPTY_COUNT_VALID; otherwise 0.
@@ -281,6 +283,7 @@ struct efx_tx_queue {
 	unsigned int notify_count;
 	/* Statistics to supplement MAC stats */
 	unsigned long tx_packets;
+	unsigned long old_tx_packets;
 
 	/* Members shared between paths and sometimes updated */
 	unsigned int empty_read_count ____cacheline_aligned_in_smp;
@@ -370,6 +373,8 @@ struct efx_rx_page_state {
  * @recycle_count: RX buffer recycle counter.
  * @slow_fill: Timer used to defer efx_nic_generate_fill_event().
  * @grant_work: workitem used to grant credits to the MAE if @grant_credits
+ * @rx_packets: Number of packets received since this struct was created
+ * @old_rx_packets: Value of @rx_packets as of last efx_init_rx_queue()
  * @xdp_rxq_info: XDP specific RX queue information.
  * @xdp_rxq_info_valid: Is xdp_rxq_info valid data?.
  */
@@ -406,6 +411,7 @@ struct efx_rx_queue {
 	struct work_struct grant_work;
 	/* Statistics to supplement MAC stats */
 	unsigned long rx_packets;
+	unsigned long old_rx_packets;
 	struct xdp_rxq_info xdp_rxq_info;
 	bool xdp_rxq_info_valid;
 };
diff --git a/drivers/net/ethernet/sfc/rx.c b/drivers/net/ethernet/sfc/rx.c
index f77a2d3ef37e..f07495582125 100644
--- a/drivers/net/ethernet/sfc/rx.c
+++ b/drivers/net/ethernet/sfc/rx.c
@@ -125,8 +125,6 @@ void efx_rx_packet(struct efx_rx_queue *rx_queue, unsigned int index,
 	struct efx_channel *channel = efx_rx_queue_channel(rx_queue);
 	struct efx_rx_buffer *rx_buf;
 
-	rx_queue->rx_packets++;
-
 	rx_buf = efx_rx_buffer(rx_queue, index);
 	rx_buf->flags |= flags;
 
@@ -394,6 +392,8 @@ void __efx_rx_packet(struct efx_channel *channel)
 		goto out;
 	}
 
+	rx_queue->rx_packets++;
+
 	if (!efx_do_xdp(efx, channel, rx_buf, &eh))
 		goto out;
 
diff --git a/drivers/net/ethernet/sfc/rx_common.c b/drivers/net/ethernet/sfc/rx_common.c
index 0b7dc75c40f9..bdb4325a7c2c 100644
--- a/drivers/net/ethernet/sfc/rx_common.c
+++ b/drivers/net/ethernet/sfc/rx_common.c
@@ -241,6 +241,8 @@ void efx_init_rx_queue(struct efx_rx_queue *rx_queue)
 	rx_queue->page_recycle_failed = 0;
 	rx_queue->page_recycle_full = 0;
 
+	rx_queue->old_rx_packets = rx_queue->rx_packets;
+
 	/* Initialise limit fields */
 	max_fill = efx->rxq_entries - EFX_RXD_HEAD_ROOM;
 	max_trigger =
diff --git a/drivers/net/ethernet/sfc/tx_common.c b/drivers/net/ethernet/sfc/tx_common.c
index 2adb132b2f7e..f1694900e0f0 100644
--- a/drivers/net/ethernet/sfc/tx_common.c
+++ b/drivers/net/ethernet/sfc/tx_common.c
@@ -86,6 +86,8 @@ void efx_init_tx_queue(struct efx_tx_queue *tx_queue)
 	tx_queue->completed_timestamp_major = 0;
 	tx_queue->completed_timestamp_minor = 0;
 
+	tx_queue->old_tx_packets = tx_queue->tx_packets;
+
 	tx_queue->xdp_tx = efx_channel_is_xdp_tx(tx_queue->channel);
 	tx_queue->tso_version = 0;
 


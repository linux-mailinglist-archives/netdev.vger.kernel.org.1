Return-Path: <netdev+bounces-125610-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 066ED96DE9F
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 17:42:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27A8D1C23625
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 15:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E07A19DF82;
	Thu,  5 Sep 2024 15:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HQYCmPj5"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2060.outbound.protection.outlook.com [40.107.244.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65AAC19DF7D
	for <netdev@vger.kernel.org>; Thu,  5 Sep 2024 15:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725550955; cv=fail; b=sPOTWxZQYxjY55gqVvcSEyAQY76W2k1ky956CpGOiC1iHa9fuENgHBUZcZXfFtxZTMMQat6e21/zjJVcyuHGv4RAFH2YAk+fAzPy8StlGdjnyoPGU5eee6aM7wGH3tlP+KtKTrgU808x11yzaFLwU20HGKzXqT6bHDcus7D32v8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725550955; c=relaxed/simple;
	bh=8VOEc/NGYwPSiFlsth1x0apcZW2NrMfMRB9J4X5wMvY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RBpSgghXvHhv1+7dkGUW/9ZoIXyLfQpPbdV2MHd88jNo86DJ7lPy+EvW9pe2PeKxhvpQ7WcLpaJOFqzOG7n5MQNJfHPdChj3bSgtZIuu7cb5l292qVrOAnw1cjGNL7aUE28ibGJjKHryeYQbNZju6HaozcKi7vMIAu4GzCOoYdI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HQYCmPj5; arc=fail smtp.client-ip=40.107.244.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HhqycskQeK3auGCGC7wW+yh6VaXQG8+BVilxxZ5P4tGhPPIzUl2e7ofEQ0DDHsL3cMuw642c+Iabg2iROE4Lj2Zef5VKeKuPbKBHAs9UarICCmS7SVyyzZ3fLGqLMB6M7lmZPwL5FyRGI0beCd8aG7cqISoYGUSHGdIbJzf3pC34CBGt01vlWwHPZK1linCF09h9CYihbRPuYelM4lam5z0muFSNIfcI5sJFBZP5hB00+U2prUtxVnAVwo5j/1kfTgpc66px9XOR7Fs3/i5Wqc9j4K4kDOSKljXF3HQUQVWTwmN5xtt9+h3IyAC4sJ9/uBH/vS+GLoEcct0GZPhR/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5eO0/Lp3OKzkRZU6aHIQBb4nKw9snp7RTwkk0wPs4AU=;
 b=HLFbT3n3cKEC46ZEifQEMW6JtYNk1QZiFnZq7aUHm34KWcyyvFQZylorQqQ728D2GexngXzIc0HXPibSOci4B5x4LzPAH8Ha4HdNSKBuFsdc4PGol7jP0HWcElae1ySuUFAlfTemR9gITcHEREaL4S3I+DYzjFMdQewCjt7G7vqTcBsV3k29WCS88yQS/4zznciUZgqRWRR/a/ch8o+qioJpAsSY7KhoyKlVWD6M8OfW2dGI5IIuyWvfTrXjrHaTvkflK0ehFwJy2xjZyQTc159xP0lVdntqEaiKiKF/QmOCbbkiew8E9uqmn2kO9Hu5hWF070OhqYHCP/z70GBiTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5eO0/Lp3OKzkRZU6aHIQBb4nKw9snp7RTwkk0wPs4AU=;
 b=HQYCmPj5uwTG+uIVLcVqVDzdTq0tDHQ947DScrykpTQDU1KOkyQdauIp+K654Db2/EtYw7iBAM7AjSWldMBvMs12P/lL3f93Rirx6EP3bXgTAZw7fdlZ9NRJPrx1PJCaYDDqeZv5b08F5GbBO9Rw+GmYecRJO4SrR032d5plBtg=
Received: from BYAPR07CA0103.namprd07.prod.outlook.com (2603:10b6:a03:12b::44)
 by SJ0PR12MB6992.namprd12.prod.outlook.com (2603:10b6:a03:483::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Thu, 5 Sep
 2024 15:42:30 +0000
Received: from SJ1PEPF00001CDF.namprd05.prod.outlook.com
 (2603:10b6:a03:12b:cafe::77) by BYAPR07CA0103.outlook.office365.com
 (2603:10b6:a03:12b::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25 via Frontend
 Transport; Thu, 5 Sep 2024 15:42:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ1PEPF00001CDF.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Thu, 5 Sep 2024 15:42:30 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 5 Sep
 2024 10:42:25 -0500
Received: from xcbecree42x.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Thu, 5 Sep 2024 10:42:24 -0500
From: <edward.cree@amd.com>
To: <linux-net-drivers@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: Edward Cree <ecree.xilinx@gmail.com>, <netdev@vger.kernel.org>,
	<habetsm.xilinx@gmail.com>, <jacob.e.keller@intel.com>
Subject: [PATCH v2 net-next 2/6] sfc: implement basic per-queue stats
Date: Thu, 5 Sep 2024 16:41:31 +0100
Message-ID: <dbedc53fe6b2906beede93237071ddd2c56a170c.1725550154.git.ecree.xilinx@gmail.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDF:EE_|SJ0PR12MB6992:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c80ada6-dac1-4e4a-8e23-08dccdc15a60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ayeRCtXDJ04aZMYZQ0wWiIGkaqa6zyEgMKJXRfgb6jTJsnjhp1nlgfn7qdbS?=
 =?us-ascii?Q?gVsnAuekttIFQRaQPaIS18utxZwMlwxjw8WuSbRI6ngxsYyKeJ/BLNn2ZDjq?=
 =?us-ascii?Q?JDhe5b0TRrXA6Dc/FBaFa6iuK04BtxDYDPid6tYbDxvbsStaKxPrK2Fuv5dz?=
 =?us-ascii?Q?Cz830hFyX4g1/Om7+6UHiWECjLUDq336ZrVgulG6O2XNeXkZwksUPfX5NwtU?=
 =?us-ascii?Q?jKc/G+cUu8K2s1EXDEKeTi3h/RtGCr4UP+IOGso6g72QnLOQlAVXN6wh1XoV?=
 =?us-ascii?Q?s4gkq6oD3c6lgpujrVvwHHgHZze+qXt//ICW0woLXCh0YkxrU+VNdt84tVQj?=
 =?us-ascii?Q?X9u/3YxNEuIc0PWbHIMT6HFpJ0QaGx4FaFXEDgF3B3f6xMsoYNzme0yQXZLG?=
 =?us-ascii?Q?RczAheM2QShxnVs346SILma3RRZsL8oP8870MHw5EBo/9wwbCFCDIS4xh2ju?=
 =?us-ascii?Q?wMrCEY8n9/6rWB+oS1n/9hRdOVayMIYXre9AdUtpb+IQpg5vasx9rh6LsIzx?=
 =?us-ascii?Q?QefxAGjtGeo2q84GglZmF+iaTTc/k46ovCJnaqpxf23gimMSnSYxDNNp3v/N?=
 =?us-ascii?Q?xzQCHpx0++HWQlhVF9VZeWKqaFTKJ9yJiGgFrJQwhT+3RWfbPbtgrUEotVT4?=
 =?us-ascii?Q?YzqZAYf49CA+zwR+jvxoNXMwfowqirhHVQKfMrmu1QQbRSkXHycCVSqASOQS?=
 =?us-ascii?Q?YXOrQnHSqdNQJzfa5vR67HgO7lHOiUm3fcAoisdnmDhZkr9vm/5hSTyVnaUw?=
 =?us-ascii?Q?maaQcaIXOz2dldtUa6tXkGOnKI2vjeTCsOCZ+CBn4XOC/z2rNr9m0xWBflSe?=
 =?us-ascii?Q?enRQb7cRnddbK45r16GujTTDvS5UE5Q66PLw6KGgakWU42KhrvoTeot91MA0?=
 =?us-ascii?Q?XVCNo4UvqstadSO61oxgs0ES03lPNCGph/IKTOgXz+l8y9t7n5jNgLYp9bAU?=
 =?us-ascii?Q?UAb5pluQSL1Zuhm5AYk0Vs3ap7b8zS2ocBZ6XD/ETwNj2jNPCaO91Ipx3JIF?=
 =?us-ascii?Q?JwFIKsGNbcNDVCbHe2jl0Dr87bkqQzPL0jI0+J8WIpa5Edf40WN+jc16EMoN?=
 =?us-ascii?Q?1SI0oX5A+aPJ66byxRNUlRKiCeXr/r0v1z32qZocn/VQ6h2JDOjFV7jp/jBH?=
 =?us-ascii?Q?X3AZmk55iuABeNs1SXi3bRrybvWvv3NgjPzk1aTST8Y6YIO/ogYJKMtKJrwR?=
 =?us-ascii?Q?eo2pcqhPJY+705lbG3GjWMDOKWjAT+sieOseOHj5afqsh6idyzZVinKoqUAd?=
 =?us-ascii?Q?31Edpa4S2m93D+Vyx8tGGj05EL/1poUkB/z5RQxZrpXh0GSN+chCF5MtfSE7?=
 =?us-ascii?Q?o+M3VEbE9osuyu6WngVXgMdPHkQgpueUd7J/31wgJLEMa/62H8QGsTBk6nMX?=
 =?us-ascii?Q?YGGHrDhLvMWGU2KvjnE4EwSJNi6CT2A5/1mHZqyvOsUzCYoxt+K1DSWgkxOc?=
 =?us-ascii?Q?Yv/tBORq3zLciZN3jRrdymrAlkG+84kB?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 15:42:30.7021
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c80ada6-dac1-4e4a-8e23-08dccdc15a60
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CDF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6992

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
 drivers/net/ethernet/sfc/efx.c          | 74 +++++++++++++++++++++++++
 drivers/net/ethernet/sfc/efx_channels.h |  1 -
 drivers/net/ethernet/sfc/net_driver.h   |  6 ++
 drivers/net/ethernet/sfc/rx.c           |  4 +-
 drivers/net/ethernet/sfc/rx_common.c    |  2 +
 drivers/net/ethernet/sfc/tx_common.c    |  2 +
 7 files changed, 88 insertions(+), 5 deletions(-)

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
index 6f1a01ded7d4..9b0313cecc1d 100644
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
@@ -626,6 +627,78 @@ static const struct net_device_ops efx_netdev_ops = {
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
+	 * in base stats; however, in EFX_XDP_TX_QUEUES_BORROWED mode we use
+	 * the same TXQ as the core, and thus XDP TXes get included in these
+	 * per-queue stats.
+	 */
+	efx_for_each_channel_tx_queue(tx_queue, channel)
+		if (!tx_queue->xdp_tx)
+			stats->packets += tx_queue->tx_packets -
+					  tx_queue->old_tx_packets;
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
+						net_dev->real_num_tx_queues ||
+			    tx_queue->xdp_tx)
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
@@ -716,6 +789,7 @@ static int efx_register_netdev(struct efx_nic *efx)
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
 


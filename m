Return-Path: <netdev+bounces-130407-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 894D398A655
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 15:57:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD8D21C227D3
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 13:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B6C8191F98;
	Mon, 30 Sep 2024 13:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="f3B+K92M"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2066.outbound.protection.outlook.com [40.107.220.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A044718FDC3
	for <netdev@vger.kernel.org>; Mon, 30 Sep 2024 13:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727704423; cv=fail; b=WS+a7B/W3tRmRh9vQbty8hlVcdaB4DKFfJ+rLhTdYFzMcSMY6K0igDLUlFpyjQlDr9YA4xnpYyibG0MDrtuurA0VCB9RTBZGx/IGkyHEn3Y19Hq34TPlA20m0Mvmpu/yKWQYHFn/+IUdogwfxicp9KkPa7VnJIzlMpF2QWAXcaw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727704423; c=relaxed/simple;
	bh=Gf/1smqKic0fiAp+2C7CYv7gGvmcwUFshob5EwldZPA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xc/1AdEUQce/PlHA49Aem1Aok6iUPFX3igDpr8B0/M6moJ1UOowK4GTe7puQ41RhuHk5z4QwZ9CUVNTeXaIYz4hvupEhatc4KWglR1Jca2R9CA6FGpsZA9uPYAzWNY4nFVR1Mr0TX7kbM6jtM9l1arF9onWgR0li7YQj5sX0jdE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=f3B+K92M; arc=fail smtp.client-ip=40.107.220.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A++37dKIpzGfwo6bo0rEdc/TaHsUAD7N3v5gq1CxgPpGYTtP2SixMD3YAL5yd481AcDDcO61V/uvGDS2vTrV1wRT5LCWGJ1ETPlRfAIUY55SySPJB9zNigZ3JOdi/IcXKBFmd6GxGhHSbmE+ubetE0n3kbBhFuZCUH/LoR2OkCWaeu0fy7odVYrFY67zVPrdqW9xhJI/4HVgtMDk6qKzaQT7PK2ElF5YTCJ6VKyHcTPA/+XZDF4pXX2LA+hfyNV/1ravto2OW2rPYckb7lQzDbZSPORo2DmytLXoakDarFP24czKBT5H/1FO4V7XI+Q+vKwuVhseHB06tSS5gFTzGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/NYz787yAgl6vpZd7V5kOwziXwKb3nKPwDYHmV23RGY=;
 b=d4LcQbpsGf2Ir44OBi+pl+ntYdF3A2sbi+MAZQ7cTHSsNbXOesob+kJI4+Gzl7kbh/w8UKT0gq8hIXnRFVA3Oh105Ojngp4odCeuyotvJwRfz5X3HMElAwshgmOa7KAhkA5YrF/3kXLoUMepSDb9+5dMp5Lm9YPkrG/K0opCk0sc1Gt0weyVaThDLz/tIf4kkNiZmqSfyghy+X9mgOo3ANXa2PJl2ufbHWmzgC2iY4iIC0XUL+N3hLoR3CxI7PoOcgn+nC2crAbp9p8Vlp1iCs/daSlX586+kuKJKPxM/pMpykJGBeZgWoASOvX6IzVj2ztcpO4d0036//xiNeWdgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/NYz787yAgl6vpZd7V5kOwziXwKb3nKPwDYHmV23RGY=;
 b=f3B+K92MoW+aveR7TaQOzHGKKIGqFNjx7Ubqt9VqwRDYRnqKmfxz7nmDqRhQfp/grFaT75BLJ/BVGu9hlAqT0K+WA7hPEZZ5Y8LGpHaZgM/cddBnCKeveEJZY8kvMTHSDfDF+dDv7lCY4zlBz3wjX8uqviRF06rrXQzrSDdsNT0=
Received: from CH3P220CA0008.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1e8::19)
 by CH3PR12MB8994.namprd12.prod.outlook.com (2603:10b6:610:171::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27; Mon, 30 Sep
 2024 13:53:38 +0000
Received: from CH2PEPF0000014A.namprd02.prod.outlook.com
 (2603:10b6:610:1e8:cafe::59) by CH3P220CA0008.outlook.office365.com
 (2603:10b6:610:1e8::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27 via Frontend
 Transport; Mon, 30 Sep 2024 13:53:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000014A.mail.protection.outlook.com (10.167.244.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Mon, 30 Sep 2024 13:53:38 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 30 Sep
 2024 08:53:16 -0500
Received: from xcbecree42x.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Mon, 30 Sep 2024 08:53:15 -0500
From: <edward.cree@amd.com>
To: <linux-net-drivers@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: Edward Cree <ecree.xilinx@gmail.com>, <netdev@vger.kernel.org>,
	<habetsm.xilinx@gmail.com>, <jacob.e.keller@intel.com>
Subject: [PATCH v4 net-next 2/7] sfc: implement basic per-queue stats
Date: Mon, 30 Sep 2024 14:52:40 +0100
Message-ID: <f9c5d5c041f4fe8ab63d3ee558d01e0d79645837.1727703521.git.ecree.xilinx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1727703521.git.ecree.xilinx@gmail.com>
References: <cover.1727703521.git.ecree.xilinx@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: edward.cree@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000014A:EE_|CH3PR12MB8994:EE_
X-MS-Office365-Filtering-Correlation-Id: 288b86f8-60b1-40ed-eed1-08dce15748f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HxF3VLy/ujnmSPXzJ45cQ5USDv0X5WbnKpHH9YL7GotbOUji8e/YI3m7Y8b4?=
 =?us-ascii?Q?OmdgULBDD+SF8xe7ErZ8MlrzAx+R1spURsV0s/pi5lwMYdy9l1vFFJNX5slo?=
 =?us-ascii?Q?7QaCQaFbpBDY27tW46LtzPDIDEHpeFFWLPDDLSPaFQVp2wYCiAkQBJ1rXAS7?=
 =?us-ascii?Q?sfjIXaTQbGi1SZJ4//A61hhGHzBwpLN/BubQOl+F+Rry6NWOxvG8BnU4Xtky?=
 =?us-ascii?Q?xIio1kAiagj9q41f7zpTZyXGUgnD/zWrApofquZBIgqXtu9gunQaOBLF7Fta?=
 =?us-ascii?Q?8c8ECS8UMSA0OFE5fb5/fzDqS4lvQ1Ayfd+SIU0W/A0x0He7h6DWRnWQrJWm?=
 =?us-ascii?Q?igv3cfscv25iA60dc9Sa8pCigbI16wOVbmjOfhHWHvWN7NVUmP/bkGoDdKkz?=
 =?us-ascii?Q?Exumatn5t3Pru+Mt+gW477gk+JBJEkYP8OiqI+3fx4iJg/z4YDek/iY53ule?=
 =?us-ascii?Q?JotEiLv7DQgNuSILwagsYf+eQX3cWRpCjllVuRwRM3YCpQ/2D4R2zlj7H3Nq?=
 =?us-ascii?Q?y46BsQqvXE8T4wYTwDlnhoWB3CFgS+uucwDpXJzkBPKVTnFYZTota0Ga+sqq?=
 =?us-ascii?Q?U+iiYVKFZn5zGgRMmNBu4oIKkzSV6UFyJ5dXPuAiBTKdbRWYFB/nnWQGg8s5?=
 =?us-ascii?Q?69+2nuYcIp0M3VsKN/7WNKr0Jj0hHEdaR7/UUCLia0wQkZJSdpCpdN3i2vGC?=
 =?us-ascii?Q?6hCITYZPujytmq+Ix4EyFL/h0+ZuUaUJSi8idZPveCMCeCd72SowjdUNoicw?=
 =?us-ascii?Q?g129Sh9T0ovufMN6mmVBE/GtUTi2MdsZZNl0b8I7AEbfpXDq0JozxODkTO+N?=
 =?us-ascii?Q?GF+uDxui2KaR8jqAS2HzsMGRlLVB3YRGD7ipMt8GZxi7KGMzfJY7JMWqGNZv?=
 =?us-ascii?Q?RQ/awDVnnxdgaPLwcnl9rvsYeNZ+CPihAo6pAuqH4m9oVQRIxlkcsb7E9wc8?=
 =?us-ascii?Q?thi16TsodOFu3nMsYKRNWTl2TzaQJgw2QXGqWzbRyzl4QY+YK9vilIts9UEO?=
 =?us-ascii?Q?ZVQcxA2MlxRsFwI7AAs03XQyNGz1XgzwY/vtrGa9OMNKA1eIXbTI/PdoxmAm?=
 =?us-ascii?Q?uWp0/Zy50bAvXp+nkZIdKdVK8fBT8p9QYfU+s2nozl7MY7lPb1o8Uzmpx07C?=
 =?us-ascii?Q?+Rm3Sn0/Jm8a8XAEi7fYHPFrLl/BPl19VXJvuA3AddXPOthSKCXBAwcSTTJJ?=
 =?us-ascii?Q?Mfzq3ykXMIXvKUtihFB2gzwfsvXIhJe7+JAaNanV5AwzFTcDXNZGwzNO9DoH?=
 =?us-ascii?Q?N7hXFPvyWTeGEENt86jzZa2fG3yYMyeOItAt6pUkYdPdixR+r1uDDM8AI5Fi?=
 =?us-ascii?Q?7KkfJ2Zed8Rh1xmzfdc+/3VJNHCWkgFmM0qKzAqye5RQrkbTHnZp8Tf4UV6P?=
 =?us-ascii?Q?6UvK0H8=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 13:53:38.1180
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 288b86f8-60b1-40ed-eed1-08dce15748f3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000014A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8994

From: Edward Cree <ecree.xilinx@gmail.com>

Just RX and TX packet counts and TX bytes for now.  We do not
 have per-queue RX byte counts, which causes us to fail
 stats.pkt_byte_sum selftest with "Drivers should always report
 basic keys" error.
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
XDP TX packets are not yet counted into base_stats.

Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>
---
 drivers/net/ethernet/sfc/ef100_rx.c     |  4 +-
 drivers/net/ethernet/sfc/efx.c          | 75 +++++++++++++++++++++++++
 drivers/net/ethernet/sfc/efx_channels.c |  2 +
 drivers/net/ethernet/sfc/net_driver.h   | 22 ++++++++
 drivers/net/ethernet/sfc/rx.c           |  4 +-
 drivers/net/ethernet/sfc/rx_common.c    |  2 +
 drivers/net/ethernet/sfc/tx_common.c    |  3 +
 7 files changed, 108 insertions(+), 4 deletions(-)

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
index 36b3b57e2055..21dc4b885542 100644
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
@@ -626,6 +627,79 @@ static const struct net_device_ops efx_netdev_ops = {
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
+	stats->bytes = 0;
+	efx_for_each_channel_tx_queue(tx_queue, channel) {
+		stats->packets += tx_queue->complete_packets -
+				  tx_queue->old_complete_packets;
+		stats->bytes += tx_queue->complete_bytes -
+				tx_queue->old_complete_bytes;
+	}
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
+	tx->bytes = 0;
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
+						net_dev->real_num_tx_queues) {
+				tx->packets += tx_queue->complete_packets;
+				tx->bytes += tx_queue->complete_bytes;
+			} else {
+				tx->packets += tx_queue->old_complete_packets;
+				tx->bytes += tx_queue->old_complete_bytes;
+			}
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
@@ -716,6 +790,7 @@ static int efx_register_netdev(struct efx_nic *efx)
 	net_dev->watchdog_timeo = 5 * HZ;
 	net_dev->irq = efx->pci_dev->irq;
 	net_dev->netdev_ops = &efx_netdev_ops;
+	net_dev->stat_ops = &efx_stat_ops;
 	if (efx_nic_rev(efx) >= EFX_REV_HUNT_A0)
 		net_dev->priv_flags |= IFF_UNICAST_FLT;
 	net_dev->ethtool_ops = &efx_ethtool_ops;
diff --git a/drivers/net/ethernet/sfc/efx_channels.c b/drivers/net/ethernet/sfc/efx_channels.c
index c9e17a8208a9..834d51812e2b 100644
--- a/drivers/net/ethernet/sfc/efx_channels.c
+++ b/drivers/net/ethernet/sfc/efx_channels.c
@@ -1209,6 +1209,8 @@ static int efx_process_channel(struct efx_channel *channel, int budget)
 						  tx_queue->pkts_compl,
 						  tx_queue->bytes_compl);
 		}
+		tx_queue->complete_packets += tx_queue->pkts_compl;
+		tx_queue->complete_bytes += tx_queue->bytes_compl;
 	}
 
 	/* Receive any packets we queued up */
diff --git a/drivers/net/ethernet/sfc/net_driver.h b/drivers/net/ethernet/sfc/net_driver.h
index 4d904e1404d4..83c33c1ca120 100644
--- a/drivers/net/ethernet/sfc/net_driver.h
+++ b/drivers/net/ethernet/sfc/net_driver.h
@@ -193,6 +193,10 @@ struct efx_tx_buffer {
  * @initialised: Has hardware queue been initialised?
  * @timestamping: Is timestamping enabled for this channel?
  * @xdp_tx: Is this an XDP tx queue?
+ * @old_complete_packets: Value of @complete_packets as of last
+ *	efx_init_tx_queue()
+ * @old_complete_bytes: Value of @complete_bytes as of last
+ *	efx_init_tx_queue()
  * @read_count: Current read pointer.
  *	This is the number of buffers that have been removed from both rings.
  * @old_write_count: The value of @write_count when last checked.
@@ -202,6 +206,16 @@ struct efx_tx_buffer {
  *	avoid cache-line ping-pong between the xmit path and the
  *	completion path.
  * @merge_events: Number of TX merged completion events
+ * @bytes_compl: Number of bytes completed during this NAPI poll
+ *	(efx_process_channel()).  For BQL.
+ * @pkts_compl: Number of packets completed during this NAPI poll.
+ * @complete_packets: Number of packets completed since this struct was
+ *	created.  Only counts SKB packets, not XDP TX (it accumulates
+ *	the same values that are reported to BQL).
+ * @complete_bytes: Number of bytes completed since this struct was
+ *	created.  For TSO, counts the superframe size, not the sizes of
+ *	generated frames on the wire (i.e. the headers are only counted
+ *	once)
  * @completed_timestamp_major: Top part of the most recent tx timestamp.
  * @completed_timestamp_minor: Low part of the most recent tx timestamp.
  * @insert_count: Current insert pointer
@@ -232,6 +246,7 @@ struct efx_tx_buffer {
  * @xmit_pending: Are any packets waiting to be pushed to the NIC
  * @cb_packets: Number of times the TX copybreak feature has been used
  * @notify_count: Count of notified descriptors to the NIC
+ * @tx_packets: Number of packets sent since this struct was created
  * @empty_read_count: If the completion path has seen the queue as empty
  *	and the transmission path has not yet checked this, the value of
  *	@read_count bitwise-added to %EFX_EMPTY_COUNT_VALID; otherwise 0.
@@ -255,6 +270,8 @@ struct efx_tx_queue {
 	bool initialised;
 	bool timestamping;
 	bool xdp_tx;
+	unsigned long old_complete_packets;
+	unsigned long old_complete_bytes;
 
 	/* Members used mainly on the completion path */
 	unsigned int read_count ____cacheline_aligned_in_smp;
@@ -262,6 +279,8 @@ struct efx_tx_queue {
 	unsigned int merge_events;
 	unsigned int bytes_compl;
 	unsigned int pkts_compl;
+	unsigned long complete_packets;
+	unsigned long complete_bytes;
 	u32 completed_timestamp_major;
 	u32 completed_timestamp_minor;
 
@@ -370,6 +389,8 @@ struct efx_rx_page_state {
  * @recycle_count: RX buffer recycle counter.
  * @slow_fill: Timer used to defer efx_nic_generate_fill_event().
  * @grant_work: workitem used to grant credits to the MAE if @grant_credits
+ * @rx_packets: Number of packets received since this struct was created
+ * @old_rx_packets: Value of @rx_packets as of last efx_init_rx_queue()
  * @xdp_rxq_info: XDP specific RX queue information.
  * @xdp_rxq_info_valid: Is xdp_rxq_info valid data?.
  */
@@ -406,6 +427,7 @@ struct efx_rx_queue {
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
index 2adb132b2f7e..6d47927e1c2c 100644
--- a/drivers/net/ethernet/sfc/tx_common.c
+++ b/drivers/net/ethernet/sfc/tx_common.c
@@ -86,6 +86,9 @@ void efx_init_tx_queue(struct efx_tx_queue *tx_queue)
 	tx_queue->completed_timestamp_major = 0;
 	tx_queue->completed_timestamp_minor = 0;
 
+	tx_queue->old_complete_packets = tx_queue->complete_packets;
+	tx_queue->old_complete_bytes = tx_queue->complete_bytes;
+
 	tx_queue->xdp_tx = efx_channel_is_xdp_tx(tx_queue->channel);
 	tx_queue->tso_version = 0;
 


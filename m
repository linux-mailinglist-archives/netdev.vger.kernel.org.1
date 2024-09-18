Return-Path: <netdev+bounces-128843-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FF6F97BF0C
	for <lists+netdev@lfdr.de>; Wed, 18 Sep 2024 18:18:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA26E1C218C8
	for <lists+netdev@lfdr.de>; Wed, 18 Sep 2024 16:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 408691C9874;
	Wed, 18 Sep 2024 16:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DsTb6i7A"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2060.outbound.protection.outlook.com [40.107.237.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D4B139D05
	for <netdev@vger.kernel.org>; Wed, 18 Sep 2024 16:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726676283; cv=fail; b=RnmocIpjZDWCqTvx9Be20rJAXyBdp9OBpoSMIzlBZaC8uvnVcvzIoAcywPKxlEkm4b4E+8WjMwKNT9PYIijsQGnAHnxfPDHlm5xLKh8CTM7gZDlrqUAGMA0k3HiLDZSmNRjFKTRcLWx5yTDgLxx7gpUpZJBjcfHMTt+cX8kio5M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726676283; c=relaxed/simple;
	bh=Gf/1smqKic0fiAp+2C7CYv7gGvmcwUFshob5EwldZPA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qZ2WGLtva6XnOjvV34KnTcLgf49/iEygdF9xPyd3WZlLdBMDrdbEgQNkpa2a3CWYg9Eb57hpqRlgWrqwJwqwyPQYXQrwadpbZHAXzy/n0eIZrMUELufcyLnICpu74ajikNg3UXFoK6yT2UTDULgLN8FE2s+0Hp+4Y/hzKFu7wXQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DsTb6i7A; arc=fail smtp.client-ip=40.107.237.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kWzMT9S9EDRu7jXiL96v0Cz4rFsSo9OuqJdzhLSaXy8vDpkx/gDmJVZvX+0FqIEgj6rmOuxkh76zpSVcFMYWFB0WZQs2jyPqdzL3jBcLPEGtEVY6jjKoZNJIaUGVmja7Edw6R+l2AXjYMKdBvPqaROuSYgfRo3kqYK9NPBdoEYjIRNhw5ak7cAb/OXKMmaJKSKQSbkQDy127YO6sBpvTUj5/UipEmt72c36SNA5rt4046p4uI1McUJgiHBpoENihOpxH4KkiXI6FNPOBA872XwbKBF81ElCHpZ76QhP1hDAdG9Yid23uv5wIQVLwVh25MY3pStoWkLnXAO0+ga9t5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/NYz787yAgl6vpZd7V5kOwziXwKb3nKPwDYHmV23RGY=;
 b=p6ELSPyLHdCELMP+Dq7h+5elUVi4uwDXSh7ZISRS83NRJ5KpC55dp2XlW1k+qCzIXKoeYwzoQzw7bzbLjmrcIyT8U1dH64JVUoEo6ihSnzGqjvRSl5ACuk3rsnb3co6p/fnuTOz+oDJGt3YxcQsBKpLLbPmSITj1nlD4mPcGa/cqhpqKYf5lYaoivNbrbeXAgAtetQCTOCae7GrUpOXZzawwIEnT/rHUOzrZ94mxzENmD8rtvsRvt4dlk36viousdywqDPCAwKeeSgLroME9zHMFICf+ZFSanGjv+vKFAwH2L30N1t05Cn5yAmzqb5rQ7VhzuvS/dbSS4ZU+c9Qreg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/NYz787yAgl6vpZd7V5kOwziXwKb3nKPwDYHmV23RGY=;
 b=DsTb6i7AYXz9tyEg0lctu/NKn5Wy6n3//BMF9Hak1df9P2hPYsQM780Scwvwqq0RLFF/Y/LGblbTSpMgzIOITFXdnGn4023dVZgvZ16p4FwCEsFreFKYTx3L6s1ZWc6UoYszNnQUPYSkwYzDIq9ThJaEP85iJFQhKX3CbXjNrPQ=
Received: from MW4PR04CA0299.namprd04.prod.outlook.com (2603:10b6:303:89::34)
 by DM6PR12MB4449.namprd12.prod.outlook.com (2603:10b6:5:2a5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.25; Wed, 18 Sep
 2024 16:17:57 +0000
Received: from CO1PEPF000044FA.namprd21.prod.outlook.com
 (2603:10b6:303:89:cafe::a5) by MW4PR04CA0299.outlook.office365.com
 (2603:10b6:303:89::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.30 via Frontend
 Transport; Wed, 18 Sep 2024 16:17:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000044FA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8005.1 via Frontend Transport; Wed, 18 Sep 2024 16:17:57 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 18 Sep
 2024 11:17:55 -0500
Received: from xcbecree42x.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Wed, 18 Sep 2024 11:17:54 -0500
From: <edward.cree@amd.com>
To: <linux-net-drivers@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: Edward Cree <ecree.xilinx@gmail.com>, <netdev@vger.kernel.org>,
	<habetsm.xilinx@gmail.com>, <jacob.e.keller@intel.com>
Subject: [RFC PATCH v3 net-next 2/7] sfc: implement basic per-queue stats
Date: Wed, 18 Sep 2024 17:14:24 +0100
Message-ID: <20a353f5cf789bd98baa8f09a50e5f2300609a3f.1726593633.git.ecree.xilinx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1726593632.git.ecree.xilinx@gmail.com>
References: <cover.1726593632.git.ecree.xilinx@gmail.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FA:EE_|DM6PR12MB4449:EE_
X-MS-Office365-Filtering-Correlation-Id: e6f2b3f4-a9af-4734-ee82-08dcd7fd7549
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Z9H1+fVjrORd5v4WSNdd0EtD6uGZ470LD3lgg8049E53C6pHdVR9UM+cSKiI?=
 =?us-ascii?Q?DdcCHTe78X8LJ9qwIf2HgPBd9W7Aoq+mX7b/4lUlL18dZDnMOBnatPImFSWb?=
 =?us-ascii?Q?gglE6DHJSAj2+0xYz86bAWC9O3X6A6mHTtgchIKBsWeGiXWV0dMdH4yAu5oK?=
 =?us-ascii?Q?NLvNF0owRpqDm88LBb7FkRZb9acFqgP0k8SHWuvizJ4Ig1z7OONbIC5wd8Mk?=
 =?us-ascii?Q?vXDN7gPpci3L/wbPjNpShXKZceAE1qaMcWrZdjkSD8RN9FVIYZWNYgjV5Ipf?=
 =?us-ascii?Q?92ds/evBysaJP70LjdgeIlXeKTz0R6W/gZ7rWqL4FLnSAzTtFxceQN9GxuQH?=
 =?us-ascii?Q?yTfrYHtOu7HmX//5BClXE/17oC5yrn5H9vr1HJ2XQKlwyvphMtUEuOtqUzUK?=
 =?us-ascii?Q?0QXp4ZwJwA56OSUPtc53JjfUiLZt5UvQyYwTnpGmSi4wXRg2RPZOCUud/6aJ?=
 =?us-ascii?Q?DjhXLCxX5ZShkz33jTpcpsgJcgFLnbEwkJjhgzHK8VcApoHjpsx0fvfh0ng3?=
 =?us-ascii?Q?XO/isrX5TUXNqjrcAUPO0Fn9SU8T/efK2S0w1Re8JzxYxpd+4i2NybNSGAkE?=
 =?us-ascii?Q?gaxQhNPWJ6Fi+any8KOlxxTiHQdYfUP2614zxWzaJyVOdf24FYjU0vus2TTH?=
 =?us-ascii?Q?dv0tAkiY1eCtIVhnOJ6R9lZO0oirMSPhtM6aPrvb7Ys4U3Z1nNhqJqlQkDA3?=
 =?us-ascii?Q?0YKZe32HMu9x71VnVQyWZ0qEBaqfYa/f4JR5q51lmGNNlWvkS4BnEbbKDmiZ?=
 =?us-ascii?Q?efBVOHpeFDDPGqFFuSTBV22xRgHTi+4AEteaQCwzSV68thqWMuQo/aV11OmF?=
 =?us-ascii?Q?kfEcXo2JRhOzQQGpYJzJZGhGEVRR5BFRdhbWgUF8SGA1LBsi+TB79LNAcJsy?=
 =?us-ascii?Q?aVAWOavTqR67pHTFg6iSidjl4yZS5QXpG9DWVbAAwGnbVwZ/VlHMLzP3rRr/?=
 =?us-ascii?Q?wn1kvknunr8aDMsXm4SgltynV9+x+IAYKa1kgP/fJuH1s+WRvw4ZMrokPAa0?=
 =?us-ascii?Q?FEoTPRo3DTKdpUaw0u1sNqpJzsztMTf7P1+AXoV+bKDFLV30/HcLUgHezqFe?=
 =?us-ascii?Q?IxJGAnkfBOqQAbEOD+yRI5MCQ1g5lsfTPCaq/Y5Th2OLVwFii79RLmb72X2w?=
 =?us-ascii?Q?TxB5YbK++cyqSGNhsS3vadSiLXp1PRKwO+pIbMmk+hPWrCNGNnrLaHjw8w7N?=
 =?us-ascii?Q?rv4tPSMvInebstoOGVPtQVTSDYYoBgOyCHViYiyqLEbPQldk0R2G4afPlwqT?=
 =?us-ascii?Q?7HGVPc0pLjOEK2gRSD62eepb0sVrvgGvPGOv0Wg5R6j7ltMe46joIvNObqaE?=
 =?us-ascii?Q?sens3Sp4kTG+/Ipj+AMthmQqYtNsWfzx+sjh1lFliET6Bk+v5jwIBD+rAHj6?=
 =?us-ascii?Q?ycnfBgJEtuszKWDl++jT27mmACiUvNj15Vnx7AFbzmRgB41oB/JY++DUOWDc?=
 =?us-ascii?Q?EbsLon5RjpfFSx1tAbnAYwcKunKxv1Nj?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2024 16:17:57.2682
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6f2b3f4-a9af-4734-ee82-08dcd7fd7549
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044FA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4449

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
 


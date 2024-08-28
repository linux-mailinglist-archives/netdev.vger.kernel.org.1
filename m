Return-Path: <netdev+bounces-122792-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA528962926
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 15:46:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D4821F21D66
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 13:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFB03188CAD;
	Wed, 28 Aug 2024 13:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fMqY5Zxu"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2081.outbound.protection.outlook.com [40.107.92.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F17188CAC
	for <netdev@vger.kernel.org>; Wed, 28 Aug 2024 13:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724852766; cv=fail; b=iZ2IAOVhRmgBQMjjrxatXMLytHeO2VVGd1BotGraWIINLPwXS4z9xP/0mnswv+YQY1Atzu4gqHCfSqBG5NIcgqDSVXsAEmWCp5EEZ326IGOg/QRYgE3ZquVccVf25aRnkFc8CX6CmEKA82OLJUs7eSpzr746SygvfyrR21DvL7Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724852766; c=relaxed/simple;
	bh=BkqzjF7u7nQIbQ2L2lbRvun8QIoAlqi12VueZS8zQDw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DPUFbrf7BqHV2jk+I7if7BFtDdfLPsZGL2ERg2zUZun6mFbpmjmmWc3OTesq9tNd//q/SyYEf1wgEnuhkTRqwa/fC6TtzXhmCp3MLYfRPTWo3qqqtJQYTO2QdNT/XnFgI1gWj69xrksLb9dlQQzYwnNwxy/RSBbC8NJSSyba2DE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fMqY5Zxu; arc=fail smtp.client-ip=40.107.92.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iTIxVKeVZiwzZfKmgP8OuURR2Mjm77G9ZGwE/OA6dEGbAbgjxj7+pg2nx9dm/gZiKP6kWEag+jyUCZr8eSn5NuEas7FmzbgPr5xvXWjcKEuDjBObOnU28L5jyZBwyM2sq5K5ThGGwD0SU1088hy+wk2YU2k5t0vYN2MqBn2GILVCst5UT9JNatT1TbNtYzEG5iG4+b2rIxXhSsDxIOu6/ocMaABY4wWZ6DEui+8hcR/l78yw2UTPNLfWbCT7QVIwTAfW1Mcpju5FkSloo0mz0ElQC8uNXuxNPUNUIGKR7qL8txI41C9e/lndLf+j8k5n27PBKmom1LP/8nIU/GpVSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0YLxYkfwuAQ+K5oJK4ma80+49Lg1px0qurjUxzWpu3c=;
 b=AdyGBj0jbwnHLFV4SmQXIE3uP6S9vN+0xcpKX0ELqRpsOF73/ccM/JFsGLnt+ijsBV5/3zdSg4UuwtDZXualXTxa13ksWmCiES73h0BwQ2ruPsmyuMjZfcCbVOj01STfjVf2jNI2bP+7eGa/NpflbZ6Atj6m5BIKjpOu+X7836xxzFzv52DM6RB/DGWUaqsV3W4FkReprwgbhQp7gk3i4iFuvyVhiMW5YM+U1sqSD9MVKNciWs2H99C4y8JRyEhoDigfCYweKu5OJzE9DFNGfOdOZ53XbpTVy57ZsYOy3nrbAFD7DPHSNa2y/8i4eT/m4V6GjaFp7vqQ3bKtABvIxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0YLxYkfwuAQ+K5oJK4ma80+49Lg1px0qurjUxzWpu3c=;
 b=fMqY5ZxuK3PzuBhQq3CabGGDYAocimqm4FzMSSlYzouKVtsAFvosVOFifqNPbRyGtwVOJPDZQTqc3Deqmb8pzR/clCGU5QtEXyXRbmLnDQgwnO+6kyuTqL/ShHxkLDwy2cVahYnWhbXPT7UbGWj9TMyUDukKHEsI8QlVmcYi9+I=
Received: from SA1P222CA0078.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:2c1::25)
 by CY8PR12MB8068.namprd12.prod.outlook.com (2603:10b6:930:75::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Wed, 28 Aug
 2024 13:46:01 +0000
Received: from SN1PEPF0002BA50.namprd03.prod.outlook.com
 (2603:10b6:806:2c1:cafe::e2) by SA1P222CA0078.outlook.office365.com
 (2603:10b6:806:2c1::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.27 via Frontend
 Transport; Wed, 28 Aug 2024 13:46:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF0002BA50.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Wed, 28 Aug 2024 13:46:01 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 28 Aug
 2024 08:46:00 -0500
Received: from xcbecree42x.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Wed, 28 Aug 2024 08:46:00 -0500
From: <edward.cree@amd.com>
To: <linux-net-drivers@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: Edward Cree <ecree.xilinx@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH net-next 6/6] sfc: add per-queue RX and TX bytes stats
Date: Wed, 28 Aug 2024 14:45:15 +0100
Message-ID: <9695a02a3f50cf7d4c1a6321cd42a0538fc686be.1724852597.git.ecree.xilinx@gmail.com>
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
Received-SPF: None (SATLEXMB03.amd.com: edward.cree@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA50:EE_|CY8PR12MB8068:EE_
X-MS-Office365-Filtering-Correlation-Id: 03bed6a9-876b-41eb-1447-08dcc767c147
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?C/uusDqsMO1qstUxkDtKGXfvWEujiWf06vW4ddFRDBVOpYYTU496kVgcGdw9?=
 =?us-ascii?Q?qCRq1zZxdYidsKhpuf1eONVaJ0zbBWYwS1tgetigfK8Tl1mJSEsgPzhnJruB?=
 =?us-ascii?Q?au0OHwDffngRHr7LWVrTpqMNcI2mNsvnmIufIY4ub3lwNW+DAC4BILfFV8dQ?=
 =?us-ascii?Q?q7i4REmWa6xotreh/ZMVmnz2k+1Rl300xAVq6Fx/BfA1/3Z1M9ntTmUU8M4G?=
 =?us-ascii?Q?1H6hAPxy10x8CxGDhGcf3LaKqAfxBTiBtWhFhZIqWLy2EXfVcS1IbVgYSmfE?=
 =?us-ascii?Q?lKoKGhohnaAiWl3pwYztU8qaeE0MC1pfwP2dSIgSwDNFNcOc06L4botdn7cP?=
 =?us-ascii?Q?q6ECssnBwzxGlqGQg+pLWJTOMGwPZwkrDijOQb9zPOKDhFYWuszgtbGgETpa?=
 =?us-ascii?Q?hZet82ZfvS6w88AsAUyk3v2ZCq8+5CwbucZVZOF7FCyg5mW2rt/v0pN+ZQKa?=
 =?us-ascii?Q?Ky0GHQOIn0JeAsG6ySsijdJwDAzN2gcUXitmdonSwd10vawcMwiQtcq3Ra0G?=
 =?us-ascii?Q?pLNiMs13x86VfYU1cX4iyYRIC/xqgADtiAl1XiGLgkBiUYdwNI1WgyVfEUnk?=
 =?us-ascii?Q?2z/CxNox4IoUSt8zsj09Y2zLKVxBDtq3rUZXNvXjbpAi5UORUEDcLZRA/3VY?=
 =?us-ascii?Q?imQ0lpSzSWsL3whsnjjNpiOdh5mnOiWwzbp6ukYRMAwbbknG8aZXJ6Ito3kV?=
 =?us-ascii?Q?T4JKqQoiDK265VZnYTaX1WlfZQPvTHIshiibBmmoaXEP0XwU3aLH6OJfk/VJ?=
 =?us-ascii?Q?jXqUSCDme3dRC4Yn7xLYVqlNvhOJlHaEqAzqsjw0d2x+LX+zUhv/A1fIRlAH?=
 =?us-ascii?Q?7wK6b5x9AJaFj1d/XiWaNqoMyO2y09lQGvuCiPAnmVbibu/w0qkMWBw3OZtv?=
 =?us-ascii?Q?NxjScX4rclu0LwJnGc9YWn+Tcf8M878RGyH8kpCglpoJHqebZ0ZjOR9gieEA?=
 =?us-ascii?Q?W4/5jCJcQoTFopxq59oj4a+SvxqJdnj7xCEKTfsOuzK3vPyViQJMsrOyN3St?=
 =?us-ascii?Q?puCanj0bHOWBAa0D7sYCN94UgxTW2p/l06O8LXXhHdydEDhVCoSMYThq/Dyw?=
 =?us-ascii?Q?26UsBxVHuM6VJ2ex/LkXW1VlUFzn+Kd/wAT4X6x+qv6gKdSmXFFR/YaXEpsf?=
 =?us-ascii?Q?7lZR/qjJJL92arHpIBhGlFz6jxJ9e5mcRRrd6z/scF54azf3jT5h2CXCohrU?=
 =?us-ascii?Q?srhj3CPXhwRiWSbTwI3RC/bHrPcU9LtAmOIUyDFiwIPeuuk2Xjz9MPXFkvaE?=
 =?us-ascii?Q?GTOeNzEEFAMCP40g65yXYJxZjYPIlwHiGi04fGEBdjQ1npAMT3SYTPkKdO4D?=
 =?us-ascii?Q?chj6Xv4PpYHs4CvKf04WKxFkRn9mEo8620ASGIJaQ/kieP1KAokQS6sQhpTN?=
 =?us-ascii?Q?mhzNkBzYUzzZYti9vm3EoUjpHpGkoCshJx5lwl9M2SiRu5iIAuF4CO0Rokhu?=
 =?us-ascii?Q?BNfoIePc0sAoZ7+LnNG00E6+nJQMFURn?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 13:46:01.7050
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03bed6a9-876b-41eb-1447-08dcc767c147
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA50.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8068

From: Edward Cree <ecree.xilinx@gmail.com>

While this does add overhead to the fast path, it should be minimal
 as the cacheline should already be held for write from updating the
 queue's [tr]x_packets stat.

Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>
---
 drivers/net/ethernet/sfc/ef100_rx.c   |  1 +
 drivers/net/ethernet/sfc/ef100_tx.c   |  1 +
 drivers/net/ethernet/sfc/efx.c        |  9 +++++++++
 drivers/net/ethernet/sfc/net_driver.h | 10 ++++++++++
 drivers/net/ethernet/sfc/rx.c         |  1 +
 drivers/net/ethernet/sfc/rx_common.c  |  1 +
 drivers/net/ethernet/sfc/tx.c         |  2 ++
 drivers/net/ethernet/sfc/tx_common.c  |  1 +
 8 files changed, 26 insertions(+)

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
index bf06fbcdcbff..b3fbffed4e61 100644
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
@@ -663,6 +665,7 @@ static void efx_get_queue_stats_tx(struct net_device *net_dev, int idx,
 	 */
 	efx_for_each_channel_tx_queue(tx_queue, channel) {
 		stats->packets += tx_queue->tx_packets - tx_queue->old_tx_packets;
+		stats->bytes += tx_queue->tx_bytes - tx_queue->old_tx_bytes;
 		stats->hw_gso_packets += tx_queue->tso_bursts -
 					 tx_queue->old_tso_bursts;
 		stats->hw_gso_wire_packets += tx_queue->tso_packets -
@@ -680,9 +683,11 @@ static void efx_get_base_stats(struct net_device *net_dev,
 	struct efx_channel *channel;
 
 	rx->packets = 0;
+	rx->bytes = 0;
 	rx->hw_drops = 0;
 	rx->hw_drop_overruns = 0;
 	tx->packets = 0;
+	tx->bytes = 0;
 	tx->hw_gso_packets = 0;
 	tx->hw_gso_wire_packets = 0;
 
@@ -693,10 +698,12 @@ static void efx_get_base_stats(struct net_device *net_dev,
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
@@ -705,10 +712,12 @@ static void efx_get_base_stats(struct net_device *net_dev,
 			    channel->channel >= efx->tx_channel_offset +
 						net_dev->real_num_tx_queues) {
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
 


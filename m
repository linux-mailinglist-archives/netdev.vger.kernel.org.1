Return-Path: <netdev+bounces-122791-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26E10962925
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 15:46:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54169B232EC
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 13:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E6B8188CBE;
	Wed, 28 Aug 2024 13:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kAvr9XXp"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2060.outbound.protection.outlook.com [40.107.92.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8C5188016
	for <netdev@vger.kernel.org>; Wed, 28 Aug 2024 13:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724852766; cv=fail; b=Xs1W1yyAi1vNv/PZNmY3etZfLwMKcFoOe/zzdOy1d2YfkL5uGybhxUzN6tYpzXSTSkytS9C9wA62E29j+NQuE38Pjh8sjxpVhuQKXm3yFYqDqt9qo/mFAclHtbB14KIEq5/BGzloLzovg5b/mID83yzdX9qS1VJvsAIOU+mWZt0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724852766; c=relaxed/simple;
	bh=SohGqyf4xQHlPn+Jpy/FPFGTdDRzadLSivXTa/QG7V4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S+8rqdKK7owmXAsW1L2bCOnPsegLi8M810T/oycEk0VYoSe0IBiICItn6nTo+i/m3OjYH53EbvvGWZdRkYbgglCHqQfPZBaEmT0qHO6EhXSaSH/xcSNKhYIlgUlfnnc/Qhj2ro6RrpE05GtHP5+zWyPbYtPy1Vin1qq/kvd7XhY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kAvr9XXp; arc=fail smtp.client-ip=40.107.92.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BfX12+mjWuMTQF2YZcz9lQaw3AabkgwTp4tQrMMwH7otlksAh9DCUu2FCYKmYxA8cEaeM3VjGeFufoWDmWSKetx5HKpH+iE7NjJTqYfXvqr+7rrqmMKHxYXMdTaQW19SDk5x1h3jyj2GS2IuAi15VKbi+2w0dfhUsF0W9eumacTRi1S95DQJVRO53wY0T/zKSjI0aHS54kPeV73J7iQTzenAS1vKj3+LSsSU1Xp1xcuojj2ZpZQdZdyQEMwIzZgm3O1pZrhQDa+z30dlY23mkPkSIxDt71+dEkZvViREiaRbdHBiPPKCwt/iA591E/VHk5B3bfFepr9qWQsDOJkYPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k3iep3+X4PGt3FOGtLQgA9lEGosfrN0WZIq/WDHvOrg=;
 b=BdldpOlRVKvslLt8jgsZeAyCLlIuGnzMb4yStUS99jO326U3zl2j0R/y0dp/gXDOKcKWCUoYg5mUah3ZMolTFDDSoyAByenpaMGYg0sLGxb5/84/xMfIZnWgZjCka3ayWLBYmOf2OC9zDpjUU32TrA2APb7yvk5ydmDivh5GKZgDXQkeFT3Zl95L0lz1dRvZ1hqvA+Z5XK6Q3NOg8flPPQO0TJhRcqlJcaUkXpZligHuqD7dKK+rkBaR4OAcuQ+MHDGObO8PHxwpTwPdUekWQQQTzhOZtJhCWztadp7oxM6U6/M3n+2/pUdkR8HtOT2WCldcQ/xYILNoNJPyOkFybw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k3iep3+X4PGt3FOGtLQgA9lEGosfrN0WZIq/WDHvOrg=;
 b=kAvr9XXpqb3RKQcYEMPGj20IBOXm70hifXQJFFwnIWuzKI+Ju2SZNY4V7jOj/9fcE2f0boPOAah17F/3pnC2+svjZ8muR1VlqEaMHoBp4McVb39QFVZ+mPDzXjiqUWmyw1gHveSGGlxJ4ZK6gjFH/nxTxlvrrhR9WLSbhZyJkkA=
Received: from BN1PR14CA0008.namprd14.prod.outlook.com (2603:10b6:408:e3::13)
 by SJ2PR12MB7865.namprd12.prod.outlook.com (2603:10b6:a03:4cc::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.26; Wed, 28 Aug
 2024 13:45:59 +0000
Received: from BL6PEPF0001AB77.namprd02.prod.outlook.com
 (2603:10b6:408:e3:cafe::76) by BN1PR14CA0008.outlook.office365.com
 (2603:10b6:408:e3::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.28 via Frontend
 Transport; Wed, 28 Aug 2024 13:45:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB77.mail.protection.outlook.com (10.167.242.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Wed, 28 Aug 2024 13:45:59 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 28 Aug
 2024 08:45:58 -0500
Received: from xcbecree42x.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Wed, 28 Aug 2024 08:45:57 -0500
From: <edward.cree@amd.com>
To: <linux-net-drivers@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: Edward Cree <ecree.xilinx@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH net-next 4/6] sfc: implement per-queue rx drop and overrun stats
Date: Wed, 28 Aug 2024 14:45:13 +0100
Message-ID: <379cc84db6cfb516f8eb677a1b703cbacfa46e02.1724852597.git.ecree.xilinx@gmail.com>
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
Received-SPF: None (SATLEXMB04.amd.com: edward.cree@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB77:EE_|SJ2PR12MB7865:EE_
X-MS-Office365-Filtering-Correlation-Id: ebba11c4-94d5-463a-6910-08dcc767bfd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xoZUEHrTcgL0pTthcvdC54qZTW+3duGQeSAPr9nGw0xJ+0ta5GHtu/1hyq2c?=
 =?us-ascii?Q?KZOwld7ZuWHZ3faPeZ//VAhyeaDpgUmsx9wl1P5WlWHc+FUzXwahR8oSNm/h?=
 =?us-ascii?Q?LjXUMskX7aWxK9IyrW25Okhk2+bIUPQlmR6vSDeAovXuZJfg9b+8NzmOXA6H?=
 =?us-ascii?Q?2B+bMjcH3b/tUJEwl5Lui7TGYkhA+I2+jE35DiSMHdys7J6xED8M2dfQJYBs?=
 =?us-ascii?Q?6CFP6uptdF0rjYATDm2j1DJ15GUGQT1Jpl8VNK7bcL5q0JN39W4BjuVCGjcs?=
 =?us-ascii?Q?O+7wGtNaXtESVJXE/xCNO3PG/wQd1rP7KXENosLmTSbAzg1Wonep8OkQH0/L?=
 =?us-ascii?Q?/utI/Nh6zZden1OPGeEjTG2n9HJVLcb9o136JHkXiJR8PizcQ9MQLourLNz9?=
 =?us-ascii?Q?vgcK69Va6UWvFvdKWcYfs/ZTIs2bOnhQSsHikmeD1HMYQmiogkkIklM70ij3?=
 =?us-ascii?Q?CC2z5N3rAt/fFe/Or2h4pWufi6jqimWqVIoGyE9P4TzDcQ3ZaRO7Hy8HX/IZ?=
 =?us-ascii?Q?JYwwVwGCHaI5aqPt8wIBXubHoVUWqdNLhStEEmU4hN/0Tc8ZQ5d1LIKd85NS?=
 =?us-ascii?Q?Edixkw9NTGR6azHilsJ31EuUdCGuYk6ZY55yBdOmoj+oQl/DGtIzsQc1gexx?=
 =?us-ascii?Q?mXvc+GJrR+ZLwiwDWr57Ezt5DmoV9eoDC9YAuqqp+ytqoGaqIzzehgkFjkzb?=
 =?us-ascii?Q?Pc3AC/k5jZYb2Uh/E8ru9mLAYAknRKwuKHnWAiQDrWBF5V5fDcDUNepA5VzS?=
 =?us-ascii?Q?kUj4ylN9R9kWyUmyEZ7/nVeJXduTmdcxYKd2zNZfjsu+PjGrR7CnGnC3tAZG?=
 =?us-ascii?Q?0YS406l3YOwu3Z0k5KcF/2zVPZK7mV90XekdImUufOwJcpHZvyHhvjx91s9V?=
 =?us-ascii?Q?qmzaJsECA5V7VWqZBa4e243WQgnxU1ZM7KXLmKyA84C++V0qwBPv5lgmu+/H?=
 =?us-ascii?Q?5La6fYMDZriHHy72w1BQ4t0UCH9g4sBn4cC1VASm6CD77g6Jx1JhUIHd4t2x?=
 =?us-ascii?Q?jr+wD+FFHggSBBCIHeOeqafhZrA55GkwKgmQBLqCfe/gS+EZF8ajokK1lyY0?=
 =?us-ascii?Q?2A2XfZc9irHWONiJSJCsSFP2uZ8rzfNo4NCeunNlOM6DUYEVZi8D1UJ6yAyB?=
 =?us-ascii?Q?gF+ebr23AFQcEZIYXVfowDWTovRYvkgmdUV2ff3ict0R4BIsM7caK2Yr71Jh?=
 =?us-ascii?Q?S4KsaVxoNJqBzvxi9AqhQxxTNCGq/ndfk1xOYMSvQH2Asdc23yeO/FFo4d9v?=
 =?us-ascii?Q?dU2azeCu7WnA0gf99ZyKw0parz2K7ErygCYar9o7Zl7d5LVC69ibj331wmIi?=
 =?us-ascii?Q?+WPzrlkdZQxhrglsMBGxCckjSHCSxz8pevSg1tB/8bp+tx1S1OF+7qRQIwN1?=
 =?us-ascii?Q?SYnbux5w7gUbcy0HGjlQKfEVcR/98zak5XTDynEIR2Y/3hywreUYwKgeo85X?=
 =?us-ascii?Q?0szE71G3GvvIetbowE0+oLI5cCigynrO?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 13:45:59.2847
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ebba11c4-94d5-463a-6910-08dcc767bfd3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB77.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7865

From: Edward Cree <ecree.xilinx@gmail.com>

Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>
---
 drivers/net/ethernet/sfc/efx.c          | 15 +++++++++++++--
 drivers/net/ethernet/sfc/efx_channels.c |  4 ++++
 drivers/net/ethernet/sfc/efx_channels.h |  7 +++++++
 drivers/net/ethernet/sfc/net_driver.h   |  7 +++++++
 4 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/sfc/efx.c b/drivers/net/ethernet/sfc/efx.c
index e4656efce969..8b46d143b6c7 100644
--- a/drivers/net/ethernet/sfc/efx.c
+++ b/drivers/net/ethernet/sfc/efx.c
@@ -638,6 +638,10 @@ static void efx_get_queue_stats_rx(struct net_device *net_dev, int idx,
 	rx_queue = efx_channel_get_rx_queue(channel);
 	/* Count only packets since last time datapath was started */
 	stats->packets = rx_queue->rx_packets - rx_queue->old_rx_packets;
+	stats->hw_drops = efx_get_queue_stat_rx_hw_drops(channel) -
+			  channel->old_n_rx_hw_drops;
+	stats->hw_drop_overruns = channel->n_rx_nodesc_trunc -
+				  channel->old_n_rx_hw_drop_overruns;
 }
 
 static void efx_get_queue_stats_tx(struct net_device *net_dev, int idx,
@@ -669,6 +673,8 @@ static void efx_get_base_stats(struct net_device *net_dev,
 	struct efx_channel *channel;
 
 	rx->packets = 0;
+	rx->hw_drops = 0;
+	rx->hw_drop_overruns = 0;
 	tx->packets = 0;
 
 	/* Count all packets on non-core queues, and packets before last
@@ -676,10 +682,15 @@ static void efx_get_base_stats(struct net_device *net_dev,
 	 */
 	efx_for_each_channel(channel, efx) {
 		rx_queue = efx_channel_get_rx_queue(channel);
-		if (channel->channel >= net_dev->real_num_rx_queues)
+		if (channel->channel >= net_dev->real_num_rx_queues) {
 			rx->packets += rx_queue->rx_packets;
-		else
+			rx->hw_drops += efx_get_queue_stat_rx_hw_drops(channel);
+			rx->hw_drop_overruns += channel->n_rx_nodesc_trunc;
+		} else {
 			rx->packets += rx_queue->old_rx_packets;
+			rx->hw_drops += channel->old_n_rx_hw_drops;
+			rx->hw_drop_overruns += channel->old_n_rx_hw_drop_overruns;
+		}
 		efx_for_each_channel_tx_queue(tx_queue, channel) {
 			if (channel->channel < efx->tx_channel_offset ||
 			    channel->channel >= efx->tx_channel_offset +
diff --git a/drivers/net/ethernet/sfc/efx_channels.c b/drivers/net/ethernet/sfc/efx_channels.c
index c9e17a8208a9..90b9986ceaa3 100644
--- a/drivers/net/ethernet/sfc/efx_channels.c
+++ b/drivers/net/ethernet/sfc/efx_channels.c
@@ -1100,6 +1100,10 @@ void efx_start_channels(struct efx_nic *efx)
 			atomic_inc(&efx->active_queues);
 		}
 
+		/* reset per-queue stats */
+		channel->old_n_rx_hw_drops = efx_get_queue_stat_rx_hw_drops(channel);
+		channel->old_n_rx_hw_drop_overruns = channel->n_rx_nodesc_trunc;
+
 		efx_for_each_channel_rx_queue(rx_queue, channel) {
 			efx_init_rx_queue(rx_queue);
 			atomic_inc(&efx->active_queues);
diff --git a/drivers/net/ethernet/sfc/efx_channels.h b/drivers/net/ethernet/sfc/efx_channels.h
index b3b5e18a69cc..cccbc7d66e77 100644
--- a/drivers/net/ethernet/sfc/efx_channels.h
+++ b/drivers/net/ethernet/sfc/efx_channels.h
@@ -43,6 +43,13 @@ struct efx_channel *efx_copy_channel(const struct efx_channel *old_channel);
 void efx_start_channels(struct efx_nic *efx);
 void efx_stop_channels(struct efx_nic *efx);
 
+static inline u64 efx_get_queue_stat_rx_hw_drops(struct efx_channel *channel)
+{
+	return channel->n_rx_eth_crc_err + channel->n_rx_frm_trunc +
+	       channel->n_rx_overlength + channel->n_rx_nodesc_trunc +
+	       channel->n_rx_mport_bad;
+}
+
 void efx_init_napi_channel(struct efx_channel *channel);
 void efx_init_napi(struct efx_nic *efx);
 void efx_fini_napi_channel(struct efx_channel *channel);
diff --git a/drivers/net/ethernet/sfc/net_driver.h b/drivers/net/ethernet/sfc/net_driver.h
index cc96716d8dbe..25701f37aa40 100644
--- a/drivers/net/ethernet/sfc/net_driver.h
+++ b/drivers/net/ethernet/sfc/net_driver.h
@@ -472,6 +472,10 @@ enum efx_sync_events_state {
  * @n_rx_xdp_redirect: Count of RX packets redirected to a different NIC by XDP
  * @n_rx_mport_bad: Count of RX packets dropped because their ingress mport was
  *	not recognised
+ * @old_n_rx_hw_drops: Count of all RX packets dropped for any reason as of last
+ *	efx_start_channels()
+ * @old_n_rx_hw_drop_overruns: Value of @n_rx_nodesc_trunc as of last
+ *	efx_start_channels()
  * @rx_pkt_n_frags: Number of fragments in next packet to be delivered by
  *	__efx_rx_packet(), or zero if there is none
  * @rx_pkt_index: Ring index of first buffer for next packet to be delivered
@@ -534,6 +538,9 @@ struct efx_channel {
 	unsigned int n_rx_xdp_redirect;
 	unsigned int n_rx_mport_bad;
 
+	unsigned int old_n_rx_hw_drops;
+	unsigned int old_n_rx_hw_drop_overruns;
+
 	unsigned int rx_pkt_n_frags;
 	unsigned int rx_pkt_index;
 


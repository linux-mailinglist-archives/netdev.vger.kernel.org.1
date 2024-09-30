Return-Path: <netdev+bounces-130406-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1150798A654
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 15:57:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CECF1F24728
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 13:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCA26191F8D;
	Mon, 30 Sep 2024 13:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EI4nIpIO"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2055.outbound.protection.outlook.com [40.107.237.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012F2199FD2
	for <netdev@vger.kernel.org>; Mon, 30 Sep 2024 13:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727704409; cv=fail; b=YC44aKGIauDv44lWXuwSU4SjEXH/j//bXU4SgzKvshDwyQDmPrl9NqKVa6+6+lFldZeqvJ2tF2jd6eWSrq8zwko316hg/Bu8CqR7KBH81dVaz2nR4Ku8E5qSyOmZewpcxcYdLck82fEgubZ9zDDarVvkTnOKrc02AFXmTF5VAqw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727704409; c=relaxed/simple;
	bh=c8s/UkSYgBeYUP/zUyJ/sGRGMzy+uDkEoHfD4PtSliQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IQSvYq4W6YSsbqg/aE6ii1VV19pNhuBZTgphePYFUCqF6xQUEbGowzDRkguaDrv37oHZ4talQxjfMv1ZKSGISUVmsMB7S9je8Wd1lT1hbeasr1ifcjTaYAQJDPloTaSaBkgF2c4BCC8vHF3v9GSGahC1wtjgVC7M9tr86zaTFpY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EI4nIpIO; arc=fail smtp.client-ip=40.107.237.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oLauarVuumaarU/661hY140lDHfMWqHKrnK/+y5PQJ/udNAaLSX/u2t/+yQnNMeMsUKCgX7PgesZ9V9hne0Zpp1cBCU1oA5nPF9Q6LIZh3N/1C61RW9c3EIvABAFutbzDF4Gp8xBg2yXBv0WJwhXLXZ8SBDUz3vvv8+nLHVU+gZlZEwIAsON4wvZlY4vGSIuAixrZnrCky7P4IWyHLGP3D3M1X9jcPqGvBohpIBQbmFqYceTfSyYeV4fmYwhwyx4rPCLyoCHd4nz7xIbwerAlG33olo2KYCpxtQiYPLSZVULYel25G7XRJ6Fsx8EG8TCqlEpXOToklkEXkiSZcgVVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X4IYNfrc0R076S/IYR0vqDcrJwEjrHHFjbncDZPA6W4=;
 b=ZUZfbeVqYXsN0uhtaSCqdf9HcgaMKQhZAW3ney9U16XF32hMGWaf6+6ug4c84QfwODNQLjTAOXiFXjuFDCNCt5OZk1TMskCudtBZhWvydDPQmNDXLXWj3uMfMe3a3oPQnvzw7+tnj1GNReJUJnozDafxMDATRbb3iCHmkQWDzWCzEbtw24XzaK5OIvE/3gzSZPoSrGxTkXE1MN5g3EUSa6cdD7WbkfIT4Uc4UCmolm47KrFsagFWirZEXOhzvKNZRomH0hXL1WJSIMxmw9Xez2HRUoIb3DnnBJpKQNq/XEEQnqjd/fKfJkaPFD+WIkp28x1kntwjas7sx7rOf7eMew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X4IYNfrc0R076S/IYR0vqDcrJwEjrHHFjbncDZPA6W4=;
 b=EI4nIpIOp3OHoV5kFDPVgSIYgQw3W2CXAN/SG0jFPvl0Xn3iihxKHPtwBSri0Mq8kFk2G2ZQVP+xCNJcIQa2GDxwDGKfrBXJQ9EozTfEGjeXQguXiWGks5lo2ZVjSR0VPWA66OHXLUBIouOziOZNO2WBpwASRd1QuKKt3M/tbak=
Received: from MN2PR07CA0005.namprd07.prod.outlook.com (2603:10b6:208:1a0::15)
 by PH0PR12MB5630.namprd12.prod.outlook.com (2603:10b6:510:146::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.22; Mon, 30 Sep
 2024 13:53:24 +0000
Received: from BL02EPF0002992E.namprd02.prod.outlook.com
 (2603:10b6:208:1a0:cafe::85) by MN2PR07CA0005.outlook.office365.com
 (2603:10b6:208:1a0::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27 via Frontend
 Transport; Mon, 30 Sep 2024 13:53:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF0002992E.mail.protection.outlook.com (10.167.249.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Mon, 30 Sep 2024 13:53:23 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 30 Sep
 2024 08:53:23 -0500
Received: from xcbecree42x.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Mon, 30 Sep 2024 08:53:22 -0500
From: <edward.cree@amd.com>
To: <linux-net-drivers@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: Edward Cree <ecree.xilinx@gmail.com>, <netdev@vger.kernel.org>,
	<habetsm.xilinx@gmail.com>, <jacob.e.keller@intel.com>
Subject: [PATCH v4 net-next 7/7] sfc: add per-queue RX bytes stats
Date: Mon, 30 Sep 2024 14:52:45 +0100
Message-ID: <49153e93bb07d01e81447be655007e3a8d4da81d.1727703521.git.ecree.xilinx@gmail.com>
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
Received-SPF: None (SATLEXMB03.amd.com: edward.cree@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992E:EE_|PH0PR12MB5630:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b30580c-6cfc-4b5c-708b-08dce1574061
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iBsURwrr+oDtm6gc4vl/l8LAvyvhGMR1gnt7QjEs8zRCf4IcEEOaGWINgorP?=
 =?us-ascii?Q?bQxQZqwCGopRu+gwSQSeriY9HqoR9cJ48+XBrJLNQTpDwCwPoRki3q8yQ5f6?=
 =?us-ascii?Q?e7pjxX+0iJC796fpDxefljklK2P9u21dh/JFC9M4FNP7imuQddxMUSUxrxa6?=
 =?us-ascii?Q?UUXr2sCe4Fag/vrpB7U10ujF2I8oqHs/cVbGwys0ySDPO9NFbaYhGBXIXE/i?=
 =?us-ascii?Q?SxnkVQIBaucyiyllWO0/ag0+2lBHhmzu4sguCVugRpcGLwvyFRnXuXnGJxLL?=
 =?us-ascii?Q?EaLwmfH9m+RuAkNAfjIA/miitOj/7XixLIYilop4/5y/c1UUmuZbcmxBKwTI?=
 =?us-ascii?Q?p9FfqtmaWSMl2jbhdTvrNNn1635mWXkhLXX71t/5bXPP8AzCljgtMxLQ9G1h?=
 =?us-ascii?Q?AyvHtukBtHmLQHzvbjOhUkH+bbu+ZeG4ocxRwjYOD0ocCbgZVSrl5xBSdT8W?=
 =?us-ascii?Q?FQfS0Gi0uEXBcES9ynAr5jm2ib92/cgeOQU/iUx3g+XyscJm11Q3hYdJmUmh?=
 =?us-ascii?Q?65RSz01ZZIz4TEkNb3XgkE2duUAnERhLOdH7nxlSLWnBBqrS28EBYggLwlpF?=
 =?us-ascii?Q?7/6bdv9Vd6qJ9tStTrFhHHn5Y2fLPM5ljEDV1es0oo/VMbiL1zAZahJWVB7j?=
 =?us-ascii?Q?FsPAY8qUdsKDWkTBWqtVDZFhHTnbaWkNjWBrfE1WVo274/F1FrxeRJTtKCa1?=
 =?us-ascii?Q?H5p+hMkFvNCgLKMA4zmeyUK9vKcmHqAH4KgZTvRdvbbPkBz2bJ/4n8va0t8d?=
 =?us-ascii?Q?gVaN1XnmaK45bj7V5ATCPFRXHP6IhLEZsyTPrF4RdkqWoMzCkkcyYriAP3aD?=
 =?us-ascii?Q?AtCmVcgnRwn0h4CPIc9NhOSbPfu1VSTL99N54sz7e25Y2ktpFzBOG2diA/ik?=
 =?us-ascii?Q?qRXWNC93kEpo9EkVDYhoSMXhMjytC4+o5Q79ED/x1euXRKXo02PPyjT46gt+?=
 =?us-ascii?Q?078Q42Fie+O4Q4PCn1CYvYSGI8wZ23MJrTeoq9mpQi8QpW6/PQ3elRwdlO2p?=
 =?us-ascii?Q?ugXaxhM89OlrOc8L7OJ5cUV/zZGpsMYDoV1k5FyXdytGIY6W0cgF+yB264js?=
 =?us-ascii?Q?JGQ/MSkRNYjkh40lRxc4G9OMoU7oHpj0ALlMUa8mRJs5rOk3yPvKbH/J60Dp?=
 =?us-ascii?Q?ELhN4KE5h9KZW0SeJSi1bMBFubGsIOzoAHI/4I+pgKsaRknoQOC5fn4pHqkG?=
 =?us-ascii?Q?0tRBPLl0Muu0RO+o4YKkc8JmcZL0a/RSIaiZ0rMxD+KhZkz4qHXXT/fZflKk?=
 =?us-ascii?Q?VR5OmAUER+Cd/CQyH5PdiX8UzsU2hRpIdBjVQ54bmJt1DQt3FgnW06Yq4kUX?=
 =?us-ascii?Q?eSOE5tVbJ3N8+nUlw/l/bE57boC7lpW8+sjIUbC+jE/YoMyxx+/v+drexNOK?=
 =?us-ascii?Q?T8PRW9+NGFVZ0pLy0cArQB50VJPFgD5aGx4Pyv9d1ZLbVZQlGFPowqlQFBEQ?=
 =?us-ascii?Q?ncr5OKzBD5BHQcIuJGPSkMmu7ild3cpg?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 13:53:23.7674
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b30580c-6cfc-4b5c-708b-08dce1574061
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0002992E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5630

From: Edward Cree <ecree.xilinx@gmail.com>

While this does add overhead to the fast path, it should be minimal
 as the cacheline should already be held for write from updating the
 queue's rx_packets stat.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>
---
 drivers/net/ethernet/sfc/ef100_rx.c   | 1 +
 drivers/net/ethernet/sfc/efx.c        | 4 ++++
 drivers/net/ethernet/sfc/net_driver.h | 4 ++++
 drivers/net/ethernet/sfc/rx.c         | 1 +
 drivers/net/ethernet/sfc/rx_common.c  | 1 +
 5 files changed, 11 insertions(+)

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
diff --git a/drivers/net/ethernet/sfc/efx.c b/drivers/net/ethernet/sfc/efx.c
index 68ddb28d3141..90bb7db15519 100644
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
@@ -682,6 +683,7 @@ static void efx_get_base_stats(struct net_device *net_dev,
 	struct efx_channel *channel;
 
 	rx->packets = 0;
+	rx->bytes = 0;
 	rx->hw_drops = 0;
 	rx->hw_drop_overruns = 0;
 	tx->packets = 0;
@@ -696,10 +698,12 @@ static void efx_get_base_stats(struct net_device *net_dev,
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
diff --git a/drivers/net/ethernet/sfc/net_driver.h b/drivers/net/ethernet/sfc/net_driver.h
index 4ca48db3e168..b54662d32f55 100644
--- a/drivers/net/ethernet/sfc/net_driver.h
+++ b/drivers/net/ethernet/sfc/net_driver.h
@@ -400,7 +400,9 @@ struct efx_rx_page_state {
  * @slow_fill: Timer used to defer efx_nic_generate_fill_event().
  * @grant_work: workitem used to grant credits to the MAE if @grant_credits
  * @rx_packets: Number of packets received since this struct was created
+ * @rx_bytes: Number of bytes received since this struct was created
  * @old_rx_packets: Value of @rx_packets as of last efx_init_rx_queue()
+ * @old_rx_bytes: Value of @rx_bytes as of last efx_init_rx_queue()
  * @xdp_rxq_info: XDP specific RX queue information.
  * @xdp_rxq_info_valid: Is xdp_rxq_info valid data?.
  */
@@ -437,7 +439,9 @@ struct efx_rx_queue {
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


Return-Path: <netdev+bounces-128847-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6023197BF10
	for <lists+netdev@lfdr.de>; Wed, 18 Sep 2024 18:18:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83BE21C21B84
	for <lists+netdev@lfdr.de>; Wed, 18 Sep 2024 16:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A68A51C9EAB;
	Wed, 18 Sep 2024 16:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HDCGNiil"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2077.outbound.protection.outlook.com [40.107.237.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6B11C9DEF
	for <netdev@vger.kernel.org>; Wed, 18 Sep 2024 16:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726676290; cv=fail; b=dVFGHlceOBzzp+AQj+EAncR6KBGJ4cYtOMvjAfSMeIN3QcpWEico7kz0YxthhGIKwW17ayyQPoarxzIk/as4w3IyJgN+bw4ogkBIDp8k24xSjJux9xPOh/SP/SyDHB9xj9ggd4JqKMbr0b7p6gYRuBhIRzqEAzukT0YHLz6vYD4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726676290; c=relaxed/simple;
	bh=c8s/UkSYgBeYUP/zUyJ/sGRGMzy+uDkEoHfD4PtSliQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DLA9r/RHeB6mI/taRZvme28hrpD8r67GDzyIoSUGTM0YyLn8B8j4FvzNZODrzvPODehwdsplEaPeV6xu7KV/KCYNYevKdIvGufrYFN6fb853SgQbP6Czvig9TXvZyba4duDqc/oYqoYvhB60Z6jQRdZI/hC4FfcCYJgt+2vD2K4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HDCGNiil; arc=fail smtp.client-ip=40.107.237.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Eo+j681Xm2Lhnll6Qyqa4AD1aNvEugiMiHvHDSCTi2dMjsYtpq2xFgkuHRqGJw1F0cu3DMgsTvJpgUTUGVeWgw0RLjjD4JSXRMJucextBpkpnJsok2oAgt/ZfMRHBJXYMEuGpozmJBQ+iEau+6LmyJr9oMqDNfZI/TXmqamaNIu0RGkqxiB1hMniBiCtSBcYN26w+mYVZQ3uFepBaBc6wbZhkDVk1tBiLE6BADTZ2ePKxWLXV5oGSMMsoh09dtquOZXhfH33Md0VOHgY3Ik46ql4zBo0jhzzkJlvko/deaI5Q2SpJbI8/InD4PNMKQvOqFo31GWZ67gbg8xkTZRPfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X4IYNfrc0R076S/IYR0vqDcrJwEjrHHFjbncDZPA6W4=;
 b=F0O4gQ+9ircVy1BdOEc/veLZdaQyMWWVRgrR83021zN+nZ+SNoYdZqFLxRWskUtgYWgmSJaIh7zNksDRfNxtD05OwRzF1vLpHMMOhniH7DzovCnLU/u1gqqVBiQIwrQGcuk810zw3/j2uJiNc2WDLW8iol/YWMZOD1wJDy7ByPS4r6y1e5cqOyqyy9j2yk4d/VYHZxAAU34CEDOfj6Zo5xQNzrb/6rVZJXQdRBT1/nzv+OCSWPnAK3eVNsC0glH1mzlRYriUFOt4u4X+yE5P5u3EaMe2s0lzVgN7ZnBkf4vndaennUK9RuM1NptTwPZf7qeJxCK8+q1lpjgcI6xVrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X4IYNfrc0R076S/IYR0vqDcrJwEjrHHFjbncDZPA6W4=;
 b=HDCGNiilo5F70g8l4kDnnhQQzgmi8Yg8a18iEHb1tY/g+g68DlgF6Iw7M36e/bptUoFYI07OQfr/5YY7to+V2TKK7w6dkZ+IitrXbX6e5fS0FaQD/fU+f/8OvQZq59mANGb4ihzhbkpt9uoZzQ3vgmaTU9ahBIKyDWvY0fidmi0=
Received: from MW4P220CA0016.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::21)
 by SJ0PR12MB8089.namprd12.prod.outlook.com (2603:10b6:a03:4eb::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.24; Wed, 18 Sep
 2024 16:18:06 +0000
Received: from CO1PEPF000044FB.namprd21.prod.outlook.com
 (2603:10b6:303:115:cafe::71) by MW4P220CA0016.outlook.office365.com
 (2603:10b6:303:115::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.30 via Frontend
 Transport; Wed, 18 Sep 2024 16:18:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000044FB.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8005.1 via Frontend Transport; Wed, 18 Sep 2024 16:18:05 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 18 Sep
 2024 11:18:02 -0500
Received: from xcbecree42x.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Wed, 18 Sep 2024 11:18:01 -0500
From: <edward.cree@amd.com>
To: <linux-net-drivers@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: Edward Cree <ecree.xilinx@gmail.com>, <netdev@vger.kernel.org>,
	<habetsm.xilinx@gmail.com>, <jacob.e.keller@intel.com>
Subject: [RFC PATCH v3 net-next 7/7] sfc: add per-queue RX bytes stats
Date: Wed, 18 Sep 2024 17:14:29 +0100
Message-ID: <7139aaa5f83d09c5490ef593b7c8e3eb6484cce7.1726593633.git.ecree.xilinx@gmail.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FB:EE_|SJ0PR12MB8089:EE_
X-MS-Office365-Filtering-Correlation-Id: 0815e7e3-53df-4942-dad4-08dcd7fd7a0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?su4caedANmy9i/BPmcNRNWvlzd6cs7zY9CTPdkI0a1eSrZvMSt+RO8NhyCFp?=
 =?us-ascii?Q?MSgEOvRuPdWsKsZvJOPNNIX0JswJzTQ6mwe+7Jk+F6okN9XycFeB6wJJqytG?=
 =?us-ascii?Q?td2v5+wOBueTetxaNPefpW7ghUq8dEptPKoPjywFc4gjLf7FJUp2wQnKdJX2?=
 =?us-ascii?Q?9eKQ5NPGAAyvAA3qw9PSL7gVOmhswNyDFTi+qxT6w9Xis64M8WGWiIDLlYH8?=
 =?us-ascii?Q?fOZh+aJOHkg2cE1k7b1cHS8CaN9/RSC0516pQEcUepoPAbrFSOoLGCgYDKh5?=
 =?us-ascii?Q?OWLX+0F4MkJLwUgBfg441MuA/gTBsEdluSFO+9QtU9VpeZ9BmYOrWb5Gp2WJ?=
 =?us-ascii?Q?OJIicYD7K7dyxvRUB8AGNS8HmJmTXlvAkiYb79/UBlhvmOEn4L634vh1nsXs?=
 =?us-ascii?Q?Rq8x2fM1/peV6XkauBouc1sc4G/xjE+GaymbKsJk3liszLPajzEOpyP6iLWT?=
 =?us-ascii?Q?hhoVPCKghYIIXrI8xCgm+xAYxRfwLWau79XeEP82rycYwQP28Ea8hgikmToN?=
 =?us-ascii?Q?7L+F/MYWLBK4q+WwmEYRR1u5ORZMQEETzv9VrISbav/212LWwxNw8m3E8G9c?=
 =?us-ascii?Q?C44EZX0ypB2DQ3w50veN7K0fJofUv7OcNLl8r4Y6WGxmiARM+gbKTp8qGJ6N?=
 =?us-ascii?Q?VdqWkq7gQbqmMEj+ky3YrMRW0OGZDtE708C4VU6Vc4aMDG5dIaFFlZjrIopB?=
 =?us-ascii?Q?YxPT5FswqhKzg490t8CGibSNPFih4thsaQpdVWi1+FaczFkAgKPwu8O5hgsf?=
 =?us-ascii?Q?UK6yzQJ31q5kwggSng53eokW+XqFuGF2F7EABVszw6AH2oClJVqu3gM/OIcb?=
 =?us-ascii?Q?/6/GfM+Kd11ngK8c856EoqfzNbIAZuygTGb2Vx2LUeR/awqchDfPkzFWzs2F?=
 =?us-ascii?Q?HGBFDgjZIfSTaxmm56iL526W224+xjjvpPx2zWPJWiCWaYbvvxyPpArAEV2g?=
 =?us-ascii?Q?qJUgDLFF4Pz5dQ6XGbtilFojtlGfHgVFGlUOLuruLwPIt6wq5h1f/VK6942R?=
 =?us-ascii?Q?UhHM0c1hQJFe8wbwj51oEx9bTHTYrNUyAVN8GZqlzv9G37QQf1NYh6bVW7H/?=
 =?us-ascii?Q?oIjW8sco0EDM03r5iDAo33jjSTWoV09nM9UawLpLZb6UvEGhwSCAWRWOizMh?=
 =?us-ascii?Q?vOVMQiBtM38D2nUTOY0QCmwmRTOolSqyY2+jKNIbESm5V9DRC3tXUwFyGNrB?=
 =?us-ascii?Q?m7ujjjIwm8UUTpcxbys2maOVk8CcLy0oEBfm1qkYRymvccR0hbDXPQcXddvf?=
 =?us-ascii?Q?2saCnwgXNbnO/xBBYGrv9XgYnyfYZPHFLtLZdox782kXzEqwIKR1rdFYbMZe?=
 =?us-ascii?Q?ePib/gv0MziZTlnIDnnQveuAB53ZfzbU1jIsii9KPpkArOo2/gifZWtLCAvE?=
 =?us-ascii?Q?pcgGhAkWVmit6gN9h3og/RGnERT4ii3CkEnT31ZoxJj26ujUkyYmZHf8tWdg?=
 =?us-ascii?Q?dEO8fBsz5mA6q27/ohk/pMqsVs68LQat?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2024 16:18:05.2344
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0815e7e3-53df-4942-dad4-08dcd7fd7a0b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044FB.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8089

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


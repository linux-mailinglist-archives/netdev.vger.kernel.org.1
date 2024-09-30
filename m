Return-Path: <netdev+bounces-130403-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7984B98A650
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 15:57:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82E2A1C212AB
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 13:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBB43199E9E;
	Mon, 30 Sep 2024 13:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="D7dQq9bz"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2083.outbound.protection.outlook.com [40.107.102.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37860191F7E
	for <netdev@vger.kernel.org>; Mon, 30 Sep 2024 13:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727704405; cv=fail; b=ixyBj7XoxnkQtoy9v6deCHCOJe6O/k8KEY/Lq1KeSHqkwQUS/QN9CKVo/KyGINDabDllyujDUQp4UxjZEGSfHm2pnXD6xetn1shv9U8wRkWWdq0EKSiVbDlrfbx/UTZPPZzj1Zjz/nQSkn2/PJtgYqbWPCeXhFR0qj3zLfojqdM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727704405; c=relaxed/simple;
	bh=wg0yEJ8qRagYgQcGnFNeDtAVK2u1kSRCVY1mv2+MDAQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sQlNjJ4iOwq+pfWNp+gDEeaZTNEXE/rm7Y6K0SeJLTvSgA0NGZ87lKW+ZBfu1j/TbHslzrswryI+QMxbas0GmjHS//ADPUATq3DNHBq7jSY9ShHCjWkC1H1IyHE6AS17rUbu9I5eFpWtJP/2P1gRXzTKV/jDwJuO9i5BT98Q+II=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=D7dQq9bz; arc=fail smtp.client-ip=40.107.102.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SUkwN8tg9WguIXL9BBEqsIjPEhNiqPwmu/97mH0KFVtCpdMe7gUGdgNDv5cRYyaLTlryi8S0ajlgbjZL5FuwQbsEB/HFnCLdcqhTezsCik5tFm8DLmmg3QyUPe3dJTQe1OsNqb/F/9NI8Up6F3fqVXcBIyPad5vhJ7FybqKrIFekzh9QVjKGbKJcBKE/AEVC2NFUk8FounpE4ImnLF7xXKNcuR6339MsnKrO+EoyYgpV2Ov6GdrOo5E4zh4psF9znEKCb4QCul3ub2zLRKDboSa/KXtpe6tKom/Ys2DHdpIAJjpfQszBaR/WpMRFW49ljfckKGToxPJOpFGK1ytyDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hXx5JbZemJdRw1Lv6XGS80EQox2jzRpGqE5GpYza0xw=;
 b=kzISUdAs8E/ve5ASAHU5/zOzfG/GFNFQcmfHM1f0MkjXs8IshkVssGp0A1I+Gvz5dETqUm9u/xjlHK+XYBMogXXrrGOp88IyGpkHdPO9lax1e0T6lYXRfRUgOV19r7dGNyVT0TZgyfkeBBVY42iMW35rax6hpH9aSsFvJD+JPuTZkVxHThRJnYNuuQV7tVUid3qqVrULzSqmQ2kqCXHr7DBes47aUFwbX/0Vn/opLCxk/Nl9/dE6Ppzee8UMfmZAqvSh3I4PFdsnrLjl+YCiXyEgcGzn86DODiM0W+7WFXQIgJIgV82QnNJXtwsTMTtZ1PUdO1gzjvHO6Dfct9AdWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hXx5JbZemJdRw1Lv6XGS80EQox2jzRpGqE5GpYza0xw=;
 b=D7dQq9bzoOHeKo3Vf0v3t+xR9K2zXEMqE47uVk05wmcWBLLkZqcyeedXvWgVHSzozDFCJ9ev3YJxpAIw0oO44bb6sddPcczUspt+Z7tfwIoergWaG7GrZ0FfNXCKoOLC1Y66tddffKCyyKObT8PoDDEwYW9FD+/f5oyIU1NeUeg=
Received: from BL1PR13CA0084.namprd13.prod.outlook.com (2603:10b6:208:2b8::29)
 by SA1PR12MB6971.namprd12.prod.outlook.com (2603:10b6:806:24e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Mon, 30 Sep
 2024 13:53:21 +0000
Received: from BL02EPF00029927.namprd02.prod.outlook.com
 (2603:10b6:208:2b8:cafe::39) by BL1PR13CA0084.outlook.office365.com
 (2603:10b6:208:2b8::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.14 via Frontend
 Transport; Mon, 30 Sep 2024 13:53:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF00029927.mail.protection.outlook.com (10.167.249.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Mon, 30 Sep 2024 13:53:21 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 30 Sep
 2024 08:53:20 -0500
Received: from xcbecree42x.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Mon, 30 Sep 2024 08:53:19 -0500
From: <edward.cree@amd.com>
To: <linux-net-drivers@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: Edward Cree <ecree.xilinx@gmail.com>, <netdev@vger.kernel.org>,
	<habetsm.xilinx@gmail.com>, <jacob.e.keller@intel.com>
Subject: [PATCH v4 net-next 5/7] sfc: implement per-queue rx drop and overrun stats
Date: Mon, 30 Sep 2024 14:52:43 +0100
Message-ID: <626495ebb966557dafdbfa712a27d9a39051a280.1727703521.git.ecree.xilinx@gmail.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00029927:EE_|SA1PR12MB6971:EE_
X-MS-Office365-Filtering-Correlation-Id: eac63a24-5cc5-4a41-b7bc-08dce1573ee1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Sw/uPuC4ImHhhziuqGXEeKPRIm/Fsjhae2LRxXIOo+BRisifg5cb9PdjDgBO?=
 =?us-ascii?Q?33tFA9a5ahaLXB0kN4hHxAoOQHSUyijw+g7+HmIn8zxLw2JUb3fqJ/d2D/54?=
 =?us-ascii?Q?pTeuE4H+akTKsfVupFzTp/UK15uKSliInTSC+XJQAqpVzu+W3x/LunWWgMPS?=
 =?us-ascii?Q?oDSHpebcT3TKMO0NZS/rhqwt+HuguaubhTcPPp+oxMmKahewWF6kT8/lrcAm?=
 =?us-ascii?Q?mMAW+btwZ7fiRjIInt+c6FPJGs97A8AMRD7R2uQf5kqbf+lcMnth6NcvaEOx?=
 =?us-ascii?Q?iuRvnsPLSViMD8lJHWUIGvqswosHFh8p7RNOeYdJuURUtboACyR0ScvNaskO?=
 =?us-ascii?Q?31GtAaPbesUZt0edOk58WdTxfU5Sh4ftTktX3erzQtRr5V4lC1nO1RUiWquY?=
 =?us-ascii?Q?Ihd67g+Q/O0h1TTsHhE6ct7/jzocjUmWi+0DjZUmU9T1tD1bz5kmComaX59v?=
 =?us-ascii?Q?x81uGgH19jJwaJdy2c80xgVZcgiJallb3iivHkvFG9mE50+CcyNIlk/gkDiH?=
 =?us-ascii?Q?jYtcH+oRoTwMiiVdTwhLFSKwR243WEQqW3OFHXV647eAB78SZyUNlZzjNH4K?=
 =?us-ascii?Q?ewLFTDCXVbM6ouL1QLPTgTuFVcD0Z7KI0RjWTPGvYxWMQiSE2ybu80VQiBzc?=
 =?us-ascii?Q?wyaejMazTJhrAgQNUi/0cOx+0B+/qIbJQWqelZRHqWS8u3Fgcpst7+CVoPRk?=
 =?us-ascii?Q?NbPlVhDi2Yb/Dju0Z5v+ihL6erziYJpgZhOJhb7bKjFNoq8mD4BrqdyI3GoB?=
 =?us-ascii?Q?whPYJBkRTYAD/r7j2ppPfuuf1oJmDl9oRb4zBOWbzd85lx8WAX8BtPmIDEK0?=
 =?us-ascii?Q?ZeMw20e6c9O2kbd/Hct8tgYfr3ZbOCLq2HohUTWjS0zmQ4dMyMHQSSYPRv5/?=
 =?us-ascii?Q?mUrHXIg4eGF8JYLchFDRdC7hzulRfT7dhAxzdpFASSBsdnUbyMmOFBQ8o94Y?=
 =?us-ascii?Q?5b25jLteFTDNAgpzwFK+yzX7E5EXFFEZA2DkzColzEC8YBtYOj7uHhNsMtTV?=
 =?us-ascii?Q?dhZwI6eKKj9Wx9JY5l0klD9C+hCE7sZRHKfR6ZTLB6NALahaAQ/Ymu3TNZKX?=
 =?us-ascii?Q?HZmCRZ+lx7JWjelm40LS8r8e1DnflbVhRgTQSQ43vSLi/K6n/Bb5FuzVh0q6?=
 =?us-ascii?Q?0CPRYdwy5VgbYWMQrlNatxGD1VulyyVLYV8z99joMZBIXSqN5X0GRRBAV8bY?=
 =?us-ascii?Q?3N3gerrH5ZqkhPjk0PRidqMtUODpwN7kNg12TzeenH7d0vyoRRY5nOwUHUBI?=
 =?us-ascii?Q?LNWwyYdObogJVU44uv/uapNhhYe3kvHDjnQZ1za9LPX7LlLNIcCuR8/oeyzE?=
 =?us-ascii?Q?FuoLwAPlsZThmxtcOM0GS4bFlmWWsk93GylAllqBO5/U4BaxfECB7/d+EgOy?=
 =?us-ascii?Q?+714ZcSErtW6Ncxvw65Sh2OxUyEr3twtxOmALAl5j6aF6YnDTqCcU8xtllx7?=
 =?us-ascii?Q?IZP/F5vdYxh9LSrFnc7vSeEwVDOepBK0?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 13:53:21.2370
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eac63a24-5cc5-4a41-b7bc-08dce1573ee1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00029927.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6971

From: Edward Cree <ecree.xilinx@gmail.com>

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>
---
 drivers/net/ethernet/sfc/efx.c          | 15 +++++++++++++--
 drivers/net/ethernet/sfc/efx_channels.c |  4 ++++
 drivers/net/ethernet/sfc/efx_channels.h |  7 +++++++
 drivers/net/ethernet/sfc/net_driver.h   |  7 +++++++
 4 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/sfc/efx.c b/drivers/net/ethernet/sfc/efx.c
index ea1e0e8ecbdd..b0ea4ca82cd8 100644
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
@@ -668,6 +672,8 @@ static void efx_get_base_stats(struct net_device *net_dev,
 	struct efx_channel *channel;
 
 	rx->packets = 0;
+	rx->hw_drops = 0;
+	rx->hw_drop_overruns = 0;
 	tx->packets = 0;
 	tx->bytes = 0;
 
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
index 834d51812e2b..44d92c0e1b63 100644
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
index 46b702648721..547cf94014a3 100644
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
index aba106d03d41..f6632f8185b2 100644
--- a/drivers/net/ethernet/sfc/net_driver.h
+++ b/drivers/net/ethernet/sfc/net_driver.h
@@ -494,6 +494,10 @@ enum efx_sync_events_state {
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
@@ -556,6 +560,9 @@ struct efx_channel {
 	unsigned int n_rx_xdp_redirect;
 	unsigned int n_rx_mport_bad;
 
+	unsigned int old_n_rx_hw_drops;
+	unsigned int old_n_rx_hw_drop_overruns;
+
 	unsigned int rx_pkt_n_frags;
 	unsigned int rx_pkt_index;
 


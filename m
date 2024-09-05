Return-Path: <netdev+bounces-125612-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A395E96DEA1
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 17:43:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CFCD3B2551A
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 15:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 477E019EEA6;
	Thu,  5 Sep 2024 15:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2h1rqSIJ"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2041.outbound.protection.outlook.com [40.107.244.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1B019E7D0
	for <netdev@vger.kernel.org>; Thu,  5 Sep 2024 15:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725550957; cv=fail; b=JSIHDAH5pxZOyMnSmmCm+7lt/C+1j4vxa2RqruSSAKovmzN/C/LPG+r1mlXA5Xl2V9uBAmdHUAks4r3EwIAJ62YUkvhzoKCxsNOF8HMmVB65lq2X4p0v5D34RZXOuonr1uBI4zQbdaGaFJ67ZabrndeYwG4J8KrFTw80DZBYER0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725550957; c=relaxed/simple;
	bh=SUTWoPjmsI3HqwTAMKZdg+Y9pj/sr6dVYbcFfSCO3mE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kbSpOcHg9M11JFOi8iAvr2Pmu13UoJNv1A2okfl82uanPQMiQHNuhTJF1f2khghITfaFKzDsa/7L7gDsfgT0zq8Bid+Sc5zdiwEhwpdvBABW/s8nIyDtJLJmJlg9XEvOHM2rzmn+/NBPlYDyfzgMhtB4RSnK92a/KHBlTAD1QSs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2h1rqSIJ; arc=fail smtp.client-ip=40.107.244.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZY0X30XmYcctKOxiyLwXak2paYCFK0JSAra6qURW6QeOmQGysq25HITvQIrPoGN89z15v9OPuueInqVsFW4YT8m8PPMui8lfyblACRhh6FAuL4D6v/mtUEeuQvW6+XLbQMkcMOa9UnuBjlxb0KKXK5056BQeUg6hpixdjoHK5uM3S5Z8HZmXb+y83uqUK99oiiypUS/9tFT28oEfCgyae+A7AnUGUMUIiLUaGULatY/itxhIWB4QxfJzPz4lcQulvo3zu+blcJle6XvfW0f3T5rNfG9CvE47mFKFD9bnuIpawe9H0Cfid39vBt0FYAwfXj0WjDedGBTPvsPvd3SAOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bkC5F2Gz4aIksx/jXmKqyiI5nHUsyxiOoeB9l+1bh7o=;
 b=QmJFE/X/woHON0JP9VjYvUDZRrliQZT6r24sTux+AtlrskgUSJEaiYqNn+B7TqD128NnGAbYVeWIsH/oTj1GxZa3IyWM/Grj3tDeLtYC2zXEvGSHjaiEIZZQl2nBjyxIl5KTXOyfBoPLWIQwNe2JBHARbmlkemqJP4XICPUx1AqDj9NUPH++xw5WA042oD8wG38xtDDH4Dlaf/bisbX582++a8Ps/VMhfleP129ujqkutz7wggi9lz8ieokEmIU7tUUmCrk4LvpNaMiSx3ocL1EPf1STt2cLrq2nq5A8rRPOhvcr0DktjsFABu8OagIx7X3rPYkVKq/TOr50IL5oPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bkC5F2Gz4aIksx/jXmKqyiI5nHUsyxiOoeB9l+1bh7o=;
 b=2h1rqSIJNIZsLqJyLhyr+XtmqOM9Mw3HqoYkULGQPpSgGsMYQsff6mX8JM8IcaoOflyf82CsgWPnIPZCfGf7NWkuED3p2bu7n/8639kzBAwVee1PW6YmR6paS7dX9vZxjQHipo5Sp6+dM9BWD5wFVCDxKS4e/QqYw4JzHeto98I=
Received: from DS7PR03CA0071.namprd03.prod.outlook.com (2603:10b6:5:3bb::16)
 by IA0PR12MB8695.namprd12.prod.outlook.com (2603:10b6:208:485::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Thu, 5 Sep
 2024 15:42:31 +0000
Received: from DS1PEPF0001709C.namprd05.prod.outlook.com
 (2603:10b6:5:3bb:cafe::1) by DS7PR03CA0071.outlook.office365.com
 (2603:10b6:5:3bb::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27 via Frontend
 Transport; Thu, 5 Sep 2024 15:42:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS1PEPF0001709C.mail.protection.outlook.com (10.167.18.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Thu, 5 Sep 2024 15:42:30 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 5 Sep
 2024 10:42:28 -0500
Received: from xcbecree42x.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Thu, 5 Sep 2024 10:42:27 -0500
From: <edward.cree@amd.com>
To: <linux-net-drivers@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: Edward Cree <ecree.xilinx@gmail.com>, <netdev@vger.kernel.org>,
	<habetsm.xilinx@gmail.com>, <jacob.e.keller@intel.com>
Subject: [PATCH v2 net-next 4/6] sfc: implement per-queue rx drop and overrun stats
Date: Thu, 5 Sep 2024 16:41:33 +0100
Message-ID: <1224bf8e779980f37ca703be91610411ed340123.1725550155.git.ecree.xilinx@gmail.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709C:EE_|IA0PR12MB8695:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c64b179-979a-402d-6c61-08dccdc15a7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7/nJTolX1TPA2u4ACTxxbCJwS8qPwKlZjWleGsVmcjNcm+bsmCyzgZXP5Y+C?=
 =?us-ascii?Q?7vVxA6jJ4kt2m7GnNUOSQBb/1K3rxMRbLVcmx4lUwqrrX4N0tkAhOpfPDp5R?=
 =?us-ascii?Q?l/lCJutEs/MHMDUwfGldo/E+mL8PbLEZsI0TJXWzt3FqjcdZDwPDkGeE/G63?=
 =?us-ascii?Q?49wuus6jCfedmMMZWdXo3hDD+igX6+fY9wiwMJPhJN/doBvJ4QKv5KNVBTsC?=
 =?us-ascii?Q?zI/DIJchYtz/RcBLHIFuVfUcQVY54qDfhAzVFaTAWSlhKG7Rfzinp73IDxeE?=
 =?us-ascii?Q?iOE45IpGPaqZ4x7uZGtsgnv2IKZT70hYU2fSPXHQEFCzVUCDOjQi8ol8yIoG?=
 =?us-ascii?Q?oF2u7hm8jtLS6G3HcAw6WEMjV31uqeOqj3k+3qdJufArkM1HCKZgegB9JMmS?=
 =?us-ascii?Q?+9p9kJomep69dcaAm7dhsupulx5OEvD43n1E3Quj65WKZvXBgVeEcxDl13qT?=
 =?us-ascii?Q?CIstaTNOtApu5A3ZP4sGDVYtw+LITXI/K8QlJOl98Y56jM2KMu5Ri576o/U6?=
 =?us-ascii?Q?he2SPkosITv+NLagf+BAImtoI/lApObreTdIuvV/kDZdg47Nz78SWLHHxXT+?=
 =?us-ascii?Q?lCSo03ue+T6bl6c1wrB6B0JNeg4C5OEDwRLJ5pLnws2vcVDrmnRrG4mZm9t9?=
 =?us-ascii?Q?N4k7fJu5Z/+GqxVCucvoMLN1w4h9p8HSvNtf3L0Pwyp9MuPn1cDBQVQp/KlM?=
 =?us-ascii?Q?xWcWRHHdAJ9nnFw9jn4aSCaO1ud45VqgwzNce0jZYF6ptDP4yrevGLDr7CMQ?=
 =?us-ascii?Q?34ipiz/YkUUOaaZTtFWUZU9kffYvPFu1XeDxcm0p3N9dXWEqoesoIKVfsUMh?=
 =?us-ascii?Q?Vd9Qp2jPFx7FSKrDC8qdu3ZbzqjLqONdJ+OGYIje8Nkk8g5uLDo8Hscu8fc6?=
 =?us-ascii?Q?J/YEfJYH6VhM7dOj71Pi5AK9tmiA7l+RrPAPXJs9c/ipHRzwv9oi1neG26ew?=
 =?us-ascii?Q?fPcLF0MH7bmJkK5pBTOFbcH3iE0Csja6k6xCPLHT91Qc4bwOxf2PgUj+bSu3?=
 =?us-ascii?Q?jAuzt9kZGXTHgrzBvCxacUQN4z9aKrL0cU5whd6FBn3NOFA5Sq9avMScWlTO?=
 =?us-ascii?Q?Io3rHzlXWY8PH/8vG5hF13smKd/DLjMiiqx9/cE/2x7jV5QgCLnB9NMKXxx4?=
 =?us-ascii?Q?0gul/9YdMq44Ie0BmqFvxkTGVr1SF92aB+qCGHqa/0QD1tzn5sV0A4n9w0PV?=
 =?us-ascii?Q?NaKPjzZ6ILTs/cLIlqCxPK244CyIbtU55ffBzw1/AS6ZSR0oHptPWEXUZgeo?=
 =?us-ascii?Q?ipRZfwhzD5zLc6GJy/QLDNIAiBlrJcPM7W1ykZVBmuEQfnd+wEsQnzjAgsAW?=
 =?us-ascii?Q?NsEKVuDmx/k+Igj7vgy0u7P7vD5WIzTeSrkxw3erzj7eWr8MUAMhYyx3r3iZ?=
 =?us-ascii?Q?KSyH58CQFJXwCFSPFojDS7MKa8fln+kBrZIcqu1yXKiI20osbOO7bmE7i8sz?=
 =?us-ascii?Q?x2hOPhWC16B5wFGER2Ma/pkghVw/fZbu?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 15:42:30.9094
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c64b179-979a-402d-6c61-08dccdc15a7b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001709C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8695

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
index 9b0313cecc1d..a442867ebdaa 100644
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
@@ -670,6 +674,8 @@ static void efx_get_base_stats(struct net_device *net_dev,
 	struct efx_channel *channel;
 
 	rx->packets = 0;
+	rx->hw_drops = 0;
+	rx->hw_drop_overruns = 0;
 	tx->packets = 0;
 
 	/* Count all packets on non-core queues, and packets before last
@@ -677,10 +683,15 @@ static void efx_get_base_stats(struct net_device *net_dev,
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
 


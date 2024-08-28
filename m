Return-Path: <netdev+bounces-122790-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF51962924
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 15:46:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CEAD0B2324D
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 13:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 752B4188CB8;
	Wed, 28 Aug 2024 13:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="V1iMjWt4"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2051.outbound.protection.outlook.com [40.107.92.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA11E188014
	for <netdev@vger.kernel.org>; Wed, 28 Aug 2024 13:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724852766; cv=fail; b=RNGcK2ofPhXrKy+kemMGWanTaeY2f1uHpnqwEIr5ZIu4I7n18PJB19rFdAwWfRJGrHISt3ed+UgLebASjp4t91BlDQSlj76dIz9a03mMuy+rFTY+Ckbe8nI52X8SdvlIBwgHl2+tskSXKxyNuQzq6xzQ+j7q2SBuUdSl9fBjyDE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724852766; c=relaxed/simple;
	bh=QnlGXbssvsCcpDGbfk7mP+XhiEQcLKzKE15aqwCw8Xk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l3NxjRG9dl2cbFgy1JxR3BeEJYo2gGbbw6gXLLNZGIrq/lG0m6O9RjxiUxRDYzdSVV1UwGMcp2d78W8U1+E1SC9OfnZZiiokgXPs6TQJyjSLNMI6UBAuQPosDZyBfZaRPgqFb89zoSSrLSTqtLCDmDKK+E/iK7MKkMfQDMZ1Syk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=V1iMjWt4; arc=fail smtp.client-ip=40.107.92.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VKloY2CXp15TnzHpdkYe7TcPn6l2b9SW4dSVglITXxoBd0iJc+Cz7KwrCgen9fjw8Bu2VxPaFLMSnGRyBloElZtCk94my+MKmPg2stOS06lbmzD55riAcqtQF2HmcwtrFCW/wa5UXPhxWebzuloqZE3Fze6Smu0381wbs57GSEAWhT0hF20pSEhcj6WSGWBweqDDC+9aEVFj6W9rEVzX6+mSBFxWfeurCxSCHAoT3+HyWv2O2XmF9A/8uzGu/Zi4eU7SCV4d8tvXZrbX200yAmOCOrc3NSJik5/+nF/Ixg4PFTJxBG4A7C0PuVldyq60/j9Wrvfx4NgJg7i0dikWdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lbQogCNzWeAwSmJmwPOieRaXtB/5V9CyMgc+6FeYfV0=;
 b=j3CeMUeYsUjj22JsmQF/r3RpfHkt8P0JIDlpEpcBNttlWxUdQVjY1tHMoPF9ol8ohvj5jrUng+XBly8dZ0exqNF0Fwqufqtc3fotTSe5TrYbKPud1glgsCVTGp3Cc4J7ML0saWF55HGC8ui4ez9mPaWbn1B09ML4I9Acf533jKNq1W0iYyQ7D3GDjorYeMkFDHSy2N4ZxrSflsptg2JFfD4IqkOhI258AjVNLNWTc6iSTk1O9fTMpwQws9I7wYjFLGj498l3PO5yov7mCcMamF3u4rIfiWvXX9D1jfMYSk4MXiXljaaWD4faLyNKGDdMoTUTpAMbd8+1Yix5GDS25Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lbQogCNzWeAwSmJmwPOieRaXtB/5V9CyMgc+6FeYfV0=;
 b=V1iMjWt4LH8KC2KHGpLM7MSN92muTX8CbvIC+F6+4EubcEHnPrMLEzUOBcKRbRJdtgTor65BQ2EV7geX0OH4rfFfLiy+wa15gHfcOZ5jwf2ENvGdVhRBStUrHZgVGhTuLcrWZKO6piqr2BLWkUbxXGpL3L0rEIwjqQGDpeBe7Dc=
Received: from SA1P222CA0064.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:2c1::15)
 by SA1PR12MB8142.namprd12.prod.outlook.com (2603:10b6:806:334::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Wed, 28 Aug
 2024 13:46:00 +0000
Received: from SN1PEPF0002BA50.namprd03.prod.outlook.com
 (2603:10b6:806:2c1:cafe::d1) by SA1P222CA0064.outlook.office365.com
 (2603:10b6:806:2c1::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.28 via Frontend
 Transport; Wed, 28 Aug 2024 13:46:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF0002BA50.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Wed, 28 Aug 2024 13:46:00 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 28 Aug
 2024 08:45:59 -0500
Received: from xcbecree42x.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Wed, 28 Aug 2024 08:45:58 -0500
From: <edward.cree@amd.com>
To: <linux-net-drivers@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: Edward Cree <ecree.xilinx@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH net-next 5/6] sfc: implement per-queue TSO (hw_gso) stats
Date: Wed, 28 Aug 2024 14:45:14 +0100
Message-ID: <35782d70ad89c72d5dc819f9a12b2e5b4e742141.1724852597.git.ecree.xilinx@gmail.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA50:EE_|SA1PR12MB8142:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b238878-a1ac-4570-f2d1-08dcc767c0c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mKQzmyGkxF+XMY3tHwTpbT9J8Nt829chJ/vx/lxLPE7BHOLxJd9dMbI7TL75?=
 =?us-ascii?Q?8axZOulYVQA8PYJEFXrGCq69HiMB92CnaEEFsGrEqYutc2hvccY2WFae+dVB?=
 =?us-ascii?Q?bCX+1o58yMO/iDRestgIdd9lQjFU2+VD6EJxQdXg5arFhhvkHJu/cm4LXn8e?=
 =?us-ascii?Q?GfESCrcdBHCT68At8JmrfwPYfBIkkulVXnXigr/102m19tMxQv/K8jcvDzww?=
 =?us-ascii?Q?FjsshUdiC0aBQm4Ipw6Ju+Et0RYsZsKuUnVDeUiHE7nJlLhmlvuGV2Jpx9mf?=
 =?us-ascii?Q?kpB9ITw7gTq4Oyo62mML3GBVNn8LP4LfSsr/6ZhIaPFvIrpYpum76zOyXUxn?=
 =?us-ascii?Q?JtRhglP54vK6648qm/Aic8OsnnTSKL2ldHgyC6ac3Vouqm1STOcrOlbo3Usn?=
 =?us-ascii?Q?n6FfeDdyD82AatJuoAQUYQ+B8fwDAtyrrHE3I6L1oIiC+zM3a2fEKSMr3et1?=
 =?us-ascii?Q?yrGG74X+GtNYTx2KOamXvlV0hZr+0PpUqWMpXuG58kKGR5y/OUpL43aAGltJ?=
 =?us-ascii?Q?asoi73rYS7TlVWahtrzYrB7ZdZasBTL3RfUMBC+XF3A60NZQpmdVJPS1/bC0?=
 =?us-ascii?Q?xpJUl9tcdKnQPuD494i84Ywj7UIH7GVTdpRIS9lhDyiu/Aely0PxiZYugjZk?=
 =?us-ascii?Q?bdn42o/anYhZ50FbUtsnTo6gqABnbW2VYrH07AbaAXqh/3bApfcMXKrj7yEN?=
 =?us-ascii?Q?0fS5cff+52Je8BJaNFaZJARrCXAOs7OaxLLunBG9wD8m5bZDvyEDLmpfndMZ?=
 =?us-ascii?Q?pDrEEMEsP77NDalwSx9bMI/MGcvG8/GO3HgEK+h7tcbAc3ZvS3nqb63BVo6o?=
 =?us-ascii?Q?iECvpGRqOfVepsQs8L8/sdjwfwnnEdug0cg4A57quumI2G6c9ztvTHwD5mmh?=
 =?us-ascii?Q?GfZqPg7GC01VztCq3FfRKj9VghefHQRcUvou7Re+Ocq1PzV/QCdQRxk8VsMF?=
 =?us-ascii?Q?k1Fsy4U7aN3tlsMnSLhwTlIQcuozgf/nnwXzRUBNt/SAfvlIN9a0xkcu+AZS?=
 =?us-ascii?Q?w/al4V1kOch1T3z3YgjMpZI2Vi1+4afEUbvsmSOjAD/eBVe7ndhgXpkpie3r?=
 =?us-ascii?Q?JqROfQms4dDiVQt1WmI+x3jlgb/8QwrK99U4L20JZYBD9QJSwrRXnp9FbyC4?=
 =?us-ascii?Q?byaENJ3L8fDPIGzA1C1gc++ke2WiPwTelTCZQJHoZFqSIYsE1ngN67z6a8IG?=
 =?us-ascii?Q?bVmeZ5wf0i/k9sSwvXEuMuMVn9WFwfYrzBJvaXJYFTXAzwCiOO/jMFtpqFMv?=
 =?us-ascii?Q?bkdRO7yAqteS76id9Qst8sO8ZNXhj8vEzohVaqyZsu1v0H0vatjfdETNIevJ?=
 =?us-ascii?Q?X/CRr1W6OFk9iIgt3V2ieF1NEM/7k95KPbi2uZOHWXpTVrw64aT6j1vfn/8/?=
 =?us-ascii?Q?lpSHEohhZ+BApYY33zRosc/rU7VJXjQ8uD3u+wSvRw4AO8DYmNvNUYkR4mD9?=
 =?us-ascii?Q?zeI6/3PIEzE=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 13:46:00.8612
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b238878-a1ac-4570-f2d1-08dcc767c0c3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA50.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8142

From: Edward Cree <ecree.xilinx@gmail.com>

Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>
---
 drivers/net/ethernet/sfc/efx.c        | 20 +++++++++++++++++---
 drivers/net/ethernet/sfc/net_driver.h |  4 ++++
 drivers/net/ethernet/sfc/tx_common.c  |  2 ++
 3 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/sfc/efx.c b/drivers/net/ethernet/sfc/efx.c
index 8b46d143b6c7..bf06fbcdcbff 100644
--- a/drivers/net/ethernet/sfc/efx.c
+++ b/drivers/net/ethernet/sfc/efx.c
@@ -653,14 +653,21 @@ static void efx_get_queue_stats_tx(struct net_device *net_dev, int idx,
 
 	channel = efx_get_tx_channel(efx, idx);
 	stats->packets = 0;
+	stats->hw_gso_packets = 0;
+	stats->hw_gso_wire_packets = 0;
 	/* If a TX channel has XDP TXQs, the stats for these will be counted
 	 * under the channel rather than in base stats.  Unclear whether this
 	 * is correct behaviour, but we can't reliably exclude XDP TXes from
 	 * these stats anyway because in EFX_XDP_TX_QUEUES_BORROWED we use
 	 * the same TXQ as the core.
 	 */
-	efx_for_each_channel_tx_queue(tx_queue, channel)
+	efx_for_each_channel_tx_queue(tx_queue, channel) {
 		stats->packets += tx_queue->tx_packets - tx_queue->old_tx_packets;
+		stats->hw_gso_packets += tx_queue->tso_bursts -
+					 tx_queue->old_tso_bursts;
+		stats->hw_gso_wire_packets += tx_queue->tso_packets -
+					      tx_queue->old_tso_packets;
+	}
 }
 
 static void efx_get_base_stats(struct net_device *net_dev,
@@ -676,6 +683,8 @@ static void efx_get_base_stats(struct net_device *net_dev,
 	rx->hw_drops = 0;
 	rx->hw_drop_overruns = 0;
 	tx->packets = 0;
+	tx->hw_gso_packets = 0;
+	tx->hw_gso_wire_packets = 0;
 
 	/* Count all packets on non-core queues, and packets before last
 	 * datapath start on core queues.
@@ -694,10 +703,15 @@ static void efx_get_base_stats(struct net_device *net_dev,
 		efx_for_each_channel_tx_queue(tx_queue, channel) {
 			if (channel->channel < efx->tx_channel_offset ||
 			    channel->channel >= efx->tx_channel_offset +
-						net_dev->real_num_tx_queues)
+						net_dev->real_num_tx_queues) {
 				tx->packets += tx_queue->tx_packets;
-			else
+				tx->hw_gso_packets += tx_queue->tso_bursts;
+				tx->hw_gso_wire_packets += tx_queue->tso_packets;
+			} else {
 				tx->packets += tx_queue->old_tx_packets;
+				tx->hw_gso_packets += tx_queue->old_tso_bursts;
+				tx->hw_gso_wire_packets += tx_queue->old_tso_packets;
+			}
 		}
 	}
 }
diff --git a/drivers/net/ethernet/sfc/net_driver.h b/drivers/net/ethernet/sfc/net_driver.h
index 25701f37aa40..2cf2935a713c 100644
--- a/drivers/net/ethernet/sfc/net_driver.h
+++ b/drivers/net/ethernet/sfc/net_driver.h
@@ -234,6 +234,8 @@ struct efx_tx_buffer {
  * @notify_count: Count of notified descriptors to the NIC
  * @tx_packets: Number of packets sent since this struct was created
  * @old_tx_packets: Value of @tx_packets as of last efx_init_tx_queue()
+ * @old_tso_bursts: Value of @tso_bursts as of last efx_init_tx_queue()
+ * @old_tso_packets: Value of @tso_packets as of last efx_init_tx_queue()
  * @empty_read_count: If the completion path has seen the queue as empty
  *	and the transmission path has not yet checked this, the value of
  *	@read_count bitwise-added to %EFX_EMPTY_COUNT_VALID; otherwise 0.
@@ -284,6 +286,8 @@ struct efx_tx_queue {
 	/* Statistics to supplement MAC stats */
 	unsigned long tx_packets;
 	unsigned long old_tx_packets;
+	unsigned int old_tso_bursts;
+	unsigned int old_tso_packets;
 
 	/* Members shared between paths and sometimes updated */
 	unsigned int empty_read_count ____cacheline_aligned_in_smp;
diff --git a/drivers/net/ethernet/sfc/tx_common.c b/drivers/net/ethernet/sfc/tx_common.c
index f1694900e0f0..cd0857131aa8 100644
--- a/drivers/net/ethernet/sfc/tx_common.c
+++ b/drivers/net/ethernet/sfc/tx_common.c
@@ -87,6 +87,8 @@ void efx_init_tx_queue(struct efx_tx_queue *tx_queue)
 	tx_queue->completed_timestamp_minor = 0;
 
 	tx_queue->old_tx_packets = tx_queue->tx_packets;
+	tx_queue->old_tso_bursts = tx_queue->tso_bursts;
+	tx_queue->old_tso_packets = tx_queue->tso_packets;
 
 	tx_queue->xdp_tx = efx_channel_is_xdp_tx(tx_queue->channel);
 	tx_queue->tso_version = 0;


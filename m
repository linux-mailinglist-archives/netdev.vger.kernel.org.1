Return-Path: <netdev+bounces-125614-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7569796DEA3
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 17:43:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D383DB256DD
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 15:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8114519F49D;
	Thu,  5 Sep 2024 15:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RzVA3Bfc"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2087.outbound.protection.outlook.com [40.107.92.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDDB419F408
	for <netdev@vger.kernel.org>; Thu,  5 Sep 2024 15:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725550959; cv=fail; b=KYE4S+N3VapYd4YorBOlqO8ViEDFHhLQbgrB7cdFRzqIEA6C7kaPnF4AAbbN1G3hDwxhZSHXJX58HTmvqc44f6npKFMm/08wSZJ6eXtyJ13M+XRy8sKniPumPCWKZ3/kxbP7zQ+eFI7AtGq/HCqNAZVRkuZESIeTPgduPcoAMJc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725550959; c=relaxed/simple;
	bh=iynTbeW0Snx4ZKoce87n9X6nqJEjdlrOOXGpD1msBXc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rGdZfUt4ufdIfvb74iuXSjl85e/2FlYUj7C+7gSzSDZ+KgkusfgMqxNxkjw3JGa5eAghdOJ8toTxpkdYNd3RvMzp2QX2feg8nJV3AWS1boUmnwyi/SyKPBR5JSM7OsL3UaxFSsLYWg+pc6NWSf1TDoKar+5H6qRFMPp+tXrUb/Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RzVA3Bfc; arc=fail smtp.client-ip=40.107.92.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=STc+qMxq95NvgoCUK1/f6hRrK/Rj7m4KPT+oCm5ZbkLuq0nA9K7M6L4OQHPkyIp44tcHWZLNvtvt1F1koX+XVggE0tQA/jQWsUP0zATPpKGQJqe4HYFcHnxbmCHq55uF7FpcgsWP214YN0fyxzSYCpbujhPTV0kc6Ltxg52J7Ju9hDEY8AREM6zywLAIhBgjtuxNBYyd7iAo9S8FmpB+3OnR+2kCUSwj3tdRu8PIjFmfEusY5gDRnz0JCdC3YxZQvNxM0cyiOEQw/FOPG4TnwphYqDbY+be9+ZmFFSP7t4LtWxXbFtKnggDZj5pBtwAoKbjlMGtIxKD9hCheoSKJxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oxkq5GMSa2q5FcOHKx3GyIKBAwX4n39W8u3O8D18//s=;
 b=PLJLsQMaGtBzSShgbCa8Hixj1IV3ds6uyMAxI1kv11x5KqbAUW7chWgiQLtXvJWaVIcZNxhKg/xpQlTDaAp8quZ8b4JGms3Pda7PazsfqQQas+4gcmtZv5xV5hG7M55T7bc9AfwXHQLUxmD8sqjl+woD18icb5xTrfb5F+ICXw0ueNzsN8P+abRzE6n8KsJsChY2ekRQg8cio+pUOINee9WfGh5/aiTDT7rkOaa42vs/+BGR3gJVFaggnj9UGMXUAaVxEJFA2D3Eg9oHNZyXULpleBtrv3Shk5WuhPbokofti30j1YYtzBODdji81PB803OBqM4WVUzR1gAfjOHqDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oxkq5GMSa2q5FcOHKx3GyIKBAwX4n39W8u3O8D18//s=;
 b=RzVA3Bfcpr+gZBQ6EEO8mrsURiS/6tHbYfF3fzI8dykJY1aakY+OkCKrsNDrgNq8U9BtcDVGqdPcaqLUfJfFQ/ZG07Jbm70ierUMGsDwAtoinX4tUdoXnMeycQ+6TMvxKvNZtbstq5iuZFns4nCqYdq/klO2XvcJkUu1l7ObVgU=
Received: from DS7PR03CA0068.namprd03.prod.outlook.com (2603:10b6:5:3bb::13)
 by PH7PR12MB5877.namprd12.prod.outlook.com (2603:10b6:510:1d5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Thu, 5 Sep
 2024 15:42:32 +0000
Received: from DS1PEPF0001709C.namprd05.prod.outlook.com
 (2603:10b6:5:3bb:cafe::53) by DS7PR03CA0068.outlook.office365.com
 (2603:10b6:5:3bb::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27 via Frontend
 Transport; Thu, 5 Sep 2024 15:42:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS1PEPF0001709C.mail.protection.outlook.com (10.167.18.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Thu, 5 Sep 2024 15:42:32 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 5 Sep
 2024 10:42:29 -0500
Received: from xcbecree42x.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Thu, 5 Sep 2024 10:42:28 -0500
From: <edward.cree@amd.com>
To: <linux-net-drivers@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: Edward Cree <ecree.xilinx@gmail.com>, <netdev@vger.kernel.org>,
	<habetsm.xilinx@gmail.com>, <jacob.e.keller@intel.com>
Subject: [PATCH v2 net-next 5/6] sfc: implement per-queue TSO (hw_gso) stats
Date: Thu, 5 Sep 2024 16:41:34 +0100
Message-ID: <1cb576697367358868fa611d12bc8a01f0fec974.1725550155.git.ecree.xilinx@gmail.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709C:EE_|PH7PR12MB5877:EE_
X-MS-Office365-Filtering-Correlation-Id: c0a581b4-58ae-4b41-b35d-08dccdc15b24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fBnRTx/yib2vDCiF27Z51owDky8k6wnzUErqFZQUx5Nf4mIuDeKAFgFfmWKc?=
 =?us-ascii?Q?UH6gOj8J5f6z2QG0Dt7K8rTXOpljh+222boRMRTjfcYI1wdmscSCiAggm9MB?=
 =?us-ascii?Q?1HMtHzNbYgpFQQUjmIRVoucvBMKsnpUYVvLUkVbfb7pgVQTP2RskDT1D4ExT?=
 =?us-ascii?Q?mD6uDlm65jKc5+QJ+gJKyzD88JMBx7b66BDMqZ2fKIrAheBRJF9kAqSJV8r7?=
 =?us-ascii?Q?D77vr5aAeYsZFSt/lX70uNy/WvH01a3yiUllzl5+sfyi740vVPEnfg4RJ4qG?=
 =?us-ascii?Q?xNtUHB/9ebuv9FP7tXiyQDCAfF16clQUA2iqdgeNY5hfm8iNd9AZyG7SWbyY?=
 =?us-ascii?Q?pTis2a70bk6RhG6gi8kjywK9n90Cf0qv9nIlbtTBBMojWPMwEJoq70T/U0vA?=
 =?us-ascii?Q?2F55UpDn9UnL6VmqCurCzu/KpuobLXcuuFE0Y42EjNusLiKSNdL6G7ifQw+P?=
 =?us-ascii?Q?jDz3W7b9cz9oI8f4QKIOSasGUyyCimQYvqSwpgfSn85MXQ8PRpXbnbPeNqot?=
 =?us-ascii?Q?WjbLAmLbdjZgpxTBtRBldvJTvhTCiTuh3t0ZiaJEtbXhjoeLYmsbDTFU86K/?=
 =?us-ascii?Q?uxrM4oEt+/79YgH0y4bn2xLvRMdLjKcmQu/GhZ1C87wp713BJNjYj1aPpYjE?=
 =?us-ascii?Q?jrhzkgjTOer0xUP14QNQr9B7nbmR5ehA3h4LOrtussVdJKKQToYUOTPCj8Oh?=
 =?us-ascii?Q?noiRXzwQgp18xjE9DLkwxFbPOrdMcHprigMPMlD/uI/DFCER4zAtubSHAc2k?=
 =?us-ascii?Q?vlHgMKmw9u2VF1Ei8O+65pQ82RE3lSgJe7wMS9/7kBrh+RXkRqBmspyU1Jbv?=
 =?us-ascii?Q?9+LGFxwh9OtP6+8Vqs0vHN8JVhXSBfUSnroBwPE0ARegeFOFy86AKQoFaIRc?=
 =?us-ascii?Q?DYvmpAZVJtg4fE9FQrD0NWDx+2raqfCR6GkVIbavd3uud04ZniKh/HPC41Ud?=
 =?us-ascii?Q?LWjGL/BYHu6GFzzd3CiF8eomLZqn2Zt1EcpGAs5g58+cH4+7zcywkpciTNjM?=
 =?us-ascii?Q?EzRTE/fGKRnEd9iYTzU36JFGgyrgPn0c1ahfS/dhB1uZvmJbHd9XPE5nMHS3?=
 =?us-ascii?Q?rI0r7WkZ6XDSckJPTIeI9vJSE0lQD5WMe/uCzAwF2yCMvHCyIh9vEfb5vW/E?=
 =?us-ascii?Q?ygutftBYnxQjHFXlyp9WbAA3cVtlkKlXAiDrn0YVzzpS67BXL3OzKf5xura/?=
 =?us-ascii?Q?6w/vfQpw4pA+3dcmWxYM5s4hL63qV9A3vhtQHNGlDnikg7ex/Iw1S1IYRyj+?=
 =?us-ascii?Q?8qWpNL5XWlnaPsQaxXFLucXzCQO8dOXRg+ylR28CjsCS+KOBsJJcDEAMrXUw?=
 =?us-ascii?Q?6jKTTSB9nrkkK4P2j6aCsAb/Wqumu9zPjaIF30tHvRrcwP7fv1psVOYvzrwX?=
 =?us-ascii?Q?U7g12Ny9+uyfCkal8J2K8lfP22m/kb5X0z/ZtNKxk5dssHWX21vMkNytNbPb?=
 =?us-ascii?Q?eBCYmPWbnp4=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 15:42:32.0188
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0a581b4-58ae-4b41-b35d-08dccdc15b24
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001709C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5877

From: Edward Cree <ecree.xilinx@gmail.com>

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>
---
 drivers/net/ethernet/sfc/efx.c        | 20 +++++++++++++++++---
 drivers/net/ethernet/sfc/net_driver.h |  4 ++++
 drivers/net/ethernet/sfc/tx_common.c  |  2 ++
 3 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/sfc/efx.c b/drivers/net/ethernet/sfc/efx.c
index a442867ebdaa..4b546f61dfaf 100644
--- a/drivers/net/ethernet/sfc/efx.c
+++ b/drivers/net/ethernet/sfc/efx.c
@@ -653,15 +653,22 @@ static void efx_get_queue_stats_tx(struct net_device *net_dev, int idx,
 
 	channel = efx_get_tx_channel(efx, idx);
 	stats->packets = 0;
+	stats->hw_gso_packets = 0;
+	stats->hw_gso_wire_packets = 0;
 	/* If a TX channel has XDP TXQs, the stats for these will be counted
 	 * in base stats; however, in EFX_XDP_TX_QUEUES_BORROWED mode we use
 	 * the same TXQ as the core, and thus XDP TXes get included in these
 	 * per-queue stats.
 	 */
 	efx_for_each_channel_tx_queue(tx_queue, channel)
-		if (!tx_queue->xdp_tx)
+		if (!tx_queue->xdp_tx) {
 			stats->packets += tx_queue->tx_packets -
 					  tx_queue->old_tx_packets;
+			stats->hw_gso_packets += tx_queue->tso_bursts -
+						 tx_queue->old_tso_bursts;
+			stats->hw_gso_wire_packets += tx_queue->tso_packets -
+						      tx_queue->old_tso_packets;
+		}
 }
 
 static void efx_get_base_stats(struct net_device *net_dev,
@@ -677,6 +684,8 @@ static void efx_get_base_stats(struct net_device *net_dev,
 	rx->hw_drops = 0;
 	rx->hw_drop_overruns = 0;
 	tx->packets = 0;
+	tx->hw_gso_packets = 0;
+	tx->hw_gso_wire_packets = 0;
 
 	/* Count all packets on non-core queues, and packets before last
 	 * datapath start on core queues.
@@ -696,10 +705,15 @@ static void efx_get_base_stats(struct net_device *net_dev,
 			if (channel->channel < efx->tx_channel_offset ||
 			    channel->channel >= efx->tx_channel_offset +
 						net_dev->real_num_tx_queues ||
-			    tx_queue->xdp_tx)
+			    tx_queue->xdp_tx) {
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


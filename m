Return-Path: <netdev+bounces-130402-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E9AC98A64E
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 15:57:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92EA11C2128E
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 13:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53166199E82;
	Mon, 30 Sep 2024 13:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CyXY92W2"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2083.outbound.protection.outlook.com [40.107.94.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D91B191F79
	for <netdev@vger.kernel.org>; Mon, 30 Sep 2024 13:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727704405; cv=fail; b=ic9/7k2YvHqBmvzTbuBzEuBdJB4v7Z0J+7ZvAglYLHvWJ2oOKYIs0QtlowWUriwopL19fd0flb7+B5sWhrRt4MTbFVZMYxYnwDbaQAW7SqNES0drVZmW1dIY0xNASZia3DICJ/Ak6K7sHbW07shKq/OMhVun1z5wEwyoxcIJ/SU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727704405; c=relaxed/simple;
	bh=pPWTYDmixPhRLCHcZ9rpS3Wp2A71AXolnz/p6VSl3NI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gXG5Vjvt2izZUiSaroZzEZMYN7JE2HeVJL2jSsZkjg8BEQpwb+rGV0nPwVA+dU5O9UZ6e7buEN+5AdUjhLiOy0rjHZRrHBT+8qfelfxZDcn2EFvrKthx1c10q+odCjPSQEUo1OOJBGmAIMDLc7iTVEL9EcB6UxFosePMMgNNEOg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CyXY92W2; arc=fail smtp.client-ip=40.107.94.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FHKK/scnIFuSXAXBvcAVkOhg58fIgfZH1Yr/xJkqC1TAPPDJIjCe7GtB5I+gdAKzsCBkv0gL3H6xFtvsopIDmWO2B+p6FLcbuXPaRp8aoBKqlPhe9rHoRsiIdhOeVaL/PH9i1A4vYlE7jML2f0I1PQET8fnEcFCJa7sLQ8K1YaSiPiDfblc6rb4+o+swc/j1qRWyiGiBn5wBuBfHW2+SDhBAngtmebEySv6/SpgruGZohteZlJgpo7XiXSewYh34rbvCpy9HGgtWYe4atYi+UiKF9/2PCsHvW6zdT507yZL9+x7He1u6rylmZP04e6Fz9zVh8YxqFbTUONFL+z+0UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E9gwSEhRQ2tT+qiziVBTJAtitlov9TWKdhaAeJE+2YQ=;
 b=xRYP1oqdWP4zlEsfsSF1RR2dGUiENmG33vfUTft5K5VF91ofTJOti0Wf1s3tgJuoGE2Yj2ROXDYZpALIr3blrf1OCXA+fzUYm/NVUj4iu6ebSztzXI9c7z0zhfWzEqscAeHiel6Nz7zXe7B6LWon3p5730adxwMKcpOAkh3QbCxHcyzOl7MY8Fii3GoWurxas9tMLVOj7dWRu0xZ6zUmDf0ZWFILochTau+fpYiGnP0xRjjx8ewVWvGG81yTtDVED4HOxocotFP3VOAuCxNboy+LDjt3rwhZwvF1sPfJDj+XxgJDntz3QzZD/lOnR83CFVa0Di0oekM5cfMShvyIYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E9gwSEhRQ2tT+qiziVBTJAtitlov9TWKdhaAeJE+2YQ=;
 b=CyXY92W2k2wN7uNi7Ti+JoTXgmqOgrocx1YG8P0WwQtwa8dNo4vJFGRxUp0T1w/gcQg4NVDcGmV0bBFdSEyIazF1hN4If+FGEhKf0h5e3v5QLhg9XfMNF6IdwyuavlOr81zpsJu9znz0ZHsY0sWdKtiAiRsUP+iOZqbZ97TARtA=
Received: from BL1PR13CA0067.namprd13.prod.outlook.com (2603:10b6:208:2b8::12)
 by DS0PR12MB9276.namprd12.prod.outlook.com (2603:10b6:8:1a0::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.24; Mon, 30 Sep
 2024 13:53:20 +0000
Received: from BL02EPF00029927.namprd02.prod.outlook.com
 (2603:10b6:208:2b8:cafe::2e) by BL1PR13CA0067.outlook.office365.com
 (2603:10b6:208:2b8::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.15 via Frontend
 Transport; Mon, 30 Sep 2024 13:53:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF00029927.mail.protection.outlook.com (10.167.249.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Mon, 30 Sep 2024 13:53:20 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 30 Sep
 2024 08:53:19 -0500
Received: from xcbecree42x.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Mon, 30 Sep 2024 08:53:18 -0500
From: <edward.cree@amd.com>
To: <linux-net-drivers@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: Edward Cree <ecree.xilinx@gmail.com>, <netdev@vger.kernel.org>,
	<habetsm.xilinx@gmail.com>, <jacob.e.keller@intel.com>
Subject: [PATCH v4 net-next 4/7] sfc: account XDP TXes in netdev base stats
Date: Mon, 30 Sep 2024 14:52:42 +0100
Message-ID: <44d77cdcc1df6d2606945481ded02ba824d9d507.1727703521.git.ecree.xilinx@gmail.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00029927:EE_|DS0PR12MB9276:EE_
X-MS-Office365-Filtering-Correlation-Id: bc71d179-9306-4882-49ec-08dce1573e31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?o8K9xj1XVUMbVOYD8oA/TOX2Jhh8dlKCiZEKMKjR0VcqCgw0Xna2AqBEoFNB?=
 =?us-ascii?Q?CtmFxtQei9pp8Ms1h0Hm8/wcpdc9qamPHuWWUqrbj4RxXKYzHOuCAgUSV/uH?=
 =?us-ascii?Q?FlY/gCGw8AaxtAsaFO26ZCtJ/CKOkKTLzKf6O8psBYP+IGDyX6UI4WNkLB4v?=
 =?us-ascii?Q?ZIyL+M0TyVAhemIhxo6Ujg334cofR81HXAvqZAX45ZMI81EbQWyvGsV9hSDP?=
 =?us-ascii?Q?MHn3AZ3Ou1zDV+HTztwINRa5idzK4NWgXXrK8dVdVRdpzllYyt2uCb0RYfiB?=
 =?us-ascii?Q?OVZ4FIX5bHJWij0TtzR1hymHYSiClv8c0bNkkLkWCMXitiRNebK4CtLoQ2Q2?=
 =?us-ascii?Q?KywJab7qR9E7N1hFVyQKh1083WxPAQqkqvG1NfLG69Zet0SQNScjyF0zsGFR?=
 =?us-ascii?Q?/VnSrJkHf2h6fMd9K7UZ4VMHIPBbOVMnETaDPi7MYzgoX+4bsdfmAm8npL6O?=
 =?us-ascii?Q?dkf42NQrpQkveTsfo9tZbj90hM7InPX94A1+CKOb6Kj7tRd9heAR8kc788mK?=
 =?us-ascii?Q?oJzVcPC740W1YIz/VcVjB6OgoKJqoCs2KKLreXySGdu1Ftz6P+KLxSBqyJmh?=
 =?us-ascii?Q?DsmwUCTcl3rVEiCz7g16AMWRiL4pOO1bk9oGnowlSk0udKDdbDox2N3c4jQ2?=
 =?us-ascii?Q?orCPAQYGnynoQ1GGXb/1W6DREObwHwT2AVULBItLnqAvi8MKMd6geJ84v6xY?=
 =?us-ascii?Q?F0B8DT1PdR1j1UnwR3ly+D7ecymVl9JbjrpmE7z+qateEJZxjG4Kv+rycEOp?=
 =?us-ascii?Q?/xjg15il/gQolJrdC9RIliXCg9kVHdEeq4YWlLKrDE3ivc9vdp4P3iYco3ks?=
 =?us-ascii?Q?JGQh4s1HNm2K0R7OY5keVxRSQVJ6hCDSIUD6ACJBAgnRieQlOmh0J2OFXGl1?=
 =?us-ascii?Q?Nm7yCCTH8+R/cs3Di/HnnPRrbTE2wtxuGeE858n8ZXg85nlLFKFcKSFVlyfs?=
 =?us-ascii?Q?huF49VmtD4WQQKpuNY7I4NXcHy0twlNsLLnG8CWTIcIdrefQNKXt3YbkxYFR?=
 =?us-ascii?Q?hCuzqo82twH/18J6H3kAzdyoUXmLqHCnHavMz6BzWPUdmg6XzqMqvpGvofUY?=
 =?us-ascii?Q?+qO9PRlE5yT9Hn/ZLyCagCo/g1XLknw/PhV3lMepox0EGFVwxXUasXjxSrSF?=
 =?us-ascii?Q?v/5KEOGYsEDqla3h0Rw7Unqef+SxBweElqG3A+bHtYJ+RYcSLPOnaoCK6C8h?=
 =?us-ascii?Q?pHt8iwqWkWDSIDaQrUMjNWTbDIgB8ctvE47YdxKxj7Mh3bLp/yJttWb3hAjI?=
 =?us-ascii?Q?tvbqp8WGLzJXBGizWASSyBsxSD0E60Sw9aGGjp6//s35wk/wFViR8ngvQrDI?=
 =?us-ascii?Q?DdxUNhiIsy6ty6elbYCZvmohemxTDm4U4D0Vzt3hBlL71FmZO6QrIWJSDLh+?=
 =?us-ascii?Q?l1HY7b2z1rCIqDigA68Nxy2GfK9hY/VciPbt9icNv9Ek6rPAL/BjihdSJjBa?=
 =?us-ascii?Q?B9rQzoP++9eGlDhCAFMkKi4vuH83J6dA?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 13:53:20.0652
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc71d179-9306-4882-49ec-08dce1573e31
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00029927.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9276

From: Edward Cree <ecree.xilinx@gmail.com>

When we handle a TX completion for an XDP packet, it is not counted
 in the per-TXQ netdev stats.  Record it in new internal counters,
 and include those in the device-wide total in efx_get_base_stats().

Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>
---
 drivers/net/ethernet/sfc/efx.c        |  3 +++
 drivers/net/ethernet/sfc/net_driver.h |  6 ++++++
 drivers/net/ethernet/sfc/tx.c         |  6 +++++-
 drivers/net/ethernet/sfc/tx_common.c  | 28 +++++++++++++++++++++------
 drivers/net/ethernet/sfc/tx_common.h  |  4 +++-
 5 files changed, 39 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/sfc/efx.c b/drivers/net/ethernet/sfc/efx.c
index 21dc4b885542..ea1e0e8ecbdd 100644
--- a/drivers/net/ethernet/sfc/efx.c
+++ b/drivers/net/ethernet/sfc/efx.c
@@ -690,6 +690,9 @@ static void efx_get_base_stats(struct net_device *net_dev,
 				tx->packets += tx_queue->old_complete_packets;
 				tx->bytes += tx_queue->old_complete_bytes;
 			}
+			/* Include XDP TX in device-wide stats */
+			tx->packets += tx_queue->complete_xdp_packets;
+			tx->bytes += tx_queue->complete_xdp_bytes;
 		}
 	}
 }
diff --git a/drivers/net/ethernet/sfc/net_driver.h b/drivers/net/ethernet/sfc/net_driver.h
index 83c33c1ca120..aba106d03d41 100644
--- a/drivers/net/ethernet/sfc/net_driver.h
+++ b/drivers/net/ethernet/sfc/net_driver.h
@@ -216,6 +216,10 @@ struct efx_tx_buffer {
  *	created.  For TSO, counts the superframe size, not the sizes of
  *	generated frames on the wire (i.e. the headers are only counted
  *	once)
+ * @complete_xdp_packets: Number of XDP TX packets completed since this
+ *	struct was created.
+ * @complete_xdp_bytes: Number of XDP TX bytes completed since this
+ *	struct was created.
  * @completed_timestamp_major: Top part of the most recent tx timestamp.
  * @completed_timestamp_minor: Low part of the most recent tx timestamp.
  * @insert_count: Current insert pointer
@@ -281,6 +285,8 @@ struct efx_tx_queue {
 	unsigned int pkts_compl;
 	unsigned long complete_packets;
 	unsigned long complete_bytes;
+	unsigned long complete_xdp_packets;
+	unsigned long complete_xdp_bytes;
 	u32 completed_timestamp_major;
 	u32 completed_timestamp_minor;
 
diff --git a/drivers/net/ethernet/sfc/tx.c b/drivers/net/ethernet/sfc/tx.c
index fe2d476028e7..822ec6564b2d 100644
--- a/drivers/net/ethernet/sfc/tx.c
+++ b/drivers/net/ethernet/sfc/tx.c
@@ -553,6 +553,7 @@ netdev_tx_t efx_hard_start_xmit(struct sk_buff *skb,
 
 void efx_xmit_done_single(struct efx_tx_queue *tx_queue)
 {
+	unsigned int xdp_pkts_compl = 0, xdp_bytes_compl = 0;
 	unsigned int pkts_compl = 0, bytes_compl = 0;
 	unsigned int efv_pkts_compl = 0;
 	unsigned int read_ptr;
@@ -577,7 +578,8 @@ void efx_xmit_done_single(struct efx_tx_queue *tx_queue)
 		if (buffer->flags & EFX_TX_BUF_SKB)
 			finished = true;
 		efx_dequeue_buffer(tx_queue, buffer, &pkts_compl, &bytes_compl,
-				   &efv_pkts_compl);
+				   &efv_pkts_compl, &xdp_pkts_compl,
+				   &xdp_bytes_compl);
 
 		++tx_queue->read_count;
 		read_ptr = tx_queue->read_count & tx_queue->ptr_mask;
@@ -585,6 +587,8 @@ void efx_xmit_done_single(struct efx_tx_queue *tx_queue)
 
 	tx_queue->pkts_compl += pkts_compl;
 	tx_queue->bytes_compl += bytes_compl;
+	tx_queue->complete_xdp_packets += xdp_pkts_compl;
+	tx_queue->complete_xdp_bytes += xdp_bytes_compl;
 
 	EFX_WARN_ON_PARANOID(pkts_compl + efv_pkts_compl != 1);
 
diff --git a/drivers/net/ethernet/sfc/tx_common.c b/drivers/net/ethernet/sfc/tx_common.c
index 6d47927e1c2c..2013a609f9be 100644
--- a/drivers/net/ethernet/sfc/tx_common.c
+++ b/drivers/net/ethernet/sfc/tx_common.c
@@ -112,12 +112,14 @@ void efx_fini_tx_queue(struct efx_tx_queue *tx_queue)
 
 	/* Free any buffers left in the ring */
 	while (tx_queue->read_count != tx_queue->write_count) {
+		unsigned int xdp_pkts_compl = 0, xdp_bytes_compl = 0;
 		unsigned int pkts_compl = 0, bytes_compl = 0;
 		unsigned int efv_pkts_compl = 0;
 
 		buffer = &tx_queue->buffer[tx_queue->read_count & tx_queue->ptr_mask];
 		efx_dequeue_buffer(tx_queue, buffer, &pkts_compl, &bytes_compl,
-				   &efv_pkts_compl);
+				   &efv_pkts_compl, &xdp_pkts_compl,
+				   &xdp_bytes_compl);
 
 		++tx_queue->read_count;
 	}
@@ -153,7 +155,9 @@ void efx_dequeue_buffer(struct efx_tx_queue *tx_queue,
 			struct efx_tx_buffer *buffer,
 			unsigned int *pkts_compl,
 			unsigned int *bytes_compl,
-			unsigned int *efv_pkts_compl)
+			unsigned int *efv_pkts_compl,
+			unsigned int *xdp_pkts,
+			unsigned int *xdp_bytes)
 {
 	if (buffer->unmap_len) {
 		struct device *dma_dev = &tx_queue->efx->pci_dev->dev;
@@ -198,6 +202,10 @@ void efx_dequeue_buffer(struct efx_tx_queue *tx_queue,
 			   tx_queue->queue, tx_queue->read_count);
 	} else if (buffer->flags & EFX_TX_BUF_XDP) {
 		xdp_return_frame_rx_napi(buffer->xdpf);
+		if (xdp_pkts)
+			(*xdp_pkts)++;
+		if (xdp_bytes)
+			(*xdp_bytes) += buffer->xdpf->len;
 	}
 
 	buffer->len = 0;
@@ -213,7 +221,9 @@ static void efx_dequeue_buffers(struct efx_tx_queue *tx_queue,
 				unsigned int index,
 				unsigned int *pkts_compl,
 				unsigned int *bytes_compl,
-				unsigned int *efv_pkts_compl)
+				unsigned int *efv_pkts_compl,
+				unsigned int *xdp_pkts,
+				unsigned int *xdp_bytes)
 {
 	struct efx_nic *efx = tx_queue->efx;
 	unsigned int stop_index, read_ptr;
@@ -233,7 +243,7 @@ static void efx_dequeue_buffers(struct efx_tx_queue *tx_queue,
 		}
 
 		efx_dequeue_buffer(tx_queue, buffer, pkts_compl, bytes_compl,
-				   efv_pkts_compl);
+				   efv_pkts_compl, xdp_pkts, xdp_bytes);
 
 		++tx_queue->read_count;
 		read_ptr = tx_queue->read_count & tx_queue->ptr_mask;
@@ -256,15 +266,18 @@ void efx_xmit_done_check_empty(struct efx_tx_queue *tx_queue)
 int efx_xmit_done(struct efx_tx_queue *tx_queue, unsigned int index)
 {
 	unsigned int fill_level, pkts_compl = 0, bytes_compl = 0;
+	unsigned int xdp_pkts_compl = 0, xdp_bytes_compl = 0;
 	unsigned int efv_pkts_compl = 0;
 	struct efx_nic *efx = tx_queue->efx;
 
 	EFX_WARN_ON_ONCE_PARANOID(index > tx_queue->ptr_mask);
 
 	efx_dequeue_buffers(tx_queue, index, &pkts_compl, &bytes_compl,
-			    &efv_pkts_compl);
+			    &efv_pkts_compl, &xdp_pkts_compl, &xdp_bytes_compl);
 	tx_queue->pkts_compl += pkts_compl;
 	tx_queue->bytes_compl += bytes_compl;
+	tx_queue->complete_xdp_packets += xdp_pkts_compl;
+	tx_queue->complete_xdp_bytes += xdp_bytes_compl;
 
 	if (pkts_compl + efv_pkts_compl > 1)
 		++tx_queue->merge_events;
@@ -293,6 +306,8 @@ int efx_xmit_done(struct efx_tx_queue *tx_queue, unsigned int index)
 void efx_enqueue_unwind(struct efx_tx_queue *tx_queue,
 			unsigned int insert_count)
 {
+	unsigned int xdp_bytes_compl = 0;
+	unsigned int xdp_pkts_compl = 0;
 	unsigned int efv_pkts_compl = 0;
 	struct efx_tx_buffer *buffer;
 	unsigned int bytes_compl = 0;
@@ -303,7 +318,8 @@ void efx_enqueue_unwind(struct efx_tx_queue *tx_queue,
 		--tx_queue->insert_count;
 		buffer = __efx_tx_queue_get_insert_buffer(tx_queue);
 		efx_dequeue_buffer(tx_queue, buffer, &pkts_compl, &bytes_compl,
-				   &efv_pkts_compl);
+				   &efv_pkts_compl, &xdp_pkts_compl,
+				   &xdp_bytes_compl);
 	}
 }
 
diff --git a/drivers/net/ethernet/sfc/tx_common.h b/drivers/net/ethernet/sfc/tx_common.h
index 1e9f42938aac..039eefafba23 100644
--- a/drivers/net/ethernet/sfc/tx_common.h
+++ b/drivers/net/ethernet/sfc/tx_common.h
@@ -20,7 +20,9 @@ void efx_dequeue_buffer(struct efx_tx_queue *tx_queue,
 			struct efx_tx_buffer *buffer,
 			unsigned int *pkts_compl,
 			unsigned int *bytes_compl,
-			unsigned int *efv_pkts_compl);
+			unsigned int *efv_pkts_compl,
+			unsigned int *xdp_pkts,
+			unsigned int *xdp_bytes);
 
 static inline bool efx_tx_buffer_in_use(struct efx_tx_buffer *buffer)
 {


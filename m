Return-Path: <netdev+bounces-128846-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F242597BF0F
	for <lists+netdev@lfdr.de>; Wed, 18 Sep 2024 18:18:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 822691F21955
	for <lists+netdev@lfdr.de>; Wed, 18 Sep 2024 16:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 648031C9DF7;
	Wed, 18 Sep 2024 16:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FfO991tb"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2072.outbound.protection.outlook.com [40.107.94.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3E41C9878
	for <netdev@vger.kernel.org>; Wed, 18 Sep 2024 16:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726676289; cv=fail; b=JUjofXQgL7KmpWL2E8kkWWfsOnWwT4144+Wae+/WTtxbf358qws3BByeH+c/6M5UbYzFfZaMeKUrzWQV7BipCb1oCz7ahJG8gVwGA3Kdsc+9vHSoIDVvUE05G6CHbfFHdTU7rreyctMs8ngVBErSif1/pY10/m10Fjl8aVteIV4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726676289; c=relaxed/simple;
	bh=pPWTYDmixPhRLCHcZ9rpS3Wp2A71AXolnz/p6VSl3NI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ESxdwotVAFa4yxPqq/T5Z+O+mIjHz4B9ArgJacB4g92zm8RoIOY9uxvC3ZLVVh22nFs5+Cx0eyoGfpcbTjy9o3KJmfH2OmZnpWrPT/TFGlKhQhHluTMO1N9Fd14ej/B6P56VwOTse+x2rjVWO0Kxp9hbnLEIvXs2ZmnXNGjM3PQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FfO991tb; arc=fail smtp.client-ip=40.107.94.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lpandi3I2bKnT9M1L8PJ2WNOnMzPP1xHkRtGxbgY7FVpqufcaz6zAvnxH8VxJH1pf1CsbBPfBMaWKtVTGFc7sX88yHuVfP5nyUP6vWU0cLcgr/wTrmrdTVpQGp97xnC1Sa4pha0U0FZ8tXjrOOvSo+/Bgw1n8uNzg/oukcRvyJTQeGCpqk+lu+mRi5y2n2mw6rTlWifumDvVywzpBkqdwqp7UXF6e20StC5n8rVKYXmK0gwLy6Qujw8Ftf9ZOcCO2ETtfgElHi4/WTg675xiZLHfxIrRPPV9ZnLKrNzwRq/5nImo+stNgo7+2H+PTjmoZQJyHs4JxFflxAT8LpS+uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E9gwSEhRQ2tT+qiziVBTJAtitlov9TWKdhaAeJE+2YQ=;
 b=T5yJPMPfOtnX6pYF52Bx6KJRsNghNyBvBipEM45UPxrXFtDdaQ4t6jeMfO1OTs64VjWIb26CPFwtytLX4SxFufDGO3ulLBzQMQlCYlNntFBPjrYh50bvPKZztNTRPRMbGIzZc6D5s6CSr3vJtU5u8bB455KeOilrvwq1crSJM3YDNMuMjB44ZgCl467/G/ZNTZH6aj/KhJcfFWpRv6a2pqNgtyx5K1m3ghIBtZDKMv+pCPSgOQZ1FO5Wbi/ziuOS5KuqgWMAfWc838wEklI0vk8cp7g9uxmkANAsFXJYlocJaMU6bBYhF6LwBG/P9i+rSRZ7zA53Bh2gT67T1YjI+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E9gwSEhRQ2tT+qiziVBTJAtitlov9TWKdhaAeJE+2YQ=;
 b=FfO991tbWVoQioRf8cfGrW7B339ZDokbuAtoR4Gp/q2/F15ZoiBv+TC9TwVQDMfMNzLHNhaD7NRDUaKN/DjMAlOFxk8TwItOj8c7ElSgaJsukR073XySiR8tr2Ftf9K3H8kmdEn/Am5Mr1xkqx7qA+oHCcq1cXeOgTWUTcHfC40=
Received: from MW4PR03CA0122.namprd03.prod.outlook.com (2603:10b6:303:8c::7)
 by CYXPR12MB9428.namprd12.prod.outlook.com (2603:10b6:930:d5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.26; Wed, 18 Sep
 2024 16:18:00 +0000
Received: from CO1PEPF000044FC.namprd21.prod.outlook.com
 (2603:10b6:303:8c:cafe::d5) by MW4PR03CA0122.outlook.office365.com
 (2603:10b6:303:8c::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.26 via Frontend
 Transport; Wed, 18 Sep 2024 16:17:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000044FC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8005.1 via Frontend Transport; Wed, 18 Sep 2024 16:17:59 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 18 Sep
 2024 11:17:58 -0500
Received: from xcbecree42x.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Wed, 18 Sep 2024 11:17:57 -0500
From: <edward.cree@amd.com>
To: <linux-net-drivers@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: Edward Cree <ecree.xilinx@gmail.com>, <netdev@vger.kernel.org>,
	<habetsm.xilinx@gmail.com>, <jacob.e.keller@intel.com>
Subject: [RFC PATCH v3 net-next 4/7] sfc: account XDP TXes in netdev base stats
Date: Wed, 18 Sep 2024 17:14:26 +0100
Message-ID: <0c9c2e2b13aa82de9cedca478a8ee6e8cf22fcc6.1726593633.git.ecree.xilinx@gmail.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FC:EE_|CYXPR12MB9428:EE_
X-MS-Office365-Filtering-Correlation-Id: a2853d6b-4023-4d03-225a-08dcd7fd76af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?r/TccHaHDtGPLD6HG3EUxv73LMOqrQ2aG1Ak+sFBk5msbt5Cf+hdDjPyyHAp?=
 =?us-ascii?Q?3LhvONhS/jrKuF/biST2TPYhkzXaX/KLtFZtrSGQ+1FEl1sbaJSXS1lY352U?=
 =?us-ascii?Q?B+/nRiQxh2mlJNdslj4P1ltFW0xMtsaWK4iacaEvxyTXhVHFKJ7vZrEn9pko?=
 =?us-ascii?Q?Gbmqk1LYhP2Hc55RRFITqcoNEIUwsluBhyh+qSpHoxWuqKaw5kHnPrlK7NYn?=
 =?us-ascii?Q?avS9Xgv9pKqLtJKpv2oGzKE5PUMJr7wM9oNJlYA5vwVgRwUuw70Ap48kc5QC?=
 =?us-ascii?Q?TA5rt8iR/JRFqkxYMs9nTe7PPe5+YwzhcnZADS2ApRBoQwgRCi/2USqukXh1?=
 =?us-ascii?Q?53oiNy2iIBbQ544DnwoVxYqCQi/0bOrE1LxRz+/EWNdFEffu11a/aaMX9nRT?=
 =?us-ascii?Q?+RgsIcrWr+oNgYgsLjKk3EkCAjKIlsAgtfpthVjwxQs5B/ullbk7nnIvQ8ip?=
 =?us-ascii?Q?R+/CNndunLHEFskMKQbBrY6Vzt0gUaF75g1zCEu+A6f6J5fmnab6GzrgAEuD?=
 =?us-ascii?Q?/DJSMGm3czWGcwWjUb7Z+A5EAqj6f2i1G3fpOHYZ/N68aj3QMrPmqraR2kd5?=
 =?us-ascii?Q?fRRlfw0FHvxMYbmnpZTEqMrSin54LqycBXosvJrrTY51yzO7Cp95vEXAqnj8?=
 =?us-ascii?Q?ZqcX4TG8XSYMQHLUUeBns2yON6tU8IWx/QWDXuNbK2ZZCw9hiURxpfMUGi6j?=
 =?us-ascii?Q?BC8hGbWNt3RjqAh6PT8PC7RmNFjSPPrqIiuEERJzlDnFhwpL4rDm4rVdHgUD?=
 =?us-ascii?Q?KmcgoEUKrcyEntbsatqL5ZOgmma252zzjmh4F5gDjRExdkXaY7V3bV82pqNo?=
 =?us-ascii?Q?dPKszJS082VRIAB7IHwI/KJGTIWKKGHuZVyPDk3yeYPCsQu2zTJtXywfXdrr?=
 =?us-ascii?Q?+RQWGte5IyNpA9G32keN2FYwwucf/AwxVgG5Df/l3ELH/LIedctsvpWA0+Ly?=
 =?us-ascii?Q?5bZpxleQS1mrkXAVtlpSjM2u2pTdICVqShuEv+Bs2OunVBxyFVSpkv2UVqDh?=
 =?us-ascii?Q?njFVUyUmlHCp6Cdqst1fVwd+Wkil0EG7DT1DJyg/S/mpsWKbS2Iz+cpbfF9T?=
 =?us-ascii?Q?kxrwa8AZB57Wkaoxvnkhfr5RLmAG5mtWNR9XrYw00I9pwIze/GYMiTlgdq6R?=
 =?us-ascii?Q?XS9sThV1lObhFPZJ5R0ix+L8UTKlNJbyZuQvfkNwT39xxww0FnRww1rLFX0O?=
 =?us-ascii?Q?m+ufVE+dI1bCPpEhAWdS2MqxqQMGGZHgX2IWwSUpxelSGNWMAy116U0oNoWs?=
 =?us-ascii?Q?OEadO97iy3q8CbE8lnqxrC/PNATB8U+EVTZDukkUsJNaK53uBv4+AAz1Hp7I?=
 =?us-ascii?Q?6zhkIPHI16NMpzMM4H3UkHI4e7EWRv+eP7GYB6ucu05VqmoOGWP61Bh8xosN?=
 =?us-ascii?Q?NHIXZt5nYmdZ9AfqZaEVbktxseR6D2KQ8RE984DdpvKa4bUmmeOFFVQ79jG9?=
 =?us-ascii?Q?uu2i/TaS9iZK54IPE2NuNuIHc80mUAu+?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2024 16:17:59.6092
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2853d6b-4023-4d03-225a-08dcd7fd76af
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044FC.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9428

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


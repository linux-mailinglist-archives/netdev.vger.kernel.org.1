Return-Path: <netdev+bounces-76311-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B243086D367
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 20:41:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6C8B1C22037
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 19:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A9CD142903;
	Thu, 29 Feb 2024 19:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aWIlHVk0"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2065.outbound.protection.outlook.com [40.107.223.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84DE313F43A
	for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 19:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709235625; cv=fail; b=DWJxmkHfFl7CMOgMD/pdTBzUHJfyBbY4w/8r3/YrxbU5ho621nVDb+Ku+5+suGiJjIJvufhAKUT9IXSO/7Ef06llx0SHqXhR+OD+eN65t7o1VVOKb46O2k4Q9z3awJ7+/GhG2vkEKUWseH+FpUNz65sg+fbMfYsYLtPRv8r6nvw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709235625; c=relaxed/simple;
	bh=hlLzD6bRjziNYtJ1Z0P4PZXo9T7SWcVfPYO1QHX0nlw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pvihr58WOeO6bLNS3OEI4o5aaauc5cBqFSM7lpMKlRSe/9OqJ7xVgzviS3TaMuvQPve16/Io80wW0Zs9msFr4SS70JIlf5Q+bBEOgGbrlimLv/2BM7ZGHYtONOSfABdB+afLGn7WvTk1vG4yhqhxikAeLlGHHARKbBjJ7aZCBIk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=aWIlHVk0; arc=fail smtp.client-ip=40.107.223.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V48dJM+aqOWvrRFEwyBUn6/+KqHwTG5A/cQcXEU+8ON3fNsmO7kSepGAmICR7NLUSAS9r6AAxypki/9B1kRZQaBNmLLjiE9xaSgwBzPW7bN/afHfqXp+UAT4WLbM8ffqnXdLWwH98hdGPw5Z7Ge8VwPhAWkiY4IbMPI0Mgs3/7OQ85ZgtUkdSZui65QjORuJmuxwcwjYTBXbHYFYtPW5QA8Mt9Z2ensYarUuq4C64sUgbfae7jTS8CBnqOMMsu/Vd61bhFBxJ+Hi3FhXujDThk8GZsIv21dvZDQwPhXLO+5xjfpB3LI8lQKjky02dTAh88khVZF7q0Kyy7u+BZaU9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N8efVALvVZPtjUmuD2XPhBpiEUUUrvoKpmQsHikzAh0=;
 b=NhBXhDBbAcxt8zpj4CSO+F2G9RK7ThGZGr0/uU1niVR7Jryuscql5t/YGQMgHWv5TEsMZPzBKKuLNXbXwEkIU+SnXkr56rm36Q5YZPJQlXG/YLjRLBkO3WgROixSZsHXG3MsX4uubTCPkqQkhZoyPXUyaK7FD8gVSiKZUxH8cxfOShzJvRv8KRT781WQ2obXM1FyCjy4SbW+HgN4DHd5u7TMG+1jN8BLBhOKlanJh3P92u6TO9OnkxQZwQ/B5Ld1NXo7cto/Ej+5Td4hSm+n1I78veLyJJRxWHTVkf2VSxrHJi2vi+kAN+y5YyQv9odqEXTfWxVMVTh7HOGbjSaWlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N8efVALvVZPtjUmuD2XPhBpiEUUUrvoKpmQsHikzAh0=;
 b=aWIlHVk0a6tQR8QoE9zEJmoiZZnQtiCYFTTcFbM3T67k+MRLMetQ8gbj3uT+PkeWI6sQ+Y3fms7x/l8gOl7lh7vLfHW/+AOecHxlDHSH0jTiBqAWhH6yeJoDyLXKejPCKSd7qWM84rd496GPzNOURePOfPCdMKbbLgND7m9yo04=
Received: from BLAPR03CA0152.namprd03.prod.outlook.com (2603:10b6:208:32f::16)
 by CY8PR12MB7416.namprd12.prod.outlook.com (2603:10b6:930:5c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Thu, 29 Feb
 2024 19:40:17 +0000
Received: from BL02EPF0001A102.namprd05.prod.outlook.com
 (2603:10b6:208:32f:cafe::1e) by BLAPR03CA0152.outlook.office365.com
 (2603:10b6:208:32f::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.28 via Frontend
 Transport; Thu, 29 Feb 2024 19:40:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A102.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Thu, 29 Feb 2024 19:40:16 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 29 Feb
 2024 13:40:13 -0600
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH net-next 07/12] ionic: Pass local netdev instead of referencing struct
Date: Thu, 29 Feb 2024 11:39:30 -0800
Message-ID: <20240229193935.14197-8-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240229193935.14197-1-shannon.nelson@amd.com>
References: <20240229193935.14197-1-shannon.nelson@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A102:EE_|CY8PR12MB7416:EE_
X-MS-Office365-Filtering-Correlation-Id: c05d8d10-c7cd-400c-d9ed-08dc395e415d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ApyHz4eSxDTPk+X/ue6HR3J2CMAmDsQzDBX31PeeM+G9nCpJf6ZHIEJSNPpmTwz2BKc3HONp/9A/TqqzHX6U0eGpxj0OxKqDHqTO3qjLmVCocYi85fOC76BjzLK+j5k0Aqno5ZoMFh50Ov+Omlitpvtv0ziP3q3QUvLS+RbQvmCe/LA6DVPSI3NsRo1LMJXDCrlYH2CnMgJ3dFk+rvMkGjfN9/DfTceQT5bqWLX13iyRFkxuoxh5QTWuRDT6F3/9gWQfiQr1JvXhyUVurw2kNfZiFrVR3giViEt4N7hmdCFj0cMb97vwu0aUfq+6be+jp+W4a3CawZoqlYmZ2UCoKU+9p85XjmJTthPjowIGwdZGMJ/mZ1hLDoxLkJvzA4lRfhERknd/iF1BfkJXvlQokShjW8QBU+GyWgOXoNssVq6hQWXGFuYgzaTH7hWZ2wdH6woRd43ahIOSWfXgsDzyD5jdXifOcPHUBiRUWl1X8Rkc0/IQKW0RAhB1sVyvZ+hBVa4QpzsiET8YFQBqT0CTPXuS2h9V/iEpeGNwNcHwL4xu1UjFBG9QStHzuHgw13I9GdyhAAG7DHUosvQZjrj+1u/lEKK6wFJydI5HPFrqnQlakvj3F2m4a5co2TOCjlqtmQt03ogSH7fSFMk/5+TRmi5fTZLdECsvMDJkpRvEpgzxvMBCgDZmpsXRUwHkk3vOm6nxAR0T4ECyN2zEGA83igm+xyZX8K/hr8w5gzd9MYmwgJ26+vEP6o1o/WEa6CMd
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Feb 2024 19:40:16.5521
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c05d8d10-c7cd-400c-d9ed-08dc395e415d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A102.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7416

From: Brett Creeley <brett.creeley@amd.com>

Instead of using q->lif->netdev, just pass the netdev when it's
locally defined.

Signed-off-by: Brett Creeley <brett.creeley@amd.com>
Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 .../net/ethernet/pensando/ionic/ionic_txrx.c  | 66 ++++++++++---------
 1 file changed, 36 insertions(+), 30 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
index d9e23fc78e6b..f217b9875f1b 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
@@ -99,9 +99,10 @@ bool ionic_rxq_poke_doorbell(struct ionic_queue *q)
 	return true;
 }
 
-static inline struct netdev_queue *q_to_ndq(struct ionic_queue *q)
+static inline struct netdev_queue *q_to_ndq(struct net_device *netdev,
+					    struct ionic_queue *q)
 {
-	return netdev_get_tx_queue(q->lif->netdev, q->index);
+	return netdev_get_tx_queue(netdev, q->index);
 }
 
 static void *ionic_rx_buf_va(struct ionic_buf_info *buf_info)
@@ -203,14 +204,14 @@ static bool ionic_rx_buf_recycle(struct ionic_queue *q,
 	return true;
 }
 
-static struct sk_buff *ionic_rx_frags(struct ionic_queue *q,
+static struct sk_buff *ionic_rx_frags(struct net_device *netdev,
+				      struct ionic_queue *q,
 				      struct ionic_desc_info *desc_info,
 				      unsigned int headroom,
 				      unsigned int len,
 				      unsigned int num_sg_elems,
 				      bool synced)
 {
-	struct net_device *netdev = q->lif->netdev;
 	struct ionic_buf_info *buf_info;
 	struct ionic_rx_stats *stats;
 	struct device *dev = q->dev;
@@ -271,13 +272,13 @@ static struct sk_buff *ionic_rx_frags(struct ionic_queue *q,
 	return skb;
 }
 
-static struct sk_buff *ionic_rx_copybreak(struct ionic_queue *q,
+static struct sk_buff *ionic_rx_copybreak(struct net_device *netdev,
+					  struct ionic_queue *q,
 					  struct ionic_desc_info *desc_info,
 					  unsigned int headroom,
 					  unsigned int len,
 					  bool synced)
 {
-	struct net_device *netdev = q->lif->netdev;
 	struct ionic_buf_info *buf_info;
 	struct ionic_rx_stats *stats;
 	struct device *dev = q->dev;
@@ -308,7 +309,7 @@ static struct sk_buff *ionic_rx_copybreak(struct ionic_queue *q,
 					 headroom, len, DMA_FROM_DEVICE);
 
 	skb_put(skb, len);
-	skb->protocol = eth_type_trans(skb, q->lif->netdev);
+	skb->protocol = eth_type_trans(skb, netdev);
 
 	return skb;
 }
@@ -348,8 +349,7 @@ static void ionic_xdp_tx_desc_clean(struct ionic_queue *q,
 	desc_info->act = 0;
 }
 
-static int ionic_xdp_post_frame(struct net_device *netdev,
-				struct ionic_queue *q, struct xdp_frame *frame,
+static int ionic_xdp_post_frame(struct ionic_queue *q, struct xdp_frame *frame,
 				enum xdp_action act, struct page *page, int off,
 				bool ring_doorbell)
 {
@@ -457,7 +457,7 @@ int ionic_xdp_xmit(struct net_device *netdev, int n,
 	txq_trans_cond_update(nq);
 
 	if (netif_tx_queue_stopped(nq) ||
-	    !netif_txq_maybe_stop(q_to_ndq(txq),
+	    !netif_txq_maybe_stop(q_to_ndq(netdev, txq),
 				  ionic_q_space_avail(txq),
 				  1, 1)) {
 		__netif_tx_unlock(nq);
@@ -466,7 +466,7 @@ int ionic_xdp_xmit(struct net_device *netdev, int n,
 
 	space = min_t(int, n, ionic_q_space_avail(txq));
 	for (nxmit = 0; nxmit < space ; nxmit++) {
-		if (ionic_xdp_post_frame(netdev, txq, xdp_frames[nxmit],
+		if (ionic_xdp_post_frame(txq, xdp_frames[nxmit],
 					 XDP_REDIRECT,
 					 virt_to_page(xdp_frames[nxmit]->data),
 					 0, false)) {
@@ -479,7 +479,7 @@ int ionic_xdp_xmit(struct net_device *netdev, int n,
 		ionic_dbell_ring(lif->kern_dbpage, txq->hw_type,
 				 txq->dbval | txq->head_idx);
 
-	netif_txq_maybe_stop(q_to_ndq(txq),
+	netif_txq_maybe_stop(q_to_ndq(netdev, txq),
 			     ionic_q_space_avail(txq),
 			     4, 4);
 	__netif_tx_unlock(nq);
@@ -574,7 +574,7 @@ static bool ionic_run_xdp(struct ionic_rx_stats *stats,
 		txq_trans_cond_update(nq);
 
 		if (netif_tx_queue_stopped(nq) ||
-		    !netif_txq_maybe_stop(q_to_ndq(txq),
+		    !netif_txq_maybe_stop(q_to_ndq(netdev, txq),
 					  ionic_q_space_avail(txq),
 					  1, 1)) {
 			__netif_tx_unlock(nq);
@@ -584,7 +584,7 @@ static bool ionic_run_xdp(struct ionic_rx_stats *stats,
 		dma_unmap_page(rxq->dev, buf_info->dma_addr,
 			       IONIC_PAGE_SIZE, DMA_FROM_DEVICE);
 
-		err = ionic_xdp_post_frame(netdev, txq, xdpf, XDP_TX,
+		err = ionic_xdp_post_frame(txq, xdpf, XDP_TX,
 					   buf_info->page,
 					   buf_info->page_offset,
 					   true);
@@ -662,9 +662,10 @@ static void ionic_rx_clean(struct ionic_queue *q,
 
 	headroom = q->xdp_rxq_info ? XDP_PACKET_HEADROOM : 0;
 	if (len <= q->lif->rx_copybreak)
-		skb = ionic_rx_copybreak(q, desc_info, headroom, len, !!xdp_prog);
+		skb = ionic_rx_copybreak(netdev, q, desc_info,
+					 headroom, len, !!xdp_prog);
 	else
-		skb = ionic_rx_frags(q, desc_info, headroom, len,
+		skb = ionic_rx_frags(netdev, q, desc_info, headroom, len,
 				     comp->num_sg_elems, !!xdp_prog);
 
 	if (unlikely(!skb)) {
@@ -1298,7 +1299,8 @@ unsigned int ionic_tx_cq_service(struct ionic_cq *cq, unsigned int work_to_do)
 		struct ionic_queue *q = cq->bound_q;
 
 		if (!ionic_txq_hwstamp_enabled(q))
-			netif_txq_completed_wake(q_to_ndq(q), pkts, bytes,
+			netif_txq_completed_wake(q_to_ndq(q->lif->netdev, q),
+						 pkts, bytes,
 						 ionic_q_space_avail(q),
 						 IONIC_TSO_DESCS_NEEDED);
 	}
@@ -1338,8 +1340,10 @@ void ionic_tx_empty(struct ionic_queue *q)
 	}
 
 	if (!ionic_txq_hwstamp_enabled(q)) {
-		netdev_tx_completed_queue(q_to_ndq(q), pkts, bytes);
-		netdev_tx_reset_queue(q_to_ndq(q));
+		struct netdev_queue *ndq = q_to_ndq(q->lif->netdev, q);
+
+		netdev_tx_completed_queue(ndq, pkts, bytes);
+		netdev_tx_reset_queue(ndq);
 	}
 }
 
@@ -1388,7 +1392,7 @@ static int ionic_tx_tcp_pseudo_csum(struct sk_buff *skb)
 	return 0;
 }
 
-static void ionic_tx_tso_post(struct ionic_queue *q,
+static void ionic_tx_tso_post(struct net_device *netdev, struct ionic_queue *q,
 			      struct ionic_desc_info *desc_info,
 			      struct sk_buff *skb,
 			      dma_addr_t addr, u8 nsge, u16 len,
@@ -1418,14 +1422,15 @@ static void ionic_tx_tso_post(struct ionic_queue *q,
 	if (start) {
 		skb_tx_timestamp(skb);
 		if (!ionic_txq_hwstamp_enabled(q))
-			netdev_tx_sent_queue(q_to_ndq(q), skb->len);
+			netdev_tx_sent_queue(q_to_ndq(netdev, q), skb->len);
 		ionic_txq_post(q, false, ionic_tx_clean, skb);
 	} else {
 		ionic_txq_post(q, done, NULL, NULL);
 	}
 }
 
-static int ionic_tx_tso(struct ionic_queue *q, struct sk_buff *skb)
+static int ionic_tx_tso(struct net_device *netdev, struct ionic_queue *q,
+			struct sk_buff *skb)
 {
 	struct ionic_tx_stats *stats = q_to_tx_stats(q);
 	struct ionic_desc_info *desc_info;
@@ -1533,7 +1538,7 @@ static int ionic_tx_tso(struct ionic_queue *q, struct sk_buff *skb)
 		seg_rem = min(tso_rem, mss);
 		done = (tso_rem == 0);
 		/* post descriptor */
-		ionic_tx_tso_post(q, desc_info, skb,
+		ionic_tx_tso_post(netdev, q, desc_info, skb,
 				  desc_addr, desc_nsge, desc_len,
 				  hdrlen, mss, outer_csum, vlan_tci, has_vlan,
 				  start, done);
@@ -1643,7 +1648,8 @@ static void ionic_tx_skb_frags(struct ionic_queue *q, struct sk_buff *skb,
 	stats->frags += skb_shinfo(skb)->nr_frags;
 }
 
-static int ionic_tx(struct ionic_queue *q, struct sk_buff *skb)
+static int ionic_tx(struct net_device *netdev, struct ionic_queue *q,
+		    struct sk_buff *skb)
 {
 	struct ionic_desc_info *desc_info = &q->info[q->head_idx];
 	struct ionic_tx_stats *stats = q_to_tx_stats(q);
@@ -1666,7 +1672,7 @@ static int ionic_tx(struct ionic_queue *q, struct sk_buff *skb)
 	stats->bytes += skb->len;
 
 	if (!ionic_txq_hwstamp_enabled(q)) {
-		struct netdev_queue *ndq = q_to_ndq(q);
+		struct netdev_queue *ndq = q_to_ndq(netdev, q);
 
 		if (unlikely(!ionic_q_has_space(q, MAX_SKB_FRAGS + 1)))
 			netif_tx_stop_queue(ndq);
@@ -1789,9 +1795,9 @@ static netdev_tx_t ionic_start_hwstamp_xmit(struct sk_buff *skb,
 
 	skb_shinfo(skb)->tx_flags |= SKBTX_HW_TSTAMP;
 	if (skb_is_gso(skb))
-		err = ionic_tx_tso(q, skb);
+		err = ionic_tx_tso(netdev, q, skb);
 	else
-		err = ionic_tx(q, skb);
+		err = ionic_tx(netdev, q, skb);
 
 	if (err)
 		goto err_out_drop;
@@ -1829,15 +1835,15 @@ netdev_tx_t ionic_start_xmit(struct sk_buff *skb, struct net_device *netdev)
 	if (ndescs < 0)
 		goto err_out_drop;
 
-	if (!netif_txq_maybe_stop(q_to_ndq(q),
+	if (!netif_txq_maybe_stop(q_to_ndq(netdev, q),
 				  ionic_q_space_avail(q),
 				  ndescs, ndescs))
 		return NETDEV_TX_BUSY;
 
 	if (skb_is_gso(skb))
-		err = ionic_tx_tso(q, skb);
+		err = ionic_tx_tso(netdev, q, skb);
 	else
-		err = ionic_tx(q, skb);
+		err = ionic_tx(netdev, q, skb);
 
 	if (err)
 		goto err_out_drop;
-- 
2.17.1



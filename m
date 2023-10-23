Return-Path: <netdev+bounces-43460-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D8CB87D351F
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 13:45:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3ED7CB20C97
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 11:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 996C216409;
	Mon, 23 Oct 2023 11:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="jhEo4Mmv"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE3F18021
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 11:45:27 +0000 (UTC)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52F23170D;
	Mon, 23 Oct 2023 04:45:22 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39MN00Pe002349;
	Mon, 23 Oct 2023 04:45:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=pfpt0220;
 bh=loQIiydTkdc8jp4yYaQACpRwZcT5vkJLwSIJdUcrjkQ=;
 b=jhEo4MmvTiywViOf0Grv3kKPp24L4TuaQHe+VxkMr+PVnevN4ryxr+3Gr5aCGFs3cy/9
 51uvrheWepNG7Ko2jQDmgjfdEkMgXpQoTf6Kyrybq/Nuc49GiZIcju9A44p5HvEZAxMt
 Ffyosqw8pErICuhDB6qNb8E7AtGEs/yblRDr83x/rN3S216l6/hd9yUJQzSUBUcFLVzP
 6KL9Sl7mXyQShaGiRvTJEmDR0jXdW7jlJe+nKqePQzR7Eq0Uo1kmfG0yQiDAEhwKzTeV
 mouY/QLVwA3RlE8P0ppAqHPZYvY56nR6K46HvHglUO3kGW3Klxp0no0iLW3NAKGWlMMa 4Q== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3tvc0qp11b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Mon, 23 Oct 2023 04:45:11 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 23 Oct
 2023 04:45:09 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Mon, 23 Oct 2023 04:45:09 -0700
Received: from ubuntu-PowerEdge-T110-II.sclab.marvell.com (unknown [10.106.27.86])
	by maili.marvell.com (Postfix) with ESMTP id 662523F70BE;
	Mon, 23 Oct 2023 04:45:09 -0700 (PDT)
From: Shinas Rasheed <srasheed@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <hgani@marvell.com>, <vimleshk@marvell.com>, <egallen@redhat.com>,
        <mschmidt@redhat.com>, <pabeni@redhat.com>, <horms@kernel.org>,
        <kuba@kernel.org>, <davem@davemloft.net>,
        Shinas Rasheed
	<srasheed@marvell.com>,
        Veerasenareddy Burru <vburru@marvell.com>,
        "Sathesh
 Edara" <sedara@marvell.com>,
        Eric Dumazet <edumazet@google.com>
Subject: [PATCH net-next 3/3] octeon_ep: remove atomic variable usage in Tx data path
Date: Mon, 23 Oct 2023 04:44:48 -0700
Message-ID: <20231023114449.2362147-4-srasheed@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231023114449.2362147-1-srasheed@marvell.com>
References: <20231023114449.2362147-1-srasheed@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: M0Cs4mk1VzQkZHSPOTPWdRxhXnaJ5QJ7
X-Proofpoint-GUID: M0Cs4mk1VzQkZHSPOTPWdRxhXnaJ5QJ7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-23_10,2023-10-19_01,2023-05-22_02

Replace atomic variable "instr_pending" which represents number of
posted tx instructions pending completion, with host_write_idx and
flush_index variables in the xmit and completion processing respectively.

Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
---
 drivers/net/ethernet/marvell/octeon_ep/octep_config.h |  1 +
 drivers/net/ethernet/marvell/octeon_ep/octep_main.c   | 11 ++++-------
 drivers/net/ethernet/marvell/octeon_ep/octep_main.h   |  9 +++++++++
 drivers/net/ethernet/marvell/octeon_ep/octep_tx.c     |  5 +----
 drivers/net/ethernet/marvell/octeon_ep/octep_tx.h     |  3 ---
 5 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_config.h b/drivers/net/ethernet/marvell/octeon_ep/octep_config.h
index ed8b1ace56b9..91cfa19c65b9 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_config.h
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_config.h
@@ -13,6 +13,7 @@
 #define OCTEP_64BYTE_INSTR  64
 
 /* Tx Queue: maximum descriptors per ring */
+/* This needs to be a power of 2 */
 #define OCTEP_IQ_MAX_DESCRIPTORS    1024
 /* Minimum input (Tx) requests to be enqueued to ring doorbell */
 #define OCTEP_DB_MIN                8
diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
index 730443ba2f5b..d7498a864385 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
@@ -777,7 +777,7 @@ static int octep_stop(struct net_device *netdev)
  */
 static inline int octep_iq_full_check(struct octep_iq *iq)
 {
-	if (likely((iq->max_count - atomic_read(&iq->instr_pending)) >=
+	if (likely((IQ_INSTR_SPACE(iq)) >
 		   OCTEP_WAKE_QUEUE_THRESHOLD))
 		return 0;
 
@@ -787,7 +787,7 @@ static inline int octep_iq_full_check(struct octep_iq *iq)
 	/* check again and restart the queue, in case NAPI has just freed
 	 * enough Tx ring entries.
 	 */
-	if (unlikely((iq->max_count - atomic_read(&iq->instr_pending)) >=
+	if (unlikely(IQ_INSTR_SPACE(iq) >
 		     OCTEP_WAKE_QUEUE_THRESHOLD)) {
 		netif_start_subqueue(iq->netdev, iq->q_no);
 		iq->stats.restart_cnt++;
@@ -897,14 +897,11 @@ static netdev_tx_t octep_start_xmit(struct sk_buff *skb,
 	xmit_more = netdev_xmit_more();
 
 	skb_tx_timestamp(skb);
-	atomic_inc(&iq->instr_pending);
 	iq->fill_cnt++;
 	wi++;
-	if (wi == iq->max_count)
-		wi = 0;
-	iq->host_write_index = wi;
+	iq->host_write_index = wi & iq->ring_size_mask;
 	if (xmit_more &&
-	    (atomic_read(&iq->instr_pending) <
+	    (IQ_INSTR_PENDING(iq) <
 	     (iq->max_count - OCTEP_WAKE_QUEUE_THRESHOLD)) &&
 	    iq->fill_cnt < iq->fill_threshold)
 		return NETDEV_TX_OK;
diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_main.h b/drivers/net/ethernet/marvell/octeon_ep/octep_main.h
index 6df902ebb7f3..c33e046b69a4 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_main.h
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_main.h
@@ -40,6 +40,15 @@
 #define  OCTEP_OQ_INTR_RESEND_BIT  59
 
 #define  OCTEP_MMIO_REGIONS     3
+
+#define  IQ_INSTR_PENDING(iq)  ({ typeof(iq) iq__ = (iq); \
+				  ((iq__)->host_write_index - (iq__)->flush_index) & \
+				  (iq__)->ring_size_mask; \
+				})
+#define  IQ_INSTR_SPACE(iq)    ({ typeof(iq) iq_ = (iq); \
+				  (iq_)->max_count - IQ_INSTR_PENDING(iq_); \
+				})
+
 /* PCI address space mapping information.
  * Each of the 3 address spaces given by BAR0, BAR2 and BAR4 of
  * Octeon gets mapped to different physical address spaces in
diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_tx.c b/drivers/net/ethernet/marvell/octeon_ep/octep_tx.c
index d0adb82d65c3..06851b78aa28 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_tx.c
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_tx.c
@@ -21,7 +21,6 @@ static void octep_iq_reset_indices(struct octep_iq *iq)
 	iq->flush_index = 0;
 	iq->pkts_processed = 0;
 	iq->pkt_in_done = 0;
-	atomic_set(&iq->instr_pending, 0);
 }
 
 /**
@@ -82,7 +81,6 @@ int octep_iq_process_completions(struct octep_iq *iq, u16 budget)
 	}
 
 	iq->pkts_processed += compl_pkts;
-	atomic_sub(compl_pkts, &iq->instr_pending);
 	iq->stats.instr_completed += compl_pkts;
 	iq->stats.bytes_sent += compl_bytes;
 	iq->stats.sgentry_sent += compl_sg;
@@ -91,7 +89,7 @@ int octep_iq_process_completions(struct octep_iq *iq, u16 budget)
 	netdev_tx_completed_queue(iq->netdev_q, compl_pkts, compl_bytes);
 
 	if (unlikely(__netif_subqueue_stopped(iq->netdev, iq->q_no)) &&
-	    ((iq->max_count - atomic_read(&iq->instr_pending)) >
+	    (IQ_INSTR_SPACE(iq) >
 	     OCTEP_WAKE_QUEUE_THRESHOLD))
 		netif_wake_subqueue(iq->netdev, iq->q_no);
 	return !budget;
@@ -144,7 +142,6 @@ static void octep_iq_free_pending(struct octep_iq *iq)
 		dev_kfree_skb_any(skb);
 	}
 
-	atomic_set(&iq->instr_pending, 0);
 	iq->flush_index = fi;
 	netdev_tx_reset_queue(netdev_get_tx_queue(iq->netdev, iq->q_no));
 }
diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_tx.h b/drivers/net/ethernet/marvell/octeon_ep/octep_tx.h
index 86c98b13fc44..1ba4ff65e54d 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_tx.h
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_tx.h
@@ -172,9 +172,6 @@ struct octep_iq {
 	/* Statistics for this input queue. */
 	struct octep_iq_stats stats;
 
-	/* This field keeps track of the instructions pending in this queue. */
-	atomic_t instr_pending;
-
 	/* Pointer to the Virtual Base addr of the input ring. */
 	struct octep_tx_desc_hw *desc_ring;
 
-- 
2.25.1



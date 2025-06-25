Return-Path: <netdev+bounces-201235-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 512AEAE8925
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 18:05:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D03D16589F
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 16:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AC642882BC;
	Wed, 25 Jun 2025 16:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cgJZ//e8"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556CE2C1780
	for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 16:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750867488; cv=none; b=j8S5UUzldAx1zt3HFIpIrArH3JhxHFQlJZ4BuBNbBx57yQKxImHk9EvN5dB54Uxq7apaNZNIjqjAsx/qr4v5TI3qjdwYC2qWrXvdxefqIwuHaumzAHiQy7UoUol6COwD2sX80cfi30lktBFoOz3DRvva5411SdJLgqRRd3dorAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750867488; c=relaxed/simple;
	bh=Zd+VLAsrrcR1tPOdnniati56UycANJqUzVA7B/Jeq2E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fxiu/k0PDbCWx0/eNEPcV3SotmKn2puwcJJXlb0HmxcPMyqXS31l3JRxY3yU4dAOqX1iOCSDmk07Rh5SRox/bMljTvYBEawEvRbMnYLSuQqionHdyYgzQXG7o/FNLIYnAD9JTQxdWsJpZIA+lJFMzdy1fdq+5NJ3plDmuW/Fu4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cgJZ//e8; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750867486; x=1782403486;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Zd+VLAsrrcR1tPOdnniati56UycANJqUzVA7B/Jeq2E=;
  b=cgJZ//e8ZG+aOkGZmwBqbwA6qxnIFT8Laqmg+7ZbmWrQ/PYtj/ladpxb
   OYbKOAObs3xsjKpH1LJ+p0jJfnRvDFePi00YnPRBfNdbvkjcc9MMyd7dU
   dIwTFriCMVVFMc5mr6VW5gCkwG4B0WV97X5UaH3vU///094nFnFcR58ck
   +pk1V3pHDaTijhr0YmgWhPe79mrhMPLdr9YoE7ZnD9TYs8jbI1Ve9AAGT
   FRjP3YX4DACnLcTgkz9UCZAkbVDE60/F8BSUgD4KYwvlJHMfivg77YUDq
   C/b88m0hoSudWl4M4EzH0vFgITT2jLJvv7cGX7C+gaiL8Xnt4ftn6PMwi
   A==;
X-CSE-ConnectionGUID: AbH2drRqSCGajLqg1glWpw==
X-CSE-MsgGUID: w4bUME9HSv+IP+m80UoVKQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11475"; a="70714955"
X-IronPort-AV: E=Sophos;i="6.16,265,1744095600"; 
   d="scan'208";a="70714955"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2025 09:04:44 -0700
X-CSE-ConnectionGUID: e16QpDVLTwWcc/7E9GKclg==
X-CSE-MsgGUID: /tvgSbwTQYKYBeUNa13KMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,265,1744095600"; 
   d="scan'208";a="157752636"
Received: from dcskidmo-m40.jf.intel.com ([10.166.241.13])
  by fmviesa004.fm.intel.com with ESMTP; 25 Jun 2025 09:04:45 -0700
From: Joshua Hay <joshua.a.hay@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Joshua Hay <joshua.a.hay@intel.com>,
	Madhu Chittim <madhu.chittim@intel.com>
Subject: [Intel-wired-lan] [PATCH net 4/5] idpf: stop Tx if there are insufficient buffer resources
Date: Wed, 25 Jun 2025 09:11:55 -0700
Message-Id: <20250625161156.338777-5-joshua.a.hay@intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250625161156.338777-1-joshua.a.hay@intel.com>
References: <20250625161156.338777-1-joshua.a.hay@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Tx refillq logic will cause packets to be silently dropped if there
are not enough buffer resources available to send a packet in flow
scheduling mode. Instead, determine how many buffers are needed along
with number of descriptors. Make sure there are enough of both resources
to send the packet, and stop the queue if not.

Fixes: 7292af042bcf ("idpf: fix a race in txq wakeup")
Signed-off-by: Joshua Hay <joshua.a.hay@intel.com>
Reviewed-by: Madhu Chittim <madhu.chittim@intel.com>
---
 .../ethernet/intel/idpf/idpf_singleq_txrx.c   |  4 +-
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   | 51 +++++++++++++------
 drivers/net/ethernet/intel/idpf/idpf_txrx.h   |  9 +++-
 3 files changed, 44 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c
index 4c1d7235a073..d8216bb13019 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c
@@ -361,12 +361,12 @@ netdev_tx_t idpf_tx_singleq_frame(struct sk_buff *skb,
 				  struct idpf_tx_queue *tx_q)
 {
 	struct idpf_tx_offload_params offload = { };
+	unsigned int count, buf_count;
 	struct idpf_tx_buf *first;
 	int csum, tso, needed;
-	unsigned int count;
 	__be16 protocol;
 
-	count = idpf_tx_desc_count_required(tx_q, skb);
+	count = idpf_tx_res_count_required(tx_q, skb, &buf_count);
 	if (unlikely(!count))
 		return idpf_tx_drop_skb(tx_q, skb);
 
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index 25eea632a966..674b7a382bf1 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -2254,15 +2254,22 @@ void idpf_tx_splitq_build_flow_desc(union idpf_tx_flex_desc *desc,
 	desc->flow.qw1.compl_tag = cpu_to_le16(params->compl_tag);
 }
 
-/* Global conditions to tell whether the txq (and related resources)
- * has room to allow the use of "size" descriptors.
+/**
+ * idpf_tx_splitq_has_room - check if enough Tx splitq resources are available
+ * @tx_q: the queue to be checked
+ * @descs_needed: number of descriptors required for this packet
+ * @bufs_needed: number of Tx buffers required for this packet
+ *
+ * Return: 0 if no room available, 1 otherwise
  */
-static int idpf_txq_has_room(struct idpf_tx_queue *tx_q, u32 size)
+static int idpf_txq_has_room(struct idpf_tx_queue *tx_q, u32 descs_needed,
+			     u32 bufs_needed)
 {
-	if (IDPF_DESC_UNUSED(tx_q) < size ||
+	if (IDPF_DESC_UNUSED(tx_q) < descs_needed ||
 	    IDPF_TX_COMPLQ_PENDING(tx_q->txq_grp) >
 		IDPF_TX_COMPLQ_OVERFLOW_THRESH(tx_q->txq_grp->complq) ||
-	    IDPF_TX_BUF_RSV_LOW(tx_q))
+	    IDPF_TX_BUF_RSV_LOW(tx_q) ||
+	    IDPF_BUFS_UNUSED(tx_q->refillq) < bufs_needed)
 		return 0;
 	return 1;
 }
@@ -2271,14 +2278,21 @@ static int idpf_txq_has_room(struct idpf_tx_queue *tx_q, u32 size)
  * idpf_tx_maybe_stop_splitq - 1st level check for Tx splitq stop conditions
  * @tx_q: the queue to be checked
  * @descs_needed: number of descriptors required for this packet
+ * @bufs_needed: number of buffers needed for this packet
  *
- * Returns 0 if stop is not needed
+ * Return: 0 if stop is not needed
  */
 static int idpf_tx_maybe_stop_splitq(struct idpf_tx_queue *tx_q,
-				     unsigned int descs_needed)
+				     unsigned int descs_needed,
+				     unsigned int bufs_needed)
 {
+	/* Since we have multiple resources to check for splitq, our
+	 * start,stop_thrs becomes a boolean check instead of a count
+	 * threshold.
+	 */
 	if (netif_subqueue_maybe_stop(tx_q->netdev, tx_q->idx,
-				      idpf_txq_has_room(tx_q, descs_needed),
+				      idpf_txq_has_room(tx_q, descs_needed,
+							bufs_needed),
 				      1, 1))
 		return 0;
 
@@ -2320,24 +2334,29 @@ void idpf_tx_buf_hw_update(struct idpf_tx_queue *tx_q, u32 val,
 }
 
 /**
- * idpf_tx_desc_count_required - calculate number of Tx descriptors needed
+ * idpf_tx_res_count_required - get number of Tx resources needed for this pkt
  * @txq: queue to send buffer on
  * @skb: send buffer
+ * @bufs_needed: (output) number of buffers needed for this skb.
  *
- * Returns number of data descriptors needed for this skb.
+ * Return: number of data descriptors and buffers needed for this skb.
  */
-unsigned int idpf_tx_desc_count_required(struct idpf_tx_queue *txq,
-					 struct sk_buff *skb)
+unsigned int idpf_tx_res_count_required(struct idpf_tx_queue *txq,
+					struct sk_buff *skb,
+					unsigned int *bufs_needed)
 {
 	const struct skb_shared_info *shinfo;
 	unsigned int count = 0, i;
 
 	count += !!skb_headlen(skb);
 
-	if (!skb_is_nonlinear(skb))
+	if (!skb_is_nonlinear(skb)) {
+		*bufs_needed = 1;
 		return count;
+	}
 
 	shinfo = skb_shinfo(skb);
+	*bufs_needed = shinfo->nr_frags;
 	for (i = 0; i < shinfo->nr_frags; i++) {
 		unsigned int size;
 
@@ -2958,12 +2977,12 @@ static netdev_tx_t idpf_tx_splitq_frame(struct sk_buff *skb,
 {
 	struct idpf_tx_splitq_params tx_params = { };
 	union idpf_flex_tx_ctx_desc *ctx_desc;
+	unsigned int count, buf_count;
 	struct idpf_tx_buf *first;
-	unsigned int count;
 	int tso, idx;
 	u16 buf_id;
 
-	count = idpf_tx_desc_count_required(tx_q, skb);
+	count = idpf_tx_res_count_required(tx_q, skb, &buf_count);
 	if (unlikely(!count))
 		return idpf_tx_drop_skb(tx_q, skb);
 
@@ -2973,7 +2992,7 @@ static netdev_tx_t idpf_tx_splitq_frame(struct sk_buff *skb,
 
 	/* Check for splitq specific TX resources */
 	count += (IDPF_TX_DESCS_PER_CACHE_LINE + tso);
-	if (idpf_tx_maybe_stop_splitq(tx_q, count)) {
+	if (idpf_tx_maybe_stop_splitq(tx_q, count, buf_count)) {
 		idpf_tx_buf_hw_update(tx_q, tx_q->next_to_use, false);
 
 		return NETDEV_TX_BUSY;
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.h b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
index a79a6a89c5e3..2d4846793f5a 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
@@ -116,6 +116,10 @@ do {								\
 #define IDPF_DESC_UNUSED(txq)     \
 	((((txq)->next_to_clean > (txq)->next_to_use) ? 0 : (txq)->desc_count) + \
 	(txq)->next_to_clean - (txq)->next_to_use - 1)
+#define IDPF_BUFS_UNUSED(refillq)      \
+	((((refillq)->next_to_use > (refillq)->next_to_clean) ? \
+	  0 : (refillq)->desc_count) + \
+	 (refillq)->next_to_use - (refillq)->next_to_clean)
 
 #define IDPF_TX_BUF_RSV_UNUSED(txq)	((txq)->stash->buf_stack.top)
 #define IDPF_TX_BUF_RSV_LOW(txq)	(IDPF_TX_BUF_RSV_UNUSED(txq) < \
@@ -1047,8 +1051,9 @@ unsigned int idpf_size_to_txd_count(unsigned int size);
 netdev_tx_t idpf_tx_drop_skb(struct idpf_tx_queue *tx_q, struct sk_buff *skb);
 void idpf_tx_dma_map_unwind(struct idpf_tx_queue *txq, struct sk_buff *skb,
 			    struct idpf_tx_buf *first, u16 ring_idx);
-unsigned int idpf_tx_desc_count_required(struct idpf_tx_queue *txq,
-					 struct sk_buff *skb);
+unsigned int idpf_tx_res_count_required(struct idpf_tx_queue *txq,
+					struct sk_buff *skb,
+					unsigned int *buf_count);
 void idpf_tx_timeout(struct net_device *netdev, unsigned int txqueue);
 netdev_tx_t idpf_tx_singleq_frame(struct sk_buff *skb,
 				  struct idpf_tx_queue *tx_q);
-- 
2.39.2



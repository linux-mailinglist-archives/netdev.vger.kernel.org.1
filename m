Return-Path: <netdev+bounces-215747-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5682BB301A1
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 20:02:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D44137BC23E
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 18:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E841234574C;
	Thu, 21 Aug 2025 18:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E73r2vQS"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211823451BB
	for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 18:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755799291; cv=none; b=HIhDdqsBz4qDEbWaQwjh49XvHPjIOolczBMTFlWRDUUbNyIkGSF4PxRirakHFQHd87gQ9wmHGG0U4MjeXp7evdVlxrpg2F6VI5Rt4BJHpzwpOIvyqDEHYs+VHJJkGsYYJ19/ZNJ8KgyBf7MNCRukeH0yvg4fQljyZbcBdlRow+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755799291; c=relaxed/simple;
	bh=YQMtW/HisKVA6/v/IwX+x2wUM6X39qt+PRWiLTJCTp8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tTFxYQHF4M78tkSSNNXYkoPa3ykfdxMKj3wqt+NdPapvOBn8TgFBRCfJ/Z36iKFXIbbyx3tSKwG5n3DgiRnrEO6d0lpQAVLz3zvr5ZqQ3RpTGakeOg29R4xNj7Uf9gylHqChd+wRd71zuPCiEge9PNThxMRNKqhRzG2JK8oZDeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E73r2vQS; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755799290; x=1787335290;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YQMtW/HisKVA6/v/IwX+x2wUM6X39qt+PRWiLTJCTp8=;
  b=E73r2vQSWb+jD179rKECvl3wD70osSqSnvPbqndq5gFJC2AYsEBEsNHF
   axrORmqjneNG5w2jD6Z0v1RmSl0Px1+cSVB+HheXPxVAxzhrYSD74KStd
   oPCj2pFhAuKoXKLIpecMCAGI6nYQJMMQDjxRhkp+wn4JGMXqi+lASS5Tf
   mmln80RCd2FN65qqCt9Ihtkqu331+NUKKj8OOQsahhhR16fzpLnU+S1O+
   diii9Z9G2lv3F1UYe+3Nm6WMyrkZ6mocSETZJPSCxj91j6QI4zRKlG8Kr
   NGBOWIYn1VnSQrEt9E4/QEWEEIuuo5paU6V46YYameSSD6XJfg1EI20ut
   Q==;
X-CSE-ConnectionGUID: f7J5xPwJRa2HkIAEJ7irTw==
X-CSE-MsgGUID: 5aIuV/eoQoaX2J2e6wKNmA==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="60727116"
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="60727116"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 11:01:13 -0700
X-CSE-ConnectionGUID: /RaE+BVbSVOVxfjlhlvdQA==
X-CSE-MsgGUID: ZVpBqV9FR7yBPfCckJHj8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="172738255"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa005.fm.intel.com with ESMTP; 21 Aug 2025 11:01:13 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Joshua Hay <joshua.a.hay@intel.com>,
	anthony.l.nguyen@intel.com,
	lrizzo@google.com,
	brianvv@google.com,
	aleksander.lobakin@intel.com,
	horms@kernel.org,
	Madhu Chittim <madhu.chittim@intel.com>,
	Samuel Salin <Samuel.salin@intel.com>
Subject: [PATCH net 5/6] idpf: stop Tx if there are insufficient buffer resources
Date: Thu, 21 Aug 2025 11:00:58 -0700
Message-ID: <20250821180100.401955-6-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250821180100.401955-1-anthony.l.nguyen@intel.com>
References: <20250821180100.401955-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Joshua Hay <joshua.a.hay@intel.com>

The Tx refillq logic will cause packets to be silently dropped if there
are not enough buffer resources available to send a packet in flow
scheduling mode. Instead, determine how many buffers are needed along
with number of descriptors. Make sure there are enough of both resources
to send the packet, and stop the queue if not.

Fixes: 7292af042bcf ("idpf: fix a race in txq wakeup")
Signed-off-by: Joshua Hay <joshua.a.hay@intel.com>
Reviewed-by: Madhu Chittim <madhu.chittim@intel.com>
Tested-by: Samuel Salin <Samuel.salin@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 .../ethernet/intel/idpf/idpf_singleq_txrx.c   |  4 +-
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   | 47 +++++++++++++------
 drivers/net/ethernet/intel/idpf/idpf_txrx.h   | 15 +++++-
 3 files changed, 47 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c
index 57c0f5ab8f9e..b19b462e0bb6 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c
@@ -415,11 +415,11 @@ netdev_tx_t idpf_tx_singleq_frame(struct sk_buff *skb,
 {
 	struct idpf_tx_offload_params offload = { };
 	struct idpf_tx_buf *first;
+	u32 count, buf_count = 1;
 	int csum, tso, needed;
-	unsigned int count;
 	__be16 protocol;
 
-	count = idpf_tx_desc_count_required(tx_q, skb);
+	count = idpf_tx_res_count_required(tx_q, skb, &buf_count);
 	if (unlikely(!count))
 		return idpf_tx_drop_skb(tx_q, skb);
 
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index 5fe329a7c944..fa5432a0566a 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -2191,15 +2191,22 @@ void idpf_tx_splitq_build_flow_desc(union idpf_tx_flex_desc *desc,
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
+	    idpf_tx_splitq_get_free_bufs(tx_q->refillq) < bufs_needed)
 		return 0;
 	return 1;
 }
@@ -2208,14 +2215,21 @@ static int idpf_txq_has_room(struct idpf_tx_queue *tx_q, u32 size)
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
+				     u32 descs_needed,
+				     u32 bufs_needed)
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
 
@@ -2257,14 +2271,16 @@ void idpf_tx_buf_hw_update(struct idpf_tx_queue *tx_q, u32 val,
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
+					u32 *bufs_needed)
 {
 	const struct skb_shared_info *shinfo;
 	unsigned int count = 0, i;
@@ -2275,6 +2291,7 @@ unsigned int idpf_tx_desc_count_required(struct idpf_tx_queue *txq,
 		return count;
 
 	shinfo = skb_shinfo(skb);
+	*bufs_needed += shinfo->nr_frags;
 	for (i = 0; i < shinfo->nr_frags; i++) {
 		unsigned int size;
 
@@ -2892,11 +2909,11 @@ static netdev_tx_t idpf_tx_splitq_frame(struct sk_buff *skb,
 	};
 	union idpf_flex_tx_ctx_desc *ctx_desc;
 	struct idpf_tx_buf *first;
-	unsigned int count;
+	u32 count, buf_count = 1;
 	int tso, idx;
 	u32 buf_id;
 
-	count = idpf_tx_desc_count_required(tx_q, skb);
+	count = idpf_tx_res_count_required(tx_q, skb, &buf_count);
 	if (unlikely(!count))
 		return idpf_tx_drop_skb(tx_q, skb);
 
@@ -2906,7 +2923,7 @@ static netdev_tx_t idpf_tx_splitq_frame(struct sk_buff *skb,
 
 	/* Check for splitq specific TX resources */
 	count += (IDPF_TX_DESCS_PER_CACHE_LINE + tso);
-	if (idpf_tx_maybe_stop_splitq(tx_q, count)) {
+	if (idpf_tx_maybe_stop_splitq(tx_q, count, buf_count)) {
 		idpf_tx_buf_hw_update(tx_q, tx_q->next_to_use, false);
 
 		return NETDEV_TX_BUSY;
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.h b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
index d86246c320c8..9565e4dc3514 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
@@ -1026,6 +1026,17 @@ static inline void idpf_vport_intr_set_wb_on_itr(struct idpf_q_vector *q_vector)
 	       reg->dyn_ctl);
 }
 
+/**
+ * idpf_tx_splitq_get_free_bufs - get number of free buf_ids in refillq
+ * @refillq: pointer to refillq containing buf_ids
+ */
+static inline u32 idpf_tx_splitq_get_free_bufs(struct idpf_sw_queue *refillq)
+{
+	return (refillq->next_to_use > refillq->next_to_clean ?
+		0 : refillq->desc_count) +
+	       refillq->next_to_use - refillq->next_to_clean - 1;
+}
+
 int idpf_vport_singleq_napi_poll(struct napi_struct *napi, int budget);
 void idpf_vport_init_num_qs(struct idpf_vport *vport,
 			    struct virtchnl2_create_vport *vport_msg);
@@ -1053,8 +1064,8 @@ void idpf_tx_buf_hw_update(struct idpf_tx_queue *tx_q, u32 val,
 			   bool xmit_more);
 unsigned int idpf_size_to_txd_count(unsigned int size);
 netdev_tx_t idpf_tx_drop_skb(struct idpf_tx_queue *tx_q, struct sk_buff *skb);
-unsigned int idpf_tx_desc_count_required(struct idpf_tx_queue *txq,
-					 struct sk_buff *skb);
+unsigned int idpf_tx_res_count_required(struct idpf_tx_queue *txq,
+					struct sk_buff *skb, u32 *buf_count);
 void idpf_tx_timeout(struct net_device *netdev, unsigned int txqueue);
 netdev_tx_t idpf_tx_singleq_frame(struct sk_buff *skb,
 				  struct idpf_tx_queue *tx_q);
-- 
2.47.1



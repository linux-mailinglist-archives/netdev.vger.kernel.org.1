Return-Path: <netdev+bounces-294311-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0zkPMBARH2rmewAAu9opvQ
	(envelope-from <netdev+bounces-294311-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 19:21:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2719D630A6C
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 19:21:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=TV4gV0R0;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294311-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-294311-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C49F630D6751
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 17:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C32EB3F5BE6;
	Tue,  2 Jun 2026 17:09:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182E73F8ED3
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 17:09:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780420177; cv=none; b=tQyS/gqZ+x6ymJr43MWJBEt2oiMMvTchyk1dVOUhJ+lQP802lA6VRs87xeT9+c67ItLCCXMOyrzyQ8o/v9fgvyAgEsMracBA6fnYdH+P8wIN++sJuR0nJXeXLmhYm75e7N00SYp9LE2Kkksii2Tub3ETg++cgmt6swOLL1bxJXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780420177; c=relaxed/simple;
	bh=0hNyd6l4mAlhdLZzhVHbZjXeQ+X9+9CN45W6x7Lxqxo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dX673233P3zON05TvLE9XhOf4pMiKX6gtwKbWXIJ+pmfqf86jd2DoFKquBqy9thnB+xjZy4mrGs7Gw3TLVrxySIvhz/IIxeTxCrQCOOa2BxOaa2sT5jrkRo+0GIGOs7Ti2732O9DNOdGPIo8/Wp3QihgrLdJKHuXWGpvXyg9INo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TV4gV0R0; arc=none smtp.client-ip=192.198.163.17
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780420175; x=1811956175;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0hNyd6l4mAlhdLZzhVHbZjXeQ+X9+9CN45W6x7Lxqxo=;
  b=TV4gV0R04BHOolDdk01YTGhY30Ugj0XMqADi/Pkv4C12Pv01nxKGuIhu
   WbuYDiu1hqMERKd9+FxH+ldbwP+x23oeOWgC4q293OavNvANNMv/Ef8lq
   sl4ajLW2fS6xZi0h+dLbF2Qk2E3rGs/Gx7RDoQReoLx6jG+MZkf9JvRSk
   5oKEyoPdI76laFlHLBhb7o24/S7qUsz6KLUXYhMSMyEJ+wBVMzGB4kzJr
   GxBHxlfkvI9kjlZhhz1J1201bHhqYz0DTuu6hM184WMxy5+C3bBCjHL1z
   P5Kq6y1xcDbcWDjkDODWh+mNV5Is/Ei6d9aqqjXadzMUYRm2ZMXHwcbsL
   Q==;
X-CSE-ConnectionGUID: NNZriDGtS6eVaruO6PkqeQ==
X-CSE-MsgGUID: xQQR1iVZS/WJVOeCXoPmLQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="81074150"
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; 
   d="scan'208";a="81074150"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 10:09:33 -0700
X-CSE-ConnectionGUID: JVoat2iQTGu0yZBYIzl66Q==
X-CSE-MsgGUID: pjhSrO6ZSTKcH1fHo0nhUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; 
   d="scan'208";a="241475801"
Received: from dcskidmo-m40.jf.intel.com ([10.166.241.14])
  by fmviesa008.fm.intel.com with ESMTP; 02 Jun 2026 10:09:32 -0700
From: Joshua Hay <joshua.a.hay@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org
Subject: [Intel-wired-lan][PATCH net v2 3/3] idpf: fix skb datapath queue based scheduling crashes and timeouts
Date: Tue,  2 Jun 2026 10:20:24 -0700
Message-Id: <20260602172024.2285947-4-joshua.a.hay@intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20260602172024.2285947-1-joshua.a.hay@intel.com>
References: <20260602172024.2285947-1-joshua.a.hay@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[joshua.a.hay@intel.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-294311-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:intel-wired-lan@lists.osuosl.org,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joshua.a.hay@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2719D630A6C

The splitq Tx resource checks were assuming that the queues were using
flow based scheduling and checking the refillqs for free buffers.
However, the Tx refillqs are not allocated when using queue based
scheduling resulting in a NULL ptr dereference. Adjust the Tx resource
checks to only check available descriptor resources when using queue
based scheduling. Because queue based scheduling does not have any
notion of descriptor only completions, there cannot be any packets in
flight, meaning there is no need to check for pending completions.

The driver also only supported 8 byte completion descriptors in the skb
datapath previously. However, currently the FW only supports 4 byte
completion descriptors when using queue based scheduling. This meant we
were skipping over completions, resulting in Tx timeouts.  Add support
to process both 4 and 8 byte completion descriptors, depending on the
scheduling mode. Cache the next_to_clean completion descriptor in the
completion queue struct, and fetch this descriptor before the start of
each cleaning loop. Access the next descriptor in the loop by
calculating the index based on raw byte count.

As reported by Sashiko [1], add a dma_rmb to read ownership (gen) bit in
the completion descriptor before any other fields.

Fixes: 0c3f135e840d ("idpf: stop Tx if there are insufficient buffer resources")
Fixes: 1c325aac10a8 ("idpf: configure resources for TX queues")
Link: https://sashiko.dev/#/patchset/20260504-jk-iwl-net-2026-05-04-v1-0-a222a88bd962%40intel.com [1]
Signed-off-by: Joshua Hay <joshua.a.hay@intel.com>
Reviewed-by: Madhu Chittim <madhu.chittim@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
v1->v2: add dma_rmb after completion desc gen bit read
---
 drivers/net/ethernet/intel/idpf/idpf_txrx.c | 51 +++++++++++++--------
 drivers/net/ethernet/intel/idpf/idpf_txrx.h |  6 ++-
 2 files changed, 38 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index 9cc4fbd13313..54ef86ebf11f 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -270,11 +270,9 @@ static int idpf_tx_desc_alloc(const struct idpf_vport *vport,
 static int idpf_compl_desc_alloc(const struct idpf_vport *vport,
 				 struct idpf_compl_queue *complq)
 {
-	u32 desc_size;
-
-	desc_size = idpf_queue_has(FLOW_SCH_EN, complq) ?
-		    sizeof(*complq->comp) : sizeof(*complq->comp_4b);
-	complq->size = array_size(complq->desc_count, desc_size);
+	complq->desc_sz = idpf_queue_has(FLOW_SCH_EN, complq) ?
+			  sizeof(*complq->comp) : sizeof(*complq->comp_4b);
+	complq->size = array_size(complq->desc_count, complq->desc_sz);
 
 	complq->desc_ring = dma_alloc_coherent(complq->netdev->dev.parent,
 					       complq->size, &complq->dma,
@@ -284,6 +282,7 @@ static int idpf_compl_desc_alloc(const struct idpf_vport *vport,
 
 	complq->next_to_use = 0;
 	complq->next_to_clean = 0;
+	complq->ntc_desc = complq->comp;
 	idpf_queue_set(GEN_CHK, complq);
 
 	idpf_xsk_setup_queue(vport, complq,
@@ -2196,7 +2195,7 @@ static void idpf_tx_handle_rs_completion(struct idpf_tx_queue *txq,
 static bool idpf_tx_clean_complq(struct idpf_compl_queue *complq, int budget,
 				 int *cleaned)
 {
-	struct idpf_splitq_tx_compl_desc *tx_desc;
+	struct idpf_splitq_tx_compl_desc *tx_desc = complq->ntc_desc;
 	s16 ntc = complq->next_to_clean;
 	struct idpf_netdev_priv *np;
 	unsigned int complq_budget;
@@ -2204,7 +2203,6 @@ static bool idpf_tx_clean_complq(struct idpf_compl_queue *complq, int budget,
 	int i;
 
 	complq_budget = complq->clean_budget;
-	tx_desc = &complq->comp[ntc];
 	ntc -= complq->desc_count;
 
 	do {
@@ -2221,6 +2219,8 @@ static bool idpf_tx_clean_complq(struct idpf_compl_queue *complq, int budget,
 		if (idpf_queue_has(GEN_CHK, complq) != gen)
 			break;
 
+		dma_rmb();
+
 		/* Find necessary info of TX queue to clean buffers */
 		rel_tx_qid = le16_get_bits(tx_desc->common.qid_comptype_gen,
 					   IDPF_TXD_COMPLQ_QID_M);
@@ -2260,11 +2260,12 @@ static bool idpf_tx_clean_complq(struct idpf_compl_queue *complq, int budget,
 		u64_stats_update_end(&tx_q->stats_sync);
 
 fetch_next_desc:
-		tx_desc++;
+		tx_desc = (struct idpf_splitq_tx_compl_desc *)
+				((u8 *)tx_desc + complq->desc_sz);
 		ntc++;
 		if (unlikely(!ntc)) {
 			ntc -= complq->desc_count;
-			tx_desc = &complq->comp[0];
+			tx_desc = complq->comp;
 			idpf_queue_change(GEN_CHK, complq);
 		}
 
@@ -2274,6 +2275,8 @@ static bool idpf_tx_clean_complq(struct idpf_compl_queue *complq, int budget,
 		complq_budget--;
 	} while (likely(complq_budget));
 
+	complq->ntc_desc = tx_desc;
+
 	/* Store the state of the complq to be used later in deciding if a
 	 * TXQ can be started again
 	 */
@@ -2440,21 +2443,32 @@ static int idpf_txq_has_room(struct idpf_tx_queue *tx_q, u32 descs_needed,
  * @tx_q: the queue to be checked
  * @descs_needed: number of descriptors required for this packet
  * @bufs_needed: number of buffers needed for this packet
+ * @flow: true if queue uses flow based scheduling, false if queue based scheduling
  *
  * Return: 0 if stop is not needed
  */
 static int idpf_tx_maybe_stop_splitq(struct idpf_tx_queue *tx_q,
-				     u32 descs_needed,
-				     u32 bufs_needed)
+				     u32 descs_needed, u32 bufs_needed,
+				     bool flow)
 {
-	/* Since we have multiple resources to check for splitq, our
+	/* Since we have multiple resources to check for flow based splitq, our
 	 * start,stop_thrs becomes a boolean check instead of a count
 	 * threshold.
 	 */
-	if (netif_subqueue_maybe_stop(tx_q->netdev, tx_q->idx,
-				      idpf_txq_has_room(tx_q, descs_needed,
-							bufs_needed),
-				      1, 1))
+	if (flow && netif_subqueue_maybe_stop(tx_q->netdev, tx_q->idx,
+					      idpf_txq_has_room(tx_q,
+								descs_needed,
+								bufs_needed),
+					      1, 1))
+		return 0;
+
+	/* For queue based splitq, there is no need to check the number of
+	 * pending completions since we cannot reuse descriptors until we get
+	 * completions, so we only need to check for descriptor resources.
+	 */
+	if (!flow && netif_subqueue_maybe_stop(tx_q->netdev, tx_q->idx,
+					       IDPF_DESC_UNUSED(tx_q),
+					       descs_needed, descs_needed))
 		return 0;
 
 	u64_stats_update_begin(&tx_q->stats_sync);
@@ -3024,6 +3038,7 @@ static bool idpf_tx_splitq_need_re(struct idpf_tx_queue *tx_q)
 static netdev_tx_t idpf_tx_splitq_frame(struct sk_buff *skb,
 					struct idpf_tx_queue *tx_q)
 {
+	bool flow = idpf_queue_has(FLOW_SCH_EN, tx_q);
 	struct idpf_tx_splitq_params tx_params = {
 		.prev_ntu = tx_q->next_to_use,
 	};
@@ -3043,7 +3058,7 @@ static netdev_tx_t idpf_tx_splitq_frame(struct sk_buff *skb,
 
 	/* Check for splitq specific TX resources */
 	count += (IDPF_TX_DESCS_PER_CACHE_LINE + tso);
-	if (idpf_tx_maybe_stop_splitq(tx_q, count, buf_count)) {
+	if (idpf_tx_maybe_stop_splitq(tx_q, count, buf_count, flow)) {
 		idpf_tx_buf_hw_update(tx_q, tx_q->next_to_use, false);
 
 		return NETDEV_TX_BUSY;
@@ -3075,7 +3090,7 @@ static netdev_tx_t idpf_tx_splitq_frame(struct sk_buff *skb,
 		idpf_tx_set_tstamp_desc(ctx_desc, idx);
 	}
 
-	if (idpf_queue_has(FLOW_SCH_EN, tx_q)) {
+	if (flow) {
 		struct idpf_sw_queue *refillq = tx_q->refillq;
 
 		/* Save refillq state in case of a packet rollback.  Otherwise,
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.h b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
index 8eadc2682c96..2a03ec586161 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
@@ -810,11 +810,13 @@ libeth_cacheline_set_assert(struct idpf_buf_queue, 64, 24, 32);
  * @txq_grp: See struct idpf_txq_group
  * @flags: See enum idpf_queue_flags_t
  * @desc_count: Number of descriptors
+ * @desc_sz: Descriptor size in bytes
  * @clean_budget: queue cleaning budget
  * @netdev: &net_device corresponding to this queue
  * @next_to_use: Next descriptor to use. Relevant in both split & single txq
  *		 and bufq.
  * @next_to_clean: Next descriptor to clean
+ * @ntc_desc: Pointer to next_to_clean descriptor for next NAPI poll
  * @num_completions: Only relevant for TX completion queue. It tracks the
  *		     number of completions received to compare against the
  *		     number of completions pending, as accumulated by the
@@ -836,6 +838,7 @@ struct idpf_compl_queue {
 
 	DECLARE_BITMAP(flags, __IDPF_Q_FLAGS_NBITS);
 	u32 desc_count;
+	u32 desc_sz;
 
 	u32 clean_budget;
 	struct net_device *netdev;
@@ -844,6 +847,7 @@ struct idpf_compl_queue {
 	__cacheline_group_begin_aligned(read_write);
 	u32 next_to_use;
 	u32 next_to_clean;
+	struct idpf_splitq_tx_compl_desc *ntc_desc;
 
 	aligned_u64 num_completions;
 	__cacheline_group_end_aligned(read_write);
@@ -856,7 +860,7 @@ struct idpf_compl_queue {
 	struct idpf_q_vector *q_vector;
 	__cacheline_group_end_aligned(cold);
 };
-libeth_cacheline_set_assert(struct idpf_compl_queue, 40, 16, 24);
+libeth_cacheline_set_assert(struct idpf_compl_queue, 48, 24, 24);
 
 /**
  * struct idpf_sw_queue
-- 
2.39.2



Return-Path: <netdev+bounces-210175-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B26C8B12408
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 20:36:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E7B01C8728D
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 18:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EEBD259CB3;
	Fri, 25 Jul 2025 18:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jyP2U/+s"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90EA6258CF1
	for <netdev@vger.kernel.org>; Fri, 25 Jul 2025 18:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753468494; cv=none; b=nhOaajC54vCAH+XB1rKrd9vD3feWqJutYdtdCUBa+ItltJbV/o3zk29MdZaGs3cRpI6eGuIPNe4vUNnso0Ws8SA9tM8NwjRLfG3wiSKTlONPj9kQP7g+76hkUCng8dJK9NHV0QL3sfzfikF4pZlGROSc0QVGNsctC8NdIUKRyL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753468494; c=relaxed/simple;
	bh=ljbvlVxTlhjFo3SaePkeosgc0qu/xefuvNJDbQHT7iI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZV+KUWSscYUvNSTEbQPCqGpqHiLmlcx63t4CZQA9pL8wyG+tNMurNcYcnsa6RGODpQbvsRYmjAgNEir8W/LG8SpLNCF91+lJhQ3zTzxuYPbsJWnkNq+RblVSbXBsDAA7YNh68N+RZsTpKLoWcQnhmr5pfkRzeeHQGvrkFtc6H/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jyP2U/+s; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753468492; x=1785004492;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ljbvlVxTlhjFo3SaePkeosgc0qu/xefuvNJDbQHT7iI=;
  b=jyP2U/+sZeqf+K1CKFZ2WGUa/3dPKgKyMTXMji47rS79EmFs4UJsoeo5
   qpW5k5MvplbP5K7GSr39dFBRO41CqNkubAs3oXLCa5YaT81KAfZIyvVzz
   u0vr+9qRgHJkpfB6Uc6MpTkwYkRKGYJjn/b1A8CmCIdl/DIK3Dy//6RuG
   JF4RqZQbvStdTs/lYoAkEcwzKll44xwrMVmD7MvE8Yj1nNHSSKewUMaZX
   JiQpXoceom8dCSDEVviEH6Q5fJNeDgU8Um5nsnXGTXjcG28pGlyc3Fm1A
   6l3LdHlHmldEMc++QwLDSo+tL/VKkTAaMmdgQEl7mFEjnyPeLNWfV/UZm
   w==;
X-CSE-ConnectionGUID: JZ2mDW6HT067IA6uL2v5PA==
X-CSE-MsgGUID: Ev/E5HRZT2Golt1wE8dWjQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11503"; a="81252339"
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="81252339"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2025 11:34:52 -0700
X-CSE-ConnectionGUID: DL/GdAmKQsSX4JUuyD4X4Q==
X-CSE-MsgGUID: yATKwqRvSYipxrA0eZeAyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="160803950"
Received: from dcskidmo-m40.jf.intel.com ([10.166.241.13])
  by orviesa009.jf.intel.com with ESMTP; 25 Jul 2025 11:34:52 -0700
From: Joshua Hay <joshua.a.hay@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Joshua Hay <joshua.a.hay@intel.com>,
	Luigi Rizzo <lrizzo@google.com>,
	Brian Vazquez <brianvv@google.com>,
	Madhu Chittim <madhu.chittim@intel.com>
Subject: [Intel-wired-lan] [PATCH iwl-net v3 2/6] idpf: improve when to set RE bit logic
Date: Fri, 25 Jul 2025 11:42:19 -0700
Message-Id: <20250725184223.4084821-3-joshua.a.hay@intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250725184223.4084821-1-joshua.a.hay@intel.com>
References: <20250725184223.4084821-1-joshua.a.hay@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Track the gap between next_to_use and the last RE index. Set RE again
if the gap is large enough to ensure RE bit is set frequently. This is
critical before removing the stashing mechanisms because the
opportunistic descriptor ring cleaning from the out-of-order completions
will go away. Previously the descriptors would be "cleaned" by both the
descriptor (RE) completion and the out-of-order completions. Without the
latter, we must ensure the RE bit is set more frequently. Otherwise,
it's theoretically possible for the descriptor ring next_to_clean to
never advance.  The previous implementation was dependent on the start
of a packet falling on a 64th index in the descriptor ring, which is not
guaranteed with large packets.

Signed-off-by: Luigi Rizzo <lrizzo@google.com>
Signed-off-by: Brian Vazquez <brianvv@google.com>
Signed-off-by: Joshua Hay <joshua.a.hay@intel.com>
Reviewed-by: Madhu Chittim <madhu.chittim@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_txrx.c | 20 +++++++++++++++++++-
 drivers/net/ethernet/intel/idpf/idpf_txrx.h |  6 ++++--
 2 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index d5908126163d..3359b3b52625 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -294,6 +294,8 @@ static int idpf_tx_desc_alloc(const struct idpf_vport *vport,
 	 */
 	idpf_queue_change(GEN_CHK, refillq);
 
+	tx_q->last_re = tx_q->desc_count - IDPF_TX_SPLITQ_RE_MIN_GAP;
+
 	return 0;
 
 err_alloc:
@@ -2912,6 +2914,21 @@ static void idpf_tx_set_tstamp_desc(union idpf_flex_tx_ctx_desc *ctx_desc,
 { }
 #endif /* CONFIG_PTP_1588_CLOCK */
 
+/**
+ * idpf_tx_splitq_need_re - check whether RE bit needs to be set
+ * @tx_q: pointer to Tx queue
+ *
+ * Return: true if RE bit needs to be set, false otherwise
+ */
+static bool idpf_tx_splitq_need_re(struct idpf_tx_queue *tx_q)
+{
+	int gap = tx_q->next_to_use - tx_q->last_re;
+
+	gap += (gap < 0) ? tx_q->desc_count : 0;
+
+	return gap >= IDPF_TX_SPLITQ_RE_MIN_GAP;
+}
+
 /**
  * idpf_tx_splitq_frame - Sends buffer on Tx ring using flex descriptors
  * @skb: send buffer
@@ -2998,9 +3015,10 @@ static netdev_tx_t idpf_tx_splitq_frame(struct sk_buff *skb,
 		 * MIN_RING size to ensure it will be set at least once each
 		 * time around the ring.
 		 */
-		if (!(tx_q->next_to_use % IDPF_TX_SPLITQ_RE_MIN_GAP)) {
+		if (idpf_tx_splitq_need_re(tx_q)) {
 			tx_params.eop_cmd |= IDPF_TXD_FLEX_FLOW_CMD_RE;
 			tx_q->txq_grp->num_completions_pending++;
+			tx_q->last_re = tx_q->next_to_use;
 		}
 
 		if (skb->ip_summed == CHECKSUM_PARTIAL)
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.h b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
index 6924bee6ff5b..65acad4c929d 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
@@ -609,6 +609,8 @@ libeth_cacheline_set_assert(struct idpf_rx_queue, 64,
  * @netdev: &net_device corresponding to this queue
  * @next_to_use: Next descriptor to use
  * @next_to_clean: Next descriptor to clean
+ * @last_re: last descriptor index that RE bit was set
+ * @tx_max_bufs: Max buffers that can be transmitted with scatter-gather
  * @cleaned_bytes: Splitq only, TXQ only: When a TX completion is received on
  *		   the TX completion queue, it can be for any TXQ associated
  *		   with that completion queue. This means we can clean up to
@@ -619,7 +621,6 @@ libeth_cacheline_set_assert(struct idpf_rx_queue, 64,
  *		   only once at the end of the cleaning routine.
  * @clean_budget: singleq only, queue cleaning budget
  * @cleaned_pkts: Number of packets cleaned for the above said case
- * @tx_max_bufs: Max buffers that can be transmitted with scatter-gather
  * @stash: Tx buffer stash for Flow-based scheduling mode
  * @refillq: Pointer to refill queue
  * @compl_tag_bufid_m: Completion tag buffer id mask
@@ -662,6 +663,8 @@ struct idpf_tx_queue {
 	__cacheline_group_begin_aligned(read_write);
 	u16 next_to_use;
 	u16 next_to_clean;
+	u16 last_re;
+	u16 tx_max_bufs;
 
 	union {
 		u32 cleaned_bytes;
@@ -669,7 +672,6 @@ struct idpf_tx_queue {
 	};
 	u16 cleaned_pkts;
 
-	u16 tx_max_bufs;
 	struct idpf_txq_stash *stash;
 	struct idpf_sw_queue *refillq;
 
-- 
2.39.2



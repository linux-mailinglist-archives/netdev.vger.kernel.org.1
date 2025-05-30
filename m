Return-Path: <netdev+bounces-194429-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3465AC96EA
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 23:12:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 259A41C05C2B
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 21:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF334283CBD;
	Fri, 30 May 2025 21:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VjyYgPwD"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33EF283686
	for <netdev@vger.kernel.org>; Fri, 30 May 2025 21:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748639551; cv=none; b=cvpiErsusfCUBL9q7z8edF7BZGgc2Y+WTis2CxLEY/6GFO5iz8AlC0AoBttA+cRp8MgmsD33j81EXE9BjctY4owONR2HKmFxe90Bw8fWfJkrgHqRG6Eh6zOTy26bxId+tnRmRTk5bhsDpZW7NHfihxwVtq4DSBXxsLe8zM4Spro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748639551; c=relaxed/simple;
	bh=2oZ/t60rxKZ8eSQKU9mKyxh1R9orCnEQKKhheNPkFpA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UOkLCiHjopk815gV1d1tj1MVjH48/mnQ4nvTIDBRvdcPFKSC+oYxGjqH5ufnmpMwwFAc6fqID+AVjtGvWAyBOVvLIbTe8JCP5J//j2aV98hZwFBSMdA3ARI1Pp47p1HOfGOkQQxOCt8No3XuPXbCKxTnUght259I3UK3RrEfXDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VjyYgPwD; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748639550; x=1780175550;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2oZ/t60rxKZ8eSQKU9mKyxh1R9orCnEQKKhheNPkFpA=;
  b=VjyYgPwDLVvb25HGYVHg3CHR2sJFzXKxWZoqJO3ZFsr3mFecyiJg8uiT
   5QOCjQHNnCX/JVeJn8Zqzg7BkYJEWXSYVPw4IYGXH9nL/7SMyy/G0+P28
   BWOfTZJviALg+W8bGavSvn2PoMZ9J6GTrySKb/MY5dK7rJibSBL9K/PkF
   k5j3ZPYVxgRefyufqiEDBd+a+RJQ8HQeHQBhZDw9DxxLqC1Fod0x/vGOo
   FKUeFjIqnMFygBjs5s0HN5HghYvhlFSiMPEII7gGxsOU43Nb8Y38nXi0E
   GBAfH6FvQTm6/MPbKMR/7AlaMCqV/BJFR5eWkDkjlymjBSRY5d0Z7RO/4
   w==;
X-CSE-ConnectionGUID: +Rkpp+1WR6i+Xy7yZ5NKsg==
X-CSE-MsgGUID: +9iffTCCRj6dPYXzFrIywg==
X-IronPort-AV: E=McAfee;i="6700,10204,11449"; a="49862618"
X-IronPort-AV: E=Sophos;i="6.16,196,1744095600"; 
   d="scan'208";a="49862618"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2025 14:12:25 -0700
X-CSE-ConnectionGUID: 1ZvXY7BmSIeM2cbLmdXFqQ==
X-CSE-MsgGUID: ROLchqaySnaLNkltnCkkIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,196,1744095600"; 
   d="scan'208";a="144621683"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa007.jf.intel.com with ESMTP; 30 May 2025 14:12:25 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Brian Vazquez <brianvv@google.com>,
	anthony.l.nguyen@intel.com,
	brianvv.kernel@gmail.com,
	willemb@google.com,
	decot@google.com,
	lrizzo@google.com,
	Jacob Keller <jacob.e.keller@intel.com>,
	Madhu Chittim <madhu.chittim@intel.com>,
	Josh Hay <joshua.a.hay@intel.com>,
	Simon Horman <horms@kernel.org>,
	Samuel Salin <Samuel.salin@intel.com>
Subject: [PATCH net 4/5] idpf: fix a race in txq wakeup
Date: Fri, 30 May 2025 14:12:18 -0700
Message-ID: <20250530211221.2170484-5-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250530211221.2170484-1-anthony.l.nguyen@intel.com>
References: <20250530211221.2170484-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Brian Vazquez <brianvv@google.com>

Add a helper function to correctly handle the lockless
synchronization when the sender needs to block. The paradigm is

        if (no_resources()) {
                stop_queue();
                barrier();
                if (!no_resources())
                        restart_queue();
        }

netif_subqueue_maybe_stop already handles the paradigm correctly, but
the code split the check for resources in three parts, the first one
(descriptors) followed the protocol, but the other two (completions and
tx_buf) were only doing the first part and so race prone.

Luckily netif_subqueue_maybe_stop macro already allows you to use a
function to evaluate the start/stop conditions so the fix only requires
the right helper function to evaluate all the conditions at once.

The patch removes idpf_tx_maybe_stop_common since it's no longer needed
and instead adjusts separately the conditions for singleq and splitq.

Note that idpf_tx_buf_hw_update doesn't need to check for resources
since that will be covered in idpf_tx_splitq_frame.

To reproduce:

Reduce the threshold for pending completions to increase the chances of
hitting this pause by changing your kernel:

drivers/net/ethernet/intel/idpf/idpf_txrx.h

-#define IDPF_TX_COMPLQ_OVERFLOW_THRESH(txcq)   ((txcq)->desc_count >> 1)
+#define IDPF_TX_COMPLQ_OVERFLOW_THRESH(txcq)   ((txcq)->desc_count >> 4)

Use pktgen to force the host to push small pkts very aggressively:

./pktgen_sample02_multiqueue.sh -i eth1 -s 100 -6 -d $IP -m $MAC \
  -p 10000-10000 -t 16 -n 0 -v -x -c 64

Fixes: 6818c4d5b3c2 ("idpf: add splitq start_xmit")
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Madhu Chittim <madhu.chittim@intel.com>
Signed-off-by: Josh Hay <joshua.a.hay@intel.com>
Signed-off-by: Brian Vazquez <brianvv@google.com>
Signed-off-by: Luigi Rizzo <lrizzo@google.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Samuel Salin <Samuel.salin@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 .../ethernet/intel/idpf/idpf_singleq_txrx.c   |  9 ++--
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   | 45 +++++++------------
 drivers/net/ethernet/intel/idpf/idpf_txrx.h   |  8 ----
 3 files changed, 22 insertions(+), 40 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c
index 2e356dd10812..993c354aa27a 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c
@@ -362,17 +362,18 @@ netdev_tx_t idpf_tx_singleq_frame(struct sk_buff *skb,
 {
 	struct idpf_tx_offload_params offload = { };
 	struct idpf_tx_buf *first;
+	int csum, tso, needed;
 	unsigned int count;
 	__be16 protocol;
-	int csum, tso;
 
 	count = idpf_tx_desc_count_required(tx_q, skb);
 	if (unlikely(!count))
 		return idpf_tx_drop_skb(tx_q, skb);
 
-	if (idpf_tx_maybe_stop_common(tx_q,
-				      count + IDPF_TX_DESCS_PER_CACHE_LINE +
-				      IDPF_TX_DESCS_FOR_CTX)) {
+	needed = count + IDPF_TX_DESCS_PER_CACHE_LINE + IDPF_TX_DESCS_FOR_CTX;
+	if (!netif_subqueue_maybe_stop(tx_q->netdev, tx_q->idx,
+				       IDPF_DESC_UNUSED(tx_q),
+				       needed, needed)) {
 		idpf_tx_buf_hw_update(tx_q, tx_q->next_to_use, false);
 
 		u64_stats_update_begin(&tx_q->stats_sync);
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index 631679cdaa6f..5cf440e09d0a 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -2184,6 +2184,19 @@ void idpf_tx_splitq_build_flow_desc(union idpf_tx_flex_desc *desc,
 	desc->flow.qw1.compl_tag = cpu_to_le16(params->compl_tag);
 }
 
+/* Global conditions to tell whether the txq (and related resources)
+ * has room to allow the use of "size" descriptors.
+ */
+static int idpf_txq_has_room(struct idpf_tx_queue *tx_q, u32 size)
+{
+	if (IDPF_DESC_UNUSED(tx_q) < size ||
+	    IDPF_TX_COMPLQ_PENDING(tx_q->txq_grp) >
+		IDPF_TX_COMPLQ_OVERFLOW_THRESH(tx_q->txq_grp->complq) ||
+	    IDPF_TX_BUF_RSV_LOW(tx_q))
+		return 0;
+	return 1;
+}
+
 /**
  * idpf_tx_maybe_stop_splitq - 1st level check for Tx splitq stop conditions
  * @tx_q: the queue to be checked
@@ -2194,29 +2207,11 @@ void idpf_tx_splitq_build_flow_desc(union idpf_tx_flex_desc *desc,
 static int idpf_tx_maybe_stop_splitq(struct idpf_tx_queue *tx_q,
 				     unsigned int descs_needed)
 {
-	if (idpf_tx_maybe_stop_common(tx_q, descs_needed))
-		goto out;
-
-	/* If there are too many outstanding completions expected on the
-	 * completion queue, stop the TX queue to give the device some time to
-	 * catch up
-	 */
-	if (unlikely(IDPF_TX_COMPLQ_PENDING(tx_q->txq_grp) >
-		     IDPF_TX_COMPLQ_OVERFLOW_THRESH(tx_q->txq_grp->complq)))
-		goto splitq_stop;
-
-	/* Also check for available book keeping buffers; if we are low, stop
-	 * the queue to wait for more completions
-	 */
-	if (unlikely(IDPF_TX_BUF_RSV_LOW(tx_q)))
-		goto splitq_stop;
-
-	return 0;
-
-splitq_stop:
-	netif_stop_subqueue(tx_q->netdev, tx_q->idx);
+	if (netif_subqueue_maybe_stop(tx_q->netdev, tx_q->idx,
+				      idpf_txq_has_room(tx_q, descs_needed),
+				      1, 1))
+		return 0;
 
-out:
 	u64_stats_update_begin(&tx_q->stats_sync);
 	u64_stats_inc(&tx_q->q_stats.q_busy);
 	u64_stats_update_end(&tx_q->stats_sync);
@@ -2242,12 +2237,6 @@ void idpf_tx_buf_hw_update(struct idpf_tx_queue *tx_q, u32 val,
 	nq = netdev_get_tx_queue(tx_q->netdev, tx_q->idx);
 	tx_q->next_to_use = val;
 
-	if (idpf_tx_maybe_stop_common(tx_q, IDPF_TX_DESC_NEEDED)) {
-		u64_stats_update_begin(&tx_q->stats_sync);
-		u64_stats_inc(&tx_q->q_stats.q_busy);
-		u64_stats_update_end(&tx_q->stats_sync);
-	}
-
 	/* Force memory writes to complete before letting h/w
 	 * know there are new descriptors to fetch.  (Only
 	 * applicable for weak-ordered memory model archs,
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.h b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
index c779fe71df99..36a0f828a6f8 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
@@ -1049,12 +1049,4 @@ bool idpf_rx_singleq_buf_hw_alloc_all(struct idpf_rx_queue *rxq,
 				      u16 cleaned_count);
 int idpf_tso(struct sk_buff *skb, struct idpf_tx_offload_params *off);
 
-static inline bool idpf_tx_maybe_stop_common(struct idpf_tx_queue *tx_q,
-					     u32 needed)
-{
-	return !netif_subqueue_maybe_stop(tx_q->netdev, tx_q->idx,
-					  IDPF_DESC_UNUSED(tx_q),
-					  needed, needed);
-}
-
 #endif /* !_IDPF_TXRX_H_ */
-- 
2.47.1



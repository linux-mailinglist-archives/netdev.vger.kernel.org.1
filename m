Return-Path: <netdev+bounces-215744-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1EF7B301A4
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 20:02:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E79BF1CE3AD9
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 18:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B45573451A8;
	Thu, 21 Aug 2025 18:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fJvnf75k"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108CD34165B
	for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 18:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755799289; cv=none; b=eBYU7odWcAvOPyNK2ESul7Obj6G6SzvKyEJ3thhcnbHP3FQwDCnhiaytdIkhRR+VvCMEz5vwnzQ5ahpAilsOfjpwKkMxGOzE+LdpJNk/KDrJKCY5VIze+idDlhB7Kd+gW4WDwUYtzmfVUJ3Cp+hPyuFj0t8KlLkFDrIkd2oYCkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755799289; c=relaxed/simple;
	bh=oAO9vWC6KVwzYSozPHwlkZjQ6dCaLj0Ka4tTDNuUIEs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=owS4vJFxqNQJHduJjZW764Esa/dPEqS0DwUDjajUyZORFTkutTjCL3bxd4USCGOKVtXcoASLOtk/81JEmnvjJEK6sU3Dubrgk0avnKbff3ihPZdmeJwILnZJqzdF077h1ZpWRu47GKSxcndz9j1zspnUrt4ShOH9Rcokimpvt+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fJvnf75k; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755799288; x=1787335288;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oAO9vWC6KVwzYSozPHwlkZjQ6dCaLj0Ka4tTDNuUIEs=;
  b=fJvnf75kN2kTO9ZRInu0kE+J7cBYF6GueGyrebdEMAjA0kX0a83Mn06a
   aVlXnja7fdJQi0N4yMEaXSCUScH3jsGruLXTQQQEKV1x0ouLR0VFcSp13
   PqtUnCuZv5OvE/R9l/ac6c6dEcGBzO4+75fJTNxrrWEKo9dchSXzGEjED
   8v3R6jRokBmO9y3LN/irI4C72N91KrbgkduDzu/aW/g0f92Qlg+J0bqk4
   BGsAx8NOqR2nGou3mKdJELLVvKuB8gKT6U34LsRtWJdTXyziGXTFw/lcS
   cI96rgG15wyBFBG8dDcpwUhb2uT2aSEFpy2+xwxjJrJacFD7nusYJvSRb
   Q==;
X-CSE-ConnectionGUID: W3KSpd5HSvyrC+PSsnbI/g==
X-CSE-MsgGUID: PxaWwZnETIucMWw/KZo9/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="60727084"
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="60727084"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 11:01:11 -0700
X-CSE-ConnectionGUID: HzFFEs51SkaAIgRx50cTkw==
X-CSE-MsgGUID: fpYaqEx3RES11A+F4OBVCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="172738228"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa005.fm.intel.com with ESMTP; 21 Aug 2025 11:01:11 -0700
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
Subject: [PATCH net 2/6] idpf: improve when to set RE bit logic
Date: Thu, 21 Aug 2025 11:00:55 -0700
Message-ID: <20250821180100.401955-3-anthony.l.nguyen@intel.com>
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
Tested-by: Samuel Salin <Samuel.salin@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_txrx.c | 20 +++++++++++++++++++-
 drivers/net/ethernet/intel/idpf/idpf_txrx.h |  6 ++++--
 2 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index 9b63944235fb..ee59153508af 100644
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
index 58232a1bd0a9..c75ca5d3e57c 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
@@ -610,6 +610,8 @@ libeth_cacheline_set_assert(struct idpf_rx_queue, 64,
  * @netdev: &net_device corresponding to this queue
  * @next_to_use: Next descriptor to use
  * @next_to_clean: Next descriptor to clean
+ * @last_re: last descriptor index that RE bit was set
+ * @tx_max_bufs: Max buffers that can be transmitted with scatter-gather
  * @cleaned_bytes: Splitq only, TXQ only: When a TX completion is received on
  *		   the TX completion queue, it can be for any TXQ associated
  *		   with that completion queue. This means we can clean up to
@@ -620,7 +622,6 @@ libeth_cacheline_set_assert(struct idpf_rx_queue, 64,
  *		   only once at the end of the cleaning routine.
  * @clean_budget: singleq only, queue cleaning budget
  * @cleaned_pkts: Number of packets cleaned for the above said case
- * @tx_max_bufs: Max buffers that can be transmitted with scatter-gather
  * @stash: Tx buffer stash for Flow-based scheduling mode
  * @refillq: Pointer to refill queue
  * @compl_tag_bufid_m: Completion tag buffer id mask
@@ -663,6 +664,8 @@ struct idpf_tx_queue {
 	__cacheline_group_begin_aligned(read_write);
 	u16 next_to_use;
 	u16 next_to_clean;
+	u16 last_re;
+	u16 tx_max_bufs;
 
 	union {
 		u32 cleaned_bytes;
@@ -670,7 +673,6 @@ struct idpf_tx_queue {
 	};
 	u16 cleaned_pkts;
 
-	u16 tx_max_bufs;
 	struct idpf_txq_stash *stash;
 	struct idpf_sw_queue *refillq;
 
-- 
2.47.1



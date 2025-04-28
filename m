Return-Path: <netdev+bounces-186552-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36ABFA9FA03
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 21:55:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43CF33B8346
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 19:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B3B4296D29;
	Mon, 28 Apr 2025 19:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Yxv0FS0C"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E192973AE
	for <netdev@vger.kernel.org>; Mon, 28 Apr 2025 19:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745870153; cv=none; b=bxofJMNxQx8hN3EevEPpVc2d6pic2aw2pZagAE5TC8AOQIg/ncVFbAm+qT6rwi1Oz05G6J6FySu/P+C/sp0XPuC/sMvbYWYbsrYeRXTD7805Xg1v5jgkk/QweR8/FSjmZ0LPA5PPOyyPJTHtM9ESrsu16R/cgSYUKyIWg2xO49A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745870153; c=relaxed/simple;
	bh=MaA81J+3HtofT3J1tOR6wMfPW9HqOJsPPsy7qd6wKiU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=uVDi4DrjJLQZQCjneDZzwjoHtBEaZnGIa0s8YEjCVj+9ae7N1jMu9Av6bqubVA+vo2VycfURx6gE9SCSFgBBhe5ri4c9B2JPRC4QjFTwlYvk5CV1dBk/TCxf986VmQY6JfM7G7K3B49qKwfVd1k1YZnOBwj2EvNlL+WUu/40mok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--brianvv.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Yxv0FS0C; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--brianvv.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-73c09e99069so5263989b3a.0
        for <netdev@vger.kernel.org>; Mon, 28 Apr 2025 12:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745870150; x=1746474950; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WF1rdyAsoL1EvhWVSLVqE87e6m1CGCQ1ONSXKdBqozE=;
        b=Yxv0FS0C8oW7Q+cTSSiVaFQtW1pGKzXw+jspheiK7MTQCyMrNVDjEal3Zm07WLPs6K
         IywT32VR3Zn+2jYTx97T9IKMvGldz14Ztio+NuZ9K6D4cl8YjhAIJX3Aq87JkAeXyuDN
         4IgF3huZYydXsZk/3nmlV811gi+oLkFMcg3vDoAxhGsjlvDU3TzLRw0MjV2h+vbIEvKd
         pjl7BvzGDl63saNVXzLukonOH5kuxfXQX2/L6JXGn/jnmFtdGyaAmnjFqpW0uOH6DpRn
         RLdrOod1Gu9QffK++CMTMkb0GCdfjzfKAZtLIaPlSCTXGNskr2yDELo1lr3jBONEdejI
         GLVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745870150; x=1746474950;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WF1rdyAsoL1EvhWVSLVqE87e6m1CGCQ1ONSXKdBqozE=;
        b=T0seMfAgipaXcivMcbc0CV0AfYvdALpd/X+qLiZpfYgKJmC+4Hc21+FwGKuI4OyQ08
         7uOu38wASgrC4Il3J50hG5j/NK18hjRLJ4tGW345JyPoaHDhPJLiyPGzwA5k2N7BwzMn
         nqjaywNPYwaS3du7oI6Soeg5+f92kaau1ApP/C79+J4WEzD8YTg/QFAbjA07lV1ZIJUA
         DVDU5XRj9F2Ep+2VdAqgRrwZUL2EyY1mpZyLXVYW/q0T8VLO8adWCP+KCfFlTPSJYHeK
         7AQ3zBflScFDnf/TpsvQ9hxj4GWMok8mCqOQ4RPNjmKj64MSM53kdN4HgcRmJWPCtzGR
         jPmA==
X-Forwarded-Encrypted: i=1; AJvYcCWg1R8FN69pkqkufk7uafmd4hbh941OUkvjl0VpucU5Ba4ecsYBGnKZFEzy9236QTVPT5Jy2SU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFqtNUloA5ggSuNaKezEHTbT+/9rvdIlfKI97h9V/mFdSHIz7r
	UKe/3cPmT6scDsjmAeUkYw9Y28JvYJJprHhCWWbYbckjOAa8fGtUaOE4Y6g2q4p84Lmz2uF1uJ0
	eH0MzMA==
X-Google-Smtp-Source: AGHT+IGgzi/mmJ2yTIATM1jhnypep6TvOgCGYfDJkP79jyyBpEEK6EumSZueXfXDpyYjfteBqr8NEmlR8IGO
X-Received: from pfbcl15.prod.google.com ([2002:a05:6a00:32cf:b0:740:65f:220a])
 (user=brianvv job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:cfa4:b0:1f5:58b9:6d97
 with SMTP id adf61e73a8af0-2093e52803amr1192392637.35.1745870150677; Mon, 28
 Apr 2025 12:55:50 -0700 (PDT)
Date: Mon, 28 Apr 2025 19:55:32 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.901.g37484f566f-goog
Message-ID: <20250428195532.1590892-1-brianvv@google.com>
Subject: [iwl-net PATCH v2] idpf: fix a race in txq wakeup
From: Brian Vazquez <brianvv@google.com>
To: Brian Vazquez <brianvv.kernel@gmail.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	intel-wired-lan@lists.osuosl.org
Cc: David Decotigny <decot@google.com>, Anjali Singhai <anjali.singhai@intel.com>, 
	Sridhar Samudrala <sridhar.samudrala@intel.com>, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, emil.s.tantilov@intel.com, 
	Brian Vazquez <brianvv@google.com>, Josh Hay <joshua.a.hay@intel.com>, 
	Luigi Rizzo <lrizzo@google.com>
Content-Type: text/plain; charset="UTF-8"

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

Note that idpf_rx_buf_hw_update doesn't need to check for resources
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
Signed-off-by: Josh Hay <joshua.a.hay@intel.com>
Signed-off-by: Brian Vazquez <brianvv@google.com>
Signed-off-by: Luigi Rizzo <lrizzo@google.com>
---
v2:
- Fix typos
- Fix RCT in singleq function
- No inline in c files
- Submit to iwl-net and add Fixes tag

 .../ethernet/intel/idpf/idpf_singleq_txrx.c   |  9 ++--
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   | 45 +++++++------------
 drivers/net/ethernet/intel/idpf/idpf_txrx.h   |  8 ----
 3 files changed, 22 insertions(+), 40 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c
index eae1b6f474e6..6ade54e21325 100644
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
index bdf52cef3891..a6ca2f55b5d5 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -2132,6 +2132,19 @@ void idpf_tx_splitq_build_flow_desc(union idpf_tx_flex_desc *desc,
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
@@ -2142,29 +2155,11 @@ void idpf_tx_splitq_build_flow_desc(union idpf_tx_flex_desc *desc,
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
@@ -2190,12 +2185,6 @@ void idpf_tx_buf_hw_update(struct idpf_tx_queue *tx_q, u32 val,
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
index b029f566e57c..c192a6c547dd 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
@@ -1037,12 +1037,4 @@ bool idpf_rx_singleq_buf_hw_alloc_all(struct idpf_rx_queue *rxq,
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
2.49.0.901.g37484f566f-goog



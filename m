Return-Path: <netdev+bounces-187290-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F8E8AA6215
	for <lists+netdev@lfdr.de>; Thu,  1 May 2025 19:06:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D2E11886439
	for <lists+netdev@lfdr.de>; Thu,  1 May 2025 17:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A7B92144CF;
	Thu,  1 May 2025 17:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WZmhNm0q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA6511185
	for <netdev@vger.kernel.org>; Thu,  1 May 2025 17:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746119203; cv=none; b=fGsgLT/KAZCA/bV5cdvzF2FCBy3iUuY8lRnkAMu+WxjIBuwzW5ncCYKZZ1yOKbBgky+CsZq4zGYy2Dj+BzSpC9o0Lx/4ngQTp61Q4XUpMcOPnwKdsbv2QNyuNUk2E/CowVA39wwtxnHoVOiD+ymHiqMcDwL2UisLUfNahOKAWpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746119203; c=relaxed/simple;
	bh=vpwoHZgEK+eBpkOnV4IVJceo45W3/GlUw9ugRDiiG1E=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=q8AVvrmDpBM0Dw0pURNpQuMWkme8MmconP3aeelBuGt3QvwjCxtie5n3Ggw6ZGuyRf7QC1o/k0CY5380f34BOJ+Ja88rcGM8ckBZJOR1yi6KKgg0MLIrmmW8+PiwLOZH3Cf57SXzCl9ZcTOmj8iNui5MIPdIbYSNK94OgRgbQNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--brianvv.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WZmhNm0q; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--brianvv.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-736c0306242so1668379b3a.1
        for <netdev@vger.kernel.org>; Thu, 01 May 2025 10:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746119201; x=1746724001; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CYoyI2HUtH9/wqxtGZ6AIAXvjb4DxACBRi1cFZcTEuM=;
        b=WZmhNm0qVM6aG4SLxyKD7Jo+3/t1tTa7ARSDNylV/xYg3asgUvGdJ8geqdLaBlj3y2
         /ElfnKBwQ6HP9ryfMT8900P1diUVOYvCFZ51VXo7YFxYWyfSEf6UXzlWJYSZTYN0opxB
         4lEOmkLcSOtfVd4+cPNKAemSri1Y1tiTOEt0I0JJFEBN6/SVZ7JBGlSNXQ/XMfWn48n0
         1uGebGJKOV9VbAWIyENJiqYMxbNU36mkl7yV8XElkELwxI7EnJFs7hx43/+FAZLF9OMp
         i7l2vzCsRor2fpcXfcUR2N8/a0NiWwRJVusXQ+aWFrJN2NpKBDfosr08T3OFVyoXRDKg
         vGNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746119201; x=1746724001;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CYoyI2HUtH9/wqxtGZ6AIAXvjb4DxACBRi1cFZcTEuM=;
        b=sAkd+r6yZkOeZ3OrQ0XDs7sVLisigkK91e7V/b1JlN0wBWKJR3n9z9WvPIL9GOsYh5
         8kCmV3+Qp21Yhnwhu43/7qbUOV8KkVkNRbt4hs4LhRWlvcjNvEIJ2VXqfCzOgfkQ+B7A
         hwdAU06wJXxbCvt0C5u8s+z9VzpiqIAXbtHgmZkbkw14XqwPdetwP2/VxRAppDKlt3MO
         ewJ4OzFizzxHDOJQ+1jRvM/hqSIIcYnAMrTWMZkbR1G973phNCBk+VmwoG0jtCYKbLsb
         wGJSW+tHpoUFSCqqSYCFtKp/TgHM5cft9MriJCkIGGyyc4P7ID7MoJpzzHtAABiaImmP
         pmqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVSCl1du/EJlNm6c7BbZy8lEY/SULxhU2OJKpxXVneuX3H7/T+0KccWXz8SimbKaAFmcwRwoHY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoNt9w7qMW488hyMwUnuThMWHomuYLpTp3hq+MO7O5/vM5H7cK
	CU5HqkuKWyQVQ8UX0B2dzP1u9NS/awmGZXQzyDbl3oxEOg98QoADnTOhougQqkq5x9zPjbQG4Xw
	tHhQ1UA==
X-Google-Smtp-Source: AGHT+IE+CNt/JL+aCgGxR0exee8kV9DzgY4OHDalS4DF1luZNEgwobOsGpCnxsW+nq8AuUV79LdPhRXrXa/D
X-Received: from pfny12.prod.google.com ([2002:aa7:854c:0:b0:740:41eb:584c])
 (user=brianvv job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2e29:b0:736:a973:748
 with SMTP id d2e1a72fcca58-7403a82e80dmr9803580b3a.22.1746119200622; Thu, 01
 May 2025 10:06:40 -0700 (PDT)
Date: Thu,  1 May 2025 17:06:17 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.967.g6a0df3ecc3-goog
Message-ID: <20250501170617.1121247-1-brianvv@google.com>
Subject: [iwl-net PATCH v3] idpf: fix a race in txq wakeup
From: Brian Vazquez <brianvv@google.com>
To: Brian Vazquez <brianvv.kernel@gmail.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	intel-wired-lan@lists.osuosl.org
Cc: David Decotigny <decot@google.com>, Anjali Singhai <anjali.singhai@intel.com>, 
	Sridhar Samudrala <sridhar.samudrala@intel.com>, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, emil.s.tantilov@intel.com, 
	Brian Vazquez <brianvv@google.com>, Jacob Keller <jacob.e.keller@intel.com>, 
	Madhu Chittim <madhu.chittim@intel.com>, Josh Hay <joshua.a.hay@intel.com>, 
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
---
v3:
- Fix typo in commit message
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
2.49.0.967.g6a0df3ecc3-goog



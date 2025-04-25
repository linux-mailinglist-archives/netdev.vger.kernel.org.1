Return-Path: <netdev+bounces-186079-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE06BA9D010
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 19:54:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7D0B1B6081B
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 17:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E70B1FE474;
	Fri, 25 Apr 2025 17:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o9I2+0qP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEDB61DED5D
	for <netdev@vger.kernel.org>; Fri, 25 Apr 2025 17:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745603685; cv=none; b=uPE/sBvmUPx07pwkdyiXyXa2cjragt3iTAV6Oi8Ok8azHNi7JOJgzcAZ+4hi2MQFyNiTnWn1WJcMpnqUcM3cZa0huBretzLvT3mriPtoD+kDbQgC7BWiEST+10x1L4MYaqebrhGtb/HKq7vdFEkFBp8R71PEP9PNtuCbq/4HR34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745603685; c=relaxed/simple;
	bh=TDcDG4961RqBZwRUnI6OzSCYnyhIUCqoI2dBjdnGAnE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=A7qxLTUdVDWrN+AchKkWS3D+aSvNYmtvlIMWloCXWDdXuwXYL5mSoO3RQqABpDnPFInAflHUral5L1DQsBN1VxZHVRIqFxkVqiD4ISFdkYhDhZI6G9h8mRdLRCvABOc0nkI6gzrTjXXSQSH2l/wfKUQiNCamO3hmLge+9uI3nTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--brianvv.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o9I2+0qP; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--brianvv.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-af5a8c67707so1574005a12.1
        for <netdev@vger.kernel.org>; Fri, 25 Apr 2025 10:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745603682; x=1746208482; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wUyDDDATMAbAlsjuyDcvLPYobzWIS7zLHCptp+fvkNY=;
        b=o9I2+0qPNcz8MGXrwOqP5+f3/L6j2tW8ByuLI5NZ5R1Mq667QY9ThTdKvOcovHQVeP
         82wKHK7bM4go7iJguU1n07LfWLEhK/oYe/MOYouZt9jwWcdR5hcNq0Yt++HkcKKHQz6Y
         pzzjd3BZJRaZ0Sy43RcQJxE49mERYTYId+q9cuQ9Zc5YBjkOuw0oJiJ9f3o4IFvuFYOR
         4ewDdmk1WHk/wk1trEPfM9OJdq2zGBtfwoDy07rXi977xRICmo2hK693cXqwCHoAu31z
         YCvqBpTrArIiWHYi8Wcz919cSv2/Rabq+IAuFN/ayJZlAHHrRedNTisV4hqXEi2szuuX
         28YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745603682; x=1746208482;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wUyDDDATMAbAlsjuyDcvLPYobzWIS7zLHCptp+fvkNY=;
        b=SjgTVtu6UDbu62A61aQQdsjs+Ftiw6CyJ9awaLuxpaWz7H2LokecP5/mYMIJykr50F
         cVjC55z73odKBkMREEw6mlARidmWDsPD+n2govhcZQ4y9sHJ0q13VkTL1OZpf8KK4M3T
         XJWOUAHO8MDDqLlQGKiMrG1ga0MAebCC1u8QBjkaBmldpbnWi/gTyOM7Zn2PssHXJ9Jq
         E0e1KQDX5V232TSyF/ScxJ6AuWOlnsnMWKsptfDrcGdwA1PwJl0VZP4g80k8X/GBHFBs
         lRlExDuuzWZLjYEOnTZRTDrjUodr+IgO9uQqfXHsJV75qQudRMG2/QCD8sZLNq0xQmEX
         DSMg==
X-Forwarded-Encrypted: i=1; AJvYcCVmPyJpTyuHeMJB/dlD/q0tmziZEWI6qXcmAmu0gBZi270w2V3lLAepGB8d5/ZMO8he50oY7fs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyXe6DirIXCG0sDeLjeFbXIv072y5F2E8e9zmPI/o9KTCMB/Bj
	jAqtxfdikbT6zocf2dSyWLmKzi9Z+KGdGLp0GrgnHsVyEEuqQbA7Nzuw56lvlbRHBBs9+V5Kyub
	ecsOCTQ==
X-Google-Smtp-Source: AGHT+IEJMb0ZmvksR4COBHZqXiP7tE9JuIPcnR5oiaXvoL19IqL5V1QRPcjHRCuU+i31xkfihBjXX09nyPlC
X-Received: from pfvf11.prod.google.com ([2002:a05:6a00:1acb:b0:739:485f:c33e])
 (user=brianvv job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:1085:b0:1f5:5b2a:f641
 with SMTP id adf61e73a8af0-2045b986d2amr4582036637.28.1745603681950; Fri, 25
 Apr 2025 10:54:41 -0700 (PDT)
Date: Fri, 25 Apr 2025 17:54:26 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.850.g28803427d3-goog
Message-ID: <20250425175426.3353069-1-brianvv@google.com>
Subject: [iwl-next PATCH] idpf: fix a race in txq wakeup
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

Luckly netif_subqueue_maybe_stop macro already allows you to use a
function to evaluate the start/stop conditions so the fix only requires
to pass the right helper function to evaluate all the conditions at once.

The patch removes idpf_tx_maybe_stop_common since it's no longer needed
and instead adjusts separetely the conditions for singleq and splitq.

Note that idpf_rx_buf_hw_update doesn't need to check for resources
since that will be covered in idpf_tx_splitq_frame.

To reproduce:

Reduce the threshold for pending completions to increase the chances of
hitting this pause by locally changing the kernel:

drivers/net/ethernet/intel/idpf/idpf_txrx.h

-#define IDPF_TX_COMPLQ_OVERFLOW_THRESH(txcq)   ((txcq)->desc_count >> 1)
+#define IDPF_TX_COMPLQ_OVERFLOW_THRESH(txcq)   ((txcq)->desc_count >> 4)

Use pktgen to force the host to push small pkts very aggresively:

./pktgen_sample02_multiqueue.sh -i eth1 -s 100 -6 -d $IP -m $MAC \
  -p 10000-10000 -t 16 -n 0 -v -x -c 64

Signed-off-by: Josh Hay <joshua.a.hay@intel.com>
Signed-off-by: Brian Vazquez <brianvv@google.com>
Signed-off-by: Luigi Rizzo <lrizzo@google.com>
---
 .../ethernet/intel/idpf/idpf_singleq_txrx.c   |  9 ++--
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   | 44 +++++++------------
 drivers/net/ethernet/intel/idpf/idpf_txrx.h   |  8 ----
 3 files changed, 21 insertions(+), 40 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c
index c6b927fa9979..fb85270c69d6 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c
@@ -364,15 +364,16 @@ netdev_tx_t idpf_tx_singleq_frame(struct sk_buff *skb,
 	struct idpf_tx_buf *first;
 	unsigned int count;
 	__be16 protocol;
-	int csum, tso;
+	int csum, tso, needed;
 
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
index 970fa9e5c39b..cb41b6fcf03f 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -2184,6 +2184,19 @@ void idpf_tx_splitq_build_flow_desc(union idpf_tx_flex_desc *desc,
 	desc->flow.qw1.compl_tag = cpu_to_le16(params->compl_tag);
 }
 
+/* Global conditions to tell whether the txq (and related resources)
+ * has room to allow the use of "size" descriptors.
+ */
+static inline int txq_has_room(struct idpf_tx_queue *tx_q, u32 size)
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
@@ -2194,29 +2207,10 @@ void idpf_tx_splitq_build_flow_desc(union idpf_tx_flex_desc *desc,
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
+				      txq_has_room(tx_q, descs_needed), 1, 1))
+		return 0;
 
-out:
 	u64_stats_update_begin(&tx_q->stats_sync);
 	u64_stats_inc(&tx_q->q_stats.q_busy);
 	u64_stats_update_end(&tx_q->stats_sync);
@@ -2242,12 +2236,6 @@ void idpf_tx_buf_hw_update(struct idpf_tx_queue *tx_q, u32 val,
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
2.49.0.850.g28803427d3-goog



Return-Path: <netdev+bounces-232389-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 75854C053C1
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 11:05:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id ACA47351AB1
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 09:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 051663090C2;
	Fri, 24 Oct 2025 09:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j5xO8y7U"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BAB615665C
	for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 09:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761296721; cv=none; b=N/BadmnJf2YGeyeAYRmjfgszPRI+p1KNgQr7PL688Kuda9xL6MPQfK0KPBUANB15i1smGRAGvyzKgKiFhYRlXTRy3zRAxIkLvZsl5/CQ2uIdrYTq4i5UmE3f1u3CIVj1Cdy4ctNaSONHczQudeGrkYRoFWy8KOm0cFYKpoyZARk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761296721; c=relaxed/simple;
	bh=5K97SsUnEfqdFwytsKvj2De1R9KsXAx82CNF2Zgpzps=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=mPYzGEi405ZHGjNLLmejhsagICbxinle4F4k4/n000a5uCy9Eu0rpzMasP5HzsaAuYHtbUa3S93EazW95YJ6NqLZSBcUxc4SPtOpwvglioWCdQNt+mFTxqcggXkqakTPHuUxFlnvRJQTF8uvE+WDZFAtbu0J0ysHEFUoUTWtJ1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j5xO8y7U; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-86df46fa013so454536085a.2
        for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 02:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761296719; x=1761901519; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Fi5G9FDzNAyP7VCBLqTHNVcA0dfjoCrd2yNKOk994Bg=;
        b=j5xO8y7UBBeSNzi1Hw+49pbCPAPxFax/qkEt4VUdAT5ehYN5TLT10F5JjIodAdQb89
         eGX1uOBr+AxGeeaTabzG4Y2h7XLaxeZtl6FDh86LzL/3zAqo+TpbU5LarjzLJbVoZ4Lx
         9uBAaXaAp9Wn66UWwJhB+m6DrF8joGDLEhI5LHZkEzE92P5R4fApqlDG7hxSdF44eRe+
         jlAbTsRir+4O1fa0JqFEqfIrQz/kq/bRLA1ydzAnqG5HTEIf9LLi5mQjtY6dep3MBIGd
         2ubzCaTwbhN2aOgc4bqOpbCxgxiMwBaCL2CBMNSHaKIXJeahW2NLbvnj2IXQwuRst0gl
         auvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761296719; x=1761901519;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Fi5G9FDzNAyP7VCBLqTHNVcA0dfjoCrd2yNKOk994Bg=;
        b=OQgK4Bz/KcvvvYEpBUQiP9MRga0kFvU3C1Z72AA53SPAYUhhcXuzHBfm36x8FfNUCk
         NOx3ezz/gsLbySvy+kHRzSbTuL80bqXe4s1so4GSt6KbaAgMeX+jz2kn8awXaRB+iBqr
         UppRRH8DFAy6Nf3BFMUqDVSGQmOPdSDTyi2mD55taIcIz5gSP/22RU0tnJtGjXPuXzLr
         4F6Lts0cTSFEpMsSuSii5VuuFUAq0MhsBxLOPh13741hUYuYAI+6sTUDOcf9WlFbDnRB
         odWNt5ug7gcxxhamYMtiaQv75LvQ3kumYUx8KW8FlUKv12becVS5B/Jk5K62q8TYZrCN
         V0Bg==
X-Forwarded-Encrypted: i=1; AJvYcCUVTWSolBDShnmsmBekejAfL1PXe8MtXJOERECPNpDLb/A4dQt1AXmS0GYdsaFT1onY+MD3Tzk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwK/sVL4RleUAhhztXV9Pi1Ydiz2P23ZcbgMJNYe47jxSaifwX4
	Qv34rUbHher5MlPgXWtS7StPDPOXI/nTDHbT2o0ScaiAJOp323CCqqezcNwgnW0PFbbcxTVNHvF
	0Oi33PsXRuZzJXQ==
X-Google-Smtp-Source: AGHT+IFkBKQ1xhiu+J4ssdntf1LjBo4P0/7iB1Ky1RIeCz/7Y7wNoAFINU+j75Qk9kVluIq2rAIJ6gX8OqLeHw==
X-Received: from qkat25.prod.google.com ([2002:a05:620a:ac19:b0:891:cf96:c9c3])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:1790:b0:82b:2bad:ba33 with SMTP id af79cd13be357-89c0f701d5dmr604113885a.2.1761296719108;
 Fri, 24 Oct 2025 02:05:19 -0700 (PDT)
Date: Fri, 24 Oct 2025 09:05:17 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.1.821.gb6fe4d2222-goog
Message-ID: <20251024090517.3289181-1-edumazet@google.com>
Subject: [PATCH net-next] net: optimize enqueue_to_backlog() for the fast path
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>, 
	Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"

Add likely() and unlikely() clauses for the common cases:

Device is running.
Queue is not full.
Queue is less than half capacity.

Add max_backlog parameter to skb_flow_limit() to avoid
a second READ_ONCE(net_hotdata.max_backlog).

skb_flow_limit() does not need the backlog_lock protection,
and can be called before we acquire the lock, for even better
resistance to attacks.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Willem de Bruijn <willemb@google.com>
---
 net/core/dev.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 378c2d010faf251ffd874ebf0cc3dd6968eee447..d32f0b0c03bbd069d3651f5a6b772c8029baf96c 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -5249,14 +5249,15 @@ void kick_defer_list_purge(unsigned int cpu)
 int netdev_flow_limit_table_len __read_mostly = (1 << 12);
 #endif
 
-static bool skb_flow_limit(struct sk_buff *skb, unsigned int qlen)
+static bool skb_flow_limit(struct sk_buff *skb, unsigned int qlen,
+			   int max_backlog)
 {
 #ifdef CONFIG_NET_FLOW_LIMIT
-	struct sd_flow_limit *fl;
-	struct softnet_data *sd;
 	unsigned int old_flow, new_flow;
+	const struct softnet_data *sd;
+	struct sd_flow_limit *fl;
 
-	if (qlen < (READ_ONCE(net_hotdata.max_backlog) >> 1))
+	if (likely(qlen < (max_backlog >> 1)))
 		return false;
 
 	sd = this_cpu_ptr(&softnet_data);
@@ -5301,19 +5302,19 @@ static int enqueue_to_backlog(struct sk_buff *skb, int cpu,
 	u32 tail;
 
 	reason = SKB_DROP_REASON_DEV_READY;
-	if (!netif_running(skb->dev))
+	if (unlikely(!netif_running(skb->dev)))
 		goto bad_dev;
 
-	reason = SKB_DROP_REASON_CPU_BACKLOG;
 	sd = &per_cpu(softnet_data, cpu);
 
 	qlen = skb_queue_len_lockless(&sd->input_pkt_queue);
 	max_backlog = READ_ONCE(net_hotdata.max_backlog);
-	if (unlikely(qlen > max_backlog))
+	if (unlikely(qlen > max_backlog) ||
+	    skb_flow_limit(skb, qlen, max_backlog))
 		goto cpu_backlog_drop;
 	backlog_lock_irq_save(sd, &flags);
 	qlen = skb_queue_len(&sd->input_pkt_queue);
-	if (qlen <= max_backlog && !skb_flow_limit(skb, qlen)) {
+	if (likely(qlen <= max_backlog)) {
 		if (!qlen) {
 			/* Schedule NAPI for backlog device. We can use
 			 * non atomic operation as we own the queue lock.
@@ -5334,6 +5335,7 @@ static int enqueue_to_backlog(struct sk_buff *skb, int cpu,
 	backlog_unlock_irq_restore(sd, &flags);
 
 cpu_backlog_drop:
+	reason = SKB_DROP_REASON_CPU_BACKLOG;
 	numa_drop_add(&sd->drop_counters, 1);
 bad_dev:
 	dev_core_stats_rx_dropped_inc(skb->dev);
-- 
2.51.1.821.gb6fe4d2222-goog



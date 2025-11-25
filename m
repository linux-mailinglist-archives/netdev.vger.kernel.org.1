Return-Path: <netdev+bounces-241659-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1FC6C87486
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 23:02:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 729A63B13D6
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 22:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6D802EA72A;
	Tue, 25 Nov 2025 22:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="cGGY1MOP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0F936D501
	for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 22:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764108145; cv=none; b=Sl3T2xT8cWtG/g7UGwScv4VHv5l1hOjRT5cB3I9UDRDT57SXrG7dldSWpun6525lCNZs2rqOXQ6R60MWiR0pZDPeN0xAubk6r7K3nU80v3v5uOVTyLDoNFn0/M4BNb0qxj6O7PlySjYu7vwrx1js3lkvDdI4R9/CV5UuF8vU86c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764108145; c=relaxed/simple;
	bh=zqrE9jq0fqp+tonHuWzTGg+7mEZnYEZW3rpe3GaQ0X0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ngxqmy1Yb8W+VsP6CY4SwfCcJDztlCAiPIAL//P+cNHaXth6nHB6a/hwCij1dna6KlhG1ndJrZCsdIhIvFOk5uZiQbYeXRgxFBm2e4RvvfNWPmFCPrkL4JgUrD1K8sH+jK1FlgcJYL3q8QEAsFUgXx98++18hoqVNJLLVRWU7DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=cGGY1MOP; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-297d4a56f97so89510885ad.1
        for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 14:02:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1764108143; x=1764712943; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bbjOw0QyNolsfOkG4RyjWMHnOdINMrcNSgfM++GjW2A=;
        b=cGGY1MOPfqMGml9i3xC1x72VkyDdcKD++BOHh132pcnVFbbW1a+8GYMXTodXAbZfqZ
         Ai0CJ0Ym6ah5L9eiglPWV6kOHfhyyG5M5eppN1Pa/hqdd+HsEZxjuZuJ/U1B/JfrOnPd
         pxtKXiVLsowRhTE2Pk/vbrDZ5d58qRlnMgR5KJvltp2yAPH1QJeWvYKpbXMIVqI98i+o
         9zYzLwD+nPFFx9ZsrVNDZFMocYXdk0Sc4A+8wW8JTeadzxqjkFI7WLM90YEjx+VW9RUl
         Wjq7xjtxytxXy0v9hFolE7y+cqJJe57xNJBNfwJkn9CBJEVo+OEIBYlY18NvtvPhXElq
         7sjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764108143; x=1764712943;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bbjOw0QyNolsfOkG4RyjWMHnOdINMrcNSgfM++GjW2A=;
        b=u1NhD+NRLwNiq1JrqfPFEIfgVCXfx6JfSEAfAuWkgBTmGbmWY6lFq99yZ/wEh59htf
         2cmXGRtmP1QTTPmktiNBJ0hPnIAmcFSdoX3HjSEgJCEz++eotFW6PXC8tjQn7BE8/WmW
         Xo3/LSKAgwLOcfsQMYZuPR9Oy+B3IAk4wj1uet/7VqrfCln8rp5BRBIOb+LZ++OZ3DkL
         CBsIqTgjiet6lHhemzYSVKrGQOhoX02Ig5pswYalTQcNsa0NGovss/W/477WcBYgZWW1
         YlsviF8azymLLoJt3DLU5ZR+5VeB0OFnNxe8TDZptL64vsyw+PdCuD/4Y9hn0WIfDFx8
         56Vg==
X-Gm-Message-State: AOJu0Yypa8dIEYkfAKFheT0D8f0UFKbH0TUJU1iNfevLCsQtpziRcrW5
	QjLXDoidZTMcsXEgi9r4i07lk4kgMd9jD4A+owSdyfEFoLi9MjsncKyohI6r1LNfqA==
X-Gm-Gg: ASbGnctPVYYd4QI8Vb6H22N0T5hrb9eXeo6dBXk7ICtxcoDCw78KNZkZpzEgMdOrm6L
	Fb8avDMJlpiZpKJK4AUOGe9iT7LG+hXfOvtOrK99b9KJp5bEfu5W7oOvm9T7Fl+DKcnmPzB6IJ1
	nn7r04jBX52BFaHAVwgS5HELkdXZIVcY537sJXEiE6/nfQJcJMxGGFKv7rRhwjbfPg+6g0iGUE8
	s+hEql08nN3MyPJFe2pa+2/x2Oyxa0AP/M7KydLiBjl210O71gvbv9R8Y4sjfKkBphe4eTyExJo
	t7T1j4cm3KgG4SqKld9flKmo74arnBBQFclSGwWx4uGXKIBmwbmJYBrtaVILxHKFc/xkP3lnDxU
	bH+gzWN4sepyFWvYDyEGYnUHYq6c2+QQG5z6TTK3vflD/p4Qe6txBuh6smW5Dill6UGff4hAyQh
	37nSQ1wpxtAypBGcSOMVPtaiEVI8W73gQrT5h6PRGv
X-Google-Smtp-Source: AGHT+IHQ8QfOyds6RMKG6tQbZbE7RZlLZK2EFXr+6J25EywxGVspPaJyvoOkCYbUy6tWWXlEhDfJCQ==
X-Received: by 2002:a05:7301:e22:b0:2a4:3594:d534 with SMTP id 5a478bee46e88-2a7195369f7mr11762131eec.1.1764108142950;
        Tue, 25 Nov 2025 14:02:22 -0800 (PST)
Received: from p1.tailc0aff1.ts.net (209-147-139-51.nat.asu.edu. [209.147.139.51])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2a6fc3d0bb6sm93697505eec.2.2025.11.25.14.02.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 14:02:22 -0800 (PST)
From: Xiang Mei <xmei5@asu.edu>
To: security@kernel.org
Cc: netdev@vger.kernel.org,
	toke@toke.dk,
	xiyou.wangcong@gmail.com,
	cake@lists.bufferbloat.net,
	bestswngs@gmail.com,
	Xiang Mei <xmei5@asu.edu>
Subject: [PATCH net v6 1/2] net/sched: sch_cake: Fix incorrect qlen reduction in cake_drop
Date: Tue, 25 Nov 2025 15:02:12 -0700
Message-ID: <20251125220213.3155360-1-xmei5@asu.edu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In cake_drop(), qdisc_tree_reduce_backlog() is used to update the qlen
and backlog of the qdisc hierarchy. Its caller, cake_enqueue(), assumes
that the parent qdisc will enqueue the current packet. However, this
assumption breaks when cake_enqueue() returns NET_XMIT_CN: the parent
qdisc stops enqueuing current packet, leaving the tree qlen/backlog
accounting inconsistent. This mismatch can lead to a NULL dereference
(e.g., when the parent Qdisc is qfq_qdisc).

This patch computes the qlen/backlog delta in a more robust way by
observing the difference before and after the series of cake_drop()
calls, and then compensates the qdisc tree accounting if cake_enqueue()
returns NET_XMIT_CN.

To ensure correct compensation when ACK thinning is enabled, a new
variable is introduced to keep qlen unchanged.

Fixes: 15de71d06a40 ("net/sched: Make cake_enqueue return NET_XMIT_CN when past buffer_limit")
Signed-off-by: Xiang Mei <xmei5@asu.edu>
---
v2: add missing cc
v3: move qdisc_tree_reduce_backlog out of cake_drop
v4: remove redundant variable and handle ack branch correctly
v5: add the PoC as a test case
v6: split test and patch; fix the wrong drop count
---
 net/sched/sch_cake.c | 59 +++++++++++++++++++++++++-------------------
 1 file changed, 33 insertions(+), 26 deletions(-)

diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
index 32bacfc314c2..a64fb6889946 100644
--- a/net/sched/sch_cake.c
+++ b/net/sched/sch_cake.c
@@ -1597,7 +1597,6 @@ static unsigned int cake_drop(struct Qdisc *sch, struct sk_buff **to_free)
 
 	qdisc_drop_reason(skb, sch, to_free, SKB_DROP_REASON_QDISC_OVERLIMIT);
 	sch->q.qlen--;
-	qdisc_tree_reduce_backlog(sch, 1, len);
 
 	cake_heapify(q, 0);
 
@@ -1743,14 +1742,14 @@ static void cake_reconfigure(struct Qdisc *sch);
 static s32 cake_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 			struct sk_buff **to_free)
 {
+	u32 idx, tin, prev_qlen, prev_backlog, drop_id;
 	struct cake_sched_data *q = qdisc_priv(sch);
-	int len = qdisc_pkt_len(skb);
-	int ret;
+	int len = qdisc_pkt_len(skb), ret;
 	struct sk_buff *ack = NULL;
 	ktime_t now = ktime_get();
 	struct cake_tin_data *b;
 	struct cake_flow *flow;
-	u32 idx, tin;
+	bool same_flow = false;
 
 	/* choose flow to insert into */
 	idx = cake_classify(sch, &b, skb, q->flow_mode, &ret);
@@ -1823,6 +1822,8 @@ static s32 cake_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 		consume_skb(skb);
 	} else {
 		/* not splitting */
+		int ack_pkt_len = 0;
+
 		cobalt_set_enqueue_time(skb, now);
 		get_cobalt_cb(skb)->adjusted_len = cake_overhead(q, skb);
 		flow_queue_add(flow, skb);
@@ -1833,13 +1834,13 @@ static s32 cake_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 		if (ack) {
 			b->ack_drops++;
 			sch->qstats.drops++;
-			b->bytes += qdisc_pkt_len(ack);
-			len -= qdisc_pkt_len(ack);
+			ack_pkt_len = qdisc_pkt_len(ack);
+			b->bytes += ack_pkt_len;
 			q->buffer_used += skb->truesize - ack->truesize;
 			if (q->rate_flags & CAKE_FLAG_INGRESS)
 				cake_advance_shaper(q, b, ack, now, true);
 
-			qdisc_tree_reduce_backlog(sch, 1, qdisc_pkt_len(ack));
+			qdisc_tree_reduce_backlog(sch, 1, ack_pkt_len);
 			consume_skb(ack);
 		} else {
 			sch->q.qlen++;
@@ -1848,11 +1849,11 @@ static s32 cake_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 
 		/* stats */
 		b->packets++;
-		b->bytes	    += len;
-		b->backlogs[idx]    += len;
-		b->tin_backlog      += len;
-		sch->qstats.backlog += len;
-		q->avg_window_bytes += len;
+		b->bytes	    += len - ack_pkt_len;
+		b->backlogs[idx]    += len - ack_pkt_len;
+		b->tin_backlog      += len - ack_pkt_len;
+		sch->qstats.backlog += len - ack_pkt_len;
+		q->avg_window_bytes += len - ack_pkt_len;
 	}
 
 	if (q->overflow_timeout)
@@ -1927,24 +1928,30 @@ static s32 cake_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	if (q->buffer_used > q->buffer_max_used)
 		q->buffer_max_used = q->buffer_used;
 
-	if (q->buffer_used > q->buffer_limit) {
-		bool same_flow = false;
-		u32 dropped = 0;
-		u32 drop_id;
+	if (q->buffer_used <= q->buffer_limit)
+		return NET_XMIT_SUCCESS;
 
-		while (q->buffer_used > q->buffer_limit) {
-			dropped++;
-			drop_id = cake_drop(sch, to_free);
+	prev_qlen = sch->q.qlen;
+	prev_backlog = sch->qstats.backlog;
 
-			if ((drop_id >> 16) == tin &&
-			    (drop_id & 0xFFFF) == idx)
-				same_flow = true;
-		}
-		b->drop_overlimit += dropped;
+	while (q->buffer_used > q->buffer_limit) {
+		drop_id = cake_drop(sch, to_free);
+		if ((drop_id >> 16) == tin &&
+		    (drop_id & 0xFFFF) == idx)
+			same_flow = true;
+	}
+
+	/* Compute the droppped qlen and pkt length */
+	prev_qlen -= sch->q.qlen;
+	prev_backlog -= sch->qstats.backlog;
+	b->drop_overlimit += prev_qlen;
 
-		if (same_flow)
-			return NET_XMIT_CN;
+	if (same_flow) {
+		qdisc_tree_reduce_backlog(sch, prev_qlen - 1,
+					  prev_backlog - len);
+		return NET_XMIT_CN;
 	}
+	qdisc_tree_reduce_backlog(sch, prev_qlen, prev_backlog);
 	return NET_XMIT_SUCCESS;
 }
 
-- 
2.43.0



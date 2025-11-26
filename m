Return-Path: <netdev+bounces-242011-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EA3D1C8BAE5
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 20:47:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A38684E644D
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 19:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 256A2340286;
	Wed, 26 Nov 2025 19:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="r2hc/dAj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62DB84A02
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 19:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764186321; cv=none; b=Rby58LBxQeDOC9R/TmqWnLpSZQNBXkQ7FuR5YwnNiOu2kZXV2H3bC+1r7jioy94HK9gtaNsoaF7r2Z2bkXUPprrpfSKBtvDqh9kDqDNXpQFG6V84gu++OMVmaNi+WCmTy3m09V8Ck0+KkoFA2OK4HsbDvROqU617+SjwdabP1GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764186321; c=relaxed/simple;
	bh=2jP+qM2+v5iGC4HrKkBQh+JjJn4g1/u+TzFbgP4AQCw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=An42seF15yXV09Tro3z/zNOnZ1dHAX+obvhfMG9ESknFORFPWCLB3/03VjzyjZqSmn5lEKrDcWnr0+o14354Ma0Px+06HrrIzKGeqIa0J60oRUE1If/WH6w4e6PjYLYLs62Hd/cgYYH4MStVjMHl258psS9vCroUNx1EMwznIFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=r2hc/dAj; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-bb2447d11ceso105471a12.0
        for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 11:45:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1764186318; x=1764791118; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WtEsv1qnprkRz63f114HO+3gpWzGkQYPLZ6RpFK2vlo=;
        b=r2hc/dAjhCKgOJwhTEfKSi5auueHtIn9h2wk/HpbonSvgrLtuRX2aJJiUUnuFUJAiR
         gYnWEU2hCHnveKE4lXknObGeJfGlyMORuYctklC6xU1KBmwh+emBTs71UOfIl9vzvwzY
         kdeEPI2gCFD68Oy0nt7VhaQpdR50rvxazYYCDCebbZfihj56aBHezKpnA4yyCtAHzhNq
         1WXBbMazm8ccqL1xjtw9WPF/Lbfa8/XjHs7NDkqjSi538DOH7BKs2MY9znDOo+ybBCtw
         mdE/xKakeTbgUJ14+Xath/fZXvdIYmCVv3HFY5mZpIaZb2jrnl4C3k35J1q/lxpmXdeY
         OoSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764186318; x=1764791118;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WtEsv1qnprkRz63f114HO+3gpWzGkQYPLZ6RpFK2vlo=;
        b=XuRBzh6jxMqFjL8ZF38QJ55LRRITmvHGHCabJ5emSjgnXyic5knKbnN1psiWXXl2JV
         fuop/uwW7Nq6S59asnIA42kcmBqH0BbKtI6wVCK5Xa4lg8gl6BhWyEAI1mtbSF88uuOu
         aE5odjf/5sfi6rNA87RrFywV55cmlBclo2DMeaB5RaEfKV6M4qA/O/aPBpfjeTgfKXop
         rWiVUt8ySYLCb6TFVbkB/QY9dltygZwutSE3MeGzf3D9js3i60PsdnrUlR/4LlyeXGKq
         +m4r+mjU9+HilWthfaTXuno34YKtnsr6TGLDoIATWvoY5/5+h/XUnvRt05xFzmPtUJtE
         FmBQ==
X-Gm-Message-State: AOJu0YzPzl9hwySKLy+s5+7cWMUIcliSkpKHFfIl6zbCDB97b025laax
	rCuZKvObCpChypOW8Zmu1vOHyTghxNLgw7dGtQDDBS9vRuXJv1Fa2QRVANXnwra4YA==
X-Gm-Gg: ASbGncs227/QyalcWgWs3AaBo+yS3wQcErtp5uIxsEqEitZouTHskMnCJLuuaUCB1KE
	0oUwQaemB8h0P/kouIYVobwHJpOeK8TH/2MdfLM8y+F/XJUpUiiq0C2APlMsFjKY7mFYtWC1jAt
	vFbtvMeTv7ML43WNZzIkHFz1tnluO+8Usaf7032sOMYzvHJdZY+WUVmAQ93/PmCfIzG3lFOjySM
	cNQIjA0GtAWkfsX2PNOQYTZ18I4ck45w57JrfELwlT1jzzbBmxQlB7iJiXI8hoFhE657QA2QZ7U
	INbMdovbE2/DKqjGTYcQ39hwRpM7IxnzoppUnlcf3SX2Hes/2qx25DMhMbGWnZR2iE+KH25zAqh
	4Gc4bvrfCj5s1g7vo2UXHsS+KpbYPXDBrMtyySdUn20eSOKfKPfX3Ri6cZQ9U5uvVXghhs3OtnA
	WIa1Mp+wjbWevNB3zWNmXPNfZ4gnI33zbw5MkjyAEe
X-Google-Smtp-Source: AGHT+IFLLj/qsp3TdZVuBhvSHTdhyYnHycOPM+V5xxsYu8sfMBuLLU7iSV/CB0c2g/DZ7EeufYy0Pg==
X-Received: by 2002:a05:7300:3c9d:b0:2a4:3592:c604 with SMTP id 5a478bee46e88-2a94174e0a3mr4277965eec.21.1764186318491;
        Wed, 26 Nov 2025 11:45:18 -0800 (PST)
Received: from p1.tailc0aff1.ts.net (209-147-139-51.nat.asu.edu. [209.147.139.51])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2a93c5562b2sm24252446eec.3.2025.11.26.11.45.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 11:45:18 -0800 (PST)
From: Xiang Mei <xmei5@asu.edu>
To: security@kernel.org
Cc: netdev@vger.kernel.org,
	toke@toke.dk,
	xiyou.wangcong@gmail.com,
	cake@lists.bufferbloat.net,
	bestswngs@gmail.com,
	Xiang Mei <xmei5@asu.edu>
Subject: [PATCH net v7 1/2] net/sched: sch_cake: Fix incorrect qlen reduction in cake_drop
Date: Wed, 26 Nov 2025 12:45:12 -0700
Message-ID: <20251126194513.3984722-1-xmei5@asu.edu>
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
v7: remove redundant comments
---
 net/sched/sch_cake.c | 58 ++++++++++++++++++++++++--------------------
 1 file changed, 32 insertions(+), 26 deletions(-)

diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
index 32bacfc314c2..d325a90cde9e 100644
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
@@ -1927,24 +1928,29 @@ static s32 cake_enqueue(struct sk_buff *skb, struct Qdisc *sch,
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



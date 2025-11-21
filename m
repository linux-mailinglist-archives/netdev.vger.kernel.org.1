Return-Path: <netdev+bounces-240895-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 25877C7BD7E
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 23:22:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1352635FCAC
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 22:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 674D730ACFD;
	Fri, 21 Nov 2025 22:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="WFSUgzjT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2383064A1
	for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 22:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763763608; cv=none; b=kCiZfGVi5I7DXzEc9dV4PgQ2POVpQS1//ySmHfdJsV5j1Bu4itW73NP4b2Vh7k28NK7nctVMMCzUnQVa5nS8/vbDEpuvuI77ZVRyFe9NQLxWTrazRkQ/goqB18KNm76Dud5Oc6t5AgLablNz5NrP/YQnVTS2C7+PwHctWHAQae4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763763608; c=relaxed/simple;
	bh=g3Ql5JAp7mptlUZp2JDv6dBIgd/skiR01YPR0iGeJP8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Zm5FIHpSlpW6c8DmQJv1pU8HNhv5ZmymQZ5SbK68OQ9tXczns9DaMe5cObHaODguMhqLohmkHjPzVXXfnzHg09Joa7mC48aFdLptlJu7G7U2MF0V1XLaDoZViIP2j7S3l3kNAduBlwtK3agbPbiFbF51rMTM9GggVHDjukUScz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=WFSUgzjT; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7b89c1ce9easo2873282b3a.2
        for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 14:20:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1763763602; x=1764368402; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4sUVNth8FAZgtbCcjfYNARaKtvymY9NltD2v12K6L98=;
        b=WFSUgzjTTlvjvGjHwRI0MSYL85x5HyYfe7zrEaOEuOhQ/oz1RdDq7nGSlpjR3C3HTt
         M3QCWT8qJ9aKjaE/5qn2Hq+8jVigTxgkxnxVukbksM7p1S9iqyioe/a3Ro+onjJX+NNf
         Kqs6nbLHGM9vEX3dFmn2LNOtckfTTe1s7ovzLWWez07jy3X02k1VWioTXnMU9fhdFrHG
         rbdIdWSm9ptNGNp5iirCslcN8GL9b77KPTJKOxxMflHw8HwDFSC7QvYtjzS4KVanP7ox
         XS7sJprD3WXTtpDDUkMHGpOF29l27wBJ0W4Ean+/pXdHMvWj9Hc5nJd0ud7NVDiPnHAO
         o2FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763763602; x=1764368402;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4sUVNth8FAZgtbCcjfYNARaKtvymY9NltD2v12K6L98=;
        b=FBcoE8q5tE229tFz8XAoNYt4f9PCzhk855NqsynuFAuWGgHXjIB2qhr9xEEXh0y/U0
         E4NJr2yxpbZeZjza85x/acWsQ+3FGNVKYdAWhii46/f4xP64mydGMn1Tn0bVN3WWWC4X
         I0uUVSa2E2qwSIbBoI7IFeqNhqaYpC2VXNH3GBRsoLjEx9HNUao1BLIN1FW/8B+X3DTd
         D17Dvn33SekewOGy0g3CtICU5JGNyFzn/gVfn3IRN/fVqwPGvnAczYFOZp0kZpbLoPHr
         pTDLtrBcGCMtURhjdVeB2fisb5PmQQEQ13VDSeZYh4EY7g5HvqdHKOX6oz+sCpOEpIgH
         7ciA==
X-Gm-Message-State: AOJu0Yy13T9eIXQRJHlf3emgZD8qfB7OKTBm6JGAsHdv9ag3+7RMGXvc
	nuYqOwBbpOJAY4nbCBMECSO5k2OKRJjjX5EXqLFW4ZO30R2z63GXyEIY7STiL1+jgA==
X-Gm-Gg: ASbGncuem6V5w7mqQ+IMP/4F1wCFAJBq7vF9+MBpiK2QoZIRlyLQ/+DHYBx1HgrpLXH
	QZ88COjNkfR9qheaVevX/4JkLebB40/lg/J/t4loJgENQBqwTAF1NPNJCtYb5dwux3VHcxb0xd+
	qpuruErOo9ueDsJWytde3uLA5fkZqyGPiYKrKHGFu+UqXNyvE8Iki23iqSaqlebxqcAQggjbc1c
	BmWbVQ+wnzmbFld0k7HZSavhQtcITWoA/QqRVSBv8fn64FAw5zFbvp6aVYHeXAaf7RiEtWbTimC
	dSrT5wqCed2xT59wBPMVynKak5k74Gv3Uaq0pvIXHNdUdIQGwtS9pv5sCKSxh3IO7HZ4yeVC8Id
	sfH2NXkkpkZRZqSyJ26g94SYncWt+TDFnU8bbMLoJm0O2UHmFPEPOFU7+k/XJSnw41crrrz/AkC
	w1q1Y3mdNbixArPX7vRpAerBitawNDqEPuOWlonmXQ
X-Google-Smtp-Source: AGHT+IH5VXK3OCSrTYKrEiAE26/rAsGhJzAoRU9EZdpEiwzHCfBWn/O9JUrzanqcZBYu+7tAfYC0ZQ==
X-Received: by 2002:a05:7022:b882:b0:11b:bf3f:5251 with SMTP id a92af1059eb24-11c9d718e3bmr1213422c88.16.1763763601744;
        Fri, 21 Nov 2025 14:20:01 -0800 (PST)
Received: from p1.tailc0aff1.ts.net (209-147-139-51.nat.asu.edu. [209.147.139.51])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11c93de82c1sm20464204c88.3.2025.11.21.14.20.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 14:20:01 -0800 (PST)
From: Xiang Mei <xmei5@asu.edu>
To: security@kernel.org
Cc: netdev@vger.kernel.org,
	toke@toke.dk,
	xiyou.wangcong@gmail.com,
	cake@lists.bufferbloat.net,
	bestswngs@gmail.com,
	Xiang Mei <xmei5@asu.edu>
Subject: [PATCH net v4] net/sched: sch_cake: Fix incorrect qlen reduction in cake_drop
Date: Fri, 21 Nov 2025 15:19:54 -0700
Message-ID: <20251121221954.907033-1-xmei5@asu.edu>
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
---
 net/sched/sch_cake.c | 52 +++++++++++++++++++++++++-------------------
 1 file changed, 30 insertions(+), 22 deletions(-)

diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
index 32bacfc314c2..cf4d6454ca9c 100644
--- a/net/sched/sch_cake.c
+++ b/net/sched/sch_cake.c
@@ -1597,7 +1597,6 @@ static unsigned int cake_drop(struct Qdisc *sch, struct sk_buff **to_free)
 
 	qdisc_drop_reason(skb, sch, to_free, SKB_DROP_REASON_QDISC_OVERLIMIT);
 	sch->q.qlen--;
-	qdisc_tree_reduce_backlog(sch, 1, len);
 
 	cake_heapify(q, 0);
 
@@ -1750,7 +1749,8 @@ static s32 cake_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	ktime_t now = ktime_get();
 	struct cake_tin_data *b;
 	struct cake_flow *flow;
-	u32 idx, tin;
+	u32 idx, tin, prev_qlen, prev_backlog, drop_id;
+	bool same_flow = false;
 
 	/* choose flow to insert into */
 	idx = cake_classify(sch, &b, skb, q->flow_mode, &ret);
@@ -1823,6 +1823,8 @@ static s32 cake_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 		consume_skb(skb);
 	} else {
 		/* not splitting */
+		int ack_pkt_len = 0;
+
 		cobalt_set_enqueue_time(skb, now);
 		get_cobalt_cb(skb)->adjusted_len = cake_overhead(q, skb);
 		flow_queue_add(flow, skb);
@@ -1834,7 +1836,7 @@ static s32 cake_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 			b->ack_drops++;
 			sch->qstats.drops++;
 			b->bytes += qdisc_pkt_len(ack);
-			len -= qdisc_pkt_len(ack);
+			ack_pkt_len = qdisc_pkt_len(ack);
 			q->buffer_used += skb->truesize - ack->truesize;
 			if (q->rate_flags & CAKE_FLAG_INGRESS)
 				cake_advance_shaper(q, b, ack, now, true);
@@ -1848,11 +1850,11 @@ static s32 cake_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 
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
@@ -1927,24 +1929,30 @@ static s32 cake_enqueue(struct sk_buff *skb, struct Qdisc *sch,
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
+	b->drop_overlimit += prev_backlog;
 
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



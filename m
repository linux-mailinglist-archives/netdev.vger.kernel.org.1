Return-Path: <netdev+bounces-242432-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24268C90638
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 01:14:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5A253A95E5
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 00:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54AA62F85B;
	Fri, 28 Nov 2025 00:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="YWPeDVth"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812302AD13
	for <netdev@vger.kernel.org>; Fri, 28 Nov 2025 00:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764288870; cv=none; b=qBsYBglDGh0pRANE2TPnTM7fZdAJCIPB9CdIIxya965QS5xQGh7XvOgtUJSVVaQrLijAzCNfcduwC2TyUSAgds87q0DNW4SbKfLvVYjeFjB8rixtLRa4i8eUkTlB6e6XY7R2MurNkAK6RTp5EjkOENLJipKh2tk8MEpinH9cNkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764288870; c=relaxed/simple;
	bh=v5i/EmFaBPgs6nlSq7GL06zXBoB1G+7bxvYfuktyJ/w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ja4W+3e/+apb4B3EAWCqp5QSah/LZBkCN2kK/K4C6lvjjVBTuOFblwtKlHTj5sILIZA1Nd6t+P/MZtr/qY44o5o65uAaIKlHVWZisHz8FmvNnswPRaCvgXxO5zJE8TY/NI4pG3qqRXw7s+tA3Lyt+2SfF8LMh6xrbYqcKJsGb+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=YWPeDVth; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-bc2abdcfc6fso792130a12.2
        for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 16:14:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1764288868; x=1764893668; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HTp1SGwTKk2hZyC3Yj3TH2Fee95cP69A2MpxOAn+dMw=;
        b=YWPeDVthg4uxGKLPwqyrwHwNAUOIRzSHNndZR0PefU4nW6htsLrbJeXusM3g9oxWC7
         Z9F/HayabEvpfH53EzOrmDXGbeyhykRiW8GWbONUEFx9Vkzg4bdBGTCTiiBFGU7XgI5e
         uwTmwONKgPArMqa4v3QFTPOo2ZD0gKL+98sGhwaMCRwUqmhbGzWc0SJNBPvthXZSVO+o
         A/35JTPkAhoGbhNig/3cBuyHBrTlOJnZVU2hjDwdlzHkPdmScKpuzW2Y349xi3FrBG0G
         ktnqt6JONZx6RmjzbYvOw0mWzx7e4xLT6LiIk/1m2IM7ZvWV7uqxPSPSqJ8ekTRFeTK/
         RtEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764288868; x=1764893668;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HTp1SGwTKk2hZyC3Yj3TH2Fee95cP69A2MpxOAn+dMw=;
        b=NkIU4Gxxv+Wlx/WmWQGkkBTODl5RKZiENXUMWLIDuXhGMlINWNkIg6/yBqYJwzuKFp
         Uh7x4lu8TUjxdd1iVDhgt15X5hpCyOeQwjTngVjoULKWigP03+muH/cGR2BVCVqyxLPQ
         JVvXZH2L8CchsnHV5NbMhytI8ZzGRfgOepi5tkAuN8F4JEEzpMyD2oCQz4RcFX/KfK3W
         qnuojzCiDKPb9WP3EHRfJ5mnHdJxuMXRdz3Haz+Pvh4jnv/eXF/H4a+2urjd1W9zsdSI
         f91R+URCkDLFlPWWc68BF5h3e6F6Ppc9Um+DqmPy7ynF6YU/9lKVBRSwtrTFNXBlDbi7
         3upQ==
X-Gm-Message-State: AOJu0YzadOiraclJcep60g/Yy/KlViY1dWfQt+cmx4LuQAeorFrBdPfR
	rL3Jd/FssUIeHb+djbhrW63XCqR/iXw+l2HI/bWWaRZ81qgMFuUaHn8Cdrt+cFKivLVfEtd3sDj
	8QpU=
X-Gm-Gg: ASbGncueFFFbIbqE32aQbZ/uY29F6bY4e44j+HUlOJxHI4pdvvjASIzQyJZ9sI1A+i9
	zG1WFfFmh3D0m60WtOX68YsO9lx4MECFackLfdxGRIDVCxSOKJJVyrTMDRwdjnebwkKE4WvhCFY
	x2TlV/l4RskMJlr9VhsYPzNEl4Ka3rmtRLRN8Pi2+7XrzTFJeuO4amagUSuvbBLYPfvCECVttCW
	NdD1w28rh+ICruJFiWpMeftr5oGCe0erA9ndDcR0Z/rI874EOY2/+WuneGLCsFY105a4byMT0PF
	WESbHjVzpQlHNm0e2RMm7oC+KP8/MfJSoVvmds4BK7arPXyf95zS0gLjva64sOzUOgwU6dNAcwv
	b12elpevmjxY3EhtD2agqxSh6vPwYHZzN1oaAGhR0yw6XVv6Zco5qU/C0Ha4jQthzYFzFqEAYSd
	hDRf0IrSmyCQWE2c7X9fLHgh3MHoIQ3dS6kFbKc422
X-Google-Smtp-Source: AGHT+IGMHEUfgIYw2AAmbDPAgqMQw4zD5YxfPYyEm1HQvDzWLdelfQlnl64DN5ws3BlZ+HRBPf6ZEQ==
X-Received: by 2002:a05:7300:570d:b0:2a4:5c3b:e2bc with SMTP id 5a478bee46e88-2a719d80133mr14284109eec.19.1764288867608;
        Thu, 27 Nov 2025 16:14:27 -0800 (PST)
Received: from p1.tailc0aff1.ts.net (209-147-139-51.nat.asu.edu. [209.147.139.51])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2a965ae9d06sm11209080eec.4.2025.11.27.16.14.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Nov 2025 16:14:26 -0800 (PST)
From: Xiang Mei <xmei5@asu.edu>
To: security@kernel.org
Cc: netdev@vger.kernel.org,
	toke@toke.dk,
	xiyou.wangcong@gmail.com,
	cake@lists.bufferbloat.net,
	bestswngs@gmail.com,
	Xiang Mei <xmei5@asu.edu>
Subject: [PATCH net v8 1/2] net/sched: sch_cake: Fix incorrect qlen reduction in cake_drop
Date: Thu, 27 Nov 2025 17:14:14 -0700
Message-ID: <20251128001415.377823-1-xmei5@asu.edu>
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
v8: no change
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



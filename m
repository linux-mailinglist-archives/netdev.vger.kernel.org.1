Return-Path: <netdev+bounces-240908-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3733CC7BF12
	for <lists+netdev@lfdr.de>; Sat, 22 Nov 2025 00:28:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 01E0D4E1724
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 23:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8916630BF59;
	Fri, 21 Nov 2025 23:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="jSSqjGe/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE142EDD7E
	for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 23:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763767687; cv=none; b=T2XIyPc3e6eQekvwt7n/k42rrMQ6w9q3M5GTDwwijci92g1q/E9T0hS4XzoO1gZWdq2uVGETxWkXRhyJ26CJHZLaIGclI6uv6gpeqzEPCvCApicyNXMQoRSce6i6eZSH4WLR7fPzjLkXNCocmY6zuYfx0mlkGjHQNGG9eh4Rbr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763767687; c=relaxed/simple;
	bh=4x0yFS1G6/qQ3vA1WwHwNq63xJUDTisqyZbFdhGku4A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=chPtfLX5mfJsZlDe9ZkXn2YViLQTe75fVCWOHhIsPhzChCjNC8MJBb1fSxTWFtyz6du0Drh/RF+P1+v7ecbSTjXRcupNihtxMk616sixq9P5g5m5IBh8xinkc+1sVpswEu6nMK0ICbyCeH5L5WAsvjQD5y7GrYhmotxcxO4HNfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=jSSqjGe/; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7b852bb31d9so3062751b3a.0
        for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 15:27:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1763767675; x=1764372475; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ACQddHZcDaCDM4L+eMLnqjgNPpNjJRnV3lGXdOduM+A=;
        b=jSSqjGe/ypLpA69qXopBxdT/P8G2ic2dbIBix4tQJ2kdJXAuGnGJjRlUcygn1oqRM1
         r8eXcQzH4Waz5RfZ0tOThotAg/Nzro7afoU5gFiUMEfmsQ6C0exLctML/2RhPJNZXhhL
         lJoBA3c2RQDAGXPAetvesLZ+M9C/qxLYn6O3O+KTVlmnwRGzp8+giPcVQJL43wKoMih3
         BUuOkni+p88W/nwrIFMB/qDfS42UR9CDsFid7LvMr2XOYzWqxFG8Rjr/FKGzhbb8qTjM
         qqVGvp0uYrT2LpM9d7QBD806Gq3qQrUqKx82zPGvuxXOgHi2o0pwRMfL1YIjbRS89zKr
         BH8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763767675; x=1764372475;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ACQddHZcDaCDM4L+eMLnqjgNPpNjJRnV3lGXdOduM+A=;
        b=wYI0aFddKovSuwGLmzroZU+kv19mvgJ56R0AeY+i8srNSBHXrcUm3mcDwbsF+o7yJv
         Vgueri1Hj25smYLRE41ajjFbbV5uQWupZhiR+4SvAebvfpq7wewLFsw97lRQyG/AoxuE
         0oqbW4LFIHwrgf4HxrIJf0yqg8L4Pnm8RrkCsNIg0VHtmhwYzF2xlX3HQb1A8wgBF4UT
         7kJ5nOuP4Ol05tE2T9+s7tJL7XLbnHli5JZ8OIimGUTgKMDJ0SqMWetQGPLx6fr/q8BD
         RBQiZHZeSeleoo0YJwc4zSBN09vMvmNAtcMW99h2nMK9v2Gqe35E1A7EoFi7HqW8eSV9
         zLZA==
X-Gm-Message-State: AOJu0YytpyQjHQUVSaQ8U2ISE2HCY3hGV/i9CynYStulDnP8N06Pp87d
	0MsfbHZ2dKuiXeaix4fvCM9iI+1HTB4ein1q7mShxCbq8r2dwQ/W8ceUfj+dVGQsKA==
X-Gm-Gg: ASbGncv3+jQV3DTS6Hkrt5xHCw//Ymj3YpHMBJilLXA6JWiVKRr30b/EmQcXeJnXMkj
	pMzenv/Z8pGPDKDHN9U4fG0YgVjrUK21/JG+qiD5O4J7DmCwqQIHWR/d53SB/NRA06zvX0qfauA
	UMyIBpPq4d0WJCFFcwCZW0G+1PAA+ZBkMu5MTJTpafxSXLT+VG3u8Uu+5lqVt2hnc5Yx5oyU58D
	GPQHZhAUAWkgg/zCkC8ZZCeJ1LuijTEzL9KFHH+7ofzgSccXvDaPDE5p7Jgr/G12qKMjyqGP6Jr
	EO8il/qMf9lf40aSnMPQnCPJqOrkk3Cl8uRrBbeDxV3bgx5MGe7RMdF1XjOrt0wQWZaLymbBy8L
	/Ni0xnzc9aHHRYDYxMjf3SpR5YpKR9qy5RmUy/DWaD4KS5i+kBqfaYO55KdWCnMj9oiTQO79Puc
	KnGDWyTL53wTSmhaVUEUON+ZAYO6nF/i9F6ByVJ3kU
X-Google-Smtp-Source: AGHT+IFmqosMYWpJDWj3TYGKEUWHYx3dE5wLEGG4lzl9FC1I9zK9qz+rYoFclwit74bSZLRBFroScQ==
X-Received: by 2002:a05:7022:412:b0:11a:4ffb:9849 with SMTP id a92af1059eb24-11c9d811985mr1925590c88.21.1763767675380;
        Fri, 21 Nov 2025 15:27:55 -0800 (PST)
Received: from p1.tailc0aff1.ts.net (209-147-139-51.nat.asu.edu. [209.147.139.51])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11c93e6dbc8sm30222906c88.10.2025.11.21.15.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 15:27:54 -0800 (PST)
From: Xiang Mei <xmei5@asu.edu>
To: security@kernel.org
Cc: netdev@vger.kernel.org,
	toke@toke.dk,
	xiyou.wangcong@gmail.com,
	cake@lists.bufferbloat.net,
	bestswngs@gmail.com,
	Xiang Mei <xmei5@asu.edu>
Subject: [PATCH net v5] net/sched: sch_cake: Fix incorrect qlen reduction in cake_drop
Date: Fri, 21 Nov 2025 16:27:35 -0700
Message-ID: <20251121232735.1020046-1-xmei5@asu.edu>
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
---
 net/sched/sch_cake.c                          | 52 +++++++++++--------
 .../tc-testing/tc-tests/qdiscs/cake.json      | 28 ++++++++++
 2 files changed, 58 insertions(+), 22 deletions(-)

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
 
diff --git a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/cake.json b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/cake.json
index c4c5f7ba0e0f..47ecd3fb1ea4 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/cake.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/cake.json
@@ -441,5 +441,33 @@
         "teardown": [
             "$TC qdisc del dev $DUMMY handle 1: root"
         ]
+    },
+    {
+	"id": "4366",
+	"name": "Enqueue CAKE with packets dropping",
+	"category": [
+	    "qdisc",
+	    "cake",
+	    "netem"
+	],
+	"plugins": {
+	    "requires": "nsPlugin"
+	},
+	"setup":[
+	    "$TC qdisc add dev $DUMMY handle 1: root qfq",
+	    "$TC class add dev $DUMMY parent 1: classid 1:1 qfq maxpkt 1024",
+	    "$TC qdisc add dev $DUMMY parent 1:1 handle 2: cake memlimit 9",
+	    "$TC filter add dev $DUMMY protocol ip parent 1: prio 1 u32 match ip protocol 1 0xff flowid 1:1",
+	    "ping -I$DUMMY -f -c1 -s64 -W1 10.10.10.1 || true",
+	    "$TC qdisc replace dev $DUMMY parent 1:1 handle 3: netem delay 0ms"
+	],
+	"cmdUnderTest": "ping -I$DUMMY -f -c1 -s64 -W1 10.10.10.1 || true",
+	"expExitCode": "0",
+	"verifyCmd": "$TC -s qdisc show dev $DUMMY",
+	"matchPattern": "qdisc qfq 1:",
+	"matchCount": "1",
+	"teardown": [
+	    "$TC qdisc del dev $DUMMY handle 1: root"
+	]
     }
 ]
-- 
2.43.0



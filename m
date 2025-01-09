Return-Path: <netdev+bounces-156778-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46B1DA07CFC
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 17:10:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF078188D526
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 16:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80E6321E08B;
	Thu,  9 Jan 2025 16:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ME4sdaOm"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3662A21A453
	for <netdev@vger.kernel.org>; Thu,  9 Jan 2025 16:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736438971; cv=none; b=B/mdpuSOZlTk3ZxDk/7lILwu7hJos2jsYTiSp3zK9kluTEqqNjP3LodyGoJ9pipDQp55Gq7L2Eo0kS8M8T2uNpUO+0yl+x5O+J1Q7MCvBVUiv+XarjZUAJeFN6bnLnkQQ4JiKdn0KrXUSeNH/yNB8QP/l2h9SA2I6E7r57mw/m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736438971; c=relaxed/simple;
	bh=bds85Mf90xKFcBzLC6zAs9X4hgZaW3AKKpZ0W2SyB5o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=saUg/JJ6qybNEFc403VrEeY55CywYvTztTz7cot2ewpzeJVoYP4drgGriV1tFU6xZZ5nRBdsCRXOrYgNjsceR1S7uwc165XLTmc61LfeK9rU5t4Xog99lSgRlvqqmAgbFBaTkKeqAkOuJRDjKS0zlmi0F8eUo34fjc01Bs9lc30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ME4sdaOm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736438967;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=s7Ff5q9rkJbIvC8NZwUqyOwv4+qS/F8+N/B+qJ0BveY=;
	b=ME4sdaOmWwtctytGQOqz6FQAVS8z7AMpLgPIlrvjY0PYsUN+r7FNn3VYau6/DCK5wwudM+
	9Y6FnnBFY7BKO+Gu/VUGJIztS1MjoLt15RnSxXluJ8Wq9BY0ejcahw1IvjnBPn4h/X3hr0
	gqsJgvgMZafh2z3b7XJk+gpX3dAA+X0=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-215-bOcgl9jQN8ShbLdqJl2cLg-1; Thu, 09 Jan 2025 11:09:25 -0500
X-MC-Unique: bOcgl9jQN8ShbLdqJl2cLg-1
X-Mimecast-MFC-AGG-ID: bOcgl9jQN8ShbLdqJl2cLg
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-aa680e17f6dso85194666b.1
        for <netdev@vger.kernel.org>; Thu, 09 Jan 2025 08:09:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736438963; x=1737043763;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s7Ff5q9rkJbIvC8NZwUqyOwv4+qS/F8+N/B+qJ0BveY=;
        b=n2kqMxnUr7PaPj1c1kERqE7hEG5QbSWZkE6Y0BnGUY19Eux6I9ik3tN4dgWDsZYcJY
         SqCfQ2TwVyqEBy01ORYtxdSR6EeX59N7/5mzJIUP6hAh1fHplUMnUKShFS4Q0+YWomNu
         ypB429nyJe0rA4qV4SwJnrkk6lQLTHnwEuKRFYge5BMLzZUIsjen5lAAL5u+758KJo1t
         f+DLBjEGpMYF+/B08qEc0Yl3GV97li5KrEbpAhkf4vH0aHWYtrJqVUuH2uF/Um1AxG3s
         63BqS6yt7dLUOs+rY65GhFp1hPcP9KFshDZufFPahbnXhqdFnLvW+gdGYHN8xbKZ7ySz
         bd8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWF43bHSnwrKtL7aI/z1Klc8NYpGDzWj+C4S2pZL1gHBhP9aEgq/DmHgM1MS5zE4iwqAJxR9uQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxY8QEpQ3lKJi8AxTYBGA2MG8jr308lNnVLT89SYXt/oasZRBa7
	JZRbFVo//m923LpecwTUTbCpwH1LumlCqmu88jhAEgEeB9+L+f+UFRhasJfN9j+1jeZjUtAilWT
	W4eVwz45qmh66v1qDFXN6Wrj8INGZwTYHkIZ4kJrjoka2rayEx3EYAA==
X-Gm-Gg: ASbGnct2VoPtPUTPo3L8WhV2HD0hQCKWBNKBB6nvr1DPghoU2GoJ2z5Kls6DX6Flv/B
	tIxlltL3ET2XRfP9Q9JdmxHU3B+fOyLLM1eqLP0M1xwqoLt/NVzaMw6FZDZnA/NPRr2tnYFsIiO
	HgY1GMOiQ2buvVYUnf1T+NUCOikxPhNNHJwkvUxJ1/sW8jiMKKuAQTHr65gSi2GpFakLYBwW7ES
	CZqmsoBNun1CrfbNZxkeVslWrCUov6BvywmoHKpzpbqqn9tvmtTXVO9AUWolsHkM2nsYq3Q11kk
	rJWNtA==
X-Received: by 2002:a05:6402:4415:b0:5d0:abb8:7a3 with SMTP id 4fb4d7f45d1cf-5d972e000c5mr17046383a12.6.1736438963397;
        Thu, 09 Jan 2025 08:09:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEs/F/Oyj00ptdXnI+y37mRpEHAYkEwvAGhLWl/C9WE00KJ2awn08XEU1fgzT457+MxvSbEWQ==
X-Received: by 2002:a05:6402:4415:b0:5d0:abb8:7a3 with SMTP id 4fb4d7f45d1cf-5d972e000c5mr17046306a12.6.1736438962870;
        Thu, 09 Jan 2025 08:09:22 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d99008c35bsm750825a12.2.2025.01.09.08.09.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 08:09:21 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id AF84A177E385; Thu, 09 Jan 2025 17:09:19 +0100 (CET)
From: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Paolo Abeni <pabeni@redhat.com>
Cc: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	syzbot+f63600d288bfb7057424@syzkaller.appspotmail.com,
	Dave Taht <dave.taht@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	cake@lists.bufferbloat.net,
	netdev@vger.kernel.org
Subject: [PATCH net v3] sched: sch_cake: add bounds checks to host bulk flow fairness counts
Date: Thu,  9 Jan 2025 17:08:59 +0100
Message-ID: <20250109160900.192138-1-toke@redhat.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Even though we fixed a logic error in the commit cited below, syzbot
still managed to trigger an underflow of the per-host bulk flow
counters, leading to an out of bounds memory access.

To avoid any such logic errors causing out of bounds memory accesses,
this commit factors out all accesses to the per-host bulk flow counters
to a series of helpers that perform bounds-checking before any
increments and decrements. This also has the benefit of improving
readability by moving the conditional checks for the flow mode into
these helpers, instead of having them spread out throughout the
code (which was the cause of the original logic error).

As part of this change, the flow quantum calculation is consolidated
into a helper function, which means that the dithering applied to the
host load scaling is now applied both in the DRR rotation and when a
sparse flow's quantum is first initiated. The only user-visible effect
of this is that the maximum packet size that can be sent while a flow
stays sparse will now vary with +/- one byte in some cases. This should
not make a noticeable difference in practice, and thus it's not worth
complicating the code to preserve the old behaviour.

Fixes: 546ea84d07e3 ("sched: sch_cake: fix bulk flow accounting logic for host fairness")
Reported-by: syzbot+f63600d288bfb7057424@syzkaller.appspotmail.com
Acked-By: Dave Taht <dave.taht@gmail.com>
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
v3:
- Add note about the dithering change to the commit message
- Move changelog out of the commit message
- Collect Dave'sACK

v2:
- Remove now-unused srchost and dsthost local variables in cake_dequeue()

 net/sched/sch_cake.c | 140 +++++++++++++++++++++++--------------------
 1 file changed, 75 insertions(+), 65 deletions(-)

diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
index 8d8b2db4653c..2c2e2a67f3b2 100644
--- a/net/sched/sch_cake.c
+++ b/net/sched/sch_cake.c
@@ -627,6 +627,63 @@ static bool cake_ddst(int flow_mode)
 	return (flow_mode & CAKE_FLOW_DUAL_DST) == CAKE_FLOW_DUAL_DST;
 }
 
+static void cake_dec_srchost_bulk_flow_count(struct cake_tin_data *q,
+					     struct cake_flow *flow,
+					     int flow_mode)
+{
+	if (likely(cake_dsrc(flow_mode) &&
+		   q->hosts[flow->srchost].srchost_bulk_flow_count))
+		q->hosts[flow->srchost].srchost_bulk_flow_count--;
+}
+
+static void cake_inc_srchost_bulk_flow_count(struct cake_tin_data *q,
+					     struct cake_flow *flow,
+					     int flow_mode)
+{
+	if (likely(cake_dsrc(flow_mode) &&
+		   q->hosts[flow->srchost].srchost_bulk_flow_count < CAKE_QUEUES))
+		q->hosts[flow->srchost].srchost_bulk_flow_count++;
+}
+
+static void cake_dec_dsthost_bulk_flow_count(struct cake_tin_data *q,
+					     struct cake_flow *flow,
+					     int flow_mode)
+{
+	if (likely(cake_ddst(flow_mode) &&
+		   q->hosts[flow->dsthost].dsthost_bulk_flow_count))
+		q->hosts[flow->dsthost].dsthost_bulk_flow_count--;
+}
+
+static void cake_inc_dsthost_bulk_flow_count(struct cake_tin_data *q,
+					     struct cake_flow *flow,
+					     int flow_mode)
+{
+	if (likely(cake_ddst(flow_mode) &&
+		   q->hosts[flow->dsthost].dsthost_bulk_flow_count < CAKE_QUEUES))
+		q->hosts[flow->dsthost].dsthost_bulk_flow_count++;
+}
+
+static u16 cake_get_flow_quantum(struct cake_tin_data *q,
+				 struct cake_flow *flow,
+				 int flow_mode)
+{
+	u16 host_load = 1;
+
+	if (cake_dsrc(flow_mode))
+		host_load = max(host_load,
+				q->hosts[flow->srchost].srchost_bulk_flow_count);
+
+	if (cake_ddst(flow_mode))
+		host_load = max(host_load,
+				q->hosts[flow->dsthost].dsthost_bulk_flow_count);
+
+	/* The get_random_u16() is a way to apply dithering to avoid
+	 * accumulating roundoff errors
+	 */
+	return (q->flow_quantum * quantum_div[host_load] +
+		get_random_u16()) >> 16;
+}
+
 static u32 cake_hash(struct cake_tin_data *q, const struct sk_buff *skb,
 		     int flow_mode, u16 flow_override, u16 host_override)
 {
@@ -773,10 +830,8 @@ static u32 cake_hash(struct cake_tin_data *q, const struct sk_buff *skb,
 		allocate_dst = cake_ddst(flow_mode);
 
 		if (q->flows[outer_hash + k].set == CAKE_SET_BULK) {
-			if (allocate_src)
-				q->hosts[q->flows[reduced_hash].srchost].srchost_bulk_flow_count--;
-			if (allocate_dst)
-				q->hosts[q->flows[reduced_hash].dsthost].dsthost_bulk_flow_count--;
+			cake_dec_srchost_bulk_flow_count(q, &q->flows[outer_hash + k], flow_mode);
+			cake_dec_dsthost_bulk_flow_count(q, &q->flows[outer_hash + k], flow_mode);
 		}
 found:
 		/* reserve queue for future packets in same flow */
@@ -801,9 +856,10 @@ static u32 cake_hash(struct cake_tin_data *q, const struct sk_buff *skb,
 			q->hosts[outer_hash + k].srchost_tag = srchost_hash;
 found_src:
 			srchost_idx = outer_hash + k;
-			if (q->flows[reduced_hash].set == CAKE_SET_BULK)
-				q->hosts[srchost_idx].srchost_bulk_flow_count++;
 			q->flows[reduced_hash].srchost = srchost_idx;
+
+			if (q->flows[reduced_hash].set == CAKE_SET_BULK)
+				cake_inc_srchost_bulk_flow_count(q, &q->flows[reduced_hash], flow_mode);
 		}
 
 		if (allocate_dst) {
@@ -824,9 +880,10 @@ static u32 cake_hash(struct cake_tin_data *q, const struct sk_buff *skb,
 			q->hosts[outer_hash + k].dsthost_tag = dsthost_hash;
 found_dst:
 			dsthost_idx = outer_hash + k;
-			if (q->flows[reduced_hash].set == CAKE_SET_BULK)
-				q->hosts[dsthost_idx].dsthost_bulk_flow_count++;
 			q->flows[reduced_hash].dsthost = dsthost_idx;
+
+			if (q->flows[reduced_hash].set == CAKE_SET_BULK)
+				cake_inc_dsthost_bulk_flow_count(q, &q->flows[reduced_hash], flow_mode);
 		}
 	}
 
@@ -1839,10 +1896,6 @@ static s32 cake_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 
 	/* flowchain */
 	if (!flow->set || flow->set == CAKE_SET_DECAYING) {
-		struct cake_host *srchost = &b->hosts[flow->srchost];
-		struct cake_host *dsthost = &b->hosts[flow->dsthost];
-		u16 host_load = 1;
-
 		if (!flow->set) {
 			list_add_tail(&flow->flowchain, &b->new_flows);
 		} else {
@@ -1852,18 +1905,8 @@ static s32 cake_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 		flow->set = CAKE_SET_SPARSE;
 		b->sparse_flow_count++;
 
-		if (cake_dsrc(q->flow_mode))
-			host_load = max(host_load, srchost->srchost_bulk_flow_count);
-
-		if (cake_ddst(q->flow_mode))
-			host_load = max(host_load, dsthost->dsthost_bulk_flow_count);
-
-		flow->deficit = (b->flow_quantum *
-				 quantum_div[host_load]) >> 16;
+		flow->deficit = cake_get_flow_quantum(b, flow, q->flow_mode);
 	} else if (flow->set == CAKE_SET_SPARSE_WAIT) {
-		struct cake_host *srchost = &b->hosts[flow->srchost];
-		struct cake_host *dsthost = &b->hosts[flow->dsthost];
-
 		/* this flow was empty, accounted as a sparse flow, but actually
 		 * in the bulk rotation.
 		 */
@@ -1871,12 +1914,8 @@ static s32 cake_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 		b->sparse_flow_count--;
 		b->bulk_flow_count++;
 
-		if (cake_dsrc(q->flow_mode))
-			srchost->srchost_bulk_flow_count++;
-
-		if (cake_ddst(q->flow_mode))
-			dsthost->dsthost_bulk_flow_count++;
-
+		cake_inc_srchost_bulk_flow_count(b, flow, q->flow_mode);
+		cake_inc_dsthost_bulk_flow_count(b, flow, q->flow_mode);
 	}
 
 	if (q->buffer_used > q->buffer_max_used)
@@ -1933,13 +1972,11 @@ static struct sk_buff *cake_dequeue(struct Qdisc *sch)
 {
 	struct cake_sched_data *q = qdisc_priv(sch);
 	struct cake_tin_data *b = &q->tins[q->cur_tin];
-	struct cake_host *srchost, *dsthost;
 	ktime_t now = ktime_get();
 	struct cake_flow *flow;
 	struct list_head *head;
 	bool first_flow = true;
 	struct sk_buff *skb;
-	u16 host_load;
 	u64 delay;
 	u32 len;
 
@@ -2039,11 +2076,6 @@ static struct sk_buff *cake_dequeue(struct Qdisc *sch)
 	q->cur_flow = flow - b->flows;
 	first_flow = false;
 
-	/* triple isolation (modified DRR++) */
-	srchost = &b->hosts[flow->srchost];
-	dsthost = &b->hosts[flow->dsthost];
-	host_load = 1;
-
 	/* flow isolation (DRR++) */
 	if (flow->deficit <= 0) {
 		/* Keep all flows with deficits out of the sparse and decaying
@@ -2055,11 +2087,8 @@ static struct sk_buff *cake_dequeue(struct Qdisc *sch)
 				b->sparse_flow_count--;
 				b->bulk_flow_count++;
 
-				if (cake_dsrc(q->flow_mode))
-					srchost->srchost_bulk_flow_count++;
-
-				if (cake_ddst(q->flow_mode))
-					dsthost->dsthost_bulk_flow_count++;
+				cake_inc_srchost_bulk_flow_count(b, flow, q->flow_mode);
+				cake_inc_dsthost_bulk_flow_count(b, flow, q->flow_mode);
 
 				flow->set = CAKE_SET_BULK;
 			} else {
@@ -2071,19 +2100,7 @@ static struct sk_buff *cake_dequeue(struct Qdisc *sch)
 			}
 		}
 
-		if (cake_dsrc(q->flow_mode))
-			host_load = max(host_load, srchost->srchost_bulk_flow_count);
-
-		if (cake_ddst(q->flow_mode))
-			host_load = max(host_load, dsthost->dsthost_bulk_flow_count);
-
-		WARN_ON(host_load > CAKE_QUEUES);
-
-		/* The get_random_u16() is a way to apply dithering to avoid
-		 * accumulating roundoff errors
-		 */
-		flow->deficit += (b->flow_quantum * quantum_div[host_load] +
-				  get_random_u16()) >> 16;
+		flow->deficit += cake_get_flow_quantum(b, flow, q->flow_mode);
 		list_move_tail(&flow->flowchain, &b->old_flows);
 
 		goto retry;
@@ -2107,11 +2124,8 @@ static struct sk_buff *cake_dequeue(struct Qdisc *sch)
 				if (flow->set == CAKE_SET_BULK) {
 					b->bulk_flow_count--;
 
-					if (cake_dsrc(q->flow_mode))
-						srchost->srchost_bulk_flow_count--;
-
-					if (cake_ddst(q->flow_mode))
-						dsthost->dsthost_bulk_flow_count--;
+					cake_dec_srchost_bulk_flow_count(b, flow, q->flow_mode);
+					cake_dec_dsthost_bulk_flow_count(b, flow, q->flow_mode);
 
 					b->decaying_flow_count++;
 				} else if (flow->set == CAKE_SET_SPARSE ||
@@ -2129,12 +2143,8 @@ static struct sk_buff *cake_dequeue(struct Qdisc *sch)
 				else if (flow->set == CAKE_SET_BULK) {
 					b->bulk_flow_count--;
 
-					if (cake_dsrc(q->flow_mode))
-						srchost->srchost_bulk_flow_count--;
-
-					if (cake_ddst(q->flow_mode))
-						dsthost->dsthost_bulk_flow_count--;
-
+					cake_dec_srchost_bulk_flow_count(b, flow, q->flow_mode);
+					cake_dec_dsthost_bulk_flow_count(b, flow, q->flow_mode);
 				} else
 					b->decaying_flow_count--;
 
-- 
2.47.1



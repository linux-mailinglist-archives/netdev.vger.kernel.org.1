Return-Path: <netdev+bounces-155477-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66EF4A026CE
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 14:40:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4DC41882F55
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 13:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 892AA1DDC37;
	Mon,  6 Jan 2025 13:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gdg9KAh/"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353E61DB34C
	for <netdev@vger.kernel.org>; Mon,  6 Jan 2025 13:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736170810; cv=none; b=q1uXyf8gKV57ZeynPMqAZvOCBZ7vSp9yOhFKBnGRzlQ+qwzZwSJEXxu4hM3eeXu1gP0oxLZPBxKmJFnmdlsHbK+UsLOIF6RXDM7ZSKPpKXBANtEvtWPfu124firQ5PLsP5BqAje5rtY6rPUE2uXCjm1zNS0dImcGND0st9ibytA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736170810; c=relaxed/simple;
	bh=X/CRaL/9bbuz9p4rnDSoG0FMO0lOHNXxApQq1foIyaU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cC5kIPe5LSqmxPW3Vtmpihb6jyOsp8irmdoHqFs/U39i5aXoX3zPKMKz/l0tVkjvgn4nDEDfKLr98+erONswB621XiOOB3y1uj1vJfrx1CuFb9+p05Z3RNYLKlqD/jcs6sokP6f7T1d7zFKT0Y8omNg+YtfkqQZUVKqvVLuTT6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Gdg9KAh/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736170806;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Aykk49gbvca+fRkPZSvRtNtvxhZhBnfZrlAGzlCj8GE=;
	b=Gdg9KAh/BH76bFiJc1V+usgGNka5NJwK44WzZgzHRU3gjX5FX91bBk4DX4vgG48vaW8h3i
	2J2m6UhrhllI2A2zr3Q7/fJMGoha6f1GVgW5n/8TW1pPDbXJDD5lZSzv2VO7OJkupbT2WA
	GgNT/DrVxhEVTNAEyL+9K4aoaZSVnuc=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-120-Pdc6wBTsPvOCL2G7SvMIOA-1; Mon, 06 Jan 2025 08:40:04 -0500
X-MC-Unique: Pdc6wBTsPvOCL2G7SvMIOA-1
X-Mimecast-MFC-AGG-ID: Pdc6wBTsPvOCL2G7SvMIOA
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-aa6a831f93cso229535466b.1
        for <netdev@vger.kernel.org>; Mon, 06 Jan 2025 05:40:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736170803; x=1736775603;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Aykk49gbvca+fRkPZSvRtNtvxhZhBnfZrlAGzlCj8GE=;
        b=Z7dv84/lUPwqD8M8195/3cSub1uywtNypagw6WveqcwGWEGj20qwE07l4fcHPvJJZC
         UTztT8Txji9HJObTYZjgFYEND6FDkhOGcH35lHnAv5+ADkIY+9foPJkBt1BdNZ50fOXF
         W+zEpGhBSHC4UoYi68a1kGuIAltcv8ohjP2rxirVuoRci48SVw79EEv6DnIAfvPPztzM
         iAAliUEcjoScDeTUtuxPNJGj3Xw4QF3XfhQbKHR1ZfeZIM9CPe30J5XNwxOwGr1OCywV
         mSL4YBS6LHou2t7zLcycf9wT1KHh3jc4eICM+xJ+ZZsJ8kRiJnOKaB85eFHXAFRT5nCH
         DnVA==
X-Forwarded-Encrypted: i=1; AJvYcCVsBsbGcbtLElyaAbLvf3FzwEqDi5kDGIfpYPa60ej8PwD90cT6UN1d71JI61IoqqYMVLeRyJc=@vger.kernel.org
X-Gm-Message-State: AOJu0YytUy1NKpW3Hip4FpvNzrL5ziUsYUSw37g47lG8a4nNRM4APjrS
	9rrR5ChxxWaHXBRMdi2MKxE16A0/9DDy4uCQj7Jb/k0neEt6kgEcfs1G9o5PEaXE9wHROMf3s7t
	xYbpFSA1C/qXGAMMJKSGDIw0nctsYUFsCQS3qMn/B/M+s1ie0es/+cg==
X-Gm-Gg: ASbGncufs/Nap82Rg4T21sBca04TrbQLaXz/cLvP6W4tgbs3Y6wWXgDt288k3eJbQ21
	LdJIYjUSESp6KcdBT8A5zIxR9H424goNDHJh/x9JlGyC7kRUCDrqcGoaDMf+Dsmj7qVjjpqXFMQ
	UYlCctaAFmcvCYZzBTuzbNQUWsgY3zCnLaoQ3L7Cc4OuStDMfFUNLPANMIWRAMOhybhQalZdoT3
	paFQJxQbimTi1xPqN7q2WecotflYLlmhDZ6tmAvpGPyxOEE9Kwi2w==
X-Received: by 2002:a17:907:7f0b:b0:aab:dc3e:1c84 with SMTP id a640c23a62f3a-aac2b0a56b6mr5056061366b.17.1736170803477;
        Mon, 06 Jan 2025 05:40:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEQ4fy+bYZtT8GzTBXjkHHDP8uRbcLNSuvg0O2pFaTIMwftyd/2R0VX3W1BkcVGNjuwueBrZA==
X-Received: by 2002:a17:907:7f0b:b0:aab:dc3e:1c84 with SMTP id a640c23a62f3a-aac2b0a56b6mr5056058366b.17.1736170802870;
        Mon, 06 Jan 2025 05:40:02 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aac0e892bb7sm2237715766b.43.2025.01.06.05.40.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2025 05:40:02 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 5484A177DEBD; Mon, 06 Jan 2025 14:40:01 +0100 (CET)
From: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Paolo Abeni <pabeni@redhat.com>
Cc: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	syzbot+f63600d288bfb7057424@syzkaller.appspotmail.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	cake@lists.bufferbloat.net,
	netdev@vger.kernel.org
Subject: [PATCH net] sched: sch_cake: add bounds checks to host bulk flow fairness counts
Date: Mon,  6 Jan 2025 14:38:36 +0100
Message-ID: <20250106133837.18609-1-toke@redhat.com>
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

Fixes: 546ea84d07e3 ("sched: sch_cake: fix bulk flow accounting logic for host fairness")
Reported-by: syzbot+f63600d288bfb7057424@syzkaller.appspotmail.com
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 net/sched/sch_cake.c | 135 ++++++++++++++++++++++++-------------------
 1 file changed, 75 insertions(+), 60 deletions(-)

diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
index 8d8b2db4653c..8f61ecb78139 100644
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
@@ -1939,7 +1978,6 @@ static struct sk_buff *cake_dequeue(struct Qdisc *sch)
 	struct list_head *head;
 	bool first_flow = true;
 	struct sk_buff *skb;
-	u16 host_load;
 	u64 delay;
 	u32 len;
 
@@ -2042,7 +2080,6 @@ static struct sk_buff *cake_dequeue(struct Qdisc *sch)
 	/* triple isolation (modified DRR++) */
 	srchost = &b->hosts[flow->srchost];
 	dsthost = &b->hosts[flow->dsthost];
-	host_load = 1;
 
 	/* flow isolation (DRR++) */
 	if (flow->deficit <= 0) {
@@ -2055,11 +2092,8 @@ static struct sk_buff *cake_dequeue(struct Qdisc *sch)
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
@@ -2071,19 +2105,7 @@ static struct sk_buff *cake_dequeue(struct Qdisc *sch)
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
@@ -2107,11 +2129,8 @@ static struct sk_buff *cake_dequeue(struct Qdisc *sch)
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
@@ -2129,12 +2148,8 @@ static struct sk_buff *cake_dequeue(struct Qdisc *sch)
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



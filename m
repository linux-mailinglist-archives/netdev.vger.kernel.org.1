Return-Path: <netdev+bounces-155816-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89457A03E74
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 13:01:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 025C218804EA
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 12:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A15ED1EBA1C;
	Tue,  7 Jan 2025 12:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aU+s/mgr"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362221EBFED
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 12:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736251288; cv=none; b=iursiaL9DCV7Vg/++IOALgK4qlZN9YjRStb1+g/2M5WhucO0yvNJN4clNiNaM/DVbXUWw+Uc0VR/a9p+IobltN8u27Yqfdjqr3FZ40w+X8C9HpOxfHioqcJNFlpNXTRbb2/KhAJNt4/a3Bsp1pCKIf63kFEuVK7P8JC2F2itQPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736251288; c=relaxed/simple;
	bh=lzgKG3lKuyd/w8zxZiiqbtSudmrEpb49c7OMs9ihfE8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WjIyNFqjdFyaWjfa+dekpg1TPLho5YBrVZ2LFxrhGAJ1IGk4H8fqxQTMMyJ4PG0p7tB1BW5rtnhlMZzsUgvQx0GbOFxaf47RX1dO8JwRk+9xbQBfp0TQJf4eXVRtlHlVCIo8HRwukd1y6SFjuSMei9m438qDkFTrzBuZ97waw2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aU+s/mgr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736251282;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6jYoXioYE1FvbrI80xKIL1y/Pw2SEUk3F4ceubiVbLw=;
	b=aU+s/mgro0QigNGc3arsl6n8/jA8Tt/I808lQHIzaFJXedROS9WHeMVIM07LWpFOCXFCHT
	t/eNMjE3NvOexe72n/rfhB73KNgLQsFch5DE0fCkTpVVo2KyAwRiHyoXpSn8GSpI/oKCtj
	kHvYmCr1HhiZyoQJ4KsvCAosSn9u+5U=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-294-PkY-r0iRNFu9qPFOLqXypA-1; Tue, 07 Jan 2025 07:01:20 -0500
X-MC-Unique: PkY-r0iRNFu9qPFOLqXypA-1
X-Mimecast-MFC-AGG-ID: PkY-r0iRNFu9qPFOLqXypA
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-aa689b88293so801675866b.3
        for <netdev@vger.kernel.org>; Tue, 07 Jan 2025 04:01:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736251279; x=1736856079;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6jYoXioYE1FvbrI80xKIL1y/Pw2SEUk3F4ceubiVbLw=;
        b=jSkSeTCaJ7ksx7kpWuw1VkR9Nk27DB5CpLjgAxxFmrPm8r+cCrf9yPVozsV6+RszZU
         D7AIkm6cS81z87ZPl3t+ZHwIXSs1PLrqEdsLErwnhw0m52JBj/nHmQzMnNCrcfV6PW+R
         Ojvw7+iFvAi1VpCR8UmYQMpHn3NmMON764cIvGmntczqBZamAILLLui4CIg40XDGeg6I
         f3XD4ffvAvAuEzX0iJQMiyQVFSbvzBLCZ6b6VEfyjuV0/lmW12nrDv6L5a3ubtsBQ1Lz
         0rKAstRgH00wJzkRZykCGtRffl9aTpI4pwpp/GZMFO28CtsHaFGRb0mKSDscC4dc/Igr
         BOlQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCAehx6m2UiVTPHC4GVBIsz4siPDZEHff5unCQK4f2OlBDLiqsPayhCAgEIbOTNMRwetN8b8I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfIBf8NGfn4XkH97idrO4E/Xx7Vn/P0Tn01R866lam1MPglcsJ
	K490ownGHiIJBYXv85CPsANrEFpN61q0Dv6f8OXLRtk7aVHcAmJtQBBdpbSvabvNtivSINdlA03
	BNnY5wUQRJVzpADTA9YrE9z8JjJ6kKDr/eKEGWdViPiEr8tnOaWqQ8g==
X-Gm-Gg: ASbGncuG+bjui2/xTM4XKf+5+bGOuD1O3ybgj7qkBd7FCXAzOCAJxQDrG7Obb/zdIuf
	Q3hd7BSG5ohsnIvUzh9C3zOEi8IUGU6qFKfCrtihgxtFd9uM9UwHDn3uK/xFPJxyaMu8JpTW/gX
	MwL38n3MrBetdUgECdhso7tNj35/9+MhR5KGoVg50J4Pz48AUATCayiYsnif2lrI0/b40r8rN0j
	7DBG7WI97z76Ld0H3MU5l3ETM5mMMIP8e3kqm5cZwFkZ+Ix//JIfKN7YeHJrfvjhbH45NF1UNOb
	ka6mHg==
X-Received: by 2002:a17:907:3e8c:b0:aa6:abe2:5cb8 with SMTP id a640c23a62f3a-aac3366f16emr5600963166b.60.1736251277581;
        Tue, 07 Jan 2025 04:01:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF1zymT2cuftMDuEUfG2da0NezcAmNzkY/ipPchSMDIG/bvIgmiaQ7JupRvxDo3Zw2ylXjQBw==
X-Received: by 2002:a17:907:3e8c:b0:aa6:abe2:5cb8 with SMTP id a640c23a62f3a-aac3366f16emr5600960966b.60.1736251277069;
        Tue, 07 Jan 2025 04:01:17 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aac0efe490asm2370635166b.98.2025.01.07.04.01.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 04:01:16 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 7E2FC177E084; Tue, 07 Jan 2025 13:01:15 +0100 (CET)
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
Subject: [PATCH net v2] sched: sch_cake: add bounds checks to host bulk flow fairness counts
Date: Tue,  7 Jan 2025 13:01:05 +0100
Message-ID: <20250107120105.70685-1-toke@redhat.com>
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

v2:
- Remove now-unused srchost and dsthost local variables in cake_dequeue()

Fixes: 546ea84d07e3 ("sched: sch_cake: fix bulk flow accounting logic for host fairness")
Reported-by: syzbot+f63600d288bfb7057424@syzkaller.appspotmail.com
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
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



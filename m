Return-Path: <netdev+bounces-280697-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OIjhOnL16WmepQIAu9opvQ
	(envelope-from <netdev+bounces-280697-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 12:33:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EF45A450C38
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 12:33:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7255C314AA5C
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 10:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0AD7382F0F;
	Thu, 23 Apr 2026 10:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="abF49ELC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3455F28C2DD
	for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 10:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776939810; cv=none; b=la3IjMp6WGG1a1xk+8ZVnxXY8Sw8dKaecQy6fCYrIjSjzgUy7MOeuciXiF/TEqPJUwiPP0geOZI+eg/sLSrv10rxA4d6xjcWIhgNAl4F7gdOgSrKxtZctxHaLVGvW0V3yJBVCZ5oJoj0cfWykfUzWh7gh1ix0E2hmfhfvKuovTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776939810; c=relaxed/simple;
	bh=+40syrGbxrfDIRUw4eObxgmx8uzHBk6D7KZp9kMMaF4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kyQRdxhLwMQZ3h2/fGIFua6LVdT+4xW6mgPet3huIe/q/qOsgxfm0atT1vDeFzsAl3vtV6mxdRvNdS1ZP4+Dn2m2H065ZKFvp1RgeBoS3oVI7L7YwER6R/8cmeUpHSMTcNndGFoZzXBCLJYt3MsVR1edtDf9hNtSY5RmB9w4i3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=abF49ELC; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-8d3ea68b9cdso1255833485a.3
        for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 03:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776939808; x=1777544608; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EysEmg+1ufr9bf50eAqB1if1f2hgaDfqyUJotgs3rC8=;
        b=abF49ELCYoBraOJ1PN/CP8ML8NM8aPiaLeY4n1bcDqlTDvFyg6GM0aGasUOmYnK15N
         skxwEkyQMxWoYl/FKF0WgIAyQprPtd7vYcjhyt6BHHelbQkKLDvVzg5cmwfGNKMBn2NC
         gCThkvt77TTSpeXsllWcMH0aqA8RVGB7FmlNB+rpDNqOj0Bwko5XMXnzYIYrkPoDnLwX
         +bfCEFXrEPuMXTImAhPmIRbcz+BciwMWRVzp3l5zwPhz260L5fr7/z7Tr8AQOXaDKNYE
         82vbzdWKXNbHIPGHq9mi7w6GVh67oaA5ndhxm1z9ROMKCkA8YhLpIZJe0D6tnhqLcFqq
         jctw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776939808; x=1777544608;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EysEmg+1ufr9bf50eAqB1if1f2hgaDfqyUJotgs3rC8=;
        b=TA2C/WZHcrnmklouN7X00wqXp78Rq0gI5A+3YxWCU7+RLczYGfj0ACmQpzIeIfMwG0
         B+I5lRs2mTPuSPJ/BELHv6hU65u5uJ+RC1FfcuuPfsEzl7417FhGTBa56WQmlgfJdTQc
         X0r3UQ0nZjrve8bdoXE06bS8QB44WBQl3hxlY/2hbnIF8d1z5DghwBCfrplggCztI8mt
         3uy9dKCSAHW2nB8mgfNkoJKxpkRoNFAgxTr8T1QdtwT7WDNXTrPOom240PIDcpuphnhw
         eSKjenqFGV7YAom9I2O/RZDiOFeJrGlnL4sh5h6QdkJq/w9/QirEoO8ANtnzqZ/+Do/P
         RT+g==
X-Forwarded-Encrypted: i=1; AFNElJ9wPeaSw7jXFeUZl5zHgYZYb76upvpbpzjU3vHjauDFTQBdHjNSvH9IZ9WK+gyEkxzah+ktTD4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzZGjn0upMRyN2qtEyE+p5D8R6FKu55+VzAMgCj5WbOj7V/eCq
	a33lUir4JSGtmJ+W9ZR8Nv0i/macknu9v2JWN4WL5ruAOUU8k1zTjQZmIgvyO9ryiEfmqMwRgCj
	Ib5o3tN4ZFjEI7Q==
X-Received: from qkbe7-n2.prod.google.com ([2002:a05:620a:a407:20b0:8de:d98c:d165])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:2687:b0:8eb:d38d:201e with SMTP id af79cd13be357-8ebd38d25bemr1999915885a.4.1776939807833;
 Thu, 23 Apr 2026 03:23:27 -0700 (PDT)
Date: Thu, 23 Apr 2026 10:23:20 +0000
In-Reply-To: <20260423102324.3172448-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260423102324.3172448-1-edumazet@google.com>
X-Mailer: git-send-email 2.54.0.rc2.544.gc7ae2d5bb8-goog
Message-ID: <20260423102324.3172448-2-edumazet@google.com>
Subject: [PATCH net 1/5] net/sched: sch_cake: annotate data-races in
 cake_dump_stats() (I)
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, 
	"=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?=" <toke@redhat.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, 
	"=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?=" <toke@toke.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,mojatatu.com,resnulli.us,redhat.com,vger.kernel.org,gmail.com,google.com,toke.dk];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280697-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,toke.dk:email]
X-Rspamd-Queue-Id: EF45A450C38
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

cake_dump_stats() runs without qdisc spinlock being held.

In this first patch, I add READ_ONCE()/WRITE_ONCE() annotations
for the following fields:

- way_hits
- way_misses
- way_collisions
- sparse_flow_count
- decaying_flow_count

Other annotations are added in following patches, to ease code review.

Fixes: 046f6fd5daef ("sched: Add Common Applications Kept Enhanced (cake) q=
disc")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: "Toke H=C3=B8iland-J=C3=B8rgensen" <toke@toke.dk>
---
 net/sched/sch_cake.c | 42 +++++++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
index 02e1fa4577ae6089646e79b901b0d21945891855..bcc601fc486b13ab1609134f1ee=
29ebdcb9e8a06 100644
--- a/net/sched/sch_cake.c
+++ b/net/sched/sch_cake.c
@@ -813,7 +813,7 @@ static u32 cake_hash(struct cake_tin_data *q, const str=
uct sk_buff *skb,
 		     i++, k =3D (k + 1) % CAKE_SET_WAYS) {
 			if (q->tags[outer_hash + k] =3D=3D flow_hash) {
 				if (i)
-					q->way_hits++;
+					WRITE_ONCE(q->way_hits, q->way_hits + 1);
=20
 				if (!q->flows[outer_hash + k].set) {
 					/* need to increment host refcnts */
@@ -831,7 +831,7 @@ static u32 cake_hash(struct cake_tin_data *q, const str=
uct sk_buff *skb,
 		for (i =3D 0; i < CAKE_SET_WAYS;
 			 i++, k =3D (k + 1) % CAKE_SET_WAYS) {
 			if (!q->flows[outer_hash + k].set) {
-				q->way_misses++;
+				WRITE_ONCE(q->way_misses, q->way_misses + 1);
 				allocate_src =3D cake_dsrc(flow_mode);
 				allocate_dst =3D cake_ddst(flow_mode);
 				goto found;
@@ -841,7 +841,7 @@ static u32 cake_hash(struct cake_tin_data *q, const str=
uct sk_buff *skb,
 		/* With no empty queues, default to the original
 		 * queue, accept the collision, update the host tags.
 		 */
-		q->way_collisions++;
+		WRITE_ONCE(q->way_collisions, q->way_collisions + 1);
 		allocate_src =3D cake_dsrc(flow_mode);
 		allocate_dst =3D cake_ddst(flow_mode);
=20
@@ -1917,11 +1917,11 @@ static s32 cake_enqueue(struct sk_buff *skb, struct=
 Qdisc *sch,
 		if (!flow->set) {
 			list_add_tail(&flow->flowchain, &b->new_flows);
 		} else {
-			b->decaying_flow_count--;
+			WRITE_ONCE(b->decaying_flow_count, b->decaying_flow_count - 1);
 			list_move_tail(&flow->flowchain, &b->new_flows);
 		}
 		flow->set =3D CAKE_SET_SPARSE;
-		b->sparse_flow_count++;
+		WRITE_ONCE(b->sparse_flow_count, b->sparse_flow_count + 1);
=20
 		flow->deficit =3D cake_get_flow_quantum(b, flow, q->config->flow_mode);
 	} else if (flow->set =3D=3D CAKE_SET_SPARSE_WAIT) {
@@ -1929,7 +1929,7 @@ static s32 cake_enqueue(struct sk_buff *skb, struct Q=
disc *sch,
 		 * in the bulk rotation.
 		 */
 		flow->set =3D CAKE_SET_BULK;
-		b->sparse_flow_count--;
+		WRITE_ONCE(b->sparse_flow_count, b->sparse_flow_count - 1);
 		b->bulk_flow_count++;
=20
 		cake_inc_srchost_bulk_flow_count(b, flow, q->config->flow_mode);
@@ -2149,7 +2149,7 @@ static struct sk_buff *cake_dequeue(struct Qdisc *sch=
)
 		 */
 		if (flow->set =3D=3D CAKE_SET_SPARSE) {
 			if (flow->head) {
-				b->sparse_flow_count--;
+				WRITE_ONCE(b->sparse_flow_count, b->sparse_flow_count - 1);
 				b->bulk_flow_count++;
=20
 				cake_inc_srchost_bulk_flow_count(b, flow, q->config->flow_mode);
@@ -2192,27 +2192,27 @@ static struct sk_buff *cake_dequeue(struct Qdisc *s=
ch)
 					cake_dec_srchost_bulk_flow_count(b, flow, q->config->flow_mode);
 					cake_dec_dsthost_bulk_flow_count(b, flow, q->config->flow_mode);
=20
-					b->decaying_flow_count++;
+					WRITE_ONCE(b->decaying_flow_count, b->decaying_flow_count + 1);
 				} else if (flow->set =3D=3D CAKE_SET_SPARSE ||
 					   flow->set =3D=3D CAKE_SET_SPARSE_WAIT) {
-					b->sparse_flow_count--;
-					b->decaying_flow_count++;
+					WRITE_ONCE(b->sparse_flow_count, b->sparse_flow_count - 1);
+					WRITE_ONCE(b->decaying_flow_count, b->decaying_flow_count + 1);
 				}
 				flow->set =3D CAKE_SET_DECAYING;
 			} else {
 				/* remove empty queue from the flowchain */
 				list_del_init(&flow->flowchain);
 				if (flow->set =3D=3D CAKE_SET_SPARSE ||
-				    flow->set =3D=3D CAKE_SET_SPARSE_WAIT)
-					b->sparse_flow_count--;
-				else if (flow->set =3D=3D CAKE_SET_BULK) {
+				    flow->set =3D=3D CAKE_SET_SPARSE_WAIT) {
+					WRITE_ONCE(b->sparse_flow_count, b->sparse_flow_count - 1);
+				} else if (flow->set =3D=3D CAKE_SET_BULK) {
 					b->bulk_flow_count--;
=20
 					cake_dec_srchost_bulk_flow_count(b, flow, q->config->flow_mode);
 					cake_dec_dsthost_bulk_flow_count(b, flow, q->config->flow_mode);
-				} else
-					b->decaying_flow_count--;
-
+				} else {
+					WRITE_ONCE(b->decaying_flow_count, b->decaying_flow_count - 1);
+				}
 				flow->set =3D CAKE_SET_NONE;
 			}
 			goto begin;
@@ -3050,12 +3050,12 @@ static int cake_dump_stats(struct Qdisc *sch, struc=
t gnet_dump *d)
 		PUT_TSTAT_U32(BASE_DELAY_US,
 			      ktime_to_us(ns_to_ktime(b->base_delay)));
=20
-		PUT_TSTAT_U32(WAY_INDIRECT_HITS, b->way_hits);
-		PUT_TSTAT_U32(WAY_MISSES, b->way_misses);
-		PUT_TSTAT_U32(WAY_COLLISIONS, b->way_collisions);
+		PUT_TSTAT_U32(WAY_INDIRECT_HITS, READ_ONCE(b->way_hits));
+		PUT_TSTAT_U32(WAY_MISSES, READ_ONCE(b->way_misses));
+		PUT_TSTAT_U32(WAY_COLLISIONS, READ_ONCE(b->way_collisions));
=20
-		PUT_TSTAT_U32(SPARSE_FLOWS, b->sparse_flow_count +
-					    b->decaying_flow_count);
+		PUT_TSTAT_U32(SPARSE_FLOWS, READ_ONCE(b->sparse_flow_count) +
+					    READ_ONCE(b->decaying_flow_count));
 		PUT_TSTAT_U32(BULK_FLOWS, b->bulk_flow_count);
 		PUT_TSTAT_U32(UNRESPONSIVE_FLOWS, b->unresponsive_flow_count);
 		PUT_TSTAT_U32(MAX_SKBLEN, b->max_skblen);
--=20
2.54.0.rc2.544.gc7ae2d5bb8-goog



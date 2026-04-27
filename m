Return-Path: <netdev+bounces-281264-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gIZ1KZEg72lv7QAAu9opvQ
	(envelope-from <netdev+bounces-281264-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 10:38:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3306C46F3B7
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 10:38:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9122B302CB19
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 08:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C23B39B960;
	Mon, 27 Apr 2026 08:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="deP9fzcq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9734F39B971
	for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 08:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777278972; cv=none; b=QVY9OhmZFHWUW8gUk5xJORpHRg5L/yxm4DliZUe3YqBeHON3bV9A/dDNYYagNibTDF696k9Cn80iozL22k0Ljcul29kLJukzGbetuk7+3k5qhuuBCrB3635ECik3ape3prI3ER+IE4nIkYpNgf0sb2DLq8rYdHXgQ8Daf/y+d/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777278972; c=relaxed/simple;
	bh=tF03mX0eX1LsBj2vlYTLzI/3TMMBKSYeyf2Sh2PJe7U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NbrPuaRwHhBk3/iPA4q89QxfXMfEUnr9f4SOKY4vUSU61fdbYGe18Bj1y/tc6F5YYPvrHlZh8/V7PNHZ0iIktdO3rzWjCiL0eTlfOc1qW2887O+EFjgSRUE+X7QJEb6vIKhxQckhS0pYrTl7+pEmWnB2PhbDE0ZRju/JKfbFEbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=deP9fzcq; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-50d9a6a853bso138290201cf.0
        for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 01:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777278969; x=1777883769; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AoWQoAlkGMvuqPf2NFqfhPep3QmdvQoaOuKbL0MnccM=;
        b=deP9fzcq+xCgWlx5IwVITAXdLsSRySei40ZDWoH4mCfUVb+3Rnblu74MUm2grJ5eGK
         oZd6qw6dUpXtoDw5dmdL05xT2fxt5S25Df3xji30Y8tE9tYVVBdB1RhkwcnUadpzUB4V
         o8LTpqZKzbFqFr3CeEM/nR4qtCQoYQchw8buIsdYNdvTh3XH0hm93M8qDZ8WM9cWo1ot
         LknJ8QO2VuivNFZYJi4QAWagG/klnTrDDo7xDBlLTdNzHJU4za0eESLfDE6w27mZgm+4
         hxTH4iy8gVtIqxFyMoMRmwYtkYlBFwVUx2aLMY4aD6NrejimIvsNUt/yFXe/oVAGXIie
         bcQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777278969; x=1777883769;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AoWQoAlkGMvuqPf2NFqfhPep3QmdvQoaOuKbL0MnccM=;
        b=PNdi8qVqfiDGubStKxtMeS+sFmBC+n8QTEmw+CSSkNQl9a3MoPhAfnPvDn1v/ugiM1
         9sbu4/C9gB6n9m/DUB5jWjELNipzF2acIsFUt6qqyemK1JVa8LGzMAAAh/2WpfuGIxlq
         Ztf/mQkdBaf4WH7YD8jP/N24ky0jpPpnKnoUThJeGPTxCJLKdLCY79e+VDNvjQmbwxrD
         HH7xs7Fw3GjqwTBHiMOshHK/4VVGw5KwPGTTY/4UCtccTp8iSdmVmXc+Q850vds7ljB0
         EL6rI49/qKKFSbMdCfw/YIbLcmQNCg04+lILjccDcyxQ9VUnPHZxCkk6kDOLkZ3c+5Su
         ZVig==
X-Forwarded-Encrypted: i=1; AFNElJ9OF/63xmjs5oD3s9nSWtyW0zMnjtpwgbemx2a3YzMfCbDwbTtoxyt9cc9fI8uJxZNdL/U1tlQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaFsCO7YSa5K7Zs2JkRYqpmTWP9EHq+t2xUXS1Owp/iOjnRuec
	aFRwYbA9eAWJgE7BS75joFOe2WA/RnaR4H4k4pTAp+f6iSnOEyRYd1ZpXFOafjwSHNmSji8vpxG
	WufMHv9QwqSgprg==
X-Received: from qtkw16.prod.google.com ([2002:a05:622a:1350:b0:50e:5e33:ee38])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:2281:b0:50f:ba44:ce5f with SMTP id d75a77b69052e-50fba44d77amr368700131cf.22.1777278969492;
 Mon, 27 Apr 2026 01:36:09 -0700 (PDT)
Date: Mon, 27 Apr 2026 08:36:02 +0000
In-Reply-To: <20260427083606.459355-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260427083606.459355-1-edumazet@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260427083606.459355-2-edumazet@google.com>
Subject: [PATCH v2 net 1/5] net/sched: sch_cake: annotate data-races in
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
X-Rspamd-Queue-Id: 3306C46F3B7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,mojatatu.com,resnulli.us,redhat.com,vger.kernel.org,gmail.com,google.com,toke.dk];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281264-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,toke.dk:email]

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
Acked-by: "Toke H=C3=B8iland-J=C3=B8rgensen" <toke@toke.dk>
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
2.54.0.545.g6539524ca2-goog



Return-Path: <netdev+bounces-281266-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qDyFGFgg72lv7QAAu9opvQ
	(envelope-from <netdev+bounces-281266-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 10:37:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 851B746F38A
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 10:37:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4BE95300BC97
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 08:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB4E139C010;
	Mon, 27 Apr 2026 08:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E6vqqjT7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B35E39B975
	for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 08:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777278975; cv=none; b=crSQIr7pAFWUv8HEltIBJxTAwAuBvQCNzJv8MopuA50ooCUxFx976FOP7L8fkL+vRJef3hlhcQCdT3JDVtkncW1lepTwq3+mPOCm7JFKYagHRR/C9Gkjpewxlwn1yw2h/MxduUiRdBAYT4eWxkOgyd+Ks5CuH3Hvy99ZbvWnFJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777278975; c=relaxed/simple;
	bh=jjfo/Z7LCADcKkW4S9JLxNAag2/NSt1v54bR2f4gjqI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qvS1TIwb1fS/fmFpiXmccEkaINYY+tkIJvdNMyu5ollutM8EfbdGH7q4QgKnCKlp0ALXo7umP6PTOpJYcsqGjOpAQ9uCDjdO+5Mr/s/lm6Y4EAMbp1m5jIXuR2ihAltYFfpXDP1/zhvI5EPvDWraxg1ZLZrKpgUF1B+oC5WcmUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E6vqqjT7; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-50df4c130dbso165036791cf.1
        for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 01:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777278973; x=1777883773; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dmXRr2sWL7A+FMGNgOt0J8wEI3M+DOHQa79xl2Gs7pM=;
        b=E6vqqjT74CJKFVKTIezRah/9Cula70hB7VShFsFv1g4pAQ2pfM4rawbjmjlIpDr4dC
         PftT50o3kNwYbnfVYB0AzkNIHGcT/O0cPtQNG1OYd7vcJFlHhf0dcu3mb7fTeGMVs61Y
         t7KlOlVdkO17rs8n6XnHfRq/YCG306Kd5iI3/7FKfIu9evNEDH0W4tM+wRQCe3yp7Hki
         xYVbKZIrY5Tgu1soo8Wiqjmp+UpcyzVfF12Wb7PqIzg51RcHwmj84zwaRQCDtxXUb3aQ
         YLxu+L3JHWqETDjJCHAwkXiOVgveRkC+Mo553v9DAAAyKu4ipWxce7jH0a71mvt//uAY
         ZXrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777278973; x=1777883773;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dmXRr2sWL7A+FMGNgOt0J8wEI3M+DOHQa79xl2Gs7pM=;
        b=qeAcSamShRyrSZruAHKgzq0wYuuyMmFUG1p6HCaZ7J8ya+609rQ04eEt63giC4LNhg
         DCUduFJzzvgnE/j0J1va5n1diS7k4G+AdEcq51JL7p+IgZ0iseXz9vq9l3NpGuptt+xj
         U6/35QBd+6Zi+zNoGd7YbaB0MtHdXyyYi1myWtpl5qKcoy8qyvmlZA2N+eVgoGl8oxPN
         UOXR+pfhKWL8ztFRIAXB2sKxVOdbhDaeIPuliAW/oqBloDNPv6I8GMmZV46Lq+J20zvq
         BNJsSP84neHaDwuJ1oWI9Vep/TyHKn8g1Qh2P4+1+JK0VTIt0EShvTQT2LGgC69Zm6PL
         v5Ag==
X-Forwarded-Encrypted: i=1; AFNElJ8YLTuzmeQvTvr6nWK0/mZ41mWrJOoxHsdy8Mt6ApvSj0l5Gj8c0rg92DkuGLsZuDCLtUvZzJ0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxs9zNW79HnqQdyMePfrRGfXWyPqySdykjNUVDe9iq47O/Staop
	GJCxRl6UjYeM9VPDE7cdP4xZAWbz7ZcJsOHObRutPd0C2H6BblNGyt+H7YkN/6MACLXJLUnOpi7
	vDTE3fUlOVzpoAQ==
X-Received: from qtxg11.prod.google.com ([2002:ac8:5d4b:0:b0:503:31d9:9a96])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:5f4d:0:b0:50f:6e68:d71a with SMTP id d75a77b69052e-50f6e68e71dmr394701701cf.28.1777278972994;
 Mon, 27 Apr 2026 01:36:12 -0700 (PDT)
Date: Mon, 27 Apr 2026 08:36:04 +0000
In-Reply-To: <20260427083606.459355-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260427083606.459355-1-edumazet@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260427083606.459355-4-edumazet@google.com>
Subject: [PATCH v2 net 3/5] net/sched: sch_cake: annotate data-races in
 cake_dump_stats() (III)
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, 
	"=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?=" <toke@redhat.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, 
	"=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?=" <toke@toke.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 851B746F38A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,mojatatu.com,resnulli.us,redhat.com,vger.kernel.org,gmail.com,google.com,toke.dk];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281266-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[toke.dk:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

cake_dump_stats() runs without qdisc spinlock being held.

In this third patch, I add READ_ONCE()/WRITE_ONCE() annotations
for the following fields:

- packets
- tin_dropped
- tin_ecn_mark
- ack_drops
- peak_delay
- avge_delay
- base_delay

Other annotations are added in following patches, to ease code review.

Fixes: 046f6fd5daef ("sched: Add Common Applications Kept Enhanced (cake) q=
disc")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Acked-by: "Toke H=C3=B8iland-J=C3=B8rgensen" <toke@toke.dk>
---
 net/sched/sch_cake.c | 38 ++++++++++++++++++++------------------
 1 file changed, 20 insertions(+), 18 deletions(-)

diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
index d7465ee4c5507467effd5aaaf8cfd05bcafde2cf..c5aae31565e984e40937b55201b=
498174a37180e 100644
--- a/net/sched/sch_cake.c
+++ b/net/sched/sch_cake.c
@@ -1600,7 +1600,7 @@ static unsigned int cake_drop(struct Qdisc *sch, stru=
ct sk_buff **to_free)
 	sch->qstats.backlog -=3D len;
=20
 	flow->dropped++;
-	b->tin_dropped++;
+	WRITE_ONCE(b->tin_dropped, b->tin_dropped + 1);
=20
 	if (q->config->rate_flags & CAKE_FLAG_INGRESS)
 		cake_advance_shaper(q, b, skb, now, true);
@@ -1820,7 +1820,7 @@ static s32 cake_enqueue(struct sk_buff *skb, struct Q=
disc *sch,
 			numsegs++;
 			slen +=3D segs->len;
 			q->buffer_used +=3D segs->truesize;
-			b->packets++;
+			WRITE_ONCE(b->packets, b->packets + 1);
 		}
=20
 		/* stats */
@@ -1844,7 +1844,7 @@ static s32 cake_enqueue(struct sk_buff *skb, struct Q=
disc *sch,
 			ack =3D cake_ack_filter(q, flow);
=20
 		if (ack) {
-			b->ack_drops++;
+			WRITE_ONCE(b->ack_drops, b->ack_drops + 1);
 			sch->qstats.drops++;
 			ack_pkt_len =3D qdisc_pkt_len(ack);
 			b->bytes +=3D ack_pkt_len;
@@ -1860,7 +1860,7 @@ static s32 cake_enqueue(struct sk_buff *skb, struct Q=
disc *sch,
 		}
=20
 		/* stats */
-		b->packets++;
+		WRITE_ONCE(b->packets, b->packets + 1);
 		b->bytes	    +=3D len - ack_pkt_len;
 		b->backlogs[idx]    +=3D len - ack_pkt_len;
 		b->tin_backlog      +=3D len - ack_pkt_len;
@@ -2236,7 +2236,7 @@ static struct sk_buff *cake_dequeue(struct Qdisc *sch=
)
 			b->tin_deficit -=3D len;
 		}
 		flow->dropped++;
-		b->tin_dropped++;
+		WRITE_ONCE(b->tin_dropped, b->tin_dropped + 1);
 		qdisc_tree_reduce_backlog(sch, 1, qdisc_pkt_len(skb));
 		qdisc_qstats_drop(sch);
 		qdisc_dequeue_drop(sch, skb, reason);
@@ -2244,17 +2244,19 @@ static struct sk_buff *cake_dequeue(struct Qdisc *s=
ch)
 			goto retry;
 	}
=20
-	b->tin_ecn_mark +=3D !!flow->cvars.ecn_marked;
+	WRITE_ONCE(b->tin_ecn_mark, b->tin_ecn_mark + !!flow->cvars.ecn_marked);
 	qdisc_bstats_update(sch, skb);
 	WRITE_ONCE(q->last_active, now);
=20
 	/* collect delay stats */
 	delay =3D ktime_to_ns(ktime_sub(now, cobalt_get_enqueue_time(skb)));
-	b->avge_delay =3D cake_ewma(b->avge_delay, delay, 8);
-	b->peak_delay =3D cake_ewma(b->peak_delay, delay,
-				  delay > b->peak_delay ? 2 : 8);
-	b->base_delay =3D cake_ewma(b->base_delay, delay,
-				  delay < b->base_delay ? 2 : 8);
+	WRITE_ONCE(b->avge_delay, cake_ewma(b->avge_delay, delay, 8));
+	WRITE_ONCE(b->peak_delay,
+		   cake_ewma(b->peak_delay, delay,
+			     delay > b->peak_delay ? 2 : 8));
+	WRITE_ONCE(b->base_delay,
+		   cake_ewma(b->base_delay, delay,
+			     delay < b->base_delay ? 2 : 8));
=20
 	len =3D cake_advance_shaper(q, b, skb, now, false);
 	flow->deficit -=3D len;
@@ -3042,17 +3044,17 @@ static int cake_dump_stats(struct Qdisc *sch, struc=
t gnet_dump *d)
 		PUT_TSTAT_U32(INTERVAL_US,
 			      ktime_to_us(ns_to_ktime(b->cparams.interval)));
=20
-		PUT_TSTAT_U32(SENT_PACKETS, b->packets);
-		PUT_TSTAT_U32(DROPPED_PACKETS, b->tin_dropped);
-		PUT_TSTAT_U32(ECN_MARKED_PACKETS, b->tin_ecn_mark);
-		PUT_TSTAT_U32(ACKS_DROPPED_PACKETS, b->ack_drops);
+		PUT_TSTAT_U32(SENT_PACKETS, READ_ONCE(b->packets));
+		PUT_TSTAT_U32(DROPPED_PACKETS, READ_ONCE(b->tin_dropped));
+		PUT_TSTAT_U32(ECN_MARKED_PACKETS, READ_ONCE(b->tin_ecn_mark));
+		PUT_TSTAT_U32(ACKS_DROPPED_PACKETS, READ_ONCE(b->ack_drops));
=20
 		PUT_TSTAT_U32(PEAK_DELAY_US,
-			      ktime_to_us(ns_to_ktime(b->peak_delay)));
+			      ktime_to_us(ns_to_ktime(READ_ONCE(b->peak_delay))));
 		PUT_TSTAT_U32(AVG_DELAY_US,
-			      ktime_to_us(ns_to_ktime(b->avge_delay)));
+			      ktime_to_us(ns_to_ktime(READ_ONCE(b->avge_delay))));
 		PUT_TSTAT_U32(BASE_DELAY_US,
-			      ktime_to_us(ns_to_ktime(b->base_delay)));
+			      ktime_to_us(ns_to_ktime(READ_ONCE(b->base_delay))));
=20
 		PUT_TSTAT_U32(WAY_INDIRECT_HITS, READ_ONCE(b->way_hits));
 		PUT_TSTAT_U32(WAY_MISSES, READ_ONCE(b->way_misses));
--=20
2.54.0.545.g6539524ca2-goog



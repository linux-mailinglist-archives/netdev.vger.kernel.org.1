Return-Path: <netdev+bounces-281265-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GIMgK00g72lu7QAAu9opvQ
	(envelope-from <netdev+bounces-281265-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 10:37:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ADC0C46F357
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 10:37:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 55349300B2A5
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 08:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B07539B96B;
	Mon, 27 Apr 2026 08:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Gdi6C+VC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7196939B972
	for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 08:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777278974; cv=none; b=O0yg/nt5/SrPYnq6uV+QnqIfucdI3fDmeNNytotNwP1yurNt/wbKqRuaaBseL2A9W5irOHFnn9KYRod9TVFjZ6deq7sA7A8lHlGYzBQFXYr6V58Un1jaTlUlDmtF56GqambLDJmYRgqQTsiUr5XEoLnJFmOPH178YZpyN00M58g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777278974; c=relaxed/simple;
	bh=9R/+SCk31mMHMwSinoNrq9rsFULMdq1DaQBFXqY7fMI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TPyFL4D6wfhEQjrO/YfZN5qLQrQTLA5txxO+WbhBinXr+kx2JxO+4qRA0fBI0TUu9NYuoN1+vYqFXBspNV7PHJlmb1u9v8wMqS9B74fH7zcraI3hSwgLPWINn5qUxQDI+hkGKOBpLrVab/ECtwUOu52NVWtquRftsKVLTm/GdRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Gdi6C+VC; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-8dd61e9d1faso2590685285a.2
        for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 01:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777278971; x=1777883771; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0khgoXU1UcNxwuoM/7urG7oG5w4C6yrDSFd/XqIzG9k=;
        b=Gdi6C+VCXMkKGT+0mT7Y55DhlFec/8PdXAE3FdzXUxgZTo4Sc2BxEsBo4UNeLZ803p
         HH8Fv71YdBi3rTmCb4pqks3AJG1QQgmkT78tCrO0JME+bS7bleh6S4b8rIuZ4wbSz1wR
         PPqtAPt0xkUEnovrjN5Trdh3m9oHtS+kxOmtflu5/WFb5m6gIhXN4SibbaCn1uYQg9eW
         /4w6vsCm3lJG7MAfN2FQdLSzUxrXmEmZAJRsAwuFyPKcSiMpZjbwJnxLB5rIxEYWgw0s
         OPr8WdCP0n0OpoDf263BgdOcbhnXkUel3SH3E84gq5q6GEeKWmVe0cB4gG/BkQsxyGha
         QIcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777278971; x=1777883771;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0khgoXU1UcNxwuoM/7urG7oG5w4C6yrDSFd/XqIzG9k=;
        b=Jz0z1UrqLvxiVk31DJvgBXIlFkkJuHzq5XuvXM0EZSZfQWp/OeJ+t+XvpSroVc6jVq
         FCdaXM3CrAkh/bTtpgTF70sZJaQp9VtnG9SOK2SVCteK8ZQdkHryUnPUqau3ftFYMo5Q
         kC/GgIuZuy8yB6w+g4fRQcSxFy74WkX0ywf8oOZOjeZsT1yJYHOH55zRcl3l8++BrCmG
         gGYHUODJzTWMlooNiWFd/BZqplmtSzupeTtkc/2EdZrDlWjSLjvj5D+IT+CpOZlWE09X
         XzdVHSv3iOFiIIZ2q8sTGM2/sPwZwI2k1a2Uhs1OmhBR1995hVJQB6xfU8/uAkQENBxY
         /t0Q==
X-Forwarded-Encrypted: i=1; AFNElJ+DfZf72nlMpEYsuvLHfROrqljDuze6HY9F/2j3Xboc27PdvxHZkSv6aG0kbnnW0vMqztpfxVs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRbgZzlVfhdRX7ywdW+bJer0sc5vvlz8R65JFX82hH3y/Ds7ZD
	h/JjBi7VPZXX1ZjOpgxnV7dNV2v0ZSH8Efm3HeiohM7cL4+gnTfq84rso+Keq63PuwlQ5sXaXwl
	IGvqZhxP4egasTg==
X-Received: from qknwk21.prod.google.com ([2002:a05:620a:5795:b0:8f4:ef44:fc38])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:4012:b0:8cf:d9a8:561b with SMTP id af79cd13be357-8e78baf8c89mr6380343285a.0.1777278971258;
 Mon, 27 Apr 2026 01:36:11 -0700 (PDT)
Date: Mon, 27 Apr 2026 08:36:03 +0000
In-Reply-To: <20260427083606.459355-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260427083606.459355-1-edumazet@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260427083606.459355-3-edumazet@google.com>
Subject: [PATCH v2 net 2/5] net/sched: sch_cake: annotate data-races in
 cake_dump_stats() (II)
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, 
	"=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?=" <toke@redhat.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, 
	"=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?=" <toke@toke.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: ADC0C46F357
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
	TAGGED_FROM(0.00)[bounces-281265-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,toke.dk:email]

cake_dump_stats() runs without qdisc spinlock being held.

In this second patch, I add READ_ONCE()/WRITE_ONCE() annotations
for the following fields:

- bulk_flow_count
- unresponsive_flow_count
- max_skblen
- flow_quantum

Other annotations are added in following patches, to ease code review.

Fixes: 046f6fd5daef ("sched: Add Common Applications Kept Enhanced (cake) q=
disc")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Acked-by: "Toke H=C3=B8iland-J=C3=B8rgensen" <toke@toke.dk>
---
 net/sched/sch_cake.c | 34 +++++++++++++++++++---------------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
index bcc601fc486b13ab1609134f1ee29ebdcb9e8a06..d7465ee4c5507467effd5aaaf8c=
fd05bcafde2cf 100644
--- a/net/sched/sch_cake.c
+++ b/net/sched/sch_cake.c
@@ -1590,7 +1590,8 @@ static unsigned int cake_drop(struct Qdisc *sch, stru=
ct sk_buff **to_free)
 	}
=20
 	if (cobalt_queue_full(&flow->cvars, &b->cparams, now))
-		b->unresponsive_flow_count++;
+		WRITE_ONCE(b->unresponsive_flow_count,
+			   b->unresponsive_flow_count + 1);
=20
 	len =3D qdisc_pkt_len(skb);
 	q->buffer_used      -=3D skb->truesize;
@@ -1795,7 +1796,7 @@ static s32 cake_enqueue(struct sk_buff *skb, struct Q=
disc *sch,
 	}
=20
 	if (unlikely(len > b->max_skblen))
-		b->max_skblen =3D len;
+		WRITE_ONCE(b->max_skblen, len);
=20
 	if (qdisc_pkt_segs(skb) > 1 && q->config->rate_flags & CAKE_FLAG_SPLIT_GS=
O) {
 		struct sk_buff *segs, *nskb;
@@ -1930,7 +1931,7 @@ static s32 cake_enqueue(struct sk_buff *skb, struct Q=
disc *sch,
 		 */
 		flow->set =3D CAKE_SET_BULK;
 		WRITE_ONCE(b->sparse_flow_count, b->sparse_flow_count - 1);
-		b->bulk_flow_count++;
+		WRITE_ONCE(b->bulk_flow_count, b->bulk_flow_count + 1);
=20
 		cake_inc_srchost_bulk_flow_count(b, flow, q->config->flow_mode);
 		cake_inc_dsthost_bulk_flow_count(b, flow, q->config->flow_mode);
@@ -2150,7 +2151,7 @@ static struct sk_buff *cake_dequeue(struct Qdisc *sch=
)
 		if (flow->set =3D=3D CAKE_SET_SPARSE) {
 			if (flow->head) {
 				WRITE_ONCE(b->sparse_flow_count, b->sparse_flow_count - 1);
-				b->bulk_flow_count++;
+				WRITE_ONCE(b->bulk_flow_count, b->bulk_flow_count + 1);
=20
 				cake_inc_srchost_bulk_flow_count(b, flow, q->config->flow_mode);
 				cake_inc_dsthost_bulk_flow_count(b, flow, q->config->flow_mode);
@@ -2177,7 +2178,8 @@ static struct sk_buff *cake_dequeue(struct Qdisc *sch=
)
 		if (!skb) {
 			/* this queue was actually empty */
 			if (cobalt_queue_empty(&flow->cvars, &b->cparams, now))
-				b->unresponsive_flow_count--;
+				WRITE_ONCE(b->unresponsive_flow_count,
+					   b->unresponsive_flow_count - 1);
=20
 			if (flow->cvars.p_drop || flow->cvars.count ||
 			    ktime_before(now, flow->cvars.drop_next)) {
@@ -2187,7 +2189,7 @@ static struct sk_buff *cake_dequeue(struct Qdisc *sch=
)
 				list_move_tail(&flow->flowchain,
 					       &b->decaying_flows);
 				if (flow->set =3D=3D CAKE_SET_BULK) {
-					b->bulk_flow_count--;
+					WRITE_ONCE(b->bulk_flow_count, b->bulk_flow_count - 1);
=20
 					cake_dec_srchost_bulk_flow_count(b, flow, q->config->flow_mode);
 					cake_dec_dsthost_bulk_flow_count(b, flow, q->config->flow_mode);
@@ -2206,7 +2208,7 @@ static struct sk_buff *cake_dequeue(struct Qdisc *sch=
)
 				    flow->set =3D=3D CAKE_SET_SPARSE_WAIT) {
 					WRITE_ONCE(b->sparse_flow_count, b->sparse_flow_count - 1);
 				} else if (flow->set =3D=3D CAKE_SET_BULK) {
-					b->bulk_flow_count--;
+					WRITE_ONCE(b->bulk_flow_count, b->bulk_flow_count - 1);
=20
 					cake_dec_srchost_bulk_flow_count(b, flow, q->config->flow_mode);
 					cake_dec_dsthost_bulk_flow_count(b, flow, q->config->flow_mode);
@@ -2329,9 +2331,9 @@ static void cake_set_rate(struct cake_tin_data *b, u6=
4 rate, u32 mtu,
 	u8  rate_shft =3D 0;
 	u64 rate_ns =3D 0;
=20
-	b->flow_quantum =3D 1514;
 	if (rate) {
-		b->flow_quantum =3D max(min(rate >> 12, 1514ULL), 300ULL);
+		WRITE_ONCE(b->flow_quantum,
+			   max(min(rate >> 12, 1514ULL), 300ULL));
 		rate_shft =3D 34;
 		rate_ns =3D ((u64)NSEC_PER_SEC) << rate_shft;
 		rate_ns =3D div64_u64(rate_ns, max(MIN_RATE, rate));
@@ -2339,8 +2341,10 @@ static void cake_set_rate(struct cake_tin_data *b, u=
64 rate, u32 mtu,
 			rate_ns >>=3D 1;
 			rate_shft--;
 		}
-	} /* else unlimited, ie. zero delay */
-
+	} else {
+		/* else unlimited, ie. zero delay */
+		WRITE_ONCE(b->flow_quantum, 1514);
+	}
 	b->tin_rate_bps  =3D rate;
 	b->tin_rate_ns   =3D rate_ns;
 	b->tin_rate_shft =3D rate_shft;
@@ -3056,11 +3060,11 @@ static int cake_dump_stats(struct Qdisc *sch, struc=
t gnet_dump *d)
=20
 		PUT_TSTAT_U32(SPARSE_FLOWS, READ_ONCE(b->sparse_flow_count) +
 					    READ_ONCE(b->decaying_flow_count));
-		PUT_TSTAT_U32(BULK_FLOWS, b->bulk_flow_count);
-		PUT_TSTAT_U32(UNRESPONSIVE_FLOWS, b->unresponsive_flow_count);
-		PUT_TSTAT_U32(MAX_SKBLEN, b->max_skblen);
+		PUT_TSTAT_U32(BULK_FLOWS, READ_ONCE(b->bulk_flow_count));
+		PUT_TSTAT_U32(UNRESPONSIVE_FLOWS, READ_ONCE(b->unresponsive_flow_count))=
;
+		PUT_TSTAT_U32(MAX_SKBLEN, READ_ONCE(b->max_skblen));
=20
-		PUT_TSTAT_U32(FLOW_QUANTUM, b->flow_quantum);
+		PUT_TSTAT_U32(FLOW_QUANTUM, READ_ONCE(b->flow_quantum));
 		nla_nest_end(d->skb, ts);
 	}
=20
--=20
2.54.0.545.g6539524ca2-goog



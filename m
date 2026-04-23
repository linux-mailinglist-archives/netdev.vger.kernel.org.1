Return-Path: <netdev+bounces-280698-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8GqsAvf16WnkpwIAu9opvQ
	(envelope-from <netdev+bounces-280698-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 12:35:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D434450C8C
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 12:35:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C148D314DBB2
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 10:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74A0D374731;
	Thu, 23 Apr 2026 10:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MTP4akrh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D799423BCEE
	for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 10:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776939812; cv=none; b=Z41s97/QrubfRae/PhQhjFq5ivR7pDsW5tBfwy9xTuBdY6uyv7TMI4c1q1vNJ4PRLzsm1w8NfqaZRSzeve9qQuUL9Kt7VsSrHY0aTjl07qbSVR0rfJfL1rA5CilVGCbQAO1zCnHSlNY2ikz9YdaU0QTlDdRYC1JIa5p6rTBTwEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776939812; c=relaxed/simple;
	bh=7XLQijXFSfUXa6wdTquuHn10RROSHLj4bNZvX0NbQAQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HLkSJFY0cLEDc66QjTJS+RpwBiavu0ycsJvW+32gh+HLR7cmvNkQK2U0eZ0AuEBmLNcTcOr0txrR3KTE6GLzUFg2C8Ah7fLJq6NII94ZMN+eI+F3JYqcubZSWDYtcMNUulT8A65gpulQJMhYiIjTJjqiavkIcIxNjVX0vQrN+aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MTP4akrh; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-8eaee67d1bcso692751285a.0
        for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 03:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776939810; x=1777544610; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/0QGCfQHriQpE01npTgJWBhIPzd28whWPsodjTbPNXg=;
        b=MTP4akrh0u5CCp69pHTsGJ1StSS86hhIQpDzXUyrQZ19xceelUgjUWqpiMPn0I0Jwc
         jrdAA/H/1btsHfjI7MacyDTOcC3GlYKvW12ENLHYe1Ww9N3KQAkQfeEKDtQzXHVSOIEU
         Sspj+KCsk7UL9pC/2t2Ar3ms6DE39/wsSjNMsH00ChIK2dRv+VFsUufnCY79XnWmiLtt
         4ZQPNzLs+HPNglbAvzmX+ijWr678FMmGUSpRcO5yhmDEhnhpacrEp7arrG9QKVj0N8Rc
         LMb6WXA3ckTqeL0jc1i4V2NfnOowAwTZ/6Kc/rV6jyP+HQ7or2iB5zgJ0SelrT4AWekt
         YEdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776939810; x=1777544610;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/0QGCfQHriQpE01npTgJWBhIPzd28whWPsodjTbPNXg=;
        b=HS+tey0iX5C15b6aXtpK404evkZMT46i4R6jfrYiTOoP1dbn6TajuZIbUdmYEB1fCp
         5Np+KD5E9+8E8r10X+19S4SmbyRPIopGjfNZgVLornZp1o/GqDR9v1qWdeePH2Sxc3yp
         OrL5RAAI6QwcyowJNEekAQK+1NEk2K0etQHYOUWqZyWwTlLf25xx2S6X/YHr/FQLIfkV
         tVHvwNdYx5ldnSlPjbsZadzgC20qW3q/ZWD0AHyNbaG3fhvFTq+lcDBTnoIEinGj3Rmy
         bss/dIFt7jPdC5XnZhi61nQ+yhRVoIXJ31BCP6LUl27gif8w7lhOltZY55FrTVS/DbaX
         2tJw==
X-Forwarded-Encrypted: i=1; AFNElJ+LOfTU3K0cPtZSr/wDj0nrTLEJTb74dYlsw3wtJvJxb9rlUcuW1OPugA1GbQYeB9xiiMjKVoU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvaPpnPswhzcotxAiQjUGK8YjZIs7YEq/21owMYBXAaZ+s4szw
	QuwlSNPdootEe3Uldt4JFa+ilGU+eLXPA/hA0/iZGoaMQPscl3FuRFQNc+iv+xCJW1HR8qm1EG/
	F00mhazOUY/a/oA==
X-Received: from qknrq10.prod.google.com ([2002:a05:620a:674a:b0:8eb:edf:f268])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:47c8:b0:8eb:41de:fb43 with SMTP id af79cd13be357-8eb41defe38mr1870711385a.10.1776939809455;
 Thu, 23 Apr 2026 03:23:29 -0700 (PDT)
Date: Thu, 23 Apr 2026 10:23:21 +0000
In-Reply-To: <20260423102324.3172448-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260423102324.3172448-1-edumazet@google.com>
X-Mailer: git-send-email 2.54.0.rc2.544.gc7ae2d5bb8-goog
Message-ID: <20260423102324.3172448-3-edumazet@google.com>
Subject: [PATCH net 2/5] net/sched: sch_cake: annotate data-races in
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
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,mojatatu.com,resnulli.us,redhat.com,vger.kernel.org,gmail.com,google.com,toke.dk];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280698-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[toke.dk:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5D434450C8C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
Cc: "Toke H=C3=B8iland-J=C3=B8rgensen" <toke@toke.dk>
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
2.54.0.rc2.544.gc7ae2d5bb8-goog



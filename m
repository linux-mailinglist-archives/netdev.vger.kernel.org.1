Return-Path: <netdev+bounces-280699-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IBeZKnP06WmepQIAu9opvQ
	(envelope-from <netdev+bounces-280699-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 12:29:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EA89450ABF
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 12:29:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CC4A930DE818
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 10:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F38623BCEE;
	Thu, 23 Apr 2026 10:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZM9LrLAr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9694037FF51
	for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 10:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776939814; cv=none; b=tN9R6ouzomdWJSHFpcSpaHwuXzYVT9Wzg6s6j2LRRhh1m58Xwaf6wgP2tGeM9dixlZrva/+UjY4hyRUQswIysmVOLmO7ulj7wKlYj66g0VsN+LyIxdW5ubGGRuCtofcy/OEyJukTGd0NTgrsAIG+iuyeRF5eD3Hom8ou8uRzQGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776939814; c=relaxed/simple;
	bh=7Wx8GMPAiBzWuATDGdMYvqj8JdNkE3Zz6G8UBvchaGc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HcE2GFsOBzzjuu00lPPHdXprfGry6bOORg1A/xgdn3dUElC9+o8ndE6Ym3+v1v/k9syOCLtxTU8nsQdQAPdg56rfKOS9OBTzs538Q/TBAUpuwrf8Nq0txv+5nPXiHCdOGRTOuuh8VKvYi/RiCqYwmuCNjlurBmNal5SVTrFmQ+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZM9LrLAr; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-8eb21daf7ddso672950985a.1
        for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 03:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776939811; x=1777544611; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/bs2oVJkJpvJmP9vHTdDwu8fvGAQQpg5YY2vaTiMdG0=;
        b=ZM9LrLArRjhlhsDbGC76UkS3HuxT9XFWLltobVCC9KqGHnPvBUd5Eg8wplxbSDy8im
         u44kVJ6uBUt58fUwKxpKqIHTJPu+59xQe2XCP2RnKSItrRyMpUdmde2g/IN4gIUya0jp
         Q27LbFzp0Ltj0BLX6ysk792zfXAfGMDvLkChsrJCKwFMmZedQhoZWDgNp74sz9s+eOXH
         WSCPrHgXe8EULS5HJGX1ZAdU+WdZEU4K3XDvq8FB+BR459pjE9niHGJpZczIigOBwXdf
         fW5grzLyTA9GP0dJfQ76IoIC69iUeEfP/EjaEG42mJdbYvCyuwpewlres13CNqGpCM/t
         PgXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776939811; x=1777544611;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/bs2oVJkJpvJmP9vHTdDwu8fvGAQQpg5YY2vaTiMdG0=;
        b=rjUoog1BB7sAJ+RWYkCo7Bbh5HvNzasYmfkbhGk3DeyUyMG1RIFx4UGV7o1J7k0ivo
         vivX0e0uRKCmc1DPvzwkD+hoQvP1s9qXHWcTIpWS38suzGr4DOqXdVOQE21+GigoIzJd
         F2Y6OHcuk5FHPeVb5ootBimK65RwAycU6sWYj1fG1k/iMbPQea2DijrfEv0Qi29Pkys5
         WuK2EObwb+SyG7Km48A+2KdSwN/xpy6xaCFYyPLTuSFlT5/aK3yP0BJv6FO02i9kgwz4
         oQwILT1OrruOAq5diF8F9XqxXuRnPR9JLjF7NtMDwiDFjAcLPnl3cFKfrJMhyPqFCUhB
         G5IA==
X-Forwarded-Encrypted: i=1; AFNElJ/1TTKE9GsYrk24VKrNHkJop72IsNxAwPinwWyfcRF0pVq7+f+rOPZrITdsDNcsQZKU6chJkTs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOMn3EBGrQTCapz480/W1Aktk3chvVp7m3wHeb94ScnzBAFA2b
	bPKZHo16kQDMJbawFaQXOX+bPp8e/L3YYYuoweKUNXJ47cOC7d7ZbiWJpofo+RwlrY0i4wpvTKc
	2OvfNLneZ103nww==
X-Received: from qkld26.prod.google.com ([2002:a05:620a:137a:b0:8d3:bb62:c8af])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:5dc3:b0:8eb:10d4:a471 with SMTP id af79cd13be357-8eb10d4b00emr1858315485a.43.1776939811280;
 Thu, 23 Apr 2026 03:23:31 -0700 (PDT)
Date: Thu, 23 Apr 2026 10:23:22 +0000
In-Reply-To: <20260423102324.3172448-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260423102324.3172448-1-edumazet@google.com>
X-Mailer: git-send-email 2.54.0.rc2.544.gc7ae2d5bb8-goog
Message-ID: <20260423102324.3172448-4-edumazet@google.com>
Subject: [PATCH net 3/5] net/sched: sch_cake: annotate data-races in
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
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,mojatatu.com,resnulli.us,redhat.com,vger.kernel.org,gmail.com,google.com,toke.dk];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280699-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[toke.dk:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4EA89450ABF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
Cc: "Toke H=C3=B8iland-J=C3=B8rgensen" <toke@toke.dk>
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
2.54.0.rc2.544.gc7ae2d5bb8-goog



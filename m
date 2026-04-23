Return-Path: <netdev+bounces-280700-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id z3BuKn/06WnApwIAu9opvQ
	(envelope-from <netdev+bounces-280700-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 12:29:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 35B57450AC7
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 12:29:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2E02330F2AA6
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 10:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C21F7388392;
	Thu, 23 Apr 2026 10:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fD13c3e5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BFE238737A
	for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 10:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776939815; cv=none; b=Eb8MxueAQtqmo39M+JCM4FSQdlZ/h/qy0/ru73MIZjTWV4CrqBCZ5pxnwI+gZbBdbL/iK0XVhs/lcoDz04EeAOxPU53BmBG+0vjTDTEDNN6Kc+hhyKR8DtD0uwvJ8r9hxu9MDxMWFLmXfmK+ZhAqoW35lkLrTAkMf+jWTYzp3I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776939815; c=relaxed/simple;
	bh=5USiF9JX7vne2vkKD6xxkl/ELUvYt13QPnCgFUwXjfw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iE7n2ND4tY2JPtNpwp2RwrV0eWu5i5l/NFubPJzuu/cK1IEfBOfoMBUq7wVIdPkFA6viT6XvQh+kZykFKuvt/jkpGTNMdUjaapQ7dVjf/ghAn9cD5r+SBifaPmCNBh2n4tyJVvMfOiY5dcCewhJhILLxq4V7bv/rjPvVRtXBtPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fD13c3e5; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-50fcdd579e1so7384531cf.1
        for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 03:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776939813; x=1777544613; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1p088oMi2SCzRRaEEh5jDtHzUNTmT+xWRnQrYeuJ6O0=;
        b=fD13c3e57nPNb5E1ugkag1MKR7LnV4HIaZlE1px70PFDGgghHAc39nO9GPk4G1C2CY
         ReiGC529AHbWglrTD3gKhigMkVq2sIycp5Y8ww4et+K64IturkSLvjg3m4zeotS+9oxO
         nLOrUL2c6T8YZiogDaQKVfncUe32b7fmiiGauAnGw9amEXixBJMh6Pjm9asHbTmI4S3G
         duehbNeMdsPRxUVKHoRCtv7oA6OWKxI2WCsYnKt9ZoLtTUnNAFppr/Te/zO6xBR+XtDD
         VghrFKQOJcMcsWvcbvHMiFsFvM4K0Rnf6XZA1dQ90uNEPaAcuQYEW6jaRBewHak+DLvH
         CU2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776939813; x=1777544613;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1p088oMi2SCzRRaEEh5jDtHzUNTmT+xWRnQrYeuJ6O0=;
        b=E/t6Qkbom4VWh4F2lVxrUlxgdYNjmKMSsZOHcoh5PI+e+83iIyaMiLVwRCwb0orQF1
         W+7EgVwxClyBN/FZzm+jMXBeSlwPZ6SB4EB5AlSXtJJio78MoyjPuHjFs5IiMfgj7mc8
         FraOfPIeoWTyTp5wx6ACTJ/zHZEZ+vY0dZ8VtEaGEO+51McSIsRH649JGLOatr4pedMD
         hVke/Ttt8kVJuyUqCj+kdBCZmDqSeJX7Z+lyF87L5/7f/U/2uDc1yEgAFpMfRioacUwh
         qjHmTrCjJr0Uc5Uq0Rxj+AK+qjUJfIo0u7JhzIPn/8yXtULFYPXu+1ob81ofS9PpH8Lb
         tbJw==
X-Forwarded-Encrypted: i=1; AFNElJ9TzGR6Lg4qP2lWEMvwflqrT/bGtv2/OgUS1TtXscHBGLPH4xLk2LpkiieS3Z2LC7RRJUj33IM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzSrBXnsU669vnHB871b9FZyja3/vadgXF4OfXTZZy5ushJAdl
	gGyGQGU8/h7tVutKfh//RA/6IIA2DCx5G8wzMoZaNgObXLw/CykmyQkYSSISdMVyLefsWHrzod0
	jgGV3nrEjmha+Zw==
X-Received: from qtnc23.prod.google.com ([2002:ac8:5197:0:b0:50d:40ca:3d44])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:1f99:b0:50d:a987:89b2 with SMTP id d75a77b69052e-50e36c12741mr381790911cf.31.1776939812969;
 Thu, 23 Apr 2026 03:23:32 -0700 (PDT)
Date: Thu, 23 Apr 2026 10:23:23 +0000
In-Reply-To: <20260423102324.3172448-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260423102324.3172448-1-edumazet@google.com>
X-Mailer: git-send-email 2.54.0.rc2.544.gc7ae2d5bb8-goog
Message-ID: <20260423102324.3172448-5-edumazet@google.com>
Subject: [PATCH net 4/5] net/sched: sch_cake: annotate data-races in
 cake_dump_stats() (IV)
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,mojatatu.com,resnulli.us,redhat.com,vger.kernel.org,gmail.com,google.com,toke.dk];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280700-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[toke.dk:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 35B57450AC7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

cake_dump_stats() runs without qdisc spinlock being held.

In this fourth patch, I add READ_ONCE()/WRITE_ONCE() annotations
for the following fields:

- avg_peak_bandwidth
- buffer_limit
- buffer_max_used
- avg_netoff
- max_netlen
- max_adjlen
- min_netlen
- min_adjlen
- active_queues
- tin_rate_bps
- bytes
- tin_backlog

Other annotations are added in following patch, to ease code review.

Fixes: 046f6fd5daef ("sched: Add Common Applications Kept Enhanced (cake) q=
disc")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: "Toke H=C3=B8iland-J=C3=B8rgensen" <toke@toke.dk>
---
 net/sched/sch_cake.c | 90 ++++++++++++++++++++++----------------------
 1 file changed, 46 insertions(+), 44 deletions(-)

diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
index c5aae31565e984e40937b55201b498174a37180e..c3b09f67f0fdbc51d23b3d22df9=
ab89a716c7e2b 100644
--- a/net/sched/sch_cake.c
+++ b/net/sched/sch_cake.c
@@ -1379,9 +1379,9 @@ static u32 cake_calc_overhead(struct cake_sched_data =
*qd, u32 len, u32 off)
 		len -=3D off;
=20
 	if (qd->max_netlen < len)
-		qd->max_netlen =3D len;
+		WRITE_ONCE(qd->max_netlen, len);
 	if (qd->min_netlen > len)
-		qd->min_netlen =3D len;
+		WRITE_ONCE(qd->min_netlen, len);
=20
 	len +=3D q->rate_overhead;
=20
@@ -1401,9 +1401,9 @@ static u32 cake_calc_overhead(struct cake_sched_data =
*qd, u32 len, u32 off)
 	}
=20
 	if (qd->max_adjlen < len)
-		qd->max_adjlen =3D len;
+		WRITE_ONCE(qd->max_adjlen, len);
 	if (qd->min_adjlen > len)
-		qd->min_adjlen =3D len;
+		WRITE_ONCE(qd->min_adjlen, len);
=20
 	return len;
 }
@@ -1416,7 +1416,7 @@ static u32 cake_overhead(struct cake_sched_data *q, c=
onst struct sk_buff *skb)
 	u16 segs =3D qdisc_pkt_segs(skb);
 	u32 len =3D qdisc_pkt_len(skb);
=20
-	q->avg_netoff =3D cake_ewma(q->avg_netoff, off << 16, 8);
+	WRITE_ONCE(q->avg_netoff, cake_ewma(q->avg_netoff, off << 16, 8));
=20
 	if (segs =3D=3D 1)
 		return cake_calc_overhead(q, len, off);
@@ -1596,7 +1596,7 @@ static unsigned int cake_drop(struct Qdisc *sch, stru=
ct sk_buff **to_free)
 	len =3D qdisc_pkt_len(skb);
 	q->buffer_used      -=3D skb->truesize;
 	b->backlogs[idx]    -=3D len;
-	b->tin_backlog      -=3D len;
+	WRITE_ONCE(b->tin_backlog, b->tin_backlog - len);
 	sch->qstats.backlog -=3D len;
=20
 	flow->dropped++;
@@ -1824,9 +1824,9 @@ static s32 cake_enqueue(struct sk_buff *skb, struct Q=
disc *sch,
 		}
=20
 		/* stats */
-		b->bytes	    +=3D slen;
+		WRITE_ONCE(b->bytes, b->bytes + slen);
 		b->backlogs[idx]    +=3D slen;
-		b->tin_backlog      +=3D slen;
+		WRITE_ONCE(b->tin_backlog, b->tin_backlog + slen);
 		sch->qstats.backlog +=3D slen;
 		q->avg_window_bytes +=3D slen;
=20
@@ -1847,7 +1847,7 @@ static s32 cake_enqueue(struct sk_buff *skb, struct Q=
disc *sch,
 			WRITE_ONCE(b->ack_drops, b->ack_drops + 1);
 			sch->qstats.drops++;
 			ack_pkt_len =3D qdisc_pkt_len(ack);
-			b->bytes +=3D ack_pkt_len;
+			WRITE_ONCE(b->bytes, b->bytes + ack_pkt_len);
 			q->buffer_used +=3D skb->truesize - ack->truesize;
 			if (q->config->rate_flags & CAKE_FLAG_INGRESS)
 				cake_advance_shaper(q, b, ack, now, true);
@@ -1861,9 +1861,9 @@ static s32 cake_enqueue(struct sk_buff *skb, struct Q=
disc *sch,
=20
 		/* stats */
 		WRITE_ONCE(b->packets, b->packets + 1);
-		b->bytes	    +=3D len - ack_pkt_len;
+		WRITE_ONCE(b->bytes, b->bytes + len - ack_pkt_len);
 		b->backlogs[idx]    +=3D len - ack_pkt_len;
-		b->tin_backlog      +=3D len - ack_pkt_len;
+		WRITE_ONCE(b->tin_backlog, b->tin_backlog + len - ack_pkt_len);
 		sch->qstats.backlog +=3D len - ack_pkt_len;
 		q->avg_window_bytes +=3D len - ack_pkt_len;
 	}
@@ -1895,9 +1895,9 @@ static s32 cake_enqueue(struct sk_buff *skb, struct Q=
disc *sch,
 			u64 b =3D q->avg_window_bytes * (u64)NSEC_PER_SEC;
=20
 			b =3D div64_u64(b, window_interval);
-			q->avg_peak_bandwidth =3D
-				cake_ewma(q->avg_peak_bandwidth, b,
-					  b > q->avg_peak_bandwidth ? 2 : 8);
+			WRITE_ONCE(q->avg_peak_bandwidth,
+				   cake_ewma(q->avg_peak_bandwidth, b,
+					     b > q->avg_peak_bandwidth ? 2 : 8));
 			q->avg_window_bytes =3D 0;
 			q->avg_window_begin =3D now;
=20
@@ -1938,7 +1938,7 @@ static s32 cake_enqueue(struct sk_buff *skb, struct Q=
disc *sch,
 	}
=20
 	if (q->buffer_used > q->buffer_max_used)
-		q->buffer_max_used =3D q->buffer_used;
+		WRITE_ONCE(q->buffer_max_used, q->buffer_used);
=20
 	if (q->buffer_used <=3D q->buffer_limit)
 		return NET_XMIT_SUCCESS;
@@ -1978,7 +1978,7 @@ static struct sk_buff *cake_dequeue_one(struct Qdisc =
*sch)
 		skb =3D dequeue_head(flow);
 		len =3D qdisc_pkt_len(skb);
 		b->backlogs[q->cur_flow] -=3D len;
-		b->tin_backlog		 -=3D len;
+		WRITE_ONCE(b->tin_backlog, b->tin_backlog - len);
 		sch->qstats.backlog      -=3D len;
 		q->buffer_used		 -=3D skb->truesize;
 		sch->q.qlen--;
@@ -2043,7 +2043,7 @@ static struct sk_buff *cake_dequeue(struct Qdisc *sch=
)
=20
 		cake_configure_rates(sch, new_rate, true);
 		q->last_checked_active =3D now;
-		q->active_queues =3D num_active_qs;
+		WRITE_ONCE(q->active_queues, num_active_qs);
 	}
=20
 begin:
@@ -2347,7 +2347,7 @@ static void cake_set_rate(struct cake_tin_data *b, u6=
4 rate, u32 mtu,
 		/* else unlimited, ie. zero delay */
 		WRITE_ONCE(b->flow_quantum, 1514);
 	}
-	b->tin_rate_bps  =3D rate;
+	WRITE_ONCE(b->tin_rate_bps, rate);
 	b->tin_rate_ns   =3D rate_ns;
 	b->tin_rate_shft =3D rate_shft;
=20
@@ -2617,25 +2617,27 @@ static void cake_reconfigure(struct Qdisc *sch)
 {
 	struct cake_sched_data *qd =3D qdisc_priv(sch);
 	struct cake_sched_config *q =3D qd->config;
+	u32 buffer_limit;
=20
 	cake_configure_rates(sch, qd->config->rate_bps, false);
=20
 	if (q->buffer_config_limit) {
-		qd->buffer_limit =3D q->buffer_config_limit;
+		buffer_limit =3D q->buffer_config_limit;
 	} else if (q->rate_bps) {
 		u64 t =3D q->rate_bps * q->interval;
=20
 		do_div(t, USEC_PER_SEC / 4);
-		qd->buffer_limit =3D max_t(u32, t, 4U << 20);
+		buffer_limit =3D max_t(u32, t, 4U << 20);
 	} else {
-		qd->buffer_limit =3D ~0;
+		buffer_limit =3D ~0;
 	}
=20
 	sch->flags &=3D ~TCQ_F_CAN_BYPASS;
=20
-	qd->buffer_limit =3D min(qd->buffer_limit,
-			       max(sch->limit * psched_mtu(qdisc_dev(sch)),
-				   q->buffer_config_limit));
+	WRITE_ONCE(qd->buffer_limit,
+		   min(buffer_limit,
+		       max(sch->limit * psched_mtu(qdisc_dev(sch)),
+			   q->buffer_config_limit)));
 }
=20
 static int cake_config_change(struct cake_sched_config *q, struct nlattr *=
opt,
@@ -2780,10 +2782,10 @@ static int cake_change(struct Qdisc *sch, struct nl=
attr *opt,
 		return ret;
=20
 	if (overhead_changed) {
-		qd->max_netlen =3D 0;
-		qd->max_adjlen =3D 0;
-		qd->min_netlen =3D ~0;
-		qd->min_adjlen =3D ~0;
+		WRITE_ONCE(qd->max_netlen, 0);
+		WRITE_ONCE(qd->max_adjlen, 0);
+		WRITE_ONCE(qd->min_netlen, ~0);
+		WRITE_ONCE(qd->min_adjlen, ~0);
 	}
=20
 	if (qd->tins) {
@@ -3001,15 +3003,15 @@ static int cake_dump_stats(struct Qdisc *sch, struc=
t gnet_dump *d)
 			goto nla_put_failure;			       \
 	} while (0)
=20
-	PUT_STAT_U64(CAPACITY_ESTIMATE64, q->avg_peak_bandwidth);
-	PUT_STAT_U32(MEMORY_LIMIT, q->buffer_limit);
-	PUT_STAT_U32(MEMORY_USED, q->buffer_max_used);
-	PUT_STAT_U32(AVG_NETOFF, ((q->avg_netoff + 0x8000) >> 16));
-	PUT_STAT_U32(MAX_NETLEN, q->max_netlen);
-	PUT_STAT_U32(MAX_ADJLEN, q->max_adjlen);
-	PUT_STAT_U32(MIN_NETLEN, q->min_netlen);
-	PUT_STAT_U32(MIN_ADJLEN, q->min_adjlen);
-	PUT_STAT_U32(ACTIVE_QUEUES, q->active_queues);
+	PUT_STAT_U64(CAPACITY_ESTIMATE64, READ_ONCE(q->avg_peak_bandwidth));
+	PUT_STAT_U32(MEMORY_LIMIT, READ_ONCE(q->buffer_limit));
+	PUT_STAT_U32(MEMORY_USED, READ_ONCE(q->buffer_max_used));
+	PUT_STAT_U32(AVG_NETOFF, ((READ_ONCE(q->avg_netoff) + 0x8000) >> 16));
+	PUT_STAT_U32(MAX_NETLEN, READ_ONCE(q->max_netlen));
+	PUT_STAT_U32(MAX_ADJLEN, READ_ONCE(q->max_adjlen));
+	PUT_STAT_U32(MIN_NETLEN, READ_ONCE(q->min_netlen));
+	PUT_STAT_U32(MIN_ADJLEN, READ_ONCE(q->min_adjlen));
+	PUT_STAT_U32(ACTIVE_QUEUES, READ_ONCE(q->active_queues));
=20
 #undef PUT_STAT_U32
 #undef PUT_STAT_U64
@@ -3035,9 +3037,9 @@ static int cake_dump_stats(struct Qdisc *sch, struct =
gnet_dump *d)
 		if (!ts)
 			goto nla_put_failure;
=20
-		PUT_TSTAT_U64(THRESHOLD_RATE64, b->tin_rate_bps);
-		PUT_TSTAT_U64(SENT_BYTES64, b->bytes);
-		PUT_TSTAT_U32(BACKLOG_BYTES, b->tin_backlog);
+		PUT_TSTAT_U64(THRESHOLD_RATE64, READ_ONCE(b->tin_rate_bps));
+		PUT_TSTAT_U64(SENT_BYTES64, READ_ONCE(b->bytes));
+		PUT_TSTAT_U32(BACKLOG_BYTES, READ_ONCE(b->tin_backlog));
=20
 		PUT_TSTAT_U32(TARGET_US,
 			      ktime_to_us(ns_to_ktime(b->cparams.target)));
@@ -3304,10 +3306,10 @@ static int cake_mq_change(struct Qdisc *sch, struct=
 nlattr *opt,
 		struct cake_sched_data *qd =3D qdisc_priv(chld);
=20
 		if (overhead_changed) {
-			qd->max_netlen =3D 0;
-			qd->max_adjlen =3D 0;
-			qd->min_netlen =3D ~0;
-			qd->min_adjlen =3D ~0;
+			WRITE_ONCE(qd->max_netlen, 0);
+			WRITE_ONCE(qd->max_adjlen, 0);
+			WRITE_ONCE(qd->min_netlen, ~0);
+			WRITE_ONCE(qd->min_adjlen, ~0);
 		}
=20
 		if (qd->tins) {
--=20
2.54.0.rc2.544.gc7ae2d5bb8-goog



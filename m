Return-Path: <netdev+bounces-277512-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2PZNFfFA2WkHnwgAu9opvQ
	(envelope-from <netdev+bounces-277512-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 20:26:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ACA3B3DB726
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 20:26:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5105B301982D
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 18:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E6793DC4D1;
	Fri, 10 Apr 2026 18:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qtQLthDU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C2178F29
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 18:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775845409; cv=none; b=oHaoVm4HH4zyrGuZPuQoc2YRZ+LQniVMgoVvat64ObhnKUFv4fOQxnaNNHXzglcC3/ITyKsQTeNDvjwBhB+us95X2mzw7v+8ZiSsa9zKQ4bi7KHy2RWbUD4lPcZvx0xkX2Kjqw2Lf/RzerD98dZAeR3ySR/KLDtnCtZjpdgKOH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775845409; c=relaxed/simple;
	bh=K9d44KQDeEWHNSllzrUTy0gLgc056e+wl1b1hL3dSY8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Self6VXX6ZuKMS+SXpP6LW6XVo+hcenRUXT6zmMlYPPi9f4ZAt2ds0IK8oViT+HkdvVw72AyPSLEmFjzK70++UFqR+dZMYQu/1nQN7vDuBOF+3MafzvRXv/SPpkeWmHWdizle0QOjTPSot46NUCvyn7i/Xk/7+A8Qrq4y2LRsiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qtQLthDU; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-50d68dbb77bso7773991cf.2
        for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 11:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775845407; x=1776450207; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Qp/OLL06Dqe7i66SOntwCo2pOiy130tu28jOnMwLnlc=;
        b=qtQLthDU1faWcuMSEizFkLrNgvi6G+8ZuEtLkbzlVXlh5C2GJSuAGr0fmRFUKXrDjB
         F0oxipH/rYhAcvzy2mZmNnREDsBwYJDHf2IoKuO8ZiNLQr4h1pc9kxpZw4wqn/P7Vk2E
         kBmAaChPMKMpFfM2tjozNOE7C/1+ncozGNqfHHdD6tHKQUJ9/MlRx3uXy4ElFBqRLNHC
         VPJ9nYZAqcGw1Mp88q1DvW8bnjMZN1DgTgstnf15+456t85ROIz5Z8O8VN9Ma7acgZji
         WBoD1xee7SvP27G9ZUJDuoco2ZMjOxRio30/zu8kDO5jwukS9oWhpe5IE56fzIzQYcEU
         FwLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775845407; x=1776450207;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qp/OLL06Dqe7i66SOntwCo2pOiy130tu28jOnMwLnlc=;
        b=OzPDmuzl+rzImtzUxbLTT2pKBql3a6rb1Av/dUCXKuyoXshwG4XTeh+CfNiqOzHDFT
         Ewnt+81NrXTC5sa++Bgdq1CT6sjGtJgRAEpiVdF1C4s7ZWaSdm18rXo/bX06yj9UzV1P
         i193EQW9TYQLjha4aulsTUoC5uhups3SwLqmYCt50crU1m0W3gjtwHVY55ObU0ecNQcy
         p1OhTebIEQTOQWkIEnClH141UArymw93RDQdM+gZvwpMwAtnp35iaA6gJSsrJvX6K/mw
         Gy4pJyz3G7i6hFGgjWxl7WYBqLR5CXcApfDE6X9DZKx1jnEyHYnRaWtLkF5g7zSCxNwb
         BbHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVALpeTgD79+3LbLytSA2hFtUgei7fGl7XbZ1ylu3uJ1AmxVuc6MU5NGg++NQ/fRNFTKNQQLX8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFe1cWSxutgO1bK5fGpnTXDHUAM2uPjiZUYR3+h44xFetsJQ4w
	/UGFSePHkdx6IRUPbtnpGZ28mw04l2CfaO1E3n+KK3mw17HT2s5T4PBDGoEnEvZgCBC4REkS1jG
	2ih0lQ34XY3bQ3g==
X-Received: from qtnd15.prod.google.com ([2002:ac8:51cf:0:b0:50b:2f12:4f2a])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:5d14:0:b0:50b:2640:22e3 with SMTP id d75a77b69052e-50dd5ad0c53mr64383771cf.11.1775845406423;
 Fri, 10 Apr 2026 11:23:26 -0700 (PDT)
Date: Fri, 10 Apr 2026 18:22:54 +0000
In-Reply-To: <20260410182257.774311-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260410182257.774311-1-edumazet@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260410182257.774311-13-edumazet@google.com>
Subject: [PATCH v3 net-next 12/15] net/sched: sch_choke: annotate data-races
 in choke_dump_stats()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,mojatatu.com,resnulli.us,vger.kernel.org,gmail.com,google.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277512-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: ACA3B3DB726
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

choke_dump_stats() only runs with RTNL held,
reading fields that can be changed in qdisc fast path.

Add READ_ONCE()/WRITE_ONCE() annotations.

Fixes: edb09eb17ed8 ("net: sched: do not acquire qdisc spinlock in qdisc/class stats dump")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/sched/sch_choke.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/net/sched/sch_choke.c b/net/sched/sch_choke.c
index cd0785ad8e74314e6d5c88144ffcf64f286e02dd..73d3e673dc7b16cf2b9ac1d622da280c2ceb064a 100644
--- a/net/sched/sch_choke.c
+++ b/net/sched/sch_choke.c
@@ -229,7 +229,7 @@ static int choke_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 
 		/* Draw a packet at random from queue and compare flow */
 		if (choke_match_random(q, skb, &idx)) {
-			q->stats.matched++;
+			WRITE_ONCE(q->stats.matched, q->stats.matched + 1);
 			choke_drop_by_idx(sch, idx, to_free);
 			goto congestion_drop;
 		}
@@ -241,11 +241,13 @@ static int choke_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 			qdisc_qstats_overlimit(sch);
 			if (use_harddrop(q) || !use_ecn(q) ||
 			    !INET_ECN_set_ce(skb)) {
-				q->stats.forced_drop++;
+				WRITE_ONCE(q->stats.forced_drop,
+					   q->stats.forced_drop + 1);
 				goto congestion_drop;
 			}
 
-			q->stats.forced_mark++;
+			WRITE_ONCE(q->stats.forced_mark,
+				   q->stats.forced_mark + 1);
 		} else if (++q->vars.qcount) {
 			if (red_mark_probability(p, &q->vars, q->vars.qavg)) {
 				q->vars.qcount = 0;
@@ -253,11 +255,13 @@ static int choke_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 
 				qdisc_qstats_overlimit(sch);
 				if (!use_ecn(q) || !INET_ECN_set_ce(skb)) {
-					q->stats.prob_drop++;
+					WRITE_ONCE(q->stats.prob_drop,
+					           q->stats.prob_drop + 1);
 					goto congestion_drop;
 				}
 
-				q->stats.prob_mark++;
+				WRITE_ONCE(q->stats.prob_mark,
+					   q->stats.prob_mark + 1);
 			}
 		} else
 			q->vars.qR = red_random(p);
@@ -272,7 +276,7 @@ static int choke_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 		return NET_XMIT_SUCCESS;
 	}
 
-	q->stats.pdrop++;
+	WRITE_ONCE(q->stats.pdrop, q->stats.pdrop + 1);
 	return qdisc_drop(skb, sch, to_free);
 
 congestion_drop:
@@ -461,10 +465,12 @@ static int choke_dump_stats(struct Qdisc *sch, struct gnet_dump *d)
 {
 	struct choke_sched_data *q = qdisc_priv(sch);
 	struct tc_choke_xstats st = {
-		.early	= q->stats.prob_drop + q->stats.forced_drop,
-		.marked	= q->stats.prob_mark + q->stats.forced_mark,
-		.pdrop	= q->stats.pdrop,
-		.matched = q->stats.matched,
+		.early	= READ_ONCE(q->stats.prob_drop) +
+			  READ_ONCE(q->stats.forced_drop),
+		.marked	= READ_ONCE(q->stats.prob_mark) +
+			  READ_ONCE(q->stats.forced_mark),
+		.pdrop	= READ_ONCE(q->stats.pdrop),
+		.matched = READ_ONCE(q->stats.matched),
 	};
 
 	return gnet_stats_copy_app(d, &st, sizeof(st));
-- 
2.53.0.1213.gd9a14994de-goog



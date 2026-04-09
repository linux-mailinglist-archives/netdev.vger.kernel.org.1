Return-Path: <netdev+bounces-277145-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QNjjF3sf2GlaYAgAu9opvQ
	(envelope-from <netdev+bounces-277145-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 23:51:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B45513D0070
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 23:51:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6032330414BF
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 21:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E37C378D89;
	Thu,  9 Apr 2026 21:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nyI/lh8U"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FDFA35B658
	for <netdev@vger.kernel.org>; Thu,  9 Apr 2026 21:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775771380; cv=none; b=a5iKQ9WSfILa6cH5caFMmzaW4dk23STdSaXEjkfNNFtL6gPziUtKkUolR6InbzA91yMpy37HAc7hyYTvantJmU7lVVOim7kyBJJO3JVT/bJ4zM3uvpkTZiP2n36qq1JW+4BYKvXEMzyNZt2bp+T1103j/XjNTXp25cF07LKZmBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775771380; c=relaxed/simple;
	bh=K9d44KQDeEWHNSllzrUTy0gLgc056e+wl1b1hL3dSY8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OHy6cIbWuKzDpqJn94p6Si+JU5ClfxfxddVRWHyndVk3YBLK+2IG4nZtcekRnRiz1ukHAxq9PzyRTHXkboCY25uZRZCH2ML+zNz0/gVQJlRabPx34EANK72gZB5wfz+X2BTc4Y1MGsHutzSf6L3VcwU2hLW0fAf4nIdfse5LEyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nyI/lh8U; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-50b4031b86dso41529491cf.0
        for <netdev@vger.kernel.org>; Thu, 09 Apr 2026 14:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775771378; x=1776376178; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Qp/OLL06Dqe7i66SOntwCo2pOiy130tu28jOnMwLnlc=;
        b=nyI/lh8UrJ/CXt76cw5XQJJhZZO2rikRtZxDAwfxJAz5QvV47Hh0JQ9MOhXPXFwo8p
         OtRs/KI2ezCkRCXpG9aluy20wKz79Q+ic0tPRiymSQNXFu7KwD1LxisQ36ywcYJg94Y9
         cjxUlMo+MnOhB+e3JKk4UaBytgcsRqH+FRg47OKq1+JtWwvWWufTrHvOviloT3zJnLAU
         nf3nojwOmqed51oSC6wmtIt8NfefMdcc+avY7GLgz16tfNUVkGr6LDxhYC9DbahJUeka
         DvVsf0tWWIbA4AekF8mPoMpOjjxTPy8AcskU77dwJRFt3BYFqyEN4G9B+2PYWQ0wUJMp
         z6pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775771378; x=1776376178;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qp/OLL06Dqe7i66SOntwCo2pOiy130tu28jOnMwLnlc=;
        b=mqVYdeRUECyhBGcQBgnFcTjiw8ZWOMwxpdJoeDoBtiXMaZmJnzzc64FEEboyH/lW3s
         8/VPAQlRIHRlOva9r9XPuu9iFTMa+eBSkKpUX7AvyH2wAZYqssjECIHu+cm0NmM+yk7l
         XQx2omhl+250K6PtsMK41MjpQ3rcOHU12zHDg0BpcKzt36PfPdCeCBfS+08wFctjW115
         bkx6J8kzfjm7h9HTiepzqBEQlDyd/W/lR9Uo1mf/IGtFtJyCbChz2gtY7R05S49O7VUc
         b04jXNQFtaDSbTE3kQUtnEkv9w3SWhLElkUmHYV3Dp8YJ5SK9bXZEceEQ5edP2bSOAUB
         gFyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUrqKA+wz7+Ly99w3mc2zrx0ps/Epwdbb4MsuPqMnr5iAWJcjT1r9YHTxW0JBldi8jTT7gzvvU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaJ7oKW0NH7VUzeLjbI8Ug3QmlUfO+jS9iW3yhPYHQcvvK9NgK
	vbgayqIonjVbRF7iPYMhBUEn/keMm83Z5IPqmTBQymPuYq3KNfzTsfBG4JGGW6sn0at5DLjTX8z
	azN3K+VOR6MXDkg==
X-Received: from qtbkf17.prod.google.com ([2002:a05:622a:2a91:b0:50d:3e7a:321d])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:2485:b0:50b:50bf:5bbe with SMTP id d75a77b69052e-50dd5adbf6fmr14797641cf.22.1775771378073;
 Thu, 09 Apr 2026 14:49:38 -0700 (PDT)
Date: Thu,  9 Apr 2026 21:49:11 +0000
In-Reply-To: <20260409214914.3072827-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260409214914.3072827-1-edumazet@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260409214914.3072827-13-edumazet@google.com>
Subject: [PATCH v2 net-next 12/15] net/sched: sch_choke: annotate data-races
 in choke_dump_stats()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,mojatatu.com,resnulli.us,google.com,vger.kernel.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277145-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B45513D0070
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



Return-Path: <netdev+bounces-276527-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WPG9IM1Q1mm8DQgAu9opvQ
	(envelope-from <netdev+bounces-276527-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 14:57:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 013C23BC79D
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 14:57:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 985B430651E0
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 12:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 115A43BBA01;
	Wed,  8 Apr 2026 12:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UlLVM/wj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com [209.85.219.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E263C9420
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 12:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775652998; cv=none; b=tO+ucO/3IIHtavAKEywp7vHCHuOnZtqNiOae5/pHulwORxvh7n5o+3HkpM3RYe6b/pVar1sU4cNUjvIL6YMhZRtp5PmV+Vngzd1x6r7PigxP3y9miBAqKv7eOOn/eCJKNAT7CXIrrpAmcmq3OQpWQIAYNfpX0FBuZMmfoo9qJoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775652998; c=relaxed/simple;
	bh=K9d44KQDeEWHNSllzrUTy0gLgc056e+wl1b1hL3dSY8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gi87LhJc8Nsqp8d+87XtjGUDLLQ1kqzTDVl6+XwN+BO9ApL9tZCEamGi/a8TvFv+ltFKjeX2dGnfsoPKm3K+zBUUzQR9dV3StGUuk96zT2+74l2W822dRHVYxVZytAFT+Zmp5eKnGWeFYeOjOAI+h9cLHWWrKQaUqKMWFCPUehM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UlLVM/wj; arc=none smtp.client-ip=209.85.219.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f74.google.com with SMTP id 6a1803df08f44-8a8ea3f1becso124426446d6.0
        for <netdev@vger.kernel.org>; Wed, 08 Apr 2026 05:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775652995; x=1776257795; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Qp/OLL06Dqe7i66SOntwCo2pOiy130tu28jOnMwLnlc=;
        b=UlLVM/wjcR5uy7nkVqtLe2a9ZbmizvA/KdF9plfDDD6Ln/pIa5V1kHZTl2oYtjhw2B
         DJ9zsqaROa26aiD6H6e1DYtLuV2ZXQlveErOwyuS8579s5Lz3bUtwvEzp5VjoEXYtCDO
         wC4vyWQor2NMKLppyuQ6uAmRMAgtbbDMg0jvdJ0I1xMg7yn6Oms2Cb3LijtQNVupmhry
         oSxPzAQtBRmE78nNpZiCHS31BgCxMqoRc+P4SR4lxwu+MMqjbiqRJQILA2VpB1zjlcIz
         JvAr+doxUunI9O4HP387Oo2SrlEfdOHXNBFqyu2A1NYEOj5Uc8+mxZxsQIDov5bOaJWa
         dVGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775652995; x=1776257795;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qp/OLL06Dqe7i66SOntwCo2pOiy130tu28jOnMwLnlc=;
        b=PcDcZe4qW/fk0Ltuo7ICiEFwVdlCLReCD1trQNWirdnTp1j9b5zwCzGlmxSS/jlHx6
         j0j9DpfJkqLRFD2ZRiAQYGffrdcn0BzFfJ/Sev9lCXoPfLAM24/IusdY0y/q+56rKaUz
         qcZSankpUDvmDo0yU4Teb0Q7PsT7nYujPHd8a+drgiWU7dA3A+XMxDwj1tfzygak1sMd
         0LPk9ngwrKn7PMfhETraK6CjkmTiWeTnciJxF9/p7pgTdotugTEG4+0pxrPl2dSWgZm1
         N/C/wnf7oKiZ4uzwCw63xn/X1Ssl1YtH93mthash683AcwZaO+25S6IrdV0SYiqWzxnv
         jAYA==
X-Forwarded-Encrypted: i=1; AJvYcCU4PVP/ZOwh22XyYzA3QE5e8dowrHGqV/z2MhecPL9Q0Iu/7m16pNNAa//gmIW+Wy7BJZk94k8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9+7fFKtt8GbzelJGi3dcG3VDymbES9rqFNVcS3NFUR4du36kg
	AWXdHooFxL2Dl3TafW8TY3UlbtOWdtvAEbHcxmzMcD0I9RO2Cdgbv9oCxs4xzXkDN7UPyvz7vOR
	kIBNSt3eaO4ScKQ==
X-Received: from qvboe2.prod.google.com ([2002:a05:6214:4302:b0:896:f72b:27fe])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ad4:4eef:0:b0:899:eba1:3c14 with SMTP id 6a1803df08f44-8a7025b7992mr362485116d6.18.1775652995403;
 Wed, 08 Apr 2026 05:56:35 -0700 (PDT)
Date: Wed,  8 Apr 2026 12:56:08 +0000
In-Reply-To: <20260408125611.3592751-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260408125611.3592751-1-edumazet@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260408125611.3592751-13-edumazet@google.com>
Subject: [PATCH net-next 12/15] net/sched: sch_choke: annotate data-races in choke_dump_stats()
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,mojatatu.com,resnulli.us,google.com,vger.kernel.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276527-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 013C23BC79D
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



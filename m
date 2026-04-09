Return-Path: <netdev+bounces-277134-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yHPeMOMe2GlaYAgAu9opvQ
	(envelope-from <netdev+bounces-277134-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 23:49:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 698713D000B
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 23:49:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C111E301DA5B
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 21:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0440358363;
	Thu,  9 Apr 2026 21:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WYq4+B1P"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81EE926290
	for <netdev@vger.kernel.org>; Thu,  9 Apr 2026 21:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775771361; cv=none; b=kkKoAeG2tn9IKfcqMnoPRAR4A0pEaPuXzmRucYUyOiMeMMY/12JTR8GDBfYfTQGJ026eNutWPeR+8BZ/OTEVYUms0Rcxyu6LKh5gufbSCYmEItnVLoXx79gPiVEog20lEK5gzBusGJ3KV3qaLZTPoeMMFAMy5aAHCDBryw54lqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775771361; c=relaxed/simple;
	bh=pFKKj8F843iNchIlexWbcxgO53tqGPS6FEt3DXfbJe0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IMakXLiEr0bPnQqvRZNQD8UzsX14yFuDhMfuzmiLsM0UL0OY7mWLvpj53H4u3Qf53MHyq12B3g0GuxZuDOcKE9M5Fmw7Y/uw1qqvQX+cbod9kcNX5SqSF7UgVFMLnwCfsz/l+YG1eMx/4YBxkNkv+3w9Kw3213Di8m7jBb8fIo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WYq4+B1P; arc=none smtp.client-ip=209.85.219.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-89ffce20deaso25347926d6.0
        for <netdev@vger.kernel.org>; Thu, 09 Apr 2026 14:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775771359; x=1776376159; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=z9TuYwDDvZ5LhJpRr9/4FggHwKX+GQWobJYxYIfXlSI=;
        b=WYq4+B1PIZtP/th5N9VEduQkFX5IL1/sBrKpKKDNpZykQXcJAOtecJ7eWNdhKV804m
         UlL7cZ0OoBTq8kbe/ASENi14aUrqvT45Drsr3nwMBeIJm/EL9vBlJVt+IF/99kLEMOzB
         RSpAh4HM8P2/CVx6fna/C0jXLKO5IRK/ZHKqCl/3Msv2mfCPRiRp+I93bbDXzF8M45KW
         5hAaqyL5uYkh91NVT/IiOHjfv9SMwdoy3lRBlyzLAKjwQI3fwa/sqC5mS6ym+PB4UV1p
         jsTTACOiwbw2VtxEgEKxaNlhfHCsxpaPq+gaIb7YwLfOgR57zaF/eAeUcWlqwDsjXbxJ
         l/tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775771359; x=1776376159;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z9TuYwDDvZ5LhJpRr9/4FggHwKX+GQWobJYxYIfXlSI=;
        b=ghf9l7Dcc7L78JCimKnqWRJp5eYyPbpF3Zm/idaWMacXWqZKj7Tu5Prvn4d6o35III
         2MwjpROSSBal3s+/2V7FGnXfdS3zo2y+VJRysXeHhNG4u+ZrzvjbGL8/TXgmoEgVGPjA
         KLCEXV9DCbo7nSSFFTFlxjJ8UW0i9vOFhxWvMHVaRJNy8ky0e0k+d5Z9V8NpSDabKbju
         DTQG49NSMH5oy7aG+3FUEAwkhUbG7PGyLaIonNhq5UuLaT4FLpBq0DGpRaor+uIxyB/k
         Uhh7eFsw2jxYVd1dg2ZkD0t9mZDoYLwUO6seUYbZbdl8uQNL3yy+RTk6GpE72eDoeFKa
         Hflw==
X-Forwarded-Encrypted: i=1; AJvYcCUd6MEKISwG+opBLGg/q2P1m5sa4g6y0jXrjZoJrJPilY7yfbKJYNylxQmN48KkzDEJBzQl5LI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpTcXrA81KH+y9TFHRTSHt0DszjhsRDdwYeIL/vj/mTLKfOAXh
	t4do5Izkar0r5tnMeYXOERFexn2IaDCrmh8X2vbzm/wgCddZzX125c3tvrB9/h7GdXEjzTZVkq3
	aFHXhnD3u+6BpKA==
X-Received: from qvbql18.prod.google.com ([2002:a05:6214:5412:b0:89d:166d:84f1])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:2586:b0:89a:116b:e67d with SMTP id 6a1803df08f44-8ac862a5fd8mr9632216d6.37.1775771359293;
 Thu, 09 Apr 2026 14:49:19 -0700 (PDT)
Date: Thu,  9 Apr 2026 21:49:00 +0000
In-Reply-To: <20260409214914.3072827-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260409214914.3072827-1-edumazet@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260409214914.3072827-2-edumazet@google.com>
Subject: [PATCH v2 net-next 01/15] net/sched: rename qstats_overlimit_inc() to qstats_cpu_overlimit_inc()
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,mojatatu.com,resnulli.us,google.com,vger.kernel.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277134-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 698713D000B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

qstats_overlimit_inc() is only used to increment per cpu overlimits.

It can use this_cpu_inc() to avoid this_cpu_ptr() extra cost
and avoid potential store tearing.

Change qstats_overlimit_inc() name and its argument type.

Also add a WRITE_ONCE() in qdisc_qstats_overlimit() to prevent
store tearing.

$ scripts/bloat-o-meter -t vmlinux.0 vmlinux.1
add/remove: 0/0 grow/shrink: 0/5 up/down: 0/-72 (-72)
Function                                     old     new   delta
tcf_skbmod_act                               772     764      -8
tcf_police_act                               733     725      -8
tcf_mirred_to_dev                           1126    1114     -12
tcf_ife_act                                 1077    1061     -16
tcf_mirred_act                              1324    1296     -28
Total: Before=29610901, After=29610829, chg -0.00%

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/act_api.h     | 2 +-
 include/net/sch_generic.h | 6 +++---
 net/sched/act_ife.c       | 4 ++--
 net/sched/act_police.c    | 2 +-
 net/sched/act_skbmod.c    | 2 +-
 5 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/net/act_api.h b/include/net/act_api.h
index d11b791079302f50c47e174979767e0b24afc59a..2ec4ef9a5d0c8e9110f92f135cc3c31a38af0479 100644
--- a/include/net/act_api.h
+++ b/include/net/act_api.h
@@ -250,7 +250,7 @@ static inline void tcf_action_inc_drop_qstats(struct tc_action *a)
 static inline void tcf_action_inc_overlimit_qstats(struct tc_action *a)
 {
 	if (likely(a->cpu_qstats)) {
-		qstats_overlimit_inc(this_cpu_ptr(a->cpu_qstats));
+		qstats_cpu_overlimit_inc(a->cpu_qstats);
 		return;
 	}
 	atomic_inc(&a->tcfa_overlimits);
diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
index 5af262ec4bbd2d5021904df127a849e52c26178a..3ee383c6fc3f66f1aecd9ebc675fbd143852c150 100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -1004,9 +1004,9 @@ static inline void qstats_drop_inc(struct gnet_stats_queue *qstats)
 	qstats->drops++;
 }
 
-static inline void qstats_overlimit_inc(struct gnet_stats_queue *qstats)
+static inline void qstats_cpu_overlimit_inc(struct gnet_stats_queue __percpu *qstats)
 {
-	qstats->overlimits++;
+	this_cpu_inc(qstats->overlimits);
 }
 
 static inline void qdisc_qstats_drop(struct Qdisc *sch)
@@ -1021,7 +1021,7 @@ static inline void qdisc_qstats_cpu_drop(struct Qdisc *sch)
 
 static inline void qdisc_qstats_overlimit(struct Qdisc *sch)
 {
-	sch->qstats.overlimits++;
+	WRITE_ONCE(sch->qstats.overlimits, sch->qstats.overlimits + 1);
 }
 
 static inline int qdisc_qstats_copy(struct gnet_dump *d, struct Qdisc *sch)
diff --git a/net/sched/act_ife.c b/net/sched/act_ife.c
index d5e8a91bb4eb9f1f1f084e199b5ada4e7f7e7205..e1b825e14900d6f46bbfd1b7f72ab6cd554d8a73 100644
--- a/net/sched/act_ife.c
+++ b/net/sched/act_ife.c
@@ -750,7 +750,7 @@ static int tcf_ife_decode(struct sk_buff *skb, const struct tc_action *a,
 			 */
 			pr_info_ratelimited("Unknown metaid %d dlen %d\n",
 					    mtype, dlen);
-			qstats_overlimit_inc(this_cpu_ptr(ife->common.cpu_qstats));
+			qstats_cpu_overlimit_inc(ife->common.cpu_qstats);
 		}
 	}
 
@@ -814,7 +814,7 @@ static int tcf_ife_encode(struct sk_buff *skb, const struct tc_action *a,
 		/* abuse overlimits to count when we allow packet
 		 * with no metadata
 		 */
-		qstats_overlimit_inc(this_cpu_ptr(ife->common.cpu_qstats));
+		qstats_cpu_overlimit_inc(ife->common.cpu_qstats);
 		return action;
 	}
 	/* could be stupid policy setup or mtu config
diff --git a/net/sched/act_police.c b/net/sched/act_police.c
index 12ea9e5a600536b603ea73cc99b4c00381287219..8060f43e4d11c0a26e1475db06b76426f50c5975 100644
--- a/net/sched/act_police.c
+++ b/net/sched/act_police.c
@@ -307,7 +307,7 @@ TC_INDIRECT_SCOPE int tcf_police_act(struct sk_buff *skb,
 	}
 
 inc_overlimits:
-	qstats_overlimit_inc(this_cpu_ptr(police->common.cpu_qstats));
+	qstats_cpu_overlimit_inc(police->common.cpu_qstats);
 inc_drops:
 	if (ret == TC_ACT_SHOT)
 		qstats_drop_inc(this_cpu_ptr(police->common.cpu_qstats));
diff --git a/net/sched/act_skbmod.c b/net/sched/act_skbmod.c
index 23ca46138f040d38de37684439873921bc9c86af..a464b0a3c1b81dba6c28c1141aa38c5c7cad3acb 100644
--- a/net/sched/act_skbmod.c
+++ b/net/sched/act_skbmod.c
@@ -87,7 +87,7 @@ TC_INDIRECT_SCOPE int tcf_skbmod_act(struct sk_buff *skb,
 	return p->action;
 
 drop:
-	qstats_overlimit_inc(this_cpu_ptr(d->common.cpu_qstats));
+	qstats_cpu_overlimit_inc(d->common.cpu_qstats);
 	return TC_ACT_SHOT;
 }
 
-- 
2.53.0.1213.gd9a14994de-goog



Return-Path: <netdev+bounces-281679-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GOR5Fq9d8GnDSQEAu9opvQ
	(envelope-from <netdev+bounces-281679-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 09:11:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A4EB847E825
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 09:11:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 869303009145
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 07:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED1E939524E;
	Tue, 28 Apr 2026 07:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O4VDxM2L"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f73.google.com (mail-yx1-f73.google.com [74.125.224.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C16A361DB1
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 07:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777360163; cv=none; b=NLY+yvnDCuo8cr3w+Mv9ujJsuLQSv8+/PPH8wvAddX4bjBWW+K8uc9NO7oMUkia9aD1lrkJCP4HaCSyUT03qM/kboweQ/G3JgWz9UH42HBLiaQAyI+Pt+W4RYWbs5ClB8GgWMoFt+UI7RIqjKlm30LoYU5Bcg1q8uw2uIjXNqUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777360163; c=relaxed/simple;
	bh=6AB3orESIKLAo/khVc7XcxX39RJUVU5bY+L1mBF5+hA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=nO4V46lEVfnO9SDuP/OWUSmymR3OB3IlLGTy7RAKiX1CdLHS4sNrECI+EMu9jWD07G5GHgoD/ist/t4r2Qa14Jfj+cfKQhJ9XiM+4yYCJ88VVW5ZMZuJttpyQM1wcMChnPh6LIn4rgGaGqMlLBIPGMtS2xOPtQe5erjZ9WX42EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O4VDxM2L; arc=none smtp.client-ip=74.125.224.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yx1-f73.google.com with SMTP id 956f58d0204a3-651c92dd649so19916975d50.1
        for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 00:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777360161; x=1777964961; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mKlZyTkMgncwvi2sfTQVzqCBKhiJuDWXk5fIO/U9gnc=;
        b=O4VDxM2LzIsVV6pZYLpNq1ATsDMlFomlUVlBxcG35moxvDE72yuScwg4ass65qIr8h
         jOVqj4Z+lGksPxgLk8v7BMYQA2UAef4hgnNS7YOFVCCZL3oimgEAZUjoOec2vNZ473Yv
         T6CS5CFJTHHOcYOzrgg4GNO3qnIxjFAgSmxO9S+0JglsWdjiK+HKAWQQ8GBTyk6ai7Ll
         +fB9DiE8ueaOKr8mBy+lVsqbGEVGGIxvRgHUrRAKx9TBt3E5exJmhkK3AL23EMeU58B0
         9iTfYaxsWC5RksnWc4344AvTZlv8mOOx6xRUoyc1VjaMLUhpr1zeLdPCXAUBG7/wdmGM
         nccg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777360161; x=1777964961;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mKlZyTkMgncwvi2sfTQVzqCBKhiJuDWXk5fIO/U9gnc=;
        b=nE9n7QmdV8aHSl/MmrhTSgcS/V0RSNKXPrZ2z1/o05ncCCpIah/jFcQoVBui5DTbfp
         TI+3tyaHi68q39jP4UIPCKSJLd/SuxM/EDX1p7/5hKk5VWq8vvmxs1mxLx/45tM06Wco
         tYUjJh0tvmRVBBkVWx/ANWX1IeXlkTsrFvLePjkK+cGsYGKWmDJlweS3pfVFkBWqjPcj
         6lS5lRTuxMT9sX7RdyHzRja3yOmAZh0tkXYYGw8SuMVJvrP64huUQ50kWmMOUzWpEADQ
         006ZERN+RYpYhtSA8DbSUvmDIu8b04Tetj3VHlNzBRB0dnE6BDOxqOIeT3bgxl85RtR8
         0sVA==
X-Forwarded-Encrypted: i=1; AFNElJ963Q86+d+v4LFfTzpKH4ZphGslDOfae/zw3Nte0fZj2TDeE4qkaGJe2+F8+iaabmNwIKUbD7M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzE2hOD09pKpKSI8JuJLLjM/ybaXKPJe4fmDRxppSpGi2v+3Sdn
	o8l9PAIgxBDOPTGjy7A9HKic73nCPRAc4+lCy+E226G+feWo6TY9rhBCS6i5VP+RA8LacxS370s
	K+rcRByXjYu70WA==
X-Received: from yxak7-n1.prod.google.com ([2002:a53:c047:0:10b0:652:df1f:6403])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:690e:1906:b0:651:b214:cb69 with SMTP id 956f58d0204a3-65beeef1619mr1368003d50.65.1777360161159;
 Tue, 28 Apr 2026 00:09:21 -0700 (PDT)
Date: Tue, 28 Apr 2026 07:09:19 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260428070919.3109557-1-edumazet@google.com>
Subject: [PATCH v4 net-next] net/sched: rename qstats_overlimit_inc() to qstats_cpu_overlimit_inc()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: A4EB847E825
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
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
	FREEMAIL_CC(0.00)[kernel.org,mojatatu.com,resnulli.us,vger.kernel.org,gmail.com,google.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281679-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

qstats_overlimit_inc() is only used to increment per cpu overlimits.

It can use this_cpu_inc() to avoid this_cpu_ptr() extra cost
and avoid potential store tearing.

Change qstats_overlimit_inc() name and its argument type.

Also add a WRITE_ONCE() in qdisc_qstats_overlimit() to prevent
store tearing.

$ scripts/bloat-o-meter -t vmlinux.0 vmlinux.1
add/remove: 0/0 grow/shrink: 0/7 up/down: 0/-91 (-91)
Function                                     old     new   delta
tcf_skbmod_act                               772     764      -8
tcf_police_act                               733     725      -8
tcf_gate_act                                 318     310      -8
tcf_pedit_act                               1295    1284     -11
tcf_mirred_to_dev                           1126    1114     -12
tcf_ife_act                                 1077    1061     -16
tcf_mirred_act                              1324    1296     -28
Total: Before=24274627, After=24274536, chg -0.00%

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>
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
index 11159a50d6a14535d7c173c81c0de80dff108807..cbfe9ed435fd77422a181074980e5779190ab9c3 100644
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
2.54.0.545.g6539524ca2-goog



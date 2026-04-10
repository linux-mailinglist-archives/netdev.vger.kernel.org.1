Return-Path: <netdev+bounces-277517-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6AQeNgZC2WnCnwgAu9opvQ
	(envelope-from <netdev+bounces-277517-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 20:31:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 69EBE3DB773
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 20:31:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9476E300D768
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 18:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74F733BED0F;
	Fri, 10 Apr 2026 18:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="klyetVHT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f73.google.com (mail-ot1-f73.google.com [209.85.210.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D843358A7
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 18:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775845892; cv=none; b=DEkMP13zmd8XjbEpD9+FILOr33ShUvm1uTuVIn7/o4DAsdpbwtIC8RUEjIMFmN3eChM18IP6L9PM4t9Co2vmVlJmwmqzn5FdmONwUibyxhpBQ7Lkz87k6LL3j/lV+9nuEYqiRtDf3LqGYNgx7tqTNfdbqKLcP+WzisIxHhjl/gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775845892; c=relaxed/simple;
	bh=pFKKj8F843iNchIlexWbcxgO53tqGPS6FEt3DXfbJe0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KYjsBCAslgnWETRE61vu3366PVgn8JDi2O0Nd0f8YB8vHM0WtkFTDdnDsKvcScoL26+RfoKLH/RDHyFy0KztB35PXSVdcHwSXjGwS7L7JfDZ3aGHZzPOPsWQc6dtdN/10T5mHAkz171cQT+AE1dW4QKPNYta9PxS50eEHP+A04s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=klyetVHT; arc=none smtp.client-ip=209.85.210.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-ot1-f73.google.com with SMTP id 46e09a7af769-7dbe11b1f03so5224718a34.0
        for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 11:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775845890; x=1776450690; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=z9TuYwDDvZ5LhJpRr9/4FggHwKX+GQWobJYxYIfXlSI=;
        b=klyetVHTDwSLJFBwPh6E70q6i0XcyWg11dmhmOQ2ye9vMTrL5LVQYZOSLZieunPJXF
         S+rlU2UXrdAeDsTN9dFsWfJcMLqYhMPz7bBb//CRstBAoC2b8nCugkrlA9YOp9ZhznaX
         P5rwyTDQu0Z7vvpkaFudAAWW0APobLXTlOb8h3ey/aIYqwJ8hFwNGRiTW331kHYHKJA5
         mrOOplIDwUifnxupnQopiUHW/knTxUEAmS76gUMmxAMQ9f9GZ04S67ZbRQHHTn/w+bce
         /JCjTSnb4lcZ5KGIgCXW3gPgxxdZUqFFwMs1BcCqImvMJhFbEmczNaTyREUCStj/IGwn
         XPDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775845890; x=1776450690;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z9TuYwDDvZ5LhJpRr9/4FggHwKX+GQWobJYxYIfXlSI=;
        b=OU4j6iWdB//g8PUs0+DY0/OT2oqXcN7BknYYOAnZoTIi80SgzhU5XRkE5C6/eSt6gg
         MydWRCFBj+tFHOtzOLhnDMwTfGGdAMVKz6eRGx7GjJOZAzz0pNkc0ow5jF5B71LXO3Fr
         aQisQmwU3vDVBwunGjEf//4/RxWl7HJ5pEQxuuqeusaVv0zMMQY+rPdUt79ISiorIeOc
         SMDs+25cQlHEv+ctwFasPELpSXwmOLTHxElBBG2Uhsw48QkZoldRid6+svyPJYllwnYK
         vqKTfIj48+x5jwh9BE7lzuJrs0QstUsgMcAwSepjCbOVW6RfTMxVVzlVcI9I//+1dbvC
         c4ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXv1NuenxEWSYGy5Am6DG0FFJy8ka5JGKeGwKZp2IYy6307CxV2nONfs6CCBNZe8KJwO1vgHPI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5+Uxd8fSyboD4XEO1qdOgy0DvHsVD80jELH3bBJHZs5Rk4pHh
	BMZaO6p66A/zwKBqKm9JCoiMaRUEAx4+wnM3DtDBuoo4BycWS5/IAJIPEo0XGmSO+Gu3timKxaf
	RytRloM57/SOyWQ==
X-Received: from qtod19.prod.google.com ([2002:ac8:5353:0:b0:50d:cf83:e5b7])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:7fcf:0:b0:50d:5f34:9a with SMTP id d75a77b69052e-50dd5b51ce1mr63518011cf.28.1775845387146;
 Fri, 10 Apr 2026 11:23:07 -0700 (PDT)
Date: Fri, 10 Apr 2026 18:22:43 +0000
In-Reply-To: <20260410182257.774311-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260410182257.774311-1-edumazet@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260410182257.774311-2-edumazet@google.com>
Subject: [PATCH v3 net-next 01/15] net/sched: rename qstats_overlimit_inc() to qstats_cpu_overlimit_inc()
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,mojatatu.com,resnulli.us,vger.kernel.org,gmail.com,google.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277517-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 69EBE3DB773
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



Return-Path: <netdev+bounces-287939-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UKukD0i2BWpZaAIAu9opvQ
	(envelope-from <netdev+bounces-287939-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 13:47:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AA62054132C
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 13:47:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A60F83016277
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 11:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF8B23C09ED;
	Thu, 14 May 2026 11:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DbECCrJY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF793B8D7E
	for <netdev@vger.kernel.org>; Thu, 14 May 2026 11:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778759237; cv=none; b=GUbkVwDGB0qbVbYHoICiq1cYX+W8dDHpCprkgw2nGTIr8jqXOh1kD7UrHy3Yiy1lZHcxRUbYEP9sdMyYsdC9HqRJxLvSDSnIwAlYXq/D3YwLAMe5arCmPlJt2FCQJnTh3RJCdTFmXRnIhjRcb1QweSY/Jeair5NmAW0VBOf4Fss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778759237; c=relaxed/simple;
	bh=efEdLYBGwXMk1FZ6NvnTRdf+WewLtg4Mqsibp1Nr4EI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=i5x09QZ0x4SRemqjOB2p827nCLZ/24gg86lAI4jdl+xzTESUzDxRHTEe8ZbzM/R88OvOEzTpP/YkQJ7rRH7YVoNos5E2tuPXFEGGSjogv+8HEYm2WOoxXwMvg6XriBKXGa5bTSD2eIwisJeSh54JJ92WpVPeyBp+jq4U+7n7++E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DbECCrJY; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-51494d74d4bso139431621cf.1
        for <netdev@vger.kernel.org>; Thu, 14 May 2026 04:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778759235; x=1779364035; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jvDeDkJghz++54GrljZdOEdxppinnGvlOHppuZiSKQI=;
        b=DbECCrJY1ABArBVkFHAa1rJoMUYa5OdlHiCge9spb5atJ3gVLtt/WpU8Tc7KXuQrDa
         Koj0Axmj8r2ITx09zFlYBW26X6MiM1znkih5cZv4X6yhwVas55softPY6KtZHhb19ybY
         2tekpgQX08WAeUXx19eQIN1Ar15ro6secGCIDbmOSAXw5N9Suh4yOrvXiSp951xUAOEI
         uPi7HpCehcjePuz2DH+Xlcxyj3CTKyZsusnYptkj3yVKT+TUBkiA1x/iZkpnJHISA2fl
         IuPUw09ZWloVwAs5Mb4jBSc5scmGNc50m7bWCOazm2U7yTMkzwlGWwqLjojzw167cAmT
         aMCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778759235; x=1779364035;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jvDeDkJghz++54GrljZdOEdxppinnGvlOHppuZiSKQI=;
        b=rAt42uAXeZZFrK613rhIPu/ZL3Q2w7WRQ+cqWPVRMXKQHc/VWC2tGFXwAT1IkVw6ao
         cAbPcFaJmpV/jwaTnaz6hwNj8lxIBzVpyVDn5kvW+FaggP3LsSav/6awSp4k6ZLREDnJ
         itvySAasT7HePP6OawUA6FOu4WSXYuvvklhrP7nCAZvN/kTSOVe7axLWhnNz0murKmTJ
         EnipdD7OtL1EGz4bFNsYZnKn46Qnc4lYNVfLmVwP8LBsdf61TOacLgwAsTuZwojdqhO3
         1Cf3b0zNrHY8hFU3m6tifkK/Sp0pYXo37cQOAsDWGZzAKXXDstjamV2Cpd8Xkqvvh1JH
         dFRg==
X-Forwarded-Encrypted: i=1; AFNElJ9DFGGuDV2h1ieEsUv5RC8fhlTCpHByOjIMr/oWQdKJfrNm/6+Lx+pK9NcOu0sfSP1cwCtV5h8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiYinQNrFwHjupgN+JcKVXGYGhRBsuqGjJdD4MH5AI5sG0yYsS
	cz21mcFJT2Q5VA0oiKuWZcVzZulSoOD2F1cZsU9nMr9RoDIjiZsB0hdF9lCp4fdjJmM9izWYiEs
	++cabwXX0bQSoag==
X-Received: from qtbir3.prod.google.com ([2002:a05:622a:6dc3:b0:50e:5ff6:e88c])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:2588:b0:509:11bd:9d3 with SMTP id d75a77b69052e-516415f4efemr40519191cf.1.1778759234878;
 Thu, 14 May 2026 04:47:14 -0700 (PDT)
Date: Thu, 14 May 2026 11:47:13 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260514114713.4134674-1-edumazet@google.com>
Subject: [PATCH net-next] net/sched: sch_dualpi2: annotate data-races in dualpi2_dump_stats()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Victor Nogueira <victor@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, 
	"=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?=" <toke@toke.dk>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Vineet Agarwal <agarwal.vineet2006@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: AA62054132C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-287939-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,mojatatu.com,resnulli.us,toke.dk,vger.kernel.org,gmail.com,google.com];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

dualpi2_dump_stats() runs without qdisc lock held.

Add missing READ_ONCE()/WRITE_ONCE() annotations.

Fixes: d4de8bffbef4 ("sched: Dump configuration and statistics of dualpi2 qdisc")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Vineet Agarwal <agarwal.vineet2006@gmail.com>
---
 net/sched/sch_dualpi2.c | 68 ++++++++++++++++++++---------------------
 1 file changed, 34 insertions(+), 34 deletions(-)

diff --git a/net/sched/sch_dualpi2.c b/net/sched/sch_dualpi2.c
index c6416f09dddd8f170b92e50fb89377a15773c5bf..8b3bc646730499dac1798372ef5b647c2e9e5a57 100644
--- a/net/sched/sch_dualpi2.c
+++ b/net/sched/sch_dualpi2.c
@@ -190,7 +190,7 @@ static bool skb_apply_step(struct sk_buff *skb, struct dualpi2_sched_data *q)
 static bool dualpi2_mark(struct dualpi2_sched_data *q, struct sk_buff *skb)
 {
 	if (INET_ECN_set_ce(skb)) {
-		q->ecn_mark++;
+		WRITE_ONCE(q->ecn_mark, q->ecn_mark + 1);
 		return true;
 	}
 	return false;
@@ -198,7 +198,7 @@ static bool dualpi2_mark(struct dualpi2_sched_data *q, struct sk_buff *skb)
 
 static void dualpi2_reset_c_protection(struct dualpi2_sched_data *q)
 {
-	q->c_protection_credit = q->c_protection_init;
+	WRITE_ONCE(q->c_protection_credit, q->c_protection_init);
 }
 
 /* This computes the initial credit value and WRR weight for the L queue (wl)
@@ -403,12 +403,12 @@ static int dualpi2_enqueue_skb(struct sk_buff *skb, struct Qdisc *sch,
 
 	cb = dualpi2_skb_cb(skb);
 	cb->ts = ktime_get_ns();
-	q->memory_used += skb->truesize;
+	WRITE_ONCE(q->memory_used, q->memory_used + skb->truesize);
 	if (q->memory_used > q->max_memory_used)
-		q->max_memory_used = q->memory_used;
+		WRITE_ONCE(q->max_memory_used, q->memory_used);
 
 	if (qdisc_qlen(sch) > q->maxq)
-		q->maxq = qdisc_qlen(sch);
+		WRITE_ONCE(q->maxq, qdisc_qlen(sch));
 
 	if (skb_in_l_queue(skb)) {
 		/* Apply step thresh if skb is L4S && L-queue len >= min_qlen */
@@ -417,14 +417,14 @@ static int dualpi2_enqueue_skb(struct sk_buff *skb, struct Qdisc *sch,
 		/* Keep the overall qdisc stats consistent */
 		qdisc_qlen_inc(sch);
 		qdisc_qstats_backlog_inc(sch, skb);
-		++q->packets_in_l;
+		WRITE_ONCE(q->packets_in_l, q->packets_in_l + 1);
 		if (!q->l_head_ts)
-			q->l_head_ts = cb->ts;
+			WRITE_ONCE(q->l_head_ts, cb->ts);
 		return qdisc_enqueue_tail(skb, q->l_queue);
 	}
-	++q->packets_in_c;
+	WRITE_ONCE(q->packets_in_c, q->packets_in_c + 1);
 	if (!q->c_head_ts)
-		q->c_head_ts = cb->ts;
+		WRITE_ONCE(q->c_head_ts, cb->ts);
 	return qdisc_enqueue_tail(skb, sch);
 }
 
@@ -531,17 +531,16 @@ static struct sk_buff *dequeue_packet(struct Qdisc *sch,
 
 		/* Keep the global queue size consistent */
 		qdisc_qlen_dec(sch);
-		q->memory_used -= skb->truesize;
 	} else if (c_len) {
 		skb = __qdisc_dequeue_head(&sch->q);
 		WRITE_ONCE(q->c_head_ts, head_enqueue_time(sch));
 		if (qdisc_qlen(q->l_queue))
 			*credit_change = ~((s32)q->c_protection_wl) + 1;
-		q->memory_used -= skb->truesize;
 	} else {
 		dualpi2_reset_c_protection(q);
 		return NULL;
 	}
+	WRITE_ONCE(q->memory_used, q->memory_used - skb->truesize);
 	*credit_change *= qdisc_pkt_len(skb);
 	qdisc_qstats_backlog_dec(sch, skb);
 	return skb;
@@ -564,7 +563,7 @@ static int do_step_aqm(struct dualpi2_sched_data *q, struct sk_buff *skb,
 		}
 
 		if (dualpi2_mark(q, skb))
-			++q->step_marks;
+			WRITE_ONCE(q->step_marks, q->step_marks + 1);
 	}
 	qdisc_bstats_update(q->l_queue, skb);
 	return 0;
@@ -600,7 +599,8 @@ static struct sk_buff *dualpi2_qdisc_dequeue(struct Qdisc *sch)
 			continue;
 		}
 
-		q->c_protection_credit += credit_change;
+		WRITE_ONCE(q->c_protection_credit,
+			   q->c_protection_credit + credit_change);
 		qdisc_bstats_update(sch, skb);
 		break;
 	}
@@ -876,7 +876,7 @@ static int dualpi2_change(struct Qdisc *sch, struct nlattr *opt,
 				WARN_ON_ONCE(1);
 				break;
 			}
-			q->memory_used -= skb->truesize;
+			WRITE_ONCE(q->memory_used, q->memory_used - skb->truesize);
 			rtnl_qdisc_drop(skb, sch);
 		} else if (qdisc_qlen(q->l_queue)) {
 			skb = qdisc_dequeue_internal(q->l_queue, true);
@@ -890,7 +890,7 @@ static int dualpi2_change(struct Qdisc *sch, struct nlattr *opt,
 			 */
 			qdisc_qlen_dec(sch);
 			qdisc_qstats_backlog_dec(sch, skb);
-			q->memory_used -= skb->truesize;
+			WRITE_ONCE(q->memory_used, q->memory_used - skb->truesize);
 			rtnl_qdisc_drop(skb, q->l_queue);
 			qdisc_qstats_drop(sch);
 		} else {
@@ -1046,15 +1046,15 @@ static int dualpi2_dump_stats(struct Qdisc *sch, struct gnet_dump *d)
 	struct dualpi2_sched_data *q = qdisc_priv(sch);
 	struct tc_dualpi2_xstats st = {
 		.prob			= READ_ONCE(q->pi2_prob),
-		.packets_in_c		= q->packets_in_c,
-		.packets_in_l		= q->packets_in_l,
-		.maxq			= q->maxq,
-		.ecn_mark		= q->ecn_mark,
-		.credit			= q->c_protection_credit,
-		.step_marks		= q->step_marks,
-		.memory_used		= q->memory_used,
-		.max_memory_used	= q->max_memory_used,
-		.memory_limit		= q->memory_limit,
+		.packets_in_c		= READ_ONCE(q->packets_in_c),
+		.packets_in_l		= READ_ONCE(q->packets_in_l),
+		.maxq			= READ_ONCE(q->maxq),
+		.ecn_mark		= READ_ONCE(q->ecn_mark),
+		.credit			= READ_ONCE(q->c_protection_credit),
+		.step_marks		= READ_ONCE(q->step_marks),
+		.memory_used		= READ_ONCE(q->memory_used),
+		.max_memory_used	= READ_ONCE(q->max_memory_used),
+		.memory_limit		= READ_ONCE(q->memory_limit),
 	};
 	u64 qc, ql;
 
@@ -1074,16 +1074,16 @@ static void dualpi2_reset(struct Qdisc *sch)
 
 	qdisc_reset_queue(sch);
 	qdisc_reset_queue(q->l_queue);
-	q->c_head_ts = 0;
-	q->l_head_ts = 0;
-	q->pi2_prob = 0;
-	q->packets_in_c = 0;
-	q->packets_in_l = 0;
-	q->maxq = 0;
-	q->ecn_mark = 0;
-	q->step_marks = 0;
-	q->memory_used = 0;
-	q->max_memory_used = 0;
+	WRITE_ONCE(q->c_head_ts, 0);
+	WRITE_ONCE(q->l_head_ts, 0);
+	WRITE_ONCE(q->pi2_prob, 0);
+	WRITE_ONCE(q->packets_in_c, 0);
+	WRITE_ONCE(q->packets_in_l, 0);
+	WRITE_ONCE(q->maxq, 0);
+	WRITE_ONCE(q->ecn_mark, 0);
+	WRITE_ONCE(q->step_marks, 0);
+	WRITE_ONCE(q->memory_used, 0);
+	WRITE_ONCE(q->max_memory_used, 0);
 	dualpi2_reset_c_protection(q);
 }
 
-- 
2.54.0.563.g4f69b47b94-goog



Return-Path: <netdev+bounces-277148-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yIm+EqAf2GlaYAgAu9opvQ
	(envelope-from <netdev+bounces-277148-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 23:52:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AAB763D0086
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 23:52:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CF936304C961
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 21:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD14335B653;
	Thu,  9 Apr 2026 21:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e9CDmw6G"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47CA233A701
	for <netdev@vger.kernel.org>; Thu,  9 Apr 2026 21:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775771385; cv=none; b=rP0L6Mz8/j9dHHVpjJPotPUPDRTPjpkz+skb91K5LZfj00GRENYTD8Gtyq7oYh7GT5ujymGfRIXDcP4bXcJPcHoX6PS4OIjXSmNi/FG67mZIAdjEVuwUGyc65dwXTLiT4UqZFsVdZG6EOIr7288brBkP/xuoSzF/s3FQbR3Y2QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775771385; c=relaxed/simple;
	bh=nSo6aej+ukOVgv3jtn96voViCFdUZLg0a6AQV1Ez90M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Z6B+td9tqhqycw118dJJgqTk2zMXW2WePFt1lJQFwOMmz+iykTcmLc93W4buddf3ZIAhF/CKf0gZUAWRk+KymHbNp9N60AyIVVd5vdHIHzFIMuYFNhWf51atPZH3/yAdPLsWqI/oKbQFn3zHkCuFzuK0K36qd4pBDmq/PxzTFC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e9CDmw6G; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-50b4ca7e7c2so28879601cf.3
        for <netdev@vger.kernel.org>; Thu, 09 Apr 2026 14:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775771383; x=1776376183; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0ARy47czAXI1fX/UiSwJx6KtZ1ahNEm57GRGQ4HfmRQ=;
        b=e9CDmw6Gcaf+gSwrM5uztL6yBeCRgedzXXogF+Bo3ypzVRtrhg3sA4WS7Vb+wSx0Um
         YzQrutwAdEnPXx/91MftHNFe6pwbHpha4q0gv/f9gFPXEuGU+5Vu0LLrsebautZ9UGkH
         iS9m0dY4x6yEl7vW8wYHVinM5Za0iJJjaFn4ZGxiATSDMiJTc9TdFVHz3s5Kp+NoX8yh
         Xkavd6DtDERJffcxVgKApMD02u2a+iqJlz5mvICL1GZNEZ8Hud7Vjsj5mfBQh6dZWCOF
         LSd4zohq5mXHCK+/NzV7Sap/hFRsBwW0Jzi/WwcoAVFFRXSb/4qQxK61P4QeyFD4czNe
         ktKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775771383; x=1776376183;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0ARy47czAXI1fX/UiSwJx6KtZ1ahNEm57GRGQ4HfmRQ=;
        b=CRgcJ7OXVqYGaITwlls5wrsrUyRGIRJkNITBQKSRvyPtQpGRM6HxpkmJmFZuoWOi4E
         mWjGgUAOt/nYGjN37Sj2ZXyOZG8h2i6YG7/59oVZdkVtPKSNyVqqYVFylLbBOONzBdUj
         W7iEEheT5LdtsZHZAj/2hGXWivyE2DxInmQc8gPq1vdxME0HmOkfjXnrubKPf5d4UnBu
         kBd7Tt+Y+vhEJIujByY83EvhWWHNSXS4H6xOhxwGU9iCi/D99nAz14EvXgWEmw/OblJN
         0HwMRFDaRAVM6kcOkRwoVzIvJnLLVWSfMzDX1dMmIqRqH1Dbc/yoAptE3YT3XDLg9vhx
         QI4w==
X-Forwarded-Encrypted: i=1; AJvYcCXA8nt5DA6nF0CgbGxkmbGwlPBFWc+N6l4p9posPctxrxcQB5gk5HcjBw6YU2vUckipANypt4o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAA00pmjyb9i632TQG+sGwvGuGqRI5x0YsbRRtxZsf90WGw2Ji
	49cszRMjFqnJ+jT6tZZQhMw2h8tK2FIrOK4KH3NpCIoivqs1MIefVjyXuIHpvxiTRRO832r7dUO
	ago77Qdg2GS6QPw==
X-Received: from qtvo19.prod.google.com ([2002:ac8:7c53:0:b0:503:34fa:ca78])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:2285:b0:50b:465f:706c with SMTP id d75a77b69052e-50dd5ccfd69mr14525371cf.60.1775771383180;
 Thu, 09 Apr 2026 14:49:43 -0700 (PDT)
Date: Thu,  9 Apr 2026 21:49:14 +0000
In-Reply-To: <20260409214914.3072827-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260409214914.3072827-1-edumazet@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260409214914.3072827-16-edumazet@google.com>
Subject: [PATCH v2 net-next 15/15] net/sched: taprio: prepare taprio_dump()
 for RTNL removal
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,mojatatu.com,resnulli.us,google.com,vger.kernel.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277148-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AAB763D0086
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

We soon will no longer hold RTNL in qdisc dumps.

Add READ_ONCE()/WRITE_ONCE() annoations.

Note taprio already uses RCU to protect most of its fields.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/sched/sch_taprio.c | 42 ++++++++++++++++++++++++------------------
 1 file changed, 24 insertions(+), 18 deletions(-)

diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
index 885a9bc859166dfb6d20aa0dfbb8f11194e02ba9..75030a834840cde3480722cc4214431625a7c7ee 100644
--- a/net/sched/sch_taprio.c
+++ b/net/sched/sch_taprio.c
@@ -308,10 +308,10 @@ static void taprio_update_queue_max_sdu(struct taprio_sched *q,
 
 		if (max_sdu != U32_MAX) {
 			sched->max_frm_len[tc] = max_sdu + dev->hard_header_len;
-			sched->max_sdu[tc] = max_sdu;
+			WRITE_ONCE(sched->max_sdu[tc], max_sdu);
 		} else {
 			sched->max_frm_len[tc] = U32_MAX; /* never oversized */
-			sched->max_sdu[tc] = 0;
+			WRITE_ONCE(sched->max_sdu[tc], 0);
 		}
 	}
 }
@@ -1770,8 +1770,8 @@ static int taprio_parse_tc_entries(struct Qdisc *sch,
 	}
 
 	for (tc = 0; tc < TC_QOPT_MAX_QUEUE; tc++) {
-		q->max_sdu[tc] = max_sdu[tc];
-		q->fp[tc] = fp[tc];
+		WRITE_ONCE(q->max_sdu[tc], max_sdu[tc]);
+		WRITE_ONCE(q->fp[tc], fp[tc]);
 		if (fp[tc] != TC_FP_EXPRESS)
 			have_preemption = true;
 	}
@@ -1851,12 +1851,14 @@ static int taprio_change(struct Qdisc *sch, struct nlattr *opt,
 		return -EINVAL;
 	}
 
-	if (q->flags != TAPRIO_FLAGS_INVALID && q->flags != taprio_flags) {
-		NL_SET_ERR_MSG_MOD(extack,
-				   "Changing 'flags' of a running schedule is not supported");
-		return -EOPNOTSUPP;
+	if (q->flags != taprio_flags) {
+		if (q->flags != TAPRIO_FLAGS_INVALID) {
+			NL_SET_ERR_MSG_MOD(extack,
+					   "Changing 'flags' of a running schedule is not supported");
+			return -EOPNOTSUPP;
+		}
+		q->flags = taprio_flags;
 	}
-	q->flags = taprio_flags;
 
 	/* Needed for length_to_duration() during netlink attribute parsing */
 	taprio_set_picos_per_byte(dev, q, extack);
@@ -1939,7 +1941,8 @@ static int taprio_change(struct Qdisc *sch, struct nlattr *opt,
 			goto unlock;
 		}
 
-		q->txtime_delay = nla_get_u32(tb[TCA_TAPRIO_ATTR_TXTIME_DELAY]);
+		WRITE_ONCE(q->txtime_delay,
+			   nla_get_u32(tb[TCA_TAPRIO_ATTR_TXTIME_DELAY]));
 	}
 
 	if (!TXTIME_ASSIST_IS_ENABLED(q->flags) &&
@@ -2279,8 +2282,8 @@ static int dump_schedule(struct sk_buff *msg,
 }
 
 static int taprio_dump_tc_entries(struct sk_buff *skb,
-				  struct taprio_sched *q,
-				  struct sched_gate_list *sched)
+				  const struct taprio_sched *q,
+				  const struct sched_gate_list *sched)
 {
 	struct nlattr *n;
 	int tc;
@@ -2294,10 +2297,11 @@ static int taprio_dump_tc_entries(struct sk_buff *skb,
 			goto nla_put_failure;
 
 		if (nla_put_u32(skb, TCA_TAPRIO_TC_ENTRY_MAX_SDU,
-				sched->max_sdu[tc]))
+				READ_ONCE(sched->max_sdu[tc])))
 			goto nla_put_failure;
 
-		if (nla_put_u32(skb, TCA_TAPRIO_TC_ENTRY_FP, q->fp[tc]))
+		if (nla_put_u32(skb, TCA_TAPRIO_TC_ENTRY_FP,
+				READ_ONCE(q->fp[tc])))
 			goto nla_put_failure;
 
 		nla_nest_end(skb, n);
@@ -2383,6 +2387,7 @@ static int taprio_dump(struct Qdisc *sch, struct sk_buff *skb)
 	struct sched_gate_list *oper, *admin;
 	struct tc_mqprio_qopt opt = { 0 };
 	struct nlattr *nest, *sched_nest;
+	u32 txtime_delay;
 
 	mqprio_qopt_reconstruct(dev, &opt);
 
@@ -2400,14 +2405,15 @@ static int taprio_dump(struct Qdisc *sch, struct sk_buff *skb)
 	if (q->flags && nla_put_u32(skb, TCA_TAPRIO_ATTR_FLAGS, q->flags))
 		goto options_error;
 
-	if (q->txtime_delay &&
-	    nla_put_u32(skb, TCA_TAPRIO_ATTR_TXTIME_DELAY, q->txtime_delay))
+	txtime_delay = READ_ONCE(q->txtime_delay);
+	if (txtime_delay &&
+	    nla_put_u32(skb, TCA_TAPRIO_ATTR_TXTIME_DELAY, txtime_delay))
 		goto options_error;
 
 	rcu_read_lock();
 
-	oper = rtnl_dereference(q->oper_sched);
-	admin = rtnl_dereference(q->admin_sched);
+	oper = rcu_dereference(q->oper_sched);
+	admin = rcu_dereference(q->admin_sched);
 
 	if (oper && taprio_dump_tc_entries(skb, q, oper))
 		goto options_error_rcu;
-- 
2.53.0.1213.gd9a14994de-goog



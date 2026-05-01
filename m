Return-Path: <netdev+bounces-283126-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ePPEGjRM9GkUAQIAu9opvQ
	(envelope-from <netdev+bounces-283126-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 08:46:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C744A4AABBA
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 08:46:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D272B3026C1B
	for <lists+netdev@lfdr.de>; Fri,  1 May 2026 06:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 482363603FC;
	Fri,  1 May 2026 06:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fE3OiIzs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3DFD2ED17B
	for <netdev@vger.kernel.org>; Fri,  1 May 2026 06:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777617773; cv=none; b=sCvVIIiAKhXq3vHsqGbHklHtgp/jgjX0TOD3V7K6n1FrcsGo7X26/FbOTuoBS4JupjpkdbxLcAGUDrmPYgVcdCSuwOMQN+H9VHMGYQMzZipWHqncovkDkGaFrzhrhx3Zs5NRH56JsHBQLSuFQ8yXPxZ7zTRfdNw7DW+8XsAFUaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777617773; c=relaxed/simple;
	bh=FEWrGNNf+Xq36oGSBKfECMKwsWtEtMeg9O8Y/oSXqV4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=IIXE5Kv0WLtw12hhmEV/nDWaNWhgRUXSrBrNo7CkrytjaTyzHLYvpFATq4LefOF1Ejqa7mMvIu/hqj9ra5KxE9630MbE4NWJL9iIunaZfiMUSf5E1XYgfgksfaX3HorBnXa+tV0/YxZiF9rCXr/Z/iyYH9QLLitsfWmuSuckPF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fE3OiIzs; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-50d9a6a853bso30124961cf.0
        for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 23:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777617770; x=1778222570; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GbMc9ghKwk6SefPtqeBtKp4E75ftKxftebjoBFl4Itg=;
        b=fE3OiIzsKZF2eR/uLcSXnB+o51AEfkoPXLsUfz+98Nk5TD4zK2eJGF8zsc7nwp5Kn8
         ZS5pm7l9njvxuaZ23vSXROx5l07JzypfUQtKxVFTIO0GE5KBGbqG9O/a3hGiK3qUxNOQ
         4egSCcX5pEV1dNOR+fHX0C1Mv0Jix5tg69ByDpwIRRVpsXCzGfaS7gPBR7P1V31iWalR
         /1v8ygz1+ypGK5SZObdDuNbgfqRsrHwqrjoUjwIdPUHu4O9vTSBkMpP4lKuQ0dg7cwJ1
         IqRGKsVL6lc6YBLuurMYCRp8QixHz7+AKiIhlcLOnMTw6mAxBCsYW4YREKR5wbjQKVVb
         N8DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777617770; x=1778222570;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GbMc9ghKwk6SefPtqeBtKp4E75ftKxftebjoBFl4Itg=;
        b=srBet/fCeFvPNWehQ6+ZSurSoxCs3EgC1XScnLYIfp8lgK7TS2Q/ioIJ2KExumQ7nz
         mmxDBshS4Z4nzGSLZYsEkE+wZe6cv3Xs6RqYPwKVqnEifugGrrcuXWw5bY1694PgigVc
         0CbKYK/uo9VqzvzFgGFMZ5HArhPaQBfaRxddBnQ1VQjaeOck80XtI9pugGWaSwGkETRW
         18W8c3jx035nVdHyXRtP5A0TTiSKdkmCiQUPereYqsrngwbhu3+PArg4vA1q7+p4MIZd
         zSzVbL5zY1DP9z7xcxQSoZmg3afg/x2dzwxdREQemcONtG0roCiN5L3bNpqgNYW/v0DL
         iFyg==
X-Forwarded-Encrypted: i=1; AFNElJ8jy5Hc0pwyp5XGwrja/HRxydoMHJ9gkLPxwwBTYDgbnCcP2nnwtXiTbcHENEeGLAXmKHt+BlQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzE9bjSZ/BBP/MD9U1krwAVt8lAk8B15fH9xEyZ7woTkvT5Zov/
	1cmun+EzVfgoaEAiricJo4soFM0wi+FPoQUgqO6CQe+nytZ6tQZJEJ0ol9Q4n6TRFoXnDQeHVFT
	gCfU238bWwiUKUA==
X-Received: from qtqt2.prod.google.com ([2002:ac8:7602:0:b0:50f:b9af:ace1])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:4246:b0:50e:5c31:5d56 with SMTP id d75a77b69052e-5103e80138bmr24215601cf.6.1777617770489;
 Thu, 30 Apr 2026 23:42:50 -0700 (PDT)
Date: Fri,  1 May 2026 06:42:47 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260501064247.2027688-1-edumazet@google.com>
Subject: [PATCH net-next] net/sched: taprio: prepare taprio_dump() for RTNL removal
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: C744A4AABBA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,mojatatu.com,resnulli.us,vger.kernel.org,gmail.com,google.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283126-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

We soon will no longer hold RTNL in qdisc dumps.

Add READ_ONCE()/WRITE_ONCE() annotations.

Note: taprio already uses RCU to protect most of its fields.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/sched/sch_taprio.c | 42 ++++++++++++++++++++++++------------------
 1 file changed, 24 insertions(+), 18 deletions(-)

diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
index 45245157e00a69311304f8c69f9ee9d80bc4f4d8..71b690e1974dad8fbab7e12998e03f86a0847a98 100644
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
@@ -1771,8 +1771,8 @@ static int taprio_parse_tc_entries(struct Qdisc *sch,
 	}
 
 	for (tc = 0; tc < TC_QOPT_MAX_QUEUE; tc++) {
-		q->max_sdu[tc] = max_sdu[tc];
-		q->fp[tc] = fp[tc];
+		WRITE_ONCE(q->max_sdu[tc], max_sdu[tc]);
+		WRITE_ONCE(q->fp[tc], fp[tc]);
 		if (fp[tc] != TC_FP_EXPRESS)
 			have_preemption = true;
 	}
@@ -1852,12 +1852,14 @@ static int taprio_change(struct Qdisc *sch, struct nlattr *opt,
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
+		WRITE_ONCE(q->flags, taprio_flags);
 	}
-	q->flags = taprio_flags;
 
 	/* Needed for length_to_duration() during netlink attribute parsing */
 	taprio_set_picos_per_byte(dev, q, extack);
@@ -1940,7 +1942,8 @@ static int taprio_change(struct Qdisc *sch, struct nlattr *opt,
 			goto unlock;
 		}
 
-		q->txtime_delay = nla_get_u32(tb[TCA_TAPRIO_ATTR_TXTIME_DELAY]);
+		WRITE_ONCE(q->txtime_delay,
+			   nla_get_u32(tb[TCA_TAPRIO_ATTR_TXTIME_DELAY]));
 	}
 
 	if (!TXTIME_ASSIST_IS_ENABLED(q->flags) &&
@@ -2283,8 +2286,8 @@ static int dump_schedule(struct sk_buff *msg,
 }
 
 static int taprio_dump_tc_entries(struct sk_buff *skb,
-				  struct taprio_sched *q,
-				  struct sched_gate_list *sched)
+				  const struct taprio_sched *q,
+				  const struct sched_gate_list *sched)
 {
 	struct nlattr *n;
 	int tc;
@@ -2298,10 +2301,11 @@ static int taprio_dump_tc_entries(struct sk_buff *skb,
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
@@ -2387,6 +2391,7 @@ static int taprio_dump(struct Qdisc *sch, struct sk_buff *skb)
 	struct sched_gate_list *oper, *admin;
 	struct tc_mqprio_qopt opt = { 0 };
 	struct nlattr *nest, *sched_nest;
+	u32 txtime_delay;
 
 	mqprio_qopt_reconstruct(dev, &opt);
 
@@ -2404,14 +2409,15 @@ static int taprio_dump(struct Qdisc *sch, struct sk_buff *skb)
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
2.54.0.545.g6539524ca2-goog



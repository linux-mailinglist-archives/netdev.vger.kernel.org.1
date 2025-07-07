Return-Path: <netdev+bounces-204579-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D591EAFB3D0
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 15:02:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 119391AA49A3
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 13:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B219729C32C;
	Mon,  7 Jul 2025 13:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UvXK76MD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f201.google.com (mail-oi1-f201.google.com [209.85.167.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 138BA28F531
	for <netdev@vger.kernel.org>; Mon,  7 Jul 2025 13:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751893294; cv=none; b=gXBqbNSC4tVAEFkP/JXv6Y5JTvTIV54LibODplPFM7DnpzwwhAWTCLUQUMtOItDgdu8GcwLG6sfvuO+iUpPTOxgLT7zXtjqrQHa0PkxYQJm/HvJ5x8qZo61FLhUhIeuSfU1u9gBnr735sSYLXozCJi+YWHmRNtfX+TBKCjrBPI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751893294; c=relaxed/simple;
	bh=CcejGQ8SHPlI1MV1L5CIzh1g4+lLG87YAF8mEG3K2Kg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UwviGHX4Ziue6zM8N/d0YXlk5atnzvCDRcVbPdB2766VsANQNuAt87F89vv/Tnc+CsGtrwuLpRMc2jfRLZuErKlY/ZIIR15vzbrR/zoq/AlFNY0zEbGh8PvNSnNEV6Y1LMpBdT+apScSHJhSaWeCmUkw+6ZelJZXQH8yXxO7Sr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UvXK76MD; arc=none smtp.client-ip=209.85.167.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-oi1-f201.google.com with SMTP id 5614622812f47-40b4c0b616fso2968918b6e.1
        for <netdev@vger.kernel.org>; Mon, 07 Jul 2025 06:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751893291; x=1752498091; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pzOJVWd/gQVz8kTkQbl/2Rgc6oY4s5cublCArg1AdME=;
        b=UvXK76MD1mnDtCh8tcg4PWc5hyLSh+29qigxPUZUdng8TpqkGpWHyDEA3N3S+29w7q
         o7r5Z44KU2r1B3uV5XadoOYo5o26tD4DRdAxg6Vcju0fGO2M8RCV/w2I377F8ldWlStO
         MOGPOb84eLkgBxaoDvaj/wO6OpNsURm/LLnEHqr+0Qpf2qFdiK7EkUXPm25kBpfmlTwX
         HNrQK22O0uPJPgEd6vY6oErZDTpukOwkqMWkJzUV/hq33tjkeLymQhTblDj1+FJ0Uz+H
         dDno9UP7aLDhKxOmMxRxIqmepHT1bt5sLf9SNKB0UBSSoeeqxFDrMGg4+gbYo3r4+i/L
         DCkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751893291; x=1752498091;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pzOJVWd/gQVz8kTkQbl/2Rgc6oY4s5cublCArg1AdME=;
        b=Y70EJ8qRzu/Z2b+WccNO0nJmN4uE16R+cDjrfqHNDF5P2bqgxxXmNS249Gz2xP0XgD
         NonH+Ciwg8izM2+j1Eyvh+HAeNA/g9Uw7qrFkye4yQL1VKWi1ZR8KRaq2G7modlwknTH
         tuMBkqp/M/dFAZFA4yzAKQh+sk6HeA3US1YTajROi6Vgv6PMwOsbtKXRF2oHSuOkR21f
         meQ71Rj+C6kOphGn3MnlGtD+3JPgMcVxHcEwrrGQBQLsCM2XKbUvC8JVcAS3zzH6YNYU
         Kc3i4CyGOZLKGjJ9lShO90x9k99aBo8WJwQUCJQuVnLzTb6NkYHTrW15coHmZnUuokmf
         3Ouw==
X-Forwarded-Encrypted: i=1; AJvYcCUPRwW19znFUpM3HIWlFrG4btZ5DqmBzQwYPJiygMAxDKXMxC9rlHzdcStV5kF5ho6d7bXiCAY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNOwhR48757owdsfdfi+8ExZlEdz7UG+whrXa3lFgwQMRQKHaG
	JOfQQ9lwz5ZH6XYzyqYvaqMbjsuJf2gUK1ztgqercynCrB86x+/3yw6iybSWMFse9AD3tHRF6Ol
	kjBlL1eIIaKJ65w==
X-Google-Smtp-Source: AGHT+IGhOgf+pfKFkjcsmMVXImXv/sFIPxMK0If7kNyIbtKjYxH3SZPMMTBNM1Q6caGZPAX4xZS9g8Lrj8pWyw==
X-Received: from qvkj27.prod.google.com ([2002:a0c:e01b:0:b0:704:7b0b:56fd])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:1a23:b0:401:bb42:700c with SMTP id 5614622812f47-40d02a66f5fmr9456626b6e.19.1751893291381;
 Mon, 07 Jul 2025 06:01:31 -0700 (PDT)
Date: Mon,  7 Jul 2025 13:01:09 +0000
In-Reply-To: <20250707130110.619822-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250707130110.619822-1-edumazet@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250707130110.619822-11-edumazet@google.com>
Subject: [PATCH net-next 10/11] net_sched: act_police: use RCU in tcf_police_dump()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Also storing tcf_action into struct tcf_police_params
makes sure there is no discrepancy in tcf_police_act().

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/tc_act/tc_police.h |  3 ++-
 net/sched/act_police.c         | 18 +++++++++---------
 2 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/include/net/tc_act/tc_police.h b/include/net/tc_act/tc_police.h
index 490d88cb52338592f57e43fb79d1c6955a9684eb..a89fc8e68b1e4343bb3f6ecfc06737ebbc385f0c 100644
--- a/include/net/tc_act/tc_police.h
+++ b/include/net/tc_act/tc_police.h
@@ -5,10 +5,11 @@
 #include <net/act_api.h>
 
 struct tcf_police_params {
+	int			action;
 	int			tcfp_result;
 	u32			tcfp_ewma_rate;
-	s64			tcfp_burst;
 	u32			tcfp_mtu;
+	s64			tcfp_burst;
 	s64			tcfp_mtu_ptoks;
 	s64			tcfp_pkt_burst;
 	struct psched_ratecfg	rate;
diff --git a/net/sched/act_police.c b/net/sched/act_police.c
index a214ed68114206ed0770725ab91d867bab35aa09..0e1c611833790b4b1d941faf0a05ef1bde2adcb9 100644
--- a/net/sched/act_police.c
+++ b/net/sched/act_police.c
@@ -198,6 +198,7 @@ static int tcf_police_init(struct net *net, struct nlattr *nla,
 		psched_ppscfg_precompute(&new->ppsrate, pps);
 	}
 
+	new->action = parm->action;
 	spin_lock_bh(&police->tcf_lock);
 	spin_lock_bh(&police->tcfp_lock);
 	police->tcfp_t_c = ktime_get_ns();
@@ -254,8 +255,8 @@ TC_INDIRECT_SCOPE int tcf_police_act(struct sk_buff *skb,
 	tcf_lastuse_update(&police->tcf_tm);
 	bstats_update(this_cpu_ptr(police->common.cpu_bstats), skb);
 
-	ret = READ_ONCE(police->tcf_action);
 	p = rcu_dereference_bh(police->params);
+	ret = p->action;
 
 	if (p->tcfp_ewma_rate) {
 		struct gnet_stats_rate_est64 sample;
@@ -338,9 +339,9 @@ static void tcf_police_stats_update(struct tc_action *a,
 static int tcf_police_dump(struct sk_buff *skb, struct tc_action *a,
 			       int bind, int ref)
 {
+	const struct tcf_police *police = to_police(a);
 	unsigned char *b = skb_tail_pointer(skb);
-	struct tcf_police *police = to_police(a);
-	struct tcf_police_params *p;
+	const struct tcf_police_params *p;
 	struct tc_police opt = {
 		.index = police->tcf_index,
 		.refcnt = refcount_read(&police->tcf_refcnt) - ref,
@@ -348,10 +349,9 @@ static int tcf_police_dump(struct sk_buff *skb, struct tc_action *a,
 	};
 	struct tcf_t t;
 
-	spin_lock_bh(&police->tcf_lock);
-	opt.action = police->tcf_action;
-	p = rcu_dereference_protected(police->params,
-				      lockdep_is_held(&police->tcf_lock));
+	rcu_read_lock();
+	p = rcu_dereference(police->params);
+	opt.action = p->action;
 	opt.mtu = p->tcfp_mtu;
 	opt.burst = PSCHED_NS2TICKS(p->tcfp_burst);
 	if (p->rate_present) {
@@ -392,12 +392,12 @@ static int tcf_police_dump(struct sk_buff *skb, struct tc_action *a,
 	tcf_tm_dump(&t, &police->tcf_tm);
 	if (nla_put_64bit(skb, TCA_POLICE_TM, sizeof(t), &t, TCA_POLICE_PAD))
 		goto nla_put_failure;
-	spin_unlock_bh(&police->tcf_lock);
+	rcu_read_unlock();
 
 	return skb->len;
 
 nla_put_failure:
-	spin_unlock_bh(&police->tcf_lock);
+	rcu_read_unlock();
 	nlmsg_trim(skb, b);
 	return -1;
 }
-- 
2.50.0.727.gbf7dc18ff4-goog



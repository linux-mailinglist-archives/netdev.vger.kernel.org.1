Return-Path: <netdev+bounces-204580-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA30AAFB3DC
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 15:03:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B9773AFEDF
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 13:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC56129DB6E;
	Mon,  7 Jul 2025 13:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jKYYnwYL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A58E29B78F
	for <netdev@vger.kernel.org>; Mon,  7 Jul 2025 13:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751893295; cv=none; b=myyFT3iKlpL+LIz1ecLSeYWMWBYh/VLDyzxju+Zkx846A1lZ4QOQ9odle5tO5hUNr2nht3RPHPfL/eIHIE/B/OSou0xX9a+XS1t5F2/RpbWZQEWE7mJYkOuWyrHsj3t2JK6Jzy80rcq9bEshEFPGP2rWQLcBzudLE+fR77jU4L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751893295; c=relaxed/simple;
	bh=hsu7U466GN1+zy4Qwvhx4fxvDuIMte/Witb5P1gAEyQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Aol+xXug7AM4gzOjnMPcPgumYekYYbmZMWN5+j5DweK1VNOh8XxbAXG1G5QoR661aZaS9phEJKjfdVO7CepIX0mntQVSxBVDnqC4A0XkS4zIdVWRhDdNY540LL5A8cQvk00QuBWa4om0Qs9ERI3K0XHzlQHiWmjiS0V4uVKLC2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jKYYnwYL; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-4a587c85a60so65955411cf.2
        for <netdev@vger.kernel.org>; Mon, 07 Jul 2025 06:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751893293; x=1752498093; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8WK+EUgqHXjydIumFBu4wkgRGYQLwWKZHC1itmkKhpA=;
        b=jKYYnwYLdQ20tKII6jo7zlxVs1lR9YJl6mAjPab8Er2Nix5R6GKxCz8zmORZHFR0DN
         u3O5Tk+FpmfNJCHSjmDdvTxhavU7buRl/Txfp5HPRsigWO1IPX1P7a7I9dLfmdk3PzKa
         Fg94NznIxdF7DYfomO/S5Edw9d9rhS4Ps6zIQuWRfD+kXE1bCzxsoC4AgORW/0bvom5z
         4uh7mavgmnQY2StPmYqiKe8cXoSFho0O61qWWCGjlUD9dQ1J4iVr3LvTpCdssG+8M+h7
         sN/uhqRMVxQkD1VmOs/ZYQI3NRbAGXa0LoromiPuluCALLlQTV8LbmlKKOW41OAu+BeR
         6pug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751893293; x=1752498093;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8WK+EUgqHXjydIumFBu4wkgRGYQLwWKZHC1itmkKhpA=;
        b=DYn4BIDGHqHk++a8juOXokRgeLi/to9TBCqChnX0Y4NiePVXF/CNZFYxH2IU65Sv5I
         ipfdOEt7VQfMwuFu6yMx9bmGLMvM/tukwbjnfu69pKVGOzsRROQmpPawBtjYGFbU6549
         RyWr7uIMawTxfkhdqG7gWvDcED02QQxTpdnMNZd60k0UH3NTMetef5mPlALJvCmhxorp
         IQ7pesm6tY+NySqgwtG504A3FlsBDx0faOqybyOv3d3bnfXrIiqn6GR3ZEtfkOCj99GD
         MHlDiBtX7nYpMKhRcGEsYB5ukNfD2I6oY8TyT9T+GYSJrqIiP95PKaABGcWsa8E5F8zx
         HuKA==
X-Forwarded-Encrypted: i=1; AJvYcCVnXghNJcBIeCLZX8p4TCs858cF0QCMRX/i1QCaQtvl7dKoyDqYPsqWB2ui8jDO6DfL9H0AdHc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZzH6jHMlocF2nJMgsOONa/GOg3HLVz0m8gEeYmBCr2mLQkUXT
	Zw3vrAvO+wchTL7K45Yl9XULxS4wayDzakoD8mOnRu6DaRb/pH/H3dk3O1dBxWgMfI1vfNnHhUl
	IlT1ai+obR4UGoQ==
X-Google-Smtp-Source: AGHT+IHqaeLqWfQiXeuzM4njVqR7Fl2EOejPPn+f2lN8bwMYLc66/yyl+BGxyDois85HkytYn4D3dW3/W6+zdw==
X-Received: from qtbfj12.prod.google.com ([2002:a05:622a:550c:b0:4a4:4c21:c3ac])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:580e:b0:476:8a27:6b01 with SMTP id d75a77b69052e-4a9a6977951mr143118931cf.47.1751893292964;
 Mon, 07 Jul 2025 06:01:32 -0700 (PDT)
Date: Mon,  7 Jul 2025 13:01:10 +0000
In-Reply-To: <20250707130110.619822-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250707130110.619822-1-edumazet@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250707130110.619822-12-edumazet@google.com>
Subject: [PATCH net-next 11/11] net_sched: act_skbedit: use RCU in tcf_skbedit_dump()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Also storing tcf_action into struct tcf_skbedit_params
makes sure there is no discrepancy in tcf_skbedit_act().

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/tc_act/tc_skbedit.h |  1 +
 net/sched/act_skbedit.c         | 20 +++++++++-----------
 2 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/include/net/tc_act/tc_skbedit.h b/include/net/tc_act/tc_skbedit.h
index 9649600fb3dcc35dee63950c9e0663c06604e1bd..31b2cd0bebb5b79d05a25aed00af98dd42e0c201 100644
--- a/include/net/tc_act/tc_skbedit.h
+++ b/include/net/tc_act/tc_skbedit.h
@@ -12,6 +12,7 @@
 #include <linux/tc_act/tc_skbedit.h>
 
 struct tcf_skbedit_params {
+	int action;
 	u32 flags;
 	u32 priority;
 	u32 mark;
diff --git a/net/sched/act_skbedit.c b/net/sched/act_skbedit.c
index 1f1d9ce3e968a2342a524c068d15912623de058f..8c1d1554f6575d3b0feae4d26ef4865d44a63e59 100644
--- a/net/sched/act_skbedit.c
+++ b/net/sched/act_skbedit.c
@@ -43,13 +43,11 @@ TC_INDIRECT_SCOPE int tcf_skbedit_act(struct sk_buff *skb,
 {
 	struct tcf_skbedit *d = to_skbedit(a);
 	struct tcf_skbedit_params *params;
-	int action;
 
 	tcf_lastuse_update(&d->tcf_tm);
 	bstats_update(this_cpu_ptr(d->common.cpu_bstats), skb);
 
 	params = rcu_dereference_bh(d->params);
-	action = READ_ONCE(d->tcf_action);
 
 	if (params->flags & SKBEDIT_F_PRIORITY)
 		skb->priority = params->priority;
@@ -85,7 +83,7 @@ TC_INDIRECT_SCOPE int tcf_skbedit_act(struct sk_buff *skb,
 	}
 	if (params->flags & SKBEDIT_F_PTYPE)
 		skb->pkt_type = params->ptype;
-	return action;
+	return params->action;
 
 err:
 	qstats_drop_inc(this_cpu_ptr(d->common.cpu_qstats));
@@ -262,6 +260,7 @@ static int tcf_skbedit_init(struct net *net, struct nlattr *nla,
 	if (flags & SKBEDIT_F_MASK)
 		params_new->mask = *mask;
 
+	params_new->action = parm->action;
 	spin_lock_bh(&d->tcf_lock);
 	goto_ch = tcf_action_set_ctrlact(*a, parm->action, goto_ch);
 	params_new = rcu_replace_pointer(d->params, params_new,
@@ -284,9 +283,9 @@ static int tcf_skbedit_init(struct net *net, struct nlattr *nla,
 static int tcf_skbedit_dump(struct sk_buff *skb, struct tc_action *a,
 			    int bind, int ref)
 {
+	const struct tcf_skbedit *d = to_skbedit(a);
 	unsigned char *b = skb_tail_pointer(skb);
-	struct tcf_skbedit *d = to_skbedit(a);
-	struct tcf_skbedit_params *params;
+	const struct tcf_skbedit_params *params;
 	struct tc_skbedit opt = {
 		.index   = d->tcf_index,
 		.refcnt  = refcount_read(&d->tcf_refcnt) - ref,
@@ -295,10 +294,9 @@ static int tcf_skbedit_dump(struct sk_buff *skb, struct tc_action *a,
 	u64 pure_flags = 0;
 	struct tcf_t t;
 
-	spin_lock_bh(&d->tcf_lock);
-	params = rcu_dereference_protected(d->params,
-					   lockdep_is_held(&d->tcf_lock));
-	opt.action = d->tcf_action;
+	rcu_read_lock();
+	params = rcu_dereference(d->params);
+	opt.action = params->action;
 
 	if (nla_put(skb, TCA_SKBEDIT_PARMS, sizeof(opt), &opt))
 		goto nla_put_failure;
@@ -333,12 +331,12 @@ static int tcf_skbedit_dump(struct sk_buff *skb, struct tc_action *a,
 	tcf_tm_dump(&t, &d->tcf_tm);
 	if (nla_put_64bit(skb, TCA_SKBEDIT_TM, sizeof(t), &t, TCA_SKBEDIT_PAD))
 		goto nla_put_failure;
-	spin_unlock_bh(&d->tcf_lock);
+	rcu_read_unlock();
 
 	return skb->len;
 
 nla_put_failure:
-	spin_unlock_bh(&d->tcf_lock);
+	rcu_read_unlock();
 	nlmsg_trim(skb, b);
 	return -1;
 }
-- 
2.50.0.727.gbf7dc18ff4-goog



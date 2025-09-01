Return-Path: <netdev+bounces-218675-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7108AB3DE84
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 11:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2DA42013EF
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 09:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B45D30EF7E;
	Mon,  1 Sep 2025 09:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vzv03FpF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE4A30E0D9
	for <netdev@vger.kernel.org>; Mon,  1 Sep 2025 09:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756718773; cv=none; b=nXLIINO4OrCilwJo5mgM5R3maTEo67xoEJasO7sWdRydpGRCK7Vpl5b7MiiimR/s4jWcSaLK+8Ywz2BwLKW+ayrFiIHROGUHsEF4v7DGq260uLp20yEaqz7MurEUnGeNFSDqb93kD51Xv4Heza2sqFLSqZTwDEgSPdw1NH4nEf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756718773; c=relaxed/simple;
	bh=G9PfaWDZdD/GtP3yqiDSk+HOqVC4Z40vbHjTCmLx+V0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=jL13MJcgOKodP05BcwXGZXmToSg2+vakMYrUcpjrux92jFavpwKa39keMsEACy5LJ7PNyCmXyb39IezGlrZAUORBuADmTPl1dlIgQqWguYCA9RIiXqteVwOYuChA/mhOBnDq9YperCfkU+9LnMYX6Mywz6eiRpkHRWrCVnvFjp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vzv03FpF; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-4b32d323297so20953611cf.1
        for <netdev@vger.kernel.org>; Mon, 01 Sep 2025 02:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756718770; x=1757323570; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pJYPoBQUInG6z+9C6LI1Q2eM+QtWM/gk1TicRzuaN2k=;
        b=vzv03FpFHk/QPz+b6Z5PISdQWbcuE5qBXFxbrnQTozmz09NcC4Apjta60NFL6bsK/k
         /E4kr76FF4HGi4zgRtkYnQFJz1I5+pKjHKKs3eimjqwEVpGjvdM4BwMvQeQph1lLSANV
         hSQuo7/l1iuyyfumBQohGxXrZZpOM4vSpym7ZMIA50v92s0aTwYdXJm9K7NQDsyAJLsI
         bcvmcpcFjzT5voJr8BRZnDqqTy6TCwlKIIAn0RW/XnVlC5dc2gMBuduvLpwyrR5dTT3N
         5UK6PdhKO6dp+GNqD3gbJ4ePUwjrrNTwaczFfNwF9JLRzx0ISMtEpeIyYFdrjHiKCevB
         +5vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756718770; x=1757323570;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pJYPoBQUInG6z+9C6LI1Q2eM+QtWM/gk1TicRzuaN2k=;
        b=t5SAEMQR48iFWacy7tHn4e4vfcC9tHMvO1N39A9MH/WxPQN81pUhuPrk7KQL4y6Z+7
         6/RjuWYwR6ZEnFB2IkDylV/gsz6PAbzc4VxNRdiFV9SocQ3Uq2meLO7+Dd2FPO0rn5vd
         hLLPjZCKA963eZDTEDyrqPXiEpx3QdqDKdMkvMRCXIsF5VjpItQHbTtKrZm+9XMFOlZR
         7WrJl9Qp1omptwc+zCTHtRDR+ugcchlg5+klGr+Yk0FGXtXEwtX1q6I/mtcF3wk15rFw
         LYULSlTuKzijNNOiRucVXqYYRhJ01xUI4yRnMb4lJvm74RkG8qD8BdvwD4bxujFM5kaJ
         81Wg==
X-Forwarded-Encrypted: i=1; AJvYcCUk18RhODM5DO8mc47lfbZdqEuuDZMWyy22x8xCOSWzwoljp0hgjt/nPO90zO3UDDw6Qzv3hzU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8G9I52UHUgGA7SeHzumLm3R1esa8frDUereEKRzNwmMHwIRee
	rFXgFRHw+JCRN3C38PQC/dQw24Itfdzzv9Yjmmvsx0seQWjXKICbE/z7Vzuez2ZLsW5xiT00jsg
	dDOQlV6OpF7+pwA==
X-Google-Smtp-Source: AGHT+IFnT5mVD3HhsWR8vUlxg4mqlAiLH/rsGcfx3XffnYwBf2EYufIQnlUy5CEdJSVUdVwOf968HsclI+HHdg==
X-Received: from qtbne14.prod.google.com ([2002:a05:622a:830e:b0:4ab:6375:3dda])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:1812:b0:4b2:94e5:9847 with SMTP id d75a77b69052e-4b31dcac538mr96926221cf.74.1756718770325;
 Mon, 01 Sep 2025 02:26:10 -0700 (PDT)
Date: Mon,  1 Sep 2025 09:26:07 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
Message-ID: <20250901092608.2032473-1-edumazet@google.com>
Subject: [PATCH net-next] net_sched: add back BH safety to tcf_lock
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Jamal reported that we had to use BH safety after all,
because stats can be updated from BH handler.

Fixes: 3133d5c15cb5 ("net_sched: remove BH blocking in eight actions")
Fixes: 53df77e78590 ("net_sched: act_skbmod: use RCU in tcf_skbmod_dump()")
Fixes: e97ae742972f ("net_sched: act_tunnel_key: use RCU in tunnel_key_dump()")
Fixes: 48b5e5dbdb23 ("net_sched: act_vlan: use RCU in tcf_vlan_dump()")
Reported-by: Jamal Hadi Salim <jhs@mojatatu.com>
Closes: https://lore.kernel.org/netdev/CAM0EoMmhq66EtVqDEuNik8MVFZqkgxFbMu=fJtbNoYD7YXg4bA@mail.gmail.com/
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/sched/act_connmark.c   | 4 ++--
 net/sched/act_csum.c       | 4 ++--
 net/sched/act_ct.c         | 4 ++--
 net/sched/act_ctinfo.c     | 4 ++--
 net/sched/act_mpls.c       | 4 ++--
 net/sched/act_nat.c        | 4 ++--
 net/sched/act_pedit.c      | 4 ++--
 net/sched/act_skbedit.c    | 4 ++--
 net/sched/act_skbmod.c     | 4 ++--
 net/sched/act_tunnel_key.c | 4 ++--
 net/sched/act_vlan.c       | 4 ++--
 11 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/net/sched/act_connmark.c b/net/sched/act_connmark.c
index bf2d6b6da042..3e89927d7116 100644
--- a/net/sched/act_connmark.c
+++ b/net/sched/act_connmark.c
@@ -169,10 +169,10 @@ static int tcf_connmark_init(struct net *net, struct nlattr *nla,
 
 	nparms->action = parm->action;
 
-	spin_lock(&ci->tcf_lock);
+	spin_lock_bh(&ci->tcf_lock);
 	goto_ch = tcf_action_set_ctrlact(*a, parm->action, goto_ch);
 	oparms = rcu_replace_pointer(ci->parms, nparms, lockdep_is_held(&ci->tcf_lock));
-	spin_unlock(&ci->tcf_lock);
+	spin_unlock_bh(&ci->tcf_lock);
 
 	if (goto_ch)
 		tcf_chain_put_by_act(goto_ch);
diff --git a/net/sched/act_csum.c b/net/sched/act_csum.c
index 8bad91753615..0939e6b2ba4d 100644
--- a/net/sched/act_csum.c
+++ b/net/sched/act_csum.c
@@ -101,11 +101,11 @@ static int tcf_csum_init(struct net *net, struct nlattr *nla,
 	params_new->update_flags = parm->update_flags;
 	params_new->action = parm->action;
 
-	spin_lock(&p->tcf_lock);
+	spin_lock_bh(&p->tcf_lock);
 	goto_ch = tcf_action_set_ctrlact(*a, parm->action, goto_ch);
 	params_new = rcu_replace_pointer(p->params, params_new,
 					 lockdep_is_held(&p->tcf_lock));
-	spin_unlock(&p->tcf_lock);
+	spin_unlock_bh(&p->tcf_lock);
 
 	if (goto_ch)
 		tcf_chain_put_by_act(goto_ch);
diff --git a/net/sched/act_ct.c b/net/sched/act_ct.c
index 6d2355e73b0f..6749a4a9a9cd 100644
--- a/net/sched/act_ct.c
+++ b/net/sched/act_ct.c
@@ -1410,11 +1410,11 @@ static int tcf_ct_init(struct net *net, struct nlattr *nla,
 		goto cleanup;
 
 	params->action = parm->action;
-	spin_lock(&c->tcf_lock);
+	spin_lock_bh(&c->tcf_lock);
 	goto_ch = tcf_action_set_ctrlact(*a, parm->action, goto_ch);
 	params = rcu_replace_pointer(c->params, params,
 				     lockdep_is_held(&c->tcf_lock));
-	spin_unlock(&c->tcf_lock);
+	spin_unlock_bh(&c->tcf_lock);
 
 	if (goto_ch)
 		tcf_chain_put_by_act(goto_ch);
diff --git a/net/sched/act_ctinfo.c b/net/sched/act_ctinfo.c
index 6f79eed9a544..71efe04d00b5 100644
--- a/net/sched/act_ctinfo.c
+++ b/net/sched/act_ctinfo.c
@@ -258,11 +258,11 @@ static int tcf_ctinfo_init(struct net *net, struct nlattr *nla,
 
 	cp_new->action = actparm->action;
 
-	spin_lock(&ci->tcf_lock);
+	spin_lock_bh(&ci->tcf_lock);
 	goto_ch = tcf_action_set_ctrlact(*a, actparm->action, goto_ch);
 	cp_new = rcu_replace_pointer(ci->params, cp_new,
 				     lockdep_is_held(&ci->tcf_lock));
-	spin_unlock(&ci->tcf_lock);
+	spin_unlock_bh(&ci->tcf_lock);
 
 	if (goto_ch)
 		tcf_chain_put_by_act(goto_ch);
diff --git a/net/sched/act_mpls.c b/net/sched/act_mpls.c
index ed7bdaa23f0d..6654011dcd2b 100644
--- a/net/sched/act_mpls.c
+++ b/net/sched/act_mpls.c
@@ -296,10 +296,10 @@ static int tcf_mpls_init(struct net *net, struct nlattr *nla,
 					     htons(ETH_P_MPLS_UC));
 	p->action = parm->action;
 
-	spin_lock(&m->tcf_lock);
+	spin_lock_bh(&m->tcf_lock);
 	goto_ch = tcf_action_set_ctrlact(*a, parm->action, goto_ch);
 	p = rcu_replace_pointer(m->mpls_p, p, lockdep_is_held(&m->tcf_lock));
-	spin_unlock(&m->tcf_lock);
+	spin_unlock_bh(&m->tcf_lock);
 
 	if (goto_ch)
 		tcf_chain_put_by_act(goto_ch);
diff --git a/net/sched/act_nat.c b/net/sched/act_nat.c
index 9cc2a1772cf8..26241d80ebe0 100644
--- a/net/sched/act_nat.c
+++ b/net/sched/act_nat.c
@@ -95,10 +95,10 @@ static int tcf_nat_init(struct net *net, struct nlattr *nla, struct nlattr *est,
 
 	p = to_tcf_nat(*a);
 
-	spin_lock(&p->tcf_lock);
+	spin_lock_bh(&p->tcf_lock);
 	goto_ch = tcf_action_set_ctrlact(*a, parm->action, goto_ch);
 	oparm = rcu_replace_pointer(p->parms, nparm, lockdep_is_held(&p->tcf_lock));
-	spin_unlock(&p->tcf_lock);
+	spin_unlock_bh(&p->tcf_lock);
 
 	if (goto_ch)
 		tcf_chain_put_by_act(goto_ch);
diff --git a/net/sched/act_pedit.c b/net/sched/act_pedit.c
index 8fc8f577cb7a..4b65901397a8 100644
--- a/net/sched/act_pedit.c
+++ b/net/sched/act_pedit.c
@@ -280,10 +280,10 @@ static int tcf_pedit_init(struct net *net, struct nlattr *nla,
 
 	p = to_pedit(*a);
 	nparms->action = parm->action;
-	spin_lock(&p->tcf_lock);
+	spin_lock_bh(&p->tcf_lock);
 	goto_ch = tcf_action_set_ctrlact(*a, parm->action, goto_ch);
 	oparms = rcu_replace_pointer(p->parms, nparms, 1);
-	spin_unlock(&p->tcf_lock);
+	spin_unlock_bh(&p->tcf_lock);
 
 	if (oparms)
 		call_rcu(&oparms->rcu, tcf_pedit_cleanup_rcu);
diff --git a/net/sched/act_skbedit.c b/net/sched/act_skbedit.c
index aa6b1744de21..8c1d1554f657 100644
--- a/net/sched/act_skbedit.c
+++ b/net/sched/act_skbedit.c
@@ -261,11 +261,11 @@ static int tcf_skbedit_init(struct net *net, struct nlattr *nla,
 		params_new->mask = *mask;
 
 	params_new->action = parm->action;
-	spin_lock(&d->tcf_lock);
+	spin_lock_bh(&d->tcf_lock);
 	goto_ch = tcf_action_set_ctrlact(*a, parm->action, goto_ch);
 	params_new = rcu_replace_pointer(d->params, params_new,
 					 lockdep_is_held(&d->tcf_lock));
-	spin_unlock(&d->tcf_lock);
+	spin_unlock_bh(&d->tcf_lock);
 	if (params_new)
 		kfree_rcu(params_new, rcu);
 	if (goto_ch)
diff --git a/net/sched/act_skbmod.c b/net/sched/act_skbmod.c
index fce625eafcb2..a9e0c1326e2a 100644
--- a/net/sched/act_skbmod.c
+++ b/net/sched/act_skbmod.c
@@ -194,7 +194,7 @@ static int tcf_skbmod_init(struct net *net, struct nlattr *nla,
 	p->flags = lflags;
 	p->action = parm->action;
 	if (ovr)
-		spin_lock(&d->tcf_lock);
+		spin_lock_bh(&d->tcf_lock);
 	/* Protected by tcf_lock if overwriting existing action. */
 	goto_ch = tcf_action_set_ctrlact(*a, parm->action, goto_ch);
 	p_old = rcu_dereference_protected(d->skbmod_p, 1);
@@ -208,7 +208,7 @@ static int tcf_skbmod_init(struct net *net, struct nlattr *nla,
 
 	rcu_assign_pointer(d->skbmod_p, p);
 	if (ovr)
-		spin_unlock(&d->tcf_lock);
+		spin_unlock_bh(&d->tcf_lock);
 
 	if (p_old)
 		kfree_rcu(p_old, rcu);
diff --git a/net/sched/act_tunnel_key.c b/net/sched/act_tunnel_key.c
index e1c8b48c217c..876b30c5709e 100644
--- a/net/sched/act_tunnel_key.c
+++ b/net/sched/act_tunnel_key.c
@@ -531,11 +531,11 @@ static int tunnel_key_init(struct net *net, struct nlattr *nla,
 	params_new->tcft_enc_metadata = metadata;
 
 	params_new->action = parm->action;
-	spin_lock(&t->tcf_lock);
+	spin_lock_bh(&t->tcf_lock);
 	goto_ch = tcf_action_set_ctrlact(*a, parm->action, goto_ch);
 	params_new = rcu_replace_pointer(t->params, params_new,
 					 lockdep_is_held(&t->tcf_lock));
-	spin_unlock(&t->tcf_lock);
+	spin_unlock_bh(&t->tcf_lock);
 	tunnel_key_release_params(params_new);
 	if (goto_ch)
 		tcf_chain_put_by_act(goto_ch);
diff --git a/net/sched/act_vlan.c b/net/sched/act_vlan.c
index b46f980f3b2a..a74621797d69 100644
--- a/net/sched/act_vlan.c
+++ b/net/sched/act_vlan.c
@@ -253,10 +253,10 @@ static int tcf_vlan_init(struct net *net, struct nlattr *nla,
 	}
 
 	p->action = parm->action;
-	spin_lock(&v->tcf_lock);
+	spin_lock_bh(&v->tcf_lock);
 	goto_ch = tcf_action_set_ctrlact(*a, parm->action, goto_ch);
 	p = rcu_replace_pointer(v->vlan_p, p, lockdep_is_held(&v->tcf_lock));
-	spin_unlock(&v->tcf_lock);
+	spin_unlock_bh(&v->tcf_lock);
 
 	if (goto_ch)
 		tcf_chain_put_by_act(goto_ch);
-- 
2.51.0.318.gd7df087d1a-goog



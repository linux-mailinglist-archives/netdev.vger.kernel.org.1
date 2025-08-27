Return-Path: <netdev+bounces-217282-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17A25B382E1
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 14:54:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11E8B461AAC
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 12:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FC0D34AB0C;
	Wed, 27 Aug 2025 12:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zG/w+4ka"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F50030CD81
	for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 12:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756299237; cv=none; b=JHAJPl0Z/43f16EAlkxotFVVdvSTeploCAIpou4mLQXIFmwi1q0MJofj3jxSSjFawt6Oa3LedYyuvZExeNMS+Z7LWmASiJaCivcuHVXur+HGu7MEJjqVCF0iDPhjJaxEs+u/MPWcx+YAUstBBSS0ENBIN/jWYJtcXh5Mwp/4J2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756299237; c=relaxed/simple;
	bh=zkzRUCpFRa5edw94cSno6DisN8D4X5a1JyRyOJnR8BE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SDyqag+sUCRHX0WJ3mPweY79MzT1P87jbZkaO0993NSBIcOEXq5lDqZiztaXXkixekSheMb0WvKEDhMEJSKjO07yYKodv05Yg8rUC3n+mXsbTYi6PtzJBslvYrRS7Joz/IMAiktzKnIs7YtpYT6S5zeLFeLnrRsohVeagsTdSe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zG/w+4ka; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-7e8704c5867so2455913585a.1
        for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 05:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756299234; x=1756904034; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6ny8i1I7CyZAb3tMpppQPSGRZMl9CVDv/tV/k0yj0JU=;
        b=zG/w+4kaykl0GWl7767eyCbDeOOdrf7+1T/IWnh5bXIQlAJeMA9SxNZuI4YegpwVEU
         uaIdqu/kN+I9QxRxstaztOm5LUdQ+SSwa7yVC2Tpzl0P0AWiAz3YWLtAxOva6UwbW1VV
         5ZF6fuUV/tqT0Pz75mI4TWkbhEl0UdNhnR2YzAegow5vz0rD/vG2mHbsvt85ASW7opej
         K/V0Hmq5EXtMJ5Qe5GIYZilwsQLNF7+lqcCLkL3QLtQOo4OBISAaS8HIIqIrHvkANe7H
         JqPUNb7crbFNyrmR8wYiLzdHLQlwPO3oVyRQSA9cYMwAL61LCvZLx0qt26Lj1v5Te3oE
         gBow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756299234; x=1756904034;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6ny8i1I7CyZAb3tMpppQPSGRZMl9CVDv/tV/k0yj0JU=;
        b=EA/5wT5km68oqhAF70qO2XwtWe/Un6HB6ic1hzyEQpMUgjNvImvZzpknhuJUZmDSLQ
         lMyr6dvUrzWnqz6CFGlLJxyELcKIivHlR7S9MO5rriT18DnGwXKB8DY3Gcn/WOais/dE
         DZzmZVEbCtNv82bs7LDz1Oy0pssQ2gRlJSUoenHjDLcAc5R/Kb0MyKu+GC+hyaMcv1h/
         Alk7yG2wncUTxYUTxEqRRwNPL2a/XQjBMMjM+w9KIUP5deRLOAy88wGifYZDkJpHrmW6
         XKmEGJ60aIGkR4yiH1nv7tORP0PDzCvHPTQLP3CdAmy4u52+OYYt725QkkLHZfCqxFeK
         syPw==
X-Forwarded-Encrypted: i=1; AJvYcCWlB5dN7BTJgjvU97Jyw2uwn+SYg50LQDm1QWD8AGpfS3Em9I6aHEkvqr8J6itJ3jKEqQNmhX8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiD4Nm4WA+CkUP77q323rxNMFEHXKaddYOyedWOf5ypASJP+Uz
	IUg2Qs5xX8Gc/Ax9CahnawTB/GaxUctDBnuKVTaGYLdCoKxeEsLLjwbtwChoa4UjiYOvHwwTJ4G
	Zewy2BvoQSzasfA==
X-Google-Smtp-Source: AGHT+IGvhG245mPeQrWo4gRFRjk+rBGmtXhRXyMgxSg6hnX2UQY6qtnzqkSRVhSDqmolniEHeSPSVaRFxcsi0g==
X-Received: from qkpb20.prod.google.com ([2002:a05:620a:2714:b0:7e8:336:737b])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:1a11:b0:7e9:f81f:ce84 with SMTP id af79cd13be357-7ea1108e2e5mr2154523085a.70.1756299234256;
 Wed, 27 Aug 2025 05:53:54 -0700 (PDT)
Date: Wed, 27 Aug 2025 12:53:46 +0000
In-Reply-To: <20250827125349.3505302-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250827125349.3505302-1-edumazet@google.com>
X-Mailer: git-send-email 2.51.0.261.g7ce5a0a67e-goog
Message-ID: <20250827125349.3505302-2-edumazet@google.com>
Subject: [PATCH net-next 1/4] net_sched: remove BH blocking in eight actions
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Followup of f45b45cbfae3 ("Merge branch
'net_sched-act-extend-rcu-use-in-dump-methods'")

We never grab tcf_lock from BH context in these modules:

 act_connmark
 act_csum
 act_ct
 act_ctinfo
 act_mpls
 act_nat
 act_pedit
 act_skbedit

No longer block BH when acquiring tcf_lock from init functions.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/sched/act_connmark.c | 4 ++--
 net/sched/act_csum.c     | 4 ++--
 net/sched/act_ct.c       | 4 ++--
 net/sched/act_ctinfo.c   | 4 ++--
 net/sched/act_mpls.c     | 4 ++--
 net/sched/act_nat.c      | 4 ++--
 net/sched/act_pedit.c    | 4 ++--
 net/sched/act_skbedit.c  | 4 ++--
 8 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/net/sched/act_connmark.c b/net/sched/act_connmark.c
index 3e89927d711647d75f31c8d80a3ddd102e3d2e36..bf2d6b6da04223e1acaa7e9f5d29d426db06d705 100644
--- a/net/sched/act_connmark.c
+++ b/net/sched/act_connmark.c
@@ -169,10 +169,10 @@ static int tcf_connmark_init(struct net *net, struct nlattr *nla,
 
 	nparms->action = parm->action;
 
-	spin_lock_bh(&ci->tcf_lock);
+	spin_lock(&ci->tcf_lock);
 	goto_ch = tcf_action_set_ctrlact(*a, parm->action, goto_ch);
 	oparms = rcu_replace_pointer(ci->parms, nparms, lockdep_is_held(&ci->tcf_lock));
-	spin_unlock_bh(&ci->tcf_lock);
+	spin_unlock(&ci->tcf_lock);
 
 	if (goto_ch)
 		tcf_chain_put_by_act(goto_ch);
diff --git a/net/sched/act_csum.c b/net/sched/act_csum.c
index 0939e6b2ba4d1947df0f3dcfc09bfaa339a6ace2..8bad91753615a08d78d99086fd6a7ab6e4c8e857 100644
--- a/net/sched/act_csum.c
+++ b/net/sched/act_csum.c
@@ -101,11 +101,11 @@ static int tcf_csum_init(struct net *net, struct nlattr *nla,
 	params_new->update_flags = parm->update_flags;
 	params_new->action = parm->action;
 
-	spin_lock_bh(&p->tcf_lock);
+	spin_lock(&p->tcf_lock);
 	goto_ch = tcf_action_set_ctrlact(*a, parm->action, goto_ch);
 	params_new = rcu_replace_pointer(p->params, params_new,
 					 lockdep_is_held(&p->tcf_lock));
-	spin_unlock_bh(&p->tcf_lock);
+	spin_unlock(&p->tcf_lock);
 
 	if (goto_ch)
 		tcf_chain_put_by_act(goto_ch);
diff --git a/net/sched/act_ct.c b/net/sched/act_ct.c
index 6749a4a9a9cd0a43897fcd20d228721ce057cb88..6d2355e73b0f55750679b48e562e148d2cd8b7d4 100644
--- a/net/sched/act_ct.c
+++ b/net/sched/act_ct.c
@@ -1410,11 +1410,11 @@ static int tcf_ct_init(struct net *net, struct nlattr *nla,
 		goto cleanup;
 
 	params->action = parm->action;
-	spin_lock_bh(&c->tcf_lock);
+	spin_lock(&c->tcf_lock);
 	goto_ch = tcf_action_set_ctrlact(*a, parm->action, goto_ch);
 	params = rcu_replace_pointer(c->params, params,
 				     lockdep_is_held(&c->tcf_lock));
-	spin_unlock_bh(&c->tcf_lock);
+	spin_unlock(&c->tcf_lock);
 
 	if (goto_ch)
 		tcf_chain_put_by_act(goto_ch);
diff --git a/net/sched/act_ctinfo.c b/net/sched/act_ctinfo.c
index 71efe04d00b5c6195e43f1ea6dab1548f6f97293..6f79eed9a544a49aed35ac0557250a3d5a9fc576 100644
--- a/net/sched/act_ctinfo.c
+++ b/net/sched/act_ctinfo.c
@@ -258,11 +258,11 @@ static int tcf_ctinfo_init(struct net *net, struct nlattr *nla,
 
 	cp_new->action = actparm->action;
 
-	spin_lock_bh(&ci->tcf_lock);
+	spin_lock(&ci->tcf_lock);
 	goto_ch = tcf_action_set_ctrlact(*a, actparm->action, goto_ch);
 	cp_new = rcu_replace_pointer(ci->params, cp_new,
 				     lockdep_is_held(&ci->tcf_lock));
-	spin_unlock_bh(&ci->tcf_lock);
+	spin_unlock(&ci->tcf_lock);
 
 	if (goto_ch)
 		tcf_chain_put_by_act(goto_ch);
diff --git a/net/sched/act_mpls.c b/net/sched/act_mpls.c
index 6654011dcd2ba30769b2f52078373a834e259f88..ed7bdaa23f0d80caef6bd5cd5b9787e24ff2d1af 100644
--- a/net/sched/act_mpls.c
+++ b/net/sched/act_mpls.c
@@ -296,10 +296,10 @@ static int tcf_mpls_init(struct net *net, struct nlattr *nla,
 					     htons(ETH_P_MPLS_UC));
 	p->action = parm->action;
 
-	spin_lock_bh(&m->tcf_lock);
+	spin_lock(&m->tcf_lock);
 	goto_ch = tcf_action_set_ctrlact(*a, parm->action, goto_ch);
 	p = rcu_replace_pointer(m->mpls_p, p, lockdep_is_held(&m->tcf_lock));
-	spin_unlock_bh(&m->tcf_lock);
+	spin_unlock(&m->tcf_lock);
 
 	if (goto_ch)
 		tcf_chain_put_by_act(goto_ch);
diff --git a/net/sched/act_nat.c b/net/sched/act_nat.c
index 26241d80ebe03e74a92e951fb5ae065493b93277..9cc2a1772cf8290a4be7d6e694e2ceccd48c386a 100644
--- a/net/sched/act_nat.c
+++ b/net/sched/act_nat.c
@@ -95,10 +95,10 @@ static int tcf_nat_init(struct net *net, struct nlattr *nla, struct nlattr *est,
 
 	p = to_tcf_nat(*a);
 
-	spin_lock_bh(&p->tcf_lock);
+	spin_lock(&p->tcf_lock);
 	goto_ch = tcf_action_set_ctrlact(*a, parm->action, goto_ch);
 	oparm = rcu_replace_pointer(p->parms, nparm, lockdep_is_held(&p->tcf_lock));
-	spin_unlock_bh(&p->tcf_lock);
+	spin_unlock(&p->tcf_lock);
 
 	if (goto_ch)
 		tcf_chain_put_by_act(goto_ch);
diff --git a/net/sched/act_pedit.c b/net/sched/act_pedit.c
index 4b65901397a88864014f74c53d0fa00b40ac6613..8fc8f577cb7a8362fee60cd79cce263edca32a7a 100644
--- a/net/sched/act_pedit.c
+++ b/net/sched/act_pedit.c
@@ -280,10 +280,10 @@ static int tcf_pedit_init(struct net *net, struct nlattr *nla,
 
 	p = to_pedit(*a);
 	nparms->action = parm->action;
-	spin_lock_bh(&p->tcf_lock);
+	spin_lock(&p->tcf_lock);
 	goto_ch = tcf_action_set_ctrlact(*a, parm->action, goto_ch);
 	oparms = rcu_replace_pointer(p->parms, nparms, 1);
-	spin_unlock_bh(&p->tcf_lock);
+	spin_unlock(&p->tcf_lock);
 
 	if (oparms)
 		call_rcu(&oparms->rcu, tcf_pedit_cleanup_rcu);
diff --git a/net/sched/act_skbedit.c b/net/sched/act_skbedit.c
index 8c1d1554f6575d3b0feae4d26ef4865d44a63e59..aa6b1744de21c1dca223cb87a919dc3e29841b83 100644
--- a/net/sched/act_skbedit.c
+++ b/net/sched/act_skbedit.c
@@ -261,11 +261,11 @@ static int tcf_skbedit_init(struct net *net, struct nlattr *nla,
 		params_new->mask = *mask;
 
 	params_new->action = parm->action;
-	spin_lock_bh(&d->tcf_lock);
+	spin_lock(&d->tcf_lock);
 	goto_ch = tcf_action_set_ctrlact(*a, parm->action, goto_ch);
 	params_new = rcu_replace_pointer(d->params, params_new,
 					 lockdep_is_held(&d->tcf_lock));
-	spin_unlock_bh(&d->tcf_lock);
+	spin_unlock(&d->tcf_lock);
 	if (params_new)
 		kfree_rcu(params_new, rcu);
 	if (goto_ch)
-- 
2.51.0.261.g7ce5a0a67e-goog



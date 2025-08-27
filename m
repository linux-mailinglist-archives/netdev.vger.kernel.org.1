Return-Path: <netdev+bounces-217285-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CFDF4B382E4
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 14:54:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EDD41BA1F94
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 12:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85A9134AB1A;
	Wed, 27 Aug 2025 12:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bGzekVmZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5D234DCD2
	for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 12:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756299248; cv=none; b=CcNuMJi6YfDjO/h6ahpdSX3238Fz5ZZzomCGmvvqePyRQdgZzfjPmFPcWkD1gyMrezu/BoziYPo5iuc/U6D4+p9Ii3j+Wyq2NEMbFT0zktLfrRdY/8MKvFn6AtEU2yo8hvtnQDBgERbIMkFh7RhcykgVlycypU/Ikm/6b3DMvlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756299248; c=relaxed/simple;
	bh=t7keYkahwLI3m1DIEtzWANMbakVd/tBC1sDtUz/sOpc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aVJKaIT8BhhIhx+FtwwfxPFYHGM6jqjsJXTBZnOxuMvgNRUCFZ/oBnvbaEAFbQG4mxNxMzExFBjH1lALnPdvR2a1sAUJHQoZeuLaiSw+sjKdMRjAhdof/Aoy0QhAWo7UuOHBpvPOqVyPg7YJ6R48kEFMUTfqoW7zxab/SV/CwLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bGzekVmZ; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-7f674810ddbso316570585a.3
        for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 05:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756299244; x=1756904044; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cF1clRdyNjbempIEUQ66e1bj2W1Th4RhUSzzw5xkIeE=;
        b=bGzekVmZWba7LCkXHJ64O7xKH4EXIFf9F2VxngluJ+xff7NtJgq0olwpJ+wCM1Iktl
         G90oZNoNwhSEEtps+V6XRwim+JFhbyHDxCh4OmMxkIUogXOoEYejFNovT19gfVNPD+Ju
         8mb4MVpFV8Uin1DwA9GBmDAi20iJ531IEcZTQtUyFEMpTvs6J4I1eDb7+CJHVzT8OHoa
         HAm7gag0waQEIroU2HGEM5S5xIdh6Ux/0USKuPztJKSg5UutdAsWvoPjjxqKLuaD9osJ
         7UFVhuxnbUTDx488rqfxNnbksSvunHzoqoiPQpfCSNVPH1XWwMrDe6yVN119Tex1H9FA
         UnVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756299244; x=1756904044;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cF1clRdyNjbempIEUQ66e1bj2W1Th4RhUSzzw5xkIeE=;
        b=OidXW7TeXjBU0DFrS7o5DFX3JfervsWJgWqLEAYOWvjQ6kXmxyTWYgKLFwakHijRvk
         1w4Nlxq490H9Ic1b5N4LoWYgp0Q1uNNVAvw1VNP/OnjoJPWcjq6k+MyLQcvb2/p0EIIB
         JBcVRStfBZSKBbShTh4WeXIoSWTuvcIghzvk4jhJNM6ZwEJ2bCrBiu16O1lER1sfrxAh
         /W4LXtscfcxY6TojwnHUvK5+HQ3BphsnGhma7s7ew/7atr3i51bJJp/WdRV7Qd19mLj2
         tR+xlk0m6SrkGvi6z+zO3iq1TNd+3rGF/KgkNaxnrYrqotBvJjOSn+0o91xOgruEXnPR
         LwEA==
X-Forwarded-Encrypted: i=1; AJvYcCWbRSk3dcDHxfAsiRmllfisaoG5/Sr3zHZDDeOIqXZD3dESP6ZopJYGK9MJMfnijX11veOEcEE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxP+gsSe8TSVpo9bMnjKwMleM4OF0bHM9R//EnYpBh/53M5hoIn
	4BVXlcNVLGbvNZm7uZisuoLDMOVK03IFJ7M1v9kZHa61fkXzwmJizemj39SX9eh0PYavVw5G17L
	Va0RO2oGmELf6kw==
X-Google-Smtp-Source: AGHT+IE0+QY78Gqw0blamf5DEd5j2GU1hN7GGlLHPcUfrQzy7xHr9SwzsQG7cnlYW1SPV90PHEhGWJLJ5/yG4A==
X-Received: from qkbdx10.prod.google.com ([2002:a05:620a:608a:b0:7e8:7199:dfc9])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:2995:b0:7e6:9ce4:198a with SMTP id af79cd13be357-7ea11068c07mr2283821385a.43.1756299244608;
 Wed, 27 Aug 2025 05:54:04 -0700 (PDT)
Date: Wed, 27 Aug 2025 12:53:49 +0000
In-Reply-To: <20250827125349.3505302-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250827125349.3505302-1-edumazet@google.com>
X-Mailer: git-send-email 2.51.0.261.g7ce5a0a67e-goog
Message-ID: <20250827125349.3505302-5-edumazet@google.com>
Subject: [PATCH net-next 4/4] net_sched: act_skbmod: use RCU in tcf_skbmod_dump()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Also storing tcf_action into struct tcf_skbmod_params
makes sure there is no discrepancy in tcf_skbmod_act().

No longer block BH in tcf_skbmod_init() when acquiring tcf_lock.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/tc_act/tc_skbmod.h |  1 +
 net/sched/act_skbmod.c         | 26 ++++++++++++--------------
 2 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/include/net/tc_act/tc_skbmod.h b/include/net/tc_act/tc_skbmod.h
index 7c240d2fed4e3cdf686016588cd78eb52b80765b..626704cd6241b37f20539f9dd1270275ba19e578 100644
--- a/include/net/tc_act/tc_skbmod.h
+++ b/include/net/tc_act/tc_skbmod.h
@@ -12,6 +12,7 @@
 struct tcf_skbmod_params {
 	struct rcu_head	rcu;
 	u64	flags; /*up to 64 types of operations; extend if needed */
+	int	action;
 	u8	eth_dst[ETH_ALEN];
 	u16	eth_type;
 	u8	eth_src[ETH_ALEN];
diff --git a/net/sched/act_skbmod.c b/net/sched/act_skbmod.c
index dc022969346188c17a43f3ef40f3c203272954c4..fce625eafcb2b793cba7bebb740b136bf8498aa1 100644
--- a/net/sched/act_skbmod.c
+++ b/net/sched/act_skbmod.c
@@ -27,19 +27,18 @@ TC_INDIRECT_SCOPE int tcf_skbmod_act(struct sk_buff *skb,
 				     struct tcf_result *res)
 {
 	struct tcf_skbmod *d = to_skbmod(a);
-	int action, max_edit_len, err;
 	struct tcf_skbmod_params *p;
+	int max_edit_len, err;
 	u64 flags;
 
 	tcf_lastuse_update(&d->tcf_tm);
 	bstats_update(this_cpu_ptr(d->common.cpu_bstats), skb);
 
-	action = READ_ONCE(d->tcf_action);
-	if (unlikely(action == TC_ACT_SHOT))
+	p = rcu_dereference_bh(d->skbmod_p);
+	if (unlikely(p->action == TC_ACT_SHOT))
 		goto drop;
 
 	max_edit_len = skb_mac_header_len(skb);
-	p = rcu_dereference_bh(d->skbmod_p);
 	flags = p->flags;
 
 	/* tcf_skbmod_init() guarantees "flags" to be one of the following:
@@ -85,7 +84,7 @@ TC_INDIRECT_SCOPE int tcf_skbmod_act(struct sk_buff *skb,
 		INET_ECN_set_ce(skb);
 
 out:
-	return action;
+	return p->action;
 
 drop:
 	qstats_overlimit_inc(this_cpu_ptr(d->common.cpu_qstats));
@@ -193,9 +192,9 @@ static int tcf_skbmod_init(struct net *net, struct nlattr *nla,
 	}
 
 	p->flags = lflags;
-
+	p->action = parm->action;
 	if (ovr)
-		spin_lock_bh(&d->tcf_lock);
+		spin_lock(&d->tcf_lock);
 	/* Protected by tcf_lock if overwriting existing action. */
 	goto_ch = tcf_action_set_ctrlact(*a, parm->action, goto_ch);
 	p_old = rcu_dereference_protected(d->skbmod_p, 1);
@@ -209,7 +208,7 @@ static int tcf_skbmod_init(struct net *net, struct nlattr *nla,
 
 	rcu_assign_pointer(d->skbmod_p, p);
 	if (ovr)
-		spin_unlock_bh(&d->tcf_lock);
+		spin_unlock(&d->tcf_lock);
 
 	if (p_old)
 		kfree_rcu(p_old, rcu);
@@ -248,10 +247,9 @@ static int tcf_skbmod_dump(struct sk_buff *skb, struct tc_action *a,
 	opt.index   = d->tcf_index;
 	opt.refcnt  = refcount_read(&d->tcf_refcnt) - ref;
 	opt.bindcnt = atomic_read(&d->tcf_bindcnt) - bind;
-	spin_lock_bh(&d->tcf_lock);
-	opt.action = d->tcf_action;
-	p = rcu_dereference_protected(d->skbmod_p,
-				      lockdep_is_held(&d->tcf_lock));
+	rcu_read_lock();
+	p = rcu_dereference(d->skbmod_p);
+	opt.action = p->action;
 	opt.flags  = p->flags;
 	if (nla_put(skb, TCA_SKBMOD_PARMS, sizeof(opt), &opt))
 		goto nla_put_failure;
@@ -269,10 +267,10 @@ static int tcf_skbmod_dump(struct sk_buff *skb, struct tc_action *a,
 	if (nla_put_64bit(skb, TCA_SKBMOD_TM, sizeof(t), &t, TCA_SKBMOD_PAD))
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
2.51.0.261.g7ce5a0a67e-goog



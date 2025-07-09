Return-Path: <netdev+bounces-205340-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C735AFE37A
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 11:03:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF047189382A
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 09:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31C4F283151;
	Wed,  9 Jul 2025 09:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jON4NLzf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BBEA28469F
	for <netdev@vger.kernel.org>; Wed,  9 Jul 2025 09:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752051748; cv=none; b=RvQzMSetfqSeSPrf5uyXTpc5bx+E+1lUH0eqjxftSKI/CJ3Ehyy1P+NS1gLj+tMit2BYNBUGk9JNsfJHDsJOa53IzvXmPiZTpATYVp253jxcCgmGxFhxqf6h76ERdPTUN9mnw9wWjwc3Gq9uCgpRzPRmNlwtUkmen73fVk0xBZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752051748; c=relaxed/simple;
	bh=hsu7U466GN1+zy4Qwvhx4fxvDuIMte/Witb5P1gAEyQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YU331RqeXM3C0YQcMVJhk5i/G3xSL2ejyXWmt1Jxe1Cxz05OPgl29PMHCYMAGoMXbroBGSrmXG9CTyx12TVMFOTdvww2N3kDFB0n6dzVWezgYiTY9bHU6iyz1WjJEJ6z07f8Ec8FM808B29xxR5+FFfQnbGmNC1+dllQrUHnsHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jON4NLzf; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-4a6ef72a544so111380131cf.1
        for <netdev@vger.kernel.org>; Wed, 09 Jul 2025 02:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752051745; x=1752656545; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8WK+EUgqHXjydIumFBu4wkgRGYQLwWKZHC1itmkKhpA=;
        b=jON4NLzfDuWcEP2vEnXOk8Y3+UqvIZgKkn/Xo0lMd1Jjmj+mRa6PT9xl1aM3heLi/X
         HAjo5EyX6WEyxQVXHztCwy011NbAinLv39HqE/p+OBFTD/yqwos7gB6Ad4e1ZB+Q37D2
         YuBj9vWp4uNMHFpoAZWas/cNEpw/TlG3pTYvCFTlk73u+b1QkhmOOSO4DdDKqRS6tFE1
         twr1/iFxSaVi0Q+UVEVCQbsvtd0Ch3UE7ZxvQdJch29+Zx2h9Zhvw/8ujzPlIStb5iwf
         lGVcSr7SX8z/GqwrTDkX+PVTCzEiBQP9OlU4Ww3+aicknexlgkQDg/KVhxbWNE7+7G0s
         F5UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752051745; x=1752656545;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8WK+EUgqHXjydIumFBu4wkgRGYQLwWKZHC1itmkKhpA=;
        b=KAoA4YDfyyyMDjwuca4f3yekgUT8M7VkhAUj2++2Jj1hcAe2U5arNynHMDoTXJtqYT
         T5KAbteI21RT68lkx0iqTPByJfmXXHzi5PW7j4qsYxMKnwMW02k9+UEwn8JDFg4M71P8
         odDne4/Xlrh1slYp+O1I1WH7emt5AXVYEwGgmwkYaqmsdZygHBXXGpzm3RgIdHF+VdQ2
         um21EUSNo9ED9cCuQYCzcHdTk5CTq/8/g+vvOphTcMlHmVKW8yEFpK1yGdRre07bJIAb
         qV5XAvhuB1wUhiVMsxtoJxsapGU2pkhxN5spJ+aLtiYtvptSIN9EMcVA8WLd1h3fCj7f
         FkQg==
X-Forwarded-Encrypted: i=1; AJvYcCU/pw4WV24aPlQAftgunis3Fl0XXSO19J8+aEPwb0pCXxRj+IfaSa1uLNz59goL2GzSoivYM1w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYFE/V0+gv53wsa8gDluB3C9a0RBYadtJEbz9wf+/cZSJfxaMm
	rGsDROpsoBTJMs+kSmHpFI9QPOsuMpePzKgk9HZXNnDsNVH/AD5iC5SukqPooQbG6URydnACKGz
	fre1vgOPwregLXw==
X-Google-Smtp-Source: AGHT+IHST1YJ4nvVqO92lNb+FTQKYDUJdWAHAEoPSW5K0cMJ+bsd1EqenL05O2jEKOlrQbc4yDJYOhynxYtgxw==
X-Received: from qtbhh3.prod.google.com ([2002:a05:622a:6183:b0:4a9:7a92:c1b7])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:5709:0:b0:4a3:fcc7:c72e with SMTP id d75a77b69052e-4a9dec2813cmr17843761cf.9.1752051745395;
 Wed, 09 Jul 2025 02:02:25 -0700 (PDT)
Date: Wed,  9 Jul 2025 09:02:03 +0000
In-Reply-To: <20250709090204.797558-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250709090204.797558-1-edumazet@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250709090204.797558-12-edumazet@google.com>
Subject: [PATCH v2 net-next 11/11] net_sched: act_skbedit: use RCU in tcf_skbedit_dump()
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



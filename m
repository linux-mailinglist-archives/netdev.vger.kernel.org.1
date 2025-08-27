Return-Path: <netdev+bounces-217283-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23179B382E2
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 14:54:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C8221BA1B7B
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 12:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1F09307AFD;
	Wed, 27 Aug 2025 12:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g3kwoHsv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f73.google.com (mail-ua1-f73.google.com [209.85.222.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15CE30CD81
	for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 12:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756299240; cv=none; b=mDLXivHiAenDvPss2jzgWGwLdkaW2gbeBPyS+EDt7IKVl89fQqWTs/WrKA6DDstncKjno6TeJnBRYghYyPzr2BnO2JPmBKLphM9DdpcZf7jk0vazXGjZ7sRidFSf6cjYoKKOPPki3UMCDYW7+BZFEkYReVIn4RqWbZfBpDU6rBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756299240; c=relaxed/simple;
	bh=FqFV21eSvZGLhuYXdH2ncw/Vjfmb+l+Gjvy6yyPMRRU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nOcNV5h/i2UdR5ArIlSEQnve8Eehuzqmm+ck8Z5yvi4yxJM5ACBEr0fPSLT/ZMta5drwI88dScfI5hWRhyzJPKnn7pSMCBJCRhHkOn26/uP5bRkYoyEJiFAAQVbSqVovzsquGu4s1x2BO6MTpiNzIV5KSq+FTzBqDo1np3g9ZKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g3kwoHsv; arc=none smtp.client-ip=209.85.222.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-ua1-f73.google.com with SMTP id a1e0cc1a2514c-89253c490d4so1120092241.0
        for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 05:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756299238; x=1756904038; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=p1mXdwSJgWtaF8V/jI1eYiSOr+Vr35IjVnOPWEHaKWM=;
        b=g3kwoHsvnkyVqzWUPRmWr3kFxEfPYazEWPU7iU/R9J76l0AlcHDaGThzNvcVQ16/P9
         xOLFsPlTAU177mQ/Uj69ohYLFxQJn6gN7s8Hk7/ZUKk/k0AAwoZAUo8JyEWzfTVHf8Cw
         rJCn0xBXWrK8yoKDcbdrCyKaHFK6KOzs87BAX7qtEUaUnZclqLwlrCGQVozUwk5/WEm/
         I7dlzipA5qLoOpcEvPUO0CIfz+P0u0nGrGwOz5FL/xw9EggYBb0TqWfo/qXOK2SwMa4U
         xr92RPVjEQoBef9HqzEbOtcx9tQblttsu1pHP/8QKkCeTo0E0669NuLj/0mPcntIpbPe
         UZ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756299238; x=1756904038;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p1mXdwSJgWtaF8V/jI1eYiSOr+Vr35IjVnOPWEHaKWM=;
        b=ajLuOoH4CAZaQxsLPMxZul5Z2wlAOaxhnfzlR3n75YESUSxQvgHdYSyGaHLDYyZsYP
         IOEL0EgeSae8NV4MDZaakqVPEKyCTM7I+QZUp1/xqH22U8LcL1fAdqdaQaaRQZuJ6vmA
         obcVzcwpLy07ahIl7isPn+eO6yadRCZ1h1CT+QQmrqS6HQB+uizV3e1lm8riPNzAwS9o
         u5i03EbRfUGfYuKENn6ChKqLzqmXrI/B6p78+XVpsMQ7yC5t6NybElMWbCHl2R210BaU
         iRJ1wlfx7jTCt9fVbe4vlCXtILH10xyqIl/Hezc2vOM8VmKVtK5rTDhhnouELQ27/pRt
         29kQ==
X-Forwarded-Encrypted: i=1; AJvYcCWlEphUbi19Vm0atKzSwJISoqxCox8tyde2PhM1N7imaPEfixK6z9KCqR4KcHePMMxEPNfeoZc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVE1KyWnwFyK9ANCMMxwOhRE08upGXE8s5wE/sZnqYsL66dbiR
	OK7IO8BzK+FY8Cvfid1DS+WlqkmmT8Y3/yVK8G9LVaWIQP3/kiTMzkhNXNErohm64XqXmIJ6mAC
	CAKsvIOytRE5SUA==
X-Google-Smtp-Source: AGHT+IHQ7bTyWuCSW0C74/TZeobhN/EreLw0cuvvkWg79kBlKx8o/Yjnhhjf6+myR6BGJ9TOOqKBsx+s3L2Khg==
X-Received: from vshx25.prod.google.com ([2002:a05:6102:919:b0:523:846d:1120])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6102:4a95:b0:519:534a:6c20 with SMTP id ada2fe7eead31-51d0f9073a3mr6194707137.30.1756299237544;
 Wed, 27 Aug 2025 05:53:57 -0700 (PDT)
Date: Wed, 27 Aug 2025 12:53:47 +0000
In-Reply-To: <20250827125349.3505302-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250827125349.3505302-1-edumazet@google.com>
X-Mailer: git-send-email 2.51.0.261.g7ce5a0a67e-goog
Message-ID: <20250827125349.3505302-3-edumazet@google.com>
Subject: [PATCH net-next 2/4] net_sched: act_vlan: use RCU in tcf_vlan_dump()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Also storing tcf_action into struct tcf_vlan_params
makes sure there is no discrepancy in tcf_vlan_act().

No longer block BH in tcf_vlan_init() when acquiring tcf_lock.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/tc_act/tc_vlan.h |  1 +
 net/sched/act_vlan.c         | 20 +++++++++-----------
 2 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/include/net/tc_act/tc_vlan.h b/include/net/tc_act/tc_vlan.h
index 3f5e9242b5e83d082b8a633b3702feadd5672b47..beadee41669a22d7519adaf348fb602cac7d273f 100644
--- a/include/net/tc_act/tc_vlan.h
+++ b/include/net/tc_act/tc_vlan.h
@@ -10,6 +10,7 @@
 #include <linux/tc_act/tc_vlan.h>
 
 struct tcf_vlan_params {
+	int		  action;
 	int               tcfv_action;
 	unsigned char     tcfv_push_dst[ETH_ALEN];
 	unsigned char     tcfv_push_src[ETH_ALEN];
diff --git a/net/sched/act_vlan.c b/net/sched/act_vlan.c
index 383bf18b6862f9a7a96087f1ed786fb869b70415..b46f980f3b2ae0bc50f1a37442945d281b7abddd 100644
--- a/net/sched/act_vlan.c
+++ b/net/sched/act_vlan.c
@@ -25,7 +25,6 @@ TC_INDIRECT_SCOPE int tcf_vlan_act(struct sk_buff *skb,
 {
 	struct tcf_vlan *v = to_vlan(a);
 	struct tcf_vlan_params *p;
-	int action;
 	int err;
 	u16 tci;
 
@@ -38,8 +37,6 @@ TC_INDIRECT_SCOPE int tcf_vlan_act(struct sk_buff *skb,
 	if (skb_at_tc_ingress(skb))
 		skb_push_rcsum(skb, skb->mac_len);
 
-	action = READ_ONCE(v->tcf_action);
-
 	p = rcu_dereference_bh(v->vlan_p);
 
 	switch (p->tcfv_action) {
@@ -97,7 +94,7 @@ TC_INDIRECT_SCOPE int tcf_vlan_act(struct sk_buff *skb,
 		skb_pull_rcsum(skb, skb->mac_len);
 
 	skb_reset_mac_len(skb);
-	return action;
+	return p->action;
 
 drop:
 	tcf_action_inc_drop_qstats(&v->common);
@@ -255,10 +252,11 @@ static int tcf_vlan_init(struct net *net, struct nlattr *nla,
 			   ETH_ALEN);
 	}
 
-	spin_lock_bh(&v->tcf_lock);
+	p->action = parm->action;
+	spin_lock(&v->tcf_lock);
 	goto_ch = tcf_action_set_ctrlact(*a, parm->action, goto_ch);
 	p = rcu_replace_pointer(v->vlan_p, p, lockdep_is_held(&v->tcf_lock));
-	spin_unlock_bh(&v->tcf_lock);
+	spin_unlock(&v->tcf_lock);
 
 	if (goto_ch)
 		tcf_chain_put_by_act(goto_ch);
@@ -297,9 +295,9 @@ static int tcf_vlan_dump(struct sk_buff *skb, struct tc_action *a,
 	};
 	struct tcf_t t;
 
-	spin_lock_bh(&v->tcf_lock);
-	opt.action = v->tcf_action;
-	p = rcu_dereference_protected(v->vlan_p, lockdep_is_held(&v->tcf_lock));
+	rcu_read_lock();
+	p = rcu_dereference(v->vlan_p);
+	opt.action = p->action;
 	opt.v_action = p->tcfv_action;
 	if (nla_put(skb, TCA_VLAN_PARMS, sizeof(opt), &opt))
 		goto nla_put_failure;
@@ -325,12 +323,12 @@ static int tcf_vlan_dump(struct sk_buff *skb, struct tc_action *a,
 	tcf_tm_dump(&t, &v->tcf_tm);
 	if (nla_put_64bit(skb, TCA_VLAN_TM, sizeof(t), &t, TCA_VLAN_PAD))
 		goto nla_put_failure;
-	spin_unlock_bh(&v->tcf_lock);
+	rcu_read_unlock();
 
 	return skb->len;
 
 nla_put_failure:
-	spin_unlock_bh(&v->tcf_lock);
+	rcu_read_unlock();
 	nlmsg_trim(skb, b);
 	return -1;
 }
-- 
2.51.0.261.g7ce5a0a67e-goog



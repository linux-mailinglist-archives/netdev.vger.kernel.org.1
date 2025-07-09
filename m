Return-Path: <netdev+bounces-205336-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AFB8AFE377
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 11:03:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 337603B44FC
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 09:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6094B28468F;
	Wed,  9 Jul 2025 09:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HaJL5NCZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB7D2820BA
	for <netdev@vger.kernel.org>; Wed,  9 Jul 2025 09:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752051742; cv=none; b=j5bqgxLCJwtipjAeYuLBX0R0O756ZzwikUcgNLcxkVyDHOcm305nzQxzjnfsV58DDdVQUlEmsd3HioH80qO2GCYwZSoJwvd0+LVWzsWqFWbmojudE91E6l0T3bOtVVlVaiw/zq5xLKklwZE/eQ1jIkmXvEjotnUcu5VSRYwNBgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752051742; c=relaxed/simple;
	bh=x5NSI371g6NSuXIj3A2EJmsylyruQ0zmVflSE180Vr8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RsWaeHn9LihwG0qN6JnemhXpFALlkgMF9dOm7GyPnEC/arM3ex+ruR3o38mttKfEsoQGBhguaLPZTPi42pV3I72uJR1DLIk4ahPVrVbI5g4Wexl1f+imRmh0qwuxfejNy4DAKYYEbZaWEE0nV0NkXQ7thzXba48i3mfErzLiFVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HaJL5NCZ; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-4a587a96f0aso161484171cf.3
        for <netdev@vger.kernel.org>; Wed, 09 Jul 2025 02:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752051739; x=1752656539; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Dz7jb1QO4e65JJC9JvpcrbyWkPjv7YRjvPCsGz71cDo=;
        b=HaJL5NCZFJ2A0SQ15OxTS4X2yY56eZjYPr208gKuby58pwjYhaRGZyqi2ZQ6waiIsX
         f0Veye2aJ4PVtl+apQ/EYWxOZIsYWGFD/pOtG/+1jcdWpJhc/vcfruZuIDI3bhVU9+1m
         M5eIl3cKeeVhHsm5Aj4RYQ0xQJ2bBXMWaISNSatEHpWLX0/uMHyqHcpCcJUWkErILk+M
         u0pehmtUhMKriB5Q8bzlv/MRKSn0n80kc04wJ5M1nUP3JAftrIPI6PvrUU9g7r/J89ry
         BthcmX/vuWRvzeGjDSByGGdSMijsvN3ksGP8Sx3v6ipj1gpD4uTGnFrSYaJlofTVSOrM
         BJCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752051740; x=1752656540;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dz7jb1QO4e65JJC9JvpcrbyWkPjv7YRjvPCsGz71cDo=;
        b=WaFRW2tAClEHWixp2qRvqmcewQTjtMFrA/rAfzsmuhIX0Ot2HvKVxIK9U0FJa3qCPF
         rzfvpt/mqTiYLqUxha7xlsCb/3E5lv8KZiAS0+J8qG82pxi2VCD4Avbcw9OH/JGmdgTp
         xPd0SMECx4VT1auRlqllZzpNrAiEMlMCKEgrRfOeIshDh+8WNw5Ygw/wbGHJzqJ8KHPZ
         Q3b9mQX0eM/pFgIOq78ZmZGOGXRmWATkNPrWAAJcTXIpD/UKGCz/RF8FqBcjLMJANKBo
         N4A2+o+EA+HBVvq9yL5rmwAbyvtnGGAyl+u46zzO8NZs3F0h8DOYvj9vLK4Y6P9+UkP2
         cJZw==
X-Forwarded-Encrypted: i=1; AJvYcCVmZt1pioyzW7E1xULapZpM44fBZYcHbI3MR4YJF9bcvtBZ+tlinTyZoDw4d9qRIEZ22z7y98Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqSTivA5FbCkfkODpHjvvrmxe835K0ZBYYDhwoLrBWqXw+YwR1
	CXDtHkNtKgMxXogIv58TNGnTtauzkvlElbFlgn2riTFtnwwB2YHEg9le/26wWj2g87RnGWWtB55
	XP1UmGMyXe4c73w==
X-Google-Smtp-Source: AGHT+IEeHXjrqFMnYD7DSwLryEgoosIXfO16moUbWF+HM9HCfOvLXS9YKk9hqTnABb5zuO/OiKUmVn2mQHj+NA==
X-Received: from qtbbr22.prod.google.com ([2002:a05:622a:1e16:b0:4a9:ae5f:14c1])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:148e:b0:4a4:3c3e:5754 with SMTP id d75a77b69052e-4a9decfb243mr25209161cf.32.1752051739608;
 Wed, 09 Jul 2025 02:02:19 -0700 (PDT)
Date: Wed,  9 Jul 2025 09:02:00 +0000
In-Reply-To: <20250709090204.797558-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250709090204.797558-1-edumazet@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250709090204.797558-9-edumazet@google.com>
Subject: [PATCH v2 net-next 08/11] net_sched: act_nat: use RCU in tcf_nat_dump()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Also storing tcf_action into struct tcf_nat_params
makes sure there is no discrepancy in tcf_nat_act().

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/tc_act/tc_nat.h |  1 +
 net/sched/act_nat.c         | 25 ++++++++++++-------------
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/include/net/tc_act/tc_nat.h b/include/net/tc_act/tc_nat.h
index c869274ac529b2667a5d9ebcc4a35dbd34da71bb..ae35f4009445560401b78584d165fbcc635c4ae5 100644
--- a/include/net/tc_act/tc_nat.h
+++ b/include/net/tc_act/tc_nat.h
@@ -6,6 +6,7 @@
 #include <net/act_api.h>
 
 struct tcf_nat_parms {
+	int action;
 	__be32 old_addr;
 	__be32 new_addr;
 	__be32 mask;
diff --git a/net/sched/act_nat.c b/net/sched/act_nat.c
index d541f553805face5a0d444659c17e0b720aeb843..26241d80ebe03e74a92e951fb5ae065493b93277 100644
--- a/net/sched/act_nat.c
+++ b/net/sched/act_nat.c
@@ -91,6 +91,7 @@ static int tcf_nat_init(struct net *net, struct nlattr *nla, struct nlattr *est,
 	nparm->new_addr = parm->new_addr;
 	nparm->mask = parm->mask;
 	nparm->flags = parm->flags;
+	nparm->action = parm->action;
 
 	p = to_tcf_nat(*a);
 
@@ -130,17 +131,16 @@ TC_INDIRECT_SCOPE int tcf_nat_act(struct sk_buff *skb,
 	tcf_lastuse_update(&p->tcf_tm);
 	tcf_action_update_bstats(&p->common, skb);
 
-	action = READ_ONCE(p->tcf_action);
-
 	parms = rcu_dereference_bh(p->parms);
+	action = parms->action;
+	if (unlikely(action == TC_ACT_SHOT))
+		goto drop;
+
 	old_addr = parms->old_addr;
 	new_addr = parms->new_addr;
 	mask = parms->mask;
 	egress = parms->flags & TCA_NAT_FLAG_EGRESS;
 
-	if (unlikely(action == TC_ACT_SHOT))
-		goto drop;
-
 	noff = skb_network_offset(skb);
 	if (!pskb_may_pull(skb, sizeof(*iph) + noff))
 		goto drop;
@@ -268,21 +268,20 @@ static int tcf_nat_dump(struct sk_buff *skb, struct tc_action *a,
 			int bind, int ref)
 {
 	unsigned char *b = skb_tail_pointer(skb);
-	struct tcf_nat *p = to_tcf_nat(a);
+	const struct tcf_nat *p = to_tcf_nat(a);
+	const struct tcf_nat_parms *parms;
 	struct tc_nat opt = {
 		.index    = p->tcf_index,
 		.refcnt   = refcount_read(&p->tcf_refcnt) - ref,
 		.bindcnt  = atomic_read(&p->tcf_bindcnt) - bind,
 	};
-	struct tcf_nat_parms *parms;
 	struct tcf_t t;
 
-	spin_lock_bh(&p->tcf_lock);
-
-	opt.action = p->tcf_action;
+	rcu_read_lock();
 
-	parms = rcu_dereference_protected(p->parms, lockdep_is_held(&p->tcf_lock));
+	parms = rcu_dereference(p->parms);
 
+	opt.action = parms->action;
 	opt.old_addr = parms->old_addr;
 	opt.new_addr = parms->new_addr;
 	opt.mask = parms->mask;
@@ -294,12 +293,12 @@ static int tcf_nat_dump(struct sk_buff *skb, struct tc_action *a,
 	tcf_tm_dump(&t, &p->tcf_tm);
 	if (nla_put_64bit(skb, TCA_NAT_TM, sizeof(t), &t, TCA_NAT_PAD))
 		goto nla_put_failure;
-	spin_unlock_bh(&p->tcf_lock);
+	rcu_read_unlock();
 
 	return skb->len;
 
 nla_put_failure:
-	spin_unlock_bh(&p->tcf_lock);
+	rcu_read_unlock();
 	nlmsg_trim(skb, b);
 	return -1;
 }
-- 
2.50.0.727.gbf7dc18ff4-goog



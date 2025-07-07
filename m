Return-Path: <netdev+bounces-204578-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BBCBAFB3D2
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 15:02:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88C594A3BED
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 13:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B7F329B792;
	Mon,  7 Jul 2025 13:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bOp8SC1p"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7355429ACD4
	for <netdev@vger.kernel.org>; Mon,  7 Jul 2025 13:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751893294; cv=none; b=lpeZT49h1PlYL6Q1svfkqTyriokuqj305c2EGGrdJHE9rkVVPWJDznnNWMlbpQfZF4Z7ACdcmgnmNcVVpC+owrPIXsw36htPskZXRZr5dW6HwsrzY7bgw0HE8J24aA78/9K4LAhEFk6azQs56Kwyak/scMacm2po0TFru6QBPw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751893294; c=relaxed/simple;
	bh=0GTWCVXw8PLHsBfc7wPwyR+Zi2sMk2qt3u/cQXD+Y0Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hgtxqP/CnMFWUdMU25dvn6OcSc3KTCArYxJWRUnrFVc8KzM6q3UIWHb1w/LwAfWyftiEx+4S4C3pYHl8DsR5moqiTETPx6KYxHTtOgju29rKgt8Qva3v09ioY2OkDqszZQf982zKRWSz+6XY8yunqTW5xDUTG4q7+Q0aSAzty0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bOp8SC1p; arc=none smtp.client-ip=209.85.219.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-6fab979413fso60876136d6.2
        for <netdev@vger.kernel.org>; Mon, 07 Jul 2025 06:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751893291; x=1752498091; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UB0Qx2+wxwqPhRHaMY4oD8vvlTVNZ4D0x0o57nz4IJw=;
        b=bOp8SC1p3GqEILQIZBdRArpCRS0rIdEl0Qs0PVRQVP3atepT3Dikel+EsMj0Wbyw8O
         HO1TJjRoDpW2F7dmg8dJz3K+Yt9NPnrFG/VMgmRURQmkd84d2TvFodwMlGD4grsS/4HX
         P8KkpqGR/u2Iix0vwBdSP8exuSQVYzuDFh5HSKb5PCZI5sway0lYezV36ocGhJgEhDH2
         DyFv3D7v9gDnqn+n3YqZYjdWFxWO6bVPaQLdKsuRy6b9sES+HFOjCQp9cgUUrqojPZcO
         utMYt/aex25Xu3+VFYS7G2eHGRNlj0doPsySXp/vwkh49cj/KKtnOiJWKgXtz8U/W4zJ
         MbeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751893291; x=1752498091;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UB0Qx2+wxwqPhRHaMY4oD8vvlTVNZ4D0x0o57nz4IJw=;
        b=ueIWuEXShEhSXiP0+orb/x1tDg7IxFgtfLWXcMsOmNfvYS4SHVNuTFhzq9umjnZZ6s
         l1Rk4rqncC9xgWzIfoUtLJQ+nbmqDg7EqcG2XT9orf/FGDUee6pzgaJxM8ShwHUC1Rif
         UdLG0S7vYMIu69LK7q92164hTKPNUpAatCQYg8NVzIGI/vFCBiMfMpSm/tLIaZuffIKo
         fxEhAiEDZzEdz5o83z3YD5xVCCU95BjOxeQazuKE5QiDGTVUh+aq5bRw+/onxp72O1xg
         GQDWN7/+2utdCwmuPZ1hFZYWbmI3wMWAaXGw1PFgUO3sx7V9ZctlSEXS89T/EI3ef58I
         JZ/g==
X-Forwarded-Encrypted: i=1; AJvYcCVc/i4/G9uUHTL8I8tXD9nr1CBABo9o6xuwrxXp/6Gx5zqG5Sp+gjseCMJ2hZwJj+zU4AyvXoY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo/DbaeR3IeVm9fEgWhUUHTPQCFqhsGXdO2HKBhoa4uUuWi16e
	lUBpmzeg5PxwBCO5zqwy44cD/hMFChpaOSF4O3cCBY49pzuBIbdxwkBpvPFHOYlasZ92jVlhvvi
	G6EVioDlGhdx+IQ==
X-Google-Smtp-Source: AGHT+IHQ0dUgzL0aPBp13NewoplBH7ykJ+JY+VHTBvRtOfRCCyByjMrxG+Br+ya1Vcl0mN+cjpj6gOU+TTQ3Ew==
X-Received: from qvblh3.prod.google.com ([2002:a05:6214:54c3:b0:6fa:aa06:c3ea])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:2e89:b0:702:d3c8:5e1e with SMTP id 6a1803df08f44-702d3c8606fmr106330686d6.0.1751893287216;
 Mon, 07 Jul 2025 06:01:27 -0700 (PDT)
Date: Mon,  7 Jul 2025 13:01:07 +0000
In-Reply-To: <20250707130110.619822-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250707130110.619822-1-edumazet@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250707130110.619822-9-edumazet@google.com>
Subject: [PATCH net-next 08/11] net_sched: act_nat: use RCU in tcf_nat_dump()
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
index d541f553805face5a0d444659c17e0b720aeb843..834d4c7f35a2ec56b4e47831bdfa298d562c5b01 100644
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
+	rcu_read_lock();
 
 	return skb->len;
 
 nla_put_failure:
-	spin_unlock_bh(&p->tcf_lock);
+	rcu_read_unlock();
 	nlmsg_trim(skb, b);
 	return -1;
 }
-- 
2.50.0.727.gbf7dc18ff4-goog



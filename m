Return-Path: <netdev+bounces-204581-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E9A5AFB3D5
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 15:02:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9371A7A4C59
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 13:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C08829E11F;
	Mon,  7 Jul 2025 13:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kgtYkFNv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f73.google.com (mail-io1-f73.google.com [209.85.166.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAFE629E101
	for <netdev@vger.kernel.org>; Mon,  7 Jul 2025 13:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751893300; cv=none; b=krJvq73msfSOH71e463bdL0LgfIk+ookR7ciAqPGidJZbPRipXhl/KGEjNlKJ2+MC/ZZjfK/NhhEifSUZTd2DLuNrukQXM3GWuh/vEjp5atWT9JWXWzi51XzT0stQPxHyVup8A976EnIjwW0FzPjBrJOMj8xnFTKc+P2pg3XwR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751893300; c=relaxed/simple;
	bh=/T0HwzI9j8g/SI9eut487Fk66S2bL19IBr5B2TYqgrI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CAqUdtt3o7G245d3ZN2LfkomLeXo+QXS/RFUi6ZPNNktq3Faa0tcaI0tUN8e4971oqsXw2hKxobepe3ZtDBQDsQqKZVjoudk8bZUlvzD88FYumY4Q2rOC8PasH6DIsMrox9BR3DnXCLyHUeM29K1KAfKxtBhqx4d4S0HeiZiaQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kgtYkFNv; arc=none smtp.client-ip=209.85.166.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-io1-f73.google.com with SMTP id ca18e2360f4ac-87632a0275dso244106139f.1
        for <netdev@vger.kernel.org>; Mon, 07 Jul 2025 06:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751893298; x=1752498098; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HyAy4rJwM+bYLxcCHmtu4h/+tGct2PyAHPVu6Zt5GA4=;
        b=kgtYkFNvTUlUvDomi9u3ptf9QsZbaRuL03Q2Di72SYXRUEmX8pBtuimZ5kBFawK6cN
         /hCioXCd6CGLKwH5R5jSaOceD9hbccm1VOJ25SqFpdPgF2kKvniQNmcFZrwOXZTNppO4
         qAWs/2AMrejic/ukv+uSpHax311wxJVXzWnztFOMTXlsQXfb/XF8oSxXUC91Bls1n6iu
         sygZntApjF36YYUwP8fbW/xkIeKO6qYs8pH2Q5/AI9DgAvnB3kJx/VSwNQBBK72t0GF2
         CA6dDqUUd8b9K+qz+USLu+6KmJRJUcxC6XdqnkdcFKG81G9rqGKexGPI3knlgK/PC2D2
         16Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751893298; x=1752498098;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HyAy4rJwM+bYLxcCHmtu4h/+tGct2PyAHPVu6Zt5GA4=;
        b=Ef4bxR2z7warpFzb+hPr+1tPfrHsaxKvnpR8GewyfAZf9V01klSBlecNqsdXke7G+Z
         6vEpU1VZkC0ZaFAVka5rcSPCNUP73DqD4GEhKSN4oWFlKowuT3KF9XZ65Na50p768avA
         +XZjqq/M22kUwcnhvio/xLKyEmOOSTfdVP7h7aEzijWDgxIv+IrsGzp2FLFT8XY1lr/7
         U/j1d3J+o1oSSOBbLHA6dCzr7K7JkQX/PGSNVm7m5fQz2GQ4srYfIDF7vFRtZS50x3dQ
         KfeBJ66i2vVuwiKhJeo5z52/sgC0VgUBybfPxpxfRLdgLSW5Al2uv9zyZCr8aoM4bI4j
         gcyA==
X-Forwarded-Encrypted: i=1; AJvYcCW4tDh0P2vxvses6ZneETXMwLD93hfnRCpaxuVgUcmuQnbv+4ypaW35TX5aqDh3SAPgAJkMGHE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/q2yCHQzlIr52rlan+5ghe1mcgp6lW0ie2QkNzasj9F1WfhXV
	CFXV1GCgZFDRX/DjzmNk+3aTMXcKHrXhBIMMLQ28d7wK4WZbKfXzD8Ddf1OTbcEajNJ1IHWp7hi
	RwV46elpvzEQJIA==
X-Google-Smtp-Source: AGHT+IG1zI2Ca3j9z6f3FjWlEwPFCU5UKupxu3X3ecXTM2gb/wTPe2eSos2TVH1Tq+JIbHJq7du3pG8U69Z5RQ==
X-Received: from qvc25.prod.google.com ([2002:a05:6214:8119:b0:6fd:3847:68])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:2e4a:b0:6ff:b41b:b5bb with SMTP id 6a1803df08f44-702d167577emr145232396d6.26.1751893284075;
 Mon, 07 Jul 2025 06:01:24 -0700 (PDT)
Date: Mon,  7 Jul 2025 13:01:05 +0000
In-Reply-To: <20250707130110.619822-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250707130110.619822-1-edumazet@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250707130110.619822-7-edumazet@google.com>
Subject: [PATCH net-next 06/11] net_sched: act_ctinfo: use RCU in tcf_ctinfo_dump()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Also storing tcf_action into struct tcf_ctinfo_params
makes sure there is no discrepancy in tcf_ctinfo_act().

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/tc_act/tc_ctinfo.h |  1 +
 net/sched/act_ctinfo.c         | 23 +++++++++++------------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/include/net/tc_act/tc_ctinfo.h b/include/net/tc_act/tc_ctinfo.h
index a04bcac7adf4b61b73181d5dbd2ff9eee3cf5e97..7fe01ab236da4eaa0624db08d0a9599e36820bee 100644
--- a/include/net/tc_act/tc_ctinfo.h
+++ b/include/net/tc_act/tc_ctinfo.h
@@ -7,6 +7,7 @@
 struct tcf_ctinfo_params {
 	struct rcu_head rcu;
 	struct net *net;
+	int action;
 	u32 dscpmask;
 	u32 dscpstatemask;
 	u32 cpmarkmask;
diff --git a/net/sched/act_ctinfo.c b/net/sched/act_ctinfo.c
index 93ab3bcd6d3106a1561f043e078d0be5997ea277..71efe04d00b5c6195e43f1ea6dab1548f6f97293 100644
--- a/net/sched/act_ctinfo.c
+++ b/net/sched/act_ctinfo.c
@@ -88,13 +88,11 @@ TC_INDIRECT_SCOPE int tcf_ctinfo_act(struct sk_buff *skb,
 	struct tcf_ctinfo_params *cp;
 	struct nf_conn *ct;
 	int proto, wlen;
-	int action;
 
 	cp = rcu_dereference_bh(ca->params);
 
 	tcf_lastuse_update(&ca->tcf_tm);
 	tcf_action_update_bstats(&ca->common, skb);
-	action = READ_ONCE(ca->tcf_action);
 
 	wlen = skb_network_offset(skb);
 	switch (skb_protocol(skb, true)) {
@@ -141,7 +139,7 @@ TC_INDIRECT_SCOPE int tcf_ctinfo_act(struct sk_buff *skb,
 	if (thash)
 		nf_ct_put(ct);
 out:
-	return action;
+	return cp->action;
 }
 
 static const struct nla_policy ctinfo_policy[TCA_CTINFO_MAX + 1] = {
@@ -258,6 +256,8 @@ static int tcf_ctinfo_init(struct net *net, struct nlattr *nla,
 		cp_new->mode |= CTINFO_MODE_CPMARK;
 	}
 
+	cp_new->action = actparm->action;
+
 	spin_lock_bh(&ci->tcf_lock);
 	goto_ch = tcf_action_set_ctrlact(*a, actparm->action, goto_ch);
 	cp_new = rcu_replace_pointer(ci->params, cp_new,
@@ -282,25 +282,24 @@ static int tcf_ctinfo_init(struct net *net, struct nlattr *nla,
 static int tcf_ctinfo_dump(struct sk_buff *skb, struct tc_action *a,
 			   int bind, int ref)
 {
-	struct tcf_ctinfo *ci = to_ctinfo(a);
+	const struct tcf_ctinfo *ci = to_ctinfo(a);
+	unsigned char *b = skb_tail_pointer(skb);
+	const struct tcf_ctinfo_params *cp;
 	struct tc_ctinfo opt = {
 		.index   = ci->tcf_index,
 		.refcnt  = refcount_read(&ci->tcf_refcnt) - ref,
 		.bindcnt = atomic_read(&ci->tcf_bindcnt) - bind,
 	};
-	unsigned char *b = skb_tail_pointer(skb);
-	struct tcf_ctinfo_params *cp;
 	struct tcf_t t;
 
-	spin_lock_bh(&ci->tcf_lock);
-	cp = rcu_dereference_protected(ci->params,
-				       lockdep_is_held(&ci->tcf_lock));
+	rcu_read_lock();
+	cp = rcu_dereference(ci->params);
 
 	tcf_tm_dump(&t, &ci->tcf_tm);
 	if (nla_put_64bit(skb, TCA_CTINFO_TM, sizeof(t), &t, TCA_CTINFO_PAD))
 		goto nla_put_failure;
 
-	opt.action = ci->tcf_action;
+	opt.action = cp->action;
 	if (nla_put(skb, TCA_CTINFO_ACT, sizeof(opt), &opt))
 		goto nla_put_failure;
 
@@ -337,11 +336,11 @@ static int tcf_ctinfo_dump(struct sk_buff *skb, struct tc_action *a,
 			      TCA_CTINFO_PAD))
 		goto nla_put_failure;
 
-	spin_unlock_bh(&ci->tcf_lock);
+	rcu_read_unlock();
 	return skb->len;
 
 nla_put_failure:
-	spin_unlock_bh(&ci->tcf_lock);
+	rcu_read_unlock();
 	nlmsg_trim(skb, b);
 	return -1;
 }
-- 
2.50.0.727.gbf7dc18ff4-goog



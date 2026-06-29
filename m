Return-Path: <netdev+bounces-302770-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id T1jHIAu2Qmo1AAoAu9opvQ
	(envelope-from <netdev+bounces-302770-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 20:14:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C93A46DDF2E
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 20:14:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=mwASHess;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302770-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302770-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 31D9F3055D59
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 18:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73FD1381B06;
	Mon, 29 Jun 2026 18:12:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CCC6381B01
	for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 18:12:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782756757; cv=none; b=acsgKtpyv1dg2auDeT6BOqlI3vAcczj5lzRzUmYOz9JCSiLN7nObB/1SyEzWgOWHI8WxlOn8SAuN/JXASaK/MGAd6PgW5lkGVGNapGMJsf24HQhMvdeX+nb/OxmO9K+mq7lJLqp0kjCcMHCmF70PSLBl2Qtk6zMqACtlD64AmVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782756757; c=relaxed/simple;
	bh=GDAJRTe2YCSz9oo6aE0hNNr30xV/i9vlguXY6/zhdKQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jNvCpE8R37i5mUzCDNP0bRWhJIyJpZvhxwYtWgVU0StbO76qSPX2X3l26QOt22suPVxG1DhA+jNTjt30Ylz6WTYA4EKYxCylxwp8C+AZLTGFq8jCxe6rLoMv3IfZzdKipUjGsJ2Hd7EKhhoJ+v6pIF5JUvy/V3GFkvrZ8155e4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mwASHess; arc=none smtp.client-ip=209.85.210.202
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-8422ca754d8so1987154b3a.1
        for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 11:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782756755; x=1783361555; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1cGYTi0+ETqdgDQxsbIRmyjTFpW6WNyrxv+a3ICio3g=;
        b=mwASHessPb+OSXSb2CRLsQmhfAeGoIhs4LGAGJWbVruTLhNKDxNPyt7v/Fg6OOJL/R
         nDdUUPkiu1tKjcwssu0ftRt/rIrvUM2AmXyEMsFucLNtI8ujaEMcJzlf/eJTQ66QRA5L
         kGG7KeGjqsuskDxuCiI7TJsST8Wa39HowAzcVo2Dt4FXUJPVoI3zZFzHu1HMXrtvlZEE
         jZQqa/Ko+A8iah06IqyKJhMcYist53Ptd4J+GwDXBjgPl4lUJBAI7k9P/P3pi6HId180
         3173H96rEUH5WMAdK1A6bf+NrjBiTp216hQ51xmddQ/lj2s86WrSMyBgsHGttLYqjrlF
         0hPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782756755; x=1783361555;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1cGYTi0+ETqdgDQxsbIRmyjTFpW6WNyrxv+a3ICio3g=;
        b=RMgPOv0wMjAoM1Rj3d2LhwPOWq2ogMeM7CoWNzODHvOsFxAH2xUEImoNWmgD9sv+0z
         HLM6wCuWZwu2xvnQAa/pBOlRaXCzVA1g/aYYNolqskiaXiNOr1w0Edff0Iwm1xcjafcg
         PK+8Ga7qXfrkd4xhBgGvGR9K1WxS45q61pJgDp19GWN5vw717PZEin0cCIWzvFmNo8Hc
         Ki2jnPG901OYjzu0FY8p/jEAQmezRvRu24rYw7qh7JYx/BzEu8V/vfZvOG6pL5JNuUlF
         ahhzmvvTQobMUcoiQRSdeKyAuBorxyBmyTY9quDqM3FPAiwSqxecyKgQymoVrP0V81hX
         2eYw==
X-Forwarded-Encrypted: i=1; AFNElJ+wAXGgLawhzUWT3b6I/9zpeARk51yIfqdkCQOZ4T3qOY/KRqQiH9fCJWFj5zfYiPjwDe3HIUc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEoOKS06wnKsKQNwTfbipHwxLRrrEA5mHXv3L3UXay3g3Qp4ST
	Z/oxsCOVdSTKBgCxsfFXTih0/7PhEv7wFwRD5G3Ia6l1TI4gRNDGvZWjF7FxmxNxw467R3LQlKR
	/RQJZYQ==
X-Received: from pfblo12.prod.google.com ([2002:a05:6a00:3d0c:b0:842:8522:9ada])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1c9d:b0:845:e7e9:b57a
 with SMTP id d2e1a72fcca58-8479f2da72amr367821b3a.61.1782756755310; Mon, 29
 Jun 2026 11:12:35 -0700 (PDT)
Date: Mon, 29 Jun 2026 18:10:59 +0000
In-Reply-To: <20260629181226.1929658-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260629181226.1929658-1-kuniyu@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260629181226.1929658-8-kuniyu@google.com>
Subject: [PATCH v1 net-next 07/10] net: fib_rules: Drop RTNL assertions.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-302770-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:dsahern@kernel.org,m:idosch@nvidia.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:kuniyu@google.com,m:kuni1840@gmail.com,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C93A46DDF2E

Now, fib_rule structs are protected by per-fib_rules_ops mutex.

Let's drop ASSERT_RTNL_NET() and rtnl_dereference().

Note that fib_rules_event() iterates over net->rules_ops without
net->rules_mod_lock, but this is fine because all fib_rule users
are built-in and concurrent fib_rules_unregister() does not happen.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/core/fib_rules.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/net/core/fib_rules.c b/net/core/fib_rules.c
index 25a3fd997782..5eef5d6ace82 100644
--- a/net/core/fib_rules.c
+++ b/net/core/fib_rules.c
@@ -387,7 +387,6 @@ static int call_fib_rule_notifiers(struct net *net,
 		.rule = rule,
 	};
 
-	ASSERT_RTNL_NET(net);
 	lockdep_assert_held(&ops->lock);
 
 	/* Paired with READ_ONCE() in fib_rules_seq() */
@@ -955,7 +954,7 @@ int fib_newrule(struct net *net, struct sk_buff *skb, struct nlmsghdr *nlh,
 		list_for_each_entry(r, &ops->rules_list, list) {
 			if (r->action == FR_ACT_GOTO &&
 			    r->target == rule->pref &&
-			    rtnl_dereference(r->ctarget) == NULL) {
+			    !rcu_access_pointer(r->ctarget)) {
 				rcu_assign_pointer(r->ctarget, rule);
 				if (--ops->unresolved_rules == 0)
 					break;
@@ -1064,7 +1063,7 @@ int fib_delrule(struct net *net, struct sk_buff *skb, struct nlmsghdr *nlh,
 
 	if (rule->action == FR_ACT_GOTO) {
 		ops->nr_goto_rules--;
-		if (rtnl_dereference(rule->ctarget) == NULL)
+		if (!rcu_access_pointer(rule->ctarget))
 			ops->unresolved_rules--;
 	}
 
@@ -1082,7 +1081,7 @@ int fib_delrule(struct net *net, struct sk_buff *skb, struct nlmsghdr *nlh,
 		if (&n->list == &ops->rules_list || n->pref != rule->pref)
 			n = NULL;
 		list_for_each_entry(r, &ops->rules_list, list) {
-			if (rtnl_dereference(r->ctarget) != rule)
+			if (rcu_access_pointer(r->ctarget) != rule)
 				continue;
 			rcu_assign_pointer(r->ctarget, n);
 			if (!n)
@@ -1400,8 +1399,6 @@ static int fib_rules_event(struct notifier_block *this, unsigned long event,
 	struct net *net = dev_net(dev);
 	struct fib_rules_ops *ops;
 
-	ASSERT_RTNL();
-
 	switch (event) {
 	case NETDEV_REGISTER:
 		list_for_each_entry(ops, &net->rules_ops, list) {
-- 
2.55.0.rc0.799.gd6f94ed593-goog



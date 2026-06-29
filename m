Return-Path: <netdev+bounces-302768-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BF/RB+q1QmozAAoAu9opvQ
	(envelope-from <netdev+bounces-302768-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 20:14:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7740C6DDF25
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 20:14:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=wbfG66LN;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302768-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302768-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8976330479C1
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 18:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD614380FFE;
	Mon, 29 Jun 2026 18:12:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9C737C0E7
	for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 18:12:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782756755; cv=none; b=tutTstnfZRqDV9nkMD/rbhRmbtWGeAVMXFcucNJLSObZMD8pW0PG1GKzvqg22ikfS+EdSWYg4Uu/LG43/hdoH6aUA8FyxiCZrdWisqDq6xiBCDKQzJad5cTnlyVbkwe0HvB1Ohb14p9NEyhiqE0798+AUFQyFLL+QPDzO7iygVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782756755; c=relaxed/simple;
	bh=Y3XSBR9ty13tjR7eA9bGsDzxlHHrTKCv8ssch553Esc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nA1JpZ8Qa7d4LUbW++AhWg604O4utOHuRo4yG4Rt+wDGBmTM/F6UhvxefQcSqXSGsAcR1M7dgDrONzvIMFa4TqgyzTtwKltZBZdfyBsNRIsptHOQi5ipUjx5QQJblK15ajPuUG2kUYiejLQ2r9FsQ1rcPRzHqYrxL/4oSiwLnV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wbfG66LN; arc=none smtp.client-ip=209.85.214.201
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2c804e38c65so39296955ad.2
        for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 11:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782756754; x=1783361554; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SO3BTf/18qQBrY40uuLAVTCmct5NvytYO5ofDh/MuJ0=;
        b=wbfG66LNosaG+e60skIcdQ/r3aRz0QoPKC/3ujXkAVAtjiM7OM+mhtW1W6gVC3+FYM
         aeiBrbWuy1hA257DyRvaWU9cHk0O6u/yTL41LaOUUky5YLgcxFqyFSove6B7m53Vi0jl
         dUZRUQtz9bCbD7d0XcFItxs+doB6M8vAY0aM1cfua+mj2T/I5+tolmwOkHN42PmStv7k
         GVmMniHTiYrRURm+vmWDrGMY3PqqWz72k25I1HJkEnOUwS+IeoSo1k3gHXCQPMpa0j0H
         Z0gvcMaXXZn0C8PjsoW6TLzQ2wV2wWqnYEGLA8HyZ7pN1911ISJhyeDlJ88ej3zZbBp+
         D7gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782756754; x=1783361554;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SO3BTf/18qQBrY40uuLAVTCmct5NvytYO5ofDh/MuJ0=;
        b=edhTMfn5XYqnJNzXXmy8PvrkkcR69bQTYsYYYS+PwhAx22yxT2o2veAY8bc0IbtNLp
         ub0AIu5NST/AAhou94SoA9HWCQrHZgch2iwToLtg53+6BDn+e/9W+ts8HCShk/3kUugF
         lSVnKvzqGM9CkIphVqiWxmyUAP92v+Hm7LNLWaZ126FMQdy4+/TKlDNYwyxhEdOeeNYf
         6qva+E60vdTlho1qVgD7PfgsVWWhKFk+Wa8s2EbMYK/LJ2rirMwXBt+jfL93bWW1AJML
         Rn1kIWJQRq9by1ETf6SAmsYEny8vIqd/EfLUTsvh81/FD9PIT67+VavFuHsedV50zZk5
         izhg==
X-Forwarded-Encrypted: i=1; AHgh+RoNgFhOm6+D2hZzhsQZqZCwi3SI/7O5x8h6ztngWQ5AK2M9c2+K2yIyK9iznE1jEKJ2842GKgs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6bdqkD+DmzTb0wC+udGmS02k/JgqUBeFh23aoB0spJAn3ZF9W
	QVfwhZYn5NM8rToo7NHuBzF1UpvwtLkZZL9T8OuQ2YdnuEn1oWkidP5x7lHF3ec9hBzZN6K+AlT
	Cx66yKQ==
X-Received: from plhd15.prod.google.com ([2002:a17:903:230f:b0:2c1:220c:ccc1])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:3886:b0:2c9:d892:b7df
 with SMTP id d9443c01a7336-2ca2e91091cmr3477505ad.25.1782756753613; Mon, 29
 Jun 2026 11:12:33 -0700 (PDT)
Date: Mon, 29 Jun 2026 18:10:57 +0000
In-Reply-To: <20260629181226.1929658-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260629181226.1929658-1-kuniyu@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260629181226.1929658-6-kuniyu@google.com>
Subject: [PATCH v1 net-next 05/10] net: fib_rules: Add fib_rules_ops.lock.
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
	TAGGED_FROM(0.00)[bounces-302768-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 7740C6DDF25

We will no longer hold RTNL for RTM_NEWRULE and RMT_DELRULE
except for the first IPv4 RTM_NEWRULE.

Let's add per-fib_rules_ops mutex inside RTNL.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 include/net/fib_rules.h |  1 +
 net/core/fib_rules.c    | 20 ++++++++++++++++++--
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/include/net/fib_rules.h b/include/net/fib_rules.h
index f9a4bca51eda..7636ef4da5ad 100644
--- a/include/net/fib_rules.h
+++ b/include/net/fib_rules.h
@@ -98,6 +98,7 @@ struct fib_rules_ops {
 	struct list_head	rules_list;
 	struct module		*owner;
 	struct net		*fro_net;
+	struct mutex		lock;
 	struct rcu_head		rcu;
 };
 
diff --git a/net/core/fib_rules.c b/net/core/fib_rules.c
index 961eb709f256..8b9dac1bd4a7 100644
--- a/net/core/fib_rules.c
+++ b/net/core/fib_rules.c
@@ -172,6 +172,7 @@ fib_rules_register(const struct fib_rules_ops *tmpl, struct net *net)
 		return ERR_PTR(-ENOMEM);
 
 	INIT_LIST_HEAD(&ops->rules_list);
+	mutex_init(&ops->lock);
 	ops->fro_net = net;
 
 	err = __fib_rules_register(ops);
@@ -392,6 +393,7 @@ static int call_fib_rule_notifiers(struct net *net,
 	};
 
 	ASSERT_RTNL_NET(net);
+	lockdep_assert_held(&ops->lock);
 
 	/* Paired with READ_ONCE() in fib_rules_seq() */
 	WRITE_ONCE(ops->fib_rules_seq, ops->fib_rules_seq + 1);
@@ -910,6 +912,7 @@ int fib_newrule(struct net *net, struct sk_buff *skb, struct nlmsghdr *nlh,
 
 	if (!rtnl_held)
 		rtnl_net_lock(net);
+	mutex_lock(&ops->lock);
 
 	err = fib_nl2rule_rtnl(rule, ops, tb, extack);
 	if (err)
@@ -978,6 +981,7 @@ int fib_newrule(struct net *net, struct sk_buff *skb, struct nlmsghdr *nlh,
 
 	fib_rule_get(rule);
 
+	mutex_unlock(&ops->lock);
 	if (!rtnl_held)
 		rtnl_net_unlock(net);
 
@@ -988,6 +992,7 @@ int fib_newrule(struct net *net, struct sk_buff *skb, struct nlmsghdr *nlh,
 	return 0;
 
 errout_free:
+	mutex_unlock(&ops->lock);
 	if (!rtnl_held)
 		rtnl_net_unlock(net);
 	kfree(rule);
@@ -1039,6 +1044,7 @@ int fib_delrule(struct net *net, struct sk_buff *skb, struct nlmsghdr *nlh,
 
 	if (!rtnl_held)
 		rtnl_net_lock(net);
+	mutex_lock(&ops->lock);
 
 	err = fib_nl2rule_rtnl(nlrule, ops, tb, extack);
 	if (err)
@@ -1093,6 +1099,7 @@ int fib_delrule(struct net *net, struct sk_buff *skb, struct nlmsghdr *nlh,
 
 	call_fib_rule_notifiers(net, FIB_EVENT_RULE_DEL, rule, ops, NULL);
 
+	mutex_unlock(&ops->lock);
 	if (!rtnl_held)
 		rtnl_net_unlock(net);
 
@@ -1104,6 +1111,7 @@ int fib_delrule(struct net *net, struct sk_buff *skb, struct nlmsghdr *nlh,
 	return 0;
 
 errout_free:
+	mutex_unlock(&ops->lock);
 	if (!rtnl_held)
 		rtnl_net_unlock(net);
 	kfree(nlrule);
@@ -1403,20 +1411,28 @@ static int fib_rules_event(struct notifier_block *this, unsigned long event,
 
 	switch (event) {
 	case NETDEV_REGISTER:
-		list_for_each_entry(ops, &net->rules_ops, list)
+		list_for_each_entry(ops, &net->rules_ops, list) {
+			mutex_lock(&ops->lock);
 			attach_rules(&ops->rules_list, dev);
+			mutex_unlock(&ops->lock);
+		}
 		break;
 
 	case NETDEV_CHANGENAME:
 		list_for_each_entry(ops, &net->rules_ops, list) {
+			mutex_lock(&ops->lock);
 			detach_rules(&ops->rules_list, dev);
 			attach_rules(&ops->rules_list, dev);
+			mutex_unlock(&ops->lock);
 		}
 		break;
 
 	case NETDEV_UNREGISTER:
-		list_for_each_entry(ops, &net->rules_ops, list)
+		list_for_each_entry(ops, &net->rules_ops, list) {
+			mutex_lock(&ops->lock);
 			detach_rules(&ops->rules_list, dev);
+			mutex_unlock(&ops->lock);
+		}
 		break;
 	}
 
-- 
2.55.0.rc0.799.gd6f94ed593-goog



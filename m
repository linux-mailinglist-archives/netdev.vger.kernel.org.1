Return-Path: <netdev+bounces-295460-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /hk5GWABImr/RQEAu9opvQ
	(envelope-from <netdev+bounces-295460-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 00:51:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB34643DE6
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 00:51:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=p0tpiiRN;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295460-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-295460-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DCA713064713
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 22:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B8732EEE72;
	Thu,  4 Jun 2026 22:47:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B7133F8A1
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 22:47:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780613250; cv=none; b=PpaX4uve0Mq8P316QnYiknvJCfAncMuueaoSZVOFcVIJQF6o+uu32cFXol4sLbGd6JOacRsXILTwK03cL6sydj6bwi70Gegif7PGnge5Q1qsBUWwnqtGNsiQRniXGT1I0s7+aEq5DQagjTZGWWvykWhyumSFo+F4XYpHUU5GzlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780613250; c=relaxed/simple;
	bh=gH+GZwJFBeinisdV0VqY+4qBFwH40iTxSzO8b+UvK1k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mWj94pyKivflnhJt6hWpD5uojdb+u0DH5fN6/2JkZt0suLvdB/677tbCNiUhDZSDDWx0BL5dwPr3JefGpY8QTmuJUh3yPY5Ft2gYypHUnca8LISzXlUywvLjm8hwCzgIe+PiThPuEgY1O53v7jCp1f+tVhQDW4S131x7WvzpwMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p0tpiiRN; arc=none smtp.client-ip=209.85.216.73
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-36d97a4e08fso1128786a91.0
        for <netdev@vger.kernel.org>; Thu, 04 Jun 2026 15:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780613248; x=1781218048; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+bPDgs/fa5RPFvG8fR4TUIVB0FsWdGFoesfioLm6zcw=;
        b=p0tpiiRNe7ZFewceFH0+4Bsv+EvzetZAvFxKzdOzePj4Ln4eiWeSbq+FCq54bYqTgZ
         YIMX7sVQQQUCqPA5ZyN3/iedKmb7aegf8sYlU1KMKIt+y1oLIxwKt5B3o52FS2iUWmkX
         7AfBSNXd+8cWSnH+A8ldDRMdCaeQQZxoB/Ik9jV6pdb+ozq5SG08nWb5ZC+5VlmOxtFr
         gGIF85kXs5E4oz+yQjPB8PgxSShtNq9jf5rB5202EhSKpUd+/kbl3at4Z5XaxUhgHkpT
         lq29qUJnaMmV/nBqIFbk9FFEfqw+pyC9+Y7zRQvM7zvNnSuCTLKmSAqd079VBiDD2ThD
         qtmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780613248; x=1781218048;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+bPDgs/fa5RPFvG8fR4TUIVB0FsWdGFoesfioLm6zcw=;
        b=PtvrrUCz/CaJiLDw79j8y+rIP7w0KLTAs5TlEzCFPzQMENZau3sNLKX0JqclbiLMAg
         DACDVnnahWWHXWqEdiDZtKE6VDO+kKbDv3rVKE7CYQRamvgRXFAGN0dDRILbg17XL3vn
         iLGOWcvxM0QAYgG8iDGgXk5vk7+WwuSPOmQ2MzvyrOEVb+JS+aRVJYhlZxJ1UnuX81p9
         3CJCgPM/LUeO7jY81O6cg6u9TSODLewfeYs7AL9myCEomkJmvQSJGM49EDX8A2hdGuJV
         88Ulq5w3oY7L3Sj2a3nMAvZdd3HCQMuiDlkBytfgAzwV1WWFz7XA3SIJvTl+IkRuYdSK
         OOaA==
X-Forwarded-Encrypted: i=1; AFNElJ+YAuw33E3Y4fMNKIuo0ovgxAsb+MYMp6pYhpij/MF7wK3Qkb1Hbs4IfyB5nvOK2CtsXa9E6fw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7OTnmUq7h+gCBh3YA+4Vli12d2jYul3KJ0zCO5WuncrQo95CI
	+FWRe6Ht//Gi6C6IVXraa1XCeLl5IjYZelE7gWvB48Yay4Y4UEdah9D2p9ijjb8qJHBFeRi7JTU
	I/JogCw==
X-Received: from pgk24.prod.google.com ([2002:a63:a18:0:b0:c82:7761:991a])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5210:b0:36a:8240:2477
 with SMTP id 98e67ed59e1d1-370f0967012mr790735a91.19.1780613247532; Thu, 04
 Jun 2026 15:47:27 -0700 (PDT)
Date: Thu,  4 Jun 2026 22:46:27 +0000
In-Reply-To: <20260604224712.3209821-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260604224712.3209821-1-kuniyu@google.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260604224712.3209821-10-kuniyu@google.com>
Subject: [PATCH v3 net-next 09/15] ip6mr: Call fib_rules_unregister() without RTNL.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S . Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Ido Schimmel <idosch@nvidia.com>, 
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-295460-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:dsahern@kernel.org,m:edumazet@google.com,m:idosch@nvidia.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:kuniyu@google.com,m:kuni1840@gmail.com,m:netdev@vger.kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EDB34643DE6

fib_rules_unregister() removes ops from net->rules_ops under
spinlock, calls ops->delete() for each rule, and frees the ops.

ip6mr_rules_ops_template does not have ->delete(), and any
operation does not require RTNL there.

Let's move fib_rules_unregister() from ip6mr_rules_exit() to
ip6mr_net_exit().

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/ipv6/ip6mr.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
index ddbe06397d9c..bb613331ead2 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -259,6 +259,11 @@ static int __net_init ip6mr_rules_init(struct net *net)
 }
 
 static void __net_exit ip6mr_rules_exit(struct net *net)
+{
+	fib_rules_unregister(net->ipv6.mr6_rules_ops);
+}
+
+static void __net_exit ip6mr_rules_exit_rtnl(struct net *net)
 {
 	struct mr_table *mrt, *next;
 
@@ -267,7 +272,6 @@ static void __net_exit ip6mr_rules_exit(struct net *net)
 		list_del_rcu(&mrt->list);
 		ip6mr_free_table(mrt);
 	}
-	fib_rules_unregister(net->ipv6.mr6_rules_ops);
 }
 
 static int ip6mr_rules_dump(struct net *net, struct notifier_block *nb,
@@ -328,6 +332,10 @@ static int __net_init ip6mr_rules_init(struct net *net)
 }
 
 static void __net_exit ip6mr_rules_exit(struct net *net)
+{
+}
+
+static void __net_exit ip6mr_rules_exit_rtnl(struct net *net)
 {
 	struct mr_table *mrt = rcu_dereference_protected(net->ipv6.mrt6, 1);
 
@@ -1366,8 +1374,9 @@ static int __net_init ip6mr_net_init(struct net *net)
 	remove_proc_entry("ip6_mr_vif", net->proc_net);
 proc_vif_fail:
 	rtnl_lock();
-	ip6mr_rules_exit(net);
+	ip6mr_rules_exit_rtnl(net);
 	rtnl_unlock();
+	ip6mr_rules_exit(net);
 #endif
 ip6mr_rules_fail:
 	ip6mr_notifier_exit(net);
@@ -1380,6 +1389,7 @@ static void __net_exit ip6mr_net_exit(struct net *net)
 	remove_proc_entry("ip6_mr_cache", net->proc_net);
 	remove_proc_entry("ip6_mr_vif", net->proc_net);
 #endif
+	ip6mr_rules_exit(net);
 	ip6mr_notifier_exit(net);
 }
 
@@ -1389,7 +1399,7 @@ static void __net_exit ip6mr_net_exit_batch(struct list_head *net_list)
 
 	rtnl_lock();
 	list_for_each_entry(net, net_list, exit_list)
-		ip6mr_rules_exit(net);
+		ip6mr_rules_exit_rtnl(net);
 	rtnl_unlock();
 }
 
-- 
2.54.0.1032.g2f8565e1d1-goog



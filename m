Return-Path: <netdev+bounces-277589-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ELlvIbBp2Wk1pggAu9opvQ
	(envelope-from <netdev+bounces-277589-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 23:20:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F15BF3DCD7E
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 23:20:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 212AC304E5C4
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 21:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51C013AF657;
	Fri, 10 Apr 2026 21:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b5PjKLJL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3B23C13E1
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 21:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775855876; cv=none; b=YR7aurawBoNAXEKbdkYMs4to1rbRnpmZVlCdKr2oNijv3uFTWc3E1Dm1FRPZ62xePZ9hnyNaQH3wyrV8da+ZhVH8EENt84KhGB+22sHE55ii1SIn8hlkuGP+kl2p70A5s/K2cfsqYFus3f17kszj/uwRgj+KZThQAZae+HQaaic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775855876; c=relaxed/simple;
	bh=xA8aHJqcLzD83VIFtTt4W5+7HyEXquDccyUeQ6Tum7Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JyVrJgVli4XbfUJ4X4zBMFu9jTaekuIrnPKLFW3nirlcfY9WlF0CAY80j9eKuquW7IBg1DEenYstBTJVw/Jbncbrpqre6FP3mT4BgTj9zC3YO9lif0b1NpfOb58FAWNZb1/9Bzjn6SgIFDuCTfPaah03E//pP5I+0r5fhl//PxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b5PjKLJL; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c76bd4feb9fso1546236a12.0
        for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 14:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775855874; x=1776460674; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dIdcRj+T9tt+7cz8URohoUhrrOp9HUzgUEC9Y1TYUAg=;
        b=b5PjKLJLSkxwLHY8QJ0W50kYplRn11Rxriu+0OUBd1lHqcclezQ+BaZaG+TcduTpMQ
         d+iB6QrzegJALG6CR0g22NszKlRiBfcicl61NmosmmAXXNMlAI4AbQLOFmP2RoUrquyy
         nJ4h7OE4fSVee3udkhqr525PehhWbKhPjcSBB27+XKBtH1q1jPsO8U/96lRYIizbi+xm
         PHyJXp3Wg6VovTPT+yL8oSTCMkZ1gPt0+44W00EWbNF4Eg7a4imtEVJBaJeI6mGPiCOi
         e2uAWmUU4pyJfR9Fp0H1JCt1bcBAaFFL1ptb5jNYa42MB/JPnCG9uXnYzTvqFprVS27l
         lh+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775855874; x=1776460674;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dIdcRj+T9tt+7cz8URohoUhrrOp9HUzgUEC9Y1TYUAg=;
        b=pKtIdV72HjwzjGInZXhGR74OTGgZbohIB8IyZQhzFqccrkuxytj2C2wv1prT5NLYHH
         0RE2sIzrMWPrqMQJkBvykJVwW+oIY2eM/3ZNUGENLzTIDcV2z3Nul/r0uctQ9dEAKcW6
         fnCW8dm8ZGtEOFsl7JT4Ta8q+e9/uwqSaOzrsZGUn7xmXCKA25i/fxaGSvxHZS185MoA
         10IZfwEcQWoq86hXlWxV2W6jPhpAeZfXDKhckdk8za7eoRXX9oww4kI5fc98AQDMC3kr
         RA5feIN5KQjH6XfCfYOLnB9fmaxujwuexvB+vMxwOLOAVdZQ+zF3jHwz3+FoYkZkDjR3
         e90A==
X-Forwarded-Encrypted: i=1; AJvYcCVPJOM6m9zY/jUSHCpk4kuoRrhlV7lqVzN1qz0KqJyl1RQYdVX8qIhXiphbxAbhq1ZUjwr2ZYY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1SPJ5OLoUb9WURiq0g37/NihvxUlJ3e9EGwHF6dkwF9h8VO7C
	SL5CZpPrg+cXnPTDm+Z2li7+jJkcdKkgAc3fH1wO1Q4UcUNfsUEnFi1X4ROuhXpAMZ4JyKan+Vd
	bUel7Tg==
X-Received: from pgbdp13.prod.google.com ([2002:a05:6a02:f0d:b0:c76:669e:8145])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:a12c:b0:398:d981:f623
 with SMTP id adf61e73a8af0-39fe3c9873amr5581280637.1.1775855873981; Fri, 10
 Apr 2026 14:17:53 -0700 (PDT)
Date: Fri, 10 Apr 2026 21:17:09 +0000
In-Reply-To: <20260410211726.1668756-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260410211726.1668756-1-kuniyu@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260410211726.1668756-14-kuniyu@google.com>
Subject: [PATCH v2 net-next 13/15] ip6mr: Remove RTNL in ip6mr_rules_init()
 and ip6mr_net_init().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S . Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-277589-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F15BF3DCD7E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When ip6mr_free_table() is called from ip6mr_rules_init() or
ip6mr_net_init(), the netns is not yet published.

Thus, no device should have been registered, and
mroute_clean_tables() will not call mif6_delete(), so
unregister_netdevice_many() is unnecessary.

unregister_netdevice_many() does nothing if the list is empty,
but it requires RTNL due to the unconditional ASSERT_RTNL()
at the entry of unregister_netdevice_many_notify().

Let's remove unnecessary RTNL and ASSERT_RTNL() and instead
add WARN_ON_ONCE() in ip6mr_free_table().

Note that we use a local list for the new WARN_ON_ONCE() because
dev_kill_list passed from ip6mr_rules_exit_rtnl() may have some
devices when other ops->init() fails after ipmr durnig setup_net().

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/ipv6/ip6mr.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
index 860fce51819e..3b8867e150fe 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -253,10 +253,7 @@ static int __net_init ip6mr_rules_init(struct net *net)
 	return 0;
 
 err2:
-	rtnl_lock();
 	ip6mr_free_table(mrt, &dev_kill_list);
-	unregister_netdevice_many(&dev_kill_list);
-	rtnl_unlock();
 err1:
 	fib_rules_unregister(ops);
 	return err;
@@ -267,7 +264,6 @@ static void __net_exit ip6mr_rules_exit_rtnl(struct net *net,
 {
 	struct mr_table *mrt, *next;
 
-	ASSERT_RTNL();
 	list_for_each_entry_safe(mrt, next, &net->ipv6.mr6_tables, list) {
 		list_del_rcu(&mrt->list);
 		ip6mr_free_table(mrt, dev_kill_list);
@@ -338,8 +334,6 @@ static void __net_exit ip6mr_rules_exit_rtnl(struct net *net,
 {
 	struct mr_table *mrt = rcu_dereference_protected(net->ipv6.mrt6, 1);
 
-	ASSERT_RTNL();
-
 	RCU_INIT_POINTER(net->ipv6.mrt6, NULL);
 	ip6mr_free_table(mrt, dev_kill_list);
 }
@@ -420,15 +414,19 @@ static void ip6mr_free_table(struct mr_table *mrt,
 			     struct list_head *dev_kill_list)
 {
 	struct net *net = read_pnet(&mrt->net);
+	LIST_HEAD(ip6mr_dev_kill_list);
 
 	WARN_ON_ONCE(!mr_can_free_table(net));
 
 	timer_shutdown_sync(&mrt->ipmr_expire_timer);
 	mroute_clean_tables(mrt, MRT6_FLUSH_MIFS | MRT6_FLUSH_MIFS_STATIC |
 			    MRT6_FLUSH_MFC | MRT6_FLUSH_MFC_STATIC,
-			    dev_kill_list);
+			    &ip6mr_dev_kill_list);
 	rhltable_destroy(&mrt->mfc_hash);
 	kfree_rcu(mrt, rcu);
+
+	WARN_ON_ONCE(!net_initialized(net) && !list_empty(&ip6mr_dev_kill_list));
+	list_splice(&ip6mr_dev_kill_list, dev_kill_list);
 }
 
 #ifdef CONFIG_PROC_FS
@@ -1368,10 +1366,7 @@ static int __net_init ip6mr_net_init(struct net *net)
 proc_cache_fail:
 	remove_proc_entry("ip6_mr_vif", net->proc_net);
 proc_vif_fail:
-	rtnl_lock();
 	ip6mr_rules_exit_rtnl(net, &dev_kill_list);
-	unregister_netdevice_many(&dev_kill_list);
-	rtnl_unlock();
 #endif
 ip6mr_rules_fail:
 	ip6mr_notifier_exit(net);
-- 
2.53.0.1213.gd9a14994de-goog



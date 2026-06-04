Return-Path: <netdev+bounces-295462-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LmprJaYAImrkRQEAu9opvQ
	(envelope-from <netdev+bounces-295462-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 00:48:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3552F643DB3
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 00:48:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b="loek9j/e";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295462-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-295462-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DA4B9302A438
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 22:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0649C30D404;
	Thu,  4 Jun 2026 22:47:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA0B2F7F14
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 22:47:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780613254; cv=none; b=CstFBhKn2aiOzfFSchJo5Q2TmqvpiBUqMmWDpAeovCH+0PGI+SA9qT1EgORf4hni3diSmGkjr5mS1ooXYKy9onyqkYQ/Puz2uYDt+jqs88LgcDBXxyE87p6uOHnfBJz3wAP0DPE3EdljQMMRqgsbW1kcR09jkFZIapnKPMU34sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780613254; c=relaxed/simple;
	bh=zEgyffOlvxsFcS7bdp1Lva0iXsOzxMnW5EbNajdJ/vM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=T3VpOjr4B2FO0qhRiQJxPRqgdjC2f1g7Q7oLvmuGOrwo5ATj5adQsU+Whzy6A3zN2Ws/N6MgmWnsUnIi5++LT8Ww8aqeqqNhHaocjwk/h6FCkWZ2e1dPAdTG/mqadQoEFEu4G2DGLQFCOMbZuGPQJO5skXI2dfBiphY4rN+bDB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=loek9j/e; arc=none smtp.client-ip=209.85.210.202
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-84245e2bb00so1021437b3a.1
        for <netdev@vger.kernel.org>; Thu, 04 Jun 2026 15:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780613249; x=1781218049; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rOPrIaxOHzXHRKgdrJGdPS312xoEWU6Xhd+kr0B02yw=;
        b=loek9j/elnUVfL4EU8lKMSPj2T+jI9USYYLR+3cIBLwuMhlsBwV52fNIYbToblDNxJ
         T0tVvY8uI6vKkQBdQiBzXBSps5ds9z8svE2nNR9rgW60D1jlhaEsUzNQ9d4fjeYYAASc
         gRZVOXeEcF+gjUexNUfyr8o2sr30Zb/x6mhm3mu7GGe9XBcgb2usXFx6o2m8ciRxqcaX
         Dmz3kBBSheMb1kQsLNWdjx4q0RSYpV89jiXNsFw5gkL7lmkESmCsEueYM3RvKp6uT2L8
         N9TyauVQCAPe9O3qquRgYK6OLk9U/+/M6IIGSA2gHEMDPISzjD0JdMvWxA4BtTvz4m79
         6uOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780613249; x=1781218049;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rOPrIaxOHzXHRKgdrJGdPS312xoEWU6Xhd+kr0B02yw=;
        b=IsbpCtV2Q42+ROzJlhySlc2XajFLpfsI9Wv4f3dyQyV1IZlo22JLVStsT8wetTUxI7
         udOQNTp+aQrihhhPfTRijnMd3p9I+1nS4hMNKpxdgvzdXHEZpL/XHgtTAZtkPIpOfYkG
         gUmq7S9gl6Pc12gJJvH2xx777fZ4IB36IO7rpmuO8JcUjcOWdprt/RG9jiB50CRKMKJK
         R5pjVl6FDVESEjIkQQ4sZz+p4iegx7J9WEy7pmVKtFcwjO25ffu3dSZgjUH5s40BWdVe
         OyVx/L/Vao0FBch3VzPyJKdStcBcRmG3suhFT77souO1NF2n2BzvyshLLNgcL6Z42Yw8
         jWGQ==
X-Forwarded-Encrypted: i=1; AFNElJ/jIMOxnbF77B2h2qQlnMhmF2XLgNrPp8QfYUIdg7LehwjZdTXgLNJQAcMzEdYcJv1QObd6GOg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJxjHQ5snJSlRdpFEwQnYrb+NlDBK8yUYuaJVKICn9UAvTf1KF
	HPgpcqE/luk2+HWdWAu49JvLfYLcNTocijnXeVFala0hPXi9mzW2xAwUlPZzR+SBc4htt7tZO+Y
	qH6RG9A==
X-Received: from pfbky35.prod.google.com ([2002:a05:6a00:6f63:b0:83f:1941:b9bc])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:23ca:b0:842:572f:2521
 with SMTP id d2e1a72fcca58-842b0e1d172mr600023b3a.10.1780613249111; Thu, 04
 Jun 2026 15:47:29 -0700 (PDT)
Date: Thu,  4 Jun 2026 22:46:29 +0000
In-Reply-To: <20260604224712.3209821-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260604224712.3209821-1-kuniyu@google.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260604224712.3209821-12-kuniyu@google.com>
Subject: [PATCH v3 net-next 11/15] ip6mr: Move unregister_netdevice_many() out
 of ip6mr_free_table().
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-295462-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3552F643DB3

This is a prep commit to convert ip6mr_net_exit_batch() to
->exit_rtnl().

Let's move unregister_netdevice_many() in ip6mr_free_table()
to its callers.

Now ip6mr_rules_exit() can do batching all tables per netns.

Note that later we will remove RTNL and unregister_netdevice_many()
in ip6mr_rules_init().

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/ipv6/ip6mr.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
index b5da94c9f074..f531c4a24ea1 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -85,7 +85,8 @@ static DEFINE_SPINLOCK(mfc_unres_lock);
 static struct kmem_cache *mrt_cachep __read_mostly;
 
 static struct mr_table *ip6mr_new_table(struct net *net, u32 id);
-static void ip6mr_free_table(struct mr_table *mrt);
+static void ip6mr_free_table(struct mr_table *mrt,
+			     struct list_head *dev_kill_list);
 
 static void ip6_mr_forward(struct net *net, struct mr_table *mrt,
 			   struct net_device *dev, struct sk_buff *skb,
@@ -228,6 +229,7 @@ static const struct fib_rules_ops __net_initconst ip6mr_rules_ops_template = {
 static int __net_init ip6mr_rules_init(struct net *net)
 {
 	struct fib_rules_ops *ops;
+	LIST_HEAD(dev_kill_list);
 	struct mr_table *mrt;
 	int err;
 
@@ -252,7 +254,8 @@ static int __net_init ip6mr_rules_init(struct net *net)
 
 err2:
 	rtnl_lock();
-	ip6mr_free_table(mrt);
+	ip6mr_free_table(mrt, &dev_kill_list);
+	unregister_netdevice_many(&dev_kill_list);
 	rtnl_unlock();
 err1:
 	fib_rules_unregister(ops);
@@ -267,12 +270,15 @@ static void __net_exit ip6mr_rules_exit(struct net *net)
 static void __net_exit ip6mr_rules_exit_rtnl(struct net *net)
 {
 	struct mr_table *mrt, *next;
+	LIST_HEAD(dev_kill_list);
 
 	ASSERT_RTNL();
 	list_for_each_entry_safe(mrt, next, &net->ipv6.mr6_tables, list) {
 		list_del_rcu(&mrt->list);
-		ip6mr_free_table(mrt);
+		ip6mr_free_table(mrt, &dev_kill_list);
 	}
+
+	unregister_netdevice_many(&dev_kill_list);
 }
 
 static int ip6mr_rules_dump(struct net *net, struct notifier_block *nb,
@@ -339,11 +345,13 @@ static void __net_exit ip6mr_rules_exit(struct net *net)
 static void __net_exit ip6mr_rules_exit_rtnl(struct net *net)
 {
 	struct mr_table *mrt = rcu_dereference_protected(net->ipv6.mrt6, 1);
+	LIST_HEAD(dev_kill_list);
 
 	ASSERT_RTNL();
 
 	RCU_INIT_POINTER(net->ipv6.mrt6, NULL);
-	ip6mr_free_table(mrt);
+	ip6mr_free_table(mrt, &dev_kill_list);
+	unregister_netdevice_many(&dev_kill_list);
 }
 
 static int ip6mr_rules_dump(struct net *net, struct notifier_block *nb,
@@ -418,18 +426,17 @@ static struct mr_table *ip6mr_new_table(struct net *net, u32 id)
 			      ipmr_expire_process, ip6mr_new_table_set);
 }
 
-static void ip6mr_free_table(struct mr_table *mrt)
+static void ip6mr_free_table(struct mr_table *mrt,
+			     struct list_head *dev_kill_list)
 {
 	struct net *net = read_pnet(&mrt->net);
-	LIST_HEAD(dev_kill_list);
 
 	WARN_ON_ONCE(!mr_can_free_table(net));
 
 	timer_shutdown_sync(&mrt->ipmr_expire_timer);
 	mroute_clean_tables(mrt, MRT6_FLUSH_MIFS | MRT6_FLUSH_MIFS_STATIC |
 			    MRT6_FLUSH_MFC | MRT6_FLUSH_MFC_STATIC,
-			    &dev_kill_list);
-	unregister_netdevice_many(&dev_kill_list);
+			    dev_kill_list);
 
 	mr_table_free(mrt);
 }
-- 
2.54.0.1032.g2f8565e1d1-goog



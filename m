Return-Path: <netdev+bounces-276174-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SJekMEx21WlC6gcAu9opvQ
	(envelope-from <netdev+bounces-276174-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 23:25:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A7473B502F
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 23:25:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 88EB630E2DD3
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 21:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49C6337CD5F;
	Tue,  7 Apr 2026 21:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ul/Crvzz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047E437BE73
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 21:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775596823; cv=none; b=jnTtsdNLMx9ymQo28U0u8FrGgTxTtNc8tEYn1OisPyI/FXBvDCzPPRn3kpecPDQ+IjMB5l1y6Smx2Nb7L4Whr6gVUXDZ7Rp6eQtlpzVjmebS7/hmiDPx5GwSg6mf9QMU1BL80JOqO52eb5GE6/5SaWyFjlXOxrvLJKp8DVdBg4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775596823; c=relaxed/simple;
	bh=baHGkHdnKVILW14V9fkDm+tlAo+TcP8mZMEUyxQSii4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fAeiyzEGIgkpz1elVEevWbKKMumfwCYyf5yrHah5r3zG1DnZ3CYRaIMvZEMk1VD53BTHaNn11NBrh26rKfwR9EzUlPJcqSuFoB165qYeqtIrnB7u0lj6C0BKMGlCYcEQ7HO3Ew1SeG+eL5X4Kxio+WPnOppJVTiydMwLhcAEoe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ul/Crvzz; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c76ad3b732eso8456690a12.1
        for <netdev@vger.kernel.org>; Tue, 07 Apr 2026 14:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775596821; x=1776201621; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cjKFtfIJDLWL+LZWK9grVg4UFi0pQnYmM8GkW+IKuzc=;
        b=ul/Crvzz2IpEKVmAU48OkYKtviz/YsMu7b2MUff+MGx1Uf7dWkP+NJJQGm33W+iUau
         2ESmONn9XkceabJjUy08JZcFVRgPF/22/EMU2TTbraacOXDdGHPnWBx283iuqQsgdGYt
         8OKdxzeWUkuPN/SpEsCtvBSoiZWxmPOsnzuZjjxV8hXvQM+Tm6MM/qS9dFFGR6aczvmH
         q5UZ8vQsVw2xvGI4suNIB+lccNX3Xo5YKmDigyaUOu8Um/iEKxh64fY6rtxmuWkQQyh2
         OqbihdOf6VVL9raP9Dhad1Bhvsr77q9L27ofaUAjKYitcz/THVEyXKEoETs9K994pkD+
         3G8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775596821; x=1776201621;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cjKFtfIJDLWL+LZWK9grVg4UFi0pQnYmM8GkW+IKuzc=;
        b=KP3XU3supnKRXvMwuJsoUGfpycfk5DUYDoaT3jTponDG5hJXxvWq8SS5VebqZ25Giv
         WsX84r7EAcW1hYlo3Ye9pIn+FhxXFObz77xbTKMG44cV+/WQNgHwk+KOwsbbzHYyHkpz
         FiwMep37aC4gWK27l3+3XJtY7ruMxZbUioCw3evZSJ/Mus7HYjYOCIWovfi1DpUQ73gZ
         u1IguzoKmh4hKenI6gNqxaqIu/MQ4v/hGYXBwqZBBRKQwJZz8Dt/pzFcvgofuamp6pXd
         9/a/PcMYDYBCB6g+M5S1GcH9a+1XIYy35suBZ2p7c9kRNLLKkdJlTYqR91vX0bMcsL9N
         mvMA==
X-Forwarded-Encrypted: i=1; AJvYcCVkQ3c3Y4xXvh9DXXNccjMRxsHcwtxu2HArEYzxKkCv1ROZgDNFUNc4z/g2IY0fnVrtthWnNeU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0+V8UWra4eQXCSz6CQsGYskXQzRpdcN1wcZGNFvsQ3w7NI9sj
	Io9cUWawz3PKu99X4lfmMlWLvIXCBVnxci1Kj5ooHfHMw+BVWYaPLIbXzgYCoL/vzlhHGtu3QbM
	AJRqh7Q==
X-Received: from pfdj20.prod.google.com ([2002:a05:6a00:9514:b0:82c:ebd5:6f92])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:414c:b0:82c:9f73:a2f
 with SMTP id d2e1a72fcca58-82d0db96cbbmr17123701b3a.40.1775596821222; Tue, 07
 Apr 2026 14:20:21 -0700 (PDT)
Date: Tue,  7 Apr 2026 21:19:44 +0000
In-Reply-To: <20260407212001.2368593-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260407212001.2368593-1-kuniyu@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260407212001.2368593-12-kuniyu@google.com>
Subject: [PATCH v3 net-next 11/15] ip6mr: Convert ip6mr_net_exit_batch() to ->exit_rtnl().
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-276174-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2A7473B502F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

ip6mr_net_ops uses ->exit_batch() to acquire RTNL only once
for dying network namespaces.

ip6mr does not depend on the ordering of ->exit_rtnl() and
->exit_batch() of other pernet_operations (unlike fib_net_ops).

Once ip6mr_free_table() is called and all devices are
queued for destruction in ->exit_rtnl(), later during
NETDEV_UNREGISTER, ip6mr_device_event() will not see anything
in vif table and just do nothing.

Let's convert ip6mr_net_exit_batch() to ->exit_rtnl().

Note that fib_rules_unregister() does not need RTNL and
we will remove RTNL and unregister_netdevice_many() in
ip6mr_rules_init().

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/ipv6/ip6mr.c | 31 +++++++++++++------------------
 1 file changed, 13 insertions(+), 18 deletions(-)

diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
index 30e1aece5f53..2220a2049781 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -272,18 +272,17 @@ static int __net_init ip6mr_rules_init(struct net *net)
 	return err;
 }
 
-static void __net_exit ip6mr_rules_exit(struct net *net)
+static void __net_exit ip6mr_rules_exit_rtnl(struct net *net,
+					     struct list_head *dev_kill_list)
 {
 	struct mr_table *mrt, *next;
-	LIST_HEAD(dev_kill_list);
 
 	ASSERT_RTNL();
 	list_for_each_entry_safe(mrt, next, &net->ipv6.mr6_tables, list) {
 		list_del(&mrt->list);
-		ip6mr_free_table(mrt, &dev_kill_list);
+		ip6mr_free_table(mrt, dev_kill_list);
 	}
 
-	unregister_netdevice_many(&dev_kill_list);
 	fib_rules_unregister(net->ipv6.mr6_rules_ops);
 }
 
@@ -341,13 +340,11 @@ static int __net_init ip6mr_rules_init(struct net *net)
 	return 0;
 }
 
-static void __net_exit ip6mr_rules_exit(struct net *net)
+static void __net_exit ip6mr_rules_exit_rtnl(struct net *net,
+					     struct list_head *dev_kill_list)
 {
-	LIST_HEAD(dev_kill_list);
-
 	ASSERT_RTNL();
-	ip6mr_free_table(net->ipv6.mrt6, &dev_kill_list);
-	unregister_netdevice_many(&dev_kill_list);
+	ip6mr_free_table(net->ipv6.mrt6, dev_kill_list);
 
 	net->ipv6.mrt6 = NULL;
 }
@@ -1340,6 +1337,7 @@ static void __net_exit ip6mr_notifier_exit(struct net *net)
 /* Setup for IP multicast routing */
 static int __net_init ip6mr_net_init(struct net *net)
 {
+	LIST_HEAD(dev_kill_list);
 	int err;
 
 	err = ip6mr_notifier_init(net);
@@ -1367,7 +1365,8 @@ static int __net_init ip6mr_net_init(struct net *net)
 	remove_proc_entry("ip6_mr_vif", net->proc_net);
 proc_vif_fail:
 	rtnl_lock();
-	ip6mr_rules_exit(net);
+	ip6mr_rules_exit_rtnl(net, &dev_kill_list);
+	unregister_netdevice_many(&dev_kill_list);
 	rtnl_unlock();
 #endif
 ip6mr_rules_fail:
@@ -1384,20 +1383,16 @@ static void __net_exit ip6mr_net_exit(struct net *net)
 	ip6mr_notifier_exit(net);
 }
 
-static void __net_exit ip6mr_net_exit_batch(struct list_head *net_list)
+static void __net_exit ip6mr_net_exit_rtnl(struct net *net,
+					   struct list_head *dev_kill_list)
 {
-	struct net *net;
-
-	rtnl_lock();
-	list_for_each_entry(net, net_list, exit_list)
-		ip6mr_rules_exit(net);
-	rtnl_unlock();
+	ip6mr_rules_exit_rtnl(net, dev_kill_list);
 }
 
 static struct pernet_operations ip6mr_net_ops = {
 	.init = ip6mr_net_init,
 	.exit = ip6mr_net_exit,
-	.exit_batch = ip6mr_net_exit_batch,
+	.exit_rtnl = ip6mr_net_exit_rtnl,
 };
 
 static const struct rtnl_msg_handler ip6mr_rtnl_msg_handlers[] __initconst_or_module = {
-- 
2.53.0.1213.gd9a14994de-goog



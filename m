Return-Path: <netdev+bounces-135304-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB85399D814
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 22:20:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45A5CB20EA3
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 20:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EF831CCECD;
	Mon, 14 Oct 2024 20:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Goy22UfH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB459155301
	for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 20:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728937239; cv=none; b=TlyGpc+NjDgTkauzslIz9XzlQsZ4QDgpvMqT/gP9dgjCzbrwojFN8gXM4NuY2XWpPO8IRShF9Rjl1FSizFb/3fUTIdWXvRSTfBRg1k0r4hOTWn9xXLnjqHVWGiOSx3JajOVA122ksOngWsoqw9sv4vv7o6VmeyclSdjo8MEKi5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728937239; c=relaxed/simple;
	bh=Mkj6QO9rGx3eIJTu3B3mciHsnWzjxhc64hYzGwjtnp8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BYvZcoxqlVreKVe6wjSjqm+cD6sgaJjykR/IZeoD97tsMQpIbZOqJDpNVzA17aAcfSVmL1rcfbKz4q47Julsrn88y9QJOV296H5/FGYWpLtJ3UfChaCKlmcqSIWAQ+HCDTp7h9Log624qChbYcknO7xx0aoTuUWNDAkG2uQip5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Goy22UfH; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1728937237; x=1760473237;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=T4jSpqxVsl0px7xzugv7STNqp91A9orhCGVULOFDpf4=;
  b=Goy22UfH4gYet8xTIzSXiDZ3qOxehUEDtgcXl136KVqYgOSflF/WxHbO
   dGHPBzl4uMzs9ESOQtdH5S47wT1mJenW87uhQflwLI/LnOmh99jFZPuLm
   Xejg/CcUkIBZT3H4I3OUpSNidlBRcum6mO2eI0QOvBf7267P18aj/FjYt
   w=;
X-IronPort-AV: E=Sophos;i="6.11,203,1725321600"; 
   d="scan'208";a="138561825"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2024 20:20:36 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.21.151:34782]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.38.26:2525] with esmtp (Farcaster)
 id 0c1f2413-8b8b-428e-8851-26663407bd3f; Mon, 14 Oct 2024 20:20:35 +0000 (UTC)
X-Farcaster-Flow-ID: 0c1f2413-8b8b-428e-8851-26663407bd3f
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 14 Oct 2024 20:20:35 +0000
Received: from 6c7e67c6786f.amazon.com (10.106.101.44) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Mon, 14 Oct 2024 20:20:32 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 06/11] ipv4: Use rtnl_register_many().
Date: Mon, 14 Oct 2024 13:18:23 -0700
Message-ID: <20241014201828.91221-7-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241014201828.91221-1-kuniyu@amazon.com>
References: <20241014201828.91221-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D033UWC002.ant.amazon.com (10.13.139.196) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

We will remove rtnl_register() in favour of rtnl_register_many().

When it succeeds, rtnl_register_many() guarantees all rtnetlink types
in the passed array are supported, and there is no chance that a part
of message types is not supported.

Let's use rtnl_register_many() instead.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
v2:
  * Add __initconst
  * Use C99 initialisation
---
 net/core/fib_rules.c    | 17 ++++++++++-------
 net/ipv4/devinet.c      | 18 +++++++++++-------
 net/ipv4/fib_frontend.c | 14 ++++++++++----
 net/ipv4/nexthop.c      | 31 ++++++++++++++++++-------------
 net/ipv4/route.c        |  8 ++++++--
 5 files changed, 55 insertions(+), 33 deletions(-)

diff --git a/net/core/fib_rules.c b/net/core/fib_rules.c
index 82ef090c0037..d0de9677f450 100644
--- a/net/core/fib_rules.c
+++ b/net/core/fib_rules.c
@@ -1291,13 +1291,18 @@ static struct pernet_operations fib_rules_net_ops = {
 	.exit = fib_rules_net_exit,
 };
 
+static const struct rtnl_msg_handler fib_rules_rtnl_msg_handlers[] __initconst = {
+	{.msgtype = RTM_NEWRULE, .doit = fib_nl_newrule},
+	{.msgtype = RTM_DELRULE, .doit = fib_nl_delrule},
+	{.msgtype = RTM_GETRULE, .dumpit = fib_nl_dumprule,
+	 .flags = RTNL_FLAG_DUMP_UNLOCKED},
+};
+
 static int __init fib_rules_init(void)
 {
 	int err;
-	rtnl_register(PF_UNSPEC, RTM_NEWRULE, fib_nl_newrule, NULL, 0);
-	rtnl_register(PF_UNSPEC, RTM_DELRULE, fib_nl_delrule, NULL, 0);
-	rtnl_register(PF_UNSPEC, RTM_GETRULE, NULL, fib_nl_dumprule,
-		      RTNL_FLAG_DUMP_UNLOCKED);
+
+	rtnl_register_many(fib_rules_rtnl_msg_handlers);
 
 	err = register_pernet_subsys(&fib_rules_net_ops);
 	if (err < 0)
@@ -1312,9 +1317,7 @@ static int __init fib_rules_init(void)
 fail_unregister:
 	unregister_pernet_subsys(&fib_rules_net_ops);
 fail:
-	rtnl_unregister(PF_UNSPEC, RTM_NEWRULE);
-	rtnl_unregister(PF_UNSPEC, RTM_DELRULE);
-	rtnl_unregister(PF_UNSPEC, RTM_GETRULE);
+	rtnl_unregister_many(fib_rules_rtnl_msg_handlers);
 	return err;
 }
 
diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
index 7c156f85b7d2..d81fff93d208 100644
--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -2797,6 +2797,16 @@ static struct rtnl_af_ops inet_af_ops __read_mostly = {
 	.set_link_af	  = inet_set_link_af,
 };
 
+static const struct rtnl_msg_handler devinet_rtnl_msg_handlers[] __initconst = {
+	{.protocol = PF_INET, .msgtype = RTM_NEWADDR, .doit = inet_rtm_newaddr},
+	{.protocol = PF_INET, .msgtype = RTM_DELADDR, .doit = inet_rtm_deladdr},
+	{.protocol = PF_INET, .msgtype = RTM_GETADDR, .dumpit = inet_dump_ifaddr,
+	 .flags = RTNL_FLAG_DUMP_UNLOCKED | RTNL_FLAG_DUMP_SPLIT_NLM_DONE},
+	{.protocol = PF_INET, .msgtype = RTM_GETNETCONF,
+	 .doit = inet_netconf_get_devconf, .dumpit = inet_netconf_dump_devconf,
+	 .flags = RTNL_FLAG_DOIT_UNLOCKED | RTNL_FLAG_DUMP_UNLOCKED},
+};
+
 void __init devinet_init(void)
 {
 	register_pernet_subsys(&devinet_ops);
@@ -2804,11 +2814,5 @@ void __init devinet_init(void)
 
 	rtnl_af_register(&inet_af_ops);
 
-	rtnl_register(PF_INET, RTM_NEWADDR, inet_rtm_newaddr, NULL, 0);
-	rtnl_register(PF_INET, RTM_DELADDR, inet_rtm_deladdr, NULL, 0);
-	rtnl_register(PF_INET, RTM_GETADDR, NULL, inet_dump_ifaddr,
-		      RTNL_FLAG_DUMP_UNLOCKED | RTNL_FLAG_DUMP_SPLIT_NLM_DONE);
-	rtnl_register(PF_INET, RTM_GETNETCONF, inet_netconf_get_devconf,
-		      inet_netconf_dump_devconf,
-		      RTNL_FLAG_DOIT_UNLOCKED | RTNL_FLAG_DUMP_UNLOCKED);
+	rtnl_register_many(devinet_rtnl_msg_handlers);
 }
diff --git a/net/ipv4/fib_frontend.c b/net/ipv4/fib_frontend.c
index 8353518b110a..53bd26315df5 100644
--- a/net/ipv4/fib_frontend.c
+++ b/net/ipv4/fib_frontend.c
@@ -1649,6 +1649,15 @@ static struct pernet_operations fib_net_ops = {
 	.exit_batch = fib_net_exit_batch,
 };
 
+static const struct rtnl_msg_handler fib_rtnl_msg_handlers[] __initconst = {
+	{.protocol = PF_INET, .msgtype = RTM_NEWROUTE,
+	 .doit = inet_rtm_newroute},
+	{.protocol = PF_INET, .msgtype = RTM_DELROUTE,
+	 .doit = inet_rtm_delroute},
+	{.protocol = PF_INET, .msgtype = RTM_GETROUTE, .dumpit = inet_dump_fib,
+	 .flags = RTNL_FLAG_DUMP_UNLOCKED | RTNL_FLAG_DUMP_SPLIT_NLM_DONE},
+};
+
 void __init ip_fib_init(void)
 {
 	fib_trie_init();
@@ -1658,8 +1667,5 @@ void __init ip_fib_init(void)
 	register_netdevice_notifier(&fib_netdev_notifier);
 	register_inetaddr_notifier(&fib_inetaddr_notifier);
 
-	rtnl_register(PF_INET, RTM_NEWROUTE, inet_rtm_newroute, NULL, 0);
-	rtnl_register(PF_INET, RTM_DELROUTE, inet_rtm_delroute, NULL, 0);
-	rtnl_register(PF_INET, RTM_GETROUTE, NULL, inet_dump_fib,
-		      RTNL_FLAG_DUMP_UNLOCKED | RTNL_FLAG_DUMP_SPLIT_NLM_DONE);
+	rtnl_register_many(fib_rtnl_msg_handlers);
 }
diff --git a/net/ipv4/nexthop.c b/net/ipv4/nexthop.c
index 93aaea0006ba..570e450e008c 100644
--- a/net/ipv4/nexthop.c
+++ b/net/ipv4/nexthop.c
@@ -4042,25 +4042,30 @@ static struct pernet_operations nexthop_net_ops = {
 	.exit_batch_rtnl = nexthop_net_exit_batch_rtnl,
 };
 
+static const struct rtnl_msg_handler nexthop_rtnl_msg_handlers[] __initconst = {
+	{.msgtype = RTM_NEWNEXTHOP, .doit = rtm_new_nexthop},
+	{.msgtype = RTM_DELNEXTHOP, .doit = rtm_del_nexthop},
+	{.msgtype = RTM_GETNEXTHOP, .doit = rtm_get_nexthop,
+	 .dumpit = rtm_dump_nexthop},
+	{.msgtype = RTM_GETNEXTHOPBUCKET, .doit = rtm_get_nexthop_bucket,
+	 .dumpit = rtm_dump_nexthop_bucket},
+	{.protocol = PF_INET, .msgtype = RTM_NEWNEXTHOP,
+	 .doit = rtm_new_nexthop},
+	{.protocol = PF_INET, .msgtype = RTM_GETNEXTHOP,
+	 .dumpit = rtm_dump_nexthop},
+	{.protocol = PF_INET6, .msgtype = RTM_NEWNEXTHOP,
+	 .doit = rtm_new_nexthop},
+	{.protocol = PF_INET6, .msgtype = RTM_GETNEXTHOP,
+	 .dumpit = rtm_dump_nexthop},
+};
+
 static int __init nexthop_init(void)
 {
 	register_pernet_subsys(&nexthop_net_ops);
 
 	register_netdevice_notifier(&nh_netdev_notifier);
 
-	rtnl_register(PF_UNSPEC, RTM_NEWNEXTHOP, rtm_new_nexthop, NULL, 0);
-	rtnl_register(PF_UNSPEC, RTM_DELNEXTHOP, rtm_del_nexthop, NULL, 0);
-	rtnl_register(PF_UNSPEC, RTM_GETNEXTHOP, rtm_get_nexthop,
-		      rtm_dump_nexthop, 0);
-
-	rtnl_register(PF_INET, RTM_NEWNEXTHOP, rtm_new_nexthop, NULL, 0);
-	rtnl_register(PF_INET, RTM_GETNEXTHOP, NULL, rtm_dump_nexthop, 0);
-
-	rtnl_register(PF_INET6, RTM_NEWNEXTHOP, rtm_new_nexthop, NULL, 0);
-	rtnl_register(PF_INET6, RTM_GETNEXTHOP, NULL, rtm_dump_nexthop, 0);
-
-	rtnl_register(PF_UNSPEC, RTM_GETNEXTHOPBUCKET, rtm_get_nexthop_bucket,
-		      rtm_dump_nexthop_bucket, 0);
+	rtnl_register_many(nexthop_rtnl_msg_handlers);
 
 	return 0;
 }
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index a0b091a7df87..18a08b4f4a5a 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -3632,6 +3632,11 @@ static __net_initdata struct pernet_operations ipv4_inetpeer_ops = {
 struct ip_rt_acct __percpu *ip_rt_acct __read_mostly;
 #endif /* CONFIG_IP_ROUTE_CLASSID */
 
+static const struct rtnl_msg_handler ip_rt_rtnl_msg_handlers[] __initconst = {
+	{.protocol = PF_INET, .msgtype = RTM_GETROUTE,
+	 .doit = inet_rtm_getroute, .flags = RTNL_FLAG_DOIT_UNLOCKED},
+};
+
 int __init ip_rt_init(void)
 {
 	void *idents_hash;
@@ -3689,8 +3694,7 @@ int __init ip_rt_init(void)
 	xfrm_init();
 	xfrm4_init();
 #endif
-	rtnl_register(PF_INET, RTM_GETROUTE, inet_rtm_getroute, NULL,
-		      RTNL_FLAG_DOIT_UNLOCKED);
+	rtnl_register_many(ip_rt_rtnl_msg_handlers);
 
 #ifdef CONFIG_SYSCTL
 	register_pernet_subsys(&sysctl_route_ops);
-- 
2.39.5 (Apple Git-154)



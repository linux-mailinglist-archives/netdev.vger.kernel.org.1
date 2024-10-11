Return-Path: <netdev+bounces-134711-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B006A99AE7F
	for <lists+netdev@lfdr.de>; Sat, 12 Oct 2024 00:08:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2DFBB20FA6
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 22:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EB391D1E77;
	Fri, 11 Oct 2024 22:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="ZCP9EEhg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993D71D1E72
	for <netdev@vger.kernel.org>; Fri, 11 Oct 2024 22:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728684500; cv=none; b=EVuaNXdsZvwXjpgdsQjg01zcUYSlsHvSj04yLzRjRuYE4Wqw/XvLzgcZVU/9Q1u/fuCrWAfHWQIC7n17C0nbtasiKDewx2j4NUS40Dmj85rw7cV61Gcqs10yGDao/OlOfxl4N3zGzVCik6XtvkzCKwnAD2YkApRlgXJYDxaKdHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728684500; c=relaxed/simple;
	bh=WerYwdF8Gng6/UmMi46Gs8wOYYFSWbUtgkp0TMmuAHk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rR5yOsF5PyBvgyZJXGljjqlKBD+afFI/CKgrmLyRaeHsvA9rpVwpTJnBR7irijcuVw5TpbpTaImmUwDxdEUggNOgs5sAleot6RUBqwJctaLeh2veRL+IPS1wlv8/tI3cxUH0RzxerzMxnla7Zedd9GVMVSy8N8bzurbfBA17LAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=ZCP9EEhg; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1728684498; x=1760220498;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PnX2Ej9DXFBwozAh09x4okxSb//MbK4jONEj+7BgoKE=;
  b=ZCP9EEhg5UdSjwjk9EDWNic8Wn2wXnkblVW7VQFef5REl9hbGO7oCxNM
   F9i/vzrvMWenvNFfiu96C+JkaQRX6FYQ696nxZaJHJhKdsjdUTLaR/0Us
   O52mbsbCws4Hp/y0Oh6yWnCXYfWnt5P5kxBlGwx3ISDMd0g7VuCT9UlDm
   g=;
X-IronPort-AV: E=Sophos;i="6.11,196,1725321600"; 
   d="scan'208";a="440211205"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 22:08:15 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.7.35:62265]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.7.250:2525] with esmtp (Farcaster)
 id da62d421-07ba-494c-a2ca-51c52adb2d98; Fri, 11 Oct 2024 22:08:14 +0000 (UTC)
X-Farcaster-Flow-ID: da62d421-07ba-494c-a2ca-51c52adb2d98
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 11 Oct 2024 22:08:13 +0000
Received: from 6c7e67c6786f.amazon.com (10.106.100.8) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Fri, 11 Oct 2024 22:08:11 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 07/11] ipv6: Use rtnl_register_many().
Date: Fri, 11 Oct 2024 15:05:46 -0700
Message-ID: <20241011220550.46040-8-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241011220550.46040-1-kuniyu@amazon.com>
References: <20241011220550.46040-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D039UWB001.ant.amazon.com (10.13.138.119) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

We will remove rtnl_register_module() in favour of rtnl_register_many().

rtnl_register_many() will unwind the previous successful registrations
on failure and simplify module error handling.

Let's use rtnl_register_many() instead.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/core/fib_rules.c | 24 ++++++++++++--------
 net/ipv6/addrconf.c  | 52 +++++++++++++++-----------------------------
 net/ipv6/addrlabel.c | 27 +++++++++--------------
 net/ipv6/ip6_fib.c   |  9 +++++---
 net/ipv6/route.c     | 21 +++++++-----------
 5 files changed, 57 insertions(+), 76 deletions(-)

diff --git a/net/core/fib_rules.c b/net/core/fib_rules.c
index 154a2681f55c..7ed6f9928604 100644
--- a/net/core/fib_rules.c
+++ b/net/core/fib_rules.c
@@ -1289,17 +1289,24 @@ static struct pernet_operations fib_rules_net_ops = {
 	.exit = fib_rules_net_exit,
 };
 
+static const struct rtnl_msg_handler fib_rules_rtnl_msg_handlers[] = {
+	{NULL, PF_UNSPEC, RTM_NEWRULE, fib_nl_newrule, NULL, 0},
+	{NULL, PF_UNSPEC, RTM_DELRULE, fib_nl_delrule, NULL, 0},
+	{NULL, PF_UNSPEC, RTM_GETRULE, NULL, fib_nl_dumprule,
+	 RTNL_FLAG_DUMP_UNLOCKED},
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
+	err = rtnl_register_many(fib_rules_rtnl_msg_handlers);
+	if (err)
+		goto fail_rtnl;
 
 	err = register_pernet_subsys(&fib_rules_net_ops);
 	if (err < 0)
-		goto fail;
+		goto fail_pernet;
 
 	err = register_netdevice_notifier(&fib_rules_notifier);
 	if (err < 0)
@@ -1309,10 +1316,9 @@ static int __init fib_rules_init(void)
 
 fail_unregister:
 	unregister_pernet_subsys(&fib_rules_net_ops);
-fail:
-	rtnl_unregister(PF_UNSPEC, RTM_NEWRULE);
-	rtnl_unregister(PF_UNSPEC, RTM_DELRULE);
-	rtnl_unregister(PF_UNSPEC, RTM_GETRULE);
+fail_pernet:
+	rtnl_unregister_many(fib_rules_rtnl_msg_handlers);
+fail_rtnl:
 	return err;
 }
 
diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index f31528d4f694..020519362b33 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -7406,6 +7406,22 @@ static struct rtnl_af_ops inet6_ops __read_mostly = {
 	.set_link_af	  = inet6_set_link_af,
 };
 
+static const struct rtnl_msg_handler addrconf_rtnl_msg_handlers[] = {
+	{THIS_MODULE, PF_INET6, RTM_GETLINK, NULL, inet6_dump_ifinfo,
+	 RTNL_FLAG_DUMP_UNLOCKED},
+	{THIS_MODULE, PF_INET6, RTM_NEWADDR, inet6_rtm_newaddr, NULL, 0},
+	{THIS_MODULE, PF_INET6, RTM_DELADDR, inet6_rtm_deladdr, NULL, 0},
+	{THIS_MODULE, PF_INET6, RTM_GETADDR, inet6_rtm_getaddr, inet6_dump_ifaddr,
+	 RTNL_FLAG_DOIT_UNLOCKED | RTNL_FLAG_DUMP_UNLOCKED},
+	{THIS_MODULE, PF_INET6, RTM_GETMULTICAST, NULL, inet6_dump_ifmcaddr,
+	 RTNL_FLAG_DUMP_UNLOCKED},
+	{THIS_MODULE, PF_INET6, RTM_GETANYCAST, NULL, inet6_dump_ifacaddr,
+	 RTNL_FLAG_DUMP_UNLOCKED},
+	{THIS_MODULE, PF_INET6, RTM_GETNETCONF,
+	 inet6_netconf_get_devconf, inet6_netconf_dump_devconf,
+	 RTNL_FLAG_DOIT_UNLOCKED | RTNL_FLAG_DUMP_UNLOCKED},
+};
+
 /*
  *	Init / cleanup code
  */
@@ -7449,42 +7465,10 @@ int __init addrconf_init(void)
 
 	rtnl_af_register(&inet6_ops);
 
-	err = rtnl_register_module(THIS_MODULE, PF_INET6, RTM_GETLINK,
-				   NULL, inet6_dump_ifinfo, RTNL_FLAG_DUMP_UNLOCKED);
-	if (err < 0)
+	err = rtnl_register_many(addrconf_rtnl_msg_handlers);
+	if (err)
 		goto errout;
 
-	err = rtnl_register_module(THIS_MODULE, PF_INET6, RTM_NEWADDR,
-				   inet6_rtm_newaddr, NULL, 0);
-	if (err < 0)
-		goto errout;
-	err = rtnl_register_module(THIS_MODULE, PF_INET6, RTM_DELADDR,
-				   inet6_rtm_deladdr, NULL, 0);
-	if (err < 0)
-		goto errout;
-	err = rtnl_register_module(THIS_MODULE, PF_INET6, RTM_GETADDR,
-				   inet6_rtm_getaddr, inet6_dump_ifaddr,
-				   RTNL_FLAG_DOIT_UNLOCKED |
-				   RTNL_FLAG_DUMP_UNLOCKED);
-	if (err < 0)
-		goto errout;
-	err = rtnl_register_module(THIS_MODULE, PF_INET6, RTM_GETMULTICAST,
-				   NULL, inet6_dump_ifmcaddr,
-				   RTNL_FLAG_DUMP_UNLOCKED);
-	if (err < 0)
-		goto errout;
-	err = rtnl_register_module(THIS_MODULE, PF_INET6, RTM_GETANYCAST,
-				   NULL, inet6_dump_ifacaddr,
-				   RTNL_FLAG_DUMP_UNLOCKED);
-	if (err < 0)
-		goto errout;
-	err = rtnl_register_module(THIS_MODULE, PF_INET6, RTM_GETNETCONF,
-				   inet6_netconf_get_devconf,
-				   inet6_netconf_dump_devconf,
-				   RTNL_FLAG_DOIT_UNLOCKED |
-				   RTNL_FLAG_DUMP_UNLOCKED);
-	if (err < 0)
-		goto errout;
 	err = ipv6_addr_label_rtnl_register();
 	if (err < 0)
 		goto errout;
diff --git a/net/ipv6/addrlabel.c b/net/ipv6/addrlabel.c
index acd70b5992a7..b31738761b0b 100644
--- a/net/ipv6/addrlabel.c
+++ b/net/ipv6/addrlabel.c
@@ -634,23 +634,16 @@ static int ip6addrlbl_get(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 	return err;
 }
 
+static const struct rtnl_msg_handler ipv6_adddr_label_rtnl_msg_handlers[] = {
+	{THIS_MODULE, PF_INET6, RTM_NEWADDRLABEL, ip6addrlbl_newdel, NULL,
+	 RTNL_FLAG_DOIT_UNLOCKED},
+	{THIS_MODULE, PF_INET6, RTM_DELADDRLABEL, ip6addrlbl_newdel, NULL,
+	 RTNL_FLAG_DOIT_UNLOCKED},
+	{THIS_MODULE, PF_INET6, RTM_GETADDRLABEL, ip6addrlbl_get, ip6addrlbl_dump,
+	 RTNL_FLAG_DOIT_UNLOCKED | RTNL_FLAG_DUMP_UNLOCKED},
+};
+
 int __init ipv6_addr_label_rtnl_register(void)
 {
-	int ret;
-
-	ret = rtnl_register_module(THIS_MODULE, PF_INET6, RTM_NEWADDRLABEL,
-				   ip6addrlbl_newdel,
-				   NULL, RTNL_FLAG_DOIT_UNLOCKED);
-	if (ret < 0)
-		return ret;
-	ret = rtnl_register_module(THIS_MODULE, PF_INET6, RTM_DELADDRLABEL,
-				   ip6addrlbl_newdel,
-				   NULL, RTNL_FLAG_DOIT_UNLOCKED);
-	if (ret < 0)
-		return ret;
-	ret = rtnl_register_module(THIS_MODULE, PF_INET6, RTM_GETADDRLABEL,
-				   ip6addrlbl_get,
-				   ip6addrlbl_dump, RTNL_FLAG_DOIT_UNLOCKED |
-						    RTNL_FLAG_DUMP_UNLOCKED);
-	return ret;
+	return rtnl_register_many(ipv6_adddr_label_rtnl_msg_handlers);
 }
diff --git a/net/ipv6/ip6_fib.c b/net/ipv6/ip6_fib.c
index eb111d20615c..b28259f23960 100644
--- a/net/ipv6/ip6_fib.c
+++ b/net/ipv6/ip6_fib.c
@@ -2500,6 +2500,11 @@ static struct pernet_operations fib6_net_ops = {
 	.exit = fib6_net_exit,
 };
 
+static const struct rtnl_msg_handler fib6_rtnl_msg_handlers[] = {
+	{THIS_MODULE, PF_INET6, RTM_GETROUTE, NULL, inet6_dump_fib,
+	 RTNL_FLAG_DUMP_UNLOCKED | RTNL_FLAG_DUMP_SPLIT_NLM_DONE},
+};
+
 int __init fib6_init(void)
 {
 	int ret = -ENOMEM;
@@ -2513,9 +2518,7 @@ int __init fib6_init(void)
 	if (ret)
 		goto out_kmem_cache_create;
 
-	ret = rtnl_register_module(THIS_MODULE, PF_INET6, RTM_GETROUTE, NULL,
-				   inet6_dump_fib, RTNL_FLAG_DUMP_UNLOCKED |
-				   RTNL_FLAG_DUMP_SPLIT_NLM_DONE);
+	ret = rtnl_register_many(fib6_rtnl_msg_handlers);
 	if (ret)
 		goto out_unregister_subsys;
 
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index b4251915585f..6f617c0f3db4 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -6680,6 +6680,13 @@ static void bpf_iter_unregister(void)
 #endif
 #endif
 
+static const struct rtnl_msg_handler ip6_route_rtnl_msg_handlers[] = {
+	{THIS_MODULE, PF_INET6, RTM_NEWROUTE, inet6_rtm_newroute, NULL, 0},
+	{THIS_MODULE, PF_INET6, RTM_DELROUTE, inet6_rtm_delroute, NULL, 0},
+	{THIS_MODULE, PF_INET6, RTM_GETROUTE, inet6_rtm_getroute, NULL,
+	 RTNL_FLAG_DOIT_UNLOCKED},
+};
+
 int __init ip6_route_init(void)
 {
 	int ret;
@@ -6722,19 +6729,7 @@ int __init ip6_route_init(void)
 	if (ret)
 		goto fib6_rules_init;
 
-	ret = rtnl_register_module(THIS_MODULE, PF_INET6, RTM_NEWROUTE,
-				   inet6_rtm_newroute, NULL, 0);
-	if (ret < 0)
-		goto out_register_late_subsys;
-
-	ret = rtnl_register_module(THIS_MODULE, PF_INET6, RTM_DELROUTE,
-				   inet6_rtm_delroute, NULL, 0);
-	if (ret < 0)
-		goto out_register_late_subsys;
-
-	ret = rtnl_register_module(THIS_MODULE, PF_INET6, RTM_GETROUTE,
-				   inet6_rtm_getroute, NULL,
-				   RTNL_FLAG_DOIT_UNLOCKED);
+	ret = rtnl_register_many(ip6_route_rtnl_msg_handlers);
 	if (ret < 0)
 		goto out_register_late_subsys;
 
-- 
2.39.5 (Apple Git-154)



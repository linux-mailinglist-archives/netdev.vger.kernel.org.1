Return-Path: <netdev+bounces-135305-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 994A499D815
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 22:21:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 113A2B20F06
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 20:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EFB51CDA0F;
	Mon, 14 Oct 2024 20:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="cWYLzWIR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B34155301
	for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 20:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728937261; cv=none; b=TegLD9uYLTXr8gLZ/jzKJUluVTFAU1MxGeI0CQztvTqenJqKq7+LE2LTOP7JJwMq3Rsd1/9OgBK48mnYGaxh8UoAiqKMehW7+ZvbjzX9agPbGmioaGMwwxw717PV0gjRooHwT4qJFkaJ+lPBF1olx94Q2rS/0V8Wv04Dhg42QZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728937261; c=relaxed/simple;
	bh=J5N+jKmw3iQJRF89iQxN8YIVQ8vXTqlUFjsnwnkugRA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kRZw6unTpPpgRq8IsD+4LwR2skYzaxU5jJNLmJy9W8bMi1zXiIdIo8/AGObPRO02UdamaNTMGa05ef7N00x/inr5hGpgPAPX5yvquPppd/S18of0NuSLErs20MSdFC2pkcB6AgDQGy0GGCR9oRsZwhhiFTywY3EIYpUOT7x/c+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=cWYLzWIR; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1728937260; x=1760473260;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=u8YQN9ecDwpE/fPC3BHHbfZaEwdbjuHkPYiFxCQ9Z+c=;
  b=cWYLzWIRHtD0gHjslPG/VcODp2Ko1aT2lz4QqrlJ06yVLqgn2SIdYUga
   TNJOzVkESQTiBAuaoR7t151rfXQm5g8ZINq8+FEHi2Nq81HKLDMAGEgu7
   /509Mb1Qa/wxit9YdWFCeKIKJvHsSXjRI4Vbtwmy9DQ1bOsZVb4ApWfwB
   s=;
X-IronPort-AV: E=Sophos;i="6.11,203,1725321600"; 
   d="scan'208";a="431390695"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2024 20:20:57 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.21.151:30505]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.38.26:2525] with esmtp (Farcaster)
 id e07eb4aa-6d3c-4763-bc3d-1d71670ea7c1; Mon, 14 Oct 2024 20:20:55 +0000 (UTC)
X-Farcaster-Flow-ID: e07eb4aa-6d3c-4763-bc3d-1d71670ea7c1
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 14 Oct 2024 20:20:54 +0000
Received: from 6c7e67c6786f.amazon.com (10.106.101.44) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Mon, 14 Oct 2024 20:20:52 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 07/11] ipv6: Use rtnl_register_many().
Date: Mon, 14 Oct 2024 13:18:24 -0700
Message-ID: <20241014201828.91221-8-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D031UWA004.ant.amazon.com (10.13.139.19) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

We will remove rtnl_register_module() in favour of rtnl_register_many().

rtnl_register_many() will unwind the previous successful registrations
on failure and simplify module error handling.

Let's use rtnl_register_many() instead.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
v2:
  * Add __initconst_or_module
  * Use C99 initialisation
---
 net/ipv6/addrconf.c  | 57 ++++++++++++++++++--------------------------
 net/ipv6/addrlabel.c | 28 +++++++++-------------
 net/ipv6/ip6_fib.c   | 10 +++++---
 net/ipv6/route.c     | 23 ++++++++----------
 4 files changed, 51 insertions(+), 67 deletions(-)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index f31528d4f694..ac8645ad2537 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -7406,6 +7406,27 @@ static struct rtnl_af_ops inet6_ops __read_mostly = {
 	.set_link_af	  = inet6_set_link_af,
 };
 
+static const struct rtnl_msg_handler addrconf_rtnl_msg_handlers[] __initconst_or_module = {
+	{.owner = THIS_MODULE, .protocol = PF_INET6, .msgtype = RTM_GETLINK,
+	 .dumpit = inet6_dump_ifinfo, .flags = RTNL_FLAG_DUMP_UNLOCKED},
+	{.owner = THIS_MODULE, .protocol = PF_INET6, .msgtype = RTM_NEWADDR,
+	 .doit = inet6_rtm_newaddr},
+	{.owner = THIS_MODULE, .protocol = PF_INET6, .msgtype = RTM_DELADDR,
+	 .doit = inet6_rtm_deladdr},
+	{.owner = THIS_MODULE, .protocol = PF_INET6, .msgtype = RTM_GETADDR,
+	 .doit = inet6_rtm_getaddr, .dumpit = inet6_dump_ifaddr,
+	 .flags = RTNL_FLAG_DOIT_UNLOCKED | RTNL_FLAG_DUMP_UNLOCKED},
+	{.owner = THIS_MODULE, .protocol = PF_INET6, .msgtype = RTM_GETMULTICAST,
+	 .dumpit = inet6_dump_ifmcaddr,
+	 .flags = RTNL_FLAG_DUMP_UNLOCKED},
+	{.owner = THIS_MODULE, .protocol = PF_INET6, .msgtype = RTM_GETANYCAST,
+	 .dumpit = inet6_dump_ifacaddr,
+	 .flags = RTNL_FLAG_DUMP_UNLOCKED},
+	{.owner = THIS_MODULE, .protocol = PF_INET6, .msgtype = RTM_GETNETCONF,
+	 .doit = inet6_netconf_get_devconf, .dumpit = inet6_netconf_dump_devconf,
+	 .flags = RTNL_FLAG_DOIT_UNLOCKED | RTNL_FLAG_DUMP_UNLOCKED},
+};
+
 /*
  *	Init / cleanup code
  */
@@ -7449,42 +7470,10 @@ int __init addrconf_init(void)
 
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
index acd70b5992a7..ab054f329e12 100644
--- a/net/ipv6/addrlabel.c
+++ b/net/ipv6/addrlabel.c
@@ -634,23 +634,17 @@ static int ip6addrlbl_get(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 	return err;
 }
 
+static const struct rtnl_msg_handler ipv6_adddr_label_rtnl_msg_handlers[] __initconst_or_module = {
+	{.owner = THIS_MODULE, .protocol = PF_INET6, .msgtype = RTM_NEWADDRLABEL,
+	 .doit = ip6addrlbl_newdel, .flags = RTNL_FLAG_DOIT_UNLOCKED},
+	{.owner = THIS_MODULE, .protocol = PF_INET6, .msgtype = RTM_DELADDRLABEL,
+	 .doit = ip6addrlbl_newdel, .flags = RTNL_FLAG_DOIT_UNLOCKED},
+	{.owner = THIS_MODULE, .protocol = PF_INET6, .msgtype = RTM_GETADDRLABEL,
+	 .doit = ip6addrlbl_get, .dumpit = ip6addrlbl_dump,
+	 .flags = RTNL_FLAG_DOIT_UNLOCKED | RTNL_FLAG_DUMP_UNLOCKED},
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
index cea160b249d2..823d9e151189 100644
--- a/net/ipv6/ip6_fib.c
+++ b/net/ipv6/ip6_fib.c
@@ -2500,6 +2500,12 @@ static struct pernet_operations fib6_net_ops = {
 	.exit = fib6_net_exit,
 };
 
+static const struct rtnl_msg_handler fib6_rtnl_msg_handlers[] __initconst_or_module = {
+	{.owner = THIS_MODULE, .protocol = PF_INET6, .msgtype = RTM_GETROUTE,
+	 .dumpit = inet6_dump_fib,
+	 .flags = RTNL_FLAG_DUMP_UNLOCKED | RTNL_FLAG_DUMP_SPLIT_NLM_DONE},
+};
+
 int __init fib6_init(void)
 {
 	int ret = -ENOMEM;
@@ -2513,9 +2519,7 @@ int __init fib6_init(void)
 	if (ret)
 		goto out_kmem_cache_create;
 
-	ret = rtnl_register_module(THIS_MODULE, PF_INET6, RTM_GETROUTE, NULL,
-				   inet6_dump_fib, RTNL_FLAG_DUMP_UNLOCKED |
-				   RTNL_FLAG_DUMP_SPLIT_NLM_DONE);
+	ret = rtnl_register_many(fib6_rtnl_msg_handlers);
 	if (ret)
 		goto out_unregister_subsys;
 
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index b4251915585f..d7ce5cf2017a 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -6680,6 +6680,15 @@ static void bpf_iter_unregister(void)
 #endif
 #endif
 
+static const struct rtnl_msg_handler ip6_route_rtnl_msg_handlers[] __initconst_or_module = {
+	{.owner = THIS_MODULE, .protocol = PF_INET6, .msgtype = RTM_NEWROUTE,
+	 .doit = inet6_rtm_newroute},
+	{.owner = THIS_MODULE, .protocol = PF_INET6, .msgtype = RTM_DELROUTE,
+	 .doit = inet6_rtm_delroute},
+	{.owner = THIS_MODULE, .protocol = PF_INET6, .msgtype = RTM_GETROUTE,
+	 .doit = inet6_rtm_getroute, .flags = RTNL_FLAG_DOIT_UNLOCKED},
+};
+
 int __init ip6_route_init(void)
 {
 	int ret;
@@ -6722,19 +6731,7 @@ int __init ip6_route_init(void)
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



Return-Path: <netdev+bounces-134710-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E148299AE7E
	for <lists+netdev@lfdr.de>; Sat, 12 Oct 2024 00:08:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EC74282D94
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 22:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63A831D1E77;
	Fri, 11 Oct 2024 22:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="DVNrmFW5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD761D173C
	for <netdev@vger.kernel.org>; Fri, 11 Oct 2024 22:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.190.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728684482; cv=none; b=Rh7wErl8A/5zJMXZTxrr/g7g/38Ohbsfr6BkF57vp8sb0crZ7oChKDnTYLOXrVIjBg9M64gvGHiGwPA0TCGk6sTAZ4hrI+YWPMoFXb6mNVrIno73OeeyqlbzvFpYoHliNM/criLkyIdCjMAaZvjH+wxve/6+ZlmoR1YJORJz+9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728684482; c=relaxed/simple;
	bh=0GcaaAMe/i7cDC6vmISzY1rkyV7/jpjS6SLlr7wRB68=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NwcRXwqVGz+vvP4hlgtf5bTmehrSCbuth7rOCOBxb5kzTZQ+rA8qw007R0gtCItg4E4pQKchgybj64qswQ4Kpb0e+CEyWRYY33ssI5h80N5e1aCt3iO5EQuadlPGHJGDP56a4I66wrpg46u970TUSeSE7gNPT8WpaCTtjopqMlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=DVNrmFW5; arc=none smtp.client-ip=207.171.190.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1728684481; x=1760220481;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=p4s3h+tQVXZuCDX6wRivIP0ooJ9EQAnBHclzNnlLV24=;
  b=DVNrmFW5Ok9FT6Jki/7rvwvT83GMHfWzKvpLuHH7H5WshYvJltbaLSQY
   iYJp+4AOjrZAoDrvNS5aPabX8/2xeyCeg02FhMnt/1EMSAhXKUAjtN8Im
   6NAonlv96k4IT5VnGSfzKDMn5Knv22iiTgGP/JsgTwe0lKAUNeKVumzGT
   M=;
X-IronPort-AV: E=Sophos;i="6.11,196,1725321600"; 
   d="scan'208";a="375475703"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 22:07:55 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.7.35:54424]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.7.250:2525] with esmtp (Farcaster)
 id c5b4a469-3ca6-4f97-9d86-9fd1e00d5538; Fri, 11 Oct 2024 22:07:54 +0000 (UTC)
X-Farcaster-Flow-ID: c5b4a469-3ca6-4f97-9d86-9fd1e00d5538
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 11 Oct 2024 22:07:54 +0000
Received: from 6c7e67c6786f.amazon.com (10.106.100.8) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Fri, 11 Oct 2024 22:07:51 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 06/11] ipv4: Use rtnl_register_many().
Date: Fri, 11 Oct 2024 15:05:45 -0700
Message-ID: <20241011220550.46040-7-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D040UWA002.ant.amazon.com (10.13.139.113) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

We will remove rtnl_register() in favour of rtnl_register_many().

When it succeeds, rtnl_register_many() guarantees all rtnetlink types
in the passed array are supported, and there is no chance that a part
of message types is not supported.

Let's use rtnl_register_many() instead.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/ipv4/devinet.c      | 18 +++++++++++-------
 net/ipv4/fib_frontend.c | 12 ++++++++----
 net/ipv4/nexthop.c      | 26 +++++++++++++-------------
 net/ipv4/route.c        |  8 ++++++--
 4 files changed, 38 insertions(+), 26 deletions(-)

diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
index 7c156f85b7d2..10119cc92a77 100644
--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -2797,6 +2797,16 @@ static struct rtnl_af_ops inet_af_ops __read_mostly = {
 	.set_link_af	  = inet_set_link_af,
 };
 
+static const struct rtnl_msg_handler devinet_rtnl_msg_handlers[] = {
+	{NULL, PF_INET, RTM_NEWADDR, inet_rtm_newaddr, NULL, 0},
+	{NULL, PF_INET, RTM_DELADDR, inet_rtm_deladdr, NULL, 0},
+	{NULL, PF_INET, RTM_GETADDR, NULL, inet_dump_ifaddr,
+	 RTNL_FLAG_DUMP_UNLOCKED | RTNL_FLAG_DUMP_SPLIT_NLM_DONE},
+	{NULL, PF_INET, RTM_GETNETCONF,
+	 inet_netconf_get_devconf, inet_netconf_dump_devconf,
+	 RTNL_FLAG_DOIT_UNLOCKED | RTNL_FLAG_DUMP_UNLOCKED},
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
index 8353518b110a..f710cb99df02 100644
--- a/net/ipv4/fib_frontend.c
+++ b/net/ipv4/fib_frontend.c
@@ -1649,6 +1649,13 @@ static struct pernet_operations fib_net_ops = {
 	.exit_batch = fib_net_exit_batch,
 };
 
+static const struct rtnl_msg_handler fib_rtnl_msg_handlers[] = {
+	{NULL, PF_INET, RTM_NEWROUTE, inet_rtm_newroute, NULL, 0},
+	{NULL, PF_INET, RTM_DELROUTE, inet_rtm_delroute, NULL, 0},
+	{NULL, PF_INET, RTM_GETROUTE, NULL, inet_dump_fib,
+	 RTNL_FLAG_DUMP_UNLOCKED | RTNL_FLAG_DUMP_SPLIT_NLM_DONE},
+};
+
 void __init ip_fib_init(void)
 {
 	fib_trie_init();
@@ -1658,8 +1665,5 @@ void __init ip_fib_init(void)
 	register_netdevice_notifier(&fib_netdev_notifier);
 	register_inetaddr_notifier(&fib_inetaddr_notifier);
 
-	rtnl_register(PF_INET, RTM_NEWROUTE, inet_rtm_newroute, NULL, 0);
-	rtnl_register(PF_INET, RTM_DELROUTE, inet_rtm_delroute, NULL, 0);
-	rtnl_register(PF_INET, RTM_GETROUTE, NULL, inet_dump_fib,
-		      RTNL_FLAG_DUMP_UNLOCKED | RTNL_FLAG_DUMP_SPLIT_NLM_DONE);
+	rtnl_register_many(fib_rtnl_msg_handlers);
 }
diff --git a/net/ipv4/nexthop.c b/net/ipv4/nexthop.c
index 93aaea0006ba..925602f722fc 100644
--- a/net/ipv4/nexthop.c
+++ b/net/ipv4/nexthop.c
@@ -4042,25 +4042,25 @@ static struct pernet_operations nexthop_net_ops = {
 	.exit_batch_rtnl = nexthop_net_exit_batch_rtnl,
 };
 
+static const struct rtnl_msg_handler nexthop_rtnl_msg_handlers[] = {
+	{NULL, PF_UNSPEC, RTM_NEWNEXTHOP, rtm_new_nexthop, NULL, 0},
+	{NULL, PF_UNSPEC, RTM_DELNEXTHOP, rtm_del_nexthop, NULL, 0},
+	{NULL, PF_UNSPEC, RTM_GETNEXTHOP, rtm_get_nexthop, rtm_dump_nexthop, 0},
+	{NULL, PF_UNSPEC, RTM_GETNEXTHOPBUCKET,
+	 rtm_get_nexthop_bucket, rtm_dump_nexthop_bucket, 0},
+	{NULL, PF_INET, RTM_NEWNEXTHOP, rtm_new_nexthop, NULL, 0},
+	{NULL, PF_INET, RTM_GETNEXTHOP, NULL, rtm_dump_nexthop, 0},
+	{NULL, PF_INET6, RTM_NEWNEXTHOP, rtm_new_nexthop, NULL, 0},
+	{NULL, PF_INET6, RTM_GETNEXTHOP, NULL, rtm_dump_nexthop, 0},
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
index a0b091a7df87..63269870b6fc 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -3632,6 +3632,11 @@ static __net_initdata struct pernet_operations ipv4_inetpeer_ops = {
 struct ip_rt_acct __percpu *ip_rt_acct __read_mostly;
 #endif /* CONFIG_IP_ROUTE_CLASSID */
 
+static const struct rtnl_msg_handler ip_rt_rtnl_msg_handlers[] = {
+	{NULL, PF_INET, RTM_GETROUTE, inet_rtm_getroute, NULL,
+	 RTNL_FLAG_DOIT_UNLOCKED},
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



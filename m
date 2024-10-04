Return-Path: <netdev+bounces-132266-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4654899124D
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 00:25:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0716D280DA0
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 22:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B76B140E34;
	Fri,  4 Oct 2024 22:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="G2mnhViZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7908E1AE016
	for <netdev@vger.kernel.org>; Fri,  4 Oct 2024 22:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728080752; cv=none; b=TtMEcUHPF/oAu6NEFU/3Q6kUk0M3/SQtVWioMZ+b7feTFbKfQ/In4Prol5D9H2+RS5xrP+DUmvpWjYH4bYofgGNuB2HVJM/RQV/NEJbUPRyKle0Z+bqYOWnzYfiLMFlsWJglCarecTLu57t7Hx3+EMiO+NmqPTEahUspG5pHXVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728080752; c=relaxed/simple;
	bh=xK5EJIXdG1+AkpIH88womkiriYhcbPsU2HBPSRxuDFk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rLxhG99XinJF22bCiuJ1PBFad4ee6h/iJjcIytxnXtyqbPPZn0q0Ps04fyE/qUze/7Qjr6SvF/2/FjLJ8tqg29gbQvEoehMEEy47bv1UlEEyCIJM2yixTcAUr2652Y07uZeY+t+mYWET+wi6pdZEME/PjEKbEa7v5fsj4APi908=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=G2mnhViZ; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1728080751; x=1759616751;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XkT8Ca7ats+yvzh1zsTnkwh6q4fxqQZOVVnE/iXA4g4=;
  b=G2mnhViZmfJtyV7kKwlmZXLk5PvA2gjYbD4lPpqlsNgqCZQlxumGhL5D
   GMmNIE5N/kCfaZd28lZuJvdkD+sJRB6kPzXITT4INOBSDdwrfpaxELok8
   xijWzwcS31wLJgXRGHJXsIBZ0D30A9PYaDtf9xhrhpQP4cwF1tNsD+XQF
   c=;
X-IronPort-AV: E=Sophos;i="6.11,178,1725321600"; 
   d="scan'208";a="663831048"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2024 22:25:49 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.38.20:32230]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.6.41:2525] with esmtp (Farcaster)
 id 4204bda0-e04c-4044-84cb-bd97cf9ec285; Fri, 4 Oct 2024 22:25:48 +0000 (UTC)
X-Farcaster-Flow-ID: 4204bda0-e04c-4044-84cb-bd97cf9ec285
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 4 Oct 2024 22:25:46 +0000
Received: from 88665a182662.ant.amazon.com (10.88.184.239) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Fri, 4 Oct 2024 22:25:44 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>, Jeremy Kerr
	<jk@codeconstruct.com.au>, Matt Johnston <matt@codeconstruct.com.au>
Subject: [PATCH v2 net 4/6] mctp: Handle error of rtnl_register_module().
Date: Fri, 4 Oct 2024 15:23:56 -0700
Message-ID: <20241004222358.79129-5-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20241004222358.79129-1-kuniyu@amazon.com>
References: <20241004222358.79129-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D042UWA001.ant.amazon.com (10.13.139.92) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Since introduced, mctp has been ignoring the returned value
of rtnl_register_module(), which could fail.

Let's handle the errors by rtnl_register_module_many().

Fixes: 583be982d934 ("mctp: Add device handling and netlink interface")
Fixes: 831119f88781 ("mctp: Add neighbour netlink interface")
Fixes: 06d2f4c583a7 ("mctp: Add netlink route management")
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
Cc: Jeremy Kerr <jk@codeconstruct.com.au>
Cc: Matt Johnston <matt@codeconstruct.com.au>
---
 include/net/mctp.h |  2 +-
 net/mctp/af_mctp.c |  6 +++++-
 net/mctp/device.c  | 30 ++++++++++++++++++------------
 net/mctp/neigh.c   | 31 +++++++++++++++++++------------
 net/mctp/route.c   | 34 ++++++++++++++++++++++++----------
 5 files changed, 67 insertions(+), 36 deletions(-)

diff --git a/include/net/mctp.h b/include/net/mctp.h
index 7b17c52e8ce2..28d59ae94ca3 100644
--- a/include/net/mctp.h
+++ b/include/net/mctp.h
@@ -295,7 +295,7 @@ void mctp_neigh_remove_dev(struct mctp_dev *mdev);
 int mctp_routes_init(void);
 void mctp_routes_exit(void);
 
-void mctp_device_init(void);
+int mctp_device_init(void);
 void mctp_device_exit(void);
 
 #endif /* __NET_MCTP_H */
diff --git a/net/mctp/af_mctp.c b/net/mctp/af_mctp.c
index 43288b408fde..f6de136008f6 100644
--- a/net/mctp/af_mctp.c
+++ b/net/mctp/af_mctp.c
@@ -756,10 +756,14 @@ static __init int mctp_init(void)
 	if (rc)
 		goto err_unreg_routes;
 
-	mctp_device_init();
+	rc = mctp_device_init();
+	if (rc)
+		goto err_unreg_neigh;
 
 	return 0;
 
+err_unreg_neigh:
+	mctp_neigh_exit();
 err_unreg_routes:
 	mctp_routes_exit();
 err_unreg_proto:
diff --git a/net/mctp/device.c b/net/mctp/device.c
index acb97b257428..d70e688ac886 100644
--- a/net/mctp/device.c
+++ b/net/mctp/device.c
@@ -524,25 +524,31 @@ static struct notifier_block mctp_dev_nb = {
 	.priority = ADDRCONF_NOTIFY_PRIORITY,
 };
 
-void __init mctp_device_init(void)
+static struct rtnl_msg_handler mctp_device_rtnl_msg_handlers[] = {
+	{PF_MCTP, RTM_NEWADDR, mctp_rtm_newaddr, NULL, 0},
+	{PF_MCTP, RTM_DELADDR, mctp_rtm_deladdr, NULL, 0},
+	{PF_MCTP, RTM_GETADDR, NULL, mctp_dump_addrinfo, 0},
+};
+
+int __init mctp_device_init(void)
 {
-	register_netdevice_notifier(&mctp_dev_nb);
+	int err;
 
-	rtnl_register_module(THIS_MODULE, PF_MCTP, RTM_GETADDR,
-			     NULL, mctp_dump_addrinfo, 0);
-	rtnl_register_module(THIS_MODULE, PF_MCTP, RTM_NEWADDR,
-			     mctp_rtm_newaddr, NULL, 0);
-	rtnl_register_module(THIS_MODULE, PF_MCTP, RTM_DELADDR,
-			     mctp_rtm_deladdr, NULL, 0);
+	register_netdevice_notifier(&mctp_dev_nb);
 	rtnl_af_register(&mctp_af_ops);
+
+	err = rtnl_register_module_many(mctp_device_rtnl_msg_handlers);
+	if (err) {
+		rtnl_af_unregister(&mctp_af_ops);
+		unregister_netdevice_notifier(&mctp_dev_nb);
+	}
+
+	return err;
 }
 
 void __exit mctp_device_exit(void)
 {
+	rtnl_unregister_many(mctp_device_rtnl_msg_handlers);
 	rtnl_af_unregister(&mctp_af_ops);
-	rtnl_unregister(PF_MCTP, RTM_DELADDR);
-	rtnl_unregister(PF_MCTP, RTM_NEWADDR);
-	rtnl_unregister(PF_MCTP, RTM_GETADDR);
-
 	unregister_netdevice_notifier(&mctp_dev_nb);
 }
diff --git a/net/mctp/neigh.c b/net/mctp/neigh.c
index ffa0f9e0983f..245f8242929b 100644
--- a/net/mctp/neigh.c
+++ b/net/mctp/neigh.c
@@ -322,22 +322,29 @@ static struct pernet_operations mctp_net_ops = {
 	.exit = mctp_neigh_net_exit,
 };
 
+static struct rtnl_msg_handler mctp_neigh_rtnl_msg_handlers[] = {
+	{PF_MCTP, RTM_NEWNEIGH, mctp_rtm_newneigh, NULL, 0},
+	{PF_MCTP, RTM_DELNEIGH, mctp_rtm_delneigh, NULL, 0},
+	{PF_MCTP, RTM_GETNEIGH, NULL, mctp_rtm_getneigh, 0},
+};
+
 int __init mctp_neigh_init(void)
 {
-	rtnl_register_module(THIS_MODULE, PF_MCTP, RTM_NEWNEIGH,
-			     mctp_rtm_newneigh, NULL, 0);
-	rtnl_register_module(THIS_MODULE, PF_MCTP, RTM_DELNEIGH,
-			     mctp_rtm_delneigh, NULL, 0);
-	rtnl_register_module(THIS_MODULE, PF_MCTP, RTM_GETNEIGH,
-			     NULL, mctp_rtm_getneigh, 0);
-
-	return register_pernet_subsys(&mctp_net_ops);
+	int err;
+
+	err = register_pernet_subsys(&mctp_net_ops);
+	if (err)
+		return err;
+
+	err = rtnl_register_module_many(mctp_neigh_rtnl_msg_handlers);
+	if (err)
+		unregister_pernet_subsys(&mctp_net_ops);
+
+	return err;
 }
 
-void __exit mctp_neigh_exit(void)
+void mctp_neigh_exit(void)
 {
+	rtnl_unregister_many(mctp_neigh_rtnl_msg_handlers);
 	unregister_pernet_subsys(&mctp_net_ops);
-	rtnl_unregister(PF_MCTP, RTM_GETNEIGH);
-	rtnl_unregister(PF_MCTP, RTM_DELNEIGH);
-	rtnl_unregister(PF_MCTP, RTM_NEWNEIGH);
 }
diff --git a/net/mctp/route.c b/net/mctp/route.c
index eefd7834d9a0..083f9933eb81 100644
--- a/net/mctp/route.c
+++ b/net/mctp/route.c
@@ -1474,26 +1474,40 @@ static struct pernet_operations mctp_net_ops = {
 	.exit = mctp_routes_net_exit,
 };
 
+static struct rtnl_msg_handler mctp_route_rtnl_msg_handlers[] = {
+	{PF_MCTP, RTM_NEWROUTE, mctp_newroute, NULL, 0},
+	{PF_MCTP, RTM_DELROUTE, mctp_delroute, NULL, 0},
+	{PF_MCTP, RTM_GETROUTE, NULL, mctp_dump_rtinfo, 0},
+};
+
 int __init mctp_routes_init(void)
 {
+	int err;
+
 	dev_add_pack(&mctp_packet_type);
 
-	rtnl_register_module(THIS_MODULE, PF_MCTP, RTM_GETROUTE,
-			     NULL, mctp_dump_rtinfo, 0);
-	rtnl_register_module(THIS_MODULE, PF_MCTP, RTM_NEWROUTE,
-			     mctp_newroute, NULL, 0);
-	rtnl_register_module(THIS_MODULE, PF_MCTP, RTM_DELROUTE,
-			     mctp_delroute, NULL, 0);
+	err = register_pernet_subsys(&mctp_net_ops);
+	if (err)
+		goto fail_pernet;
+
+	err = rtnl_register_module_many(mctp_route_rtnl_msg_handlers);
+	if (err)
+		goto fail_rtnl;
 
-	return register_pernet_subsys(&mctp_net_ops);
+out:
+	return err;
+
+fail_rtnl:
+	unregister_pernet_subsys(&mctp_net_ops);
+fail_pernet:
+	dev_remove_pack(&mctp_packet_type);
+	goto out;
 }
 
 void mctp_routes_exit(void)
 {
+	rtnl_unregister_many(mctp_route_rtnl_msg_handlers);
 	unregister_pernet_subsys(&mctp_net_ops);
-	rtnl_unregister(PF_MCTP, RTM_DELROUTE);
-	rtnl_unregister(PF_MCTP, RTM_NEWROUTE);
-	rtnl_unregister(PF_MCTP, RTM_GETROUTE);
 	dev_remove_pack(&mctp_packet_type);
 }
 
-- 
2.30.2



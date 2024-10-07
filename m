Return-Path: <netdev+bounces-132685-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 979E5992C55
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 14:48:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 550F0282D1B
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 12:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B93D61D435F;
	Mon,  7 Oct 2024 12:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="JD9FrxIl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177C41D434D
	for <netdev@vger.kernel.org>; Mon,  7 Oct 2024 12:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728305216; cv=none; b=QRQU3ECiK7+JXoUpJspkYayuFOw4AJzxgJHVbTFNen6lVXhoYqoxqbkdh5zGuE6WB2XFy5j79DK1g6y4Ec+g6ZehmThD/OjMwi0k/z3CSC0ACWeejeRH7S3BxFO9RkZ6+WO6sd7Kfo52jz12flp1A18M38VHw7xALT/vUloqW58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728305216; c=relaxed/simple;
	bh=7hbP2/0Xfm7JF0AULsAnv9+f0n2Fhqidu0dOJTUn4rI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gkY3tkWMXmKePBqbmFcT8OZ6kaAZvOigi4xeOeUREl62KUFepi0E5PpejIMUcgQq3AJX6Rexx4tX7qhw28ODOXwPKkEbC3Y/mNKx4yEgcfDJIaSgckZRQ/fPrA+fyZSfpEhcG7N6BKKGinPq/ragCgR19evioZhutWEu6MwgYF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=JD9FrxIl; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1728305215; x=1759841215;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tA+vr/LTHe7jyAr8RXf9sKkXnIu94nGIjkruWS0sCAc=;
  b=JD9FrxIlEUm2irZ/yvRftGBm2QIh6BccxaWtfzg1MYTzVeRQYxyPeCkU
   UzNdb6ppMFXNAcutAcbkCc7lKKhiIT6R5fMORNwGilHkmrN2edpEIsDuo
   W+I8cDt0se5j8wJiDEutzv9hyzAT1teHtpNySBZwIBpC3gDXq0gz1a+kN
   g=;
X-IronPort-AV: E=Sophos;i="6.11,184,1725321600"; 
   d="scan'208";a="135637416"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 12:46:50 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:18302]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.25.223:2525] with esmtp (Farcaster)
 id 67e98ff5-2d77-4262-962a-416155741e58; Mon, 7 Oct 2024 12:46:50 +0000 (UTC)
X-Farcaster-Flow-ID: 67e98ff5-2d77-4262-962a-416155741e58
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 7 Oct 2024 12:46:49 +0000
Received: from 88665a182662.ant.amazon.com (10.119.221.239) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Mon, 7 Oct 2024 12:46:47 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>, Jeremy Kerr
	<jk@codeconstruct.com.au>, Matt Johnston <matt@codeconstruct.com.au>
Subject: [PATCH v3 net 4/6] mctp: Handle error of rtnl_register_module().
Date: Mon, 7 Oct 2024 05:44:57 -0700
Message-ID: <20241007124459.5727-5-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20241007124459.5727-1-kuniyu@amazon.com>
References: <20241007124459.5727-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D036UWC002.ant.amazon.com (10.13.139.242) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Since introduced, mctp has been ignoring the returned value
of rtnl_register_module(), which could fail.

Let's handle the errors by rtnl_register_many().

Fixes: 583be982d934 ("mctp: Add device handling and netlink interface")
Fixes: 831119f88781 ("mctp: Add neighbour netlink interface")
Fixes: 06d2f4c583a7 ("mctp: Add netlink route management")
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: Jeremy Kerr <jk@codeconstruct.com.au>
---
Cc: Matt Johnston <matt@codeconstruct.com.au>
---
 include/net/mctp.h |  2 +-
 net/mctp/af_mctp.c |  6 +++++-
 net/mctp/device.c  | 30 ++++++++++++++++++------------
 net/mctp/neigh.c   | 31 +++++++++++++++++++------------
 net/mctp/route.c   | 33 +++++++++++++++++++++++----------
 5 files changed, 66 insertions(+), 36 deletions(-)

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
index acb97b257428..85cc5f31f1e7 100644
--- a/net/mctp/device.c
+++ b/net/mctp/device.c
@@ -524,25 +524,31 @@ static struct notifier_block mctp_dev_nb = {
 	.priority = ADDRCONF_NOTIFY_PRIORITY,
 };
 
-void __init mctp_device_init(void)
+static const struct rtnl_msg_handler mctp_device_rtnl_msg_handlers[] = {
+	{THIS_MODULE, PF_MCTP, RTM_NEWADDR, mctp_rtm_newaddr, NULL, 0},
+	{THIS_MODULE, PF_MCTP, RTM_DELADDR, mctp_rtm_deladdr, NULL, 0},
+	{THIS_MODULE, PF_MCTP, RTM_GETADDR, NULL, mctp_dump_addrinfo, 0},
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
+	err = rtnl_register_many(mctp_device_rtnl_msg_handlers);
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
index ffa0f9e0983f..590f642413e4 100644
--- a/net/mctp/neigh.c
+++ b/net/mctp/neigh.c
@@ -322,22 +322,29 @@ static struct pernet_operations mctp_net_ops = {
 	.exit = mctp_neigh_net_exit,
 };
 
+static const struct rtnl_msg_handler mctp_neigh_rtnl_msg_handlers[] = {
+	{THIS_MODULE, PF_MCTP, RTM_NEWNEIGH, mctp_rtm_newneigh, NULL, 0},
+	{THIS_MODULE, PF_MCTP, RTM_DELNEIGH, mctp_rtm_delneigh, NULL, 0},
+	{THIS_MODULE, PF_MCTP, RTM_GETNEIGH, NULL, mctp_rtm_getneigh, 0},
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
+	err = rtnl_register_many(mctp_neigh_rtnl_msg_handlers);
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
index eefd7834d9a0..597e9cf5aa64 100644
--- a/net/mctp/route.c
+++ b/net/mctp/route.c
@@ -1474,26 +1474,39 @@ static struct pernet_operations mctp_net_ops = {
 	.exit = mctp_routes_net_exit,
 };
 
+static const struct rtnl_msg_handler mctp_route_rtnl_msg_handlers[] = {
+	{THIS_MODULE, PF_MCTP, RTM_NEWROUTE, mctp_newroute, NULL, 0},
+	{THIS_MODULE, PF_MCTP, RTM_DELROUTE, mctp_delroute, NULL, 0},
+	{THIS_MODULE, PF_MCTP, RTM_GETROUTE, NULL, mctp_dump_rtinfo, 0},
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
+		goto err_pernet;
+
+	err = rtnl_register_many(mctp_route_rtnl_msg_handlers);
+	if (err)
+		goto err_rtnl;
 
-	return register_pernet_subsys(&mctp_net_ops);
+	return 0;
+
+err_rtnl:
+	unregister_pernet_subsys(&mctp_net_ops);
+err_pernet:
+	dev_remove_pack(&mctp_packet_type);
+	return err;
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



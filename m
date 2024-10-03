Return-Path: <netdev+bounces-131774-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A766998F859
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 22:59:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B41B1F220C9
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 20:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1ABB1AC884;
	Thu,  3 Oct 2024 20:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Rx3JIR47"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C422F1AC429
	for <netdev@vger.kernel.org>; Thu,  3 Oct 2024 20:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727989162; cv=none; b=FAbEBW0hrILawp8hmUXdNChKIRGzPWRz10ItT2f0nfOynLbzZ4SoPSTPGkY70CGbTGI27WYmSktgZNqnCr8RgXMTQo3wJnoRGcdJXBQJpi9YaR3J+L7u/idAdupBnDbfjOuy9/iGgIAuWrk5AxQ1y3SXXRLyNlpMcteSvilvNYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727989162; c=relaxed/simple;
	bh=Qu9zRBOtnwRVJJEsiHoN/Iu/t9pJpYvC9pKE9q8YJyM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mLveqk82xkU43LfRQvGod5W0tLzPl+HxhJEeeiJ0NdpWOd8p63Q6yT2RGwPUXLSwmBL+qIoXhL4WwhBVqZoErBTuuE8czQ2G2Ct24wyLRYF3RAVzxpD0oWKNQYxi20d7BrjVNv0KEIa43FC4rwJZ/SvbNdMDwcTeyTB2qOmFbw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Rx3JIR47; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1727989161; x=1759525161;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vPXwzzinDqB7NbJ4oGcDXrMVUaz2wCkAuVWcJTktmH4=;
  b=Rx3JIR47lD0IyPzwMsAKJ4Z2WO02jE1QJdmwibr+Ez6YOaPVFO+rDz9G
   6pkJng4EBqJi3/8mexT3rPV/AosWSLqmXSBYSnzgZfVyj+c/2LwaAVf7I
   fQrwy9TvMmJQUdccj688Nfbzk5c7Hthrxj3cB26R/IKq8nKoIUuiJuscV
   o=;
X-IronPort-AV: E=Sophos;i="6.11,175,1725321600"; 
   d="scan'208";a="428681691"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2024 20:59:17 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.7.35:8650]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.4.107:2525] with esmtp (Farcaster)
 id 632f0500-25a2-4d4c-bbc6-5af16630b27c; Thu, 3 Oct 2024 20:59:16 +0000 (UTC)
X-Farcaster-Flow-ID: 632f0500-25a2-4d4c-bbc6-5af16630b27c
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Thu, 3 Oct 2024 20:59:15 +0000
Received: from 88665a182662.ant.amazon.com (10.187.171.32) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Thu, 3 Oct 2024 20:59:12 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>, Jeremy Kerr
	<jk@codeconstruct.com.au>, Matt Johnston <matt@codeconstruct.com.au>
Subject: [PATCH v1 net 4/6] mctp: Handle error of rtnl_register_module().
Date: Thu, 3 Oct 2024 13:57:23 -0700
Message-ID: <20241003205725.5612-5-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20241003205725.5612-1-kuniyu@amazon.com>
References: <20241003205725.5612-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D046UWA001.ant.amazon.com (10.13.139.112) To
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
 net/mctp/neigh.c   | 29 ++++++++++++++++++-----------
 net/mctp/route.c   | 34 ++++++++++++++++++++++++----------
 5 files changed, 66 insertions(+), 35 deletions(-)

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
index acb97b257428..3e5cfe119519 100644
--- a/net/mctp/device.c
+++ b/net/mctp/device.c
@@ -524,25 +524,31 @@ static struct notifier_block mctp_dev_nb = {
 	.priority = ADDRCONF_NOTIFY_PRIORITY,
 };
 
-void __init mctp_device_init(void)
+static struct rtnl_msg_handler mctp_rtnl_addr_msg_handlers[] = {
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
+	err = rtnl_register_module_many(mctp_rtnl_addr_msg_handlers);
+	if (err) {
+		rtnl_af_unregister(&mctp_af_ops);
+		unregister_netdevice_notifier(&mctp_dev_nb);
+	}
+
+	return err;
 }
 
 void __exit mctp_device_exit(void)
 {
+	rtnl_unregister_many(mctp_rtnl_addr_msg_handlers);
 	rtnl_af_unregister(&mctp_af_ops);
-	rtnl_unregister(PF_MCTP, RTM_DELADDR);
-	rtnl_unregister(PF_MCTP, RTM_NEWADDR);
-	rtnl_unregister(PF_MCTP, RTM_GETADDR);
-
 	unregister_netdevice_notifier(&mctp_dev_nb);
 }
diff --git a/net/mctp/neigh.c b/net/mctp/neigh.c
index ffa0f9e0983f..6bcdae3c53b2 100644
--- a/net/mctp/neigh.c
+++ b/net/mctp/neigh.c
@@ -322,22 +322,29 @@ static struct pernet_operations mctp_net_ops = {
 	.exit = mctp_neigh_net_exit,
 };
 
+static struct rtnl_msg_handler mctp_rtnl_neigh_msg_handlers[] = {
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
+	err = rtnl_register_module_many(mctp_rtnl_neigh_msg_handlers);
+	if (err)
+		return err;
+
+	err = register_pernet_subsys(&mctp_net_ops);
+	if (err)
+		rtnl_unregister_many(mctp_rtnl_neigh_msg_handlers);
+
+	return err;
 }
 
 void __exit mctp_neigh_exit(void)
 {
 	unregister_pernet_subsys(&mctp_net_ops);
-	rtnl_unregister(PF_MCTP, RTM_GETNEIGH);
-	rtnl_unregister(PF_MCTP, RTM_DELNEIGH);
-	rtnl_unregister(PF_MCTP, RTM_NEWNEIGH);
+	rtnl_unregister_many(mctp_rtnl_neigh_msg_handlers);
 }
diff --git a/net/mctp/route.c b/net/mctp/route.c
index eefd7834d9a0..88ac6feb4e22 100644
--- a/net/mctp/route.c
+++ b/net/mctp/route.c
@@ -1474,26 +1474,40 @@ static struct pernet_operations mctp_net_ops = {
 	.exit = mctp_routes_net_exit,
 };
 
+static struct rtnl_msg_handler mctp_rtnl_route_msg_handlers[] = {
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
+	err = rtnl_register_module_many(mctp_rtnl_route_msg_handlers);
+	if (err)
+		goto fail_rtnl;
+
+	err = register_pernet_subsys(&mctp_net_ops);
+	if (err)
+		goto fail_pernet;
 
-	return register_pernet_subsys(&mctp_net_ops);
+out:
+	return err;
+
+fail_pernet:
+	rtnl_unregister_many(mctp_rtnl_route_msg_handlers);
+fail_rtnl:
+	dev_remove_pack(&mctp_packet_type);
+	goto out;
 }
 
 void mctp_routes_exit(void)
 {
 	unregister_pernet_subsys(&mctp_net_ops);
-	rtnl_unregister(PF_MCTP, RTM_DELROUTE);
-	rtnl_unregister(PF_MCTP, RTM_NEWROUTE);
-	rtnl_unregister(PF_MCTP, RTM_GETROUTE);
+	rtnl_unregister_many(mctp_rtnl_route_msg_handlers);
 	dev_remove_pack(&mctp_packet_type);
 }
 
-- 
2.30.2



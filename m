Return-Path: <netdev+bounces-133282-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D2E99571F
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 20:49:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEDB41F283E3
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 18:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8EEB212D1B;
	Tue,  8 Oct 2024 18:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="t6niCDO7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11FC821263C
	for <netdev@vger.kernel.org>; Tue,  8 Oct 2024 18:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728413370; cv=none; b=kzcXJrYOsBtdiaMsC1lhqpT6Zj+5hA+Z+cn+6arQ4NsGLXxOruItoCrWW3Gn5B96pOrWrd1gZyv0ToezbnGaGFEHQaqn6nafEvBXYet1Te20VQP8PRgu75HTVXGjMNPkTWZVstXhwc5gBz8SkAnbEVVbmWbgvze/fSuB5nH+hc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728413370; c=relaxed/simple;
	bh=VQhSGzCB3TkLgxGI0mv84+/ltM6ENsoLGh5bMq50wUk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Uqpn9hxxRBlNLBa5igWx2UwnWKSy5NIlp28Ssq07ojy0uBhRR/ZpKA7Bbwmm6BvnRdr/iegSHPo1mA0yiG6oFm3EHfEYRfzqQr4wDRv6Wj1EEyLAQWU05Qw4wr96KG41BTTQYgloP3lsRsPEtTc1FGbRMt9Ml7rVcgemU47SK+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=t6niCDO7; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1728413369; x=1759949369;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jAsiRepGMaO2RpBZnaZbfHkLY9GJm8UEqwYud3lUz8A=;
  b=t6niCDO7+h67dF8lUzxlQHSAz1f3+apGrDprhK6mPlO2yagEGUrxbQqr
   Z66IPATqWOGh7BQKGS9nDjzDk921NNjhogNiKkU4lUnzl8L6SJjfMpd3F
   +sJX/DjTRQr58dpOmVKfVe45xNpOZ31Tf8TwIQXSOObw24Rw7sUoHIyfz
   Q=;
X-IronPort-AV: E=Sophos;i="6.11,187,1725321600"; 
   d="scan'208";a="136767985"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2024 18:49:27 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.38.20:12688]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.7.250:2525] with esmtp (Farcaster)
 id ac789e74-4aee-420c-a438-f40cf7468f2b; Tue, 8 Oct 2024 18:49:26 +0000 (UTC)
X-Farcaster-Flow-ID: ac789e74-4aee-420c-a438-f40cf7468f2b
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 8 Oct 2024 18:49:26 +0000
Received: from 88665a182662.ant.amazon.com (10.187.170.17) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Tue, 8 Oct 2024 18:49:23 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>, Jeremy Kerr
	<jk@codeconstruct.com.au>, Matt Johnston <matt@codeconstruct.com.au>
Subject: [PATCH v4 net 4/6] mctp: Handle error of rtnl_register_module().
Date: Tue, 8 Oct 2024 11:47:35 -0700
Message-ID: <20241008184737.9619-5-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20241008184737.9619-1-kuniyu@amazon.com>
References: <20241008184737.9619-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D046UWA003.ant.amazon.com (10.13.139.18) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Since introduced, mctp has been ignoring the returned value of
rtnl_register_module(), which could fail silently.

Handling the error allows users to view a module as an all-or-nothing
thing in terms of the rtnetlink functionality.  This prevents syzkaller
from reporting spurious errors from its tests, where OOM often occurs
and module is automatically loaded.

Let's handle the errors by rtnl_register_many().

Fixes: 583be982d934 ("mctp: Add device handling and netlink interface")
Fixes: 831119f88781 ("mctp: Add neighbour netlink interface")
Fixes: 06d2f4c583a7 ("mctp: Add netlink route management")
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: Jeremy Kerr <jk@codeconstruct.com.au>
---
Cc: Matt Johnston <matt@codeconstruct.com.au>

v3: Add more context in changelog
v2:
  * Make rtnl_msg_handler const
  * Update goto labels
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



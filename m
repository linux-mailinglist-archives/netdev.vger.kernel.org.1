Return-Path: <netdev+bounces-136272-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A7149A122B
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 20:58:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E8881C208FB
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 18:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAC2D212F10;
	Wed, 16 Oct 2024 18:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="WpNI2ZtQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA2A2144AB
	for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 18:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729105106; cv=none; b=pTWVXEULFHTIfg79dS+xWiy8WLJW0dSFG5X1MI/odIp84mXCKIUfW/ATqFrN5OsB1MlUwsFbDa0udVumeRyHjNk+ddv7zVeot3CSI6T7R2lFbhzOl2h61NkdoQ1tOJF+GfR6xzBlRuwLd4Pedbv8Q8EI6I2xmFC6vSworh8tVEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729105106; c=relaxed/simple;
	bh=Xv7Z2i0C+3Ayy22TepDoLEV2eIz2u4ZgkTuqve1Tlw0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RvQWdy/EosxdOQKpCkCdmqKnv4+mKktdm1vOKEvSsESq89si0e2DkK0Ia0tSnJHXutUq6w3zxZCSuV8Si9fR+r65iga11C3MJnwL2P0laN8taQi+IIdlo7hi9FWdYq/6HulRPSk2Uv8rD3Hrk8ekQqw+El0VGrMZVTuwSI+KNG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=WpNI2ZtQ; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1729105104; x=1760641104;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=C3gTYY3r02AOkVXFjyLSDXyJNGKfIybiCdZWU3dFVdo=;
  b=WpNI2ZtQQv987Nrh5K9CmEMC3cov3QoEhm/ZaJCwZJXmSrUyzCHo8w0u
   CfbQyq+M2ekCicN3oxkc8Xff548fc11oHGIZNDVowp4BpaD/eHQqQnB4u
   S0PBGzDmXczSmPrphn76vunH/NOjt5OzC0Hg+OGhGmWJgzLCEABIrMcr9
   s=;
X-IronPort-AV: E=Sophos;i="6.11,208,1725321600"; 
   d="scan'208";a="666709085"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 18:58:23 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.21.151:37224]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.7.250:2525] with esmtp (Farcaster)
 id c103c91d-9b71-4290-9208-0b3764d6bb97; Wed, 16 Oct 2024 18:58:21 +0000 (UTC)
X-Farcaster-Flow-ID: c103c91d-9b71-4290-9208-0b3764d6bb97
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 16 Oct 2024 18:58:21 +0000
Received: from 6c7e67c6786f.amazon.com (10.106.100.12) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Wed, 16 Oct 2024 18:58:18 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>, Roopa Prabhu
	<roopa@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>, David Ahern
	<dsahern@kernel.org>, Jeremy Kerr <jk@codeconstruct.com.au>, Matt Johnston
	<matt@codeconstruct.com.au>
Subject: [PATCH v2 net-next 13/14] rtnetlink: Return int from rtnl_af_register().
Date: Wed, 16 Oct 2024 11:53:56 -0700
Message-ID: <20241016185357.83849-14-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241016185357.83849-1-kuniyu@amazon.com>
References: <20241016185357.83849-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D039UWA004.ant.amazon.com (10.13.139.68) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

The next patch will add init_srcu_struct() in rtnl_af_register(),
then we need to handle its error.

Let's add the error handling in advance to make the following
patch cleaner.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
Cc: Roopa Prabhu <roopa@nvidia.com>
Cc: Nikolay Aleksandrov <razor@blackwall.org>
Cc: David Ahern <dsahern@kernel.org>
Cc: Jeremy Kerr <jk@codeconstruct.com.au>
Cc: Matt Johnston <matt@codeconstruct.com.au>
---
 include/net/rtnetlink.h |  2 +-
 net/bridge/br_netlink.c |  6 +++++-
 net/core/rtnetlink.c    |  4 +++-
 net/ipv4/devinet.c      |  3 ++-
 net/ipv6/addrconf.c     |  5 ++++-
 net/mctp/device.c       | 16 +++++++++++-----
 net/mpls/af_mpls.c      |  5 ++++-
 7 files changed, 30 insertions(+), 11 deletions(-)

diff --git a/include/net/rtnetlink.h b/include/net/rtnetlink.h
index 1a6aa5ca74f3..969138ae2f4b 100644
--- a/include/net/rtnetlink.h
+++ b/include/net/rtnetlink.h
@@ -204,7 +204,7 @@ struct rtnl_af_ops {
 	size_t			(*get_stats_af_size)(const struct net_device *dev);
 };
 
-void rtnl_af_register(struct rtnl_af_ops *ops);
+int rtnl_af_register(struct rtnl_af_ops *ops);
 void rtnl_af_unregister(struct rtnl_af_ops *ops);
 
 struct net *rtnl_link_get_net(struct net *src_net, struct nlattr *tb[]);
diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
index 6b97ae47f855..3e0f47203f2a 100644
--- a/net/bridge/br_netlink.c
+++ b/net/bridge/br_netlink.c
@@ -1924,7 +1924,9 @@ int __init br_netlink_init(void)
 	if (err)
 		goto out;
 
-	rtnl_af_register(&br_af_ops);
+	err = rtnl_af_register(&br_af_ops);
+	if (err)
+		goto out_vlan;
 
 	err = rtnl_link_register(&br_link_ops);
 	if (err)
@@ -1934,6 +1936,8 @@ int __init br_netlink_init(void)
 
 out_af:
 	rtnl_af_unregister(&br_af_ops);
+out_vlan:
+	br_vlan_rtnl_uninit();
 out:
 	return err;
 }
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 445e6ffed75e..70b663aca209 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -686,11 +686,13 @@ static const struct rtnl_af_ops *rtnl_af_lookup(const int family)
  *
  * Returns 0 on success or a negative error code.
  */
-void rtnl_af_register(struct rtnl_af_ops *ops)
+int rtnl_af_register(struct rtnl_af_ops *ops)
 {
 	rtnl_lock();
 	list_add_tail_rcu(&ops->list, &rtnl_af_ops);
 	rtnl_unlock();
+
+	return 0;
 }
 EXPORT_SYMBOL_GPL(rtnl_af_register);
 
diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
index d81fff93d208..2152d8cfa2dc 100644
--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -2812,7 +2812,8 @@ void __init devinet_init(void)
 	register_pernet_subsys(&devinet_ops);
 	register_netdevice_notifier(&ip_netdev_notifier);
 
-	rtnl_af_register(&inet_af_ops);
+	if (rtnl_af_register(&inet_af_ops))
+		panic("Unable to register inet_af_ops\n");
 
 	rtnl_register_many(devinet_rtnl_msg_handlers);
 }
diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index ac8645ad2537..d0a99710d65d 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -7468,7 +7468,9 @@ int __init addrconf_init(void)
 
 	addrconf_verify(&init_net);
 
-	rtnl_af_register(&inet6_ops);
+	err = rtnl_af_register(&inet6_ops);
+	if (err)
+		goto erraf;
 
 	err = rtnl_register_many(addrconf_rtnl_msg_handlers);
 	if (err)
@@ -7482,6 +7484,7 @@ int __init addrconf_init(void)
 errout:
 	rtnl_unregister_all(PF_INET6);
 	rtnl_af_unregister(&inet6_ops);
+erraf:
 	unregister_netdevice_notifier(&ipv6_dev_notf);
 errlo:
 	destroy_workqueue(addrconf_wq);
diff --git a/net/mctp/device.c b/net/mctp/device.c
index 85cc5f31f1e7..3d75b919995d 100644
--- a/net/mctp/device.c
+++ b/net/mctp/device.c
@@ -535,14 +535,20 @@ int __init mctp_device_init(void)
 	int err;
 
 	register_netdevice_notifier(&mctp_dev_nb);
-	rtnl_af_register(&mctp_af_ops);
+
+	err = rtnl_af_register(&mctp_af_ops);
+	if (err)
+		goto err_notifier;
 
 	err = rtnl_register_many(mctp_device_rtnl_msg_handlers);
-	if (err) {
-		rtnl_af_unregister(&mctp_af_ops);
-		unregister_netdevice_notifier(&mctp_dev_nb);
-	}
+	if (err)
+		goto err_af;
 
+	return 0;
+err_af:
+	rtnl_af_unregister(&mctp_af_ops);
+err_notifier:
+	unregister_netdevice_notifier(&mctp_dev_nb);
 	return err;
 }
 
diff --git a/net/mpls/af_mpls.c b/net/mpls/af_mpls.c
index a0573847bc55..1f63b32d76d6 100644
--- a/net/mpls/af_mpls.c
+++ b/net/mpls/af_mpls.c
@@ -2753,7 +2753,9 @@ static int __init mpls_init(void)
 
 	dev_add_pack(&mpls_packet_type);
 
-	rtnl_af_register(&mpls_af_ops);
+	err = rtnl_af_register(&mpls_af_ops);
+	if (err)
+		goto out_unregister_dev_type;
 
 	err = rtnl_register_many(mpls_rtnl_msg_handlers);
 	if (err)
@@ -2773,6 +2775,7 @@ static int __init mpls_init(void)
 	rtnl_unregister_many(mpls_rtnl_msg_handlers);
 out_unregister_rtnl_af:
 	rtnl_af_unregister(&mpls_af_ops);
+out_unregister_dev_type:
 	dev_remove_pack(&mpls_packet_type);
 out_unregister_pernet:
 	unregister_pernet_subsys(&mpls_net_ops);
-- 
2.39.5 (Apple Git-154)



Return-Path: <netdev+bounces-143113-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 292989C1349
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 01:49:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE397284425
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 00:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60F071BD9DE;
	Fri,  8 Nov 2024 00:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="ISR7XYvK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6FB179D2
	for <netdev@vger.kernel.org>; Fri,  8 Nov 2024 00:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.190.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731026958; cv=none; b=IuwzRMRf2HpntD7EIeeiWOWlN1A/iJNNadxxs3/oZxBjPF91elXzSUad8AENQ1VilRzXo81LMrwnQZarFmYcmojPL2IHLwlaMjAfILaXOL2xKo1K9lwSJSjzzUYH/+vLYEv8ums7OfqKFcXpIINEzX4MK+WLT3qjwTVnfz6P2u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731026958; c=relaxed/simple;
	bh=esqY7z68Id/YzL+/BHrNG/eiQA/HtkC1u5LtOoDsrZI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sg+vP+dJYIpYOPZL9SCbXE7AsVZUmOUQbY7YoP/07xPlUHG6wm1mFS7d+Wh2g9hm9XrnqUOiZs6yc2FcOwOUJiUOb75DJyUUUb6I4B5tQiA3bNYx4DGm53c75NY49lV5DXI3pgX4RNqroRNPSGygzC4dJFl+PKr4b/2ivgDky+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=ISR7XYvK; arc=none smtp.client-ip=207.171.190.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1731026957; x=1762562957;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=p8ORRkWw6Q48z7FqTmY32iLWcmfdA951jrfwoBPUJCs=;
  b=ISR7XYvKpCSQZyokJ04yr0Q+mfKQNPQYGLeC2xK464f0RU+3KpJhVY8G
   Hw8d7A2EiAtfM2tg4p3rMZU2th8lTXAHlZYeTy1D/WZ5QSZrFIpEkUXsF
   RgXnDsjQnRT1OZ9oXNCQBZGH4IJBzX5i4120p8xptL41jT1F5JrEDhEvK
   o=;
X-IronPort-AV: E=Sophos;i="6.12,136,1728950400"; 
   d="scan'208";a="383425010"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2024 00:49:11 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.38.20:51883]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.34.224:2525] with esmtp (Farcaster)
 id ed1b2096-3a2c-4ed6-b886-318a85e09617; Fri, 8 Nov 2024 00:49:10 +0000 (UTC)
X-Farcaster-Flow-ID: ed1b2096-3a2c-4ed6-b886-318a85e09617
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 8 Nov 2024 00:49:09 +0000
Received: from 6c7e67c6786f.amazon.com (10.187.170.59) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Fri, 8 Nov 2024 00:49:06 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, Marc Kleine-Budde
	<mkl@pengutronix.de>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, "Daniel
 Borkmann" <daniel@iogearbox.net>, Nikolay Aleksandrov <razor@blackwall.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH RESEND v3 net-next 02/10] rtnetlink: Protect link_ops by mutex.
Date: Thu, 7 Nov 2024 16:48:15 -0800
Message-ID: <20241108004823.29419-3-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241108004823.29419-1-kuniyu@amazon.com>
References: <20241108004823.29419-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D043UWC002.ant.amazon.com (10.13.139.222) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

rtnl_link_unregister() holds RTNL and calls synchronize_srcu(),
but rtnl_newlink() will acquire SRCU frist and then RTNL.

Then, we need to unlink ops and call synchronize_srcu() outside
of RTNL to avoid the deadlock.

   rtnl_link_unregister()       rtnl_newlink()
   ----                         ----
   lock(rtnl_mutex);
                                lock(&ops->srcu);
                                lock(rtnl_mutex);
   sync(&ops->srcu);

Let's move as such and add a mutex to protect link_ops.

Now, link_ops is protected by its dedicated mutex and
rtnl_link_register() no longer needs to hold RTNL.

While at it, we move the initialisation of ops->dellink and
ops->srcu out of the mutex scope.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 include/net/rtnetlink.h |  2 +-
 net/core/rtnetlink.c    | 33 ++++++++++++++++++++-------------
 2 files changed, 21 insertions(+), 14 deletions(-)

diff --git a/include/net/rtnetlink.h b/include/net/rtnetlink.h
index 3ebfcc6e56fd..7559020f760c 100644
--- a/include/net/rtnetlink.h
+++ b/include/net/rtnetlink.h
@@ -71,7 +71,7 @@ static inline int rtnl_msg_family(const struct nlmsghdr *nlh)
 /**
  *	struct rtnl_link_ops - rtnetlink link operations
  *
- *	@list: Used internally, protected by RTNL and SRCU
+ *	@list: Used internally, protected by link_ops_mutex and SRCU
  *	@srcu: Used internally
  *	@kind: Identifier
  *	@netns_refund: Physical device, move to init_net on netns exit
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 634732fe4c64..fcccb916e468 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -466,6 +466,7 @@ void __rtnl_unregister_many(const struct rtnl_msg_handler *handlers, int n)
 }
 EXPORT_SYMBOL_GPL(__rtnl_unregister_many);
 
+static DEFINE_MUTEX(link_ops_mutex);
 static LIST_HEAD(link_ops);
 
 static struct rtnl_link_ops *rtnl_link_ops_get(const char *kind, int *srcu_index)
@@ -508,14 +509,6 @@ int __rtnl_link_register(struct rtnl_link_ops *ops)
 	struct rtnl_link_ops *tmp;
 	int err;
 
-	/* When RTNL is removed, add lock for link_ops. */
-	ASSERT_RTNL();
-
-	list_for_each_entry(tmp, &link_ops, list) {
-		if (!strcmp(ops->kind, tmp->kind))
-			return -EEXIST;
-	}
-
 	/* The check for alloc/setup is here because if ops
 	 * does not have that filled up, it is not possible
 	 * to use the ops for creating device. So do not
@@ -528,9 +521,20 @@ int __rtnl_link_register(struct rtnl_link_ops *ops)
 	if (err)
 		return err;
 
+	mutex_lock(&link_ops_mutex);
+
+	list_for_each_entry(tmp, &link_ops, list) {
+		if (!strcmp(ops->kind, tmp->kind)) {
+			err = -EEXIST;
+			goto unlock;
+		}
+	}
+
 	list_add_tail_rcu(&ops->list, &link_ops);
+unlock:
+	mutex_unlock(&link_ops_mutex);
 
-	return 0;
+	return err;
 }
 EXPORT_SYMBOL_GPL(__rtnl_link_register);
 
@@ -598,14 +602,17 @@ void rtnl_link_unregister(struct rtnl_link_ops *ops)
 {
 	struct net *net;
 
-	/* Close the race with setup_net() and cleanup_net() */
-	down_write(&pernet_ops_rwsem);
-	rtnl_lock_unregistering_all();
-
+	mutex_lock(&link_ops_mutex);
 	list_del_rcu(&ops->list);
+	mutex_unlock(&link_ops_mutex);
+
 	synchronize_srcu(&ops->srcu);
 	cleanup_srcu_struct(&ops->srcu);
 
+	/* Close the race with setup_net() and cleanup_net() */
+	down_write(&pernet_ops_rwsem);
+	rtnl_lock_unregistering_all();
+
 	for_each_net(net)
 		__rtnl_kill_links(net, ops);
 
-- 
2.39.5 (Apple Git-154)



Return-Path: <netdev+bounces-142619-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D95B19BFC8D
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 03:30:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 044A01C20ADA
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 02:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 125B42207A;
	Thu,  7 Nov 2024 02:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="u1klVLtF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD8457C9F
	for <netdev@vger.kernel.org>; Thu,  7 Nov 2024 02:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730946597; cv=none; b=c4C9n9l94xRSKKh4YtFoCu9H4d/KQ6JKdza02Vjtda18pv5j9YhCJbmGqTGyZG8BGZy6wDKGlSOWQLk9PqsRQpBbdjEtZVVDDZGM0d6hnZPO0akqkcEpPX35i1ReVnJeAp8amlKRDVhyfgwWoNRFhmBZGFk6bABS2nWQ5Yqrvoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730946597; c=relaxed/simple;
	bh=esqY7z68Id/YzL+/BHrNG/eiQA/HtkC1u5LtOoDsrZI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dbwi8JLcIfIdicgHNgR3nkjLdPwiVUa69B4ob/nmHqEOr1U9mRvira7Q4/m1GIeIbAdhVTGNSrDrQgpLjCK3LWwTwBkLbsSVYWkW4eo9qnwItQlUJO23CvrZE7JYNl1DBEFRecVD2cE92xjLaY3lm2HwhF48pFZjojmjZwKbRls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=u1klVLtF; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1730946595; x=1762482595;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=p8ORRkWw6Q48z7FqTmY32iLWcmfdA951jrfwoBPUJCs=;
  b=u1klVLtFDgh4hhhg/SI5zzVxdHXAElgoxeKSzq7paPRdkkdB1xShwPIj
   k9zvY0P0F/uzEagaeYT7h1rsi6SegBdWyDmPx5ZSZwU6gnLLasdUJCYeP
   +rYvmYmmNuBcK4YrArkOB2TItEKDrQCmAVosWb0nVZ1wAphKzEyqAJGXG
   M=;
X-IronPort-AV: E=Sophos;i="6.11,264,1725321600"; 
   d="scan'208";a="350037288"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2024 02:29:54 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:17980]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.44.86:2525] with esmtp (Farcaster)
 id 56bd46c8-1097-43d3-8799-58d3a6906051; Thu, 7 Nov 2024 02:29:53 +0000 (UTC)
X-Farcaster-Flow-ID: 56bd46c8-1097-43d3-8799-58d3a6906051
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Thu, 7 Nov 2024 02:29:52 +0000
Received: from 6c7e67c6786f.amazon.com (10.106.101.27) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Thu, 7 Nov 2024 02:29:48 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, Marc Kleine-Budde
	<mkl@pengutronix.de>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, "Daniel
 Borkmann" <daniel@iogearbox.net>, Nikolay Aleksandrov <razor@blackwall.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v3 net-next 02/10] rtnetlink: Protect link_ops by mutex.
Date: Wed, 6 Nov 2024 18:28:52 -0800
Message-ID: <20241107022900.70287-3-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241107022900.70287-1-kuniyu@amazon.com>
References: <20241107022900.70287-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D042UWA002.ant.amazon.com (10.13.139.17) To
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



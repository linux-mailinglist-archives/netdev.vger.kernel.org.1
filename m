Return-Path: <netdev+bounces-181018-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D9E8A8366F
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 04:24:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 830038C043B
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 02:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCA021CAA62;
	Thu, 10 Apr 2025 02:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="VMKk9LUN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B6B15624D
	for <netdev@vger.kernel.org>; Thu, 10 Apr 2025 02:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744251645; cv=none; b=YO6LBHWBINiq5yND48dnyrZeMYFOY+d59I6Y/pWDMacqqryj6/0/6zDwWyGKpZ4Vg7/2C3jmBEevPHU4wG2Y/2NxeY8O5+u7hSmJpQljdWpLp3bidkNPQf/uvvBVIwNrM4m28LzDJsdeic7Yfqp/wHkT5a7PcIHuM1i4JwXdwwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744251645; c=relaxed/simple;
	bh=DfL6CvSRsbchBgpk/pMWYeCrJoLVyO5ARwKCUCyFinM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TeX/SR6ReA+0lMa4O1mc6beh32n3MABBbD7KoZSm3YSCsdQylTtRYSmalt4OaxhCW8iCPaz3AcslpHxe2F7FRNl2OpgED74VNv8HALt6G1un36hNQkACx5IOJdzrH/c/qTK8G1JeFgY3dK3JDUoHGN4c6Y0tViK8752CPETH3Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=VMKk9LUN; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744251644; x=1775787644;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cVdeIYpaG0H7G8oMkMWn/wCUT/7MTxd5fPqMug8OI2M=;
  b=VMKk9LUN15DR9ztedEroDX4u19Ka4kSFttGu+klK9JCK5qrFPLqh/HmB
   tCwKU/mQ4m0QFmErNF0rr87cE72x3sYQAzhALaUvDteXJudJZJw1x8zIi
   D7QNSKKJH8uHMiBrrQMZXAtamE5vuJOHJWcp7VSFfZe24OoXGJQ9+exL9
   k=;
X-IronPort-AV: E=Sophos;i="6.15,201,1739836800"; 
   d="scan'208";a="287189423"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 02:20:42 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.38.20:29609]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.43.57:2525] with esmtp (Farcaster)
 id f091a536-9d42-4df3-ad41-c28ddc87b4fd; Thu, 10 Apr 2025 02:20:41 +0000 (UTC)
X-Farcaster-Flow-ID: f091a536-9d42-4df3-ad41-c28ddc87b4fd
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 10 Apr 2025 02:20:40 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.170.41) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 10 Apr 2025 02:20:38 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 01/14] net: Factorise setup_net() and cleanup_net().
Date: Wed, 9 Apr 2025 19:19:22 -0700
Message-ID: <20250410022004.8668-2-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250410022004.8668-1-kuniyu@amazon.com>
References: <20250410022004.8668-1-kuniyu@amazon.com>
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

When we roll back the changes made by struct pernet_operations.init(),
we execute mostly identical sequences in three places.

  * setup_net()
  * cleanup_net()
  * free_exit_list()

The only difference between the first two is which list and RCU helpers
to use.

In setup_net(), an ops could fail on the way, so we need to perform a
reverse walk from its previous ops in pernet_list.  OTOH, in cleanup_net(),
we iterate the full list from tail to head.

The former passes the failed ops to list_for_each_entry_continue_reverse().
It's tricky, but we can reuse it for the latter if we pass list_entry() of
the head node.

Also, synchronize_rcu() and synchronize_rcu_expedited() can be easily
switched by an argument.

Let's factorise the rollback part in setup_net() and cleanup_net().

In the next patch, ops_undo_list() will be reused for free_exit_list(),
and then two arguments (ops_list and hold_rtnl) will differ.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/core/net_namespace.c | 106 +++++++++++++++++++--------------------
 1 file changed, 51 insertions(+), 55 deletions(-)

diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
index b0dfdf791ece..2612339efd71 100644
--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -188,6 +188,53 @@ static void ops_free_list(const struct pernet_operations *ops,
 	}
 }
 
+static void ops_undo_list(const struct list_head *ops_list,
+			  const struct pernet_operations *ops,
+			  struct list_head *net_exit_list,
+			  bool expedite_rcu, bool hold_rtnl)
+{
+	const struct pernet_operations *saved_ops;
+
+	if (!ops)
+		ops = list_entry(ops_list, typeof(*ops), list);
+
+	saved_ops = ops;
+
+	list_for_each_entry_continue_reverse(ops, ops_list, list)
+		ops_pre_exit_list(ops, net_exit_list);
+
+	/* Another CPU might be rcu-iterating the list, wait for it.
+	 * This needs to be before calling the exit() notifiers, so the
+	 * rcu_barrier() after ops_undo_list() isn't sufficient alone.
+	 * Also the pre_exit() and exit() methods need this barrier.
+	 */
+	if (expedite_rcu)
+		synchronize_rcu_expedited();
+	else
+		synchronize_rcu();
+
+	if (hold_rtnl) {
+		LIST_HEAD(dev_kill_list);
+
+		ops = saved_ops;
+		rtnl_lock();
+		list_for_each_entry_continue_reverse(ops, ops_list, list) {
+			if (ops->exit_batch_rtnl)
+				ops->exit_batch_rtnl(net_exit_list, &dev_kill_list);
+		}
+		unregister_netdevice_many(&dev_kill_list);
+		rtnl_unlock();
+	}
+
+	ops = saved_ops;
+	list_for_each_entry_continue_reverse(ops, ops_list, list)
+		ops_exit_list(ops, net_exit_list);
+
+	ops = saved_ops;
+	list_for_each_entry_continue_reverse(ops, ops_list, list)
+		ops_free_list(ops, net_exit_list);
+}
+
 /* should be called with nsid_lock held */
 static int alloc_netid(struct net *net, struct net *peer, int reqid)
 {
@@ -351,9 +398,8 @@ static __net_init void preinit_net(struct net *net, struct user_namespace *user_
 static __net_init int setup_net(struct net *net)
 {
 	/* Must be called with pernet_ops_rwsem held */
-	const struct pernet_operations *ops, *saved_ops;
+	const struct pernet_operations *ops;
 	LIST_HEAD(net_exit_list);
-	LIST_HEAD(dev_kill_list);
 	int error = 0;
 
 	preempt_disable();
@@ -376,29 +422,7 @@ static __net_init int setup_net(struct net *net)
 	 * for the pernet modules whose init functions did not fail.
 	 */
 	list_add(&net->exit_list, &net_exit_list);
-	saved_ops = ops;
-	list_for_each_entry_continue_reverse(ops, &pernet_list, list)
-		ops_pre_exit_list(ops, &net_exit_list);
-
-	synchronize_rcu();
-
-	ops = saved_ops;
-	rtnl_lock();
-	list_for_each_entry_continue_reverse(ops, &pernet_list, list) {
-		if (ops->exit_batch_rtnl)
-			ops->exit_batch_rtnl(&net_exit_list, &dev_kill_list);
-	}
-	unregister_netdevice_many(&dev_kill_list);
-	rtnl_unlock();
-
-	ops = saved_ops;
-	list_for_each_entry_continue_reverse(ops, &pernet_list, list)
-		ops_exit_list(ops, &net_exit_list);
-
-	ops = saved_ops;
-	list_for_each_entry_continue_reverse(ops, &pernet_list, list)
-		ops_free_list(ops, &net_exit_list);
-
+	ops_undo_list(&pernet_list, ops, &net_exit_list, false, true);
 	rcu_barrier();
 	goto out;
 }
@@ -594,11 +618,9 @@ struct task_struct *cleanup_net_task;
 
 static void cleanup_net(struct work_struct *work)
 {
-	const struct pernet_operations *ops;
-	struct net *net, *tmp, *last;
 	struct llist_node *net_kill_list;
+	struct net *net, *tmp, *last;
 	LIST_HEAD(net_exit_list);
-	LIST_HEAD(dev_kill_list);
 
 	cleanup_net_task = current;
 
@@ -629,33 +651,7 @@ static void cleanup_net(struct work_struct *work)
 		list_add_tail(&net->exit_list, &net_exit_list);
 	}
 
-	/* Run all of the network namespace pre_exit methods */
-	list_for_each_entry_reverse(ops, &pernet_list, list)
-		ops_pre_exit_list(ops, &net_exit_list);
-
-	/*
-	 * Another CPU might be rcu-iterating the list, wait for it.
-	 * This needs to be before calling the exit() notifiers, so
-	 * the rcu_barrier() below isn't sufficient alone.
-	 * Also the pre_exit() and exit() methods need this barrier.
-	 */
-	synchronize_rcu_expedited();
-
-	rtnl_lock();
-	list_for_each_entry_reverse(ops, &pernet_list, list) {
-		if (ops->exit_batch_rtnl)
-			ops->exit_batch_rtnl(&net_exit_list, &dev_kill_list);
-	}
-	unregister_netdevice_many(&dev_kill_list);
-	rtnl_unlock();
-
-	/* Run all of the network namespace exit methods */
-	list_for_each_entry_reverse(ops, &pernet_list, list)
-		ops_exit_list(ops, &net_exit_list);
-
-	/* Free the net generic variables */
-	list_for_each_entry_reverse(ops, &pernet_list, list)
-		ops_free_list(ops, &net_exit_list);
+	ops_undo_list(&pernet_list, NULL, &net_exit_list, true, true);
 
 	up_read(&pernet_ops_rwsem);
 
-- 
2.49.0



Return-Path: <netdev+bounces-181794-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A67CA867B2
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 22:54:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E6B38C2505
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 20:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BD5E28FFEF;
	Fri, 11 Apr 2025 20:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Cdw5HRuO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA26028D853
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 20:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744404871; cv=none; b=m5Zbxu/nvYXNqr7+GNOyyOJui13EMG0/PA+eMpnrBaHeL4LjKFW0WKqWFZuaRtG2sTbCeUB55rrD68oMO+XC0vq5nXRupJ8BKYUrwPNQbkm3YMo0Aongetmi+nI+jpFaSMKQCX8kWIesIzA8UW2eO00XXSrsPsk/qU3P+q9pYMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744404871; c=relaxed/simple;
	bh=ekfRNNSjyNbVab7zWqe6Y8vo5Kq50AYwi9XJcGfiMG8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iffClOO0Vg3pyVwNz+MWHtbH2Y3fSTTQMfc1qMY8fKgQx61m6hU5FSxnD+OyLpC7C1uIumIkWe1yQHaLdsmh8vPwRyfQBwYzdE8drb8sHFN7lwiMPsa/Uuv4+21PPQqrb8m5ZrXt6FTWqebSIGzr+nWey52KgJdmcvfbr0BYlwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Cdw5HRuO; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744404869; x=1775940869;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=W5vQy/D2/12VH3wihbYu2oqTtzdSTmLyt8iUR3bsF/E=;
  b=Cdw5HRuOFNfYP7GyZ5ccieHyumOOoArZFbcQyQGw4qDoVCf8EKLpkZCE
   hGb2HP+6yNJhrlk1gFhtIlIxoRLmIVn25HkJnOkgjCJgj+gc74N1E65zF
   CvPaMKNhiSXeeuFKXOVewcO6E43kiWShDl+WRYIAee1muP9OMEACoD003
   0=;
X-IronPort-AV: E=Sophos;i="6.15,206,1739836800"; 
   d="scan'208";a="815395962"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2025 20:54:24 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.21.151:4557]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.14.132:2525] with esmtp (Farcaster)
 id eedb0a07-35fa-41ab-b94d-448b655b90f2; Fri, 11 Apr 2025 20:54:23 +0000 (UTC)
X-Farcaster-Flow-ID: eedb0a07-35fa-41ab-b94d-448b655b90f2
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 11 Apr 2025 20:54:23 +0000
Received: from 6c7e67bfbae3.amazon.com (10.119.240.29) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 11 Apr 2025 20:54:20 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 03/14] net: Add ->exit_rtnl() hook to struct pernet_operations.
Date: Fri, 11 Apr 2025 13:52:32 -0700
Message-ID: <20250411205258.63164-4-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250411205258.63164-1-kuniyu@amazon.com>
References: <20250411205258.63164-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D032UWA003.ant.amazon.com (10.13.139.37) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

struct pernet_operations provides two batching hooks; ->exit_batch()
and ->exit_batch_rtnl().

The batching variant is beneficial if ->exit() meets any of the
following conditions:

  1) ->exit() repeatedly acquires a global lock for each netns

  2) ->exit() has a time-consuming operation that can be factored
     out (e.g. synchronize_rcu(), smp_mb(), etc)

  3) ->exit() does not need to repeat the same iterations for each
     netns (e.g. inet_twsk_purge())

Currently, none of the ->exit_batch_rtnl() functions satisfy any of
the above conditions because RTNL is factored out and held by the
caller and all of these functions iterate over the dying netns list.

Also, we want to hold per-netns RTNL there but avoid spreading
__rtnl_net_lock() across multiple locations.

Let's add ->exit_rtnl() hook and run it under __rtnl_net_lock().

The following patches will convert all ->exit_batch_rtnl() users
to ->exit_rtnl().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 include/net/net_namespace.h |  2 ++
 net/core/net_namespace.c    | 53 +++++++++++++++++++++++++++----------
 2 files changed, 41 insertions(+), 14 deletions(-)

diff --git a/include/net/net_namespace.h b/include/net/net_namespace.h
index bd57d8fb54f1..b071e6eed9d5 100644
--- a/include/net/net_namespace.h
+++ b/include/net/net_namespace.h
@@ -475,6 +475,8 @@ struct pernet_operations {
 	void (*exit)(struct net *net);
 	void (*exit_batch)(struct list_head *net_exit_list);
 	/* Following method is called with RTNL held. */
+	void (*exit_rtnl)(struct net *net,
+			  struct list_head *dev_kill_list);
 	void (*exit_batch_rtnl)(struct list_head *net_exit_list,
 				struct list_head *dev_kill_list);
 	unsigned int * const id;
diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
index 37026776ae4e..afaa3d1bda8d 100644
--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -163,16 +163,51 @@ static void ops_pre_exit_list(const struct pernet_operations *ops,
 	}
 }
 
+static void ops_exit_rtnl_list(const struct list_head *ops_list,
+			       const struct pernet_operations *ops,
+			       struct list_head *net_exit_list)
+{
+	const struct pernet_operations *saved_ops = ops;
+	LIST_HEAD(dev_kill_list);
+	struct net *net;
+
+	rtnl_lock();
+
+	list_for_each_entry(net, net_exit_list, exit_list) {
+		__rtnl_net_lock(net);
+
+		ops = saved_ops;
+		list_for_each_entry_continue_reverse(ops, ops_list, list) {
+			if (ops->exit_rtnl)
+				ops->exit_rtnl(net, &dev_kill_list);
+		}
+
+		__rtnl_net_unlock(net);
+	}
+
+	ops = saved_ops;
+	list_for_each_entry_continue_reverse(ops, ops_list, list) {
+		if (ops->exit_batch_rtnl)
+			ops->exit_batch_rtnl(net_exit_list, &dev_kill_list);
+	}
+
+	unregister_netdevice_many(&dev_kill_list);
+
+	rtnl_unlock();
+}
+
 static void ops_exit_list(const struct pernet_operations *ops,
 			  struct list_head *net_exit_list)
 {
-	struct net *net;
 	if (ops->exit) {
+		struct net *net;
+
 		list_for_each_entry(net, net_exit_list, exit_list) {
 			ops->exit(net);
 			cond_resched();
 		}
 	}
+
 	if (ops->exit_batch)
 		ops->exit_batch(net_exit_list);
 }
@@ -213,18 +248,8 @@ static void ops_undo_list(const struct list_head *ops_list,
 	else
 		synchronize_rcu();
 
-	if (hold_rtnl) {
-		LIST_HEAD(dev_kill_list);
-
-		ops = saved_ops;
-		rtnl_lock();
-		list_for_each_entry_continue_reverse(ops, ops_list, list) {
-			if (ops->exit_batch_rtnl)
-				ops->exit_batch_rtnl(net_exit_list, &dev_kill_list);
-		}
-		unregister_netdevice_many(&dev_kill_list);
-		rtnl_unlock();
-	}
+	if (hold_rtnl)
+		ops_exit_rtnl_list(ops_list, saved_ops, net_exit_list);
 
 	ops = saved_ops;
 	list_for_each_entry_continue_reverse(ops, ops_list, list)
@@ -238,7 +263,7 @@ static void ops_undo_list(const struct list_head *ops_list,
 static void ops_undo_single(struct pernet_operations *ops,
 			    struct list_head *net_exit_list)
 {
-	bool hold_rtnl = !!ops->exit_batch_rtnl;
+	bool hold_rtnl = ops->exit_rtnl || ops->exit_batch_rtnl;
 	LIST_HEAD(ops_list);
 
 	list_add(&ops->list, &ops_list);
-- 
2.49.0



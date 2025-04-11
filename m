Return-Path: <netdev+bounces-181793-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D02BA867B3
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 22:54:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 935DE1893BEE
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 20:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A03328D853;
	Fri, 11 Apr 2025 20:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="qbFUg+Ha"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3BB7280A43
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 20:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744404843; cv=none; b=gVNKiZ6VumJ79U1joEFOpCmwj4QbS5QTP9439KyKQdBI4LgoQO8XGZcrwxXW9yXoCuu/iUifOiHg5iO7pT4K5i2PJVyKlcwn2rzkftNieHJrnEfPeT7h8YID4hDW3z1+GIu2hdLLpwTyHiE9kBpcLeL4aGYYDurSRSo6MzTfpmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744404843; c=relaxed/simple;
	bh=PAOC8idqR7PZo2ia+BKYPAQnHfSp8Pe5c3KxMIjWuOw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pD9zPpN584xuI2JGcA9FAYwwTRVcvzRk3WuWZkCqOiMUstRDABvrYBplpBuevmkNzf0UEC0FIsC9GT9s+DGFHWUqPDTChhL9tm5d8ZlrmC0jfJfOG8THLRDR54eztSUUJDFTaVmdW8zcRb+eQd3ujPgCk0y6mbubGpgY1efhkZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=qbFUg+Ha; arc=none smtp.client-ip=99.78.197.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744404842; x=1775940842;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fdd7+7JtJQAwSvoq0uGQhc0y4fidcyeYRxdm7aY152A=;
  b=qbFUg+Habe3UkqvCjwNyea353McEBdZ5SMErjJ8VqVNTbETm9MrYL5s5
   kvz5xOmSyYUzL3+tt4qlEXKw5tqPQVsQZI4evPQm2oxLhKs4xBvfFE4TM
   oJ9GqOD5xt7UskfGisfCSH3dYpj2BxkF+WsWSu2pag7YE2mWjbfIRPuE+
   4=;
X-IronPort-AV: E=Sophos;i="6.15,206,1739836800"; 
   d="scan'208";a="39946216"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2025 20:54:01 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.7.35:43941]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.47.226:2525] with esmtp (Farcaster)
 id a1aa19a0-fb23-4a2b-be3d-a42b0741bf41; Fri, 11 Apr 2025 20:53:59 +0000 (UTC)
X-Farcaster-Flow-ID: a1aa19a0-fb23-4a2b-be3d-a42b0741bf41
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 11 Apr 2025 20:53:59 +0000
Received: from 6c7e67bfbae3.amazon.com (10.119.240.29) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 11 Apr 2025 20:53:56 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 02/14] net: Add ops_undo_single for module load/unload.
Date: Fri, 11 Apr 2025 13:52:31 -0700
Message-ID: <20250411205258.63164-3-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D033UWC002.ant.amazon.com (10.13.139.196) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

If ops_init() fails while loading a module or we unload the
module, free_exit_list() rolls back the changes.

The rollback sequence is the same as ops_undo_list().

The ops is already removed from pernet_list before calling
free_exit_list().  If we link the ops to a temporary list,
we can reuse ops_undo_list().

Let's add a wrapper of ops_undo_list() and use it instead
of free_exit_list().

Now, we have the central place to roll back ops_init().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
v2: Convert free_exit_list() under CONFIG_NET_NS=n
---
 net/core/net_namespace.c | 54 ++++++++++++++++++----------------------
 1 file changed, 24 insertions(+), 30 deletions(-)

diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
index 2612339efd71..37026776ae4e 100644
--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -235,6 +235,17 @@ static void ops_undo_list(const struct list_head *ops_list,
 		ops_free_list(ops, net_exit_list);
 }
 
+static void ops_undo_single(struct pernet_operations *ops,
+			    struct list_head *net_exit_list)
+{
+	bool hold_rtnl = !!ops->exit_batch_rtnl;
+	LIST_HEAD(ops_list);
+
+	list_add(&ops->list, &ops_list);
+	ops_undo_list(&ops_list, NULL, net_exit_list, false, hold_rtnl);
+	list_del(&ops->list);
+}
+
 /* should be called with nsid_lock held */
 static int alloc_netid(struct net *net, struct net *peer, int reqid)
 {
@@ -1235,31 +1246,13 @@ void __init net_ns_init(void)
 	rtnl_register_many(net_ns_rtnl_msg_handlers);
 }
 
-static void free_exit_list(struct pernet_operations *ops, struct list_head *net_exit_list)
-{
-	ops_pre_exit_list(ops, net_exit_list);
-	synchronize_rcu();
-
-	if (ops->exit_batch_rtnl) {
-		LIST_HEAD(dev_kill_list);
-
-		rtnl_lock();
-		ops->exit_batch_rtnl(net_exit_list, &dev_kill_list);
-		unregister_netdevice_many(&dev_kill_list);
-		rtnl_unlock();
-	}
-	ops_exit_list(ops, net_exit_list);
-
-	ops_free_list(ops, net_exit_list);
-}
-
 #ifdef CONFIG_NET_NS
 static int __register_pernet_operations(struct list_head *list,
 					struct pernet_operations *ops)
 {
+	LIST_HEAD(net_exit_list);
 	struct net *net;
 	int error;
-	LIST_HEAD(net_exit_list);
 
 	list_add_tail(&ops->list, list);
 	if (ops->init || ops->id) {
@@ -1278,21 +1271,21 @@ static int __register_pernet_operations(struct list_head *list,
 out_undo:
 	/* If I have an error cleanup all namespaces I initialized */
 	list_del(&ops->list);
-	free_exit_list(ops, &net_exit_list);
+	ops_undo_single(ops, &net_exit_list);
 	return error;
 }
 
 static void __unregister_pernet_operations(struct pernet_operations *ops)
 {
-	struct net *net;
 	LIST_HEAD(net_exit_list);
+	struct net *net;
 
-	list_del(&ops->list);
 	/* See comment in __register_pernet_operations() */
 	for_each_net(net)
 		list_add_tail(&net->exit_list, &net_exit_list);
 
-	free_exit_list(ops, &net_exit_list);
+	list_del(&ops->list);
+	ops_undo_single(ops, &net_exit_list);
 }
 
 #else
@@ -1300,22 +1293,23 @@ static void __unregister_pernet_operations(struct pernet_operations *ops)
 static int __register_pernet_operations(struct list_head *list,
 					struct pernet_operations *ops)
 {
-	if (!init_net_initialized) {
-		list_add_tail(&ops->list, list);
+	list_add_tail(&ops->list, list);
+
+	if (!init_net_initialized)
 		return 0;
-	}
 
 	return ops_init(ops, &init_net);
 }
 
 static void __unregister_pernet_operations(struct pernet_operations *ops)
 {
-	if (!init_net_initialized) {
-		list_del(&ops->list);
-	} else {
+	list_del(&ops->list);
+
+	if (init_net_initialized) {
 		LIST_HEAD(net_exit_list);
+
 		list_add(&init_net.exit_list, &net_exit_list);
-		free_exit_list(ops, &net_exit_list);
+		ops_undo_single(ops, &net_exit_list);
 	}
 }
 
-- 
2.49.0



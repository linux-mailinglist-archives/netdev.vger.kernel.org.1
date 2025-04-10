Return-Path: <netdev+bounces-181019-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0B3FA8366D
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 04:24:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40A054A2C7D
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 02:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6427E1C8639;
	Thu, 10 Apr 2025 02:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="lKsOvdax"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888561C8630
	for <netdev@vger.kernel.org>; Thu, 10 Apr 2025 02:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744251671; cv=none; b=Q8wkQJCbLP3Gu99ztd6MnuHLB+Vea18lFn3CfzyUExcxzlXLUc4XP63DKeVnqjrWKY11YPLEXxSG1MiQy2Fi5MvQSZ8hWhN4r2vasbcoutbSEfzrR47qzwojzDhjwAyH3n0P3pVcdpUY2g/2tT8Wroj+Hs4YKrYXScI7SjrKWuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744251671; c=relaxed/simple;
	bh=Sp7iS9jR5r3PLqWpYHJVZAT/dkS3tdm5CnnSgSkumB4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RCNz7e2/sNhXGD7tQx4eyh6vroHtp6w8BmXSfalCIgt/gQ0cAS9dtzCg9s13aVkit2UGtzOXarveLWKEt9rpYDB7gaR/fL7Xs9qekIZPaTv/FWa7zr6SSiqdvtf3z+HG9332n5S6uMqaxjICGCO+sxuMU4Lukx7/xXLPuRLPtJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=lKsOvdax; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744251670; x=1775787670;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=H7LAZ13jxGeMZ3naDvQ2F6JpGkAzR/L+sFG4eUMov0U=;
  b=lKsOvdaxU5GNLByfhHTV/QtHpvHLt69h8ofZ+hU0LnshIl75OnEl5k8Z
   dSR5onrjGSMj40Q6MxNqKpF3HTaiD5ZoRH8IF/yTBOxzeRT2Y7GhhFw3K
   f2cRzkylt1b0JF332GgdkfRrpzN6NVaAc5HDa21miT1CMzmM1RAVg4N5p
   U=;
X-IronPort-AV: E=Sophos;i="6.15,201,1739836800"; 
   d="scan'208";a="488160826"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 02:21:06 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:61512]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.49.222:2525] with esmtp (Farcaster)
 id 10f110b4-c78d-440c-8673-9f23baf7f51d; Thu, 10 Apr 2025 02:21:05 +0000 (UTC)
X-Farcaster-Flow-ID: 10f110b4-c78d-440c-8673-9f23baf7f51d
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 10 Apr 2025 02:21:04 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.170.41) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 10 Apr 2025 02:21:02 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 02/14] net: Add ops_undo_single for module load/unload.
Date: Wed, 9 Apr 2025 19:19:23 -0700
Message-ID: <20250410022004.8668-3-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D033UWA003.ant.amazon.com (10.13.139.42) To
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
 net/core/net_namespace.c | 39 ++++++++++++++++-----------------------
 1 file changed, 16 insertions(+), 23 deletions(-)

diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
index 2612339efd71..5e0ee117cf25 100644
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
-- 
2.49.0



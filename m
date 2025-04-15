Return-Path: <netdev+bounces-182569-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5C8DA891D3
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 04:25:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4A561773D3
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 02:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AE7520A5C4;
	Tue, 15 Apr 2025 02:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="QdGXmvzX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1278460
	for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 02:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744683934; cv=none; b=dTUpYABVhRPdq10g8mPxVz0xhEJXptGfyJuHIZv3zrNYgYvJlOFgdP5dlqV7Ep203b7HRlUIgkc+YRcteMZinFtRl+CuPsEgEz3PA5wo8NiG7tRshzlX78SvzUaLYMFFhN4qNqkxmyEGId1uPkoFf3TA1/1yrvaPRN032oKYRbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744683934; c=relaxed/simple;
	bh=k5llc3AydomdogzwmYWlpRUqPSMdkjIsTxh2JXXcCdg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QlJoxEHkgPNyrDPRXybbRxtG7i7lbjSPFC4P5HOmCXCUefggq+3B+bf+lXnsy/3PBHBcNJj8mt2ClX0fhpAjN9xnYD/yIUKUZgV0P4wWwAc1wPSccXOpVrcUAofgmaLfiTRRQwcJAWxr6TRiQG2YFyR9oV8o9K5W+U1aV5t4zmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=QdGXmvzX; arc=none smtp.client-ip=99.78.197.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744683933; x=1776219933;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6UZjYRW3+YP7pn4ZbxKu2/Ank8S2QP3KlUn98EFHxeA=;
  b=QdGXmvzX5nPsyGocEGfq8xHpezqAkcYtiJ9EhlzoPzd64+OAca7zKAUB
   EUbZabmej7bJITX4jsnN4H+lUQL49+jpZ4Cd4HlamNwUaIzoB3EMBL8No
   lCpxxyuJRRhTPiZbAF8Jpb2XHYKzINdPlg/k3a6Tq7ptSuxQAtzeGK/2j
   w=;
X-IronPort-AV: E=Sophos;i="6.15,213,1739836800"; 
   d="scan'208";a="40626784"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 02:25:31 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.38.20:41093]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.14.132:2525] with esmtp (Farcaster)
 id 02340575-dfdd-4b47-b605-d5744853eda9; Tue, 15 Apr 2025 02:25:30 +0000 (UTC)
X-Farcaster-Flow-ID: 02340575-dfdd-4b47-b605-d5744853eda9
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 15 Apr 2025 02:23:48 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.170.39) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 15 Apr 2025 02:23:31 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 1/3] net: Drop hold_rtnl arg from ops_undo_list().
Date: Mon, 14 Apr 2025 19:21:59 -0700
Message-ID: <20250415022258.11491-2-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250415022258.11491-1-kuniyu@amazon.com>
References: <20250415022258.11491-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D033UWA004.ant.amazon.com (10.13.139.85) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

ops_undo_list() first iterates over ops_list for ->pre_exit().

Let's check if any of the ops has ->exit_rtnl() there and drop
the hold_rtnl argument.

Note that nexthop uses ->exit_rtnl() and is built-in, so hold_rtnl
is always true for setup_net() and cleanup_net() for now.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Link: https://lore.kernel.org/netdev/20250414170148.21f3523c@kernel.org/
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/core/net_namespace.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
index 0a2b24af4028..48dd6dc603c9 100644
--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -220,17 +220,20 @@ static void ops_free_list(const struct pernet_operations *ops,
 static void ops_undo_list(const struct list_head *ops_list,
 			  const struct pernet_operations *ops,
 			  struct list_head *net_exit_list,
-			  bool expedite_rcu, bool hold_rtnl)
+			  bool expedite_rcu)
 {
 	const struct pernet_operations *saved_ops;
+	bool hold_rtnl = false;
 
 	if (!ops)
 		ops = list_entry(ops_list, typeof(*ops), list);
 
 	saved_ops = ops;
 
-	list_for_each_entry_continue_reverse(ops, ops_list, list)
+	list_for_each_entry_continue_reverse(ops, ops_list, list) {
+		hold_rtnl |= !!ops->exit_rtnl;
 		ops_pre_exit_list(ops, net_exit_list);
+	}
 
 	/* Another CPU might be rcu-iterating the list, wait for it.
 	 * This needs to be before calling the exit() notifiers, so the
@@ -257,11 +260,10 @@ static void ops_undo_list(const struct list_head *ops_list,
 static void ops_undo_single(struct pernet_operations *ops,
 			    struct list_head *net_exit_list)
 {
-	bool hold_rtnl = !!ops->exit_rtnl;
 	LIST_HEAD(ops_list);
 
 	list_add(&ops->list, &ops_list);
-	ops_undo_list(&ops_list, NULL, net_exit_list, false, hold_rtnl);
+	ops_undo_list(&ops_list, NULL, net_exit_list, false);
 	list_del(&ops->list);
 }
 
@@ -452,7 +454,7 @@ static __net_init int setup_net(struct net *net)
 	 * for the pernet modules whose init functions did not fail.
 	 */
 	list_add(&net->exit_list, &net_exit_list);
-	ops_undo_list(&pernet_list, ops, &net_exit_list, false, true);
+	ops_undo_list(&pernet_list, ops, &net_exit_list, false);
 	rcu_barrier();
 	goto out;
 }
@@ -681,7 +683,7 @@ static void cleanup_net(struct work_struct *work)
 		list_add_tail(&net->exit_list, &net_exit_list);
 	}
 
-	ops_undo_list(&pernet_list, NULL, &net_exit_list, true, true);
+	ops_undo_list(&pernet_list, NULL, &net_exit_list, true);
 
 	up_read(&pernet_ops_rwsem);
 
-- 
2.49.0



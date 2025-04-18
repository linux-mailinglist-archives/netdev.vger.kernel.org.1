Return-Path: <netdev+bounces-184004-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A27EA92ED7
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 02:33:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E66A19E616D
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 00:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF9A82A1D7;
	Fri, 18 Apr 2025 00:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="UBr5+xk5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205D32AEE1
	for <netdev@vger.kernel.org>; Fri, 18 Apr 2025 00:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744936423; cv=none; b=caj4aBsgCbkfP9TpCFIrCT6/Z+8oEu7EAVAr0CI/4XkZvILFAu+ju1LI1rNF7P1sZXm+/R0SWy9NqzMhseIigLncAnz0tM64u67vyJmH1YhEUFy9Q5N2pJ2SSjNouhfIDiX5RfBtp8oacwxEPPO0BJA7nmd0E2R5G/QhoLAWBCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744936423; c=relaxed/simple;
	bh=k5llc3AydomdogzwmYWlpRUqPSMdkjIsTxh2JXXcCdg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bqYgAug96bZg3uYLgg9rYaLoTKyOrf7HdOoUM1Rf5E9jf8iEQhg7deZbaQ2qToxeps6lvtw7f/s2TkbJcUmi3sVPTllbxlgDCWcP4uUubqHpPOcOG5dea2aCl6WsMTcNLHdeq0ysE5h2sp4tP3wVTSwHt8SH/NC1XjRdCHALbP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=UBr5+xk5; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744936422; x=1776472422;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6UZjYRW3+YP7pn4ZbxKu2/Ank8S2QP3KlUn98EFHxeA=;
  b=UBr5+xk58qdSIrwDmTcsWkYzCkNQT547C43ZrhIiwVTepxHbd6cKs6Lr
   i8Zq2J6Z1X+clWI6kdjqMn1nYIg9QTavFigiHLuH7DH3cSXq6iPtP/tmM
   /p6FmHrFCJh+Xc+TG58Mbj6pG3gEIcXH6l3HCtR1rybB/rsE0nu7dueix
   8=;
X-IronPort-AV: E=Sophos;i="6.15,220,1739836800"; 
   d="scan'208";a="816986433"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2025 00:33:37 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.7.35:44833]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.50.54:2525] with esmtp (Farcaster)
 id d337d442-bf6c-40ff-8842-c69e4486b41e; Fri, 18 Apr 2025 00:33:36 +0000 (UTC)
X-Farcaster-Flow-ID: d337d442-bf6c-40ff-8842-c69e4486b41e
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 18 Apr 2025 00:33:34 +0000
Received: from 6c7e67bfbae3.amazon.com (10.94.49.59) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 18 Apr 2025 00:33:31 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 1/3] net: Drop hold_rtnl arg from ops_undo_list().
Date: Thu, 17 Apr 2025 17:32:32 -0700
Message-ID: <20250418003259.48017-2-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250418003259.48017-1-kuniyu@amazon.com>
References: <20250418003259.48017-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWC001.ant.amazon.com (10.13.139.241) To
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



Return-Path: <netdev+bounces-181801-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BBC55A867C1
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 22:57:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C67908C3211
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 20:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D9B1290082;
	Fri, 11 Apr 2025 20:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="kNqbscXN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB68128F93B
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 20:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744405041; cv=none; b=OwZl0rUdp/LJaX9jkiYvbx9ClwEsA5KZjPVD37tTboCtAAjiAd30URmzLZfUCXgsuNAw2qYg6gKDi+H/n0mnmUm2xn5lXuiXxtsiQiui6f0hL1gbi2Lq++eMKbzLVRUuSgpd/RW+lXXM4MfOXACzJAvWUqPGWGPLLGtDpioQkBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744405041; c=relaxed/simple;
	bh=C265zH6VU9K7YgGfgNwSDqrXDqeJnFPh0CjB2w/5Ajw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=koSENpyxPAtVATQEIBS7GgkIjNPMhz4HxFvj0OiaM4L4Z1z/c+p6jxDssldMwz+xXydnGlAH/uA4UUbDiozitDSPhMFniR7LRWeaHucoVVLiAeJxVoYNJ2NO1+0usuvzuA5jsmmZ67q1wI2CHeWfQdWjslHUzFziDZ8YFwhmcqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=kNqbscXN; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744405039; x=1775941039;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JMfBNpLyOv24cBHuXy3CzxXoIy4yMGCg9G2ewfUuFvw=;
  b=kNqbscXNRzf8kBLaP9Tyep1gEhASbqpMMOcNcfMkbMdhuo9reVLNMTSw
   9epXKHWvni/xyeCCCBEk//+wCc2eZJPuyS53hEY4hSHdoor/WD+9OLW8K
   Z+A0hhZEAEAejZb98Ur5HDRQyRoWh3zTlFmaFrK3jwtGWzPxiSF+Q274j
   4=;
X-IronPort-AV: E=Sophos;i="6.15,206,1739836800"; 
   d="scan'208";a="190435515"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2025 20:57:16 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.7.35:42067]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.8.63:2525] with esmtp (Farcaster)
 id c7ad5896-ec84-4ee8-b598-c422cb4af088; Fri, 11 Apr 2025 20:57:16 +0000 (UTC)
X-Farcaster-Flow-ID: c7ad5896-ec84-4ee8-b598-c422cb4af088
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 11 Apr 2025 20:57:16 +0000
Received: from 6c7e67bfbae3.amazon.com (10.119.240.29) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 11 Apr 2025 20:57:13 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>, "Nikolay
 Aleksandrov" <razor@blackwall.org>, Jay Vosburgh <jv@jvosburgh.net>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
Subject: [PATCH v2 net-next 10/14] bonding: Convert bond_net_exit_batch_rtnl() to ->exit_rtnl().
Date: Fri, 11 Apr 2025 13:52:39 -0700
Message-ID: <20250411205258.63164-11-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D037UWC002.ant.amazon.com (10.13.139.250) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

bond_net_exit_batch_rtnl() iterates the dying netns list and
performs the same operation for each.

Let's use ->exit_rtnl().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
---
Cc: Jay Vosburgh <jv@jvosburgh.net>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>
---
 drivers/net/bonding/bond_main.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 950d8e4d86f8..bdd36409dd9b 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -6558,7 +6558,7 @@ static int __net_init bond_net_init(struct net *net)
 
 /* According to commit 69b0216ac255 ("bonding: fix bonding_masters
  * race condition in bond unloading") we need to remove sysfs files
- * before we remove our devices (done later in bond_net_exit_batch_rtnl())
+ * before we remove our devices (done later in bond_net_exit_rtnl())
  */
 static void __net_exit bond_net_pre_exit(struct net *net)
 {
@@ -6567,25 +6567,20 @@ static void __net_exit bond_net_pre_exit(struct net *net)
 	bond_destroy_sysfs(bn);
 }
 
-static void __net_exit bond_net_exit_batch_rtnl(struct list_head *net_list,
-						struct list_head *dev_kill_list)
+static void __net_exit bond_net_exit_rtnl(struct net *net,
+					  struct list_head *dev_kill_list)
 {
-	struct bond_net *bn;
-	struct net *net;
+	struct bond_net *bn = net_generic(net, bond_net_id);
+	struct bonding *bond, *tmp_bond;
 
 	/* Kill off any bonds created after unregistering bond rtnl ops */
-	list_for_each_entry(net, net_list, exit_list) {
-		struct bonding *bond, *tmp_bond;
-
-		bn = net_generic(net, bond_net_id);
-		list_for_each_entry_safe(bond, tmp_bond, &bn->dev_list, bond_list)
-			unregister_netdevice_queue(bond->dev, dev_kill_list);
-	}
+	list_for_each_entry_safe(bond, tmp_bond, &bn->dev_list, bond_list)
+		unregister_netdevice_queue(bond->dev, dev_kill_list);
 }
 
 /* According to commit 23fa5c2caae0 ("bonding: destroy proc directory
  * only after all bonds are gone") bond_destroy_proc_dir() is called
- * after bond_net_exit_batch_rtnl() has completed.
+ * after bond_net_exit_rtnl() has completed.
  */
 static void __net_exit bond_net_exit_batch(struct list_head *net_list)
 {
@@ -6601,7 +6596,7 @@ static void __net_exit bond_net_exit_batch(struct list_head *net_list)
 static struct pernet_operations bond_net_ops = {
 	.init = bond_net_init,
 	.pre_exit = bond_net_pre_exit,
-	.exit_batch_rtnl = bond_net_exit_batch_rtnl,
+	.exit_rtnl = bond_net_exit_rtnl,
 	.exit_batch = bond_net_exit_batch,
 	.id   = &bond_net_id,
 	.size = sizeof(struct bond_net),
-- 
2.49.0



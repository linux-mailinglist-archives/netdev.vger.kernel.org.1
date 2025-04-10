Return-Path: <netdev+bounces-181027-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B866FA8367E
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 04:27:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 462CF3BC747
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 02:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 458711C860A;
	Thu, 10 Apr 2025 02:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="kSu/iYvS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34BC1C863A
	for <netdev@vger.kernel.org>; Thu, 10 Apr 2025 02:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744251869; cv=none; b=uLWYdNO54Fnjhra1IsVt80q4G/s8Fvqds+g/Ti2ny4rio/9jeaY+LvyqovXx5SgYg7zOfYp7i3ECkBy/6j3wLQe9PGFJ42dJ5OlMXaY44Q6Kbf8M6x+fvvKQfzwaBNQv6VDv4T8xETLHriUcO7Z/HbPy1jrhyR4Jp+KnToHLydg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744251869; c=relaxed/simple;
	bh=4PQZEaeT7rfM0K/pEb0+8s2BkV6CJYSAwXljWX7xq5A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ARYZ0dUgM4EHYnXyGQE8orfnXn/SqCrqzuzyAx8XzRvEiCcpRCHuq+1HFMF2qTID378G6ouoH4IvpN6FaXjvFqlbdxYfzHsJ54DFPUnnGkpXDDsD9an6im/7slvpzsMECAcvpPgvPzVUg2CyJWWgvaDHPEbDcE0gv+dUGg9v76k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=kSu/iYvS; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744251868; x=1775787868;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KmNjNT+z57ynH6RN4caiy929Q6I33LdsgxCs0G2q2to=;
  b=kSu/iYvS41HmQwxAffMXks9dJDJgpBJwTaBKOHGydB8qWmNLUUYGCHd/
   ovPIiorkRDHqbblr88ZfgfggWQM3oLZg/VcEx6I5JcPDJb8v2CSirCYAR
   z9EUQIEhUsTaiEY35ZTrLhMK5kdgEWuEVh9gS5ytc9NMam9eAgmVeGjCh
   A=;
X-IronPort-AV: E=Sophos;i="6.15,201,1739836800"; 
   d="scan'208";a="510310372"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 02:24:21 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.21.151:26549]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.25.120:2525] with esmtp (Farcaster)
 id 73db5625-c922-4a3e-839a-3ebe959d56c7; Thu, 10 Apr 2025 02:24:19 +0000 (UTC)
X-Farcaster-Flow-ID: 73db5625-c922-4a3e-839a-3ebe959d56c7
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 10 Apr 2025 02:24:18 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.170.41) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 10 Apr 2025 02:24:16 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>, "Jay
 Vosburgh" <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>
Subject: [PATCH v1 net-next 10/14] bonding: Convert bond_net_exit_batch_rtnl() to ->exit_rtnl().
Date: Wed, 9 Apr 2025 19:19:31 -0700
Message-ID: <20250410022004.8668-11-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D039UWA002.ant.amazon.com (10.13.139.32) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

bond_net_exit_batch_rtnl() iterates the dying netns list and
performs the same operation for each.

Let's use ->exit_rtnl().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
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



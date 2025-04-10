Return-Path: <netdev+bounces-181029-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C64BDA8367C
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 04:26:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8F7F441B91
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 02:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11AE01C878E;
	Thu, 10 Apr 2025 02:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="nHD7wCsl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DCE81C860A
	for <netdev@vger.kernel.org>; Thu, 10 Apr 2025 02:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744251913; cv=none; b=ODyAiuGYfBqLuFz/ozd9jQT6ryPSN0NQvkggDIetPdP0lp9zrJAlTAqDUuXsEKgin3BNjvh0g/Jv3gJNrXc6X0J1rzS9JMmdNfwKnsW32r9grVXtjc/S0ccmGXEWHc297E37VhLkFn6dDOvBP/arWesI9WI8Q1jJS8cnYcY2tvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744251913; c=relaxed/simple;
	bh=aiiPRud64xLR8NblqFGmdfDbSNbkKXkC3DHGL6X1ZEM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BPgbHIqQ9sseJVQlU8MpAcFM4/qPnBRUQy2kAZ1rxB+OGLF38eD+2d0N9sVqAf5I8MzMVdqOGEfEuKv6EO1Xd4Dt7zsplLSFp0265O76bsMcqHilxQE5JBD7iyJx1+0wB+4xX637tZSPkwD8VTJW2bRVzYwAaoJe/0wqw59KguE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=nHD7wCsl; arc=none smtp.client-ip=99.78.197.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744251912; x=1775787912;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Yv7ULPRpSJV5KAIIxDMe3vCo+vZURCyYDLTVyVKQtoM=;
  b=nHD7wCslZ8nSNaiUZ5iTWe120g5nZMg6xGFCod3aOsV1nt5Glq2nxRYa
   +rUqEOYVKyNWHsCxcfZel9mIfR1w8FRIqQqIUnF+t3QkRYSkWQdH8exrR
   HpU269alGZq1ARTEbBEGXn5QsC+WBWLgS4oimTvDPtZlMf84p8bmoaYAV
   E=;
X-IronPort-AV: E=Sophos;i="6.15,201,1739836800"; 
   d="scan'208";a="39349847"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 02:25:11 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.7.35:30871]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.62.147:2525] with esmtp (Farcaster)
 id 06c5d451-b0ba-45d7-a4e6-e0ee6798c1d4; Thu, 10 Apr 2025 02:25:10 +0000 (UTC)
X-Farcaster-Flow-ID: 06c5d451-b0ba-45d7-a4e6-e0ee6798c1d4
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 10 Apr 2025 02:25:07 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.170.41) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 10 Apr 2025 02:25:05 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>, Andrew Lunn
	<andrew+netdev@lunn.ch>
Subject: [PATCH v1 net-next 12/14] bareudp: Convert bareudp_exit_batch_rtnl() to ->exit_rtnl().
Date: Wed, 9 Apr 2025 19:19:33 -0700
Message-ID: <20250410022004.8668-13-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D043UWA002.ant.amazon.com (10.13.139.53) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

bareudp_exit_batch_rtnl() iterates the dying netns list and performs the
same operation for each.

Let's use ->exit_rtnl().

While at it, we replace unregister_netdevice_queue() with
bareudp_dellink() for better cleanup.  It unlinks the device
from net_generic(net, bareudp_net_id)->bareudp_list, but there
is no real issue as both the dev and the list are freed later.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
Cc: Andrew Lunn <andrew+netdev@lunn.ch>
---
 drivers/net/bareudp.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/net/bareudp.c b/drivers/net/bareudp.c
index d1473c5f8eef..a9dffdcac805 100644
--- a/drivers/net/bareudp.c
+++ b/drivers/net/bareudp.c
@@ -777,27 +777,19 @@ static __net_init int bareudp_init_net(struct net *net)
 	return 0;
 }
 
-static void bareudp_destroy_tunnels(struct net *net, struct list_head *head)
+static void __net_exit bareudp_exit_rtnl_net(struct net *net,
+					     struct list_head *dev_kill_list)
 {
 	struct bareudp_net *bn = net_generic(net, bareudp_net_id);
 	struct bareudp_dev *bareudp, *next;
 
 	list_for_each_entry_safe(bareudp, next, &bn->bareudp_list, next)
-		unregister_netdevice_queue(bareudp->dev, head);
-}
-
-static void __net_exit bareudp_exit_batch_rtnl(struct list_head *net_list,
-					       struct list_head *dev_kill_list)
-{
-	struct net *net;
-
-	list_for_each_entry(net, net_list, exit_list)
-		bareudp_destroy_tunnels(net, dev_kill_list);
+		bareudp_dellink(bareudp->dev, dev_kill_list);
 }
 
 static struct pernet_operations bareudp_net_ops = {
 	.init = bareudp_init_net,
-	.exit_batch_rtnl = bareudp_exit_batch_rtnl,
+	.exit_rtnl = bareudp_exit_rtnl_net,
 	.id   = &bareudp_net_id,
 	.size = sizeof(struct bareudp_net),
 };
-- 
2.49.0



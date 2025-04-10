Return-Path: <netdev+bounces-181026-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88370A8367D
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 04:27:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 678903B7FEC
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 02:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 771811C860A;
	Thu, 10 Apr 2025 02:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="c/8+nxHS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B426B15624D
	for <netdev@vger.kernel.org>; Thu, 10 Apr 2025 02:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744251839; cv=none; b=OKJD+pIgC3ryb6VLrFdgM1u8JfjrdHRvsuIXNoz6Ad2u2XGuiJEJz8bohrtqS2wGe7DhDjvOXntl+PeA6IgLY4qMPO9z+E2dloPU5yT/B7bedBUd8XuSdfUqCTg/l2xC6KlzqV9KjpHYCp1TwYjPYiUObEG+jVHLxRb2atdEHp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744251839; c=relaxed/simple;
	bh=GslO7q+77znvHFnD+jo1Svma/yOunj2u8W8FmDP2Nfk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lOE7IArJPpVIQCFfEvQq5NzHD81DI4xjM4vdqS9oGm6/YdwJFN2d8Hq0bauehmRbVgTCXS6emwArvJT9Cp1BoVWxXT2/EcH/r0t6s+DwMl3WVNru3KX8mLf4B5V6nACQ6nG7kHW5Huf0THMm9BpO6JE6ACoEZsGJ2NO45ECEm5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=c/8+nxHS; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744251839; x=1775787839;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ii2tmLktfeHDXdIexRcSbaXe+USlxZD1A9h9Wk6diog=;
  b=c/8+nxHSadKrcPGhfn/N15fhOcyVsx/bKqpIut8e88cK2xhPSix4usYU
   288djIeOau3VV65tJ4pkFoJIlHHnW31QXaoUZLd4/I8ODo1qu6z/8Y+Az
   S261c5cbMg/q+IJrteXNjv44Qrx2NHTXu55/nMn21dWy4FZGG0iBA6eov
   M=;
X-IronPort-AV: E=Sophos;i="6.15,201,1739836800"; 
   d="scan'208";a="488161184"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 02:23:57 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.7.35:34683]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.8.63:2525] with esmtp (Farcaster)
 id 847ad529-cc48-42a1-85da-14479dc6ec5d; Thu, 10 Apr 2025 02:23:55 +0000 (UTC)
X-Farcaster-Flow-ID: 847ad529-cc48-42a1-85da-14479dc6ec5d
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 10 Apr 2025 02:23:54 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.170.41) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 10 Apr 2025 02:23:52 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>, "Nikolay
 Aleksandrov" <razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH v1 net-next 09/14] bridge: Convert br_net_exit_batch_rtnl() to ->exit_rtnl().
Date: Wed, 9 Apr 2025 19:19:30 -0700
Message-ID: <20250410022004.8668-10-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D032UWA004.ant.amazon.com (10.13.139.56) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

br_net_exit_batch_rtnl() iterates the dying netns list and
performs the same operation for each.

Let's use ->exit_rtnl().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
Cc: Nikolay Aleksandrov <razor@blackwall.org>
Cc: Ido Schimmel <idosch@nvidia.com>
---
 net/bridge/br.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/net/bridge/br.c b/net/bridge/br.c
index 183fcb362f9e..c16913aac84c 100644
--- a/net/bridge/br.c
+++ b/net/bridge/br.c
@@ -363,21 +363,20 @@ void br_opt_toggle(struct net_bridge *br, enum net_bridge_opts opt, bool on)
 		clear_bit(opt, &br->options);
 }
 
-static void __net_exit br_net_exit_batch_rtnl(struct list_head *net_list,
-					      struct list_head *dev_to_kill)
+static void __net_exit br_net_exit_rtnl(struct net *net,
+					struct list_head *dev_to_kill)
 {
 	struct net_device *dev;
-	struct net *net;
 
-	ASSERT_RTNL();
-	list_for_each_entry(net, net_list, exit_list)
-		for_each_netdev(net, dev)
-			if (netif_is_bridge_master(dev))
-				br_dev_delete(dev, dev_to_kill);
+	ASSERT_RTNL_NET(net);
+
+	for_each_netdev(net, dev)
+		if (netif_is_bridge_master(dev))
+			br_dev_delete(dev, dev_to_kill);
 }
 
 static struct pernet_operations br_net_ops = {
-	.exit_batch_rtnl = br_net_exit_batch_rtnl,
+	.exit_rtnl = br_net_exit_rtnl,
 };
 
 static const struct stp_proto br_stp_proto = {
-- 
2.49.0



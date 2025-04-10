Return-Path: <netdev+bounces-181022-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 318FBA83673
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 04:24:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CA3B4A050C
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 02:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E841C1D5AD4;
	Thu, 10 Apr 2025 02:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="bWJokUds"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676761C860A
	for <netdev@vger.kernel.org>; Thu, 10 Apr 2025 02:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744251741; cv=none; b=YzK2e+c+qnijTof/oww5dxoPE33/ohumo0KdIrt2sWXHGGeq8JTX0PRWmSWHKgqSWuzj5H/w9W48kAUI70etlEqcByHW5Dh0kWCBOAI/v9qX1wAcm+QUou6o0j1D/KFKdtWSgC9q0aYxX5eqwbOa5clL6FwLdBQTMwPbtaMDEbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744251741; c=relaxed/simple;
	bh=+WlQLh5fmdaqtlqCt1fkM95f9TyobJLG5Eb3bs1kbtQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JYT12hOafpuxM5lnInXDtmuV+iYNHWH1gqd3Ev28CQt/AomraSkwdnwRoSQ7XhL5xxqJVF3EekYQb35i8jGNkKxjcZWmUmAPzkwrYwBkWM1m3laFI2qcuIpFs4NIWFww91EXnljhot/7ME/Ka2OG4DCM2KhbfQBqsQx9wpcfVqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=bWJokUds; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744251740; x=1775787740;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IYDdzJWgADjuk0pAxGK30TDXqcum5E1EPkmjknabwkY=;
  b=bWJokUdshEYqSiUvwDEoy+J1FilvZQhYxFuwC906hfiWgTiiUqMaKqFI
   HeGEZgbc9apNb6oTFL4Wy/LpudPmN34UmNoJUQZq5KTZe1B4/YMcnPwmZ
   NChj73J6ztc0osSmOFY5NoZqu55gRp4Os+2js2s+/IRpmBv3WghCar9Yu
   4=;
X-IronPort-AV: E=Sophos;i="6.15,201,1739836800"; 
   d="scan'208";a="189833877"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 02:22:18 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.38.20:53223]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.14.132:2525] with esmtp (Farcaster)
 id 84d96226-d211-49c2-ac4c-f277a8d648f4; Thu, 10 Apr 2025 02:22:18 +0000 (UTC)
X-Farcaster-Flow-ID: 84d96226-d211-49c2-ac4c-f277a8d648f4
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 10 Apr 2025 02:22:17 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.170.41) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 10 Apr 2025 02:22:14 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>, Andrew Lunn
	<andrew+netdev@lunn.ch>
Subject: [PATCH v1 net-next 05/14] vxlan: Convert vxlan_exit_batch_rtnl() to ->exit_rtnl().
Date: Wed, 9 Apr 2025 19:19:26 -0700
Message-ID: <20250410022004.8668-6-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D038UWC002.ant.amazon.com (10.13.139.238) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

vxlan_exit_batch_rtnl() iterates the dying netns list and
performs the same operations for each.

Let's use ->exit_rtnl().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
Cc: Andrew Lunn <andrew+netdev@lunn.ch>
---
 drivers/net/vxlan/vxlan_core.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 8c49e903cb3a..6ee61334719b 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -4966,19 +4966,15 @@ static void __net_exit vxlan_destroy_tunnels(struct vxlan_net *vn,
 		vxlan_dellink(vxlan->dev, dev_to_kill);
 }
 
-static void __net_exit vxlan_exit_batch_rtnl(struct list_head *net_list,
-					     struct list_head *dev_to_kill)
+static void __net_exit vxlan_exit_rtnl(struct net *net,
+				       struct list_head *dev_to_kill)
 {
-	struct net *net;
-
-	ASSERT_RTNL();
-	list_for_each_entry(net, net_list, exit_list) {
-		struct vxlan_net *vn = net_generic(net, vxlan_net_id);
+	struct vxlan_net *vn = net_generic(net, vxlan_net_id);
 
-		__unregister_nexthop_notifier(net, &vn->nexthop_notifier_block);
+	ASSERT_RTNL_NET(net);
 
-		vxlan_destroy_tunnels(vn, dev_to_kill);
-	}
+	__unregister_nexthop_notifier(net, &vn->nexthop_notifier_block);
+	vxlan_destroy_tunnels(vn, dev_to_kill);
 }
 
 static void __net_exit vxlan_exit_net(struct net *net)
@@ -4992,7 +4988,7 @@ static void __net_exit vxlan_exit_net(struct net *net)
 
 static struct pernet_operations vxlan_net_ops = {
 	.init = vxlan_init_net,
-	.exit_batch_rtnl = vxlan_exit_batch_rtnl,
+	.exit_rtnl = vxlan_exit_rtnl,
 	.exit = vxlan_exit_net,
 	.id   = &vxlan_net_id,
 	.size = sizeof(struct vxlan_net),
-- 
2.49.0



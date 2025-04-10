Return-Path: <netdev+bounces-181021-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85D81A83679
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 04:25:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1210C3BEB3D
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 02:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 784221DF974;
	Thu, 10 Apr 2025 02:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="PvorKw3N"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9105.amazon.com (smtp-fw-9105.amazon.com [207.171.188.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E9A1D5166
	for <netdev@vger.kernel.org>; Thu, 10 Apr 2025 02:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744251720; cv=none; b=aAI/OXYuFdWTVIuWpVz/jOS2TKwJE6qcP57+m++5AZoafKY9saqMr3Cv0cccDw43iSFJqwly8w3UzQmyaBxDnE2SRu34atrNKxLExR3f1ftxCi5dce3YvxyFJMSsYkUcco0ZzvWy7zev1SuXNcqnTbHMlj5Z6AAiuCDy2KW3xs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744251720; c=relaxed/simple;
	bh=d7kc9KDPF5SGY6BmyxYoxbMUczwGY5GLmcgUDc3+K9c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=stEpGdkCtGFFR/DB2XeqCURyhzfPSAyZEqnTJJ7zhDkQtVAD1Q0m8V4u+XzLmEjk5rgTobuRZ9G4ZX8bZPBbOAsIDdHM6tWLG6pAfCBlcY6ky/6kFvm0Ljq23E3xFIgF5YrPrsf1xJdBcdH5IDc21U7Sg1Tau8zbp7zPFt6n/vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=PvorKw3N; arc=none smtp.client-ip=207.171.188.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744251719; x=1775787719;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gUz0sZBZN76ZNo598ZW3/d4PNnSGuF5h8/87eyIF1T0=;
  b=PvorKw3NH1Q/AOoKrnII30FeyCPKnsn+l2+bjAgPk5lCgex41jv/+wQl
   WQHSyv3T6CwwetNMA7TKnUmf0efMisyrFS2WjXQ0y9RfU6X2b67r90Pbp
   aMepYAmW5gPKxunBBcpOjPblBJmtqKLngmqmAEW/MEgnTk9Ub/I2c7irC
   U=;
X-IronPort-AV: E=Sophos;i="6.15,201,1739836800"; 
   d="scan'208";a="9125910"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9105.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 02:21:54 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.21.151:42066]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.51.140:2525] with esmtp (Farcaster)
 id 126f541f-09bd-4817-ba4c-7565016f2508; Thu, 10 Apr 2025 02:21:53 +0000 (UTC)
X-Farcaster-Flow-ID: 126f541f-09bd-4817-ba4c-7565016f2508
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 10 Apr 2025 02:21:53 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.170.41) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 10 Apr 2025 02:21:50 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>, David Ahern
	<dsahern@kernel.org>
Subject: [PATCH v1 net-next 04/14] nexthop: Convert nexthop_net_exit_batch_rtnl() to ->exit_rtnl().
Date: Wed, 9 Apr 2025 19:19:25 -0700
Message-ID: <20250410022004.8668-5-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D038UWC004.ant.amazon.com (10.13.139.229) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

nexthop_net_exit_batch_rtnl() iterates the dying netns list and
performs the same operation for each.

Let's use ->exit_rtnl().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
Cc: David Ahern <dsahern@kernel.org>
---
 net/ipv4/nexthop.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/net/ipv4/nexthop.c b/net/ipv4/nexthop.c
index 467151517023..d9cf06b297d1 100644
--- a/net/ipv4/nexthop.c
+++ b/net/ipv4/nexthop.c
@@ -4040,14 +4040,11 @@ void nexthop_res_grp_activity_update(struct net *net, u32 id, u16 num_buckets,
 }
 EXPORT_SYMBOL(nexthop_res_grp_activity_update);
 
-static void __net_exit nexthop_net_exit_batch_rtnl(struct list_head *net_list,
-						   struct list_head *dev_to_kill)
+static void __net_exit nexthop_net_exit_rtnl(struct net *net,
+					     struct list_head *dev_to_kill)
 {
-	struct net *net;
-
-	ASSERT_RTNL();
-	list_for_each_entry(net, net_list, exit_list)
-		flush_all_nexthops(net);
+	ASSERT_RTNL_NET(net);
+	flush_all_nexthops(net);
 }
 
 static void __net_exit nexthop_net_exit(struct net *net)
@@ -4072,7 +4069,7 @@ static int __net_init nexthop_net_init(struct net *net)
 static struct pernet_operations nexthop_net_ops = {
 	.init = nexthop_net_init,
 	.exit = nexthop_net_exit,
-	.exit_batch_rtnl = nexthop_net_exit_batch_rtnl,
+	.exit_rtnl = nexthop_net_exit_rtnl,
 };
 
 static const struct rtnl_msg_handler nexthop_rtnl_msg_handlers[] __initconst = {
-- 
2.49.0



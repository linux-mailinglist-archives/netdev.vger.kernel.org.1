Return-Path: <netdev+bounces-181030-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D0C1A8367F
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 04:27:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0550C3B0235
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 02:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C5191C878E;
	Thu, 10 Apr 2025 02:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="MU1kyT7V"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9105.amazon.com (smtp-fw-9105.amazon.com [207.171.188.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA181A2390
	for <netdev@vger.kernel.org>; Thu, 10 Apr 2025 02:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744251935; cv=none; b=esa8s2I8w6qdzqcc9rZQOTPc90xe2EqlRo+/VC1M26GBdELS1LWzeoSDDmsZV6DgGx8MzXlFkTLECWC0WONKF8Gp1oELUQSipRle+xt4Rlb+oazNc2OdPzQ6UN48KvAXtzxDUr9Oi343Ckij7DnKDcmCDto5Ki3ejStYTfO0Fb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744251935; c=relaxed/simple;
	bh=arycCvE5tN/bo+C9Z2l+YIbdxDtI5Ug9riv7CldsuIo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h34hTEal9jhUc1fes1/MD7E+uEGfQ+KkAbuezvQG3P5W/kDJDfpN6Wq1lbHUf5rV4IOqM/F2kSmKCzVdvqw/4r73RwvJhzHZU0yUHz6fx+ElnfeyuYoV+jxXLdECwLKXv8dYJuRy7uCbgbq9n8qMC5AlGiE5VWiJi2UlgiRu5Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=MU1kyT7V; arc=none smtp.client-ip=207.171.188.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744251934; x=1775787934;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=54SlZOB+0J7lyWUHULLwbFKzI7oVVRieJOy+8cSXss8=;
  b=MU1kyT7V/Z/5c1+jQRo9vFVOdKGlibOlxI0KzieCVcrNY4hjisMlr2zG
   kAUbjVcpIJwL8hTg0YoRSndvhACWqn7PssFFW7ASuL9qo9EUp1WW0tInL
   cJfFFwUt0vwhTruTLzANgyoeiwF153r2jdVZlDR5UWgdfrNWAEf0bNHHU
   4=;
X-IronPort-AV: E=Sophos;i="6.15,201,1739836800"; 
   d="scan'208";a="9126290"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9105.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 02:25:33 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.7.35:50064]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.25.120:2525] with esmtp (Farcaster)
 id a06f79f3-6cf1-457c-88a9-b68ae73de456; Thu, 10 Apr 2025 02:25:32 +0000 (UTC)
X-Farcaster-Flow-ID: a06f79f3-6cf1-457c-88a9-b68ae73de456
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 10 Apr 2025 02:25:31 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.170.41) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 10 Apr 2025 02:25:29 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>, Andrew Lunn
	<andrew+netdev@lunn.ch>
Subject: [PATCH v1 net-next 13/14] geneve: Convert geneve_exit_batch_rtnl() to ->exit_rtnl().
Date: Wed, 9 Apr 2025 19:19:34 -0700
Message-ID: <20250410022004.8668-14-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D033UWC002.ant.amazon.com (10.13.139.196) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

geneve_exit_batch_rtnl() iterates the dying netns list and
performs the same operation for each.

Let's use ->exit_rtnl().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
Cc: Andrew Lunn <andrew+netdev@lunn.ch>
---
 drivers/net/geneve.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
index 66e38ce9cd1d..ffc15a432689 100644
--- a/drivers/net/geneve.c
+++ b/drivers/net/geneve.c
@@ -1946,22 +1946,14 @@ static __net_init int geneve_init_net(struct net *net)
 	return 0;
 }
 
-static void geneve_destroy_tunnels(struct net *net, struct list_head *head)
+static void __net_exit geneve_exit_rtnl_net(struct net *net,
+					    struct list_head *dev_to_kill)
 {
 	struct geneve_net *gn = net_generic(net, geneve_net_id);
 	struct geneve_dev *geneve, *next;
 
 	list_for_each_entry_safe(geneve, next, &gn->geneve_list, next)
-		geneve_dellink(geneve->dev, head);
-}
-
-static void __net_exit geneve_exit_batch_rtnl(struct list_head *net_list,
-					      struct list_head *dev_to_kill)
-{
-	struct net *net;
-
-	list_for_each_entry(net, net_list, exit_list)
-		geneve_destroy_tunnels(net, dev_to_kill);
+		geneve_dellink(geneve->dev, dev_to_kill);
 }
 
 static void __net_exit geneve_exit_net(struct net *net)
@@ -1973,7 +1965,7 @@ static void __net_exit geneve_exit_net(struct net *net)
 
 static struct pernet_operations geneve_net_ops = {
 	.init = geneve_init_net,
-	.exit_batch_rtnl = geneve_exit_batch_rtnl,
+	.exit_rtnl = geneve_exit_rtnl_net,
 	.exit = geneve_exit_net,
 	.id   = &geneve_net_id,
 	.size = sizeof(struct geneve_net),
-- 
2.49.0



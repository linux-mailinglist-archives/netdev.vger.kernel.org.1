Return-Path: <netdev+bounces-166332-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 792D1A358B2
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 09:19:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 500B93ABD68
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 08:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CA0A22258F;
	Fri, 14 Feb 2025 08:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="lSKzBAOt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3B1222564
	for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 08:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739521162; cv=none; b=BlztamevIa4vqiwcQQTn7G+zQytjvwG4JyW4ingVAXaSyb/ulxlihiZOLbVcArA7vlzYcZj9nlIZ/G/xMj57+SvA2wbmmQN2Yl+mrFLzQSUbe2C0N23VKA74SVGcvDtPWLby3HhPmQkFVXtWQ+wXTMQZHjm5rmZCQ6CrQR9d8KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739521162; c=relaxed/simple;
	bh=VLBJuY7oCgJw0LKo9mxBuWijtAEJXjN0DxwoareQl5M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F0Ib7/Sldw9vkcIjmJ0IYqCxep+mNg+gtElQovg6lEr7csk6trJ7oGMLHk+Mi0MOTcOf0odbFD/VirmGFIyOxXC1GlBWvngY79tr9rtGBZmc5QjDqre0uG5jwkawjws84YQrrDy7p4GfT5xiTkrye3mYNXiby1ddgnxoOB/Y2uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=lSKzBAOt; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1739521161; x=1771057161;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3Leu2dT5qI9tz/h9yI2wGAVB7w/codXrefp3fDbh1eM=;
  b=lSKzBAOt3T/KkZrLQVJYU38zkRUhe7lRZMOeBzS1jZbfVW1wjrl8z+rs
   cczE+3hogY6qJCEg6I9hkFliqz1SpRvOX6/DyNMuAkD8DjNCN7X1SoIwy
   Sgq7Xi/3KYGHO6/kvXrRcF8fN6K/qMAQqCIcZBTJykqZJ4RAlAbn1qGOZ
   g=;
X-IronPort-AV: E=Sophos;i="6.13,285,1732579200"; 
   d="scan'208";a="271123782"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 08:19:05 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.7.35:1169]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.10.141:2525] with esmtp (Farcaster)
 id 23e23bed-b56b-4753-89eb-6f43ed1d6ea6; Fri, 14 Feb 2025 08:19:03 +0000 (UTC)
X-Farcaster-Flow-ID: 23e23bed-b56b-4753-89eb-6f43ed1d6ea6
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 14 Feb 2025 08:19:00 +0000
Received: from 6c7e67bfbae3.amazon.com (10.118.254.117) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 14 Feb 2025 08:18:56 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 1/3] pfcp: Convert pfcp_net_exit() to ->exit_batch_rtnl().
Date: Fri, 14 Feb 2025 17:18:16 +0900
Message-ID: <20250214081818.81658-2-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250214081818.81658-1-kuniyu@amazon.com>
References: <20250214081818.81658-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D046UWB001.ant.amazon.com (10.13.139.187) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

pfcp_net_exit() holds RTNL and calls unregister_netdevice_queue() for
dev in the netns.

Let's convert pfcp_net_exit() to ->exit_batch_rtnl to save RTNL dances
for each netns.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 drivers/net/pfcp.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/drivers/net/pfcp.c b/drivers/net/pfcp.c
index 68d0d9e92a22..5cb8635ada20 100644
--- a/drivers/net/pfcp.c
+++ b/drivers/net/pfcp.c
@@ -244,30 +244,35 @@ static int __net_init pfcp_net_init(struct net *net)
 	return 0;
 }
 
-static void __net_exit pfcp_net_exit(struct net *net)
+static void __net_exit pfcp_destroy_links(struct net *net,
+					  struct list_head *dev_kill_list)
 {
 	struct pfcp_net *pn = net_generic(net, pfcp_net_id);
 	struct pfcp_dev *pfcp, *pfcp_next;
 	struct net_device *dev;
-	LIST_HEAD(list);
 
-	rtnl_lock();
 	for_each_netdev(net, dev)
 		if (dev->rtnl_link_ops == &pfcp_link_ops)
-			pfcp_dellink(dev, &list);
+			pfcp_dellink(dev, dev_kill_list);
 
 	list_for_each_entry_safe(pfcp, pfcp_next, &pn->pfcp_dev_list, list)
-		pfcp_dellink(pfcp->dev, &list);
+		pfcp_dellink(pfcp->dev, dev_kill_list);
+}
+
+static void __net_exit pfcp_net_exit_batch_rtnl(struct list_head *net_exit_list,
+						struct list_head *dev_kill_list)
+{
+	struct net *net;
 
-	unregister_netdevice_many(&list);
-	rtnl_unlock();
+	list_for_each_entry(net, net_exit_list, exit_list)
+		pfcp_destroy_links(net, dev_kill_list);
 }
 
 static struct pernet_operations pfcp_net_ops = {
-	.init	= pfcp_net_init,
-	.exit	= pfcp_net_exit,
-	.id	= &pfcp_net_id,
-	.size	= sizeof(struct pfcp_net),
+	.init = pfcp_net_init,
+	.exit_batch_rtnl = pfcp_net_exit_batch_rtnl,
+	.id = &pfcp_net_id,
+	.size = sizeof(struct pfcp_net),
 };
 
 static int __init pfcp_init(void)
-- 
2.39.5 (Apple Git-154)



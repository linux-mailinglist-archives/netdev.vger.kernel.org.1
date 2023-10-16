Return-Path: <netdev+bounces-41546-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 456B57CB477
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 22:17:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37A0DB21090
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 20:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DB33374E8;
	Mon, 16 Oct 2023 20:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dcm2mikn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16078374D2
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 20:17:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AE19C433C7;
	Mon, 16 Oct 2023 20:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697487423;
	bh=sGSPN075c5HoiuRzD54d5Ke/Yq6FhIM7bQMUpCMuEls=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Dcm2miknVNjoNN2b+GlPWHe7rknh3654wEMK9FOpOXrT7BJq+Mmul+WWVRQQNkMcF
	 VpduJwDwZOqS+ciT0nSEf2/4iQSAGGzAKOkrx++25KUazFJpKJvCCP3KkbOQOKfkOb
	 TJSVoxY/l128DHpkv+/H565qe/cPLXIOwTnsMrkYd7XSET7/hMmVZu1xPoW1BnFS1h
	 lXiol4vfZO4tUWWv8nLA6P/riaFrC1BfthfH0ttJfLui8zEWktMaWq3e/nW36UOKFO
	 +HLfd2UKcQVZgs/PXslYiXDukR1e6fqaHHhY+IImUFyDqCkVEq4y/SjAbnj2STuC+s
	 zP5X882mylxRA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	jiri@resnulli.us
Subject: [PATCH net 3/5] net: avoid UAF on deleted altname
Date: Mon, 16 Oct 2023 13:16:55 -0700
Message-ID: <20231016201657.1754763-4-kuba@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231016201657.1754763-1-kuba@kernel.org>
References: <20231016201657.1754763-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Altnames are accessed under RCU (__dev_get_by_name())
but freed by kfree() with no synchronization point.

Because the name nodes don't hold a reference on the netdevice
either, take the heavier approach of inserting synchronization
points. Subsequent patch will remove the one added on device
deletion path.

Fixes: ff92741270bf ("net: introduce name_node struct to be used in hashlist")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: jiri@resnulli.us
---
 net/core/dev.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index f4fa2692cf6d..7d5107cd5792 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -345,7 +345,6 @@ int netdev_name_node_alt_create(struct net_device *dev, const char *name)
 static void __netdev_name_node_alt_destroy(struct netdev_name_node *name_node)
 {
 	list_del(&name_node->list);
-	netdev_name_node_del(name_node);
 	kfree(name_node->name);
 	netdev_name_node_free(name_node);
 }
@@ -364,6 +363,8 @@ int netdev_name_node_alt_destroy(struct net_device *dev, const char *name)
 	if (name_node == dev->name_node || name_node->dev != dev)
 		return -EINVAL;
 
+	netdev_name_node_del(name_node);
+	synchronize_rcu();
 	__netdev_name_node_alt_destroy(name_node);
 
 	return 0;
@@ -10937,6 +10938,7 @@ void unregister_netdevice_many_notify(struct list_head *head,
 	synchronize_net();
 
 	list_for_each_entry(dev, head, unreg_list) {
+		struct netdev_name_node *name_node;
 		struct sk_buff *skb = NULL;
 
 		/* Shutdown queueing discipline. */
@@ -10964,6 +10966,9 @@ void unregister_netdevice_many_notify(struct list_head *head,
 		dev_uc_flush(dev);
 		dev_mc_flush(dev);
 
+		netdev_for_each_altname(dev, name_node)
+			netdev_name_node_del(name_node);
+		synchronize_rcu();
 		netdev_name_node_alt_flush(dev);
 		netdev_name_node_free(dev->name_node);
 
-- 
2.41.0



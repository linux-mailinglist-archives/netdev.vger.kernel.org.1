Return-Path: <netdev+bounces-42101-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66C167CD1E0
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 03:38:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22E38281B66
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 01:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 821A44424;
	Wed, 18 Oct 2023 01:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ffNUzNen"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614F54412
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 01:38:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D870C433CC;
	Wed, 18 Oct 2023 01:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697593100;
	bh=Z3gUeFvG5ya2Zj4YcoDixIIJp9IcEcaHlthqu6CmM6A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ffNUzNenYG1Te6/Rk6HFGkY+ip/T5HNhUXf1RWTtkD2wenWgpAAP6WNoFck91RMI7
	 QzKmHsPTSVRiPdUkpjNM3mixk7z/zpEM+KZb/x+YxqQVHHjDRFsTDAKYms7DODsgmI
	 AwPVLXGZbjLwN+hKJHuOTejc7ulpxyAElnPqeneIEkIYAtMU0doq2n67EPA9wYfkOS
	 sgOKAxBB9e8JpvWaYu7oK9fCCh0dwH5KtuM6NNyiWgsKH7ukRvhOw+UUMhu95FiLlF
	 +lSNWBR+No2kP3MNZ6t+Lwr3HftrTWfQ5zst5S4dLFEgibEtk+d90J3B6bpX7T+tQT
	 Y7IiRnJ6phrJg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	jiri@resnulli.us,
	przemyslaw.kitszel@intel.com,
	daniel@iogearbox.net,
	Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@nvidia.com>
Subject: [PATCH net v2 3/5] net: avoid UAF on deleted altname
Date: Tue, 17 Oct 2023 18:38:15 -0700
Message-ID: <20231018013817.2391509-4-kuba@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231018013817.2391509-1-kuba@kernel.org>
References: <20231018013817.2391509-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Altnames are accessed under RCU (dev_get_by_name_rcu())
but freed by kfree() with no synchronization point.

Each node has one or two allocations (node and a variable-size
name, sometimes the name is netdev->name). Adding rcu_heads
here is a bit tedious. Besides most code which unlists the names
already has rcu barriers - so take the simpler approach of adding
synchronize_rcu(). Note that the one on the unregistration path
(which matters more) is removed by the next fix.

Fixes: ff92741270bf ("net: introduce name_node struct to be used in hashlist")
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2: update the commit msg a bit
---
 net/core/dev.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index ae557193b77c..559705aeefe4 100644
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
@@ -10941,6 +10942,7 @@ void unregister_netdevice_many_notify(struct list_head *head,
 	synchronize_net();
 
 	list_for_each_entry(dev, head, unreg_list) {
+		struct netdev_name_node *name_node;
 		struct sk_buff *skb = NULL;
 
 		/* Shutdown queueing discipline. */
@@ -10968,6 +10970,9 @@ void unregister_netdevice_many_notify(struct list_head *head,
 		dev_uc_flush(dev);
 		dev_mc_flush(dev);
 
+		netdev_for_each_altname(dev, name_node)
+			netdev_name_node_del(name_node);
+		synchronize_rcu();
 		netdev_name_node_alt_flush(dev);
 		netdev_name_node_free(dev->name_node);
 
-- 
2.41.0



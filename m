Return-Path: <netdev+bounces-41547-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B1027CB479
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 22:17:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F8C9B21119
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 20:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D3E5381A5;
	Mon, 16 Oct 2023 20:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o1cNis9B"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74CF37CB6
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 20:17:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 171C2C43395;
	Mon, 16 Oct 2023 20:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697487424;
	bh=dmLGkf3W9ZuOj5bz5D5W7vOdov6Jq49XaOaT6bjzt70=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o1cNis9BZxUIvLEo8dAyd7ezb3weXRGhELlLRtJM+7hTvhxuOxkg36beeAv7AN7jt
	 HyGt194I7HcTHU3IXPWucbiPir3A1Z8D6RMF3SPUQNEtQArXeRO5I7QWuIXlClmpFz
	 Wwr2HJN+YiBtC3uNNqgmbCBDeBfvPGSJVoHSvqhYX4vlWrsLToVDJsYk1/I4U0uFb/
	 6uXLGX2mTDTaNvSK9mRYhtSaEcuur5rAgQJzoh5WrpI0lmChYfiJOa9IOzqwPul4zq
	 /CLc3nIe52gVvZ3DXIE38ei5Z0C8GscAQryMd3xkx9IzPiEoWK9JpU4EhGdl/8blUp
	 mn26LlNAOdiZg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	jiri@resnulli.us
Subject: [PATCH net 4/5] net: move altnames together with the netdevice
Date: Mon, 16 Oct 2023 13:16:56 -0700
Message-ID: <20231016201657.1754763-5-kuba@kernel.org>
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

The altname nodes are currently not moved to the new netns
when netdevice itself moves:

  [ ~]# ip netns add test
  [ ~]# ip -netns test link add name eth0 type dummy
  [ ~]# ip -netns test link property add dev eth0 altname some-name
  [ ~]# ip -netns test link show dev some-name
  2: eth0: <BROADCAST,NOARP> mtu 1500 qdisc noop state DOWN mode DEFAULT group default qlen 1000
      link/ether 1e:67:ed:19:3d:24 brd ff:ff:ff:ff:ff:ff
      altname some-name
  [ ~]# ip -netns test link set dev eth0 netns 1
  [ ~]# ip link
  ...
  3: eth0: <BROADCAST,NOARP> mtu 1500 qdisc noop state DOWN mode DEFAULT group default qlen 1000
      link/ether 02:40:88:62:ec:b8 brd ff:ff:ff:ff:ff:ff
      altname some-name
  [ ~]# ip li show dev some-name
  Device "some-name" does not exist.

Remove them from the hash table when device is unlisted
and add back when listed again.

Fixes: 36fbf1e52bd3 ("net: rtnetlink: add linkprop commands to add and delete alternative ifnames")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: jiri@resnulli.us
---
 net/core/dev.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 7d5107cd5792..25a8321ecdbf 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -381,6 +381,7 @@ static void netdev_name_node_alt_flush(struct net_device *dev)
 /* Device list insertion */
 static void list_netdevice(struct net_device *dev)
 {
+	struct netdev_name_node *name_node;
 	struct net *net = dev_net(dev);
 
 	ASSERT_RTNL();
@@ -391,6 +392,10 @@ static void list_netdevice(struct net_device *dev)
 	hlist_add_head_rcu(&dev->index_hlist,
 			   dev_index_hash(net, dev->ifindex));
 	write_unlock(&dev_base_lock);
+
+	netdev_for_each_altname(dev, name_node)
+		netdev_name_node_add(net, name_node);
+
 	/* We reserved the ifindex, this can't fail */
 	WARN_ON(xa_store(&net->dev_by_index, dev->ifindex, dev, GFP_KERNEL));
 
@@ -402,12 +407,16 @@ static void list_netdevice(struct net_device *dev)
  */
 static void unlist_netdevice(struct net_device *dev, bool lock)
 {
+	struct netdev_name_node *name_node;
 	struct net *net = dev_net(dev);
 
 	ASSERT_RTNL();
 
 	xa_erase(&net->dev_by_index, dev->ifindex);
 
+	netdev_for_each_altname(dev, name_node)
+		netdev_name_node_del(name_node);
+
 	/* Unlink dev from the device chain */
 	if (lock)
 		write_lock(&dev_base_lock);
@@ -10938,7 +10947,6 @@ void unregister_netdevice_many_notify(struct list_head *head,
 	synchronize_net();
 
 	list_for_each_entry(dev, head, unreg_list) {
-		struct netdev_name_node *name_node;
 		struct sk_buff *skb = NULL;
 
 		/* Shutdown queueing discipline. */
@@ -10966,9 +10974,6 @@ void unregister_netdevice_many_notify(struct list_head *head,
 		dev_uc_flush(dev);
 		dev_mc_flush(dev);
 
-		netdev_for_each_altname(dev, name_node)
-			netdev_name_node_del(name_node);
-		synchronize_rcu();
 		netdev_name_node_alt_flush(dev);
 		netdev_name_node_free(dev->name_node);
 
-- 
2.41.0



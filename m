Return-Path: <netdev+bounces-41545-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D0EA7CB476
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 22:17:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF6101C20C8A
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 20:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF56374DC;
	Mon, 16 Oct 2023 20:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OD2rfkau"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE15837178
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 20:17:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C4DEC433C9;
	Mon, 16 Oct 2023 20:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697487423;
	bh=jIMYJZdLSkIjGhV+sa8/zN79aQ1+r4oyWNEsEnAiRtA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OD2rfkauCejGrdo1+gvNdyygx2aTWDd0Niij7iUwY1oR8NDyPuyQtj4RXBHGLtLC9
	 BLC3LHnb2Ot9Y6/Vhowg5Lu/IE03bQTJ5MChzJBxbVOtBBSM/EXW+KwAvYyEXR3rUX
	 6lSSiCIBB84p2Lk6rV3aKh9yRVXpdd58ppW3MlO899zo/xqughZexUEWkkcwPtf44U
	 TdSeY/gCjkRGHtAaXV4Hife0wzRnDfuCu7n20oSa3zwYFIHU0F3jiGkE3JDBRLw1r6
	 2AtxP/VRdpwdwm9EBWZt+hnZKXPtC70ow0Hd1cHCUBJ0gsnE87P+aRj+RmRfRseMeM
	 ZLTfaw3+ltSJQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	gnault@redhat.com,
	liuhangbin@gmail.com,
	lucien.xin@gmail.com,
	jiri@resnulli.us
Subject: [PATCH net 2/5] net: check for altname conflicts when changing netdev's netns
Date: Mon, 16 Oct 2023 13:16:54 -0700
Message-ID: <20231016201657.1754763-3-kuba@kernel.org>
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

It's currently possible to create an altname conflicting
with an altname or real name of another device by creating
it in another netns and moving it over:

 [ ~]$ ip link add dev eth0 type dummy

 [ ~]$ ip netns add test
 [ ~]$ ip -netns test link add dev ethX netns test type dummy
 [ ~]$ ip -netns test link property add dev ethX altname eth0
 [ ~]$ ip -netns test link set dev ethX netns 1

 [ ~]$ ip link
 ...
 3: eth0: <BROADCAST,NOARP> mtu 1500 qdisc noop state DOWN mode DEFAULT group default qlen 1000
     link/ether 02:40:88:62:ec:b8 brd ff:ff:ff:ff:ff:ff
 ...
 5: ethX: <BROADCAST,NOARP> mtu 1500 qdisc noop state DOWN mode DEFAULT group default qlen 1000
     link/ether 26:b7:28:78:38:0f brd ff:ff:ff:ff:ff:ff
     altname eth0

Create a macro for walking the altnames, this hopefully makes
it clearer that the list we walk contains only altnames.
Which is otherwise not entirely intuitive.

Fixes: 36fbf1e52bd3 ("net: rtnetlink: add linkprop commands to add and delete alternative ifnames")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: gnault@redhat.com
CC: liuhangbin@gmail.com
CC: lucien.xin@gmail.com
CC: jiri@resnulli.us
---
 net/core/dev.c | 9 ++++++++-
 net/core/dev.h | 3 +++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index b08031957ffe..f4fa2692cf6d 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -1086,7 +1086,8 @@ static int __dev_alloc_name(struct net *net, const char *name, char *buf)
 
 		for_each_netdev(net, d) {
 			struct netdev_name_node *name_node;
-			list_for_each_entry(name_node, &d->name_node->list, list) {
+
+			netdev_for_each_altname(d, name_node) {
 				if (!sscanf(name_node->name, name, &i))
 					continue;
 				if (i < 0 || i >= max_netdevices)
@@ -11047,6 +11048,7 @@ EXPORT_SYMBOL(unregister_netdev);
 int __dev_change_net_namespace(struct net_device *dev, struct net *net,
 			       const char *pat, int new_ifindex)
 {
+	struct netdev_name_node *name_node;
 	struct net *net_old = dev_net(dev);
 	char new_name[IFNAMSIZ] = {};
 	int err, new_nsid;
@@ -11079,6 +11081,11 @@ int __dev_change_net_namespace(struct net_device *dev, struct net *net,
 		if (err < 0)
 			goto out;
 	}
+	/* Check that none of the altnames conflicts. */
+	err = -EEXIST;
+	netdev_for_each_altname(dev, name_node)
+		if (netdev_name_in_use(net, name_node->name))
+			goto out;
 
 	/* Check that new_ifindex isn't used yet. */
 	if (new_ifindex) {
diff --git a/net/core/dev.h b/net/core/dev.h
index e075e198092c..d093be175bd0 100644
--- a/net/core/dev.h
+++ b/net/core/dev.h
@@ -62,6 +62,9 @@ struct netdev_name_node {
 int netdev_get_name(struct net *net, char *name, int ifindex);
 int dev_change_name(struct net_device *dev, const char *newname);
 
+#define netdev_for_each_altname(dev, name_node)				\
+	list_for_each_entry((name_node), &(dev)->name_node->list, list)
+
 int netdev_name_node_alt_create(struct net_device *dev, const char *name);
 int netdev_name_node_alt_destroy(struct net_device *dev, const char *name);
 
-- 
2.41.0



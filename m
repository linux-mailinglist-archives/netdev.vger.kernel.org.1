Return-Path: <netdev+bounces-42100-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A8447CD1DF
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 03:38:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7DDF281B8E
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 01:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6F2F1C05;
	Wed, 18 Oct 2023 01:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="taihSi1/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973C11843
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 01:38:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0748EC433CB;
	Wed, 18 Oct 2023 01:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697593100;
	bh=YlwdxOxkqtA79vhQQTJArnozued5GrXVX22YX2cvv6M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=taihSi1/z6YU3bip7qUyx/sQrSPbLKOAfC4qumGHbCd5z1NkCwBh2jDKg7fnia6Eh
	 HUkZYW1ZOvHqjw7pEClCCwBl8VjMf683rht4UOH71Bcr21v5ZBoMkg5773pJE9MB5y
	 Z+6FVOdsfubkTUMC71aNMBW+a2BR7SVk8aomyUi3r6oko9sQzrIsx0BbSh1aYrlal9
	 eXKNGbtzU+ifKYXQHCr8IuVQNmBC/gmlGGhXv5Z5AaLtNlxdHvQIU2Xo1TgbBfhIIQ
	 HQzcCBJEhSRFUQJF+/Qy7BRrPKWSzjIF03WdCiizj3XEDV/J95u6TtzIc0yQNvznZ4
	 BkSDX6nS6D0wQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	jiri@resnulli.us,
	przemyslaw.kitszel@intel.com,
	daniel@iogearbox.net,
	Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@nvidia.com>,
	gnault@redhat.com,
	liuhangbin@gmail.com,
	lucien.xin@gmail.com
Subject: [PATCH net v2 2/5] net: check for altname conflicts when changing netdev's netns
Date: Tue, 17 Oct 2023 18:38:14 -0700
Message-ID: <20231018013817.2391509-3-kuba@kernel.org>
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
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: gnault@redhat.com
CC: liuhangbin@gmail.com
CC: lucien.xin@gmail.com
---
 net/core/dev.c | 9 ++++++++-
 net/core/dev.h | 3 +++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index f109ad34d660..ae557193b77c 100644
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
@@ -11051,6 +11052,7 @@ EXPORT_SYMBOL(unregister_netdev);
 int __dev_change_net_namespace(struct net_device *dev, struct net *net,
 			       const char *pat, int new_ifindex)
 {
+	struct netdev_name_node *name_node;
 	struct net *net_old = dev_net(dev);
 	char new_name[IFNAMSIZ] = {};
 	int err, new_nsid;
@@ -11083,6 +11085,11 @@ int __dev_change_net_namespace(struct net_device *dev, struct net *net,
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
index e075e198092c..fa2e9c5c4122 100644
--- a/net/core/dev.h
+++ b/net/core/dev.h
@@ -62,6 +62,9 @@ struct netdev_name_node {
 int netdev_get_name(struct net *net, char *name, int ifindex);
 int dev_change_name(struct net_device *dev, const char *newname);
 
+#define netdev_for_each_altname(dev, namenode)				\
+	list_for_each_entry((namenode), &(dev)->name_node->list, list)
+
 int netdev_name_node_alt_create(struct net_device *dev, const char *name);
 int netdev_name_node_alt_destroy(struct net_device *dev, const char *name);
 
-- 
2.41.0



Return-Path: <netdev+bounces-41544-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E34E7CB474
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 22:17:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7603F281785
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 20:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75B0337149;
	Mon, 16 Oct 2023 20:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lHKG6ygi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5843734CE3
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 20:17:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 868A9C433C7;
	Mon, 16 Oct 2023 20:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697487422;
	bh=3TnMjMxYjwPTAXjTP7ZccZQD14qQ31M1uIrL1rwlliM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lHKG6ygi9fFDKEUepnP3JOnyyu6DQAQyBDZUeQwOaA9e4t7D2SRUK7HKQKzlJFTNx
	 J2DpIfqgQDdQtB/tYBbyS0X2sunkbzHCfFA2ybjKYkSaVihpA82lLOVZEn0ANFpPDN
	 cwIAQXdqDzJi84owckzMQ3LraaZiJ/A/693KqHeeh/XJnjKlqp72fb3bxswA0KHHSK
	 s6e2zYfRtWh+zFCDkW93H2jTxt6BiJs16zTOmcxMGeEriU+mRpKHPL7YWUCdjZYMUh
	 4Om8mbrRhB1jzEV8wc8+2fMSO8VydpDYxrAr4Yr+SfN+ThhuUwaezHn4+vZDs2F0V2
	 7zgd92+GDoPFw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	daniel@iogearbox.net,
	opurdila@ixiacom.com
Subject: [PATCH net 1/5] net: fix ifname in netlink ntf during netns move
Date: Mon, 16 Oct 2023 13:16:53 -0700
Message-ID: <20231016201657.1754763-2-kuba@kernel.org>
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

dev_get_valid_name() overwrites the netdev's name on success.
This makes it hard to use in prepare-commit-like fashion,
where we do validation first, and "commit" to the change
later.

Factor out a helper which lets us save the new name to a buffer.
Use it to fix the problem of notification on netns move having
incorrect name:

 5: eth0: <BROADCAST,NOARP> mtu 1500 qdisc noop state DOWN group default
     link/ether be:4d:58:f9:d5:40 brd ff:ff:ff:ff:ff:ff
 6: eth1: <BROADCAST,NOARP> mtu 1500 qdisc noop state DOWN group default
     link/ether 1e:4a:34:36:e3:cd brd ff:ff:ff:ff:ff:ff

 [ ~]# ip link set dev eth0 netns 1 name eth1

ip monitor inside netns:
 Deleted inet eth0
 Deleted inet6 eth0
 Deleted 5: eth1: <BROADCAST,NOARP> mtu 1500 qdisc noop state DOWN group default
     link/ether be:4d:58:f9:d5:40 brd ff:ff:ff:ff:ff:ff new-netnsid 0 new-ifindex 7

Name is reported as eth1 in old netns for ifindex 5, already renamed.

Fixes: d90310243fd7 ("net: device name allocation cleanups")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: daniel@iogearbox.net
CC: opurdila@ixiacom.com
---
 net/core/dev.c | 42 ++++++++++++++++++++++++++++--------------
 1 file changed, 28 insertions(+), 14 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 5aaf5753d4e4..b08031957ffe 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -1157,22 +1157,32 @@ int dev_alloc_name(struct net_device *dev, const char *name)
 }
 EXPORT_SYMBOL(dev_alloc_name);
 
+static int dev_prep_valid_name(struct net *net, struct net_device *dev,
+			       const char *want_name, char *out_name)
+{
+	int ret;
+
+	BUG_ON(!net);
+
+	if (!dev_valid_name(want_name))
+		return -EINVAL;
+
+	if (strchr(want_name, '%')) {
+		ret = __dev_alloc_name(net, want_name, out_name);
+		return ret < 0 ? ret : 0;
+	} else if (netdev_name_in_use(net, want_name)) {
+		return -EEXIST;
+	} else if (out_name != want_name) {
+		strscpy(out_name, want_name, IFNAMSIZ);
+	}
+
+	return 0;
+}
+
 static int dev_get_valid_name(struct net *net, struct net_device *dev,
 			      const char *name)
 {
-	BUG_ON(!net);
-
-	if (!dev_valid_name(name))
-		return -EINVAL;
-
-	if (strchr(name, '%'))
-		return dev_alloc_name_ns(net, dev, name);
-	else if (netdev_name_in_use(net, name))
-		return -EEXIST;
-	else if (dev->name != name)
-		strscpy(dev->name, name, IFNAMSIZ);
-
-	return 0;
+	return dev_prep_valid_name(net, dev, name, dev->name);
 }
 
 /**
@@ -11038,6 +11048,7 @@ int __dev_change_net_namespace(struct net_device *dev, struct net *net,
 			       const char *pat, int new_ifindex)
 {
 	struct net *net_old = dev_net(dev);
+	char new_name[IFNAMSIZ] = {};
 	int err, new_nsid;
 
 	ASSERT_RTNL();
@@ -11064,7 +11075,7 @@ int __dev_change_net_namespace(struct net_device *dev, struct net *net,
 		/* We get here if we can't use the current device name */
 		if (!pat)
 			goto out;
-		err = dev_get_valid_name(net, dev, pat);
+		err = dev_prep_valid_name(net, dev, pat, new_name);
 		if (err < 0)
 			goto out;
 	}
@@ -11135,6 +11146,9 @@ int __dev_change_net_namespace(struct net_device *dev, struct net *net,
 	kobject_uevent(&dev->dev.kobj, KOBJ_ADD);
 	netdev_adjacent_add_links(dev);
 
+	if (new_name[0]) /* Rename the netdev to prepared name */
+		strscpy(dev->name, new_name, IFNAMSIZ);
+
 	/* Fixup kobjects */
 	err = device_rename(&dev->dev, dev->name);
 	WARN_ON(err);
-- 
2.41.0



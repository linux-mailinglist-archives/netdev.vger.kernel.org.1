Return-Path: <netdev+bounces-42099-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 910ED7CD1DE
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 03:38:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38F89281AC4
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 01:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79B6215BF;
	Wed, 18 Oct 2023 01:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PmKyFa7Z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B4A15BC
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 01:38:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E04EC433CA;
	Wed, 18 Oct 2023 01:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697593099;
	bh=gyteMpMrmb7xM5pxR0coqwfSu9jdBlg9cR1EwIdSj7E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PmKyFa7ZG2uPQUoz2PrJ0fMYsAbWOcVIWnY6j2nPjFDMuNGM/mDhD8UafvfwHJb0y
	 Jm5aIxL0h3mgls9mKzwCk2o5uNSnfS7qeviE0uuwL/fBybOsc/0xP7YodHTxPXpjFk
	 CWR4tf0Ogdtss/keuEEbF1oO0PMIblusT0ecjgB4JeY03JDDfzt6r/rHcK+Yc1n1NQ
	 6rkdl/RzVocGXHi4ig/mh8fLOyqTWWNurEQS2lFqcX16G0Gt49kODbLAo30Bjs2UQo
	 71M9Iuuw71hyX2za46h0mFpJaeIqIS263lOsPVBR15ZVzxU51XMR1EdP2Nlhgvxo+L
	 big4bSp+tMMZQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	jiri@resnulli.us,
	przemyslaw.kitszel@intel.com,
	daniel@iogearbox.net,
	Jakub Kicinski <kuba@kernel.org>,
	opurdila@ixiacom.com
Subject: [PATCH net v2 1/5] net: fix ifname in netlink ntf during netns move
Date: Tue, 17 Oct 2023 18:38:13 -0700
Message-ID: <20231018013817.2391509-2-kuba@kernel.org>
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
v2:
 - use a temp buffer in dev_get_valid_name() to avoid
   clobering dev->name on error
 - move dev_prep_valid_name() up a bit, this will help later
   cleanups in net-next

CC: daniel@iogearbox.net
CC: opurdila@ixiacom.com
---
 net/core/dev.c | 44 +++++++++++++++++++++++++++++++-------------
 1 file changed, 31 insertions(+), 13 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 5aaf5753d4e4..f109ad34d660 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -1123,6 +1123,26 @@ static int __dev_alloc_name(struct net *net, const char *name, char *buf)
 	return -ENFILE;
 }
 
+static int dev_prep_valid_name(struct net *net, struct net_device *dev,
+			       const char *want_name, char *out_name)
+{
+	int ret;
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
 static int dev_alloc_name_ns(struct net *net,
 			     struct net_device *dev,
 			     const char *name)
@@ -1160,19 +1180,13 @@ EXPORT_SYMBOL(dev_alloc_name);
 static int dev_get_valid_name(struct net *net, struct net_device *dev,
 			      const char *name)
 {
-	BUG_ON(!net);
+	char buf[IFNAMSIZ];
+	int ret;
 
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
+	ret = dev_prep_valid_name(net, dev, name, buf);
+	if (ret >= 0)
+		strscpy(dev->name, buf, IFNAMSIZ);
+	return ret;
 }
 
 /**
@@ -11038,6 +11052,7 @@ int __dev_change_net_namespace(struct net_device *dev, struct net *net,
 			       const char *pat, int new_ifindex)
 {
 	struct net *net_old = dev_net(dev);
+	char new_name[IFNAMSIZ] = {};
 	int err, new_nsid;
 
 	ASSERT_RTNL();
@@ -11064,7 +11079,7 @@ int __dev_change_net_namespace(struct net_device *dev, struct net *net,
 		/* We get here if we can't use the current device name */
 		if (!pat)
 			goto out;
-		err = dev_get_valid_name(net, dev, pat);
+		err = dev_prep_valid_name(net, dev, pat, new_name);
 		if (err < 0)
 			goto out;
 	}
@@ -11135,6 +11150,9 @@ int __dev_change_net_namespace(struct net_device *dev, struct net *net,
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



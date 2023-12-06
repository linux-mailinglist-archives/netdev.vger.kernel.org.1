Return-Path: <netdev+bounces-54364-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C4E5B806C4C
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 11:39:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A17CB20DF1
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 10:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 676B018654;
	Wed,  6 Dec 2023 10:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="S3IfaKU+"
X-Original-To: netdev@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 077F112B
	for <netdev@vger.kernel.org>; Wed,  6 Dec 2023 02:39:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=RnuxTWRTMpKhkBlBwUAmVTzSTvvFxNs+6yJuFhML4J4=; t=1701859180; x=1703068780; 
	b=S3IfaKU+Wuk24Us3Ou6NmEt1IjtUKYvTDsy+gERhk9HElra3g++q61Q6gVupy+rAQH67VjbhAaA
	u+KEOa8xVtsgws2Zr9c4Nh5ZViZWvR9NkxcG59iFF1l+24YAK+oTTMU0QYiaY5gfGDtXmvnzcPZGV
	eRw+xratbszp/SqFEMLgIONdKV4Ej+cyVyXWFs3BjBqWqL1S/ArTs3WN8NzctjPCDjbO4y6PoyAvo
	mt9qXF9ySzdqlabdlKx9AfZ3+yQRCHE39vEGn8tqgKpC4Xig4Y76dRJIXVuogCWan+xD5KKwqszrr
	2S4JNAoeJZMSTbV4w1mL/glEvr8E4jno+dPQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rApJY-0000000HaBs-0lCf;
	Wed, 06 Dec 2023 11:39:36 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: netdev@vger.kernel.org
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Marc MERLIN <marc@merlins.org>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH net v3] net: ethtool: do runtime PM outside RTNL
Date: Wed,  6 Dec 2023 11:39:32 +0100
Message-ID: <20231206113934.8d7819857574.I2deb5804ef1739a2af307283d320ef7d82456494@changeid>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

As reported by Marc MERLIN, at least one driver (igc) wants or
needs to acquire the RTNL inside suspend/resume ops, which can
be called from here in ethtool if runtime PM is enabled.

Allow this by doing runtime PM transitions without the RTNL
held. For the ioctl to have the same operations order, this
required reworking the code to separately check validity and
do the operation. For the netlink code, this now has to do
the runtime_pm_put a bit later.

Reported-by: Marc MERLIN <marc@merlins.org>
Fixes: f32a21376573 ("ethtool: runtime-resume netdev parent before ethtool ioctl ops")
Fixes: d43c65b05b84 ("ethtool: runtime-resume netdev parent in ethnl_ops_begin")
Closes: https://lore.kernel.org/r/20231202221402.GA11155@merlins.org
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
v2:
 - add tags
 - use netdev_get_by_name()/netdev_put() in ioctl path
v3:
 - drop if(dev) before netdev_put() [Przemek Kitszel]
 - add Reviewed-by tag
---
 net/ethtool/ioctl.c   | 71 ++++++++++++++++++++++++++-----------------
 net/ethtool/netlink.c | 32 ++++++++-----------
 2 files changed, 56 insertions(+), 47 deletions(-)

diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index a977f8903467..7c0e56985eb8 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -2768,26 +2768,18 @@ static int ethtool_set_fecparam(struct net_device *dev, void __user *useraddr)
 /* The main entry point in this file.  Called from net/core/dev_ioctl.c */
 
 static int
-__dev_ethtool(struct net *net, struct ifreq *ifr, void __user *useraddr,
-	      u32 ethcmd, struct ethtool_devlink_compat *devlink_state)
+__dev_ethtool_check(struct net_device *dev, void __user *useraddr,
+		    u32 ethcmd, u32 *sub_cmd)
 {
-	struct net_device *dev;
-	u32 sub_cmd;
-	int rc;
-	netdev_features_t old_features;
-
-	dev = __dev_get_by_name(net, ifr->ifr_name);
-	if (!dev)
-		return -ENODEV;
-
 	if (ethcmd == ETHTOOL_PERQUEUE) {
-		if (copy_from_user(&sub_cmd, useraddr + sizeof(ethcmd), sizeof(sub_cmd)))
+		if (copy_from_user(sub_cmd, useraddr + sizeof(ethcmd), sizeof(*sub_cmd)))
 			return -EFAULT;
 	} else {
-		sub_cmd = ethcmd;
+		*sub_cmd = ethcmd;
 	}
+
 	/* Allow some commands to be done by anyone */
-	switch (sub_cmd) {
+	switch (*sub_cmd) {
 	case ETHTOOL_GSET:
 	case ETHTOOL_GDRVINFO:
 	case ETHTOOL_GMSGLVL:
@@ -2826,22 +2818,28 @@ __dev_ethtool(struct net *net, struct ifreq *ifr, void __user *useraddr,
 	case ETHTOOL_GFECPARAM:
 		break;
 	default:
-		if (!ns_capable(net->user_ns, CAP_NET_ADMIN))
+		if (!ns_capable(dev_net(dev)->user_ns, CAP_NET_ADMIN))
 			return -EPERM;
 	}
 
-	if (dev->dev.parent)
-		pm_runtime_get_sync(dev->dev.parent);
+	return 0;
+}
 
-	if (!netif_device_present(dev)) {
-		rc = -ENODEV;
-		goto out;
-	}
+static int
+__dev_ethtool_do(struct net_device *dev, struct ifreq *ifr,
+		 void __user *useraddr, u32 ethcmd, u32 sub_cmd,
+		 struct ethtool_devlink_compat *devlink_state)
+{
+	netdev_features_t old_features;
+	int rc;
+
+	if (!netif_device_present(dev))
+		return -ENODEV;
 
 	if (dev->ethtool_ops->begin) {
 		rc = dev->ethtool_ops->begin(dev);
 		if (rc < 0)
-			goto out;
+			return rc;
 	}
 	old_features = dev->features;
 
@@ -3052,7 +3050,7 @@ __dev_ethtool(struct net *net, struct ifreq *ifr, void __user *useraddr,
 		rc = ethtool_set_fecparam(dev, useraddr);
 		break;
 	default:
-		rc = -EOPNOTSUPP;
+		return -EOPNOTSUPP;
 	}
 
 	if (dev->ethtool_ops->complete)
@@ -3060,9 +3058,6 @@ __dev_ethtool(struct net *net, struct ifreq *ifr, void __user *useraddr,
 
 	if (old_features != dev->features)
 		netdev_features_change(dev);
-out:
-	if (dev->dev.parent)
-		pm_runtime_put(dev->dev.parent);
 
 	return rc;
 }
@@ -3070,7 +3065,9 @@ __dev_ethtool(struct net *net, struct ifreq *ifr, void __user *useraddr,
 int dev_ethtool(struct net *net, struct ifreq *ifr, void __user *useraddr)
 {
 	struct ethtool_devlink_compat *state;
-	u32 ethcmd;
+	struct net_device *dev = NULL;
+	netdevice_tracker dev_tracker;
+	u32 ethcmd, subcmd;
 	int rc;
 
 	if (copy_from_user(&ethcmd, useraddr, sizeof(ethcmd)))
@@ -3090,9 +3087,26 @@ int dev_ethtool(struct net *net, struct ifreq *ifr, void __user *useraddr)
 		break;
 	}
 
+	dev = netdev_get_by_name(net, ifr->ifr_name, &dev_tracker, GFP_KERNEL);
+	if (!dev) {
+		rc = -ENODEV;
+		goto exit_free;
+	}
+
+	rc = __dev_ethtool_check(dev, useraddr, ethcmd, &subcmd);
+	if (rc)
+		goto exit_free;
+
+	if (dev->dev.parent)
+		pm_runtime_get_sync(dev->dev.parent);
+
 	rtnl_lock();
-	rc = __dev_ethtool(net, ifr, useraddr, ethcmd, state);
+	rc = __dev_ethtool_do(dev, ifr, useraddr, ethcmd, subcmd, state);
 	rtnl_unlock();
+
+	if (dev->dev.parent)
+		pm_runtime_put(dev->dev.parent);
+
 	if (rc)
 		goto exit_free;
 
@@ -3115,6 +3129,7 @@ int dev_ethtool(struct net *net, struct ifreq *ifr, void __user *useraddr)
 	}
 
 exit_free:
+	netdev_put(dev, &dev_tracker);
 	if (state->devlink)
 		devlink_put(state->devlink);
 	kfree(state);
diff --git a/net/ethtool/netlink.c b/net/ethtool/netlink.c
index fe3553f60bf3..67e2dd893330 100644
--- a/net/ethtool/netlink.c
+++ b/net/ethtool/netlink.c
@@ -34,39 +34,23 @@ int ethnl_ops_begin(struct net_device *dev)
 {
 	int ret;
 
-	if (!dev)
-		return -ENODEV;
-
-	if (dev->dev.parent)
-		pm_runtime_get_sync(dev->dev.parent);
-
 	if (!netif_device_present(dev) ||
-	    dev->reg_state == NETREG_UNREGISTERING) {
-		ret = -ENODEV;
-		goto err;
-	}
+	    dev->reg_state == NETREG_UNREGISTERING)
+		return -ENODEV;
 
 	if (dev->ethtool_ops->begin) {
 		ret = dev->ethtool_ops->begin(dev);
 		if (ret)
-			goto err;
+			return ret;
 	}
 
 	return 0;
-err:
-	if (dev->dev.parent)
-		pm_runtime_put(dev->dev.parent);
-
-	return ret;
 }
 
 void ethnl_ops_complete(struct net_device *dev)
 {
 	if (dev->ethtool_ops->complete)
 		dev->ethtool_ops->complete(dev);
-
-	if (dev->dev.parent)
-		pm_runtime_put(dev->dev.parent);
 }
 
 /**
@@ -602,6 +586,14 @@ static int ethnl_default_set_doit(struct sk_buff *skb, struct genl_info *info)
 			goto out_dev;
 	}
 
+	if (!req_info.dev) {
+		ret = -ENODEV;
+		goto out_dev;
+	}
+
+	if (req_info.dev->dev.parent)
+		pm_runtime_get_sync(req_info.dev->dev.parent);
+
 	rtnl_lock();
 	ret = ethnl_ops_begin(req_info.dev);
 	if (ret < 0)
@@ -617,6 +609,8 @@ static int ethnl_default_set_doit(struct sk_buff *skb, struct genl_info *info)
 	ethnl_ops_complete(req_info.dev);
 out_rtnl:
 	rtnl_unlock();
+	if (req_info.dev->dev.parent)
+		pm_runtime_put(req_info.dev->dev.parent);
 out_dev:
 	ethnl_parse_header_dev_put(&req_info);
 	return ret;
-- 
2.43.0



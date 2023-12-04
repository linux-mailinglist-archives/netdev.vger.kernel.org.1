Return-Path: <netdev+bounces-53604-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 021AD803E12
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 20:07:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FD5B1F2108A
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 19:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B7430F9D;
	Mon,  4 Dec 2023 19:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Hm9XFNLZ"
X-Original-To: netdev@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71831CB
	for <netdev@vger.kernel.org>; Mon,  4 Dec 2023 11:07:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=uBTJj1Qtxq9SLgn//Jw6JgydynLqSMP/yWLsZ9yFqRk=; t=1701716843; x=1702926443; 
	b=Hm9XFNLZDdQ42/W/njUXLtqFLui+DAfTjWtapAfJHu3Yph/uUIthKjodl7ZQtB7HeEkiDRnYrYN
	A0km5G6ZOT74TQItvujZj8aO5wCIfR95+HKvdHwaXnzY75IorsO+n7Qdwaz4ogkssp2FKYRVRF8uG
	pVP0j/Rtmnj1LVHiTigyp+TRZxG+ztlDL4vy1yRTKOCKDUifG+Xs9XQ0X/QEK6lPirgkJXnsQS3o6
	FtFTomaA3ILp1wFAxpOt3lbBdrWDgiddXTKj7CySk+s23htEOwMPNxpN/qBnMxiqgkb3O6RekXlqD
	wGYbjrWEOfHU2yiJaFgRAGVgHS3l81PV59DQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rAEHm-0000000FCfw-1pgw;
	Mon, 04 Dec 2023 20:07:18 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: netdev@vger.kernel.org
Cc: Marc MERLIN <marc@merlins.org>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	intel-wired-lan@lists.osuosl.org,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [RFC PATCH] net: ethtool: do runtime PM outside RTNL
Date: Mon,  4 Dec 2023 20:07:06 +0100
Message-ID: <20231204200710.40c291e60cea.I2deb5804ef1739a2af307283d320ef7d82456494@changeid>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

As reported by Marc MERLIN in [1], at least one driver (igc)
wants/needs to acquire the RTNL inside suspend/resume ops,
which can be called from here in ethtool if runtime PM is
enabled.

[1] https://lore.kernel.org/r/20231202221402.GA11155@merlins.org

Allow this by doing runtime PM transitions without the RTNL
held. For the ioctl to have the same operations order, this
required reworking the code to separately check validity and
do the operation. For the netlink code, this now has to do
the runtime_pm_put a bit later.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/ethtool/ioctl.c   | 71 ++++++++++++++++++++++++++-----------------
 net/ethtool/netlink.c | 32 ++++++++-----------
 2 files changed, 56 insertions(+), 47 deletions(-)

diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index 0b0ce4f81c01..ae7e165dc471 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -2765,26 +2765,18 @@ static int ethtool_set_fecparam(struct net_device *dev, void __user *useraddr)
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
@@ -2823,22 +2815,28 @@ __dev_ethtool(struct net *net, struct ifreq *ifr, void __user *useraddr,
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
 
@@ -3049,7 +3047,7 @@ __dev_ethtool(struct net *net, struct ifreq *ifr, void __user *useraddr,
 		rc = ethtool_set_fecparam(dev, useraddr);
 		break;
 	default:
-		rc = -EOPNOTSUPP;
+		return -EOPNOTSUPP;
 	}
 
 	if (dev->ethtool_ops->complete)
@@ -3057,9 +3055,6 @@ __dev_ethtool(struct net *net, struct ifreq *ifr, void __user *useraddr,
 
 	if (old_features != dev->features)
 		netdev_features_change(dev);
-out:
-	if (dev->dev.parent)
-		pm_runtime_put(dev->dev.parent);
 
 	return rc;
 }
@@ -3067,7 +3062,8 @@ __dev_ethtool(struct net *net, struct ifreq *ifr, void __user *useraddr,
 int dev_ethtool(struct net *net, struct ifreq *ifr, void __user *useraddr)
 {
 	struct ethtool_devlink_compat *state;
-	u32 ethcmd;
+	struct net_device *dev = NULL;
+	u32 ethcmd, subcmd;
 	int rc;
 
 	if (copy_from_user(&ethcmd, useraddr, sizeof(ethcmd)))
@@ -3087,9 +3083,26 @@ int dev_ethtool(struct net *net, struct ifreq *ifr, void __user *useraddr)
 		break;
 	}
 
+	dev = dev_get_by_name(net, ifr->ifr_name);
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
 
@@ -3112,6 +3125,8 @@ int dev_ethtool(struct net *net, struct ifreq *ifr, void __user *useraddr)
 	}
 
 exit_free:
+	if (dev)
+		dev_put(dev);
 	if (state->devlink)
 		devlink_put(state->devlink);
 	kfree(state);
diff --git a/net/ethtool/netlink.c b/net/ethtool/netlink.c
index fe3553f60bf3..ee9ccf64688d 100644
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
+	    	return -ENODEV;
 
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



Return-Path: <netdev+bounces-166849-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD7F4A378DD
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 00:34:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC6EF3B09F5
	for <lists+netdev@lfdr.de>; Sun, 16 Feb 2025 23:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C8D91AA1C9;
	Sun, 16 Feb 2025 23:32:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC82189B94
	for <netdev@vger.kernel.org>; Sun, 16 Feb 2025 23:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739748779; cv=none; b=sxU7YZmiVdfrY79oev5aQSHcZHYbARSrqDvSWhP8AEUPdaTS00uwA6LKRh8A8beH9dX//6XGnb8N9UmHPqh1+ba6Ufp0llIwwXpyLewk35rCAaQ5JfHmENHJ7GIZS+7hqbfuCx/uDabxNueYpU4x59ExA5XcXZ6nu5lqyzQzqok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739748779; c=relaxed/simple;
	bh=0qF9azZhbv+K6w/fmwKUlEwCbaufDUfv65e12704k94=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B6tQ6Xg1Qc36neq07uX6Cv0eyx6jx1JKOANyB/J8HVxfHGFKKj6i4d4MAcC24I5SVl06aYwgfbiQfeSIkmKfdoWqqRiZrWMhrlomGwY8cP5Y7cl3aIvhKoWS2GE+M0O+B3BzTjiEalCqep7P5fAZ2QsBOr2wC7gvK4NiLnlx1ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-221050f3f00so23775355ad.2
        for <netdev@vger.kernel.org>; Sun, 16 Feb 2025 15:32:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739748776; x=1740353576;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GpV6qcH9DxcCnF4yIPwKAs10z2fHF5CsZ8Shd5oa6/E=;
        b=B64GVpm/kh3DfpvrTBOuSmvJ34G1XE6IdXe6RbPWKTTXVlzI1XXFW5blQ3nT91688+
         IxAu099KYv7gUqby5hEL2RuusJ1735Ebq8O2JKDwVy3KFesnULVSRQzT8I7UBoEU4tVF
         nTI55pvNd85eWdYo0tDFRyYOI9uwSsXLEiF0jWXS5uuoXilRyA802mUNC+N3X2t30C7q
         MknWGtzEYftozdA0nYpvixBYvMkIwRwL1uRWHoQdM8SMsYikWnCXXCJEomBleDpgsAyp
         kN9valL+sMit0YbpJ2Z+p0SYEtp+FdVOKn8QFBddbjvJlDe7MhzrYowxuEFkjd4qRwkV
         XxVg==
X-Gm-Message-State: AOJu0Yy0mfyHx0epwkvJa/OF/z+hJ5pGf99wW7nV7NZc+qmWhaCUZ1T8
	OO3qHaq4KDdtUJJFHySMAeZIrrva8xRbkFK0RLilmAdLxQ7d1q2mBx9g
X-Gm-Gg: ASbGncs/dLZj0ARL8nsC+mplG/aL+li761wlB/cldPzCyrGazs7JL2P21nqYdTugUk1
	XYra7sBj9YP5igF0v2ycMPDJ+271LUarD0iYh9sFx7y9xsiymmyoigXyXFDNR6ssZ6eARejHAu9
	IF6JijC2zJzUVusmSDpAPbAu9rWP6aJ/SazLowJANTLCdrtqTqRPva51tOIVJ5LXxjTJvGAfqOy
	j3yNvCmCPecVEJZuaysCRAAvpUqti5w7Sk/U0a9BtMWXtML9SouIw+tPtJAqtqaZvZa0ve7mS6U
	QVKJXsQIk0Vb84s=
X-Google-Smtp-Source: AGHT+IGEgKc30XjFpB9vxFox62ooQgBNQwgPzFGsJFxx3t1UsZTb6gUdMaT6/YHGbGKPGJsvddI1aw==
X-Received: by 2002:a17:902:e841:b0:215:9470:7e82 with SMTP id d9443c01a7336-22103efebeemr122698535ad.4.1739748776511;
        Sun, 16 Feb 2025 15:32:56 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:2844:3d8f:bf3e:12cc])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2fbf98cfd03sm8890627a91.15.2025.02.16.15.32.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2025 15:32:56 -0800 (PST)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Saeed Mahameed <saeed@kernel.org>
Subject: [PATCH net-next v3 08/12] net: ethtool: try to protect all callback with netdev instance lock
Date: Sun, 16 Feb 2025 15:32:41 -0800
Message-ID: <20250216233245.3122700-9-sdf@fomichev.me>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250216233245.3122700-1-sdf@fomichev.me>
References: <20250216233245.3122700-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jakub Kicinski <kuba@kernel.org>

Protect all ethtool callbacks and PHY related state with the netdev
instance lock, for drivers which want / need to have their ops
instance-locked. Basically take the lock everywhere we take rtnl_lock.
It was tempting to take the lock in ethnl_ops_begin(), but turns
out we actually nest those calls (when generating notifications).

Cc: Saeed Mahameed <saeed@kernel.org>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 drivers/net/netdevsim/ethtool.c |  2 --
 net/dsa/conduit.c               | 16 +++++++++++++++-
 net/ethtool/cabletest.c         | 20 ++++++++++++--------
 net/ethtool/features.c          |  6 ++++--
 net/ethtool/ioctl.c             |  6 ++++++
 net/ethtool/module.c            |  8 +++++---
 net/ethtool/netlink.c           | 12 ++++++++++++
 net/ethtool/phy.c               | 20 ++++++++++++++------
 net/ethtool/rss.c               |  2 ++
 net/ethtool/tsinfo.c            |  9 ++++++---
 net/sched/sch_taprio.c          |  5 ++++-
 11 files changed, 80 insertions(+), 26 deletions(-)

diff --git a/drivers/net/netdevsim/ethtool.c b/drivers/net/netdevsim/ethtool.c
index 5c80fbee7913..72a369cd21a2 100644
--- a/drivers/net/netdevsim/ethtool.c
+++ b/drivers/net/netdevsim/ethtool.c
@@ -107,10 +107,8 @@ nsim_set_channels(struct net_device *dev, struct ethtool_channels *ch)
 	struct netdevsim *ns = netdev_priv(dev);
 	int err;
 
-	netdev_lock(dev);
 	err = netif_set_real_num_queues(dev, ch->combined_count,
 					ch->combined_count);
-	netdev_unlock(dev);
 	if (err)
 		return err;
 
diff --git a/net/dsa/conduit.c b/net/dsa/conduit.c
index 3dfdb3cb47dc..f21bb2551bed 100644
--- a/net/dsa/conduit.c
+++ b/net/dsa/conduit.c
@@ -26,7 +26,9 @@ static int dsa_conduit_get_regs_len(struct net_device *dev)
 	int len;
 
 	if (ops->get_regs_len) {
+		netdev_lock_ops(dev);
 		len = ops->get_regs_len(dev);
+		netdev_unlock_ops(dev);
 		if (len < 0)
 			return len;
 		ret += len;
@@ -57,11 +59,15 @@ static void dsa_conduit_get_regs(struct net_device *dev,
 	int len;
 
 	if (ops->get_regs_len && ops->get_regs) {
+		netdev_lock_ops(dev);
 		len = ops->get_regs_len(dev);
-		if (len < 0)
+		if (len < 0) {
+			netdev_unlock_ops(dev);
 			return;
+		}
 		regs->len = len;
 		ops->get_regs(dev, regs, data);
+		netdev_unlock_ops(dev);
 		data += regs->len;
 	}
 
@@ -91,8 +97,10 @@ static void dsa_conduit_get_ethtool_stats(struct net_device *dev,
 	int count = 0;
 
 	if (ops->get_sset_count && ops->get_ethtool_stats) {
+		netdev_lock_ops(dev);
 		count = ops->get_sset_count(dev, ETH_SS_STATS);
 		ops->get_ethtool_stats(dev, stats, data);
+		netdev_unlock_ops(dev);
 	}
 
 	if (ds->ops->get_ethtool_stats)
@@ -114,8 +122,10 @@ static void dsa_conduit_get_ethtool_phy_stats(struct net_device *dev,
 		if (count >= 0)
 			phy_ethtool_get_stats(dev->phydev, stats, data);
 	} else if (ops->get_sset_count && ops->get_ethtool_phy_stats) {
+		netdev_lock_ops(dev);
 		count = ops->get_sset_count(dev, ETH_SS_PHY_STATS);
 		ops->get_ethtool_phy_stats(dev, stats, data);
+		netdev_unlock_ops(dev);
 	}
 
 	if (count < 0)
@@ -132,11 +142,13 @@ static int dsa_conduit_get_sset_count(struct net_device *dev, int sset)
 	struct dsa_switch *ds = cpu_dp->ds;
 	int count = 0;
 
+	netdev_lock_ops(dev);
 	if (sset == ETH_SS_PHY_STATS && dev->phydev &&
 	    !ops->get_ethtool_phy_stats)
 		count = phy_ethtool_get_sset_count(dev->phydev);
 	else if (ops->get_sset_count)
 		count = ops->get_sset_count(dev, sset);
+	netdev_unlock_ops(dev);
 
 	if (count < 0)
 		count = 0;
@@ -163,6 +175,7 @@ static void dsa_conduit_get_strings(struct net_device *dev, uint32_t stringset,
 	/* We do not want to be NULL-terminated, since this is a prefix */
 	pfx[sizeof(pfx) - 1] = '_';
 
+	netdev_lock_ops(dev);
 	if (stringset == ETH_SS_PHY_STATS && dev->phydev &&
 	    !ops->get_ethtool_phy_stats) {
 		mcount = phy_ethtool_get_sset_count(dev->phydev);
@@ -176,6 +189,7 @@ static void dsa_conduit_get_strings(struct net_device *dev, uint32_t stringset,
 			mcount = 0;
 		ops->get_strings(dev, stringset, data);
 	}
+	netdev_unlock_ops(dev);
 
 	if (ds->ops->get_strings) {
 		ndata = data + mcount * len;
diff --git a/net/ethtool/cabletest.c b/net/ethtool/cabletest.c
index f22051f33868..d4a79310b33f 100644
--- a/net/ethtool/cabletest.c
+++ b/net/ethtool/cabletest.c
@@ -72,23 +72,24 @@ int ethnl_act_cable_test(struct sk_buff *skb, struct genl_info *info)
 	dev = req_info.dev;
 
 	rtnl_lock();
+	netdev_lock_ops(dev);
 	phydev = ethnl_req_get_phydev(&req_info,
 				      tb[ETHTOOL_A_CABLE_TEST_HEADER],
 				      info->extack);
 	if (IS_ERR_OR_NULL(phydev)) {
 		ret = -EOPNOTSUPP;
-		goto out_rtnl;
+		goto out_unlock;
 	}
 
 	ops = ethtool_phy_ops;
 	if (!ops || !ops->start_cable_test) {
 		ret = -EOPNOTSUPP;
-		goto out_rtnl;
+		goto out_unlock;
 	}
 
 	ret = ethnl_ops_begin(dev);
 	if (ret < 0)
-		goto out_rtnl;
+		goto out_unlock;
 
 	ret = ops->start_cable_test(phydev, info->extack);
 
@@ -97,7 +98,8 @@ int ethnl_act_cable_test(struct sk_buff *skb, struct genl_info *info)
 	if (!ret)
 		ethnl_cable_test_started(phydev, ETHTOOL_MSG_CABLE_TEST_NTF);
 
-out_rtnl:
+out_unlock:
+	netdev_unlock_ops(dev);
 	rtnl_unlock();
 	ethnl_parse_header_dev_put(&req_info);
 	return ret;
@@ -339,23 +341,24 @@ int ethnl_act_cable_test_tdr(struct sk_buff *skb, struct genl_info *info)
 		goto out_dev_put;
 
 	rtnl_lock();
+	netdev_lock_ops(dev);
 	phydev = ethnl_req_get_phydev(&req_info,
 				      tb[ETHTOOL_A_CABLE_TEST_TDR_HEADER],
 				      info->extack);
 	if (IS_ERR_OR_NULL(phydev)) {
 		ret = -EOPNOTSUPP;
-		goto out_rtnl;
+		goto out_unlock;
 	}
 
 	ops = ethtool_phy_ops;
 	if (!ops || !ops->start_cable_test_tdr) {
 		ret = -EOPNOTSUPP;
-		goto out_rtnl;
+		goto out_unlock;
 	}
 
 	ret = ethnl_ops_begin(dev);
 	if (ret < 0)
-		goto out_rtnl;
+		goto out_unlock;
 
 	ret = ops->start_cable_test_tdr(phydev, info->extack, &cfg);
 
@@ -365,7 +368,8 @@ int ethnl_act_cable_test_tdr(struct sk_buff *skb, struct genl_info *info)
 		ethnl_cable_test_started(phydev,
 					 ETHTOOL_MSG_CABLE_TEST_TDR_NTF);
 
-out_rtnl:
+out_unlock:
+	netdev_unlock_ops(dev);
 	rtnl_unlock();
 out_dev_put:
 	ethnl_parse_header_dev_put(&req_info);
diff --git a/net/ethtool/features.c b/net/ethtool/features.c
index b6cb101d7f19..ccffd64d5a87 100644
--- a/net/ethtool/features.c
+++ b/net/ethtool/features.c
@@ -234,9 +234,10 @@ int ethnl_set_features(struct sk_buff *skb, struct genl_info *info)
 	dev = req_info.dev;
 
 	rtnl_lock();
+	netdev_lock_ops(dev);
 	ret = ethnl_ops_begin(dev);
 	if (ret < 0)
-		goto out_rtnl;
+		goto out_unlock;
 	ethnl_features_to_bitmap(old_active, dev->features);
 	ethnl_features_to_bitmap(old_wanted, dev->wanted_features);
 	ret = ethnl_parse_bitset(req_wanted, req_mask, NETDEV_FEATURE_COUNT,
@@ -286,7 +287,8 @@ int ethnl_set_features(struct sk_buff *skb, struct genl_info *info)
 
 out_ops:
 	ethnl_ops_complete(dev);
-out_rtnl:
+out_unlock:
+	netdev_unlock_ops(dev);
 	rtnl_unlock();
 	ethnl_parse_header_dev_put(&req_info);
 	return ret;
diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index 98b7dcea207a..7a77ee1d0345 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -2315,6 +2315,7 @@ static int ethtool_phys_id(struct net_device *dev, void __user *useraddr)
 	 */
 	busy = true;
 	netdev_hold(dev, &dev_tracker, GFP_KERNEL);
+	netdev_unlock_ops(dev);
 	rtnl_unlock();
 
 	if (rc == 0) {
@@ -2329,8 +2330,10 @@ static int ethtool_phys_id(struct net_device *dev, void __user *useraddr)
 
 		do {
 			rtnl_lock();
+			netdev_lock_ops(dev);
 			rc = ops->set_phys_id(dev,
 				    (i++ & 1) ? ETHTOOL_ID_OFF : ETHTOOL_ID_ON);
+			netdev_unlock_ops(dev);
 			rtnl_unlock();
 			if (rc)
 				break;
@@ -2339,6 +2342,7 @@ static int ethtool_phys_id(struct net_device *dev, void __user *useraddr)
 	}
 
 	rtnl_lock();
+	netdev_lock_ops(dev);
 	netdev_put(dev, &dev_tracker);
 	busy = false;
 
@@ -3138,6 +3142,7 @@ __dev_ethtool(struct net *net, struct ifreq *ifr, void __user *useraddr,
 			return -EPERM;
 	}
 
+	netdev_lock_ops(dev);
 	if (dev->dev.parent)
 		pm_runtime_get_sync(dev->dev.parent);
 
@@ -3371,6 +3376,7 @@ __dev_ethtool(struct net *net, struct ifreq *ifr, void __user *useraddr,
 out:
 	if (dev->dev.parent)
 		pm_runtime_put(dev->dev.parent);
+	netdev_unlock_ops(dev);
 
 	return rc;
 }
diff --git a/net/ethtool/module.c b/net/ethtool/module.c
index 6988e07bdcd6..d3d2e135e45e 100644
--- a/net/ethtool/module.c
+++ b/net/ethtool/module.c
@@ -419,19 +419,21 @@ int ethnl_act_module_fw_flash(struct sk_buff *skb, struct genl_info *info)
 	dev = req_info.dev;
 
 	rtnl_lock();
+	netdev_lock_ops(dev);
 	ret = ethnl_ops_begin(dev);
 	if (ret < 0)
-		goto out_rtnl;
+		goto out_unlock;
 
 	ret = ethnl_module_fw_flash_validate(dev, info->extack);
 	if (ret < 0)
-		goto out_rtnl;
+		goto out_unlock;
 
 	ret = module_flash_fw(dev, tb, skb, info);
 
 	ethnl_ops_complete(dev);
 
-out_rtnl:
+out_unlock:
+	netdev_unlock_ops(dev);
 	rtnl_unlock();
 	ethnl_parse_header_dev_put(&req_info);
 	return ret;
diff --git a/net/ethtool/netlink.c b/net/ethtool/netlink.c
index b4c45207fa32..dee36f5cc228 100644
--- a/net/ethtool/netlink.c
+++ b/net/ethtool/netlink.c
@@ -90,6 +90,8 @@ int ethnl_ops_begin(struct net_device *dev)
 	if (dev->dev.parent)
 		pm_runtime_get_sync(dev->dev.parent);
 
+	netdev_ops_assert_locked(dev);
+
 	if (!netif_device_present(dev) ||
 	    dev->reg_state >= NETREG_UNREGISTERING) {
 		ret = -ENODEV;
@@ -490,7 +492,11 @@ static int ethnl_default_doit(struct sk_buff *skb, struct genl_info *info)
 	ethnl_init_reply_data(reply_data, ops, req_info->dev);
 
 	rtnl_lock();
+	if (req_info->dev)
+		netdev_lock_ops(req_info->dev);
 	ret = ops->prepare_data(req_info, reply_data, info);
+	if (req_info->dev)
+		netdev_unlock_ops(req_info->dev);
 	rtnl_unlock();
 	if (ret < 0)
 		goto err_cleanup;
@@ -548,7 +554,9 @@ static int ethnl_default_dump_one(struct sk_buff *skb, struct net_device *dev,
 
 	ethnl_init_reply_data(ctx->reply_data, ctx->ops, dev);
 	rtnl_lock();
+	netdev_lock_ops(ctx->req_info->dev);
 	ret = ctx->ops->prepare_data(ctx->req_info, ctx->reply_data, info);
+	netdev_unlock_ops(ctx->req_info->dev);
 	rtnl_unlock();
 	if (ret < 0)
 		goto out;
@@ -693,6 +701,7 @@ static int ethnl_default_set_doit(struct sk_buff *skb, struct genl_info *info)
 	dev = req_info.dev;
 
 	rtnl_lock();
+	netdev_lock_ops(dev);
 	dev->cfg_pending = kmemdup(dev->cfg, sizeof(*dev->cfg),
 				   GFP_KERNEL_ACCOUNT);
 	if (!dev->cfg_pending) {
@@ -720,6 +729,7 @@ static int ethnl_default_set_doit(struct sk_buff *skb, struct genl_info *info)
 	kfree(dev->cfg_pending);
 out_tie_cfg:
 	dev->cfg_pending = dev->cfg;
+	netdev_unlock_ops(dev);
 	rtnl_unlock();
 out_dev:
 	ethnl_parse_header_dev_put(&req_info);
@@ -777,6 +787,8 @@ static void ethnl_default_notify(struct net_device *dev, unsigned int cmd,
 	req_info->dev = dev;
 	req_info->flags |= ETHTOOL_FLAG_COMPACT_BITSETS;
 
+	netdev_ops_assert_locked(dev);
+
 	ethnl_init_reply_data(reply_data, ops, dev);
 	ret = ops->prepare_data(req_info, reply_data, &info);
 	if (ret < 0)
diff --git a/net/ethtool/phy.c b/net/ethtool/phy.c
index ed8f690f6bac..2b428bc80c9b 100644
--- a/net/ethtool/phy.c
+++ b/net/ethtool/phy.c
@@ -158,18 +158,19 @@ int ethnl_phy_doit(struct sk_buff *skb, struct genl_info *info)
 		return ret;
 
 	rtnl_lock();
+	netdev_lock_ops(req_info.base.dev);
 
 	ret = ethnl_phy_parse_request(&req_info.base, tb, info->extack);
 	if (ret < 0)
-		goto err_unlock_rtnl;
+		goto err_unlock;
 
 	/* No PHY, return early */
 	if (!req_info.pdn)
-		goto err_unlock_rtnl;
+		goto err_unlock;
 
 	ret = ethnl_phy_reply_size(&req_info.base, info->extack);
 	if (ret < 0)
-		goto err_unlock_rtnl;
+		goto err_unlock;
 	reply_len = ret + ethnl_reply_header_size();
 
 	rskb = ethnl_reply_init(reply_len, req_info.base.dev,
@@ -178,13 +179,14 @@ int ethnl_phy_doit(struct sk_buff *skb, struct genl_info *info)
 				info, &reply_payload);
 	if (!rskb) {
 		ret = -ENOMEM;
-		goto err_unlock_rtnl;
+		goto err_unlock;
 	}
 
 	ret = ethnl_phy_fill_reply(&req_info.base, rskb);
 	if (ret)
 		goto err_free_msg;
 
+	netdev_unlock_ops(req_info.base.dev);
 	rtnl_unlock();
 	ethnl_parse_header_dev_put(&req_info.base);
 	genlmsg_end(rskb, reply_payload);
@@ -193,7 +195,8 @@ int ethnl_phy_doit(struct sk_buff *skb, struct genl_info *info)
 
 err_free_msg:
 	nlmsg_free(rskb);
-err_unlock_rtnl:
+err_unlock:
+	netdev_unlock_ops(req_info.base.dev);
 	rtnl_unlock();
 	ethnl_parse_header_dev_put(&req_info.base);
 	return ret;
@@ -290,10 +293,15 @@ int ethnl_phy_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
 	rtnl_lock();
 
 	if (ctx->phy_req_info->base.dev) {
-		ret = ethnl_phy_dump_one_dev(skb, ctx->phy_req_info->base.dev, cb);
+		dev = ctx->phy_req_info->base.dev;
+		netdev_lock_ops(dev);
+		ret = ethnl_phy_dump_one_dev(skb, dev, cb);
+		netdev_unlock_ops(dev);
 	} else {
 		for_each_netdev_dump(net, dev, ctx->ifindex) {
+			netdev_lock_ops(dev);
 			ret = ethnl_phy_dump_one_dev(skb, dev, cb);
+			netdev_unlock_ops(dev);
 			if (ret)
 				break;
 
diff --git a/net/ethtool/rss.c b/net/ethtool/rss.c
index 58df9ad02ce8..ec41d1d7eefe 100644
--- a/net/ethtool/rss.c
+++ b/net/ethtool/rss.c
@@ -345,7 +345,9 @@ int ethnl_rss_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
 		if (ctx->match_ifindex && ctx->match_ifindex != ctx->ifindex)
 			break;
 
+		netdev_lock_ops(dev);
 		ret = rss_dump_one_dev(skb, cb, dev);
+		netdev_unlock_ops(dev);
 		if (ret)
 			break;
 	}
diff --git a/net/ethtool/tsinfo.c b/net/ethtool/tsinfo.c
index 691be6c445b3..73b6a89b8731 100644
--- a/net/ethtool/tsinfo.c
+++ b/net/ethtool/tsinfo.c
@@ -448,12 +448,15 @@ int ethnl_tsinfo_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
 
 	rtnl_lock();
 	if (ctx->req_info->base.dev) {
-		ret = ethnl_tsinfo_dump_one_net_topo(skb,
-						     ctx->req_info->base.dev,
-						     cb);
+		dev = ctx->req_info->base.dev;
+		netdev_lock_ops(dev);
+		ret = ethnl_tsinfo_dump_one_net_topo(skb, dev, cb);
+		netdev_unlock_ops(dev);
 	} else {
 		for_each_netdev_dump(net, dev, ctx->pos_ifindex) {
+			netdev_lock_ops(dev);
 			ret = ethnl_tsinfo_dump_one_net_topo(skb, dev, cb);
+			netdev_unlock_ops(dev);
 			if (ret < 0 && ret != -EOPNOTSUPP)
 				break;
 			ctx->pos_phyindex = 0;
diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
index 10548bb78da1..edcb163d23ad 100644
--- a/net/sched/sch_taprio.c
+++ b/net/sched/sch_taprio.c
@@ -1620,8 +1620,11 @@ static int taprio_parse_clockid(struct Qdisc *sch, struct nlattr **tb,
 			goto out;
 		}
 
-		if (ops && ops->get_ts_info)
+		if (ops && ops->get_ts_info) {
+			netdev_lock_ops(dev);
 			err = ops->get_ts_info(dev, &info);
+			netdev_unlock_ops(dev);
+		}
 
 		if (err || info.phc_index < 0) {
 			NL_SET_ERR_MSG(extack,
-- 
2.48.1



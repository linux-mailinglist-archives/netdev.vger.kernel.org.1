Return-Path: <netdev+bounces-292890-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +GmZBHjOGGqunggAu9opvQ
	(envelope-from <netdev+bounces-292890-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 01:23:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B96545FB626
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 01:23:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EC6633042C6E
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 23:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4219370D6D;
	Thu, 28 May 2026 23:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UbvKf4Qy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6C8370AFF
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 23:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780010221; cv=none; b=g+Z0pNuZ7fgIuuFTPq8JffikTUSn/T/J0YZ75GmJd7IQFixXXPPmlKZaTb36x4dsAwNoXcFmt2ZUrFP1IHi3h83DtuNH5kGaIwbYfL5wczfNFrPia2Ps1jwn10jX6ZDXGNTfV73LVK2VRYJ6iaSP78rM9cI2lnPBwkh7gS2fyBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780010221; c=relaxed/simple;
	bh=fTVAI95Lh9oCCp9TMDIx868bJsKIYD65giPkBfSNzRk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QYaZrY1fEDhB/TTreQ3jqdqzp+pKvC9Ki0MLUr2Y1FP9qedS4egjfaLyux6mcwkzCWNEWTqb0FEbJtETp/JLOLPStXtsLipvtU5ylsmB7ZMumgfSjFCqkzKS2ywFdpH0MzDILnW/hZ/7OmWq6IbAUH/4IsXbHUUiNAKkJD3auWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UbvKf4Qy; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4E731F000E9;
	Thu, 28 May 2026 23:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780010220;
	bh=zhzV6Hqi0dSi/jRYzwL+uYhLe9tpwDqg6K1s+4LC/D0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UbvKf4QyXY5HHmZENSgJwbi7722BfhH8txQG7BzGqAaPwHo9nHdwVYKQE/HT6M3Sg
	 0OUGf3jsFt80JFk7u2WiLEXJ4tjpGCnXuIUkjcRELJNsiYcF8/hWa9i1KL7rPAaruh
	 cUNfbHbviN+/SzM1dIJaolPlooWbLmeqQ6epD2kuZuwoktbyXmNsO1RkJIyE5Pw+Ci
	 dH0BN8JmsLeOnlDhsNNpFoGTURO8+jD2GgCqUiQeG9yihE1a8SvsS8UdvRMo1BxzOn
	 AADaHRtuhbYAP5eiP7Mt6sHXWVQRvHeVf4KUb0cmMpFgAqJNGB8c6AYzflOH4xd7Jl
	 QcfN1EasMXVWg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	michael.chan@broadcom.com,
	joshwash@google.com,
	tariqt@nvidia.com,
	haiyangz@microsoft.com,
	linux@armlinux.org.uk,
	maxime.chevallier@bootlin.com,
	willemb@google.com,
	ernis@linux.microsoft.com,
	sdf.kernel@gmail.com,
	kory.maincent@bootlin.com,
	danieller@nvidia.com,
	idosch@nvidia.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 13/14] net: ethtool: optionally skip rtnl_lock on IOCTL path
Date: Thu, 28 May 2026 16:16:36 -0700
Message-ID: <20260528231637.251822-14-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528231637.251822-1-kuba@kernel.org>
References: <20260528231637.251822-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,broadcom.com,nvidia.com,microsoft.com,armlinux.org.uk,bootlin.com,linux.microsoft.com,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-292890-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: B96545FB626
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Convert the IOCTL path similarly to how we converted Netlink.
The device lookup gets a little hairy. We could take rtnl_lock
unconditionally and drop it before calling the driver (this would
avoid the reference + liveness check). But I think being able
to make progress even if rtnl is dead-locked is quite useful.

First extra concern is handling features. List all the cmds which
modify features and always take rtnl_lock. We could fold this list
into ethtool_ioctl_needs_rtnl() but seems cleaner to keep
ethtool_ioctl_needs_rtnl() driver-related. If a driver changed
features and we were not holding rtnl_lock - warn about it.
It can only happen on buggy ops locked drivers (buggy because
they should have set appropriate "I need rtnl for op X" bit).

Second wrinkle is the PHY ID hack which drops the locks while
sleeping. Convert its static "busy" variable which used to
be protected by rtnl_lock to a field in struct ethtool_netdev_state.
This feature is about identifying an adapter or a port within
a system, so being able to blink multiple LEDs at the same
time is likely not very useful in practice. But it's the simplest
fix, we can add a mutex if someone thinks a system should only
be ID'ing one port at a time.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 include/linux/ethtool.h |  2 +
 net/ethtool/ioctl.c     | 98 ++++++++++++++++++++++++++++++-----------
 2 files changed, 74 insertions(+), 26 deletions(-)

diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index 4f15221119e2..35ee57a0e5fa 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -1375,6 +1375,7 @@ int ethtool_virtdev_set_link_ksettings(struct net_device *dev,
  *			within RTNL.
  * @rss_indir_user_size: Number of user provided entries for the default
  *			 (context 0) indirection table.
+ * @phys_id_busy:	Loop blinking the device LED is running.
  * @wol_enabled:	Wake-on-LAN is enabled
  * @module_fw_flash_in_progress: Module firmware flashing is in progress.
  */
@@ -1382,6 +1383,7 @@ struct ethtool_netdev_state {
 	struct xarray		rss_ctx;
 	struct mutex		rss_lock;
 	u32			rss_indir_user_size;
+	unsigned		phys_id_busy:1;
 	unsigned		wol_enabled:1;
 	unsigned		module_fw_flash_in_progress:1;
 };
diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index 6c3a7e8644ae..aea087d62fe9 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -543,7 +543,7 @@ static int ethtool_get_link_ksettings(struct net_device *dev,
 	int err = 0;
 	struct ethtool_link_ksettings link_ksettings;
 
-	ASSERT_RTNL();
+	netdev_ops_assert_locked(dev);
 	if (!dev->ethtool_ops->get_link_ksettings)
 		return -EOPNOTSUPP;
 
@@ -600,7 +600,7 @@ static int ethtool_set_link_ksettings(struct net_device *dev,
 	struct ethtool_link_ksettings link_ksettings = {};
 	int err;
 
-	ASSERT_RTNL();
+	netdev_ops_assert_locked(dev);
 
 	if (!dev->ethtool_ops->set_link_ksettings)
 		return -EOPNOTSUPP;
@@ -674,7 +674,7 @@ static int ethtool_get_settings(struct net_device *dev, void __user *useraddr)
 	struct ethtool_cmd cmd;
 	int err;
 
-	ASSERT_RTNL();
+	netdev_ops_assert_locked(dev);
 	if (!dev->ethtool_ops->get_link_ksettings)
 		return -EOPNOTSUPP;
 
@@ -710,7 +710,7 @@ static int ethtool_set_settings(struct net_device *dev, void __user *useraddr)
 	struct ethtool_cmd cmd;
 	int ret;
 
-	ASSERT_RTNL();
+	netdev_ops_assert_locked(dev);
 
 	if (copy_from_user(&cmd, useraddr, sizeof(cmd)))
 		return -EFAULT;
@@ -2451,10 +2451,10 @@ void ethtool_puts(u8 **data, const char *str)
 }
 EXPORT_SYMBOL(ethtool_puts);
 
-static int ethtool_phys_id(struct net_device *dev, void __user *useraddr)
+static int ethtool_phys_id(struct net_device *dev, void __user *useraddr,
+			   bool has_rtnl_lock)
 {
 	struct ethtool_value id;
-	static bool busy;
 	const struct ethtool_ops *ops = dev->ethtool_ops;
 	netdevice_tracker dev_tracker;
 	int rc;
@@ -2462,7 +2462,7 @@ static int ethtool_phys_id(struct net_device *dev, void __user *useraddr)
 	if (!ops->set_phys_id)
 		return -EOPNOTSUPP;
 
-	if (busy)
+	if (dev->ethtool->phys_id_busy)
 		return -EBUSY;
 
 	if (copy_from_user(&id, useraddr, sizeof(id)))
@@ -2472,13 +2472,14 @@ static int ethtool_phys_id(struct net_device *dev, void __user *useraddr)
 	if (rc < 0)
 		return rc;
 
-	/* Drop the RTNL lock while waiting, but prevent reentry or
+	/* Drop the locks while waiting, but prevent reentry or
 	 * removal of the device.
 	 */
-	busy = true;
+	dev->ethtool->phys_id_busy = true;
 	netdev_hold(dev, &dev_tracker, GFP_KERNEL);
 	netdev_unlock_ops(dev);
-	rtnl_unlock();
+	if (has_rtnl_lock)
+		rtnl_unlock();
 
 	if (rc == 0) {
 		/* Driver will handle this itself */
@@ -2491,22 +2492,25 @@ static int ethtool_phys_id(struct net_device *dev, void __user *useraddr)
 		u64 i = 0;
 
 		do {
-			rtnl_lock();
+			if (has_rtnl_lock)
+				rtnl_lock();
 			netdev_lock_ops(dev);
 			rc = ops->set_phys_id(dev,
 				    (i++ & 1) ? ETHTOOL_ID_OFF : ETHTOOL_ID_ON);
 			netdev_unlock_ops(dev);
-			rtnl_unlock();
+			if (has_rtnl_lock)
+				rtnl_unlock();
 			if (rc)
 				break;
 			schedule_timeout_interruptible(interval);
 		} while (!signal_pending(current) && (!id.data || i < count));
 	}
 
-	rtnl_lock();
+	if (has_rtnl_lock)
+		rtnl_lock();
 	netdev_lock_ops(dev);
 	netdev_put(dev, &dev_tracker);
-	busy = false;
+	dev->ethtool->phys_id_busy = false;
 
 	(void) ops->set_phys_id(dev, ETHTOOL_ID_INACTIVE);
 	return rc;
@@ -3259,7 +3263,8 @@ static int ethtool_set_fecparam(struct net_device *dev, void __user *useraddr)
 static int
 dev_ethtool_locked(struct net *net, struct net_device *dev,
 		   void __user *useraddr,
-		   u32 ethcmd, struct ethtool_devlink_compat *devlink_state)
+		   u32 ethcmd, struct ethtool_devlink_compat *devlink_state,
+		   bool has_rtnl_lock)
 {
 	u32 sub_cmd;
 	int rc;
@@ -3315,6 +3320,8 @@ dev_ethtool_locked(struct net *net, struct net_device *dev,
 			return -EPERM;
 	}
 
+	netdev_ops_assert_locked(dev);
+
 	if (dev->dev.parent)
 		pm_runtime_get_sync(dev->dev.parent);
 
@@ -3402,7 +3409,7 @@ dev_ethtool_locked(struct net *net, struct net_device *dev,
 		rc = ethtool_get_strings(dev, useraddr);
 		break;
 	case ETHTOOL_PHYS_ID:
-		rc = ethtool_phys_id(dev, useraddr);
+		rc = ethtool_phys_id(dev, useraddr, has_rtnl_lock);
 		break;
 	case ETHTOOL_GSTATS:
 		rc = ethtool_get_stats(dev, useraddr);
@@ -3549,8 +3556,12 @@ dev_ethtool_locked(struct net *net, struct net_device *dev,
 	if (dev->ethtool_ops->complete)
 		dev->ethtool_ops->complete(dev);
 
-	if (old_features != dev->features)
-		netdev_features_change(dev);
+	if (old_features != dev->features) {
+		if (has_rtnl_lock)
+			netdev_features_change(dev);
+		else
+			netdev_WARN(dev, "unexpected device features change with ethtool cmd %u", ethcmd);
+	}
 out:
 	if (dev->dev.parent)
 		pm_runtime_put(dev->dev.parent);
@@ -3558,25 +3569,60 @@ dev_ethtool_locked(struct net *net, struct net_device *dev,
 	return rc;
 }
 
+/* Commands that may toggle dev->features in net/ethtool/ioctl.c and so
+ * call into __netdev_update_features(), which still requires rtnl_lock.
+ * Driver-decided SET commands that may chain into rtnl-only helpers are
+ * covered by ethtool_ioctl_needs_rtnl()/ETHTOOL_OP_NEEDS_RTNL_*.
+ */
+static bool ethtool_cmd_changes_features(u32 ethcmd)
+{
+	switch (ethcmd) {
+	case ETHTOOL_SFEATURES:
+	case ETHTOOL_SFLAGS:
+	case ETHTOOL_STXCSUM:
+	case ETHTOOL_SRXCSUM:
+	case ETHTOOL_SSG:
+	case ETHTOOL_STSO:
+	case ETHTOOL_SGSO:
+	case ETHTOOL_SGRO:
+		return true;
+	}
+	return false;
+}
+
 static int
 __dev_ethtool(struct net *net, struct ifreq *ifr, void __user *useraddr,
 	      u32 ethcmd, struct ethtool_devlink_compat *devlink_state)
 {
+	netdevice_tracker dev_tracker;
 	struct net_device *dev;
+	bool need_rtnl;
 	int rc;
 
-	rtnl_lock();
-	dev = __dev_get_by_name(net, ifr->ifr_name);
-	if (!dev) {
+	dev = netdev_get_by_name(net, ifr->ifr_name, &dev_tracker, GFP_KERNEL);
+	if (!dev)
+		return -ENODEV;
+
+	need_rtnl = !netdev_need_ops_lock(dev) ||
+		    ethtool_cmd_changes_features(ethcmd) ||
+		    ethtool_ioctl_needs_rtnl(dev, ethcmd);
+	if (need_rtnl)
+		rtnl_lock();
+	netdev_lock_ops(dev);
+	if (dev->reg_state > NETREG_REGISTERED ||
+	    dev->moving_ns || !net_eq(dev_net(dev), net)) {
 		rc = -ENODEV;
-		goto exit_rtnl_unlock;
+		goto exit_ops_unlock;
 	}
 
-	netdev_lock_ops(dev);
-	rc = dev_ethtool_locked(net, dev, useraddr, ethcmd, devlink_state);
+	rc = dev_ethtool_locked(net, dev, useraddr, ethcmd, devlink_state,
+				need_rtnl);
+
+exit_ops_unlock:
 	netdev_unlock_ops(dev);
-exit_rtnl_unlock:
-	rtnl_unlock();
+	if (need_rtnl)
+		rtnl_unlock();
+	netdev_put(dev, &dev_tracker);
 
 	return rc;
 }
-- 
2.54.0



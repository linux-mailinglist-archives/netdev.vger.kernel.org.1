Return-Path: <netdev+bounces-69764-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE3E984C7EE
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 10:51:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83DA6285F55
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 09:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B182022F1E;
	Wed,  7 Feb 2024 09:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S9D0Togc"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B77F22F17
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 09:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707299482; cv=none; b=fucvr0CgqJ/mTbIF7WAY10F79emCn2x67vjpPtmRZkmOD02OBltz3XGC21NjuhWyYfRyccJ7UwfcG4oJ9H6hlQYwYMuUFCOQ3Vby+qrdZwcS5OahsKdprCwZLbpVu54eA6MIcmUwZo0DGT4Cpug6SOzD4k4c3pWpRsVaJTEfga0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707299482; c=relaxed/simple;
	bh=wEpHautye3aUmDnr5EX60tKVuyhrh9Nt4y1wCVmm0gM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Hn+fHEyicn8zaWW/SFMJpf2IvEj10N7BJyGcWXhWwDUPPWQiThRsdm/outmeJZWxQe3sLcIZWHyF43r9yKmCN1wYUTi1S8B08kyDKKyjpZ6OCTw149vAGHf1yvkxAmGaBwknytn4uuNEw1IT3GSOMywMupeL7BGvtNC14JGhR2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S9D0Togc; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707299480; x=1738835480;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wEpHautye3aUmDnr5EX60tKVuyhrh9Nt4y1wCVmm0gM=;
  b=S9D0TogcTyDq0raBAqVVfrTNl9c8DlDdoDWTWDXSLWAPBHAPEWzBSt9c
   b0hcdozLRMAQikCPQToS5Z4cEdQQ8GQlG3ZSKXBaXq2IM0+XKJXKQ4mKt
   8vssLVU9FGxX2uIdpI/iPmFhLYJLNK3MZvquZRNbnUmS5gGivoKtgtBtt
   8bPXh8GtkqIjztnMO9C1YUDgkAravb6uX5tx37WsOI57o95WbptftAnOl
   8LzBT9XBiWKF9K0xNnFJtazEDGb4rkFNnlCoRihq++6ZKJNQajW0Swnx1
   9xGC4ER0w8VkFdgfiMLbd9YFZr/GpjU+KJsB481WDIz9mX3s4VWJkpI8B
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10976"; a="12310428"
X-IronPort-AV: E=Sophos;i="6.05,250,1701158400"; 
   d="scan'208";a="12310428"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2024 01:51:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,250,1701158400"; 
   d="scan'208";a="1322190"
Received: from sgruszka-mobl.ger.corp.intel.com (HELO localhost) ([10.252.61.88])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2024 01:51:14 -0800
From: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Sasha Neftin <sasha.neftin@intel.com>,
	Dima Ruinskiy <dima.ruinskiy@intel.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"Rafael J . Wysocki " <rafael@kernel.org>
Subject: [PATCH] net: avoid net core runtime resume for most drivers
Date: Wed,  7 Feb 2024 10:51:11 +0100
Message-Id: <20240207095111.1593146-1-stanislaw.gruszka@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introducing runtime resume before ndo_open and ethtool ops by commits:

d43c65b05b84 ("ethtool: runtime-resume netdev parent in ethnl_ops_begin")
bd869245a3dc ("net: core: try to runtime-resume detached device in __dev_open")

caused rtnl_lock -> rtnl_lock deadlock for igc/igb drivers if user enabled
runtime power management by:

echo auto > /sys/bus/pci/devices/{PCI_ID}/power/control

and then use ethtool or open the link, when device is suspended.

The deadlock was reported at few places before, for example:

https://lore.kernel.org/netdev/20211124144505.31e15716@hermes.local/
https://lore.kernel.org/all/20231202221402.GA11155@merlins.org/

and has fix for igb:

ac8c58f5b535 ("igb: fix deadlock caused by taking RTNL in RPM resume path")

However this solution does not take into account various corner cases.
For example it breaks RTNL lock assertion for netif_set_real_num_queues().
Fixing the deadlock issue properly in race free manner in igb/igc drivers
is not easy.

Additionally for other drivers, that fine tune their pm runtime
implementation, runtime resume by net core cause unnecessary wake-ups.
Various ethtool ops do not require HW access and can be done without
resuming device. On dev_open(), we can error exit before ndo_open(),
then not-used device will stay permanently enabled (if not implemented
runtime pm with autosuspend).

So, remove the runtime resume calls from net core.

However, now seems there are some benefits of the calls for r8169
driver, so keep them for it by introducing IFF_DO_RUNTIME_PM priv flag
and use it for r8169.

Fixes: d43c65b05b84 ("ethtool: runtime-resume netdev parent in ethnl_ops_begin")
Fixes: bd869245a3dc ("net: core: try to runtime-resume detached device in __dev_open")
Signed-off-by: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
---
 drivers/net/ethernet/realtek/r8169_main.c | 2 +-
 include/linux/netdevice.h                 | 1 +
 net/core/dev.c                            | 2 +-
 net/ethtool/ioctl.c                       | 4 ++--
 net/ethtool/netlink.c                     | 6 +++---
 5 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index dd73df6b17b0..f430df3c9e51 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -5287,7 +5287,7 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	dev->hw_features = NETIF_F_IP_CSUM | NETIF_F_RXCSUM |
 			   NETIF_F_HW_VLAN_CTAG_TX | NETIF_F_HW_VLAN_CTAG_RX;
 	dev->vlan_features = NETIF_F_SG | NETIF_F_IP_CSUM | NETIF_F_TSO;
-	dev->priv_flags |= IFF_LIVE_ADDR_CHANGE;
+	dev->priv_flags |= IFF_LIVE_ADDR_CHANGE | IFF_DO_RUNTIME_PM;
 
 	/*
 	 * Pretend we are using VLANs; This bypasses a nasty bug where
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 118c40258d07..b149eca32adc 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1768,6 +1768,7 @@ enum netdev_priv_flags {
 	IFF_TX_SKB_NO_LINEAR		= BIT_ULL(31),
 	IFF_CHANGE_PROTO_DOWN		= BIT_ULL(32),
 	IFF_SEE_ALL_HWTSTAMP_REQUESTS	= BIT_ULL(33),
+	IFF_DO_RUNTIME_PM		= BIT_ULL(34),
 };
 
 #define IFF_802_1Q_VLAN			IFF_802_1Q_VLAN
diff --git a/net/core/dev.c b/net/core/dev.c
index cb2dab0feee0..bd9af0469dfa 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -1420,7 +1420,7 @@ static int __dev_open(struct net_device *dev, struct netlink_ext_ack *extack)
 
 	if (!netif_device_present(dev)) {
 		/* may be detached because parent is runtime-suspended */
-		if (dev->dev.parent)
+		if (dev->priv_flags & IFF_DO_RUNTIME_PM && dev->dev.parent)
 			pm_runtime_resume(dev->dev.parent);
 		if (!netif_device_present(dev))
 			return -ENODEV;
diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index 7519b0818b91..8e424c08de89 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -2875,7 +2875,7 @@ __dev_ethtool(struct net *net, struct ifreq *ifr, void __user *useraddr,
 			return -EPERM;
 	}
 
-	if (dev->dev.parent)
+	if (dev->priv_flags & IFF_DO_RUNTIME_PM && dev->dev.parent)
 		pm_runtime_get_sync(dev->dev.parent);
 
 	if (!netif_device_present(dev)) {
@@ -3106,7 +3106,7 @@ __dev_ethtool(struct net *net, struct ifreq *ifr, void __user *useraddr,
 	if (old_features != dev->features)
 		netdev_features_change(dev);
 out:
-	if (dev->dev.parent)
+	if (dev->priv_flags & IFF_DO_RUNTIME_PM && dev->dev.parent)
 		pm_runtime_put(dev->dev.parent);
 
 	return rc;
diff --git a/net/ethtool/netlink.c b/net/ethtool/netlink.c
index fe3553f60bf3..089a88a12f7a 100644
--- a/net/ethtool/netlink.c
+++ b/net/ethtool/netlink.c
@@ -37,7 +37,7 @@ int ethnl_ops_begin(struct net_device *dev)
 	if (!dev)
 		return -ENODEV;
 
-	if (dev->dev.parent)
+	if (dev->priv_flags & IFF_DO_RUNTIME_PM && dev->dev.parent)
 		pm_runtime_get_sync(dev->dev.parent);
 
 	if (!netif_device_present(dev) ||
@@ -54,7 +54,7 @@ int ethnl_ops_begin(struct net_device *dev)
 
 	return 0;
 err:
-	if (dev->dev.parent)
+	if (dev->priv_flags & IFF_DO_RUNTIME_PM && dev->dev.parent)
 		pm_runtime_put(dev->dev.parent);
 
 	return ret;
@@ -65,7 +65,7 @@ void ethnl_ops_complete(struct net_device *dev)
 	if (dev->ethtool_ops->complete)
 		dev->ethtool_ops->complete(dev);
 
-	if (dev->dev.parent)
+	if (dev->priv_flags & IFF_DO_RUNTIME_PM  && dev->dev.parent)
 		pm_runtime_put(dev->dev.parent);
 }
 
-- 
2.34.1



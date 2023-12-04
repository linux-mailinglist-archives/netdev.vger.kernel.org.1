Return-Path: <netdev+bounces-53650-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FECB80405A
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 21:47:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE3CB28124F
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 20:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DDD82FC25;
	Mon,  4 Dec 2023 20:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="kTVp5hcP"
X-Original-To: netdev@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D218AAA
	for <netdev@vger.kernel.org>; Mon,  4 Dec 2023 12:47:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=HPeLbO6YanfaBqml2qtht/At26Dk9UVoLR7RL810Quo=; t=1701722831; x=1702932431; 
	b=kTVp5hcPBPdMgKM45+8AbQTPYdujd0FRO67RPBPAyMYOMNymXthp7Dhw9xZSW0EVddYxYiYz94J
	oG/FUKaiGmUChSPZCnMf3eGjL5Qr+cXh97QUrR/IIswcmZUoTtbSesWyjL5dS4kR6lJQTcL1Hjj2r
	xjtOji1Dttte73CZqWwMCiFJHuo1idw3eihKo1unOxYK8fSRTr6q9P8OdFgLiCfM2gGnejynSJAw8
	x29iFt8O7gBzXQm5EBhvdbhSm5Pu7+jkHUSsOai4Hb5Kze8n+kVy5f00bUivLxXs0/H152DTNIc0z
	iVZz8n/57rkQiidE5AW07A/XmH84+K2Cek1Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rAFqP-0000000FFhB-1b3R;
	Mon, 04 Dec 2023 21:47:09 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: netdev@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH net] net: core: synchronize link-watch when carrier is queried
Date: Mon,  4 Dec 2023 21:47:07 +0100
Message-ID: <20231204214706.303c62768415.I1caedccae72ee5a45c9085c5eb49c145ce1c0dd5@changeid>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

There are multiple ways to query for the carrier state: through
rtnetlink, sysfs, and (possibly) ethtool. Synchronize linkwatch
work before these operations so that we don't have a situation
where userspace queries the carrier state between the driver's
carrier off->on transition and linkwatch running and expects it
to work, when really (at least) TX cannot work until linkwatch
has run.

I previously posted a longer explanation of how this applies to
wireless [1] but with this wireless can simply query the state
before sending data, to ensure the kernel is ready for it.

[1] https://lore.kernel.org/all/346b21d87c69f817ea3c37caceb34f1f56255884.camel@sipsolutions.net/

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/linux/netdevice.h | 9 +++++++++
 net/core/dev.c            | 2 +-
 net/core/dev.h            | 1 -
 net/core/link_watch.c     | 2 +-
 net/core/net-sysfs.c      | 8 +++++++-
 net/core/rtnetlink.c      | 8 ++++++++
 net/ethtool/ioctl.c       | 3 +++
 7 files changed, 29 insertions(+), 4 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 2564e209465e..17dbaf379c69 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -4195,6 +4195,15 @@ static inline void netdev_ref_replace(struct net_device *odev,
  */
 void linkwatch_fire_event(struct net_device *dev);
 
+/**
+ * linkwatch_sync_dev - sync linkwatch for the given device
+ * @dev: network device to sync linkwatch for
+ *
+ * Sync linkwatch for the given device, removing it from the
+ * pending work list (if queued).
+ */
+void linkwatch_sync_dev(struct net_device *dev);
+
 /**
  *	netif_carrier_ok - test if carrier present
  *	@dev: network device
diff --git a/net/core/dev.c b/net/core/dev.c
index c879246be48d..188799b2c6a5 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -10511,7 +10511,7 @@ void netdev_run_todo(void)
 		write_lock(&dev_base_lock);
 		dev->reg_state = NETREG_UNREGISTERED;
 		write_unlock(&dev_base_lock);
-		linkwatch_forget_dev(dev);
+		linkwatch_sync_dev(dev);
 	}
 
 	while (!list_empty(&list)) {
diff --git a/net/core/dev.h b/net/core/dev.h
index 5aa45f0fd4ae..cb06fe5e38ea 100644
--- a/net/core/dev.h
+++ b/net/core/dev.h
@@ -30,7 +30,6 @@ int __init dev_proc_init(void);
 #endif
 
 void linkwatch_init_dev(struct net_device *dev);
-void linkwatch_forget_dev(struct net_device *dev);
 void linkwatch_run_queue(void);
 
 void dev_addr_flush(struct net_device *dev);
diff --git a/net/core/link_watch.c b/net/core/link_watch.c
index ed3e5391fa79..7be5b3ab32bd 100644
--- a/net/core/link_watch.c
+++ b/net/core/link_watch.c
@@ -240,7 +240,7 @@ static void __linkwatch_run_queue(int urgent_only)
 	spin_unlock_irq(&lweventlist_lock);
 }
 
-void linkwatch_forget_dev(struct net_device *dev)
+void linkwatch_sync_dev(struct net_device *dev)
 {
 	unsigned long flags;
 	int clean = 0;
diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index fccaa5bac0ed..d9b33e923b18 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -194,8 +194,14 @@ static ssize_t carrier_show(struct device *dev,
 {
 	struct net_device *netdev = to_net_dev(dev);
 
-	if (netif_running(netdev))
+	if (netif_running(netdev)) {
+		/* Synchronize carrier state with link watch,
+		 * see also rtnl_getlink().
+		 */
+		linkwatch_sync_dev(netdev);
+
 		return sysfs_emit(buf, fmt_dec, !!netif_carrier_ok(netdev));
+	}
 
 	return -EINVAL;
 }
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index e8431c6c8490..613268d7c491 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -3853,6 +3853,14 @@ static int rtnl_getlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 	if (nskb == NULL)
 		goto out;
 
+	/* Synchronize the carrier state so we don't report a state
+	 * that we're not actually going to honour immediately; if
+	 * the driver just did a carrier off->on transition, we can
+	 * only TX if link watch work has run, but without this we'd
+	 * already report carrier on, even if it doesn't work yet.
+	 */
+	linkwatch_sync_dev(dev);
+
 	err = rtnl_fill_ifinfo(nskb, dev, net,
 			       RTM_NEWLINK, NETLINK_CB(skb).portid,
 			       nlh->nlmsg_seq, 0, 0, ext_filter_mask,
diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index 0b0ce4f81c01..a977f8903467 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -58,6 +58,9 @@ static struct devlink *netdev_to_devlink_get(struct net_device *dev)
 
 u32 ethtool_op_get_link(struct net_device *dev)
 {
+	/* Synchronize carrier state with link watch, see also rtnl_getlink() */
+	linkwatch_sync_dev(dev);
+
 	return netif_carrier_ok(dev) ? 1 : 0;
 }
 EXPORT_SYMBOL(ethtool_op_get_link);
-- 
2.43.0



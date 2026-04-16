Return-Path: <netdev+bounces-279117-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0N5zFCQx4WlGqQAAu9opvQ
	(envelope-from <netdev+bounces-279117-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 20:57:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C6DE413E93
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 20:57:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0ACEE308A97E
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 18:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D736934A76E;
	Thu, 16 Apr 2026 18:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gAWgv1et"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f67.google.com (mail-oa1-f67.google.com [209.85.160.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06DB349B0D
	for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 18:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776365838; cv=none; b=Gr7wBDkK3s+xPoN3XBXF+jvFlfsUiTrbT+SaKZRcixU5bxtu9XbWEUyHTf0kO+jwbhqoNu3QZUJe9Akgc7buGlTu5pGIj2sbPbBzJEId11jWC+ZztkmXYExyw4z6l5kiAYhLZzrCT8K1X6/qvj9bpPlLuGCLZPz7wpe5OAeKgSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776365838; c=relaxed/simple;
	bh=RpP0ghPYkXYyxCzeoFcR1C+QJytn0nUatnTFYLy20Io=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kZRkJfCuYqvlp7ta2LnrN678Ats6l6dSKBT/D+0iIs2tfrhREch9vs5n9jDIpz79J5ZigjP33VmW3G6Ukvx/ToG3WrlBwAqLpRjDwkCbCnAIZRI0EIQxfY1dVnWiaNTRiB9R3mlWQUukX62WyO08RGsu8T6z9M+V6UMd62/LRfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gAWgv1et; arc=none smtp.client-ip=209.85.160.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f67.google.com with SMTP id 586e51a60fabf-42306f82341so4752211fac.2
        for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 11:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776365836; x=1776970636; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V/nILRcN6OBW1vD/5qdaPFqqkmrEknnRXeLiUw/PKSM=;
        b=gAWgv1etmFgdtQHx3pm10Y3DayxV3dhSoEYkfV92GRquTgmvshYdKWBzl9h1L/lhH+
         ebwVQa+lo4kileSGw12LIJf2Hz7p7RduRmQvnRF2l2PolWe36DE/b0ym9HMcscnrfdIr
         3lyPpD04cR3dMD75o1G+QxDvOv1e9Uex63wBwtVvFbnRtCAHpAQUbfPdsiL1Dnr0xwBh
         o/0Rb4EoataiW0Y761ZQN8GpEn2sr3kQh0xzspkUBpvIGg/QpF2w7hwa2gqQLzeA4XJH
         qUe6ELd7F3f5E0TC7HvZWEHSpF6+nAp46mUJukgXzsZHtxEzEvFKttL4WOTmTGBGfYUm
         0how==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776365836; x=1776970636;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=V/nILRcN6OBW1vD/5qdaPFqqkmrEknnRXeLiUw/PKSM=;
        b=EIERtsbq50uATP+7ze/JjgBUrtPyt0sltCplp2PlT9fIcEarjAQYUKaCuLBNgeBavg
         A2ZllncArhKNYgg4V8WA13LxsIS7ouw7AYG306pjca2fFxF6q/Wb2l5l0+y6zeglFm8F
         zCU7o04rV0+ivqy8a9lOeu2TvTdPvDeR91IaJvkcqc61vj36/6u+AaAW5Eh2XErGdN61
         xvNhgABzajfJcwHK4rbFa5yYeWAldTl/3DlrzVXtVxUPeIUfNg03mLBmipHHiphsio1X
         vo/LwuVkXcRI5AosziIxF35H9WeRA+pQMhQdo4677jH1kXWD1jLOfnGHEcpJtywORCcV
         EmFQ==
X-Gm-Message-State: AOJu0YzrqeHhM4OXX6E8d9DODWX+2SS6G7qJOmlyEwzZfx1vofQuDbNh
	McPBzmFKzBwLOk8bNGW8L3sIE2nA3n/bjiuz3t/kuTvE6fAEfg3TTsczTZX5KI1y
X-Gm-Gg: AeBDieuKD/6U7W2XyBdAgleu6UnsLu+oowglJrpi6KqO3+4X/iA5mvTSIBBwp9JCQXd
	9LTwfKlrVyxXtZ0HOUgwxIoJUsITjy0PpUpGCwXyhm6DBuAQQaUvCdSmgozx0sPnETi/xySV1QN
	BwLhOQc6oX0MVVOrG80CpyQLqY3DEwfAB1s0xitSk/ZMxSE9Wbg6dLAv8t13lw7Tb5Wr8F2JR24
	QPExf4vuEP6FtqPdOC721h3HuEGvahxjjflGoCK1Exu5iIhUjIoV2vY0fBMDqClWnDAHb4z7tQ6
	HWiX3k5TaSPGdtD+eOnwtwDcV5Bmd4hYY9dKiDrBllg/zdZ1TJ3X26tS2hinWnwWbo+53UIz5gn
	HbhybW58gdFZkIye+XPW0fQHSUe0crsBn4ODYu5xH3m36FnhngyNvPvS/9ckqAyGRmrgqUBBJQ5
	3TMIt1yk1zuSphne/Vm8p9mbLnSqRX
X-Received: by 2002:a05:6870:c14f:b0:417:6c45:b92e with SMTP id 586e51a60fabf-4289150ca79mr372252fac.19.1776365835619;
        Thu, 16 Apr 2026 11:57:15 -0700 (PDT)
Received: from localhost ([2a03:2880:12ff:43::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-42666bcbedbsm4519145fac.5.2026.04.16.11.57.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 11:57:15 -0700 (PDT)
From: Stanislav Fomichev <sdf.kernel@gmail.com>
X-Google-Original-From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [PATCH net v8 02/15] net: introduce ndo_set_rx_mode_async and netdev_rx_mode_work
Date: Thu, 16 Apr 2026 11:56:59 -0700
Message-ID: <20260416185712.2155425-3-sdf@fomichev.me>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260416185712.2155425-1-sdf@fomichev.me>
References: <20260416185712.2155425-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-279117-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,fomichev.me:mid,fomichev.me:email]
X-Rspamd-Queue-Id: 7C6DE413E93
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add ndo_set_rx_mode_async callback that drivers can implement instead
of the legacy ndo_set_rx_mode. The legacy callback runs under the
netif_addr_lock spinlock with BHs disabled, preventing drivers from
sleeping. The async variant runs from a work queue with rtnl_lock and
netdev_lock_ops held, in fully sleepable context.

When __dev_set_rx_mode() sees ndo_set_rx_mode_async, it schedules
netdev_rx_mode_work instead of calling the driver inline. The work
function takes two snapshots of each address list (uc/mc) under
the addr_lock, then drops the lock and calls the driver with the
work copies. After the driver returns, it reconciles the snapshots
back to the real lists under the lock.

Add netif_rx_mode_sync() to opportunistically execute the pending
workqueue update inline, so that rx mode changes are committed
before returning to userspace:
  - dev_change_flags (SIOCSIFFLAGS / RTM_NEWLINK)
  - dev_set_promiscuity
  - dev_set_allmulti
  - dev_ifsioc SIOCADDMULTI / SIOCDELMULTI
  - do_setlink (RTM_SETLINK)

Note that some deep hierarchies still do skip the lower updates via:
  - dev_uc_sync
  - dev_mc_sync

If we do end up hitting user-visible issues, we can add more calls to
netif_rx_mode_sync in specific places. But hopefully we should not,
the actual user-visible lists are still synced, it's that just HW state
that might be lagging.

Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 Documentation/networking/netdevices.rst |   9 +
 include/linux/netdevice.h               |  18 ++
 net/core/dev.c                          |  43 +----
 net/core/dev.h                          |   3 +
 net/core/dev_addr_lists.c               | 209 ++++++++++++++++++++++++
 net/core/dev_api.c                      |   3 +
 net/core/dev_ioctl.c                    |   6 +-
 net/core/rtnetlink.c                    |   1 +
 8 files changed, 249 insertions(+), 43 deletions(-)

diff --git a/Documentation/networking/netdevices.rst b/Documentation/networking/netdevices.rst
index 83e28b96884f..e89b12d4f3a7 100644
--- a/Documentation/networking/netdevices.rst
+++ b/Documentation/networking/netdevices.rst
@@ -289,6 +289,15 @@ struct net_device synchronization rules
 ndo_set_rx_mode:
 	Synchronization: netif_addr_lock spinlock.
 	Context: BHs disabled
+	Notes: Deprecated in favor of ndo_set_rx_mode_async which runs
+	in process context.
+
+ndo_set_rx_mode_async:
+	Synchronization: rtnl_lock() semaphore. In addition, netdev instance
+	lock if the driver implements queue management or shaper API.
+	Context: process (from a work queue)
+	Notes: Async version of ndo_set_rx_mode which runs in process
+	context. Receives snapshots of the unicast and multicast address lists.
 
 ndo_setup_tc:
 	``TC_SETUP_BLOCK`` and ``TC_SETUP_FT`` are running under NFT locks
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index a84c55488b8c..6ed97f4c3bc6 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1119,6 +1119,16 @@ struct netdev_net_notifier {
  *	This function is called device changes address list filtering.
  *	If driver handles unicast address filtering, it should set
  *	IFF_UNICAST_FLT in its priv_flags.
+ *	Cannot sleep, called with netif_addr_lock_bh held.
+ *	Deprecated in favor of ndo_set_rx_mode_async.
+ *
+ * void (*ndo_set_rx_mode_async)(struct net_device *dev,
+ *				 struct netdev_hw_addr_list *uc,
+ *				 struct netdev_hw_addr_list *mc);
+ *	Async version of ndo_set_rx_mode which runs in process context
+ *	with rtnl_lock and netdev_lock_ops(dev) held. The uc/mc parameters
+ *	are snapshots of the address lists - iterate with
+ *	netdev_hw_addr_list_for_each(ha, uc).
  *
  * int (*ndo_set_mac_address)(struct net_device *dev, void *addr);
  *	This function  is called when the Media Access Control address
@@ -1439,6 +1449,10 @@ struct net_device_ops {
 	void			(*ndo_change_rx_flags)(struct net_device *dev,
 						       int flags);
 	void			(*ndo_set_rx_mode)(struct net_device *dev);
+	void			(*ndo_set_rx_mode_async)(
+					struct net_device *dev,
+					struct netdev_hw_addr_list *uc,
+					struct netdev_hw_addr_list *mc);
 	int			(*ndo_set_mac_address)(struct net_device *dev,
 						       void *addr);
 	int			(*ndo_validate_addr)(struct net_device *dev);
@@ -1903,6 +1917,8 @@ enum netdev_reg_state {
  *				has been enabled due to the need to listen to
  *				additional unicast addresses in a device that
  *				does not implement ndo_set_rx_mode()
+ *	@rx_mode_node:		List entry for rx_mode work processing
+ *	@rx_mode_tracker:	Refcount tracker for rx_mode work
  *	@uc:			unicast mac addresses
  *	@mc:			multicast mac addresses
  *	@dev_addrs:		list of device hw addresses
@@ -2294,6 +2310,8 @@ struct net_device {
 	unsigned int		promiscuity;
 	unsigned int		allmulti;
 	bool			uc_promisc;
+	struct list_head	rx_mode_node;
+	netdevice_tracker	rx_mode_tracker;
 #ifdef CONFIG_LOCKDEP
 	unsigned char		nested_level;
 #endif
diff --git a/net/core/dev.c b/net/core/dev.c
index e59f6025067c..b37061238a25 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -9593,7 +9593,7 @@ static void dev_change_rx_flags(struct net_device *dev, int flags)
 		ops->ndo_change_rx_flags(dev, flags);
 }
 
-static int __dev_set_promiscuity(struct net_device *dev, int inc, bool notify)
+int __dev_set_promiscuity(struct net_device *dev, int inc, bool notify)
 {
 	unsigned int old_flags = dev->flags;
 	unsigned int promiscuity, flags;
@@ -9697,46 +9697,6 @@ int netif_set_allmulti(struct net_device *dev, int inc, bool notify)
 	return 0;
 }
 
-/*
- *	Upload unicast and multicast address lists to device and
- *	configure RX filtering. When the device doesn't support unicast
- *	filtering it is put in promiscuous mode while unicast addresses
- *	are present.
- */
-void __dev_set_rx_mode(struct net_device *dev)
-{
-	const struct net_device_ops *ops = dev->netdev_ops;
-
-	/* dev_open will call this function so the list will stay sane. */
-	if (!(dev->flags&IFF_UP))
-		return;
-
-	if (!netif_device_present(dev))
-		return;
-
-	if (!(dev->priv_flags & IFF_UNICAST_FLT)) {
-		/* Unicast addresses changes may only happen under the rtnl,
-		 * therefore calling __dev_set_promiscuity here is safe.
-		 */
-		if (!netdev_uc_empty(dev) && !dev->uc_promisc) {
-			__dev_set_promiscuity(dev, 1, false);
-			dev->uc_promisc = true;
-		} else if (netdev_uc_empty(dev) && dev->uc_promisc) {
-			__dev_set_promiscuity(dev, -1, false);
-			dev->uc_promisc = false;
-		}
-	}
-
-	if (ops->ndo_set_rx_mode)
-		ops->ndo_set_rx_mode(dev);
-}
-
-void dev_set_rx_mode(struct net_device *dev)
-{
-	netif_addr_lock_bh(dev);
-	__dev_set_rx_mode(dev);
-	netif_addr_unlock_bh(dev);
-}
 
 /**
  * netif_get_flags() - get flags reported to userspace
@@ -12127,6 +12087,7 @@ struct net_device *alloc_netdev_mqs(int sizeof_priv, const char *name,
 #endif
 
 	mutex_init(&dev->lock);
+	INIT_LIST_HEAD(&dev->rx_mode_node);
 
 	dev->priv_flags = IFF_XMIT_DST_RELEASE | IFF_XMIT_DST_RELEASE_PERM;
 	setup(dev);
diff --git a/net/core/dev.h b/net/core/dev.h
index 585b6d7e88df..0cf24b8f5008 100644
--- a/net/core/dev.h
+++ b/net/core/dev.h
@@ -165,6 +165,9 @@ int netif_change_carrier(struct net_device *dev, bool new_carrier);
 int dev_change_carrier(struct net_device *dev, bool new_carrier);
 
 void __dev_set_rx_mode(struct net_device *dev);
+int __dev_set_promiscuity(struct net_device *dev, int inc, bool notify);
+bool netif_rx_mode_clean(struct net_device *dev);
+void netif_rx_mode_sync(struct net_device *dev);
 
 void __dev_notify_flags(struct net_device *dev, unsigned int old_flags,
 			unsigned int gchanges, u32 portid,
diff --git a/net/core/dev_addr_lists.c b/net/core/dev_addr_lists.c
index bb4851bc55ce..056bca6fce12 100644
--- a/net/core/dev_addr_lists.c
+++ b/net/core/dev_addr_lists.c
@@ -11,10 +11,18 @@
 #include <linux/rtnetlink.h>
 #include <linux/export.h>
 #include <linux/list.h>
+#include <linux/spinlock.h>
+#include <linux/workqueue.h>
 #include <kunit/visibility.h>
 
 #include "dev.h"
 
+static void netdev_rx_mode_work(struct work_struct *work);
+
+static LIST_HEAD(rx_mode_list);
+static DEFINE_SPINLOCK(rx_mode_lock);
+static DECLARE_WORK(rx_mode_work, netdev_rx_mode_work);
+
 /*
  * General list handling functions
  */
@@ -1156,3 +1164,204 @@ void dev_mc_init(struct net_device *dev)
 	__hw_addr_init(&dev->mc);
 }
 EXPORT_SYMBOL(dev_mc_init);
+
+static int netif_addr_lists_snapshot(struct net_device *dev,
+				     struct netdev_hw_addr_list *uc_snap,
+				     struct netdev_hw_addr_list *mc_snap,
+				     struct netdev_hw_addr_list *uc_ref,
+				     struct netdev_hw_addr_list *mc_ref)
+{
+	int err;
+
+	err = __hw_addr_list_snapshot(uc_snap, &dev->uc, dev->addr_len);
+	if (!err)
+		err = __hw_addr_list_snapshot(uc_ref, &dev->uc, dev->addr_len);
+	if (!err)
+		err = __hw_addr_list_snapshot(mc_snap, &dev->mc,
+					      dev->addr_len);
+	if (!err)
+		err = __hw_addr_list_snapshot(mc_ref, &dev->mc, dev->addr_len);
+
+	if (err) {
+		__hw_addr_flush(uc_snap);
+		__hw_addr_flush(uc_ref);
+		__hw_addr_flush(mc_snap);
+	}
+
+	return err;
+}
+
+static void netif_addr_lists_reconcile(struct net_device *dev,
+				       struct netdev_hw_addr_list *uc_snap,
+				       struct netdev_hw_addr_list *mc_snap,
+				       struct netdev_hw_addr_list *uc_ref,
+				       struct netdev_hw_addr_list *mc_ref)
+{
+	__hw_addr_list_reconcile(&dev->uc, uc_snap, uc_ref, dev->addr_len);
+	__hw_addr_list_reconcile(&dev->mc, mc_snap, mc_ref, dev->addr_len);
+}
+
+static void netif_rx_mode_run(struct net_device *dev)
+{
+	struct netdev_hw_addr_list uc_snap, mc_snap, uc_ref, mc_ref;
+	const struct net_device_ops *ops = dev->netdev_ops;
+	int err;
+
+	might_sleep();
+	netdev_ops_assert_locked(dev);
+
+	__hw_addr_init(&uc_snap);
+	__hw_addr_init(&mc_snap);
+	__hw_addr_init(&uc_ref);
+	__hw_addr_init(&mc_ref);
+
+	if (!(dev->flags & IFF_UP) || !netif_device_present(dev))
+		return;
+
+	netif_addr_lock_bh(dev);
+	err = netif_addr_lists_snapshot(dev, &uc_snap, &mc_snap,
+					&uc_ref, &mc_ref);
+	if (err) {
+		netdev_WARN(dev, "failed to sync uc/mc addresses\n");
+		netif_addr_unlock_bh(dev);
+		return;
+	}
+	netif_addr_unlock_bh(dev);
+
+	ops->ndo_set_rx_mode_async(dev, &uc_snap, &mc_snap);
+
+	netif_addr_lock_bh(dev);
+	netif_addr_lists_reconcile(dev, &uc_snap, &mc_snap,
+				   &uc_ref, &mc_ref);
+	netif_addr_unlock_bh(dev);
+}
+
+static void netdev_rx_mode_work(struct work_struct *work)
+{
+	struct net_device *dev;
+
+	rtnl_lock();
+
+	while (true) {
+		spin_lock_bh(&rx_mode_lock);
+		if (list_empty(&rx_mode_list)) {
+			spin_unlock_bh(&rx_mode_lock);
+			break;
+		}
+		dev = list_first_entry(&rx_mode_list, struct net_device,
+				       rx_mode_node);
+		list_del_init(&dev->rx_mode_node);
+		/* We must free netdev tracker under
+		 * the spinlock protection.
+		 */
+		netdev_tracker_free(dev, &dev->rx_mode_tracker);
+		spin_unlock_bh(&rx_mode_lock);
+
+		netdev_lock_ops(dev);
+		netif_rx_mode_run(dev);
+		netdev_unlock_ops(dev);
+		/* Use __dev_put() because netdev_tracker_free() was already
+		 * called above. Must be after netdev_unlock_ops() to prevent
+		 * netdev_run_todo() from freeing the device while still in use.
+		 */
+		__dev_put(dev);
+	}
+
+	rtnl_unlock();
+}
+
+static void netif_rx_mode_queue(struct net_device *dev)
+{
+	spin_lock_bh(&rx_mode_lock);
+	if (list_empty(&dev->rx_mode_node)) {
+		list_add_tail(&dev->rx_mode_node, &rx_mode_list);
+		netdev_hold(dev, &dev->rx_mode_tracker, GFP_ATOMIC);
+	}
+	spin_unlock_bh(&rx_mode_lock);
+	schedule_work(&rx_mode_work);
+}
+
+/**
+ * __dev_set_rx_mode() - upload unicast and multicast address lists to device
+ * and configure RX filtering.
+ * @dev: device
+ *
+ * When the device doesn't support unicast filtering it is put in promiscuous
+ * mode while unicast addresses are present.
+ */
+void __dev_set_rx_mode(struct net_device *dev)
+{
+	const struct net_device_ops *ops = dev->netdev_ops;
+
+	/* dev_open will call this function so the list will stay sane. */
+	if (!(dev->flags & IFF_UP))
+		return;
+
+	if (!netif_device_present(dev))
+		return;
+
+	if (ops->ndo_set_rx_mode_async) {
+		netif_rx_mode_queue(dev);
+		return;
+	}
+
+	if (!(dev->priv_flags & IFF_UNICAST_FLT)) {
+		if (!netdev_uc_empty(dev) && !dev->uc_promisc) {
+			__dev_set_promiscuity(dev, 1, false);
+			dev->uc_promisc = true;
+		} else if (netdev_uc_empty(dev) && dev->uc_promisc) {
+			__dev_set_promiscuity(dev, -1, false);
+			dev->uc_promisc = false;
+		}
+	}
+
+	if (ops->ndo_set_rx_mode)
+		ops->ndo_set_rx_mode(dev);
+}
+
+void dev_set_rx_mode(struct net_device *dev)
+{
+	netif_addr_lock_bh(dev);
+	__dev_set_rx_mode(dev);
+	netif_addr_unlock_bh(dev);
+}
+
+bool netif_rx_mode_clean(struct net_device *dev)
+{
+	bool clean = false;
+
+	spin_lock_bh(&rx_mode_lock);
+	if (!list_empty(&dev->rx_mode_node)) {
+		list_del_init(&dev->rx_mode_node);
+		clean = true;
+		/* We must release netdev tracker under
+		 * the spinlock protection.
+		 */
+		netdev_tracker_free(dev, &dev->rx_mode_tracker);
+	}
+	spin_unlock_bh(&rx_mode_lock);
+
+	return clean;
+}
+
+/**
+ * netif_rx_mode_sync() - sync rx mode inline
+ * @dev: network device
+ *
+ * Drivers implementing ndo_set_rx_mode_async() have their rx mode callback
+ * executed from a workqueue. This allows the callback to sleep, but means
+ * the hardware update is deferred and may not be visible to userspace
+ * by the time the initiating syscall returns. netif_rx_mode_sync() steals
+ * workqueue update and executes it inline. This preserves the atomicity of
+ * operations to the userspace.
+ */
+void netif_rx_mode_sync(struct net_device *dev)
+{
+	if (netif_rx_mode_clean(dev)) {
+		netif_rx_mode_run(dev);
+		/* Use __dev_put() because netdev_tracker_free() was already
+		 * called inside netif_rx_mode_clean().
+		 */
+		__dev_put(dev);
+	}
+}
diff --git a/net/core/dev_api.c b/net/core/dev_api.c
index f28852078aa6..437947dd08ed 100644
--- a/net/core/dev_api.c
+++ b/net/core/dev_api.c
@@ -66,6 +66,7 @@ int dev_change_flags(struct net_device *dev, unsigned int flags,
 
 	netdev_lock_ops(dev);
 	ret = netif_change_flags(dev, flags, extack);
+	netif_rx_mode_sync(dev);
 	netdev_unlock_ops(dev);
 
 	return ret;
@@ -285,6 +286,7 @@ int dev_set_promiscuity(struct net_device *dev, int inc)
 
 	netdev_lock_ops(dev);
 	ret = netif_set_promiscuity(dev, inc);
+	netif_rx_mode_sync(dev);
 	netdev_unlock_ops(dev);
 
 	return ret;
@@ -311,6 +313,7 @@ int dev_set_allmulti(struct net_device *dev, int inc)
 
 	netdev_lock_ops(dev);
 	ret = netif_set_allmulti(dev, inc, true);
+	netif_rx_mode_sync(dev);
 	netdev_unlock_ops(dev);
 
 	return ret;
diff --git a/net/core/dev_ioctl.c b/net/core/dev_ioctl.c
index 7a8966544c9d..f3979b276090 100644
--- a/net/core/dev_ioctl.c
+++ b/net/core/dev_ioctl.c
@@ -586,24 +586,26 @@ static int dev_ifsioc(struct net *net, struct ifreq *ifr, void __user *data,
 		return err;
 
 	case SIOCADDMULTI:
-		if (!ops->ndo_set_rx_mode ||
+		if ((!ops->ndo_set_rx_mode && !ops->ndo_set_rx_mode_async) ||
 		    ifr->ifr_hwaddr.sa_family != AF_UNSPEC)
 			return -EINVAL;
 		if (!netif_device_present(dev))
 			return -ENODEV;
 		netdev_lock_ops(dev);
 		err = dev_mc_add_global(dev, ifr->ifr_hwaddr.sa_data);
+		netif_rx_mode_sync(dev);
 		netdev_unlock_ops(dev);
 		return err;
 
 	case SIOCDELMULTI:
-		if (!ops->ndo_set_rx_mode ||
+		if ((!ops->ndo_set_rx_mode && !ops->ndo_set_rx_mode_async) ||
 		    ifr->ifr_hwaddr.sa_family != AF_UNSPEC)
 			return -EINVAL;
 		if (!netif_device_present(dev))
 			return -ENODEV;
 		netdev_lock_ops(dev);
 		err = dev_mc_del_global(dev, ifr->ifr_hwaddr.sa_data);
+		netif_rx_mode_sync(dev);
 		netdev_unlock_ops(dev);
 		return err;
 
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 69daba3ddaf0..b613bb6e07df 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -3431,6 +3431,7 @@ static int do_setlink(const struct sk_buff *skb, struct net_device *dev,
 					     dev->name);
 	}
 
+	netif_rx_mode_sync(dev);
 	netdev_unlock_ops(dev);
 
 	return err;
-- 
2.52.0



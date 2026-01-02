Return-Path: <netdev+bounces-246608-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 327A5CEF247
	for <lists+netdev@lfdr.de>; Fri, 02 Jan 2026 19:11:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DA70F301F8CD
	for <lists+netdev@lfdr.de>; Fri,  2 Jan 2026 18:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7409314D3D;
	Fri,  2 Jan 2026 18:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G7X9KnDf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7EE3148C8
	for <netdev@vger.kernel.org>; Fri,  2 Jan 2026 18:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767377167; cv=none; b=I92+WAuBUuFHWm7CY6REQ8RqeqTxfFu698Nh3gKfRKIvGdWHDTri4vus/4x0X6J7DxJlDSZPGMTPJVEnw6QkV5XsPYjMgWdVe7pGLste6X50bBhRkDNk0rkwx7tfKke6cxlEJRSPv9AZfvXxxIbltIrUXKejIiKU24HyeC0aaw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767377167; c=relaxed/simple;
	bh=QL6iWH/ffOsWWkSiflvPSq6EGb10KY9jnnnWVhluE6A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pvVCntnqvFbiUuUhYU6dcHsq+vWiIgl0HhNUAfCwTqdaq8EJhrx7DM2Xkg6JNZIFw71BgSI9+C66d0kPXYH9s5VDLxgZ+TuI8sTfY1Vk25jrI9ISuM4mZmTsGOdQQlQBycN82xzjotq0C+vSe54uL34mFT9gND+NCkgQTrnUyPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G7X9KnDf; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2a12ebe4b74so219134945ad.0
        for <netdev@vger.kernel.org>; Fri, 02 Jan 2026 10:05:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767377154; x=1767981954; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rDg1l5xXQWfPdXgWqgA3SiOxZopZjh7i4jGImOR73AU=;
        b=G7X9KnDfa07/+Dt/G0BY3jkRcHfUWEWlp7EwGnFsBKhBokwlAo4aH0Z6OK6jI0Ylar
         dsi6PLrmnDb1Qd5XPafwYVwXOFI0acMx53qtx7f0MQNRd0nqffExr/q29VsMQ+T+r0Hh
         ozSgOzrffHMkX12yHdwCMIaNvcDE+HsNMHUNxX64Q0esC6+BhTQoBfYopdcnAj69FHLS
         Zr8ocFBVmdYGp9aE5AUn5yU6/SjoWOWdWXqtLZhzT5cglkYil8HXpULgPj1OafOepwY+
         Bvw01304w/jvQGnRGnU264eRSXmEcxod78iBpNUj4UvBsP8FZ6fbAWfd2JOOdfhmpGIx
         bL8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767377154; x=1767981954;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rDg1l5xXQWfPdXgWqgA3SiOxZopZjh7i4jGImOR73AU=;
        b=T8wuYhMc0Vyt3OS4uwAmK759CVRRlsez8IMxmW3Zj9tT3Mev17METAVZP9Ov28yt02
         hdXRg15e95gXEWTcn+wgszpYq7SWQrIrHcZDRP2M5sLWlkee9Np4OvpXV0xRJ6LzjTAR
         HrjpFIuVZDHdqN1VdSR/cnXciQymiK5QMR28tFjpTwzWtqcfuFqLPY7mieGZLBGUYtmD
         KjLyKVrnHMzzDa4NBpCn9USiszgXjYRTGw1IvWQAu1KEqOOK1w0U2XzdrvUNk4Ei3E6G
         2fyRdeZm9LS40kiJPfhnQDswVhNWVR87/QK9daE7adI6j1UbXR4GKPjvrNfjWaXK//WO
         fymw==
X-Gm-Message-State: AOJu0YyE/PDUXAstfB1muK1AfHdxi/3oC4OKRO/GNFAfUf1hHxJpmE1N
	WaaEsNz5D0wSUEhDCAhm67LgmzDLmN3rGIi76bJqHhPAUIXp6UHYG81l
X-Gm-Gg: AY/fxX4TP6KvnKUQS4G7RT2PmOojeBKXsnaYRTdHrSEbwU1JQrGUgIDR7E3kcks9EbP
	l8xsMHOdnVEAlH+1aKMogCH+gqL1O9q4jqGyZbIfUbkMU4NHTGOZoLr1OO/mH4QQAv4lUsVgbIP
	LFrMpxVcEFZBpFPAG1OCF8V3KW1mxnXVSKyiIlxnJGXY424a+Bc45L/t2aTHipHjKfS1/SLggJx
	cXGb4s3/hPXulxZGW5gALuq5m3COwk+yBA8s2eAMRSDGi6KMiiXAPnvtDe9U1LFGDwLiirVsawT
	6PrgTXyShM9za02zUokTg4jetRz/bxXQW0K2qmMZW3lUz2PCuwlGqFRFii4aX8v2vjQgm2IyTyl
	mtXNRly2eLmFox34Tt6TuMQ8s3oB0hydN4vXbBDajCVe4F6mEZa0F8pTPw1Gbft5AcEK9QMzGbe
	Z7BRNRHestP1/r1fp+P9ISdoLhTSiprFySEVLujAk7Qr+rsSYGSjPZtx3aTkul/Moh+/k=
X-Google-Smtp-Source: AGHT+IEuuXrn9NaOqlNxXjs2ojC/SR61NEtcz1zOTJnY/wbx1biNgLIT0Xg5mI+ZNFeJfAokXBWluQ==
X-Received: by 2002:a17:903:290:b0:2a1:e19:ff5 with SMTP id d9443c01a7336-2a2f273818fmr464251945ad.38.1767377154228;
        Fri, 02 Jan 2026 10:05:54 -0800 (PST)
Received: from localhost.localdomain ([223.181.108.198])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3d77566sm386297585ad.97.2026.01.02.10.05.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 10:05:53 -0800 (PST)
From: I Viswanath <viswanathiyyappan@gmail.com>
To: edumazet@google.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	mst@redhat.com,
	eperezma@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com
Cc: netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	I Viswanath <viswanathiyyappan@gmail.com>
Subject: [PATCH net-next v7 1/2] net: refactor set_rx_mode into snapshot and deferred I/O
Date: Fri,  2 Jan 2026 23:35:29 +0530
Message-ID: <20260102180530.1559514-2-viswanathiyyappan@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260102180530.1559514-1-viswanathiyyappan@gmail.com>
References: <20260102180530.1559514-1-viswanathiyyappan@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ndo_set_rx_mode is problematic as it cannot sleep.

There are drivers that circumvent this by doing the rx_mode work
in a work item. This requires extra work that can be avoided if
core provided a mechanism to do that. This patch proposes such a
mechanism.

Refactor set_rx_mode into 2 stages: A snapshot stage and the
actual I/O. In this new model, when _dev_set_rx_mode is called,
we take a snapshot of the current rx_config and then commit it
to the hardware later via a work item

To accomplish this, reinterpret set_rx_mode as the ndo for
customizing the snapshot and enabling/disabling rx_mode set
and add a new ndo write_rx_mode for the deferred I/O

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: I Viswanath <viswanathiyyappan@gmail.com>
---
 include/linux/netdevice.h | 111 +++++++++++++++-
 net/core/dev.c            | 264 +++++++++++++++++++++++++++++++++++++-
 2 files changed, 368 insertions(+), 7 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 5870a9e514a5..210f320d404d 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1062,6 +1062,44 @@ struct netdev_net_notifier {
 	struct notifier_block *nb;
 };
 
+struct netif_cleanup_work {
+	struct work_struct work;
+	struct net_device *dev;
+};
+
+enum netif_rx_mode_cfg {
+	NETIF_RX_MODE_CFG_ALLMULTI,
+	NETIF_RX_MODE_CFG_PROMISC,
+	NETIF_RX_MODE_CFG_VLAN
+};
+
+enum netif_rx_mode_flags {
+	NETIF_RX_MODE_READY,
+
+	/* if set, rx_mode set work will be skipped */
+	NETIF_RX_MODE_SET_SKIP,
+
+	/* if set, uc/mc lists will not be part of rx_mode config */
+	NETIF_RX_MODE_UC_SKIP,
+	NETIF_RX_MODE_MC_SKIP
+};
+
+struct netif_rx_mode_config {
+	char	*uc_addrs;
+	char	*mc_addrs;
+	int	uc_count;
+	int	mc_count;
+	int	cfg;
+};
+
+struct netif_rx_mode_ctx {
+	struct netif_rx_mode_config *pending;
+	struct netif_rx_mode_config *ready;
+	struct work_struct work;
+	struct net_device *dev;
+	int flags;
+};
+
 /*
  * This structure defines the management hooks for network devices.
  * The following hooks can be defined; unless noted otherwise, they are
@@ -1114,9 +1152,14 @@ struct netdev_net_notifier {
  *	changes to configuration when multicast or promiscuous is enabled.
  *
  * void (*ndo_set_rx_mode)(struct net_device *dev);
- *	This function is called device changes address list filtering.
+ *	This function is called when device changes address list filtering.
  *	If driver handles unicast address filtering, it should set
- *	IFF_UNICAST_FLT in its priv_flags.
+ *	IFF_UNICAST_FLT in its priv_flags. This is used to configure
+ *	the rx_mode snapshot that will be written to the hardware.
+ *
+ * void (*ndo_write_rx_mode)(struct net_device *dev);
+ *	This function is scheduled after set_rx_mode and is responsible for
+ *	writing the rx_mode snapshot to the hardware.
  *
  * int (*ndo_set_mac_address)(struct net_device *dev, void *addr);
  *	This function  is called when the Media Access Control address
@@ -1437,6 +1480,7 @@ struct net_device_ops {
 	void			(*ndo_change_rx_flags)(struct net_device *dev,
 						       int flags);
 	void			(*ndo_set_rx_mode)(struct net_device *dev);
+	void			(*ndo_write_rx_mode)(struct net_device *dev);
 	int			(*ndo_set_mac_address)(struct net_device *dev,
 						       void *addr);
 	int			(*ndo_validate_addr)(struct net_device *dev);
@@ -1939,7 +1983,7 @@ enum netdev_reg_state {
  *	@ingress_queue:		XXX: need comments on this one
  *	@nf_hooks_ingress:	netfilter hooks executed for ingress packets
  *	@broadcast:		hw bcast address
- *
+ *	@rx_mode_ctx:		rx_mode work context
  *	@rx_cpu_rmap:	CPU reverse-mapping for RX completion interrupts,
  *			indexed by RX queue number. Assigned by driver.
  *			This must only be set if the ndo_rx_flow_steer
@@ -1971,6 +2015,8 @@ enum netdev_reg_state {
  *	@link_watch_list:	XXX: need comments on this one
  *
  *	@reg_state:		Register/unregister state machine
+ *	@needs_cleanup_work:	Should dev_close schedule the cleanup work?
+ *	@cleanup_work:		Cleanup work context
  *	@dismantle:		Device is going to be freed
  *	@needs_free_netdev:	Should unregister perform free_netdev?
  *	@priv_destructor:	Called from unregister
@@ -2350,6 +2396,7 @@ struct net_device {
 #endif
 
 	unsigned char		broadcast[MAX_ADDR_LEN];
+	struct netif_rx_mode_ctx *rx_mode_ctx;
 #ifdef CONFIG_RFS_ACCEL
 	struct cpu_rmap		*rx_cpu_rmap;
 #endif
@@ -2387,6 +2434,10 @@ struct net_device {
 
 	u8 reg_state;
 
+	bool needs_cleanup_work;
+
+	struct netif_cleanup_work *cleanup_work;
+
 	bool dismantle;
 
 	/** @moving_ns: device is changing netns, protected by @lock */
@@ -3373,6 +3424,60 @@ int dev_loopback_xmit(struct net *net, struct sock *sk, struct sk_buff *newskb);
 u16 dev_pick_tx_zero(struct net_device *dev, struct sk_buff *skb,
 		     struct net_device *sb_dev);
 
+/* Helpers to be used in the set_rx_mode implementation */
+static inline void netif_rx_mode_set_cfg(struct net_device *dev, int b,
+					 bool val)
+{
+	if (val)
+		dev->rx_mode_ctx->pending->cfg |= BIT(b);
+	else
+		dev->rx_mode_ctx->pending->cfg &= ~BIT(b);
+}
+
+static inline void netif_rx_mode_set_flag(struct net_device *dev, int b,
+					  bool val)
+{
+	if (val)
+		dev->rx_mode_ctx->flags |= BIT(b);
+	else
+		dev->rx_mode_ctx->flags &= ~BIT(b);
+}
+
+/* Helpers to be used in the write_rx_mode implementation */
+static inline int netif_rx_mode_get_cfg(struct net_device *dev, int b)
+{
+	return !!(dev->rx_mode_ctx->ready->cfg & BIT(b));
+}
+
+static inline int netif_rx_mode_get_flag(struct net_device *dev, int b)
+{
+	return !!(dev->rx_mode_ctx->flags & BIT(b));
+}
+
+static inline int netif_rx_mode_get_mc_count(struct net_device *dev)
+{
+	return dev->rx_mode_ctx->ready->mc_count;
+}
+
+static inline int netif_rx_mode_get_uc_count(struct net_device *dev)
+{
+	return dev->rx_mode_ctx->ready->uc_count;
+}
+
+void netif_schedule_rx_mode_work(struct net_device *dev);
+
+void netif_flush_rx_mode_work(struct net_device *dev);
+
+#define netif_rx_mode_for_each_uc_addr(dev, ha_addr, idx) \
+	for (ha_addr = (dev)->rx_mode_ctx->ready->uc_addrs, idx = 0; \
+	     idx < netif_rx_mode_get_uc_count((dev)); \
+	     ha_addr += (dev)->addr_len, idx++)
+
+#define netif_rx_mode_for_each_mc_addr(dev, ha_addr, idx) \
+	for (ha_addr = (dev)->rx_mode_ctx->ready->mc_addrs, idx = 0; \
+	     idx < netif_rx_mode_get_mc_count((dev)); \
+	     ha_addr += (dev)->addr_len, idx++)
+
 int __dev_queue_xmit(struct sk_buff *skb, struct net_device *sb_dev);
 int __dev_direct_xmit(struct sk_buff *skb, u16 queue_id);
 
diff --git a/net/core/dev.c b/net/core/dev.c
index 36dc5199037e..ffa0615b688e 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -1587,6 +1587,206 @@ void netif_state_change(struct net_device *dev)
 	}
 }
 
+/* This function attempts to copy the current state of the
+ * net device into pending (reallocating if necessary). If it fails,
+ * pending is guaranteed to be unmodified.
+ */
+static int __netif_prepare_rx_mode(struct net_device *dev)
+{
+	struct netif_rx_mode_config *pending = dev->rx_mode_ctx->pending;
+	bool skip_uc = false, skip_mc = false;
+	int uc_count = 0, mc_count = 0;
+	struct netdev_hw_addr *ha;
+	char *tmp;
+	int i;
+
+	skip_uc = netif_rx_mode_get_flag(dev, NETIF_RX_MODE_UC_SKIP);
+	skip_mc = netif_rx_mode_get_flag(dev, NETIF_RX_MODE_MC_SKIP);
+
+	/* The allocations need to be atomic since this will be called under
+	 * netif_addr_lock_bh()
+	 */
+	if (!skip_uc) {
+		uc_count = netdev_uc_count(dev);
+		tmp = krealloc(pending->uc_addrs, uc_count * dev->addr_len,
+			       GFP_ATOMIC);
+		if (!tmp)
+			return -ENOMEM;
+		pending->uc_addrs = tmp;
+	}
+
+	if (!skip_mc) {
+		mc_count = netdev_mc_count(dev);
+		tmp = krealloc(pending->mc_addrs, mc_count * dev->addr_len,
+			       GFP_ATOMIC);
+		if (!tmp)
+			return -ENOMEM;
+		pending->mc_addrs = tmp;
+	}
+
+	/* This function cannot fail after this point */
+
+	/* This is going to be the same for every single driver. Better to
+	 * do it here than in the set_rx_mode impl
+	 */
+	netif_rx_mode_set_cfg(dev, NETIF_RX_MODE_CFG_ALLMULTI,
+			      !!(dev->flags & IFF_ALLMULTI));
+
+	netif_rx_mode_set_cfg(dev, NETIF_RX_MODE_CFG_PROMISC,
+			      !!(dev->flags & IFF_PROMISC));
+
+	i = 0;
+	if (!skip_uc) {
+		pending->uc_count = uc_count;
+		netdev_for_each_uc_addr(ha, dev)
+			memcpy(pending->uc_addrs + (i++) * dev->addr_len,
+			       ha->addr, dev->addr_len);
+	}
+
+	i = 0;
+	if (!skip_mc) {
+		pending->mc_count = mc_count;
+		netdev_for_each_mc_addr(ha, dev)
+			memcpy(pending->mc_addrs + (i++) * dev->addr_len,
+			       ha->addr, dev->addr_len);
+	}
+	return 0;
+}
+
+static void netif_prepare_rx_mode(struct net_device *dev)
+{
+	lockdep_assert_held(&dev->addr_list_lock);
+	int rc;
+
+	rc = __netif_prepare_rx_mode(dev);
+	if (rc)
+		return;
+
+	netif_rx_mode_set_flag(dev, NETIF_RX_MODE_READY, true);
+}
+
+static void netif_write_rx_mode(struct work_struct *param)
+{
+	struct netif_rx_mode_ctx *ctx;
+	struct net_device *dev;
+
+	rtnl_lock();
+	ctx = container_of(param, struct netif_rx_mode_ctx, work);
+	dev = ctx->dev;
+
+	if (!netif_running(dev)) {
+		rtnl_unlock();
+		return;
+	}
+
+	/* Paranoia. */
+	if (WARN_ON(!dev->netdev_ops->ndo_write_rx_mode)) {
+		rtnl_unlock();
+		return;
+	}
+
+	/* We could introduce a new lock for this but reusing the addr
+	 * lock works well enough
+	 */
+	netif_addr_lock_bh(dev);
+
+	/* There's no point continuing if the pending config is not ready */
+	if (!netif_rx_mode_get_flag(dev, NETIF_RX_MODE_READY)) {
+		netif_addr_unlock_bh(dev);
+		rtnl_unlock();
+		return;
+	}
+
+	swap(ctx->ready, ctx->pending);
+	netif_rx_mode_set_flag(dev, NETIF_RX_MODE_READY, false);
+	netif_addr_unlock_bh(dev);
+
+	dev->netdev_ops->ndo_write_rx_mode(dev);
+	rtnl_unlock();
+}
+
+static int netif_alloc_rx_mode_ctx(struct net_device *dev)
+{
+	dev->rx_mode_ctx = kzalloc(sizeof(*dev->rx_mode_ctx), GFP_KERNEL);
+	if (!dev->rx_mode_ctx)
+		goto fail_all;
+
+	dev->rx_mode_ctx->ready = kzalloc(sizeof(*dev->rx_mode_ctx->ready),
+					  GFP_KERNEL);
+	if (!dev->rx_mode_ctx->ready)
+		goto fail_ready;
+
+	dev->rx_mode_ctx->pending = kzalloc(sizeof(*dev->rx_mode_ctx->pending),
+					    GFP_KERNEL);
+	if (!dev->rx_mode_ctx->pending)
+		goto fail_pending;
+
+	dev->rx_mode_ctx->dev = dev;
+	INIT_WORK(&dev->rx_mode_ctx->work, netif_write_rx_mode);
+	return 0;
+
+fail_pending:
+	kfree(dev->rx_mode_ctx->ready);
+
+fail_ready:
+	kfree(dev->rx_mode_ctx);
+
+fail_all:
+	return -ENOMEM;
+}
+
+static void netif_free_rx_mode_ctx(struct net_device *dev)
+{
+	if (!dev->rx_mode_ctx)
+		return;
+
+	cancel_work_sync(&dev->rx_mode_ctx->work);
+
+	kfree(dev->rx_mode_ctx->ready->uc_addrs);
+	kfree(dev->rx_mode_ctx->ready->mc_addrs);
+	kfree(dev->rx_mode_ctx->ready);
+
+	kfree(dev->rx_mode_ctx->pending->uc_addrs);
+	kfree(dev->rx_mode_ctx->pending->mc_addrs);
+	kfree(dev->rx_mode_ctx->pending);
+
+	kfree(dev->rx_mode_ctx);
+	dev->rx_mode_ctx = NULL;
+}
+
+static void netif_cleanup_work_fn(struct work_struct *param)
+{
+	struct netif_cleanup_work *ctx;
+	struct net_device *dev;
+
+	ctx = container_of(param, struct netif_cleanup_work, work);
+	dev = ctx->dev;
+
+	if (dev->netdev_ops->ndo_write_rx_mode)
+		netif_free_rx_mode_ctx(dev);
+}
+
+static int netif_alloc_cleanup_work(struct net_device *dev)
+{
+	dev->cleanup_work = kzalloc(sizeof(*dev->cleanup_work), GFP_KERNEL);
+	if (!dev->cleanup_work)
+		return -ENOMEM;
+
+	dev->cleanup_work->dev = dev;
+	INIT_WORK(&dev->cleanup_work->work, netif_cleanup_work_fn);
+	return 0;
+}
+
+static void netif_free_cleanup_work(struct net_device *dev)
+{
+	if (!dev->cleanup_work)
+		return;
+
+	cancel_work_sync(&dev->cleanup_work->work);
+	kfree(dev->cleanup_work);
+	dev->cleanup_work = NULL;
+}
+
 /**
  * __netdev_notify_peers - notify network peers about existence of @dev,
  * to be called when rtnl lock is already held.
@@ -1682,6 +1882,16 @@ static int __dev_open(struct net_device *dev, struct netlink_ext_ack *extack)
 	if (!ret && ops->ndo_open)
 		ret = ops->ndo_open(dev);
 
+	if (!ret && dev->needs_cleanup_work) {
+		if (!dev->cleanup_work)
+			ret = netif_alloc_cleanup_work(dev);
+		else
+			cancel_work_sync(&dev->cleanup_work->work);
+	}
+
+	if (!ret && ops->ndo_write_rx_mode)
+		ret = netif_alloc_rx_mode_ctx(dev);
+
 	netpoll_poll_enable(dev);
 
 	if (ret)
@@ -1755,6 +1965,9 @@ static void __dev_close_many(struct list_head *head)
 		if (ops->ndo_stop)
 			ops->ndo_stop(dev);
 
+		if (dev->needs_cleanup_work)
+			schedule_work(&dev->cleanup_work->work);
+
 		netif_set_up(dev, false);
 		netpoll_poll_enable(dev);
 	}
@@ -9623,6 +9836,47 @@ int netif_set_allmulti(struct net_device *dev, int inc, bool notify)
 	return 0;
 }
 
+/* netif_schedule_rx_mode_work - Sets up the rx_config snapshot and
+ * schedules the deferred I/O.
+ */
+void netif_schedule_rx_mode_work(struct net_device *dev)
+{
+	const struct net_device_ops *ops = dev->netdev_ops;
+
+	if (ops->ndo_set_rx_mode)
+		ops->ndo_set_rx_mode(dev);
+
+	if (!ops->ndo_write_rx_mode)
+		return;
+
+	/* This part is only for drivers that implement ndo_write_rx_mode */
+
+	/* If rx_mode set is to be skipped, we don't schedule the work */
+	if (netif_rx_mode_get_flag(dev, NETIF_RX_MODE_SET_SKIP))
+		return;
+
+	netif_prepare_rx_mode(dev);
+	schedule_work(&dev->rx_mode_ctx->work);
+}
+EXPORT_SYMBOL(netif_schedule_rx_mode_work);
+
+/* Drivers that implement rx mode as work flush the work item when closing
+ * or suspending. This is the substitute for those calls.
+ */
+void netif_flush_rx_mode_work(struct net_device *dev)
+{
+	/* Calling this function with RTNL held will result in a deadlock. */
+	if (WARN_ON(rtnl_is_locked()))
+		return;
+
+	/* Doing nothing is enough to "flush" work on a closed interface */
+	if (!netif_running(dev))
+		return;
+
+	flush_work(&dev->rx_mode_ctx->work);
+}
+EXPORT_SYMBOL(netif_flush_rx_mode_work);
+
 /*
  *	Upload unicast and multicast address lists to device and
  *	configure RX filtering. When the device doesn't support unicast
@@ -9631,8 +9885,6 @@ int netif_set_allmulti(struct net_device *dev, int inc, bool notify)
  */
 void __dev_set_rx_mode(struct net_device *dev)
 {
-	const struct net_device_ops *ops = dev->netdev_ops;
-
 	/* dev_open will call this function so the list will stay sane. */
 	if (!(dev->flags&IFF_UP))
 		return;
@@ -9653,8 +9905,7 @@ void __dev_set_rx_mode(struct net_device *dev)
 		}
 	}
 
-	if (ops->ndo_set_rx_mode)
-		ops->ndo_set_rx_mode(dev);
+	netif_schedule_rx_mode_work(dev);
 }
 
 void dev_set_rx_mode(struct net_device *dev)
@@ -11325,6 +11576,9 @@ int register_netdevice(struct net_device *dev)
 		}
 	}
 
+	if (dev->netdev_ops->ndo_write_rx_mode)
+		dev->needs_cleanup_work = true;
+
 	if (((dev->hw_features | dev->features) &
 	     NETIF_F_HW_VLAN_CTAG_FILTER) &&
 	    (!dev->netdev_ops->ndo_vlan_rx_add_vid ||
@@ -12068,6 +12322,7 @@ struct net_device *alloc_netdev_mqs(int sizeof_priv, const char *name,
 	dev->real_num_rx_queues = rxqs;
 	if (netif_alloc_rx_queues(dev))
 		goto free_all;
+
 	dev->ethtool = kzalloc(sizeof(*dev->ethtool), GFP_KERNEL_ACCOUNT);
 	if (!dev->ethtool)
 		goto free_all;
@@ -12151,6 +12406,7 @@ void free_netdev(struct net_device *dev)
 	kfree(dev->ethtool);
 	netif_free_tx_queues(dev);
 	netif_free_rx_queues(dev);
+	netif_free_cleanup_work(dev);
 
 	kfree(rcu_dereference_protected(dev->ingress_queue, 1));
 
-- 
2.47.3



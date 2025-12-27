Return-Path: <netdev+bounces-246146-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A8008CE0050
	for <lists+netdev@lfdr.de>; Sat, 27 Dec 2025 18:43:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AFCF8300BEEC
	for <lists+netdev@lfdr.de>; Sat, 27 Dec 2025 17:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 727A52550D5;
	Sat, 27 Dec 2025 17:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lywlCv7p"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6755D21FF3B
	for <netdev@vger.kernel.org>; Sat, 27 Dec 2025 17:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766857399; cv=none; b=qOMSqquigF+rwMCFV0Yg2XScFiCB0q1mUvF7bqxnM4ECWzzURGNPYQUt4ah8dML/R4q1iGfDB/QtMQ1i5yvOowAubqAZj9olFLxPZATLSwhCJJ8b8xhzatDCXrMsjRNYn37NxQKSwKSOszTJq7z5syXrEtHheIwxnOSy/rYI7Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766857399; c=relaxed/simple;
	bh=jW8lKr9jXGyfjKReSsdq6zbGzsBQ3q0nslPu+o9MoG0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mIJRrC2E7zsii11w+k7wxi81Dr1zQ9n/XNffGnmzTeya+k6JOr+qw5IPiQKiVtaKhXGhJ33KkSyScl5t9ZMeFmjltpGzgE6estS4y+W2muWET+FRvnQ7ogt5apJlIRBxuvKKl7lNEuih6At9iHKEUc6vuc41TCVNjIvHTHhjF7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lywlCv7p; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-34b75fba315so8953050a91.3
        for <netdev@vger.kernel.org>; Sat, 27 Dec 2025 09:43:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766857396; x=1767462196; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jLALgdMTI4IqYMOYKH3E2WgP+MBHIsn8TXx+tpe7PP4=;
        b=lywlCv7pJrOgTIeNrRRnBbZqVmI0maSOqAWIr0TMBJecRjDxsbx27Z9/olagQl622M
         aBBFTGPBcNC5h2gLpX80K3ORGynmTQrKooNiUFXWQR7CIfzgOAdIaosGNefWwFB4cbNl
         huJ2BtkwM9Z1A+/mF9AX6e9H9/BaemL6Vi1M3Q/Q4RZu0/fewus+1jzqGbP3OF1XWPYg
         YJ7KseeeZcWoEIJW/IeVatx6rSvUvR3f3GVxxeYfG9FI8a5VOxGhn2i59ssnxy52rwEJ
         cIN8mJmuS42wwjFO/G+msu516v07GvFMVYI0aSqZV3Idd+RMTjWiFrj3GWa+NfK8/9op
         yjVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766857396; x=1767462196;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jLALgdMTI4IqYMOYKH3E2WgP+MBHIsn8TXx+tpe7PP4=;
        b=YCcY/hR/oT8TFuax9OmLSp0cQQ4jk2uQY1an2pErHcEyNRQn+gtdAbmZ9+EX3i9gKF
         hOJ808jhEZ0haNwDK40ZPAoFH5/1RfWD1GYuI4vQjrgGAnXBeYudBFbfyfh5cf9n891+
         XLDo+WcF5bCrdzkhFPUH0mZpDdc/g7J/Aocse+G9eaY0T/Wmngw6/rhWrembFn7Yyndg
         DExlh+KDpJQXqz8vx7UfPg9CIB3kmMAhNECWsyC/u7o5QmwbnUjVKbDHNwUrHIvDcpup
         81mP8/c7cmvsG6aTG4mem+wsXsPD9yce3AlsFUVhvaA06/TpsIZoPnbkC1KZzu3KJonj
         o3uQ==
X-Gm-Message-State: AOJu0Yw2KZ3jl6E5QcoM3ubhOp/A8FG78OsAljv2865s96Lw/Iun01ho
	PBpw+pcA/PZv8ffaJIm9y46/KLaT1UVh/wR1ChoALLnDQKTjmxEpVvvs
X-Gm-Gg: AY/fxX50st6XI+K8tq8TTW9U0LTc/xfgQQxHXXCqKOnkSSUvwTpfvCcf+VfxSCn5NQd
	r4c0LkwesEgyg1oivGcFWuoedodfLk67eRlUrCmERxWhyVZ2uflJ1XyNMUN2MczxwsmKkBZQLLA
	8z+SZqhjJCYsBRQSh5I1p6Tbo+UrLExz8rozOjN3IEFdGQfUOtFbwo8ABnAxUNWtg/0S1NytWKe
	RTi/jzSBt/sjIDUBu2DeoCXGzaTGdn5Lps4czup5ShAc0RG8sq1nOZxYL0BejBYNk5F5ezTOonz
	rGbsdV3rWKouWwgATi6y4qDe3AI3CWuEFtK9hLX1ODMnQclz6lWbQqKtqiLhU9Kmoz+nlpnbVv/
	cAUN4EYBks4mO6aV5R9h6O7ZZbBYUWKdtVhw3vufAxYzog5gnO21bgmimnRyiSU09y1LA5XwbOL
	+BuzPuxm8wNrFjZWdY4cdNu2s/bVQq4TUTJ3UOIsS9v1n50t18wIXbKDlXIT/IOnFq
X-Google-Smtp-Source: AGHT+IGlaGEJm61GM4FE6DVLILa6/sk4cClHSu+fr18e/NOPitTbFPVRrSuRfsdMDIggsxiNUCzCkw==
X-Received: by 2002:a17:90b:17d0:b0:349:30b4:6367 with SMTP id 98e67ed59e1d1-34e921eaefemr22093521a91.30.1766857396376;
        Sat, 27 Dec 2025 09:43:16 -0800 (PST)
Received: from localhost.localdomain ([223.181.117.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34e9223ae29sm23274975a91.16.2025.12.27.09.43.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Dec 2025 09:43:15 -0800 (PST)
From: I Viswanath <viswanathiyyappan@gmail.com>
To: kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch,
	edumazet@google.com,
	xuanzhuo@linux.alibaba.com,
	mst@redhat.com,
	jasowang@redhat.com,
	eperezma@redhat.com
Cc: netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	I Viswanath <viswanathiyyappan@gmail.com>
Subject: [PATCH net-next v6 1/2] net: refactor set_rx_mode into snapshot and deferred I/O
Date: Sat, 27 Dec 2025 23:12:24 +0530
Message-ID: <20251227174225.699975-2-viswanathiyyappan@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251227174225.699975-1-viswanathiyyappan@gmail.com>
References: <20251227174225.699975-1-viswanathiyyappan@gmail.com>
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
 include/linux/netdevice.h | 113 +++++++++++++++-
 net/core/dev.c            | 270 +++++++++++++++++++++++++++++++++++++-
 2 files changed, 375 insertions(+), 8 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 5870a9e514a5..43f2904d5b39 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1062,6 +1062,45 @@ struct netdev_net_notifier {
 	struct notifier_block *nb;
 };
 
+struct netif_deferred_work_cleanup {
+	struct work_struct cleanup_work;
+	struct net_device *dev;
+};
+
+enum netif_rx_mode_cfg_flags {
+	NETIF_RX_MODE_CFG_ALLMULTI,
+	NETIF_RX_MODE_CFG_PROMISC,
+	NETIF_RX_MODE_CFG_VLAN
+};
+
+enum netif_rx_mode_ctrl_flags {
+	/* pending config state */
+	NETIF_RX_MODE_CFG_READY,
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
+	int	cfg_bits;
+};
+
+struct netif_rx_mode_work_ctx {
+	struct netif_rx_mode_config *pending;
+	struct netif_rx_mode_config *ready;
+	struct work_struct rx_mode_work;
+	struct net_device *dev;
+	int ctrl_bits;
+};
+
 /*
  * This structure defines the management hooks for network devices.
  * The following hooks can be defined; unless noted otherwise, they are
@@ -1114,9 +1153,14 @@ struct netdev_net_notifier {
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
@@ -1437,6 +1481,7 @@ struct net_device_ops {
 	void			(*ndo_change_rx_flags)(struct net_device *dev,
 						       int flags);
 	void			(*ndo_set_rx_mode)(struct net_device *dev);
+	void			(*ndo_write_rx_mode)(struct net_device *dev);
 	int			(*ndo_set_mac_address)(struct net_device *dev,
 						       void *addr);
 	int			(*ndo_validate_addr)(struct net_device *dev);
@@ -1939,7 +1984,7 @@ enum netdev_reg_state {
  *	@ingress_queue:		XXX: need comments on this one
  *	@nf_hooks_ingress:	netfilter hooks executed for ingress packets
  *	@broadcast:		hw bcast address
- *
+ *	@rx_mode_ctx:		Context required for rx_mode work
  *	@rx_cpu_rmap:	CPU reverse-mapping for RX completion interrupts,
  *			indexed by RX queue number. Assigned by driver.
  *			This must only be set if the ndo_rx_flow_steer
@@ -1971,6 +2016,9 @@ enum netdev_reg_state {
  *	@link_watch_list:	XXX: need comments on this one
  *
  *	@reg_state:		Register/unregister state machine
+ *	@needs_deferred_cleanup:Should dev_close schedule cleanup of
+ *				deferred work?
+ *	@deferred_work_cleanup:	Context required for cleanup of deferred work
  *	@dismantle:		Device is going to be freed
  *	@needs_free_netdev:	Should unregister perform free_netdev?
  *	@priv_destructor:	Called from unregister
@@ -2350,6 +2398,7 @@ struct net_device {
 #endif
 
 	unsigned char		broadcast[MAX_ADDR_LEN];
+	struct netif_rx_mode_work_ctx *rx_mode_ctx;
 #ifdef CONFIG_RFS_ACCEL
 	struct cpu_rmap		*rx_cpu_rmap;
 #endif
@@ -2387,6 +2436,10 @@ struct net_device {
 
 	u8 reg_state;
 
+	bool needs_deferred_cleanup;
+
+	struct netif_deferred_work_cleanup *deferred_work_cleanup;
+
 	bool dismantle;
 
 	/** @moving_ns: device is changing netns, protected by @lock */
@@ -3373,6 +3426,60 @@ int dev_loopback_xmit(struct net *net, struct sock *sk, struct sk_buff *newskb);
 u16 dev_pick_tx_zero(struct net_device *dev, struct sk_buff *skb,
 		     struct net_device *sb_dev);
 
+/* Helpers to be used in the set_rx_mode implementation */
+static inline void netif_rx_mode_set_cfg_bit(struct net_device *dev, int b,
+					     bool val)
+{
+	if (val)
+		dev->rx_mode_ctx->pending->cfg_bits |= BIT(b);
+	else
+		dev->rx_mode_ctx->pending->cfg_bits &= ~BIT(b);
+}
+
+static inline void netif_rx_mode_set_ctrl_bit(struct net_device *dev, int b,
+					      bool val)
+{
+	if (val)
+		dev->rx_mode_ctx->ctrl_bits |= BIT(b);
+	else
+		dev->rx_mode_ctx->ctrl_bits &= ~BIT(b);
+}
+
+/* Helper to be used in the write_rx_mode implementation */
+static inline int netif_rx_mode_get_cfg_bit(struct net_device *dev, int b)
+{
+	return !!(dev->rx_mode_ctx->ready->cfg_bits & BIT(b));
+}
+
+static inline int netif_rx_mode_get_ctrl_bit(struct net_device *dev, int b)
+{
+	return !!(dev->rx_mode_ctx->ctrl_bits & BIT(b));
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
+void netif_rx_mode_schedule_work(struct net_device *dev);
+
+void netif_rx_mode_flush_work(struct net_device *dev);
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
index 9094c0fb8c68..ee6367ef43ab 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -1587,6 +1587,211 @@ void netif_state_change(struct net_device *dev)
 	}
 }
 
+/* This function attempts to copy the current state of the
+ * net device into pending (reallocating if necessary). If it fails,
+ * pending is guaranteed to be unmodified.
+ */
+static int netif_rx_mode_alloc_and_fill_pending(struct net_device *dev)
+{
+	struct netif_rx_mode_config *pending = dev->rx_mode_ctx->pending;
+	bool skip_uc = false, skip_mc = false;
+	int uc_count = 0, mc_count = 0;
+	struct netdev_hw_addr *ha;
+	char *tmp;
+	int i;
+
+	skip_uc = netif_rx_mode_get_ctrl_bit(dev, NETIF_RX_MODE_UC_SKIP);
+	skip_mc = netif_rx_mode_get_ctrl_bit(dev, NETIF_RX_MODE_MC_SKIP);
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
+	netif_rx_mode_set_cfg_bit(dev, NETIF_RX_MODE_CFG_ALLMULTI,
+				  !!(dev->flags & IFF_ALLMULTI));
+
+	netif_rx_mode_set_cfg_bit(dev, NETIF_RX_MODE_CFG_PROMISC,
+				  !!(dev->flags & IFF_PROMISC));
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
+static void netif_rx_mode_prepare_pending(struct net_device *dev)
+{
+	lockdep_assert_held(&dev->addr_list_lock);
+	int rc;
+
+	rc = netif_rx_mode_alloc_and_fill_pending(dev);
+	if (rc)
+		return;
+
+	netif_rx_mode_set_ctrl_bit(dev, NETIF_RX_MODE_CFG_READY, true);
+}
+
+static void netif_rx_mode_write_rx_mode(struct work_struct *param)
+{
+	rtnl_lock();
+
+	struct netif_rx_mode_work_ctx *rx_mode_ctx = container_of(param,
+			struct netif_rx_mode_work_ctx, rx_mode_work);
+
+	struct net_device *dev = rx_mode_ctx->dev;
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
+	if (!netif_rx_mode_get_ctrl_bit(dev, NETIF_RX_MODE_CFG_READY)) {
+		netif_addr_unlock_bh(dev);
+		rtnl_unlock();
+		return;
+	}
+
+	swap(rx_mode_ctx->ready, rx_mode_ctx->pending);
+	netif_rx_mode_set_ctrl_bit(dev, NETIF_RX_MODE_CFG_READY, false);
+
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
+	INIT_WORK(&dev->rx_mode_ctx->rx_mode_work, netif_rx_mode_write_rx_mode);
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
+	cancel_work_sync(&dev->rx_mode_ctx->rx_mode_work);
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
+static void netif_deferred_work_cleanup_fn(struct work_struct *param)
+{
+	struct netif_deferred_work_cleanup *ctx;
+	struct net_device *dev;
+
+	ctx = container_of(param, struct netif_deferred_work_cleanup,
+			   cleanup_work);
+	dev = ctx->dev;
+
+	if (dev->netdev_ops->ndo_write_rx_mode)
+		netif_free_rx_mode_ctx(dev);
+}
+
+static int netif_alloc_deferred_work_cleanup(struct net_device *dev)
+{
+	dev->deferred_work_cleanup = kzalloc(sizeof(*dev->deferred_work_cleanup),
+					     GFP_KERNEL);
+	if (!dev->deferred_work_cleanup)
+		return -ENOMEM;
+
+	dev->deferred_work_cleanup->dev = dev;
+	INIT_WORK(&dev->deferred_work_cleanup->cleanup_work,
+		  netif_deferred_work_cleanup_fn);
+	return 0;
+}
+
+static void netif_free_deferred_work_cleanup(struct net_device *dev)
+{
+	if (!dev->deferred_work_cleanup)
+		return;
+
+	cancel_work_sync(&dev->deferred_work_cleanup->cleanup_work);
+
+	kfree(dev->deferred_work_cleanup);
+	dev->deferred_work_cleanup = NULL;
+}
+
 /**
  * __netdev_notify_peers - notify network peers about existence of @dev,
  * to be called when rtnl lock is already held.
@@ -1672,16 +1877,26 @@ static int __dev_open(struct net_device *dev, struct netlink_ext_ack *extack)
 	if (ret)
 		return ret;
 
+	if (dev->needs_deferred_cleanup) {
+		if (!dev->deferred_work_cleanup)
+			ret = netif_alloc_deferred_work_cleanup(dev);
+
+		cancel_work_sync(&dev->deferred_work_cleanup->cleanup_work);
+	}
+
 	set_bit(__LINK_STATE_START, &dev->state);
 
 	netdev_ops_assert_locked(dev);
 
-	if (ops->ndo_validate_addr)
+	if (!ret && ops->ndo_validate_addr)
 		ret = ops->ndo_validate_addr(dev);
 
 	if (!ret && ops->ndo_open)
 		ret = ops->ndo_open(dev);
 
+	if (!ret && ops->ndo_write_rx_mode)
+		ret = netif_alloc_rx_mode_ctx(dev);
+
 	netpoll_poll_enable(dev);
 
 	if (ret)
@@ -1755,6 +1970,9 @@ static void __dev_close_many(struct list_head *head)
 		if (ops->ndo_stop)
 			ops->ndo_stop(dev);
 
+		if (dev->needs_deferred_cleanup)
+			schedule_work(&dev->deferred_work_cleanup->cleanup_work);
+
 		netif_set_up(dev, false);
 		netpoll_poll_enable(dev);
 	}
@@ -9621,6 +9839,46 @@ int netif_set_allmulti(struct net_device *dev, int inc, bool notify)
 	return 0;
 }
 
+/* netif_rx_mode_schedule_work - Sets up the rx_config snapshot and
+ * schedules the deferred I/O.
+ */
+void netif_rx_mode_schedule_work(struct net_device *dev)
+{
+	const struct net_device_ops *ops = dev->netdev_ops;
+
+	if (ops->ndo_set_rx_mode)
+		ops->ndo_set_rx_mode(dev);
+
+	/* This part is only for drivers that implement ndo_write_rx_mode */
+	if (!ops->ndo_write_rx_mode)
+		return;
+
+	/* If rx_mode set is to be skipped, we don't schedule the work */
+	if (netif_rx_mode_get_ctrl_bit(dev, NETIF_RX_MODE_SET_SKIP))
+		return;
+
+	netif_rx_mode_prepare_pending(dev);
+	schedule_work(&dev->rx_mode_ctx->rx_mode_work);
+}
+EXPORT_SYMBOL(netif_rx_mode_schedule_work);
+
+/* Drivers that implement rx mode as work flush the work item when closing
+ * or suspending. This is the substitute for those calls.
+ */
+void netif_rx_mode_flush_work(struct net_device *dev)
+{
+	/* Calling this function with RTNL held will result in a deadlock. */
+	if (WARN_ON(rtnl_is_locked()))
+		return;
+
+	/* Doing nothing is enough to "flush" work on a closed interface */
+	if (!netif_running(dev))
+		return;
+
+	flush_work(&dev->rx_mode_ctx->rx_mode_work);
+}
+EXPORT_SYMBOL(netif_rx_mode_flush_work);
+
 /*
  *	Upload unicast and multicast address lists to device and
  *	configure RX filtering. When the device doesn't support unicast
@@ -9629,8 +9887,6 @@ int netif_set_allmulti(struct net_device *dev, int inc, bool notify)
  */
 void __dev_set_rx_mode(struct net_device *dev)
 {
-	const struct net_device_ops *ops = dev->netdev_ops;
-
 	/* dev_open will call this function so the list will stay sane. */
 	if (!(dev->flags&IFF_UP))
 		return;
@@ -9651,8 +9907,7 @@ void __dev_set_rx_mode(struct net_device *dev)
 		}
 	}
 
-	if (ops->ndo_set_rx_mode)
-		ops->ndo_set_rx_mode(dev);
+	netif_rx_mode_schedule_work(dev);
 }
 
 void dev_set_rx_mode(struct net_device *dev)
@@ -11323,6 +11578,9 @@ int register_netdevice(struct net_device *dev)
 		}
 	}
 
+	if (dev->netdev_ops->ndo_write_rx_mode)
+		dev->needs_deferred_cleanup = true;
+
 	if (((dev->hw_features | dev->features) &
 	     NETIF_F_HW_VLAN_CTAG_FILTER) &&
 	    (!dev->netdev_ops->ndo_vlan_rx_add_vid ||
@@ -12066,6 +12324,7 @@ struct net_device *alloc_netdev_mqs(int sizeof_priv, const char *name,
 	dev->real_num_rx_queues = rxqs;
 	if (netif_alloc_rx_queues(dev))
 		goto free_all;
+
 	dev->ethtool = kzalloc(sizeof(*dev->ethtool), GFP_KERNEL_ACCOUNT);
 	if (!dev->ethtool)
 		goto free_all;
@@ -12149,6 +12408,7 @@ void free_netdev(struct net_device *dev)
 	kfree(dev->ethtool);
 	netif_free_tx_queues(dev);
 	netif_free_rx_queues(dev);
+	netif_free_deferred_work_cleanup(dev);
 
 	kfree(rcu_dereference_protected(dev->ingress_queue, 1));
 
-- 
2.47.3



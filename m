Return-Path: <netdev+bounces-249135-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 803D1D14B69
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 19:18:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9073D3065E3F
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 18:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FE1738736C;
	Mon, 12 Jan 2026 18:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EMoC6MnT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C012314A99
	for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 18:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768241830; cv=none; b=bo1FzjVIrZLSQQzW70Cw/jNUuWEioglrz0evFcoQLpIupx8zvXC7NKbW6ITI2it/MQhPDGpQHF6ir4vRzV58i4NTF23/Xwbtq031o738pf9NFfkBL1+wVOP8eYIFOnznA3QdiA8mm9T7ep8TPgMIHsmIRNSwTt2TGrwsxaCP144=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768241830; c=relaxed/simple;
	bh=UC3Dr3WnbVBQ8+vdvDal4ad44MmHKu+Fxe8trmV3V4U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aRwpSQ6ua6iWN5OQxXZsGkG33ITIN1yRxT3havYojstpXe+jUvRCJ8XbIKMM7H2qB4zGberH884BMf8w9ir+P6Rj2QDi+JTR1OreaRmzknK9VI/SWKKJp0K7xuexJ0dADK5g7g/oaTf895cFb4alZCEjawbY0oCzIC3dWd9VJSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EMoC6MnT; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-34c27d14559so3829179a91.2
        for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 10:17:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768241828; x=1768846628; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zwd6dDu7lItaCK0ooIefkkW4WrxEZYfI/qcoCv+2eFY=;
        b=EMoC6MnTUYfPILER5qcJMy85dRA5j3T5vUOGrlrSEHkyZsQEqTGPv3yxwTN+uUif/3
         f5Fr4/1CnMLUL2Bc36CizgjA7w5ar3G928AP7lmPDsPxm7l3ZhZgvMuuOwc0s0Z9AftO
         lRgMYmJDzn7q977OoI0vWrwohDS+ih4Q4aBMbEVY3/I5VB/yVUnd3xjkQlBxSFc9aLJq
         Yj3hn/zmyhcgdaN2Q1HGTItKHlrw8OvWI45HZXPvfwwTFuBOgKT1wTL9fSistkWVNZNS
         +RxpmMvKCb40BnxlhSAhyGkty/KORJ0hr4WrnFQJu0Wo5WKB3LWyeyM8z/m6bnk6YmWW
         7w+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768241828; x=1768846628;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zwd6dDu7lItaCK0ooIefkkW4WrxEZYfI/qcoCv+2eFY=;
        b=tGHFooNHBHKCLHORAL5a+TQdoX7Dgz2IAbneGMFMNIlNfJ2VUBOFh8FrKI2xc4whPw
         mXDaXiDcU3KZGrQ49RzgrprWv/UaGIXdCVJSzwhX5fMRWqjb29lLsM9Od5Bb7GGrYHEV
         Fx4+Tsz90aJbRLcINB5Uw+6R1xVXRhw1y604A2Dz+rYt0mmlHCOtI5h7r16AVDcD+3VY
         Jftm6HdM27BSiECEyqAfVUhQ1F3Ay/8c96lWTxOf/T/i+c4s7zEtDOpjvbUtkUSTHT+S
         A9bRN+Ai0G4fkmH1xcKAPtK9kQ33k7Ok0nzL/AgUwjc6EJvCG43/VEfIBnygx1L5kSqi
         ECiQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3DvtaTM5J0q8Pb3liBjbhx6LvzFDOJzndiZuok9kA6aRS2du9Sva58XN7KEUVF5evFqY/oG4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyb3MdHRFnuOomdms57R5LyxdxSVz6AUIcow9cxMl/YhvQg28hp
	qov2qqbPKtV0gwtzH6+RbJIxM3E1LUEc9q2JWCin93aBMrRKg6OvZSrVgskEYw==
X-Gm-Gg: AY/fxX72boduhcMpm9bIiXPcydwMnKK4Qcck2wmIpQNUsG3UG+vQq+ki0gY90CfHMJ7
	cTaNvTmpkxX0/OxDRugolRy0zhWZiJmzikVyMDiVPl76NspNLDJwHHt6s5n0cUXoW7bWmuQYfJJ
	+vM4D6TAYWytXFz9sHPzON771RHlQIpsm8G6zcGROflPvn7W8qatyHAugMVLWWGPoMGPqFw1Rsl
	dBPNgsRfeeN7jaB0yUfTIDflNE8a43BXqfjBnEclQEdoQ1s8NHFBoK1aIN1jgCABBhJXEaFpAIM
	qXRZjFkt37HBVxKW3JVhKiAHOSrG+wRgVzxJdLb0B+c7k3cSmnW80qM/vdpeEUq7WaIjhThpXD+
	zLp/LRyUXNLHkGpORJDnCWne3P7gq2WEyE4Tuc0RYSyjhEFs2+bUOJN1QiwSywwE8vHJR3RDR3Q
	22d6dw41KTzn20w9MxomlFR1QQyMKJGEtYxYzBRkoHmXMZvdGWxpETf/Y5/mtOO8o5PQ==
X-Google-Smtp-Source: AGHT+IGgnN4Y18bqXv+/bNspsRG2tcSPdS/aRKgm0fNhJX4T/PueCj4eRHzEu4W1mJ9daiNFBFQHQg==
X-Received: by 2002:a17:90b:5830:b0:340:ec8f:82d8 with SMTP id 98e67ed59e1d1-34f68b6816bmr19325336a91.12.1768241827532;
        Mon, 12 Jan 2026 10:17:07 -0800 (PST)
Received: from localhost.localdomain ([122.183.54.120])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34f5f7c4141sm18165365a91.6.2026.01.12.10.17.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 10:17:06 -0800 (PST)
From: I Viswanath <viswanathiyyappan@gmail.com>
To: edumazet@google.com,
	horms@kernel.org,
	sdf@fomichev.me,
	kuba@kernel.org,
	andrew+netdev@lunn.ch,
	pabeni@redhat.com,
	jasowang@redhat.com,
	eperezma@redhat.com,
	mst@redhat.com,
	xuanzhuo@linux.alibaba.com,
	przemyslaw.kitszel@intel.com,
	anthony.l.nguyen@intel.com,
	ronak.doshi@broadcom.com,
	pcnet32@frontier.com
Cc: bcm-kernel-feedback-list@broadcom.com,
	intel-wired-lan@lists.osuosl.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	I Viswanath <viswanathiyyappan@gmail.com>
Subject: [PATCH net-next v8 1/6] net: refactor set_rx_mode into snapshot and deferred I/O
Date: Mon, 12 Jan 2026 23:46:21 +0530
Message-ID: <20260112181626.20117-2-viswanathiyyappan@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260112181626.20117-1-viswanathiyyappan@gmail.com>
References: <20260112181626.20117-1-viswanathiyyappan@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refactor set_rx_mode into two stages: a snapshot stage and the
actual I/O. When __dev_set_rx_mode() is called, the core takes a
snapshot of the current rx_mode config and commits it to
hardware later via a work item.

In this model, ndo_set_rx_mode() is responsible for customizing the
rx mode snapshot and deciding whether the work should happen or not,
while ndo_write_rx_mode() applies the snapshot to hardware.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: I Viswanath <viswanathiyyappan@gmail.com>
---
 include/linux/netdevice.h | 112 +++++++++++++++-
 net/core/dev.c            | 265 +++++++++++++++++++++++++++++++++++++-
 2 files changed, 370 insertions(+), 7 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index d99b0fbc1942..5f9268ac7b75 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1062,6 +1062,45 @@ struct netdev_net_notifier {
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
+	NETIF_RX_MODE_CFG_VLAN,
+	NETIF_RX_MODE_CFG_BROADCAST
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
+ *	@rx_mode_ctx:		rx_mode work context
  *	@rx_cpu_rmap:	CPU reverse-mapping for RX completion interrupts,
  *			indexed by RX queue number. Assigned by driver.
  *			This must only be set if the ndo_rx_flow_steer
@@ -1971,6 +2016,8 @@ enum netdev_reg_state {
  *	@link_watch_list:	XXX: need comments on this one
  *
  *	@reg_state:		Register/unregister state machine
+ *	@needs_cleanup_work:	Should dev_close schedule the cleanup work?
+ *	@cleanup_work:		Cleanup work context
  *	@dismantle:		Device is going to be freed
  *	@needs_free_netdev:	Should unregister perform free_netdev?
  *	@priv_destructor:	Called from unregister
@@ -2350,6 +2397,7 @@ struct net_device {
 #endif
 
 	unsigned char		broadcast[MAX_ADDR_LEN];
+	struct netif_rx_mode_ctx *rx_mode_ctx;
 #ifdef CONFIG_RFS_ACCEL
 	struct cpu_rmap		*rx_cpu_rmap;
 #endif
@@ -2387,6 +2435,10 @@ struct net_device {
 
 	u8 reg_state;
 
+	bool needs_cleanup_work;
+
+	struct netif_cleanup_work *cleanup_work;
+
 	bool dismantle;
 
 	/** @moving_ns: device is changing netns, protected by @lock */
@@ -3373,6 +3425,60 @@ int dev_loopback_xmit(struct net *net, struct sock *sk, struct sk_buff *newskb);
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
+static inline int netif_rx_mode_mc_count(struct net_device *dev)
+{
+	return dev->rx_mode_ctx->ready->mc_count;
+}
+
+static inline int netif_rx_mode_uc_count(struct net_device *dev)
+{
+	return dev->rx_mode_ctx->ready->uc_count;
+}
+
+void netif_schedule_rx_mode_work(struct net_device *dev);
+
+void netif_flush_rx_mode_work(struct net_device *dev);
+
+#define netif_rx_mode_for_each_uc_addr(ha_addr, dev, __i) \
+	for (__i = 0, ha_addr = (dev)->rx_mode_ctx->ready->uc_addrs; \
+	     __i < (dev)->rx_mode_ctx->ready->uc_count; \
+	     __i++, ha_addr += (dev)->addr_len)
+
+#define netif_rx_mode_for_each_mc_addr(ha_addr, dev, __i) \
+	for (__i = 0, ha_addr = (dev)->rx_mode_ctx->ready->mc_addrs; \
+	     __i < (dev)->rx_mode_ctx->ready->mc_count; \
+	     __i++, ha_addr += (dev)->addr_len)
+
 int __dev_queue_xmit(struct sk_buff *skb, struct net_device *sb_dev);
 int __dev_direct_xmit(struct sk_buff *skb, u16 queue_id);
 
diff --git a/net/core/dev.c b/net/core/dev.c
index c711da335510..072da874a958 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -1586,6 +1586,197 @@ void netif_state_change(struct net_device *dev)
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
+	int rc;
+
+	lockdep_assert_held(&dev->addr_list_lock);
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
+	flush_work(&dev->cleanup_work->work);
+	kfree(dev->cleanup_work);
+	dev->cleanup_work = NULL;
+}
+
 /**
  * __netdev_notify_peers - notify network peers about existence of @dev,
  * to be called when rtnl lock is already held.
@@ -1678,6 +1869,16 @@ static int __dev_open(struct net_device *dev, struct netlink_ext_ack *extack)
 	if (ops->ndo_validate_addr)
 		ret = ops->ndo_validate_addr(dev);
 
+	if (!ret && dev->needs_cleanup_work) {
+		if (!dev->cleanup_work)
+			ret = netif_alloc_cleanup_work(dev);
+		else
+			flush_work(&dev->cleanup_work->work);
+	}
+
+	if (!ret && ops->ndo_write_rx_mode)
+		ret = netif_alloc_rx_mode_ctx(dev);
+
 	if (!ret && ops->ndo_open)
 		ret = ops->ndo_open(dev);
 
@@ -1754,6 +1955,9 @@ static void __dev_close_many(struct list_head *head)
 		if (ops->ndo_stop)
 			ops->ndo_stop(dev);
 
+		if (dev->needs_cleanup_work)
+			schedule_work(&dev->cleanup_work->work);
+
 		netif_set_up(dev, false);
 		netpoll_poll_enable(dev);
 	}
@@ -9622,6 +9826,57 @@ int netif_set_allmulti(struct net_device *dev, int inc, bool notify)
 	return 0;
 }
 
+/* netif_schedule_rx_mode_work - Sets up the rx_config snapshot and
+ * schedules the deferred I/O.
+ */
+static void __netif_schedule_rx_mode_work(struct net_device *dev)
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
+
+void netif_schedule_rx_mode_work(struct net_device *dev)
+{
+	if (WARN_ON(!netif_running(dev)))
+		return;
+
+	netif_addr_lock_bh(dev);
+	__netif_schedule_rx_mode_work(dev);
+	netif_addr_unlock_bh(dev);
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
@@ -9630,8 +9885,6 @@ int netif_set_allmulti(struct net_device *dev, int inc, bool notify)
  */
 void __dev_set_rx_mode(struct net_device *dev)
 {
-	const struct net_device_ops *ops = dev->netdev_ops;
-
 	/* dev_open will call this function so the list will stay sane. */
 	if (!(dev->flags&IFF_UP))
 		return;
@@ -9652,8 +9905,7 @@ void __dev_set_rx_mode(struct net_device *dev)
 		}
 	}
 
-	if (ops->ndo_set_rx_mode)
-		ops->ndo_set_rx_mode(dev);
+	__netif_schedule_rx_mode_work(dev);
 }
 
 void dev_set_rx_mode(struct net_device *dev)
@@ -11324,6 +11576,9 @@ int register_netdevice(struct net_device *dev)
 		}
 	}
 
+	if (dev->netdev_ops->ndo_write_rx_mode)
+		dev->needs_cleanup_work = true;
+
 	if (((dev->hw_features | dev->features) &
 	     NETIF_F_HW_VLAN_CTAG_FILTER) &&
 	    (!dev->netdev_ops->ndo_vlan_rx_add_vid ||
@@ -12067,6 +12322,7 @@ struct net_device *alloc_netdev_mqs(int sizeof_priv, const char *name,
 	dev->real_num_rx_queues = rxqs;
 	if (netif_alloc_rx_queues(dev))
 		goto free_all;
+
 	dev->ethtool = kzalloc(sizeof(*dev->ethtool), GFP_KERNEL_ACCOUNT);
 	if (!dev->ethtool)
 		goto free_all;
@@ -12150,6 +12406,7 @@ void free_netdev(struct net_device *dev)
 	kfree(dev->ethtool);
 	netif_free_tx_queues(dev);
 	netif_free_rx_queues(dev);
+	netif_free_cleanup_work(dev);
 
 	kfree(rcu_dereference_protected(dev->ingress_queue, 1));
 
-- 
2.47.3



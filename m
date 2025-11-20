Return-Path: <netdev+bounces-240410-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 389C0C74824
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 15:18:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 567512AD21
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 14:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 555F534844B;
	Thu, 20 Nov 2025 14:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ePvArZh8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714CE33C521
	for <netdev@vger.kernel.org>; Thu, 20 Nov 2025 14:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763648162; cv=none; b=kYju+ESWNtKb0MGgog0wQk4L9wzA8y+oZWO+5p6uybeK4UiuaG50Ro3XtCEVpHJcB8MdxlF2rVoHPFPWLlNcn+SoVkhpACL7q2Zaq85KVaM4TwHvw806TOI22X0AxIOaEIw1ZF1SzGKCno2WfUABRV1c4s5RAzQtJxlHIA74To4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763648162; c=relaxed/simple;
	bh=fdofOYSx30kxze7ZMeejuTjOfFbcUuyiRQtQxtHJmHM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=M/kbV4cYmMboJSxdf1DbK5GFZPvMApUEC5uMlRkKpCKyEJNaZk3KM0lZixy0zHuGPmoGVz+V/aAAndcBIOLR0XH/wmZbFRBqFrBjuM9HgQVLsvjPQoXZtDNH9lrgFTfq4cyEpf6RD7ELk6IcWIY/1QEx+u8FjzTUqoexFU3yS+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ePvArZh8; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-29812589890so11737605ad.3
        for <netdev@vger.kernel.org>; Thu, 20 Nov 2025 06:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763648160; x=1764252960; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ajidgd+5FB7avT3KG2su9bYCh9pzkFLcEde9nhVLLg=;
        b=ePvArZh8y4kpKA64qd/fxDjJrOcLJ2weDiauWkozubsZKDuPVxbD3KaA9bMfL6TZw2
         eqm1ixgFIkqc7kIZ6TTIc5hoWaWbNiLii084u2oXkiPs6z4Mx6bfxJLqFgdUe/TitZjr
         wB+W8sWEQ8wjMfQ7NpJeFlSgFYUsuJkjWXoJAJv02uD+hwmebB6AwUF9L2Vgaf7d122T
         hnld50CJU4tQY8jJ7r0VfR2b5n/UTQKOMmhZKsNbnnGiu5y7wsaKAGibO+4vZFgVr3Cs
         tTsG0783kxBtcQvmHC69eaJpJFnLF3sIXWdj0u223RDvRcCq4OgGeKQKdogN6iooXs+p
         NzCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763648160; x=1764252960;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3ajidgd+5FB7avT3KG2su9bYCh9pzkFLcEde9nhVLLg=;
        b=LffVGe+EX36/QOMfv4jgR0eBMLeOF7bwYVPHfaThK7Nkw3hxqaYpuzh7YUMMLQkkea
         cbqwHJxlUCPOAOi5DNMBLIh19HLagPdPsg99VDZ8bNklcHfN/UAnCUCI/sEUL6HgVWKP
         JVRAds+J6klhE2+O0s4OsI+qMGRqDftgCNJFVBK8IBhNzeyW2fR4yhhM6VEUZ4RWAazr
         aJ6AUgbcVD4yBxZIdNW+uSCUF1CuaZzxUEsCV/iW0LJzWmVvU3ILq6dK3jh0yrb8qU3J
         FvhB53Vblk/pIz0O2o2wPXAnGxVRA3AXp446uuYTpGtMCiMHvEp4WbHO19fGDs7vRQJG
         P8Zg==
X-Forwarded-Encrypted: i=1; AJvYcCXqnkmGlownVisCwJQHkiKWQa3pxkRRonqo2qdpBCIrUVOrTzfBa4/amxigXm1waBZUC3AFXLk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsrjvOIcnuXSi1t7zudfnH9RHIedkBf1NPTeMmuSu2B+mAKtt+
	hetCvk3EkroDhV6rv8VGjpEwtNrT1glGZWh2mLLt/IMfkGNfm/xoZ83x
X-Gm-Gg: ASbGncvncuT/ZJoIeuVEVG7dhderUg6kPvCOBj8Qcik3Zob5dhdP2WEpPIXLO9P+6bG
	xzHnoVR2AVVADEouYGW3/NYHb0F8sRezeCi/UiE6tp/jP3VZupve+G2X5Zxh5P9e4K6ojPu/lyf
	c1ehHpIZNpLjJA9lOOUFVrNW1x5Xxl4SiXRrMAH0JLT62lDG448aCn384V9PhOpDIvR/LbLIMRX
	fB/UrYOpoFtZovxirOLHZuSeGXOjv0geep5MQdAR+yumGrDdkqb4v63eQ2rEt1tkm0RMKtyw2x7
	kA43HjkPwEGZvmnXjpEbJRLIi/NHNk0gPPgBKn0WLcw4QkJuZy9cXooJlwKj/jXSvynSuMxzc5w
	eNAS5rkZKQWawZCsR1xHQTmJh3pAFrpenULucvgHf6qgB12bDmZ+Sn1cr7v5ZMGAPfu3ZAG5xbt
	Bq73FRzNwmfBu5vdZlaNqVl2oaEFTLp2VrF3ZtObT2yg==
X-Google-Smtp-Source: AGHT+IHmQT0EhWZieWnM8D+8CZXX5h86PIdEOLv9K/NZZDLWTZWGHTQD+Xa/os8v0JbueFnnTUbEOA==
X-Received: by 2002:a17:903:28e:b0:295:9d7f:9296 with SMTP id d9443c01a7336-29b5ec7bad8mr31892945ad.45.1763648159251;
        Thu, 20 Nov 2025 06:15:59 -0800 (PST)
Received: from COB-LTR7HP24-497.. ([223.185.131.209])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b138bcbsm28442915ad.29.2025.11.20.06.15.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 06:15:58 -0800 (PST)
From: I Viswanath <viswanathiyyappan@gmail.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	sdf@fomichev.me,
	kuniyu@google.com,
	skhawaja@google.com,
	aleksander.lobakin@intel.com,
	mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com
Cc: virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	I Viswanath <viswanathiyyappan@gmail.com>
Subject: [PATCH net-next v5 1/2] net: refactor set_rx_mode into snapshot and deferred I/O
Date: Thu, 20 Nov 2025 19:43:53 +0530
Message-Id: <20251120141354.355059-2-viswanathiyyappan@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251120141354.355059-1-viswanathiyyappan@gmail.com>
References: <20251120141354.355059-1-viswanathiyyappan@gmail.com>
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

Signed-off-by: I Viswanath <viswanathiyyappan@gmail.com>
Suggested-by: Jakub Kicinski <kuba@kernel.org>
---
 include/linux/netdevice.h | 104 ++++++++++++++++++-
 net/core/dev.c            | 208 +++++++++++++++++++++++++++++++++++++-
 2 files changed, 305 insertions(+), 7 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index e808071dbb7d..e819426bb7cb 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1049,6 +1049,40 @@ struct netdev_net_notifier {
 	struct notifier_block *nb;
 };
 
+enum netif_rx_mode_flags {
+	/* enable flags */
+	NETIF_RX_MODE_ALLMULTI_EN,
+	NETIF_RX_MODE_PROM_EN,
+	NETIF_RX_MODE_VLAN_EN,
+
+	/* control flags */
+	/* pending config state */
+	NETIF_RX_MODE_CFG_READY,
+
+	/* if set, rx_mode config work will not be executed */
+	NETIF_RX_MODE_SET_DIS,
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
+	int	ctrl_flags;
+	void	*priv_ptr;
+};
+
+struct netif_rx_mode_ctx {
+	struct work_struct		rx_mode_work;
+	struct net_device		*dev;
+	struct netif_rx_mode_config	*ready;
+	struct netif_rx_mode_config	*pending;
+};
+
 /*
  * This structure defines the management hooks for network devices.
  * The following hooks can be defined; unless noted otherwise, they are
@@ -1101,9 +1135,14 @@ struct netdev_net_notifier {
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
@@ -1424,6 +1463,7 @@ struct net_device_ops {
 	void			(*ndo_change_rx_flags)(struct net_device *dev,
 						       int flags);
 	void			(*ndo_set_rx_mode)(struct net_device *dev);
+	void			(*ndo_write_rx_mode)(struct net_device *dev);
 	int			(*ndo_set_mac_address)(struct net_device *dev,
 						       void *addr);
 	int			(*ndo_validate_addr)(struct net_device *dev);
@@ -1926,7 +1966,7 @@ enum netdev_reg_state {
  *	@ingress_queue:		XXX: need comments on this one
  *	@nf_hooks_ingress:	netfilter hooks executed for ingress packets
  *	@broadcast:		hw bcast address
- *
+ *	@rx_mode_ctx:		context required for rx_mode config work
  *	@rx_cpu_rmap:	CPU reverse-mapping for RX completion interrupts,
  *			indexed by RX queue number. Assigned by driver.
  *			This must only be set if the ndo_rx_flow_steer
@@ -2337,6 +2377,7 @@ struct net_device {
 #endif
 
 	unsigned char		broadcast[MAX_ADDR_LEN];
+	struct netif_rx_mode_ctx *rx_mode_ctx;
 #ifdef CONFIG_RFS_ACCEL
 	struct cpu_rmap		*rx_cpu_rmap;
 #endif
@@ -3360,6 +3401,63 @@ int dev_loopback_xmit(struct net *net, struct sock *sk, struct sk_buff *newskb);
 u16 dev_pick_tx_zero(struct net_device *dev, struct sk_buff *skb,
 		     struct net_device *sb_dev);
 
+void netif_rx_mode_schedule_work(struct net_device *dev, bool flush);
+
+/* Drivers that implement rx mode as work flush the work item when closing
+ * or suspending. This is the substitute for those calls.
+ */
+static inline void netif_rx_mode_flush_work(struct net_device *dev)
+{
+	flush_work(&dev->rx_mode_ctx->rx_mode_work);
+}
+
+/* Helpers to be used in the set_rx_mode implementation */
+static inline void netif_rx_mode_set_bit(struct net_device *dev, int b,
+					 bool val)
+{
+	if (val)
+		dev->rx_mode_ctx->pending->ctrl_flags |= BIT(b);
+	else
+		dev->rx_mode_ctx->pending->ctrl_flags &= ~BIT(b);
+}
+
+static inline void netif_rx_mode_set_priv_ptr(struct net_device *dev,
+					      void *priv)
+{
+	dev->rx_mode_ctx->pending->priv_ptr = priv;
+}
+
+/* Helpers to be used in the write_rx_mode implementation */
+static inline bool netif_rx_mode_get_bit(struct net_device *dev, int b)
+{
+	return !!(dev->rx_mode_ctx->ready->ctrl_flags & BIT(b));
+}
+
+static inline void *netif_rx_mode_get_priv_ptr(struct net_device *dev)
+{
+	return dev->rx_mode_ctx->ready->priv_ptr;
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
+#define netif_rx_mode_for_each_uc_addr(dev, ha_addr, idx) \
+	for (ha_addr = (dev)->rx_mode_ctx->ready->uc_addrs, idx = 0; \
+		idx < (dev)->rx_mode_ctx->ready->uc_count; \
+		ha_addr += (dev)->addr_len, idx++)
+
+#define netif_rx_mode_for_each_mc_addr(dev, ha_addr, idx) \
+	for (ha_addr = (dev)->rx_mode_ctx->ready->mc_addrs, idx = 0; \
+		idx < (dev)->rx_mode_ctx->ready->mc_count; \
+		ha_addr += (dev)->addr_len, idx++)
+
 int __dev_queue_xmit(struct sk_buff *skb, struct net_device *sb_dev);
 int __dev_direct_xmit(struct sk_buff *skb, u16 queue_id);
 
diff --git a/net/core/dev.c b/net/core/dev.c
index 69515edd17bc..2be3ff8512b1 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -1645,6 +1645,160 @@ static int napi_kthread_create(struct napi_struct *n)
 	return err;
 }
 
+/* The existence of pending/ready config is an implementation detail. The
+ * caller shouldn't be aware of them. This is a bit hacky. We read
+ * bits from pending because control bits need to be read before pending
+ * is prepared.
+ */
+static bool __netif_rx_mode_pending_get_bit(struct net_device *dev, int b)
+{
+	return !!(dev->rx_mode_ctx->pending->ctrl_flags & BIT(b));
+}
+
+/* This function attempts to copy the current state of the
+ * net device into pending (reallocating if necessary). If it fails,
+ * pending is guaranteed to be unmodified.
+ */
+static int netif_rx_mode_alloc_and_fill_pending(struct net_device *dev)
+{
+	struct netif_rx_mode_config *pending = dev->rx_mode_ctx->pending;
+	int uc_count = 0, mc_count = 0;
+	struct netdev_hw_addr *ha;
+	char *tmp;
+	int i;
+
+	/* The allocations need to be atomic since this will be called under
+	 * netif_addr_lock_bh()
+	 */
+	if (!__netif_rx_mode_pending_get_bit(dev, NETIF_RX_MODE_UC_SKIP)) {
+		uc_count = netdev_uc_count(dev);
+		tmp = krealloc(pending->uc_addrs,
+			       uc_count * dev->addr_len,
+			       GFP_ATOMIC);
+		if (!tmp)
+			return -ENOMEM;
+		pending->uc_addrs = tmp;
+	}
+
+	if (!__netif_rx_mode_pending_get_bit(dev, NETIF_RX_MODE_MC_SKIP)) {
+		mc_count = netdev_mc_count(dev);
+		tmp = krealloc(pending->mc_addrs,
+			       mc_count * dev->addr_len,
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
+	netif_rx_mode_set_bit(dev, NETIF_RX_MODE_ALLMULTI_EN,
+			      !!(dev->flags & IFF_ALLMULTI));
+
+	netif_rx_mode_set_bit(dev, NETIF_RX_MODE_PROM_EN,
+			      !!(dev->flags & IFF_PROMISC));
+
+	i = 0;
+	if (!__netif_rx_mode_pending_get_bit(dev, NETIF_RX_MODE_UC_SKIP)) {
+		pending->uc_count = uc_count;
+		netdev_for_each_uc_addr(ha, dev)
+			memcpy(pending->uc_addrs + (i++) * dev->addr_len,
+			       ha->addr,
+			       dev->addr_len);
+	}
+
+	i = 0;
+	if (!__netif_rx_mode_pending_get_bit(dev, NETIF_RX_MODE_MC_SKIP)) {
+		pending->mc_count = mc_count;
+		netdev_for_each_mc_addr(ha, dev)
+			memcpy(pending->mc_addrs + (i++) * dev->addr_len,
+			       ha->addr,
+			       dev->addr_len);
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
+	netif_rx_mode_set_bit(dev, NETIF_RX_MODE_CFG_READY, true);
+}
+
+static void netif_rx_mode_write_active(struct work_struct *param)
+{
+	struct netif_rx_mode_ctx *rx_mode_ctx = container_of(param,
+			struct netif_rx_mode_ctx, rx_mode_work);
+
+	struct net_device *dev = rx_mode_ctx->dev;
+
+	/* Paranoia. */
+	WARN_ON(!dev->netdev_ops->ndo_write_rx_mode);
+
+	/* We could introduce a new lock for this but reusing the addr
+	 * lock works well enough
+	 */
+	netif_addr_lock_bh(dev);
+
+	/* There's no point continuing if the pending config is not ready */
+	if (!__netif_rx_mode_pending_get_bit(dev, NETIF_RX_MODE_CFG_READY)) {
+		netif_addr_unlock_bh(dev);
+		return;
+	}
+
+	/* We use the prepared pending config as the new ready config and
+	 * reuse old ready config's memory for the next pending config
+	 */
+	swap(rx_mode_ctx->ready, rx_mode_ctx->pending);
+	netif_rx_mode_set_bit(dev, NETIF_RX_MODE_CFG_READY, false);
+
+	netif_addr_unlock_bh(dev);
+
+	rtnl_lock();
+	dev->netdev_ops->ndo_write_rx_mode(dev);
+	rtnl_unlock();
+}
+
+static int alloc_rx_mode_ctx(struct net_device *dev)
+{
+	dev->rx_mode_ctx = kzalloc(sizeof(*dev->rx_mode_ctx), GFP_KERNEL);
+
+	if (!dev->rx_mode_ctx)
+		goto fail;
+
+	dev->rx_mode_ctx->ready = kzalloc(sizeof(*dev->rx_mode_ctx->ready),
+					  GFP_KERNEL);
+
+	if (!dev->rx_mode_ctx->ready)
+		goto fail_ready;
+
+	dev->rx_mode_ctx->pending = kzalloc(sizeof(*dev->rx_mode_ctx->pending),
+					    GFP_KERNEL);
+
+	if (!dev->rx_mode_ctx->pending)
+		goto fail_pending;
+
+	INIT_WORK(&dev->rx_mode_ctx->rx_mode_work, netif_rx_mode_write_active);
+	dev->rx_mode_ctx->dev = dev;
+
+	return 0;
+
+fail_pending:
+	kfree(dev->rx_mode_ctx->ready);
+fail_ready:
+	kfree(dev->rx_mode_ctx);
+fail:
+	return -ENOMEM;
+}
+
 static int __dev_open(struct net_device *dev, struct netlink_ext_ack *extack)
 {
 	const struct net_device_ops *ops = dev->netdev_ops;
@@ -1679,6 +1833,9 @@ static int __dev_open(struct net_device *dev, struct netlink_ext_ack *extack)
 	if (ops->ndo_validate_addr)
 		ret = ops->ndo_validate_addr(dev);
 
+	if (!ret && ops->ndo_write_rx_mode)
+		ret = alloc_rx_mode_ctx(dev);
+
 	if (!ret && ops->ndo_open)
 		ret = ops->ndo_open(dev);
 
@@ -1713,6 +1870,22 @@ int netif_open(struct net_device *dev, struct netlink_ext_ack *extack)
 	return ret;
 }
 
+static void cleanup_rx_mode_ctx(struct net_device *dev)
+{
+	/* cancel and wait for execution to complete */
+	cancel_work_sync(&dev->rx_mode_ctx->rx_mode_work);
+
+	kfree(dev->rx_mode_ctx->pending->uc_addrs);
+	kfree(dev->rx_mode_ctx->pending->mc_addrs);
+	kfree(dev->rx_mode_ctx->pending);
+
+	kfree(dev->rx_mode_ctx->ready->uc_addrs);
+	kfree(dev->rx_mode_ctx->ready->mc_addrs);
+	kfree(dev->rx_mode_ctx->ready);
+
+	kfree(dev->rx_mode_ctx);
+}
+
 static void __dev_close_many(struct list_head *head)
 {
 	struct net_device *dev;
@@ -1755,6 +1928,9 @@ static void __dev_close_many(struct list_head *head)
 		if (ops->ndo_stop)
 			ops->ndo_stop(dev);
 
+		if (ops->ndo_write_rx_mode)
+			cleanup_rx_mode_ctx(dev);
+
 		netif_set_up(dev, false);
 		netpoll_poll_enable(dev);
 	}
@@ -9613,6 +9789,33 @@ int netif_set_allmulti(struct net_device *dev, int inc, bool notify)
 	return 0;
 }
 
+/* netif_rx_mode_schedule_work - Sets up the rx_config snapshot and
+ * schedules the deferred I/O. If it's necessary to wait for completion
+ * of I/O, set flush to true.
+ */
+void netif_rx_mode_schedule_work(struct net_device *dev, bool flush)
+{
+	const struct net_device_ops *ops = dev->netdev_ops;
+
+	if (ops->ndo_set_rx_mode)
+		ops->ndo_set_rx_mode(dev);
+
+	/* Return early if ndo_write_rx_mode is not implemented */
+	if (!ops->ndo_write_rx_mode)
+		return;
+
+	/* If rx_mode config is disabled, we don't schedule the work */
+	if (__netif_rx_mode_pending_get_bit(dev, NETIF_RX_MODE_SET_DIS))
+		return;
+
+	netif_rx_mode_prepare_pending(dev);
+
+	schedule_work(&dev->rx_mode_ctx->rx_mode_work);
+	if (flush)
+		flush_work(&dev->rx_mode_ctx->rx_mode_work);
+}
+EXPORT_SYMBOL(netif_rx_mode_schedule_work);
+
 /*
  *	Upload unicast and multicast address lists to device and
  *	configure RX filtering. When the device doesn't support unicast
@@ -9621,8 +9824,6 @@ int netif_set_allmulti(struct net_device *dev, int inc, bool notify)
  */
 void __dev_set_rx_mode(struct net_device *dev)
 {
-	const struct net_device_ops *ops = dev->netdev_ops;
-
 	/* dev_open will call this function so the list will stay sane. */
 	if (!(dev->flags&IFF_UP))
 		return;
@@ -9643,8 +9844,7 @@ void __dev_set_rx_mode(struct net_device *dev)
 		}
 	}
 
-	if (ops->ndo_set_rx_mode)
-		ops->ndo_set_rx_mode(dev);
+	netif_rx_mode_schedule_work(dev, false);
 }
 
 void dev_set_rx_mode(struct net_device *dev)
-- 
2.34.1



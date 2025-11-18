Return-Path: <netdev+bounces-239637-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 031FEC6AB28
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 17:44:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 76BF42C1B2
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 16:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 017B53570AB;
	Tue, 18 Nov 2025 16:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aakLBA+7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189E2284898
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 16:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763484247; cv=none; b=VARmKRcZJ5FaD4NyyKo1ol6r32el+XMag70/aqHcPwpGHwfbcO7sd4D2X5Li/idw6Og215Tr7o7FrBQ6r8u5PXfVxi6p6NZOUY4RCsJOP8bqiucPaqkwdsFjh/iVgIZ5W5uYESbM6kQcqQUss46+qf70EIC9kL3DeSdQaKEDFF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763484247; c=relaxed/simple;
	bh=TftfHpNi/QdyqcA8ErgXvxkQdDLaQg6QyQuXn5bm2Bo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eiqmlU2q6EfvvvIzlKqs5g+I+ibsmoh1vuFA5Y8/hKfs28CEOVa8iyki5QXIkePTrYo8Q2ElhIS3yC1Sf2sBhJ/uhV7bYjYmgGo+11hOvPZbK1upe0GfRTfPrF2byyIVVc7PEw8xxZz7nHCJXk8evb7SgebbvRAeyRWTMx56NFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aakLBA+7; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-34372216275so6260675a91.2
        for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 08:44:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763484243; x=1764089043; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z8JKFjb15/5rHbpwr0QF/sf0oilaOjgc/gps4D1hyeI=;
        b=aakLBA+7+gnHjlTQt2xoEumqtuqlU9Q2W8t70P4xCxRdQLpcL42fD/SUx3lCkvNjHt
         NKdHp3T0qBVq4YiAJ7DKV3dV4lIf3TTeeF7NtyFhU83KrJx+oj11XdPGZNM1za9VI6/A
         Xoyg0k5aScckNj+EElaWfEbPKrNW/thJHgYTkOD5eFq6qFygWaG9V3hi9lh4Rz/m9sHc
         UgNvxrB+iTQN6n4rAp4fxnol8hiN6DGXNKgGf30lqthWNAE5MbNQdB78auuynhw6wY6/
         RcWrjsaFcyMTSDYDQRkdEYXHNBEo+gfgIXU0vFVhqBCkzjlViLjfVAbZsqTMxc6/LSpS
         bSHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763484243; x=1764089043;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Z8JKFjb15/5rHbpwr0QF/sf0oilaOjgc/gps4D1hyeI=;
        b=wY3atvBERncyRIG3nfnrsM20Gd6dNXkjlO9Tzzu4RGQOnpo9zTV2xkFZ0Q4seLnfrX
         vuowBmpHu+zw1DaAORfBCSRLDEwso3GFjO2UeCW3a3IOXH0fjnNT97DiWftLtyUEOxNx
         2okq2Nk7HTqRTyLDK6NyMuhgQncZJwTu/xepD+Dx+9A/jiNDvGXWvZWdcj2eqKCVJCBY
         2V39WEo+qGlRuYuiNo48hIxD3sae477WvDTZmNr4+joXiGtpaNYiqwu1Y57t3377kDTt
         AZv34o0muSnnhQtQ3+pC68COwer+PiB15ilHW0K4vb9gYsd2ElNLwDUFQEjEgcZHMo3N
         WEDw==
X-Forwarded-Encrypted: i=1; AJvYcCVJqUZfCXzIAOH7XlwIY28kmCHWF0h4e1aaPo2w95h/yscYEGBLUqPd5NTWJcMv1afxiYq/GTo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzWI/qW9VecMuUq0Wo8OqYyNQcBiLg6dAmsuP/psHwOkiaGw/q
	IV3Z05Tev2QbmUq5mqLIEcTluzyMFzzOa+oEjUvXyrT3K5gY1MCr+42K
X-Gm-Gg: ASbGncs6fA6oN9GrVOpwQldy/lEOvfwI+tvtRF2n/ZMYfz9lNnppzUEkhCICms9tXSh
	gKVMwwPpo6WA2inwMI49KuhctSSBx0oUq//acTCdYyR/upiHHCm9UpU7uANKu9Er8DpUBo6Ls9p
	5XtP7klrwNN41CC5mblz89Jy3AURzUJ/AAo35y/C7OC+6b4CUxaCpbTq7dIT3UySHpgdvRFulTN
	TBiPNzR9IEQ/ldt864MWfiTT8NB7HeSvOEvDiaOZXKlQSU6KD0PuCzJhsntgVkK9PUGNxJemPan
	p5ObANrCHDPUD4HTDJtvogHPEJX+m/kAniAkbRwAkL1eLdlUpZPo6HvnvAlDdhpqsOipj2qY26h
	lhXqtTn75aGiAQTcFoXHfMKxCrK+l8NeLEgRkomPoRuGdXGt2SEW6R9Wl8o1TXo4Z0k3XZ3dse7
	lzDfhK72x/9+dBmder7rWEB00b6o+qt9QeZTo3XW/L4Rv8DJrjAryhlA==
X-Google-Smtp-Source: AGHT+IGL9Foatx+ZYdSEZJJSaSWdVw6rYXFXFFiFBvbjyKpKOfcJ4DrZmTflQmrij88ak5Eh2Kv75g==
X-Received: by 2002:a17:90b:586d:b0:340:e4fb:130b with SMTP id 98e67ed59e1d1-343f9eb6167mr17497274a91.14.1763484243121;
        Tue, 18 Nov 2025 08:44:03 -0800 (PST)
Received: from COB-LTR7HP24-497.domain.name ([223.185.135.16])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3456513f162sm13544843a91.8.2025.11.18.08.43.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 08:44:02 -0800 (PST)
From: I Viswanath <viswanathiyyappan@gmail.com>
To: kuba@kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	sdf@fomichev.me,
	kuniyu@google.com,
	skhawaja@google.com,
	aleksander.lobakin@intel.com
Cc: virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	I Viswanath <viswanathiyyappan@gmail.com>
Subject: [RFT net-next v4] net: refactor set_rx_mode into snapshot and deferred I/O
Date: Tue, 18 Nov 2025 22:13:32 +0530
Message-Id: <20251118164333.24842-2-viswanathiyyappan@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251118164333.24842-1-viswanathiyyappan@gmail.com>
References: <20251118164333.24842-1-viswanathiyyappan@gmail.com>
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
index e808071dbb7d..848f341a677e 100644
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
+	return dev->rx_mode_ctx->ready->ctrl_flags & BIT(b);
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
+	for (ha_addr = dev->rx_mode_ctx->ready->uc_addrs, idx = 0; \
+		idx < dev->rx_mode_ctx->ready->uc_count; \
+		ha_addr += dev->addr_len, idx++)
+
+#define netif_rx_mode_for_each_mc_addr(dev, ha_addr, idx) \
+	for (ha_addr = dev->rx_mode_ctx->ready->mc_addrs, idx = 0; \
+		idx < dev->rx_mode_ctx->ready->mc_count; \
+		ha_addr += dev->addr_len, idx++)
+
 int __dev_queue_xmit(struct sk_buff *skb, struct net_device *sb_dev);
 int __dev_direct_xmit(struct sk_buff *skb, u16 queue_id);
 
diff --git a/net/core/dev.c b/net/core/dev.c
index 69515edd17bc..021f24c82977 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -1645,6 +1645,161 @@ static int napi_kthread_create(struct napi_struct *n)
 	return err;
 }
 
+/* The existence of pending/ready config is an implementation detail. The
+ * caller shouldn't be aware of them. This is a bit hacky. We read
+ * bits from pending because control bits need to be read before pending
+ * is prepared.
+ */
+static inline bool __netif_rx_mode_pending_get_bit(struct net_device *dev,
+						   int b)
+{
+	return dev->rx_mode_ctx->pending->ctrl_flags & BIT(b);
+}
+
+/* This function attempts to copy the current state of the
+ * net device into pending (reallocating if necessary). If it fails,
+ * pending is guaranteed to be unmodified.
+ */
+static int netif_rx_mode_alloc_and_fill_pending(struct net_device *dev)
+{
+	struct netif_rx_mode_config *pending = dev->rx_mode_ctx->pending;
+	struct netdev_hw_addr *ha;
+	int uc_count = 0, mc_count = 0;
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
@@ -1679,6 +1834,9 @@ static int __dev_open(struct net_device *dev, struct netlink_ext_ack *extack)
 	if (ops->ndo_validate_addr)
 		ret = ops->ndo_validate_addr(dev);
 
+	if (!ret && ops->ndo_write_rx_mode)
+		ret = alloc_rx_mode_ctx(dev);
+
 	if (!ret && ops->ndo_open)
 		ret = ops->ndo_open(dev);
 
@@ -1713,6 +1871,22 @@ int netif_open(struct net_device *dev, struct netlink_ext_ack *extack)
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
@@ -1755,6 +1929,8 @@ static void __dev_close_many(struct list_head *head)
 		if (ops->ndo_stop)
 			ops->ndo_stop(dev);
 
+		cleanup_rx_mode_ctx(dev);
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



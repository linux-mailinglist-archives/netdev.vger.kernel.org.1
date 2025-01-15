Return-Path: <netdev+bounces-158378-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BF31A1181C
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 04:54:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 867D97A16B6
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 03:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5360C22F39F;
	Wed, 15 Jan 2025 03:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hbXAj4Kd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F53322F399
	for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 03:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736913221; cv=none; b=sSRw5w+J6JXmwEq0y4rJVuG4GxKXU3qo+K+KIVSUl3xgpUwLRNzgwwKY8YVSnYOoAHD5KY1auhclyx+VpqIGBmPcfEaabMl3bcAWpvaSVwibvWQgFrCR7Mv5YbgLCr58cHZwZTl2TiChmki4M1t0I5kHdEznXbJN6iofQgMsGbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736913221; c=relaxed/simple;
	bh=OgxCKVDd6gB1ntWzMAk5eOTDn1EsoLc45FuC2+NwPOo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MxIJxk7fuXQrs/kvSce30ocJz97tE1PWqyvRQysamUBWXyymnFZ9kub2mTp3r0DbyZlTMFlzrlE+gqp5Jr9eqnIzYsFFRqJ3B2TcJm5Ob8jkN4Lj8pA7pXBjIWS6WQ/m32FxyBC9Q7WV41BmrPYk+TSBUx+CXN87Vh6xgwwAHzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hbXAj4Kd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA33EC4CEDF;
	Wed, 15 Jan 2025 03:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736913220;
	bh=OgxCKVDd6gB1ntWzMAk5eOTDn1EsoLc45FuC2+NwPOo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hbXAj4Kd422g9S0/j+9fnLalDsSWYDIueIFLvTq6KUquJDM3oGvJ+X9HlfN//DSF3
	 uYXB5XrnbZHDpJ8uBjlSVd6i3tjKnfD2YocbmS3G79uZT6yeD2Xvc8oqL/io9S2BFF
	 DVOO0IoqCkzjADsa0pPS8SPlR+ET6laHXaOLdsWtudKhYJvPcMvbSbrPTIjN3NJ78j
	 nrOibjgEfkkhGI4cOxIhpiL99fjPqyNaODrpKtpG122K2ZgyNgu0tj0pTK+dIFcm17
	 zWA16TvXVYUfcVvgb0OCdpSj22SMvUdHNfUT+MVJByhJW60fdgbMPcSRKm1om3yimC
	 zjLtokM5pQrsg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	jdamato@fastly.com,
	Jakub Kicinski <kuba@kernel.org>,
	Francois Romieu <romieu@fr.zoreil.com>,
	pcnet32@frontier.com,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	marcin.s.wojtas@gmail.com
Subject: [PATCH net-next v2 06/11] net: protect NAPI enablement with netdev_lock()
Date: Tue, 14 Jan 2025 19:53:14 -0800
Message-ID: <20250115035319.559603-7-kuba@kernel.org>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250115035319.559603-1-kuba@kernel.org>
References: <20250115035319.559603-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Wrap napi_enable() / napi_disable() with netdev_lock().
Provide the "already locked" flavor of the API.

iavf needs the usual adjustment. A number of drivers call
napi_enable() under a spin lock, so they have to be modified
to take netdev_lock() first, then spin lock then call
napi_enable_locked().

Protecting napi_enable() implies that napi->napi_id is protected
by netdev_lock().

Acked-by: Francois Romieu <romieu@fr.zoreil.com> # via-velocity
Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2:
 - use napi_disabled_locked() in via-velocity
v1: https://lore.kernel.org/20250114035118.110297-7-kuba@kernel.org

CC: pcnet32@frontier.com
CC: anthony.l.nguyen@intel.com
CC: przemyslaw.kitszel@intel.com
CC: marcin.s.wojtas@gmail.com
CC: romieu@fr.zoreil.com
---
 include/linux/netdevice.h                   | 11 ++----
 drivers/net/ethernet/amd/pcnet32.c          | 11 +++++-
 drivers/net/ethernet/intel/iavf/iavf_main.c |  4 +-
 drivers/net/ethernet/marvell/mvneta.c       |  5 ++-
 drivers/net/ethernet/via/via-velocity.c     |  6 ++-
 net/core/dev.c                              | 41 +++++++++++++++++----
 6 files changed, 56 insertions(+), 22 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index e8c8a5ea7326..4ab33fbadd9f 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -382,7 +382,7 @@ struct napi_struct {
 	struct sk_buff		*skb;
 	struct list_head	rx_list; /* Pending GRO_NORMAL skbs */
 	int			rx_count; /* length of rx_list */
-	unsigned int		napi_id;
+	unsigned int		napi_id; /* protected by netdev_lock */
 	struct hrtimer		timer;
 	struct task_struct	*thread;
 	unsigned long		gro_flush_timeout;
@@ -570,16 +570,11 @@ static inline bool napi_complete(struct napi_struct *n)
 
 int dev_set_threaded(struct net_device *dev, bool threaded);
 
-/**
- *	napi_disable - prevent NAPI from scheduling
- *	@n: NAPI context
- *
- * Stop NAPI from being scheduled on this context.
- * Waits till any outstanding processing completes.
- */
 void napi_disable(struct napi_struct *n);
+void napi_disable_locked(struct napi_struct *n);
 
 void napi_enable(struct napi_struct *n);
+void napi_enable_locked(struct napi_struct *n);
 
 /**
  *	napi_synchronize - wait until NAPI is not running
diff --git a/drivers/net/ethernet/amd/pcnet32.c b/drivers/net/ethernet/amd/pcnet32.c
index 72db9f9e7bee..c6bd803f5b0c 100644
--- a/drivers/net/ethernet/amd/pcnet32.c
+++ b/drivers/net/ethernet/amd/pcnet32.c
@@ -462,7 +462,7 @@ static void pcnet32_netif_start(struct net_device *dev)
 	val = lp->a->read_csr(ioaddr, CSR3);
 	val &= 0x00ff;
 	lp->a->write_csr(ioaddr, CSR3, val);
-	napi_enable(&lp->napi);
+	napi_enable_locked(&lp->napi);
 }
 
 /*
@@ -889,6 +889,7 @@ static int pcnet32_set_ringparam(struct net_device *dev,
 	if (netif_running(dev))
 		pcnet32_netif_stop(dev);
 
+	netdev_lock(dev);
 	spin_lock_irqsave(&lp->lock, flags);
 	lp->a->write_csr(ioaddr, CSR0, CSR0_STOP);	/* stop the chip */
 
@@ -920,6 +921,7 @@ static int pcnet32_set_ringparam(struct net_device *dev,
 	}
 
 	spin_unlock_irqrestore(&lp->lock, flags);
+	netdev_unlock(dev);
 
 	netif_info(lp, drv, dev, "Ring Param Settings: RX: %d, TX: %d\n",
 		   lp->rx_ring_size, lp->tx_ring_size);
@@ -985,6 +987,7 @@ static int pcnet32_loopback_test(struct net_device *dev, uint64_t * data1)
 	if (netif_running(dev))
 		pcnet32_netif_stop(dev);
 
+	netdev_lock(dev);
 	spin_lock_irqsave(&lp->lock, flags);
 	lp->a->write_csr(ioaddr, CSR0, CSR0_STOP);	/* stop the chip */
 
@@ -1122,6 +1125,7 @@ static int pcnet32_loopback_test(struct net_device *dev, uint64_t * data1)
 		lp->a->write_bcr(ioaddr, 20, 4);	/* return to 16bit mode */
 	}
 	spin_unlock_irqrestore(&lp->lock, flags);
+	netdev_unlock(dev);
 
 	return rc;
 }				/* end pcnet32_loopback_test  */
@@ -2101,6 +2105,7 @@ static int pcnet32_open(struct net_device *dev)
 		return -EAGAIN;
 	}
 
+	netdev_lock(dev);
 	spin_lock_irqsave(&lp->lock, flags);
 	/* Check for a valid station address */
 	if (!is_valid_ether_addr(dev->dev_addr)) {
@@ -2266,7 +2271,7 @@ static int pcnet32_open(struct net_device *dev)
 		goto err_free_ring;
 	}
 
-	napi_enable(&lp->napi);
+	napi_enable_locked(&lp->napi);
 
 	/* Re-initialize the PCNET32, and start it when done. */
 	lp->a->write_csr(ioaddr, 1, (lp->init_dma_addr & 0xffff));
@@ -2300,6 +2305,7 @@ static int pcnet32_open(struct net_device *dev)
 		     lp->a->read_csr(ioaddr, CSR0));
 
 	spin_unlock_irqrestore(&lp->lock, flags);
+	netdev_unlock(dev);
 
 	return 0;		/* Always succeed */
 
@@ -2315,6 +2321,7 @@ static int pcnet32_open(struct net_device *dev)
 
 err_free_irq:
 	spin_unlock_irqrestore(&lp->lock, flags);
+	netdev_unlock(dev);
 	free_irq(dev->irq, dev);
 	return rc;
 }
diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 2db97c5d9f9e..cbfaaa5b7d02 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -1180,7 +1180,7 @@ static void iavf_napi_enable_all(struct iavf_adapter *adapter)
 
 		q_vector = &adapter->q_vectors[q_idx];
 		napi = &q_vector->napi;
-		napi_enable(napi);
+		napi_enable_locked(napi);
 	}
 }
 
@@ -1196,7 +1196,7 @@ static void iavf_napi_disable_all(struct iavf_adapter *adapter)
 
 	for (q_idx = 0; q_idx < q_vectors; q_idx++) {
 		q_vector = &adapter->q_vectors[q_idx];
-		napi_disable(&q_vector->napi);
+		napi_disable_locked(&q_vector->napi);
 	}
 }
 
diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index fe6261b81540..cc97474852ef 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -4392,6 +4392,7 @@ static int mvneta_cpu_online(unsigned int cpu, struct hlist_node *node)
 	if (pp->neta_armada3700)
 		return 0;
 
+	netdev_lock(port->napi.dev);
 	spin_lock(&pp->lock);
 	/*
 	 * Configuring the driver for a new CPU while the driver is
@@ -4418,7 +4419,7 @@ static int mvneta_cpu_online(unsigned int cpu, struct hlist_node *node)
 
 	/* Mask all ethernet port interrupts */
 	on_each_cpu(mvneta_percpu_mask_interrupt, pp, true);
-	napi_enable(&port->napi);
+	napi_enable_locked(&port->napi);
 
 	/*
 	 * Enable per-CPU interrupts on the CPU that is
@@ -4439,6 +4440,8 @@ static int mvneta_cpu_online(unsigned int cpu, struct hlist_node *node)
 		    MVNETA_CAUSE_LINK_CHANGE);
 	netif_tx_start_all_queues(pp->dev);
 	spin_unlock(&pp->lock);
+	netdev_unlock(port->napi.dev);
+
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/via/via-velocity.c b/drivers/net/ethernet/via/via-velocity.c
index dd4a07c97eee..5aa93144a4f5 100644
--- a/drivers/net/ethernet/via/via-velocity.c
+++ b/drivers/net/ethernet/via/via-velocity.c
@@ -2320,7 +2320,8 @@ static int velocity_change_mtu(struct net_device *dev, int new_mtu)
 		if (ret < 0)
 			goto out_free_tmp_vptr_1;
 
-		napi_disable(&vptr->napi);
+		netdev_lock(dev);
+		napi_disable_locked(&vptr->napi);
 
 		spin_lock_irqsave(&vptr->lock, flags);
 
@@ -2342,12 +2343,13 @@ static int velocity_change_mtu(struct net_device *dev, int new_mtu)
 
 		velocity_give_many_rx_descs(vptr);
 
-		napi_enable(&vptr->napi);
+		napi_enable_locked(&vptr->napi);
 
 		mac_enable_int(vptr->mac_regs);
 		netif_start_queue(dev);
 
 		spin_unlock_irqrestore(&vptr->lock, flags);
+		netdev_unlock(dev);
 
 		velocity_free_rings(tmp_vptr);
 
diff --git a/net/core/dev.c b/net/core/dev.c
index 7511207057e5..9cf93868ac7e 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6957,11 +6957,13 @@ void netif_napi_add_weight_locked(struct net_device *dev,
 }
 EXPORT_SYMBOL(netif_napi_add_weight_locked);
 
-void napi_disable(struct napi_struct *n)
+void napi_disable_locked(struct napi_struct *n)
 {
 	unsigned long val, new;
 
 	might_sleep();
+	netdev_assert_locked(n->dev);
+
 	set_bit(NAPI_STATE_DISABLE, &n->state);
 
 	val = READ_ONCE(n->state);
@@ -6984,16 +6986,25 @@ void napi_disable(struct napi_struct *n)
 
 	clear_bit(NAPI_STATE_DISABLE, &n->state);
 }
-EXPORT_SYMBOL(napi_disable);
+EXPORT_SYMBOL(napi_disable_locked);
 
 /**
- *	napi_enable - enable NAPI scheduling
- *	@n: NAPI context
+ * napi_disable() - prevent NAPI from scheduling
+ * @n: NAPI context
  *
- * Resume NAPI from being scheduled on this context.
- * Must be paired with napi_disable.
+ * Stop NAPI from being scheduled on this context.
+ * Waits till any outstanding processing completes.
+ * Takes netdev_lock() for associated net_device.
  */
-void napi_enable(struct napi_struct *n)
+void napi_disable(struct napi_struct *n)
+{
+	netdev_lock(n->dev);
+	napi_disable_locked(n);
+	netdev_unlock(n->dev);
+}
+EXPORT_SYMBOL(napi_disable);
+
+void napi_enable_locked(struct napi_struct *n)
 {
 	unsigned long new, val = READ_ONCE(n->state);
 
@@ -7010,6 +7021,22 @@ void napi_enable(struct napi_struct *n)
 			new |= NAPIF_STATE_THREADED;
 	} while (!try_cmpxchg(&n->state, &val, new));
 }
+EXPORT_SYMBOL(napi_enable_locked);
+
+/**
+ * napi_enable() - enable NAPI scheduling
+ * @n: NAPI context
+ *
+ * Enable scheduling of a NAPI instance.
+ * Must be paired with napi_disable().
+ * Takes netdev_lock() for associated net_device.
+ */
+void napi_enable(struct napi_struct *n)
+{
+	netdev_lock(n->dev);
+	napi_enable_locked(n);
+	netdev_unlock(n->dev);
+}
 EXPORT_SYMBOL(napi_enable);
 
 static void flush_gro_hash(struct napi_struct *napi)
-- 
2.48.0



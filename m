Return-Path: <netdev+bounces-233816-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B492C18D51
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 09:05:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DF191B21E2F
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 08:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34F8C31282A;
	Wed, 29 Oct 2025 08:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="BO8bCt6J"
X-Original-To: netdev@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8103112C9
	for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 08:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761724923; cv=none; b=rMjs/0n2DgN6TsfgylSku3xXNdCw1gnVgNEIOwspJ1O6YB3is5cjjuFFMJdkReZyhvden9ZxJgiTvUWV+k5oMKfaMhxT2luu8NblCRcct+5IbyDocgvziRZhC0spBBxHVR0qrqF2f4y1bPYibnoK3uGosih8hJMO71SQlNO2rpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761724923; c=relaxed/simple;
	bh=UHPaVt0kCzb47SPEkXrTGsW8IwQdnGy3v9vVc0pCOZQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=n8urytTnfsKG1l5zj9wHcmZ5cI8C2js2UawJrzDXA4+ueoyzR1tV8bvM4pUyturaOWFva/lIEuzfqZmAhG8gyQ5AOqYB3SMzxgEjL0CPiI1wn3mDlj2XJ/kj+id10nTSAghQPyCa5f5TjCM1LxcEMgbSHPSDeqAyYoD2HTwmrxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=BO8bCt6J; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1761724911; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=/TLKcJhpaZm/5rnnomHsL7GXrxaa4J7y+4XU0ETl1s0=;
	b=BO8bCt6JDs/Ql3VX6qeAtpU/kANsXDxjggG/4GWn+9kcxVINcNUlm/i+ET7myLeHYi9hAT5ETv6c+vLtJuPAy44TixD40X5Hjlt1Pep0++JB9O+m7CKPp6HwkkX34TfAIZdFwxMICR4E3Mevnrqeej9lSndkMgcthwf+HeTXUOM=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WrF5XxQ_1761724909 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 29 Oct 2025 16:01:49 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>,
	Philo Lu <lulie@linux.alibaba.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Vivian Wang <wangruikang@iscas.ac.cn>,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>,
	Dust Li <dust.li@linux.alibaba.com>
Subject: [PATCH net-next v9 4/5] eea: create/destroy rx,tx queues for netdevice open and stop
Date: Wed, 29 Oct 2025 16:01:44 +0800
Message-Id: <20251029080145.18967-5-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20251029080145.18967-1-xuanzhuo@linux.alibaba.com>
References: <20251029080145.18967-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: 4becde0aa50f
Content-Transfer-Encoding: 8bit

Add basic driver framework for the Alibaba Elastic Ethernet Adapter(EEA).

This commit introduces the implementation for the netdevice open and
stop.

Reviewed-by: Dust Li <dust.li@linux.alibaba.com>
Reviewed-by: Philo Lu <lulie@linux.alibaba.com>
Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/ethernet/alibaba/eea/Makefile  |   4 +-
 drivers/net/ethernet/alibaba/eea/eea_net.c | 386 ++++++++++-
 drivers/net/ethernet/alibaba/eea/eea_net.h |  48 ++
 drivers/net/ethernet/alibaba/eea/eea_pci.c | 178 +++++
 drivers/net/ethernet/alibaba/eea/eea_pci.h |  14 +
 drivers/net/ethernet/alibaba/eea/eea_rx.c  | 763 +++++++++++++++++++++
 drivers/net/ethernet/alibaba/eea/eea_tx.c  | 380 ++++++++++
 7 files changed, 1770 insertions(+), 3 deletions(-)
 create mode 100644 drivers/net/ethernet/alibaba/eea/eea_rx.c
 create mode 100644 drivers/net/ethernet/alibaba/eea/eea_tx.c

diff --git a/drivers/net/ethernet/alibaba/eea/Makefile b/drivers/net/ethernet/alibaba/eea/Makefile
index 91f318e8e046..fa34a005fa01 100644
--- a/drivers/net/ethernet/alibaba/eea/Makefile
+++ b/drivers/net/ethernet/alibaba/eea/Makefile
@@ -3,4 +3,6 @@ obj-$(CONFIG_EEA) += eea.o
 eea-y := eea_ring.o \
 	eea_net.o \
 	eea_pci.o \
-	eea_adminq.o
+	eea_adminq.o \
+	eea_tx.o \
+	eea_rx.o
diff --git a/drivers/net/ethernet/alibaba/eea/eea_net.c b/drivers/net/ethernet/alibaba/eea/eea_net.c
index 8824cc64d6d6..0c998ee26f81 100644
--- a/drivers/net/ethernet/alibaba/eea/eea_net.c
+++ b/drivers/net/ethernet/alibaba/eea/eea_net.c
@@ -18,6 +18,331 @@
 
 #define EEA_SPLIT_HDR_SIZE 128
 
+static void enet_bind_new_q_and_cfg(struct eea_net *enet,
+				    struct eea_net_init_ctx *ctx)
+{
+	struct eea_net_rx *rx;
+	struct eea_net_tx *tx;
+	int i;
+
+	enet->cfg = ctx->cfg;
+
+	enet->rx = ctx->rx;
+	enet->tx = ctx->tx;
+
+	for (i = 0; i < ctx->cfg.rx_ring_num; i++) {
+		rx = ctx->rx[i];
+		tx = &ctx->tx[i];
+
+		rx->enet = enet;
+		tx->enet = enet;
+	}
+}
+
+void enet_init_ctx(struct eea_net *enet, struct eea_net_init_ctx *ctx)
+{
+	memset(ctx, 0, sizeof(*ctx));
+
+	ctx->netdev = enet->netdev;
+	ctx->edev = enet->edev;
+	ctx->cfg = enet->cfg;
+}
+
+static void eea_free_rxtx_q_mem(struct eea_net *enet)
+{
+	struct eea_net_rx *rx;
+	struct eea_net_tx *tx;
+	int i;
+
+	for (i = 0; i < enet->cfg.rx_ring_num; i++) {
+		rx = enet->rx[i];
+		tx = &enet->tx[i];
+
+		eea_free_rx(rx);
+		eea_free_tx(tx);
+	}
+
+	/* We called __netif_napi_del(),
+	 * we need to respect an RCU grace period before freeing enet->rx
+	 */
+	synchronize_net();
+
+	kvfree(enet->rx);
+	kvfree(enet->tx);
+
+	enet->rx = NULL;
+	enet->tx = NULL;
+}
+
+/* alloc tx/rx: struct, ring, meta, pp, napi */
+static int eea_alloc_rxtx_q_mem(struct eea_net_init_ctx *ctx)
+{
+	struct eea_net_rx *rx;
+	struct eea_net_tx *tx;
+	int err, i;
+
+	ctx->tx = kvcalloc(ctx->cfg.tx_ring_num, sizeof(*ctx->tx), GFP_KERNEL);
+	if (!ctx->tx)
+		goto error_tx;
+
+	ctx->rx = kvcalloc(ctx->cfg.rx_ring_num, sizeof(*ctx->rx), GFP_KERNEL);
+	if (!ctx->rx)
+		goto error_rx;
+
+	ctx->cfg.rx_sq_desc_size = sizeof(struct eea_rx_desc);
+	ctx->cfg.rx_cq_desc_size = sizeof(struct eea_rx_cdesc);
+	ctx->cfg.tx_sq_desc_size = sizeof(struct eea_tx_desc);
+	ctx->cfg.tx_cq_desc_size = sizeof(struct eea_tx_cdesc);
+
+	ctx->cfg.tx_cq_desc_size /= 2;
+
+	if (!ctx->cfg.split_hdr)
+		ctx->cfg.rx_sq_desc_size /= 2;
+
+	for (i = 0; i < ctx->cfg.rx_ring_num; i++) {
+		rx = eea_alloc_rx(ctx, i);
+		if (!rx)
+			goto err;
+
+		ctx->rx[i] = rx;
+
+		tx = ctx->tx + i;
+		err = eea_alloc_tx(ctx, tx, i);
+		if (err)
+			goto err;
+	}
+
+	return 0;
+
+err:
+	for (i = 0; i < ctx->cfg.rx_ring_num; i++) {
+		rx = ctx->rx[i];
+		tx = ctx->tx + i;
+
+		eea_free_rx(rx);
+		eea_free_tx(tx);
+	}
+
+	kvfree(ctx->rx);
+
+error_rx:
+	kvfree(ctx->tx);
+
+error_tx:
+	return -ENOMEM;
+}
+
+static int eea_active_ring_and_irq(struct eea_net *enet)
+{
+	int err;
+
+	err = eea_adminq_create_q(enet, /* qidx = */ 0,
+				  enet->cfg.rx_ring_num +
+				  enet->cfg.tx_ring_num, 0);
+	if (err)
+		return err;
+
+	err = enet_rxtx_irq_setup(enet, 0, enet->cfg.rx_ring_num);
+	if (err) {
+		eea_adminq_destroy_all_q(enet);
+		return err;
+	}
+
+	return 0;
+}
+
+static int eea_unactive_ring_and_irq(struct eea_net *enet)
+{
+	struct eea_net_rx *rx;
+	int err, i;
+
+	err = eea_adminq_destroy_all_q(enet);
+	if (err)
+		netdev_warn(enet->netdev, "unactive rxtx ring failed.\n");
+
+	for (i = 0; i < enet->cfg.rx_ring_num; i++) {
+		rx = enet->rx[i];
+		eea_irq_free(rx);
+	}
+
+	return err;
+}
+
+/* stop rx napi, stop tx queue. */
+static int eea_stop_rxtx(struct net_device *netdev)
+{
+	struct eea_net *enet = netdev_priv(netdev);
+	int i;
+
+	netif_tx_disable(netdev);
+
+	for (i = 0; i < enet->cfg.rx_ring_num; i++)
+		enet_rx_stop(enet->rx[i]);
+
+	netif_carrier_off(netdev);
+
+	return 0;
+}
+
+static int eea_start_rxtx(struct net_device *netdev)
+{
+	struct eea_net *enet = netdev_priv(netdev);
+	int i, err;
+
+	err = netif_set_real_num_queues(netdev, enet->cfg.tx_ring_num,
+					enet->cfg.rx_ring_num);
+	if (err)
+		return err;
+
+	for (i = 0; i < enet->cfg.rx_ring_num; i++)
+		enet_rx_start(enet->rx[i]);
+
+	netif_tx_start_all_queues(netdev);
+	netif_carrier_on(netdev);
+
+	enet->started = true;
+
+	return 0;
+}
+
+static int eea_netdev_stop(struct net_device *netdev)
+{
+	struct eea_net *enet = netdev_priv(netdev);
+
+	/* This function can be called during device anomaly recovery. To
+	 * prevent duplicate stop operations, the `started` flag is introduced
+	 * for checking.
+	 */
+
+	if (!enet->started) {
+		netdev_warn(netdev, "eea netdev stop: but dev is not started.\n");
+		return 0;
+	}
+
+	eea_stop_rxtx(netdev);
+	eea_unactive_ring_and_irq(enet);
+	eea_free_rxtx_q_mem(enet);
+
+	enet->started = false;
+
+	return 0;
+}
+
+static int eea_netdev_open(struct net_device *netdev)
+{
+	struct eea_net *enet = netdev_priv(netdev);
+	struct eea_net_init_ctx ctx;
+	int err;
+
+	if (enet->link_err) {
+		netdev_err(netdev, "netdev open err, because link error: %d\n",
+			   enet->link_err);
+		return -EBUSY;
+	}
+
+	enet_init_ctx(enet, &ctx);
+
+	err = eea_alloc_rxtx_q_mem(&ctx);
+	if (err)
+		return err;
+
+	enet_bind_new_q_and_cfg(enet, &ctx);
+
+	err = eea_active_ring_and_irq(enet);
+	if (err)
+		return err;
+
+	return eea_start_rxtx(netdev);
+}
+
+/* resources: ring, buffers, irq */
+int eea_reset_hw_resources(struct eea_net *enet, struct eea_net_init_ctx *ctx)
+{
+	int err;
+
+	if (!netif_running(enet->netdev)) {
+		enet->cfg = ctx->cfg;
+		return 0;
+	}
+
+	err = eea_alloc_rxtx_q_mem(ctx);
+	if (err) {
+		netdev_warn(enet->netdev,
+			    "eea reset: alloc q failed. stop reset. err %d\n",
+			    err);
+		return err;
+	}
+
+	eea_netdev_stop(enet->netdev);
+
+	enet_bind_new_q_and_cfg(enet, ctx);
+
+	err = eea_active_ring_and_irq(enet);
+	if (err) {
+		netdev_warn(enet->netdev,
+			    "eea reset: active new ring and irq failed. err %d\n",
+			    err);
+		return err;
+	}
+
+	err = eea_start_rxtx(enet->netdev);
+	if (err)
+		netdev_warn(enet->netdev,
+			    "eea reset: start queue failed. err %d\n", err);
+
+	return err;
+}
+
+int eea_queues_check_and_reset(struct eea_device *edev)
+{
+	struct eea_aq_dev_status *dstatus __free(kfree) = NULL;
+	struct eea_aq_queue_status *qstatus;
+	struct eea_aq_queue_status *qs;
+	struct eea_net_init_ctx ctx;
+	bool need_reset = false;
+	int num, i, err = 0;
+
+	rtnl_lock();
+
+	num = edev->enet->cfg.tx_ring_num * 2 + 1;
+
+	dstatus = eea_adminq_dev_status(edev->enet);
+	if (!dstatus) {
+		netdev_warn(edev->enet->netdev, "query queue status failed.\n");
+		err = -ENOMEM;
+		goto done;
+	}
+
+	if (le16_to_cpu(dstatus->link_status) == EEA_LINK_DOWN_STATUS) {
+		eea_netdev_stop(edev->enet->netdev);
+		edev->enet->link_err = EEA_LINK_ERR_LINK_DOWN;
+		netdev_warn(edev->enet->netdev, "device link is down. stop device.\n");
+		goto done;
+	}
+
+	qstatus = dstatus->q_status;
+
+	for (i = 0; i < num; ++i) {
+		qs = &qstatus[i];
+
+		if (le16_to_cpu(qs->status) == EEA_QUEUE_STATUS_NEED_RESET) {
+			netdev_warn(edev->enet->netdev,
+				    "queue status: queue %u needs to reset\n",
+				    le16_to_cpu(qs->qidx));
+			need_reset = true;
+		}
+	}
+
+	if (need_reset) {
+		enet_init_ctx(edev->enet, &ctx);
+		err = eea_reset_hw_resources(edev->enet, &ctx);
+	}
+
+done:
+	rtnl_unlock();
+	return err;
+}
+
 static void eea_update_cfg(struct eea_net *enet,
 			   struct eea_device *edev,
 			   struct eea_aq_cfg *hwcfg)
@@ -104,8 +429,12 @@ static int eea_netdev_init_features(struct net_device *netdev,
 }
 
 static const struct net_device_ops eea_netdev = {
+	.ndo_open           = eea_netdev_open,
+	.ndo_stop           = eea_netdev_stop,
+	.ndo_start_xmit     = eea_tx_xmit,
 	.ndo_validate_addr  = eth_validate_addr,
 	.ndo_features_check = passthru_features_check,
+	.ndo_tx_timeout     = eea_tx_timeout,
 };
 
 static struct eea_net *eea_netdev_alloc(struct eea_device *edev, u32 pairs)
@@ -131,11 +460,48 @@ static struct eea_net *eea_netdev_alloc(struct eea_device *edev, u32 pairs)
 	return enet;
 }
 
+static void eea_update_ts_off(struct eea_device *edev, struct eea_net *enet)
+{
+	u64 ts;
+
+	ts = eea_pci_device_ts(edev);
+
+	enet->hw_ts_offset = ktime_get_real() - ts;
+}
+
+static int eea_net_reprobe(struct eea_device *edev)
+{
+	struct eea_net *enet = edev->enet;
+	int err = 0;
+
+	enet->edev = edev;
+
+	if (!enet->adminq.ring) {
+		err = eea_create_adminq(enet, edev->rx_num + edev->tx_num);
+		if (err)
+			return err;
+	}
+
+	eea_update_ts_off(edev, enet);
+
+	if (edev->ha_reset_netdev_running) {
+		rtnl_lock();
+		enet->link_err = 0;
+		err = eea_netdev_open(enet->netdev);
+		rtnl_unlock();
+	}
+
+	return err;
+}
+
 int eea_net_probe(struct eea_device *edev)
 {
 	struct eea_net *enet;
 	int err = -ENOMEM;
 
+	if (edev->ha_reset)
+		return eea_net_reprobe(edev);
+
 	enet = eea_netdev_alloc(edev, edev->rx_num);
 	if (!enet)
 		return -ENOMEM;
@@ -156,6 +522,7 @@ int eea_net_probe(struct eea_device *edev)
 	if (err)
 		goto err_reset_dev;
 
+	eea_update_ts_off(edev, enet);
 	netif_carrier_off(enet->netdev);
 
 	netdev_dbg(enet->netdev, "eea probe success.\n");
@@ -179,10 +546,25 @@ void eea_net_remove(struct eea_device *edev)
 	enet = edev->enet;
 	netdev = enet->netdev;
 
-	unregister_netdev(netdev);
-	netdev_dbg(enet->netdev, "eea removed.\n");
+	if (edev->ha_reset) {
+		edev->ha_reset_netdev_running = false;
+		if (netif_running(enet->netdev)) {
+			rtnl_lock();
+			eea_netdev_stop(enet->netdev);
+			enet->link_err = EEA_LINK_ERR_HA_RESET_DEV;
+			enet->edev = NULL;
+			rtnl_unlock();
+			edev->ha_reset_netdev_running = true;
+		}
+	} else {
+		unregister_netdev(netdev);
+		netdev_dbg(enet->netdev, "eea removed.\n");
+	}
 
 	eea_device_reset(edev);
 
 	eea_destroy_adminq(enet);
+
+	if (!edev->ha_reset)
+		free_netdev(netdev);
 }
diff --git a/drivers/net/ethernet/alibaba/eea/eea_net.h b/drivers/net/ethernet/alibaba/eea/eea_net.h
index b35d7483de63..b451f6765480 100644
--- a/drivers/net/ethernet/alibaba/eea/eea_net.h
+++ b/drivers/net/ethernet/alibaba/eea/eea_net.h
@@ -18,6 +18,13 @@
 #define EEA_VER_MINOR		0
 #define EEA_VER_SUB_MINOR	0
 
+struct eea_tx_meta;
+
+struct eea_reprobe {
+	struct eea_net *enet;
+	bool running_before_reprobe;
+};
+
 struct eea_net_tx {
 	struct eea_net *enet;
 
@@ -104,6 +111,18 @@ struct eea_net_cfg {
 	u8 tx_cq_desc_size;
 
 	u32 split_hdr;
+
+	struct hwtstamp_config ts_cfg;
+};
+
+struct eea_net_init_ctx {
+	struct eea_net_cfg cfg;
+
+	struct eea_net_tx *tx;
+	struct eea_net_rx **rx;
+
+	struct net_device *netdev;
+	struct eea_device *edev;
 };
 
 enum {
@@ -135,9 +154,38 @@ struct eea_net {
 	u64 hw_ts_offset;
 };
 
+int eea_tx_resize(struct eea_net *enet, struct eea_net_tx *tx, u32 ring_num);
+
 int eea_net_probe(struct eea_device *edev);
 void eea_net_remove(struct eea_device *edev);
 int eea_net_freeze(struct eea_device *edev);
 int eea_net_restore(struct eea_device *edev);
 
+int eea_reset_hw_resources(struct eea_net *enet, struct eea_net_init_ctx *ctx);
+void enet_init_ctx(struct eea_net *enet, struct eea_net_init_ctx *ctx);
+int eea_queues_check_and_reset(struct eea_device *edev);
+
+/* rx apis */
+int eea_poll(struct napi_struct *napi, int budget);
+
+void enet_rx_stop(struct eea_net_rx *rx);
+void enet_rx_start(struct eea_net_rx *rx);
+
+void eea_free_rx(struct eea_net_rx *rx);
+struct eea_net_rx *eea_alloc_rx(struct eea_net_init_ctx *ctx, u32 idx);
+
+void eea_irq_free(struct eea_net_rx *rx);
+
+int enet_rxtx_irq_setup(struct eea_net *enet, u32 qid, u32 num);
+
+/* tx apis */
+int eea_poll_tx(struct eea_net_tx *tx, int budget);
+void eea_poll_cleantx(struct eea_net_rx *rx);
+netdev_tx_t eea_tx_xmit(struct sk_buff *skb, struct net_device *netdev);
+
+void eea_tx_timeout(struct net_device *netdev, u32 txqueue);
+
+void eea_free_tx(struct eea_net_tx *tx);
+int eea_alloc_tx(struct eea_net_init_ctx *ctx, struct eea_net_tx *tx, u32 idx);
+
 #endif
diff --git a/drivers/net/ethernet/alibaba/eea/eea_pci.c b/drivers/net/ethernet/alibaba/eea/eea_pci.c
index 2060ea3a0555..4c7dfe1c7ad6 100644
--- a/drivers/net/ethernet/alibaba/eea/eea_pci.c
+++ b/drivers/net/ethernet/alibaba/eea/eea_pci.c
@@ -13,6 +13,9 @@
 
 #define EEA_PCI_DB_OFFSET 4096
 
+#define EEA_PCI_CAP_RESET_DEVICE 0xFA
+#define EEA_PCI_CAP_RESET_FLAG BIT(1)
+
 struct eea_pci_cfg {
 	__le32 reserve0;
 	__le32 reserve1;
@@ -51,6 +54,7 @@ struct eea_pci_device {
 	void __iomem *reg;
 	void __iomem *db_base;
 
+	struct work_struct ha_handle_work;
 	char ha_irq_name[32];
 	u8 reset_pos;
 };
@@ -67,6 +71,11 @@ struct eea_pci_device {
 #define cfg_read32(reg, item) ioread32(cfg_pointer(reg, item))
 #define cfg_readq(reg, item) readq(cfg_pointer(reg, item))
 
+/* Due to circular references, we have to add function definitions here. */
+static int __eea_pci_probe(struct pci_dev *pci_dev,
+			   struct eea_pci_device *ep_dev);
+static void __eea_pci_remove(struct pci_dev *pci_dev, bool flush_ha_work);
+
 const char *eea_pci_name(struct eea_device *edev)
 {
 	return pci_name(edev->ep_dev->pci_dev);
@@ -252,6 +261,153 @@ void eea_pci_active_aq(struct eea_ring *ering)
 				    cfg_read32(ep_dev->reg, aq_db_off));
 }
 
+void eea_pci_free_irq(struct eea_ring *ering, void *data)
+{
+	struct eea_pci_device *ep_dev = ering->edev->ep_dev;
+	int irq;
+
+	irq = pci_irq_vector(ep_dev->pci_dev, ering->msix_vec);
+	irq_update_affinity_hint(irq, NULL);
+	free_irq(irq, data);
+}
+
+int eea_pci_request_irq(struct eea_ring *ering,
+			irqreturn_t (*callback)(int irq, void *data),
+			void *data)
+{
+	struct eea_pci_device *ep_dev = ering->edev->ep_dev;
+	int irq;
+
+	snprintf(ering->irq_name, sizeof(ering->irq_name), "eea-q%d@%s",
+		 ering->index / 2, pci_name(ep_dev->pci_dev));
+
+	irq = pci_irq_vector(ep_dev->pci_dev, ering->msix_vec);
+
+	return request_irq(irq, callback, 0, ering->irq_name, data);
+}
+
+static int eea_ha_handle_reset(struct eea_pci_device *ep_dev)
+{
+	struct eea_device *edev;
+	struct pci_dev *pci_dev;
+	u16 reset;
+
+	if (!ep_dev->reset_pos)
+		return 0;
+
+	edev = &ep_dev->edev;
+
+	pci_read_config_word(ep_dev->pci_dev, ep_dev->reset_pos, &reset);
+
+	/* clear bit */
+	pci_write_config_word(ep_dev->pci_dev, ep_dev->reset_pos, 0xFFFF);
+
+	if (reset & EEA_PCI_CAP_RESET_FLAG) {
+		dev_warn(&ep_dev->pci_dev->dev, "recv device reset request.\n");
+
+		pci_dev = ep_dev->pci_dev;
+
+		/* The pci remove callback may hold this lock. If the
+		 * pci remove callback is called, then we can ignore the
+		 * ha interrupt.
+		 */
+		if (mutex_trylock(&edev->ha_lock)) {
+			edev->ha_reset = true;
+
+			__eea_pci_remove(pci_dev, false);
+			__eea_pci_probe(pci_dev, ep_dev);
+
+			edev->ha_reset = false;
+			mutex_unlock(&edev->ha_lock);
+		} else {
+			dev_warn(&ep_dev->pci_dev->dev,
+				 "ha device reset: trylock failed.\n");
+		}
+
+		return 1;
+	}
+
+	return 0;
+}
+
+/* ha handle code */
+static void eea_ha_handle_work(struct work_struct *work)
+{
+	struct eea_pci_device *ep_dev;
+	int done;
+
+	ep_dev = container_of(work, struct eea_pci_device, ha_handle_work);
+
+	/* Ha interrupt is triggered, so there maybe some error, we may need to
+	 * reset the device or reset some queues.
+	 */
+	dev_warn(&ep_dev->pci_dev->dev, "recv ha interrupt.\n");
+
+	done = eea_ha_handle_reset(ep_dev);
+	if (done)
+		return;
+
+	eea_queues_check_and_reset(&ep_dev->edev);
+}
+
+static irqreturn_t eea_pci_ha_handle(int irq, void *data)
+{
+	struct eea_device *edev = data;
+
+	schedule_work(&edev->ep_dev->ha_handle_work);
+
+	return IRQ_HANDLED;
+}
+
+static void eea_pci_free_ha_irq(struct eea_device *edev)
+{
+	struct eea_pci_device *ep_dev = edev->ep_dev;
+	int irq = pci_irq_vector(ep_dev->pci_dev, 0);
+
+	free_irq(irq, edev);
+}
+
+static int eea_pci_ha_init(struct eea_device *edev, struct pci_dev *pci_dev)
+{
+	u8 pos, cfg_type_off, type, cfg_drv_off, cfg_dev_off;
+	struct eea_pci_device *ep_dev = edev->ep_dev;
+	int irq;
+
+	cfg_type_off = offsetof(struct eea_pci_cap, cfg_type);
+	cfg_drv_off = offsetof(struct eea_pci_reset_reg, driver);
+	cfg_dev_off = offsetof(struct eea_pci_reset_reg, device);
+
+	for (pos = pci_find_capability(pci_dev, PCI_CAP_ID_VNDR);
+	     pos > 0;
+	     pos = pci_find_next_capability(pci_dev, pos, PCI_CAP_ID_VNDR)) {
+		pci_read_config_byte(pci_dev, pos + cfg_type_off, &type);
+
+		if (type == EEA_PCI_CAP_RESET_DEVICE) {
+			/* notify device, driver support this feature. */
+			pci_write_config_word(pci_dev, pos + cfg_drv_off,
+					      EEA_PCI_CAP_RESET_FLAG);
+			pci_write_config_word(pci_dev, pos + cfg_dev_off,
+					      0xFFFF);
+
+			edev->ep_dev->reset_pos = pos + cfg_dev_off;
+			goto found;
+		}
+	}
+
+	dev_warn(&edev->ep_dev->pci_dev->dev, "Not Found reset cap.\n");
+
+found:
+	snprintf(ep_dev->ha_irq_name, sizeof(ep_dev->ha_irq_name), "eea-ha@%s",
+		 pci_name(ep_dev->pci_dev));
+
+	irq = pci_irq_vector(ep_dev->pci_dev, 0);
+
+	INIT_WORK(&ep_dev->ha_handle_work, eea_ha_handle_work);
+
+	return request_irq(irq, eea_pci_ha_handle, 0,
+			   ep_dev->ha_irq_name, edev);
+}
+
 u64 eea_pci_device_ts(struct eea_device *edev)
 {
 	struct eea_pci_device *ep_dev = edev->ep_dev;
@@ -286,10 +442,13 @@ static int eea_init_device(struct eea_device *edev)
 static int __eea_pci_probe(struct pci_dev *pci_dev,
 			   struct eea_pci_device *ep_dev)
 {
+	struct eea_device *edev;
 	int err;
 
 	pci_set_drvdata(pci_dev, ep_dev);
 
+	edev = &ep_dev->edev;
+
 	err = eea_pci_setup(pci_dev, ep_dev);
 	if (err)
 		goto err_setup;
@@ -298,8 +457,15 @@ static int __eea_pci_probe(struct pci_dev *pci_dev,
 	if (err)
 		goto err_register;
 
+	err = eea_pci_ha_init(edev, pci_dev);
+	if (err)
+		goto err_error_irq;
+
 	return 0;
 
+err_error_irq:
+	eea_net_remove(edev);
+
 err_register:
 	eea_pci_release_resource(ep_dev);
 
@@ -314,6 +480,11 @@ static void __eea_pci_remove(struct pci_dev *pci_dev, bool flush_ha_work)
 	struct device *dev = get_device(&ep_dev->pci_dev->dev);
 	struct eea_device *edev = &ep_dev->edev;
 
+	eea_pci_free_ha_irq(edev);
+
+	if (flush_ha_work)
+		flush_work(&ep_dev->ha_handle_work);
+
 	eea_net_remove(edev);
 
 	pci_disable_sriov(pci_dev);
@@ -340,14 +511,21 @@ static int eea_pci_probe(struct pci_dev *pci_dev,
 
 	ep_dev->pci_dev = pci_dev;
 
+	mutex_init(&edev->ha_lock);
+
 	return __eea_pci_probe(pci_dev, ep_dev);
 }
 
 static void eea_pci_remove(struct pci_dev *pci_dev)
 {
 	struct eea_pci_device *ep_dev = pci_get_drvdata(pci_dev);
+	struct eea_device *edev;
+
+	edev = &ep_dev->edev;
 
+	mutex_lock(&edev->ha_lock);
 	__eea_pci_remove(pci_dev, true);
+	mutex_unlock(&edev->ha_lock);
 
 	kfree(ep_dev);
 }
diff --git a/drivers/net/ethernet/alibaba/eea/eea_pci.h b/drivers/net/ethernet/alibaba/eea/eea_pci.h
index d793128e556c..cdddb465d956 100644
--- a/drivers/net/ethernet/alibaba/eea/eea_pci.h
+++ b/drivers/net/ethernet/alibaba/eea/eea_pci.h
@@ -10,6 +10,7 @@
 
 #include <linux/pci.h>
 
+#include "eea_net.h"
 #include "eea_ring.h"
 
 struct eea_pci_cap {
@@ -34,6 +35,12 @@ struct eea_device {
 
 	u64 features;
 
+	bool ha_reset;
+	bool ha_reset_netdev_running;
+
+	/* ha lock for the race between ha work and pci remove */
+	struct mutex ha_lock;
+
 	u32 rx_num;
 	u32 tx_num;
 	u32 db_blk_size;
@@ -47,7 +54,14 @@ int eea_device_reset(struct eea_device *dev);
 void eea_device_ready(struct eea_device *dev);
 void eea_pci_active_aq(struct eea_ring *ering);
 
+int eea_pci_request_irq(struct eea_ring *ering,
+			irqreturn_t (*callback)(int irq, void *data),
+			void *data);
+void eea_pci_free_irq(struct eea_ring *ering, void *data);
+
 u64 eea_pci_device_ts(struct eea_device *edev);
 
+int eea_pci_set_affinity(struct eea_ring *ering,
+			 const struct cpumask *cpu_mask);
 void __iomem *eea_pci_db_addr(struct eea_device *edev, u32 off);
 #endif
diff --git a/drivers/net/ethernet/alibaba/eea/eea_rx.c b/drivers/net/ethernet/alibaba/eea/eea_rx.c
new file mode 100644
index 000000000000..756a1a94961a
--- /dev/null
+++ b/drivers/net/ethernet/alibaba/eea/eea_rx.c
@@ -0,0 +1,763 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Driver for Alibaba Elastic Ethernet Adapter.
+ *
+ * Copyright (C) 2025 Alibaba Inc.
+ */
+
+#include <net/netdev_rx_queue.h>
+#include <net/page_pool/helpers.h>
+
+#include "eea_adminq.h"
+#include "eea_net.h"
+#include "eea_ring.h"
+
+#define EEA_SETUP_F_NAPI         BIT(0)
+#define EEA_SETUP_F_IRQ          BIT(1)
+#define EEA_ENABLE_F_NAPI        BIT(2)
+
+#define EEA_PAGE_FRAGS_NUM 1024
+
+#define EEA_RX_BUF_ALIGN 128
+
+struct eea_rx_ctx {
+	void *buf;
+
+	u32 len;
+	u32 hdr_len;
+
+	u16 flags;
+	bool more;
+
+	u32 frame_sz;
+
+	struct eea_rx_meta *meta;
+};
+
+static struct eea_rx_meta *eea_rx_meta_get(struct eea_net_rx *rx)
+{
+	struct eea_rx_meta *meta;
+
+	if (!rx->free)
+		return NULL;
+
+	meta = rx->free;
+	rx->free = meta->next;
+
+	return meta;
+}
+
+static void eea_rx_meta_put(struct eea_net_rx *rx, struct eea_rx_meta *meta)
+{
+	meta->next = rx->free;
+	rx->free = meta;
+}
+
+static void eea_free_rx_buffer(struct eea_net_rx *rx, struct eea_rx_meta *meta)
+{
+	u32 drain_count;
+
+	drain_count = EEA_PAGE_FRAGS_NUM - meta->frags;
+
+	if (page_pool_unref_page(meta->page, drain_count) == 0)
+		page_pool_put_unrefed_page(rx->pp, meta->page, -1, true);
+
+	meta->page = NULL;
+}
+
+static void meta_align_offset(struct eea_net_rx *rx, struct eea_rx_meta *meta)
+{
+	int h, b;
+
+	h = rx->headroom;
+	b = meta->offset + h;
+
+	/* For better performance, we align the buffer address to
+	 * EEA_RX_BUF_ALIGN, as required by the device design.
+	 */
+	b = ALIGN(b, EEA_RX_BUF_ALIGN);
+
+	meta->offset = b - h;
+}
+
+static int eea_alloc_rx_buffer(struct eea_net_rx *rx, struct eea_rx_meta *meta)
+{
+	struct page *page;
+
+	if (meta->page)
+		return 0;
+
+	page = page_pool_dev_alloc_pages(rx->pp);
+	if (!page)
+		return -ENOMEM;
+
+	page_pool_fragment_page(page, EEA_PAGE_FRAGS_NUM);
+
+	meta->page = page;
+	meta->dma = page_pool_get_dma_addr(page);
+	meta->offset = 0;
+	meta->frags = 0;
+
+	meta_align_offset(rx, meta);
+
+	return 0;
+}
+
+static void eea_consume_rx_buffer(struct eea_net_rx *rx,
+				  struct eea_rx_meta *meta,
+				  u32 consumed)
+{
+	int min;
+
+	meta->offset += consumed;
+	++meta->frags;
+
+	min = SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
+	min += rx->headroom;
+	min += ETH_DATA_LEN;
+
+	meta_align_offset(rx, meta);
+
+	if (min + meta->offset > PAGE_SIZE)
+		eea_free_rx_buffer(rx, meta);
+}
+
+static void eea_free_rx_hdr(struct eea_net_rx *rx)
+{
+	struct eea_net *enet = rx->enet;
+	struct eea_rx_meta *meta;
+	int i;
+
+	for (i = 0; i < enet->cfg.rx_ring_depth; ++i) {
+		meta = &rx->meta[i];
+		meta->hdr_addr = NULL;
+
+		if (!meta->hdr_page)
+			continue;
+
+		dma_unmap_page(enet->edev->dma_dev, meta->hdr_dma,
+			       PAGE_SIZE, DMA_FROM_DEVICE);
+		put_page(meta->hdr_page);
+
+		meta->hdr_page = NULL;
+	}
+}
+
+static int eea_alloc_rx_hdr(struct eea_net_init_ctx *ctx, struct eea_net_rx *rx)
+{
+	struct page *hdr_page = NULL;
+	struct eea_rx_meta *meta;
+	u32 offset = 0, hdrsize;
+	struct device *dmadev;
+	dma_addr_t dma;
+	int i;
+
+	dmadev = ctx->edev->dma_dev;
+	hdrsize = ctx->cfg.split_hdr;
+
+	for (i = 0; i < ctx->cfg.rx_ring_depth; ++i) {
+		meta = &rx->meta[i];
+
+		if (!hdr_page || offset + hdrsize > PAGE_SIZE) {
+			hdr_page = dev_alloc_page();
+			if (!hdr_page)
+				return -ENOMEM;
+
+			dma = dma_map_page(dmadev, hdr_page, 0, PAGE_SIZE,
+					   DMA_FROM_DEVICE);
+
+			if (unlikely(dma_mapping_error(dmadev, dma))) {
+				put_page(hdr_page);
+				return -ENOMEM;
+			}
+
+			offset = 0;
+			meta->hdr_page = hdr_page;
+			meta->dma = dma;
+		}
+
+		meta->hdr_dma = dma + offset;
+		meta->hdr_addr = page_address(hdr_page) + offset;
+		offset += hdrsize;
+	}
+
+	return 0;
+}
+
+static void eea_rx_meta_dma_sync_for_cpu(struct eea_net_rx *rx,
+					 struct eea_rx_meta *meta, u32 len)
+{
+	dma_sync_single_for_cpu(rx->enet->edev->dma_dev,
+				meta->dma + meta->offset + meta->headroom,
+				len, DMA_FROM_DEVICE);
+}
+
+static int eea_harden_check_overflow(struct eea_rx_ctx *ctx,
+				     struct eea_net *enet)
+{
+	if (unlikely(ctx->len > ctx->meta->truesize - ctx->meta->room)) {
+		pr_debug("%s: rx error: len %u exceeds truesize %u\n",
+			 enet->netdev->name, ctx->len,
+			 ctx->meta->truesize - ctx->meta->room);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int eea_harden_check_size(struct eea_rx_ctx *ctx, struct eea_net *enet)
+{
+	int err;
+
+	err = eea_harden_check_overflow(ctx, enet);
+	if (err)
+		return err;
+
+	if (unlikely(ctx->hdr_len + ctx->len < ETH_HLEN)) {
+		pr_debug("%s: short packet %u\n", enet->netdev->name, ctx->len);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static struct sk_buff *eea_build_skb(void *buf, u32 buflen, u32 headroom,
+				     u32 len)
+{
+	struct sk_buff *skb;
+
+	skb = build_skb(buf, buflen);
+	if (unlikely(!skb))
+		return NULL;
+
+	skb_reserve(skb, headroom);
+	skb_put(skb, len);
+
+	return skb;
+}
+
+static struct sk_buff *eea_rx_build_split_hdr_skb(struct eea_net_rx *rx,
+						  struct eea_rx_ctx *ctx)
+{
+	struct eea_rx_meta *meta = ctx->meta;
+	struct sk_buff *skb;
+	u32 truesize;
+
+	dma_sync_single_for_cpu(rx->enet->edev->dma_dev, meta->hdr_dma,
+				ctx->hdr_len, DMA_FROM_DEVICE);
+
+	skb = napi_alloc_skb(&rx->napi, ctx->hdr_len);
+	if (unlikely(!skb))
+		return NULL;
+
+	truesize = meta->headroom + ctx->len;
+
+	skb_put_data(skb, ctx->meta->hdr_addr, ctx->hdr_len);
+
+	if (ctx->len) {
+		skb_add_rx_frag(skb, 0, meta->page,
+				meta->offset + meta->headroom,
+				ctx->len, truesize);
+
+		eea_consume_rx_buffer(rx, meta, truesize);
+	}
+
+	skb_mark_for_recycle(skb);
+
+	return skb;
+}
+
+static struct sk_buff *eea_rx_build_skb(struct eea_net_rx *rx,
+					struct eea_rx_ctx *ctx)
+{
+	struct eea_rx_meta *meta = ctx->meta;
+	u32 len, shinfo_size, truesize;
+	struct sk_buff *skb;
+	struct page *page;
+	void *buf, *pkt;
+
+	page = meta->page;
+	if (!page)
+		return NULL;
+
+	shinfo_size = SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
+
+	buf = page_address(page) + meta->offset;
+	pkt = buf + meta->headroom;
+	len = ctx->len;
+	truesize = meta->headroom + ctx->len + shinfo_size;
+
+	skb = eea_build_skb(buf, truesize, pkt - buf, len);
+	if (unlikely(!skb))
+		return NULL;
+
+	eea_consume_rx_buffer(rx, meta, truesize);
+	skb_mark_for_recycle(skb);
+
+	return skb;
+}
+
+static int eea_skb_append_buf(struct eea_net_rx *rx, struct eea_rx_ctx *ctx)
+{
+	struct sk_buff *curr_skb = rx->pkt.curr_skb;
+	struct sk_buff *head_skb = rx->pkt.head_skb;
+	int num_skb_frags;
+	int offset;
+
+	if (!curr_skb)
+		curr_skb = head_skb;
+
+	num_skb_frags = skb_shinfo(curr_skb)->nr_frags;
+	if (unlikely(num_skb_frags == MAX_SKB_FRAGS)) {
+		struct sk_buff *nskb = alloc_skb(0, GFP_ATOMIC);
+
+		if (unlikely(!nskb))
+			return -ENOMEM;
+
+		if (curr_skb == head_skb)
+			skb_shinfo(curr_skb)->frag_list = nskb;
+		else
+			curr_skb->next = nskb;
+
+		curr_skb = nskb;
+		head_skb->truesize += nskb->truesize;
+		num_skb_frags = 0;
+
+		rx->pkt.curr_skb = curr_skb;
+	}
+
+	if (curr_skb != head_skb) {
+		head_skb->data_len += ctx->len;
+		head_skb->len += ctx->len;
+		head_skb->truesize += ctx->meta->truesize;
+	}
+
+	offset = ctx->meta->offset + ctx->meta->headroom;
+
+	skb_add_rx_frag(curr_skb, num_skb_frags, ctx->meta->page,
+			offset, ctx->len, ctx->meta->truesize);
+
+	eea_consume_rx_buffer(rx, ctx->meta, ctx->meta->headroom + ctx->len);
+
+	return 0;
+}
+
+static int process_remain_buf(struct eea_net_rx *rx, struct eea_rx_ctx *ctx)
+{
+	struct eea_net *enet = rx->enet;
+
+	if (eea_harden_check_overflow(ctx, enet))
+		goto err;
+
+	if (eea_skb_append_buf(rx, ctx))
+		goto err;
+
+	return 0;
+
+err:
+	dev_kfree_skb(rx->pkt.head_skb);
+	rx->pkt.do_drop = true;
+	rx->pkt.head_skb = NULL;
+	return 0;
+}
+
+static int process_first_buf(struct eea_net_rx *rx, struct eea_rx_ctx *ctx)
+{
+	struct eea_net *enet = rx->enet;
+	struct sk_buff *skb = NULL;
+
+	if (eea_harden_check_size(ctx, enet))
+		goto err;
+
+	rx->pkt.data_valid = ctx->flags & EEA_DESC_F_DATA_VALID;
+
+	if (ctx->hdr_len)
+		skb = eea_rx_build_split_hdr_skb(rx, ctx);
+	else
+		skb = eea_rx_build_skb(rx, ctx);
+
+	if (unlikely(!skb))
+		goto err;
+
+	rx->pkt.head_skb = skb;
+
+	return 0;
+
+err:
+	rx->pkt.do_drop = true;
+	return 0;
+}
+
+static void eea_submit_skb(struct eea_net_rx *rx, struct sk_buff *skb,
+			   struct eea_rx_cdesc *desc)
+{
+	struct eea_net *enet = rx->enet;
+
+	if (rx->pkt.data_valid)
+		skb->ip_summed = CHECKSUM_UNNECESSARY;
+
+	if (enet->cfg.ts_cfg.rx_filter == HWTSTAMP_FILTER_ALL)
+		skb_hwtstamps(skb)->hwtstamp = EEA_DESC_TS(desc) +
+			enet->hw_ts_offset;
+
+	skb_record_rx_queue(skb, rx->index);
+	skb->protocol = eth_type_trans(skb, enet->netdev);
+
+	napi_gro_receive(&rx->napi, skb);
+}
+
+static void eea_rx_desc_to_ctx(struct eea_net_rx *rx,
+			       struct eea_rx_ctx *ctx,
+			       struct eea_rx_cdesc *desc)
+{
+	ctx->meta = &rx->meta[le16_to_cpu(desc->id)];
+	ctx->len = le16_to_cpu(desc->len);
+	ctx->flags = le16_to_cpu(desc->flags);
+
+	ctx->hdr_len = 0;
+	if (ctx->flags & EEA_DESC_F_SPLIT_HDR)
+		ctx->hdr_len = le16_to_cpu(desc->len_ex) &
+			EEA_RX_CDESC_HDR_LEN_MASK;
+
+	ctx->more = ctx->flags & EEA_RING_DESC_F_MORE;
+}
+
+static int eea_cleanrx(struct eea_net_rx *rx, int budget,
+		       struct eea_rx_ctx *ctx)
+{
+	struct eea_rx_cdesc *desc;
+	struct eea_rx_meta *meta;
+	int packets;
+
+	for (packets = 0; packets < budget; ) {
+		desc = ering_cq_get_desc(rx->ering);
+		if (!desc)
+			break;
+
+		eea_rx_desc_to_ctx(rx, ctx, desc);
+
+		meta = ctx->meta;
+		ctx->buf = page_address(meta->page) + meta->offset +
+			meta->headroom;
+
+		if (unlikely(rx->pkt.do_drop))
+			goto skip;
+
+		eea_rx_meta_dma_sync_for_cpu(rx, meta, ctx->len);
+
+		if (!rx->pkt.idx)
+			process_first_buf(rx, ctx);
+		else
+			process_remain_buf(rx, ctx);
+
+		++rx->pkt.idx;
+
+		if (!ctx->more) {
+			if (likely(rx->pkt.head_skb))
+				eea_submit_skb(rx, rx->pkt.head_skb, desc);
+
+			++packets;
+		}
+
+skip:
+		eea_rx_meta_put(rx, meta);
+		ering_cq_ack_desc(rx->ering, 1);
+
+		if (!ctx->more)
+			memset(&rx->pkt, 0, sizeof(rx->pkt));
+	}
+
+	return packets;
+}
+
+static bool eea_rx_post(struct eea_net *enet, struct eea_net_rx *rx)
+{
+	u32 tailroom, headroom, room, len;
+	struct eea_rx_meta *meta;
+	struct eea_rx_desc *desc;
+	int err = 0, num = 0;
+	dma_addr_t addr;
+
+	tailroom = SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
+	headroom = rx->headroom;
+	room = headroom + tailroom;
+
+	while (true) {
+		meta = eea_rx_meta_get(rx);
+		if (!meta)
+			break;
+
+		err = eea_alloc_rx_buffer(rx, meta);
+		if (err) {
+			eea_rx_meta_put(rx, meta);
+			break;
+		}
+
+		len = PAGE_SIZE - meta->offset - room;
+		addr = meta->dma + meta->offset + headroom;
+
+		desc = ering_sq_alloc_desc(rx->ering, meta->id, true, 0);
+		desc->addr = cpu_to_le64(addr);
+		desc->len = cpu_to_le16(len);
+
+		if (meta->hdr_addr)
+			desc->hdr_addr = cpu_to_le64(meta->hdr_dma);
+
+		ering_sq_commit_desc(rx->ering);
+
+		meta->truesize = len + room;
+		meta->headroom = headroom;
+		meta->tailroom = tailroom;
+		meta->len = len;
+		++num;
+	}
+
+	if (num)
+		ering_kick(rx->ering);
+
+	/* true means busy, napi should be called again. */
+	return !!err;
+}
+
+int eea_poll(struct napi_struct *napi, int budget)
+{
+	struct eea_net_rx *rx = container_of(napi, struct eea_net_rx, napi);
+	struct eea_net_tx *tx = &rx->enet->tx[rx->index];
+	struct eea_net *enet = rx->enet;
+	struct eea_rx_ctx ctx = {};
+	bool busy = false;
+	u32 received;
+
+	eea_poll_tx(tx, budget);
+
+	received = eea_cleanrx(rx, budget, &ctx);
+
+	if (rx->ering->num_free > budget)
+		busy |= eea_rx_post(enet, rx);
+
+	busy |= received >= budget;
+
+	if (!busy) {
+		if (napi_complete_done(napi, received))
+			ering_irq_active(rx->ering, tx->ering);
+	}
+
+	if (busy)
+		return budget;
+
+	return budget - 1;
+}
+
+static void eea_free_rx_buffers(struct eea_net_rx *rx)
+{
+	struct eea_rx_meta *meta;
+	u32 i;
+
+	for (i = 0; i < rx->enet->cfg.rx_ring_depth; ++i) {
+		meta = &rx->meta[i];
+		if (!meta->page)
+			continue;
+
+		eea_free_rx_buffer(rx, meta);
+	}
+}
+
+static struct page_pool *eea_create_pp(struct eea_net_rx *rx,
+				       struct eea_net_init_ctx *ctx, u32 idx)
+{
+	struct page_pool_params pp_params = {0};
+
+	pp_params.order     = 0;
+	pp_params.flags     = PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV;
+	pp_params.pool_size = ctx->cfg.rx_ring_depth;
+	pp_params.nid       = dev_to_node(ctx->edev->dma_dev);
+	pp_params.dev       = ctx->edev->dma_dev;
+	pp_params.napi      = &rx->napi;
+	pp_params.netdev    = ctx->netdev;
+	pp_params.dma_dir   = DMA_FROM_DEVICE;
+	pp_params.max_len   = PAGE_SIZE;
+
+	return page_pool_create(&pp_params);
+}
+
+static void eea_destroy_page_pool(struct eea_net_rx *rx)
+{
+	if (rx->pp)
+		page_pool_destroy(rx->pp);
+}
+
+static irqreturn_t irq_handler(int irq, void *data)
+{
+	struct eea_net_rx *rx = data;
+
+	rx->irq_n++;
+
+	napi_schedule_irqoff(&rx->napi);
+
+	return IRQ_HANDLED;
+}
+
+void enet_rx_stop(struct eea_net_rx *rx)
+{
+	if (rx->flags & EEA_ENABLE_F_NAPI) {
+		rx->flags &= ~EEA_ENABLE_F_NAPI;
+		napi_disable(&rx->napi);
+	}
+}
+
+void enet_rx_start(struct eea_net_rx *rx)
+{
+	napi_enable(&rx->napi);
+	rx->flags |= EEA_ENABLE_F_NAPI;
+
+	local_bh_disable();
+	napi_schedule(&rx->napi);
+	local_bh_enable();
+}
+
+static int enet_irq_setup_for_q(struct eea_net_rx *rx)
+{
+	int err;
+
+	ering_irq_unactive(rx->ering);
+
+	err = eea_pci_request_irq(rx->ering, irq_handler, rx);
+	if (err)
+		return err;
+
+	rx->flags |= EEA_SETUP_F_IRQ;
+
+	return 0;
+}
+
+void eea_irq_free(struct eea_net_rx *rx)
+{
+	if (rx->flags & EEA_SETUP_F_IRQ) {
+		eea_pci_free_irq(rx->ering, rx);
+		rx->flags &= ~EEA_SETUP_F_IRQ;
+	}
+}
+
+int enet_rxtx_irq_setup(struct eea_net *enet, u32 qid, u32 num)
+{
+	struct eea_net_rx *rx;
+	int err, i;
+
+	for (i = 0; i < enet->cfg.rx_ring_num; i++) {
+		rx = enet->rx[i];
+
+		err = enet_irq_setup_for_q(rx);
+		if (err)
+			goto err;
+	}
+
+	return 0;
+
+err:
+	for (i = 0; i < enet->cfg.rx_ring_num; i++) {
+		rx = enet->rx[i];
+
+		eea_irq_free(rx);
+	}
+	return err;
+}
+
+void eea_free_rx(struct eea_net_rx *rx)
+{
+	if (!rx)
+		return;
+
+	if (rx->ering) {
+		ering_free(rx->ering);
+		rx->ering = NULL;
+	}
+
+	if (rx->meta) {
+		eea_free_rx_buffers(rx);
+		eea_free_rx_hdr(rx);
+		kvfree(rx->meta);
+		rx->meta = NULL;
+	}
+
+	if (rx->pp) {
+		eea_destroy_page_pool(rx);
+		rx->pp = NULL;
+	}
+
+	if (rx->flags & EEA_SETUP_F_NAPI) {
+		rx->flags &= ~EEA_SETUP_F_NAPI;
+		netif_napi_del(&rx->napi);
+	}
+
+	kfree(rx);
+}
+
+static void eea_rx_meta_init(struct eea_net_rx *rx, u32 num)
+{
+	struct eea_rx_meta *meta;
+	int i;
+
+	rx->free = NULL;
+
+	for (i = 0; i < num; ++i) {
+		meta = &rx->meta[i];
+		meta->id = i;
+		meta->next = rx->free;
+		rx->free = meta;
+	}
+}
+
+struct eea_net_rx *eea_alloc_rx(struct eea_net_init_ctx *ctx, u32 idx)
+{
+	struct eea_ring *ering;
+	struct eea_net_rx *rx;
+	int err;
+
+	rx = kzalloc(sizeof(*rx), GFP_KERNEL);
+	if (!rx)
+		return rx;
+
+	rx->index = idx;
+	sprintf(rx->name, "rx.%u", idx);
+
+	/* ering */
+	ering = ering_alloc(idx * 2, ctx->cfg.rx_ring_depth, ctx->edev,
+			    ctx->cfg.rx_sq_desc_size,
+			    ctx->cfg.rx_cq_desc_size,
+			    rx->name);
+	if (!ering)
+		goto err;
+
+	rx->ering = ering;
+
+	rx->dma_dev = ctx->edev->dma_dev;
+
+	/* meta */
+	rx->meta = kvcalloc(ctx->cfg.rx_ring_depth,
+			    sizeof(*rx->meta), GFP_KERNEL);
+	if (!rx->meta)
+		goto err;
+
+	eea_rx_meta_init(rx, ctx->cfg.rx_ring_depth);
+
+	if (ctx->cfg.split_hdr) {
+		err = eea_alloc_rx_hdr(ctx, rx);
+		if (err)
+			goto err;
+	}
+
+	rx->pp = eea_create_pp(rx, ctx, idx);
+	if (IS_ERR(rx->pp)) {
+		err = PTR_ERR(rx->pp);
+		rx->pp = NULL;
+		goto err;
+	}
+
+	netif_napi_add(ctx->netdev, &rx->napi, eea_poll);
+	rx->flags |= EEA_SETUP_F_NAPI;
+
+	return rx;
+err:
+	eea_free_rx(rx);
+	return NULL;
+}
diff --git a/drivers/net/ethernet/alibaba/eea/eea_tx.c b/drivers/net/ethernet/alibaba/eea/eea_tx.c
new file mode 100644
index 000000000000..4a03aaffd2b9
--- /dev/null
+++ b/drivers/net/ethernet/alibaba/eea/eea_tx.c
@@ -0,0 +1,380 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Driver for Alibaba Elastic Ethernet Adapter.
+ *
+ * Copyright (C) 2025 Alibaba Inc.
+ */
+
+#include <net/netdev_queues.h>
+
+#include "eea_net.h"
+#include "eea_pci.h"
+#include "eea_ring.h"
+
+struct eea_sq_free_stats {
+	u64 packets;
+	u64 bytes;
+};
+
+struct eea_tx_meta {
+	struct eea_tx_meta *next;
+
+	u32 id;
+
+	union {
+		struct sk_buff *skb;
+		void *data;
+	};
+
+	u32 num;
+
+	dma_addr_t dma_addr;
+	struct eea_tx_desc *desc;
+	u16 dma_len;
+};
+
+static struct eea_tx_meta *eea_tx_meta_get(struct eea_net_tx *tx)
+{
+	struct eea_tx_meta *meta;
+
+	if (!tx->free)
+		return NULL;
+
+	meta = tx->free;
+	tx->free = meta->next;
+
+	return meta;
+}
+
+static void eea_tx_meta_put_and_unmap(struct eea_net_tx *tx,
+				      struct eea_tx_meta *meta)
+{
+	struct eea_tx_meta *head;
+
+	head = meta;
+
+	while (true) {
+		dma_unmap_single(tx->dma_dev, meta->dma_addr,
+				 meta->dma_len, DMA_TO_DEVICE);
+
+		meta->data = NULL;
+
+		if (meta->next) {
+			meta = meta->next;
+			continue;
+		}
+
+		break;
+	}
+
+	meta->next = tx->free;
+	tx->free = head;
+}
+
+static void eea_meta_free_xmit(struct eea_net_tx *tx,
+			       struct eea_tx_meta *meta,
+			       bool in_napi,
+			       struct eea_tx_cdesc *desc,
+			       struct eea_sq_free_stats *stats)
+{
+	struct sk_buff *skb = meta->skb;
+
+	if (!skb) {
+		netdev_err(tx->enet->netdev,
+			   "tx meta->skb is null. id %d num: %d\n",
+			   meta->id, meta->num);
+		return;
+	}
+
+	if (unlikely((skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP) && desc)) {
+		struct skb_shared_hwtstamps ts = {};
+
+		ts.hwtstamp = EEA_DESC_TS(desc) + tx->enet->hw_ts_offset;
+		skb_tstamp_tx(skb, &ts);
+	}
+
+	stats->bytes += meta->skb->len;
+	napi_consume_skb(meta->skb, in_napi);
+}
+
+static u32 eea_clean_tx(struct eea_net_tx *tx)
+{
+	struct eea_sq_free_stats stats = {0};
+	struct eea_tx_cdesc *desc;
+	struct eea_tx_meta *meta;
+
+	while ((desc = ering_cq_get_desc(tx->ering))) {
+		++stats.packets;
+
+		meta = &tx->meta[le16_to_cpu(desc->id)];
+
+		eea_meta_free_xmit(tx, meta, true, desc, &stats);
+
+		ering_cq_ack_desc(tx->ering, meta->num);
+		eea_tx_meta_put_and_unmap(tx, meta);
+	}
+
+	return stats.packets;
+}
+
+int eea_poll_tx(struct eea_net_tx *tx, int budget)
+{
+	struct eea_net *enet = tx->enet;
+	u32 index = tx - enet->tx;
+	struct netdev_queue *txq;
+	u32 cleaned;
+
+	txq = netdev_get_tx_queue(enet->netdev, index);
+
+	__netif_tx_lock(txq, raw_smp_processor_id());
+
+	cleaned = eea_clean_tx(tx);
+
+	if (netif_tx_queue_stopped(txq) && cleaned > 0)
+		netif_tx_wake_queue(txq);
+
+	__netif_tx_unlock(txq);
+
+	return 0;
+}
+
+static int eea_fill_desc_from_skb(const struct sk_buff *skb,
+				  struct eea_ring *ering,
+				  struct eea_tx_desc *desc)
+{
+	if (skb_is_gso(skb)) {
+		struct skb_shared_info *sinfo = skb_shinfo(skb);
+
+		desc->gso_size = cpu_to_le16(sinfo->gso_size);
+		if (sinfo->gso_type & SKB_GSO_TCPV4)
+			desc->gso_type = EEA_TX_GSO_TCPV4;
+
+		else if (sinfo->gso_type & SKB_GSO_TCPV6)
+			desc->gso_type = EEA_TX_GSO_TCPV6;
+
+		else if (sinfo->gso_type & SKB_GSO_UDP_L4)
+			desc->gso_type = EEA_TX_GSO_UDP_L4;
+
+		else
+			return -EINVAL;
+
+		if (sinfo->gso_type & SKB_GSO_TCP_ECN)
+			desc->gso_type |= EEA_TX_GSO_ECN;
+	} else {
+		desc->gso_type = EEA_TX_GSO_NONE;
+	}
+
+	if (skb->ip_summed == CHECKSUM_PARTIAL) {
+		desc->csum_start = cpu_to_le16(skb_checksum_start_offset(skb));
+		desc->csum_offset = cpu_to_le16(skb->csum_offset);
+	}
+
+	return 0;
+}
+
+static struct eea_tx_meta *eea_tx_desc_fill(struct eea_net_tx *tx,
+					    dma_addr_t addr, u32 len,
+					    bool is_last, void *data, u16 flags)
+{
+	struct eea_tx_meta *meta;
+	struct eea_tx_desc *desc;
+
+	meta = eea_tx_meta_get(tx);
+
+	desc = ering_sq_alloc_desc(tx->ering, meta->id, is_last, flags);
+	desc->addr = cpu_to_le64(addr);
+	desc->len = cpu_to_le16(len);
+
+	meta->next     = NULL;
+	meta->dma_len  = len;
+	meta->dma_addr = addr;
+	meta->data     = data;
+	meta->num      = 1;
+	meta->desc     = desc;
+
+	return meta;
+}
+
+static int eea_tx_add_skb_frag(struct eea_net_tx *tx,
+			       struct eea_tx_meta *head_meta,
+			       const skb_frag_t *frag, bool is_last)
+{
+	u32 len = skb_frag_size(frag);
+	struct eea_tx_meta *meta;
+	dma_addr_t addr;
+
+	addr = skb_frag_dma_map(tx->dma_dev, frag, 0, len, DMA_TO_DEVICE);
+	if (unlikely(dma_mapping_error(tx->dma_dev, addr)))
+		return -ENOMEM;
+
+	meta = eea_tx_desc_fill(tx, addr, len, is_last, NULL, 0);
+
+	meta->next = head_meta->next;
+	head_meta->next = meta;
+
+	return 0;
+}
+
+static int eea_tx_post_skb(struct eea_net_tx *tx, struct sk_buff *skb)
+{
+	const struct skb_shared_info *shinfo = skb_shinfo(skb);
+	u32 hlen = skb_headlen(skb);
+	struct eea_tx_meta *meta;
+	dma_addr_t addr;
+	int i, err;
+	u16 flags;
+
+	addr = dma_map_single(tx->dma_dev, skb->data, hlen, DMA_TO_DEVICE);
+	if (unlikely(dma_mapping_error(tx->dma_dev, addr)))
+		return -ENOMEM;
+
+	flags = skb->ip_summed == CHECKSUM_PARTIAL ? EEA_DESC_F_DO_CSUM : 0;
+
+	meta = eea_tx_desc_fill(tx, addr, hlen, !shinfo->nr_frags, skb, flags);
+
+	if (eea_fill_desc_from_skb(skb, tx->ering, meta->desc))
+		goto err;
+
+	for (i = 0; i < shinfo->nr_frags; i++) {
+		const skb_frag_t *frag = &shinfo->frags[i];
+		bool is_last = i == (shinfo->nr_frags - 1);
+
+		err = eea_tx_add_skb_frag(tx, meta, frag, is_last);
+		if (err)
+			goto err;
+	}
+
+	meta->num = shinfo->nr_frags + 1;
+	ering_sq_commit_desc(tx->ering);
+
+	return 0;
+
+err:
+	ering_sq_cancel(tx->ering);
+	eea_tx_meta_put_and_unmap(tx, meta);
+	return -ENOMEM;
+}
+
+static void eea_tx_kick(struct eea_net_tx *tx)
+{
+	ering_kick(tx->ering);
+}
+
+netdev_tx_t eea_tx_xmit(struct sk_buff *skb, struct net_device *netdev)
+{
+	const struct skb_shared_info *shinfo = skb_shinfo(skb);
+	struct eea_net *enet = netdev_priv(netdev);
+	int qnum = skb_get_queue_mapping(skb);
+	struct eea_net_tx *tx = &enet->tx[qnum];
+	struct netdev_queue *txq;
+	int err, n;
+
+	txq = netdev_get_tx_queue(netdev, qnum);
+
+	n = shinfo->nr_frags + 1;
+
+	if (!netif_txq_maybe_stop(txq, tx->ering->num_free, n, n)) {
+		/* maybe the previous skbs was xmitted without kick. */
+		eea_tx_kick(tx);
+		return NETDEV_TX_BUSY;
+	}
+
+	skb_tx_timestamp(skb);
+
+	err = eea_tx_post_skb(tx, skb);
+	if (unlikely(err))
+		dev_kfree_skb_any(skb);
+
+	if (!netdev_xmit_more() || netif_xmit_stopped(txq))
+		eea_tx_kick(tx);
+
+	return NETDEV_TX_OK;
+}
+
+static void eea_free_meta(struct eea_net_tx *tx)
+{
+	struct eea_sq_free_stats stats;
+	struct eea_tx_meta *meta;
+	int i;
+
+	while ((meta = eea_tx_meta_get(tx)))
+		meta->skb = NULL;
+
+	for (i = 0; i < tx->enet->cfg.tx_ring_num; i++) {
+		meta = &tx->meta[i];
+
+		if (!meta->skb)
+			continue;
+
+		eea_meta_free_xmit(tx, meta, false, NULL, &stats);
+
+		meta->skb = NULL;
+	}
+
+	kvfree(tx->meta);
+	tx->meta = NULL;
+}
+
+void eea_tx_timeout(struct net_device *netdev, unsigned int txqueue)
+{
+	struct netdev_queue *txq = netdev_get_tx_queue(netdev, txqueue);
+	struct eea_net *priv = netdev_priv(netdev);
+	struct eea_net_tx *tx = &priv->tx[txqueue];
+
+	netdev_err(netdev, "TX timeout on queue: %u, tx: %s, ering: 0x%x, %u usecs ago\n",
+		   txqueue, tx->name, tx->ering->index,
+		   jiffies_to_usecs(jiffies - READ_ONCE(txq->trans_start)));
+}
+
+void eea_free_tx(struct eea_net_tx *tx)
+{
+	if (!tx)
+		return;
+
+	if (tx->ering) {
+		ering_free(tx->ering);
+		tx->ering = NULL;
+	}
+
+	if (tx->meta)
+		eea_free_meta(tx);
+}
+
+int eea_alloc_tx(struct eea_net_init_ctx *ctx, struct eea_net_tx *tx, u32 idx)
+{
+	struct eea_tx_meta *meta;
+	struct eea_ring *ering;
+	u32 i;
+
+	sprintf(tx->name, "tx.%u", idx);
+
+	ering = ering_alloc(idx * 2 + 1, ctx->cfg.tx_ring_depth, ctx->edev,
+			    ctx->cfg.tx_sq_desc_size,
+			    ctx->cfg.tx_cq_desc_size,
+			    tx->name);
+	if (!ering)
+		goto err;
+
+	tx->ering = ering;
+	tx->index = idx;
+	tx->dma_dev = ctx->edev->dma_dev;
+
+	/* meta */
+	tx->meta = kvcalloc(ctx->cfg.tx_ring_depth,
+			    sizeof(*tx->meta), GFP_KERNEL);
+	if (!tx->meta)
+		goto err;
+
+	for (i = 0; i < ctx->cfg.tx_ring_depth; ++i) {
+		meta = &tx->meta[i];
+		meta->id = i;
+		meta->next = tx->free;
+		tx->free = meta;
+	}
+
+	return 0;
+
+err:
+	eea_free_tx(tx);
+	return -ENOMEM;
+}
-- 
2.32.0.3.g01195cf9f



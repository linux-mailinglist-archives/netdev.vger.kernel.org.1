Return-Path: <netdev+bounces-257811-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aCcYHIRNiGk/ngQAu9opvQ
	(envelope-from <netdev+bounces-257811-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 08 Feb 2026 09:47:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D6F7410820E
	for <lists+netdev@lfdr.de>; Sun, 08 Feb 2026 09:46:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 161F33017390
	for <lists+netdev@lfdr.de>; Sun,  8 Feb 2026 08:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7AC633CE81;
	Sun,  8 Feb 2026 08:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="XiuRuXey"
X-Original-To: netdev@vger.kernel.org
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99E233C180
	for <netdev@vger.kernel.org>; Sun,  8 Feb 2026 08:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770540385; cv=none; b=Lv/xiDrstkwT+rizcPVHMrKGxeCvjufjvXxwnOhs0AmmAAH07dXz/15dIrfONJRxBitAn3Ql49KGV8StGK16AZRaqD5Bx+IGesYNYeqUO9xiazXjHwubg0muK8QYhztkZOzTLeJZBB3iXM5GeQCwtkDQvTHP6N1aW1pj3Ki/UhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770540385; c=relaxed/simple;
	bh=t4F23zePWP5OiOtuVdzpQonrmAFEmBfG3w88oYk+RYM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RqntSR9l3VXpASNqNyCwPw3IK3YK++99lRB1Lx2Iz40H7fcTyFiINr9EP9tOlL5InMa4BKU4OrUDAB4Im4K0r8rAOqw87M2QyNA5aJMssv6PRe2rKE6IJDVP9lIsx/KqcfZ/ptvVnIOYnlRJlfVVqx39xlVK8BjSwG/5wClFYW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=XiuRuXey; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1770540377; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=26GH7J+SfEvgOSHEsrmWQCGTAY/9GSLusYEggogeOVo=;
	b=XiuRuXeyOMB3pbBcYlK2ZyKOiEeSQLafYnnckmGEGIBiHpF1Aqj0dJKcWYb0EPJHygKTDLX5+W0Dcdxb8jhxOAiTZR4+4FmZGDkK/9bDBdlGxOfzvF9xftdj9CPlkuiABWEhxTXKccGfGTIT/cp6nbNG34sSTTYrwkfAmV6/e+g=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WykSl79_1770540376 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sun, 08 Feb 2026 16:46:16 +0800
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
	Dong Yibo <dong100@mucse.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>,
	Dust Li <dust.li@linux.alibaba.com>
Subject: [PATCH net-next v26 4/8] eea: create/destroy rx,tx queues for netdevice open and stop
Date: Sun,  8 Feb 2026 16:46:09 +0800
Message-Id: <20260208084613.2658-5-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20260208084613.2658-1-xuanzhuo@linux.alibaba.com>
References: <20260208084613.2658-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: 5481c6b77b7b
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-6.16 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257811-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xuanzhuo@linux.alibaba.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,linux.alibaba.com,linux.dev,mucse.com,gmail.com];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: D6F7410820E
X-Rspamd-Action: no action

Add basic driver framework for the Alibaba Elastic Ethernet Adapter(EEA).

This commit introduces the implementation for the netdevice open and
stop.

Reviewed-by: Dust Li <dust.li@linux.alibaba.com>
Reviewed-by: Philo Lu <lulie@linux.alibaba.com>
Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/ethernet/alibaba/eea/Makefile  |   4 +-
 drivers/net/ethernet/alibaba/eea/eea_net.c | 531 ++++++++++++++++++++-
 drivers/net/ethernet/alibaba/eea/eea_net.h |  47 ++
 drivers/net/ethernet/alibaba/eea/eea_pci.c | 182 ++++++-
 drivers/net/ethernet/alibaba/eea/eea_pci.h |  13 +
 drivers/net/ethernet/alibaba/eea/eea_rx.c  | 254 ++++++++++
 drivers/net/ethernet/alibaba/eea/eea_tx.c  | 114 +++++
 7 files changed, 1140 insertions(+), 5 deletions(-)
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
index 31cb9ca5b408..1dc93722b44b 100644
--- a/drivers/net/ethernet/alibaba/eea/eea_net.c
+++ b/drivers/net/ethernet/alibaba/eea/eea_net.c
@@ -18,6 +18,451 @@
 
 #define EEA_SPLIT_HDR_SIZE 128
 
+static irqreturn_t eea_irq_handler(int irq, void *data)
+{
+	struct eea_irq_blk *blk = data;
+
+	napi_schedule_irqoff(&blk->napi);
+
+	return IRQ_HANDLED;
+}
+
+static void eea_free_irq_blk(struct eea_net *enet)
+{
+	struct eea_irq_blk *blk;
+	u32 num;
+	int i;
+
+	if (!enet->irq_blks)
+		return;
+
+	num = enet->edev->rx_num;
+
+	for (i = 0; i < num; i++) {
+		blk = &enet->irq_blks[i];
+
+		if (blk->ready)
+			eea_pci_free_irq(blk);
+
+		blk->ready = false;
+	}
+
+	kvfree(enet->irq_blks);
+	enet->irq_blks = NULL;
+}
+
+static int eea_alloc_irq_blks(struct eea_net *enet, u32 num)
+{
+	struct eea_device *edev = enet->edev;
+	struct eea_irq_blk *blk, *irq_blks;
+	int i, err;
+
+	irq_blks = kvcalloc(num, sizeof(*blk), GFP_KERNEL);
+	if (!irq_blks)
+		return -ENOMEM;
+
+	for (i = 0; i < num; i++) {
+		blk = &irq_blks[i];
+		blk->idx = i;
+
+		/* vec 0 is for error notify. */
+		blk->msix_vec = i + 1;
+
+		err = eea_pci_request_irq(edev, blk, eea_irq_handler);
+		if (err)
+			goto err_free_irq_blk;
+
+		blk->ready = true;
+	}
+
+	enet->irq_blks = irq_blks;
+	return 0;
+
+err_free_irq_blk:
+	eea_free_irq_blk(enet);
+	return err;
+}
+
+static int eea_update_queues(struct eea_net *enet)
+{
+	return netif_set_real_num_queues(enet->netdev, enet->cfg.tx_ring_num,
+					 enet->cfg.rx_ring_num);
+}
+
+void eea_init_ctx(struct eea_net *enet, struct eea_net_init_ctx *ctx)
+{
+	memset(ctx, 0, sizeof(*ctx));
+
+	ctx->netdev = enet->netdev;
+	ctx->edev = enet->edev;
+	ctx->cfg = enet->cfg;
+}
+
+static void eea_bind_q_and_cfg(struct eea_net *enet,
+			       struct eea_net_init_ctx *ctx)
+{
+	struct eea_irq_blk *blk;
+	struct eea_net_rx *rx;
+	struct eea_net_tx *tx;
+	int i;
+
+	enet->cfg = ctx->cfg;
+	enet->rx = ctx->rx;
+	enet->tx = ctx->tx;
+
+	for (i = 0; i < ctx->cfg.rx_ring_num; i++) {
+		blk = &enet->irq_blks[i];
+
+		rx = ctx->rx[i];
+		tx = &ctx->tx[i];
+
+		rx->enet = enet;
+		rx->napi = &blk->napi;
+		rx->ering->msix_vec = blk->msix_vec;
+
+		tx->enet = enet;
+		tx->ering->msix_vec = blk->msix_vec;
+
+		blk->rx = rx;
+	}
+}
+
+static void eea_unbind_q_and_cfg(struct eea_net *enet,
+				 struct eea_net_init_ctx *ctx)
+{
+	struct eea_irq_blk *blk;
+	struct eea_net_rx *rx;
+	int i;
+
+	ctx->cfg = enet->cfg;
+	ctx->rx = enet->rx;
+	ctx->tx = enet->tx;
+
+	enet->rx = NULL;
+	enet->tx = NULL;
+
+	for (i = 0; i < ctx->cfg.rx_ring_num; i++) {
+		blk = &enet->irq_blks[i];
+
+		rx = ctx->rx[i];
+
+		rx->napi = NULL;
+
+		blk->rx = NULL;
+	}
+}
+
+static void eea_free_rxtx_q_mem(struct eea_net_init_ctx *ctx)
+{
+	struct eea_net_rx *rx;
+	struct eea_net_tx *tx;
+	int i;
+
+	for (i = 0; i < ctx->cfg.rx_ring_num; i++) {
+		rx = ctx->rx[i];
+		tx = &ctx->tx[i];
+
+		eea_free_rx(rx, &ctx->cfg);
+		eea_free_tx(tx, &ctx->cfg);
+	}
+
+	kvfree(ctx->rx);
+	kvfree(ctx->tx);
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
+		return -ENOMEM;
+
+	ctx->rx = kvcalloc(ctx->cfg.rx_ring_num, sizeof(*ctx->rx), GFP_KERNEL);
+	if (!ctx->rx)
+		goto err_free_tx;
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
+			goto err_free;
+
+		ctx->rx[i] = rx;
+
+		tx = ctx->tx + i;
+		err = eea_alloc_tx(ctx, tx, i);
+		if (err)
+			goto err_free;
+	}
+
+	return 0;
+
+err_free:
+	for (i = 0; i < ctx->cfg.rx_ring_num; i++) {
+		rx = ctx->rx[i];
+		tx = ctx->tx + i;
+
+		eea_free_rx(rx, &ctx->cfg);
+		eea_free_tx(tx, &ctx->cfg);
+	}
+
+	kvfree(ctx->rx);
+
+err_free_tx:
+	kvfree(ctx->tx);
+	return -ENOMEM;
+}
+
+static int eea_hw_active_ring(struct eea_net *enet)
+{
+	return eea_adminq_create_q(enet, /* qidx = */ 0,
+				   enet->cfg.rx_ring_num +
+				   enet->cfg.tx_ring_num, 0);
+}
+
+static int eea_hw_unactive_ring(struct eea_net *enet)
+{
+	int err;
+
+	err = eea_adminq_destroy_all_q(enet);
+	if (err)
+		netdev_warn(enet->netdev, "unactive rxtx ring failed.\n");
+
+	return err;
+}
+
+/* stop rx napi, stop tx queue. */
+static void eea_stop_rxtx(struct net_device *netdev)
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
+}
+
+static void eea_start_rxtx(struct eea_net *enet)
+{
+	int i;
+
+	for (i = 0; i < enet->cfg.rx_ring_num; i++)
+		enet_rx_start(enet->rx[i]);
+
+	netif_tx_start_all_queues(enet->netdev);
+	netif_carrier_on(enet->netdev);
+
+	enet->started = true;
+}
+
+static int eea_netdev_stop(struct net_device *netdev)
+{
+	struct eea_net *enet = netdev_priv(netdev);
+	struct eea_net_init_ctx ctx;
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
+	eea_hw_unactive_ring(enet);
+	eea_unbind_q_and_cfg(enet, &ctx);
+	eea_free_rxtx_q_mem(&ctx);
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
+	eea_init_ctx(enet, &ctx);
+
+	err = eea_alloc_rxtx_q_mem(&ctx);
+	if (err)
+		goto err_done;
+
+	eea_bind_q_and_cfg(enet, &ctx);
+
+	err = eea_update_queues(enet);
+	if (err)
+		goto err_free_q;
+
+	err = eea_hw_active_ring(enet);
+	if (err)
+		goto err_free_q;
+
+	eea_start_rxtx(enet);
+
+	return 0;
+
+err_free_q:
+	eea_unbind_q_and_cfg(enet, &ctx);
+	eea_free_rxtx_q_mem(&ctx);
+
+err_done:
+	return err;
+}
+
+/* resources: ring, buffers, irq */
+int eea_reset_hw_resources(struct eea_net *enet, struct eea_net_init_ctx *ctx)
+{
+	struct eea_net_init_ctx ctx_old = {0};
+	int err;
+
+	if (!netif_running(enet->netdev) || !enet->started) {
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
+	eea_stop_rxtx(enet->netdev);
+	eea_hw_unactive_ring(enet);
+
+	eea_unbind_q_and_cfg(enet, &ctx_old);
+	eea_bind_q_and_cfg(enet, ctx);
+
+	err = eea_update_queues(enet);
+	if (err) {
+		netdev_err(enet->netdev,
+			   "eea reset: set real num queues failed. err %d\n",
+			   err);
+		goto err_bind_old;
+	}
+
+	err = eea_hw_active_ring(enet);
+	if (err) {
+		netdev_err(enet->netdev, "eea reset: active new ring. err %d\n",
+			   err);
+		eea_unbind_q_and_cfg(enet, ctx);
+		goto err_free_q;
+	}
+
+	eea_start_rxtx(enet);
+	eea_free_rxtx_q_mem(&ctx_old);
+	return 0;
+
+err_bind_old:
+	eea_unbind_q_and_cfg(enet, ctx);
+	eea_bind_q_and_cfg(enet, &ctx_old);
+	err = eea_hw_active_ring(enet);
+	if (err) {
+		netdev_err(enet->netdev, "eea reset: active old ring. err %d\n",
+			   err);
+		eea_unbind_q_and_cfg(enet, &ctx_old);
+		goto err_free_q;
+	}
+
+	eea_start_rxtx(enet);
+	eea_free_rxtx_q_mem(ctx);
+	return 0;
+
+err_free_q:
+
+	/* An exception occurred at the hardware level, and there's not much we
+	 * can do about it -- we can only release the resources first.
+	 */
+	eea_free_rxtx_q_mem(ctx);
+	eea_free_rxtx_q_mem(&ctx_old);
+	enet->started = false;
+	return err;
+}
+
+int eea_queues_check_and_reset(struct eea_device *edev)
+{
+	struct eea_aq_queue_status *qstatus;
+	struct eea_aq_dev_status *dstatus;
+	struct eea_aq_queue_status *qs;
+	struct eea_net_init_ctx ctx;
+	bool need_reset = false;
+	int num, i, err = 0;
+
+	rtnl_lock();
+
+	if (!netif_running(edev->enet->netdev))
+		goto err_unlock;
+
+	num = edev->enet->cfg.tx_ring_num * 2 + 1;
+
+	dstatus = eea_adminq_dev_status(edev->enet);
+	if (!dstatus) {
+		netdev_warn(edev->enet->netdev, "query queue status failed.\n");
+		err = -ENOMEM;
+		goto err_unlock;
+	}
+
+	if (le16_to_cpu(dstatus->link_status) == EEA_LINK_DOWN_STATUS) {
+		eea_netdev_stop(edev->enet->netdev);
+		edev->enet->link_err = EEA_LINK_ERR_LINK_DOWN;
+		netdev_warn(edev->enet->netdev, "device link is down. stop device.\n");
+		goto err_free;
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
+		eea_init_ctx(edev->enet, &ctx);
+		err = eea_reset_hw_resources(edev->enet, &ctx);
+	}
+
+err_free:
+	kfree(dstatus);
+
+err_unlock:
+	rtnl_unlock();
+	return err;
+}
+
 static void eea_update_cfg(struct eea_net *enet,
 			   struct eea_device *edev,
 			   struct eea_aq_cfg *hwcfg)
@@ -116,14 +561,19 @@ static int eea_netdev_init_features(struct net_device *netdev,
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
 {
 	struct net_device *netdev;
 	struct eea_net *enet;
+	int err;
 
 	netdev = alloc_etherdev_mq(sizeof(struct eea_net), pairs);
 	if (!netdev) {
@@ -140,14 +590,65 @@ static struct eea_net *eea_netdev_alloc(struct eea_device *edev, u32 pairs)
 	enet->edev = edev;
 	edev->enet = enet;
 
+	err = eea_alloc_irq_blks(enet, pairs);
+	if (err) {
+		dev_err(edev->dma_dev,
+			"eea_alloc_irq_blks failed with pairs %d\n", pairs);
+		free_netdev(netdev);
+		return NULL;
+	}
+
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
+	err = eea_alloc_irq_blks(enet, edev->rx_num);
+	if (err) {
+		eea_destroy_adminq(enet);
+		return -ENOMEM;
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
@@ -168,6 +669,7 @@ int eea_net_probe(struct eea_device *edev)
 	if (err)
 		goto err_reset_dev;
 
+	eea_update_ts_off(edev, enet);
 	netif_carrier_off(enet->netdev);
 
 	netdev_dbg(enet->netdev, "eea probe success.\n");
@@ -179,10 +681,31 @@ int eea_net_probe(struct eea_device *edev)
 	eea_destroy_adminq(enet);
 
 err_free_netdev:
+	eea_free_irq_blk(enet);
 	free_netdev(enet->netdev);
 	return err;
 }
 
+static void eea_net_ha_reset_remove(struct eea_net *enet,
+				    struct eea_device *edev,
+				    struct net_device *netdev)
+{
+	rtnl_lock();
+	edev->ha_reset_netdev_running = false;
+	if (netif_running(enet->netdev)) {
+		eea_netdev_stop(enet->netdev);
+		enet->link_err = EEA_LINK_ERR_HA_RESET_DEV;
+		edev->ha_reset_netdev_running = true;
+	}
+	rtnl_unlock();
+
+	eea_device_reset(edev);
+	eea_destroy_adminq(enet);
+	eea_free_irq_blk(enet);
+
+	enet->edev = NULL;
+}
+
 void eea_net_remove(struct eea_device *edev)
 {
 	struct net_device *netdev;
@@ -191,12 +714,16 @@ void eea_net_remove(struct eea_device *edev)
 	enet = edev->enet;
 	netdev = enet->netdev;
 
+	if (edev->ha_reset) {
+		eea_net_ha_reset_remove(enet, edev, netdev);
+		return;
+	}
+
 	unregister_netdev(netdev);
-	netdev_dbg(enet->netdev, "eea removed.\n");
 
 	eea_device_reset(edev);
-
 	eea_destroy_adminq(enet);
+	eea_free_irq_blk(enet);
 
 	free_netdev(netdev);
 }
diff --git a/drivers/net/ethernet/alibaba/eea/eea_net.h b/drivers/net/ethernet/alibaba/eea/eea_net.h
index ab487bc88af2..6f9c89c180de 100644
--- a/drivers/net/ethernet/alibaba/eea/eea_net.h
+++ b/drivers/net/ethernet/alibaba/eea/eea_net.h
@@ -18,6 +18,8 @@
 #define EEA_VER_MINOR		0
 #define EEA_VER_SUB_MINOR	0
 
+struct eea_tx_meta;
+
 struct eea_net_tx {
 	struct eea_net *enet;
 
@@ -101,6 +103,18 @@ struct eea_net_cfg {
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
@@ -109,6 +123,17 @@ enum {
 	EEA_LINK_ERR_LINK_DOWN,
 };
 
+struct eea_irq_blk {
+	struct napi_struct napi;
+	u16 msix_vec;
+	bool ready;
+	struct eea_net_rx *rx;
+	char irq_name[32];
+	int irq;
+	int idx;
+
+};
+
 struct eea_net {
 	struct eea_device *edev;
 	struct net_device *netdev;
@@ -121,6 +146,8 @@ struct eea_net {
 	struct eea_net_cfg cfg;
 	struct eea_net_cfg cfg_hw;
 
+	struct eea_irq_blk *irq_blks;
+
 	u32 link_err;
 
 	bool started;
@@ -134,4 +161,24 @@ struct eea_net {
 int eea_net_probe(struct eea_device *edev);
 void eea_net_remove(struct eea_device *edev);
 
+int eea_reset_hw_resources(struct eea_net *enet, struct eea_net_init_ctx *ctx);
+void eea_init_ctx(struct eea_net *enet, struct eea_net_init_ctx *ctx);
+int eea_queues_check_and_reset(struct eea_device *edev);
+
+/* rx apis */
+void enet_rx_stop(struct eea_net_rx *rx);
+void enet_rx_start(struct eea_net_rx *rx);
+
+void eea_free_rx(struct eea_net_rx *rx, struct eea_net_cfg *cfg);
+struct eea_net_rx *eea_alloc_rx(struct eea_net_init_ctx *ctx, u32 idx);
+
+/* tx apis */
+int eea_poll_tx(struct eea_net_tx *tx, int budget);
+netdev_tx_t eea_tx_xmit(struct sk_buff *skb, struct net_device *netdev);
+
+void eea_tx_timeout(struct net_device *netdev, unsigned int txqueue);
+
+void eea_free_tx(struct eea_net_tx *tx, struct eea_net_cfg *cfg);
+int eea_alloc_tx(struct eea_net_init_ctx *ctx, struct eea_net_tx *tx, u32 idx);
+
 #endif
diff --git a/drivers/net/ethernet/alibaba/eea/eea_pci.c b/drivers/net/ethernet/alibaba/eea/eea_pci.c
index 97efac753cfb..e42b0298eebb 100644
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
@@ -250,6 +259,150 @@ void eea_pci_active_aq(struct eea_ring *ering, int msix_vec)
 				    cfg_read32(ep_dev->reg, aq_db_off));
 }
 
+void eea_pci_free_irq(struct eea_irq_blk *blk)
+{
+	irq_update_affinity_hint(blk->irq, NULL);
+	free_irq(blk->irq, blk);
+}
+
+int eea_pci_request_irq(struct eea_device *edev, struct eea_irq_blk *blk,
+			irqreturn_t (*callback)(int irq, void *data))
+{
+	struct eea_pci_device *ep_dev = edev->ep_dev;
+	int irq;
+
+	snprintf(blk->irq_name, sizeof(blk->irq_name), "eea-q%d@%s", blk->idx,
+		 pci_name(ep_dev->pci_dev));
+
+	irq = pci_irq_vector(ep_dev->pci_dev, blk->msix_vec);
+
+	blk->irq = irq;
+
+	return request_irq(irq, callback, IRQF_NO_AUTOEN, blk->irq_name, blk);
+}
+
+static void eea_ha_handle_reset(struct eea_pci_device *ep_dev)
+{
+	struct eea_device *edev;
+	struct pci_dev *pci_dev;
+	u16 reset;
+	int err;
+
+	if (!ep_dev->reset_pos) {
+		eea_queues_check_and_reset(&ep_dev->edev);
+		return;
+	}
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
+			err = __eea_pci_probe(pci_dev, ep_dev);
+			if (err)
+				dev_err(&ep_dev->pci_dev->dev,
+					"ha: re-setup failed.\n");
+
+			edev->ha_reset = false;
+			mutex_unlock(&edev->ha_lock);
+		} else {
+			dev_warn(&ep_dev->pci_dev->dev,
+				 "ha device reset: trylock failed.\n");
+		}
+		return;
+	}
+
+	eea_queues_check_and_reset(&ep_dev->edev);
+}
+
+/* ha handle code */
+static void eea_ha_handle_work(struct work_struct *work)
+{
+	struct eea_pci_device *ep_dev;
+
+	ep_dev = container_of(work, struct eea_pci_device, ha_handle_work);
+
+	/* Ha interrupt is triggered, so there maybe some error, we may need to
+	 * reset the device or reset some queues.
+	 */
+	dev_warn(&ep_dev->pci_dev->dev, "recv ha interrupt.\n");
+
+	eea_ha_handle_reset(ep_dev);
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
@@ -284,10 +437,13 @@ static int eea_init_device(struct eea_device *edev)
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
 		return err;
@@ -296,19 +452,31 @@ static int __eea_pci_probe(struct pci_dev *pci_dev,
 	if (err)
 		goto err_pci_rel;
 
+	err = eea_pci_ha_init(edev, pci_dev);
+	if (err)
+		goto err_net_rm;
+
 	return 0;
 
+err_net_rm:
+	eea_net_remove(edev);
+
 err_pci_rel:
 	eea_pci_release_resource(ep_dev);
 	return err;
 }
 
-static void __eea_pci_remove(struct pci_dev *pci_dev)
+static void __eea_pci_remove(struct pci_dev *pci_dev, bool flush_ha_work)
 {
 	struct eea_pci_device *ep_dev = pci_get_drvdata(pci_dev);
 	struct device *dev = get_device(&ep_dev->pci_dev->dev);
 	struct eea_device *edev = &ep_dev->edev;
 
+	eea_pci_free_ha_irq(edev);
+
+	if (flush_ha_work)
+		flush_work(&ep_dev->ha_handle_work);
+
 	eea_net_remove(edev);
 
 	pci_disable_sriov(pci_dev);
@@ -336,8 +504,11 @@ static int eea_pci_probe(struct pci_dev *pci_dev,
 
 	ep_dev->pci_dev = pci_dev;
 
+	mutex_init(&edev->ha_lock);
+
 	err = __eea_pci_probe(pci_dev, ep_dev);
 	if (err) {
+		mutex_destroy(&edev->ha_lock);
 		pci_set_drvdata(pci_dev, NULL);
 		kfree(ep_dev);
 	}
@@ -348,10 +519,17 @@ static int eea_pci_probe(struct pci_dev *pci_dev,
 static void eea_pci_remove(struct pci_dev *pci_dev)
 {
 	struct eea_pci_device *ep_dev = pci_get_drvdata(pci_dev);
+	struct eea_device *edev;
+
+	edev = &ep_dev->edev;
 
-	__eea_pci_remove(pci_dev);
+	mutex_lock(&edev->ha_lock);
+	__eea_pci_remove(pci_dev, true);
+	mutex_unlock(&edev->ha_lock);
 
 	pci_set_drvdata(pci_dev, NULL);
+
+	mutex_destroy(&edev->ha_lock);
 	kfree(ep_dev);
 }
 
diff --git a/drivers/net/ethernet/alibaba/eea/eea_pci.h b/drivers/net/ethernet/alibaba/eea/eea_pci.h
index d240dc2dae9b..8dfb860165dc 100644
--- a/drivers/net/ethernet/alibaba/eea/eea_pci.h
+++ b/drivers/net/ethernet/alibaba/eea/eea_pci.h
@@ -10,8 +10,11 @@
 
 #include <linux/pci.h>
 
+#include "eea_net.h"
 #include "eea_ring.h"
 
+struct eea_irq_blk;
+
 struct eea_pci_cap {
 	__u8 cap_vndr;
 	__u8 cap_next;
@@ -34,6 +37,12 @@ struct eea_device {
 
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
@@ -47,6 +56,10 @@ int eea_device_reset(struct eea_device *dev);
 void eea_device_ready(struct eea_device *dev);
 void eea_pci_active_aq(struct eea_ring *ering, int msix_vec);
 
+int eea_pci_request_irq(struct eea_device *edev, struct eea_irq_blk *blk,
+			irqreturn_t (*callback)(int irq, void *data));
+void eea_pci_free_irq(struct eea_irq_blk *blk);
+
 u64 eea_pci_device_ts(struct eea_device *edev);
 
 void __iomem *eea_pci_db_addr(struct eea_device *edev, u32 off);
diff --git a/drivers/net/ethernet/alibaba/eea/eea_rx.c b/drivers/net/ethernet/alibaba/eea/eea_rx.c
new file mode 100644
index 000000000000..7c9bb513191b
--- /dev/null
+++ b/drivers/net/ethernet/alibaba/eea/eea_rx.c
@@ -0,0 +1,254 @@
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
+#define EEA_ENABLE_F_NAPI        BIT(0)
+
+#define EEA_PAGE_FRAGS_NUM 1024
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
+static void eea_free_rx_hdr(struct eea_net_rx *rx, struct eea_net_cfg *cfg)
+{
+	struct eea_rx_meta *meta;
+	int i;
+
+	for (i = 0; i < cfg->rx_ring_depth; ++i) {
+		meta = &rx->meta[i];
+		meta->hdr_addr = NULL;
+
+		if (!meta->hdr_page)
+			continue;
+
+		dma_unmap_page(rx->dma_dev, meta->hdr_dma, PAGE_SIZE,
+			       DMA_FROM_DEVICE);
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
+static int eea_poll(struct napi_struct *napi, int budget)
+{
+	/* Empty function; will be implemented in a subsequent commit. */
+	return 0;
+}
+
+static void eea_free_rx_buffers(struct eea_net_rx *rx, struct eea_net_cfg *cfg)
+{
+	struct eea_rx_meta *meta;
+	u32 i;
+
+	for (i = 0; i < cfg->rx_ring_depth; ++i) {
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
+	pp_params.napi      = rx->napi;
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
+void enet_rx_stop(struct eea_net_rx *rx)
+{
+	if (rx->flags & EEA_ENABLE_F_NAPI) {
+		rx->flags &= ~EEA_ENABLE_F_NAPI;
+		disable_irq(rx->enet->irq_blks[rx->index].irq);
+		napi_disable(rx->napi);
+		netif_napi_del(rx->napi);
+	}
+}
+
+void enet_rx_start(struct eea_net_rx *rx)
+{
+	netif_napi_add(rx->enet->netdev, rx->napi, eea_poll);
+
+	napi_enable(rx->napi);
+
+	rx->flags |= EEA_ENABLE_F_NAPI;
+
+	local_bh_disable();
+	napi_schedule(rx->napi);
+	local_bh_enable();
+
+	enable_irq(rx->enet->irq_blks[rx->index].irq);
+}
+
+/* Maybe called before enet_bind_new_q_and_cfg. So the cfg must be
+ * passed.
+ */
+void eea_free_rx(struct eea_net_rx *rx, struct eea_net_cfg *cfg)
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
+		eea_free_rx_buffers(rx, cfg);
+		eea_free_rx_hdr(rx, cfg);
+		kvfree(rx->meta);
+		rx->meta = NULL;
+	}
+
+	if (rx->pp) {
+		eea_destroy_page_pool(rx);
+		rx->pp = NULL;
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
+		goto err_free_rx;
+
+	rx->ering = ering;
+
+	rx->dma_dev = ctx->edev->dma_dev;
+
+	/* meta */
+	rx->meta = kvcalloc(ctx->cfg.rx_ring_depth,
+			    sizeof(*rx->meta), GFP_KERNEL);
+	if (!rx->meta)
+		goto err_free_rx;
+
+	eea_rx_meta_init(rx, ctx->cfg.rx_ring_depth);
+
+	if (ctx->cfg.split_hdr) {
+		err = eea_alloc_rx_hdr(ctx, rx);
+		if (err)
+			goto err_free_rx;
+	}
+
+	rx->pp = eea_create_pp(rx, ctx, idx);
+	if (IS_ERR(rx->pp)) {
+		err = PTR_ERR(rx->pp);
+		rx->pp = NULL;
+		goto err_free_rx;
+	}
+
+	return rx;
+
+err_free_rx:
+	eea_free_rx(rx, &ctx->cfg);
+	return NULL;
+}
diff --git a/drivers/net/ethernet/alibaba/eea/eea_tx.c b/drivers/net/ethernet/alibaba/eea/eea_tx.c
new file mode 100644
index 000000000000..1475fca44b6e
--- /dev/null
+++ b/drivers/net/ethernet/alibaba/eea/eea_tx.c
@@ -0,0 +1,114 @@
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
+int eea_poll_tx(struct eea_net_tx *tx, int budget)
+{
+	/* Empty function; will be implemented in a subsequent commit. */
+	return 0;
+}
+
+netdev_tx_t eea_tx_xmit(struct sk_buff *skb, struct net_device *netdev)
+{
+	/* Empty function; will be implemented in a subsequent commit. */
+	return NETDEV_TX_OK;
+}
+
+static void eea_free_meta(struct eea_net_tx *tx, struct eea_net_cfg *cfg)
+{
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
+/* Maybe called before enet_bind_new_q_and_cfg. So the cfg must be
+ * passed.
+ */
+void eea_free_tx(struct eea_net_tx *tx, struct eea_net_cfg *cfg)
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
+		eea_free_meta(tx, cfg);
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
+		goto err_free_tx;
+
+	tx->ering = ering;
+	tx->index = idx;
+	tx->dma_dev = ctx->edev->dma_dev;
+
+	/* meta */
+	tx->meta = kvcalloc(ctx->cfg.tx_ring_depth,
+			    sizeof(*tx->meta), GFP_KERNEL);
+	if (!tx->meta)
+		goto err_free_tx;
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
+err_free_tx:
+	eea_free_tx(tx, &ctx->cfg);
+	return -ENOMEM;
+}
-- 
2.32.0.3.g01195cf9f



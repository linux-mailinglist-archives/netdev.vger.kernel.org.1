Return-Path: <netdev+bounces-71314-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D357D852F8F
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 12:36:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16249B2474C
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 11:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CE1A4F610;
	Tue, 13 Feb 2024 11:34:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311713A1C8
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 11:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707824094; cv=none; b=IhL6ToYnBHi8GRNg5MgYVcTROxgNHMU9r86rIAImf2kdu2HudTy8QNd86Pb5jEEolh4S24jiXeqAkp74QjhGtm3HoYp9CdIkwEgh0bhXcmSeHEMba3vNLcmmrLVG+VJmHWEobwywI4CmuLlo+/rL3Ns3XisexBKm7R2OCO7w1UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707824094; c=relaxed/simple;
	bh=a2xmEEhpflsxDDcnBL1twQujV6bdf3hnMmyI3SJKLTo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qTJ3afxsMaIROAbM2j9cz+xhoB/x8ER9Mdwu3+4SujQKXAeifRFHF2nawrtT3G53NKX4NSgkzn9XfgC/eQ/+LR7QEElywqJn+/+8fXid0MXytH4xaHSzCcDXnzJFDE5xJaVgdVV6/C6d0lU+YVdVb0XR8VpsXRnr99duSngzqs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1rZr3n-00019n-Fk
	for netdev@vger.kernel.org; Tue, 13 Feb 2024 12:34:47 +0100
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1rZr3j-000TVN-Au
	for netdev@vger.kernel.org; Tue, 13 Feb 2024 12:34:43 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 0358828D6B3
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 11:34:42 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id D284828D656;
	Tue, 13 Feb 2024 11:34:40 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 5f679a80;
	Tue, 13 Feb 2024 11:34:39 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Markus Schneider-Pargmann <msp@baylibre.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 14/23] can: m_can: Use the workqueue as queue
Date: Tue, 13 Feb 2024 12:25:17 +0100
Message-ID: <20240213113437.1884372-15-mkl@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213113437.1884372-1-mkl@pengutronix.de>
References: <20240213113437.1884372-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

From: Markus Schneider-Pargmann <msp@baylibre.com>

The current implementation uses the workqueue for peripheral chips to
submit work. Only a single work item is queued and used at any time.

To be able to keep more than one transmit in flight at a time, prepare
the workqueue to support multiple transmits at the same time.

Each work item now has a separate storage for a skb and a pointer to
cdev. This assures that each workitem can be processed individually.

The workqueue is replaced by an ordered workqueue which makes sure that
only a single worker processes the items queued on the workqueue. Also
items are ordered by the order they were enqueued. This removes most of
the concurrency the workqueue normally offers. It is not necessary for
this driver.

The cleanup functions have to be adopted a bit to handle this new
mechanism.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
Link: https://lore.kernel.org/all/20240207093220.2681425-11-msp@baylibre.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/m_can/m_can.c | 109 ++++++++++++++++++++--------------
 drivers/net/can/m_can/m_can.h |  14 ++++-
 2 files changed, 76 insertions(+), 47 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index a8e7b910ef81..8d7dbf2eb46c 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -485,17 +485,18 @@ static void m_can_clean(struct net_device *net)
 {
 	struct m_can_classdev *cdev = netdev_priv(net);
 
-	if (cdev->tx_skb) {
-		u32 putidx = 0;
+	if (cdev->tx_ops) {
+		for (int i = 0; i != cdev->tx_fifo_size; ++i) {
+			if (!cdev->tx_ops[i].skb)
+				continue;
 
-		net->stats.tx_errors++;
-		if (cdev->version > 30)
-			putidx = FIELD_GET(TXFQS_TFQPI_MASK,
-					   m_can_read(cdev, M_CAN_TXFQS));
-
-		can_free_echo_skb(cdev->net, putidx, NULL);
-		cdev->tx_skb = NULL;
+			net->stats.tx_errors++;
+			cdev->tx_ops[i].skb = NULL;
+		}
 	}
+
+	for (int i = 0; i != cdev->can.echo_skb_max; ++i)
+		can_free_echo_skb(cdev->net, i, NULL);
 }
 
 /* For peripherals, pass skb to rx-offload, which will push skb from
@@ -1685,8 +1686,9 @@ static int m_can_close(struct net_device *dev)
 	m_can_clk_stop(cdev);
 	free_irq(dev->irq, dev);
 
+	m_can_clean(dev);
+
 	if (cdev->is_peripheral) {
-		cdev->tx_skb = NULL;
 		destroy_workqueue(cdev->tx_wq);
 		cdev->tx_wq = NULL;
 		can_rx_offload_disable(&cdev->offload);
@@ -1713,20 +1715,18 @@ static int m_can_next_echo_skb_occupied(struct net_device *dev, u32 putidx)
 	return !!cdev->can.echo_skb[next_idx];
 }
 
-static netdev_tx_t m_can_tx_handler(struct m_can_classdev *cdev)
+static netdev_tx_t m_can_tx_handler(struct m_can_classdev *cdev,
+				    struct sk_buff *skb)
 {
-	struct canfd_frame *cf = (struct canfd_frame *)cdev->tx_skb->data;
+	struct canfd_frame *cf = (struct canfd_frame *)skb->data;
 	u8 len_padded = DIV_ROUND_UP(cf->len, 4);
 	struct m_can_fifo_element fifo_element;
 	struct net_device *dev = cdev->net;
-	struct sk_buff *skb = cdev->tx_skb;
 	u32 cccr, fdflags;
 	u32 txfqs;
 	int err;
 	u32 putidx;
 
-	cdev->tx_skb = NULL;
-
 	/* Generate ID field for TX buffer Element */
 	/* Common to all supported M_CAN versions */
 	if (cf->can_id & CAN_EFF_FLAG) {
@@ -1850,10 +1850,31 @@ static netdev_tx_t m_can_tx_handler(struct m_can_classdev *cdev)
 
 static void m_can_tx_work_queue(struct work_struct *ws)
 {
-	struct m_can_classdev *cdev = container_of(ws, struct m_can_classdev,
-						   tx_work);
+	struct m_can_tx_op *op = container_of(ws, struct m_can_tx_op, work);
+	struct m_can_classdev *cdev = op->cdev;
+	struct sk_buff *skb = op->skb;
 
-	m_can_tx_handler(cdev);
+	op->skb = NULL;
+	m_can_tx_handler(cdev, skb);
+}
+
+static void m_can_tx_queue_skb(struct m_can_classdev *cdev, struct sk_buff *skb)
+{
+	cdev->tx_ops[cdev->next_tx_op].skb = skb;
+	queue_work(cdev->tx_wq, &cdev->tx_ops[cdev->next_tx_op].work);
+
+	++cdev->next_tx_op;
+	if (cdev->next_tx_op >= cdev->tx_fifo_size)
+		cdev->next_tx_op = 0;
+}
+
+static netdev_tx_t m_can_start_peripheral_xmit(struct m_can_classdev *cdev,
+					       struct sk_buff *skb)
+{
+	netif_stop_queue(cdev->net);
+	m_can_tx_queue_skb(cdev, skb);
+
+	return NETDEV_TX_OK;
 }
 
 static netdev_tx_t m_can_start_xmit(struct sk_buff *skb,
@@ -1864,30 +1885,15 @@ static netdev_tx_t m_can_start_xmit(struct sk_buff *skb,
 	if (can_dev_dropped_skb(dev, skb))
 		return NETDEV_TX_OK;
 
-	if (cdev->is_peripheral) {
-		if (cdev->tx_skb) {
-			netdev_err(dev, "hard_xmit called while tx busy\n");
-			return NETDEV_TX_BUSY;
-		}
-
-		if (cdev->can.state == CAN_STATE_BUS_OFF) {
-			m_can_clean(dev);
-		} else {
-			/* Need to stop the queue to avoid numerous requests
-			 * from being sent.  Suggested improvement is to create
-			 * a queueing mechanism that will queue the skbs and
-			 * process them in order.
-			 */
-			cdev->tx_skb = skb;
-			netif_stop_queue(cdev->net);
-			queue_work(cdev->tx_wq, &cdev->tx_work);
-		}
-	} else {
-		cdev->tx_skb = skb;
-		return m_can_tx_handler(cdev);
+	if (cdev->can.state == CAN_STATE_BUS_OFF) {
+		m_can_clean(cdev->net);
+		return NETDEV_TX_OK;
 	}
 
-	return NETDEV_TX_OK;
+	if (cdev->is_peripheral)
+		return m_can_start_peripheral_xmit(cdev, skb);
+	else
+		return m_can_tx_handler(cdev, skb);
 }
 
 static enum hrtimer_restart hrtimer_callback(struct hrtimer *timer)
@@ -1927,15 +1933,17 @@ static int m_can_open(struct net_device *dev)
 
 	/* register interrupt handler */
 	if (cdev->is_peripheral) {
-		cdev->tx_skb = NULL;
-		cdev->tx_wq = alloc_workqueue("mcan_wq",
-					      WQ_FREEZABLE | WQ_MEM_RECLAIM, 0);
+		cdev->tx_wq = alloc_ordered_workqueue("mcan_wq",
+						      WQ_FREEZABLE | WQ_MEM_RECLAIM);
 		if (!cdev->tx_wq) {
 			err = -ENOMEM;
 			goto out_wq_fail;
 		}
 
-		INIT_WORK(&cdev->tx_work, m_can_tx_work_queue);
+		for (int i = 0; i != cdev->tx_fifo_size; ++i) {
+			cdev->tx_ops[i].cdev = cdev;
+			INIT_WORK(&cdev->tx_ops[i].work, m_can_tx_work_queue);
+		}
 
 		err = request_threaded_irq(dev->irq, NULL, m_can_isr,
 					   IRQF_ONESHOT,
@@ -2228,6 +2236,19 @@ int m_can_class_register(struct m_can_classdev *cdev)
 {
 	int ret;
 
+	cdev->tx_fifo_size = max(1, min(cdev->mcfg[MRAM_TXB].num,
+					cdev->mcfg[MRAM_TXE].num));
+	if (cdev->is_peripheral) {
+		cdev->tx_ops =
+			devm_kzalloc(cdev->dev,
+				     cdev->tx_fifo_size * sizeof(*cdev->tx_ops),
+				     GFP_KERNEL);
+		if (!cdev->tx_ops) {
+			dev_err(cdev->dev, "Failed to allocate tx_ops for workqueue\n");
+			return -ENOMEM;
+		}
+	}
+
 	if (cdev->pm_clock_support) {
 		ret = m_can_clk_start(cdev);
 		if (ret)
diff --git a/drivers/net/can/m_can/m_can.h b/drivers/net/can/m_can/m_can.h
index 0de42fc5ef1e..be1d2119bd53 100644
--- a/drivers/net/can/m_can/m_can.h
+++ b/drivers/net/can/m_can/m_can.h
@@ -70,6 +70,12 @@ struct m_can_ops {
 	int (*init)(struct m_can_classdev *cdev);
 };
 
+struct m_can_tx_op {
+	struct m_can_classdev *cdev;
+	struct work_struct work;
+	struct sk_buff *skb;
+};
+
 struct m_can_classdev {
 	struct can_priv can;
 	struct can_rx_offload offload;
@@ -80,8 +86,6 @@ struct m_can_classdev {
 	struct clk *cclk;
 
 	struct workqueue_struct *tx_wq;
-	struct work_struct tx_work;
-	struct sk_buff *tx_skb;
 	struct phy *transceiver;
 
 	ktime_t irq_timer_wait;
@@ -102,7 +106,11 @@ struct m_can_classdev {
 	u32 tx_coalesce_usecs_irq;
 
 	// Store this internally to avoid fetch delays on peripheral chips
-	int tx_fifo_putidx;
+	u32 tx_fifo_putidx;
+
+	struct m_can_tx_op *tx_ops;
+	int tx_fifo_size;
+	int next_tx_op;
 
 	struct mram_cfg mcfg[MRAM_CFG_NUM];
 
-- 
2.43.0




Return-Path: <netdev+bounces-69751-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FDFC84C782
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 10:36:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF5A81F2930E
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 09:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D85B32C6AA;
	Wed,  7 Feb 2024 09:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="3beO/wrM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928192E856
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 09:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707298370; cv=none; b=obGF4s6jNhwUCV1HaDc2edjR068nD1WoHSSPy+5D3na3pOC37sYBYCCImUCqLWEmaVHjCMo0I2cKukupyy7yCK6qwUrxGwywYfWpQRPyOjFpdZMpNo5/xV63lJDPv0BTLpVOdPphca5hu5MigNznMVL/azeq9FDCDhf8etZyB2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707298370; c=relaxed/simple;
	bh=NYJ3A2y67U2m+v+KhNwTl8S8kTZvtCbeohEtdOffeYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UwZF4Mfr+MNVnXlX+pyfi5iqWYZO6+gvlslFZbmByehvPxltbIQ0rnMsS3eIWxQJaHf3L0LSuodhrEldP/GQ2/yC/kP0jn8/KNx0OaZ0hMGAjNUsGaIV5yNsLFRfk3Ra/Q9S/nZpkY3Oo7NIvWzs5Ebiaa86Z7WM1Kuwx6Cnn+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=3beO/wrM; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a3510d79ae9so47859266b.0
        for <netdev@vger.kernel.org>; Wed, 07 Feb 2024 01:32:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1707298367; x=1707903167; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uKZ3BPJz8PAmJCZaBIlEGMQvKGyQYSxuujjqsIx4zUk=;
        b=3beO/wrM/AGU7WHQzOQTbJg3rY2s8VeDh8wu2h5e/n2hRfS9i3FRRDJcxeQrGmxEQB
         0vAS1WBqu9yDqrJOBMrGHxHUCC19kEhx/mwY6TBFdPvQEhUqXBboSn6EE88yjTXqYAeZ
         e32bszNa+L9vd1yGGpxtcMB2BoSo5YQRgEKK+eeJ2zOCbCpJdyjRlUdlh1+UsJtA3PU9
         XgBW3F/Z9ZhKwxGAOfhjY7H7Tirzw75VDjTd4tat2pVL3xC/UBxVY/B0C7rmaEfD9blg
         H3LWaBxHc8m1cXBM4iyJo5uKpvUzVn5vSVhXgkphGzPQModd1n1u+d/AIqRKTa/ksGwh
         blJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707298367; x=1707903167;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uKZ3BPJz8PAmJCZaBIlEGMQvKGyQYSxuujjqsIx4zUk=;
        b=aW3ISV0mBkrGbnhKIk9MV2nz5MhCCQE2B1S/Y3P6Wm+aLegIfbzDOZCLqR8iGZrEDi
         sH70f5MMXHmmh4V5LrlkFeIJp3n5GjQToPukCas6kf9aP49KyhhX7SF2n8tr4RBhBCoi
         oTI+NuYsBrPpEilB66XMhXbe+Xy47bTiLkM9tFo8RoFqlhTjxlTuHU/tvU5jcE7jGds3
         3LqfRl7qTug8rbGD8bVI9ptP7sX8ek/o/9LSVroJJW81oDt1kXBynOrd6Cf44fqdIt9i
         lLcCJdDp7Z4EYarvsX1c8DaBaXbJhRV0SdAIpCcmH96Mt4T3b/vPODaus/gY52OyZZqa
         /Z7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWa3kZtQVMOqa0FWCRANWHBzh5SGHDmnOwEXwpy36uH13owPy2mnKXJUiWF41jv4KRGnAGHDbaMHYaEbYTErqyz3YaKwFCw
X-Gm-Message-State: AOJu0Yyg8PNCfuy66vtPW3ndOpWYTP0cLauyHaAmiyyCTkQKmmsfD0qj
	AVD3/WYyXuqPasqIRbU1+2sAEsFG/nWX7pq9YAf8UfZELw5GfjGaLG43ez5PiCc=
X-Google-Smtp-Source: AGHT+IGpEgpcST3wE1g4CM2/7qsgYdty7Fxya6Z5Tnz+jN5nKSe5jA/EPZPg+GTDgR8e/hYs2C48lQ==
X-Received: by 2002:a17:906:a457:b0:a37:2576:79f9 with SMTP id cb23-20020a170906a45700b00a37257679f9mr3564299ejb.2.1707298366961;
        Wed, 07 Feb 2024 01:32:46 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV4ckXwS1ua8BB7mYK2JuX5RpJt2C8XTl7t0RACFE848UlmDKjd9snlaT9UnYsORUElPYx67iN4wONI+sK5+0xXSWr/30eyo6fnQluvljRKGMo3IP8yChLBlmNRRYAiW0jU/kq2htZCyrLRwxoTnXjg4DxH1q4oYeUofgtUBZEb/0OaabGwFPNGK1m9gQx/56Jo+d5+jOKVn2yvqLzawy4mWxZj/hrhaCjul9uDYt6dojxHH0xqS07/jN1Eg7zQlZ8DCBESqRVnTvtfTB0PY8htI5pxxt33K80OVlsD9mqy1a2AfX0yemM5ZNDFl+reX7deKlbY+Sp9/OIrKQ91BrQODHbjouRiR6ERVlnrWcRWqxiWzJxLNuIqQu+h8l/Dn4l9Tb+OdMs8leSvGCRQRVVogr4HSohNewEsX64u69vj4DpPHZEix7ofLmR7
Received: from blmsp.fritz.box ([2001:4091:a246:821e:6f3b:6b50:4762:8343])
        by smtp.gmail.com with ESMTPSA id qo9-20020a170907874900b00a388e24f533sm122336ejc.148.2024.02.07.01.32.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 01:32:46 -0800 (PST)
From: Markus Schneider-Pargmann <msp@baylibre.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
	Wolfgang Grandegger <wg@grandegger.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Tony Lindgren <tony@atomide.com>,
	Judith Mendez <jm@ti.com>
Cc: Vincent MAILHOL <mailhol.vincent@wanadoo.fr>,
	Simon Horman <horms@kernel.org>,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Julien Panis <jpanis@baylibre.com>,
	Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH 10/14] can: m_can: Use the workqueue as queue
Date: Wed,  7 Feb 2024 10:32:16 +0100
Message-ID: <20240207093220.2681425-11-msp@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207093220.2681425-1-msp@baylibre.com>
References: <20240207093220.2681425-1-msp@baylibre.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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



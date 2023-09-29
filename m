Return-Path: <netdev+bounces-37046-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B38807B3483
	for <lists+netdev@lfdr.de>; Fri, 29 Sep 2023 16:13:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 8F9B31C20A44
	for <lists+netdev@lfdr.de>; Fri, 29 Sep 2023 14:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D3BB4E29B;
	Fri, 29 Sep 2023 14:13:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34DAA4B235
	for <netdev@vger.kernel.org>; Fri, 29 Sep 2023 14:13:28 +0000 (UTC)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DE241BE
	for <netdev@vger.kernel.org>; Fri, 29 Sep 2023 07:13:24 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-4066241289bso1832945e9.0
        for <netdev@vger.kernel.org>; Fri, 29 Sep 2023 07:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1695996803; x=1696601603; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FE3oDEDqgLswKU+5J4LYo4ANf4rALFlCrjxbNb+GIJc=;
        b=dddfecjHbtjdyMuiCHR2wAJaPoXVEawvmWfVX5TEdwIVMnIzfDYAlmb8agqWEzjQtU
         MrP9YPNxXSqxM5rBoHG4BVz+eeVahrxvuFT7aKGteU2XbQOYlBM1TUVKafYLyWUSrIG+
         CnxIjWqO+AmjOwH+SvCzDo9SVZrduDDITwawMknpvWbVRlO1GbsuGKagpeiBtU4iqRaI
         3+/HqwH8NIetuYcu3HuWuOW/Q9XBJN56Y9P6/w3+S6d2oRs8qiTcUQhOB6zTguKlkfwv
         zsnn+s0MhCdpabW+SQOGrtIEm1+aSFYWDyiyaTtO9KG3BRGC4+wLv1S+bsWrjVAQ5rDX
         iyGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695996803; x=1696601603;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FE3oDEDqgLswKU+5J4LYo4ANf4rALFlCrjxbNb+GIJc=;
        b=e9cOtoo09qSlCm8Xf4395Ky9e26mY2R8Uscrks623M7py34QLhr7FGkou24kr7qmM0
         xtn5KL8hdGVEcDAetK8Y0pEStVUD8umI02g/08u1YWooiUolCmkBrKEFl8gl3GZ+HEym
         uzkh+WSOGIMhK+B/R3u/wLthxFsYs8808WpN1TWc4KYoTJ4zqSY0NCQmNv/ucfhh7fbb
         R9/jDPxvU0h5poRmZ5lIW59bukbv3Zv/kT++cCE2mBVaztLYIzLkRG1opHqVzNWB7sgS
         cH6Lbcs0t/DMGWDMQ/FJAJgFG0SNfCZXQ4n5LtzaI9b/QtYoVEOtbziH0SPKgLuQcDXG
         kVhQ==
X-Gm-Message-State: AOJu0YyFeqM3YY/skpQ6fj7fLltGnjjFGfPvtthMBOpDHX/YZBsmTRCq
	JWCdl4S8JHPPykEDnFvd1cQ1+g==
X-Google-Smtp-Source: AGHT+IFATDLmqS6Xu8RD3l1grxpJ5bki/q3AWXgm3nILIPPayIRPsMVCzHUhvFiGFQSQ/DWP1eemeg==
X-Received: by 2002:a7b:ca53:0:b0:405:3b1f:968b with SMTP id m19-20020a7bca53000000b004053b1f968bmr4056008wml.21.1695996802803;
        Fri, 29 Sep 2023 07:13:22 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4091:a246:8222:dbda:9cd9:39cc:f174])
        by smtp.gmail.com with ESMTPSA id t25-20020a7bc3d9000000b00405391f485fsm1513068wmj.41.2023.09.29.07.13.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 07:13:22 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
	Wolfgang Grandegger <wg@grandegger.com>
Cc: Vincent MAILHOL <mailhol.vincent@wanadoo.fr>,
	Simon Horman <simon.horman@corigine.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Julien Panis <jpanis@baylibre.com>,
	Judith Mendez <jm@ti.com>,
	Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH v6 11/14] can: m_can: Introduce a tx_fifo_in_flight counter
Date: Fri, 29 Sep 2023 16:13:01 +0200
Message-Id: <20230929141304.3934380-12-msp@baylibre.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230929141304.3934380-1-msp@baylibre.com>
References: <20230929141304.3934380-1-msp@baylibre.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Keep track of the number of transmits in flight.

This patch prepares the driver to control the network interface queue
based on this counter. By itself this counter be
implemented with an atomic, but as we need to do other things in the
critical sections later I am using a spinlock instead.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
---
 drivers/net/can/m_can/m_can.c | 41 ++++++++++++++++++++++++++++++++++-
 drivers/net/can/m_can/m_can.h |  4 ++++
 2 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 1c3dc5e347b5..3ecd071abacb 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -483,6 +483,7 @@ static u32 m_can_get_timestamp(struct m_can_classdev *cdev)
 static void m_can_clean(struct net_device *net)
 {
 	struct m_can_classdev *cdev = netdev_priv(net);
+	unsigned long irqflags;
 
 	for (int i = 0; i != cdev->tx_fifo_size; ++i) {
 		if (!cdev->tx_ops[i].skb)
@@ -494,6 +495,10 @@ static void m_can_clean(struct net_device *net)
 
 	for (int i = 0; i != cdev->can.echo_skb_max; ++i)
 		can_free_echo_skb(cdev->net, i, NULL);
+
+	spin_lock_irqsave(&cdev->tx_handling_spinlock, irqflags);
+	cdev->tx_fifo_in_flight = 0;
+	spin_unlock_irqrestore(&cdev->tx_handling_spinlock, irqflags);
 }
 
 /* For peripherals, pass skb to rx-offload, which will push skb from
@@ -1064,6 +1069,24 @@ static void m_can_tx_update_stats(struct m_can_classdev *cdev,
 	stats->tx_packets++;
 }
 
+static void m_can_finish_tx(struct m_can_classdev *cdev, int transmitted)
+{
+	unsigned long irqflags;
+
+	spin_lock_irqsave(&cdev->tx_handling_spinlock, irqflags);
+	cdev->tx_fifo_in_flight -= transmitted;
+	spin_unlock_irqrestore(&cdev->tx_handling_spinlock, irqflags);
+}
+
+static void m_can_start_tx(struct m_can_classdev *cdev)
+{
+	unsigned long irqflags;
+
+	spin_lock_irqsave(&cdev->tx_handling_spinlock, irqflags);
+	++cdev->tx_fifo_in_flight;
+	spin_unlock_irqrestore(&cdev->tx_handling_spinlock, irqflags);
+}
+
 static int m_can_echo_tx_event(struct net_device *dev)
 {
 	u32 txe_count = 0;
@@ -1073,6 +1096,7 @@ static int m_can_echo_tx_event(struct net_device *dev)
 	int i = 0;
 	int err = 0;
 	unsigned int msg_mark;
+	int processed = 0;
 
 	struct m_can_classdev *cdev = netdev_priv(dev);
 
@@ -1102,12 +1126,15 @@ static int m_can_echo_tx_event(struct net_device *dev)
 
 		/* update stats */
 		m_can_tx_update_stats(cdev, msg_mark, timestamp);
+		++processed;
 	}
 
 	if (ack_fgi != -1)
 		m_can_write(cdev, M_CAN_TXEFA, FIELD_PREP(TXEFA_EFAI_MASK,
 							  ack_fgi));
 
+	m_can_finish_tx(cdev, processed);
+
 	return err;
 }
 
@@ -1189,6 +1216,7 @@ static irqreturn_t m_can_isr(int irq, void *dev_id)
 				timestamp = m_can_get_timestamp(cdev);
 			m_can_tx_update_stats(cdev, 0, timestamp);
 			netif_wake_queue(dev);
+			m_can_finish_tx(cdev, 1);
 		}
 	} else  {
 		if (ir & (IR_TEFN | IR_TEFW)) {
@@ -1874,11 +1902,22 @@ static netdev_tx_t m_can_start_peripheral_xmit(struct m_can_classdev *cdev,
 	}
 
 	netif_stop_queue(cdev->net);
+
+	m_can_start_tx(cdev);
+
 	m_can_tx_queue_skb(cdev, skb);
 
 	return NETDEV_TX_OK;
 }
 
+static netdev_tx_t m_can_start_fast_xmit(struct m_can_classdev *cdev,
+					 struct sk_buff *skb)
+{
+	m_can_start_tx(cdev);
+
+	return m_can_tx_handler(cdev, skb);
+}
+
 static netdev_tx_t m_can_start_xmit(struct sk_buff *skb,
 				    struct net_device *dev)
 {
@@ -1890,7 +1929,7 @@ static netdev_tx_t m_can_start_xmit(struct sk_buff *skb,
 	if (cdev->is_peripheral)
 		return m_can_start_peripheral_xmit(cdev, skb);
 	else
-		return m_can_tx_handler(cdev, skb);
+		return m_can_start_fast_xmit(cdev, skb);
 }
 
 static enum hrtimer_restart hrtimer_callback(struct hrtimer *timer)
diff --git a/drivers/net/can/m_can/m_can.h b/drivers/net/can/m_can/m_can.h
index be1d2119bd53..76b1ce1b7c1b 100644
--- a/drivers/net/can/m_can/m_can.h
+++ b/drivers/net/can/m_can/m_can.h
@@ -108,6 +108,10 @@ struct m_can_classdev {
 	// Store this internally to avoid fetch delays on peripheral chips
 	u32 tx_fifo_putidx;
 
+	/* Protects shared state between start_xmit and m_can_isr */
+	spinlock_t tx_handling_spinlock;
+	int tx_fifo_in_flight;
+
 	struct m_can_tx_op *tx_ops;
 	int tx_fifo_size;
 	int next_tx_op;
-- 
2.40.1



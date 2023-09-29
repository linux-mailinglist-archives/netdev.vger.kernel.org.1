Return-Path: <netdev+bounces-37048-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CF2A77B3487
	for <lists+netdev@lfdr.de>; Fri, 29 Sep 2023 16:13:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id 32CD1B20DD5
	for <lists+netdev@lfdr.de>; Fri, 29 Sep 2023 14:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F2684E284;
	Fri, 29 Sep 2023 14:13:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA164F123
	for <netdev@vger.kernel.org>; Fri, 29 Sep 2023 14:13:32 +0000 (UTC)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEB2810C7
	for <netdev@vger.kernel.org>; Fri, 29 Sep 2023 07:13:27 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-4060b623e64so4733015e9.0
        for <netdev@vger.kernel.org>; Fri, 29 Sep 2023 07:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1695996805; x=1696601605; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gA/Wmd3Y496Cv44zBuUPXpmquZBwyc1Ad3nb4RaIwjs=;
        b=LQojhdfBDlSiW3DEaGg4mD8cmFBYYu2fsFrhGrkg9zFzvqHss8KZUE0S/NmVJvoNzz
         BvLykwo26hSsiPq5Gza4VEi916PmrNi8ijWUh/zSb9RaQPgy0SCZdsBbmRhzJ0fsMNCp
         rsrvL6jJWfPRrFv++iQ9IXHYuAHD5GssP553s3jUA+KNj1ZPeMuzRcSD3rh2cxNOmFPi
         kQIxmBCqxmJQARfRy55JfsjVXX0EfdE7TyE3raXVWfp3N86PcU4T6JEXhNrabMdmng9t
         vagsnjEAXnlNxhyKl/Zh91QNF1shWXSJOVGbWPTmXlpfvi+w+mIURWUn+737+jkZMP1B
         1RNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695996805; x=1696601605;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gA/Wmd3Y496Cv44zBuUPXpmquZBwyc1Ad3nb4RaIwjs=;
        b=Y3J/y1DYE/UwHGctlBHUkM40s48gCw/hjgMMLhvJHsRv6WG3BUP4fdiXy+98zZ01+k
         6KuHpu7B9iEszctOAfj79oFqfEqYUbTv2oOz/jb1S8wWnAmiqM41PxreDAIHA6RdQZfz
         KCnqBlrJxFDz7IBX4o+a8udwPn5mTa4V7pNBPBgvOdyp1dRZKxf5tChcD/s3dABndybq
         QqfTxX4qiAEpDo6SPCfFws29XsSQsqYm+Cx98omIsve4tjbEMuDl5WotCCMNHw0Ta4oN
         j+Sh/keZQKMOHNhYleXoR/LwSlO7XoxuirebVMmV0CVV6M/Kgn6IMLBo7ETG9GGurMo7
         U5KA==
X-Gm-Message-State: AOJu0YxTRwuO86/lTKsiQv2I6NcN8MskTTi+FIXQLkK5GSeY1hI4mxu9
	ex3od+zzzklvrmbzSU/NLU6kiw==
X-Google-Smtp-Source: AGHT+IE7n4eX/QOUtZnmrYmfrSDk/GdoA2VTMEb6+QhGzcozQOYK07nuiXkrBREm0biYNu/1kQMNDg==
X-Received: by 2002:a7b:cc95:0:b0:406:51a0:17ea with SMTP id p21-20020a7bcc95000000b0040651a017eamr3951279wma.10.1695996805165;
        Fri, 29 Sep 2023 07:13:25 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4091:a246:8222:dbda:9cd9:39cc:f174])
        by smtp.gmail.com with ESMTPSA id t25-20020a7bc3d9000000b00405391f485fsm1513068wmj.41.2023.09.29.07.13.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 07:13:24 -0700 (PDT)
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
Subject: [PATCH v6 13/14] can: m_can: Implement BQL
Date: Fri, 29 Sep 2023 16:13:03 +0200
Message-Id: <20230929141304.3934380-14-msp@baylibre.com>
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

Implement byte queue limiting in preparation for the use of xmit_more().

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
---
 drivers/net/can/m_can/m_can.c | 49 +++++++++++++++++++++++++----------
 1 file changed, 35 insertions(+), 14 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index dc8e8f133ea3..286c88132370 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -486,6 +486,8 @@ static void m_can_clean(struct net_device *net)
 	for (int i = 0; i != cdev->can.echo_skb_max; ++i)
 		can_free_echo_skb(cdev->net, i, NULL);
 
+	netdev_reset_queue(cdev->net);
+
 	spin_lock_irqsave(&cdev->tx_handling_spinlock, irqflags);
 	cdev->tx_fifo_in_flight = 0;
 	spin_unlock_irqrestore(&cdev->tx_handling_spinlock, irqflags);
@@ -1040,29 +1042,34 @@ static int m_can_poll(struct napi_struct *napi, int quota)
  * echo. timestamp is used for peripherals to ensure correct ordering
  * by rx-offload, and is ignored for non-peripherals.
  */
-static void m_can_tx_update_stats(struct m_can_classdev *cdev,
-				  unsigned int msg_mark,
-				  u32 timestamp)
+static unsigned int m_can_tx_update_stats(struct m_can_classdev *cdev,
+					  unsigned int msg_mark, u32 timestamp)
 {
 	struct net_device *dev = cdev->net;
 	struct net_device_stats *stats = &dev->stats;
+	unsigned int frame_len;
 
 	if (cdev->is_peripheral)
 		stats->tx_bytes +=
 			can_rx_offload_get_echo_skb_queue_timestamp(&cdev->offload,
 								    msg_mark,
 								    timestamp,
-								    NULL);
+								    &frame_len);
 	else
-		stats->tx_bytes += can_get_echo_skb(dev, msg_mark, NULL);
+		stats->tx_bytes += can_get_echo_skb(dev, msg_mark, &frame_len);
 
 	stats->tx_packets++;
+
+	return frame_len;
 }
 
-static void m_can_finish_tx(struct m_can_classdev *cdev, int transmitted)
+static void m_can_finish_tx(struct m_can_classdev *cdev, int transmitted,
+			    unsigned int transmitted_frame_len)
 {
 	unsigned long irqflags;
 
+	netdev_completed_queue(cdev->net, transmitted, transmitted_frame_len);
+
 	spin_lock_irqsave(&cdev->tx_handling_spinlock, irqflags);
 	if (cdev->tx_fifo_in_flight >= cdev->tx_fifo_size && transmitted > 0)
 		netif_wake_queue(cdev->net);
@@ -1101,6 +1108,7 @@ static int m_can_echo_tx_event(struct net_device *dev)
 	int err = 0;
 	unsigned int msg_mark;
 	int processed = 0;
+	unsigned int processed_frame_len = 0;
 
 	struct m_can_classdev *cdev = netdev_priv(dev);
 
@@ -1129,7 +1137,9 @@ static int m_can_echo_tx_event(struct net_device *dev)
 		fgi = (++fgi >= cdev->mcfg[MRAM_TXE].num ? 0 : fgi);
 
 		/* update stats */
-		m_can_tx_update_stats(cdev, msg_mark, timestamp);
+		processed_frame_len += m_can_tx_update_stats(cdev, msg_mark,
+							     timestamp);
+
 		++processed;
 	}
 
@@ -1137,7 +1147,7 @@ static int m_can_echo_tx_event(struct net_device *dev)
 		m_can_write(cdev, M_CAN_TXEFA, FIELD_PREP(TXEFA_EFAI_MASK,
 							  ack_fgi));
 
-	m_can_finish_tx(cdev, processed);
+	m_can_finish_tx(cdev, processed, processed_frame_len);
 
 	return err;
 }
@@ -1215,11 +1225,12 @@ static irqreturn_t m_can_isr(int irq, void *dev_id)
 		if (ir & IR_TC) {
 			/* Transmission Complete Interrupt*/
 			u32 timestamp = 0;
+			unsigned int frame_len;
 
 			if (cdev->is_peripheral)
 				timestamp = m_can_get_timestamp(cdev);
-			m_can_tx_update_stats(cdev, 0, timestamp);
-			m_can_finish_tx(cdev, 1);
+			frame_len = m_can_tx_update_stats(cdev, 0, timestamp);
+			m_can_finish_tx(cdev, 1, frame_len);
 		}
 	} else  {
 		if (ir & (IR_TEFN | IR_TEFW)) {
@@ -1735,6 +1746,7 @@ static netdev_tx_t m_can_tx_handler(struct m_can_classdev *cdev,
 	u32 cccr, fdflags;
 	int err;
 	u32 putidx;
+	unsigned int frame_len = can_skb_get_frame_len(skb);
 
 	/* Generate ID field for TX buffer Element */
 	/* Common to all supported M_CAN versions */
@@ -1780,7 +1792,7 @@ static netdev_tx_t m_can_tx_handler(struct m_can_classdev *cdev,
 		}
 		m_can_write(cdev, M_CAN_TXBTIE, 0x1);
 
-		can_put_echo_skb(skb, dev, 0, 0);
+		can_put_echo_skb(skb, dev, 0, frame_len);
 
 		m_can_write(cdev, M_CAN_TXBAR, 0x1);
 		/* End of xmit function for version 3.0.x */
@@ -1818,7 +1830,7 @@ static netdev_tx_t m_can_tx_handler(struct m_can_classdev *cdev,
 		/* Push loopback echo.
 		 * Will be looped back on TX interrupt based on message marker
 		 */
-		can_put_echo_skb(skb, dev, putidx, 0);
+		can_put_echo_skb(skb, dev, putidx, frame_len);
 
 		/* Enable TX FIFO element to start transfer  */
 		m_can_write(cdev, M_CAN_TXBAR, (1 << putidx));
@@ -1889,14 +1901,23 @@ static netdev_tx_t m_can_start_xmit(struct sk_buff *skb,
 				    struct net_device *dev)
 {
 	struct m_can_classdev *cdev = netdev_priv(dev);
+	netdev_tx_t ret;
+	unsigned int frame_len;
 
 	if (can_dev_dropped_skb(dev, skb))
 		return NETDEV_TX_OK;
 
+	frame_len = can_skb_get_frame_len(skb);
+
 	if (cdev->is_peripheral)
-		return m_can_start_peripheral_xmit(cdev, skb);
+		ret = m_can_start_peripheral_xmit(cdev, skb);
 	else
-		return m_can_start_fast_xmit(cdev, skb);
+		ret = m_can_start_fast_xmit(cdev, skb);
+
+	if (ret == NETDEV_TX_OK)
+		netdev_sent_queue(dev, frame_len);
+
+	return ret;
 }
 
 static enum hrtimer_restart hrtimer_callback(struct hrtimer *timer)
-- 
2.40.1



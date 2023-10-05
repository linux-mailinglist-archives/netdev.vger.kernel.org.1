Return-Path: <netdev+bounces-38398-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 765EF7BAAFE
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 21:59:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id D4F6628284E
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 19:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB82D436A8;
	Thu,  5 Oct 2023 19:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E9042BFF
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 19:58:29 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3681CF7
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 12:58:27 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1qoUUL-0004qx-2X
	for netdev@vger.kernel.org; Thu, 05 Oct 2023 21:58:25 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1qoUUG-00BLLp-Ge
	for netdev@vger.kernel.org; Thu, 05 Oct 2023 21:58:20 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 768D9230059
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 19:58:19 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 96E2522FFDB;
	Thu,  5 Oct 2023 19:58:17 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id ff8ba5d4;
	Thu, 5 Oct 2023 19:58:15 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 30/37] can: at91_can: at91_irq_err_frame(): move next to at91_irq_err()
Date: Thu,  5 Oct 2023 21:58:05 +0200
Message-Id: <20231005195812.549776-31-mkl@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231005195812.549776-1-mkl@pengutronix.de>
References: <20231005195812.549776-1-mkl@pengutronix.de>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This is a cleanup patch, no functional change intended. As
at91_irq_err_frame() is called from the IRQ handler move it in front
of the IRQ handler next to at91_irq_err().

Link: https://lore.kernel.org/all/20231005-at91_can-rx_offload-v2-20-9987d53600e0@pengutronix.de
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/at91_can.c | 122 ++++++++++++++++++-------------------
 1 file changed, 61 insertions(+), 61 deletions(-)

diff --git a/drivers/net/can/at91_can.c b/drivers/net/can/at91_can.c
index a84da1995816..6b017fd695c0 100644
--- a/drivers/net/can/at91_can.c
+++ b/drivers/net/can/at91_can.c
@@ -750,67 +750,6 @@ static int at91_poll_rx(struct net_device *dev, int quota)
 	return received;
 }
 
-static void at91_irq_err_frame(struct net_device *dev, const u32 reg_sr)
-{
-	struct net_device_stats *stats = &dev->stats;
-	struct at91_priv *priv = netdev_priv(dev);
-	struct sk_buff *skb;
-	struct can_frame *cf = NULL;
-
-	priv->can.can_stats.bus_error++;
-
-	skb = alloc_can_err_skb(dev, &cf);
-	if (cf)
-		cf->can_id |= CAN_ERR_PROT | CAN_ERR_BUSERROR;
-
-	if (reg_sr & AT91_IRQ_CERR) {
-		netdev_dbg(dev, "CRC error\n");
-
-		stats->rx_errors++;
-		if (cf)
-			cf->data[3] |= CAN_ERR_PROT_LOC_CRC_SEQ;
-	}
-
-	if (reg_sr & AT91_IRQ_SERR) {
-		netdev_dbg(dev, "Stuff error\n");
-
-		stats->rx_errors++;
-		if (cf)
-			cf->data[2] |= CAN_ERR_PROT_STUFF;
-	}
-
-	if (reg_sr & AT91_IRQ_AERR) {
-		netdev_dbg(dev, "NACK error\n");
-
-		stats->tx_errors++;
-		if (cf) {
-			cf->can_id |= CAN_ERR_ACK;
-			cf->data[2] |= CAN_ERR_PROT_TX;
-		}
-	}
-
-	if (reg_sr & AT91_IRQ_FERR) {
-		netdev_dbg(dev, "Format error\n");
-
-		stats->rx_errors++;
-		if (cf)
-			cf->data[2] |= CAN_ERR_PROT_FORM;
-	}
-
-	if (reg_sr & AT91_IRQ_BERR) {
-		netdev_dbg(dev, "Bit error\n");
-
-		stats->tx_errors++;
-		if (cf)
-			cf->data[2] |= CAN_ERR_PROT_TX | CAN_ERR_PROT_BIT;
-	}
-
-	if (!cf)
-		return;
-
-	netif_receive_skb(skb);
-}
-
 static int at91_poll(struct napi_struct *napi, int quota)
 {
 	struct net_device *dev = napi->dev;
@@ -1061,6 +1000,67 @@ static void at91_irq_err(struct net_device *dev)
 	priv->can.state = new_state;
 }
 
+static void at91_irq_err_frame(struct net_device *dev, const u32 reg_sr)
+{
+	struct net_device_stats *stats = &dev->stats;
+	struct at91_priv *priv = netdev_priv(dev);
+	struct sk_buff *skb;
+	struct can_frame *cf = NULL;
+
+	priv->can.can_stats.bus_error++;
+
+	skb = alloc_can_err_skb(dev, &cf);
+	if (cf)
+		cf->can_id |= CAN_ERR_PROT | CAN_ERR_BUSERROR;
+
+	if (reg_sr & AT91_IRQ_CERR) {
+		netdev_dbg(dev, "CRC error\n");
+
+		stats->rx_errors++;
+		if (cf)
+			cf->data[3] |= CAN_ERR_PROT_LOC_CRC_SEQ;
+	}
+
+	if (reg_sr & AT91_IRQ_SERR) {
+		netdev_dbg(dev, "Stuff error\n");
+
+		stats->rx_errors++;
+		if (cf)
+			cf->data[2] |= CAN_ERR_PROT_STUFF;
+	}
+
+	if (reg_sr & AT91_IRQ_AERR) {
+		netdev_dbg(dev, "NACK error\n");
+
+		stats->tx_errors++;
+		if (cf) {
+			cf->can_id |= CAN_ERR_ACK;
+			cf->data[2] |= CAN_ERR_PROT_TX;
+		}
+	}
+
+	if (reg_sr & AT91_IRQ_FERR) {
+		netdev_dbg(dev, "Format error\n");
+
+		stats->rx_errors++;
+		if (cf)
+			cf->data[2] |= CAN_ERR_PROT_FORM;
+	}
+
+	if (reg_sr & AT91_IRQ_BERR) {
+		netdev_dbg(dev, "Bit error\n");
+
+		stats->tx_errors++;
+		if (cf)
+			cf->data[2] |= CAN_ERR_PROT_TX | CAN_ERR_PROT_BIT;
+	}
+
+	if (!cf)
+		return;
+
+	netif_receive_skb(skb);
+}
+
 /* interrupt handler
  */
 static irqreturn_t at91_irq(int irq, void *dev_id)
-- 
2.40.1




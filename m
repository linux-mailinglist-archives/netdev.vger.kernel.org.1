Return-Path: <netdev+bounces-38407-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2356C7BAB08
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 21:59:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id 2A543B209B5
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 19:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FED443AAF;
	Thu,  5 Oct 2023 19:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB2242C1D
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 19:58:30 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AA0DF9
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 12:58:28 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1qoUUL-0004s4-W9
	for netdev@vger.kernel.org; Thu, 05 Oct 2023 21:58:26 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1qoUUH-00BLMk-31
	for netdev@vger.kernel.org; Thu, 05 Oct 2023 21:58:21 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id E0CA723006A
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 19:58:19 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 79BC522FFD7;
	Thu,  5 Oct 2023 19:58:17 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id d44122fc;
	Thu, 5 Oct 2023 19:58:15 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 29/37] can: at91_can: at91_irq_err_frame(): call directly from IRQ handler
Date: Thu,  5 Oct 2023 21:58:04 +0200
Message-Id: <20231005195812.549776-30-mkl@pengutronix.de>
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
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This is a preparation patch to convert the driver to the rx-offload
helper. In rx-offload RX, TX-done and CAN error handling are done in
the IRQ handler, SKB are pushed to the network stack in the NAPI poll
function.

Move the CAN frame error handling from the NAPI function at91_poll()
to the IRQ handler at91_poll(). To reflect this change, rename
at91_poll_err() to at91_irq_err_frame().

Link: https://lore.kernel.org/all/20231005-at91_can-rx_offload-v2-19-9987d53600e0@pengutronix.de
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/at91_can.c | 36 ++++++++++++------------------------
 1 file changed, 12 insertions(+), 24 deletions(-)

diff --git a/drivers/net/can/at91_can.c b/drivers/net/can/at91_can.c
index 5b611657b41f..a84da1995816 100644
--- a/drivers/net/can/at91_can.c
+++ b/drivers/net/can/at91_can.c
@@ -155,7 +155,6 @@ struct at91_priv {
 
 	void __iomem *reg_base;
 
-	u32 reg_sr;
 	unsigned int tx_head;
 	unsigned int tx_tail;
 	unsigned int rx_next;
@@ -751,7 +750,7 @@ static int at91_poll_rx(struct net_device *dev, int quota)
 	return received;
 }
 
-static int at91_poll_err(struct net_device *dev, int quota, u32 reg_sr)
+static void at91_irq_err_frame(struct net_device *dev, const u32 reg_sr)
 {
 	struct net_device_stats *stats = &dev->stats;
 	struct at91_priv *priv = netdev_priv(dev);
@@ -760,11 +759,9 @@ static int at91_poll_err(struct net_device *dev, int quota, u32 reg_sr)
 
 	priv->can.can_stats.bus_error++;
 
-	if (quota) {
-		skb = alloc_can_err_skb(dev, &cf);
-		if (cf)
-			cf->can_id |= CAN_ERR_PROT | CAN_ERR_BUSERROR;
-	}
+	skb = alloc_can_err_skb(dev, &cf);
+	if (cf)
+		cf->can_id |= CAN_ERR_PROT | CAN_ERR_BUSERROR;
 
 	if (reg_sr & AT91_IRQ_CERR) {
 		netdev_dbg(dev, "CRC error\n");
@@ -809,11 +806,9 @@ static int at91_poll_err(struct net_device *dev, int quota, u32 reg_sr)
 	}
 
 	if (!cf)
-		return 0;
+		return;
 
 	netif_receive_skb(skb);
-
-	return 1;
 }
 
 static int at91_poll(struct napi_struct *napi, int quota)
@@ -826,13 +821,6 @@ static int at91_poll(struct napi_struct *napi, int quota)
 	if (reg_sr & get_irq_mb_rx(priv))
 		work_done += at91_poll_rx(dev, quota - work_done);
 
-	/* The error bits are clear on read,
-	 * so use saved value from irq handler.
-	 */
-	reg_sr |= priv->reg_sr;
-	if (reg_sr & AT91_IRQ_ERR_FRAME)
-		work_done += at91_poll_err(dev, quota - work_done, reg_sr);
-
 	if (work_done < quota) {
 		/* enable IRQs for frame errors and all mailboxes >= rx_next */
 		u32 reg_ier = AT91_IRQ_ERR_FRAME;
@@ -1092,14 +1080,10 @@ static irqreturn_t at91_irq(int irq, void *dev_id)
 
 	handled = IRQ_HANDLED;
 
-	/* Receive or error interrupt? -> napi */
-	if (reg_sr & (get_irq_mb_rx(priv) | AT91_IRQ_ERR_FRAME)) {
-		/* The error bits are clear on read,
-		 * save for later use.
-		 */
-		priv->reg_sr = reg_sr;
+	/* Receive interrupt? -> napi */
+	if (reg_sr & get_irq_mb_rx(priv)) {
 		at91_write(priv, AT91_IDR,
-			   get_irq_mb_rx(priv) | AT91_IRQ_ERR_FRAME);
+			   get_irq_mb_rx(priv));
 		napi_schedule(&priv->napi);
 	}
 
@@ -1109,6 +1093,10 @@ static irqreturn_t at91_irq(int irq, void *dev_id)
 
 	at91_irq_err(dev);
 
+	/* Frame Error Interrupt */
+	if (reg_sr & AT91_IRQ_ERR_FRAME)
+		at91_irq_err_frame(dev, reg_sr);
+
  exit:
 	return handled;
 }
-- 
2.40.1




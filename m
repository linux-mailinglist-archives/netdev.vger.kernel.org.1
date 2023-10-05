Return-Path: <netdev+bounces-38408-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8C877BAB21
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 21:59:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id BC66028393E
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 19:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0A3643AB5;
	Thu,  5 Oct 2023 19:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B76D42C08
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 19:58:32 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68E6EDB
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 12:58:28 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1qoUUM-0004qr-5g
	for netdev@vger.kernel.org; Thu, 05 Oct 2023 21:58:26 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1qoUUG-00BLMH-LP
	for netdev@vger.kernel.org; Thu, 05 Oct 2023 21:58:20 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 77F0723005C
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 19:58:19 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 61DC922FFCF;
	Thu,  5 Oct 2023 19:58:17 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id efb0814e;
	Thu, 5 Oct 2023 19:58:15 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 28/37] can: at91_can: at91_poll_err(): increase stats even if no quota left or OOM
Date: Thu,  5 Oct 2023 21:58:03 +0200
Message-Id: <20231005195812.549776-29-mkl@pengutronix.de>
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

at91_poll_err() allocates a can error SKB, to inform the user space
about the CAN error. Then it fills the SKB with information the error
information and increases the net device error stats.

In case no SBK can be allocated (e.g. due to an OOM) or the NAPI quota
is 0 the function is left early and no stats are updated. This is not
helpful to the user, as there is no information about the faulty CAN
bus.

Increase the error stats even if no quota is left or no SKB can be
allocated.

While there treat No-Acknowledgment as a bus error, too.

Link: https://lore.kernel.org/all/20231005-at91_can-rx_offload-v2-18-9987d53600e0@pengutronix.de
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/at91_can.c | 71 ++++++++++++++++++++------------------
 1 file changed, 38 insertions(+), 33 deletions(-)

diff --git a/drivers/net/can/at91_can.c b/drivers/net/can/at91_can.c
index 2071011ee812..5b611657b41f 100644
--- a/drivers/net/can/at91_can.c
+++ b/drivers/net/can/at91_can.c
@@ -753,59 +753,64 @@ static int at91_poll_rx(struct net_device *dev, int quota)
 
 static int at91_poll_err(struct net_device *dev, int quota, u32 reg_sr)
 {
+	struct net_device_stats *stats = &dev->stats;
 	struct at91_priv *priv = netdev_priv(dev);
 	struct sk_buff *skb;
-	struct can_frame *cf;
+	struct can_frame *cf = NULL;
 
-	if (quota == 0)
-		return 0;
+	priv->can.can_stats.bus_error++;
 
-	skb = alloc_can_err_skb(dev, &cf);
-	if (unlikely(!skb))
-		return 0;
+	if (quota) {
+		skb = alloc_can_err_skb(dev, &cf);
+		if (cf)
+			cf->can_id |= CAN_ERR_PROT | CAN_ERR_BUSERROR;
+	}
 
-	/* CRC error */
 	if (reg_sr & AT91_IRQ_CERR) {
-		netdev_dbg(dev, "CERR irq\n");
-		dev->stats.rx_errors++;
-		priv->can.can_stats.bus_error++;
-		cf->can_id |= CAN_ERR_PROT | CAN_ERR_BUSERROR;
+		netdev_dbg(dev, "CRC error\n");
+
+		stats->rx_errors++;
+		if (cf)
+			cf->data[3] |= CAN_ERR_PROT_LOC_CRC_SEQ;
 	}
 
-	/* Stuffing Error */
 	if (reg_sr & AT91_IRQ_SERR) {
-		netdev_dbg(dev, "SERR irq\n");
-		dev->stats.rx_errors++;
-		priv->can.can_stats.bus_error++;
-		cf->can_id |= CAN_ERR_PROT | CAN_ERR_BUSERROR;
-		cf->data[2] |= CAN_ERR_PROT_STUFF;
+		netdev_dbg(dev, "Stuff error\n");
+
+		stats->rx_errors++;
+		if (cf)
+			cf->data[2] |= CAN_ERR_PROT_STUFF;
 	}
 
-	/* Acknowledgement Error */
 	if (reg_sr & AT91_IRQ_AERR) {
-		netdev_dbg(dev, "AERR irq\n");
-		dev->stats.tx_errors++;
-		cf->can_id |= CAN_ERR_ACK;
+		netdev_dbg(dev, "NACK error\n");
+
+		stats->tx_errors++;
+		if (cf) {
+			cf->can_id |= CAN_ERR_ACK;
+			cf->data[2] |= CAN_ERR_PROT_TX;
+		}
 	}
 
-	/* Form error */
 	if (reg_sr & AT91_IRQ_FERR) {
-		netdev_dbg(dev, "FERR irq\n");
-		dev->stats.rx_errors++;
-		priv->can.can_stats.bus_error++;
-		cf->can_id |= CAN_ERR_PROT | CAN_ERR_BUSERROR;
-		cf->data[2] |= CAN_ERR_PROT_FORM;
+		netdev_dbg(dev, "Format error\n");
+
+		stats->rx_errors++;
+		if (cf)
+			cf->data[2] |= CAN_ERR_PROT_FORM;
 	}
 
-	/* Bit Error */
 	if (reg_sr & AT91_IRQ_BERR) {
-		netdev_dbg(dev, "BERR irq\n");
-		dev->stats.tx_errors++;
-		priv->can.can_stats.bus_error++;
-		cf->can_id |= CAN_ERR_PROT | CAN_ERR_BUSERROR;
-		cf->data[2] |= CAN_ERR_PROT_BIT;
+		netdev_dbg(dev, "Bit error\n");
+
+		stats->tx_errors++;
+		if (cf)
+			cf->data[2] |= CAN_ERR_PROT_TX | CAN_ERR_PROT_BIT;
 	}
 
+	if (!cf)
+		return 0;
+
 	netif_receive_skb(skb);
 
 	return 1;
-- 
2.40.1




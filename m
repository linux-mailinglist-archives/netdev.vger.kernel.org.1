Return-Path: <netdev+bounces-12639-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CDDC738569
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 15:38:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CC3A280E8A
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 13:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 718FA19E54;
	Wed, 21 Jun 2023 13:29:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6617F19E4B
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 13:29:56 +0000 (UTC)
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DC961BCA
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 06:29:41 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1qBxtz-00078A-D8
	for netdev@vger.kernel.org; Wed, 21 Jun 2023 15:29:39 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 0D9631DE95F
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 13:29:23 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 4A6BB1DE91C;
	Wed, 21 Jun 2023 13:29:21 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id f8248239;
	Wed, 21 Jun 2023 13:29:17 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Jimmy Assarsson <extja@kvaser.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 33/33] can: kvaser_pciefd: Use TX FIFO size read from CAN controller
Date: Wed, 21 Jun 2023 15:29:14 +0200
Message-Id: <20230621132914.412546-34-mkl@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230621132914.412546-1-mkl@pengutronix.de>
References: <20230621132914.412546-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:b01:1d::7b
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Jimmy Assarsson <extja@kvaser.com>

Use the TX FIFO size read from CAN controller register, instead of using
hard coded value.

Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Link: https://lore.kernel.org/all/20230529134248.752036-15-extja@kvaser.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/kvaser_pciefd.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/net/can/kvaser_pciefd.c b/drivers/net/can/kvaser_pciefd.c
index 0321b70a3b71..db6256f2b1b3 100644
--- a/drivers/net/can/kvaser_pciefd.c
+++ b/drivers/net/can/kvaser_pciefd.c
@@ -658,8 +658,7 @@ static netdev_tx_t kvaser_pciefd_start_xmit(struct sk_buff *skb,
 	/* No room for a new message, stop the queue until at least one
 	 * successful transmit
 	 */
-	if (count >= KVASER_PCIEFD_CAN_TX_MAX_COUNT ||
-	    can->can.echo_skb[can->echo_idx])
+	if (count >= can->can.echo_skb_max || can->can.echo_skb[can->echo_idx])
 		netif_stop_queue(netdev);
 	spin_unlock_irqrestore(&can->echo_lock, irq_flags);
 
@@ -802,16 +801,9 @@ static int kvaser_pciefd_setup_can_ctrls(struct kvaser_pciefd *pcie)
 		tx_nr_packets_max =
 			FIELD_GET(KVASER_PCIEFD_KCAN_TX_NR_PACKETS_MAX_MASK,
 				  ioread32(can->reg_base + KVASER_PCIEFD_KCAN_TX_NR_PACKETS_REG));
-		if (tx_nr_packets_max < KVASER_PCIEFD_CAN_TX_MAX_COUNT) {
-			dev_err(&pcie->pci->dev,
-				"Max Tx count is smaller than expected\n");
-
-			free_candev(netdev);
-			return -ENODEV;
-		}
 
 		can->can.clock.freq = pcie->freq;
-		can->can.echo_skb_max = KVASER_PCIEFD_CAN_TX_MAX_COUNT;
+		can->can.echo_skb_max = min(KVASER_PCIEFD_CAN_TX_MAX_COUNT, tx_nr_packets_max - 1);
 		can->echo_idx = 0;
 		spin_lock_init(&can->echo_lock);
 		spin_lock_init(&can->lock);
@@ -1311,8 +1303,7 @@ static int kvaser_pciefd_handle_ack_packet(struct kvaser_pciefd *pcie,
 		count = FIELD_GET(KVASER_PCIEFD_KCAN_TX_NR_PACKETS_CURRENT_MASK,
 				  ioread32(can->reg_base + KVASER_PCIEFD_KCAN_TX_NR_PACKETS_REG));
 
-		if (count < KVASER_PCIEFD_CAN_TX_MAX_COUNT &&
-		    netif_queue_stopped(can->can.dev))
+		if (count < can->can.echo_skb_max && netif_queue_stopped(can->can.dev))
 			netif_wake_queue(can->can.dev);
 
 		if (!one_shot_fail) {
-- 
2.40.1




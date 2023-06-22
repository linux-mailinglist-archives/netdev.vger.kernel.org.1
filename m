Return-Path: <netdev+bounces-12993-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B74B739A06
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 10:38:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBA9F1C2032E
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 08:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D928200B9;
	Thu, 22 Jun 2023 08:27:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228E4200B5
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 08:27:58 +0000 (UTC)
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ADEC2103
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 01:27:39 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1qCFf5-00039J-76
	for netdev@vger.kernel.org; Thu, 22 Jun 2023 10:27:27 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 5DB2B1DF452
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 08:27:07 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 7E3441DF3E9;
	Thu, 22 Jun 2023 08:27:05 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 05a2cf62;
	Thu, 22 Jun 2023 08:27:02 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Jimmy Assarsson <extja@kvaser.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 31/33] can: kvaser_pciefd: Add len8_dlc support
Date: Thu, 22 Jun 2023 10:26:56 +0200
Message-Id: <20230622082658.571150-32-mkl@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230622082658.571150-1-mkl@pengutronix.de>
References: <20230622082658.571150-1-mkl@pengutronix.de>
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

Add support for the Classical CAN raw DLC functionality to send and receive
DLC values from 9 .. 15.

Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Link: https://lore.kernel.org/all/20230529134248.752036-13-extja@kvaser.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/kvaser_pciefd.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/kvaser_pciefd.c b/drivers/net/can/kvaser_pciefd.c
index 8779091c448c..e3d730264462 100644
--- a/drivers/net/can/kvaser_pciefd.c
+++ b/drivers/net/can/kvaser_pciefd.c
@@ -591,15 +591,20 @@ static int kvaser_pciefd_prepare_tx_packet(struct kvaser_pciefd_tx_packet *p,
 		p->header[0] |= KVASER_PCIEFD_RPACKET_IDE;
 
 	p->header[0] |= FIELD_PREP(KVASER_PCIEFD_RPACKET_ID_MASK, cf->can_id);
-	p->header[1] |= FIELD_PREP(KVASER_PCIEFD_RPACKET_DLC_MASK, can_fd_len2dlc(cf->len));
 	p->header[1] |= KVASER_PCIEFD_TPACKET_AREQ;
 
 	if (can_is_canfd_skb(skb)) {
+		p->header[1] |= FIELD_PREP(KVASER_PCIEFD_RPACKET_DLC_MASK,
+					   can_fd_len2dlc(cf->len));
 		p->header[1] |= KVASER_PCIEFD_RPACKET_FDF;
 		if (cf->flags & CANFD_BRS)
 			p->header[1] |= KVASER_PCIEFD_RPACKET_BRS;
 		if (cf->flags & CANFD_ESI)
 			p->header[1] |= KVASER_PCIEFD_RPACKET_ESI;
+	} else {
+		p->header[1] |=
+			FIELD_PREP(KVASER_PCIEFD_RPACKET_DLC_MASK,
+				   can_get_cc_dlc((struct can_frame *)cf, can->can.ctrlmode));
 	}
 
 	p->header[1] |= FIELD_PREP(KVASER_PCIEFD_PACKET_SEQ_MASK, seq);
@@ -834,7 +839,8 @@ static int kvaser_pciefd_setup_can_ctrls(struct kvaser_pciefd *pcie)
 
 		can->can.ctrlmode_supported = CAN_CTRLMODE_LISTENONLY |
 					      CAN_CTRLMODE_FD |
-					      CAN_CTRLMODE_FD_NON_ISO;
+					      CAN_CTRLMODE_FD_NON_ISO |
+					      CAN_CTRLMODE_CC_LEN8_DLC;
 
 		status = ioread32(can->reg_base + KVASER_PCIEFD_KCAN_STAT_REG);
 		if (!(status & KVASER_PCIEFD_KCAN_STAT_FD)) {
@@ -996,12 +1002,14 @@ static int kvaser_pciefd_handle_data_packet(struct kvaser_pciefd *pcie,
 	struct can_priv *priv;
 	struct net_device_stats *stats;
 	u8 ch_id = FIELD_GET(KVASER_PCIEFD_PACKET_CHID_MASK, p->header[1]);
+	u8 dlc;
 
 	if (ch_id >= pcie->nr_channels)
 		return -EIO;
 
 	priv = &pcie->can[ch_id]->can;
 	stats = &priv->dev->stats;
+	dlc = FIELD_GET(KVASER_PCIEFD_RPACKET_DLC_MASK, p->header[1]);
 
 	if (p->header[1] & KVASER_PCIEFD_RPACKET_FDF) {
 		skb = alloc_canfd_skb(priv->dev, &cf);
@@ -1010,6 +1018,7 @@ static int kvaser_pciefd_handle_data_packet(struct kvaser_pciefd *pcie,
 			return -ENOMEM;
 		}
 
+		cf->len = can_fd_dlc2len(dlc);
 		if (p->header[1] & KVASER_PCIEFD_RPACKET_BRS)
 			cf->flags |= CANFD_BRS;
 
@@ -1021,14 +1030,13 @@ static int kvaser_pciefd_handle_data_packet(struct kvaser_pciefd *pcie,
 			stats->rx_dropped++;
 			return -ENOMEM;
 		}
+		can_frame_set_cc_len((struct can_frame *)cf, dlc, priv->ctrlmode);
 	}
 
 	cf->can_id = FIELD_GET(KVASER_PCIEFD_RPACKET_ID_MASK, p->header[0]);
 	if (p->header[0] & KVASER_PCIEFD_RPACKET_IDE)
 		cf->can_id |= CAN_EFF_FLAG;
 
-	cf->len = can_fd_dlc2len(FIELD_GET(KVASER_PCIEFD_RPACKET_DLC_MASK, p->header[1]));
-
 	if (p->header[0] & KVASER_PCIEFD_RPACKET_RTR) {
 		cf->can_id |= CAN_RTR_FLAG;
 	} else {
-- 
2.40.1




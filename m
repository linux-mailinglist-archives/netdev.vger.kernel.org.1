Return-Path: <netdev+bounces-225838-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F4A5B98CD8
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 10:22:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCEBA2E2A5A
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 08:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4001286411;
	Wed, 24 Sep 2025 08:21:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4986F285068
	for <netdev@vger.kernel.org>; Wed, 24 Sep 2025 08:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758702107; cv=none; b=Q0jztvbfdltVkAC1+pwYZ0AUG/GwYMBoOJD+xRGw7Yfdiy5e0gsWFEhjz/ELT4pBYOlO5XB5gqWaJkMC2XAqvVvZvEvVBSwFUsKEjByI1Ull/6kHtr8ELrmPHeQepbMi51/3YtOCMZimZxRuEp2+7Epvmh96BWiC95Ba62jAhbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758702107; c=relaxed/simple;
	bh=L4kVkseMvnicAWlbMp6SLkaM3wED+vrIdK9517ZqFtk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M1vZXupFSUNz0BeEsDHnlycSsJ0b8u94MB+r9/W97+3lc48ko715DEms1R6jkOXoLL8LZRLXnXXAj8rAmId0bbVXEAr+rvxo2T9NsuQgaGWU1Gy01xe4E+5H+yxayAy/iWj4fT1I2/2rkynu75pbbzH4MQvldDTCGAJGF854uZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1v1Kke-0001FN-Ei; Wed, 24 Sep 2025 10:21:24 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1v1Kkd-000Dw5-00;
	Wed, 24 Sep 2025 10:21:23 +0200
Received: from blackshift.org (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 8ED6F478886;
	Wed, 24 Sep 2025 08:21:08 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 17/48] can: rcar_can: Mailbox bitfield conversion
Date: Wed, 24 Sep 2025 10:06:34 +0200
Message-ID: <20250924082104.595459-18-mkl@pengutronix.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250924082104.595459-1-mkl@pengutronix.de>
References: <20250924082104.595459-1-mkl@pengutronix.de>
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

From: Geert Uytterhoeven <geert+renesas@glider.be>

Convert CAN Mailbox Register field accesses to use the FIELD_PREP() and
FIELD_GET() bitfield access macro.

This gets rid of explicit shifts, and keeps a clear separation between
hardware register layouts and offical CAN definitions.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/c75c7d6ed5929c4becf7c9178cec04a0731e8ab1.1755857536.git.geert+renesas@glider.be
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/rcar/rcar_can.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_can.c b/drivers/net/can/rcar/rcar_can.c
index 4c5c1f044691..de1829477659 100644
--- a/drivers/net/can/rcar/rcar_can.c
+++ b/drivers/net/can/rcar/rcar_can.c
@@ -160,7 +160,8 @@ static const struct can_bittiming_const rcar_can_bittiming_const = {
 /* Mailbox and Mask Registers bits */
 #define RCAR_CAN_IDE		BIT(31)		/* ID Extension */
 #define RCAR_CAN_RTR		BIT(30)		/* Remote Transmission Request */
-#define RCAR_CAN_SID_SHIFT	18
+#define RCAR_CAN_SID		GENMASK(28, 18)	/* Standard ID */
+#define RCAR_CAN_EID		GENMASK(28, 0)	/* Extended ID */
 
 /* Mailbox Interrupt Enable Register 1 bits */
 #define RCAR_CAN_MIER1_RXFIE	BIT(28)		/* Receive  FIFO Interrupt Enable */
@@ -599,9 +600,10 @@ static netdev_tx_t rcar_can_start_xmit(struct sk_buff *skb,
 		return NETDEV_TX_OK;
 
 	if (cf->can_id & CAN_EFF_FLAG)	/* Extended frame format */
-		data = (cf->can_id & CAN_EFF_MASK) | RCAR_CAN_IDE;
+		data = FIELD_PREP(RCAR_CAN_EID, cf->can_id & CAN_EFF_MASK) |
+		       RCAR_CAN_IDE;
 	else				/* Standard frame format */
-		data = (cf->can_id & CAN_SFF_MASK) << RCAR_CAN_SID_SHIFT;
+		data = FIELD_PREP(RCAR_CAN_SID, cf->can_id & CAN_SFF_MASK);
 
 	if (cf->can_id & CAN_RTR_FLAG) { /* Remote transmission request */
 		data |= RCAR_CAN_RTR;
@@ -656,9 +658,9 @@ static void rcar_can_rx_pkt(struct rcar_can_priv *priv)
 
 	data = readl(&priv->regs->mb[RCAR_CAN_RX_FIFO_MBX].id);
 	if (data & RCAR_CAN_IDE)
-		cf->can_id = (data & CAN_EFF_MASK) | CAN_EFF_FLAG;
+		cf->can_id = FIELD_GET(RCAR_CAN_EID, data) | CAN_EFF_FLAG;
 	else
-		cf->can_id = (data >> RCAR_CAN_SID_SHIFT) & CAN_SFF_MASK;
+		cf->can_id = FIELD_GET(RCAR_CAN_SID, data);
 
 	dlc = readb(&priv->regs->mb[RCAR_CAN_RX_FIFO_MBX].dlc);
 	cf->len = can_cc_dlc2len(dlc);
-- 
2.51.0



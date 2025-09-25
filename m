Return-Path: <netdev+bounces-226305-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3353FB9F252
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 14:15:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B1B74E4EFB
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 12:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 067C43054CB;
	Thu, 25 Sep 2025 12:14:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485F32FFF8F
	for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 12:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758802446; cv=none; b=MymXYBLG+l58HinFgAc/sVa9UbB5ryDZgoA8MBR2EJ+W3llQnNY63grMOkSxLLhsDqo38nN05LCVYu+opYWnW6N63v/0uCssRF5vkJ1aFWtyDMAFgc1/rOYDCSq5D+JL7lABaH+o+LXYXw8to3g3Sf3QBhWqk+3L+beHZLYMMsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758802446; c=relaxed/simple;
	bh=0NhSBlMJgJLDr7UonSIPqfR92ku9IKOwdbISsJOfkh8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uwPW/0pzuKOfA1/eLeX0mZPzEMs6/32o+heaRLcG/QFLS48CSXFqdBZLWk5292Yfkb7wXr7P76fBOuJeP+fCsgbYza4McY4YVRYXWx2AHPCuaSh0wPJ4MTZb44GtwvFrtdaaYkTOrYEn4lMtfz6k5XJ4FiftIkQi61mhuwFZTrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1v1kqu-0000Vu-I4; Thu, 25 Sep 2025 14:13:36 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1v1kqu-000Pvk-0R;
	Thu, 25 Sep 2025 14:13:36 +0200
Received: from blackshift.org (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id D7C9447997B;
	Thu, 25 Sep 2025 12:13:35 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 15/48] can: rcar_can: TFCR bitfield conversion
Date: Thu, 25 Sep 2025 14:07:52 +0200
Message-ID: <20250925121332.848157-16-mkl@pengutronix.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250925121332.848157-1-mkl@pengutronix.de>
References: <20250925121332.848157-1-mkl@pengutronix.de>
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

Convert CAN Transmit FIFO Control Register field accesses to use the
FIELD_GET() bitfield access macro.

This gets rid of an explicit shift.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/a8b1dc6f1249a01af9b691ca59e2e5cc2dba6d44.1755857536.git.geert+renesas@glider.be
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/rcar/rcar_can.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_can.c b/drivers/net/can/rcar/rcar_can.c
index 8b4356fcd7d2..6f28dc935451 100644
--- a/drivers/net/can/rcar/rcar_can.c
+++ b/drivers/net/can/rcar/rcar_can.c
@@ -145,8 +145,6 @@ static const struct can_bittiming_const rcar_can_bittiming_const = {
 /* Transmit FIFO Control Register bits */
 #define RCAR_CAN_TFCR_TFUST	GENMASK(3, 1)	/* Transmit FIFO Unsent Message */
 						/* Number Status Bits */
-#define RCAR_CAN_TFCR_TFUST_SHIFT 1		/* Offset of Transmit FIFO Unsent */
-						/* Message Number Status Bits */
 #define RCAR_CAN_TFCR_TFE	BIT(0)		/* Transmit FIFO Enable */
 
 #define RCAR_CAN_N_RX_MKREGS1	2		/* Number of mask registers */
@@ -377,10 +375,9 @@ static void rcar_can_tx_done(struct net_device *ndev)
 	u8 isr;
 
 	while (1) {
-		u8 unsent = readb(&priv->regs->tfcr);
+		u8 unsent = FIELD_GET(RCAR_CAN_TFCR_TFUST,
+			    readb(&priv->regs->tfcr));
 
-		unsent = (unsent & RCAR_CAN_TFCR_TFUST) >>
-			  RCAR_CAN_TFCR_TFUST_SHIFT;
 		if (priv->tx_head - priv->tx_tail <= unsent)
 			break;
 		stats->tx_packets++;
-- 
2.51.0



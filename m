Return-Path: <netdev+bounces-225849-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A213B98D24
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 10:23:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDE8619C7D9C
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 08:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 890C628AAEE;
	Wed, 24 Sep 2025 08:21:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6623228507B
	for <netdev@vger.kernel.org>; Wed, 24 Sep 2025 08:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758702110; cv=none; b=jCUxlhRSzrEYUya7G+tZWmcj2bJUsiBtEb+VLhmHyWZvgZddVslVjWFSgELh7TlCpBZckjy+AcOXvCzv20Ubt4E2L4F4vp8lNOT7d91O5oS1GEtiJC/1DeBLaPV7yX6nsni5Po+xdwE5yG3R98F6s8o7skH2LVxjaqPiGKYHDmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758702110; c=relaxed/simple;
	bh=0NhSBlMJgJLDr7UonSIPqfR92ku9IKOwdbISsJOfkh8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EbED6OiMZcJi3kFk4TEg/OSWUos47xPwucD5T1qRHxkGJFTWC4AVu/mqg0K9AV3vfoMml2F54+iBFqtCs6rgFSKhucR0WfxxkxVdVU75qcsWkDmz/S3s6/5efms/OFSI7nBb7S2jFAkZ8L2TxlhH7V/nxq/fZ7oUfZhWgBskUuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1v1Kke-0001FZ-LK; Wed, 24 Sep 2025 10:21:24 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1v1Kkc-000Dvw-2x;
	Wed, 24 Sep 2025 10:21:22 +0200
Received: from blackshift.org (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 6CC62478882;
	Wed, 24 Sep 2025 08:21:08 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 15/48] can: rcar_can: TFCR bitfield conversion
Date: Wed, 24 Sep 2025 10:06:32 +0200
Message-ID: <20250924082104.595459-16-mkl@pengutronix.de>
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



Return-Path: <netdev+bounces-225837-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2E88B98CEB
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 10:22:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5A004C38C4
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 08:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75DB9285CBC;
	Wed, 24 Sep 2025 08:21:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD3D285061
	for <netdev@vger.kernel.org>; Wed, 24 Sep 2025 08:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758702107; cv=none; b=EscMdy9VTq7U26c0ALk+/PXUiv2M/TCsFF6cWSMtGc49ZbYC0p3/8fuUUfTKsB1soJcku5UJUbwwTqos1ObsBHO4TSXeyUSkroH4nOc4DhaR2SlnxVOypa0TiCzUom16Ya/wBzIdh9qU6phKdhYp7+HgH4zqoQjTgIWHbbqqCZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758702107; c=relaxed/simple;
	bh=6SJo2Zz8xPEFGioLuAOKl0AdN4zsc6eL2RHEmONPV6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OSsxTHXY7e1saxPn/c26Bo/tXwwpSxJk+Dk0mhpq9q62yrGbtUbNPvm5G38Rs7HjYj8WvN4ixIVmv6WCSoU3NbOwcEgCJvuLhM7tXzzYjfprCwA4sR0N1xzbbmSxoYiQo4p+8xEfxZqSwmNtjBDv1sfNIYHcJZxybk5F30ZtS4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1v1Kke-0001Fi-OJ; Wed, 24 Sep 2025 10:21:24 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1v1Kkc-000Dvp-2i;
	Wed, 24 Sep 2025 10:21:22 +0200
Received: from blackshift.org (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 5C923478880;
	Wed, 24 Sep 2025 08:21:08 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 14/48] can: rcar_can: CTLR bitfield conversion
Date: Wed, 24 Sep 2025 10:06:31 +0200
Message-ID: <20250924082104.595459-15-mkl@pengutronix.de>
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

Convert CAN Control Register field accesses to use the FIELD_PREP()
bitfield access macro.  Add a few more comments and definitions while at
it.

This gets rid of explicit (and sometimes confusing) shifts.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/077640e31949dc3c9d128a08ade94c9e9cd25672.1755857536.git.geert+renesas@glider.be
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/rcar/rcar_can.c | 33 ++++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_can.c b/drivers/net/can/rcar/rcar_can.c
index 7b94224bbc9b..8b4356fcd7d2 100644
--- a/drivers/net/can/rcar/rcar_can.c
+++ b/drivers/net/can/rcar/rcar_can.c
@@ -5,6 +5,7 @@
  * Copyright (C) 2013 Renesas Solutions Corp.
  */
 
+#include <linux/bitfield.h>
 #include <linux/bits.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
@@ -115,16 +116,19 @@ static const struct can_bittiming_const rcar_can_bittiming_const = {
 
 /* Control Register bits */
 #define RCAR_CAN_CTLR_BOM	GENMASK(12, 11)	/* Bus-Off Recovery Mode Bits */
-#define RCAR_CAN_CTLR_BOM_ENT	(1 << 11) /* Entry to halt mode */
-					/* at bus-off entry */
+#define RCAR_CAN_CTLR_BOM_ENT		1	/* Entry to halt mode */
+						/* at bus-off entry */
 #define RCAR_CAN_CTLR_SLPM	BIT(10)		/* Sleep Mode */
 #define RCAR_CAN_CTLR_CANM	GENMASK(9, 8)	/* Operating Mode Select Bit */
-#define RCAR_CAN_CTLR_CANM_HALT	(1 << 9)
-#define RCAR_CAN_CTLR_CANM_RESET (1 << 8)
-#define RCAR_CAN_CTLR_CANM_FORCE_RESET (3 << 8)
+#define RCAR_CAN_CTLR_CANM_OPER		0	/* Operation Mode */
+#define RCAR_CAN_CTLR_CANM_RESET	1	/* Reset Mode */
+#define RCAR_CAN_CTLR_CANM_HALT		2	/* Halt Mode */
+#define RCAR_CAN_CTLR_CANM_FORCE_RESET	3	/* Reset Mode (forcible) */
 #define RCAR_CAN_CTLR_MLM	BIT(3)		/* Message Lost Mode Select */
 #define RCAR_CAN_CTLR_IDFM	GENMASK(2, 1)	/* ID Format Mode Select Bits */
-#define RCAR_CAN_CTLR_IDFM_MIXED (1 << 2) /* Mixed ID mode */
+#define RCAR_CAN_CTLR_IDFM_STD		0	/* Standard ID mode */
+#define RCAR_CAN_CTLR_IDFM_EXT		1	/* Extended ID mode */
+#define RCAR_CAN_CTLR_IDFM_MIXED	2	/* Mixed ID mode */
 #define RCAR_CAN_CTLR_MBM	BIT(0)		/* Mailbox Mode select */
 
 /* Status Register bits */
@@ -453,16 +457,17 @@ static void rcar_can_start(struct net_device *ndev)
 	ctlr &= ~RCAR_CAN_CTLR_SLPM;
 	writew(ctlr, &priv->regs->ctlr);
 	/* Go to reset mode */
-	ctlr |= RCAR_CAN_CTLR_CANM_FORCE_RESET;
+	ctlr |= FIELD_PREP(RCAR_CAN_CTLR_CANM, RCAR_CAN_CTLR_CANM_FORCE_RESET);
 	writew(ctlr, &priv->regs->ctlr);
 	for (i = 0; i < MAX_STR_READS; i++) {
 		if (readw(&priv->regs->str) & RCAR_CAN_STR_RSTST)
 			break;
 	}
 	rcar_can_set_bittiming(ndev);
-	ctlr |= RCAR_CAN_CTLR_IDFM_MIXED; /* Select mixed ID mode */
-	ctlr |= RCAR_CAN_CTLR_BOM_ENT;	/* Entry to halt mode automatically */
-					/* at bus-off */
+	/* Select mixed ID mode */
+	ctlr |= FIELD_PREP(RCAR_CAN_CTLR_IDFM, RCAR_CAN_CTLR_IDFM_MIXED);
+	/* Entry to halt mode automatically at bus-off */
+	ctlr |= FIELD_PREP(RCAR_CAN_CTLR_BOM, RCAR_CAN_CTLR_BOM_ENT);
 	ctlr |= RCAR_CAN_CTLR_MBM;	/* Select FIFO mailbox mode */
 	ctlr |= RCAR_CAN_CTLR_MLM;	/* Overrun mode */
 	writew(ctlr, &priv->regs->ctlr);
@@ -492,7 +497,9 @@ static void rcar_can_start(struct net_device *ndev)
 	priv->can.state = CAN_STATE_ERROR_ACTIVE;
 
 	/* Go to operation mode */
-	writew(ctlr & ~RCAR_CAN_CTLR_CANM, &priv->regs->ctlr);
+	ctlr &= ~RCAR_CAN_CTLR_CANM;
+	ctlr |= FIELD_PREP(RCAR_CAN_CTLR_CANM, RCAR_CAN_CTLR_CANM_OPER);
+	writew(ctlr, &priv->regs->ctlr);
 	for (i = 0; i < MAX_STR_READS; i++) {
 		if (!(readw(&priv->regs->str) & RCAR_CAN_STR_RSTST))
 			break;
@@ -553,7 +560,7 @@ static void rcar_can_stop(struct net_device *ndev)
 
 	/* Go to (force) reset mode */
 	ctlr = readw(&priv->regs->ctlr);
-	ctlr |= RCAR_CAN_CTLR_CANM_FORCE_RESET;
+	ctlr |= FIELD_PREP(RCAR_CAN_CTLR_CANM, RCAR_CAN_CTLR_CANM_FORCE_RESET);
 	writew(ctlr, &priv->regs->ctlr);
 	for (i = 0; i < MAX_STR_READS; i++) {
 		if (readw(&priv->regs->str) & RCAR_CAN_STR_RSTST)
@@ -847,7 +854,7 @@ static int rcar_can_suspend(struct device *dev)
 	netif_device_detach(ndev);
 
 	ctlr = readw(&priv->regs->ctlr);
-	ctlr |= RCAR_CAN_CTLR_CANM_HALT;
+	ctlr |= FIELD_PREP(RCAR_CAN_CTLR_CANM, RCAR_CAN_CTLR_CANM_HALT);
 	writew(ctlr, &priv->regs->ctlr);
 	ctlr |= RCAR_CAN_CTLR_SLPM;
 	writew(ctlr, &priv->regs->ctlr);
-- 
2.51.0



Return-Path: <netdev+bounces-38392-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E3057BAAF5
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 21:59:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 5AD93282A28
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 19:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EECE42C0D;
	Thu,  5 Oct 2023 19:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF6F41E43
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 19:58:28 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 329FCF3
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 12:58:26 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1qoUUK-0004nv-3Z
	for netdev@vger.kernel.org; Thu, 05 Oct 2023 21:58:24 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1qoUUF-00BLJ3-Iy
	for netdev@vger.kernel.org; Thu, 05 Oct 2023 21:58:19 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 602B5230009
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 19:58:18 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 957B922FF88;
	Thu,  5 Oct 2023 19:58:15 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 5f8ffdc9;
	Thu, 5 Oct 2023 19:58:14 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 14/37] can: at91_can: BR register: convert to FIELD_PREP()
Date: Thu,  5 Oct 2023 21:57:49 +0200
Message-Id: <20231005195812.549776-15-mkl@pengutronix.de>
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

Use FIELD_PREP() to access the individual fields of the BR register.

Link: https://lore.kernel.org/all/20231005-at91_can-rx_offload-v2-4-9987d53600e0@pengutronix.de
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/at91_can.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/net/can/at91_can.c b/drivers/net/can/at91_can.c
index 966980d4b5dd..79eb78b9f8ae 100644
--- a/drivers/net/can/at91_can.c
+++ b/drivers/net/can/at91_can.c
@@ -6,6 +6,7 @@
  * (C) 2008, 2009, 2010, 2011 by Marc Kleine-Budde <kernel@pengutronix.de>
  */
 
+#include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/errno.h>
 #include <linux/ethtool.h>
@@ -64,6 +65,13 @@ enum at91_reg {
 
 #define AT91_SR_RBSY BIT(29)
 
+#define AT91_BR_PHASE2_MASK GENMASK(2, 0)
+#define AT91_BR_PHASE1_MASK GENMASK(6, 4)
+#define AT91_BR_PROPAG_MASK GENMASK(10, 8)
+#define AT91_BR_SJW_MASK GENMASK(13, 12)
+#define AT91_BR_BRP_MASK GENMASK(22, 16)
+#define AT91_BR_SMP BIT(24)
+
 #define AT91_MMR_PRIO_SHIFT (16)
 
 #define AT91_MID_MIDE BIT(29)
@@ -353,12 +361,16 @@ static int at91_set_bittiming(struct net_device *dev)
 {
 	const struct at91_priv *priv = netdev_priv(dev);
 	const struct can_bittiming *bt = &priv->can.bittiming;
-	u32 reg_br;
+	u32 reg_br = 0;
 
-	reg_br = ((priv->can.ctrlmode & CAN_CTRLMODE_3_SAMPLES) ? 1 << 24 : 0) |
-		((bt->brp - 1) << 16) | ((bt->sjw - 1) << 12) |
-		((bt->prop_seg - 1) << 8) | ((bt->phase_seg1 - 1) << 4) |
-		((bt->phase_seg2 - 1) << 0);
+	if (priv->can.ctrlmode & CAN_CTRLMODE_3_SAMPLES)
+		reg_br |= AT91_BR_SMP;
+
+	reg_br |= FIELD_PREP(AT91_BR_BRP_MASK, bt->brp - 1) |
+		FIELD_PREP(AT91_BR_SJW_MASK, bt->sjw - 1) |
+		FIELD_PREP(AT91_BR_PROPAG_MASK, bt->prop_seg - 1) |
+		FIELD_PREP(AT91_BR_PHASE1_MASK, bt->phase_seg1 - 1) |
+		FIELD_PREP(AT91_BR_PHASE2_MASK, bt->phase_seg2 - 1);
 
 	netdev_info(dev, "writing AT91_BR: 0x%08x\n", reg_br);
 
-- 
2.40.1




Return-Path: <netdev+bounces-12975-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22E4C7399C5
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 10:31:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51AAA1C21076
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 08:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 398711E53C;
	Thu, 22 Jun 2023 08:27:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EEB91E52A
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 08:27:40 +0000 (UTC)
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C80C92133
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 01:27:16 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1qCFep-0002aj-4W
	for netdev@vger.kernel.org; Thu, 22 Jun 2023 10:27:11 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id CCB861DF3C1
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 08:27:04 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 54F1A1DF359;
	Thu, 22 Jun 2023 08:27:02 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 23f5cced;
	Thu, 22 Jun 2023 08:27:00 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 11/33] can: sja1000: Prepare the use of a threaded handler
Date: Thu, 22 Jun 2023 10:26:36 +0200
Message-Id: <20230622082658.571150-12-mkl@pengutronix.de>
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

From: Miquel Raynal <miquel.raynal@bootlin.com>

In order to support a flavor of the sja1000 which sometimes freezes, it
will be needed upon certain interrupts to perform a soft reset. The soft
reset operation takes a bit of time, so better not do it within the hard
interrupt handler but rather in a threaded handler. Let's prepare the
possibility for sja1000_err() to request "interrupting" the current flow
and request the threaded handler to be run while keeping the interrupt
line low.

There is no functional change.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Link: https://lore.kernel.org/all/20230616134553.2786391-1-miquel.raynal@bootlin.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/sja1000/sja1000.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/sja1000/sja1000.c b/drivers/net/can/sja1000/sja1000.c
index aac5956e4a53..4719806e3a9f 100644
--- a/drivers/net/can/sja1000/sja1000.c
+++ b/drivers/net/can/sja1000/sja1000.c
@@ -501,7 +501,8 @@ irqreturn_t sja1000_interrupt(int irq, void *dev_id)
 	struct sja1000_priv *priv = netdev_priv(dev);
 	struct net_device_stats *stats = &dev->stats;
 	uint8_t isrc, status;
-	int n = 0;
+	irqreturn_t ret = 0;
+	int n = 0, err;
 
 	if (priv->pre_irq)
 		priv->pre_irq(priv);
@@ -546,19 +547,23 @@ irqreturn_t sja1000_interrupt(int irq, void *dev_id)
 		}
 		if (isrc & (IRQ_DOI | IRQ_EI | IRQ_BEI | IRQ_EPI | IRQ_ALI)) {
 			/* error interrupt */
-			if (sja1000_err(dev, isrc, status))
+			err = sja1000_err(dev, isrc, status);
+			if (err)
 				break;
 		}
 		n++;
 	}
 out:
+	if (!ret)
+		ret = (n) ? IRQ_HANDLED : IRQ_NONE;
+
 	if (priv->post_irq)
 		priv->post_irq(priv);
 
 	if (n >= SJA1000_MAX_IRQ)
 		netdev_dbg(dev, "%d messages handled in ISR", n);
 
-	return (n) ? IRQ_HANDLED : IRQ_NONE;
+	return ret;
 }
 EXPORT_SYMBOL_GPL(sja1000_interrupt);
 
-- 
2.40.1




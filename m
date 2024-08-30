Return-Path: <netdev+bounces-123899-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8601B966BF9
	for <lists+netdev@lfdr.de>; Sat, 31 Aug 2024 00:00:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 305CB1F23942
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 22:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D35F1C32F5;
	Fri, 30 Aug 2024 21:59:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023A51C1AD6
	for <netdev@vger.kernel.org>; Fri, 30 Aug 2024 21:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725055169; cv=none; b=G+ie4Y+dkq4QlwO3ZJAvluGoXvj9iRL/30BBzPG4+Twqep+zWWPsSvsJwoXah/TlgzqQjhUOTLdl3wZWSWO106m8W5HGC8YjrSccvKV22zcCulW7HQYDSVmRCumAthn+W5VauAdHqAFNThnrb92G0823yk0mi9QzuVFYeueccxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725055169; c=relaxed/simple;
	bh=nSDzG4x4S/22CPxtI33mPWYOrlAKVQAJy3UlKepe2ps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BBszIa/zqTUPQaYCVbYLyaWyAU5eFYlT6YuzCWStcM3kqH/4jvrk9lWG9DRawIj/cgeTOIpkeKXJIQSvPedz3FsCPp1Gf0bd2d5GwHv+RDeFgOQLcVXJ/yb5C+/Hf/VV7iq11TxU7XU1QYoLKu9NAL9OFTRSY7cYwR6oYAHJt/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sk9eN-0004H0-6D
	for netdev@vger.kernel.org; Fri, 30 Aug 2024 23:59:23 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sk9eL-004FZc-Bd
	for netdev@vger.kernel.org; Fri, 30 Aug 2024 23:59:21 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 074DE32E541
	for <netdev@vger.kernel.org>; Fri, 30 Aug 2024 21:59:20 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id A151832E4EF;
	Fri, 30 Aug 2024 21:59:17 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id d4d60628;
	Fri, 30 Aug 2024 21:59:16 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Martin Jocic <martin.jocic@kvaser.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net 13/13] can: kvaser_pciefd: Use a single write when releasing RX buffers
Date: Fri, 30 Aug 2024 23:53:48 +0200
Message-ID: <20240830215914.1610393-14-mkl@pengutronix.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240830215914.1610393-1-mkl@pengutronix.de>
References: <20240830215914.1610393-1-mkl@pengutronix.de>
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

From: Martin Jocic <martin.jocic@kvaser.com>

Kvaser's PCIe cards uses the KCAN FPGA IP block which has dual 4K
buffers for incoming messages shared by all (currently up to eight)
channels. While the driver processes messages in one buffer, new
incoming messages are stored in the other and so on.

The design of KCAN is such that a buffer must be fully read and then
released. Releasing a buffer will make the FPGA switch buffers. If the
other buffer contains at least one incoming message the FPGA will also
instantly issue a new interrupt, if not the interrupt will be issued
after receiving the first new message.

With IRQx interrupts, it takes a little time for the interrupt to
happen, enough for any previous ISR call to do it's business and
return, but MSI interrupts are way faster so this time is reduced to
almost nothing.

So with MSI, releasing the buffer HAS to be the very last action of
the ISR before returning, otherwise the new interrupt might be
"masked" by the kernel because the previous ISR call hasn't returned.
And the interrupts are edge-triggered so we cannot loose one, or the
ping-pong reading process will stop.

This is why this patch modifies the driver to use a single write to
the SRB_CMD register before returning.

Signed-off-by: Martin Jocic <martin.jocic@kvaser.com>
Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Link: https://patch.msgid.link/20240830153113.2081440-1-martin.jocic@kvaser.com
Fixes: 26ad340e582d ("can: kvaser_pciefd: Add driver for Kvaser PCIEcan devices")
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/kvaser_pciefd.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/net/can/kvaser_pciefd.c b/drivers/net/can/kvaser_pciefd.c
index a60d9efd5f8d..9ffc3ffb4e8f 100644
--- a/drivers/net/can/kvaser_pciefd.c
+++ b/drivers/net/can/kvaser_pciefd.c
@@ -1686,6 +1686,7 @@ static irqreturn_t kvaser_pciefd_irq_handler(int irq, void *dev)
 	const struct kvaser_pciefd_irq_mask *irq_mask = pcie->driver_data->irq_mask;
 	u32 pci_irq = ioread32(KVASER_PCIEFD_PCI_IRQ_ADDR(pcie));
 	u32 srb_irq = 0;
+	u32 srb_release = 0;
 	int i;
 
 	if (!(pci_irq & irq_mask->all))
@@ -1699,17 +1700,14 @@ static irqreturn_t kvaser_pciefd_irq_handler(int irq, void *dev)
 			kvaser_pciefd_transmit_irq(pcie->can[i]);
 	}
 
-	if (srb_irq & KVASER_PCIEFD_SRB_IRQ_DPD0) {
-		/* Reset DMA buffer 0, may trigger new interrupt */
-		iowrite32(KVASER_PCIEFD_SRB_CMD_RDB0,
-			  KVASER_PCIEFD_SRB_ADDR(pcie) + KVASER_PCIEFD_SRB_CMD_REG);
-	}
+	if (srb_irq & KVASER_PCIEFD_SRB_IRQ_DPD0)
+		srb_release |= KVASER_PCIEFD_SRB_CMD_RDB0;
 
-	if (srb_irq & KVASER_PCIEFD_SRB_IRQ_DPD1) {
-		/* Reset DMA buffer 1, may trigger new interrupt */
-		iowrite32(KVASER_PCIEFD_SRB_CMD_RDB1,
-			  KVASER_PCIEFD_SRB_ADDR(pcie) + KVASER_PCIEFD_SRB_CMD_REG);
-	}
+	if (srb_irq & KVASER_PCIEFD_SRB_IRQ_DPD1)
+		srb_release |= KVASER_PCIEFD_SRB_CMD_RDB1;
+
+	if (srb_release)
+		iowrite32(srb_release, KVASER_PCIEFD_SRB_ADDR(pcie) + KVASER_PCIEFD_SRB_CMD_REG);
 
 	return IRQ_HANDLED;
 }
-- 
2.45.2




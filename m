Return-Path: <netdev+bounces-123462-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F9B964EE1
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 21:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 894991F23E5A
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 19:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 689291BA888;
	Thu, 29 Aug 2024 19:30:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5DE1BA285
	for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 19:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724959801; cv=none; b=BNBlbINfCJDGE+rxSJuAq3jGaDlRBQruWlQUSR9gyv5OvlQ6fv7WcHi9+rbueLouYv7Y+0/lSLT0wxZByT4kEnW/Buh4PetcIvA5SdPXHjFgCFk4I+lKLLaKQrwh//gkX+X3M1jYCNrPcGoVdFM2acw8YFt9mWEfEFgPHD9MvvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724959801; c=relaxed/simple;
	bh=+vrFZ/bsF/ac7pfr3aYEdyZAiv7u5jDIM1t4nDMRxX0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gIQgNcfw3DHPIA9eyHrvhZqHZNFa7C5ZlB1lCDWhLfBz2KPAxtpbysNS2COcu+YWfy0Z2EFUs4GQQefv35oXwI4h2BqXxLpocZNuFEm2KLM4bZ514pZDGdzV4mvwTRK9PZNqCzCLDEll50ZP8ZreNMsPOzQKg0pF6BzFEekqMI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sjkqD-00066Z-NE
	for netdev@vger.kernel.org; Thu, 29 Aug 2024 21:29:57 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sjkqA-003yrf-Uw
	for netdev@vger.kernel.org; Thu, 29 Aug 2024 21:29:55 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id A1D6F32D4BE
	for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 19:29:54 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 1929032D474;
	Thu, 29 Aug 2024 19:29:52 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id b1224d51;
	Thu, 29 Aug 2024 19:29:51 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Markus Schneider-Pargmann <msp@baylibre.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net 05/13] can: m_can: Remove m_can_rx_peripheral indirection
Date: Thu, 29 Aug 2024 21:20:38 +0200
Message-ID: <20240829192947.1186760-6-mkl@pengutronix.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240829192947.1186760-1-mkl@pengutronix.de>
References: <20240829192947.1186760-1-mkl@pengutronix.de>
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

From: Markus Schneider-Pargmann <msp@baylibre.com>

m_can_rx_peripheral() is a wrapper around m_can_rx_handler() that calls
m_can_disable_all_interrupts() on error. The same handling for the same
error path is done in m_can_isr() as well.

So remove m_can_rx_peripheral() and do the call from m_can_isr()
directly.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
Link: https://lore.kernel.org/all/20240805183047.305630-4-msp@baylibre.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/m_can/m_can.c | 18 +-----------------
 1 file changed, 1 insertion(+), 17 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index ba416c973e8d..a37ed376de9b 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -1037,22 +1037,6 @@ static int m_can_rx_handler(struct net_device *dev, int quota, u32 irqstatus)
 	return work_done;
 }
 
-static int m_can_rx_peripheral(struct net_device *dev, u32 irqstatus)
-{
-	struct m_can_classdev *cdev = netdev_priv(dev);
-	int work_done;
-
-	work_done = m_can_rx_handler(dev, NAPI_POLL_WEIGHT, irqstatus);
-
-	/* Don't re-enable interrupts if the driver had a fatal error
-	 * (e.g., FIFO read failure).
-	 */
-	if (work_done < 0)
-		m_can_disable_all_interrupts(cdev);
-
-	return work_done;
-}
-
 static int m_can_poll(struct napi_struct *napi, int quota)
 {
 	struct net_device *dev = napi->dev;
@@ -1250,7 +1234,7 @@ static irqreturn_t m_can_isr(int irq, void *dev_id)
 		} else {
 			int pkts;
 
-			pkts = m_can_rx_peripheral(dev, ir);
+			pkts = m_can_rx_handler(dev, NAPI_POLL_WEIGHT, ir);
 			if (pkts < 0)
 				goto out_fail;
 		}
-- 
2.45.2




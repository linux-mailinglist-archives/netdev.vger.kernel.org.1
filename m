Return-Path: <netdev+bounces-147998-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FB399DFC91
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 10:01:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFF071631E2
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 09:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D19991FA15A;
	Mon,  2 Dec 2024 09:00:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DAD11F9F6C
	for <netdev@vger.kernel.org>; Mon,  2 Dec 2024 09:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733130051; cv=none; b=p+Lnsl5pWG9wp0/AAHcmS7LnXbsr4nweHQv8IpmVbsP1DcfqtMhm/KRn+OZsuyk+NyUSAR89Ud9xYbn/PJjcvdB7fkKhzpH0j8sZfORTMtoB9BY4nUgrrfzGt6gKeimgBCfQLdNtQg318xoSrorYnkZP0Lr8RZm23fy5oMTBD+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733130051; c=relaxed/simple;
	bh=qInkAQYF8kEbLEO2aBXr8e0y18l7cLGFYE/vHvAdnFs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qQxmY9Hi57z+E9O40mZK0lV0e/pZjO8SRjYE3aBFaKJ6kMWNL/rd2XtbAnFpqytv+cv+w4VtM5dNEieNl5/UhFb4UDEUpDQGbNvtj9lWHTkNI1PCouFEa3EO5rc2zWDJT4r+OCPL5ixaHNiImrlhyGmnEMJrVYBjd07Egwz0Ahs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tI2IS-0007cE-EP
	for netdev@vger.kernel.org; Mon, 02 Dec 2024 10:00:48 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tI2IQ-001GYF-17
	for netdev@vger.kernel.org;
	Mon, 02 Dec 2024 10:00:47 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id B6C6E38334F
	for <netdev@vger.kernel.org>; Mon, 02 Dec 2024 09:00:46 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id B7C0C38331F;
	Mon, 02 Dec 2024 09:00:44 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id e115a8cb;
	Mon, 2 Dec 2024 09:00:43 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net 04/15] can: sun4i_can: sun4i_can_err(): call can_change_state() even if cf is NULL
Date: Mon,  2 Dec 2024 09:55:38 +0100
Message-ID: <20241202090040.1110280-5-mkl@pengutronix.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241202090040.1110280-1-mkl@pengutronix.de>
References: <20241202090040.1110280-1-mkl@pengutronix.de>
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

From: Dario Binacchi <dario.binacchi@amarulasolutions.com>

Call the function can_change_state() if the allocation of the skb
fails, as it handles the cf parameter when it is null.

Additionally, this ensures that the statistics related to state error
counters (i. e. warning, passive, and bus-off) are updated.

Fixes: 0738eff14d81 ("can: Allwinner A10/A20 CAN Controller support - Kernel module")
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Link: https://patch.msgid.link/20241122221650.633981-3-dario.binacchi@amarulasolutions.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/sun4i_can.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/sun4i_can.c b/drivers/net/can/sun4i_can.c
index 360158c295d3..17f94cca93fb 100644
--- a/drivers/net/can/sun4i_can.c
+++ b/drivers/net/can/sun4i_can.c
@@ -629,10 +629,10 @@ static int sun4i_can_err(struct net_device *dev, u8 isrc, u8 status)
 		tx_state = txerr >= rxerr ? state : 0;
 		rx_state = txerr <= rxerr ? state : 0;
 
-		if (likely(skb))
-			can_change_state(dev, cf, tx_state, rx_state);
-		else
-			priv->can.state = state;
+		/* The skb allocation might fail, but can_change_state()
+		 * handles cf == NULL.
+		 */
+		can_change_state(dev, cf, tx_state, rx_state);
 		if (state == CAN_STATE_BUS_OFF)
 			can_bus_off(dev);
 	}
-- 
2.45.2




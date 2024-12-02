Return-Path: <netdev+bounces-148009-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B40F9DFCA6
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 10:01:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C0C5281CD7
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 09:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 509F91FBE88;
	Mon,  2 Dec 2024 09:00:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF171FA82E
	for <netdev@vger.kernel.org>; Mon,  2 Dec 2024 09:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733130057; cv=none; b=krD4I7dKcijFX2N/JaWnLPf5QUwru5794HhhK5ANqkaqu1egLlJa9tEV7Mt2Mu7vNL3YvnpBxFNsEZ37RYQIWlvN1wmQbd374hhynqsEz4lYd6hxogZPJ7MbpBXT+oh/SQ/O49aWD6//kvXUPclCYhFwZC4oM4wjZbs8Gg3kydE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733130057; c=relaxed/simple;
	bh=p7awPQ9JQQkWRCwMOxdTdFRuiWt5WxjlZtb82lC0anA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PlBmvs+jZ96bx3FwcDxvW2Sis3GCfj7+U+vb+RcwPUtsdaxPK4j9f/tD40tjZPsgKo+rfemK2NrvYLOz/8FgTGIVppODfKqxWd3fVgMSNNuiNUj0kiFjW8mDREIh95DZ/bURQEHkxfi4LeEHpdQNmocw2GEakm03iETqpt+PvK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tI2IW-0007i0-0S
	for netdev@vger.kernel.org; Mon, 02 Dec 2024 10:00:52 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tI2IS-001GcO-1w
	for netdev@vger.kernel.org;
	Mon, 02 Dec 2024 10:00:49 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 0AB8B383399
	for <netdev@vger.kernel.org>; Mon, 02 Dec 2024 09:00:48 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id E5CD538333B;
	Mon, 02 Dec 2024 09:00:45 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 4d0dd13f;
	Mon, 2 Dec 2024 09:00:44 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net 13/15] can: f81604: f81604_handle_can_bus_errors(): fix {rx,tx}_errors statistics
Date: Mon,  2 Dec 2024 09:55:47 +0100
Message-ID: <20241202090040.1110280-14-mkl@pengutronix.de>
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

The f81604_handle_can_bus_errors() function only incremented the receive
error counter and never the transmit error counter, even if the ECC_DIR
flag reported that an error had occurred during transmission.

Increment the receive/transmit error counter based on the value of the
ECC_DIR flag.

Fixes: 88da17436973 ("can: usb: f81604: add Fintek F81604 support")
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Link: https://patch.msgid.link/20241122221650.633981-13-dario.binacchi@amarulasolutions.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/f81604.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/usb/f81604.c b/drivers/net/can/usb/f81604.c
index bc0c8903fe77..e0cfa1460b0b 100644
--- a/drivers/net/can/usb/f81604.c
+++ b/drivers/net/can/usb/f81604.c
@@ -526,7 +526,6 @@ static void f81604_handle_can_bus_errors(struct f81604_port_priv *priv,
 		netdev_dbg(netdev, "bus error interrupt\n");
 
 		priv->can.can_stats.bus_error++;
-		stats->rx_errors++;
 
 		if (skb) {
 			cf->can_id |= CAN_ERR_PROT | CAN_ERR_BUSERROR;
@@ -548,10 +547,15 @@ static void f81604_handle_can_bus_errors(struct f81604_port_priv *priv,
 
 			/* set error location */
 			cf->data[3] = data->ecc & F81604_SJA1000_ECC_SEG;
+		}
 
-			/* Error occurred during transmission? */
-			if ((data->ecc & F81604_SJA1000_ECC_DIR) == 0)
+		/* Error occurred during transmission? */
+		if ((data->ecc & F81604_SJA1000_ECC_DIR) == 0) {
+			stats->tx_errors++;
+			if (skb)
 				cf->data[2] |= CAN_ERR_PROT_TX;
+		} else {
+			stats->rx_errors++;
 		}
 
 		set_bit(F81604_CLEAR_ECC, &priv->clear_flags);
-- 
2.45.2




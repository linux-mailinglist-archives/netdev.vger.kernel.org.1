Return-Path: <netdev+bounces-115971-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A646948A70
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 09:48:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B1581C21550
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 07:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4748C1BD4EB;
	Tue,  6 Aug 2024 07:47:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE40161310
	for <netdev@vger.kernel.org>; Tue,  6 Aug 2024 07:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722930467; cv=none; b=BMcqr2tcDgqafE8t46DDfV9Y/q2iCgNw1JV4uHIC0H9jARitjt8Px1VK4O7zJVDcUm90n7q4qjg8k7LFFNoY83IcGBrbAgSEhKDpcEJMihhqVn3ZbVgUzeaG/b8P1dAYA9auWmKA8x7k0h1h+RAmP0EgMrxfCRjINgEfeh01L4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722930467; c=relaxed/simple;
	bh=cAX/AyCl9IPg2U5P1BK0BgS+iHguEM6fkOB9BW0DN6I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L4N2pEmzGbFksk+TKmfAKDG8spmG2Qce5ZmbvbTDy7mwFkVRaiv7zQoj3WG7yS6yCyzJQo3n4GoOhLydMv3mwo0jGoo/OV/apwgXbAMUnBam7UfGbmOqUdXocaezxg1AaYTX0+Ne5nqsKKnqGRnigtVU+ymBfAVruK9XCCUv+mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sbEuz-000478-W0
	for netdev@vger.kernel.org; Tue, 06 Aug 2024 09:47:42 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sbEuv-004tt4-Ky
	for netdev@vger.kernel.org; Tue, 06 Aug 2024 09:47:37 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 366F93179E4
	for <netdev@vger.kernel.org>; Tue, 06 Aug 2024 07:47:37 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 2719C31797B;
	Tue, 06 Aug 2024 07:47:34 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 1714af3a;
	Tue, 6 Aug 2024 07:47:33 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Jimmy Assarsson <extja@kvaser.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 08/20] can: kvaser_usb: hydra: Add struct for Tx ACK commands
Date: Tue,  6 Aug 2024 09:41:59 +0200
Message-ID: <20240806074731.1905378-9-mkl@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240806074731.1905378-1-mkl@pengutronix.de>
References: <20240806074731.1905378-1-mkl@pengutronix.de>
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

From: Jimmy Assarsson <extja@kvaser.com>

Add, struct kvaser_cmd_tx_ack, for standard Tx ACK commands.

Expand kvaser_usb_hydra_ktime_from_cmd() to extract timestamps from both
standard and extended Tx ACK commands. Unsupported commands are silently
ignored, and 0 is returned.

Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Link: https://lore.kernel.org/all/20240701154936.92633-4-extja@kvaser.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 .../net/can/usb/kvaser_usb/kvaser_usb_hydra.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
index 84f1f1f9c107..f102f9de7d16 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
@@ -261,6 +261,15 @@ struct kvaser_cmd_tx_can {
 	u8 reserved[11];
 } __packed;
 
+struct kvaser_cmd_tx_ack {
+	__le32 id;
+	u8 data[8];
+	u8 dlc;
+	u8 flags;
+	__le16 timestamp[3];
+	u8 reserved0[8];
+} __packed;
+
 struct kvaser_cmd_header {
 	u8 cmd_no;
 	/* The destination HE address is stored in 0..5 of he_addr.
@@ -297,6 +306,7 @@ struct kvaser_cmd {
 
 		struct kvaser_cmd_rx_can rx_can;
 		struct kvaser_cmd_tx_can tx_can;
+		struct kvaser_cmd_tx_ack tx_ack;
 	} __packed;
 } __packed;
 
@@ -530,9 +540,14 @@ static ktime_t kvaser_usb_hydra_ktime_from_cmd(const struct kvaser_usb_dev_cfg *
 	if (cmd->header.cmd_no == CMD_EXTENDED) {
 		struct kvaser_cmd_ext *cmd_ext = (struct kvaser_cmd_ext *)cmd;
 
-		hwtstamp = kvaser_usb_timestamp64_to_ktime(cfg, cmd_ext->rx_can.timestamp);
-	} else {
+		if (cmd_ext->cmd_no_ext == CMD_RX_MESSAGE_FD)
+			hwtstamp = kvaser_usb_timestamp64_to_ktime(cfg, cmd_ext->rx_can.timestamp);
+		else if (cmd_ext->cmd_no_ext == CMD_TX_ACKNOWLEDGE_FD)
+			hwtstamp = kvaser_usb_timestamp64_to_ktime(cfg, cmd_ext->tx_ack.timestamp);
+	} else if (cmd->header.cmd_no == CMD_RX_MESSAGE) {
 		hwtstamp = kvaser_usb_timestamp48_to_ktime(cfg, cmd->rx_can.timestamp);
+	} else if (cmd->header.cmd_no == CMD_TX_ACKNOWLEDGE) {
+		hwtstamp = kvaser_usb_timestamp48_to_ktime(cfg, cmd->tx_ack.timestamp);
 	}
 
 	return hwtstamp;
-- 
2.43.0




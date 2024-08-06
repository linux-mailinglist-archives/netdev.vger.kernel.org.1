Return-Path: <netdev+bounces-115980-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C7E2948A7C
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 09:48:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB2071F24164
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 07:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 197341BDAA6;
	Tue,  6 Aug 2024 07:47:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2C81BCA1A
	for <netdev@vger.kernel.org>; Tue,  6 Aug 2024 07:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722930469; cv=none; b=Y2E/C21gQ3r+RI/mpXDoI+MMDtMEQFlHZYdriPYH0lF8AAL4uxvc78MsVUYZ+O0Tvdiuah+HSzcJlqAlyIc/lCPOX9N6IHqg+lzZVJozS5xNcDzNc3hsrgHCvuqwfUbJj9zeAuMOnX3hTpNfscg82tRmShhswntwajcTsRlUz1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722930469; c=relaxed/simple;
	bh=GrF2a6BfLgUqK1Cjm0Yo9MGfUEptD/IgJ+sbDs3Q5xo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KhyEBW472ZzZNRZpa/4Fsi9oCervCSojx4ZY0rBppL6IPDc5OjgmvdhU4oBCUHPpw1SQjcBh9AC39KzdcAXOMc0jXXo3zrhXN3xLtbPbggwecV1U+vLIsPYmWcxMgClN9OYrBhC01OUk0UToF9KQUNiROFm/oXxv3FciW3fXR6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sbEv1-00048S-Rm
	for netdev@vger.kernel.org; Tue, 06 Aug 2024 09:47:43 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sbEuw-004tub-Ng
	for netdev@vger.kernel.org; Tue, 06 Aug 2024 09:47:38 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 29497317A0A
	for <netdev@vger.kernel.org>; Tue, 06 Aug 2024 07:47:38 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id C765231798F;
	Tue, 06 Aug 2024 07:47:34 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id beeb9c7b;
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
Subject: [PATCH net-next 15/20] can: kvaser_usb: leaf: Add structs for Tx ACK and clock overflow commands
Date: Tue,  6 Aug 2024 09:42:06 +0200
Message-ID: <20240806074731.1905378-16-mkl@pengutronix.de>
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

For usbcan devices (M16C), add struct usbcan_cmd_tx_acknowledge for Tx ACK
commands and struct usbcan_cmd_clk_overflow_event for clock overflow event
commands.

Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Link: https://lore.kernel.org/all/20240701154936.92633-11-extja@kvaser.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 .../net/can/usb/kvaser_usb/kvaser_usb_leaf.c  | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
index 5839333eb5ae..2c0313c8f63e 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
@@ -242,6 +242,13 @@ struct leaf_cmd_tx_acknowledge {
 	u8 padding[2];
 } __packed;
 
+struct usbcan_cmd_tx_acknowledge {
+	u8 channel;
+	u8 tid;
+	__le16 time;
+	u8 padding[2];
+} __packed;
+
 struct leaf_cmd_can_error_event {
 	u8 tid;
 	u8 flags;
@@ -288,6 +295,12 @@ struct usbcan_cmd_error_event {
 	__le16 padding;
 } __packed;
 
+struct usbcan_cmd_clk_overflow_event {
+	u8 tid;
+	u8 padding;
+	__le32 time;
+} __packed;
+
 struct kvaser_cmd_ctrl_mode {
 	u8 tid;
 	u8 channel;
@@ -363,6 +376,8 @@ struct kvaser_cmd {
 			struct usbcan_cmd_chip_state_event chip_state_event;
 			struct usbcan_cmd_can_error_event can_error_event;
 			struct usbcan_cmd_error_event error_event;
+			struct usbcan_cmd_tx_acknowledge tx_ack;
+			struct usbcan_cmd_clk_overflow_event clk_overflow_event;
 		} __packed usbcan;
 
 		struct kvaser_cmd_tx_can tx_can;
@@ -396,7 +411,7 @@ static const u8 kvaser_usb_leaf_cmd_sizes_usbcan[] = {
 	[CMD_START_CHIP_REPLY]		= kvaser_fsize(u.simple),
 	[CMD_STOP_CHIP_REPLY]		= kvaser_fsize(u.simple),
 	[CMD_GET_CARD_INFO_REPLY]	= kvaser_fsize(u.cardinfo),
-	[CMD_TX_ACKNOWLEDGE]		= kvaser_fsize(u.tx_acknowledge_header),
+	[CMD_TX_ACKNOWLEDGE]		= kvaser_fsize(u.usbcan.tx_ack),
 	[CMD_GET_SOFTWARE_INFO_REPLY]	= kvaser_fsize(u.usbcan.softinfo),
 	[CMD_RX_STD_MESSAGE]		= kvaser_fsize(u.usbcan.rx_can),
 	[CMD_RX_EXT_MESSAGE]		= kvaser_fsize(u.usbcan.rx_can),
@@ -404,7 +419,7 @@ static const u8 kvaser_usb_leaf_cmd_sizes_usbcan[] = {
 	[CMD_CAN_ERROR_EVENT]		= kvaser_fsize(u.usbcan.can_error_event),
 	[CMD_ERROR_EVENT]		= kvaser_fsize(u.usbcan.error_event),
 	/* ignored events: */
-	[CMD_USBCAN_CLOCK_OVERFLOW_EVENT] = CMD_SIZE_ANY,
+	[CMD_USBCAN_CLOCK_OVERFLOW_EVENT] = kvaser_fsize(u.usbcan.clk_overflow_event),
 };
 
 /* Summary of a kvaser error event, for a unified Leaf/Usbcan error
-- 
2.43.0




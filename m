Return-Path: <netdev+bounces-115977-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F08A948A79
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 09:48:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD74F28354F
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 07:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07D721BDA98;
	Tue,  6 Aug 2024 07:47:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D951BCA09
	for <netdev@vger.kernel.org>; Tue,  6 Aug 2024 07:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722930468; cv=none; b=B4eYFnfwfmY6XbsecDRRcZPgopdQn2MwHQuzWCqrnWcBfVsdWHz/TNZfRzHfFU6U2xvZ5H+txQAnv9uRGiTOphfZWjUu9VWkzIkwGpQNHXpTI37bNQNQ6/ORZtlcRFq9r4iz/+NSmjd/znjrOb46uCILmBYicPpv4xF4LnAFj2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722930468; c=relaxed/simple;
	bh=cCU3R/hxWqICa9KiROaA4sol166IrTzQYPPF0B2j/D8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=twzGsAE+Sat0Ax2cDjE9gX2Spy+0N5I0LZTJSdIBd8N564Zw3oF/wqX8im4vzIG2k3di9i3s6dtZsfrgf4jYvlfdk6NoGX9RCne7lVeVWRv7djBQqLWlcmXMOOeNE+I9d8x25gK48zp2Hnb8sAiXFNW6mOkeC645kPA2pY7vxPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sbEv1-000483-8n
	for netdev@vger.kernel.org; Tue, 06 Aug 2024 09:47:43 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sbEuw-004tuF-EQ
	for netdev@vger.kernel.org; Tue, 06 Aug 2024 09:47:38 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id E7B82317A02
	for <netdev@vger.kernel.org>; Tue, 06 Aug 2024 07:47:37 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 9C19D31798B;
	Tue, 06 Aug 2024 07:47:34 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id d3e8e3d9;
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
Subject: [PATCH net-next 14/20] can: kvaser_usb: leaf: Add hardware timestamp support to leaf based devices
Date: Tue,  6 Aug 2024 09:42:05 +0200
Message-ID: <20240806074731.1905378-15-mkl@pengutronix.de>
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

Add hardware timestamp support to leaf based devices (M32C and leafimx).

Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Link: https://lore.kernel.org/all/20240701154936.92633-10-extja@kvaser.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c | 11 +++++++----
 drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c | 15 +++++++++++++++
 2 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
index daa34b532aa8..b5d762d38d5d 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
@@ -106,14 +106,16 @@ static const struct kvaser_usb_driver_info kvaser_usb_driver_info_usbcan = {
 };
 
 static const struct kvaser_usb_driver_info kvaser_usb_driver_info_leaf = {
-	.quirks = KVASER_USB_QUIRK_IGNORE_CLK_FREQ,
+	.quirks = KVASER_USB_QUIRK_IGNORE_CLK_FREQ |
+		  KVASER_USB_QUIRK_HAS_HARDWARE_TIMESTAMP,
 	.family = KVASER_LEAF,
 	.ops = &kvaser_usb_leaf_dev_ops,
 };
 
 static const struct kvaser_usb_driver_info kvaser_usb_driver_info_leaf_err = {
 	.quirks = KVASER_USB_QUIRK_HAS_TXRX_ERRORS |
-		  KVASER_USB_QUIRK_IGNORE_CLK_FREQ,
+		  KVASER_USB_QUIRK_IGNORE_CLK_FREQ |
+		  KVASER_USB_QUIRK_HAS_HARDWARE_TIMESTAMP,
 	.family = KVASER_LEAF,
 	.ops = &kvaser_usb_leaf_dev_ops,
 };
@@ -121,13 +123,14 @@ static const struct kvaser_usb_driver_info kvaser_usb_driver_info_leaf_err = {
 static const struct kvaser_usb_driver_info kvaser_usb_driver_info_leaf_err_listen = {
 	.quirks = KVASER_USB_QUIRK_HAS_TXRX_ERRORS |
 		  KVASER_USB_QUIRK_HAS_SILENT_MODE |
-		  KVASER_USB_QUIRK_IGNORE_CLK_FREQ,
+		  KVASER_USB_QUIRK_IGNORE_CLK_FREQ |
+		  KVASER_USB_QUIRK_HAS_HARDWARE_TIMESTAMP,
 	.family = KVASER_LEAF,
 	.ops = &kvaser_usb_leaf_dev_ops,
 };
 
 static const struct kvaser_usb_driver_info kvaser_usb_driver_info_leafimx = {
-	.quirks = 0,
+	.quirks = KVASER_USB_QUIRK_HAS_HARDWARE_TIMESTAMP,
 	.family = KVASER_LEAF,
 	.ops = &kvaser_usb_leaf_dev_ops,
 };
diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
index caef1f26a95c..5839333eb5ae 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
@@ -915,6 +915,8 @@ static void kvaser_usb_leaf_tx_acknowledge(const struct kvaser_usb *dev,
 	struct kvaser_usb_net_priv *priv;
 	unsigned long flags;
 	u8 channel, tid;
+	struct sk_buff *skb;
+	ktime_t hwtstamp = 0;
 
 	channel = cmd->u.tx_acknowledge_header.channel;
 	tid = cmd->u.tx_acknowledge_header.tid;
@@ -954,9 +956,19 @@ static void kvaser_usb_leaf_tx_acknowledge(const struct kvaser_usb *dev,
 
 		priv->can.state = CAN_STATE_ERROR_ACTIVE;
 	}
+	switch (dev->driver_info->family) {
+	case KVASER_LEAF:
+		hwtstamp = kvaser_usb_timestamp48_to_ktime(dev->cfg, cmd->u.leaf.tx_ack.time);
+		break;
+	case KVASER_USBCAN:
+		break;
+	}
 
 	spin_lock_irqsave(&priv->tx_contexts_lock, flags);
 
+	skb = priv->can.echo_skb[context->echo_index];
+	if (skb)
+		skb_hwtstamps(skb)->hwtstamp = hwtstamp;
 	stats->tx_packets++;
 	stats->tx_bytes += can_get_echo_skb(priv->netdev,
 					    context->echo_index, NULL);
@@ -1334,6 +1346,7 @@ static void kvaser_usb_leaf_rx_can_msg(const struct kvaser_usb *dev,
 	struct net_device_stats *stats;
 	u8 channel = cmd->u.rx_can_header.channel;
 	const u8 *rx_data = NULL;	/* GCC */
+	ktime_t hwtstamp = 0;
 
 	if (channel >= dev->nchannels) {
 		dev_err(&dev->intf->dev,
@@ -1364,6 +1377,7 @@ static void kvaser_usb_leaf_rx_can_msg(const struct kvaser_usb *dev,
 	switch (dev->driver_info->family) {
 	case KVASER_LEAF:
 		rx_data = cmd->u.leaf.rx_can.data;
+		hwtstamp = kvaser_usb_timestamp48_to_ktime(dev->cfg, cmd->u.leaf.rx_can.time);
 		break;
 	case KVASER_USBCAN:
 		rx_data = cmd->u.usbcan.rx_can.data;
@@ -1410,6 +1424,7 @@ static void kvaser_usb_leaf_rx_can_msg(const struct kvaser_usb *dev,
 			memcpy(cf->data, &rx_data[6], cf->len);
 	}
 
+	skb_hwtstamps(skb)->hwtstamp = hwtstamp;
 	stats->rx_packets++;
 	if (!(cf->can_id & CAN_RTR_FLAG))
 		stats->rx_bytes += cf->len;
-- 
2.43.0




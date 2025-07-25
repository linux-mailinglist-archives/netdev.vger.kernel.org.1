Return-Path: <netdev+bounces-210100-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7193B121AC
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 18:16:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E223586B07
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 16:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 085B02F0C53;
	Fri, 25 Jul 2025 16:13:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9FD62F0042
	for <netdev@vger.kernel.org>; Fri, 25 Jul 2025 16:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753460025; cv=none; b=K4oL5fRkko9ut14UN/rS+Kuu0V7S8uMhs4UfgtwnYsWm/5Sj0gs+vXT5XcfisllT/gl/Sh+v9c2xgjz3uSmVlgyv2V3znQTV0EVG6YeMD2xw90/hDYPgfhRIDJ0mSfYDEkG/mw7TSTTRDyrJOUUbDAINqCJDPyFGPS5ON2uq5/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753460025; c=relaxed/simple;
	bh=7iTuLrU8ZoVy3zqWMY/i818AZPaFYYqdOjWlYCAeTeM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oQnHI/jkIJYjDR+SuQ0b7d9byJfkckyaITWkWNukhY6me1J7MdvTNwHqjjjUxSqv9OqsL9HlVRsOd9VQdfeRwg35vnZpXS+kUpcxsOhT5UR9mQ4ah55gvw+L/2NvwwUNu35EijuT7lVRDkTIONBTFtN6S5BWzolUcPL9Gcui/hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1ufL3E-0006jT-OC
	for netdev@vger.kernel.org; Fri, 25 Jul 2025 18:13:40 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1ufL3A-00AFcW-2X
	for netdev@vger.kernel.org;
	Fri, 25 Jul 2025 18:13:36 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 4FB1B4498E0
	for <netdev@vger.kernel.org>; Fri, 25 Jul 2025 16:13:35 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 0B6A444982E;
	Fri, 25 Jul 2025 16:13:31 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id ae327742;
	Fri, 25 Jul 2025 16:13:30 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Jimmy Assarsson <extja@kvaser.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 18/27] can: kvaser_usb: Add support for ethtool set_phys_id()
Date: Fri, 25 Jul 2025 18:05:28 +0200
Message-ID: <20250725161327.4165174-19-mkl@pengutronix.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250725161327.4165174-1-mkl@pengutronix.de>
References: <20250725161327.4165174-1-mkl@pengutronix.de>
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

Add support for ethtool set_phys_id(), to physically locate devices by
flashing a LED on the device.

Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
Link: https://patch.msgid.link/20250725123452.41-3-extja@kvaser.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 .../net/can/usb/kvaser_usb/kvaser_usb_core.c  | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
index daf42080f942..c74875f978c4 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
@@ -753,6 +753,31 @@ static netdev_tx_t kvaser_usb_start_xmit(struct sk_buff *skb,
 	return ret;
 }
 
+static int kvaser_usb_set_phys_id(struct net_device *netdev,
+				  enum ethtool_phys_id_state state)
+{
+	struct kvaser_usb_net_priv *priv = netdev_priv(netdev);
+	const struct kvaser_usb_dev_ops *ops = priv->dev->driver_info->ops;
+
+	switch (state) {
+	case ETHTOOL_ID_ACTIVE:
+		return 3; /* 3 On/Off cycles per second */
+
+	case ETHTOOL_ID_ON:
+		return ops->dev_set_led(priv, KVASER_USB_LED_ON, 1000);
+
+	case ETHTOOL_ID_OFF:
+		return ops->dev_set_led(priv, KVASER_USB_LED_OFF, 1000);
+
+	case ETHTOOL_ID_INACTIVE:
+		/* Turn LED off and restore standard function after 1ms */
+		return ops->dev_set_led(priv, KVASER_USB_LED_OFF, 1);
+
+	default:
+		return -EINVAL;
+	}
+}
+
 static const struct net_device_ops kvaser_usb_netdev_ops = {
 	.ndo_open = kvaser_usb_open,
 	.ndo_stop = kvaser_usb_close,
@@ -763,6 +788,7 @@ static const struct net_device_ops kvaser_usb_netdev_ops = {
 
 static const struct ethtool_ops kvaser_usb_ethtool_ops = {
 	.get_ts_info = can_ethtool_op_get_ts_info_hwts,
+	.set_phys_id = kvaser_usb_set_phys_id,
 };
 
 static void kvaser_usb_remove_interfaces(struct kvaser_usb *dev)
-- 
2.47.2




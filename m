Return-Path: <netdev+bounces-148898-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73F6A9E35B1
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 09:42:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BEAF165767
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 08:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF0DC1ABED7;
	Wed,  4 Dec 2024 08:41:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1DE51991CD
	for <netdev@vger.kernel.org>; Wed,  4 Dec 2024 08:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733301717; cv=none; b=YhrkuLYAaos5uIOlNudB7I+VrxQOpIiyz0KMSTvm9ODJ9dr+3p7b5IOeNre6zgyC0R3MeguPAcKoyfANd3xllvm3+kF4F0yVFjqasO03w8trSt+lSO1Qv3EAJ7uk64sl7rlqmGbY67FMEMCPztKqmynlmw+65c9Z/y/VUGHfVY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733301717; c=relaxed/simple;
	bh=u33syiicEIaonuoBeEib0kONlZukMcsn71SdeVu9Azo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A/sSWG1nj6GWVmemSIe0dNHzGhtXwQdua/3RloXJtljwHUa/mKVsIRwGT1b75kHHFN8Izqa+mYXVxdNLaJJidmoT2lEJ/kQoM75w9q6SbfjgotMkVcBpF73oyoc2bFVtinbgEMwbw3X+H1AitS8dQJGQKUR5lAitzIJFEuYoL+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tIkx7-0001I7-46; Wed, 04 Dec 2024 09:41:45 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tIkx5-001cUL-0z;
	Wed, 04 Dec 2024 09:41:44 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tIkx5-004ptq-36;
	Wed, 04 Dec 2024 09:41:43 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	Andrew Lunn <andrew@lunn.ch>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com,
	Phil Elwell <phil@raspberrypi.org>
Subject: [PATCH net-next v2 08/10] net: usb: lan78xx: Add error handling to set_rx_max_frame_length and set_mtu
Date: Wed,  4 Dec 2024 09:41:40 +0100
Message-Id: <20241204084142.1152696-9-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241204084142.1152696-1-o.rempel@pengutronix.de>
References: <20241204084142.1152696-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

Improve error handling in `lan78xx_set_rx_max_frame_length` by:
- Checking return values from register read/write operations and
  propagating errors.
- Exiting immediately on failure to ensure proper error reporting.

In `lan78xx_change_mtu`, log errors when changing MTU fails, using `%pe`
for clear error representation.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/usb/lan78xx.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index 33cda7f3dd12..2d16c1fc850e 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -2599,27 +2599,36 @@ static int lan78xx_phy_init(struct lan78xx_net *dev)
 
 static int lan78xx_set_rx_max_frame_length(struct lan78xx_net *dev, int size)
 {
-	u32 buf;
 	bool rxenabled;
+	u32 buf;
+	int ret;
 
-	lan78xx_read_reg(dev, MAC_RX, &buf);
+	ret = lan78xx_read_reg(dev, MAC_RX, &buf);
+	if (ret < 0)
+		return ret;
 
 	rxenabled = ((buf & MAC_RX_RXEN_) != 0);
 
 	if (rxenabled) {
 		buf &= ~MAC_RX_RXEN_;
-		lan78xx_write_reg(dev, MAC_RX, buf);
+		ret = lan78xx_write_reg(dev, MAC_RX, buf);
+		if (ret < 0)
+			return ret;
 	}
 
 	/* add 4 to size for FCS */
 	buf &= ~MAC_RX_MAX_SIZE_MASK_;
 	buf |= (((size + 4) << MAC_RX_MAX_SIZE_SHIFT_) & MAC_RX_MAX_SIZE_MASK_);
 
-	lan78xx_write_reg(dev, MAC_RX, buf);
+	ret = lan78xx_write_reg(dev, MAC_RX, buf);
+	if (ret < 0)
+		return ret;
 
 	if (rxenabled) {
 		buf |= MAC_RX_RXEN_;
-		lan78xx_write_reg(dev, MAC_RX, buf);
+		ret = lan78xx_write_reg(dev, MAC_RX, buf);
+		if (ret < 0)
+			return ret;
 	}
 
 	return 0;
@@ -2685,7 +2694,10 @@ static int lan78xx_change_mtu(struct net_device *netdev, int new_mtu)
 		return ret;
 
 	ret = lan78xx_set_rx_max_frame_length(dev, max_frame_len);
-	if (!ret)
+	if (ret < 0)
+		netdev_err(dev->net, "MTU changed to %d from %d failed with %pe\n",
+			   new_mtu, netdev->mtu, ERR_PTR(ret));
+	else
 		WRITE_ONCE(netdev->mtu, new_mtu);
 
 	usb_autopm_put_interface(dev->intf);
-- 
2.39.5



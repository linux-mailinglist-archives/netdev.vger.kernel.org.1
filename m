Return-Path: <netdev+bounces-80278-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB3AE87E07B
	for <lists+netdev@lfdr.de>; Sun, 17 Mar 2024 22:46:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FB3E281F8C
	for <lists+netdev@lfdr.de>; Sun, 17 Mar 2024 21:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88972208C3;
	Sun, 17 Mar 2024 21:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="hPEJYq4R"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B155219EB
	for <netdev@vger.kernel.org>; Sun, 17 Mar 2024 21:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710711957; cv=none; b=e+StkDuh0Fx4hxQht+H0iuTM30lHcOi774Q2wZ/rr4BxixUSbe7Mb0/sCR2g4zHi4CIccn6D4iKCV41tTIM5oQop7o4f2mkPCgWSz/CDqdDe/VsUIvTUl8P9wT5tQ/XHSY0LMl8ZsnuOcoPCAQsclaoLkFgwu4m/6ZFh7oe9UgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710711957; c=relaxed/simple;
	bh=7REgVx3Hk+G70l5YOIE6zqEavzl38e/93gZxmXsSzgA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rv/DIEmn6z6MakKPwTxJzmPPqctnO4KhWxdlWvA6Wu/llS3MVautoAv1FLbbuAvxJSb0RG1lewaAvHV/uZ2fjc5L0vln89q8JaOfks4o9J9EYgaeq3rUE6j1kRYZKadQ0Iqwyu695+qt4bmxDQX4KBXhvKQtbqmLib3Ny9L4BdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=hPEJYq4R; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=iHiJcTca4uqI5eVNh//6Wjc2B/iJjDsQUALvb+o+t0E=; b=hP
	EJYq4RYDgyN5aStus78jQtE9ismb/7j4owckxA72Q8w5tndDtT4eHQb/sFBid1Iohi3//h7Pu9LOD
	BU+GpREXexrqGwwS15vXmvi2kjAQSpIMDObqE/81MxUkY/RdaZxU8OPAka7kw2h/E8V6EAeBGtICw
	iLUjIR3JB0k7uds=;
Received: from c-76-156-36-110.hsd1.mn.comcast.net ([76.156.36.110] helo=thinkpad.home.lunn.ch)
	by vps0.lunn.ch with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rlyKG-00AYv5-Fr; Sun, 17 Mar 2024 22:45:52 +0100
From: Andrew Lunn <andrew@lunn.ch>
Date: Sun, 17 Mar 2024 16:45:17 -0500
Subject: [PATCH RFC 4/7] net: dsa: mv88e6xxx: Tie the low level LED
 functions to device ops
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240317-v6-8-0-net-next-mv88e6xxx-leds-v4-v1-4-80a4e6c6293e@lunn.ch>
References: <20240317-v6-8-0-net-next-mv88e6xxx-leds-v4-v1-0-80a4e6c6293e@lunn.ch>
In-Reply-To: <20240317-v6-8-0-net-next-mv88e6xxx-leds-v4-v1-0-80a4e6c6293e@lunn.ch>
To: Florian Fainelli <f.fainelli@gmail.com>, 
 Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Russell King <linux@armlinux.org.uk>, 
 Gregory Clement <gregory.clement@bootlin.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2653; i=andrew@lunn.ch;
 h=from:subject:message-id; bh=7REgVx3Hk+G70l5YOIE6zqEavzl38e/93gZxmXsSzgA=;
 b=owEBbQKS/ZANAwAKAea/DcumaUyEAcsmYgBl92SC1z3kofFxFIrP/ZVj8eLftmqLQeCY05X05
 ivueIykLwmJAjMEAAEKAB0WIQRh+xAly1MmORb54bfmvw3LpmlMhAUCZfdkggAKCRDmvw3LpmlM
 hBuxEACWXhEVcxdZnPtOZiA70PydYkXSQQGrcdkfaoOJqIqCDDRr13KgN23KaD1x8H5IBTOdHSX
 wC3PavyWiWNhV/CnIgS7wByqor1LJkrjrZBDNFzh9C+0RfjeDNdMcppLhabcWVfrGMKIMYWs84d
 1KirljXyyC0Mg+0kC8vogZtQxNEL7DxjAH42QosHsOSDFsnrqzyAHcBJnWmErRQEOQQf62gTy4F
 +a+ylfOlyMDPqaxZrG79WQbGEJR2XRWx4+PQYuxgfcrCmWX8VjlfVgBnQMUgU4alq7eE6LasIyj
 D+8jatU0X7ZW+2bK6niMChC1AJX1HZMoyAXF3AAGLSJmKU1vdvrGVClxIbU/JuxF+W6zPMOi0J2
 3/eXknWPy7BHaN69ni4hAF+X9sD0ANHSeKTvFzkCz9CFuu/0/d9ykefYLi2UYzSphrKZv2iaiYs
 Scl53xxysf5xGVLyZATkbxxzbp1q9tSbZSc1vpnxebPM6GzdUW+a6Fw8Y+VRN8poilbog2ioGaH
 Dmruamz9buGfZj2pu+6JSSfs/7M6GRX2ujMwRe2D9YMNW6c2X6n3nOhvW3v+DPSlDyaxuHv5/3Q
 N9jBBMw1JhhofmhbHEzIYy6norBhjoPCpdb1xwmeVjon+roHWwQ2HTI0S3xVUZ8L/2kZ3Re9Xoj
 +dngTpRuui0iwmQ==
X-Developer-Key: i=andrew@lunn.ch; a=openpgp;
 fpr=61FB1025CB53263916F9E1B7E6BF0DCBA6694C84

Make the LED brightness and blink helpers available for the 6352
family via their ops structure.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/dsa/mv88e6xxx/chip.c | 8 ++++++++
 drivers/net/dsa/mv88e6xxx/chip.h | 7 +++++++
 2 files changed, 15 insertions(+)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 9ed1821184ec..3d7e4aa9293a 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -4526,6 +4526,8 @@ static const struct mv88e6xxx_ops mv88e6172_ops = {
 	.gpio_ops = &mv88e6352_gpio_ops,
 	.phylink_get_caps = mv88e6352_phylink_get_caps,
 	.pcs_ops = &mv88e6352_pcs_ops,
+	.led_brightness_set = mv88e6352_port_led_brightness_set,
+	.led_blink_set = mv88e6352_port_led_blink_set,
 };
 
 static const struct mv88e6xxx_ops mv88e6175_ops = {
@@ -4628,6 +4630,8 @@ static const struct mv88e6xxx_ops mv88e6176_ops = {
 	.gpio_ops = &mv88e6352_gpio_ops,
 	.phylink_get_caps = mv88e6352_phylink_get_caps,
 	.pcs_ops = &mv88e6352_pcs_ops,
+	.led_brightness_set = mv88e6352_port_led_brightness_set,
+	.led_blink_set = mv88e6352_port_led_blink_set,
 };
 
 static const struct mv88e6xxx_ops mv88e6185_ops = {
@@ -4897,6 +4901,8 @@ static const struct mv88e6xxx_ops mv88e6240_ops = {
 	.ptp_ops = &mv88e6352_ptp_ops,
 	.phylink_get_caps = mv88e6352_phylink_get_caps,
 	.pcs_ops = &mv88e6352_pcs_ops,
+	.led_brightness_set = mv88e6352_port_led_brightness_set,
+	.led_blink_set = mv88e6352_port_led_blink_set,
 };
 
 static const struct mv88e6xxx_ops mv88e6250_ops = {
@@ -5310,6 +5316,8 @@ static const struct mv88e6xxx_ops mv88e6352_ops = {
 	.serdes_set_tx_amplitude = mv88e6352_serdes_set_tx_amplitude,
 	.phylink_get_caps = mv88e6352_phylink_get_caps,
 	.pcs_ops = &mv88e6352_pcs_ops,
+	.led_brightness_set = mv88e6352_port_led_brightness_set,
+	.led_blink_set = mv88e6352_port_led_blink_set,
 };
 
 static const struct mv88e6xxx_ops mv88e6390_ops = {
diff --git a/drivers/net/dsa/mv88e6xxx/chip.h b/drivers/net/dsa/mv88e6xxx/chip.h
index 85eb293381a7..64f8bde68ccf 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.h
+++ b/drivers/net/dsa/mv88e6xxx/chip.h
@@ -661,6 +661,13 @@ struct mv88e6xxx_ops {
 
 	/* Max Frame Size */
 	int (*set_max_frame_size)(struct mv88e6xxx_chip *chip, int mtu);
+
+	/* LEDs */
+	int (*led_brightness_set)(struct mv88e6xxx_chip *chip, int port,
+				  u8 led, enum led_brightness value);
+	int (*led_blink_set)(struct mv88e6xxx_chip *chip, int port, u8 led,
+			     unsigned long *delay_on,
+			     unsigned long *delay_off);
 };
 
 struct mv88e6xxx_irq_ops {

-- 
2.43.0



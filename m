Return-Path: <netdev+bounces-83525-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DAE6892C8B
	for <lists+netdev@lfdr.de>; Sat, 30 Mar 2024 19:33:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8C22282832
	for <lists+netdev@lfdr.de>; Sat, 30 Mar 2024 18:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CC7641A92;
	Sat, 30 Mar 2024 18:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="OTVSt01Y"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD2A1E49E
	for <netdev@vger.kernel.org>; Sat, 30 Mar 2024 18:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711823562; cv=none; b=BiXpCwJ9CcojphzUiVjS/J34NOUWBvkVz+NwwIbCjJou9e0Fare3EXh6tKh7VOB2L4lzCaepdN0BU7hWXo31b+GgEJSiJp5TFiWJiNzpv1dtay+VXvKaA+NmaBqRnMs6o8hN3nVvZkKWav+SFmFHUAzrg5hccm2mADupIq/AEZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711823562; c=relaxed/simple;
	bh=7REgVx3Hk+G70l5YOIE6zqEavzl38e/93gZxmXsSzgA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qV6XUZztTz9CkdNVYSzxc6MgDx8wQMJaw0Z7H5UxmAG8XcaSzG77+vOmimcNFHZYIMi5yl1EN4/L/fp13ruvySt9E22oj+EIS0zr7ZmLYWN7sBvHi0fmFQbdfX5sOtivcvpvYRhrjlJh76kBErPcWi5BtjSVTyODNZnNm/sYtSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=OTVSt01Y; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=iHiJcTca4uqI5eVNh//6Wjc2B/iJjDsQUALvb+o+t0E=; b=OT
	VSt01YUrgdsDrI9l8kd+M6G5Wfi6Puh9Gms11QcAGGYwtOp31NbXiIM4RouWae0KPqk1vb2c5h3x0
	QsJA4sAD9IMCdSJ7ojw3k+AqadLMiW+hK5sw+jv6S5c95Np+v8p5mhKK/Ngg563UQNpQNa42nZxPp
	PpHXnUgfjw6bVjU=;
Received: from c-76-156-36-110.hsd1.mn.comcast.net ([76.156.36.110] helo=thinkpad.home.lunn.ch)
	by vps0.lunn.ch with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rqdVM-00Bjfq-8e; Sat, 30 Mar 2024 19:32:36 +0100
From: Andrew Lunn <andrew@lunn.ch>
Date: Sat, 30 Mar 2024 13:32:01 -0500
Subject: [PATCH net-next v2 4/7] net: dsa: mv88e6xxx: Tie the low level LED
 functions to device ops
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240330-v6-8-0-net-next-mv88e6xxx-leds-v4-v2-4-fc5beb9febc5@lunn.ch>
References: <20240330-v6-8-0-net-next-mv88e6xxx-leds-v4-v2-0-fc5beb9febc5@lunn.ch>
In-Reply-To: <20240330-v6-8-0-net-next-mv88e6xxx-leds-v4-v2-0-fc5beb9febc5@lunn.ch>
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
 b=owEBbQKS/ZANAwAKAea/DcumaUyEAcsmYgBmCFq2gQt8sfiXVo60U+PhqTHD4ARiN/T1vNU8m
 ghDUU2dLwyJAjMEAAEKAB0WIQRh+xAly1MmORb54bfmvw3LpmlMhAUCZghatgAKCRDmvw3LpmlM
 hMSVEAC/N6SK/6+vNRKig+sGfZ4aO27X/oHoPKsJn020LBPxR177AZSGrIJ8zNhY7J6+/SfQwsV
 PLwG6xdmh3kBILwRE7Q6oRetUQtFRUHJJeXsjSUcHBwsRyyzZfRF6ezKm3fop6gQy7sUOyYcdmH
 E6lrGGUWJ6gzCsrHotg1c3R5eMz7SunZVbbIW4VCW6rWTBqe/AtCg+7Oy5lx330YQwAxKB4/MTJ
 zL16u47a9ddg7Wzl3sUPBsbyjUEbwu/6pWHGn24Ht+Bi+IACippw52+MUeynZmdeo4MKL9VuO7V
 pTCYVo08lOMyP8d9thRhR2muGPZ2O1yQ1Zx6Za13sn6U9J3v6dzOyqUIpjonP8MHuFDpsXHqM0y
 y91HYOYiDNXGucHBDe08ZKt/j9F/vMnjokfLhsRVgjQwPGz9SICIWWlQnzLvDARl+Nr5jTpRu72
 PtNoEgRD39Fi0GxEtF95YqN9k1hb8eytNI5aVCzwGsvO7AExKDLwmv5hnmWz3g8ifohnR6AoDPV
 QuSQiUOlsvx2ltD4NIcQhAVhO38Zre6ORZNrqs8LXwJHYlCxzKVM7MNgVWwzpDM8CfeJOikKdsd
 3xO98O39kunCgwa3mIWXS6tgIBNX6tgTncB0Jg4rhz258Y2d7mMvzsboZJQwlupOZjF1gqfzMh7
 nEsohPeCG6u5Yzw==
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



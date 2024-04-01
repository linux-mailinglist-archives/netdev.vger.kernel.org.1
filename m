Return-Path: <netdev+bounces-83755-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53366893B86
	for <lists+netdev@lfdr.de>; Mon,  1 Apr 2024 15:36:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6ED81F221C7
	for <lists+netdev@lfdr.de>; Mon,  1 Apr 2024 13:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0775B3FE35;
	Mon,  1 Apr 2024 13:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Poocr3tk"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6778B3FE4E
	for <netdev@vger.kernel.org>; Mon,  1 Apr 2024 13:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711978580; cv=none; b=eEo1j1Lo8YUVy8i/dJnj8iP4kBOhjW9mxos9cqBZwjlCdew5VGqjgb3XxhSEnLOp0IhelcblN371olkjiBvyVekyphu4ik04aqICkTA9Fy23qgZOLWedsxWhU7vHul4JFhMiSMflBktt/IY0G3bm8FxRSn5kOr6pJpuELdcgLn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711978580; c=relaxed/simple;
	bh=7REgVx3Hk+G70l5YOIE6zqEavzl38e/93gZxmXsSzgA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Xv9XDdTMEFw38jR5RMS9Dz/ksaXTdB0+Lf/vtdcpFO+dAy1QW7Up8p5tIOqxFNqphPm2e1HNAwuBr252xd4wL0w1vcmCPQpYBnQt3YA1rn2Vz2nhDDsz+ew1bUEr1h4EAFy9MD++68cu9WCrygrWUxVME7G/Yj+J7cZ2aEvhS1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Poocr3tk; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=iHiJcTca4uqI5eVNh//6Wjc2B/iJjDsQUALvb+o+t0E=; b=Po
	ocr3tkyLPkg3N+hoDGTRSrZ6PNvTNNkVdkntXzDzepGW3b/a/lKItLCgM5krZvNPgXawiZ/lF6u47
	wavDlJ/n/iLAJmBUaIzNcRFLJWIUSNKB5KFZsFyE6z2Ij3UtebNkNJE80xBT6heXyby/MVMwGG79f
	QtHbNTnmPWoEYnk=;
Received: from c-76-156-36-110.hsd1.mn.comcast.net ([76.156.36.110] helo=thinkpad.home.lunn.ch)
	by vps0.lunn.ch with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rrHpg-00BrFx-1P; Mon, 01 Apr 2024 15:36:16 +0200
From: Andrew Lunn <andrew@lunn.ch>
Date: Mon, 01 Apr 2024 08:35:49 -0500
Subject: [PATCH net-next v3 4/7] net: dsa: mv88e6xxx: Tie the low level LED
 functions to device ops
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240401-v6-8-0-net-next-mv88e6xxx-leds-v4-v3-4-221b3fa55f78@lunn.ch>
References: <20240401-v6-8-0-net-next-mv88e6xxx-leds-v4-v3-0-221b3fa55f78@lunn.ch>
In-Reply-To: <20240401-v6-8-0-net-next-mv88e6xxx-leds-v4-v3-0-221b3fa55f78@lunn.ch>
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
 b=owEBbQKS/ZANAwAKAea/DcumaUyEAcsmYgBmCrhB9wF3ybn7TCaOpEb7fjn1iMtO7rJEbtu76
 JQuF3uIKK2JAjMEAAEKAB0WIQRh+xAly1MmORb54bfmvw3LpmlMhAUCZgq4QQAKCRDmvw3LpmlM
 hEiLEADLqQiIKohfK7o2nAsg4K1R2RrqA29D5aBEGqHOBnZjBFKxwzSbMKC7e2+I8RvaOIGGfL1
 HtU2Z12CVUOhZYUBsJkM6Rj9geMWhXLOoL9qmAZpdbm30MgezxWpZvIpAFKRDhfizQVh5FlNvfP
 d1qefbEp3HH0F1KF1OPDpl7cy9aVj8ny+TJysILy2VWIxQCTQNGzGGPofTz9ZV2rG03lsgqPK/r
 MKvMCgKc49q07VcC63kGZ2hgo3yjlHcGM8VpUujG80TuB8I6XyWFCDudZFmc6/smHkSTmkD/6E9
 51QIdVMz78kL1iqT8xX4yPjKbjTSoOMRoZOWQF1LujMA6NII4vPkKKDL5nv8PHYQV1s+vAltWlW
 QDo6VKPLmf3d/2ouz1hbDgSbrU1Jsmvob7isIHhMXLa4MSdfBWblYEqL1o9XxvsBsEiImwQeN9c
 SL/JhR572A9MMg4Owpn6WAbU/MrsKy9bOJplMfnlA6LVFJBjtXGia5vQT5zBuwMojSk/zA2vdZJ
 Cni+5tkw86BJ/oDAxpp1p6bpp+tiTrnmLRks0uZMiH9T/N/Eesak41hMFcFYrHagCIAWncfY7SL
 8uwZTLZYYUXaISna3SO/rpkLFo2J5JmLeN/QdQO87Z8Wxf0jSRtNeZ+UFkPBzZhJagvdNOUsbbF
 XDsHS0BVznEBWPA==
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



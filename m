Return-Path: <netdev+bounces-85462-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 041B189ACD2
	for <lists+netdev@lfdr.de>; Sat,  6 Apr 2024 22:14:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B191282826
	for <lists+netdev@lfdr.de>; Sat,  6 Apr 2024 20:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1D5F4E1C8;
	Sat,  6 Apr 2024 20:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="CA6hejSZ"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BDE44EB55
	for <netdev@vger.kernel.org>; Sat,  6 Apr 2024 20:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712434456; cv=none; b=TucN+3NeATUFZjdqXDN/M2BmRo/UeLcQWDkJTItPCmavbZ20c2usuuhuh9QpyLqfCFbhnampxrMFEoxBal/UhLaC5F7QoQqZUcYAdy91lck/K3phHdv1pYdov24o460jyFHRGo7Agy60U5Bcjhsl/AC+ag4XcT6QvE42l3v3NNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712434456; c=relaxed/simple;
	bh=7REgVx3Hk+G70l5YOIE6zqEavzl38e/93gZxmXsSzgA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TnSJDuKy+PYs/jLlnpTrfDeY3ZqSycPd+3aOwamqGMdkv4I6wuB4Pmkng+0/8WJMY1lj1sueRoNikJYg1L3hdpMNiB93qB8jmGaXazxpfMzKJoDssuxIaQKCvPFjNabXFcq48GOuQ2nzGO9KWLBxW9VGgtWET+Y5y5nzXubgjsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=CA6hejSZ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=iHiJcTca4uqI5eVNh//6Wjc2B/iJjDsQUALvb+o+t0E=; b=CA
	6hejSZpXcCohrnhilAAXy7vuCSd6Hv+/67dtsgEaVjHfNYBpT5/fCF7e/7oa782R7+Y2fXdAspoTe
	DeuccLdUloA/wPn79toguTBEV+2ofAAaxdO+1BGsDSMoIcS48PV3E+6d3d+mlC1TFSM8DZky7P4e7
	OkUdwH0f8JPZjHA=;
Received: from c-76-156-36-110.hsd1.mn.comcast.net ([76.156.36.110] helo=thinkpad.home.lunn.ch)
	by vps0.lunn.ch with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rtCQX-00COA7-1A; Sat, 06 Apr 2024 22:14:13 +0200
From: Andrew Lunn <andrew@lunn.ch>
Date: Sat, 06 Apr 2024 15:13:33 -0500
Subject: [PATCH net-next v4 6/8] net: dsa: mv88e6xxx: Tie the low level LED
 functions to device ops
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240406-v6-8-0-net-next-mv88e6xxx-leds-v4-v4-6-eb97665e7f96@lunn.ch>
References: <20240406-v6-8-0-net-next-mv88e6xxx-leds-v4-v4-0-eb97665e7f96@lunn.ch>
In-Reply-To: <20240406-v6-8-0-net-next-mv88e6xxx-leds-v4-v4-0-eb97665e7f96@lunn.ch>
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
 b=owEBbQKS/ZANAwAKAea/DcumaUyEAcsmYgBmEa0AIoXnHYGwc/vXgqKM6A7W8nJwed2gaKLQm
 ArTsPfZMliJAjMEAAEKAB0WIQRh+xAly1MmORb54bfmvw3LpmlMhAUCZhGtAAAKCRDmvw3LpmlM
 hFd/D/92AWTD4vJ4zr4KpGZA2CoZ43Ur/qp4D4Lm+sANe3O1/kntagidATmeh+5lRh8nO+2zmMc
 +ZX2a3Mf7Nhf6Hh1RcKyXNObvGgAFy6UMPTAEIf+2aH6GSLXV3mnAKWEvNNJGADSCy78WkmEzfv
 3UyvB9zBGzZrMHvgR90QGTbqoOE66ha9P7fG6yS9tuonKMzcmGdNW0T24b2RaB7i3BNs5cppv9C
 uw26cbfcyvJcnNa9PwfcrtjCQIiHuqyb6tRL2RDPYROanypMONMy0PN+MqtH+fiIwmw3/L0Chbx
 FDiUPBM0HhqiA3UrqDMH0UFYeNaoVz5v7LzyII3j3oanEjceBSWPR2j78E1klGPM+PK2ZFhHzSW
 UwioxbL0Le45JDba3DHR1rGO36Vc5M9ZDhKRoC4Z23kVFbW4Maxv+JwRxD4aB+VKRzzeumRqYll
 7ViIKVo/K6UfVtJoQCrgTOWjop0xKV0Gi+c/juZ04dctyTmfdXgmW/VvVatY9watAICKawrtww1
 vuWXiJAArXgA3F4Tm14+5e5xmPqgLQMJWBSroWL3FuBKSqR+he4rphXH+AG7UuLkdKnOdwFX6tH
 dBX3RTqLrvEWQTjpvtknTdcyuhOl3PEl9sTfOpNUXbfIYQvQgJ8U2YB+YtxwI1H3o+MT0lSgO3q
 ckEGztNlqbIanfQ==
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



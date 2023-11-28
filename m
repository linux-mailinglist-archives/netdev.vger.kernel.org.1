Return-Path: <netdev+bounces-51910-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F9817FCAC0
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 00:22:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0308D1F20F20
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 23:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DFBF5C3CA;
	Tue, 28 Nov 2023 23:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="NUa78q7M"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0585919B0
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 15:21:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:From:Sender:Reply-To:Subject:Date:
	Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=tU0et7kR0Lya3m4q3aAsRnEOVHMXdmfgu4p0cl2TNS4=; b=NUa78q7M8NC0n/AXtLhROyNJou
	NqBRZNeNNSvkY/gofCHi32hrWfeirHYq2thmpzwhwKHR++O7BYu8ft+Zv2qb41mszlkZNXtsGI4dL
	nT7dxZgtihTKEL2sQ/7eEMeDxcs+/FkerOMDTqGwmGJ9UIrYXEDE5ftuk+YfeQqR+xZM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1r87Op-001VIw-Io; Wed, 29 Nov 2023 00:21:51 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: netdev <netdev@vger.kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH RFC net-next 2/8] net: dsa: mv88e6xxx: Tie the low level LED functions to device ops
Date: Wed, 29 Nov 2023 00:21:29 +0100
Message-Id: <20231128232135.358638-3-andrew@lunn.ch>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20231128232135.358638-1-andrew@lunn.ch>
References: <20231128232135.358638-1-andrew@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make the LED brightness and blink helpers available for the 6352
family via their ops structure.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/dsa/mv88e6xxx/chip.c | 16 ++++++++++++++++
 drivers/net/dsa/mv88e6xxx/chip.h |  7 +++++++
 2 files changed, 23 insertions(+)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 42b1acaca33a..6bd0a8e232a5 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -4341,6 +4341,8 @@ static const struct mv88e6xxx_ops mv88e6171_ops = {
 	.stu_getnext = mv88e6352_g1_stu_getnext,
 	.stu_loadpurge = mv88e6352_g1_stu_loadpurge,
 	.phylink_get_caps = mv88e6185_phylink_get_caps,
+	.led_brightness_set = mv88e6352_port_led_brightness_set,
+	.led_blink_set = mv88e6352_port_led_blink_set,
 };
 
 static const struct mv88e6xxx_ops mv88e6172_ops = {
@@ -4395,6 +4397,8 @@ static const struct mv88e6xxx_ops mv88e6172_ops = {
 	.gpio_ops = &mv88e6352_gpio_ops,
 	.phylink_get_caps = mv88e6352_phylink_get_caps,
 	.pcs_ops = &mv88e6352_pcs_ops,
+	.led_brightness_set = mv88e6352_port_led_brightness_set,
+	.led_blink_set = mv88e6352_port_led_blink_set,
 };
 
 static const struct mv88e6xxx_ops mv88e6175_ops = {
@@ -4441,6 +4445,8 @@ static const struct mv88e6xxx_ops mv88e6175_ops = {
 	.stu_getnext = mv88e6352_g1_stu_getnext,
 	.stu_loadpurge = mv88e6352_g1_stu_loadpurge,
 	.phylink_get_caps = mv88e6185_phylink_get_caps,
+	.led_brightness_set = mv88e6352_port_led_brightness_set,
+	.led_blink_set = mv88e6352_port_led_blink_set,
 };
 
 static const struct mv88e6xxx_ops mv88e6176_ops = {
@@ -4497,6 +4503,8 @@ static const struct mv88e6xxx_ops mv88e6176_ops = {
 	.gpio_ops = &mv88e6352_gpio_ops,
 	.phylink_get_caps = mv88e6352_phylink_get_caps,
 	.pcs_ops = &mv88e6352_pcs_ops,
+	.led_brightness_set = mv88e6352_port_led_brightness_set,
+	.led_blink_set = mv88e6352_port_led_blink_set,
 };
 
 static const struct mv88e6xxx_ops mv88e6185_ops = {
@@ -4766,6 +4774,8 @@ static const struct mv88e6xxx_ops mv88e6240_ops = {
 	.ptp_ops = &mv88e6352_ptp_ops,
 	.phylink_get_caps = mv88e6352_phylink_get_caps,
 	.pcs_ops = &mv88e6352_pcs_ops,
+	.led_brightness_set = mv88e6352_port_led_brightness_set,
+	.led_blink_set = mv88e6352_port_led_blink_set,
 };
 
 static const struct mv88e6xxx_ops mv88e6250_ops = {
@@ -5070,6 +5080,8 @@ static const struct mv88e6xxx_ops mv88e6350_ops = {
 	.stu_getnext = mv88e6352_g1_stu_getnext,
 	.stu_loadpurge = mv88e6352_g1_stu_loadpurge,
 	.phylink_get_caps = mv88e6185_phylink_get_caps,
+	.led_brightness_set = mv88e6352_port_led_brightness_set,
+	.led_blink_set = mv88e6352_port_led_blink_set,
 };
 
 static const struct mv88e6xxx_ops mv88e6351_ops = {
@@ -5118,6 +5130,8 @@ static const struct mv88e6xxx_ops mv88e6351_ops = {
 	.avb_ops = &mv88e6352_avb_ops,
 	.ptp_ops = &mv88e6352_ptp_ops,
 	.phylink_get_caps = mv88e6185_phylink_get_caps,
+	.led_brightness_set = mv88e6352_port_led_brightness_set,
+	.led_blink_set = mv88e6352_port_led_blink_set,
 };
 
 static const struct mv88e6xxx_ops mv88e6352_ops = {
@@ -5179,6 +5193,8 @@ static const struct mv88e6xxx_ops mv88e6352_ops = {
 	.serdes_set_tx_amplitude = mv88e6352_serdes_set_tx_amplitude,
 	.phylink_get_caps = mv88e6352_phylink_get_caps,
 	.pcs_ops = &mv88e6352_pcs_ops,
+	.led_brightness_set = mv88e6352_port_led_brightness_set,
+	.led_blink_set = mv88e6352_port_led_blink_set,
 };
 
 static const struct mv88e6xxx_ops mv88e6390_ops = {
diff --git a/drivers/net/dsa/mv88e6xxx/chip.h b/drivers/net/dsa/mv88e6xxx/chip.h
index 44383a03ef2f..9f6a2a7fdb1b 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.h
+++ b/drivers/net/dsa/mv88e6xxx/chip.h
@@ -649,6 +649,13 @@ struct mv88e6xxx_ops {
 
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
2.42.0



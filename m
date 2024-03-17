Return-Path: <netdev+bounces-80277-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ED2187E07A
	for <lists+netdev@lfdr.de>; Sun, 17 Mar 2024 22:46:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16143281DF2
	for <lists+netdev@lfdr.de>; Sun, 17 Mar 2024 21:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ACBA21373;
	Sun, 17 Mar 2024 21:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="BaL80QQB"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A391F945
	for <netdev@vger.kernel.org>; Sun, 17 Mar 2024 21:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710711955; cv=none; b=Apd3Owui1aNMYSdqAYltUFYozRs9KC7AhxAa/XcSroiBwd9sQ0dFzfiBiWjFB/EJEv3+2hLDoEzXhkHh8VWax6+ycSI2FRB+vsHEq9a+PGaYsqB2fQfXYh2/sb1Jb2w8d2C9xIyGxC1robIitehsndjZA4agvcXrfwkBPm6I19Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710711955; c=relaxed/simple;
	bh=vEo4XtuQ8HhSi1WPbCnuGGliVAtGRVQEqy8l7ZEuS3Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h2643/03jzh70ERixNcP6mQY2hztaWF4/QgK51j+Hc4VETmGjK/JOxS0w5uNIy0p+QuFvHIuXZ8Wb4yX0AhMZmATdXrX5sxvUP2P2QfCok087mV8O8aO6MVpb84F8CK+lhR1hqIsj4Fx77FRKmU3XtNV/3M1YAFwHG2unKJKvrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=BaL80QQB; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=9pL1eG3RR7OWhX6ZHZmAZW8ZNaGZQk4y6N4iJhK3V+4=; b=Ba
	L80QQBoBN5sAxhVCZ9AbTJu4P5mWoC0s3WBlhYv+9i8JOFa8y7LO/Uy/5tTQq6O37YCeK2xJHOeoz
	vwYVckFF0s2l1V+q3RKy5EtgsvTP+e35fIu0PtWDlABctmH6pf/fYL8X/IysMtoB9sCLGRyLZVv3M
	FFXZ3ILHfHQ1c18=;
Received: from c-76-156-36-110.hsd1.mn.comcast.net ([76.156.36.110] helo=thinkpad.home.lunn.ch)
	by vps0.lunn.ch with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rlyKD-00AYv5-Ql; Sun, 17 Mar 2024 22:45:50 +0100
From: Andrew Lunn <andrew@lunn.ch>
Date: Sun, 17 Mar 2024 16:45:16 -0500
Subject: [PATCH RFC 3/7] net: dsa: mv88e6xxx: Add helpers for 6352 LED
 blink and brightness
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240317-v6-8-0-net-next-mv88e6xxx-leds-v4-v1-3-80a4e6c6293e@lunn.ch>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=8607; i=andrew@lunn.ch;
 h=from:subject:message-id; bh=vEo4XtuQ8HhSi1WPbCnuGGliVAtGRVQEqy8l7ZEuS3Q=;
 b=owEBbQKS/ZANAwAKAea/DcumaUyEAcsmYgBl92SBjd7ACBk/s4zrwjMA6P/gJe3bGiWTwotpe
 MFTR1ZxeRKJAjMEAAEKAB0WIQRh+xAly1MmORb54bfmvw3LpmlMhAUCZfdkgQAKCRDmvw3LpmlM
 hExdD/9nhn8b0HBv6ul9JfLqdDsjv+MEykFMTkJkzhzUo40Hnh8TAPjhBRt936FZsMJJ7NkuqDF
 IT6Ws5iU1YEqupSTAkHLko/kfiGOAilB2eayiIZtBcJ1KaGauiwowRkIu+5j8IgEaNoVwpUpGQT
 9rtss21fpoik+ms41AfICL4H07ZXBoanC3aLket0YkN35tiJgJNYNhvN8xxdkKFd5QrlrWHJZEZ
 JJU4OnZzOOy0U+j9Tlz7O0RuUs1UmZWnt/3DtgPR42hDkQgMrjgfPXOoydHYZC/HkeVKllR3Zjz
 mGBHkdGbOQLQwpJtIS5//qTZvWy9sSL4gvBtZu7ASyHZhuFiPqcIekaPWluEizBuSJ34g90vbVs
 I35vuX/2WhYnyQS+DPUyxYI2TfCsoiJ6nrpA59cv8cIjmBqqQpqsIli9cqjfcZoVmUF/3fAlINm
 7lRd/FSP/jkbYLcFdeVJvXcN/TxlEY5ICSoYJtEHD+mC4XJAEnEQOglypmdlOyKPaZ7T3WIVXr0
 Gde1XopiBl+Q4YvpLSP/YcHNQjf/HiA36qeL/QKbYI4JwaikoYT92nnH2WKbNJLN16n/hmcA3aK
 5jp2/vsLf71Pu6WHgx/hs5L8I32mVMUvR2yr+mdkAVxi7aDNakv6/9r+HESfNVHbP9JCUKe3qLd
 bN9Hw/DcUKq/Ksg==
X-Developer-Key: i=andrew@lunn.ch; a=openpgp;
 fpr=61FB1025CB53263916F9E1B7E6BF0DCBA6694C84

The 6352 family has two LEDs per port for ports 0-4. Ports 5 and 6
share a couple of LEDs. Add support functions to set the brightness,
i.e. on or off, and to make the LEDs blink at a fixed rate.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/dsa/mv88e6xxx/port.c | 99 ++++++++++++++++++++++++++++++++++++++++
 drivers/net/dsa/mv88e6xxx/port.h | 76 +++++++++++++++++++++++++++++-
 2 files changed, 174 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/mv88e6xxx/port.c b/drivers/net/dsa/mv88e6xxx/port.c
index 5394a8cf7bf1..8dae51f0c1d4 100644
--- a/drivers/net/dsa/mv88e6xxx/port.c
+++ b/drivers/net/dsa/mv88e6xxx/port.c
@@ -1723,3 +1723,102 @@ int mv88e6393x_port_set_policy(struct mv88e6xxx_chip *chip, int port,
 
 	return mv88e6393x_port_policy_write(chip, port, ptr, reg);
 }
+
+/* Offset 0x16: LED Control Register */
+
+static int mv88e6352_port_led_write(struct mv88e6xxx_chip *chip, int port,
+				    u16 pointer, u16 data)
+{
+	u16 reg = MV88E6352_PORT_LED_CTL_UPDATE | pointer | data;
+
+	return mv88e6xxx_port_write(chip, port, MV88E6352_PORT_LED_CTL, reg);
+}
+
+static int mv88e6352_port_led_read(struct mv88e6xxx_chip *chip, int port,
+				   u16 pointer, u16 *data)
+{
+	int err;
+	u16 val;
+
+	err = mv88e6xxx_port_write(chip, port, MV88E6352_PORT_LED_CTL, pointer);
+	if (err)
+		return err;
+
+	err = mv88e6xxx_port_read(chip, port, MV88E6352_PORT_LED_CTL, &val);
+	if (err)
+		return err;
+
+	*data = val & MV88E6352_PORT_LED_CTL_DATA_MASK;
+
+	return 0;
+}
+
+int mv88e6352_port_led_brightness_set(struct mv88e6xxx_chip *chip, int port,
+				      u8 led, enum led_brightness value)
+{
+	int err;
+	u16 val;
+
+	if (led > 1)
+		return -EINVAL;
+
+	if (port > 5)
+		return -EOPNOTSUPP;
+
+	err = mv88e6352_port_led_read(chip, port,
+				      MV88E6352_PORT_LED_CTL_PTR_LED01,
+				      &val);
+	if (err)
+		return err;
+
+	if (led == 0) {
+		val &= ~MV88E6352_PORT_LED_CTL_DATA_LED01_LED0_MASK;
+		if (value)
+			val |= MV88E6352_PORT_LED_CTL_DATA_LED01_LED0_ON;
+		else
+			val |= MV88E6352_PORT_LED_CTL_DATA_LED01_LED0_OFF;
+	} else {
+		val &= ~MV88E6352_PORT_LED_CTL_DATA_LED01_LED1_MASK;
+		if (value)
+			val |= MV88E6352_PORT_LED_CTL_DATA_LED01_LED1_ON;
+		else
+			val |= MV88E6352_PORT_LED_CTL_DATA_LED01_LED1_OFF;
+	}
+	return mv88e6352_port_led_write(chip, port,
+					MV88E6352_PORT_LED_CTL_PTR_LED01,
+					val);
+}
+
+int mv88e6352_port_led_blink_set(struct mv88e6xxx_chip *chip, int port, u8 led,
+				 unsigned long *delay_on,
+				 unsigned long *delay_off)
+{
+	int err;
+	u16 val;
+
+	if (led > 1)
+		return -EINVAL;
+
+	if (port > 5)
+		return -EOPNOTSUPP;
+
+	/* Reset default is 84ms */
+	*delay_on = 84 / 2;
+	*delay_off = 84 / 2;
+	err = mv88e6352_port_led_read(chip, port,
+				      MV88E6352_PORT_LED_CTL_PTR_LED01,
+				      &val);
+	if (err)
+		return err;
+
+	if (led == 0) {
+		val &= ~MV88E6352_PORT_LED_CTL_DATA_LED01_LED0_MASK;
+		val |= MV88E6352_PORT_LED_CTL_DATA_LED01_LED0_BLINK;
+	} else {
+		val &= ~MV88E6352_PORT_LED_CTL_DATA_LED01_LED1_MASK;
+		val |= MV88E6352_PORT_LED_CTL_DATA_LED01_LED1_BLINK;
+	}
+	return mv88e6352_port_led_write(chip, port,
+					MV88E6352_PORT_LED_CTL_PTR_LED01,
+					val);
+}
diff --git a/drivers/net/dsa/mv88e6xxx/port.h b/drivers/net/dsa/mv88e6xxx/port.h
index 86deeb347cbc..72556e4d154c 100644
--- a/drivers/net/dsa/mv88e6xxx/port.h
+++ b/drivers/net/dsa/mv88e6xxx/port.h
@@ -294,6 +294,76 @@
 /* Offset 0x13: OutFiltered Counter */
 #define MV88E6XXX_PORT_OUT_FILTERED	0x13
 
+/* Offset 0x16: LED Control */
+#define MV88E6352_PORT_LED_CTL					0x16
+#define MV88E6352_PORT_LED_CTL_UPDATE				0x8000
+#define MV88E6352_PORT_LED_CTL_PTR_LED01			0x0000
+#define MV88E6352_PORT_LED_CTL_PTR_STRETCH_BLINK		0x6000
+#define MV88E6352_PORT_LED_CTL_PTR_SPECIAL			0x7000
+#define MV88E6352_PORT_LED_CTL_DATA_MASK			0x03ff
+/* Ports 0-4 */
+#define MV88E6352_PORT_LED_CTL_DATA_LED01_LED1_P2_SPECIAL	0x0000
+#define MV88E6352_PORT_LED_CTL_DATA_LED01_LED1_10_100_ACT	0x0010
+#define MV88E6352_PORT_LED_CTL_DATA_LED01_LED1_1000		0x0030
+#define MV88E6352_PORT_LED_CTL_DATA_LED01_LED1_P1_SPECIAL	0x0040
+#define MV88E6352_PORT_LED_CTL_DATA_LED01_LED1_10_1000_ACT	0x0060
+#define MV88E6352_PORT_LED_CTL_DATA_LED01_LED1_10_1000		0x0070
+#define MV88E6352_PORT_LED_CTL_DATA_LED01_LED1_ACT		0x0080
+#define MV88E6352_PORT_LED_CTL_DATA_LED01_LED1_100		0x0090
+#define MV88E6352_PORT_LED_CTL_DATA_LED01_LED1_100_ACT		0x00A0
+#define MV88E6352_PORT_LED_CTL_DATA_LED01_LED1_10_100		0x00B0
+#define MV88E6352_PORT_LED_CTL_DATA_LED01_LED1_PTP_ACT		0x00C0
+#define MV88E6352_PORT_LED_CTL_DATA_LED01_LED1_BLINK		0x00D0
+#define MV88E6352_PORT_LED_CTL_DATA_LED01_LED1_OFF		0x00E0
+#define MV88E6352_PORT_LED_CTL_DATA_LED01_LED1_ON		0x00F0
+#define MV88E6352_PORT_LED_CTL_DATA_LED01_LED1_MASK		0x00F0
+#define MV88E6352_PORT_LED_CTL_DATA_LED01_LED1_LINK_ACT		0x0000
+#define MV88E6352_PORT_LED_CTL_DATA_LED01_LED0_100_1000_ACT	0x0001
+#define MV88E6352_PORT_LED_CTL_DATA_LED01_LED0_1000_ACT		0x0002
+#define MV88E6352_PORT_LED_CTL_DATA_LED01_LED0_LINK_ACT		0x0003
+#define MV88E6352_PORT_LED_CTL_DATA_LED01_LED0_P0_SPECIAL	0x0004
+#define MV88E6352_PORT_LED_CTL_DATA_LED01_LED0_DUPLEX_COL	0x0006
+#define MV88E6352_PORT_LED_CTL_DATA_LED01_LED0_10_1000_ACT	0x0007
+#define MV88E6352_PORT_LED_CTL_DATA_LED01_LED0_LINK		0x0008
+#define MV88E6352_PORT_LED_CTL_DATA_LED01_LED0_10		0x0009
+#define MV88E6352_PORT_LED_CTL_DATA_LED01_LED0_10_ACT		0x000A
+#define MV88E6352_PORT_LED_CTL_DATA_LED01_LED0_100_1000		0x000B
+#define MV88E6352_PORT_LED_CTL_DATA_LED01_LED0_PTP_ACT		0x000C
+#define MV88E6352_PORT_LED_CTL_DATA_LED01_LED0_BLINK		0x000D
+#define MV88E6352_PORT_LED_CTL_DATA_LED01_LED0_OFF		0x000E
+#define MV88E6352_PORT_LED_CTL_DATA_LED01_LED0_ON		0x000F
+#define MV88E6352_PORT_LED_CTL_DATA_LED01_LED0_MASK		0x000F
+
+/* Port 5 */
+#define MV88E6352_PORT_LED_CTL_DATA5_LED01_LED1_P6_ACT		0x0000
+#define MV88E6352_PORT_LED_CTL_DATA5_LED01_LED1_FIBER_1000_ACT	0x0010
+#define MV88E6352_PORT_LED_CTL_DATA5_LED01_LED1_FIBER_100_ACT   0x0020
+#define MV88E6352_PORT_LED_CTL_DATA5_LED01_LED1_FIBER		0x0030
+#define MV88E6352_PORT_LED_CTL_DATA5_LED01_LED1_P5_ACT		0x0040
+#define MV88E6352_PORT_LED_CTL_DATA5_LED01_LED1_P6_LINK		0x0050
+#define MV88E6352_PORT_LED_CTL_DATA5_LED01_LED1_P6_DUPLEX_COL	0x0060
+#define MV88E6352_PORT_LED_CTL_DATA5_LED01_LED1_P6_LINK_ACT	0x0070
+#define MV88E6352_PORT_LED_CTL_DATA5_LED01_LED1_P0_SPECIAL	0x0080
+#define MV88E6352_PORT_LED_CTL_DATA5_LED01_LED1_P1_SPECIAL	0x0090
+#define MV88E6352_PORT_LED_CTL_DATA5_LED01_LED1_P2_SPECIAL	0x00A0
+#define MV88E6352_PORT_LED_CTL_DATA5_LED01_LED1_P6_PTP_ACT	0x00C0
+#define MV88E6352_PORT_LED_CTL_DATA5_LED01_LED1_BLINK		0x00D0
+#define MV88E6352_PORT_LED_CTL_DATA5_LED01_LED1_OFF		0x00E0
+#define MV88E6352_PORT_LED_CTL_DATA5_LED01_LED1_ON		0x00F0
+#define MV88E6352_PORT_LED_CTL_DATA5_LED01_LED1_P5_LINK_ACT	0x0000
+#define MV88E6352_PORT_LED_CTL_DATA5_LED01_LED0_FIBER_100_ACT	0x0001
+#define MV88E6352_PORT_LED_CTL_DATA5_LED01_LED0_FIBER_1000_ACT	0x0002
+#define MV88E6352_PORT_LED_CTL_DATA5_LED01_LED0_P0_SPECIAL	0x0003
+#define MV88E6352_PORT_LED_CTL_DATA5_LED01_LED0_P1_SPECIAL	0x0004
+#define MV88E6352_PORT_LED_CTL_DATA5_LED01_LED0_P2_SPECIAL	0x0005
+#define MV88E6352_PORT_LED_CTL_DATA5_LED01_LED0_P5_DUPLEX_COL	0x0006
+#define MV88E6352_PORT_LED_CTL_DATA5_LED01_LED0_P5_LINK_ACT	0x0007
+#define MV88E6352_PORT_LED_CTL_DATA5_LED01_LED0_P6_LINK_ACT	0x0008
+#define MV88E6352_PORT_LED_CTL_DATA5_LED01_LED0_BLINK		0x000D
+#define MV88E6352_PORT_LED_CTL_DATA5_LED01_LED0_OFF		0x000E
+#define MV88E6352_PORT_LED_CTL_DATA5_LED01_LED0_ON		0x000F
+/* Port 6 does not have any LEDs */
+
 /* Offset 0x18: IEEE Priority Mapping Table */
 #define MV88E6390_PORT_IEEE_PRIO_MAP_TABLE			0x18
 #define MV88E6390_PORT_IEEE_PRIO_MAP_TABLE_UPDATE		0x8000
@@ -459,5 +529,9 @@ int mv88e6xxx_port_hidden_write(struct mv88e6xxx_chip *chip, int block,
 int mv88e6xxx_port_hidden_wait(struct mv88e6xxx_chip *chip);
 int mv88e6xxx_port_hidden_read(struct mv88e6xxx_chip *chip, int block, int port,
 			       int reg, u16 *val);
-
+int mv88e6352_port_led_brightness_set(struct mv88e6xxx_chip *chip, int port,
+				      u8 led, enum led_brightness value);
+int mv88e6352_port_led_blink_set(struct mv88e6xxx_chip *chip, int port, u8 led,
+				 unsigned long *delay_on,
+				 unsigned long *delay_off);
 #endif /* _MV88E6XXX_PORT_H */

-- 
2.43.0



Return-Path: <netdev+bounces-83754-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 797C2893B85
	for <lists+netdev@lfdr.de>; Mon,  1 Apr 2024 15:36:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5588B20A73
	for <lists+netdev@lfdr.de>; Mon,  1 Apr 2024 13:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85F1C3FB29;
	Mon,  1 Apr 2024 13:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="NpYGXAXQ"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AECD53FB07
	for <netdev@vger.kernel.org>; Mon,  1 Apr 2024 13:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711978578; cv=none; b=S9elZAYmF3i6pNXokQ6MHLeCzF3cDXMmAPUf2ocfIPfThcqtY2cWyUuFDrxszIpgIeFfcxSopCPnns0dpdEaTZigQM8hSrfWipAR6dKemrrvscFGGIevvw8JtYei7B3efSIAgQYO1UyMmZn+X9eyjUW2AqQgBq79xYiZh9oIpPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711978578; c=relaxed/simple;
	bh=Ba8ZRPcHIpN0lalX1MJan4IYyVadQnFD5BsiVvTcBu0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Hatuy41z38D/O/gO7pFSUz0yjfa7OYewWLQzlXKRtOrsWWGUJiOTBj8H92pYeRLyiKkP9wIC5g+J2dlRX7Eugn5gxKCy3BWGd/EyqnJUQZuD9ibRW6Z+z0ScoDGHbUHd5o81KwlV3DUENwunG4ZGjbotKtGxwCqJwMo7HBgbvps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=NpYGXAXQ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=horO3WQSlmE1YpmKxwySgRee+ScV5A7WgNw1ql2FvsM=; b=Np
	YGXAXQ3P9Piy5h+8ojpDaHbb5lgg45zrNZvJTSG2+eivvZgnJbuNb9YQp42Ej1ld7OIWu85HtZj8I
	bDGa23ddibORIIDrL/qzbtOaieKeedueU/DUADJizJ1ITzMBRAOppwUnGQ6q8kpVsOiFpYz9MddOP
	MVZ74Dwr54HnmDk=;
Received: from c-76-156-36-110.hsd1.mn.comcast.net ([76.156.36.110] helo=thinkpad.home.lunn.ch)
	by vps0.lunn.ch with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rrHpd-00BrFx-CJ; Mon, 01 Apr 2024 15:36:13 +0200
From: Andrew Lunn <andrew@lunn.ch>
Date: Mon, 01 Apr 2024 08:35:48 -0500
Subject: [PATCH net-next v3 3/7] net: dsa: mv88e6xxx: Add helpers for 6352
 LED blink and brightness
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240401-v6-8-0-net-next-mv88e6xxx-leds-v4-v3-3-221b3fa55f78@lunn.ch>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=8530; i=andrew@lunn.ch;
 h=from:subject:message-id; bh=Ba8ZRPcHIpN0lalX1MJan4IYyVadQnFD5BsiVvTcBu0=;
 b=owEBbQKS/ZANAwAKAea/DcumaUyEAcsmYgBmCrhB/85He6vDXpBQGnKw40yi8zeNVOYzwlenQ
 HiFcEYb4DyJAjMEAAEKAB0WIQRh+xAly1MmORb54bfmvw3LpmlMhAUCZgq4QQAKCRDmvw3LpmlM
 hLtwD/4sNDBVK/lmDrW2kUkLuXkenbWzTYeof7duj51W47y5mXNb+YgPsW75gNkgdPpNkSuDI4f
 mcqSMtlObCKxqwOFCYVr+teq34sQw2zaErlW8Ypozo9DxRhpN09BI+XEp1fKDZxjJawnv5FQXYw
 +9zmuEZRQsAVTRC3S/SRF1cVxf0MEon/jaJ5R638F0qQKpacfMJ9wRkGEiRZkxWrvpISfkMOEGC
 x/hMI0lBgADOpv2mo0Ri46nfV8B+k9jU1zskPrUEhqT8eqK23GRY0NoIrw4//bGzfPi4j1AvSB5
 Bqi1EyjHH+BBWN86ORjZQxE/Zqf0Xr+XfimCCyic0v3JPZ5rKb4joRUOnK3UWlzZq1zIN06ocBl
 NUix+MbwQUOBn6/4IZdBQztuNWmJ2IzfckYZJXEta99yqrpnmnw2mvJ1h/f0tmZJBuu+FrBsr12
 usu5btLwZLqt/NUJVaAqqGacuD5nGMmENwanv2DtbO9ySTS3ZWr2EdtA0SXWeMxLcTv7kRvHtgF
 nSGyeatjqrxw+ZVHlJIXp2YCJKoargHYgy2zVd9H+PB5sB2bk2e/cdUtFgYiJaRE2zC9reGITRl
 9ii/COMH2mC2ERp0FUkkXlhTQZvfGIcsSc+IsDFnRPtciNqZNd3LMMShuOV9dypYduB4kV5XrzT
 c9cdAZEZylBTtEA==
X-Developer-Key: i=andrew@lunn.ch; a=openpgp;
 fpr=61FB1025CB53263916F9E1B7E6BF0DCBA6694C84

The 6352 family has two LEDs per port for ports 0-4. Ports 5 and 6
share a couple of LEDs. Add support functions to set the brightness,
i.e. on or off, and to make the LEDs blink at a fixed rate.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/dsa/mv88e6xxx/port.c | 93 ++++++++++++++++++++++++++++++++++++++++
 drivers/net/dsa/mv88e6xxx/port.h | 76 +++++++++++++++++++++++++++++++-
 2 files changed, 168 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/mv88e6xxx/port.c b/drivers/net/dsa/mv88e6xxx/port.c
index 5394a8cf7bf1..37315a4aa9cf 100644
--- a/drivers/net/dsa/mv88e6xxx/port.c
+++ b/drivers/net/dsa/mv88e6xxx/port.c
@@ -1723,3 +1723,96 @@ int mv88e6393x_port_set_policy(struct mv88e6xxx_chip *chip, int port,
 
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



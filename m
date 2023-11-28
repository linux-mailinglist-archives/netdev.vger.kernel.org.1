Return-Path: <netdev+bounces-51914-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 771197FCAC5
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 00:22:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8D0A1C20EF9
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 23:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A57D85CD1F;
	Tue, 28 Nov 2023 23:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="kSgHiI9C"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8AE919A4
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 15:21:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:From:Sender:Reply-To:Subject:Date:
	Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Ok7WyD+SI9g6AvKWJI0BF/1VrixPN53H8IGATCy9kIk=; b=kSgHiI9CBZCEA2LiPyrJz9Je4/
	F2z3RNA2gY5eL22xz3BYh0Nm7pRvKbdRgl1+E11UDNkAnIieUfAYM5Qv9H+IplsJdG5NTdjxfaH5P
	t16v4gcflLOnMQ4E8jsmo3ns+8qfH54l6SXcpE1OTCpf1ehf2s3vI7KlGqsNy4H/d+KI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1r87Op-001VIs-Hg; Wed, 29 Nov 2023 00:21:51 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: netdev <netdev@vger.kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH RFC net-next 1/8] net: dsa: mv88e6xxx: Add helpers for 6352 LED blink and brightness
Date: Wed, 29 Nov 2023 00:21:28 +0100
Message-Id: <20231128232135.358638-2-andrew@lunn.ch>
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

The 6352 family has two LEDs per port for ports 0-4. Ports 5 and 6
share a couple of LEDs. Add support functions to set the brightness,
i.e. on or off, and to make the LEDs blink at a fixed rate.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/dsa/mv88e6xxx/port.c | 99 ++++++++++++++++++++++++++++++++
 drivers/net/dsa/mv88e6xxx/port.h | 76 +++++++++++++++++++++++-
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
2.42.0



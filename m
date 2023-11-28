Return-Path: <netdev+bounces-51911-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D2707FCAC1
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 00:22:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75D0DB21701
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 23:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 298AE5C3CC;
	Tue, 28 Nov 2023 23:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="X/lLoYqD"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C81021A5
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 15:21:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:From:Sender:Reply-To:Subject:Date:
	Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=OsZ+n4tpZgXWhY3i3wY37+Jasv2M+Rd3jlJh4/Jkm9o=; b=X/lLoYqDAc9jDfBqeKBOBBaX5e
	wDRKvKXueZvIMmGeKMPWY2Xs9SgV2m8sBys5jJA6HX0Tu6cUKkncDy4dg1MKhhCVfAKRG/pit6JIM
	OFjhgjtqO/Zm9ODyEppgRkiknWcWT1cQeDFIn3C/WRpU9OqtAvcKiS1pLcnjC53sEWSE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1r87Op-001VJC-NE; Wed, 29 Nov 2023 00:21:51 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: netdev <netdev@vger.kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH RFC net-next 6/8] dsa: mv88e6xxx: Plumb in LED offload functions
Date: Wed, 29 Nov 2023 00:21:33 +0100
Message-Id: <20231128232135.358638-7-andrew@lunn.ch>
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

Add the plumbing needed for each switch family to support offloading
the LED blinking to hardware.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/dsa/mv88e6xxx/chip.c | 52 ++++++++++++++++++++++++++++++++
 drivers/net/dsa/mv88e6xxx/chip.h |  7 +++++
 2 files changed, 59 insertions(+)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 38b0d8259fa0..645fba8937ee 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -6836,6 +6836,55 @@ static int mv88e6xxx_led_blink_set(struct dsa_switch *ds, int port,
 	return -EOPNOTSUPP;
 }
 
+static int mv88e6xxx_led_hw_control_is_supported(struct dsa_switch *ds,
+						 int port, u8 led,
+						 unsigned long flags)
+{
+	struct mv88e6xxx_chip *chip = ds->priv;
+	int err;
+
+	if (chip->info->ops->led_hw_control_is_supported) {
+		mv88e6xxx_reg_lock(chip);
+		err = chip->info->ops->led_hw_control_is_supported(chip, port,
+								   led, flags);
+		mv88e6xxx_reg_unlock(chip);
+		return err;
+	}
+	return -EOPNOTSUPP;
+}
+
+static int mv88e6xxx_led_hw_control_set(struct dsa_switch *ds, int port,
+					u8 led, unsigned long flags)
+{
+	struct mv88e6xxx_chip *chip = ds->priv;
+	int err;
+
+	if (chip->info->ops->led_hw_control_set) {
+		mv88e6xxx_reg_lock(chip);
+		err = chip->info->ops->led_hw_control_set(chip, port,
+							  led, flags);
+		mv88e6xxx_reg_unlock(chip);
+		return err;
+	}
+	return -EOPNOTSUPP;
+}
+
+static int mv88e6xxx_led_hw_control_get(struct dsa_switch *ds, int port,
+					u8 led, unsigned long *flags)
+{
+	struct mv88e6xxx_chip *chip = ds->priv;
+	int err;
+
+	if (chip->info->ops->led_hw_control_get) {
+		mv88e6xxx_reg_lock(chip);
+		err = chip->info->ops->led_hw_control_get(chip, port,
+							  led, flags);
+		mv88e6xxx_reg_unlock(chip);
+		return err;
+	}
+	return -EOPNOTSUPP;
+}
+
 static const struct dsa_switch_ops mv88e6xxx_switch_ops = {
 	.get_tag_protocol	= mv88e6xxx_get_tag_protocol,
 	.change_tag_protocol	= mv88e6xxx_change_tag_protocol,
@@ -6902,6 +6951,9 @@ static const struct dsa_switch_ops mv88e6xxx_switch_ops = {
 	.crosschip_lag_leave	= mv88e6xxx_crosschip_lag_leave,
 	.led_brightness_set	= mv88e6xxx_led_brightness_set,
 	.led_blink_set		= mv88e6xxx_led_blink_set,
+	.led_hw_control_is_supported = mv88e6xxx_led_hw_control_is_supported,
+	.led_hw_control_set	= mv88e6xxx_led_hw_control_set,
+	.led_hw_control_get	= mv88e6xxx_led_hw_control_get,
 };
 
 static int mv88e6xxx_register_switch(struct mv88e6xxx_chip *chip)
diff --git a/drivers/net/dsa/mv88e6xxx/chip.h b/drivers/net/dsa/mv88e6xxx/chip.h
index 9f6a2a7fdb1b..5a4daf288c17 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.h
+++ b/drivers/net/dsa/mv88e6xxx/chip.h
@@ -656,6 +656,13 @@ struct mv88e6xxx_ops {
 	int (*led_blink_set)(struct mv88e6xxx_chip *chip, int port, u8 led,
 			     unsigned long *delay_on,
 			     unsigned long *delay_off);
+	int (*led_hw_control_is_supported)(struct mv88e6xxx_chip *chip,
+					   int port,
+					   u8 led, unsigned long flags);
+	int (*led_hw_control_set)(struct mv88e6xxx_chip *chip, int port,
+				  u8 led, unsigned long flags);
+	int (*led_hw_control_get)(struct mv88e6xxx_chip *chip, int port,
+				  u8 led, unsigned long *flags);
 };
 
 struct mv88e6xxx_irq_ops {
-- 
2.42.0



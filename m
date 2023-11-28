Return-Path: <netdev+bounces-51909-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A27687FCABF
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 00:22:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA481281F3A
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 23:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC3E25C3C0;
	Tue, 28 Nov 2023 23:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="z8li9sxb"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 358601A3
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 15:21:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:From:Sender:Reply-To:Subject:Date:
	Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Uv07crr7jfaQh41rhm4hZbyQzApuNQc5UJcqXiHaUIQ=; b=z8li9sxbphih/StjgY9LD3HjCz
	Nu7o6PlBExX81tp5WFg293iNuC/PycvLG+1DkhrvQ3IIZ2spr6WpdSLKBYfY0RA1DDC7EpCSOl2oI
	IG6Ht3o7vWzU2lnSBRaGEkRhOmtjJcVmlUWwf3yw9PiGsfeGOqwFiJEPFYJ4Q5qIZkPI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1r87Op-001VJ0-Jq; Wed, 29 Nov 2023 00:21:51 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: netdev <netdev@vger.kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH RFC net-next 3/8] net: dsa: Plumb LED brightnes and blink into switch API
Date: Wed, 29 Nov 2023 00:21:30 +0100
Message-Id: <20231128232135.358638-4-andrew@lunn.ch>
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

Allow the switch driver to expose its methods to control the LED
brightness and blinking to the DSA core.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/dsa/mv88e6xxx/chip.c | 35 ++++++++++++++++++++++++++++++++
 include/net/dsa.h                |  8 ++++++++
 2 files changed, 43 insertions(+)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 6bd0a8e232a5..38b0d8259fa0 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -6803,6 +6803,39 @@ static int mv88e6xxx_crosschip_lag_leave(struct dsa_switch *ds, int sw_index,
 	return err_sync ? : err_pvt;
 }
 
+static int mv88e6xxx_led_brightness_set(struct dsa_switch *ds, int port,
+					u8 led, enum led_brightness value)
+{
+	struct mv88e6xxx_chip *chip = ds->priv;
+	int err;
+
+	if (chip->info->ops->led_brightness_set) {
+		mv88e6xxx_reg_lock(chip);
+		err = chip->info->ops->led_brightness_set(chip, port, led,
+							  value);
+		mv88e6xxx_reg_unlock(chip);
+		return err;
+	}
+	return -EOPNOTSUPP;
+}
+
+static int mv88e6xxx_led_blink_set(struct dsa_switch *ds, int port,
+				   u8 led, unsigned long *delay_on,
+				   unsigned long *delay_off)
+{
+	struct mv88e6xxx_chip *chip = ds->priv;
+	int err;
+
+	if (chip->info->ops->led_blink_set) {
+		mv88e6xxx_reg_lock(chip);
+		err = chip->info->ops->led_blink_set(chip, port, led,
+						     delay_on, delay_off);
+		mv88e6xxx_reg_unlock(chip);
+		return err;
+	}
+	return -EOPNOTSUPP;
+}
+
 static const struct dsa_switch_ops mv88e6xxx_switch_ops = {
 	.get_tag_protocol	= mv88e6xxx_get_tag_protocol,
 	.change_tag_protocol	= mv88e6xxx_change_tag_protocol,
@@ -6867,6 +6900,8 @@ static const struct dsa_switch_ops mv88e6xxx_switch_ops = {
 	.crosschip_lag_change	= mv88e6xxx_crosschip_lag_change,
 	.crosschip_lag_join	= mv88e6xxx_crosschip_lag_join,
 	.crosschip_lag_leave	= mv88e6xxx_crosschip_lag_leave,
+	.led_brightness_set	= mv88e6xxx_led_brightness_set,
+	.led_blink_set		= mv88e6xxx_led_blink_set,
 };
 
 static int mv88e6xxx_register_switch(struct mv88e6xxx_chip *chip)
diff --git a/include/net/dsa.h b/include/net/dsa.h
index 82135fbdb1e6..ae73765cd71c 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -1238,6 +1238,14 @@ struct dsa_switch_ops {
 	void	(*conduit_state_change)(struct dsa_switch *ds,
 					const struct net_device *conduit,
 					bool operational);
+
+	/*
+	 * LED control
+	 */
+	int (*led_brightness_set)(struct dsa_switch *ds, int port,
+				  u8 led, enum led_brightness value);
+	int (*led_blink_set)(struct dsa_switch *ds, int port, u8 led,
+			     unsigned long *delay_on, unsigned long *delay_off);
 };
 
 #define DSA_DEVLINK_PARAM_DRIVER(_id, _name, _type, _cmodes)		\
-- 
2.42.0



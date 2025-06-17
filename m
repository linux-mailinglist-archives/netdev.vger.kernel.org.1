Return-Path: <netdev+bounces-198568-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B447ADCAE1
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 14:17:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 055471889375
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 12:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BB602F2C62;
	Tue, 17 Jun 2025 12:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="lrOG1v53"
X-Original-To: netdev@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A07A2EBDF5;
	Tue, 17 Jun 2025 12:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750162355; cv=none; b=frFcluScWXYg5dqnGQxXux3DDJxS9SUzW3wirYhsD7PvbnpV0rymlBRLQpOiSc/CkHSvg4q1a+mZjZu5WgdLXRoWBqk9IrlrMYpZz/8EOVbfN6uv0G3gArlRt7YD7BOFtSKf0SvnnCc73HWn6FuZ7qeEo9c9uzI+2LD3a0GEEHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750162355; c=relaxed/simple;
	bh=HFQWAfZvvOVviJYU4nJ3AIIjhLUSvteSwDQkYZUucVo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LbjCBqOgzz1g8/rTerRzTihchXDC4zgr0PLaV3+OlTclprRnjHN89I7eyietTHPRjO+Cwoz20T88k6rgNq8ovqQjG6uvC9LIbl2ksa9AolaJDIhOgNU3o9eJ9yLeo4LSSY/NxnhSFBGnGMBTq0s/mU8V9kl6nyxlyLLK6GCtnHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=lrOG1v53; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id F0BBF439F6;
	Tue, 17 Jun 2025 12:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1750162350;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t4eclzSe50+bbHVxcyvpL552HOn3zu2XAeniKUWOrVg=;
	b=lrOG1v53OcOxqCUI42LEgOo7+e+VA8K7CS9x8rFSMSraBWq9iZHktA1ALMuTs/q+sDnB8v
	jAtWuEEu6RA/EI4Pnms4AYgXhLNB/IZzYCFcp9z0U68U5deVghzh2aksnDNBbPflc8+mLA
	H+JwjV1X4j10CJ6y1JhcGD246JE7U27D5ka1TjOWBalv6mLerd9uizJr1gJ6yZ7PgChEpn
	hG6QoapPoAbP40/EBoVuLa5o2OhCJgVPWzVJnym66svFrtsb72+VcdrAO5gVa2ZBkDeJPo
	FP91h0wRoX2I84tAUtqc4b1vE8XJX8tgPmn/81z6FaxQhCWj1staVYq5E0i0lQ==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Tue, 17 Jun 2025 14:12:11 +0200
Subject: [PATCH net-next v14 12/13] net: pse-pd: tps23881: Add support for
 static port priority feature
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250617-feature_poe_port_prio-v14-12-78a1a645e2ee@bootlin.com>
References: <20250617-feature_poe_port_prio-v14-0-78a1a645e2ee@bootlin.com>
In-Reply-To: <20250617-feature_poe_port_prio-v14-0-78a1a645e2ee@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>, Oleksij Rempel <o.rempel@pengutronix.de>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Jonathan Corbet <corbet@lwn.net>, Donald Hunter <donald.hunter@gmail.com>, 
 Rob Herring <robh@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 Simon Horman <horms@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-doc@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>, 
 Dent Project <dentproject@linuxfoundation.org>, kernel@pengutronix.de, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Kory Maincent (Dent Project)" <kory.maincent@bootlin.com>
X-Mailer: b4 0.15-dev-8cb71
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgdduhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefmohhrhicuofgrihhntggvnhhtuceokhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepvefgvdfgkeetgfefgfegkedugffghfdtffeftdeuteehjedtvdelvddvleehtdevnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopegluddvjedrtddruddrudgnpdhmrghilhhfrhhomhepkhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvdejpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmpdhrtghpthhtohepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtoheptghonhhorhdoughtsehkvghrnhgvlhdrohhrghdpr
 hgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqughotgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkhihlvgdrshifvghnshhonhesvghsthdrthgvtghh
X-GND-Sasl: kory.maincent@bootlin.com

From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>

This patch enhances PSE callbacks by introducing support for the static
port priority feature. It extends interrupt management to handle and report
detection, classification, and disconnection events. Additionally, it
introduces the pi_get_pw_req() callback, which provides information about
the power requested by the Powered Devices.

Interrupt support is essential for the proper functioning of the TPS23881
controller. Without it, after a power-on (PWON), the controller will
no longer perform detection and classification. This could lead to
potential hazards, such as connecting a non-PoE device after a PoE device,
which might result in magic smoke.

Signed-off-by: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
Reviewed-by: Oleksij Rempel <o.rempel@pengutronix.de>
---

Change in v7:
- Add configuration of the power limit back after an over current event.

Change in v4:
- Fix variable type nit.

Change in v3:
- New patch
---
 drivers/net/pse-pd/tps23881.c | 244 +++++++++++++++++++++++++++++++++++++++---
 1 file changed, 228 insertions(+), 16 deletions(-)

diff --git a/drivers/net/pse-pd/tps23881.c b/drivers/net/pse-pd/tps23881.c
index 7a9a5dbe0cb1..63f8f43062bc 100644
--- a/drivers/net/pse-pd/tps23881.c
+++ b/drivers/net/pse-pd/tps23881.c
@@ -20,20 +20,30 @@
 
 #define TPS23881_REG_IT		0x0
 #define TPS23881_REG_IT_MASK	0x1
+#define TPS23881_REG_IT_DISF	BIT(2)
+#define TPS23881_REG_IT_DETC	BIT(3)
+#define TPS23881_REG_IT_CLASC	BIT(4)
 #define TPS23881_REG_IT_IFAULT	BIT(5)
 #define TPS23881_REG_IT_SUPF	BIT(7)
+#define TPS23881_REG_DET_EVENT	0x5
 #define TPS23881_REG_FAULT	0x7
 #define TPS23881_REG_SUPF_EVENT	0xb
 #define TPS23881_REG_TSD	BIT(7)
+#define TPS23881_REG_DISC	0xc
 #define TPS23881_REG_PW_STATUS	0x10
 #define TPS23881_REG_OP_MODE	0x12
+#define TPS23881_REG_DISC_EN	0x13
 #define TPS23881_OP_MODE_SEMIAUTO	0xaaaa
 #define TPS23881_REG_DIS_EN	0x13
 #define TPS23881_REG_DET_CLA_EN	0x14
 #define TPS23881_REG_GEN_MASK	0x17
+#define TPS23881_REG_CLCHE	BIT(2)
+#define TPS23881_REG_DECHE	BIT(3)
 #define TPS23881_REG_NBITACC	BIT(5)
 #define TPS23881_REG_INTEN	BIT(7)
 #define TPS23881_REG_PW_EN	0x19
+#define TPS23881_REG_RESET	0x1a
+#define TPS23881_REG_CLRAIN	BIT(7)
 #define TPS23881_REG_2PAIR_POL1	0x1e
 #define TPS23881_REG_PORT_MAP	0x26
 #define TPS23881_REG_PORT_POWER	0x29
@@ -178,6 +188,7 @@ static int tps23881_pi_enable(struct pse_controller_dev *pcdev, int id)
 	struct i2c_client *client = priv->client;
 	u8 chan;
 	u16 val;
+	int ret;
 
 	if (id >= TPS23881_MAX_CHANS)
 		return -ERANGE;
@@ -191,7 +202,22 @@ static int tps23881_pi_enable(struct pse_controller_dev *pcdev, int id)
 				       BIT(chan % 4));
 	}
 
-	return i2c_smbus_write_word_data(client, TPS23881_REG_PW_EN, val);
+	ret = i2c_smbus_write_word_data(client, TPS23881_REG_PW_EN, val);
+	if (ret)
+		return ret;
+
+	/* Enable DC disconnect*/
+	chan = priv->port[id].chan[0];
+	ret = i2c_smbus_read_word_data(client, TPS23881_REG_DISC_EN);
+	if (ret < 0)
+		return ret;
+
+	val = tps23881_set_val(ret, chan, 0, BIT(chan % 4), BIT(chan % 4));
+	ret = i2c_smbus_write_word_data(client, TPS23881_REG_DISC_EN, val);
+	if (ret)
+		return ret;
+
+	return 0;
 }
 
 static int tps23881_pi_disable(struct pse_controller_dev *pcdev, int id)
@@ -224,6 +250,17 @@ static int tps23881_pi_disable(struct pse_controller_dev *pcdev, int id)
 	 */
 	mdelay(5);
 
+	/* Disable DC disconnect*/
+	chan = priv->port[id].chan[0];
+	ret = i2c_smbus_read_word_data(client, TPS23881_REG_DISC_EN);
+	if (ret < 0)
+		return ret;
+
+	val = tps23881_set_val(ret, chan, 0, 0, BIT(chan % 4));
+	ret = i2c_smbus_write_word_data(client, TPS23881_REG_DISC_EN, val);
+	if (ret)
+		return ret;
+
 	/* Enable detection and classification */
 	ret = i2c_smbus_read_word_data(client, TPS23881_REG_DET_CLA_EN);
 	if (ret < 0)
@@ -919,6 +956,47 @@ static int tps23881_setup_pi_matrix(struct pse_controller_dev *pcdev)
 	return ret;
 }
 
+static int tps23881_power_class_table[] = {
+	-ERANGE,
+	4000,
+	7000,
+	15500,
+	30000,
+	15500,
+	15500,
+	-ERANGE,
+	45000,
+	60000,
+	75000,
+	90000,
+	15500,
+	45000,
+	-ERANGE,
+	-ERANGE,
+};
+
+static int tps23881_pi_get_pw_req(struct pse_controller_dev *pcdev, int id)
+{
+	struct tps23881_priv *priv = to_tps23881_priv(pcdev);
+	struct i2c_client *client = priv->client;
+	u8 reg, chan;
+	int ret;
+	u16 val;
+
+	/* For a 4-pair the classification need 5ms to be completed */
+	if (priv->port[id].is_4p)
+		mdelay(5);
+
+	chan = priv->port[id].chan[0];
+	reg = TPS23881_REG_DISC + (chan % 4);
+	ret = i2c_smbus_read_word_data(client, reg);
+	if (ret < 0)
+		return ret;
+
+	val = tps23881_calc_val(ret, chan, 4, 0xf);
+	return tps23881_power_class_table[val];
+}
+
 static const struct pse_controller_ops tps23881_ops = {
 	.setup_pi_matrix = tps23881_setup_pi_matrix,
 	.pi_enable = tps23881_pi_enable,
@@ -931,6 +1009,7 @@ static const struct pse_controller_ops tps23881_ops = {
 	.pi_get_pw_limit = tps23881_pi_get_pw_limit,
 	.pi_set_pw_limit = tps23881_pi_set_pw_limit,
 	.pi_get_pw_limit_ranges = tps23881_pi_get_pw_limit_ranges,
+	.pi_get_pw_req = tps23881_pi_get_pw_req,
 };
 
 static const char fw_parity_name[] = "ti/tps23881/tps23881-parity-14.bin";
@@ -1088,17 +1167,113 @@ static void tps23881_irq_event_over_temp(struct tps23881_priv *priv,
 	}
 }
 
-static void tps23881_irq_event_over_current(struct tps23881_priv *priv,
-					    u16 reg_val,
-					    unsigned long *notifs,
-					    unsigned long *notifs_mask)
+static int tps23881_irq_event_over_current(struct tps23881_priv *priv,
+					   u16 reg_val,
+					   unsigned long *notifs,
+					   unsigned long *notifs_mask)
 {
+	int i, ret;
 	u8 chans;
 
 	chans = tps23881_irq_export_chans_helper(reg_val, 0);
+	if (!chans)
+		return 0;
+
+	tps23881_set_notifs_helper(priv, chans, notifs, notifs_mask,
+				   ETHTOOL_PSE_EVENT_OVER_CURRENT |
+				   ETHTOOL_C33_PSE_EVENT_DISCONNECTION);
+
+	/* Over Current event resets the power limit registers so we need
+	 * to configured it again.
+	 */
+	for_each_set_bit(i, notifs_mask, priv->pcdev.nr_lines) {
+		if (priv->port[i].pw_pol < 0)
+			continue;
+
+		ret = tps23881_pi_enable_manual_pol(priv, i);
+		if (ret < 0)
+			return ret;
+
+		/* Set power policy */
+		ret = tps23881_pi_set_pw_pol_limit(priv, i,
+						   priv->port[i].pw_pol,
+						   priv->port[i].is_4p);
+		if (ret < 0)
+			return ret;
+	}
+
+	return 0;
+}
+
+static void tps23881_irq_event_disconnection(struct tps23881_priv *priv,
+					     u16 reg_val,
+					     unsigned long *notifs,
+					     unsigned long *notifs_mask)
+{
+	u8 chans;
+
+	chans = tps23881_irq_export_chans_helper(reg_val, 4);
 	if (chans)
 		tps23881_set_notifs_helper(priv, chans, notifs, notifs_mask,
-					   ETHTOOL_PSE_EVENT_OVER_CURRENT);
+					   ETHTOOL_C33_PSE_EVENT_DISCONNECTION);
+}
+
+static int tps23881_irq_event_detection(struct tps23881_priv *priv,
+					u16 reg_val,
+					unsigned long *notifs,
+					unsigned long *notifs_mask)
+{
+	enum ethtool_pse_event event;
+	int reg, ret, i, val;
+	unsigned long chans;
+
+	chans = tps23881_irq_export_chans_helper(reg_val, 0);
+	for_each_set_bit(i, &chans, TPS23881_MAX_CHANS) {
+		reg = TPS23881_REG_DISC + (i % 4);
+		ret = i2c_smbus_read_word_data(priv->client, reg);
+		if (ret < 0)
+			return ret;
+
+		val = tps23881_calc_val(ret, i, 0, 0xf);
+		/* If detection valid */
+		if (val == 0x4)
+			event = ETHTOOL_C33_PSE_EVENT_DETECTION;
+		else
+			event = ETHTOOL_C33_PSE_EVENT_DISCONNECTION;
+
+		tps23881_set_notifs_helper(priv, BIT(i), notifs,
+					   notifs_mask, event);
+	}
+
+	return 0;
+}
+
+static int tps23881_irq_event_classification(struct tps23881_priv *priv,
+					     u16 reg_val,
+					     unsigned long *notifs,
+					     unsigned long *notifs_mask)
+{
+	int reg, ret, val, i;
+	unsigned long chans;
+
+	chans = tps23881_irq_export_chans_helper(reg_val, 4);
+	for_each_set_bit(i, &chans, TPS23881_MAX_CHANS) {
+		reg = TPS23881_REG_DISC + (i % 4);
+		ret = i2c_smbus_read_word_data(priv->client, reg);
+		if (ret < 0)
+			return ret;
+
+		val = tps23881_calc_val(ret, i, 4, 0xf);
+		/* Do not report classification event for unknown class */
+		if (!val || val == 0x8 || val == 0xf)
+			continue;
+
+		tps23881_set_notifs_helper(priv, BIT(i), notifs,
+					   notifs_mask,
+					   ETHTOOL_C33_PSE_EVENT_CLASSIFICATION);
+	}
+
+	return 0;
 }
 
 static int tps23881_irq_event_handler(struct tps23881_priv *priv, u16 reg,
@@ -1106,7 +1281,7 @@ static int tps23881_irq_event_handler(struct tps23881_priv *priv, u16 reg,
 				      unsigned long *notifs_mask)
 {
 	struct i2c_client *client = priv->client;
-	int ret;
+	int ret, val;
 
 	/* The Supply event bit is repeated twice so we only need to read
 	 * the one from the first byte.
@@ -1118,13 +1293,36 @@ static int tps23881_irq_event_handler(struct tps23881_priv *priv, u16 reg,
 		tps23881_irq_event_over_temp(priv, ret, notifs, notifs_mask);
 	}
 
-	if (reg & (TPS23881_REG_IT_IFAULT | TPS23881_REG_IT_IFAULT << 8)) {
+	if (reg & (TPS23881_REG_IT_IFAULT | TPS23881_REG_IT_IFAULT << 8 |
+		   TPS23881_REG_IT_DISF | TPS23881_REG_IT_DISF << 8)) {
 		ret = i2c_smbus_read_word_data(client, TPS23881_REG_FAULT);
 		if (ret < 0)
 			return ret;
-		tps23881_irq_event_over_current(priv, ret, notifs, notifs_mask);
+		ret = tps23881_irq_event_over_current(priv, ret, notifs,
+						      notifs_mask);
+		if (ret)
+			return ret;
+
+		tps23881_irq_event_disconnection(priv, ret, notifs, notifs_mask);
 	}
 
+	if (reg & (TPS23881_REG_IT_DETC | TPS23881_REG_IT_DETC << 8 |
+		   TPS23881_REG_IT_CLASC | TPS23881_REG_IT_CLASC << 8)) {
+		ret = i2c_smbus_read_word_data(client, TPS23881_REG_DET_EVENT);
+		if (ret < 0)
+			return ret;
+
+		val = ret;
+		ret = tps23881_irq_event_detection(priv, val, notifs,
+						   notifs_mask);
+		if (ret)
+			return ret;
+
+		ret = tps23881_irq_event_classification(priv, val, notifs,
+							notifs_mask);
+		if (ret)
+			return ret;
+	}
 	return 0;
 }
 
@@ -1178,7 +1376,14 @@ static int tps23881_setup_irq(struct tps23881_priv *priv, int irq)
 	int ret;
 	u16 val;
 
-	val = TPS23881_REG_IT_IFAULT | TPS23881_REG_IT_SUPF;
+	if (!irq) {
+		dev_err(&client->dev, "interrupt is missing");
+		return -EINVAL;
+	}
+
+	val = TPS23881_REG_IT_IFAULT | TPS23881_REG_IT_SUPF |
+	      TPS23881_REG_IT_DETC | TPS23881_REG_IT_CLASC |
+	      TPS23881_REG_IT_DISF;
 	val |= val << 8;
 	ret = i2c_smbus_write_word_data(client, TPS23881_REG_IT_MASK, val);
 	if (ret)
@@ -1188,11 +1393,19 @@ static int tps23881_setup_irq(struct tps23881_priv *priv, int irq)
 	if (ret < 0)
 		return ret;
 
-	val = (u16)(ret | TPS23881_REG_INTEN | TPS23881_REG_INTEN << 8);
+	val = TPS23881_REG_INTEN | TPS23881_REG_CLCHE | TPS23881_REG_DECHE;
+	val |= val << 8;
+	val |= (u16)ret;
 	ret = i2c_smbus_write_word_data(client, TPS23881_REG_GEN_MASK, val);
 	if (ret < 0)
 		return ret;
 
+	/* Reset interrupts registers */
+	ret = i2c_smbus_write_word_data(client, TPS23881_REG_RESET,
+					TPS23881_REG_CLRAIN);
+	if (ret < 0)
+		return ret;
+
 	return devm_pse_irq_helper(&priv->pcdev, irq, 0, &irq_desc);
 }
 
@@ -1270,17 +1483,16 @@ static int tps23881_i2c_probe(struct i2c_client *client)
 	priv->pcdev.dev = dev;
 	priv->pcdev.types = ETHTOOL_PSE_C33;
 	priv->pcdev.nr_lines = TPS23881_MAX_CHANS;
+	priv->pcdev.supp_budget_eval_strategies = PSE_BUDGET_EVAL_STRAT_STATIC;
 	ret = devm_pse_controller_register(dev, &priv->pcdev);
 	if (ret) {
 		return dev_err_probe(dev, ret,
 				     "failed to register PSE controller\n");
 	}
 
-	if (client->irq) {
-		ret = tps23881_setup_irq(priv, client->irq);
-		if (ret)
-			return ret;
-	}
+	ret = tps23881_setup_irq(priv, client->irq);
+	if (ret)
+		return ret;
 
 	return ret;
 }

-- 
2.43.0



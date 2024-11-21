Return-Path: <netdev+bounces-146678-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCAF19D4F28
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 15:53:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4323D1F22A24
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 14:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 160A01E32A7;
	Thu, 21 Nov 2024 14:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Agql/hyI"
X-Original-To: netdev@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D4A1E284B;
	Thu, 21 Nov 2024 14:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732200284; cv=none; b=cx/o6K/BY0geBk8sUft8l3PeHeMHBh5UTUIgvrN1gjajg3AVOrbVVE62PBy7SLKfuoP0mta41JSOEu++jMXg4Zm2/0TYQA7Q41V5/ZT+R0otB1V91V0IUyVL8d1najl621Riba0hMn808/J5AFoOOwdNNhh8fUovRQ6cMkhL7XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732200284; c=relaxed/simple;
	bh=v5J+08NmArma6dpVpg7cLAzvIs/ri2nCEqzIMUR01Us=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Cve6J3xoblH2ndXAfCp9GFz7kyIjDqh3ZD8HV915FIgy6H9lONl3nmHQfVQImO9mgqCBrv6nN+m0nGIM2kDSmXlfizib4/NLVgNPqhTm22ja9DguHz7de260bdis7nK3eIK7KF6lPo3Bz0DUhF3jLLFuvCvW+iDrZaD2NUKI/vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Agql/hyI; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1B2AB4000C;
	Thu, 21 Nov 2024 14:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1732200280;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bp8/QWFlegjnCbGdXZycjaz1LZVfDVH9JsjekA21Oek=;
	b=Agql/hyImLGy5UmyugslsKGl/AimG2y4gL+/NaM0z1hc9G+gYZ/PCXWhIOI8BaaYnhGy5z
	8OClCK41XV8IhMSXsklIHIhttPJOMHVgYv34idieRJaABRow6ZI9huFXIUmhrE6Nf+rzXh
	tYe0Wq7RC9WfULCC487qRs0SAkco3a9XCNJkNHkhyfOqt2GaLOiWX94y4601GQCyXYYtPd
	4QbDiwYVgyne0ba8ptdGYRRzJmPliIDpc2vcyMJSdLb5f1F2/KBpj/3PvK22UyQZMQMK4l
	DEqCy0jiPOzQzHYI5Y1U9ZI4LPzr96kqbPN1NKZsyjnHuSKZuZDJEizoIZUWeA==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Thu, 21 Nov 2024 15:42:52 +0100
Subject: [PATCH RFC net-next v3 26/27] net: pse-pd: tps23881: Add support
 for static port priority feature
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241121-feature_poe_port_prio-v3-26-83299fa6967c@bootlin.com>
References: <20241121-feature_poe_port_prio-v3-0-83299fa6967c@bootlin.com>
In-Reply-To: <20241121-feature_poe_port_prio-v3-0-83299fa6967c@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>, Oleksij Rempel <o.rempel@pengutronix.de>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Jonathan Corbet <corbet@lwn.net>, Donald Hunter <donald.hunter@gmail.com>, 
 Rob Herring <robh@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 Simon Horman <horms@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-doc@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>, 
 Dent Project <dentproject@linuxfoundation.org>, kernel@pengutronix.de, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.15-dev-8cb71
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

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

We may need a fix for the interrupt support in old version of Linux.

Change in v3:
- New patch
---
 drivers/net/pse-pd/tps23881.c | 197 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 188 insertions(+), 9 deletions(-)

diff --git a/drivers/net/pse-pd/tps23881.c b/drivers/net/pse-pd/tps23881.c
index 6fe8f150231f..49757e141990 100644
--- a/drivers/net/pse-pd/tps23881.c
+++ b/drivers/net/pse-pd/tps23881.c
@@ -19,20 +19,30 @@
 
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
@@ -189,6 +199,17 @@ static int tps23881_pi_enable(struct pse_controller_dev *pcdev, int id)
 	if (ret)
 		return ret;
 
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
 	return 0;
 }
 
@@ -226,6 +247,17 @@ static int tps23881_pi_disable(struct pse_controller_dev *pcdev, int id)
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
@@ -1002,6 +1034,47 @@ static int tps23881_pi_set_current_limit(struct pse_controller_dev *pcdev,
 	return 0;
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
@@ -1011,6 +1084,7 @@ static const struct pse_controller_ops tps23881_ops = {
 	.pi_get_voltage = tps23881_pi_get_voltage,
 	.pi_get_current_limit = tps23881_pi_get_current_limit,
 	.pi_set_current_limit = tps23881_pi_set_current_limit,
+	.pi_get_pw_req = tps23881_pi_get_pw_req,
 };
 
 static const char fw_parity_name[] = "ti/tps23881/tps23881-parity-14.bin";
@@ -1181,12 +1255,83 @@ static void tps23881_irq_event_over_current(struct tps23881_priv *priv,
 					   ETHTOOL_PSE_EVENT_OVER_CURRENT);
 }
 
+static void tps23881_irq_event_disconnection(struct tps23881_priv *priv,
+					     u16 reg_val,
+					     unsigned long *notifs,
+					     unsigned long *notifs_mask)
+{
+	u8 chans;
+
+	chans = tps23881_it_export_chans_helper(reg_val, 4);
+	if (chans)
+		tps23881_set_notifs_helper(priv, chans, notifs, notifs_mask,
+					   ETHTOOL_C33_PSE_EVENT_DISCONNECTION);
+}
+
+static int tps23881_irq_event_detection(struct tps23881_priv *priv,
+					u16 reg_val,
+					unsigned long *notifs,
+					unsigned long *notifs_mask)
+{
+	enum ethtool_pse_events event;
+	int reg, ret, i, val;
+	u8 chans;
+
+	chans = tps23881_it_export_chans_helper(reg_val, 0);
+	for_each_set_bit(i, (unsigned long *)&chans, TPS23881_MAX_CHANS) {
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
+	u8 chans;
+
+	chans = tps23881_it_export_chans_helper(reg_val, 4);
+	for_each_set_bit(i, (unsigned long *)&chans, TPS23881_MAX_CHANS) {
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
+}
+
 static int tps23881_irq_event_handler(struct tps23881_priv *priv, u16 reg,
 				      unsigned long *notifs,
 				      unsigned long *notifs_mask)
 {
 	struct i2c_client *client = priv->client;
-	int ret;
+	int ret, val;
 
 	/* The Supply event bit is repeated twice so we only need to read
 	 * the one from the first byte.
@@ -1198,13 +1343,33 @@ static int tps23881_irq_event_handler(struct tps23881_priv *priv, u16 reg,
 		tps23881_irq_event_over_temp(priv, ret, notifs, notifs_mask);
 	}
 
-	if (reg & (TPS23881_REG_IT_IFAULT | TPS23881_REG_IT_IFAULT << 8)) {
+	if (reg & (TPS23881_REG_IT_IFAULT | TPS23881_REG_IT_IFAULT << 8 |
+		   TPS23881_REG_IT_DISF | TPS23881_REG_IT_DISF << 8)) {
 		ret = i2c_smbus_read_word_data(client, TPS23881_REG_FAULT);
 		if (ret < 0)
 			return ret;
 		tps23881_irq_event_over_current(priv, ret, notifs, notifs_mask);
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
 
@@ -1250,7 +1415,14 @@ static int tps23881_setup_irq(struct tps23881_priv *priv, int irq)
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
@@ -1260,11 +1432,19 @@ static int tps23881_setup_irq(struct tps23881_priv *priv, int irq)
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
 
@@ -1342,17 +1522,16 @@ static int tps23881_i2c_probe(struct i2c_client *client)
 	priv->pcdev.dev = dev;
 	priv->pcdev.types = ETHTOOL_PSE_C33;
 	priv->pcdev.nr_lines = TPS23881_MAX_CHANS;
+	priv->pcdev.port_prio_supp_modes = ETHTOOL_PSE_PORT_PRIO_STATIC;
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
2.34.1



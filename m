Return-Path: <netdev+bounces-146660-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A1649D4EEA
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 15:46:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE7731F20FB9
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 14:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3338D1DEFC4;
	Thu, 21 Nov 2024 14:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="btoHyHOm"
X-Original-To: netdev@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF1A1DE8A9;
	Thu, 21 Nov 2024 14:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732200233; cv=none; b=cDadyP3aMmT2CIDz679BFPqRXuSfkq0ROu3eEID03jqYQurEyL06QxKR4LaCNjWHoZGFnQA1xl2MxzctuRvU4FWdrsXKuq7DEeXSFqradqyjzBXcKwWNdKde7Em+mOMRldPYSw1jTKxTNw38buo24GepzivVBovI5FKCX6fN1mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732200233; c=relaxed/simple;
	bh=N2VnxB2ko/xn9R1ZPLwugn+mKFltCGe40AyxoZVHGUw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EPUrOWGz0a8zlIerQ6c3Ck+LfunA6+Jg+i57rx9E2Ruwc0nG1Tbzd4v223azxxtDQeapWxAi1mWi5vG5MgRRkiCnOcWVPoL8Y7FtwOf2LB8+SGp3rN5omFV/fABfsrjHPK420qYkwPdqTDUD8hn6lgiF55HuXz/03iQWoZXjdmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=btoHyHOm; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id AFBD640006;
	Thu, 21 Nov 2024 14:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1732200228;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1a3e7ksDGRat7Ji4aJzMVkldZtaeGAH9wNk6J3hf2Ow=;
	b=btoHyHOm5j4Aivtwyl4rDU6QojJjkxPSk6VHX7lHtxohOZFJwTOe1aY1tt5eWeV0cmssRN
	1GNrynnc9OFf4ERyqs9w+vN1ihztHw5q6/QO7rjZsEMBBa1ASyxAM5+/pkdwK3b1LR5eBR
	BYi9c4w6oA31o/yIYay0oZ/I8wDA0VBUYLqXhVtLSi63R48bBIBAczlGRoZYIa41146awc
	0kgaVxtzAWTwlYExuq0Loid016ddX5TprKInvArgnmFY21abdwqVk209oqnqXDUWw1pe9s
	hRF9IQNtoiZyeeilYdZhGUyu3wT5I2VCBS5DCn4MdgUaTPUu2+rs8tA+txWAcA==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Thu, 21 Nov 2024 15:42:34 +0100
Subject: [PATCH RFC net-next v3 08/27] net: pse-pd: tps23881: Add support
 for power limit and measurement features
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241121-feature_poe_port_prio-v3-8-83299fa6967c@bootlin.com>
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

Expand PSE callbacks to support the newly introduced
pi_get/set_current_limit() and pi_get_voltage() functions. These callbacks
allow for power limit configuration in the TPS23881 controller.

Additionally, the patch includes the detected class, the current power
delivered and the power limit ranges in the status returned, providing more
comprehensive PoE status reporting.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

Change in v3:
- NIT change, use tps23881_set_val helper to set the power limit
  register value.
- Add policy varaible internally to being able to reconfigure it after a
  PWOFF call.

Change in v2:
- Use newly introduced helpers.
---
 drivers/net/pse-pd/tps23881.c | 326 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 324 insertions(+), 2 deletions(-)

diff --git a/drivers/net/pse-pd/tps23881.c b/drivers/net/pse-pd/tps23881.c
index 58864b7d28d2..b25561f95774 100644
--- a/drivers/net/pse-pd/tps23881.c
+++ b/drivers/net/pse-pd/tps23881.c
@@ -25,20 +25,34 @@
 #define TPS23881_REG_GEN_MASK	0x17
 #define TPS23881_REG_NBITACC	BIT(5)
 #define TPS23881_REG_PW_EN	0x19
+#define TPS23881_REG_2PAIR_POL1	0x1e
 #define TPS23881_REG_PORT_MAP	0x26
 #define TPS23881_REG_PORT_POWER	0x29
-#define TPS23881_REG_POEPLUS	0x40
+#define TPS23881_REG_4PAIR_POL1	0x2a
+#define TPS23881_REG_INPUT_V	0x2e
+#define TPS23881_REG_CHAN1_A	0x30
+#define TPS23881_REG_CHAN1_V	0x32
+#define TPS23881_REG_FOLDBACK	0x40
 #define TPS23881_REG_TPON	BIT(0)
 #define TPS23881_REG_FWREV	0x41
 #define TPS23881_REG_DEVID	0x43
 #define TPS23881_REG_DEVID_MASK	0xF0
 #define TPS23881_DEVICE_ID	0x02
+#define TPS23881_REG_CHAN1_CLASS	0x4c
 #define TPS23881_REG_SRAM_CTRL	0x60
 #define TPS23881_REG_SRAM_DATA	0x61
 
+#define TPS23881_UV_STEP	3662
+#define TPS23881_MAX_UV		60000000
+#define TPS23881_NA_STEP	70190
+#define TPS23881_MAX_UA		1150000
+#define TPS23881_MW_STEP	500
+#define TPS23881_MIN_PI_PW_LIMIT	2000
+
 struct tps23881_port_desc {
 	u8 chan[2];
 	bool is_4p;
+	int pw_pol;
 };
 
 struct tps23881_priv {
@@ -102,6 +116,42 @@ static u16 tps23881_set_val(u16 reg_val, u8 chan, u8 field_offset,
 	return reg_val;
 }
 
+static int
+tps23881_pi_set_2p_pw_limit(struct tps23881_priv *priv, u8 chan, u8 pw_pol)
+{
+	struct i2c_client *client = priv->client;
+	int ret, reg;
+	u16 val;
+
+	reg = TPS23881_REG_2PAIR_POL1 + (chan % 4);
+	ret = i2c_smbus_read_word_data(client, reg);
+	if (ret < 0)
+		return ret;
+
+	val = tps23881_set_val(ret, chan, 0, 0xff, pw_pol);
+	return i2c_smbus_write_word_data(client, reg, val);
+}
+
+static int
+tps23881_pi_set_4p_pw_limit(struct tps23881_priv *priv, u8 chan, u8 pw_pol)
+{
+	struct i2c_client *client = priv->client;
+	int ret, reg;
+	u16 val;
+
+	if ((chan % 4) < 2)
+		reg = TPS23881_REG_4PAIR_POL1;
+	else
+		reg = TPS23881_REG_4PAIR_POL1 + 1;
+
+	ret = i2c_smbus_read_word_data(client, reg);
+	if (ret < 0)
+		return ret;
+
+	val = tps23881_set_val(ret, chan, 0, 0xff, pw_pol);
+	return i2c_smbus_write_word_data(client, reg, val);
+}
+
 static int tps23881_pi_enable(struct pse_controller_dev *pcdev, int id)
 {
 	struct tps23881_priv *priv = to_tps23881_priv(pcdev);
@@ -184,7 +234,38 @@ static int tps23881_pi_disable(struct pse_controller_dev *pcdev, int id)
 				       BIT(chan % 4));
 	}
 
-	return i2c_smbus_write_word_data(client, TPS23881_REG_DET_CLA_EN, val);
+	ret = i2c_smbus_write_word_data(client, TPS23881_REG_DET_CLA_EN, val);
+	if (ret)
+		return ret;
+
+	/* No power policy set */
+	if (priv->port[id].pw_pol < 0)
+		return 0;
+
+	chan = priv->port[id].chan[0];
+	ret = i2c_smbus_read_byte_data(client, TPS23881_REG_FOLDBACK);
+	if (ret < 0)
+		return ret;
+
+	/* No need to test if the chan is PoE4 as setting either bit for a
+	 * 4P configured port disables the automatic configuration on both
+	 * channels.
+	 */
+	val = tps23881_set_val(ret, chan, 0, BIT(chan % 4), BIT(chan % 4));
+	ret = i2c_smbus_write_byte_data(client, TPS23881_REG_FOLDBACK, val);
+	if (ret)
+		return ret;
+
+	/* Set power policy */
+	if (priv->port[id].is_4p)
+		/* One chan is enough to configure the PI power limit */
+		ret = tps23881_pi_set_4p_pw_limit(priv, chan,
+						  priv->port[id].pw_pol);
+	else
+		ret = tps23881_pi_set_2p_pw_limit(priv, chan,
+						  priv->port[id].pw_pol);
+
+	return ret;
 }
 
 static int tps23881_pi_is_enabled(struct pse_controller_dev *pcdev, int id)
@@ -214,6 +295,141 @@ static int tps23881_pi_is_enabled(struct pse_controller_dev *pcdev, int id)
 	return enabled;
 }
 
+static int tps23881_pi_get_voltage(struct pse_controller_dev *pcdev, int id)
+{
+	struct tps23881_priv *priv = to_tps23881_priv(pcdev);
+	struct i2c_client *client = priv->client;
+	int ret;
+	u64 uV;
+
+	ret = i2c_smbus_read_word_data(client, TPS23881_REG_INPUT_V);
+	if (ret < 0)
+		return ret;
+
+	uV = ret & 0x3fff;
+	uV *= TPS23881_UV_STEP;
+	if (uV > TPS23881_MAX_UV) {
+		dev_err(&client->dev, "voltage read out of range\n");
+		return -ERANGE;
+	}
+
+	return (int)uV;
+}
+
+static int
+tps23881_pi_get_chan_current(struct tps23881_priv *priv, u8 chan)
+{
+	struct i2c_client *client = priv->client;
+	int reg, ret;
+	u64 tmp_64;
+
+	if (chan < 4)
+		/* Registers 0x30 0x34 0x38 0x3c */
+		reg = TPS23881_REG_CHAN1_A + chan * 4;
+	else
+		/* Registers 0x31 0x35 0x39 0x3d */
+		reg = TPS23881_REG_CHAN1_A + 1 + (chan % 4) * 4;
+
+	ret = i2c_smbus_read_word_data(client, reg);
+	if (ret < 0)
+		return ret;
+
+	tmp_64 = ret;
+	tmp_64 *= TPS23881_NA_STEP;
+	/* uA = nA / 1000 */
+	tmp_64 = DIV_ROUND_CLOSEST_ULL(tmp_64, 1000);
+	if (tmp_64 > TPS23881_MAX_UA) {
+		dev_err(&client->dev, "current read out of range\n");
+		return -ERANGE;
+	}
+	return (int)tmp_64;
+}
+
+static int
+tps23881_pi_get_power(struct tps23881_priv *priv, unsigned long id)
+{
+	int ret, uV, uA;
+	u64 tmp_64;
+	u8 chan;
+
+	ret = tps23881_pi_get_voltage(&priv->pcdev, id);
+	if (ret < 0)
+		return ret;
+	uV = ret;
+
+	chan = priv->port[id].chan[0];
+	ret = tps23881_pi_get_chan_current(priv, chan);
+	if (ret < 0)
+		return ret;
+	uA = ret;
+
+	if (priv->port[id].is_4p) {
+		chan = priv->port[id].chan[1];
+		ret = tps23881_pi_get_chan_current(priv, chan);
+		if (ret < 0)
+			return ret;
+		uA += ret;
+	}
+
+	tmp_64 = uV;
+	tmp_64 *= uA;
+	/* mW = uV * uA / 1000000000 */
+	return DIV_ROUND_CLOSEST_ULL(tmp_64, 1000000000);
+}
+
+static int
+tps23881_pi_get_pw_limit_chan(struct tps23881_priv *priv, u8 chan)
+{
+	struct i2c_client *client = priv->client;
+	int ret, reg;
+	u16 val;
+
+	reg = TPS23881_REG_2PAIR_POL1 + (chan % 4);
+	ret = i2c_smbus_read_word_data(client, reg);
+	if (ret < 0)
+		return ret;
+
+	val = tps23881_calc_val(ret, chan, 0, 0xff);
+	return val * TPS23881_MW_STEP;
+}
+
+static int tps23881_pi_get_pw_limit(struct tps23881_priv *priv, int id)
+{
+	int ret, mW;
+	u8 chan;
+
+	chan = priv->port[id].chan[0];
+	ret = tps23881_pi_get_pw_limit_chan(priv, chan);
+	if (ret < 0)
+		return ret;
+
+	mW = ret;
+	if (priv->port[id].is_4p) {
+		chan = priv->port[id].chan[1];
+		ret = tps23881_pi_get_pw_limit_chan(priv, chan);
+		if (ret < 0)
+			return ret;
+		mW += ret;
+	}
+
+	return mW;
+}
+
+static int tps23881_pi_get_class(struct tps23881_priv *priv, int id)
+{
+	struct i2c_client *client = priv->client;
+	int ret, reg;
+	u8 chan;
+
+	chan = priv->port[id].chan[0];
+	reg = TPS23881_REG_CHAN1_CLASS + (chan % 4);
+	ret = i2c_smbus_read_word_data(client, reg);
+	if (ret < 0)
+		return ret;
+
+	return tps23881_calc_val(ret, chan, 4, 0x0f);
+}
+
 static int tps23881_ethtool_get_status(struct pse_controller_dev *pcdev,
 				       unsigned long id,
 				       struct netlink_ext_ack *extack,
@@ -256,6 +472,31 @@ static int tps23881_ethtool_get_status(struct pse_controller_dev *pcdev,
 	else
 		status->c33_admin_state = ETHTOOL_C33_PSE_ADMIN_STATE_DISABLED;
 
+	ret = tps23881_pi_get_power(priv, id);
+	if (ret < 0)
+		return ret;
+	status->c33_actual_pw = ret;
+
+	status->c33_pw_limit_ranges = kzalloc(sizeof(*status->c33_pw_limit_ranges),
+					      GFP_KERNEL);
+	if (!status->c33_pw_limit_ranges)
+		return -ENOMEM;
+
+	status->c33_actual_pw = ret;
+	status->c33_pw_limit_nb_ranges = 1;
+	status->c33_pw_limit_ranges->min = TPS23881_MIN_PI_PW_LIMIT;
+	status->c33_pw_limit_ranges->max = MAX_PI_PW;
+
+	ret = tps23881_pi_get_pw_limit(priv, id);
+	if (ret < 0)
+		return ret;
+	status->c33_avail_pw_limit = ret;
+
+	ret = tps23881_pi_get_class(priv, id);
+	if (ret < 0)
+		return ret;
+	status->c33_pw_class = ret;
+
 	return 0;
 }
 
@@ -553,6 +794,9 @@ tps23881_write_port_matrix(struct tps23881_priv *priv,
 		if (port_matrix[i].exist)
 			priv->port[pi_id].chan[0] = lgcl_chan;
 
+		/* Initialize power policy internal value */
+		priv->port[pi_id].pw_pol = -1;
+
 		/* Set hardware port matrix for all ports */
 		val |= hw_chan << (lgcl_chan * 2);
 
@@ -672,12 +916,90 @@ static int tps23881_setup_pi_matrix(struct pse_controller_dev *pcdev)
 	return ret;
 }
 
+static int tps23881_pi_get_current_limit(struct pse_controller_dev *pcdev,
+					 int id)
+{
+	struct tps23881_priv *priv = to_tps23881_priv(pcdev);
+	int ret, mW, uV;
+	u64 tmp_64;
+
+	ret = tps23881_pi_get_pw_limit(priv, id);
+	if (ret < 0)
+		return ret;
+	mW = ret;
+
+	ret = tps23881_pi_get_voltage(pcdev, id);
+	if (ret < 0)
+		return ret;
+	uV = ret;
+
+	tmp_64 = mW;
+	tmp_64 *= 1000000000ull;
+	/* uA = mW * 1000000000 / uV */
+	return DIV_ROUND_CLOSEST_ULL(tmp_64, uV);
+}
+
+static int tps23881_pi_set_current_limit(struct pse_controller_dev *pcdev,
+					 int id, int max_uA)
+{
+	struct tps23881_priv *priv = to_tps23881_priv(pcdev);
+	u8 chan, pw_pol;
+	int ret, mW;
+	u64 tmp_64;
+	u16 val;
+
+	ret = tps23881_pi_get_voltage(pcdev, id);
+	if (ret < 0)
+		return ret;
+
+	tmp_64 = ret;
+	tmp_64 *= max_uA;
+	/* mW = uV * uA / 1000000000 */
+	mW = DIV_ROUND_CLOSEST_ULL(tmp_64, 1000000000);
+	if (mW < TPS23881_MIN_PI_PW_LIMIT || MAX_PI_PW < mW)
+		return -ERANGE;
+
+	chan = priv->port[id].chan[0];
+	ret = i2c_smbus_read_byte_data(priv->client, TPS23881_REG_FOLDBACK);
+	if (ret < 0)
+		return ret;
+
+	/* No need to test if the chan is PoE4 as setting either bit for a
+	 * 4P configured port disables the automatic configuration on both
+	 * channels.
+	 */
+	val = tps23881_set_val(ret, chan, 0, BIT(chan % 4), BIT(chan % 4));
+	ret = i2c_smbus_write_byte_data(priv->client, TPS23881_REG_FOLDBACK, val);
+	if (ret)
+		return ret;
+
+	pw_pol = DIV_ROUND_CLOSEST_ULL(mW, TPS23881_MW_STEP);
+
+	/* Save power policy to reconfigure it after a disabled call */
+	priv->port[id].pw_pol = pw_pol;
+	if (priv->port[id].is_4p) {
+		/* One chan is enough to configure the PI power limit */
+		ret = tps23881_pi_set_4p_pw_limit(priv, chan, pw_pol);
+		if (ret < 0)
+			return ret;
+	} else {
+		ret = tps23881_pi_set_2p_pw_limit(priv, chan, pw_pol);
+		if (ret < 0)
+			return ret;
+	}
+
+	return 0;
+}
+
 static const struct pse_controller_ops tps23881_ops = {
 	.setup_pi_matrix = tps23881_setup_pi_matrix,
 	.pi_enable = tps23881_pi_enable,
 	.pi_disable = tps23881_pi_disable,
 	.pi_is_enabled = tps23881_pi_is_enabled,
 	.ethtool_get_status = tps23881_ethtool_get_status,
+	.pi_get_voltage = tps23881_pi_get_voltage,
+	.pi_get_current_limit = tps23881_pi_get_current_limit,
+	.pi_set_current_limit = tps23881_pi_set_current_limit,
 };
 
 static const char fw_parity_name[] = "ti/tps23881/tps23881-parity-14.bin";

-- 
2.34.1



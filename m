Return-Path: <netdev+bounces-157060-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45A3EA08C98
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 10:45:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 408CF188DF2C
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 09:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49965210182;
	Fri, 10 Jan 2025 09:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="EKYVzxSV"
X-Original-To: netdev@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A6120E6E6;
	Fri, 10 Jan 2025 09:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736502057; cv=none; b=Amhim2UK37c20LJxrYtSpsOgE8WBvg3KLay2mx+xyXiAKCdnHLiR/BgswAxJ59ATyXq4EZkqcunXzgCu9anlpIgIcl4XHx5whP14iI7LfrwrAhQZoiQxw+Etpp4djBazbKqJ9CGFHphyNXvTy0qvcq6HrzzHveIzWcKc43sdl4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736502057; c=relaxed/simple;
	bh=ecjKM4sllO19bVpLxz8yv/ZU2bKvIraeVQH0VzmNSzc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a17mqnef10AKciGHHR5JSuXQNByiixRynfjRxYfePgXstnf5j62xHmwYp0FuMLHaNi0UYnHUqp7wi59qyjkKRD6e6S61TYTZBjEEN6pas0vYMsxKq6k5xc2lOtcVU773NavVLANu+jswVm+0yIZF/wWbWrNinefyCbX622yDsek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=EKYVzxSV; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id BFD856000D;
	Fri, 10 Jan 2025 09:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1736502052;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Crjp8Vetc7xjrZ3wfgGkaf3FMlm7IaxngfNvxIPDxio=;
	b=EKYVzxSVcZsdsEg0+2f8leX8dxi/NvYaSMYTLuOT8ZZrVkK3VEZu+29cNyI9YY4MC2PcvO
	kylUVlv1RHUZ4pv7+XshPH18h9bgvvVSQaHuSGcij5cTgsEZb9OQol0gNCTW+8kBrja+Y2
	HNdgSSq33jmqt3dapyAsrBN8Pk9y/dhwBLpVzh6lC2y22KnKBnPwqb26AddL7hnEx30oiB
	2dxzDKK5f15CqnKgYP22UwInj11j533XnSiXjhuaVYjQPmeuP/oZ2vLi7EwqfJ5FNBpg37
	ZjqmYuImCGLTPEyQkRzMaUuG6K1Y7e3xJ14D6WDzoLxjsdg6a4brklIWrwZm7A==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Fri, 10 Jan 2025 10:40:29 +0100
Subject: [PATCH net-next v3 10/12] net: pse-pd: tps23881: Add support for
 power limit and measurement features
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250110-b4-feature_poe_arrange-v3-10-142279aedb94@bootlin.com>
References: <20250110-b4-feature_poe_arrange-v3-0-142279aedb94@bootlin.com>
In-Reply-To: <20250110-b4-feature_poe_arrange-v3-0-142279aedb94@bootlin.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-doc@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>, 
 Dent Project <dentproject@linuxfoundation.org>, kernel@pengutronix.de, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.14.1
X-GND-Sasl: kory.maincent@bootlin.com

Expand PSE callbacks to support the newly introduced
pi_get/set_pw_limit() and pi_get_voltage() functions. These callbacks
allow for power limit configuration in the TPS23881 controller.

Additionally, the patch includes the pi_get_pw_class() the
pi_get_actual_pw(), and the pi_get_pw_limit_ranges') callbacks providing
more comprehensive PoE status reporting.

Acked-by: Oleksij Rempel <o.rempel@pengutronix.de>
Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
 drivers/net/pse-pd/tps23881.c | 258 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 256 insertions(+), 2 deletions(-)

diff --git a/drivers/net/pse-pd/tps23881.c b/drivers/net/pse-pd/tps23881.c
index 340d70ee37fe..5e9dda2c0eac 100644
--- a/drivers/net/pse-pd/tps23881.c
+++ b/drivers/net/pse-pd/tps23881.c
@@ -25,20 +25,32 @@
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
+#define TPS23881_NA_STEP	70190
+#define TPS23881_MW_STEP	500
+#define TPS23881_MIN_PI_PW_LIMIT_MW	2000
+
 struct tps23881_port_desc {
 	u8 chan[2];
 	bool is_4p;
+	int pw_pol;
 };
 
 struct tps23881_priv {
@@ -102,6 +114,54 @@ static u16 tps23881_set_val(u16 reg_val, u8 chan, u8 field_offset,
 	return reg_val;
 }
 
+static int
+tps23881_pi_set_pw_pol_limit(struct tps23881_priv *priv, int id, u8 pw_pol,
+			     bool is_4p)
+{
+	struct i2c_client *client = priv->client;
+	int ret, reg;
+	u16 val;
+	u8 chan;
+
+	chan = priv->port[id].chan[0];
+	if (!is_4p) {
+		reg = TPS23881_REG_2PAIR_POL1 + (chan % 4);
+	} else {
+		/* One chan is enough to configure the 4p PI power limit */
+		if ((chan % 4) < 2)
+			reg = TPS23881_REG_4PAIR_POL1;
+		else
+			reg = TPS23881_REG_4PAIR_POL1 + 1;
+	}
+
+	ret = i2c_smbus_read_word_data(client, reg);
+	if (ret < 0)
+		return ret;
+
+	val = tps23881_set_val(ret, chan, 0, 0xff, pw_pol);
+	return i2c_smbus_write_word_data(client, reg, val);
+}
+
+static int tps23881_pi_enable_manual_pol(struct tps23881_priv *priv, int id)
+{
+	struct i2c_client *client = priv->client;
+	int ret;
+	u8 chan;
+	u16 val;
+
+	ret = i2c_smbus_read_byte_data(client, TPS23881_REG_FOLDBACK);
+	if (ret < 0)
+		return ret;
+
+	/* No need to test if the chan is PoE4 as setting either bit for a
+	 * 4P configured port disables the automatic configuration on both
+	 * channels.
+	 */
+	chan = priv->port[id].chan[0];
+	val = tps23881_set_val(ret, chan, 0, BIT(chan % 4), BIT(chan % 4));
+	return i2c_smbus_write_byte_data(client, TPS23881_REG_FOLDBACK, val);
+}
+
 static int tps23881_pi_enable(struct pse_controller_dev *pcdev, int id)
 {
 	struct tps23881_priv *priv = to_tps23881_priv(pcdev);
@@ -171,7 +231,21 @@ static int tps23881_pi_disable(struct pse_controller_dev *pcdev, int id)
 				       BIT(chan % 4));
 	}
 
-	return i2c_smbus_write_word_data(client, TPS23881_REG_DET_CLA_EN, val);
+	ret = i2c_smbus_write_word_data(client, TPS23881_REG_DET_CLA_EN, val);
+	if (ret)
+		return ret;
+
+	/* No power policy */
+	if (priv->port[id].pw_pol < 0)
+		return 0;
+
+	ret = tps23881_pi_enable_manual_pol(priv, id);
+	if (ret < 0)
+		return ret;
+
+	/* Set power policy */
+	return tps23881_pi_set_pw_pol_limit(priv, id, priv->port[id].pw_pol,
+					    priv->port[id].is_4p);
 }
 
 static int
@@ -246,6 +320,177 @@ tps23881_pi_get_pw_status(struct pse_controller_dev *pcdev, int id,
 	return 0;
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
+	/* Registers 0x30 to 0x3d */
+	reg = TPS23881_REG_CHAN1_A + (chan % 4) * 4 + (chan >= 4);
+	ret = i2c_smbus_read_word_data(client, reg);
+	if (ret < 0)
+		return ret;
+
+	tmp_64 = ret & 0x3fff;
+	tmp_64 *= TPS23881_NA_STEP;
+	/* uA = nA / 1000 */
+	tmp_64 = DIV_ROUND_CLOSEST_ULL(tmp_64, 1000);
+	return (int)tmp_64;
+}
+
+static int tps23881_pi_get_pw_class(struct pse_controller_dev *pcdev,
+				    int id)
+{
+	struct tps23881_priv *priv = to_tps23881_priv(pcdev);
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
+static int
+tps23881_pi_get_actual_pw(struct pse_controller_dev *pcdev, int id)
+{
+	struct tps23881_priv *priv = to_tps23881_priv(pcdev);
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
+static int tps23881_pi_get_pw_limit(struct pse_controller_dev *pcdev, int id)
+{
+	struct tps23881_priv *priv = to_tps23881_priv(pcdev);
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
+static int tps23881_pi_set_pw_limit(struct pse_controller_dev *pcdev,
+				    int id, int max_mW)
+{
+	struct tps23881_priv *priv = to_tps23881_priv(pcdev);
+	u8 pw_pol;
+	int ret;
+
+	if (max_mW < TPS23881_MIN_PI_PW_LIMIT_MW || MAX_PI_PW < max_mW) {
+		dev_err(&priv->client->dev,
+			"power limit %d out of ranges [%d,%d]",
+			max_mW, TPS23881_MIN_PI_PW_LIMIT_MW, MAX_PI_PW);
+		return -ERANGE;
+	}
+
+	ret = tps23881_pi_enable_manual_pol(priv, id);
+	if (ret < 0)
+		return ret;
+
+	pw_pol = DIV_ROUND_CLOSEST_ULL(max_mW, TPS23881_MW_STEP);
+
+	/* Save power policy to reconfigure it after a disabled call */
+	priv->port[id].pw_pol = pw_pol;
+	return tps23881_pi_set_pw_pol_limit(priv, id, pw_pol,
+					    priv->port[id].is_4p);
+}
+
+static int
+tps23881_pi_get_pw_limit_ranges(struct pse_controller_dev *pcdev, int id,
+				struct pse_pw_limit_ranges *pw_limit_ranges)
+{
+	struct ethtool_c33_pse_pw_limit_range *c33_pw_limit_ranges;
+
+	c33_pw_limit_ranges = kzalloc(sizeof(*c33_pw_limit_ranges),
+				      GFP_KERNEL);
+	if (!c33_pw_limit_ranges)
+		return -ENOMEM;
+
+	c33_pw_limit_ranges->min = TPS23881_MIN_PI_PW_LIMIT_MW;
+	c33_pw_limit_ranges->max = MAX_PI_PW;
+	pw_limit_ranges->c33_pw_limit_ranges = c33_pw_limit_ranges;
+
+	/* Return the number of ranges */
+	return 1;
+}
+
 /* Parse managers subnode into a array of device node */
 static int
 tps23881_get_of_channels(struct tps23881_priv *priv,
@@ -540,6 +785,9 @@ tps23881_write_port_matrix(struct tps23881_priv *priv,
 		if (port_matrix[i].exist)
 			priv->port[pi_id].chan[0] = lgcl_chan;
 
+		/* Initialize power policy internal value */
+		priv->port[pi_id].pw_pol = -1;
+
 		/* Set hardware port matrix for all ports */
 		val |= hw_chan << (lgcl_chan * 2);
 
@@ -665,6 +913,12 @@ static const struct pse_controller_ops tps23881_ops = {
 	.pi_disable = tps23881_pi_disable,
 	.pi_get_admin_state = tps23881_pi_get_admin_state,
 	.pi_get_pw_status = tps23881_pi_get_pw_status,
+	.pi_get_pw_class = tps23881_pi_get_pw_class,
+	.pi_get_actual_pw = tps23881_pi_get_actual_pw,
+	.pi_get_voltage = tps23881_pi_get_voltage,
+	.pi_get_pw_limit = tps23881_pi_get_pw_limit,
+	.pi_set_pw_limit = tps23881_pi_set_pw_limit,
+	.pi_get_pw_limit_ranges = tps23881_pi_get_pw_limit_ranges,
 };
 
 static const char fw_parity_name[] = "ti/tps23881/tps23881-parity-14.bin";

-- 
2.34.1



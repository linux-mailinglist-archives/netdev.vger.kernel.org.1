Return-Path: <netdev+bounces-131306-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 039EF98E0B1
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 18:30:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CBBFEB2307C
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 16:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11BE01D1742;
	Wed,  2 Oct 2024 16:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="F9UGxuCI"
X-Original-To: netdev@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609341D0F57;
	Wed,  2 Oct 2024 16:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727886553; cv=none; b=L0qp1F2+0M4zWmXmnTkqcI6iGDdIX5TW62t9uguffxT/DwJZRqv/m0NHhES9KnTo9OSBiPHebDsDqTSfXSuxiPL4pRKSu5rKA/XUmma0Q9Zc3nFGTY5A35/SDUGC96a68rnLiZVAQl0sa8wI9gGGU/JlacerDvJJodKwMmo+250=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727886553; c=relaxed/simple;
	bh=O6dqqwIb8ntWdhD7LBUoy2m5OdXAqUc9w9/iAHs433k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QbgGp93SDDAJ4xkE5MHiWxRBD0vnNDuh+0VH2GKPShf/tExyu9O7S/kxOqqs0MPNm4X/SgWQT3lIend3pKAS2TU+g9E6fuUoLCp2ZnCJeKhEmeVg0DOnpcynjApZWkT0J0B+uh0fN3gcI+WB9kTI3hekF68PHxmKGujZb2ZrqtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=F9UGxuCI; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 35D4D1BF20B;
	Wed,  2 Oct 2024 16:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1727886548;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s5rLJXL+Op3mv3qC1Ju68EqXWIew/9aiRguP/DQDY/M=;
	b=F9UGxuCI/xfLH/VjLKKhYnLrO4qQm1Qsj2mQkH84q/wooPLeYrQzIkcayCuiS6/C/1HpLZ
	ICF+1s3BecAyZ9mf3vMg0FMG7DGrSpHF6PcD2mLW5kH65S/KC4iWe5Pmiva666IzR5fRPu
	XUUkaP0AtFVL4ffjBRxVhFdKmAwTJ1buwomOOMoKAAS02EpsbWeSzMeLMJRaPKb2fG7Id7
	8KrMyvjr4qlr2RGqTFp9Azfp+UvJ62X7RQr95w4i33K1f3o9cbl2LSGoeFatIGR6ylQpYt
	9XlAQgDEeKbcRAJa4D0ArOVTNqJRaPn+dWDfqvF0KwhyTDCg8QrHk0+qdRFQEw==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Wed, 02 Oct 2024 18:28:00 +0200
Subject: [PATCH net-next 04/12] net: pse-pd: tps23881: Add support for
 power limit and measurement features
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241002-feature_poe_port_prio-v1-4-787054f74ed5@bootlin.com>
References: <20241002-feature_poe_port_prio-v1-0-787054f74ed5@bootlin.com>
In-Reply-To: <20241002-feature_poe_port_prio-v1-0-787054f74ed5@bootlin.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Jonathan Corbet <corbet@lwn.net>, Donald Hunter <donald.hunter@gmail.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-doc@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>, 
 Dent Project <dentproject@linuxfoundation.org>, kernel@pengutronix.de, 
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
 drivers/net/pse-pd/tps23881.c | 314 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 314 insertions(+)

diff --git a/drivers/net/pse-pd/tps23881.c b/drivers/net/pse-pd/tps23881.c
index fdf996f5d1f8..e05b45cdc9f8 100644
--- a/drivers/net/pse-pd/tps23881.c
+++ b/drivers/net/pse-pd/tps23881.c
@@ -25,17 +25,29 @@
 #define TPS23881_REG_GEN_MASK	0x17
 #define TPS23881_REG_NBITACC	BIT(5)
 #define TPS23881_REG_PW_EN	0x19
+#define TPS23881_REG_2PAIR_POL1	0x1e
 #define TPS23881_REG_PORT_MAP	0x26
 #define TPS23881_REG_PORT_POWER	0x29
+#define TPS23881_REG_4PAIR_POL1	0x2a
+#define TPS23881_REG_INPUT_V	0x2e
+#define TPS23881_REG_CHAN1_A	0x30
+#define TPS23881_REG_CHAN1_V	0x32
 #define TPS23881_REG_POEPLUS	0x40
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
+
 struct tps23881_port_desc {
 	u8 chan[2];
 	bool is_4p;
@@ -151,6 +163,175 @@ static int tps23881_pi_is_enabled(struct pse_controller_dev *pcdev, int id)
 	return enabled;
 }
 
+static int tps23881_pi_get_voltage(struct pse_controller_dev *pcdev, int id)
+{
+	struct tps23881_priv *priv = to_tps23881_priv(pcdev);
+	struct i2c_client *client = priv->client;
+	int ret, reg;
+	u8 chan;
+	u64 uV;
+
+	/* Read Voltage only at one of the 2-pair ports */
+	chan = priv->port[id].chan[0];
+	if (chan < 4)
+		/* Registers 0x32 0x36 0x3a 0x3e */
+		reg = TPS23881_REG_CHAN1_V + chan * 4;
+	else
+		/* Registers 0x33 0x37 0x3b 0x3f */
+		reg = TPS23881_REG_CHAN1_V + 1 + (chan % 4) * 4;
+
+	ret = i2c_smbus_read_word_data(client, reg);
+	if (ret < 0)
+		return ret;
+
+	uV = ret;
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
+	int ret, reg, mW;
+
+	reg = TPS23881_REG_2PAIR_POL1 + (chan % 4);
+	ret = i2c_smbus_read_word_data(client, reg);
+	if (ret < 0)
+		return ret;
+
+	if (chan < 4)
+		mW = (ret & 0xff) * TPS23881_MW_STEP;
+	else
+		mW = (ret >> 8) * TPS23881_MW_STEP;
+
+	return mW;
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
+static int tps23881_pi_get_max_pw_limit(struct tps23881_priv *priv, int id)
+{
+	int ret, uV;
+	u64 tmp_64;
+
+	ret = tps23881_pi_get_voltage(&priv->pcdev, id);
+	if (ret < 0)
+		return ret;
+	uV = ret;
+
+	tmp_64 = uV;
+	tmp_64 *= MAX_PI_CURRENT;
+	/* mW = uV * uA / 1000000000 */
+	return DIV_ROUND_CLOSEST_ULL(tmp_64, 1000000000);
+}
+
+static int tps23881_pi_get_class(struct tps23881_priv *priv, int id)
+{
+	struct i2c_client *client = priv->client;
+	int ret, reg, class;
+	u8 chan;
+
+	chan = priv->port[id].chan[0];
+	reg = TPS23881_REG_CHAN1_CLASS + (chan % 4);
+	ret = i2c_smbus_read_word_data(client, reg);
+	if (ret < 0)
+		return ret;
+
+	if (chan < 4)
+		class = ret >> 4;
+	else
+		class = ret >> 12;
+
+	return class;
+}
+
 static int tps23881_ethtool_get_status(struct pse_controller_dev *pcdev,
 				       unsigned long id,
 				       struct netlink_ext_ack *extack,
@@ -198,6 +379,35 @@ static int tps23881_ethtool_get_status(struct pse_controller_dev *pcdev,
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
+
+	ret = tps23881_pi_get_max_pw_limit(priv, id);
+	if (ret < 0)
+		return ret;
+	status->c33_pw_limit_nb_ranges = 1;
+	status->c33_pw_limit_ranges->min = 2000;
+	status->c33_pw_limit_ranges->max = ret;
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
 
@@ -614,12 +824,116 @@ static int tps23881_setup_pi_matrix(struct pse_controller_dev *pcdev)
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
+static int
+tps23881_pi_set_2p_pw_limit(struct tps23881_priv *priv, u8 chan, u8 pol)
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
+	if (chan < 4)
+		val = (ret & 0xff00) | pol;
+	else
+		val = (ret & 0xff) | (pol << 8);
+
+	return i2c_smbus_write_word_data(client, reg, val);
+}
+
+static int
+tps23881_pi_set_4p_pw_limit(struct tps23881_priv *priv, u8 chan, u8 pol)
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
+	if (chan < 4)
+		val = (ret & 0xff00) | pol;
+	else
+		val = (ret & 0xff) | (pol << 8);
+
+	return i2c_smbus_write_word_data(client, reg, val);
+}
+
+static int tps23881_pi_set_current_limit(struct pse_controller_dev *pcdev,
+					 int id, int max_uA)
+{
+	struct tps23881_priv *priv = to_tps23881_priv(pcdev);
+	u8 chan, pw_pol;
+	int ret, mW;
+	u64 tmp_64;
+
+	ret = tps23881_pi_get_voltage(pcdev, id);
+	if (ret < 0)
+		return ret;
+
+	tmp_64 = ret;
+	tmp_64 *= max_uA;
+	/* mW = uV * uA / 1000000000 */
+	mW = DIV_ROUND_CLOSEST_ULL(tmp_64, 1000000000);
+	pw_pol = DIV_ROUND_CLOSEST_ULL(mW, TPS23881_MW_STEP);
+
+	if (priv->port[id].is_4p) {
+		chan = priv->port[id].chan[0];
+		/* One chan is enough to configure the PI power limit */
+		ret = tps23881_pi_set_4p_pw_limit(priv, chan, pw_pol);
+		if (ret < 0)
+			return ret;
+	} else {
+		chan = priv->port[id].chan[0];
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



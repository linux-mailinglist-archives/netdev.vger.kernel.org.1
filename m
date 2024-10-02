Return-Path: <netdev+bounces-131314-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 612F398E0C9
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 18:32:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0B761F21F63
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 16:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D54A81D2B32;
	Wed,  2 Oct 2024 16:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Q5k3kQxz"
X-Original-To: netdev@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC421D0E34;
	Wed,  2 Oct 2024 16:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727886558; cv=none; b=qv0GQ/k56y/4IsBk6Yp5BsKwVandzPbbq8tuL7c+EdQzATkLpA96HL8/HOsoE6flFqqwAN627RiseIs1ZZ9zqBSQtP/QiZ0zWTfQqtLegkaG2fP+kOs0YcVvcm7OiUNqSy09/W1mo5NZyO30JlsLXFDwP+uiPVN+jgcPuQCr7U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727886558; c=relaxed/simple;
	bh=lie+v4+aHAQjNO+R6PY+GE+xML+J1xWgPW0F7Qo/Yjk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OcDFQCmFTXCw82gbz4md6MhYRx0TEACxI5MSRdEHVkk+l917XboYW1AW3K/VJIX3wXTCIVoajRWJkLV0yHCy/vKFb2ZwH4ybmUvCpsxHU/0jPwxtJCr+pHkkh/7graW1701SwQHgQHx5n0vyjA0PsdvaIlKoRVtCxrktjk8UECU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Q5k3kQxz; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1D3B11BF203;
	Wed,  2 Oct 2024 16:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1727886554;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zg8or6L5eyzMH1TuklarP5kBCWGDZKKVNBcBHI7D8X4=;
	b=Q5k3kQxzsrX0DhSS0BNxLp/hw+twTNjflYLsWGPXUb8+aWaj1qsT9N6rtx4+o6JXg8gX4y
	ybRwg5i8CK49Fa3EHED4K7YtVdZxKfOfDi7Eid286okAaVXBnT8tskucWGHGsHYOSYdbBL
	j974Nb15SYb6W9LorYNC5CVt7ly3cQ9BNtz4KqKYmy2PkiiksA+YVmVN2isQFWtPOZEYk5
	G1hVpfozz9Hp1Nc+oGgMShGPSdjONi/X7JTM52qADNdXW0tCNg8gx9H9g+RgPbYzasAv/X
	kVWkuP5m9oZPdTYNRm4A7AODdpzTD0/uOrR/e4acIHd7FBTRmiuji0+Z3Rg8dg==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Wed, 02 Oct 2024 18:28:08 +0200
Subject: [PATCH net-next 12/12] net: pse-pd: tps23881: Add support for PSE
 events and interrupts
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241002-feature_poe_port_prio-v1-12-787054f74ed5@bootlin.com>
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

Add support for PSE event reporting through interrupts. Set up the newly
introduced devm_pse_irq_helper helper to register the interrupt. Events are
reported for over-current and over-temperature conditions.

This patch also adds support for an OSS GPIO line to turn off all low
priority ports in case of an over-current event.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
 drivers/net/pse-pd/tps23881.c | 123 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 122 insertions(+), 1 deletion(-)

diff --git a/drivers/net/pse-pd/tps23881.c b/drivers/net/pse-pd/tps23881.c
index ddb44a17218a..03f36b641bb4 100644
--- a/drivers/net/pse-pd/tps23881.c
+++ b/drivers/net/pse-pd/tps23881.c
@@ -17,6 +17,13 @@
 
 #define TPS23881_MAX_CHANS 8
 
+#define TPS23881_REG_IT		0x0
+#define TPS23881_REG_IT_MASK	0x1
+#define TPS23881_REG_IT_IFAULT	BIT(5)
+#define TPS23881_REG_IT_SUPF	BIT(7)
+#define TPS23881_REG_FAULT	0x7
+#define TPS23881_REG_SUPF_EVENT	0xb
+#define TPS23881_REG_TSD	BIT(7)
 #define TPS23881_REG_PW_STATUS	0x10
 #define TPS23881_REG_OP_MODE	0x12
 #define TPS23881_OP_MODE_SEMIAUTO	0xaaaa
@@ -25,6 +32,7 @@
 #define TPS23881_REG_PW_PRIO	0x15
 #define TPS23881_REG_GEN_MASK	0x17
 #define TPS23881_REG_NBITACC	BIT(5)
+#define TPS23881_REG_INTEN	BIT(7)
 #define TPS23881_REG_PW_EN	0x19
 #define TPS23881_REG_2PAIR_POL1	0x1e
 #define TPS23881_REG_PORT_MAP	0x26
@@ -59,6 +67,7 @@ struct tps23881_priv {
 	struct pse_controller_dev pcdev;
 	struct device_node *np;
 	struct tps23881_port_desc port[TPS23881_MAX_CHANS];
+	struct gpio_desc *oss;
 };
 
 static struct tps23881_priv *to_tps23881_priv(struct pse_controller_dev *pcdev)
@@ -1088,11 +1097,112 @@ static int tps23881_flash_sram_fw(struct i2c_client *client)
 	return 0;
 }
 
+static void tps23881_turn_off_low_prio(struct tps23881_priv *priv)
+{
+	dev_info(&priv->client->dev,
+		 "turn off low priority ports due to over current event.\n");
+	gpiod_set_value_cansleep(priv->oss, 1);
+
+	/* TPS23880 datasheet (Rev G) indicates minimum OSS pulse is 5us */
+	usleep_range(5, 10);
+	gpiod_set_value_cansleep(priv->oss, 0);
+}
+
+static int tps23881_irq_handler(int irq, struct pse_irq_data *pid,
+				unsigned long *dev_mask)
+{
+	struct tps23881_priv *priv = (struct tps23881_priv *)pid->data;
+	struct i2c_client *client = priv->client;
+	struct pse_err_state *stat;
+	int ret, i;
+	u16 val;
+
+	*dev_mask = 0;
+	for (i = 0; i < TPS23881_MAX_CHANS; i++) {
+		stat = &pid->states[i];
+		stat->notifs = 0;
+		stat->errors = 0;
+	}
+
+	ret = i2c_smbus_read_word_data(client, TPS23881_REG_IT);
+	if (ret < 0)
+		return PSE_FAILED_RETRY;
+
+	val = (u16)ret;
+	if (val & TPS23881_REG_IT_SUPF) {
+		ret = i2c_smbus_read_word_data(client, TPS23881_REG_SUPF_EVENT);
+		if (ret < 0)
+			return PSE_FAILED_RETRY;
+
+		if (ret & TPS23881_REG_TSD) {
+			for (i = 0; i < TPS23881_MAX_CHANS; i++) {
+				stat = &pid->states[i];
+				*dev_mask |= 1 << i;
+				stat->notifs = PSE_EVENT_OVER_TEMP;
+				stat->errors = PSE_ERROR_OVER_TEMP;
+			}
+		}
+	}
+
+	if (val & (TPS23881_REG_IT_IFAULT | TPS23881_REG_IT_IFAULT << 8)) {
+		ret = i2c_smbus_read_word_data(client, TPS23881_REG_FAULT);
+		if (ret < 0)
+			return PSE_FAILED_RETRY;
+
+		val = (u16)(ret & 0xf0f);
+
+		/* Power cut detected, shutdown low priority port */
+		if (val && priv->oss)
+			tps23881_turn_off_low_prio(priv);
+
+		*dev_mask |= val;
+		for (i = 0; i < TPS23881_MAX_CHANS; i++) {
+			if (val & BIT(i)) {
+				stat = &pid->states[i];
+				stat->notifs = PSE_EVENT_OVER_CURRENT;
+				stat->errors = PSE_ERROR_OVER_CURRENT;
+			}
+		}
+	}
+
+	return PSE_ERROR_CLEARED;
+}
+
+static int tps23881_setup_irq(struct tps23881_priv *priv, int irq)
+{
+	int errs = PSE_ERROR_OVER_CURRENT | PSE_ERROR_OVER_TEMP;
+	struct i2c_client *client = priv->client;
+	struct pse_irq_desc irq_desc = {
+		.name = "tps23881-irq",
+		.map_event = tps23881_irq_handler,
+		.data = priv,
+	};
+	int ret;
+	u16 val;
+
+	val = TPS23881_REG_IT_IFAULT | TPS23881_REG_IT_SUPF |
+	      TPS23881_REG_IT_IFAULT << 8 | TPS23881_REG_IT_SUPF << 8;
+	ret = i2c_smbus_write_word_data(client, TPS23881_REG_IT_MASK, val);
+	if (ret)
+		return ret;
+
+	ret = i2c_smbus_read_word_data(client, TPS23881_REG_GEN_MASK);
+	if (ret < 0)
+		return ret;
+
+	val = (u16)(ret | TPS23881_REG_INTEN | TPS23881_REG_INTEN << 8);
+	ret = i2c_smbus_write_word_data(client, TPS23881_REG_GEN_MASK, val);
+	if (ret < 0)
+		return ret;
+
+	return devm_pse_irq_helper(&priv->pcdev, irq, 0, errs, &irq_desc);
+}
+
 static int tps23881_i2c_probe(struct i2c_client *client)
 {
 	struct device *dev = &client->dev;
 	struct tps23881_priv *priv;
-	struct gpio_desc *reset;
+	struct gpio_desc *reset, *oss;
 	int ret;
 	u8 val;
 
@@ -1169,6 +1279,17 @@ static int tps23881_i2c_probe(struct i2c_client *client)
 				     "failed to register PSE controller\n");
 	}
 
+	oss = devm_gpiod_get_optional(dev, "oss", GPIOD_OUT_LOW);
+	if (IS_ERR(oss))
+		return dev_err_probe(&client->dev, PTR_ERR(oss), "Failed to get OSS GPIO\n");
+	priv->oss = oss;
+
+	if (client->irq) {
+		ret = tps23881_setup_irq(priv, client->irq);
+		if (ret)
+			return ret;
+	}
+
 	return ret;
 }
 

-- 
2.34.1



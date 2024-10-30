Return-Path: <netdev+bounces-140483-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D7B79B69E2
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 17:59:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6EDC1F22813
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 16:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 401EB228057;
	Wed, 30 Oct 2024 16:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="B/eP4cyZ"
X-Original-To: netdev@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF77221BB0A;
	Wed, 30 Oct 2024 16:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730307250; cv=none; b=oK0yDHSgSDrjkoOtrQjT5T1/W0ZqRWqOAAIogAs4a5kowSZyGcTlLJXHTpbnN7r8ZNKl9buPbEtIjbBuHRqlQ8go+w198/1pxBwq75Q9MAE87A+oPGl9L0AYz9fqfFQln+j3k4E4eVcNKaYNcLdmEB8X8Mzx0oMG2u9CpO8vGII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730307250; c=relaxed/simple;
	bh=pgngeL1kRve3sqgMsMP9B0SyqIQZzJSt8f6LKb/qKpM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GF6f2rR30OXcuSiTr4jat544DTrOVFI0A4CWHiUhDBdkiFbWkPD17XEYgOHKhyvcEwyqUKSX0NP0XWGtcJJU/rAeBhnaEnhz9K4fI1uCC2f358GsBK9GEJqI589t5ucRNnzOjUaN85hCrtu2BRMqh32oinnyLNQ+nDHgGynByr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=B/eP4cyZ; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 34B12C0014;
	Wed, 30 Oct 2024 16:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1730307245;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QxWo1fsyB4vJFRjc+GJjnsHl3xaRDNnxkxepOa554E4=;
	b=B/eP4cyZSRc5tV9OSXiF7D4Ck/5sJR2OtfsgiX5SKZzov1IEEwcKsl2fssp4cHqbRFu3Wi
	G7fEcgOIVrqtDF8klRdxfA8e/QX1eyJwv3niC6Kqa1Ok80hLEzZxMH3QvTXo1GGKBMI/OW
	hyXkbw4SFqowfzca6qiM5lf55XlPB7GpEyaY//Y/PlHk9QpV0jhAhmyvtujoYhUh2LDfWB
	UJ+UykR7ZWnAYmSJ5Op48OoNo5k9x0Ci57AKsbMlc1oUy7tZHKnykY/4XKgg+17zCKT2xV
	TXuoDPjNnltPonuf3QVUlVCUvaZsb39Dqqo4UtqkazJ5Y3IZcWsOy8rh4GyM6A==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Wed, 30 Oct 2024 17:53:12 +0100
Subject: [PATCH RFC net-next v2 10/18] net: pse-pd: tps23881: Add support
 for PSE events and interrupts
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241030-feature_poe_port_prio-v2-10-9559622ee47a@bootlin.com>
References: <20241030-feature_poe_port_prio-v2-0-9559622ee47a@bootlin.com>
In-Reply-To: <20241030-feature_poe_port_prio-v2-0-9559622ee47a@bootlin.com>
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

Add support for PSE event reporting through interrupts. Set up the newly
introduced devm_pse_irq_helper helper to register the interrupt. Events are
reported for over-current and over-temperature conditions.

Reviewed-by: Kyle Swenson <kyle.swenson@est.tech>
Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

Change in v2:
- Remove support for OSS pin and TPC23881 specific port priority management
---
 drivers/net/pse-pd/tps23881.c | 90 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 90 insertions(+)

diff --git a/drivers/net/pse-pd/tps23881.c b/drivers/net/pse-pd/tps23881.c
index 928d9844462c..3e15e2c97b24 100644
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
@@ -24,6 +31,7 @@
 #define TPS23881_REG_DET_CLA_EN	0x14
 #define TPS23881_REG_GEN_MASK	0x17
 #define TPS23881_REG_NBITACC	BIT(5)
+#define TPS23881_REG_INTEN	BIT(7)
 #define TPS23881_REG_PW_EN	0x19
 #define TPS23881_REG_2PAIR_POL1	0x1e
 #define TPS23881_REG_PORT_MAP	0x26
@@ -1055,6 +1063,82 @@ static int tps23881_flash_sram_fw(struct i2c_client *client)
 	return 0;
 }
 
+static int tps23881_irq_handler(int irq, struct pse_controller_dev *pcdev,
+				unsigned long *notifs,
+				unsigned long *notifs_mask)
+{
+	struct tps23881_priv *priv = to_tps23881_priv(pcdev);
+	struct i2c_client *client = priv->client;
+	int ret, i;
+	u16 val;
+
+	ret = i2c_smbus_read_word_data(client, TPS23881_REG_IT);
+	if (ret < 0)
+		return ret;
+
+	val = (u16)ret;
+	/* The Supply event bit is repeated twice so we only need to read
+	 * the one from the first byte.
+	 */
+	if (val & TPS23881_REG_IT_SUPF) {
+		ret = i2c_smbus_read_word_data(client, TPS23881_REG_SUPF_EVENT);
+		if (ret < 0)
+			return ret;
+
+		if (ret & TPS23881_REG_TSD) {
+			for (i = 0; i < TPS23881_MAX_CHANS; i++) {
+				*notifs_mask |= 1 << i;
+				notifs[i] = ETHTOOL_C33_PSE_EVENT_OVER_TEMP;
+			}
+		}
+	}
+
+	if (val & (TPS23881_REG_IT_IFAULT | TPS23881_REG_IT_IFAULT << 8)) {
+		ret = i2c_smbus_read_word_data(client, TPS23881_REG_FAULT);
+		if (ret < 0)
+			return ret;
+
+		/* Convert interrupt events located in 0xf0f to 0xff be
+		 * aligned with the port number.
+		 */
+		val = (u16)(((ret >> 4) & 0xf0) | (ret & 0x0f));
+
+		*notifs_mask |= val;
+		for_each_set_bit(i, notifs_mask, TPS23881_MAX_CHANS)
+			notifs[i] = ETHTOOL_C33_PSE_EVENT_OVER_CURRENT;
+	}
+
+	return 0;
+}
+
+static int tps23881_setup_irq(struct tps23881_priv *priv, int irq)
+{
+	struct i2c_client *client = priv->client;
+	struct pse_irq_desc irq_desc = {
+		.name = "tps23881-irq",
+		.map_event = tps23881_irq_handler,
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
+	return devm_pse_irq_helper(&priv->pcdev, irq, 0, &irq_desc);
+}
+
 static int tps23881_i2c_probe(struct i2c_client *client)
 {
 	struct device *dev = &client->dev;
@@ -1135,6 +1219,12 @@ static int tps23881_i2c_probe(struct i2c_client *client)
 				     "failed to register PSE controller\n");
 	}
 
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



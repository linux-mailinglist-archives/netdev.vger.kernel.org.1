Return-Path: <netdev+bounces-146666-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A2B9D4EFC
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 15:48:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B33A7281E4F
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 14:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 891C91DFE03;
	Thu, 21 Nov 2024 14:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="egn34iF4"
X-Original-To: netdev@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3241DFD82;
	Thu, 21 Nov 2024 14:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732200245; cv=none; b=cM2iKEN3G6fOqp4Nv0ol4CPvD0CCeltYx8SG7R3GRlG4EVmTTrqIGRaXedT07PnLCnjyw9hMIOIKVNnn2qerm/mXjPOEjgugWZD39HGPYqxQhVIqB8eRhqMsBYv8EFcoSVRtacfyhS+oqK6chRw88pYBuWhhkqOWnI29GuQwjOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732200245; c=relaxed/simple;
	bh=QfqHP8jQ3HE57WJ53GO2+IxI/8dWMrI4Z5hUUWqWUFA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LU1019CDIYqZqTLkKTkrUst3n2CD87hJPr2AvRH+A+oUwP61uZVqy+elL7Nx9+go/kMwYqkKz/0H+tBQm6FfgR9CcOv4LSiA8d6Rjav+P2tKnomyr/GBYorLzr18SGnTDXv002q9aNqi2F/dehB70za417D0CtjgtJ26DWcVGv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=egn34iF4; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D8F1740006;
	Thu, 21 Nov 2024 14:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1732200241;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MRiOopLuCYf+dwOYK9bRpViinqwBSZssZX1G6ZdiUGg=;
	b=egn34iF4U5Ktiu8MZiJJRYipnbX7sbjp7BajncIw7eluYuQkvQjtUNu8OJgpsd+9Hk0EY8
	gt6UJhGFzBbxboasTsOrwp/Fh6C1B0BbX07Z3ckJllgevFL/maJ2E7zRF1i/71cwOWw9Yb
	9R+tFqsOoIXONy4cvycFlvomvMLiLQLheRsHPNJyhdYrpZxLQBPmkqfGJL7afgETEqc2+4
	hdnmJ6oA/oRe2P4KOMsVRHjh2kq/3CPMvmy44Nr9DMFF5qW4vfqhuPACuNHA8y6CRcRxlM
	gITg94d6gan4DLpCX47UMQMfj3/L3WL9vYLhsdB780jZuLD8XM7gqpVHg8DF2A==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Thu, 21 Nov 2024 15:42:40 +0100
Subject: [PATCH RFC net-next v3 14/27] net: pse-pd: tps23881: Add support
 for PSE events and interrupts
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241121-feature_poe_port_prio-v3-14-83299fa6967c@bootlin.com>
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

Add support for PSE event reporting through interrupts. Set up the newly
introduced devm_pse_irq_helper helper to register the interrupt. Events are
reported for over-current and over-temperature conditions.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

Change in v3:
- Loop over interruption register to be sure the interruption pin is
  freed before exiting the interrupt handler function.
- Add exist variable to not report event for undescribed PIs.
- Used helpers to convert the chan number to the PI port number.

Change in v2:
- Remove support for OSS pin and TPC23881 specific port priority management
---
 drivers/net/pse-pd/tps23881.c | 178 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 177 insertions(+), 1 deletion(-)

diff --git a/drivers/net/pse-pd/tps23881.c b/drivers/net/pse-pd/tps23881.c
index b25561f95774..6fe8f150231f 100644
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
@@ -53,6 +61,7 @@ struct tps23881_port_desc {
 	u8 chan[2];
 	bool is_4p;
 	int pw_pol;
+	bool exist;
 };
 
 struct tps23881_priv {
@@ -791,8 +800,10 @@ tps23881_write_port_matrix(struct tps23881_priv *priv,
 		hw_chan = port_matrix[i].hw_chan[0] % 4;
 
 		/* Set software port matrix for existing ports */
-		if (port_matrix[i].exist)
+		if (port_matrix[i].exist) {
 			priv->port[pi_id].chan[0] = lgcl_chan;
+			priv->port[pi_id].exist = true;
+		}
 
 		/* Initialize power policy internal value */
 		priv->port[pi_id].pw_pol = -1;
@@ -1098,6 +1109,165 @@ static int tps23881_flash_sram_fw(struct i2c_client *client)
 	return 0;
 }
 
+/* Convert interrupt events to 0xff to be aligned with the chan
+ * number.
+ */
+static u8 tps23881_it_export_chans_helper(u16 reg_val, u8 field_offset)
+{
+	u8 val;
+
+	val = (reg_val >> (4 + field_offset) & 0xf0) |
+	      (reg_val >> field_offset & 0x0f);
+
+	return val;
+}
+
+/* Convert chan number to port number */
+static void tps23881_set_notifs_helper(struct tps23881_priv *priv,
+				       u8 chans,
+				       unsigned long *notifs,
+				       unsigned long *notifs_mask,
+				       enum ethtool_pse_events event)
+{
+	u8 chan;
+	int i;
+
+	if (!chans)
+		return;
+
+	for (i = 0; i < TPS23881_MAX_CHANS; i++) {
+		if (!priv->port[i].exist)
+			continue;
+		/* No need to look at the 2nd channel in case of PoE4 as
+		 * both registers are set.
+		 */
+		chan = priv->port[i].chan[0];
+
+		if (BIT(chan) & chans) {
+			*notifs_mask |= BIT(i);
+			notifs[i] |= event;
+		}
+	}
+}
+
+static void tps23881_irq_event_over_temp(struct tps23881_priv *priv,
+					 u16 reg_val,
+					 unsigned long *notifs,
+					 unsigned long *notifs_mask)
+{
+	int i;
+
+	if (reg_val & TPS23881_REG_TSD) {
+		for (i = 0; i < TPS23881_MAX_CHANS; i++) {
+			if (!priv->port[i].exist)
+				continue;
+
+			*notifs_mask |= BIT(i);
+			notifs[i] |= ETHTOOL_PSE_EVENT_OVER_TEMP;
+		}
+	}
+}
+
+static void tps23881_irq_event_over_current(struct tps23881_priv *priv,
+					    u16 reg_val,
+					    unsigned long *notifs,
+					    unsigned long *notifs_mask)
+{
+	u8 chans;
+
+	chans = tps23881_it_export_chans_helper(reg_val, 0);
+	if (chans)
+		tps23881_set_notifs_helper(priv, chans, notifs, notifs_mask,
+					   ETHTOOL_PSE_EVENT_OVER_CURRENT);
+}
+
+static int tps23881_irq_event_handler(struct tps23881_priv *priv, u16 reg,
+				      unsigned long *notifs,
+				      unsigned long *notifs_mask)
+{
+	struct i2c_client *client = priv->client;
+	int ret;
+
+	/* The Supply event bit is repeated twice so we only need to read
+	 * the one from the first byte.
+	 */
+	if (reg & TPS23881_REG_IT_SUPF) {
+		ret = i2c_smbus_read_word_data(client, TPS23881_REG_SUPF_EVENT);
+		if (ret < 0)
+			return ret;
+		tps23881_irq_event_over_temp(priv, ret, notifs, notifs_mask);
+	}
+
+	if (reg & (TPS23881_REG_IT_IFAULT | TPS23881_REG_IT_IFAULT << 8)) {
+		ret = i2c_smbus_read_word_data(client, TPS23881_REG_FAULT);
+		if (ret < 0)
+			return ret;
+		tps23881_irq_event_over_current(priv, ret, notifs, notifs_mask);
+	}
+
+	return 0;
+}
+
+static int tps23881_irq_handler(int irq, struct pse_controller_dev *pcdev,
+				unsigned long *notifs,
+				unsigned long *notifs_mask)
+{
+	struct tps23881_priv *priv = to_tps23881_priv(pcdev);
+	struct i2c_client *client = priv->client;
+	int ret, it_mask;
+
+	/* Get interruption mask */
+	ret = i2c_smbus_read_word_data(client, TPS23881_REG_IT_MASK);
+	if (ret < 0)
+		return ret;
+	it_mask = ret;
+
+	/* Read interrupt register until it frees the interruption pin. */
+	while (true) {
+		ret = i2c_smbus_read_word_data(client, TPS23881_REG_IT);
+		if (ret < 0)
+			return ret;
+
+		/* No more relevant interruption */
+		if (!(ret & it_mask))
+			return 0;
+
+		ret = tps23881_irq_event_handler(priv, (u16)ret, notifs,
+						 notifs_mask);
+		if (ret)
+			return ret;
+	}
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
+	val = TPS23881_REG_IT_IFAULT | TPS23881_REG_IT_SUPF;
+	val |= val << 8;
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
@@ -1178,6 +1348,12 @@ static int tps23881_i2c_probe(struct i2c_client *client)
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



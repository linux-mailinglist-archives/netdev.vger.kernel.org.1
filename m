Return-Path: <netdev+bounces-171563-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEC7FA4DA17
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 11:21:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6C7A3A90CD
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 10:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F7371FF1D9;
	Tue,  4 Mar 2025 10:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ckPQ3EDn"
X-Original-To: netdev@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992051FC107;
	Tue,  4 Mar 2025 10:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741083648; cv=none; b=o5zd35rBrJFtjAKHvML2IMeTMsRlSEA5jRhLjQn5VWfEPEVRwUhNisLt0GcIgnCnz5R2zyC13xBE35vd9UIj0xusKDN0fxqK0PS5Hml29Z4X9BvNrjjoBB8OZ120+2zpf/JLvq43CG+HDzrQhYO9SD7Y16+yZXWJUt7CLfRf3Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741083648; c=relaxed/simple;
	bh=1UfyHCwYphGAP1ni7IxzGtwqfYTFvPRRDii1jM7Kje8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lnYaOp/u7kkTvRbWNuDiXIbv0X4m9Ln6C0m5q02DXMOQyGmyILTJJbzi3l4Hs5eMgA/Rv6xptB6ouiLo1IgQ74+cCWL+N1hxxm9j2Hq9oHSgg9OTYXFF/hm7iUlt0VxmIDsIXP/vvyItFVB5sUOWELYz/FxSYvTX6/7X9RBcQDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ckPQ3EDn; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B973D432BC;
	Tue,  4 Mar 2025 10:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1741083644;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I+IR/EUFFn44uz8yBvIwrvhs6+0W0jOSwoxjqvZa9Hw=;
	b=ckPQ3EDnZ5jaXlCdrRvKHUjg0YmkjcH4ZIqMVAmZjxhpFgJbimPdL4fYsuFrFV88UBn1ly
	tARaO4dmLXjeqra94jV6b+SIYGkDAs2+FL4b2KabUi0vdov17m6LwOnnhVjW6FuLLAWoWy
	tnxfuFVBITKTzfAbsDRVyxBk9INPruARIZHUKSeZ8bnkIuGTGmaF7h64ln2XTeeAsspeiU
	iQjd7lYqybQcpSOHgi/sSscY5crsOz/wvLwR4LYsOD+ggRDI1/ucOlWgk4LbBVIJb0hIJu
	rERIA+32ck8NrFTVz+5tUwCaG7T2ELl30RUFbbEI99aI3BsjsCLiJrnHEypWIQ==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Tue, 04 Mar 2025 11:18:52 +0100
Subject: [PATCH net-next v6 03/12] net: pse-pd: tps23881: Add support for
 PSE events and interrupts
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250304-feature_poe_port_prio-v6-3-3dc0c5ebaf32@bootlin.com>
References: <20250304-feature_poe_port_prio-v6-0-3dc0c5ebaf32@bootlin.com>
In-Reply-To: <20250304-feature_poe_port_prio-v6-0-3dc0c5ebaf32@bootlin.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutddujeekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomhepmfhorhihucforghinhgtvghnthcuoehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeevgfdvgfektefgfefggeekudfggffhtdfffedtueetheejtddvledvvdelhedtveenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplgduvdejrddtrddurddungdpmhgrihhlfhhrohhmpehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvjedprhgtphhtthhopehthhhomhgrshdrphgvthgriiiiohhnihessghoohhtlhhinhdrtghomhdprhgtphhtthhopehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmpdhrtghpthhtoheptghorhgsvghtsehlfihnrdhnvghtpdhrtghpthhtoheplhhgihhrugifohhougesghhmrghilhdrtghomhdprhgtphhtthhopeguvghnthhprhhojhgvtghtsehlihhnuhigf
 hhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohepkhhriihkodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgvrhhnvghlsehpvghnghhuthhrohhnihigrdguvgdprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthh
X-GND-Sasl: kory.maincent@bootlin.com

From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>

Add support for PSE event reporting through interrupts. Set up the newly
introduced devm_pse_irq_helper helper to register the interrupt. Events are
reported for over-current and over-temperature conditions.

Reviewed-by: Oleksij Rempel <o.rempel@pengutronix.de>
Signed-off-by: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
---

Change in v4:
- Small rename of a function.

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
index 5e9dda2c0eac7..1226667192977 100644
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
@@ -51,6 +59,7 @@ struct tps23881_port_desc {
 	u8 chan[2];
 	bool is_4p;
 	int pw_pol;
+	bool exist;
 };
 
 struct tps23881_priv {
@@ -782,8 +791,10 @@ tps23881_write_port_matrix(struct tps23881_priv *priv,
 		hw_chan = port_matrix[i].hw_chan[0] % 4;
 
 		/* Set software port matrix for existing ports */
-		if (port_matrix[i].exist)
+		if (port_matrix[i].exist) {
 			priv->port[pi_id].chan[0] = lgcl_chan;
+			priv->port[pi_id].exist = true;
+		}
 
 		/* Initialize power policy internal value */
 		priv->port[pi_id].pw_pol = -1;
@@ -1017,6 +1028,165 @@ static int tps23881_flash_sram_fw(struct i2c_client *client)
 	return 0;
 }
 
+/* Convert interrupt events to 0xff to be aligned with the chan
+ * number.
+ */
+static u8 tps23881_irq_export_chans_helper(u16 reg_val, u8 field_offset)
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
+	chans = tps23881_irq_export_chans_helper(reg_val, 0);
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
@@ -1097,6 +1267,12 @@ static int tps23881_i2c_probe(struct i2c_client *client)
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



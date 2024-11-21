Return-Path: <netdev+bounces-146658-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2821F9D4EE5
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 15:46:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A281A1F215BF
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 14:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D01F21DE88A;
	Thu, 21 Nov 2024 14:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="M4i6De0U"
X-Original-To: netdev@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142491DE3AB;
	Thu, 21 Nov 2024 14:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732200228; cv=none; b=tiFLjpBPIXz3e2Y5PvFMPxi9s3vlPV6hECAfd8lQd+be8ckDVQJb18O9hw68J91pgpbUz2RDB84x0Vg49LVFGkFqhc9SrrKhktyMs77KhAudQX1w1cZmFg75zdsJ08v3M0TOs6P7zi6zronp50/GWqEjpkXJ4H452GoZMHP0QJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732200228; c=relaxed/simple;
	bh=ffDIfIKozJdI36XtPpaxP40wvqXasjwC2BubHWmTuu8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u00IIbLskWWKSriNWwTK9H3NkRNf+q8bktUwAQRtEG/uxrYtw1wjEAh6AqsYzTiMSsmHfERKwLHAJZcRPHz0FvxE/jq3FWmcM9WsZs1EAK+JHUVky9ZBv7CxldWDBtlByaLbj+qBZuCQHwGQ4Am4Pt2ttwHXTIEi4M6+eypzbn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=M4i6De0U; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6179440009;
	Thu, 21 Nov 2024 14:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1732200224;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FThTH0Mg3xvhRUwUt4xppHY86DV1YRmcuOvIlQciNKQ=;
	b=M4i6De0U36ljagcarLtkQ2bJvJDR7XwiuOdelooC8eCbRHxR1SflLUYP1+Dzgua6WdhrKz
	gESOYPHRlnPAgurN1t1/ATYloqKY3fUxRDSQOzpTpH9Cjtu2qQSrcKOzv+PYCMONb0K0R6
	Z38gtxB4A/QNt+0BqsinI5vNV56q1jUfPKH4FHivh+TjRh59GMwUHIN9nb7cYqEBm/qEXd
	Zaera19EDGiuWNDYNVtra3BWNhliLO0aS1lGvVdFIaI5O+ZPx53BHRp403mlPoSya1yIBO
	DDi/tvMyz8MSipF6IJjk99+HsWyi/w8htzuXdx0shFYsmninOQsyIsc8xLZZ+g==
From: "Kory Maincent (Dent Project)" <kory.maincent@bootlin.com>
Date: Thu, 21 Nov 2024 15:42:32 +0100
Subject: [PATCH RFC net-next v3 06/27] net: pse-pd: tps23881: Use helpers
 to calculate bit offset for a channel
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241121-feature_poe_port_prio-v3-6-83299fa6967c@bootlin.com>
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

This driver frequently follows a pattern where two registers are read or
written in a single operation, followed by calculating the bit offset for
a specific channel.

Introduce helpers to streamline this process and reduce code redundancy,
making the codebase cleaner and more maintainable.

Acked-by: Oleksij Rempel <o.rempel@pengutronix.de>
Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

Thanks to Oleksij for the design of the helpers functions.

Change in v3:
- Small fix: use chan >= 4 instead of chan > 4;

Change in v2:
- New patch
---
 drivers/net/pse-pd/tps23881.c | 107 +++++++++++++++++++++++++++---------------
 1 file changed, 69 insertions(+), 38 deletions(-)

diff --git a/drivers/net/pse-pd/tps23881.c b/drivers/net/pse-pd/tps23881.c
index 20eab9857817..6fd76ecb2961 100644
--- a/drivers/net/pse-pd/tps23881.c
+++ b/drivers/net/pse-pd/tps23881.c
@@ -53,6 +53,55 @@ static struct tps23881_priv *to_tps23881_priv(struct pse_controller_dev *pcdev)
 	return container_of(pcdev, struct tps23881_priv, pcdev);
 }
 
+/*
+ * Helper to extract a value from a u16 register value, which is made of two
+ * u8 registers. The function calculates the bit offset based on the channel
+ * and extracts the relevant bits using a provided field mask.
+ *
+ * @param reg_val: The u16 register value (composed of two u8 registers).
+ * @param chan: The channel number (0-7).
+ * @param field_offset: The base bit offset to apply (e.g., 0 or 4).
+ * @param field_mask: The mask to apply to extract the required bits.
+ * @return: The extracted value for the specific channel.
+ */
+static u16 tps23881_calc_val(u16 reg_val, u8 chan, u8 field_offset,
+			     u16 field_mask)
+{
+	if (chan >= 4)
+		reg_val >>= 8;
+
+	return (reg_val >> field_offset) & field_mask;
+}
+
+/*
+ * Helper to combine individual channel values into a u16 register value.
+ * The function sets the value for a specific channel in the appropriate
+ * position.
+ *
+ * @param reg_val: The current u16 register value.
+ * @param chan: The channel number (0-7).
+ * @param field_offset: The base bit offset to apply (e.g., 0 or 4).
+ * @param field_mask: The mask to apply for the field (e.g., 0x0F).
+ * @param field_val: The value to set for the specific channel (masked by
+ *                   field_mask).
+ * @return: The updated u16 register value with the channel value set.
+ */
+static u16 tps23881_set_val(u16 reg_val, u8 chan, u8 field_offset,
+			    u16 field_mask, u16 field_val)
+{
+	field_val &= field_mask;
+
+	if (chan < 4) {
+		reg_val &= ~(field_mask << field_offset);
+		reg_val |= (field_val << field_offset);
+	} else {
+		reg_val &= ~(field_mask << (field_offset + 8));
+		reg_val |= (field_val << (field_offset + 8));
+	}
+
+	return reg_val;
+}
+
 static int tps23881_pi_enable(struct pse_controller_dev *pcdev, int id)
 {
 	struct tps23881_priv *priv = to_tps23881_priv(pcdev);
@@ -69,17 +118,12 @@ static int tps23881_pi_enable(struct pse_controller_dev *pcdev, int id)
 		return ret;
 
 	chan = priv->port[id].chan[0];
-	if (chan < 4)
-		val = (u16)(ret | BIT(chan));
-	else
-		val = (u16)(ret | BIT(chan + 4));
+	val = tps23881_set_val(ret, chan, 0, BIT(chan % 4), BIT(chan % 4));
 
 	if (priv->port[id].is_4p) {
 		chan = priv->port[id].chan[1];
-		if (chan < 4)
-			val |= BIT(chan);
-		else
-			val |= BIT(chan + 4);
+		val = tps23881_set_val(val, chan, 0, BIT(chan % 4),
+				       BIT(chan % 4));
 	}
 
 	ret = i2c_smbus_write_word_data(client, TPS23881_REG_PW_EN, val);
@@ -105,17 +149,12 @@ static int tps23881_pi_disable(struct pse_controller_dev *pcdev, int id)
 		return ret;
 
 	chan = priv->port[id].chan[0];
-	if (chan < 4)
-		val = (u16)(ret | BIT(chan + 4));
-	else
-		val = (u16)(ret | BIT(chan + 8));
+	val = tps23881_set_val(ret, chan, 4, BIT(chan % 4), BIT(chan % 4));
 
 	if (priv->port[id].is_4p) {
 		chan = priv->port[id].chan[1];
-		if (chan < 4)
-			val |= BIT(chan + 4);
-		else
-			val |= BIT(chan + 8);
+		val = tps23881_set_val(val, chan, 4, BIT(chan % 4),
+				       BIT(chan % 4));
 	}
 
 	return i2c_smbus_write_word_data(client, TPS23881_REG_PW_EN, val);
@@ -127,6 +166,7 @@ static int tps23881_pi_is_enabled(struct pse_controller_dev *pcdev, int id)
 	struct i2c_client *client = priv->client;
 	bool enabled;
 	u8 chan;
+	u16 val;
 	int ret;
 
 	ret = i2c_smbus_read_word_data(client, TPS23881_REG_PW_STATUS);
@@ -134,17 +174,13 @@ static int tps23881_pi_is_enabled(struct pse_controller_dev *pcdev, int id)
 		return ret;
 
 	chan = priv->port[id].chan[0];
-	if (chan < 4)
-		enabled = ret & BIT(chan);
-	else
-		enabled = ret & BIT(chan + 4);
+	val = tps23881_calc_val(ret, chan, 0, BIT(chan % 4));
+	enabled = !!(val);
 
 	if (priv->port[id].is_4p) {
 		chan = priv->port[id].chan[1];
-		if (chan < 4)
-			enabled &= !!(ret & BIT(chan));
-		else
-			enabled &= !!(ret & BIT(chan + 4));
+		val = tps23881_calc_val(ret, chan, 0, BIT(chan % 4));
+		enabled &= !!(val);
 	}
 
 	/* Return enabled status only if both channel are on this state */
@@ -160,6 +196,7 @@ static int tps23881_ethtool_get_status(struct pse_controller_dev *pcdev,
 	struct i2c_client *client = priv->client;
 	bool enabled, delivering;
 	u8 chan;
+	u16 val;
 	int ret;
 
 	ret = i2c_smbus_read_word_data(client, TPS23881_REG_PW_STATUS);
@@ -167,23 +204,17 @@ static int tps23881_ethtool_get_status(struct pse_controller_dev *pcdev,
 		return ret;
 
 	chan = priv->port[id].chan[0];
-	if (chan < 4) {
-		enabled = ret & BIT(chan);
-		delivering = ret & BIT(chan + 4);
-	} else {
-		enabled = ret & BIT(chan + 4);
-		delivering = ret & BIT(chan + 8);
-	}
+	val = tps23881_calc_val(ret, chan, 0, BIT(chan % 4));
+	enabled = !!(val);
+	val = tps23881_calc_val(ret, chan, 4, BIT(chan % 4));
+	delivering = !!(val);
 
 	if (priv->port[id].is_4p) {
 		chan = priv->port[id].chan[1];
-		if (chan < 4) {
-			enabled &= !!(ret & BIT(chan));
-			delivering &= !!(ret & BIT(chan + 4));
-		} else {
-			enabled &= !!(ret & BIT(chan + 4));
-			delivering &= !!(ret & BIT(chan + 8));
-		}
+		val = tps23881_calc_val(ret, chan, 0, BIT(chan % 4));
+		enabled &= !!(val);
+		val = tps23881_calc_val(ret, chan, 4, BIT(chan % 4));
+		delivering &= !!(val);
 	}
 
 	/* Return delivering status only if both channel are on this state */

-- 
2.34.1



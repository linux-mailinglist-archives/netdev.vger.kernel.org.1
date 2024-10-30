Return-Path: <netdev+bounces-140477-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 316809B69CC
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 17:57:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 542011C2082D
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 16:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CF4621B439;
	Wed, 30 Oct 2024 16:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="NWbM+9JI"
X-Original-To: netdev@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34EC92194B5;
	Wed, 30 Oct 2024 16:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730307246; cv=none; b=WL/oWC5KHFAvmLQ1KIsLNHFzl6C1CA0qt5sLp/tIN/yerG4Ju1ObnxC6WUWnr5ROPKkDdkKw3LimlpDDJdLX1e5xUop2i7X8ne4EIta4BmZxbi8NlMrNu1GLm0ykc62fYErV3ZFef4F1r//d99Ic7gH1PtOGUpLLSokf3cqrwy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730307246; c=relaxed/simple;
	bh=6YXADs66ZEo8Xd5qgtpbfltEJNbzzRkqeeQks6lC1aU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lGar2ygIB62cwpIxFvU+LOiu0LlAoSo9kQ7GU8yMsSXhLl+/+3cURDIZ+AxMxCJ69APPRjobV2ItdvPVPqWVf4RWhY8r1KmqiZsl6L3c5NPUTp+Zbu35tFI4x0ri+ymj8c/pfR+7wrQz2OZpHT8UNYyvD6lfS7qG31Hn+23pWVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=NWbM+9JI; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 118E7C000A;
	Wed, 30 Oct 2024 16:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1730307236;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uTPLNz5yTOtn3lqPTWfyhqM47yr8HvgCllgs7jDzZNE=;
	b=NWbM+9JI4oTCtdEnyWDljVNJoyaVGQ9zqnlpF4OPwHpPENZL2Scya9JEinu8CL8X5bkbvg
	W4sapk/gV3c+J7Pfk+M/pHJgRT0Xj+ig+HgiNkNWwla/Z8p29gOBS5S6zRznHAoLrY6Ak+
	hVpjvpS6jniuzpSjtwzei4NpU5qibfT2nKVihLVF5yAF1z92a/DeeS2PiDxtkhvMCMuEFs
	9evqq/JS11iHAumyCpifglVBoJDVI6H7YucVh1fSyIPbM4wc1/UbrC+bX2KjEN7uUk3zrV
	/2XVbBQ7UGcGvI1QkIkhAuz4ACwzcit60FJWXDwRP37fW6U1lZXH/pnHmBCKOw==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Wed, 30 Oct 2024 17:53:05 +0100
Subject: [PATCH RFC net-next v2 03/18] net: pse-pd: tps23881: Use helpers
 to calculate bit offset for a channel
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241030-feature_poe_port_prio-v2-3-9559622ee47a@bootlin.com>
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

This driver frequently follows a pattern where two registers are read or
written in a single operation, followed by calculating the bit offset for
a specific channel.

Introduce helpers to streamline this process and reduce code redundancy,
making the codebase cleaner and more maintainable.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

Thanks to Oleksij for the design of the helpers functions.

Change in v2:
- New patch
---
 drivers/net/pse-pd/tps23881.c | 107 +++++++++++++++++++++++++++---------------
 1 file changed, 69 insertions(+), 38 deletions(-)

diff --git a/drivers/net/pse-pd/tps23881.c b/drivers/net/pse-pd/tps23881.c
index 20eab9857817..391b8964f687 100644
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
+	if (chan > 4)
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



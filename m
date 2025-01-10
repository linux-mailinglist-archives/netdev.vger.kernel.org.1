Return-Path: <netdev+bounces-157055-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEF27A08C99
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 10:45:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 035F83ABB5E
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 09:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF70520DD76;
	Fri, 10 Jan 2025 09:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="EEInbnPb"
X-Original-To: netdev@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411B720CCC2;
	Fri, 10 Jan 2025 09:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736502051; cv=none; b=kgiUC6vm3NuIf4bM5phQeh8nOs3OoSnUMNDKcMbTjXdlhbGXNBjU7LWM2E/pHeramE4cTXAu9gNGIehLZJKdHmMqMXbWN7Z95PC48CsSK6Mw1tyoM6OuhsoZnSz2uCSTBcRXKYug0Ra04O6rsiZEpsV9KPAj+bSquzi51YkCSpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736502051; c=relaxed/simple;
	bh=ns29UNfUXHFoRLrVuc7uzRszGQJY3zowfpiKXHfpbzI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C3A90+IDcE+krXN0PAXC5+xWAGoRzVQC6vBB8sHv4BEgi27KHTRbzMzWsjKEN+jmjA61sDzSVlH4kZdsukDOBfoigx6qfRTGQV6NVcG6TWLZRiRkH+kGS6GMCHOLDe+Fy+fJun1xWzF16r2agetc7oxyRBJwCh6rDK3DylrS6UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=EEInbnPb; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id CE8596000A;
	Fri, 10 Jan 2025 09:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1736502047;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b2luEWHl/wNv8QBtLwThUaVY9O5h4DfUQKdcYl8DSSw=;
	b=EEInbnPbAFaIvz3ozjtijeSLxjxHyn9tWVzBOWVjaLGW/MYCnNxSnCaaUFmYrXMgdtm+WC
	TUEcVdsp13Pqts03F80/UYZBXeJjNii6u7V+qWmq6EAu5waA4emjUokIR+FnvgO4BQSFOH
	xCH5aL6lqet9J2tumPqvVNhI1LUrNaiPBNsFwt47cTeIHsSMctD1s2CWbThZWXlVBRoZ29
	XgZhgBV+09uVkZu4EUXjRJIVN70uFivB1zHagZX+jwCtphaBs2Ycd3kaoxu7smLvdYXvka
	G5X5ELRbpDPiFn7TqIH7EU8Kn5dqqCiEvn7gPQXjo6wIdzSPsj36NR0jT3PuEw==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Fri, 10 Jan 2025 10:40:24 +0100
Subject: [PATCH net-next v3 05/12] net: pse-pd: tps23881: Use helpers to
 calculate bit offset for a channel
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250110-b4-feature_poe_arrange-v3-5-142279aedb94@bootlin.com>
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

This driver frequently follows a pattern where two registers are read or
written in a single operation, followed by calculating the bit offset for
a specific channel.

Introduce helpers to streamline this process and reduce code redundancy,
making the codebase cleaner and more maintainable.

Acked-by: Oleksij Rempel <o.rempel@pengutronix.de>
Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
 drivers/net/pse-pd/tps23881.c | 107 +++++++++++++++++++++++++++---------------
 1 file changed, 69 insertions(+), 38 deletions(-)

diff --git a/drivers/net/pse-pd/tps23881.c b/drivers/net/pse-pd/tps23881.c
index a3507520ff87..4a75206b2de6 100644
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
@@ -64,17 +113,12 @@ static int tps23881_pi_enable(struct pse_controller_dev *pcdev, int id)
 		return -ERANGE;
 
 	chan = priv->port[id].chan[0];
-	if (chan < 4)
-		val = BIT(chan);
-	else
-		val = BIT(chan + 4);
+	val = tps23881_set_val(0, chan, 0, BIT(chan % 4), BIT(chan % 4));
 
 	if (priv->port[id].is_4p) {
 		chan = priv->port[id].chan[1];
-		if (chan < 4)
-			val |= BIT(chan);
-		else
-			val |= BIT(chan + 4);
+		val = tps23881_set_val(val, chan, 0, BIT(chan % 4),
+				       BIT(chan % 4));
 	}
 
 	return i2c_smbus_write_word_data(client, TPS23881_REG_PW_EN, val);
@@ -91,17 +135,12 @@ static int tps23881_pi_disable(struct pse_controller_dev *pcdev, int id)
 		return -ERANGE;
 
 	chan = priv->port[id].chan[0];
-	if (chan < 4)
-		val = BIT(chan + 4);
-	else
-		val = BIT(chan + 8);
+	val = tps23881_set_val(0, chan, 4, BIT(chan % 4), BIT(chan % 4));
 
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
@@ -113,6 +152,7 @@ static int tps23881_pi_is_enabled(struct pse_controller_dev *pcdev, int id)
 	struct i2c_client *client = priv->client;
 	bool enabled;
 	u8 chan;
+	u16 val;
 	int ret;
 
 	ret = i2c_smbus_read_word_data(client, TPS23881_REG_PW_STATUS);
@@ -120,17 +160,13 @@ static int tps23881_pi_is_enabled(struct pse_controller_dev *pcdev, int id)
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
@@ -146,6 +182,7 @@ static int tps23881_ethtool_get_status(struct pse_controller_dev *pcdev,
 	struct i2c_client *client = priv->client;
 	bool enabled, delivering;
 	u8 chan;
+	u16 val;
 	int ret;
 
 	ret = i2c_smbus_read_word_data(client, TPS23881_REG_PW_STATUS);
@@ -153,23 +190,17 @@ static int tps23881_ethtool_get_status(struct pse_controller_dev *pcdev,
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



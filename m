Return-Path: <netdev+bounces-157056-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB0FA08C9D
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 10:46:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F9EB3ABD43
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 09:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BCFE20E01C;
	Fri, 10 Jan 2025 09:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="LfDhC7Qw"
X-Original-To: netdev@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DEF220D4E8;
	Fri, 10 Jan 2025 09:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736502052; cv=none; b=uqkmNzUSS2xiWvNuaZB5hxyRA9sqqmlSreIIWv9A1kFcgS1u7y/2SFOWCcOzMt3lBx29hR8mZR7NcKY/0UXDwOXZjY6ySXoDnk4H+GfIrsMUXTHTcc+eh34/ORXW+Apm9yrNja+Fl0Hc6QpLxpIUzpRc5E25CiOyNNPY3b5yR5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736502052; c=relaxed/simple;
	bh=1cpyM0nhY6kdZvQnHRrrE/y2S5upKCKKbmuWL2v0Y0Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B9mKIqJSXVG1Csk0K5fHscefsHgGdagUXHcC0eQYkbApXRFwX08sSUPa6SrB25g8g3Koh6MLmc5IE1xFvv4DHVkKzwWdRCBkSpdf0lyLeBdCwGaOkEbabvsAy3/P5r9ULQxlHpOt3DCQbPiWF5ARwTawwNAWdMpUvTsf/ZKo28M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=LfDhC7Qw; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id BCDAF6000F;
	Fri, 10 Jan 2025 09:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1736502048;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zug4J6T28+TU1ScCoHZv4AeuuSzRl2B40KC9bPHJdw4=;
	b=LfDhC7QwgMRZw2r1meACLIsF8ll2+J4/ZSchPtVRf7YDEMUi0aKyVpuVIiRoIWMGYTifek
	pOdFkd3ydRzWqQjjdEW/nIHY1rUhZxBz3jZkfEz1c9nuC7iYqgvQgR3gG86CmaGEWTW50X
	7/nj4tYfyjOn/8sAl/MXo5TeR9hUrbEUJduYC3ok4EPHPRfYlSmX5XCqqsiLHAlN7gon1X
	qybyxgAX5Zztmwk1GkSNI4PN5xzSyaSF6cIn06XM/xTMre6skhzEywFevUhERoefNPMKLR
	38r3c4kc4K1UD0ircWZB2VQoMLbYHo4IquAaTqFqfwXnkrAxhSyFTwAcv3C5Fw==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Fri, 10 Jan 2025 10:40:25 +0100
Subject: [PATCH net-next v3 06/12] net: pse-pd: tps23881: Add missing
 configuration register after disable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250110-b4-feature_poe_arrange-v3-6-142279aedb94@bootlin.com>
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

When setting the PWOFF register, the controller resets multiple
configuration registers. This patch ensures these registers are
reconfigured as needed following a disable operation.

Acked-by: Oleksij Rempel <o.rempel@pengutronix.de>
Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
 drivers/net/pse-pd/tps23881.c | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/net/pse-pd/tps23881.c b/drivers/net/pse-pd/tps23881.c
index 4a75206b2de6..b87c391ae0f5 100644
--- a/drivers/net/pse-pd/tps23881.c
+++ b/drivers/net/pse-pd/tps23881.c
@@ -130,6 +130,7 @@ static int tps23881_pi_disable(struct pse_controller_dev *pcdev, int id)
 	struct i2c_client *client = priv->client;
 	u8 chan;
 	u16 val;
+	int ret;
 
 	if (id >= TPS23881_MAX_CHANS)
 		return -ERANGE;
@@ -143,7 +144,34 @@ static int tps23881_pi_disable(struct pse_controller_dev *pcdev, int id)
 				       BIT(chan % 4));
 	}
 
-	return i2c_smbus_write_word_data(client, TPS23881_REG_PW_EN, val);
+	ret = i2c_smbus_write_word_data(client, TPS23881_REG_PW_EN, val);
+	if (ret)
+		return ret;
+
+	/* PWOFF command resets lots of register which need to be
+	 * configured again. According to the datasheet "It may take upwards
+	 * of 5ms after PWOFFn command for all register values to be updated"
+	 */
+	mdelay(5);
+
+	/* Enable detection and classification */
+	ret = i2c_smbus_read_word_data(client, TPS23881_REG_DET_CLA_EN);
+	if (ret < 0)
+		return ret;
+
+	chan = priv->port[id].chan[0];
+	val = tps23881_set_val(ret, chan, 0, BIT(chan % 4), BIT(chan % 4));
+	val = tps23881_set_val(val, chan, 4, BIT(chan % 4), BIT(chan % 4));
+
+	if (priv->port[id].is_4p) {
+		chan = priv->port[id].chan[1];
+		val = tps23881_set_val(ret, chan, 0, BIT(chan % 4),
+				       BIT(chan % 4));
+		val = tps23881_set_val(val, chan, 4, BIT(chan % 4),
+				       BIT(chan % 4));
+	}
+
+	return i2c_smbus_write_word_data(client, TPS23881_REG_DET_CLA_EN, val);
 }
 
 static int tps23881_pi_is_enabled(struct pse_controller_dev *pcdev, int id)

-- 
2.34.1



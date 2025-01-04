Return-Path: <netdev+bounces-155207-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80D21A0172D
	for <lists+netdev@lfdr.de>; Sat,  4 Jan 2025 23:30:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 668E9163114
	for <lists+netdev@lfdr.de>; Sat,  4 Jan 2025 22:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D1CA1D89FA;
	Sat,  4 Jan 2025 22:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="JUAxrAEO"
X-Original-To: netdev@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E8B1D7994;
	Sat,  4 Jan 2025 22:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736029736; cv=none; b=WqpzW6WuylxVXKPn5LrbKQBCRXBcGSQV109rCibunz+xvccI+QBKo9r46UiJcjaKJawEEiYlk8Kl6+3v+F5Pifr4AGILdkdO2DWplWkvZP+yzgdtKo1TEQD8KQvAACwFNVjqTMGomOUw9KIUwSbkHL20tChb9nr7rAOLqxByoig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736029736; c=relaxed/simple;
	bh=/tAXWE9ZL4WtZspUDdAze2QFcr2Yf2fb5nGAhV9PnmQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Xzg7aG9USlTc64KeI+A6qzrC8ftkxq81+Ey3ldzh/Qyow0CmQ2XpOoytfL0gG01OwuQWmCrO6Jmg874vrZY7TgMrh7KqvPolmONZUhSCWTgoDi5bSDiNjPuVDl1tnTFdWChF8lCFElS9vKD9yGabj4S+6F9ZNDrh4swArIFkrhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=JUAxrAEO; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B5A2740002;
	Sat,  4 Jan 2025 22:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1736029732;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3sbdIG7o+MIgUW4/5Lh2oWiUH88289E01R5dOjp9fk0=;
	b=JUAxrAEOIGvp+h65Pf6gdrB6ljByE9+DfnZCwSUNRUFuy4XxNhP7OMdNcXDalOv1p4a/x7
	uullnHvNUgSmGIrmfCXgbfHci5jgvzXSmCfSw5VZX+zS6jBgr5C1XZrp3hWvNEUcaYEJ3B
	S4xv5fOLMyvnGi7A6TcsBw0AOoJ4jzFQ/+/XaFGj+4vSN+C8CmFqjlVl/kaIib0swUfPHD
	CXF7YhfRJXG3/v9yJnyrh0GTStlaibORNlKmyPP4XtvTiFgk0Tp9iAv1eoJStLVG8JwjHX
	fCdvYhHhWXQgrS7N7MHhaV1yfc2wYh1TeiEElGCSnA7NhHCBtjjsvjhGVh75EA==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Sat, 04 Jan 2025 23:27:31 +0100
Subject: [PATCH net-next 06/14] net: pse-pd: tps23881: Add missing
 configuration register after disable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250104-b4-feature_poe_arrange-v1-6-92f804bd74ed@bootlin.com>
References: <20250104-b4-feature_poe_arrange-v1-0-92f804bd74ed@bootlin.com>
In-Reply-To: <20250104-b4-feature_poe_arrange-v1-0-92f804bd74ed@bootlin.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>, 
 Jonathan Corbet <corbet@lwn.net>, Liam Girdwood <lgirdwood@gmail.com>, 
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



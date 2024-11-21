Return-Path: <netdev+bounces-146657-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43F949D4EDF
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 15:45:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09D38282386
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 14:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 209E21DE3AE;
	Thu, 21 Nov 2024 14:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="nbCYWFlY"
X-Original-To: netdev@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87991DD877;
	Thu, 21 Nov 2024 14:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732200226; cv=none; b=YvZzahqpHOhvjVxtG6YmfjrUik5sMXZQllihrSREsOBciMxthMNyYBiqRzun2fmfy+AtgwC3GdZSFliYDbINhhb3XL3QmTvRbUcT0uRtaW2ZVeGXTJ6k6MwSjTgd7eymyS3NudtBck6GcSZgOBOQw72Bc14+5QTPv5fe/JS8dJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732200226; c=relaxed/simple;
	bh=ZsdCmW4n2LvHHk61rNgVX7raqVKq/pW4WBuFPn32Q2I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bQ79+my5K9/3ZUBM5TeQbdEhW/vdGj+Om3O9HcmtxfMxAm2yujVJS2kF0yLuBz+SZV+1qucNx6HHsZsmzS9AjHMueAY2OzcUg1zvUVEauGTrnicdEQSHkWYaABy4znWj+p11XI69rmzvPgzpvJGzDqyRnnujhqz0KJLsW3jAW9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=nbCYWFlY; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 198CB40006;
	Thu, 21 Nov 2024 14:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1732200222;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZR/OQqXD89qyu5jFhAfZEfAZSUhVQIdWY1c3hbVfIMM=;
	b=nbCYWFlYdqMjzdMZMVjm2eP2ZK2CE0KsGNaRD0BVd3lFbkTqjUsjj0Z9fuoHa7J2RUo0b3
	C+Z9NoRJzW5WOBtTd2Mq3J4y5Fz5eT39tkn4VHtkPpqTj4Hn/ISjhc0hOG+ugZGyRVAQhj
	xTEZ9xwrNJaliOzr6aE5P7/vtzubWZ3sxtx1ogpv+FZrkkT/5HXXwYCyl5erLdXewRrdrM
	A/tHNdNKWpmkPeZFQnanv83mXhej5T7SKXqeLWJPpTE4s4YN1OnLFNumvyZS/gjqtaIm9D
	92UvzppHSGrCw4H5XxPa6CzpZKpQA9ICHJ5JI5zI/Pkbt+xzjzbHC8d/4KUTWg==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Thu, 21 Nov 2024 15:42:31 +0100
Subject: [PATCH RFC net-next v3 05/27] net: pse-pd: tps23881: Simplify
 function returns by removing redundant checks
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241121-feature_poe_port_prio-v3-5-83299fa6967c@bootlin.com>
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

Cleaned up several functions in tps23881 by removing redundant checks on
return values at the end of functions. These check has been removed, and
the return statement now directly returns the function result, reducing
the code's complexity and making it more concise.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Acked-by: Oleksij Rempel <o.rempel@pengutronix.de>
Reviewed-by: Kyle Swenson <kyle.swenson@est.tech>
Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
 drivers/net/pse-pd/tps23881.c | 26 +++++---------------------
 1 file changed, 5 insertions(+), 21 deletions(-)

diff --git a/drivers/net/pse-pd/tps23881.c b/drivers/net/pse-pd/tps23881.c
index 5c4e88be46ee..20eab9857817 100644
--- a/drivers/net/pse-pd/tps23881.c
+++ b/drivers/net/pse-pd/tps23881.c
@@ -118,11 +118,7 @@ static int tps23881_pi_disable(struct pse_controller_dev *pcdev, int id)
 			val |= BIT(chan + 8);
 	}
 
-	ret = i2c_smbus_write_word_data(client, TPS23881_REG_PW_EN, val);
-	if (ret)
-		return ret;
-
-	return 0;
+	return i2c_smbus_write_word_data(client, TPS23881_REG_PW_EN, val);
 }
 
 static int tps23881_pi_is_enabled(struct pse_controller_dev *pcdev, int id)
@@ -488,7 +484,7 @@ tps23881_write_port_matrix(struct tps23881_priv *priv,
 	struct i2c_client *client = priv->client;
 	u8 pi_id, lgcl_chan, hw_chan;
 	u16 val = 0;
-	int i, ret;
+	int i;
 
 	for (i = 0; i < port_cnt; i++) {
 		pi_id = port_matrix[i].pi_id;
@@ -519,11 +515,7 @@ tps23881_write_port_matrix(struct tps23881_priv *priv,
 	}
 
 	/* Write hardware ports matrix */
-	ret = i2c_smbus_write_word_data(client, TPS23881_REG_PORT_MAP, val);
-	if (ret)
-		return ret;
-
-	return 0;
+	return i2c_smbus_write_word_data(client, TPS23881_REG_PORT_MAP, val);
 }
 
 static int
@@ -572,11 +564,7 @@ tps23881_set_ports_conf(struct tps23881_priv *priv,
 			val |= BIT(port_matrix[i].lgcl_chan[1]) |
 			       BIT(port_matrix[i].lgcl_chan[1] + 4);
 	}
-	ret = i2c_smbus_write_word_data(client, TPS23881_REG_DET_CLA_EN, val);
-	if (ret)
-		return ret;
-
-	return 0;
+	return i2c_smbus_write_word_data(client, TPS23881_REG_DET_CLA_EN, val);
 }
 
 static int
@@ -602,11 +590,7 @@ tps23881_set_ports_matrix(struct tps23881_priv *priv,
 	if (ret)
 		return ret;
 
-	ret = tps23881_set_ports_conf(priv, port_matrix);
-	if (ret)
-		return ret;
-
-	return 0;
+	return tps23881_set_ports_conf(priv, port_matrix);
 }
 
 static int tps23881_setup_pi_matrix(struct pse_controller_dev *pcdev)

-- 
2.34.1



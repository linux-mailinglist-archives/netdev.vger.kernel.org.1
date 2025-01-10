Return-Path: <netdev+bounces-157054-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 063A8A08C94
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 10:45:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BCBF3AB10A
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 09:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9B2B20D50C;
	Fri, 10 Jan 2025 09:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="bYKw4LyX"
X-Original-To: netdev@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58BA620C01C;
	Fri, 10 Jan 2025 09:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736502050; cv=none; b=FdMWx2Q0ayj+mhX0kDn58Uf+alJ9Sl9tbXh/HEMId53yEgUI7G3LquR8GEHI6aeIyTPyr+YnidujBxtup4HJOTpvrDUjLLbxORL8sM7mEEX/hT2y9KVWH0seTN9BXiMq34e0fJ4kWn5sHhya4zeqhD4jwzELE9cQDK4QczHdGqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736502050; c=relaxed/simple;
	bh=TvFBQV31iwYwOG9dtrUHP6DEYjVPybIBNJwsyuhd5GU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XdXqnv6McKWlNYodTjB1OvLuZJWnmLN/xGx0mPJs5afW3Tl8siOklMoBZFLbvHKmrsFsD5yyGhl8G5L6wj8aW/v8PeA8rWgNEO1oHW0T5VhDm7PZOtOaGUaQadvCaKabeP7+y4M/85sS/Cttd7uWrkwaDMJEBbJNxkDhhLDSCt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=bYKw4LyX; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D698860004;
	Fri, 10 Jan 2025 09:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1736502046;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CocVB22R4GqNnoqhdrol2m5clFmBx09JeRH+KXr6f7c=;
	b=bYKw4LyXX0oo0dl5t+JIw/k3DRztjQXafDbv5MW3LWzwxJ2eq3d28MM5CzZRU1Ua7zFIPG
	0kWv9UrledBLFXdDN5pDIM2G4ynbjJIUvh+pQsxchmg1rTWl2l9JgssyDIVe9d/I1i9BLS
	pKoDFMsdNcR6i2IFHJLtcK6HuRbDtzP9RH+9Lfz/uX1rA6su2qJauMZ3L0DWTdWApkf7vT
	64xxLO+MtNpDs13LRqJYGXpS/dVPA147Cb3StTS9mVWnxM6XGrXh4M03tkwYupM8phgltL
	48jk84fWtxNdDcOqpkshp15+b7I0RvrKwbPB2oHSsrOgjOM24eJXZG0ik3w7kw==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Fri, 10 Jan 2025 10:40:23 +0100
Subject: [PATCH net-next v3 04/12] net: pse-pd: tps23881: Simplify function
 returns by removing redundant checks
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250110-b4-feature_poe_arrange-v3-4-142279aedb94@bootlin.com>
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
 Kory Maincent <kory.maincent@bootlin.com>, Andrew Lunn <andrew@lunn.ch>
X-Mailer: b4 0.14.1
X-GND-Sasl: kory.maincent@bootlin.com

Cleaned up several functions in tps23881 by removing redundant checks on
return values at the end of functions. These check has been removed, and
the return statement now directly returns the function result, reducing
the code's complexity and making it more concise.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Acked-by: Oleksij Rempel <o.rempel@pengutronix.de>
Reviewed-by: Kyle Swenson <kyle.swenson@est.tech>
Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
 drivers/net/pse-pd/tps23881.c | 34 ++++++----------------------------
 1 file changed, 6 insertions(+), 28 deletions(-)

diff --git a/drivers/net/pse-pd/tps23881.c b/drivers/net/pse-pd/tps23881.c
index 8797ca1a8a21..a3507520ff87 100644
--- a/drivers/net/pse-pd/tps23881.c
+++ b/drivers/net/pse-pd/tps23881.c
@@ -59,7 +59,6 @@ static int tps23881_pi_enable(struct pse_controller_dev *pcdev, int id)
 	struct i2c_client *client = priv->client;
 	u8 chan;
 	u16 val;
-	int ret;
 
 	if (id >= TPS23881_MAX_CHANS)
 		return -ERANGE;
@@ -78,11 +77,7 @@ static int tps23881_pi_enable(struct pse_controller_dev *pcdev, int id)
 			val |= BIT(chan + 4);
 	}
 
-	ret = i2c_smbus_write_word_data(client, TPS23881_REG_PW_EN, val);
-	if (ret)
-		return ret;
-
-	return 0;
+	return i2c_smbus_write_word_data(client, TPS23881_REG_PW_EN, val);
 }
 
 static int tps23881_pi_disable(struct pse_controller_dev *pcdev, int id)
@@ -91,7 +86,6 @@ static int tps23881_pi_disable(struct pse_controller_dev *pcdev, int id)
 	struct i2c_client *client = priv->client;
 	u8 chan;
 	u16 val;
-	int ret;
 
 	if (id >= TPS23881_MAX_CHANS)
 		return -ERANGE;
@@ -110,11 +104,7 @@ static int tps23881_pi_disable(struct pse_controller_dev *pcdev, int id)
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
@@ -480,7 +470,7 @@ tps23881_write_port_matrix(struct tps23881_priv *priv,
 	struct i2c_client *client = priv->client;
 	u8 pi_id, lgcl_chan, hw_chan;
 	u16 val = 0;
-	int i, ret;
+	int i;
 
 	for (i = 0; i < port_cnt; i++) {
 		pi_id = port_matrix[i].pi_id;
@@ -511,11 +501,7 @@ tps23881_write_port_matrix(struct tps23881_priv *priv,
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
@@ -564,11 +550,7 @@ tps23881_set_ports_conf(struct tps23881_priv *priv,
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
@@ -594,11 +576,7 @@ tps23881_set_ports_matrix(struct tps23881_priv *priv,
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



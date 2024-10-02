Return-Path: <netdev+bounces-131291-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 214C598E064
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 18:15:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C98B328587D
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 16:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A40FB1D1518;
	Wed,  2 Oct 2024 16:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ZMDM2Wpo"
X-Original-To: netdev@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539CD1D0E19;
	Wed,  2 Oct 2024 16:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727885693; cv=none; b=aObOa4EfaxNedhmPJgRbluwyrs7AszXP0gDyw1FF58ege1dGR2xxJMIkQjA22T8cMAnWB7cK4ypL6G8EM3UIoZe4Pq6V4NjhHUvrb8z7WR6bFOUkRkbzPax7rhzwbtn1rsneYT9vA5/BYxY4AJLv8lv1PCedhOjpN/3ONwbuwKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727885693; c=relaxed/simple;
	bh=OV/RdTYEnlbC3pry5KNHKsetn+/sjren2tP879uTa5Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gDwCIDOjLfcEWt3VVdMs0MzfFmESBxkoHvKsVAavyRubU9OR90gPM+lo3XtfublFdKDO/zx4YiPxyJ7tlLC2Qfrcxbjb//IcI1Tqfn4cUs90X2b6goSxoPrqMWBii6rATy+vDLsexWkVDnNNUNBA63ald3vSib8UPBYJDKkDqOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ZMDM2Wpo; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B124AFF80A;
	Wed,  2 Oct 2024 16:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1727885684;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5ePH3amKbdbo1+SFMAbJyxHZ4YiapYq55nJZg7ttGFg=;
	b=ZMDM2WpoyLVJwrUzZhoIq92Nx1nkGmEJVQDJactxsWB2Wg0wQXq/LGoyczTfefRCqoTyrC
	g44Q1f5bO9zVqCqej9FgYFjZOYBEinOUJZ+llp1AIz5GnAPZ0pbVlm5Y5Jm+eSsy4hfp4E
	EzNbB436ooNO8VqgHi6M0WaSPsq45WpUK7buatGmwHoMaNvLB+Hxy4ZBQHD52uR7+d7ZwZ
	8028durkTipo0JxeDJkpI+2jJJtYr4mR1iQInuHPJevKht5E4s1smLFxlMVy3SHl8jhBIk
	OauvPKfWtb65XS2ppPaTzO7rxBeGb8BxidRazKAQesnzXcxAMibSXYgN0uYVoA==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Wed, 02 Oct 2024 18:14:14 +0200
Subject: [PATCH 03/12] net: pse-pd: tps23881: Simplify function returns by
 removing redundant checks
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241002-feature_poe_port_prio-v1-3-eb067b78d6cf@bootlin.com>
References: <20241002-feature_poe_port_prio-v1-0-eb067b78d6cf@bootlin.com>
In-Reply-To: <20241002-feature_poe_port_prio-v1-0-eb067b78d6cf@bootlin.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Jonathan Corbet <corbet@lwn.net>, Donald Hunter <donald.hunter@gmail.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-doc@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>, 
 Dent Project <dentproject@linuxfoundation.org>, kernel@pengutronix.de, 
 Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.15-dev-8cb71
X-GND-Sasl: kory.maincent@bootlin.com

From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>

Cleaned up several functions in tps23881 by removing redundant checks on
return values at the end of functions. These check has been removed, and
the return statement now directly returns the function result, reducing
the code's complexity and making it more concise.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
 drivers/net/pse-pd/tps23881.c | 26 +++++---------------------
 1 file changed, 5 insertions(+), 21 deletions(-)

diff --git a/drivers/net/pse-pd/tps23881.c b/drivers/net/pse-pd/tps23881.c
index 1a57c55f8577..fdf996f5d1f8 100644
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



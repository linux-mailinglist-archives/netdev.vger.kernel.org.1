Return-Path: <netdev+bounces-250793-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DD94FD39267
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 04:26:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 981823011004
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 03:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBF2A2D5A19;
	Sun, 18 Jan 2026 03:26:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994AB285C8D;
	Sun, 18 Jan 2026 03:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768706788; cv=none; b=AMHxGkN8OgwAhoyo/sFBQwVjEQoczn8gfoKxLEfeewYzF6lE6Y7hVK+NmgRj1ZrW/qjnECy2boUPinlL6uWvBAF/impbqD/Nt+eDo6V9qgkOcp2qVDEc5F9LYrWjCFTdfpPqMCEgBGmBoktaBmo5IEm4ENQdXgT0iCC5uSz1UhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768706788; c=relaxed/simple;
	bh=N8VyIRf66A2A3+6H87q/7UkyhXth+iqdcVGI0cbly/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WXHM5SzSub9y1HxTlNeZUqwTXEG0/rbXa+oNjmi7TbVJVTqdxXzWG5vXUl7HUCJqEqo6j1m0uwMS9n5Ob2DvNx50ExnJhI7EsL9qbiI5+A7djaA80+vTjTPv9PNoSbdLq4Bhzb3rMR9Zou2noo/ZF6JGKmEHYm259QvGTyY9Szc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1vhJQj-000000000fP-2tCG;
	Sun, 18 Jan 2026 03:26:21 +0000
Date: Sun, 18 Jan 2026 03:26:13 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Hauke Mehrtens <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Chen Minqiang <ptpt52@gmail.com>, Xinfa Deng <xinfa.deng@gl-inet.com>
Subject: [PATCH net-next v5 5/6] net: dsa: mxl-gsw1xx: only setup SerDes PCS
 if it exists
Message-ID: <1aa2df661218b4d03509ccb5691cfe76c88d1018.1768704116.git.daniel@makrotopia.org>
References: <cover.1768704116.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1768704116.git.daniel@makrotopia.org>

Older Intel GSW150 chip doesn't have a SGMII/1000Base-X/2500Base-X PCS.
Prepare for supporting Intel GSW150 by skipping PCS reset and
initialization in case no .mac_select_pcs operation is defined.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
v5: no changes
v4: no changes
v3: no changes
v2: new patch

 drivers/net/dsa/lantiq/mxl-gsw1xx.c | 37 ++++++++++++++++++-----------
 1 file changed, 23 insertions(+), 14 deletions(-)

diff --git a/drivers/net/dsa/lantiq/mxl-gsw1xx.c b/drivers/net/dsa/lantiq/mxl-gsw1xx.c
index 6a2d4bd5ded08..c9dc6e16d16b4 100644
--- a/drivers/net/dsa/lantiq/mxl-gsw1xx.c
+++ b/drivers/net/dsa/lantiq/mxl-gsw1xx.c
@@ -578,6 +578,28 @@ static struct regmap *gsw1xx_regmap_init(struct gsw1xx_priv *priv,
 				priv, &config);
 }
 
+static int gsw1xx_serdes_pcs_init(struct gsw1xx_priv *priv)
+{
+	/* do nothing if the chip doesn't have a SerDes PCS */
+	if (!priv->gswip.hw_info->mac_select_pcs)
+		return 0;
+
+	priv->pcs.ops = &gsw1xx_pcs_ops;
+	priv->pcs.poll = true;
+	__set_bit(PHY_INTERFACE_MODE_SGMII,
+		  priv->pcs.supported_interfaces);
+	__set_bit(PHY_INTERFACE_MODE_1000BASEX,
+		  priv->pcs.supported_interfaces);
+	if (priv->gswip.hw_info->supports_2500m)
+		__set_bit(PHY_INTERFACE_MODE_2500BASEX,
+			  priv->pcs.supported_interfaces);
+	priv->tbi_interface = PHY_INTERFACE_MODE_NA;
+
+	/* assert SGMII reset to power down SGMII unit */
+	return regmap_set_bits(priv->shell, GSW1XX_SHELL_RST_REQ,
+			       GSW1XX_RST_REQ_SGMII_SHELL);
+}
+
 static int gsw1xx_probe(struct mdio_device *mdiodev)
 {
 	struct device *dev = &mdiodev->dev;
@@ -630,20 +652,7 @@ static int gsw1xx_probe(struct mdio_device *mdiodev)
 	if (IS_ERR(priv->shell))
 		return PTR_ERR(priv->shell);
 
-	priv->pcs.ops = &gsw1xx_pcs_ops;
-	priv->pcs.poll = true;
-	__set_bit(PHY_INTERFACE_MODE_SGMII,
-		  priv->pcs.supported_interfaces);
-	__set_bit(PHY_INTERFACE_MODE_1000BASEX,
-		  priv->pcs.supported_interfaces);
-	if (priv->gswip.hw_info->supports_2500m)
-		__set_bit(PHY_INTERFACE_MODE_2500BASEX,
-			  priv->pcs.supported_interfaces);
-	priv->tbi_interface = PHY_INTERFACE_MODE_NA;
-
-	/* assert SGMII reset to power down SGMII unit */
-	ret = regmap_set_bits(priv->shell, GSW1XX_SHELL_RST_REQ,
-			      GSW1XX_RST_REQ_SGMII_SHELL);
+	ret = gsw1xx_serdes_pcs_init(priv);
 	if (ret < 0)
 		return ret;
 
-- 
2.52.0


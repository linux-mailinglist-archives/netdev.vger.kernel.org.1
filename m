Return-Path: <netdev+bounces-250362-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0185ED2960F
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 01:08:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 425FB304349A
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 00:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C4A954723;
	Fri, 16 Jan 2026 00:08:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628C842AA3;
	Fri, 16 Jan 2026 00:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768522081; cv=none; b=t6D3GOaazW8AvKMpm9A/0RRn2UwKQ1+Ht0qVvcXXUbfhABdZqEKEUj/OGFcJcVFRLkChkhJMivLAkOYvTtvUWHGVmIaUyEVEy5851Q0dIb0kL7CNb3er0Ym7brqC/aS4DUq0dM+1NfCCAT5PUtDo4H45pgs9Xlh0KLmcx+q4vPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768522081; c=relaxed/simple;
	bh=J2qPx9fpXS+2+oSDbHYS4ZGyTfAP2YRim//GPBwaj14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OsF/G0h6feHk+wF/Pg0A7n008IlzkQdSOCOmSlbJF4BkOgFiDjWPDdzPEUe2lhfHC/9y92e19s5t5ECs9GyQ/WePB3tKpVV5RWYanphAKjc4rN2g8cVmh1oJ711dYYxtch3UVV8//9cap+PKvl28d4pKlWQp7u7uWypLOjx9Q3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1vgXNc-000000007ZK-0VIb;
	Fri, 16 Jan 2026 00:07:56 +0000
Date: Fri, 16 Jan 2026 00:07:53 +0000
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
Subject: [PATCH net-next v3 5/6] net: dsa: mxl-gsw1xx: only setup SerDes PCS
 if it exists
Message-ID: <9755af5b9607d0954f44a493577db78afdbfac3b.1768519376.git.daniel@makrotopia.org>
References: <cover.1768519376.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1768519376.git.daniel@makrotopia.org>

Older Intel GSW150 chip doesn't have a SGMII/1000Base-X/2500Base-X PCS.
Prepare for supporting Intel GSW150 by skipping PCS reset and
initialization in case no .mac_select_pcs operation is defined.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
v3: no changes
v2: new patch

 drivers/net/dsa/lantiq/mxl-gsw1xx.c | 37 ++++++++++++++++++-----------
 1 file changed, 23 insertions(+), 14 deletions(-)

diff --git a/drivers/net/dsa/lantiq/mxl-gsw1xx.c b/drivers/net/dsa/lantiq/mxl-gsw1xx.c
index 0267196f98464..54cf7aab3bfe4 100644
--- a/drivers/net/dsa/lantiq/mxl-gsw1xx.c
+++ b/drivers/net/dsa/lantiq/mxl-gsw1xx.c
@@ -579,6 +579,28 @@ static struct regmap *gsw1xx_regmap_init(struct gsw1xx_priv *priv,
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
@@ -631,20 +653,7 @@ static int gsw1xx_probe(struct mdio_device *mdiodev)
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


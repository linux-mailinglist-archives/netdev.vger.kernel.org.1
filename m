Return-Path: <netdev+bounces-55326-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F5A380A63B
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 15:53:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45751281C7A
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 14:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED1CB20B34;
	Fri,  8 Dec 2023 14:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FPlxBK4M"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19DDB387D;
	Fri,  8 Dec 2023 06:52:21 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-40c09f4814eso28992975e9.1;
        Fri, 08 Dec 2023 06:52:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702047140; x=1702651940; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=svpeSInqcPybABBCUtSaJ0EECZ2cPeIJlTmLy81gfdg=;
        b=FPlxBK4MRu+/soRdfLrZBTgz1ovbdftFcggpVP+akAOIZeLn0s3JAs4Es3rgVe1/lD
         80x2esOW+VAO7KgFeV18WnWeZ8yh5qnOLDz3+tz72+ZAjyzNCNs7iR1qTc9GWcwuZk05
         sQZwd+ZD9GY8hyueZIChtVkux2ei/lseL9BW+2SDC8RfP4qxAoSTsGox5ALUF726OGBF
         I88EGJKRNvWfx9oGiXdzGtj6kbtbBgcWefpGwPXO5aBkS7e34SAC1dDMVg62ba88vclA
         e1EdDx8bSy3rWfGcj0HC8w00vrd0HDMpzJ2fvauj7bpoNAPdnqJbcW5lvcsZpdsMzPTS
         H6bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702047140; x=1702651940;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=svpeSInqcPybABBCUtSaJ0EECZ2cPeIJlTmLy81gfdg=;
        b=dnOkESTVUGc1sDra7bZfxI6qQKta94IUlDZBkoTzanwHGp47yTur6PU1ziFJ6P+Ybj
         2tB0TNr15oQjmumEMO7tPsINcClg/DezHfA3oFwyP2fg9z8kAldjYoDXBa7VZsh4H87W
         kDpPfCSzludM4O4a6zd5EoYKg5ku9f4KRTPsffYMXLs1aUvLuGlD8rp4O1rHn9aZBot/
         taKtC3sU3R5lVBN+w0/ruuM8OC/z/t/JWNHVMiMIKwycoheS5ZQJtT1ldFlWBx3if3Gd
         30AmfeXXpzwT8Bvb1D/blFNZNUIL77kfNaBdfonL1FZLt1hN0tkJmB/PHWvxHd4pGVdr
         QvMA==
X-Gm-Message-State: AOJu0YwIZJY0X6XZMRFWpadoqKpb5JSAl77l4QB4cMmEas8TchIlgxdy
	fwqVfd9Fo2VJKqBSIEVDhbM=
X-Google-Smtp-Source: AGHT+IFCTqsfFFENH0LRFz02F/flJE6WQboHEipudGjKJqFLP6F8WTsQSkqd5DXniqxh4OfTIX9qZw==
X-Received: by 2002:a05:600c:2214:b0:40c:3308:3aec with SMTP id z20-20020a05600c221400b0040c33083aecmr54376wml.132.1702047140270;
        Fri, 08 Dec 2023 06:52:20 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id r9-20020a05600c458900b0040b3e79bad3sm3088264wmo.40.2023.12.08.06.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 06:52:19 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Christian Marangi <ansuelsmth@gmail.com>
Subject: [net-next PATCH v4 12/13] net: phy: at803x: move at8035 specific DT parse to dedicated probe
Date: Fri,  8 Dec 2023 15:51:59 +0100
Message-Id: <20231208145200.25162-13-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231208145200.25162-1-ansuelsmth@gmail.com>
References: <20231208145200.25162-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move at8035 specific DT parse for clock out frequency to dedicated probe
to make at803x probe function more generic.

This is to tidy code and no behaviour change are intended.

Detection logic is changed, we check if the clk 25m mask is set and if
it's not zero, we assume the qca,clk-out-frequency property is set.

The property is checked in the generic at803x_parse_dt called by
at803x_probe.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/phy/at803x.c | 60 +++++++++++++++++++++++++++-------------
 1 file changed, 41 insertions(+), 19 deletions(-)

diff --git a/drivers/net/phy/at803x.c b/drivers/net/phy/at803x.c
index c08d3c4f097f..da3506fd19c8 100644
--- a/drivers/net/phy/at803x.c
+++ b/drivers/net/phy/at803x.c
@@ -638,23 +638,6 @@ static int at803x_parse_dt(struct phy_device *phydev)
 
 		priv->clk_25m_reg |= FIELD_PREP(AT803X_CLK_OUT_MASK, sel);
 		priv->clk_25m_mask |= AT803X_CLK_OUT_MASK;
-
-		/* Fixup for the AR8030/AR8035. This chip has another mask and
-		 * doesn't support the DSP reference. Eg. the lowest bit of the
-		 * mask. The upper two bits select the same frequencies. Mask
-		 * the lowest bit here.
-		 *
-		 * Warning:
-		 *   There was no datasheet for the AR8030 available so this is
-		 *   just a guess. But the AR8035 is listed as pin compatible
-		 *   to the AR8030 so there might be a good chance it works on
-		 *   the AR8030 too.
-		 */
-		if (phydev->drv->phy_id == ATH8030_PHY_ID ||
-		    phydev->drv->phy_id == ATH8035_PHY_ID) {
-			priv->clk_25m_reg &= AT8035_CLK_OUT_MASK;
-			priv->clk_25m_mask &= AT8035_CLK_OUT_MASK;
-		}
 	}
 
 	ret = of_property_read_u32(node, "qca,clk-out-strength", &strength);
@@ -1635,6 +1618,45 @@ static int at8031_config_intr(struct phy_device *phydev)
 	return at803x_config_intr(phydev);
 }
 
+static int at8035_parse_dt(struct phy_device *phydev)
+{
+	struct at803x_priv *priv = phydev->priv;
+
+	/* Mask is set by the generic at803x_parse_dt
+	 * if property is set. Assume property is set
+	 * with the mask not zero.
+	 */
+	if (priv->clk_25m_mask) {
+		/* Fixup for the AR8030/AR8035. This chip has another mask and
+		 * doesn't support the DSP reference. Eg. the lowest bit of the
+		 * mask. The upper two bits select the same frequencies. Mask
+		 * the lowest bit here.
+		 *
+		 * Warning:
+		 *   There was no datasheet for the AR8030 available so this is
+		 *   just a guess. But the AR8035 is listed as pin compatible
+		 *   to the AR8030 so there might be a good chance it works on
+		 *   the AR8030 too.
+		 */
+		priv->clk_25m_reg &= AT8035_CLK_OUT_MASK;
+		priv->clk_25m_mask &= AT8035_CLK_OUT_MASK;
+	}
+
+	return 0;
+}
+
+/* AR8030 and AR8035 shared the same special mask for clk_25m */
+static int at8035_probe(struct phy_device *phydev)
+{
+	int ret;
+
+	ret = at803x_probe(phydev);
+	if (ret)
+		return ret;
+
+	return at8035_parse_dt(phydev);
+}
+
 static int qca83xx_config_init(struct phy_device *phydev)
 {
 	u8 switch_revision;
@@ -2107,7 +2129,7 @@ static struct phy_driver at803x_driver[] = {
 	PHY_ID_MATCH_EXACT(ATH8035_PHY_ID),
 	.name			= "Qualcomm Atheros AR8035",
 	.flags			= PHY_POLL_CABLE_TEST,
-	.probe			= at803x_probe,
+	.probe			= at8035_probe,
 	.config_aneg		= at803x_config_aneg,
 	.config_init		= at803x_config_init,
 	.soft_reset		= genphy_soft_reset,
@@ -2128,7 +2150,7 @@ static struct phy_driver at803x_driver[] = {
 	.phy_id			= ATH8030_PHY_ID,
 	.name			= "Qualcomm Atheros AR8030",
 	.phy_id_mask		= AT8030_PHY_ID_MASK,
-	.probe			= at803x_probe,
+	.probe			= at8035_probe,
 	.config_init		= at803x_config_init,
 	.link_change_notify	= at803x_link_change_notify,
 	.set_wol		= at803x_set_wol,
-- 
2.40.1



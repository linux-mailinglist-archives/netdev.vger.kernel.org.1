Return-Path: <netdev+bounces-55329-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E6380A63F
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 15:53:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1A3E1F21461
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 14:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8185A1E538;
	Fri,  8 Dec 2023 14:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fMS8AMWu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3535C35B1;
	Fri,  8 Dec 2023 06:52:14 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-40c0f3a7717so24649315e9.1;
        Fri, 08 Dec 2023 06:52:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702047132; x=1702651932; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SKdApVa1/ad6QR0kGy/pXmtTCWwb2YcJRtG4h3T2bUY=;
        b=fMS8AMWuOCa8yU1df2vi/+X0nowQfPxHdBkEworfzHRmYXd99vc4clBYy3WyM5nIoH
         Di5CVXTufCJMwc2bpq0pw98QldBiJIMegvhb7iJVtdZKB3bPNLO3YwUQx0pNMwPinIcz
         tvOUxqAS7jzzbu4AT+JHYClX38SUFNrOVbYpjA2cKD7SAlRp58LuPf/nSz336ra0WxMU
         FVu9hiBKWoDE+4ZQwghpoT7+6weIynO7Ut0XS6pJXAaQK5K6MVhFNqJX+EeXiZKwrBkL
         NOZVYWnds207MGhvbjw5egcbH3gFiunJ06ZODcvmgnZPBi0QGagg1K5tawthEaqzlK6v
         4lSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702047132; x=1702651932;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SKdApVa1/ad6QR0kGy/pXmtTCWwb2YcJRtG4h3T2bUY=;
        b=bJZJ4thDxrJDWYkJlA6uOPamihu/B3jPFIRgaOs+oH8LFP4mNWUgFselalrVdfhNXu
         T4iGEPeRFj94uz2n857T1tf3aOMxPHKE/L4Jzl0PDt+5PLHjHc+sEWA7iJhfkSMWgCD6
         AeZyPKfKYel/PJPJkbAuie4pxpnhSG9dk6GH1VU39VGpAXS7NNwhryaKTIYFS4Ops5Np
         Cvtd5sDAQrCPGRJVZeKNWY/ttPezoKCQrGLQnMcbQcOpFJS56axPKP7AWDWcczGv0EIJ
         e3g8RzKylwcM774xUqyPSUw+zwNrgZ9xndWnGYX4or8sqt/KoooGy8FEfpXSy7TJbzRo
         IYJA==
X-Gm-Message-State: AOJu0YymTPCbLb0ZWU2dEgqFXI/5KlTYp35y1lbuIkJ4/Q3UWp8AXlpA
	VLvHMRTeMHkbr1FgfDvnaiw=
X-Google-Smtp-Source: AGHT+IF+dqlzPLibBM3YHFIrfF8fdOtcPcNS2v/dAzKrDQOs162Ja2IE5onrQ17NY/uibq6xI7oUfg==
X-Received: by 2002:a1c:740d:0:b0:40b:5e22:2f6 with SMTP id p13-20020a1c740d000000b0040b5e2202f6mr27184wmc.98.1702047132401;
        Fri, 08 Dec 2023 06:52:12 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id r9-20020a05600c458900b0040b3e79bad3sm3088264wmo.40.2023.12.08.06.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 06:52:11 -0800 (PST)
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
Subject: [net-next PATCH v4 05/13] net: phy: at803x: move specific DT option for at8031 to specific probe
Date: Fri,  8 Dec 2023 15:51:52 +0100
Message-Id: <20231208145200.25162-6-ansuelsmth@gmail.com>
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

Move specific DT options for at8031 to specific probe to tidy things up
and make at803x_parse_dt more generic.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/phy/at803x.c | 55 ++++++++++++++++++++++------------------
 1 file changed, 31 insertions(+), 24 deletions(-)

diff --git a/drivers/net/phy/at803x.c b/drivers/net/phy/at803x.c
index fa412a4e080d..5694c2667b4d 100644
--- a/drivers/net/phy/at803x.c
+++ b/drivers/net/phy/at803x.c
@@ -825,30 +825,6 @@ static int at803x_parse_dt(struct phy_device *phydev)
 		}
 	}
 
-	/* Only supported on AR8031/AR8033, the AR8030/AR8035 use strapping
-	 * options.
-	 */
-	if (phydev->drv->phy_id == ATH8031_PHY_ID) {
-		if (of_property_read_bool(node, "qca,keep-pll-enabled"))
-			priv->flags |= AT803X_KEEP_PLL_ENABLED;
-
-		ret = at8031_register_regulators(phydev);
-		if (ret < 0)
-			return ret;
-
-		ret = devm_regulator_get_enable_optional(&phydev->mdio.dev,
-							 "vddio");
-		if (ret) {
-			phydev_err(phydev, "failed to get VDDIO regulator\n");
-			return ret;
-		}
-
-		/* Only AR8031/8033 support 1000Base-X for SFP modules */
-		ret = phy_sfp_probe(phydev, &at803x_sfp_ops);
-		if (ret < 0)
-			return ret;
-	}
-
 	return 0;
 }
 
@@ -1582,6 +1558,30 @@ static int at803x_cable_test_start(struct phy_device *phydev)
 	return 0;
 }
 
+static int at8031_parse_dt(struct phy_device *phydev)
+{
+	struct device_node *node = phydev->mdio.dev.of_node;
+	struct at803x_priv *priv = phydev->priv;
+	int ret;
+
+	if (of_property_read_bool(node, "qca,keep-pll-enabled"))
+		priv->flags |= AT803X_KEEP_PLL_ENABLED;
+
+	ret = at8031_register_regulators(phydev);
+	if (ret < 0)
+		return ret;
+
+	ret = devm_regulator_get_enable_optional(&phydev->mdio.dev,
+						 "vddio");
+	if (ret) {
+		phydev_err(phydev, "failed to get VDDIO regulator\n");
+		return ret;
+	}
+
+	/* Only AR8031/8033 support 1000Base-X for SFP modules */
+	return phy_sfp_probe(phydev, &at803x_sfp_ops);
+}
+
 static int at8031_probe(struct phy_device *phydev)
 {
 	int ret;
@@ -1590,6 +1590,13 @@ static int at8031_probe(struct phy_device *phydev)
 	if (ret)
 		return ret;
 
+	/* Only supported on AR8031/AR8033, the AR8030/AR8035 use strapping
+	 * options.
+	 */
+	ret = at8031_parse_dt(phydev);
+	if (ret)
+		return ret;
+
 	/* Disable WoL in 1588 register which is enabled
 	 * by default
 	 */
-- 
2.40.1



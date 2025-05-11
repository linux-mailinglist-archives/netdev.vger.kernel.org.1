Return-Path: <netdev+bounces-189568-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CF6DAB2A62
	for <lists+netdev@lfdr.de>; Sun, 11 May 2025 20:41:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7CEA3AE162
	for <lists+netdev@lfdr.de>; Sun, 11 May 2025 18:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E9A2262FD9;
	Sun, 11 May 2025 18:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D3hgDRFW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4E72609EE;
	Sun, 11 May 2025 18:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746988827; cv=none; b=ETyR1dNK5d5webIhF3FnnnjWZgRJn3TR/aXLVjJDGYqznkvLokMmksnMEzXrrHZD9ts7KjtULmts3d7yigv08SFxq5+QM14Or9u9t8umqyBinWBHu0y+q3zJ/fCTv+gJvLyk8EQbS0RbuBFF+TphQCK2sTCi94nKCC0ZGVRHjAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746988827; c=relaxed/simple;
	bh=JMeorUGvSZqGdgT8eqo1GtEKe7cqqq8Xmt0oOBKX1/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TmhCbrywhZGlAJtqp0qY3Y+JRO07I1FHPMZGMa9k2pdA6MFYBSxd4HktRgvLWZdkXg02+NujE7GBBM6tjOr+qZ2g2fHsMwukhpQE0yz7Mj40chkYjEXjDEN5WaGMIGfU66wFHPTSo+CE5JvDIfj5XgvKzjs6zDus7HYbjvt6QaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D3hgDRFW; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43cf06eabdaso37728825e9.2;
        Sun, 11 May 2025 11:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746988823; x=1747593623; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lTQhXTyWA+dzynRUt+APtRqGDF+FBiwvMZ8BjXEGJS4=;
        b=D3hgDRFWDcZB10GJyPqH1QQhBp/k19WXDollwru/bYun4nU9Judkx9rUNo7jAlP1+E
         ZBXJX8/+JxWPi0CeWIMc2qyvr/nQGMdIqExlG3ruhSXqwVxxfUlIyRLx2bO9WkD8qkm6
         bf5WSpOwNEs13hi/NEJeEetxF/Mlc7pMojB38xNxjfGDJmvh5lAW/dq4jS0O1tECk+6v
         NYNjSdKaHJkVe/cBKRBMyS6twSWvCvuMxTmVHSX2IDaqQxKbd26P3TYyeH6zIG9G4lw2
         c30Tv8Tyk3HkoZZGS873X19k+h4Qld4hIeWQ9lDp+IpBra8JUqUtymwMz1opETKea5NY
         Dq4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746988823; x=1747593623;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lTQhXTyWA+dzynRUt+APtRqGDF+FBiwvMZ8BjXEGJS4=;
        b=aspjIGcVB0uJnQmHSN6h4K2lRFkGtYDKsU7VQv1JvLUS6Np93bQEtFjLZptOo3PTJQ
         hKOdnptrCDMgqsVwFngOGbvMxnXcKfrzcYqQ3/f9sVBWfTHx5KUgD2k0gsAA9PKXRex4
         cUWLXa/vVYCWxofN7PpkAjzMhCZMC/LzP93cyMwiFwN4mGcIvLP6jFzhMeadcYUjybDz
         FYEsHDFdjxe4H9Mp/OuHZcT2oGGSJLAG2dRD2Rib0ZtQ4qvtswFaIOtV4EDTUX+pxe4g
         rg1WXo60bb9HYkeoUogsyWhOvBYSyBHJqZ98/XanBR8DopVB/nowehcin4SOqlV9UbM/
         X6PA==
X-Forwarded-Encrypted: i=1; AJvYcCUz+ha8vo9Nz3F8VSazEcl/5IL4WEnS7Uq/egxDN4u7hAEneTYr10vEERsf3dQkjALXYym/8yHnpHLqGfA6@vger.kernel.org, AJvYcCVZyQlgeKm8juiTJx7JSyNBjSFVbGRS/DBz79nRTt0/S/G2g7Hc8RacluEMto02YWn9ruq25ERq@vger.kernel.org, AJvYcCWyx1An2euobkpji73AQqLGYXPGUxDEWPZ2rKYbkNdfrvKx5C9VCyix1xRJti4p7/tjLs9CiRFlnwH3@vger.kernel.org
X-Gm-Message-State: AOJu0YwBjsde/Mu+akCAn12TZCshoTT4aMspwjZLz6m/AXj+BPR70Si4
	Zrjr1aghp6hSuJ71t5BaLUIM8PA2RsGPy5rue0NqhhnQtT3zWDut
X-Gm-Gg: ASbGncu+t/m2r06O7j+QAUz8Sy0A8U+Z7jaiaRWTkKEh/ASccao5+/3puxoClqiqFRa
	hsz3TUaTih1y31/z74GCdzZS4LsaXYJzCFRReOavra7cOVlMSY/gUd5Btkpe0LX6tZUP3K+i2/v
	YpOl9CNd79JomGnKygMEl8aMrwRObbALM0Td/5QAza9uaem8GHtwPFKGdoXCwX7ltuYaSflejJl
	/jM50LZTcvlhCZBx8NUUWtG39iPb508XTss71PWybRTRA+QqmSYYOPvPVVC2PoNbn8jiAe+nZ5c
	lHgc8XFf/HhFMNIQrbqI5+akKGg9V0BhxWazXcdBgDTeJ9g/3giO/nMgxpk8NatyPqfVGYZjY5/
	7gGUV0SurAuwxg+3WF81l
X-Google-Smtp-Source: AGHT+IGaWWznm1g3/EE3XRPbpAWq5hRI4HNyqj7w1FypcqerY4CKOJ5dbZnmsHxw3yLaCugp4W2Dzw==
X-Received: by 2002:a05:600c:a343:b0:43d:1b74:e89a with SMTP id 5b1f17b1804b1-442d6d3e238mr97781515e9.9.1746988823299;
        Sun, 11 May 2025 11:40:23 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-442d76b7fd6sm61020615e9.0.2025.05.11.11.40.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 May 2025 11:40:22 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Andrei Botila <andrei.botila@oss.nxp.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Michael Klein <michael@fossekall.de>,
	Daniel Golle <daniel@makrotopia.org>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Subject: [net-next PATCH v9 3/6] net: phy: nxp-c45-tja11xx: simplify .match_phy_device OP
Date: Sun, 11 May 2025 20:39:27 +0200
Message-ID: <20250511183933.3749017-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250511183933.3749017-1-ansuelsmth@gmail.com>
References: <20250511183933.3749017-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Simplify .match_phy_device OP by using a generic function and using the
new phy_id PHY driver info instead of hardcoding the matching PHY ID
with new variant for macsec and no_macsec PHYs.

Also make use of PHY_ID_MATCH_MODEL macro and drop PHY_ID_MASK define to
introduce phy_id and phy_id_mask again in phy_driver struct.

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/phy/nxp-c45-tja11xx.c | 45 ++++++++++++++-----------------
 1 file changed, 20 insertions(+), 25 deletions(-)

diff --git a/drivers/net/phy/nxp-c45-tja11xx.c b/drivers/net/phy/nxp-c45-tja11xx.c
index 22921b192a8b..4c6d905f0a9f 100644
--- a/drivers/net/phy/nxp-c45-tja11xx.c
+++ b/drivers/net/phy/nxp-c45-tja11xx.c
@@ -19,7 +19,6 @@
 
 #include "nxp-c45-tja11xx.h"
 
-#define PHY_ID_MASK			GENMASK(31, 4)
 /* Same id: TJA1103, TJA1104 */
 #define PHY_ID_TJA_1103			0x001BB010
 /* Same id: TJA1120, TJA1121 */
@@ -1966,32 +1965,24 @@ static int nxp_c45_macsec_ability(struct phy_device *phydev)
 	return macsec_ability;
 }
 
-static int tja1103_match_phy_device(struct phy_device *phydev,
-				    const struct phy_driver *phydrv)
+static int tja11xx_no_macsec_match_phy_device(struct phy_device *phydev,
+					      const struct phy_driver *phydrv)
 {
-	return phy_id_compare(phydev->phy_id, PHY_ID_TJA_1103, PHY_ID_MASK) &&
-	       !nxp_c45_macsec_ability(phydev);
-}
+	if (!phy_id_compare(phydev->phy_id, phydrv->phy_id,
+			    phydrv->phy_id_mask))
+		return 0;
 
-static int tja1104_match_phy_device(struct phy_device *phydev,
-				    const struct phy_driver *phydrv)
-{
-	return phy_id_compare(phydev->phy_id, PHY_ID_TJA_1103, PHY_ID_MASK) &&
-	       nxp_c45_macsec_ability(phydev);
+	return !nxp_c45_macsec_ability(phydev);
 }
 
-static int tja1120_match_phy_device(struct phy_device *phydev,
-				    const struct phy_driver *phydrv)
+static int tja11xx_macsec_match_phy_device(struct phy_device *phydev,
+					   const struct phy_driver *phydrv)
 {
-	return phy_id_compare(phydev->phy_id, PHY_ID_TJA_1120, PHY_ID_MASK) &&
-	       !nxp_c45_macsec_ability(phydev);
-}
+	if (!phy_id_compare(phydev->phy_id, phydrv->phy_id,
+			    phydrv->phy_id_mask))
+		return 0;
 
-static int tja1121_match_phy_device(struct phy_device *phydev,
-				    const struct phy_driver *phydrv)
-{
-	return phy_id_compare(phydev->phy_id, PHY_ID_TJA_1120, PHY_ID_MASK) &&
-	       nxp_c45_macsec_ability(phydev);
+	return nxp_c45_macsec_ability(phydev);
 }
 
 static const struct nxp_c45_regmap tja1120_regmap = {
@@ -2064,6 +2055,7 @@ static const struct nxp_c45_phy_data tja1120_phy_data = {
 
 static struct phy_driver nxp_c45_driver[] = {
 	{
+		PHY_ID_MATCH_MODEL(PHY_ID_TJA_1103),
 		.name			= "NXP C45 TJA1103",
 		.get_features		= nxp_c45_get_features,
 		.driver_data		= &tja1103_phy_data,
@@ -2085,9 +2077,10 @@ static struct phy_driver nxp_c45_driver[] = {
 		.get_sqi		= nxp_c45_get_sqi,
 		.get_sqi_max		= nxp_c45_get_sqi_max,
 		.remove			= nxp_c45_remove,
-		.match_phy_device	= tja1103_match_phy_device,
+		.match_phy_device	= tja11xx_no_macsec_match_phy_device,
 	},
 	{
+		PHY_ID_MATCH_MODEL(PHY_ID_TJA_1103),
 		.name			= "NXP C45 TJA1104",
 		.get_features		= nxp_c45_get_features,
 		.driver_data		= &tja1103_phy_data,
@@ -2109,9 +2102,10 @@ static struct phy_driver nxp_c45_driver[] = {
 		.get_sqi		= nxp_c45_get_sqi,
 		.get_sqi_max		= nxp_c45_get_sqi_max,
 		.remove			= nxp_c45_remove,
-		.match_phy_device	= tja1104_match_phy_device,
+		.match_phy_device	= tja11xx_macsec_match_phy_device,
 	},
 	{
+		PHY_ID_MATCH_MODEL(PHY_ID_TJA_1120),
 		.name			= "NXP C45 TJA1120",
 		.get_features		= nxp_c45_get_features,
 		.driver_data		= &tja1120_phy_data,
@@ -2134,9 +2128,10 @@ static struct phy_driver nxp_c45_driver[] = {
 		.get_sqi		= nxp_c45_get_sqi,
 		.get_sqi_max		= nxp_c45_get_sqi_max,
 		.remove			= nxp_c45_remove,
-		.match_phy_device	= tja1120_match_phy_device,
+		.match_phy_device	= tja11xx_no_macsec_match_phy_device,
 	},
 	{
+		PHY_ID_MATCH_MODEL(PHY_ID_TJA_1120),
 		.name			= "NXP C45 TJA1121",
 		.get_features		= nxp_c45_get_features,
 		.driver_data		= &tja1120_phy_data,
@@ -2159,7 +2154,7 @@ static struct phy_driver nxp_c45_driver[] = {
 		.get_sqi		= nxp_c45_get_sqi,
 		.get_sqi_max		= nxp_c45_get_sqi_max,
 		.remove			= nxp_c45_remove,
-		.match_phy_device	= tja1121_match_phy_device,
+		.match_phy_device	= tja11xx_macsec_match_phy_device,
 	},
 };
 
-- 
2.48.1



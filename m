Return-Path: <netdev+bounces-178573-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F087FA779FC
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 13:48:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A5B3188FDD2
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 11:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB6DA202F95;
	Tue,  1 Apr 2025 11:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DQat3XwS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A75F202C2D;
	Tue,  1 Apr 2025 11:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743508013; cv=none; b=M7J9r03qBEqRZRlAF1k+yyJrVsqjisgrXd+wyjlN03yrbbs7tnllgFz7i3N/2dfYr3ptYAjtZiREFrQV33O9JuwpW6QQ6ochnDrc8HDFTE7JebQ9FVyek4F+37nx+KK89gp5/ajCPd8sIIEbzvGYiD+1YQpgCfgtX709d8SRNPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743508013; c=relaxed/simple;
	bh=IujCQ9IoIZbeIWphTzYwK68VeGSRhaVRbzlwAfd7wwU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HRxxo5rgxjI1Xh/Vzfzh86hXlvNsVfeGuCejXZLvKxsg8BXnCSLZIJvlnxC6fWunYSPt53l3pU+d6GdbsyT19yLD33LmOoyi7sstIpVC1mOmdTfiAGHG1+e8nGgfAU9Kce9k/2oscADDNbUUr6OYgFMO94E5FnCmljtxgzXjzcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DQat3XwS; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4394a0c65fcso52570015e9.1;
        Tue, 01 Apr 2025 04:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743508010; x=1744112810; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C3/3eFl4jlQ6T50tlJqQU5aclw0PVg9d0gCXOGIE1ww=;
        b=DQat3XwSKF9IU3DZ5U4xrs08rLZlo6VLv33T+WTE51vQJ+/ldNOKdr0InOnnJxgAjx
         QUsr5DoY3gzzzzTRn0/j1bgSPLvWhNe+aEhrqoKeRgwTXnXFUUMW8gU0yI3Dc9Bu3tIr
         Kxa0oy8K32So3H9Oa6Sl7UGztHQVpkPeXjigYlX2rFQID4j80UIyxKnJMy0nRfwBSchZ
         oWPfFlLgJmWkkv3O+CdiGwsrrXjFT/d8lGr3VTt0xYhwPYGqyp/93367dy7Mh4hSunQN
         Ga3T/7z7nsQShUV791ui6s84IHsdrVnwjfAkbwNv5TXaw7mgNlQ9Jw5C0X49g1ntgk+8
         2emA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743508010; x=1744112810;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C3/3eFl4jlQ6T50tlJqQU5aclw0PVg9d0gCXOGIE1ww=;
        b=W11ArUwy2A46zvOfwdc9w4DDHTAr2bjBg0mEL8jjoRVXBuZk9cFTswN0J1hCJQ5i5P
         H2fjwRxCceBfC/jlnTouJ4mvsao+oFf6IvpoYJ2EOaXQYWGlr2QpaPCUikdu8vxrHJwV
         POhK6v6S1+WuLW5B/spbt524xpbCa+aOx8ILi8L9MqqYeb/mSdH5jHktgrbfFZJ0hpVZ
         YQn5RPHl30kOhb7cwenaysZV7u9AcRBs7wW7HRZFaEj+c3gaLHvsxxtOmSC5s+GhcKgq
         FXmleKvUGSrPp5D0ak8+9EhEfhA7fZ5nMr6qlS6YQ59XGI4hGf442O7Oqi64/fFiJaZQ
         lv7Q==
X-Forwarded-Encrypted: i=1; AJvYcCV3Hr543lPtgnp6TuNzPdoyq+Dx2YLXAVat1JEiG16LW5NrJ09kJ+duoaT5fBxLIKCn6Hfnv2zPwkGa@vger.kernel.org, AJvYcCVAha87yFv2mhNb9it72bTWBnAOHS9285cmHxZL5TMVA8v6pKsAkFHMe/ZcIhbLgsenSPU7wtPX@vger.kernel.org, AJvYcCXf8OUSR1U28rFe6zxUk4o0XFVb6XA2kLUKJUgmTxKsX46mGxadSeUEqgEAv/3A0FEJnp5ihA0SSeyYMlvT@vger.kernel.org
X-Gm-Message-State: AOJu0YyEM+J1h0YoRe+SVgpqrfLDDbS2uJj8LZiEzQ4YiwToYSswbzcC
	jjuhN8tk+y7YUkXZ0Uvgbt8SSc6GltJWL7taf5ny2uDajg8M6Xn0
X-Gm-Gg: ASbGncsLHpbZQnC/I04XI/ZGy8UcnknQBuuhp6ssGApt6wxFdW1b9bJteOggWkVKBYL
	rD+5DQmpxP36tXAdXo3AKgK2mw8UmNhHWIKqR6muZfQRwikCdiWDNayfs2cGefJCyxQY/zT0ewd
	85A6Kd4EkiQTBiLTpSwv4MtlJ6ZRKYYX0v6y05eV8qzEyE9iCm+WKu8i8u3mZGL/igX7OSnd6ES
	WWaMlE6qt8mqH1GtPszAEB+m3yfknI6nilOHsY8ERN/qebiT12Gg4OeACnWOC5tWewOCcx48OcZ
	xOnpZbmtUhz78i2a7X509OKOud6tUyRj/+hBOKU7WvZwyRhygJTqoHdkuZUcGvmeDmQcaeERwep
	eXAO+a4WQcdqFZA==
X-Google-Smtp-Source: AGHT+IGzStcsNM0lTrd6CNJ5/kLN7VXIH17cdBr6F9hmiGQss8AKVLI/EC1v3Gg1nJaG/xji9hBaPw==
X-Received: by 2002:a05:600c:4e48:b0:43d:3df:42d8 with SMTP id 5b1f17b1804b1-43eaa03e0c4mr19310025e9.6.1743508009646;
        Tue, 01 Apr 2025 04:46:49 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-43ead679894sm8148175e9.40.2025.04.01.04.46.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 04:46:49 -0700 (PDT)
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
	Daniel Golle <daniel@makrotopia.org>,
	Eric Woudstra <ericwouds@gmail.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [net-next RFC PATCH v5 3/6] net: phy: nxp-c45-tja11xx: simplify .match_phy_device OP
Date: Tue,  1 Apr 2025 13:46:04 +0200
Message-ID: <20250401114611.4063-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250401114611.4063-1-ansuelsmth@gmail.com>
References: <20250401114611.4063-1-ansuelsmth@gmail.com>
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

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/phy/nxp-c45-tja11xx.c | 45 ++++++++++++++-----------------
 1 file changed, 20 insertions(+), 25 deletions(-)

diff --git a/drivers/net/phy/nxp-c45-tja11xx.c b/drivers/net/phy/nxp-c45-tja11xx.c
index bc2b7cc0cebe..8880547c4bfa 100644
--- a/drivers/net/phy/nxp-c45-tja11xx.c
+++ b/drivers/net/phy/nxp-c45-tja11xx.c
@@ -19,7 +19,6 @@
 
 #include "nxp-c45-tja11xx.h"
 
-#define PHY_ID_MASK			GENMASK(31, 4)
 /* Same id: TJA1103, TJA1104 */
 #define PHY_ID_TJA_1103			0x001BB010
 /* Same id: TJA1120, TJA1121 */
@@ -1971,32 +1970,24 @@ static int nxp_c45_macsec_ability(struct phy_device *phydev)
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
@@ -2069,6 +2060,7 @@ static const struct nxp_c45_phy_data tja1120_phy_data = {
 
 static struct phy_driver nxp_c45_driver[] = {
 	{
+		PHY_ID_MATCH_MODEL(PHY_ID_TJA_1103),
 		.name			= "NXP C45 TJA1103",
 		.get_features		= nxp_c45_get_features,
 		.driver_data		= &tja1103_phy_data,
@@ -2090,9 +2082,10 @@ static struct phy_driver nxp_c45_driver[] = {
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
@@ -2114,9 +2107,10 @@ static struct phy_driver nxp_c45_driver[] = {
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
@@ -2139,9 +2133,10 @@ static struct phy_driver nxp_c45_driver[] = {
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
@@ -2164,7 +2159,7 @@ static struct phy_driver nxp_c45_driver[] = {
 		.get_sqi		= nxp_c45_get_sqi,
 		.get_sqi_max		= nxp_c45_get_sqi_max,
 		.remove			= nxp_c45_remove,
-		.match_phy_device	= tja1121_match_phy_device,
+		.match_phy_device	= tja11xx_macsec_match_phy_device,
 	},
 };
 
-- 
2.48.1



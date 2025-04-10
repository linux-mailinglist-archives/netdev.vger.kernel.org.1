Return-Path: <netdev+bounces-181169-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AAF51A83F97
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 11:56:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36B294A1416
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 09:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A7F126B2B6;
	Thu, 10 Apr 2025 09:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HmijmIrV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D1726B089;
	Thu, 10 Apr 2025 09:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744278925; cv=none; b=hyvhHYlZHFF2b80wcVUklrX9/yvYI3GcAjhUDWSqiRlQmQLMQFcQRME/KUCDxLMxkqUugkKBgnV/bWAVbn2sELJgwtndy3wcbnUIq/ssrTHh9d/Mh4aGA2UVJcHvBHVkFx7DfQ+aIaKg0kksP8oDDw8ie9YTevoeH/NS5jA1HAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744278925; c=relaxed/simple;
	bh=7xQBp2QUPKH5LroIbe0cwWDvJAfps7bphYShXYoPdIA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PutkyC4GBSCZx4B5bemA1svy1z1fq2cLzIv//vBjP1McmQ4rBec9eH/fwAjho30O3ZvkmcUfeaNU9dJHwQQmGwkX6NQwUUcsypwIDbmhPb8x/jSXUxdDruR95HOs/4ENFE6zWamaL4JMAatW9Vx+BrD3JbGOJl+W9z3uhQ0T7oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HmijmIrV; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43cfecdd8b2so4947845e9.2;
        Thu, 10 Apr 2025 02:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744278921; x=1744883721; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zzy/xEoKoVUE89Yht/hd4iXTKNGhjve+WY3rZvIu844=;
        b=HmijmIrVtw5tiPdZ+5GbSqh0J5ijUIP+VF8PJ6pQfY77xktPBEnbyERBPAfF3XR2Sf
         /nf11nHaAfpqF5QeKKh1nmisSla3zGqCzjvu+fGeQSrq47QVQlMGY1MIq8WlN6tUN1Tw
         5PIDgaKldh4QadTOo8yLxeLG1fzDprDH9/Ggn39SPe6exubRqEIkDI8i4lT9lPs4ZtXG
         Nid5wfsQflkSx2KvDHehsEknRmPfpJKn7vZLnXIDzFjhapbtqpW6THW7EyNc7PvIcQ92
         oEMV1Ck1rPZei0eJHKKXRu01yBN6mwEp10hcy8EVURDkKst4104+YT6duGE0SXAVMoJ/
         APGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744278921; x=1744883721;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zzy/xEoKoVUE89Yht/hd4iXTKNGhjve+WY3rZvIu844=;
        b=bSeNbqBRpaTf5faP7GeUuAIpOQ9Mwo9OKCINRjAPd+/s4K1KOJd0WfCH41wGQTRMMq
         J6BbF8WrqFL0F9RJD6dXxnmX7UM2jVRe0195j4HO+OcR/85zNEiMwzESxkOMXzyPPT/z
         WSffAPrlmw5e0MJ90Mgiay2nIOZIKAvK+GgTy3DaeZLy8DHcBng0guQqrAshnonrGeL5
         OSyjDMA13ak4UBzNH0FKWhDGLj7jNzGpF6iGwoboMqGZZnkuv9XzKZsMJkHV8+CLuk0x
         uasKg/rtDEcnJQKpKRUWH58y3XvS3owhXgXzDXEKSAK5ABkQXt95Yx0Kq+JzIvyq4Jle
         TSoQ==
X-Forwarded-Encrypted: i=1; AJvYcCVSz1OdGPXBgKTdCKM/EDqf2KcObc0k1C0np3K88CQLSXyYkDm70uwxaHaK2x6276/5FPYdZcmXxHhn@vger.kernel.org, AJvYcCWlgDn3B/sgP1fEQ9VsyC4uis+lgQk5RS8zVZv0EoGZMT2K8YDJJvagD6Xf6wSbz1/79dmnSF+9@vger.kernel.org
X-Gm-Message-State: AOJu0YziW8v0W0JUmUk9uftMkLzYb8LINABY50QtRG5aaZXBGA1tEA/d
	mP8MBt7YTLXZszB4iILBtmNr/VEapsA5cufQ+2G6qNr+CjtPtpIG
X-Gm-Gg: ASbGncupxDYb6shwPU/wPbeJQVyKMl8kU1gj/Z+IWMGWqf/CLI/R7TzkoDwo84FNZBM
	CvHjToE7lw4gCtSe0q1iv3FtYo8Yi0HiM5t1e+jP9NVUsxsRc51ODGGfSLV7k00WcaShuwDbnp0
	TO75pWjr2D/YFubtqTiYeNhoYmS0312d3AcVriL2iQ3njqsagvgIp9tQ4pmKd0z5S7Ghs1vudId
	+9cjlUNbdYxRiQdEAiWnakd1bP7P/gfs6K+U6v4tYb0Xk5YSIu49Cvaj2QnWqOYvPV+ACHT1sFn
	Lvo+R2ThWTKh9ucXeDujJ8+tyt3SpRlV8BFhblm8cWSy4FBvUrAJ8ePJC7zARf9ZogIP35K8rg6
	QOPfdP63Cag==
X-Google-Smtp-Source: AGHT+IFjil7/kUSDgNa+OJqBGEden9dXkDXVyutyGFfj+PnQTEVWb34tJZU+7qweW+TIJFqsUuy7lA==
X-Received: by 2002:a05:600c:3ac4:b0:43c:f5fe:5c26 with SMTP id 5b1f17b1804b1-43f2fdcd138mr16455925e9.4.1744278921297;
        Thu, 10 Apr 2025 02:55:21 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-43f233a2f71sm45404425e9.15.2025.04.10.02.55.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 02:55:20 -0700 (PDT)
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
	Eric Woudstra <ericwouds@gmail.com>,
	Daniel Golle <daniel@makrotopia.org>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.or
Cc: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Subject: [net-next PATCH v7 3/6] net: phy: nxp-c45-tja11xx: simplify .match_phy_device OP
Date: Thu, 10 Apr 2025 11:53:33 +0200
Message-ID: <20250410095443.30848-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250410095443.30848-1-ansuelsmth@gmail.com>
References: <20250410095443.30848-1-ansuelsmth@gmail.com>
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



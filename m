Return-Path: <netdev+bounces-179927-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5502A7EE9E
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 22:11:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4FB0B7A6CF0
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 20:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 479BF224225;
	Mon,  7 Apr 2025 20:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EpNdEBSA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23FF522258F;
	Mon,  7 Apr 2025 20:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744056611; cv=none; b=iBlH/7gGCMsuL9BT2+E2BaVrMSIRVJadzDHBOsRtRr/SC3kMNPlH2bnx5iwMC4H2TknQtZTwG5RZu9/UuHkcOsBZttVv9j6abuNBGCE4hdWM52A9+Q9wQrNdctsc/T0gwUGH2V9F4LpxTMXZzhsY2K6iZmGWy3zKv4TV5iUyfgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744056611; c=relaxed/simple;
	bh=7xQBp2QUPKH5LroIbe0cwWDvJAfps7bphYShXYoPdIA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CUf9/gY3scA4iJLfRiQI86/FIF7sdNBpSkuOXfGAEKBhN+NXbRlhMELX1qYXv2yP4bxm0nZGlzeme4kdXGX1w89G5gt8bjJZOCXtgSaVfsWQ1F40zyAsWEbj2ojd75TtuFjCgldqR1EwiRli27w/HC4RDrVaFOOvv8uVVmWaE0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EpNdEBSA; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-39c0dfba946so3009680f8f.3;
        Mon, 07 Apr 2025 13:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744056607; x=1744661407; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zzy/xEoKoVUE89Yht/hd4iXTKNGhjve+WY3rZvIu844=;
        b=EpNdEBSA9HKg/VwbWr5q/3oyOnYzwyZ7dCLg+WK6+Bm6ORAk4fJ/X0pp67sH19JQ4H
         lWzI/7nwvc6BVb/v6rv3ero42oX7RaSjmGHNFN2NgkoqShRa3IJ2ob2iCZaLulFNRB4q
         LrHj4LneXsNtltfYl5ktngms11Zz1duciRhdHvm4MyxMLWH53dC7Lx/Eaq9Liic5PTZn
         qTOy1mWEEhRddDe3v29A+YzYWTi0l36MLjbN3EyXWEgdlWRCmBWopujrbFSItvvhlLBz
         bUBYRJW6SiWd6SlKfYPUY9YjtMuo1DafsSCCi/5iYE95hcBZn3Ctnw6analhGbGghwjG
         e5YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744056607; x=1744661407;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zzy/xEoKoVUE89Yht/hd4iXTKNGhjve+WY3rZvIu844=;
        b=wCCm+TqULUm3rrzUve4Q3PhjKt8oQ9Zz2oaqt5D+raPSVRb/2BVelMxZO6qjAnOQxh
         +WBG8ivyaGaMz1WroWIDULfertxg0q18jFY7gREKlXwAjbfp0aT6D4FzbzURZWUfP7Bo
         9GcdWTl0IpseeEbqBXnKhrE6q9vQo8bZFtp0Zac41HEOBHzX+aAsEsssTvJ+7Klq/bko
         R7WIUHsaWXh2N6rBfBy1ovNtPWJQ60jRSAZhyt7PqzqGxYpbW9gDog4alK4FoUMuy2UZ
         LXyR++wGb5oRIo0LtjWD5YjmHxHjJZEh+7EoMNIgT6/bgADU3QxS1uqHy5QBX1U1boic
         cSfA==
X-Forwarded-Encrypted: i=1; AJvYcCU2Dg/6Y7Ht98XQnLB999v1YMrZXtGYVhvGCbWdB+eHnA93pwVhXeif/KTbQoqRzk7WdkY94fKXs/gpsM+0@vger.kernel.org, AJvYcCVQcuh//tSHywGk5zPH3k+rkw+9cQAr98Ki/YYxeU58qeMfLLQEDpJ9rqWAZ35XQbyDsW7wKhVOX1fP@vger.kernel.org, AJvYcCX5YMFPKawHI3aM7qhOTv5vaZ5LIJ3SJ3p7uwGBH7ERpsKwOszsXYS1p77efigBU7niVokdWXUj@vger.kernel.org
X-Gm-Message-State: AOJu0YzvvW2561RgHcmeAvLcljSfgYrIt+Ja63H3aZkTTwWHQZYTOnSU
	Ju2aSUnQCp1BI7aaKi9Jz4ipzrZ3PHDiTioPOs8xMXQ6D9ODeEZ2
X-Gm-Gg: ASbGncu350f+vj/23wYXwU35Dw5BnDpRs3GPqc22hjDR8HBzf2sZ3+u4Hb7aon6aWyk
	mE2uBe8Da+6BZb9mFg0P4GFOtM4Fdp4dj3edpvYM7wihXxktGaBPbTUXm6Mj51kK/QI/Sc4IXy5
	7/FPYAcdOfGxcHxJBvu1OoyjLwn+ETZRtJ0+syUf5GaOW+5m2+zRnzcoSCza+PhWms0hSW8q47v
	w+KlWEhLbnUQ03+8Cl88olvKOHEXcfNUUEm33aCBYX8iqkfHCJ0kTZ7EigOxygyfbVdvefNMhW1
	dWvY5h09CyffqCZwfs/DgfUuskzlxIXI7B+OBcOxxwJzFca3ZmqdSqPt9lBx7qTnJeNAR6oejVc
	6ofAYhTY8sLrZ9Q==
X-Google-Smtp-Source: AGHT+IENdkOhXlTcelGVWZ4wnjSdlpsvNIEZGI3bU8bCmAmah43GcF69EV2g/X8cTTn5Khn0LzC7Nw==
X-Received: by 2002:a05:6000:1847:b0:38d:de45:bf98 with SMTP id ffacd0b85a97d-39cb3575870mr10354302f8f.8.1744056607290;
        Mon, 07 Apr 2025 13:10:07 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-43ec34be2e6sm139605995e9.18.2025.04.07.13.10.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 13:10:06 -0700 (PDT)
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
Cc: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Subject: [net-next PATCH v6 3/6] net: phy: nxp-c45-tja11xx: simplify .match_phy_device OP
Date: Mon,  7 Apr 2025 22:09:23 +0200
Message-ID: <20250407200933.27811-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250407200933.27811-1-ansuelsmth@gmail.com>
References: <20250407200933.27811-1-ansuelsmth@gmail.com>
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



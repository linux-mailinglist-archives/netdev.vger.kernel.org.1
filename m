Return-Path: <netdev+bounces-189489-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00F1CAB2589
	for <lists+netdev@lfdr.de>; Sun, 11 May 2025 00:07:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8F7A4A17BB
	for <lists+netdev@lfdr.de>; Sat, 10 May 2025 22:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A05F21A931;
	Sat, 10 May 2025 22:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I8D4pbUO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2519B21421C;
	Sat, 10 May 2025 22:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746914795; cv=none; b=XWLvRwmbX+4oWadBPE42Pdfnyl69Ka3frumLpblyQbagBwhJA+8Ivrx3hjwrt4xe39KM6XNJdQ9DfUop73FtopeOSLA45YrVtZlcBgi7uWGs54N/nOdCJaCsQHA9XNMkTEeuR6thxwGcjNMZYQYmzQCPLK6QKloYsbo4CIH782M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746914795; c=relaxed/simple;
	bh=JMeorUGvSZqGdgT8eqo1GtEKe7cqqq8Xmt0oOBKX1/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oa5gLWF7R0s6twVtf2Ox1gfvRPZKwkzunR4ZJ/Iuvtum+tKQObm0IdBFsPz3DRsRFCmzcA0QeQgZpJskbCkNtxqVK9JPOpCTGMpKvfA1uqVcmfNVAqvqCk9ans8MLVg1NC5yiTp8qpVt4FjPIlc0fRxFCmsb1PsBf9vO/CE4/3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I8D4pbUO; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43cfba466b2so36824955e9.3;
        Sat, 10 May 2025 15:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746914791; x=1747519591; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lTQhXTyWA+dzynRUt+APtRqGDF+FBiwvMZ8BjXEGJS4=;
        b=I8D4pbUO1xgDyjGXmzkUlmRA5U/dOJbi9sW9zKr9r7OqPGviy223Z7l13rFwLopylc
         sXsGtwPEMD1w+EipW8846CEWxDnsNd0spOEb7cv8lTLbUYYz3SLlnyUiepxKqIz6Kl+s
         FDeSbdvjp+tOA4nD9bENhPs7SsT9psRIvY+CxdYgvyimWKdhiA5rP+Iprluj+ixZx+Bz
         RtHTq+dgHbQmKiT3iUAEptGiPqW/zNPrISV9JqeLOWpo+iww4VvO/fDtlbMlaAmlCyha
         SSGcF1E722ZzOWR3xlQB9Xp33IGB9C9qUaNrsy0kKFLAhLxSrc2pd2AdkMFpztGKm7qa
         CfQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746914791; x=1747519591;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lTQhXTyWA+dzynRUt+APtRqGDF+FBiwvMZ8BjXEGJS4=;
        b=Q5SRARYyXCWHPkxlmGV70iN/9sRA9xan7kBVXFLru9A48uQbtSGr5Dri1AuKYkWEFd
         ABNyw4lLmLx5gcalRKk660znj6nbPS7Ti6BkOqOe+jG5p4FpljEGtiBPOGRKGynfrWrl
         t7cr82La/1eQjEZTyQdNiIVMegLDbgc0gNf6Ix8VgwlSX5DYg+Ux/6IZYfPtLDNlww2R
         oCIYMazYzbrHldjY8lzLBd92x4El8b6dNtlbcp60o82g/bORZZmdG0m44GQ4I52+yqTV
         yeGXrkhed2pjYM6qZtoWWeDEp0tKtWNBqeieeRA83YcC95VhwoyJqe0lPSC5pP0NErSj
         i6Wg==
X-Forwarded-Encrypted: i=1; AJvYcCUJTwhhJKjvs01NcPVjGftMkNPCJ074/+tdEtlmBVvx3fQvs0oNW0V3N3jMKEgvz99rbuKn9Ud6KDAfI6O7@vger.kernel.org, AJvYcCUS+mC+pvomfdV1fluLJ1FQvHLvicWWkICu+7SzPcxJg0ZjFN/u9mypGddf3SQjpYSXaymK0Fj8@vger.kernel.org, AJvYcCVI60aVmqP24qDHnu/AjjkE3ugD7dw8pjv3GFEk8T6Jtpf7e/a4bPXfw+1luHSaeSqyVMUJpLSqEUSJ@vger.kernel.org
X-Gm-Message-State: AOJu0YxpDpoE3cc4yyJz9eYzd05hlQZ6pttjuhgNBzR3vuaOLYzm4r0e
	qPBiFuMjNLSofbJXQw6dsIAWoZd7zyrtlVav459FDooxfelJfl1v
X-Gm-Gg: ASbGnctHZwzjYz+IggEdjtU1insVgxI1vs0HQC6JQLSY7T5eyzYGAB4x90G99Wqm+ib
	qiA+aGl01xmLEo0m2kdEnSsyUVmbLRgMzVXcJGZXwV+pChO6q+E94THAgfJdP6XbkB8/Wx94Tmd
	h6w7NMby0cnR+0brsNzgn8n0fmdomgbPtoObzGPeUa2Oo4r7lOb8LSeY0H9OwZm9ZRpFqGPvqqd
	h+mHATlrSt6vDzTvcW5TAlNSwk7jTerxo8F6t5asPcK7yAFMiGcVZ8fhnAWS03bjpAQgEhkCtTV
	i6q9DvTenJoRMqpNPU/rRpWapgFgBYH7OhiKt+Ks1YAUq8mP68HrBvc3lusQ8etQbAplR9EP/J8
	425YzlxTgjnuWLR+a38HX
X-Google-Smtp-Source: AGHT+IEMpr4IM+1gHdXwXOvYgzrrKnDsZQ07G9lI3Q8nQlDmHeSR/Fhk5vDUzcEDM4dhzN04hvX4Tw==
X-Received: by 2002:a05:600c:608b:b0:43c:efed:732d with SMTP id 5b1f17b1804b1-442d6d6ab7cmr75401275e9.16.1746914791118;
        Sat, 10 May 2025 15:06:31 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3a1f5a2d2e9sm7477940f8f.75.2025.05.10.15.06.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 May 2025 15:06:30 -0700 (PDT)
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
Subject: [net-next PATCH v8 3/6] net: phy: nxp-c45-tja11xx: simplify .match_phy_device OP
Date: Sun, 11 May 2025 00:05:45 +0200
Message-ID: <20250510220556.3352247-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250510220556.3352247-1-ansuelsmth@gmail.com>
References: <20250510220556.3352247-1-ansuelsmth@gmail.com>
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



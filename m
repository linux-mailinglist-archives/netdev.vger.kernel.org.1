Return-Path: <netdev+bounces-178034-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E73D6A74115
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 23:46:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6E007A8C82
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 22:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38D621EF39D;
	Thu, 27 Mar 2025 22:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EL8KDoN3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8291EB5F5;
	Thu, 27 Mar 2025 22:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743115569; cv=none; b=n/pmOOAy2QMoDdvEO1wy3Oz2tNNzcZQmTOERbIMuWC9LSSEkBoLbba3hUEJktglGxHGHqCmdNxnz7rXQ9DAvyWqftk+nY+5n5L8kkMKIO97U9QB6TOzxfsauwSjtYnl1XKTVFHkdPyQO+Ds7rXG1qG/gBRsg0aFbKCEQN8vAdFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743115569; c=relaxed/simple;
	bh=xpJdp/7msPlC4qRCiTTaN1bxJjt6AabxpQvs/1zbhVw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UfLYSAoIhpFJ3duPZfvKYedsHxLPtTOLIgGVDia9n7MiXT1kpxgM0rfy8lfIZN65fhZZTWVx1PGN/L6RmToZcFyuatD9rcmrrwVBXaEQglEBShKDq7Qy1slVM7esP5CkuerzP82pTvaFHPOE6A86Vd8G3WSQGdOXwLcGz6IY9k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EL8KDoN3; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43d04dc73b7so17290715e9.3;
        Thu, 27 Mar 2025 15:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743115564; x=1743720364; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A9+Y/eUw63bgSIlI4ENZSv0yNN3VTD69ceTGNfVOp0g=;
        b=EL8KDoN3+2AdTcRH4UpeV6Th9uaG0qCFhq4StuImYSf76zfYy3nAPG2iFMY8zhtrBp
         nGHiTyZvkkZNJti8GwngwV949UzgLKXXnPDy5iRRNKRaanB4UzuXU1taXGwi30B+SsrV
         FEDMf/NSL2pfhJCGJcsSFzvcoFCyDXygv7Utfop/2JE5tgcmd4estj2OUZsOCyzZDFLg
         SbckX+8yjdZio1yj3+273TEu7hNnKMiQbTKZLZh+CicXGb51zJYfZGCQtHU/Nr4Go2fo
         ouGhuBh2psZzLpHwDn4TZ3XjQM1OZIdz6hjCGNVdust2+hV1DUptlULXfrY03lxubYyF
         ocZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743115564; x=1743720364;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A9+Y/eUw63bgSIlI4ENZSv0yNN3VTD69ceTGNfVOp0g=;
        b=U1J22pdhwmnamkNSWMvXENUs3YIeh5VaQiiCAPmotA2qLYVbtmnIVJ9uhWuUx0/XSk
         iLJHinaXmtUqGdGK5tIhoFcGpSkvxY38MGro61spJdmiWgd7eIpMa1rHOHZZdi7A7Oac
         +O8oOGWN+lvqvpTJVe9KvCtOKg/NDna8IqO4+FBOIQVw1feN2UWgTCXKq4dWegy5jmUl
         304x724km3KTKMtrWXFZn+4GYZQ216b2ZlqAbniblD7SP7YV/bWiCLwK9Y7Yz15tZrUC
         TX5b3wokXSN+jpGrpfvs8aukR60QpTo50rNp482ZDvgThNv/kr7evcKhwwORDgtxvBt5
         bMKg==
X-Forwarded-Encrypted: i=1; AJvYcCVDgv2njUAYPc+dKnmKG4k+7Z+/4WgZ4cIrkajSVOv4ooU0sNTsPU7mMUdSIVGbA8RLZmyMAhWJ@vger.kernel.org, AJvYcCVecMm5EtQV6is8BPYSLto3buynOdMmsbcSzTozE/zGzcQkc5SfiVJLO9zrXH4tGDJUtH2tnsNZEUcpfFYb@vger.kernel.org, AJvYcCXsYgaU+J8fbfws2FNyNwukLTpub4xDqC7iLvqz08umsmoE+hQ5TerB3izSGG/2Nxn4niJ9VEuNy/xE@vger.kernel.org
X-Gm-Message-State: AOJu0YyMUve04/Mvlf6mqS/otjsg1U1njuk03oU2OrLx2kvAO2AIcx6a
	kwt04zwY7yRMwgEHElsgymSkdEuGSE2Wm3NSAtyMnbyXjlo7B9xe
X-Gm-Gg: ASbGncsWhXi+R3BxTBfp3xG7bWQsVxkCJaAM/Y/YELvpdZLnj2EuTQgYArLsz5ifFdQ
	PAiCDnAAJoG/pRlJRKUAMDK6osjMCuBQZ2I/357PZOABXwwbQrLqNywj4sQnuVWPwQGL1nIiNBG
	XRBP0UP/ZseJ9yTSEM52WDT0RWc4qITLNxQ+iM8uI4+WkMdANy6/ckDL6QfeG1sD89YETluZx3o
	i17hLumt/P2goNkAOrB66oyFwwk5d2wDmwSAFaIiORA1RuQh3HjRsaQ5+wDxQ50kWyZV/a795W8
	m+QgDmcptJvY3GVPqt9Pk8y2rIKNOnxNBJOfttHzT+4mTaZI50uxCu/U0+HIT4xGHNc4MFf6go4
	+qmD/1SbZKcYHbw==
X-Google-Smtp-Source: AGHT+IEW6lvCZV6euE6B+VP6bLyAsCYsgQ70pQHxpKLF3uvwzBqxKfplDFDXX864bcW8r6uG/aycJg==
X-Received: by 2002:a5d:584a:0:b0:39a:c9fe:f069 with SMTP id ffacd0b85a97d-39ad1771d22mr4166645f8f.30.1743115564254;
        Thu, 27 Mar 2025 15:46:04 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-39c0b6588dbsm789476f8f.2.2025.03.27.15.46.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Mar 2025 15:46:03 -0700 (PDT)
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
Subject: [net-next RFC PATCH v4 3/6] net: phy: nxp-c45-tja11xx: simplify .match_phy_device OP
Date: Thu, 27 Mar 2025 23:45:14 +0100
Message-ID: <20250327224529.814-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250327224529.814-1-ansuelsmth@gmail.com>
References: <20250327224529.814-1-ansuelsmth@gmail.com>
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
 drivers/net/phy/nxp-c45-tja11xx.c | 39 +++++++++++--------------------
 1 file changed, 14 insertions(+), 25 deletions(-)

diff --git a/drivers/net/phy/nxp-c45-tja11xx.c b/drivers/net/phy/nxp-c45-tja11xx.c
index bc2b7cc0cebe..fccfc1468698 100644
--- a/drivers/net/phy/nxp-c45-tja11xx.c
+++ b/drivers/net/phy/nxp-c45-tja11xx.c
@@ -19,7 +19,6 @@
 
 #include "nxp-c45-tja11xx.h"
 
-#define PHY_ID_MASK			GENMASK(31, 4)
 /* Same id: TJA1103, TJA1104 */
 #define PHY_ID_TJA_1103			0x001BB010
 /* Same id: TJA1120, TJA1121 */
@@ -1971,31 +1970,17 @@ static int nxp_c45_macsec_ability(struct phy_device *phydev)
 	return macsec_ability;
 }
 
-static int tja1103_match_phy_device(struct phy_device *phydev,
-				    const struct phy_driver *phydrv)
+static int tja11xx_no_macsec_match_phy_device(struct phy_device *phydev,
+					      const struct phy_driver *phydrv)
 {
-	return phy_id_compare(phydev->phy_id, PHY_ID_TJA_1103, PHY_ID_MASK) &&
+	return phy_id_compare(phydev->phy_id, phydrv->phy_id, phydrv->phy_id_mask) &&
 	       !nxp_c45_macsec_ability(phydev);
 }
 
-static int tja1104_match_phy_device(struct phy_device *phydev,
-				    const struct phy_driver *phydrv)
+static int tja11xx_macsec_match_phy_device(struct phy_device *phydev,
+					   const struct phy_driver *phydrv)
 {
-	return phy_id_compare(phydev->phy_id, PHY_ID_TJA_1103, PHY_ID_MASK) &&
-	       nxp_c45_macsec_ability(phydev);
-}
-
-static int tja1120_match_phy_device(struct phy_device *phydev,
-				    const struct phy_driver *phydrv)
-{
-	return phy_id_compare(phydev->phy_id, PHY_ID_TJA_1120, PHY_ID_MASK) &&
-	       !nxp_c45_macsec_ability(phydev);
-}
-
-static int tja1121_match_phy_device(struct phy_device *phydev,
-				    const struct phy_driver *phydrv)
-{
-	return phy_id_compare(phydev->phy_id, PHY_ID_TJA_1120, PHY_ID_MASK) &&
+	return phy_id_compare(phydev->phy_id, phydrv->phy_id, phydrv->phy_id_mask) &&
 	       nxp_c45_macsec_ability(phydev);
 }
 
@@ -2069,6 +2054,7 @@ static const struct nxp_c45_phy_data tja1120_phy_data = {
 
 static struct phy_driver nxp_c45_driver[] = {
 	{
+		PHY_ID_MATCH_MODEL(PHY_ID_TJA_1103),
 		.name			= "NXP C45 TJA1103",
 		.get_features		= nxp_c45_get_features,
 		.driver_data		= &tja1103_phy_data,
@@ -2090,9 +2076,10 @@ static struct phy_driver nxp_c45_driver[] = {
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
@@ -2114,9 +2101,10 @@ static struct phy_driver nxp_c45_driver[] = {
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
@@ -2139,9 +2127,10 @@ static struct phy_driver nxp_c45_driver[] = {
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
@@ -2164,7 +2153,7 @@ static struct phy_driver nxp_c45_driver[] = {
 		.get_sqi		= nxp_c45_get_sqi,
 		.get_sqi_max		= nxp_c45_get_sqi_max,
 		.remove			= nxp_c45_remove,
-		.match_phy_device	= tja1121_match_phy_device,
+		.match_phy_device	= tja11xx_macsec_match_phy_device,
 	},
 };
 
-- 
2.48.1



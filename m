Return-Path: <netdev+bounces-191315-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49845ABAC4C
	for <lists+netdev@lfdr.de>; Sat, 17 May 2025 22:15:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D6D49E1B6D
	for <lists+netdev@lfdr.de>; Sat, 17 May 2025 20:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C228221771F;
	Sat, 17 May 2025 20:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PPJ+DtGe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5857214A91;
	Sat, 17 May 2025 20:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747512874; cv=none; b=Jnp0MxkM44EL6BEP9dsr84YvXAlFFRiXulqYBV+ClC/m6zpdy1AfalgeTF6O147sWHLeDuS2MaEC+072fg730v5xG4XUzHNekrLCRuG0BjWhz/f9Ja3teZKyUkanJkz7dmfWTSSk+5l8JyyUHJ4SWR+PrnEJazXY0a85bbc+tpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747512874; c=relaxed/simple;
	bh=JMeorUGvSZqGdgT8eqo1GtEKe7cqqq8Xmt0oOBKX1/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lPLgjDg+cBdBdmzWJnoimGxMIa5CyawqI+9X/7j1FM7S6H619R7ufKERrl/JG5NWGzsFgcCVi7KB+IuhVcWXcf87OPVoOR71fKqWfz2gBKbPQ4bDkfAZlZCR4rrPnKUuCMKAk/iLQVQxQi6YmwP2+Ljqs5lnuwnV0qGXTElo1eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PPJ+DtGe; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-442ea95f738so24100965e9.3;
        Sat, 17 May 2025 13:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747512871; x=1748117671; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lTQhXTyWA+dzynRUt+APtRqGDF+FBiwvMZ8BjXEGJS4=;
        b=PPJ+DtGe77/Tmia2bLr/5n6OwgWqlWFvIu+Wl64sGMysYN58YYlFBknblBU99hx3UY
         F99cNz5bAXGH7FYU8f2rx+o7gPH82zgw5rmM+aN8JZR+wS/hCWZHFX6NE8DS7I9P+vju
         R1eyorVWdAOEw0AFtx8zXqfS0gJQAfV9eusFwY0qEJSzK/IWF9wIL/43thpots8VcdV3
         h0gVt5MNPKwvCbXURTJ3AMa3rDj59QaOSAFvqiETQS5zpJ3eEmatFKcsfq6vZBoDuP+o
         Xi4hEhnSGf80x1Qgv9r7DTaObrFxsWWWaAFVX3SL2ojzqhXJ2mIvqO+9o34bwm9wVdtt
         sQSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747512871; x=1748117671;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lTQhXTyWA+dzynRUt+APtRqGDF+FBiwvMZ8BjXEGJS4=;
        b=F1RZjs6ZTQfz3kN6W17S3ghC+VMIEnbzkIbMWvvIJln7S5RH/+unMF7UubmZJ0xSrv
         6DCnl1u6G8cJwRD64D+CUIk49wEYhFEIywf/SSMVLK9XaJ0LCkf43fgIjA+85katWaUE
         SrlOFgQ1F5+K7M1oTVb18Sku0CFurCdmh1PO7LCLsCid6ctGN1mAF5tb0+iGbmeEk0Qw
         Sfi8Y69y6K9Pgoujvi1b36eoz4rXyI5dbgRGpezjJMI2kGD9rvt7qU+QFgluG9ZBANir
         jJQpsK2rIxBNkZvJ8gDq6Pfcz2jTIHMLsfEYKiLqbYx0YTrYLHiO7I6RbNFLmIFG6xxt
         f1ww==
X-Forwarded-Encrypted: i=1; AJvYcCUUiMhkvl9IVYmPJ+QPPl7uzZR5oZgfP6qmnFU8SJOt0qvRgDvCqQZJ1t1s3gTJzw1f0ZjtE5uA@vger.kernel.org, AJvYcCWGJwzSTrOEz2HmKWy+y2E1ts0eqKzS/uptHA5+NDKJeXPqN72sRId3rYK9Xozguur9AWn8opKdgzU6@vger.kernel.org, AJvYcCXA1Q+/ji6nJOnMjlJdR0769UyOb2bTmYqtEV2RukA+sGOd9WTFMA45Rgup1W6Ep4iZiSirUKWX4bwtx1wm6YU=@vger.kernel.org, AJvYcCXabSZDBymlTGF7om3lbDF6WuN6MFiLfi/2til+mUGO6u/+hdUgvLIW5RAk0CSE4UrsXZY6EqcpcjnVKVjX@vger.kernel.org
X-Gm-Message-State: AOJu0YyeVYValHm+UDekszzNafE1vGJRdla9y2dW7IXBBQAz7lm1tykM
	cbrPMbM3t1NwVzQwJlfanD8RNKwsR5qHY71xyeWOhSKHYV6gEPRBRwOm
X-Gm-Gg: ASbGncunxC4nhVvUuqxTTlDxvAznFxbVo9MlYHpZzTftMU/tc5y/Z4K25svhdtuaLGx
	mLdQenObjY7fFs0j8ezuBWZtlTsiOxMZkuYl8dqMD48KdrP3GVERRKXPZpe6a6EvZ0SwME8/bna
	AXz8/sI6A4tNq75nujsac9ekAJcoKCuexJxag33BHFyShUT90FFigh4HvA3D2ld9bk4phuO24MR
	IGU4x6023zirko1R7fFHq3YWl26FIi6Q80au8b/NE/bcUOhKb5+KidPu1rrQjLSnp6Fd5foirVk
	ESarZ/FYD/36fH36PgkFf1/aNGvVxn9Pdi0DWVQ/Xg8p0VA0d7x1zMQPflZnVuLrxKIOKrTSTru
	rGzTc/x9MLhq2Yx8OKirmO0z7oWhDLVk=
X-Google-Smtp-Source: AGHT+IF17AQpViVU083IJgM6t4NsFN1G06ba3Grx4g16s1dBnHhgUvn539UfEByy/q2BHmHqoRQU9A==
X-Received: by 2002:a05:600c:1c14:b0:441:c1ea:ac35 with SMTP id 5b1f17b1804b1-442fd64df64mr62100625e9.18.1747512870885;
        Sat, 17 May 2025 13:14:30 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-442fd4fdcccsm85345445e9.6.2025.05.17.13.14.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 May 2025 13:14:30 -0700 (PDT)
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
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Trevor Gross <tmgross@umich.edu>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Michael Klein <michael@fossekall.de>,
	Daniel Golle <daniel@makrotopia.org>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Cc: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Subject: [net-next PATCH v12 3/6] net: phy: nxp-c45-tja11xx: simplify .match_phy_device OP
Date: Sat, 17 May 2025 22:13:47 +0200
Message-ID: <20250517201353.5137-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250517201353.5137-1-ansuelsmth@gmail.com>
References: <20250517201353.5137-1-ansuelsmth@gmail.com>
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



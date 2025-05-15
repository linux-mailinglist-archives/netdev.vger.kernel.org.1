Return-Path: <netdev+bounces-190697-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A61FAB84D6
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 13:28:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DF4A1BC1A50
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 11:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 067E62989B2;
	Thu, 15 May 2025 11:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mh3BCw7l"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1720B298CA2;
	Thu, 15 May 2025 11:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747308476; cv=none; b=kyKwkVaJ1uTAwqGxZe9K68LmFf+CZo6iTTfMEFtDIKlm7VI6uZZ6e0VXcVJ+sJ17OioRcXpSQMu6+oHkffcAgYPQ53fUxfYT1W3IOtBztHaIPllMP9ErKl4C6+UZ4VCzHOl6lA3ev0cJyx3B4ClT9fxgYv8Os/roVUojj0TZ+p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747308476; c=relaxed/simple;
	bh=JMeorUGvSZqGdgT8eqo1GtEKe7cqqq8Xmt0oOBKX1/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JJ/v/HBSgaVhDC8LEO0FU7Wqc9+HBYfjDpc6OmdQ4AhdOqqWuWWEDGFWglYEhDrAaWipuSedIMthLjoWWXZP5sih/Dba+FrOfHnH2FevZNI7i0YhvukvvKZ+2x8RZ70K3Ps5M/DU+s+1phY3d8Aqk7vQ1fLj2Cuv/ljc8gNw6dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mh3BCw7l; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43cfa7e7f54so6116465e9.1;
        Thu, 15 May 2025 04:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747308473; x=1747913273; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lTQhXTyWA+dzynRUt+APtRqGDF+FBiwvMZ8BjXEGJS4=;
        b=Mh3BCw7lpOuydoe948NIwgcDCSrIiDT2lCeQ03Jp3QAYdys6C19mOAJ8Y0Ja3GOoiL
         XdOtujYBwN+lkERxuJB/BDGxadyZf3ryss9dLwTwy8X6OyK4z5sf58CLgMWRcULNg4Fu
         sj0bqmrahROdghFwXCwjK9O2icSUjIt5CrSXE9BZ7JmnGfdIh6Assw6MzrTuEJ3iVAFF
         HUAJuRQydlP+IbyXlpMPJg+i1f0kQqIR+kMIhASlhXXRIvx2fJp+b7sYthlkgPeyAFmi
         CH0bgBALMhN5XksFty5ye02Ofdud1P0Lj7LA9VgDp5iuPqADaE4FFAnHryqAlzDiGdjl
         MEFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747308473; x=1747913273;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lTQhXTyWA+dzynRUt+APtRqGDF+FBiwvMZ8BjXEGJS4=;
        b=dHovjC9gnTAXKGka+wE1SNVWq5N0a8CnW4BTYN3f22q6xSQsRfKb/9k/Y/Ze6Rw+Di
         +HMlLPiAjadYZp8GjB1KrKe9Lf1LFINoIN6YBlQjkHHvAQZRauRh1Opyu8uqEtNznH0B
         20sv2kjprpmprhad/uliSzWGOKLet557fJp8cG4FjFk8TBalFyvddxbFJ9NyTqZO7n6r
         iC/AfbRUp7sx/F/B5BAPASxOt9q9x+tKL7csrr4AvcWsEFHWP8xY7yo7vUn8s0jByyEM
         78iWEr4nVkjgOA+EsW9g7b/hflN3zPwN3Rkj1k26QAEP3Qj8Vc3whZ3xTj0qCkANv3ld
         Ex6w==
X-Forwarded-Encrypted: i=1; AJvYcCVl2TUGxk3cFtBd8zB09dv4RPo2l+EK5jtu0pnnWXkXT9UELWCE5fbuOKa+OtRkm5YeX5hdFZ6GAsGt@vger.kernel.org, AJvYcCWJw3idfNpbwHf56qvAIv/dtswzhsngFm+WaUoWKGlQqGtNmE5tKuS1E5jc0mqZ7u4xMLu3HnDpf4XvSJKd@vger.kernel.org, AJvYcCWkcOejsQrmIF32IqHTJF9dakxqmSveJhYgJ/Ld1l83KbR76uE67MVCZBcXBjqsDs/HbU+oCrhRHvkPJdi5gUM=@vger.kernel.org, AJvYcCX/vzsFsepDCygarMxGWspoz1zGPu12rU7ek32qm5JbVur6fvi1h+INLuQZKBOek1UuU0YCh65M@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo/uW4TcmE81hlk4Bhf8rWPqPaWhDfWYiC+RRsSLZxzAFpwTXa
	O+ptlLbdo+1jR4JHCkBKgXnVFV+lSLGWDr82BIQQYVucr6wUhljn
X-Gm-Gg: ASbGncvnmZue7LRCI70B2zU6rBUeqF/+PhDr+oJtjTj2suZDAovNfBU16feGxNWjhel
	brFpOvP2NqcKuGPREpyQ3sAUqbZCLmrCnNpUDzDRiV2Hkg/CnZXg0h1VAfitVA7ApSPCHQzW/MN
	zIglbEGSz7TC/1BQEzI1b1NGVO4cpRPJ6LxB9l6EjbuSsWqKvLJJ23bwwNVH58H087NrvuyLg8o
	9MEhuF/FanIvSWgRJQU6lninVaXv+5fVfH98FE2G7cd10i4e2W2kJabrjcJcZen7nX7XiJyxTh3
	OF5wZvYKExSGM6zECWCp5ahoiqfx3LDAu4d1uoDNjmaMbe94pT/W0viSxCjCp5Z6TI1cLvzNkv6
	pmScTOub9cI1bn19zgbKEtb0ccnRoABk=
X-Google-Smtp-Source: AGHT+IHrymNKn2A7ocKKmuUkNWurs3VOlFCxJK6qXKAG7HoSOs3sb/+MsDZxzh0HxPQtlziBrmnlXA==
X-Received: by 2002:a05:600c:1c27:b0:442:f904:1305 with SMTP id 5b1f17b1804b1-442f9041472mr21336195e9.6.1747308472913;
        Thu, 15 May 2025 04:27:52 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-442f39517f7sm64497795e9.20.2025.05.15.04.27.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 04:27:52 -0700 (PDT)
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
Subject: [net-next PATCH v10 3/7] net: phy: nxp-c45-tja11xx: simplify .match_phy_device OP
Date: Thu, 15 May 2025 13:27:08 +0200
Message-ID: <20250515112721.19323-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250515112721.19323-1-ansuelsmth@gmail.com>
References: <20250515112721.19323-1-ansuelsmth@gmail.com>
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



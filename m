Return-Path: <netdev+bounces-191177-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72FF2ABA513
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 23:25:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02EFD503673
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 21:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1C4F281378;
	Fri, 16 May 2025 21:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B1nTC1YH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29C7281351;
	Fri, 16 May 2025 21:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747430672; cv=none; b=tRTJo/omSCbq0CYX96ajVe77pOypkOcDZlkQdufC0myZG8+cH5HTFI7UuI+gyklsRQEoVSSb+x25NuXrBCGnfMvwAaG7uWTF955r5P84AXCYpY/t6qPoG6lEVB47rlRzx5uVmKUs7Pbtm09sCClloyuGlUdjQ/kyCcAkZd2/eKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747430672; c=relaxed/simple;
	bh=JMeorUGvSZqGdgT8eqo1GtEKe7cqqq8Xmt0oOBKX1/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iOK9vurvMVfN4HpzaUtoAANbxKw0Hrt0vPftagLrow9QiDfr6KOYayDyoMMATJ369kW+kUsZCP950/tgIp5PwSfN9Q4QFswxDns5aheDan7eFiHoUjSsAxBeOz/RtIw1z8dJ9Uai2dwMQchW6mFEckYljsJbIWQPU3M+vRsElMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B1nTC1YH; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3a365a6804eso95737f8f.3;
        Fri, 16 May 2025 14:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747430668; x=1748035468; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lTQhXTyWA+dzynRUt+APtRqGDF+FBiwvMZ8BjXEGJS4=;
        b=B1nTC1YHBu0cwdekHH5GPXweN0nCfLZAT2esC8EPu+nXoN0F4CcLDpmS0Sdvqk80to
         JRWnqqG94+X2uHo4Tc40L5XJo6fFh2nMoyAXSGLMz+epuJ8SrboUhlWjeMcQiDhO6qpj
         vnlMU0t/+wcg6tZluO3BWHX7JKPWVdiFWcvK9lEuKG3skXVUamQzjOFhXufI3GaGlcg4
         BHr+9J94EEZpCNwc1VQ4MpfkukrwUQaXL1Uj5X+22iEFC6daXKX7qwJCShWhbOU5FIbb
         NE5A+94Yjq41ZxlnWM/6MyiCgx8jIscbDugj87a29hsTqaNU44/gTN+9CXoK/gLQlBQD
         7/Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747430668; x=1748035468;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lTQhXTyWA+dzynRUt+APtRqGDF+FBiwvMZ8BjXEGJS4=;
        b=c7YidxXCR1A6Iu1kcDbVnKDZ93bopxkELsp6qX3E52TvZmRDOWxByNh8ovs7yvplB1
         3URhTZQ8p3VQ3FL5VqLVMBN0ZU7tsVFt3DSvM0Ca/APHaNvONwzM1pe4OHruUEd/6qtG
         o9Eh5aroR1ssOxVBwv3QIcBijPKSg7v/APB/Cig9C9TdRtFcn6cph1X4uCUSyncWfrNE
         dwyAMurlComchzSiv4WYlTS38smUT3s67rkcKlqwoYj6i0bFAqf+pS61Y7wm5NPy9gBw
         OtwbRWLJ0QKF40hTP3egf4cnh9A7bk+B0UVz/D8Mrbu126rgfKlIY27ptub8qAE169oy
         CBVQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9mT/y23RzTw7Ec1jeDMxD2UDVhjTgRl0RQ6zhv6MP2h5KeJRMqiiV4bpmllbsWOjLUMkO+4w/xm7YLqmgzKE=@vger.kernel.org, AJvYcCUuKS64+6sglfewLCHMll1HACOls7auc10I/c28ghlAJtm9ZnigJ+W62zIeVCh5H8G3kW8AZhkssYvY51BX@vger.kernel.org, AJvYcCWq0AOd2elrNIKP++ZSe6JOpyBaxe2t1K9EiumFa7hXFzoI1lTS01lXhndnmqiO867+IsH6Q71E@vger.kernel.org, AJvYcCXMDQ8gzC7qs8GSlfvJdv6CPblRwzit0elziixNUmJ8/CrOdYHKy9uxDNJ3FIojlU6ngyocIGieuAZi@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy2ymK+lrJM8n9F4emKq4iGUzsTqNqldjl2TxNnTURxctAmjVe
	ZEKfFWVNW6YwV7xRQY8ATELGmyPCzuU/ir0+wJgA1wYWqNCJm9jp54Wj9UsptQ==
X-Gm-Gg: ASbGncuFzbpueGoPI13uNUtTIxA5lxs15x36VsVHLcUBYWDerHh5VWb0hPah8JYVzys
	A/cQNgIxp5q/QtTNhFkxtgNWxUP3Kbg9MwrfZlqpkHabTTTneNSERaN5ty/+eF8QJMwinljoVq+
	SSRzD0dmTMwWck7X8s22B9ELDcQ3tVTAhMGqmY7uPqslN1AFHZt58ZFa106EYpZYCAerRI0kV3d
	TP6wB2SF5JImEuPamq4TgkGbZGVQHUZlUxsEX9akAq/FMsnUMD1eE7qYFdl2BNnXQfjGpIfnspZ
	j+VLkXpZJcu7hZ2fd6+f/T8soBbf8PILKBeskQYjqOpJNgiILNECBta02VJ9bDnirTeGw/8LBxB
	c+h0yuUaZH6pI4+vhvZs3
X-Google-Smtp-Source: AGHT+IGY15WiWg0f9wJ6UCW3NtxDpBka1rYldw+tn8twNzedNg6aOQO8Ox8PVurqPH/4U8YNPxC0vw==
X-Received: by 2002:a05:6000:402b:b0:3a0:b7ee:b1c3 with SMTP id ffacd0b85a97d-3a35c821fe2mr4797344f8f.6.1747430667998;
        Fri, 16 May 2025 14:24:27 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-442f39e84d3sm126293555e9.32.2025.05.16.14.24.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 14:24:27 -0700 (PDT)
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
Subject: [net-next PATCH v11 3/6] net: phy: nxp-c45-tja11xx: simplify .match_phy_device OP
Date: Fri, 16 May 2025 23:23:28 +0200
Message-ID: <20250516212354.32313-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250516212354.32313-1-ansuelsmth@gmail.com>
References: <20250516212354.32313-1-ansuelsmth@gmail.com>
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



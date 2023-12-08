Return-Path: <netdev+bounces-55320-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37D8480A631
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 15:52:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7E58281C44
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 14:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B60C200C6;
	Fri,  8 Dec 2023 14:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R+33ggdu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63B603599;
	Fri,  8 Dec 2023 06:52:11 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-40c19f5f822so12487275e9.1;
        Fri, 08 Dec 2023 06:52:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702047129; x=1702651929; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WHoMR2yNKpJ7vVM7Ri3zOKS32TyWFv4sZETti3k6Nk8=;
        b=R+33ggduWCjCTF1BvF01ieHH1wTi6d8Y7MMnKviA5ufCXgTG8+lV5bKkk8E12BagVf
         81b5ySelnVbKLbDSEuQkxojOaIKftmkZRtCrHlC4+KTrt67z+p1x319qW6ikdatR+/99
         8sKQAjDtPO5oPyYsqv307trkcwPtl3DD55crTTI/3SAVirmFIwcPs925jyluxYgbcHCB
         VeGSXBef+y92lPIn4qL/0qT711+gVeaL3TMLhO8eFgGEIa4cCqN16iLQ2W6Kyvtrh56U
         28vAzE0wFvnahq5sj/OI4ntFqupIaphsWD9sqs78tma1aBAxOfNU4RGD/RIK/EqFkf9p
         1kKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702047129; x=1702651929;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WHoMR2yNKpJ7vVM7Ri3zOKS32TyWFv4sZETti3k6Nk8=;
        b=upKXKyn5Q3mkhEgA7lQsy28Pk2BmeVr6icE2e0iOQODcmYMljci+yi+2oGwcq+wRyJ
         SfpoFQPY2Eh8vo2Qe5Tw3aR4V8wy4nUZy1HLhmhprJYUb/JDt0EJGlVFcZxDuyv8vBXL
         rbLsEZNaAAqGFODTTJy0Jui2AUAvI/rH+9ao1uGiv3pxrvO8513/b5NKYhIkqXkK1T6I
         TvmGYMxCIt9VbqEOsJ+XaKV3TH//MS3WL2NjZJKoS73ElFEBSgc7bXC5r8+w3DPrOGxZ
         OwU4YWrw4cIMQEv/SQpFm0eEM+E7Gyps6GmCPOBke/h1FqH5FoAyCB/dKYtlAQBe6Agt
         kzPw==
X-Gm-Message-State: AOJu0Yw6GxScyOQI+FUw/6fwEcO2p9ZWQDXY6haJ+B3mFUvWUgVlrv5Y
	EZtG4/p8BoGEBO0mmRA3C7E=
X-Google-Smtp-Source: AGHT+IH3OSJGOHb3jLohEgdeuv83AL412GIVU6HTHYfpArS/MOHC/XZVNM/JjXNoCnOvvzOSPHIQQw==
X-Received: by 2002:a05:600c:4fd3:b0:40b:5e56:7b44 with SMTP id o19-20020a05600c4fd300b0040b5e567b44mr127875wmq.141.1702047129250;
        Fri, 08 Dec 2023 06:52:09 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id r9-20020a05600c458900b0040b3e79bad3sm3088264wmo.40.2023.12.08.06.52.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 06:52:08 -0800 (PST)
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
Subject: [net-next PATCH v4 02/13] net: phy: at803x: move disable WOL to specific at8031 probe
Date: Fri,  8 Dec 2023 15:51:49 +0100
Message-Id: <20231208145200.25162-3-ansuelsmth@gmail.com>
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

Move the WOL disable call to specific at8031 probe to make at803x_probe
more generic and drop extra check for PHY ID.

Keep the same previous behaviour by first calling at803x_probe and then
disabling WOL.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/phy/at803x.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/drivers/net/phy/at803x.c b/drivers/net/phy/at803x.c
index ef203b0807e5..b8f3c215d0e8 100644
--- a/drivers/net/phy/at803x.c
+++ b/drivers/net/phy/at803x.c
@@ -886,15 +886,6 @@ static int at803x_probe(struct phy_device *phydev)
 			priv->is_fiber = true;
 			break;
 		}
-
-		/* Disable WoL in 1588 register which is enabled
-		 * by default
-		 */
-		ret = phy_modify_mmd(phydev, MDIO_MMD_PCS,
-				     AT803X_PHY_MMD3_WOL_CTRL,
-				     AT803X_WOL_EN, 0);
-		if (ret)
-			return ret;
 	}
 
 	return 0;
@@ -1591,6 +1582,22 @@ static int at803x_cable_test_start(struct phy_device *phydev)
 	return 0;
 }
 
+static int at8031_probe(struct phy_device *phydev)
+{
+	int ret;
+
+	ret = at803x_probe(phydev);
+	if (ret)
+		return ret;
+
+	/* Disable WoL in 1588 register which is enabled
+	 * by default
+	 */
+	return phy_modify_mmd(phydev, MDIO_MMD_PCS,
+			      AT803X_PHY_MMD3_WOL_CTRL,
+			      AT803X_WOL_EN, 0);
+}
+
 static int qca83xx_config_init(struct phy_device *phydev)
 {
 	u8 switch_revision;
@@ -2092,7 +2099,7 @@ static struct phy_driver at803x_driver[] = {
 	PHY_ID_MATCH_EXACT(ATH8031_PHY_ID),
 	.name			= "Qualcomm Atheros AR8031/AR8033",
 	.flags			= PHY_POLL_CABLE_TEST,
-	.probe			= at803x_probe,
+	.probe			= at8031_probe,
 	.config_init		= at803x_config_init,
 	.config_aneg		= at803x_config_aneg,
 	.soft_reset		= genphy_soft_reset,
-- 
2.40.1



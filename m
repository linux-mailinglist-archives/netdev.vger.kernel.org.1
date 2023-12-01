Return-Path: <netdev+bounces-52742-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EED27800008
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 01:15:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDFBB1C20E86
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 00:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEB73163;
	Fri,  1 Dec 2023 00:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EKEHcGR6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9AAF197;
	Thu, 30 Nov 2023 16:14:52 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-40b4f6006d5so14732935e9.1;
        Thu, 30 Nov 2023 16:14:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701389691; x=1701994491; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4S8WGKa0/D4CAm9y6YGXWUP7HyKdLd55ppGa7UA6g6A=;
        b=EKEHcGR6/nE0E41Kr0tfotrGUkcpewpralAzjadCewrbWBHTTQLz4GaMnuSq3ZdLx6
         zC/gQ52sYhSi+Ehyt41vAoV6ai13smD5WOFqII2BYTgaMjsCsB4tkO7EoIXIPQLLijiU
         b7tZU3IFekrp7an8AlY5W4ATDX7j86Ls7GRyf0G0A1SfXYkXG1mVhgj5JhDPpbe8SsbD
         9VJCCqMd8Q4SnbcEexeHA9KbNnr0dQJHZgd/3YUzwVRvlzNchtvmHUNDuavtWsAy+z5c
         pep+Owqek9SE1K3jPhBwb5TPWm3cH1DT15mTxLEGMrvI/IIRG/oLcLF9BeNLO3BfL6TA
         dOgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701389691; x=1701994491;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4S8WGKa0/D4CAm9y6YGXWUP7HyKdLd55ppGa7UA6g6A=;
        b=ukknrkaa5e6Sx8Goqy0UlVpn2lD8rJSgdCsh1iUc/SRnfK1nSLzpGjPN22xHQzly88
         eZsrf0ArPKcu+vDyzMtDE6YkbiRp0fzzFIpue6CluSDQEUnoMqyom/FGhBTLo5rLUr6K
         efzz5QKW7F1HjiCBiUlwGlDJkJ58HMPskkprfXr1awQirjQWDaoike3dESR9z3KyQgEr
         G7mR8oeueMUXmOs1eruQ1e2H0KoeZMNlmeKgV80vugi9Fqk9I7chAQUv2THA7XriDo9r
         /5LXmKTnhsZASW0RAxekL3t9P+Ey5if4wFGkagcumJ1xvT6pDFn1ANmcujkH/Bd+yVkJ
         ZxGQ==
X-Gm-Message-State: AOJu0YyeOINgdtWvNRHGkas/qAVcHwBwum3PBGzqD2GedJlOfkbY/PSO
	riTbF8tDCiH8GmTVvSi9aB0=
X-Google-Smtp-Source: AGHT+IE6Gy7juJD1bl485hU/D6aumSPdf3B+iOXOHZc4R5VCHywBhQBqhAGQ+FiyCldeGChlowhcJw==
X-Received: by 2002:a05:600c:524d:b0:40b:473d:6b82 with SMTP id fc13-20020a05600c524d00b0040b473d6b82mr110234wmb.12.1701389690879;
        Thu, 30 Nov 2023 16:14:50 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id g16-20020a05600c4ed000b0040b47c53610sm3535457wmq.14.2023.11.30.16.14.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 16:14:50 -0800 (PST)
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
Subject: [net-next PATCH v2 02/12] net: phy: at803x: move disable WOL to specific at8031 probe
Date: Fri,  1 Dec 2023 01:14:12 +0100
Message-Id: <20231201001423.20989-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231201001423.20989-1-ansuelsmth@gmail.com>
References: <20231201001423.20989-1-ansuelsmth@gmail.com>
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
---
 drivers/net/phy/at803x.c | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/drivers/net/phy/at803x.c b/drivers/net/phy/at803x.c
index ef203b0807e5..85302d96d133 100644
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
@@ -1591,6 +1582,24 @@ static int at803x_cable_test_start(struct phy_device *phydev)
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
+	ret = phy_modify_mmd(phydev, MDIO_MMD_PCS,
+			     AT803X_PHY_MMD3_WOL_CTRL,
+			     AT803X_WOL_EN, 0);
+
+	return ret;
+}
+
 static int qca83xx_config_init(struct phy_device *phydev)
 {
 	u8 switch_revision;
@@ -2092,7 +2101,7 @@ static struct phy_driver at803x_driver[] = {
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



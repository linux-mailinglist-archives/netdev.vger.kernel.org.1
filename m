Return-Path: <netdev+bounces-222124-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 206CDB5333A
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 15:09:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39AD61C22461
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 13:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CB9F326D51;
	Thu, 11 Sep 2025 13:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mdli3jPc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B8A326D54;
	Thu, 11 Sep 2025 13:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757596144; cv=none; b=A2tGQJMV0NnsXHrBI0AAQz1VfqYDgqcLiaBVI5/kRRi2bRDe5l2MD7IdshmUAY4LHGoSqDlq451S+sOY10s//1bq5AuTnrsCrOy+oZW5/XF2msKsY6IahHhfxn9n3fduLrejVhvaRbO9IqYGMxS/6A/F3JZ35n6vSz3ya4vQG0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757596144; c=relaxed/simple;
	bh=V2H9dXIwVgpVXBpviqyiuQS0vIC/+TNnkgW/1tjYST8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=II5PHcVt579CJkAWRxYbTqN/sC/7wKLZSu/svSJP1NE05Qt+6KyX64H1ffYCD+LZYNcH9DLEqWDxFHT4GHfLZmy7Z1OIBoNHqFsHT9m9bzYYgyomJVg6/q0i2hhz4pVvEEMP2S4PcuObLQP0sRRsThybOdB+7aSNccPdQBANt1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mdli3jPc; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-62598fcf41aso919902a12.3;
        Thu, 11 Sep 2025 06:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757596140; x=1758200940; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C1AkGWYGZhk13kpXwKplWPVQOyZ5VfsAbXzcTkoUclo=;
        b=mdli3jPcoRFNYyqbraRwvJFVjOcwCJJ9rlYOvLMai/hKQvAM8KipgOaHci5rMRCIqu
         RRnBsmFuy6KOokkq0AQ7qQCdSTFTmL0kxE2oVkl7bD/gQdGXIY42m9qQWfbagufxf1BV
         YIWwjE3vg8l/hNASXMHy2NYTvNUJxU1qSt6os+E5sHfkuXxCOGhlk1AIIFNaEvJu2nw6
         EU8ZWd1UjvUJPmvLov5lSN+BoBk+GqBsoSlJkVG5BsHLEFySWLJaV8aE4ExD36/nUrp6
         OHJUtI9DHpDIHGK/2tQJGw/dFDfgZ9BBbh620KQ+uVulIeATRtx+jrPFqG8HoWypYuc8
         9s+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757596140; x=1758200940;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C1AkGWYGZhk13kpXwKplWPVQOyZ5VfsAbXzcTkoUclo=;
        b=JsU4nbeB7/xIkEM7cb7hrv1exEQ157m1ZSfHohDGQck0QpGxMYBZ7TvnCyRiHb7POD
         4+ssBzzGQtSUpoMcl7mTdLRaW8UjwWDlSykzk131es0lnbMp5Dw9viMgKwT7tnYTZxDi
         T5EnPJj/bul9V5hlI6SE9bF3fEgnsUsJN7EpsP/n0yJlW/tHgkcYcuFQuuLVCOUQrMro
         tfERIcRXzoThtMdfBrWh7ayWzUZmv2/PZABtsen9i/Ix7y9HpdOK6DL8EAP3IWgK9Qhp
         FFaQ3Ka5hYWV1kfXdaAQ8HtzyreqiYXUETZQGupp29jCIbdgDOXcOmiXntY3487oIVgo
         y0xA==
X-Forwarded-Encrypted: i=1; AJvYcCVl4prVHBqsv5K1b12aOB2Qsgz45xTkv7C54BmwfL5hIOVxZPqbtaqx27Tsa8vKfUFns+RPskUQ@vger.kernel.org, AJvYcCXAyNr+/2i7PYa0P1ymDRmtZGbXW02bJbYYQE9ujtLMWaRJnxvxI8q1PoVp6/dC9G13GhIyYeuV461ssL4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWscUuJU0xNrrt0k/W0fTwVkpZZdHbTIadXNcjFbi0qHr0R6fh
	pCWDz1HzRUJFscf0m8yvFfk02EmyScirba2Zq01sCy74juAMQxfrgMtx
X-Gm-Gg: ASbGnct9lDoh/wqUn38akAk8C8xNtbnXf3aZr8Uttuc6jH+eM3I50/1zcxz/UCfQh6c
	AEDXD9tM2KMUozs8RJBj9QEwuqUeHkWZjNA3RCmRcIjzLjxMHkzXWK+vzGZtO6rWZMPnXYla7NM
	jJhLV0ImXKsr5sbyldoQeZTRa2eou2r0awOBiRcAhCvO2Cka+fBrBm2/C+tiFQ6t8GvZxGfmUXj
	nfgNhvxF1l0liuB3Lajre3r/5v33Sh3uyk221+ZafG/n+kHumW/zqe4Jh4ZGDXLcmJR9oSA44YS
	AoH6IcXAZ2dEJJe7JBzvtwZY+Hj9gyPlG5bD2fCRp5EVT2Xp9bYwpVGD2DBaG6w7Zz8I0w+2/N5
	QcKm+1Eu99m9OhlE6brItiqqq/CMLl7RkCRnQYgh3PD0nyxgx2w1gOrgSEY2zi2AVkpqb60w=
X-Google-Smtp-Source: AGHT+IGpC6N5TNOFIDo3yamTJzl+2SnSbdhkFL0ilGKENQBeqDqBzmADVcGyQJxwQ2VyzHZelNATbQ==
X-Received: by 2002:a05:6402:280d:b0:615:6a10:f048 with SMTP id 4fb4d7f45d1cf-6237826dd97mr16569149a12.33.1757596139618;
        Thu, 11 Sep 2025 06:08:59 -0700 (PDT)
Received: from Ansuel-XPS24 (host-95-249-236-54.retail.telecomitalia.it. [95.249.236.54])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-62ec33f3b16sm1133038a12.24.2025.09.11.06.08.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 06:08:58 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Christian Marangi <ansuelsmth@gmail.com>
Subject: [net-next PATCH v2 2/3] net: phy: broadcom: Convert to phy_id_compare_model()
Date: Thu, 11 Sep 2025 15:08:32 +0200
Message-ID: <20250911130840.23569-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250911130840.23569-1-ansuelsmth@gmail.com>
References: <20250911130840.23569-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert driver to phy_id_compare_model() helper instead of the custom
BRCM_PHY_MODEL macro.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
Changes v2:
- Add review tag

 drivers/net/phy/broadcom.c | 42 ++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 22 deletions(-)

diff --git a/drivers/net/phy/broadcom.c b/drivers/net/phy/broadcom.c
index a60e58ef90c4..46ca739dcd4a 100644
--- a/drivers/net/phy/broadcom.c
+++ b/drivers/net/phy/broadcom.c
@@ -23,9 +23,6 @@
 #include <linux/irq.h>
 #include <linux/gpio/consumer.h>
 
-#define BRCM_PHY_MODEL(phydev) \
-	((phydev)->drv->phy_id & (phydev)->drv->phy_id_mask)
-
 #define BRCM_PHY_REV(phydev) \
 	((phydev)->drv->phy_id & ~((phydev)->drv->phy_id_mask))
 
@@ -249,8 +246,8 @@ static int bcm54xx_phydsp_config(struct phy_device *phydev)
 	if (err < 0)
 		return err;
 
-	if (BRCM_PHY_MODEL(phydev) == PHY_ID_BCM50610 ||
-	    BRCM_PHY_MODEL(phydev) == PHY_ID_BCM50610M) {
+	if (phy_id_compare_model(phydev->drv->phy_id, PHY_ID_BCM50610) ||
+	    phy_id_compare_model(phydev->drv->phy_id, PHY_ID_BCM50610M)) {
 		/* Clear bit 9 to fix a phy interop issue. */
 		err = bcm_phy_write_exp(phydev, MII_BCM54XX_EXP_EXP08,
 					MII_BCM54XX_EXP_EXP08_RJCT_2MHZ);
@@ -264,7 +261,7 @@ static int bcm54xx_phydsp_config(struct phy_device *phydev)
 		}
 	}
 
-	if (BRCM_PHY_MODEL(phydev) == PHY_ID_BCM57780) {
+	if (phy_id_compare_model(phydev->drv->phy_id, PHY_ID_BCM57780)) {
 		int val;
 
 		val = bcm_phy_read_exp(phydev, MII_BCM54XX_EXP_EXP75);
@@ -292,12 +289,12 @@ static void bcm54xx_adjust_rxrefclk(struct phy_device *phydev)
 	bool clk125en = true;
 
 	/* Abort if we are using an untested phy. */
-	if (BRCM_PHY_MODEL(phydev) != PHY_ID_BCM57780 &&
-	    BRCM_PHY_MODEL(phydev) != PHY_ID_BCM50610 &&
-	    BRCM_PHY_MODEL(phydev) != PHY_ID_BCM50610M &&
-	    BRCM_PHY_MODEL(phydev) != PHY_ID_BCM54210E &&
-	    BRCM_PHY_MODEL(phydev) != PHY_ID_BCM54810 &&
-	    BRCM_PHY_MODEL(phydev) != PHY_ID_BCM54811)
+	if (!(phy_id_compare_model(phydev->drv->phy_id, PHY_ID_BCM57780) ||
+	      phy_id_compare_model(phydev->drv->phy_id, PHY_ID_BCM50610) ||
+	      phy_id_compare_model(phydev->drv->phy_id, PHY_ID_BCM50610M) ||
+	      phy_id_compare_model(phydev->drv->phy_id, PHY_ID_BCM54210E) ||
+	      phy_id_compare_model(phydev->drv->phy_id, PHY_ID_BCM54810) ||
+	      phy_id_compare_model(phydev->drv->phy_id, PHY_ID_BCM54811)))
 		return;
 
 	val = bcm_phy_read_shadow(phydev, BCM54XX_SHD_SCR3);
@@ -306,8 +303,8 @@ static void bcm54xx_adjust_rxrefclk(struct phy_device *phydev)
 
 	orig = val;
 
-	if ((BRCM_PHY_MODEL(phydev) == PHY_ID_BCM50610 ||
-	     BRCM_PHY_MODEL(phydev) == PHY_ID_BCM50610M) &&
+	if ((phy_id_compare_model(phydev->drv->phy_id, PHY_ID_BCM50610) ||
+	     phy_id_compare_model(phydev->drv->phy_id, PHY_ID_BCM50610M)) &&
 	    BRCM_PHY_REV(phydev) >= 0x3) {
 		/*
 		 * Here, bit 0 _disables_ CLK125 when set.
@@ -316,7 +313,8 @@ static void bcm54xx_adjust_rxrefclk(struct phy_device *phydev)
 		clk125en = false;
 	} else {
 		if (phydev->dev_flags & PHY_BRCM_RX_REFCLK_UNUSED) {
-			if (BRCM_PHY_MODEL(phydev) != PHY_ID_BCM54811) {
+			if (!phy_id_compare_model(phydev->drv->phy_id,
+						  PHY_ID_BCM54811)) {
 				/* Here, bit 0 _enables_ CLK125 when set */
 				val &= ~BCM54XX_SHD_SCR3_DEF_CLK125;
 			}
@@ -330,9 +328,9 @@ static void bcm54xx_adjust_rxrefclk(struct phy_device *phydev)
 		val |= BCM54XX_SHD_SCR3_DLLAPD_DIS;
 
 	if (phydev->dev_flags & PHY_BRCM_DIS_TXCRXC_NOENRGY) {
-		if (BRCM_PHY_MODEL(phydev) == PHY_ID_BCM54210E ||
-		    BRCM_PHY_MODEL(phydev) == PHY_ID_BCM54810 ||
-		    BRCM_PHY_MODEL(phydev) == PHY_ID_BCM54811)
+		if (phy_id_compare_model(phydev->drv->phy_id, PHY_ID_BCM54210E) ||
+		    phy_id_compare_model(phydev->drv->phy_id, PHY_ID_BCM54810) ||
+		    phy_id_compare_model(phydev->drv->phy_id, PHY_ID_BCM54811))
 			val |= BCM54XX_SHD_SCR3_RXCTXC_DIS;
 		else
 			val |= BCM54XX_SHD_SCR3_TRDDAPD;
@@ -461,14 +459,14 @@ static int bcm54xx_config_init(struct phy_device *phydev)
 	if (err < 0)
 		return err;
 
-	if ((BRCM_PHY_MODEL(phydev) == PHY_ID_BCM50610 ||
-	     BRCM_PHY_MODEL(phydev) == PHY_ID_BCM50610M) &&
+	if ((phy_id_compare_model(phydev->drv->phy_id, PHY_ID_BCM50610) ||
+	     phy_id_compare_model(phydev->drv->phy_id, PHY_ID_BCM50610M)) &&
 	    (phydev->dev_flags & PHY_BRCM_CLEAR_RGMII_MODE))
 		bcm_phy_write_shadow(phydev, BCM54XX_SHD_RGMII_MODE, 0);
 
 	bcm54xx_adjust_rxrefclk(phydev);
 
-	switch (BRCM_PHY_MODEL(phydev)) {
+	switch (phydev->drv->phy_id & PHY_ID_MATCH_MODEL_MASK) {
 	case PHY_ID_BCM50610:
 	case PHY_ID_BCM50610M:
 		err = bcm54xx_config_clock_delay(phydev);
@@ -693,7 +691,7 @@ static int bcm5481x_read_abilities(struct phy_device *phydev)
 		 * So we must read the bcm54811 as unable to auto-negotiate
 		 * in BroadR-Reach mode.
 		 */
-		if (BRCM_PHY_MODEL(phydev) == PHY_ID_BCM54811)
+		if (phy_id_compare_model(phydev->drv->phy_id, PHY_ID_BCM54811))
 			aneg = 0;
 		else
 			aneg = val & LRESR_LDSABILITY;
-- 
2.51.0



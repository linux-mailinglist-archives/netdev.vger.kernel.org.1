Return-Path: <netdev+bounces-221400-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C35AB5070E
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 22:28:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E3FC7AAA52
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 20:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFABB3314B5;
	Tue,  9 Sep 2025 20:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ksRoi3KS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F1E2F747B;
	Tue,  9 Sep 2025 20:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757449720; cv=none; b=EXKpF8XWhyMNckSUttK0jEvXb+UH4wnQjtPESBKDdxfsTn2KiQXDcrD+rta4YpF5/7dCkXzQds++fPBmlIjMLmETEOaPEfRUFh6CSgbGSyZbpjw7Lt/n8przAvhTrM7Nc6m8KVdc16RyBhBNkMmAMsNa2cFcip/QKAhGXSpPE0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757449720; c=relaxed/simple;
	bh=EYefjlGYPLMW79Chbq60KgZz72SutJ+Sx/lvAxQXI3I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uP5xv2Jl5KApasndLvnU78+NNTB2LBa0IWj377NV30Jks35JAAkuaE9FQdIcHmcg09eN7HOrJQ85XsfKQxBhx6+JkbUpHCk7+4M9R4DZZDSlOmbWb4XZozS3+yfJle4KxbaDY2k6cLwOzpoopqW2DnewTAXuB7ZF8SXyrolWLg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ksRoi3KS; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-45b9814efbcso46284365e9.0;
        Tue, 09 Sep 2025 13:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757449717; x=1758054517; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A56qRt+8GO41Ieq0GoIOCI3OMFU8M45ud0Tw5ciw/4g=;
        b=ksRoi3KSLQGeKblzjFv7m3MgDmHienRO/WEqaesrDNVdJbV6lGmuS3Gnnyr4aQy20O
         Q3vEsZ2BESKDOoB5JGwx+jPC+W7G+xGbTp4hKcNoGrPNKxUSvp4SzAUNetqAIoGVrATS
         BswAd2U/x0ImV2B0RgUp/+Sv2pQJ9Il6JaQLn3X0Bmb72q8TWL6u9LVXHrlQsQyaCfjH
         f098XTTQsU6OHgaQ1LNvNKIxriNptpS5Qu1sAliNPu8kJtxNevQIKEsoxrzCwrtAXoAD
         ociw03mVLLJYps8uwCuc+C0BS2/EVR7AAQk/ddNCnGXDry7xZdttzsWkjKqMK39zjeHd
         xmtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757449717; x=1758054517;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A56qRt+8GO41Ieq0GoIOCI3OMFU8M45ud0Tw5ciw/4g=;
        b=S9qMeNXfjHin1/6L8PopNIm0Htr4z7Nbq7XMPGwdQfGXRDnwa1JTr1AlZcgT8AhUfY
         pMRoJ5g1MrVQZxDHwhPfGjFDV+h9vtBIY7m5M/d82lHJAtL5zZ85EpzIyZedPAhhtbEo
         rUvPKJGFnH3E9IREROITthha2nG0wZwltaYGi2Anl4Edxvxy7HdiIS+l+V4NQIbG9P7q
         ZkWyHVZHC/f0dQmh/RkPzOAR3ppiomN+x+htDD5xaFEsdE7N5rZr8G3ZDXcXeCepNKj4
         e558GBsCOmYhUtaeYzyWO91XVwB3lXbJMXBAt+WroeKJEcXEeUEoB5Z0DR3jzIP1LT6q
         NqIA==
X-Forwarded-Encrypted: i=1; AJvYcCWPCNjlb1jjlXGoxOuyDpOmkeYqMNdcTGAmq/RXJSNvUgd/L+m7OvC+vD1D9Pu0dAcX2YdEmyZsA4UyfnU=@vger.kernel.org, AJvYcCXyNfF8ukeyxJLKhQNNOb22zdPnkArQK7iTzlEInbfqqAcnh83T33N5j2mO/k+3HEZ0PxvnwfR/@vger.kernel.org
X-Gm-Message-State: AOJu0YyTIW54/Mvre6VmFaMnpQIVFAqbrG7nj8W+7cC+cXirxbW4Owtr
	sAyCHAy2J/aGSQeuhT7TnkzTO0rWTJxIu8CMGGCZMFVjU5y3ZTB8D+ub
X-Gm-Gg: ASbGncsK7h47x18RBYY72btCinDnn6ghsgg/kIZxRoh/QBwXRv75Wrn+ktjTUab6FQi
	95V9yA9BS0zuEBZP98tSCZnPuMCtAnd0hzEv8C5ICR7UkG/UsCpDqt8TkcOQL4i/pVku0wCl2Gl
	mukvg8xRSpI3o0FGlRMmj76AclJrRnFOcYT2nm5VsWHEvIpcmDCI2/lomIhOAV23i8PYNOrlpoN
	rV6zd+KBPi4nKKmHWubkYQejETbvzIpIafI4mQjQHIG+6YaxoYHZUsn2ozi72VYO3Zq89/Bh2yX
	oCO3PYQ+P4a9QlAhPBcH1lah89ExNxDQHa4mLlahO4OHaCbyNheT7/C2L9R1Esr0HGjskZvYwbU
	iisvQCB683qyCM8SZuNwwdpt36z/VImyHgJtfCAop/+urUpO1eIPI87emusp3Kls9B43E5GTFqg
	fhwJb5mQ==
X-Google-Smtp-Source: AGHT+IFJco4TrI7Pt18xJ9Rgb8gP/UIpw8ClRg+ScqygjHaS/9ESQEyRNBT3zX5Rx6l/GOkuKsAiyQ==
X-Received: by 2002:a05:6000:2288:b0:3de:e787:5d8c with SMTP id ffacd0b85a97d-3e3020eb34amr14710640f8f.13.1757449717173;
        Tue, 09 Sep 2025 13:28:37 -0700 (PDT)
Received: from Ansuel-XPS24 (host-95-249-236-54.retail.telecomitalia.it. [95.249.236.54])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3e7521be57esm3895842f8f.2.2025.09.09.13.28.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 13:28:36 -0700 (PDT)
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
Subject: [net-next PATCH 2/3] net: phy: broadcom: Convert to phy_id_compare_model()
Date: Tue,  9 Sep 2025 22:28:11 +0200
Message-ID: <20250909202818.26479-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250909202818.26479-1-ansuelsmth@gmail.com>
References: <20250909202818.26479-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert driver to phy_id_compare_model() helper instead of the custom
BRCM_PHY_MODEL macro.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
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



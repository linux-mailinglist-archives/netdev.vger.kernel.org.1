Return-Path: <netdev+bounces-121078-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05D3C95B918
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 16:53:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACA522866BA
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 14:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 883991CC16C;
	Thu, 22 Aug 2024 14:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c1TlC42A"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A501EB5B;
	Thu, 22 Aug 2024 14:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724338433; cv=none; b=udn14EghdA61++80NNgzKhuJMyUoSjFHQx8eJY8IdmdC+Bd6e7Yy49S80rcCzzIkOij7oN7zEf1ZRdHG6WbQXs+dDqxJD3M7R2uKZg8W79yEmOY+ejfdShrA5Gy0ulc080WkOgnwEeo5VI+jzNlEIPLY/YMzgSt3mR4xguozwEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724338433; c=relaxed/simple;
	bh=JgMnPdxIcARuczM0WQACnBcB8005hAtK3ZyFdyrVbP0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sxgE9L3FcMHKCqgxtbrRXTG7lUrd+fQG4dzL85gffzelXMiJgaxt4/PsCOxyA4VjsfBwehecDMxhyXlR02p3DxF82V2J8vgltPw785I5FEB8ZcvonSlnsBw/oWjRX4HIZZNB5R86Aim1OLU5LYZ/PdwqBvFgsXBUm5U0/NKYLmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c1TlC42A; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a8657900fc1so148351766b.1;
        Thu, 22 Aug 2024 07:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724338430; x=1724943230; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4AFX8Jy0QsFbyyF167FDXq1PSqmdmQPvGIjIJI+2j+Q=;
        b=c1TlC42AWeDo0N9DYeVrzbGU9bHf8nn9pm6kk5pY+tVkpnjDXQm4XzAnrkTE2Bxtou
         euX8Yy5WNMoGriV3KwrEKi0CabFdiGnTJ/KFp7Pxc+p7Uzi9NUWcR6px1zyY+Afk2AAA
         mAxpoEoeEENLdUVT8Jd3JbfpqgbmU5pK0fFyEacINmnQ4CqVZNpwQJDj+BDzX0tdAtuC
         ylAQ/TBWGAuZo44/KIvmlu1L365HjxP+Uo2TIjG25u5VUzQR3JSRTjpjYweqOEnXKqI1
         uQqJEq1bLSxQ6lysuoThio03pv/mt3qYICOJSIsqav2y/RiGA0dZIbnMaVnLcJTSusTd
         /Aqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724338430; x=1724943230;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4AFX8Jy0QsFbyyF167FDXq1PSqmdmQPvGIjIJI+2j+Q=;
        b=fNtBdhfrh1TiQfoUdQfNXni8SH6k3i8/Q92WFAztDPitKESFtf/BguESp/1/naYFP3
         LPZsmdv8U7FXFy81oWjCei6uSU8rHHNliD7vdf8Aw+NmAC1J6o91vkvp/9k2UpczGPro
         nAs4YPX+0dt05pQunEGUvOt6rCAW6Vq+io5Teu9hvbzLpgi+6l5ekmglY3nSmtBfrGjv
         AMzDR+M2h7kjUCDq/28VmJB0zrSuuPZO9iDefMMOicYPlT7snJaBble7SitvXe1v8Oa9
         qTi6hyUnYBUKdze4RXF7wIG2VRyJRC0VhpTxyxb/X04IMU53FAMfkEziNyCipWQ0nRbo
         lDyA==
X-Forwarded-Encrypted: i=1; AJvYcCUoxSP0wqDAnHZW585WQ+3EpdGZPiFMl8zvLElqQYkLnQb31L8klrbRGIOztVhxT8l0dgz7XPHTAiunHaw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmBsTa78uOYOlqIwGVHVHU8v41jiRHMa6FQACUCYd9Nyc/tled
	a4ddLN9EeIOTNLxjyUezxPb+8QY9YIfjfQlanUbuQcaiPiBsA4qC+5wFoW8X
X-Google-Smtp-Source: AGHT+IHyGGxERj4Yr04ZdEgjGkjg9VUVjdF/smWT9qwrNI/xE7sqJ5SuCWPYVy2wlJlellAQfWN6ow==
X-Received: by 2002:a17:907:7f28:b0:a86:9041:a42a with SMTP id a640c23a62f3a-a8691cbabb2mr145270666b.62.1724338429183;
        Thu, 22 Aug 2024 07:53:49 -0700 (PDT)
Received: from WBEC325.dom.lan ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f48a5d0sm128735566b.159.2024.08.22.07.53.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 07:53:48 -0700 (PDT)
From: Pawel Dembicki <paweldembicki@gmail.com>
To: netdev@vger.kernel.org
Cc: Pawel Dembicki <paweldembicki@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: phy: vitesse: implement MDI-X configuration in vsc73xx
Date: Thu, 22 Aug 2024 16:53:36 +0200
Message-Id: <20240822145336.409867-1-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit introduces MDI-X configuration support in vsc73xx phys.

Vsc73xx supports only auto mode or forced MDI.

Vsc73xx have auto MDI-X disabled by default in forced speed mode.
This commit enables it.

Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
---
 drivers/net/phy/vitesse.c | 88 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 88 insertions(+)

diff --git a/drivers/net/phy/vitesse.c b/drivers/net/phy/vitesse.c
index 54eb4e8377c4..38a025521119 100644
--- a/drivers/net/phy/vitesse.c
+++ b/drivers/net/phy/vitesse.c
@@ -71,6 +71,19 @@
 #define MII_VSC73XX_DOWNSHIFT_MAX		5
 #define MII_VSC73XX_DOWNSHIFT_INVAL		1
 
+/* VSC73XX PHY_BYPASS_CTRL register*/
+#define MII_VSC73XX_PHY_BYPASS_CTRL		MII_DCOUNTER
+#define MII_VSC73XX_PBC_TX_DIS			BIT(15)
+#define MII_VSC73XX_PBC_FOR_SPD_AUTO_MDIX_DIS	BIT(7)
+#define MII_VSC73XX_PBC_PAIR_SWAP_DIS		BIT(5)
+#define MII_VSC73XX_PBC_POL_INV_DIS		BIT(4)
+#define MII_VSC73XX_PBC_PARALLEL_DET_DIS	BIT(3)
+#define MII_VSC73XX_PBC_AUTO_NP_EXCHANGE_DIS	BIT(1)
+
+/* VSC73XX PHY_AUX_CTRL_STAT register */
+#define MII_VSC73XX_PHY_AUX_CTRL_STAT	MII_NCONFIG
+#define MII_VSC73XX_PACS_NO_MDI_X_IND	BIT(13)
+
 /* Vitesse VSC8601 Extended PHY Control Register 1 */
 #define MII_VSC8601_EPHY_CTL		0x17
 #define MII_VSC8601_EPHY_CTL_RGMII_SKEW	(1 << 8)
@@ -319,6 +332,73 @@ static int vsc739x_config_init(struct phy_device *phydev)
 	return 0;
 }
 
+static int vsc73xx_mdix_set(struct phy_device *phydev, u8 mdix)
+{
+	int ret;
+	u16 val;
+
+	val = phy_read(phydev, MII_VSC73XX_PHY_BYPASS_CTRL);
+
+	switch (mdix) {
+	case ETH_TP_MDI:
+		val |= MII_VSC73XX_PBC_FOR_SPD_AUTO_MDIX_DIS |
+		       MII_VSC73XX_PBC_PAIR_SWAP_DIS |
+		       MII_VSC73XX_PBC_POL_INV_DIS;
+		break;
+	case ETH_TP_MDI_X:
+		/* When MDI-X auto configuration is disabled, is possible
+		 * to force only MDI mode. Let's use autoconfig for forced
+		 * MDIX mode.
+		 */
+	default:
+		val &= ~(MII_VSC73XX_PBC_FOR_SPD_AUTO_MDIX_DIS |
+			 MII_VSC73XX_PBC_PAIR_SWAP_DIS |
+			 MII_VSC73XX_PBC_POL_INV_DIS);
+		break;
+	}
+
+	ret = phy_write(phydev, MII_VSC73XX_PHY_BYPASS_CTRL, val);
+	if (ret)
+		return ret;
+
+	return genphy_restart_aneg(phydev);
+}
+
+static int vsc73xx_config_aneg(struct phy_device *phydev)
+{
+	int ret;
+
+	ret = vsc73xx_mdix_set(phydev, phydev->mdix_ctrl);
+	if (ret)
+		return ret;
+
+	return genphy_config_aneg(phydev);
+}
+
+static int vsc73xx_mdix_get(struct phy_device *phydev, u8 *mdix)
+{
+	u16 reg_val;
+
+	reg_val = phy_read(phydev, MII_VSC73XX_PHY_AUX_CTRL_STAT);
+	if (reg_val & MII_VSC73XX_PACS_NO_MDI_X_IND)
+		*mdix = ETH_TP_MDI;
+	else
+		*mdix = ETH_TP_MDI_X;
+
+	return 0;
+}
+
+static int vsc73xx_read_status(struct phy_device *phydev)
+{
+	int ret;
+
+	ret = vsc73xx_mdix_get(phydev, &phydev->mdix);
+	if (ret < 0)
+		return ret;
+
+	return genphy_read_status(phydev);
+}
+
 /* This adds a skew for both TX and RX clocks, so the skew should only be
  * applied to "rgmii-id" interfaces. It may not work as expected
  * on "rgmii-txid", "rgmii-rxid" or "rgmii" interfaces.
@@ -516,6 +596,8 @@ static struct phy_driver vsc82xx_driver[] = {
 	.phy_id_mask    = 0x000ffff0,
 	/* PHY_GBIT_FEATURES */
 	.config_init    = vsc738x_config_init,
+	.config_aneg    = vsc73xx_config_aneg,
+	.read_status	= vsc73xx_read_status,
 	.read_page      = vsc73xx_read_page,
 	.write_page     = vsc73xx_write_page,
 	.get_tunable    = vsc73xx_get_tunable,
@@ -526,6 +608,8 @@ static struct phy_driver vsc82xx_driver[] = {
 	.phy_id_mask    = 0x000ffff0,
 	/* PHY_GBIT_FEATURES */
 	.config_init    = vsc738x_config_init,
+	.config_aneg    = vsc73xx_config_aneg,
+	.read_status	= vsc73xx_read_status,
 	.read_page      = vsc73xx_read_page,
 	.write_page     = vsc73xx_write_page,
 	.get_tunable    = vsc73xx_get_tunable,
@@ -536,6 +620,8 @@ static struct phy_driver vsc82xx_driver[] = {
 	.phy_id_mask    = 0x000ffff0,
 	/* PHY_GBIT_FEATURES */
 	.config_init    = vsc739x_config_init,
+	.config_aneg    = vsc73xx_config_aneg,
+	.read_status	= vsc73xx_read_status,
 	.read_page      = vsc73xx_read_page,
 	.write_page     = vsc73xx_write_page,
 	.get_tunable    = vsc73xx_get_tunable,
@@ -546,6 +632,8 @@ static struct phy_driver vsc82xx_driver[] = {
 	.phy_id_mask    = 0x000ffff0,
 	/* PHY_GBIT_FEATURES */
 	.config_init    = vsc739x_config_init,
+	.config_aneg    = vsc73xx_config_aneg,
+	.read_status	= vsc73xx_read_status,
 	.read_page      = vsc73xx_read_page,
 	.write_page     = vsc73xx_write_page,
 	.get_tunable    = vsc73xx_get_tunable,
-- 
2.34.1



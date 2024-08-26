Return-Path: <netdev+bounces-121823-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE22F95ED7A
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 11:38:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8530D2844F7
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 09:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB0991482ED;
	Mon, 26 Aug 2024 09:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dGxUByPL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47E783CA3;
	Mon, 26 Aug 2024 09:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724665058; cv=none; b=hNeIbcxwJZEWVz/Lx4VJeCCr6MwwGKrXM5euOGsodBU4c0ChRlR9eJ7POlls4ft8IQLm8NvUsTHEWNkitS8M0cWnWZ7goXXtPGrCYJQKzczjZXrqlCt7m4VulD3d0maGS022GZhCt1HH6sa9P3P+xFZZyR1HU14Iw5gmrc/FltI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724665058; c=relaxed/simple;
	bh=NsbQu7M4tEss+c6Y2wL0B7gbdyDQWS2Z0nkhMS5KLd4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RVQE+OEQiC3Ijq6LefLdO9F5xQBdNW8Sxz78Jh7cLyOU56NhABw65aiKwl/5FhtKdjfKKmuG86Wz4qGurfCc5CPVSXM/qb/6pMNnNLARX7RK49MQIOxsDjV2I1TN4HV+p+Lwrd+jr9djea4ULq5Kk6uibS0Y0w7CUadhn5Adx24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dGxUByPL; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a86abbd68ffso415610166b.0;
        Mon, 26 Aug 2024 02:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724665055; x=1725269855; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZJcVakD5ss4kZCjtqj+URrNKV2fX2XA/qeyqgDhyBSw=;
        b=dGxUByPL3qA5hQ05l6PG/3esovqw0CniolNjVr67UB/ldgGcJLuZY1AN8F1jLioPPH
         l+kDJp40MFGteT3+FwcrVXs/Z8G+TQx2m2i3Cl22bP4CgjPscyevy9DTo2sTm+q324lh
         FErcMgDM3gwQOrbwYsvFl8s0sFHRwuL539A/mK1hIFAMQZO3ajAreBUBxVOuv3uP58oL
         HF5DD5dv4T0iBY2FvNS6Wuo0vzyp8WUAFPCCzUtTd894lmYrmBDDJRJcGvwaoEWBXmwy
         kQCD9/2Ii0SwvYmcAsNB1F2lnl/4ScRcPhHOoxkHkNJspBmhjcGHj2Az3ENxCZt6/rnM
         IpFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724665055; x=1725269855;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZJcVakD5ss4kZCjtqj+URrNKV2fX2XA/qeyqgDhyBSw=;
        b=iJiGiEPEQ+w2OX0HpwyzFw6xlN2W9xsSwSxGGtJz8d9/uLp0gxfZKksF4tsHiMEjVg
         fneYx95Y44HoQEblDgaOIRLZ3RvJfPBu72bgnVD3UeHdyfK+aeCiXHhH/q8GhDnBo4Eh
         o/Ak30Rw+YzZJ36eFYGS6pvAlfxkYDag3qr9UyNM2uXFHebMogQ4cgKtwfyvI/5ynUaE
         lWSMyhWEBfrTdDRS9rTgNoonsUAXMrFZD5crAEyWj7UrOsnhsfuq0+4cwrXQIbSRIF2o
         C3kDG4heE4FJv4KE0y9rm6ppJX5fkvYTzuh0fci199a++OcIBLUrmAfDEHzq6vovYher
         GzhQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDXnU/0EuJRyhgVa555XnIxYoB6ETE4PAZYVuXkmOj7xUVJmOhFZ1C3x33MPqPPpZ0Lx5F+H49HzJuWQA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd/1XIB7Fq/8CmlX7uTVHF4xVcTVu/KKKT8ibOGVX0b3pHvoUr
	SxaURwQp+WQk4r0FDPEPxakkwKQOqhMiKSINeaNvxO/pqnvbYz5x/weP06Ud
X-Google-Smtp-Source: AGHT+IHzRY/eAHW3N9sVw8x+S0Ogb3NLphxtdQh5WtqVRBDzfsy5Q2/77/ppBWjz1T7Ch+hd3xLDkg==
X-Received: by 2002:a17:907:2d11:b0:a86:a30f:4b00 with SMTP id a640c23a62f3a-a86a30f4d3fmr1057011866b.27.1724665054146;
        Mon, 26 Aug 2024 02:37:34 -0700 (PDT)
Received: from WBEC325.dom.lan ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f4360c0sm640254966b.108.2024.08.26.02.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 02:37:33 -0700 (PDT)
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
Subject: [PATCH net-next v2] net: phy: vitesse: implement MDI-X configuration in vsc73xx
Date: Mon, 26 Aug 2024 11:37:10 +0200
Message-Id: <20240826093710.511837-1-paweldembicki@gmail.com>
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
Changes in v2:
  - set auto MDI-X by default
  - 'switch (mdix)' in 'vsc73xx_mdix_set' should be more readable
---
 drivers/net/phy/vitesse.c | 93 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 93 insertions(+)

diff --git a/drivers/net/phy/vitesse.c b/drivers/net/phy/vitesse.c
index 54eb4e8377c4..2377179de017 100644
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
@@ -219,6 +232,9 @@ static void vsc73xx_config_init(struct phy_device *phydev)
 
 	/* Enable downshift by default */
 	vsc73xx_set_downshift(phydev, MII_VSC73XX_DOWNSHIFT_MAX);
+
+	/* Set Auto MDI-X by default */
+	phydev->mdix_ctrl = ETH_TP_MDI_AUTO;
 }
 
 static int vsc738x_config_init(struct phy_device *phydev)
@@ -319,6 +335,75 @@ static int vsc739x_config_init(struct phy_device *phydev)
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
+	case ETH_TP_MDI_AUTO:
+		val &= ~(MII_VSC73XX_PBC_FOR_SPD_AUTO_MDIX_DIS |
+			 MII_VSC73XX_PBC_PAIR_SWAP_DIS |
+			 MII_VSC73XX_PBC_POL_INV_DIS);
+		break;
+	default:
+		return -EINVAL;
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
@@ -516,6 +601,8 @@ static struct phy_driver vsc82xx_driver[] = {
 	.phy_id_mask    = 0x000ffff0,
 	/* PHY_GBIT_FEATURES */
 	.config_init    = vsc738x_config_init,
+	.config_aneg    = vsc73xx_config_aneg,
+	.read_status	= vsc73xx_read_status,
 	.read_page      = vsc73xx_read_page,
 	.write_page     = vsc73xx_write_page,
 	.get_tunable    = vsc73xx_get_tunable,
@@ -526,6 +613,8 @@ static struct phy_driver vsc82xx_driver[] = {
 	.phy_id_mask    = 0x000ffff0,
 	/* PHY_GBIT_FEATURES */
 	.config_init    = vsc738x_config_init,
+	.config_aneg    = vsc73xx_config_aneg,
+	.read_status	= vsc73xx_read_status,
 	.read_page      = vsc73xx_read_page,
 	.write_page     = vsc73xx_write_page,
 	.get_tunable    = vsc73xx_get_tunable,
@@ -536,6 +625,8 @@ static struct phy_driver vsc82xx_driver[] = {
 	.phy_id_mask    = 0x000ffff0,
 	/* PHY_GBIT_FEATURES */
 	.config_init    = vsc739x_config_init,
+	.config_aneg    = vsc73xx_config_aneg,
+	.read_status	= vsc73xx_read_status,
 	.read_page      = vsc73xx_read_page,
 	.write_page     = vsc73xx_write_page,
 	.get_tunable    = vsc73xx_get_tunable,
@@ -546,6 +637,8 @@ static struct phy_driver vsc82xx_driver[] = {
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



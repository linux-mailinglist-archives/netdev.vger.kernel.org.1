Return-Path: <netdev+bounces-59295-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5807A81A454
	for <lists+netdev@lfdr.de>; Wed, 20 Dec 2023 17:19:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C69B11F26A22
	for <lists+netdev@lfdr.de>; Wed, 20 Dec 2023 16:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBFFB4CE0A;
	Wed, 20 Dec 2023 16:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S9t+T1Al"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F134CDFF
	for <netdev@vger.kernel.org>; Wed, 20 Dec 2023 16:13:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E305CC433C7;
	Wed, 20 Dec 2023 16:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703088783;
	bh=+rnJiRj47sKUD4PY4FismhG5pyfaFnvG3DlWtViNHlI=;
	h=From:To:Cc:Subject:Date:From;
	b=S9t+T1AluW3qLv1s5szz4DZmrwboazuwZgG/JfDYQZ0rKXCR+qufFR1NF65KWEIZG
	 PTNuiURbpEHwlYR2X0JBFTV6VLw4FfLNTiBUeMELs70L8SFYMU6QRNik+SmfCdGjF5
	 zesgl3k6Chz3/gTrpPo+MYom1yeiVGt/vVO7Wu3tGNHFDO15CMHlsECokT8BEh3roX
	 L8NfMJdGVo5qHF8vn7RP8BlESa9TK8WXzpkuA8LwOexUZTCEe8qMyPGpdhYVfJTpZI
	 y1rbuOXQP6101f9F7wKaSHwfw3r7rdvvf5j1jf7pFUNbyG4/Mhk0vUIwFarZLDCAOV
	 qdfLWEl7M1twA==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: netdev@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Russell King <rmk+kernel@armlinux.org.uk>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH net-next] net: phy: extend genphy_c45_read_eee_abilities() to read capability 2 register
Date: Wed, 20 Dec 2023 17:12:58 +0100
Message-ID: <20231220161258.17541-1-kabel@kernel.org>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Extend the generic clause 45 PHY function reading EEE abilities to also
read the IEEE 802.3-2018 45.2.3.11 "EEE control and capability 2"
register.

The new helpers mii_eee_cap2_mod_linkmode_t() and
linkmode_to_mii_eee_cap2_t() only parse the 2500baseT and 5000baseT
EEE bits. The standard also defines bits for 400000baseR, 200000baseR
and 25000baseT, but we don't have ethtool link bits for those now.

Signed-off-by: Marek Behún <kabel@kernel.org>
---
 drivers/net/phy/phy-c45.c    | 47 +++++++++++++++++++++++++++++++++---
 drivers/net/phy/phy_device.c | 12 ++++++++-
 include/linux/mdio.h         | 37 ++++++++++++++++++++++++++++
 include/linux/phy.h          |  2 ++
 4 files changed, 94 insertions(+), 4 deletions(-)

diff --git a/drivers/net/phy/phy-c45.c b/drivers/net/phy/phy-c45.c
index 747d14bf152c..8819ff2ff932 100644
--- a/drivers/net/phy/phy-c45.c
+++ b/drivers/net/phy/phy-c45.c
@@ -830,6 +830,39 @@ static int genphy_c45_read_eee_cap1(struct phy_device *phydev)
 	return 0;
 }
 
+/**
+ * genphy_c45_read_eee_cap2 - read supported EEE link modes from register 3.21
+ * @phydev: target phy_device struct
+ */
+static int genphy_c45_read_eee_cap2(struct phy_device *phydev)
+{
+	int val;
+
+	/* IEEE 802.3-2018 45.2.3.11 EEE control and capability 2
+	 * (Register 3.21)
+	 */
+	val = phy_read_mmd(phydev, MDIO_MMD_PCS, MDIO_PCS_EEE_ABLE2);
+	if (val < 0)
+		return val;
+
+	/* The 802.3 2018 standard says the top 6 bits are reserved and should
+	 * read as 0.
+	 * If MDIO_PCS_EEE_ABLE2 is 0xffff assume EEE is not supported.
+	 */
+	if (val == 0xffff)
+		return 0;
+
+	mii_eee_cap2_mod_linkmode_t(phydev->supported_eee, val);
+
+	/* Some buggy devices may indicate EEE link modes in MDIO_PCS_EEE_ABLE2
+	 * which they don't support as indicated by BMSR, ESTATUS etc.
+	 */
+	linkmode_and(phydev->supported_eee, phydev->supported_eee,
+		     phydev->supported);
+
+	return 0;
+}
+
 /**
  * genphy_c45_read_eee_abilities - read supported EEE link modes
  * @phydev: target phy_device struct
@@ -838,9 +871,11 @@ int genphy_c45_read_eee_abilities(struct phy_device *phydev)
 {
 	int val;
 
-	/* There is not indicator whether optional register
-	 * "EEE control and capability 1" (3.20) is supported. Read it only
-	 * on devices with appropriate linkmodes.
+	/* There is not indicator whether optional registers
+	 * "EEE control and capability 1" (3.20) and
+	 * "EEE control and capability 2" (3.22) are supported. Read them only
+	 * on devices with appropriate
+	 * linkmodes.
 	 */
 	if (linkmode_intersects(phydev->supported, PHY_EEE_CAP1_FEATURES)) {
 		val = genphy_c45_read_eee_cap1(phydev);
@@ -848,6 +883,12 @@ int genphy_c45_read_eee_abilities(struct phy_device *phydev)
 			return val;
 	}
 
+	if (linkmode_intersects(phydev->supported, PHY_EEE_CAP2_FEATURES)) {
+		val = genphy_c45_read_eee_cap2(phydev);
+		if (val)
+			return val;
+	}
+
 	if (linkmode_test_bit(ETHTOOL_LINK_MODE_10baseT1L_Full_BIT,
 			      phydev->supported)) {
 		/* IEEE 802.3cg-2019 45.2.1.186b 10BASE-T1L PMA status register
diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 0c52a9eff188..45e812a0d115 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -148,6 +148,14 @@ static const int phy_eee_cap1_features_array[] = {
 __ETHTOOL_DECLARE_LINK_MODE_MASK(phy_eee_cap1_features) __ro_after_init;
 EXPORT_SYMBOL_GPL(phy_eee_cap1_features);
 
+static const int phy_eee_cap2_features_array[] = {
+	ETHTOOL_LINK_MODE_2500baseT_Full_BIT,
+	ETHTOOL_LINK_MODE_5000baseT_Full_BIT,
+};
+
+__ETHTOOL_DECLARE_LINK_MODE_MASK(phy_eee_cap2_features) __ro_after_init;
+EXPORT_SYMBOL_GPL(phy_eee_cap2_features);
+
 static void features_init(void)
 {
 	/* 10/100 half/full*/
@@ -232,7 +240,9 @@ static void features_init(void)
 	linkmode_set_bit_array(phy_eee_cap1_features_array,
 			       ARRAY_SIZE(phy_eee_cap1_features_array),
 			       phy_eee_cap1_features);
-
+	linkmode_set_bit_array(phy_eee_cap2_features_array,
+			       ARRAY_SIZE(phy_eee_cap2_features_array),
+			       phy_eee_cap2_features);
 }
 
 void phy_device_free(struct phy_device *phydev)
diff --git a/include/linux/mdio.h b/include/linux/mdio.h
index 79ceee3c8673..606b2d6920b9 100644
--- a/include/linux/mdio.h
+++ b/include/linux/mdio.h
@@ -466,6 +466,43 @@ static inline u32 linkmode_to_mii_eee_cap1_t(unsigned long *adv)
 	return result;
 }
 
+/**
+ * mii_eee_cap2_mod_linkmode_t()
+ * @adv: target the linkmode advertisement settings
+ * @val: register value
+ *
+ * A function that translates value of following registers to the linkmode:
+ * IEEE 802.3-2018 45.2.3.11 "EEE control and capability 2" register (3.21)
+ * IEEE 802.3-2018 45.2.7.15 "EEE advertisement 2" register (7.62)
+ * IEEE 802.3-2018 45.2.7.16 "EEE link partner ability 2" register (7.63)
+ */
+static inline void mii_eee_cap2_mod_linkmode_t(unsigned long *adv, u32 val)
+{
+	linkmode_mod_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT,
+			 adv, val & MDIO_EEE_2_5GT);
+	linkmode_mod_bit(ETHTOOL_LINK_MODE_5000baseT_Full_BIT,
+			 adv, val & MDIO_EEE_5GT);
+}
+
+/**
+ * linkmode_to_mii_eee_cap2_t()
+ * @adv: the linkmode advertisement settings
+ *
+ * A function that translates linkmode to value for IEEE 802.3-2018 45.2.7.16
+ * "EEE advertisement 2" register (7.63)
+ */
+static inline u32 linkmode_to_mii_eee_cap2_t(unsigned long *adv)
+{
+	u32 result = 0;
+
+	if (linkmode_test_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT, adv))
+		result |= MDIO_EEE_2_5GT;
+	if (linkmode_test_bit(ETHTOOL_LINK_MODE_5000baseT_Full_BIT, adv))
+		result |= MDIO_EEE_5GT;
+
+	return result;
+}
+
 /**
  * mii_10base_t1_adv_mod_linkmode_t()
  * @adv: linkmode advertisement settings
diff --git a/include/linux/phy.h b/include/linux/phy.h
index e9e85d347587..dbaddd8f3cdf 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -54,6 +54,7 @@ extern __ETHTOOL_DECLARE_LINK_MODE_MASK(phy_10gbit_features) __ro_after_init;
 extern __ETHTOOL_DECLARE_LINK_MODE_MASK(phy_10gbit_fec_features) __ro_after_init;
 extern __ETHTOOL_DECLARE_LINK_MODE_MASK(phy_10gbit_full_features) __ro_after_init;
 extern __ETHTOOL_DECLARE_LINK_MODE_MASK(phy_eee_cap1_features) __ro_after_init;
+extern __ETHTOOL_DECLARE_LINK_MODE_MASK(phy_eee_cap2_features) __ro_after_init;
 
 #define PHY_BASIC_FEATURES ((unsigned long *)&phy_basic_features)
 #define PHY_BASIC_T1_FEATURES ((unsigned long *)&phy_basic_t1_features)
@@ -65,6 +66,7 @@ extern __ETHTOOL_DECLARE_LINK_MODE_MASK(phy_eee_cap1_features) __ro_after_init;
 #define PHY_10GBIT_FEC_FEATURES ((unsigned long *)&phy_10gbit_fec_features)
 #define PHY_10GBIT_FULL_FEATURES ((unsigned long *)&phy_10gbit_full_features)
 #define PHY_EEE_CAP1_FEATURES ((unsigned long *)&phy_eee_cap1_features)
+#define PHY_EEE_CAP2_FEATURES ((unsigned long *)&phy_eee_cap2_features)
 
 extern const int phy_basic_ports_array[3];
 extern const int phy_fibre_port_array[1];
-- 
2.41.0



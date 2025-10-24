Return-Path: <netdev+bounces-232407-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 58757C056C6
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 11:49:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B3D0E4EFB06
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 09:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E30330B51B;
	Fri, 24 Oct 2025 09:49:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF57223D7D1;
	Fri, 24 Oct 2025 09:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761299376; cv=none; b=e9UDaYQER8P+5OJKeP4xn1YAZ468ghGvEynIKA2cx+iuctUeJ+yB71lkKv0ZcJwuTi8xs8+daF4Ik0F0+rNUdyQffCo0EtkXAdl5fimgkqlGVaznLM5lRAcTbWNGc/+nFPqSS3navC8FRueFdYeDioreqxjNmpRjtZJps/8mNbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761299376; c=relaxed/simple;
	bh=x2vktbSifIZ7s6dEUBa+yDl9FX2MZDIRSD3xi76iRgc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=pCSHo84g6HPWkLHWad3JoAfChBLWQK36/In5lExl+8jjBI/QD7tlvrneYqUIttZdNriQ+IrrWrwfbBeuVNsAykZdEPQqheeYAuBLujB7EflllE40QIZyJej+OXWU2N1zldd+hR2bLlHcb36+re0B4hdvq2LG3bxulVyAjGuapMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Received: from sven-desktop.home.narfation.org (p200300c5970781E00000000000000C00.dip0.t-ipconnect.de [IPv6:2003:c5:9707:81e0::c00])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id 9C125FA130;
	Fri, 24 Oct 2025 11:49:31 +0200 (CEST)
From: Sven Eckelmann <se@simonwunderlich.de>
Date: Fri, 24 Oct 2025 11:49:00 +0200
Subject: [PATCH] net: phy: realtek: Add RTL8224 cable testing support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251024-rtl8224-cable-test-v1-1-e3cda89ac98f@simonwunderlich.de>
X-B4-Tracking: v=1; b=H4sIAItL+2gC/x2MOwqAMBAFryJbG9Alfq8iFjE+dUFUkiBC8O4Gq
 2GKmUgeTuCpzyI53OLlPJKUeUZ2M8cKJXNy4oKrsmCtXNhbTrRm2qECfFBWVzDgpe4aTSm8HBZ
 5/ukwvu8HbH7i8mQAAAA=
X-Change-ID: 20251024-rtl8224-cable-test-c45eae2f6974
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 sw@simonwunderlich.de, Issam Hamdi <ih@simonwunderlich.de>, 
 Sven Eckelmann <se@simonwunderlich.de>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=7749; i=se@simonwunderlich.de;
 h=from:subject:message-id; bh=t+ceAQEaWEG2TVyVG/xKI8Le8OSgariURqbU8NUnzGM=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDBm/vZcq/2G6z31Qxa5+sfOKINkD1/eqfZlTI38h61CDz
 u3/igxXO0pZGMS4GGTFFFn2XMk/v5n9rfznaR+PwsxhZQIZwsDFKQAT+aHDyHBO/eN9lqUPds2d
 azt905rtnmJ6rSsdqzOPV3vyMvyYXr2V4Tf74tmPg07an1+18sD+dyvfveybtbWv4fvHYpZa0Uv
 hx76zAwA=
X-Developer-Key: i=se@simonwunderlich.de; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF

From: Issam Hamdi <ih@simonwunderlich.de>

The RTL8224 can detect open pairs and short types (in same pair or some
other pair). The distance to this problem can be estimated. This is done
for each of the 4 pairs separately.

It is not meant to be run while there is an active link partner because
this interferes with the active test pulses.

Output with open 50 m cable:

  Pair A code Open Circuit, source: TDR
  Pair A, fault length: 51.79m, source: TDR
  Pair B code Open Circuit, source: TDR
  Pair B, fault length: 51.28m, source: TDR
  Pair C code Open Circuit, source: TDR
  Pair C, fault length: 50.46m, source: TDR
  Pair D code Open Circuit, source: TDR
  Pair D, fault length: 51.12m, source: TDR

Terminated cable:

  Pair A code OK, source: TDR
  Pair B code OK, source: TDR
  Pair C code OK, source: TDR
  Pair D code OK, source: TDR

Shorted cable (both short types are at roughly the same distance)

  Pair A code Short to another pair, source: TDR
  Pair A, fault length: 2.35m, source: TDR
  Pair B code Short to another pair, source: TDR
  Pair B, fault length: 2.15m, source: TDR
  Pair C code OK, source: TDR
  Pair D code Short within Pair, source: TDR
  Pair D, fault length: 1.94m, source: TDR

Signed-off-by: Issam Hamdi <ih@simonwunderlich.de>
Co-developed-by: Sven Eckelmann <se@simonwunderlich.de>
Signed-off-by: Sven Eckelmann <se@simonwunderlich.de>
---
 drivers/net/phy/realtek/realtek_main.c | 187 +++++++++++++++++++++++++++++++++
 1 file changed, 187 insertions(+)

diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
index 16a347084293..1fd4b6cf5c1e 100644
--- a/drivers/net/phy/realtek/realtek_main.c
+++ b/drivers/net/phy/realtek/realtek_main.c
@@ -8,6 +8,7 @@
  * Copyright (c) 2004 Freescale Semiconductor, Inc.
  */
 #include <linux/bitops.h>
+#include <linux/ethtool_netlink.h>
 #include <linux/of.h>
 #include <linux/phy.h>
 #include <linux/pm_wakeirq.h>
@@ -127,6 +128,27 @@
  */
 #define RTL822X_VND2_C22_REG(reg)		(0xa400 + 2 * (reg))
 
+#define RTL8224_MII_RTCT			0x11
+#define RTL8224_MII_RTCT_ENABLE			BIT(0)
+#define RTL8224_MII_RTCT_PAIR_A			BIT(4)
+#define RTL8224_MII_RTCT_PAIR_B			BIT(5)
+#define RTL8224_MII_RTCT_PAIR_C			BIT(6)
+#define RTL8224_MII_RTCT_PAIR_D			BIT(7)
+#define RTL8224_MII_RTCT_DONE			BIT(15)
+
+#define RTL8224_MII_SRAM_ADDR			0x1b
+#define RTL8224_MII_SRAM_DATA			0x1c
+
+#define RTL8224_SRAM_RTCT_FAULT(pair)		(0x8026 + (pair) * 4)
+#define RTL8224_SRAM_RTCT_FAULT_BUSY		BIT(0)
+#define RTL8224_SRAM_RTCT_FAULT_OPEN		BIT(3)
+#define RTL8224_SRAM_RTCT_FAULT_SAME_SHORT	BIT(4)
+#define RTL8224_SRAM_RTCT_FAULT_OK		BIT(5)
+#define RTL8224_SRAM_RTCT_FAULT_DONE		BIT(6)
+#define RTL8224_SRAM_RTCT_FAULT_CROSS_SHORT	BIT(7)
+
+#define RTL8224_SRAM_RTCT_LEN(pair)		(0x8028 + (pair) * 4)
+
 #define RTL8366RB_POWER_SAVE			0x15
 #define RTL8366RB_POWER_SAVE_ON			BIT(12)
 
@@ -1453,6 +1475,168 @@ static int rtl822xb_c45_read_status(struct phy_device *phydev)
 	return 0;
 }
 
+static int rtl8224_cable_test_start(struct phy_device *phydev)
+{
+	u32 val;
+	int ret;
+
+	/* disable auto-negotiation and force 1000/Full */
+	ret = phy_modify_mmd(phydev, MDIO_MMD_VEND2,
+			     RTL822X_VND2_C22_REG(MII_BMCR),
+			     BMCR_ANENABLE | BMCR_SPEED100 | BMCR_SPEED10,
+			     BMCR_SPEED1000 | BMCR_FULLDPLX);
+	if (ret)
+		return ret;
+
+	mdelay(500);
+
+	/* trigger cable test */
+	val = RTL8224_MII_RTCT_ENABLE;
+	val |= RTL8224_MII_RTCT_PAIR_A;
+	val |= RTL8224_MII_RTCT_PAIR_B;
+	val |= RTL8224_MII_RTCT_PAIR_C;
+	val |= RTL8224_MII_RTCT_PAIR_D;
+
+	return phy_modify_mmd(phydev, MDIO_MMD_VEND2,
+			      RTL822X_VND2_C22_REG(RTL8224_MII_RTCT),
+			      RTL8224_MII_RTCT_DONE, val);
+}
+
+static int rtl8224_sram_read(struct phy_device *phydev, u32 reg)
+{
+	int ret;
+
+	ret = phy_write_mmd(phydev, MDIO_MMD_VEND2,
+			    RTL822X_VND2_C22_REG(RTL8224_MII_SRAM_ADDR),
+			    reg);
+	if (ret)
+		return ret;
+
+	return phy_read_mmd(phydev, MDIO_MMD_VEND2,
+			    RTL822X_VND2_C22_REG(RTL8224_MII_SRAM_DATA));
+}
+
+static int rtl8224_pair_len_get(struct phy_device *phydev, u32 pair)
+{
+	int cable_len;
+	u32 reg_len;
+	int ret;
+	u32 cm;
+
+	reg_len = RTL8224_SRAM_RTCT_LEN(pair);
+
+	ret = rtl8224_sram_read(phydev, reg_len);
+	if (ret < 0)
+		return ret;
+
+	cable_len = ret & 0xff00;
+
+	ret = rtl8224_sram_read(phydev, reg_len + 1);
+	if (ret < 0)
+		return ret;
+
+	cable_len |= (ret & 0xff00) >> 8;
+
+	cable_len -= 620;
+	cable_len = max(cable_len, 0);
+
+	cm = cable_len * 100 / 78;
+
+	return cm;
+}
+
+static int rtl8224_cable_test_result_trans(u32 result)
+{
+	if (!(result & RTL8224_SRAM_RTCT_FAULT_DONE))
+		return -EBUSY;
+
+	if (result & RTL8224_SRAM_RTCT_FAULT_OK)
+		return ETHTOOL_A_CABLE_RESULT_CODE_OK;
+
+	if (result & RTL8224_SRAM_RTCT_FAULT_OPEN)
+		return ETHTOOL_A_CABLE_RESULT_CODE_OPEN;
+
+	if (result & RTL8224_SRAM_RTCT_FAULT_SAME_SHORT)
+		return ETHTOOL_A_CABLE_RESULT_CODE_SAME_SHORT;
+
+	if (result & RTL8224_SRAM_RTCT_FAULT_BUSY)
+		return ETHTOOL_A_CABLE_RESULT_CODE_UNSPEC;
+
+	if (result & RTL8224_SRAM_RTCT_FAULT_CROSS_SHORT)
+		return ETHTOOL_A_CABLE_RESULT_CODE_CROSS_SHORT;
+
+	return ETHTOOL_A_CABLE_RESULT_CODE_UNSPEC;
+}
+
+static int rtl8224_cable_test_report_pair(struct phy_device *phydev, unsigned int pair)
+{
+	int fault_rslt;
+	int ret;
+
+	ret = rtl8224_sram_read(phydev, RTL8224_SRAM_RTCT_FAULT(pair));
+	if (ret < 0)
+		return ret;
+
+	fault_rslt = rtl8224_cable_test_result_trans(ret);
+	if (fault_rslt < 0)
+		return 0;
+
+	ret = ethnl_cable_test_result(phydev, pair, fault_rslt);
+	if (ret < 0)
+		return ret;
+
+	switch (fault_rslt) {
+	case ETHTOOL_A_CABLE_RESULT_CODE_OPEN:
+	case ETHTOOL_A_CABLE_RESULT_CODE_SAME_SHORT:
+	case ETHTOOL_A_CABLE_RESULT_CODE_CROSS_SHORT:
+		ret = rtl8224_pair_len_get(phydev, pair);
+		if (ret < 0)
+			return ret;
+
+		return ethnl_cable_test_fault_length(phydev, pair, ret);
+	default:
+		return  0;
+	}
+}
+
+static int rtl8224_cable_test_report(struct phy_device *phydev, bool *finished)
+{
+	unsigned int pair;
+	int ret;
+
+	for (pair = ETHTOOL_A_CABLE_PAIR_A; pair <= ETHTOOL_A_CABLE_PAIR_D; pair++) {
+		ret = rtl8224_cable_test_report_pair(phydev, pair);
+		if (ret == -EBUSY) {
+			*finished = false;
+			return 0;
+		}
+
+		if (ret < 0)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int rtl8224_cable_test_get_status(struct phy_device *phydev, bool *finished)
+{
+	int ret;
+
+	*finished = false;
+
+	ret = phy_read_mmd(phydev, MDIO_MMD_VEND2,
+			   RTL822X_VND2_C22_REG(RTL8224_MII_RTCT));
+	if (ret < 0)
+		return ret;
+
+	if (!(ret & RTL8224_MII_RTCT_DONE))
+		return 0;
+
+	*finished = true;
+
+	return rtl8224_cable_test_report(phydev, finished);
+}
+
 static bool rtlgen_supports_2_5gbps(struct phy_device *phydev)
 {
 	int val;
@@ -1930,11 +2114,14 @@ static struct phy_driver realtek_drvs[] = {
 	}, {
 		PHY_ID_MATCH_EXACT(0x001ccad0),
 		.name		= "RTL8224 2.5Gbps PHY",
+		.flags		= PHY_POLL_CABLE_TEST,
 		.get_features   = rtl822x_c45_get_features,
 		.config_aneg    = rtl822x_c45_config_aneg,
 		.read_status    = rtl822x_c45_read_status,
 		.suspend        = genphy_c45_pma_suspend,
 		.resume         = rtlgen_c45_resume,
+		.cable_test_start = rtl8224_cable_test_start,
+		.cable_test_get_status = rtl8224_cable_test_get_status,
 	}, {
 		PHY_ID_MATCH_EXACT(0x001cc961),
 		.name		= "RTL8366RB Gigabit Ethernet",

---
base-commit: f0a24b2547cfdd5ec85a131e386a2ce4ff9179cb
change-id: 20251024-rtl8224-cable-test-c45eae2f6974

Best regards,
-- 
Sven Eckelmann <se@simonwunderlich.de>



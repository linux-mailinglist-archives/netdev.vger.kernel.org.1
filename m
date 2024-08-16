Return-Path: <netdev+bounces-119168-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83DF19546F7
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 12:52:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F5C11C2340A
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 10:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A4F519D094;
	Fri, 16 Aug 2024 10:52:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5AB16F273
	for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 10:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723805533; cv=none; b=MJiskVON677plAPTasfgdmZsdcwRczxFPEmAs2W9AxRneGyjg5kRW5gdwDPsE66u2j6iZf1sK9qf1ItDE/k0wbouoD+0dQWTcF9hc24dmv71oL614NjHSl/2oueouGf5LfHVSz3QMdyBEpkdNqHx1piBGRviva4+K3AZ1UgHG+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723805533; c=relaxed/simple;
	bh=C0Lj3s6rGWRY9u7RC0hMC7LlXn1RirJdOgbQEBApXyE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lqXz6H550hdMiKvGR62YcIJ+gB9NOaLf+FjCZ5XpVXbxN1DZbOR4SR7a1nrUYfAU3OeljBkopXeS4fYyP5is4mc14w8CUGMnja7XXybUNTcYXolMsOm4sfNPWtID5ozkp7bZlOXn1kqJc0yN0jO4F4pOcP+xfNJC6rm9ld4FN88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1seuYp-00083g-3U; Fri, 16 Aug 2024 12:51:59 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1seuYn-000okl-F3; Fri, 16 Aug 2024 12:51:57 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1seuYn-007lTq-1G;
	Fri, 16 Aug 2024 12:51:57 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next v1 1/1] phy: dp83td510: Utilize ALCD for cable length measurement when link is active
Date: Fri, 16 Aug 2024 12:51:55 +0200
Message-Id: <20240816105155.1850795-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

In industrial environments where 10BaseT1L PHYs are replacing existing
field bus systems like CAN, it's often essential to retain the existing
cable infrastructure. After installation, collecting metrics such as
cable length is crucial for assessing the quality of the infrastructure.
Traditionally, TDR (Time Domain Reflectometry) is used for this purpose.
However, TDR requires interrupting the link, and if the link partner
remains active, the TDR measurement will fail.

Unlike multi-pair systems, where TDR can be attempted during the MDI-X
switching window, 10BaseT1L systems face greater challenges. The TDR
sequence on 10BaseT1L is longer and coincides with uninterrupted
autonegotiation pulses, making TDR impossible when the link partner is
active.

The DP83TD510 PHY provides an alternative through ALCD (Active Link
Cable Diagnostics), which allows for cable length measurement without
disrupting an active link. Since a live link indicates no short or open
cable states, ALCD can be used effectively to gather cable length
information.

Enhance the dp83td510 driver by:
- Leveraging ALCD to measure cable length when the link is active.
- Bypassing TDR when a link is detected, as ALCD provides the required
  information without disruption.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/net/phy/dp83td510.c | 80 ++++++++++++++++++++++++++++++++++---
 1 file changed, 74 insertions(+), 6 deletions(-)

diff --git a/drivers/net/phy/dp83td510.c b/drivers/net/phy/dp83td510.c
index 551e37786c2da..72c33079fc665 100644
--- a/drivers/net/phy/dp83td510.c
+++ b/drivers/net/phy/dp83td510.c
@@ -169,6 +169,10 @@ static const u16 dp83td510_mse_sqi_map[] = {
 #define DP83TD510E_UNKN_030E				0x30e
 #define DP83TD510E_030E_VAL				0x2520
 
+#define DP83TD510E_ALCD_STAT				0xa9f
+#define DP83TD510E_ALCD_COMPLETE			BIT(15)
+#define DP83TD510E_ALCD_CABLE_LENGTH			GENMASK(10, 0)
+
 static int dp83td510_config_intr(struct phy_device *phydev)
 {
 	int ret;
@@ -327,6 +331,16 @@ static int dp83td510_cable_test_start(struct phy_device *phydev)
 {
 	int ret;
 
+	/* If link partner is active, we won't be able to use TDR, since
+	 * we can't force link partner to be silent. The autonegotiation
+	 * pulses will be too frequent and the TDR sequence will be
+	 * too long. So, TDR will always fail. Since the link is established
+	 * we already know that the cable is working, so we can get some
+	 * extra information line the cable length using ALCD.
+	 */
+	if (phydev->link)
+		return 0;
+
 	ret = phy_set_bits_mmd(phydev, MDIO_MMD_VEND2, DP83TD510E_CTRL,
 			       DP83TD510E_CTRL_HW_RESET);
 	if (ret)
@@ -402,8 +416,8 @@ static int dp83td510_cable_test_start(struct phy_device *phydev)
 }
 
 /**
- * dp83td510_cable_test_get_status - Get the status of the cable test for the
- *                                   DP83TD510 PHY.
+ * dp83td510_cable_test_get_tdr_status - Get the status of the TDR test for the
+ *                                       DP83TD510 PHY.
  * @phydev: Pointer to the phy_device structure.
  * @finished: Pointer to a boolean that indicates whether the test is finished.
  *
@@ -411,13 +425,11 @@ static int dp83td510_cable_test_start(struct phy_device *phydev)
  *
  * Returns: 0 on success or a negative error code on failure.
  */
-static int dp83td510_cable_test_get_status(struct phy_device *phydev,
-					   bool *finished)
+static int dp83td510_cable_test_get_tdr_status(struct phy_device *phydev,
+					       bool *finished)
 {
 	int ret, stat;
 
-	*finished = false;
-
 	ret = phy_read_mmd(phydev, MDIO_MMD_VEND2, DP83TD510E_TDR_CFG);
 	if (ret < 0)
 		return ret;
@@ -459,6 +471,62 @@ static int dp83td510_cable_test_get_status(struct phy_device *phydev,
 	return phy_init_hw(phydev);
 }
 
+/**
+ * dp83td510_cable_test_get_alcd_status - Get the status of the ALCD test for the
+ * 				      DP83TD510 PHY.
+ * @phydev: Pointer to the phy_device structure.
+ * @finished: Pointer to a boolean that indicates whether the test is finished.
+ *
+ * The function sets the @finished flag to true if the test is complete.
+ * The function reads the cable length and reports it to the user.
+ *
+ * Returns: 0 on success or a negative error code on failure.
+ */
+static int dp83td510_cable_test_get_alcd_status(struct phy_device *phydev,
+						bool *finished)
+{
+	unsigned int location;
+	int ret;
+
+	ret = phy_read_mmd(phydev, MDIO_MMD_VEND2, DP83TD510E_ALCD_STAT);
+	if (ret < 0)
+		return ret;
+
+	if (!(ret & DP83TD510E_ALCD_COMPLETE))
+		return 0;
+
+	location = FIELD_GET(DP83TD510E_ALCD_CABLE_LENGTH, ret) * 100;
+
+	ethnl_cable_test_fault_length(phydev, ETHTOOL_A_CABLE_PAIR_A, location);
+
+	ethnl_cable_test_result(phydev, ETHTOOL_A_CABLE_PAIR_A,
+				ETHTOOL_A_CABLE_RESULT_CODE_OK);
+	*finished = true;
+
+	return 0;
+}
+
+/**
+ * dp83td510_cable_test_get_status - Get the status of the cable test for the
+ *                                   DP83TD510 PHY.
+ * @phydev: Pointer to the phy_device structure.
+ * @finished: Pointer to a boolean that indicates whether the test is finished.
+ *
+ * The function sets the @finished flag to true if the test is complete.
+ *
+ * Returns: 0 on success or a negative error code on failure.
+ */
+static int dp83td510_cable_test_get_status(struct phy_device *phydev,
+					   bool *finished)
+{
+	*finished = false;
+
+	if (!phydev->link)
+		return dp83td510_cable_test_get_tdr_status(phydev, finished);
+
+	return dp83td510_cable_test_get_alcd_status(phydev, finished);
+}
+
 static int dp83td510_get_features(struct phy_device *phydev)
 {
 	/* This PHY can't respond on MDIO bus if no RMII clock is enabled.
-- 
2.39.2



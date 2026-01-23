Return-Path: <netdev+bounces-252673-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8OI9Jl4qc2l7swAAu9opvQ
	(envelope-from <netdev+bounces-252673-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 08:59:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E332D7217F
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 08:59:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 938A830115A8
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 07:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE28133F396;
	Fri, 23 Jan 2026 07:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mork.no header.i=@mork.no header.b="F9IuqsUw"
X-Original-To: netdev@vger.kernel.org
Received: from dilbert.mork.no (dilbert.mork.no [65.108.154.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC00330657;
	Fri, 23 Jan 2026 07:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.108.154.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769155163; cv=none; b=MKdpHePBSf5+o6XFldC6r4WXjLAXcwloaIf/QL+w22ESX3eAewo3Qqp8yR5R7puaHtCxQyYGgQ3v+1IbPSzD+PVttfI5K7tJXeqbvpdyTVS9zWJZIU2yXMVFPrb16Bu9b6LhOv/PKGZ/MEYbFEKqwzaGZHQSSen/PXpylPOdsaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769155163; c=relaxed/simple;
	bh=fTCqFHZj/OY/3Ab1Lck/ssuVgcSHr/dHEJUd9vrOZOk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hbtiD/qeiks4dVgpM8rCHS9dTprN+XW5vJ1W/Ygs5ppTzq2zCo89sb8hocvl02NTFUQRfbsPUs+vnAIqm3ZGa4EXuLBmMw4C1zOSbf+yKLqsvE2AhqH3ZF2SntamKHxo8CxrtI9+JWEbwU80kI9vNFPNwbCTrQWGQcOKbF+RL0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mork.no; spf=pass smtp.mailfrom=miraculix.mork.no; dkim=pass (1024-bit key) header.d=mork.no header.i=@mork.no header.b=F9IuqsUw; arc=none smtp.client-ip=65.108.154.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mork.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=miraculix.mork.no
Authentication-Results: dilbert.mork.no;
	dkim=pass (1024-bit key; secure) header.d=mork.no header.i=@mork.no header.a=rsa-sha256 header.s=b header.b=F9IuqsUw;
	dkim-atps=neutral
Received: from canardo.dyn.mork.no ([IPv6:2a01:799:10e2:d900:0:0:0:1])
	(authenticated bits=0)
	by dilbert.mork.no (8.18.1/8.18.1) with ESMTPSA id 60N7wfus1303108
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Fri, 23 Jan 2026 07:58:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mork.no; s=b;
	t=1769155121; bh=35Bf9EwSz+MEQ6C6HQ7TLaDA2eaYXECWAxshTaANixY=;
	h=From:To:Cc:Subject:Date:Message-ID:References:From;
	b=F9IuqsUwGjeYZqaguR6oT/RoguyChfaiJblIkP9E+TxE8zO16RQ6XMjaQsCznraSy
	 SPZpIUMGGpmnYxlnCplDY5Q/xY7eTOGQfiLi+teTU/FQeJvto4KsHnILxYhgtc0VVf
	 JIIhnQv8w3AaKdYK3+SEx26TtR2P1Ov+/k5Chqqo=
Received: from miraculix.mork.no ([IPv6:2a01:799:10e2:d90a:6f50:7559:681d:630c])
	(authenticated bits=0)
	by canardo.dyn.mork.no (8.18.1/8.18.1) with ESMTPSA id 60N7webn3568538
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Fri, 23 Jan 2026 08:58:41 +0100
Received: (nullmailer pid 1162098 invoked by uid 1000);
	Fri, 23 Jan 2026 07:58:40 -0000
From: =?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>
To: netdev@vger.kernel.org
Cc: "Lucien.Jheng" <lucienzx159@gmail.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>
Subject: [PATCH net-next v2 1/3] net: phy: air_en8811h: factor out shareable code
Date: Fri, 23 Jan 2026 08:58:15 +0100
Message-ID: <20260123075817.1162068-2-bjorn@mork.no>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260123075817.1162068-1-bjorn@mork.no>
References: <20260123075817.1162068-1-bjorn@mork.no>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 1.4.3 at canardo.mork.no
X-Virus-Status: Clean
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mork.no,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[mork.no:s=b];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[gmail.com,makrotopia.org,nxp.com,lunn.ch,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,mork.no];
	TAGGED_FROM(0.00)[bounces-252673-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bjorn@mork.no,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[mork.no:+];
	NEURAL_HAM(-0.00)[-0.989];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mork.no:email,mork.no:dkim,mork.no:mid]
X-Rspamd-Queue-Id: E332D7217F
X-Rspamd-Action: no action

Create reusable helpers in preparation for the AN8811HB support.

Signed-off-by: Bjørn Mork <bjorn@mork.no>
---
 drivers/net/phy/air_en8811h.c | 123 +++++++++++++++++++++-------------
 1 file changed, 77 insertions(+), 46 deletions(-)

diff --git a/drivers/net/phy/air_en8811h.c b/drivers/net/phy/air_en8811h.c
index e890bb2c0aa8..e617108fe469 100644
--- a/drivers/net/phy/air_en8811h.c
+++ b/drivers/net/phy/air_en8811h.c
@@ -448,6 +448,11 @@ static int en8811h_wait_mcu_ready(struct phy_device *phydev)
 {
 	int ret, reg_value;
 
+	ret = air_buckpbus_reg_write(phydev, EN8811H_FW_CTRL_1,
+				     EN8811H_FW_CTRL_1_FINISH);
+	if (ret)
+		return ret;
+
 	/* Because of mdio-lock, may have to wait for multiple loads */
 	ret = phy_read_mmd_poll_timeout(phydev, MDIO_MMD_VEND1,
 					EN8811H_PHY_FW_STATUS, reg_value,
@@ -461,9 +466,18 @@ static int en8811h_wait_mcu_ready(struct phy_device *phydev)
 	return 0;
 }
 
-static int en8811h_load_firmware(struct phy_device *phydev)
+static void en8811h_print_fw_version(struct phy_device *phydev)
 {
 	struct en8811h_priv *priv = phydev->priv;
+
+	air_buckpbus_reg_read(phydev, EN8811H_FW_VERSION,
+			      &priv->firmware_version);
+	phydev_info(phydev, "MD32 firmware version: %08x\n",
+		    priv->firmware_version);
+}
+
+static int en8811h_load_firmware(struct phy_device *phydev)
+{
 	struct device *dev = &phydev->mdio.dev;
 	const struct firmware *fw1, *fw2;
 	int ret;
@@ -500,17 +514,11 @@ static int en8811h_load_firmware(struct phy_device *phydev)
 	if (ret < 0)
 		goto en8811h_load_firmware_out;
 
-	ret = air_buckpbus_reg_write(phydev, EN8811H_FW_CTRL_1,
-				     EN8811H_FW_CTRL_1_FINISH);
+	ret = en8811h_wait_mcu_ready(phydev);
 	if (ret < 0)
 		goto en8811h_load_firmware_out;
 
-	ret = en8811h_wait_mcu_ready(phydev);
-
-	air_buckpbus_reg_read(phydev, EN8811H_FW_VERSION,
-			      &priv->firmware_version);
-	phydev_info(phydev, "MD32 firmware version: %08x\n",
-		    priv->firmware_version);
+	en8811h_print_fw_version(phydev);
 
 en8811h_load_firmware_out:
 	release_firmware(fw2);
@@ -533,11 +541,6 @@ static int en8811h_restart_mcu(struct phy_device *phydev)
 	if (ret < 0)
 		return ret;
 
-	ret = air_buckpbus_reg_write(phydev, EN8811H_FW_CTRL_1,
-				     EN8811H_FW_CTRL_1_FINISH);
-	if (ret < 0)
-		return ret;
-
 	return en8811h_wait_mcu_ready(phydev);
 }
 
@@ -919,6 +922,23 @@ static int en8811h_clk_provider_setup(struct device *dev, struct clk_hw *hw)
 	return devm_of_clk_add_hw_provider(dev, of_clk_hw_simple_get, hw);
 }
 
+static int en8811h_leds_setup(struct phy_device *phydev)
+{
+	struct en8811h_priv *priv = phydev->priv;
+	int ret;
+
+	priv->led[0].rules = AIR_DEFAULT_TRIGGER_LED0;
+	priv->led[1].rules = AIR_DEFAULT_TRIGGER_LED1;
+	priv->led[2].rules = AIR_DEFAULT_TRIGGER_LED2;
+
+	ret = air_leds_init(phydev, EN8811H_LED_COUNT, AIR_PHY_LED_DUR,
+			    AIR_LED_MODE_DISABLE);
+	if (ret < 0)
+		phydev_err(phydev, "Failed to disable leds: %d\n", ret);
+
+	return ret;
+}
+
 static int en8811h_probe(struct phy_device *phydev)
 {
 	struct en8811h_priv *priv;
@@ -937,19 +957,12 @@ static int en8811h_probe(struct phy_device *phydev)
 	/* mcu has just restarted after firmware load */
 	priv->mcu_needs_restart = false;
 
-	priv->led[0].rules = AIR_DEFAULT_TRIGGER_LED0;
-	priv->led[1].rules = AIR_DEFAULT_TRIGGER_LED1;
-	priv->led[2].rules = AIR_DEFAULT_TRIGGER_LED2;
-
 	/* MDIO_DEVS1/2 empty, so set mmds_present bits here */
 	phydev->c45_ids.mmds_present |= MDIO_DEVS_PMAPMD | MDIO_DEVS_AN;
 
-	ret = air_leds_init(phydev, EN8811H_LED_COUNT, AIR_PHY_LED_DUR,
-			    AIR_LED_MODE_DISABLE);
-	if (ret < 0) {
-		phydev_err(phydev, "Failed to disable leds: %d\n", ret);
+	ret = en8811h_leds_setup(phydev);
+	if (ret < 0)
 		return ret;
-	}
 
 	priv->phydev = phydev;
 	/* Co-Clock Output */
@@ -1090,11 +1103,9 @@ static int en8811h_config_aneg(struct phy_device *phydev)
 	return __genphy_config_aneg(phydev, changed);
 }
 
-static int en8811h_read_status(struct phy_device *phydev)
+static int en8811h_get_lpa(struct phy_device *phydev)
 {
-	struct en8811h_priv *priv = phydev->priv;
-	u32 pbus_value;
-	int ret, val;
+	int ret;
 
 	ret = genphy_update_link(phydev);
 	if (ret)
@@ -1112,23 +1123,12 @@ static int en8811h_read_status(struct phy_device *phydev)
 	if (ret < 0)
 		return ret;
 
-	ret = genphy_read_lpa(phydev);
-	if (ret < 0)
-		return ret;
-
-	/* Get link partner 2.5GBASE-T ability from vendor register */
-	ret = air_buckpbus_reg_read(phydev, EN8811H_2P5G_LPA, &pbus_value);
-	if (ret < 0)
-		return ret;
-	linkmode_mod_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT,
-			 phydev->lp_advertising,
-			 pbus_value & EN8811H_2P5G_LPA_2P5G);
-
-	if (phydev->autoneg_complete)
-		phy_resolve_aneg_pause(phydev);
+	return genphy_read_lpa(phydev);
+}
 
-	if (!phydev->link)
-		return 0;
+static int en8811h_get_speed(struct phy_device *phydev)
+{
+	int val;
 
 	/* Get real speed from vendor register */
 	val = phy_read(phydev, AIR_AUX_CTRL_STATUS);
@@ -1146,6 +1146,40 @@ static int en8811h_read_status(struct phy_device *phydev)
 		break;
 	}
 
+	/* Only supports full duplex */
+	phydev->duplex = DUPLEX_FULL;
+
+	return 0;
+}
+
+static int en8811h_read_status(struct phy_device *phydev)
+{
+	struct en8811h_priv *priv = phydev->priv;
+	u32 pbus_value;
+	int ret;
+
+	ret = en8811h_get_lpa(phydev);
+	if (ret < 0)
+		return ret;
+
+	/* Get link partner 2.5GBASE-T ability from vendor register */
+	ret = air_buckpbus_reg_read(phydev, EN8811H_2P5G_LPA, &pbus_value);
+	if (ret < 0)
+		return ret;
+	linkmode_mod_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT,
+			 phydev->lp_advertising,
+			 pbus_value & EN8811H_2P5G_LPA_2P5G);
+
+	if (phydev->autoneg_complete)
+		phy_resolve_aneg_pause(phydev);
+
+	if (!phydev->link)
+		return 0;
+
+	ret = en8811h_get_speed(phydev);
+	if (ret < 0)
+		return ret;
+
 	/* Firmware before version 24011202 has no vendor register 2P5G_LPA.
 	 * Assume link partner advertised it if connected at 2500Mbps.
 	 */
@@ -1155,9 +1189,6 @@ static int en8811h_read_status(struct phy_device *phydev)
 				 phydev->speed == SPEED_2500);
 	}
 
-	/* Only supports full duplex */
-	phydev->duplex = DUPLEX_FULL;
-
 	return 0;
 }
 
-- 
2.47.3



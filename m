Return-Path: <netdev+bounces-252224-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8O5aDDTPcWnSMQAAu9opvQ
	(envelope-from <netdev+bounces-252224-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 08:18:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F18262717
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 08:18:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 21136366D84
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 07:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E68DF3A9001;
	Thu, 22 Jan 2026 07:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mork.no header.i=@mork.no header.b="a5KZj1D3"
X-Original-To: netdev@vger.kernel.org
Received: from dilbert.mork.no (dilbert.mork.no [65.108.154.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066473933E8;
	Thu, 22 Jan 2026 07:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.108.154.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769066240; cv=none; b=PamWRe7dPISmjnNROG4eo9nvY7fOm+3f6Tma1Uo/LAHCyEYPIQgr2yzLE/CaDdIPZtHnb3C3mHc9hN9xTNLTFRD5aekjoEmZrPUX4eeGpXzv1toqgYLaxsxjamO+r/5MjdHbJuXlyqbAvp9jF/wVL+MreFYzO8rLgaP7dO4FrMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769066240; c=relaxed/simple;
	bh=1HjCSfLdztXuexH9KFqqWUw3qFHqeHoQYg5dtnrhQaM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mZbPT64ANMwJkGZye+TqEhYyulUulhaaUtF/M5VRA66JGanBGlO5tgc1hTN+nsR2WlVqpQ3hvu5jMttDMLBZzgofxYeP3sZPerKlFniP6G1VTFqk1AM3/IYl3eHOHfcBP0NG29h6QGRV7fGoFa02E0z8rt4LnunETtn3ufi3CSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mork.no; spf=pass smtp.mailfrom=miraculix.mork.no; dkim=pass (1024-bit key) header.d=mork.no header.i=@mork.no header.b=a5KZj1D3; arc=none smtp.client-ip=65.108.154.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mork.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=miraculix.mork.no
Authentication-Results: dilbert.mork.no;
	dkim=pass (1024-bit key; secure) header.d=mork.no header.i=@mork.no header.a=rsa-sha256 header.s=b header.b=a5KZj1D3;
	dkim-atps=neutral
Received: from canardo.dyn.mork.no ([IPv6:2a01:799:10e2:d900:0:0:0:1])
	(authenticated bits=0)
	by dilbert.mork.no (8.18.1/8.18.1) with ESMTPSA id 60M7GPmJ1239610
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Thu, 22 Jan 2026 07:16:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mork.no; s=b;
	t=1769066185; bh=xyN6RI6KBvT6R5pordqchMHzXsfiabO+Z2lnnZo4bZY=;
	h=From:To:Cc:Subject:Date:Message-ID:References:From;
	b=a5KZj1D33DRZFW1Et35bAR9ziThf4mTLM1rU4KauKcbhMrigrWSpqP4BGn+UjDTVS
	 5aT5YaI2GUzFQSbCEKXd8l7OIF3I59wwIcDuorKojIefm/cHMJH605m/ySSZkm8h+x
	 DRdoWVu6ZiwZTfTHfnDG9wgOgFhxjlE6Lq1OwiEo=
Received: from miraculix.mork.no ([IPv6:2a01:799:10e2:d90a:6f50:7559:681d:630c])
	(authenticated bits=0)
	by canardo.dyn.mork.no (8.18.1/8.18.1) with ESMTPSA id 60M7GOl23217369
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Thu, 22 Jan 2026 08:16:25 +0100
Received: (nullmailer pid 1057133 invoked by uid 1000);
	Thu, 22 Jan 2026 07:16:24 -0000
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
Subject: [PATCH net-next 1/3] net: phy: air_en8811h: factor out shareable code
Date: Thu, 22 Jan 2026 08:15:58 +0100
Message-ID: <20260122071601.1057083-2-bjorn@mork.no>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260122071601.1057083-1-bjorn@mork.no>
References: <20260122071601.1057083-1-bjorn@mork.no>
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
X-Spamd-Result: default: False [-0.96 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[mork.no:s=b];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,makrotopia.org,nxp.com,lunn.ch,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,mork.no];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-252224-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[mork.no,reject];
	DKIM_TRACE(0.00)[mork.no:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bjorn@mork.no,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mork.no:email,mork.no:dkim,mork.no:mid,ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: 2F18262717
X-Rspamd-Action: no action

Create reusable helpers in preparation for the AN8811HB support.

Signed-off-by: Bjørn Mork <bjorn@mork.no>
---
 drivers/net/phy/air_en8811h.c | 126 +++++++++++++++++++++-------------
 1 file changed, 80 insertions(+), 46 deletions(-)

diff --git a/drivers/net/phy/air_en8811h.c b/drivers/net/phy/air_en8811h.c
index e890bb2c0aa8..14552ddf9436 100644
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
@@ -1144,8 +1144,45 @@ static int en8811h_read_status(struct phy_device *phydev)
 	case AIR_AUX_CTRL_STATUS_SPEED_100:
 		phydev->speed = SPEED_100;
 		break;
+	case AIR_AUX_CTRL_STATUS_SPEED_10:
+		phydev->speed = SPEED_10;
+		break;
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
@@ -1155,9 +1192,6 @@ static int en8811h_read_status(struct phy_device *phydev)
 				 phydev->speed == SPEED_2500);
 	}
 
-	/* Only supports full duplex */
-	phydev->duplex = DUPLEX_FULL;
-
 	return 0;
 }
 
-- 
2.47.3



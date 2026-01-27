Return-Path: <netdev+bounces-253854-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cA6FM6a2eGlzsQEAu9opvQ
	(envelope-from <netdev+bounces-253854-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 13:59:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 392E89498F
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 13:59:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 94AE630131E5
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 12:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 795113559CD;
	Tue, 27 Jan 2026 12:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mork.no header.i=@mork.no header.b="AOUaY4MN"
X-Original-To: netdev@vger.kernel.org
Received: from dilbert.mork.no (dilbert.mork.no [65.108.154.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A29B355811;
	Tue, 27 Jan 2026 12:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.108.154.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769518591; cv=none; b=qd2cEEib4LCgV17bzz4OdgakLz2Zts87LhSvwI4RyU4OaxCbh5NTa7UyGsPIxagG6AS4lMuBrkAmciQchzqbmgziB7jpisq7qcqovnkaHyMBvVETDYa5HjfiNC2x+HaRNcb6y6Z+JuTuJUkNWoRJj5VyySAt2s5/xjChsBV5dD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769518591; c=relaxed/simple;
	bh=NjlUr8YbkYomUklK5X+zoXxx6QhhxpjaDQzOHwc+CNo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CvXdZIWCcegFtfjSH8j8vOwt6RxOZ4g4cb8efb0qcsij2mBaSwx8h+LCz5EGwo86lrb9wCc89/L0JwLejrQ8A8EpUBMQlsfm1qpn93UUdVQpHri8lhlorAxqlu+6FqNe56eBiSCPm24xDLduGDCwwOFcB/JT2qyFssDISD6eRuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mork.no; spf=pass smtp.mailfrom=miraculix.mork.no; dkim=pass (1024-bit key) header.d=mork.no header.i=@mork.no header.b=AOUaY4MN; arc=none smtp.client-ip=65.108.154.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mork.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=miraculix.mork.no
Authentication-Results: dilbert.mork.no;
	dkim=pass (1024-bit key; secure) header.d=mork.no header.i=@mork.no header.a=rsa-sha256 header.s=b header.b=AOUaY4MN;
	dkim-atps=neutral
Received: from canardo.dyn.mork.no ([IPv6:2a01:799:10e2:d900:0:0:0:1])
	(authenticated bits=0)
	by dilbert.mork.no (8.18.1/8.18.1) with ESMTPSA id 60RCtseW1881659
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Tue, 27 Jan 2026 12:55:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mork.no; s=b;
	t=1769518553; bh=BDZ1ZTsCnzg8RfIBIHFCXrzN5KG1B8Tq0jMUU+UYhh4=;
	h=From:To:Cc:Subject:Date:Message-ID:References:From;
	b=AOUaY4MNcDhRcBnUh7bQ9tGbpkAHGAHXW6zkKLT0CygAIt0uOogGOcr+ctvpw7BrX
	 o8EUPxxNgkNQEYOvhC9cHhLgEZ7vqslkCi9svrkqUE3n6OmjNGwM3KoxaOfFaVRhdQ
	 1x9PjAzGutb5ijhgF6lf7/qO4aqC2o/nsBBzmqVc=
Received: from miraculix.mork.no ([IPv6:2a01:799:10e2:d90a:6f50:7559:681d:630c])
	(authenticated bits=0)
	by canardo.dyn.mork.no (8.18.1/8.18.1) with ESMTPSA id 60RCtro5908904
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Tue, 27 Jan 2026 13:55:53 +0100
Received: (nullmailer pid 1475185 invoked by uid 1000);
	Tue, 27 Jan 2026 12:55:52 -0000
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
Subject: [PATCH net-next v4 1/3] net: phy: air_en8811h: factor out shareable code
Date: Tue, 27 Jan 2026 13:55:45 +0100
Message-ID: <20260127125547.1475164-2-bjorn@mork.no>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260127125547.1475164-1-bjorn@mork.no>
References: <20260127125547.1475164-1-bjorn@mork.no>
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
	TAGGED_FROM(0.00)[bounces-253854-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.995];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mork.no:email,mork.no:dkim,mork.no:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 392E89498F
X-Rspamd-Action: no action

Create reusable helpers in preparation for the AN8811HB support.

Signed-off-by: Bjørn Mork <bjorn@mork.no>
---
 drivers/net/phy/air_en8811h.c | 59 +++++++++++++++++++++--------------
 1 file changed, 36 insertions(+), 23 deletions(-)

diff --git a/drivers/net/phy/air_en8811h.c b/drivers/net/phy/air_en8811h.c
index e890bb2c0aa8..392552692762 100644
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
-- 
2.47.3



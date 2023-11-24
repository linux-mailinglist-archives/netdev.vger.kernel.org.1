Return-Path: <netdev+bounces-50823-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 909BF7F73C9
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 13:28:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0FDF1C20EF9
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 12:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 226E8250FE;
	Fri, 24 Nov 2023 12:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="igrb/DuU"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7C38B6
	for <netdev@vger.kernel.org>; Fri, 24 Nov 2023 04:28:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=2/tAr1xZJUJXhhDmuUdqRC+wdFCH6M6rbVTQTw/jzKc=; b=igrb/DuUZolBxqlal6ikgjNUUq
	se+nMIbleTg1GMgXZLtnv9vTPfg9c4cfXea0OiRsIeehDegMnYSF52ZH9iq6xu+ze90U7qwlw5Kgq
	6NndB/EC8y7T5gqB7io8xR7Hwgr2wrPmwqnnl74yMgaYRvqX31LLbm7F5J61Fefc0XYK2DAH1HO7N
	ekpwE42MAsnEyhmuxQ+oH0m7t88hRUNsSahGLVRDj2xwMszPvHFMn3xKCu3vX4b1WJMINAn2/V4BM
	W/MF1Q/Qf+99eeSgmrKRoKzLrSx8X82rAwlG8izJUsThDxy7ziJuLwJlPGoJ4Z9LbcvV0qqbSwbGJ
	3mmYuGiQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:46856 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1r6VI4-0002tE-0D;
	Fri, 24 Nov 2023 12:28:12 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1r6VI6-00DDLl-2D; Fri, 24 Nov 2023 12:28:14 +0000
In-Reply-To: <ZWCWn+uNkVLPaQhn@shell.armlinux.org.uk>
References: <ZWCWn+uNkVLPaQhn@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 05/10] net: phy: aquantia: fill in
 possible_interfaces for AQR113C
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1r6VI6-00DDLl-2D@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 24 Nov 2023 12:28:14 +0000

Fill in the possible_interfaces bitmap for AQR113C so phylink knows
which interface modes will be used by the PHY.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/phy/aquantia/aquantia.h      |  5 ++
 drivers/net/phy/aquantia/aquantia_main.c | 76 +++++++++++++++++++++++-
 2 files changed, 80 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/aquantia/aquantia.h b/drivers/net/phy/aquantia/aquantia.h
index 9ed38972abdb..1c19ae74ad2b 100644
--- a/drivers/net/phy/aquantia/aquantia.h
+++ b/drivers/net/phy/aquantia/aquantia.h
@@ -47,6 +47,11 @@
 #define VEND1_GLOBAL_CFG_5G			0x031e
 #define VEND1_GLOBAL_CFG_10G			0x031f
 /* ...and now the fields */
+#define VEND1_GLOBAL_CFG_SERDES_MODE		GENMASK(2, 0)
+#define VEND1_GLOBAL_CFG_SERDES_MODE_XFI	0
+#define VEND1_GLOBAL_CFG_SERDES_MODE_SGMII	3
+#define VEND1_GLOBAL_CFG_SERDES_MODE_OCSGMII	4
+#define VEND1_GLOBAL_CFG_SERDES_MODE_XFI5G	6
 #define VEND1_GLOBAL_CFG_RATE_ADAPT		GENMASK(8, 7)
 #define VEND1_GLOBAL_CFG_RATE_ADAPT_NONE	0
 #define VEND1_GLOBAL_CFG_RATE_ADAPT_USX		1
diff --git a/drivers/net/phy/aquantia/aquantia_main.c b/drivers/net/phy/aquantia/aquantia_main.c
index cc4a97741c4a..97a2fafa15ca 100644
--- a/drivers/net/phy/aquantia/aquantia_main.c
+++ b/drivers/net/phy/aquantia/aquantia_main.c
@@ -656,6 +656,80 @@ static int aqr107_resume(struct phy_device *phydev)
 	return aqr107_wait_processor_intensive_op(phydev);
 }
 
+static const u16 aqr_global_cfg_regs[] = {
+	VEND1_GLOBAL_CFG_10M,
+	VEND1_GLOBAL_CFG_100M,
+	VEND1_GLOBAL_CFG_1G,
+	VEND1_GLOBAL_CFG_2_5G,
+	VEND1_GLOBAL_CFG_5G,
+	VEND1_GLOBAL_CFG_10G
+};
+
+static int aqr107_fill_interface_modes(struct phy_device *phydev)
+{
+	unsigned long *possible = phydev->possible_interfaces;
+	unsigned int serdes_mode, rate_adapt;
+	phy_interface_t interface;
+	int i, val;
+
+	/* Walk the media-speed configuration registers to determine which
+	 * host-side serdes modes may be used by the PHY depending on the
+	 * negotiated media speed.
+	 */
+	for (i = 0; i < ARRAY_SIZE(aqr_global_cfg_regs); i++) {
+		val = phy_read_mmd(phydev, MDIO_MMD_VEND1,
+				   aqr_global_cfg_regs[i]);
+		if (val < 0)
+			return val;
+
+		serdes_mode = FIELD_GET(VEND1_GLOBAL_CFG_SERDES_MODE, val);
+		rate_adapt = FIELD_GET(VEND1_GLOBAL_CFG_RATE_ADAPT, val);
+
+		switch (serdes_mode) {
+		case VEND1_GLOBAL_CFG_SERDES_MODE_XFI:
+			if (rate_adapt == VEND1_GLOBAL_CFG_RATE_ADAPT_USX)
+				interface = PHY_INTERFACE_MODE_USXGMII;
+			else
+				interface = PHY_INTERFACE_MODE_10GBASER;
+			break;
+
+		case VEND1_GLOBAL_CFG_SERDES_MODE_XFI5G:
+			interface = PHY_INTERFACE_MODE_5GBASER;
+			break;
+
+		case VEND1_GLOBAL_CFG_SERDES_MODE_OCSGMII:
+			interface = PHY_INTERFACE_MODE_2500BASEX;
+			break;
+
+		case VEND1_GLOBAL_CFG_SERDES_MODE_SGMII:
+			interface = PHY_INTERFACE_MODE_SGMII;
+			break;
+
+		default:
+			phydev_warn(phydev, "unrecognised serdes mode %u\n",
+				    serdes_mode);
+			interface = PHY_INTERFACE_MODE_NA;
+			break;
+		}
+
+		if (interface != PHY_INTERFACE_MODE_NA)
+			__set_bit(interface, possible);
+	}
+
+	return 0;
+}
+
+static int aqr113c_config_init(struct phy_device *phydev)
+{
+	int ret;
+
+	ret = aqr107_config_init(phydev);
+	if (ret < 0)
+		return ret;
+
+	return aqr107_fill_interface_modes(phydev);
+}
+
 static int aqr107_probe(struct phy_device *phydev)
 {
 	int ret;
@@ -794,7 +868,7 @@ static struct phy_driver aqr_driver[] = {
 	.name           = "Aquantia AQR113C",
 	.probe          = aqr107_probe,
 	.get_rate_matching = aqr107_get_rate_matching,
-	.config_init    = aqr107_config_init,
+	.config_init    = aqr113c_config_init,
 	.config_aneg    = aqr_config_aneg,
 	.config_intr    = aqr_config_intr,
 	.handle_interrupt       = aqr_handle_interrupt,
-- 
2.30.2



Return-Path: <netdev+bounces-216661-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66612B34DB7
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 23:11:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25F073AA610
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 21:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DB2329A9FA;
	Mon, 25 Aug 2025 21:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b="l9ClzoDj"
X-Original-To: netdev@vger.kernel.org
Received: from mx4.wp.pl (mx4.wp.pl [212.77.101.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9616229B764
	for <netdev@vger.kernel.org>; Mon, 25 Aug 2025 21:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756156273; cv=none; b=l6yPmodfnGlYa45P5l1xDIH5k+DQhZHYHHmZhmBCtsAzqRRa0Ls5sKWgZnfOhNPKzWzeUzpIzX9u6yRyDaIx60AtlYVx5noLI1mVazC2QxgzeTEoxZb0HbF4VZl+UuUsSUTp3p8YCMnxhV1HHVRbs771keIbgh6KOZ90ZB0dlRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756156273; c=relaxed/simple;
	bh=Uh2yBMXE/pscYd1mqmI/JTw78W6S2ubOyJMDmz70AwM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=JFVK4P0VI1OnOchrGLsEkOW2NnEZm38hdT2T9laAUnxBoyDYlVGzjPQn9dUcqilxaOy3DBHVdmiwPoKQJw2DzUpmKTAfoPNVEbeINHrRGd7JRo1R2qFABflFB3U8/w+yc4g07pvIhCY2MjTgDs1UIN8ZV+hERyJ7uYx0lsONOCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b=l9ClzoDj; arc=none smtp.client-ip=212.77.101.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Received: (wp-smtpd smtp.wp.pl 15683 invoked from network); 25 Aug 2025 23:11:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=20241105;
          t=1756156261; bh=pgHnVnF6wcMMDTHLkcv210vPP9+FRghiIsIMN6rFI/4=;
          h=From:To:Subject;
          b=l9ClzoDjJn57tyPWKxLCLARkA//rDeRQX8ImVPsLAsU9C+TpzkHlb1VM0Todvvp0q
           S9Vex+cXUBB/Mi4kn0kLScUxjrMI/u3F2/VGrED7Jolm26Voqz3JwIPAGNKBGVnjPS
           iaVxWxNVAyETAqlANTDgu1Vk1pNtR+7oapvx7JgeOSb4cLL5bHvJz9jPvVrZmG+Tth
           CwfJyMMmbG3DnuUPRG8ulbZyHu3jA9s74GoM4WPH7zLCc9MCClSc3Pv4ohGllD7YFn
           aLp+LihnHQVivWDiFdPMqxpNUxc2ZxatuKcZoAIH1yuPaE6QHxYFrUh19sxqSv8lOG
           vBe5RtCfBz/DQ==
Received: from 83.24.136.119.ipv4.supernova.orange.pl (HELO laptop-olek.lan) (olek2@wp.pl@[83.24.136.119])
          (envelope-sender <olek2@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <andrew@lunn.ch>; 25 Aug 2025 23:11:01 +0200
From: Aleksander Jan Bajkowski <olek2@wp.pl>
To: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	michael@fossekall.de,
	daniel@makrotopia.org,
	daniel.braunwarth@kuka.com,
	olek2@wp.pl,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: phy: realtek: support for TRIGGER_NETDEV_LINK on RTL8211E and RTL8211F
Date: Mon, 25 Aug 2025 23:09:49 +0200
Message-ID: <20250825211059.143231-1-olek2@wp.pl>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-WP-MailID: 32360dec30e1a5d38e5915a5e4cf53e8
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [cRM0]                               

This patch adds support for the TRIGGER_NETDEV_LINK trigger. It activates
the LED when a link is established, regardless of the speed.

Tested on Orange Pi PC2 with RTL8211E PHY.

Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>
---
 drivers/net/phy/realtek/realtek_main.c | 39 +++++++++++++++++++++-----
 1 file changed, 32 insertions(+), 7 deletions(-)

diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
index dd0d675149ad..688c031c27d9 100644
--- a/drivers/net/phy/realtek/realtek_main.c
+++ b/drivers/net/phy/realtek/realtek_main.c
@@ -648,7 +648,8 @@ static int rtl821x_resume(struct phy_device *phydev)
 static int rtl8211x_led_hw_is_supported(struct phy_device *phydev, u8 index,
 					unsigned long rules)
 {
-	const unsigned long mask = BIT(TRIGGER_NETDEV_LINK_10) |
+	const unsigned long mask = BIT(TRIGGER_NETDEV_LINK) |
+				   BIT(TRIGGER_NETDEV_LINK_10) |
 				   BIT(TRIGGER_NETDEV_LINK_100) |
 				   BIT(TRIGGER_NETDEV_LINK_1000) |
 				   BIT(TRIGGER_NETDEV_RX) |
@@ -706,6 +707,12 @@ static int rtl8211f_led_hw_control_get(struct phy_device *phydev, u8 index,
 	if (val & RTL8211F_LEDCR_LINK_1000)
 		__set_bit(TRIGGER_NETDEV_LINK_1000, rules);
 
+	if ((val & RTL8211F_LEDCR_LINK_10) &&
+	    (val & RTL8211F_LEDCR_LINK_100) &&
+	    (val & RTL8211F_LEDCR_LINK_1000)) {
+		__set_bit(TRIGGER_NETDEV_LINK, rules);
+	}
+
 	if (val & RTL8211F_LEDCR_ACT_TXRX) {
 		__set_bit(TRIGGER_NETDEV_RX, rules);
 		__set_bit(TRIGGER_NETDEV_TX, rules);
@@ -723,14 +730,20 @@ static int rtl8211f_led_hw_control_set(struct phy_device *phydev, u8 index,
 	if (index >= RTL8211x_LED_COUNT)
 		return -EINVAL;
 
-	if (test_bit(TRIGGER_NETDEV_LINK_10, &rules))
+	if (test_bit(TRIGGER_NETDEV_LINK, &rules) ||
+	    test_bit(TRIGGER_NETDEV_LINK_10, &rules)) {
 		reg |= RTL8211F_LEDCR_LINK_10;
+	}
 
-	if (test_bit(TRIGGER_NETDEV_LINK_100, &rules))
+	if (test_bit(TRIGGER_NETDEV_LINK, &rules) ||
+	    test_bit(TRIGGER_NETDEV_LINK_100, &rules)) {
 		reg |= RTL8211F_LEDCR_LINK_100;
+	}
 
-	if (test_bit(TRIGGER_NETDEV_LINK_1000, &rules))
+	if (test_bit(TRIGGER_NETDEV_LINK, &rules) ||
+	    test_bit(TRIGGER_NETDEV_LINK_1000, &rules)) {
 		reg |= RTL8211F_LEDCR_LINK_1000;
+	}
 
 	if (test_bit(TRIGGER_NETDEV_RX, &rules) ||
 	    test_bit(TRIGGER_NETDEV_TX, &rules)) {
@@ -778,6 +791,12 @@ static int rtl8211e_led_hw_control_get(struct phy_device *phydev, u8 index,
 	if (cr2 & RTL8211E_LEDCR2_LINK_1000)
 		__set_bit(TRIGGER_NETDEV_LINK_1000, rules);
 
+	if ((cr2 & RTL8211E_LEDCR2_LINK_10) &&
+	    (cr2 & RTL8211E_LEDCR2_LINK_100) &&
+	    (cr2 & RTL8211E_LEDCR2_LINK_1000)) {
+		__set_bit(TRIGGER_NETDEV_LINK, rules);
+	}
+
 	return ret;
 }
 
@@ -805,14 +824,20 @@ static int rtl8211e_led_hw_control_set(struct phy_device *phydev, u8 index,
 	if (ret < 0)
 		return ret;
 
-	if (test_bit(TRIGGER_NETDEV_LINK_10, &rules))
+	if (test_bit(TRIGGER_NETDEV_LINK, &rules) ||
+	    test_bit(TRIGGER_NETDEV_LINK_10, &rules)) {
 		cr2 |= RTL8211E_LEDCR2_LINK_10;
+	}
 
-	if (test_bit(TRIGGER_NETDEV_LINK_100, &rules))
+	if (test_bit(TRIGGER_NETDEV_LINK, &rules) ||
+	    test_bit(TRIGGER_NETDEV_LINK_100, &rules)) {
 		cr2 |= RTL8211E_LEDCR2_LINK_100;
+	}
 
-	if (test_bit(TRIGGER_NETDEV_LINK_1000, &rules))
+	if (test_bit(TRIGGER_NETDEV_LINK, &rules) ||
+	    test_bit(TRIGGER_NETDEV_LINK_1000, &rules)) {
 		cr2 |= RTL8211E_LEDCR2_LINK_1000;
+	}
 
 	cr2 <<= RTL8211E_LEDCR2_SHIFT * index;
 	ret = rtl821x_modify_ext_page(phydev, RTL8211E_LEDCR_EXT_PAGE,
-- 
2.47.2



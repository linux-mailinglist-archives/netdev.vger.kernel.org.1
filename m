Return-Path: <netdev+bounces-168784-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80D2DA40B07
	for <lists+netdev@lfdr.de>; Sat, 22 Feb 2025 19:45:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81A8B3BFF16
	for <lists+netdev@lfdr.de>; Sat, 22 Feb 2025 18:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96FCA20E719;
	Sat, 22 Feb 2025 18:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b="WctiwARz"
X-Original-To: netdev@vger.kernel.org
Received: from mx4.wp.pl (mx4.wp.pl [212.77.101.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA9920C46B
	for <netdev@vger.kernel.org>; Sat, 22 Feb 2025 18:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740249902; cv=none; b=F7D/CIT4DQDGzBJw2F6TFGWSzjmuJeHT1NDZ5WOOvV16q6CzZAWlG5iixzGfCR/FipB0JUjRACracrBd3X5A2e+ecOigxLT1uMB9nSpNceWU0tqWjo+e7rGVlxU/pvozu4bD4AZAChsKjfNyBjhJ7GfByCeb6jD/LIzo4nlsC7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740249902; c=relaxed/simple;
	bh=bJwz0Ulxy/4MRJjnoRaz8nlgEfTr5vN1BUc5gHeAHEs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=apnp1N98PeVicRoTo6bmjwe9yVZ80Tc8buueXXIAUuqxyFlVBaIx/rdfF/Zf2yRmePBaid+z69a01VYVdrEiCsFqP98r+A5/Rb+f+EPfdtIN4WL4vZ4/Vrq/zpJHwIwaqMorlVaiEjs8SJxz+6jOCNFq6siCP9hgCPZ7dRi3p7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b=WctiwARz; arc=none smtp.client-ip=212.77.101.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Received: (wp-smtpd smtp.wp.pl 47211 invoked from network); 22 Feb 2025 19:38:16 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=20241105;
          t=1740249496; bh=i2RkCP+0CD/CKqcMDclhiyW4ZjR3USyzMiy1CqfKjro=;
          h=From:To:Cc:Subject;
          b=WctiwARzWh/JjZB+vvs/IY/R7mPGGXSRQ5Z+1FiAbjueomObR7tmo7DuV/DxYuuyc
           fRZsJEwu9qpbFJva2JD+9uY2WAFwiVrnBKZyTu9ewi7h5T7tiii6VNEuBo9rDq5WNo
           Xu3d85Hx9FTasG1lCnqNtE18qFiqF0vMw6x0ZDflKuv0Ka3e1CjrDVe2IxFincQHQ9
           7dYrnwoycjMLo+PSbCwAb8CRlCKJ6oTV+QSY34qaTtTpJlP2/rosq40PxVqQLhyE9v
           Y8hnGDxJWtvvJMUKovZcfjuAytvIvMiMlrb8T/DIn5A5vLb+z/qeFl38h66BAfbRTT
           IJTj51PbDuiRw==
Received: from 83.6.114.178.ipv4.supernova.orange.pl (HELO laptop-olek.home) (olek2@wp.pl@[83.6.114.178])
          (envelope-sender <olek2@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <lxu@maxlinear.com>; 22 Feb 2025 19:38:16 +0100
From: Aleksander Jan Bajkowski <olek2@wp.pl>
To: lxu@maxlinear.com,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Aleksander Jan Bajkowski <olek2@wp.pl>,
	Daniel Golle <daniel@makrotopia.org>
Subject: [PATCH net-next 1/2] net: phy: add LED dimming support
Date: Sat, 22 Feb 2025 19:38:13 +0100
Message-Id: <20250222183814.3315-1-olek2@wp.pl>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-WP-MailID: dc5426013d86a711e844cf2620b6b218
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 000000B [YUOk]                               

Some PHYs support LED dimming. The use case is a router that dims LEDs
at night. PHYs from different manufacturers support a different number of
brightness levels, so it was necessary to extend the API with the
led_max_brightness() function. If this function is omitted, a default
value is used, assuming that only two levels are supported.

Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>
Reviewed-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/net/phy/phy_device.c | 7 ++++++-
 include/linux/phy.h          | 7 +++++++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 46713d27412b..f9631f093baa 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -3351,7 +3351,12 @@ static int of_phy_led(struct phy_device *phydev,
 
 	cdev->hw_control_get_device = phy_led_hw_control_get_device;
 #endif
-	cdev->max_brightness = 1;
+	if (phydev->drv->led_max_brightness)
+		cdev->max_brightness =
+			phydev->drv->led_max_brightness(phydev, index);
+	else
+		cdev->max_brightness = 1;
+
 	init_data.devicename = dev_name(&phydev->mdio.dev);
 	init_data.fwnode = of_fwnode_handle(led);
 	init_data.devname_mandatory = true;
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 19f076a71f94..248a47c8817b 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -1216,6 +1216,13 @@ struct phy_driver {
 	int (*led_brightness_set)(struct phy_device *dev,
 				  u8 index, enum led_brightness value);
 
+	/**
+	 * &led_max_brightness: Maximum number of brightness levels
+	 * supported by hardware. When only two levels are supported
+	 * i.e. LED_ON and LED_OFF the function can be omitted.
+	 */
+	int (*led_max_brightness)(struct phy_device *dev, u8 index);
+
 	/**
 	 * @led_blink_set: Set a PHY LED blinking.  Index indicates
 	 * which of the PHYs led should be configured to blink. Delays
-- 
2.39.5



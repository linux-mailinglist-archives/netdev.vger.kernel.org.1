Return-Path: <netdev+bounces-132143-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 00CA29908DD
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 18:17:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78D6E1F21EAC
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 16:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E98F91C876D;
	Fri,  4 Oct 2024 16:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="jQ3ra73D"
X-Original-To: netdev@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94BE81C7291;
	Fri,  4 Oct 2024 16:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728058578; cv=none; b=GBWVkMzF80TZEWmuR53RPsfA11RaTREHk7ZiCxFegqxV0XxvNtynzbbl+EDiqLZj2K/ZHRqzInm2WVepAdtejpiP8257tynakx2lpxJLW8JONPVlsFtWqhipqscJWyeT1u8O0sud0NNAawr3orbxFaGDwvjHdWNLA3SXktKP2M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728058578; c=relaxed/simple;
	bh=Bg/ls7hlfga8JfozWCtqDImaSPRRA7SiUVoQmJ277kM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EDJ5cGldNf/l02snJgu6PqBDkR+5r8sSHhmE68M5C5vjsLLyaS/tftq20jr8Oj0qYEP2HJ0l6OR4oGLaZo9HOVk5GpFo/JcSYB9/VAPihnyV66nhrhluEmXtbrQ8r9jffAbQvcczikgj+lZ2q/t3jYeTwmbBdLm0g+te63FBU9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=jQ3ra73D; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C14C120009;
	Fri,  4 Oct 2024 16:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1728058568;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=la8SYFLXiQbvELSBNxA6DPB/JK9HrzHWiWkj/zCFpDg=;
	b=jQ3ra73DjV+eY3z7qTSpp6U8ixANJh4PvBVhFTSwwoVxspGtNZbfbR+U11E13a5Nryasan
	UACUOKrq5dom/rPejVvYr1YM+VJBUk9iEb9Tid7JNfs3SB2WQ4IFYVBSYafK3CF7JLRkcg
	KG1jckkj0hwFY+fSlYyn1arKslIVUZx/bw/QWEaH4d7T7FZ+AQ1m/VfFFdqNEWYaRz/3+U
	70RuwdHgbSlS+hAoOcJ+sOvrGQCQ38eynEeRjcsVuwolqNhYOfvK1PX+T++Y9AuG5aYr3h
	dQhRSPCQsY5U/dXU2122WBx6mBFTtyxRpBfO/oZStCeffLZlhYyUpWyjUKlzNQ==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: davem@davemloft.net
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Herve Codina <herve.codina@bootlin.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	=?UTF-8?q?K=C3=B6ry=20Maincent?= <kory.maincent@bootlin.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>
Subject: [PATCH net-next v2 3/9] net: phy: Allow PHY drivers to report isolation support
Date: Fri,  4 Oct 2024 18:15:53 +0200
Message-ID: <20241004161601.2932901-4-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241004161601.2932901-1-maxime.chevallier@bootlin.com>
References: <20241004161601.2932901-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Some PHYs have malfunctionning isolation modes, where the MII lines
aren't correctly set in high-impedance, potentially interfering with the
MII bus in unexpected ways. Some other PHYs simply don't support it.

The isolation support may depend on the interface mode being used, so
introduce a new driver callback to report the isolation support in the
current PHY configuration.

As some PHYs just never support isolation, introduce a genphy helper
that can be used for strictly non-isolating PHYs.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
V2 : Moved from flag to callback, introduced genphy helper

 drivers/net/phy/phy_device.c | 11 +++++++++++
 include/linux/phy.h          | 19 +++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index a0d8ff995024..9294b73c391a 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -2127,6 +2127,14 @@ int phy_loopback(struct phy_device *phydev, bool enable)
 }
 EXPORT_SYMBOL(phy_loopback);
 
+static bool phy_can_isolate(struct phy_device *phydev)
+{
+	if (phydev->drv && phydev->drv->can_isolate)
+		return phydev->drv->can_isolate(phydev);
+
+	return true;
+}
+
 int phy_isolate(struct phy_device *phydev, bool enable)
 {
 	int ret = 0;
@@ -2134,6 +2142,9 @@ int phy_isolate(struct phy_device *phydev, bool enable)
 	if (!phydev->drv)
 		return -EIO;
 
+	if (!phy_can_isolate(phydev))
+		return -EOPNOTSUPP;
+
 	mutex_lock(&phydev->lock);
 
 	if (enable && phydev->isolated) {
diff --git a/include/linux/phy.h b/include/linux/phy.h
index ae33919aa0f5..e43f7169c57d 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -1192,6 +1192,19 @@ struct phy_driver {
 	 */
 	int (*led_polarity_set)(struct phy_device *dev, int index,
 				unsigned long modes);
+
+	/**
+	 * @can_isolate: Query the PHY isolation capability
+	 * @dev: PHY device to query
+	 *
+	 * Although PHY isolation is part of 802.3, not all PHYs support that
+	 * feature. Some PHYs can only support isolation when using a specific
+	 * phy_interface_mode, and some don't support it at all.
+	 *
+	 * Returns true if the PHY can isolate in its current configuration,
+	 * false otherwise.
+	 */
+	bool (*can_isolate)(struct phy_device *dev);
 };
 #define to_phy_driver(d) container_of_const(to_mdio_common_driver(d),		\
 				      struct phy_driver, mdiodrv)
@@ -1910,6 +1923,12 @@ static inline int genphy_no_config_intr(struct phy_device *phydev)
 {
 	return 0;
 }
+
+static inline bool genphy_no_isolate(struct phy_device *phydev)
+{
+	return false;
+}
+
 int genphy_read_mmd_unsupported(struct phy_device *phdev, int devad,
 				u16 regnum);
 int genphy_write_mmd_unsupported(struct phy_device *phdev, int devnum,
-- 
2.46.1



Return-Path: <netdev+bounces-127576-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 230ED975C64
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 23:27:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2B072839C8
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 21:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 735F51B9B2A;
	Wed, 11 Sep 2024 21:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="GdEnD/oi"
X-Original-To: netdev@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91EB0155CA8;
	Wed, 11 Sep 2024 21:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726090048; cv=none; b=vE+O2zV4InDHzdyaTdE1mpvBzvVKCWktdFwIskGxAr5OV9HTECaG/fVhVXLRXRulkVJWemrlu4aLJEYVhCJisq3whNV33WYK0zhI1snbEnlxKn/xo1w3yiNnuUg3fVepx+xoWIUV5CGL/NPzvISOPhSv584INq9vGGBY5DCXeg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726090048; c=relaxed/simple;
	bh=4XKgygHgHYU0HpYZiqp8Izesb809i6ACTGHuv9L2/zM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XBeE7rSkH0W9OMXym7ak+7ewSNSnyHu5qlryHh/ylNV1Wz3So21Jz6y7lwNWqS15G4bEaiq2+olrCdxPVVlh+bGKsk7PWPbvnaR2L0MlOkl/wYczEcSLvulJx7SrLP2I9mtbqBccipNDgjRA8Ra/Z/THfio0rfUnn53UIcD3YVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=GdEnD/oi; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3E6FA1C0003;
	Wed, 11 Sep 2024 21:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1726090039;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SuxJgxEerzFtn5NODnwFgah+RUsv6TT5UGmu+5Xa848=;
	b=GdEnD/oidgYXzEkLwRFvbhcxVFoZiSIOA1TQ4oS8U2KzVlFicJreHBfWq2WAV3fY2CdpxN
	C+Nk/8lslx6XnDQfAI/IiNxgSAUz5r08L/MTgjRqZ1AYj6yYeTs67p1exeeD0djLrKtfcs
	auwKoj04AtDh+SUnmD1mulryVQWauaIuIBsxVV+y5sSgGdwoKV5Mdfsz0Ig4KnpC5gLFUf
	g4GK1es0TuLVv/WpAaP2JNM6yhgV3sQnRce4paI5LClQ3X8qzPnQ7NIiSQAoIwcw+i1ApH
	3KK+FXDy+dUnV+3omhXocAxmuQjLQ7nbRZHGz+emld+txPGkl0YFllUdstx7gg==
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
Subject: [PATCH net-next 2/7] net: phy: Allow flagging PHY devices that can't isolate their MII
Date: Wed, 11 Sep 2024 23:27:06 +0200
Message-ID: <20240911212713.2178943-3-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240911212713.2178943-1-maxime.chevallier@bootlin.com>
References: <20240911212713.2178943-1-maxime.chevallier@bootlin.com>
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

Allow flagging these PHYs, and prevent isolating them altogether.

Assume the PHY can isolate by default.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/phy/phy_device.c | 11 +++++++++++
 include/linux/phy.h          |  1 +
 2 files changed, 12 insertions(+)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index c468e72bef4b..2a3db1043626 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -2127,6 +2127,14 @@ int phy_loopback(struct phy_device *phydev, bool enable)
 }
 EXPORT_SYMBOL(phy_loopback);
 
+static bool phy_can_isolate(struct phy_device *phydev)
+{
+	if (phydev->drv)
+		return !(phydev->drv->flags & PHY_NO_ISOLATE);
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
index ae33919aa0f5..f0a8a5459fbe 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -90,6 +90,7 @@ extern const int phy_10gbit_features_array[1];
 #define PHY_RST_AFTER_CLK_EN	0x00000002
 #define PHY_POLL_CABLE_TEST	0x00000004
 #define PHY_ALWAYS_CALL_SUSPEND	0x00000008
+#define PHY_NO_ISOLATE		0x00000010
 #define MDIO_DEVICE_IS_PHY	0x80000000
 
 /**
-- 
2.46.0



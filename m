Return-Path: <netdev+bounces-76488-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D82186DEC6
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 11:04:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C86CF28A233
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 10:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C3706E5E3;
	Fri,  1 Mar 2024 10:02:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD456CBEE
	for <netdev@vger.kernel.org>; Fri,  1 Mar 2024 10:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709287332; cv=none; b=ZTui6Pk+y0sfWIrRzOQpYOrnnI1zdFURFbRc4FaK/AViCxcd7xNcLCmJRj7wjLLUDTKG/mtAMQum600FuJsjcYcVT43Pm0p9j1XGRYCxs4se4ofV+IDqj/U2DOFREUJhKkT1sFTaKQAW+oVXXVk4GXfQES4a3pjzDdOlEa/onW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709287332; c=relaxed/simple;
	bh=uCZhXHLSFkdy7i0Gfza9gulaJphXTOfQr0iTmcrT+Y0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sIN6zVwNOi2hhwo/KvPA+hs6BKb5OBTO/YpGWir/5zzWpue2CC1xIZ4PXQX9vmrw1xKyc3M5XIf8WtaQ/APCZRe+bu6R8bjvz5OPwdA79QiDunqDMjervjO/PNc3HHKe8wwiiZvwnQCXSeRlqgJm8yFrlFj0Upk+igh6n2cRoDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1rfziG-0003og-LB; Fri, 01 Mar 2024 11:01:56 +0100
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1rfziE-003kq5-Ii; Fri, 01 Mar 2024 11:01:54 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1rfziE-003tMe-1b;
	Fri, 01 Mar 2024 11:01:54 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Wei Fang <wei.fang@nxp.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	NXP Linux Team <linux-imx@nxp.com>
Subject: [PATCH net-next v8 3/8] net: phy: Add helper to set EEE Clock stop enable bit
Date: Fri,  1 Mar 2024 11:01:48 +0100
Message-Id: <20240301100153.927743-4-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240301100153.927743-1-o.rempel@pengutronix.de>
References: <20240301100153.927743-1-o.rempel@pengutronix.de>
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

From: Andrew Lunn <andrew@lunn.ch>

The MAC driver can request that the PHY stops the clock during EEE
LPI. This has normally been does as part of phy_init_eee(), however
that function is overly complex and often wrongly used. Add a
standalone helper, to aid removing phy_init_eee().

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/net/phy/phy.c | 20 ++++++++++++++++++++
 include/linux/phy.h   |  1 +
 2 files changed, 21 insertions(+)

diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index 2bc0a7d51c63f..ab18b0d9beb47 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -1579,6 +1579,26 @@ void phy_mac_interrupt(struct phy_device *phydev)
 }
 EXPORT_SYMBOL(phy_mac_interrupt);
 
+/**
+ * phy_eee_clk_stop_enable - Clock should stop during LIP
+ * @phydev: target phy_device struct
+ *
+ * Description: Program the MMD register 3.0 setting the "Clock stop enable"
+ * bit.
+ */
+int phy_eee_clk_stop_enable(struct phy_device *phydev)
+{
+	int ret;
+
+	mutex_lock(&phydev->lock);
+	ret = phy_set_bits_mmd(phydev, MDIO_MMD_PCS, MDIO_CTRL1,
+			       MDIO_PCS_CTRL1_CLKSTOP_EN);
+	mutex_unlock(&phydev->lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(phy_eee_clk_stop_enable);
+
 /**
  * phy_init_eee - init and check the EEE feature
  * @phydev: target phy_device struct
diff --git a/include/linux/phy.h b/include/linux/phy.h
index a880f6d7170ea..432c561f58098 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -1995,6 +1995,7 @@ int phy_unregister_fixup_for_id(const char *bus_id);
 int phy_unregister_fixup_for_uid(u32 phy_uid, u32 phy_uid_mask);
 
 int phy_init_eee(struct phy_device *phydev, bool clk_stop_enable);
+int phy_eee_clk_stop_enable(struct phy_device *phydev);
 int phy_get_eee_err(struct phy_device *phydev);
 int phy_ethtool_set_eee(struct phy_device *phydev, struct ethtool_keee *data);
 int phy_ethtool_get_eee(struct phy_device *phydev, struct ethtool_keee *data);
-- 
2.39.2



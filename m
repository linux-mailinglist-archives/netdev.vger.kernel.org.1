Return-Path: <netdev+bounces-50109-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F7107F4A44
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 16:31:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED0622810CE
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 15:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 767514F1ED;
	Wed, 22 Nov 2023 15:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="FVDgcWST"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDEAE11F
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 07:31:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=TniPZp+vD2ayAvqfo7cBvwDPyl7AElQETohjboA7cio=; b=FVDgcWSTMUD4CaxBRpZ4BYOtPA
	84NMo5jH5W9oICoO03RvJWc99X4r8VWWJcQLPUHW973DLgr1xjeC17RI+IxhSLEi0UmxRTe3cPX9B
	ny60YD1M5pGCScyL+i4XWp6GNYmw4AvKPy9ldrT/cEN9aAPnPsC/4tZc5nNmhf5Rciw5JtrT1dtXp
	0qAHhwqIQhvP4CqtpjB0XvfmZEl4RkIUYhRabwzkLxW4KZejhrdRzXV2UUkN4WkFA8KKFfQkvvN9k
	1Qb68uG+cpNnN8iDVtc5WBD7sVNzPqlmnuTTXksPNhwJU7/2z9DjE59188TKQaQ895Zr63omrIhwe
	12E04Abw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:52146 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1r5pC8-0000KQ-2l;
	Wed, 22 Nov 2023 15:31:16 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1r5pCA-00DAGv-RX; Wed, 22 Nov 2023 15:31:18 +0000
In-Reply-To: <ZV4eolj9AI0b37y6@shell.armlinux.org.uk>
References: <ZV4eolj9AI0b37y6@shell.armlinux.org.uk>
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
Subject: [PATCH RFC net-next 01/10] net: phy: add possible interfaces
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1r5pCA-00DAGv-RX@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 22 Nov 2023 15:31:18 +0000

Add a possible_interfaces member to struct phy_device to indicate which
interfaces a clause 45 PHY may switch between depending on the media.
This must be populated by the PHY driver by the time the .config_init()
method completes according to the PHYs host-side configuration.

For example, the Marvell 88x3310 PHY can switch between 10GBASE-R,
5GBASE-R, 2500BASE-X, and SGMII on the host side depending on the media
side speed, so all these interface modes are set in the
possible_interfaces member.

This allows phylib users (such as phylink) to know in advance which
interface modes to expect, which allows them to appropriately restrict
the advertised link modes according to the capabilities of other parts
of the link.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/phy/phy_device.c | 2 ++
 include/linux/phy.h          | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 2ce74593d6e4..6494e66c5e10 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -1247,6 +1247,8 @@ int phy_init_hw(struct phy_device *phydev)
 	if (ret < 0)
 		return ret;
 
+	phy_interface_zero(phydev->possible_interfaces);
+
 	if (phydev->drv->config_init) {
 		ret = phydev->drv->config_init(phydev);
 		if (ret < 0)
diff --git a/include/linux/phy.h b/include/linux/phy.h
index e5f1f41e399c..6e7ebcc50b85 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -605,6 +605,8 @@ struct macsec_ops;
  * @irq_rerun: Flag indicating interrupts occurred while PHY was suspended,
  *             requiring a rerun of the interrupt handler after resume
  * @interface: enum phy_interface_t value
+ * @possible_interfaces: bitmap if interface modes that the attached PHY
+ *			 will switch between depending on media speed.
  * @skb: Netlink message for cable diagnostics
  * @nest: Netlink nest used for cable diagnostics
  * @ehdr: nNtlink header for cable diagnostics
@@ -674,6 +676,7 @@ struct phy_device {
 	u32 dev_flags;
 
 	phy_interface_t interface;
+	DECLARE_PHY_INTERFACE_MASK(possible_interfaces);
 
 	/*
 	 * forced speed & duplex (no autoneg)
-- 
2.30.2



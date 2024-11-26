Return-Path: <netdev+bounces-147363-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DE7F69D9465
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 10:27:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F79AB2BA2C
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 09:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4CE21D049D;
	Tue, 26 Nov 2024 09:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="GQJ/ulSk"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D480D1BD030
	for <netdev@vger.kernel.org>; Tue, 26 Nov 2024 09:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732613092; cv=none; b=ay0vUJnKzIAJDJKLL8DCCcxjYOBIfze9Jcre2sNkLIEN3MbIlqD7plCzKR+PUZbVJyh5JObf6mI98fHG7M4BjcvMw+helbgn75VtyFNZ6wHJE7IXX15GzvqVkzzPd37FO9XFuCH08skFx4ZPqMY2gus1DplVeH+gqd4gNQZw6f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732613092; c=relaxed/simple;
	bh=2dVszNd6s+ix2mgPssHrpHIpQk2Bmkyl84cSALIup5A=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=jncRt5EV6MWm8B/xPfcRo+Lci4ejrtuQujKD+boX7rt00czqMfbitlCPxGxZgbo7rKuRnxaNfh6MqldGZRcjKDPVdmmptuzPjzerEOx7WSMAqXKUcDoV2u7c6IN2ALkik74MkB0iU5DXpUyCWkfP+Y+sdVYmbEfOJhDVpIO1q+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=GQJ/ulSk; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ViyBqZDRf9mxt/gnHL7aRAYMh2xDyHVj2nyl3rce0Ks=; b=GQJ/ulSkVWJHiIVfXGxvaQiiIj
	e9muwTR/cxOXIAFlBTPI4Mc+6RS6qIF/zLCfzvGFzIRL3d6A/AWYJWxxusgjvoHox/4N/6500KRJk
	A899l13IltA4KYkS4p7SrDRQ/mnlfSw4VT2+Hh86WSDYqAdLaY1S/76RyspCXQ5xAfh9kQsIY85vd
	5H+ZZaSkceXtpPZqSKRpyUBvZlcUlS8th9g8iLZL9IZXYRMwLxktXznf63ZEs5z9isRChZgZULFQH
	naHe6YPZiWwMMcopiwoVmwzH7cLtEcmFDo76q3OZYUBaqZayQQva4+7mCbdZerjWAbSU3n4rDx9vR
	c4v4HYKw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:37314 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tFroD-0006Sd-0l;
	Tue, 26 Nov 2024 09:24:37 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tFroB-005xPw-Vd; Tue, 26 Nov 2024 09:24:36 +0000
In-Reply-To: <Z0WTpE8wkpjMiv_J@shell.armlinux.org.uk>
References: <Z0WTpE8wkpjMiv_J@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexander Couzens <lynxis@fe80.eu>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Daniel Golle <daniel@makrotopia.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jose Abreu <Jose.Abreu@synopsys.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Marcin Wojtas <marcin.s.wojtas@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH RFC net-next 04/16] net: phy: add phy_inband_caps()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tFroB-005xPw-Vd@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 26 Nov 2024 09:24:35 +0000

Add a method to query the PHY's in-band capabilities for a PHY
interface mode.

Where the interface mode does not have in-band capability, or the PHY
driver has not been updated to return this information, then
phy_inband_caps() should return zero. Otherwise, PHY drivers will
return a value consisting of the following flags:

LINK_INBAND_DISABLE indicates that the hardware does not support
in-band signalling, or can have in-band signalling configured via
software to be disabled.

LINK_INBAND_ENABLE indicates that the hardware will use in-band
signalling, or can have in-band signalling configured via software
to be enabled.

LINK_INBAND_BYPASS indicates that the hardware has the ability to
bypass in-band signalling when enabled after a timeout if the link
partner does not respond to its in-band signalling.

This reports the PHY capabilities for the particular interface mode,
not the current configuration.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/phy/phy.c | 21 +++++++++++++++++++++
 include/linux/phy.h   | 28 ++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index 4f3e742907cb..d7b34f8ae415 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -1005,6 +1005,27 @@ static int phy_check_link_status(struct phy_device *phydev)
 	return 0;
 }
 
+/**
+ * phy_inband_caps - query which in-band signalling modes are supported
+ * @phydev: a pointer to a &struct phy_device
+ * @interface: the interface mode for the PHY
+ *
+ * Returns zero if it is unknown what in-band signalling is supported by the
+ * PHY (e.g. because the PHY driver doesn't implement the method.) Otherwise,
+ * returns a bit mask of the LINK_INBAND_* values from
+ * &enum link_inband_signalling to describe which inband modes are supported
+ * by the PHY for this interface mode.
+ */
+unsigned int phy_inband_caps(struct phy_device *phydev,
+			     phy_interface_t interface)
+{
+	if (phydev->drv && phydev->drv->inband_caps)
+		return phydev->drv->inband_caps(phydev, interface);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(phy_inband_caps);
+
 /**
  * _phy_start_aneg - start auto-negotiation for this PHY device
  * @phydev: the phy_device struct
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 77c6d6451638..ff60c4785e11 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -815,6 +815,24 @@ struct phy_tdr_config {
 };
 #define PHY_PAIR_ALL -1
 
+/**
+ * enum link_inband_signalling - in-band signalling modes that are supported
+ *
+ * @LINK_INBAND_DISABLE: in-band signalling can be disabled
+ * @LINK_INBAND_ENABLE: in-band signalling can be enabled without bypass
+ * @LINK_INBAND_BYPASS: in-band signalling can be enabled with bypass
+ *
+ * The possible and required bits can only be used if the valid bit is set.
+ * If possible is clear, that means inband signalling can not be used.
+ * Required is only valid when possible is set, and means that inband
+ * signalling must be used.
+ */
+enum link_inband_signalling {
+	LINK_INBAND_DISABLE		= BIT(0),
+	LINK_INBAND_ENABLE		= BIT(1),
+	LINK_INBAND_BYPASS		= BIT(2),
+};
+
 /**
  * struct phy_plca_cfg - Configuration of the PLCA (Physical Layer Collision
  * Avoidance) Reconciliation Sublayer.
@@ -954,6 +972,14 @@ struct phy_driver {
 	 */
 	int (*get_features)(struct phy_device *phydev);
 
+	/**
+	 * @inband_caps: query whether in-band is supported for the given PHY
+	 * interface mode. Returns a bitmask of bits defined by enum
+	 * link_inband_signalling.
+	 */
+	unsigned int (*inband_caps)(struct phy_device *phydev,
+				    phy_interface_t interface);
+
 	/**
 	 * @get_rate_matching: Get the supported type of rate matching for a
 	 * particular phy interface. This is used by phy consumers to determine
@@ -1816,6 +1842,8 @@ int phy_config_aneg(struct phy_device *phydev);
 int _phy_start_aneg(struct phy_device *phydev);
 int phy_start_aneg(struct phy_device *phydev);
 int phy_aneg_done(struct phy_device *phydev);
+unsigned int phy_inband_caps(struct phy_device *phydev,
+			     phy_interface_t interface);
 int phy_speed_down(struct phy_device *phydev, bool sync);
 int phy_speed_up(struct phy_device *phydev);
 bool phy_check_valid(int speed, int duplex, unsigned long *features);
-- 
2.30.2



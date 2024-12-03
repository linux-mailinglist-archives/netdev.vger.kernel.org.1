Return-Path: <netdev+bounces-148569-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D493C9E230C
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 16:32:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9425B2826A5
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 15:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B202F1F8921;
	Tue,  3 Dec 2024 15:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Q8xluHOV"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E1A1F8AC8
	for <netdev@vger.kernel.org>; Tue,  3 Dec 2024 15:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733239870; cv=none; b=TYAKLXJVE/9kLwhC+pH0OW7OFg3UivDQVJ8r6UUWNlw61bjOLsngis10EXJBIWC+Pruj706Ajr5be057DwbvtfX3bvzKFeuHYkVeIeRHeKsT230LzoPYwmcVJq4TFhe2MWd0U9KksC6z3Y+dbIqTRPP916B2NMWfOSTHkYcCJPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733239870; c=relaxed/simple;
	bh=KEtHzs0wTj1TDiEwAtY6WTxcJKtG2E/4+GkvKeW6UNc=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=qWkU5dGkVvv09oLDyiD+hxyTNrwrzuw3UKImyaetzkBPl6pbY/wL5SNwgBYdzl9MDz+/cvVpK+f24a3JXEqtXOnUavajZHhKehFI/62VeZe27CqUS6rlCWAbIxRLrj7TBSkOz2UfdyCoMUNOwJn4F+QDUdkFn/90fwwNPyXCotU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Q8xluHOV; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=zDBQ/cKtnrw9FVtCtk6qdOYO3KL+q5MXQzzHoUADJhw=; b=Q8xluHOVwQyEBp6FIkcyydd7T2
	qI0D+vNtOL85XRyRSbIAti0rfTTHtPNw0+z1wXnYfbjpm5s2x6kuWgYHynYTC5lS0lHhzwfKj7jmG
	rBAY7aLSG9Z1ni06jhOmrLDkULkbjm/b4gEHGAECE3iY7S4sn5ueoFN997aiVjjbckZmoKpXF+mZT
	TgfmxcMdKQwSVsS//oOc+7E8dEDCZcFDyxexab5a5VT+oaJibohyTz4iOlmGXb93lSDjldjCDljRG
	/+2ptHFvZZw7//mQoRiFeoblHNmbDpazejgrZ+3mjbzUMc6V0GEVS8peTj7BGh8DkWXHxIwu24eRR
	oHOc22qg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:50450 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tIUrf-000287-2o;
	Tue, 03 Dec 2024 15:31:04 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tIUre-006ITz-KF; Tue, 03 Dec 2024 15:31:02 +0000
In-Reply-To: <Z08kCwxdkU4n2V6x@shell.armlinux.org.uk>
References: <Z08kCwxdkU4n2V6x@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: [PATCH net-next 04/13] net: phy: add phy_inband_caps()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tIUre-006ITz-KF@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 03 Dec 2024 15:31:02 +0000

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

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/phy/phy.c | 21 +++++++++++++++++++++
 include/linux/phy.h   | 28 ++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index 0d20b534122b..f42cd6584841 100644
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
index 563c46205685..ccb93d892da9 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -817,6 +817,24 @@ struct phy_tdr_config {
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
@@ -956,6 +974,14 @@ struct phy_driver {
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
@@ -1818,6 +1844,8 @@ int phy_config_aneg(struct phy_device *phydev);
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



Return-Path: <netdev+bounces-147368-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 960B29D9464
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 10:27:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5637F2821A3
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 09:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF5B91D45FC;
	Tue, 26 Nov 2024 09:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="02NCBbiS"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C751D4352
	for <netdev@vger.kernel.org>; Tue, 26 Nov 2024 09:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732613119; cv=none; b=k2VrIgMtgMEMm60hLRay+iHyoI9hsMPSZIUnn9VmkD7G/s7VhmMmHQkU142q87hj0K2ffcbTMWqYr2XLB0ZWg4TskchKdnnO+1Wv+/3udHib0kwKnKwNngkA/3YMOTEHlbndbD6LValvZLTQ1CIbaoN9nwRg0fm3pVR70rH4aX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732613119; c=relaxed/simple;
	bh=IZUkFTl5bZpAalqTsnwG/iRpPpwnmhOhfbpDLK0y0ZM=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=gAixntoU5Z7UTvHGUfsJLDLWOd8ep/aKWbNBvbUz1O/Y7uImPiZ6tmoXFZS4ZS4xx6HDph258g3KFZ+GYzPITVHEhVzsv0p1Dcbw564S6u1w4YUnWxQerlEzT5UEr3iwAPrGuOLwvLTINmomVYfhQhyu14Poams5Mw+auP5UQyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=02NCBbiS; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=nnhyvj3d8XtptBHuFTiG10lDwil4VamFlPvg5Ad2Ku0=; b=02NCBbiSkgV8CkMZ9aROGJtACH
	ES5TXDNPszVbNJIfxXaf8CIZxGG37MVXvjVS9Y1kYftelezHuDdLQ2fx02CS2GsxVLhc1PugMI+O1
	O4/+2xDTd97UMNxJMbDaE7T0mt9HQtDNpSuBtaQML1tAcVG/Wpp0x0hVieTuimaA1Q++AVyC9luRc
	D5UQcHR+PVso12jnVPRQQ/Qfr9H2im0MAlUDRzl0+ncZegyLq9BchKsPGd5ZlGYKvQz9WZfU8BCqV
	raofThy4nNyl+vJVf36ekJ02wA9uB1JbNbQsOc5nfDd02Al7+ZtyVVoH2OORPyKIWs9Jq0LHW0o+Q
	1kcG+ZxA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:32898 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tFrod-0006UK-03;
	Tue, 26 Nov 2024 09:25:03 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tFrob-005xQS-Hz; Tue, 26 Nov 2024 09:25:01 +0000
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
Subject: [PATCH RFC net-next 09/16] net: phylink: add pcs_inband_caps() method
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tFrob-005xQS-Hz@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 26 Nov 2024 09:25:01 +0000

Add a pcs_inband_caps() method to query the PCS for its inband link
capabilities, and use this to determine whether link modes used with
optical SFPs can be supported.

When a PCS does not provide a method, we allow inband negotiation to
be either on or off, making this a no-op until the pcs_inband_caps()
method is implemented by a PCS driver.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/phy/phylink.c | 60 +++++++++++++++++++++++++++++++++++++++
 include/linux/phylink.h   | 17 +++++++++++
 2 files changed, 77 insertions(+)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index e43a083cec57..ca52cb23187d 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -990,6 +990,15 @@ static void phylink_resolve_an_pause(struct phylink_link_state *state)
 	}
 }
 
+static unsigned int phylink_pcs_inband_caps(struct phylink_pcs *pcs,
+				    phy_interface_t interface)
+{
+	if (pcs && pcs->ops->pcs_inband_caps)
+		return pcs->ops->pcs_inband_caps(pcs, interface);
+
+	return 0;
+}
+
 static void phylink_pcs_pre_config(struct phylink_pcs *pcs,
 				   phy_interface_t interface)
 {
@@ -1043,6 +1052,24 @@ static void phylink_pcs_link_up(struct phylink_pcs *pcs, unsigned int neg_mode,
 		pcs->ops->pcs_link_up(pcs, neg_mode, interface, speed, duplex);
 }
 
+/* Query inband for a specific interface mode, asking the MAC for the
+ * PCS which will be used to handle the interface mode.
+ */
+static unsigned int phylink_inband_caps(struct phylink *pl,
+					 phy_interface_t interface)
+{
+	struct phylink_pcs *pcs;
+
+	if (!pl->mac_ops->mac_select_pcs)
+		return 0;
+
+	pcs = pl->mac_ops->mac_select_pcs(pl->config, interface);
+	if (!pcs)
+		return 0;
+
+	return phylink_pcs_inband_caps(pcs, interface);
+}
+
 static void phylink_pcs_poll_stop(struct phylink *pl)
 {
 	if (pl->cfg_link_an_mode == MLO_AN_INBAND)
@@ -2541,6 +2568,26 @@ int phylink_ethtool_ksettings_get(struct phylink *pl,
 }
 EXPORT_SYMBOL_GPL(phylink_ethtool_ksettings_get);
 
+static bool phylink_validate_pcs_inband_autoneg(struct phylink *pl,
+					        phy_interface_t interface,
+						unsigned long *adv)
+{
+	unsigned int inband = phylink_inband_caps(pl, interface);
+	unsigned int mask;
+
+	/* If the PCS doesn't implement inband support, be permissive. */
+	if (!inband)
+		return true;
+
+	if (linkmode_test_bit(ETHTOOL_LINK_MODE_Autoneg_BIT, adv))
+		mask = LINK_INBAND_ENABLE;
+	else
+		mask = LINK_INBAND_DISABLE;
+
+	/* Check whether the PCS implements the required mode */
+	return !!(inband & mask);
+}
+
 /**
  * phylink_ethtool_ksettings_set() - set the link settings
  * @pl: a pointer to a &struct phylink returned from phylink_create()
@@ -2671,6 +2718,13 @@ int phylink_ethtool_ksettings_set(struct phylink *pl,
 	    phylink_is_empty_linkmode(config.advertising))
 		return -EINVAL;
 
+	/* Validate the autonegotiation state. We don't have a PHY in this
+	 * situation, so the PCS is the media-facing entity.
+	 */
+	if (!phylink_validate_pcs_inband_autoneg(pl, config.interface,
+						 config.advertising))
+		return -EINVAL;
+
 	mutex_lock(&pl->state_mutex);
 	pl->link_config.speed = config.speed;
 	pl->link_config.duplex = config.duplex;
@@ -3350,6 +3404,12 @@ static int phylink_sfp_config_optical(struct phylink *pl)
 	phylink_dbg(pl, "optical SFP: chosen %s interface\n",
 		    phy_modes(interface));
 
+	if (!phylink_validate_pcs_inband_autoneg(pl, interface,
+						 config.advertising)) {
+		phylink_err(pl, "autoneg setting not compatible with PCS");
+		return -EINVAL;
+	}
+
 	config.interface = interface;
 
 	/* Ignore errors if we're expecting a PHY to attach later */
diff --git a/include/linux/phylink.h b/include/linux/phylink.h
index 595139797acb..ef26111d0040 100644
--- a/include/linux/phylink.h
+++ b/include/linux/phylink.h
@@ -422,6 +422,7 @@ struct phylink_pcs {
 /**
  * struct phylink_pcs_ops - MAC PCS operations structure.
  * @pcs_validate: validate the link configuration.
+ * @pcs_inband_caps: query inband support for interface mode.
  * @pcs_enable: enable the PCS.
  * @pcs_disable: disable the PCS.
  * @pcs_pre_config: pre-mac_config method (for errata)
@@ -437,6 +438,8 @@ struct phylink_pcs {
 struct phylink_pcs_ops {
 	int (*pcs_validate)(struct phylink_pcs *pcs, unsigned long *supported,
 			    const struct phylink_link_state *state);
+	unsigned int (*pcs_inband_caps)(struct phylink_pcs *pcs,
+					phy_interface_t interface);
 	int (*pcs_enable)(struct phylink_pcs *pcs);
 	void (*pcs_disable)(struct phylink_pcs *pcs);
 	void (*pcs_pre_config)(struct phylink_pcs *pcs,
@@ -473,6 +476,20 @@ struct phylink_pcs_ops {
 int pcs_validate(struct phylink_pcs *pcs, unsigned long *supported,
 		 const struct phylink_link_state *state);
 
+/**
+ * pcs_inband_caps - query PCS in-band capabilities for interface mode.
+ * @pcs: a pointer to a &struct phylink_pcs.
+ * @interface: interface mode to be queried
+ *
+ * Returns zero if it is unknown what in-band signalling is supported by the
+ * PHY (e.g. because the PHY driver doesn't implement the method.) Otherwise,
+ * returns a bit mask of the LINK_INBAND_* values from
+ * &enum link_inband_signalling to describe which inband modes are supported
+ * for this interface mode.
+ */
+unsigned int pcs_inband_caps(struct phylink_pcs *pcs,
+			     phy_interface_t interface);
+
 /**
  * pcs_enable() - enable the PCS.
  * @pcs: a pointer to a &struct phylink_pcs.
-- 
2.30.2



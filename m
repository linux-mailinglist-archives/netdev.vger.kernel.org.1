Return-Path: <netdev+bounces-148574-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7193D9E2320
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 16:32:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33AF12846E0
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 15:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A79E1F8915;
	Tue,  3 Dec 2024 15:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="o5WBJmY0"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABFDA1F76DE
	for <netdev@vger.kernel.org>; Tue,  3 Dec 2024 15:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733239895; cv=none; b=SOrPWuHoOisW5CXbrRaoYtxl6LmyAJ7K2wlnCOKX+w/BF7MgVOnZr4vEUZ0AaXBATxSuiBuOn4k/d+NJzzgtU1cDPPeydAdul6Rg8gDiIDxe6/eYt4LZQL8fwsp9PN5DUu9OYWH3LZwLG630qXEEff9Wgy51+Dxc0IVQEyr2KD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733239895; c=relaxed/simple;
	bh=2gTfSJAiMMCI8R9Z9XdqgEbCR6Y+G+REE5qc+YMyuqU=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=h1MP1di7dIpYwPLklsELsjHINfM+RILNS49cOamoU1MKqSXOyETikJYT8Px6gWo91AW/jxzWQSR+es4Rso77Eaqa8hJqriWJNl6sLlZoy2+Ia4L+SQYRKDQ25J/jzqrzRFulh591hJp3q2s7nIxrmIBezCfhuoMTXYZrssuxK4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=o5WBJmY0; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=gufDF9xBYCPVuAO0GmsGJp4vy1S6tIncK0Jhac6Li08=; b=o5WBJmY0MW+ofaa21bhB6vf42n
	blSO7OnuH5ePWuWB6K3rF669NF3VfCSiL555tUl5CEMgPd4wakidx9rnaes1p/XGshiIK/lWreotW
	u7cAuacyp3IkgmmK6Z0vz3PUwUzoOUkDygjSqCxpiy5FxwHJii9Xlqh/B2T7KdKoIj0KuNZlRfoXo
	dh5T67DZPah5w291iCKQvnQNAxmA73ssuha4qPNOhGU9rc7uPQWCqLNOPeG1wKCQ0uK9ZkHNsthHo
	sGMhw6Rr6G4LTrWmEf9tpW7f4oQBw00g6tiNuvnOGkIGccxedQCG6TuZ8bEX4iyUX3vtBPxurIEEL
	L3b7FtDA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:48892 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tIUs5-00029D-1L;
	Tue, 03 Dec 2024 15:31:29 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tIUs4-006IUU-7K; Tue, 03 Dec 2024 15:31:28 +0000
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
Subject: [PATCH net-next 09/13] net: phylink: add pcs_inband_caps() method
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tIUs4-006IUU-7K@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 03 Dec 2024 15:31:28 +0000

Add a pcs_inband_caps() method to query the PCS for its inband link
capabilities, and use this to determine whether link modes used with
optical SFPs can be supported.

When a PCS does not provide a method, we allow inband negotiation to
be either on or off, making this a no-op until the pcs_inband_caps()
method is implemented by a PCS driver.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/phy/phylink.c | 60 +++++++++++++++++++++++++++++++++++++++
 include/linux/phylink.h   | 17 +++++++++++
 2 files changed, 77 insertions(+)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index fda53dd58285..42f3c7ccbf38 100644
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
@@ -2532,6 +2559,26 @@ int phylink_ethtool_ksettings_get(struct phylink *pl,
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
@@ -2662,6 +2709,13 @@ int phylink_ethtool_ksettings_set(struct phylink *pl,
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
@@ -3341,6 +3395,12 @@ static int phylink_sfp_config_optical(struct phylink *pl)
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
index 5c01048860c4..5462cc6a37dc 100644
--- a/include/linux/phylink.h
+++ b/include/linux/phylink.h
@@ -419,6 +419,7 @@ struct phylink_pcs {
 /**
  * struct phylink_pcs_ops - MAC PCS operations structure.
  * @pcs_validate: validate the link configuration.
+ * @pcs_inband_caps: query inband support for interface mode.
  * @pcs_enable: enable the PCS.
  * @pcs_disable: disable the PCS.
  * @pcs_pre_config: pre-mac_config method (for errata)
@@ -434,6 +435,8 @@ struct phylink_pcs {
 struct phylink_pcs_ops {
 	int (*pcs_validate)(struct phylink_pcs *pcs, unsigned long *supported,
 			    const struct phylink_link_state *state);
+	unsigned int (*pcs_inband_caps)(struct phylink_pcs *pcs,
+					phy_interface_t interface);
 	int (*pcs_enable)(struct phylink_pcs *pcs);
 	void (*pcs_disable)(struct phylink_pcs *pcs);
 	void (*pcs_pre_config)(struct phylink_pcs *pcs,
@@ -470,6 +473,20 @@ struct phylink_pcs_ops {
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



Return-Path: <netdev+bounces-150238-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53D019E98AA
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 15:23:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0979E2858C7
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 14:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2A511B0419;
	Mon,  9 Dec 2024 14:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="jawGFAzD"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5FC35946
	for <netdev@vger.kernel.org>; Mon,  9 Dec 2024 14:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733754232; cv=none; b=c1ZnvyALBYblpG5CS5aKO2VU1oBhJ/dyN/8j/lIqrwOKcTZFryo4+uWtTHS0sV3KMNo7J2HOHT3VlqjJhvHxWQyUWBjnoi5PaqBgPIeMKTcQRRtxwB9X/qH0lPzTiC9UPuOb4ZQlLQBJMJTharFe3KfnxJ74B31cpJwigZYrGq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733754232; c=relaxed/simple;
	bh=ih3lHqZufWcfLCTi/cQCRDbqI7hdUi3I+y9zQpeAY8w=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=u2hdz1rxD4HVHzHHI3VJTZNGyMxFvtUD0W/NJ0qxcmMrwgToDbsnBx3XZPUAfVCrCdR5tx6mXv66C+4/i9BNq0p7eWoYfUVs4mWX2a0Av2NgEInoIHd/juDw2E3h4SBWYduip7FozvEUU7i3yG/wydFOLXlNjAHce0eftn5A+qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=jawGFAzD; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=vbgKtkwavWHQPAjV7lOJL+jWNxfzGH3YYncPjKA6/FU=; b=jawGFAzDAy+VYbUfq9HE3Ss9ob
	skLKHnYWyV84Xt23dQrk/5i/CLXpPdeY8dnhFw4HQESoBD/jGqPbcd+1t5lh2YSf+X38tPgUgkgjn
	33sipjLiVjPJnarBZJGaChPcdhsP1I4FRqdeVUwA+H7Ep5HEQ8v5XbpMRCNN4S3egv0V47PIGUeM8
	+fZ3R4lNtUjQj4XSRC34IGvTsHYX10dZaBvbAD/pY3PxmueDYWIfhZ6s5DyySU3IMGEjsNesvktNf
	gn6IEaPkjOeb6dPCj+HvaOvVzEfBWMV3UvVtQt/XPV7jBCZW+Q2lT7xPV6RUviKySGa+gPQy6ypb/
	VMUKJ5/w==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:50618 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tKefp-0000xU-0L;
	Mon, 09 Dec 2024 14:23:45 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tKefn-006SMv-Lg; Mon, 09 Dec 2024 14:23:43 +0000
In-Reply-To: <Z1b9J-FihzJ4A6aQ@shell.armlinux.org.uk>
References: <Z1b9J-FihzJ4A6aQ@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	Bryan Whitehead <bryan.whitehead@microchip.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Marcin Wojtas <marcin.s.wojtas@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	UNGLinuxDriver@microchip.com
Subject: [PATCH net-next 06/10] net: phylink: allow MAC driver to validate eee
 params
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tKefn-006SMv-Lg@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Mon, 09 Dec 2024 14:23:43 +0000

Allow the MAC driver to validate EEE parameters before accepting the
set_eee() call.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/phy/phylink.c | 16 +++++++++++++++-
 include/linux/phylink.h   | 15 +++++++++++++++
 2 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 750356b6a2e9..995bfbbd18e9 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -1570,6 +1570,14 @@ static const char *phylink_pause_to_str(int pause)
 	}
 }
 
+static int phylink_validate_tx_lpi(struct phylink *pl, struct ethtool_keee *eee)
+{
+	if (!pl->mac_ops->mac_validate_tx_lpi)
+		return 0;
+
+	return pl->mac_ops->mac_validate_tx_lpi(pl->config, eee);
+}
+
 static void phylink_deactivate_lpi(struct phylink *pl)
 {
 	if (pl->mac_enable_tx_lpi) {
@@ -3170,7 +3178,7 @@ EXPORT_SYMBOL_GPL(phylink_ethtool_get_eee);
 int phylink_ethtool_set_eee(struct phylink *pl, struct ethtool_keee *eee)
 {
 	bool mac_eee = pl->mac_supports_eee;
-	int ret = -EOPNOTSUPP;
+	int ret;
 
 	ASSERT_RTNL();
 
@@ -3187,6 +3195,12 @@ int phylink_ethtool_set_eee(struct phylink *pl, struct ethtool_keee *eee)
 			    eee->tx_lpi_timer);
 	}
 
+	ret = phylink_validate_tx_lpi(pl, eee);
+	if (ret)
+		return ret;
+
+	ret = -EOPNOTSUPP;
+
 	if (pl->phydev) {
 		ret = phy_ethtool_set_eee(pl->phydev, eee);
 		if (ret == 0)
diff --git a/include/linux/phylink.h b/include/linux/phylink.h
index f72f0a1feb89..03e790579203 100644
--- a/include/linux/phylink.h
+++ b/include/linux/phylink.h
@@ -187,6 +187,7 @@ void phylink_limit_mac_speed(struct phylink_config *config, u32 max_speed);
  * @mac_finish: finish a major reconfiguration of the interface.
  * @mac_link_down: take the link down.
  * @mac_link_up: allow the link to come up.
+ * @mac_validate_tx_lpi: validate LPI configuration.
  * @mac_disable_tx_lpi: disable LPI.
  * @mac_enable_tx_lpi: enable and configure LPI.
  *
@@ -209,6 +210,8 @@ struct phylink_mac_ops {
 			    struct phy_device *phy, unsigned int mode,
 			    phy_interface_t interface, int speed, int duplex,
 			    bool tx_pause, bool rx_pause);
+	int (*mac_validate_tx_lpi)(struct phylink_config *config,
+				   struct ethtool_keee *e);
 	void (*mac_disable_tx_lpi)(struct phylink_config *config);
 	void (*mac_enable_tx_lpi)(struct phylink_config *config, u32 timer,
 				  bool tx_clk_stop);
@@ -407,6 +410,18 @@ void mac_link_up(struct phylink_config *config, struct phy_device *phy,
 		 unsigned int mode, phy_interface_t interface,
 		 int speed, int duplex, bool tx_pause, bool rx_pause);
 
+/**
+ * mac_validate_tx_lpi() - validate the LPI parameters in EEE
+ * @config: a pointer to a &struct phylink_config.
+ * @e: EEE configuration to be validated.
+ *
+ * Validate the LPI configuration parameters in @e, returning an appropriate
+ * error. This will be called prior to any changes being made, and must not
+ * make any changes to existing configuration. Returns zero on success.
+ */
+int (*mac_validate_tx_lpi)(struct phylink_config *config,
+			   struct ethtool_keee *e);
+
 /**
  * mac_disable_tx_lpi() - disable LPI generation at the MAC
  * @config: a pointer to a &struct phylink_config.
-- 
2.30.2



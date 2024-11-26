Return-Path: <netdev+bounces-147424-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 887619D9793
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 13:53:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0878BB265F4
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 12:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10FE81D1E74;
	Tue, 26 Nov 2024 12:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="uORnPyRX"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F87192D65
	for <netdev@vger.kernel.org>; Tue, 26 Nov 2024 12:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732625593; cv=none; b=qyZJjAO2bH8swQaiBylg4WmDBNSiTIK8VAdJqvkq+3ZSXU3suANJ9GJjzy9xBdTZmyc2/kh9iAfUsG6UfpxqdJIIpO15lNqvQ8HMKKmo6lYgT5kejLUSl+Hd+XJvGzSujbNKwV241ipDEMKCZeqEVnwHMveZz1sKMp61X/93GPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732625593; c=relaxed/simple;
	bh=zB5sGOPUKzn0B2Vt61My4DYZUJVvHJ9gMoER0ddmZjk=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=WlFNvQyMw/jAzoohAauux6m9X+cajRJqkn0IUoIv8ll+qC8YCX8sF11htXtzgZq5hK9vHMRJzbGPt7G99sab+3vz5aR/ROLNNclGsRrZyAgyehGwFt7CWC/qWjP2yPUEACobU7wMd+tINnvpgoRJ7Q2jvN8yPj8uA8MID9MqCtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=uORnPyRX; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=YrRBFjzD2crSgRpPTXiskXFXmSEIx5eNanvtUfjPMXI=; b=uORnPyRXtwosRyXd/hSpFC+IHq
	a9Hg35iqjeSRwrAp5YbVtwfITI+BNuDvbprXzp9tyZCbWyhP15OlQAkf8T+Y3Jgc/BW+StHe4g2VQ
	26caF9ly+mkxF9JuPiIDtm1EzTPzWRBWU3w2h5ZiypPenKtlnNSLyuD40CqK5QN4sc/XCNQrdG0g8
	2kDSAlnzyre1GLEgahk2BUmIU35EdmzzQHF2AGS6IdXENgXqYDG7yP9TuJ3q4Lp63hUv5arnztHOZ
	5lZXyJ0NBtzDPKB3orLCfVGRnm/C/+3LaT9sAmrX2oE9QFm2wKmpP0vY+zkCjRNIcO2N/GpytZBnD
	KjUFsSIw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:39442 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tFv3q-0006tu-2u;
	Tue, 26 Nov 2024 12:52:59 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tFv3p-005yi9-3F; Tue, 26 Nov 2024 12:52:57 +0000
In-Reply-To: <Z0XEWGqLJ8okNSIr@shell.armlinux.org.uk>
References: <Z0XEWGqLJ8okNSIr@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Bryan Whitehead <bryan.whitehead@microchip.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jose Abreu <joabreu@synopsys.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Marcin Wojtas <marcin.s.wojtas@gmail.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Paolo Abeni <pabeni@redhat.com>,
	UNGLinuxDriver@microchip.com
Subject: [PATCH RFC net-next 09/23] net: phy: add configuration of rx clock
 stop mode
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tFv3p-005yi9-3F@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 26 Nov 2024 12:52:57 +0000

Add a function to allow configuration of the PCS's clock stop enable
bit, used to configure whether the xMII receive clock can be stopped
during LPI mode.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/phy/phy.c | 25 ++++++++++++++++++++-----
 include/linux/phy.h   |  1 +
 2 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index 21e0fc9a6f09..d0a9d807d48f 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -1607,6 +1607,25 @@ int phy_eee_tx_clock_stop_capable(struct phy_device *phydev)
 }
 EXPORT_SYMBOL_GPL(phy_eee_tx_clock_stop_capable);
 
+/**
+ * phy_eee_rx_clock_stop() - configure PHY receive clock in LPI
+ * phydev: target phy_device struct
+ *
+ * Configure whether the PHY may disable its receive clock during LPI mode,
+ * See IEEE 802.3 sections 22.2.2.2, 35.2.2.10, and 45.2.3.1.4. Returns 0 or
+ * negative error.
+ */
+int phy_eee_rx_clock_stop(struct phy_device *phydev, bool clk_stop_enable)
+{
+	/* Configure the PHY to stop receiving xMII
+	 * clock while it is signaling LPI.
+	 */
+	return phy_modify_mmd(phydev, MDIO_MMD_PCS, MDIO_CTRL1,
+			      MDIO_PCS_CTRL1_CLKSTOP_EN,
+			      clk_stop_enable ? MDIO_PCS_CTRL1_CLKSTOP_EN : 0);
+}
+EXPORT_SYMBOL_GPL(phy_eee_rx_clock_stop);
+
 /**
  * phy_init_eee - init and check the EEE feature
  * @phydev: target phy_device struct
@@ -1631,11 +1650,7 @@ int phy_init_eee(struct phy_device *phydev, bool clk_stop_enable)
 		return -EPROTONOSUPPORT;
 
 	if (clk_stop_enable)
-		/* Configure the PHY to stop receiving xMII
-		 * clock while it is signaling LPI.
-		 */
-		ret = phy_set_bits_mmd(phydev, MDIO_MMD_PCS, MDIO_CTRL1,
-				       MDIO_PCS_CTRL1_CLKSTOP_EN);
+		ret = phy_eee_rx_clock_stop(phydev, true);
 
 	return ret < 0 ? ret : 0;
 }
diff --git a/include/linux/phy.h b/include/linux/phy.h
index d0491cdf54b6..467149b44a8e 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -2039,6 +2039,7 @@ int phy_unregister_fixup_for_id(const char *bus_id);
 int phy_unregister_fixup_for_uid(u32 phy_uid, u32 phy_uid_mask);
 
 int phy_eee_tx_clock_stop_capable(struct phy_device *phydev);
+int phy_eee_rx_clock_stop(struct phy_device *phydev, bool clk_stop_enable);
 int phy_init_eee(struct phy_device *phydev, bool clk_stop_enable);
 int phy_get_eee_err(struct phy_device *phydev);
 int phy_ethtool_set_eee(struct phy_device *phydev, struct ethtool_keee *data);
-- 
2.30.2



Return-Path: <netdev+bounces-176601-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03A20A6B08E
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 23:16:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 483BE3BB011
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 22:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0656522B5B1;
	Thu, 20 Mar 2025 22:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="wbVA+7oy"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A5022B8A5
	for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 22:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742508696; cv=none; b=PE5pzvNk/II4AH6w1ndvRnot1yJM/gJ1Vz7AWTCXoIiuGFOif7cKvvL1OFct6TN0kjx0FtAzHh+JPE/+D/CcB0fzdsdEvPNAH05hEqIXf66kMNKXFeCIhN4mYsDSmyVjFi+niJQcLgJD7b5P2EFrHslb2JfE0TEkuVNmisBvZyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742508696; c=relaxed/simple;
	bh=osmSCg+yktdNSKUZbwza1VTHc9KJlPic0IMxA2gwNIU=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=bcTpQRoVrLTNR8mFPjpWrOOBF/4J+3a0TaGYMapTQq+NZEQKmvrB1lTdZ/Ae15kzCkTHHmV2sRWgHyTkpCqa037SxL5gjVOGNMsPRSK1Y0xT4f2WIs+So/UI/rwPwfeaohulyTkb+lEWz6vq41Lz27dF5BchccExjziwp7O/BZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=wbVA+7oy; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=fkKG+1uig/gv8dqFUSDCg+KHZ2PnbqdRy0w1E0ZwBhU=; b=wbVA+7oy5foIOmkAEoQU0k7PzL
	zKqNHoIrLmQkBIGbnASdMm1JUjTr9ZFRq1KOcvZeOoaNjHRNJ4z9yZwp0Uhaqu0cSbxI64OQFWwt2
	Zl0SjXkb6YRsinD3AQsEk+pvvNBXfxtaNGjsPYLC9WnHg/UjcPm1wcNcU/UMCYKEclLEgW/uHiDxa
	jVoVI5o1p9uK7g766JAf5+uIKfCWIaxQ6bRYZsaEKr39BjUUhk0ybUpecPSsdskVaCzzj5EeiuBVI
	f0AqWace3lwN/F3RFIA4TIDkhhjWwWsd0O9hmKk5h4Os5mrM+4jxsKF05yKEgYoTG/HeroMu5y5/p
	5nxMpz9w==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:56714 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tvO6p-0008Db-2p;
	Thu, 20 Mar 2025 22:11:27 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tvO6V-008Vjb-AP; Thu, 20 Mar 2025 22:11:07 +0000
In-Reply-To: <Z9ySeo61VYTClIJJ@shell.armlinux.org.uk>
References: <Z9ySeo61VYTClIJJ@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 1/5] net: phylink: add phylink_prepare_resume()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tvO6V-008Vjb-AP@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 20 Mar 2025 22:11:07 +0000

When the system is suspended, the PHY may be placed in low-power mode
by setting the BMCR 0.11 Power down bit. IEEE 802.3 states that the
behaviour of the PHY in this state is implementation specific, and
the PHY is not required to meet the RX_CLK and TX_CLK requirements.
Essentially, this means that a PHY may stop the clocks that it is
generating while in power down state.

However, MACs exist which require the clocks from the PHY to be running
in order to properly resume. phylink_prepare_resume() provides them
with a way to clear the Power down bit early.

Note, however, that IEEE 802.3 gives PHYs up to 500ms grace before the
transmit and receive clocks meet the requirements after clearing the
power down bit.

Add a resume preparation function, which will ensure that the receive
clock from the PHY is appropriately configured while resuming.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/phy/phylink.c | 25 +++++++++++++++++++++++++
 include/linux/phylink.h   |  1 +
 2 files changed, 26 insertions(+)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 0f70a7f3dfcc..1b76ddc286fe 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -2481,6 +2481,31 @@ void phylink_suspend(struct phylink *pl, bool mac_wol)
 }
 EXPORT_SYMBOL_GPL(phylink_suspend);
 
+/**
+ * phylink_prepare_resume() - prepare to resume a network device
+ * @pl: a pointer to a &struct phylink returned from phylink_create()
+ *
+ * Optional, but if called must be called prior to phylink_resume().
+ *
+ * Prepare to resume a network device, preparing the PHY as necessary.
+ */
+void phylink_prepare_resume(struct phylink *pl)
+{
+	struct phy_device *phydev = pl->phydev;
+
+	ASSERT_RTNL();
+
+	/* IEEE 802.3 22.2.4.1.5 allows PHYs to stop their receive clock
+	 * when PDOWN is set. However, some MACs require RXC to be running
+	 * in order to resume. If the MAC requires RXC, and we have a PHY,
+	 * then resume the PHY. Note that 802.3 allows PHYs 500ms before
+	 * the clock meets requirements. We do not implement this delay.
+	 */
+	if (pl->config->mac_requires_rxc && phydev && phydev->suspended)
+		phy_resume(phydev);
+}
+EXPORT_SYMBOL_GPL(phylink_prepare_resume);
+
 /**
  * phylink_resume() - handle a network device resume event
  * @pl: a pointer to a &struct phylink returned from phylink_create()
diff --git a/include/linux/phylink.h b/include/linux/phylink.h
index 79876c84ae81..06f1b649f173 100644
--- a/include/linux/phylink.h
+++ b/include/linux/phylink.h
@@ -707,6 +707,7 @@ void phylink_start(struct phylink *);
 void phylink_stop(struct phylink *);
 
 void phylink_suspend(struct phylink *pl, bool mac_wol);
+void phylink_prepare_resume(struct phylink *pl);
 void phylink_resume(struct phylink *pl);
 
 void phylink_ethtool_get_wol(struct phylink *, struct ethtool_wolinfo *);
-- 
2.30.2



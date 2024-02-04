Return-Path: <netdev+bounces-68922-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD56A848D7C
	for <lists+netdev@lfdr.de>; Sun,  4 Feb 2024 13:15:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B8B61F2224D
	for <lists+netdev@lfdr.de>; Sun,  4 Feb 2024 12:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D90F1224D6;
	Sun,  4 Feb 2024 12:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="vxqozgd6"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F357C224D7
	for <netdev@vger.kernel.org>; Sun,  4 Feb 2024 12:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707048821; cv=none; b=nG8lvmkXFYuoVz6AXjxKb+CkH69c1qDZHDIC+taKCyQk+Vxay04CbLoOy/ug4eAbiuNKrQq201q+BkX6BKxjwx7OpzPnxY2c94fyXvql9LIzZJpvYkTlMqknDhZCyqptg7TGr5j7SgnHKG8FTyhLzyJ1a2vR7WVTS6/be5mcbcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707048821; c=relaxed/simple;
	bh=jmOhRGhyhkvWWFkQvRyuNPvEd1M4Mfxm7VyTLlhlbEM=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=bQ7Yz3smnoZDgzZVZW8lhkHdv+3kMTs3pvCWU1CTHWzh4B6BQpHfbQtFK21oE9h3LOeAn6AOON0TOWv9Pd0RwP79XBTKTcZNUDJ7IuxxL0sMvQkLuO5PYaKYZBAdIjX8iLhQW+nJxXX0LjB0daH5g+mowAfVrEZwoGwi6nf/UK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=vxqozgd6; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=BG8iQS1uwNFv5a1AmE60y/BDGePzQB5EZyGFOh6TZKg=; b=vxqozgd6KB4EGPlgVnkumoGYga
	W652B3Zn8kaVZwCgt6RK3sG160Z9KvpUFICfCkqo6p3yLiSVHOd7DYt17zX7JzgpGxGYk7SA9WXLK
	fvONiOHNGUI5GJNaCqTAkZh3mAdOZJ8K3Ofl7B9QEt21IWrY9eSgvTx2o8J4BfWRGuT/ssCWcxNfK
	0WYl+Ljgel5fY6rYkuo2KnJQIHTf5n2P4QCgVQMV9rubmClIw6cQ63glirGZcz1RC2CQD2gIDg4ae
	wc183DRlyK2U9qdwNwBgY6/HCdb1WTsGj/+eSanZa5qGIqm/nvlX3mppWLmine/76bkhv/l36I59Y
	Hg9n04rg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:39960 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1rWbNE-0007x1-2O;
	Sun, 04 Feb 2024 12:13:24 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1rWbNC-002cCt-W7; Sun, 04 Feb 2024 12:13:23 +0000
In-Reply-To: <Zb9/O81fVAZw4ANr@shell.armlinux.org.uk>
References: <Zb9/O81fVAZw4ANr@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	bcm-kernel-feedback-list@broadcom.com,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Byungho An <bh74.an@samsung.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	"David S. Miller" <davem@davemloft.net>,
	Doug Berger <opendmb@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jose Abreu <joabreu@synopsys.com>,
	Justin Chen <justin.chen@broadcom.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	NXP Linux Team <linux-imx@nxp.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Shenwei Wang <shenwei.wang@nxp.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Wei Fang <wei.fang@nxp.com>
Subject: [PATCH net-next v2 5/6] net: bcmasp: remove eee_enabled/eee_active in
 bcmasp_get_eee()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1rWbNC-002cCt-W7@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Sun, 04 Feb 2024 12:13:22 +0000

bcmasp_get_eee() sets edata->eee_active and edata->eee_enabled from
its own copy, and then calls phy_ethtool_get_eee() which in turn will
call genphy_c45_ethtool_get_eee().

genphy_c45_ethtool_get_eee() will overwrite eee_enabled and eee_active
with its own interpretation from the PHYs settings and negotiation
result.

Therefore, setting these members in bcmasp_get_eee() is redundant, and
can be removed. This also makes intf->eee.eee_active unnecessary, so
remove this and use a local variable where appropriate.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/broadcom/asp2/bcmasp_ethtool.c | 4 ----
 drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c    | 5 +++--
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/asp2/bcmasp_ethtool.c b/drivers/net/ethernet/broadcom/asp2/bcmasp_ethtool.c
index 2851bed153e6..484fc2b5626f 100644
--- a/drivers/net/ethernet/broadcom/asp2/bcmasp_ethtool.c
+++ b/drivers/net/ethernet/broadcom/asp2/bcmasp_ethtool.c
@@ -360,7 +360,6 @@ void bcmasp_eee_enable_set(struct bcmasp_intf *intf, bool enable)
 	umac_wl(intf, reg, UMC_EEE_CTRL);
 
 	intf->eee.eee_enabled = enable;
-	intf->eee.eee_active = enable;
 }
 
 static int bcmasp_get_eee(struct net_device *dev, struct ethtool_keee *e)
@@ -371,8 +370,6 @@ static int bcmasp_get_eee(struct net_device *dev, struct ethtool_keee *e)
 	if (!dev->phydev)
 		return -ENODEV;
 
-	e->eee_enabled = p->eee_enabled;
-	e->eee_active = p->eee_active;
 	e->tx_lpi_enabled = p->tx_lpi_enabled;
 	e->tx_lpi_timer = umac_rl(intf, UMC_EEE_LPI_TIMER);
 
@@ -399,7 +396,6 @@ static int bcmasp_set_eee(struct net_device *dev, struct ethtool_keee *e)
 		}
 
 		umac_wl(intf, e->tx_lpi_timer, UMC_EEE_LPI_TIMER);
-		intf->eee.eee_active = ret >= 0;
 		intf->eee.tx_lpi_enabled = e->tx_lpi_enabled;
 		bcmasp_eee_enable_set(intf, true);
 	}
diff --git a/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c b/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
index 53e542881255..3a15f269c7d1 100644
--- a/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
+++ b/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
@@ -607,6 +607,7 @@ static void bcmasp_adj_link(struct net_device *dev)
 	struct phy_device *phydev = dev->phydev;
 	u32 cmd_bits = 0, reg;
 	int changed = 0;
+	bool active;
 
 	if (intf->old_link != phydev->link) {
 		changed = 1;
@@ -658,8 +659,8 @@ static void bcmasp_adj_link(struct net_device *dev)
 		reg |= cmd_bits;
 		umac_wl(intf, reg, UMC_CMD);
 
-		intf->eee.eee_active = phy_init_eee(phydev, 0) >= 0;
-		bcmasp_eee_enable_set(intf, intf->eee.eee_active);
+		active = phy_init_eee(phydev, 0) >= 0;
+		bcmasp_eee_enable_set(intf, active);
 	}
 
 	reg = rgmii_rl(intf, RGMII_OOB_CNTRL);
-- 
2.30.2



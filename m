Return-Path: <netdev+bounces-68381-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED7D4846C33
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 10:37:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D7161C246FF
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 09:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE2567E787;
	Fri,  2 Feb 2024 09:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="MOfTxRYF"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC8D79946
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 09:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706866473; cv=none; b=rru1fuP+ifqVaiYjo15O2qQ4V8RTpgZfNjRw05tzFzG7kpdGEKbJFLD0WzKNHWc1g7Q96yfh6HmfmFf7Rf932Ohdph2YI2xECfwK+on+Sn6qifyIEc2s6mcT69rZYK6oeyqliC3yzQNGz5+xr4UIB5tVnpSOOoPOpPYKri3mJzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706866473; c=relaxed/simple;
	bh=6l//lPVP6+L1nSDqxYzbJV7+b2Nj3c6XsEsnnOVkbHU=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=qr61PSFK+NsnznGU4dlkIwxVkogHv5p5TqURxYmvDlZY0ONCiblJTICPXpRFpxfIArCA2BHRjB1xoD9JvXyCSD3QAM+ZiU4rm5vNj1zVXZGYcTv9td4eSQmJJI2ZI6mfzLuftopXWGdKu6LkYZRWd2DXTii3yQU3XW2CDZ/TwCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=MOfTxRYF; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=vf7BGNl9i42pdxz8Gl6B1J2fWwi9YHL54zIOUUkQn3A=; b=MOfTxRYFoSRiWJObPmMTl7GlQK
	qYxjPpPDJS/Z9J2jScs4o5Z3IHEJuC74nVyreC6jomiZMDGhTF4ZlliEGll/dI3oCB4u5l2wT6AqY
	UwsU/y/Wh0C0I+gevrg5/lmLH0ffrXGHnnDjxgODAegyQUulG7YZi9zEMsWx3VaDzONEXhLs5M0N9
	qrGK37CxUb1hk7bodP4OjJ0CYp2i+NROytIkKAOeQy8jySwdcZVgA3hUJCmmyO92vMWyJ8NR3U7jz
	IoOjzfsXzU8mnzRaa8xW5lSNEA73DqGRPatHBlo+yQlFz/K7fnPE01yxeVcJ7dl5q+Tk8r6rVWNpz
	uFUfArtQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:38142 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1rVpvw-0005jK-1m;
	Fri, 02 Feb 2024 09:34:04 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1rVpvs-002Pe6-1w; Fri, 02 Feb 2024 09:34:00 +0000
In-Reply-To: <Zby24IKSgzpvRDNF@shell.armlinux.org.uk>
References: <Zby24IKSgzpvRDNF@shell.armlinux.org.uk>
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
Subject: [PATCH net-next 4/6] net: bcmgenet: remove eee_enabled/eee_active in
 bcmgenet_get_eee()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1rVpvs-002Pe6-1w@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 02 Feb 2024 09:34:00 +0000

bcmgenet_get_eee() sets edata->eee_active and edata->eee_enabled from
its own copy, and then calls phy_ethtool_get_eee() which in turn will
call genphy_c45_ethtool_get_eee().

genphy_c45_ethtool_get_eee() will overwrite eee_enabled and eee_active
with its own interpretation from the PHYs settings and negotiation
result.

Therefore, setting these members in bcmgenet_get_eee() is redundant,
and can be removed. This also makes priv->eee.eee_active unnecessary,
so remove this and use a local variable where appropriate.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/broadcom/genet/bcmgenet.c | 8 +++-----
 drivers/net/ethernet/broadcom/genet/bcmmii.c   | 5 +++--
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index 051c31fb17c2..7396e2823e32 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -1313,7 +1313,6 @@ void bcmgenet_eee_enable_set(struct net_device *dev, bool enable,
 	}
 
 	priv->eee.eee_enabled = enable;
-	priv->eee.eee_active = enable;
 	priv->eee.tx_lpi_enabled = tx_lpi_enabled;
 }
 
@@ -1328,8 +1327,6 @@ static int bcmgenet_get_eee(struct net_device *dev, struct ethtool_keee *e)
 	if (!dev->phydev)
 		return -ENODEV;
 
-	e->eee_enabled = p->eee_enabled;
-	e->eee_active = p->eee_active;
 	e->tx_lpi_enabled = p->tx_lpi_enabled;
 	e->tx_lpi_timer = bcmgenet_umac_readl(priv, UMAC_EEE_LPI_TIMER);
 
@@ -1340,6 +1337,7 @@ static int bcmgenet_set_eee(struct net_device *dev, struct ethtool_keee *e)
 {
 	struct bcmgenet_priv *priv = netdev_priv(dev);
 	struct ethtool_keee *p = &priv->eee;
+	bool active;
 
 	if (GENET_IS_V1(priv))
 		return -EOPNOTSUPP;
@@ -1352,9 +1350,9 @@ static int bcmgenet_set_eee(struct net_device *dev, struct ethtool_keee *e)
 	if (!p->eee_enabled) {
 		bcmgenet_eee_enable_set(dev, false, false);
 	} else {
-		p->eee_active = phy_init_eee(dev->phydev, false) >= 0;
+		active = phy_init_eee(dev->phydev, false) >= 0;
 		bcmgenet_umac_writel(priv, e->tx_lpi_timer, UMAC_EEE_LPI_TIMER);
-		bcmgenet_eee_enable_set(dev, p->eee_active, e->tx_lpi_enabled);
+		bcmgenet_eee_enable_set(dev, active, e->tx_lpi_enabled);
 	}
 
 	return phy_ethtool_set_eee(dev->phydev, e);
diff --git a/drivers/net/ethernet/broadcom/genet/bcmmii.c b/drivers/net/ethernet/broadcom/genet/bcmmii.c
index 97ea76d443ab..cbbe004621bc 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmmii.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmmii.c
@@ -30,6 +30,7 @@ static void bcmgenet_mac_config(struct net_device *dev)
 	struct bcmgenet_priv *priv = netdev_priv(dev);
 	struct phy_device *phydev = dev->phydev;
 	u32 reg, cmd_bits = 0;
+	bool active;
 
 	/* speed */
 	if (phydev->speed == SPEED_1000)
@@ -88,9 +89,9 @@ static void bcmgenet_mac_config(struct net_device *dev)
 	}
 	bcmgenet_umac_writel(priv, reg, UMAC_CMD);
 
-	priv->eee.eee_active = phy_init_eee(phydev, 0) >= 0;
+	active = phy_init_eee(phydev, 0) >= 0;
 	bcmgenet_eee_enable_set(dev,
-				priv->eee.eee_enabled && priv->eee.eee_active,
+				priv->eee.eee_enabled && active,
 				priv->eee.tx_lpi_enabled);
 }
 
-- 
2.30.2



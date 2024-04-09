Return-Path: <netdev+bounces-86287-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF5989E509
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 23:37:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC8DC1F226EA
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 21:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE44F158A0E;
	Tue,  9 Apr 2024 21:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="RHrFPNjp"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FADF12F381
	for <netdev@vger.kernel.org>; Tue,  9 Apr 2024 21:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712698663; cv=none; b=CFT6/46M3SPrD26tOUWdHffVfpXxqYbWnecBcvrkhBUEhLkS0qG8sfZEqOPRp8CuesgBuMM3bcJLq4zBsdguuz0LvhSrft4h8apDdFTyp7agsPdwQTXrhDZDQAolnUKTmU191uFxKALpt+aOr8BIvUKiSTZdtrUkRXBP/AXSEfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712698663; c=relaxed/simple;
	bh=Orgu8QO0VnmqpcqaRkC2dNMOTeVTWpuucPbCTVtKMOc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Has4SgjSCye3zk3s6w762kBOzAPWEusL2PpA5fOEn63Slf3P1KzYmCTM/CqwhiaVRoDgeMlc04rGre6ELDx9NKkskmZmCWYhFF3qxqMUUHZ7PvFoFZoMg04fPirI4Rx9z4YzQl0/9kCD9t2Hlxj/wan7CMVglxTmkIWlCQXZdss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=RHrFPNjp; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Xqeo3KBdlAHdjnhrSgO8gF9Rw6RVwOLt8YrNkgUgNz4=; b=RHrFPNjp59ap0DEFa237cZxfCL
	anKZ5YmqAhjMa2YN8ePGmOYLgiZHLAL4fDLH5sMm+yASkCr+22Dxuv0xRUT23bm72tkhc4IXbJRog
	jA+aa5qJ4kxBj/AKCkyYFQXeLtBZnTEz9Ohn3UlO8nzvFQ1tQchMxdnzEYXoenU/D9zg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ruJ9T-00Cbsx-6f; Tue, 09 Apr 2024 23:37:11 +0200
Date: Tue, 9 Apr 2024 23:37:11 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Doug Berger <opendmb@gmail.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: genet: Fixup EEE
Message-ID: <67c0777f-f66e-4293-af8b-08e0c4ab0acc@lunn.ch>
References: <20240408-stmmac-eee-v1-1-3d65d671c06b@lunn.ch>
 <4826747e-0dd5-4ab9-af02-9d17a1ab7358@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4826747e-0dd5-4ab9-af02-9d17a1ab7358@broadcom.com>

On Tue, Apr 09, 2024 at 01:41:43PM -0700, Florian Fainelli wrote:
> On 4/8/24 17:54, Andrew Lunn wrote:
> > The enabling/disabling of EEE in the MAC should happen as a result of
> > auto negotiation. So move the enable/disable into bcmgenet_mii_setup()
> > which gets called by phylib when there is a change in link status.
> > 
> > bcmgenet_set_eee() now just writes the LPI timer value to the
> > hardware.  Everything else is passed to phylib, so it can correctly
> > setup the PHY.
> > 
> > bcmgenet_get_eee() relies on phylib doing most of the work, the MAC
> > driver just adds the LPI timer value from hardware.
> > 
> > Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> > ---
> >   drivers/net/ethernet/broadcom/genet/bcmgenet.c | 26 ++++++--------------------
> >   drivers/net/ethernet/broadcom/genet/bcmgenet.h |  6 +-----
> >   drivers/net/ethernet/broadcom/genet/bcmmii.c   |  7 +------
> >   3 files changed, 8 insertions(+), 31 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> > index b1f84b37032a..c090b519255a 100644
> > --- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> > +++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> > @@ -1272,13 +1272,14 @@ static void bcmgenet_get_ethtool_stats(struct net_device *dev,
> >   	}
> >   }
> > -void bcmgenet_eee_enable_set(struct net_device *dev, bool enable,
> > -			     bool tx_lpi_enabled)
> > +void bcmgenet_eee_enable_set(struct net_device *dev, bool enable)
> >   {
> >   	struct bcmgenet_priv *priv = netdev_priv(dev);
> > -	u32 off = priv->hw_params->tbuf_offset + TBUF_ENERGY_CTRL;
> > +	u32 off;
> >   	u32 reg;
> > +	off = priv->hw_params->tbuf_offset + TBUF_ENERGY_CTRL;
> > +
> >   	if (enable && !priv->clk_eee_enabled) {
> >   		clk_prepare_enable(priv->clk_eee);
> >   		priv->clk_eee_enabled = true;
> > @@ -1293,7 +1294,7 @@ void bcmgenet_eee_enable_set(struct net_device *dev, bool enable,
> >   	/* Enable EEE and switch to a 27Mhz clock automatically */
> >   	reg = bcmgenet_readl(priv->base + off);
> > -	if (tx_lpi_enabled)
> > +	if (enable)
> >   		reg |= TBUF_EEE_EN | TBUF_PM_EN;
> >   	else
> >   		reg &= ~(TBUF_EEE_EN | TBUF_PM_EN);
> > @@ -1311,15 +1312,11 @@ void bcmgenet_eee_enable_set(struct net_device *dev, bool enable,
> >   		clk_disable_unprepare(priv->clk_eee);
> >   		priv->clk_eee_enabled = false;
> >   	}
> > -
> > -	priv->eee.eee_enabled = enable;
> > -	priv->eee.tx_lpi_enabled = tx_lpi_enabled;
> >   }
> >   static int bcmgenet_get_eee(struct net_device *dev, struct ethtool_keee *e)
> >   {
> >   	struct bcmgenet_priv *priv = netdev_priv(dev);
> > -	struct ethtool_keee *p = &priv->eee;
> >   	if (GENET_IS_V1(priv))
> >   		return -EOPNOTSUPP;
> > @@ -1327,7 +1324,6 @@ static int bcmgenet_get_eee(struct net_device *dev, struct ethtool_keee *e)
> >   	if (!dev->phydev)
> >   		return -ENODEV;
> > -	e->tx_lpi_enabled = p->tx_lpi_enabled;
> >   	e->tx_lpi_timer = bcmgenet_umac_readl(priv, UMAC_EEE_LPI_TIMER);
> >   	return phy_ethtool_get_eee(dev->phydev, e);
> > @@ -1336,8 +1332,6 @@ static int bcmgenet_get_eee(struct net_device *dev, struct ethtool_keee *e)
> >   static int bcmgenet_set_eee(struct net_device *dev, struct ethtool_keee *e)
> >   {
> >   	struct bcmgenet_priv *priv = netdev_priv(dev);
> > -	struct ethtool_keee *p = &priv->eee;
> > -	bool active;
> >   	if (GENET_IS_V1(priv))
> >   		return -EOPNOTSUPP;
> > @@ -1345,15 +1339,7 @@ static int bcmgenet_set_eee(struct net_device *dev, struct ethtool_keee *e)
> >   	if (!dev->phydev)
> >   		return -ENODEV;
> > -	p->eee_enabled = e->eee_enabled;
> > -
> > -	if (!p->eee_enabled) {
> > -		bcmgenet_eee_enable_set(dev, false, false);
> > -	} else {
> > -		active = phy_init_eee(dev->phydev, false) >= 0;
> > -		bcmgenet_umac_writel(priv, e->tx_lpi_timer, UMAC_EEE_LPI_TIMER);
> > -		bcmgenet_eee_enable_set(dev, active, e->tx_lpi_enabled);
> > -	}
> > +	bcmgenet_umac_writel(priv, e->tx_lpi_timer, UMAC_EEE_LPI_TIMER);
> >   	return phy_ethtool_set_eee(dev->phydev, e);
> >   }
> > diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.h b/drivers/net/ethernet/broadcom/genet/bcmgenet.h
> > index 7523b60b3c1c..bb82ecb2e220 100644
> > --- a/drivers/net/ethernet/broadcom/genet/bcmgenet.h
> > +++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.h
> > @@ -644,8 +644,6 @@ struct bcmgenet_priv {
> >   	bool wol_active;
> >   	struct bcmgenet_mib_counters mib;
> > -
> > -	struct ethtool_keee eee;
> >   };
> >   #define GENET_IO_MACRO(name, offset)					\
> > @@ -703,7 +701,5 @@ int bcmgenet_wol_power_down_cfg(struct bcmgenet_priv *priv,
> >   void bcmgenet_wol_power_up_cfg(struct bcmgenet_priv *priv,
> >   			       enum bcmgenet_power_mode mode);
> > -void bcmgenet_eee_enable_set(struct net_device *dev, bool enable,
> > -			     bool tx_lpi_enabled);
> > -
> > +void bcmgenet_eee_enable_set(struct net_device *dev, bool enable);
> >   #endif /* __BCMGENET_H__ */
> > diff --git a/drivers/net/ethernet/broadcom/genet/bcmmii.c b/drivers/net/ethernet/broadcom/genet/bcmmii.c
> > index 9ada89355747..25eeea4c1965 100644
> > --- a/drivers/net/ethernet/broadcom/genet/bcmmii.c
> > +++ b/drivers/net/ethernet/broadcom/genet/bcmmii.c
> > @@ -30,7 +30,6 @@ static void bcmgenet_mac_config(struct net_device *dev)
> >   	struct bcmgenet_priv *priv = netdev_priv(dev);
> >   	struct phy_device *phydev = dev->phydev;
> >   	u32 reg, cmd_bits = 0;
> > -	bool active;
> >   	/* speed */
> >   	if (phydev->speed == SPEED_1000)
> > @@ -88,11 +87,6 @@ static void bcmgenet_mac_config(struct net_device *dev)
> >   		reg |= CMD_TX_EN | CMD_RX_EN;
> >   	}
> >   	bcmgenet_umac_writel(priv, reg, UMAC_CMD);
> > -
> > -	active = phy_init_eee(phydev, 0) >= 0;
> > -	bcmgenet_eee_enable_set(dev,
> > -				priv->eee.eee_enabled && active,
> > -				priv->eee.tx_lpi_enabled);
> 
> You can keep the call to bcmgenet_eee_enable_set() where it currently is and
> just change the arguments?

Hi Florian

bcmgenet_eee_enable_set() configures the hardware. We should only call
that once auto-neg has completed and the adjust_link callback is
called. Or in the case EEE autoneg is disabled, phylib will
artificially down/up the link in order to call the adjust_link
callback.

bcmgenet_eee_enable_set() is currently called in bcmgenet_set_eee(),
which is the .set_eee ethtool_op. So that is the wrong place to do
this. That is what the last hunk in the patch does, it moves it to
bcmgenet_mii_setup() which is passed to of_phy_connect() as the
callback.

Or am i missing thing?

	Andrew


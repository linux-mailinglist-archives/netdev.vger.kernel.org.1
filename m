Return-Path: <netdev+bounces-165998-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09889A33E37
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 12:37:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB579168DE5
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 11:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B30F2227EB6;
	Thu, 13 Feb 2025 11:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="ciyZL3RD"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2A1227E8D;
	Thu, 13 Feb 2025 11:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739446662; cv=none; b=KTwdHG2ohsomlhunyAirfPpEn3jMGOrSgY0LqRL/whADA794qPtLIAdTMsz+OVv40mCrTgLAlF5Q/rfJA+xO0flEyhxUtjqjlq09pGjkfqWDRmKqtoY33kaT3PdJKq+OTtGzT2uI3gH8F0KPAWb9a4ur9IMow9fx/v/GxPbZ/hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739446662; c=relaxed/simple;
	bh=TPAyIIX/YfbPOxBlRz+HmUEInmJ/lGMaLvI/YohKVw0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=joC8X5OcrBwInwh2lXzxbswAKtW+Ri5UDzAomU+qPSumydqwNq/+551jyFm7PgSkO2W+3BFz/ZKAo/ZLUch/TRQ+IhVjwNUnI6B8REpVm7E7qy6XxgDLpJb30w8xutAbG0SlUlUdraOImfspDbzsiC455/+W7qVrwQq6PLOdurc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=ciyZL3RD; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=272ecwD0qQOvyWC3T+Go9BkCCvBpAAQ1+7vxu5z9xyw=; b=ciyZL3RDpG3knXa8xEsj60OGWO
	vmPEULi5M/IzT2AVQuPWwdP4dWxHaroeM/02ZttcGHJv6Kw8Fxyhq9VgvEkUvf9s3+Cy4dIzN+R4M
	wQpjoalZ97eCdNRmbhQRnBGWUspHE9pDzMYfmjnBl9+vaO23BZprjYDpGYoYOQizWM9H40DHWLJ8g
	wsXbi/w91EOndLeRgU2//n6JsIp6V7dFclLoKaMObplw2LcUcyQqJzFUuOxh3EcJcrUVhP9KGNGtL
	N4uEhoN7v7wnnV8gv0fT1pmArPzDkziH49hPcXKdoDN+ebIG940bHtcDVLRV1YF8PJjXBnd2H82rf
	W+Q9oUGQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:44508)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tiXX0-0000xe-0h;
	Thu, 13 Feb 2025 11:37:22 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tiXWv-00025n-1H;
	Thu, 13 Feb 2025 11:37:17 +0000
Date: Thu, 13 Feb 2025 11:37:17 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Bryan Whitehead <bryan.whitehead@microchip.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Marcin Wojtas <marcin.s.wojtas@gmail.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, UNGLinuxDriver@microchip.com,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH net-next 9/9] net: stmmac: convert to phylink managed EEE
 support
Message-ID: <Z63Zbaf_4Rt57sox@shell.armlinux.org.uk>
References: <Z4gdtOaGsBhQCZXn@shell.armlinux.org.uk>
 <E1tYAEG-0014QH-9O@rmk-PC.armlinux.org.uk>
 <6ab08068-7d70-4616-8e88-b6915cbf7b1d@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ab08068-7d70-4616-8e88-b6915cbf7b1d@nvidia.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Feb 13, 2025 at 11:05:01AM +0000, Jon Hunter wrote:
> Hi Russell,
> 
> On 15/01/2025 20:43, Russell King (Oracle) wrote:
> > Convert stmmac to use phylink managed EEE support rather than delving
> > into phylib:
> > 
> > 1. Move the stmmac_eee_init() calls out of mac_link_down() and
> >     mac_link_up() methods into the new mac_{enable,disable}_lpi()
> >     methods. We leave the calls to stmmac_set_eee_pls() in place as
> >     these change bits which tell the EEE hardware when the link came
> >     up or down, and is used for a separate hardware timer. However,
> >     symmetrically conditionalise this with priv->dma_cap.eee.
> > 
> > 2. Update the current LPI timer each time LPI is enabled - which we
> >     need for software-timed LPI.
> > 
> > 3. With phylink managed EEE, phylink manages the receive clock stop
> >     configuration via phylink_config.eee_rx_clk_stop_enable. Set this
> >     appropriately which makes the call to phy_eee_rx_clock_stop()
> >     redundant.
> > 
> > 4. From what I can work out, all supported interfaces support LPI
> >     signalling on stmmac (there's no restriction implemented.) It
> >     also appears to support LPI at all full duplex speeds at or over
> >     100M. Set these capabilities.
> > 
> > 5. The default timer appears to be derived from a module parameter.
> >     Set this the same, although we keep code that reconfigures the
> >     timer in stmmac_init_phy().
> > 
> > 6. Remove the direct call to phy_support_eee(), which phylink will do
> >     on the drivers behalf if phylink_config.eee_enabled_default is set.
> > 
> > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> > ---
> >   .../net/ethernet/stmicro/stmmac/stmmac_main.c | 57 +++++++++++++++----
> >   1 file changed, 45 insertions(+), 12 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > index acd6994c1764..c5d293be8ab9 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > @@ -988,8 +988,8 @@ static void stmmac_mac_link_down(struct phylink_config *config,
> >   	struct stmmac_priv *priv = netdev_priv(to_net_dev(config->dev));
> >   	stmmac_mac_set(priv, priv->ioaddr, false);
> > -	stmmac_eee_init(priv, false);
> > -	stmmac_set_eee_pls(priv, priv->hw, false);
> > +	if (priv->dma_cap.eee)
> > +		stmmac_set_eee_pls(priv, priv->hw, false);
> >   	if (stmmac_fpe_supported(priv))
> >   		stmmac_fpe_link_state_handle(priv, false);
> > @@ -1096,13 +1096,8 @@ static void stmmac_mac_link_up(struct phylink_config *config,
> >   		writel(ctrl, priv->ioaddr + MAC_CTRL_REG);
> >   	stmmac_mac_set(priv, priv->ioaddr, true);
> > -	if (phy && priv->dma_cap.eee) {
> > -		phy_eee_rx_clock_stop(phy, !(priv->plat->flags &
> > -					     STMMAC_FLAG_RX_CLK_RUNS_IN_LPI));
> > -		priv->tx_lpi_timer = phy->eee_cfg.tx_lpi_timer;
> > -		stmmac_eee_init(priv, phy->enable_tx_lpi);
> > +	if (priv->dma_cap.eee)
> >   		stmmac_set_eee_pls(priv, priv->hw, true);
> > -	}
> >   	if (stmmac_fpe_supported(priv))
> >   		stmmac_fpe_link_state_handle(priv, true);
> > @@ -1111,12 +1106,32 @@ static void stmmac_mac_link_up(struct phylink_config *config,
> >   		stmmac_hwtstamp_correct_latency(priv, priv);
> >   }
> > +static void stmmac_mac_disable_tx_lpi(struct phylink_config *config)
> > +{
> > +	struct stmmac_priv *priv = netdev_priv(to_net_dev(config->dev));
> > +
> > +	stmmac_eee_init(priv, false);
> > +}
> > +
> > +static int stmmac_mac_enable_tx_lpi(struct phylink_config *config, u32 timer,
> > +				    bool tx_clk_stop)
> > +{
> > +	struct stmmac_priv *priv = netdev_priv(to_net_dev(config->dev));
> > +
> > +	priv->tx_lpi_timer = timer;
> > +	stmmac_eee_init(priv, true);
> > +
> > +	return 0;
> > +}
> > +
> >   static const struct phylink_mac_ops stmmac_phylink_mac_ops = {
> >   	.mac_get_caps = stmmac_mac_get_caps,
> >   	.mac_select_pcs = stmmac_mac_select_pcs,
> >   	.mac_config = stmmac_mac_config,
> >   	.mac_link_down = stmmac_mac_link_down,
> >   	.mac_link_up = stmmac_mac_link_up,
> > +	.mac_disable_tx_lpi = stmmac_mac_disable_tx_lpi,
> > +	.mac_enable_tx_lpi = stmmac_mac_enable_tx_lpi,
> >   };
> >   /**
> > @@ -1189,9 +1204,6 @@ static int stmmac_init_phy(struct net_device *dev)
> >   			return -ENODEV;
> >   		}
> > -		if (priv->dma_cap.eee)
> > -			phy_support_eee(phydev);
> > -
> >   		ret = phylink_connect_phy(priv->phylink, phydev);
> >   	} else {
> >   		fwnode_handle_put(phy_fwnode);
> > @@ -1201,7 +1213,12 @@ static int stmmac_init_phy(struct net_device *dev)
> >   	if (ret == 0) {
> >   		struct ethtool_keee eee;
> > -		/* Configure phylib's copy of the LPI timer */
> > +		/* Configure phylib's copy of the LPI timer. Normally,
> > +		 * phylink_config.lpi_timer_default would do this, but there is
> > +		 * a chance that userspace could change the eee_timer setting
> > +		 * via sysfs before the first open. Thus, preserve existing
> > +		 * behaviour.
> > +		 */
> >   		if (!phylink_ethtool_get_eee(priv->phylink, &eee)) {
> >   			eee.tx_lpi_timer = priv->tx_lpi_timer;
> >   			phylink_ethtool_set_eee(priv->phylink, &eee);
> > @@ -1234,6 +1251,9 @@ static int stmmac_phy_setup(struct stmmac_priv *priv)
> >   	/* Stmmac always requires an RX clock for hardware initialization */
> >   	priv->phylink_config.mac_requires_rxc = true;
> > +	if (!(priv->plat->flags & STMMAC_FLAG_RX_CLK_RUNS_IN_LPI))
> > +		priv->phylink_config.eee_rx_clk_stop_enable = true;
> > +
> >   	mdio_bus_data = priv->plat->mdio_bus_data;
> >   	if (mdio_bus_data)
> >   		priv->phylink_config.default_an_inband =
> > @@ -1255,6 +1275,19 @@ static int stmmac_phy_setup(struct stmmac_priv *priv)
> >   				 priv->phylink_config.supported_interfaces,
> >   				 pcs->supported_interfaces);
> > +	if (priv->dma_cap.eee) {
> > +		/* Assume all supported interfaces also support LPI */
> > +		memcpy(priv->phylink_config.lpi_interfaces,
> > +		       priv->phylink_config.supported_interfaces,
> > +		       sizeof(priv->phylink_config.lpi_interfaces));
> > +
> > +		/* All full duplex speeds above 100Mbps are supported */
> > +		priv->phylink_config.lpi_capabilities = ~(MAC_1000FD - 1) |
> > +							MAC_100FD;
> > +		priv->phylink_config.lpi_timer_default = eee_timer * 1000;
> > +		priv->phylink_config.eee_enabled_default = true;
> > +	}
> > +
> >   	fwnode = priv->plat->port_node;
> >   	if (!fwnode)
> >   		fwnode = dev_fwnode(priv->device);
> 
> 
> I have been tracking down a suspend regression on Tegra186 and bisect is
> pointing to this change. If I revert this on top of v6.14-rc2 then
> suspend is working again. This is observed on the Jetson TX2 board
> (specifically tegra186-p2771-0000.dts).

Thanks for the report.

> This device is using NFS for testing. So it appears that for this board
> networking does not restart and the board hangs. Looking at the logs I
> do see this on resume ...
> 
> [   64.129079] dwc-eth-dwmac 2490000.ethernet: Failed to reset the dma
> [   64.133125] dwc-eth-dwmac 2490000.ethernet eth0: stmmac_hw_setup: DMA engine initialization failed
> 
> My first thought was if 'dma_cap.eee' is not supported for this device,
> but from what I can see it is and 'dma_cap.eee' is true. Here are some
> more details on this device regarding the ethernet controller.

Could you see whether disabling EEE through ethtool (maybe first try
turning tx-lpi off before using the "eee off") to see whether that
makes any difference please?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!


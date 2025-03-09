Return-Path: <netdev+bounces-173357-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80FC3A58698
	for <lists+netdev@lfdr.de>; Sun,  9 Mar 2025 18:58:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5D813A8065
	for <lists+netdev@lfdr.de>; Sun,  9 Mar 2025 17:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33AF11F09BC;
	Sun,  9 Mar 2025 17:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="dc5fL2Pa"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7AB1F099B;
	Sun,  9 Mar 2025 17:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741543066; cv=none; b=FP5TSV231hxC73Jz0nPa7AcJgtuRrqqOlVt4gbtJnBEBq1vL35aVPIK+1nDHzgf+zQQwAz5CgHdy4M19Wt6vOSkptdT4VsRCYc8Vn3a0LwdKxR7s0HnFMgoilubajt25GQDemznsIAVZnhBoKEspbTEkziwKQwVG/jWZ3eeAbeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741543066; c=relaxed/simple;
	bh=xsz6OPx6Z9uDP3D+uEqnroPiSIU8yECBlbfjyMtzjAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PDzCM98lFSKJ7KGydMrnY3pXMjpuZoA5y+DTB1QWbVdybG07AzIvt78pQ6n3SWGeLEaVWDnaT7Vt9n0jg57O00j/csPXuSQlrrC8QdnnxM3+fvXURIlWPvAUuwb91pcTLMN1tSx9T/io+YkEHHZc1nXOHI+lsn6+UUHqGpaR2do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=dc5fL2Pa; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=dIhdSeA+sKY04sYaP/yGGu7Uf1h3HX4WesIt7XvRbuE=; b=dc5fL2Pap+D9k82kWKY/cDDfZu
	iYILHTxmGsAQsiVsrzo8CHuB98dMQ38Jm1ctAkrGymRJnBUth5n79xKv46sDqw8cbEjiLTwXHchW2
	8+MNISEP1foTylRjLfCrDZeiIjG/ZIPzFJkD/wxtw3V/Lr+oeVeS5XBmIVe2fNMiL4cS4fS1SeDKq
	d9llRg6SOXq/m0zRSmU0RcSsWHI9Z6K2rlHPWnkyTpQjU6xEtLqzxdKk0SEjeyvZnw+u5B/uOiBSR
	z6QBRB1XDGGTKcMAac9HTmIGLH9JXDB/eNfVW6dn+K4+cR+NmyAd2UeWAvrs9mS79HZaYGj7Vjl2K
	rnIil4Ug==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:42970)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1trKtw-0001ar-2h;
	Sun, 09 Mar 2025 17:57:24 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1trKts-0001dj-36;
	Sun, 09 Mar 2025 17:57:21 +0000
Date: Sun, 9 Mar 2025 17:57:20 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	upstream@airoha.com
Subject: Re: [net-next PATCH v12 12/13] net: dsa: Add Airoha AN8855 5-Port
 Gigabit DSA Switch driver
Message-ID: <Z83WgMeg_IxgbxhO@shell.armlinux.org.uk>
References: <20250309172717.9067-1-ansuelsmth@gmail.com>
 <20250309172717.9067-13-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250309172717.9067-13-ansuelsmth@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sun, Mar 09, 2025 at 06:26:57PM +0100, Christian Marangi wrote:
> +static int an8855_port_enable(struct dsa_switch *ds, int port,
> +			      struct phy_device *phy)
> +{
> +	struct an8855_priv *priv = ds->priv;
> +
> +	return regmap_set_bits(priv->regmap, AN8855_PMCR_P(port),
> +			       AN8855_PMCR_TX_EN | AN8855_PMCR_RX_EN);

Shouldn't you wait for phylink to call your mac_link_up() method?

> +}
> +
> +static void an8855_port_disable(struct dsa_switch *ds, int port)
> +{
> +	struct an8855_priv *priv = ds->priv;
> +	int ret;
> +
> +	ret = regmap_clear_bits(priv->regmap, AN8855_PMCR_P(port),
> +				AN8855_PMCR_TX_EN | AN8855_PMCR_RX_EN);
> +	if (ret)
> +		dev_err(priv->ds->dev, "failed to disable port: %d\n", ret);

Doesn't the link get set down before this is called? IOW, doesn't
phylink call your mac_link_down() method first?

...

> +static void an8855_phylink_mac_link_up(struct phylink_config *config,
> +				       struct phy_device *phydev, unsigned int mode,
> +				       phy_interface_t interface, int speed,
> +				       int duplex, bool tx_pause, bool rx_pause)
> +{
> +	struct dsa_port *dp = dsa_phylink_to_port(config);
> +	struct an8855_priv *priv = dp->ds->priv;
> +	int port = dp->index;
> +	u32 reg;
> +
> +	reg = regmap_read(priv->regmap, AN8855_PMCR_P(port), &reg);
> +	if (phylink_autoneg_inband(mode)) {
> +		reg &= ~AN8855_PMCR_FORCE_MODE;
> +	} else {
> +		reg |= AN8855_PMCR_FORCE_MODE | AN8855_PMCR_FORCE_LNK;
> +
> +		reg &= ~AN8855_PMCR_FORCE_SPEED;
> +		switch (speed) {
> +		case SPEED_10:
> +			reg |= AN8855_PMCR_FORCE_SPEED_10;
> +			break;
> +		case SPEED_100:
> +			reg |= AN8855_PMCR_FORCE_SPEED_100;
> +			break;
> +		case SPEED_1000:
> +			reg |= AN8855_PMCR_FORCE_SPEED_1000;
> +			break;
> +		case SPEED_2500:
> +			reg |= AN8855_PMCR_FORCE_SPEED_2500;
> +			break;
> +		case SPEED_5000:
> +			dev_err(priv->ds->dev, "Missing support for 5G speed. Aborting...\n");
> +			return;
> +		}
> +
> +		reg &= ~AN8855_PMCR_FORCE_FDX;
> +		if (duplex == DUPLEX_FULL)
> +			reg |= AN8855_PMCR_FORCE_FDX;
> +
> +		reg &= ~AN8855_PMCR_RX_FC_EN;
> +		if (rx_pause || dsa_port_is_cpu(dp))
> +			reg |= AN8855_PMCR_RX_FC_EN;
> +
> +		reg &= ~AN8855_PMCR_TX_FC_EN;
> +		if (rx_pause || dsa_port_is_cpu(dp))
> +			reg |= AN8855_PMCR_TX_FC_EN;
> +
> +		/* Disable any EEE options */
> +		reg &= ~(AN8855_PMCR_FORCE_EEE5G | AN8855_PMCR_FORCE_EEE2P5G |
> +			 AN8855_PMCR_FORCE_EEE1G | AN8855_PMCR_FORCE_EEE100);

Why? Maybe consider implementing the phylink tx_lpi functions for EEE
support.

> +	}
> +
> +	reg |= AN8855_PMCR_TX_EN | AN8855_PMCR_RX_EN;
> +
> +	regmap_write(priv->regmap, AN8855_PMCR_P(port), reg);
> +}
> +
> +static unsigned int an8855_pcs_inband_caps(struct phylink_pcs *pcs,
> +					   phy_interface_t interface)
> +{
> +	/* SGMII can be configured to use inband with AN result */
> +	if (interface == PHY_INTERFACE_MODE_SGMII)
> +		return LINK_INBAND_DISABLE | LINK_INBAND_ENABLE;
> +
> +	/* inband is not supported in 2500-baseX and must be disabled */
> +	return  LINK_INBAND_DISABLE;

Spurious double space.

> +}
> +
> +static void an8855_pcs_get_state(struct phylink_pcs *pcs, unsigned int neg_mode,
> +				 struct phylink_link_state *state)
> +{
> +	struct an8855_priv *priv = container_of(pcs, struct an8855_priv, pcs);
> +	u32 val;
> +	int ret;
> +
> +	ret = regmap_read(priv->regmap, AN8855_PMSR_P(AN8855_CPU_PORT), &val);
> +	if (ret < 0) {
> +		state->link = false;
> +		return;
> +	}
> +
> +	state->link = !!(val & AN8855_PMSR_LNK);
> +	state->an_complete = state->link;
> +	state->duplex = (val & AN8855_PMSR_DPX) ? DUPLEX_FULL :
> +						  DUPLEX_HALF;
> +
> +	switch (val & AN8855_PMSR_SPEED) {
> +	case AN8855_PMSR_SPEED_10:
> +		state->speed = SPEED_10;
> +		break;
> +	case AN8855_PMSR_SPEED_100:
> +		state->speed = SPEED_100;
> +		break;
> +	case AN8855_PMSR_SPEED_1000:
> +		state->speed = SPEED_1000;
> +		break;
> +	case AN8855_PMSR_SPEED_2500:
> +		state->speed = SPEED_2500;
> +		break;
> +	case AN8855_PMSR_SPEED_5000:
> +		dev_err(priv->ds->dev, "Missing support for 5G speed. Setting Unknown.\n");
> +		fallthrough;

Which is wrong now, we have SPEED_5000.

> +	default:
> +		state->speed = SPEED_UNKNOWN;
> +		break;
> +	}
> +
> +	if (val & AN8855_PMSR_RX_FC)
> +		state->pause |= MLO_PAUSE_RX;
> +	if (val & AN8855_PMSR_TX_FC)
> +		state->pause |= MLO_PAUSE_TX;
> +}
> +
> +static int an8855_pcs_config(struct phylink_pcs *pcs, unsigned int neg_mode,
> +			     phy_interface_t interface,
> +			     const unsigned long *advertising,
> +			     bool permit_pause_to_mac)
> +{
> +	struct an8855_priv *priv = container_of(pcs, struct an8855_priv, pcs);
> +	u32 val;
> +	int ret;
> +
> +	/*                   !!! WELCOME TO HELL !!!                   */
> +
[... hell ...]
> +	ret = regmap_write(priv->regmap, AN8855_MSG_RX_LIK_STS_2,
> +			   AN8855_RG_RXFC_AN_BYPASS_P3 |
> +			   AN8855_RG_RXFC_AN_BYPASS_P2 |
> +			   AN8855_RG_RXFC_AN_BYPASS_P1 |
> +			   AN8855_RG_TXFC_AN_BYPASS_P3 |
> +			   AN8855_RG_TXFC_AN_BYPASS_P2 |
> +			   AN8855_RG_TXFC_AN_BYPASS_P1 |
> +			   AN8855_RG_DPX_AN_BYPASS_P3 |
> +			   AN8855_RG_DPX_AN_BYPASS_P2 |
> +			   AN8855_RG_DPX_AN_BYPASS_P1 |
> +			   AN8855_RG_DPX_AN_BYPASS_P0);
> +	if (ret)
> +		return ret;
> +
> +	return 0;

Is this disruptive to the link if the link is up, and this is called
(e.g. to change the advertisement rather than switch interface mode).
If so, please do something about that - e.g. only doing the bulk of
the configuration if the interface mode has changed.

I guess, however, that as you're only using SGMII with in-band, it
probably doesn't make much difference, but having similar behaviour
in the various drivers helps with ongoing maintenance.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!


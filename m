Return-Path: <netdev+bounces-137512-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDA299A6BB3
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 16:10:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEF221C22E4C
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 14:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48C4A1F8F15;
	Mon, 21 Oct 2024 14:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="NPlhIEcG"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9FD21D1736;
	Mon, 21 Oct 2024 14:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729519728; cv=none; b=b48A8zvYE7q1NGSBRf0qVp9zjFnz4BTa1+9XCpKAmZvr7ZFVKXVu56/RHRlx3H/IcOXSKfzpTPhzb5rK75U9za3QyptEwiay8gA6NuQ3DBCpB9ULng0rhbcl8235JUe9nzf3VG80DM0lAfo2IReiScuu+TN9L1GFbl/tEUwHe58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729519728; c=relaxed/simple;
	bh=2+f81HS1CB52W2ClBnbIOBSsjPq66icCvNTAWwYMIBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TzXmYKQL/bHAAhcOWO3VmsQoANyM+6+0lrcUAO4R6J09Fzqpj8z+I5eF09+Ku1GbZ2jXbn8JohZeWtctETCcRw1Gu5I9+ZHmO8yTIwy9hg+XdJaWkFry0FjUYg0NWt5x2/HkdVbeEYeZNT7hsP9hYhrZhBGysIeQH2oOu7SetD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=NPlhIEcG; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=y7YDMtix7G7QEQXn/vP+9itDBlDIS+ULl39LBJYMnm4=; b=NPlhIEcGaaoLQ9Edrw98Y9glFe
	PiGc10RESME9CvOu0J6RvTf5y152wIV65gNtVnHNCU3iRHC+F4U+WrubHe89hLwCy7JUV3wS2g1Ez
	lXuT4EpatFI+RILrMMSSl/wigvsS/MLuPe2qBUoSb5NvcFPOQqtRt5M4EIXLvugPeQY509JRNyles
	jpW/GQL0gxVXAIj5WwV02EwLKpSK0/r8PEUV64vEKgZvYtqCE0ixGeiE/t3TI0cStDhFBLK755Bny
	8e+QKYOnzKaKdcs9q4TtGveSppl1f1J390hMZppg7sDzT2HpCoi1hjVq/5sjfG/JcY93OyanKSVe+
	cyW3nC7Q==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:37488)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1t2t59-0003Ua-1w;
	Mon, 21 Oct 2024 15:08:28 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1t2t56-0001mA-2U;
	Mon, 21 Oct 2024 15:08:24 +0100
Date: Mon, 21 Oct 2024 15:08:24 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next RFC PATCH 3/4] net: dsa: Add Airoha AN8855 5-Port
 Gigabit DSA Switch driver
Message-ID: <ZxZgWGlrWP2vnUjV@shell.armlinux.org.uk>
References: <20241021130209.15660-1-ansuelsmth@gmail.com>
 <20241021130209.15660-4-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241021130209.15660-4-ansuelsmth@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Oct 21, 2024 at 03:01:58PM +0200, Christian Marangi wrote:
> +static int an8855_mii_read32(struct mii_bus *bus, u8 phy_id, u32 reg, u32 *val)
> +{
> +	u16 lo, hi;
> +	int ret;
> +
> +	ret = bus->write(bus, phy_id, 0x1f, 0x4);
> +	ret = bus->write(bus, phy_id, 0x10, 0);
> +
> +	ret = bus->write(bus, phy_id, 0x15, ((reg >> 16) & 0xFFFF));

These assignments above are useless on their own. What if one of them
fails?

Please also consider __mdiobus_write() and __mdiobus_read() which will
check that the bus lock is held, and also give the ability to trace
the bus activity.

> +	ret = bus->write(bus, phy_id, 0x16, (reg & 0xFFFF));
> +	if (ret < 0) {
> +		dev_err_ratelimited(&bus->dev,
> +				    "failed to read an8855 register\n");
> +		return ret;
> +	}
> +
> +	lo = bus->read(bus, phy_id, 0x18);
> +	hi = bus->read(bus, phy_id, 0x17);

What if one of these fails, and the negative value gets clamped to a
u16?

> +
> +	ret = bus->write(bus, phy_id, 0x1f, 0);
> +	if (ret < 0) {
> +		dev_err_ratelimited(&bus->dev,
> +				    "failed to read an8855 register\n");
> +		return ret;
> +	}
> +
> +	*val = (hi << 16) | (lo & 0xffff);
> +
> +	return 0;
> +}
> +
> +static int an8855_regmap_read(void *ctx, uint32_t reg, uint32_t *val)
> +{
> +	struct an8855_priv *priv = ctx;
> +	struct mii_bus *bus = priv->bus;
> +	int ret;
> +
> +	scoped_guard(mdio_mutex_nested, &bus->mdio_lock)
> +		ret = an8855_mii_read32(bus, priv->phy_base,
> +					reg, val);

I'm really not a fan of these non-C like code structures that make the
code harder to review, and can add (and already have resulted in) bugs,
but everyone to their own. Al Viro found a whole new class of bug caused
by these magic things. I'd much prefer explicit C code that can be read
and reviewed over "let the compiler do magic" stuff.

> +
> +	return ret < 0 ? ret : 0;
> +}
> +
> +static int an8855_mii_write32(struct mii_bus *bus, u8 phy_id, u32 reg, u32 val)
> +{
> +	int ret;
> +
> +	ret = bus->write(bus, phy_id, 0x1f, 0x4);
> +	ret = bus->write(bus, phy_id, 0x10, 0);
> +
> +	ret = bus->write(bus, phy_id, 0x11, ((reg >> 16) & 0xFFFF));
> +	ret = bus->write(bus, phy_id, 0x12, (reg & 0xFFFF));
> +
> +	ret = bus->write(bus, phy_id, 0x13, ((val >> 16) & 0xFFFF));
> +	ret = bus->write(bus, phy_id, 0x14, (val & 0xFFFF));

Same as above.

> +
> +	ret = bus->write(bus, phy_id, 0x1f, 0);
> +	if (ret < 0)
> +		dev_err_ratelimited(&bus->dev,
> +				    "failed to write an8855 register\n");
> +
> +	return 0;
> +}

...

> +static int an8855_set_mac_eee(struct dsa_switch *ds, int port,
> +			      struct ethtool_keee *eee)
> +{
> +	struct an8855_priv *priv = ds->priv;
> +	u32 reg;
> +	int ret;
> +
> +	if (eee->eee_enabled) {
> +		ret = regmap_read(priv->regmap, AN8855_PMCR_P(port), &reg);
> +		if (ret)
> +			return ret;
> +		if (reg & AN8855_PMCR_FORCE_MODE) {
> +			switch (reg & AN8855_PMCR_FORCE_SPEED) {
> +			case AN8855_PMCR_FORCE_SPEED_1000:
> +				reg |= AN8855_PMCR_FORCE_EEE1G;
> +				break;
> +			case AN8855_PMCR_FORCE_SPEED_100:
> +				reg |= AN8855_PMCR_FORCE_EEE100;
> +				break;
> +			default:
> +				break;
> +			}
> +			ret = regmap_write(priv->regmap, AN8855_PMCR_P(port), reg);
> +			if (ret)
> +				return ret;

What logic are you trying to implement here? It looks like you're
forcing EEE to be enabled here if AN8855_PMCR_FORCE_MODE was set, which,
reading the code in link_{up,down} it always will be when the link
happens to be down when the user configures EEE. This makes no sense.

EEE is supposed to be enabled as a result of the PHY's negotiation with
the link partner. There shouldn't be any forcing.

> +		}
> +		if (eee->tx_lpi_enabled) {
> +			ret = regmap_set_bits(priv->regmap, AN8855_PMEEECR_P(port),
> +					      AN8855_LPI_MODE_EN);
> +			if (ret)
> +				return ret;
> +		} else {
> +			ret = regmap_clear_bits(priv->regmap, AN8855_PMEEECR_P(port),
> +						AN8855_LPI_MODE_EN);
> +			if (ret)
> +				return ret;
> +		}

Maybe:

		ret = regmap_update_bits(priv->regmap, AN8855_PMEEECR_P(port),
					 AN8855_LPI_MODE_EN,
					 eee->tx_lpi_enabled ?
					   AN8855_LPI_MODE_EN : 0);
		if (ret)
			return ret;

> +	} else {
> +		ret = regmap_clear_bits(priv->regmap, AN8855_PMCR_P(port),
> +					AN8855_PMCR_FORCE_EEE1G |
> +					AN8855_PMCR_FORCE_EEE100);
> +		if (ret)
> +			return ret;
> +
> +		ret = regmap_clear_bits(priv->regmap, AN8855_PMEEECR_P(port),
> +					AN8855_LPI_MODE_EN);
> +		if (ret)
> +			return ret;

This probably needs to interact with the link up/down state.

Really, I need to find the time to sort out adding EEE stuff to phylink
that is keyed from phylib's implementation, but not at the moment.

> +	}
> +
> +	return 0;
> +}
> +
> +static int an8855_get_mac_eee(struct dsa_switch *ds, int port,
> +			      struct ethtool_keee *eee)
> +{
> +	struct an8855_priv *priv = ds->priv;
> +	u32 reg;
> +	int ret;
> +
> +	ret = regmap_read(priv->regmap, AN8855_PMEEECR_P(port), &reg);
> +	if (ret)
> +		return ret;
> +	eee->tx_lpi_enabled = reg & AN8855_LPI_MODE_EN;

This is fine, the MAC is responsible for LPI transmission.

> +
> +	ret = regmap_read(priv->regmap, AN8855_CKGCR, &reg);
> +	if (ret)
> +		return ret;
> +	/* Global LPI TXIDLE Threshold, default 60ms (unit 2us) */
> +	eee->tx_lpi_timer = FIELD_GET(AN8855_LPI_TXIDLE_THD_MASK, reg) / 500;

Also fine.

> +
> +	ret = regmap_read(priv->regmap, AN8855_PMSR_P(port), &reg);
> +	if (ret)
> +		return ret;
> +	eee->eee_active = reg & (AN8855_PMSR_EEE1G | AN8855_PMSR_EEE100M);

This isn't. You're overwriting the value set by
genphy_c45_ethtool_get_eee(), which has already determined whether
EEE is active from the PHY's negotiation state, and this is what
eee_active is supposed to indicate.

> +
> +	return 0;
> +}
> +
> +static u32 en8855_get_phy_flags(struct dsa_switch *ds, int port)
> +{
> +	struct an8855_priv *priv = ds->priv;
> +	u8 calibration_data[4] = { };
> +	u8 shift_sel;
> +	u32 val;
> +	int ret;
> +	int i;
> +
> +	/* PHY doesn't need calibration */
> +	if (!priv->phy_require_calib)
> +		return 0;
> +
> +	/* Read Calibration value */
> +	for (i = 0; i < sizeof(u32); i++) {
> +		ret = regmap_read(priv->regmap, AN8855_EFUSE_DATA0 +
> +				  ((3 + i + (4 * port)) * 4), &val);
> +		if (ret)
> +			return 0;
> +
> +		shift_sel = FIELD_GET(AN8855_EFUSE_R50O, val);
> +		calibration_data[i] = en8855_get_r50ohm_val(shift_sel);
> +	}
> +
> +	memcpy(&val, calibration_data, sizeof(u32));
> +	return val;

Ewwwwwww.

So you're reading from fuses, and then passing them as phy flags.
PHY flags are no longer 100% available for whatever you want to use
them for - some have standard meanings:

 *      - Bits [15:0] are free to use by the PHY driver to communicate
 *        driver specific behavior.
 *      - Bits [23:16] are currently reserved for future use.
 *      - Bits [31:24] are reserved for defining generic
 *        PHY driver behavior.

For example, PHY_F_NO_IRQ and PHY_F_RXC_ALWAYS_ON are already allocated
in the top 8 bits.

> +static void
> +an8855_phylink_mac_config(struct phylink_config *config, unsigned int mode,
> +			  const struct phylink_link_state *state)
> +{
> +	struct dsa_port *dp = dsa_phylink_to_port(config);
> +	struct dsa_switch *ds = dp->ds;
> +	struct an8855_priv *priv;
> +	int port = dp->index;
> +
> +	priv = ds->priv;
> +
> +	switch (port) {
> +	case 0:
> +	case 1:
> +	case 2:
> +	case 3:
> +	case 4:
> +		return;
> +	case 5:
> +		break;
> +	default:
> +		dev_err(ds->dev, "unsupported port: %d", port);
> +		return;
> +	}
> +
> +	if (state->interface == PHY_INTERFACE_MODE_2500BASEX &&
> +	    phylink_autoneg_inband(mode))
> +		dev_err(ds->dev, "in-band negotiation unsupported");

Please check this in the PCS code.

> +
> +	regmap_update_bits(priv->regmap, AN8855_PMCR_P(port),
> +			   AN8855_PMCR_IFG_XMIT | AN8855_PMCR_MAC_MODE |
> +			   AN8855_PMCR_BACKOFF_EN | AN8855_PMCR_BACKPR_EN,
> +			   FIELD_PREP(AN8855_PMCR_IFG_XMIT, 0x1) |
> +			   AN8855_PMCR_MAC_MODE | AN8855_PMCR_BACKOFF_EN |
> +			   AN8855_PMCR_BACKPR_EN);
> +}
> +
> +static void an8855_phylink_get_caps(struct dsa_switch *ds, int port,
> +				    struct phylink_config *config)
> +{
> +	switch (port) {
> +	case 0:
> +	case 1:
> +	case 2:
> +	case 3:
> +	case 4:
> +		__set_bit(PHY_INTERFACE_MODE_GMII,
> +			  config->supported_interfaces);
> +		__set_bit(PHY_INTERFACE_MODE_INTERNAL,
> +			  config->supported_interfaces);
> +		break;
> +	case 5:
> +		phy_interface_set_rgmii(config->supported_interfaces);
> +		__set_bit(PHY_INTERFACE_MODE_SGMII,
> +			  config->supported_interfaces);
> +		__set_bit(PHY_INTERFACE_MODE_2500BASEX,
> +			  config->supported_interfaces);
> +		break;
> +	}
> +
> +	config->mac_capabilities = MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
> +				   MAC_10 | MAC_100 | MAC_1000FD;
> +}
> +
> +static void
> +an8855_phylink_mac_link_down(struct phylink_config *config, unsigned int mode,
> +			     phy_interface_t interface)
> +{
> +	struct dsa_port *dp = dsa_phylink_to_port(config);
> +	struct an8855_priv *priv = dp->ds->priv;
> +
> +	/* Disable TX/RX, force link down */
> +	regmap_update_bits(priv->regmap, AN8855_PMCR_P(dp->index),
> +			   AN8855_PMCR_TX_EN | AN8855_PMCR_RX_EN |
> +			   AN8855_PMCR_FORCE_MODE | AN8855_PMCR_FORCE_LNK,
> +			   AN8855_PMCR_FORCE_MODE);

Does forcing the link down prevent the AN8855_PMSR_LNK bit being set?
If not, please document that here because the current code goes against
what's documented in phylink:
 
 * If @mode is not an in-band negotiation mode (as defined by
   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 * phylink_autoneg_inband()), force the link down and disable any
 * Energy Efficient Ethernet MAC configuration. ...

> +}
> +
> +static void
> +an8855_phylink_mac_link_up(struct phylink_config *config,
> +			   struct phy_device *phydev, unsigned int mode,
> +			   phy_interface_t interface, int speed, int duplex,
> +			   bool tx_pause, bool rx_pause)
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
> +			reg |= AN8855_PMCR_FORCE_SPEED_5000;
> +			break;
> +		}
> +
> +		reg &= AN8855_PMCR_FORCE_FDX;
> +		if (duplex == DUPLEX_FULL)
> +			reg |= AN8855_PMCR_FORCE_FDX;
> +
> +		reg &= AN8855_PMCR_RX_FC_EN;
> +		if (rx_pause || dsa_port_is_cpu(dp))
> +			reg |= AN8855_PMCR_RX_FC_EN;
> +
> +		reg &= AN8855_PMCR_TX_FC_EN;
> +		if (rx_pause || dsa_port_is_cpu(dp))
> +			reg |= AN8855_PMCR_TX_FC_EN;
> +
> +		/* Disable any EEE options */
> +		reg &= ~(AN8855_PMCR_FORCE_EEE5G | AN8855_PMCR_FORCE_EEE2P5G |
> +			 AN8855_PMCR_FORCE_EEE1G | AN8855_PMCR_FORCE_EEE100);
> +	}
> +
> +	reg |= AN8855_PMCR_TX_EN | AN8855_PMCR_RX_EN;
> +
> +	regmap_write(priv->regmap, AN8855_PMCR_P(port), reg);
> +}
> +
> +static void an8855_pcs_get_state(struct phylink_pcs *pcs,
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
> +		state->speed = SPEED_5000;
> +		break;
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
> +	switch (interface) {
> +	case PHY_INTERFACE_MODE_RGMII:
> +		return 0;
> +	case PHY_INTERFACE_MODE_SGMII:
> +		break;
> +	case PHY_INTERFACE_MODE_2500BASEX:
> +		if (neg_mode == PHYLINK_PCS_NEG_INBAND_ENABLED)
> +			return -EINVAL;
> +
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	/*                   !!! WELCOME TO HELL !!!                   */
> +
> +	/* TX FIR - improve TX EYE */
> +	ret = regmap_update_bits(priv->regmap, AN8855_INTF_CTRL_10, GENMASK(21, 16),
> +				 FIELD_PREP(GENMASK(21, 16), 0x20));
> +	if (ret)
> +		return ret;
> +	ret = regmap_update_bits(priv->regmap, AN8855_INTF_CTRL_10, GENMASK(28, 24),
> +				 FIELD_PREP(GENMASK(28, 24), 0x4));
> +	if (ret)
> +		return ret;
> +	ret = regmap_set_bits(priv->regmap, AN8855_INTF_CTRL_10, BIT(29));
> +	if (ret)
> +		return ret;
> +
> +	if (interface == PHY_INTERFACE_MODE_2500BASEX)
> +		val = 0x0;
> +	else
> +		val = 0xd;
> +	ret = regmap_update_bits(priv->regmap, AN8855_INTF_CTRL_11, GENMASK(5, 0),
> +				 FIELD_PREP(GENMASK(5, 0), val));
> +	if (ret)
> +		return ret;
> +	ret = regmap_set_bits(priv->regmap, AN8855_INTF_CTRL_11, BIT(6));
> +	if (ret)
> +		return ret;
> +
> +	/* RX CDR - improve RX Jitter Tolerance */
> +	if (interface == PHY_INTERFACE_MODE_2500BASEX)
> +		val = 0x5;
> +	else
> +		val = 0x6;
> +	ret = regmap_update_bits(priv->regmap, AN8855_RG_QP_CDR_LPF_BOT_LIM, GENMASK(26, 24),
> +				 FIELD_PREP(GENMASK(26, 24), val));
> +	if (ret)
> +		return ret;
> +	ret = regmap_update_bits(priv->regmap, AN8855_RG_QP_CDR_LPF_BOT_LIM, GENMASK(22, 20),
> +				 FIELD_PREP(GENMASK(22, 20), val));
> +	if (ret)
> +		return ret;
> +
> +	/* PLL */
> +	if (interface == PHY_INTERFACE_MODE_2500BASEX)
> +		val = 0x1;
> +	else
> +		val = 0x0;
> +	ret = regmap_update_bits(priv->regmap, AN8855_QP_DIG_MODE_CTRL_1, GENMASK(3, 2),
> +				 FIELD_PREP(GENMASK(3, 2), val));
> +	if (ret)
> +		return ret;
> +
> +	/* PLL - LPF */
> +	ret = regmap_update_bits(priv->regmap, AN8855_PLL_CTRL_2, GENMASK(1, 0),
> +				 FIELD_PREP(GENMASK(1, 0), 0x1));
> +	if (ret)
> +		return ret;
> +	ret = regmap_update_bits(priv->regmap, AN8855_PLL_CTRL_2, GENMASK(4, 2),
> +				 FIELD_PREP(GENMASK(4, 2), 0x5));
> +	if (ret)
> +		return ret;
> +	ret = regmap_clear_bits(priv->regmap, AN8855_PLL_CTRL_2, BIT(6) | BIT(7));
> +	if (ret)
> +		return ret;
> +	ret = regmap_update_bits(priv->regmap, AN8855_PLL_CTRL_2, GENMASK(10, 8),
> +				 FIELD_PREP(GENMASK(10, 8), 0x3));
> +	if (ret)
> +		return ret;
> +	ret = regmap_set_bits(priv->regmap, AN8855_PLL_CTRL_2, BIT(29));
> +	if (ret)
> +		return ret;
> +	ret = regmap_clear_bits(priv->regmap, AN8855_PLL_CTRL_2, BIT(12) | BIT(13));
> +	if (ret)
> +		return ret;
> +
> +	/* PLL - ICO */
> +	ret = regmap_set_bits(priv->regmap, AN8855_PLL_CTRL_4, BIT(2));
> +	if (ret)
> +		return ret;
> +	ret = regmap_clear_bits(priv->regmap, AN8855_PLL_CTRL_2, BIT(14));
> +	if (ret)
> +		return ret;
> +
> +	/* PLL - CHP */
> +	if (interface == PHY_INTERFACE_MODE_2500BASEX)
> +		val = 0x6;
> +	else
> +		val = 0x4;
> +	ret = regmap_update_bits(priv->regmap, AN8855_PLL_CTRL_2, GENMASK(19, 16),
> +				 FIELD_PREP(GENMASK(19, 16), val));
> +	if (ret)
> +		return ret;
> +
> +	/* PLL - PFD */
> +	ret = regmap_update_bits(priv->regmap, AN8855_PLL_CTRL_2, GENMASK(21, 20),
> +				 FIELD_PREP(GENMASK(21, 20), 0x1));
> +	if (ret)
> +		return ret;
> +	ret = regmap_update_bits(priv->regmap, AN8855_PLL_CTRL_2, GENMASK(25, 24),
> +				 FIELD_PREP(GENMASK(25, 24), 0x1));
> +	if (ret)
> +		return ret;
> +	ret = regmap_clear_bits(priv->regmap, AN8855_PLL_CTRL_2, BIT(26));
> +	if (ret)
> +		return ret;
> +
> +	/* PLL - POSTDIV */
> +	ret = regmap_set_bits(priv->regmap, AN8855_PLL_CTRL_2, BIT(22));
> +	if (ret)
> +		return ret;
> +	ret = regmap_clear_bits(priv->regmap, AN8855_PLL_CTRL_2, BIT(27));
> +	if (ret)
> +		return ret;
> +	ret = regmap_clear_bits(priv->regmap, AN8855_PLL_CTRL_2, BIT(28));
> +	if (ret)
> +		return ret;
> +
> +	/* PLL - SDM */
> +	ret = regmap_clear_bits(priv->regmap, AN8855_PLL_CTRL_4, BIT(3) | BIT(4));
> +	if (ret)
> +		return ret;
> +	ret = regmap_clear_bits(priv->regmap, AN8855_PLL_CTRL_2, BIT(30));
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_update_bits(priv->regmap, AN8855_SS_LCPLL_PWCTL_SETTING_2,
> +				 GENMASK(17, 16),
> +				 FIELD_PREP(GENMASK(17, 16), 0x1));
> +	if (ret)
> +		return ret;
> +
> +	if (interface == PHY_INTERFACE_MODE_2500BASEX)
> +		val = 0x7a000000;
> +	else
> +		val = 0x48000000;
> +	ret = regmap_write(priv->regmap, AN8855_SS_LCPLL_TDC_FLT_2, val);
> +	if (ret)
> +		return ret;
> +	ret = regmap_write(priv->regmap, AN8855_SS_LCPLL_TDC_PCW_1, val);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_clear_bits(priv->regmap, AN8855_SS_LCPLL_TDC_FLT_5, BIT(24));
> +	if (ret)
> +		return ret;
> +	ret = regmap_clear_bits(priv->regmap, AN8855_PLL_CK_CTRL_0, BIT(8));
> +	if (ret)
> +		return ret;
> +
> +	/* PLL - SS */
> +	ret = regmap_clear_bits(priv->regmap, AN8855_PLL_CTRL_3, GENMASK(15, 0));
> +	if (ret)
> +		return ret;
> +	ret = regmap_clear_bits(priv->regmap, AN8855_PLL_CTRL_4, GENMASK(1, 0));
> +	if (ret)
> +		return ret;
> +	ret = regmap_clear_bits(priv->regmap, AN8855_PLL_CTRL_3, GENMASK(31, 16));
> +	if (ret)
> +		return ret;
> +
> +	/* PLL - TDC */
> +	ret = regmap_clear_bits(priv->regmap, AN8855_PLL_CK_CTRL_0, BIT(9));
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_set_bits(priv->regmap, AN8855_RG_QP_PLL_SDM_ORD, BIT(3));
> +	if (ret)
> +		return ret;
> +	ret = regmap_set_bits(priv->regmap, AN8855_RG_QP_PLL_SDM_ORD, BIT(4));
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_update_bits(priv->regmap, AN8855_RG_QP_RX_DAC_EN, GENMASK(17, 16),
> +				 FIELD_PREP(GENMASK(17, 16), 0x2));
> +	if (ret)
> +		return ret;
> +
> +	/* TCL Disable (only for Co-SIM) */
> +	ret = regmap_clear_bits(priv->regmap, AN8855_PON_RXFEDIG_CTRL_0, BIT(12));
> +	if (ret)
> +		return ret;
> +
> +	/* TX Init */
> +	if (interface == PHY_INTERFACE_MODE_2500BASEX)
> +		val = 0x4;
> +	else
> +		val = 0x0;
> +	ret = regmap_clear_bits(priv->regmap, AN8855_RG_QP_TX_MODE_16B_EN, BIT(0));
> +	if (ret)
> +		return ret;
> +	ret = regmap_update_bits(priv->regmap, AN8855_RG_QP_TX_MODE_16B_EN,
> +				 GENMASK(31, 16),
> +				 FIELD_PREP(GENMASK(31, 16), val));
> +	if (ret)
> +		return ret;
> +
> +	/* RX Control/Init */
> +	ret = regmap_set_bits(priv->regmap, AN8855_RG_QP_RXAFE_RESERVE, BIT(11));
> +	if (ret)
> +		return ret;
> +
> +	if (interface == PHY_INTERFACE_MODE_2500BASEX)
> +		val = 0x1;
> +	else
> +		val = 0x2;
> +	ret = regmap_update_bits(priv->regmap, AN8855_RG_QP_CDR_LPF_MJV_LIM,
> +				 GENMASK(5, 4),
> +				 FIELD_PREP(GENMASK(5, 4), val));
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_update_bits(priv->regmap, AN8855_RG_QP_CDR_LPF_SETVALUE,
> +				 GENMASK(28, 25),
> +				 FIELD_PREP(GENMASK(28, 25), 0x1));
> +	if (ret)
> +		return ret;
> +	ret = regmap_update_bits(priv->regmap, AN8855_RG_QP_CDR_LPF_SETVALUE,
> +				 GENMASK(31, 29),
> +				 FIELD_PREP(GENMASK(31, 29), 0x6));
> +	if (ret)
> +		return ret;
> +
> +	if (interface == PHY_INTERFACE_MODE_2500BASEX)
> +		val = 0xf;
> +	else
> +		val = 0xc;
> +	ret = regmap_update_bits(priv->regmap, AN8855_RG_QP_CDR_PR_CKREF_DIV1,
> +				 GENMASK(12, 8),
> +				 FIELD_PREP(GENMASK(12, 8), val));
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_update_bits(priv->regmap, AN8855_RG_QP_CDR_PR_KBAND_DIV_PCIE,
> +				 GENMASK(12, 8),
> +				 FIELD_PREP(GENMASK(12, 8), 0x19));
> +	if (ret)
> +		return ret;
> +	ret = regmap_clear_bits(priv->regmap, AN8855_RG_QP_CDR_PR_KBAND_DIV_PCIE, BIT(6));
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_update_bits(priv->regmap, AN8855_RG_QP_CDR_FORCE_IBANDLPF_R_OFF,
> +				 GENMASK(12, 6),
> +				 FIELD_PREP(GENMASK(12, 6), 0x21));
> +	if (ret)
> +		return ret;
> +	ret = regmap_update_bits(priv->regmap, AN8855_RG_QP_CDR_FORCE_IBANDLPF_R_OFF,
> +				 GENMASK(17, 16),
> +				 FIELD_PREP(GENMASK(17, 16), 0x2));
> +	if (ret)
> +		return ret;
> +	ret = regmap_clear_bits(priv->regmap, AN8855_RG_QP_CDR_FORCE_IBANDLPF_R_OFF, BIT(13));
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_clear_bits(priv->regmap, AN8855_RG_QP_CDR_PR_KBAND_DIV_PCIE, BIT(30));
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_update_bits(priv->regmap, AN8855_RG_QP_CDR_PR_CKREF_DIV1,
> +				 GENMASK(26, 24),
> +				 FIELD_PREP(GENMASK(26, 24), 0x4));
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_set_bits(priv->regmap, AN8855_RX_CTRL_26, BIT(23));
> +	if (ret)
> +		return ret;
> +	ret = regmap_clear_bits(priv->regmap, AN8855_RX_CTRL_26, BIT(24));
> +	if (ret)
> +		return ret;
> +	ret = regmap_set_bits(priv->regmap, AN8855_RX_CTRL_26, BIT(26));
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_update_bits(priv->regmap, AN8855_RX_DLY_0, GENMASK(7, 0),
> +				 FIELD_PREP(GENMASK(7, 0), 0x6f));
> +	if (ret)
> +		return ret;
> +	ret = regmap_set_bits(priv->regmap, AN8855_RX_DLY_0, GENMASK(13, 8));
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_update_bits(priv->regmap, AN8855_RX_CTRL_42, GENMASK(12, 0),
> +				 FIELD_PREP(GENMASK(12, 0), 0x150));
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_update_bits(priv->regmap, AN8855_RX_CTRL_2, GENMASK(28, 16),
> +				 FIELD_PREP(GENMASK(28, 16), 0x150));
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_update_bits(priv->regmap, AN8855_PON_RXFEDIG_CTRL_9,
> +				 GENMASK(2, 0),
> +				 FIELD_PREP(GENMASK(2, 0), 0x1));
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_update_bits(priv->regmap, AN8855_RX_CTRL_8, GENMASK(27, 16),
> +				 FIELD_PREP(GENMASK(27, 16), 0x200));
> +	if (ret)
> +		return ret;
> +	ret = regmap_update_bits(priv->regmap, AN8855_RX_CTRL_8, GENMASK(14, 0),
> +				 FIELD_PREP(GENMASK(14, 0), 0xfff));
> +	if (ret)
> +		return ret;
> +
> +	/* Frequency meter */
> +	if (interface == PHY_INTERFACE_MODE_2500BASEX)
> +		val = 0x10;
> +	else
> +		val = 0x28;
> +	ret = regmap_update_bits(priv->regmap, AN8855_RX_CTRL_5, GENMASK(29, 10),
> +				 FIELD_PREP(GENMASK(29, 10), val));
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_update_bits(priv->regmap, AN8855_RX_CTRL_6, GENMASK(19, 0),
> +				 FIELD_PREP(GENMASK(19, 0), 0x64));
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_update_bits(priv->regmap, AN8855_RX_CTRL_7, GENMASK(19, 0),
> +				 FIELD_PREP(GENMASK(19, 0), 0x2710));
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_set_bits(priv->regmap, AN8855_PLL_CTRL_0, BIT(0));
> +	if (ret)
> +		return ret;
> +
> +	/* PCS Init */
> +	if (interface == PHY_INTERFACE_MODE_SGMII &&
> +	    neg_mode == PHYLINK_PCS_NEG_INBAND_DISABLED) {
> +		ret = regmap_clear_bits(priv->regmap, AN8855_QP_DIG_MODE_CTRL_0,
> +					BIT(0));
> +		if (ret)
> +			return ret;
> +		ret = regmap_clear_bits(priv->regmap, AN8855_QP_DIG_MODE_CTRL_0,
> +					GENMASK(5, 4));
> +		if (ret)
> +			return ret;

Do these really need to be done separately, or can the two be combined?

		ret = regmap_clear_bits(priv->regmap, AN8855_QP_DIG_MODE_CTRL_0,
					GENMASK(5, 4) | BIT(0));

?

> +	}
> +
> +	ret = regmap_clear_bits(priv->regmap, AN8855_RG_HSGMII_PCS_CTROL_1, BIT(30));
> +	if (ret)
> +		return ret;
> +
> +	if (neg_mode == PHYLINK_PCS_NEG_INBAND_ENABLED) {
> +		/* Set AN Ability - Interrupt */
> +		ret = regmap_set_bits(priv->regmap, AN8855_SGMII_REG_AN_FORCE_CL37, BIT(0));
> +		if (ret)
> +			return ret;
> +
> +		ret = regmap_update_bits(priv->regmap, AN8855_SGMII_REG_AN_13,
> +					 GENMASK(5, 0),
> +					 FIELD_PREP(GENMASK(5, 0), 0xb));
> +		if (ret)
> +			return ret;
> +		ret = regmap_set_bits(priv->regmap, AN8855_SGMII_REG_AN_13, BIT(8));
> +		if (ret)
> +			return ret;
> +	}

Eh?

> +
> +	/* Rate Adaption - GMII path config. */
> +	if (interface == PHY_INTERFACE_MODE_2500BASEX) {
> +		ret = regmap_clear_bits(priv->regmap, AN8855_RATE_ADP_P0_CTRL_0, BIT(31));
> +		if (ret)
> +			return ret;
> +	} else {
> +		if (neg_mode == PHYLINK_PCS_NEG_INBAND_ENABLED) {
> +			ret = regmap_set_bits(priv->regmap, AN8855_MII_RA_AN_ENABLE, BIT(0));
> +			if (ret)
> +				return ret;
> +		} else {
> +			ret = regmap_set_bits(priv->regmap, AN8855_RG_AN_SGMII_MODE_FORCE,
> +					      BIT(0));
> +			if (ret)
> +				return ret;
> +			ret = regmap_clear_bits(priv->regmap, AN8855_RG_AN_SGMII_MODE_FORCE,
> +						GENMASK(5, 4));
> +			if (ret)
> +				return ret;
> +
> +			ret = regmap_clear_bits(priv->regmap, AN8855_RATE_ADP_P0_CTRL_0,
> +						GENMASK(3, 0));
> +			if (ret)
> +				return ret;
> +		}
> +
> +		ret = regmap_set_bits(priv->regmap, AN8855_RATE_ADP_P0_CTRL_0, BIT(28));
> +		if (ret)
> +			return ret;
> +	}
> +
> +	ret = regmap_set_bits(priv->regmap, AN8855_RG_RATE_ADAPT_CTRL_0, BIT(0));
> +	if (ret)
> +		return ret;
> +	ret = regmap_set_bits(priv->regmap, AN8855_RG_RATE_ADAPT_CTRL_0, BIT(4));
> +	if (ret)
> +		return ret;
> +	ret = regmap_set_bits(priv->regmap, AN8855_RG_RATE_ADAPT_CTRL_0, GENMASK(27, 26));
> +	if (ret)
> +		return ret;
> +
> +	/* Disable AN */
> +	if (neg_mode == PHYLINK_PCS_NEG_INBAND_ENABLED) {
> +		ret = regmap_set_bits(priv->regmap, AN8855_SGMII_REG_AN0,
> +				      AN8855_SGMII_AN_ENABLE);
> +		if (ret)
> +			return ret;
> +	} else {
> +		ret = regmap_clear_bits(priv->regmap, AN8855_SGMII_REG_AN0,
> +					AN8855_SGMII_AN_ENABLE);
> +		if (ret)
> +			return ret;
> +	}

Again, using regmap_update_bits() with a mask and value is probably more
readable here. This looks like it's twiddling a standard BMCR_ANENABLE
bit.

> +
> +	if (interface == PHY_INTERFACE_MODE_SGMII &&
> +	    neg_mode == PHYLINK_PCS_NEG_INBAND_DISABLED) {
> +		ret = regmap_set_bits(priv->regmap, AN8855_PHY_RX_FORCE_CTRL_0, BIT(4));
> +		if (ret)
> +			return ret;
> +	}

Eh?

> +
> +	/* Force Speed */
> +	if (interface == PHY_INTERFACE_MODE_2500BASEX ||
> +	    neg_mode == PHYLINK_PCS_NEG_INBAND_ENABLED) {
> +		if (interface == PHY_INTERFACE_MODE_2500BASEX)
> +			val = 0x3;
> +		else
> +			val = 0x2;
> +		ret = regmap_set_bits(priv->regmap, AN8855_SGMII_STS_CTRL_0, BIT(2));
> +		if (ret)
> +			return ret;
> +		ret = regmap_update_bits(priv->regmap, AN8855_SGMII_STS_CTRL_0,
> +					 GENMASK(5, 4),
> +					 FIELD_PREP(GENMASK(5, 4), val));
> +		if (ret)
> +			return ret;
> +	}

I don't understand why speed should be forced if inband is enabled or
we're using 2500base-X.

> +
> +	/* bypass flow control to MAC */
> +	ret = regmap_write(priv->regmap, AN8855_MSG_RX_LIK_STS_0, 0x01010107);
> +	if (ret)
> +		return ret;
> +	ret = regmap_write(priv->regmap, AN8855_MSG_RX_LIK_STS_2, 0x00000EEF);
> +	if (ret)
> +		return ret;

Overall, I'd like more comments about what stuff is doing, especially
the AN stuff. I can't make head nor tail of e.g. is there any
advertisement being programmed or not.

Also, given that this will be called _on its own_ if the user requests
the inband advertisement to be changed, we don't want to unnecessarily
disrupt the link. What would happen if this code runs when the link is
up?

> +
> +	return 0;
> +}
> +
> +static void an8855_pcs_an_restart(struct phylink_pcs *pcs)
> +{
> +	struct an8855_priv *priv = container_of(pcs, struct an8855_priv, pcs);
> +
> +	regmap_set_bits(priv->regmap, AN8855_SGMII_REG_AN0,
> +			AN8855_SGMII_AN_RESTART);

Again, looks like a standard PHY BMCR.

I haven't done a full review, but these are just what I've spotted so
far.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!


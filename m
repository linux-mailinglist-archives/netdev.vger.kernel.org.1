Return-Path: <netdev+bounces-216288-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30311B32E6A
	for <lists+netdev@lfdr.de>; Sun, 24 Aug 2025 10:47:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D0BA203531
	for <lists+netdev@lfdr.de>; Sun, 24 Aug 2025 08:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79C9425A2C4;
	Sun, 24 Aug 2025 08:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="o2jUWLvs"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A20425B2FD;
	Sun, 24 Aug 2025 08:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756024974; cv=none; b=c3Hmg6R2AI3A9UxWzaESA4WotZWhNuWDKAUAdUABVxIV11hwagbPFgr8Gs2PcKAad7WKUvuLmrS5bLZL8SK5OdEg9T8YqrTZelRT+sRrFWpiW+chxZp5lToSk5729VrOhRveQWdGSQUNz/ccZ0HLWL82ak3wTdDn3C5Qu4qmqNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756024974; c=relaxed/simple;
	bh=VH2ff+RYvrHzjKV72r5eI3Kt2BOyvwDFwIhG3q3/I3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mVOtF2nblRXNXh5cZAF9169LOKZ1TuMKz1EkFtH7xvoqb0WtFwvXQ6uFHrCVZG1g82bACCMeAKg8GSsihZ/glvIUw+TLHtEFETV00LZOkjCIyEo/kDwtqFaF9lI/1YHkFanBBweigsfUByThBUPNsRh18RlQ6iPa1FCR2YwmJBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=o2jUWLvs; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=D8Gl+Zxt9oa7Zc5dESj0vpDguKDuGIyx8iMDjefopxc=; b=o2jUWLvsgzzKohJFr1Bd+1/Mwi
	DsUFhDfDO4zbFoMyVVm0IdBvNaww4OyZo7HbhLUlBFMOvZkDyOJJ9X72oxIJBA1n1WUmcGrhWbx+v
	Oq8RENR6UVptNE+Kg7K7qFHYlGGKM/0K48ca09p2fci5D2hkRenRJHhMEqoSLNCPsIt8+zCuZHUDR
	uUx8UkJ/iipOiPWYVXTSFk+eu37kCna6yZ2DNBSjBU/rmt4jPU/sxXn6w/JnW5R6Cfbz9HJmuRyBh
	sEPg5vLP+Co//EmD1tPaXmEdrEHci0iuTD0PKU2anJTTPrtR1ifx8Krea5WRHa89hIngbP1yV1ZPz
	ncEHQjUA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:33716)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uq6JM-000000005O0-21LE;
	Sun, 24 Aug 2025 09:42:48 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uq6JK-000000006pV-3GkP;
	Sun, 24 Aug 2025 09:42:46 +0100
Date: Sun, 24 Aug 2025 09:42:46 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Simon Horman <horms@kernel.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v6 3/3] net: dsa: yt921x: Add support for
 Motorcomm YT921x
Message-ID: <aKrQhggoGYKzOlkQ@shell.armlinux.org.uk>
References: <20250824005116.2434998-1-mmyangfl@gmail.com>
 <20250824005116.2434998-4-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250824005116.2434998-4-mmyangfl@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

Hi,

Thanks for fixing the major phylink implementation errors. There are
further issues that need addressing.

On Sun, Aug 24, 2025 at 08:51:11AM +0800, David Yang wrote:
> +/******** hardware definitions ********/

...

> +#define YT921X_REG_END			0x400000  /* as long as reg space is below this */

Please consider moving the above register definitions to, e.g.
drivers/net/dsa/yt921x-hw.h Also consider whether some of the below
should also be moved there.

> +#define YT921X_TAG_LEN			8
> +
> +#define YT921X_EDATA_EXTMODE		0xfb
> +#define YT921X_EDATA_LEN		0x100
> +
> +#define YT921X_FDB_NUM		4096
> 
> +enum yt921x_fdb_entry_status {
> +	YT921X_FDB_ENTRY_STATUS_INVALID = 0,
> +	YT921X_FDB_ENTRY_STATUS_MIN_TIME = 1,
> +	YT921X_FDB_ENTRY_STATUS_MOVE_AGING_MAX_TIME = 3,
> +	YT921X_FDB_ENTRY_STATUS_MAX_TIME = 5,
> +	YT921X_FDB_ENTRY_STATUS_PENDING = 6,
> +	YT921X_FDB_ENTRY_STATUS_STATIC = 7,
> +};
> +
> +#define YT921X_PVID_DEFAULT		1
> +
> +#define YT921X_FRAME_SIZE_MAX		0x2400  /* 9216 */
> +
> +#define YT921X_RST_DELAY_US		10000
> +
> +struct yt921x_mib_desc {
> +	unsigned int size;
> +	unsigned int offset;
> +	const char *name;
> +};

Maybe consider moving the struct definitions (of which there are
several) to drivers/net/dsa/yt921x.h ?

> +/******** eee ********/
> +
> +static int
> +yt921x_set_eee(struct yt921x_priv *priv, int port, struct ethtool_keee *e)
> +{
> +	struct device *dev = to_device(priv);
> +	bool enable = e->eee_enabled;
> +	u16 new_mask;
> +	int res;
> +
> +	dev_dbg(dev, "%s: port %d, enable %d\n", __func__, port, enable);
> +
> +	/* Enable / disable global EEE */
> +	new_mask = priv->eee_ports_mask;
> +	new_mask &= ~BIT(port);
> +	new_mask |= !enable ? 0 : BIT(port);
> +
> +	if (!!new_mask != !!priv->eee_ports_mask) {
> +		dev_dbg(dev, "%s: toggle %d\n", __func__, !!new_mask);
> +
> +		res = yt921x_smi_toggle_bits(priv, YT921X_PON_STRAP_FUNC,
> +					     YT921X_PON_STRAP_EEE, !!new_mask);
> +		if (res)
> +			return res;
> +		res = yt921x_smi_toggle_bits(priv, YT921X_PON_STRAP_VAL,
> +					     YT921X_PON_STRAP_EEE, !!new_mask);
> +		if (res)
> +			return res;

Here, if EEE is completely disabled, you clear the YT921X_PON_STRAP_EEE
bit...

> +static bool yt921x_dsa_support_eee(struct dsa_switch *ds, int port)
> +{
> +	struct yt921x_priv *priv = to_yt921x_priv(ds);
> +
> +	return (priv->pon_strap_cap & YT921X_PON_STRAP_EEE) != 0;

... and if this bit is clear, you report that EEE is unsupported by the
device - which means the device has no hardware for EEE support, and
the ethtool EEE operations will be blocked and return -EOPNOTSUPP. This
means that once all ports have EEE disabled, EEE can not be re-enabled
except through hardware reset.

Please see the code in net/dsa/user.c::dsa_user_set_eee().

> +/******** port ********/
> +
> +static int yt921x_port_down(struct yt921x_priv *priv, int port)
> +{
> +	u32 mask;
> +	u32 ctrl;
> +	int res;
> +
> +	ctrl = YT921X_PORT_LINK | YT921X_PORT_RX_MAC_EN | YT921X_PORT_TX_MAC_EN;
> +	res = yt921x_smi_clear_bits(priv, YT921X_PORTn_CTRL(port), ctrl);
> +	if (res)
> +		return res;
> +
> +	if (yt921x_port_is_external(port)) {
> +		ctrl = YT921X_SGMII_LINK;
> +		res = yt921x_smi_clear_bits(priv, YT921X_SGMIIn(port), ctrl);
> +		if (res)
> +			return res;
> +
> +		mask = YT921X_XMII_LINK;
> +		res = yt921x_smi_clear_bits(priv, YT921X_XMIIn(port), ctrl);
> +		if (res)
> +			return res;
> +	}
> +
> +	return 0;
> +}
> +
> +static int
> +yt921x_port_up(struct yt921x_priv *priv, int port, unsigned int mode,
> +	       phy_interface_t interface, int speed, int duplex,
> +	       bool tx_pause, bool rx_pause)
> +{
> +	struct device *dev = to_device(priv);
> +	u32 mask;
> +	u32 ctrl;
> +	int res;
> +
> +	switch (speed) {
> +	case SPEED_10:
> +		ctrl = YT921X_PORT_SPEED_10;
> +		break;
> +	case SPEED_100:
> +		ctrl = YT921X_PORT_SPEED_100;
> +		break;
> +	case SPEED_1000:
> +		ctrl = YT921X_PORT_SPEED_1000;
> +		break;
> +	case SPEED_10000:
> +		ctrl = YT921X_PORT_SPEED_10000;
> +		break;
> +	case SPEED_2500:
> +		ctrl = YT921X_PORT_SPEED_2500;
> +		break;
> +	default:
> +		if (speed >= 0)
> +			dev_err(dev, "Unsupported speed %d\n", speed);
> +		break;
> +	}
> +	if (duplex == DUPLEX_FULL)
> +		ctrl |= YT921X_PORT_DUPLEX_FULL;
> +	if (tx_pause)
> +		ctrl |= YT921X_PORT_TX_PAUSE;
> +	if (rx_pause)
> +		ctrl |= YT921X_PORT_RX_PAUSE;
> +	ctrl |= YT921X_PORT_LINK | YT921X_PORT_RX_MAC_EN |
> +		YT921X_PORT_TX_MAC_EN;
> +	res = yt921x_smi_write(priv, YT921X_PORTn_CTRL(port), ctrl);
> +	if (res)
> +		return res;
> +
> +	if (yt921x_port_is_external(port)) {
> +		mask = YT921X_SGMII_SPEED_M;
> +		switch (speed) {
> +		case SPEED_10:
> +			ctrl = YT921X_SGMII_SPEED_10;
> +			break;
> +		case SPEED_100:
> +			ctrl = YT921X_SGMII_SPEED_100;
> +			break;
> +		case SPEED_1000:
> +			ctrl = YT921X_SGMII_SPEED_1000;
> +			break;
> +		case SPEED_10000:
> +			ctrl = YT921X_SGMII_SPEED_10000;
> +			break;
> +		case SPEED_2500:
> +			ctrl = YT921X_SGMII_SPEED_2500;
> +			break;
> +		}
> +		mask |= YT921X_SGMII_DUPLEX_FULL;
> +		if (duplex == DUPLEX_FULL)
> +			ctrl |= YT921X_SGMII_DUPLEX_FULL;
> +		mask |= YT921X_SGMII_TX_PAUSE;
> +		if (tx_pause)
> +			ctrl |= YT921X_SGMII_TX_PAUSE;
> +		mask |= YT921X_SGMII_RX_PAUSE;
> +		if (rx_pause)
> +			ctrl |= YT921X_SGMII_RX_PAUSE;
> +		mask |= YT921X_SGMII_LINK;
> +		ctrl |= YT921X_SGMII_LINK;
> +		res = yt921x_smi_update_bits(priv, YT921X_SGMIIn(port),
> +					     mask, ctrl);
> +		if (res)
> +			return res;
> +
> +		ctrl = YT921X_XMII_LINK;
> +		res = yt921x_smi_set_bits(priv, YT921X_XMIIn(port), ctrl);
> +		if (res)
> +			return res;
> +
> +		switch (speed) {
> +		case SPEED_10:
> +			ctrl = YT921X_MDIO_POLLING_SPEED_10;
> +			break;
> +		case SPEED_100:
> +			ctrl = YT921X_MDIO_POLLING_SPEED_100;
> +			break;
> +		case SPEED_1000:
> +			ctrl = YT921X_MDIO_POLLING_SPEED_1000;
> +			break;
> +		case SPEED_10000:
> +			ctrl = YT921X_MDIO_POLLING_SPEED_10000;
> +			break;
> +		case SPEED_2500:
> +			ctrl = YT921X_MDIO_POLLING_SPEED_2500;
> +			break;
> +		}
> +		if (duplex == DUPLEX_FULL)
> +			ctrl |= YT921X_MDIO_POLLING_DUPLEX_FULL;
> +		ctrl |= YT921X_MDIO_POLLING_LINK;
> +		res = yt921x_smi_write(priv, YT921X_MDIO_POLLINGn(port), ctrl);
> +		if (res)
> +			return res;
> +	}
> +
> +	return 0;
> +}
> +
> +static int
> +yt921x_port_config(struct yt921x_priv *priv, int port, unsigned int mode,
> +		   phy_interface_t interface)
> +{
> +	struct device *dev = to_device(priv);
> +	u32 mask;
> +	u32 ctrl;
> +	int res;
> +
> +	if (!yt921x_port_is_external(port)) {
> +		if (interface != PHY_INTERFACE_MODE_INTERNAL) {
> +			dev_err(dev, "Wrong mode %d on port %d\n",
> +				interface, port);
> +			return -EINVAL;
> +		}
> +		return 0;
> +	}
> +
> +	switch (interface) {
> +	/* SGMII */
> +	case PHY_INTERFACE_MODE_SGMII:
> +	case PHY_INTERFACE_MODE_100BASEX:
> +	case PHY_INTERFACE_MODE_1000BASEX:
> +	case PHY_INTERFACE_MODE_2500BASEX:
> +		res = yt921x_smi_set_bits(priv, YT921X_SGMII_CTRL,
> +					  YT921X_SGMII_CTRL_PORTn(port));
> +		if (res)
> +			return res;
> +		res = yt921x_smi_clear_bits(priv, YT921X_XMII_CTRL,
> +					    YT921X_XMII_CTRL_PORTn(port));
> +		if (res)
> +			return res;
> +
> +		mask = YT921X_SGMII_MODE_M;
> +		switch (interface) {
> +		case PHY_INTERFACE_MODE_SGMII:
> +			ctrl = YT921X_SGMII_MODE_SGMII_PHY;
> +			break;
> +		case PHY_INTERFACE_MODE_100BASEX:
> +			ctrl = YT921X_SGMII_MODE_100BASEX;
> +			break;
> +		case PHY_INTERFACE_MODE_1000BASEX:
> +			ctrl = YT921X_SGMII_MODE_1000BASEX;
> +			break;
> +		case PHY_INTERFACE_MODE_2500BASEX:
> +			ctrl = YT921X_SGMII_MODE_2500BASEX;
> +			break;
> +		default:
> +			WARN_ON(1);
> +			break;
> +		}
> +		res = yt921x_smi_update_bits(priv, YT921X_SGMIIn(port),
> +					     mask, ctrl);
> +		if (res)
> +			return res;
> +
> +		break;
> +	/* XMII */
> +	case PHY_INTERFACE_MODE_MII:
> +	case PHY_INTERFACE_MODE_REVMII:
> +	case PHY_INTERFACE_MODE_RMII:
> +	case PHY_INTERFACE_MODE_REVRMII:
> +	case PHY_INTERFACE_MODE_RGMII:
> +	case PHY_INTERFACE_MODE_RGMII_ID:
> +	case PHY_INTERFACE_MODE_RGMII_RXID:
> +	case PHY_INTERFACE_MODE_RGMII_TXID:
> +	case PHY_INTERFACE_MODE_INTERNAL:
> +		/* TODO */
> +		dev_err(dev, "Untested mode %d\n", interface);
> +		return -EINVAL;
> +
> +		res = yt921x_smi_clear_bits(priv, YT921X_SGMII_CTRL,
> +					    YT921X_SGMII_CTRL_PORTn(port));
> +		if (res)
> +			return res;
> +		res = yt921x_smi_set_bits(priv, YT921X_XMII_CTRL,
> +					  YT921X_XMII_CTRL_PORTn(port));
> +		if (res)
> +			return res;
> +
> +		mask = YT921X_XMII_EN | YT921X_XMII_MODE_M;
> +		ctrl = YT921X_XMII_EN;
> +		switch (interface) {
> +		case PHY_INTERFACE_MODE_MII:
> +			ctrl |= YT921X_XMII_MODE_MII;
> +			break;
> +		case PHY_INTERFACE_MODE_REVMII:
> +			ctrl |= YT921X_XMII_MODE_REVMII;
> +			break;
> +		case PHY_INTERFACE_MODE_RMII:
> +			ctrl |= YT921X_XMII_MODE_RMII;
> +			break;
> +		case PHY_INTERFACE_MODE_REVRMII:
> +			ctrl |= YT921X_XMII_MODE_REVRMII;
> +			break;
> +		case PHY_INTERFACE_MODE_RGMII:
> +		case PHY_INTERFACE_MODE_RGMII_ID:
> +		case PHY_INTERFACE_MODE_RGMII_RXID:
> +		case PHY_INTERFACE_MODE_RGMII_TXID:
> +			ctrl |= YT921X_XMII_MODE_RGMII;
> +			break;
> +		case PHY_INTERFACE_MODE_INTERNAL:
> +			ctrl |= YT921X_XMII_MODE_DISABLE;
> +			break;
> +		default:
> +			WARN_ON(1);
> +			break;
> +		}
> +		res = yt921x_smi_update_bits(priv, YT921X_XMIIn(port),
> +					     mask, ctrl);
> +		if (res)
> +			return res;
> +
> +		/* TODO: RGMII delay */
> +
> +		break;
> +	default:
> +		WARN_ON(1);
> +		break;
> +	}
> +
> +	return 0;
> +}
> +
> +static void
> +yt921x_phylink_mac_link_down(struct phylink_config *config, unsigned int mode,
> +			     phy_interface_t interface)
> +{
> +	struct dsa_port *dp = dsa_phylink_to_port(config);
> +	struct dsa_switch *ds = dp->ds;
> +	struct yt921x_priv *priv = to_yt921x_priv(ds);
> +	struct device *dev = to_device(priv);
> +	int port = dp->index;
> +	int res;
> +
> +	dev_dbg(dev, "%s: port %d\n", __func__, port);
> +
> +	yt921x_smi_acquire(priv);
> +	res = yt921x_port_down(priv, port);
> +	yt921x_smi_release(priv);
> +
> +	if (res)
> +		dev_err(dev, "%s: port %d: %i\n", __func__, port, res);
> +}
> +
> +static void
> +yt921x_phylink_mac_link_up(struct phylink_config *config,
> +			   struct phy_device *phydev, unsigned int mode,
> +			   phy_interface_t interface, int speed, int duplex,
> +			   bool tx_pause, bool rx_pause)
> +{
> +	struct dsa_port *dp = dsa_phylink_to_port(config);
> +	struct dsa_switch *ds = dp->ds;
> +	struct yt921x_priv *priv = to_yt921x_priv(ds);
> +	struct device *dev = to_device(priv);
> +	int port = dp->index;
> +	int res;
> +
> +	dev_dbg(dev,
> +		"%s: port %d, mode %u, interface %d, speed %d, duplex %d, "
> +		"tx_pause %d, rx_pause %d\n", __func__, port, mode, interface,
> +		speed, duplex, tx_pause, rx_pause);
> +
> +	yt921x_smi_acquire(priv);
> +	res = yt921x_port_up(priv, port, mode, interface, speed, duplex,
> +			     tx_pause, rx_pause);
> +	yt921x_smi_release(priv);
> +
> +	if (res)
> +		dev_err(dev, "%s: port %d: %i\n", __func__, port, res);
> +}
> +
> +static void
> +yt921x_phylink_mac_config(struct phylink_config *config, unsigned int mode,
> +			  const struct phylink_link_state *state)
> +{
> +	struct dsa_port *dp = dsa_phylink_to_port(config);
> +	struct dsa_switch *ds = dp->ds;
> +	struct yt921x_priv *priv = to_yt921x_priv(ds);
> +	struct device *dev = to_device(priv);
> +	int port = dp->index;
> +	int res;
> +
> +	dev_dbg(dev, "%s: port %d, mode %u, interface %d\n",
> +		__func__, port, mode, state->interface);
> +
> +	yt921x_smi_acquire(priv);
> +	res = yt921x_port_config(priv, port, mode, state->interface);
> +	yt921x_smi_release(priv);
> +	if (res)
> +		dev_err(dev, "%s: port %d: %i\n", __func__, port, res);
> +}
> +
> +static void
> +yt921x_dsa_phylink_get_caps(struct dsa_switch *ds, int port,
> +			    struct phylink_config *config)
> +{
> +	struct yt921x_priv *priv = to_yt921x_priv(ds);
> +	const struct yt921x_info *info = priv->info;
> +
> +	if (yt921x_info_port_is_internal(info, port)) {
> +		__set_bit(PHY_INTERFACE_MODE_INTERNAL,
> +			  config->supported_interfaces);
> +		config->mac_capabilities = 0;
> +	} else if (yt921x_info_port_is_external(info, port)) {
> +		/* TODO: external port may support SGMII only, XMII only, or
> +		 * SGMII + XMII depending on the chip. However, we can't get
> +		 * the accurate config table due to lack of document, thus
> +		 * we simply declare SGMII + XMII and rely on the correctness
> +		 * of devicetree for now.
> +		 */
> +
> +		/* SGMII */
> +		__set_bit(PHY_INTERFACE_MODE_SGMII,
> +			  config->supported_interfaces);
> +		__set_bit(PHY_INTERFACE_MODE_100BASEX,
> +			  config->supported_interfaces);
> +		__set_bit(PHY_INTERFACE_MODE_1000BASEX,
> +			  config->supported_interfaces);
> +		__set_bit(PHY_INTERFACE_MODE_2500BASEX,
> +			  config->supported_interfaces);
> +		config->mac_capabilities = MAC_2500FD;
> +
> +		/* XMII */
> +		__set_bit(PHY_INTERFACE_MODE_MII,
> +			  config->supported_interfaces);
> +		__set_bit(PHY_INTERFACE_MODE_REVMII,
> +			  config->supported_interfaces);
> +		__set_bit(PHY_INTERFACE_MODE_RMII,
> +			  config->supported_interfaces);
> +		__set_bit(PHY_INTERFACE_MODE_REVRMII,
> +			  config->supported_interfaces);
> +		phy_interface_set_rgmii(config->supported_interfaces);
> +	} else {
> +		return;
> +	}
> +
> +	config->mac_capabilities |= MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
> +				    MAC_10 | MAC_100 | MAC_1000;

You can set this at the top of the function, which will eliminate the
need for the final "else { return; }" and the need for the weird
looking "config->mac_capabilities = 0;" in the internal case. Don't
forget to update the external case to use |=.

This is safe because if config->supported_interfaces is empty, phylink
will report an error.

> +static void yt921x_mdio_shutdown(struct mdio_device *mdiodev)
> +{
> +	struct device *dev = &mdiodev->dev;
> +	struct yt921x_priv *priv = dev_get_drvdata(dev);

	struct yt921x_priv *priv = mdiodev_get_drvdata(mdiodev0;

> +	struct dsa_switch *ds = &priv->ds;
> +
> +	dsa_switch_shutdown(ds);
> +}
> +
> +static void yt921x_mdio_remove(struct mdio_device *mdiodev)
> +{
> +	struct device *dev = &mdiodev->dev;
> +	struct yt921x_priv *priv = dev_get_drvdata(dev);

	struct yt921x_priv *priv = mdiodev_get_drvdata(mdiodev0;

> +	struct dsa_switch *ds = &priv->ds;
> +
> +	dsa_unregister_switch(ds);
> +}
> +
> +static int yt921x_mdio_probe(struct mdio_device *mdiodev)
> +{
> +	struct device *dev = &mdiodev->dev;
> +	struct yt921x_smi_mdio *mdio;
> +	struct yt921x_priv *priv;
> +	struct dsa_switch *ds;
> +
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	mdio = devm_kzalloc(dev, sizeof(*mdio), GFP_KERNEL);
> +	if (!mdio)
> +		return -ENOMEM;
> +
> +	mdio->bus = mdiodev->bus;
> +	mdio->addr = mdiodev->addr;
> +	mdio->switchid = 0;
> +
> +	priv->smi_ops = &yt921x_smi_ops_mdio;
> +	priv->smi_ctx = mdio;
> +
> +	ds = &priv->ds;
> +	ds->dev = dev;
> +	ds->configure_vlan_while_not_filtering = true;
> +	ds->assisted_learning_on_cpu_port = true;
> +	ds->priv = priv;
> +	ds->ops = &yt921x_dsa_switch_ops;
> +	ds->phylink_mac_ops = &yt921x_phylink_mac_ops;
> +	ds->num_ports = YT921X_PORT_NUM;
> +
> +	dev_set_drvdata(dev, priv);

	mdiodev_set_drvdata(mdiodev, priv);

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!


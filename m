Return-Path: <netdev+bounces-99361-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 671818D49BE
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 12:36:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97FD71C22A55
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 10:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26781176ADD;
	Thu, 30 May 2024 10:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Vfjo8Haf"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89B9176AD8;
	Thu, 30 May 2024 10:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717065358; cv=none; b=BkDWZodn69ByQXMpw/X+19EJfAmL4+T8UeO7jD6Mk3EXFyN335YdpDe0ko3fxs3Z8ZNuu3ZMtdb3x72+un5fx4H+hFzO90akWtRSJSClicVDuphfHfXl3xOXkjGdR32g5wQV5n2Xlr69WM7xdo3UKCkpysOzltzXz3CFjKx0/CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717065358; c=relaxed/simple;
	bh=+QaffK0reuDqOh0TT1ydlqjOcVteN5EKkVTcdgLqsNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lV+qOC42dfnIDQJS+A69K8lqhQhQwAVWX6NfFavLOfA/k2LH3y+v8bJWii/Hx4UkH7TI3HNMap0fweRclRQEMwdv/QZg8Z011aRZKDA4OUJDM9MBxMRt+GH++5ENOfTIAs6BypzUSambCjkJa5nCilfgR2l/E+HP+gZI08ZNr/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Vfjo8Haf; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=7EB7Pfgo7d2NaDQG2bI7LdmS0RfvQbmEUJWLNeSOUPE=; b=Vfjo8HafVgU85X8wT31+ClDAnG
	yFLvmJ1mBuR7Te0gX5R5ClsSqBm66It75TUU7WdBF/MreijEep3h3W6LOGOcOiHuHcN8L9lCZaZtL
	cranp4f/nde77Us43ZL3lRXJteXoOjiMCxpQjt1+RKf+LfIEmW9S+6UPVQw7ndtOZ4XYbY0xPedzS
	h7FCRBF3rpiZ+LzHS8Ga7SBoce/eVohOg08iGSmaFdtncg2fUpbXvCzDOmrJzAUslutJDcA5GWuEO
	GyIMRn8b4UFTd4X8rkcVoT3Bqnpi/n1L0if6hDboA8jP0s6Re+YCakFmC9pqE0g5fJ/GawGTYlXeK
	fJMoRYEg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:42664)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sCd8I-0007GP-0U;
	Thu, 30 May 2024 11:35:42 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sCd8J-00054V-0z; Thu, 30 May 2024 11:35:43 +0100
Date: Thu, 30 May 2024 11:35:42 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Sky Huang <SkyLake.Huang@mediatek.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Qingfang Deng <dqfext@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Steven Liu <Steven.Liu@mediatek.com>
Subject: Re: [PATCH net-next v5 5/5] net: phy: add driver for built-in 2.5G
 ethernet PHY on MT7988
Message-ID: <ZlhWfua01SCOor80@shell.armlinux.org.uk>
References: <20240530034844.11176-1-SkyLake.Huang@mediatek.com>
 <20240530034844.11176-6-SkyLake.Huang@mediatek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240530034844.11176-6-SkyLake.Huang@mediatek.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, May 30, 2024 at 11:48:44AM +0800, Sky Huang wrote:
> +static int mt798x_2p5ge_phy_config_aneg(struct phy_device *phydev)
> +{
> +	bool changed = false;
> +	u32 adv;
> +	int ret;
> +
> +	/* In fact, if we disable autoneg, we can't link up correctly:
> +	 *  2.5G/1G: Need AN to exchange master/slave information.
> +	 *  100M: Without AN, link starts at half duplex(According to IEEE 802.3-2018),
> +	 *        which this phy doesn't support.
> +	 *   10M: Deprecated in this ethernet phy.
> +	 */
> +	if (phydev->autoneg == AUTONEG_DISABLE)
> +		return -EOPNOTSUPP;

We have another driver (stmmac) where a platform driver is wanting to
put a hack in the ksettings_set() ethtool path to error out on
disabling AN for 1G speeds. This sounds like something that is
applicable to more than one hardware (and I've been wondering whether
it is universally true that 1G copper links and faster all require
AN to function.)

Thus, I'm wondering whether this is something that the core code should
be doing.

> +	/* This phy can't handle collision, and neither can (XFI)MAC it's connected to.
> +	 * Although it can do HDX handshake, it doesn't support CSMA/CD that HDX requires.
> +	 */

What the MAC can and can't do really has little bearing on what link
modes the PHY driver should be providing. It is the responsibility of
the MAC driver to appropriately change what is supported when attaching
to the PHY. If using phylink, this is done by phylink via the MAC driver
telling phylink what it is capable of via mac_capabilities.

> +static int mt798x_2p5ge_phy_get_rate_matching(struct phy_device *phydev,
> +					      phy_interface_t iface)
> +{
> +	if (iface == PHY_INTERFACE_MODE_XGMII)
> +		return RATE_MATCH_PAUSE;

You mention above XFI...

XFI is 10GBASE-R protocol to XFP module electrical standards.
SFI is 10GBASE-R protocol to SFP+ module electrical standards.

phy_interface_t is interested in the protocol. So, given that you
mention XFI, why doesn't this test for PHY_INTERFACE_MODE_10GBASER?

> +static int mt798x_2p5ge_phy_probe(struct phy_device *phydev)
> +{
> +	struct mtk_i2p5ge_phy_priv *priv;
> +
> +	priv = devm_kzalloc(&phydev->mdio.dev,
> +			    sizeof(struct mtk_i2p5ge_phy_priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	switch (phydev->drv->phy_id) {
> +	case MTK_2P5GPHY_ID_MT7988:
> +		/* The original hardware only sets MDIO_DEVS_PMAPMD */
> +		phydev->c45_ids.mmds_present |= (MDIO_DEVS_PCS | MDIO_DEVS_AN |
> +						 MDIO_DEVS_VEND1 | MDIO_DEVS_VEND2);

No need for parens on the RHS. The RHS is an expression in its own
right, and there's no point in putting parens around the expression
to turn it into another expression!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!


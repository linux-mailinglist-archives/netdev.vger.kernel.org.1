Return-Path: <netdev+bounces-125538-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E80C96D9E2
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 15:11:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 499751F231FB
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 13:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92FA619B5BE;
	Thu,  5 Sep 2024 13:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="vbXW2lJv"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0993719923F;
	Thu,  5 Sep 2024 13:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725541891; cv=none; b=cm6e7LLPQpJLJG5hY9lV3HzB3RkRi+K09xaf+lB1HanGhE4HupnVyvyzzbMv2nwqTSke4RVIR2pj0cgWRsfSSCZ0HH1Qj97aBFbVA41xPYbkP8ftHIV6b86Q3dArr2ppjwr6a/Bi6C6EFu4peZOzHubra0sky4sSlJ8xe6jKLD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725541891; c=relaxed/simple;
	bh=B4OoINR8f2pI7vP0h50pkU+jjxceI3F24FMsJ26tdMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Afq24dDe/K75mWYAkkXUPVtf8dVKG7B9KozEuOr/Z/GgTx5dRBn89fVzU8Cyhcl16zbDR1ZmtCCse84+lPeaoYb9alD688WmkzpMwS8KKp5MKjl2buMZVnYu9Zubz15jzTFpEI53sk/b36aQBE45xvveXV+UDEOXPX6W2689RDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=vbXW2lJv; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=3TZF8JcMuMlh2jF0tc2CPPeXmTZ6sDvGLKFPbqWE8Wo=; b=vbXW2lJvtpLgs/EMbMxtKeCQVE
	c9NGrOOsULP+7JP/r0r8L47vz1ir26FboPmOpRnkWywH9U0vae+do/IGfTh5sHGTeHsaS6PKVFW7G
	SGvWRKZjuLghaTJqzX7ixrhBjcL1msNvIbpjWcw4rjduDRLOx9hAWNrjjcy6xmQT828I=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1smCGe-006gAX-Co; Thu, 05 Sep 2024 15:11:20 +0200
Date: Thu, 5 Sep 2024 15:11:20 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, linux@armlinux.org.uk,
	kuba@kernel.org, hkallweit1@gmail.com, richardcochran@gmail.com,
	rdunlap@infradead.org, bryan.whitehead@microchip.com,
	edumazet@google.com, pabeni@redhat.com,
	maxime.chevallier@bootlin.com, linux-kernel@vger.kernel.org,
	horms@kernel.org, UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net-next V5 4/5] net: lan743x: Migrate phylib to phylink
Message-ID: <cad5b31d-7713-4a1d-88e4-58d6878e90c5@lunn.ch>
References: <20240904090645.8742-1-Raju.Lakkaraju@microchip.com>
 <20240904090645.8742-5-Raju.Lakkaraju@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904090645.8742-5-Raju.Lakkaraju@microchip.com>

> +static struct {
> +	unsigned long mask;
> +	int speed;
> +	int duplex;
> +} lan743x_mac_caps_params[] = {
> +	{ MAC_2500FD,	SPEED_2500,   DUPLEX_FULL },
> +	{ MAC_1000FD,	SPEED_1000,   DUPLEX_FULL },
> +	{ MAC_100FD,	SPEED_100,    DUPLEX_FULL },
> +	{ MAC_10FD,	SPEED_10,     DUPLEX_FULL },
> +	{ MAC_100HD,	SPEED_100,    DUPLEX_HALF },
> +	{ MAC_10HD,	SPEED_10,     DUPLEX_HALF },
> +};
> +
> +static int lan743x_find_max_speed(unsigned long caps, int *speed, int *duplex)
> +{
> +	int i;
> +
> +	*speed = SPEED_UNKNOWN;
> +	*duplex = DUPLEX_UNKNOWN;
> +	for (i = 0; i < ARRAY_SIZE(lan743x_mac_caps_params); i++) {
> +		if (caps & lan743x_mac_caps_params[i].mask) {
> +			*speed = lan743x_mac_caps_params[i].speed;
> +			*duplex = lan743x_mac_caps_params[i].duplex;
> +			break;
> +		}
> +	}
> +
> +	return *speed == SPEED_UNKNOWN ? -EINVAL : 0;
> +}
> +
> +static int lan743x_phylink_create(struct lan743x_adapter *adapter)
> +{
> +	struct net_device *netdev = adapter->netdev;
> +	struct phylink *pl;
> +
> +	adapter->phylink_config.dev = &netdev->dev;
> +	adapter->phylink_config.type = PHYLINK_NETDEV;
> +	adapter->phylink_config.mac_managed_pm = false;
> +
> +	adapter->phylink_config.mac_capabilities = MAC_ASYM_PAUSE |
> +		MAC_SYM_PAUSE | MAC_10 | MAC_100 | MAC_1000FD;
> +


> +	case PHY_INTERFACE_MODE_SGMII:
> +		__set_bit(PHY_INTERFACE_MODE_SGMII,
> +			  adapter->phylink_config.supported_interfaces);
> +		__set_bit(PHY_INTERFACE_MODE_1000BASEX,
> +			  adapter->phylink_config.supported_interfaces);
> +		__set_bit(PHY_INTERFACE_MODE_2500BASEX,
> +			  adapter->phylink_config.supported_interfaces);
> +		adapter->phylink_config.mac_capabilities |= MAC_2500FD;


> +static int lan743x_phylink_connect(struct lan743x_adapter *adapter)
> +{
> +	struct device_node *dn = adapter->pdev->dev.of_node;
> +	struct net_device *dev = adapter->netdev;
> +	struct phy_device *phydev;
> +	int ret;
> +
> +	if (dn)
> +		ret = phylink_of_phy_connect(adapter->phylink, dn, 0);
> +
> +	if (!dn || (ret && !lan743x_phy_handle_exists(dn))) {
> +		phydev = phy_find_first(adapter->mdiobus);
> +		if (phydev) {
> +			/* attach the mac to the phy */
> +			ret = phylink_connect_phy(adapter->phylink, phydev);
> +		} else if (((adapter->csr.id_rev & ID_REV_ID_MASK_) ==
> +			      ID_REV_ID_LAN7431_) || adapter->is_pci11x1x) {
> +			struct phylink_link_state state;
> +			unsigned long caps;
> +
> +			caps = adapter->phylink_config.mac_capabilities;
> +			ret = lan743x_find_max_speed(caps, &state.speed,
> +						     &state.duplex);

This seems like an overly complicated way to determine the speed. If
MAC_2500FD is set, you know it is 2500. Otherwise it must by 1000. Why
not use a simple if?

I'm not the best at reviewing phylink patches, but since Russell is
off-lime, i'm the best you have. So

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

but please do consider simplifying the code above.

    Andrew


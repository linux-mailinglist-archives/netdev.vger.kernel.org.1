Return-Path: <netdev+bounces-143269-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 268429C1C37
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 12:33:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3D211F237DF
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 11:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D66B31E378D;
	Fri,  8 Nov 2024 11:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="A3n5ikA7"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C17D1E2858;
	Fri,  8 Nov 2024 11:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731065613; cv=none; b=RtdRdQ2j9SB3nJDEq5rEIMZQsVHJ7dccEwSAgGZKtBg8jQY14GPNGmzBNNOONww31knlpb2haJucumIKNI8psopAaLbdTMpNl4OfoNmOH5/Wr/8xxNq7Hp5WvdEqog8sPkpkHZXJJcBir8QtgkB8sY9fgCM9iNWzGRa+rD3Eqos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731065613; c=relaxed/simple;
	bh=LV7sIanrhOHm+4SGC8DkFx60M6wRG5hygFTvG7O7XJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RbwAGE8kyb38rQPLJ82lQeC8fCp923qu4Ft0Mlqrz2mku7GacJGJUrVXkzN+bU3tUPswUa2fHHUiqXdXUjcj7kQJTX4d3x5BW0BxONia8pjIVgSdTJhtCOw579KCr7V4ZNTo+H7s1pWeMuHXtloM9AIeLAe71DrMMb3ABY89WM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=A3n5ikA7; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=tlHjCfRteXu58BjoW1uzXoJ5VXyhMAoQV0ggR8gszgQ=; b=A3n5ikA7/oGGqiqyRWg/SaNHGQ
	J0PJD0HyKq4zi8avJAACBQwVr9L75+ExiNnp3oABWbBDl0yA4kFvTX6O8NsALAb3jc7iGG+IofYuK
	wPKPMjU7WlgJzfODVFTTqXiq/7AipDF5vt5HcGlFbGbgSNzMg8irXJ0M9DLPXfSJgwPkmgBpnd01L
	Z0nAomJk2RLHkEghje+xRZkIv9FksOQnSgljLZnpOSZQzI/+VHsywdiWk2ye558o977fob2RplxCZ
	3pDso7dlFKFydGHlXcgpVpK2nkqFnxe0NhFd0zwiqSspKUqUUtUTFER1UwOnLIGjf8EpnhC752IGM
	DrxuW80A==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:33240)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1t9NEs-00052L-1F;
	Fri, 08 Nov 2024 11:33:18 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1t9NEq-0002Ep-2F;
	Fri, 08 Nov 2024 11:33:16 +0000
Date: Fri, 8 Nov 2024 11:33:16 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Daniel Machon <daniel.machon@microchip.com>
Cc: Andrew Lunn <andrew@lunn.ch>, UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Lars Povlsen <lars.povlsen@microchip.com>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	jacob.e.keller@intel.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next 7/7] net: lan969x: add function for configuring
 RGMII port devices
Message-ID: <Zy32_Bs7gDAtay5V@shell.armlinux.org.uk>
References: <20241106-sparx5-lan969x-switch-driver-4-v1-0-f7f7316436bd@microchip.com>
 <20241106-sparx5-lan969x-switch-driver-4-v1-7-f7f7316436bd@microchip.com>
 <6fee4db6-0085-4ce8-a6b5-050fddd0bc5a@lunn.ch>
 <20241108085320.fqbell5bfx3roey4@DEN-DL-M70577>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241108085320.fqbell5bfx3roey4@DEN-DL-M70577>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Nov 08, 2024 at 08:53:20AM +0000, Daniel Machon wrote:
> Hi Andrew,
> 
> > > +     if (conf->phy_mode == PHY_INTERFACE_MODE_RGMII ||
> > > +         conf->phy_mode == PHY_INTERFACE_MODE_RGMII_TXID)
> > > +             rx_delay = true;
> > > +
> > > +     if (conf->phy_mode == PHY_INTERFACE_MODE_RGMII ||
> > > +         conf->phy_mode == PHY_INTERFACE_MODE_RGMII_RXID)
> > > +             tx_delay = true;
> > 
> > O.K, now warning bells are ringing in this reviews head.
> > 
> > What i don't see is the value you pass to the PHY? You obviously need
> > to mask out what the MAC is doing when talking to the PHY, otherwise
> > both ends will add delays.
> > 
> 
> What value should be passed to the PHY?
> 
> We (the MAC) add the delays based on the PHY modes - so does the PHY.
> 
> RGMII, we add both delays.
> RGMII_ID, the PHY adds both delays.
> RGMII_TXID, we add the rx delay, the PHY adds the tx delay.
> RGMII_RXID, we add the tx delay, the PHY adds the rx delay.
> 
> Am I missing something here? :-)

What if the board routing adds the necessary delays?

From Documentation/networking/phy.rst:
"
* PHY_INTERFACE_MODE_RGMII: the PHY is not responsible for inserting any
  internal delay by itself, it assumes that either the Ethernet MAC (if capable)
  or the PCB traces insert the correct 1.5-2ns delay
...
For cases where the PHY is not capable of providing this delay, but the
Ethernet MAC driver is capable of doing so, the correct phy_interface_t value
should be PHY_INTERFACE_MODE_RGMII, and the Ethernet MAC driver should be
configured correctly in order to provide the required transmit and/or receive
side delay from the perspective of the PHY device. Conversely, if the Ethernet
MAC driver looks at the phy_interface_t value, for any other mode but
PHY_INTERFACE_MODE_RGMII, it should make sure that the MAC-level delays are
disabled."

The point here is that you have three entities that can deal with the
required delays - the PHY, the board, and the MAC.

PHY_INTERFACE_MODE_RGMII* passed to phylink/phylib tells the PHY how it
should program its delay capabilities.

We're then down to dealing with the MAC and board induced delays. Many
implementations use the rx-internal-delay-ps and tx-internal-delay-ps
properties defined in the ethernet-controller.yaml DT binding to
control the MAC delays.

However, there are a few which use PHY_INTERFACE_MODE_RGMII* on the MAC
end, but in this case, they always pass PHY_INTERFACE_MODE_RGMII to
phylib to stop the PHY adding any delays.

However, we don't have a way at present for DSA/phylink etc to handle a
MAC that wants to ddd its delays with the PHY set to
PHY_INTERFACE_MODE_RGMII.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!


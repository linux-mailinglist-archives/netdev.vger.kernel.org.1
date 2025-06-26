Return-Path: <netdev+bounces-201538-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 676E4AE9D11
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 14:02:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EFC43BFDE5
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 12:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E1FD275AF7;
	Thu, 26 Jun 2025 11:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="bLnAdtiI"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C6527587F;
	Thu, 26 Jun 2025 11:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750939109; cv=none; b=OWJ74MWKmkMu5wnuExKuVrJiHTVktYTr8ru6y3C2leJWa5pagWfCx7z+8FKmJxh0MvJml4flkNRq5h6adcEnbjBVGLdSla89Bsg/77vo5bDBLOEi1IogyBMz139Cebkys69LTk70mUe3OCTHAtJYM6nHXm3RcBnS0r9kdyDI/A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750939109; c=relaxed/simple;
	bh=Qx5wfOItoi1+VQTwbp4aWjc7EP/neC9kgAUf1miAZdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A+eWQuoVCmM/HDE9tyhUkjhXTu6JoA+BtHv3H0Z8q9Yt5kFOLLGrFFqjSRacQv3d86jnbkF6HY6AuHi7jJ6czlWD0V0n/vXEd096gGBJd4nGV+bLkSGoJe8gQkxT342onvVb0GXhUQYLEMTmbyHHVy31rHeJWsXPuWCQSIsmRTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=bLnAdtiI; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=E7sAEgdd707TI8toifhEogagOBUn3n5FZn7TngN4ra8=; b=bLnAdtiIn4wQsxsNQ9E4g1vdj+
	dzmL9IPFWW/ZMhnrr9WlYwj7N1V3Yk8elPHBYwDwSADNFMfaYKdAY8OL9xcwQft8P5YXlebsKs71F
	IV52ILHh2KP0GqomfNcwhnB/a3I3oFOSaiXvVaiKOjsrjflriRqGVpKMnt6yVzJq4VBw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uUlF1-00H2Xz-3Z; Thu, 26 Jun 2025 13:58:07 +0200
Date: Thu, 26 Jun 2025 13:58:07 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andy Whitcroft <apw@canonical.com>,
	Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	Joe Perches <joe@perches.com>, Jonathan Corbet <corbet@lwn.net>,
	Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
	Roger Quadros <rogerq@kernel.org>, Tero Kristo <kristo@kernel.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux@ew.tq-group.com,
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next v2 2/3] net: ethernet: ti: am65-cpsw: fixup PHY
 mode for fixed RGMII TX delay
Message-ID: <8a99444a-a4e4-4c4f-8cec-225a10d5d418@lunn.ch>
References: <cover.1750756583.git.matthias.schiffer@ew.tq-group.com>
 <9b3fb1fbf719bef30702192155c6413cd5de5dcf.1750756583.git.matthias.schiffer@ew.tq-group.com>
 <54d6cd05-65ef-4e1d-8041-3e4a2c50b443@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54d6cd05-65ef-4e1d-8041-3e4a2c50b443@ti.com>

On Thu, Jun 26, 2025 at 03:10:50PM +0530, Siddharth Vadapalli wrote:
> On Tue, Jun 24, 2025 at 12:53:33PM +0200, Matthias Schiffer wrote:
> 
> Hello Matthias,
> 
> > All am65-cpsw controllers have a fixed TX delay, so the PHY interface
> > mode must be fixed up to account for this.
> > 
> > Modes that claim to a delay on the PCB can't actually work. Warn people
> > to update their Device Trees if one of the unsupported modes is specified.
> > 
> > Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> > Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> > Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> > ---
> >  drivers/net/ethernet/ti/am65-cpsw-nuss.c | 27 ++++++++++++++++++++++--
> >  1 file changed, 25 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
> > index f20d1ff192efe..519757e618ad0 100644
> > --- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
> > +++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
> > @@ -2602,6 +2602,7 @@ static int am65_cpsw_nuss_init_slave_ports(struct am65_cpsw_common *common)
> >  		return -ENOENT;
> >  
> >  	for_each_child_of_node(node, port_np) {
> > +		phy_interface_t phy_if;
> >  		struct am65_cpsw_port *port;
> >  		u32 port_id;
> >  
> > @@ -2667,14 +2668,36 @@ static int am65_cpsw_nuss_init_slave_ports(struct am65_cpsw_common *common)
> >  
> >  		/* get phy/link info */
> >  		port->slave.port_np = of_node_get(port_np);
> > -		ret = of_get_phy_mode(port_np, &port->slave.phy_if);
> > +		ret = of_get_phy_mode(port_np, &phy_if);
> >  		if (ret) {
> >  			dev_err(dev, "%pOF read phy-mode err %d\n",
> >  				port_np, ret);
> >  			goto of_node_put;
> >  		}
> >  
> > -		ret = phy_set_mode_ext(port->slave.ifphy, PHY_MODE_ETHERNET, port->slave.phy_if);
> > +		/* CPSW controllers supported by this driver have a fixed
> > +		 * internal TX delay in RGMII mode. Fix up PHY mode to account
> > +		 * for this and warn about Device Trees that claim to have a TX
> > +		 * delay on the PCB.
> > +		 */
> > +		switch (phy_if) {
> > +		case PHY_INTERFACE_MODE_RGMII_ID:
> > +			phy_if = PHY_INTERFACE_MODE_RGMII_RXID;
> > +			break;
> > +		case PHY_INTERFACE_MODE_RGMII_TXID:
> > +			phy_if = PHY_INTERFACE_MODE_RGMII;
> > +			break;
> > +		case PHY_INTERFACE_MODE_RGMII:
> > +		case PHY_INTERFACE_MODE_RGMII_RXID:
> > +			dev_warn(dev,
> > +				 "RGMII mode without internal TX delay unsupported; please fix your Device Tree\n");
> 
> Existing users designed boards and enabled Ethernet functionality using
> "rgmii-rxid" in the device-tree and implementing the PCB traces in a
> way that they interpret "rgmii-rxid". So their (mis)interpretation of
> it is being challenged by the series. While it is true that we are updating
> the bindings and driver to move towards the correct definition, I believe that
> the above message would cause confusion. Would it be alright to update it to
> something similar to:
> 
> "Interpretation of RGMII delays has been corrected; no functional impact; please fix your Device Tree"

It is dev_warn() not dev_err(), so it should be read as a warning. And
the device will continue to probe and work. So I think the message is
O.K. What we don't want is DT developers thinking they can just ignore
it. So i would keep it reasonably strongly worded.

	Andrew


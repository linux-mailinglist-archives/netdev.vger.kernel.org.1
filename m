Return-Path: <netdev+bounces-211204-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA964B17274
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 15:52:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBB6F1C22B51
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 13:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C98F2D1301;
	Thu, 31 Jul 2025 13:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="KgOSHaLN"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406EA2D12E6
	for <netdev@vger.kernel.org>; Thu, 31 Jul 2025 13:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753969853; cv=none; b=NiLkUJCtxk3lDCipVw8n+f8DYwaLoUb5IXhM1wM11advMZn95RCvg6QzX/bqDw3d8CAWYHrpEAwTviBDiAtoA6Mgs4NrJ2nx/hDjr672Ikh/u9zsTgunug54sGx1SnIWoll31IEi0F4W7zzy2gCFfbzfNRiowKqvxPJyCwY7xs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753969853; c=relaxed/simple;
	bh=Jhq8GsvwJo/ERxKvbfFY89YtsVFcEGBSAGYKAWGdGT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RyJf73GzSdal/if8tTHWip/M1vUXWr8I3UGf37kEoCUq6ECJ9dt5cVGSyKBe7wEVsRn+4YgleC8+hp3gUsU3tvV1TKYfU2VXKctJcmQqEkT3bBu50OUjRvesfejcW4ORcssINa7Wi7otqb1oGS/YUDKSReo4qQCZiwXhV8/Jt9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=KgOSHaLN; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=EtHOdkUrI/LHJoo4aSLNhIy4O7aRVecAaUYHo14dmpc=; b=KgOSHaLNsVdy7XfCvbv3wXO557
	L3vUq4w++REDwwo4SAhhto0BthFCgATo2oujmRhvlanB8QEkF3lYc0wZ8cWCvm/K+oJWnwSQQyYhV
	1QGGHzMDyXyL7qKQsbkXcbCGkCCajn3zWzM0FlmMZjrPHiVDGMHlazUJs5Opa95Tdsbg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uhTg6-003NE1-Ib; Thu, 31 Jul 2025 15:50:38 +0200
Date: Thu, 31 Jul 2025 15:50:38 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: markus.stockhausen@gmx.de
Cc: 'Heiner Kallweit' <hkallweit1@gmail.com>, linux@armlinux.org.uk,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, michael@fossekall.de, daniel@makrotopia.org,
	netdev@vger.kernel.org, jan@3e8.eu
Subject: Re: [PATCH v2] net: phy: realtek: convert RTL8226-CG to c45 only
Message-ID: <82e6a2d7-f341-468b-b7f6-e3c6768ba474@lunn.ch>
References: <20250731054445.580474-1-markus.stockhausen@gmx.de>
 <d0e1c087-f701-402e-b842-3444fbce7f27@gmail.com>
 <059901dc0209$a817de50$f8479af0$@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <059901dc0209$a817de50$f8479af0$@gmx.de>

> > For my understanding: Which hardware disables c22 MMD access on RTL8226 how?
> > RTL930x configures RTL8226 in a way that is doesn't accept c45 over c22 any longer?
> 
> sorry to be not clear about this. We have rtl9300 mdio driver
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree
> /drivers/net/mdio/mdio-realtek-rtl9300.c?h=v6.16
> 
> This must decide how its four smi busses are configured. Either c22 
> or c45. https://svanheule.net/realtek/longan/register/smi_glb_ctrl 
> So it does.
> 
> 	/* Put the interfaces into C45 mode if required */
> 	glb_ctrl_mask = GENMASK(19, 16);
> 	for (i = 0; i < MAX_SMI_BUSSES; i++)
> 		if (priv->smi_bus_is_c45[i])
> 			glb_ctrl_val |= GLB_CTRL_INTF_SEL(i);
> 	...
> 	err = regmap_update_bits(regmap, SMI_GLB_CTRL,
> 				 glb_ctrl_mask, glb_ctrl_val);
> 
> As soon as this bit is set to one mode the bus will block most
> accesses with the other mode. E.g. In c22 mode registers 13/14
> are a dead end. So the only option for the bus is to limit access
> like this.
> 
> 	bus->name = "Realtek Switch MDIO Bus";
> 	if (priv->smi_bus_is_c45[mdio_bus]) {
> 		bus->read_c45 = rtl9300_mdio_read_c45;
> 		bus->write_c45 =  rtl9300_mdio_write_c45;
> 	} else {
> 		bus->read = rtl9300_mdio_read_c22;
> 		bus->write = rtl9300_mdio_write_c22;
> 	}

Please summaries this for in the commit message. Not using C22 in the
driver is only part of the overall picture. In phylib, there are a
number of places in core where if an op is not provided by the driver,
it will fall back to a genphy_ helper which will do a C22 access. It
would be good if the commit message made is clear this has been
considered, and that such operations will fail because the MDIO driver
itself does not support C22.

	Andrew


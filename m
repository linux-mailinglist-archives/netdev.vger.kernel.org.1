Return-Path: <netdev+bounces-234038-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BAE5C1C2BA
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 17:42:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 154A6464E58
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 15:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B8772E2DD4;
	Wed, 29 Oct 2025 15:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="sUm7pKr8"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437182DC321;
	Wed, 29 Oct 2025 15:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761750943; cv=none; b=JWmIrGG82GZFfQKR1HSch7ajEXOewvxeUBf08HQQ6cigim9XzlEEbZUU2WYbR8GoRw/HEvHwNldDK3gPIrdvvfzPJyXk8jbBeP1nFV54+HCfI6pzcBnxWn46uw5WqhkaY/VQss0N//bZUVNSnKql8rrkk1VKzUf/RULCOd28XGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761750943; c=relaxed/simple;
	bh=YpOiN16OOmgQKGfgwWpCdhOG6sGEAhkAnM4rvwsc+Gg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EVGVxaR/IjiMqgFXija+EnuY6Ce9jqamaAHpHUr5nxozjRrb4Lik95bn5rpDXdEfzKnlMWpKZ1JdH+k9b5gv56+2N7Ib3UyjVqJxoRVIuMHNYTEMXbrIlgGz3aEfrD5VTXXSgn5mnoDK6Mj3vw8c2rffgw/52E4OW/Y3blK1vNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=sUm7pKr8; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=WghT21IWeW06NETfCppiitPVHTb4Mn61Llspnfp9sqY=; b=sUm7pKr8zCcva9ENEdrHLEfwNv
	A+5k4SgmrB/gt7ugyupv25YRpTmNDF/mdvjRMbQry0+PyRZ5VdEH0ECdTP16eYZwHAHidF+XqFenQ
	8pPX26qH9s4DKWrXQhcofMY5FVQCH0s4t2mEmtV+ITHiigphbbvLU6Ac8qqVPp3kZtCI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vE7tX-00CQ6R-AF; Wed, 29 Oct 2025 16:15:27 +0100
Date: Wed, 29 Oct 2025 16:15:27 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Buday Csaba <buday.csaba@prolan.hu>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Philipp Zabel <p.zabel@pengutronix.de>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 3/4] net: mdio: reset PHY before attempting
 to access registers in fwnode_mdiobus_register_phy
Message-ID: <c01fc3d0-050e-4ea7-970f-393268430824@lunn.ch>
References: <cover.1761732347.git.buday.csaba@prolan.hu>
 <5f8d93021a7aa6eeb4fb67ab27ddc7de9101c59f.1761732347.git.buday.csaba@prolan.hu>
 <e61e1c1c-083b-472f-8edd-b16832ca578e@lunn.ch>
 <aQIhf3dXOxS4vd2W@debianbuilder>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQIhf3dXOxS4vd2W@debianbuilder>

On Wed, Oct 29, 2025 at 03:15:27PM +0100, Buday Csaba wrote:
> On Wed, Oct 29, 2025 at 02:20:14PM +0100, Andrew Lunn wrote:
> > > +/* Hard-reset a PHY before registration */
> > > +static int fwnode_reset_phy(struct mii_bus *bus, u32 addr,
> > > +			    struct fwnode_handle *phy_node)
> > > +{
> > > +	struct mdio_device *tmpdev;
> > > +	int rc;
> > > +
> > > +	tmpdev = mdio_device_create(bus, addr);
> > > +	if (IS_ERR(tmpdev))
> > > +		return PTR_ERR(tmpdev);
> > > +
> > > +	fwnode_handle_get(phy_node);
> > 
> > You add a _get() here. Where is the corresponding _put()?
> 
> When mdio_device_free() is called, it eventually invokes
> mdio_device_release(). There is the corresponding _put(), that will
> release the reference. I also verified this with a stack trace.
> 
> > 
> > Also, fwnode_handle_get() returns a handle. Why do you throw it away?
> > What is the point of this get?
> >
> 
> I copied this initialization stub from of_mdiobus_register_device()
> in of_mdio.c. The same pattern is used there:
> 
> 	fwnode_handle_get(fwnode);
> 	device_set_node(&mdiodev->dev, fwnode);

This looks broken, but i'm not sure...

static int of_mdiobus_register_device(struct mii_bus *mdio,
				      struct device_node *child, u32 addr)
{
	struct fwnode_handle *fwnode = of_fwnode_handle(child);
	struct mdio_device *mdiodev;
	int rc;

	mdiodev = mdio_device_create(mdio, addr);
	if (IS_ERR(mdiodev))
		return PTR_ERR(mdiodev);

	/* Associate the OF node with the device structure so it
	 * can be looked up later.
	 */
	fwnode_handle_get(fwnode);
	device_set_node(&mdiodev->dev, fwnode);

	/* All data is now stored in the mdiodev struct; register it. */
	rc = mdio_device_register(mdiodev);
	if (rc) {
		device_set_node(&mdiodev->dev, NULL);
		fwnode_handle_put(fwnode);
		mdio_device_free(mdiodev);

In this error handling, it appears the fwnode is put() and then the
mdiodev freed. I assume that results in a call to
mdio_device_release() which does a second put() on fwnode.

That is why code like this should look symmetric. If the put() is in
free, the get() should be in the create.

> It is kind of awkward that we need to half-establish a device, just
> to assert the reset, but I could not think of any better solution, that
> does not lead to a large amount of code duplication.

And this is another argument against this approach. What does the
documentation say about what you can do with a half-established
device?

	Andrew


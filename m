Return-Path: <netdev+bounces-234280-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FB8DC1E92B
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 07:34:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8522440281A
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 06:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C1AD2F744F;
	Thu, 30 Oct 2025 06:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="TWQR3CW0"
X-Original-To: netdev@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B48226B2C8;
	Thu, 30 Oct 2025 06:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761806047; cv=none; b=GIIKUbsYDNKrdys0tvNJ6QxIZxh0DgeS0TnD5Z9iAMb8mNmhRFEAikXeIV39fmjNyrvPGfuvpW/QYt1UW7vJZ+xT5ygF05KoSzW0BbCJt/qUt4wfTLvzQ1oE5pMGHUwAbzdlftPg/1082lrZmMDyvWc4EFpE/MeQet0Qgc/Gcwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761806047; c=relaxed/simple;
	bh=+SJTBy93OQZkNa5+ywB13QewJssAEqdr321BINBmN58=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ULmSlO0jGHysyk0U2Cr/40FQYYyn1wr1gmMh5LW6roBuD5J22QUus8BIKOHJFtPJMfjfVxowwX6ArB/yI1Gx39s/GAwq/0W2ZIj1l6qYndYAd5IhFuIjvd6ZR3K5mkUz8AWR+DZfI4tc3LZeU7KiucSX/MwbfaeTgedlWA326Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=TWQR3CW0; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 4392AA06E0;
	Thu, 30 Oct 2025 07:33:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-type:content-type:date:from:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to; s=mail; bh=M6ImSmlEdVq6gYsAfzdGGfn6z0LGqhFlIH7lgrJV1hU=; b=
	TWQR3CW0WeseO8PBp42ROXDB16WYCL+prcMIJ8D6uKDCtY5LJsfrSU2UfFZCBbtE
	g5YEaUNDd8RaDJ5PIF4VtOF7N+fuakK2OH0/IrsI3kqG/R72jeuLCeZuYyF4y+pm
	jqZ4yz826Z36Y7hbLoaxq7oT1Ljnqr2Cg9r4cIi+D6SOrPBhxAGJKHDob9NTNnsF
	2RYnSyyp6eEm66TlRkfNU3WmyNTAfsc6zdIcWxrh5hzV7FJxwWy3KKDUX67iaaP2
	FBI9wKlYUZXdGXMtLjmME5fQBWASJPoBDAD1dZaCVHNskvIisda8cOEOoQZ5MDew
	lkUvYAmZ3zqX84WFuN93PURFgaIzwniD6ckyCmL6su0/T6FxGdmDRdn8k9QLQrDf
	00zv+Yg+ApQKOp/xPUUsTfBUPJBZQI+2YxWRkk5MytE+zAgts/AV6O2IJEBT16mL
	zUbqscrPuZVk4rZnWnXcafgz6LL/kMhfjnMeuqbJt7OnDdTXUoPx0/5xM5db51Lc
	+3MqkUy2h2zH46Dm92GN3KgTO2IKlDEfiOwqYb6r0ni2BQcykMo0aRSU7KLI5A20
	EEY2jzqmrGTKvREC8skRYPlJF1Tl4H7o36dP1D5j8B9gYgovscVa09XrrzkQ0RXi
	BIaX4T43FMzRaWN5zuj1X5sy+RfkZA3cK4jtH7XRNZI=
Date: Thu, 30 Oct 2025 07:33:56 +0100
From: Buday Csaba <buday.csaba@prolan.hu>
To: Andrew Lunn <andrew@lunn.ch>
CC: Heiner Kallweit <hkallweit1@gmail.com>, Russell King
	<linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Philipp Zabel <p.zabel@pengutronix.de>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v5 3/4] net: mdio: reset PHY before attempting
 to access registers in fwnode_mdiobus_register_phy
Message-ID: <aQMG1A7nPzpoaShr@debianbuilder>
References: <cover.1761732347.git.buday.csaba@prolan.hu>
 <5f8d93021a7aa6eeb4fb67ab27ddc7de9101c59f.1761732347.git.buday.csaba@prolan.hu>
 <e61e1c1c-083b-472f-8edd-b16832ca578e@lunn.ch>
 <aQIhf3dXOxS4vd2W@debianbuilder>
 <c01fc3d0-050e-4ea7-970f-393268430824@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <c01fc3d0-050e-4ea7-970f-393268430824@lunn.ch>
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1761806037;VERSION=8001;MC=2613030632;ID=168085;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A296767155F67736A

On Wed, Oct 29, 2025 at 04:15:27PM +0100, Andrew Lunn wrote:
> On Wed, Oct 29, 2025 at 03:15:27PM +0100, Buday Csaba wrote:
> > On Wed, Oct 29, 2025 at 02:20:14PM +0100, Andrew Lunn wrote:
> > > > +/* Hard-reset a PHY before registration */
> > > > +static int fwnode_reset_phy(struct mii_bus *bus, u32 addr,
> > > > +			    struct fwnode_handle *phy_node)
> > > > +{
> > > > +	struct mdio_device *tmpdev;
> > > > +	int rc;
> > > > +
> > > > +	tmpdev = mdio_device_create(bus, addr);
> > > > +	if (IS_ERR(tmpdev))
> > > > +		return PTR_ERR(tmpdev);
> > > > +
> > > > +	fwnode_handle_get(phy_node);
> > > 
> > > You add a _get() here. Where is the corresponding _put()?
> > 
> > When mdio_device_free() is called, it eventually invokes
> > mdio_device_release(). There is the corresponding _put(), that will
> > release the reference. I also verified this with a stack trace.
> > 
> > > 
> > > Also, fwnode_handle_get() returns a handle. Why do you throw it away?
> > > What is the point of this get?
> > >
> > 
> > I copied this initialization stub from of_mdiobus_register_device()
> > in of_mdio.c. The same pattern is used there:
> > 
> > 	fwnode_handle_get(fwnode);
> > 	device_set_node(&mdiodev->dev, fwnode);
> 
> This looks broken, but i'm not sure...
> 
> static int of_mdiobus_register_device(struct mii_bus *mdio,
> 				      struct device_node *child, u32 addr)
> {
> 	struct fwnode_handle *fwnode = of_fwnode_handle(child);
> 	struct mdio_device *mdiodev;
> 	int rc;
> 
> 	mdiodev = mdio_device_create(mdio, addr);
> 	if (IS_ERR(mdiodev))
> 		return PTR_ERR(mdiodev);
> 
> 	/* Associate the OF node with the device structure so it
> 	 * can be looked up later.
> 	 */
> 	fwnode_handle_get(fwnode);
> 	device_set_node(&mdiodev->dev, fwnode);
> 
> 	/* All data is now stored in the mdiodev struct; register it. */
> 	rc = mdio_device_register(mdiodev);
> 	if (rc) {
> 		device_set_node(&mdiodev->dev, NULL);
> 		fwnode_handle_put(fwnode);
> 		mdio_device_free(mdiodev);
> 
> In this error handling, it appears the fwnode is put() and then the
> mdiodev freed. I assume that results in a call to
> mdio_device_release() which does a second put() on fwnode.
> 
> That is why code like this should look symmetric. If the put() is in
> free, the get() should be in the create.

I totally agree with that, but I have nothing to do with that code.
It did also confuse me at first, that is why my earlier versions also had
a put(), just not in the error handling path.

> 
> > It is kind of awkward that we need to half-establish a device, just
> > to assert the reset, but I could not think of any better solution, that
> > does not lead to a large amount of code duplication.
> 
> And this is another argument against this approach. What does the
> documentation say about what you can do with a half-established
> device?
> 
> 	Andrew
> 

But that device never actually leaves fwnode_reset_phy(). It is contained.
That was the whole point of the first patch: to avoid code duplication
as much as possible.
In order to assert and deassert the reset, you have many things to set up:
read DT properties, claim the GPIO or the reset controller (which is only
possible for a device, is it not?), then perform the actual
assertion/deassertion.
These functions currently exist for an mdio device, why not use them?

After these patches fwnode_reset_phy() is reasonably structured, at least
I think so. The temporary device is created, reset properties initialized,
reset performed, then cleaned up on exit.

I understand your concerns about the functionality itself. Yes, it may be
better handled by the driver, and it is just to gain a little convenience.
But that is more of a philosophical argument. If I send a next version,
I can not address that. I can only address technical concerns. If your
opinion is, that this feature is not wanted, then there is no point in
sending a next version.
I personally think that autodetection works reasonably well for most of the
devices, so expanding this set a little bit is a nice thing.
But that decision is ultimately for you -maintainers- to make.

I also think that the documentation should reflect clearly when and why
specifying the PHY ID in the DT is necessary, and wheter it is preferred
or not. I would be happy to make such a patch, once the decision is made.

That would have have saved us a lot of development time, and I imagine
there are others in the same shoes.

Thank you for the thorough review!
Csaba



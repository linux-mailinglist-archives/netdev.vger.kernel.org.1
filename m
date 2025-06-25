Return-Path: <netdev+bounces-201261-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ED1AAE8A0B
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 18:38:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46ADB5A75BE
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 16:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F115269823;
	Wed, 25 Jun 2025 16:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="CkD3Vw55"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67BA92BF00A
	for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 16:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750869502; cv=none; b=PAJlA4x3DpVPaVSL6+7vKE+OvjaIfDm31q1Tk3WckLZVGyH+GtVqnocNch10U5OAyni+vZ0OAAr0u8082hTaHusgiHlO9+Uucj71Q9qARrYRi/qMtE8HHe3V4QrXn+MairQjjBsJzn1LFIA0zWnmY1TgSPBWs7EEUn78JqJagSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750869502; c=relaxed/simple;
	bh=hhSqXCulG1nLkdEHGwYUz829kp5zGKZqAKSxjdgnPlQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QfbuDtfFzHB2QpIfr5Ip2ejcZ1MneReh6duGn/3SltA8wwusCygKEl/EJ69viau3zYwD8cyP6OSM5uSO6od3KpdG7cDr75zXri8Tm9maEQaR9cGUSCyMyDymNwm+twY1s5+ck8h5BOOydFPMBOYjC8DpVlsiwxXQJjihF1Hd7ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=CkD3Vw55; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=UKaQDUrxSriPUFL0/33ZL9C0/9EtUaLJiIUk83qCvaA=; b=CkD3Vw55FNuIHL2SQ88YHZnrHD
	Denkcn8MUgbfjzSVS1ONOF0BGfCFGMkvL/P7/NA91e/4m41WHxYzoLo1TZnYxa/9Mj4zTEcv9wZH8
	RQv99uQuJZ54+rfG56W9UmFhBaaFWBdnDgsgDCqVdrp5y6YlZTSJCv8noYzDzYU8xtxM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uUT8Y-00Gx7d-ON; Wed, 25 Jun 2025 18:38:14 +0200
Date: Wed, 25 Jun 2025 18:38:14 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Jakub Raczynski <j.raczynski@samsung.com>, linux@armlinux.org.uk,
	hkallweit1@gmail.com, netdev@vger.kernel.org,
	Wenjing Shan <wenjing.shan@samsung.com>
Subject: Re: [PATCH 1/2] net/mdiobus: Fix potential out-of-bounds read/write
 access
Message-ID: <09617c9f-8c78-4ec2-8f29-fbbd481baf06@lunn.ch>
References: <aEb2WfLHcGBdI3_G@shell.armlinux.org.uk>
 <CGME20250609153151eucas1p12def205b1e442c456d043ab444418a56@eucas1p1.samsung.com>
 <20250609153147.1435432-1-j.raczynski@samsung.com>
 <0d51f36d-eee3-4455-a886-d6a979e8e891@sabinyo.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d51f36d-eee3-4455-a886-d6a979e8e891@sabinyo.mountain>

On Wed, Jun 25, 2025 at 10:23:17AM -0500, Dan Carpenter wrote:
> On Mon, Jun 09, 2025 at 05:31:46PM +0200, Jakub Raczynski wrote:
> > When using publicly available tools like 'mdio-tools' to read/write data
> > from/to network interface and its PHY via mdiobus, there is no verification of
> > parameters passed to the ioctl and it accepts any mdio address.
> > Currently there is support for 32 addresses in kernel via PHY_MAX_ADDR define,
> > but it is possible to pass higher value than that via ioctl.
> > While read/write operation should generally fail in this case,
> > mdiobus provides stats array, where wrong address may allow out-of-bounds
> > read/write.
> > 
> > Fix that by adding address verification before read/write operation.
> > While this excludes this access from any statistics, it improves security of
> > read/write operation.
> > 
> > Fixes: 080bb352fad00 ("net: phy: Maintain MDIO device and bus statistics")
> > Signed-off-by: Jakub Raczynski <j.raczynski@samsung.com>
> > Reported-by: Wenjing Shan <wenjing.shan@samsung.com>
> > ---
> >  drivers/net/phy/mdio_bus.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/drivers/net/phy/mdio_bus.c b/drivers/net/phy/mdio_bus.c
> > index a6bcb0fee863..60fd0cd7cb9c 100644
> > --- a/drivers/net/phy/mdio_bus.c
> > +++ b/drivers/net/phy/mdio_bus.c
> > @@ -445,6 +445,9 @@ int __mdiobus_read(struct mii_bus *bus, int addr, u32 regnum)
> >  
> >  	lockdep_assert_held_once(&bus->mdio_lock);
> >  
> > +	if (addr >= PHY_MAX_ADDR)
> > +		return -ENXIO;
> 
> addr is an int so Smatch wants this to be:
> 
> 	if (addr < 0 || addr >= PHY_MAX_ADDR)
> 		return return -ENXIO;

Yes, addr should never be negative.

> I think that although addr is an int, the actual values are limited to
> 0-U16_MAX?

No, addr should be in the range 0-31. regnum should also be in the
range 0-31. These are clause 22 accesses. There are also clause 45
accesses, but they don't come through here. For those, addr is still
in the range 0-31, but regnum is 0-U16_MAX.

	Andrew


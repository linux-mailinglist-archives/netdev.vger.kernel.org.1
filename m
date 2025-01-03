Return-Path: <netdev+bounces-155032-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71147A00B95
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 16:37:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F07A163520
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 15:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADC9A1FA8EF;
	Fri,  3 Jan 2025 15:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="BA1PMRrv"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0AD1FA8E9
	for <netdev@vger.kernel.org>; Fri,  3 Jan 2025 15:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735918660; cv=none; b=quZHgbYTloQlam9+i3BMlfl/obWk/NnJ0Rb41Kwi6ziIm9f3uCnIhfU7D3iGbzKa4+JZgs4UMw1QzFQqA+LQqmAvj30FStflqKAE91N+wA4yNwOJoot1op8wiWEDaLLh1HK6j7vPI/t7A7/RUVxi0F+E2cde+fZAiX8fkeeFlIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735918660; c=relaxed/simple;
	bh=IQw9pJ228eTZvbjFpEWokRyegaCkYhFIlI8zbKGcOOs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ogY6ji7kutkiOj7Re9LFszMO3DSNckP9XI3IqAs59DvmjMQF0uH5+rZ84H8cGZTX9gW7rYGxl5oH404sXlfM6XXR9/hV6NYGgU/DO4YtpR9m+xv7SBg1XQnIif5g4BjQ6YSu5iCMVnMPQretD945uASPh1UkD5U1DgW/qo8gP+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=BA1PMRrv; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=JSd33bkwaveu8S8e0mibGgJ6kNdOWbqWpVO1trXKPTU=; b=BA1PMRrvHImqNiiDSWBDu84GEX
	p8IvwmoGxhJ3A9V1F+J8rSYJsAEDTM9a6gSbqN3qtL/7FLZSNJOCUfQ3Tm28eR0+LcUJMIt6/fpbJ
	jXHFO25H0FXk4ltQf9Q01PhmtcQdkfDdrEnWnWp4c5GAa2srlIck0Nqo6xvdZWg60KMo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tTjjx-0014iJ-7r; Fri, 03 Jan 2025 16:37:33 +0100
Date: Fri, 3 Jan 2025 16:37:33 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Niklas Cassel <cassel@kernel.org>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
	Francesco Valla <francesco@valla.it>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
	Anand Moon <linux.amoon@gmail.com>,
	Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH] net: phy: don't issue a module request if a driver is
 available
Message-ID: <1898857d-d580-4fa5-8f19-6e91114975a1@lunn.ch>
References: <20250101235122.704012-1-francesco@valla.it>
 <Z3ZzJ3aUN5zrtqcx@shell.armlinux.org.uk>
 <7103704.9J7NaK4W3v@fedora.fritz.box>
 <d5bbf98e-7dff-436e-9759-0d809072202f@lunn.ch>
 <Z3fJQEVV4ACpvP3L@ryzen>
 <Z3fTS5hOGawu18aH@shell.armlinux.org.uk>
 <Z3fc2jiJJDzbCHLu@ryzen>
 <cff14918-0143-4309-9317-675c18ad3a8f@lunn.ch>
 <Z3f1coRBcuKd1Eao@ryzen>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z3f1coRBcuKd1Eao@ryzen>

On Fri, Jan 03, 2025 at 03:34:26PM +0100, Niklas Cassel wrote:
> On Fri, Jan 03, 2025 at 03:12:14PM +0100, Andrew Lunn wrote:
> > > FWIW, the patch in $subject does make the splat go away for me.
> > > (I have the PHY driver built as built-in).
> > > 
> > > The patch in $subject does "Add a list of registered drivers and check
> > > if one is already available before resorting to call request_module();
> > > in this way, if the PHY driver is already there, the MDIO bus can perform
> > > the async probe."
> > 
> > Lets take a step backwards.
> > 
> > How in general should module loading work with async probe? Lets
> > understand that first.
> > 
> > Then we can think about what is special about PHYs, and how we can fit
> > into the existing framework.
> 
> I agree that it might be a good idea, if possible, for request_module()
> itself to see if the requested module is already registered, and then do
> nothing.
> 
> Adding Luis (modules maintainer) to CC.
> 
> Luis, phylib calls request_module() unconditionally, regardless if there
> is a driver registered already (phy driver built as built-in).
> 
> This causes the splat described here to be printed:
> https://lore.kernel.org/netdev/7103704.9J7NaK4W3v@fedora.fritz.box/T/#u
> 
> But as far as I can tell, this is a false positive, since the call cannot
> possibly load any module (since the driver is built as built-in and not
> as a module).

Please be careful here. Just because it is built in for your build
does not mean it is built in for everybody. The code needs to be able
to load the module if it is not built in.

Also, i've seen broken builds where the driver is both built in and
exists as a module. User space will try to load the module, and the
linker will then complain about duplicate symbols and the load fails.
So it is not a false positive. There is also the question of what
exactly causes the deadlock. Is simply calling user space to load a
module which does not exist sufficient to cause the deadlock? That is
what is happening in your system, with built in modules.

Also, the kernel probably has no idea if the module has already been
loaded nor not when request_module() is called. What we pass to the
request_module() is not the name of the module, but a string which
represents one of the IDs the PHY has. It is then userspace that maps
that string to a kernel module via modules.alias. And there is a many
to one mapping, many IDs map to one module. So it could be the module
has already been loaded due to some other string.

So, back to my original question. How should module loading work with
async probe?

      Andrew


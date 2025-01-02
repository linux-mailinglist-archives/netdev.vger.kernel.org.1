Return-Path: <netdev+bounces-154826-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FD889FFDBF
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 19:18:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 143353A02DC
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 18:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 224F126281;
	Thu,  2 Jan 2025 18:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Uz9D0mPz"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0445F1C36
	for <netdev@vger.kernel.org>; Thu,  2 Jan 2025 18:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735841903; cv=none; b=nCZaxZbX7PzWC9IqPKEEIBR9OYXpE3I7ml6eQUr5qnxTEj4o8bWWoa+WjdmIROwo8eu9Y1//98YP/s6KiN7JkR7mhjKyihDQvlCwDhyq2kR4r1tz6zCnXNJ808s6nn8kJNZUiBUSFAVNoAd/miZvaO8mcLHWXfgpHs3kxHqnkr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735841903; c=relaxed/simple;
	bh=eGzq4qeyEsxYhheiFXVbV6vBt+yp5lOUpZmGPoZWD+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hXtJt5dBoBRvI02xVSV31xnjCpzN3430NW2E/AZqnhxMYP1d+JvN5sKGYWqL++9B0EgmHi+3uFgyvAQa6omHaYAU/f/iNGXF8n6jY/ZkakRPZfciNnOyfQUTdOugZUHDYIaQ4++k6d6tLbvFiqZBl8TDYwK4+/FHcW2N7+nbVaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Uz9D0mPz; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=gEnr+2xd5FErp9UakbV+HDM8/IklJy2kSrzBVoTsHpQ=; b=Uz9D0mPzgKQlm5vqoBpZ+tFMMM
	L/TlnAj0baIo9BDQBoR+WVcbN25WtKhco9o3xTRO4yQjz7Xfc+O2P2lVqlpq+Hx36MlyXAq7r9hwj
	u1SwiOP0FtAMXcYlllbOdBMRaqt8YrQtArZTgimITgkgOnxmFENKSX13DHs8JhGXPNd5TPHWvddYe
	mZHkq3AyE1yxUYrAl+VYQEhU5JdeLuRYEFq5sgVNo4JyRPNnywtoqfe261kuewkHr83exvk46eE/j
	OySYT9V+VHmPYCutn1ynNbYWD1y5DsmYlRlWcHm9NSari4aCt5FbrciPxJ9NAVugU/IcUgAONuKJG
	IKlY3znw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:33266)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tTPlv-0002HQ-31;
	Thu, 02 Jan 2025 18:18:16 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tTPlt-0000Ub-35;
	Thu, 02 Jan 2025 18:18:13 +0000
Date: Thu, 2 Jan 2025 18:18:13 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	UNGLinuxDriver@microchip.com,
	Woojung Huh <woojung.huh@microchip.com>
Subject: Re: [PATCH RFC net-next 0/7] net: dsa: cleanup EEE (part 2)
Message-ID: <Z3bYZZu8Ip8it0RZ@shell.armlinux.org.uk>
References: <Z1hPaLFlR4TW_YCr@shell.armlinux.org.uk>
 <20241212194853.7b2bic2vchuqprxz@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241212194853.7b2bic2vchuqprxz@skbuf>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Dec 12, 2024 at 09:48:53PM +0200, Vladimir Oltean wrote:
> On Tue, Dec 10, 2024 at 02:25:44PM +0000, Russell King (Oracle) wrote:
> > This is part 2 of the DSA EEE cleanups, and is being sent out becaues it
> > is relevant for the review of part 1, but would make part 1 too large.
> > 
> > Patch 1 removes the useless setting of tx_lpi parameters in the
> > ksz driver.
> > 
> > Patch 2 removes the DSA core code that calls the get_mac_eee() operation.
> > This needs to be done before removing the implementations because doing
> > otherwise would cause dsa_user_get_eee() to return -EOPNOTSUPP.
> > 
> > Patches 3..6 remove the trivial get_mac_eee() implementations from DSA
> > drivers.
> > 
> > Patch 7 finally removes the get_mac_eee() method from struct
> > dsa_switch_ops.
> 
> I appreciate the splitting of the get_mac_eee() removal into multiple
> patches per driver and 2 for the DSA framework. It should help BSP
> backporters which target only a subset of DSA drivers. Monolithic
> patches are harder to digest, and may have trivial context conflicts due
> to unrelated changes.
> 
> The set looks good, please don't forget to also update the documentation.

Sorry, but which documentation are you referring to?

$ grep get_mac_eee Documentation/networking/ drivers/net include/ net/ -r
$ 

No references to get_mac_eee() anywhere (except in the mt7530 driver
which I've missed - patches now included, will be in v2.)

Even looking for "et_mac_eee" in case of Documentation using
[sg]et_mac_eee() reveals nothing.

So, I don't think there's any documentation that these patches change.

There is this in Documentation/networking/dsa/dsa.rst:

- ``get_eee``: ethtool function which is used to query a switch port EEE settings,
  this function should return the EEE state of the switch port MAC controller
  and data-processing logic as well as query the PHY for its currently configured
  EEE settings

First, realise that my patch set actually changes nothing - all these
implementations were entirely useless because everything they have been
doing has been overwritten by phylib since phylib's EEE support was
changed. Therefore, the above as wrong both before and after this
patch set.

Second, when phylink managed EEE gets merged, the above becomes true
again.

Think of the current phylib behaviour as a user visible regression
(because that's exactly what it is), and this patch set is part of a
move towards resolving that regression.

IMHO, phylib managed EEE support should never have been merged - not
in the way it was. There should have been either a way to transition
drivers to it without causing all this breakage, or there should have
been a commitment to getting this fixed in a timely manner (in the
same cycle that it was merged.)

What we have right now is a total trainwreck.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!


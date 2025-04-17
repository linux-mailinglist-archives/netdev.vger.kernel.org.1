Return-Path: <netdev+bounces-183806-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4A8BA9215D
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 17:23:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C49524643C6
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 15:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D988622D78F;
	Thu, 17 Apr 2025 15:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="tyrjPNBr"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052AD19D898
	for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 15:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744903401; cv=none; b=UnUqh3Sk4vzPluKoisy0Wra/yEwch7/AC0Mj7wdDulOo7dlnMicefvSwnDRa6MOvnQv5k/xNqXlkCV+U1RvHPHcsnQEzUJOu4s5/wATeoY7d07nNOIpOKqw3awzJ2HqFai9Tp4QHy1BASNZmBXgwBbG2E843DBqLiJafa4rBCig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744903401; c=relaxed/simple;
	bh=J0vCAHsn8FJxBfa45px6rI54cE/POgRuZlrWpmmrKn4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nneJEICyqjeKM/TQOzpPhfV90fh4bUTVBOlgmA2w6/F2lp9y9E/TK+3LoQztj+uYmh9YiaKsbFxTRGCPILhRAPUWEiN0H/oLYqRNcSGhR/tOXZ4X9FRuwEknPkzT5AoTFPmXI2QzkDr+qkJSuWH0hMNwVGD4E/35glerh2NBDm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=tyrjPNBr; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=f3pZR1R704MhPbtS/DaFBvBzDCGzwN+h57Alfq3rJtI=; b=tyrjPNBrEu38V0CLT5Zp8lt/w8
	VANxoVW3+CvyCf3RN0kxVZlnQqR81kGs9F/EIiUpQtxzupz52biqXvDO99PG88nYhMJTQLybZ2vV0
	NKoZ/z0vYyEiQrE49k1rOoh7xQa/2Mblq/I2m0cZqrMJbwXx9kTKRyJ/2rUl2S/osCvMhyLwp98Ff
	1QLN8ly42cDujNQ6MHSStn3qWXXNaBi4lHjHb4GRwU83DtPVJ6emfAl1DfaVVVEk0xKRzICZBmXn7
	ekcD8C6M6wVpAT/EGetu928bkZQD8BvR4YetypZgCAwfkYgbs0jOZxc60KxmgciOJ9djRRS4gKTr1
	2/SXWP7Q==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:39068)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1u5R55-0007VS-0k;
	Thu, 17 Apr 2025 16:23:13 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1u5R53-0002Xu-0W;
	Thu, 17 Apr 2025 16:23:09 +0100
Date: Thu, 17 Apr 2025 16:23:08 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Alexander H Duyck <alexander.duyck@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Joakim Zhang <qiangqing.zhang@nxp.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net] net: phylink: fix suspend/resume with WoL enabled
 and link down
Message-ID: <aAEc3HZbSZTiWB8s@shell.armlinux.org.uk>
References: <Z__URcfITnra19xy@shell.armlinux.org.uk>
 <E1u55Qf-0016RN-PA@rmk-PC.armlinux.org.uk>
 <9910f0885c4ee48878569d3e286072228088137a.camel@gmail.com>
 <aAERy1qnTyTGT-_w@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aAERy1qnTyTGT-_w@shell.armlinux.org.uk>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Apr 17, 2025 at 03:35:56PM +0100, Russell King (Oracle) wrote:
> On Thu, Apr 17, 2025 at 07:30:05AM -0700, Alexander H Duyck wrote:
> > This is the only spot where we weren't setting netif_carrier_on/off and
> > old_link_state together. I suspect you could just carry old_link_state
> > without needing to add a new argument. Basically you would just need to
> > drop the "else" portion of this statement.
> > 
> > In the grand scheme of things with the exception of this one spot
> > old_link_state is essentially the actual MAC/PCS link state whereas
> > netif_carrier_off is the administrative state.
> 
> Sorry to say, but you have that wrong. Neither are the administrative
> state.

To add to this (sorry, I rushed that reply), old_link_state is used when
we aren't bound to a network device, otherwise the netif carrier state
is used. Changes in the netif carrier state provoke netlink messages to
userspace to inform userspace of changes to the link state.

Moreover, it controls whether the network stack queues packets for
transmission to the driver, and also whether the transmit watchdog is
allowed to time out. It _probably_ also lets the packet schedulers
know that the link state has changed.

So, the netif carrier state is not "administrative".

It isn't strictly necessary for old_link_state to remain in sync with
the netif carrier state, but it is desirable to avoid errors - but
obviously the netif carrier state only exists when we're bound to a
network device.

> > > -		/* Call mac_link_down() so we keep the overall state balanced.
> > > -		 * Do this under the state_mutex lock for consistency. This
> > > -		 * will cause a "Link Down" message to be printed during
> > > -		 * resume, which is harmless - the true link state will be
> > > -		 * printed when we run a resolve.
> > > -		 */
> > > -		mutex_lock(&pl->state_mutex);
> > > -		phylink_link_down(pl);
> > > -		mutex_unlock(&pl->state_mutex);
> > > +		if (pl->suspend_link_up) {
> > > +			/* Call mac_link_down() so we keep the overall state
> > > +			 * balanced. Do this under the state_mutex lock for
> > > +			 * consistency. This will cause a "Link Down" message
> > > +			 * to be printed during resume, which is harmless -
> > > +			 * the true link state will be printed when we run a
> > > +			 * resolve.
> > > +			 */
> > > +			mutex_lock(&pl->state_mutex);
> > > +			phylink_link_down(pl);
> > > +			mutex_unlock(&pl->state_mutex);
> > > +		}
> > 
> > You should be able to do all of this with just old_link_state. The only
> > thing that would have to change is that you would need to set
> > old_link_state to false after the if statement.
> 
> Nope.

And still nope - what we need to know here is what was the link state
_before_ we called netif_carrier_off() or set old_link_state to false.

I somehow suspect that you don't understand what all this code is trying
to do, so let me explain it.

In the suspend function, when WoL is enabled, and we're using MAC-based
WoL, we need the link to the MAC to remain up, so it can receive packets
to check whether they are the appropriate wake packet. However, we don't
want packets to be queued for transmission either.

So, we have the case where we want to avoid notifying the MAC that the
link has gone down, but we also want to call netif_carrier_off() to stop
the network stack queueing packets.

To achieve this, several things work in unison:

- we take the state mutex to prevent the resolver from running while we
  fiddle with various state.
- we disable the resolver (which, if that's the only thing that happens,
  will provoke the resolver to take the link down.)
- we lie to the resolver about the link state, by calling
  netif_carrier_off() and/or setting old_link_state to false. This
  means the resolver believes the link is _already_ down, and thus
  because of the strict ordering I've previously mentioned, will *not*
  call mac_link_down().
- we release the lock.

There is now no way that the resolver will call either mac_link_up() or
mac_link_down() - which is what we want here.

When we resume, we need to unwind this, but taking care that the network
layers may need to be reprogrammed. That is done by "completing" the
link-down that was done in the suspend function by calling
mac_link_down() (which should only have been done if the link wasn't
already down - hence depends on state _prior_ to the modifications that
phylink_suspend() made.)

It can then re-setup the MAC/PCS by calling the config functions, and
then release the resolver to then make a decision about the state of
the link.

With the fix I posted, this guarantees that that the contract I talked
about previously is maintained.

I'm sorry that this doesn't "fit" your special case, but this is what
all users so far expect from phylink.

Now, how about explaining what's going on in fbnic_mac_link_up_asic()
and fbnic_mac_link_down_asic(), and what in there triggers the BMC
to press the panic stations do-not-press red buttin?

If you wish to have confirmation of what netif_carrier does, then I'm
sure your co-maintainer and core Linux networking maintainer, Jakub,
would be happy to help.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!


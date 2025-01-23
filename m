Return-Path: <netdev+bounces-160595-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09919A1A741
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 16:46:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4C343A13E6
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 15:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16D7C45016;
	Thu, 23 Jan 2025 15:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="F1hM0ajD"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7324288A2;
	Thu, 23 Jan 2025 15:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737647177; cv=none; b=OTX/wMWllFk8aBc4jQitEushj1jH/6kr398OIKUStIBPQQjH3Vdhbrjilh7LJJ0gFK7ZEe0jT53ICWumhhgJzLzKnVrAXiFtSjS0LRiTfSfyLVgHTzVNNQNOPRVcD/9wMcMdvKNSlxecTS91LqKYDr7WnThfW/EZR1sZvFftmS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737647177; c=relaxed/simple;
	bh=StkSgqGlIvB2/x9jzNFXWtGzosqhOQwg8tXsvlPq5Vw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZEUhM2aKLEGkw6i3SkssRukWmRqPff5z7/NWxUvW2HbxjcgnUDEeqL6jWEdo1Cwhk+f+PmKUEWpCSYir494W7yArblh4SH6mh2sjOHSAkChjGVanOjGenstgW5XuSxFwgkVe19UROckNKa/uuZI4HjOft6TEf3fsq7LzO2KpOzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=F1hM0ajD; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=OcBEbigIfy0tR9k6bLmYZ1WLhujCWwwfXvs4ogtPxM8=; b=F1hM0ajDhr4v8Tmdup8Cf6GTjm
	PfsQaqswRNWWJxTPpsZRE1hjPPWbfBRjBiCWbXSi2p7r26KwvFCkmf3dbi49Rz52s0V2PoS8wQhIX
	X7udjz9hWmf12Upu+f754DBMQZAVvmJWK93ZJqZ7VsLEbGXek3meT4opbhXcThEq8dSiDZ+nD/TBm
	bXU2DGkE047961cuMhgYJz3Ft82QU6rUtXsgmtstYQ6mNwJmhRK9uZJ4TBMFXZ8d8ileSYanJYQnq
	tzCk5BR7u2rFr063Obz9JxOqXKIObqO+eI1j5u1za18UOtXPnfsV5BcuYiygYcqEYUiXsEPDLxVEs
	4M01Y7Mw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:57028)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tazP9-0001E4-0p;
	Thu, 23 Jan 2025 15:46:03 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tazP3-00063R-2C;
	Thu, 23 Jan 2025 15:45:57 +0000
Date: Thu, 23 Jan 2025 15:45:57 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	thomas.petazzoni@bootlin.com, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Niklas =?iso-8859-1?Q?S=F6derlund?= <niklas.soderlund@ragnatech.se>,
	Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: Re: [PATCH net-next v3] net: phy: Fix suspicious rcu_dereference
 usage
Message-ID: <Z5JkNZVhMNZkG7W6@shell.armlinux.org.uk>
References: <20250120141926.1290763-1-kory.maincent@bootlin.com>
 <20250120111228.6bd61673@kernel.org>
 <20250121103845.6e135477@kmaincent-XPS-13-7390>
 <134f69de-64f9-4d36-94ff-22b93cb32f2e@bp.renesas.com>
 <20250121140124.259e36e0@kmaincent-XPS-13-7390>
 <d512e107-68ac-4594-a7cb-8c26be4b3280@bp.renesas.com>
 <20250121171156.790df4ba@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250121171156.790df4ba@kmaincent-XPS-13-7390>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Jan 21, 2025 at 05:11:56PM +0100, Kory Maincent wrote:
> On Tue, 21 Jan 2025 15:44:34 +0000
> Paul Barker <paul.barker.ct@bp.renesas.com> wrote:
> 
> > On 21/01/2025 13:01, Kory Maincent wrote:
> > > On Tue, 21 Jan 2025 11:34:48 +0000
> > > Paul Barker <paul.barker.ct@bp.renesas.com> wrote:
> > >   
> > >> On 21/01/2025 09:38, Kory Maincent wrote:  
> >  [...]  
> >  [...]  
> > >>  [...]    
> >  [...]  
> >  [...]  
> > >>
> > >> (Cc'ing Niklas and Sergey as this relates to the ravb driver)  
> > > 
> > > Yes, thanks.
> > >   
> > >> Why do we need to hold the rtnl mutex across the calls to
> > >> netif_device_detach() and ravb_wol_setup()?
> > >>
> > >> My reading of Documentation/networking/netdevices.rst is that the rtnl
> > >> mutex is held when the net subsystem calls the driver's ndo_stop method,
> > >> which in our case is ravb_close(). So, we should take the rtnl mutex
> > >> when we call ravb_close() directly, in both ravb_suspend() and
> > >> ravb_wol_restore(). That would ensure that we do not call
> > >> phy_disconnect() without holding the rtnl mutex and should fix this
> > >> issue.  
> > > 
> > > Not sure about it. For example ravb_ptp_stop() called in ravb_wol_setup()
> > > won't be protected by the rtnl lock.  
> > 
> > ravb_ptp_stop() modifies a couple of device registers and calls
> > ptp_clock_unregister(). I don't see anything to suggest that this
> > requires the rtnl lock to be held, unless I am missing something.
> 
> What happens if two ptp_clock_unregister() with the same ptp_clock pointer are 
> called simultaneously? From ravb_suspend and ravb_set_ringparam for example. It
> may cause some errors.
> For example the ptp->kworker pointer could be used after a kfree.
> https://elixir.bootlin.com/linux/v6.12.6/source/drivers/ptp/ptp_clock.c#L416

Taking a look at where ravb_ptp_stop() is called from:

1. ravb_set_ringparam(). ethtool operation. RTNL will be held for this.
2. ravb_open() error-cleanup. RTNL will be held for this.
3. ravb_tx_timeout_work(). rtnl_trylock() is called and we will only
   call through to the above function if we grabbed the RTNL.
4. ravb_close(), again RTNL will be held here.
5. ravb_wol_setup(). Another ethtool operation. (1) applies.

Hence, it is not possible for two threads to execute ravb_ptp_stop()
symultaneously. However, if ptp_clock_register() in ravb_ptp_init()
fails, then priv->ptp.clock will be set to an error-pointer, and
subsequently passed to ptp_clock_unregister() which would cause a
kernel oops. No one seems to have thought about that... and that
definitely needs fixing.

However, one wonders why it's necessary to unregister a _user_
_interface_ when responding to a change in WoL, ring parameters, or
merely handling a transmit timeout. It doesn't seem particularly
nice to userspace for a device that its using to suddenly go away
for these reasons. I wonder whether anyone has tested anything
that uses the PTP clock interfaces while changing e.g. the WoL
settings.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!


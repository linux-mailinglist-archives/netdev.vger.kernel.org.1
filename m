Return-Path: <netdev+bounces-96145-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D6D58C47E1
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 21:52:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8CB4BB21A76
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 19:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AED5178285;
	Mon, 13 May 2024 19:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="HjkpJ9i7"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F503BB30;
	Mon, 13 May 2024 19:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715629971; cv=none; b=BZJ8+PPZ49InjpV0qxgIGjAmRVSV2AVQYQTmc6a9x7VYadfCNFapWLauwV6EZ7S3rU9fMLo3wcVCCrRW0bFljTcVM1vGBnVvof8jd9n2Fh4018lLlcLjwmHF8pmcYcTQvSF7bIdF6JoJERFbDwLwp+OJ9mpBtNr/SMxiNcVc4i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715629971; c=relaxed/simple;
	bh=LsycYNcfqeN2Wiip2jKgMk5yKEaDaKLdXjNiCQWLjpU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LOUJyAJXsLT5yI8OuPvo1WvGA4UeK2OoS1PEK0U5g3JcshJc1uTtKhqt/khcCSwrflH+kEYvZYcVKiFwdCJ0/Cc8jEP+hKHuMs25PjcdvWPR8Tk022jHgrhJxPXH2spK5zhGCTzH3majs8tyXDTrgC4hvh8WKHuNM5iKXgRkVx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=HjkpJ9i7; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=413blUidoZWelONSsN0SMSimPfYxVtpWsVLy1UsodyE=; b=Hj
	kpJ9i7j63HHIGE8iWKQpPmGWAhk2KaaRQMv3bM76nCk15Un+1uyE/2KAqkk5dMahEAZRQfEe6XLFV
	hFaRpBlCIS2/lQ1+cJB+BpSwhrdN+TMBq6BjjMbepbomlwauFsj1XB9k5qZOqQPr5M6oP8nQjWu33
	TvR6/xe16rM1Coo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s6biq-00FKdS-HE; Mon, 13 May 2024 21:52:32 +0200
Date: Mon, 13 May 2024 21:52:32 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>,
	netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com,
	bcm-kernel-feedback-list@broadcom.com, alexandre.torgue@foss.st.com,
	joabreu@synopsys.com, mcoquelin.stm32@gmail.com,
	richardcochran@gmail.com, linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	Herve Codina <herve.codina@bootlin.com>
Subject: Re: [PATCH v2, net-next, 2/2] net: stmmac: PCI driver for BCM8958X
 SoC
Message-ID: <ea0485f6-fc7d-4e02-884c-05d77420d6ea@lunn.ch>
References: <20240510000331.154486-3-jitendra.vegiraju@broadcom.com>
 <20240511015924.41457-1-jitendra.vegiraju@broadcom.com>
 <Zj/IPpub11OL3jBo@shell.armlinux.org.uk>
 <CAMdnO-KCC0qXEsE1iDGNZwdd0PAcsRinmxe8_-5Anp=e1c5WFA@mail.gmail.com>
 <ZkJQz9u8pQ9YmM5n@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZkJQz9u8pQ9YmM5n@shell.armlinux.org.uk>

On Mon, May 13, 2024 at 06:41:35PM +0100, Russell King (Oracle) wrote:
> On Mon, May 13, 2024 at 10:38:46AM -0700, Jitendra Vegiraju wrote:
> > Thanks for reviewing the patch.
> > On Sat, May 11, 2024 at 12:34 PM Russell King (Oracle)
> > <linux@armlinux.org.uk> wrote:
> > > As pointed out in the other sub-thread, you don't need this. If you need
> > > a fixed-link and you don't have a firmware description of it, you can
> > > provide a swnode based description through plat->port_node that will be
> > > passed to phylink. Through that, you can tell phylink to create a
> > > fixed link.
> > >
> > Thank you for the pointers or software node support.
> > Since the driver is initially targetted for X86/_64, we were not sure
> > how to deal with lack of OF support.
> > We will try out the software node facility.
> 
> You may wish to have a look at drivers/net/ethernet/wangxun/ which
> also creates software nodes for phylink.

How complex is the switch configuration? So far, you have not said
anything about it. Is it derived from b53/SF2?

There is an alternative route you can take. Work with bootlin and use
DT overlays.

https://lore.kernel.org/linux-pci/20240430083730.134918-1-herve.codina@bootlin.com/

Looking at the product brief, the BCM89586M has MDIO busses, SPI
busses, GPIO, etc. It is unclear if these are available on the PCIe
interface, or are only connected to the Cortex-M7? I would guess the
QSPI, DEBUG/JTAG and the UART go to the M7, for its boot media and
console. But the other interfaces could be for Linux to control over
the PCIe. Additionally, the PHY-less ports doing XFI, 5G, 2.5G SGMII
etc, would have either an SFP or multi-gigi PHY connected, hanging of
one of the MDIO busses, GPIOs used for SFP LOS, TX-enable etc. Oddly
there is no I2C for the SPF, but i suppose you could do SPI->I2C.
Anyway, all that is going to need a complex configuration, so maybe DT
overlays make sense, because once the initial work getting Bootlins
patches merged is complete, you get the rest pretty much for free.

	Andrew


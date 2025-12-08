Return-Path: <netdev+bounces-243994-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0992CCACEC0
	for <lists+netdev@lfdr.de>; Mon, 08 Dec 2025 11:54:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 33B1B30155B4
	for <lists+netdev@lfdr.de>; Mon,  8 Dec 2025 10:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92FF52DCBF7;
	Mon,  8 Dec 2025 10:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="1yGsDy0z"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8228525A34F;
	Mon,  8 Dec 2025 10:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765191248; cv=none; b=FAu0dC33KvLPx2++BMaTfQzCuWs2KH0PhYVajTlsq7sdZTZ6AwmA2UensHgh+Du9AZGhTQMYwZIaaUZSYyyTASqkIEvk2SMkKvoYAVpCBTbkyPa6BY05GwsVCYacSbIioSiltRVx0Q0567VBWbvZPwXuu6ypyRxYVhfUsgmR5yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765191248; c=relaxed/simple;
	bh=lIbqbq7+vorGHl/mBqA5iGNZsz87/lls6lN+bAA2TAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mwcOgs2F8mu/suECIswH3RWRRnevIfyPzq7p3qhSqT5e4TsNlNfLDPfBtumON6VgCkzze/8n0xZGIWf6Za6Ag/HqN/o2UX4Opx5szk/EdL/2VHJ2ynx8O1eZqz4l7DKGfYSftogcOOz2whBxUYuUJAaiVIaBkuU6jvKiMTLH1Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=1yGsDy0z; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=lMwxducfoonGZZRrofUF0eEbq1GuPXXsKQ6vzYmcwfw=; b=1yGsDy0zmVtRK97upXKNlS9mmE
	NbcaYh83OyDoMt24AemcGvpc/8IrcM0uEnFIOgmBTyY822qiAXlUUjOA591UKOtTi6AFvSKLHZxZN
	7tkaAISrMoT6tCuOHCAftp09G4PkK7N4YPkZb73fewm4yJUnUEyUpvXxuOScsEWjV2bHwHLUqQDp+
	3kw+vX+vqxSvv++KSEsZK7FRr7YEmlF+yY7QIcsjIGGks9S8VegtxhbsSYzzBRToJhWXC+8QlYuUB
	0ASNR3jZzE3pP0KEwcSQMkVN7avxeawcUh2+1gAfqhYPaya2lXD2IyxgZrlu6ffKK1dOa0Xd1JUlz
	8x/nJjZA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:35326)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vSYsE-000000007eI-3IoT;
	Mon, 08 Dec 2025 10:53:46 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vSYs9-000000004xw-2Ove;
	Mon, 08 Dec 2025 10:53:41 +0000
Date: Mon, 8 Dec 2025 10:53:41 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: phasta@kernel.org
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, Yao Zi <ziyao@disroot.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Frank <Frank.Sae@motor-comm.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Choong Yong Liang <yong.liang.choong@linux.intel.com>,
	Chen-Yu Tsai <wens@csie.org>, Jisheng Zhang <jszhang@kernel.org>,
	Furong Xu <0x1207@gmail.com>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, Mingcong Bai <jeffbai@aosc.io>,
	Kexy Biscuit <kexybiscuit@aosc.io>, Runhua He <hua@aosc.io>,
	Xi Ruoyao <xry111@xry111.site>
Subject: Re: [PATCH net-next v3 2/3] net: stmmac: Add glue driver for
 Motorcomm YT6801 ethernet controller
Message-ID: <aTauNWvRKhn-muir@shell.armlinux.org.uk>
References: <20251205221629.GA3294018@bhelgaas>
 <27fec7d0ed633218a7787be3edce63c3038c63e2.camel@mailbox.org>
 <aTalXy_85pvLraIy@shell.armlinux.org.uk>
 <7e024db2557a4d5822a0dd409ae678d10d815d9c.camel@mailbox.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7e024db2557a4d5822a0dd409ae678d10d815d9c.camel@mailbox.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Dec 08, 2025 at 11:47:23AM +0100, Philipp Stanner wrote:
> On Mon, 2025-12-08 at 10:15 +0000, Russell King (Oracle) wrote:
> > On Mon, Dec 08, 2025 at 10:54:36AM +0100, Philipp Stanner wrote:
> > > The bad news is that it's not super trivial to remove. I looked into it
> > > about two times and decided I can't invest that time currently. You
> > > need to go over all drivers again to see who uses pcim_enable_device(),
> > > then add free_irq_vecs() for them all and so on…
> > 
> > So that I can confirm, you're saying that all drivers that call
> > pci_alloc_irq_vectors() should call pci_free_irq_vectors() in their
> > ->remove() method and not rely on the devres behaviour that
> > pcim_enable_device() will permit.
> 
> "permit" is kind of a generous word. This behavior is dangerous and
> there were bugs because of that in the past, because it confused
> programmers. See:
> 
> f00059b4c1b0 drm/vboxvideo: fix mapping leaks
> 
> 
> pcim_enable_device() used to switch all sorts of functions into managed
> mode. As far as I could figure out through git, back in 2009 it was
> intended that ALL pci functions are switched into managed mode that
> way. That's also how it was documented.
> 
> The ecosystem then fractured, however. Some functions were always
> managed (pcim_), some never, and some sometimes.
> 
> I removed all "sometimes managed" functions since 2024. The last
> remainder is MSI.
> 
> If we want to remove that, we need to:
>    1. Find all drivers that rely on pci_free_irq_vectors() being run
>       automatically. IOW those that use pcim_enable_device() + wrappers
>       around pci_setup_msi_context().
>    2. Port those drivers to do the free_irq_vecs manually, if it's not
>       a problem if it's called twice. If that were a problem, those
>       drivers would also need to replace pcim_enable_device() with
>       pci_enable_device().
>    3. Once all drivers are ported, remove the devres code from msi.c
>    4. Do associated cleanup work in PCI.
> 
> > 
> > In terms of whether it's safe to call this twice, pci_free_irq_vectors()
> > calls pci_disable_msix() and pci_disable_msi().
> > 
> > pci_disable_msix() checks:
> > 
> >         if (!pci_msi_enabled() || !dev || !dev->msix_enabled)
> >                 return;
> > 
> > which will set dev->msix_enabled to 0 via pci_msix_shutdown().
> > 
> > pci_disable_msi() does a similar check:
> > 
> >         if (!pci_msi_enabled() || !dev || !dev->msi_enabled)
> >                 return;
> > 
> > and similarly pci_msi_shutdown() sets dev->msi_enabled to 0.
> > 
> > So my conclusion is it's safe to call pci_free_irq_vectors() twice for
> > the same device.
> > 
> 
> Hm. Looks good.

So, what do you want to see for new drivers such as the one at the top
of this thread? Should they explicitly call pci_free_irq_vectors() even
though they call pcim_enable_device() ?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!


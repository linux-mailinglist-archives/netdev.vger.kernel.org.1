Return-Path: <netdev+bounces-243767-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FBF6CA783C
	for <lists+netdev@lfdr.de>; Fri, 05 Dec 2025 13:06:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A1353380D106
	for <lists+netdev@lfdr.de>; Fri,  5 Dec 2025 09:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAF34332904;
	Fri,  5 Dec 2025 09:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="ShZigmyH"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60348326938;
	Fri,  5 Dec 2025 09:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764927333; cv=none; b=etLMfGxpRVWAy4vQ/xhfm4SfJJmlo6iK+kHbsG8WPG+1to0g8gBwNjgxcti6pjh4Ilr4V/TGTo5HRXzedSKe5X34wpxHr1npEhCugaihXjGvH5/QfmjU6UB++/sbrdJNrQfS2DkkNNWf3VZZ54OMSnjui3B79YIXsx5apxBvdHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764927333; c=relaxed/simple;
	bh=bAEv9NRUrhaLWdKKfgwUqOg8lsDX3mo3CZiMt+NA8/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r4pYu+JTRm6gpLs8pwxBqrPvgxeazV9jkFUkEYSgrDbjNajgovXgFxE8jVa7KrwmmJ/5Pxl3Nnjq4Fq2XAWgq+RJYFqxZSpIkORMDfY385PFSZJ81eFYCyn/IX36ZnbPAiZ8Xpg1+/a3VeoKSNKvucphNWOTMa8r/hTNN90Gry4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=ShZigmyH; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=URUDjWal6cKcs4QGjFVFGtfPyi+Q8+b5VkS9luErQj0=; b=ShZigmyHOwxiNjXcWtPW38ARJq
	VJhIkKvrEx35I8kbXGjJ1s5pknqd9+PLjAw4vepLkSzhqe5IINOL2yipe4C9uUaKKDAdEkkcjD62h
	LpWUOZzch9sJmpoo1+eHN7Z+kaMG26dvLYQtsPdZ/iG3IIuCGgZkhYxnyvPN0LiTmvOW+f/+2tV6H
	7gSgN/hQRAu7QO8HvwrDbhP/zvHKyZVGpMxxO+jMHEbbWRvxsj3xwCA53BK8J+4Unte51sPhJRPzD
	s5f/w3CDEXwJumDynf7WTkVkNpZx8WY/Ota1NtAvcSZjOK2mkWxdnmiANQN0yAOwTDpSzcKsESDYi
	2x5pa6eA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:52364)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vRSDO-000000004RF-2YkX;
	Fri, 05 Dec 2025 09:35:02 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vRSDH-000000001wJ-0RBt;
	Fri, 05 Dec 2025 09:34:55 +0000
Date: Fri, 5 Dec 2025 09:34:54 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Yao Zi <ziyao@disroot.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
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
Message-ID: <aTKnPvJUjGyyueH4@shell.armlinux.org.uk>
References: <20251124163211.54994-1-ziyao@disroot.org>
 <20251124163211.54994-3-ziyao@disroot.org>
 <aSSspDCPM_5-l24a@shell.armlinux.org.uk>
 <aTJuNk4zF8CLtt9S@pie>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aTJuNk4zF8CLtt9S@pie>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Dec 05, 2025 at 05:31:34AM +0000, Yao Zi wrote:
> Hi Russell,
> 
> Sorry for the late reply,
> 
> On Mon, Nov 24, 2025 at 07:06:12PM +0000, Russell King (Oracle) wrote:
> > On Mon, Nov 24, 2025 at 04:32:10PM +0000, Yao Zi wrote:
> > > +static int motorcomm_setup_irq(struct pci_dev *pdev,
> > > +			       struct stmmac_resources *res,
> > > +			       struct plat_stmmacenet_data *plat)
> > > +{
> > > +	int ret;
> > > +
> > > +	ret = pci_alloc_irq_vectors(pdev, 6, 6, PCI_IRQ_MSIX);
> > > +	if (ret > 0) {
> > > +		res->rx_irq[0]	= pci_irq_vector(pdev, 0);
> > > +		res->tx_irq[0]	= pci_irq_vector(pdev, 4);
> > > +		res->irq	= pci_irq_vector(pdev, 5);
> > > +
> > > +		plat->flags |= STMMAC_FLAG_MULTI_MSI_EN;
> > > +
> > > +		return 0;
> > > +	}
> > > +
> > > +	dev_info(&pdev->dev, "failed to allocate MSI-X vector: %d\n", ret);
> > > +	dev_info(&pdev->dev, "try MSI instead\n");
> > > +
> > > +	ret = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_MSI);
> > > +	if (ret < 0)
> > > +		return dev_err_probe(&pdev->dev, ret,
> > > +				     "failed to allocate MSI\n");
> > > +
> > > +	res->irq = pci_irq_vector(pdev, 0);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int motorcomm_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> > > +{
> > ...
> > > +	ret = motorcomm_setup_irq(pdev, &res, plat);
> > > +	if (ret)
> > > +		return dev_err_probe(&pdev->dev, ret, "failed to setup IRQ\n");
> > > +
> > > +	motorcomm_init(priv);
> > > +
> > > +	res.addr = priv->base + GMAC_OFFSET;
> > > +
> > > +	return stmmac_dvr_probe(&pdev->dev, plat, &res);
> > 
> > If stmmac_dvr_probe() fails, then it will return an error code. This
> > leaves the PCI MSI interrupt allocated...
> 
> This isn't true. MSI API is a little magical: when the device is enabled
> through pcim_enable_device(), the device becomes devres-managed, and
> a plain call to pci_alloc_irq_vectors() becomes managed, too, even if
> its name doesn't indicate it's a devres-managed API.
> 
> pci_free_irq_vectors() will be automatically called on driver deattach.
> See pcim_setup_msi_release() in drivers/pci/msi/msi.c, which is invoked
> by pci_alloc_irq_vectors() internally.

This looks very non-intuitive, and the documentation for
pci_alloc_irq_vectors() doesn't help:

 * Upon a successful allocation, the caller should use pci_irq_vector()
 * to get the Linux IRQ number to be passed to request_threaded_irq().
 * The driver must call pci_free_irq_vectors() on cleanup.
   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

because if what you say is correct (and it looks like it is) then this
line is blatently incorrect.

Bjorn?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!


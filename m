Return-Path: <netdev+bounces-243699-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E2C5CA6285
	for <lists+netdev@lfdr.de>; Fri, 05 Dec 2025 06:38:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EA687307CB34
	for <lists+netdev@lfdr.de>; Fri,  5 Dec 2025 05:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21A862EB85E;
	Fri,  5 Dec 2025 05:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="AoWgq5bL"
X-Original-To: netdev@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18122BE7A7;
	Fri,  5 Dec 2025 05:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764913107; cv=none; b=QB9hxih65xUcYu+2mY9lCgZJestJFHg1O+AqlCDZwUZVHf46+iU2h+Za02AzPIh5yuGuyJy0Y+RVEBFObcWQOx3w8JNE2WNZZcepZ5WiB6+2IMgwvh+hV3SuhFvJIIx4x9+mXyQTUWvvWVi03ygu7UI5fh75fUbSvOxTqOolZ0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764913107; c=relaxed/simple;
	bh=LTqdQcIw0CyyS+hNWi/YRC5a7hw6Ig/qdpkgBxzJvhw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DuDx6TLgWfNDncmXbTebncsiFIB/O7w+gKf9p3IQKPItoeOoQI2MSeV13H5c0GHNRIvlAmWFeyR3ryxZfeCwkqpNrKYWspf5JxubHWz7FlyvrWANpKJOnsbdglrw53P9lAt+NSLRCTGzN6VzbH/CU0qrBogO0eSOa5L6sALnl4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=AoWgq5bL; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 3ACF326704;
	Fri,  5 Dec 2025 06:32:08 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YAoeXpJ_KLyK; Fri,  5 Dec 2025 06:32:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1764912727; bh=LTqdQcIw0CyyS+hNWi/YRC5a7hw6Ig/qdpkgBxzJvhw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AoWgq5bLk6SRn6UD7TZAkLZVKJB7DN+m0cKoxIqJ0d/ipCVtf56SMQjPor1HME1p0
	 2llN3hO3HtmojZclQzOq6R1CI5k9mxkPX//8/j4HeRwaptfLVPp9Lo0B9V83hMUPSw
	 FuT7k3Hljv72lZubAy9Z0OpUhWzAULHhDwbsAP93xyowbr8vndKmGvx2AmhFuYUFEP
	 xUh+BUSSngfL1LDhjIQ814REnHWzuGTiBtd2nerM6okLO7UMhw16qfO8kgrr0mumep
	 zB8Gc/b5E7etHusGbKSDg3Xxoq0cIdkw1duKBOzEIdb2aeqO9lFNTkRHa43SpH85mk
	 8mIgLxPiiPOxA==
Date: Fri, 5 Dec 2025 05:31:34 +0000
From: Yao Zi <ziyao@disroot.org>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
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
Message-ID: <aTJuNk4zF8CLtt9S@pie>
References: <20251124163211.54994-1-ziyao@disroot.org>
 <20251124163211.54994-3-ziyao@disroot.org>
 <aSSspDCPM_5-l24a@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aSSspDCPM_5-l24a@shell.armlinux.org.uk>

Hi Russell,

Sorry for the late reply,

On Mon, Nov 24, 2025 at 07:06:12PM +0000, Russell King (Oracle) wrote:
> On Mon, Nov 24, 2025 at 04:32:10PM +0000, Yao Zi wrote:
> > +static int motorcomm_setup_irq(struct pci_dev *pdev,
> > +			       struct stmmac_resources *res,
> > +			       struct plat_stmmacenet_data *plat)
> > +{
> > +	int ret;
> > +
> > +	ret = pci_alloc_irq_vectors(pdev, 6, 6, PCI_IRQ_MSIX);
> > +	if (ret > 0) {
> > +		res->rx_irq[0]	= pci_irq_vector(pdev, 0);
> > +		res->tx_irq[0]	= pci_irq_vector(pdev, 4);
> > +		res->irq	= pci_irq_vector(pdev, 5);
> > +
> > +		plat->flags |= STMMAC_FLAG_MULTI_MSI_EN;
> > +
> > +		return 0;
> > +	}
> > +
> > +	dev_info(&pdev->dev, "failed to allocate MSI-X vector: %d\n", ret);
> > +	dev_info(&pdev->dev, "try MSI instead\n");
> > +
> > +	ret = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_MSI);
> > +	if (ret < 0)
> > +		return dev_err_probe(&pdev->dev, ret,
> > +				     "failed to allocate MSI\n");
> > +
> > +	res->irq = pci_irq_vector(pdev, 0);
> > +
> > +	return 0;
> > +}
> > +
> > +static int motorcomm_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> > +{
> ...
> > +	ret = motorcomm_setup_irq(pdev, &res, plat);
> > +	if (ret)
> > +		return dev_err_probe(&pdev->dev, ret, "failed to setup IRQ\n");
> > +
> > +	motorcomm_init(priv);
> > +
> > +	res.addr = priv->base + GMAC_OFFSET;
> > +
> > +	return stmmac_dvr_probe(&pdev->dev, plat, &res);
> 
> If stmmac_dvr_probe() fails, then it will return an error code. This
> leaves the PCI MSI interrupt allocated...

This isn't true. MSI API is a little magical: when the device is enabled
through pcim_enable_device(), the device becomes devres-managed, and
a plain call to pci_alloc_irq_vectors() becomes managed, too, even if
its name doesn't indicate it's a devres-managed API.

pci_free_irq_vectors() will be automatically called on driver deattach.
See pcim_setup_msi_release() in drivers/pci/msi/msi.c, which is invoked
by pci_alloc_irq_vectors() internally.

> > +}
> > +
> > +static void motorcomm_remove(struct pci_dev *pdev)
> > +{
> > +	stmmac_dvr_remove(&pdev->dev);
> > +	pci_free_irq_vectors(pdev);
> 
> ... which stood out because of the presence of this function doing
> stuff after the call to stmmac_dvr_remove().

But yes, this call to pci_free_irq_vectors() is redundant, since
pci_free_irq_vectors() will be automatically invoked. I'll remove it in
the next version.

> So... reviewing the other stmmac PCI drivers:
> 
> - dwmac-intel calls pci_alloc_irq_vectors() but does not call
>   pci_free_irq_vectors(). This looks like a bug.

The driver does call pcim_enable_device() thus enables devres for the
PCI device, in which case manually calling pci_free_irq_vectors() is
unnecessary. I don't think there's a bug.

> - dwmac-intel calls pcim_enable_device() in its probe function, and
>   also its intel_eth_pci_resume() - pcim_enable_device() is the devres
>   managed function, so we end up adding more and more devres entries
>   each time intel_eth_pci_resume() is resumed. Note that
>   intel_eth_pci_suspend() doesn't disable the device. So, this should
>   probably be the non-devres version.

Agree.

> - dwmac-loongson looks sane, but the checks for ld->multichan before
>   calling loongson_dwmac_msi_clear() look unnecessary, as
>   pci_free_irq_vectors() can be safely called even if MSI/MSI-X have
>   not been (successfully) allocated.

loongson-dwmac doesn't enable devres for the PCI device (it calls
pci_enable_device() instead), so manually freeing the interrupts is
indeed necessary. However, I'd suggest moving to the devres variant and
simplify the error handling (and clean up) path.

> So, I wonder whether there is scope to have a common way to clean up
> PCI drivers. Could you look into this please?

In short, enabling the device with pcim_enable_device() to make it
devres-managed should be the best solution, in which case
pci_alloc_irq_vectors() is devres-managed, too, and at least we don't
need to worry about interrupts anymore on error handling/removal path.

Regards,
Yao Zi

> -- 
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!


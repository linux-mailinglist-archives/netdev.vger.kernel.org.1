Return-Path: <netdev+bounces-243882-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D632CA97C0
	for <lists+netdev@lfdr.de>; Fri, 05 Dec 2025 23:21:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C1C02328A74C
	for <lists+netdev@lfdr.de>; Fri,  5 Dec 2025 22:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 144C72EB5DC;
	Fri,  5 Dec 2025 22:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FxrTPDcE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E171513C918;
	Fri,  5 Dec 2025 22:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764972991; cv=none; b=Wq0qsPDgwhoJVE3Vsx7tpG82X54HpDQ917PXSHXEHbt6orpGLtS72Al/x0EaRQSIGAdd6fUrke54ZLFVmdmvHiza75zC9q3QBymgYN7Fdagj2O3HkmKbGyYIXxAZpUG5uk5RQRsQQy2zECN5WXuXrr7pUjPIweS6C3F3ElbsSBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764972991; c=relaxed/simple;
	bh=EwMfZKLt4WHien9TB78OXU15926X49rO5k+7pKGyCl8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=W4kFY93i1tfEBvU0+sMZ0kaMBx8dkBsxHwouMCgM2r19Vbq4P7DjUd/n7GD2fyFot94DwftbCDhKSEb/oILWDBFcEmKLYpAJ9dv8YeU+h2A/4d9XoKZ7RbX/BF1rogkqRr8eOCKP9avhCR3GV1IOU1hI6Kk4YTQkzRq5PUZwfjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FxrTPDcE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5ED2C4CEF1;
	Fri,  5 Dec 2025 22:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764972990;
	bh=EwMfZKLt4WHien9TB78OXU15926X49rO5k+7pKGyCl8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=FxrTPDcEJknCnWIpLFQFbbw/9DFUJE/14QUW5l8Y3sOfIkTBt+gnToFDx7tW2zcUQ
	 KbQSgw7C97LTU/vs4L+7BuGCjtfVTlZoOEz9+Ixh22YLanviGIettV2sjAfWy74vEz
	 zgiYNtcP19bPL9gT79S8lj+w9MlSbLCNKSFxCiGxLfdEFCy2PWbecVxOPszbOjDfl0
	 tLXRIY0ablqnAFDn1rCAIzqvNxDeHsXHiwUnhu/VwVCixcTGUdUOphCuS0XelOa7yP
	 uAFWU8DFva7141UEyV+s36EKoBKRu4khbsUktp9yj1Rt2bbajw5Qq3x/66Rcg63Zky
	 V819GaJIKeSNQ==
Date: Fri, 5 Dec 2025 16:16:29 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>,
	Philipp Stanner <phasta@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: Yao Zi <ziyao@disroot.org>, Bjorn Helgaas <bhelgaas@google.com>,
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
Message-ID: <20251205221629.GA3294018@bhelgaas>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aTKnPvJUjGyyueH4@shell.armlinux.org.uk>

[+to Philipp, Thomas for MSI devres question]

On Fri, Dec 05, 2025 at 09:34:54AM +0000, Russell King (Oracle) wrote:
> On Fri, Dec 05, 2025 at 05:31:34AM +0000, Yao Zi wrote:
> > On Mon, Nov 24, 2025 at 07:06:12PM +0000, Russell King (Oracle) wrote:
> > > On Mon, Nov 24, 2025 at 04:32:10PM +0000, Yao Zi wrote:
> > > > +static int motorcomm_setup_irq(struct pci_dev *pdev,
> > > > +			       struct stmmac_resources *res,
> > > > +			       struct plat_stmmacenet_data *plat)
> > > > +{
> > > > +	int ret;
> > > > +
> > > > +	ret = pci_alloc_irq_vectors(pdev, 6, 6, PCI_IRQ_MSIX);
> > > > +	if (ret > 0) {
> > > > +		res->rx_irq[0]	= pci_irq_vector(pdev, 0);
> > > > +		res->tx_irq[0]	= pci_irq_vector(pdev, 4);
> > > > +		res->irq	= pci_irq_vector(pdev, 5);
> > > > +
> > > > +		plat->flags |= STMMAC_FLAG_MULTI_MSI_EN;
> > > > +
> > > > +		return 0;
> > > > +	}
> > > > +
> > > > +	dev_info(&pdev->dev, "failed to allocate MSI-X vector: %d\n", ret);
> > > > +	dev_info(&pdev->dev, "try MSI instead\n");
> > > > +
> > > > +	ret = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_MSI);
> > > > +	if (ret < 0)
> > > > +		return dev_err_probe(&pdev->dev, ret,
> > > > +				     "failed to allocate MSI\n");
> > > > +
> > > > +	res->irq = pci_irq_vector(pdev, 0);
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +static int motorcomm_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> > > > +{
> > > ...
> > > > +	ret = motorcomm_setup_irq(pdev, &res, plat);
> > > > +	if (ret)
> > > > +		return dev_err_probe(&pdev->dev, ret, "failed to setup IRQ\n");
> > > > +
> > > > +	motorcomm_init(priv);
> > > > +
> > > > +	res.addr = priv->base + GMAC_OFFSET;
> > > > +
> > > > +	return stmmac_dvr_probe(&pdev->dev, plat, &res);
> > > 
> > > If stmmac_dvr_probe() fails, then it will return an error code. This
> > > leaves the PCI MSI interrupt allocated...
> > 
> > This isn't true. MSI API is a little magical: when the device is enabled
> > through pcim_enable_device(), the device becomes devres-managed, and
> > a plain call to pci_alloc_irq_vectors() becomes managed, too, even if
> > its name doesn't indicate it's a devres-managed API.
> > 
> > pci_free_irq_vectors() will be automatically called on driver deattach.
> > See pcim_setup_msi_release() in drivers/pci/msi/msi.c, which is invoked
> > by pci_alloc_irq_vectors() internally.
> 
> This looks very non-intuitive, and the documentation for
> pci_alloc_irq_vectors() doesn't help:
> 
>  * Upon a successful allocation, the caller should use pci_irq_vector()
>  * to get the Linux IRQ number to be passed to request_threaded_irq().
>  * The driver must call pci_free_irq_vectors() on cleanup.
>    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
> because if what you say is correct (and it looks like it is) then this
> line is blatently incorrect.
> 
> Bjorn?


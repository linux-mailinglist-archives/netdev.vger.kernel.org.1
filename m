Return-Path: <netdev+bounces-94643-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 121ED8C00A4
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 17:10:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9112C1F223BC
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 15:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF22886AE2;
	Wed,  8 May 2024 15:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QaCi6fIw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE33B74E09
	for <netdev@vger.kernel.org>; Wed,  8 May 2024 15:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715181026; cv=none; b=NzX6B7Lht2+Jb0Q0nstOfULAt8sqwHMHcrhEJQ+6/TPDGwqBJ7uByBd+7bfo8vdzDfAvkftNua2kqV8bP7/IO//Tzf6uDOIpr9qrJSunEdSPEP7/lscugpWUFMjta1W63lDJZ6EXm6bFByfrP0WH7ln+ErlIWWE1rJriwU+jV2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715181026; c=relaxed/simple;
	bh=v+xYHmsTxYFkuN5YXSuw4OpOVSlg+1laNTiGuTRYe+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eUM3y3GAVwhdHb0v1LC0j9WyKX3mzTMc6GGsXS5iNWKVWIIbJrHZyLOQwnHdI8OVNpaufj0TXDq24WtpxfCSJttupwA8wD/cTUFdRupzmSm1LcP6SwJqJPTrn8K5lGwABUt1Ij4LcWmzaZ6Pj6tdW/QDV3ADk+BJx0+Map+xLvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QaCi6fIw; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2df848f9325so51885191fa.1
        for <netdev@vger.kernel.org>; Wed, 08 May 2024 08:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715181023; x=1715785823; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=F01Ap78JD2tU8lLUbYzKh+x/DHATSJTtDVfjMl+xf2k=;
        b=QaCi6fIw0pW9ySKfxCOjZjAw+SjHEYIXYgTqIYZoThyMZwzNujhhEzgwV5E4bl9J5X
         0ERiH5TUX2FUr3Vr2voO1zX85wdxi3VqOfe5yqLCmKa3fOIM65Wf3s6rELYwz9iB4JZD
         xP9bQ8KQ+S1xuaUBXfsz2TAoQCA8mXhpJJCEBqJChCjhZzYAj1fNKR3w9xTnPv/5d1yv
         Gf2yWmQVb5tf+ciLzZwAMpGSbi/uCRCbBjk0guQlgQ0TIwR+v+7M0B4FJ1GcZW3fwWYQ
         VZO26YmnqNKmvJjessgoeNYdTdvMs2g3P0HSpevQrEgoqy8KCs2Wy1eNk6tq5e1bqJiX
         WB/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715181023; x=1715785823;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F01Ap78JD2tU8lLUbYzKh+x/DHATSJTtDVfjMl+xf2k=;
        b=N6Ts2+ACwVnyQhAM/EcjOlFkZAUWfEBpJkmHgWHRTLEziPgaImx4qH05DeHrnIdhyB
         8/S9RPr1jfltgv2vhgfDOpZKv/9G+p1XcKxEcoWxtTGMpFnDyVi/dtWyBxJAd7V0UwH0
         HJCbKYhhMWg6vRTV/EhOtNDFetgVk1KF0okbxSUwthNsYBN1olbza2Z45jLBZFBUp8gj
         875j+wystppty3XfOn9d+jUqtm0Bn1/mR9vxHvJ+JLAHRNgAmJFWHihy0kQsX6Z+cDQz
         iOfUkNDZ5+0i95ulbocDgaFbDT9fNz+SgrAka8QtLU+vC964cYwEbSlcojwY8ZD4ZyVa
         65fw==
X-Forwarded-Encrypted: i=1; AJvYcCXej9zhEN7LG6AlrByjK3sCIMKU9Cw2jMZvmRMwBJ6oskHHdTUKBAv+PfPgtXTshAooa0qyHCLxFno73E1UmJ0BltjMglhd
X-Gm-Message-State: AOJu0Yxqb0gkxKY6XfcFDHQscEB9y5sUQdaQYU6755ROmFjohga/cKFq
	N7IhPDu2jSHi22bUncOw5fsZ+jzm5p1AANPNY43Nr3eAgKlsbXuo
X-Google-Smtp-Source: AGHT+IFvzjBdy51lxuNvHZuUWc8Vhon/7lkdSRdEIY5a2iMY4uiSzVEm+bNvXilVkED+QUT5YgltaA==
X-Received: by 2002:a05:651c:542:b0:2df:6e6d:2c22 with SMTP id 38308e7fff4ca-2e4476b48abmr21958821fa.47.1715181022425;
        Wed, 08 May 2024 08:10:22 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id y9-20020a05651c106900b002e37121abcbsm1230739ljm.36.2024.05.08.08.10.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 08:10:22 -0700 (PDT)
Date: Wed, 8 May 2024 18:10:18 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Yanteng Si <siyanteng@loongson.cn>, andrew@lunn.ch, 
	hkallweit1@gmail.com, peppe.cavallaro@st.com, alexandre.torgue@foss.st.com, 
	joabreu@synopsys.com, Jose.Abreu@synopsys.com, linux@armlinux.org.uk, 
	guyinggang@loongson.cn, netdev@vger.kernel.org, chris.chenfeiyang@gmail.com, 
	siyanteng01@gmail.com
Subject: Re: [PATCH net-next v12 13/15] net: stmmac: dwmac-loongson: Add
 Loongson GNET support
Message-ID: <tbjruh7sx7zovj4ypvfmer3tkgp63zrwhsaxj6hpcfc7ljaqes@zyd3acrqchik>
References: <cover.1714046812.git.siyanteng@loongson.cn>
 <c97cb15ab77fb9dfdd281640f48dcfc08c6988c0.1714046812.git.siyanteng@loongson.cn>
 <jkjgjraqvih4zu7wvqykerq5wisgkhqf2n2pouha7qhfoeif7v@tkwyx53dfrdw>
 <150b03ff-70b5-488a-b5e6-5f74b6398b20@loongson.cn>
 <pdyqoki5qw4zabz3uv5ff2e2o43htcr6xame652zmbqh23tjji@lt5gmp6m3lkm>
 <CAAhV-H7Dz0CVysUVVVe4Y8qGxpmwJ0i6y2wKnATzNS=5DR_vZg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAhV-H7Dz0CVysUVVVe4Y8qGxpmwJ0i6y2wKnATzNS=5DR_vZg@mail.gmail.com>

On Wed, May 08, 2024 at 10:58:16PM +0800, Huacai Chen wrote:
> Hi, Serge,
> 
> On Wed, May 8, 2024 at 10:38 PM Serge Semin <fancer.lancer@gmail.com> wrote:
> >
> > On Tue, May 07, 2024 at 09:35:24PM +0800, Yanteng Si wrote:
> > > Hi Serge,
> > >
> > > 在 2024/5/6 18:39, Serge Semin 写道:
> > > > On Thu, Apr 25, 2024 at 09:11:36PM +0800, Yanteng Si wrote:
> > > > > ...
> > > > > +static int loongson_dwmac_config_msi(struct pci_dev *pdev,
> > > > > +                              struct plat_stmmacenet_data *plat,
> > > > > +                              struct stmmac_resources *res,
> > > > > +                              struct device_node *np)
> > > > > +{
> > > > > + int i, ret, vecs;
> > > > > +
> > > > > + vecs = roundup_pow_of_two(CHANNEL_NUM * 2 + 1);
> > > > > + ret = pci_alloc_irq_vectors(pdev, vecs, vecs, PCI_IRQ_MSI);
> > > > > + if (ret < 0) {
> > > > > +         dev_info(&pdev->dev,
> > > > > +                  "MSI enable failed, Fallback to legacy interrupt\n");
> > > > > +         return loongson_dwmac_config_legacy(pdev, plat, res, np);
> > > > > + }
> > > > > +
> > > > > + res->irq = pci_irq_vector(pdev, 0);
> > > > > + res->wol_irq = 0;
> > > > > +
> > > > > + /* INT NAME | MAC | CH7 rx | CH7 tx | ... | CH0 rx | CH0 tx |
> > > > > +  * --------- ----- -------- --------  ...  -------- --------
> > > > > +  * IRQ NUM  |  0  |   1    |   2    | ... |   15   |   16   |
> > > > > +  */
> > > > > + for (i = 0; i < CHANNEL_NUM; i++) {
> > > > > +         res->rx_irq[CHANNEL_NUM - 1 - i] =
> > > > > +                 pci_irq_vector(pdev, 1 + i * 2);
> > > > > +         res->tx_irq[CHANNEL_NUM - 1 - i] =
> > > > > +                 pci_irq_vector(pdev, 2 + i * 2);
> > > > > + }
> > > > > +
> > > > > + plat->flags |= STMMAC_FLAG_MULTI_MSI_EN;
> > > > > +
> > > > > + return 0;
> > > > > +}
> > > > > +
> > > > > ...
> > > > >   static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> > > > >   {
> > > > >           struct plat_stmmacenet_data *plat;
> > > > >           int ret, i, bus_id, phy_mode;
> > > > >           struct stmmac_pci_info *info;
> > > > >           struct stmmac_resources res;
> > > > > + struct loongson_data *ld;
> > > > >           struct device_node *np;
> > > > >           np = dev_of_node(&pdev->dev);
> > > > > @@ -122,10 +460,12 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
> > > > >                   return -ENOMEM;
> > > > >           plat->dma_cfg = devm_kzalloc(&pdev->dev, sizeof(*plat->dma_cfg), GFP_KERNEL);
> > > > > - if (!plat->dma_cfg) {
> > > > > -         ret = -ENOMEM;
> > > > > -         goto err_put_node;
> > > > > - }
> > > > > + if (!plat->dma_cfg)
> > > > > +         return -ENOMEM;
> > > > > +
> > > > > + ld = devm_kzalloc(&pdev->dev, sizeof(*ld), GFP_KERNEL);
> > > > > + if (!ld)
> > > > > +         return -ENOMEM;
> > > > >           /* Enable pci device */
> > > > >           ret = pci_enable_device(pdev);
> > > > > @@ -171,14 +511,34 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
> > > > >                   plat->phy_interface = phy_mode;
> > > > >           }
> > > > > - pci_enable_msi(pdev);
> > > > > + plat->bsp_priv = ld;
> > > > > + plat->setup = loongson_dwmac_setup;
> > > > > + ld->dev = &pdev->dev;
> > > > > +
> > > > >           memset(&res, 0, sizeof(res));
> > > > >           res.addr = pcim_iomap_table(pdev)[0];
> > > > > + ld->gmac_verion = readl(res.addr + GMAC_VERSION) & 0xff;
> > > > > +
> > > > > + switch (ld->gmac_verion) {
> > > > > + case LOONGSON_DWMAC_CORE_1_00:
> > > > > +         plat->rx_queues_to_use = CHANNEL_NUM;
> > > > > +         plat->tx_queues_to_use = CHANNEL_NUM;
> > > > > +
> > > > > +         /* Only channel 0 supports checksum,
> > > > > +          * so turn off checksum to enable multiple channels.
> > > > > +          */
> > > > > +         for (i = 1; i < CHANNEL_NUM; i++)
> > > > > +                 plat->tx_queues_cfg[i].coe_unsupported = 1;
> > > > > - plat->tx_queues_to_use = 1;
> > > > > - plat->rx_queues_to_use = 1;
> > > > > +         ret = loongson_dwmac_config_msi(pdev, plat, &res, np);
> > > > > +         break;
> > > > > + default:        /* 0x35 device and 0x37 device. */
> > > > > +         plat->tx_queues_to_use = 1;
> > > > > +         plat->rx_queues_to_use = 1;
> > > > > - ret = loongson_dwmac_config_legacy(pdev, plat, &res, np);
> > > > > +         ret = loongson_dwmac_config_legacy(pdev, plat, &res, np);
> > > > > +         break;
> > > > > + }
> > > > Let's now talk about this change.
> > > >
> > > > First of all, one more time. You can't miss the return value check
> > > > because if any of the IRQ config method fails then the driver won't
> > > > work! The first change that introduces the problem is in the patch
> > > > [PATCH net-next v12 11/15] net: stmmac: dwmac-loongson: Add loongson_dwmac_config_legacy
> > > OK!
> > > >
> > > > Second, as I already mentioned in another message sent to this patch
> > > > you are missing the PCI MSI IRQs freeing in the cleanup-on-error path
> > > > and in the device/driver remove() function. It's definitely wrong.
> > > You are right! I will do it.
> > > > Thirdly, you said that the node-pointer is now optional and introduced
> > > > the patch
> > > > [PATCH net-next v12 10/15] net: stmmac: dwmac-loongson: Add full PCI support
> > > > If so and the DT-based setting up isn't mandatory then I would
> > > > suggest to proceed with the entire so called legacy setups only if the
> > > > node-pointer has been found, otherwise the pure PCI-based setup would
> > > > be performed. So the patches 10-13 (in your v12 order) would look
> > >
> > > In this case, MSI will not be enabled when the node-pointer is found.
> > >
> > > .
> > >
> > >
> > > In fact, a large fraction of 2k devices are DT-based, of course, many are
> > > PCI-based.
> >
> > Then please summarise which devices need the DT-node pointer which
> > don't? And most importantly if they do why do they need the DT-node?

> Whether we need DT-nodes doesn't depend on device type, but depends on
> the BIOS type. When we boot with UEFI+ACPI, we don't need DT-node,
> when we boot with PMON+FDT, we need DT-node. Loongson machines may
> have either BIOS types.

Thanks for the answer. Just to fully clarify. Does it mean that all
Loongson Ethernet controllers (Loongson GNET and GMAC) are able to
deliver both PCI MSI IRQs and direct GIC IRQs (so called legacy)?

-Serge(y)

> 
> Huacai
> 
> >
> > AFAICS currently both LS2K1000 and LS7A1000 GMACs require the DT-node
> > to get the MAC and LPI IRQ signals. AFAICS from your series LS7A2000
> > GNET is also DT-based for the same reason. But the LS2K2000 GNET case
> > is different. You say that some of the platforms have the respective
> > DT-node some don't, but at the same time you submitting this patch
> > which permits the MSI IRQs only for the LS7A2000 GNET. It looks
> > contradicting. Does it mean that the GNET devices may generate the
> > IRQs via both legacy (an IRQ signal directly connected to the system
> > GIC) and the PCI MSI ways?
> >
> > Let's get the question to the more generic level. Are the Loongson
> > GNET and GMAC controllers able to generate the IRQs via both ways:
> > physical IRQ signal and PCI MSI?
> >
> > Please don't consider this as a vastly meticulous review. I am just
> > trying to figure out how to make things less complicated and fix the
> > driver to permitting only the cases which are actually possible.
> >
> > -Serge(y)
> >
> > >
> > >
> > > Thanks,
> > >
> > > Yanteng
> > >
> > >


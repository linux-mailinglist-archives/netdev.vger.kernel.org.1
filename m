Return-Path: <netdev+bounces-96093-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E8CE8C44DE
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 18:11:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 105561F21E8F
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 16:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B26DD155331;
	Mon, 13 May 2024 16:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KNyBrV4q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C73C15532B
	for <netdev@vger.kernel.org>; Mon, 13 May 2024 16:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715616684; cv=none; b=ZiQYbEjqhkX0CpCp/8AwWpgOpwYN0H33dR4FwHfIisZTsKLfYcplboqLbwYHo3AFfeDQC7UD4AQBo4McI9vSjXVeDyApGnAKDUVzVBV0whSxG5nO6GQZS7UNg6HEdzsah4FSLZBLE+NGQh158qNsJLMUZWk25wQUkGc4NB/nZZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715616684; c=relaxed/simple;
	bh=jWw9sRkhzhlEvAQgdmZXMmdut6hetEj4jiyqFCEyN4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TSYRwSN8zv09d53eziWQW9HKOcUkZqGeVfDRdK5vgM9sy4k+GAGsl0hMR+NMU2gf6UU6AVBZB/8HXgB95026cRiZI/0/cYioixHaZhjO6KLI0LFbOKr5qJdtlBiwXpXvWnEZwRJ2dCctqRwQEtWU2mNdxxLkamDEPw+SiSEzm7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KNyBrV4q; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-51f1b378ca5so7835898e87.1
        for <netdev@vger.kernel.org>; Mon, 13 May 2024 09:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715616681; x=1716221481; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JBv3lXXewSsqlaqlyDfeM7oXdlNLtRRq5W5t5n4uMHg=;
        b=KNyBrV4qvACrdT74Hp7ePV36pNRDr0YHfmljrFZzX8T2IIEn/TnMRhczw5RkU/YDIx
         KGw0KDJa8EHw6QkEPlzs0DVIuJxBrhfJArSA3244vcae13/LybHJxTSER9SMhnCbovdi
         vBh6k0yr43jJ2zCW6fkaw7WJf8+WLFLmMfdOLfcZHmiqWvEt/tH3uK9pAwv/hx7+4N0H
         u5cSHuUh3b8dqRzQKpwtq+hQTx5I6tMiQKY0kCLotnOcTzblVMsoKMsnUELZvCJPfOln
         QZV3QC3pztV5BGJvKy5VKUVZCZAkqE6lzcSiP9W0qtoVkwtlQbRKlojg+nn5cn7mg6KN
         WdiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715616681; x=1716221481;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JBv3lXXewSsqlaqlyDfeM7oXdlNLtRRq5W5t5n4uMHg=;
        b=pei2azA74MGFu3MjHb9awMl9j1+zUc+7r297jF3hpH5iO+feC3iloNyk8+QNO7rbeY
         h+b08dBa9mJa9rcuXJa0+WpLMfZdk9aGNhWkymt+gA0Q0M1JnsX1KkLOjLIOrxnu8ZUe
         +dQye+Lhd/AtSqXReQnwxZhw+/keRuKg5f+3ZwcZJncU2DJrxj+yZKH/COmr3hiiwYnb
         JxHLjup/AO84lS0i3kMJ64rdm8jMGNiQrOC07yrAlx4WSOJyH38HnS1Kv/haB4RRD5oa
         0CLJeiIJB3iloFDkofv+Jt5IMa3NXxePdWGvm3pxCca7V3GcPegkt13pkVmCy26DSSJ3
         IW8Q==
X-Forwarded-Encrypted: i=1; AJvYcCW3kyIxuerB/avV/yIw/JIMMwjtPWDjWNBj1hvRnGU0jCxxe4uUBQDRbGHrrOGhR0k4mK2NRLGZ8mOXBQZepLTt4mRVWUjw
X-Gm-Message-State: AOJu0Yw20+0tHis76N+P5pL8YLdp2FEE8l/iX8ezREBCbREFjsCcpciZ
	epO6qu+e98WSoGgQY8hFuMjY3QkhG61FcAhU+dJOS5ktWxVdm3sO
X-Google-Smtp-Source: AGHT+IFKfM5Yc5z8aIGxW/HZ62CooGhWAbhCv3lG6sQgRFJnfzG2b31HVCQnMOGrol4Tjd+G+vWusw==
X-Received: by 2002:ac2:4c50:0:b0:51c:d1ac:c450 with SMTP id 2adb3069b0e04-5220fc7c5camr11163899e87.10.1715616680208;
        Mon, 13 May 2024 09:11:20 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-521f35ae015sm1786380e87.55.2024.05.13.09.11.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 09:11:19 -0700 (PDT)
Date: Mon, 13 May 2024 19:11:16 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Yanteng Si <siyanteng@loongson.cn>, andrew@lunn.ch, 
	hkallweit1@gmail.com, peppe.cavallaro@st.com, alexandre.torgue@foss.st.com, 
	joabreu@synopsys.com, Jose.Abreu@synopsys.com, linux@armlinux.org.uk, 
	guyinggang@loongson.cn, netdev@vger.kernel.org, chris.chenfeiyang@gmail.com, 
	siyanteng01@gmail.com
Subject: Re: [PATCH net-next v12 13/15] net: stmmac: dwmac-loongson: Add
 Loongson GNET support
Message-ID: <nt5bjlmul5jchxvx6zzgvbmdsegpwwz7quzt57vfejnxng7smz@abqdfipuclzh>
References: <cover.1714046812.git.siyanteng@loongson.cn>
 <c97cb15ab77fb9dfdd281640f48dcfc08c6988c0.1714046812.git.siyanteng@loongson.cn>
 <jkjgjraqvih4zu7wvqykerq5wisgkhqf2n2pouha7qhfoeif7v@tkwyx53dfrdw>
 <150b03ff-70b5-488a-b5e6-5f74b6398b20@loongson.cn>
 <pdyqoki5qw4zabz3uv5ff2e2o43htcr6xame652zmbqh23tjji@lt5gmp6m3lkm>
 <CAAhV-H7Dz0CVysUVVVe4Y8qGxpmwJ0i6y2wKnATzNS=5DR_vZg@mail.gmail.com>
 <tbjruh7sx7zovj4ypvfmer3tkgp63zrwhsaxj6hpcfc7ljaqes@zyd3acrqchik>
 <7b56eabc-53e1-4fbe-bf92-81bb1c91ddfc@loongson.cn>
 <kw7fb7mcy7ungrungmbe6z6rmfzswastesx66phtcxxez6vvgw@dal7dt2kj54u>
 <CAAhV-H4TtoV9LAfhx1+fu40XgDqQ+W-tXt36XoieK87_ucBgcQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAhV-H4TtoV9LAfhx1+fu40XgDqQ+W-tXt36XoieK87_ucBgcQ@mail.gmail.com>

On Mon, May 13, 2024 at 09:26:11PM +0800, Huacai Chen wrote:
> Hi, Serge,
> 
> On Mon, May 13, 2024 at 6:57 PM Serge Semin <fancer.lancer@gmail.com> wrote:
> >
> > On Thu, May 09, 2024 at 04:57:44PM +0800, Yanteng Si wrote:
> > > Hi Serge
> > >
> > > 在 2024/5/8 23:10, Serge Semin 写道:
> > > > On Wed, May 08, 2024 at 10:58:16PM +0800, Huacai Chen wrote:
> > > > > Hi, Serge,
> > > > >
> > > > > On Wed, May 8, 2024 at 10:38 PM Serge Semin<fancer.lancer@gmail.com>  wrote:
> > > > > > On Tue, May 07, 2024 at 09:35:24PM +0800, Yanteng Si wrote:
> > > > > > > Hi Serge,
> > > > > > >
> > > > > > > 在 2024/5/6 18:39, Serge Semin 写道:
> > > > > > > > On Thu, Apr 25, 2024 at 09:11:36PM +0800, Yanteng Si wrote:
> > > > > > > > > ...
> > > > > > > > > +static int loongson_dwmac_config_msi(struct pci_dev *pdev,
> > > > > > > > > +                              struct plat_stmmacenet_data *plat,
> > > > > > > > > +                              struct stmmac_resources *res,
> > > > > > > > > +                              struct device_node *np)
> > > > > > > > > +{
> > > > > > > > > + int i, ret, vecs;
> > > > > > > > > +
> > > > > > > > > + vecs = roundup_pow_of_two(CHANNEL_NUM * 2 + 1);
> > > > > > > > > + ret = pci_alloc_irq_vectors(pdev, vecs, vecs, PCI_IRQ_MSI);
> > > > > > > > > + if (ret < 0) {
> > > > > > > > > +         dev_info(&pdev->dev,
> > > > > > > > > +                  "MSI enable failed, Fallback to legacy interrupt\n");
> > > > > > > > > +         return loongson_dwmac_config_legacy(pdev, plat, res, np);
> > > > > > > > > + }
> > > > > > > > > +
> > > > > > > > > + res->irq = pci_irq_vector(pdev, 0);
> > > > > > > > > + res->wol_irq = 0;
> > > > > > > > > +
> > > > > > > > > + /* INT NAME | MAC | CH7 rx | CH7 tx | ... | CH0 rx | CH0 tx |
> > > > > > > > > +  * --------- ----- -------- --------  ...  -------- --------
> > > > > > > > > +  * IRQ NUM  |  0  |   1    |   2    | ... |   15   |   16   |
> > > > > > > > > +  */
> > > > > > > > > + for (i = 0; i < CHANNEL_NUM; i++) {
> > > > > > > > > +         res->rx_irq[CHANNEL_NUM - 1 - i] =
> > > > > > > > > +                 pci_irq_vector(pdev, 1 + i * 2);
> > > > > > > > > +         res->tx_irq[CHANNEL_NUM - 1 - i] =
> > > > > > > > > +                 pci_irq_vector(pdev, 2 + i * 2);
> > > > > > > > > + }
> > > > > > > > > +
> > > > > > > > > + plat->flags |= STMMAC_FLAG_MULTI_MSI_EN;
> > > > > > > > > +
> > > > > > > > > + return 0;
> > > > > > > > > +}
> > > > > > > > > +
> > > > > > > > > ...
> > > > > > > > >    static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> > > > > > > > >    {
> > > > > > > > >            struct plat_stmmacenet_data *plat;
> > > > > > > > >            int ret, i, bus_id, phy_mode;
> > > > > > > > >            struct stmmac_pci_info *info;
> > > > > > > > >            struct stmmac_resources res;
> > > > > > > > > + struct loongson_data *ld;
> > > > > > > > >            struct device_node *np;
> > > > > > > > >            np = dev_of_node(&pdev->dev);
> > > > > > > > > @@ -122,10 +460,12 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
> > > > > > > > >                    return -ENOMEM;
> > > > > > > > >            plat->dma_cfg = devm_kzalloc(&pdev->dev, sizeof(*plat->dma_cfg), GFP_KERNEL);
> > > > > > > > > - if (!plat->dma_cfg) {
> > > > > > > > > -         ret = -ENOMEM;
> > > > > > > > > -         goto err_put_node;
> > > > > > > > > - }
> > > > > > > > > + if (!plat->dma_cfg)
> > > > > > > > > +         return -ENOMEM;
> > > > > > > > > +
> > > > > > > > > + ld = devm_kzalloc(&pdev->dev, sizeof(*ld), GFP_KERNEL);
> > > > > > > > > + if (!ld)
> > > > > > > > > +         return -ENOMEM;
> > > > > > > > >            /* Enable pci device */
> > > > > > > > >            ret = pci_enable_device(pdev);
> > > > > > > > > @@ -171,14 +511,34 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
> > > > > > > > >                    plat->phy_interface = phy_mode;
> > > > > > > > >            }
> > > > > > > > > - pci_enable_msi(pdev);
> > > > > > > > > + plat->bsp_priv = ld;
> > > > > > > > > + plat->setup = loongson_dwmac_setup;
> > > > > > > > > + ld->dev = &pdev->dev;
> > > > > > > > > +
> > > > > > > > >            memset(&res, 0, sizeof(res));
> > > > > > > > >            res.addr = pcim_iomap_table(pdev)[0];
> > > > > > > > > + ld->gmac_verion = readl(res.addr + GMAC_VERSION) & 0xff;
> > > > > > > > > +
> > > > > > > > > + switch (ld->gmac_verion) {
> > > > > > > > > + case LOONGSON_DWMAC_CORE_1_00:
> > > > > > > > > +         plat->rx_queues_to_use = CHANNEL_NUM;
> > > > > > > > > +         plat->tx_queues_to_use = CHANNEL_NUM;
> > > > > > > > > +
> > > > > > > > > +         /* Only channel 0 supports checksum,
> > > > > > > > > +          * so turn off checksum to enable multiple channels.
> > > > > > > > > +          */
> > > > > > > > > +         for (i = 1; i < CHANNEL_NUM; i++)
> > > > > > > > > +                 plat->tx_queues_cfg[i].coe_unsupported = 1;
> > > > > > > > > - plat->tx_queues_to_use = 1;
> > > > > > > > > - plat->rx_queues_to_use = 1;
> > > > > > > > > +         ret = loongson_dwmac_config_msi(pdev, plat, &res, np);
> > > > > > > > > +         break;
> > > > > > > > > + default:        /* 0x35 device and 0x37 device. */
> > > > > > > > > +         plat->tx_queues_to_use = 1;
> > > > > > > > > +         plat->rx_queues_to_use = 1;
> > > > > > > > > - ret = loongson_dwmac_config_legacy(pdev, plat, &res, np);
> > > > > > > > > +         ret = loongson_dwmac_config_legacy(pdev, plat, &res, np);
> > > > > > > > > +         break;
> > > > > > > > > + }
> > > > > > > > Let's now talk about this change.
> > > > > > > >
> > > > > > > > First of all, one more time. You can't miss the return value check
> > > > > > > > because if any of the IRQ config method fails then the driver won't
> > > > > > > > work! The first change that introduces the problem is in the patch
> > > > > > > > [PATCH net-next v12 11/15] net: stmmac: dwmac-loongson: Add loongson_dwmac_config_legacy
> > > > > > > OK!
> > > > > > > > Second, as I already mentioned in another message sent to this patch
> > > > > > > > you are missing the PCI MSI IRQs freeing in the cleanup-on-error path
> > > > > > > > and in the device/driver remove() function. It's definitely wrong.
> > > > > > > You are right! I will do it.
> > > > > > > > Thirdly, you said that the node-pointer is now optional and introduced
> > > > > > > > the patch
> > > > > > > > [PATCH net-next v12 10/15] net: stmmac: dwmac-loongson: Add full PCI support
> > > > > > > > If so and the DT-based setting up isn't mandatory then I would
> > > > > > > > suggest to proceed with the entire so called legacy setups only if the
> > > > > > > > node-pointer has been found, otherwise the pure PCI-based setup would
> > > > > > > > be performed. So the patches 10-13 (in your v12 order) would look
> > > > > > > In this case, MSI will not be enabled when the node-pointer is found.
> > > > > > >
> > > > > > > .
> > > > > > >
> > > > > > >
> > > > > > > In fact, a large fraction of 2k devices are DT-based, of course, many are
> > > > > > > PCI-based.
> > > > > > Then please summarise which devices need the DT-node pointer which
> > > > > > don't? And most importantly if they do why do they need the DT-node?
> > > > > Whether we need DT-nodes doesn't depend on device type, but depends on
> > > > > the BIOS type. When we boot with UEFI+ACPI, we don't need DT-node,
> > > > > when we boot with PMON+FDT, we need DT-node. Loongson machines may
> > > > > have either BIOS types.
> > > > Thanks for the answer. Just to fully clarify. Does it mean that all
> > > > Loongson Ethernet controllers (Loongson GNET and GMAC) are able to
> > > > deliver both PCI MSI IRQs and direct GIC IRQs (so called legacy)?
> > >
> >
> > > No, only devices that support multiple channels can deliver both PCI MSI
> > > IRQs
> > >
> > > and direct GIC IRQs, other devices can only deliver GIC IRQs.
> > >
> > > Furthermore, multiple channel features are bundled with MSI. If we want to
> > >
> > > enable multiple channels, we must enable MSI.
> >
> > Sadly to say but this information changes a lot. Based on that the
> > only platform with optional DT-node is the LS2K2000 GNET device. The
> > rest of the devices (GMACs and LS7A2000 GNET) must be equipped with a
> > node-pointer otherwise they won't work. Due to that the logic of the
> > patches
> > [PATCH net-next v12 10/15] net: stmmac: dwmac-loongson: Add full PCI support
> > [PATCH net-next v12 11/15] net: stmmac: dwmac-loongson: Add loongson_dwmac_config_legacy
> > is incorrect.
> >
> > 1. [PATCH net-next v12 10/15] net: stmmac: dwmac-loongson: Add full PCI support
> > So this patch doesn't add a pure PCI-based probe procedure after all
> > because the Loongson GMACs are required to have a DT-node. AFAICS
> > pdev->irq is actually the IRQ retrieved from the DT-node. So the "if
> > (np) {} else {}" clause doesn't really make sense.
> >
> > 2. [PATCH net-next v12 11/15] net: stmmac: dwmac-loongson: Add loongson_dwmac_config_legacy
> > First of all the function name is incorrect. The IRQ signal isn't legacy
> > (INTx-based), but is retrieved from the DT-node. Secondly the
> > "if (np) {} else {}" statement is very much redundant because if no
> > DT-node found the pdev->irq won't be initialized at all, and the
> > driver won't work with no error printed.
> >
> > All of that also affects the patch/commit logs. Glad we figured that
> > out at this stage. Seeing there have been tons of another comments
> > let's postpone the discussion around this problem for v13 then. I'll
> > keep in mind the info you shared in this thread and think of the way
> > to fix the patches after v13 is submitted for review.
> Let me clarify the interrupt information, hope that can help you to
> understand better:

> 1, Loongson machines may use UEFI (implies ACPI) or PMON/UBOOT
> (implies FDT) as the BIOS.

Ok. Aside with the OF-based platform there is an ACPI case.

> 2, The BIOS type has no relationship with device types, which means:
> machines with GMAC can be either ACPI-based or FDT-based, machines
> with GNET can also be either ACPI-based or FDT-based.

Ok. It's either-or. Got it.

> 3, The existing Loongson driver can only support FDT, which means the
> device should be PCI-probed and DT-configured. Though the existing
> driver only supports GMAC, it doesn't mean that GMAC is bound to FDT.
> GMAC can also work with ACPI, in that case we say it is "full PCI",
> which means we don't need "np".

"full PCI" statement can't be utilized for the case of the ACPI-based
IRQ assignment. "full PCI" is the way the GNET probe procedure works -
everything required for the device handling is detected in runtime
with no ACPI/DT stuff.

So the patch 10 with the "full PCI"-related subject doesn't actually
adds the PCIe-only-based device probe support, but actually converts
the driver to supporting the ACPI-case.)

> 4, At present, multi-channel devices support MSI, currently only GNET
> support MSI, but in future there may also GMAC support MSI.

It's better to avoid adding a support for hypothetical devices and
prohibit all the currently unreal cases. It will simplify the code,
ease it' maintenance, reduce the bugs probability.

> 5, So, in Yanteng's patches, a device firstly request MSI, and since
> MSI is dynamically allocated, it doesn't care about the BIOS type
> (ACPI or FDT). However, if MSI fails (either because MSI is exhausted
> or the device doesn't support it), it fallback to "legacy" interrupt,
> which means irq lines mapped to INT-A/B/C/D of PCI.

Unless we are talking about the actual PCI devices (not PCI express)
or the cases where the INT-x is emulated by means the specific PCIe
TLPs, I wouldn't mentioned the INTx or "legacy" names in the current
context. It's just a platform ACPI/DT IRQs.

> 6. In the legacy case, the irq is get from DT-node (FDT case), or
> already in pdev->irq (ACPI case).

It will be in the pdev->irq in any case whether it's DT or ACPI. See:

ACPI:
pci_device_probe():
+-> arch/loongarch/pci/pci.c:pcibios_alloc_irq()

DT:
pci_device_probe():
+-> pci_assign_irq();
    +-> pci_host_bridge::map_irq()
        +-> of_irq_parse_and_map_pci()
        or in case of Loongson PCIe host controller:
        +-> drivers/pci/controller/pci-loongson.c::loongson_map_irq()

Moreover unless the MSI IRQs are enabled, the platform IRQ (and the
legacy IRQ) can be retrieved by means of the pci_irq_vector() method.
The only reason of having the direct OF-based IRQs getting in the
Loongson DWMAC driver I see is that the LPI IRQ will be missing in
case of the pci_irq_vector() method utilization. In the rest of the
cases the pci_irq_vector() function could be freely used.

>  So Yanteng use a "if (np) { } else {
> }", which is reasonable from my point of view.
> 

At least one problem is there. What if pdev->irq isn't initialized
(initialized with zero)?..

> So Yanteng's interrupt code is good for me, but I also agree to
> improve that after v13, if needed.

Ok. I've got much better picture about what is going on under the
hood. Thanks. In anyway I'll get back to this topic in details in v13.

-Serge(y)

> 
> Huacai
> 
> >
> > Thanks
> > -Serge(y)
> >
> > >
> > > Thanks,
> > >
> > > Yanteng
> > >


Return-Path: <netdev+bounces-96336-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E48F78C5343
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 13:44:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83686285E88
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 11:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29B9C6F077;
	Tue, 14 May 2024 11:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jFljaHvx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B5B1D54D
	for <netdev@vger.kernel.org>; Tue, 14 May 2024 11:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715686401; cv=none; b=aXDooMtRDDksSO6JcqYhfTaPOt1uVA5dlW/E3pITEs44lI6o6oFBoOVlt89X0yGf6KyA9f4yTdLvkSPa4W+ZIALdjXS0zLi1ZL+DwJglqhtz08VnqfR7XPqgX0EIDa4LntkbuT2hv9t8Reu/UmFcsimaJC6tCMVylBtmbjdl0oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715686401; c=relaxed/simple;
	bh=8e7jHfPa/Xg2tVdxnlNWY7/DM50Jf1wkw65g9fwLhdA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HmO1uwzxXkRztF98/TOR3lQpGNkrIUydds4LPEXu0/XwZ/ez6WuvUfvknpl3mJ5Q9KUud8zEKaOBFtF7oNbBdnblh6lEMytdIsPKNr4VAqIH1JvqLQcxJg+ikZV6raab1FM3I7axo3fuaIDZshIRx9BXhwozZTdLzIz4MGmH78s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jFljaHvx; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-51f60817e34so6065369e87.2
        for <netdev@vger.kernel.org>; Tue, 14 May 2024 04:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715686397; x=1716291197; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VszNoK63Mz+szQfZ4LtfFejgcMxEf1ilixpxvdRuzwM=;
        b=jFljaHvxlnSaVeOzQqbUiNE/62EkSPhKv5qlUN6Pnf/ddKF2lC25YPRS/iOShUdeov
         GRqqsqOI+GQmbU7/KvgCGaQtG8sOhp78PptmuKLeHOmJt020QSz+nsPgieBcYv1qR5Tw
         gbDvFIeMzZD04Ah4L8cM+aAAQ97ZOLLpHtOHKGMtBAQb0dWaVq3Uc004xllHNWpxupZd
         aes6EDzt2fcRMkgv6NiMica3L0p9n3p1M6kbEiFan4OCuImbHMe24qHW5ulO7Sgl961l
         1LZTWjX7kgef6YG6Qvy+gCHWaB6eZk+ydKTxpPQ3eYgdZkltjnvEmkqmuc+xS6BmfMAj
         zRyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715686397; x=1716291197;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VszNoK63Mz+szQfZ4LtfFejgcMxEf1ilixpxvdRuzwM=;
        b=ksKC8NmHfJ9lPl8aB66yOcUGv7arOgtI7DKnmwuRYx/QwIFpOZacogsI3B6xonxfDC
         mp5+sT7hDCrPuB0JI7mYcLgFHNZZY1hP3qs8OrFrOBJS//Kxr/ASCmaxcz0r6CbLAL7v
         74FnzOByEVzx7HyziClrtXOEvU/4+fI8pJ+IahCiBVMuvRS6D6uOIYBtWS+dJRC+58JS
         I+rigN/tSULvWz3QsCBA13bjZ482O4fr15eS3mVZmGPCUy01mXcr9M82jr47sWKEG/r6
         4PPDJJT69AyOU2m8m89T+6Pr4SZ/gVxAbHFWXaUxgzd5vMllB7cAWAXnF7jHadZs9Wig
         Md0A==
X-Forwarded-Encrypted: i=1; AJvYcCWaTcUrX8+DEMwXYvY5Sx82syMblgXc9qx0kbHWdeR/pSlFHWQ15P70WZ9yftsjSNqhsu/SDkLIyqnTNFUn1tWLFEHd1Sv7
X-Gm-Message-State: AOJu0YyHM2zhjKkS9E0xjEJFsIHK/eoXGN109PYxuIbbPAPpBVQP6zFN
	IWu8bI88MWvQO46d7SnSbdBMFT32qTo0qU8uJ/v3Zb0kDASI03/i
X-Google-Smtp-Source: AGHT+IFDiM6UUe/DTegRL9Gob22ssk5IAKt//W66jwKzj22kx/rmBUAo35D7KOn1EGak82OdYKGk9w==
X-Received: by 2002:ac2:57c7:0:b0:51d:70d9:f6ce with SMTP id 2adb3069b0e04-5220fe78a6bmr6619901e87.53.1715686396705;
        Tue, 14 May 2024 04:33:16 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-521f35ba4f6sm2143087e87.84.2024.05.14.04.33.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 04:33:16 -0700 (PDT)
Date: Tue, 14 May 2024 14:33:13 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Yanteng Si <siyanteng@loongson.cn>, andrew@lunn.ch, 
	hkallweit1@gmail.com, peppe.cavallaro@st.com, alexandre.torgue@foss.st.com, 
	joabreu@synopsys.com, Jose.Abreu@synopsys.com, linux@armlinux.org.uk, 
	guyinggang@loongson.cn, netdev@vger.kernel.org, chris.chenfeiyang@gmail.com, 
	siyanteng01@gmail.com
Subject: Re: [PATCH net-next v12 13/15] net: stmmac: dwmac-loongson: Add
 Loongson GNET support
Message-ID: <d2ibcsxpzrhjzjt4zu7tmopgyp6q77omgweobzidsp53yadcgz@x5774dqqs7qr>
References: <jkjgjraqvih4zu7wvqykerq5wisgkhqf2n2pouha7qhfoeif7v@tkwyx53dfrdw>
 <150b03ff-70b5-488a-b5e6-5f74b6398b20@loongson.cn>
 <pdyqoki5qw4zabz3uv5ff2e2o43htcr6xame652zmbqh23tjji@lt5gmp6m3lkm>
 <CAAhV-H7Dz0CVysUVVVe4Y8qGxpmwJ0i6y2wKnATzNS=5DR_vZg@mail.gmail.com>
 <tbjruh7sx7zovj4ypvfmer3tkgp63zrwhsaxj6hpcfc7ljaqes@zyd3acrqchik>
 <7b56eabc-53e1-4fbe-bf92-81bb1c91ddfc@loongson.cn>
 <kw7fb7mcy7ungrungmbe6z6rmfzswastesx66phtcxxez6vvgw@dal7dt2kj54u>
 <CAAhV-H4TtoV9LAfhx1+fu40XgDqQ+W-tXt36XoieK87_ucBgcQ@mail.gmail.com>
 <nt5bjlmul5jchxvx6zzgvbmdsegpwwz7quzt57vfejnxng7smz@abqdfipuclzh>
 <CAAhV-H5UMJvOtt+YFChqPC1eMkj5UjCEnFJ_YksWjk+uriZPzw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAhV-H5UMJvOtt+YFChqPC1eMkj5UjCEnFJ_YksWjk+uriZPzw@mail.gmail.com>

On Tue, May 14, 2024 at 12:58:33PM +0800, Huacai Chen wrote:
> On Tue, May 14, 2024 at 12:11 AM Serge Semin <fancer.lancer@gmail.com> wrote:
> >
> > On Mon, May 13, 2024 at 09:26:11PM +0800, Huacai Chen wrote:
> > > Hi, Serge,
> > >
> > > On Mon, May 13, 2024 at 6:57 PM Serge Semin <fancer.lancer@gmail.com> wrote:
> > > >
> > > > On Thu, May 09, 2024 at 04:57:44PM +0800, Yanteng Si wrote:
> > > > > Hi Serge
> > > > >
...
> > > >
> > > > > No, only devices that support multiple channels can deliver both PCI MSI
> > > > > IRQs
> > > > >
> > > > > and direct GIC IRQs, other devices can only deliver GIC IRQs.
> > > > >
> > > > > Furthermore, multiple channel features are bundled with MSI. If we want to
> > > > >
> > > > > enable multiple channels, we must enable MSI.
> > > >
> > > > Sadly to say but this information changes a lot. Based on that the
> > > > only platform with optional DT-node is the LS2K2000 GNET device. The
> > > > rest of the devices (GMACs and LS7A2000 GNET) must be equipped with a
> > > > node-pointer otherwise they won't work. Due to that the logic of the
> > > > patches
> > > > [PATCH net-next v12 10/15] net: stmmac: dwmac-loongson: Add full PCI support
> > > > [PATCH net-next v12 11/15] net: stmmac: dwmac-loongson: Add loongson_dwmac_config_legacy
> > > > is incorrect.
> > > >
> > > > 1. [PATCH net-next v12 10/15] net: stmmac: dwmac-loongson: Add full PCI support
> > > > So this patch doesn't add a pure PCI-based probe procedure after all
> > > > because the Loongson GMACs are required to have a DT-node. AFAICS
> > > > pdev->irq is actually the IRQ retrieved from the DT-node. So the "if
> > > > (np) {} else {}" clause doesn't really make sense.
> > > >
> > > > 2. [PATCH net-next v12 11/15] net: stmmac: dwmac-loongson: Add loongson_dwmac_config_legacy
> > > > First of all the function name is incorrect. The IRQ signal isn't legacy
> > > > (INTx-based), but is retrieved from the DT-node. Secondly the
> > > > "if (np) {} else {}" statement is very much redundant because if no
> > > > DT-node found the pdev->irq won't be initialized at all, and the
> > > > driver won't work with no error printed.
> > > >
> > > > All of that also affects the patch/commit logs. Glad we figured that
> > > > out at this stage. Seeing there have been tons of another comments
> > > > let's postpone the discussion around this problem for v13 then. I'll
> > > > keep in mind the info you shared in this thread and think of the way
> > > > to fix the patches after v13 is submitted for review.
> > > Let me clarify the interrupt information, hope that can help you to
> > > understand better:
> >
> > > 1, Loongson machines may use UEFI (implies ACPI) or PMON/UBOOT
> > > (implies FDT) as the BIOS.
> >
> > Ok. Aside with the OF-based platform there is an ACPI case.
> >
> > > 2, The BIOS type has no relationship with device types, which means:
> > > machines with GMAC can be either ACPI-based or FDT-based, machines
> > > with GNET can also be either ACPI-based or FDT-based.
> >
> > Ok. It's either-or. Got it.
> >
> > > 3, The existing Loongson driver can only support FDT, which means the
> > > device should be PCI-probed and DT-configured. Though the existing
> > > driver only supports GMAC, it doesn't mean that GMAC is bound to FDT.
> > > GMAC can also work with ACPI, in that case we say it is "full PCI",
> > > which means we don't need "np".
> >
> > "full PCI" statement can't be utilized for the case of the ACPI-based
> > IRQ assignment. "full PCI" is the way the GNET probe procedure works -
> > everything required for the device handling is detected in runtime
> > with no ACPI/DT stuff.
> >
> > So the patch 10 with the "full PCI"-related subject doesn't actually
> > adds the PCIe-only-based device probe support, but actually converts
> > the driver to supporting the ACPI-case.)

> Yes, the commit message can be improved.

Can be? It must be changed, because at the very least it's misleading,
but frankly speaking it now sounds just wrong.

> 
> >
> > > 4, At present, multi-channel devices support MSI, currently only GNET
> > > support MSI, but in future there may also GMAC support MSI.
> >
> > It's better to avoid adding a support for hypothetical devices and
> > prohibit all the currently unreal cases. It will simplify the code,
> > ease it' maintenance, reduce the bugs probability.
> >
> > > 5, So, in Yanteng's patches, a device firstly request MSI, and since
> > > MSI is dynamically allocated, it doesn't care about the BIOS type
> > > (ACPI or FDT). However, if MSI fails (either because MSI is exhausted
> > > or the device doesn't support it), it fallback to "legacy" interrupt,
> > > which means irq lines mapped to INT-A/B/C/D of PCI.
> >
> > Unless we are talking about the actual PCI devices (not PCI express)
> > or the cases where the INT-x is emulated by means the specific PCIe
> > TLPs, I wouldn't mentioned the INTx or "legacy" names in the current
> > context. It's just a platform ACPI/DT IRQs.

> Yes, it is probably a platform ACPI/DT IRQ, but I think the "legacy"
> name is still reasonable in this case.

Probably? These _are_ pure platform IRQs.

> Otherwise, what does "legacy"
> stand for in "PCI_IRQ_LEGACY/PCI_IRQ_MSI/PCI_IRQ_MSIX"?

It means that the platform IRQs has just been implemented via the
already available old-school API, which has been in the kernel since
the plain PCI devices. The platform IRQs and the traditional PCI INTx
are normally mutually exclusive, so I guess that's why they have been
implemented in framework of the same interface. Another reason could
be to have less troubles with adopting the PCI drivers for both type
of the IRQs delivery.

Moreover just recently the so called _legacy_ flag name has been
deprecated in favor of the more generic INTx one:
https://lore.kernel.org/linux-pci/20231122060406.14695-1-dlemoal@kernel.org/

Once again about the naming. From the retrospective point of view the
so called legacy PCI IRQs (in fact PCI INTx) and the platform IRQs
look similar because these are just the level-type signals connected
to the system IRQ controller. But when it comes to the PCI _Express_,
the implementation is completely different. The PCIe INTx is just the
PCIe TLPs of special type, like MSI. Upon receiving these special
messages the PCIe host controller delivers the IRQ up to the
respective system IRQ controller. So in order to avoid the confusion
between the actual legacy PCI INTx, PCI Express INTx and the just
platform IRQs, it's better to emphasize the actual way of the IRQs
delivery. In this case it's the later method.

> 
> >
> > > 6. In the legacy case, the irq is get from DT-node (FDT case), or
> > > already in pdev->irq (ACPI case).
> >
> > It will be in the pdev->irq in any case whether it's DT or ACPI. See:
> >
> > ACPI:
> > pci_device_probe():
> > +-> arch/loongarch/pci/pci.c:pcibios_alloc_irq()
> >
> > DT:
> > pci_device_probe():
> > +-> pci_assign_irq();
> >     +-> pci_host_bridge::map_irq()
> >         +-> of_irq_parse_and_map_pci()
> >         or in case of Loongson PCIe host controller:
> >         +-> drivers/pci/controller/pci-loongson.c::loongson_map_irq()
> >
> > Moreover unless the MSI IRQs are enabled, the platform IRQ (and the
> > legacy IRQ) can be retrieved by means of the pci_irq_vector() method.
> > The only reason of having the direct OF-based IRQs getting in the
> > Loongson DWMAC driver I see is that the LPI IRQ will be missing in
> > case of the pci_irq_vector() method utilization. In the rest of the
> > cases the pci_irq_vector() function could be freely used.
> Yes, in the DT case, they may be macirq, eth_wake_irq and eth_lpi,
> rather than a single irq, so we need an if-else here.
> 
> >
> > >  So Yanteng use a "if (np) { } else {
> > > }", which is reasonable from my point of view.
> > >
> >
> > At least one problem is there. What if pdev->irq isn't initialized
> > (initialized with zero)?..

> As you said above, both ACPI and DT initialized pdev->irq, unless
> there is a bug in BIOS.

I meant that based on the platform firmware nature the pdev->irq field
shall be initialized with an IRQ number in accordance with the DT or
ACPI logic. I never said it was impossible to have the field
uninitialized (that is being left zero). It's absolutely possible.
There are much more reasons to have that than just a firmware bug. On
the top of my mind: MSI being enabled, kernel misconfiguration, kernel
bug, DT/ACPI lacking the IRQ property, ...

-Serge(y)

> 
> 
> Huacai
> 
> >
> > > So Yanteng's interrupt code is good for me, but I also agree to
> > > improve that after v13, if needed.
> >
> > Ok. I've got much better picture about what is going on under the
> > hood. Thanks. In anyway I'll get back to this topic in details in v13.
> >
> > -Serge(y)
> >
> > >
> > > Huacai
> > >
> > > >
> > > > Thanks
> > > > -Serge(y)
> > > >
> > > > >
> > > > > Thanks,
> > > > >
> > > > > Yanteng
> > > > >


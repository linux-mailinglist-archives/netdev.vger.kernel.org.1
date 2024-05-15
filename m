Return-Path: <netdev+bounces-96492-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81AEE8C62F6
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 10:40:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 323B2283A0A
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 08:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BB4F4E1A8;
	Wed, 15 May 2024 08:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nTM3ogBJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8D72772A
	for <netdev@vger.kernel.org>; Wed, 15 May 2024 08:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715762424; cv=none; b=XEEELb+mMJ7QDlFFAL335GYktrplHFDWo9eFwwdmcHqXQ3raxRD0eRak2ivx9bzUB3hcpGdxGpx0Y+iPALNdH8hEhIjoQF1ba+4J6xg5tPPY3eIItiNRaXBVrpAYmlKjVEY/799zd57QLHi96Ma7KCK9OY6p8qRkjHHWc1terv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715762424; c=relaxed/simple;
	bh=2jMytUwkqczSbvSxHvMMfFvKMP5Yj5pZB9t2TSFGNmU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X4/pgJ0O4WDVwLL5gh4Qotq5ClhgdJAMtOFxQLXsfLsymenCkgSoNKH144/SPsnAmooD1T4nqM4V6mUFkEXX8kk5N1rgSZ6Ukd0LLPvGjHR8pK4B+/x/9jLWVNK9x17WA/2LIdBQ5bAlBxQKW9v4AfqjV92n8YyHKVoQxRFt1oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nTM3ogBJ; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52389c1308dso1039656e87.3
        for <netdev@vger.kernel.org>; Wed, 15 May 2024 01:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715762420; x=1716367220; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dEpBa0CdmSpAxaj6Y1hwXzOWa1kpBuYXqrMl8QkwAU4=;
        b=nTM3ogBJTrsYiERpaOO478pj8RTPGPhe4yjTC7AGaGKRifF887FTkfuWKp4s6bGBQx
         D+XPIb4M93pNmj1NHwRTxN+qIsrG5mKlSXI0nZZvNDuOwT1/ImVQJXM0W0uFsglkzeQx
         PMeovtRrgrS9AQFGqZXIS0+PTYWvDh+3zY1wzk07G5G0F8MkK0SvVlTGgttzr95IFc8B
         xVFGbpFYMmewJm/5mYNn87KVy8+rI761DtcR2SRoiO+hN0C0VkisRYeLu5yxBJN9wAKF
         x1YiFyNHCwLFZznhE7lrrFhXcXOLsR7JADddYzZdE7wufLIn+KrwsFKdbCOCLbeM69KR
         2F1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715762420; x=1716367220;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dEpBa0CdmSpAxaj6Y1hwXzOWa1kpBuYXqrMl8QkwAU4=;
        b=mCcBM5fb/rbAz+s45Y4kp9NCeFxzFVQHVEKk4uRQ5/vEMlqHFdHij/YKMNXC8XOfEM
         Cuvo5Eh5JtqI0HJ0OIZ0e+4Xzz/+NxPGA3N90AugsQPpcVslB/hDdVvdcDQ9qCNafTIb
         Za5PGkUJtBAFVO3sQhZ+gz1xAd1vALS5gooy7OMTA8kTvI7cEnV567YRS3VIhJfllUkY
         8XG2dGgMY556FMSjjgkDt8X9alRnOI1B2vPG68GMHNzeAAotreBw0sYx+ct3+Uupbwzx
         lL72Yr2Zm8gmiDdOtR6i8mj583gOD7yRFBUDK4jrh3oBHzqmNynrekIWCMJEdCiIfcoT
         l1Kw==
X-Forwarded-Encrypted: i=1; AJvYcCXpevylV5odKZ2olRqjEFzYV5gclQN4lmUljnfkvdU9TzB726AXwnudjZuqHy5f+m9TqDh/DjiptbbJZsuUKF5Tt8dyB5YR
X-Gm-Message-State: AOJu0Yxg/wdr0A637gyi9zYJfJuLX+iW1W7RKp7ibOrNfZEycacn226/
	qbM/FrswREjTxaA4m4aQ6EZv0pdHniTCmMVr64gnnIHSQHjGc1sB
X-Google-Smtp-Source: AGHT+IEmXwI6acwOB8BVsu0WzhpwtVsIhNNhYhVDVAhztQozpMZe7pp9DdEG0BkiuO1XMbR76a8nZA==
X-Received: by 2002:ac2:5e2a:0:b0:51f:128d:a6b0 with SMTP id 2adb3069b0e04-5220fc7dc33mr8869838e87.26.1715762419981;
        Wed, 15 May 2024 01:40:19 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-521f35ad58fsm2451908e87.47.2024.05.15.01.40.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 01:40:19 -0700 (PDT)
Date: Wed, 15 May 2024 11:40:16 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Yanteng Si <siyanteng@loongson.cn>, andrew@lunn.ch, 
	hkallweit1@gmail.com, peppe.cavallaro@st.com, alexandre.torgue@foss.st.com, 
	joabreu@synopsys.com, Jose.Abreu@synopsys.com, linux@armlinux.org.uk, 
	guyinggang@loongson.cn, netdev@vger.kernel.org, chris.chenfeiyang@gmail.com, 
	siyanteng01@gmail.com
Subject: Re: [PATCH net-next v12 13/15] net: stmmac: dwmac-loongson: Add
 Loongson GNET support
Message-ID: <xa2ewgfe3qjljsraet5d77qk3dygcvexnqk5atm5fm5oro3ogp@xctegdmx2srt>
References: <pdyqoki5qw4zabz3uv5ff2e2o43htcr6xame652zmbqh23tjji@lt5gmp6m3lkm>
 <CAAhV-H7Dz0CVysUVVVe4Y8qGxpmwJ0i6y2wKnATzNS=5DR_vZg@mail.gmail.com>
 <tbjruh7sx7zovj4ypvfmer3tkgp63zrwhsaxj6hpcfc7ljaqes@zyd3acrqchik>
 <7b56eabc-53e1-4fbe-bf92-81bb1c91ddfc@loongson.cn>
 <kw7fb7mcy7ungrungmbe6z6rmfzswastesx66phtcxxez6vvgw@dal7dt2kj54u>
 <CAAhV-H4TtoV9LAfhx1+fu40XgDqQ+W-tXt36XoieK87_ucBgcQ@mail.gmail.com>
 <nt5bjlmul5jchxvx6zzgvbmdsegpwwz7quzt57vfejnxng7smz@abqdfipuclzh>
 <CAAhV-H5UMJvOtt+YFChqPC1eMkj5UjCEnFJ_YksWjk+uriZPzw@mail.gmail.com>
 <d2ibcsxpzrhjzjt4zu7tmopgyp6q77omgweobzidsp53yadcgz@x5774dqqs7qr>
 <CAAhV-H7Fck+cd14RSUkEPrB=6=35JGkHLBCtrYTGD924fYi2VA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAhV-H7Fck+cd14RSUkEPrB=6=35JGkHLBCtrYTGD924fYi2VA@mail.gmail.com>

On Tue, May 14, 2024 at 08:53:46PM +0800, Huacai Chen wrote:
> Hi, Serge,
> 
> On Tue, May 14, 2024 at 7:33 PM Serge Semin <fancer.lancer@gmail.com> wrote:
> >
> > On Tue, May 14, 2024 at 12:58:33PM +0800, Huacai Chen wrote:
> > > On Tue, May 14, 2024 at 12:11 AM Serge Semin <fancer.lancer@gmail.com> wrote:
> > > >
> > > > On Mon, May 13, 2024 at 09:26:11PM +0800, Huacai Chen wrote:
> > > > > Hi, Serge,
> > > > >
> > > > > On Mon, May 13, 2024 at 6:57 PM Serge Semin <fancer.lancer@gmail.com> wrote:
> > > > > >
> > > > > > On Thu, May 09, 2024 at 04:57:44PM +0800, Yanteng Si wrote:
> > > > > > > Hi Serge
> > > > > > >
> > ...
> > > > > >
> > > > > > > No, only devices that support multiple channels can deliver both PCI MSI
> > > > > > > IRQs
> > > > > > >
> > > > > > > and direct GIC IRQs, other devices can only deliver GIC IRQs.
> > > > > > >
> > > > > > > Furthermore, multiple channel features are bundled with MSI. If we want to
> > > > > > >
> > > > > > > enable multiple channels, we must enable MSI.
> > > > > >
> > > > > > Sadly to say but this information changes a lot. Based on that the
> > > > > > only platform with optional DT-node is the LS2K2000 GNET device. The
> > > > > > rest of the devices (GMACs and LS7A2000 GNET) must be equipped with a
> > > > > > node-pointer otherwise they won't work. Due to that the logic of the
> > > > > > patches
> > > > > > [PATCH net-next v12 10/15] net: stmmac: dwmac-loongson: Add full PCI support
> > > > > > [PATCH net-next v12 11/15] net: stmmac: dwmac-loongson: Add loongson_dwmac_config_legacy
> > > > > > is incorrect.
> > > > > >
> > > > > > 1. [PATCH net-next v12 10/15] net: stmmac: dwmac-loongson: Add full PCI support
> > > > > > So this patch doesn't add a pure PCI-based probe procedure after all
> > > > > > because the Loongson GMACs are required to have a DT-node. AFAICS
> > > > > > pdev->irq is actually the IRQ retrieved from the DT-node. So the "if
> > > > > > (np) {} else {}" clause doesn't really make sense.
> > > > > >
> > > > > > 2. [PATCH net-next v12 11/15] net: stmmac: dwmac-loongson: Add loongson_dwmac_config_legacy
> > > > > > First of all the function name is incorrect. The IRQ signal isn't legacy
> > > > > > (INTx-based), but is retrieved from the DT-node. Secondly the
> > > > > > "if (np) {} else {}" statement is very much redundant because if no
> > > > > > DT-node found the pdev->irq won't be initialized at all, and the
> > > > > > driver won't work with no error printed.
> > > > > >
> > > > > > All of that also affects the patch/commit logs. Glad we figured that
> > > > > > out at this stage. Seeing there have been tons of another comments
> > > > > > let's postpone the discussion around this problem for v13 then. I'll
> > > > > > keep in mind the info you shared in this thread and think of the way
> > > > > > to fix the patches after v13 is submitted for review.
> > > > > Let me clarify the interrupt information, hope that can help you to
> > > > > understand better:
> > > >
> > > > > 1, Loongson machines may use UEFI (implies ACPI) or PMON/UBOOT
> > > > > (implies FDT) as the BIOS.
> > > >
> > > > Ok. Aside with the OF-based platform there is an ACPI case.
> > > >
> > > > > 2, The BIOS type has no relationship with device types, which means:
> > > > > machines with GMAC can be either ACPI-based or FDT-based, machines
> > > > > with GNET can also be either ACPI-based or FDT-based.
> > > >
> > > > Ok. It's either-or. Got it.
> > > >
> > > > > 3, The existing Loongson driver can only support FDT, which means the
> > > > > device should be PCI-probed and DT-configured. Though the existing
> > > > > driver only supports GMAC, it doesn't mean that GMAC is bound to FDT.
> > > > > GMAC can also work with ACPI, in that case we say it is "full PCI",
> > > > > which means we don't need "np".
> > > >
> > > > "full PCI" statement can't be utilized for the case of the ACPI-based
> > > > IRQ assignment. "full PCI" is the way the GNET probe procedure works -
> > > > everything required for the device handling is detected in runtime
> > > > with no ACPI/DT stuff.
> > > >
> > > > So the patch 10 with the "full PCI"-related subject doesn't actually
> > > > adds the PCIe-only-based device probe support, but actually converts
> > > > the driver to supporting the ACPI-case.)
> >
> > > Yes, the commit message can be improved.
> >
> > Can be? It must be changed, because at the very least it's misleading,
> > but frankly speaking it now sounds just wrong.

> Sit back and relax. :)

The smiley enclosing your epigram doesn't make it appropriate. Please
refrain from familiarity in our future discussions.

> I agree with your opinion, but we don't need to so abolute, yes?
> 
> >
> > >
> > > >
> > > > > 4, At present, multi-channel devices support MSI, currently only GNET
> > > > > support MSI, but in future there may also GMAC support MSI.
> > > >
> > > > It's better to avoid adding a support for hypothetical devices and
> > > > prohibit all the currently unreal cases. It will simplify the code,
> > > > ease it' maintenance, reduce the bugs probability.
> > > >
> > > > > 5, So, in Yanteng's patches, a device firstly request MSI, and since
> > > > > MSI is dynamically allocated, it doesn't care about the BIOS type
> > > > > (ACPI or FDT). However, if MSI fails (either because MSI is exhausted
> > > > > or the device doesn't support it), it fallback to "legacy" interrupt,
> > > > > which means irq lines mapped to INT-A/B/C/D of PCI.
> > > >
> > > > Unless we are talking about the actual PCI devices (not PCI express)
> > > > or the cases where the INT-x is emulated by means the specific PCIe
> > > > TLPs, I wouldn't mentioned the INTx or "legacy" names in the current
> > > > context. It's just a platform ACPI/DT IRQs.
> >
> > > Yes, it is probably a platform ACPI/DT IRQ, but I think the "legacy"
> > > name is still reasonable in this case.
> >
> > Probably? These _are_ pure platform IRQs.
> >
> > > Otherwise, what does "legacy"
> > > stand for in "PCI_IRQ_LEGACY/PCI_IRQ_MSI/PCI_IRQ_MSIX"?
> >
> > It means that the platform IRQs has just been implemented via the
> > already available old-school API, which has been in the kernel since
> > the plain PCI devices. The platform IRQs and the traditional PCI INTx
> > are normally mutually exclusive, so I guess that's why they have been
> > implemented in framework of the same interface. Another reason could
> > be to have less troubles with adopting the PCI drivers for both type
> > of the IRQs delivery.
> >
> > Moreover just recently the so called _legacy_ flag name has been
> > deprecated in favor of the more generic INTx one:
> > https://lore.kernel.org/linux-pci/20231122060406.14695-1-dlemoal@kernel.org/

> This info is important, but your last suggestion for Yanteng still use
> PCI_IRQ_LEGACY. :)

Yes, my mistake. It should be replaced with PCI_IRQ_INTX.

> 
> >
> > Once again about the naming. From the retrospective point of view the
> > so called legacy PCI IRQs (in fact PCI INTx) and the platform IRQs
> > look similar because these are just the level-type signals connected
> > to the system IRQ controller. But when it comes to the PCI _Express_,
> > the implementation is completely different. The PCIe INTx is just the
> > PCIe TLPs of special type, like MSI. Upon receiving these special
> > messages the PCIe host controller delivers the IRQ up to the
> > respective system IRQ controller. So in order to avoid the confusion
> > between the actual legacy PCI INTx, PCI Express INTx and the just
> > platform IRQs, it's better to emphasize the actual way of the IRQs
> > delivery. In this case it's the later method.
> You are absolutely right, and I think I found a method to use your
> framework to solve our problems:
> 
>    static int loongson_dwmac_config_irqs(struct pci_dev *pdev,
>                                           struct plat_stmmacenet_data *plat,
>                                           struct stmmac_resources *res)
>    {
>        int i, ret, vecs;
> 
>        /* INT NAME | MAC | CH7 rx | CH7 tx | ... | CH0 rx | CH0 tx |
>         * --------- ----- -------- --------  ...  -------- --------
>         * IRQ NUM  |  0  |   1    |   2    | ... |   15   |   16   |
>         */
>        vecs = plat->rx_queues_to_use + plat->tx_queues_to_use + 1;
>        ret = pci_alloc_irq_vectors(pdev, 1, vecs, PCI_IRQ_MSI | PCI_IRQ_INTX);
>        if (ret < 0) {
>                dev_err(&pdev->dev, "Failed to allocate PCI IRQs\n");
>                return ret;
>        }
>       if (ret >= vecs) {
>                for (i = 0; i < plat->rx_queues_to_use; i++) {
>                        res->rx_irq[CHANNELS_NUM - 1 - i] =
>                                pci_irq_vector(pdev, 1 + i * 2);
>                }
>                for (i = 0; i < plat->tx_queues_to_use; i++) {
>                        res->tx_irq[CHANNELS_NUM - 1 - i] =
>                                pci_irq_vector(pdev, 2 + i * 2);
>                }
> 
>                plat->flags |= STMMAC_FLAG_MULTI_MSI_EN;
>        }
> 
>        res->irq = pci_irq_vector(pdev, 0);
> 
>      if (np) {
>          res->irq = of_irq_get_byname(np, "macirq");
>          if (res->irq < 0) {
>             dev_err(&pdev->dev, "IRQ macirq not found\n");
>             return -ENODEV;
>          }
> 
>          res->wol_irq = of_irq_get_byname(np, "eth_wake_irq");
>          if (res->wol_irq < 0) {
>             dev_info(&pdev->dev,
>                  "IRQ eth_wake_irq not found, using macirq\n");
>             res->wol_irq = res->irq;
>          }
> 
>          res->lpi_irq = of_irq_get_byname(np, "eth_lpi");
>          if (res->lpi_irq < 0) {
>             dev_err(&pdev->dev, "IRQ eth_lpi not found\n");
>             return -ENODEV;
>          }
>      }
>        return 0;
>    }
> 
> If your agree, Yanteng can use this method in V13, then avoid furthur changes.

Since yesterday I have been too relaxed sitting back to explain in
detail the problems with the code above. Shortly speaking, no to the
method designed as above.

-Serge(y)

> 
> Huacai
> 
> >
> > >
> > > >
> > > > > 6. In the legacy case, the irq is get from DT-node (FDT case), or
> > > > > already in pdev->irq (ACPI case).
> > > >
> > > > It will be in the pdev->irq in any case whether it's DT or ACPI. See:
> > > >
> > > > ACPI:
> > > > pci_device_probe():
> > > > +-> arch/loongarch/pci/pci.c:pcibios_alloc_irq()
> > > >
> > > > DT:
> > > > pci_device_probe():
> > > > +-> pci_assign_irq();
> > > >     +-> pci_host_bridge::map_irq()
> > > >         +-> of_irq_parse_and_map_pci()
> > > >         or in case of Loongson PCIe host controller:
> > > >         +-> drivers/pci/controller/pci-loongson.c::loongson_map_irq()
> > > >
> > > > Moreover unless the MSI IRQs are enabled, the platform IRQ (and the
> > > > legacy IRQ) can be retrieved by means of the pci_irq_vector() method.
> > > > The only reason of having the direct OF-based IRQs getting in the
> > > > Loongson DWMAC driver I see is that the LPI IRQ will be missing in
> > > > case of the pci_irq_vector() method utilization. In the rest of the
> > > > cases the pci_irq_vector() function could be freely used.
> > > Yes, in the DT case, they may be macirq, eth_wake_irq and eth_lpi,
> > > rather than a single irq, so we need an if-else here.
> > >
> > > >
> > > > >  So Yanteng use a "if (np) { } else {
> > > > > }", which is reasonable from my point of view.
> > > > >
> > > >
> > > > At least one problem is there. What if pdev->irq isn't initialized
> > > > (initialized with zero)?..
> >
> > > As you said above, both ACPI and DT initialized pdev->irq, unless
> > > there is a bug in BIOS.
> >
> > I meant that based on the platform firmware nature the pdev->irq field
> > shall be initialized with an IRQ number in accordance with the DT or
> > ACPI logic. I never said it was impossible to have the field
> > uninitialized (that is being left zero). It's absolutely possible.
> > There are much more reasons to have that than just a firmware bug. On
> > the top of my mind: MSI being enabled, kernel misconfiguration, kernel
> > bug, DT/ACPI lacking the IRQ property, ...
> >
> > -Serge(y)
> >
> > >
> > >
> > > Huacai
> > >
> > > >
> > > > > So Yanteng's interrupt code is good for me, but I also agree to
> > > > > improve that after v13, if needed.
> > > >
> > > > Ok. I've got much better picture about what is going on under the
> > > > hood. Thanks. In anyway I'll get back to this topic in details in v13.
> > > >
> > > > -Serge(y)
> > > >
> > > > >
> > > > > Huacai
> > > > >
> > > > > >
> > > > > > Thanks
> > > > > > -Serge(y)
> > > > > >
> > > > > > >
> > > > > > > Thanks,
> > > > > > >
> > > > > > > Yanteng
> > > > > > >


Return-Path: <netdev+bounces-96355-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC2948C565A
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 14:56:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E56EB20B38
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 12:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 878836D1A0;
	Tue, 14 May 2024 12:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W2cyqM8z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F5B12DD87
	for <netdev@vger.kernel.org>; Tue, 14 May 2024 12:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715691240; cv=none; b=inz/Unj9bntSdHD0MbYTR3QeGcVikfHVqJWu3mo2M5MZ2Sa6WnZE+dA5vbH3SGyCvUjhLCBQX+E+I4WBUks2S5FRQZIwf2OBfXKVF+EeI9d+rSw8YNyFz3+NRho1Z959iTFNgRpddKPiYBOjeepknQwugJmk/yuQNa0TS98REyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715691240; c=relaxed/simple;
	bh=Iuu6kFssW0dQvxI+YukFiyo+JShxEGusqQkuwtEwD+Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a2PPHXCAzbezQ4BDIC7/lBvRhMvF31hl/tOTuXCUguR/qPwxi3bSUyZ6lxOhecseDzKtqTxrLMkCS5lfeRPGzdS7TxbH1NdiomfgSVAXG7MkcHL9KGaJwjuYqf5mdcFYtuH1tvJ5qTZsrGV2+RDqiZ8xBehFM6H9nJP0eNa2BME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W2cyqM8z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF5C8C4AF17
	for <netdev@vger.kernel.org>; Tue, 14 May 2024 12:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715691239;
	bh=Iuu6kFssW0dQvxI+YukFiyo+JShxEGusqQkuwtEwD+Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=W2cyqM8zY7MIwx3tq/aKtNeIOrUjmlU70EkVGyq1c4oKZnmkHJMut4ZetONX5O87T
	 4YqvHZ32TokMqv8Z0dh4JCE0OMS4PVuhxLOZvrOzSpNX3WFcfbYvra1LDE4I7tBGRz
	 KX9u7t1hJv11kkLvovduFX7pdogp2+A0djcRDOnTWgMGm3g0QgnlM6IW4pEQSVnRMh
	 uCmVZLDwusmG0muYe4w+grbVK2n/Ghej2hIO9b4AutNd40X9oUcCYMyGDiBVBk0ALK
	 7IiHHwKlJXuxRaSNK5R9xozlfeFpU5+8ZAH/ddwJ39obKae/wWGVUxdmoLR5mR1xD3
	 UgrW+CjgwL7kw==
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a5a5c930cf6so4645766b.0
        for <netdev@vger.kernel.org>; Tue, 14 May 2024 05:53:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWjJ4NL9ZS9HsCKLwAhshvobTiFNsZhqyMTtxz2DzBDTvMGy587AVCskXtTPmwtF852aYMaGDd5pLaxEDrGCkynGy22Vn0W
X-Gm-Message-State: AOJu0YyilBhFElLVSWm5ax+9jKRgh60I+UO9KwBmd64lkhWbOvpTHiwY
	VUugyJ1h1Urygt4f7nrWmMC485Sj+x5T8+LWaxFETVWC2Buyro52SAIUYyK2fqEGvPs+LqEPITT
	49IKGw9SpgOl+GE1aPhgNsLCHxEM=
X-Google-Smtp-Source: AGHT+IEguIddAVau+LwTm4nMiE808+Tr9Hp/kBBHcLU66j9GXEqbtOzYAcb3oc1xH3FWTRmZlViLQKt9bJlw3CByMAQ=
X-Received: by 2002:a17:906:13c8:b0:a59:cbb5:e09e with SMTP id
 a640c23a62f3a-a5a2d6669b6mr852232166b.58.1715691238249; Tue, 14 May 2024
 05:53:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <jkjgjraqvih4zu7wvqykerq5wisgkhqf2n2pouha7qhfoeif7v@tkwyx53dfrdw>
 <150b03ff-70b5-488a-b5e6-5f74b6398b20@loongson.cn> <pdyqoki5qw4zabz3uv5ff2e2o43htcr6xame652zmbqh23tjji@lt5gmp6m3lkm>
 <CAAhV-H7Dz0CVysUVVVe4Y8qGxpmwJ0i6y2wKnATzNS=5DR_vZg@mail.gmail.com>
 <tbjruh7sx7zovj4ypvfmer3tkgp63zrwhsaxj6hpcfc7ljaqes@zyd3acrqchik>
 <7b56eabc-53e1-4fbe-bf92-81bb1c91ddfc@loongson.cn> <kw7fb7mcy7ungrungmbe6z6rmfzswastesx66phtcxxez6vvgw@dal7dt2kj54u>
 <CAAhV-H4TtoV9LAfhx1+fu40XgDqQ+W-tXt36XoieK87_ucBgcQ@mail.gmail.com>
 <nt5bjlmul5jchxvx6zzgvbmdsegpwwz7quzt57vfejnxng7smz@abqdfipuclzh>
 <CAAhV-H5UMJvOtt+YFChqPC1eMkj5UjCEnFJ_YksWjk+uriZPzw@mail.gmail.com> <d2ibcsxpzrhjzjt4zu7tmopgyp6q77omgweobzidsp53yadcgz@x5774dqqs7qr>
In-Reply-To: <d2ibcsxpzrhjzjt4zu7tmopgyp6q77omgweobzidsp53yadcgz@x5774dqqs7qr>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Tue, 14 May 2024 20:53:46 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7Fck+cd14RSUkEPrB=6=35JGkHLBCtrYTGD924fYi2VA@mail.gmail.com>
Message-ID: <CAAhV-H7Fck+cd14RSUkEPrB=6=35JGkHLBCtrYTGD924fYi2VA@mail.gmail.com>
Subject: Re: [PATCH net-next v12 13/15] net: stmmac: dwmac-loongson: Add
 Loongson GNET support
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Yanteng Si <siyanteng@loongson.cn>, andrew@lunn.ch, hkallweit1@gmail.com, 
	peppe.cavallaro@st.com, alexandre.torgue@foss.st.com, joabreu@synopsys.com, 
	Jose.Abreu@synopsys.com, linux@armlinux.org.uk, guyinggang@loongson.cn, 
	netdev@vger.kernel.org, chris.chenfeiyang@gmail.com, siyanteng01@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Serge,

On Tue, May 14, 2024 at 7:33=E2=80=AFPM Serge Semin <fancer.lancer@gmail.co=
m> wrote:
>
> On Tue, May 14, 2024 at 12:58:33PM +0800, Huacai Chen wrote:
> > On Tue, May 14, 2024 at 12:11=E2=80=AFAM Serge Semin <fancer.lancer@gma=
il.com> wrote:
> > >
> > > On Mon, May 13, 2024 at 09:26:11PM +0800, Huacai Chen wrote:
> > > > Hi, Serge,
> > > >
> > > > On Mon, May 13, 2024 at 6:57=E2=80=AFPM Serge Semin <fancer.lancer@=
gmail.com> wrote:
> > > > >
> > > > > On Thu, May 09, 2024 at 04:57:44PM +0800, Yanteng Si wrote:
> > > > > > Hi Serge
> > > > > >
> ...
> > > > >
> > > > > > No, only devices that support multiple channels can deliver bot=
h PCI MSI
> > > > > > IRQs
> > > > > >
> > > > > > and direct GIC IRQs, other devices can only deliver GIC IRQs.
> > > > > >
> > > > > > Furthermore, multiple channel features are bundled with MSI. If=
 we want to
> > > > > >
> > > > > > enable multiple channels, we must enable MSI.
> > > > >
> > > > > Sadly to say but this information changes a lot. Based on that th=
e
> > > > > only platform with optional DT-node is the LS2K2000 GNET device. =
The
> > > > > rest of the devices (GMACs and LS7A2000 GNET) must be equipped wi=
th a
> > > > > node-pointer otherwise they won't work. Due to that the logic of =
the
> > > > > patches
> > > > > [PATCH net-next v12 10/15] net: stmmac: dwmac-loongson: Add full =
PCI support
> > > > > [PATCH net-next v12 11/15] net: stmmac: dwmac-loongson: Add loong=
son_dwmac_config_legacy
> > > > > is incorrect.
> > > > >
> > > > > 1. [PATCH net-next v12 10/15] net: stmmac: dwmac-loongson: Add fu=
ll PCI support
> > > > > So this patch doesn't add a pure PCI-based probe procedure after =
all
> > > > > because the Loongson GMACs are required to have a DT-node. AFAICS
> > > > > pdev->irq is actually the IRQ retrieved from the DT-node. So the =
"if
> > > > > (np) {} else {}" clause doesn't really make sense.
> > > > >
> > > > > 2. [PATCH net-next v12 11/15] net: stmmac: dwmac-loongson: Add lo=
ongson_dwmac_config_legacy
> > > > > First of all the function name is incorrect. The IRQ signal isn't=
 legacy
> > > > > (INTx-based), but is retrieved from the DT-node. Secondly the
> > > > > "if (np) {} else {}" statement is very much redundant because if =
no
> > > > > DT-node found the pdev->irq won't be initialized at all, and the
> > > > > driver won't work with no error printed.
> > > > >
> > > > > All of that also affects the patch/commit logs. Glad we figured t=
hat
> > > > > out at this stage. Seeing there have been tons of another comment=
s
> > > > > let's postpone the discussion around this problem for v13 then. I=
'll
> > > > > keep in mind the info you shared in this thread and think of the =
way
> > > > > to fix the patches after v13 is submitted for review.
> > > > Let me clarify the interrupt information, hope that can help you to
> > > > understand better:
> > >
> > > > 1, Loongson machines may use UEFI (implies ACPI) or PMON/UBOOT
> > > > (implies FDT) as the BIOS.
> > >
> > > Ok. Aside with the OF-based platform there is an ACPI case.
> > >
> > > > 2, The BIOS type has no relationship with device types, which means=
:
> > > > machines with GMAC can be either ACPI-based or FDT-based, machines
> > > > with GNET can also be either ACPI-based or FDT-based.
> > >
> > > Ok. It's either-or. Got it.
> > >
> > > > 3, The existing Loongson driver can only support FDT, which means t=
he
> > > > device should be PCI-probed and DT-configured. Though the existing
> > > > driver only supports GMAC, it doesn't mean that GMAC is bound to FD=
T.
> > > > GMAC can also work with ACPI, in that case we say it is "full PCI",
> > > > which means we don't need "np".
> > >
> > > "full PCI" statement can't be utilized for the case of the ACPI-based
> > > IRQ assignment. "full PCI" is the way the GNET probe procedure works =
-
> > > everything required for the device handling is detected in runtime
> > > with no ACPI/DT stuff.
> > >
> > > So the patch 10 with the "full PCI"-related subject doesn't actually
> > > adds the PCIe-only-based device probe support, but actually converts
> > > the driver to supporting the ACPI-case.)
>
> > Yes, the commit message can be improved.
>
> Can be? It must be changed, because at the very least it's misleading,
> but frankly speaking it now sounds just wrong.
Sit back and relax. :)
I agree with your opinion, but we don't need to so abolute, yes?

>
> >
> > >
> > > > 4, At present, multi-channel devices support MSI, currently only GN=
ET
> > > > support MSI, but in future there may also GMAC support MSI.
> > >
> > > It's better to avoid adding a support for hypothetical devices and
> > > prohibit all the currently unreal cases. It will simplify the code,
> > > ease it' maintenance, reduce the bugs probability.
> > >
> > > > 5, So, in Yanteng's patches, a device firstly request MSI, and sinc=
e
> > > > MSI is dynamically allocated, it doesn't care about the BIOS type
> > > > (ACPI or FDT). However, if MSI fails (either because MSI is exhaust=
ed
> > > > or the device doesn't support it), it fallback to "legacy" interrup=
t,
> > > > which means irq lines mapped to INT-A/B/C/D of PCI.
> > >
> > > Unless we are talking about the actual PCI devices (not PCI express)
> > > or the cases where the INT-x is emulated by means the specific PCIe
> > > TLPs, I wouldn't mentioned the INTx or "legacy" names in the current
> > > context. It's just a platform ACPI/DT IRQs.
>
> > Yes, it is probably a platform ACPI/DT IRQ, but I think the "legacy"
> > name is still reasonable in this case.
>
> Probably? These _are_ pure platform IRQs.
>
> > Otherwise, what does "legacy"
> > stand for in "PCI_IRQ_LEGACY/PCI_IRQ_MSI/PCI_IRQ_MSIX"?
>
> It means that the platform IRQs has just been implemented via the
> already available old-school API, which has been in the kernel since
> the plain PCI devices. The platform IRQs and the traditional PCI INTx
> are normally mutually exclusive, so I guess that's why they have been
> implemented in framework of the same interface. Another reason could
> be to have less troubles with adopting the PCI drivers for both type
> of the IRQs delivery.
>
> Moreover just recently the so called _legacy_ flag name has been
> deprecated in favor of the more generic INTx one:
> https://lore.kernel.org/linux-pci/20231122060406.14695-1-dlemoal@kernel.o=
rg/
This info is important, but your last suggestion for Yanteng still use
PCI_IRQ_LEGACY. :)

>
> Once again about the naming. From the retrospective point of view the
> so called legacy PCI IRQs (in fact PCI INTx) and the platform IRQs
> look similar because these are just the level-type signals connected
> to the system IRQ controller. But when it comes to the PCI _Express_,
> the implementation is completely different. The PCIe INTx is just the
> PCIe TLPs of special type, like MSI. Upon receiving these special
> messages the PCIe host controller delivers the IRQ up to the
> respective system IRQ controller. So in order to avoid the confusion
> between the actual legacy PCI INTx, PCI Express INTx and the just
> platform IRQs, it's better to emphasize the actual way of the IRQs
> delivery. In this case it's the later method.
You are absolutely right, and I think I found a method to use your
framework to solve our problems:

   static int loongson_dwmac_config_irqs(struct pci_dev *pdev,
                                          struct plat_stmmacenet_data *plat=
,
                                          struct stmmac_resources *res)
   {
       int i, ret, vecs;

       /* INT NAME | MAC | CH7 rx | CH7 tx | ... | CH0 rx | CH0 tx |
        * --------- ----- -------- --------  ...  -------- --------
        * IRQ NUM  |  0  |   1    |   2    | ... |   15   |   16   |
        */
       vecs =3D plat->rx_queues_to_use + plat->tx_queues_to_use + 1;
       ret =3D pci_alloc_irq_vectors(pdev, 1, vecs, PCI_IRQ_MSI | PCI_IRQ_I=
NTX);
       if (ret < 0) {
               dev_err(&pdev->dev, "Failed to allocate PCI IRQs\n");
               return ret;
       }
      if (ret >=3D vecs) {
               for (i =3D 0; i < plat->rx_queues_to_use; i++) {
                       res->rx_irq[CHANNELS_NUM - 1 - i] =3D
                               pci_irq_vector(pdev, 1 + i * 2);
               }
               for (i =3D 0; i < plat->tx_queues_to_use; i++) {
                       res->tx_irq[CHANNELS_NUM - 1 - i] =3D
                               pci_irq_vector(pdev, 2 + i * 2);
               }

               plat->flags |=3D STMMAC_FLAG_MULTI_MSI_EN;
       }

       res->irq =3D pci_irq_vector(pdev, 0);

     if (np) {
         res->irq =3D of_irq_get_byname(np, "macirq");
         if (res->irq < 0) {
            dev_err(&pdev->dev, "IRQ macirq not found\n");
            return -ENODEV;
         }

         res->wol_irq =3D of_irq_get_byname(np, "eth_wake_irq");
         if (res->wol_irq < 0) {
            dev_info(&pdev->dev,
                 "IRQ eth_wake_irq not found, using macirq\n");
            res->wol_irq =3D res->irq;
         }

         res->lpi_irq =3D of_irq_get_byname(np, "eth_lpi");
         if (res->lpi_irq < 0) {
            dev_err(&pdev->dev, "IRQ eth_lpi not found\n");
            return -ENODEV;
         }
     }
       return 0;
   }

If your agree, Yanteng can use this method in V13, then avoid furthur chang=
es.

Huacai

>
> >
> > >
> > > > 6. In the legacy case, the irq is get from DT-node (FDT case), or
> > > > already in pdev->irq (ACPI case).
> > >
> > > It will be in the pdev->irq in any case whether it's DT or ACPI. See:
> > >
> > > ACPI:
> > > pci_device_probe():
> > > +-> arch/loongarch/pci/pci.c:pcibios_alloc_irq()
> > >
> > > DT:
> > > pci_device_probe():
> > > +-> pci_assign_irq();
> > >     +-> pci_host_bridge::map_irq()
> > >         +-> of_irq_parse_and_map_pci()
> > >         or in case of Loongson PCIe host controller:
> > >         +-> drivers/pci/controller/pci-loongson.c::loongson_map_irq()
> > >
> > > Moreover unless the MSI IRQs are enabled, the platform IRQ (and the
> > > legacy IRQ) can be retrieved by means of the pci_irq_vector() method.
> > > The only reason of having the direct OF-based IRQs getting in the
> > > Loongson DWMAC driver I see is that the LPI IRQ will be missing in
> > > case of the pci_irq_vector() method utilization. In the rest of the
> > > cases the pci_irq_vector() function could be freely used.
> > Yes, in the DT case, they may be macirq, eth_wake_irq and eth_lpi,
> > rather than a single irq, so we need an if-else here.
> >
> > >
> > > >  So Yanteng use a "if (np) { } else {
> > > > }", which is reasonable from my point of view.
> > > >
> > >
> > > At least one problem is there. What if pdev->irq isn't initialized
> > > (initialized with zero)?..
>
> > As you said above, both ACPI and DT initialized pdev->irq, unless
> > there is a bug in BIOS.
>
> I meant that based on the platform firmware nature the pdev->irq field
> shall be initialized with an IRQ number in accordance with the DT or
> ACPI logic. I never said it was impossible to have the field
> uninitialized (that is being left zero). It's absolutely possible.
> There are much more reasons to have that than just a firmware bug. On
> the top of my mind: MSI being enabled, kernel misconfiguration, kernel
> bug, DT/ACPI lacking the IRQ property, ...
>
> -Serge(y)
>
> >
> >
> > Huacai
> >
> > >
> > > > So Yanteng's interrupt code is good for me, but I also agree to
> > > > improve that after v13, if needed.
> > >
> > > Ok. I've got much better picture about what is going on under the
> > > hood. Thanks. In anyway I'll get back to this topic in details in v13=
.
> > >
> > > -Serge(y)
> > >
> > > >
> > > > Huacai
> > > >
> > > > >
> > > > > Thanks
> > > > > -Serge(y)
> > > > >
> > > > > >
> > > > > > Thanks,
> > > > > >
> > > > > > Yanteng
> > > > > >


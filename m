Return-Path: <netdev+bounces-96575-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 98D578C67EA
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 15:56:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F28FBB23037
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 13:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BA6A13F427;
	Wed, 15 May 2024 13:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VRg2Bmfq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB10613EFF3
	for <netdev@vger.kernel.org>; Wed, 15 May 2024 13:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715781322; cv=none; b=O0KMvJ0Lg3w4ULQJIXfzdWd7gtdF1XEJCKJQN6Ghw+iv+Rjtwlvqll84zq0OwAXxVntrt8cAs8w//VdMxnBTHMjvmAXOt2IIaeHpRyrRwSwgKkH44l29+pBLzO+oCQZBFB2yWhPCS6n9QLyPwjOru2RTiMHiDDO2fGEnMrdLPqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715781322; c=relaxed/simple;
	bh=igMJpiX0WEKvdu+HDh+hRz0/8AiRRuVHQJcngVd8JyY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F5EIdwTN+9NbZ57yuAj0t9rnMFbfrztWYf+3D4Ktf0kAyr+aMM1DlNMR56fpQQ8ZX50t0/PxYB/ZTOqR+ZDEj2IZIgB4uJTiydxXUl0xGVj0uYPeic389sGTAkolfijLBdKZSfWVGmnuPMAtpA4oVHXG8rR9E3tGjwd43Jba80w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VRg2Bmfq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D033C116B1
	for <netdev@vger.kernel.org>; Wed, 15 May 2024 13:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715781321;
	bh=igMJpiX0WEKvdu+HDh+hRz0/8AiRRuVHQJcngVd8JyY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=VRg2BmfqmluvyZudGg186pzYKHdZA0KZBvSvLIP7JwYwN2a8tV6ioMqIs2KAKU9EE
	 ISruSaNjnQNVl5iF5dvag0mk7P75JPQOl4fwLW7gdGk6gltY+GsYl29rycDliIGcID
	 LVR4AtizTqwEzySKeoKmvAgdu71hCW+jk6JNZfYYBvyn7LWMMG+VJSUd7o3oQGG/rv
	 IoGjcY9g7XVPemX0vwtVIB1jazIMJ6+12Ui2376lHptQ5l09F/80MkaSTiKDMHuLjh
	 fPcymyL0/pUHGkXayfRxA5acVIyrKyrtrboTLH+1SEahuOyxIM4qmkvUBURZZQlU5+
	 7TiKgGmvcmrZQ==
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a5a8cd78701so196990766b.2
        for <netdev@vger.kernel.org>; Wed, 15 May 2024 06:55:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX/fT4+EtKz+HM+Xfa6CTuF7XjLgKdmCypfr1KWcLkhxB4rJce+9GojxpPCKFQTrKqm1E+EodrPyawkhdOUaPiLN5Ab56ML
X-Gm-Message-State: AOJu0Yxwag4U5FGaSZ1jV4O5AsuDNMkSQSKIDSMRnR/TN9ltAOtWtUzc
	do/ccwWRExDX8zs7v4f2Mugol3S2Ja5AH9/xxTFqcQs5XrfbEwRbboS3fGM+e8T6Fc+sjFuoJ7f
	bnTbxX36KoOWiKpzcuMBuNqSAPTA=
X-Google-Smtp-Source: AGHT+IE5GNn+ghB6fQFgy6lClBr3XAkcCYbX1Htyg96GEnhTGl2JxRKdDusQ9BKiictp236RdFMD5i3YidZfvbsGCNM=
X-Received: by 2002:a17:906:38f:b0:a59:cdf4:f93d with SMTP id
 a640c23a62f3a-a5a2d5cb1dfmr1037320066b.34.1715781319885; Wed, 15 May 2024
 06:55:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pdyqoki5qw4zabz3uv5ff2e2o43htcr6xame652zmbqh23tjji@lt5gmp6m3lkm>
 <CAAhV-H7Dz0CVysUVVVe4Y8qGxpmwJ0i6y2wKnATzNS=5DR_vZg@mail.gmail.com>
 <tbjruh7sx7zovj4ypvfmer3tkgp63zrwhsaxj6hpcfc7ljaqes@zyd3acrqchik>
 <7b56eabc-53e1-4fbe-bf92-81bb1c91ddfc@loongson.cn> <kw7fb7mcy7ungrungmbe6z6rmfzswastesx66phtcxxez6vvgw@dal7dt2kj54u>
 <CAAhV-H4TtoV9LAfhx1+fu40XgDqQ+W-tXt36XoieK87_ucBgcQ@mail.gmail.com>
 <nt5bjlmul5jchxvx6zzgvbmdsegpwwz7quzt57vfejnxng7smz@abqdfipuclzh>
 <CAAhV-H5UMJvOtt+YFChqPC1eMkj5UjCEnFJ_YksWjk+uriZPzw@mail.gmail.com>
 <d2ibcsxpzrhjzjt4zu7tmopgyp6q77omgweobzidsp53yadcgz@x5774dqqs7qr>
 <CAAhV-H7Fck+cd14RSUkEPrB=6=35JGkHLBCtrYTGD924fYi2VA@mail.gmail.com> <xa2ewgfe3qjljsraet5d77qk3dygcvexnqk5atm5fm5oro3ogp@xctegdmx2srt>
In-Reply-To: <xa2ewgfe3qjljsraet5d77qk3dygcvexnqk5atm5fm5oro3ogp@xctegdmx2srt>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Wed, 15 May 2024 21:55:09 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5JT+QfZgHX7K3HYLFSxuZeer4PdUPjehtyXKcfi=L2oQ@mail.gmail.com>
Message-ID: <CAAhV-H5JT+QfZgHX7K3HYLFSxuZeer4PdUPjehtyXKcfi=L2oQ@mail.gmail.com>
Subject: Re: [PATCH net-next v12 13/15] net: stmmac: dwmac-loongson: Add
 Loongson GNET support
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Yanteng Si <siyanteng@loongson.cn>, andrew@lunn.ch, hkallweit1@gmail.com, 
	peppe.cavallaro@st.com, alexandre.torgue@foss.st.com, joabreu@synopsys.com, 
	Jose.Abreu@synopsys.com, linux@armlinux.org.uk, guyinggang@loongson.cn, 
	netdev@vger.kernel.org, chris.chenfeiyang@gmail.com, siyanteng01@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 15, 2024 at 4:40=E2=80=AFPM Serge Semin <fancer.lancer@gmail.co=
m> wrote:
>
> On Tue, May 14, 2024 at 08:53:46PM +0800, Huacai Chen wrote:
> > Hi, Serge,
> >
> > On Tue, May 14, 2024 at 7:33=E2=80=AFPM Serge Semin <fancer.lancer@gmai=
l.com> wrote:
> > >
> > > On Tue, May 14, 2024 at 12:58:33PM +0800, Huacai Chen wrote:
> > > > On Tue, May 14, 2024 at 12:11=E2=80=AFAM Serge Semin <fancer.lancer=
@gmail.com> wrote:
> > > > >
> > > > > On Mon, May 13, 2024 at 09:26:11PM +0800, Huacai Chen wrote:
> > > > > > Hi, Serge,
> > > > > >
> > > > > > On Mon, May 13, 2024 at 6:57=E2=80=AFPM Serge Semin <fancer.lan=
cer@gmail.com> wrote:
> > > > > > >
> > > > > > > On Thu, May 09, 2024 at 04:57:44PM +0800, Yanteng Si wrote:
> > > > > > > > Hi Serge
> > > > > > > >
> > > ...
> > > > > > >
> > > > > > > > No, only devices that support multiple channels can deliver=
 both PCI MSI
> > > > > > > > IRQs
> > > > > > > >
> > > > > > > > and direct GIC IRQs, other devices can only deliver GIC IRQ=
s.
> > > > > > > >
> > > > > > > > Furthermore, multiple channel features are bundled with MSI=
. If we want to
> > > > > > > >
> > > > > > > > enable multiple channels, we must enable MSI.
> > > > > > >
> > > > > > > Sadly to say but this information changes a lot. Based on tha=
t the
> > > > > > > only platform with optional DT-node is the LS2K2000 GNET devi=
ce. The
> > > > > > > rest of the devices (GMACs and LS7A2000 GNET) must be equippe=
d with a
> > > > > > > node-pointer otherwise they won't work. Due to that the logic=
 of the
> > > > > > > patches
> > > > > > > [PATCH net-next v12 10/15] net: stmmac: dwmac-loongson: Add f=
ull PCI support
> > > > > > > [PATCH net-next v12 11/15] net: stmmac: dwmac-loongson: Add l=
oongson_dwmac_config_legacy
> > > > > > > is incorrect.
> > > > > > >
> > > > > > > 1. [PATCH net-next v12 10/15] net: stmmac: dwmac-loongson: Ad=
d full PCI support
> > > > > > > So this patch doesn't add a pure PCI-based probe procedure af=
ter all
> > > > > > > because the Loongson GMACs are required to have a DT-node. AF=
AICS
> > > > > > > pdev->irq is actually the IRQ retrieved from the DT-node. So =
the "if
> > > > > > > (np) {} else {}" clause doesn't really make sense.
> > > > > > >
> > > > > > > 2. [PATCH net-next v12 11/15] net: stmmac: dwmac-loongson: Ad=
d loongson_dwmac_config_legacy
> > > > > > > First of all the function name is incorrect. The IRQ signal i=
sn't legacy
> > > > > > > (INTx-based), but is retrieved from the DT-node. Secondly the
> > > > > > > "if (np) {} else {}" statement is very much redundant because=
 if no
> > > > > > > DT-node found the pdev->irq won't be initialized at all, and =
the
> > > > > > > driver won't work with no error printed.
> > > > > > >
> > > > > > > All of that also affects the patch/commit logs. Glad we figur=
ed that
> > > > > > > out at this stage. Seeing there have been tons of another com=
ments
> > > > > > > let's postpone the discussion around this problem for v13 the=
n. I'll
> > > > > > > keep in mind the info you shared in this thread and think of =
the way
> > > > > > > to fix the patches after v13 is submitted for review.
> > > > > > Let me clarify the interrupt information, hope that can help yo=
u to
> > > > > > understand better:
> > > > >
> > > > > > 1, Loongson machines may use UEFI (implies ACPI) or PMON/UBOOT
> > > > > > (implies FDT) as the BIOS.
> > > > >
> > > > > Ok. Aside with the OF-based platform there is an ACPI case.
> > > > >
> > > > > > 2, The BIOS type has no relationship with device types, which m=
eans:
> > > > > > machines with GMAC can be either ACPI-based or FDT-based, machi=
nes
> > > > > > with GNET can also be either ACPI-based or FDT-based.
> > > > >
> > > > > Ok. It's either-or. Got it.
> > > > >
> > > > > > 3, The existing Loongson driver can only support FDT, which mea=
ns the
> > > > > > device should be PCI-probed and DT-configured. Though the exist=
ing
> > > > > > driver only supports GMAC, it doesn't mean that GMAC is bound t=
o FDT.
> > > > > > GMAC can also work with ACPI, in that case we say it is "full P=
CI",
> > > > > > which means we don't need "np".
> > > > >
> > > > > "full PCI" statement can't be utilized for the case of the ACPI-b=
ased
> > > > > IRQ assignment. "full PCI" is the way the GNET probe procedure wo=
rks -
> > > > > everything required for the device handling is detected in runtim=
e
> > > > > with no ACPI/DT stuff.
> > > > >
> > > > > So the patch 10 with the "full PCI"-related subject doesn't actua=
lly
> > > > > adds the PCIe-only-based device probe support, but actually conve=
rts
> > > > > the driver to supporting the ACPI-case.)
> > >
> > > > Yes, the commit message can be improved.
> > >
> > > Can be? It must be changed, because at the very least it's misleading=
,
> > > but frankly speaking it now sounds just wrong.
>
> > Sit back and relax. :)
>
> The smiley enclosing your epigram doesn't make it appropriate. Please
> refrain from familiarity in our future discussions.
>
> > I agree with your opinion, but we don't need to so abolute, yes?
> >
> > >
> > > >
> > > > >
> > > > > > 4, At present, multi-channel devices support MSI, currently onl=
y GNET
> > > > > > support MSI, but in future there may also GMAC support MSI.
> > > > >
> > > > > It's better to avoid adding a support for hypothetical devices an=
d
> > > > > prohibit all the currently unreal cases. It will simplify the cod=
e,
> > > > > ease it' maintenance, reduce the bugs probability.
> > > > >
> > > > > > 5, So, in Yanteng's patches, a device firstly request MSI, and =
since
> > > > > > MSI is dynamically allocated, it doesn't care about the BIOS ty=
pe
> > > > > > (ACPI or FDT). However, if MSI fails (either because MSI is exh=
austed
> > > > > > or the device doesn't support it), it fallback to "legacy" inte=
rrupt,
> > > > > > which means irq lines mapped to INT-A/B/C/D of PCI.
> > > > >
> > > > > Unless we are talking about the actual PCI devices (not PCI expre=
ss)
> > > > > or the cases where the INT-x is emulated by means the specific PC=
Ie
> > > > > TLPs, I wouldn't mentioned the INTx or "legacy" names in the curr=
ent
> > > > > context. It's just a platform ACPI/DT IRQs.
> > >
> > > > Yes, it is probably a platform ACPI/DT IRQ, but I think the "legacy=
"
> > > > name is still reasonable in this case.
> > >
> > > Probably? These _are_ pure platform IRQs.
> > >
> > > > Otherwise, what does "legacy"
> > > > stand for in "PCI_IRQ_LEGACY/PCI_IRQ_MSI/PCI_IRQ_MSIX"?
> > >
> > > It means that the platform IRQs has just been implemented via the
> > > already available old-school API, which has been in the kernel since
> > > the plain PCI devices. The platform IRQs and the traditional PCI INTx
> > > are normally mutually exclusive, so I guess that's why they have been
> > > implemented in framework of the same interface. Another reason could
> > > be to have less troubles with adopting the PCI drivers for both type
> > > of the IRQs delivery.
> > >
> > > Moreover just recently the so called _legacy_ flag name has been
> > > deprecated in favor of the more generic INTx one:
> > > https://lore.kernel.org/linux-pci/20231122060406.14695-1-dlemoal@kern=
el.org/
>
> > This info is important, but your last suggestion for Yanteng still use
> > PCI_IRQ_LEGACY. :)
>
> Yes, my mistake. It should be replaced with PCI_IRQ_INTX.
>
> >
> > >
> > > Once again about the naming. From the retrospective point of view the
> > > so called legacy PCI IRQs (in fact PCI INTx) and the platform IRQs
> > > look similar because these are just the level-type signals connected
> > > to the system IRQ controller. But when it comes to the PCI _Express_,
> > > the implementation is completely different. The PCIe INTx is just the
> > > PCIe TLPs of special type, like MSI. Upon receiving these special
> > > messages the PCIe host controller delivers the IRQ up to the
> > > respective system IRQ controller. So in order to avoid the confusion
> > > between the actual legacy PCI INTx, PCI Express INTx and the just
> > > platform IRQs, it's better to emphasize the actual way of the IRQs
> > > delivery. In this case it's the later method.
> > You are absolutely right, and I think I found a method to use your
> > framework to solve our problems:
> >
> >    static int loongson_dwmac_config_irqs(struct pci_dev *pdev,
> >                                           struct plat_stmmacenet_data *=
plat,
> >                                           struct stmmac_resources *res)
> >    {
> >        int i, ret, vecs;
> >
> >        /* INT NAME | MAC | CH7 rx | CH7 tx | ... | CH0 rx | CH0 tx |
> >         * --------- ----- -------- --------  ...  -------- --------
> >         * IRQ NUM  |  0  |   1    |   2    | ... |   15   |   16   |
> >         */
> >        vecs =3D plat->rx_queues_to_use + plat->tx_queues_to_use + 1;
> >        ret =3D pci_alloc_irq_vectors(pdev, 1, vecs, PCI_IRQ_MSI | PCI_I=
RQ_INTX);
> >        if (ret < 0) {
> >                dev_err(&pdev->dev, "Failed to allocate PCI IRQs\n");
> >                return ret;
> >        }
> >       if (ret >=3D vecs) {
> >                for (i =3D 0; i < plat->rx_queues_to_use; i++) {
> >                        res->rx_irq[CHANNELS_NUM - 1 - i] =3D
> >                                pci_irq_vector(pdev, 1 + i * 2);
> >                }
> >                for (i =3D 0; i < plat->tx_queues_to_use; i++) {
> >                        res->tx_irq[CHANNELS_NUM - 1 - i] =3D
> >                                pci_irq_vector(pdev, 2 + i * 2);
> >                }
> >
> >                plat->flags |=3D STMMAC_FLAG_MULTI_MSI_EN;
> >        }
> >
> >        res->irq =3D pci_irq_vector(pdev, 0);
> >
> >      if (np) {
> >          res->irq =3D of_irq_get_byname(np, "macirq");
> >          if (res->irq < 0) {
> >             dev_err(&pdev->dev, "IRQ macirq not found\n");
> >             return -ENODEV;
> >          }
> >
> >          res->wol_irq =3D of_irq_get_byname(np, "eth_wake_irq");
> >          if (res->wol_irq < 0) {
> >             dev_info(&pdev->dev,
> >                  "IRQ eth_wake_irq not found, using macirq\n");
> >             res->wol_irq =3D res->irq;
> >          }
> >
> >          res->lpi_irq =3D of_irq_get_byname(np, "eth_lpi");
> >          if (res->lpi_irq < 0) {
> >             dev_err(&pdev->dev, "IRQ eth_lpi not found\n");
> >             return -ENODEV;
> >          }
> >      }
> >        return 0;
> >    }
> >
> > If your agree, Yanteng can use this method in V13, then avoid furthur c=
hanges.
>
> Since yesterday I have been too relaxed sitting back to explain in
> detail the problems with the code above. Shortly speaking, no to the
> method designed as above.
This function is copy-paste from your version which you suggest to
Yanteng, and plus the fallback parts for DT. If you don't want to
discuss it any more, we can discuss after V13.

BTW, we cannot remove "res->wol_irq =3D res->irq", because Loongson
GMAC/GNET indeed supports WoL.

Huacai

>
> -Serge(y)
>
> >
> > Huacai
> >
> > >
> > > >
> > > > >
> > > > > > 6. In the legacy case, the irq is get from DT-node (FDT case), =
or
> > > > > > already in pdev->irq (ACPI case).
> > > > >
> > > > > It will be in the pdev->irq in any case whether it's DT or ACPI. =
See:
> > > > >
> > > > > ACPI:
> > > > > pci_device_probe():
> > > > > +-> arch/loongarch/pci/pci.c:pcibios_alloc_irq()
> > > > >
> > > > > DT:
> > > > > pci_device_probe():
> > > > > +-> pci_assign_irq();
> > > > >     +-> pci_host_bridge::map_irq()
> > > > >         +-> of_irq_parse_and_map_pci()
> > > > >         or in case of Loongson PCIe host controller:
> > > > >         +-> drivers/pci/controller/pci-loongson.c::loongson_map_i=
rq()
> > > > >
> > > > > Moreover unless the MSI IRQs are enabled, the platform IRQ (and t=
he
> > > > > legacy IRQ) can be retrieved by means of the pci_irq_vector() met=
hod.
> > > > > The only reason of having the direct OF-based IRQs getting in the
> > > > > Loongson DWMAC driver I see is that the LPI IRQ will be missing i=
n
> > > > > case of the pci_irq_vector() method utilization. In the rest of t=
he
> > > > > cases the pci_irq_vector() function could be freely used.
> > > > Yes, in the DT case, they may be macirq, eth_wake_irq and eth_lpi,
> > > > rather than a single irq, so we need an if-else here.
> > > >
> > > > >
> > > > > >  So Yanteng use a "if (np) { } else {
> > > > > > }", which is reasonable from my point of view.
> > > > > >
> > > > >
> > > > > At least one problem is there. What if pdev->irq isn't initialize=
d
> > > > > (initialized with zero)?..
> > >
> > > > As you said above, both ACPI and DT initialized pdev->irq, unless
> > > > there is a bug in BIOS.
> > >
> > > I meant that based on the platform firmware nature the pdev->irq fiel=
d
> > > shall be initialized with an IRQ number in accordance with the DT or
> > > ACPI logic. I never said it was impossible to have the field
> > > uninitialized (that is being left zero). It's absolutely possible.
> > > There are much more reasons to have that than just a firmware bug. On
> > > the top of my mind: MSI being enabled, kernel misconfiguration, kerne=
l
> > > bug, DT/ACPI lacking the IRQ property, ...
> > >
> > > -Serge(y)
> > >
> > > >
> > > >
> > > > Huacai
> > > >
> > > > >
> > > > > > So Yanteng's interrupt code is good for me, but I also agree to
> > > > > > improve that after v13, if needed.
> > > > >
> > > > > Ok. I've got much better picture about what is going on under the
> > > > > hood. Thanks. In anyway I'll get back to this topic in details in=
 v13.
> > > > >
> > > > > -Serge(y)
> > > > >
> > > > > >
> > > > > > Huacai
> > > > > >
> > > > > > >
> > > > > > > Thanks
> > > > > > > -Serge(y)
> > > > > > >
> > > > > > > >
> > > > > > > > Thanks,
> > > > > > > >
> > > > > > > > Yanteng
> > > > > > > >


Return-Path: <netdev+bounces-96048-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F10018C41DC
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 15:26:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 203AD1C203FF
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 13:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD052152185;
	Mon, 13 May 2024 13:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jKScWpuT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B766C152171
	for <netdev@vger.kernel.org>; Mon, 13 May 2024 13:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715606784; cv=none; b=U30nN24hLeVXWZRPcakt+l1ZQIbDKU/b8d/xG93uy2opbXA2foOvZIeghyNrWKVA8kLXZoZyVyMgSeWlTh5fA0KFl2J9Damm1fowcirLNNpuNg2SacQPUrUWT9/3QNupLrDXdrIfqGVpFxEixCppKBJ1Ho6kY13TyBBjsrAg0xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715606784; c=relaxed/simple;
	bh=JpRLQjviDe//a762euKyWiPbpdEbYbOlghsZ6oCI3u4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i//2nnbFL3YoTFN/9l7swHoWsnRAU485x4mtKTFKhlYSc6g8Jw/fT3dGcSE0uzPgQA9f970MVoqkGd68fRgwKuThOL++u7pK/bPSAhuvE7hmcFYVjGHEf2WRdb4UnoQiYrp5YySjbWMfaDud7BhjpAsRNLoJXfUIQfxB6fpY/zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jKScWpuT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 503B1C32786
	for <netdev@vger.kernel.org>; Mon, 13 May 2024 13:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715606784;
	bh=JpRLQjviDe//a762euKyWiPbpdEbYbOlghsZ6oCI3u4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=jKScWpuTQBpVDJN5E08VrhyW/NDHqWKFxlrP18xKjsDZ1dveP3oW0Wvtj4ZgK8+pA
	 D85XkRTwfiluOEOEm+WyRjGdaZq4SBL8MlmUkgeujJ+uzp18UA4vvw+2RuUN/wZ6Dw
	 EbgJeuG8u63iXnACexxs9y5P9AjtYrE6HP/wAG6i04/I35XmHURiiMkM95O5tOfwbx
	 K9DZsGtzCgF/S0R+6PIVyAy2e0OcQAbJMPZquCXU1JXPGS8b8eSd3jlC8yrYyJybYO
	 IuHQiYANBa8l9SUY5Hy7U4Zk96aeAGWZoibDyv85mESIRDStaNq3Bz1CDhIy1PdW9y
	 Pe4OXNFr/4LAA==
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a5a552c8cbaso461884966b.2
        for <netdev@vger.kernel.org>; Mon, 13 May 2024 06:26:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVuNSKRciAegWNAn6j0KIENOn/7VmppKv1IiAuaBJBQFqkWQXjG/Y/L/ND/DysDrNjDxgfrCcfVvN16phT8gCCjy1f92YRy
X-Gm-Message-State: AOJu0YxqGENl09RnNUi3fCTl3wN0VMXddUk9Gd6Eyf/DRsaHiZXmGA9a
	KvE2ANz1bKZY4rxXhK9B2+CUXOX3NvvGJ7+ja8UXsteOQMwbNcUO3I3wjWlRRtrRT1Q51Q0gcii
	XaEQZgpUiW7Er65RP7qIXsb/ivBY=
X-Google-Smtp-Source: AGHT+IHjaUsYHCNzJKbX808RpTBdKZgp7J9qrUpYZdWHliFgWfwmXuTuVkF5emWTJQNu0FIaAWf/Sl995l+NNjzoziE=
X-Received: by 2002:a17:906:11d6:b0:a59:ce90:27ea with SMTP id
 a640c23a62f3a-a5a2d581d96mr658037966b.24.1715606782809; Mon, 13 May 2024
 06:26:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1714046812.git.siyanteng@loongson.cn> <c97cb15ab77fb9dfdd281640f48dcfc08c6988c0.1714046812.git.siyanteng@loongson.cn>
 <jkjgjraqvih4zu7wvqykerq5wisgkhqf2n2pouha7qhfoeif7v@tkwyx53dfrdw>
 <150b03ff-70b5-488a-b5e6-5f74b6398b20@loongson.cn> <pdyqoki5qw4zabz3uv5ff2e2o43htcr6xame652zmbqh23tjji@lt5gmp6m3lkm>
 <CAAhV-H7Dz0CVysUVVVe4Y8qGxpmwJ0i6y2wKnATzNS=5DR_vZg@mail.gmail.com>
 <tbjruh7sx7zovj4ypvfmer3tkgp63zrwhsaxj6hpcfc7ljaqes@zyd3acrqchik>
 <7b56eabc-53e1-4fbe-bf92-81bb1c91ddfc@loongson.cn> <kw7fb7mcy7ungrungmbe6z6rmfzswastesx66phtcxxez6vvgw@dal7dt2kj54u>
In-Reply-To: <kw7fb7mcy7ungrungmbe6z6rmfzswastesx66phtcxxez6vvgw@dal7dt2kj54u>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Mon, 13 May 2024 21:26:11 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4TtoV9LAfhx1+fu40XgDqQ+W-tXt36XoieK87_ucBgcQ@mail.gmail.com>
Message-ID: <CAAhV-H4TtoV9LAfhx1+fu40XgDqQ+W-tXt36XoieK87_ucBgcQ@mail.gmail.com>
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

On Mon, May 13, 2024 at 6:57=E2=80=AFPM Serge Semin <fancer.lancer@gmail.co=
m> wrote:
>
> On Thu, May 09, 2024 at 04:57:44PM +0800, Yanteng Si wrote:
> > Hi Serge
> >
> > =E5=9C=A8 2024/5/8 23:10, Serge Semin =E5=86=99=E9=81=93:
> > > On Wed, May 08, 2024 at 10:58:16PM +0800, Huacai Chen wrote:
> > > > Hi, Serge,
> > > >
> > > > On Wed, May 8, 2024 at 10:38=E2=80=AFPM Serge Semin<fancer.lancer@g=
mail.com>  wrote:
> > > > > On Tue, May 07, 2024 at 09:35:24PM +0800, Yanteng Si wrote:
> > > > > > Hi Serge,
> > > > > >
> > > > > > =E5=9C=A8 2024/5/6 18:39, Serge Semin =E5=86=99=E9=81=93:
> > > > > > > On Thu, Apr 25, 2024 at 09:11:36PM +0800, Yanteng Si wrote:
> > > > > > > > ...
> > > > > > > > +static int loongson_dwmac_config_msi(struct pci_dev *pdev,
> > > > > > > > +                              struct plat_stmmacenet_data =
*plat,
> > > > > > > > +                              struct stmmac_resources *res=
,
> > > > > > > > +                              struct device_node *np)
> > > > > > > > +{
> > > > > > > > + int i, ret, vecs;
> > > > > > > > +
> > > > > > > > + vecs =3D roundup_pow_of_two(CHANNEL_NUM * 2 + 1);
> > > > > > > > + ret =3D pci_alloc_irq_vectors(pdev, vecs, vecs, PCI_IRQ_M=
SI);
> > > > > > > > + if (ret < 0) {
> > > > > > > > +         dev_info(&pdev->dev,
> > > > > > > > +                  "MSI enable failed, Fallback to legacy i=
nterrupt\n");
> > > > > > > > +         return loongson_dwmac_config_legacy(pdev, plat, r=
es, np);
> > > > > > > > + }
> > > > > > > > +
> > > > > > > > + res->irq =3D pci_irq_vector(pdev, 0);
> > > > > > > > + res->wol_irq =3D 0;
> > > > > > > > +
> > > > > > > > + /* INT NAME | MAC | CH7 rx | CH7 tx | ... | CH0 rx | CH0 =
tx |
> > > > > > > > +  * --------- ----- -------- --------  ...  -------- -----=
---
> > > > > > > > +  * IRQ NUM  |  0  |   1    |   2    | ... |   15   |   16=
   |
> > > > > > > > +  */
> > > > > > > > + for (i =3D 0; i < CHANNEL_NUM; i++) {
> > > > > > > > +         res->rx_irq[CHANNEL_NUM - 1 - i] =3D
> > > > > > > > +                 pci_irq_vector(pdev, 1 + i * 2);
> > > > > > > > +         res->tx_irq[CHANNEL_NUM - 1 - i] =3D
> > > > > > > > +                 pci_irq_vector(pdev, 2 + i * 2);
> > > > > > > > + }
> > > > > > > > +
> > > > > > > > + plat->flags |=3D STMMAC_FLAG_MULTI_MSI_EN;
> > > > > > > > +
> > > > > > > > + return 0;
> > > > > > > > +}
> > > > > > > > +
> > > > > > > > ...
> > > > > > > >    static int loongson_dwmac_probe(struct pci_dev *pdev, co=
nst struct pci_device_id *id)
> > > > > > > >    {
> > > > > > > >            struct plat_stmmacenet_data *plat;
> > > > > > > >            int ret, i, bus_id, phy_mode;
> > > > > > > >            struct stmmac_pci_info *info;
> > > > > > > >            struct stmmac_resources res;
> > > > > > > > + struct loongson_data *ld;
> > > > > > > >            struct device_node *np;
> > > > > > > >            np =3D dev_of_node(&pdev->dev);
> > > > > > > > @@ -122,10 +460,12 @@ static int loongson_dwmac_probe(struc=
t pci_dev *pdev, const struct pci_device_id
> > > > > > > >                    return -ENOMEM;
> > > > > > > >            plat->dma_cfg =3D devm_kzalloc(&pdev->dev, sizeo=
f(*plat->dma_cfg), GFP_KERNEL);
> > > > > > > > - if (!plat->dma_cfg) {
> > > > > > > > -         ret =3D -ENOMEM;
> > > > > > > > -         goto err_put_node;
> > > > > > > > - }
> > > > > > > > + if (!plat->dma_cfg)
> > > > > > > > +         return -ENOMEM;
> > > > > > > > +
> > > > > > > > + ld =3D devm_kzalloc(&pdev->dev, sizeof(*ld), GFP_KERNEL);
> > > > > > > > + if (!ld)
> > > > > > > > +         return -ENOMEM;
> > > > > > > >            /* Enable pci device */
> > > > > > > >            ret =3D pci_enable_device(pdev);
> > > > > > > > @@ -171,14 +511,34 @@ static int loongson_dwmac_probe(struc=
t pci_dev *pdev, const struct pci_device_id
> > > > > > > >                    plat->phy_interface =3D phy_mode;
> > > > > > > >            }
> > > > > > > > - pci_enable_msi(pdev);
> > > > > > > > + plat->bsp_priv =3D ld;
> > > > > > > > + plat->setup =3D loongson_dwmac_setup;
> > > > > > > > + ld->dev =3D &pdev->dev;
> > > > > > > > +
> > > > > > > >            memset(&res, 0, sizeof(res));
> > > > > > > >            res.addr =3D pcim_iomap_table(pdev)[0];
> > > > > > > > + ld->gmac_verion =3D readl(res.addr + GMAC_VERSION) & 0xff=
;
> > > > > > > > +
> > > > > > > > + switch (ld->gmac_verion) {
> > > > > > > > + case LOONGSON_DWMAC_CORE_1_00:
> > > > > > > > +         plat->rx_queues_to_use =3D CHANNEL_NUM;
> > > > > > > > +         plat->tx_queues_to_use =3D CHANNEL_NUM;
> > > > > > > > +
> > > > > > > > +         /* Only channel 0 supports checksum,
> > > > > > > > +          * so turn off checksum to enable multiple channe=
ls.
> > > > > > > > +          */
> > > > > > > > +         for (i =3D 1; i < CHANNEL_NUM; i++)
> > > > > > > > +                 plat->tx_queues_cfg[i].coe_unsupported =
=3D 1;
> > > > > > > > - plat->tx_queues_to_use =3D 1;
> > > > > > > > - plat->rx_queues_to_use =3D 1;
> > > > > > > > +         ret =3D loongson_dwmac_config_msi(pdev, plat, &re=
s, np);
> > > > > > > > +         break;
> > > > > > > > + default:        /* 0x35 device and 0x37 device. */
> > > > > > > > +         plat->tx_queues_to_use =3D 1;
> > > > > > > > +         plat->rx_queues_to_use =3D 1;
> > > > > > > > - ret =3D loongson_dwmac_config_legacy(pdev, plat, &res, np=
);
> > > > > > > > +         ret =3D loongson_dwmac_config_legacy(pdev, plat, =
&res, np);
> > > > > > > > +         break;
> > > > > > > > + }
> > > > > > > Let's now talk about this change.
> > > > > > >
> > > > > > > First of all, one more time. You can't miss the return value =
check
> > > > > > > because if any of the IRQ config method fails then the driver=
 won't
> > > > > > > work! The first change that introduces the problem is in the =
patch
> > > > > > > [PATCH net-next v12 11/15] net: stmmac: dwmac-loongson: Add l=
oongson_dwmac_config_legacy
> > > > > > OK!
> > > > > > > Second, as I already mentioned in another message sent to thi=
s patch
> > > > > > > you are missing the PCI MSI IRQs freeing in the cleanup-on-er=
ror path
> > > > > > > and in the device/driver remove() function. It's definitely w=
rong.
> > > > > > You are right! I will do it.
> > > > > > > Thirdly, you said that the node-pointer is now optional and i=
ntroduced
> > > > > > > the patch
> > > > > > > [PATCH net-next v12 10/15] net: stmmac: dwmac-loongson: Add f=
ull PCI support
> > > > > > > If so and the DT-based setting up isn't mandatory then I woul=
d
> > > > > > > suggest to proceed with the entire so called legacy setups on=
ly if the
> > > > > > > node-pointer has been found, otherwise the pure PCI-based set=
up would
> > > > > > > be performed. So the patches 10-13 (in your v12 order) would =
look
> > > > > > In this case, MSI will not be enabled when the node-pointer is =
found.
> > > > > >
> > > > > > .
> > > > > >
> > > > > >
> > > > > > In fact, a large fraction of 2k devices are DT-based, of course=
, many are
> > > > > > PCI-based.
> > > > > Then please summarise which devices need the DT-node pointer whic=
h
> > > > > don't? And most importantly if they do why do they need the DT-no=
de?
> > > > Whether we need DT-nodes doesn't depend on device type, but depends=
 on
> > > > the BIOS type. When we boot with UEFI+ACPI, we don't need DT-node,
> > > > when we boot with PMON+FDT, we need DT-node. Loongson machines may
> > > > have either BIOS types.
> > > Thanks for the answer. Just to fully clarify. Does it mean that all
> > > Loongson Ethernet controllers (Loongson GNET and GMAC) are able to
> > > deliver both PCI MSI IRQs and direct GIC IRQs (so called legacy)?
> >
>
> > No, only devices that support multiple channels can deliver both PCI MS=
I
> > IRQs
> >
> > and direct GIC IRQs, other devices can only deliver GIC IRQs.
> >
> > Furthermore, multiple channel features are bundled with MSI. If we want=
 to
> >
> > enable multiple channels, we must enable MSI.
>
> Sadly to say but this information changes a lot. Based on that the
> only platform with optional DT-node is the LS2K2000 GNET device. The
> rest of the devices (GMACs and LS7A2000 GNET) must be equipped with a
> node-pointer otherwise they won't work. Due to that the logic of the
> patches
> [PATCH net-next v12 10/15] net: stmmac: dwmac-loongson: Add full PCI supp=
ort
> [PATCH net-next v12 11/15] net: stmmac: dwmac-loongson: Add loongson_dwma=
c_config_legacy
> is incorrect.
>
> 1. [PATCH net-next v12 10/15] net: stmmac: dwmac-loongson: Add full PCI s=
upport
> So this patch doesn't add a pure PCI-based probe procedure after all
> because the Loongson GMACs are required to have a DT-node. AFAICS
> pdev->irq is actually the IRQ retrieved from the DT-node. So the "if
> (np) {} else {}" clause doesn't really make sense.
>
> 2. [PATCH net-next v12 11/15] net: stmmac: dwmac-loongson: Add loongson_d=
wmac_config_legacy
> First of all the function name is incorrect. The IRQ signal isn't legacy
> (INTx-based), but is retrieved from the DT-node. Secondly the
> "if (np) {} else {}" statement is very much redundant because if no
> DT-node found the pdev->irq won't be initialized at all, and the
> driver won't work with no error printed.
>
> All of that also affects the patch/commit logs. Glad we figured that
> out at this stage. Seeing there have been tons of another comments
> let's postpone the discussion around this problem for v13 then. I'll
> keep in mind the info you shared in this thread and think of the way
> to fix the patches after v13 is submitted for review.
Let me clarify the interrupt information, hope that can help you to
understand better:
1, Loongson machines may use UEFI (implies ACPI) or PMON/UBOOT
(implies FDT) as the BIOS.
2, The BIOS type has no relationship with device types, which means:
machines with GMAC can be either ACPI-based or FDT-based, machines
with GNET can also be either ACPI-based or FDT-based.
3, The existing Loongson driver can only support FDT, which means the
device should be PCI-probed and DT-configured. Though the existing
driver only supports GMAC, it doesn't mean that GMAC is bound to FDT.
GMAC can also work with ACPI, in that case we say it is "full PCI",
which means we don't need "np".
4, At present, multi-channel devices support MSI, currently only GNET
support MSI, but in future there may also GMAC support MSI.
5, So, in Yanteng's patches, a device firstly request MSI, and since
MSI is dynamically allocated, it doesn't care about the BIOS type
(ACPI or FDT). However, if MSI fails (either because MSI is exhausted
or the device doesn't support it), it fallback to "legacy" interrupt,
which means irq lines mapped to INT-A/B/C/D of PCI.
6. In the legacy case, the irq is get from DT-node (FDT case), or
already in pdev->irq (ACPI case). So Yanteng use a "if (np) { } else {
}", which is reasonable from my point of view.

So Yanteng's interrupt code is good for me, but I also agree to
improve that after v13, if needed.

Huacai

>
> Thanks
> -Serge(y)
>
> >
> > Thanks,
> >
> > Yanteng
> >


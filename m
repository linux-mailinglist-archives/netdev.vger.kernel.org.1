Return-Path: <netdev+bounces-96255-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CE8348C4BD2
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 06:58:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31C27B2319F
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 04:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26CB2125AC;
	Tue, 14 May 2024 04:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uqql+sVM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37FFBE47
	for <netdev@vger.kernel.org>; Tue, 14 May 2024 04:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715662728; cv=none; b=dvYevB/RdJwSJKgQJcKdXCPQVASThfjUcZucoMDjPPOSoMdt87IDmscXsYDJOUgJtUx+LfyLvCrU2781U4HTCPTBEwO0LeCT65lJGpJuhaH7l9VN3J2q+uy9Gs1jzvjVTvlnpzUOt+n1HVCmtFojcxu2CLwLtsO3u/2e5zgf/YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715662728; c=relaxed/simple;
	bh=yYx/Xtc4onCC3oUKRff/nBFnbMc2GOEpD4uI66hsORs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q9sPoFUqpB8iGmvL9dCGcBtyh511kiX/tjgOvLEmrujqu02P8EbJuPk/4vIvSmhiPLwrlMnHGyQkN20vzAdaRMOxpKo7d9lHyXQ+J8CHy3Q9YEHzbhphoygshuHkW9yQG/aVUwWWsv0kEI4dHgRrVEEnDuKBzmX5WT8SNCHMYC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uqql+sVM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56980C32782
	for <netdev@vger.kernel.org>; Tue, 14 May 2024 04:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715662727;
	bh=yYx/Xtc4onCC3oUKRff/nBFnbMc2GOEpD4uI66hsORs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=uqql+sVMPWOKi4zmxbJTUgeZkCr0pJSkJK9Riy9aMHEfvmSzbM+az+GbeK7nKjGVQ
	 2kaYrIFabCmGB7jyC8sq0chJGiaYcn9XY8IG4qNowhhUIpH08tmfbummfxM7AQESmG
	 G0+P1RjobVm7mTFAslrxpvZU4KZy4Nze48kgsYTce6QVKlucYlZOZGDn84uf0G7aW+
	 Z7YJ3zjMI1qlfPcUpTz7PBeGFK+Dj40RU4S09eNQY4M11V4vY0fyTrBWnc4zB3sf+V
	 Iv9ApvRHtZq+X9mbma6F6G5xUTknZ5kM/EtuHAgQlGFiW2UXiuo5MywIKTjIr3aFU9
	 5yW3rYEp2cXJA==
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a59ad344f7dso1042256466b.0
        for <netdev@vger.kernel.org>; Mon, 13 May 2024 21:58:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVECY73QCHFBJsxGClI1uzJMthQOVb9F0vicJIDQ2PRVAodLIMG3GRPfzeIMijRzPX1gXCIips8klwGLbpJP1uM6VDHvoAF
X-Gm-Message-State: AOJu0Yw6+Wf0jalWJcJVWEOYBzltQJzVnS5Bc6clp6lAN+ONBl9fSpd9
	mgivTUNqAoiMsekL1HmtGRyZLsBd50aAd7/MynvfXCa+ivIczWi/TtEfO9c0710UI6YJUlGkQ3d
	oke1TdK4QMJwPqz9waaUhWaaRbPg=
X-Google-Smtp-Source: AGHT+IEgVuox7etcjGOIXfKRcxVJNXtycKcLvRdBmOm4Kt4irz7hUFc3+yV3+iDXbmjz1WZ2o2oMmTX7Li8HjW0yea4=
X-Received: by 2002:a17:906:408f:b0:a59:b491:5d79 with SMTP id
 a640c23a62f3a-a5a2d585a7fmr728340866b.24.1715662725790; Mon, 13 May 2024
 21:58:45 -0700 (PDT)
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
 <CAAhV-H4TtoV9LAfhx1+fu40XgDqQ+W-tXt36XoieK87_ucBgcQ@mail.gmail.com> <nt5bjlmul5jchxvx6zzgvbmdsegpwwz7quzt57vfejnxng7smz@abqdfipuclzh>
In-Reply-To: <nt5bjlmul5jchxvx6zzgvbmdsegpwwz7quzt57vfejnxng7smz@abqdfipuclzh>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Tue, 14 May 2024 12:58:33 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5UMJvOtt+YFChqPC1eMkj5UjCEnFJ_YksWjk+uriZPzw@mail.gmail.com>
Message-ID: <CAAhV-H5UMJvOtt+YFChqPC1eMkj5UjCEnFJ_YksWjk+uriZPzw@mail.gmail.com>
Subject: Re: [PATCH net-next v12 13/15] net: stmmac: dwmac-loongson: Add
 Loongson GNET support
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Yanteng Si <siyanteng@loongson.cn>, andrew@lunn.ch, hkallweit1@gmail.com, 
	peppe.cavallaro@st.com, alexandre.torgue@foss.st.com, joabreu@synopsys.com, 
	Jose.Abreu@synopsys.com, linux@armlinux.org.uk, guyinggang@loongson.cn, 
	netdev@vger.kernel.org, chris.chenfeiyang@gmail.com, siyanteng01@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 14, 2024 at 12:11=E2=80=AFAM Serge Semin <fancer.lancer@gmail.c=
om> wrote:
>
> On Mon, May 13, 2024 at 09:26:11PM +0800, Huacai Chen wrote:
> > Hi, Serge,
> >
> > On Mon, May 13, 2024 at 6:57=E2=80=AFPM Serge Semin <fancer.lancer@gmai=
l.com> wrote:
> > >
> > > On Thu, May 09, 2024 at 04:57:44PM +0800, Yanteng Si wrote:
> > > > Hi Serge
> > > >
> > > > =E5=9C=A8 2024/5/8 23:10, Serge Semin =E5=86=99=E9=81=93:
> > > > > On Wed, May 08, 2024 at 10:58:16PM +0800, Huacai Chen wrote:
> > > > > > Hi, Serge,
> > > > > >
> > > > > > On Wed, May 8, 2024 at 10:38=E2=80=AFPM Serge Semin<fancer.lanc=
er@gmail.com>  wrote:
> > > > > > > On Tue, May 07, 2024 at 09:35:24PM +0800, Yanteng Si wrote:
> > > > > > > > Hi Serge,
> > > > > > > >
> > > > > > > > =E5=9C=A8 2024/5/6 18:39, Serge Semin =E5=86=99=E9=81=93:
> > > > > > > > > On Thu, Apr 25, 2024 at 09:11:36PM +0800, Yanteng Si wrot=
e:
> > > > > > > > > > ...
> > > > > > > > > > +static int loongson_dwmac_config_msi(struct pci_dev *p=
dev,
> > > > > > > > > > +                              struct plat_stmmacenet_d=
ata *plat,
> > > > > > > > > > +                              struct stmmac_resources =
*res,
> > > > > > > > > > +                              struct device_node *np)
> > > > > > > > > > +{
> > > > > > > > > > + int i, ret, vecs;
> > > > > > > > > > +
> > > > > > > > > > + vecs =3D roundup_pow_of_two(CHANNEL_NUM * 2 + 1);
> > > > > > > > > > + ret =3D pci_alloc_irq_vectors(pdev, vecs, vecs, PCI_I=
RQ_MSI);
> > > > > > > > > > + if (ret < 0) {
> > > > > > > > > > +         dev_info(&pdev->dev,
> > > > > > > > > > +                  "MSI enable failed, Fallback to lega=
cy interrupt\n");
> > > > > > > > > > +         return loongson_dwmac_config_legacy(pdev, pla=
t, res, np);
> > > > > > > > > > + }
> > > > > > > > > > +
> > > > > > > > > > + res->irq =3D pci_irq_vector(pdev, 0);
> > > > > > > > > > + res->wol_irq =3D 0;
> > > > > > > > > > +
> > > > > > > > > > + /* INT NAME | MAC | CH7 rx | CH7 tx | ... | CH0 rx | =
CH0 tx |
> > > > > > > > > > +  * --------- ----- -------- --------  ...  -------- -=
-------
> > > > > > > > > > +  * IRQ NUM  |  0  |   1    |   2    | ... |   15   | =
  16   |
> > > > > > > > > > +  */
> > > > > > > > > > + for (i =3D 0; i < CHANNEL_NUM; i++) {
> > > > > > > > > > +         res->rx_irq[CHANNEL_NUM - 1 - i] =3D
> > > > > > > > > > +                 pci_irq_vector(pdev, 1 + i * 2);
> > > > > > > > > > +         res->tx_irq[CHANNEL_NUM - 1 - i] =3D
> > > > > > > > > > +                 pci_irq_vector(pdev, 2 + i * 2);
> > > > > > > > > > + }
> > > > > > > > > > +
> > > > > > > > > > + plat->flags |=3D STMMAC_FLAG_MULTI_MSI_EN;
> > > > > > > > > > +
> > > > > > > > > > + return 0;
> > > > > > > > > > +}
> > > > > > > > > > +
> > > > > > > > > > ...
> > > > > > > > > >    static int loongson_dwmac_probe(struct pci_dev *pdev=
, const struct pci_device_id *id)
> > > > > > > > > >    {
> > > > > > > > > >            struct plat_stmmacenet_data *plat;
> > > > > > > > > >            int ret, i, bus_id, phy_mode;
> > > > > > > > > >            struct stmmac_pci_info *info;
> > > > > > > > > >            struct stmmac_resources res;
> > > > > > > > > > + struct loongson_data *ld;
> > > > > > > > > >            struct device_node *np;
> > > > > > > > > >            np =3D dev_of_node(&pdev->dev);
> > > > > > > > > > @@ -122,10 +460,12 @@ static int loongson_dwmac_probe(s=
truct pci_dev *pdev, const struct pci_device_id
> > > > > > > > > >                    return -ENOMEM;
> > > > > > > > > >            plat->dma_cfg =3D devm_kzalloc(&pdev->dev, s=
izeof(*plat->dma_cfg), GFP_KERNEL);
> > > > > > > > > > - if (!plat->dma_cfg) {
> > > > > > > > > > -         ret =3D -ENOMEM;
> > > > > > > > > > -         goto err_put_node;
> > > > > > > > > > - }
> > > > > > > > > > + if (!plat->dma_cfg)
> > > > > > > > > > +         return -ENOMEM;
> > > > > > > > > > +
> > > > > > > > > > + ld =3D devm_kzalloc(&pdev->dev, sizeof(*ld), GFP_KERN=
EL);
> > > > > > > > > > + if (!ld)
> > > > > > > > > > +         return -ENOMEM;
> > > > > > > > > >            /* Enable pci device */
> > > > > > > > > >            ret =3D pci_enable_device(pdev);
> > > > > > > > > > @@ -171,14 +511,34 @@ static int loongson_dwmac_probe(s=
truct pci_dev *pdev, const struct pci_device_id
> > > > > > > > > >                    plat->phy_interface =3D phy_mode;
> > > > > > > > > >            }
> > > > > > > > > > - pci_enable_msi(pdev);
> > > > > > > > > > + plat->bsp_priv =3D ld;
> > > > > > > > > > + plat->setup =3D loongson_dwmac_setup;
> > > > > > > > > > + ld->dev =3D &pdev->dev;
> > > > > > > > > > +
> > > > > > > > > >            memset(&res, 0, sizeof(res));
> > > > > > > > > >            res.addr =3D pcim_iomap_table(pdev)[0];
> > > > > > > > > > + ld->gmac_verion =3D readl(res.addr + GMAC_VERSION) & =
0xff;
> > > > > > > > > > +
> > > > > > > > > > + switch (ld->gmac_verion) {
> > > > > > > > > > + case LOONGSON_DWMAC_CORE_1_00:
> > > > > > > > > > +         plat->rx_queues_to_use =3D CHANNEL_NUM;
> > > > > > > > > > +         plat->tx_queues_to_use =3D CHANNEL_NUM;
> > > > > > > > > > +
> > > > > > > > > > +         /* Only channel 0 supports checksum,
> > > > > > > > > > +          * so turn off checksum to enable multiple ch=
annels.
> > > > > > > > > > +          */
> > > > > > > > > > +         for (i =3D 1; i < CHANNEL_NUM; i++)
> > > > > > > > > > +                 plat->tx_queues_cfg[i].coe_unsupporte=
d =3D 1;
> > > > > > > > > > - plat->tx_queues_to_use =3D 1;
> > > > > > > > > > - plat->rx_queues_to_use =3D 1;
> > > > > > > > > > +         ret =3D loongson_dwmac_config_msi(pdev, plat,=
 &res, np);
> > > > > > > > > > +         break;
> > > > > > > > > > + default:        /* 0x35 device and 0x37 device. */
> > > > > > > > > > +         plat->tx_queues_to_use =3D 1;
> > > > > > > > > > +         plat->rx_queues_to_use =3D 1;
> > > > > > > > > > - ret =3D loongson_dwmac_config_legacy(pdev, plat, &res=
, np);
> > > > > > > > > > +         ret =3D loongson_dwmac_config_legacy(pdev, pl=
at, &res, np);
> > > > > > > > > > +         break;
> > > > > > > > > > + }
> > > > > > > > > Let's now talk about this change.
> > > > > > > > >
> > > > > > > > > First of all, one more time. You can't miss the return va=
lue check
> > > > > > > > > because if any of the IRQ config method fails then the dr=
iver won't
> > > > > > > > > work! The first change that introduces the problem is in =
the patch
> > > > > > > > > [PATCH net-next v12 11/15] net: stmmac: dwmac-loongson: A=
dd loongson_dwmac_config_legacy
> > > > > > > > OK!
> > > > > > > > > Second, as I already mentioned in another message sent to=
 this patch
> > > > > > > > > you are missing the PCI MSI IRQs freeing in the cleanup-o=
n-error path
> > > > > > > > > and in the device/driver remove() function. It's definite=
ly wrong.
> > > > > > > > You are right! I will do it.
> > > > > > > > > Thirdly, you said that the node-pointer is now optional a=
nd introduced
> > > > > > > > > the patch
> > > > > > > > > [PATCH net-next v12 10/15] net: stmmac: dwmac-loongson: A=
dd full PCI support
> > > > > > > > > If so and the DT-based setting up isn't mandatory then I =
would
> > > > > > > > > suggest to proceed with the entire so called legacy setup=
s only if the
> > > > > > > > > node-pointer has been found, otherwise the pure PCI-based=
 setup would
> > > > > > > > > be performed. So the patches 10-13 (in your v12 order) wo=
uld look
> > > > > > > > In this case, MSI will not be enabled when the node-pointer=
 is found.
> > > > > > > >
> > > > > > > > .
> > > > > > > >
> > > > > > > >
> > > > > > > > In fact, a large fraction of 2k devices are DT-based, of co=
urse, many are
> > > > > > > > PCI-based.
> > > > > > > Then please summarise which devices need the DT-node pointer =
which
> > > > > > > don't? And most importantly if they do why do they need the D=
T-node?
> > > > > > Whether we need DT-nodes doesn't depend on device type, but dep=
ends on
> > > > > > the BIOS type. When we boot with UEFI+ACPI, we don't need DT-no=
de,
> > > > > > when we boot with PMON+FDT, we need DT-node. Loongson machines =
may
> > > > > > have either BIOS types.
> > > > > Thanks for the answer. Just to fully clarify. Does it mean that a=
ll
> > > > > Loongson Ethernet controllers (Loongson GNET and GMAC) are able t=
o
> > > > > deliver both PCI MSI IRQs and direct GIC IRQs (so called legacy)?
> > > >
> > >
> > > > No, only devices that support multiple channels can deliver both PC=
I MSI
> > > > IRQs
> > > >
> > > > and direct GIC IRQs, other devices can only deliver GIC IRQs.
> > > >
> > > > Furthermore, multiple channel features are bundled with MSI. If we =
want to
> > > >
> > > > enable multiple channels, we must enable MSI.
> > >
> > > Sadly to say but this information changes a lot. Based on that the
> > > only platform with optional DT-node is the LS2K2000 GNET device. The
> > > rest of the devices (GMACs and LS7A2000 GNET) must be equipped with a
> > > node-pointer otherwise they won't work. Due to that the logic of the
> > > patches
> > > [PATCH net-next v12 10/15] net: stmmac: dwmac-loongson: Add full PCI =
support
> > > [PATCH net-next v12 11/15] net: stmmac: dwmac-loongson: Add loongson_=
dwmac_config_legacy
> > > is incorrect.
> > >
> > > 1. [PATCH net-next v12 10/15] net: stmmac: dwmac-loongson: Add full P=
CI support
> > > So this patch doesn't add a pure PCI-based probe procedure after all
> > > because the Loongson GMACs are required to have a DT-node. AFAICS
> > > pdev->irq is actually the IRQ retrieved from the DT-node. So the "if
> > > (np) {} else {}" clause doesn't really make sense.
> > >
> > > 2. [PATCH net-next v12 11/15] net: stmmac: dwmac-loongson: Add loongs=
on_dwmac_config_legacy
> > > First of all the function name is incorrect. The IRQ signal isn't leg=
acy
> > > (INTx-based), but is retrieved from the DT-node. Secondly the
> > > "if (np) {} else {}" statement is very much redundant because if no
> > > DT-node found the pdev->irq won't be initialized at all, and the
> > > driver won't work with no error printed.
> > >
> > > All of that also affects the patch/commit logs. Glad we figured that
> > > out at this stage. Seeing there have been tons of another comments
> > > let's postpone the discussion around this problem for v13 then. I'll
> > > keep in mind the info you shared in this thread and think of the way
> > > to fix the patches after v13 is submitted for review.
> > Let me clarify the interrupt information, hope that can help you to
> > understand better:
>
> > 1, Loongson machines may use UEFI (implies ACPI) or PMON/UBOOT
> > (implies FDT) as the BIOS.
>
> Ok. Aside with the OF-based platform there is an ACPI case.
>
> > 2, The BIOS type has no relationship with device types, which means:
> > machines with GMAC can be either ACPI-based or FDT-based, machines
> > with GNET can also be either ACPI-based or FDT-based.
>
> Ok. It's either-or. Got it.
>
> > 3, The existing Loongson driver can only support FDT, which means the
> > device should be PCI-probed and DT-configured. Though the existing
> > driver only supports GMAC, it doesn't mean that GMAC is bound to FDT.
> > GMAC can also work with ACPI, in that case we say it is "full PCI",
> > which means we don't need "np".
>
> "full PCI" statement can't be utilized for the case of the ACPI-based
> IRQ assignment. "full PCI" is the way the GNET probe procedure works -
> everything required for the device handling is detected in runtime
> with no ACPI/DT stuff.
>
> So the patch 10 with the "full PCI"-related subject doesn't actually
> adds the PCIe-only-based device probe support, but actually converts
> the driver to supporting the ACPI-case.)
Yes, the commit message can be improved.

>
> > 4, At present, multi-channel devices support MSI, currently only GNET
> > support MSI, but in future there may also GMAC support MSI.
>
> It's better to avoid adding a support for hypothetical devices and
> prohibit all the currently unreal cases. It will simplify the code,
> ease it' maintenance, reduce the bugs probability.
>
> > 5, So, in Yanteng's patches, a device firstly request MSI, and since
> > MSI is dynamically allocated, it doesn't care about the BIOS type
> > (ACPI or FDT). However, if MSI fails (either because MSI is exhausted
> > or the device doesn't support it), it fallback to "legacy" interrupt,
> > which means irq lines mapped to INT-A/B/C/D of PCI.
>
> Unless we are talking about the actual PCI devices (not PCI express)
> or the cases where the INT-x is emulated by means the specific PCIe
> TLPs, I wouldn't mentioned the INTx or "legacy" names in the current
> context. It's just a platform ACPI/DT IRQs.
Yes, it is probably a platform ACPI/DT IRQ, but I think the "legacy"
name is still reasonable in this case. Otherwise, what does "legacy"
stand for in "PCI_IRQ_LEGACY/PCI_IRQ_MSI/PCI_IRQ_MSIX"?

>
> > 6. In the legacy case, the irq is get from DT-node (FDT case), or
> > already in pdev->irq (ACPI case).
>
> It will be in the pdev->irq in any case whether it's DT or ACPI. See:
>
> ACPI:
> pci_device_probe():
> +-> arch/loongarch/pci/pci.c:pcibios_alloc_irq()
>
> DT:
> pci_device_probe():
> +-> pci_assign_irq();
>     +-> pci_host_bridge::map_irq()
>         +-> of_irq_parse_and_map_pci()
>         or in case of Loongson PCIe host controller:
>         +-> drivers/pci/controller/pci-loongson.c::loongson_map_irq()
>
> Moreover unless the MSI IRQs are enabled, the platform IRQ (and the
> legacy IRQ) can be retrieved by means of the pci_irq_vector() method.
> The only reason of having the direct OF-based IRQs getting in the
> Loongson DWMAC driver I see is that the LPI IRQ will be missing in
> case of the pci_irq_vector() method utilization. In the rest of the
> cases the pci_irq_vector() function could be freely used.
Yes, in the DT case, they may be macirq, eth_wake_irq and eth_lpi,
rather than a single irq, so we need an if-else here.

>
> >  So Yanteng use a "if (np) { } else {
> > }", which is reasonable from my point of view.
> >
>
> At least one problem is there. What if pdev->irq isn't initialized
> (initialized with zero)?..
As you said above, both ACPI and DT initialized pdev->irq, unless
there is a bug in BIOS.


Huacai

>
> > So Yanteng's interrupt code is good for me, but I also agree to
> > improve that after v13, if needed.
>
> Ok. I've got much better picture about what is going on under the
> hood. Thanks. In anyway I'll get back to this topic in details in v13.
>
> -Serge(y)
>
> >
> > Huacai
> >
> > >
> > > Thanks
> > > -Serge(y)
> > >
> > > >
> > > > Thanks,
> > > >
> > > > Yanteng
> > > >


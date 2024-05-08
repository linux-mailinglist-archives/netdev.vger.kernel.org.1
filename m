Return-Path: <netdev+bounces-94638-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8DD28C0088
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 16:58:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53CA01F218C8
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 14:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFE8286653;
	Wed,  8 May 2024 14:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h3O049BE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51239126F27
	for <netdev@vger.kernel.org>; Wed,  8 May 2024 14:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715180311; cv=none; b=nOtGEgyyFZ23eSVvTgQagAVwyiJbYXKnR3zmoxaDImU6t5vtOHljquqHYLP2qbUNwBAO2idKNDF6x81DvaMOFRLitqmuKXxHMsGl5piLatlSBsCBfbgBPAf5MHtIuR8JEVFxMng00uB4r3IqlY+bwq2Ab2nISttB+hx+s3h20Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715180311; c=relaxed/simple;
	bh=86auDagn5oiLg83Gx5Yg0tRLMHbY2vUzobpiGZwYg2M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cs4lLAJyJl5ZGQDuNjv4lNTUJqZl8+LqYMIahDFwolV04NCbkv9acGvsVdbwN0g9N6rDmRrW1NF0JYADuCYNBlCisr/tojMa6bQx3ojkzmo/zwTRck0o+2G7uwii4QFQZnGIW9b+J81lNDYdmryxJFKALgCmnJbreL6Xr6EfMsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h3O049BE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3EACC32781
	for <netdev@vger.kernel.org>; Wed,  8 May 2024 14:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715180310;
	bh=86auDagn5oiLg83Gx5Yg0tRLMHbY2vUzobpiGZwYg2M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=h3O049BEwiTbpxmRnatOs8W7ufLvF4IeSBrbmCIFxR9b1hog45zaZ9x26IXmluEjW
	 8N/ZiDatE97ZzxYvQrzIjINm3LzeyuOBaa2cDbfRlmAqvk3c2K57kFMYDrGukCoH3g
	 8sFZ7idxlPzML6+vcijUTaml6DtRJFY93p9lMwwrWXk8XNsY9ZhUX6BVN/kNw/Cm/W
	 jwVKzaqNzB2vKG+YVtzEhvJrbw89zwrir3EnFDRpvlTZUlXnHqQ5/GJFBX3+E1P2Gj
	 12gy44XygWNR70xVzs6/JWPFPDyTH30ksqLpVVpP9Jwchch9fvd/E+GlIyNYTifqTu
	 XukLQ3jH97Ttw==
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a59c0a6415fso1050737466b.1
        for <netdev@vger.kernel.org>; Wed, 08 May 2024 07:58:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUAyqyNtBd/vlcZiD/4RfexXKQjledbxvV3igyEnYbHpv6Nifj6+e+DgORB3GQ+mD56NJCIepYyuOusdTruttpErqhuemEr
X-Gm-Message-State: AOJu0YyxXLqEdzlcoxwN/fhJXZjcUyWPzogZXQSdmV/orNSll4AobKIk
	/vbnJA0XuJa9R0Vd80mN4dJLlf+3D7Gsz7kaDSbIGcLKcswe98ZHpSUPaZH7XSw6oqO10GSS1OG
	Zmuy0RKdGYdx02rvzqB8ThX4xLlE=
X-Google-Smtp-Source: AGHT+IHvwO+pN4fRDooIheffe4iXuuy6tKq/NAI3/Qo+f0X/py6OwRB84JPZ6TaVV138wFRFPoXJtmOAeIIx9S7UG0E=
X-Received: by 2002:a17:907:9482:b0:a59:d063:f5f3 with SMTP id
 a640c23a62f3a-a59fb9db658mr235896866b.63.1715180309251; Wed, 08 May 2024
 07:58:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1714046812.git.siyanteng@loongson.cn> <c97cb15ab77fb9dfdd281640f48dcfc08c6988c0.1714046812.git.siyanteng@loongson.cn>
 <jkjgjraqvih4zu7wvqykerq5wisgkhqf2n2pouha7qhfoeif7v@tkwyx53dfrdw>
 <150b03ff-70b5-488a-b5e6-5f74b6398b20@loongson.cn> <pdyqoki5qw4zabz3uv5ff2e2o43htcr6xame652zmbqh23tjji@lt5gmp6m3lkm>
In-Reply-To: <pdyqoki5qw4zabz3uv5ff2e2o43htcr6xame652zmbqh23tjji@lt5gmp6m3lkm>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Wed, 8 May 2024 22:58:16 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7Dz0CVysUVVVe4Y8qGxpmwJ0i6y2wKnATzNS=5DR_vZg@mail.gmail.com>
Message-ID: <CAAhV-H7Dz0CVysUVVVe4Y8qGxpmwJ0i6y2wKnATzNS=5DR_vZg@mail.gmail.com>
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

On Wed, May 8, 2024 at 10:38=E2=80=AFPM Serge Semin <fancer.lancer@gmail.co=
m> wrote:
>
> On Tue, May 07, 2024 at 09:35:24PM +0800, Yanteng Si wrote:
> > Hi Serge,
> >
> > =E5=9C=A8 2024/5/6 18:39, Serge Semin =E5=86=99=E9=81=93:
> > > On Thu, Apr 25, 2024 at 09:11:36PM +0800, Yanteng Si wrote:
> > > > ...
> > > > +static int loongson_dwmac_config_msi(struct pci_dev *pdev,
> > > > +                              struct plat_stmmacenet_data *plat,
> > > > +                              struct stmmac_resources *res,
> > > > +                              struct device_node *np)
> > > > +{
> > > > + int i, ret, vecs;
> > > > +
> > > > + vecs =3D roundup_pow_of_two(CHANNEL_NUM * 2 + 1);
> > > > + ret =3D pci_alloc_irq_vectors(pdev, vecs, vecs, PCI_IRQ_MSI);
> > > > + if (ret < 0) {
> > > > +         dev_info(&pdev->dev,
> > > > +                  "MSI enable failed, Fallback to legacy interrupt=
\n");
> > > > +         return loongson_dwmac_config_legacy(pdev, plat, res, np);
> > > > + }
> > > > +
> > > > + res->irq =3D pci_irq_vector(pdev, 0);
> > > > + res->wol_irq =3D 0;
> > > > +
> > > > + /* INT NAME | MAC | CH7 rx | CH7 tx | ... | CH0 rx | CH0 tx |
> > > > +  * --------- ----- -------- --------  ...  -------- --------
> > > > +  * IRQ NUM  |  0  |   1    |   2    | ... |   15   |   16   |
> > > > +  */
> > > > + for (i =3D 0; i < CHANNEL_NUM; i++) {
> > > > +         res->rx_irq[CHANNEL_NUM - 1 - i] =3D
> > > > +                 pci_irq_vector(pdev, 1 + i * 2);
> > > > +         res->tx_irq[CHANNEL_NUM - 1 - i] =3D
> > > > +                 pci_irq_vector(pdev, 2 + i * 2);
> > > > + }
> > > > +
> > > > + plat->flags |=3D STMMAC_FLAG_MULTI_MSI_EN;
> > > > +
> > > > + return 0;
> > > > +}
> > > > +
> > > > ...
> > > >   static int loongson_dwmac_probe(struct pci_dev *pdev, const struc=
t pci_device_id *id)
> > > >   {
> > > >           struct plat_stmmacenet_data *plat;
> > > >           int ret, i, bus_id, phy_mode;
> > > >           struct stmmac_pci_info *info;
> > > >           struct stmmac_resources res;
> > > > + struct loongson_data *ld;
> > > >           struct device_node *np;
> > > >           np =3D dev_of_node(&pdev->dev);
> > > > @@ -122,10 +460,12 @@ static int loongson_dwmac_probe(struct pci_de=
v *pdev, const struct pci_device_id
> > > >                   return -ENOMEM;
> > > >           plat->dma_cfg =3D devm_kzalloc(&pdev->dev, sizeof(*plat->=
dma_cfg), GFP_KERNEL);
> > > > - if (!plat->dma_cfg) {
> > > > -         ret =3D -ENOMEM;
> > > > -         goto err_put_node;
> > > > - }
> > > > + if (!plat->dma_cfg)
> > > > +         return -ENOMEM;
> > > > +
> > > > + ld =3D devm_kzalloc(&pdev->dev, sizeof(*ld), GFP_KERNEL);
> > > > + if (!ld)
> > > > +         return -ENOMEM;
> > > >           /* Enable pci device */
> > > >           ret =3D pci_enable_device(pdev);
> > > > @@ -171,14 +511,34 @@ static int loongson_dwmac_probe(struct pci_de=
v *pdev, const struct pci_device_id
> > > >                   plat->phy_interface =3D phy_mode;
> > > >           }
> > > > - pci_enable_msi(pdev);
> > > > + plat->bsp_priv =3D ld;
> > > > + plat->setup =3D loongson_dwmac_setup;
> > > > + ld->dev =3D &pdev->dev;
> > > > +
> > > >           memset(&res, 0, sizeof(res));
> > > >           res.addr =3D pcim_iomap_table(pdev)[0];
> > > > + ld->gmac_verion =3D readl(res.addr + GMAC_VERSION) & 0xff;
> > > > +
> > > > + switch (ld->gmac_verion) {
> > > > + case LOONGSON_DWMAC_CORE_1_00:
> > > > +         plat->rx_queues_to_use =3D CHANNEL_NUM;
> > > > +         plat->tx_queues_to_use =3D CHANNEL_NUM;
> > > > +
> > > > +         /* Only channel 0 supports checksum,
> > > > +          * so turn off checksum to enable multiple channels.
> > > > +          */
> > > > +         for (i =3D 1; i < CHANNEL_NUM; i++)
> > > > +                 plat->tx_queues_cfg[i].coe_unsupported =3D 1;
> > > > - plat->tx_queues_to_use =3D 1;
> > > > - plat->rx_queues_to_use =3D 1;
> > > > +         ret =3D loongson_dwmac_config_msi(pdev, plat, &res, np);
> > > > +         break;
> > > > + default:        /* 0x35 device and 0x37 device. */
> > > > +         plat->tx_queues_to_use =3D 1;
> > > > +         plat->rx_queues_to_use =3D 1;
> > > > - ret =3D loongson_dwmac_config_legacy(pdev, plat, &res, np);
> > > > +         ret =3D loongson_dwmac_config_legacy(pdev, plat, &res, np=
);
> > > > +         break;
> > > > + }
> > > Let's now talk about this change.
> > >
> > > First of all, one more time. You can't miss the return value check
> > > because if any of the IRQ config method fails then the driver won't
> > > work! The first change that introduces the problem is in the patch
> > > [PATCH net-next v12 11/15] net: stmmac: dwmac-loongson: Add loongson_=
dwmac_config_legacy
> > OK!
> > >
> > > Second, as I already mentioned in another message sent to this patch
> > > you are missing the PCI MSI IRQs freeing in the cleanup-on-error path
> > > and in the device/driver remove() function. It's definitely wrong.
> > You are right! I will do it.
> > > Thirdly, you said that the node-pointer is now optional and introduce=
d
> > > the patch
> > > [PATCH net-next v12 10/15] net: stmmac: dwmac-loongson: Add full PCI =
support
> > > If so and the DT-based setting up isn't mandatory then I would
> > > suggest to proceed with the entire so called legacy setups only if th=
e
> > > node-pointer has been found, otherwise the pure PCI-based setup would
> > > be performed. So the patches 10-13 (in your v12 order) would look
> >
> > In this case, MSI will not be enabled when the node-pointer is found.
> >
> > .
> >
> >
> > In fact, a large fraction of 2k devices are DT-based, of course, many a=
re
> > PCI-based.
>
> Then please summarise which devices need the DT-node pointer which
> don't? And most importantly if they do why do they need the DT-node?
Whether we need DT-nodes doesn't depend on device type, but depends on
the BIOS type. When we boot with UEFI+ACPI, we don't need DT-node,
when we boot with PMON+FDT, we need DT-node. Loongson machines may
have either BIOS types.

Huacai

>
> AFAICS currently both LS2K1000 and LS7A1000 GMACs require the DT-node
> to get the MAC and LPI IRQ signals. AFAICS from your series LS7A2000
> GNET is also DT-based for the same reason. But the LS2K2000 GNET case
> is different. You say that some of the platforms have the respective
> DT-node some don't, but at the same time you submitting this patch
> which permits the MSI IRQs only for the LS7A2000 GNET. It looks
> contradicting. Does it mean that the GNET devices may generate the
> IRQs via both legacy (an IRQ signal directly connected to the system
> GIC) and the PCI MSI ways?
>
> Let's get the question to the more generic level. Are the Loongson
> GNET and GMAC controllers able to generate the IRQs via both ways:
> physical IRQ signal and PCI MSI?
>
> Please don't consider this as a vastly meticulous review. I am just
> trying to figure out how to make things less complicated and fix the
> driver to permitting only the cases which are actually possible.
>
> -Serge(y)
>
> >
> >
> > Thanks,
> >
> > Yanteng
> >
> >


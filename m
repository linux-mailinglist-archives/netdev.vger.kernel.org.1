Return-Path: <netdev+bounces-97074-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D64378C906B
	for <lists+netdev@lfdr.de>; Sat, 18 May 2024 12:47:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0DDD1C20D2E
	for <lists+netdev@lfdr.de>; Sat, 18 May 2024 10:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7248E12E63;
	Sat, 18 May 2024 10:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f23mlsYA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97731773A
	for <netdev@vger.kernel.org>; Sat, 18 May 2024 10:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716029267; cv=none; b=aSmAlbM4MulV8Mz8SX/ZGX0fx0ciyGkkILp67wG8eSz7Nuv8+jUQXei265kiWS64PuADXm/Ip0/UwYgSAz1+rN8vD1rbaeb6h6NO5Cuz+XicSmosNwacfuzQQcIJLOMnlKsboWgUK1z7dOcTvUKTHdv6g0zp+9bAKh3uZ6+qIeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716029267; c=relaxed/simple;
	bh=HFnmgkfspCb14MK6hxS3fOHPoNB1+VO7NApvLkWLLzs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aO0Pg8xpXY0WS0A0lr6Azir6hjkdU0PMfZErAWskYadQySun6XVAT0Ai/Dig9LYdVEgf2XiyxlFkZgzBhQtZaDRVxpeKPDyDIPX8bhs6Voqpn6mPXphYTxC+I2ttR9rEj1RKPWMReznBzJGBxErVDA/9Tjb9VTD6plCmuXeJgSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f23mlsYA; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-df1cfa7f124so1063397276.3
        for <netdev@vger.kernel.org>; Sat, 18 May 2024 03:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716029265; x=1716634065; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=27GCOqnE5EEpe5aZzGImCB4UsEWyZlNpfXZNd8t+YCI=;
        b=f23mlsYAJSIJMF9eh36hhc/Y/dND1rI+cOggKjSr45PbDdhuwLnEGeWs8WUb/GRFiA
         zpkeFkZCHszsQ5Sclnr540QUaEefamDa+6hY8FeAp1hrtXzkq1zf+88+VZDRIS5zggHY
         Aq2sWKkXTxDIO+Mm1cCLahwpYRfTkwZGI5bbJpMPv0VR0veUt4HvfGb6E8f1Va3SSmYD
         XHcV6A9SPdjMoa59h577f1ruJ51+KmCraBKR4Qq3ACmBo6n26feB7ANeHJ2hTAE/nXl5
         IY9oTlKL3NBYGfcqnqX7K55VQpGd+MeGP/ACBneIFLBuF+xxdU88wGGdgz1KmTYdqShq
         g03A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716029265; x=1716634065;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=27GCOqnE5EEpe5aZzGImCB4UsEWyZlNpfXZNd8t+YCI=;
        b=jz/zb/CkFrMAIcl3JctLJa196KkRwIMl72eTgF+Db56vI9kijMh/G623RiFPVvNL3v
         NK2G4eOCpHRFDjSHH5X+gFO6qeULyPwkKJnBmS3o0eP7A1NybSQ1ytwpmDUKE1cpGW6S
         y6yFNYnaZwRDhiCKcXP299O083gwpK1QkOO3UjrcGIPWRX8AMJ0NXHaGcIGur6rHRvjT
         pBHXxXrhR9sjldgrTlsV5IUUENCqhXlWt6zPgGRqXD+tyAAZWYl48284bBY1/w+vrVCy
         NyVDXeWF+WbPYOmbTg4Z6POxEmR5tIDieDasqkwf2K/ZJAW2VSUh5qIB2THTTgpHZ7wJ
         Jq1Q==
X-Forwarded-Encrypted: i=1; AJvYcCUz5go2IvG26GLHwpFwxveGh37ztTptdKb4i5PzkgipUUo1oNZUtFBMA8yMxXuC7wKTmb/T5VE9Rb89kWuRv64xbf88yPEi
X-Gm-Message-State: AOJu0Yy9BuEUOobtJHRINzKNx3icimXy1FBKWQRs+JlurBMJNVD8+8Fc
	dOO3huHu73Yeyx74ZPlm62FKPe2tFakdiksq2Q7j8lb9pXO4lbXJCJE8eFA9e0EQE551vOfQTOc
	F5aW4E1ijOYrpuxniJgYKaQzjcUw=
X-Google-Smtp-Source: AGHT+IEfz9yQJBiewxJdXe5P6INhEXxEVTAZpMPGXnkg+mlI2QcqvMLxfx9Ob9CZgK1/5SoL4X6H49XbY0KVATSzAkY=
X-Received: by 2002:a25:a1a5:0:b0:de4:603f:cc2a with SMTP id
 3f1490d57ef6-dee4f35503fmr23034786276.45.1716029264394; Sat, 18 May 2024
 03:47:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAhV-H4TtoV9LAfhx1+fu40XgDqQ+W-tXt36XoieK87_ucBgcQ@mail.gmail.com>
 <nt5bjlmul5jchxvx6zzgvbmdsegpwwz7quzt57vfejnxng7smz@abqdfipuclzh>
 <CAAhV-H5UMJvOtt+YFChqPC1eMkj5UjCEnFJ_YksWjk+uriZPzw@mail.gmail.com>
 <d2ibcsxpzrhjzjt4zu7tmopgyp6q77omgweobzidsp53yadcgz@x5774dqqs7qr>
 <CAAhV-H7Fck+cd14RSUkEPrB=6=35JGkHLBCtrYTGD924fYi2VA@mail.gmail.com>
 <xa2ewgfe3qjljsraet5d77qk3dygcvexnqk5atm5fm5oro3ogp@xctegdmx2srt>
 <CAAhV-H5JT+QfZgHX7K3HYLFSxuZeer4PdUPjehtyXKcfi=L2oQ@mail.gmail.com>
 <460a6b52-249e-4d50-8d3e-28cc9da6a01b@loongson.cn> <l3bkpa2bw2gsiir2ybzzin2dusarlvzyai3zge62kxrkfomixb@ryaxhawhgylt>
 <c09237c6-6661-4744-a9d3-7c3443f2820c@loongson.cn> <ikmwqzwplbnorwrao6afj6t4iksgo4t7jk6to65pnmtqgmalkv@gnrv5cskqlsb>
In-Reply-To: <ikmwqzwplbnorwrao6afj6t4iksgo4t7jk6to65pnmtqgmalkv@gnrv5cskqlsb>
From: yanteng si <siyanteng01@gmail.com>
Date: Sat, 18 May 2024 18:47:28 +0800
Message-ID: <CAEensMxS-+RNj8j+QSYnBZzXLQ88M-d-4D=DvNr1y-pW81fAcg@mail.gmail.com>
Subject: Re: [PATCH net-next v12 13/15] net: stmmac: dwmac-loongson: Add
 Loongson GNET support
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Yanteng Si <siyanteng@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, andrew@lunn.ch, 
	hkallweit1@gmail.com, peppe.cavallaro@st.com, alexandre.torgue@foss.st.com, 
	joabreu@synopsys.com, Jose.Abreu@synopsys.com, linux@armlinux.org.uk, 
	guyinggang@loongson.cn, netdev@vger.kernel.org, chris.chenfeiyang@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Serge Semin <fancer.lancer@gmail.com> =E4=BA=8E2024=E5=B9=B45=E6=9C=8818=E6=
=97=A5=E5=91=A8=E5=85=AD 00:37=E5=86=99=E9=81=93=EF=BC=9A
>
> On Fri, May 17, 2024 at 06:37:50PM +0800, Yanteng Si wrote:
> > Hi Serge,
> >
> > =E5=9C=A8 2024/5/17 17:07, Serge Semin =E5=86=99=E9=81=93:
> > > On Fri, May 17, 2024 at 04:42:51PM +0800, Yanteng Si wrote:
> > > > Hi Huacai, Serge,
> > > >
> > > > =E5=9C=A8 2024/5/15 21:55, Huacai Chen =E5=86=99=E9=81=93:
> > > > > > > > Once again about the naming. From the retrospective point o=
f view the
> > > > > > > > so called legacy PCI IRQs (in fact PCI INTx) and the platfo=
rm IRQs
> > > > > > > > look similar because these are just the level-type signals =
connected
> > > > > > > > to the system IRQ controller. But when it comes to the PCI_=
Express_,
> > > > > > > > the implementation is completely different. The PCIe INTx i=
s just the
> > > > > > > > PCIe TLPs of special type, like MSI. Upon receiving these s=
pecial
> > > > > > > > messages the PCIe host controller delivers the IRQ up to th=
e
> > > > > > > > respective system IRQ controller. So in order to avoid the =
confusion
> > > > > > > > between the actual legacy PCI INTx, PCI Express INTx and th=
e just
> > > > > > > > platform IRQs, it's better to emphasize the actual way of t=
he IRQs
> > > > > > > > delivery. In this case it's the later method.
> > > > > > > You are absolutely right, and I think I found a method to use=
 your
> > > > > > > framework to solve our problems:
> > > > > > >
> > > > > > >      static int loongson_dwmac_config_irqs(struct pci_dev *pd=
ev,
> > > > > > >                                             struct plat_stmma=
cenet_data *plat,
> > > > > > >                                             struct stmmac_res=
ources *res)
> > > > > > >      {
> > > > > > >          int i, ret, vecs;
> > > > > > >
> > > > > > >          /* INT NAME | MAC | CH7 rx | CH7 tx | ... | CH0 rx |=
 CH0 tx |
> > > > > > >           * --------- ----- -------- --------  ...  -------- =
--------
> > > > > > >           * IRQ NUM  |  0  |   1    |   2    | ... |   15   |=
   16   |
> > > > > > >           */
> > > > > > >          vecs =3D plat->rx_queues_to_use + plat->tx_queues_to=
_use + 1;
> > > > > > >          ret =3D pci_alloc_irq_vectors(pdev, 1, vecs, PCI_IRQ=
_MSI | PCI_IRQ_INTX);
> > > > > > >          if (ret < 0) {
> > > > > > >                  dev_err(&pdev->dev, "Failed to allocate PCI =
IRQs\n");
> > > > > > >                  return ret;
> > > > > > >          }
> > > > > > >         if (ret >=3D vecs) {
> > > > > > >                  for (i =3D 0; i < plat->rx_queues_to_use; i+=
+) {
> > > > > > >                          res->rx_irq[CHANNELS_NUM - 1 - i] =
=3D
> > > > > > >                                  pci_irq_vector(pdev, 1 + i *=
 2);
> > > > > > >                  }
> > > > > > >                  for (i =3D 0; i < plat->tx_queues_to_use; i+=
+) {
> > > > > > >                          res->tx_irq[CHANNELS_NUM - 1 - i] =
=3D
> > > > > > >                                  pci_irq_vector(pdev, 2 + i *=
 2);
> > > > > > >                  }
> > > > > > >
> > > > > > >                  plat->flags |=3D STMMAC_FLAG_MULTI_MSI_EN;
> > > > > > >          }
> > > > > > >
> > > > > > >          res->irq =3D pci_irq_vector(pdev, 0);
> > > > > > >
> > > > > > >        if (np) {
> > > > > > >            res->irq =3D of_irq_get_byname(np, "macirq");
> > > > > > >            if (res->irq < 0) {
> > > > > > >               dev_err(&pdev->dev, "IRQ macirq not found\n");
> > > > > > >               return -ENODEV;
> > > > > > >            }
> > > > > > >
> > > > > > >            res->wol_irq =3D of_irq_get_byname(np, "eth_wake_i=
rq");
> > > > > > >            if (res->wol_irq < 0) {
> > > > > > >               dev_info(&pdev->dev,
> > > > > > >                    "IRQ eth_wake_irq not found, using macirq\=
n");
> > > > > > >               res->wol_irq =3D res->irq;
> > > > > > >            }
> > > > > > >
> > > > > > >            res->lpi_irq =3D of_irq_get_byname(np, "eth_lpi");
> > > > > > >            if (res->lpi_irq < 0) {
> > > > > > >               dev_err(&pdev->dev, "IRQ eth_lpi not found\n");
> > > > > > >               return -ENODEV;
> > > > > > >            }
> > > > > > >        }
> > > > > > >          return 0;
> > > > > > >      }
> > > > > > >
> > > > > > > If your agree, Yanteng can use this method in V13, then avoid=
 furthur changes.
> > > > > > Since yesterday I have been too relaxed sitting back to explain=
 in
> > > > > > detail the problems with the code above. Shortly speaking, no t=
o the
> > > > > > method designed as above.
> > > > > This function is copy-paste from your version which you suggest t=
o
> > > > > Yanteng, and plus the fallback parts for DT. If you don't want to
> > > > > discuss it any more, we can discuss after V13.
> > > My conclusion is the same. no to _your_ (Huacai) version of the code.
> > > I suggest to Huacai dig dipper in the function semantic and find out
> > > the problems it has. Meanwhile I'll keep relaxing...
> > >
> > > > > BTW, we cannot remove "res->wol_irq =3D res->irq", because Loongs=
on
> > > > > GMAC/GNET indeed supports WoL.
> > > > Okay, I will not drop it in v13.
> > > Apparently Huacai isn't well familiar with what he is reviewing. Once
> > > again the initialization is useless. Drop it.
> >
>
> > Hmm, to be honest, I'm still a little confused about this.
> >
> > When we first designed the driver, we looked at intel,See:
> >
> > $: vim drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c +953
> >
> > static int stmmac_config_single_msi(struct pci_dev *pdev,
> >                     struct plat_stmmacenet_data *plat,
> >                     struct stmmac_resources *res)
> > {
> >     int ret;
> >
> >     ret =3D pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_ALL_TYPES);
> >     if (ret < 0) {
> >         dev_info(&pdev->dev, "%s: Single IRQ enablement failed\n",
> >              __func__);
> >         return ret;
> >     }
> >
> >     res->irq =3D pci_irq_vector(pdev, 0);
> >     res->wol_irq =3D res->irq;
> >
> > Why can't we do this?
> >
> > Intel Patch thread link <https://lore.kernel.org/netdev/20210316121823.=
18659-5-weifeng.voon@intel.com/>
>
> First of all the Intel' STMMAC patches isn't something what can be
> referred to as a good-practice example. A significant part of the
> mess in the plat_stmmacenet_data structure is their doing.
>
> Secondly as I already said several times initializing res->wol_irq
> with res->irq is _useless_. It's because of the way the WoL IRQ line
> is requested:
I see, res->irq will be droped. Thanks.
>
> stmmac_request_irq_single(struct net_device *dev)
> {
>         ...
>         if (priv->wol_irq > 0 && priv->wol_irq !=3D dev->irq) {
>                 ret =3D request_irq(priv->wol_irq, stmmac_interrupt,
>                                   IRQF_SHARED, dev->name, dev);
>                 ...
>         }
>         ...
> }
>
> stmmac_request_irq_multi_msi(struct net_device *dev)
> {
>         ...
>         if (priv->wol_irq > 0 && priv->wol_irq !=3D dev->irq) {
>                 int_name =3D priv->int_name_wol;
>                 sprintf(int_name, "%s:%s", dev->name, "wol");
>                 ret =3D request_irq(priv->wol_irq,
>                                   stmmac_mac_interrupt,
>                                   0, int_name, dev);
>                 ...
>         }
>         ...
> }
>
> See, even if you initialize priv->wol_irq with dev->irq (res->irq) it
> will have the same effect as if you had it left uninitialized
> (pre-initialized with zero). So from both maintainability and
> readability points of view it's better to avoid a redundant code
> especially if it causes an ill coding practice reproduction.
Oh, I see. Thank you=EF=BC=81
>
>
> Interestingly to note that having res->wol_irq initialized with
> res->irq had been required before another Intel' commit:
> 8532f613bc78 ("net: stmmac: introduce MSI Interrupt routines for mac, saf=
ety, RX & TX")
> (submitted sometime around the commit you are referring to).
> In that commit Intel' developers themself fixed the semantics in the
> STMMAC core driver, but didn't bother with fixing the platform drivers
> and even the Intel' DWMAC PCI driver has been left with that redundant
> line of the code. Sigh...
>
> > Ok, if I'm fast enough, I'll send an RFC to talk about msi and legacy.
>
> It's up to you. But please be aware, I'll be busy next week with my
> own patches cooking up. So I won't be able to actively participate in
> your patches review.
Okay, maybe it would be better to send v13 after the window closes.

Thanks,
Yanteng


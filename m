Return-Path: <netdev+bounces-97073-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D8C9C8C9067
	for <lists+netdev@lfdr.de>; Sat, 18 May 2024 12:38:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E6481F219B1
	for <lists+netdev@lfdr.de>; Sat, 18 May 2024 10:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96F8F14A9D;
	Sat, 18 May 2024 10:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N/1psPzI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C2F1D688
	for <netdev@vger.kernel.org>; Sat, 18 May 2024 10:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716028733; cv=none; b=jl7EATjR/BSkJUqMxJ8gRhv4kO7O7Z0qod/evh1oM2WKozSKBPYOEw6zmhiYEDRupxnsMikm6yR1ZL+UQGnM1cEwg9Alx3sVNEqIno6Nu0G3uQrg2I1CF1BOBxOeC+Ffmy4Z8A34ddO1NnChlP5/DLANk5LuoFr53IyBV0tvVw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716028733; c=relaxed/simple;
	bh=Z76wQ3TFaCO8AYBFUxqsai9hc2GJxeBw3q+m3iRB310=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iCfibKpWJow5MtiIUkbqvxg+BU0+rIks/KrHFpTDbk976fUf3OBW8Z3h/LqFWY6YRkcB6ClUHlBnWCGdfIGDBAIDct98/NnCIyWvyFk28JRou5Aih/2XSifwt7d2q/+jbQbdmdY0ReQ8WKxlqhbOIQpc8KzAxS6+ySVXYux6kx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N/1psPzI; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-de5b1e6beceso1117596276.0
        for <netdev@vger.kernel.org>; Sat, 18 May 2024 03:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716028731; x=1716633531; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sDp4rpQNRnU5TJVpOZQV86GTVy54p+7oUW9b1UuOjlk=;
        b=N/1psPzIEV3LwfiaVr+6Yll3qRzR9SbwVhH9kQqLXfCQDE8xSQ6FGQ58qsIS/7er5A
         PuU3DdJQhd/NA8C8/QFliwDgmqK2oQZMqlh7FB529TzPvOE7ddv9T01OYrz6HSkknFO9
         8/yCKFeTrwJQWSFqwDO6BELwsw9RrtjhFkAiXjVqXugSMOM1AvSVevNCDDpoMYtg6enU
         /vKqABuAO1APrYrk3IZuJLbv8mdldh1TS1CNThT86RVgdn07dBsFtx3tMg0Lr9cezZJM
         GnBvU/Z4nwF+s/giN3MAwtep0qGYFCN0DryTK0Q003lHlFk1rq4+kpfidGpNbtLSnc14
         L+wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716028731; x=1716633531;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sDp4rpQNRnU5TJVpOZQV86GTVy54p+7oUW9b1UuOjlk=;
        b=ikwRaE1qZMnE8lBpJLE0JFtsDjVtq2vZkU6RVuWN562JHDLhGmj50XvZWOZYikj3lz
         cdAJ8M3KiXoY0m+0d+PA19SJ+flJks730UPoLZx4L57FvSM1KUnCgYWrUlYf2JiQYB0F
         TX9L2FBzoP19ekB/L3D8imJRG3aWND1Osh1wJCptpYq9cAMZIrbfiOONsm6vZCqYINWQ
         p5IhrxAXRcoyTrlfH3Lt6DNO4oBf8vTL9O7uUfdVxtklYsq63tTeU8rf2gYnGlkM551+
         mSMUA1Oa6URfaEnF9VPYCI0hllTbVN0NdJUc3OS6vBLeqRz6cSgmxGEpjBwtnIRNxSO7
         JZFA==
X-Forwarded-Encrypted: i=1; AJvYcCXXy4ZZ2c0cYYgIiuU9wM4MhHcMDP14cBEqeRWuovydj8rEJ+94txnd/cbi/A0DZsvnRv76f1maosR9+fLyTDYXfPssLFr2
X-Gm-Message-State: AOJu0YwT7Z9VI4jBo4h0x5j68vPDTmieJQXWUobQBBHMGpt071cMRT5i
	G1xleEfcN6xCqTC9EwfbbAQjBFwTMAdMnaw7B928gwIduGaS4ewhXRmv2E5BnXksXGz81+/rayI
	D+p6xo+XsxgrPp3/XdnBLd1KoNxVP3kRm/LRvvA==
X-Google-Smtp-Source: AGHT+IG0FoKBFiA4pMiSy6AhYzvBK0NRGwtut5XrAFhPw7NEizrpEeM+rZe+iboDo3f7cou7krZmJvTq6fbimd5lex4=
X-Received: by 2002:a25:d387:0:b0:df4:7142:a168 with SMTP id
 3f1490d57ef6-df47142a34amr6701572276.45.1716028730549; Sat, 18 May 2024
 03:38:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1714046812.git.siyanteng@loongson.cn> <e0ea692698171f9c69b80a70607a55805d249c4a.1714046812.git.siyanteng@loongson.cn>
 <arxxtmtifgus4qfai5nkemg46l5ql5ptqfodnflqpf2eenfj57@4x4h3vmcuw5x>
 <29f046d6-67a8-4566-be6a-e2ee73037a94@loongson.cn> <uy3pqd5zqpcdpny4jfdy2a4uwsrp22u755w5ukm3etqhyljr6i@ayup5ikrlx7g>
In-Reply-To: <uy3pqd5zqpcdpny4jfdy2a4uwsrp22u755w5ukm3etqhyljr6i@ayup5ikrlx7g>
From: yanteng si <siyanteng01@gmail.com>
Date: Sat, 18 May 2024 18:38:39 +0800
Message-ID: <CAEensMz39F11FUsrsAyyy0WYZsVxL5FJB7=quR0EF_JsRkxvaQ@mail.gmail.com>
Subject: Re: [PATCH net-next v12 06/15] net: stmmac: dwmac-loongson: Split up
 the platform data initialization
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Yanteng Si <siyanteng@loongson.cn>, chenhuacai@kernel.org, andrew@lunn.ch, 
	hkallweit1@gmail.com, peppe.cavallaro@st.com, alexandre.torgue@foss.st.com, 
	joabreu@synopsys.com, Jose.Abreu@synopsys.com, linux@armlinux.org.uk, 
	guyinggang@loongson.cn, netdev@vger.kernel.org, chris.chenfeiyang@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Serge Semin <fancer.lancer@gmail.com> =E4=BA=8E2024=E5=B9=B45=E6=9C=8813=E6=
=97=A5=E5=91=A8=E4=B8=80 22:05=E5=86=99=E9=81=93=EF=BC=9A
> > >
> > > >           /* Set default value for unicast filter entries */
> > > >           plat->unicast_filter_entries =3D 1;
> > > >           /* Set the maxmtu to a default of JUMBO_LEN */
> > > >           plat->maxmtu =3D JUMBO_LEN;
> > > > - /* Set default number of RX and TX queues to use */
> > > > - plat->tx_queues_to_use =3D 1;
> > > > - plat->rx_queues_to_use =3D 1;
> > > > -
> > > >           /* Disable Priority config by default */
> > > >           plat->tx_queues_cfg[0].use_prio =3D false;
> > > >           plat->rx_queues_cfg[0].use_prio =3D false;
> > > > @@ -41,6 +39,12 @@ static int loongson_default_data(struct plat_stm=
macenet_data *plat)
> > > >           plat->dma_cfg->pblx8 =3D true;
> > > >           plat->multicast_filter_bins =3D 256;
> > > > +}
> > > > +
> > > > +static int loongson_gmac_data(struct plat_stmmacenet_data *plat)
> > > > +{
> > > > + loongson_default_data(plat);
> > > > +
> > > >           return 0;
> > > >   }
> > > > @@ -109,11 +113,10 @@ static int loongson_dwmac_probe(struct pci_de=
v *pdev, const struct pci_device_id
> > > >           }
> > > >           plat->phy_interface =3D phy_mode;
> > > > - plat->mac_interface =3D PHY_INTERFACE_MODE_GMII;
> > > >           pci_set_master(pdev);
> > > > - loongson_default_data(plat);
> > > > + loongson_gmac_data(plat);
> > > >           pci_enable_msi(pdev);
> > > >           memset(&res, 0, sizeof(res));
> > > >           res.addr =3D pcim_iomap_table(pdev)[0];
> > > > @@ -138,6 +141,9 @@ static int loongson_dwmac_probe(struct pci_dev =
*pdev, const struct pci_device_id
> > > >                   goto err_disable_msi;
> > > >           }
> > > > + plat->tx_queues_to_use =3D 1;
> > > > + plat->rx_queues_to_use =3D 1;
> > > > +
> > > You can freely move this to loongson_gmac_data() method. And then, in
> > > the patch adding the GNET-support, you'll be able to provide these fi=
elds
> > > initialization in the loongson_gnet_data() method together with the
> > > plat->tx_queues_cfg[*].coe_unsupported flag init. Thus the probe()
> > > method will get to be smaller and easier to read, and the
> > > loongson_*_data() method will be more coherent.
> >
> > As you said, at first glance, putting them in loongson_gnet_data() meth=
od is
> > fine,
> >
> > but in LS2K2000:
> >
> >         plat->rx_queues_to_use =3D CHANNEL_NUM;    // CHANNEL_NUM =3D 8=
;
> >         plat->tx_queues_to_use =3D CHANNEL_NUM;
> >
> > So we need to distinguish between them. At the same time, we have to
> > distinguish
> >
> > between LS2K2000 in probe() method. Why not put them inside probe, whic=
h
> > will
> >
> > save a lot of duplicate code, like this:
> >
> >     struct stmmac_resources res;
> >     struct loongson_data *ld;
> >
> > ...
> >
> >     memset(&res, 0, sizeof(res));
> >     res.addr =3D pcim_iomap_table(pdev)[0];
> >     ld->gmac_verion =3D readl(res.addr + GMAC_VERSION) & 0xff;
> >
> >     switch (ld->gmac_verion) {
> >     case LOONGSON_DWMAC_CORE_1_00:
> >         plat->rx_queues_to_use =3D CHANNEL_NUM;
> >         plat->tx_queues_to_use =3D CHANNEL_NUM;
> >
> >         /* Only channel 0 supports checksum,
> >          * so turn off checksum to enable multiple channels.
> >          */
> >         for (i =3D 1; i < CHANNEL_NUM; i++)
> >             plat->tx_queues_cfg[i].coe_unsupported =3D 1;
> >
> >         ret =3D loongson_dwmac_config_msi(pdev, plat, &res, np);
> >         break;
> >     default:    /* 0x35 device and 0x37 device. */
> >         plat->tx_queues_to_use =3D 1;
> >         plat->rx_queues_to_use =3D 1;
> >
> >         ret =3D loongson_dwmac_config_legacy(pdev, plat, &res, np);
> >         break;
> >     }
> >     if (ret)
> >         goto err_disable_device;
> >
> >
> > What do you think?
> >
> >
> > Of course, if you insist, I'm willing to repeat this in the
> >
> > loongson_gnet_data() method.
>
> Not necessarily. As Huacai earlier suggested you can keep the Loongson
> ID in the platform private data and have it utilized in the local
> sub-functions/routines. Like this:
>
> struct loongson_data {
>         u32 loongson_id;
> };
>
> static int loongson_gmac_data(struct pci_dev *pdev,
>                               struct plat_stmmacenet_data *plat)
> {
>         struct loongson_data *ld =3D plat->bsp_priv;
>
>         ...
>
>         plat->rx_queues_to_use =3D 1;
>         plat->tx_queues_to_use =3D 1;
>
>         return 0;
> }
>
> static int loongson_gnet_data(struct pci_dev *pdev,
>                               struct plat_stmmacenet_data *plat)
> {
>         struct loongson_data *ld =3D plat->bsp_priv;
>
>         ...
>
>         if (ld->loongson_id =3D=3D DWMAC_CORE_LS2K2000) {
I did the test and found that at this point in time: loongson_id =3D 0,
it has not been initialized yet.

>
> static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_de=
vice_id *id)
> {
>         struct loongson_data *ld;
>         ...
>
>         ld =3D devm_kzalloc(&pdev->dev, sizeof(*ld), GFP_KERNEL);
>         if (!ld)
>                 return -ENOMEM;
>         ...
>         ld->loongson_id =3D readl(res.addr + GMAC_VERSION) & 0xff;
>         plat->bsp_priv =3D ld;
>         ...
>         if (ld->loongson_id =3D=3D DWMAC_CORE_LS2K2000)
>                 ret =3D loongson_dwmac_config_msi(pdev, plat, &res);
>         else
>                 ret =3D loongson_dwmac_config_plat(pdev, plat, &res);
I'll change loongson_dwmac_config_legacy to loongson_dwmac_config_plat in t=
he
next version. And using if-else.

>
> It's not "a lot" duplication code. Just two if-else statements, which
> is fine. But the data-init methods will get to be fully coherent. It's
> much more important.
Yes, I agree with you, but it looks like we still need to do the following =
again
inside loongson_gnet_data() :

memset(&res, 0, sizeof(res));
res.addr =3D pcim_iomap_table(pdev)[0];
ld->loongson_id =3D readl(res.addr + GMAC_VERSION) & 0xff;


>
> * Note switch-case is redundant since you have a single case in there,
> so if-else would be more than enough.
I see, Your single case is great=EF=BC=81

Thanks,
Yanteng


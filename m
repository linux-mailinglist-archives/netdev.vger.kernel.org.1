Return-Path: <netdev+bounces-96947-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD14D8C855B
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 13:14:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83B4F280F63
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 11:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D88E3BBE2;
	Fri, 17 May 2024 11:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IZhCdw6w"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D440200DD
	for <netdev@vger.kernel.org>; Fri, 17 May 2024 11:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715944485; cv=none; b=YbDcpTqVL/75cFFeBRDlyhHAFaIGZY5H4GgJQkYB/8Sr1BkuU+aecOXixvC/ynOYgzOi7vXRAx9VYiVG0Uu7uEYLLNWr1umhYmGN3RET6gWHn5CGtJJ+zW7Aj8HodXFcccEp/a1eRnNNvrtuuZG2ySzw9Wd+vm+JefexDLXxz24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715944485; c=relaxed/simple;
	bh=qYEe+EXu6YVhLPui8QL1VKR2Js3jUvYAUP+duWwYUC8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WBEajexko8qJZjQvCiV3yH1M3nQFveMDs+vUoOiXChmlqLg9Xlg1YkyDQPuItLQRiYdku70jWf8yp+zqc3YllZP5/fwAKJm8E05NbjSHYiYMciallKjIlxsrI39Ngykr5Yn6vCmhJH1WRcdj+nfYdeIJ2Rrr7xXRJsPa3EwYnRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IZhCdw6w; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-61be4b986aaso3457b3.3
        for <netdev@vger.kernel.org>; Fri, 17 May 2024 04:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715944483; x=1716549283; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=20hRkyQF/pHTt8GYJWFhAlbqajq1dp7GsD7dEeP8Hic=;
        b=IZhCdw6wljInADWJoLGz0s0Rmp20dRvEaeCJAXmF5J5a11c5w6fzeX5Hs03kpe+0ge
         GIJ/YWHMVnv6Xb+slyPAFR7AvNNoX1SiFbnlgnFMf6/P5lO0dKgc8XvfRQ2jLZJXAn4d
         Vt72g2HKFeX988A8WMJkg5zETPmVREtgfuxPrUWHR5bJkC+Tjkfx0lx4WJmdURaeRvlL
         /jDlEDOvsvg5DjwPI7e89fTw/7QpyFYhDQdQt6oth7EJvfmcj5R/9m5SOYnqehGWX6J4
         4xhdOb49VxhGFwFhqlW74U2bRYTC2q1SOkfJdAwugyhvL5UWvtl3z935825XJWrsIcVr
         6cKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715944483; x=1716549283;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=20hRkyQF/pHTt8GYJWFhAlbqajq1dp7GsD7dEeP8Hic=;
        b=G+gOtU8zxa7w/ahlO2DLvH5uqTwiSlbkLrn81xj0frnlVgyyu7wc4ZAqK8/c/q0Fok
         h/EYUojiksmjlTeWe3Rty4z34NcOoBBEdnlDt6OMdCLAVue7efya3jynet+ZaX08Ov5K
         Yof+UmdrSRe0TpUPrdOCsBH9NZ2b8CHgfVomV1qK9dVwZG14rLHlgSHl1NXsRvNcOzIx
         aqaIklaNBUO5sFC4r5Fa5RojsP+l4p3ANJf+X4TEJIpD3RRMDz9AWVdeXicf43ov5vUm
         /t8F9GvBRd0gifk3T/mpaWHZL1Rv8RdMT8ycvp25pDad55roRrE+lV6ijWUNF64mMY9x
         yuhA==
X-Forwarded-Encrypted: i=1; AJvYcCW+D2I0obFkWn07+KkkSR+cOJBWVzGFX2aeqK3b4G1cV8ATHRsIJuWWWMEqlJlyGN2gi7DvM+kcmv48V8nd2fxsjiCvH+mi
X-Gm-Message-State: AOJu0YxEheKtLSFXYEIDc3bFTl+aP+glMUKQYK8f2p8Bl44OHuakXgI9
	tBccU6MDS3E4eFfkXxjH757F6PNlIfpK8vtO+NQgFQvkNKg37RnSmnysKx/Bglu5myplTF6PnLh
	qnA9ph4+BRZ3ZF2QyQTR1VUnoOEk=
X-Google-Smtp-Source: AGHT+IF6h3s6pribTitrcz+UDtovIHDn5KO+3hoXp6HzBz8H5LNKoUC7vx4MtjZTDqRpXaQ03LY5955gY76iBqHjtNg=
X-Received: by 2002:a25:7409:0:b0:df4:449d:5f4d with SMTP id
 3f1490d57ef6-df4449d60f3mr5872257276.18.1715944483215; Fri, 17 May 2024
 04:14:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1714046812.git.siyanteng@loongson.cn> <c97cb15ab77fb9dfdd281640f48dcfc08c6988c0.1714046812.git.siyanteng@loongson.cn>
 <dcsn7kixduijizlmkhm4jmzevc6dt46gl33orh3z2ohu6otbz2@zlkx3vyvlsur>
 <9e9302c6-3b52-401f-b9af-1551136c3242@loongson.cn> <qmm4rpqzwaf2qu6ndt5r45nkwcnc22k5asexzdnuutzagfy45z@pyykj2wgpe4n>
In-Reply-To: <qmm4rpqzwaf2qu6ndt5r45nkwcnc22k5asexzdnuutzagfy45z@pyykj2wgpe4n>
From: yanteng si <siyanteng01@gmail.com>
Date: Fri, 17 May 2024 19:14:32 +0800
Message-ID: <CAEensMx3jF1DYEEe25Lasw82N61bg3NVjqSDXXOB6xL3d6-PAA@mail.gmail.com>
Subject: Re: [PATCH net-next v12 13/15] net: stmmac: dwmac-loongson: Add
 Loongson GNET support
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Yanteng Si <siyanteng@loongson.cn>, andrew@lunn.ch, hkallweit1@gmail.com, 
	peppe.cavallaro@st.com, alexandre.torgue@foss.st.com, joabreu@synopsys.com, 
	Jose.Abreu@synopsys.com, chenhuacai@kernel.org, linux@armlinux.org.uk, 
	guyinggang@loongson.cn, netdev@vger.kernel.org, chris.chenfeiyang@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Serge,

I can't access siyanteng@loongson.cn right now for some reason,
so let's switch to siyanteng01@gmail.com.

Serge Semin <fancer.lancer@gmail.com> =E4=BA=8E2024=E5=B9=B45=E6=9C=8817=E6=
=97=A5=E5=91=A8=E4=BA=94 17:48=E5=86=99=E9=81=93=EF=BC=9A

> > > > +
> > > > +static int loongson_gnet_dma_interrupt(struct stmmac_priv *priv,
> > > > +                                void __iomem *ioaddr,
> > > > +                                struct stmmac_extra_stats *x,
> > > > +                                u32 chan, u32 dir)
> > > > +{
> > > > + struct stmmac_pcpu_stats *stats =3D
> > > ...
> > > > + /* Clear the interrupt by writing a logic 1 to the CSR5[15-0] */
> > > 0x7ffff !=3D CSR5[15-0]
> >
>
> > Hmmm, It should be CSR5[19-0]?
>
> 0x7ffff =3D [18-0]
> 0xfffff =3D [19-0]
>
> >
> > BTW, 0x1ffff !=3D CSR5[15-0], too.
> >
> > It should be CSR5[16-0], right?
>
> Right. If you wish to fix that in the original code, that has to be
> done in a dedicated patch.
OK.
>
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
>
> > > Hm, this must be justified and better being done in a separate patch.
> > OK.
>
> AFAICS the pci_enable_msi()/pci_disable_msi() calls can be dropped due
> to the Loongson GMAC not having the MSI IRQs delivered (at least
> that's what I got from the discussion and from the original driver,
> please correct my if I am wrong). Thus no need in the MSI capability
> being enabled. Meanwhile the multi-channels Loongson GNET will use the
> pci_alloc_irq_vectors()/pci_free_irq_vectors() functions for the IRQ
> vectors allocation and freeing which already perform the MSIs
> enable/disable by design.
Ok, I will try.
> * But once again, please drop the functions call in a separate patch
> submitted with the proper commit log justifying the removal.
Ok.
>
> > >
> > > Besides I don't see you freeing the IRQ vectors allocated in the
> > > loongson_dwmac_config_msi() method neither in probe(), nor in remove(=
)
> > > functions. That's definitely wrong. What you need is to have a
> > > method antagonistic to loongson_dwmac_config_msi() (like
> > > loongson_dwmac_clear_msi()) which would execute the cleanup procedure=
.
> >
>
> > Hmmm, We can free it in struct pci_driver ->remove method.
> >
> > Just in loongson_dwmac_remove() call
> >
> > pci_free_irq_vectors(pdev);
>
> Sounds good. Although I would have implemented that in a more
> maintainable way:
>
> loongson_dwmac_config_msi()
> {
>         ...
> }
>
> loongson_dwmac_clear_msi()
> {
>         pci_free_irq_vectors(pdev)
> }
>
> ...
>
> loongson_dwmac_remove()
> {
>         ...
>         if (ld->loongson_id =3D=3D DWMAC_CORE_LS2K2000)
>                 loongson_dwmac_clear_msi();
>         ...
> }
>
loongson_dwmac_clear_msi() looks better, and you'll see it in RFC/v13.

Thanks,
Yanteng


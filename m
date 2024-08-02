Return-Path: <netdev+bounces-115422-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75E74946532
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 23:43:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A75531C20A22
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 21:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EFD6133987;
	Fri,  2 Aug 2024 21:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ei67T59A"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8291ABEC2
	for <netdev@vger.kernel.org>; Fri,  2 Aug 2024 21:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722634998; cv=none; b=QdONSAATvHQ5k1U47PMoxn5xad6NapQL7F3R9DNxHHghiRL5zsortw311V4PKJG3hPE5BSpZPGuF27YoVD2vyvm+Lll5HrVXO5lNp9cmuu8nG40nGKJteFNfAfeXcHWieAjCayPOwVceh0Ys+LisMdrVrJp+YzVCjCSQ4q9xxTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722634998; c=relaxed/simple;
	bh=SfOTiz9UY3pucISMWMj/A6XFiE2X8f0Ut6NVQ49nh+A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FnTvPdIL+w70/Xx8jSYoCMEUhykiNd3o8jz4Tg3bWEV4NEQVJKEiCQXM+Mm55tBpc/ZKHubAJcLt2+qtHPWuk3pPReuPAf/RQhEvhJ805Xnky8B591ChZM1b0Qm++nmr9804FLXa0GIZaGRUkalHydnbTB2/sBJAYbqaiv40mD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ei67T59A; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7ae3d7222d4so4968879a12.3
        for <netdev@vger.kernel.org>; Fri, 02 Aug 2024 14:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1722634996; x=1723239796; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9vMHdVSrXJF8XYak0iSBlyxgzNiJzotPPn7gmZpMrkY=;
        b=ei67T59AhJNLsNB92VV0LsJzKYSMuFYpei/IuoB009+2g/+3vb+mfhr2qJHLCrjxrQ
         Euiy7W0129Ai+Hj0CoB9i7iX2Nn+X/NUy3+XuB1j8Ga8OUfHjlSrpRh4vwTQuQwRQ/4t
         euh1Lv6gBx2QI+lWvmXZDfYjRHtMjpkJY016Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722634996; x=1723239796;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9vMHdVSrXJF8XYak0iSBlyxgzNiJzotPPn7gmZpMrkY=;
        b=IkDmwoBjQO/RbiQVx8Y3xu+Rrm4NrHavETkglLujIGbzkOc6+dsj2nheTBeQ+Woyav
         3jXW7yhQimq2VtNbnjSXpax9SJxucC6wUifV8hrG4FWVsmdEq0U/AZIxgRMSGPijpl0k
         2rLof/i6xro6mfqw3nWv5HU4TeG4tt7WzzQ1p5RNUK9yTKJMzOEgErUlVFBx13yi2GpU
         /HsPMfA+agT8Eqare/WtvVovU4GrM3ZUpIHBN8Ji5jj8IzT5AswZDqfNmoEKq2TMITxs
         X++1jJSxFntHD93Hq2VjgSAFP6OyxQAraqPnJ2i+o1/+WdRwqwtLjIEApdBUCxnJ96TC
         Ni6Q==
X-Gm-Message-State: AOJu0YxlJ49LyI6r4/2gxKc/4S3DZZ097F8prvMBGoHJgDvnIL5phH32
	un/+JPjzru9eXBKz48InlOsMrriyw2ObKg1Libvjq6wnaDmf2CBhyifNhI+Vckelk2tdjnFhD6A
	HEqnb5lZZVKIA2UPT63383wCrsXEJYyf/81RV
X-Google-Smtp-Source: AGHT+IEtvLrcXhCLETX+9N9XQkX7L9HzPL+GHPynwB9luwQ69BeemNXYJLs+adSVkzdD9GLwGnf0wExUCNvvTJfPf+s=
X-Received: by 2002:a17:90a:f02:b0:2cd:ba3e:38a5 with SMTP id
 98e67ed59e1d1-2cff9469006mr5802105a91.21.1722634996112; Fri, 02 Aug 2024
 14:43:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240802031822.1862030-1-jitendra.vegiraju@broadcom.com>
 <20240802031822.1862030-2-jitendra.vegiraju@broadcom.com> <ZqyXE0XJkn+Of6rR@shell.armlinux.org.uk>
In-Reply-To: <ZqyXE0XJkn+Of6rR@shell.armlinux.org.uk>
From: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
Date: Fri, 2 Aug 2024 14:43:05 -0700
Message-ID: <CAMdnO-+_w=XTE7TPv-b6RtAbjK1CC9jgf1kukmg9W-_0Dj8O2A@mail.gmail.com>
Subject: Re: [PATCH net-next v3 1/3] net: stmmac: Add basic dwxgmac4 support
 to stmmac core
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, alexandre.torgue@foss.st.com, joabreu@synopsys.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	mcoquelin.stm32@gmail.com, bcm-kernel-feedback-list@broadcom.com, 
	richardcochran@gmail.com, ast@kernel.org, daniel@iogearbox.net, 
	hawk@kernel.org, john.fastabend@gmail.com, linux-kernel@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org, andrew@lunn.ch, 
	horms@kernel.org, florian.fainelli@broadcom.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sorry for reposting, resending the reply since I missed reply to all.

On Fri, Aug 2, 2024 at 1:21=E2=80=AFAM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> On Thu, Aug 01, 2024 at 08:18:20PM -0700, jitendra.vegiraju@broadcom.com =
wrote:
> > +static int rd_dma_ch_ind(void __iomem *ioaddr, u8 mode, u32 channel)
> > +{
> > +     u32 reg_val =3D 0;
> > +     u32 val =3D 0;
>
> val is unnecessary.
True, I will fix it.
>
> > +
> > +     reg_val |=3D mode << XGMAC4_MSEL_SHIFT & XGMAC4_MODE_SELECT;
>
> Consider using:
>
>         reg_val |=3D FIELD_PREP(XGMAC4_MODE_SELECT, mode);
>
Thanks, I will make the changes.

> and similarly everywhere else you use a shift and mask. With this, you
> can remove _all_ _SHIFT definitions in your header file.
>
> > +     reg_val |=3D channel << XGMAC4_AOFF_SHIFT & XGMAC4_ADDR_OFFSET;
> > +     reg_val |=3D XGMAC4_CMD_TYPE | XGMAC4_OB;
> > +     writel(reg_val, ioaddr + XGMAC4_DMA_CH_IND_CONTROL);
> > +     val =3D readl(ioaddr + XGMAC4_DMA_CH_IND_DATA);
> > +     return val;
>
>         return readl(ioaddr + XGMAC4_DMA_CH_IND_DATA);
>
> ...
>
> > +void dwxgmac4_dma_init(void __iomem *ioaddr,
> > +                    struct stmmac_dma_cfg *dma_cfg, int atds)
> > +{
> > +     u32 value;
> > +     u32 i;
> > +
> > +     value =3D readl(ioaddr + XGMAC_DMA_SYSBUS_MODE);
> > +
> > +     if (dma_cfg->aal)
> > +             value |=3D XGMAC_AAL;
> > +
> > +     if (dma_cfg->eame)
> > +             value |=3D XGMAC_EAME;
>
> What if dma_cfg doesn't have these bits set? Is it possible they will be
> set in the register?
The reset default for these bits is zero.
>
> Thanks.
>
> --
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!


Return-Path: <netdev+bounces-196441-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB6B1AD4DB3
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 09:58:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F7851BC08B0
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 07:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FDCF238C3D;
	Wed, 11 Jun 2025 07:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nogh/cLW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776FC2367B9;
	Wed, 11 Jun 2025 07:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749628572; cv=none; b=es6D5NLUwIwSD3wuXLnEnYsPFKUXEdbhOBlOBdJ4u4GdhhsGkoRjJ/9LjVJrhHdHf374o+LExESVwTVemg6hkqy378tqyNluK1P/Ij55Fc0qj/tnPm93ux+/tunDNxKmhkIih7bE3nHZspqKOZw7ZohP7ELbmm26EbIUVLJvWv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749628572; c=relaxed/simple;
	bh=7To7WI9XwMMtA66JWXTA1CAUBiFHtDp+UJB/oeWMvgE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=piKfnM5wPcLx4vU2jdIHlVMvFCVHGn4rO959996CE6avBLcHovVlZfkZRaJe8kRQ27x2lqOzuw+9HTWVwuuUasAbhd9Td0dTmxrexdYMPpsWeqBDRzQbz+bYmibtTY27AmSXO3p8XL516gjvmcDYILTYC5Ea8AzeMVV+KfSxSE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nogh/cLW; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3122368d7cfso4952168a91.1;
        Wed, 11 Jun 2025 00:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749628570; x=1750233370; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V6TJM3iIHz3tB+nb8hhVbd7mqPPM3Iw3zLYnp9N8mLE=;
        b=Nogh/cLWuBR9sTL36zWeobxf/UhLu3egdGRW5kFVmJ/DoF/6TXMF7SvHBC6FhmEDJR
         D4SmIGt5EZJIFepjGwnV65LY1sgqY8tkHXOyIREBN16sbtQw43Uavi5NKp2tgUs8OJ1R
         0bQuVYuCRlqPetKsFwvm8N0X6T1oTYtgd11oyK8DsNjb0VdZcnXq6Wm6JLlnlWfscp3i
         JyGk5S9xH1hCcz2NNDDy/K1L0fmsV5PSlJVfynIIj0yc4NtRUINiWWb/HpeSym/H+FfP
         fivGUiLTb8EC+g89jLzAdoGpBpPaoKIqLXX4ajscX3INvDaQrL94LCEj06++15uwpzm5
         5xBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749628570; x=1750233370;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V6TJM3iIHz3tB+nb8hhVbd7mqPPM3Iw3zLYnp9N8mLE=;
        b=weoRDL6bj2g1XyzoQBWolfghtFPj4ZpVJqr2LIq8ontdeLHxad+aJccQiZ91G+BvUH
         0FLTklXmvP6L0wQbhEAD0CZcATOmh/hrI0bc1z/sd7UINhJ2uooIJEWBlTqO4jISQxMy
         0LOPZ3rDxyyizHyVJDHTi9SMoi8/kF1YbcMchX2VatI7eXfNm4FLF21pXhh8vNXLR7UJ
         MtsnJsQICZ4vOycCTOA32PfwVC/VHBNn/uVNBEV3CO/86MteRvoVHwsGlqXIxqTRLwX1
         BFOgYyTeKjX+1QEAvGfR47GNlgTN+NRyEbM4HR6SX9jvmY39i1jjeaVuu3ScB9wDgUNg
         Ancg==
X-Forwarded-Encrypted: i=1; AJvYcCUWApqGsEoJ/6uz/YdKgeyt/mqZt7gqzytXVzQfU8Lf95nZ/3Nt3hfBDKvJN2sHN1qKCB6FWkEDKtIo70k=@vger.kernel.org, AJvYcCWjILkx6bmX/g3UZ9+HcgVEV+jbaMnMT7HWWuduDsY1P01KRpyuSbapgsskOAPd1Pko643kmGDR@vger.kernel.org
X-Gm-Message-State: AOJu0YyfVRAA65Yr4/wv2P6zi+6WJd+ZzMX7DbTD9Vj31iH9DjphCuFb
	4UHQKDCclg20ESyNjpEVm6Q0Rr3lCSIDaZ4GDgukrOaoE9rdkI+s8sDYjPlYY0UFvXxXHZaWI1e
	j50zs98vpT1FpOlSJbqDdmxEeuQe9g/c=
X-Gm-Gg: ASbGncuuI1B3G8NwlPuy8U6C3OFsllNFeDjYBTweFP8XwireIvnX5mUuQwyJga60jHI
	lcf7dgUht6Wvm92K7jhwQMxu0ShD7mo5dMA3pZ+SEKan/xurZazrhyI4tgxb5jRZHnWeBIrnptB
	Eic/YVqQkD8pzSZ8PunnXw2xe9pA926R2T/3w9YzVMlxbDb+FzpAs6csT6rc/0jap1ti3U+J8BU
	uuAig==
X-Google-Smtp-Source: AGHT+IEGu/HRiaDx7N9wwGgDKWEyvWvXU6gKXh4ODwPCXIMqNMtx+Ito2uXPce5z6WK7Fa0t+cRRbv4Xoj+KCg+sjNM=
X-Received: by 2002:a17:90b:224c:b0:313:2adc:b4c4 with SMTP id
 98e67ed59e1d1-313b1ff8937mr2759927a91.24.1749628569445; Wed, 11 Jun 2025
 00:56:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250603204858.72402-1-noltari@gmail.com> <20250603204858.72402-2-noltari@gmail.com>
 <507a09f6-8b6e-4800-8c90-f2b1662cafa2@broadcom.com> <CAOiHx==HkOqi4TY6v7bdzWoHEQxO4Q4=HH8kWe7hJiEdLTy3-g@mail.gmail.com>
In-Reply-To: <CAOiHx==HkOqi4TY6v7bdzWoHEQxO4Q4=HH8kWe7hJiEdLTy3-g@mail.gmail.com>
From: =?UTF-8?B?w4FsdmFybyBGZXJuw6FuZGV6IFJvamFz?= <noltari@gmail.com>
Date: Wed, 11 Jun 2025 09:55:35 +0200
X-Gm-Features: AX0GCFvO2K9WMbRwW6sNOIi5HI3SZ7oMAMCJu6EBqkRi4K2T-ILrj2BAouyE2Qc
Message-ID: <CAKR-sGe6K=Za+eSspTc92Fj=XjAwSm1UQCzunU4TVovZ_4V_fA@mail.gmail.com>
Subject: Re: [RFC PATCH net-next v2 01/10] net: dsa: b53: add support for FDB
 operations on 5325/5365
To: Jonas Gorski <jonas.gorski@gmail.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>, andrew@lunn.ch, olteanv@gmail.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	vivien.didelot@gmail.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dgcbueu@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

El mi=C3=A9, 4 jun 2025 a las 8:32, Jonas Gorski (<jonas.gorski@gmail.com>)=
 escribi=C3=B3:
>
> On Wed, Jun 4, 2025 at 12:10=E2=80=AFAM Florian Fainelli
> <florian.fainelli@broadcom.com> wrote:
> >
> > On 6/3/25 13:48, =C3=81lvaro Fern=C3=A1ndez Rojas wrote:
> > > From: Florian Fainelli <f.fainelli@gmail.com>
> > >
> > > BCM5325 and BCM5365 are part of a much older generation of switches w=
hich,
> > > due to their limited number of ports and VLAN entries (up to 256) all=
owed
> > > a single 64-bit register to hold a full ARL entry.
> > > This requires a little bit of massaging when reading, writing and
> > > converting ARL entries in both directions.
> > >
> > > Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> > > Signed-off-by: =C3=81lvaro Fern=C3=A1ndez Rojas <noltari@gmail.com>
> > > ---
> >
> > [snip]
> >
> > >   static int b53_arl_op(struct b53_device *dev, int op, int port,
> > >                     const unsigned char *addr, u16 vid, bool is_valid=
)
> > >   {
> > > @@ -1795,14 +1834,18 @@ static int b53_arl_op(struct b53_device *dev,=
 int op, int port,
> > >
> > >       /* Perform a read for the given MAC and VID */
> > >       b53_write48(dev, B53_ARLIO_PAGE, B53_MAC_ADDR_IDX, mac);
> > > -     b53_write16(dev, B53_ARLIO_PAGE, B53_VLAN_ID_IDX, vid);
> > > +     if (!is5325(dev))
> > > +             b53_write16(dev, B53_ARLIO_PAGE, B53_VLAN_ID_IDX, vid);
> >
> > I used the 5325M-DS113-RDS datasheet for this code initially but the
> > 5325E-DS14-R datasheet shows that this register is defined. It's not
> > clear to me how to differentiate the two kinds of switches. The 5325M
> > would report itself as:
> >
> > 0x00406330
> >
> > in the integrated PHY PHYSID1/2 registers, whereas a 5325E would report
> > itself as 0x0143bc30. Maybe we can use that to key off the very first
> > generation 5325 switches?
>
> According to the product brief and other documents BCM5325M does not
> support 802.1Q VLANs, which would explain the missing register
> descriptions. It does have 2k ARL entries compared to 1k for the 5325E
> though, so I now see where that value comes from.
>
> If it really doesn't support 802.1Q, then checking if related
> registers are writable might also work.

Considering that I don't have access to a 5325M in order to properly
test it, I prefer the solution proposed by Florian.

I've implemented it in the following branch:
https://github.com/Noltari/linux/commits/b53-bcm5325-v3/
https://github.com/Noltari/linux/commit/e2d3d541ac421bbb5d2fc783e07fda26b10=
5d1a5

I will wait a bit just in case there are some comments for the
recently submitted v2 of the dsa tag patches and then I will merge
both sets of patches into one since your proposed change of checking
the tag protocol for the BRCM_HDR register access requires having the
new legacy FCS tag.

>
> Jonas

Best regards,
=C3=81lvaro.


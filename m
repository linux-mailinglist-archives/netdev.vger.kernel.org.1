Return-Path: <netdev+bounces-194060-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71EA7AC729C
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 23:14:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EC114E62F5
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 21:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C689D220F59;
	Wed, 28 May 2025 21:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ncvpEiP4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367F619B3EC;
	Wed, 28 May 2025 21:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748466870; cv=none; b=YQd23j0bqdLYeTDCQEfqPwiI1R0SnI87BsqovMGqeFi4fSTYz2/OE72yEfRYIJjJQfns3VuW91sepKhiyE9Xokeh5k8DyyLCRTT/wtD36+90+JjhGCQeztzw8w2OZd+GkShcUQsq2G42FxVBqNhUvmrdPPT9QkhfBYUw7z4cIEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748466870; c=relaxed/simple;
	bh=bik8tiy9zD4tncn3V/spfXhSHei4QkySdXosKgPMaGo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N4hAjtvgw+PI8vhmOqyOjAwZLrrT70dYx1gGV2M7wdi5/2z/lZ12wxH2MIBi/4+yU6tJNXSsPLyQ+YXd+NY7XrHzg4FDsv7UiuaofDKkoloUT6bDhikXmQmwYKWslceAAtnVzAt5f+nYe1YAKf6gLZsYLsPRgYm5pBU/geVjkZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ncvpEiP4; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-87de3223127so59750241.1;
        Wed, 28 May 2025 14:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748466868; x=1749071668; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bik8tiy9zD4tncn3V/spfXhSHei4QkySdXosKgPMaGo=;
        b=ncvpEiP4AQqOJr2Nm//DPlN289FixuqQYffHdD5X/vwG1g4ukGCnGafiHgThG0GMjc
         EfQx3kQz2UG+FqTAoH9b6G4s5HiYMLxwrVFUSJIRbAjbmTNel66q9SfjMRxowNWRnIhe
         qhwlG2p3SKRQn/tX/tx1lYlKvojRORvpjRBPeVr+qt8c3IWRiV25YNPHlcUZ71t81GXh
         hC9dwngL3rZiVhmaMo5DI5iiqHmX0+NWxIq14gk6AyIwVlaHIwcgyavha5ucD7hdu/LS
         931PtLlZkp/LTbA+A88tv2rNwUnVsTalbwetPkGIBuIzZVH+43QTvK5ljp9lZWuAmfx8
         MHiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748466868; x=1749071668;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bik8tiy9zD4tncn3V/spfXhSHei4QkySdXosKgPMaGo=;
        b=uS22fnlbrbhUatejWnt3eTH39LFsBKlkiy29K0B1n4jiouXljI8MjxsnJDa7tSYFYB
         xYARrEKq/CAHettl0mPH69CdYjqlHDaoXGvXc/a0LY8AAOXNsvQm1DVjEnOlWaxR4amE
         TFmJAWNSRIHoSJcZmtG0d0DLIaJ9j87RnSToSlEXBVFOyjdODfeBUYEH0crfEfmXmN1d
         E0MTwZ/duu7TpVUZbscICG22+VtcyvAi3L7O7ln3J99v+s/p5x867o04kQqULH9bSHvE
         6l7SGWYDuXD4KXVMyK+wOP6ArqEy1C3jX1sm4P1zzbjK/9oloHfm9tPsTIXlid2wGBfu
         lgkA==
X-Forwarded-Encrypted: i=1; AJvYcCU30EeiauxJ+PTPyrwT3obXqdbxw9OMP/EIsubdTyGD1Gys69CWv+BQGurUufkx5t+1rpr5te51@vger.kernel.org, AJvYcCXI1wyQFzMjcIj/jtqFUrXCS1Juliw7BR3NFz8mhrCrYIkInAEvQiCKflDW1lRbBSJLnQVWWjMVwnUbHH0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0rK7sXkJKt6KMraVW3ii+shxuvEhxRLk/p1y5EqmGNBsCnAKT
	Nxt7nLtlUApLE89lagPZm1d4SRm5CTkGnnegsatKqPNAIPLKSqsCySkqqnyOk3Qh6TIZaAEGjWN
	C32AoOq+cFYkfamz40lXCttfVM3L4pjc=
X-Gm-Gg: ASbGncsot8+lkwfYknwYDn0PuLNuZV/r0jupFdXqT65EON066Uk0TqEm6r0kPVtw5H/
	n1gcxenM3UxSvw7ICwGsj8jmvIyX5W7ISsj/uz7jaKEQ090ePi4LBFNXpl8hLoJGrx/mXTSS5wY
	1sJPB6p1F9MLOkKdakE98pNIRvWMRUjKH5hQ==
X-Google-Smtp-Source: AGHT+IGGLLvtEb730nnh7rC673oR16aeQY2nH92ZW4fGCX/YiQ4QwWrxJP/i3AUVjXlzBuIQT/Ux8cWPw7wSCO4tioo=
X-Received: by 2002:a05:6102:1612:b0:4e5:958d:4962 with SMTP id
 ada2fe7eead31-4e5958d5d03mr7448988137.2.1748466867876; Wed, 28 May 2025
 14:14:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADvTj4oVj-38ohw7Na9rkXLTGEEFkLv=4S40GPvHM5eZnN7KyA@mail.gmail.com>
 <aDbA5l5iXNntTN6n@shell.armlinux.org.uk> <CADvTj4qP_enKCG-xpNG44ddMOJj42c+yiuMjV_N9LPJPMJqyOg@mail.gmail.com>
 <f915a0ca-35c9-4a95-8274-8215a9a3e8f5@lunn.ch> <CAGb2v66PEA4OJxs2rHrYFAxx8bw4zab7TUXQr+DM-+ERBO-UyQ@mail.gmail.com>
 <CADvTj4qyRRCSnvvYHLvTq73P0YOjqZ=Z7kyjPMm206ezMePTpQ@mail.gmail.com>
 <aDdXRPD2NpiZMsfZ@shell.armlinux.org.uk> <CADvTj4pKsAYsm6pm0sgZgQ+AxriXH5_DLmF30g8rFd0FewGG6w@mail.gmail.com>
 <8306dac8-3a0e-4e79-938a-10e9ee38e325@lunn.ch> <CADvTj4rWvEaFyOm2HdNonASE4y1qoPoNgP_9n_ZbLCqAo1gGYw@mail.gmail.com>
 <1e6e4a44-9d2b-4af4-8635-150ccc410c22@lunn.ch>
In-Reply-To: <1e6e4a44-9d2b-4af4-8635-150ccc410c22@lunn.ch>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Wed, 28 May 2025 15:14:16 -0600
X-Gm-Features: AX0GCFtJbKcSZrV6aI_DEhodkWvBg_0kUSxJMObTitKRlUNU-S1IGzUWOHTLoqc
Message-ID: <CADvTj4r1VvjiK4tj3tiHYVJtLDWtMSJ3GFQgYyteTnLGsQQ2Eg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] net: stmmac: allow drivers to explicitly select
 PHY device
To: Andrew Lunn <andrew@lunn.ch>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>, wens@csie.org, netdev@vger.kernel.org, 
	linux-sunxi@lists.linux.dev, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Furong Xu <0x1207@gmail.com>, Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 28, 2025 at 3:05=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Wed, May 28, 2025 at 01:45:40PM -0600, James Hilliard wrote:
> > On Wed, May 28, 2025 at 1:27=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wr=
ote:
> > >
> > > > I think a lot of ethernet drivers use phy_find_first() for phy scan=
ning
> > > > as well so it's not limited to just stmmac AFAIU.
> > >
> > > You need to differentiate by time. It has become a lot less used in
> > > the last decade. DT describes the PHY, so there is no need to hunt
> > > around for it. The only real use case now a days is USB dongles, whic=
h
> > > don't have DT, and maybe PCIe devices without ACPI support.
> >
> > I mean, hardware probing features for this sort of use case have been
> > getting added outside the network subsystem so I'm not sure what the
> > issue with this is as those use cases don't appear to be meaningfully
> > different.
> >
> > > I suggest you give up pushing this. You have two Maintainers saying n=
o
> > > to this, so it is very unlikely you are going to succeed.
> >
> > So what should I be doing instead?
>
> Describe the one PHY which actually exists in device tree for the
> board, and point to it using phy-handle. No runtime detection, just
> correctly describe the hardware.

But the boards randomly contain SoC's with different PHY's so we
have to support both variants.

> Do you have examples of boards where the SoC variant changed during
> the boards production life?

Yes, the boards I'm working for example, but this is likely an issue for
other boards as well(vendor BSP auto detects PHY variants):
https://www.zeusbtc.com/ASIC-Miner-Repair/Parts-Tools-Details.asp?ID=3D1139


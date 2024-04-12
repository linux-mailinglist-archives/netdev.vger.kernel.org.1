Return-Path: <netdev+bounces-87431-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 573BA8A31D1
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 17:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DAC928457B
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 15:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6633147C6C;
	Fri, 12 Apr 2024 15:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SilwzUMm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF4C1474B7
	for <netdev@vger.kernel.org>; Fri, 12 Apr 2024 15:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712934627; cv=none; b=jl7gyEvPLzkt4RWH+6WASPfTfdAOzdskDEkgOuo7U7+egN0/dOdHlygGhwmAtzVWFP6MrKXFN0Fu67b1QxGGkAJKT/J5b1HjjmH/tEdym79yyjG9naGNtz4tr82J05farLzsIDZrvsgoFtanQ3jo1S/vIZAJBlPi91uWaQ1hrIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712934627; c=relaxed/simple;
	bh=agRLU8EQ4WQY7VJ4/atO1fSX82MYqrZk+GudECsRmKM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MNfdRsVIzcSEw/AZWmJKPTzmq7yJOuX5J8zmgCB8r3h6D7X68/Uly4tbPF8GSUDBzLXTdIyCmQHVafNIagRyUrSTCuvP6zGAPo//Gugt1eYbR2Y0MC9eO7Vzp+IC4AZN34/fsLYwMuRDIz5vW5lRLCaDUxMMazThALomzE6bdeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SilwzUMm; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a52309ed543so126637166b.1
        for <netdev@vger.kernel.org>; Fri, 12 Apr 2024 08:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712934624; x=1713539424; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CHMziSdWqK6YK3GX/xxuVhVuRLO3CsqvGQAdmBEl4TM=;
        b=SilwzUMmN84uFUtM079a57GIja1MT7KoSW84qRDpXKBYp4cJQudRPJToZsVOw1ooyc
         SaJKBBJAZksQXOPyTyU0ZjwtJ2dJv+eE3IdBHhQTYdzP3+fn5buMOuvHwOjigDBRLvKr
         vHkMniRcthBSCTvcR5vxiy2qNlowMMyTisWZ5qigoNYVo7mrp+MNB7Y45/hOgml2BlY2
         WfucrKpnudFgIepwhXYBdRiLX71e1Wzupxqcl28hZMY9BNPEttgLP9mezi6Z0Q3f95nf
         xUVEs6YMn9XJ7rGxT8023hI2qrR6cYVMOalumejYc1O7w/jSnYx95SygSUvkgpp/2S6k
         8Hyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712934624; x=1713539424;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CHMziSdWqK6YK3GX/xxuVhVuRLO3CsqvGQAdmBEl4TM=;
        b=Ibj+lg8fGkzFqiaexUjPupzaRdKPWBxpHxMjvuDk30Mxb6EgLp6QgoDcmTX7DYTiVL
         Kr4pNJT0dxF2vKUiU2ZHDNpiKCx2JqJcWr5PmuQ/d4rasHXcoub200PtmB2vaQ2KkGbe
         8ozfd+RgFlocQxEhji/sCDucHPhK2+oP+MSYE9WMWB0ZCC752FDOkRDyfjhDeAzDtjO+
         xomsyVOIBgIo86gSz524kAN4HO0X5F9V41SVj24CQ+sFNHXI6lhNHv58RI+3ILraFZlJ
         Um2hhNImNB8wSVvQZI0BVYQL0MHAUM01vpvTNH7vEgeGad8URksjATHWSou9zx7mP5p5
         cB5g==
X-Forwarded-Encrypted: i=1; AJvYcCV3QQ260kJyGdIt8kHvriWICmbBgDLGPQiVKomOXgd8ojyTbk5rgYA3WKHIVVkiCp2sAYKXY0vjGCxGxzeP/IGpl1Aqkkvf
X-Gm-Message-State: AOJu0YykDuY3bDIq+xjWP7WycO+0D77VOPezlTYf8JBzuxiQT5BZWS+Z
	7MqNnIR9oTRf5YqtpqRheYCmXQksAx0JrgwxRVAAHVWGbT/+bdrQhDg5uesQahsFHBTZDEsVbj4
	IyhGhBJ1RJyeKNNrabHZoGvGM5fE=
X-Google-Smtp-Source: AGHT+IFrSS1oKeRwfM66JBgi4H/sbyA1sIrzW0IOS4P7nI01QyHBsDod8zCietPEaq36k+aVhdF9kEdxZGUibX260T0=
X-Received: by 2002:a17:906:5a98:b0:a51:ad4e:15f0 with SMTP id
 l24-20020a1709065a9800b00a51ad4e15f0mr1959384ejq.29.1712934624264; Fri, 12
 Apr 2024 08:10:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240329154225.349288-1-edumazet@google.com> <20240329154225.349288-7-edumazet@google.com>
 <CAL+tcoBa1g1Ps5V_P1TqVtGWD482AvSy=wgvvUMT3RCHH+x2=Q@mail.gmail.com> <CANn89iJKQuSLUivtGQRNxA2Xd3t8n68GQ_BAz2dp28eU9wzVcg@mail.gmail.com>
In-Reply-To: <CANn89iJKQuSLUivtGQRNxA2Xd3t8n68GQ_BAz2dp28eU9wzVcg@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 12 Apr 2024 23:09:47 +0800
Message-ID: <CAL+tcoATkG9RcSr_zPNoggengOPfRiZSpvcJWYpLACBOoHL=fQ@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 6/8] net: rps: change input_queue_tail_incr_save()
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 31, 2024 at 12:01=E2=80=AFAM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> On Sat, Mar 30, 2024 at 3:47=E2=80=AFPM Jason Xing <kerneljasonxing@gmail=
.com> wrote:
> >
> > Hello Eric,
> >
> > On Fri, Mar 29, 2024 at 11:43=E2=80=AFPM Eric Dumazet <edumazet@google.=
com> wrote:
> > >
> > > input_queue_tail_incr_save() is incrementing the sd queue_tail
> > > and save it in the flow last_qtail.
> > >
> > > Two issues here :
> > >
> > > - no lock protects the write on last_qtail, we should use appropriate
> > >   annotations.
> > >
> > > - We can perform this write after releasing the per-cpu backlog lock,
> > >   to decrease this lock hold duration (move away the cache line miss)
> > >
> > > Also move input_queue_head_incr() and rps helpers to include/net/rps.=
h,
> > > while adding rps_ prefix to better reflect their role.
> > >
> > > v2: Fixed a build issue (Jakub and kernel build bots)
> > >
> > > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > > ---
> > >  include/linux/netdevice.h | 15 ---------------
> > >  include/net/rps.h         | 23 +++++++++++++++++++++++
> > >  net/core/dev.c            | 20 ++++++++++++--------
> > >  3 files changed, 35 insertions(+), 23 deletions(-)
> > >
> > > diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> > > index 1c31cd2691d32064613836141fbdeeebc831b21f..14f19cc2616452d7e6afb=
baa52f8ad3e61a419e9 100644
> > > --- a/include/linux/netdevice.h
> > > +++ b/include/linux/netdevice.h
> > > @@ -3249,21 +3249,6 @@ struct softnet_data {
> > >         call_single_data_t      defer_csd;
> > >  };
> > >
> > > -static inline void input_queue_head_incr(struct softnet_data *sd)
> > > -{
> > > -#ifdef CONFIG_RPS
> > > -       sd->input_queue_head++;
> > > -#endif
> > > -}
> > > -
> > > -static inline void input_queue_tail_incr_save(struct softnet_data *s=
d,
> > > -                                             unsigned int *qtail)
> > > -{
> > > -#ifdef CONFIG_RPS
> > > -       *qtail =3D ++sd->input_queue_tail;
> > > -#endif
> > > -}
> > > -
> > >  DECLARE_PER_CPU_ALIGNED(struct softnet_data, softnet_data);
> > >
> > >  static inline int dev_recursion_level(void)
> > > diff --git a/include/net/rps.h b/include/net/rps.h
> > > index 7660243e905b92651a41292e04caf72c5f12f26e..10ca25731c1ef766715fe=
7ee415ad0b71ec643a8 100644
> > > --- a/include/net/rps.h
> > > +++ b/include/net/rps.h
> > > @@ -122,4 +122,27 @@ static inline void sock_rps_record_flow(const st=
ruct sock *sk)
> > >  #endif
> > >  }
> > >
> > > +static inline u32 rps_input_queue_tail_incr(struct softnet_data *sd)
> > > +{
> > > +#ifdef CONFIG_RPS
> > > +       return ++sd->input_queue_tail;
> > > +#else
> > > +       return 0;
> > > +#endif
> > > +}
> > > +
> > > +static inline void rps_input_queue_tail_save(u32 *dest, u32 tail)
> > > +{
> > > +#ifdef CONFIG_RPS
> > > +       WRITE_ONCE(*dest, tail);
> > > +#endif
> > > +}
> >
> > I wonder if we should also call this new helper to WRITE_ONCE
> > last_qtail in the set_rps_cpu()?
> >
>
> Absolutely, I have another patch series to address remaining races
> (rflow->cpu, rflow->filter ...)
>
> I chose to make a small one, to ease reviews.

Hello Eric,

I wonder if you already have a patchset to change those three members
in struct rps_dev_flow? I looked through this part and found it's not
that complicated. So if not, I can do it :)

Thanks,
Jason


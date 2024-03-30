Return-Path: <netdev+bounces-83512-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DF90892BF0
	for <lists+netdev@lfdr.de>; Sat, 30 Mar 2024 17:08:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39922282B3C
	for <lists+netdev@lfdr.de>; Sat, 30 Mar 2024 16:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90AC53A1A8;
	Sat, 30 Mar 2024 16:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lbJ15pgk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C524F335D8
	for <netdev@vger.kernel.org>; Sat, 30 Mar 2024 16:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711814898; cv=none; b=TtNtvnRM4mLHxpsyuSf2oUJ4eUHilE+lOUFYTkGUrBLVItc17kCESpcfGtrxRgYLCIruzsDy2kCRV4l0exBhyX2nSmWPvwb6KAROqkBsT8lZi1KqUNBI1tAml0RTmdUP3MyX8zS6X0RMwjNxxE4FdPsrOpnVrjxN+0yzymEAs4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711814898; c=relaxed/simple;
	bh=aZ+ahDgFULwD6gTd+XIhN5rHorld6C4W6kMFpEbq40E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p/Bid6CqnEu/kbI4uE+IoSDwyUpAzD6f1enGfEqH2f2Gczw99UJZjg2xkBjvMRLRX+eeKJ4CL6/bs00gzWZMnNROzrPYeBVpCHQkcBZrk7Y3/6IrOKn5I8TZJroZK3X8kC1xo6V3ivodwx5O4gCj591YGDTy2AeZ/O57CTJMVE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lbJ15pgk; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a4e4e7057fbso46227466b.0
        for <netdev@vger.kernel.org>; Sat, 30 Mar 2024 09:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711814895; x=1712419695; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tqYtiFl3gMtiR/slz7/31AGueSg/Uoe5u6YbVitMFwQ=;
        b=lbJ15pgkjoFIosMOnM15oDV4ZjsVOR+mLG7MpqWIe/OxlPUzLHiUCKsp9rT7wvG1/v
         +FWT5/m8KnaR7+HlmP/96uL5L0YSEtfv4iNb5zaSGe31yGn2ybLrNPbKTllri+aecnrz
         5g0ch8eiMFa1/lZSV8IhhaAXQ5qtQM10Ark4YR/Uyg0uDcytyz0u+TNvu6yDei+2Fi8H
         tfz0DE/lSBnTJ59PqGsCwpFtSYcpirfgAukTfu/EH6DBDOXXHGq37KCLeq0QzHgLHnKd
         zBOpR0SHS4OUA+5bnxBqzOkJyRwV1+l6Vh4lOWMUr00oQGYQg+j9azLILp8x0wrOMLU5
         MnDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711814895; x=1712419695;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tqYtiFl3gMtiR/slz7/31AGueSg/Uoe5u6YbVitMFwQ=;
        b=u/CA6LmMHt4V6bE8x8M7s37MmylQALCtHq4+mceDQZAqNd4/fAxZPgDOZl6GVJR59W
         gsiGrrlsE73I4X7lUvt2DB8/WNP+8GmqitAd5O3Kv1sVowW6igHWTevgTIOL7hNfcHE7
         C9WkfXWXhlqxz0RDcQv6PpVuwihJtGNHexUNRcc2prg2EvRQgD/JvUU9CT9jT4USy3fy
         5LiLJGbdeyMnYn2x5wn/H72miFHTUI7ZjvU0ftP4du63VN8sIyL0ZcXBX6ehQEkTn1+r
         iOMpJwiwtWWTeL7+mPbfqUNXqqG7lVjo/jbWeqeZqEQYj3fUCQVFyN013hSM2C9MGF20
         CrhQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTtXU+6pEXQJqrUGJAmKipoLc4xvGdwzemL7yJ/6GhHzxpfU+6n9utKv0EVZFUkG7jmZs4rHIzmrUaxO1F/1uCg7WgeUqR
X-Gm-Message-State: AOJu0YxLq3mAZHis+WeS7/yyLMaRyTmizM9mxWipMwQ5aIcfR8N4nBSE
	c1l9c8aoYfwDbWd6s2y7sTXtt/bCVy3m/QycqxaUn4FHoiTgq3VchaGc3Fo+4NbUzjlStDJy17X
	08ncnUrtnyGt+5GX/AB+9H2+N10Q=
X-Google-Smtp-Source: AGHT+IGd2O8mKMifiEWtXwxmvNbMq1I5C6mjN0KPpO4vKSiTRx2qpOuLgKan1Goru7+nEAF1Dq82X61eIrdjqwvC7yU=
X-Received: by 2002:a17:907:86a0:b0:a4e:5abe:8164 with SMTP id
 qa32-20020a17090786a000b00a4e5abe8164mr115987ejc.59.1711814894828; Sat, 30
 Mar 2024 09:08:14 -0700 (PDT)
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
Date: Sun, 31 Mar 2024 00:07:37 +0800
Message-ID: <CAL+tcoBqrWX0AMFfGOJoTTT6-Mgc7HqmCU0-bzLH7rrxBGqEng@mail.gmail.com>
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

Great. Now I have no more questions :)

Thanks,
Jason


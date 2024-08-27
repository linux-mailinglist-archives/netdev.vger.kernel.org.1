Return-Path: <netdev+bounces-122364-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3798960D54
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 16:15:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A9A61F2374F
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 14:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C53B1C3F29;
	Tue, 27 Aug 2024 14:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="emAdTITg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DED91C3F2A
	for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 14:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724768095; cv=none; b=uv2TumjJNTJk+XwE9ROSZnjNdgmJ1u9cXWxutsZO2uC3DJeMqNErDBsZbN0RKWtZPjN5LvDocfDJSiJKXph3Y+B4BtOvc8Tq9ssA8EYaPj2ySJLVJTH82ceJ5DiNKGNQh7qUsxaxS7w/F/Z0+oy3ph8JQHwniRCVRCNcE58FI40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724768095; c=relaxed/simple;
	bh=FFIbVvuX8f3vRvrEsglBErIEZvRLJmczVCxLqMxeW0c=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=j1Fhdwet9Z6lIUMWzlSFpr3A5okPyKuBal8ETc95G8UtF3yXUSXQsHx5iwXe5e/cZp2KETcdi8Kxxn+qrDaIr1aChgo6Du7OA0FR7fhrolCcc2XDeIW88lHik4bsWlU+slPMjS+gYipEdDHbk3PhlhODUbT8vv9+oLE/kzLWisc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=emAdTITg; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6b0c5b1adfaso50804117b3.0
        for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 07:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724768092; x=1725372892; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2qQE93EuJ8C6m1Zm69S4b+4Z+l0tnRzas3Pv248i0Us=;
        b=emAdTITgKmqaTdQ8rgkITK6WGsh0GI34+bAl0oBR3NkkEk+Fn1h6atkwGhs8hCMXn4
         SQy3oZGMb2mG9J/x5q25IVELaub3ZJivcsqffwKeIJuRDFGzaODuc0bln3NPvj+m6W1n
         PGzemndWRy0tPvXalFjmtaFOVahUY+mLQWj7dmQoKg1aBRKfT6xLi3DSlzxlRVXVB4Ek
         Tq3IBmmdmQsOM8gXeJuA1wqekgecqGOb0fEpDudSOYtUiQYjSPJEkeZ25N+/DMJveD3P
         cPQisF/fseJdNSUW6J0sWiAndZ4mAJAcNKSPT5nDD+PpWQXn2lYv6l1Q5nDd+XoEXMcQ
         ioag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724768092; x=1725372892;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2qQE93EuJ8C6m1Zm69S4b+4Z+l0tnRzas3Pv248i0Us=;
        b=Nt78AcKao4/tnlC91d+Aupag2OM1lnV+RO5WE9YrStRqo43IxmSK+/bjXUYZFz+Wbw
         gvxqvuDfvh++PDE2BLute0i/GmElRoy9/bP9TlakBcblZLCMHBULz1VTohqfKs0v6fDu
         UQu5nL3HZsYhYv2d9A+OFSpBmxP1qaQjNAp2nauVP4thm3rPmSHDVsKjHo3+lKvwDoPh
         oLBlNghaP4ufO1PV1oGGYA3LkU7/LHbg3J0x/mWA7i1SJUfv/l5EB1miXI+IR5fbLN6u
         Zg41sIdxmIgzvGvM1yC+xlfh0GMWJkqxZU56hq+XD9+2SWm+t6LsP7rxt6MvHBQObWw2
         VRSw==
X-Forwarded-Encrypted: i=1; AJvYcCVu/7F8IYe8dGDUGR0zAYFUsEqGuzBDkKHuiBYbBjzjW+Ya29i8ejvNB5m2HbnLlEfoHZjDZao=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3ds9cw5gFI5dLW6wFEFWBTwbsW7VexgwhXyVFp4FE4uSkEJT+
	6hdsL517x53LaaLpKcjX7TXhL7sVhExt5aynvq/lfAulolpy+yVMbF/Uww/mQQC3caSHOKOpDV7
	i+BZH8hwJQbIYk8q9QugXl2r+yQ==
X-Google-Smtp-Source: AGHT+IHD1pti+RcM2gBaKRTNaxJAxy5frCEvuFNtI7bYnk3DLwE6ZyNpUaddJgzL9TBfOzSkh8FitRYY+5aCVCpN2tI=
X-Received: by 2002:a05:690c:dc8:b0:6af:fc23:178e with SMTP id
 00721157ae682-6c624fb5b0bmr159165597b3.1.1724768092173; Tue, 27 Aug 2024
 07:14:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Lisong Xu <lisongxu@gmail.com>
Date: Tue, 27 Aug 2024 09:14:41 -0500
Message-ID: <CABdStnNL4ipEfT4xiJXH=4bmyOdRdD4n2AzF31TreDKMyOnhHA@mail.gmail.com>
Subject: Re: [PATCH net] tcp_cubic: switch ca->last_time to usec resolution
To: Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"eric.dumazet@gmail.com" <eric.dumazet@gmail.com>, Mingrui Zhang <mrzhang97@gmail.com>, 
	Yuchung Cheng <ycheng@google.com>, Lisong Xu <xu@unl.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> ________________________________________
> From: Eric Dumazet <edumazet@google.com>
> Sent: Monday, August 26, 2024 12:27 PM
> To: Neal Cardwell
> Cc: David S . Miller; Jakub Kicinski; Paolo Abeni; netdev@vger.kernel.org=
; eric.dumazet@gmail.com; Mingrui Zhang; Lisong Xu; Yuchung Cheng
> Subject: Re: [PATCH net] tcp_cubic: switch ca->last_time to usec resoluti=
on
>
> Caution: Non-NU Email
>
>
> On Mon, Aug 26, 2024 at 3:26=E2=80=AFPM Neal Cardwell <ncardwell@google.c=
om> wrote:
> >
> > On Mon, Aug 26, 2024 at 5:27=E2=80=AFAM Eric Dumazet <edumazet@google.c=
om> wrote:
> > >
> > > bictcp_update() uses ca->last_time as a timestamp
> > > to decide of several heuristics.
> > >
> > > Historically this timestamp has been fed with jiffies,
> > > which has too coarse resolution, some distros are
> > > still using CONFIG_HZ_250=3Dy
> > >
> > > It is time to switch to usec resolution, now TCP stack
> > > already caches in tp->tcp_mstamp the high resolution time.
> > >
> > > Also remove the 'inline' qualifier, this helper is used
> > > once and compilers are smarts.
> > >
> > > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > > Link: https://urldefense.com/v3/__https://lore.kernel.org/netdev/2024=
0817163400.2616134-1-mrzhang97@gmail.com/T/*mb6a64c9e2309eb98eaeeeb4b085c4a=
2270b6789d__;Iw!!PvXuogZ4sRB2p-tU!CFiPa78hSiQJz2pJVSL2IbKk_L0o9RGTCO29eeo32=
aJX9_1V_QyTFP9gxuafoE_Ye7DtfD-LhjMf$
> > > Cc: Mingrui Zhang <mrzhang97@gmail.com>
> > > Cc: Lisong Xu <xu@unl.edu>
> > > ---
> > >  net/ipv4/tcp_cubic.c | 18 ++++++++++--------
> > >  1 file changed, 10 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/net/ipv4/tcp_cubic.c b/net/ipv4/tcp_cubic.c
> > > index 5dbed91c6178257df8d2ccd1c8690a10bdbaf56a..3b1845103ee1866a31692=
6a130c212e6f5e78ef0 100644
> > > --- a/net/ipv4/tcp_cubic.c
> > > +++ b/net/ipv4/tcp_cubic.c
> > > @@ -87,7 +87,7 @@ struct bictcp {
> > >         u32     cnt;            /* increase cwnd by 1 after ACKs */
> > >         u32     last_max_cwnd;  /* last maximum snd_cwnd */
> > >         u32     last_cwnd;      /* the last snd_cwnd */
> > > -       u32     last_time;      /* time when updated last_cwnd */
> > > +       u32     last_time;      /* time when updated last_cwnd (usec)=
 */
> > >         u32     bic_origin_point;/* origin point of bic function */
> > >         u32     bic_K;          /* time to origin point
> > >                                    from the beginning of the current =
epoch */
> > > @@ -211,26 +211,28 @@ static u32 cubic_root(u64 a)
> > >  /*
> > >   * Compute congestion window to use.
> > >   */
> > > -static inline void bictcp_update(struct bictcp *ca, u32 cwnd, u32 ac=
ked)
> > > +static void bictcp_update(struct sock *sk, u32 cwnd, u32 acked)
> > >  {
> > > +       const struct tcp_sock *tp =3D tcp_sk(sk);
> > > +       struct bictcp *ca =3D inet_csk_ca(sk);
> > >         u32 delta, bic_target, max_cnt;
> > >         u64 offs, t;
> > >
> > >         ca->ack_cnt +=3D acked;   /* count the number of ACKed packet=
s */
> > >
> > > -       if (ca->last_cwnd =3D=3D cwnd &&
> > > -           (s32)(tcp_jiffies32 - ca->last_time) <=3D HZ / 32)
> > > +       delta =3D tp->tcp_mstamp - ca->last_time;
> > > +       if (ca->last_cwnd =3D=3D cwnd && delta <=3D USEC_PER_SEC / 32=
)
> > >                 return;
> > >
> > > -       /* The CUBIC function can update ca->cnt at most once per jif=
fy.
> > > +       /* The CUBIC function can update ca->cnt at most once per ms.
> > >          * On all cwnd reduction events, ca->epoch_start is set to 0,
> > >          * which will force a recalculation of ca->cnt.
> > >          */
> > > -       if (ca->epoch_start && tcp_jiffies32 =3D=3D ca->last_time)
> > > +       if (ca->epoch_start && delta < USEC_PER_MSEC)
> > >                 goto tcp_friendliness;
> >
> > AFAICT there is a problem here. It is switching this line of code to
> > use microsecond resolution without also changing the core CUBIC slope
> > (ca->cnt) calculation to also use microseconds.  AFAICT that means we
> > would be re-introducing the bug that was fixed in 2015 in
> > d6b1a8a92a1417f8859a6937d2e6ffe2dfab4e6d (see below). Basically, if
> > the CUBIC slope (ca->cnt) calculation uses jiffies, then we should
> > only run that code once per jiffy, to avoid getting the wrong answer
> > for the slope:
>
> Interesting.... would adding the following part deal with this
> problem, or is it something else ?
>
> diff --git a/net/ipv4/tcp_cubic.c b/net/ipv4/tcp_cubic.c
> index 3b1845103ee1866a316926a130c212e6f5e78ef0..bff5688ba5109fa5a0bbff7dc=
529525b2752dc46
> 100644
> --- a/net/ipv4/tcp_cubic.c
> +++ b/net/ipv4/tcp_cubic.c
> @@ -268,9 +268,10 @@ static void bictcp_update(struct sock *sk, u32
> cwnd, u32 acked)
>
>         t =3D (s32)(tcp_jiffies32 - ca->epoch_start);
>         t +=3D usecs_to_jiffies(ca->delay_min);
> -       /* change the unit from HZ to bictcp_HZ */
> +       t =3D jiffies_to_msecs(t);
> +       /* change the unit from ms to bictcp_HZ */
>         t <<=3D BICTCP_HZ;
> -       do_div(t, HZ);
> +       do_div(t, MSEC_PER_SEC);
>
>         if (t < ca->bic_K)              /* t - K */
>                 offs =3D ca->bic_K - t;


How about something like the following? basically, we change
ca->epoch_start also to usec.

ca->epoch_start =3D tp->tcp_mstamp;

...

t =3D (s32)(tp->tcp_mstamp - ca->epoch_start);
t +=3D ca->delay_min;
/* first change the unit from usec to msec to avoid overflow*/
do_div(t, USEC_PER_MSEC);
/* then change the unit from msec to bictcp_HZ */
t <<=3D BICTCP_HZ;
do_div(t, MSEC_PER_SEC);


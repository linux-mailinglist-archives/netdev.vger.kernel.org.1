Return-Path: <netdev+bounces-122915-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BFD2963178
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 22:10:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC4091F25478
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 20:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 621571A7ADD;
	Wed, 28 Aug 2024 20:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yp8x+CJM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1ACD1ABEB8
	for <netdev@vger.kernel.org>; Wed, 28 Aug 2024 20:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724875819; cv=none; b=AvSfpOlFwVQWkTdOmGFje65pogZNDkCCDh56prBI5MHL3Tb/8rS2x7tBtQYv2XBA3QqOAJgCegkRJZ9aRe6ODUeAtcsMgbZ161AhlGfIXqAIMZuDqHXbV9mjsn4Xs8dT7heqA3LTHbqtgmUhtemaLa1Lxhe7FLQTFql/MaXXc4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724875819; c=relaxed/simple;
	bh=w8b6PkIYjJZovuOCIqwavIgc16+Xh9q9q81R1DI+cuc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lL6UEzduFbjHq66FWEFwTZ3nUnmbqsmPelukViw0c9hy1WyMeU9PdVshUNU8ilC9YaXRIzpHxL5q4buervxiWcpDc5RLinveggcCMUB+EYAuC4BJI6cUmSkqy5Wh5/RPfyZym0q5CD9T4xocnxh+RoEEITdQIFa+sSBRIbVLS54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yp8x+CJM; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4518d9fa2f4so75531cf.0
        for <netdev@vger.kernel.org>; Wed, 28 Aug 2024 13:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724875816; x=1725480616; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WRQZULi0fxdGaDOWgUnJwTM13nI0IO1slOUeig8k28M=;
        b=yp8x+CJMG5utUgzd1vDw7Gjppw/nAhv6+frjKp2XBwq4d9o4369oqFkUY004DbWABJ
         sSjQAMMzzfmRRYb7hufIjkBq60lHg6lNWtmTeoOOfHA+IoVlG85Gwy+rXwqfiSrT8UHE
         aXxCNXyxVm3Xm6zG+XntXvynjvjsFHPcoTtC3jLLF2gTP4ovnI4eeKRB/J30FtOHSYu/
         r0RqRVoV1wfkmwingjI01Zi7Y8EHtpSbEs0ijrAW6TcFquBfCFk75pfNNu3Lod4jmJxm
         CfN9v4ybJIM/GEZVEhjbStlYTqBtn4bDZ4iHjKa43CFQkqNOgsHbdGCvPZxGX2yg9OJ8
         FnNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724875816; x=1725480616;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WRQZULi0fxdGaDOWgUnJwTM13nI0IO1slOUeig8k28M=;
        b=FWWClXX8h7Dszrvb3J65rk7FZzHlpYF91lkHCSbEXaVpGfkujgBUgqDbP6fN65bhbK
         Mb9yBye0Wmi8OlOUGZ9WIr9SvnJxx0+F0mRivoy4Ob2+ihf6Ln2Gq8O2zGoHv/V7AARH
         eWGDKIgJPtAcflYi9VcH1U5vLkI6QTgCK+4/pWE9X0KskSzWnzGM+VDPjktvLqd6U1yX
         kEJt+AYPNLLbyT81nvJTSI+8jnvsj9tg+xt5nRouCGTLIhUEy5pC2XW5WevpxvL/Nv1m
         TcouWIzFZDx1vYeNyINSSdDNHJ7PU1NZxgVSAqK5xp5XoCP+2TgujBM+/oCBILIo/Usa
         Qw9w==
X-Forwarded-Encrypted: i=1; AJvYcCWfwj9OU0ao3JXLe3mxu+BlsPLM1K/ahOkjwp4A3JCQTVG+c0VskgHMGRwjr+OSiDDjr0IjsGg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4ibDsULaLyzhiadMw+H0EMjqxIdLig+B2G13AtZR2L3i8exGv
	hf0iuZxI3DQ5lSDr8jiaEdNzejuo4Kgpn7wJ5utCcNUH5QqZ8uCSjHvrICjfra3KLrH0j3bwVO1
	4WI/t6pJnz61LeJA9GvrjAr1xwOnX2vvHFlbI
X-Google-Smtp-Source: AGHT+IFVVPvKyQ132jKWfjlBFDK33k//CBo5j8f7kHW4CS1dThiSw5RYeMAHF/V0vGwk0WFu/U3PVi1al3YuWSKNdoc=
X-Received: by 2002:ac8:64cd:0:b0:456:7f34:f560 with SMTP id
 d75a77b69052e-4567fcbdfbbmr637231cf.22.1724875816089; Wed, 28 Aug 2024
 13:10:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240826092707.2661435-1-edumazet@google.com> <CADVnQy=Z697P_gtkXMgPiASS6YwJ4PLDkqei3NvGJ5csKE8nhw@mail.gmail.com>
 <CANn89iJwVq5OyH9PpWjk4vWGuLOZi=rfEf7HMcoGZ3Uf4nW-Rg@mail.gmail.com>
In-Reply-To: <CANn89iJwVq5OyH9PpWjk4vWGuLOZi=rfEf7HMcoGZ3Uf4nW-Rg@mail.gmail.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Wed, 28 Aug 2024 16:09:56 -0400
Message-ID: <CADVnQymWJ1Ay=qWVNHeJ=kLVKnNZkTs-U38ZLGS-6JnF+xM4pg@mail.gmail.com>
Subject: Re: [PATCH net] tcp_cubic: switch ca->last_time to usec resolution
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Mingrui Zhang <mrzhang97@gmail.com>, Lisong Xu <xu@unl.edu>, Yuchung Cheng <ycheng@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 26, 2024 at 1:27=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
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
> > > Link: https://lore.kernel.org/netdev/20240817163400.2616134-1-mrzhang=
97@gmail.com/T/#mb6a64c9e2309eb98eaeeeb4b085c4a2270b6789d
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

I don't think that would be sufficient to take care of the issue.

The issue (addressed in d6b1a8a92a1417f8859a6937d2e6ffe2dfab4e6d) is
that in the CUBIC bictcp_update() computation of bic_target the input
is tcp_jiffies32. That means that the output bic_target will only
change when the tcp_jiffies32 increments to a new jiffies value.

That means that if we were to go back to executing the bic_target  and
ca->cnt computations more than once per jiffy, the ca->cnt "slope"
value becomes increasingly incorrect over the course of each jiffy,
due to the ca->cnt computation looking like:

  ca->cnt =3D cwnd / (bic_target - cwnd);

...and the fact that cwnd can update for each ACK event, while
bic_target is "stuck" during the course of the jiffy due to the jiffy
granularity.

I guess one approach to trying to avoid this issue would be to change
the initial computation of the "t" variable to be in microseconds and
increase BICTCP_HZ from 10 to 20 so that the final value of t also
increases roughly once per microsecond. But then I suspect a lot of
code would have to be tweaked to avoid overflows... e.g., AFAICT with
microsecond units the core logic to cube the offs value would overflow
quite often:

  delta =3D (cube_rtt_scale * offs * offs * offs) >> (10+3*BICTCP_HZ)

IMHO it's safest to just leave last_time in jiffies. :-)

neal


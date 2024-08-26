Return-Path: <netdev+bounces-121994-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE57E95F810
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 19:27:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E70E1C2237E
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 17:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CA3C198E9E;
	Mon, 26 Aug 2024 17:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TwVyWBw7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7F0198E99
	for <netdev@vger.kernel.org>; Mon, 26 Aug 2024 17:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724693249; cv=none; b=SsAcSMBfUjEQz7mQFUE2ICFs6w+AQKNXUljRqVC97WBdmPLTsJy/c9w4H/ufkkwJQUkWc0d9iLG5uqIlmgMkYpFY6YJnuZqWCHzy0GOybnZ+lcuxq5kbZMRdP3jOjJjbBB7UPqUn7d1b/b8Wi1KTzBBcKjqKREHFeSB7c7tbKsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724693249; c=relaxed/simple;
	bh=GG0kyWBF7pGc+XvoEpS6Eq5nxn+pDWdxGpoLmGtH5oQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t8Kt+3gFquet653bB8dwgBJLx1ixizs7Cp1Cv0wEVkZqIlxbFTX/7wXE7x2TYda32HgO4dmDRCxZKF4WI55nxiIAKzNClFfPP6jz9lP1gpgIe+Rfo76gtGHBXoFgCjVB2/fq8gVNa/o3s+xLeUGEyOyIbc2+6E4WTS0ioEVwMTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TwVyWBw7; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a869f6ce2b9so452689966b.2
        for <netdev@vger.kernel.org>; Mon, 26 Aug 2024 10:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724693246; x=1725298046; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PvuvOohiK2kVc/GMqKz5FTXViTH0DhlYVs1rpkwutnI=;
        b=TwVyWBw7QPuAR/2azU5VUg9eixZgWDSkTJ5HGScMU2tmG2CBgnNYqp8qRxsCrXGK2o
         dTTPA9zgzs6ieiTzbyjVlacY9g/OS7XEhvaxXaFyRJIjneAim/OS7HKFGFdPlodmPkZm
         luS7rOWzJpnZJWkaEAU5NycNnPKTBwKe7wiSVP5VXfDbFi6qO1mXijLDU/RoQk2U+ABT
         5Tduf/hS2P82i3aGNgUdFz25nTzksWglXhXSZz7RvZihdbiBnR2EbN2wIlNrT3Ti/brp
         CR37a9sJNoQK4F+KFa7iWLEfOFDgz56j/WBY/2cMupt3KAIIpT8j6RLqyn6nbKuqqfT5
         nxHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724693246; x=1725298046;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PvuvOohiK2kVc/GMqKz5FTXViTH0DhlYVs1rpkwutnI=;
        b=IVtXQHqhcuculg1K2m95FS74q6vFO3NMabn5uVayFuFEOgCi2hSCxiuTv4CySdTnXg
         D5JHH/0IiCKCNU8O1s5+rIF1gonELpNHLFSoaNrY6rjSre+3NNDUXXfQvcmD4gqCru3X
         4h+TRWrF+hfn83NkTdE/zaZnggsfq2MimLVWsXIlc9X1D1OJ+l9qDcQL8F7MqHNyIUrj
         yv4SolQ8pMlYGnpIICkRl/6/YHqwgey90A75tE4zSIEvsx289cQvn0AHUA00rAAWug/0
         I7O/zmVLE+auNonU64fjAdwmBmvRNiMA6wMnXBTQSsPutQwpf7Ld6g7PRVlR1rMtz8+5
         XUmQ==
X-Forwarded-Encrypted: i=1; AJvYcCWoevj7hggN9WDrlsZ0qn1tCW5uXUcfDWzFlpgyMuqWXR9bf6j9wtkb0djqauVlQn6+BB98Bjg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yys5h6Zl/XbfJyGXgCDeLx50srP6XDFfObiXDxf/rRtlIyjdKqi
	4/XaZZNZN813cE6Jrpa/wC/v1nGLOORPexYwIV4IOdXVu/SF7J71iZPV/xljLhIxOj4+dYCWQZI
	hraHik20DMLN+vk4gPdDkIrJviA8x9D9ac80b
X-Google-Smtp-Source: AGHT+IHr5/wnZFZDgu7vVvP620oIqvUWguNOJgQVQkvYbxJXhp8kdWN6YoLlUfwYj5FPflaDJmEk60QVcsXgwkDvIkQ=
X-Received: by 2002:a17:907:8688:b0:a7a:8586:d36b with SMTP id
 a640c23a62f3a-a86e397e675mr12255966b.3.1724693245245; Mon, 26 Aug 2024
 10:27:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240826092707.2661435-1-edumazet@google.com> <CADVnQy=Z697P_gtkXMgPiASS6YwJ4PLDkqei3NvGJ5csKE8nhw@mail.gmail.com>
In-Reply-To: <CADVnQy=Z697P_gtkXMgPiASS6YwJ4PLDkqei3NvGJ5csKE8nhw@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 26 Aug 2024 19:27:10 +0200
Message-ID: <CANn89iJwVq5OyH9PpWjk4vWGuLOZi=rfEf7HMcoGZ3Uf4nW-Rg@mail.gmail.com>
Subject: Re: [PATCH net] tcp_cubic: switch ca->last_time to usec resolution
To: Neal Cardwell <ncardwell@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Mingrui Zhang <mrzhang97@gmail.com>, Lisong Xu <xu@unl.edu>, Yuchung Cheng <ycheng@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 26, 2024 at 3:26=E2=80=AFPM Neal Cardwell <ncardwell@google.com=
> wrote:
>
> On Mon, Aug 26, 2024 at 5:27=E2=80=AFAM Eric Dumazet <edumazet@google.com=
> wrote:
> >
> > bictcp_update() uses ca->last_time as a timestamp
> > to decide of several heuristics.
> >
> > Historically this timestamp has been fed with jiffies,
> > which has too coarse resolution, some distros are
> > still using CONFIG_HZ_250=3Dy
> >
> > It is time to switch to usec resolution, now TCP stack
> > already caches in tp->tcp_mstamp the high resolution time.
> >
> > Also remove the 'inline' qualifier, this helper is used
> > once and compilers are smarts.
> >
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > Link: https://lore.kernel.org/netdev/20240817163400.2616134-1-mrzhang97=
@gmail.com/T/#mb6a64c9e2309eb98eaeeeb4b085c4a2270b6789d
> > Cc: Mingrui Zhang <mrzhang97@gmail.com>
> > Cc: Lisong Xu <xu@unl.edu>
> > ---
> >  net/ipv4/tcp_cubic.c | 18 ++++++++++--------
> >  1 file changed, 10 insertions(+), 8 deletions(-)
> >
> > diff --git a/net/ipv4/tcp_cubic.c b/net/ipv4/tcp_cubic.c
> > index 5dbed91c6178257df8d2ccd1c8690a10bdbaf56a..3b1845103ee1866a316926a=
130c212e6f5e78ef0 100644
> > --- a/net/ipv4/tcp_cubic.c
> > +++ b/net/ipv4/tcp_cubic.c
> > @@ -87,7 +87,7 @@ struct bictcp {
> >         u32     cnt;            /* increase cwnd by 1 after ACKs */
> >         u32     last_max_cwnd;  /* last maximum snd_cwnd */
> >         u32     last_cwnd;      /* the last snd_cwnd */
> > -       u32     last_time;      /* time when updated last_cwnd */
> > +       u32     last_time;      /* time when updated last_cwnd (usec) *=
/
> >         u32     bic_origin_point;/* origin point of bic function */
> >         u32     bic_K;          /* time to origin point
> >                                    from the beginning of the current ep=
och */
> > @@ -211,26 +211,28 @@ static u32 cubic_root(u64 a)
> >  /*
> >   * Compute congestion window to use.
> >   */
> > -static inline void bictcp_update(struct bictcp *ca, u32 cwnd, u32 acke=
d)
> > +static void bictcp_update(struct sock *sk, u32 cwnd, u32 acked)
> >  {
> > +       const struct tcp_sock *tp =3D tcp_sk(sk);
> > +       struct bictcp *ca =3D inet_csk_ca(sk);
> >         u32 delta, bic_target, max_cnt;
> >         u64 offs, t;
> >
> >         ca->ack_cnt +=3D acked;   /* count the number of ACKed packets =
*/
> >
> > -       if (ca->last_cwnd =3D=3D cwnd &&
> > -           (s32)(tcp_jiffies32 - ca->last_time) <=3D HZ / 32)
> > +       delta =3D tp->tcp_mstamp - ca->last_time;
> > +       if (ca->last_cwnd =3D=3D cwnd && delta <=3D USEC_PER_SEC / 32)
> >                 return;
> >
> > -       /* The CUBIC function can update ca->cnt at most once per jiffy=
.
> > +       /* The CUBIC function can update ca->cnt at most once per ms.
> >          * On all cwnd reduction events, ca->epoch_start is set to 0,
> >          * which will force a recalculation of ca->cnt.
> >          */
> > -       if (ca->epoch_start && tcp_jiffies32 =3D=3D ca->last_time)
> > +       if (ca->epoch_start && delta < USEC_PER_MSEC)
> >                 goto tcp_friendliness;
>
> AFAICT there is a problem here. It is switching this line of code to
> use microsecond resolution without also changing the core CUBIC slope
> (ca->cnt) calculation to also use microseconds.  AFAICT that means we
> would be re-introducing the bug that was fixed in 2015 in
> d6b1a8a92a1417f8859a6937d2e6ffe2dfab4e6d (see below). Basically, if
> the CUBIC slope (ca->cnt) calculation uses jiffies, then we should
> only run that code once per jiffy, to avoid getting the wrong answer
> for the slope:

Interesting.... would adding the following part deal with this
problem, or is it something else ?

diff --git a/net/ipv4/tcp_cubic.c b/net/ipv4/tcp_cubic.c
index 3b1845103ee1866a316926a130c212e6f5e78ef0..bff5688ba5109fa5a0bbff7dc52=
9525b2752dc46
100644
--- a/net/ipv4/tcp_cubic.c
+++ b/net/ipv4/tcp_cubic.c
@@ -268,9 +268,10 @@ static void bictcp_update(struct sock *sk, u32
cwnd, u32 acked)

        t =3D (s32)(tcp_jiffies32 - ca->epoch_start);
        t +=3D usecs_to_jiffies(ca->delay_min);
-       /* change the unit from HZ to bictcp_HZ */
+       t =3D jiffies_to_msecs(t);
+       /* change the unit from ms to bictcp_HZ */
        t <<=3D BICTCP_HZ;
-       do_div(t, HZ);
+       do_div(t, MSEC_PER_SEC);

        if (t < ca->bic_K)              /* t - K */
                offs =3D ca->bic_K - t;


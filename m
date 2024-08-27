Return-Path: <netdev+bounces-122371-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7477D960DAF
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 16:34:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CEA3283BD3
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 14:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCB471BDABE;
	Tue, 27 Aug 2024 14:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="miJfzLxn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222271BCA00
	for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 14:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724769265; cv=none; b=kUsuVkaKYMkt54RFG7BZL7Fnd6s0qwVlKkY0gVssSzO1b1MlwAJ44zNYPGydF8FJ2uaH4Zwky0E9kuUBg13h4oclcs1ErooUuDmKkNCwWgqX8FO2GDn4tbu0pVDRn/ik72JT4EfE7nn0xemKXoikyL6YByXdVXH1geHIfRrA/dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724769265; c=relaxed/simple;
	bh=+6HsnbADGEL6r8YXUk/7il0030G3DSEfxtNgmBgHuNM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jzR1SCAg1SARzJg7KcTnB3u+tmKU3M31CKtLpidTmYTfo6tbyN+XRT+Xb/pIipHAZKz4ndPgMsu56HCupOXuMT/ya45jjSaw0g/w8/gOpj3ecnF/e5UZHf/wGpqh9IXQ8oFI3RaUXHXqAPSQLxF9uGyrbv/0/zLSF2308dOhw4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=miJfzLxn; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e13c23dbabdso5343635276.3
        for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 07:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724769263; x=1725374063; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+6B77qdosHfG1XHACtUmLxp0f+e+BDw5RcesMVDieus=;
        b=miJfzLxnlKdKVyuVDGjluC5aEti5XCe8F2dV1ZrcCoeAcDzwtBQXjFdIk1QegW3yut
         ZEKkKY9nuyJ1x9/Kmaz017OMjGt/lMYpOFpGXRv4FBPiJr1vSdjdrzi8NhFxrBtwTZBg
         TNLPJCYOXq7YTw0OrfluzBnhWAYfzDqThmfkti+wJBpVifgj3rZjmz03Pb5con03v+8e
         mGypV0myNHwDSQ7283Upmqeh50hg1906PNzX/RjaIAWW6QeyHvp+GG9NMqVOOlrThuXF
         s3seRXd75yrzVVAUUkZxuWeR9QqpSr+TFbnNsnj7vM+HobnXV/rZS6ulSZ7MoYgWLWh6
         3TTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724769263; x=1725374063;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+6B77qdosHfG1XHACtUmLxp0f+e+BDw5RcesMVDieus=;
        b=wbOtoAZEvyimLcYnrRQfqPmjklvHABi3ThjFDhYZwZacwqxhVSjXp3fJByucq5zSSL
         ZKX6YQtVoxlMcFT/sktUoOM6ETfvIL+CV+XXSC/iqVjNVfsP6bEs1D8Atle2WQSjE2Cs
         LL424ka3olvsWnyn3xEQg85oMURLjHnK03CNVh7RPFBcyUc7hgqHnLZS7sOFLGnAIwTK
         Iebk+myikWkTiqUZrev9ocqFft/VAEx/Fh6YuuY5xW8jBtCU7Ipt+C5qQjFjUSRRq4G2
         fSIagstT43c/21PDhZZod31/RfFwHAERbDx1jARXMHO877MR8fs24PFUiQMEJseKbL8r
         tQLQ==
X-Forwarded-Encrypted: i=1; AJvYcCX70dGiCF3uUp5iQ8zy9E6BhNkCphCur4ZT6pymF5yTe4/eM5vMQ2spnGPhVRaTXj3AMCoHgvs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRYv+di+eHL+gRG6LR62X7+yT5zyXY6df/el2r5EUhnX9XhGMw
	ZnhpI4tOA7+mOvrp13yZsyROJm62VnUCOUtVbi9Zq4LbAsuq3ppj3nQYSnyczBcZ6PZRX07FQC1
	hDrxtucnDVo1Wb2+I/2IcMbPXag==
X-Google-Smtp-Source: AGHT+IFi9Xxw6l84PXgyUIegNE4JraZ3kRqNSXEpO2Qque9ilUC5jebVX8BiIZL6bmTa55X6fAkD/4G3mdiqzLYSiHo=
X-Received: by 2002:a05:690c:dc8:b0:6af:fc23:178e with SMTP id
 00721157ae682-6c624fb5b0bmr160075307b3.1.1724769262998; Tue, 27 Aug 2024
 07:34:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABdStnNL4ipEfT4xiJXH=4bmyOdRdD4n2AzF31TreDKMyOnhHA@mail.gmail.com>
 <CANn89i+_yApeWTXjUF2eghWTOKmbMfQoQ4AOmm57Yv4grJbvuA@mail.gmail.com>
In-Reply-To: <CANn89i+_yApeWTXjUF2eghWTOKmbMfQoQ4AOmm57Yv4grJbvuA@mail.gmail.com>
From: Lisong Xu <lisongxu@gmail.com>
Date: Tue, 27 Aug 2024 09:34:12 -0500
Message-ID: <CABdStnN1SYyuEb56CFEckWeY7gYg8Dag3bcD8Ez1NKFCyn1U+Q@mail.gmail.com>
Subject: Re: [PATCH net] tcp_cubic: switch ca->last_time to usec resolution
To: Eric Dumazet <edumazet@google.com>
Cc: Neal Cardwell <ncardwell@google.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "eric.dumazet@gmail.com" <eric.dumazet@gmail.com>, 
	Mingrui Zhang <mrzhang97@gmail.com>, Yuchung Cheng <ycheng@google.com>, Lisong Xu <xu@unl.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 27, 2024 at 9:19=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
>
>
> On Tue, Aug 27, 2024 at 4:14=E2=80=AFPM Lisong Xu <lisongxu@gmail.com> wr=
ote:
>>
>> > ________________________________________
>> > From: Eric Dumazet <edumazet@google.com>
>> > Sent: Monday, August 26, 2024 12:27 PM
>> > To: Neal Cardwell
>> > Cc: David S . Miller; Jakub Kicinski; Paolo Abeni; netdev@vger.kernel.=
org; eric.dumazet@gmail.com; Mingrui Zhang; Lisong Xu; Yuchung Cheng
>> > Subject: Re: [PATCH net] tcp_cubic: switch ca->last_time to usec resol=
ution
>> >
>> > Caution: Non-NU Email
>> >
>> >
>> > On Mon, Aug 26, 2024 at 3:26=E2=80=AFPM Neal Cardwell <ncardwell@googl=
e.com> wrote:
>> > >
>> > > On Mon, Aug 26, 2024 at 5:27=E2=80=AFAM Eric Dumazet <edumazet@googl=
e.com> wrote:
>> > > >
>> > > > bictcp_update() uses ca->last_time as a timestamp
>> > > > to decide of several heuristics.
>> > > >
>> > > > Historically this timestamp has been fed with jiffies,
>> > > > which has too coarse resolution, some distros are
>> > > > still using CONFIG_HZ_250=3Dy
>> > > >
>> > > > It is time to switch to usec resolution, now TCP stack
>> > > > already caches in tp->tcp_mstamp the high resolution time.
>> > > >
>> > > > Also remove the 'inline' qualifier, this helper is used
>> > > > once and compilers are smarts.
>> > > >
>> > > > Signed-off-by: Eric Dumazet <edumazet@google.com>
>> > > > Link: https://urldefense.com/v3/__https://lore.kernel.org/netdev/2=
0240817163400.2616134-1-mrzhang97@gmail.com/T/*mb6a64c9e2309eb98eaeeeb4b085=
c4a2270b6789d__;Iw!!PvXuogZ4sRB2p-tU!CFiPa78hSiQJz2pJVSL2IbKk_L0o9RGTCO29ee=
o32aJX9_1V_QyTFP9gxuafoE_Ye7DtfD-LhjMf$
>> > > > Cc: Mingrui Zhang <mrzhang97@gmail.com>
>> > > > Cc: Lisong Xu <xu@unl.edu>
>> > > > ---
>> > > >  net/ipv4/tcp_cubic.c | 18 ++++++++++--------
>> > > >  1 file changed, 10 insertions(+), 8 deletions(-)
>> > > >
>> > > > diff --git a/net/ipv4/tcp_cubic.c b/net/ipv4/tcp_cubic.c
>> > > > index 5dbed91c6178257df8d2ccd1c8690a10bdbaf56a..3b1845103ee1866a31=
6926a130c212e6f5e78ef0 100644
>> > > > --- a/net/ipv4/tcp_cubic.c
>> > > > +++ b/net/ipv4/tcp_cubic.c
>> > > > @@ -87,7 +87,7 @@ struct bictcp {
>> > > >         u32     cnt;            /* increase cwnd by 1 after ACKs *=
/
>> > > >         u32     last_max_cwnd;  /* last maximum snd_cwnd */
>> > > >         u32     last_cwnd;      /* the last snd_cwnd */
>> > > > -       u32     last_time;      /* time when updated last_cwnd */
>> > > > +       u32     last_time;      /* time when updated last_cwnd (us=
ec) */
>> > > >         u32     bic_origin_point;/* origin point of bic function *=
/
>> > > >         u32     bic_K;          /* time to origin point
>> > > >                                    from the beginning of the curre=
nt epoch */
>> > > > @@ -211,26 +211,28 @@ static u32 cubic_root(u64 a)
>> > > >  /*
>> > > >   * Compute congestion window to use.
>> > > >   */
>> > > > -static inline void bictcp_update(struct bictcp *ca, u32 cwnd, u32=
 acked)
>> > > > +static void bictcp_update(struct sock *sk, u32 cwnd, u32 acked)
>> > > >  {
>> > > > +       const struct tcp_sock *tp =3D tcp_sk(sk);
>> > > > +       struct bictcp *ca =3D inet_csk_ca(sk);
>> > > >         u32 delta, bic_target, max_cnt;
>> > > >         u64 offs, t;
>> > > >
>> > > >         ca->ack_cnt +=3D acked;   /* count the number of ACKed pac=
kets */
>> > > >
>> > > > -       if (ca->last_cwnd =3D=3D cwnd &&
>> > > > -           (s32)(tcp_jiffies32 - ca->last_time) <=3D HZ / 32)
>> > > > +       delta =3D tp->tcp_mstamp - ca->last_time;
>> > > > +       if (ca->last_cwnd =3D=3D cwnd && delta <=3D USEC_PER_SEC /=
 32)
>> > > >                 return;
>> > > >
>> > > > -       /* The CUBIC function can update ca->cnt at most once per =
jiffy.
>> > > > +       /* The CUBIC function can update ca->cnt at most once per =
ms.
>> > > >          * On all cwnd reduction events, ca->epoch_start is set to=
 0,
>> > > >          * which will force a recalculation of ca->cnt.
>> > > >          */
>> > > > -       if (ca->epoch_start && tcp_jiffies32 =3D=3D ca->last_time)
>> > > > +       if (ca->epoch_start && delta < USEC_PER_MSEC)
>> > > >                 goto tcp_friendliness;
>> > >
>> > > AFAICT there is a problem here. It is switching this line of code to
>> > > use microsecond resolution without also changing the core CUBIC slop=
e
>> > > (ca->cnt) calculation to also use microseconds.  AFAICT that means w=
e
>> > > would be re-introducing the bug that was fixed in 2015 in
>> > > d6b1a8a92a1417f8859a6937d2e6ffe2dfab4e6d (see below). Basically, if
>> > > the CUBIC slope (ca->cnt) calculation uses jiffies, then we should
>> > > only run that code once per jiffy, to avoid getting the wrong answer
>> > > for the slope:
>> >
>> > Interesting.... would adding the following part deal with this
>> > problem, or is it something else ?
>> >
>> > diff --git a/net/ipv4/tcp_cubic.c b/net/ipv4/tcp_cubic.c
>> > index 3b1845103ee1866a316926a130c212e6f5e78ef0..bff5688ba5109fa5a0bbff=
7dc529525b2752dc46
>> > 100644
>> > --- a/net/ipv4/tcp_cubic.c
>> > +++ b/net/ipv4/tcp_cubic.c
>> > @@ -268,9 +268,10 @@ static void bictcp_update(struct sock *sk, u32
>> > cwnd, u32 acked)
>> >
>> >         t =3D (s32)(tcp_jiffies32 - ca->epoch_start);
>> >         t +=3D usecs_to_jiffies(ca->delay_min);
>> > -       /* change the unit from HZ to bictcp_HZ */
>> > +       t =3D jiffies_to_msecs(t);
>> > +       /* change the unit from ms to bictcp_HZ */
>> >         t <<=3D BICTCP_HZ;
>> > -       do_div(t, HZ);
>> > +       do_div(t, MSEC_PER_SEC);
>> >
>> >         if (t < ca->bic_K)              /* t - K */
>> >                 offs =3D ca->bic_K - t;
>>
>>
>> How about something like the following? basically, we change
>> ca->epoch_start also to usec.
>>
>> ca->epoch_start =3D tp->tcp_mstamp;
>>
>> ...
>>
>> t =3D (s32)(tp->tcp_mstamp - ca->epoch_start);
>> t +=3D ca->delay_min;
>> /* first change the unit from usec to msec to avoid overflow*/
>> do_div(t, USEC_PER_MSEC);
>> /* then change the unit from msec to bictcp_HZ */
>> t <<=3D BICTCP_HZ;
>> do_div(t, MSEC_PER_SEC);
>
>
> Changing ca->epoch_start would require  more changes, say in cubictcp_cwn=
d_event().
>
> This probably should be done in a separate patch.
>
>

Yes, it requires more changes, as ca->epoch_start is used also in
several other methods.


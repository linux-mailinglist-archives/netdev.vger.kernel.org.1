Return-Path: <netdev+bounces-123372-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EEF7964A24
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 17:34:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEC1F1C2433B
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 15:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD9241B29B0;
	Thu, 29 Aug 2024 15:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L4Ne1cdC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1FA1B1505
	for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 15:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724945686; cv=none; b=WQuikJK2hkvus5iBe0KGSVa5L/vNAImu05VckTat35P6o4NIjW0C5pvbjKvyKk0nrvD3Gv7cd+vSF8gU35Awu33atiuKbX6GG7gtgttYbxqSayPPc0kV4z9r0XQVeg7hOOVZeVChuSma67lfUKl9XUjXA7+0FRG5O22Y2+x2Nok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724945686; c=relaxed/simple;
	bh=NsFyDI+PKnB5RgzOGY6tJn9LloDsFOGJpgO8yUEIJvY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fV9BWd063sdajXmproro+sZ0xkmuEN8HZd+v7c/rvR5qNyIxPxtt2AQ4i/nttETn8uVwXEsbPwoI5Cd5VfgPmm0e+vW2U/Q/ijdRZggutisdzFmQgWGlfzGv7il+YewLo/1XHFtZkl4tF9qFPz6ZxIKyjepkAMTE0P43ONDwK6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L4Ne1cdC; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a8682bb5e79so105980966b.2
        for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 08:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724945683; x=1725550483; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DkIeMUqxoStnXRZ+piOkJF5oSuKoFGVKmsBvNWzncXY=;
        b=L4Ne1cdC4PZ+BRJd71kSl8t088LvVHBHNeg3EfLpaPQYPzcW5sKzM4w672F0Hshha3
         7PWk98vvZiew1k0yct9Kt/foXa9N4EZeSRHzriJeZbvFbMp6aUy6TjRPqtweA+KeA21D
         P+DJWuK+tBX4iHnm4MUbZ4vmdkYF8thJlbM8RM3XowkGvPU2fRTlBG7QYy/gPQuKJMbZ
         6Jwk/za1wmTPRZ2+cipmQqymUhx4da9ARREwpZyZJPSDDx2KJKCecFuVKQ5uA4WB8HHn
         r74wji0CePg8pjGnLq0JlOYLZpMsDucZeFfSu5xj4w1AyDYP+4OlCrk62HbGFXRHotn3
         PB4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724945683; x=1725550483;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DkIeMUqxoStnXRZ+piOkJF5oSuKoFGVKmsBvNWzncXY=;
        b=ixkrqqWJDl6GDjhy1Xmqtx0N8RXAwlrhf1v8/ZsRSdwkSpTT6SynwZFe+3HikPNQpF
         ydUM0+jQ5V4eC9VOE1yIxWgeYNacjd6pKZWvKgdDPvWu+iWMfb2IRaIT1sZX9dkY361e
         4081eqM4ncOFmE4UYIdLat04TAy9NBcwxrUOrZubAzCtsJ6GTYcYPsH7UpJ0Catp4CLi
         vugSYI5ccYgTPU3aBoLB/AeCV5d9/SBPwGE3ibu5E4bX5dfE4YJBDVgUoWeoDTP7XyL2
         kJkEkddHHWg+XiRieB8R63Ler23zLIR6wFltDPfoRDuZrCR4Fke+sNffkzom23JB6WRk
         YaBA==
X-Forwarded-Encrypted: i=1; AJvYcCX4kk25f1Qb1W8dUVO0hLZTnp0GMwQsJGdV110OOHrudPArJLb+2G/2vutw/J4RzDiy/r3owdw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxypacOQ02X3l/W9D+UVA9oasPruTp4bdNLwIYHIyrVdZ8EXz7
	Ft0Nisxq54zZv9/DiXQzGY4z/TFRqLYrL/0gPBQw+FQ+mxNYEEihoY3RdiyK5qo8mBRBhhWYx/3
	BheEVeKhOAO+0XI/CDqNA7PT7qnQ=
X-Google-Smtp-Source: AGHT+IFQlep9DRGJ6MKtm4FM0htHYfe0Zvmx3ysI5qsSOhk/LuAgzmIqvAzMdjGSQWoUEBNShfQN2xNwz0pXm5+QZL4=
X-Received: by 2002:a17:906:dac7:b0:a77:cf09:9c70 with SMTP id
 a640c23a62f3a-a897fa6370dmr271771366b.43.1724945682868; Thu, 29 Aug 2024
 08:34:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240828160145.68805-1-kerneljasonxing@gmail.com>
 <20240828160145.68805-2-kerneljasonxing@gmail.com> <66d082a58cc98_3895fa294fe@willemb.c.googlers.com.notmuch>
In-Reply-To: <66d082a58cc98_3895fa294fe@willemb.c.googlers.com.notmuch>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 29 Aug 2024 23:34:04 +0800
Message-ID: <CAL+tcoAr4viE-1HfQN8EpmikeSFUefr9NKiXFx3ysoGRNUn=SQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2 1/2] tcp: make SOF_TIMESTAMPING_RX_SOFTWARE
 feature per socket
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, willemb@google.com, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 10:16=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Jason Xing wrote:
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > Normally, if we want to record and print the rx timestamp after
> > tcp_recvmsg_locked(), we must enable both SOF_TIMESTAMPING_SOFTWARE
> > and SOF_TIMESTAMPING_RX_SOFTWARE flags, from which we also can notice
> > through running rxtimestamp binary in selftests (see testcase 7).
> >
> > However, there is one particular case that fails the selftests with
> > "./rxtimestamp: Expected swtstamp to not be set." error printing in
> > testcase 6.
> >
> > How does it happen? When we keep running a thread starting a socket
> > and set SOF_TIMESTAMPING_RX_SOFTWARE option first, then running
> > ./rxtimestamp, it will fail. The reason is the former thread
> > switching on netstamp_needed_key that makes the feature global,
> > every skb going through netif_receive_skb_list_internal() function
> > will get a current timestamp in net_timestamp_check(). So the skb
> > will have timestamp regardless of whether its socket option has
> > SOF_TIMESTAMPING_RX_SOFTWARE or not.
> >
> > After this patch, we can pass the selftest and control each socket
> > as we want when using rx timestamp feature.
> >
> > Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > ---
> >  net/ipv4/tcp.c | 11 +++++++++--
> >  1 file changed, 9 insertions(+), 2 deletions(-)
> >
> > diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> > index 8514257f4ecd..5e88c765b9a1 100644
> > --- a/net/ipv4/tcp.c
> > +++ b/net/ipv4/tcp.c
> > @@ -2235,6 +2235,7 @@ void tcp_recv_timestamp(struct msghdr *msg, const=
 struct sock *sk,
> >                       struct scm_timestamping_internal *tss)
> >  {
> >       int new_tstamp =3D sock_flag(sk, SOCK_TSTAMP_NEW);
> > +     u32 tsflags =3D READ_ONCE(sk->sk_tsflags);
> >       bool has_timestamping =3D false;
> >
> >       if (tss->ts[0].tv_sec || tss->ts[0].tv_nsec) {
> > @@ -2274,14 +2275,20 @@ void tcp_recv_timestamp(struct msghdr *msg, con=
st struct sock *sk,
> >                       }
> >               }
> >
> > -             if (READ_ONCE(sk->sk_tsflags) & SOF_TIMESTAMPING_SOFTWARE=
)
> > +             /* We have to use the generation flag here to test if we
> > +              * allow the corresponding application to receive the rx
> > +              * timestamp. Only using report flag does not hold for
> > +              * receive timestamping case.
> > +              */
>
> Nit: what does "does not hold" mean here? I don't think a casual reader
> will be able to parse this comment and understand it.

=E2=80=9Chold for=E2=80=9D can be a fixed collocation, which means "be suit=
able for"?
I'm not that sure. I was trying to say "only using the report flag
cannot meet our needs" something like this.

>
> Perhaps something along the lines of
>
> "Test both reporting and generation flag, to filter out false
> positives where the process asked only for tx software timestamps and
> another process enabled receive software timestamp generation."

Thanks, it's much better than mine. I will use it.

Thanks,
Jason

>
> > +             if (tsflags & SOF_TIMESTAMPING_SOFTWARE &&
> > +                 tsflags & SOF_TIMESTAMPING_RX_SOFTWARE)
> >                       has_timestamping =3D true;
> >               else
> >                       tss->ts[0] =3D (struct timespec64) {0};
> >       }
> >
> >       if (tss->ts[2].tv_sec || tss->ts[2].tv_nsec) {
> > -             if (READ_ONCE(sk->sk_tsflags) & SOF_TIMESTAMPING_RAW_HARD=
WARE)
> > +             if (tsflags & SOF_TIMESTAMPING_RAW_HARDWARE)
> >                       has_timestamping =3D true;
> >               else
> >                       tss->ts[2] =3D (struct timespec64) {0};
> > --
> > 2.37.3
> >
>
>


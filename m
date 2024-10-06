Return-Path: <netdev+bounces-132540-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E39E7992112
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 22:15:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61EC1B21360
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 20:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC2FB2557A;
	Sun,  6 Oct 2024 20:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e1SxLiAO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E84C18B487
	for <netdev@vger.kernel.org>; Sun,  6 Oct 2024 20:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728245709; cv=none; b=PGLlDiuMPZioJxyZnVxjIQ130PTaAnMs++HHgsxPJCfXvdm/YiI15pzXpLXsbCAXRdcIsdqB2YDH6iKuuY1lyFLHlx+5v4J2vuvbR8BfiHyWorngyup0rJ69WDfixTTbmXIWuUsc2g+pitg0faGojd5Xc7cahkvOTvkkkTOjA3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728245709; c=relaxed/simple;
	bh=8LR6C89rn25ET7wynHuGqWPBvAdLgEGtH4sQCs1fGO0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l4NfLvzn6stqVstOOxGlMSOZDcmgIDOzDQZqWp3yr8TrwAkuXhDrFPBhZXDice/CSx4iPlfQsmrFMNvyASLliE546+xLvjhAqROOtjlGuqQ68uGhNDF0Qrmcm2PAj7l58uuP1VtlV2Zg+GQNGYX2bFXe5g0d4mK7xvFt/gH7kqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e1SxLiAO; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5c721803a89so5013291a12.1
        for <netdev@vger.kernel.org>; Sun, 06 Oct 2024 13:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728245706; x=1728850506; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CWzf1FUPHiGf2xnaK2XvpTPlfDWzPgSTpNM0hb8mdRo=;
        b=e1SxLiAO3C1GPeZy2qwpRXUjbB99S6hGyOZNuJgCYucD/nkp08n/9nRGUKoTQeYc7j
         Lk48hkH3vN2N0UfJgziPcSbosjZnqFHFGaxw/pQ8+I0TW/tMkcoQBABCWLpvC6Z9RK6R
         wU/6FZECv+zjsXuB8uLYKk6j6eO40w2xVkWEYVOEhZq4xC6zMNaIsi6jn+xLj4g6fRoR
         uCyfDbdwAz7uadsEamsQOJ37qY6WhPRuGzJqkeYSzYmHfd4PfewZ860z85BHOkFjiS2F
         eV9Wgv+Xqz+z68jVN0ybJfErfuSLLXfzypd/FooTnQp8RwQYoRDSH0d0fAK/I3Jt0z+D
         qOoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728245706; x=1728850506;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CWzf1FUPHiGf2xnaK2XvpTPlfDWzPgSTpNM0hb8mdRo=;
        b=B8/1qCS97KG0I4uV4Zi+9KLf9Dv6aRsuQlOze4/MPDTThXV0cTJbS1gC/dgmZAC8Nq
         7yy4Ob53Z2Gxn7sR4vaBsyBKta0Uel64ASpkKkuSURp4oChU+P/9B2M7OhruyaYJsok2
         ZaG9lCRlnKYQ6ybKvxI1NG16adkYk+QUqeJnM404KDRMfn58lgsrh3Xkf0/GlG//zD6+
         4cZSxyWN8ND7z2uEkZPPZ/iok6d+rFIVwAdXVjQObeGS/UMF6w3/Nm7+gPO6zdUVdYYh
         9NrkZv9kbmN118k7j0cBIrjBnBgyZMyAhl+Byj1BYYADbyzu70F1OgTlc6dk7MbNQq/K
         xhFw==
X-Forwarded-Encrypted: i=1; AJvYcCVrK06JCRe+KC3hC0CAB4qQvkfiVSjUOGFTpT52OY77Xqt/aw9N49T/wxfJtrDA39aJe7Qvv3A=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywjb67qTbsfEdPUahoBxSz+bgw9lrohxh4UMiR5zxtapFDIpoTy
	5YhET3tbf4Ukhn0JIgvtuiPQIzn7Sze0aZcfc1dMShGKW5Z7kAAtSZZQ5VWSgcMIg3+i9sDM1qT
	DrfCMqfOYYdYjY4nerqdvZS7hyMvoDxWLwyJpKd0ohSwXj8oMzg==
X-Google-Smtp-Source: AGHT+IHZJzuDxjcAyA7syKtQswkTBlWUkxsXjBimHrVIc62a/1zwnK+E6GTuPa6K9BcClEyuO0WUUOpi4LNAp0rfygA=
X-Received: by 2002:a17:907:98c:b0:a89:f5f6:395 with SMTP id
 a640c23a62f3a-a991bce6187mr1224652866b.1.1728245706114; Sun, 06 Oct 2024
 13:15:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241004191644.1687638-1-edumazet@google.com> <20241004191644.1687638-2-edumazet@google.com>
 <CANn89i+PxDFAkc_O9VdP3KgdBsRtpgaTCuYnH11ccLZAzpKMpA@mail.gmail.com> <604aa161-9648-41bd-9ede-940e51f7248c@linux.dev>
In-Reply-To: <604aa161-9648-41bd-9ede-940e51f7248c@linux.dev>
From: Eric Dumazet <edumazet@google.com>
Date: Sun, 6 Oct 2024 22:14:52 +0200
Message-ID: <CANn89iKSchhx-NTbhZYyi5zp4HX=JsYbecK+bh6UbQ_FKjn1qQ@mail.gmail.com>
Subject: Re: [PATCH net-next 1/5] net: add TIME_WAIT logic to sk_to_full_sk()
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, eric.dumazet@gmail.com, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 5, 2024 at 2:37=E2=80=AFAM Martin KaFai Lau <martin.lau@linux.d=
ev> wrote:
>
> On 10/4/24 2:56 PM, Eric Dumazet wrote:
> > On Fri, Oct 4, 2024 at 9:16=E2=80=AFPM Eric Dumazet <edumazet@google.co=
m> wrote:
> >>
> >> TCP will soon attach TIME_WAIT sockets to some ACK and RST.
> >>
> >> Make sure sk_to_full_sk() detects this and does not return
> >> a non full socket.
> >>
> >> Signed-off-by: Eric Dumazet <edumazet@google.com>
> >> ---
> >>   include/net/inet_sock.h | 4 +++-
> >>   1 file changed, 3 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/include/net/inet_sock.h b/include/net/inet_sock.h
> >> index 394c3b66065e20d34594d6e2a2010c55bb457810..cec093b78151b9a3b95ad4=
b3672a72b0aa9a8305 100644
> >> --- a/include/net/inet_sock.h
> >> +++ b/include/net/inet_sock.h
> >> @@ -319,8 +319,10 @@ static inline unsigned long inet_cmsg_flags(const=
 struct inet_sock *inet)
> >>   static inline struct sock *sk_to_full_sk(struct sock *sk)
> >>   {
> >>   #ifdef CONFIG_INET
> >> -       if (sk && sk->sk_state =3D=3D TCP_NEW_SYN_RECV)
> >> +       if (sk && READ_ONCE(sk->sk_state) =3D=3D TCP_NEW_SYN_RECV)
> >>                  sk =3D inet_reqsk(sk)->rsk_listener;
> >> +       if (sk && READ_ONCE(sk->sk_state) =3D=3D TCP_TIME_WAIT)
> >> +               sk =3D NULL;
> >>   #endif
> >>          return sk;
> >>   }
> >
> > It appears some callers do not check if the return value could be NULL.
> > I will have to add in v2 :
> >
> > diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
> > index ce91d9b2acb9f8991150ceead4475b130bead438..c3ffb45489a6924c1bc8035=
5e862e243ec195b01
> > 100644
> > --- a/include/linux/bpf-cgroup.h
> > +++ b/include/linux/bpf-cgroup.h
> > @@ -209,7 +209,7 @@ static inline bool cgroup_bpf_sock_enabled(struct s=
ock *sk,
> >          int __ret =3D 0;                                              =
           \
> >          if (cgroup_bpf_enabled(CGROUP_INET_EGRESS) && sk) {           =
         \
>
> The above "&& sk" test can probably be removed after the "__sk &&" additi=
on below.

Yes, I can do that.

>
> >                  typeof(sk) __sk =3D sk_to_full_sk(sk);                =
           \
> > -               if (sk_fullsock(__sk) && __sk =3D=3D skb_to_full_sk(skb=
) &&        \
> > +               if (__sk && sk_fullsock(__sk) && __sk =3D=3D skb_to_ful=
l_sk(skb) &&        \
>
> sk_to_full_sk() includes the TCP_TIME_WAIT check now. I wonder if testing=
 __sk
> for NULL is good enough and the sk_fullsock(__sk) check can be removed al=
so.

+2

>
> Thanks for working on this series. It is useful for the bpf prog.

Thanks.


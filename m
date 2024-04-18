Return-Path: <netdev+bounces-89075-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3996F8A962B
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 11:28:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C4D31C21BF0
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 09:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1753A1591FF;
	Thu, 18 Apr 2024 09:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FnqElyiS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40FD61CA92
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 09:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713432411; cv=none; b=Fexl3wKK5AVHUtYrx+71ZwOkR73lzq5wX39km5AWU/AofHjh04/J4pCawfHN+IbIMqcpMYD3CVGPk5aGWFGdxwAMDuky4D8u9ngt/9rxrEzbHZSO2Yp/DbokASmL37kj94f8XO3tO3+dS8PG2woaPaqkfgwchjtKxlHC9Ia7PA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713432411; c=relaxed/simple;
	bh=ufO01s8DBV5PrLvABpJObWb0m5TA1em9YffNE0Pdz+k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TVzsxu6bkpGmBiM5jJEmvpN8iE8CXebU07paz7QaeZ+S63Iu/bV5e4NoqXIu7B3vIa6g5pLgMMq0RlkQQAkdkiPtqBiDSgqW1/GzPMoP7r/3wE/Epb/nu9Rx4fPeSjxPcj8Z20jLmoq7ER0OofP0t+Qazg5jP+uU3/jZFJpOjBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FnqElyiS; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-56fd95160e5so6327a12.0
        for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 02:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713432407; x=1714037207; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3EvmMOndT20VHkhN1VcowmlQaFEpgIUN+jm+A4Yrmq0=;
        b=FnqElyiS8c2wEU82j05wELwJrJrQ9wJIt3TC0pzctG1x/uyOsI8clZWGieQ+lX9XBa
         M8ziYQ+8ql2cQJdhBjIdu45Vdb1AYMmyvCw2t4bIpTEurUwd7PHcIqZSgtoGOvyFPXhX
         v3OLJEAXa+kdyEVJdWERS8wy+wfEXbcWswb5KaYnmgrsC+KDp0i2UFI32tn1IWQ1lBof
         sTNzjMaZfQBnsAQvoor8Fk4BDiP5WHnTEVKwy2Ite3PZity0WMC7HhiId0x0SUSrbug/
         FGHFyocSDp18IZJ2Y2tqUuMqJ16JzXyDmQDIsk27mA6ASEzVD7H2gQyXdWgEjKu6pNwN
         DA3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713432407; x=1714037207;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3EvmMOndT20VHkhN1VcowmlQaFEpgIUN+jm+A4Yrmq0=;
        b=Byat+07rrTD0fpcpuO+O+5TgrLQNQUBkZOxOlyoslZdNIOxL9vRWECTq7JAietqQQ4
         mzJF+VM2RuQiyMQLu0b7cwx0ywKuYUag7oh8U2WC2yuQCigf1lJFDut5nQ8Y+SOnLf9F
         0R5pkB67DgTgt0n5jzawR1ZK5bMX9i3kAQTLuqVhCINDDvCfab0xHnulEO1ozIwD2suG
         dF395OHZKGLMzsliOLvYvVdNR6OfvFQzcts+dJtVZg+2Pr8FY+6oNj1xOn8hAwV55670
         ofu+hDDCs8ASnl8+fSA0mtdMXe/tDX0xo3p7teiuox+pmawDfnKnNsd402SBl15vkl2s
         Ep3A==
X-Forwarded-Encrypted: i=1; AJvYcCVqbH5mbnCZ9GZ7EatXJ/KFbNqD/4N1RxNbTiDCJHWiQXjtWvYjY21UEL/Iy/hartmjiVD8eSzj/x410wBUVAd+cSaHnHw3
X-Gm-Message-State: AOJu0YzkZDOfAPQLtZK5d0yulqa6bdfqs0NNnFKEPQxdvXnKVIk/11EJ
	7cD0tdGQCGaok2ORxK+JkM9A7F1Yn+taIBOVLz0Ri1DliWeuKJGtj7arWXp+U3sfUyc/QBN53bS
	nbnQX7TogGwOirGEN2OH1cTyJOjZ4Q7KZ/Z/V
X-Google-Smtp-Source: AGHT+IFpajaK3tALiS5PGJurmKspEK2kULhNTPj8PiuMteBL44Ec70RcMkMjiX/wrLCNygcFsJhW7p24ZLDu2weQ1pw=
X-Received: by 2002:a05:6402:1510:b0:571:bc8d:4b6e with SMTP id
 f16-20020a056402151000b00571bc8d4b6emr41277edw.3.1713432407252; Thu, 18 Apr
 2024 02:26:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240417165756.2531620-1-edumazet@google.com> <20240417165756.2531620-2-edumazet@google.com>
 <e332d0b8fa7b116003dfd8b47f021901e66b36b9.camel@redhat.com> <CANn89i+-cjHze1yiFZKr-cCGG7Fh4gb9NZnS1u4u_77bG2Mf6Q@mail.gmail.com>
In-Reply-To: <CANn89i+-cjHze1yiFZKr-cCGG7Fh4gb9NZnS1u4u_77bG2Mf6Q@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 18 Apr 2024 11:26:33 +0200
Message-ID: <CANn89iLSZFOYfZUSK57LLe8yw4wNt8vHt=aD79a1MbZBhfeRbw@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] tcp: conditionally call ip_icmp_error() from tcp_v4_err()
To: Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, 
	Neal Cardwell <ncardwell@google.com>, Dragos Tatulea <dtatulea@nvidia.com>, eric.dumazet@gmail.com, 
	=?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>, 
	Willem de Bruijn <willemb@google.com>, Shachar Kagan <skagan@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 18, 2024 at 10:03=E2=80=AFAM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> On Thu, Apr 18, 2024 at 10:02=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> =
wrote:
> >
> > Hi,
> >
> > On Wed, 2024-04-17 at 16:57 +0000, Eric Dumazet wrote:
> > > Blamed commit claimed in its changelog that the new functionality
> > > was guarded by IP_RECVERR/IPV6_RECVERR :
> > >
> > >     Note that applications need to set IP_RECVERR/IPV6_RECVERR option=
 to
> > >     enable this feature, and that the error message is only queued
> > >     while in SYN_SNT state.
> > >
> > > This was true only for IPv6, because ipv6_icmp_error() has
> > > the following check:
> > >
> > > if (!inet6_test_bit(RECVERR6, sk))
> > >     return;
> > >
> > > Other callers check IP_RECVERR by themselves, it is unclear
> > > if we could factorize these checks in ip_icmp_error()
> > >
> > > For stable backports, I chose to add the missing check in tcp_v4_err(=
)
> > >
> > > We think this missing check was the root cause for commit
> > > 0a8de364ff7a ("tcp: no longer abort SYN_SENT when receiving
> > > some ICMP") breakage, leading to a revert.
> > >
> > > Many thanks to Dragos Tatulea for conducting the investigations.
> > >
> > > As Jakub said :
> > >
> > >     The suspicion is that SSH sees the ICMP report on the socket erro=
r queue
> > >     and tries to connect() again, but due to the patch the socket isn=
't
> > >     disconnected, so it gets EALREADY, and throws its hands up...
> > >
> > >     The error bubbles up to Vagrant which also becomes unhappy.
> > >
> > >     Can we skip the call to ip_icmp_error() for non-fatal ICMP errors=
?
> > >
> > > Fixes: 45af29ca761c ("tcp: allow traceroute -Mtcp for unpriv users")
> > > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > > Tested-by: Dragos Tatulea <dtatulea@nvidia.com>
> > > Cc: Dragos Tatulea <dtatulea@nvidia.com>
> > > Cc: Maciej =C5=BBenczykowski <maze@google.com>
> > > Cc: Willem de Bruijn <willemb@google.com>
> > > Cc: Neal Cardwell <ncardwell@google.com>
> > > Cc: Shachar Kagan <skagan@nvidia.com>
> > > ---
> > >  net/ipv4/tcp_ipv4.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> > > index 88c83ac4212957f19efad0f967952d2502bdbc7f..a717db99972d977a64178=
d7ed1109325d64a6d51 100644
> > > --- a/net/ipv4/tcp_ipv4.c
> > > +++ b/net/ipv4/tcp_ipv4.c
> > > @@ -602,7 +602,8 @@ int tcp_v4_err(struct sk_buff *skb, u32 info)
> > >               if (fastopen && !fastopen->sk)
> > >                       break;
> > >
> > > -             ip_icmp_error(sk, skb, err, th->dest, info, (u8 *)th);
> > > +             if (inet_test_bit(RECVERR, sk))
> > > +                     ip_icmp_error(sk, skb, err, th->dest, info, (u8=
 *)th);
> > >
> > >               if (!sock_owned_by_user(sk)) {
> > >                       WRITE_ONCE(sk->sk_err, err);
> >
> > We have a fcnal-test.sh self-test failure:
> >
> > https://netdev.bots.linux.dev/contest.html?branch=3Dnet-next-2024-04-18=
--06-00&test=3Dfcnal-test-sh
> >
> > that I suspect are related to this patch (or the following one): the
> > test case creates a TCP connection on loopback and this is the only
> > patchseries touching the related code, included in the relevant patch
> > burst.
> >
> > Could you please have a look?
>
> Sure, thanks Paolo !

First patch is fine, I see no failure from fcnal-test.sh (as I would expect=
)

For the second one, I am not familiar enough with this very slow test
suite (all these "sleep 1" ... oh well)

I guess "failing tests" depended on TCP connect() to immediately abort
on one ICMP message,
depending on old kernel behavior.

I do not know how to launch a subset of the tests, and trace these.

"./fcnal-test.sh -t ipv4_tcp" alone takes more than 9 minutes [1] in a
VM running a non debug kernel :/

David, do you have an idea how to proceed ?

Thanks.

[1]
Tests passed: 134
Tests failed:   0

real 9m33.085s
user 0m40.159s
sys 0m30.098s


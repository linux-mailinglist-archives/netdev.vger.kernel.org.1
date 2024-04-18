Return-Path: <netdev+bounces-89098-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E3B98A9717
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 12:15:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03DCB283C0E
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 10:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1523915B578;
	Thu, 18 Apr 2024 10:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BIpJR79c"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F4415B13A
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 10:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713435332; cv=none; b=nVlTJ4sYxhNiro3K+/Cc9aUE2h8dQuu+yGKbm8F2vDImIolrmP6t7gW08PFj5uZnkdpqPtAGuHEY+e6LYyTp7X+Vz+jwXPDYZUg9RHWIW0JyrEQZy1mbt1lLt/Mne6+L52GyYZB3BuFEQ+Zt35jNYtaNGUo0cEztoYlri3328x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713435332; c=relaxed/simple;
	bh=Iy0u/HP/xDtifzBzYn91kGBeWKT4MQ2Rxs/xaicc134=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f0/gDg7DydY62ZHm9KLB1qcTpDVmNAWLEH7gUtQbmn9qV1k1qNFL2CMId07BvcW3qWTu5lnXNUJKC/nToKm+XSr+ywM80ItacL+LJQh28RHs8ULAeknUV41Kd3mLnbY4wefGkrXGPvFCd7oFME2dJcYBP6jScNN0heCo+w7K780=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BIpJR79c; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-41699bbfb91so51315e9.0
        for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 03:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713435328; x=1714040128; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fp1W1sDgUWLhMctKF7nSC8klptr3kpwZ0PkRdCTSjvI=;
        b=BIpJR79cFzxOJtBVLVx6VR33ybDwoRWSlye4p2uT1JV6y4kVxiVL28CV0OwUjShfMk
         pVW/toB1anCmuIbphHWOfRbqR0q37Couk/RU7V6MqXF6/L+GxDfEUlzxgAYaeAKhlxDX
         k8LAcjhVlIWjt7lFV44R7Ozw/5jGnBr0ACT3zvq238Kdx0rNBAsrkEaEe6f30zWlTHCP
         8EtMJYqe3dsm1Gzq3Frb3IaDX3hS6GdTpC7Coa9oUUqF9QZ+VCZjwJw70+zLICazeg63
         hN6FSNgDyv/em5Aj0sbLGgBKvkfh52CAV7WI5pfGRWy/J03FAUNNenk5rzYq5Q4Jhm2S
         x6XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713435328; x=1714040128;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fp1W1sDgUWLhMctKF7nSC8klptr3kpwZ0PkRdCTSjvI=;
        b=KRVPZcxx2q5DqqY++GTfm8EGB4WzDy9VHZRNMQ0U/JzW3S9CB1poM0Z/ZbAhDFsQ5P
         6bJncCfmPourggszykix14lbEvCWG7lJnGdRHyM+Vf3hjhuW43GfHauJYXmFVFaDWHyr
         HC27Zfq2gYTxlwHtr1YZrmb7ECyI7jjwsz5gAy/JLXpyuFmHekAqbsdxW4O/OlwPiPBt
         Y2DJoF7KjL+oMSjso64nlecfRJDz1jhXgVuaUGpMc0r14cF6o4bEKJDLRZzNXd4VMdk5
         WSMgARxU3Z9aXh1IDVCVpj3wLXgWaOkG0ebGk5kP7lRX91wP2b3YgSgK96siTyPG0H5t
         zs8w==
X-Forwarded-Encrypted: i=1; AJvYcCXWmjDd+F5CmcLiIqUTFoGSI+5DSXb2BDrMRKPJy8K+S7J+yJvvgyvnk/pH8anmcEwljAcc5lXG19uPvwqWX1z2ft41Pduh
X-Gm-Message-State: AOJu0YyAx+O2jfbXE9fywlbsnWKDqeiCdRLiUpLlLexXhTquFGomAiEl
	tAfzqQ+QojhoNShaWjQQEq2Xtv4oNgTsQsNyMgXurUHj9MF4RAVRs9c3aieLR3WGInP6Mr8ZfDW
	0aqdBIXxPQE/vOxY7r8LC2nB1oDIn6ssLp8FrUPt+9O+aLJWX2zBd
X-Google-Smtp-Source: AGHT+IHa5XaO+6tA0cDKATpd0EDpQcNFwtsjQ//Ln74hJkUBHot97KTpB8bsZDYmKBTILaP6D+UPpflp7jslMRa1IkQ=
X-Received: by 2002:a05:600c:3556:b0:418:5aaa:7db1 with SMTP id
 i22-20020a05600c355600b004185aaa7db1mr134988wmq.1.1713435328248; Thu, 18 Apr
 2024 03:15:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240417165756.2531620-1-edumazet@google.com> <20240417165756.2531620-2-edumazet@google.com>
 <e332d0b8fa7b116003dfd8b47f021901e66b36b9.camel@redhat.com>
 <CANn89i+-cjHze1yiFZKr-cCGG7Fh4gb9NZnS1u4u_77bG2Mf6Q@mail.gmail.com>
 <CANn89iLSZFOYfZUSK57LLe8yw4wNt8vHt=aD79a1MbZBhfeRbw@mail.gmail.com> <7d1aa7d5a134ad4f4bca215ec6a075190cea03f2.camel@redhat.com>
In-Reply-To: <7d1aa7d5a134ad4f4bca215ec6a075190cea03f2.camel@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 18 Apr 2024 12:15:17 +0200
Message-ID: <CANn89iJg7AcxMLbvwnghN85L6ASuoKsSSSHdgaQzBU48G1TRiw@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] tcp: conditionally call ip_icmp_error() from tcp_v4_err()
To: Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, 
	Neal Cardwell <ncardwell@google.com>, Dragos Tatulea <dtatulea@nvidia.com>, eric.dumazet@gmail.com, 
	=?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>, 
	Willem de Bruijn <willemb@google.com>, Shachar Kagan <skagan@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 18, 2024 at 11:58=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wr=
ote:
>
> On Thu, 2024-04-18 at 11:26 +0200, Eric Dumazet wrote:
> > On Thu, Apr 18, 2024 at 10:03=E2=80=AFAM Eric Dumazet <edumazet@google.=
com> wrote:
> > >
> > > On Thu, Apr 18, 2024 at 10:02=E2=80=AFAM Paolo Abeni <pabeni@redhat.c=
om> wrote:
> > > >
> > > > Hi,
> > > >
> > > > On Wed, 2024-04-17 at 16:57 +0000, Eric Dumazet wrote:
> > > > > Blamed commit claimed in its changelog that the new functionality
> > > > > was guarded by IP_RECVERR/IPV6_RECVERR :
> > > > >
> > > > >     Note that applications need to set IP_RECVERR/IPV6_RECVERR op=
tion to
> > > > >     enable this feature, and that the error message is only queue=
d
> > > > >     while in SYN_SNT state.
> > > > >
> > > > > This was true only for IPv6, because ipv6_icmp_error() has
> > > > > the following check:
> > > > >
> > > > > if (!inet6_test_bit(RECVERR6, sk))
> > > > >     return;
> > > > >
> > > > > Other callers check IP_RECVERR by themselves, it is unclear
> > > > > if we could factorize these checks in ip_icmp_error()
> > > > >
> > > > > For stable backports, I chose to add the missing check in tcp_v4_=
err()
> > > > >
> > > > > We think this missing check was the root cause for commit
> > > > > 0a8de364ff7a ("tcp: no longer abort SYN_SENT when receiving
> > > > > some ICMP") breakage, leading to a revert.
> > > > >
> > > > > Many thanks to Dragos Tatulea for conducting the investigations.
> > > > >
> > > > > As Jakub said :
> > > > >
> > > > >     The suspicion is that SSH sees the ICMP report on the socket =
error queue
> > > > >     and tries to connect() again, but due to the patch the socket=
 isn't
> > > > >     disconnected, so it gets EALREADY, and throws its hands up...
> > > > >
> > > > >     The error bubbles up to Vagrant which also becomes unhappy.
> > > > >
> > > > >     Can we skip the call to ip_icmp_error() for non-fatal ICMP er=
rors?
> > > > >
> > > > > Fixes: 45af29ca761c ("tcp: allow traceroute -Mtcp for unpriv user=
s")
> > > > > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > > > > Tested-by: Dragos Tatulea <dtatulea@nvidia.com>
> > > > > Cc: Dragos Tatulea <dtatulea@nvidia.com>
> > > > > Cc: Maciej =C5=BBenczykowski <maze@google.com>
> > > > > Cc: Willem de Bruijn <willemb@google.com>
> > > > > Cc: Neal Cardwell <ncardwell@google.com>
> > > > > Cc: Shachar Kagan <skagan@nvidia.com>
> > > > > ---
> > > > >  net/ipv4/tcp_ipv4.c | 3 ++-
> > > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> > > > > index 88c83ac4212957f19efad0f967952d2502bdbc7f..a717db99972d977a6=
4178d7ed1109325d64a6d51 100644
> > > > > --- a/net/ipv4/tcp_ipv4.c
> > > > > +++ b/net/ipv4/tcp_ipv4.c
> > > > > @@ -602,7 +602,8 @@ int tcp_v4_err(struct sk_buff *skb, u32 info)
> > > > >               if (fastopen && !fastopen->sk)
> > > > >                       break;
> > > > >
> > > > > -             ip_icmp_error(sk, skb, err, th->dest, info, (u8 *)t=
h);
> > > > > +             if (inet_test_bit(RECVERR, sk))
> > > > > +                     ip_icmp_error(sk, skb, err, th->dest, info,=
 (u8 *)th);
> > > > >
> > > > >               if (!sock_owned_by_user(sk)) {
> > > > >                       WRITE_ONCE(sk->sk_err, err);
> > > >
> > > > We have a fcnal-test.sh self-test failure:
> > > >
> > > > https://netdev.bots.linux.dev/contest.html?branch=3Dnet-next-2024-0=
4-18--06-00&test=3Dfcnal-test-sh
> > > >
> > > > that I suspect are related to this patch (or the following one): th=
e
> > > > test case creates a TCP connection on loopback and this is the only
> > > > patchseries touching the related code, included in the relevant pat=
ch
> > > > burst.
> > > >
> > > > Could you please have a look?
> > >
> > > Sure, thanks Paolo !
> >
> > First patch is fine, I see no failure from fcnal-test.sh (as I would ex=
pect)
> >
> > For the second one, I am not familiar enough with this very slow test
> > suite (all these "sleep 1" ... oh well)
>
> @David, some of them could be replaced with loopy_wait calls
>
> > I guess "failing tests" depended on TCP connect() to immediately abort
> > on one ICMP message,
> > depending on old kernel behavior.
> >
> > I do not know how to launch a subset of the tests, and trace these.
> >
> > "./fcnal-test.sh -t ipv4_tcp" alone takes more than 9 minutes [1] in a
> > VM running a non debug kernel :/
> >
> > David, do you have an idea how to proceed ?
>
> One very dumb thing I do in that cases is commenting out the other
> tests, something alike (completely untested!):
> ---
> diff --git a/tools/testing/selftests/net/fcnal-test.sh b/tools/testing/se=
lftests/net/fcnal-test.sh
> index 386ebd829df5..494932aa99b2 100755
> --- a/tools/testing/selftests/net/fcnal-test.sh
> +++ b/tools/testing/selftests/net/fcnal-test.sh
> @@ -1186,6 +1186,7 @@ ipv4_tcp_novrf()
>  {
>         local a
>
> +if false; then
>         #
>         # server tests
>         #
> @@ -1271,6 +1272,7 @@ ipv4_tcp_novrf()
>                 log_test_addr ${a} $? 1 "Device server, unbound client, l=
ocal connection"
>         done
>
> +fi
>         a=3D${NSA_IP}
>         log_start
>         run_cmd nettest -s &
> @@ -1487,12 +1489,14 @@ ipv4_tcp()
>         set_sysctl net.ipv4.tcp_l3mdev_accept=3D0
>         ipv4_tcp_novrf
>         log_subsection "tcp_l3mdev_accept enabled"
> +if false; then
>         set_sysctl net.ipv4.tcp_l3mdev_accept=3D1
>         ipv4_tcp_novrf
>
>         log_subsection "With VRF"
>         setup "yes"
>         ipv4_tcp_vrf
> +fi
>  }

Thanks Paolo

I found that the following patch is fixing the issue for me.

diff --git a/tools/testing/selftests/net/nettest.c
b/tools/testing/selftests/net/nettest.c
index cd8a580974480212b45d86f35293b77f3d033473..ff25e53024ef6d4101f251c8a8a=
5e936e44e280f
100644
--- a/tools/testing/selftests/net/nettest.c
+++ b/tools/testing/selftests/net/nettest.c
@@ -1744,6 +1744,7 @@ static int connectsock(void *addr, socklen_t
alen, struct sock_args *args)
        if (args->bind_test_only)
                goto out;

+       set_recv_attr(sd, args->version);
        if (connect(sd, addr, alen) < 0) {
                if (errno !=3D EINPROGRESS) {
                        log_err_errno("Failed to connect to remote host");


Return-Path: <netdev+bounces-89117-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B100E8A9793
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 12:38:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27CF61F219D8
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 10:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59F05160793;
	Thu, 18 Apr 2024 10:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DttbU/yU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A8915FD19
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 10:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713436583; cv=none; b=uQmIbcJdGHW0XtVQmS1OqjVoKYPdynwTtk613LtRQqEgcPQuTvm+bwU5sVd6NZAyi4x7C+H/k4VDtqR/DUjXC/I3zrRzrmBQhHACvsoIohNl7SvVuDUhvVMvfRAdCQsXNWmoCFeAIiKfCb2yUiV7vhFnaBLhfKG+NQikl44dru8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713436583; c=relaxed/simple;
	bh=JBg88H9rszxtozTHN3KCQmS5T63NVkvx85CNlw+Bx34=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u7qlZ3jOOQqgWf+7krPXu3sZuP/nLcSJ+RedvCvTbDM8eXXory8rrKVjaD3CCQMDYiTXTkhfszB3Jo1ZsNcwUHkwKgkU0GNP0dh2w+b4/nx+h1YWyeenN6mSSxmaDaDI8+r2D5y9NQXuB1P+1DmjHS0IR+HJOJotWcFPKWc/+0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DttbU/yU; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-56e5174ffc2so7840a12.1
        for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 03:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713436579; x=1714041379; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wR48YcL7pubFu/dtux+W0UvZV+U7NVSFm4pGP3PmoPI=;
        b=DttbU/yUgknXQZ6H/M68fMd4D44+57g2fjnvfjNHaPA4K3urOhvs/F7siPOwzAhOfj
         tu0aUrAg33NzWXH3cRQgo8G2ujLSV+gjRN7/03oBMOJkr2+jIPzU4Z/O8WpohQpgTNta
         ZrAWWu/wUClh2BYNPHstyvCoPFv8k9Jo8AHefXfbe9UymX/msNTNQ4BrAd56sYzOtZgW
         tQXmZRtJZDDN+3/LBRd9etAZzrusfLPna76UKFYFMsCmXA/LQ6fKlPg2sNQVoo77Fqf7
         RBSw1wUeBj4mqeRxWuJTTo22Oi9QQVAylm9KyJ8dcTrHuUQcGZSZdpW2zPU7i+574+1l
         Hs5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713436580; x=1714041380;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wR48YcL7pubFu/dtux+W0UvZV+U7NVSFm4pGP3PmoPI=;
        b=KSaJJ67s7CQfbbiJ3Vr0PBHEk+u9W6TFUzkufLvgL39zdicXE7hPmY05gFNV5b+7gB
         NWyQuenuMUgPnAdbp/66S7gDMEyh/J4yF30aNnid03f7LIQbkXhhJukyPg3XYeJsrVwc
         8bPzYV/inuDGD3kByX5wfyXpwfoDPGGfSqnvToSAnb9BVu9nhWMWCnQ+mFX2YBEqr19w
         bIFLcNy2xkRHavy6/MXO5uE3pi4AwqV2ctSss6fuapU15ZqNbQEDKU1/eAOADfMvu/Qt
         wiluNt9D08TQVgMSjL9HjxvzBohGVdQAOZS2o3cKIgpTGyuhLvEyZRPk2H5RRooGsje9
         ER2w==
X-Forwarded-Encrypted: i=1; AJvYcCW5WSoQLC2/RTvUDs3X5JIgTimToPWSFu98dKxn+H4ScXIW2z8mnMyYe9SCh0tUk1esUGwHxy1z1IQvAG9Apa5CZOM6Odv/
X-Gm-Message-State: AOJu0YyMEUt28FJKjAXIXRuVTzjM4tcNedvnb5EepW7tlbDhtJQkyLRN
	M03teXf57IR/8pRcGPvJfZ0Lt0u633ZUmAv+mnbAso+CaA9mUz0Wyi2TrBv1NnDHtv3U6PrAg9R
	tkyenchDkr57y7IYzxMIV0yTI4lQSAVuk21+E
X-Google-Smtp-Source: AGHT+IHRDI/KSAykxu4N+g9RbFh2tQRwAlRkJ5WP1ZWlbW0kOsOhC+JRyY5eH0ayxsXAz079cteosKOOmYT8uonOvlk=
X-Received: by 2002:aa7:c987:0:b0:570:49e3:60a8 with SMTP id
 c7-20020aa7c987000000b0057049e360a8mr98999edt.7.1713436579340; Thu, 18 Apr
 2024 03:36:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240417165756.2531620-1-edumazet@google.com> <20240417165756.2531620-2-edumazet@google.com>
 <e332d0b8fa7b116003dfd8b47f021901e66b36b9.camel@redhat.com>
 <CANn89i+-cjHze1yiFZKr-cCGG7Fh4gb9NZnS1u4u_77bG2Mf6Q@mail.gmail.com>
 <CANn89iLSZFOYfZUSK57LLe8yw4wNt8vHt=aD79a1MbZBhfeRbw@mail.gmail.com>
 <7d1aa7d5a134ad4f4bca215ec6a075190cea03f2.camel@redhat.com>
 <CANn89iJg7AcxMLbvwnghN85L6ASuoKsSSSHdgaQzBU48G1TRiw@mail.gmail.com> <CANn89i+BKDL-BHqHyev9PAzbHqp8xhkC=4kZTB7vydcBVkc0Nw@mail.gmail.com>
In-Reply-To: <CANn89i+BKDL-BHqHyev9PAzbHqp8xhkC=4kZTB7vydcBVkc0Nw@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 18 Apr 2024 12:36:08 +0200
Message-ID: <CANn89iK3kCqrgpyEiXHK5Y4MnHxE=CEdxgyE5HHAsasa-Fefbg@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] tcp: conditionally call ip_icmp_error() from tcp_v4_err()
To: Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, 
	Neal Cardwell <ncardwell@google.com>, Dragos Tatulea <dtatulea@nvidia.com>, eric.dumazet@gmail.com, 
	=?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>, 
	Willem de Bruijn <willemb@google.com>, Shachar Kagan <skagan@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 18, 2024 at 12:22=E2=80=AFPM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> On Thu, Apr 18, 2024 at 12:15=E2=80=AFPM Eric Dumazet <edumazet@google.co=
m> wrote:
> >
> > On Thu, Apr 18, 2024 at 11:58=E2=80=AFAM Paolo Abeni <pabeni@redhat.com=
> wrote:
> > >
> > > On Thu, 2024-04-18 at 11:26 +0200, Eric Dumazet wrote:
> > > > On Thu, Apr 18, 2024 at 10:03=E2=80=AFAM Eric Dumazet <edumazet@goo=
gle.com> wrote:
> > > > >
> > > > > On Thu, Apr 18, 2024 at 10:02=E2=80=AFAM Paolo Abeni <pabeni@redh=
at.com> wrote:
> > > > > >
> > > > > > Hi,
> > > > > >
> > > > > > On Wed, 2024-04-17 at 16:57 +0000, Eric Dumazet wrote:
> > > > > > > Blamed commit claimed in its changelog that the new functiona=
lity
> > > > > > > was guarded by IP_RECVERR/IPV6_RECVERR :
> > > > > > >
> > > > > > >     Note that applications need to set IP_RECVERR/IPV6_RECVER=
R option to
> > > > > > >     enable this feature, and that the error message is only q=
ueued
> > > > > > >     while in SYN_SNT state.
> > > > > > >
> > > > > > > This was true only for IPv6, because ipv6_icmp_error() has
> > > > > > > the following check:
> > > > > > >
> > > > > > > if (!inet6_test_bit(RECVERR6, sk))
> > > > > > >     return;
> > > > > > >
> > > > > > > Other callers check IP_RECVERR by themselves, it is unclear
> > > > > > > if we could factorize these checks in ip_icmp_error()
> > > > > > >
> > > > > > > For stable backports, I chose to add the missing check in tcp=
_v4_err()
> > > > > > >
> > > > > > > We think this missing check was the root cause for commit
> > > > > > > 0a8de364ff7a ("tcp: no longer abort SYN_SENT when receiving
> > > > > > > some ICMP") breakage, leading to a revert.
> > > > > > >
> > > > > > > Many thanks to Dragos Tatulea for conducting the investigatio=
ns.
> > > > > > >
> > > > > > > As Jakub said :
> > > > > > >
> > > > > > >     The suspicion is that SSH sees the ICMP report on the soc=
ket error queue
> > > > > > >     and tries to connect() again, but due to the patch the so=
cket isn't
> > > > > > >     disconnected, so it gets EALREADY, and throws its hands u=
p...
> > > > > > >
> > > > > > >     The error bubbles up to Vagrant which also becomes unhapp=
y.
> > > > > > >
> > > > > > >     Can we skip the call to ip_icmp_error() for non-fatal ICM=
P errors?
> > > > > > >
> > > > > > > Fixes: 45af29ca761c ("tcp: allow traceroute -Mtcp for unpriv =
users")
> > > > > > > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > > > > > > Tested-by: Dragos Tatulea <dtatulea@nvidia.com>
> > > > > > > Cc: Dragos Tatulea <dtatulea@nvidia.com>
> > > > > > > Cc: Maciej =C5=BBenczykowski <maze@google.com>
> > > > > > > Cc: Willem de Bruijn <willemb@google.com>
> > > > > > > Cc: Neal Cardwell <ncardwell@google.com>
> > > > > > > Cc: Shachar Kagan <skagan@nvidia.com>
> > > > > > > ---
> > > > > > >  net/ipv4/tcp_ipv4.c | 3 ++-
> > > > > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > > > > >
> > > > > > > diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> > > > > > > index 88c83ac4212957f19efad0f967952d2502bdbc7f..a717db99972d9=
77a64178d7ed1109325d64a6d51 100644
> > > > > > > --- a/net/ipv4/tcp_ipv4.c
> > > > > > > +++ b/net/ipv4/tcp_ipv4.c
> > > > > > > @@ -602,7 +602,8 @@ int tcp_v4_err(struct sk_buff *skb, u32 i=
nfo)
> > > > > > >               if (fastopen && !fastopen->sk)
> > > > > > >                       break;
> > > > > > >
> > > > > > > -             ip_icmp_error(sk, skb, err, th->dest, info, (u8=
 *)th);
> > > > > > > +             if (inet_test_bit(RECVERR, sk))
> > > > > > > +                     ip_icmp_error(sk, skb, err, th->dest, i=
nfo, (u8 *)th);
> > > > > > >
> > > > > > >               if (!sock_owned_by_user(sk)) {
> > > > > > >                       WRITE_ONCE(sk->sk_err, err);
> > > > > >
> > > > > > We have a fcnal-test.sh self-test failure:
> > > > > >
> > > > > > https://netdev.bots.linux.dev/contest.html?branch=3Dnet-next-20=
24-04-18--06-00&test=3Dfcnal-test-sh
> > > > > >
> > > > > > that I suspect are related to this patch (or the following one)=
: the
> > > > > > test case creates a TCP connection on loopback and this is the =
only
> > > > > > patchseries touching the related code, included in the relevant=
 patch
> > > > > > burst.
> > > > > >
> > > > > > Could you please have a look?
> > > > >
> > > > > Sure, thanks Paolo !
> > > >
> > > > First patch is fine, I see no failure from fcnal-test.sh (as I woul=
d expect)
> > > >
> > > > For the second one, I am not familiar enough with this very slow te=
st
> > > > suite (all these "sleep 1" ... oh well)
> > >
> > > @David, some of them could be replaced with loopy_wait calls
> > >
> > > > I guess "failing tests" depended on TCP connect() to immediately ab=
ort
> > > > on one ICMP message,
> > > > depending on old kernel behavior.
> > > >
> > > > I do not know how to launch a subset of the tests, and trace these.
> > > >
> > > > "./fcnal-test.sh -t ipv4_tcp" alone takes more than 9 minutes [1] i=
n a
> > > > VM running a non debug kernel :/
> > > >
> > > > David, do you have an idea how to proceed ?
> > >
> > > One very dumb thing I do in that cases is commenting out the other
> > > tests, something alike (completely untested!):
> > > ---
> > > diff --git a/tools/testing/selftests/net/fcnal-test.sh b/tools/testin=
g/selftests/net/fcnal-test.sh
> > > index 386ebd829df5..494932aa99b2 100755
> > > --- a/tools/testing/selftests/net/fcnal-test.sh
> > > +++ b/tools/testing/selftests/net/fcnal-test.sh
> > > @@ -1186,6 +1186,7 @@ ipv4_tcp_novrf()
> > >  {
> > >         local a
> > >
> > > +if false; then
> > >         #
> > >         # server tests
> > >         #
> > > @@ -1271,6 +1272,7 @@ ipv4_tcp_novrf()
> > >                 log_test_addr ${a} $? 1 "Device server, unbound clien=
t, local connection"
> > >         done
> > >
> > > +fi
> > >         a=3D${NSA_IP}
> > >         log_start
> > >         run_cmd nettest -s &
> > > @@ -1487,12 +1489,14 @@ ipv4_tcp()
> > >         set_sysctl net.ipv4.tcp_l3mdev_accept=3D0
> > >         ipv4_tcp_novrf
> > >         log_subsection "tcp_l3mdev_accept enabled"
> > > +if false; then
> > >         set_sysctl net.ipv4.tcp_l3mdev_accept=3D1
> > >         ipv4_tcp_novrf
> > >
> > >         log_subsection "With VRF"
> > >         setup "yes"
> > >         ipv4_tcp_vrf
> > > +fi
> > >  }
> >
> > Thanks Paolo
> >
> > I found that the following patch is fixing the issue for me.
> >
> > diff --git a/tools/testing/selftests/net/nettest.c
> > b/tools/testing/selftests/net/nettest.c
> > index cd8a580974480212b45d86f35293b77f3d033473..ff25e53024ef6d4101f251c=
8a8a5e936e44e280f
> > 100644
> > --- a/tools/testing/selftests/net/nettest.c
> > +++ b/tools/testing/selftests/net/nettest.c
> > @@ -1744,6 +1744,7 @@ static int connectsock(void *addr, socklen_t
> > alen, struct sock_args *args)
> >         if (args->bind_test_only)
> >                 goto out;
> >
> > +       set_recv_attr(sd, args->version);
> >         if (connect(sd, addr, alen) < 0) {
> >                 if (errno !=3D EINPROGRESS) {
> >                         log_err_errno("Failed to connect to remote host=
");
>
> When tracing nettest we now have EHOSTUNREACH
>
> 3343  setsockopt(3, SOL_SOCKET, SO_REUSEPORT, [1], 4) =3D 0 <0.000210>
> 3343  setsockopt(3, SOL_SOCKET, SO_BINDTODEVICE, "eth1\0", 5) =3D 0 <0.00=
0170>
> 3343  setsockopt(3, SOL_IP, IP_PKTINFO, [1], 4) =3D 0 <0.000161>
> 3343  setsockopt(3, SOL_IP, IP_RECVERR, [1], 4) =3D 0 <0.000181>
> 3343  connect(3, {sa_family=3DAF_INET, sin_port=3Dhtons(12345),
> sin_addr=3Dinet_addr("172.16.2.1")}, 16) =3D -1 EINPROGRESS (Operation no=
w
> in progress) <0.000874>
> 3343  pselect6(1024, NULL, [3], NULL, {tv_sec=3D5, tv_nsec=3D0}, NULL) =
=3D 1
> (out [3], left {tv_sec=3D1, tv_nsec=3D930762080}) <3.069673>
> 3343  getsockopt(3, SOL_SOCKET, SO_ERROR, [EHOSTUNREACH], [4]) =3D 0 <0.0=
00270>
>
> As mentioned in net/ipv4/icmp.c :
>  RFC 1122: 3.2.2.1 States that NET_UNREACH, HOST_UNREACH and SR_FAILED
> MUST be considered 'transient errs'.
>
> Maybe another way to fix nettest would be to change wait_for_connect()
> to pass a non NULL fdset in 4th argument of select()
>
> select(FD_SETSIZE, NULL, &wfd, NULL /* here */, tv);

This change in wait_for_connect() does not help.

I am guessing set_recv_attr(sd, args->version); is what we need.

I am running all ./fcnal-test.sh tests to make sure everything is green.


Return-Path: <netdev+bounces-89101-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15F0F8A973A
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 12:22:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4ADEBB2294F
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 10:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FDB315B97D;
	Thu, 18 Apr 2024 10:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wfN+gK/S"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F70915B544
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 10:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713435755; cv=none; b=hj05ZmGtlNT0shGLrIvdURo56DZTb86OSvqtcw3y7oSIFP9ASiVwri3e0O7uQAlgVsFBZzqp3SjxmZbM953BBY40borhp6aYPa/F5O0PPnZ2GB6/+oey8q0zneUHaIQGRkZt6Z5mlxA8F7CWYRvDUcuWhe7aSzoC8CzIAWmn5ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713435755; c=relaxed/simple;
	bh=NVe/j2tNqTlgl9U+prgxzoJr9bAIZrEDcgB3HvgIm5c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lx5lxlZgUw6wgv4QcVasTQdS6HiZBuQkSAEYCcWKVi7kl/1AlltTDD1lyXEcQXNTpVdU0DiHu7ExukRuByhLqQARWN9Rce2Jtjdor72xspOQMIVuUb12FuDp1AiAyUwW9F32+CAOG99FM912q2Ew2CTjwcpl7RTpqm5+zvebLyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wfN+gK/S; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-56e2e851794so8271a12.0
        for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 03:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713435752; x=1714040552; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0UzJs1/BF/uqRROBys2kUXI64hxvbXpQct0Tue7eBhs=;
        b=wfN+gK/SyQD+GIk6gmUtVNJ6VWGEfeyPx4F23VCVhzwCjbRZl1v8eu5C3+EQKjt1vh
         TvsL10S7zDEssuSgQOtnvBA3e/KBBuGxQC/nsfjCJgAmFn7Y28NSQjzSjxd1IfP8qo/K
         Rled9pftZHIemtCQzH+t+0veirNU/1PEl1vS7MRXYiXQb+KsGYctn3815Hd8KSEH9wUn
         nmpqdqigkqsIA/ESGxATCbRHFgk3pkyJ8yNtniyXaoEFZruakm1GkM8aUaarkD4haGg5
         X3nqFACU+3aRFpO2NzCmkBrxtr8hiUexi1kesjArotIrUimMJ2Zr3SJq2+wp6w8Wu7D0
         vifg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713435752; x=1714040552;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0UzJs1/BF/uqRROBys2kUXI64hxvbXpQct0Tue7eBhs=;
        b=HVntP37fBtBuVqiIIpF1uQmWZiHNBSLw8kHyIJDQAuBrQ31Fw0QU+Lmy5pAPkQWGmd
         LJDFwHpKx/lQQGPgRK3wY9BBxfofQXw6JEoxcDqMwXPjQgdtBuVSCNN3XutWaj85aozU
         3mryV7OQM+gx+SvO9Gg9+2l5tdGa91qUiJG8NYcR15AuWtP4fZNodsfrEe3nuAqLrEHN
         L7bkulPs1/zn3KvIOx4Zol/iurHTLDIGP037uzPLJV4B2/ZnU/PdynKti534HzCCdsv/
         5IzIYEJr2BLSemnhmouDOzMhZLAoVmDLBd0FjMJ/tUcpb5p9pRwBJPxphgpP91qVi2uz
         LpKA==
X-Forwarded-Encrypted: i=1; AJvYcCWd/gBoCd59LY43ls6wHxPhHuouYPGEDMeuTfeMpnU6mAJdBYXW2rAlQ8LXy4jcNz4v0CxeVsDqcLPpiHF3ErSIRkL+YZ6q
X-Gm-Message-State: AOJu0YxLHO1Y6mN9CIgc6oqfBMrRUfjlpXcyLu8ZiNbvBUOpEIswaVPn
	zwuhRTVCsvk+ACYdc0NQcA45wixYgdLac7XOTm4oKw+VRNDKhD/BjzcC3CKABA/prR7hKEmsbWG
	uAL3zMfJ4hI1nXz8ErGJ7Q5+X/FnEGNjk3Git
X-Google-Smtp-Source: AGHT+IEO0lJUUXgy+ypX+2AJgtWk3YT4yREQspEncYE3+d/ZCCmaCGU92iN3xR4y7W6pEca5ifQ+zcF+RHxfknAdynQ=
X-Received: by 2002:aa7:db50:0:b0:570:fa4:97d6 with SMTP id
 n16-20020aa7db50000000b005700fa497d6mr154210edt.0.1713435751618; Thu, 18 Apr
 2024 03:22:31 -0700 (PDT)
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
 <7d1aa7d5a134ad4f4bca215ec6a075190cea03f2.camel@redhat.com> <CANn89iJg7AcxMLbvwnghN85L6ASuoKsSSSHdgaQzBU48G1TRiw@mail.gmail.com>
In-Reply-To: <CANn89iJg7AcxMLbvwnghN85L6ASuoKsSSSHdgaQzBU48G1TRiw@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 18 Apr 2024 12:22:16 +0200
Message-ID: <CANn89i+BKDL-BHqHyev9PAzbHqp8xhkC=4kZTB7vydcBVkc0Nw@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] tcp: conditionally call ip_icmp_error() from tcp_v4_err()
To: Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, 
	Neal Cardwell <ncardwell@google.com>, Dragos Tatulea <dtatulea@nvidia.com>, eric.dumazet@gmail.com, 
	=?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>, 
	Willem de Bruijn <willemb@google.com>, Shachar Kagan <skagan@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 18, 2024 at 12:15=E2=80=AFPM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> On Thu, Apr 18, 2024 at 11:58=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> =
wrote:
> >
> > On Thu, 2024-04-18 at 11:26 +0200, Eric Dumazet wrote:
> > > On Thu, Apr 18, 2024 at 10:03=E2=80=AFAM Eric Dumazet <edumazet@googl=
e.com> wrote:
> > > >
> > > > On Thu, Apr 18, 2024 at 10:02=E2=80=AFAM Paolo Abeni <pabeni@redhat=
.com> wrote:
> > > > >
> > > > > Hi,
> > > > >
> > > > > On Wed, 2024-04-17 at 16:57 +0000, Eric Dumazet wrote:
> > > > > > Blamed commit claimed in its changelog that the new functionali=
ty
> > > > > > was guarded by IP_RECVERR/IPV6_RECVERR :
> > > > > >
> > > > > >     Note that applications need to set IP_RECVERR/IPV6_RECVERR =
option to
> > > > > >     enable this feature, and that the error message is only que=
ued
> > > > > >     while in SYN_SNT state.
> > > > > >
> > > > > > This was true only for IPv6, because ipv6_icmp_error() has
> > > > > > the following check:
> > > > > >
> > > > > > if (!inet6_test_bit(RECVERR6, sk))
> > > > > >     return;
> > > > > >
> > > > > > Other callers check IP_RECVERR by themselves, it is unclear
> > > > > > if we could factorize these checks in ip_icmp_error()
> > > > > >
> > > > > > For stable backports, I chose to add the missing check in tcp_v=
4_err()
> > > > > >
> > > > > > We think this missing check was the root cause for commit
> > > > > > 0a8de364ff7a ("tcp: no longer abort SYN_SENT when receiving
> > > > > > some ICMP") breakage, leading to a revert.
> > > > > >
> > > > > > Many thanks to Dragos Tatulea for conducting the investigations=
.
> > > > > >
> > > > > > As Jakub said :
> > > > > >
> > > > > >     The suspicion is that SSH sees the ICMP report on the socke=
t error queue
> > > > > >     and tries to connect() again, but due to the patch the sock=
et isn't
> > > > > >     disconnected, so it gets EALREADY, and throws its hands up.=
..
> > > > > >
> > > > > >     The error bubbles up to Vagrant which also becomes unhappy.
> > > > > >
> > > > > >     Can we skip the call to ip_icmp_error() for non-fatal ICMP =
errors?
> > > > > >
> > > > > > Fixes: 45af29ca761c ("tcp: allow traceroute -Mtcp for unpriv us=
ers")
> > > > > > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > > > > > Tested-by: Dragos Tatulea <dtatulea@nvidia.com>
> > > > > > Cc: Dragos Tatulea <dtatulea@nvidia.com>
> > > > > > Cc: Maciej =C5=BBenczykowski <maze@google.com>
> > > > > > Cc: Willem de Bruijn <willemb@google.com>
> > > > > > Cc: Neal Cardwell <ncardwell@google.com>
> > > > > > Cc: Shachar Kagan <skagan@nvidia.com>
> > > > > > ---
> > > > > >  net/ipv4/tcp_ipv4.c | 3 ++-
> > > > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > > > >
> > > > > > diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> > > > > > index 88c83ac4212957f19efad0f967952d2502bdbc7f..a717db99972d977=
a64178d7ed1109325d64a6d51 100644
> > > > > > --- a/net/ipv4/tcp_ipv4.c
> > > > > > +++ b/net/ipv4/tcp_ipv4.c
> > > > > > @@ -602,7 +602,8 @@ int tcp_v4_err(struct sk_buff *skb, u32 inf=
o)
> > > > > >               if (fastopen && !fastopen->sk)
> > > > > >                       break;
> > > > > >
> > > > > > -             ip_icmp_error(sk, skb, err, th->dest, info, (u8 *=
)th);
> > > > > > +             if (inet_test_bit(RECVERR, sk))
> > > > > > +                     ip_icmp_error(sk, skb, err, th->dest, inf=
o, (u8 *)th);
> > > > > >
> > > > > >               if (!sock_owned_by_user(sk)) {
> > > > > >                       WRITE_ONCE(sk->sk_err, err);
> > > > >
> > > > > We have a fcnal-test.sh self-test failure:
> > > > >
> > > > > https://netdev.bots.linux.dev/contest.html?branch=3Dnet-next-2024=
-04-18--06-00&test=3Dfcnal-test-sh
> > > > >
> > > > > that I suspect are related to this patch (or the following one): =
the
> > > > > test case creates a TCP connection on loopback and this is the on=
ly
> > > > > patchseries touching the related code, included in the relevant p=
atch
> > > > > burst.
> > > > >
> > > > > Could you please have a look?
> > > >
> > > > Sure, thanks Paolo !
> > >
> > > First patch is fine, I see no failure from fcnal-test.sh (as I would =
expect)
> > >
> > > For the second one, I am not familiar enough with this very slow test
> > > suite (all these "sleep 1" ... oh well)
> >
> > @David, some of them could be replaced with loopy_wait calls
> >
> > > I guess "failing tests" depended on TCP connect() to immediately abor=
t
> > > on one ICMP message,
> > > depending on old kernel behavior.
> > >
> > > I do not know how to launch a subset of the tests, and trace these.
> > >
> > > "./fcnal-test.sh -t ipv4_tcp" alone takes more than 9 minutes [1] in =
a
> > > VM running a non debug kernel :/
> > >
> > > David, do you have an idea how to proceed ?
> >
> > One very dumb thing I do in that cases is commenting out the other
> > tests, something alike (completely untested!):
> > ---
> > diff --git a/tools/testing/selftests/net/fcnal-test.sh b/tools/testing/=
selftests/net/fcnal-test.sh
> > index 386ebd829df5..494932aa99b2 100755
> > --- a/tools/testing/selftests/net/fcnal-test.sh
> > +++ b/tools/testing/selftests/net/fcnal-test.sh
> > @@ -1186,6 +1186,7 @@ ipv4_tcp_novrf()
> >  {
> >         local a
> >
> > +if false; then
> >         #
> >         # server tests
> >         #
> > @@ -1271,6 +1272,7 @@ ipv4_tcp_novrf()
> >                 log_test_addr ${a} $? 1 "Device server, unbound client,=
 local connection"
> >         done
> >
> > +fi
> >         a=3D${NSA_IP}
> >         log_start
> >         run_cmd nettest -s &
> > @@ -1487,12 +1489,14 @@ ipv4_tcp()
> >         set_sysctl net.ipv4.tcp_l3mdev_accept=3D0
> >         ipv4_tcp_novrf
> >         log_subsection "tcp_l3mdev_accept enabled"
> > +if false; then
> >         set_sysctl net.ipv4.tcp_l3mdev_accept=3D1
> >         ipv4_tcp_novrf
> >
> >         log_subsection "With VRF"
> >         setup "yes"
> >         ipv4_tcp_vrf
> > +fi
> >  }
>
> Thanks Paolo
>
> I found that the following patch is fixing the issue for me.
>
> diff --git a/tools/testing/selftests/net/nettest.c
> b/tools/testing/selftests/net/nettest.c
> index cd8a580974480212b45d86f35293b77f3d033473..ff25e53024ef6d4101f251c8a=
8a5e936e44e280f
> 100644
> --- a/tools/testing/selftests/net/nettest.c
> +++ b/tools/testing/selftests/net/nettest.c
> @@ -1744,6 +1744,7 @@ static int connectsock(void *addr, socklen_t
> alen, struct sock_args *args)
>         if (args->bind_test_only)
>                 goto out;
>
> +       set_recv_attr(sd, args->version);
>         if (connect(sd, addr, alen) < 0) {
>                 if (errno !=3D EINPROGRESS) {
>                         log_err_errno("Failed to connect to remote host")=
;

When tracing nettest we now have EHOSTUNREACH

3343  setsockopt(3, SOL_SOCKET, SO_REUSEPORT, [1], 4) =3D 0 <0.000210>
3343  setsockopt(3, SOL_SOCKET, SO_BINDTODEVICE, "eth1\0", 5) =3D 0 <0.0001=
70>
3343  setsockopt(3, SOL_IP, IP_PKTINFO, [1], 4) =3D 0 <0.000161>
3343  setsockopt(3, SOL_IP, IP_RECVERR, [1], 4) =3D 0 <0.000181>
3343  connect(3, {sa_family=3DAF_INET, sin_port=3Dhtons(12345),
sin_addr=3Dinet_addr("172.16.2.1")}, 16) =3D -1 EINPROGRESS (Operation now
in progress) <0.000874>
3343  pselect6(1024, NULL, [3], NULL, {tv_sec=3D5, tv_nsec=3D0}, NULL) =3D =
1
(out [3], left {tv_sec=3D1, tv_nsec=3D930762080}) <3.069673>
3343  getsockopt(3, SOL_SOCKET, SO_ERROR, [EHOSTUNREACH], [4]) =3D 0 <0.000=
270>

As mentioned in net/ipv4/icmp.c :
 RFC 1122: 3.2.2.1 States that NET_UNREACH, HOST_UNREACH and SR_FAILED
MUST be considered 'transient errs'.

Maybe another way to fix nettest would be to change wait_for_connect()
to pass a non NULL fdset in 4th argument of select()

select(FD_SETSIZE, NULL, &wfd, NULL /* here */, tv);


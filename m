Return-Path: <netdev+bounces-216089-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 58D26B32029
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 18:09:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27D6B1D22358
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 16:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E62D228727D;
	Fri, 22 Aug 2025 16:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e2XcsNJC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C297F28152A
	for <netdev@vger.kernel.org>; Fri, 22 Aug 2025 16:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755878563; cv=none; b=KDdtC6mYDc8OhX21QrJPfQ8a4pQdbf6ghHVc+K1ghbcrJD98KhNhqghq08bfVdhlhL3QlPz9H2tAi2CTsypZWmj2jVeqG23KQ1eo4+lLBzM0P8dUtfykWhDhHignyP8nqZKE5a14Nbzw6DHs2vfuRwQ2cnZr4Tigx8kMcjwIJ6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755878563; c=relaxed/simple;
	bh=6j2wVSC1eY0LNYrhjKWMbjy4LYJKfEoSAUxyGf+TkRM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t03Hvu5+UopWyZaRM+tyybKa4dUguMQaQuKiy8BPNE0tefBIGVHhswCvyX0fBgVvd1y5Xam3Wswkdy7jvJFaJfZFoc0kk+tK48dKa43+NzT1bxLALdTzxIQwCpIx7Jjhy/x9ELe9SCfj+/1qXLrLlSez34gTvNWbKnlTUa4YRjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e2XcsNJC; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3b9a342e8ffso1583131f8f.0
        for <netdev@vger.kernel.org>; Fri, 22 Aug 2025 09:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755878560; x=1756483360; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u6uIOvK2yrojSK1BrIKyE65F98CHI8uQnPckjILUm/E=;
        b=e2XcsNJCUcyRtkXxzPoqqOkwBj4GlrtOeZevyDxI5LSfZZOCmpGScyLuoxaj9SMatV
         tv/x7zCuW67Sn6EyJ+kCIYs3rwP8Rhoz6KsDhyxIyYT735sTU62ezEJFsxMbsJs1hsPt
         I9yBMhhAoDCi3cCPBSHHFwTIlqamuX778g/gFzncwNptTgSb79Ko9cj8qAmBNEXSQBq1
         tCKTYk9RKLg79uuNtum+uoDe+jz5LBoxxJ3a9mb9CXGt0Z2D4VMJEghsbsJleMe76u+E
         6dIBvpt7o7ZFPvxn2s4M3Sy4aOHMuWFWMK0Qtu5IrpJglDj6n+Y7i/lsG+GvSpGjbhBr
         UyzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755878560; x=1756483360;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u6uIOvK2yrojSK1BrIKyE65F98CHI8uQnPckjILUm/E=;
        b=R2rK/YliojGcruYewdhs1Nsz44sBBG/RL6BDyfA6ZaLMECoYT11V04SmN9M9hyrb4K
         PUHbpL9SoLHDcd0wWcphCtAS2Ef+AVywexQefgzCOIc8pujI/ecxxuxL0Z8CpwsjxhW1
         JRViBK1Y3wk5SGGJ0v1VCRfhqefEYsj2ttdd9D+jijHFK2Jvtd897WagW71J1OK3boQ5
         gmH58YiSIgKazQ0/0IPh5yyTkgIJOcOzCz9eQ+/kgfIpZ2B3HBVwVx2gTMRvse9O4DtZ
         raSBMXYtDUYqhVURl1SOrk+BkRRsk12mP2d1B/7Q4XY0/p4TjG6z6zNbgr3KhktWUrWl
         K/hQ==
X-Forwarded-Encrypted: i=1; AJvYcCWPj2qp+Q4S54kUONgFkAfJNWCKXi930FzAMtMy4DJwbsHApsAqdikfh4+BSu6Pj05pffyV9Rw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyGFslVreYNqtbYZRHvJdNtlxLv9jwGmrL44vrBELRczj/4I0J
	HYeHWkBYMyhc2onq07yHPaVzpKFOJGIRgznWwg7AvZUrCnMC4uMF56c/2snHQlTK/7IK0iWoqX3
	O+m3jmrMK5GRN20h7zYz7JmRxJ/Rf2dUBl375AayH
X-Gm-Gg: ASbGncsngLUjJzrjWPirbrw5TvdX5C0TauOchoSr9mRYK4qZQwKOrL2JYRNsgWemxka
	yE5yQ2lwhiu33HxKtl2omewdjCkRuPVJ5FfHDJ6tEjvRCKqUhzUupnb765eknM8vWBxgSAls+wt
	kdR95HAb87wXNIo6tsv1sE+nhUIGAlwy1kJmy70G36FhI+VL7rQB/2yj19+KHyKvg0V56xM0hLc
	R3mf+eG3FFD78OX7PeZs7SV2K0kWktlVJk=
X-Google-Smtp-Source: AGHT+IHy+0GrlNeJA6rIuVVSrxezkgWo24V2J7OrpAtJYKHx3aM+NyvHVhAwt3nKQNrGTxbTgOXS6zxhQjzYrqsL3SQ=
X-Received: by 2002:a05:6000:2c05:b0:3b6:5d0d:9826 with SMTP id
 ffacd0b85a97d-3c4b082654cmr5273385f8f.21.1755878558965; Fri, 22 Aug 2025
 09:02:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822060254.74708-1-mii.w@linux.alibaba.com> <CANn89iLYHdtAFSjSW+cSN0Td_V3B+V05hHnGeop5Y+hjWEt_HA@mail.gmail.com>
In-Reply-To: <CANn89iLYHdtAFSjSW+cSN0Td_V3B+V05hHnGeop5Y+hjWEt_HA@mail.gmail.com>
From: Yuchung Cheng <ycheng@google.com>
Date: Fri, 22 Aug 2025 09:02:02 -0700
X-Gm-Features: Ac12FXxBZ2hBC8VfYiO98CAitgGa1e2IFQ2I30ERv-IptpnUB4wFdmjuC-ZT7NE
Message-ID: <CAK6E8=fG69i1eCFJtu-r19Wt=A-nx_Y5Q4gAum_T1v-42foFPA@mail.gmail.com>
Subject: Re: [RFC net] tcp: Fix orphaned socket stalling indefinitely in FIN-WAIT-1
To: Eric Dumazet <edumazet@google.com>
Cc: MingMing Wang <mii.w@linux.alibaba.com>, ncardwell@google.com, kuniyu@google.com, 
	davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Dust Li <dust.li@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 22, 2025 at 1:53=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Thu, Aug 21, 2025 at 11:04=E2=80=AFPM MingMing Wang <mii.w@linux.aliba=
ba.com> wrote:
> >
> > From: MingMing Wang <mii.w@linux.alibaba.com>
> >
> > An orphaned TCP socket can stall indefinitely in FIN-WAIT-1
> > if the following conditions are met:
> > 1. net.ipv4.tcp_retries2 is set to a value =E2=89=A4 8;
> > 2. The peer advertises a zero window, and the window never reopens.
> >
> > Steps to reproduce:
> > 1. Set up two instances with nmap installed: one will act as the server
> >    the other as the client
> > 2. Execute on the server:
> >    a. lower rmem : `sysctl -w net.ipv4.tcp_rmem=3D"16 32 32"`
> >    b. start a listener: `nc -l -p 1234`
> > 3. Execute on the client:
> >    a. lower tcp_retries2: `sysctl -w net.ipv4.tcp_retries2=3D8`
> >    b. send pakcets: `cat /dev/zero | nc <server-ip> 1234`
> >    c. after five seconds, stop the process: `killall nc`
> > 4. Execute on the server: `killall -STOP nc`
> > 5. Expected abnormal result: using `ss` command, we'll notice that the
> >    client connection remains stuck in the FIN_WAIT1 state, and the
> >    backoff counter always be 8 and no longer increased, as shown below:
> >    ```
>
> Hi MingMing
>
> Please prepare and share with us a packetdrill test, instead of this
> 'repro', which is the old way of describing things :/
>
> - This will be easier for us to understand the issue.
>
> - It will be added to existing tests in tools/testing/selftests/net/packe=
tdrill
> if your patch is accepted, so that we can make sure future changes are
> not breaking this again.
>
> Ideally, you should attach this packetdrill test in a second patch
> (thus sending a series of two patches)
>
> Thank you.
>
> >    FIN-WAIT-1 0      1389    172.16.0.2:50316    172.16.0.1:1234
> >          cubic wscale:2,7 rto:201 backoff:8 rtt:0.078/0.007 mss:36
> >                  ... other fields omitted ...
> >    ```
> > 6. If we set tcp_retries2 to 15 and repeat the steps above, the FIN_WAI=
T1
> >    state will be forcefully reclaimed after about 5 minutes.
> >
> > During the zero-window probe retry process, it will check whether the
> > current connection is alive or not. If the connection is not alive and
> > the counter of retries exceeds the maximum allowed `max_probes`, retry
> > process will be terminated.
> >
> > In our case, when we set `net.ipv4.tcp_retries2` to 8 or a less value,
> > according to the current implementation, the `icsk->icsk_backoff` count=
er
> > will be capped at `net.ipv4.tcp_retries2`. The value calculated by
> > `inet_csk_rto_backoff` will always be too small, which means the
> > computed backoff duration will always be less than rto_max. As a result=
,
> > the alive check will always return true. The condition before the
> > `goto abort` statement is an logical AND condition, the abort branch
> > can never be reached.
> >
> > So, the TCP retransmission backoff mechanism has two issues:
> >
> > 1. `icsk->icsk_backoff` should monotonically increase during probe
> >    transmission and, upon reaching the maximum backoff limit, the
> >    connection should be terminated. However, the backoff value itself
> >    must not be capped prematurely =E2=80=94 it should only control when=
 to abort.
> >
> > 2. The condition for orphaned connection abort was incorrectly based on
> >    connection liveness and probe count. It should instead consider whet=
her
> >    the number of orphaned probes exceeds the intended limit.
> >
> > To fix this, introduce a local variable `orphan_probes` to track orphan
> > probe attempts separately from `max_probes`, which is used for RTO
> > retransmissions. This decouples the two counters and prevents accidenta=
l
> > overwrites, ensuring correct timeout behavior for orphaned connections.
> >
> > Fixes: b248230c34970 ("tcp: abort orphan sockets stalling on zero windo=
w probes")
Thanks for catching this corner case. Feel free to add a Acked-by:
<ycheng@google.com> after the packetdrill test in your respin

> > Co-developed-by: Dust Li <dust.li@linux.alibaba.com>
> > Signed-off-by: Dust Li <dust.li@linux.alibaba.com>
> > Co-developed-by: MingMing Wang <mii.w@linux.alibaba.com>
> > Signed-off-by: MingMing Wang <mii.w@linux.alibaba.com>
> >
> > ---
> > We couldn't determine the rationale behind the following check in tcp_s=
end_probe0():
> > ```
> > if (icsk->icsk_backoff < READ_ONCE(net->ipv4.sysctl_tcp_retries2))
> >     icsk->icsk_backoff++;
> > ```
> >
> > This condition appears to be the root cause of the observed stall.
> > However, it has existed in the kernel for over 20 years =E2=80=94 which=
 suggests
> > there might be a historical or subtle reason for its presence.
> >
> > We would greatly appreciate it if anyone could shed
> > ---
> >  net/ipv4/tcp_output.c | 4 +---
> >  net/ipv4/tcp_timer.c  | 4 ++--
> >  2 files changed, 3 insertions(+), 5 deletions(-)
> >
> > diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> > index caf11920a878..21795d696e38 100644
> > --- a/net/ipv4/tcp_output.c
> > +++ b/net/ipv4/tcp_output.c
> > @@ -4385,7 +4385,6 @@ void tcp_send_probe0(struct sock *sk)
> >  {
> >         struct inet_connection_sock *icsk =3D inet_csk(sk);
> >         struct tcp_sock *tp =3D tcp_sk(sk);
> > -       struct net *net =3D sock_net(sk);
> >         unsigned long timeout;
> >         int err;
> >
> > @@ -4401,8 +4400,7 @@ void tcp_send_probe0(struct sock *sk)
> >
> >         icsk->icsk_probes_out++;
> >         if (err <=3D 0) {
> > -               if (icsk->icsk_backoff < READ_ONCE(net->ipv4.sysctl_tcp=
_retries2))
> > -                       icsk->icsk_backoff++;
> > +               icsk->icsk_backoff++;
>
> I think we need to have a cap, otherwise we risk overflows in
> inet_csk_rto_backoff()
>
>
> >                 timeout =3D tcp_probe0_when(sk, tcp_rto_max(sk));
> >         } else {
> >                 /* If packet was not sent due to local congestion,
> > diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
> > index a207877270fb..4dba2928e1bf 100644
> > --- a/net/ipv4/tcp_timer.c
> > +++ b/net/ipv4/tcp_timer.c
> > @@ -419,9 +419,9 @@ static void tcp_probe_timer(struct sock *sk)
> >         if (sock_flag(sk, SOCK_DEAD)) {
> >                 unsigned int rto_max =3D tcp_rto_max(sk);
> >                 const bool alive =3D inet_csk_rto_backoff(icsk, rto_max=
) < rto_max;
> > +               int orphan_probes =3D tcp_orphan_retries(sk, alive);
> >
> > -               max_probes =3D tcp_orphan_retries(sk, alive);
> > -               if (!alive && icsk->icsk_backoff >=3D max_probes)
> > +               if (!alive || icsk->icsk_backoff >=3D orphan_probes)
> >                         goto abort;
> >                 if (tcp_out_of_resources(sk, true))
> >                         return;
> > --
> > 2.46.0
> >


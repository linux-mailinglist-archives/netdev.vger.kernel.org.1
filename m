Return-Path: <netdev+bounces-215961-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09CE8B31266
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 10:56:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32D1F3BCD14
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 08:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 379822475C7;
	Fri, 22 Aug 2025 08:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Gi+PdxMj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4F8393DE7
	for <netdev@vger.kernel.org>; Fri, 22 Aug 2025 08:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755852833; cv=none; b=XZw9T7rSVRu3zfunO+qah6ZxIRoRpHhkSWKXWhyP0qTaqGle+pu+oh7bCBBVt9PeYg1Dsah5sbk53wjuzJKy0ksAo1JZNYc/Q0IWC4QQ/0kHBwILuFDbwE7lEmnl4q0eLfw127UdJPda9hlmVpcPkRkfkj5pONC6+lhrnU4LSAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755852833; c=relaxed/simple;
	bh=2+bRuuIzI9S+oIj5Db0h0yF3G+mLElAksm4w4Lz8vS8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QJdSegSQOE3n9pz3VnucEe2X7srSUVlAUhLP82/B9JOCZqF2L0JR0OrOUEjXNBzlfW2jY0kI46FmPx888BC/GokwJJm43izg4+olGsmUMKCGtOgUb4Rz25L91jdchdlD+2hUQrXj4K3k+3HUYstPAuGrsmeaFsEs7Od8qvNeOOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Gi+PdxMj; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4b297962b24so19022571cf.2
        for <netdev@vger.kernel.org>; Fri, 22 Aug 2025 01:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755852830; x=1756457630; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VwnXI8Q4i5E1F2kA0OUxgOWXMwST0o08T6okrD/DYYA=;
        b=Gi+PdxMjVe+HTSaNV0YCLDx/qmsE49KJHKQiXwsQu4zOnOLBlKg7qP98/n4hUcQ5Yt
         lNg2WRevgu8mEPLML5M09QKlaUrRBSnezQQ7+oC7+FELBrhMcoGighbqEMIXJMwOnYdo
         aTYI1wnqi3TbsgyKc9CQn0ZlZvrJ75rdea0JY0OBDOWHipUM73i1/S/q7uFeI4enRJS+
         3CAAXumVv7cwLieHnD9Q6HeC5oiRwZi5lM3fXYfxALTrPvEvC5NexdytuM0ByeAstjKd
         +8Ci5ryqlXk3oPBMwYGhnXHmHV9c52izsjEWO4ALFA6T7R4isAGD+VPgwKFo58WWzisC
         7Vkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755852830; x=1756457630;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VwnXI8Q4i5E1F2kA0OUxgOWXMwST0o08T6okrD/DYYA=;
        b=kVXRc/fefIkbirG/dfP0WRojE0l//XVPwMGPr9hlpWOD53kOtajJdWkR6aK1pH+rkG
         Ls0sepJKLwR66+42sSTDkPfM34BrZ+hp5U2U622bIKeeQvDOwNP7jk/FG2cJzs+wUvxC
         NSLW5C/zbCP0hV2Lzlldsf1pCIQmKY1fQEgYj/B6N5ZjDobuwWod5R9xkHFmDQuP3et8
         OQw4m7igxaL0szJs4S9lg9rWLr8Hf4vj7OM+/lNnJZ7dT57AN+fpnSCxWk8cGtxXFyd5
         b6uGI090OYI6bRDnBFqw0qqoGLkoZJ8frklwR6tKlQEVAfrSITqMLkqTZM8YL2LxNri3
         cWBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWAZiwCk4Sbx3at6Q41y0vxeTFFwzsb58IJuQRXkLZ6VTpraWYGi6Cs8Rzq9rQOJ8zmu7Hkl64=@vger.kernel.org
X-Gm-Message-State: AOJu0YxR4ou+gXdNeprrnai/3W0R4Y/+lOJ+/saBu9xExrrFQbOAaBGW
	0PfngERfH612TpRl+ll6/cqMK4uRCkNs7Tb0d7rDL3U74u5Rl4OGXcr053QouyenK4qyvRqLo1O
	NEYIkzI83AsGG9E0nzwAfi61/rgbPk5ORU3760jyY
X-Gm-Gg: ASbGnctWyDfVYLJI4GQ04lOPTLvCvr+Xr2KhMdVxUA+Eh4FKpL1wyDoxNarkxJBtZa7
	cgu5O/g9KC5DJ7Ayl927naCxq0B7wdNScfMeXu7RCalTCLQYxLzqLx/Tj90NoAcD/wUZvForTRt
	5ZrBMxfl94Jyy+7iVrvWT1ke3mMmu+r5l6B5cR2vA2lL0V9XwNpdOZezqr3VZIQigzSGXwR+XiI
	kwdd6CPbUWXYw4=
X-Google-Smtp-Source: AGHT+IFJCOD9ED9ZQtQim2+n+wKW3ngXRFg4cSckRxMhx5RX7rC8DBvYjQpn3RQUBVTBx47wLJ0ZQpKyrA52UTxR1KI=
X-Received: by 2002:ac8:5956:0:b0:4b1:103b:bb72 with SMTP id
 d75a77b69052e-4b2aab26a18mr27843471cf.64.1755852829840; Fri, 22 Aug 2025
 01:53:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822060254.74708-1-mii.w@linux.alibaba.com>
In-Reply-To: <20250822060254.74708-1-mii.w@linux.alibaba.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 22 Aug 2025 01:53:38 -0700
X-Gm-Features: Ac12FXxVs71jQnan2ses4SoCzFVxcC4m-okhoTzkf2IeSW992nOUWQViEMHGDkQ
Message-ID: <CANn89iLYHdtAFSjSW+cSN0Td_V3B+V05hHnGeop5Y+hjWEt_HA@mail.gmail.com>
Subject: Re: [RFC net] tcp: Fix orphaned socket stalling indefinitely in FIN-WAIT-1
To: MingMing Wang <mii.w@linux.alibaba.com>
Cc: ncardwell@google.com, kuniyu@google.com, davem@davemloft.net, 
	dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	ycheng@google.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Dust Li <dust.li@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 21, 2025 at 11:04=E2=80=AFPM MingMing Wang <mii.w@linux.alibaba=
.com> wrote:
>
> From: MingMing Wang <mii.w@linux.alibaba.com>
>
> An orphaned TCP socket can stall indefinitely in FIN-WAIT-1
> if the following conditions are met:
> 1. net.ipv4.tcp_retries2 is set to a value =E2=89=A4 8;
> 2. The peer advertises a zero window, and the window never reopens.
>
> Steps to reproduce:
> 1. Set up two instances with nmap installed: one will act as the server
>    the other as the client
> 2. Execute on the server:
>    a. lower rmem : `sysctl -w net.ipv4.tcp_rmem=3D"16 32 32"`
>    b. start a listener: `nc -l -p 1234`
> 3. Execute on the client:
>    a. lower tcp_retries2: `sysctl -w net.ipv4.tcp_retries2=3D8`
>    b. send pakcets: `cat /dev/zero | nc <server-ip> 1234`
>    c. after five seconds, stop the process: `killall nc`
> 4. Execute on the server: `killall -STOP nc`
> 5. Expected abnormal result: using `ss` command, we'll notice that the
>    client connection remains stuck in the FIN_WAIT1 state, and the
>    backoff counter always be 8 and no longer increased, as shown below:
>    ```

Hi MingMing

Please prepare and share with us a packetdrill test, instead of this
'repro', which is the old way of describing things :/

- This will be easier for us to understand the issue.

- It will be added to existing tests in tools/testing/selftests/net/packetd=
rill
if your patch is accepted, so that we can make sure future changes are
not breaking this again.

Ideally, you should attach this packetdrill test in a second patch
(thus sending a series of two patches)

Thank you.

>    FIN-WAIT-1 0      1389    172.16.0.2:50316    172.16.0.1:1234
>          cubic wscale:2,7 rto:201 backoff:8 rtt:0.078/0.007 mss:36
>                  ... other fields omitted ...
>    ```
> 6. If we set tcp_retries2 to 15 and repeat the steps above, the FIN_WAIT1
>    state will be forcefully reclaimed after about 5 minutes.
>
> During the zero-window probe retry process, it will check whether the
> current connection is alive or not. If the connection is not alive and
> the counter of retries exceeds the maximum allowed `max_probes`, retry
> process will be terminated.
>
> In our case, when we set `net.ipv4.tcp_retries2` to 8 or a less value,
> according to the current implementation, the `icsk->icsk_backoff` counter
> will be capped at `net.ipv4.tcp_retries2`. The value calculated by
> `inet_csk_rto_backoff` will always be too small, which means the
> computed backoff duration will always be less than rto_max. As a result,
> the alive check will always return true. The condition before the
> `goto abort` statement is an logical AND condition, the abort branch
> can never be reached.
>
> So, the TCP retransmission backoff mechanism has two issues:
>
> 1. `icsk->icsk_backoff` should monotonically increase during probe
>    transmission and, upon reaching the maximum backoff limit, the
>    connection should be terminated. However, the backoff value itself
>    must not be capped prematurely =E2=80=94 it should only control when t=
o abort.
>
> 2. The condition for orphaned connection abort was incorrectly based on
>    connection liveness and probe count. It should instead consider whethe=
r
>    the number of orphaned probes exceeds the intended limit.
>
> To fix this, introduce a local variable `orphan_probes` to track orphan
> probe attempts separately from `max_probes`, which is used for RTO
> retransmissions. This decouples the two counters and prevents accidental
> overwrites, ensuring correct timeout behavior for orphaned connections.
>
> Fixes: b248230c34970 ("tcp: abort orphan sockets stalling on zero window =
probes")
> Co-developed-by: Dust Li <dust.li@linux.alibaba.com>
> Signed-off-by: Dust Li <dust.li@linux.alibaba.com>
> Co-developed-by: MingMing Wang <mii.w@linux.alibaba.com>
> Signed-off-by: MingMing Wang <mii.w@linux.alibaba.com>
>
> ---
> We couldn't determine the rationale behind the following check in tcp_sen=
d_probe0():
> ```
> if (icsk->icsk_backoff < READ_ONCE(net->ipv4.sysctl_tcp_retries2))
>     icsk->icsk_backoff++;
> ```
>
> This condition appears to be the root cause of the observed stall.
> However, it has existed in the kernel for over 20 years =E2=80=94 which s=
uggests
> there might be a historical or subtle reason for its presence.
>
> We would greatly appreciate it if anyone could shed
> ---
>  net/ipv4/tcp_output.c | 4 +---
>  net/ipv4/tcp_timer.c  | 4 ++--
>  2 files changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> index caf11920a878..21795d696e38 100644
> --- a/net/ipv4/tcp_output.c
> +++ b/net/ipv4/tcp_output.c
> @@ -4385,7 +4385,6 @@ void tcp_send_probe0(struct sock *sk)
>  {
>         struct inet_connection_sock *icsk =3D inet_csk(sk);
>         struct tcp_sock *tp =3D tcp_sk(sk);
> -       struct net *net =3D sock_net(sk);
>         unsigned long timeout;
>         int err;
>
> @@ -4401,8 +4400,7 @@ void tcp_send_probe0(struct sock *sk)
>
>         icsk->icsk_probes_out++;
>         if (err <=3D 0) {
> -               if (icsk->icsk_backoff < READ_ONCE(net->ipv4.sysctl_tcp_r=
etries2))
> -                       icsk->icsk_backoff++;
> +               icsk->icsk_backoff++;

I think we need to have a cap, otherwise we risk overflows in
inet_csk_rto_backoff()


>                 timeout =3D tcp_probe0_when(sk, tcp_rto_max(sk));
>         } else {
>                 /* If packet was not sent due to local congestion,
> diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
> index a207877270fb..4dba2928e1bf 100644
> --- a/net/ipv4/tcp_timer.c
> +++ b/net/ipv4/tcp_timer.c
> @@ -419,9 +419,9 @@ static void tcp_probe_timer(struct sock *sk)
>         if (sock_flag(sk, SOCK_DEAD)) {
>                 unsigned int rto_max =3D tcp_rto_max(sk);
>                 const bool alive =3D inet_csk_rto_backoff(icsk, rto_max) =
< rto_max;
> +               int orphan_probes =3D tcp_orphan_retries(sk, alive);
>
> -               max_probes =3D tcp_orphan_retries(sk, alive);
> -               if (!alive && icsk->icsk_backoff >=3D max_probes)
> +               if (!alive || icsk->icsk_backoff >=3D orphan_probes)
>                         goto abort;
>                 if (tcp_out_of_resources(sk, true))
>                         return;
> --
> 2.46.0
>


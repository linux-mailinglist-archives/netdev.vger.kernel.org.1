Return-Path: <netdev+bounces-112612-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7B9D93A2E0
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 16:38:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D9BF1F2448C
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 14:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 571C215572F;
	Tue, 23 Jul 2024 14:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qb5XzUPN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577B814F122
	for <netdev@vger.kernel.org>; Tue, 23 Jul 2024 14:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721745494; cv=none; b=fOG54moj4/bgyIY0dp2KfIs/lZPjSX8XRfAIR3xDUZTHvUQM6kT1rzeER4/tjFuSLSsM7IOQYo5tq+sDMsX+gIQWHeUknFOoreE9Wm11YD3TD8y4WUaHN7RCnTRyWTIc8NYz5pMAXZcvPbjPFRE2QIPDKcYwZhkON+PBBh6jzfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721745494; c=relaxed/simple;
	bh=ff/CkTO/SkIimAhtYkfktjm2JYhVwuqVIfiA0JD5iQM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GwkQ1wyd2zIwgpjPi/SgObYtT7RaCvioEwFeLmyjcxsnyFRWhntpBM/gUvFCxqudgLPC1PCltlS4DLyMbhcRQo7HUdGO2AcXvIhBRTpFv7LfkXKSDpt8xYGtbFnbBHq8OOpXjGU5k0ArCTMg8jx8zU/n7Vt4FlKR3cKmqfXeI7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qb5XzUPN; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5a869e3e9dfso17642a12.0
        for <netdev@vger.kernel.org>; Tue, 23 Jul 2024 07:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721745491; x=1722350291; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ykd4q8hKlp7Yud9vXA9/ALvMC3wTdvW89xFIM92u8u0=;
        b=qb5XzUPNOU5nYRgM5Ue/ihnyuQq9siqEUFX2knZmHqV1nN6spubJAyczzinM+naazb
         2/yExK+sOD3N1Hd4SbVYyyA8Q4WG7up29Xnio4g6FbK3C5fItDZWiqT/ea9lEWeRe4bl
         8aRLRG8i1pTu9WY7d0HPpPeZQDVmxO8COZSw7+3s74PENU5EUpKJTbEGc3r6tlcLs/Hg
         yIGHw44YC6mXlU4uOrjRyeRIyXL0sw4wCGNZztzcxx8+G9z3jUGVNBU5XsZG4xDcaYCQ
         u1Qv5ks+P5sFbj6lKwCGQBKzAppGiPr3DLfcUd5/M63PlLM3ByIM7mUzBpcVwlCVITrr
         K3bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721745491; x=1722350291;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ykd4q8hKlp7Yud9vXA9/ALvMC3wTdvW89xFIM92u8u0=;
        b=rSkBdkreD9BsBrE9kaAvoiRm6sqGBzIUQORv2wCbj1Q+2OfnCdWTX4ZhmNjIGkiUwt
         smEU07Urr4X+Z5zq8+yUWYm1Ya+B0/OZ8+17+t1gCZWLzVIiAzXurYYz0Q9XcjEL6yHy
         KW/0ONy6Rua9n6UuwCExF3FWXOgXmBFsXh9DqpPbT0QRXuls7ZB574xMYDZ8BXY7t+uW
         5bwaKLJxrMT1j2FSgPL5gYyHuIKhw3wNvogUl86cKkJDDAzcyqKJ3s7RF624CoqiqcGV
         1iWk43V85GuZiSbjCiKrLkix7U7nzoFyZXcXrHa/1Xp/hwg9Lwgwh/+8eRmIvXQd5V0O
         pY3A==
X-Forwarded-Encrypted: i=1; AJvYcCWuzT8jQbsI8YDwZ3DHLzqBEHCci//nSQ42vKF4D321o7URAdMFtB/VV3C+Sdo5wJHztn+ZjRwg2A9Nba4kBwRfO5WPQmsZ
X-Gm-Message-State: AOJu0Yygv+VWb8ALltkTxM3qsgm36YTRuoVwUguNT6fWvJ9/9syqHoE5
	HKtEiZZcAdAB1o/SMTl2KiqM8amZhIUe8iXpq+UHusRnuihFNKdhKuLfHgfBlVXzWndGxVvKuzj
	1FJRW0khr5/h9iIjLcNiWb5TIllXhSQGyML09
X-Google-Smtp-Source: AGHT+IGwoVmZuNo0bxnzbHW9EyaVLe/rGxfRwlLABQDaghnJkzA63EuN7jns0D+cHfzTWZM07Q7eRFBHoQHeKElPA6Y=
X-Received: by 2002:a05:6402:27c6:b0:5a1:4658:cb98 with SMTP id
 4fb4d7f45d1cf-5a44fe634f7mr576743a12.0.1721745490199; Tue, 23 Jul 2024
 07:38:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240718-upstream-net-next-20240716-tcp-3rd-ack-consume-sk_socket-v2-0-d653f85639f6@kernel.org>
 <20240718-upstream-net-next-20240716-tcp-3rd-ack-consume-sk_socket-v2-1-d653f85639f6@kernel.org>
In-Reply-To: <20240718-upstream-net-next-20240716-tcp-3rd-ack-consume-sk_socket-v2-1-d653f85639f6@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 23 Jul 2024 16:37:59 +0200
Message-ID: <CANn89iJNa+UqZrONT0tTgN+MjnFZJQQ8zuH=nG+3XRRMjK9TfA@mail.gmail.com>
Subject: Re: [PATCH net v2 1/2] tcp: process the 3rd ACK with sk_socket for TFO/MPTCP
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Jerry Chu <hkchu@google.com>, netdev@vger.kernel.org, 
	mptcp@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 18, 2024 at 12:34=E2=80=AFPM Matthieu Baerts (NGI0)
<matttbe@kernel.org> wrote:
>
> The 'Fixes' commit recently changed the behaviour of TCP by skipping the
> processing of the 3rd ACK when a sk->sk_socket is set. The goal was to
> skip tcp_ack_snd_check() in tcp_rcv_state_process() not to send an
> unnecessary ACK in case of simultaneous connect(). Unfortunately, that
> had an impact on TFO and MPTCP.
>
> I started to look at the impact on MPTCP, because the MPTCP CI found
> some issues with the MPTCP Packetdrill tests [1]. Then Paolo suggested
> me to look at the impact on TFO with "plain" TCP.
>
> For MPTCP, when receiving the 3rd ACK of a request adding a new path
> (MP_JOIN), sk->sk_socket will be set, and point to the MPTCP sock that
> has been created when the MPTCP connection got established before with
> the first path. The newly added 'goto' will then skip the processing of
> the segment text (step 7) and not go through tcp_data_queue() where the
> MPTCP options are validated, and some actions are triggered, e.g.
> sending the MPJ 4th ACK [2] as demonstrated by the new errors when
> running a packetdrill test [3] establishing a second subflow.
>
> This doesn't fully break MPTCP, mainly the 4th MPJ ACK that will be
> delayed. Still, we don't want to have this behaviour as it delays the
> switch to the fully established mode, and invalid MPTCP options in this
> 3rd ACK will not be caught any more. This modification also affects the
> MPTCP + TFO feature as well, and being the reason why the selftests
> started to be unstable the last few days [4].
>
> For TFO, the existing 'basic-cookie-not-reqd' test [5] was no longer
> passing: if the 3rd ACK contains data, and the connection is accept()ed
> before receiving them, these data would no longer be processed, and thus
> not ACKed.
>
> One last thing about MPTCP, in case of simultaneous connect(), a
> fallback to TCP will be done, which seems fine:
>
>   `../common/defaults.sh`
>
>    0 socket(..., SOCK_STREAM|SOCK_NONBLOCK, IPPROTO_MPTCP) =3D 3
>   +0 connect(3, ..., ...) =3D -1 EINPROGRESS (Operation now in progress)
>
>   +0 > S  0:0(0)                 <mss 1460, sackOK, TS val 100 ecr 0,   n=
op, wscale 8, mpcapable v1 flags[flag_h] nokey>
>   +0 < S  0:0(0) win 1000        <mss 1460, sackOK, TS val 407 ecr 0,   n=
op, wscale 8, mpcapable v1 flags[flag_h] nokey>
>   +0 > S. 0:0(0) ack 1           <mss 1460, sackOK, TS val 330 ecr 0,   n=
op, wscale 8, mpcapable v1 flags[flag_h] nokey>
>   +0 < S. 0:0(0) ack 1 win 65535 <mss 1460, sackOK, TS val 700 ecr 100, n=
op, wscale 8, mpcapable v1 flags[flag_h] key[skey=3D2]>
>
>   +0 write(3, ..., 100) =3D 100
>   +0 >  . 1:1(0)     ack 1 <nop, nop, TS val 845707014 ecr 700, nop, nop,=
 sack 0:1>
>   +0 > P. 1:101(100) ack 1 <nop, nop, TS val 845958933 ecr 700>
>
> Simultaneous SYN-data crossing is also not supported by TFO, see [6].
>
> Link: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/993622=
7696 [1]
> Link: https://datatracker.ietf.org/doc/html/rfc8684#fig_tokens [2]
> Link: https://github.com/multipath-tcp/packetdrill/blob/mptcp-net-next/gt=
ests/net/mptcp/syscalls/accept.pkt#L28 [3]
> Link: https://netdev.bots.linux.dev/contest.html?executor=3Dvmksft-mptcp-=
dbg&test=3Dmptcp-connect-sh [4]
> Link: https://github.com/google/packetdrill/blob/master/gtests/net/tcp/fa=
stopen/server/basic-cookie-not-reqd.pkt#L21 [5]
> Link: https://github.com/google/packetdrill/blob/master/gtests/net/tcp/fa=
stopen/client/simultaneous-fast-open.pkt [6]
> Fixes: 23e89e8ee7be ("tcp: Don't drop SYN+ACK for simultaneous connect().=
")
> Suggested-by: Paolo Abeni <pabeni@redhat.com>
> Suggested-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> Notes:
>  - We could also drop this 'goto consume', and send the unnecessary ACK
>    in this simultaneous connect case, which doesn't seem to be a "real"
>    case, more something for fuzzers. But that's not what the RFC 9293
>    recommends to do.
>  - v2:
>    - Check if the SYN bit is set instead of looking for TFO and MPTCP
>      specific attributes, as suggested by Kuniyuki.
>    - Updated the comment above
>    - Please note that the v2 has been sent mainly to satisfy the CI (to
>      be able to catch new bugs with MPTCP), and because the suggestion
>      from Kuniyuki looks better. It has not been sent to urge TCP
>      maintainers to review it quicker than it should, please take your
>      time and enjoy netdev.conf :)
> ---
>  net/ipv4/tcp_input.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index ff9ab3d01ced..bfe1bc69dc3e 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -6820,7 +6820,12 @@ tcp_rcv_state_process(struct sock *sk, struct sk_b=
uff *skb)
>                 if (sk->sk_shutdown & SEND_SHUTDOWN)
>                         tcp_shutdown(sk, SEND_SHUTDOWN);
>
> -               if (sk->sk_socket)
> +               /* For crossed SYN cases, not to send an unnecessary ACK.
> +                * Note that sk->sk_socket can be assigned in other cases=
, e.g.
> +                * with TFO (if accept()'ed before the 3rd ACK) and MPTCP=
 (MPJ:
> +                * sk_socket is the parent MPTCP sock).
> +                */
> +               if (sk->sk_socket && th->syn)
>                         goto consume;

I think we should simply remove this part completely, because we
should send an ack anyway.

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index ff9ab3d01ced89570903d3a9f649a637c5e07a90..91357d4713182078debd746a224=
046cba80ea3ce
100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -6820,8 +6820,6 @@ tcp_rcv_state_process(struct sock *sk, struct
sk_buff *skb)
                if (sk->sk_shutdown & SEND_SHUTDOWN)
                        tcp_shutdown(sk, SEND_SHUTDOWN);

-               if (sk->sk_socket)
-                       goto consume;
                break;

        case TCP_FIN_WAIT1: {


I have a failing packetdrill test after  Kuniyuki  patch :



//
// Test the simultaneous open scenario that both end sends
// SYN/data. Although we don't support that the connection should
// still be established.
//
`../../common/defaults.sh
 ../../common/set_sysctls.py /proc/sys/net/ipv4/tcp_timestamps=3D0`

// Cache warmup: send a Fast Open cookie request
    0 socket(..., SOCK_STREAM, IPPROTO_TCP) =3D 3
   +0 fcntl(3, F_SETFL, O_RDWR|O_NONBLOCK) =3D 0
   +0 sendto(3, ..., 0, MSG_FASTOPEN, ..., ...) =3D -1 EINPROGRESS
(Operation is now in progress)
   +0 > S 0:0(0) <mss 1460,nop,nop,sackOK,nop,wscale 8,FO,nop,nop>
 +.01 < S. 123:123(0) ack 1 win 14600 <mss
1460,nop,nop,sackOK,nop,wscale 6,FO abcd1234,nop,nop>
   +0 > . 1:1(0) ack 1
 +.01 close(3) =3D 0
   +0 > F. 1:1(0) ack 1
 +.01 < F. 1:1(0) ack 2 win 92
   +0 > .  2:2(0) ack 2


//
// Test: simulatenous fast open
//
 +.01 socket(..., SOCK_STREAM, IPPROTO_TCP) =3D 4
   +0 fcntl(4, F_SETFL, O_RDWR|O_NONBLOCK) =3D 0
   +0 sendto(4, ..., 1000, MSG_FASTOPEN, ..., ...) =3D 1000
   +0 > S 0:1000(1000) <mss 1460,nop,nop,sackOK,nop,wscale 8,FO
abcd1234,nop,nop>
// Simul. SYN-data crossing: we don't support that yet so ack only remote I=
SN
+.005 < S 1234:1734(500) win 14600 <mss 1040,nop,nop,sackOK,nop,wscale
6,FO 87654321,nop,nop>
   +0 > S. 0:0(0) ack 1235 <mss 1460,nop,nop,sackOK,nop,wscale 8>

// SYN data is never retried.
+.045 < S. 1234:1234(0) ack 1001 win 14600 <mss
940,nop,nop,sackOK,nop,wscale 6,FO 12345678,nop,nop>
   +0 > . 1001:1001(0) ack 1
// The other end retries
  +.1 < P. 1:501(500) ack 1000 win 257
   +0 > . 1001:1001(0) ack 501
   +0 read(4, ..., 4096) =3D 500
   +0 close(4) =3D 0
   +0 > F. 1001:1001(0) ack 501
 +.05 < F. 501:501(0) ack 1002 win 257
   +0 > . 1002:1002(0) ack 502

`/tmp/sysctl_restore_${PPID}.sh`


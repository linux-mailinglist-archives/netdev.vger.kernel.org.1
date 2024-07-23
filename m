Return-Path: <netdev+bounces-112627-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6D0193A3D0
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 17:38:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5C9C1C22C88
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 15:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E34DE156F5F;
	Tue, 23 Jul 2024 15:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qhQkWB7C"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85FD01534FB
	for <netdev@vger.kernel.org>; Tue, 23 Jul 2024 15:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721749124; cv=none; b=nsl3S7kelXpvJDB0qRGwazQMZ5qXNy53bNa93L2/MNAAejeTjdws9aMtqkz6cPq8nY5XWBKnC5+SZeti7v+WxfVJ8YH75Vf62wS4yhqLXNB6ScpjbHzdjq6ca+CcP8YA3EtejC5i9hNALMKPdNW7FhY6Br61QqQH2ieXZuXNOFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721749124; c=relaxed/simple;
	bh=6OZcCAIpS1aeAiWmCR1XKoITuZ3DnqE9fl+e4cu2qeU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dRx8BJCJ0P4VZMDRJMtgGLsgN6Hf3eLQhOrtDmCHKJtkDm+E1vqO1Bg+KN4gYPkeEMS/MaVnwAdK8NVUfL7+nxCKLrEVqvolKbPg9x/cx5Zfv0zPhGg1Ky1mNnXOG6yghAWY4HbEgpZRDJP2hX5CG+6xI6P8Den0eirOAvF4hww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qhQkWB7C; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4266f796e67so37955e9.1
        for <netdev@vger.kernel.org>; Tue, 23 Jul 2024 08:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721749120; x=1722353920; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ipWJ/SqKwPa5tIGo6EOPErBuJvbnltaOYoypdwVloM=;
        b=qhQkWB7CILBJauylZoQYMBlhpbRst00kl1zhSdbolsCxvrfTz6befRzkxYi2seIFr+
         nbfd90uDLzgJYJudRwmN8K6N7P/WfamOnqdwYQc7WtcWcF7UHSV3ICXzfR/Aql554XRC
         ju3UoAEXfB3ovl3kybi6Wn21uyzw14W3fjHKzvJWJecxJU9jnl21k8g2LvxYos1/iLty
         yMxUVNHxw8GsHQwLfxJ7riqfdjrAaHypOiveb1L4/AkONcrXtSNydz5d3RQ8FOrUtH8W
         GjQ2HFbc580dqA5C6hc15XFrq8UF3O1k30AU2C2sx0T1lXswOk6jdmSXTVGUAVKYs9Xa
         iNnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721749120; x=1722353920;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7ipWJ/SqKwPa5tIGo6EOPErBuJvbnltaOYoypdwVloM=;
        b=pZCoqXBegKm5a+lqAKvkKvVRkCUIhrzbDIOsn6P0H/4FOZVT5Sv7Du/j7uPep6otfl
         bWHJZLkxoklUFEBWcWO4APr0r37+xd8QVYw0vASv4txLRGPSuhCsIFTCNgNBuY4nOB1Z
         4ghttp90M5UxwzMqAsvmWDPpzBlpwRlJ/AzvijBzSqkcvuTYONaoee6lTwriWjSxuV6T
         wpwO41MnYTQrfHzc6byAUeYdwrQSBOVfxNJrFVYfqQPzdEY2zhLWf3NrCBoa2gCIa4S7
         OuCEPBCgqA3tWmeIYIPaELXLXykwF8ybky/Rqggy3pvEJlVz4jsz7KmHFuckJMbeKZ73
         DmYA==
X-Forwarded-Encrypted: i=1; AJvYcCU580YXJYbksSq9rHGYTHMRNI4OrQCWP2x9PoR7jqZoHY789WL+Dv6HzvnunVTP0YL5GsDD42M6xd012w7Q0PRPEZHZMtkG
X-Gm-Message-State: AOJu0YylGgSQqOM40zkXTPF0Mbf5VzFLiYNW/NMjEM+sfhyVcCUI1/1u
	UR1gSrCLLlvUoFIaLny8FimQVbrN6XuGT48aPNgkq+hXPcAa6LVC5D3rHCNK6XxPP7TUAX2ZeKP
	ZctIwVdxtOK6uLgNVlDXE6XGdz9RgRwKxEtTr
X-Google-Smtp-Source: AGHT+IHSriSprYOSqcJ4hJtEEmbw5WzLt0KkfwnP/jrBUqRB6CaYyWKWeFOEBn71z8rcLTO4keC4GB5As5QxNinte2I=
X-Received: by 2002:a05:600c:1c03:b0:41a:444b:e1d9 with SMTP id
 5b1f17b1804b1-427dbb47c0emr4585065e9.4.1721749119432; Tue, 23 Jul 2024
 08:38:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240718-upstream-net-next-20240716-tcp-3rd-ack-consume-sk_socket-v2-0-d653f85639f6@kernel.org>
 <20240718-upstream-net-next-20240716-tcp-3rd-ack-consume-sk_socket-v2-1-d653f85639f6@kernel.org>
 <CANn89iJNa+UqZrONT0tTgN+MjnFZJQQ8zuH=nG+3XRRMjK9TfA@mail.gmail.com> <2583642a-cc5f-4765-856d-4340adcecf33@kernel.org>
In-Reply-To: <2583642a-cc5f-4765-856d-4340adcecf33@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 23 Jul 2024 17:38:27 +0200
Message-ID: <CANn89iKP4y7iMHxsy67o13Eair+tDquGPBr=kS41zPbKz+_0iQ@mail.gmail.com>
Subject: Re: [PATCH net v2 1/2] tcp: process the 3rd ACK with sk_socket for TFO/MPTCP
To: Matthieu Baerts <matttbe@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, netdev@vger.kernel.org, mptcp@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Neal Cardwell <ncardwell@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 23, 2024 at 4:58=E2=80=AFPM Matthieu Baerts <matttbe@kernel.org=
> wrote:
>
> Hi Eric,
>
> +cc Neal
> -cc Jerry (NoSuchUser)
>
> On 23/07/2024 16:37, Eric Dumazet wrote:
> > On Thu, Jul 18, 2024 at 12:34=E2=80=AFPM Matthieu Baerts (NGI0)
> > <matttbe@kernel.org> wrote:
> >>
> >> The 'Fixes' commit recently changed the behaviour of TCP by skipping t=
he
> >> processing of the 3rd ACK when a sk->sk_socket is set. The goal was to
> >> skip tcp_ack_snd_check() in tcp_rcv_state_process() not to send an
> >> unnecessary ACK in case of simultaneous connect(). Unfortunately, that
> >> had an impact on TFO and MPTCP.
> >>
> >> I started to look at the impact on MPTCP, because the MPTCP CI found
> >> some issues with the MPTCP Packetdrill tests [1]. Then Paolo suggested
> >> me to look at the impact on TFO with "plain" TCP.
> >>
> >> For MPTCP, when receiving the 3rd ACK of a request adding a new path
> >> (MP_JOIN), sk->sk_socket will be set, and point to the MPTCP sock that
> >> has been created when the MPTCP connection got established before with
> >> the first path. The newly added 'goto' will then skip the processing o=
f
> >> the segment text (step 7) and not go through tcp_data_queue() where th=
e
> >> MPTCP options are validated, and some actions are triggered, e.g.
> >> sending the MPJ 4th ACK [2] as demonstrated by the new errors when
> >> running a packetdrill test [3] establishing a second subflow.
> >>
> >> This doesn't fully break MPTCP, mainly the 4th MPJ ACK that will be
> >> delayed. Still, we don't want to have this behaviour as it delays the
> >> switch to the fully established mode, and invalid MPTCP options in thi=
s
> >> 3rd ACK will not be caught any more. This modification also affects th=
e
> >> MPTCP + TFO feature as well, and being the reason why the selftests
> >> started to be unstable the last few days [4].
> >>
> >> For TFO, the existing 'basic-cookie-not-reqd' test [5] was no longer
> >> passing: if the 3rd ACK contains data, and the connection is accept()e=
d
> >> before receiving them, these data would no longer be processed, and th=
us
> >> not ACKed.
> >>
> >> One last thing about MPTCP, in case of simultaneous connect(), a
> >> fallback to TCP will be done, which seems fine:
> >>
> >>   `../common/defaults.sh`
> >>
> >>    0 socket(..., SOCK_STREAM|SOCK_NONBLOCK, IPPROTO_MPTCP) =3D 3
> >>   +0 connect(3, ..., ...) =3D -1 EINPROGRESS (Operation now in progres=
s)
> >>
> >>   +0 > S  0:0(0)                 <mss 1460, sackOK, TS val 100 ecr 0, =
  nop, wscale 8, mpcapable v1 flags[flag_h] nokey>
> >>   +0 < S  0:0(0) win 1000        <mss 1460, sackOK, TS val 407 ecr 0, =
  nop, wscale 8, mpcapable v1 flags[flag_h] nokey>
> >>   +0 > S. 0:0(0) ack 1           <mss 1460, sackOK, TS val 330 ecr 0, =
  nop, wscale 8, mpcapable v1 flags[flag_h] nokey>
> >>   +0 < S. 0:0(0) ack 1 win 65535 <mss 1460, sackOK, TS val 700 ecr 100=
, nop, wscale 8, mpcapable v1 flags[flag_h] key[skey=3D2]>
> >>
> >>   +0 write(3, ..., 100) =3D 100
> >>   +0 >  . 1:1(0)     ack 1 <nop, nop, TS val 845707014 ecr 700, nop, n=
op, sack 0:1>
> >>   +0 > P. 1:101(100) ack 1 <nop, nop, TS val 845958933 ecr 700>
> >>
> >> Simultaneous SYN-data crossing is also not supported by TFO, see [6].
> >>
> >> Link: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/993=
6227696 [1]
> >> Link: https://datatracker.ietf.org/doc/html/rfc8684#fig_tokens [2]
> >> Link: https://github.com/multipath-tcp/packetdrill/blob/mptcp-net-next=
/gtests/net/mptcp/syscalls/accept.pkt#L28 [3]
> >> Link: https://netdev.bots.linux.dev/contest.html?executor=3Dvmksft-mpt=
cp-dbg&test=3Dmptcp-connect-sh [4]
> >> Link: https://github.com/google/packetdrill/blob/master/gtests/net/tcp=
/fastopen/server/basic-cookie-not-reqd.pkt#L21 [5]
> >> Link: https://github.com/google/packetdrill/blob/master/gtests/net/tcp=
/fastopen/client/simultaneous-fast-open.pkt [6]
> >> Fixes: 23e89e8ee7be ("tcp: Don't drop SYN+ACK for simultaneous connect=
().")
> >> Suggested-by: Paolo Abeni <pabeni@redhat.com>
> >> Suggested-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> >> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> >> ---
> >> Notes:
> >>  - We could also drop this 'goto consume', and send the unnecessary AC=
K
> >>    in this simultaneous connect case, which doesn't seem to be a "real=
"
> >>    case, more something for fuzzers. But that's not what the RFC 9293
> >>    recommends to do.
> >>  - v2:
> >>    - Check if the SYN bit is set instead of looking for TFO and MPTCP
> >>      specific attributes, as suggested by Kuniyuki.
> >>    - Updated the comment above
> >>    - Please note that the v2 has been sent mainly to satisfy the CI (t=
o
> >>      be able to catch new bugs with MPTCP), and because the suggestion
> >>      from Kuniyuki looks better. It has not been sent to urge TCP
> >>      maintainers to review it quicker than it should, please take your
> >>      time and enjoy netdev.conf :)
> >> ---
> >>  net/ipv4/tcp_input.c | 7 ++++++-
> >>  1 file changed, 6 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> >> index ff9ab3d01ced..bfe1bc69dc3e 100644
> >> --- a/net/ipv4/tcp_input.c
> >> +++ b/net/ipv4/tcp_input.c
> >> @@ -6820,7 +6820,12 @@ tcp_rcv_state_process(struct sock *sk, struct s=
k_buff *skb)
> >>                 if (sk->sk_shutdown & SEND_SHUTDOWN)
> >>                         tcp_shutdown(sk, SEND_SHUTDOWN);
> >>
> >> -               if (sk->sk_socket)
> >> +               /* For crossed SYN cases, not to send an unnecessary A=
CK.
> >> +                * Note that sk->sk_socket can be assigned in other ca=
ses, e.g.
> >> +                * with TFO (if accept()'ed before the 3rd ACK) and MP=
TCP (MPJ:
> >> +                * sk_socket is the parent MPTCP sock).
> >> +                */
> >> +               if (sk->sk_socket && th->syn)
> >>                         goto consume;
> >
> > I think we should simply remove this part completely, because we
> > should send an ack anyway.
>
> Thank you for having looked, and ran the full packetdrill test suite!
>
> >
> > diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> > index ff9ab3d01ced89570903d3a9f649a637c5e07a90..91357d4713182078debd746=
a224046cba80ea3ce
> > 100644
> > --- a/net/ipv4/tcp_input.c
> > +++ b/net/ipv4/tcp_input.c
> > @@ -6820,8 +6820,6 @@ tcp_rcv_state_process(struct sock *sk, struct
> > sk_buff *skb)
> >                 if (sk->sk_shutdown & SEND_SHUTDOWN)
> >                         tcp_shutdown(sk, SEND_SHUTDOWN);
> >
> > -               if (sk->sk_socket)
> > -                       goto consume;
> >                 break;
> >
> >         case TCP_FIN_WAIT1: {
> >
> >
> > I have a failing packetdrill test after  Kuniyuki  patch :
> >
> >
> >
> > //
> > // Test the simultaneous open scenario that both end sends
> > // SYN/data. Although we don't support that the connection should
> > // still be established.
> > //
> > `../../common/defaults.sh
> >  ../../common/set_sysctls.py /proc/sys/net/ipv4/tcp_timestamps=3D0`
> >
> > // Cache warmup: send a Fast Open cookie request
> >     0 socket(..., SOCK_STREAM, IPPROTO_TCP) =3D 3
> >    +0 fcntl(3, F_SETFL, O_RDWR|O_NONBLOCK) =3D 0
> >    +0 sendto(3, ..., 0, MSG_FASTOPEN, ..., ...) =3D -1 EINPROGRESS
> > (Operation is now in progress)
> >    +0 > S 0:0(0) <mss 1460,nop,nop,sackOK,nop,wscale 8,FO,nop,nop>
> >  +.01 < S. 123:123(0) ack 1 win 14600 <mss
> > 1460,nop,nop,sackOK,nop,wscale 6,FO abcd1234,nop,nop>
> >    +0 > . 1:1(0) ack 1
> >  +.01 close(3) =3D 0
> >    +0 > F. 1:1(0) ack 1
> >  +.01 < F. 1:1(0) ack 2 win 92
> >    +0 > .  2:2(0) ack 2
> >
> >
> > //
> > // Test: simulatenous fast open
> > //
> >  +.01 socket(..., SOCK_STREAM, IPPROTO_TCP) =3D 4
> >    +0 fcntl(4, F_SETFL, O_RDWR|O_NONBLOCK) =3D 0
> >    +0 sendto(4, ..., 1000, MSG_FASTOPEN, ..., ...) =3D 1000
> >    +0 > S 0:1000(1000) <mss 1460,nop,nop,sackOK,nop,wscale 8,FO
> > abcd1234,nop,nop>
> > // Simul. SYN-data crossing: we don't support that yet so ack only remo=
te ISN
> > +.005 < S 1234:1734(500) win 14600 <mss 1040,nop,nop,sackOK,nop,wscale
> > 6,FO 87654321,nop,nop>
> >    +0 > S. 0:0(0) ack 1235 <mss 1460,nop,nop,sackOK,nop,wscale 8>
> >
> > // SYN data is never retried.
> > +.045 < S. 1234:1234(0) ack 1001 win 14600 <mss
> > 940,nop,nop,sackOK,nop,wscale 6,FO 12345678,nop,nop>
> >    +0 > . 1001:1001(0) ack 1
>
> I recently sent a PR -- already applied -- to Neal to remove this line:
>
>   https://github.com/google/packetdrill/pull/86
>
> I thought it was the intension of Kuniyuki's patch not to send this ACK
> in this case to follow the RFC 9293's recommendation. This TFO test
> looks a bit similar to the example from Kuniyuki's patch:
>
>
> --------------- 8< ---------------
>  0 socket(..., SOCK_STREAM|SOCK_NONBLOCK, IPPROTO_TCP) =3D 3
> +0 connect(3, ..., ...) =3D -1 EINPROGRESS (Operation now in progress)
>
> +0 > S  0:0(0) <mss 1460,sackOK,TS val 1000 ecr 0,nop,wscale 8>
> +0 < S  0:0(0) win 1000 <mss 1000>
> +0 > S. 0:0(0) ack 1 <mss 1460,sackOK,TS val 3308134035 ecr 0,nop,wscale =
8>
> +0 < S. 0:0(0) ack 1 win 1000
>
>   /* No ACK here */
>
> +0 write(3, ..., 100) =3D 100
> +0 > P. 1:101(100) ack 1
> --------------- 8< ---------------
>
>
>
> But maybe here that should be different for TFO?
>
> For my case with MPTCP (and TFO), it is fine to drop this 'goto consume'
> but I don't know how "strict" we want to be regarding the RFC and this
> marginal case.

Problem of this 'goto consume' is that we are not properly sending a
DUPACK in this case.

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

+.045 < S. 1234:1234(0) ack 1001 win 14600 <mss
940,nop,nop,sackOK,nop,wscale 6,FO 12345678,nop,nop>
   +0 > . 1001:1001(0) ack 1 <nop,nop,sack 0:1>  // See here

Not sending a dupack seems wrong and could hurt.

I had reservations about this part, if you look back to the discussion.

This is why Kuniyuki added in his changelog :

    Note that tcp_ack_snd_check() in tcp_rcv_state_process() is skipped not=
 to
    send an unnecessary ACK, but this could be a bit risky for net.git, so =
this
    targets for net-next.


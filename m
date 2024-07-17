Return-Path: <netdev+bounces-111886-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4808D933EE5
	for <lists+netdev@lfdr.de>; Wed, 17 Jul 2024 16:58:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4461B22546
	for <lists+netdev@lfdr.de>; Wed, 17 Jul 2024 14:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EBDD1802DF;
	Wed, 17 Jul 2024 14:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="x7vQZUH/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94FC181330
	for <netdev@vger.kernel.org>; Wed, 17 Jul 2024 14:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721228297; cv=none; b=OOxtF8AVhw+Z73BuRppMPc5L4OMiM+2HkxsXW3th27NitUgFXcg9TVwo9kGAKJQfoBGTYvjHElZWORqwgBOYSAWH1bl5bwRDROQkga/XGrqXob2b8m+A3TifRxwFJaPrzWMzt9KonccjwxT2SEp0iG207p+YE/MM/CXmWk9DM2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721228297; c=relaxed/simple;
	bh=dpjUFS34+Kn5fyMlt2g900XkmwZUM84v+Sue8ykQgOE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dz9XSVnQdT6AsHzHWarEikzK+Sv41/N3yN4u8+Ey7My8ZqqIZ9UNDk3DKZMcx9P3yWiYHHzpnZhhs5ZCft7zS/rlf/oMHdyBwk2JpNYILRGEO11ruoY24huJfFhMM5HS6nQaDTjxOf5hHwt7+GRkMFbwHgvwqqIV/5FGeXTW4w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=x7vQZUH/; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-58ce966a1d3so13516a12.1
        for <netdev@vger.kernel.org>; Wed, 17 Jul 2024 07:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721228294; x=1721833094; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PQSNc99mSLlBbaOi1xCED/nnBkGtLUEtseNxdNSuNO8=;
        b=x7vQZUH/EojQy7KTDvzf/1k2FAicPp/uGk0NiRe0Sq1r7VEzqyfISdZweOjqS8V+l+
         wIimHz3Ixlz4ZWULWMbDuZStdfG/zim8t0Jh5haYichvXEQGfhPS4KjlUT3u0NqAWLBr
         YdkAYEg6pyEs144Fs8FoqvlGAxwK5UpTr3rJ1vNyf3+9GC/6NzbEldvaDLoVwju3FNgR
         qQpR7mGwcr71lKBJlhfbQysg+vvsd7nN/hVJw8r2wrLgrzhRFENPxL0dZv2T196COYq9
         3YNEMRL4f2HxR7KVAR/JYajI5V9GgzW/D+iADAighkpTAyavOszswAInJfR4fVLKebd/
         Z6hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721228294; x=1721833094;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PQSNc99mSLlBbaOi1xCED/nnBkGtLUEtseNxdNSuNO8=;
        b=U6DdiWc8hkyCprD5Dh3ILQY284fi7pQdvcjAYkNUWf/28qOrxnG3xwBZpO0tZVog0Y
         pYbelBA5S1vrbAdnl3MKfySGhlCaOdO66PN2Df5hxqJbqT/ItHDbTDer/5r8DRDTtsls
         Sn+5cvzqL7kGgQdA53r/OlBrMLkQ0RDirH5FRrOGbGz4Z2UuLUJKXWVvcYAAE3NFGsLo
         xo8KFmdtJsAn61aGZSSc9sEE3hGQXWdhav9Mn9jkpJOKxPahlXbHjnWdAvreN5KH4p4y
         FrM54lVEqf+gcWzNp9EdBioDIV8VzAi7xwzRHtsyK7TyJag/COVNgdHO5uFd2jrvsRuF
         BfvQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2TeCJ6UEtOF7wfCwQIuiT7s3xg4s6LrdsirXI6NAktu3nIol2T8spT3RbQSrPUrIcZmHr2hZ2JSipEw8fnURv5ktQFcMm
X-Gm-Message-State: AOJu0Yxvm8b1VOWWAhOjHFtrccKccICqMx2aZJmz2OER/BDzI28wfTOb
	bb4fWDRn+qN2HGnxXug6yp+wissB608J8u5QGUwxB6HOuqS0aISRYJnbc0TbbbNu1IDzIPZYA3g
	u4rZUGcy34evYrod2EATVzd3GzfgdiWTEoIDK
X-Google-Smtp-Source: AGHT+IFiGEvyTzeYTN0dVhUmIpZZx/yHVA3uop/MuC3ufQZ/Oxya9cPJoO2sp/D/qKluIbTjfrLOEDl73SAIjX/CGhA=
X-Received: by 2002:a50:9f6e:0:b0:57c:bb0d:5e48 with SMTP id
 4fb4d7f45d1cf-5a018b20444mr280272a12.2.1721228293562; Wed, 17 Jul 2024
 07:58:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240716-upstream-net-next-20240716-tcp-3rd-ack-consume-sk_socket-v1-1-4e61d0b79233@kernel.org>
In-Reply-To: <20240716-upstream-net-next-20240716-tcp-3rd-ack-consume-sk_socket-v1-1-4e61d0b79233@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 17 Jul 2024 07:57:58 -0700
Message-ID: <CANn89iKrHnzuHpRn0fi6+2WB_wxi5r-HpZ2jrkhrZEPyhBe0HQ@mail.gmail.com>
Subject: Re: [PATCH net] tcp: process the 3rd ACK with sk_socket for for TFO/MPTCP
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, Neal Cardwell <ncardwell@google.com>
Cc: mptcp@lists.linux.dev, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 16, 2024 at 12:43=E2=80=AFPM Matthieu Baerts (NGI0)
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
> passing: if the 3rd ACK contains data, these data would no longer be
> processed, and thus not ACKed.
>
> Note that for MPTCP, in case of simultaneous connect(), a fallback to
> TCP will be done, which seems fine:
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
> Link: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/993622=
7696 [1]
> Link: https://datatracker.ietf.org/doc/html/rfc8684#fig_tokens [2]
> Link: https://github.com/multipath-tcp/packetdrill/blob/mptcp-net-next/gt=
ests/net/mptcp/syscalls/accept.pkt#L28 [3]
> Link: https://netdev.bots.linux.dev/contest.html?executor=3Dvmksft-mptcp-=
dbg&test=3Dmptcp-connect-sh [4]
> Link: https://github.com/google/packetdrill/blob/master/gtests/net/tcp/fa=
stopen/server/basic-cookie-not-reqd.pkt#L21 [5]
> Fixes: 23e89e8ee7be ("tcp: Don't drop SYN+ACK for simultaneous connect().=
")
> Suggested-by: Paolo Abeni <pabeni@redhat.com>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> Notes:
>  - We could also drop this 'goto consume', and send the unnecessary ACK
>    in this simultaneous connect case, which doesn't seem to be a "real"
>    case, more something for fuzzers.
>  - When sending this patch, the 'Fixes' commit is only in net-next, this
>    patch is then on top of net-next. But because net-next will be merged
>    into -net soon -- judging by the PR that has been sent to Linus a few
>    hours ago -- the 'net' prefix is then used.
> ---
>  net/ipv4/tcp_input.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index ff9ab3d01ced..a89b3ee57d8c 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -6820,7 +6820,13 @@ tcp_rcv_state_process(struct sock *sk, struct sk_b=
uff *skb)
>                 if (sk->sk_shutdown & SEND_SHUTDOWN)
>                         tcp_shutdown(sk, SEND_SHUTDOWN);
>
> -               if (sk->sk_socket)
> +               /* In simult-connect cases, sk_socket will be assigned. B=
ut also
> +                * with TFO and MPTCP (MPJ) while they required further
> +                * processing later in tcp_data_queue().
> +                */
> +               if (sk->sk_socket &&
> +                   TCP_SKB_CB(skb)->seq =3D=3D TCP_SKB_CB(skb)->end_seq =
&&
> +                   !sk_is_mptcp(sk))
>                         goto consume;
>                 break;
>

Hi Matthieu

I had no time yet to run all our packetdrill tests with Kuniyuki patch
because of the ongoing netdev conference.

Is it ok for you if we hold your patch for about 5 days ?

I would like to make sure we did not miss anything else.

I am CCing Neal, perhaps he can help to expedite the testing part
while I am busy.

Thanks !


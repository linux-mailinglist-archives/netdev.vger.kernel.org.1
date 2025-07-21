Return-Path: <netdev+bounces-208615-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45E03B0C58F
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 15:52:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7015116A7FB
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 13:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D43502D6417;
	Mon, 21 Jul 2025 13:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sEhlvA3x"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF2347F4A
	for <netdev@vger.kernel.org>; Mon, 21 Jul 2025 13:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753105964; cv=none; b=ViCSisNJQirGM5tXacSQol29NF58SRiNb/0UnIn8ZO+uSyP0y8KPanH3bqg5CKZTo5bbY0ZkXYEqLr4uQWE6wgdbzWBj70wUo7mV7pOOOY6GXeeIUwwzHK9Wpl5jsXBOCfzqZySQSAq5zc/gQSEk0QIJd8Kt/xQM8Uh7uQrkzSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753105964; c=relaxed/simple;
	bh=WUEb8W4Q5ZR35WB3dQ/VC3fecA4xNAyaCoWSQ37d/MM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eckf4Vm1tACsnH1FouD+0XFso0PqfYqhGE9cCJG6DJv56zGzfyAJmZWJmiPvZBgAOHk4QJgUHDQ5Be2xFcEjp7w+BZlI0zLQdxLBG3d9OYmuFnkd1rRssm+2ycfQQAUDTHFMshrDu5Q2/P+NrFi013+NKcRe3NWCY29cSIXq4zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sEhlvA3x; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4ab814c4f2dso84384771cf.1
        for <netdev@vger.kernel.org>; Mon, 21 Jul 2025 06:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753105962; x=1753710762; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vImXdH5ze+05JItxGqglL8657yTxHBGyzhMbm2p+EpI=;
        b=sEhlvA3xMIpJqCsmqhyna/L/A3QpypjqW6qsm6tU/wsFmVtc6iMxXQiK4Z9cYMX42r
         E+EmRwRF41dtoMdeSTVosdRbkVJ1r99S9d+I/iEomkpHMfXcSRqlwyYHj11YPQnd7pOb
         jDWUXgGK86F1kPieAZwlwCuE/h7pL7OhW+cHdyausXOw8H1HDZ1aSXw3wRj6URP9SeLe
         qPlCMyhRAt8uspOggnL0HzLRD64JxEiPhCkLzgBk0xBS4LI7qTr6xD0YcfmH0sw1zAOS
         TPvkdxsFHABXXIxdQwUF5qp31C/ZYombm/BCpHhZLggj0HZfeDI+r0vjZQrungpI5L54
         zOhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753105962; x=1753710762;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vImXdH5ze+05JItxGqglL8657yTxHBGyzhMbm2p+EpI=;
        b=TiQQWZp4KybE0k2E2FFrZvwmLwhA+AVb5OaD0ZLZ+SgLihRT6l6ZxlK6N85b3YvTpw
         X9UFVDeHXUiXasmnZ0xVbnCbJQ+FtbGhAoBtztLSIENuWZlPvEEJJTi5TlEIrmo0cM2f
         8Pv8HccFk7iuN02PWlFm+t7zXn0NOxANwwlkvYpf9jH0NEJ7dHRum9ZuaQ7wkXOpD4wq
         q7aGjR212HQE81zEQSnnIEQ3oX+5RJBVZ4nkRDnBZjYATfZy2yBOX2JCfByIuFhjxopK
         d55WjZC3gLG3dCD9Lffr9KwJdvp+QZ+sstfH4fK+vg+GlQG3FwhWha8mCkJRLQgKqQiU
         82AA==
X-Gm-Message-State: AOJu0YxDA881gJAWz+/ko5/VrhxzWc1gogguPv9O6TTAk7xtDQvBOVDi
	PWPnu6D3fvTrR6XkcXpySRiXQQGEzoPaf+2HBubR9EYBa16XdKGZ+hNs543zUNlPaUkthdIjRmV
	qLn5sOkKs8O2aUd6X8RP7NdJ5ttPVQdD9A9/ZnVyh
X-Gm-Gg: ASbGncsP4rCZjBCViO5e2hbzYfoNH4U6jfMIxNi7XCy29zjrLHWpl2VUIh39wCBnb5x
	skuTlwZxIGZ64VNpK1lAoUCALJPpQ5inGb8+I7dVQN5ZOsM2BlQqlJhd8dTSekLP42cjbm+RtF8
	BViLiXdH6ozpFn7dD3V2Ss6SH6gNtkCel4Y1UzPWDfQfFVgEwuxKZLDwXTsTPZlTvxCQgEfAA6d
	o16jGE=
X-Google-Smtp-Source: AGHT+IFFRQCGv101tu7HK1l/bW6r4psvTYyAbs8FMcb+sActbBYgI5+eOuXX9Rp1ev/kBE5aMMKj9GFSedRhl/HCd68=
X-Received: by 2002:ac8:5a49:0:b0:4ab:c0ec:6236 with SMTP id
 d75a77b69052e-4abc0ec6373mr129680991cf.12.1753105961829; Mon, 21 Jul 2025
 06:52:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1752859383.git.pabeni@redhat.com> <3e080bdba9981988ff86e120df40a5f0dc6cd033.1752859383.git.pabeni@redhat.com>
 <CANn89i+KCsw+LH1X1yzmgr1wg5Vxm47AbAEOeOnY5gqq4ngH4w@mail.gmail.com>
 <f8178814-cf90-4021-a3e2-f2494dbf982a@redhat.com> <CANn89i+baSpvbJM6gcbSjZMmWVyvwsFotvH1czui9ARVRjS5Bw@mail.gmail.com>
 <ebc7890c-e239-4a64-99af-df5053245b28@redhat.com>
In-Reply-To: <ebc7890c-e239-4a64-99af-df5053245b28@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 21 Jul 2025 06:52:30 -0700
X-Gm-Features: Ac12FXyrx6bC5_lhIoiLwP_s7oUh93NYkDRGZPPqgKNuTgAfTahP_TnJRkyhyc0
Message-ID: <CANn89iJeXXJV-D5g3+hqStM1sH0UZ3jDeZmOu9mM_E_i9ZYaeA@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] tcp: do not set a zero size receive buffer
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, 
	Matthieu Baerts <matttbe@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 21, 2025 at 6:32=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 7/21/25 2:30 PM, Eric Dumazet wrote:
> > On Mon, Jul 21, 2025 at 3:50=E2=80=AFAM Paolo Abeni <pabeni@redhat.com>=
 wrote:
> >> On 7/21/25 10:04 AM, Eric Dumazet wrote:
> >>> On Fri, Jul 18, 2025 at 10:25=E2=80=AFAM Paolo Abeni <pabeni@redhat.c=
om> wrote:
> >>>>
> >>>> The nipa CI is reporting frequent failures in the mptcp_connect
> >>>> self-tests.
> >>>>
> >>>> In the failing scenarios (TCP -> MPTCP) the involved sockets are
> >>>> actually plain TCP ones, as fallback for passive socket at 2whs
> >>>> time cause the MPTCP listener to actually create a TCP socket.
> >>>>
> >>>> The transfer is stuck due to the receiver buffer being zero.
> >>>> With the stronger check in place, tcp_clamp_window() can be invoked
> >>>> while the TCP socket has sk_rmem_alloc =3D=3D 0, and the receive buf=
fer
> >>>> will be zeroed, too.
> >>>>
> >>>> Pass to tcp_clamp_window() even the current skb truesize, so that
> >>>> such helper could compute and use the actual limit enforced by
> >>>> the stack.
> >>>>
> >>>> Fixes: 1d2fbaad7cd8 ("tcp: stronger sk_rcvbuf checks")
> >>>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> >>>> ---
> >>>>  net/ipv4/tcp_input.c | 12 ++++++------
> >>>>  1 file changed, 6 insertions(+), 6 deletions(-)
> >>>>
> >>>> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> >>>> index 672cbfbdcec1..c98de02a3c57 100644
> >>>> --- a/net/ipv4/tcp_input.c
> >>>> +++ b/net/ipv4/tcp_input.c
> >>>> @@ -610,24 +610,24 @@ static void tcp_init_buffer_space(struct sock =
*sk)
> >>>>  }
> >>>>
> >>>>  /* 4. Recalculate window clamp after socket hit its memory bounds. =
*/
> >>>> -static void tcp_clamp_window(struct sock *sk)
> >>>> +static void tcp_clamp_window(struct sock *sk, int truesize)
> >>>
> >>>
> >>> I am unsure about this one. truesize can be 1MB here, do we want that
> >>> in general ?
> >>
> >> I'm unsure either. But I can't think of a different approach?!? If the
> >> incoming truesize is 1M the socket should allow for at least 1M rcvbuf
> >> size to accept it, right?
> >
> > What I meant was :
> >
> > This is the generic point, accepting skb->truesize as additional input
> > here would make us more vulnerable, or we could risk other
> > regressions.
>
> Understood, thanks for the clarification.
>
> > The question is : why does MPTCP end up here in the first place.
> > Perhaps an older issue with an incorrectly sized sk_rcvbuf ?
>
> I collected a few more data. The issue happens even with plain TCP
> sockets[1].
>
> The relevant transfer is on top of the loopback device. The scaling_rate
> rapidly grows to 254 - that is `truesize` and `len` are very near.
>
> The stall happens when the received get in a packet with a slightly less
> 'efficient' layout (in the experiment I have handy len is 71424,
> truesize 72320) (almost) filling the receiver window.
>
> On such input, tcp_clamp_window() shrinks the receiver buffer to the
> current rmem usage. The same happens on retransmissions until rcvbuf
> becomes 0.
>
> I *think* that catching only the !sk_rmem_alloc case would avoid the
> stall, but I think it's a bit 'late'.

A packetdrill test here would help understanding your concern.

> I'm unsure if we could
> preventing/forbidding 'too high' values of scaling_rate? (also I'm
> unsure where to draw the line exactly.

Indeed we need to account for a possible variation (ie reduction) of
skb->len/skb->truesize ratio in future packets.

Note that whatever conservative change we make, it will always be
possible to feed packets until RWIN 0 is sent back,
eventually after a bump caused by a prune operation.

Imagine wscale is 8, and a prior RWIN 1 was sent.

Normally we should be able to receive a packet with 256 bytes of
payload, but typical skb->truesize
will be 256+512+4096 (for a NIC driver using 4K pages).

This is one of the reasons we force wscale to 12 in Google DC :)

>
> Cheers,
>
> Paolo
>
>
> [1] You can run the relevant test by adding '-t' on the mptcp_connect.sh
> command line, but it will take a lot of time to run the 10-20 iterations
> I need to observe the issue. To make it faster I manually trimmed the
> not relevant test-cases.
>


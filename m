Return-Path: <netdev+bounces-208637-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36840B0C770
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 17:21:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D480418958CB
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 15:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E4DF2DC33A;
	Mon, 21 Jul 2025 15:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wpnjkNtE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D01728F95E
	for <netdev@vger.kernel.org>; Mon, 21 Jul 2025 15:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753111313; cv=none; b=cVtszZYNhPwgwHMjuH96G96SWFg5dU0Ejr6ZpNS8NqY5zK6UGkrNLjqpUdmVrxEdROMFyG5qD8N3naIYPyCtbxx8FMem6RRNIyuIIr0FIu88ViIohdOObhbDUcwujx8wjyOm7le/mBjsOI4tfHrID22KpksHHOHdf2sQKxcsoJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753111313; c=relaxed/simple;
	bh=zY7tgwpRg6nbpxL0Gep74voGS2BpOig5dATabqH+55A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T2D3lL69v0M9tYtLnOSjxkxP35P+mAWDVtP81zrNJsqBAFJdISH3V/7sB2okCRpvDbK9qSSf6YuU/2aPROfgR8kB84Owo/tqV14ziKI+wavuRgK8nWNBi+xsgQlNRr9fy9Yhn/SSEGTdiQk4wznKzkp65loQhDjl+f+3Twkh96Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wpnjkNtE; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4ab5aec969eso86301671cf.3
        for <netdev@vger.kernel.org>; Mon, 21 Jul 2025 08:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753111310; x=1753716110; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MCm3e8F6cDMu/B/EevArrjy1MVVv2JwgfxH3z3oc7jw=;
        b=wpnjkNtEEuWvNxpNHXmBut8F4UG/DD2fljZEsni3tkGpRYMdOYzhCxewM7j2TUhfjV
         eTsdpW7EK49qf5IYVmFm43+qWHqRPkQrBE5zufxcjdlt/lt3EWOZjhHD+eAfdiQn4I7y
         ctndQzZBC7Ju3zzGuiB57TRR7spapKnXiysWKOD8lExCCtEWju8BoGxpctyr7NnVQes8
         w64tBTBmKmJc53MU+vVlWm/OezDsHbmLPHXRoos0CIBiVyAQOwuoUS0bL36VrKaSqcnk
         1G1PCLVqCu1PXLacDi0pgsTvew0czdTLS1UxM0dW9FuTngZPEev/n0qgAEaxqXbENSIz
         e9xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753111310; x=1753716110;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MCm3e8F6cDMu/B/EevArrjy1MVVv2JwgfxH3z3oc7jw=;
        b=VwlKPAVkajkIfci2QKYJ6l5jWKcLS4utzEGKbeL9Brq30rw/bwIbCibGTv9x1xEtJz
         96R/GOdmqVMX888yJzi+FGiqdRw1OShVc+OI5IrvwbKUqoVaurtZUM1bvOanR9imtE7q
         sdeUcge1/qQPE7afxETIydPOzFdwdk/nlAga05Jrhrb1ShdPEE9mvGLuDEv/Y3ole1j+
         4XERVLl2fSEsRV0B8NCc4B6DDdeddcGAxD5H9rtZGRLWIdaM4NPITzW2mPqSNqRqu+it
         W+AuKOJPf6nM6yIRt/IlBezjnIQgs31yih4XrTLlnwHx/Rj7QH77QWs1uWnAqExKnKFb
         bk/A==
X-Gm-Message-State: AOJu0YzkDJTKA/2DKupzFj2vLitF05oDau5HgXuAI/JW7D3rVWXjZQuy
	+QJQamyD0mF2NgsCNwuq/ZsXuDvIeMHjUTJIRDGgAFPG+/0OG0sbgEHgFNfUjfh6ZCkXrKjOd2F
	WfOUAeQNWLlZAuA0Zan1zNPHrk8K9RMkqdk0ZmrNQ
X-Gm-Gg: ASbGncujpNvQnkoONhH0EINp6S5mi2u9uXEuAw+VBndywMfv55TE4ILpzK/tbsNaAFC
	FV1WFoM7TszH7Z7rU2/l5rrFEscuW2ClYTDHG+zSgJMrTVnCtrmRL3SvR8Y8cfoZ8k963NQIm58
	NcK+At+AplWMwrOQYlnud162OjEsPLHaaOBNSqs+lmTbRrPcRx5d7SeVcUmECuyvRQdKajAMwk1
	zs7f2c=
X-Google-Smtp-Source: AGHT+IHiDnLxdax7iyuwjteMxTERldEmKYjiGXYRsRYFxod45wE5Qaeer2FgWhlEfXSK2w6Ere3QLiDwcoRBybsLKG8=
X-Received: by 2002:a05:622a:1e87:b0:4a7:189a:7580 with SMTP id
 d75a77b69052e-4abb2d6e883mr210151711cf.26.1753111310072; Mon, 21 Jul 2025
 08:21:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1752859383.git.pabeni@redhat.com> <3e080bdba9981988ff86e120df40a5f0dc6cd033.1752859383.git.pabeni@redhat.com>
 <CANn89i+KCsw+LH1X1yzmgr1wg5Vxm47AbAEOeOnY5gqq4ngH4w@mail.gmail.com>
 <f8178814-cf90-4021-a3e2-f2494dbf982a@redhat.com> <CANn89i+baSpvbJM6gcbSjZMmWVyvwsFotvH1czui9ARVRjS5Bw@mail.gmail.com>
 <ebc7890c-e239-4a64-99af-df5053245b28@redhat.com> <CANn89iJeXXJV-D5g3+hqStM1sH0UZ3jDeZmOu9mM_E_i9ZYaeA@mail.gmail.com>
 <1d78b781-5cca-440c-b9d0-bdf40a410a3d@redhat.com>
In-Reply-To: <1d78b781-5cca-440c-b9d0-bdf40a410a3d@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 21 Jul 2025 08:21:38 -0700
X-Gm-Features: Ac12FXy6nX6g8c5yHYd7Ib06nQ6w0FwsDh172xAM5SWJW0Y0bF3ZfzVA8hWGD-w
Message-ID: <CANn89iLwpjs7-1qZ+wvFsav_Th9_PJvHvgfWPhz3wxUJwRx70Q@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] tcp: do not set a zero size receive buffer
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, 
	Matthieu Baerts <matttbe@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 21, 2025 at 7:56=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 7/21/25 3:52 PM, Eric Dumazet wrote:
> > On Mon, Jul 21, 2025 at 6:32=E2=80=AFAM Paolo Abeni <pabeni@redhat.com>=
 wrote:
> >> On 7/21/25 2:30 PM, Eric Dumazet wrote:
> >>> On Mon, Jul 21, 2025 at 3:50=E2=80=AFAM Paolo Abeni <pabeni@redhat.co=
m> wrote:
> >>>> On 7/21/25 10:04 AM, Eric Dumazet wrote:
> >>>>> On Fri, Jul 18, 2025 at 10:25=E2=80=AFAM Paolo Abeni <pabeni@redhat=
.com> wrote:
> >>>>>>
> >>>>>> The nipa CI is reporting frequent failures in the mptcp_connect
> >>>>>> self-tests.
> >>>>>>
> >>>>>> In the failing scenarios (TCP -> MPTCP) the involved sockets are
> >>>>>> actually plain TCP ones, as fallback for passive socket at 2whs
> >>>>>> time cause the MPTCP listener to actually create a TCP socket.
> >>>>>>
> >>>>>> The transfer is stuck due to the receiver buffer being zero.
> >>>>>> With the stronger check in place, tcp_clamp_window() can be invoke=
d
> >>>>>> while the TCP socket has sk_rmem_alloc =3D=3D 0, and the receive b=
uffer
> >>>>>> will be zeroed, too.
> >>>>>>
> >>>>>> Pass to tcp_clamp_window() even the current skb truesize, so that
> >>>>>> such helper could compute and use the actual limit enforced by
> >>>>>> the stack.
> >>>>>>
> >>>>>> Fixes: 1d2fbaad7cd8 ("tcp: stronger sk_rcvbuf checks")
> >>>>>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> >>>>>> ---
> >>>>>>  net/ipv4/tcp_input.c | 12 ++++++------
> >>>>>>  1 file changed, 6 insertions(+), 6 deletions(-)
> >>>>>>
> >>>>>> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> >>>>>> index 672cbfbdcec1..c98de02a3c57 100644
> >>>>>> --- a/net/ipv4/tcp_input.c
> >>>>>> +++ b/net/ipv4/tcp_input.c
> >>>>>> @@ -610,24 +610,24 @@ static void tcp_init_buffer_space(struct soc=
k *sk)
> >>>>>>  }
> >>>>>>
> >>>>>>  /* 4. Recalculate window clamp after socket hit its memory bounds=
. */
> >>>>>> -static void tcp_clamp_window(struct sock *sk)
> >>>>>> +static void tcp_clamp_window(struct sock *sk, int truesize)
> >>>>>
> >>>>>
> >>>>> I am unsure about this one. truesize can be 1MB here, do we want th=
at
> >>>>> in general ?
> >>>>
> >>>> I'm unsure either. But I can't think of a different approach?!? If t=
he
> >>>> incoming truesize is 1M the socket should allow for at least 1M rcvb=
uf
> >>>> size to accept it, right?
> >>>
> >>> What I meant was :
> >>>
> >>> This is the generic point, accepting skb->truesize as additional inpu=
t
> >>> here would make us more vulnerable, or we could risk other
> >>> regressions.
> >>
> >> Understood, thanks for the clarification.
> >>
> >>> The question is : why does MPTCP end up here in the first place.
> >>> Perhaps an older issue with an incorrectly sized sk_rcvbuf ?
> >>
> >> I collected a few more data. The issue happens even with plain TCP
> >> sockets[1].
> >>
> >> The relevant transfer is on top of the loopback device. The scaling_ra=
te
> >> rapidly grows to 254 - that is `truesize` and `len` are very near.
> >>
> >> The stall happens when the received get in a packet with a slightly le=
ss
> >> 'efficient' layout (in the experiment I have handy len is 71424,
> >> truesize 72320) (almost) filling the receiver window.
> >>
> >> On such input, tcp_clamp_window() shrinks the receiver buffer to the
> >> current rmem usage. The same happens on retransmissions until rcvbuf
> >> becomes 0.
> >>
> >> I *think* that catching only the !sk_rmem_alloc case would avoid the
> >> stall, but I think it's a bit 'late'.
> >
> > A packetdrill test here would help understanding your concern.
>
> I fear like a complete working script would take a lot of time, let me
> try to sketch just the relevant part:
>
> # receiver state is:
> # rmem=3D110592 rcvbuf=3D174650 scaling_ratio=3D253 rwin=3D63232
> # no OoO data, no memory pressure,
>
> # the incoming packet is in sequence
> +0 > P. 109297:172528(63232) ack 1
>
> With just the 0 rmem check in tcp_prune_queue(), such function will
> still invoke tcp_clamp_window() that will shrink the receive buffer to
> 110592.

As long as an ACK is sent back with a smaller RWIN, I think this would
be reasonable in this case.

> tcp_collapse() can't make enough room and the incoming packet will be
> dropped. I think we should instead accept such packet.

Only if not completely off-the-limits...

packetdrill test :

cat eric.pkt
// Test the calculation of receive window values by a bulk data receiver.

--mss=3D1000

// Set up config.
// Need to set tcp_rmem[1] to what tcp_fixup_rcvbuf() would have set to
// make sure the same kernel behavior after removing tcp_fixup_rcvbuf()
`../common/defaults.sh
../common/set_sysctls.py /proc/sys/net/ipv4/tcp_rmem=3D"4096 131072 1572864=
0"
`

// Create a socket.
    0 socket(..., SOCK_STREAM, IPPROTO_TCP) =3D 3
   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) =3D 0

// Verify that the receive buffer is the tcp_rmem default.
   +0 getsockopt(3, SOL_SOCKET, SO_RCVBUF, [131072], [4]) =3D 0

   +0 bind(3, ..., ...) =3D 0
   +0 listen(3, 1) =3D 0

// Establish a connection.
 +.01 < S 0:0(0) win 65535 <mss 1000,nop,nop,sackOK,nop,wscale 6>
   +0 > S. 0:0(0) ack 1 win 64240 <mss 1460,nop,nop,sackOK,nop,wscale 8>
 +.01 < . 1:1(0) ack 1 win 457
   +0 accept(3, ..., ...) =3D 4

// Verify that the receive buffer is the tcp_rmem default.
   +0 getsockopt(3, SOL_SOCKET, SO_RCVBUF, [131072], [4]) =3D 0

// Check first outgoing window after SYN
 +.01 write(4, ..., 1000) =3D 1000
   +0 > P. 1:1001(1000) ack 1 win 251

// Phase 1: Data arrives but app doesn't read from the socket buffer.

 +.01 < . 1:60001(60000) ack 1001 win 457
   +0 > . 1001:1001(0) ack 60001 win 263


 +.01 < . 60001:120001(60000) ack 1001 win 457
+0~+.04 > . 1001:1001(0) ack 120001 win 29

// Incoming packet  has a too big skb->truesize, lets send a lower RWIN
 +.01 < . 120001:127425(7424) ack 1001 win 457
+0~+.04 > . 1001:1001(0) ack 120001 win 0

// Reset to sysctls defaults
`/tmp/sysctl_restore_${PPID}.sh`


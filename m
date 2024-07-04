Return-Path: <netdev+bounces-109310-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7095F927D76
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 21:02:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA01D1F24C38
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 19:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16C12137C2A;
	Thu,  4 Jul 2024 19:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vkQKWVdO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1F713C8EE
	for <netdev@vger.kernel.org>; Thu,  4 Jul 2024 19:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720119728; cv=none; b=E0FgXX0u7s79YKf5p6ofOkLpzmqqi9/xGpu7BbYtQXRFsUv6KrKWswuNcT555foEM9nT0Oqv8M3AI0n3HAl/N4xRsP1Atrv2AUBbRkb192B9psOPCefC/slh59lvi5gaQgF9FMBiu32EQswVeXU7MZkJULMSAKqQYuDcYiBzX2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720119728; c=relaxed/simple;
	bh=97OQ15uTvBPzUhzNjXXQecbLgB0ZyVm/Q42rgdaBM1c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gYuGwWbUpkoUDMv9/ogEZ1gM809l7i2O/v/1+tnYvwnmTeS2QsbkJaJCaKthncceoHjkTFehhsSw0QgJnWPmbKbpr8Bhxdy53weOTqYy/xZen2qj5eHF31f80ZiInryimV4PxpUY3h7w3J9lQY7un04o3B6hmGihzzPcg6t82Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vkQKWVdO; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-58ce966a1d3so12236a12.1
        for <netdev@vger.kernel.org>; Thu, 04 Jul 2024 12:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720119724; x=1720724524; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hhFWmypeo+2fFP0usMglgA7U3O/mCr2FbEmj5CVohuk=;
        b=vkQKWVdOZzgekbMgaTaV1x3dfPwymUj0/hRS5nutt0JHdSDuk148QgYstjqd6G2+k4
         bhKv37TJ9P8TIU3Jemh6VvHudTco0qjyvZL2fl6IDAbzc8zA05WjMWov32lhCkkHb60J
         3WX/b+e5yGSCGoJG0hA1sQKfrcJ1BABf8qo0l8zinVb3TRfrlJhq/ORRUYtEDjbZc2Gl
         beONfeOzfszk1oyH3iptQ2TS4zwdCkE9jouvC9h+udiMd7yWprkzs/oYImLT+ryzQngf
         eyGWFEYm6jZvqdgy6a5kgXgCXRsChzWVkz49O4lODspiGCJcEjF0jIgUSP/3WgYitvGx
         0R4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720119724; x=1720724524;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hhFWmypeo+2fFP0usMglgA7U3O/mCr2FbEmj5CVohuk=;
        b=QVOjFyMoTnsq1t3+W3q/okJ1yJ2sFRXDAAAtAE053k3clXwmpOIgXLqu5azm7ewo0C
         sEczez7w9TklT4WF0hcDv9w0c+az3fbsAddQDElfHXtoBlBijV3VMKWf4mBwKBQlvYPk
         WWxEWvDGUD/ClUIQ6gZyvW2LGz/+Y9vqwtr9ED1Ml6MarTaaFW2Z7UsOG0Tp/O+VyrID
         wER2qJ1IN8HV83Yr9giUj33CXafFAmQoQPkr3k+GNW9623szvYJDXtxilSlwgIWHsYFz
         ZG+e6zeEKHVtlGP3qtlLhCvGnRglEvz+ux/hvOFqbAz424/kY5CytvenISizLYgYMG0/
         7OsQ==
X-Forwarded-Encrypted: i=1; AJvYcCU14QSGDYkytjjUlO1fY6Q91Txm7zQxzRbq6FFm/+POP8CTTjKjEGYXcpMTXZZpBT86D2WDE6Um5ogg2GtkKuE82vny/rKm
X-Gm-Message-State: AOJu0Yx38LXhc3w5M5C5Kv6/aZ+kD+XwAwjxO+6/+hscc977//OB3lxv
	B2konchNDXixlaSgOqvpcKgeTKxwH11KXRNbULd9b9+wPMHCnSiCpWw61i2PO9IHWQ69UOiOgb4
	fYHSPI8tihTQj7fERMX23e54I9nlfOrBG8SA4
X-Google-Smtp-Source: AGHT+IHNgRxtqnEnkAIgRpbF9hTwBqCG8jVrOCkIcuwrJG8FRRBCLHAxdbfHCmNZPFe9jQYQgA1CNbxqmqd4lDQsATw=
X-Received: by 2002:a50:9f46:0:b0:58b:21f2:74e6 with SMTP id
 4fb4d7f45d1cf-58dfda85339mr203334a12.0.1720119724060; Thu, 04 Jul 2024
 12:02:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANn89iJhX=ck_XD4Gu7B_1401e+y4NSE+8CAD_Yu4PMO4-H-eA@mail.gmail.com>
 <20240704173621.1804-1-kuniyu@amazon.com>
In-Reply-To: <20240704173621.1804-1-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 4 Jul 2024 21:01:52 +0200
Message-ID: <CANn89iJ35J7u+7WNWM_BjC-+HaBxSjAkMhSD+eC8AaBaawuhmQ@mail.gmail.com>
Subject: Re: [PATCH v1 net] tcp: Don't drop SYN+ACK for simultaneous connect().
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: brakmo@fb.com, davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, 
	kuni1840@gmail.com, netdev@vger.kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 4, 2024 at 7:36=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.com=
> wrote:
>
> From: Eric Dumazet <edumazet@google.com>
> Date: Thu, 4 Jul 2024 10:44:55 +0200
> > On Thu, Jul 4, 2024 at 5:57=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon=
.com> wrote:
> > >
> > > RFC 9293 states that in the case of simultaneous connect(), the conne=
ction
> > > gets established when SYN+ACK is received. [0]
> > >
> > >       TCP Peer A                                       TCP Peer B
> > >
> > >   1.  CLOSED                                           CLOSED
> > >   2.  SYN-SENT     --> <SEQ=3D100><CTL=3DSYN>              ...
> > >   3.  SYN-RECEIVED <-- <SEQ=3D300><CTL=3DSYN>              <-- SYN-SE=
NT
> > >   4.               ... <SEQ=3D100><CTL=3DSYN>              --> SYN-RE=
CEIVED
> > >   5.  SYN-RECEIVED --> <SEQ=3D100><ACK=3D301><CTL=3DSYN,ACK> ...
> > >   6.  ESTABLISHED  <-- <SEQ=3D300><ACK=3D101><CTL=3DSYN,ACK> <-- SYN-=
RECEIVED
> > >   7.               ... <SEQ=3D100><ACK=3D301><CTL=3DSYN,ACK> --> ESTA=
BLISHED
> > >
> > > However, since commit 0c24604b68fc ("tcp: implement RFC 5961 4.2"), s=
uch a
> > > SYN+ACK is dropped in tcp_validate_incoming() and responded with Chal=
lenge
> > > ACK.
> > >
> > > For example, the write() syscall in the following packetdrill script =
fails
> > > with -EAGAIN, and wrong SNMP stats get incremented.
> > >
> > >    0 socket(..., SOCK_STREAM|SOCK_NONBLOCK, IPPROTO_TCP) =3D 3
> > >   +0 connect(3, ..., ...) =3D -1 EINPROGRESS (Operation now in progre=
ss)
> > >
> > >   +0 > S  0:0(0) <mss 1460,sackOK,TS val 1000 ecr 0,nop,wscale 8>
> > >   +0 < S  0:0(0) win 1000 <mss 1000>
> > >   +0 > S. 0:0(0) ack 1 <mss 1460,sackOK,TS val 3308134035 ecr 0,nop,w=
scale 8>
> > >   +0 < S. 0:0(0) ack 1 win 1000
> > >
> > >   +0 write(3, ..., 100) =3D 100
> > >   +0 > P. 1:101(100) ack 1
> > >
> > >   --
> > >
> > >   # packetdrill cross-synack.pkt
> > >   cross-synack.pkt:13: runtime error in write call: Expected result 1=
00 but got -1 with errno 11 (Resource temporarily unavailable)
> > >   # nstat
> > >   ...
> > >   TcpExtTCPChallengeACK           1                  0.0
> > >   TcpExtTCPSYNChallenge           1                  0.0
> > >
> > > That said, this is no big deal because the Challenge ACK finally let =
the
> > > connection state transition to TCP_ESTABLISHED in both directions.  I=
f the
> > > peer is not using Linux, there might be a small latency before ACK th=
ough.
> >
> > I suggest removing these 3 lines. Removing a not needed challenge ACK i=
s good
> > regardless of the 'other peer' behavior.
>
> I see, then should Fixes point to 0c24604b68fc ?

I would target net-next, unless you have a very convincing reason.

The bug might only be exposed by eBPF users, right ?



>
> Also I noticed it still sends ACK in tcp_ack_snd_check() as if it's a
> response to the normal 3WHS, so we need:
>
> ---8<---
> @@ -6788,6 +6793,9 @@ tcp_rcv_state_process(struct sock *sk, struct sk_bu=
ff *skb)
>                 tcp_fast_path_on(tp);
>                 if (sk->sk_shutdown & SEND_SHUTDOWN)
>                         tcp_shutdown(sk, SEND_SHUTDOWN);
> +
> +               if (!req)
> +                       goto consume;

I guess this is becoming a bit risky for net tree ?

Given tcp cross syn is mostly used by fuzzers, I would advise doing
something very minimal.

>                 break;
>
>         case TCP_FIN_WAIT1: {
> ---8<---
>
> and I have a question regarding the consume: label.  Why do we use
> __kfree_skb() there instead of consume_skb() ?  I guess it's because
> skb_unref() is unnecessary and expensive and tracing is also expensive ?

For the same reason we do __kfree_skb()  in other places.

This predates consume_skb().

>
>
> >
> > >
> > > The problem is that bpf_skops_established() is triggered by the Chall=
enge
> > > ACK instead of SYN+ACK.  This causes the bpf prog to miss the chance =
to
> > > check if the peer supports a TCP option that is expected to be exchan=
ged
> > > in SYN and SYN+ACK.
> > >
> > > Let's accept a bare SYN+ACK for non-TFO TCP_SYN_RECV sockets to avoid=
 such
> > > a situation.
> > >
> > > Link: https://www.rfc-editor.org/rfc/rfc9293.html#section-3.5-7 [0]
> > > Fixes: 9872a4bde31b ("bpf: Add TCP connection BPF callbacks")
> > > Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> > > ---
> > >  net/ipv4/tcp_input.c | 7 ++++++-
> > >  1 file changed, 6 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> > > index 77294fd5fd3e..70595009bb58 100644
> > > --- a/net/ipv4/tcp_input.c
> > > +++ b/net/ipv4/tcp_input.c
> > > @@ -5980,6 +5980,11 @@ static bool tcp_validate_incoming(struct sock =
*sk, struct sk_buff *skb,
> > >          * RFC 5961 4.2 : Send a challenge ack
> > >          */
> > >         if (th->syn) {
> > > +               if (sk->sk_state =3D=3D TCP_SYN_RECV && !tp->syn_fast=
open && th->ack &&
> > > +                   TCP_SKB_CB(skb)->seq + 1 =3D=3D TCP_SKB_CB(skb)->=
end_seq &&
> > > +                   TCP_SKB_CB(skb)->seq + 1 =3D=3D tp->rcv_nxt &&
> > > +                   TCP_SKB_CB(skb)->ack_seq =3D=3D tp->snd_nxt)
> > > +                       goto pass;
> > >  syn_challenge:
> > >                 if (syn_inerr)
> > >                         TCP_INC_STATS(sock_net(sk), TCP_MIB_INERRS);
> > > @@ -5990,7 +5995,7 @@ static bool tcp_validate_incoming(struct sock *=
sk, struct sk_buff *skb,
> > >         }
> > >
> > >         bpf_skops_parse_hdr(sk, skb);
> > > -
> > > +pass:
> >
> > It is not clear to me why we do not call bpf_skops_parse_hdr(sk, skb)
> > in this case ?
>
> I skipped bpf_skops_parse_hdr() as it had this check.
>
>         switch (sk->sk_state) {
>         case TCP_SYN_RECV:
>         case TCP_SYN_SENT:
>         case TCP_LISTEN:
>                 return;
>         }

I think I prefer these checks being clearly centralized there, instead
of trying to duplicate them earlier.

This is slow path anyway.

I am a bit like Paolo : why do we even care, adding more fuel for fuzzers..=
.


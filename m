Return-Path: <netdev+bounces-142667-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B51C9BFF48
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 08:45:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 182451F21D84
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 07:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11A7517E473;
	Thu,  7 Nov 2024 07:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J5WnQF/i"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F1E10F9
	for <netdev@vger.kernel.org>; Thu,  7 Nov 2024 07:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730965535; cv=none; b=tU/ppi1XJc5Hvic9aayglxdwC/SQh2a7oNQiQmlcnJmjf0fiuhQt5klUxXKj75irOWbtsXtZw4GX5VoE4x5zqj2K/km28Y4k+z0SIAmojMmXYd2eOd2dC9bxHoA5yfuOub9A816o+OUyJQ7uJDZGfAZRAchPmQX5yPf+IlDWXCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730965535; c=relaxed/simple;
	bh=5uRGz46gy3g24ohwsQ4PrjGbpT9TIi9MCtrUESBtL/c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gVMHsXfJHAqGW1oGKWmQU2bP7IcDGa/zK7aSDe0f6LoQPtP5v8OFeJtDymDOc1AGd4PrH8LnFyYfY3FlfjmvXeIvMylBbbzNyXpN0VgG6mavIhAK6yM+YvGu7JkN7OkuvBmoX1gnZU1VJBaJfSde7GfPXcWZD6qDwSG4w98h3eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J5WnQF/i; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-83abf71f244so24224939f.1
        for <netdev@vger.kernel.org>; Wed, 06 Nov 2024 23:45:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730965532; x=1731570332; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PGxE8YIzKeiPwvk8z5Vq+b4Zwn9C8kj/pt94M1PoIxk=;
        b=J5WnQF/i6sgPHybenYclsbcDNvPIKqd8DgHae5PWzHe7ehkuc6bJeczqmb8+L6/jtU
         xulvTkIX4Q0gw0NPLNtMdK4Ovog99kZ5aORkEU3GpDKeODyjMS5AeVzoNOqO/yMadbtv
         9mC5oCyKVITJrOwxqILrR3TvP0FfA3UjEWoO/L4okglEI653sQEGw+r/BXhjgwP+C7hQ
         ksIiEcuwea9uRvZh3UH/e7lMWl3McYZEsJaIBsHUwmnObYGwsJAM5PWEkID8KshwKj2c
         PE2X8I0LDaW6QvcqOTW1/PQSId18AFbFq788rMJGaWLRn+fFxqzrDov5l5B5qKPUUaBf
         RrDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730965532; x=1731570332;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PGxE8YIzKeiPwvk8z5Vq+b4Zwn9C8kj/pt94M1PoIxk=;
        b=knwYmQnwRx2K48EBt5ixv/kZZIFH23YNcG+UWyEwjAlBcC5C8vcasogCHKzk7o3bon
         TtJMgkafL6wr/rcAJnXRtp4AD4iNMEqJj5Lbv/PAGCQMiMEmS8X6kpfHkDkCGtx4VtRt
         AovpNYstJrWTJhXt14UcER4uI7i9G8//HNL1pCCgfG0+8UoVvqECuqutQ1f/xBtZs95L
         93tZI3ZwrDpE+VBLJznzI9hGfhynlz3MVQj41afZPcttwy5dgKwchqDV+lUkH93+ZNdO
         /DPH8YQV+xQEkafG3CIJHy0TKbb1oJtJrhhQH/StWZck1W2Lo7Gls5zxBXjmMVwJg+F4
         msMQ==
X-Forwarded-Encrypted: i=1; AJvYcCVlSreTM3kWVLSzX9t67y4CswDAJnFZZJjI4U5vB3964koQICL/EGFFisgd8tb6KGTsYNh1ELo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTtrPw73WanpC6DVT1LsoEqjyyVEPsLgakV/blDAC6Fx4D3o2Q
	fqZZjVoUOSoVRINEeY7bJFaZ8RKb48RcQC85iacpVD3I/XCA9seGmgshGHUr0UUk4VHqyZsqU3l
	WaNxvqV1ErEPuJcL1HnrFX4plQap5uqpM
X-Google-Smtp-Source: AGHT+IG4qnmKY/H9prjo56iGO+PMiHweZiC8/yawp3YKDB5aZODOKH1+3aa9Hx5X1r22OVUXdiHiGvSXiLOmkUizD/Y=
X-Received: by 2002:a05:6e02:1985:b0:3a4:eaae:f9f0 with SMTP id
 e9e14a558f8ab-3a6ed0a40f4mr3775305ab.2.1730965532234; Wed, 06 Nov 2024
 23:45:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAL+tcoCzJWBN9-0F32a37Ljbx9XbA-in55K8sRjfSicZBGtqbA@mail.gmail.com>
 <20241107071117.1022-1-kuniyu@amazon.com>
In-Reply-To: <20241107071117.1022-1-kuniyu@amazon.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 7 Nov 2024 15:44:55 +0800
Message-ID: <CAL+tcoCVS-thL79WjN5mSxnUFNVrp1bB+JF9MUcsGuodcETPFg@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: avoid RST in 3-way shakehands due to
 failure in tcp_timewait_state_process
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	horms@kernel.org, kernelxing@tencent.com, kuba@kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 7, 2024 at 3:11=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.com=
> wrote:
>
> From: Jason Xing <kerneljasonxing@gmail.com>
> Date: Thu, 7 Nov 2024 14:51:35 +0800
> > On Thu, Nov 7, 2024 at 1:43=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon=
.com> wrote:
> > >
> > > From: Jason Xing <kerneljasonxing@gmail.com>
> > > Date: Thu, 7 Nov 2024 13:23:50 +0800
> > > > On Thu, Nov 7, 2024 at 12:15=E2=80=AFPM Kuniyuki Iwashima <kuniyu@a=
mazon.com> wrote:
> > > > >
> > > > > From: Jason Xing <kerneljasonxing@gmail.com>
> > > > > Date: Thu, 7 Nov 2024 11:16:04 +0800
> > > > > > > Here is how things happen in production:
> > > > > > > Time        Client(A)        Server(B)
> > > > > > > 0s          SYN-->
> > > > > > > ...
> > > > > > > 132s                         <-- FIN
> > > > > > > ...
> > > > > > > 169s        FIN-->
> > > > > > > 169s                         <-- ACK
> > > > > > > 169s        SYN-->
> > > > > > > 169s                         <-- ACK
> > > > > >
> > > > > > I noticed the above ACK doesn't adhere to RFC 6191. It says:
> > > > > > "If the previous incarnation of the connection used Timestamps,=
 then:
> > > > > >      if ...
> > > > > >      ...
> > > > > >      * Otherwise, silently drop the incoming SYN segment, thus =
leaving
> > > > > >          the previous incarnation of the connection in the TIME=
-WAIT
> > > > > >          state.
> > > > > > "
> > > > > > But the timewait socket sends an ACK because of this code snipp=
et:
> > > > > > tcp_timewait_state_process()
> > > > > >     -> // the checks of SYN packet failed.
> > > > > >     -> if (!th->rst) {
> > > > > >         -> return TCP_TW_ACK; // this line can be traced back t=
o 2005
> > > > >
> > > > > This is a challenge ACK following RFC 5961.
> > > >
> > > > Please note the idea of challenge ack was proposed in 2010. But thi=
s
> > > > code snippet has already existed before 2005. If it is a challenge
> > > > ack, then at least we need to count it (by using NET_INC_STATS(net,
> > > > LINUX_MIB_TCPCHALLENGEACK);).
> > >
> > > The word was not accurate, the behaviour is compliant with RFC 5961.
> > > RFC is often formalised based on real implementations.
> > >
> > > Incrementing the count makes sense to me.
> > >
> > > >
> > > > >
> > > > > If SYN is returned here, the client may lose the chance to RST th=
e
> > > > > previous connection in TIME_WAIT.
> > > > >
> > > > > https://www.rfc-editor.org/rfc/rfc9293.html#section-3.10.7.4-2.4.=
1
> > > > > ---8<---
> > > > >       -  TIME-WAIT STATE
> > > > >
> > > > >          o  If the SYN bit is set in these synchronized states, i=
t may
> > > > >             be either a legitimate new connection attempt (e.g., =
in the
> > > > >             case of TIME-WAIT), an error where the connection sho=
uld be
> > > > >             reset, or the result of an attack attempt, as describ=
ed in
> > > > >             RFC 5961 [9].  For the TIME-WAIT state, new connectio=
ns can
> > > > >             be accepted if the Timestamp Option is used and meets
> > > > >             expectations (per [40]).  For all other cases, RFC 59=
61
> > > > >             provides a mitigation with applicability to some situ=
ations,
> > > > >             though there are also alternatives that offer cryptog=
raphic
> > > > >             protection (see Section 7).  RFC 5961 recommends that=
 in
> > > > >             these synchronized states, if the SYN bit is set,
> > > > >             irrespective of the sequence number, TCP endpoints MU=
ST send
> > > > >             a "challenge ACK" to the remote peer:
> > > > >
> > > > >             <SEQ=3DSND.NXT><ACK=3DRCV.NXT><CTL=3DACK>
> > > > > ---8<---
> > > > >
> > > > > https://datatracker.ietf.org/doc/html/rfc5961#section-4
> > > > > ---8<---
> > > > >    1) If the SYN bit is set, irrespective of the sequence number,=
 TCP
> > > > >       MUST send an ACK (also referred to as challenge ACK) to the=
 remote
> > > > >       peer:
> > > > >
> > > > >       <SEQ=3DSND.NXT><ACK=3DRCV.NXT><CTL=3DACK>
> > > > >
> > > > >       After sending the acknowledgment, TCP MUST drop the unaccep=
table
> > > > >       segment and stop processing further.
> > > > > ---8<---
> > > >
> > > > The RFC 5961 4.2 was implemented in tcp_validate_incoming():
> > > >         /* step 4: Check for a SYN
> > > >          * RFC 5961 4.2 : Send a challenge ack
> > > >          */
> > > >         if (th->syn) {
> > > >                 if (sk->sk_state =3D=3D TCP_SYN_RECV && sk->sk_sock=
et && th->ack &&
> > > >                     TCP_SKB_CB(skb)->seq + 1 =3D=3D TCP_SKB_CB(skb)=
->end_seq &&
> > > >                     TCP_SKB_CB(skb)->seq + 1 =3D=3D tp->rcv_nxt &&
> > > >                     TCP_SKB_CB(skb)->ack_seq =3D=3D tp->snd_nxt)
> > > >                         goto pass;
> > > > syn_challenge:
> > > >                 if (syn_inerr)
> > > >                         TCP_INC_STATS(sock_net(sk), TCP_MIB_INERRS)=
;
> > > >                 NET_INC_STATS(sock_net(sk),
> > > > LINUX_MIB_TCPSYNCHALLENGE);
> > > >                 tcp_send_challenge_ack(sk);
> > > >                 SKB_DR_SET(reason, TCP_INVALID_SYN);
> > > >                 goto discard;
> > > >         }
> > > >
> > > > Also, this quotation you mentioned obviously doesn't match the kern=
el
> > > > implementation:
> > > > "If the SYN bit is set, irrespective of the sequence number, TCP MU=
ST
> > > > send an ACK"
> > > > The tcp_timewait_state_process() does care about the seq number, or
> > > > else timewait socket would refuse every SYN packet.
> > >
> > > That's why I pasted RFC 9293 first that clearly states that we
> > > should check seq number and then return ACK for all other cases.
> >
> > I don't think so.
> >
> > RFC 9293 only states that RFC 5691 provides an approach that mitigates
> > the risk by rejecting all the SYN packets if the socket stays in
> > synchronized state. It's "For all other cases" in RFC 9293.
>
> RFC 9293 states which RFC to prioritise.  You will find the
> link [40] is RFC 6191.
>
> ---8<---
> For the TIME-WAIT state, new connections can
> be accepted if the Timestamp Option is used and meets
> expectations (per [40]).  For all other cases, RFC 5961
> ...
> ---8<---
>
> > Please loot at "irrespective of the sequence number" in RFC 5691 4.2
> > [1]. It means no matter what the seq is we MUST send back an ACK
> > instead of establishing a new connection.
>
> RFC 9293 mentions accepatble cases first, so this is only applied
> to "all other cases"
>
>
> > Actually the tcp_timewait_state_process() checks the seq or timestamp
> > in the SYN packet.
>
> and this part takes precedence than "all other cases".
>
> Also, you missed that the pasted part is the 4th step of incoming
> segment processing.
>
> https://www.rfc-editor.org/rfc/rfc9293.html#section-3.10.7.4
> ---8<---
> First, check sequence number: ...
> Second, check the RST bit: ...
> Third, check security: ...
> Fourth, check the SYN bit:
> ...
>   TIME-WAIT STATE
>     If the SYN bit is set in these synchronized states...
> ---8<---
>
> So, RFC 9293 says "check seq number, RST, security, then
> if the connection is still accepatable for TIME_WAIT based on
> RFC 6191, accept it, otherwise, return ACK based on RFC 5691".

I see what you mean here. If that is so, tcp_timewait_state_process()
has already implemented the challenge ack even before the challenge
ack showed up in 2010.

Interesting. If this part refers to RFC 5691, then we need to copy
part of tcp_send_challenge_ack() in this case to send the challenge
ack, like testing sysctl_tcp_challenge_ack_limit, etc.

Thanks,
Jason


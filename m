Return-Path: <netdev+bounces-109140-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D19D59271BB
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 10:30:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86B9A280FBC
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 08:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0736A1946B;
	Thu,  4 Jul 2024 08:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JOcTHyVV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F994431
	for <netdev@vger.kernel.org>; Thu,  4 Jul 2024 08:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720081849; cv=none; b=aMBRl9Zcgebp8yR+7TD2/tH9rT7+VJy1F/vBkF4ZL2bRGilap4iiq3LXCwo8ErdAeyHDjnLzmDLsyjfDN5CRnYJQR8Dow8NuXmo3DMlqCpxLdxml+RhP+cv1irEnL1/+fEhyneVvvlmkDsvZe0qGGJmMahb7TLR6saOgeDOqFyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720081849; c=relaxed/simple;
	bh=ojeIH5iCl0s842EBXJbzHzcd568Awwx1zt5zgLi1TeA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PhSOX9tGmpaWObGyARgIHE3JmOGvp2JLAJx0z0V363jlffMfjQ2jf3FsbOjEvWU+ln3h83hCUpZHJirc/RVwH2NmOWoypNBY2N9gWLu2GE5oNLgFNV5FUS7s1ctakFK32Gz/Mt0YcfpUVQfLOc3+Y+Pa5j498HcLiF2UPhEC1nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JOcTHyVV; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4255f915611so58075e9.0
        for <netdev@vger.kernel.org>; Thu, 04 Jul 2024 01:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720081847; x=1720686647; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iqX8hf+56LZXJwE4f2vZe2yArYJRCIiypumjCGL0WGo=;
        b=JOcTHyVVjZMDjptIN/PC8oiEanACQ0WLun7+e6xRbhuDfCu2xqIsv+5QISitf3Rp4d
         WO2HRmlT7oDkpva2GAncR3RHy8swjTQVtUC0oB4WVONW7YAmDZ4dI3gw5tuT/U+3qcS8
         dmxm98SSVOdcAGkm6q3N/obNIVwNxKQmodPaiQgnPJwxswMklX9ycObIYQlSJPx0KKCz
         E8ZQTzM1yOcfyVxsuPuvezuTJZ1y6+hTXAA1J6iT7IUy6bQPUv719QeF2BhN1IqpfQ/B
         yoRtfbCsr7+9iQmRmkwZL2EhPpvWktpbeA7zE1FuoTJcFrcdfqwp3HOC5VNh+2clDPbu
         pxrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720081847; x=1720686647;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iqX8hf+56LZXJwE4f2vZe2yArYJRCIiypumjCGL0WGo=;
        b=VfrfoCoX6pT6Tk78T1fxo3eX+OHhn4JKqFpc4qdEu3l+3SlJRdR1nesgZOx0zS6/xl
         qmu/RmsNacJ2wKlpLh8oTib/46jSXq0qWeOmGCMzzMpZwS1Qlzapc5LWk6T65IW0J8JC
         7MsPzxGvURPRTVFtjne7rI1rHo7qVLMumGXvCVZyUDUydA0kuwoI/GYTXw3kmkUvVHuz
         oDxcm+mztQCI9wC34PqkRQ30ceQfcuNkS96qZiSwhW8lCntnnE/Vpps4CpaF5b/Et0cf
         GD5LoY+C9UcUJ7JBYU8Q8kQFBX4y23/dEmK8O0PlFqSM0Opes5vDwLvt0EjazslutGVi
         CRQw==
X-Forwarded-Encrypted: i=1; AJvYcCUXl/LFylvSW9Ws+Kh3ygsAnt4cs8p3bKehc9/xKBxObGl1VWmGLX9IRdVaD5AaZVbOIwOKiqNyp8JqLsXnyIoXsjVe1Eyr
X-Gm-Message-State: AOJu0YxdEKRLrwJZAfAreBxH9MZpKhhjjYoeBF88d3BXOR0/hJnfX5Mq
	Pfx2UMeJJslZs15tF+63DjaafJXqSwyjZ1B8ODONtSzFEhPhdSOZ458BQl/WHInC3L+eobfOlNU
	LB0j3zULsXcIVKYMt84QpGj3HTicg7j+G8oyr
X-Google-Smtp-Source: AGHT+IGabB1K2u3s9RC5OIqItsw2R4sjTyL5BUZbh7mKyIQP+vj9msujHa1u7WsOt+pzhEK4Lr1DiXpf7toqUQXP8A8=
X-Received: by 2002:a05:600c:3b02:b0:421:6c54:3a8 with SMTP id
 5b1f17b1804b1-42649a5cb24mr950605e9.7.1720081846250; Thu, 04 Jul 2024
 01:30:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240704035703.95065-1-kuniyu@amazon.com> <98087e1ae7e1d63a05c9275c54ca322d9f53a2aa.camel@redhat.com>
 <CANn89i+pwejq4Kt9h-m4cDEvDeOUC9k5RXJUcUp=fEZm=ojhfw@mail.gmail.com> <05cf321aa7d33124a17b4c75d92d5f8c67286871.camel@redhat.com>
In-Reply-To: <05cf321aa7d33124a17b4c75d92d5f8c67286871.camel@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 4 Jul 2024 10:30:32 +0200
Message-ID: <CANn89i+235C4orw9fNi6vu8pEoed1evT=qbF5ifnzURA_Nw-rw@mail.gmail.com>
Subject: Re: [PATCH v1 net] tcp: Don't drop SYN+ACK for simultaneous connect().
To: Paolo Abeni <pabeni@redhat.com>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, David Ahern <dsahern@kernel.org>, Lawrence Brakmo <brakmo@fb.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 4, 2024 at 10:14=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On Thu, 2024-07-04 at 10:03 +0200, Eric Dumazet wrote:
> > On Thu, Jul 4, 2024 at 10:01=E2=80=AFAM Paolo Abeni <pabeni@redhat.com>=
 wrote:
> > >
> > > On Wed, 2024-07-03 at 20:57 -0700, Kuniyuki Iwashima wrote:
> > > > RFC 9293 states that in the case of simultaneous connect(), the con=
nection
> > > > gets established when SYN+ACK is received. [0]
> > > >
> > > >       TCP Peer A                                       TCP Peer B
> > > >
> > > >   1.  CLOSED                                           CLOSED
> > > >   2.  SYN-SENT     --> <SEQ=3D100><CTL=3DSYN>              ...
> > > >   3.  SYN-RECEIVED <-- <SEQ=3D300><CTL=3DSYN>              <-- SYN-=
SENT
> > > >   4.               ... <SEQ=3D100><CTL=3DSYN>              --> SYN-=
RECEIVED
> > > >   5.  SYN-RECEIVED --> <SEQ=3D100><ACK=3D301><CTL=3DSYN,ACK> ...
> > > >   6.  ESTABLISHED  <-- <SEQ=3D300><ACK=3D101><CTL=3DSYN,ACK> <-- SY=
N-RECEIVED
> > > >   7.               ... <SEQ=3D100><ACK=3D301><CTL=3DSYN,ACK> --> ES=
TABLISHED
> > > >
> > > > However, since commit 0c24604b68fc ("tcp: implement RFC 5961 4.2"),=
 such a
> > > > SYN+ACK is dropped in tcp_validate_incoming() and responded with Ch=
allenge
> > > > ACK.
> > > >
> > > > For example, the write() syscall in the following packetdrill scrip=
t fails
> > > > with -EAGAIN, and wrong SNMP stats get incremented.
> > > >
> > > >    0 socket(..., SOCK_STREAM|SOCK_NONBLOCK, IPPROTO_TCP) =3D 3
> > > >   +0 connect(3, ..., ...) =3D -1 EINPROGRESS (Operation now in prog=
ress)
> > > >
> > > >   +0 > S  0:0(0) <mss 1460,sackOK,TS val 1000 ecr 0,nop,wscale 8>
> > > >   +0 < S  0:0(0) win 1000 <mss 1000>
> > > >   +0 > S. 0:0(0) ack 1 <mss 1460,sackOK,TS val 3308134035 ecr 0,nop=
,wscale 8>
> > > >   +0 < S. 0:0(0) ack 1 win 1000
> > > >
> > > >   +0 write(3, ..., 100) =3D 100
> > > >   +0 > P. 1:101(100) ack 1
> > > >
> > > >   --
> > > >
> > > >   # packetdrill cross-synack.pkt
> > > >   cross-synack.pkt:13: runtime error in write call: Expected result=
 100 but got -1 with errno 11 (Resource temporarily unavailable)
> > > >   # nstat
> > > >   ...
> > > >   TcpExtTCPChallengeACK           1                  0.0
> > > >   TcpExtTCPSYNChallenge           1                  0.0
> > > >
> > > > That said, this is no big deal because the Challenge ACK finally le=
t the
> > > > connection state transition to TCP_ESTABLISHED in both directions. =
 If the
> > > > peer is not using Linux, there might be a small latency before ACK =
though.
> > >
> > > I'm curious to learn in which scenarios the peer is not running Linux=
:
> > > out of sheer ignorance on my side I thought simult-connect was only
> > > possible - or at least made any sense - only on loopback.
> >
> > This is the case in the scenario used in the packetdrill test included
> > in this changelog,
> > but in general simultaneous connect() can be attempted from two differe=
nt hosts.
>
> I understand that. I also thought such thing belonged to protocol's
> edge cases nobody would dare to really use. Why doing that instead of
> more usual client-server connection?

Long time ago, I heard that this could be used to establish p2p TCP flows,
from hosts behind NAT and some firewalls.

Presumably Kuniyuki company/customers rely on such RFC-compliant behavior.

Also, fuzzers definitely want to stress this part of our stack, and
this is a lot of fun.


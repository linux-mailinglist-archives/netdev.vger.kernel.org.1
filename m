Return-Path: <netdev+bounces-109125-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78D6992712E
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 10:04:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3ACA728557D
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 08:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E89A31A38DD;
	Thu,  4 Jul 2024 08:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F3B0bNaU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A4318637
	for <netdev@vger.kernel.org>; Thu,  4 Jul 2024 08:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720080257; cv=none; b=sEELdGdNUifnl8+c8Oh34AskyKR3SF+mQ5Zs2u6tDfFLt6WQec4j61RYnbUTr3PinYSKmndIsDuv1foHtRQ5AVNymdbTKyKAqdSIycJqZdga8YQV3VfjgYBdxfBGLkA9IWWYKOy8LIxhciUDKjawkKgpqSQsdcjeEqAWd5tX+xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720080257; c=relaxed/simple;
	bh=X8Nvwnry3ZtclcKkURzGHqDBNDVeubDhgR7zus364WA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lHMukOZvGNwpGqF8l0Hbc4be/lkossIYt8Qpl1zEin7UU+1Iv5FIncvV6HkSTJt349UHW9n6SZdZCs8jPnOB4l2+iaZqTv2OYHIvC2poCLf8Bv6QJVQzRlVhD1gTHfiKDev1/gJHTPIwkm4cxAOErqEIUclIxI56d66xPiBQqnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F3B0bNaU; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-58c0abd6b35so8178a12.0
        for <netdev@vger.kernel.org>; Thu, 04 Jul 2024 01:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720080254; x=1720685054; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RPGE/f0QlpkOWQ4atNnaNMQy13aJF11uyVpAoOxPUWc=;
        b=F3B0bNaUjJ/TozeTx+tWo7wYGVyAfzigrtmelaz7iLoVUoMrFp0g9ce/zdxW+nfKGC
         jyvqqeUKwlXjM/bhfimNbvcm25jhU3yWN9J6Bsf6W+SqBVJ1CMIdRaUzpRQjA8fgrGKz
         QzS2oAC5y9OofDfe6OtBkmi4ssi57T2FhPvHYpWBDLIJj5b0vNq5aNKUpkn5WLxLGqMf
         PI0VadCfablmFCzpH6Eae2fXNrBbQmMgZ6494sa+Zn7MC+A7Z0fVcVzSdtAE5PDo6N2E
         TeCOLXczQwUqFFqp4Tq4UuTUMEihADDoSbZ84RchQQx2+rETQqA07YC6LJV6qfcXRrcp
         FAfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720080254; x=1720685054;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RPGE/f0QlpkOWQ4atNnaNMQy13aJF11uyVpAoOxPUWc=;
        b=QrywBahP4Upg0qd+7MZsZv+EaRrb8AVsU/Iku3/m0XYGq/5WtZbjqDt6kaofteOD83
         ogDIsa0tCt7R8w8+bReqjqTd/AR2Y3XoeofVXgKaohDmNXtc915l4I95UhPAwAqtwIov
         mCPPJBLoqdwW2hxiqfBm/GmhcDHAmAC04gDuNv260VYGZFQtXL8qq4qG52xBAdI2n0kb
         jfM1M+hFFnOTLZ6CAFUaiHXFRUjkiUJmktnZeD9VeL1tJNMWraKkspgiCvzoVioJ5vIR
         UHPRfWz8cUrf6yUrFURF5+gNZUZtrgROXBx+UNz7mu+kIZsJAgEul+YpxTOAKTgqI2E5
         BjFw==
X-Forwarded-Encrypted: i=1; AJvYcCXwgZogCrEJW1KVoPBjYLvzVnZ3biyCTv+a3Phh7EwAuxIzCYQLP4Agr8zDayr2LJWFUhED6xkBddPajNqH7zNpTpgjCUSc
X-Gm-Message-State: AOJu0YwXOa3gFywAqO3zsllUMp2sPjsj/ZiYswnV+uOUmBmjqkWTBwqU
	dXQtwOI9VYI2qFc/YQ54NrKslTXoav6ugCuLZv8jxAIi3M6C5HpCqW5lVES6hqhD2LqE/Zho0Wf
	Ig3V3a/bGWsnpzCsG52JwOIFsUDOK/c9tdNNv
X-Google-Smtp-Source: AGHT+IF96sV5pwdSNQs/l34IdsBVnKSQkuWWuRkifaaGVgliAM2C9ZrZfH9nPnA4/9eoe7IN9mXLfWhqzeAXBnwKTJQ=
X-Received: by 2002:a50:a6d0:0:b0:58b:dfaa:a5cd with SMTP id
 4fb4d7f45d1cf-58e00a27d70mr92635a12.2.1720080254127; Thu, 04 Jul 2024
 01:04:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240704035703.95065-1-kuniyu@amazon.com> <98087e1ae7e1d63a05c9275c54ca322d9f53a2aa.camel@redhat.com>
In-Reply-To: <98087e1ae7e1d63a05c9275c54ca322d9f53a2aa.camel@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 4 Jul 2024 10:03:58 +0200
Message-ID: <CANn89i+pwejq4Kt9h-m4cDEvDeOUC9k5RXJUcUp=fEZm=ojhfw@mail.gmail.com>
Subject: Re: [PATCH v1 net] tcp: Don't drop SYN+ACK for simultaneous connect().
To: Paolo Abeni <pabeni@redhat.com>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, David Ahern <dsahern@kernel.org>, Lawrence Brakmo <brakmo@fb.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 4, 2024 at 10:01=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On Wed, 2024-07-03 at 20:57 -0700, Kuniyuki Iwashima wrote:
> > RFC 9293 states that in the case of simultaneous connect(), the connect=
ion
> > gets established when SYN+ACK is received. [0]
> >
> >       TCP Peer A                                       TCP Peer B
> >
> >   1.  CLOSED                                           CLOSED
> >   2.  SYN-SENT     --> <SEQ=3D100><CTL=3DSYN>              ...
> >   3.  SYN-RECEIVED <-- <SEQ=3D300><CTL=3DSYN>              <-- SYN-SENT
> >   4.               ... <SEQ=3D100><CTL=3DSYN>              --> SYN-RECE=
IVED
> >   5.  SYN-RECEIVED --> <SEQ=3D100><ACK=3D301><CTL=3DSYN,ACK> ...
> >   6.  ESTABLISHED  <-- <SEQ=3D300><ACK=3D101><CTL=3DSYN,ACK> <-- SYN-RE=
CEIVED
> >   7.               ... <SEQ=3D100><ACK=3D301><CTL=3DSYN,ACK> --> ESTABL=
ISHED
> >
> > However, since commit 0c24604b68fc ("tcp: implement RFC 5961 4.2"), suc=
h a
> > SYN+ACK is dropped in tcp_validate_incoming() and responded with Challe=
nge
> > ACK.
> >
> > For example, the write() syscall in the following packetdrill script fa=
ils
> > with -EAGAIN, and wrong SNMP stats get incremented.
> >
> >    0 socket(..., SOCK_STREAM|SOCK_NONBLOCK, IPPROTO_TCP) =3D 3
> >   +0 connect(3, ..., ...) =3D -1 EINPROGRESS (Operation now in progress=
)
> >
> >   +0 > S  0:0(0) <mss 1460,sackOK,TS val 1000 ecr 0,nop,wscale 8>
> >   +0 < S  0:0(0) win 1000 <mss 1000>
> >   +0 > S. 0:0(0) ack 1 <mss 1460,sackOK,TS val 3308134035 ecr 0,nop,wsc=
ale 8>
> >   +0 < S. 0:0(0) ack 1 win 1000
> >
> >   +0 write(3, ..., 100) =3D 100
> >   +0 > P. 1:101(100) ack 1
> >
> >   --
> >
> >   # packetdrill cross-synack.pkt
> >   cross-synack.pkt:13: runtime error in write call: Expected result 100=
 but got -1 with errno 11 (Resource temporarily unavailable)
> >   # nstat
> >   ...
> >   TcpExtTCPChallengeACK           1                  0.0
> >   TcpExtTCPSYNChallenge           1                  0.0
> >
> > That said, this is no big deal because the Challenge ACK finally let th=
e
> > connection state transition to TCP_ESTABLISHED in both directions.  If =
the
> > peer is not using Linux, there might be a small latency before ACK thou=
gh.
>
> I'm curious to learn in which scenarios the peer is not running Linux:
> out of sheer ignorance on my side I thought simult-connect was only
> possible - or at least made any sense - only on loopback.

This is the case in the scenario used in the packetdrill test included
in this changelog,
but in general simultaneous connect() can be attempted from two different h=
osts.


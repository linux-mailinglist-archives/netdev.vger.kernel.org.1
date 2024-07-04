Return-Path: <netdev+bounces-109139-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 14BF5927189
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 10:15:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78A43B24920
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 08:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26CF31A3BDC;
	Thu,  4 Jul 2024 08:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="azJgRog1"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B0D1A3BD2
	for <netdev@vger.kernel.org>; Thu,  4 Jul 2024 08:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720080863; cv=none; b=Ob4g5P9W/4e93ReRxXQ4v1gEICTmZaiR15hZK0+1Mkmyx2wJLQHxbup5PMSrxeGtK6zXQlkAOPM+ejEU6fmmqPFBlH32pR0bMtkgs8kGgegbdexBMj+ejQixR91n8+/mDshQN51TNJxS8lCopYeRKkjfDP/R5uL5uYpgPXRGumI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720080863; c=relaxed/simple;
	bh=AbvX/DO4Fstlore6EHkApYrLLhEJPwOJEI8OEplJ3cc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SwqrXcBhkCyZL+O3EBoElSG1oNNgs/3o2xEOShcYcskiVCp7PLteZBYRxrJ5R2OtN0fiF8oxsxTlps28h7olE5ryq7wAou9V1G9anogUd4fIgCNpoIL29RWYZfm+hIImwm816AY+sdZjV6tfAQiEAqwMjXjMHc7/p6hY2v7Fedo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=azJgRog1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720080860;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=dqRXlZMSElNEREoWSZ4Da/oS0Vsj3ObLsNY9MCdSPWc=;
	b=azJgRog13virNcVZijYOfYtlBFGutd/vk0/ZHxJzUt4+j8b2yYdugCrbYju7k7TMfJJIaC
	j6REisjcR9fB6ovymAdJ8Ox2bbjP5v1dETPLVzCZGTTfkqhbLKW6spAGKUcvWF2nx60osV
	4lN8+bSLoiJWVFtqfY9gKegaUgL5U/o=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-410-88mtFpMrMUSp5wj-HZpNFg-1; Thu, 04 Jul 2024 04:14:19 -0400
X-MC-Unique: 88mtFpMrMUSp5wj-HZpNFg-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-367a19f9fd7so7193f8f.3
        for <netdev@vger.kernel.org>; Thu, 04 Jul 2024 01:14:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720080857; x=1720685657;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dqRXlZMSElNEREoWSZ4Da/oS0Vsj3ObLsNY9MCdSPWc=;
        b=glESpYZB1jwP+KejF2bKjSdCtIVlRdN+3SsdDzluCkAfpRj0yjbXi1TaG7T1UEUb4Q
         b1Spi5FpdzH0ro3FOmm4AzaBfZPUmpYDt1NUHPBxdFfXiM8u9YYcvwDurqusPfe7wX3s
         qeC230CddD+WR0oDTIiZYP1vJpOMcCIRFhG98E+VCSkkfG7rxHO7KS6URgRzdaJAwDNs
         nDahPxT/OalAquSwj+CXmAqJLfcTuBHfEf5IKnJHMj1UYt07lO/GJ8sZeEeXkvn4EQlm
         JzolbYSnGtSOwbrZlh5OQHlwJNkyFsKsiZPRIkllTaUHHejBoXU6E3nj6TDfto8vjLcT
         e70w==
X-Forwarded-Encrypted: i=1; AJvYcCXEn2x5b+qDr0GbmW4rGmry1CGZ0ruCbKlPVIofmXmECVf7VMeCVZK2jWB8xPJ3WYdcLBvlh5V80mLpVj/cdmD+OwqvfM11
X-Gm-Message-State: AOJu0Yz7mPvVy+ckeN4B7vAdEHRWF7tECjrfDC3KSdVc+scTA7QdpGLx
	oPOe+F66xM4yvD0vc/Rqyldt0mtrTP3zskp+UMmuhKEPaF762adSylTvgY3XzJT4PnJxdIoFZ4F
	HOlw7PSJ/ah9y/8o3dDrI/nKMyApKnFBf9xYWs4asgcavuT7J3TIQEZcLO+5QYw==
X-Received: by 2002:a05:600c:35d2:b0:422:78c:82f6 with SMTP id 5b1f17b1804b1-4264a467de7mr7152175e9.3.1720080857697;
        Thu, 04 Jul 2024 01:14:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHiO+86hEMqv4PahF9GFvzUzYHG/6dLJEcTQweGVi7gfpQ7gFzYjC0sdV+OlkvKzLhxLVRAng==
X-Received: by 2002:a05:600c:35d2:b0:422:78c:82f6 with SMTP id 5b1f17b1804b1-4264a467de7mr7151975e9.3.1720080857263;
        Thu, 04 Jul 2024 01:14:17 -0700 (PDT)
Received: from gerbillo.redhat.com ([2a0d:3344:172b:1510:dd78:6ccd:a776:5943])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a184537sm14160195e9.0.2024.07.04.01.14.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 01:14:16 -0700 (PDT)
Message-ID: <05cf321aa7d33124a17b4c75d92d5f8c67286871.camel@redhat.com>
Subject: Re: [PATCH v1 net] tcp: Don't drop SYN+ACK for simultaneous
 connect().
From: Paolo Abeni <pabeni@redhat.com>
To: Eric Dumazet <edumazet@google.com>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, "David S. Miller"
	 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, David Ahern
	 <dsahern@kernel.org>, Lawrence Brakmo <brakmo@fb.com>, Kuniyuki Iwashima
	 <kuni1840@gmail.com>, netdev@vger.kernel.org
Date: Thu, 04 Jul 2024 10:14:14 +0200
In-Reply-To: <CANn89i+pwejq4Kt9h-m4cDEvDeOUC9k5RXJUcUp=fEZm=ojhfw@mail.gmail.com>
References: <20240704035703.95065-1-kuniyu@amazon.com>
	 <98087e1ae7e1d63a05c9275c54ca322d9f53a2aa.camel@redhat.com>
	 <CANn89i+pwejq4Kt9h-m4cDEvDeOUC9k5RXJUcUp=fEZm=ojhfw@mail.gmail.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-07-04 at 10:03 +0200, Eric Dumazet wrote:
> On Thu, Jul 4, 2024 at 10:01=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> w=
rote:
> >=20
> > On Wed, 2024-07-03 at 20:57 -0700, Kuniyuki Iwashima wrote:
> > > RFC 9293 states that in the case of simultaneous connect(), the conne=
ction
> > > gets established when SYN+ACK is received. [0]
> > >=20
> > >       TCP Peer A                                       TCP Peer B
> > >=20
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
> > >=20
> > > However, since commit 0c24604b68fc ("tcp: implement RFC 5961 4.2"), s=
uch a
> > > SYN+ACK is dropped in tcp_validate_incoming() and responded with Chal=
lenge
> > > ACK.
> > >=20
> > > For example, the write() syscall in the following packetdrill script =
fails
> > > with -EAGAIN, and wrong SNMP stats get incremented.
> > >=20
> > >    0 socket(..., SOCK_STREAM|SOCK_NONBLOCK, IPPROTO_TCP) =3D 3
> > >   +0 connect(3, ..., ...) =3D -1 EINPROGRESS (Operation now in progre=
ss)
> > >=20
> > >   +0 > S  0:0(0) <mss 1460,sackOK,TS val 1000 ecr 0,nop,wscale 8>
> > >   +0 < S  0:0(0) win 1000 <mss 1000>
> > >   +0 > S. 0:0(0) ack 1 <mss 1460,sackOK,TS val 3308134035 ecr 0,nop,w=
scale 8>
> > >   +0 < S. 0:0(0) ack 1 win 1000
> > >=20
> > >   +0 write(3, ..., 100) =3D 100
> > >   +0 > P. 1:101(100) ack 1
> > >=20
> > >   --
> > >=20
> > >   # packetdrill cross-synack.pkt
> > >   cross-synack.pkt:13: runtime error in write call: Expected result 1=
00 but got -1 with errno 11 (Resource temporarily unavailable)
> > >   # nstat
> > >   ...
> > >   TcpExtTCPChallengeACK           1                  0.0
> > >   TcpExtTCPSYNChallenge           1                  0.0
> > >=20
> > > That said, this is no big deal because the Challenge ACK finally let =
the
> > > connection state transition to TCP_ESTABLISHED in both directions.  I=
f the
> > > peer is not using Linux, there might be a small latency before ACK th=
ough.
> >=20
> > I'm curious to learn in which scenarios the peer is not running Linux:
> > out of sheer ignorance on my side I thought simult-connect was only
> > possible - or at least made any sense - only on loopback.
>=20
> This is the case in the scenario used in the packetdrill test included
> in this changelog,
> but in general simultaneous connect() can be attempted from two different=
 hosts.

I understand that. I also thought such thing belonged to protocol's
edge cases nobody would dare to really use. Why doing that instead of
more usual client-server connection?

Thanks,

Paolo



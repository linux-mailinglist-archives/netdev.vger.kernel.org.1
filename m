Return-Path: <netdev+bounces-109203-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA4C99275DC
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 14:23:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19A7B1C22F9F
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 12:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42FDF1ABCC4;
	Thu,  4 Jul 2024 12:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X+wgQKBo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855B51A072E
	for <netdev@vger.kernel.org>; Thu,  4 Jul 2024 12:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720095806; cv=none; b=WwqeN0a5id247XzvlN8vDInGNcrxcHtShKiTdiDHQKEiOQMG97SAs4TB8rGQRJbs33kFk+nP7zEFovkBbAnjnkkM2JI+7JT9LDj/hqZkzuDww/aUtfhyqal6nznzR8VJv7feO5rEpC/WcPyXaBalbPaO1Y260fxyxnYgVBS0dEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720095806; c=relaxed/simple;
	bh=P/7WUUah2ylD8u9g6ueacZdQmHgLe3HDXoi6Y8Gzqzk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hAKkLJu4ytvhQ+U/htIfFUHPOviIR/MKHi+w1Ma4onq7uHCtW/i/HB6HC1heRsBTBNy9gRZMpIF9Zlf5EOtgobBrvHNUIahQEr9lfcIDcZn8mjJxo76xJoC8jrD7ctVjc6EtV5d/aa0A0unJbC8XcOS6Zac1+jrevGlV04KaRac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X+wgQKBo; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-58ce966a1d3so8736a12.1
        for <netdev@vger.kernel.org>; Thu, 04 Jul 2024 05:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720095803; x=1720700603; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/hX9K9IyzuNVorPZbqs6R5CkF934QKkB7aeWBDN/oZM=;
        b=X+wgQKBo7b14r8virJ2yRYnKAbXx2x/2F5Jy1qMBLNO/BbhELgNSGNYWJ9K0s1DgUs
         lF9oykOQpe5osQLeLx5CYCiRAcFEmt2JlRiImcn6w/g72EjeVv4yhhnCShpoMzX8iCRV
         fQqlJZ6dgzAWSJP/RDve1bc9OYqRBjdXiYMyIeeUs75tmoc/pbu8LW/acBaov5HWNG4L
         449ZD25zjc/nUyLePi5g1RDS2aphqMqXtqdFVpgHrwtVFXG57ZYVEjktJlbZayRp1hWe
         tA5Hc+Oog4FK75kkfABZFCOZxXZgQVaH3BLN8Vu4OcYjitVKsBE3aRJS7RdDToOkVDol
         kyxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720095803; x=1720700603;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/hX9K9IyzuNVorPZbqs6R5CkF934QKkB7aeWBDN/oZM=;
        b=wqysxyvoZA5+2HN5AqV43t2xvjdyqf7Wiqyw2kEX+pMXiLP8plsCyvQ/2JHZ/d1Ywr
         41WqwdN3a8S+UGAiwOpPwkuyJTvBgVrM0l+34QFZmQodEIV44vpGmXOVMyw+2fhyWLpI
         Wg4Pp1d2fIH4iGPndMZuZMK1Bjx9WA1Ie1wmxhgGVw5prg6co2yELI5G+pDvvvMOim4H
         V9TXCjayPLaoiugKLTUTM65skXrbHTNdizK1hXxGAXNI0QKmnJK6MAM3XUbQAe96i6Wl
         /RR4YZj1qJPBPSZFANebcMf0uO7zIFuOUtWiVTnsM7QTqN6qwAploPaNffiEf7FJmj3A
         tjGw==
X-Forwarded-Encrypted: i=1; AJvYcCWzbP6o/vYhvH69MDvDg2Ee07EDKIwGrjbBNifKAYtF4zlruQ647+2nEZSmhFwiFT89PQMhp97SCArHnBzsnB/iiDSR5Umn
X-Gm-Message-State: AOJu0Yw9DOPKbId+DI1OrJ9Oojy3/hITLG1mH3SGxb3d6NVXsZfYxkSB
	+0tK2GKFHq2dSU6Dj0a6D4PFR8aDeyXr3NmspiG+d9VFh+bNG+ryAMccvakAawgS2ogeF7VyQgF
	hcvf7PKa8l1PN/e8Tf0EGRHTfIP0DWzQ+f+qX
X-Google-Smtp-Source: AGHT+IEejRBeobtILfbLRV01p0azcsLsKDMQwXzlRBasC/j+KIpzciwn0RMzXafWbVSN4Uu8QTSTf5bcI/bIHAlay48=
X-Received: by 2002:a50:954f:0:b0:58b:93:b623 with SMTP id 4fb4d7f45d1cf-58e2942d69cmr102605a12.5.1720095802541;
 Thu, 04 Jul 2024 05:23:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240704035703.95065-1-kuniyu@amazon.com> <7c1264b94e70d591adfda405bf358ba1dfadafd5.camel@redhat.com>
In-Reply-To: <7c1264b94e70d591adfda405bf358ba1dfadafd5.camel@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 4 Jul 2024 14:23:11 +0200
Message-ID: <CANn89iKO=Y8P_tms-nymhLF8QbWmOD-g_N33DLMfA6WcO+vhbg@mail.gmail.com>
Subject: Re: [PATCH v1 net] tcp: Don't drop SYN+ACK for simultaneous connect().
To: Paolo Abeni <pabeni@redhat.com>, Dmitry Safonov <0x7f454c46@gmail.com>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, Lawrence Brakmo <brakmo@fb.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, David Ahern <dsahern@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 4, 2024 at 1:16=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wrot=
e:
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
> >
> > The problem is that bpf_skops_established() is triggered by the Challen=
ge
> > ACK instead of SYN+ACK.  This causes the bpf prog to miss the chance to
> > check if the peer supports a TCP option that is expected to be exchange=
d
> > in SYN and SYN+ACK.
> >
> > Let's accept a bare SYN+ACK for non-TFO TCP_SYN_RECV sockets to avoid s=
uch
> > a situation.
>
> Apparently this behavior change is causing TCP AO self-tests failures:
>
> https://netdev.bots.linux.dev/contest.html?pw-n=3D0&branch=3Dnet-next-202=
4-07-04--09-00
> e.g.
> https://netdev-3.bots.linux.dev/vmksft-tcp-ao-dbg/results/668061/22-self-=
connect-ipv4/stdout
>

These tests seem to have broken assumptions on a kernel behavior which
are orthogonal to TCP AO.

> Could you please have a look?
>
> Thanks!
>
> Paolo
>


Return-Path: <netdev+bounces-109983-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B3BD92A91A
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 20:43:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D10DBB20A97
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 18:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAC8F14A4D4;
	Mon,  8 Jul 2024 18:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="chae+7sM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA62015A8
	for <netdev@vger.kernel.org>; Mon,  8 Jul 2024 18:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720464183; cv=none; b=h1e5OExwbrMq3ZLwkGpnyUoUkSdHf5Gg+VprB7R5YUYrYgIB0e56yjG66/X8tGqZDEX7AlMkIz0SA5Qm+6LW36JJb2D+LIJJ1waSdUKsKoHgIG8fuIkH3j8IpBRsU32Lq0tIRbNZA0bUMfbZzWSVDsxLMiG63ixasewCHdGSVzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720464183; c=relaxed/simple;
	bh=CkuY5i/T4s2q6aXFI7O1x3dsDcouSEP6h1wdqMo6Sf8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LiacnEp9wM+jb5EmxVbmxJhzHLicyo6P5uYYB5s+W6QiA/X+fNEEIQrg0ib0xoBU+hiOhA2csPjEPyVMPvS36uvceWosfTp17ZWjOlP16bJmlwrtgyEORjILNBfWM5eitmQhPQprX1QPrsrLQXEd2SIcmvLUCJJ5jOEFbkKMOF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=chae+7sM; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-57a16f4b8bfso2706a12.0
        for <netdev@vger.kernel.org>; Mon, 08 Jul 2024 11:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720464180; x=1721068980; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a16Lj8ws5ivE1eVCLRi77bYox53mX49eZdrhv4am2jc=;
        b=chae+7sMuuir5y3d5lxs3UpVrBUECTzFd+wyPYQkJbxX0SdHv1S/2G8EKw80OHK7O0
         V+2BZx/uxrUdKDqtYJtEPFmJH/FmocXmExm3iEFZ/FRJLym+dCUWWQ1MsZhdlRjTRZ+q
         Drs/m8ETdpwpn/R3d59LnTh7504FuazG50m5cQUgO3iSF/Nyou/qjzvARFKdiBq1Tny5
         ZVaI9p2f6QS+tMXUBU6ud0kxXjib4uaH6ZQu314jLnUNSLAuDL3Bfh8QnHd9Dfc2FrdE
         F5bs5NP4LeGmKlUk2NxpD6iMFVtFCf3stTiykNfJ1vMtxxjdlaPk1SNKn+kxhGenka93
         3r8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720464180; x=1721068980;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a16Lj8ws5ivE1eVCLRi77bYox53mX49eZdrhv4am2jc=;
        b=eh2z5Meu24ld/D5D54BZ9I27FdNWhcdisg7BDNrRke/EycM8XIhJ6NBxzP2aMbNbdl
         7LOg2u3bjt/j0rZfK5en5ADy1Yd29JSZfHkTH5Q2YGHkeWA3C0aZQraWm+ux/FyJrlPl
         VRCYDauGYvadFMLgAvdEGmlzGuTvuoCpeB/T7775+f+b4YnBW1FE98myVSQ+w2w1nWKb
         vvMHZnlCMHZ1GGybPdaNionJMBmLRY56VDijWof3LA2Gvgb9j9XvkTuwhgunUEVI/o9r
         azMR29kIKBzuN/P2ax4VlzXItlh2IUNvA1ElGivxN+UFFRlX9BZ7DXMdefNbODi78amx
         Xc5Q==
X-Forwarded-Encrypted: i=1; AJvYcCX4L6ZcHmKDJ14/qGCJ1SjCWof/i5XS4O5A06mYl4RCEO9qbxSD93wecsBpC3bgLmxaep2qPfWnuFBMooe6Ixj+RyVnpI1W
X-Gm-Message-State: AOJu0YxX97lD8l8X4lWM+X5xwwl/9/j0UuwdsEm48r9nN56dVkfqP+ZF
	pmfeByw44dK8rsyxHwxPpb1hsRiUT8dg3ZxOFpwfHZx9njzefd5n63VLedN2nsWIXFlripQcmPQ
	66O7J76MxUB0HBSHgMfNE/UH1kbXDXgjpiwWv
X-Google-Smtp-Source: AGHT+IHzWx4O095foH0a8hI2afU5xVH0alypxyznPH+QMwQT5bYMl6Gc+zD1pBiZzt1+WMbNMwJaXDJ/GPoze0sAxaQ=
X-Received: by 2002:a50:aa97:0:b0:58b:90c6:c59e with SMTP id
 4fb4d7f45d1cf-594d787a417mr16737a12.7.1720464179067; Mon, 08 Jul 2024
 11:42:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240708180852.92919-1-kuniyu@amazon.com> <20240708180852.92919-2-kuniyu@amazon.com>
In-Reply-To: <20240708180852.92919-2-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 8 Jul 2024 11:42:48 -0700
Message-ID: <CANn89iLtDQ7edCAkmswFtHeQFA9ptwe8jCotaF0bdvhGaLj=2A@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 1/2] tcp: Don't drop SYN+ACK for simultaneous connect().
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, Dmitry Safonov <dima@arista.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 8, 2024 at 11:09=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> RFC 9293 states that in the case of simultaneous connect(), the connectio=
n
> gets established when SYN+ACK is received. [0]
>
>       TCP Peer A                                       TCP Peer B
>
>   1.  CLOSED                                           CLOSED
>   2.  SYN-SENT     --> <SEQ=3D100><CTL=3DSYN>              ...
>   3.  SYN-RECEIVED <-- <SEQ=3D300><CTL=3DSYN>              <-- SYN-SENT
>   4.               ... <SEQ=3D100><CTL=3DSYN>              --> SYN-RECEIV=
ED
>   5.  SYN-RECEIVED --> <SEQ=3D100><ACK=3D301><CTL=3DSYN,ACK> ...
>   6.  ESTABLISHED  <-- <SEQ=3D300><ACK=3D101><CTL=3DSYN,ACK> <-- SYN-RECE=
IVED
>   7.               ... <SEQ=3D100><ACK=3D301><CTL=3DSYN,ACK> --> ESTABLIS=
HED
>
> However, since commit 0c24604b68fc ("tcp: implement RFC 5961 4.2"), such =
a
> SYN+ACK is dropped in tcp_validate_incoming() and responded with Challeng=
e
> ACK.
>
> For example, the write() syscall in the following packetdrill script fail=
s
> with -EAGAIN, and wrong SNMP stats get incremented.
>
>    0 socket(..., SOCK_STREAM|SOCK_NONBLOCK, IPPROTO_TCP) =3D 3
>   +0 connect(3, ..., ...) =3D -1 EINPROGRESS (Operation now in progress)
>
>   +0 > S  0:0(0) <mss 1460,sackOK,TS val 1000 ecr 0,nop,wscale 8>
>   +0 < S  0:0(0) win 1000 <mss 1000>
>   +0 > S. 0:0(0) ack 1 <mss 1460,sackOK,TS val 3308134035 ecr 0,nop,wscal=
e 8>
>   +0 < S. 0:0(0) ack 1 win 1000
>
>   +0 write(3, ..., 100) =3D 100
>   +0 > P. 1:101(100) ack 1
>
>   --
>
>   # packetdrill cross-synack.pkt
>   cross-synack.pkt:13: runtime error in write call: Expected result 100 b=
ut got -1 with errno 11 (Resource temporarily unavailable)
>   # nstat
>   ...
>   TcpExtTCPChallengeACK           1                  0.0
>   TcpExtTCPSYNChallenge           1                  0.0
>
> The problem is that bpf_skops_established() is triggered by the Challenge
> ACK instead of SYN+ACK.  This causes the bpf prog to miss the chance to
> check if the peer supports a TCP option that is expected to be exchanged
> in SYN and SYN+ACK.
>
> Let's accept a bare SYN+ACK for non-TFO TCP_SYN_RECV sockets to avoid suc=
h
> a situation.
>
> Note that tcp_ack_snd_check() in tcp_rcv_state_process() is skipped not t=
o
> send an unnecessary ACK, but this could be a bit risky for net.git, so th=
is
> targets for net-next.
>
> Link: https://www.rfc-editor.org/rfc/rfc9293.html#section-3.5-7 [0]
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>


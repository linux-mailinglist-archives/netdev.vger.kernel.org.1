Return-Path: <netdev+bounces-97499-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 572D58CBB98
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 08:53:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD44E1F21E77
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 06:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD32474E3D;
	Wed, 22 May 2024 06:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MFcdvufT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1610918C3D
	for <netdev@vger.kernel.org>; Wed, 22 May 2024 06:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716360798; cv=none; b=gwV1+Kwnn5L7Ny/xI4FOhojixpHifIysBLzm2b2edZYjNnPeMYypnqjX7DtqBakS8rgxNy8o6bK6LlWTA6B3+kOpswtUPXPiUVOS2o3FmtS+cR1rh1OkFJPVkYED2DBlUdcTB9T0WCF+nJhPowAhULRyfCPJxXMGnuFMgUWtvQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716360798; c=relaxed/simple;
	bh=oeUovsot+OOiLAdgtQE3S/UYm5FOLspEJzZnOWYf1OE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OJjwciewweTLHJIdi+CN4rKU/a42D1S23ORGijX89ELkMSUp928f9emqwqQtq2ohY5AaZw4JL31iOnUc6BVtiOkg/5pOF2okO4Zyq43yPwdX22wz0YVZ3NVLjzJTWHuUoatcmn22Wmonr7PzUXqHDCLCEiE+dY+rJ5y4trJIXpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MFcdvufT; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-572f6c56cdaso10432a12.0
        for <netdev@vger.kernel.org>; Tue, 21 May 2024 23:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716360795; x=1716965595; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oh+OKMRlBER3+DsLKJFvr71KdWJLr6Csi9m9hfPnhmc=;
        b=MFcdvufTNbfV/pWp6YSabCLqRXAPMoLzUq9EJTt60dprZY+pHNnUbjDU+crZ648OU3
         nLlHNf0cOORpsTUajXRsLYc+pYK+idXeOYukFKd4GapLQDPGYcUTLmZiWapNY5kspb6M
         UiJxK8c37q9s5sIS3A8E0/2tPcr/S/NGq+kFv+wBFf0IR92LnJ3R92YRzRv0UHzz66ZZ
         L20d2hmRK3lMIV9a6V0ilSRDmvd9Hz4QI2r2kXNJQmEnhw2FePX+kQKb4KmehtEO/RN+
         zk+mRHjsOyFYyaNMZRQUtwXEWqLp5g8s53aRXfHTDZgbntSUqJdenxaySYMDik16Mxcr
         oefg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716360795; x=1716965595;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oh+OKMRlBER3+DsLKJFvr71KdWJLr6Csi9m9hfPnhmc=;
        b=mr1d6ZTrYlOFLj4fdRWP6cqRllYH4/0DJZznoDky7OmHp5ZbPROV8hzBA03dFN+q8p
         bDeNK551EC8OWe8izMQBw7Cbdqm9q5lNG2h6Bp5rzIwsPu1yD7IivTCH4sV77V+/qVVe
         P0riFUKDcWSnW+1QeOlxcQydwhNMYuLYRUKnyKaRx9o6OCHAxN29lwna7BGuM4lqYpui
         TeB82+w/k/zwhM9HRioGiGhnNCOsjVc6skNQM3NIdPW1kOSfOW4kZBy7XIdfMvNmsMZ+
         fBHxdC9Oi7Gb8tJayf1ijGo3Zgg9lmpbYVcvB8g8sz1aNDtL/CJfXh9Epx2i8MkvJzTI
         vtVA==
X-Gm-Message-State: AOJu0Yx3W9p8Ke08XkWGQuDmX2nNzKaG8+DEDEKspt95GQSnELByfRzY
	XzxLlPB7655mHNb01uO2IUO0TYRxOFwVF+fkxdeC6SdWoiqZLRwiHcCj9HSwMKdw7ATOG3te8as
	FXBRiRo6AnAe4tjuE4LIRCmGd7TgOg8dInDQ3
X-Google-Smtp-Source: AGHT+IGlMh1+xKdfOpLqKv70kJDmrx49AvcbsYd2cHojU26nhU2fbPgTQbIk3z9ifWGjjh/NrQyM30Hts5Y0cpILuGc=
X-Received: by 2002:a05:6402:50cf:b0:572:57d8:4516 with SMTP id
 4fb4d7f45d1cf-5782f9f7e7bmr139633a12.2.1716360795072; Tue, 21 May 2024
 23:53:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <23ab880a44d8cfd967e84de8b93dbf48848e3d8c.1716299669.git.pabeni@redhat.com>
In-Reply-To: <23ab880a44d8cfd967e84de8b93dbf48848e3d8c.1716299669.git.pabeni@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 22 May 2024 08:53:04 +0200
Message-ID: <CANn89i+fuYw=JOZxs7GB=g1nvZrH0VT0PQ7H6SrcVb5Y-tDimw@mail.gmail.com>
Subject: Re: [PATCH v2 net] net: relax socket state check at accept time.
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Christoph Paasch <cpaasch@apple.com>, Neal Cardwell <ncardwell@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 21, 2024 at 4:01=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> Christoph reported the following splat:
>
> WARNING: CPU: 1 PID: 772 at net/ipv4/af_inet.c:761 __inet_accept+0x1f4/0x=
4a0
> Modules linked in:
> CPU: 1 PID: 772 Comm: syz-executor510 Not tainted 6.9.0-rc7-g7da7119fe22b=
 #56
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.11.0-2.el7 =
04/01/2014
> RIP: 0010:__inet_accept+0x1f4/0x4a0 net/ipv4/af_inet.c:759
> Code: 04 38 84 c0 0f 85 87 00 00 00 41 c7 04 24 03 00 00 00 48 83 c4 10 5=
b 41 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc e8 ec b7 da fd <0f> 0b e9 7f fe=
 ff ff e8 e0 b7 da fd 0f 0b e9 fe fe ff ff 89 d9 80
> RSP: 0018:ffffc90000c2fc58 EFLAGS: 00010293
> RAX: ffffffff836bdd14 RBX: 0000000000000000 RCX: ffff888104668000
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: dffffc0000000000 R08: ffffffff836bdb89 R09: fffff52000185f64
> R10: dffffc0000000000 R11: fffff52000185f64 R12: dffffc0000000000
> R13: 1ffff92000185f98 R14: ffff88810754d880 R15: ffff8881007b7800
> FS:  000000001c772880(0000) GS:ffff88811b280000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fb9fcf2e178 CR3: 00000001045d2002 CR4: 0000000000770ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> PKRU: 55555554
> Call Trace:
>  <TASK>
>  inet_accept+0x138/0x1d0 net/ipv4/af_inet.c:786
>  do_accept+0x435/0x620 net/socket.c:1929
>  __sys_accept4_file net/socket.c:1969 [inline]
>  __sys_accept4+0x9b/0x110 net/socket.c:1999
>  __do_sys_accept net/socket.c:2016 [inline]
>  __se_sys_accept net/socket.c:2013 [inline]
>  __x64_sys_accept+0x7d/0x90 net/socket.c:2013
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0x58/0x100 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> RIP: 0033:0x4315f9
> Code: fd ff 48 81 c4 80 00 00 00 e9 f1 fe ff ff 0f 1f 00 48 89 f8 48 89 f=
7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff=
 ff 0f 83 ab b4 fd ff c3 66 2e 0f 1f 84 00 00 00 00
> RSP: 002b:00007ffdb26d9c78 EFLAGS: 00000246 ORIG_RAX: 000000000000002b
> RAX: ffffffffffffffda RBX: 0000000000400300 RCX: 00000000004315f9
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000004
> RBP: 00000000006e1018 R08: 0000000000400300 R09: 0000000000400300
> R10: 0000000000400300 R11: 0000000000000246 R12: 0000000000000000
> R13: 000000000040cdf0 R14: 000000000040ce80 R15: 0000000000000055
>  </TASK>
>
> The reproducer invokes shutdown() before entering the listener status.
> After commit 94062790aedb ("tcp: defer shutdown(SEND_SHUTDOWN) for
> TCP_SYN_RECV sockets"), the above causes the child to reach the accept
> syscall in FIN_WAIT1 status.
>
> Eric noted we can relax the existing assertion in __inet_accept()
>
> Reported-by: Christoph Paasch <cpaasch@apple.com>
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/490
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Fixes: 94062790aedb ("tcp: defer shutdown(SEND_SHUTDOWN) for TCP_SYN_RECV=
 sockets")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> v1 -> v2:
>  - relax the existing check instead of clearing sk_shutdown at listen
>    time
>    https://lore.kernel.org/netdev/8db98a8fbf2ac673b355651852093579a913f3f=
1.1716199422.git.pabeni@redhat.com/
>
> Note: I considered replacing the WARN_ON with WARN_ON_ONCE but we expect
> it should never trigger, and hopefully we will get rid of it on net-next,
> so I opted to avoid extra changes
> ---
>  net/ipv4/af_inet.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
> index 44564d009e95..86cce7e9c2d1 100644
> --- a/net/ipv4/af_inet.c
> +++ b/net/ipv4/af_inet.c
> @@ -758,7 +758,9 @@ void __inet_accept(struct socket *sock, struct socket=
 *newsock, struct sock *new
>         sock_rps_record_flow(newsk);
>         WARN_ON(!((1 << newsk->sk_state) &
>                   (TCPF_ESTABLISHED | TCPF_SYN_RECV |
> -                 TCPF_CLOSE_WAIT | TCPF_CLOSE)));
> +                  TCPF_FIN_WAIT1 | TCPF_FIN_WAIT2 |
> +                  TCPF_CLOSING | TCPF_CLOSE_WAIT |
> +                  TCPF_CLOSE)));
>
>         if (test_bit(SOCK_SUPPORT_ZC, &sock->flags))
>                 set_bit(SOCK_SUPPORT_ZC, &newsock->flags);
> --
> 2.43.2
>

Reviewed-by: Eric Dumazet <edumazet@google.com>


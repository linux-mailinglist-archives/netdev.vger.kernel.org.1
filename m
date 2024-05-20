Return-Path: <netdev+bounces-97204-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE90E8C9E98
	for <lists+netdev@lfdr.de>; Mon, 20 May 2024 16:08:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F56A1F22E99
	for <lists+netdev@lfdr.de>; Mon, 20 May 2024 14:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D1D113664B;
	Mon, 20 May 2024 14:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TUD/GvD0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23B445026
	for <netdev@vger.kernel.org>; Mon, 20 May 2024 14:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716214077; cv=none; b=CU0TdQ1sFZ6DaaalOQVKayohOPeOz8w27SPlHiv3/goa/Ar7jC9fiS/d4If24SCr6wIHuE4x+JyfMjNe/akS2G4on0wu0RdNHHVpG4/yYomIxB9IQhhAa0QFxUKpIUxbsyQfwuHdUCD5XbXYm/dG39Y3ux6Tv9EUda5NLuPUupU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716214077; c=relaxed/simple;
	bh=2Z/L+TYsPMukzUZFVHI5IKjhEOWCx+6ap1Aul9JhwFs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hgqtXb9h0EA6t3ysK983hlT43kS8kuOBkwYlFAEbzHqO98Uhxds8/LyJQ29swztDnzIflFNTreOLAzirNX29icstbrNK4No8Ew2UbXK4uO4bHDkZxfTHb8rPtjIP3dj8NfGvTUH+hWVlcELTzQkMJ2zOzpsbrzHnSFoWNIMJV/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TUD/GvD0; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5750a8737e5so13540a12.0
        for <netdev@vger.kernel.org>; Mon, 20 May 2024 07:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716214074; x=1716818874; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P4Y/M8Mynm54MFibFpghFKhMg+QcluQBXVhAkUsd7Nk=;
        b=TUD/GvD0B5uSRdipbFdiypeAEfdE0pVD0cp6/roQ8QiCWPaRtXmVYM+gW25y39yFzQ
         LXDQWfqwpPVkObJxAsxE+3z6W4CkYk82vNWDqQ2jNyF+Uswm/k3Z/4eYIz1DMiCBpQLv
         sQefRApOCNE4+VPWbtVlgXKx3i8W+9BAdP8klzPJTLpi2kSmFdGjwI1eKRw3KYKOLSMF
         v+6DSvR8dZrGKIrQKlBd3l9M8QfW+lwzmjeNXIvwYFYdRt1smSkD21e2snLTSaQPt6ZD
         iZiznjAifKKM81Wwq6/rbhGl8hVdCYfHOn5NNYW2kS39gxYE8sV33WrRBLcDFndwTxwP
         rgFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716214074; x=1716818874;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P4Y/M8Mynm54MFibFpghFKhMg+QcluQBXVhAkUsd7Nk=;
        b=cTQOQGYf4NDGJmqmS0Wde42tWNPsRnEEp/aRiKK+aHNiJFADBl9VXYudGUGo5e8AIo
         XM2M+1N2BaI5RfUizUYTflraLIfHDEfVU179Kdw9s8NS7yWDs3NeJ7xAXITSCOmMqrvI
         w8n9qAY8OD0ES3kIMt2oyRE5d7hquQX2og2v69LZfHCwWinDSASVphQSoY8W4alZrNkQ
         0oOFWImzjr3mmmehTefM7DMzCqF/obmGzc1jXxl3w6KnKx65ltJPBF4fpPUE2GiuHd3W
         CTZQssGf+yyHA93l+d+Xd1pIPJMa3RObNzpA/l9lCXFM8REKqUE/PEtcP83HlnBsm8Hm
         v1aw==
X-Gm-Message-State: AOJu0Yw0kqMHVtD2ER/gKxhaUnE+dEvV09zIO1dlz0bGL7VwRRZKwkbY
	OdBBVUyyKulpOuaGDvlb9x4FsD7dwyQDgNUUqF3jY5vyNrUXu/4wnVSJl8R6yIeXrRQDme+IcFZ
	sL/Bqxd5X8dCYkz1/JjQRy82Gm1lgGRjlBVji
X-Google-Smtp-Source: AGHT+IHgJSGreKgO81FPhHIDYnuQQCjwb3Vj8Eebvl4q9EKdsrjFZ1LbzODh/KRDF013n0kSwROryQdsgs85s3uXMAM=
X-Received: by 2002:aa7:d5cf:0:b0:573:438c:7789 with SMTP id
 4fb4d7f45d1cf-5752c401ed0mr250159a12.1.1716214073677; Mon, 20 May 2024
 07:07:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8db98a8fbf2ac673b355651852093579a913f3f1.1716199422.git.pabeni@redhat.com>
 <CANn89i+zxB9g7n3JWXd8B-kkSkfRWfb7mOQcQi+mMLs6U-n5tQ@mail.gmail.com>
In-Reply-To: <CANn89i+zxB9g7n3JWXd8B-kkSkfRWfb7mOQcQi+mMLs6U-n5tQ@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 20 May 2024 16:07:40 +0200
Message-ID: <CANn89iLM7xjUOJeA1mt2Ng2j6K2_9OLrc0014PM0U+TOKcvt0Q@mail.gmail.com>
Subject: Re: [PATCH net] tcp: ensure sk_showdown is 0 for listening sockets
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Christoph Paasch <cpaasch@apple.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 20, 2024 at 3:46=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Mon, May 20, 2024 at 12:05=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> =
wrote:
> >
> > Christoph reported the following splat:
> >
> > WARNING: CPU: 1 PID: 772 at net/ipv4/af_inet.c:761 __inet_accept+0x1f4/=
0x4a0
> > Modules linked in:
> > CPU: 1 PID: 772 Comm: syz-executor510 Not tainted 6.9.0-rc7-g7da7119fe2=
2b #56
> > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.11.0-2.el=
7 04/01/2014
> > RIP: 0010:__inet_accept+0x1f4/0x4a0 net/ipv4/af_inet.c:759
> > Code: 04 38 84 c0 0f 85 87 00 00 00 41 c7 04 24 03 00 00 00 48 83 c4 10=
 5b 41 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc e8 ec b7 da fd <0f> 0b e9 7f =
fe ff ff e8 e0 b7 da fd 0f 0b e9 fe fe ff ff 89 d9 80
> > RSP: 0018:ffffc90000c2fc58 EFLAGS: 00010293
> > RAX: ffffffff836bdd14 RBX: 0000000000000000 RCX: ffff888104668000
> > RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> > RBP: dffffc0000000000 R08: ffffffff836bdb89 R09: fffff52000185f64
> > R10: dffffc0000000000 R11: fffff52000185f64 R12: dffffc0000000000
> > R13: 1ffff92000185f98 R14: ffff88810754d880 R15: ffff8881007b7800
> > FS:  000000001c772880(0000) GS:ffff88811b280000(0000) knlGS:00000000000=
00000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 00007fb9fcf2e178 CR3: 00000001045d2002 CR4: 0000000000770ef0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > PKRU: 55555554
> > Call Trace:
> >  <TASK>
> >  inet_accept+0x138/0x1d0 net/ipv4/af_inet.c:786
> >  do_accept+0x435/0x620 net/socket.c:1929
> >  __sys_accept4_file net/socket.c:1969 [inline]
> >  __sys_accept4+0x9b/0x110 net/socket.c:1999
> >  __do_sys_accept net/socket.c:2016 [inline]
> >  __se_sys_accept net/socket.c:2013 [inline]
> >  __x64_sys_accept+0x7d/0x90 net/socket.c:2013
> >  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> >  do_syscall_64+0x58/0x100 arch/x86/entry/common.c:83
> >  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > RIP: 0033:0x4315f9
> > Code: fd ff 48 81 c4 80 00 00 00 e9 f1 fe ff ff 0f 1f 00 48 89 f8 48 89=
 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 =
ff ff 0f 83 ab b4 fd ff c3 66 2e 0f 1f 84 00 00 00 00
> > RSP: 002b:00007ffdb26d9c78 EFLAGS: 00000246 ORIG_RAX: 000000000000002b
> > RAX: ffffffffffffffda RBX: 0000000000400300 RCX: 00000000004315f9
> > RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000004
> > RBP: 00000000006e1018 R08: 0000000000400300 R09: 0000000000400300
> > R10: 0000000000400300 R11: 0000000000000246 R12: 0000000000000000
> > R13: 000000000040cdf0 R14: 000000000040ce80 R15: 0000000000000055
> >  </TASK>
> >
> > Listener sockets are supposed to have a zero sk_shutdown, as the
> > accepted children will inherit such field.
> >
> > Invoking shutdown() before entering the listener status allows
> > violating the above constraint.
> >
> > After commit 94062790aedb ("tcp: defer shutdown(SEND_SHUTDOWN) for
> > TCP_SYN_RECV sockets"), the above causes the child to reach the accept
> > syscall in FIN_WAIT1 status.
> >
> > Address the issue explicitly by clearing sk_shutdown at listen time.
> >
> > Reported-by: Christoph Paasch <cpaasch@apple.com>
> > Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/490
> > Fixes: 1da177e4c3fu ("Linux-2.6.12-rc2")
> > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > ---
> > Note: the issue above reports an MPTCP reproducer, but I can reproduce
> > the issue even using plain TCP sockets only.
> > ---
> >  net/ipv4/inet_connection_sock.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection=
_sock.c
> > index 3b38610958ee..dab723fea0cc 100644
> > --- a/net/ipv4/inet_connection_sock.c
> > +++ b/net/ipv4/inet_connection_sock.c
> > @@ -1269,6 +1269,8 @@ int inet_csk_listen_start(struct sock *sk)
> >
> >         reqsk_queue_alloc(&icsk->icsk_accept_queue);
> >
> > +       /* closed sockets can have non zero sk_shutdown */
> > +       WRITE_ONCE(sk->sk_shutdown, 0);
>
> Hi Paolo.
>
> I am unsure about your patch, I had an internal syzbot report about
> this before going OOO for a few days,
> and my first reaction was to change the WARN in inet_accept().
>
> Perhaps some applications are relying on calling shutdown() before listen=
()...

BTW the syzbot repro was

r0 =3D socket$inet6_tcp(0xa, 0x1, 0x0)
sendto$inet6(0xffffffffffffffff, 0x0, 0x0, 0x20000004, 0x0, 0x0)
shutdown(r0, 0x1)
bind$inet6(r0, &(0x7f0000000040)=3D{0xa, 0x4e22, 0x0, @empty}, 0x1c)
listen(r0, 0x0)
r1 =3D socket$inet_mptcp(0x2, 0x1, 0x106)
connect$inet(r1, &(0x7f0000000000)=3D{0x2, 0x4e22, @local}, 0x10)
accept(r0, 0x0, 0x0)


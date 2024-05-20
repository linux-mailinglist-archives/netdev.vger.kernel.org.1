Return-Path: <netdev+bounces-97207-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C70DB8C9F09
	for <lists+netdev@lfdr.de>; Mon, 20 May 2024 16:54:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55CC41F21FEF
	for <lists+netdev@lfdr.de>; Mon, 20 May 2024 14:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5335613699A;
	Mon, 20 May 2024 14:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="buZ6LNZB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FECA1E878
	for <netdev@vger.kernel.org>; Mon, 20 May 2024 14:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716216838; cv=none; b=hI4DcXgGdrj+f/PbeMSA25OrqW0mCwqQILmkiEHNw6zvt79YBjOP2WW0F1DslzNk/9PV3Pf9czlRkmCt2dk36EQdqwFsnWAImpzJJsep5iGf2BwYRfWHKkqxe7ohT1ENYs+PVOYLvUuvke9rXuAprA6DVBKs/+naeyxQH+IdRc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716216838; c=relaxed/simple;
	bh=oJBRL1jaJxMoxt+4X4Mhn3BGgw1NStuUFa9QtTEw810=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a7LV3hPjMfFo5+L1FMojOYfBWBL0kmBrSRGXUI4R3YAVjP5AuydmgVcexyVYs7zNrEQYpOh4UZHlWV7KKtnbha3ni/pBMEn0JUq7po7TxHbd4I4Y51Imb9cTL4hQ5TznpVXUxMwuJEWHVPN1LGHpRHISnUDueHEHcqHJzmNcdD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=buZ6LNZB; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-41ff3a5af40so81715e9.1
        for <netdev@vger.kernel.org>; Mon, 20 May 2024 07:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716216835; x=1716821635; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FXVtHGAXh4sfliNi2GN3o5Z0Xw9C+JEN0vgpuab7ots=;
        b=buZ6LNZB6TNy+RtD6wr3Rlc1DK//MDToJnBCAbAZnMi1nRZPnvCmwKjdku928AsB8I
         q13hOHilw2a4V0SJrT/1yyTTKCEjf6iCWSJaQq6H6kKovr0BLz7wH1wrMfA4tg2Tqrcc
         XE8JXBG7EAYufx6wj9OJ0Io3c/YqopzxEnKz4AT7DcKIv3GEl1mS4coI7S5rXK2UyboY
         We9Qj42PDPejixgNvkIg6KkqELiatRy1+OT+DPEPk2OPTuCbHbkn1OiCli+x3EqOtbcQ
         MHLeu+68OqwOkM1iD6gBfBRTLUMkYtj9fTvlrrS6EgrOKA9ybsehGUXvwlFzctjXcVk/
         iNRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716216835; x=1716821635;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FXVtHGAXh4sfliNi2GN3o5Z0Xw9C+JEN0vgpuab7ots=;
        b=I3JTBRAAKWzhuN4TRYV4psco/G2KAgP3oXWUZGAsXO864jKqO6cog5oc8pUlNCIgpQ
         6dJtVxkOzz+P2Pj3JDgXhNtrHXCEhZp/wXl2L73TZMun8eHafd9iCWjKC45D0MgIHemk
         w0L6pHQJS2wZVNz+WRqtbpQLop7UuKb9/wWxFRo/peO7KqE0LChPJIR/5RhaOspNAIVd
         xBfpNlAJ+/It+ayhE/D3Xz3ghtBOdkULGC57+gYB8JAfklTGqCTfEqd7F5LtPhh40pnu
         WQdsNlH16FMbFVjobv0qOesORvzhFtZGI4XmRPWc45x0H75zvIIux/SlOqkqqRv91Is2
         9ZlQ==
X-Gm-Message-State: AOJu0YwXYi67n3+JWwfd0t3VIQLUg9LpUDE3Je2M/QIt+DDoZal9gp2K
	7LnmQdb/ntqbAEh7FwuyfO2OJbBE4drail6Xz42HASEvsIa3y23Qve6s+1bOlPRK72h1IH6qSv2
	iTLA7hciPcWENX6h/YaPIyhG8/YV8MmRIf5UsIr+SQUoRgHb1+rbO
X-Google-Smtp-Source: AGHT+IEh5lZe4YbrbTPUlG0NvhC+1yVDZOGOt0yQcoJB+VW1VX773OX47RaO4v4i4q7V8cSrjOYgvBB9hRiP+h6WoqU=
X-Received: by 2002:a05:600c:34c5:b0:41b:e55c:8dca with SMTP id
 5b1f17b1804b1-420e1f76868mr3215065e9.7.1716216834397; Mon, 20 May 2024
 07:53:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8db98a8fbf2ac673b355651852093579a913f3f1.1716199422.git.pabeni@redhat.com>
 <CANn89i+zxB9g7n3JWXd8B-kkSkfRWfb7mOQcQi+mMLs6U-n5tQ@mail.gmail.com>
 <CANn89iLM7xjUOJeA1mt2Ng2j6K2_9OLrc0014PM0U+TOKcvt0Q@mail.gmail.com> <48cf7e9764eef299c55a9f9af03ab5d9dbe8c658.camel@redhat.com>
In-Reply-To: <48cf7e9764eef299c55a9f9af03ab5d9dbe8c658.camel@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 20 May 2024 16:53:43 +0200
Message-ID: <CANn89i+1Ozg7zztkFug8LuyTEPnX2R3GCrQX=H8cuzPdfW-x6A@mail.gmail.com>
Subject: Re: [PATCH net] tcp: ensure sk_showdown is 0 for listening sockets
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Christoph Paasch <cpaasch@apple.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 20, 2024 at 4:46=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> Hi,
>
> On Mon, 2024-05-20 at 16:07 +0200, Eric Dumazet wrote:
> > On Mon, May 20, 2024 at 3:46=E2=80=AFPM Eric Dumazet <edumazet@google.c=
om> wrote:
> > >
> > > On Mon, May 20, 2024 at 12:05=E2=80=AFPM Paolo Abeni <pabeni@redhat.c=
om> wrote:
> > > >
> > > > Christoph reported the following splat:
> > > >
> > > > WARNING: CPU: 1 PID: 772 at net/ipv4/af_inet.c:761 __inet_accept+0x=
1f4/0x4a0
> > > > Modules linked in:
> > > > CPU: 1 PID: 772 Comm: syz-executor510 Not tainted 6.9.0-rc7-g7da711=
9fe22b #56
> > > > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.11.0-=
2.el7 04/01/2014
> > > > RIP: 0010:__inet_accept+0x1f4/0x4a0 net/ipv4/af_inet.c:759
> > > > Code: 04 38 84 c0 0f 85 87 00 00 00 41 c7 04 24 03 00 00 00 48 83 c=
4 10 5b 41 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc e8 ec b7 da fd <0f> 0b e9=
 7f fe ff ff e8 e0 b7 da fd 0f 0b e9 fe fe ff ff 89 d9 80
> > > > RSP: 0018:ffffc90000c2fc58 EFLAGS: 00010293
> > > > RAX: ffffffff836bdd14 RBX: 0000000000000000 RCX: ffff888104668000
> > > > RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> > > > RBP: dffffc0000000000 R08: ffffffff836bdb89 R09: fffff52000185f64
> > > > R10: dffffc0000000000 R11: fffff52000185f64 R12: dffffc0000000000
> > > > R13: 1ffff92000185f98 R14: ffff88810754d880 R15: ffff8881007b7800
> > > > FS:  000000001c772880(0000) GS:ffff88811b280000(0000) knlGS:0000000=
000000000
> > > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > CR2: 00007fb9fcf2e178 CR3: 00000001045d2002 CR4: 0000000000770ef0
> > > > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > > > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > > > PKRU: 55555554
> > > > Call Trace:
> > > >  <TASK>
> > > >  inet_accept+0x138/0x1d0 net/ipv4/af_inet.c:786
> > > >  do_accept+0x435/0x620 net/socket.c:1929
> > > >  __sys_accept4_file net/socket.c:1969 [inline]
> > > >  __sys_accept4+0x9b/0x110 net/socket.c:1999
> > > >  __do_sys_accept net/socket.c:2016 [inline]
> > > >  __se_sys_accept net/socket.c:2013 [inline]
> > > >  __x64_sys_accept+0x7d/0x90 net/socket.c:2013
> > > >  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> > > >  do_syscall_64+0x58/0x100 arch/x86/entry/common.c:83
> > > >  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > > > RIP: 0033:0x4315f9
> > > > Code: fd ff 48 81 c4 80 00 00 00 e9 f1 fe ff ff 0f 1f 00 48 89 f8 4=
8 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01=
 f0 ff ff 0f 83 ab b4 fd ff c3 66 2e 0f 1f 84 00 00 00 00
> > > > RSP: 002b:00007ffdb26d9c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000=
02b
> > > > RAX: ffffffffffffffda RBX: 0000000000400300 RCX: 00000000004315f9
> > > > RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000004
> > > > RBP: 00000000006e1018 R08: 0000000000400300 R09: 0000000000400300
> > > > R10: 0000000000400300 R11: 0000000000000246 R12: 0000000000000000
> > > > R13: 000000000040cdf0 R14: 000000000040ce80 R15: 0000000000000055
> > > >  </TASK>
> > > >
> > > > Listener sockets are supposed to have a zero sk_shutdown, as the
> > > > accepted children will inherit such field.
> > > >
> > > > Invoking shutdown() before entering the listener status allows
> > > > violating the above constraint.
> > > >
> > > > After commit 94062790aedb ("tcp: defer shutdown(SEND_SHUTDOWN) for
> > > > TCP_SYN_RECV sockets"), the above causes the child to reach the acc=
ept
> > > > syscall in FIN_WAIT1 status.
> > > >
> > > > Address the issue explicitly by clearing sk_shutdown at listen time=
.
> > > >
> > > > Reported-by: Christoph Paasch <cpaasch@apple.com>
> > > > Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/490
> > > > Fixes: 1da177e4c3fu ("Linux-2.6.12-rc2")
> > > > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > > > ---
> > > > Note: the issue above reports an MPTCP reproducer, but I can reprod=
uce
> > > > the issue even using plain TCP sockets only.
> > > > ---
> > > >  net/ipv4/inet_connection_sock.c | 2 ++
> > > >  1 file changed, 2 insertions(+)
> > > >
> > > > diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connec=
tion_sock.c
> > > > index 3b38610958ee..dab723fea0cc 100644
> > > > --- a/net/ipv4/inet_connection_sock.c
> > > > +++ b/net/ipv4/inet_connection_sock.c
> > > > @@ -1269,6 +1269,8 @@ int inet_csk_listen_start(struct sock *sk)
> > > >
> > > >         reqsk_queue_alloc(&icsk->icsk_accept_queue);
> > > >
> > > > +       /* closed sockets can have non zero sk_shutdown */
> > > > +       WRITE_ONCE(sk->sk_shutdown, 0);
> > >
> > > Hi Paolo.
> > >
> > > I am unsure about your patch, I had an internal syzbot report about
> > > this before going OOO for a few days,
> > > and my first reaction was to change the WARN in inet_accept().
> > >
> > > Perhaps some applications are relying on calling shutdown() before li=
sten()...
>
> Uhmm, right I did not consider that a non zero sk_shutdown would have
> affected recvmsg() and sendmsg() even prior to 94062790aedb ("tcp:
> defer shutdown(SEND_SHUTDOWN) for TCP_SYN_RECV sockets").
>
> > BTW the syzbot repro was
> >
> > r0 =3D socket$inet6_tcp(0xa, 0x1, 0x0)
> > sendto$inet6(0xffffffffffffffff, 0x0, 0x0, 0x20000004, 0x0, 0x0)
> > shutdown(r0, 0x1)
> > bind$inet6(r0, &(0x7f0000000040)=3D{0xa, 0x4e22, 0x0, @empty}, 0x1c)
> > listen(r0, 0x0)
> > r1 =3D socket$inet_mptcp(0x2, 0x1, 0x106)
> > connect$inet(r1, &(0x7f0000000000)=3D{0x2, 0x4e22, @local}, 0x10)
> > accept(r0, 0x0, 0x0)
>
> The above is very similar to what Christoph reported. It should splat
> even replacing 0x106 with 0 (mptcp -> tcp).
>
> I'm fine with relaxing the check in __inet_accept(). Do you prefer send
> to patch yourself, or me to send a v2? The condition should be
>
>         WARN_ON(!((1 << newsk->sk_state) &
>                   (TCPF_ESTABLISHED | TCPF_SYN_RECV |
>                    TCPF_FIN_WAIT1 | TCPF_FIN_WAIT2 |
>                    TCPF_CLOSING | TCPF_CLOSE_WAIT |
>                    TCPF_CLOSE)));
>

Please send a v2.

I am not sure why we need a WARN_ON() to begin with, the socket is
still private.

Even the lock_sock(sk2)/release_sock(sk2) pair in inet_accept() seems overk=
ill.


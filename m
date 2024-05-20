Return-Path: <netdev+bounces-97206-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 508F68C9F00
	for <lists+netdev@lfdr.de>; Mon, 20 May 2024 16:49:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5F1D1F23489
	for <lists+netdev@lfdr.de>; Mon, 20 May 2024 14:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08D40136669;
	Mon, 20 May 2024 14:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WTBLkH4K"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2345353E07
	for <netdev@vger.kernel.org>; Mon, 20 May 2024 14:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716216570; cv=none; b=kM1OT+zIi6bvOsLJ2x712Uin7/nYu9n1niAVdLS9TZsuml25M+MF75Nw8tPs9KyPzFUJR3+2yjBVYJM9me3N/jBa4iNHiXzgreClv/csJWLliDXjAYEw4PjpSuX+6PLvP7G89PtU0gBvmWvPoiU93GWC7fVEZTe6/Qt9xLXr4t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716216570; c=relaxed/simple;
	bh=GNBGYaVWprk8mAxBWbFOXfvRk0qekKt53UjIM8rg1L0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PtRR8XVSGJ9A5nY5BNKn8Psric6HnRpi8ncpsISkvMMQcpH72VMCVgma4WMy6TcIO46HmmUyHddnRmgGkje8Px3agaUDyjztKqmwsdMkjS4qyGpuH6o8g9RK+cWTy8ZPWZks+TJqnINkC5a9p3fb1tO9ph26EtQoSfYVohIsbEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WTBLkH4K; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5750a8737e5so14090a12.0
        for <netdev@vger.kernel.org>; Mon, 20 May 2024 07:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716216567; x=1716821367; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DgP4Ze8xegln7lSB6uUkPHSfhiV/X15GfUfzqgKOmLg=;
        b=WTBLkH4KSoShC7dVonGjJ+bOzc5Rty3vGiDsComBPZ58e28jY3pGZ3D6vp+i3ytxid
         PZEqKS6dAyxHdORC56QsA/J2HaRRZ0MDEoiLJpPa3nlNSRhVtDn8abo8pJI8Ea0mjRdp
         Tr69q0RMgLqHaHFbcL01rd+uyTtYHW+A5BFxhERy6DO8Y4qrwQHmKK5zmU4/RjwWyT66
         iwbWA56pYUjylQX6R0nBWPtc0ZpmY0Ke9/u/JJMmsn1G9b7rTdKPqP/OSSqgpv2WhjhL
         e8CndGKCGpPv0wxJ2uFL1LHOkZBgCeIxgWHUp1OtM+6MyXs/t/KuebLv0H5EtB/Zby7p
         kxCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716216567; x=1716821367;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DgP4Ze8xegln7lSB6uUkPHSfhiV/X15GfUfzqgKOmLg=;
        b=E3F3S1jWs2TvvpiaAQp9v19bkE/nyFTBXCFhtgfzkKOHmqeVvryHv3uj26lxtZrCJJ
         elE19BqaGVk7uQCltWTOTa7Z45nl3fd8mUglYATElR1txiiv82Ezd7I1ly7P4tOLYr/F
         9O3AvS26/yo+aN4gxJBx0o/vt0Snj4qv3U/cEHLjC8oorFcJUgA+NS9BMvShv5xB5ui2
         zH1qn5k60VHAICcG6gT+SWD9I1lBRuvnvSzQnYG/Pll5pEy7BQ0usj3zGdzC/YNHdz6X
         xbwxeukDbbuKGWaGUyVnY8tyTHjLHHpzKj2gjt4Tnj35NclVaWT1ycZHOEW329Az7D6h
         6DaA==
X-Gm-Message-State: AOJu0Yw/o+WKXVI3ARqxqbW4bDEfSg7WnHdHVPs2h8PUfWV238mz7mQR
	a3wfNnd5Xyqo/R+uAPsiFrHufA5i1RLKP4aESlcGvtfGoFLfAXsixY4QIP6ba5GHqcr+wFHcQ9A
	0v9LJ6xzjTfVv0WWCffTJpWx/TgVeuyGYkt+1
X-Google-Smtp-Source: AGHT+IEfdiBj1o9x+SzUq3UIntTzpRyzuGJPsZm0juRau1nwwElMBue2oFzyspuvdIfWLN0Tec8C8LfZlVE+rIjK1Ro=
X-Received: by 2002:aa7:d39a:0:b0:572:a33d:437f with SMTP id
 4fb4d7f45d1cf-5752a70fc1cmr278391a12.2.1716216567008; Mon, 20 May 2024
 07:49:27 -0700 (PDT)
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
Date: Mon, 20 May 2024 16:49:12 +0200
Message-ID: <CANn89i+gGYpCojJ8=zzZfpwTWhPF6T+rWqstu1D1rGLjoaa-xQ@mail.gmail.com>
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
> I guess.
>
> Thanks!
>
> Paolo
>
>
>


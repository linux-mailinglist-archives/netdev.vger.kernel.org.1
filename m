Return-Path: <netdev+bounces-97210-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 982938C9FA3
	for <lists+netdev@lfdr.de>; Mon, 20 May 2024 17:26:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBAC01C2060E
	for <lists+netdev@lfdr.de>; Mon, 20 May 2024 15:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68E9F136E1A;
	Mon, 20 May 2024 15:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bbJ6APiO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C72F224DD
	for <netdev@vger.kernel.org>; Mon, 20 May 2024 15:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716218779; cv=none; b=aABnmRJamUMXYVE6jrEZm+MIL7dKGuQxdD9ySgizv6YeEC2cBP54RgG4sV0DTm39jQ6u4spkviM2l0xkuVIu4Z3zZesNPSDoDCu6o/ugmYAm1tbJaOW9RvpRVdUwoyf+JphTXoa+nz08WHuXseoDWCMp3kmL5vnwjN1I7kixLWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716218779; c=relaxed/simple;
	bh=swXlV6c1e+Ufi79WanLyV7mA1Ge8ZIRrPJLhvEVCZtM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i/JXuoNg3pl7z0skXfqeU9VNGkQCtLlrPTJWI4OO8LfkkLHrtEyEHwW2ca+qypCT6XXPUtMgVTqlqVMbsvnAPcBRodN9kL8eGqIa/VwsQhgF8qU3pxQ4VfmAxw2Uoc55uzjdcllUI3eMZb/MI2dJ29v+ekA4cejDLZDN5/BCES8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bbJ6APiO; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-572f6c56cdaso16972a12.0
        for <netdev@vger.kernel.org>; Mon, 20 May 2024 08:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716218776; x=1716823576; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N+L7R8CMvFqr0x5n4bWuxzoOaOwcV60hNzraFwe44mQ=;
        b=bbJ6APiOLBxz+EWR7V7cHKsE34QtmVvQ9hJ64eE5NI2iP/31a6JofOH6mTDyWDzb6C
         PGL08H+OZnn9bqZdawbaz7/6d70abEdF0k0dkBNnWVGUIA+JeIKlPk3QxpegxlDYk7CN
         wz/iUpCFaTHplMLYivNZ8CsKIIHeaFsj5IBtdjyjfxfO3TxPyxSlJnmLwuFGxECdimll
         775SdBybm/BM8FBeJPZ7/FQ85RRSjJe+7I14S95V3Eol1a+6p5/UspWZRLxWWZfK5QFQ
         aSmGpY+k2qFVBngkmrrolA3mlX3rVNbsMXK6FAsK88bsCzqnCD7lE3mjJbPIIzMjx9Dv
         MOgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716218776; x=1716823576;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N+L7R8CMvFqr0x5n4bWuxzoOaOwcV60hNzraFwe44mQ=;
        b=IHoHd/SASDZNDo4QmiDsCimOWxHYgP0UZ8P2+8XCdYnTwHEaREq/Jx8drFT5g9weQY
         AbxOfxlidvABMILWoAl25jaAdwGSKaEwAybvDeULTfyxrN61nHc/XcAnyFVP7vLfTYQ2
         5P/wCWPaWGpXeUhzkWuKUXXYcZRqYUxtoPY1k9SgmCgwOJdIhY4TOP3PCDJvfbCvQFyI
         N7UN4PgVutjRwmvlDru6uIG7scmmeRIFkKxSgRlZRbXW+0UzgOoYLjwtL7nob42pBJky
         Qa4iOPkZUUIGssd9GsTA9gWvOCxSScWTgzw5JdJ7c+u6g2a2IOmJ3D5jQu7qpJy4xuz9
         CIyg==
X-Gm-Message-State: AOJu0Yy7pdyQsBkiefvuvDLhQUqwdwrqLddjFo7A8+TZksNE68iVMRWv
	oIkvIStFmXboxAWTebJWM5qsC2PFDxzWN60IsdJhrM3gQRJnZkevq6iLVWbWdYZVxfXWJbs9SNO
	NhM8Kw38eyNzMm8JCFpcAeIFiqXIvMHLFjkDi
X-Google-Smtp-Source: AGHT+IGvMjYao9IpAkBFaYGHLI2SbyB8mYtw7QrSLqZUBF+ACiS2CpeJrPWCiZQkVuB0aX9LLq+7DXZPLj6+VQInGmg=
X-Received: by 2002:a50:8750:0:b0:576:68c7:f211 with SMTP id
 4fb4d7f45d1cf-57668c7feb7mr213274a12.6.1716218775421; Mon, 20 May 2024
 08:26:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8db98a8fbf2ac673b355651852093579a913f3f1.1716199422.git.pabeni@redhat.com>
 <CANn89i+zxB9g7n3JWXd8B-kkSkfRWfb7mOQcQi+mMLs6U-n5tQ@mail.gmail.com>
 <CANn89iLM7xjUOJeA1mt2Ng2j6K2_9OLrc0014PM0U+TOKcvt0Q@mail.gmail.com>
 <48cf7e9764eef299c55a9f9af03ab5d9dbe8c658.camel@redhat.com>
 <CANn89i+1Ozg7zztkFug8LuyTEPnX2R3GCrQX=H8cuzPdfW-x6A@mail.gmail.com> <2f9ba4e6625065157740d4a0fb70c1dfbe409542.camel@redhat.com>
In-Reply-To: <2f9ba4e6625065157740d4a0fb70c1dfbe409542.camel@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 20 May 2024 17:26:00 +0200
Message-ID: <CANn89i+vahCe_o=Qv-z5F5U9FZf3RLSWS7rQvnCuZZkx12xvMA@mail.gmail.com>
Subject: Re: [PATCH net] tcp: ensure sk_showdown is 0 for listening sockets
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Christoph Paasch <cpaasch@apple.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 20, 2024 at 5:13=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On Mon, 2024-05-20 at 16:53 +0200, Eric Dumazet wrote:
> > On Mon, May 20, 2024 at 4:46=E2=80=AFPM Paolo Abeni <pabeni@redhat.com>=
 wrote:
> > >
> > > Hi,
> > >
> > > On Mon, 2024-05-20 at 16:07 +0200, Eric Dumazet wrote:
> > > > On Mon, May 20, 2024 at 3:46=E2=80=AFPM Eric Dumazet <edumazet@goog=
le.com> wrote:
> > > > >
> > > > > On Mon, May 20, 2024 at 12:05=E2=80=AFPM Paolo Abeni <pabeni@redh=
at.com> wrote:
> > > > > >
> > > > > > Christoph reported the following splat:
> > > > > >
> > > > > > WARNING: CPU: 1 PID: 772 at net/ipv4/af_inet.c:761 __inet_accep=
t+0x1f4/0x4a0
> > > > > > Modules linked in:
> > > > > > CPU: 1 PID: 772 Comm: syz-executor510 Not tainted 6.9.0-rc7-g7d=
a7119fe22b #56
> > > > > > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.1=
1.0-2.el7 04/01/2014
> > > > > > RIP: 0010:__inet_accept+0x1f4/0x4a0 net/ipv4/af_inet.c:759
> > > > > > Code: 04 38 84 c0 0f 85 87 00 00 00 41 c7 04 24 03 00 00 00 48 =
83 c4 10 5b 41 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc e8 ec b7 da fd <0f> 0=
b e9 7f fe ff ff e8 e0 b7 da fd 0f 0b e9 fe fe ff ff 89 d9 80
> > > > > > RSP: 0018:ffffc90000c2fc58 EFLAGS: 00010293
> > > > > > RAX: ffffffff836bdd14 RBX: 0000000000000000 RCX: ffff8881046680=
00
> > > > > > RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00000000000000=
00
> > > > > > RBP: dffffc0000000000 R08: ffffffff836bdb89 R09: fffff52000185f=
64
> > > > > > R10: dffffc0000000000 R11: fffff52000185f64 R12: dffffc00000000=
00
> > > > > > R13: 1ffff92000185f98 R14: ffff88810754d880 R15: ffff8881007b78=
00
> > > > > > FS:  000000001c772880(0000) GS:ffff88811b280000(0000) knlGS:000=
0000000000000
> > > > > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > > > CR2: 00007fb9fcf2e178 CR3: 00000001045d2002 CR4: 0000000000770e=
f0
> > > > > > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000000=
00
> > > > > > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000000004=
00
> > > > > > PKRU: 55555554
> > > > > > Call Trace:
> > > > > >  <TASK>
> > > > > >  inet_accept+0x138/0x1d0 net/ipv4/af_inet.c:786
> > > > > >  do_accept+0x435/0x620 net/socket.c:1929
> > > > > >  __sys_accept4_file net/socket.c:1969 [inline]
> > > > > >  __sys_accept4+0x9b/0x110 net/socket.c:1999
> > > > > >  __do_sys_accept net/socket.c:2016 [inline]
> > > > > >  __se_sys_accept net/socket.c:2013 [inline]
> > > > > >  __x64_sys_accept+0x7d/0x90 net/socket.c:2013
> > > > > >  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> > > > > >  do_syscall_64+0x58/0x100 arch/x86/entry/common.c:83
> > > > > >  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > > > > > RIP: 0033:0x4315f9
> > > > > > Code: fd ff 48 81 c4 80 00 00 00 e9 f1 fe ff ff 0f 1f 00 48 89 =
f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3=
d 01 f0 ff ff 0f 83 ab b4 fd ff c3 66 2e 0f 1f 84 00 00 00 00
> > > > > > RSP: 002b:00007ffdb26d9c78 EFLAGS: 00000246 ORIG_RAX: 000000000=
000002b
> > > > > > RAX: ffffffffffffffda RBX: 0000000000400300 RCX: 00000000004315=
f9
> > > > > > RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00000000000000=
04
> > > > > > RBP: 00000000006e1018 R08: 0000000000400300 R09: 00000000004003=
00
> > > > > > R10: 0000000000400300 R11: 0000000000000246 R12: 00000000000000=
00
> > > > > > R13: 000000000040cdf0 R14: 000000000040ce80 R15: 00000000000000=
55
> > > > > >  </TASK>
> > > > > >
> > > > > > Listener sockets are supposed to have a zero sk_shutdown, as th=
e
> > > > > > accepted children will inherit such field.
> > > > > >
> > > > > > Invoking shutdown() before entering the listener status allows
> > > > > > violating the above constraint.
> > > > > >
> > > > > > After commit 94062790aedb ("tcp: defer shutdown(SEND_SHUTDOWN) =
for
> > > > > > TCP_SYN_RECV sockets"), the above causes the child to reach the=
 accept
> > > > > > syscall in FIN_WAIT1 status.
> > > > > >
> > > > > > Address the issue explicitly by clearing sk_shutdown at listen =
time.
> > > > > >
> > > > > > Reported-by: Christoph Paasch <cpaasch@apple.com>
> > > > > > Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/=
490
> > > > > > Fixes: 1da177e4c3fu ("Linux-2.6.12-rc2")
> > > > > > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > > > > > ---
> > > > > > Note: the issue above reports an MPTCP reproducer, but I can re=
produce
> > > > > > the issue even using plain TCP sockets only.
> > > > > > ---
> > > > > >  net/ipv4/inet_connection_sock.c | 2 ++
> > > > > >  1 file changed, 2 insertions(+)
> > > > > >
> > > > > > diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_co=
nnection_sock.c
> > > > > > index 3b38610958ee..dab723fea0cc 100644
> > > > > > --- a/net/ipv4/inet_connection_sock.c
> > > > > > +++ b/net/ipv4/inet_connection_sock.c
> > > > > > @@ -1269,6 +1269,8 @@ int inet_csk_listen_start(struct sock *sk=
)
> > > > > >
> > > > > >         reqsk_queue_alloc(&icsk->icsk_accept_queue);
> > > > > >
> > > > > > +       /* closed sockets can have non zero sk_shutdown */
> > > > > > +       WRITE_ONCE(sk->sk_shutdown, 0);
> > > > >
> > > > > Hi Paolo.
> > > > >
> > > > > I am unsure about your patch, I had an internal syzbot report abo=
ut
> > > > > this before going OOO for a few days,
> > > > > and my first reaction was to change the WARN in inet_accept().
> > > > >
> > > > > Perhaps some applications are relying on calling shutdown() befor=
e listen()...
> > >
> > > Uhmm, right I did not consider that a non zero sk_shutdown would have
> > > affected recvmsg() and sendmsg() even prior to 94062790aedb ("tcp:
> > > defer shutdown(SEND_SHUTDOWN) for TCP_SYN_RECV sockets").
> > >
> > > > BTW the syzbot repro was
> > > >
> > > > r0 =3D socket$inet6_tcp(0xa, 0x1, 0x0)
> > > > sendto$inet6(0xffffffffffffffff, 0x0, 0x0, 0x20000004, 0x0, 0x0)
> > > > shutdown(r0, 0x1)
> > > > bind$inet6(r0, &(0x7f0000000040)=3D{0xa, 0x4e22, 0x0, @empty}, 0x1c=
)
> > > > listen(r0, 0x0)
> > > > r1 =3D socket$inet_mptcp(0x2, 0x1, 0x106)
> > > > connect$inet(r1, &(0x7f0000000000)=3D{0x2, 0x4e22, @local}, 0x10)
> > > > accept(r0, 0x0, 0x0)
> > >
> > > The above is very similar to what Christoph reported. It should splat
> > > even replacing 0x106 with 0 (mptcp -> tcp).
> > >
> > > I'm fine with relaxing the check in __inet_accept(). Do you prefer se=
nd
> > > to patch yourself, or me to send a v2? The condition should be
> > >
> > >         WARN_ON(!((1 << newsk->sk_state) &
> > >                   (TCPF_ESTABLISHED | TCPF_SYN_RECV |
> > >                    TCPF_FIN_WAIT1 | TCPF_FIN_WAIT2 |
> > >                    TCPF_CLOSING | TCPF_CLOSE_WAIT |
> > >                    TCPF_CLOSE)));
> > >
> >
> > Please send a v2.
> >
> > I am not sure why we need a WARN_ON() to begin with, the socket is
> > still private.
>
> Digging into the history, the warn was introduced in 2.3.15 - was a
> BUG_TRAP() back then.
>
> The relevant chunk replaced explicit handling for each expected state
> with more generic code handling all of them the same way. I guess the
> assertion is a left over safeguard.
>
> I would not drop it on net, perhaps later on net-next?

Sure, let's wait for the next syzbot report if any.

>
> > Even the lock_sock(sk2)/release_sock(sk2) pair in inet_accept() seems o=
verkill.
>
> Something for net-next, I guess?

Sure, this is orthogonal.

>
> Thanks!
>
> Paolo
>


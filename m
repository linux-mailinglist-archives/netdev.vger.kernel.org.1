Return-Path: <netdev+bounces-97205-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3B6F8C9EF7
	for <lists+netdev@lfdr.de>; Mon, 20 May 2024 16:46:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16ACDB20421
	for <lists+netdev@lfdr.de>; Mon, 20 May 2024 14:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D8251E878;
	Mon, 20 May 2024 14:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YsP8Pyrr"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229DE8462
	for <netdev@vger.kernel.org>; Mon, 20 May 2024 14:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716216372; cv=none; b=aFMR3+9Qy/oo/PgS6yV+vabm8BAFxDYWo1dFwYbOnSfYMefSa4LfJqgX5VGgLUFFFV2FCkd0akdGsSa3BJ/b18e7zGt2SUKBqpnvoTovYqO1aj1TZwH5f10AaeyDzTRzwPeJDIeDCI2LwlEYft36D6GUgQCfJaIEc8ly8GbSuQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716216372; c=relaxed/simple;
	bh=fJPmzPkuCyGxNoFHbN/OU0qUPHsIO+7Oug0PLC373FQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Nb4Kjp7gsa90sssuBjrG9j2u7MhVYlXk9yc6ltkpBrZzRgThFX2XC255tQKxOSSgYzJahOhK0eultYwxjFJBeDWfo17TzJgAAY4UO0dbKlZdldnCwfnRqELOqXsRWEMtHoOBF8ekQ48afneDBmoCZfArPtuE/wMDL37qPZUVIS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YsP8Pyrr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716216369;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=KLtXm7Ly74/PCl5LuDGR3q+iLKTLxHVIvO0aLWq3Iq4=;
	b=YsP8Pyrr9/7UGJQ4t7kpRxnb6koOAkuSphNcVPJzbbSCPxqmATUpwdhMKHltPK8GEmaKzG
	0cemBamb6FC9A0sVXHKGJdomBiwm3M2J6ZzvJAvxCRlTHrqLKqM0tEQg/KSrEM7AR/d9Ll
	oWBOHTtQA5/j5fCv3Oc5OOPPA8A102U=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-Zy8GVpS1NQu17dOQDSQTRw-1; Mon, 20 May 2024 10:46:08 -0400
X-MC-Unique: Zy8GVpS1NQu17dOQDSQTRw-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-34db05be56dso1664288f8f.0
        for <netdev@vger.kernel.org>; Mon, 20 May 2024 07:46:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716216367; x=1716821167;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KLtXm7Ly74/PCl5LuDGR3q+iLKTLxHVIvO0aLWq3Iq4=;
        b=m8YUiRvwfWZVwBwBp2xvzl56vcB39n2ogSpqmFtHlkIXNUEHtlnLRtDC5HmF1xeMMh
         4FltOcSlEzZj/UuJpXsgvzfJyWA0JI02YJQFdM9/0D0fp4JfPIhMQ0R3F1hEXfsW4NRs
         0T87fFsFYfduV7OBednrBa1wHI8chZ/6eVsProopOODMHxO1fQIqphD90PL+MBRg4h5f
         dzWghOdUwIm3zTpSk8nwAKrOuuT18Pv9g1V7Aaj5sO9Jsrx1xtU/Aq3JRFQArbxT+zdG
         zTI/kCY+KwpOM7WBTQzvsue/UyUcsIbUdIDyLLsqmEtmVYbI5aZoEGr6viip8fW24pVG
         uuuw==
X-Gm-Message-State: AOJu0YwJmlIWslKPrM8vPoWBe9aI+4CZnAfTpnnmCLlbMX45scfsxPF9
	IKnb7/wzMitHLesjF71pyhb8R9prT9t4MiuXNI9yk9EWWHumnraZlpwYtBeCof1XHobQlL6GeIH
	DSGVjLYnDjWnsxz1VKpnpL7waNQbjHQ+WDSci4E+UlmM6ObQBByAjSQ==
X-Received: by 2002:a05:600c:511c:b0:420:29dd:84e2 with SMTP id 5b1f17b1804b1-42029dd87camr90429755e9.2.1716216366836;
        Mon, 20 May 2024 07:46:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH2cZWTnE0w27yyUvvo4DKz/2ETlc3jxm13UrR/1x/uUFOycCxELQTgXj61up8nMeWRS/EF2w==
X-Received: by 2002:a05:600c:511c:b0:420:29dd:84e2 with SMTP id 5b1f17b1804b1-42029dd87camr90429575e9.2.1716216366368;
        Mon, 20 May 2024 07:46:06 -0700 (PDT)
Received: from gerbillo.redhat.com ([2a0d:3341:b094:ab10::f71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502bbbbd60sm29545896f8f.90.2024.05.20.07.46.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 07:46:05 -0700 (PDT)
Message-ID: <48cf7e9764eef299c55a9f9af03ab5d9dbe8c658.camel@redhat.com>
Subject: Re: [PATCH net] tcp: ensure sk_showdown is 0 for listening sockets
From: Paolo Abeni <pabeni@redhat.com>
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, David
 Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Christoph
 Paasch <cpaasch@apple.com>
Date: Mon, 20 May 2024 16:46:04 +0200
In-Reply-To: <CANn89iLM7xjUOJeA1mt2Ng2j6K2_9OLrc0014PM0U+TOKcvt0Q@mail.gmail.com>
References: 
	<8db98a8fbf2ac673b355651852093579a913f3f1.1716199422.git.pabeni@redhat.com>
	 <CANn89i+zxB9g7n3JWXd8B-kkSkfRWfb7mOQcQi+mMLs6U-n5tQ@mail.gmail.com>
	 <CANn89iLM7xjUOJeA1mt2Ng2j6K2_9OLrc0014PM0U+TOKcvt0Q@mail.gmail.com>
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

Hi,

On Mon, 2024-05-20 at 16:07 +0200, Eric Dumazet wrote:
> On Mon, May 20, 2024 at 3:46=E2=80=AFPM Eric Dumazet <edumazet@google.com=
> wrote:
> >=20
> > On Mon, May 20, 2024 at 12:05=E2=80=AFPM Paolo Abeni <pabeni@redhat.com=
> wrote:
> > >=20
> > > Christoph reported the following splat:
> > >=20
> > > WARNING: CPU: 1 PID: 772 at net/ipv4/af_inet.c:761 __inet_accept+0x1f=
4/0x4a0
> > > Modules linked in:
> > > CPU: 1 PID: 772 Comm: syz-executor510 Not tainted 6.9.0-rc7-g7da7119f=
e22b #56
> > > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.11.0-2.=
el7 04/01/2014
> > > RIP: 0010:__inet_accept+0x1f4/0x4a0 net/ipv4/af_inet.c:759
> > > Code: 04 38 84 c0 0f 85 87 00 00 00 41 c7 04 24 03 00 00 00 48 83 c4 =
10 5b 41 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc e8 ec b7 da fd <0f> 0b e9 7=
f fe ff ff e8 e0 b7 da fd 0f 0b e9 fe fe ff ff 89 d9 80
> > > RSP: 0018:ffffc90000c2fc58 EFLAGS: 00010293
> > > RAX: ffffffff836bdd14 RBX: 0000000000000000 RCX: ffff888104668000
> > > RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> > > RBP: dffffc0000000000 R08: ffffffff836bdb89 R09: fffff52000185f64
> > > R10: dffffc0000000000 R11: fffff52000185f64 R12: dffffc0000000000
> > > R13: 1ffff92000185f98 R14: ffff88810754d880 R15: ffff8881007b7800
> > > FS:  000000001c772880(0000) GS:ffff88811b280000(0000) knlGS:000000000=
0000000
> > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > CR2: 00007fb9fcf2e178 CR3: 00000001045d2002 CR4: 0000000000770ef0
> > > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > > PKRU: 55555554
> > > Call Trace:
> > >  <TASK>
> > >  inet_accept+0x138/0x1d0 net/ipv4/af_inet.c:786
> > >  do_accept+0x435/0x620 net/socket.c:1929
> > >  __sys_accept4_file net/socket.c:1969 [inline]
> > >  __sys_accept4+0x9b/0x110 net/socket.c:1999
> > >  __do_sys_accept net/socket.c:2016 [inline]
> > >  __se_sys_accept net/socket.c:2013 [inline]
> > >  __x64_sys_accept+0x7d/0x90 net/socket.c:2013
> > >  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> > >  do_syscall_64+0x58/0x100 arch/x86/entry/common.c:83
> > >  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > > RIP: 0033:0x4315f9
> > > Code: fd ff 48 81 c4 80 00 00 00 e9 f1 fe ff ff 0f 1f 00 48 89 f8 48 =
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f=
0 ff ff 0f 83 ab b4 fd ff c3 66 2e 0f 1f 84 00 00 00 00
> > > RSP: 002b:00007ffdb26d9c78 EFLAGS: 00000246 ORIG_RAX: 000000000000002=
b
> > > RAX: ffffffffffffffda RBX: 0000000000400300 RCX: 00000000004315f9
> > > RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000004
> > > RBP: 00000000006e1018 R08: 0000000000400300 R09: 0000000000400300
> > > R10: 0000000000400300 R11: 0000000000000246 R12: 0000000000000000
> > > R13: 000000000040cdf0 R14: 000000000040ce80 R15: 0000000000000055
> > >  </TASK>
> > >=20
> > > Listener sockets are supposed to have a zero sk_shutdown, as the
> > > accepted children will inherit such field.
> > >=20
> > > Invoking shutdown() before entering the listener status allows
> > > violating the above constraint.
> > >=20
> > > After commit 94062790aedb ("tcp: defer shutdown(SEND_SHUTDOWN) for
> > > TCP_SYN_RECV sockets"), the above causes the child to reach the accep=
t
> > > syscall in FIN_WAIT1 status.
> > >=20
> > > Address the issue explicitly by clearing sk_shutdown at listen time.
> > >=20
> > > Reported-by: Christoph Paasch <cpaasch@apple.com>
> > > Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/490
> > > Fixes: 1da177e4c3fu ("Linux-2.6.12-rc2")
> > > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > > ---
> > > Note: the issue above reports an MPTCP reproducer, but I can reproduc=
e
> > > the issue even using plain TCP sockets only.
> > > ---
> > >  net/ipv4/inet_connection_sock.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >=20
> > > diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connecti=
on_sock.c
> > > index 3b38610958ee..dab723fea0cc 100644
> > > --- a/net/ipv4/inet_connection_sock.c
> > > +++ b/net/ipv4/inet_connection_sock.c
> > > @@ -1269,6 +1269,8 @@ int inet_csk_listen_start(struct sock *sk)
> > >=20
> > >         reqsk_queue_alloc(&icsk->icsk_accept_queue);
> > >=20
> > > +       /* closed sockets can have non zero sk_shutdown */
> > > +       WRITE_ONCE(sk->sk_shutdown, 0);
> >=20
> > Hi Paolo.
> >=20
> > I am unsure about your patch, I had an internal syzbot report about
> > this before going OOO for a few days,
> > and my first reaction was to change the WARN in inet_accept().
> >=20
> > Perhaps some applications are relying on calling shutdown() before list=
en()...

Uhmm, right I did not consider that a non zero sk_shutdown would have
affected recvmsg() and sendmsg() even prior to 94062790aedb ("tcp:
defer shutdown(SEND_SHUTDOWN) for TCP_SYN_RECV sockets").

> BTW the syzbot repro was
>=20
> r0 =3D socket$inet6_tcp(0xa, 0x1, 0x0)
> sendto$inet6(0xffffffffffffffff, 0x0, 0x0, 0x20000004, 0x0, 0x0)
> shutdown(r0, 0x1)
> bind$inet6(r0, &(0x7f0000000040)=3D{0xa, 0x4e22, 0x0, @empty}, 0x1c)
> listen(r0, 0x0)
> r1 =3D socket$inet_mptcp(0x2, 0x1, 0x106)
> connect$inet(r1, &(0x7f0000000000)=3D{0x2, 0x4e22, @local}, 0x10)
> accept(r0, 0x0, 0x0)

The above is very similar to what Christoph reported. It should splat
even replacing 0x106 with 0 (mptcp -> tcp).

I'm fine with relaxing the check in __inet_accept(). Do you prefer send
to patch yourself, or me to send a v2? The condition should be

	WARN_ON(!((1 << newsk->sk_state) &
                  (TCPF_ESTABLISHED | TCPF_SYN_RECV |
                   TCPF_FIN_WAIT1 | TCPF_FIN_WAIT2 |
                   TCPF_CLOSING | TCPF_CLOSE_WAIT |
                   TCPF_CLOSE)));

I guess.

Thanks!

Paolo





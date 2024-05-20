Return-Path: <netdev+bounces-97200-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BBF68C9E54
	for <lists+netdev@lfdr.de>; Mon, 20 May 2024 15:47:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72221B20F70
	for <lists+netdev@lfdr.de>; Mon, 20 May 2024 13:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC3441E890;
	Mon, 20 May 2024 13:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vzD27aOj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57B8101DB
	for <netdev@vger.kernel.org>; Mon, 20 May 2024 13:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716212821; cv=none; b=RBG+vaOQccUst66B3o4dlTVY2M3iHww2hWd4z8jyatRAgiN0phoThes4TH52oBR5Xvowbvn+Z0y1iy79+U9yR59MJlseiHgLIjDDyqZ5CHqWnEHlpFBODo1nmaHT0x3zvaUAuyn0IJ8JDOH4qaQ/hTKxcKiSBl8DYGD56HEvaHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716212821; c=relaxed/simple;
	bh=87FWMWagMb2cwfvtuNT12t+jgouluWIG8tmoeQe+SRA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N1J2d+raNAwKTwwEWkaVi7VjJiFuopTEUXklKpUB+9Omzy65m3YKRtMx/o+P86gbTHHd/dGM7TREbA5aawMx9i4X64vqioCHa/aIN6MH49ee9pvwvNN5dex3QQQZFuUNgV7eJgnLiugXksipLOhMVELnw66XfDY/mEZ6XJmF9bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vzD27aOj; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-420107286ecso80795e9.0
        for <netdev@vger.kernel.org>; Mon, 20 May 2024 06:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716212818; x=1716817618; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U2/zHvz7fhtPsWu6RfRtTECnVsDT4yI8TWtZKItdVnw=;
        b=vzD27aOjQl6e66J2UH6q/LXjuOZgoSu1Ixht/DAl/hmB7TXkgOVSEcGERr6lC0SFmB
         UtDKxk8OyYdO+LR2AhI+fKunt4kS9Uct9+d+sGg6o/spH2Uk8GXlY/XEP4IibNUr5ggX
         yKl7qvPxK+pk7vsLjcYH4MeVicPXrGY7mJkjIxweDmQl9CBSQ5SNHO6GTdfm6jcoYJgg
         GcpFAC2QVHhmDJ/ojQDVLA44BG4T573ZfkiclYaDo3Y5XKNuQWGeQE1rBBbWNZrCIRz7
         fJpdss8P/bAd4F77ZWfdNU7i8oMasqpm7iLY9KkUtZwAZxt+Ik5e8ba7S8R60X2Edtp3
         7AoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716212818; x=1716817618;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U2/zHvz7fhtPsWu6RfRtTECnVsDT4yI8TWtZKItdVnw=;
        b=aa1sYikO3/LMkhQX8MlnA/aA6Q7aVcF1bWFzarxyQtsBM//Ws9+q+T5M7I57yKRxU2
         WAP/OVjuF8yvVRVdYB2e69lY3HA/7wqAlq7obEm5rQKf/wFnlUlgHPUO9KxQmzUsFJrA
         Vzil/BRssccrsPWs4UxEjc5WJPuUk0NELLZR/homifK8BSr4kWmDZTMWK3EFVF4t+AYO
         uWT/3IPHyswzlR93HiKBZ7Ef3e2xhOEdoTtZ7uTCxm6EgEXj79USkbjOFh5hyJgV5oC4
         HZcIDCFQ0LZirHpmOyd2NyP/JeYKZyRG11B7KJTIDZSk01di0Us9bMIShQahNYuAix5i
         9PNg==
X-Gm-Message-State: AOJu0YwkVe52WM8S4f6fNfjk9iOwJUmpwBhF06EHjxBkgytSMlIWnmjp
	bAAjetj0qs7SVTpRfd8HTjWEZSbM6UHsRNNvASNGh8Z1RdSAy/BVgquWJyK7wWJXLzFg44AOruC
	7mwaga+Au+Qj+gpL2grDl8pVOKq0i1+HRQe3/KTGpkMMIJta/2A==
X-Google-Smtp-Source: AGHT+IG8KCtYODlaKoWuJb7pVvk/cG7As3gH0MQMAYrJGXIkESC2c6O8jgs8Ab+uLWD+2Gi2mgZgzaMrVGnYvovFMf8=
X-Received: by 2002:a05:600c:1d89:b0:41f:a15d:220a with SMTP id
 5b1f17b1804b1-420e14d0db5mr3461695e9.4.1716212817899; Mon, 20 May 2024
 06:46:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8db98a8fbf2ac673b355651852093579a913f3f1.1716199422.git.pabeni@redhat.com>
In-Reply-To: <8db98a8fbf2ac673b355651852093579a913f3f1.1716199422.git.pabeni@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 20 May 2024 15:46:44 +0200
Message-ID: <CANn89i+zxB9g7n3JWXd8B-kkSkfRWfb7mOQcQi+mMLs6U-n5tQ@mail.gmail.com>
Subject: Re: [PATCH net] tcp: ensure sk_showdown is 0 for listening sockets
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Christoph Paasch <cpaasch@apple.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 20, 2024 at 12:05=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wr=
ote:
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
> Listener sockets are supposed to have a zero sk_shutdown, as the
> accepted children will inherit such field.
>
> Invoking shutdown() before entering the listener status allows
> violating the above constraint.
>
> After commit 94062790aedb ("tcp: defer shutdown(SEND_SHUTDOWN) for
> TCP_SYN_RECV sockets"), the above causes the child to reach the accept
> syscall in FIN_WAIT1 status.
>
> Address the issue explicitly by clearing sk_shutdown at listen time.
>
> Reported-by: Christoph Paasch <cpaasch@apple.com>
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/490
> Fixes: 1da177e4c3fu ("Linux-2.6.12-rc2")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> Note: the issue above reports an MPTCP reproducer, but I can reproduce
> the issue even using plain TCP sockets only.
> ---
>  net/ipv4/inet_connection_sock.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_s=
ock.c
> index 3b38610958ee..dab723fea0cc 100644
> --- a/net/ipv4/inet_connection_sock.c
> +++ b/net/ipv4/inet_connection_sock.c
> @@ -1269,6 +1269,8 @@ int inet_csk_listen_start(struct sock *sk)
>
>         reqsk_queue_alloc(&icsk->icsk_accept_queue);
>
> +       /* closed sockets can have non zero sk_shutdown */
> +       WRITE_ONCE(sk->sk_shutdown, 0);

Hi Paolo.

I am unsure about your patch, I had an internal syzbot report about
this before going OOO for a few days,
and my first reaction was to change the WARN in inet_accept().

Perhaps some applications are relying on calling shutdown() before listen()=
...


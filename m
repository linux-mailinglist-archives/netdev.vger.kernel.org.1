Return-Path: <netdev+bounces-192865-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A090AC16D5
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 00:31:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F23611BC8490
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 22:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0A2E2609DB;
	Thu, 22 May 2025 22:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="A20egL9e"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216EE265CD3
	for <netdev@vger.kernel.org>; Thu, 22 May 2025 22:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747953068; cv=none; b=akPUiLxAO7+5jZgNfjYVs7RbVhlyAYKuwoo8gWdhUkSVz3V1l7MQmRuVxct3XEw7QVpiWBFiILJZgoWlnIyCzlXhSeePhO48XIP0yE7JYJuhmviBaMCvPEZ3N34LguKTFm/SZ5I/bYh8JsIb24QlQPzYCu1VM1Xfi3Vu4qU35i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747953068; c=relaxed/simple;
	bh=T72RH0PgvGIje1HvylCqUGnYwWsbcjnsuq0TOzvURC0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Toda9y7XZKc3sys4k0cL2V+mjN6ZHHnRaxFIUEBQmIgDQH+fY9P8P4FnGNIMhzRguS9q218l2Eeho7ldStg7O+yrJov/TX7xogQ/j6kHL7KCVGLZPcDfGOoqEEPpuR9Wvo7YhQwcslqSz9DkjvsBkcIuaGy9BKuH1DqksK8Ra60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=A20egL9e; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-70c7b8794faso85378347b3.1
        for <netdev@vger.kernel.org>; Thu, 22 May 2025 15:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1747953066; x=1748557866; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OgZvmGZtv0rsbC365JhSq58tSkXcAtCiGXIOyj1Wj+k=;
        b=A20egL9evsOyvRnLNNmEMQD542nDr5Bh2uSqqc1iw9r65vPxFIaQ0WMROBg48j6fIT
         A4gyP5+bFOakfeP5+s9WY+GybG6siedeEt26S6brX43ODUCA4//n20QzD8u3fBkheT/+
         BcAl+PuKIIe69+SFfJHADrjgCkJrHBQBDUe5wkvzXxIzAqVydqPPKV8wyQXKJBTo5kE8
         5X4bFDGqkPxPS//nh6Y7zlFB4wjM0aIvI9mjkQ2AQAdQmta4pHM2PlXvXX/5avKDWFQT
         yXY/KJc3MowdiS5ftu6xH8l7t8VbeshAKNHf2FmSTYX+enKL2Bg9RMOOJf1py6RkigIH
         jUrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747953066; x=1748557866;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OgZvmGZtv0rsbC365JhSq58tSkXcAtCiGXIOyj1Wj+k=;
        b=us+jz+B8HGfYT1q5IW3dO7vSZ2aCeAxmrnfd6EhRoWdpzEL1qCzAj56K+pbjPs0twT
         TkNRnF/xuoxrGm2xF2SsbDflchYkmwyBnZpnRb4/nh1sg0cUNvueILImbe31PATAlPFa
         kcXh2xRqnqdvW4GvQPEibQQnE5FxXSCixHxlBp3oFH7lqYYZWeXrKuIQiVVFPBV+2OmH
         9HO+WPxGsmbzGKZv5AmmkJu3CcrKXVokr4YuS/tTCa5dLbv3W/jyYpKeP0PfIXsKkO/P
         iu0gjt40xEgE0Mf9Uyuz4iXCQJqcw5+gfRhLRGRjKcnRAzYER79GhAv1XdCml3FgfM8x
         8kBw==
X-Forwarded-Encrypted: i=1; AJvYcCWF92HubRJhgycDyJYs+PIF4FXM4eYVQCXoKsM2F5837WAiStIxaWaRkuqBJAZqvMGbt5SGspI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVaBXgkaZazf8er2MjyNu2lfHkaZ4ckkz2lsdWrgu4WH0v0CS0
	EGQ95DNTn2iVnNKfi1BvPpuOgHV2ExMIxTPJ1MAyxAfSWpA/jjiddtVCDMTEM8i6w2pRP5ah4BM
	3GSMqoagW3wtfb/gPNbrOwIz7XVnBMSQ129pC4Fny
X-Gm-Gg: ASbGncvROCHWEtTEftsWyJHKeB8rH1gV/2t7MrtEaiQH6zcVqSN/TV28KZxOJAhbYjl
	h6X95O9XR7/lpWjKHxxUWYQTqMzYbFja/LBN2EVQh+vWQ2A0qlL8sKSyEoYsCjFZl4mLzYvJ0YN
	EA9pXlw6+KIJyHZUItYnvn8x38O/O/rzba
X-Google-Smtp-Source: AGHT+IG6vHpp373rSBdjob18uDOgM9GJuMp3uYZE3WNXDPopC5CndYL6r+hAZB+No1NmpD9Wf5yuOG3uiJaa1p5XW5w=
X-Received: by 2002:a05:690c:6183:b0:70e:18c0:dab6 with SMTP id
 00721157ae682-70e18c0dd3bmr15621387b3.23.1747953066054; Thu, 22 May 2025
 15:31:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250522221858.91240-1-kuniyu@amazon.com>
In-Reply-To: <20250522221858.91240-1-kuniyu@amazon.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 22 May 2025 18:30:55 -0400
X-Gm-Features: AX0GCFv4uA9yw9lBOgE02-IL0rQvlgXxQBJbo-kWwsqHOXUwQCORZR62Y0FNRrQ
Message-ID: <CAHC9VhTM14E7Mz_ToVEqpW0CQr0KEfpwZOnSzTSYdMxX55k4yQ@mail.gmail.com>
Subject: Re: [PATCH v1 net] calipso: Don't call calipso functions for AF_INET sk.
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Huw Davies <huw@codeweavers.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	linux-security-module@vger.kernel.org, syzkaller <syzkaller@googlegroups.com>, 
	John Cheung <john.cs.hey@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 22, 2025 at 6:19=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> syzkaller reported a null-ptr-deref in txopt_get(). [0]
>
> The offset 0x70 was of struct ipv6_txoptions in struct ipv6_pinfo,
> so struct ipv6_pinfo was NULL there.
>
> However, this never happens for IPv6 sockets as inet_sk(sk)->pinet6
> is always set in inet6_create(), meaning the socket was not IPv6 one.
>
> The root cause is missing validation in netlbl_conn_setattr().
>
> netlbl_conn_setattr() switches branches based on struct
> sockaddr.sa_family, which is passed from userspace.  However,
> netlbl_conn_setattr() does not check if the address family matches
> the socket.
>
> The syzkaller must have called connect() for an IPv6 address on
> an IPv4 socket.
>
> We have a proper validation in tcp_v[46]_connect(), but
> security_socket_connect() is called in the earlier stage.
>
> Let's copy the validation to netlbl_conn_setattr().
>
> [0]:
> Oops: general protection fault, probably for non-canonical address 0xdfff=
fc000000000e: 0000 [#1] PREEMPT SMP KASAN NOPTI
> KASAN: null-ptr-deref in range [0x0000000000000070-0x0000000000000077]
> CPU: 2 UID: 0 PID: 12928 Comm: syz.9.1677 Not tainted 6.12.0 #1
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/0=
1/2014
> RIP: 0010:txopt_get include/net/ipv6.h:390 [inline]
> RIP: 0010:
> Code: 02 00 00 49 8b ac 24 f8 02 00 00 e8 84 69 2a fd e8 ff 00 16 fd 48 8=
d 7d 70 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f=
 85 53 02 00 00 48 8b 6d 70 48 85 ed 0f 84 ab 01 00
> RSP: 0018:ffff88811b8afc48 EFLAGS: 00010212
> RAX: dffffc0000000000 RBX: 1ffff11023715f8a RCX: ffffffff841ab00c
> RDX: 000000000000000e RSI: ffffc90007d9e000 RDI: 0000000000000070
> RBP: 0000000000000000 R08: ffffed1023715f9d R09: ffffed1023715f9e
> R10: ffffed1023715f9d R11: 0000000000000003 R12: ffff888123075f00
> R13: ffff88810245bd80 R14: ffff888113646780 R15: ffff888100578a80
> FS:  00007f9019bd7640(0000) GS:ffff8882d2d00000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f901b927bac CR3: 0000000104788003 CR4: 0000000000770ef0
> PKRU: 80000000
> Call Trace:
>  <TASK>
>  calipso_sock_setattr+0x56/0x80 net/netlabel/netlabel_calipso.c:557
>  netlbl_conn_setattr+0x10c/0x280 net/netlabel/netlabel_kapi.c:1177
>  selinux_netlbl_socket_connect_helper+0xd3/0x1b0 security/selinux/netlabe=
l.c:569
>  selinux_netlbl_socket_connect_locked security/selinux/netlabel.c:597 [in=
line]
>  selinux_netlbl_socket_connect+0xb6/0x100 security/selinux/netlabel.c:615
>  selinux_socket_connect+0x5f/0x80 security/selinux/hooks.c:4931
>  security_socket_connect+0x50/0xa0 security/security.c:4598
>  __sys_connect_file+0xa4/0x190 net/socket.c:2067
>  __sys_connect+0x12c/0x170 net/socket.c:2088
>  __do_sys_connect net/socket.c:2098 [inline]
>  __se_sys_connect net/socket.c:2095 [inline]
>  __x64_sys_connect+0x73/0xb0 net/socket.c:2095
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xaa/0x1b0 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f901b61a12d
> Code: 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48 89 f=
7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff=
 ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f9019bd6fa8 EFLAGS: 00000246 ORIG_RAX: 000000000000002a
> RAX: ffffffffffffffda RBX: 00007f901b925fa0 RCX: 00007f901b61a12d
> RDX: 000000000000001c RSI: 0000200000000140 RDI: 0000000000000003
> RBP: 00007f901b701505 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 0000000000000000 R14: 00007f901b5b62a0 R15: 00007f9019bb7000
>  </TASK>
> Modules linked in:
>
> Fixes: ceba1832b1b2 ("calipso: Set the calipso socket label to match the =
secattr.")
> Reported-by: syzkaller <syzkaller@googlegroups.com>
> Reported-by: John Cheung <john.cs.hey@gmail.com>
> Closes: https://lore.kernel.org/netdev/CAP=3DRh=3DM1LzunrcQB1fSGauMrJrhL6=
GGps5cPAKzHJXj6GQV+-g@mail.gmail.com/
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---
>  net/netlabel/netlabel_kapi.c | 3 +++
>  1 file changed, 3 insertions(+)

Looks good to me, thanks for tracking this down and fixing it :)

Acked-by: Paul Moore <paul@paul-moore.com>

> diff --git a/net/netlabel/netlabel_kapi.c b/net/netlabel/netlabel_kapi.c
> index cd9160bbc919..6ea16138582c 100644
> --- a/net/netlabel/netlabel_kapi.c
> +++ b/net/netlabel/netlabel_kapi.c
> @@ -1165,6 +1165,9 @@ int netlbl_conn_setattr(struct sock *sk,
>                 break;
>  #if IS_ENABLED(CONFIG_IPV6)
>         case AF_INET6:
> +               if (sk->sk_family !=3D AF_INET6)
> +                       return -EAFNOSUPPORT;
> +
>                 addr6 =3D (struct sockaddr_in6 *)addr;
>                 entry =3D netlbl_domhsh_getentry_af6(secattr->domain,
>                                                    &addr6->sin6_addr);
> --
> 2.49.0

--=20
paul-moore.com


Return-Path: <netdev+bounces-142683-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C30029BFFFF
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 09:33:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5F001C20A7E
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 08:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCDA81DB377;
	Thu,  7 Nov 2024 08:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ka7kExoQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CDB0192B69
	for <netdev@vger.kernel.org>; Thu,  7 Nov 2024 08:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730968385; cv=none; b=uEoY78FYUIDW5woVGk8YWFgkfid29PPKhGFabssZ02SJG9mOrsEltgJXIPlCmGXyOiH+qAheN5YHALyrgPBsER9djyS5pyGXSvO779xpkXyiGRmG/baL2CdtyJgqUigWUwMZAkxbcujRckCMRW6l4sw/JABnx0l/5JZ2G8llRDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730968385; c=relaxed/simple;
	bh=DLpnnOAE5LShy6LOl7lFJ3w/Yc46xYGkdgWDj6J1pM4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IQW6o/XztGfqcv/7faWGuP2ccKo5/12k9G9YmVGZwa72XA5pV1aJoW67VGX9zWiWXQH2ZO+JpUUz41TNcSn1y3leszlBftyMC11lE2ZAxHs7ylXfCXvXirdw18lmtqoFXzIsKWcK11DVY5VG/tnv4vOsdDjAHk9xQsP24OOzGqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ka7kExoQ; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5cecbddb574so701210a12.1
        for <netdev@vger.kernel.org>; Thu, 07 Nov 2024 00:33:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730968382; x=1731573182; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+D6WmWVJFZBv4J2JNkjNaJkpf36ZnMPPh4XK+oZyhxY=;
        b=Ka7kExoQqwXdArC6BFVHcZDqQxBKMepY54AjKIfwYnKIde3ek5wPp8k+ZZkGWSdEuf
         uNZXjjvdKNEgS8+WJXvIKukamhCqunduBntItD6zCCeER5mPxzb6b8rxcjEGoC5NNrzr
         mYEfn4tPeDe7ozZg5KORnvh8yeYRw1ypcojCZkAtARfIcXoOyujq6J9S5eGMNoP6Meh5
         T9Unq+1HBgv6WY7fpUF9XiYD7KGXDHFKRrxLIlTvv+nItI5zqaN/oJ2dz/iyanedtCBo
         ZI5zX4gWVkbtAhaasuhHKnSngna0BQgRxDip/ovlRpW28RnfyCZsNdUmrINJtCHIfEpV
         3oKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730968382; x=1731573182;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+D6WmWVJFZBv4J2JNkjNaJkpf36ZnMPPh4XK+oZyhxY=;
        b=d4AzkqDCO2F0O8kIj+OjpVcwcvm6dCsCBNEfbGYjq9xZYDDVKfwreITc1qVvfmBPda
         xEpyBIs3omUVZ1PO8xoAJxn3dlEf1/RbZKfW6aH1JEgx8d9gI4RAErLwuXMxJTm6lZ9k
         0igf2CgZyg2FBoKwYf6V5o/43VuzIvd8Rr1coI/Pv4LX/mXQH0le/YUvk+IcuRznmP07
         bW69rW9xmmSlYkQWBOUchTeDMSPS77gLvA1sr4Z7eXDaGpN7+c8jIFS/p4C5Ff0WsB1p
         hfPw7yd11Tqlb8DiHnGQG+4N0AGt2AWedJUJRyK/8kvTIAEW/M9TSNozCByNCURfFREj
         3C+w==
X-Forwarded-Encrypted: i=1; AJvYcCXDauigGENFMSnITccB0NtPBDqHc5R97t0IZyOo259so3JTcDvLYIJKI4Yjnb+TMU86ZN++tUQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4imQuyAuZLQxrUW1iD0XAW940iG/e6YJBb36otH+lboFNtNwQ
	nVj+iR54zzgTKeiu+7qA2jGTWpj0if/SFgvGXlFCVk9iJNf+/8+sapldfwzuGXVlMPyrrYThPnG
	++m0LmpVGKrXlCWntLvOeFxgwQaNUBnp3JHYQ
X-Google-Smtp-Source: AGHT+IEp8OJrTnpizzWdFwl9LvAvmaQqEzHs5AswfyqatTHsuA1v4EGmOu+dh60LkKOFWGfaBWvu/z8O+Gnd9Ms3CFs=
X-Received: by 2002:a05:6402:40c1:b0:5ce:afba:f480 with SMTP id
 4fb4d7f45d1cf-5ceafbb04e5mr21069594a12.25.1730968382155; Thu, 07 Nov 2024
 00:33:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241106221922.1544045-1-edumazet@google.com> <ac3a7d28-0a0b-413e-8e9c-44b81fbe9121@linux.ibm.com>
In-Reply-To: <ac3a7d28-0a0b-413e-8e9c-44b81fbe9121@linux.ibm.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 7 Nov 2024 09:32:50 +0100
Message-ID: <CANn89iJ382wPnWz11FdymoGvKgmXoKKF29_-ip3316U9puuTjg@mail.gmail.com>
Subject: Re: [PATCH net] net/smc: do not leave a dangling sk pointer in __smc_create()
To: Wenjia Zhang <wenjia@linux.ibm.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Ignat Korchagin <ignat@cloudflare.com>, 
	"D. Wythe" <alibuda@linux.alibaba.com>, Dust Li <dust.li@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 7, 2024 at 9:28=E2=80=AFAM Wenjia Zhang <wenjia@linux.ibm.com> =
wrote:
>
>
>
> On 06.11.24 23:19, Eric Dumazet wrote:
> > Thanks to commit 4bbd360a5084 ("socket: Print pf->create() when
> > it does not clear sock->sk on failure."), syzbot found an issue with AF=
_SMC:
> >
> > smc_create must clear sock->sk on failure, family: 43, type: 1, protoco=
l: 0
> >   WARNING: CPU: 0 PID: 5827 at net/socket.c:1565 __sock_create+0x96f/0x=
a30 net/socket.c:1563
> > Modules linked in:
> > CPU: 0 UID: 0 PID: 5827 Comm: syz-executor259 Not tainted 6.12.0-rc6-ne=
xt-20241106-syzkaller #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS=
 Google 09/13/2024
> >   RIP: 0010:__sock_create+0x96f/0xa30 net/socket.c:1563
> > Code: 03 00 74 08 4c 89 e7 e8 4f 3b 85 f8 49 8b 34 24 48 c7 c7 40 89 0c=
 8d 8b 54 24 04 8b 4c 24 0c 44 8b 44 24 08 e8 32 78 db f7 90 <0f> 0b 90 90 =
e9 d3 fd ff ff 89 e9 80 e1 07 fe c1 38 c1 0f 8c ee f7
> > RSP: 0018:ffffc90003e4fda0 EFLAGS: 00010246
> > RAX: 099c6f938c7f4700 RBX: 1ffffffff1a595fd RCX: ffff888034823c00
> > RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> > RBP: 00000000ffffffe9 R08: ffffffff81567052 R09: 1ffff920007c9f50
> > R10: dffffc0000000000 R11: fffff520007c9f51 R12: ffffffff8d2cafe8
> > R13: 1ffffffff1a595fe R14: ffffffff9a789c40 R15: ffff8880764298c0
> > FS:  000055557b518380(0000) GS:ffff8880b8600000(0000) knlGS:00000000000=
00000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 00007fa62ff43225 CR3: 0000000031628000 CR4: 00000000003526f0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > Call Trace:
> >   <TASK>
> >    sock_create net/socket.c:1616 [inline]
> >    __sys_socket_create net/socket.c:1653 [inline]
> >    __sys_socket+0x150/0x3c0 net/socket.c:1700
> >    __do_sys_socket net/socket.c:1714 [inline]
> >    __se_sys_socket net/socket.c:1712 [inline]
> >
> > For reference, see commit 2d859aff775d ("Merge branch
> > 'do-not-leave-dangling-sk-pointers-in-pf-create-functions'")
> >
> > Fixes: d25a92ccae6b ("net/smc: Introduce IPPROTO_SMC")
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > Cc: Kuniyuki Iwashima <kuniyu@amazon.com>
> > Cc: Ignat Korchagin <ignat@cloudflare.com>
> > Cc: D. Wythe <alibuda@linux.alibaba.com>
> > Cc: Wenjia Zhang <wenjia@linux.ibm.com>
> > Cc: Dust Li <dust.li@linux.alibaba.com>
> > ---
>
> Thank you, Eric, for fixing it! The code looks good to me.
> Should the fixed commit not be 2fe5273f149c instead of d25a92ccae6b?
>

The bug was there, even before 2fe5273f149c ("net/smc: prevent UAF in
inet_create()")

Thanks.


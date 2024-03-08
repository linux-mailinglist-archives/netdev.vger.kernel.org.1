Return-Path: <netdev+bounces-78805-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A273C8769C8
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 18:23:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C16341C2085D
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 17:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DD9F28DA4;
	Fri,  8 Mar 2024 17:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cIUqicvr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA40620B0E
	for <netdev@vger.kernel.org>; Fri,  8 Mar 2024 17:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709918616; cv=none; b=etjcWSGTJKFeLc5FldfGDkKQa7KUFg1G1c8yNylScxH+L+hvbueAXk4kxhH8CC6+1NN4M5W18hsO43ss/uijqrakUaMVFC74YS+F1agdruCIXyDZES1ZWu+fYz6XELLfg7yVmKa39zkBHDzFWlr4+N/zX13LATN4u1UNwYrxyEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709918616; c=relaxed/simple;
	bh=z/dJ4mMGGVaFiMXyMWa3aXhSwqp9ok923prZOjji7Xk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oyiQIoiZcizB2aRSM1JhclXK+h+ZBk4rROfC11ZA8ln9EdNT/tYDw0FrnEXWRbdy3VF0A6DVMJ/OdflqlXQIpN6QB8+9RbkyrqQFezhzAlKjF4ZNy/SiLjm4Asb2H8VEgiXfRE3ZaFwaE0th2ZyVRfzqVgqLOLddUhR0dr7YzT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cIUqicvr; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-412d84ffbfaso86815e9.0
        for <netdev@vger.kernel.org>; Fri, 08 Mar 2024 09:23:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709918613; x=1710523413; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z/DUK0qKGR9iHphEKuSDP7Jycd8B/UvA9gbRoqjvviw=;
        b=cIUqicvr7ZXP2CcgxlTiTceC67ypPY19yUJMSbwDDyD86ep/W+taO75fYovt15vlPH
         8lDLtndTen2mCgHgPW3/MA9PrsxJ56H1jiyTsi2EjHFqEOjl32lowgh4RWKLI8aK/Lru
         7o7vGJHXDbYhUAxTB17hRspHC5+NwKkgCdENWBEI5BchpiySzr/zOaJvIe2cEhuRwj2b
         FspYvQkQ/Xu8SQxrpdQYnkLMUaQSoPWIsj3Zd20tEQmuCpuJhfpQKkF4hzsb0gU86cds
         JCl42vOAAnG8YNYgRnIYdH7cg+NdOdXttd1FCRWANPaAaVI1yEwfkcD6Vfky9f8tnQCs
         0BCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709918613; x=1710523413;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z/DUK0qKGR9iHphEKuSDP7Jycd8B/UvA9gbRoqjvviw=;
        b=kPAXerWtgO3ohesQLErwLR7UFFK0dyUI4COMROM5nfKn/QhwYwLIrJxXV4exoLawwV
         Ylw8/SNET6fNquqKUnufYkcq3d/K95JXR1CikChLztk/rZeJrirvm4LMcTV+2CnrxzYm
         dck4gOjDEKGMnmaSaLt9kvqimrHJvIBZLqR9V21aB8Dcjal11Be7Fpndx9GPxd6gopb2
         8CCH8WKCSXK6dDMdt3kBaaOC78DzXUmnioIY5dX4qEggqv6zy7AtlV3yFcvvTK/r48Fy
         7gteGqXGmdvM/S54vxEBDS6kIeGTQSJYnr7ui7UuwIoWADRlZXGxYLR6bpE8Gth37Fd9
         Sfmw==
X-Forwarded-Encrypted: i=1; AJvYcCW620shvoXuyvZILPr2bTc+5C+6gAPLjj2Pk2Yx2cIXF/jrC9sFrimMn11ALmmp3gBMDEMlHWsKHpC7SSA8+ven12xoLf5E
X-Gm-Message-State: AOJu0YyATtb1qkwKcpkUZ4FuaMx0g+ib8VqZsIhyby31RZep4sPqaliz
	Uf1tfJBo77Du5VSsrwilGtetVcMWklzqGcwpjTn3bk6ZMc5+tEpvwYelTkJ0CuAxKuxdjKCPAlc
	vO5HLwZMEAPRB0FfzFyTUrPnf6lxQh2B8ipJS
X-Google-Smtp-Source: AGHT+IHPnE9LwUl1b+KqluATQW7Eg3Wv15leJ7xN3olX5iNNWbKdNprTwXpezwJEFasuAz9m9qwoErdVHUIocGnjs7E=
X-Received: by 2002:a05:600c:1e0f:b0:413:1e06:cc40 with SMTP id
 ay15-20020a05600c1e0f00b004131e06cc40mr5809wmb.2.1709918612970; Fri, 08 Mar
 2024 09:23:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240214191308.98504-1-kuniyu@amazon.com> <170807702475.29322.4063439451772691558.git-patchwork-notify@kernel.org>
In-Reply-To: <170807702475.29322.4063439451772691558.git-patchwork-notify@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 8 Mar 2024 18:23:18 +0100
Message-ID: <CANn89iJuHQuTOoSxj025_9u0P0L7n=NBZhwy4DOS1JjsMghRBQ@mail.gmail.com>
Subject: Re: [PATCH v3 net] dccp/tcp: Unhash sk from ehash for tb2 alloc
 failure after check_estalblished().
To: patchwork-bot+netdevbpf@kernel.org
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, joannelkoong@gmail.com, 
	kuni1840@gmail.com, netdev@vger.kernel.org, syzkaller@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 16, 2024 at 10:50=E2=80=AFAM <patchwork-bot+netdevbpf@kernel.or=
g> wrote:
>
> Hello:
>
> This patch was applied to netdev/net.git (main)
> by David S. Miller <davem@davemloft.net>:
>
> On Wed, 14 Feb 2024 11:13:08 -0800 you wrote:
> > syzkaller reported a warning [0] in inet_csk_destroy_sock() with no
> > repro.
> >
> >   WARN_ON(inet_sk(sk)->inet_num && !inet_csk(sk)->icsk_bind_hash);
> >
> > However, the syzkaller's log hinted that connect() failed just before
> > the warning due to FAULT_INJECTION.  [1]
> >
> > [...]
>
> Here is the summary with links:
>   - [v3,net] dccp/tcp: Unhash sk from ehash for tb2 alloc failure after c=
heck_estalblished().
>     https://git.kernel.org/netdev/net/c/66b60b0c8c4a
>
> You are awesome, thank you!
> --
> Deet-doot-dot, I am a bot.
> https://korg.docs.kernel.org/patchwork/pwbot.html
>

Kuniyuki, syzbot is not happy after this patch I think. I will release
the report soon.

WARNING: CPU: 0 PID: 23948 at include/net/sock.h:799
sk_nulls_del_node_init_rcu+0x166/0x1a0 include/net/sock.h:799
Modules linked in:
CPU: 0 PID: 23948 Comm: syz-executor.2 Not tainted
6.8.0-rc6-syzkaller-00159-gc055fc00c07b #0
Hardware name: Google Google Compute Engine/Google Compute Engine,
BIOS Google 01/25/2024
RIP: 0010:sk_nulls_del_node_init_rcu+0x166/0x1a0 include/net/sock.h:799
Code: e8 7f 71 c6 f7 83 fb 02 7c 25 e8 35 6d c6 f7 4d 85 f6 0f 95 c0
5b 41 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc e8 1b 6d c6 f7 90 <0f> 0b
90 eb b2 e8 10 6d c6 f7 4c 89 e7 be 04 00 00 00 e8 63 e7 d2
RSP: 0018:ffffc900032d7848 EFLAGS: 00010246
RAX: ffffffff89cd0035 RBX: 0000000000000001 RCX: 0000000000040000
RDX: ffffc90004de1000 RSI: 000000000003ffff RDI: 0000000000040000
RBP: 1ffff1100439ac26 R08: ffffffff89ccffe3 R09: 1ffff1100439ac28
R10: dffffc0000000000 R11: ffffed100439ac29 R12: ffff888021cd6140
R13: dffffc0000000000 R14: ffff88802a9bf5c0 R15: ffff888021cd6130
FS: 00007f3b823f16c0(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f3b823f0ff8 CR3: 000000004674a000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
<TASK>
__inet_hash_connect+0x140f/0x20b0 net/ipv4/inet_hashtables.c:1139
dccp_v6_connect+0xcb9/0x1480 net/dccp/ipv6.c:956
__inet_stream_connect+0x262/0xf30 net/ipv4/af_inet.c:678
inet_stream_connect+0x65/0xa0 net/ipv4/af_inet.c:749
__sys_connect_file net/socket.c:2048 [inline]
__sys_connect+0x2df/0x310 net/socket.c:2065
__do_sys_connect net/socket.c:2075 [inline]
__se_sys_connect net/socket.c:2072 [inline]
__x64_sys_connect+0x7a/0x90 net/socket.c:2072
do_syscall_64+0xf9/0x240
entry_SYSCALL_64_after_hwframe+0x6f/0x77
RIP: 0033:0x7f3b8167dda9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f3b823f10c8 EFLAGS: 00000246 ORIG_RAX: 000000000000002a
RAX: ffffffffffffffda RBX: 00007f3b817abf80 RCX: 00007f3b8167dda9
RDX: 000000000000001c RSI: 0000000020000040 RDI: 0000000000000003
RBP: 00007f3b823f1120 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 000000000000000b R14: 00007f3b817abf80 R15: 00007ffd3beb57b8
</TASK>


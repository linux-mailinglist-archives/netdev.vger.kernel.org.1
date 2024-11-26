Return-Path: <netdev+bounces-147391-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2B3B9D95D9
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 11:53:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 616E12830C2
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 10:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B67BC1CB518;
	Tue, 26 Nov 2024 10:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="laP9ejX0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0FF79DC
	for <netdev@vger.kernel.org>; Tue, 26 Nov 2024 10:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732618402; cv=none; b=hdj9ZnTDpQ5ZlHHfKq1N7RvOFtpkfHOBFGYuH68jKp+uFvmZVSW/dxduTJNCC9dTlkBR2LdmKPh+jamt2HrHsZePmusuD+XJnM2vbf1A6WxMTnn6cu+nNpEgoyWtHgsSMLXpEVUEEFtn9cfxlRVnNqESR2N5cfOnT9HXT0qmaKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732618402; c=relaxed/simple;
	bh=dIPmgX4kZQHnQyY1VsXWLcrAw0KRwCEwPbrfRqSzaKM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m1miDWHsABkxXvl1cPqpn9I5vE6rPR1LeR8BwsBBjC4SQ1YEJishqdDoGx90fVomeTsxSMoAsvMv231cxyQFxemk1xqVdCPnAS8WbZ96Jg+rCnxeUzu/VLkoQN4eTP5DlXafJOeHth02YT0Yi1o6dJ7cyKQ9Fy4Jo93HSOHpJ5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=laP9ejX0; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5cfc035649bso7186022a12.2
        for <netdev@vger.kernel.org>; Tue, 26 Nov 2024 02:53:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732618399; x=1733223199; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NfLpA7OTy014y4257nSH3pKmraCZDoT+LP97ys/ccF0=;
        b=laP9ejX0mwtzQtkVJ+hw3+p5gknt8LBDoLJskuFpkatZQG9IuIMRE/CZ0h/wTdfQk0
         Om7tpBzbH4lq8qhfsMpsdFS2rWF8w2lThDvKvn6NocyQggIPi2ytEmRvS9XY3lDEI28x
         bwwSgVghW4KyXrv0gNgk2AnI3aogtsWvrtgMW0JiE6aCwz3gak1oDPB/nxSEBJbzVoOn
         nRVrA0hpaVAz+oyXnoF0F2a0WNmWlRiXDDOGXlfNPIezjqIenHflAn/LwxS9jconNwtL
         E+qUrhpaV8/5utJeRi3IOCKORh8BACZjeq9jXI322Lb56/FTdYO/Eacz4lWWYODYIxwu
         tBLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732618399; x=1733223199;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NfLpA7OTy014y4257nSH3pKmraCZDoT+LP97ys/ccF0=;
        b=dosbIYosdVqRv5eVyHBLj44mMJnxxRnYsMX0XZzM50bWQzbBmaNK5uu5EHBWfjK/4B
         oheTRdxjll3zWTtzyup4UBDb00q7Ic5IiEPe9nkwten5vaiLZBZ5cJvsEWZQ4w6e8u8k
         +imABlg6y5T898HdE5twIMh9gSkt2XItH0t3+ZNlIavy29IpYG1l25hvrRqkMHEKnxlZ
         usBOlmJ+7iUU4IL8ePMT0/JpkHccJSmB78Np+D3f/Trq2p1Om1qwWA/uO8LtFBLA8h0R
         zMTN1L+ONEvu8p9VwunIoWBjmVUq5Lsc05/KF786SKphYbEMKdMl7EERkveKN9n3W21l
         mCcg==
X-Forwarded-Encrypted: i=1; AJvYcCVWmV4QXAJOyA9uRDM8PcoVps7pFvmonZ7h6vy+tAlT1FL9aw2Jm7TFn87ab/hpQd//7xC1gFo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmaMzkzVWU5Mx3NR64tLVPsuAEe4cSavdJG7kUm7XqGZbWznyg
	7z4xdb1wsUQjISKhOOS7i7nP5q1SgDiurVWXhbHaJHnONwhToGMCwOj7ClZPBzqlfDbLvkb25lO
	mYUksVRUF7bbO4GAb60/uVwDCMtkIl6I9oBNv
X-Gm-Gg: ASbGncvLZyNrJnfTOPnPDun6rBKXP02C00wMhN6gO5n8iVoxhk3SRdvnKPXGMm1y6Zw
	mVnww9h7Ug0tFrLlY+Obc9GoCjLz70JDn
X-Google-Smtp-Source: AGHT+IFvFaDaA11u7byskmqxFpqY4Ux9YS+k8sIUc6XUvtaxsh4IrsyO5hLoS6mr2ns9aKi5Eth47lj0ZZ82v1vyorE=
X-Received: by 2002:a05:6402:4492:b0:5cf:c97c:8206 with SMTP id
 4fb4d7f45d1cf-5d020695181mr14268135a12.25.1732618398894; Tue, 26 Nov 2024
 02:53:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241126061446.64052-1-kuniyu@amazon.com>
In-Reply-To: <20241126061446.64052-1-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 26 Nov 2024 11:53:07 +0100
Message-ID: <CANn89iLXk2BRLWuyvEsxOVqRBo2qbuOydv33xfKAe54M9tKPUA@mail.gmail.com>
Subject: Re: [PATCH v1 net] tipc: Fix use-after-free of kernel socket in cleanup_bearer().
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Jon Maloy <jmaloy@redhat.com>, Ying Xue <ying.xue@windriver.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Eric W. Biederman" <ebiederm@xmission.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	tipc-discussion@lists.sourceforge.net, syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 26, 2024 at 7:14=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> syzkaller reported a use-after-free of kernel UDP socket in
> cleanup_bearer() without repro. [0][1]
>
> When bearer_disable() calls tipc_udp_disable(), cleanup of the kernel
> UDP socket is deferred by work calling cleanup_bearer().
>
> Since the cited commit, however, the socket's netns might not be alive
> when the work is executed, resulting in use-after-free.
>
> Let's hold netns for the kernel UDP socket when created.
>
> Note that we can't call get_net() before scheduling the work and call
> put_net() in cleanup_bearer() because bearer_disable() could be called
> from pernet_operations.exit():
>
>   tipc_exit_net
>   `- tipc_net_stop
>      `- tipc_bearer_stop
>         `- bearer_disable
>
> [0]:
> ref_tracker: net notrefcnt@000000009b3d1faf has 1/1 users at
>      sk_alloc+0x438/0x608
>      inet_create+0x4c8/0xcb0
>      __sock_create+0x350/0x6b8
>      sock_create_kern+0x58/0x78
>      udp_sock_create4+0x68/0x398
>      udp_sock_create+0x88/0xc8
>      tipc_udp_enable+0x5e8/0x848
>      __tipc_nl_bearer_enable+0x84c/0xed8
>      tipc_nl_bearer_enable+0x38/0x60
>      genl_family_rcv_msg_doit+0x170/0x248
>      genl_rcv_msg+0x400/0x5b0
>      netlink_rcv_skb+0x1dc/0x398
>      genl_rcv+0x44/0x68
>      netlink_unicast+0x678/0x8b0
>      netlink_sendmsg+0x5e4/0x898
>      ____sys_sendmsg+0x500/0x830
>
> [1]:
> BUG: KMSAN: use-after-free in udp_hashslot include/net/udp.h:85 [inline]
> BUG: KMSAN: use-after-free in udp_lib_unhash+0x3b8/0x930 net/ipv4/udp.c:1=
979
>  udp_hashslot include/net/udp.h:85 [inline]
>  udp_lib_unhash+0x3b8/0x930 net/ipv4/udp.c:1979
>  sk_common_release+0xaf/0x3f0 net/core/sock.c:3820
>  inet_release+0x1e0/0x260 net/ipv4/af_inet.c:437
>  inet6_release+0x6f/0xd0 net/ipv6/af_inet6.c:489
>  __sock_release net/socket.c:658 [inline]
>  sock_release+0xa0/0x210 net/socket.c:686
>  cleanup_bearer+0x42d/0x4c0 net/tipc/udp_media.c:819
>  process_one_work kernel/workqueue.c:3229 [inline]
>  process_scheduled_works+0xcaf/0x1c90 kernel/workqueue.c:3310
>  worker_thread+0xf6c/0x1510 kernel/workqueue.c:3391
>  kthread+0x531/0x6b0 kernel/kthread.c:389
>  ret_from_fork+0x60/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:244
>
> Uninit was created at:
>  slab_free_hook mm/slub.c:2269 [inline]
>  slab_free mm/slub.c:4580 [inline]
>  kmem_cache_free+0x207/0xc40 mm/slub.c:4682
>  net_free net/core/net_namespace.c:454 [inline]
>  cleanup_net+0x16f2/0x19d0 net/core/net_namespace.c:647
>  process_one_work kernel/workqueue.c:3229 [inline]
>  process_scheduled_works+0xcaf/0x1c90 kernel/workqueue.c:3310
>  worker_thread+0xf6c/0x1510 kernel/workqueue.c:3391
>  kthread+0x531/0x6b0 kernel/kthread.c:389
>  ret_from_fork+0x60/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:244
>
> CPU: 0 UID: 0 PID: 54 Comm: kworker/0:2 Not tainted 6.12.0-rc1-00131-gf66=
ebf37d69c #7 91723d6f74857f70725e1583cba3cf4adc716cfa
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.3-0-=
ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
> Workqueue: events cleanup_bearer
>
> Fixes: 26abe14379f8 ("net: Modify sk_alloc to not reference count the net=
ns of kernel sockets.")
> Reported-by: syzkaller <syzkaller@googlegroups.com>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---
> I'll remove this ugly hack by clearner API in the next cycle.
> see:
> https://lore.kernel.org/netdev/20241112001308.58355-1-kuniyu@amazon.com/
> ---
>  net/tipc/udp_media.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/net/tipc/udp_media.c b/net/tipc/udp_media.c
> index 439f75539977..10986b283ac8 100644
> --- a/net/tipc/udp_media.c
> +++ b/net/tipc/udp_media.c
> @@ -673,6 +673,7 @@ static int tipc_udp_enable(struct net *net, struct ti=
pc_bearer *b,
>         struct nlattr *opts[TIPC_NLA_UDP_MAX + 1];
>         u8 node_id[NODE_ID_LEN] =3D {0,};
>         struct net_device *dev;
> +       struct sock *sk;
>         int rmcast =3D 0;
>
>         ub =3D kzalloc(sizeof(*ub), GFP_ATOMIC);
> @@ -792,6 +793,12 @@ static int tipc_udp_enable(struct net *net, struct t=
ipc_bearer *b,
>         if (err)
>                 goto free;
>
> +       sk =3D ub->ubsock->sk;
> +       __netns_tracker_free(net, &sk->ns_tracker, false);
> +       sk->sk_net_refcnt =3D 1;
> +       get_net_track(net, &sk->ns_tracker, GFP_KERNEL);
> +       sock_inuse_add(net, 1);
> +
>         return 0;

I think 'kernel sockets' were not refcounted to allow the netns to be remov=
ed.

Otherwise, what would tipc_bearer_stop() be needed ?

tipc_exit_net(struct net *net)  // can only be called when all refcnt
have been released
 -> tipc_net_stop()
  -> tipc_bearer_stop()
    -> bearer_disable()
     -> tipc_udp_disable()
       -> INIT_WORK(&ub->work, cleanup_bearer); schedule_work(&ub->work);


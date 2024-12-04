Return-Path: <netdev+bounces-149044-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD0BC9E3D89
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 16:01:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66CF42837B6
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 15:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A22AA20B815;
	Wed,  4 Dec 2024 15:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AmCoyFDr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADECD1B21BA
	for <netdev@vger.kernel.org>; Wed,  4 Dec 2024 15:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733324485; cv=none; b=aUrg1rk/cS2bTOmHEMtm0vHJnUyGagRwQGjxYwfpxz51XLJjyUrtot1nJFydi5jyXfHK/vgelkO7ETME6EadhJqUqu3tBo4b75OWEcvUTAtpRJEudcc5SkcGAOY305DxSa+psK3LX5Pmr4adk1X8/LgESUoq9ii81Lx44zFDdLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733324485; c=relaxed/simple;
	bh=dSUKCDy2FPTBw4n8sOBE+R3dBmkr8vZhVCsUXMA/OpU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iG22Na6nioMZHua73rlly/1/FoefqgH0XIgZQu77LmRlIR+n3j3BVsYSquVT2GIxupHUtfhmcJS6Hj5soIWMl8tDe2wqdrXhMDS4lCtplQdYYiwIdwI1OapW0tTKwjWQ62SKE/esJId/F4lYRmEh2Y3FA1VrZgglj+Y3GNur69c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AmCoyFDr; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5d0ca0f67b6so6085317a12.3
        for <netdev@vger.kernel.org>; Wed, 04 Dec 2024 07:01:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733324482; x=1733929282; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rICjVG8S8+zyjHm1ueAW2GyUbyHKZTsx6R3rVayK63w=;
        b=AmCoyFDrX8p66TfH2qNiOyUr/L2hp4QNwjlS3FzXDbO2TcgGNzfyFdw7q7HUugKr18
         5aODTmePrLysM/C+Xkc+BQqHF5/0ugp0dQXP+eaC3opXPqUzNTIDApLexOvm+GxSZTA/
         pexHmeHTB12FYFgz2+dJe0zu6GeRqWRcZDAEvaJ1oMJob5pNBZFe0dnrdDqI586N/Vck
         s1x5JUyhf2LQO58k9Wlv4+USwHpY/aOTsh+k0G2iPDkYzb8jff7EA2wIx9u1BzQ8U5Ne
         7eR1TgJYJoPruqk4yCwvAhXkKluolf+NRo4ViEKHb/oV5DEMGFnLROXHmp8EVjBr/Szy
         v8gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733324482; x=1733929282;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rICjVG8S8+zyjHm1ueAW2GyUbyHKZTsx6R3rVayK63w=;
        b=kVMsXINHJYNF1tQckdgGMCsu6SBfN0Rs4VZT5D5XRV/i0h0F7QLYHUtlAvw55voQlm
         OMvTP/O5xEyEopwuy9FdyRT1QSiERW0aguEdtcugN/UPq+o34zfEoWTi/wlcATrxomAW
         X6Dc5aWJ2g8onAyT2I16Lbs+WPCqAGdQKvOi3YhwLcZphbxFHFa9fYh9bg1A1bkzRr9/
         JrflJyFUL21oTOH8naP4nBxZKgfrwRnxMspUvPRPbRNVwYNcBEScnt2MLi51txNdLfE0
         vMZpDv9i4mc/ihrFeHTggfh3g4dTl24Ps0RZUSavdalEOaFJF3WEdPcPMqN8b/+kdoel
         jlZA==
X-Forwarded-Encrypted: i=1; AJvYcCUj8rdITqwKa9W6GuhEjrAcLux2dRnT9tb3JA9Gd3esH2s1UXkoP2yG/ius2TN8FkADfbu/SNI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yywlr1RNf+eGlcD6m8pybT5RtBTUjAq4WUaNSMfKe9GusA+gnD2
	TYfPoRvBvPo30T29nwJ/qjqVBl9VsevTcV7YznZUMMUu+kV2Ek7Wn/VNQ6F9JLmGRLl8k+wN8ov
	X/avIxPAxnGQjTyMPqaS0beC2eh0yzN/AhfxK
X-Gm-Gg: ASbGnctwJoFf78RpP3qH4pBe2aJrqhZcNHYunFLjfnY2gOwCw+kaNAWFi/3+1j/JGBp
	KOvdrWgFlkCMD3iCd+zjUM8ynWEL+r8C6
X-Google-Smtp-Source: AGHT+IGDi8nOidHSuWmr+QFso7hhTWnLbnIwe+un8khJ7hJ88qi1pPFUWN29pmnql8hIhrpoKmYK0/kwiY+bJjZo1Q8=
X-Received: by 2002:a05:6402:27d1:b0:5d0:d91d:c195 with SMTP id
 4fb4d7f45d1cf-5d10cba4ffemr5023777a12.32.1733324481523; Wed, 04 Dec 2024
 07:01:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241127050512.28438-1-kuniyu@amazon.com>
In-Reply-To: <20241127050512.28438-1-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 4 Dec 2024 16:01:10 +0100
Message-ID: <CANn89iJ-GfHU=sLWJiuqNcoH+AnBtj9dSxpXHjqbAS_VZ8fzAw@mail.gmail.com>
Subject: Re: [PATCH v2 net] tipc: Fix use-after-free of kernel socket in cleanup_bearer().
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Jon Maloy <jmaloy@redhat.com>, Ying Xue <ying.xue@windriver.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Eric W. Biederman" <ebiederm@xmission.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	tipc-discussion@lists.sourceforge.net, syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 27, 2024 at 6:05=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> syzkaller reported a use-after-free of UDP kernel socket
> in cleanup_bearer() without repro. [0][1]
>
> When bearer_disable() calls tipc_udp_disable(), cleanup
> of the UDP kernel socket is deferred by work calling
> cleanup_bearer().
>
> tipc_net_stop() waits for such works to finish by checking
> tipc_net(net)->wq_count.  However, the work decrements the
> count too early before releasing the kernel socket,
> unblocking cleanup_net() and resulting in use-after-free.
>
> Let's move the decrement after releasing the socket in
> cleanup_bearer().
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
> v2:
>   * Keep kernel socket with no net refcnt.
>
> v1: https://lore.kernel.org/netdev/20241126061446.64052-1-kuniyu@amazon.c=
om/
> ---
>  net/tipc/udp_media.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/tipc/udp_media.c b/net/tipc/udp_media.c
> index 439f75539977..b7e25e7e9933 100644
> --- a/net/tipc/udp_media.c
> +++ b/net/tipc/udp_media.c
> @@ -814,10 +814,10 @@ static void cleanup_bearer(struct work_struct *work=
)
>                 kfree_rcu(rcast, rcu);
>         }
>
> -       atomic_dec(&tipc_net(sock_net(ub->ubsock->sk))->wq_count);
>         dst_cache_destroy(&ub->rcast.dst_cache);
>         udp_tunnel_sock_release(ub->ubsock);
>         synchronize_net();
> +       atomic_dec(&tipc_net(sock_net(ub->ubsock->sk))->wq_count);

Note that ub->ubsock->sk is NULL at this point.

I am testing the following fix, does it make sense to you ?

diff --git a/net/tipc/udp_media.c b/net/tipc/udp_media.c
index b7e25e7e9933b69aa6a3364e3287c358b7ac9421..1d359de9dd6ad7ff60b6b93f620=
ff6783e385106
100644
--- a/net/tipc/udp_media.c
+++ b/net/tipc/udp_media.c
@@ -807,6 +807,7 @@ static void cleanup_bearer(struct work_struct *work)
 {
        struct udp_bearer *ub =3D container_of(work, struct udp_bearer, wor=
k);
        struct udp_replicast *rcast, *tmp;
+       struct tipc_net *tn;

        list_for_each_entry_safe(rcast, tmp, &ub->rcast.list, list) {
                dst_cache_destroy(&rcast->dst_cache);
@@ -814,10 +815,14 @@ static void cleanup_bearer(struct work_struct *work)
                kfree_rcu(rcast, rcu);
        }

+       tn =3D tipc_net(sock_net(ub->ubsock->sk));
+
        dst_cache_destroy(&ub->rcast.dst_cache);
        udp_tunnel_sock_release(ub->ubsock);
+
+       /* Note: we could use a call_rcu() to avoid another synchronize_net=
() */
        synchronize_net();
-       atomic_dec(&tipc_net(sock_net(ub->ubsock->sk))->wq_count);
+       atomic_dec(&tn->wq_count);
        kfree(ub);
 }


Return-Path: <netdev+bounces-143072-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC80D9C10B6
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 22:12:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2AE5DB24AA8
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 21:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EC28215C75;
	Thu,  7 Nov 2024 21:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YqcT3mLM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C77194C92
	for <netdev@vger.kernel.org>; Thu,  7 Nov 2024 21:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731013721; cv=none; b=KubtR7b6TPZHtD/RXAD2FQWOges7XUNOJGx6cXXrF5coKjh6CM2GzlT0LNuvcM8SL0SzLaRYjkH2/nX7Z1u/r7YRWE+P57qjDs07ncFJ/3rHLGgKOyaZ6Y/YRjFOEaK4PLF9p3ziTP/0EFBgi8vXtSTDi/5EyavYPbr/O5C+fmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731013721; c=relaxed/simple;
	bh=l7cLQNshIsTfhNr6kM44Q1r0Bqx8cCQsM1kn5HstMVs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=helbKaAQl5PIYSbVWXaMCewAa3uYRRS4TX2zVTFQmzcrRLcEvIcVYIYci34RwrJc2UxMe6Mt0TbkAwr6OKuf4t+7FetsA0BA5jPhxB369xWgrxZrXo4F2qeBEnLPgmqC5KXithOWSU0dxgA1Ajcs8ErKBBbljaWZQoAl/ULymIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YqcT3mLM; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3a4ccfde548so4503265ab.1
        for <netdev@vger.kernel.org>; Thu, 07 Nov 2024 13:08:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731013719; x=1731618519; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W4lVvFUFaKfVZDh86WKU4TxQmPLEEBzz5vUP5SpSiaY=;
        b=YqcT3mLM60S0vF4f8Q/hMFgwnOFFcuQUsPN5KeJ8Pv9JSypACinQSAtUC7vrVAhXAB
         R/OQ3EDHUKKp0oYiyHgOXnDgzT9GceWY4owN1Q8brFc23Iz/qUfC9mRWDR3Lpk4dk860
         RhbF/dr6mw79u9VT3i26lWA6qy7wzCMJa2Gwr6bgTSdjSuahmrTP4fcMjutB1Y02R+F8
         TkBttFimLhyid+WiFDvsj6AjasTPQ/PVGuX6LLPcSLBo7iwsHYM5q1S/B/rSs5LnnWij
         R4LTvBdjxfkQ8OdLBB5cgOZxM2B4/7P5m5dkjhpKptmth6pP3wsm2YLU1wxhe/xdtuF7
         3WfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731013719; x=1731618519;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W4lVvFUFaKfVZDh86WKU4TxQmPLEEBzz5vUP5SpSiaY=;
        b=inp2vfI03xdpKw2mEG6OYETP/FGgt8fXP1+wBLFmf0QpT6tu4ciu9m3AF5MHvW8v3R
         chtgTAULknmcJMUsQGpaHkYTXbzXHtdT6UtreoDVKO/qio2DWVIPDVKXmJIWWICwIb6m
         Uh4VLNZcQ0eqdcj8vQwBnzvrUwscbBdVe1PWyuLif390/A/LcbZCpO+6rGy0aYXQc/b0
         qRRxWqCifRp/k+NjQhoHjVAhBsZcr5CcMpVJ5wQSZ4jtgATbXWD915ShzSgwZjt5NL4K
         dD0F7Jt3fKKukRcWZuKsjM1ILkMnMKTtBwajpAg9NdQmuA/GSlrcQK+RnkZG0XnOAbQm
         mLuw==
X-Forwarded-Encrypted: i=1; AJvYcCU7aHgAhmPjUrLG9zWD9B897R8FsdNsmgSeFBSkktmNrBcfx0wKjYW1G3SqJ9YzvgSeWPfwupc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4xrqlqv0UF+fUExYG+cA5wV3aEPrePRSpnLZ16SDv8vlEaQSq
	evurujpJnbKonQPDhEec8cMl+UCkHhRw/38g5bKZDjK3wFHKHKx2Hllsxllqzo2zluP9HfvoTEW
	OWBximU+1GTxQzhxES3awjd6KlXw=
X-Google-Smtp-Source: AGHT+IEtmch65EXFMbMIkCX7wODEfue1uvwyker87opa7mWjPu7AGnJ8O334r0COSCHN8RYKzUyEWGhxQIyAWpwjG90=
X-Received: by 2002:a05:6e02:349c:b0:3a0:9c04:8047 with SMTP id
 e9e14a558f8ab-3a6f24b2433mr3412835ab.6.1731013718710; Thu, 07 Nov 2024
 13:08:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241107192021.2579789-1-edumazet@google.com>
In-Reply-To: <20241107192021.2579789-1-edumazet@google.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Thu, 7 Nov 2024 16:08:27 -0500
Message-ID: <CADvbK_dhcQGtBtutCuwiKhjZ-Lw1Oxc15d1CrHs4Tf7r5keB0A@mail.gmail.com>
Subject: Re: [PATCH net-next] sctp: fix possible UAF in sctp_v6_available()
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 7, 2024 at 2:20=E2=80=AFPM Eric Dumazet <edumazet@google.com> w=
rote:
>
> A lockdep report [1] with CONFIG_PROVE_RCU_LIST=3Dy hints
> that sctp_v6_available() is calling dev_get_by_index_rcu()
> and ipv6_chk_addr() without holding rcu.
>
> [1]
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
>  WARNING: suspicious RCU usage
>  6.12.0-rc5-virtme #1216 Tainted: G        W
>  -----------------------------
>  net/core/dev.c:876 RCU-list traversed in non-reader section!!
>
> other info that might help us debug this:
>
> rcu_scheduler_active =3D 2, debug_locks =3D 1
>  1 lock held by sctp_hello/31495:
>  #0: ffff9f1ebbdb7418 (sk_lock-AF_INET6){+.+.}-{0:0}, at: sctp_bind (./ar=
ch/x86/include/asm/jump_label.h:27 net/sctp/socket.c:315) sctp
>
> stack backtrace:
>  CPU: 7 UID: 0 PID: 31495 Comm: sctp_hello Tainted: G        W          6=
.12.0-rc5-virtme #1216
>  Tainted: [W]=3DWARN
>  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debia=
n-1.16.3-2 04/01/2014
>  Call Trace:
>   <TASK>
>  dump_stack_lvl (lib/dump_stack.c:123)
>  lockdep_rcu_suspicious (kernel/locking/lockdep.c:6822)
>  dev_get_by_index_rcu (net/core/dev.c:876 (discriminator 7))
>  sctp_v6_available (net/sctp/ipv6.c:701) sctp
>  sctp_do_bind (net/sctp/socket.c:400 (discriminator 1)) sctp
>  sctp_bind (net/sctp/socket.c:320) sctp
>  inet6_bind_sk (net/ipv6/af_inet6.c:465)
>  ? security_socket_bind (security/security.c:4581 (discriminator 1))
>  __sys_bind (net/socket.c:1848 net/socket.c:1869)
>  ? do_user_addr_fault (./include/linux/rcupdate.h:347 ./include/linux/rcu=
pdate.h:880 ./include/linux/mm.h:729 arch/x86/mm/fault.c:1340)
>  ? do_user_addr_fault (./arch/x86/include/asm/preempt.h:84 (discriminator=
 13) ./include/linux/rcupdate.h:98 (discriminator 13) ./include/linux/rcupd=
ate.h:882 (discriminator 13) ./include/linux/mm.h:729 (discriminator 13) ar=
ch/x86/mm/fault.c:1340 (discriminator 13))
>  __x64_sys_bind (net/socket.c:1877 (discriminator 1) net/socket.c:1875 (d=
iscriminator 1) net/socket.c:1875 (discriminator 1))
>  do_syscall_64 (arch/x86/entry/common.c:52 (discriminator 1) arch/x86/ent=
ry/common.c:83 (discriminator 1))
>  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
>  RIP: 0033:0x7f59b934a1e7
>  Code: 44 00 00 48 8b 15 39 8c 0c 00 f7 d8 64 89 02 b8 ff ff ff ff eb bd =
66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 b8 31 00 00 00 0f 05 <48> 3d 01 f0 f=
f ff 73 01 c3 48 8b 0d 09 8c 0c 00 f7 d8 64 89 01 48
> All code
> =3D=3D=3D=3D=3D=3D=3D=3D
>    0:   44 00 00                add    %r8b,(%rax)
>    3:   48 8b 15 39 8c 0c 00    mov    0xc8c39(%rip),%rdx        # 0xc8c4=
3
>    a:   f7 d8                   neg    %eax
>    c:   64 89 02                mov    %eax,%fs:(%rdx)
>    f:   b8 ff ff ff ff          mov    $0xffffffff,%eax
>   14:   eb bd                   jmp    0xffffffffffffffd3
>   16:   66 2e 0f 1f 84 00 00    cs nopw 0x0(%rax,%rax,1)
>   1d:   00 00 00
>   20:   0f 1f 00                nopl   (%rax)
>   23:   b8 31 00 00 00          mov    $0x31,%eax
>   28:   0f 05                   syscall
>   2a:*  48 3d 01 f0 ff ff       cmp    $0xfffffffffffff001,%rax         <=
-- trapping instruction
>   30:   73 01                   jae    0x33
>   32:   c3                      ret
>   33:   48 8b 0d 09 8c 0c 00    mov    0xc8c09(%rip),%rcx        # 0xc8c4=
3
>   3a:   f7 d8                   neg    %eax
>   3c:   64 89 01                mov    %eax,%fs:(%rcx)
>   3f:   48                      rex.W
>
> Code starting with the faulting instruction
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>    0:   48 3d 01 f0 ff ff       cmp    $0xfffffffffffff001,%rax
>    6:   73 01                   jae    0x9
>    8:   c3                      ret
>    9:   48 8b 0d 09 8c 0c 00    mov    0xc8c09(%rip),%rcx        # 0xc8c1=
9
>   10:   f7 d8                   neg    %eax
>   12:   64 89 01                mov    %eax,%fs:(%rcx)
>   15:   48                      rex.W
>  RSP: 002b:00007ffe2d0ad398 EFLAGS: 00000202 ORIG_RAX: 0000000000000031
>  RAX: ffffffffffffffda RBX: 00007ffe2d0ad3d0 RCX: 00007f59b934a1e7
>  RDX: 000000000000001c RSI: 00007ffe2d0ad3d0 RDI: 0000000000000005
>  RBP: 0000000000000005 R08: 1999999999999999 R09: 0000000000000000
>  R10: 00007f59b9253298 R11: 0000000000000202 R12: 00007ffe2d0ada61
>  R13: 0000000000000000 R14: 0000562926516dd8 R15: 00007f59b9479000
>   </TASK>
>
> Fixes: 6fe1e52490a9 ("sctp: check ipv6 addr with sk_bound_dev if set")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Xin Long <lucien.xin@gmail.com>
> Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Acked-by: Xin Long <lucien.xin@gmail.com>

> ---
>  net/sctp/ipv6.c | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)
>
> diff --git a/net/sctp/ipv6.c b/net/sctp/ipv6.c
> index f7b809c0d142c0e6c8e29c2badc4428648117f31..38e2fbdcbeac4bf3185d98f8a=
cae4aea531ca140 100644
> --- a/net/sctp/ipv6.c
> +++ b/net/sctp/ipv6.c
> @@ -683,7 +683,7 @@ static int sctp_v6_available(union sctp_addr *addr, s=
truct sctp_sock *sp)
>         struct sock *sk =3D &sp->inet.sk;
>         struct net *net =3D sock_net(sk);
>         struct net_device *dev =3D NULL;
> -       int type;
> +       int type, res, bound_dev_if;
>
>         type =3D ipv6_addr_type(in6);
>         if (IPV6_ADDR_ANY =3D=3D type)
> @@ -697,14 +697,21 @@ static int sctp_v6_available(union sctp_addr *addr,=
 struct sctp_sock *sp)
>         if (!(type & IPV6_ADDR_UNICAST))
>                 return 0;
>
> -       if (sk->sk_bound_dev_if) {
> -               dev =3D dev_get_by_index_rcu(net, sk->sk_bound_dev_if);
> +       rcu_read_lock();
> +       bound_dev_if =3D READ_ONCE(sk->sk_bound_dev_if);
> +       if (bound_dev_if) {
> +               res =3D 0;
> +               dev =3D dev_get_by_index_rcu(net, bound_dev_if);
>                 if (!dev)
> -                       return 0;
> +                       goto out;
>         }
>
> -       return ipv6_can_nonlocal_bind(net, &sp->inet) ||
> -              ipv6_chk_addr(net, in6, dev, 0);
> +       res =3D ipv6_can_nonlocal_bind(net, &sp->inet) ||
> +             ipv6_chk_addr(net, in6, dev, 0);
> +
> +out:
> +       rcu_read_unlock();
> +       return res;
>  }
>
>  /* This function checks if the address is a valid address to be used for
> --
> 2.47.0.277.g8800431eea-goog
>


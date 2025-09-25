Return-Path: <netdev+bounces-226500-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F44CBA1114
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 20:47:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B46827B88E0
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 18:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2A3F31AF1A;
	Thu, 25 Sep 2025 18:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VWN9sZeP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC131241673
	for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 18:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758826003; cv=none; b=nWPfZ30AN0EI3Gafxc0kkjdiLVcFxd4Q2fKYthOuSgYMiNrQ3BVBRFIZyMGz+M5TgVVF8guZ3zk4PWq8sJ7PZ7k2F21a3wO9Q3fh2gPyP1D5wR7mkAbBpunAGZpzxS6kdIn/8BW5g77zmAA4g+S3lDHKObp0OSWAVhNrRf04ef8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758826003; c=relaxed/simple;
	bh=lfgcz3m4LxsJc7fu9Gh6cquree6UlWdW+wi7FdecF+E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PA2GzHuOQsyp6V4JSwIME+SQU3mTAcV6A3IC131jecYxB05j6QuKeuHwIfsWvo8j53MosYndPHabxE8iHnr9MM+HcQ98JcV6U/c9khx6ja2ZrVv0qIBZeYuR6fC3X7IJDbPtOPKkHd/YpbweGi+oKF4orKQ3BNI8JfSc5wp1+6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VWN9sZeP; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-24457f581aeso14091725ad.0
        for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 11:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758826000; x=1759430800; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lLdUuxsUyFeLw5VmYATasRsILS+Z5g1sPWduMjqAJtQ=;
        b=VWN9sZePBfN8PboPgWPiYarkSaQayMFmyL4dwSRNIbNagtH0EkrrbtlQHgrePovVAE
         njAMWChJ5eh2jR25v9pMJkaW+hB8zhRMWNRxf2/QW5aHTjayVyrcI2NL0eZ+Tmp5B0sq
         DBC9YZV5sfFeNFtN4pUj3C4CZO+3A8CxftmQFglqCMrENpNZOpDHgGK6Ay3JLXiY2rfW
         YpL9CnssC6D1ukSvVTNmyt/BnNyL/plYCUhuFP19vx8HpiSHSMOORIHCF8gF+QSb/4in
         5v3GPqIrd3/bdZG/b0/M8vTVk4Mkw3rNRPX59eZ6FLmqANaAjSR8iNSNVQxztCCWwQy2
         aMqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758826000; x=1759430800;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lLdUuxsUyFeLw5VmYATasRsILS+Z5g1sPWduMjqAJtQ=;
        b=I8v3aB4mZZlooKzzlIPPshNdol+ehtha8t8K97Qp6na6MzEEEbXgO12aFS2s+SJQt8
         HbkRknTSbF789M5hn6tXV4ArZCpvq0QCYOhnvpRG8kyzhFPZFzEopCVVz/+xeklFlEyz
         fNmV1asZXZitwPoVVE8wTK4PMvTUAyp+jmCt/4FBFonwESAFkIH6Y5I7x/QP6xIEBNin
         FASL8M341+9YX9sa6EGthHdARZjXhZeRTiQx0u0iB4e+tFzZWAJ/Nj4I3liWKmh1e6UG
         a27JPhk51zs2qqdyHc+29Rxylq8pMeVjO1PKeZ4+Lo0cyA9qqiEyPGo6zpxxQKyyIws2
         xmgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTuyM91vcbEPtL4mf7LD7F89ZrpY9IV5ztr4tKeb+Bte+ZG0w2gKjs3cVZoQHTZ/n7IVyR/lI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXiuBT9cIJoIwkk/fBKgb5egeWGs/u0AADajFxHsgDcnavslDS
	ZOp7mKJI0bEKWP7rExtLpgcL78M5/4FaCF0YWoOXK5XHxJsG99CC5L+HDyY0AH78BpbobcGljVx
	jpVa7gKkj92FmDelCQMO8Oo88V5dE+fq9I3FfkVhz
X-Gm-Gg: ASbGncsjsHUsjCTVyNzXwvVII0ax6rqnmXsTEZrzPjd0jza9ZWDOtHZxgfucVLJDKx2
	8PR9jxo05bVJPQU7ynO2Yc7K3ZYCv1/lThKpYL8VVyTM8ckP2SJRiAYr5+kHCb9c5XzifhfjkiQ
	4z4i4jSvvuHK3xxzxJn/G/VZym64a1TxOeYvnso7bfmKOEyol2Fy89VihMlgkqaWBTma2rZYWhX
	Q5trLpqGsRU9xg8WnpxmXMYEHAHjaUtx8hY6wgSGsiudOUaLkcHMxRLrQ==
X-Google-Smtp-Source: AGHT+IFHjpr/efSIGkSFc5aOwJwEJU/g3ib8aCrwbTfnR8LYDmx3PXaFp3wa4hoCDt63NVnjWqyIsHdEpL7XBgbkxZg=
X-Received: by 2002:a17:902:d490:b0:277:71e6:b04d with SMTP id
 d9443c01a7336-27ed4a29e5dmr46669715ad.3.1758825999931; Thu, 25 Sep 2025
 11:46:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250922121818.654011-1-wangliang74@huawei.com> <CANn89iLOyFnwD+monMHCmTgfZEAPWmhrZu-=8mvtMGyM9FG49g@mail.gmail.com>
In-Reply-To: <CANn89iLOyFnwD+monMHCmTgfZEAPWmhrZu-=8mvtMGyM9FG49g@mail.gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 25 Sep 2025 11:46:28 -0700
X-Gm-Features: AS18NWCbS5gc66qTtEBpXFcEyjAbYBGY7oQ_xwB_xqs7eGxR4FmmvHj2dUmJMhQ
Message-ID: <CAAVpQUBxoWW_4U2an4CZNoSi95OduUhArezHnzKgpV3oOYs5Jg@mail.gmail.com>
Subject: Re: [PATCH net] net/smc: fix general protection fault in __smc_diag_dump
To: Wang Liang <wangliang74@huawei.com>
Cc: Eric Dumazet <edumazet@google.com>, alibuda@linux.alibaba.com, 
	dust.li@linux.alibaba.com, sidraya@linux.ibm.com, wenjia@linux.ibm.com, 
	mjambigi@linux.ibm.com, tonylu@linux.alibaba.com, guwen@linux.alibaba.com, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	yuehaibing@huawei.com, zhangchangzhong@huawei.com, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks Eric for CCing me.

On Thu, Sep 25, 2025 at 7:32=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Mon, Sep 22, 2025 at 4:57=E2=80=AFAM Wang Liang <wangliang74@huawei.co=
m> wrote:
> >
> > The syzbot report a crash:
> >
> >   Oops: general protection fault, probably for non-canonical address 0x=
fbd5a5d5a0000003: 0000 [#1] SMP KASAN NOPTI
> >   KASAN: maybe wild-memory-access in range [0xdead4ead00000018-0xdead4e=
ad0000001f]
> >   CPU: 1 UID: 0 PID: 6949 Comm: syz.0.335 Not tainted syzkaller #0 PREE=
MPT(full)
> >   Hardware name: Google Google Compute Engine/Google Compute Engine, BI=
OS Google 08/18/2025
> >   RIP: 0010:smc_diag_msg_common_fill net/smc/smc_diag.c:44 [inline]
> >   RIP: 0010:__smc_diag_dump.constprop.0+0x3ca/0x2550 net/smc/smc_diag.c=
:89
> >   Call Trace:
> >    <TASK>
> >    smc_diag_dump_proto+0x26d/0x420 net/smc/smc_diag.c:217
> >    smc_diag_dump+0x27/0x90 net/smc/smc_diag.c:234
> >    netlink_dump+0x539/0xd30 net/netlink/af_netlink.c:2327
> >    __netlink_dump_start+0x6d6/0x990 net/netlink/af_netlink.c:2442
> >    netlink_dump_start include/linux/netlink.h:341 [inline]
> >    smc_diag_handler_dump+0x1f9/0x240 net/smc/smc_diag.c:251
> >    __sock_diag_cmd net/core/sock_diag.c:249 [inline]
> >    sock_diag_rcv_msg+0x438/0x790 net/core/sock_diag.c:285
> >    netlink_rcv_skb+0x158/0x420 net/netlink/af_netlink.c:2552
> >    netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
> >    netlink_unicast+0x5a7/0x870 net/netlink/af_netlink.c:1346
> >    netlink_sendmsg+0x8d1/0xdd0 net/netlink/af_netlink.c:1896
> >    sock_sendmsg_nosec net/socket.c:714 [inline]
> >    __sock_sendmsg net/socket.c:729 [inline]
> >    ____sys_sendmsg+0xa95/0xc70 net/socket.c:2614
> >    ___sys_sendmsg+0x134/0x1d0 net/socket.c:2668
> >    __sys_sendmsg+0x16d/0x220 net/socket.c:2700
> >    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> >    do_syscall_64+0xcd/0x4e0 arch/x86/entry/syscall_64.c:94
> >    entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >    </TASK>
> >
> > The process like this:
> >
> >                (CPU1)              |             (CPU2)
> >   ---------------------------------|-------------------------------
> >   inet_create()                    |
> >     // init clcsock to NULL        |
> >     sk =3D sk_alloc()                |
> >                                    |
> >     // unexpectedly change clcsock |
> >     inet_init_csk_locks()          |
> >                                    |
> >     // add sk to hash table        |
> >     smc_inet_init_sock()           |
> >       smc_sk_init()                |
> >         smc_hash_sk()              |
> >                                    | // traverse the hash table
> >                                    | smc_diag_dump_proto
> >                                    |   __smc_diag_dump()
> >                                    |     // visit wrong clcsock
> >                                    |     smc_diag_msg_common_fill()
> >     // alloc clcsock               |
> >     smc_create_clcsk               |
> >       sock_create_kern             |
> >
> > With CONFIG_DEBUG_LOCK_ALLOC=3Dy, the smc->clcsock is unexpectedly chan=
ged
> > in inet_init_csk_locks(), because the struct smc_sock does not have str=
uct
> > inet_connection_sock as the first member.
> >
> > Previous commit 60ada4fe644e ("smc: Fix various oops due to inet_sock t=
ype
> > confusion.") add inet_sock as the first member of smc_sock. For protoco=
l
> > with INET_PROTOSW_ICSK, use inet_connection_sock instead of inet_sock i=
s
> > more appropriate.

Why is INET_PROTOSW_ICSK necessary in the first place ?

I don't see a clear reason because smc_clcsock_accept() allocates
a new sock by smc_sock_alloc() and does not use inet_accept().

Or is there any other path where smc_sock is cast to
inet_connection_sock ?


> >
> > Reported-by: syzbot+f775be4458668f7d220e@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=3Df775be4458668f7d220e
> > Tested-by: syzbot+f775be4458668f7d220e@syzkaller.appspotmail.com
> > Fixes: d25a92ccae6b ("net/smc: Introduce IPPROTO_SMC")
> > Signed-off-by: Wang Liang <wangliang74@huawei.com>
> > ---
> >  net/smc/smc.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/net/smc/smc.h b/net/smc/smc.h
> > index 2c9084963739..1b20f0c927d3 100644
> > --- a/net/smc/smc.h
> > +++ b/net/smc/smc.h
> > @@ -285,7 +285,7 @@ struct smc_connection {
> >  struct smc_sock {                              /* smc sock container *=
/
> >         union {
> >                 struct sock             sk;
> > -               struct inet_sock        icsk_inet;
> > +               struct inet_connection_sock     inet_conn;
> >         };
> >         struct socket           *clcsock;       /* internal tcp socket =
*/
> >         void                    (*clcsk_state_change)(struct sock *sk);
> > --
> > 2.34.1
> >
>
> Kuniyuki, can you please review, I think you had a related fix recently.
>
> Thanks.
>
> commit 60ada4fe644edaa6c2da97364184b0425e8aeaf5
> Author: Kuniyuki Iwashima <kuniyu@google.com>
> Date:   Fri Jul 11 06:07:52 2025 +0000
>
>     smc: Fix various oops due to inet_sock type confusion.


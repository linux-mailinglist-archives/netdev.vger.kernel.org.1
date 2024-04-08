Return-Path: <netdev+bounces-85882-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F219B89CBB8
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 20:31:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6537289FB8
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 18:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB81F847B;
	Mon,  8 Apr 2024 18:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="sXljoa/g"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76711DA23
	for <netdev@vger.kernel.org>; Mon,  8 Apr 2024 18:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712601091; cv=none; b=Y3+yAR6Hkkpvel7edWgjbesVGL3YmwFzS8pjUjqdRHezXOAH5TQigTSty6m8mbl5h37QzVFmmuy/TXtAnxLeAxtcDw7hQXvRht19X2lbp3z/Ec4xERK5Xnb8+DBbr5G4bSusYNi3GKyxLVBslDpeZod4DQ1Te2YjfPhLufXXcMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712601091; c=relaxed/simple;
	bh=x5KHj+ifeDwbxvvBuwX17GFCiYzbn7G6SrWLQW7zNZ4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T9kOSjqkpNERfhsBkwknUz5PkbtHeniWb2VfngyTS71bH2G9onEX8y2wIuM020XzJMx6j+IgSqpp/gQAOu70NZUMBnl9i7jLLt3FRGLaDyburF4UhJjst7cftP5OYbN1NjV2jNosVYC21966MVHOUDJQkwYft0dBKCI09aZwd9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=sXljoa/g; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1712601089; x=1744137089;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OeIiG3FWoJ2zkbZKHWUHM96ETcgoIhT27BJX5kHrjdU=;
  b=sXljoa/goYSDBhS4JdIZDe81DLHVGyDXs864V1ODAdwVAL2hMRwTEC15
   QPmGX5NYBOEbR0qqP/VbbmIT9fKD51fiatHSpMTbuA2NW/ig833atRWT6
   +Cx/qVCmTb+B4UccjG1rTxU07fZcOygNQrHFN1PK1i7xEyq+bD6smP6Q7
   g=;
X-IronPort-AV: E=Sophos;i="6.07,187,1708387200"; 
   d="scan'208";a="79570075"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 18:31:27 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.38.20:40306]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.39.237:2525] with esmtp (Farcaster)
 id 1749bf93-30f6-4f4b-90da-3129df0f491c; Mon, 8 Apr 2024 18:31:27 +0000 (UTC)
X-Farcaster-Flow-ID: 1749bf93-30f6-4f4b-90da-3129df0f491c
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 8 Apr 2024 18:31:27 +0000
Received: from 88665a182662.ant.amazon.com (10.106.101.26) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 8 Apr 2024 18:31:23 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <aha310510@gmail.com>
CC: <daan.j.demeyer@gmail.com>, <davem@davemloft.net>, <dsahern@kernel.org>,
	<edumazet@google.com>, <eric.dumazet@gmail.com>, <kuba@kernel.org>,
	<kuniyu@amazon.com>, <martin.lau@kernel.org>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <willemdebruijn.kernel@gmail.com>
Subject: Re: [PATCH net] net: implement lockless setsockopt(SO_PEEK_OFF)
Date: Mon, 8 Apr 2024 11:31:14 -0700
Message-ID: <20240408183114.76329-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240408154354.164278-1-aha310510@gmail.com>
References: <20240408154354.164278-1-aha310510@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D032UWB004.ant.amazon.com (10.13.139.136) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Jeongjun Park <aha310510@gmail.com>
Date: Tue,  9 Apr 2024 00:43:54 +0900
> Eric Dumazet wrote:
> > On Mon, Apr 8, 2024 at 4:30 PM Jeongjun Park <aha310510@gmail.com> wrote:
> > >
> > > Eric Dumazet wrote:
> > > > syzbot reported a lockdep violation [1] involving af_unix
> > > > support of SO_PEEK_OFF.
> > > >
> > > > Since SO_PEEK_OFF is inherently not thread safe (it uses a per-socket
> > > > sk_peek_off field), there is really no point to enforce a pointless
> > > > thread safety in the kernel.
> > > >
> > > > After this patch :
> > > >
> > > > - setsockopt(SO_PEEK_OFF) no longer acquires the socket lock.
> > > >
> > > > - skb_consume_udp() no longer has to acquire the socket lock.
> > > >
> > > > - af_unix no longer needs a special version of sk_set_peek_off(),
> > > >   because it does not lock u->iolock anymore.
> > >
> > > The method employed in this patch, which avoids locking u->iolock in
> > > SO_PEEK_OFF, appears to have effectively remedied the immediate vulnerability,
> > > and the patch itself seems robust.
> > >
> > > However, if a future scenario arises where mutex_lock(&u->iolock) is required
> > > after sk_setsockopt(sk), this patch would become ineffective.
> > >
> > > In practical testing within my environment, I observed that reintroducing
> > > mutex_lock(&u->iolock) within sk_setsockopt() triggered the vulnerability once again.
> > >
> > > Therefore, I believe it's crucial to address the fundamental cause triggering this vulnerability
> > > alongside the current patch.
> > >
> > > [   30.537400] ======================================================
> > > [   30.537765] WARNING: possible circular locking dependency detected
> > > [   30.538237] 6.9.0-rc1-00058-g4076fa161217-dirty #8 Not tainted
> > > [   30.538541] ------------------------------------------------------
> > > [   30.538791] poc/209 is trying to acquire lock:
> > > [   30.539008] ffff888007a8cd58 (sk_lock-AF_UNIX){+.+.}-{0:0}, at: __unix_dgram_recvmsg+0x37e/0x550
> > > [   30.540060]
> > > [   30.540060] but task is already holding lock:
> > > [   30.540482] ffff888007a8d070 (&u->iolock){+.+.}-{3:3}, at: __unix_dgram_recvmsg+0xec/0x550
> > > [   30.540871]
> > > [   30.540871] which lock already depends on the new lock.
> > > [   30.540871]
> > > [   30.541341]
> > > [   30.541341] the existing dependency chain (in reverse order) is:
> > > [   30.541816]
> > > [   30.541816] -> #1 (&u->iolock){+.+.}-{3:3}:
> > > [   30.542411]        lock_acquire+0xc0/0x2e0
> > > [   30.542650]        __mutex_lock+0x91/0x4b0
> > > [   30.542830]        sk_setsockopt+0xae2/0x1510
> > > [   30.543009]        do_sock_setsockopt+0x14e/0x180
> > > [   30.543443]        __sys_setsockopt+0x73/0xc0
> > > [   30.543635]        __x64_sys_setsockopt+0x1a/0x30
> > > [   30.543859]        do_syscall_64+0xc9/0x1e0
> > > [   30.544057]        entry_SYSCALL_64_after_hwframe+0x6d/0x75
> > > [   30.544652]
> > > [   30.544652] -> #0 (sk_lock-AF_UNIX){+.+.}-{0:0}:
> > > [   30.544987]        check_prev_add+0xeb/0xa20
> > > [   30.545174]        __lock_acquire+0x12fb/0x1740
> > > [   30.545516]        lock_acquire+0xc0/0x2e0
> > > [   30.545692]        lock_sock_nested+0x2d/0x80
> > > [   30.545871]        __unix_dgram_recvmsg+0x37e/0x550
> > > [   30.546066]        sock_recvmsg+0xbf/0xd0
> > > [   30.546419]        ____sys_recvmsg+0x85/0x1d0
> > > [   30.546653]        ___sys_recvmsg+0x77/0xc0
> > > [   30.546971]        __sys_recvmsg+0x55/0xa0
> > > [   30.547149]        do_syscall_64+0xc9/0x1e0
> > > [   30.547428]        entry_SYSCALL_64_after_hwframe+0x6d/0x75
> > > [   30.547740]
> > > [   30.547740] other info that might help us debug this:
> > > [   30.547740]
> > > [   30.548217]  Possible unsafe locking scenario:
> > > [   30.548217]
> > > [   30.548502]        CPU0                    CPU1
> > > [   30.548713]        ----                    ----
> > > [   30.548926]   lock(&u->iolock);
> > > [   30.549234]                                lock(sk_lock-AF_UNIX);
> > > [   30.549535]                                lock(&u->iolock);
> > > [   30.549798]   lock(sk_lock-AF_UNIX);
> > > [   30.549970]
> > > [   30.549970]  *** DEADLOCK ***
> > > [   30.549970]
> > > [   30.550504] 1 lock held by poc/209:
> > > [   30.550681]  #0: ffff888007a8d070 (&u->iolock){+.+.}-{3:3}, at: __unix_dgram_recvmsg+0xec/0x550
> > > [   30.551100]
> > > [   30.551100] stack backtrace:
> > > [   30.551532] CPU: 1 PID: 209 Comm: poc Not tainted 6.9.0-rc1-00058-g4076fa161217-dirty #8
> > > [   30.551910] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
> > > [   30.552539] Call Trace:
> > > [   30.552788]  <TASK>
> > > [   30.552987]  dump_stack_lvl+0x68/0xa0
> > > [   30.553429]  check_noncircular+0x135/0x150
> > > [   30.553626]  check_prev_add+0xeb/0xa20
> > > [   30.553811]  __lock_acquire+0x12fb/0x1740
> > > [   30.553993]  lock_acquire+0xc0/0x2e0
> > > [   30.554234]  ? __unix_dgram_recvmsg+0x37e/0x550
> > > [   30.554543]  ? __skb_try_recv_datagram+0xb2/0x190
> > > [   30.554752]  lock_sock_nested+0x2d/0x80
> > > [   30.554912]  ? __unix_dgram_recvmsg+0x37e/0x550
> > > [   30.555097]  __unix_dgram_recvmsg+0x37e/0x550
> > > [   30.555498]  sock_recvmsg+0xbf/0xd0
> > > [   30.555661]  ____sys_recvmsg+0x85/0x1d0
> > > [   30.555826]  ? __import_iovec+0x177/0x1d0
> > > [   30.555998]  ? import_iovec+0x1a/0x20
> > > [   30.556401]  ? copy_msghdr_from_user+0x68/0xa0
> > > [   30.556676]  ___sys_recvmsg+0x77/0xc0
> > > [   30.556856]  ? __fget_files+0xc8/0x1a0
> > > [   30.557612]  ? lock_release+0xbd/0x290
> > > [   30.557799]  ? __fget_files+0xcd/0x1a0
> > > [   30.557969]  __sys_recvmsg+0x55/0xa0
> > > [   30.558284]  do_syscall_64+0xc9/0x1e0
> > > [   30.558455]  entry_SYSCALL_64_after_hwframe+0x6d/0x75
> > > [   30.558740] RIP: 0033:0x7f3c14632dad
> > > [   30.559329] Code: 28 89 54 24 1c 48 89 74 24 10 89 7c 24 08 e8 6a ef ff ff 8b 54 24 1c 48 8b 74 24 10 41 89 c0 8b 7c 24 08 b8 2f 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 33 44 89 c7 48 89 44 24 08 e8 9e ef f8
> > > [   30.560156] RSP: 002b:00007f3c12c43e60 EFLAGS: 00000293 ORIG_RAX: 000000000000002f
> > > [   30.560582] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f3c14632dad
> > > [   30.560933] RDX: 0000000000000000 RSI: 00007f3c12c44eb0 RDI: 0000000000000005
> > > [   30.562935] RBP: 00007f3c12c44ef0 R08: 0000000000000000 R09: 00007f3c12c45700
> > > [   30.565833] R10: fffffffffffff648 R11: 0000000000000293 R12: 00007ffe93a2bfde
> > > [   30.566161] R13: 00007ffe93a2bfdf R14: 00007f3c12c44fc0 R15: 0000000000802000
> > > [   30.569456]  </TASK>
> > >
> > >
> > >
> > >
> > > What are your thoughts on this?
> > 
> > You are talking about some unreleased code ?
> > 
> > I can not comment, obviously.
> 
> 
> 
> I think it would be prudent to patch __unix_dgram_recvmsg() as 
> depicted below to ensure its proper functionality, even 
> in the event of a later addition of mutex_lock in sk_setsockopt(). 
> 
> By implementing this patch, we mitigate the risk of potential deadlock scenarios 
> in the future by eliminating the condition that could lead to them.

It might mitigate your risk, but it does not exist upstream.

We don't accept such a patch that adds unnecessary locks just
for a future possible issue.  It should be fixed when such an
option requiring u->iolock is added.


> 
> ---
>  net/unix/af_unix.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> index 5b41e2321209..f102f08f649f 100644
> --- a/net/unix/af_unix.c
> +++ b/net/unix/af_unix.c
> @@ -2458,11 +2458,14 @@ int __unix_dgram_recvmsg(struct sock *sk, struct msghdr *msg, size_t size,
>                                                 EPOLLWRBAND);
>  
>         if (msg->msg_name) {
> +               mutex_unlock(&u->iolock);
> +
>                 unix_copy_addr(msg, skb->sk);
> -
> +
>                 BPF_CGROUP_RUN_PROG_UNIX_RECVMSG_LOCK(sk,
>                                                       msg->msg_name,
>                                                       &msg->msg_namelen);
> +               mutex_lock(&u->iolock);
>         }
>  
>         if (size > skb->len - skip)
> @@ -2814,6 +2817,8 @@ static int unix_stream_read_generic(struct unix_stream_read_state *state,
>  
>                 /* Copy address just once */
>                 if (state->msg && state->msg->msg_name) {
> +                       mutex_unlock(&u->iolock);
> +
>                         DECLARE_SOCKADDR(struct sockaddr_un *, sunaddr,
>                                          state->msg->msg_name);
>                         unix_copy_addr(state->msg, skb->sk);
> @@ -2823,6 +2828,8 @@ static int unix_stream_read_generic(struct unix_stream_read_state *state,
>                                                               &state->msg->msg_namelen);
>  
>                         sunaddr = NULL;
> +
> +                       mutex_lock(&u->iolock);
>                 }
>  
>                 chunk = min_t(unsigned int, unix_skb_len(skb) - skip, size);
> -- 
> 2.34.1


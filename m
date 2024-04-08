Return-Path: <netdev+bounces-85844-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CD3989C8A2
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 17:44:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB32CB21C55
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 15:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F65A1411FE;
	Mon,  8 Apr 2024 15:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JGi5tLrb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F3C140E29
	for <netdev@vger.kernel.org>; Mon,  8 Apr 2024 15:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712591043; cv=none; b=XI5w+rmJTLzg+L+Kosa15lhO4erXDaTYRL/FpUoWBitXqe8/ojhCMtnBg2m7QUz/0157sPr6CeKjVVri+4+QFzmO73BohAmpw8h2gxOQ7sKi++SfhtYIPM67nBOi5xX0VBI2GB7f6T/WsZgO8w78l2YWQ3+Ax5GHbAcbJbiBNUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712591043; c=relaxed/simple;
	bh=46EGW0jBdu0qZ2kQ+BhUiTCz55zN1V9///kLWlVvVRg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sJvLpnKobSgLXIKoIk5PKvUjhWaWT7xpO1n+lXWHO4XFKRqOW7uh37UxyK8YDyEPY7OyMBM0TRIa5ZadY1h7fmb4R+Gvgg8/LxiheBrL4dbrbRV39AZlyoK60Ic1VDhvDo7G6sjz76UuGgHx5I2ScMYBrc6ftDOWxb9WWe1L3eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JGi5tLrb; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6ed267f2936so995255b3a.3
        for <netdev@vger.kernel.org>; Mon, 08 Apr 2024 08:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712591040; x=1713195840; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V3eHh3ky8OeM1YFDUfBBqMWebgZajPqkv9mjoWfXcAM=;
        b=JGi5tLrbyDzc71kKNXQEdAAO3I5+lSZ4QhVz8r5+62AkUl4Q/YM+Opb4m6cAsN4//M
         fUeWiWyK8TC063F0b9H9Ry4FgRcA+LNYi3Iyuwit8Qi2vHokU+lRR6oCaIAeCfQ5jE8T
         2PnRL0YmOKYJ7DbwvaHuM4YT9kt8WCDgEhsPs/o6n2CFhFowRNW+V7K/UpSzfOm8GyiS
         P+2fkfRh1V3LgP2CkKMoIb8ftrrUXpknDwTpwLntjzKOhQc3mbKEwQ3+PSaixqQCPazQ
         CtxxjSC3YSgy7JtRmWVSS9brPWUdZ+xPeBjM6u8Sj2swaai0+qt2McSwQaI7s3Evy5I8
         hWfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712591040; x=1713195840;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V3eHh3ky8OeM1YFDUfBBqMWebgZajPqkv9mjoWfXcAM=;
        b=k7wXUd+ocL8zOYVygmq5frWRyS9LSTne5vu3XU4W5PQxfgr6bcH5R7tv43c2H3hdiu
         pbNkx+jKoPLShoPcU+IEx23wfMbTpE7dxiPGh5jFB3o7Q//v9GA+hJXK0eYIbQ2hyicM
         u4y8a6VCPFUtudheEChSQFtFtTBcuAZUlqMoozI/huyRkbVvoNsdWmFsDKhBUaivbOkq
         ihjRCQY3AFgQC2dMkxyLPC6s1Guqs2VbuMgBOnOivj4Auxn9m3mgTdlNbaWVplgcxBXE
         Qq5jpZrHLYAvT9oLJXfEaUHPcC6NM+QIWx1nPq1UPqxznwPzqQvkfmw1urwl3Fad7/gg
         Dspw==
X-Forwarded-Encrypted: i=1; AJvYcCUiOSYtfQfVGuzbImRrT8lq3wsKhs4mGSoPcPL8lnm6d213YC3DZf7GKjFa70rYT2oz1S68UuRw3bSfZDOfZRhOBtgKc2/8
X-Gm-Message-State: AOJu0YwCRSdSOu6IwPiMfL/P6Fnpi+Ody2x4dlFG7rDxAsnEEeLlkEzp
	vSJYS8nR8fVreEQShoHrkh4Rh/rE/WhGK5SVuAW7rGNBl54zb344
X-Google-Smtp-Source: AGHT+IHnjNDQWlfnZ5rv8uk9TsbcFTJAdQ0JBqviF5X/CEP3u6smu67S+MlqfqkJbTo3QtI5HmZM9w==
X-Received: by 2002:a05:6a00:3c8c:b0:6ec:ebf4:3e8a with SMTP id lm12-20020a056a003c8c00b006ecebf43e8amr10098053pfb.15.1712591040292;
        Mon, 08 Apr 2024 08:44:00 -0700 (PDT)
Received: from kernelexploit-virtual-machine.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id 3-20020a631843000000b005e485fbd455sm6704481pgy.45.2024.04.08.08.43.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 08:43:59 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: edumazet@google.com
Cc: aha310510@gmail.com,
	daan.j.demeyer@gmail.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	eric.dumazet@gmail.com,
	kuba@kernel.org,
	kuniyu@amazon.com,
	martin.lau@kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	willemdebruijn.kernel@gmail.com
Subject: Re: [PATCH net] net: implement lockless setsockopt(SO_PEEK_OFF)
Date: Tue,  9 Apr 2024 00:43:54 +0900
Message-Id: <20240408154354.164278-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CANn89iLzbwg+5sYzCCt7dWzZ0p94Sh-AYAMyLnGUzSeT7R8zAg@mail.gmail.com>
References: <CANn89iLzbwg+5sYzCCt7dWzZ0p94Sh-AYAMyLnGUzSeT7R8zAg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Eric Dumazet wrote:
> On Mon, Apr 8, 2024 at 4:30 PM Jeongjun Park <aha310510@gmail.com> wrote:
> >
> > Eric Dumazet wrote:
> > > syzbot reported a lockdep violation [1] involving af_unix
> > > support of SO_PEEK_OFF.
> > >
> > > Since SO_PEEK_OFF is inherently not thread safe (it uses a per-socket
> > > sk_peek_off field), there is really no point to enforce a pointless
> > > thread safety in the kernel.
> > >
> > > After this patch :
> > >
> > > - setsockopt(SO_PEEK_OFF) no longer acquires the socket lock.
> > >
> > > - skb_consume_udp() no longer has to acquire the socket lock.
> > >
> > > - af_unix no longer needs a special version of sk_set_peek_off(),
> > >   because it does not lock u->iolock anymore.
> >
> > The method employed in this patch, which avoids locking u->iolock in
> > SO_PEEK_OFF, appears to have effectively remedied the immediate vulnerability,
> > and the patch itself seems robust.
> >
> > However, if a future scenario arises where mutex_lock(&u->iolock) is required
> > after sk_setsockopt(sk), this patch would become ineffective.
> >
> > In practical testing within my environment, I observed that reintroducing
> > mutex_lock(&u->iolock) within sk_setsockopt() triggered the vulnerability once again.
> >
> > Therefore, I believe it's crucial to address the fundamental cause triggering this vulnerability
> > alongside the current patch.
> >
> > [   30.537400] ======================================================
> > [   30.537765] WARNING: possible circular locking dependency detected
> > [   30.538237] 6.9.0-rc1-00058-g4076fa161217-dirty #8 Not tainted
> > [   30.538541] ------------------------------------------------------
> > [   30.538791] poc/209 is trying to acquire lock:
> > [   30.539008] ffff888007a8cd58 (sk_lock-AF_UNIX){+.+.}-{0:0}, at: __unix_dgram_recvmsg+0x37e/0x550
> > [   30.540060]
> > [   30.540060] but task is already holding lock:
> > [   30.540482] ffff888007a8d070 (&u->iolock){+.+.}-{3:3}, at: __unix_dgram_recvmsg+0xec/0x550
> > [   30.540871]
> > [   30.540871] which lock already depends on the new lock.
> > [   30.540871]
> > [   30.541341]
> > [   30.541341] the existing dependency chain (in reverse order) is:
> > [   30.541816]
> > [   30.541816] -> #1 (&u->iolock){+.+.}-{3:3}:
> > [   30.542411]        lock_acquire+0xc0/0x2e0
> > [   30.542650]        __mutex_lock+0x91/0x4b0
> > [   30.542830]        sk_setsockopt+0xae2/0x1510
> > [   30.543009]        do_sock_setsockopt+0x14e/0x180
> > [   30.543443]        __sys_setsockopt+0x73/0xc0
> > [   30.543635]        __x64_sys_setsockopt+0x1a/0x30
> > [   30.543859]        do_syscall_64+0xc9/0x1e0
> > [   30.544057]        entry_SYSCALL_64_after_hwframe+0x6d/0x75
> > [   30.544652]
> > [   30.544652] -> #0 (sk_lock-AF_UNIX){+.+.}-{0:0}:
> > [   30.544987]        check_prev_add+0xeb/0xa20
> > [   30.545174]        __lock_acquire+0x12fb/0x1740
> > [   30.545516]        lock_acquire+0xc0/0x2e0
> > [   30.545692]        lock_sock_nested+0x2d/0x80
> > [   30.545871]        __unix_dgram_recvmsg+0x37e/0x550
> > [   30.546066]        sock_recvmsg+0xbf/0xd0
> > [   30.546419]        ____sys_recvmsg+0x85/0x1d0
> > [   30.546653]        ___sys_recvmsg+0x77/0xc0
> > [   30.546971]        __sys_recvmsg+0x55/0xa0
> > [   30.547149]        do_syscall_64+0xc9/0x1e0
> > [   30.547428]        entry_SYSCALL_64_after_hwframe+0x6d/0x75
> > [   30.547740]
> > [   30.547740] other info that might help us debug this:
> > [   30.547740]
> > [   30.548217]  Possible unsafe locking scenario:
> > [   30.548217]
> > [   30.548502]        CPU0                    CPU1
> > [   30.548713]        ----                    ----
> > [   30.548926]   lock(&u->iolock);
> > [   30.549234]                                lock(sk_lock-AF_UNIX);
> > [   30.549535]                                lock(&u->iolock);
> > [   30.549798]   lock(sk_lock-AF_UNIX);
> > [   30.549970]
> > [   30.549970]  *** DEADLOCK ***
> > [   30.549970]
> > [   30.550504] 1 lock held by poc/209:
> > [   30.550681]  #0: ffff888007a8d070 (&u->iolock){+.+.}-{3:3}, at: __unix_dgram_recvmsg+0xec/0x550
> > [   30.551100]
> > [   30.551100] stack backtrace:
> > [   30.551532] CPU: 1 PID: 209 Comm: poc Not tainted 6.9.0-rc1-00058-g4076fa161217-dirty #8
> > [   30.551910] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
> > [   30.552539] Call Trace:
> > [   30.552788]  <TASK>
> > [   30.552987]  dump_stack_lvl+0x68/0xa0
> > [   30.553429]  check_noncircular+0x135/0x150
> > [   30.553626]  check_prev_add+0xeb/0xa20
> > [   30.553811]  __lock_acquire+0x12fb/0x1740
> > [   30.553993]  lock_acquire+0xc0/0x2e0
> > [   30.554234]  ? __unix_dgram_recvmsg+0x37e/0x550
> > [   30.554543]  ? __skb_try_recv_datagram+0xb2/0x190
> > [   30.554752]  lock_sock_nested+0x2d/0x80
> > [   30.554912]  ? __unix_dgram_recvmsg+0x37e/0x550
> > [   30.555097]  __unix_dgram_recvmsg+0x37e/0x550
> > [   30.555498]  sock_recvmsg+0xbf/0xd0
> > [   30.555661]  ____sys_recvmsg+0x85/0x1d0
> > [   30.555826]  ? __import_iovec+0x177/0x1d0
> > [   30.555998]  ? import_iovec+0x1a/0x20
> > [   30.556401]  ? copy_msghdr_from_user+0x68/0xa0
> > [   30.556676]  ___sys_recvmsg+0x77/0xc0
> > [   30.556856]  ? __fget_files+0xc8/0x1a0
> > [   30.557612]  ? lock_release+0xbd/0x290
> > [   30.557799]  ? __fget_files+0xcd/0x1a0
> > [   30.557969]  __sys_recvmsg+0x55/0xa0
> > [   30.558284]  do_syscall_64+0xc9/0x1e0
> > [   30.558455]  entry_SYSCALL_64_after_hwframe+0x6d/0x75
> > [   30.558740] RIP: 0033:0x7f3c14632dad
> > [   30.559329] Code: 28 89 54 24 1c 48 89 74 24 10 89 7c 24 08 e8 6a ef ff ff 8b 54 24 1c 48 8b 74 24 10 41 89 c0 8b 7c 24 08 b8 2f 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 33 44 89 c7 48 89 44 24 08 e8 9e ef f8
> > [   30.560156] RSP: 002b:00007f3c12c43e60 EFLAGS: 00000293 ORIG_RAX: 000000000000002f
> > [   30.560582] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f3c14632dad
> > [   30.560933] RDX: 0000000000000000 RSI: 00007f3c12c44eb0 RDI: 0000000000000005
> > [   30.562935] RBP: 00007f3c12c44ef0 R08: 0000000000000000 R09: 00007f3c12c45700
> > [   30.565833] R10: fffffffffffff648 R11: 0000000000000293 R12: 00007ffe93a2bfde
> > [   30.566161] R13: 00007ffe93a2bfdf R14: 00007f3c12c44fc0 R15: 0000000000802000
> > [   30.569456]  </TASK>
> >
> >
> >
> >
> > What are your thoughts on this?
> 
> You are talking about some unreleased code ?
> 
> I can not comment, obviously.



I think it would be prudent to patch __unix_dgram_recvmsg() as 
depicted below to ensure its proper functionality, even 
in the event of a later addition of mutex_lock in sk_setsockopt(). 

By implementing this patch, we mitigate the risk of potential deadlock scenarios 
in the future by eliminating the condition that could lead to them.



---
 net/unix/af_unix.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 5b41e2321209..f102f08f649f 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -2458,11 +2458,14 @@ int __unix_dgram_recvmsg(struct sock *sk, struct msghdr *msg, size_t size,
                                                EPOLLWRBAND);
 
        if (msg->msg_name) {
+               mutex_unlock(&u->iolock);
+
                unix_copy_addr(msg, skb->sk);
-
+
                BPF_CGROUP_RUN_PROG_UNIX_RECVMSG_LOCK(sk,
                                                      msg->msg_name,
                                                      &msg->msg_namelen);
+               mutex_lock(&u->iolock);
        }
 
        if (size > skb->len - skip)
@@ -2814,6 +2817,8 @@ static int unix_stream_read_generic(struct unix_stream_read_state *state,
 
                /* Copy address just once */
                if (state->msg && state->msg->msg_name) {
+                       mutex_unlock(&u->iolock);
+
                        DECLARE_SOCKADDR(struct sockaddr_un *, sunaddr,
                                         state->msg->msg_name);
                        unix_copy_addr(state->msg, skb->sk);
@@ -2823,6 +2828,8 @@ static int unix_stream_read_generic(struct unix_stream_read_state *state,
                                                              &state->msg->msg_namelen);
 
                        sunaddr = NULL;
+
+                       mutex_lock(&u->iolock);
                }
 
                chunk = min_t(unsigned int, unix_skb_len(skb) - skip, size);
-- 
2.34.1




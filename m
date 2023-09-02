Return-Path: <netdev+bounces-31810-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA7D579054F
	for <lists+netdev@lfdr.de>; Sat,  2 Sep 2023 07:46:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E46602819B5
	for <lists+netdev@lfdr.de>; Sat,  2 Sep 2023 05:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E03961FA0;
	Sat,  2 Sep 2023 05:46:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC931C2B
	for <netdev@vger.kernel.org>; Sat,  2 Sep 2023 05:46:01 +0000 (UTC)
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id B97B492
	for <netdev@vger.kernel.org>; Fri,  1 Sep 2023 22:45:58 -0700 (PDT)
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 3825jMGP023000;
	Sat, 2 Sep 2023 07:45:22 +0200
Date: Sat, 2 Sep 2023 07:45:22 +0200
From: Willy Tarreau <w@1wt.eu>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org,
        syzkaller <syzkaller@googlegroups.com>
Subject: Re: [PATCH v1 net 1/4] af_unix: Fix data-races around
 user->unix_inflight.
Message-ID: <20230902054522.GA22948@1wt.eu>
References: <20230902002708.91816-1-kuniyu@amazon.com>
 <20230902002708.91816-2-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230902002708.91816-2-kuniyu@amazon.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

On Fri, Sep 01, 2023 at 05:27:05PM -0700, Kuniyuki Iwashima wrote:
> user->unix_inflight is changed under spin_lock(unix_gc_lock),
> but too_many_unix_fds() reads it locklessly.
> 
> Let's annotate the write/read accesses to user->unix_inflight.
> 
> BUG: KCSAN: data-race in unix_attach_fds / unix_inflight
> 
> write to 0xffffffff8546f2d0 of 8 bytes by task 44798 on cpu 1:
>  unix_inflight+0x157/0x180 net/unix/scm.c:66
>  unix_attach_fds+0x147/0x1e0 net/unix/scm.c:123
>  unix_scm_to_skb net/unix/af_unix.c:1827 [inline]
>  unix_dgram_sendmsg+0x46a/0x14f0 net/unix/af_unix.c:1950
>  unix_seqpacket_sendmsg net/unix/af_unix.c:2308 [inline]
>  unix_seqpacket_sendmsg+0xba/0x130 net/unix/af_unix.c:2292
>  sock_sendmsg_nosec net/socket.c:725 [inline]
>  sock_sendmsg+0x148/0x160 net/socket.c:748
>  ____sys_sendmsg+0x4e4/0x610 net/socket.c:2494
>  ___sys_sendmsg+0xc6/0x140 net/socket.c:2548
>  __sys_sendmsg+0x94/0x140 net/socket.c:2577
>  __do_sys_sendmsg net/socket.c:2586 [inline]
>  __se_sys_sendmsg net/socket.c:2584 [inline]
>  __x64_sys_sendmsg+0x45/0x50 net/socket.c:2584
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x3b/0x90 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> 
> read to 0xffffffff8546f2d0 of 8 bytes by task 44814 on cpu 0:
>  too_many_unix_fds net/unix/scm.c:101 [inline]
>  unix_attach_fds+0x54/0x1e0 net/unix/scm.c:110
>  unix_scm_to_skb net/unix/af_unix.c:1827 [inline]
>  unix_dgram_sendmsg+0x46a/0x14f0 net/unix/af_unix.c:1950
>  unix_seqpacket_sendmsg net/unix/af_unix.c:2308 [inline]
>  unix_seqpacket_sendmsg+0xba/0x130 net/unix/af_unix.c:2292
>  sock_sendmsg_nosec net/socket.c:725 [inline]
>  sock_sendmsg+0x148/0x160 net/socket.c:748
>  ____sys_sendmsg+0x4e4/0x610 net/socket.c:2494
>  ___sys_sendmsg+0xc6/0x140 net/socket.c:2548
>  __sys_sendmsg+0x94/0x140 net/socket.c:2577
>  __do_sys_sendmsg net/socket.c:2586 [inline]
>  __se_sys_sendmsg net/socket.c:2584 [inline]
>  __x64_sys_sendmsg+0x45/0x50 net/socket.c:2584
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x3b/0x90 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> 
> value changed: 0x000000000000000c -> 0x000000000000000d
> 
> Reported by Kernel Concurrency Sanitizer on:
> CPU: 0 PID: 44814 Comm: systemd-coredum Not tainted 6.4.0-11989-g6843306689af #6
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
> 
> Fixes: 712f4aad406b ("unix: properly account for FDs passed over unix sockets")
> Reported-by: syzkaller <syzkaller@googlegroups.com>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---
> Cc: Willy Tarreau <w@1wt.eu>
> ---
>  net/unix/scm.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/net/unix/scm.c b/net/unix/scm.c
> index e9dde7176c8a..6ff628f2349f 100644
> --- a/net/unix/scm.c
> +++ b/net/unix/scm.c
> @@ -64,7 +64,7 @@ void unix_inflight(struct user_struct *user, struct file *fp)
>  		/* Paired with READ_ONCE() in wait_for_unix_gc() */
>  		WRITE_ONCE(unix_tot_inflight, unix_tot_inflight + 1);
>  	}
> -	user->unix_inflight++;
> +	WRITE_ONCE(user->unix_inflight, user->unix_inflight + 1);
>  	spin_unlock(&unix_gc_lock);
>  }
>  
> @@ -85,7 +85,7 @@ void unix_notinflight(struct user_struct *user, struct file *fp)
>  		/* Paired with READ_ONCE() in wait_for_unix_gc() */
>  		WRITE_ONCE(unix_tot_inflight, unix_tot_inflight - 1);
>  	}
> -	user->unix_inflight--;
> +	WRITE_ONCE(user->unix_inflight, user->unix_inflight - 1);
>  	spin_unlock(&unix_gc_lock);
>  }
>  
> @@ -99,7 +99,7 @@ static inline bool too_many_unix_fds(struct task_struct *p)
>  {
>  	struct user_struct *user = current_user();
>  
> -	if (unlikely(user->unix_inflight > task_rlimit(p, RLIMIT_NOFILE)))
> +	if (unlikely(READ_ONCE(user->unix_inflight) > task_rlimit(p, RLIMIT_NOFILE)))
>  		return !capable(CAP_SYS_RESOURCE) && !capable(CAP_SYS_ADMIN);
>  	return false;
>  }

Looks good to me, thanks!
Acked-by: Willy Tarreau <w@1wt.eu>

Willy


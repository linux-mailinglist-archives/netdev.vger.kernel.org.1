Return-Path: <netdev+bounces-90896-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50AEB8B0A6D
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 15:08:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06680285335
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 13:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D45D15B143;
	Wed, 24 Apr 2024 13:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="ogKeApR9"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B6315B12E
	for <netdev@vger.kernel.org>; Wed, 24 Apr 2024 13:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713964107; cv=none; b=CVS7xEUptg1Fal51XzRZGUOKDwEIGcBk0FfpO0yFyOMsWkgvEQGCPeE98nOpAeTvtQj+JBEkXSJ0RfsM1uf1Gt5ngJfNifo7XYhdnWhunFX9NP7GkifmNECCM6JvaEams2D+cUR1R5WNORao5qXa8gL+utrFSVBuk2dl9HKToqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713964107; c=relaxed/simple;
	bh=8exFwnWwBkq9D2s3JIYPo9yArOXWdLtt4Blm8aATLA4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kmrjPc/boLCUtZB+laIsc2dQyMMQRvY5EBXRmowEVMYl0bPP8YXw6wIzBlBpuzUGbc7PELjeq4doHqhHLRER+uYW9WEbZbCL6OhvQdtW/JA++Y58NuW4ekAk9WzslX5Q1/mt60LIIa/nhijCWMhtLL5xglhVgWUm/ShqeOVm6SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=ogKeApR9; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1rzbqN-001Yy2-4N; Wed, 24 Apr 2024 14:35:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=5xUpOldW4Qd+dkl/NDbdgefrLYfEHOHUgmNqCH3ulm0=; b=ogKeApR9b2ACf+wqurnv/nmJ0J
	Pwl+LulUzWyYo2FcZvHTFF95V3h7WOwdP8g2R1tw2Cr0suwfhrRknS7Zqu46TJjXWnCvSI0sqQj7Z
	mocukupD0qBwZsdqZPRyuoWeVmH0bbhB6nPeTsUgQSqmOhuPcxQqcq9NZPk0bbtrHl26Rf5mXp5mO
	RJ0I9yFpI/MOktQAiwAW1Mf0HW9Lg5y5Nb6IiQATz/KmUKcLPxnKKiGDvaWc90t0B6qFeWawTQpAJ
	f9MjqgK1aEdalANQ04mx8tmsLiAU84/OQ1GjxFe6uUOrWXn/JarLIBxBsWe5yYgL2kAysm0OXumcu
	BMj4GR6g==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1rzbqM-000115-8l; Wed, 24 Apr 2024 14:35:22 +0200
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1rzbqL-008irf-3Z; Wed, 24 Apr 2024 14:35:21 +0200
Message-ID: <84d3a101-d961-4db3-acc2-23bc8bdc1fd9@rbox.co>
Date: Wed, 24 Apr 2024 14:35:19 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net] af_unix: Suppress false-positive lockdep splat for
 spin_lock() in __unix_gc().
To: Kuniyuki Iwashima <kuniyu@amazon.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org,
 syzbot+fa379358c28cc87cc307@syzkaller.appspotmail.com
References: <20240424022319.20574-1-kuniyu@amazon.com>
Content-Language: pl-PL, en-GB
From: Michal Luczaj <mhal@rbox.co>
In-Reply-To: <20240424022319.20574-1-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/24/24 04:23, Kuniyuki Iwashima wrote:
> syzbot reported a lockdep splat regarding unix_gc_lock() and
> unix_state_lock().

Just a nit: probably unix_gc_lock, without brackets?

Thanks!
Michal

> One is called from recvmsg() for a connected socket, and another
> is called from GC for TCP_LISTEN socket.
> 
> So, the splat is false-positive.
> 
> Let's add a dedicated lock class for the latter to suppress the splat.
> 
> Note that this change is not necessary for net-next.git as the issue
> is only applied to the old GC impl.
> 
> [0]:
> WARNING: possible circular locking dependency detected
> 6.9.0-rc5-syzkaller-00007-g4d2008430ce8 #0 Not tainted
>  -----------------------------------------------------
> kworker/u8:1/11 is trying to acquire lock:
> ffff88807cea4e70 (&u->lock){+.+.}-{2:2}, at: spin_lock include/linux/spinlock.h:351 [inline]
> ffff88807cea4e70 (&u->lock){+.+.}-{2:2}, at: __unix_gc+0x40e/0xf70 net/unix/garbage.c:302
> 
> but task is already holding lock:
> ffffffff8f6ab638 (unix_gc_lock){+.+.}-{2:2}, at: spin_lock include/linux/spinlock.h:351 [inline]
> ffffffff8f6ab638 (unix_gc_lock){+.+.}-{2:2}, at: __unix_gc+0x117/0xf70 net/unix/garbage.c:261
> 
> which lock already depends on the new lock.
> 
> the existing dependency chain (in reverse order) is:
> 
>  -> #1 (unix_gc_lock){+.+.}-{2:2}:
>        lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
>        __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
>        _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
>        spin_lock include/linux/spinlock.h:351 [inline]
>        unix_notinflight+0x13d/0x390 net/unix/garbage.c:140
>        unix_detach_fds net/unix/af_unix.c:1819 [inline]
>        unix_destruct_scm+0x221/0x350 net/unix/af_unix.c:1876
>        skb_release_head_state+0x100/0x250 net/core/skbuff.c:1188
>        skb_release_all net/core/skbuff.c:1200 [inline]
>        __kfree_skb net/core/skbuff.c:1216 [inline]
>        kfree_skb_reason+0x16d/0x3b0 net/core/skbuff.c:1252
>        kfree_skb include/linux/skbuff.h:1262 [inline]
>        manage_oob net/unix/af_unix.c:2672 [inline]
>        unix_stream_read_generic+0x1125/0x2700 net/unix/af_unix.c:2749
>        unix_stream_splice_read+0x239/0x320 net/unix/af_unix.c:2981
>        do_splice_read fs/splice.c:985 [inline]
>        splice_file_to_pipe+0x299/0x500 fs/splice.c:1295
>        do_splice+0xf2d/0x1880 fs/splice.c:1379
>        __do_splice fs/splice.c:1436 [inline]
>        __do_sys_splice fs/splice.c:1652 [inline]
>        __se_sys_splice+0x331/0x4a0 fs/splice.c:1634
>        do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>        do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
>        entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
>  -> #0 (&u->lock){+.+.}-{2:2}:
>        check_prev_add kernel/locking/lockdep.c:3134 [inline]
>        check_prevs_add kernel/locking/lockdep.c:3253 [inline]
>        validate_chain+0x18cb/0x58e0 kernel/locking/lockdep.c:3869
>        __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
>        lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
>        __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
>        _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
>        spin_lock include/linux/spinlock.h:351 [inline]
>        __unix_gc+0x40e/0xf70 net/unix/garbage.c:302
>        process_one_work kernel/workqueue.c:3254 [inline]
>        process_scheduled_works+0xa10/0x17c0 kernel/workqueue.c:3335
>        worker_thread+0x86d/0xd70 kernel/workqueue.c:3416
>        kthread+0x2f0/0x390 kernel/kthread.c:388
>        ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
>        ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
> 
> other info that might help us debug this:
> 
>  Possible unsafe locking scenario:
> 
>        CPU0                    CPU1
>        ----                    ----
>   lock(unix_gc_lock);
>                                lock(&u->lock);
>                                lock(unix_gc_lock);
>   lock(&u->lock);
> 
>  *** DEADLOCK ***
> 
> 3 locks held by kworker/u8:1/11:
>  #0: ffff888015089148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3229 [inline]
>  #0: ffff888015089148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_scheduled_works+0x8e0/0x17c0 kernel/workqueue.c:3335
>  #1: ffffc90000107d00 (unix_gc_work){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3230 [inline]
>  #1: ffffc90000107d00 (unix_gc_work){+.+.}-{0:0}, at: process_scheduled_works+0x91b/0x17c0 kernel/workqueue.c:3335
>  #2: ffffffff8f6ab638 (unix_gc_lock){+.+.}-{2:2}, at: spin_lock include/linux/spinlock.h:351 [inline]
>  #2: ffffffff8f6ab638 (unix_gc_lock){+.+.}-{2:2}, at: __unix_gc+0x117/0xf70 net/unix/garbage.c:261
> 
> stack backtrace:
> CPU: 0 PID: 11 Comm: kworker/u8:1 Not tainted 6.9.0-rc5-syzkaller-00007-g4d2008430ce8 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
> Workqueue: events_unbound __unix_gc
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
>  check_noncircular+0x36a/0x4a0 kernel/locking/lockdep.c:2187
>  check_prev_add kernel/locking/lockdep.c:3134 [inline]
>  check_prevs_add kernel/locking/lockdep.c:3253 [inline]
>  validate_chain+0x18cb/0x58e0 kernel/locking/lockdep.c:3869
>  __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
>  lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
>  __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
>  _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
>  spin_lock include/linux/spinlock.h:351 [inline]
>  __unix_gc+0x40e/0xf70 net/unix/garbage.c:302
>  process_one_work kernel/workqueue.c:3254 [inline]
>  process_scheduled_works+0xa10/0x17c0 kernel/workqueue.c:3335
>  worker_thread+0x86d/0xd70 kernel/workqueue.c:3416
>  kthread+0x2f0/0x390 kernel/kthread.c:388
>  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
>  </TASK>
> 
> Fixes: 47d8ac011fe1 ("af_unix: Fix garbage collector racing against connect()")
> Reported-and-tested-by: syzbot+fa379358c28cc87cc307@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=fa379358c28cc87cc307
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---
>  include/net/af_unix.h | 3 +++
>  net/unix/garbage.c    | 2 +-
>  2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/include/net/af_unix.h b/include/net/af_unix.h
> index 627ea8e2d915..3dee0b2721aa 100644
> --- a/include/net/af_unix.h
> +++ b/include/net/af_unix.h
> @@ -85,6 +85,9 @@ enum unix_socket_lock_class {
>  	U_LOCK_NORMAL,
>  	U_LOCK_SECOND,	/* for double locking, see unix_state_double_lock(). */
>  	U_LOCK_DIAG, /* used while dumping icons, see sk_diag_dump_icons(). */
> +	U_LOCK_GC_LISTENER, /* used for listening socket while determining gc
> +			     * candidates to close a small race window.
> +			     */
>  };
>  
>  static inline void unix_state_lock_nested(struct sock *sk,
> diff --git a/net/unix/garbage.c b/net/unix/garbage.c
> index 6433a414acf8..0104be9d4704 100644
> --- a/net/unix/garbage.c
> +++ b/net/unix/garbage.c
> @@ -299,7 +299,7 @@ static void __unix_gc(struct work_struct *work)
>  			__set_bit(UNIX_GC_MAYBE_CYCLE, &u->gc_flags);
>  
>  			if (sk->sk_state == TCP_LISTEN) {
> -				unix_state_lock(sk);
> +				unix_state_lock_nested(sk, U_LOCK_GC_LISTENER);
>  				unix_state_unlock(sk);
>  			}
>  		}



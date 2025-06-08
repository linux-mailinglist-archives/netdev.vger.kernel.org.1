Return-Path: <netdev+bounces-195556-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A002AD127E
	for <lists+netdev@lfdr.de>; Sun,  8 Jun 2025 16:01:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 275BB3AA6A1
	for <lists+netdev@lfdr.de>; Sun,  8 Jun 2025 14:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72988212B14;
	Sun,  8 Jun 2025 14:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=posteo.net header.i=@posteo.net header.b="XTvBtjVq"
X-Original-To: netdev@vger.kernel.org
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458872110
	for <netdev@vger.kernel.org>; Sun,  8 Jun 2025 14:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749391268; cv=none; b=TRI2EgFtDTS+/pODXUvwEE65okjEpLmlbTppnj2Hy90rGyegJ2BANQKMlnIdMv9AuTD6ffZiXxu4C+vkbBVQMX3vGbLY/VhWwBsSIpyjtmPaHbimNB5GUTfaBhCeskU8DwtsGpLPhAR1DTuXZXxJMgMa4LrJ7k/Vy9uT5wDXMJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749391268; c=relaxed/simple;
	bh=zWq7GeNVsUbeOL4wrPXhSy7AkfPOsfEydTsOqxkcx9c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Jglbo5CiRj1zQq4f0ZRT2qPWf9QygVw4xyBxPQ6WIUu5jynPFh4+0BTc9IhCDm6VotYvKo24QzXXwB86YZ21HRwINDEOj7gEKjMxzYlXA7OEx94GxXc5CEjTKk08PQqxjY2HdwB5g5ULJlUNSS1cHI0p+jPjBEnMVxuS10knvAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (3072-bit key) header.d=posteo.net header.i=@posteo.net header.b=XTvBtjVq; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 9B64E240028
	for <netdev@vger.kernel.org>; Sun,  8 Jun 2025 16:00:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net;
	s=1984.ea087b; t=1749391258;
	bh=zWq7GeNVsUbeOL4wrPXhSy7AkfPOsfEydTsOqxkcx9c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 From;
	b=XTvBtjVqVvXOa0+G2hfHmSE4V2YNuJiAzjoE2uw9NKEBJgcl0zPhlKu564h5MHiF8
	 eFQB829mjNWWai84uIKdwV+JvacBMXgfX0QV5fNhxMmT3YOP/xYpUN2lxw1LkRjYCZ
	 uDr9KeShURTe0os80Pkyt+97RDhjPjRyuAsWd+mz3jHHkFEjTBARzy4dOBl5Sul3bh
	 Y0rPuw8DCWk3ijICTnJ36lEhGKUprNjG7oac0ghTzlQrvBZbXQ065iBZ6gT8dMc5IQ
	 68kRQpsIVjfoOit/XqWeTjzgk4t9HVvzKtuOAi0eOesj+vGOFGgq5KnDAuBNtk23CX
	 Umzj5mJlRn6xpDzlpCClJrWv/jTqR6GwMlcnuhtNMht9qwNLc0zNsnK6CeD6VRQrcs
	 zgqmshkRQ4zzlzNEFotPvYRCRmD+uXnZxSS2sXFJ8q0VAJ+3K7pEZbQkdP46UsdWSt
	 IoElH6HtDzgw8lrEvM5Ydext69LfVYqHOhBI9FyWrH19CpzKwtQ
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4bFcCX537sz9rxF;
	Sun,  8 Jun 2025 16:00:55 +0200 (CEST)
From: Charalampos Mitrodimas <charmitro@posteo.net>
To: syzbot <syzbot+b4169a1cfb945d2ed0ec@syzkaller.appspotmail.com>
Cc: andrii@kernel.org,  davem@davemloft.net,  edumazet@google.com,
  horms@kernel.org,  kuba@kernel.org,  linux-kernel@vger.kernel.org,
  netdev@vger.kernel.org,  pabeni@redhat.com,
  syzkaller-bugs@googlegroups.com,  tj@kernel.org,  yangfeng@kylinos.cn
Subject: Re: [syzbot] [net?] WARNING: suspicious RCU usage in task_cls_state
In-Reply-To: <683428c7.a70a0220.29d4a0.0800.GAE@google.com>
References: <683428c7.a70a0220.29d4a0.0800.GAE@google.com>
Date: Sun, 08 Jun 2025 14:00:38 +0000
Message-ID: <87frgafi49.fsf@posteo.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

syzbot <syzbot+b4169a1cfb945d2ed0ec@syzkaller.appspotmail.com> writes:

> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    079e5c56a5c4 bpf: Fix error return value in bpf_copy_from_..
> git tree:       bpf-next
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=178ae170580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=c6c517d2f439239
> dashboard link: https://syzkaller.appspot.com/bug?extid=b4169a1cfb945d2ed0ec
> compiler:       Debian clang version 20.1.6 (++20250514063057+1e4d39e07757-1~exp1~20250514183223.118), Debian LLD 20.1.6
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13bc35f4580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15f195f4580000
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/8d7d35d067bc/disk-079e5c56.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/74d2648ea7f4/vmlinux-079e5c56.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/e751e253ee4f/bzImage-079e5c56.xz
>
> The issue was bisected to:
>
> commit ee971630f20fd421fffcdc4543731ebcb54ed6d0
> Author: Feng Yang <yangfeng@kylinos.cn>
> Date:   Tue May 6 06:14:33 2025 +0000
>
>     bpf: Allow some trace helpers for all prog types
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14cd68e8580000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=16cd68e8580000
> console output: https://syzkaller.appspot.com/x/log.txt?x=12cd68e8580000
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+b4169a1cfb945d2ed0ec@syzkaller.appspotmail.com
> Fixes: ee971630f20f ("bpf: Allow some trace helpers for all prog types")
>
> =============================
> WARNING: suspicious RCU usage
> 6.15.0-rc4-syzkaller-g079e5c56a5c4 #0 Not tainted
> -----------------------------
> net/core/netclassid_cgroup.c:24 suspicious rcu_dereference_check() usage!
>
> other info that might help us debug this:
>
>
> rcu_scheduler_active = 2, debug_locks = 1
> 1 lock held by syz-executor296/5833:
>  #0: ffffffff8df3ba40 (rcu_read_lock_trace){....}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
>  #0: ffffffff8df3ba40 (rcu_read_lock_trace){....}-{0:0}, at: rcu_read_lock_trace+0x38/0x80 include/linux/rcupdate_trace.h:58
>
> stack backtrace:
> CPU: 0 UID: 0 PID: 5833 Comm: syz-executor296 Not tainted 6.15.0-rc4-syzkaller-g079e5c56a5c4 #0 PREEMPT(full) 
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
>  lockdep_rcu_suspicious+0x140/0x1d0 kernel/locking/lockdep.c:6865
>  task_cls_state+0x1a5/0x1d0 net/core/netclassid_cgroup.c:23
>  __task_get_classid include/net/cls_cgroup.h:50 [inline]
>  ____bpf_get_cgroup_classid_curr net/core/filter.c:3086 [inline]
>  bpf_get_cgroup_classid_curr+0x18/0x60 net/core/filter.c:3084
>  bpf_prog_83da9cb0e78d4768+0x2c/0x5a
>  bpf_dispatcher_nop_func include/linux/bpf.h:1322 [inline]
>  __bpf_prog_run include/linux/filter.h:718 [inline]
>  bpf_prog_run include/linux/filter.h:725 [inline]
>  bpf_prog_run_pin_on_cpu+0x67/0x150 include/linux/filter.h:742
>  bpf_prog_test_run_syscall+0x312/0x4b0 net/bpf/test_run.c:1564
>  bpf_prog_test_run+0x2a9/0x340 kernel/bpf/syscall.c:4429
>  __sys_bpf+0x4a4/0x860 kernel/bpf/syscall.c:5854
>  __do_sys_bpf kernel/bpf/syscall.c:5943 [inline]
>  __se_sys_bpf kernel/bpf/syscall.c:5941 [inline]
>  __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5941
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xf6/0x210 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7fda75b18a69
> Code: d8 5b c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffdd0546d48 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fda75b18a69
> RDX: 0000000000000048 RSI: 0000200000000500 RDI: 000000000000000a
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection
>
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
>
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.

#syz test: https://github.com/charmitro/linux.git e5c42d49bfb967c3c35f536971f397492d2f46bf


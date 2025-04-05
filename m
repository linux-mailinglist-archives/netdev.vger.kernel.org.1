Return-Path: <netdev+bounces-179413-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34D8CA7C74A
	for <lists+netdev@lfdr.de>; Sat,  5 Apr 2025 03:52:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB00217A11B
	for <lists+netdev@lfdr.de>; Sat,  5 Apr 2025 01:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B2A618EB0;
	Sat,  5 Apr 2025 01:52:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D33618B0F
	for <netdev@vger.kernel.org>; Sat,  5 Apr 2025 01:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743817946; cv=none; b=qyrO/aPe9AojtduqN9f8+LYfWfl+IXdm2A+JGbtTJ204FgfV2C2FU7JMiLSvIoisxNpWbJyv18ghmoJXotZezZxJLQvHw0wyuZaj/P2Noy5S97jm5rTuSLxLM6C1yNkNEfnUv/A04au/SO2HefBv3Oh3UnSr4KU2HsKU/YRigrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743817946; c=relaxed/simple;
	bh=Dtod8DZ7V8khq16mweI5CRWWsY2J2/EWu6YusiiwwQo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ZhgpAQ4G+daJx+gu5nJwA0DgEJj9rLl+m4uRTUxyIzNw0h/7djaaHD7Yixv0Q0/Q8PbI94LAqCHdiNbAa8JFn1dBYU/zZ8yjpdEeLRsNrdfyL3TPcACPToa7A5MqlcgEBLTC37YD/jnzP976SSjKbG1mQ+n7rLMLgBEIbAVKKXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3d5b381656dso59107255ab.2
        for <netdev@vger.kernel.org>; Fri, 04 Apr 2025 18:52:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743817943; x=1744422743;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6nCJrw6qAEnDPjaAhoB/Zn3Anwy2j3VO4X4vlAKVz7c=;
        b=xLJFnpLustT1X717TVQWdgyxLhHt9Bv2Ywa+XI5oiL+KCNiaY5KWRT79XDrwWV2X/1
         s6GtcLsv54X5L001KxPvHq4QBJ9hyeQc3UOu18B/x23AKBfsApF5OhtxeyqhLRTdYdck
         ikrpz7IpAOvSmZdrfCsGBRAwfJZ94EJ9c1KT+YAn0l3vNRzjJzFNfj82oGYPv8Ix+/bE
         g57z8rNRo7bdrYTuWJtNMDZdltCfMbszCSvZGwPfG98pMG2YIZci8xdnXYIFF638+cte
         wPlbaKyfpmzJS0w4EH3gb773B2WZMbvt7CxWGSuv1kiEQd0icPfFTh+Szu/Cd47jJdW9
         DzHw==
X-Forwarded-Encrypted: i=1; AJvYcCUEdZm+CTonRqjRPcgtHY940tVKLwmNpwFv3mcPwBLM33X6ncJ71Ru/ZZMlcElDbeO2RU2vHzw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfiLdvB+ma8vya1fEZWKm4ZXr9Gxj3SusM/Mm5ng/1dW0DTHa7
	i6KVFes0Iyxbh2CNo2dBIOs1O0glyAPZUMRu9WX7jFwVzS+oqcht1VQpgURBD4oyYKJuKKHIR2l
	lAD9xRhDXflTsFzrcOHQ5iqokIBxec7qdSrqIG/UgmRZ8ZQasWr0NsLg=
X-Google-Smtp-Source: AGHT+IE+nJP/PTdyrlhdCBCnhMuwLyYvE945m1tRQoSAs9/Nb5TSC1ff8ItfRopYIKG1TVc4yivJUgnGdj/ZkdGvEAeSiLS0+sVb
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:16ca:b0:3d0:19c6:c9e1 with SMTP id
 e9e14a558f8ab-3d6e3f1a40fmr59337975ab.13.1743817943570; Fri, 04 Apr 2025
 18:52:23 -0700 (PDT)
Date: Fri, 04 Apr 2025 18:52:23 -0700
In-Reply-To: <67bf3ddd.050a0220.1ebef.002d.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67f08cd7.050a0220.0a13.0228.GAE@google.com>
Subject: Re: [syzbot] [net?] possible deadlock in ipv6_sock_ac_close (4)
From: syzbot <syzbot+be6f4b383534d88989f7@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    e48e99b6edf4 Merge tag 'pull-fixes' of git://git.kernel.or..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=12afa7cf980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f2054704dd53fb80
dashboard link: https://syzkaller.appspot.com/bug?extid=be6f4b383534d88989f7
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=140a294c580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1486994c580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b03407c4ab24/disk-e48e99b6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/03f6746c0414/vmlinux-e48e99b6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4b3909ad8728/bzImage-e48e99b6.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+be6f4b383534d88989f7@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.14.0-syzkaller-13189-ge48e99b6edf4 #0 Not tainted
------------------------------------------------------
syz-executor200/5838 is trying to acquire lock:
ffffffff900fc808 (rtnl_mutex){+.+.}-{4:4}, at: ipv6_sock_ac_close+0xc9/0x130 net/ipv6/anycast.c:220

but task is already holding lock:
ffff888035260aa0 (&smc->clcsock_release_lock){+.+.}-{4:4}, at: smc_clcsock_release+0x82/0xf0 net/smc/smc_close.c:30

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (&smc->clcsock_release_lock){+.+.}-{4:4}:
       lock_acquire+0x116/0x2f0 kernel/locking/lockdep.c:5866
       __mutex_lock_common kernel/locking/mutex.c:601 [inline]
       __mutex_lock+0x1a5/0x10c0 kernel/locking/mutex.c:746
       smc_switch_to_fallback+0x35/0xda0 net/smc/af_smc.c:903
       smc_setsockopt+0x765/0xd50 net/smc/af_smc.c:3104
       do_sock_setsockopt+0x3b1/0x710 net/socket.c:2296
       __sys_setsockopt net/socket.c:2321 [inline]
       __do_sys_setsockopt net/socket.c:2327 [inline]
       __se_sys_setsockopt net/socket.c:2324 [inline]
       __x64_sys_setsockopt+0x1ee/0x280 net/socket.c:2324
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #1 (sk_lock-AF_INET6){+.+.}-{0:0}:
       lock_acquire+0x116/0x2f0 kernel/locking/lockdep.c:5866
       lock_sock_nested+0x48/0x100 net/core/sock.c:3697
       do_ipv6_setsockopt+0xccd/0x3680 net/ipv6/ipv6_sockglue.c:567
       ipv6_setsockopt+0x5d/0x170 net/ipv6/ipv6_sockglue.c:993
       do_sock_setsockopt+0x3b1/0x710 net/socket.c:2296
       __sys_setsockopt net/socket.c:2321 [inline]
       __do_sys_setsockopt net/socket.c:2327 [inline]
       __se_sys_setsockopt net/socket.c:2324 [inline]
       __x64_sys_setsockopt+0x1ee/0x280 net/socket.c:2324
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (rtnl_mutex){+.+.}-{4:4}:
       check_prev_add kernel/locking/lockdep.c:3166 [inline]
       check_prevs_add kernel/locking/lockdep.c:3285 [inline]
       validate_chain+0xa69/0x24e0 kernel/locking/lockdep.c:3909
       __lock_acquire+0xad5/0xd80 kernel/locking/lockdep.c:5235
       lock_acquire+0x116/0x2f0 kernel/locking/lockdep.c:5866
       __mutex_lock_common kernel/locking/mutex.c:601 [inline]
       __mutex_lock+0x1a5/0x10c0 kernel/locking/mutex.c:746
       ipv6_sock_ac_close+0xc9/0x130 net/ipv6/anycast.c:220
       inet6_release+0x4f/0x70 net/ipv6/af_inet6.c:485
       __sock_release net/socket.c:647 [inline]
       sock_release+0x82/0x150 net/socket.c:675
       smc_clcsock_release+0xcc/0xf0 net/smc/smc_close.c:34
       __smc_release+0x683/0x800 net/smc/af_smc.c:301
       smc_release+0x2dc/0x540 net/smc/af_smc.c:344
       __sock_release net/socket.c:647 [inline]
       sock_close+0xbc/0x240 net/socket.c:1391
       __fput+0x3e9/0x9f0 fs/file_table.c:465
       task_work_run+0x251/0x310 kernel/task_work.c:227
       exit_task_work include/linux/task_work.h:40 [inline]
       do_exit+0xa11/0x27f0 kernel/exit.c:953
       do_group_exit+0x207/0x2c0 kernel/exit.c:1102
       __do_sys_exit_group kernel/exit.c:1113 [inline]
       __se_sys_exit_group kernel/exit.c:1111 [inline]
       __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1111
       x64_sys_call+0x26c3/0x26d0 arch/x86/include/generated/asm/syscalls_64.h:232
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  rtnl_mutex --> sk_lock-AF_INET6 --> &smc->clcsock_release_lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&smc->clcsock_release_lock);
                               lock(sk_lock-AF_INET6);
                               lock(&smc->clcsock_release_lock);
  lock(rtnl_mutex);

 *** DEADLOCK ***

2 locks held by syz-executor200/5838:
 #0: ffff888078efc408 (&sb->s_type->i_mutex_key#10){+.+.}-{4:4}, at: inode_lock include/linux/fs.h:867 [inline]
 #0: ffff888078efc408 (&sb->s_type->i_mutex_key#10){+.+.}-{4:4}, at: __sock_release net/socket.c:646 [inline]
 #0: ffff888078efc408 (&sb->s_type->i_mutex_key#10){+.+.}-{4:4}, at: sock_close+0x90/0x240 net/socket.c:1391
 #1: ffff888035260aa0 (&smc->clcsock_release_lock){+.+.}-{4:4}, at: smc_clcsock_release+0x82/0xf0 net/smc/smc_close.c:30

stack backtrace:
CPU: 0 UID: 0 PID: 5838 Comm: syz-executor200 Not tainted 6.14.0-syzkaller-13189-ge48e99b6edf4 #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_circular_bug+0x2e1/0x300 kernel/locking/lockdep.c:2079
 check_noncircular+0x142/0x160 kernel/locking/lockdep.c:2211
 check_prev_add kernel/locking/lockdep.c:3166 [inline]
 check_prevs_add kernel/locking/lockdep.c:3285 [inline]
 validate_chain+0xa69/0x24e0 kernel/locking/lockdep.c:3909
 __lock_acquire+0xad5/0xd80 kernel/locking/lockdep.c:5235
 lock_acquire+0x116/0x2f0 kernel/locking/lockdep.c:5866
 __mutex_lock_common kernel/locking/mutex.c:601 [inline]
 __mutex_lock+0x1a5/0x10c0 kernel/locking/mutex.c:746
 ipv6_sock_ac_close+0xc9/0x130 net/ipv6/anycast.c:220
 inet6_release+0x4f/0x70 net/ipv6/af_inet6.c:485
 __sock_release net/socket.c:647 [inline]
 sock_release+0x82/0x150 net/socket.c:675
 smc_clcsock_release+0xcc/0xf0 net/smc/smc_close.c:34
 __smc_release+0x683/0x800 net/smc/af_smc.c:301
 smc_release+0x2dc/0x540 net/smc/af_smc.c:344
 __sock_release net/socket.c:647 [inline]
 sock_close+0xbc/0x240 net/socket.c:1391
 __fput+0x3e9/0x9f0 fs/file_table.c:465
 task_work_run+0x251/0x310 kernel/task_work.c:227
 exit_task_work include/linux/task_work.h:40 [inline]
 do_exit+0xa11/0x27f0 kernel/exit.c:953
 do_group_exit+0x207/0x2c0 kernel/exit.c:1102
 __do_sys_exit_group kernel/exit.c:1113 [inline]
 __se_sys_exit_group kernel/exit.c:1111 [inline]
 __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1111
 x64_sys_call+0x26c3/0x26d0 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fd6e1b18d39
Code: Unable to access opcode bytes at 0x7fd6e1b18d0f.
R


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.


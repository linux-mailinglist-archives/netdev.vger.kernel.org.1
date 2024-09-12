Return-Path: <netdev+bounces-127631-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76987975E6F
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 03:20:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01E481F2300D
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 01:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 388681D545;
	Thu, 12 Sep 2024 01:20:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E797364AE
	for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 01:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726104028; cv=none; b=IpW03EpGEDu1sX4SBAFnfVzz0t1zDrcfwfqUZIrpHxnQl3tPZUhboVY2/oPgOzX0T/wgfRj1FKL9c56mmPrO77DQUMiSsbvQXLDhh2y2tZho8ZB6cmQXw3hFZuiHngdX82NEYAYNNtzseUEW8qx8ut/mUgatqWvKmG+ad169Dro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726104028; c=relaxed/simple;
	bh=DCinHrxP4oLMZlG75DmwQctsmobfjW/VxWg4fRx/ylY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=F9NQzNdWPwHO0pzmt1nTvuvjDrH58qIkFcTWo/w/uMTxO9p8KQ47VVaoSt3UOK4rgR7HWxu5JHTuONRRTQGrMUvW5J1TVLeamEIwc2NdgHaa8iOmzbOZP78TJ+AQtk9tHum0dwoDgm4lqfR+cNFup/NpbvdQThA87vMX6/phO14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-82cdb749559so88917139f.2
        for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 18:20:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726104025; x=1726708825;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NnW0TTLUxeLi3+xBzXmvel+kEuodYAj50dseVpoYdiM=;
        b=qu40rTzyQdbozgNNyoeCL1HRfDXsPrxGlhAL8CLS5rz5HE0rxS7Fv9AaUMfaNkuoJ5
         MK/oCkfpaFbe/RJSIbGXTXF7ez2BfX7pGb9jArFh4DVmrMoU7/HBRt5nuGypHywk3tfb
         4dxzg/B+Jaw3oGwGDVAgzeK16K8cC/KLsKTtdm+9dZpwrjYPaTMlXPYHkPjrMJUDnHaq
         oLFqoRdELka2We8eBZaCDkbh7gnUO/Fc8xbB5GeYWQx3lkY8FiSCd/VDB1w1hW2E3ZmR
         Fdo6sGLT46lTrxLd+HcmjU2PPzxol3ok+4aNmDJfnqNTJYie4IlGyUpxbylxtVNx7eVJ
         vkJA==
X-Forwarded-Encrypted: i=1; AJvYcCUyXP/ylBHK7AZQP1iZV3h+nsFy3NSU753JFyrnP8Lg0rV0OrCbPhNawTvU0MBJcgx4sUXcSSI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHSGS0589EshopRXffDXeDIFVcpJC2YgdZB6udE45qyAgJjfj0
	5F3w3wc6q2sHVYE6xILZYjGlOq7jkIcBM6ASIHbigdr+MMvgcKfMZZCgH9fVGhf3jofTUDav9Yv
	K9V52PJsA9IBxZvL3pk+c7G4Cii8NK/EYS3tq5qMeURlDjv+MpwveuH4=
X-Google-Smtp-Source: AGHT+IEQtXH6e95qVe7u/9t7oxJXZ3+WlhyE5yAgLgtZIoUDGd6K4rzz4i8ToF08w6MTe0op/Xnz6BEeTuajJQh0z6K8mS7M/pP7
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:13a7:b0:39f:5baa:e50e with SMTP id
 e9e14a558f8ab-3a0848c8ee4mr10121685ab.7.1726104025626; Wed, 11 Sep 2024
 18:20:25 -0700 (PDT)
Date: Wed, 11 Sep 2024 18:20:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004b09b90621e1e9e9@google.com>
Subject: [syzbot] [kernfs?] possible deadlock in kernfs_path_from_node
From: syzbot <syzbot+0772686ab2731ef3b722@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    8a3f14bb1e94 libbpf: Workaround (another) -Wmaybe-uninitia..
git tree:       bpf-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=11db989f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=eb19570bf3f0c14f
dashboard link: https://syzkaller.appspot.com/bug?extid=0772686ab2731ef3b722
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10aa1ffb980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15b1abc7980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/084310d1fa69/disk-8a3f14bb.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a497ae190ab2/vmlinux-8a3f14bb.xz
kernel image: https://storage.googleapis.com/syzbot-assets/039d10837302/bzImage-8a3f14bb.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0772686ab2731ef3b722@syzkaller.appspotmail.com

============================================
WARNING: possible recursive locking detected
6.11.0-rc4-syzkaller-00280-g8a3f14bb1e94 #0 Not tainted
--------------------------------------------
syz-executor106/5235 is trying to acquire lock:
ffffffff8eab6458 (kernfs_rename_lock){.-.-}-{2:2}, at: kernfs_path_from_node+0x92/0xb00 fs/kernfs/dir.c:229

but task is already holding lock:
ffffffff8eab6458 (kernfs_rename_lock){.-.-}-{2:2}, at: kernfs_path_from_node+0x92/0xb00 fs/kernfs/dir.c:229

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(kernfs_rename_lock);
  lock(kernfs_rename_lock);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

2 locks held by syz-executor106/5235:
 #0: ffffffff8eab6458 (kernfs_rename_lock){.-.-}-{2:2}, at: kernfs_path_from_node+0x92/0xb00 fs/kernfs/dir.c:229
 #1: ffffffff8e938320 (rcu_read_lock){....}-{1:2}, at: trace_call_bpf+0xbc/0x8a0

stack backtrace:
CPU: 1 UID: 0 PID: 5235 Comm: syz-executor106 Not tainted 6.11.0-rc4-syzkaller-00280-g8a3f14bb1e94 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:119
 check_deadlock kernel/locking/lockdep.c:3061 [inline]
 validate_chain+0x15d3/0x5900 kernel/locking/lockdep.c:3855
 __lock_acquire+0x137a/0x2040 kernel/locking/lockdep.c:5142
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5759
 __raw_read_lock_irqsave include/linux/rwlock_api_smp.h:160 [inline]
 _raw_read_lock_irqsave+0xdd/0x130 kernel/locking/spinlock.c:236
 kernfs_path_from_node+0x92/0xb00 fs/kernfs/dir.c:229
 kernfs_path include/linux/kernfs.h:598 [inline]
 cgroup_path include/linux/cgroup.h:598 [inline]
 get_mm_memcg_path+0xb9/0x380 mm/mmap_lock.c:82
 __mmap_lock_do_trace_start_locking+0x9c/0x2f0 mm/mmap_lock.c:95
 __mmap_lock_trace_start_locking include/linux/mmap_lock.h:29 [inline]
 mmap_read_trylock include/linux/mmap_lock.h:162 [inline]
 stack_map_get_build_id_offset+0x98a/0x9d0 kernel/bpf/stackmap.c:141
 __bpf_get_stack+0x4ad/0x5a0 kernel/bpf/stackmap.c:449
 bpf_prog_e6cf5f9c69743609+0x43/0x47
 bpf_dispatcher_nop_func include/linux/bpf.h:1254 [inline]
 __bpf_prog_run include/linux/filter.h:701 [inline]
 bpf_prog_run include/linux/filter.h:708 [inline]
 bpf_prog_run_array include/linux/bpf.h:2120 [inline]
 trace_call_bpf+0x369/0x8a0 kernel/trace/bpf_trace.c:146
 perf_trace_run_bpf_submit+0x82/0x180 kernel/events/core.c:10304
 perf_trace_lock+0x388/0x490 include/trace/events/lock.h:50
 trace_lock_release include/trace/events/lock.h:69 [inline]
 lock_release+0x9cc/0xa30 kernel/locking/lockdep.c:5770
 __raw_read_unlock_irqrestore include/linux/rwlock_api_smp.h:239 [inline]
 _raw_read_unlock_irqrestore+0x79/0x140 kernel/locking/spinlock.c:268
 kernfs_path_from_node+0x235/0xb00 fs/kernfs/dir.c:231
 kernfs_path include/linux/kernfs.h:598 [inline]
 cgroup_path include/linux/cgroup.h:598 [inline]
 get_mm_memcg_path+0xb9/0x380 mm/mmap_lock.c:82
 __mmap_lock_do_trace_start_locking+0x9c/0x2f0 mm/mmap_lock.c:95
 __mmap_lock_trace_start_locking include/linux/mmap_lock.h:29 [inline]
 mmap_read_lock include/linux/mmap_lock.h:143 [inline]
 acct_collect+0x7e7/0x830 kernel/acct.c:563
 do_exit+0x93e/0x27f0 kernel/exit.c:861
 do_group_exit+0x207/0x2c0 kernel/exit.c:1031
 __do_sys_exit_group kernel/exit.c:1042 [inline]
 __se_sys_exit_group kernel/exit.c:1040 [inline]
 __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1040
 x64_sys_call+0x2634/0x2640 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fc493637139
Code: 90 49 c7 c0 b8 ff ff ff be e7 00 00 00 ba 3c 00 00 00 eb 12 0f 1f 44 00 00 89 d0 0f 05 48 3d 00 f0 ff ff 77 1c f4 89 f0 0f 05 <48> 3d 00 f0 ff ff 76 e7 f7 d8 64 41 89 00 eb df 0f 1f 80 00 00 00
RSP: 002b:00007ffebc5ae538 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fc493637139
RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000000
RBP: 00007fc4936b22b0 R08: ffffffffffffffb8 R09: 00000000000000a0
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fc4936b22b0
R13: 0000000000000000 R14: 00007fc4936b2d20 R15: 00007fc4936082f0
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup


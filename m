Return-Path: <netdev+bounces-204950-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D3877AFCA96
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 14:40:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E3DA1885FD7
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 12:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FAEC2DC330;
	Tue,  8 Jul 2025 12:40:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D244C26E165
	for <netdev@vger.kernel.org>; Tue,  8 Jul 2025 12:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751978428; cv=none; b=HsQEXj7iw6eyQaAFd7chfVkJN+B2VWYA/h3N2QX8rk/8leiJe8fQcxH9JCQyO9pNQ8Tq9J6G86jAdNKjbttlNppOgCttDNh0PWzU2ypTK9x3431Z42TJfP76Z0UnmUUHljQ8Ltyr4IVDfRW7FVE7YXpFR3qYEe9G4cE5M/ijwFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751978428; c=relaxed/simple;
	bh=O/mt5Laig4YvyGxBOM7n5YBR4Qhf37DNVb8KTwe0N+4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=R9hz+EgnWchjh463gedxTxWg0w0vA3Gs6/uyqiUEzf01R1bKCBf/NuvElaOrrBbGkqSux6ZMqTuwD3bDZE1ua+wCLxG4wEYeWZamyKzVnwDvhJ3qTsaUeR2XlmK8kl6XFcEV7X/O5XfiAp9eTviLDBlCFgh7pOxJXgNUtzC0Isw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-87326a81ceaso438454239f.1
        for <netdev@vger.kernel.org>; Tue, 08 Jul 2025 05:40:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751978426; x=1752583226;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zNeagxp53Cib7FyDAeK/ti1QQrnWh7OkocmUSUE0k20=;
        b=RRprBAHHAf9vITczgr3WJUjy9pK/Z4tZCMqcm6oOla6Hx5OZLzcitVxNC5byYYelf8
         VkFZbExr3jT9Trevx7WlYyvbAixeH/WskpAkAr9+JPBp7wDK0RSLu/Y2d5wbzFasA+pn
         KbmgO0qG70XZC/kb8MzyLoV+mvR5NTgn0k03tOLxql5D4VFvRN8vzkH8Z5o5ztGE4gTA
         8BBd4KSAgbwS6RDmBHcPKhvCPS1npF+nOuB1bLG5XBqK/xcT0JYhoS+GjSAUo61C88+Z
         xlSm4UxWOyQIjheuN0pjkqGFdikybKDeVK0F+FZ1rH8UQoIgf0yVx83nXqjU5XriTLf5
         yf2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUxTwLFTzxQHineSqKF0EonhEmJ5lvkKJRlveZAsl12LZaeqJPYu6OBRVOsR4OtHp4etPCx+GA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdxM6ST03dfD+28pvfKvaY307yhMJbIRi9eIVYhM+uiR00UASw
	jPSiop1f7ZMIQE7zRsqCk4udHhJ8Fsmo2oGG+tVOOr1xREisfCj0ZCTZ+yzjW0AVpr5MFzL9dF6
	8yXS2fUxV+aTZX25/HSo9PzbWx6exwxDp8DiwMTyPOdEsWMwuS+qOyxyE7qI=
X-Google-Smtp-Source: AGHT+IHW29YJ0mMkJYKj8RbFg2PDoBHxN7Fim5IsU3FV9f0fYeHOL+oENDpilrPghcgkrhRME5kY/BWHO2MReuuphrGQjynxh0a5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:112:b0:3dd:bf91:23f7 with SMTP id
 e9e14a558f8ab-3e154e51b43mr20192605ab.7.1751978425899; Tue, 08 Jul 2025
 05:40:25 -0700 (PDT)
Date: Tue, 08 Jul 2025 05:40:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <686d11b9.050a0220.1ffab7.0009.GAE@google.com>
Subject: [syzbot] [net?] possible deadlock in ptp_clock_adjtime
From: syzbot <syzbot+28ddd7a3988eea351eb3@syzkaller.appspotmail.com>
To: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, richardcochran@gmail.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    d7b8f8e20813 Linux 6.16-rc5
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12b3728c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c963f5de3d9eab7d
dashboard link: https://syzkaller.appspot.com/bug?extid=28ddd7a3988eea351eb3
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b35e485ae779/disk-d7b8f8e2.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8478fc45f5f6/vmlinux-d7b8f8e2.xz
kernel image: https://storage.googleapis.com/syzbot-assets/86a991e3c539/bzImage-d7b8f8e2.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+28ddd7a3988eea351eb3@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.16.0-rc5-syzkaller #0 Tainted: G     U             
------------------------------------------------------
syz.0.4267/20512 is trying to acquire lock:
ffff88802ffba868 (&ptp->n_vclocks_mux){+.+.}-{4:4}, at: ptp_vclock_in_use drivers/ptp/ptp_private.h:113 [inline]
ffff88802ffba868 (&ptp->n_vclocks_mux){+.+.}-{4:4}, at: ptp_vclock_in_use drivers/ptp/ptp_private.h:99 [inline]
ffff88802ffba868 (&ptp->n_vclocks_mux){+.+.}-{4:4}, at: ptp_clock_freerun drivers/ptp/ptp_private.h:130 [inline]
ffff88802ffba868 (&ptp->n_vclocks_mux){+.+.}-{4:4}, at: ptp_clock_freerun drivers/ptp/ptp_private.h:125 [inline]
ffff88802ffba868 (&ptp->n_vclocks_mux){+.+.}-{4:4}, at: ptp_clock_adjtime+0x527/0x760 drivers/ptp/ptp_clock.c:125

but task is already holding lock:
ffff88802ffba130 (&clk->rwsem){++++}-{4:4}, at: get_posix_clock kernel/time/posix-clock.c:25 [inline]
ffff88802ffba130 (&clk->rwsem){++++}-{4:4}, at: get_clock_desc+0x125/0x240 kernel/time/posix-clock.c:209

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&clk->rwsem){++++}-{4:4}:
       down_write+0x92/0x200 kernel/locking/rwsem.c:1577
       posix_clock_unregister+0x4d/0xd0 kernel/time/posix-clock.c:184
       ptp_clock_unregister+0x14f/0x250 drivers/ptp/ptp_clock.c:432
       ptp_vclock_unregister+0x11a/0x160 drivers/ptp/ptp_vclock.c:228
       unregister_vclock+0x108/0x1a0 drivers/ptp/ptp_sysfs.c:177
       device_for_each_child_reverse+0x133/0x1a0 drivers/base/core.c:4051
       n_vclocks_store+0x4b6/0x6d0 drivers/ptp/ptp_sysfs.c:241
       dev_attr_store+0x58/0x80 drivers/base/core.c:2440
       sysfs_kf_write+0xf2/0x150 fs/sysfs/file.c:145
       kernfs_fop_write_iter+0x354/0x510 fs/kernfs/file.c:334
       new_sync_write fs/read_write.c:593 [inline]
       vfs_write+0x6c4/0x1150 fs/read_write.c:686
       ksys_write+0x12a/0x250 fs/read_write.c:738
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xcd/0x490 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (&ptp->n_vclocks_mux){+.+.}-{4:4}:
       check_prev_add kernel/locking/lockdep.c:3168 [inline]
       check_prevs_add kernel/locking/lockdep.c:3287 [inline]
       validate_chain kernel/locking/lockdep.c:3911 [inline]
       __lock_acquire+0x126f/0x1c90 kernel/locking/lockdep.c:5240
       lock_acquire kernel/locking/lockdep.c:5871 [inline]
       lock_acquire+0x179/0x350 kernel/locking/lockdep.c:5828
       __mutex_lock_common kernel/locking/mutex.c:602 [inline]
       __mutex_lock+0x199/0xb90 kernel/locking/mutex.c:747
       ptp_vclock_in_use drivers/ptp/ptp_private.h:113 [inline]
       ptp_vclock_in_use drivers/ptp/ptp_private.h:99 [inline]
       ptp_clock_freerun drivers/ptp/ptp_private.h:130 [inline]
       ptp_clock_freerun drivers/ptp/ptp_private.h:125 [inline]
       ptp_clock_adjtime+0x527/0x760 drivers/ptp/ptp_clock.c:125
       pc_clock_adjtime+0x115/0x1e0 kernel/time/posix-clock.c:239
       do_clock_adjtime kernel/time/posix-timers.c:1162 [inline]
       __do_sys_clock_adjtime+0x172/0x290 kernel/time/posix-timers.c:1174
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xcd/0x490 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  rlock(&clk->rwsem);
                               lock(&ptp->n_vclocks_mux);
                               lock(&clk->rwsem);
  lock(&ptp->n_vclocks_mux);

 *** DEADLOCK ***

1 lock held by syz.0.4267/20512:
 #0: ffff88802ffba130 (&clk->rwsem){++++}-{4:4}, at: get_posix_clock kernel/time/posix-clock.c:25 [inline]
 #0: ffff88802ffba130 (&clk->rwsem){++++}-{4:4}, at: get_clock_desc+0x125/0x240 kernel/time/posix-clock.c:209

stack backtrace:
CPU: 0 UID: 0 PID: 20512 Comm: syz.0.4267 Tainted: G     U              6.16.0-rc5-syzkaller #0 PREEMPT(full) 
Tainted: [U]=USER
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_circular_bug+0x275/0x350 kernel/locking/lockdep.c:2046
 check_noncircular+0x14c/0x170 kernel/locking/lockdep.c:2178
 check_prev_add kernel/locking/lockdep.c:3168 [inline]
 check_prevs_add kernel/locking/lockdep.c:3287 [inline]
 validate_chain kernel/locking/lockdep.c:3911 [inline]
 __lock_acquire+0x126f/0x1c90 kernel/locking/lockdep.c:5240
 lock_acquire kernel/locking/lockdep.c:5871 [inline]
 lock_acquire+0x179/0x350 kernel/locking/lockdep.c:5828
 __mutex_lock_common kernel/locking/mutex.c:602 [inline]
 __mutex_lock+0x199/0xb90 kernel/locking/mutex.c:747
 ptp_vclock_in_use drivers/ptp/ptp_private.h:113 [inline]
 ptp_vclock_in_use drivers/ptp/ptp_private.h:99 [inline]
 ptp_clock_freerun drivers/ptp/ptp_private.h:130 [inline]
 ptp_clock_freerun drivers/ptp/ptp_private.h:125 [inline]
 ptp_clock_adjtime+0x527/0x760 drivers/ptp/ptp_clock.c:125
 pc_clock_adjtime+0x115/0x1e0 kernel/time/posix-clock.c:239
 do_clock_adjtime kernel/time/posix-timers.c:1162 [inline]
 __do_sys_clock_adjtime+0x172/0x290 kernel/time/posix-timers.c:1174
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x490 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ffbd478e929
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffbd5676038 EFLAGS: 00000246 ORIG_RAX: 0000000000000131
RAX: ffffffffffffffda RBX: 00007ffbd49b6080 RCX: 00007ffbd478e929
RDX: 0000000000000000 RSI: 0000000000000000 RDI: fffffffffffffffb
RBP: 00007ffbd4810b39 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007ffbd49b6080 R15: 00007fff4cf8c228
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup


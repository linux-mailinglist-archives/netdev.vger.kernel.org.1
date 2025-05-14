Return-Path: <netdev+bounces-190528-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E92B8AB762B
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 21:51:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A98781BA5F84
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 19:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 709102918FF;
	Wed, 14 May 2025 19:51:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68651F9F7C
	for <netdev@vger.kernel.org>; Wed, 14 May 2025 19:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747252298; cv=none; b=usQ3R9K1xwNUf0GL97gppw0sQakw/39+9qYDubVT9S5KcAA+W2CUSxpvytf7sAdjSD2CzEiF/iTECm2w1tv/lncF8v45nySYUvY0F/NOirN4Qm7BRMcri0XcMkK3MktkS7rtNOJvvCB7CYnrOxw3VT6X+UNJoQqGhN2rT9rU4fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747252298; c=relaxed/simple;
	bh=650WkzGzXzfRNpSJ0M/yIuySfZ42hmp3ZkQvxVRCZLc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=CAPWDrGc01qTXqI7bujXnBbm0RieFVXzaRxbi6fRSRMd6K52IlhY9jJ/YDduimMJ0M1JOJKAQWVmV9abrr7igEJYWl9xrxal53/M7BDMsnJROLePuwQxz0H52xmCIAr7vIrUFG2vmLxSwKxX4EfXM6ueKrdmNyGH55DQOOEY5cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3da644c8ffeso2065945ab.1
        for <netdev@vger.kernel.org>; Wed, 14 May 2025 12:51:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747252296; x=1747857096;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MtvhusWw88lZCsB7Q9g6i+PXiLbp/uslfFEIk4Ma3Jw=;
        b=fWLmVF76ogql0JphtZeSACBFi3KP1RzDIhxes8p4uNFBEsfXfh2yN0jxHatP+cMRZt
         lR87WUJDJPEqXfTNMmOFAGknkM1LODr0vdiV/an8QWoWgfT1MqE46Xc0aIlAG8fhIMh3
         LEtEVbXH0EVhEt1fh9DsMTLdUM+ZQLd45hZxegCzrFeWKWU9hOROzKBYyy6NzkoqOQhB
         t5AyHMmMckQql+ZgsitBpaZ1IcWofTXHcGu93FlOpfaFCT5RypWsWlcqdnelspZKDP/s
         hxXI7G6GV5rquWzEP57EHhcQrdWTf1jwf6KzchIqC/E+jWYGhSANB4/OUYvXzQqMz3+J
         /JwA==
X-Forwarded-Encrypted: i=1; AJvYcCXL9HUU5XcoMdJeh+SAMsqQ4pmMIpgSB34HDGGw41n74wH0XFGJ3qUd/dXr/LvNy4ojtAZle7Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEITJ9O4X7l8iKUuw4UjT9W6bUcKfIzCAOLl40VCZtA/y7rYqj
	jvW3y0fFWZw9RjN6c1NHuxhPHIBNDMZWUkKKCEz8nLChg4RHdi1pyAAA1gVaMI3ezwlAeY+6Rxo
	XZt6I6keYa0VZSf2xCuqviPcorXe7A7Qz13rg/8J1VfTwSV8MrCN7vCg=
X-Google-Smtp-Source: AGHT+IEeHfaHv5AKwjhKg3IHx97n/uvmwk4fbdnKk92J4Rftvu+8KyNkNjytAT+g0wi8TNl0bBLw0k+cxgwqT2P9p0HSP3KwDEAA
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2146:b0:3d8:20fb:f060 with SMTP id
 e9e14a558f8ab-3db6f793796mr54666585ab.4.1747252295728; Wed, 14 May 2025
 12:51:35 -0700 (PDT)
Date: Wed, 14 May 2025 12:51:35 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6824f447.a70a0220.3e9d8.001d.GAE@google.com>
Subject: [syzbot] [net?] possible deadlock in ptp_clock_unregister
From: syzbot <syzbot+eb6f218811a9d721fd53@syzkaller.appspotmail.com>
To: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, richardcochran@gmail.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    405e6c37c89e Merge tag 'probes-fixes-v6.15-rc6' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=132f4af4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7819b10245b63b3d
dashboard link: https://syzkaller.appspot.com/bug?extid=eb6f218811a9d721fd53
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/62d60a45311f/disk-405e6c37.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/63f63df5f19f/vmlinux-405e6c37.xz
kernel image: https://storage.googleapis.com/syzbot-assets/89438849afbb/bzImage-405e6c37.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+eb6f218811a9d721fd53@syzkaller.appspotmail.com

ptp ptp0: delete virtual clock ptp1
============================================
WARNING: possible recursive locking detected
6.15.0-rc6-syzkaller-00051-g405e6c37c89e #0 Not tainted
--------------------------------------------
syz.0.550/8873 is trying to acquire lock:
ffff88802a6c4868 (&ptp->n_vclocks_mux){+.+.}-{4:4}, at: ptp_vclock_in_use drivers/ptp/ptp_private.h:103 [inline]
ffff88802a6c4868 (&ptp->n_vclocks_mux){+.+.}-{4:4}, at: ptp_clock_unregister+0x21/0x250 drivers/ptp/ptp_clock.c:415

but task is already holding lock:
ffff88814c752868 (&ptp->n_vclocks_mux){+.+.}-{4:4}, at: n_vclocks_store+0xf1/0x6d0 drivers/ptp/ptp_sysfs.c:215

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&ptp->n_vclocks_mux);
  lock(&ptp->n_vclocks_mux);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

5 locks held by syz.0.550/8873:
 #0: ffff8880290f0b78 (&f->f_pos_lock){+.+.}-{4:4}, at: fdget_pos+0x2a2/0x370 fs/file.c:1213
 #1: ffff888035f5e420 (sb_writers#7){.+.+}-{0:0}, at: ksys_write+0x12a/0x240 fs/read_write.c:736
 #2: ffff888059fa1488 (&of->mutex){+.+.}-{4:4}, at: kernfs_fop_write_iter+0x28f/0x510 fs/kernfs/file.c:325
 #3: ffff88814c93c878 (kn->active#100){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x2b2/0x510 fs/kernfs/file.c:326
 #4: ffff88814c752868 (&ptp->n_vclocks_mux){+.+.}-{4:4}, at: n_vclocks_store+0xf1/0x6d0 drivers/ptp/ptp_sysfs.c:215

stack backtrace:
CPU: 1 UID: 0 PID: 8873 Comm: syz.0.550 Not tainted 6.15.0-rc6-syzkaller-00051-g405e6c37c89e #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_deadlock_bug+0x1e9/0x240 kernel/locking/lockdep.c:3042
 check_deadlock kernel/locking/lockdep.c:3094 [inline]
 validate_chain kernel/locking/lockdep.c:3896 [inline]
 __lock_acquire+0xff7/0x1ba0 kernel/locking/lockdep.c:5235
 lock_acquire kernel/locking/lockdep.c:5866 [inline]
 lock_acquire+0x179/0x350 kernel/locking/lockdep.c:5823
 __mutex_lock_common kernel/locking/mutex.c:601 [inline]
 __mutex_lock+0x199/0xb90 kernel/locking/mutex.c:746
 ptp_vclock_in_use drivers/ptp/ptp_private.h:103 [inline]
 ptp_clock_unregister+0x21/0x250 drivers/ptp/ptp_clock.c:415
 ptp_vclock_unregister+0x11a/0x160 drivers/ptp/ptp_vclock.c:228
 unregister_vclock+0x108/0x1a0 drivers/ptp/ptp_sysfs.c:177
 device_for_each_child_reverse+0x136/0x1a0 drivers/base/core.c:4051
 n_vclocks_store+0x4b6/0x6d0 drivers/ptp/ptp_sysfs.c:241
 dev_attr_store+0x58/0x80 drivers/base/core.c:2440
 sysfs_kf_write+0xf2/0x150 fs/sysfs/file.c:145
 kernfs_fop_write_iter+0x351/0x510 fs/kernfs/file.c:334
 new_sync_write fs/read_write.c:591 [inline]
 vfs_write+0x5bd/0x1180 fs/read_write.c:684
 ksys_write+0x12a/0x240 fs/read_write.c:736
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x230 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f234fb8e969
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f2350ade038 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f234fdb5fa0 RCX: 00007f234fb8e969
RDX: 0000000000000004 RSI: 0000200000000100 RDI: 0000000000000005
RBP: 00007f234fc10ab1 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f234fdb5fa0 R15: 00007ffea4834d58
 </TASK>
ptp ptp0: only physical clock in use now


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


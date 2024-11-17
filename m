Return-Path: <netdev+bounces-145619-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 823499D0250
	for <lists+netdev@lfdr.de>; Sun, 17 Nov 2024 08:17:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD7C2B23912
	for <lists+netdev@lfdr.de>; Sun, 17 Nov 2024 07:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F285B38FAD;
	Sun, 17 Nov 2024 07:17:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F1929CE8
	for <netdev@vger.kernel.org>; Sun, 17 Nov 2024 07:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731827845; cv=none; b=RdjKc/oP7eAE4NBqNOYV+QR8U4JTWqO+DE4uhQaYwAc7pt4p32xNNLzUYuh/nXFo3eCuy44EACo0GUpUgSDNFShCSD7ukECwQi7SqHM0d5sdcJSU7jxTi9J+yj1mTqejCqUOMT4T31OVJFYuz6vaBfrV4eQVVBjXlQboYQ9SMKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731827845; c=relaxed/simple;
	bh=J9xo0eDjjWl6nYWn3GkKYXXbRW+xqRQnTm0Dylsv+W0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=BgLPebpLt9CD25eYjfx2bqNea/iZ6bzoyuJ6C9E0NdZsHtDFC5Xk7BUxFUtN4JbOqyhHq/JroYCPdWNmf0FxA2cpxrRtx5QYpipHzL1AqnBl1aeBW+tYD6ltYUOgK0+m5oN/OKSj4D4tdYAHsgc0d04baCs35lM8sO5FWMOp1Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a7191aa79cso23595895ab.1
        for <netdev@vger.kernel.org>; Sat, 16 Nov 2024 23:17:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731827843; x=1732432643;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9g9FL2vtw746ImnieEUrrscr7c4cCXXlHJDI8dzEecs=;
        b=IJmyztpD4cb/LYVgtGKP0EFWiA2qNEYZ/B4zfh7X6GhmoXP1fdtf7NLP3ggPUdgLPf
         SLPWE2/u+MSU+5J2QOTSpHely2tal485eYV4l7kWM4OQsi4cwIPQ2DSIITcAQPEUeOph
         Tlr5A4hswwjc3ZO3QJfd995BIkb6+fNHnyc+S3vUv591V3/4CgkQKsSTXc+4dzk7BSwb
         SEC9pI5/i5KGNofFFbpXkLpFYO3LHzwfhySQhf1/FB59K2/gg7BlrP2IqOEciLYSliTD
         19dGharXMoiGpJjn+FizlCi5uAGXIlh3jVKgvuBxm789AWH8ibf92nmNWy5pzTzlPFbQ
         hqiw==
X-Forwarded-Encrypted: i=1; AJvYcCUN9WsDpK4n9Mu/qqHT5F9643WbliC9TUjymp4JdgdltlKix2g1paeOcsFXQ4CegHvkVeZmTjA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yytf099cUjD8oRpKI6rg08HT02cC2sel26EfAnpzHSRP1F6RGcC
	feMyEmsXWCveDkMRi3d1aEvYr8YTn0kTJyjmuqTxvxAHBVkKZmaKWcUb6N0Ml0Jo5ZOGM+awed+
	FbzwNxkghfMbqzm7SId81vBuShBnPH9GzUMcinn55BBB8+aT+1cVRGbw=
X-Google-Smtp-Source: AGHT+IFP3Is8EwEVSWbcBxUXcFQ8uqHZie0oXoS31tzssqe3YWdGOm9OwUtOr9Y5yPw3mF6DxRyEmVAaReMKLjtoFXxbHYuZcgHg
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a8d:b0:3a6:b445:dc9c with SMTP id
 e9e14a558f8ab-3a747ff7fc7mr106747335ab.3.1731827843528; Sat, 16 Nov 2024
 23:17:23 -0800 (PST)
Date: Sat, 16 Nov 2024 23:17:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67399883.050a0220.e1c64.0010.GAE@google.com>
Subject: [syzbot] [net?] WARNING: locking bug in try_to_wake_up (2)
From: syzbot <syzbot+6ac735cc9f9ce6ec2f74@syzkaller.appspotmail.com>
To: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	luiz.dentz@gmail.com, marcel@holtmann.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    e8bdb3c8be08 Merge tag 'riscv-for-linus-6.12-rc8' of git:/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11231378580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d2aeec8c0b2e420c
dashboard link: https://syzkaller.appspot.com/bug?extid=6ac735cc9f9ce6ec2f74
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e2da80861e22/disk-e8bdb3c8.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e048d2585df1/vmlinux-e8bdb3c8.xz
kernel image: https://storage.googleapis.com/syzbot-assets/203d0f852ba3/bzImage-e8bdb3c8.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6ac735cc9f9ce6ec2f74@syzkaller.appspotmail.com

Bluetooth: hci4: unexpected cc 0x1001 length: 249 > 9
------------[ cut here ]------------
DEBUG_LOCKS_WARN_ON(1)
WARNING: CPU: 0 PID: 5857 at kernel/locking/lockdep.c:232 hlock_class kernel/locking/lockdep.c:232 [inline]
WARNING: CPU: 0 PID: 5857 at kernel/locking/lockdep.c:232 check_wait_context kernel/locking/lockdep.c:4826 [inline]
WARNING: CPU: 0 PID: 5857 at kernel/locking/lockdep.c:232 __lock_acquire+0x58c/0x2050 kernel/locking/lockdep.c:5152
Modules linked in:
CPU: 0 UID: 0 PID: 5857 Comm: kworker/u9:7 Not tainted 6.12.0-rc7-syzkaller-00189-ge8bdb3c8be08 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/30/2024
Workqueue: hci4 hci_cmd_work
RIP: 0010:hlock_class kernel/locking/lockdep.c:232 [inline]
RIP: 0010:check_wait_context kernel/locking/lockdep.c:4826 [inline]
RIP: 0010:__lock_acquire+0x58c/0x2050 kernel/locking/lockdep.c:5152
Code: 00 00 83 3d b5 db ac 0e 00 75 23 90 48 c7 c7 60 c9 0a 8c 48 c7 c6 00 cc 0a 8c e8 0f 7d e5 ff 48 ba 00 00 00 00 00 fc ff df 90 <0f> 0b 90 90 90 31 db 48 81 c3 c4 00 00 00 48 89 d8 48 c1 e8 03 0f
RSP: 0018:ffffc90004d17670 EFLAGS: 00010046
RAX: 8e05c886ad1f6a00 RBX: 0000000000000d68 RCX: ffff88803572bc00
RDX: dffffc0000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000014 R08: ffffffff8155e312 R09: 1ffff110170c519a
R10: dffffc0000000000 R11: ffffed10170c519b R12: ffff88803572bc00
R13: 0000000000000d68 R14: 1ffff11006ae58f4 R15: ffff88803572c7a0
FS:  0000000000000000(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b30b1eff8 CR3: 000000006d8fc000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5825
 _raw_spin_lock_nested+0x31/0x40 kernel/locking/spinlock.c:378
 raw_spin_rq_lock_nested+0x2a/0x140 kernel/sched/core.c:598
 raw_spin_rq_lock kernel/sched/sched.h:1506 [inline]
 rq_lock kernel/sched/sched.h:1805 [inline]
 ttwu_queue kernel/sched/core.c:3951 [inline]
 try_to_wake_up+0x81e/0x14b0 kernel/sched/core.c:4281
 autoremove_wake_function+0x16/0x110 kernel/sched/wait.c:384
 __wake_up_common kernel/sched/wait.c:89 [inline]
 __wake_up_common_lock+0x132/0x1e0 kernel/sched/wait.c:106
 vhci_send_frame+0xe1/0x150 drivers/bluetooth/hci_vhci.c:83
 hci_send_frame+0x1fb/0x380 net/bluetooth/hci_core.c:3042
 hci_send_cmd_sync net/bluetooth/hci_core.c:4069 [inline]
 hci_cmd_work+0x123/0x6c0 net/bluetooth/hci_core.c:4098
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa65/0x1850 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f2/0x390 kernel/kthread.c:389
 ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
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


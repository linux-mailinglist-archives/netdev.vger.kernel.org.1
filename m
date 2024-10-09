Return-Path: <netdev+bounces-133454-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FA01995F97
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 08:18:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49FF71C2155B
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 06:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D29D154430;
	Wed,  9 Oct 2024 06:18:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D063377102
	for <netdev@vger.kernel.org>; Wed,  9 Oct 2024 06:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728454707; cv=none; b=dv3oYO04Hu+udkXCnMzZSGmYTrNhIaABjRxnIq2L+o3Z/RHZDegoxELj+/fO1BVpsCionjvGUovwLmjvWlmOHbCM+ZV96VOyTyYtI8wX3KON1287Qu0OYghUObVGQ62EJ+Mx1fxJYaKuAXyth7zHhW1N2povaiqdZY6cvd873pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728454707; c=relaxed/simple;
	bh=41YuIWaR+jkaJzB7bu88/r19+4V3ekzIeGNJsNZGfY4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=PqUyOneuINT+SvcxOyRJLtsMqO2E4GIaw88Crh+eYEyGFgv3WCjUet6/a7L54+RCsjHssikaqWgIm4IYUvi8Q0V5mieOnE8xFUl9p05PczIJZ0NczOgSeWOiNAAtm4bp7dVG0qXxTKOSrlZinJrUggR6zbXPW4LCHdTygnAXsUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a0cb7141adso87233105ab.1
        for <netdev@vger.kernel.org>; Tue, 08 Oct 2024 23:18:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728454705; x=1729059505;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WN/8+Fk6jFaiq/biP5FQbQslYeX6B8QOQ/ORcMtPRrM=;
        b=nC/ym5IJNEuiqKvy3wHHg7PEr51DFfZglInj/cs/gUSfgoQ9Bq0L3hrV1ldx9sH5r4
         rbkhgxFUhUbTNBE5CM+H+FehTRQqLFqzis8X1SWLYUVDKYSwD+OveVnLmTxjNX0Y7joO
         5wUcdvJOCSp76Nd98d+KoRRT++oSlbF6H9/KCIMo1hhOQgH+oWt8STUYCu0IoeGR6GYq
         xCh5VbxQr/k1wHCXPqccxgRGg7XI/DUbn6vB8NiyPsLxVlk8nuxLFXH0KFuU/nTkpjgr
         jYJl2E+01lF2huKt7WgN+3LPUU5ac7W1C06BZggoRaTERGV5GMnQQA4giugD8NR7mVLS
         GnUg==
X-Forwarded-Encrypted: i=1; AJvYcCVH41W3yOTH0e5bttgexQ92c/LarEjv+uPKP0f6juwZq4ww5zBFQnkYpvLd+SJf9BwN3azNtik=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzJMHRdogb8wJ4CLW3JjOjB3Z1RKzyL9Mq1wovEHgZ1PH/7hw9
	hBPedi9WGoVa2Rz4nOqUfqn3YMnzTiZKkB1DuiQ49gB8CmWymbftclR1GJ6Qd/K3AXMdFT7HFMQ
	ctHcyKUZGVF8ccQUCjWK4SHeHKXJiqfpiY0tyh/fwVdnFf3F/eU3Wc/w=
X-Google-Smtp-Source: AGHT+IEOyWjUpS0eweEh8BTolEpe55xG/E3pr3k1QFw4EUhXMC6cstnG2+9WPEDuUFWX+z2xFeeKvU1buGLC51a0NzsvTZ5aUn1Q
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d81:b0:3a0:abec:da95 with SMTP id
 e9e14a558f8ab-3a397d19872mr11260245ab.22.1728454704989; Tue, 08 Oct 2024
 23:18:24 -0700 (PDT)
Date: Tue, 08 Oct 2024 23:18:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67062030.050a0220.3f80e.0025.GAE@google.com>
Subject: [syzbot] [wireguard?] WARNING: locking bug in wg_packet_encrypt_worker
 (2)
From: syzbot <syzbot+58510c37d7d3c2335e35@syzkaller.appspotmail.com>
To: Jason@zx2c4.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com, wireguard@lists.zx2c4.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    27cc6fdf7201 Merge tag 'linux_kselftest-fixes-6.12-rc2' of..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16829bd0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6248f0ab12f33349
dashboard link: https://syzkaller.appspot.com/bug?extid=58510c37d7d3c2335e35
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/6977fdc3f229/disk-27cc6fdf.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e3cb80988930/vmlinux-27cc6fdf.xz
kernel image: https://storage.googleapis.com/syzbot-assets/030bdb347b6a/bzImage-27cc6fdf.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+58510c37d7d3c2335e35@syzkaller.appspotmail.com

------------[ cut here ]------------
DEBUG_LOCKS_WARN_ON(1)
WARNING: CPU: 1 PID: 5276 at kernel/locking/lockdep.c:232 hlock_class kernel/locking/lockdep.c:232 [inline]
WARNING: CPU: 1 PID: 5276 at kernel/locking/lockdep.c:232 hlock_class+0xfa/0x130 kernel/locking/lockdep.c:221
Modules linked in:
CPU: 1 UID: 0 PID: 5276 Comm: kworker/1:4 Not tainted 6.12.0-rc1-syzkaller-00306-g27cc6fdf7201 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Workqueue: wg-crypt-wg2 wg_packet_encrypt_worker
RIP: 0010:hlock_class kernel/locking/lockdep.c:232 [inline]
RIP: 0010:hlock_class+0xfa/0x130 kernel/locking/lockdep.c:221
Code: b6 14 11 38 d0 7c 04 84 d2 75 43 8b 05 73 a9 f5 0e 85 c0 75 19 90 48 c7 c6 40 d5 6c 8b 48 c7 c7 60 cf 6c 8b e8 57 b2 e4 ff 90 <0f> 0b 90 90 90 31 c0 eb 9e e8 78 38 85 00 e9 1c ff ff ff 48 c7 c7
RSP: 0018:ffffc90004437960 EFLAGS: 00010086
RAX: 0000000000000000 RBX: 00000000000012ae RCX: ffffffff814e71a9
RDX: ffff88806302da00 RSI: ffffffff814e71b6 RDI: 0000000000000001
RBP: 0000000000000001 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000000
R13: ffff88806302e530 R14: 00000000000012ae R15: ffff88806302da00
FS:  0000000000000000(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020021000 CR3: 000000003167e000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 check_wait_context kernel/locking/lockdep.c:4826 [inline]
 __lock_acquire+0x415/0x3ce0 kernel/locking/lockdep.c:5152
 lock_acquire.part.0+0x11b/0x380 kernel/locking/lockdep.c:5825
 __raw_spin_lock_bh include/linux/spinlock_api_smp.h:126 [inline]
 _raw_spin_lock_bh+0x33/0x40 kernel/locking/spinlock.c:178
 spin_lock_bh include/linux/spinlock.h:356 [inline]
 ptr_ring_consume_bh include/linux/ptr_ring.h:365 [inline]
 wg_packet_encrypt_worker+0xe4/0xd60 drivers/net/wireguard/send.c:293
 process_one_work+0x9c5/0x1ba0 kernel/workqueue.c:3229
 process_scheduled_works kernel/workqueue.c:3310 [inline]
 worker_thread+0x6c8/0xf00 kernel/workqueue.c:3391
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
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


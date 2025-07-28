Return-Path: <netdev+bounces-210646-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DCC7B141F7
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 20:29:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B768917A641
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 18:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66FCD2727E1;
	Mon, 28 Jul 2025 18:29:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9FE4220694
	for <netdev@vger.kernel.org>; Mon, 28 Jul 2025 18:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753727378; cv=none; b=ZV/b0tAt4WPrUYX0607m53O4Vg78alFDd8mDAilkqfhuQIewmVySgGP9OB4nc4IFLb0AEJL/GLJziD8YuIabq2bORlZwtYmVSVM5Ylli7N6FQTRyT0RyBrNElPJFEYKN6EbH/1ZAiIxjfnx9yLUBrrBIuGZFK9zStAaXLaYF1Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753727378; c=relaxed/simple;
	bh=cYWVqAnhujQdCJ8yjAyXmyxg3NAOnr6hQ/3MIip5HSY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=p0bz0Q2jLbHaDBcAEaB7/Mcsx/J/Z414Y/X8itE4zBPGWE5vbO+eiYwy/JpGiB6buSO165Z7Eayf0kNRNi4Tttwv0VeQ5ne67ljdENQaCsRzBPDiqWRP7TwmenhB/fVteQuKRPdl3ZXrh49bSyodRn+DRv6ypXn8NI6+8C/2uHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-87c18a52977so405527139f.1
        for <netdev@vger.kernel.org>; Mon, 28 Jul 2025 11:29:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753727376; x=1754332176;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e6gSR+K0MANHv0vyIASIA2YCGJCrixEwa05dyDMZ7kE=;
        b=ajJ6EDjjqpGxRUlpGNTFA79v5fniL8MUAE71o6wjZe++EMZLfjWS4axBUgRBth2bIx
         shAGsg/RxuETQ/Nj+EyaFzC4P4S8jJVGbO/Rb2z/OAL4piBF/sQsvZlW8dLFiKLWrOvX
         mbmi/oVUusQ2iLtwth9svHHr70nhRsYgX8ds41qzZAyW8zCluXlTCGi7DGR2ENZ6szCd
         GcRWgktJTnxQ5cub3/D5WsC9kVSdQMfJYwIZCXkVHZy2STxNfanM4Pp5o6a0hJIYd1YK
         yyGT7vgwwMgKpyKVjUO92PgQ/Z4B4DqvKhJWsNfHa10Rnz+Cf3H7koCzkUIvSFUP2ILq
         mMKA==
X-Forwarded-Encrypted: i=1; AJvYcCUBqimElTpjq4oHarDDzoJdoigmzKd82YhmGUs/wwQGTVP9nFbPMFzezxkZqsAUbYFb2Hen6zE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWx/rDdrs53Leus7QyqmwRpYomc5yAStz/HJnc133I5uvZfo1p
	Fb45pqTk4CIFfCj3ljZkXodS4ygEBZ1GpCgB8xdxhL6xdTycpHnY4rb/iw5eU6tM60BVonAVP6/
	/LZFLJ03edmoT/iMigrHaKxl+Cyk0w0FxRN4c1T+gIC5eBdm8+ndCPBSYXuA=
X-Google-Smtp-Source: AGHT+IFOVG1qEshG+9mVORxycfBFrFHHC7hDcvu/57rmUCwIDnuCJdbvWi9SaDDD5Lft72kbt87utLWInMH4DE2h7BHp/YQCpPkm
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:32c9:b0:3e3:d245:8a1 with SMTP id
 e9e14a558f8ab-3e3d2450a71mr169524415ab.2.1753727375680; Mon, 28 Jul 2025
 11:29:35 -0700 (PDT)
Date: Mon, 28 Jul 2025 11:29:35 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6887c18f.a00a0220.b12ec.00ab.GAE@google.com>
Subject: [syzbot] [mm?] WARNING: locking bug in __percpu_counter_limited_add
From: syzbot <syzbot+57a2bb6f53fad29bd29c@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, baolin.wang@linux.alibaba.com, hughd@google.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    94619ea2d933 Merge tag 'ipsec-next-2025-07-23' of git://gi..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1327c0a2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ceda48240b85ec34
dashboard link: https://syzkaller.appspot.com/bug?extid=57a2bb6f53fad29bd29c
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/afd64d9816ee/disk-94619ea2.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e1755ce1f83b/vmlinux-94619ea2.xz
kernel image: https://storage.googleapis.com/syzbot-assets/2061dff2fbf4/bzImage-94619ea2.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+57a2bb6f53fad29bd29c@syzkaller.appspotmail.com

------------[ cut here ]------------
DEBUG_LOCKS_WARN_ON(!test_bit(class_idx, lock_classes_in_use))
WARNING: CPU: 0 PID: 20124 at kernel/locking/lockdep.c:5210 __lock_acquire+0xc0c/0xd20 kernel/locking/lockdep.c:5210
Modules linked in:
CPU: 0 UID: 0 PID: 20124 Comm: syz.3.4335 Not tainted 6.16.0-rc6-syzkaller-01673-g94619ea2d933 #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
RIP: 0010:__lock_acquire+0xc0c/0xd20 kernel/locking/lockdep.c:5210
Code: ff ff 90 e8 36 ad 1e 03 85 c0 74 22 83 3d 2f 14 04 0e 00 75 19 90 48 c7 c7 1d b7 b8 8d 48 c7 c6 ff 5b a0 8d e8 25 cb e5 ff 90 <0f> 0b 90 90 90 e9 8f 00 00 00 90 0f 0b 90 e9 8d fe ff ff 90 e8 fb
RSP: 0018:ffffc9000524f5c0 EFLAGS: 00010046
RAX: b837b7aac7381900 RBX: 0000000000000003 RCX: 0000000000080000
RDX: ffffc90011215000 RSI: 000000000000cba4 RDI: 000000000000cba5
RBP: 0000000000000000 R08: 0000000000000003 R09: 0000000000000004
R10: dffffc0000000000 R11: fffffbfff1bfaa6c R12: 0000000000000004
R13: 0000000000000002 R14: ffff8880251d4768 R15: 0000000000000000
FS:  00007f1c62b736c0(0000) GS:ffff888125c15000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000020000003e000 CR3: 0000000075eea000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5871
 __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
 _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
 __percpu_counter_limited_add+0x22d/0x710 lib/percpu_counter.c:351
 percpu_counter_limited_add include/linux/percpu_counter.h:77 [inline]
 shmem_inode_acct_blocks+0x187/0x470 mm/shmem.c:233
 shmem_alloc_and_add_folio+0x8bc/0xf60 mm/shmem.c:1920
 shmem_get_folio_gfp+0x59d/0x1660 mm/shmem.c:2536
 shmem_get_folio mm/shmem.c:2642 [inline]
 shmem_write_begin+0xf7/0x2b0 mm/shmem.c:3292
 generic_perform_write+0x2c7/0x910 mm/filemap.c:4112
 shmem_file_write_iter+0xf8/0x120 mm/shmem.c:3467
 new_sync_write fs/read_write.c:593 [inline]
 vfs_write+0x548/0xa90 fs/read_write.c:686
 ksys_write+0x145/0x250 fs/read_write.c:738
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f1c61d8e9a9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f1c62b73038 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f1c61fb6160 RCX: 00007f1c61d8e9a9
RDX: 00000000ffffffc1 RSI: 0000200000000200 RDI: 000000000000000a
RBP: 00007f1c61e10d69 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f1c61fb6160 R15: 00007ffe8452d7f8
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


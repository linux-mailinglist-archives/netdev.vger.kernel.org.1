Return-Path: <netdev+bounces-147679-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E6A579DB252
	for <lists+netdev@lfdr.de>; Thu, 28 Nov 2024 06:05:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F36D0B21CA8
	for <lists+netdev@lfdr.de>; Thu, 28 Nov 2024 05:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDEBD73477;
	Thu, 28 Nov 2024 05:05:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4A23FD4
	for <netdev@vger.kernel.org>; Thu, 28 Nov 2024 05:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732770326; cv=none; b=tZ6z1B4tm1+AWH+rnvFmgEvBPaGxTstKUJs6span8bd/4o5P8q+jMV9iumZfOMhg1fNRVKL7N7A08TY3mLH7JSzo96fvhc+iNe7dFvyhJ6MPZmzORCYJeHpJBGiK9HoyH4RvTEuPTDUZXXITVWD4x9saXvgh2KN9El8ceRjJAv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732770326; c=relaxed/simple;
	bh=vIKNpXEFyCj9f/ESQ5wYvvwDqyZOUL6pDkNlXFhBYsc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=A0SESpsKQ+NaQ+NjV/Jlw3pgouq+c1onTOtUVCKE4B6mFGQyYinMGt6JQR0IwkDGFjcVzFj4L7LJzwYnV8daTGJJdvRBVpXhAYVMgbUheCxX8O0SOVRSXU9F+oXBlkIa3zeHUF/RIK6EgCV+mP6bX+sc6T2waPpr5NQPiP54nus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a777d47a8eso7837515ab.3
        for <netdev@vger.kernel.org>; Wed, 27 Nov 2024 21:05:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732770324; x=1733375124;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VUe6L83DvzFZaE2UEQFYvXPculZx4n1ci65ASlI0ET4=;
        b=L3C7IqZgmtGw0ZeixNdOD/l+V7XkacUwi+vr+zYQko080DOLZ/thBii46EYsUtUvTG
         3o3z4qjB3dXhbdp6w7uxhIb6oU8OfxzMKKqQL0FNvufomVuEITDQ83tv3CjG7tyKFlT9
         wF9udWaU0oMTxhdBxWn0pVaiCUvhK9jNsBiyHBB4HGB1yvSlJEQkm2lOpZg9kI8yNadJ
         9Apx3VJHxL+/NCtX7oGwLp/LThPD3oVc+nBUSn8s2tfUBQ2MNFHCt6Bg/ZwtlE6PWiVT
         cVlPIJiTUq5km2o1qktJhb/JGWwmkKoTQY8esSwyJdP8UaO7hjkNhZ8/6AzWgQovh0PW
         UQLg==
X-Forwarded-Encrypted: i=1; AJvYcCUC7DaR0E14uGFelPHKAMkJ5NlMnfnPjf469UzEw0fK3A0cENLDvJSpW1i5w+S+tuokbKX/JxM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvwtgH6ZVYY8l1g84Nut7B+mKSTuDuSB1O0a7FjaCHuzkmQiGR
	QcrEvmJnsAxr9mEO5wuoMIjdUCf67SpLK2hVk2L7rJ32Rtfv30C30AkVEgeDZ+4/Yw7fS1fqDc+
	Y4gjsXjr/Aa3aB46sCR/WSUhUapwMgmsj1WMjVZjwVfWKsDfFAXjtzus=
X-Google-Smtp-Source: AGHT+IGtDybW2RjYZtHam542Fnhm7O0KLFSXDIdGVo3EPmAEEikK0ut5WEseH0hXcciYHeUjPgmu5lo2cYbOVd3M6RGnIqkky6ns
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1aaf:b0:3a6:b783:3c06 with SMTP id
 e9e14a558f8ab-3a7c55d6a17mr59406245ab.19.1732770324491; Wed, 27 Nov 2024
 21:05:24 -0800 (PST)
Date: Wed, 27 Nov 2024 21:05:24 -0800
In-Reply-To: <66f8a5f8.050a0220.aab67.000d.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6747fa14.050a0220.253251.0070.GAE@google.com>
Subject: Re: [syzbot] [net?] WARNING: locking bug in __task_rq_lock
From: syzbot <syzbot+bb50a872bcd6dacdf184@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    aaf20f870da0 Merge tag 'rpmsg-v6.13' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=152e71e8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=493f836b3188006b
dashboard link: https://syzkaller.appspot.com/bug?extid=bb50a872bcd6dacdf184
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=100f7530580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/08102d213bca/disk-aaf20f87.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/80a985df7f54/vmlinux-aaf20f87.xz
kernel image: https://storage.googleapis.com/syzbot-assets/2eccce18d2d9/bzImage-aaf20f87.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/87e2093dad2b/mount_20.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+bb50a872bcd6dacdf184@syzkaller.appspotmail.com

------------[ cut here ]------------
DEBUG_LOCKS_WARN_ON(1)
WARNING: CPU: 0 PID: 5975 at kernel/locking/lockdep.c:232 hlock_class kernel/locking/lockdep.c:232 [inline]
WARNING: CPU: 0 PID: 5975 at kernel/locking/lockdep.c:232 check_wait_context kernel/locking/lockdep.c:4850 [inline]
WARNING: CPU: 0 PID: 5975 at kernel/locking/lockdep.c:232 __lock_acquire+0x564/0x2100 kernel/locking/lockdep.c:5176
Modules linked in:
CPU: 0 UID: 0 PID: 5975 Comm: syz-executor Not tainted 6.12.0-syzkaller-10296-gaaf20f870da0 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:hlock_class kernel/locking/lockdep.c:232 [inline]
RIP: 0010:check_wait_context kernel/locking/lockdep.c:4850 [inline]
RIP: 0010:__lock_acquire+0x564/0x2100 kernel/locking/lockdep.c:5176
Code: 00 00 83 3d 41 69 ad 0e 00 75 23 90 48 c7 c7 40 d7 0a 8c 48 c7 c6 40 da 0a 8c e8 77 63 e5 ff 48 ba 00 00 00 00 00 fc ff df 90 <0f> 0b 90 90 90 31 db 48 81 c3 c4 00 00 00 48 89 d8 48 c1 e8 03 0f
RSP: 0018:ffffc90003aef890 EFLAGS: 00010046
RAX: ebff77b2920c0b00 RBX: 00000000000010d8 RCX: ffff888026515a00
RDX: dffffc0000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 00000000000c10d8 R08: ffffffff815688b2 R09: 1ffff110170c519a
R10: dffffc0000000000 R11: ffffed10170c519b R12: ffff8880265164c4
R13: 0000000000000005 R14: 1ffff11004ca2ca5 R15: ffff888026516528
FS:  000055555f6a9500(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f2be16756c0 CR3: 0000000032fe0000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
 _raw_spin_lock_nested+0x31/0x40 kernel/locking/spinlock.c:378
 raw_spin_rq_lock_nested+0x2a/0x140 kernel/sched/core.c:598
 raw_spin_rq_lock kernel/sched/sched.h:1514 [inline]
 __task_rq_lock+0xdf/0x3e0 kernel/sched/core.c:676
 wake_up_new_task+0x513/0xc70 kernel/sched/core.c:4866
 kernel_clone+0x4ee/0x8f0 kernel/fork.c:2818
 __do_sys_clone kernel/fork.c:2930 [inline]
 __se_sys_clone kernel/fork.c:2914 [inline]
 __x64_sys_clone+0x258/0x2a0 kernel/fork.c:2914
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f2be0977053
Code: 1f 84 00 00 00 00 00 64 48 8b 04 25 10 00 00 00 45 31 c0 31 d2 31 f6 bf 11 00 20 01 4c 8d 90 d0 02 00 00 b8 38 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 35 89 c2 85 c0 75 2c 64 48 8b 04 25 10 00 00
RSP: 002b:00007fffce1620e8 EFLAGS: 00000246 ORIG_RAX: 0000000000000038
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f2be0977053
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000001200011
RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000000
R10: 000055555f6a97d0 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000003cb79 R14: 000000000003cb07 R15: 00007fffce162270
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.


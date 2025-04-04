Return-Path: <netdev+bounces-179240-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97856A7B80C
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 09:02:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75C643A760D
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 07:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CE69186E40;
	Fri,  4 Apr 2025 07:02:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865CD2E62B6
	for <netdev@vger.kernel.org>; Fri,  4 Apr 2025 07:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743750145; cv=none; b=lPGOm0MTaOsdFQ7MxdwU7wSz53i47Q+tIxi8y3RNfdl3hFgIYdTmdwY073wlwnz/4KaEOBu75l1cInl32iyPAX3PBF6wXr6rSKPB/KW34rAQlhDt16H+WnW8XL4mcjc2iafXPNbeSuWbGRXoegt3QNe1FnF4F9VFWGed5WCxp1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743750145; c=relaxed/simple;
	bh=CG4w7wuAcBlHVA0LcWfHljDBiHRuBnpN7MvyZSm7Wuk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=p8AK0hXdPjMmNFH98K/LWB9U3iF/KHnKiWPKNvTkmdsYghNWKhDMXgZLqV0hIZohWVRijA6IgOy68n2shstIJdCzmOCOLPCd8sxWh+PlBwXckGM8vQvQPVJniC1yhdobM36I8E8AAMIOCiXCe+YU7ALakjIvepMRn72nBOqwdzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3d451ad5b2dso30378305ab.0
        for <netdev@vger.kernel.org>; Fri, 04 Apr 2025 00:02:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743750142; x=1744354942;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=07He3MW0nab6whk26QqMphpP5i0LVPgzc6I53O4nkPw=;
        b=eBGFBIZfOopggoxSeDUL8xWM4+SiuKJgSJHWTLc0R8JeovVWdzwinPOll6Mrhy6aID
         x68ik8/IiP/XJ1w2L94cwN5Q5J9rkRfh6EM2HcNPnjMS8dKJyYOHfuxhHL3BA9nUh2DU
         i8+bzjfLTiUQDADFyx+6lP5N1R/wqGSFSlLfFlf0UDVo+27IWe4xXnG5Ojnq+Lell4vd
         vdq1hl+NrFUmPY4iCsXVHGkhmJ+wZMIxeg98BOQODrkjTT7G+UyAIXYRmFpmqFbpEWyf
         0/UtDOp9rKOsDyk5A94lzzSkgCJtwCwUeHXBjjTudn47B447jdpHKCpHqj7/zY6Fi3ur
         uEAA==
X-Forwarded-Encrypted: i=1; AJvYcCXNgDiEC2xMQSIkNEnuQqxEgSxls+qp400MouWlBPLgQfXnDIrGOdurqJEtoZRQpbbmHSNjqw4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3t7IxD1cGcrwnprvI8jI7CTVRD/P9H/fXKwGx2vOZ0e+DEBGB
	Jj/H3RjMBdWBsHi9jOdgEwy/pSLjAbV1ulRPA7Fb+n3WyqR5h4inyyfYmT09EFnUKqWS3CXIC11
	XmY0HmM1VD2kg3CAsmrWnSLdFw3O0r3M/9u8dDa67Z/nEye+VhG9Xb6Q=
X-Google-Smtp-Source: AGHT+IEckqlCfcYHd05IAyBuG5vtuEy9BXLpfqJ6h/iWwrojXjk8qvRZ03CHc0/6ILBbo/a+6pChEclTXc1h/eTg+Wh/3384mQVZ
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cda7:0:b0:3d3:f15e:8e23 with SMTP id
 e9e14a558f8ab-3d6e40209e6mr20821955ab.10.1743750142644; Fri, 04 Apr 2025
 00:02:22 -0700 (PDT)
Date: Fri, 04 Apr 2025 00:02:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67ef83fe.050a0220.9040b.0366.GAE@google.com>
Subject: [syzbot] [perf?] WARNING in __free_event
From: syzbot <syzbot+ff3aa851d46ab82953a3@syzkaller.appspotmail.com>
To: acme@kernel.org, adrian.hunter@intel.com, 
	alexander.shishkin@linux.intel.com, edumazet@google.com, irogers@google.com, 
	jolsa@kernel.org, kan.liang@linux.intel.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mark.rutland@arm.com, mingo@redhat.com, 
	namhyung@kernel.org, netdev@vger.kernel.org, peterz@infradead.org, 
	sven@narfation.org, sw@simonwunderlich.de, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    0a87d6bb6fd2 Merge tag 'powerpc-6.15-2' of git://git.kerne..
git tree:       bpf-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1780f7b0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6631c78ce6cb228d
dashboard link: https://syzkaller.appspot.com/bug?extid=ff3aa851d46ab82953a3
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15440be4580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12295404580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e5cffcf83e28/disk-0a87d6bb.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/905e70de24af/vmlinux-0a87d6bb.xz
kernel image: https://storage.googleapis.com/syzbot-assets/5c28ed628313/bzImage-0a87d6bb.xz

The issue was bisected to:

commit 00b35530811f2aa3d7ceec2dbada80861c7632a8
Author: Eric Dumazet <edumazet@google.com>
Date:   Thu Feb 6 14:04:22 2025 +0000

    batman-adv: adopt netdev_hold() / netdev_put()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10a7e94c580000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=12a7e94c580000
console output: https://syzkaller.appspot.com/x/log.txt?x=14a7e94c580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ff3aa851d46ab82953a3@syzkaller.appspotmail.com
Fixes: 00b35530811f ("batman-adv: adopt netdev_hold() / netdev_put()")

------------[ cut here ]------------
WARNING: CPU: 1 PID: 6031 at kernel/events/core.c:5572 __free_event+0x50f/0x620 kernel/events/core.c:5572
Modules linked in:
CPU: 1 UID: 0 PID: 6031 Comm: syz-executor189 Not tainted 6.14.0-syzkaller-g0a87d6bb6fd2 #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
RIP: 0010:__free_event+0x50f/0x620 kernel/events/core.c:5572
Code: ff 48 c7 c7 a0 0c df 8e e8 6e a5 a6 ff 43 0f b6 44 25 00 84 c0 0f 85 f5 00 00 00 41 80 26 ef e9 ea fc ff ff e8 d2 46 cb ff 90 <0f> 0b 90 42 80 3c 3b 00 0f 85 2d fe ff ff e9 30 fe ff ff e8 b9 46
RSP: 0018:ffffc9000461f858 EFLAGS: 00010293
RAX: ffffffff81f8104e RBX: 1ffff110089a873c RCX: ffff88802f5dda00
RDX: 0000000000000000 RSI: 0000000000000003 RDI: 0000000000000001
RBP: 0000000000000003 R08: ffffffff81f80e1b R09: 1ffff1100fc94b45
R10: dffffc0000000000 R11: ffffed100fc94b46 R12: ffff888044d439d8
R13: ffff888044d439e0 R14: 1ffff110089a873b R15: dffffc0000000000
FS:  00007f1a7f6516c0(0000) GS:ffff888125099000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f1a7f743320 CR3: 000000003461c000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 inherit_event+0x190/0x9d0 kernel/events/core.c:14036
 inherit_group kernel/events/core.c:14110 [inline]
 inherit_task_group+0x18d/0x4f0 kernel/events/core.c:14177
 perf_event_init_context kernel/events/core.c:14226 [inline]
 perf_event_init_task+0x244/0x650 kernel/events/core.c:14295
 copy_process+0x151e/0x3d10 kernel/fork.c:2403
 kernel_clone+0x242/0x930 kernel/fork.c:2844
 __do_sys_clone kernel/fork.c:2987 [inline]
 __se_sys_clone kernel/fork.c:2971 [inline]
 __x64_sys_clone+0x268/0x2e0 kernel/fork.c:2971
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f1a7f6b98d9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 51 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f1a7f651218 EFLAGS: 00000246 ORIG_RAX: 0000000000000038
RAX: ffffffffffffffda RBX: 00007f1a7f743338 RCX: 00007f1a7f6b98d9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00000000ab009400
RBP: 00007f1a7f743330 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f1a7f710a94
R13: affffff7ffffffff R14: 0000200000000180 R15: 00000000ab009400
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

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


Return-Path: <netdev+bounces-184601-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CACD8A96585
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 12:11:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F6E9189D104
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 10:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7826A20D4F8;
	Tue, 22 Apr 2025 10:11:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E59D20127B
	for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 10:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745316696; cv=none; b=sKRe8DZPRcGNHYL3r3yHIIvDiWBrsc5rLA6XMvNobpRn4IwWtZk2ZHSat+i5OSmAFGQOk6xUTxpwJmKAgcX8oCHcv+wGOGOZceQgoNV2qL7dHU8vINCLuGS33Hu5JyB9vJdYRQcZt6861fYEBSplqQp8mkZE4Q3rU1IqK7sU0v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745316696; c=relaxed/simple;
	bh=WaKKNEuKDPmZOzv6aZI1owMr7y/Dfzsic8d9h2X33M0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=LoZv6rukJljQ/2Ws/KkiWNg7hDoUbAZFLXtBUpC8jtkvd53UlfTMZTcaaqK0HZ7x7d15reMSwzV6k9m/KAuIMY412TN4iAnp5C+Z0nSIeXO4J/lYhTCMmjzUD2+R9EkdYeNoUMKcEeh8+p0JWBYJwM+e3JTe/nlnfeYDMeJ638A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3d43d333855so40291825ab.0
        for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 03:11:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745316693; x=1745921493;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5aTGGX+NXErHRqVcGZvVAq3Xt0wsmBKBdz9lxioJNqw=;
        b=UmSWz3jaoGpHkWauIMda8QS6svmaJNhGm2T30gJDsFuAcFxE2vvRc7VdoEDoLbKAY1
         TL4yfZNjOreDnsY/Qwn5FpE2G7szqWISZj1l6f9RIg3L2scx6clFC35S2fNtfXN5WUIt
         eXNp9R3qrViIT2uurdNbldTz+Lh5qThZEWZQJ3lUGIm+DkM95Dvzfatx1Zqga6lFwwfP
         C966hp0wpqyzxpPvI7rXfAxHzPvUv2ytkD/ruF1IymHd7F6exOAnmpaRPN9rg8d94bpc
         bNvg0CDqtbEAMX2iHoqyPBXFg4LrpY6xnSnmWuy9ZpJs7DC4QlVhT/ZyHNtzjLyjelXk
         GfCw==
X-Forwarded-Encrypted: i=1; AJvYcCX95RfNuzcKKT8uMCF7QyRA83ZD3Zs9KPq5dtbIGU5dNUg53286GMWB1RFqbD1L9Cnw1Af7vIA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkfGv6+BATLe6HK6im2cdREP14YnKf/VpnHQs9D5JgIvPuE2Ec
	2UIS2crn9d2PyhY/1PwU1Rrn8LIX+qzjNQXXKknoj643rPrMRLHM7nq4tcNm5QEUUj7hOZ+9AmJ
	pDrBqUi7qoQFdRFT707s7J3s38SvqMibzlZcZiewBFAn26Dotzsy5UQQ=
X-Google-Smtp-Source: AGHT+IEkm/2I2kcO4o+iOW299zCLJ2uC4HY4zRS+je2FQfOcO5b6H8rAl6Q5PuNVUF6Kz8E4Y97HOY3AZ2TTv/CZDEcgn/5VaP0f
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1522:b0:3d6:d18b:868c with SMTP id
 e9e14a558f8ab-3d88eda86f8mr115750605ab.10.1745316693258; Tue, 22 Apr 2025
 03:11:33 -0700 (PDT)
Date: Tue, 22 Apr 2025 03:11:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68076b55.050a0220.8500a.0003.GAE@google.com>
Subject: [syzbot] [kernel?] BUG: soft lockup in garp_join_timer (3)
From: syzbot <syzbot+7abdcd4c733ccab0d31a@syzkaller.appspotmail.com>
To: Jason@zx2c4.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    a27a97f71394 Merge branch 'bpf-support-atomic-update-for-h..
git tree:       bpf-next
console output: https://syzkaller.appspot.com/x/log.txt?x=12b9e0cc580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f2054704dd53fb80
dashboard link: https://syzkaller.appspot.com/bug?extid=7abdcd4c733ccab0d31a
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/32a35fb59089/disk-a27a97f7.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/618c1dff8a1c/vmlinux-a27a97f7.xz
kernel image: https://storage.googleapis.com/syzbot-assets/41554819c2b9/bzImage-a27a97f7.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7abdcd4c733ccab0d31a@syzkaller.appspotmail.com

watchdog: BUG: soft lockup - CPU#0 stuck for 143s! [syz.3.67:6175]
Modules linked in:
irq event stamp: 24646117
hardirqs last  enabled at (24646116): [<ffffffff8c303183>] irqentry_exit+0x63/0x90 kernel/entry/common.c:357
hardirqs last disabled at (24646117): [<ffffffff8c300cce>] sysvec_apic_timer_interrupt+0xe/0xc0 arch/x86/kernel/apic/apic.c:1049
softirqs last  enabled at (23795144): [<ffffffff81844b9b>] __do_softirq kernel/softirq.c:613 [inline]
softirqs last  enabled at (23795144): [<ffffffff81844b9b>] invoke_softirq kernel/softirq.c:453 [inline]
softirqs last  enabled at (23795144): [<ffffffff81844b9b>] __irq_exit_rcu+0xfb/0x220 kernel/softirq.c:680
softirqs last disabled at (23795147): [<ffffffff81844b9b>] __do_softirq kernel/softirq.c:613 [inline]
softirqs last disabled at (23795147): [<ffffffff81844b9b>] invoke_softirq kernel/softirq.c:453 [inline]
softirqs last disabled at (23795147): [<ffffffff81844b9b>] __irq_exit_rcu+0xfb/0x220 kernel/softirq.c:680
CPU: 0 UID: 0 PID: 6175 Comm: syz.3.67 Not tainted 6.14.0-syzkaller-ga27a97f71394 #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
RIP: 0010:get_random_u32+0x56a/0xab0 arch/x86/include/asm/irqflags.h:-1
Code: 00 00 e8 d9 d8 28 fc 49 c7 c6 20 90 68 93 48 8b 5c 24 20 4d 85 ff 75 07 e8 c3 d8 28 fc eb 06 e8 bc d8 28 fc fb 48 8b 44 24 28 <42> 0f b6 04 28 84 c0 0f 85 92 01 00 00 8b 84 24 00 01 00 00 48 c7
RSP: 0018:ffffc900000079a0 EFLAGS: 00000246
RAX: 1ffff92000000f54 RBX: 1ffff92000000f3c RCX: ffff88802a5f1e00
RDX: 0000000000000100 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc90000007b20 R08: ffffffff859a7e99 R09: 1ffffffff20bf9ee
R10: dffffc0000000000 R11: fffffbfff20bf9ef R12: 1ffff110170c6bd5
R13: dffffc0000000000 R14: ffffffff93689020 R15: 0000000000000200
FS:  00007f88c01f66c0(0000) GS:ffff888124f97000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 00000000297de000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 __get_random_u32_below+0x14/0x90 drivers/char/random.c:567
 get_random_u32_below include/linux/random.h:63 [inline]
 garp_join_timer_arm net/802/garp.c:411 [inline]
 garp_join_timer+0xd5/0x120 net/802/garp.c:425
 call_timer_fn+0x189/0x650 kernel/time/timer.c:1789
 expire_timers kernel/time/timer.c:1840 [inline]
 __run_timers kernel/time/timer.c:2414 [inline]
 __run_timer_base+0x66e/0x8e0 kernel/time/timer.c:2426
 run_timer_base kernel/time/timer.c:2435 [inline]
 run_timer_softirq+0xb7/0x170 kernel/time/timer.c:2445
 handle_softirqs+0x2d6/0x9b0 kernel/softirq.c:579
 __do_softirq kernel/softirq.c:613 [inline]
 invoke_softirq kernel/softirq.c:453 [inline]
 __irq_exit_rcu+0xfb/0x220 kernel/softirq.c:680
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:696
 instr_sysvec_irq_work arch/x86/kernel/irq_work.c:17 [inline]
 sysvec_irq_work+0xa3/0xc0 arch/x86/kernel/irq_work.c:17
 </IRQ>
 <TASK>
 asm_sysvec_irq_work+0x1a/0x20 arch/x86/include/asm/idtentry.h:738
RIP: 0010:rcu_read_unlock_special+0x8a/0x570 kernel/rcu/tree_plugin.h:694
Code: f1 f1 f1 00 f2 f2 f2 49 89 04 14 66 41 c7 44 14 09 f3 f3 41 c6 44 14 0b f3 65 44 8b 3d 3f 0c bf 11 41 f7 c7 00 00 f0 00 74 44 <48> c7 44 24 20 0e 36 e0 45 4a c7 04 22 00 00 00 00 66 42 c7 44 22
RSP: 0018:ffffc9000b4af420 EFLAGS: 00000206
RAX: 15e49cbcfd192300 RBX: 1ffff92001695e8c RCX: ffffffff93689020
RDX: dffffc0000000000 RSI: ffffffff8e69b349 RDI: ffffffff8ca1b0e0
RBP: ffffc9000b4af4f8 R08: ffffffff905fcf77 R09: 1ffffffff20bf9ee
R10: dffffc0000000000 R11: fffffbfff20bf9ef R12: 1ffff92001695e88
R13: ffff88802a5f2260 R14: ffffc9000b4af460 R15: 0000000000000000
 __rcu_read_unlock+0xa1/0x110 kernel/rcu/tree_plugin.h:438
 rcu_read_unlock include/linux/rcupdate.h:873 [inline]
 d_alloc_parallel+0x134c/0x1660 fs/dcache.c:2614
 __lookup_slow+0x127/0x400 fs/namei.c:1792
 lookup_slow+0x53/0x70 fs/namei.c:1824
 walk_component fs/namei.c:2128 [inline]
 link_path_walk+0x969/0xeb0 fs/namei.c:2493
 path_openat+0x26d/0x35d0 fs/namei.c:4000
 do_filp_open+0x284/0x4e0 fs/namei.c:4031
 do_sys_openat2+0x12b/0x1d0 fs/open.c:1429
 do_sys_open fs/open.c:1444 [inline]
 __do_sys_openat fs/open.c:1460 [inline]
 __se_sys_openat fs/open.c:1455 [inline]
 __x64_sys_openat+0x249/0x2a0 fs/open.c:1455
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f88c238cad0
Code: 48 89 44 24 20 75 93 44 89 54 24 0c e8 49 94 02 00 44 8b 54 24 0c 89 da 48 89 ee 41 89 c0 bf 9c ff ff ff b8 01 01 00 00 0f 05 <48> 3d 00 f0 ff ff 77 38 44 89 c7 89 44 24 0c e8 9c 94 02 00 8b 44
RSP: 002b:00007f88c01f5f10 EFLAGS: 00000293 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f88c238cad0
RDX: 0000000000000002 RSI: 00007f88c01f5fa0 RDI: 00000000ffffff9c
RBP: 00007f88c01f5fa0 R08: 0000000000000000 R09: 00007f88c01f5cd6
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f88c25b6080 R15: 00007fffa89738a8
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 6198 Comm: kworker/u8:9 Not tainted 6.14.0-syzkaller-ga27a97f71394 #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
Workqueue: events_unbound toggle_allocation_gate
RIP: 0010:csd_lock_wait kernel/smp.c:340 [inline]
RIP: 0010:smp_call_function_many_cond+0x1bac/0x2d40 kernel/smp.c:885
Code: 03 84 c0 75 7e 45 8b 65 00 44 89 e6 83 e6 01 31 ff e8 c8 e2 0b 00 41 83 e4 01 4c 8b 64 24 68 75 07 e8 78 de 0b 00 eb 41 f3 90 <48> b8 00 00 00 00 00 fc ff df 0f b6 04 03 84 c0 75 11 41 f7 45 00
RSP: 0018:ffffc9000be67640 EFLAGS: 00000293
RAX: ffffffff81b7792d RBX: 1ffff110170c823d RCX: ffff888078c83c00
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffffc9000be67840 R08: ffffffff81b778f8 R09: 1ffffffff20bf9ee
R10: dffffc0000000000 R11: fffffbfff20bf9ef R12: ffff8880b873ad08
R13: ffff8880b86411e8 R14: ffff8880b873ad00 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff888125097000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f0290db6038 CR3: 000000000eb38000 CR4: 00000000003526f0
DR0: 0000200000000300 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000600
Call Trace:
 <TASK>
 on_each_cpu_cond_mask+0x3f/0x80 kernel/smp.c:1052
 on_each_cpu include/linux/smp.h:71 [inline]
 text_poke_sync arch/x86/kernel/alternative.c:2455 [inline]
 text_poke_bp_batch+0x354/0xb30 arch/x86/kernel/alternative.c:2665
 text_poke_flush arch/x86/kernel/alternative.c:2856 [inline]
 text_poke_finish+0x30/0x50 arch/x86/kernel/alternative.c:2863
 arch_jump_label_transform_apply+0x1c/0x30 arch/x86/kernel/jump_label.c:146
 static_key_enable_cpuslocked+0x136/0x260 kernel/jump_label.c:210
 static_key_enable+0x1a/0x20 kernel/jump_label.c:223
 toggle_allocation_gate+0xc0/0x250 mm/kfence/core.c:850
 process_one_work kernel/workqueue.c:3238 [inline]
 process_scheduled_works+0xac3/0x18e0 kernel/workqueue.c:3319
 worker_thread+0x870/0xd50 kernel/workqueue.c:3400
 kthread+0x7b7/0x940 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:153
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
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


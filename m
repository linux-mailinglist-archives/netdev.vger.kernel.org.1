Return-Path: <netdev+bounces-184977-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7B14A97E45
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 07:48:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6954B3B8BBE
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 05:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDF9726462C;
	Wed, 23 Apr 2025 05:48:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED063EAFA
	for <netdev@vger.kernel.org>; Wed, 23 Apr 2025 05:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745387313; cv=none; b=YmjMLyaR+6PmWEV25HQe30qYwL4J1mjq2c+BzfED+MUKkJhB9/WVe+KUJlyL3uumDfJzM0Lqo9Zx1E2COE9IUkneQuUko7IIXoLsU0UIW7RLk5rdRKLX82D3br64zL5zxHYGZI37v1CB5990n7rQBFaq1Rm4Mcc6BWV+jqCQ7D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745387313; c=relaxed/simple;
	bh=XcQ5NhAIJN4wYiAb2WDhmD0U+8TmjYr3rQ90Il5GCEM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=QSbnbxo55QTObjEq04XCQYZQhHTh6chvcGdggo7dNm9Jwf6SkuXJcyyuiVTAoGr2zKPG8ve4C6aOdraNvJArKfvMwDwIE2opNN1oMp/ObTjJDHvNDi/UrW0W0tonoerRoZ9u4sQ/hQW86Re0FQ4eMbaL3JMUFiw3Z0S/gBimuAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-85b5a7981ccso591485739f.2
        for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 22:48:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745387311; x=1745992111;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ePwokrCwfYXbJamS92ltAp7Pt4qv714YRPuYLyYHtIY=;
        b=GMv4uFmvrZ64iNU6/Hu8WsI1OgHdaBirMrHfvIkYzHJeDMAbSCRu7WVbZRlu2ETjPR
         Z6WPNHjAet/N8rwt8vKWHxWb1sfdth+SZPy1zd1as+hbBfepUm35tEdJ569D1dLJ10nV
         rfDeZleYO4FBy7iDL0ayCslrN/B6wQDOOwbMcHcQf7iUa68DDzx+e4JzYydaXxjtVIBG
         UyZqTUJaikaw9jR9bZMXcc44RfA6Keqb0BoTfxSvCa69lawwgJy+QbkKzWQxZJVZGtb8
         WYLophKNSMNx0F5gNnJQSGoRKiJVbkiG0gCGtUteR6YRbUR1Of07LvXaptb/+BQTM5gE
         i9Vg==
X-Forwarded-Encrypted: i=1; AJvYcCU1bWHuxK3Lg9UGvE+fm9RxfZuZhATpEitSMC7yKKpo6OOR27kbooWWOmOxHjQiZz3XT/iEw2g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg/5Ua27rSP+JF1Erxi/ZEDXQ3SC+mlEdkc5bjnpq0kIxt2RWu
	gYscw8985Xzgl7AA3GPJ0LhHQCoOaVIwXr8LR6XATH/7UT3PDJly37wIkNp9XrcdXw6EUtnRmdN
	hbArZHrNU2q3mMI7r2f+C6NGL6qEg+my83vUD0WW0LdJ3RMITRK0wd28=
X-Google-Smtp-Source: AGHT+IGp0L9IyqLb8+gccSqBchLzGwP3ya/bGgekxV+WpTufmNjkcIY6SMDGhpmpO+67Z/Gv/iv8Ni7PztLtF2QoRZS20rijTnbp
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2683:b0:3d8:1ea5:26d1 with SMTP id
 e9e14a558f8ab-3d89417e663mr204775465ab.18.1745387311091; Tue, 22 Apr 2025
 22:48:31 -0700 (PDT)
Date: Tue, 22 Apr 2025 22:48:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68087f2f.050a0220.dd94f.0177.GAE@google.com>
Subject: [syzbot] [kernel?] BUG: soft lockup in sys_bpf
From: syzbot <syzbot+9431dc0c0741cff46a99@syzkaller.appspotmail.com>
To: da.gomez@samsung.com, linux-kernel@vger.kernel.org, 
	linux-modules@vger.kernel.org, mcgrof@kernel.org, netdev@vger.kernel.org, 
	petr.pavlu@suse.com, samitolvanen@google.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    82303a059aab selftests/bpf: Mitigate sockmap_ktls disconne..
git tree:       bpf
console output: https://syzkaller.appspot.com/x/log.txt?x=17564c70580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2a31f7155996562
dashboard link: https://syzkaller.appspot.com/bug?extid=9431dc0c0741cff46a99
compiler:       Debian clang version 15.0.6, Debian LLD 15.0.6

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d30894ea99be/disk-82303a05.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1bda5ab405eb/vmlinux-82303a05.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a72bda7bfe37/bzImage-82303a05.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9431dc0c0741cff46a99@syzkaller.appspotmail.com

watchdog: BUG: soft lockup - CPU#0 stuck for 121s! [syz.1.81:6189]
Modules linked in:
irq event stamp: 14904795
hardirqs last  enabled at (14904794): [<ffffffff8c2f9183>] irqentry_exit+0x63/0x90 kernel/entry/common.c:357
hardirqs last disabled at (14904795): [<ffffffff8c2f6cce>] sysvec_apic_timer_interrupt+0xe/0xc0 arch/x86/kernel/apic/apic.c:1049
softirqs last  enabled at (14484656): [<ffffffff8183e65b>] __do_softirq kernel/softirq.c:613 [inline]
softirqs last  enabled at (14484656): [<ffffffff8183e65b>] invoke_softirq kernel/softirq.c:453 [inline]
softirqs last  enabled at (14484656): [<ffffffff8183e65b>] __irq_exit_rcu+0xfb/0x220 kernel/softirq.c:680
softirqs last disabled at (14484659): [<ffffffff8183e65b>] __do_softirq kernel/softirq.c:613 [inline]
softirqs last disabled at (14484659): [<ffffffff8183e65b>] invoke_softirq kernel/softirq.c:453 [inline]
softirqs last disabled at (14484659): [<ffffffff8183e65b>] __irq_exit_rcu+0xfb/0x220 kernel/softirq.c:680
CPU: 0 UID: 0 PID: 6189 Comm: syz.1.81 Not tainted 6.15.0-rc2-syzkaller-g82303a059aab #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
RIP: 0010:rcu_read_unlock_special+0x8a/0x570 kernel/rcu/tree_plugin.h:694
Code: f1 f1 f1 00 f2 f2 f2 49 89 04 14 66 41 c7 44 14 09 f3 f3 41 c6 44 14 0b f3 65 44 8b 3d ff 64 bf 11 41 f7 c7 00 00 f0 00 74 44 <48> c7 44 24 20 0e 36 e0 45 4a c7 04 22 00 00 00 00 66 42 c7 44 22
RSP: 0018:ffffc900000075e0 EFLAGS: 00000206
RAX: 55191fd20a5a7300 RBX: 1ffff92000000ec4 RCX: ffffffff93686020
RDX: dffffc0000000000 RSI: ffffffff8e6491c3 RDI: ffffffff8ca1b5a0
RBP: ffffc900000076b0 R08: ffffffff905fe077 R09: 1ffffffff20bfc0e
R10: dffffc0000000000 R11: fffffbfff20bfc0f R12: 1ffff92000000ec0
R13: ffff8880273fa260 R14: ffffc90000007620 R15: ffffffff8ed42d00
FS:  00007f0773a326c0(0000) GS:ffff888124f9a000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f716f6ddb10 CR3: 00000000328a4000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000600
Call Trace:
 <IRQ>
 __rcu_read_unlock+0xa1/0x110 kernel/rcu/tree_plugin.h:438
 rcu_read_unlock include/linux/rcupdate.h:873 [inline]
 class_rcu_destructor include/linux/rcupdate.h:1155 [inline]
 is_module_text_address+0x199/0x1f0 kernel/module/main.c:3745
 kernel_text_address+0x96/0xe0 kernel/extable.c:119
 __kernel_text_address+0xd/0x40 kernel/extable.c:79
 unwind_get_return_address+0x4d/0x90 arch/x86/kernel/unwind_orc.c:369
 arch_stack_walk+0xff/0x150 arch/x86/kernel/stacktrace.c:26
 stack_trace_save+0x11a/0x1d0 kernel/stacktrace.c:122
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:576
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x59/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2389 [inline]
 slab_free mm/slub.c:4646 [inline]
 kmem_cache_free+0x197/0x410 mm/slub.c:4748
 rcu_do_batch kernel/rcu/tree.c:2568 [inline]
 rcu_core+0xaac/0x17a0 kernel/rcu/tree.c:2824
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
RIP: 0010:schedule_debug kernel/sched/core.c:5948 [inline]
RIP: 0010:__schedule+0x1c8/0x5240 kernel/sched/core.c:6666
Code: 48 89 df e8 6a 97 fc f5 48 8b 1b 48 89 d8 48 c1 e8 03 48 b9 00 00 00 00 00 fc ff df 80 3c 08 00 74 08 48 89 df e8 48 97 fc f5 <48> 81 3b 9d 6e ac 57 0f 85 3a 23 00 00 83 7c 24 48 00 7f 5e 48 8b
RSP: 0018:ffffc9000bd4ebc0 EFLAGS: 00010246
RAX: 1ffff920017a9000 RBX: ffffc9000bd48000 RCX: dffffc0000000000
RDX: 0000000000000000 RSI: ffffffff8ca1b580 RDI: ffffffff8ca1b540
RBP: ffffc9000bd4edf0 R08: ffffffff905fe077 R09: 1ffffffff20bfc0e
R10: dffffc0000000000 R11: fffffbfff20bfc0f R12: ffff888124f9a000
R13: 1ffff920017a9dc0 R14: ffff8880b863a600 R15: ffffc9000bd4ee20
 preempt_schedule_irq+0xfe/0x1c0 kernel/sched/core.c:7090
 irqentry_exit+0x5e/0x90 kernel/entry/common.c:354
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:put_cpu_partial+0x1b8/0x250 mm/slub.c:3263
Code: 0f 85 b4 00 00 00 48 83 c4 20 5b 41 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc e8 c4 7e 0d 0a f7 c3 00 02 00 00 74 ba fb 4d 85 e4 <75> b9 eb c2 90 e8 4e 79 de 02 85 c0 74 22 83 3d f7 0b 3e 0e 00 75
RSP: 0018:ffffc9000bd4ef78 EFLAGS: 00000246
RAX: 55191fd20a5a7300 RBX: 0000000000000286 RCX: 0000000000000007
RDX: 0000000000000007 RSI: ffffffff8e6491c3 RDI: ffffffff8ca1b5a0
RBP: 0000000000000000 R08: ffffffff905fe077 R09: 1ffffffff20bfc0e
R10: dffffc0000000000 R11: fffffbfff20bfc0f R12: 0000000000000000
R13: ffffea0001fbc800 R14: ffff8880273f9e00 R15: ffff8881416deb40
 __slab_free+0x294/0x390 mm/slub.c:4516
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x9a/0x140 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x14f/0x170 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x23/0x80 mm/kasan/common.c:329
 kasan_slab_alloc include/linux/kasan.h:250 [inline]
 slab_post_alloc_hook mm/slub.c:4151 [inline]
 slab_alloc_node mm/slub.c:4200 [inline]
 __do_kmalloc_node mm/slub.c:4330 [inline]
 __kvmalloc_node_noprof+0x2ca/0x5a0 mm/slub.c:5016
 kvmalloc_array_node_noprof include/linux/slab.h:1065 [inline]
 bpf_check+0x1003/0x1d1c0 kernel/bpf/verifier.c:23980
 bpf_prog_load+0x17ee/0x2250 kernel/bpf/syscall.c:2971
 __sys_bpf+0x5dd/0x8b0 kernel/bpf/syscall.c:5834
 __do_sys_bpf kernel/bpf/syscall.c:5941 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5939 [inline]
 __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5939
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xf3/0x210 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f0772b8e169
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f0773a32038 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 00007f0772db5fa0 RCX: 00007f0772b8e169
RDX: 0000000000000094 RSI: 0000200000000600 RDI: 0000000000000005
RBP: 00007f0772c10a68 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f0772db5fa0 R15: 00007ffd8a0181a8
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 6163 Comm: syz.4.73 Not tainted 6.15.0-rc2-syzkaller-g82303a059aab #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
RIP: 0010:arch_stack_walk+0x116/0x150 arch/x86/kernel/stacktrace.c:25
Code: ff 00 74 37 48 8d 9d 70 ff ff ff 48 89 df e8 61 bf 09 00 48 85 c0 74 23 4c 89 f7 48 89 c6 4d 89 eb 41 ff d3 66 90 84 c0 74 11 <48> 89 df e8 92 c0 09 00 83 bd 70 ff ff ff 00 75 d0 48 8d 05 92 85
RSP: 0018:ffffc90000a083a0 EFLAGS: 00000202
RAX: 0000000000000001 RBX: ffffc90000a083a0 RCX: ffffffff91bfa000
RDX: dffffc0000000000 RSI: ffffffff8183e65b RDI: ffffc90000a0848c
RBP: ffffc90000a08430 R08: 000000000000000f R09: ffffc90000a08490
R10: ffffc90000a07ec8 R11: ffffffff81ae60f0 R12: ffff888026059e00
R13: ffffffff81ae60f0 R14: ffffc90000a08480 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff88812509a000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fd8e51b6038 CR3: 00000000329b8000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000600
Call Trace:
 <IRQ>
 stack_trace_save+0x11a/0x1d0 kernel/stacktrace.c:122
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 unpoison_slab_object mm/kasan/common.c:319 [inline]
 __kasan_slab_alloc+0x66/0x80 mm/kasan/common.c:345
 kasan_slab_alloc include/linux/kasan.h:250 [inline]
 slab_post_alloc_hook mm/slub.c:4151 [inline]
 slab_alloc_node mm/slub.c:4200 [inline]
 kmem_cache_alloc_node_noprof+0x1f2/0x3b0 mm/slub.c:4252
 kmalloc_reserve+0xa8/0x2a0 net/core/skbuff.c:577
 __alloc_skb+0x1f2/0x480 net/core/skbuff.c:668
 __netdev_alloc_skb+0x105/0xa10 net/core/skbuff.c:732
 netdev_alloc_skb include/linux/skbuff.h:3413 [inline]
 dev_alloc_skb include/linux/skbuff.h:3426 [inline]
 __ieee80211_beacon_get+0x9a7/0x15e0 net/mac80211/tx.c:5475
 ieee80211_beacon_get_tim+0xb7/0x330 net/mac80211/tx.c:5597
 ieee80211_beacon_get include/net/mac80211.h:5648 [inline]
 mac80211_hwsim_beacon_tx+0x3a2/0x860 drivers/net/wireless/virtual/mac80211_hwsim.c:2313
 __iterate_interfaces+0x297/0x570 net/mac80211/util.c:761
 ieee80211_iterate_active_interfaces_atomic+0xd8/0x170 net/mac80211/util.c:797
 mac80211_hwsim_beacon+0xd4/0x1f0 drivers/net/wireless/virtual/mac80211_hwsim.c:2347
 __run_hrtimer kernel/time/hrtimer.c:1761 [inline]
 __hrtimer_run_queues+0x5a6/0xd40 kernel/time/hrtimer.c:1825
 hrtimer_run_softirq+0x19a/0x2c0 kernel/time/hrtimer.c:1842
 handle_softirqs+0x2d6/0x9b0 kernel/softirq.c:579
 __do_softirq kernel/softirq.c:613 [inline]
 invoke_softirq kernel/softirq.c:453 [inline]
 __irq_exit_rcu+0xfb/0x220 kernel/softirq.c:680
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:696
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1049 [inline]
 sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1049
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:hlist_empty include/linux/list.h:972 [inline]
RIP: 0010:do_perf_trace_lock include/trace/events/lock.h:50 [inline]
RIP: 0010:perf_trace_lock+0x1b4/0x4a0 include/trace/events/lock.h:50
Code: 48 89 df e8 de 5b 8f 00 48 83 3b 00 48 8d 9c 24 80 00 00 00 75 2b 49 89 de 48 8b 5c 24 20 48 89 d8 48 c1 e8 03 42 80 3c 20 00 <74> 08 48 89 df e8 b2 5b 8f 00 48 83 3b 00 4c 89 f3 0f 84 d5 01 00
RSP: 0018:ffffc9000b7df000 EFLAGS: 00000246
RAX: 1ffffd1ffffa47c7 RBX: ffffe8ffffd23e38 RCX: ffffe8ffffd23e38
RDX: ffffffff8238de96 RSI: ffffffff8ca1b580 RDI: ffffffff8ca1b540
RBP: ffffc9000b7df118 R08: ffffffff8238e112 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: dffffc0000000000
R13: ffffffff8ec0d1a0 R14: ffffc9000b7df080 R15: ffffffff93686020
 __do_trace_lock_release include/trace/events/lock.h:69 [inline]
 trace_lock_release include/trace/events/lock.h:69 [inline]
 lock_release+0x3b4/0x3e0 kernel/locking/lockdep.c:5877
 rcu_lock_release include/linux/rcupdate.h:341 [inline]
 rcu_read_unlock_sched include/linux/rcupdate.h:953 [inline]
 pfn_valid+0x3eb/0x450 include/linux/mmzone.h:2126
 page_table_check_clear+0x21/0x6f0 mm/page_table_check.c:70
 ptep_get_and_clear_full arch/x86/include/asm/jump_label.h:-1 [inline]
 get_and_clear_full_ptes include/linux/pgtable.h:714 [inline]
 zap_present_folio_ptes mm/memory.c:1501 [inline]
 zap_present_ptes mm/memory.c:1586 [inline]
 do_zap_pte_range mm/memory.c:1687 [inline]
 zap_pte_range mm/memory.c:1731 [inline]
 zap_pmd_range mm/memory.c:1823 [inline]
 zap_pud_range mm/memory.c:1852 [inline]
 zap_p4d_range mm/memory.c:1873 [inline]
 unmap_page_range+0x33cf/0x44d0 mm/memory.c:1894
 unmap_vmas+0x3ce/0x5f0 mm/memory.c:1984
 exit_mmap+0x2bc/0xde0 mm/mmap.c:1284
 __mmput+0x115/0x420 kernel/fork.c:1379
 exit_mm+0x221/0x310 kernel/exit.c:589
 do_exit+0x994/0x27f0 kernel/exit.c:940
 do_group_exit+0x207/0x2c0 kernel/exit.c:1102
 get_signal+0x1696/0x1730 kernel/signal.c:3034
 arch_do_signal_or_restart+0x98/0x810 arch/x86/kernel/signal.c:337
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:329 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0xce/0x340 kernel/entry/common.c:218
 do_syscall_64+0x100/0x210 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7efc80f8e169
Code: Unable to access opcode bytes at 0x7efc80f8e13f.
RSP: 002b:00007efc81d55038 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: 000000000000000b RBX: 00007efc811b5fa0 RCX: 00007efc80f8e169
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000020
RBP: 00007efc81010a68 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007efc811b5fa0 R15: 00007ffde51fb1a8
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


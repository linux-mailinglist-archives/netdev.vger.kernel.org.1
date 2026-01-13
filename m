Return-Path: <netdev+bounces-249521-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DCD1D1A6C2
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 17:53:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B2B00300453D
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 16:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29D8334D91B;
	Tue, 13 Jan 2026 16:49:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f79.google.com (mail-oo1-f79.google.com [209.85.161.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE352571C5
	for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 16:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768322975; cv=none; b=PTEEL3UPECPi/AndKvyABRr+WZL2GRgcDo6VfdWl9NyvHkQZib1t6x0SiVYIz+d5c0oDtI5da3z5uPoKnTsfwSTWjCNL/TROhCprpsnII/7UfP/E4gxZjyPsTZsCfz+Z85Ozi0pZ5hgRv9Qk+jMagmDcOvxjOBCYfzOibOpUtrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768322975; c=relaxed/simple;
	bh=JKV6GmAoHH6oMG9RtZl5ikrn+qQp/xRkZ93O5+SeUjA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=uHMd0aAtKZid8ldLuSsvMd+YS4dJEJJ3VJvhGac8Xx4A0PJnbnGqY/y2msq23mb1/Qr4ryVnqT2n2seeyZ7SyY82PCJ2mz+/StYhcqO0h/fCzkmg0FKiMSQuqUzepbBGgGyyV8iZzpFIPHs+yX3hZdndicq2DatWKxPNZv2rJtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f79.google.com with SMTP id 006d021491bc7-6574475208eso8597280eaf.3
        for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 08:49:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768322972; x=1768927772;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s9l8oU/c63XdGQ4bmpll3fc4/YEXsaRrmbMS6OocjtA=;
        b=bZTb8EkCHdew5ED8mbjhg6q57Cx0GCukhY5FN6XLnzAqXCwXcAWp9i+LVAVSBT2MUB
         C/1hSOut2YJmT86SWhThqkhJ6tc0HCshluzNfIWzQlMwhQOUYTHQ20TayMM5JhX+/mu8
         l/Js5nAaMY1yCFKBm68ndbrdIYvm4v5RX7HL8ovONAnYMZwnJZsDAD/VKDH5msaFnwQs
         3CdEJdK1QUNLbHIdsGvTBfhW0+sorblSd6P5IDGkDYrB4yb2ArCDBQ/da9meWD35J8Nc
         SviSUqmlyiRsJx3z0psd0gJWj02IHVfSLqfRiWFcoAmyFrWwUBdhbzmigyCOJasA7NBe
         uBiw==
X-Forwarded-Encrypted: i=1; AJvYcCVwe/OHt3kq6l0fBZIV9g+9xe1T5B1s6v87EI+RQk7+wUtaHPD6w8DyqHCZRNu/pBvKvJT2lOA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOa/DiaxW4x7cZap82i2wekcVa5GwzS88VbDAi3L5VPgFVR4xZ
	aJiYJBsHxM9fticTaP34XCAJrD61SOtO1pt2qz27bFti0jBI4gjIwR+COHFamTmjpS4Cvj086p4
	HhlW7WpltkGhHyt9WvYO6X1X7GmaGTLp7IQDj5KwfPRvKfkhC4AxucSoKEX4=
X-Google-Smtp-Source: AGHT+IEe/slWVvl0T454EGqu8WlPgYqlIICpSF4oVyCGrhUTsIMlkv0ggB+FG4mhkY906wm3GJ8Yk+twQIkabsYOF//ltoNzLnrG
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:a1a5:b0:65f:6df9:215f with SMTP id
 006d021491bc7-65f6df92832mr3738213eaf.32.1768322972506; Tue, 13 Jan 2026
 08:49:32 -0800 (PST)
Date: Tue, 13 Jan 2026 08:49:32 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6966779c.050a0220.1a12f3.09f0.GAE@google.com>
Subject: [syzbot] [kernfs?] INFO: rcu detected stall in cleanup_net (8)
From: syzbot <syzbot+0604401cc084920f6c3d@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	gregkh@linuxfoundation.org, horms@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    008d3547aae5 Add linux-next specific files for 20251210
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=147c3a1a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a94030c847137a18
dashboard link: https://syzkaller.appspot.com/bug?extid=0604401cc084920f6c3d
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13f9deb4580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1406b992580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f5497242418d/disk-008d3547.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/46fd6edd4284/vmlinux-008d3547.xz
kernel image: https://storage.googleapis.com/syzbot-assets/61e6e2e573e8/bzImage-008d3547.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0604401cc084920f6c3d@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 	Tasks blocked on level-0 rcu_node (CPUs 0-1): P5930/1:b..l
rcu: 	(detected by 1, t=10502 jiffies, g=11645, q=51 ncpus=2)
task:kworker/u8:12   state:R  running task     stack:22432 pid:5930  tgid:5930  ppid:2      task_flags:0x4208060 flags:0x00080000
Workqueue: netns cleanup_net
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5256 [inline]
 __schedule+0x14bc/0x5000 kernel/sched/core.c:6863
 preempt_schedule_irq+0xb5/0x150 kernel/sched/core.c:7190
 irqentry_exit+0x5d8/0x660 kernel/entry/common.c:216
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:697
RIP: 0010:rcu_is_watching+0x67/0xb0 kernel/rcu/tree.c:752
Code: 89 f7 e8 0c 71 80 00 48 c7 c3 d8 f6 7f 92 49 03 1e 48 89 d8 48 c1 e8 03 42 0f b6 04 38 84 c0 75 34 8b 03 65 ff 0d 79 1d d7 10 <74> 11 83 e0 04 c1 e8 02 5b 41 5e 41 5f e9 97 d8 b6 09 cc e8 71 d5
RSP: 0018:ffffc900043af018 EFLAGS: 00000286
RAX: 000000000003f46c RBX: ffff8880b86336d8 RCX: 1e5222b0fc0eb100
RDX: 000000005b9ddbdf RSI: ffffffff8bc07c40 RDI: ffffffff8bc07c00
RBP: dffffc0000000000 R08: ffffffff81743f85 R09: ffffffff8df41a60
R10: ffffc900043af158 R11: ffffffff81ada810 R12: 1ffff92000875e21
R13: ffffc900043af140 R14: ffffffff8d9b1dd0 R15: dffffc0000000000
 rcu_read_lock include/linux/rcupdate.h:868 [inline]
 class_rcu_constructor include/linux/rcupdate.h:1195 [inline]
 unwind_next_frame+0xd4/0x2390 arch/x86/kernel/unwind_orc.c:479
 arch_stack_walk+0x11c/0x150 arch/x86/kernel/stacktrace.c:25
 stack_trace_save+0x9c/0xe0 kernel/stacktrace.c:122
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 kasan_save_free_info+0x46/0x50 mm/kasan/generic.c:584
 poison_slab_object mm/kasan/common.c:253 [inline]
 __kasan_slab_free+0x5c/0x80 mm/kasan/common.c:285
 kasan_slab_free include/linux/kasan.h:235 [inline]
 slab_free_hook mm/slub.c:2540 [inline]
 slab_free mm/slub.c:6668 [inline]
 kfree+0x1c0/0x660 mm/slub.c:6876
 devinet_sysctl_unregister net/ipv4/devinet.c:2729 [inline]
 inetdev_destroy net/ipv4/devinet.c:334 [inline]
 inetdev_event+0x78e/0x15b0 net/ipv4/devinet.c:1655
 notifier_call_chain+0x19d/0x3a0 kernel/notifier.c:85
 call_netdevice_notifiers_extack net/core/dev.c:2269 [inline]
 call_netdevice_notifiers net/core/dev.c:2283 [inline]
 unregister_netdevice_many_notify+0x1867/0x2340 net/core/dev.c:12400
 unregister_netdevice_many net/core/dev.c:12463 [inline]
 default_device_exit_batch+0x964/0x9e0 net/core/dev.c:13055
 ops_exit_list net/core/net_namespace.c:205 [inline]
 ops_undo_list+0x525/0x990 net/core/net_namespace.c:252
 cleanup_net+0x4d8/0x7a0 net/core/net_namespace.c:696
 process_one_work+0x93a/0x15a0 kernel/workqueue.c:3279
 process_scheduled_works kernel/workqueue.c:3362 [inline]
 worker_thread+0x9b0/0xee0 kernel/workqueue.c:3443
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x599/0xb30 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246
 </TASK>
rcu: rcu_preempt kthread starved for 10553 jiffies! g11645 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=1
rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_preempt     state:R  running task     stack:27736 pid:16    tgid:16    ppid:2      task_flags:0x208040 flags:0x00080000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5256 [inline]
 __schedule+0x14bc/0x5000 kernel/sched/core.c:6863
 __schedule_loop kernel/sched/core.c:6945 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6960
 schedule_timeout+0x12b/0x270 kernel/time/sleep_timeout.c:99
 rcu_gp_fqs_loop+0x301/0x1540 kernel/rcu/tree.c:2083
 rcu_gp_kthread+0x99/0x390 kernel/rcu/tree.c:2285
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x599/0xb30 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246
 </TASK>
rcu: Stack dump where RCU GP kthread last ran:
CPU: 1 UID: 0 PID: 0 Comm: swapper/1 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
RIP: 0010:pv_native_safe_halt+0x13/0x20 arch/x86/kernel/paravirt.c:82
Code: 13 ee 02 00 cc cc cc 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 66 90 0f 00 2d 73 c0 0c 00 f3 0f 1e fa fb f4 <c3> cc cc cc cc cc cc cc cc cc cc cc cc 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffc90000197de0 EFLAGS: 000002c6
RAX: 2bdaeed9ae4cb000 RBX: ffffffff8197971a RCX: 2bdaeed9ae4cb000
RDX: 0000000000000001 RSI: ffffffff8d791c9e RDI: ffffffff8bc07c60
RBP: ffffc90000197f10 R08: ffff8880b87336db R09: 1ffff110170e66db
R10: dffffc0000000000 R11: ffffed10170e66dc R12: ffffffff8f820770
R13: 1ffff110039dcb70 R14: 0000000000000001 R15: 0000000000000001
FS:  0000000000000000(0000) GS:ffff888125f34000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffee7189228 CR3: 00000000753b0000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 arch_safe_halt arch/x86/include/asm/paravirt.h:107 [inline]
 default_idle+0x13/0x20 arch/x86/kernel/process.c:767
 default_idle_call+0x73/0xb0 kernel/sched/idle.c:122
 cpuidle_idle_call kernel/sched/idle.c:191 [inline]
 do_idle+0x1ea/0x520 kernel/sched/idle.c:332
 cpu_startup_entry+0x44/0x60 kernel/sched/idle.c:430
 start_secondary+0x101/0x110 arch/x86/kernel/smpboot.c:312
 common_startup_64+0x13e/0x147
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


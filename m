Return-Path: <netdev+bounces-147175-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D2619D7D87
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 09:53:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2E361619A1
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 08:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 867A318E028;
	Mon, 25 Nov 2024 08:53:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B425018C92F
	for <netdev@vger.kernel.org>; Mon, 25 Nov 2024 08:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732524804; cv=none; b=fJP5BmBfh1rndqk2tzJFjcidztORrNvwvko7X+9aTMJyDslf86qHGjHM0wimTNS2ha/yTbgGBV7hu0pdmrYiobgIJkQVYKx+D4SY7wOpS82DThACnET4KmCi7J38j9HN8j3IDSvdaywMn2jnbpc8oAtI/jp2DxUV9IzvsFEBvFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732524804; c=relaxed/simple;
	bh=Ro4JgtyhvTpx3uc0cLSi4EkbGILhQmAYsf3Iz4h1ix4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=IEqBBF9ALEP2WUbRqnUIeS/cKtrUbu99xdIq2haFlz2JqnqWHbbJtUR45KxV/5CRSoc4jpTrzt85JPfACD/SQrWiBMfXFkHFdouljVKdJhgZjjaM1YHjXdLCRhckY4uZL3el8Y1+/n0rZeARog8vMLalgI1EWaN505VVRQ0QA4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a777d47a8eso45919295ab.3
        for <netdev@vger.kernel.org>; Mon, 25 Nov 2024 00:53:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732524802; x=1733129602;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lm0BRJLap8IYokZmCzi5Af1DkjsKA++CY39Qvl+Gr20=;
        b=vcoy77BJ7Wxd9vtpF2jO2UsD51FdDQ/j7XHDRDpmU8g4Igk7fFKfO2I8BYH6lgkK5E
         +OJ34MGYo3490y85UOZvYi/qe7EGH31VWs+i1ckfVU5rmPHfjnLgkD3Ab42+PVGkSNUb
         kHq82oO42VOnT1+ElSVdMVLjj9Df9gQr+MD5e1Cwkkkd36V+ALFz1bOPX9Sa0szhX1Ve
         HrvRNtKb+1OF6II0ezb03dAFN8R9WgnxxIEGGKlrPXZJKmuEtu5NZ8eydbet39/vHXX7
         QRfODuofPOMVqQOoBrA9vVLYmw6Gh5s74YiUKDO2OyPXmBMt1mkWL13cdpcBha0C9jWn
         PLog==
X-Forwarded-Encrypted: i=1; AJvYcCUnlTjtGBWnnuODYSQHgPFNNmYVRh/E3qra6j5cxBjr7FhSnYAGi7f+JZDknhlA12czKH4SVBo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEIkPRnaeF8q/0XVutbygJVNQRP6X5AaaftGbnw+nnFhmbhgqu
	BXObXo6s6wCHeck3AB2/ujOzpFVpHpfZyFSigl4qEDV48pDrFj4XG00AgK70ZfXn+Jse0KehFw2
	QPE7oA9FLrnQ1+2v9NFUuxMImcUnXDDNmHoDLZlQrbrCE858DcCgQWQo=
X-Google-Smtp-Source: AGHT+IGoR23tV9ownqtFbzVTrlYx84FtpfaFT4+sjnob9QTBV/YLecx14ozgy0zfgA5kXY9XJJ8pDyzg4QCW3G+hIPgzUE+KrhHJ
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:190b:b0:3a7:7d26:4ce4 with SMTP id
 e9e14a558f8ab-3a79ad0fb5dmr123833565ab.9.1732524801977; Mon, 25 Nov 2024
 00:53:21 -0800 (PST)
Date: Mon, 25 Nov 2024 00:53:21 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67443b01.050a0220.1cc393.0070.GAE@google.com>
Subject: [syzbot] [mm?] INFO: rcu detected stall in sys_setsockopt (4)
From: syzbot <syzbot+6e61d59e9d2150c8492b@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, bigeasy@linutronix.de, davem@davemloft.net, 
	edumazet@google.com, kerneljasonxing@gmail.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    cfba9f07a1d6 Add linux-next specific files for 20241122
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1701175f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=45719eec4c74e6ba
dashboard link: https://syzkaller.appspot.com/bug?extid=6e61d59e9d2150c8492b
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13353b78580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/be35516c7ba5/disk-cfba9f07.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/70295210dc7d/vmlinux-cfba9f07.xz
kernel image: https://storage.googleapis.com/syzbot-assets/8b5d044072ee/bzImage-cfba9f07.xz

The issue was bisected to:

commit d15121be7485655129101f3960ae6add40204463
Author: Paolo Abeni <pabeni@redhat.com>
Date:   Mon May 8 06:17:44 2023 +0000

    Revert "softirq: Let ksoftirqd do its job"

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=121d5ee8580000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=111d5ee8580000
console output: https://syzkaller.appspot.com/x/log.txt?x=161d5ee8580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6e61d59e9d2150c8492b@syzkaller.appspotmail.com
Fixes: d15121be7485 ("Revert "softirq: Let ksoftirqd do its job"")

rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 	Tasks blocked on level-0 rcu_node (CPUs 0-1): P6057/1:b..l
rcu: 	(detected by 1, t=10503 jiffies, g=12753, q=1720979 ncpus=2)
task:syz-executor    state:R  running task     stack:20544 pid:6057  tgid:6057  ppid:1      flags:0x00000006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5369 [inline]
 __schedule+0x1850/0x4c30 kernel/sched/core.c:6756
 preempt_schedule_irq+0xfb/0x1c0 kernel/sched/core.c:7078
 irqentry_exit+0x5e/0x90 kernel/entry/common.c:354
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:lock_acquire+0x264/0x550 kernel/locking/lockdep.c:5853
Code: 2b 00 74 08 4c 89 f7 e8 ba be 8f 00 f6 44 24 61 02 0f 85 85 01 00 00 41 f7 c7 00 02 00 00 74 01 fb 48 c7 44 24 40 0e 36 e0 45 <4b> c7 44 25 00 00 00 00 00 43 c7 44 25 09 00 00 00 00 43 c7 44 25
RSP: 0018:ffffc9000322f2a0 EFLAGS: 00000206
RAX: 0000000000000001 RBX: 1ffff92000645e60 RCX: ffff88802d22c6d8
RDX: dffffc0000000000 RSI: ffffffff8c0aa840 RDI: ffffffff8c5e88a0
RBP: ffffc9000322f3f8 R08: ffffffff9428a887 R09: 1ffffffff2851510
R10: dffffc0000000000 R11: fffffbfff2851511 R12: 1ffff92000645e5c
R13: dffffc0000000000 R14: ffffc9000322f300 R15: 0000000000000246
 rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 rcu_read_lock include/linux/rcupdate.h:849 [inline]
 page_ext_get+0x3d/0x2a0 mm/page_ext.c:525
 __page_table_check_zero+0xb1/0x350 mm/page_table_check.c:148
 page_table_check_free include/linux/page_table_check.h:41 [inline]
 free_pages_prepare mm/page_alloc.c:1128 [inline]
 free_unref_page+0xe0e/0x1140 mm/page_alloc.c:2693
 discard_slab mm/slub.c:2673 [inline]
 __put_partials+0xeb/0x130 mm/slub.c:3142
 put_cpu_partial+0x17c/0x250 mm/slub.c:3217
 __slab_free+0x2ea/0x3d0 mm/slub.c:4468
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x9a/0x140 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x14f/0x170 mm/kasan/quarantine.c:286
 __kasan_kmalloc+0x23/0xb0 mm/kasan/common.c:385
 kasan_kmalloc include/linux/kasan.h:260 [inline]
 __kmalloc_cache_node_noprof+0x25d/0x3a0 mm/slub.c:4326
 kmalloc_node_noprof include/linux/slab.h:924 [inline]
 __get_vm_area_node+0x132/0x2d0 mm/vmalloc.c:3127
 __vmalloc_node_range_noprof+0x344/0x1380 mm/vmalloc.c:3804
 __vmalloc_node_noprof mm/vmalloc.c:3909 [inline]
 vzalloc_noprof+0x79/0x90 mm/vmalloc.c:3982
 __do_replace+0xc8/0xa40 net/ipv4/netfilter/ip_tables.c:1046
 do_replace net/ipv4/netfilter/ip_tables.c:1141 [inline]
 do_ipt_set_ctl+0xf02/0x1250 net/ipv4/netfilter/ip_tables.c:1635
 nf_setsockopt+0x295/0x2c0 net/netfilter/nf_sockopt.c:101
 do_sock_setsockopt+0x3af/0x720 net/socket.c:2313
 __sys_setsockopt net/socket.c:2338 [inline]
 __do_sys_setsockopt net/socket.c:2344 [inline]
 __se_sys_setsockopt net/socket.c:2341 [inline]
 __x64_sys_setsockopt+0x1ee/0x280 net/socket.c:2341
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f1f1638070a
RSP: 002b:00007ffec3066f38 EFLAGS: 00000202 ORIG_RAX: 0000000000000036
RAX: ffffffffffffffda RBX: 00007ffec3066fc0 RCX: 00007f1f1638070a
RDX: 0000000000000040 RSI: 0000000000000000 RDI: 0000000000000003
RBP: 0000000000000003 R08: 00000000000002d8 R09: 00007ffec3067377
R10: 00007f1f16509ea0 R11: 0000000000000202 R12: 00007f1f16509e40
R13: 00007ffec3066f5c R14: 0000000000000000 R15: 00007f1f1650c000
 </TASK>
rcu: rcu_preempt kthread starved for 9031 jiffies! g12753 f0x2 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=0
rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_preempt     state:R  running task     stack:25720 pid:17    tgid:17    ppid:2      flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5369 [inline]
 __schedule+0x1850/0x4c30 kernel/sched/core.c:6756
 __schedule_loop kernel/sched/core.c:6833 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6848
 schedule_timeout+0x15a/0x290 kernel/time/sleep_timeout.c:99
 rcu_gp_fqs_loop+0x2df/0x1330 kernel/rcu/tree.c:2045
 rcu_gp_kthread+0xa7/0x3b0 kernel/rcu/tree.c:2247
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
rcu: Stack dump where RCU GP kthread last ran:
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 8 Comm: kworker/0:0 Not tainted 6.12.0-next-20241122-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/30/2024
Workqueue: wg-crypt-wg2 wg_packet_tx_worker
RIP: 0010:__trace_hardirqs_on_caller kernel/locking/lockdep.c:4346 [inline]
RIP: 0010:lockdep_hardirqs_on_prepare+0x317/0x780 kernel/locking/lockdep.c:4406
Code: 00 00 fc ff df eb ac 48 c7 c7 20 48 80 8e 4c 89 ee e8 fd 56 80 03 48 ba 00 00 00 00 00 fc ff df e9 3d ff ff ff 48 8b 44 24 10 <48> 8d 98 c0 0a 00 00 48 89 d8 48 c1 e8 03 0f b6 04 10 84 c0 0f 85
RSP: 0018:ffffc90000007a00 EFLAGS: 00000046
RAX: ffff88801d2bda00 RBX: ffff88801d2be530 RCX: ffffffff817b230a
RDX: dffffc0000000000 RSI: 0000000000000008 RDI: ffffffff9428a988
RBP: ffffc90000007ab8 R08: ffffffff9428a98f R09: 1ffffffff2851531
R10: dffffc0000000000 R11: fffffbfff2851532 R12: ffff88801d2be550
R13: 0000000000000002 R14: ffff88801d2be4d8 R15: 1ffff11003a57c9b
FS:  0000000000000000(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055b1b8f2b008 CR3: 000000000e736000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <IRQ>
 trace_hardirqs_on+0x28/0x40 kernel/trace/trace_preemptirq.c:47
 __raw_spin_unlock_irq include/linux/spinlock_api_smp.h:159 [inline]
 _raw_spin_unlock_irq+0x23/0x50 kernel/locking/spinlock.c:202
 spin_unlock_irq include/linux/spinlock.h:401 [inline]
 backlog_unlock_irq_enable net/core/dev.c:258 [inline]
 process_backlog+0x101e/0x15b0 net/core/dev.c:6146
 __napi_poll+0xcb/0x490 net/core/dev.c:6877
 napi_poll net/core/dev.c:6946 [inline]
 net_rx_action+0x89b/0x1240 net/core/dev.c:7068
 handle_softirqs+0x2c5/0x980 kernel/softirq.c:554
 do_softirq+0x11b/0x1e0 kernel/softirq.c:455
 </IRQ>
 <TASK>
 __local_bh_enable_ip+0x1bb/0x200 kernel/softirq.c:382
 wg_packet_create_data_done drivers/net/wireguard/send.c:247 [inline]
 wg_packet_tx_worker+0x160/0x810 drivers/net/wireguard/send.c:276
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa63/0x1850 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
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


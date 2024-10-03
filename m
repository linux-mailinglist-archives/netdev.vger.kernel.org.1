Return-Path: <netdev+bounces-131491-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A2BFE98EA37
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 09:16:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02C86B263B5
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 07:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 088F477111;
	Thu,  3 Oct 2024 07:16:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43DDC2CA9
	for <netdev@vger.kernel.org>; Thu,  3 Oct 2024 07:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727939784; cv=none; b=tUOlUpChhrJmcwHEkVxbO03eEmNw9/9XEwcwD3wTzi5LdKxNo42xpOT5P8Ihdzq2qnSx2c31gw947IEVVhCnkrZa0sNsdHj21VwG7UjsBqSwy33kMk083rkgKJ2ZJX78lmvyVh9PqJoNk4FcK7+IiA0yR47bofquaIIO6nZ42iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727939784; c=relaxed/simple;
	bh=g9ZGNSgOB6oWTeVjI79V5YFHloHrsOfmqnSZLeUfI+4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Vg1Bm4pheYr+emIrNKkZR7MwV//iXHQjKNs2+I53kAsakBxaAJ4y+WFL+f9Rw2fomNvyl0fDgkCS71Ih6InasmVkrUN6I0H2mbuSTALxBlSmw3o5+8ONfT5TZOV/c31b9JprfzPILfGyDRqwJ7mi25BR/0XxwCNsw26Kaul9420=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-82b930cd6b2so89042839f.1
        for <netdev@vger.kernel.org>; Thu, 03 Oct 2024 00:16:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727939782; x=1728544582;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=99IhvVVp7w0A3AFTNvV1zCAeTS7RIQcvW0OdTxrgE2I=;
        b=FBqD+lCCl5wDOAhPy08lCDRFPJsrCLkjnb+Br8XOu8ix6T7Dsb99tj1r0QWPZ9F9FO
         1Ern/sP7widW8IS4mXIWNfxO//ZnhZrFOZTwUkWY7n6xwrpdY+JxQTYZ6+ik84BWhxWC
         cn8IAr67qe5qUEtsYZ6dsW9/7QHI/hIAjZ/w+NqnYHIu/G/Lk72vt2G8QM0YEiKyJAAS
         aKyQWdk0eDERWuawCudkx69UvGPJijUY7MalpsQwhE6MhdYskGPa4LIWO74hE1xXpKi1
         VIya6SKxt4I8In2cjFuAKiT4ODlvYzClRSbtrAmgXRV4yM8CidxVCQfemVn09cNIkeVJ
         qnfA==
X-Forwarded-Encrypted: i=1; AJvYcCUGDMAZzHkxThWXXkbyiTqojtybU2R1WiBdvFbuuX4fedVb1r524YdrgSrD03b5t+8NQVUpGjk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMn8uN67NRqC/Y0JQXxuRkBZr9XPTO5FUsDb1dFV5XLVD1mrb1
	KyPWQwXa/WULFMY4QP7yQzwG+zd5yfgONTsWLypLLJdEBxj6Ddzapdxk2uvJiwTpZRdVwOZGeBW
	6OcinhDHrHaOXA8sLZlINZHPxVzcgzM/6SAxrG1u3vdrvCTfZSS/L+1Y=
X-Google-Smtp-Source: AGHT+IGXR35b68JoZdM5KbrNRImTgiLusD+wckXhPgfHS4jFV5Rb26SSvqGiOg+0+x6+N9insGGF4pxSJfxO2UlEzGa8pu+T0+5t
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1ca1:b0:3a0:a3cd:f239 with SMTP id
 e9e14a558f8ab-3a36591fa85mr65941075ab.8.1727939782459; Thu, 03 Oct 2024
 00:16:22 -0700 (PDT)
Date: Thu, 03 Oct 2024 00:16:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66fe44c6.050a0220.9ec68.0032.GAE@google.com>
Subject: [syzbot] [mm?] INFO: rcu detected stall in kjournald2 (2)
From: syzbot <syzbot+14c6ac6811273526cfa5@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    d505d3593b52 net: wwan: qcom_bam_dmux: Fix missing pm_runt..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=14aade80580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b2d4fdf18a83ec0b
dashboard link: https://syzkaller.appspot.com/bug?extid=14c6ac6811273526cfa5
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=164df6a9980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=179ffe27980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/0286a1cf90df/disk-d505d359.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b573fa96ab33/vmlinux-d505d359.xz
kernel image: https://storage.googleapis.com/syzbot-assets/cdd9993102ed/bzImage-d505d359.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+14c6ac6811273526cfa5@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 	Tasks blocked on level-0 rcu_node (CPUs 0-1): P4645/1:b..l
rcu: 	(detected by 1, t=10503 jiffies, g=5945, q=1808706 ncpus=2)
task:jbd2/sda1-8     state:R  running task     stack:23792 pid:4645  tgid:4645  ppid:2      flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x1895/0x4b30 kernel/sched/core.c:6675
 preempt_schedule_irq+0xfb/0x1c0 kernel/sched/core.c:6997
 irqentry_exit+0x5e/0x90 kernel/entry/common.c:354
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:stack_trace_consume_entry+0x7/0x280 kernel/stacktrace.c:83
Code: ff e8 fd 9b 44 0a 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 55 41 57 <41> 56 41 55 41 54 53 48 83 ec 18 48 89 fb 48 ba 00 00 00 00 00 fc
RSP: 0018:ffffc9000e59f168 EFLAGS: 00000286
RAX: ffffffff81ef7ceb RBX: ffffc9000e59f180 RCX: ffffffff917b9000
RDX: ffffffff91966401 RSI: ffffffff81ef7ceb RDI: ffffc9000e59f260
RBP: ffffc9000e59f210 R08: ffffc9000e59f4c0 R09: 0000000000000000
R10: ffffc9000e59f1d0 R11: ffffffff81806870 R12: ffff8880318bbc00
R13: ffffffff81806870 R14: ffffc9000e59f260 R15: 0000000000000000
 arch_stack_walk+0x10e/0x150 arch/x86/kernel/stacktrace.c:27
 stack_trace_save+0x118/0x1d0 kernel/stacktrace.c:122
 save_stack+0xfb/0x1f0 mm/page_owner.c:156
 __reset_page_owner+0x76/0x430 mm/page_owner.c:297
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1108 [inline]
 free_unref_page+0xcfb/0xf20 mm/page_alloc.c:2638
 discard_slab mm/slub.c:2678 [inline]
 __put_partials+0xeb/0x130 mm/slub.c:3146
 put_cpu_partial+0x17c/0x250 mm/slub.c:3221
 __slab_free+0x2ea/0x3d0 mm/slub.c:4450
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x9a/0x140 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x14f/0x170 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x23/0x80 mm/kasan/common.c:329
 kasan_slab_alloc include/linux/kasan.h:247 [inline]
 slab_post_alloc_hook mm/slub.c:4086 [inline]
 slab_alloc_node mm/slub.c:4135 [inline]
 kmem_cache_alloc_noprof+0x135/0x2a0 mm/slub.c:4142
 alloc_buffer_head+0x2a/0x290 fs/buffer.c:3020
 jbd2_journal_write_metadata_buffer+0xc2/0xa60 fs/jbd2/journal.c:349
 jbd2_journal_commit_transaction+0x1b36/0x67e0 fs/jbd2/commit.c:663
 kjournald2+0x41c/0x7b0 fs/jbd2/journal.c:201
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
rcu: rcu_preempt kthread starved for 10531 jiffies! g5945 f0x2 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=0
rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_preempt     state:R  running task     stack:25888 pid:17    tgid:17    ppid:2      flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x1895/0x4b30 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6767
 schedule_timeout+0x1be/0x310 kernel/time/timer.c:2615
 rcu_gp_fqs_loop+0x2df/0x1330 kernel/rcu/tree.c:2045
 rcu_gp_kthread+0xa7/0x3b0 kernel/rcu/tree.c:2247
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
rcu: Stack dump where RCU GP kthread last ran:
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 5277 Comm: kworker/0:4 Not tainted 6.11.0-syzkaller-11503-gd505d3593b52 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Workqueue: events nsim_dev_trap_report_work
RIP: 0010:unwind_next_frame+0x46b/0x22d0 arch/x86/kernel/unwind_orc.c:512
Code: 48 c1 e8 03 49 bc 00 00 00 00 00 fc ff df 42 0f b6 04 20 84 c0 0f 85 64 17 00 00 c6 03 01 48 c7 c2 e0 48 08 8c 48 8b 6c 24 50 <4c> 8d 7a 04 48 8d 5a 05 4c 89 f8 48 c1 e8 03 48 89 44 24 70 42 0f
RSP: 0018:ffffc900000067f0 EFLAGS: 00000202
RAX: 0000000000000002 RBX: ffffffff912967b2 RCX: ffffffff90873278
RDX: ffffffff912967ae RSI: ffffffff912967ae RDI: 0000000000000001
RBP: ffffc90000006910 R08: 0000000000000001 R09: ffffc900000069b0
R10: ffffc90000006910 R11: ffffffff81806870 R12: dffffc0000000000
R13: ffffc900000068c0 R14: ffffffff912967b3 R15: ffffffff89f7ea91
FS:  0000000000000000(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000200000c0 CR3: 0000000032f5c000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <IRQ>
 arch_stack_walk+0x11c/0x150 arch/x86/kernel/stacktrace.c:25
 stack_trace_save+0x118/0x1d0 kernel/stacktrace.c:122
 ref_tracker_alloc+0x188/0x490 lib/ref_tracker.c:209
 __netdev_tracker_alloc include/linux/netdevice.h:4050 [inline]
 netdev_hold include/linux/netdevice.h:4079 [inline]
 dst_init+0xee/0x490 net/core/dst.c:52
 dst_alloc+0x14f/0x190 net/core/dst.c:93
 rt_dst_alloc net/ipv4/route.c:1612 [inline]
 __mkroute_output net/ipv4/route.c:2573 [inline]
 ip_route_output_key_hash_rcu+0x13cc/0x2390 net/ipv4/route.c:2795
 ip_route_output_key_hash+0x193/0x2b0 net/ipv4/route.c:2624
 __ip_route_output_key include/net/route.h:141 [inline]
 ip_route_output_flow+0x29/0x140 net/ipv4/route.c:2852
 ip_route_output_key include/net/route.h:151 [inline]
 ip_route_me_harder+0x80d/0x1300 net/ipv4/netfilter.c:53
 synproxy_send_tcp+0x356/0x6c0 net/netfilter/nf_synproxy_core.c:431
 synproxy_send_client_synack+0x8b8/0xf30 net/netfilter/nf_synproxy_core.c:484
 nft_synproxy_eval_v4+0x3ca/0x610 net/netfilter/nft_synproxy.c:59
 nft_synproxy_do_eval+0x362/0xa60 net/netfilter/nft_synproxy.c:141
 expr_call_ops_eval net/netfilter/nf_tables_core.c:240 [inline]
 nft_do_chain+0x4ad/0x1da0 net/netfilter/nf_tables_core.c:288
 nft_do_chain_inet+0x418/0x6b0 net/netfilter/nft_chain_filter.c:161
 nf_hook_entry_hookfn include/linux/netfilter.h:154 [inline]
 nf_hook_slow+0xc3/0x220 net/netfilter/core.c:626
 nf_hook include/linux/netfilter.h:269 [inline]
 NF_HOOK+0x29e/0x450 include/linux/netfilter.h:312
 NF_HOOK+0x3a4/0x450 include/linux/netfilter.h:314
 __netif_receive_skb_one_core net/core/dev.c:5662 [inline]
 __netif_receive_skb+0x2bf/0x650 net/core/dev.c:5775
 process_backlog+0x662/0x15b0 net/core/dev.c:6107
 __napi_poll+0xcb/0x490 net/core/dev.c:6771
 napi_poll net/core/dev.c:6840 [inline]
 net_rx_action+0x89b/0x1240 net/core/dev.c:6962
 handle_softirqs+0x2c5/0x980 kernel/softirq.c:554
 do_softirq+0x11b/0x1e0 kernel/softirq.c:455
 </IRQ>
 <TASK>
 __local_bh_enable_ip+0x1bb/0x200 kernel/softirq.c:382
 spin_unlock_bh include/linux/spinlock.h:396 [inline]
 nsim_dev_trap_report drivers/net/netdevsim/dev.c:820 [inline]
 nsim_dev_trap_report_work+0x75d/0xaa0 drivers/net/netdevsim/dev.c:850
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa63/0x1850 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 3.091 msecs


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


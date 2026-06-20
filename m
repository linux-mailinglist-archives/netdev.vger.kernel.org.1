Return-Path: <netdev+bounces-300778-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id oVkzHOcPNmoa7QYAu9opvQ
	(envelope-from <netdev+bounces-300778-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 20 Jun 2026 05:58:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E86726A84AF
	for <lists+netdev@lfdr.de>; Sat, 20 Jun 2026 05:58:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=appspotmail.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300778-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-300778-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 44C34300B18D
	for <lists+netdev@lfdr.de>; Sat, 20 Jun 2026 03:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A543C22F767;
	Sat, 20 Jun 2026 03:58:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f206.google.com (mail-oi1-f206.google.com [209.85.167.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FFCD18DB35
	for <netdev@vger.kernel.org>; Sat, 20 Jun 2026 03:58:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781927905; cv=none; b=Su+1X1CD+hcqDxrn34QKdjOEKC/MIkaMjoCHZgXoEuEmoWqA2AuUKcJLdi2pSqYVWKvVM80rMQe26fx2+lx0lUhaA4b0eCBw4JZ5ogHYIA/6uQSxg4sVQiFo09Dfr8qnphVcLL5MnvripPC31LUhBmScqeJmTWV/CYF+ImumvPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781927905; c=relaxed/simple;
	bh=w/o4GUqyi22JOEhD3xk1ID5cF3W0qmYJDL1+khheyGo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=jowPTu7Q1x6EXWeYC4oX6UznrCzYrOUwGiTX9+DZ7gMTRx6WbJm7ICy0gpj0wJkUK4P4gy59iMm03aRAlNYt0QiPbXrNAG6g5PfYVA1ABorWC1KryiTBvGCpROHxYxBCutdZ6e1eHMt+RJmC4p/hS9+Phl7a1zMOi1OOw4rcDD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.206
Received: by mail-oi1-f206.google.com with SMTP id 5614622812f47-48b22ea31f3so244573b6e.3
        for <netdev@vger.kernel.org>; Fri, 19 Jun 2026 20:58:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781927903; x=1782532703;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Lo1BGMAuxmegwNBn3SWnedPduG928rlaMvwjWR8I/rc=;
        b=Y7fGcNz44crSmdOkbI9e/bwdeKCZpZA1CLIU+/GBG0Y0VYp6gh6Lhv/nQHDGRCvbYX
         2DwJzFfXV32H9R1RkCdpb2Zvbo0Bn2NKyn2zSjaHyetwTuFA2aBE8c/VUbTk0nI0RFPn
         peyM6iRAU3HapwajJ/pje3YRt+X5773qm2fCqqkucB7CsVXvE1MXoW2kzZdoUKQqlhf3
         Fssjh0DGUqWjnBOZQMh6PVwrQ0024C1xUlNik8QgFVCjOc52OR1iqoSj93zcvME5CHon
         if/2i+yRxwDd7C4GmBBlDUjaqkP1are5FQLjZP60E2xsjngjnlOkpm4e09h+5HGtDCcu
         mBZg==
X-Forwarded-Encrypted: i=1; AFNElJ+JiF0shdrUqr6Ny0CFEsVwdTpD8j7uPLG+0+iskPpZrzUIU9i6sm1/gcBYj5umQIhMqw3FfiU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4wLoVLJjRuyDsPF06JgpHgz51DZuS7j3ytNpVdhTcxvLC1OsZ
	0q8yGvKUdvP+2HpTNybr4gUhMnbQ34U4hF2biy944Lc8ILCHzYsZZFfFXOUL3S3hlRIwW0OTdAv
	L2YzW+1Ju5tq7LolMQ8E1nz5jjNQB3zXzbih1ObDm9elgdEh1pc5MEx7UDuQ=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1a29:b0:47b:bd7b:10d0 with SMTP id
 5614622812f47-4896aa24c4fmr5106313b6e.13.1781927903317; Fri, 19 Jun 2026
 20:58:23 -0700 (PDT)
Date: Fri, 19 Jun 2026 20:58:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a360fdf.871e809a.2d6dda.0001.GAE@google.com>
Subject: [syzbot] [fs?] [mm?] INFO: rcu detected stall in dentry_kill
From: syzbot <syzbot+0635dc2e2c3c21a6aa04@syzkaller.appspotmail.com>
To: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=9a9f723a32776544];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:brauner@kernel.org,m:jack@suse.cz,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:netdev@vger.kernel.org,m:syzkaller-bugs@googlegroups.com,m:viro@zeniv.linux.org.uk,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-300778-lists,netdev=lfdr.de,0635dc2e2c3c21a6aa04];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,storage.googleapis.com:url,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,syzkaller.appspotmail.com:from_mime,syzkaller.appspot.com:url];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E86726A84AF

Hello,

syzbot found the following issue on:

HEAD commit:    b85966adbf5d Merge tag 'net-next-7.2' of git://git.kernel...
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=15ffe3a1580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9a9f723a32776544
dashboard link: https://syzkaller.appspot.com/bug?extid=0635dc2e2c3c21a6aa04
compiler:       Debian clang version 22.1.6 (++20260514074242+fc4aad7b5db3-1~exp1~20260514074407.73), Debian LLD 22.1.6
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1192ccfe580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10dec2ae580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d65306d96573/disk-b85966ad.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ef43139aab0e/vmlinux-b85966ad.xz
kernel image: https://storage.googleapis.com/syzbot-assets/26d4d1ab67c3/bzImage-b85966ad.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0635dc2e2c3c21a6aa04@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 	0-...!: (1 GPs behind) idle=8aec/1/0x4000000000000000 softirq=15232/15238 fqs=0
rcu: 	(detected by 1, t=10502 jiffies, g=12001, q=779 ncpus=2)
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 5691 Comm: udevd Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/09/2026
RIP: 0010:lock_release+0x2d3/0x3c0 kernel/locking/lockdep.c:5893
Code: 65 c7 05 2c 91 98 11 00 00 00 00 eb b5 e8 45 d1 05 0a f7 c3 00 02 00 00 74 b9 65 48 8b 05 45 4c 98 11 48 3b 44 24 28 75 44 fb <48> 83 c4 30 5b 41 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc cc 48 8d
RSP: 0018:ffffc90000007c98 EFLAGS: 00000046
RAX: 2f357cb7f4202a00 RBX: ffff88803147f2a8 RCX: 0000000000010002
RDX: 0000000000010000 RSI: ffffffff8c291100 RDI: ffffffff8c2910c0
RBP: dffffc0000000000 R08: 0000000000000003 R09: 0000000000000004
R10: dffffc0000000000 R11: fffff52000000f90 R12: ffff8880611c6000
R13: ffffffff89b61a3a R14: ffff88803147f2c0 R15: ffff88803147f300
FS:  0000000000000000(0000) GS:ffff88812527c000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000564961a89a38 CR3: 000000000e746000 CR4: 00000000003526f0
Call Trace:
 <IRQ>
 __raw_spin_unlock include/linux/spinlock_api_smp.h:167 [inline]
 _raw_spin_unlock+0x16/0x50 kernel/locking/spinlock.c:190
 spin_unlock include/linux/spinlock.h:390 [inline]
 advance_sched+0x99a/0xc80 net/sched/sch_taprio.c:988
 __run_hrtimer kernel/time/hrtimer.c:2032 [inline]
 __hrtimer_run_queues+0x3bc/0xa10 kernel/time/hrtimer.c:2096
 hrtimer_interrupt+0x448/0x910 kernel/time/hrtimer.c:2215
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1051 [inline]
 __sysvec_apic_timer_interrupt+0x102/0x430 arch/x86/kernel/apic/apic.c:1068
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1062 [inline]
 sysvec_apic_timer_interrupt+0xa1/0xc0 arch/x86/kernel/apic/apic.c:1062
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:674
RIP: 0010:__unwind_start+0x514/0x660 arch/x86/kernel/unwind_orc.c:-1
Code: 10 42 80 3c 28 00 4c 8d 7b 38 74 08 4c 89 ff e8 12 7a ba 00 48 8b 44 24 08 49 39 07 0f 87 b6 fb ff ff 48 89 df e8 cc d0 ff ff <48> 8b 04 24 42 0f b6 04 28 84 c0 75 11 83 3b 00 4c 89 f1 0f 85 5b
RSP: 0018:ffffc9000432f590 EFLAGS: 00000282
RAX: 00000000f218b401 RBX: ffffc9000432f5e8 RCX: 0000000080000001
RDX: ffffc9000432f601 RSI: ffffffff8c291100 RDI: ffff888034f03e00
RBP: 1ffff92000865ebf R08: ffffc9000432f5d8 R09: 0000000000000000
R10: ffffc9000432f638 R11: fffff52000865ec9 R12: 1ffff92000865ebe
R13: dffffc0000000000 R14: ffffc9000432f5f8 R15: ffffc9000432f620
 unwind_start arch/x86/include/asm/unwind.h:64 [inline]
 arch_stack_walk+0xe3/0x150 arch/x86/kernel/stacktrace.c:24
 stack_trace_save+0xa9/0x100 kernel/stacktrace.c:122
 kasan_save_stack+0x3e/0x60 mm/kasan/common.c:57
 kasan_record_aux_stack+0xbd/0xd0 mm/kasan/generic.c:556
 __call_rcu_common kernel/rcu/tree.c:3159 [inline]
 call_rcu+0xee/0x8b0 kernel/rcu/tree.c:3279
 __destroy_inode+0x2a1/0x630 fs/inode.c:365
 destroy_inode fs/inode.c:388 [inline]
 evict+0x8d4/0xb50 fs/inode.c:852
 dentry_kill+0x1b9/0x880 fs/dcache.c:826
 finish_dput+0x1a/0x260 fs/dcache.c:1001
 __fput+0x675/0xa50 fs/file_table.c:520
 task_work_run+0x1d9/0x270 kernel/task_work.c:233
 exit_task_work include/linux/task_work.h:40 [inline]
 do_exit+0x73a/0x2360 kernel/exit.c:1004
 do_group_exit+0x22d/0x2f0 kernel/exit.c:1147
 __do_sys_exit_group kernel/exit.c:1158 [inline]
 __se_sys_exit_group kernel/exit.c:1156 [inline]
 __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1156
 x64_sys_call+0x221a/0x2240 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fbd5bcf16c5
Code: Unable to access opcode bytes at 0x7fbd5bcf169b.
RSP: 002b:00007ffe420f4688 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 0000564961aa4f80 RCX: 00007fbd5bcf16c5
RDX: 00000000000000e7 RSI: fffffffffffffe68 RDI: 0000000000000000
RBP: 0000564961a80910 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffe420f46d0 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
rcu: rcu_preempt kthread starved for 10502 jiffies! g12001 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=1
rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_preempt     state:R  running task     stack:28040 pid:16    tgid:16    ppid:2      task_flags:0x208040 flags:0x00080000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5504 [inline]
 __schedule+0x17d9/0x56c0 kernel/sched/core.c:7228
 __schedule_loop kernel/sched/core.c:7307 [inline]
 schedule+0x164/0x360 kernel/sched/core.c:7322
 schedule_timeout+0x152/0x2c0 kernel/time/sleep_timeout.c:99
 rcu_gp_fqs_loop+0x30c/0x11f0 kernel/rcu/tree.c:2123
 rcu_gp_kthread+0x9e/0x2b0 kernel/rcu/tree.c:2325
 kthread+0x388/0x470 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
rcu: Stack dump where RCU GP kthread last ran:
CPU: 1 UID: 0 PID: 5689 Comm: udevd Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/09/2026
RIP: 0010:csd_lock_wait kernel/smp.c:342 [inline]
RIP: 0010:smp_call_function_many_cond+0x10b0/0x14b0 kernel/smp.c:892
Code: c0 75 73 41 8b 1e 89 de 83 e6 01 31 ff e8 98 02 0c 00 83 e3 01 48 bb 00 00 00 00 00 fc ff df 75 07 e8 44 fe 0b 00 eb 37 f3 90 <41> 0f b6 04 1c 84 c0 75 10 41 f7 06 01 00 00 00 74 1e e8 29 fe 0b
RSP: 0000:ffffc9000430f840 EFLAGS: 00000293
RAX: ffffffff81b9f7f7 RBX: dffffc0000000000 RCX: ffff88807f020000
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffffc9000430f970 R08: ffffffff903116f7 R09: 1ffffffff20622de
R10: dffffc0000000000 R11: fffffbfff20622df R12: 1ffff110170c85c5
R13: ffff8880b873c2c8 R14: ffff8880b8642e28 R15: 0000000000000000
FS:  00007fbd5c388880(0000) GS:ffff88812537c000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000564961a89a38 CR3: 0000000044280000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 on_each_cpu_cond_mask+0x3f/0x80 kernel/smp.c:1057
 __flush_tlb_multi arch/x86/include/asm/paravirt.h:46 [inline]
 flush_tlb_multi arch/x86/mm/tlb.c:1361 [inline]
 flush_tlb_mm_range+0x5c4/0x1090 arch/x86/mm/tlb.c:1451
 flush_tlb_page arch/x86/include/asm/tlbflush.h:345 [inline]
 ptep_clear_flush+0x120/0x170 mm/pgtable-generic.c:104
 wp_page_copy mm/memory.c:3941 [inline]
 do_wp_page+0x3d52/0x4c70 mm/memory.c:4336
 handle_pte_fault mm/memory.c:6443 [inline]
 __handle_mm_fault mm/memory.c:6565 [inline]
 handle_mm_fault+0x1490/0x3080 mm/memory.c:6734
 do_user_addr_fault+0xa4d/0x1340 arch/x86/mm/fault.c:1339
 handle_page_fault arch/x86/mm/fault.c:1479 [inline]
 exc_page_fault+0x6a/0xc0 arch/x86/mm/fault.c:1532
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:595
RIP: 0033:0x7fbd5c3ada9a
Code: 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 53 48 85 ff 74 2f 48 8b 47 08 48 39 c7 74 21 48 8b 1f 48 39 df 74 19 48 89 18 <48> 89 43 08 e8 8d d9 ff ff 48 89 d8 5b c3 0f 1f 84 00 00 00 00 00
RSP: 002b:00007ffe420f4620 EFLAGS: 00010202
RAX: 0000564961a8a0b0 RBX: 0000564961a89a30 RCX: 0000000000000000
RDX: 0000564961a95430 RSI: 0000564961a91f60 RDI: 0000564961a8f4e0
RBP: 0000564961a8f4e0 R08: 0000564961a91f70 R09: 0000000000000003
R10: 0000000000000000 R11: 0000000000000297 R12: 0000564958c24588
R13: 00007ffe420f46d0 R14: 0000000000000000 R15: 0000000000000000
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


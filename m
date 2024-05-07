Return-Path: <netdev+bounces-94095-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0B5A8BE1C6
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 14:14:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97AFBB24271
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 12:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7CB1158A2D;
	Tue,  7 May 2024 12:14:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CBCE156F37
	for <netdev@vger.kernel.org>; Tue,  7 May 2024 12:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715084061; cv=none; b=hMVR36Xd0TuCICUhWgXtjGKMvJSXm5PE8a8JHJZ7AYYzo8eRaDorCfA2UbCP77apmpv5U0tG8yyNXKgEFBhdqh/vgUn3PsHVjPzoLvDpyxwxw75SOIVAoAnZrnwU2U0Uxpcf8u6pszlnwDX0eqZEyTDtisy8G4CegOpTcSz67mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715084061; c=relaxed/simple;
	bh=smsVF1Gn1lVf1NeQXqZC3ayNC71MpesQSy9gKacIV2s=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=HBfMVfaWDkxcdX/HqZXBZaGalprWSvrMars9/sAN1jWb/NJlltI2TBqMp1Szkc4nCt20JLl7eZ0Wx+t+IkA6Jzu+M1/GzJ18DkOFPib413PhDaFrPFZ+f1MFTQT8ErsInRpnnk73sPYvNndGE+OaOGLTZe4M+RnJ69vvmFeDXN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-7de9c6b7a36so384410739f.1
        for <netdev@vger.kernel.org>; Tue, 07 May 2024 05:14:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715084058; x=1715688858;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s0b21/2uVPCAvCtbm7wHn8GwiXN/BrEZ0uxtsyRFZPs=;
        b=Fb5GeCTEuSoQoYV1lFMo/xOvsiEW5LgPVAeiZHQ4reU+3gR+PobsTJBiu3zEIIIslu
         5VeoyHiKypwkSE/7oohgHTxrPe7eLRlS11RS9qJoZ75aqiYlbrPO0O/AmtXS6HWq4Kjk
         8YdyOrSRgmMR5xZWo7iqq+P9TamN9gXBXvf8kiXaMOX49nx3r9f7CS6XMrXQ10LJL454
         8l+TqDtjLFu+POabuH4nhaOR/jS2UGNK4Fv4L7nbwAiJX3BllluTDamGNMnSnPJzVq9E
         WLS7u0KzW+blzhVa2+uVRH8oaEUXtNta+5I3zRPQ5WrXQAltiu1b4/l09W6ifLIYcREf
         /cDA==
X-Forwarded-Encrypted: i=1; AJvYcCUnlD3WNdN/T1/Q933GkDzOwr9ujM8Gq0uBIiVIMiMKd9zt6HVbzjohEWCK7XFFoaid0WRuQQPVxHChI9rPtR5qdfEnfLd3
X-Gm-Message-State: AOJu0YwB7KSO2ERnO6MC2GZa9beiomTlHlq5jbMd8GNkWv0ve58dnQ6x
	KqgEpf3MbAedy9tPX5CSKEEu1BvJXT2qVP7wSYXD9KN02LQR6EjWh6tSZI2W7f4B2UPAtqkFRXr
	RZzNbaLQHlKp5kHXFjR1JJ640JnGVtimGUjnhyN1tlNn155Z8i4oFzeY=
X-Google-Smtp-Source: AGHT+IGR6NquASTF23FhDEJg112Cu3Pg4KZUBUU7ixs6Z6VRMiq65c6PQ18ikngsjp77jVPOHRKYLyRpuDcZTo5TK8fwKhkwdlh2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2583:b0:488:cdbc:72c0 with SMTP id
 s3-20020a056638258300b00488cdbc72c0mr125833jat.2.1715084057771; Tue, 07 May
 2024 05:14:17 -0700 (PDT)
Date: Tue, 07 May 2024 05:14:17 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000612fa0617dc20f6@google.com>
Subject: [syzbot] [net?] INFO: rcu detected stall in sock_write_iter (3)
From: syzbot <syzbot+2b5fbaaa4280010beda7@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	jhs@mojatatu.com, jiri@resnulli.us, john.stultz@linaro.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	sboyd@kernel.org, syzkaller-bugs@googlegroups.com, tglx@linutronix.de, 
	vinicius.gomes@intel.com, xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    7367539ad4b0 Merge tag 'cxl-fixes-6.9-rc7' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17058250980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3714fc09f933e505
dashboard link: https://syzkaller.appspot.com/bug?extid=2b5fbaaa4280010beda7
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17d9f62f180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1379d9df180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/367ccce69d37/disk-7367539a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/88c894cbcc3a/vmlinux-7367539a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f67d1fb31d1a/bzImage-7367539a.xz

The issue was bisected to:

commit a3d43c0d56f1b94e74963a2fbadfb70126d92213
Author: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date:   Mon Apr 29 22:48:31 2019 +0000

    taprio: Add support adding an admin schedule

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16f11ea8980000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=15f11ea8980000
console output: https://syzkaller.appspot.com/x/log.txt?x=11f11ea8980000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2b5fbaaa4280010beda7@syzkaller.appspotmail.com
Fixes: a3d43c0d56f1 ("taprio: Add support adding an admin schedule")

rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 	1-...!: (1 GPs behind) idle=b9c4/1/0x4000000000000000 softirq=6260/6262 fqs=4
rcu: 	(detected by 0, t=10502 jiffies, g=7333, q=68 ncpus=2)
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 PID: 5118 Comm: sshd Not tainted 6.9.0-rc6-syzkaller-00234-g7367539ad4b0 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
RIP: 0010:__kasan_check_write+0x0/0x20 mm/kasan/shadow.c:36
Code: 48 8b 0c 24 31 d2 e9 6f e6 ff ff 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 <f3> 0f 1e fa 89 f6 48 8b 0c 24 ba 01 00 00 00 e9 3c e6 ff ff 66 2e
RSP: 0018:ffffc90000a08b98 EFLAGS: 00000097
RAX: 0000000000000004 RBX: dffffc0000000000 RCX: 0000000000a08c03
RDX: dffffc0000000000 RSI: 0000000000000004 RDI: ffff88807105d2e8
RBP: ffffc90000a08c80 R08: ffffffff92f355e7 R09: 1ffffffff25e6abc
R10: dffffc0000000000 R11: fffffbfff25e6abd R12: ffff88807105d2e8
R13: 1ffff92000141180 R14: ffffc90000a08c00 R15: 1ffff1100e20ba5e
FS:  00007f65e68af800(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffc197ad018 CR3: 00000000573a0000 CR4: 0000000000350ef0
Call Trace:
 <NMI>
 </NMI>
 <IRQ>
 instrument_atomic_read_write include/linux/instrumented.h:96 [inline]
 atomic_try_cmpxchg_acquire include/linux/atomic/atomic-instrumented.h:1300 [inline]
 queued_spin_lock include/asm-generic/qspinlock.h:111 [inline]
 do_raw_spin_lock+0x142/0x370 kernel/locking/spinlock_debug.c:116
 spin_lock include/linux/spinlock.h:351 [inline]
 advance_sched+0xab/0xca0 net/sched/sch_taprio.c:924
 __run_hrtimer kernel/time/hrtimer.c:1692 [inline]
 __hrtimer_run_queues+0x5a7/0xd50 kernel/time/hrtimer.c:1756
 hrtimer_interrupt+0x396/0x990 kernel/time/hrtimer.c:1818
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1032 [inline]
 __sysvec_apic_timer_interrupt+0x112/0x3f0 arch/x86/kernel/apic/apic.c:1049
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
 sysvec_apic_timer_interrupt+0xa1/0xc0 arch/x86/kernel/apic/apic.c:1043
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:__rcu_read_lock+0x5/0xb0 kernel/rcu/tree_plugin.h:401
Code: fc ff ff e9 62 fc ff ff e8 48 32 03 0a 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 55 <41> 57 41 56 53 49 be 00 00 00 00 00 fc ff df 65 4c 8b 3c 25 c0 d3
RSP: 0018:ffffc900031f7110 EFLAGS: 00000293
RAX: ffffffff89deccd2 RBX: 0000000000000000 RCX: ffff888029465a00
RDX: 0000000000000000 RSI: ffffffff94aecb00 RDI: 0000000000000004
RBP: ffffc900031f7238 R08: 0000000000000000 R09: ffff888021edc000
R10: dffffc0000000000 R11: fffffbfff1f51f6e R12: 1ffff9200063ee2c
R13: ffffffff94aecb00 R14: ffff888022470ff0 R15: dffffc0000000000
 rcu_read_lock include/linux/rcupdate.h:779 [inline]
 nf_hook+0x97/0x450 include/linux/netfilter.h:238
 NF_HOOK_COND include/linux/netfilter.h:302 [inline]
 ip_output+0x185/0x230 net/ipv4/ip_output.c:433
 ip_local_out net/ipv4/ip_output.c:129 [inline]
 __ip_queue_xmit+0x118c/0x1b70 net/ipv4/ip_output.c:535
 __tcp_transmit_skb+0x2557/0x3b80 net/ipv4/tcp_output.c:1462
 tcp_transmit_skb net/ipv4/tcp_output.c:1480 [inline]
 tcp_write_xmit+0x1445/0x6100 net/ipv4/tcp_output.c:2792
 __tcp_push_pending_frames+0x9b/0x360 net/ipv4/tcp_output.c:2977
 tcp_sendmsg_locked+0x42cc/0x4d00 net/ipv4/tcp.c:1310
 tcp_sendmsg+0x30/0x50 net/ipv4/tcp.c:1342
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x1a6/0x270 net/socket.c:745
 sock_write_iter+0x2dd/0x400 net/socket.c:1160
 call_write_iter include/linux/fs.h:2110 [inline]
 new_sync_write fs/read_write.c:497 [inline]
 vfs_write+0xa86/0xcb0 fs/read_write.c:590
 ksys_write+0x1a0/0x2c0 fs/read_write.c:643
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f65e6516bf2
Code: 89 c7 48 89 44 24 08 e8 7b 34 fa ff 48 8b 44 24 08 48 83 c4 28 c3 c3 64 8b 04 25 18 00 00 00 85 c0 75 20 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 76 6f 48 8b 15 07 a2 0d 00 f7 d8 64 89 02 48 83
RSP: 002b:00007ffd643a9c18 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000034 RCX: 00007f65e6516bf2
RDX: 0000000000000034 RSI: 000056509ca5f960 RDI: 0000000000000004
RBP: 000056509ca6d220 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000056508b938aa4
R13: 0000000000000276 R14: 000056508b9393e8 R15: 00007ffd643a9c88
 </TASK>
INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 3.166 msecs
rcu: rcu_preempt kthread starved for 10494 jiffies! g7333 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=0
rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_preempt     state:R  running task     stack:25880 pid:16    tgid:16    ppid:2      flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5409 [inline]
 __schedule+0x17e8/0x4a50 kernel/sched/core.c:6746
 __schedule_loop kernel/sched/core.c:6823 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6838
 schedule_timeout+0x1be/0x310 kernel/time/timer.c:2582
 rcu_gp_fqs_loop+0x2df/0x1370 kernel/rcu/tree.c:1663
 rcu_gp_kthread+0xa7/0x3b0 kernel/rcu/tree.c:1862
 kthread+0x2f2/0x390 kernel/kthread.c:388
 ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
rcu: Stack dump where RCU GP kthread last ran:
CPU: 0 PID: 5136 Comm: kworker/u8:1 Not tainted 6.9.0-rc6-syzkaller-00234-g7367539ad4b0 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Workqueue: events_unbound toggle_allocation_gate
RIP: 0010:csd_lock_wait kernel/smp.c:311 [inline]
RIP: 0010:smp_call_function_many_cond+0x1899/0x2a00 kernel/smp.c:855
Code: 89 e6 83 e6 01 31 ff e8 15 db 0b 00 41 83 e4 01 49 bc 00 00 00 00 00 fc ff df 75 07 e8 c0 d6 0b 00 eb 38 f3 90 42 0f b6 04 23 <84> c0 75 11 41 f7 45 00 01 00 00 00 74 1e e8 a4 d6 0b 00 eb e4 44
RSP: 0018:ffffc90004b1f6e0 EFLAGS: 00000293
RAX: 0000000000000000 RBX: 1ffff110172a8869 RCX: ffff8880295c9e00
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffffc90004b1f8e0 R08: ffffffff818a39eb R09: 1ffffffff25e6aa0
R10: dffffc0000000000 R11: fffffbfff25e6aa1 R12: dffffc0000000000
R13: ffff8880b9544348 R14: ffff8880b943f7c0 R15: 0000000000000001
FS:  0000000000000000(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f5fa233e120 CR3: 000000000e134000 CR4: 0000000000350ef0
Call Trace:
 <IRQ>
 </IRQ>
 <TASK>
 on_each_cpu_cond_mask+0x3f/0x80 kernel/smp.c:1023
 on_each_cpu include/linux/smp.h:71 [inline]
 text_poke_sync arch/x86/kernel/alternative.c:2086 [inline]
 text_poke_bp_batch+0x352/0xb30 arch/x86/kernel/alternative.c:2296
 text_poke_flush arch/x86/kernel/alternative.c:2487 [inline]
 text_poke_finish+0x30/0x50 arch/x86/kernel/alternative.c:2494
 arch_jump_label_transform_apply+0x1c/0x30 arch/x86/kernel/jump_label.c:146
 static_key_enable_cpuslocked+0x136/0x260 kernel/jump_label.c:205
 static_key_enable+0x1a/0x20 kernel/jump_label.c:218
 toggle_allocation_gate+0xb5/0x250 mm/kfence/core.c:826
 process_one_work kernel/workqueue.c:3267 [inline]
 process_scheduled_works+0xa12/0x17c0 kernel/workqueue.c:3348
 worker_thread+0x86d/0xd70 kernel/workqueue.c:3429
 kthread+0x2f2/0x390 kernel/kthread.c:388
 ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
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


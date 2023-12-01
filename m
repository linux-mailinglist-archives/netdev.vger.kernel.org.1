Return-Path: <netdev+bounces-52739-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BEE247FFFF6
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 01:12:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A11EB20E45
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 00:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDA2D368;
	Fri,  1 Dec 2023 00:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T2g96d8d"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3F5A1704
	for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 16:12:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701389566; x=1732925566;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=f/Mstuk77SjWENmvuWacaZu2RsMZdNFjhKrahk3o8EI=;
  b=T2g96d8doC2nR8tNxQN5cV7rBUPvo1G9Hz3ykWdT5vqgcfUle2K197r7
   N+Nyq3GT7SPT0lXmFnxNqPJgZsVDNRCxM7umiO5t3xpKq3kojHjNdnaS2
   ADJykkP9ooPVZTMIuoxSNtCModDb2G4jhFo/Ikx/ryhSywizurd3FcSH+
   wC8VIZnvmozacC3x1JySbO2MST7Pt1ZiPDGne5OIqc2vSF5T1Yp2778OT
   s5ilI9Kbm5IcEuc+17Za6p8uwNpzW3T82EqEElpUo36bNx9kFTsDZ8A0m
   hWSbDmWKEkCzzUzDcOlWpdlHc3eZ6tROl6aRAPIw/VYvhjpXay7WqIRbP
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="390576210"
X-IronPort-AV: E=Sophos;i="6.04,240,1695711600"; 
   d="scan'208";a="390576210"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2023 16:12:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="798499759"
X-IronPort-AV: E=Sophos;i="6.04,240,1695711600"; 
   d="scan'208";a="798499759"
Received: from vcostago-desk1.jf.intel.com (HELO vcostago-desk1) ([10.54.70.67])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2023 16:12:45 -0800
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>, Cong Wang
 <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Jakub Kicinski
 <kuba@kernel.org>, Linux Kernel Network Developers
 <netdev@vger.kernel.org>
Subject: Re: Fwd: [syzbot] [net?] INFO: rcu detected stall in sys_socket (10)
In-Reply-To: <CAM0EoMkAxx+JwLxc_T0jJd3+jZmoSTndLKC6Ap7qYwd58A5Zmg@mail.gmail.com>
References: <00000000000077c77f060b603f2d@google.com>
 <CAM0EoMkAxx+JwLxc_T0jJd3+jZmoSTndLKC6Ap7qYwd58A5Zmg@mail.gmail.com>
Date: Thu, 30 Nov 2023 16:12:45 -0800
Message-ID: <87il5i7pc2.fsf@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jamal Hadi Salim <jhs@mojatatu.com> writes:

> Vinicius/Vladmir,
> I pinged you on this already. Can you take a look please? There is a
> reproducer..
>

It seems to be another one of those, syzkaller managed to produce a
schedule with a small enough interval that it's going to starve some
other things. (in this case, the interval is 127 ns)

We already reject intervals that won't allow the passage of the smallest
ethernet packet. I am running out of ideas that we could do to, at least
at configuration time.

But one almost crazy idea turned up: what if we only start the timer
when there are actually packets in the qdisc? i.e. if the queue was
empty, we would only start the timer during "empty -> non-empty"
enqueue(), and stop the timer when the queue goes back to empty.

I think that way, we remove the issue that causes most of the syzkaller
reports, and we would reduce the CPU overhead when taprio is idle (on a
non-debug system with the problematic schedule I am seeing ~2% overhead
in perf top).

Does that sound like it could work?

> cheers,
> jamal
>
> ---------- Forwarded message ---------
> From: syzbot <syzbot+de8e83db70e8beedd556@syzkaller.appspotmail.com>
> Date: Thu, Nov 30, 2023 at 10:24=E2=80=AFAM
> Subject: [syzbot] [net?] INFO: rcu detected stall in sys_socket (10)
> To: <bp@alien8.de>, <davem@davemloft.net>, <edumazet@google.com>,
> <hpa@zytor.com>, <jhs@mojatatu.com>, <jiri@resnulli.us>,
> <kuba@kernel.org>, <linux-kernel@vger.kernel.org>, <mingo@redhat.com>,
> <netdev@vger.kernel.org>, <pabeni@redhat.com>,
> <syzkaller-bugs@googlegroups.com>, <tglx@linutronix.de>,
> <vinicius.gomes@intel.com>, <willemdebruijn.kernel@gmail.com>,
> <x86@kernel.org>, <xiyou.wangcong@gmail.com>
>
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    18d46e76d7c2 Merge tag 'for-6.7-rc3-tag' of git://git.ker=
n..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D16bcc8b4e80000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dbb39fe85d254f=
638
> dashboard link: https://syzkaller.appspot.com/bug?extid=3Dde8e83db70e8bee=
dd556
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils
> for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D12172952e80=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D1086b58ae80000
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/0ce5608c89e8/dis=
k-18d46e76.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/eef847faba9c/vmlinu=
x-18d46e76.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/6a3df3288860/b=
zImage-18d46e76.xz
>
> The issue was bisected to:
>
> commit 5a781ccbd19e4664babcbe4b4ead7aa2b9283d22
> Author: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> Date:   Sat Sep 29 00:59:43 2018 +0000
>
>     tc: Add support for configuring the taprio scheduler
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D16a29b52e8=
0000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=3D15a29b52e8=
0000
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D11a29b52e80000
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+de8e83db70e8beedd556@syzkaller.appspotmail.com
> Fixes: 5a781ccbd19e ("tc: Add support for configuring the taprio schedule=
r")
>
> rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
> rcu:    0-...!: (1 GPs behind) idle=3D79f4/1/0x4000000000000000
> softirq=3D5546/5548 fqs=3D1
> rcu:    (detected by 1, t=3D10503 jiffies, g=3D5017, q=3D384 ncpus=3D2)
> Sending NMI from CPU 1 to CPUs 0:
> NMI backtrace for cpu 0
> CPU: 0 PID: 5106 Comm: syz-executor201 Not tainted
> 6.7.0-rc3-syzkaller-00024-g18d46e76d7c2 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine,
> BIOS Google 11/10/2023
> RIP: 0010:__run_hrtimer kernel/time/hrtimer.c:1686 [inline]
> RIP: 0010:__hrtimer_run_queues+0x62e/0xc20 kernel/time/hrtimer.c:1752
> Code: fc ff df 48 89 fa 48 c1 ea 03 0f b6 04 02 48 89 fa 83 e2 07 38
> d0 7f 08 84 c0 0f 85 fb 04 00 00 45 0f b6 6e 3b 31 ff 44 89 ee <e8> 2d
> 46 11 00 45 84 ed 0f 84 8e fb ff ff e8 ef 4a 11 00 4c 89 f7
> RSP: 0018:ffffc90000007e40 EFLAGS: 00000046
> RAX: 0000000000000000 RBX: ffff8880b982ba40 RCX: ffffffff817642f9
> RDX: 0000000000000003 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: 0000000000000001 R08: 0000000000000001 R09: 0000000000000000
> R10: 0000000000000001 R11: 0000000000000002 R12: ffff8880b982b940
> R13: 0000000000000000 R14: ffff88801c43a340 R15: ffffffff88a2daf0
> FS:  00005555566fe380(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fe9404c73b0 CR3: 0000000076e2d000 CR4: 0000000000350ef0
> Call Trace:
>  <NMI>
>  </NMI>
>  <IRQ>
>  hrtimer_interrupt+0x31b/0x800 kernel/time/hrtimer.c:1814
>  local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1065 [inline]
>  __sysvec_apic_timer_interrupt+0x105/0x400 arch/x86/kernel/apic/apic.c:10=
82
>  sysvec_apic_timer_interrupt+0x90/0xb0 arch/x86/kernel/apic/apic.c:1076
>  </IRQ>
>  <TASK>
>  asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.=
h:645
> RIP: 0010:lock_acquire+0x1ef/0x520 kernel/locking/lockdep.c:5722
> Code: c1 05 bd 6c 9a 7e 83 f8 01 0f 85 b4 02 00 00 9c 58 f6 c4 02 0f
> 85 9f 02 00 00 48 85 ed 74 01 fb 48 b8 00 00 00 00 00 fc ff df <48> 01
> c3 48 c7 03 00 00 00 00 48 c7 43 08 00 00 00 00 48 8b 84 24
> RSP: 0018:ffffc9000432fb00 EFLAGS: 00000206
> RAX: dffffc0000000000 RBX: 1ffff92000865f62 RCX: ffffffff81672c0e
> RDX: 0000000000000001 RSI: ffffffff8accbae0 RDI: ffffffff8b2f0dc0
> RBP: 0000000000000200 R08: 0000000000000000 R09: fffffbfff23e33d0
> R10: ffffffff91f19e87 R11: 0000000000000000 R12: 0000000000000001
> R13: 0000000000000000 R14: ffffffff8d0f0b48 R15: 0000000000000000
>  __mutex_lock_common kernel/locking/mutex.c:603 [inline]
>  __mutex_lock+0x175/0x9d0 kernel/locking/mutex.c:747
>  pcpu_alloc+0xbb8/0x1420 mm/percpu.c:1769
>  packet_alloc_pending net/packet/af_packet.c:1232 [inline]
>  packet_create+0x2b7/0x8e0 net/packet/af_packet.c:3373
>  __sock_create+0x328/0x800 net/socket.c:1569
>  sock_create net/socket.c:1620 [inline]
>  __sys_socket_create net/socket.c:1657 [inline]
>  __sys_socket+0x14c/0x260 net/socket.c:1704
>  __do_sys_socket net/socket.c:1718 [inline]
>  __se_sys_socket net/socket.c:1716 [inline]
>  __x64_sys_socket+0x72/0xb0 net/socket.c:1716
>  do_syscall_x64 arch/x86/entry/common.c:51 [inline]
>  do_syscall_64+0x40/0x110 arch/x86/entry/common.c:82
>  entry_SYSCALL_64_after_hwframe+0x63/0x6b
> RIP: 0033:0x7fe940479de9
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 d1 19 00 00 90 48 89 f8 48
> 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
> 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffe1bf080b8 EFLAGS: 00000246 ORIG_RAX: 0000000000000029
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fe940479de9
> RDX: 0000000000000000 RSI: 0000000800000003 RDI: 0000000000000011
> RBP: 00000000000f4240 R08: 0000000000000000 R09: 0000000100000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffe1bf08110
> R13: 0000000000030c67 R14: 00007ffe1bf080dc R15: 0000000000000003
>  </TASK>
> INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 1.067=
 msecs
> rcu: rcu_preempt kthread timer wakeup didn't happen for 10497 jiffies!
> g5017 f0x0 RCU_GP_WAIT_FQS(5) ->state=3D0x402
> rcu:    Possible timer handling issue on cpu=3D0 timer-softirq=3D2416
> rcu: rcu_preempt kthread starved for 10498 jiffies! g5017 f0x0
> RCU_GP_WAIT_FQS(5) ->state=3D0x402 ->cpu=3D0
> rcu:    Unless rcu_preempt kthread gets sufficient CPU time, OOM is
> now expected behavior.
> rcu: RCU grace-period kthread stack dump:
> task:rcu_preempt     state:I stack:27904 pid:17    tgid:17    ppid:2
>    flags:0x00004000
> Call Trace:
>  <TASK>
>  context_switch kernel/sched/core.c:5376 [inline]
>  __schedule+0xedb/0x5af0 kernel/sched/core.c:6688
>  __schedule_loop kernel/sched/core.c:6763 [inline]
>  schedule+0xe9/0x270 kernel/sched/core.c:6778
>  schedule_timeout+0x137/0x290 kernel/time/timer.c:2167
>  rcu_gp_fqs_loop+0x1ec/0xb10 kernel/rcu/tree.c:1631
>  rcu_gp_kthread+0x24b/0x380 kernel/rcu/tree.c:1830
>  kthread+0x2c6/0x3a0 kernel/kthread.c:388
>  ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
>  </TASK>
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> For information about bisection process see: https://goo.gl/tpsmEJ#bisect=
ion
>
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
>
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
>
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
>
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
>
> If you want to undo deduplication, reply with:
> #syz undup

--=20
Vinicius


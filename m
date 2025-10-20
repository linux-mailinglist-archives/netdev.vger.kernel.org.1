Return-Path: <netdev+bounces-230878-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 681C1BF0E0D
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 13:38:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3591F4E1274
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 11:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 130062FE06D;
	Mon, 20 Oct 2025 11:38:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3702C2E8B98
	for <netdev@vger.kernel.org>; Mon, 20 Oct 2025 11:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760960311; cv=none; b=lDEr7Ol439C7htOkQal3ghqa1LpyQlQENPGHqpu5vcrirTrQtudOoG1S3kIcPb4fc1k2VpduL+Wxsju36yLFA9LfzngRL6Utu6jwn4W23BbY8hhh/FBonmGErjyqVXcuhvlr3Lh/nzPUDlY1ykrAM1uqsL5bv4vyhF0OcTghFC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760960311; c=relaxed/simple;
	bh=nVNdc+bElqfdDMNVlJB5mmE6L+bL92tTvVCC0tuI8ZU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=FS5vR63CYDUL1qb1nx6mSMS+uUKkVx39pskcjNj/8kkDsHlmdibGsN01UsRQwEGxuO6wNq3YLmA4vITs6gM4fWlC739chNZunENLKxmnbTq/e3uVAS6t7HhmYcqLHOSJC4DeKpnfyZ5/5bklqGvn5kdfyo2N/Q/qANJrwliU3mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-93e8db8badeso154420739f.3
        for <netdev@vger.kernel.org>; Mon, 20 Oct 2025 04:38:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760960308; x=1761565108;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N8CK+chTKx9rsEaPQt4laFwFXYyo/LUomWo19HYjkvw=;
        b=VBQUn2f9E6+WRLnAdorUosDorc+GWBc4vx8hZFptGC9xB1l1M24vpePck4Zm0T1uRN
         S9obRq73fVnlBRFCqIfWOuHnYdCSA7UNL273nUoGjZI2LPBetFia+u4Q+dMbbo3vLCSo
         FtUA0H+csXeNzhGjhdmkilCiiWxMdX5/I1imUXULPpzZM0fp1t0RGGoc0/4STP/9sJ6s
         BOWzWSXIt5ir57h06BeexwwF6Yc2qGPnKkEcAPje7VMIKJGUk4Pi0342m8JkMANocnKO
         AjYJsTOdTdzQG1hmk9zl6YusXbrUwLJqErzxbu4GomdzZOGy0xtUe8QD6J1MQHvB3/C3
         /ung==
X-Forwarded-Encrypted: i=1; AJvYcCUFX27pCaoQUA9K/R/R5diKl3l2h7k91Ot2Hc2CTkHv/ZWAFds3qMarsVhRaEtrydOoz0w9/pU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfGi61Q1wA+CUIsyJftQDeLNuuSz5BDlRdjSLbIwaQQhqSMZ4K
	x0W872GpHv756CYBlLsmppE3lLKm6WfRL+csSQWXe3/LbB29Jez3DpixdLdIylXIM/OcffgqQ6W
	NrC89vc7+gMeU4h/tT47zb3UWNOxaXbcCJa4edW8j5hxYtWL6/zyHoW3Gk8s=
X-Google-Smtp-Source: AGHT+IESARV6Rzp6WQud5MHhBqEpjYbkgI4q5NleuAzRvx/nSQ/JNphlDIdWqybCpLo4msCr7FPS9vlQwTQ0cPvjTWLWYyz/nUms
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:14cb:b0:93e:856a:2fe8 with SMTP id
 ca18e2360f4ac-93e856a325emr1481601439f.19.1760960308285; Mon, 20 Oct 2025
 04:38:28 -0700 (PDT)
Date: Mon, 20 Oct 2025 04:38:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f61f34.a70a0220.205af.002f.GAE@google.com>
Subject: [syzbot] [net?] BUG: soft lockup in xfrm_policy_timer
From: syzbot <syzbot+4eba0fa4e072709f8c2d@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, herbert@gondor.apana.org.au, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, steffen.klassert@secunet.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    bf45a62baffc Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=11c95542580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bd2356106f507975
dashboard link: https://syzkaller.appspot.com/bug?extid=4eba0fa4e072709f8c2d
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f0d4874557e9/disk-bf45a62b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0bf44a13b5b2/vmlinux-bf45a62b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/18db8bc9907c/Image-bf45a62b.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4eba0fa4e072709f8c2d@syzkaller.appspotmail.com

watchdog: BUG: soft lockup - CPU#0 stuck for 22s! [swapper/0:0]
Modules linked in:
irq event stamp: 314797
hardirqs last  enabled at (314796): [<ffff80008b062b20>] __exit_to_kernel_mode arch/arm64/kernel/entry-common.c:68 [inline]
hardirqs last  enabled at (314796): [<ffff80008b062b20>] exit_to_kernel_mode+0x10/0x1c arch/arm64/kernel/entry-common.c:75
hardirqs last disabled at (314797): [<ffff80008b062af0>] __enter_from_kernel_mode arch/arm64/kernel/entry-common.c:43 [inline]
hardirqs last disabled at (314797): [<ffff80008b062af0>] enter_from_kernel_mode+0x14/0x34 arch/arm64/kernel/entry-common.c:50
softirqs last  enabled at (310210): [<ffff8000803db160>] softirq_handle_end kernel/softirq.c:425 [inline]
softirqs last  enabled at (310210): [<ffff8000803db160>] handle_softirqs+0xaf8/0xc88 kernel/softirq.c:607
softirqs last disabled at (310295): [<ffff800080022028>] __do_softirq+0x14/0x20 kernel/softirq.c:613
CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted syzkaller #0 PREEMPT 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/30/2025
pstate: 03400005 (nzcv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
pc : queued_spin_lock_slowpath+0x138/0xaec kernel/locking/qspinlock.c:197
lr : queued_spin_lock_slowpath+0x144/0xaec kernel/locking/qspinlock.c:197
sp : ffff800097c17940
x29: ffff800097c179e0 x28: 1fffe0001b7fe7a1 x27: 1ffff00011f10c32
x26: ffff80008f886180 x25: dfff800000000000 x24: ffff700012f82f2c
x23: 0000000000000001 x22: ffff80008f886190 x21: ffff0000dbff3d08
x20: ffff0000dbff3d10 x19: ffff0000dbff3d00 x18: 1fffe00033771c88
x17: ffff80010c3e8000 x16: ffff800080537d14 x15: 0000000000000001
x14: 1fffe0001b7fe7a0 x13: 0000000000000000 x12: 0000000000000000
x11: ffff60001b7fe7a1 x10: dfff800000000000 x9 : 0000000000000000
x8 : 0000000000000001 x7 : ffff800089d8c26c x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000000001 x3 : ffff80008b0885f8
x2 : 0000000000000000 x1 : 0000000000000001 x0 : 0000000000000001
Call trace:
 __cmpwait_case_8 arch/arm64/include/asm/cmpxchg.h:229 [inline] (P)
 __cmpwait arch/arm64/include/asm/cmpxchg.h:257 [inline] (P)
 queued_spin_lock_slowpath+0x138/0xaec kernel/locking/qspinlock.c:197 (P)
 queued_spin_lock include/asm-generic/qspinlock.h:114 [inline]
 do_raw_spin_lock+0x2a8/0x2cc kernel/locking/spinlock_debug.c:116
 __raw_spin_lock_bh include/linux/spinlock_api_smp.h:127 [inline]
 _raw_spin_lock_bh+0x50/0x60 kernel/locking/spinlock.c:178
 spin_lock_bh include/linux/spinlock.h:356 [inline]
 xfrm_policy_kill+0x238/0x4a4 net/xfrm/xfrm_policy.c:498
 xfrm_policy_delete net/xfrm/xfrm_policy.c:2372 [inline]
 xfrm_policy_timer+0x2fc/0x640 net/xfrm/xfrm_policy.c:419
 call_timer_fn+0x1b4/0x818 kernel/time/timer.c:1747
 expire_timers kernel/time/timer.c:1798 [inline]
 __run_timers kernel/time/timer.c:2372 [inline]
 __run_timer_base+0x51c/0x76c kernel/time/timer.c:2384
 run_timer_base kernel/time/timer.c:2393 [inline]
 run_timer_softirq+0xcc/0x194 kernel/time/timer.c:2403
 handle_softirqs+0x328/0xc88 kernel/softirq.c:579
 __do_softirq+0x14/0x20 kernel/softirq.c:613
 ____do_softirq+0x14/0x20 arch/arm64/kernel/irq.c:68
 call_on_irq_stack+0x30/0x48 arch/arm64/kernel/entry.S:891
 do_softirq_own_stack+0x20/0x2c arch/arm64/kernel/irq.c:73
 invoke_softirq kernel/softirq.c:460 [inline]
 __irq_exit_rcu+0x1b0/0x478 kernel/softirq.c:680
 irq_exit_rcu+0x14/0x84 kernel/softirq.c:696
 __el1_irq arch/arm64/kernel/entry-common.c:520 [inline]
 el1_interrupt+0x40/0x60 arch/arm64/kernel/entry-common.c:532
 el1h_64_irq_handler+0x18/0x24 arch/arm64/kernel/entry-common.c:537
 el1h_64_irq+0x6c/0x70 arch/arm64/kernel/entry.S:592
 __daif_local_irq_enable arch/arm64/include/asm/irqflags.h:26 [inline] (P)
 arch_local_irq_enable+0x8/0xc arch/arm64/include/asm/irqflags.h:48 (P)
 cpuidle_idle_call kernel/sched/idle.c:190 [inline]
 do_idle+0x1d8/0x454 kernel/sched/idle.c:330
 cpu_startup_entry+0x5c/0x74 kernel/sched/idle.c:428
 rest_init+0x2d8/0x2f4 init/main.c:744
 start_kernel+0x390/0x3e0 init/main.c:1097
 __primary_switched+0x8c/0x94 arch/arm64/kernel/head.S:246
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 7396 Comm: syz.1.139 Not tainted syzkaller #0 PREEMPT 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/30/2025
pstate: 83400005 (Nzcv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
pc : __sanitizer_cov_trace_pc+0x8/0x84 kernel/kcov.c:213
lr : xfrm_state_lookup_spi_proto net/xfrm/xfrm_state.c:1708 [inline]
lr : xfrm_alloc_spi+0x48c/0xd04 net/xfrm/xfrm_state.c:2589
sp : ffff8000a2e76f30
x29: ffff8000a2e77040 x28: 0000000000000033 x27: 0000000000000003
x26: ffff0000dbff2440 x25: ffff0000dbff38e0 x24: dfff800000000000
x23: ffff0000f4c69540 x22: ffff0000dbff38e0 x21: 00000000000018c0
x20: 00000000634d0100 x19: 0000000000060000 x18: 0000000000000000
x17: 00000000ffff0000 x16: ffff80008b065bd0 x15: ffff7000145cedd0
x14: 1ffff000145cedd0 x13: 0000000000000004 x12: ffffffffffffffff
x11: 0000000000080000 x10: 0000000000ff0100 x9 : 0000000000000002
x8 : ffff0000dbf2db80 x7 : ffff800089dc6ba0 x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000000000 x3 : 0000000000000002
x2 : 0000000000000008 x1 : 00000000634d0100 x0 : 0000000000060000
Call trace:
 __sanitizer_cov_trace_pc+0x8/0x84 kernel/kcov.c:210 (P)
 xfrm_alloc_userspi+0x55c/0x9c8 net/xfrm/xfrm_user.c:1873
 xfrm_user_rcv_msg+0x588/0x7c4 net/xfrm/xfrm_user.c:3501
 netlink_rcv_skb+0x220/0x3fc net/netlink/af_netlink.c:2552
 xfrm_netlink_rcv+0x80/0x9c net/xfrm/xfrm_user.c:3523
 netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
 netlink_unicast+0x694/0x8c4 net/netlink/af_netlink.c:1346
 netlink_sendmsg+0x648/0x930 net/netlink/af_netlink.c:1896
 sock_sendmsg_nosec net/socket.c:714 [inline]
 __sock_sendmsg net/socket.c:729 [inline]
 ____sys_sendmsg+0x490/0x7b8 net/socket.c:2614
 ___sys_sendmsg+0x204/0x278 net/socket.c:2668
 __sys_sendmsg net/socket.c:2700 [inline]
 __do_sys_sendmsg net/socket.c:2705 [inline]
 __se_sys_sendmsg net/socket.c:2703 [inline]
 __arm64_sys_sendmsg+0x184/0x238 net/socket.c:2703
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x254 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
 el0_svc+0x5c/0x254 arch/arm64/kernel/entry-common.c:744
 el0t_64_sync_handler+0x84/0x12c arch/arm64/kernel/entry-common.c:763
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:596


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


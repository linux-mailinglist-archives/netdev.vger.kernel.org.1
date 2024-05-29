Return-Path: <netdev+bounces-99206-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 235C58D41B3
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 01:10:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE2D5284632
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 23:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91D021CB31C;
	Wed, 29 May 2024 23:10:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB1D178360
	for <netdev@vger.kernel.org>; Wed, 29 May 2024 23:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717024205; cv=none; b=CR7IrTvOTl4Zyxb38E8lccSjht8/PVmkaelWpkxcYYivg0brmEDVzc4PnjK33I6vKSDlicgNHY5ICii/qL24MvC+bEJtltxj8xxzyo+SbC/5bHQxIBoB7DzVPyQyIdkDfl9QGitZJ4FO8a3wghYE4jhAP7JeMYo3VzNH6EaeimI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717024205; c=relaxed/simple;
	bh=aUcdWCMLV2Ko5G/J4AtCbG705B3p09pva3y/wsykGPI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=L3fDBhhF0G8py+NLz7ohf9dMJPxpqePfsWprFRRDpxlrUxiVW8gPDB9cAbQ+ebrelZDsgbSfjyuGDiSTcuSJv1TtG1C3pidih3p3aj+Mq27iVuRwL1XscebyTlmDtidfn1t4DUuEie8x8FvNw86o5RiES4totBpE/2okSI74LFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7eac4d26336so30219039f.2
        for <netdev@vger.kernel.org>; Wed, 29 May 2024 16:10:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717024203; x=1717629003;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=le8xpKyVOWznnS1DqEaKJXXI5P2bpZs5ptmd/ntjvJk=;
        b=FGrU/+le9sF1E6AnJJraSCVvqHCK/1HnbWdrzfPnrHkahn1myFt4LFs0fuxgc+WlVe
         JlysLDX6e+3ECVJ6CbdDR2Xk954A2PXZCRbA5i5pbgcuy8hGrTZdF1M8xiJfP4DHo7c4
         PAspNAXR1i+0THaJnVPNVShgk15MoLEHGRHHwsAF0OH0hJb+h/xZYeZWT+vq5IOpmyJx
         DVKyb9om7X2IrYQipLc6YmuFtndWCovJKueJy7sB4O8AhiX/tvBSMlVjHOAuA1u/d04K
         2JyadvVOrMKN8z+ic1Vk2BRO6fmXRmlCaNnpkvmBKYIsx2LmPDV98LGmJCPctQ6Uc1jd
         OtKw==
X-Forwarded-Encrypted: i=1; AJvYcCVU+r+FgtWLEyzItAj0UNeYB2/eRL0lCuTjCYszrGgT4IFwUEDjDt71/lOzSrYEzWzJ9u8y6cw0V+qtdJGw+M7fVpjlPj/W
X-Gm-Message-State: AOJu0Yzzi2A20fuXtKNSYuCOQ5Z6Af7ESkdKK2BEPPOwS+AREjpTb3fR
	p3hFVetkYBXSfsYbZLZvwPaIxrM+9KdFvE16drTaA1ZGbMpc53pwiob4woSQYjWUJxUyZZ3tCsk
	VWQLxwcc1ub91h0VcJJuUh2ZBJGaD0SMGfrlfYQYpS56N9f3BtWIB8Ac=
X-Google-Smtp-Source: AGHT+IF628Hq7DAY03hVT0vQjY42e6tz/nx6jxRDZh9j/ZFPCTIdVgsy8X2q5aFPz0GqM13QA319Mkl4RgfFNhxzIAtP03oPlX2C
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:236:b0:48a:37e1:a543 with SMTP id
 8926c6da1cb9f-4b1ed16f015mr11549173.6.1717024202833; Wed, 29 May 2024
 16:10:02 -0700 (PDT)
Date: Wed, 29 May 2024 16:10:02 -0700
In-Reply-To: <20240529225214.2968-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ae4d6e06199fd917@google.com>
Subject: Re: [syzbot] [net?] INFO: rcu detected stall in packet_release
From: syzbot <syzbot+a7d2b1d5d1af83035567@syzkaller.appspotmail.com>
To: edumazet@google.com, hdanton@sina.com, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, radoslaw.zielonek@gmail.com, 
	syzkaller-bugs@googlegroups.com, vinicius.gomes@intel.com, 
	vladimir.oltean@nxp.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
INFO: rcu detected stall in sctp_addr_wq_timeout_handler

rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: { 1-...D } 2647 jiffies s: 2345 root: 0x2/.
rcu: blocking rcu_node structures (internal RCU debug):
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 PID: 5448 Comm: dhcpcd Not tainted 6.9.0-syzkaller-12116-g782471db6c72-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
RIP: 0010:check_kcov_mode kernel/kcov.c:173 [inline]
RIP: 0010:write_comp_data kernel/kcov.c:236 [inline]
RIP: 0010:__sanitizer_cov_trace_const_cmp4+0x1f/0x90 kernel/kcov.c:304
Code: 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 4c 8b 04 24 65 48 8b 14 25 00 d5 03 00 65 8b 05 60 4b 6e 7e a9 00 01 ff 00 74 10 <a9> 00 01 00 00 74 5b 83 ba 1c 16 00 00 00 74 52 8b 82 f8 15 00 00
RSP: 0018:ffffc90000a18168 EFLAGS: 00000006
RAX: 0000000000010303 RBX: ffffffff89814b22 RCX: ffff88807bd9da00
RDX: ffff88807bd9da00 RSI: 0000000000000001 RDI: 0000000000000000
RBP: 0000000000000001 R08: ffffffff89814b52 R09: 1ffffffff25f04b0
R10: dffffc0000000000 R11: fffffbfff25f04b1 R12: dffffc0000000000
R13: ffff888024155808 R14: ffff888024155800 R15: ffff888023e05360
FS:  00007fc8f8104740(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fc8f805eff8 CR3: 000000007cda8000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <IRQ>
 rcu_read_lock include/linux/rcupdate.h:782 [inline]
 advance_sched+0xa32/0xca0 net/sched/sch_taprio.c:985
 __run_hrtimer kernel/time/hrtimer.c:1687 [inline]
 __hrtimer_run_queues+0x59b/0xd50 kernel/time/hrtimer.c:1751
 hrtimer_interrupt+0x396/0x990 kernel/time/hrtimer.c:1813
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1032 [inline]
 __sysvec_apic_timer_interrupt+0x110/0x3f0 arch/x86/kernel/apic/apic.c:1049
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
 sysvec_apic_timer_interrupt+0x52/0xc0 arch/x86/kernel/apic/apic.c:1043
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:get_current arch/x86/include/asm/current.h:49 [inline]
RIP: 0010:write_comp_data kernel/kcov.c:235 [inline]
RIP: 0010:__sanitizer_cov_trace_const_cmp4+0x8/0x90 kernel/kcov.c:304
Code: 44 0a 20 c3 cc cc cc cc 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 4c 8b 04 24 <65> 48 8b 14 25 00 d5 03 00 65 8b 05 60 4b 6e 7e a9 00 01 ff 00 74
RSP: 0018:ffffc90000a185b8 EFLAGS: 00000246
RAX: ffffc90000a18700 RBX: 0000000000000002 RCX: ffffc90000a11000
RDX: 0000000000000003 RSI: 0000000000000002 RDI: 0000000000000000
RBP: 1ffff920001430e2 R08: ffffffff814090ad R09: ffffffff81409006
R10: 0000000000000003 R11: ffff88807bd9da00 R12: ffffc90000a186f8
R13: ffffc90000a19000 R14: 1ffff920001430e1 R15: dffffc0000000000
 on_stack arch/x86/include/asm/stacktrace.h:58 [inline]
 stack_access_ok arch/x86/kernel/unwind_orc.c:393 [inline]
 deref_stack_reg arch/x86/kernel/unwind_orc.c:403 [inline]
 unwind_next_frame+0x109d/0x2a00 arch/x86/kernel/unwind_orc.c:585
 __unwind_start+0x641/0x7c0 arch/x86/kernel/unwind_orc.c:760
 unwind_start arch/x86/include/asm/unwind.h:64 [inline]
 arch_stack_walk+0x103/0x1b0 arch/x86/kernel/stacktrace.c:24
 stack_trace_save+0x118/0x1d0 kernel/stacktrace.c:122
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:579
 poison_slab_object+0xe0/0x150 mm/kasan/common.c:240
 __kasan_slab_free+0x37/0x60 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2195 [inline]
 slab_free mm/slub.c:4436 [inline]
 kfree+0x14a/0x370 mm/slub.c:4557
 sctp_addr_wq_timeout_handler+0x2e6/0x470 net/sctp/protocol.c:685
 call_timer_fn+0x18e/0x650 kernel/time/timer.c:1792
 expire_timers kernel/time/timer.c:1843 [inline]
 __run_timers kernel/time/timer.c:2417 [inline]
 __run_timer_base+0x66a/0x8e0 kernel/time/timer.c:2428
 run_timer_base kernel/time/timer.c:2437 [inline]
 run_timer_softirq+0xb7/0x170 kernel/time/timer.c:2447
 handle_softirqs+0x2c4/0x970 kernel/softirq.c:554
 __do_softirq kernel/softirq.c:588 [inline]
 invoke_softirq kernel/softirq.c:428 [inline]
 __irq_exit_rcu+0xf4/0x1c0 kernel/softirq.c:637
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:649
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
 sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1043
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:__raw_spin_unlock_irq include/linux/spinlock_api_smp.h:160 [inline]
RIP: 0010:_raw_spin_unlock_irq+0x29/0x50 kernel/locking/spinlock.c:202
Code: 90 f3 0f 1e fa 53 48 89 fb 48 83 c7 18 48 8b 74 24 08 e8 ca ab ee f5 48 89 df e8 e2 ef ef f5 e8 fd 94 19 f6 fb bf 01 00 00 00 <e8> d2 cc e1 f5 65 8b 05 f3 77 80 74 85 c0 74 06 5b c3 cc cc cc cc
RSP: 0018:ffffc90004917cf0 EFLAGS: 00000286
RAX: 8cf5a8119035ed00 RBX: ffff8880275fae40 RCX: ffffffff9477a603
RDX: dffffc0000000000 RSI: ffffffff8bcabc20 RDI: 0000000000000001
RBP: ffffc90004917dd0 R08: ffffffff8fac132f R09: 1ffffffff1f58265
R10: dffffc0000000000 R11: fffffbfff1f58266 R12: 1ffff1100f7b3c63
R13: 00000000000006e0 R14: ffff88807bd9e318 R15: dffffc0000000000
 do_sigaction+0x1f3/0x530
 __do_sys_rt_sigaction kernel/signal.c:4499 [inline]
 __se_sys_rt_sigaction kernel/signal.c:4484 [inline]
 __x64_sys_rt_sigaction+0x1b9/0x290 kernel/signal.c:4484
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fc8f813eb57
Code: 4d 85 c0 74 0e 48 8d 54 24 20 31 f6 48 85 c0 75 04 eb 07 31 d2 48 8d 74 24 88 41 ba 08 00 00 00 44 89 cf b8 0d 00 00 00 0f 05 <48> 3d 00 f0 ff ff 76 10 48 8b 15 a2 a2 16 00 f7 d8 64 89 02 48 83
RSP: 002b:00007fc8f805edc0 EFLAGS: 00000246 ORIG_RAX: 000000000000000d
RAX: ffffffffffffffda RBX: 00007ffd0b08de50 RCX: 00007fc8f813eb57
RDX: 00007fc8f805ede0 RSI: 0000000000000000 RDI: 0000000000000038
RBP: 00007fc8f805eff0 R08: 00007fc8f805ef28 R09: 0000000000000038
R10: 0000000000000008 R11: 0000000000000246 R12: 00007ffd0b08e168
R13: 00007fc8f805ef28 R14: 0000000000000000 R15: 0000000000000038
 </TASK>


Tested on:

commit:         782471db Merge branch 'xilinx-clock-support'
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git main
console output: https://syzkaller.appspot.com/x/log.txt?x=14a7c3ec980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=98a238b2569af6d
dashboard link: https://syzkaller.appspot.com/bug?extid=a7d2b1d5d1af83035567
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1491d7c6980000



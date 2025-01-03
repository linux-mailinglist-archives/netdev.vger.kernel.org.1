Return-Path: <netdev+bounces-155053-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 658AAA00D71
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 19:12:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A5C83A4483
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 18:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14B871FA259;
	Fri,  3 Jan 2025 18:12:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426F019DF99
	for <netdev@vger.kernel.org>; Fri,  3 Jan 2025 18:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735927925; cv=none; b=mSuLM+AAFiqp1nz9TsAOqE3hHhFZsygfMMOfi4W9zg2djeAM3vRZu3DVSOUCQh4rMu/w2j/tfu120SP9/YcIzSpRKtrB5JcrY7JRR01cR46RI6CX94yaPCR9z7PWd2fWqkKpL7RA4gsAGY24gzd8LMgoaCoxWPSNt1jJzCCRXz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735927925; c=relaxed/simple;
	bh=hH2y6oe4m4mW5v0IfDKBa58hn4F+V29hNREUD5Mz8lg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Y2xeg7ME7pcun9qZeC4R1MRPfkfR1YFv2vMqNW+9Sl4b3qi2wQ+t1nWm5vncw8goIct2dWEOelmOA/TkZ9LU5G9zUaHiPd5SWyd8bgouGFQw2CTiZkhZBkUzqVrguszClGn2w2ViHaBD46SWvPzvDMo20OyeWyjQFGnkLaqyRZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a7e0d7b804so106465185ab.0
        for <netdev@vger.kernel.org>; Fri, 03 Jan 2025 10:12:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735927922; x=1736532722;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yDv2wMD/9z8tLKIX7sFbYEax1jlO2ZPeAd5RVF3rFhk=;
        b=Q3SdTvNUcgcOyLL85eq5pZduLCCXh2EsMJHNEJBhbn5TlTnsLlJce/NXUeR994IzAO
         xdCxZQ8wrGiPNs8yaGKICtGd0xd2XrH1Zj8CLwQGq35FqamAO/YgQdwvoB0N2PkONpPh
         ykTFWIA8AfPs1zHIE1kIm4TRQ593EQrpeEnAox/CRIUcPfhy3np5pUZZHixwdMtKeFHK
         39r85xPPAaMJCbtGzSh7NZcR4K7jSHorheGfqX8YC8EEOqFHYxQQYab/bBVsNoyA2YrD
         SNXrd+ASfVAiClw22A0M0TgObMGqxGpeU/AF7Uu00zbIafdcB26TrCuEn8ficGBszlYg
         u4ag==
X-Forwarded-Encrypted: i=1; AJvYcCU8hEAur0JKYZQij9uyfNfwZ7yoPFFnrZYs7Q79xOr+QkV9kfs+zuOFjFJU1au/7UWcNBgMfqo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYYIN5dzG1dTLUPl7FMuxrhVX6Zr8kB/UZe7qB/pgcW5JJ9lCo
	Cof/bg0a94to+iN+Dr82HC1t3ChXQvk0nIQTTlxdvJGnMdCqo/AhKJ/ohSdEVAerNk7cgLXuwXq
	JfBVNPKZQPvg+YDCwuWySvYidSII1Y1D8G9xuk1YC+dzEde6Kt3mdqlM=
X-Google-Smtp-Source: AGHT+IFXgauIk9Ujujvf9UreQiskh8zdVVifb21Vegc/JPPv6tbR5VbHD8ekzm4UxakmDCricQwkjVbixooA+bgwUo7RXLOfdiXT
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:184c:b0:3a7:635e:d365 with SMTP id
 e9e14a558f8ab-3c2d25669c7mr435848735ab.6.1735927922458; Fri, 03 Jan 2025
 10:12:02 -0800 (PST)
Date: Fri, 03 Jan 2025 10:12:02 -0800
In-Reply-To: <87ttaf7q7x.fsf@toke.dk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67782872.050a0220.178762.004a.GAE@google.com>
Subject: Re: [syzbot] [wireless?] INFO: task hung in ath9k_hif_usb_firmware_cb (3)
From: syzbot <syzbot+e9b1ff41aa6a7ebf9640@syzkaller.appspotmail.com>
To: kvalo@kernel.org, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, nbd@nbd.name, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, toke@toke.dk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
INFO: rcu detected stall in worker_thread

rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 	(detected by 0, t=10502 jiffies, g=17573, q=329 ncpus=2)
rcu: All QSes seen, last rcu_preempt kthread activity 10486 (4294966972-4294956486), jiffies_till_next_fqs=1, root ->qsmask 0x0
rcu: rcu_preempt kthread starved for 10486 jiffies! g17573 f0x2 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=1
rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_preempt     state:R  running task     stack:26264 pid:17    tgid:17    ppid:2      flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5369 [inline]
 __schedule+0x1850/0x4c30 kernel/sched/core.c:6756
 __schedule_loop kernel/sched/core.c:6833 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6848
 schedule_timeout+0x15a/0x290 kernel/time/sleep_timeout.c:99
 rcu_gp_fqs_loop+0x2df/0x1330 kernel/rcu/tree.c:2045
 rcu_gp_kthread+0xa7/0x3b0 kernel/rcu/tree.c:2247
 kthread+0x2f2/0x390 kernel/kthread.c:389
 ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
rcu: Stack dump where RCU GP kthread last ran:
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 5932 Comm: kworker/1:5 Not tainted 6.13.0-rc5-syzkaller-g0bc21e701a6f-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Workqueue: events_power_efficient neigh_periodic_work
RIP: 0010:usb_pipe_endpoint include/linux/usb.h:2009 [inline]
RIP: 0010:usb_submit_urb+0x16c/0x1930 drivers/usb/core/urb.c:391
Code: f3 0f 85 d6 10 00 00 48 89 6c 24 38 44 8b 75 00 31 ed 44 89 f6 81 e6 80 00 00 00 40 0f 94 c5 31 ff e8 08 fc 5d fa 48 c1 e5 07 <48> 03 6c 24 20 4c 89 f0 48 c1 e8 0c 83 e0 78 48 8d ac 28 40 05 00
RSP: 0018:ffffc90000a18790 EFLAGS: 00000056
RAX: 0000000000000100 RBX: dffffc0000000000 RCX: ffff88807cb18000
RDX: ffff88807cb18000 RSI: 0000000000000080 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffff87417c18 R09: 1ffff1100660c25f
R10: dffffc0000000000 R11: ffffed100660c260 R12: 1ffff11029ad3803
R13: ffff88807436ae00 R14: 0000000040018280 R15: ffff88814d69c018
FS:  0000000000000000(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b2d05ffff CR3: 0000000074124000 CR4: 0000000000350ef0
Call Trace:
 <NMI>
 </NMI>
 <IRQ>
 ath9k_hif_usb_reg_in_cb+0x4ce/0x6e0 drivers/net/wireless/ath/ath9k/hif_usb.c:790
 __usb_hcd_giveback_urb+0x42e/0x6e0 drivers/usb/core/hcd.c:1650
 dummy_timer+0x856/0x4620 drivers/usb/gadget/udc/dummy_hcd.c:1993
 __run_hrtimer kernel/time/hrtimer.c:1739 [inline]
 __hrtimer_run_queues+0x59d/0xd30 kernel/time/hrtimer.c:1803
 hrtimer_run_softirq+0x19a/0x2c0 kernel/time/hrtimer.c:1820
 handle_softirqs+0x2d6/0x9b0 kernel/softirq.c:561
 __do_softirq kernel/softirq.c:595 [inline]
 invoke_softirq kernel/softirq.c:435 [inline]
 __irq_exit_rcu+0xf7/0x220 kernel/softirq.c:662
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:678
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1049 [inline]
 sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1049
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:should_resched arch/x86/include/asm/preempt.h:103 [inline]
RIP: 0010:__local_bh_enable_ip+0x170/0x200 kernel/softirq.c:396
Code: 8c e8 e4 03 67 0a 65 66 8b 05 f4 10 a2 7e 66 85 c0 75 5d bf 01 00 00 00 e8 1d bd 0b 00 e8 c8 68 45 00 fb 65 8b 05 b8 10 a2 7e <85> c0 75 05 e8 37 82 a8 ff 48 c7 44 24 20 0e 36 e0 45 49 c7 04 1c
RSP: 0018:ffffc900041dfa80 EFLAGS: 00000282
RAX: 0000000080000000 RBX: 1ffff9200083bf54 RCX: ffffffff817b274a
RDX: dffffc0000000000 RSI: ffffffff8c0a98e0 RDI: ffffffff8c5fb0e0
RBP: ffffc900041dfb28 R08: ffffffff942a494f R09: 1ffffffff2854929
R10: dffffc0000000000 R11: fffffbfff285492a R12: dffffc0000000000
R13: 1ffff9200083bf58 R14: ffffc900041dfac0 R15: 0000000000000201
 neigh_periodic_work+0xbcb/0xde0 net/core/neighbour.c:968
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa68/0x1840 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f2/0x390 kernel/kthread.c:389
 ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>


Tested on:

commit:         0bc21e70 MAINTAINERS: Remove Olof from SoC maintainers
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16c156c4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1c541fa8af5c9cc7
dashboard link: https://syzkaller.appspot.com/bug?extid=e9b1ff41aa6a7ebf9640
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=158b0edf980000



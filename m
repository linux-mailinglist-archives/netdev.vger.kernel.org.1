Return-Path: <netdev+bounces-131684-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90B7598F407
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 18:17:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD3ACB23976
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 16:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD56C1AAE1C;
	Thu,  3 Oct 2024 16:14:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B241A707B
	for <netdev@vger.kernel.org>; Thu,  3 Oct 2024 16:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727972072; cv=none; b=p+EO5rQa3N7jYwTKO3UL2BYEsk3R+DMrWfglycm0mfDqDP9yIiYhVoJSycLyUaqziDS/ZwZzVr4F94bhzb8VDh9hQbvvcFIhndMKdRY4+57B4Bwy9D6LN0cROm9AgG5bzxFpBVvZBwDAyCDDeeguM2fULq2YC7CfalzuokcDln0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727972072; c=relaxed/simple;
	bh=mDbtd6kDQBuyX9bt6LJwBD31ByVWOkWsE7whdjylih0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=BsLZeT4iZP108kTIC88FBVoOmJc/bQV15Y2PItyyIzMTaXXbMAHmWuG5dtj+3kgopWFXqV9k3jhtxAEYhBZl6HMplTgWqxmtZdRZQQK4K+mAiHumaU1YzzmKyTT0nOCfh2Ebs+VuK6t9ethbTEOdOfqDRoDFlKq/8Y1NHp5EZPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-82cdb749559so173356339f.2
        for <netdev@vger.kernel.org>; Thu, 03 Oct 2024 09:14:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727972067; x=1728576867;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ekltoWzHJ3MQltJukcbxO4hxJ5C7Yl8tH5NS7eKdODA=;
        b=SS6VlPH8kR1+4B8nb7OcCCc0n+8tyUTbn/m3UWANqXcne0yxz+CfVE9sa3cCIa64Vi
         4fmerAabbDhtE6lGpb13HTuMv35YGxSJm84rfZ18s6i1xk3gkQn4URV2BJzs3sQekR0Q
         /UI2RE3hUziPL9g4sPpW1MApslKM0NtLriiGHF89pMwPa13af+AeKHtaTijbcSc995PP
         EWyWxGAY5SePwZ8ZLjIYaipAjYNZEIXm0zQQT9DGzkIr3PuEJoPt5OKR/E/q50KJwJbX
         Sw44krd6wAIRXJDDkZXxmJZzFxYC1GoAygjGNAjFPWpozS2v82gGxkgdFw4Sd8hOPyZE
         4qzg==
X-Forwarded-Encrypted: i=1; AJvYcCVGbPXyqVJ28BbBIrW/tMoLJmfMoYWL/o5sd1DnagOOLmNccLykNpY0xw6V4z6oUJkHyvIDtvE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5S0YYNhin0xm5klaO28dQKHriGW0f5MXNCpctzoD+7ghk7QLA
	M0etGQMZcZlS2wwGwsO9db0ui2U4kciB8qM2+N8Nl77NyZi1XZQLwtvAK9oXatA5uj09azN1r2u
	tJlsxSUgdhgiij09jNJoZY/HeGO+hQtbnxAX8qT/kdaLXNnoOjNqYsNQ=
X-Google-Smtp-Source: AGHT+IGGb/I9Two01ejYoVMQENRZ6Z05K7sUaCiC5r5GDDptv6VS+C6FGzvDY8RZ2v+EDE8ri3aq5jl4U2p3kwoywaUztiDS0llm
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1b0c:b0:3a3:4164:eecd with SMTP id
 e9e14a558f8ab-3a36592b5dbmr76636575ab.15.1727972067300; Thu, 03 Oct 2024
 09:14:27 -0700 (PDT)
Date: Thu, 03 Oct 2024 09:14:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66fec2e3.050a0220.9ec68.0048.GAE@google.com>
Subject: [syzbot] [net?] [virt?] INFO: rcu detected stall in schedule_tail (6)
From: syzbot <syzbot+4d2bdddae2e3866013ef@syzkaller.appspotmail.com>
To: Liam.Howlett@oracle.com, akpm@linux-foundation.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-usb@vger.kernel.org, 
	lorenzo.stoakes@oracle.com, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, vbabka@suse.cz, 
	virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    9852d85ec9d4 Linux 6.12-rc1
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=1606e580580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4510af5d637450fb
dashboard link: https://syzkaller.appspot.com/bug?extid=4d2bdddae2e3866013ef
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1106e580580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17e8339f980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d44acbbed8bd/disk-9852d85e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8e54c80139e6/vmlinux-9852d85e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/35f22e8643ee/bzImage-9852d85e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4d2bdddae2e3866013ef@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: {
 0-...D
 } 2665 jiffies s: 1653 root: 0x1/.
rcu: blocking rcu_node structures (internal RCU debug):
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 5006 Comm: syz-executor294 Not tainted 6.12.0-rc1-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:write_comp_data+0x0/0x90 kernel/kcov.c:240
Code: 48 83 c0 01 48 39 d0 73 07 48 89 01 48 89 34 c1 c3 cc cc cc cc 0f 1f 44 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 <49> 89 d2 49 89 f8 49 89 f1 65 48 8b 15 4f de ad 7e 65 8b 05 50 de
RSP: 0018:ffffc90000006d20 EFLAGS: 00000006
RAX: 0000000000000000 RBX: 0000000000000006 RCX: ffffffff86e77fb0
RDX: 0000000000000009 RSI: 000000000000000d RDI: 0000000000000001
RBP: ffffffff8810b580 R08: 0000000000000001 R09: 000000000000000c
R10: 0000000000000009 R11: 0000000000128c20 R12: 0000000000000009
R13: 0000000000000001 R14: 000000000000000a R15: 0000000000000009
FS:  000055556995c480(0000) GS:ffff8881f5800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055556995c750 CR3: 0000000116b82000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <IRQ>
 __sanitizer_cov_trace_switch+0x54/0x90 kernel/kcov.c:351
 vsnprintf+0x740/0x1880 lib/vsprintf.c:2772
 sprintf+0xcd/0x110 lib/vsprintf.c:3007
 print_time kernel/printk/printk.c:1362 [inline]
 info_print_prefix+0x25c/0x350 kernel/printk/printk.c:1388
 record_print_text+0x141/0x400 kernel/printk/printk.c:1437
 printk_get_next_message+0x2a6/0x670 kernel/printk/printk.c:2978
 console_emit_next_record kernel/printk/printk.c:3046 [inline]
 console_flush_all+0x6ec/0xc60 kernel/printk/printk.c:3180
 __console_flush_and_unlock kernel/printk/printk.c:3239 [inline]
 console_unlock+0xd9/0x210 kernel/printk/printk.c:3279
 vprintk_emit+0x424/0x6f0 kernel/printk/printk.c:2407
 vprintk+0x7f/0xa0 kernel/printk/printk_safe.c:68
 _printk+0xc8/0x100 kernel/printk/printk.c:2432
 printk_stack_address arch/x86/kernel/dumpstack.c:72 [inline]
 show_trace_log_lvl+0x1b7/0x3d0 arch/x86/kernel/dumpstack.c:285
 sched_show_task kernel/sched/core.c:7582 [inline]
 sched_show_task+0x3f0/0x5f0 kernel/sched/core.c:7557
 show_state_filter+0xee/0x320 kernel/sched/core.c:7627
 k_spec drivers/tty/vt/keyboard.c:667 [inline]
 k_spec+0xed/0x150 drivers/tty/vt/keyboard.c:656
 kbd_keycode drivers/tty/vt/keyboard.c:1522 [inline]
 kbd_event+0xcbd/0x17a0 drivers/tty/vt/keyboard.c:1541
 input_handler_events_default+0x116/0x1b0 drivers/input/input.c:2549
 input_pass_values+0x777/0x8e0 drivers/input/input.c:126
 input_event_dispose drivers/input/input.c:341 [inline]
 input_handle_event+0xf0b/0x14d0 drivers/input/input.c:369
 input_event drivers/input/input.c:398 [inline]
 input_event+0x83/0xa0 drivers/input/input.c:390
 input_sync include/linux/input.h:451 [inline]
 hidinput_report_event+0xb2/0x100 drivers/hid/hid-input.c:1736
 hid_report_raw_event+0x274/0x11c0 drivers/hid/hid-core.c:2047
 __hid_input_report.constprop.0+0x341/0x440 drivers/hid/hid-core.c:2110
 hid_irq_in+0x35e/0x870 drivers/hid/usbhid/hid-core.c:285
 __usb_hcd_giveback_urb+0x389/0x6e0 drivers/usb/core/hcd.c:1650
 usb_hcd_giveback_urb+0x396/0x450 drivers/usb/core/hcd.c:1734
 dummy_timer+0x17c3/0x38d0 drivers/usb/gadget/udc/dummy_hcd.c:1988
 __run_hrtimer kernel/time/hrtimer.c:1691 [inline]
 __hrtimer_run_queues+0x20a/0xae0 kernel/time/hrtimer.c:1755
 hrtimer_run_softirq+0x17d/0x350 kernel/time/hrtimer.c:1772
 handle_softirqs+0x206/0x8d0 kernel/softirq.c:554
 __do_softirq kernel/softirq.c:588 [inline]
 invoke_softirq kernel/softirq.c:428 [inline]
 __irq_exit_rcu kernel/softirq.c:637 [inline]
 irq_exit_rcu+0xac/0x110 kernel/softirq.c:649
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1037 [inline]
 sysvec_apic_timer_interrupt+0x90/0xb0 arch/x86/kernel/apic/apic.c:1037
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:__sanitizer_cov_trace_switch+0x16/0x90 kernel/kcov.c:334
Code: 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 41 56 41 55 41 54 49 89 fc 55 48 89 f5 53 48 8b 46 08 <48> 83 f8 20 74 6b 77 48 48 83 f8 08 74 5b 48 83 f8 10 75 2f 41 bd
RSP: 0018:ffffc9000277fb18 EFLAGS: 00000206
RAX: 0000000000000020 RBX: 0000000000000003 RCX: 1ffff920004eff8f
RDX: ffff88811dd80200 RSI: ffffffff881088e0 RDI: 0000000000000003
RBP: ffffffff881088e0 R08: 0000000000000005 R09: 0000000000000002
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000003
R13: ffffc9000277fd38 R14: ffffc9000277fc68 R15: 0000000000000300
 ma_pivots lib/maple_tree.c:655 [inline]
 mtree_range_walk+0x311/0xbe0 lib/maple_tree.c:2767
 mas_state_walk lib/maple_tree.c:3601 [inline]
 mt_find+0x5ad/0xa20 lib/maple_tree.c:6930
 find_vma+0xc0/0x140 mm/mmap.c:967
 lock_mm_and_find_vma+0x62/0x6a0 mm/memory.c:6162
 do_user_addr_fault+0x2b5/0x12c0 arch/x86/mm/fault.c:1361
 handle_page_fault arch/x86/mm/fault.c:1481 [inline]
 exc_page_fault+0x5c/0xc0 arch/x86/mm/fault.c:1539
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
RIP: 0010:__put_user_4+0x11/0x20 arch/x86/lib/putuser.S:88
Code: 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 48 89 cb 48 c1 fb 3f 48 09 d9 0f 01 cb <89> 01 31 c9 0f 01 ca c3 cc cc cc cc 0f 1f 00 90 90 90 90 90 90 90
RSP: 0018:ffffc9000277ff10 EFLAGS: 00050206
RAX: 0000000000000010 RBX: 0000000000000000 RCX: 000055556995c750
RDX: dffffc0000000000 RSI: ffffffff8727f4a0 RDI: ffff88811c500648
RBP: 0000000000000000 R08: 0000000000000000 R09: fffffbfff14ac801
R10: ffffffff8a56400f R11: 0000000000000000 R12: ffff888101698000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 schedule_tail+0xa6/0xd0 kernel/sched/core.c:5250
 ret_from_fork+0x23/0x80 arch/x86/kernel/process.c:143
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:kworker/R-targe state:I stack:30080 pid:251   tgid:251   ppid:2      flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6767
 rescuer_thread+0x946/0xe20 kernel/workqueue.c:3541
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:kworker/R-xcopy state:I stack:30080 pid:252   tgid:252   ppid:2      flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6767
 rescuer_thread+0x946/0xe20 kernel/workqueue.c:3541
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:kworker/R-liber state:I stack:30080 pid:333   tgid:333   ppid:2      flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6767
 rescuer_thread+0x946/0xe20 kernel/workqueue.c:3541
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:kworker/R-zd121 state:I stack:30080 pid:364   tgid:364   ppid:2      flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6767
 rescuer_thread+0x946/0xe20 kernel/workqueue.c:3541
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:kworker/R-uas   state:I stack:30080 pid:445   tgid:445   ppid:2      flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6767
 rescuer_thread+0x946/0xe20 kernel/workqueue.c:3541
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:kworker/0:2     state:I stack:21872 pid:667   tgid:667   ppid:2      flags:0x00004000
Workqueue:  0x0 (events)
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6767
 worker_thread+0x2de/0xf00 kernel/workqueue.c:3406
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:kworker/R-usbip state:I stack:30832 pid:742   tgid:742   ppid:2      flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6767
 rescuer_thread+0x946/0xe20 kernel/workqueue.c:3541
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:pvrusb2-context state:S stack:30176 pid:987   tgid:987   ppid:2      flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6767
 pvr2_context_thread_func+0x631/0x970 drivers/media/usb/pvrusb2/pvrusb2-context.c:160
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:kworker/R-kvub3 state:I stack:30080 pid:1024  tgid:1024  ppid:2      flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6767
 rescuer_thread+0x946/0xe20 kernel/workqueue.c:3541
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:kworker/R-kvub3 state:I stack:30080 pid:1025  tgid:1025  ppid:2      flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6767
 rescuer_thread+0x946/0xe20 kernel/workqueue.c:3541
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:kworker/R-kvub3 state:I stack:30080 pid:1026  tgid:1026  ppid:2      flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6767
 rescuer_thread+0x946/0xe20 kernel/workqueue.c:3541
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:kworker/R-kmems state:I stack:30080 pid:1030  tgid:1030  ppid:2      flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6767
 rescuer_thread+0x946/0xe20 kernel/workqueue.c:3541
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:kworker/R-elous state:I stack:30080 pid:1048  tgid:1048  ppid:2      flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6767
 rescuer_thread+0x946/0xe20 kernel/workqueue.c:3541
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:kworker/u8:6    state:I stack:23024 pid:1183  tgid:1183  ppid:2      flags:0x00004000
Workqueue:  0x0 (events_unbound)
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6767
 worker_thread+0x2de/0xf00 kernel/workqueue.c:3406
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:kworker/0:1H    state:I stack:28272 pid:1246  tgid:1246  ppid:2      flags:0x00004000
Workqueue:  0x0 (kblockd)
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6767
 worker_thread+0x2de/0xf00 kernel/workqueue.c:3406
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:kworker/R-mld   state:I stack:30080 pid:1247  tgid:1247  ppid:2      flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6767
 rescuer_thread+0x946/0xe20 kernel/workqueue.c:3541
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:kworker/R-ipv6_ state:I stack:30080 pid:1248  tgid:1248  ppid:2      flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6767
 rescuer_thread+0x946/0xe20 kernel/workqueue.c:3541
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:kworker/u8:7    state:I stack:27296 pid:1493  tgid:1493  ppid:2      flags:0x00004000
Workqueue:  0x0 (events_unbound)
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6767
 worker_thread+0x2de/0xf00 kernel/workqueue.c:3406
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:kworker/u8:8    state:I stack:26752 pid:1535  tgid:1535  ppid:2      flags:0x00004000
Workqueue:  0x0 (events_unbound)
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6767
 worker_thread+0x2de/0xf00 kernel/workqueue.c:3406
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:jbd2/sda1-8     state:S stack:26288 pid:2510  tgid:2510  ppid:2      flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6767
 kjournald2+0x5c7/0x760 fs/jbd2/journal.c:230
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:kworker/R-ext4- state:I stack:30832 pid:2511  tgid:2511  ppid:2      flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6767
 rescuer_thread+0x946/0xe20 kernel/workqueue.c:3541
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:syslogd         state:S stack:25072 pid:2530  tgid:2530  ppid:1      flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6767
 schedule_timeout+0x258/0x2a0 kernel/time/timer.c:2591
 __skb_wait_for_more_packets+0x36c/0x5e0 net/core/datagram.c:121
 __unix_dgram_recvmsg+0x243/0xdd0 net/unix/af_unix.c:2448
 unix_dgram_recvmsg+0xd0/0x110 net/unix/af_unix.c:2537
 sock_recvmsg_nosec net/socket.c:1051 [inline]
 sock_recvmsg+0x1f6/0x250 net/socket.c:1073
 sock_read_iter+0x2bb/0x3b0 net/socket.c:1143
 new_sync_read fs/read_write.c:488 [inline]
 vfs_read+0xa3b/0xbd0 fs/read_write.c:569
 ksys_read+0x1fa/0x260 fs/read_write.c:712
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f1980c67b6a
RSP: 002b:00007ffe64941938 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f1980c67b6a
RDX: 00000000000000ff RSI: 000056188f197300 RDI: 0000000000000000
RBP: 000056188f1972c0 R08: 0000000000000001 R09: 0000000000000000
R10: 00007f1980e063a3 R11: 0000000000000246 R12: 000056188f19733a
R13: 000056188f197300 R14: 0000000000000000 R15: 00007f1980e4aa80
 </TASK>
task:acpid           state:S stack:25232 pid:2533  tgid:2533  ppid:1      flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6767
 schedule_hrtimeout_range_clock+0x369/0x3b0 kernel/time/hrtimer.c:2272
 poll_schedule_timeout.constprop.0+0xba/0x190 fs/select.c:241
 do_select+0x12ec/0x17b0 fs/select.c:604
 core_sys_select+0x459/0xb80 fs/select.c:678
 do_pselect.constprop.0+0x1a0/0x1f0 fs/select.c:760
 __do_sys_pselect6 fs/select.c:803 [inline]
 __se_sys_pselect6 fs/select.c:794 [inline]
 __x64_sys_pselect6+0x183/0x240 fs/select.c:794
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f5e6983d591
RSP: 002b:00007ffd4713f200 EFLAGS: 00000246 ORIG_RAX: 000000000000010e
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f5e6983d591
RDX: 0000000000000000 RSI: 00007ffd4713f2f8 RDI: 000000000000000d
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000055f52a2de178 R14: 0000000000000000 R15: 000000000000000c
 </TASK>
task:klogd           state:S stack:25408 pid:2537  tgid:2537  ppid:1      flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6767
 syslog_print+0x214/0x5d0 kernel/printk/printk.c:1614
 do_syslog+0x3be/0x6a0 kernel/printk/printk.c:1766
 __do_sys_syslog kernel/printk/printk.c:1858 [inline]
 __se_sys_syslog kernel/printk/printk.c:1856 [inline]
 __x64_sys_syslog+0x74/0xb0 kernel/printk/printk.c:1856
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f5353d48fa7
RSP: 002b:00007ffd7b46cc98 EFLAGS: 00000206 ORIG_RAX: 0000000000000067
RAX: ffffffffffffffda RBX: 00007f5353ee74a0 RCX: 00007f5353d48fa7
RDX: 00000000000003ff RSI: 00007f5353ee74a0 RDI: 0000000000000002
RBP: 0000000000000000 R08: 0000000000000007 R09: 883853fd9ec1de17
R10: 0000000000004000 R11: 0000000000000206 R12: 00007f5353ee74a0
R13: 00007f5353ed7212 R14: 00007f5353ee77a9 R15: 00007f5353ee77a9
 </TASK>
task:udevd           state:S stack:25856 pid:2548  tgid:2548  ppid:1      flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6767
 schedule_hrtimeout_range_clock+0x369/0x3b0 kernel/time/hrtimer.c:2272
 ep_poll fs/eventpoll.c:2062 [inline]
 do_epoll_wait+0x139b/0x1a90 fs/eventpoll.c:2459
 __do_sys_epoll_wait fs/eventpoll.c:2471 [inline]
 __se_sys_epoll_wait fs/eventpoll.c:2466 [inline]
 __x64_sys_epoll_wait+0x194/0x290 fs/eventpoll.c:2466
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f12ec088457
RSP: 002b:00007ffd871eb958 EFLAGS: 00000246 ORIG_RAX: 00000000000000e8
RAX: ffffffffffffffda RBX: 00007ffd871eba58 RCX: 00007f12ec088457
RDX: 0000000000000008 RSI: 00007ffd871eba58 RDI: 000000000000000b
RBP: 00005588da307f70 R08: 0000000000000007 R09: 79d27bf63fc7d1df
R10: 00000000ffffffff R11: 0000000000000246 R12: 00000000ffffffff
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
task:dbus-daemon     state:S stack:27776 pid:2570  tgid:2570  ppid:1      flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6767
 schedule_hrtimeout_range_clock+0x369/0x3b0 kernel/time/hrtimer.c:2272
 ep_poll fs/eventpoll.c:2062 [inline]
 do_epoll_wait+0x139b/0x1a90 fs/eventpoll.c:2459
 __do_sys_epoll_wait fs/eventpoll.c:2471 [inline]
 __se_sys_epoll_wait fs/eventpoll.c:2466 [inline]
 __x64_sys_epoll_wait+0x194/0x290 fs/eventpoll.c:2466
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fb94663e457
RSP: 002b:00007fffb2fa4a98 EFLAGS: 00000246 ORIG_RAX: 00000000000000e8
RAX: ffffffffffffffda RBX: 00007fffb2fa4aa8 RCX: 00007fb94663e457
RDX: 0000000000000040 RSI: 00007fffb2fa4aa8 RDI: 0000000000000003
RBP: 00007fffb2fa4e38 R08: 0000000000000b14 R09: 00007fb9467b3080
R10: 00000000ffffffff R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007fffb2fa4e38 R15: 00007fffb2fa5148
 </TASK>
task:dhcpcd          state:S stack:25984 pid:2585  tgid:2585  ppid:1      flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6767
 schedule_hrtimeout_range_clock+0x272/0x3b0 kernel/time/hrtimer.c:2281
 poll_schedule_timeout.constprop.0+0xba/0x190 fs/select.c:241
 do_poll fs/select.c:964 [inline]
 do_sys_poll+0xad5/0xde0 fs/select.c:1015
 __do_sys_ppoll fs/select.c:1121 [inline]
 __se_sys_ppoll fs/select.c:1101 [inline]
 __x64_sys_ppoll+0x25a/0x2d0 fs/select.c:1101
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fb96e257ad5
RSP: 002b:00007ffefac7c070 EFLAGS: 00000246 ORIG_RAX: 000000000000010f
RAX: ffffffffffffffda RBX: 0000558470475ee0 RCX: 00007fb96e257ad5
RDX: 00007ffefac7c090 RSI: 0000000000000004 RDI: 000055847047fe70
RBP: 00007ffefac7c3c0 R08: 0000000000000008 R09: 00007fb96e340080
R10: 00007ffefac7c3c0 R11: 0000000000000246 R12: 00007ffefac7c0b8
R13: 0000558452625610 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
task:dhcpcd          state:S stack:25024 pid:2586  tgid:2586  ppid:2585   flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6767
 schedule_hrtimeout_range_clock+0x369/0x3b0 kernel/time/hrtimer.c:2272
 poll_schedule_timeout.constprop.0+0xba/0x190 fs/select.c:241
 do_poll fs/select.c:964 [inline]
 do_sys_poll+0xad5/0xde0 fs/select.c:1015
 __do_sys_ppoll fs/select.c:1121 [inline]
 __se_sys_ppoll fs/select.c:1101 [inline]
 __x64_sys_ppoll+0x25a/0x2d0 fs/select.c:1101
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fb96e257ad5
RSP: 002b:00007ffefac7c070 EFLAGS: 00000246 ORIG_RAX: 000000000000010f
RAX: ffffffffffffffda RBX: 0000558470475ee0 RCX: 00007fb96e257ad5
RDX: 0000000000000000 RSI: 0000000000000003 RDI: 0000558470475ec0
RBP: 00007ffefac7c3c0 R08: 0000000000000008 R09: 09c20ffd7bbd91de
R10: 00007ffefac7c3c0 R11: 0000000000000246 R12: 0000000000000000
R13: 0000558452625610 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
task:dhcpcd          state:S stack:26416 pid:2587  tgid:2587  ppid:2585   flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6767
 schedule_hrtimeout_range_clock+0x369/0x3b0 kernel/time/hrtimer.c:2272
 poll_schedule_timeout.constprop.0+0xba/0x190 fs/select.c:241
 do_poll fs/select.c:964 [inline]
 do_sys_poll+0xad5/0xde0 fs/select.c:1015
 __do_sys_ppoll fs/select.c:1121 [inline]
 __se_sys_ppoll fs/select.c:1101 [inline]
 __x64_sys_ppoll+0x25a/0x2d0 fs/select.c:1101
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fb96e257ad5
RSP: 002b:00007ffefac7c070 EFLAGS: 00000246 ORIG_RAX: 000000000000010f
RAX: ffffffffffffffda RBX: 0000558470475ee0 RCX: 00007fb96e257ad5
RDX: 0000000000000000 RSI: 0000000000000004 RDI: 000055847047efe0
RBP: 00007ffefac7c3c0 R08: 0000000000000008 R09: 00005584526253d0
R10: 00007ffefac7c3c0 R11: 0000000000000246 R12: 0000000000000000
R13: 0000558452625610 R14: 0000000000000003 R15: 0000000000000000
 </TASK>
task:dhcpcd          state:S stack:27504 pid:2588  tgid:2588  ppid:2585   flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6767
 schedule_hrtimeout_range_clock+0x369/0x3b0 kernel/time/hrtimer.c:2272
 poll_schedule_timeout.constprop.0+0xba/0x190 fs/select.c:241
 do_poll fs/select.c:964 [inline]
 do_sys_poll+0xad5/0xde0 fs/select.c:1015
 __do_sys_ppoll fs/select.c:1121 [inline]
 __se_sys_ppoll fs/select.c:1101 [inline]
 __x64_sys_ppoll+0x25a/0x2d0 fs/select.c:1101
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fb96e257ad5
RSP: 002b:00007ffefac7c070 EFLAGS: 00000246 ORIG_RAX: 000000000000010f
RAX: ffffffffffffffda RBX: 0000558470475ee0 RCX: 00007fb96e257ad5
RDX: 0000000000000000 RSI: 0000000000000005 RDI: 000055847047efe0
RBP: 00007ffefac7c3c0 R08: 0000000000000008 R09: 00005584526253d0
R10: 00007ffefac7c3c0 R11: 0000000000000246 R12: 0000000000000000
R13: 0000558452625610 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
task:dhcpcd          state:S stack:25904 pid:2605  tgid:2605  ppid:2586   flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6767
 schedule_hrtimeout_range_clock+0x369/0x3b0 kernel/time/hrtimer.c:2272
 poll_schedule_timeout.constprop.0+0xba/0x190 fs/select.c:241
 do_poll fs/select.c:964 [inline]
 do_sys_poll+0xad5/0xde0 fs/select.c:1015
 __do_sys_ppoll fs/select.c:1121 [inline]
 __se_sys_ppoll fs/select.c:1101 [inline]
 __x64_sys_ppoll+0x25a/0x2d0 fs/select.c:1101
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fb96e257ad5
RSP: 002b:00007ffefac7c070 EFLAGS: 00000246 ORIG_RAX: 000000000000010f
RAX: ffffffffffffffda RBX: 0000558470475ee0 RCX: 00007fb96e257ad5
RDX: 0000000000000000 RSI: 0000000000000002 RDI: 0000558470480d50
RBP: 00007ffefac7c3c0 R08: 0000000000000008 R09: 0000000000000000
R10: 00007ffefac7c3c0 R11: 0000000000000246 R12: 0000000000000000
R13: 0000558452625610 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
task:sshd            state:S stack:27424 pid:2606  tgid:2606  ppid:1      flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6767
 schedule_hrtimeout_range_clock+0x369/0x3b0 kernel/time/hrtimer.c:2272
 poll_schedule_timeout.constprop.0+0xba/0x190 fs/select.c:241
 do_poll fs/select.c:964 [inline]
 do_sys_poll+0xad5/0xde0 fs/select.c:1015
 __do_sys_ppoll fs/select.c:1121 [inline]
 __se_sys_ppoll fs/select.c:1101 [inline]
 __x64_sys_ppoll+0x25a/0x2d0 fs/select.c:1101
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f3bfb2b8ad5
RSP: 002b:00007ffe7a845fd0 EFLAGS: 00000246 ORIG_RAX: 000000000000010f
RAX: ffffffffffffffda RBX: 000055d9d1634ab0 RCX: 00007f3bfb2b8ad5
RDX: 0000000000000000 RSI: 0000000000000002 RDI: 000055d9d163a490
RBP: 0000000000000064 R08: 0000000000000008 R09: 0000000000000000
R10: 00007ffe7a846188 R11: 0000000000000246 R12: 000055d9d163a490
R13: 00007ffe7a846188 R14: 0000000000000002 R15: 000055d9d1635b0c
 </TASK>
task:getty           state:S stack:25408 pid:2608  tgid:2608  ppid:1      flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6767
 schedule_timeout+0x258/0x2a0 kernel/time/timer.c:2591
 wait_woken+0x175/0x1c0 kernel/sched/wait.c:423
 n_tty_read+0x10fb/0x1480 drivers/tty/n_tty.c:2277
 iterate_tty_read drivers/tty/tty_io.c:856 [inline]
 tty_read+0x30e/0x5b0 drivers/tty/tty_io.c:931
 new_sync_read fs/read_write.c:488 [inline]
 vfs_read+0x86e/0xbd0 fs/read_write.c:569
 ksys_read+0x12f/0x260 fs/read_write.c:712
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fa28a888b6a
RSP: 002b:00007ffcf7c72ad8 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 00005569b603a2c0 RCX: 00007fa28a888b6a
RDX: 0000000000000001 RSI: 00007ffcf7c72af0 RDI: 0000000000000000
RBP: 00005569b603a320 R08: 0000000000000000 R09: 09e33be4672970b3
R10: 0000000000000010 R11: 0000000000000246 R12: 00005569b603a35c
R13: 00007ffcf7c72af0 R14: 0000000000000000 R15: 00005569b603a35c
 </TASK>
task:kworker/1:2     state:S stack:21168 pid:2610  tgid:2610  ppid:2      flags:0x00004000
Workqueue: usb_hub_wq hub_event
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6767
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6824
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x5b8/0x9c0 kernel/locking/mutex.c:752
 input_register_device+0x98a/0x1110 drivers/input/input.c:2463
 hidinput_connect+0x1d9c/0x2ba0 drivers/hid/hid-input.c:2343
 hid_connect+0x13a8/0x18a0 drivers/hid/hid-core.c:2234
 hid_hw_start drivers/hid/hid-core.c:2349 [inline]
 hid_hw_start+0xaa/0x140 drivers/hid/hid-core.c:2340
 __hid_device_probe drivers/hid/hid-core.c:2703 [inline]
 hid_device_probe+0x3e7/0x490 drivers/hid/hid-core.c:2736
 call_driver_probe drivers/base/dd.c:579 [inline]
 really_probe+0x23e/0xa90 drivers/base/dd.c:658
 __driver_probe_device+0x1de/0x440 drivers/base/dd.c:800
 driver_probe_device+0x4c/0x1b0 drivers/base/dd.c:830
 __device_attach_driver+0x1df/0x310 drivers/base/dd.c:958
 bus_for_each_drv+0x157/0x1e0 drivers/base/bus.c:459
 __device_attach+0x1e8/0x4b0 drivers/base/dd.c:1030
 bus_probe_device+0x17f/0x1c0 drivers/base/bus.c:534
 device_add+0x114b/0x1a70 drivers/base/core.c:3675
 hid_add_device+0x37f/0xa70 drivers/hid/hid-core.c:2882
 usbhid_probe+0xd3b/0x1410 drivers/hid/usbhid/hid-core.c:1431
 usb_probe_interface+0x309/0x9d0 drivers/usb/core/driver.c:399
 call_driver_probe drivers/base/dd.c:579 [inline]
 really_probe+0x23e/0xa90 drivers/base/dd.c:658
 __driver_probe_device+0x1de/0x440 drivers/base/dd.c:800
 driver_probe_device+0x4c/0x1b0 drivers/base/dd.c:830
 __device_attach_driver+0x1df/0x310 drivers/base/dd.c:958
 bus_for_each_drv+0x157/0x1e0 drivers/base/bus.c:459
 __device_attach+0x1e8/0x4b0 drivers/base/dd.c:1030
 bus_probe_device+0x17f/0x1c0 drivers/base/bus.c:534
 device_add+0x114b/0x1a70 drivers/base/core.c:3675
 usb_set_configuration+0x10cb/0x1c50 drivers/usb/core/message.c:2210
 usb_generic_driver_probe+0xb1/0x110 drivers/usb/core/generic.c:254
 usb_probe_device+0xec/0x3e0 drivers/usb/core/driver.c:294
 call_driver_probe drivers/base/dd.c:579 [inline]
 really_probe+0x23e/0xa90 drivers/base/dd.c:658
 __driver_probe_device+0x1de/0x440 drivers/base/dd.c:800
 driver_probe_device+0x4c/0x1b0 drivers/base/dd.c:830
 __device_attach_driver+0x1df/0x310 drivers/base/dd.c:958
 bus_for_each_drv+0x157/0x1e0 drivers/base/bus.c:459
 __device_attach+0x1e8/0x4b0 drivers/base/dd.c:1030
 bus_probe_device+0x17f/0x1c0 drivers/base/bus.c:534
 device_add+0x114b/0x1a70 drivers/base/core.c:3675
 usb_new_device+0xd90/0x1a10 drivers/usb/core/hub.c:2651
 hub_port_connect drivers/usb/core/hub.c:5521 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5661 [inline]
 port_event drivers/usb/core/hub.c:5821 [inline]
 hub_event+0x2e58/0x4f40 drivers/usb/core/hub.c:5903
 process_one_work+0x9c5/0x1ba0 kernel/workqueue.c:3229
 process_scheduled_works kernel/workqueue.c:3310 [inline]
 worker_thread+0x6c8/0xf00 kernel/workqueue.c:3391
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:sshd            state:S stack:25408 pid:2648  tgid:2648  ppid:2606   flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6767
 schedule_hrtimeout_range_clock+0x272/0x3b0 kernel/time/hrtimer.c:2281
 poll_schedule_timeout.constprop.0+0xba/0x190 fs/select.c:241
 do_poll fs/select.c:964 [inline]
 do_sys_poll+0xad5/0xde0 fs/select.c:1015
 __do_sys_ppoll fs/select.c:1121 [inline]
 __se_sys_ppoll fs/select.c:1101 [inline]
 __x64_sys_ppoll+0x25a/0x2d0 fs/select.c:1101
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fe564505ad5
RSP: 002b:00007ffcdf043d80 EFLAGS: 00000246 ORIG_RAX: 000000000000010f
RAX: ffffffffffffffda RBX: 00000000000668a0 RCX: 00007fe564505ad5
RDX: 00007ffcdf043da0 RSI: 0000000000000004 RDI: 00005653672a7820
RBP: 00005653672a63f0 R08: 0000000000000008 R09: 0000000000000000
R10: 00007ffcdf043e88 R11: 0000000000000246 R12: 000056532d696aa4
R13: 0000000000000001 R14: 000056532d6973e8 R15: 00007ffcdf043e08
 </TASK>
task:syz-executor294 state:S stack:25088 pid:2650  tgid:2650  ppid:2648   flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6767
 do_nanosleep+0x216/0x510 kernel/time/hrtimer.c:2032
 hrtimer_nanosleep+0x146/0x370 kernel/time/hrtimer.c:2080
 common_nsleep+0xa1/0xd0 kernel/time/posix-timers.c:1365
 __do_sys_clock_nanosleep kernel/time/posix-timers.c:1411 [inline]
 __se_sys_clock_nanosleep kernel/time/posix-timers.c:1388 [inline]
 __x64_sys_clock_nanosleep+0x344/0x4a0 kernel/time/posix-timers.c:1388
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fd9fa154bb3
RSP: 002b:00007fffa140e218 EFLAGS: 00000202 ORIG_RAX: 00000000000000e6
RAX: ffffffffffffffda RBX: ffffffffffffffb0 RCX: 00007fd9fa154bb3
RDX: 00007fffa140e230 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000002 R08: 0000000000000000 R09: 0000000000000000
R10: 00007fffa140e230 R11: 0000000000000202 R12: 6c616b7a79732f2e
R13: 585858582e72656c R14: 00007fffa140e2b0 R15: 00007fd9fa17449b
 </TASK>
task:syz-executor294 state:S stack:27216 pid:2653  tgid:2653  ppid:2650   flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6767
 do_wait+0x1dd/0x570 kernel/exit.c:1697
 kernel_wait4+0x16c/0x280 kernel/exit.c:1851
 __do_sys_wait4+0x15f/0x170 kernel/exit.c:1879
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fd9fa124de3
RSP: 002b:00007fffa140e268 EFLAGS: 00000202 ORIG_RAX: 000000000000003d
RAX: ffffffffffffffda RBX: 0000000000000a64 RCX: 00007fd9fa124de3
RDX: 0000000040000000 RSI: 00007fffa140e2d0 RDI: 00000000ffffffff
RBP: 00007fffa140e2d0 R08: 0000000000000000 R09: 0000000000000001
R10: 0000000000000000 R11: 0000000000000202 R12: 6c616b7a79732f2e
R13: 585858582e72656c R14: 00007fffa140e2b0 R15: 00007fd9fa17449b
 </TASK>
task:syz-executor294 state:S stack:27360 pid:2654  tgid:2654  ppid:2650   flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6767
 do_wait+0x1dd/0x570 kernel/exit.c:1697
 kernel_wait4+0x16c/0x280 kernel/exit.c:1851
 __do_sys_wait4+0x15f/0x170 kernel/exit.c:1879
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fd9fa124de3
RSP: 002b:00007fffa140e268 EFLAGS: 00000202 ORIG_RAX: 000000000000003d
RAX: ffffffffffffffda RBX: 0000000000000a63 RCX: 00007fd9fa124de3
RDX: 0000000040000000 RSI: 00007fffa140e2d0 RDI: 00000000ffffffff
RBP: 00007fffa140e2d0 R08: 0000000000000000 R09: 0000000000000001
R10: 0000000000000000 R11: 0000000000000202 R12: 6c616b7a79732f2e
R13: 585858582e72656c R14: 00007fffa140e2b0 R15: 00007fd9fa17449b
 </TASK>
task:syz-executor294 state:S stack:27712 pid:2655  tgid:2655  ppid:2650   flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6767
 do_wait+0x1dd/0x570 kernel/exit.c:1697
 kernel_wait4+0x16c/0x280 kernel/exit.c:1851
 __do_sys_wait4+0x15f/0x170 kernel/exit.c:1879
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fd9fa124de3
RSP: 002b:00007fffa140e268 EFLAGS: 00000202 ORIG_RAX: 000000000000003d
RAX: ffffffffffffffda RBX: 0000000000000a62 RCX: 00007fd9fa124de3
RDX: 0000000040000000 RSI: 00007fffa140e2d0 RDI: 00000000ffffffff
RBP: 00007fffa140e2d0 R08: 0000000000000000 R09: 0000000000000001
R10: 0000000000000000 R11: 0000000000000202 R12: 6c616b7a79732f2e
R13: 585858582e72656c R14: 00007fffa140e2b0 R15: 00007fd9fa17449b
 </TASK>
task:syz-executor294 state:S stack:27360 pid:2656  tgid:2656  ppid:2650   flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6767
 do_wait+0x1dd/0x570 kernel/exit.c:1697
 kernel_wait4+0x16c/0x280 kernel/exit.c:1851
 __do_sys_wait4+0x15f/0x170 kernel/exit.c:1879
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fd9fa124de3
RSP: 002b:00007fffa140e268 EFLAGS: 00000202 ORIG_RAX: 000000000000003d
RAX: ffffffffffffffda RBX: 0000000000000a65 RCX: 00007fd9fa124de3
RDX: 0000000040000000 RSI: 00007fffa140e2d0 RDI: 00000000ffffffff
RBP: 00007fffa140e2d0 R08: 0000000000000000 R09: 0000000000000001
R10: 0000000000000000 R11: 0000000000000202 R12: 6c616b7a79732f2e
R13: 585858582e72656c R14: 00007fffa140e2b0 R15: 00007fd9fa17449b
 </TASK>
task:syz-executor294 state:S stack:27360 pid:2657  tgid:2657  ppid:2650   flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6767
 do_wait+0x1dd/0x570 kernel/exit.c:1697
 kernel_wait4+0x16c/0x280 kernel/exit.c:1851
 __do_sys_wait4+0x15f/0x170 kernel/exit.c:1879
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fd9fa124de3
RSP: 002b:00007fffa140e268 EFLAGS: 00000202 ORIG_RAX: 000000000000003d
RAX: ffffffffffffffda RBX: 0000000000000a66 RCX: 00007fd9fa124de3
RDX: 0000000040000000 RSI: 00007fffa140e2d0 RDI: 00000000ffffffff
RBP: 00007fffa140e2d0 R08: 0000000000000000 R09: 0000000000000001
R10: 0000000000000000 R11: 0000000000000202 R12: 6c616b7a79732f2e
R13: 585858582e72656c R14: 00007fffa140e2b0 R15: 00007fd9fa17449b
 </TASK>
task:syz-executor294 state:S stack:24784 pid:2658  tgid:2658  ppid:2655   flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6767
 do_wait+0x1dd/0x570 kernel/exit.c:1697
 kernel_wait4+0x16c/0x280 kernel/exit.c:1851
 __do_sys_wait4+0x15f/0x170 kernel/exit.c:1879
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fd9fa124de3
RSP: 002b:00007fffa140e068 EFLAGS: 00000202 ORIG_RAX: 000000000000003d
RAX: ffffffffffffffda RBX: 0000000000000010 RCX: 00007fd9fa124de3
RDX: 0000000040000000 RSI: 00007fffa140e080 RDI: 00000000ffffffff
RBP: 00007fffa140e080 R08: 00000000000090ca R09: 00007fd9fa0d0080
R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000006
R13: 431bde82d7b634db R14: 0000000000000000 R15: 00007fffa140e0e0
 </TASK>
task:syz-executor294 state:S stack:23184 pid:2659  tgid:2659  ppid:2654   flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6767
 do_wait+0x1dd/0x570 kernel/exit.c:1697
 kernel_wait4+0x16c/0x280 kernel/exit.c:1851
 __do_sys_wait4+0x15f/0x170 kernel/exit.c:1879
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fd9fa124de3
RSP: 002b:00007fffa140e068 EFLAGS: 00000202 ORIG_RAX: 000000000000003d
RAX: ffffffffffffffda RBX: 0000000000000010 RCX: 00007fd9fa124de3
RDX: 0000000040000000 RSI: 00007fffa140e080 RDI: 00000000ffffffff
RBP: 00007fffa140e080 R08: 00000000000090ca R09: 00007fd9fa0d0080
R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000006
R13: 431bde82d7b634db R14: 0000000000000000 R15: 00007fffa140e0e0
 </TASK>
task:syz-executor294 state:S stack:24784 pid:2660  tgid:2660  ppid:2653   flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6767
 do_wait+0x1dd/0x570 kernel/exit.c:1697
 kernel_wait4+0x16c/0x280 kernel/exit.c:1851
 __do_sys_wait4+0x15f/0x170 kernel/exit.c:1879
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fd9fa124de3
RSP: 002b:00007fffa140e068 EFLAGS: 00000202 ORIG_RAX: 000000000000003d
RAX: ffffffffffffffda RBX: 0000000000000012 RCX: 00007fd9fa124de3
RDX: 0000000040000000 RSI: 00007fffa140e080 RDI: 00000000ffffffff
RBP: 00007fffa140e080 R08: 0000000000009128 R09: 00007fd9fa0d0080
R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000007
R13: 431bde82d7b634db R14: 0000000000000000 R15: 00007fffa140e0e0
 </TASK>
task:syz-executor294 state:S stack:23776 pid:2661  tgid:2661  ppid:2656   flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6767
 do_wait+0x1dd/0x570 kernel/exit.c:1697
 kernel_wait4+0x16c/0x280 kernel/exit.c:1851
 __do_sys_wait4+0x15f/0x170 kernel/exit.c:1879
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fd9fa124de3
RSP: 002b:00007fffa140e068 EFLAGS: 00000202 ORIG_RAX: 000000000000003d
RAX: ffffffffffffffda RBX: 000000000000000e RCX: 00007fd9fa124de3
RDX: 0000000040000000 RSI: 00007fffa140e080 RDI: 00000000ffffffff
RBP: 00007fffa140e080 R08: 00000000000090ca R09: 00007fd9fa0d0080
R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000006
R13: 431bde82d7b634db R14: 0000000000000000 R15: 00007fffa140e0e0
 </TASK>
task:syz-executor294 state:S stack:22752 pid:2662  tgid:2662  ppid:2657   flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6767
 do_wait+0x1dd/0x570 kernel/exit.c:1697
 kernel_wait4+0x16c/0x280 kernel/exit.c:1851
 __do_sys_wait4+0x15f/0x170 kernel/exit.c:1879
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fd9fa124de3
RSP: 002b:00007fffa140e068 EFLAGS: 00000202 ORIG_RAX: 000000000000003d
RAX: ffffffffffffffda RBX: 0000000000000010 RCX: 00007fd9fa124de3
RDX: 0000000040000000 RSI: 00007fffa140e080 RDI: 00000000ffffffff
RBP: 00007fffa140e080 R08: 0000000000009118 R09: 00007fd9fa0d0080
R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000007
R13: 431bde82d7b634db R14: 0000000000000000 R15: 00007fffa140e0e0
 </TASK>
task:kworker/0:3     state:I stack:21872 pid:4905  tgid:4905  ppid:2      flags:0x00004000
Workqueue:  0x0 (events)
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6767
 worker_thread+0x2de/0xf00 kernel/workqueue.c:3406
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:kworker/1:3     state:D stack:22224 pid:4912  tgid:4912  ppid:2      flags:0x00004000
Workqueue: usb_hub_wq hub_event
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6767
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6824
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x5b8/0x9c0 kernel/locking/mutex.c:752
 __input_unregister_device+0x136/0x450 drivers/input/input.c:2272
 input_unregister_device+0xb9/0x100 drivers/input/input.c:2511
 hidinput_disconnect+0x160/0x3e0 drivers/hid/hid-input.c:2376
 hid_disconnect+0x14d/0x1b0 drivers/hid/hid-core.c:2320
 hid_hw_stop drivers/hid/hid-core.c:2369 [inline]
 hid_device_remove+0x1a8/0x260 drivers/hid/hid-core.c:2757
 device_remove+0xc8/0x170 drivers/base/dd.c:567
 __device_release_driver drivers/base/dd.c:1273 [inline]
 device_release_driver_internal+0x44a/0x610 drivers/base/dd.c:1296
 bus_remove_device+0x22f/0x420 drivers/base/bus.c:576
 device_del+0x396/0x9f0 drivers/base/core.c:3864
 hid_remove_device drivers/hid/hid-core.c:2939 [inline]
 hid_destroy_device+0xe5/0x150 drivers/hid/hid-core.c:2959
 usbhid_disconnect+0xa0/0xe0 drivers/hid/usbhid/hid-core.c:1458
 usb_unbind_interface+0x1e8/0x970 drivers/usb/core/driver.c:461
 device_remove drivers/base/dd.c:569 [inline]
 device_remove+0x122/0x170 drivers/base/dd.c:561
 __device_release_driver drivers/base/dd.c:1273 [inline]
 device_release_driver_internal+0x44a/0x610 drivers/base/dd.c:1296
 bus_remove_device+0x22f/0x420 drivers/base/bus.c:576
 device_del+0x396/0x9f0 drivers/base/core.c:3864
 usb_disable_device+0x36c/0x7f0 drivers/usb/core/message.c:1418
 usb_disconnect+0x2e1/0x920 drivers/usb/core/hub.c:2304
 hub_port_connect drivers/usb/core/hub.c:5361 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5661 [inline]
 port_event drivers/usb/core/hub.c:5821 [inline]
 hub_event+0x1bed/0x4f40 drivers/usb/core/hub.c:5903
 process_one_work+0x9c5/0x1ba0 kernel/workqueue.c:3229
 process_scheduled_works kernel/workqueue.c:3310 [inline]
 worker_thread+0x6c8/0xf00 kernel/workqueue.c:3391
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:kworker/1:4     state:I stack:29152 pid:4913  tgid:4913  ppid:2      flags:0x00004000
Workqueue:  0x0 (mm_percpu_wq)
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6767
 worker_thread+0x2de/0xf00 kernel/workqueue.c:3406
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:kworker/1:5     state:D stack:27296 pid:4926  tgid:4926  ppid:2      flags:0x00004000
Workqueue: usb_hub_wq hub_event
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6767
 schedule_timeout+0x258/0x2a0 kernel/time/timer.c:2591
 ___down_common+0x2d7/0x460 kernel/locking/semaphore.c:225
 __down_common kernel/locking/semaphore.c:246 [inline]
 __down+0x20/0x30 kernel/locking/semaphore.c:254
 down+0x74/0xa0 kernel/locking/semaphore.c:63
 hid_device_remove+0x29/0x260 drivers/hid/hid-core.c:2749
 device_remove+0xc8/0x170 drivers/base/dd.c:567
 __device_release_driver drivers/base/dd.c:1273 [inline]
 device_release_driver_internal+0x44a/0x610 drivers/base/dd.c:1296
 bus_remove_device+0x22f/0x420 drivers/base/bus.c:576
 device_del+0x396/0x9f0 drivers/base/core.c:3864
 hid_remove_device drivers/hid/hid-core.c:2939 [inline]
 hid_destroy_device+0xe5/0x150 drivers/hid/hid-core.c:2959
 usbhid_disconnect+0xa0/0xe0 drivers/hid/usbhid/hid-core.c:1458
 usb_unbind_interface+0x1e8/0x970 drivers/usb/core/driver.c:461
 device_remove drivers/base/dd.c:569 [inline]
 device_remove+0x122/0x170 drivers/base/dd.c:561
 __device_release_driver drivers/base/dd.c:1273 [inline]
 device_release_driver_internal+0x44a/0x610 drivers/base/dd.c:1296
 bus_remove_device+0x22f/0x420 drivers/base/bus.c:576
 device_del+0x396/0x9f0 drivers/base/core.c:3864
 usb_disable_device+0x36c/0x7f0 drivers/usb/core/message.c:1418
 usb_disconnect+0x2e1/0x920 drivers/usb/core/hub.c:2304
 hub_port_connect drivers/usb/core/hub.c:5361 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5661 [inline]
 port_event drivers/usb/core/hub.c:5821 [inline]
 hub_event+0x1bed/0x4f40 drivers/usb/core/hub.c:5903
 process_one_work+0x9c5/0x1ba0 kernel/workqueue.c:3229
 process_scheduled_works kernel/workqueue.c:3310 [inline]
 worker_thread+0x6c8/0xf00 kernel/workqueue.c:3391
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:kworker/0:4     state:I stack:28192 pid:4965  tgid:4965  ppid:2      flags:0x00004000
Workqueue:  0x0 (events)
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6767
 worker_thread+0x2de/0xf00 kernel/workqueue.c:3406
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:kworker/0:5     state:I stack:22000 pid:4976  tgid:4976  ppid:2      flags:0x00004000
Workqueue:  0x0 (events)
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6767
 worker_thread+0x2de/0xf00 kernel/workqueue.c:3406
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:syz-executor294 state:D stack:27856 pid:4994  tgid:4994  ppid:2658   flags:0x00000006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6767
 exp_funnel_lock+0x344/0x3b0 kernel/rcu/tree_exp.h:320
 synchronize_rcu_expedited+0x290/0x450 kernel/rcu/tree_exp.h:976


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


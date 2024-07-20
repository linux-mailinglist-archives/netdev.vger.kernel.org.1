Return-Path: <netdev+bounces-112279-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C36B937EEA
	for <lists+netdev@lfdr.de>; Sat, 20 Jul 2024 06:25:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50D75281CD5
	for <lists+netdev@lfdr.de>; Sat, 20 Jul 2024 04:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8D508F44;
	Sat, 20 Jul 2024 04:25:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2965C129
	for <netdev@vger.kernel.org>; Sat, 20 Jul 2024 04:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721449526; cv=none; b=BmgFHiq51Wss3u7hSbHzrDRtZS29Ta+pDTifh+HkbZPtl3/ewTlziHlzgDfhX7camoGGXYi1bvAn1IH868jocz6wihmC4gFSjNEucmCiDj3Z8brguxxP3aczYN+4627ZP4to5Bjw4wb11qBTn++TUGu3/7KRq4ftL3nOrUBilMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721449526; c=relaxed/simple;
	bh=n2M18e4aU5nuk5q4mIz1jDkWB/NkOP5uiYQT5HKab88=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=u0CdvBzsi6OtJOPCnY1jieFgefhK5yBjztB4vkOGLRRaKZTmGAITBImDYmCO9O0JfOx/m99615zMcWRfn/MZF1uKDpWEdULqr5lg7cnbSOZKqT1VCngmQzT7mZRVP3aOalF02XAL4nABDYsKM2kB8dVrkZFDJXLxl02I39vDudY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-39827d07ca7so20128925ab.3
        for <netdev@vger.kernel.org>; Fri, 19 Jul 2024 21:25:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721449524; x=1722054324;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ByxoOSv5pN+8lSoVGtQj3lO5NsPmZ9BaCam6ItAw7rQ=;
        b=N04YQ/a07M4b8D+ebrOtpYFX8C88MhquZpJM1FpLszwxY0U9QOz0dfs6RZ6rpwF+SE
         ZhqZLcP10kCQsHAglw8LV78U0zRvJAQgOLarQf9O+qYOUXhuw7XNCyocqIU97O3a8zzf
         jsBmsDWCSxh82w07EGM9QPE+ePopOhulnUYz8izS9wHMV1iV/Q+ckxHPtJDSMq18WLjp
         Ulc/rIvFp/a5lamiUZDCEp4hF9PRaMt13ARt9cl77VMLy8w0NQ5jYbYHIeA2nZvPPEd+
         /AVvjT2Nl9Zk0nig/gOPZFXxtEN9r4TjDB1etUiO9bAbA+tZA3nGrFLKKHk9BKcDKM5T
         9KIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQA9Ii8fDNYDVFHPFcAfTCm2ozx7ecAtCvfsB4E4PdMRImWud4LTJoVSMSSygZ7gU/AL/dRy6q5JV2b64d/j/v+doYAEXX
X-Gm-Message-State: AOJu0Yxj2S2MPCug7m9WV6Gl6ze/rCBh8LuWtbkg2HpY3RaCiPNe7/LW
	kz0AUvlH7+KH6k9d2cGAcSGIoWqwezzqzEhtDZOJaBf1DTqJ3XqxMEQSi0ZWXlNdfjxPgRgd3Ha
	Phg0lJTW4sd/O7GIb2XTeN1N0qQSmw/GhSpLqbiO+9vNe8DfgxeOli24=
X-Google-Smtp-Source: AGHT+IEeVPzmVefnGchE5YFftqNMZuiRIBoXpbxhcxLCihohAXRwJq+zjSaXpISQNVhfuEDtcdGMasFiAsaz9W+Spg8/T2tQ/Ek2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1aae:b0:397:7dd7:bea5 with SMTP id
 e9e14a558f8ab-398e17ac737mr1615815ab.0.1721449523918; Fri, 19 Jul 2024
 21:25:23 -0700 (PDT)
Date: Fri, 19 Jul 2024 21:25:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005f49c2061da633f4@google.com>
Subject: [syzbot] [net?] INFO: rcu detected stall in lapb_t1timer_expiry (2)
From: syzbot <syzbot+0ad4cda8077288e1b15d@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, jhs@mojatatu.com, 
	jiri@resnulli.us, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com, 
	xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    5e0497553643 Merge branch 'link_path_walk'
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=167a7149980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b459dd7449326b1f
dashboard link: https://syzkaller.appspot.com/bug?extid=0ad4cda8077288e1b15d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=116f0be1980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=117a7149980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8379effc488a/disk-5e049755.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/15d272e97422/vmlinux-5e049755.xz
kernel image: https://storage.googleapis.com/syzbot-assets/35ecaef6865c/bzImage-5e049755.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0ad4cda8077288e1b15d@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: {
 1-.... } 2664 jiffies s: 601 root: 0x2/.
rcu: blocking rcu_node structures (internal RCU debug):
Sending NMI from CPU 0 to CPUs 1:
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
NMI backtrace for cpu 1
CPU: 1 PID: 1671 Comm: kworker/1:2 Not tainted 6.10.0-syzkaller-00017-g5e0497553643 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
Workqueue: events request_firmware_work_func
RIP: 0010:number+0x313/0xf90 lib/vsprintf.c:500
Code: 03 42 0f b6 04 28 84 c0 4c 8b 74 24 30 0f 85 0f 0c 00 00 88 9c 24 80 00 00 00 41 bc 01 00 00 00 e9 3d 01 00 00 bf 0a 00 00 00 <89> de e8 16 0f 1f f6 83 fb 0a 75 23 e8 cc 0a 1f f6 48 8d 9c 24 80
RSP: 0018:ffffc90000a17340 EFLAGS: 00000002
RAX: 0000000000010505 RBX: 000000000000000a RCX: ffff888024388000
RDX: 0000000000010505 RSI: 000000000000000a RDI: 000000000000000a
RBP: ffffc90000a17450 R08: ffffffff8b771d69 R09: 0000000000000000
R10: ffffc90000a173c0 R11: fffff52000142e7b R12: 00000000ffff0a00
R13: dffffc0000000000 R14: 000000000000008d R15: ffffc90000a177a1
FS:  0000000000000000(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f0ee01f60f0 CR3: 000000007c4b8000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <IRQ>
 vsnprintf+0x1542/0x1da0 lib/vsprintf.c:2890
 sprintf+0xda/0x120 lib/vsprintf.c:3028
 print_time kernel/printk/printk.c:1330 [inline]
 info_print_prefix+0x16b/0x310 kernel/printk/printk.c:1356
 record_print_text kernel/printk/printk.c:1405 [inline]
 printk_get_next_message+0x6da/0xbe0 kernel/printk/printk.c:2840
 console_emit_next_record kernel/printk/printk.c:2880 [inline]
 console_flush_all+0x410/0xfd0 kernel/printk/printk.c:2979
 console_unlock+0x13b/0x4d0 kernel/printk/printk.c:3048
 vprintk_emit+0x5a6/0x770 kernel/printk/printk.c:2348
 _printk+0xd5/0x120 kernel/printk/printk.c:2373
 int_irq+0x1bd/0x250 drivers/media/usb/gspca/gspca.c:104
 __usb_hcd_giveback_urb+0x42c/0x6e0 drivers/usb/core/hcd.c:1650
 dummy_timer+0x830/0x45d0 drivers/usb/gadget/udc/dummy_hcd.c:1987
 __run_hrtimer kernel/time/hrtimer.c:1689 [inline]
 __hrtimer_run_queues+0x59b/0xd50 kernel/time/hrtimer.c:1753
 hrtimer_interrupt+0x396/0x990 kernel/time/hrtimer.c:1815
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1032 [inline]
 __sysvec_apic_timer_interrupt+0x110/0x3f0 arch/x86/kernel/apic/apic.c:1049
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
 sysvec_apic_timer_interrupt+0x52/0xc0 arch/x86/kernel/apic/apic.c:1043
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:check_kcov_mode kernel/kcov.c:173 [inline]
RIP: 0010:__sanitizer_cov_trace_pc+0x2f/0x70 kernel/kcov.c:207
Code: 8b 04 24 65 48 8b 0c 25 80 d4 03 00 65 8b 15 c0 ab 6d 7e f7 c2 00 01 ff 00 74 11 f7 c2 00 01 00 00 74 35 83 b9 1c 16 00 00 00 <74> 2c 8b 91 f8 15 00 00 83 fa 02 75 21 48 8b 91 00 16 00 00 48 8b
RSP: 0018:ffffc90000a185f8 EFLAGS: 00000246
RAX: ffffffff894e6502 RBX: 0000000000000001 RCX: ffff888024388000
RDX: 0000000000000504 RSI: ffffffff8c1f5520 RDI: ffffffff8c1f54e0
RBP: ffff8880222d6000 R08: ffffffff894e64f0 R09: 1ffffffff25eecb0
R10: dffffc0000000000 R11: fffffbfff25eecb1 R12: ffff888015b55dc0
R13: dffffc0000000000 R14: ffff8880222d6008 R15: 0000000000000000
 rcu_read_lock include/linux/rcupdate.h:782 [inline]
 dev_queue_xmit_nit+0x72/0xc10 net/core/dev.c:2292
 xmit_one net/core/dev.c:3574 [inline]
 dev_hard_start_xmit+0x15f/0x7e0 net/core/dev.c:3594
 sch_direct_xmit+0x2b6/0x5f0 net/sched/sch_generic.c:343
 __dev_xmit_skb net/core/dev.c:3807 [inline]
 __dev_queue_xmit+0x1a24/0x3d30 net/core/dev.c:4359
 lapb_data_transmit+0x91/0xb0 net/lapb/lapb_iface.c:447
 lapb_transmit_buffer+0x168/0x1f0 net/lapb/lapb_out.c:149
 lapb_t1timer_expiry+0x6b8/0xb20
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
RIP: 0010:console_flush_all+0xaad/0xfd0 kernel/printk/printk.c:2985
Code: ff ff e8 b6 ce 1f 00 90 0f 0b 90 e9 d8 f8 ff ff e8 a8 ce 1f 00 e8 c3 4c 07 0a 4d 85 f6 74 b6 e8 99 ce 1f 00 fb 48 8b 44 24 70 <42> 0f b6 04 38 84 c0 48 8b 7c 24 30 0f 85 22 02 00 00 0f b6 1f 31
RSP: 0018:ffffc90004daf5a0 EFLAGS: 00000293
RAX: 1ffff920009b5f00 RBX: 0000000000000000 RCX: ffff888024388000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc90004daf750 R08: ffffffff817659b4 R09: 1ffffffff25eecc2
R10: dffffc0000000000 R11: fffffbfff25eecc3 R12: ffffffff8eb13378
R13: ffffffff8eb13320 R14: 0000000000000200 R15: dffffc0000000000
 console_unlock+0x13b/0x4d0 kernel/printk/printk.c:3048
 vprintk_emit+0x5a6/0x770 kernel/printk/printk.c:2348
 _printk+0xd5/0x120 kernel/printk/printk.c:2373
 regdb_fw_cb+0x19f/0x1c0
 request_firmware_work_func+0x1a4/0x280 drivers/base/firmware_loader/main.c:1167
 process_one_work kernel/workqueue.c:3248 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3329
 worker_thread+0x86d/0xd50 kernel/workqueue.c:3409
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 4.311 msecs
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_main: Resubmit URB failed with error -19
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_main: Resubmit URB failed with error -19
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_main: Resubmit URB failed with error -19
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_main: Resubmit URB failed with error -19
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_pac7302 1-1:0.0: URB error -71, resubmitting
gspca_main: Resubmit URB failed with error -19


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


Return-Path: <netdev+bounces-102994-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4250A905E7E
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 00:27:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADDB11F26B29
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 22:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4469C12C48F;
	Wed, 12 Jun 2024 22:26:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C78455C08
	for <netdev@vger.kernel.org>; Wed, 12 Jun 2024 22:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718231187; cv=none; b=hWLzAqx1y7yVT9yV7GcqLpVfvYSAFZ0xy3smzsdTx33hgzdYLRgujKuJz2lXPl3pW+7zKM4F/AAqvhJN5+sn6InnYAE9+VWWaXsoX+6lBr+dL1x+czb8qb4E/XbaPf9nQU8UQg+SKljCGFbNGUctjgKp7DY4cvvrLFlMndI451k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718231187; c=relaxed/simple;
	bh=MiLr00zhU0Wv8XTksF8fvjDWlEFM2UP6UIcPayn6NtI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=mY8FotA3Q1xSL5ZGXGW5wScFwdgOnIbr/aFlH3kzM5UBWRnKMWUMq2kOLQxBuOwvEmM4efYfrtN+aoo78JaNlfzTdGYcfDbpo7tY12VDhPSs9Mg8etYj6/nPZCcZuv1hHmMAu6Fv81jMIAAPngpqjq3NhZHgWGBMfJYWPPm0esE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3745fb76682so3541165ab.2
        for <netdev@vger.kernel.org>; Wed, 12 Jun 2024 15:26:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718231183; x=1718835983;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HzDJ/pTkToTnRpqPEuUW7Jp9VAOWrTxioldGxcPNyg4=;
        b=VXGqU+hhtRN7rwAMYVxYMyz6aRuNCWu14U6jvPb1RM69nn3vtWlX5E2AFOnq1oFlgZ
         bZwZTYLvbP4cSP55wZYVjO4/2aiWhnKuM62WDH+L7JLLgYveQlgD0+O6xUuuRUb/AWye
         /ZLCg+yI1i7PHOliRIQRh2SQkpBMsgvxWOprD9jQM8ngwRlWl504KQ080/zcM0ltYJOp
         jeTlZ/yronvuYNvSuJp6fnwkZjuIrOimEzTNckRfbUPxE1uXsEjAUNlj9Xz5kP0L/bBh
         iOVjG2BbL2F+IHyu+9+YnS+UzYhDruzvXIWcZ37yhscCYBhJDlKaOpHkDhs11eyqgnum
         wLCA==
X-Forwarded-Encrypted: i=1; AJvYcCWOjwSn1z8Nm2B7btzix3qGEDdMafmVKpsno9/X96XaykqfCD/M1Pm5g+EOWiUlwJSix/h9avso5YgAsXU2HI441ue2APWQ
X-Gm-Message-State: AOJu0YzLjZuAHYRSJQaIlfdQGLCwMn334ec81XPkOgGXEWUjZGDSpSGx
	NiwFdckalXvUfyagJyxLfSe5G3yru8b0dPwudmdfVKOcY6Su1qQlnrm15N3Csin/8JTObh5dooU
	+xLk7TKdFrUlElobVGIYhpHhrcf2mypfPP3qkKkWV3/jYK9WykP1KC2c=
X-Google-Smtp-Source: AGHT+IH+kEMJLYWmZGmbCTeN/zoiW1C2uduTaxDf3bHE954pQ8myzEZMkwL7fFxnPLQGPlUjpdsjUp1kargJT7s6T8efHkwYmmI+
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2145:b0:375:ac5d:d5df with SMTP id
 e9e14a558f8ab-375cd03a724mr2212795ab.0.1718231183340; Wed, 12 Jun 2024
 15:26:23 -0700 (PDT)
Date: Wed, 12 Jun 2024 15:26:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005348f9061ab8df82@google.com>
Subject: [syzbot] [net?] INFO: rcu detected stall in neigh_timer_handler (8)
From: syzbot <syzbot+5127feb52165f8ab165b@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, gregkh@linuxfoundation.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, marcello.bauer@9elements.com, 
	netdev@vger.kernel.org, pabeni@redhat.com, stern@rowland.harvard.edu, 
	sylv@sylv.io, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    dc772f8237f9 Merge tag 'mm-hotfixes-stable-2024-06-07-15-2..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=106a891c980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=333ebe38d43c42e2
dashboard link: https://syzkaller.appspot.com/bug?extid=5127feb52165f8ab165b
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17398dce980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=112fa5ac980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8c3aeafbce8e/disk-dc772f82.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/484bb26b914c/vmlinux-dc772f82.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d86a6cb060e3/bzImage-dc772f82.xz

The issue was bisected to:

commit a7f3813e589fd8e2834720829a47b5eb914a9afe
Author: Marcello Sylvester Bauer <sylv@sylv.io>
Date:   Thu Apr 11 14:51:28 2024 +0000

    usb: gadget: dummy_hcd: Switch to hrtimer transfer scheduler

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1327637e980000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=10a7637e980000
console output: https://syzkaller.appspot.com/x/log.txt?x=1727637e980000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5127feb52165f8ab165b@syzkaller.appspotmail.com
Fixes: a7f3813e589f ("usb: gadget: dummy_hcd: Switch to hrtimer transfer scheduler")

rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: {
 0-.... } 2647 jiffies s: 2905 root: 0x1/.
rcu: blocking rcu_node structures (internal RCU debug):

Sending NMI from CPU 1 to CPUs 0:
cdc_wdm 2-1:1.0: nonzero urb status received: -71
NMI backtrace for cpu 0
CPU: 0 PID: 785 Comm: kworker/0:2 Not tainted 6.10.0-rc2-syzkaller-00315-gdc772f8237f9 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
Workqueue: usb_hub_wq hub_event
RIP: 0010:io_serial_out+0x7e/0xc0 drivers/tty/serial/8250/8250_port.c:413
Code: fc 89 e9 41 d3 e7 48 83 c3 40 48 89 d8 48 c1 e8 03 42 80 3c 20 00 74 08 48 89 df e8 4c 8b bf fc 44 03 3b 44 89 f0 44 89 fa ee <5b> 41 5c 41 5e 41 5f 5d c3 cc cc cc cc 89 e9 80 e1 07 38 c1 7c a7
RSP: 0018:ffffc90000006ab0 EFLAGS: 00000002
RAX: 0000000000000030 RBX: ffffffff94ad1200 RCX: 0000000000000000
RDX: 00000000000003f8 RSI: 0000000000000000 RDI: 0000000000000020
RBP: 0000000000000000 R08: ffffffff853c5efb R09: 1ffff11003f54046
R10: dffffc0000000000 R11: ffffffff853c5eb0 R12: dffffc0000000000
R13: 0000000000000030 R14: 0000000000000030 R15: 00000000000003f8
FS:  0000000000000000(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fa2f6c67850 CR3: 00000000202f6000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <IRQ>
 serial8250_console_write+0x1212/0x1770 drivers/tty/serial/8250/8250_port.c:3393
 console_emit_next_record kernel/printk/printk.c:2928 [inline]
 console_flush_all+0x865/0xfd0 kernel/printk/printk.c:2994
 console_unlock+0x13b/0x4d0 kernel/printk/printk.c:3063
 vprintk_emit+0x5a6/0x770 kernel/printk/printk.c:2345
 dev_vprintk_emit+0x2ae/0x330 drivers/base/core.c:4951
 dev_printk_emit+0xdd/0x120 drivers/base/core.c:4962
 _dev_err+0x122/0x170 drivers/base/core.c:5017
 wdm_int_callback+0x41f/0xac0 drivers/usb/class/cdc-wdm.c:269
 __usb_hcd_giveback_urb+0x373/0x530 drivers/usb/core/hcd.c:1648
 dummy_timer+0x830/0x45d0 drivers/usb/gadget/udc/dummy_hcd.c:1987
 __run_hrtimer kernel/time/hrtimer.c:1687 [inline]
 __hrtimer_run_queues+0x59b/0xd50 kernel/time/hrtimer.c:1751
 hrtimer_interrupt+0x396/0x990 kernel/time/hrtimer.c:1813
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1032 [inline]
 __sysvec_apic_timer_interrupt+0x110/0x3f0 arch/x86/kernel/apic/apic.c:1049
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
 sysvec_apic_timer_interrupt+0x52/0xc0 arch/x86/kernel/apic/apic.c:1043
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:rtnl_notify+0x4f/0xc0 net/core/rtnetlink.c:755
Code: 00 00 00 00 00 fc ff df e8 9e 16 38 f8 48 81 c5 f0 02 00 00 48 89 e8 48 c1 e8 03 42 80 3c 30 00 74 08 48 89 ef e8 71 da 9d f8 <48> 8b 6d 00 48 85 db 74 27 e8 73 16 38 f8 48 83 c3 06 48 89 d8 48
RSP: 0018:ffffc90000007b10 EFLAGS: 00010246
RAX: 1ffffffff296c6be RBX: 0000000000000000 RCX: ffff88801fd83c00
RDX: 0000000000000101 RSI: ffffffff94b63300 RDI: ffff88802e1de8c0
RBP: ffffffff94b635f0 R08: 0000000000000000 R09: 0000000000000820
R10: 00004de500001511 R11: 0000000100000001 R12: 0000000000000003
R13: ffff88802e1de8c0 R14: dffffc0000000000 R15: 0000000000000000
 neigh_update_notify net/core/neighbour.c:2675 [inline]
 neigh_timer_handler+0xaae/0xfd0 net/core/neighbour.c:1166
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
RIP: 0010:console_flush_all+0xaad/0xfd0 kernel/printk/printk.c:3000
Code: ff ff e8 16 d0 1f 00 90 0f 0b 90 e9 d8 f8 ff ff e8 08 d0 1f 00 e8 83 31 10 0a 4d 85 f6 74 b6 e8 f9 cf 1f 00 fb 48 8b 44 24 70 <42> 0f b6 04 38 84 c0 48 8b 7c 24 30 0f 85 22 02 00 00 0f b6 1f 31
RSP: 0018:ffffc9000333f040 EFLAGS: 00000293
RAX: 1ffff92000667e54 RBX: 0000000000000000 RCX: ffff88801fd83c00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc9000333f1f0 R08: ffffffff81765624 R09: 1ffffffff25f56ca
R10: dffffc0000000000 R11: fffffbfff25f56cb R12: ffffffff8eb225f8
R13: ffffffff8eb225a0 R14: 0000000000000200 R15: dffffc0000000000
 console_unlock+0x13b/0x4d0 kernel/printk/printk.c:3063
 vprintk_emit+0x5a6/0x770 kernel/printk/printk.c:2345
 dev_vprintk_emit+0x2ae/0x330 drivers/base/core.c:4951
 dev_printk_emit+0xdd/0x120 drivers/base/core.c:4962
 _dev_info+0x122/0x170 drivers/base/core.c:5020
 hub_port_init+0x7bf/0x2670 drivers/usb/core/hub.c:4950
 hub_port_connect drivers/usb/core/hub.c:5450 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5661 [inline]
 port_event drivers/usb/core/hub.c:5821 [inline]
 hub_event+0x295f/0x5150 drivers/usb/core/hub.c:5903
 process_one_work kernel/workqueue.c:3231 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3312
 worker_thread+0x86d/0xd70 kernel/workqueue.c:3393
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 4.241 msecs
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: wdm_int_callback - usb_submit_urb failed with result -19
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: wdm_int_callback - usb_submit_urb failed with result -19
cdc_wdm 4-1:1.0: nonzero urb status received: -71
cdc_wdm 4-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 4-1:1.0: nonzero urb status received: -71
cdc_wdm 4-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 4-1:1.0: nonzero urb status received: -71
cdc_wdm 4-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 4-1:1.0: nonzero urb status received: -71
cdc_wdm 4-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 4-1:1.0: wdm_int_callback - usb_submit_urb failed with result -19
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: wdm_int_callback - usb_submit_urb failed with result -19
cdc_wdm 4-1:1.0: nonzero urb status received: -71
cdc_wdm 4-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 4-1:1.0: nonzero urb status received: -71
cdc_wdm 4-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 4-1:1.0: wdm_int_callback - usb_submit_urb failed with result -19
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: wdm_int_callback - usb_submit_urb failed with result -19
cdc_wdm 4-1:1.0: nonzero urb status received: -71
cdc_wdm 4-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 4-1:1.0: nonzero urb status received: -71
cdc_wdm 4-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 4-1:1.0: nonzero urb status received: -71
cdc_wdm 4-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 4-1:1.0: nonzero urb status received: -71
cdc_wdm 4-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 4-1:1.0: nonzero urb status received: -71
cdc_wdm 4-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 4-1:1.0: nonzero urb status received: -71
cdc_wdm 4-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 4-1:1.0: wdm_int_callback - usb_submit_urb failed with result -19
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: wdm_int_callback - usb_submit_urb failed with result -19
cdc_wdm 4-1:1.0: nonzero urb status received: -71
cdc_wdm 4-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 4-1:1.0: wdm_int_callback - usb_submit_urb failed with result -19
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: wdm_int_callback - usb_submit_urb failed with result -19
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: wdm_int_callback - usb_submit_urb failed with result -19
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: wdm_int_callback - usb_submit_urb failed with result -19
cdc_wdm 1-1:1.0: nonzero urb status received: -71
cdc_wdm 1-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 1-1:1.0: nonzero urb status received: -71
cdc_wdm 1-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 1-1:1.0: nonzero urb status received: -71
cdc_wdm 1-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 1-1:1.0: nonzero urb status received: -71
cdc_wdm 1-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 1-1:1.0: nonzero urb status received: -71
cdc_wdm 1-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 1-1:1.0: wdm_int_callback - usb_submit_urb failed with result -19
cdc_wdm 4-1:1.0: nonzero urb status received: -71
cdc_wdm 4-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 4-1:1.0: nonzero urb status received: -71
cdc_wdm 4-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 4-1:1.0: nonzero urb status received: -71
cdc_wdm 4-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 4-1:1.0: nonzero urb status received: -71
cdc_wdm 4-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 4-1:1.0: nonzero urb status received: -71
cdc_wdm 4-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 4-1:1.0: nonzero urb status received: -71
cdc_wdm 4-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 4-1:1.0: wdm_int_callback - usb_submit_urb failed with result -19
cdc_wdm 3-1:1.0: nonzero urb status received: -71
cdc_wdm 3-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 3-1:1.0: nonzero urb status received: -71
cdc_wdm 3-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 3-1:1.0: nonzero urb status received: -71
cdc_wdm 3-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 3-1:1.0: nonzero urb status received: -71
cdc_wdm 3-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 3-1:1.0: nonzero urb status received: -71
cdc_wdm 3-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 3-1:1.0: nonzero urb status received: -71
cdc_wdm 3-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 3-1:1.0: nonzero urb status received: -71
cdc_wdm 3-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 3-1:1.0: nonzero urb status received: -71
cdc_wdm 3-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 3-1:1.0: nonzero urb status received: -71
cdc_wdm 3-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 3-1:1.0: nonzero urb status received: -71
cdc_wdm 3-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 3-1:1.0: nonzero urb status received: -71
cdc_wdm 3-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 3-1:1.0: nonzero urb status received: -71
cdc_wdm 3-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 3-1:1.0: wdm_int_callback - usb_submit_urb failed with result -19
cdc_wdm 4-1:1.0: nonzero urb status received: -71
cdc_wdm 4-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 4-1:1.0: nonzero urb status received: -71
cdc_wdm 4-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 4-1:1.0: nonzero urb status received: -71
cdc_wdm 4-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 4-1:1.0: nonzero urb status received: -71
cdc_wdm 4-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 4-1:1.0: nonzero urb status received: -71
cdc_wdm 4-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 4-1:1.0: wdm_int_callback - usb_submit_urb failed with result -19


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


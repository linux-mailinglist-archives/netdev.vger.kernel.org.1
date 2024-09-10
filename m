Return-Path: <netdev+bounces-126996-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5958897393C
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 16:00:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9AB06B2498A
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 14:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 116901917E5;
	Tue, 10 Sep 2024 14:00:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B71E28389
	for <netdev@vger.kernel.org>; Tue, 10 Sep 2024 14:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725976836; cv=none; b=VFRHOCx+56RbqC60rpOVUfLalOIdJjiW4ThU+VWfCt6A88QN9ALjg1Vb2iyuSFkjKy4Try8F61UZteag/CyeoraXGRHvC7iUfV42qKvF1LJccABMLVDCOnvXZOv6KxC2fxax48obgizSB6vfxeWRSOt3hJj1waR+2oT6DqTnSKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725976836; c=relaxed/simple;
	bh=hGS5CWsMB0WMZph5YSbRjOIyjXr281graLsqlzfsyvU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=oIXJ9n4szFrRjCPgwHk66uU7P0nosKLxn4cPLmVJHa6EWRf1EYpUTgzkwDl0Cby6NJoWllcilmm7Z2kGs3K+WnU5RU5Gz9eQg65wkWR6nb/KlV6JgV8xC5QqzwR/KyIAsE/b9pd28xUIo2VYAILIcm2xbERW8v4vC+vXyEfRREM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a059c2c64eso3038285ab.2
        for <netdev@vger.kernel.org>; Tue, 10 Sep 2024 07:00:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725976833; x=1726581633;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NSI+9gLUZ4epPk7UdP/IwxBpOO/r6+GDK9O/LWS/7mo=;
        b=fWU5nKLNa6qrwSzLsFKuTYkZD91RwIcy+BTYYP5IyPp4xQJq5Jivsyd8jv90Vgp3S2
         28xr7MqTAyw5XHBwb3XQ0KMUE5F74a0yT3yVPjJx6xCKP7JOXx+jTlCw/9iiuCmr/5vH
         HLvGEHoMBnt4MsBoYfPLfyn2c1moXy3Lrrxa/DsZM/8b2Tk2F+HYA+RMlszFXL/BUVwL
         MHPMh7fvC0PuHRdJvP6gjdO0teryAnV/9J2TZV/zynGY27MZy8FhugGZSMgAZyqu3iP+
         32VJuBfY9dQK2GsKMh/Qt5u16kGa2SHAwKbSX7NBzBkKGbd1Fw9mQ9Qu/D0bGoVMXKNc
         pwbg==
X-Forwarded-Encrypted: i=1; AJvYcCUJfTj6VxIkkH/TfpHEoxHhwKZkP7PTFZddkRDYlyyrFufZOwLkyvMjvZiIkWWg4tbIGNgxl78=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTvbGxKRDYli+5XL07cBj3tr1bgjVLIO3NHWYCMlI4Wi9BUX3Q
	QkISz9ZKV5NdmiaEMOledWmdiIGo+53zlZEMejKacUxCPcAB3EUMHfkEKHW8HSd/1ydtkUljH7o
	HSMiX/JIc7GpGCAA3f1CemwaGKcJ0wkEgPcP5DmJqg0Yxujb0SqOnXvk=
X-Google-Smtp-Source: AGHT+IHcfS1emu6l+xffhLXJ3vd7YsFFxkLANN6KEAc4zpnKNjJpzxF/cOVOPrQgojx8/bOwS1KE2+1bqes7w9HPp+UjmJ/9Rw03
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d1d:b0:3a0:4e53:9b8a with SMTP id
 e9e14a558f8ab-3a04f070a0emr71828205ab.1.1725976833501; Tue, 10 Sep 2024
 07:00:33 -0700 (PDT)
Date: Tue, 10 Sep 2024 07:00:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000d402f0621c44c87@google.com>
Subject: [syzbot] [net?] general protection fault in send_hsr_supervision_frame
 (2)
From: syzbot <syzbot+c229849f5b6c82eba3c2@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    4c8002277167 fou: fix initialization of grc
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=12f46797980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=660f6eb11f9c7dc5
dashboard link: https://syzkaller.appspot.com/bug?extid=c229849f5b6c82eba3c2
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/9058e311cdd1/disk-4c800227.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1659255894d5/vmlinux-4c800227.xz
kernel image: https://storage.googleapis.com/syzbot-assets/04227ccb2e58/bzImage-4c800227.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c229849f5b6c82eba3c2@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000003: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000018-0x000000000000001f]
CPU: 0 UID: 0 PID: 11 Comm: kworker/u8:0 Not tainted 6.11.0-rc6-syzkaller-00180-g4c8002277167 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
Workqueue: netns cleanup_net
RIP: 0010:send_hsr_supervision_frame+0x37/0xa90 net/hsr/hsr_device.c:290
Code: 53 48 83 ec 38 48 89 54 24 30 49 89 f7 49 89 fd 48 bb 00 00 00 00 00 fc ff df e8 54 a0 f9 f5 49 8d 6d 18 48 89 e8 48 c1 e8 03 <80> 3c 18 00 74 08 48 89 ef e8 7b e6 60 f6 48 8b 6d 00 4d 89 fc 49
RSP: 0018:ffffc90000007a70 EFLAGS: 00010206
RAX: 0000000000000003 RBX: dffffc0000000000 RCX: ffff88801ced3c00
RDX: 0000000000000100 RSI: ffffc90000007b40 RDI: 0000000000000000
RBP: 0000000000000018 R08: ffffffff8b995013 R09: 1ffffffff283c908
R10: dffffc0000000000 R11: ffffffff8b99ec30 R12: ffff888065030e98
R13: 0000000000000000 R14: ffff888065030cf0 R15: ffffc90000007b40
FS:  0000000000000000(0000) GS:ffff8880b8800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f76c4f21cf8 CR3: 000000000e734000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 hsr_proxy_announce+0x23a/0x4c0 net/hsr/hsr_device.c:420
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
RIP: 0010:dev_get_stats+0x194/0xa00 net/core/dev.c:10906
Code: 00 00 ba 10 00 00 00 31 f6 e8 48 57 71 f8 49 81 c7 e8 02 00 00 4c 89 f8 48 c1 e8 03 48 b9 00 00 00 00 00 fc ff df 80 3c 08 00 <74> 08 4c 89 ff e8 52 54 71 f8 49 8b 07 48 89 44 24 38 48 85 c0 0f
RSP: 0018:ffffc900001070a8 EFLAGS: 00000246
RAX: 1ffff110063ac85d RBX: 1ffffffff193175c RCX: dffffc0000000000
RDX: 0000000000000006 RSI: ffffffff8c0ae6e0 RDI: ffffffff8c608d80
RBP: ffffffff8c98bae0 R08: ffffffff9018706f R09: 1ffffffff2030e0d
R10: dffffc0000000000 R11: fffffbfff2030e0e R12: ffffc900001072c0
R13: ffffc90000107230 R14: ffffffff8c98ba40 R15: ffff888031d642e8
 bond_get_stats+0x4f7/0x770 drivers/net/bonding/bond_main.c:4482
 dev_get_stats+0xad/0xa00 net/core/dev.c:10894
 rtnl_fill_stats+0x47/0x880 net/core/rtnetlink.c:1268
 rtnl_fill_ifinfo+0x18da/0x2270 net/core/rtnetlink.c:1909
 rtmsg_ifinfo_build_skb+0x18a/0x260 net/core/rtnetlink.c:4079
 unregister_netdevice_many_notify+0xe24/0x1c40 net/core/dev.c:11356
 cleanup_net+0x75d/0xcc0 net/core/net_namespace.c:635
 process_one_work kernel/workqueue.c:3231 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3312
 worker_thread+0x86d/0xd10 kernel/workqueue.c:3389
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:send_hsr_supervision_frame+0x37/0xa90 net/hsr/hsr_device.c:290
Code: 53 48 83 ec 38 48 89 54 24 30 49 89 f7 49 89 fd 48 bb 00 00 00 00 00 fc ff df e8 54 a0 f9 f5 49 8d 6d 18 48 89 e8 48 c1 e8 03 <80> 3c 18 00 74 08 48 89 ef e8 7b e6 60 f6 48 8b 6d 00 4d 89 fc 49
RSP: 0018:ffffc90000007a70 EFLAGS: 00010206
RAX: 0000000000000003 RBX: dffffc0000000000 RCX: ffff88801ced3c00
RDX: 0000000000000100 RSI: ffffc90000007b40 RDI: 0000000000000000
RBP: 0000000000000018 R08: ffffffff8b995013 R09: 1ffffffff283c908
R10: dffffc0000000000 R11: ffffffff8b99ec30 R12: ffff888065030e98
R13: 0000000000000000 R14: ffff888065030cf0 R15: ffffc90000007b40
FS:  0000000000000000(0000) GS:ffff8880b8800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f76c4f21cf8 CR3: 000000000e734000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	53                   	push   %rbx
   1:	48 83 ec 38          	sub    $0x38,%rsp
   5:	48 89 54 24 30       	mov    %rdx,0x30(%rsp)
   a:	49 89 f7             	mov    %rsi,%r15
   d:	49 89 fd             	mov    %rdi,%r13
  10:	48 bb 00 00 00 00 00 	movabs $0xdffffc0000000000,%rbx
  17:	fc ff df
  1a:	e8 54 a0 f9 f5       	call   0xf5f9a073
  1f:	49 8d 6d 18          	lea    0x18(%r13),%rbp
  23:	48 89 e8             	mov    %rbp,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	80 3c 18 00          	cmpb   $0x0,(%rax,%rbx,1) <-- trapping instruction
  2e:	74 08                	je     0x38
  30:	48 89 ef             	mov    %rbp,%rdi
  33:	e8 7b e6 60 f6       	call   0xf660e6b3
  38:	48 8b 6d 00          	mov    0x0(%rbp),%rbp
  3c:	4d 89 fc             	mov    %r15,%r12
  3f:	49                   	rex.WB


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


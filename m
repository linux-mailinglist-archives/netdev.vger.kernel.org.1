Return-Path: <netdev+bounces-248279-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 80D6BD06739
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 23:43:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A17523019B58
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 22:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27E5F32B990;
	Thu,  8 Jan 2026 22:43:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f79.google.com (mail-ot1-f79.google.com [209.85.210.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75262326931
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 22:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767912206; cv=none; b=ceEpY2oPcbTJ+NzwPGG3H3enVvhOCG8LYQEP6l6dPcv1MkcSbH+Q8K1d/YPYXXDGQCXb4qEqLiP23jWaIJ7Mrc+1hvnJWIc3LOki8svP0nzruJwuIYiTB+BRtp0V9xK33eHAmhC4qCN/vgj75sHrXubNGuGcJ9ds04D90HbzjS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767912206; c=relaxed/simple;
	bh=D4SiCcZnagi1n5ujXKNODjmWJFDN8mwFcgYlm5guZjk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=pLKZ5rjLSGHgNPJZxy72KgxldG4nK1xVhX1+18btANHg5OdmQsJ+99Zhpl1QS+DQkYZnkIAl/2fWAE5k4P3h3r1YfMPWdOlMbGsVqrt7jKTjB+M7wn9joqNUlyDrqDenVHkFn0dABlsfIs0EHBVT9aKqilxi0eKqNHuSIuqrMcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f79.google.com with SMTP id 46e09a7af769-7c70930bdf4so812627a34.2
        for <netdev@vger.kernel.org>; Thu, 08 Jan 2026 14:43:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767912203; x=1768517003;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9TiEK9HPqCMHBDhTZnOlClVfYIrH5v0N+vhwn/LE/jA=;
        b=uzjDroQG1sIGKQ+aJAX0ZeXNR9o2LfWCTININqups1+FrAtfg8WcdhvhH7d003ApP9
         m0bmZSEPMjtfvHROWNf0YE+zz72lRNSatZYGoYxKPIEfTkENOmrt4hMvHMdL9B9dNPlw
         TjpQAVr83uRMbcx7kMB6XOmUIbvIoRS4eQNwpd/WSBZO25CgtTxld/MMpZuZ+vi1oaDQ
         BOf6UjEY7GC5uHCHA3SMkLcr51m8lF2o516+ODAAwFE0embQ3VaAU5KMpLx16PAUrOXa
         y7SgRbaT6rEJ9GGi/jjiS/J6910JwNi1Cz5qUdgPtJUSTAPh4JxhBqKnn0moLHBs9uZl
         fnxw==
X-Forwarded-Encrypted: i=1; AJvYcCWwXvg4nDgqU2nArlMottw8ptnvcmCYEXY+u/rp1fDjK5P6qWrgXQiB48AT84rlheh4Q8Q5Ug4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz45KVGv4mYHr0It469PT5PQo1Y1C5WbP/h1FuIa8Y7lgdimR6N
	kaNKcvqLP5oepUVjA3i1e4fM3TKcFXGP3wMTlRgF8zzRr7nyjNXJ3aOx1or3Mwzgs3nDU3FlW/X
	BU9aRHZ9OsMkiqxTfIicPdQE5fYLQkSDsSH5Zis3E0Izzk8uxNsl3j8Xj+jg=
X-Google-Smtp-Source: AGHT+IE8xjXTGeRVle2y1n9kyRhHQ27tNqGnF+vOObwYB1W2n6IDOLJRU7eiCCGS9BqZQrPHgusDY97H9CLlxWdaDI/Zw6baX5hM
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:60b:b0:65f:bad:789c with SMTP id
 006d021491bc7-65f54f670d5mr3384227eaf.58.1767912203538; Thu, 08 Jan 2026
 14:43:23 -0800 (PST)
Date: Thu, 08 Jan 2026 14:43:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6960330b.050a0220.1c677c.03a9.GAE@google.com>
Subject: [syzbot] [wireguard?] WARNING in stub_timer
From: syzbot <syzbot+19e796f043fe3be7b76a@syzkaller.appspotmail.com>
To: Jason@zx2c4.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com, 
	wireguard@lists.zx2c4.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    54e82e93ca93 Merge tag 'core_urgent_for_v6.19_rc4' of git:..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1022ee22580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=513255d80ab78f2b
dashboard link: https://syzkaller.appspot.com/bug?extid=19e796f043fe3be7b76a
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-54e82e93.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f3befb5f53a4/vmlinux-54e82e93.xz
kernel image: https://storage.googleapis.com/syzbot-assets/92820ca1dbd8/bzImage-54e82e93.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+19e796f043fe3be7b76a@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: kernel/time/timer.c:716 at stub_timer+0xa/0x20 kernel/time/timer.c:716, CPU#0: kworker/0:1/10
Modules linked in:
CPU: 0 UID: 0 PID: 10 Comm: kworker/0:1 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Workqueue: events_power_efficient wg_ratelimiter_gc_entries
RIP: 0010:stub_timer+0xa/0x20 kernel/time/timer.c:716
Code: 0f 94 c0 5b 41 5e e9 05 73 b0 09 cc 0f 1f 40 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa e8 27 fa 12 00 90 <0f> 0b 90 c3 cc cc cc cc cc 66 66 66 66 2e 0f 1f 84 00 00 00 00 00
RSP: 0018:ffffc90000007c98 EFLAGS: 00010246
RAX: ffffffff81ae0d39 RBX: 0000000000000101 RCX: ffff88801bef0000
RDX: 0000000000000100 RSI: ffffffff8bc095c0 RDI: ffffc9000db0f1c0
RBP: ffffc90000007d90 R08: ffffffff8f824677 R09: 1ffffffff1f048ce
R10: dffffc0000000000 R11: ffffffff81ae0d30 R12: 0000000000000000
R13: ffffc9000db0f1c0 R14: 1ffff92000000f98 R15: 0000000000000001
FS:  0000000000000000(0000) GS:ffff88808d414000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f2cc5528910 CR3: 00000000377e7000 CR4: 0000000000352ef0
Call Trace:
 <IRQ>
 call_timer_fn+0x16e/0x590 kernel/time/timer.c:1748
 expire_timers kernel/time/timer.c:1799 [inline]
 __run_timers kernel/time/timer.c:2373 [inline]
 __run_timer_base+0x61a/0x860 kernel/time/timer.c:2385
 run_timer_base kernel/time/timer.c:2394 [inline]
 run_timer_softirq+0xb7/0x180 kernel/time/timer.c:2404
 handle_softirqs+0x22b/0x7c0 kernel/softirq.c:622
 __do_softirq kernel/softirq.c:656 [inline]
 invoke_softirq kernel/softirq.c:496 [inline]
 __irq_exit_rcu+0x60/0x150 kernel/softirq.c:723
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:739
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1056 [inline]
 sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1056
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:697
RIP: 0010:lock_release+0x2d8/0x3b0 kernel/locking/lockdep.c:5893
Code: e4 e2 10 00 00 00 00 eb b5 e8 84 7f bd 09 f7 c3 00 02 00 00 74 b9 65 48 8b 05 74 9e e2 10 48 3b 44 24 28 75 44 fb 48 83 c4 30 <5b> 41 5c 41 5d 41 5e 41 5f 5d e9 59 5e c0 09 cc 48 8d 3d 11 6d e7
RSP: 0018:ffffc900001c79e0 EFLAGS: 00000282
RAX: f62d7e25cf48d100 RBX: 0000000000000283 RCX: 0000000080000001
RDX: 0000000000000002 RSI: ffffffff8d97c93e RDI: ffffffff8bc095e0
RBP: ffff88801bef0b80 R08: 0000000000000003 R09: 0000000000000004
R10: dffffc0000000000 R11: fffff52000038f34 R12: 0000000000000002
R13: 0000000000000002 R14: ffffffff8ea6eef8 R15: ffff88801bef0000
 __raw_spin_unlock include/linux/spinlock_api_smp.h:141 [inline]
 _raw_spin_unlock+0x16/0x50 kernel/locking/spinlock.c:186
 spin_unlock include/linux/spinlock.h:391 [inline]
 wg_ratelimiter_gc_entries+0x384/0x450 drivers/net/wireguard/ratelimiter.c:76
 process_one_work kernel/workqueue.c:3257 [inline]
 process_scheduled_works+0xad1/0x1770 kernel/workqueue.c:3340
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3421
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x510/0xa50 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246
 </TASK>
----------------
Code disassembly (best guess):
   0:	e4 e2                	in     $0xe2,%al
   2:	10 00                	adc    %al,(%rax)
   4:	00 00                	add    %al,(%rax)
   6:	00 eb                	add    %ch,%bl
   8:	b5 e8                	mov    $0xe8,%ch
   a:	84 7f bd             	test   %bh,-0x43(%rdi)
   d:	09 f7                	or     %esi,%edi
   f:	c3                   	ret
  10:	00 02                	add    %al,(%rdx)
  12:	00 00                	add    %al,(%rax)
  14:	74 b9                	je     0xffffffcf
  16:	65 48 8b 05 74 9e e2 	mov    %gs:0x10e29e74(%rip),%rax        # 0x10e29e92
  1d:	10
  1e:	48 3b 44 24 28       	cmp    0x28(%rsp),%rax
  23:	75 44                	jne    0x69
  25:	fb                   	sti
  26:	48 83 c4 30          	add    $0x30,%rsp
* 2a:	5b                   	pop    %rbx <-- trapping instruction
  2b:	41 5c                	pop    %r12
  2d:	41 5d                	pop    %r13
  2f:	41 5e                	pop    %r14
  31:	41 5f                	pop    %r15
  33:	5d                   	pop    %rbp
  34:	e9 59 5e c0 09       	jmp    0x9c05e92
  39:	cc                   	int3
  3a:	48                   	rex.W
  3b:	8d                   	.byte 0x8d
  3c:	3d                   	.byte 0x3d
  3d:	11 6d e7             	adc    %ebp,-0x19(%rbp)


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


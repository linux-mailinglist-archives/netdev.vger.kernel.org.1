Return-Path: <netdev+bounces-112359-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6EEE9388CE
	for <lists+netdev@lfdr.de>; Mon, 22 Jul 2024 08:14:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D87FB20D06
	for <lists+netdev@lfdr.de>; Mon, 22 Jul 2024 06:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95F1817BA3;
	Mon, 22 Jul 2024 06:14:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D81AC18042
	for <netdev@vger.kernel.org>; Mon, 22 Jul 2024 06:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721628864; cv=none; b=hD5Wbz/906KG47W7pb9lJDOsGFtiBcDF01TsOLuDd5iMMf3s16VjDUZV3vD0qdaqxM7ldfJw0+EwYMABf6xRGbTiGXFxnCbOm+ZJ5SNNebJLwi+wAnHAWkBPr3JUC9xQVSyZzK4A8bvl8vW/3QaDVw96pmUWTDr9/9GCp5mAskQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721628864; c=relaxed/simple;
	bh=/eyD6HCsH1UmSIV9phStUm4X/SnjGHfK2IHwLF1n+9g=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=V6yZlzffxl5/6DIimbGwndcnNisBH7pbZUyUmjR7O+WjXKwdjFJ0XZol5vpevCiKq657EmQ4BTvoLf5F+GiFspNgDameiEX0LUT0oImO13pdJZyU6vxE9hLz3UMmWdVDKgsScExq6LI8ebMJCd6CHyBZi4cq94rd4CDhw3CRERg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-39817c86dc1so44133475ab.0
        for <netdev@vger.kernel.org>; Sun, 21 Jul 2024 23:14:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721628862; x=1722233662;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gru2AhLxxo0LYxQduGd0yhBPJk3tJ2VvI8DmdYaNIG4=;
        b=SQ7JSuhNIoCupvBcZzFLuMvY0p4yVovS7bWup9l+wL7aWmYFDw5Z88SYkeEbJia2tN
         OEBnJV1VLKgaQnwRtUxIPKgcWVUESQFFUmS1ZaZLWm07JLW1XsYRqR+AJcC7sddWnnv0
         lAvlavw3umzhI5UvfgIHEFK5X0h0OBu+lnTTQunTnEZpS9I68p3dd89s1e/TX2JhL0av
         w84OzBPfqa5nlnFTQhLs1UebHvNZ1smhTJGn1c/ouRTtDHhhacanTfMkCs0P4n9vyf8D
         zYkyBiNKmjKN+gGF1qD6jrFyWKZHPqHPBGoNWJXVK1ITwCAvYj8eD/uz23YoZofffywh
         TnwQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFUb0cyX8IQHAlwBmnvARWQ8/Zjqd/vPIBzS7vfY5bD7PQxckMIqqDnR1X6vsgDZabtxIaq2GdePGhfsPNkG30276LDMrr
X-Gm-Message-State: AOJu0YyCBY5lg9eQNzbJYPOl+x3B06/cZCjPrHLoZ7s/QPx7y8NSppt8
	Oi6Rw67eboCm+lHNN8JLmf4nJyFS7Ai2Asjgd0fyZvBr/AI7iQ54ttWeY15EkclNHNfBeJS7rse
	+ZPneDXrPDbZ0Dsc2bQ3GtprDg5/BgnfTNpaWwu5dU9Pb+iFsACT2OOM=
X-Google-Smtp-Source: AGHT+IGRgx3mBmXSAi/ZeOlVcipCDW6rMswB62W8uFEt5wKspDP/ZRGObdLgDCp3yW6oEHeAdfCWw3+k4l+p3LpEpiQUHAeHdtKq
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a0c:b0:396:ec3b:df69 with SMTP id
 e9e14a558f8ab-398e67c444fmr4392365ab.3.1721628862018; Sun, 21 Jul 2024
 23:14:22 -0700 (PDT)
Date: Sun, 21 Jul 2024 23:14:22 -0700
In-Reply-To: <000000000000ee5c6c060fd59890@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c18c15061dcff478@google.com>
Subject: Re: [syzbot] [v9fs?] WARNING: refcount bug in p9_req_put (3)
From: syzbot <syzbot+d99d2414db66171fccbb@syzkaller.appspotmail.com>
To: asmadeus@codewreck.org, ericvh@kernel.org, kuba@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux_oss@crudebyte.com, lucho@ionkov.net, netdev@vger.kernel.org, 
	nogikh@google.com, syzkaller-bugs@googlegroups.com, v9fs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    7846b618e0a4 Merge tag 'rtc-6.11' of git://git.kernel.org/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1221eb21980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=be4129de17851dbe
dashboard link: https://syzkaller.appspot.com/bug?extid=d99d2414db66171fccbb
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15555ec3980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15900f49980000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-7846b618.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3a2831ffe61c/vmlinux-7846b618.xz
kernel image: https://storage.googleapis.com/syzbot-assets/575e23a7c452/bzImage-7846b618.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d99d2414db66171fccbb@syzkaller.appspotmail.com

------------[ cut here ]------------
refcount_t: underflow; use-after-free.
WARNING: CPU: 3 PID: 5213 at lib/refcount.c:28 refcount_warn_saturate+0x14a/0x210 lib/refcount.c:28
Modules linked in:
CPU: 3 PID: 5213 Comm: syz-executor225 Not tainted 6.10.0-syzkaller-11323-g7846b618e0a4 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:refcount_warn_saturate+0x14a/0x210 lib/refcount.c:28
Code: ff 89 de e8 08 59 08 fd 84 db 0f 85 66 ff ff ff e8 5b 5e 08 fd c6 05 e6 c9 4e 0b 01 90 48 c7 c7 80 3b 90 8b e8 a7 9b ca fc 90 <0f> 0b 90 90 e9 43 ff ff ff e8 38 5e 08 fd 0f b6 1d c1 c9 4e 0b 31
RSP: 0018:ffffc90000908d90 EFLAGS: 00010082
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff814c9029
RDX: ffff888026a3a440 RSI: ffffffff814c9036 RDI: 0000000000000001
RBP: ffff88801e6b4ff8 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: dffffc0000000000
R13: ffff88801e6b4ff8 R14: ffff88801b0c5c00 R15: 0000000000000000
FS:  000055557f8c13c0(0000) GS:ffff88806b300000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f95101d91b8 CR3: 00000000204fe000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 __refcount_sub_and_test include/linux/refcount.h:275 [inline]
 __refcount_dec_and_test include/linux/refcount.h:307 [inline]
 refcount_dec_and_test include/linux/refcount.h:325 [inline]
 p9_req_put+0x1f4/0x250 net/9p/client.c:404
 req_done+0x1e7/0x2f0 net/9p/trans_virtio.c:147
 vring_interrupt drivers/virtio/virtio_ring.c:2595 [inline]
 vring_interrupt+0x31b/0x400 drivers/virtio/virtio_ring.c:2570
 __handle_irq_event_percpu+0x229/0x7c0 kernel/irq/handle.c:158
 handle_irq_event_percpu kernel/irq/handle.c:193 [inline]
 handle_irq_event+0xab/0x1e0 kernel/irq/handle.c:210
 handle_edge_irq+0x263/0xd10 kernel/irq/chip.c:831
 generic_handle_irq_desc include/linux/irqdesc.h:173 [inline]
 handle_irq arch/x86/kernel/irq.c:247 [inline]
 call_irq_handler arch/x86/kernel/irq.c:259 [inline]
 __common_interrupt+0xdf/0x250 arch/x86/kernel/irq.c:285
 common_interrupt+0xab/0xd0 arch/x86/kernel/irq.c:278
 </IRQ>
 <TASK>
 asm_common_interrupt+0x26/0x40 arch/x86/include/asm/idtentry.h:693
RIP: 0010:__raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:152 [inline]
RIP: 0010:_raw_spin_unlock_irqrestore+0x31/0x80 kernel/locking/spinlock.c:194
Code: f5 53 48 8b 74 24 10 48 89 fb 48 83 c7 18 e8 36 9d 75 f6 48 89 df e8 4e 1a 76 f6 f7 c5 00 02 00 00 75 23 9c 58 f6 c4 02 75 37 <bf> 01 00 00 00 e8 a5 90 67 f6 65 8b 05 e6 50 11 75 85 c0 74 16 5b
RSP: 0018:ffffc90003387c20 EFLAGS: 00000246
RAX: 0000000000000002 RBX: ffff88801e795280 RCX: 1ffffffff1fce401
RDX: 0000000000000000 RSI: ffffffff8b2cbac0 RDI: ffffffff8b909e40
RBP: 0000000000000246 R08: 0000000000000001 R09: 0000000000000001
R10: ffffffff8fe7645f R11: ffff88806b028a40 R12: 1ffff92000670f8c
R13: ffffffff92f07180 R14: ffff88801e794b30 R15: ffff88806b03fa18
 task_rq_unlock kernel/sched/sched.h:1689 [inline]
 wake_up_new_task+0x7b5/0xd30 kernel/sched/core.c:4703
 kernel_clone+0x5fd/0x980 kernel/fork.c:2811
 __do_sys_clone+0xba/0x100 kernel/fork.c:2923
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f95101586a3
Code: 1f 84 00 00 00 00 00 64 48 8b 04 25 10 00 00 00 45 31 c0 31 d2 31 f6 bf 11 00 20 01 4c 8d 90 d0 02 00 00 b8 38 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 35 89 c2 85 c0 75 2c 64 48 8b 04 25 10 00 00
RSP: 002b:00007fff6f7d9978 EFLAGS: 00000246 ORIG_RAX: 0000000000000038
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f95101586a3
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000001200011
RBP: 0000000000000001 R08: 0000000000000000 R09: 0079746972756365
R10: 000055557f8c1690 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f95101dab60 R14: 00007f95101dcd20 R15: 00007fff6f7d9ad0
 </TASK>
----------------
Code disassembly (best guess):
   0:	f5                   	cmc
   1:	53                   	push   %rbx
   2:	48 8b 74 24 10       	mov    0x10(%rsp),%rsi
   7:	48 89 fb             	mov    %rdi,%rbx
   a:	48 83 c7 18          	add    $0x18,%rdi
   e:	e8 36 9d 75 f6       	call   0xf6759d49
  13:	48 89 df             	mov    %rbx,%rdi
  16:	e8 4e 1a 76 f6       	call   0xf6761a69
  1b:	f7 c5 00 02 00 00    	test   $0x200,%ebp
  21:	75 23                	jne    0x46
  23:	9c                   	pushf
  24:	58                   	pop    %rax
  25:	f6 c4 02             	test   $0x2,%ah
  28:	75 37                	jne    0x61
* 2a:	bf 01 00 00 00       	mov    $0x1,%edi <-- trapping instruction
  2f:	e8 a5 90 67 f6       	call   0xf66790d9
  34:	65 8b 05 e6 50 11 75 	mov    %gs:0x751150e6(%rip),%eax        # 0x75115121
  3b:	85 c0                	test   %eax,%eax
  3d:	74 16                	je     0x55
  3f:	5b                   	pop    %rbx


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.


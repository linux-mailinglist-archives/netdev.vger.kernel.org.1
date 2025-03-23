Return-Path: <netdev+bounces-176956-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E885A6CEB5
	for <lists+netdev@lfdr.de>; Sun, 23 Mar 2025 11:30:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4EA916EE4C
	for <lists+netdev@lfdr.de>; Sun, 23 Mar 2025 10:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E016203706;
	Sun, 23 Mar 2025 10:30:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E6120126A
	for <netdev@vger.kernel.org>; Sun, 23 Mar 2025 10:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742725824; cv=none; b=E/C1/1nBDnTdLVgfqay1jweUepTwemOJmS3gNo7jUeZmglW97VbMkKIZ42kPwnRuG5K8hi5c3Sh6ebXXVsolgSTjXWJwA+5clRb7b3yX4Pjw4QKB8/Ydj0fmqv1klYAT7YEkE8hWMgIaV+qzVwGz7PMgQ3PFn/oAjzich7vF7es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742725824; c=relaxed/simple;
	bh=SL/QAzMewb/5aszLosVASxPmtebjdomFu2F0q+5QJFk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=hv4+OkLaQSS+GpvjXb+0qVGxKIIsTU5pgs+WKxP/Ml7okdpd1i9VM/btcGlFWI+ACQT9fE81SGajmLf3w3N5RFe3cgNqwKW883bwZIq6dPt+C7xIaFQND7mBhRsEUKr5JCEZFelpzbhTyfX9U0o/4bSHPnRrzo3z69l6Uu5ZRek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3d43c0dbe6aso70862545ab.1
        for <netdev@vger.kernel.org>; Sun, 23 Mar 2025 03:30:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742725821; x=1743330621;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x7ISn9C8+RaOU31ddJUdLDJipbozhjaswG/akP4U/us=;
        b=NzeQCpzNDUocsJizaSveX91KmIaoc7DXZ/LMvKh9XxfLAMO30ao3CNt1sXf46XSlJH
         F8vHa4LMESx7uRFglTGKG3xeU4P1YTAuRN1cptwHhy8drlZ23zfx1v3nzDNLyGfAzYmp
         VGgHZeNpKt6YUd48Pp2D00GtOEq6ih7Rhzgde23nlplhBjW2VUwgzKECqI5kwZv8MDCW
         tgZoMaZu7m+UsHhj5BRafkwxYi3RbcOljnk338ZFlzMVx+iHSW1vKEYcndOxB7X6f6kD
         0DU/cLb3SOk/KBQOSZec1AIY3YyCiArzNuXcLylU78FcopbUOLZ48PThy9b0dzdn2bxr
         gnNA==
X-Forwarded-Encrypted: i=1; AJvYcCXjUu02x6ID/6SGLX3qjeUWKJBLRRx3diC87aFI7mfJLryZBDgObQ2uue1ZkssEKCSGFadEqeE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJrQPkynkWS98nSgrFN/Kb6hYhu6aPlZxTzb7vlmF7x9XTaN7Y
	SS9fwyivsFO8KcusXMfKzjWk1aMVmACtlpNAhZW1iExQUNVltbWYenODFjFtVaXar2yfRS0LQU2
	pWVwzT+8ix45UyrbVbuL+FOi8WcXe5iuTGOdZIQRqa+GhEJsk1ChIv5U=
X-Google-Smtp-Source: AGHT+IGcFKFc84GZpTeomD+z5vKzAwbHMWqbkECjs6nIinwQR1VHqlUlwGvvBO0aRgziPVuJZFEKhyTGOavxAFq78ZhMspdjwpDk
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3e03:b0:3d0:239a:c46a with SMTP id
 e9e14a558f8ab-3d596114994mr104213735ab.9.1742725821707; Sun, 23 Mar 2025
 03:30:21 -0700 (PDT)
Date: Sun, 23 Mar 2025 03:30:21 -0700
In-Reply-To: <67506743.050a0220.17bd51.006e.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67dfe2bd.050a0220.31a16b.005c.GAE@google.com>
Subject: Re: [syzbot] [net?] BUG: unable to handle kernel paging request in
 dst_dev_put (2)
From: syzbot <syzbot+9911f8283beca191268b@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    183601b78a9b Merge tag 'perf-urgent-2025-03-22' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13b9443f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=27515cfdbafbb90d
dashboard link: https://syzkaller.appspot.com/bug?extid=9911f8283beca191268b
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=129cdc4c580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-183601b7.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/517fad16d32e/vmlinux-183601b7.xz
kernel image: https://storage.googleapis.com/syzbot-assets/1fbe51b195ec/bzImage-183601b7.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/5475b0a1ea33/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9911f8283beca191268b@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 0 UID: 0 PID: 5660 Comm: rm Not tainted 6.14.0-rc7-syzkaller-00202-g183601b78a9b #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:dst_dev_put+0x27/0x290 net/core/dst.c:146
Code: 90 90 90 f3 0f 1e fa 55 41 57 41 56 41 55 41 54 53 49 89 fd 49 bf 00 00 00 00 00 fc ff df e8 50 9f f2 f7 4d 89 ec 49 c1 ec 03 <43> 80 3c 3c 00 74 08 4c 89 ef e8 ca de 59 f8 4d 8b 75 00 49 8d 7d
RSP: 0018:ffffc90000007b30 EFLAGS: 00010246
RAX: ffffffff89cf4080 RBX: 0000000000000001 RCX: ffff8880348bc880
RDX: 0000000000000100 RSI: 0000000000000008 RDI: 0000000000000001
RBP: ffff88801fc00000 R08: ffffe8ffffc8df1f R09: 1ffffd1ffff91be3
R10: dffffc0000000000 R11: fffff91ffff91be4 R12: 0000000000000000
R13: 0000000000000001 R14: ffff888012569510 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f478d4afd11 CR3: 0000000058e7a000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 fib6_nh_release_dsts net/ipv6/route.c:3690 [inline]
 fib6_nh_release+0x355/0x420 net/ipv6/route.c:3671
 fib6_info_destroy_rcu+0xc0/0x1b0 net/ipv6/ip6_fib.c:177
 rcu_do_batch kernel/rcu/tree.c:2546 [inline]
 rcu_core+0xaaa/0x17a0 kernel/rcu/tree.c:2802
 handle_softirqs+0x2d4/0x9b0 kernel/softirq.c:561
 __do_softirq kernel/softirq.c:595 [inline]
 invoke_softirq kernel/softirq.c:435 [inline]
 __irq_exit_rcu+0xf7/0x220 kernel/softirq.c:662
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:678
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1049 [inline]
 sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1049
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:__raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:152 [inline]
RIP: 0010:_raw_spin_unlock_irqrestore+0xd8/0x140 kernel/locking/spinlock.c:194
Code: 9c 8f 44 24 20 42 80 3c 23 00 74 08 4c 89 f7 e8 9e 58 1d f6 f6 44 24 21 02 75 52 41 f7 c7 00 02 00 00 74 01 fb bf 01 00 00 00 <e8> b3 bc 83 f5 65 8b 05 a4 0f f8 73 85 c0 74 43 48 c7 04 24 0e 36
RSP: 0018:ffffc9000cd2f680 EFLAGS: 00000206
RAX: 74f1bd27331e4e00 RBX: 1ffff920019a5ed4 RCX: ffffffff9a654903
RDX: dffffc0000000000 RSI: ffffffff8c2ab3a0 RDI: 0000000000000001
RBP: ffffc9000cd2f710 R08: ffffffff903cfb77 R09: 1ffffffff2079f6e
R10: dffffc0000000000 R11: fffffbfff2079f6f R12: dffffc0000000000
R13: 1ffff920019a5ed0 R14: ffffc9000cd2f6a0 R15: 0000000000000246
 __debug_check_no_obj_freed lib/debugobjects.c:1108 [inline]
 debug_check_no_obj_freed+0x561/0x580 lib/debugobjects.c:1129
 slab_free_hook mm/slub.c:2284 [inline]
 slab_free mm/slub.c:4609 [inline]
 kmem_cache_free+0x114/0x410 mm/slub.c:4711
 file_free+0x24/0x200 fs/file_table.c:68
 path_openat+0x2edd/0x3590 fs/namei.c:3998
 do_filp_open+0x27f/0x4e0 fs/namei.c:4016
 do_sys_openat2+0x13e/0x1d0 fs/open.c:1428
 do_sys_open fs/open.c:1443 [inline]
 __do_sys_openat fs/open.c:1459 [inline]
 __se_sys_openat fs/open.c:1454 [inline]
 __x64_sys_openat+0x247/0x2a0 fs/open.c:1454
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f478d4c8a46
Code: 10 00 00 00 44 8b 54 24 e0 48 89 44 24 c0 48 8d 44 24 d0 48 89 44 24 c8 44 89 c2 4c 89 ce bf 9c ff ff ff b8 01 01 00 00 0f 05 <48> 3d 00 f0 ff ff 76 0c f7 d8 89 05 0a 48 01 00 48 83 c8 ff c3 31
RSP: 002b:00007ffd8b657538 EFLAGS: 00000287 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00007ffd8b6577a8 RCX: 00007f478d4c8a46
RDX: 0000000000080000 RSI: 00007ffd8b6575b0 RDI: 00000000ffffff9c
RBP: 00007ffd8b6575a0 R08: 0000000000080000 R09: 00007ffd8b6575b0
R10: 0000000000000000 R11: 0000000000000287 R12: 00007ffd8b6575b0
R13: 0000000000000003 R14: 00007ffd8b65778f R15: 00000000ffffffff
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:dst_dev_put+0x27/0x290 net/core/dst.c:146
Code: 90 90 90 f3 0f 1e fa 55 41 57 41 56 41 55 41 54 53 49 89 fd 49 bf 00 00 00 00 00 fc ff df e8 50 9f f2 f7 4d 89 ec 49 c1 ec 03 <43> 80 3c 3c 00 74 08 4c 89 ef e8 ca de 59 f8 4d 8b 75 00 49 8d 7d
RSP: 0018:ffffc90000007b30 EFLAGS: 00010246
RAX: ffffffff89cf4080 RBX: 0000000000000001 RCX: ffff8880348bc880
RDX: 0000000000000100 RSI: 0000000000000008 RDI: 0000000000000001
RBP: ffff88801fc00000 R08: ffffe8ffffc8df1f R09: 1ffffd1ffff91be3
R10: dffffc0000000000 R11: fffff91ffff91be4 R12: 0000000000000000
R13: 0000000000000001 R14: ffff888012569510 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f478d4afd11 CR3: 0000000058e7a000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	90                   	nop
   1:	90                   	nop
   2:	90                   	nop
   3:	f3 0f 1e fa          	endbr64
   7:	55                   	push   %rbp
   8:	41 57                	push   %r15
   a:	41 56                	push   %r14
   c:	41 55                	push   %r13
   e:	41 54                	push   %r12
  10:	53                   	push   %rbx
  11:	49 89 fd             	mov    %rdi,%r13
  14:	49 bf 00 00 00 00 00 	movabs $0xdffffc0000000000,%r15
  1b:	fc ff df
  1e:	e8 50 9f f2 f7       	call   0xf7f29f73
  23:	4d 89 ec             	mov    %r13,%r12
  26:	49 c1 ec 03          	shr    $0x3,%r12
* 2a:	43 80 3c 3c 00       	cmpb   $0x0,(%r12,%r15,1) <-- trapping instruction
  2f:	74 08                	je     0x39
  31:	4c 89 ef             	mov    %r13,%rdi
  34:	e8 ca de 59 f8       	call   0xf859df03
  39:	4d 8b 75 00          	mov    0x0(%r13),%r14
  3d:	49                   	rex.WB
  3e:	8d                   	.byte 0x8d
  3f:	7d                   	.byte 0x7d


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.


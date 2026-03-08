Return-Path: <netdev+bounces-265226-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yPC7Id8BrWlZxAEAu9opvQ
	(envelope-from <netdev+bounces-265226-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 08 Mar 2026 05:58:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E126222E89F
	for <lists+netdev@lfdr.de>; Sun, 08 Mar 2026 05:58:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EB04B3002777
	for <lists+netdev@lfdr.de>; Sun,  8 Mar 2026 04:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1063A3126AD;
	Sun,  8 Mar 2026 04:57:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com [209.85.161.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605C714A60F
	for <netdev@vger.kernel.org>; Sun,  8 Mar 2026 04:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772945849; cv=none; b=G9DnnwvbEylP31nZBVxA3U2kD23phxB7IY7bhLhgsSAP4qwbiKW42SizUnT9hDK+D7jUjV9ZpPVvpTE9wf9Sf77fjqAiZx1rnZ6Qylm1LlnTYyf503UawIbPsesOqgpJPp2ERkTMBfHPoiu5d/yBL08NajEvsar7Na3xO9MMGmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772945849; c=relaxed/simple;
	bh=DgNxDp0TxbVg1IXdBMDmxC9tk2POAZad5qjo2IO9iIk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=oIPZJ4lUEOUBP+QXZ/mJSHAst9BQwBa+sUEAkT/7xP5BW6Z4Ash1WYGPeHmC1aXSTLbp/g0cHfm9+iucGtR3RsLM2d1Qvdn8JGfsPP1cbPbZgDL5JeM/9yVD+FXOXfGNFC0HVphcGghBqzfNHB5dK34jtyvvaFfag2bnSKHx4nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-67999893008so83415973eaf.2
        for <netdev@vger.kernel.org>; Sat, 07 Mar 2026 20:57:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772945846; x=1773550646;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xelLlylSbDuOPJhWD2A8X+kTpGxL0OYG0tvtOASW9SY=;
        b=nisB9f3i4b1qW3e0EpoauWZgweGnsgxeukumW4jJraoVM3ETDPbwc6O1OCALZw3PIv
         ztGIkWXMr/nQK9l2q7oBy0+nULn1V5rnWctfaNh1tWG/wHII47I1Fjd/eMY+fnVlzZS/
         rOwPOO7UUsEJbA46kW3D0wdUFhTR6fjK5oopXhOMgVEeCSSg12YIUX3r11Gc4A+NfEs1
         H+YNujPqcM+aARe6YFz0veVlQ7M4KHW3maxyY5w3WwPKNUuFc5EpJp2lNhr3jMDV982v
         LCHst/mjJy4sBvWovuTG5hpSUOeHO4/Zf6ujTqbe953qEAT+G6vjbHntk+8gLCuPJmGT
         e3RQ==
X-Forwarded-Encrypted: i=1; AJvYcCWBK5eI/y+AOXipPdOUSfpJHgJBbi+1zP/r9nR1Oihi4+paX8x7ZaeQDCrwlbzmC7GIBsQCjRM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaMGaUk07QAe3x+i5FoIgYVr7BlkZ9zunIs2NvytjeGx/lMe/E
	oy4Sbhrnvfc2QajGVTbFPWwy5JyEVclOBgyBjyeCcfHgb+2W3kYwFjA3AUJ3yFE4BWbnh/JKZnt
	m4xGF6ubAj0qOfrM8VzZi5cYXEvyeZ+gfc73WcMEihLHyDd55Bwoun/4xygA=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:6ac8:b0:663:9b9:9297 with SMTP id
 006d021491bc7-67b9bd493e7mr4853501eaf.64.1772945846349; Sat, 07 Mar 2026
 20:57:26 -0800 (PST)
Date: Sat, 07 Mar 2026 20:57:26 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69ad01b6.050a0220.310d8.0006.GAE@google.com>
Subject: [syzbot] [net?] [virt?] BUG: soft lockup in perf_event_open (2)
From: syzbot <syzbot+e04801269a8f6321dd79@syzkaller.appspotmail.com>
To: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	eperezma@redhat.com, jasowang@redhat.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com, 
	virtualization@lists.linux.dev, xuanzhuo@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: E126222E89F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=e3161cabe5a361ff];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-265226-lists,netdev=lfdr.de,e04801269a8f6321dd79];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[storage.googleapis.com:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,googlegroups.com:email,goo.gl:url];
	RCPT_COUNT_TWELVE(0.00)[13];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.976];
	REDIRECTOR_URL(0.00)[goo.gl];
	TAGGED_RCPT(0.00)[netdev];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Action: no action

Hello,

syzbot found the following issue on:

HEAD commit:    63804fed149a Linux 6.19-rc7
git tree:       bpf
console output: https://syzkaller.appspot.com/x/log.txt?x=11a9a6ef980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e3161cabe5a361ff
dashboard link: https://syzkaller.appspot.com/bug?extid=e04801269a8f6321dd79
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/41d6b98867a6/disk-63804fed.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d5f2b92823d3/vmlinux-63804fed.xz
kernel image: https://storage.googleapis.com/syzbot-assets/05507a73fb04/bzImage-63804fed.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e04801269a8f6321dd79@syzkaller.appspotmail.com

watchdog: BUG: soft lockup - CPU#1 stuck for 144s! [syz.2.407:7202]
Modules linked in:
irq event stamp: 11017141
hardirqs last  enabled at (11017140): [<ffffffff8b96fbbc>] irqentry_exit+0x59c/0x620 kernel/entry/common.c:219
hardirqs last disabled at (11017141): [<ffffffff8b96e5ce>] sysvec_apic_timer_interrupt+0xe/0xc0 arch/x86/kernel/apic/apic.c:1056
softirqs last  enabled at (1158618): [<ffffffff8186fcaf>] __do_softirq kernel/softirq.c:656 [inline]
softirqs last  enabled at (1158618): [<ffffffff8186fcaf>] invoke_softirq kernel/softirq.c:496 [inline]
softirqs last  enabled at (1158618): [<ffffffff8186fcaf>] __irq_exit_rcu+0x5f/0x150 kernel/softirq.c:723
softirqs last disabled at (1158621): [<ffffffff8186fcaf>] __do_softirq kernel/softirq.c:656 [inline]
softirqs last disabled at (1158621): [<ffffffff8186fcaf>] invoke_softirq kernel/softirq.c:496 [inline]
softirqs last disabled at (1158621): [<ffffffff8186fcaf>] __irq_exit_rcu+0x5f/0x150 kernel/softirq.c:723
CPU: 1 UID: 0 PID: 7202 Comm: syz.2.407 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/13/2026
RIP: 0010:orc_ip arch/x86/kernel/unwind_orc.c:81 [inline]
RIP: 0010:__orc_find arch/x86/kernel/unwind_orc.c:103 [inline]
RIP: 0010:orc_find arch/x86/kernel/unwind_orc.c:238 [inline]
RIP: 0010:unwind_next_frame+0x513/0x23c0 arch/x86/kernel/unwind_orc.c:510
Code: c1 e8 3f 48 01 c8 48 83 e0 fe 4c 8d 3c 45 00 00 00 00 49 01 ef 4c 89 f8 48 c1 e8 03 48 b9 00 00 00 00 00 fc ff df 0f b6 04 08 <84> c0 75 27 49 63 07 4c 01 f8 49 8d 4f 04 4c 39 e0 48 0f 46 e9 49
RSP: 0018:ffffc90000a08298 EFLAGS: 00000a07
RAX: 0000000000000000 RBX: ffffffff90105e04 RCX: dffffc0000000000
RDX: ffffffff90105db8 RSI: ffffffff909037ee RDI: ffffffff8c073920
RBP: ffffffff90105db8 R08: 0000000000000014 R09: ffffffff8e55a360
R10: ffffc90000a08040 R11: ffffffff81afb170 R12: ffffffff822c920b
R13: ffffffff90105db8 R14: ffffc90000a08368 R15: ffffffff90105ddc
FS:  00007f5675fa96c0(0000) GS:ffff8881257f5000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f04877456b8 CR3: 00000000758f6000 CR4: 00000000003526f0
Call Trace:
 <IRQ>
 arch_stack_walk+0x11b/0x150 arch/x86/kernel/stacktrace.c:25
 stack_trace_save+0xa9/0x100 kernel/stacktrace.c:122
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 unpoison_slab_object mm/kasan/common.c:340 [inline]
 __kasan_slab_alloc+0x6c/0x80 mm/kasan/common.c:366
 kasan_slab_alloc include/linux/kasan.h:253 [inline]
 slab_post_alloc_hook mm/slub.c:4953 [inline]
 kmem_cache_alloc_bulk_noprof+0x48c/0x740 mm/slub.c:7525
 napi_skb_cache_get+0x41e/0x780 net/core/skbuff.c:291
 __alloc_skb+0x152/0x390 net/core/skbuff.c:668
 napi_alloc_skb+0x84/0x7c0 net/core/skbuff.c:832
 page_to_skb+0x2ce/0x870 drivers/net/virtio_net.c:887
 receive_mergeable drivers/net/virtio_net.c:2497 [inline]
 receive_buf+0x546/0x1900 drivers/net/virtio_net.c:2643
 virtnet_receive_packets drivers/net/virtio_net.c:2970 [inline]
 virtnet_receive drivers/net/virtio_net.c:2994 [inline]
 virtnet_poll+0x21f0/0x2fe0 drivers/net/virtio_net.c:3083
 __napi_poll+0xae/0x340 net/core/dev.c:7681
 napi_poll net/core/dev.c:7744 [inline]
 net_rx_action+0x627/0xf70 net/core/dev.c:7896
 handle_softirqs+0x22a/0x7c0 kernel/softirq.c:622
 __do_softirq kernel/softirq.c:656 [inline]
 invoke_softirq kernel/softirq.c:496 [inline]
 __irq_exit_rcu+0x5f/0x150 kernel/softirq.c:723
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:739
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1056 [inline]
 sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1056
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:697
RIP: 0010:preempt_schedule_irq+0x48/0xa0 kernel/sched/core.c:7194
Code: 49 be 00 00 00 00 00 fc ff df eb 09 48 f7 03 10 00 00 00 74 53 bf 01 00 00 00 e8 b3 9c fa f5 e8 ae 30 34 f6 fb bf 01 00 00 00 <e8> 43 a9 ff ff 9c 58 fa a9 00 02 00 00 74 05 e8 34 32 34 f6 bf 01
RSP: 0018:ffffc90004b8f530 EFLAGS: 00000202
RAX: 0000000000007025 RBX: 0000000000000000 RCX: 0000000000000001
RDX: 0000000000000007 RSI: ffffffff8dcc9112 RDI: 0000000000000001
RBP: 0000000000000000 R08: ffffffff8fef1a77 R09: 1ffffffff1fde34e
R10: dffffc0000000000 R11: fffffbfff1fde34f R12: 0000000000000000
R13: 0000000000000000 R14: dffffc0000000000 R15: 0000000000000000
 irqentry_exit+0x597/0x620 kernel/entry/common.c:216
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:697
RIP: 0010:orc_find arch/x86/kernel/unwind_orc.c:229 [inline]
RIP: 0010:unwind_next_frame+0x223/0x23c0 arch/x86/kernel/unwind_orc.c:510
Code: 86 78 04 00 00 44 89 f8 4c 8d 2c 85 8c eb 2d 91 4c 89 e8 48 c1 e8 03 0f b6 04 28 84 c0 48 89 eb 0f 85 25 1c 00 00 45 8b 6d 00 <44> 89 f8 ff c0 48 8d 2c 85 8c eb 2d 91 48 89 e8 48 c1 e8 03 0f b6
RSP: 0018:ffffc90004b8f658 EFLAGS: 00000246
RAX: 0000000000000000 RBX: dffffc0000000000 RCX: 0000000080000000
RDX: 00000000000a9ab5 RSI: ffffffff8c073960 RDI: ffffffff8c073920
RBP: dffffc0000000000 R08: ffffffff81759195 R09: ffffffff8e55a360
R10: ffffc90004b8f400 R11: ffffffff81afb170 R12: ffffffff81f6b0e8
R13: 0000000000032842 R14: ffffc90004b8f728 R15: 000000000000f6b0
 arch_stack_walk+0x11b/0x150 arch/x86/kernel/stacktrace.c:25
 stack_trace_save+0xa9/0x100 kernel/stacktrace.c:122
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 unpoison_slab_object mm/kasan/common.c:340 [inline]
 __kasan_slab_alloc+0x6c/0x80 mm/kasan/common.c:366
 kasan_slab_alloc include/linux/kasan.h:253 [inline]
 slab_post_alloc_hook mm/slub.c:4953 [inline]
 slab_alloc_node mm/slub.c:5263 [inline]
 kmem_cache_alloc_node_noprof+0x427/0x6f0 mm/slub.c:5315
 perf_event_alloc+0x1cb/0x2e40 kernel/events/core.c:12960
 __do_sys_perf_event_open kernel/events/core.c:13590 [inline]
 __se_sys_perf_event_open+0x7a9/0x1d60 kernel/events/core.c:13471
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xe2/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f567519aeb9
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f5675fa9028 EFLAGS: 00000246 ORIG_RAX: 000000000000012a
RAX: ffffffffffffffda RBX: 00007f5675415fa0 RCX: 00007f567519aeb9
RDX: ffffffffffffffff RSI: 0000000000000000 RDI: 0000200000000440
RBP: 00007f5675208c1f R08: 0000000000000002 R09: 0000000000000000
R10: ffffffffffffffff R11: 0000000000000246 R12: 0000000000000000
R13: 00007f5675416038 R14: 00007f5675415fa0 R15: 00007ffda8335dc8
 </TASK>
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 18 Comm: rcu_exp_gp_kthr Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/13/2026
RIP: 0010:kasan_check_range+0x5/0x2c0 mm/kasan/generic.c:199
Code: 48 c7 c6 a5 56 f3 8d e8 49 64 fb fe 90 0f 0b cc cc cc cc cc cc 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f 40 d6 55 <41> 57 41 56 41 55 41 54 53 b0 01 48 85 f6 0f 84 ae 01 00 00 4c 8d
RSP: 0018:ffffc90000007a28 EFLAGS: 00000002
RAX: 0000000000000001 RBX: 000000000000000d RCX: ffffffff819f9e7b
RDX: 0000000000000001 RSI: 000000000000000d RDI: ffffe8ffffcc4018
RBP: ffffc90000007b60 R08: 0000000000000004 R09: 0000000000000006
R10: dffffc0000000000 R11: fffffbfff175bf69 R12: ffffffff819f9e7b
R13: 000000000000000e R14: ffffffff8badfb40 R15: ffffe8ffffcc4018
FS:  0000000000000000(0000) GS:ffff8881256f5000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000200000051000 CR3: 00000000688bc000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000600
Call Trace:
 <IRQ>
 __asan_memcpy+0x40/0x70 mm/kasan/shadow.c:106
 do_perf_trace_lock include/trace/events/lock.h:50 [inline]
 perf_trace_lock+0x2ab/0x3f0 include/trace/events/lock.h:50
 __do_trace_lock_release include/trace/events/lock.h:69 [inline]
 trace_lock_release include/trace/events/lock.h:69 [inline]
 lock_release+0x379/0x3a0 kernel/locking/lockdep.c:5879
 rcu_lock_release include/linux/rcupdate.h:341 [inline]
 rcu_read_unlock include/linux/rcupdate.h:897 [inline]
 select_task_rq_fair+0x2b53/0x43f0 kernel/sched/fair.c:8583
 select_task_rq kernel/sched/core.c:3497 [inline]
 try_to_wake_up+0x4d7/0x1380 kernel/sched/core.c:4206
 hrtimer_wakeup+0x4e/0x60 kernel/time/hrtimer.c:2013
 __run_hrtimer kernel/time/hrtimer.c:1777 [inline]
 __hrtimer_run_queues+0x527/0xc30 kernel/time/hrtimer.c:1841
 hrtimer_interrupt+0x42b/0x1010 kernel/time/hrtimer.c:1903
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1045 [inline]
 __sysvec_apic_timer_interrupt+0x102/0x3d0 arch/x86/kernel/apic/apic.c:1062
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1056 [inline]
 sysvec_apic_timer_interrupt+0xa1/0xc0 arch/x86/kernel/apic/apic.c:1056
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:697
RIP: 0010:console_trylock_spinning kernel/printk/printk.c:2037 [inline]
RIP: 0010:vprintk_emit+0x45d/0x560 kernel/printk/printk.c:2425
Code: 0f 84 44 ff ff ff e8 e2 45 21 00 fb eb 44 e8 da 45 21 00 e8 a5 bd f3 09 4d 85 f6 74 94 e8 cb 45 21 00 fb 48 c7 c7 60 c7 54 8e <31> f6 ba 01 00 00 00 31 c9 41 b8 01 00 00 00 45 31 c9 53 e8 3b 1b
RSP: 0018:ffffc90000177940 EFLAGS: 00000293
RAX: ffffffff81a33185 RBX: ffffffff81a32fff RCX: ffff88801cef1e80
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffff8e54c760
RBP: ffffc900001779f0 R08: ffffffff8fef1a77 R09: 1ffffffff1fde34e
R10: dffffc0000000000 R11: fffffbfff1fde34f R12: 0000000000000000
R13: 0000000000000041 R14: 0000000000000200 R15: 1ffff9200002ef2c
 _printk+0xdd/0x130 kernel/printk/printk.c:2451
 synchronize_rcu_expedited_stall+0x5f/0x1170 kernel/rcu/tree_exp.h:570
 synchronize_rcu_expedited_wait kernel/rcu/tree_exp.h:668 [inline]
 rcu_exp_wait_wake kernel/rcu/tree_exp.h:687 [inline]
 rcu_exp_sel_wait_wake+0x897/0xe50 kernel/rcu/tree_exp.h:721
 kthread_worker_fn+0x4ee/0xb00 kernel/kthread.c:1005
 kthread+0x726/0x8b0 kernel/kthread.c:463
 ret_from_fork+0x51b/0xa40 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246
 </TASK>


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


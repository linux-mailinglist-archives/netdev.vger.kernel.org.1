Return-Path: <netdev+bounces-232949-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95557C0A19F
	for <lists+netdev@lfdr.de>; Sun, 26 Oct 2025 02:24:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42023189CC04
	for <lists+netdev@lfdr.de>; Sun, 26 Oct 2025 01:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7030F218EB1;
	Sun, 26 Oct 2025 01:24:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34951DFE09
	for <netdev@vger.kernel.org>; Sun, 26 Oct 2025 01:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761441870; cv=none; b=YsILkzflzDdXff5QRvVmSFR+Nfi37C7QyDXfJmW6sJ0PwE/+Nidy3HHr3+2maGpNb031JgRLvqYHLt54gDY8HTg2TNAciwivkwK52WU7GNVK7FxjVzY20ug/sP/i22+6S1kGGQVtXjAu7amGZUNsct/1ZEMhylHtrq97r8lYPpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761441870; c=relaxed/simple;
	bh=l0JdNPqHtNnrtLkYZB+eo4oUa2joCj3aDCuMLOthpJY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=r9Jv9p+sG9jDXc8mwxGSd2TLmUM180LuyLe7xO/GCLst5GtQ4Wd0K9aH6z/tR9rY6SXLVU7QsJbOA2I14T7unmomGUbvFQVuj2vEBA80t+j59/BvvQdmrvjlwUZ8xdPeMrtjCSlEWqAQXIdsD+GV6p60T84O7HU3u0A8zpdXLAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-93e4da7a183so311966639f.1
        for <netdev@vger.kernel.org>; Sat, 25 Oct 2025 18:24:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761441868; x=1762046668;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qTX9+EdpFpLtSXhB4ZvAE4+fL3brlhMvQ74K6KoDcKA=;
        b=OFpgg0DPC5RwKDT49DAa+yfWj+vqQDihdf5Y4vKej+IcWrI/MCLOPQGDuJSSAxHKun
         0ANrOxa1UEUhNuKzvZa9KmKYOomqKC3W06jFjAvUdy73QOrWrSTlKftdkVqxIAH47Ihv
         Eq/5X+dIXfGJHFravnGfL+B+PAj4SjJ5kbLy0I5pEktb5B7Boscp27sCf4zagqpWd3WM
         sQhLtt1/F4NyDZucMUlCMQ2AQHeA4ODtBDA7kc/xM9Y1M9AfA/tQOGRGwtxk1kf/Fg0t
         0LsL6UHU5owvPC5DuWDWmmLma0/z7otYYhkC/zISIpXdGWcocofqVWg1zf6sfI2WgSjt
         9I6w==
X-Forwarded-Encrypted: i=1; AJvYcCWFb/NThKV9+S74uouefYfXRJr6tuWkwbg7+6Mctn7PKrrP/So56doZn0A3Gz34lYp4OX/410Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwN2uwl2rH7sj/LhqjZoOkSUDuCWMaQM4p/lLYFG9Rx7iFwbcgn
	aPM/l4bu9mUWE4ufyvo5MCF5V+f6ngqbSgJQ74s5oZGsK3NfAwsIrlbEzo6QbVSVYRKlbWkPbaq
	BgLpLCdR21r66RdEagwErEYX8ib90U9QNGDtTgBWjEKsjxLbBHnp8sRaVNwI=
X-Google-Smtp-Source: AGHT+IEBLmQFMFbIp1naKVdNeG0tFdWjhLvNShExU/ttbEbiFSP9c3PU+NBMnRr/rltF6wF0EuwzCvMOInhHK2zsxqIcR75Gx0y5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3e04:b0:425:8744:de7d with SMTP id
 e9e14a558f8ab-430c5292336mr442014515ab.30.1761441867931; Sat, 25 Oct 2025
 18:24:27 -0700 (PDT)
Date: Sat, 25 Oct 2025 18:24:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68fd784b.a70a0220.5b2ed.0002.GAE@google.com>
Subject: [syzbot] [net?] [virt?] BUG: sleeping function called from invalid
 context in get_random_u8
From: syzbot <syzbot+705049704a8f04f9ed46@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, sgarzare@redhat.com, syzkaller-bugs@googlegroups.com, 
	virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    6548d364a3e8 Merge tag 'cgroup-for-6.18-rc2-fixes' of git:..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15ded734580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=216353986aa62c5d
dashboard link: https://syzkaller.appspot.com/bug?extid=705049704a8f04f9ed46
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d8f9e408d44f/disk-6548d364.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/70787a187f91/vmlinux-6548d364.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d0a3a98dfaf8/bzImage-6548d364.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+705049704a8f04f9ed46@syzkaller.appspotmail.com

BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:48
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 17941, name: syz.4.4549
preempt_count: 1, expected: 0
RCU nest depth: 2, expected: 2
5 locks held by syz.4.4549/17941:
 #0: ffff88803ca7a398 (sk_lock-AF_VSOCK){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1679 [inline]
 #0: ffff88803ca7a398 (sk_lock-AF_VSOCK){+.+.}-{0:0}, at: vsock_connectible_sendmsg+0x189/0x1040 net/vmw_vsock/af_vsock.c:2032
 #1: ffffffff8d7aa4c0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 #1: ffffffff8d7aa4c0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:867 [inline]
 #1: ffffffff8d7aa4c0 (rcu_read_lock){....}-{1:3}, at: __bpf_trace_run kernel/trace/bpf_trace.c:2074 [inline]
 #1: ffffffff8d7aa4c0 (rcu_read_lock){....}-{1:3}, at: bpf_trace_run9+0x1ec/0x500 kernel/trace/bpf_trace.c:2123
 #2: ffff8880b8932c88 ((stream_local_lock)){+.+.}-{3:3}, at: bpf_stream_page_local_lock kernel/bpf/stream.c:46 [inline]
 #2: ffff8880b8932c88 ((stream_local_lock)){+.+.}-{3:3}, at: bpf_stream_elem_alloc kernel/bpf/stream.c:175 [inline]
 #2: ffff8880b8932c88 ((stream_local_lock)){+.+.}-{3:3}, at: __bpf_stream_push_str+0x211/0xbe0 kernel/bpf/stream.c:190
 #3: ffffffff8d7aa4c0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 #3: ffffffff8d7aa4c0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:867 [inline]
 #3: ffffffff8d7aa4c0 (rcu_read_lock){....}-{1:3}, at: __rt_spin_trylock kernel/locking/spinlock_rt.c:110 [inline]
 #3: ffffffff8d7aa4c0 (rcu_read_lock){....}-{1:3}, at: rt_spin_trylock+0x10d/0x2b0 kernel/locking/spinlock_rt.c:118
 #4: ffff8880b8936348 ((batched_entropy_u8.lock)){+.+.}-{3:3}, at: spin_lock include/linux/spinlock_rt.h:44 [inline]
 #4: ffff8880b8936348 ((batched_entropy_u8.lock)){+.+.}-{3:3}, at: get_random_u8+0x1ce/0x870 drivers/char/random.c:552
Preemption disabled at:
[<0000000000000000>] 0x0
CPU: 1 UID: 0 PID: 17941 Comm: syz.4.4549 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 __might_resched+0x44b/0x5d0 kernel/sched/core.c:8927
 __rt_spin_lock kernel/locking/spinlock_rt.c:48 [inline]
 rt_spin_lock+0xc7/0x3e0 kernel/locking/spinlock_rt.c:57
 spin_lock include/linux/spinlock_rt.h:44 [inline]
 get_random_u8+0x1ce/0x870 drivers/char/random.c:552
 get_random_u32_below include/linux/random.h:78 [inline]
 kfence_guarded_alloc+0x9d/0xc70 mm/kfence/core.c:422
 __kfence_alloc+0x385/0x3b0 mm/kfence/core.c:1140
 kfence_alloc include/linux/kfence.h:129 [inline]
 slab_alloc_node mm/slub.c:5252 [inline]
 __kmalloc_cache_noprof+0x576/0x6c0 mm/slub.c:5750
 kmalloc_noprof include/linux/slab.h:957 [inline]
 add_stack_record_to_list mm/page_owner.c:172 [inline]
 inc_stack_record_count mm/page_owner.c:214 [inline]
 __set_page_owner+0x25c/0x490 mm/page_owner.c:333
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x240/0x2a0 mm/page_alloc.c:1850
 prep_new_page mm/page_alloc.c:1858 [inline]
 get_page_from_freelist+0x28c0/0x2960 mm/page_alloc.c:3884
 alloc_frozen_pages_nolock_noprof+0xbc/0x150 mm/page_alloc.c:7595
 alloc_pages_nolock_noprof+0xa/0x30 mm/page_alloc.c:7628
 bpf_stream_page_replace+0x19/0x1e0 kernel/bpf/stream.c:86
 bpf_stream_page_reserve_elem kernel/bpf/stream.c:142 [inline]
 bpf_stream_elem_alloc kernel/bpf/stream.c:177 [inline]
 __bpf_stream_push_str+0x35c/0xbe0 kernel/bpf/stream.c:190
 bpf_stream_stage_printk+0x14e/0x1c0 kernel/bpf/stream.c:448
 bpf_prog_report_may_goto_violation+0xc4/0x190 kernel/bpf/core.c:3181
 bpf_check_timed_may_goto+0xaa/0xb0 kernel/bpf/core.c:3199
 arch_bpf_timed_may_goto+0x21/0x40 arch/x86/net/bpf_timed_may_goto.S:40
 bpf_prog_262a74d054ad2993+0x53/0x5f
 bpf_dispatcher_nop_func include/linux/bpf.h:1350 [inline]
 __bpf_prog_run include/linux/filter.h:721 [inline]
 bpf_prog_run include/linux/filter.h:728 [inline]
 __bpf_trace_run kernel/trace/bpf_trace.c:2075 [inline]
 bpf_trace_run9+0x2de/0x500 kernel/trace/bpf_trace.c:2123
 __bpf_trace_virtio_transport_alloc_pkt+0x2d7/0x340 include/trace/events/vsock_virtio_transport_common.h:39
 __do_trace_virtio_transport_alloc_pkt include/trace/events/vsock_virtio_transport_common.h:39 [inline]
 trace_virtio_transport_alloc_pkt include/trace/events/vsock_virtio_transport_common.h:39 [inline]
 virtio_transport_alloc_skb+0x10cc/0x1130 net/vmw_vsock/virtio_transport_common.c:311
 virtio_transport_send_pkt_info+0x6be/0x1100 net/vmw_vsock/virtio_transport_common.c:390
 virtio_transport_stream_enqueue net/vmw_vsock/virtio_transport_common.c:1113 [inline]
 virtio_transport_seqpacket_enqueue+0x166/0x1f0 net/vmw_vsock/virtio_transport_common.c:841
 vsock_connectible_sendmsg+0xabf/0x1040 net/vmw_vsock/af_vsock.c:2136
 sock_sendmsg_nosec net/socket.c:727 [inline]
 __sock_sendmsg+0x21c/0x270 net/socket.c:742
 ____sys_sendmsg+0x534/0x820 net/socket.c:2630
 ___sys_sendmsg+0x21f/0x2a0 net/socket.c:2684
 __sys_sendmmsg+0x22d/0x430 net/socket.c:2773
 __do_sys_sendmmsg net/socket.c:2800 [inline]
 __se_sys_sendmmsg net/socket.c:2797 [inline]
 __x64_sys_sendmmsg+0xa0/0xc0 net/socket.c:2797
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f5c3d7fefc9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f5c3ba66038 EFLAGS: 00000246 ORIG_RAX: 0000000000000133
RAX: ffffffffffffffda RBX: 00007f5c3da55fa0 RCX: 00007f5c3d7fefc9
RDX: 0000000000000001 RSI: 0000200000000b40 RDI: 0000000000000004
RBP: 00007f5c3d881f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f5c3da56038 R14: 00007f5c3da55fa0 R15: 00007ffe123190c8
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


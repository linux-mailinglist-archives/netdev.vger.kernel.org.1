Return-Path: <netdev+bounces-228420-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66194BCA3A8
	for <lists+netdev@lfdr.de>; Thu, 09 Oct 2025 18:46:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A2813BE104
	for <lists+netdev@lfdr.de>; Thu,  9 Oct 2025 16:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49A7122DF9E;
	Thu,  9 Oct 2025 16:46:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A3F21CC79
	for <netdev@vger.kernel.org>; Thu,  9 Oct 2025 16:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760028390; cv=none; b=tuWUY6xhP3UV98GweLOUcwKDSBmCqyJ0DOZimXOsQVx8mSUTvvoDODD1oBzAj3aJ1VxvqDE9QDL4nyg6iH4ai98fjT1j3V7uIwrLG4bW2Ad0JHBhpSR4qhcmckspN6N59YSskr88XWkpxjyxjv8DIhuqDMvvtCPNhW59k7B08kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760028390; c=relaxed/simple;
	bh=zYS8gMhAS6+lp0wyfl9hgdEA0oN7PtJsGdynyO8/4q4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=TsHtCzxf9DLssxmpnoq84xDMO7xyaKblK2ux159A9wmKfSCRuSnRT/GGY51OSQ3MPyN3QCyZaQThi5qC6F6tdVi3Fmn2oxBLTaW2zGHnt/ZOy6UxbEAaIDUQUPd86gDUz/GSH5zAQlxJ0w9rqMOU3rBEwBYDMTNHBD5DvPz9KA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-937e5f9ea74so224422039f.1
        for <netdev@vger.kernel.org>; Thu, 09 Oct 2025 09:46:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760028387; x=1760633187;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IjQF2lqdhml5U4l6DnX76KvRk63yjk/2YqYks0Pn77w=;
        b=NqZDLGdZ71vGVdJpezBZk/3TG8Gm3QPAtvcj4UncVzaG5s2ljDIFZhy8BQz56WZPSn
         1dWTlLjJd/VQt6gepiTVJCxdfykoEqH7imwWhQUJBA346oM5t7y0jCC6RhKuFqh8PjOU
         0HK4w/BBj4ClhIezldiTQcwMNkzMgxwVvVsFUNKS+xtNRc0iUgL0EoaorPU3+zqSPeN4
         19CTDryI2hsuMUjWyVIZQwyqVIaZkcOoNZINlYdsXYOg4VlqBCsUpoTc0DT+ImUYNjCo
         uESk/10U9+1Zk6EGm2uRPLENuzD56nrdcewnvccnxuM7a1W6SPHcZfD3up8absBxZZGP
         F3+A==
X-Forwarded-Encrypted: i=1; AJvYcCVMhev8IyczbIJnsOA/tsuEb5cS7qA/+WFKZRUoqP9bIaaFSVxCECvQh3yA8vtIqxvTFT7fmAk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgLUV1UHMMstGtqaX03STxbPaT5FGnAY4tqxMOy3FHIOWdfRLg
	LR9imkqCGXAZ0FCgNd5LBtOVStZVf8KdOZiCNG9bpX5ioKZ6g8U2Yjqe4Y2d/kvDrzsEH5yCwN+
	nX78rT8heiCNjf6UZcxaZHu//tcnvDHcSyxgSo4tzKpfXh7otwK85ue3Fols=
X-Google-Smtp-Source: AGHT+IG632oO81iGcd/AGF++bfEMLZrcU0QXUA7DiaoXuktuQn/xho9ExeCMVyKNm33OVSX09A4XQ3MFgbL/ilFtY46KazqqC41+
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:29d3:b0:917:f4a5:1068 with SMTP id
 ca18e2360f4ac-93bd188e14emr919487339f.11.1760028387394; Thu, 09 Oct 2025
 09:46:27 -0700 (PDT)
Date: Thu, 09 Oct 2025 09:46:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68e7e6e3.050a0220.1186a4.0001.GAE@google.com>
Subject: [syzbot] [net?] [virt?] BUG: sleeping function called from invalid
 context in __set_page_owner
From: syzbot <syzbot+665739f456b28f32b23d@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, sgarzare@redhat.com, syzkaller-bugs@googlegroups.com, 
	virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    ec714e371f22 Merge tag 'perf-tools-for-v6.18-1-2025-10-08'..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=174a4b34580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=db9c80a8900dca57
dashboard link: https://syzkaller.appspot.com/bug?extid=665739f456b28f32b23d
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=140e0dcd980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1581452f980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/6d5cce2bcf5d/disk-ec714e37.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/60dff1e3a58f/vmlinux-ec714e37.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6a1823720b55/bzImage-ec714e37.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+665739f456b28f32b23d@syzkaller.appspotmail.com

BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:48
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 6069, name: syz.0.17
preempt_count: 1, expected: 0
RCU nest depth: 2, expected: 2
5 locks held by syz.0.17/6069:
 #0: ffff888035808350 (sk_lock-AF_VSOCK){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1679 [inline]
 #0: ffff888035808350 (sk_lock-AF_VSOCK){+.+.}-{0:0}, at: vsock_connect+0x152/0xe20 net/vmw_vsock/af_vsock.c:1546
 #1: ffffffff8d7aa500 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 #1: ffffffff8d7aa500 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:867 [inline]
 #1: ffffffff8d7aa500 (rcu_read_lock){....}-{1:3}, at: __bpf_trace_run kernel/trace/bpf_trace.c:2074 [inline]
 #1: ffffffff8d7aa500 (rcu_read_lock){....}-{1:3}, at: bpf_trace_run9+0x1ec/0x500 kernel/trace/bpf_trace.c:2123
 #2: ffff8880b8832c88 ((stream_local_lock)){+.+.}-{3:3}, at: bpf_stream_page_local_lock kernel/bpf/stream.c:46 [inline]
 #2: ffff8880b8832c88 ((stream_local_lock)){+.+.}-{3:3}, at: bpf_stream_elem_alloc kernel/bpf/stream.c:175 [inline]
 #2: ffff8880b8832c88 ((stream_local_lock)){+.+.}-{3:3}, at: __bpf_stream_push_str+0x211/0xbe0 kernel/bpf/stream.c:190
 #3: ffffffff8d7aa500 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 #3: ffffffff8d7aa500 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:867 [inline]
 #3: ffffffff8d7aa500 (rcu_read_lock){....}-{1:3}, at: __rt_spin_trylock kernel/locking/spinlock_rt.c:110 [inline]
 #3: ffffffff8d7aa500 (rcu_read_lock){....}-{1:3}, at: rt_spin_trylock+0x10d/0x2b0 kernel/locking/spinlock_rt.c:118
 #4: ffff8880b883f6e8 (&s->lock_key#5){+.+.}-{3:3}, at: spin_lock include/linux/spinlock_rt.h:44 [inline]
 #4: ffff8880b883f6e8 (&s->lock_key#5){+.+.}-{3:3}, at: ___slab_alloc+0x12f/0x1470 mm/slub.c:4492
Preemption disabled at:
[<0000000000000000>] 0x0
CPU: 0 UID: 0 PID: 6069 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 __might_resched+0x44b/0x5d0 kernel/sched/core.c:8925
 __rt_spin_lock kernel/locking/spinlock_rt.c:48 [inline]
 rt_spin_lock+0xc7/0x3e0 kernel/locking/spinlock_rt.c:57
 spin_lock include/linux/spinlock_rt.h:44 [inline]
 ___slab_alloc+0x12f/0x1470 mm/slub.c:4492
 __slab_alloc+0xc6/0x1f0 mm/slub.c:4746
 __slab_alloc_node mm/slub.c:4822 [inline]
 slab_alloc_node mm/slub.c:5233 [inline]
 __kmalloc_cache_noprof+0xec/0x6c0 mm/slub.c:5719
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
 bpf_prog_6fd842a53d323cc5+0x53/0x5f
 bpf_dispatcher_nop_func include/linux/bpf.h:1350 [inline]
 __bpf_prog_run include/linux/filter.h:721 [inline]
 bpf_prog_run include/linux/filter.h:728 [inline]
 __bpf_trace_run kernel/trace/bpf_trace.c:2075 [inline]
 bpf_trace_run9+0x2db/0x500 kernel/trace/bpf_trace.c:2123
 __bpf_trace_virtio_transport_alloc_pkt+0x2d7/0x340 include/trace/events/vsock_virtio_transport_common.h:39
 __do_trace_virtio_transport_alloc_pkt include/trace/events/vsock_virtio_transport_common.h:39 [inline]
 trace_virtio_transport_alloc_pkt include/trace/events/vsock_virtio_transport_common.h:39 [inline]
 virtio_transport_alloc_skb+0x10cc/0x1130 net/vmw_vsock/virtio_transport_common.c:311
 virtio_transport_send_pkt_info+0x6be/0x1100 net/vmw_vsock/virtio_transport_common.c:390
 virtio_transport_connect+0xa7/0x100 net/vmw_vsock/virtio_transport_common.c:1072
 vsock_connect+0xb8b/0xe20 net/vmw_vsock/af_vsock.c:1611
 __sys_connect_file net/socket.c:2102 [inline]
 __sys_connect+0x323/0x450 net/socket.c:2121
 __do_sys_connect net/socket.c:2127 [inline]
 __se_sys_connect net/socket.c:2124 [inline]
 __x64_sys_connect+0x7a/0x90 net/socket.c:2124
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f770871eec9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd178f3108 EFLAGS: 00000246 ORIG_RAX: 000000000000002a
RAX: ffffffffffffffda RBX: 00007f7708975fa0 RCX: 00007f770871eec9
RDX: 0000000000000010 RSI: 0000200000000100 RDI: 0000000000000005
RBP: 00007f77087a1f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f7708975fa0 R14: 00007f7708975fa0 R15: 0000000000000003
 </TASK>


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


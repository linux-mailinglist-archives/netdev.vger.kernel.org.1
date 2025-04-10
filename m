Return-Path: <netdev+bounces-181146-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D7DBA83DBD
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 11:03:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 912799E60F1
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 09:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F91F20C47B;
	Thu, 10 Apr 2025 08:59:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1952135A1
	for <netdev@vger.kernel.org>; Thu, 10 Apr 2025 08:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744275574; cv=none; b=fyHbQGhX6729XEcGPLUi1r5Z3Bf0ivu8NkMMxUW7lVLTouJAnTjxoFAXVaPvfZMgRxBdmV4Bdmz/iNi0Docf+11nebTFbWfgaG7TBYZykl5jT87BPe/ENDYhxTaqRa23sBtHBhxeDrWF348eOyrP/nbEhshxijHTVoudlvwhAZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744275574; c=relaxed/simple;
	bh=0b7y5iAYYN4Xo5PoKGj4h08dGwgF088PLC68yrST5YQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Bf46463B/0zAd5A5m2E7gvW/hRgERGe0L3VQhSYoV4u6zC6hibNXjxp0nzt4EQVwvNQTRuY3hjZyzs519PI8dMI+atF7soE+fLcMjZ+PEwBSk2grEK4lCP987QqMtUNohlkDF47m8EHT50zf3KUesYSCtVo8+mXHxnUpG4CE5pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3d6d6d82603so5500535ab.2
        for <netdev@vger.kernel.org>; Thu, 10 Apr 2025 01:59:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744275571; x=1744880371;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rQb81bfwdFlHjYUUvBYsb/oSQx0Gpm6aNzpKBawSPoo=;
        b=hiHu+VtiWX5o16nVmfjH/YVK6x+BJTHZja7h6QChG4Oh8vI+GPMF1Zq73IpuOzGghv
         6pzh65XJ4o+d5/nW37NUUq7QLNABhvbwo2yiHGbxzn0LfgKl9bx4uFcPeSmY8dF8BE2I
         4gK0amZURnsz3D5W7KABG9Tir1eErJZf9KTLmblreI5E3W7d1GJwcbCl7sKCkOOHctFr
         aXXs4nPAD7QMlV3rRs8fRlHMDCRlYTaRdzWDqJtTmX6mM0UGXt5nwGl5oBtdROPHGw6Q
         Sgd7+kwOg80BluQWY1CrAPptKf7aV0xuucbzj5w81IQS9pQQ14V6ewgtVgTK/3BUWccT
         x8iw==
X-Forwarded-Encrypted: i=1; AJvYcCURZ2DtTtFNCf7HeUrGZtPhORpvXYijXdYy/4RQJLC2odyxiB5oysh4oJi/iBbvzTI0lg04kjE=@vger.kernel.org
X-Gm-Message-State: AOJu0YywJ713DLIbWoqCeaJXL3+INjALlaglLHJt8+/39J/Jeri9UN+4
	FE9KH7EU6GzzdfSOGkxNK53iOogXul2YR7AXhn1si0Z6toEbzyPXw65LVRq/8iTyjUiZwVZMIAZ
	FZmbUI00JlnDBM6IxMcRlslQh4+MnZVW5C+d3k1QEvqkoFEcbIwj6QbM=
X-Google-Smtp-Source: AGHT+IEkKovLpBp/aYn+lDBjoIkSpDnhygnXj5o6TgsavNtvRRenDPU4TSCHMuP9LiPII4WCjWtwnwq9ARgaQGgc7BG+tS75ykJs
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3e8e:b0:3d3:f520:b7e0 with SMTP id
 e9e14a558f8ab-3d7e5f69f76mr10788165ab.6.1744275571474; Thu, 10 Apr 2025
 01:59:31 -0700 (PDT)
Date: Thu, 10 Apr 2025 01:59:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67f78873.050a0220.25d1c8.000f.GAE@google.com>
Subject: [syzbot] [net?] WARNING in dst_cache_per_cpu_get
From: syzbot <syzbot+ad0b3740715f38432033@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    420aabef3ab5 net: Drop unused @sk of __skb_try_recv_from_q..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=11175070580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f2054704dd53fb80
dashboard link: https://syzkaller.appspot.com/bug?extid=ad0b3740715f38432033
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/9e407e3b3a07/disk-420aabef.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/08826ad1cf0b/vmlinux-420aabef.xz
kernel image: https://storage.googleapis.com/syzbot-assets/df2ffedb4e99/bzImage-420aabef.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ad0b3740715f38432033@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 6307 at ./include/net/dst.h:238 dst_hold include/net/dst.h:238 [inline]
WARNING: CPU: 0 PID: 6307 at ./include/net/dst.h:238 dst_cache_per_cpu_get+0x29b/0x2b0 net/core/dst_cache.c:50
Modules linked in:
CPU: 0 UID: 0 PID: 6307 Comm: syz.2.120 Not tainted 6.14.0-syzkaller-13320-g420aabef3ab5 #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
RIP: 0010:dst_hold include/net/dst.h:238 [inline]
RIP: 0010:dst_cache_per_cpu_get+0x29b/0x2b0 net/core/dst_cache.c:50
Code: 26 f8 e9 a6 fe ff ff 89 d9 80 e1 07 80 c1 03 38 c1 0f 8c 05 ff ff ff 48 89 df e8 00 2b 26 f8 e9 f8 fe ff ff e8 b6 01 bc f7 90 <0f> 0b 90 e9 0c fe ff ff 66 66 66 66 2e 0f 1f 84 00 00 00 00 00 90
RSP: 0018:ffffc90000007768 EFLAGS: 00010246
RAX: ffffffff8a07558a RBX: 0000000000000001 RCX: ffff88807e56bc00
RDX: 0000000000000100 RSI: 0000000000000004 RDI: ffff888034a8b640
RBP: ffffc90000007901 R08: ffff888034a8b643 R09: 1ffff110069516c8
R10: dffffc0000000000 R11: ffffed10069516c9 R12: ffff888034a8b640
R13: ffff8881463ba418 R14: ffffe8ffffc6a688 R15: ffff888034a8b600
FS:  00007ff8159186c0(0000) GS:ffff888124f96000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f5a018df440 CR3: 000000007e9a0000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 tipc_udp_xmit+0xc2/0xc00 net/tipc/udp_media.c:178
 tipc_udp_send_msg+0x26b/0x3d0 net/tipc/udp_media.c:271
 tipc_bearer_xmit_skb+0x306/0x480 net/tipc/bearer.c:575
 tipc_disc_timeout+0x612/0x770 net/tipc/discover.c:338
 call_timer_fn+0x189/0x650 kernel/time/timer.c:1789
 expire_timers kernel/time/timer.c:1840 [inline]
 __run_timers kernel/time/timer.c:2414 [inline]
 __run_timer_base+0x66e/0x8e0 kernel/time/timer.c:2426
 run_timer_base kernel/time/timer.c:2435 [inline]
 run_timer_softirq+0xb7/0x170 kernel/time/timer.c:2445
 handle_softirqs+0x2d6/0x9b0 kernel/softirq.c:579
 __do_softirq kernel/softirq.c:613 [inline]
 invoke_softirq kernel/softirq.c:453 [inline]
 __irq_exit_rcu+0xfb/0x220 kernel/softirq.c:680
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:696
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1049 [inline]
 sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1049
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:node_to_entry lib/radix-tree.c:74 [inline]
RIP: 0010:delete_node+0x2ac/0x780 lib/radix-tree.c:552
Code: 90 48 89 ee e8 f5 68 15 f9 e9 40 fe ff ff e8 9b 1c 98 f5 40 b5 01 e9 60 04 00 00 e8 8e 1c 98 f5 4c 89 eb 40 b5 01 4c 8b 34 24 <48> 83 cb 02 4c 89 f8 48 c1 e8 03 48 89 44 24 08 42 80 3c 20 00 74
RSP: 0018:ffffc9000f12ece0 EFLAGS: 00000246
RAX: ffffffff8c2b3869 RBX: ffff8880263ef440 RCX: 0000000000080000
RDX: ffffc9000ca55000 RSI: 0000000000011a55 RDI: 0000000000011a56
RBP: 0000000000000000 R08: ffffffff8c2b3860 R09: 1ffff1100659a0f5
R10: dffffc0000000000 R11: ffffed100659a0f6 R12: dffffc0000000000
R13: ffff8880263ef440 R14: ffff88801bef7050 R15: ffff88801bef7058
 radix_tree_delete_item+0x2e6/0x3f0 lib/radix-tree.c:1430
 kernfs_put+0x172/0x460 fs/kernfs/dir.c:588
 kernfs_remove_by_name_ns+0xb5/0x130 fs/kernfs/dir.c:1715
 kernfs_remove_by_name include/linux/kernfs.h:633 [inline]
 remove_files fs/sysfs/group.c:28 [inline]
 sysfs_remove_group+0xfe/0x2c0 fs/sysfs/group.c:322
 sysfs_remove_groups+0x54/0xb0 fs/sysfs/group.c:346
 __kobject_del+0x84/0x310 lib/kobject.c:595
 kobject_del+0x45/0x60 lib/kobject.c:627
 rpc_sysfs_xprt_switch_destroy+0x59/0x90 net/sunrpc/sysfs.c:813
 xprt_switch_free net/sunrpc/xprtmultipath.c:194 [inline]
 kref_put include/linux/kref.h:65 [inline]
 xprt_switch_put+0x33f/0x3c0 net/sunrpc/xprtmultipath.c:221
 rpc_free_client net/sunrpc/clnt.c:1009 [inline]
 rpc_free_auth net/sunrpc/clnt.c:1033 [inline]
 rpc_release_client+0x370/0x6f0 net/sunrpc/clnt.c:1048
 rpc_shutdown_client+0x4b7/0x6c0 net/sunrpc/clnt.c:972
 nfsd_destroy_serv+0x1eb/0x4b0 fs/nfsd/nfssvc.c:546
 nfsd_nl_listener_set_doit+0x17c2/0x1870 fs/nfsd/nfsctl.c:2044
 genl_family_rcv_msg_doit net/netlink/genetlink.c:1115 [inline]
 genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
 genl_rcv_msg+0xb38/0xf00 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x208/0x480 net/netlink/af_netlink.c:2534
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1313 [inline]
 netlink_unicast+0x7f8/0x9a0 net/netlink/af_netlink.c:1339
 netlink_sendmsg+0x8c3/0xcd0 net/netlink/af_netlink.c:1883
 sock_sendmsg_nosec net/socket.c:712 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:727
 ____sys_sendmsg+0x523/0x860 net/socket.c:2566
 ___sys_sendmsg net/socket.c:2620 [inline]
 __sys_sendmsg+0x271/0x360 net/socket.c:2652
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ff814b8d169
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ff815918038 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007ff814da5fa0 RCX: 00007ff814b8d169
RDX: 0000000000000000 RSI: 0000200000000040 RDI: 0000000000000004
RBP: 00007ff814c0e730 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007ff814da5fa0 R15: 00007ffdb5c034e8
 </TASK>
----------------
Code disassembly (best guess):
   0:	90                   	nop
   1:	48 89 ee             	mov    %rbp,%rsi
   4:	e8 f5 68 15 f9       	call   0xf91568fe
   9:	e9 40 fe ff ff       	jmp    0xfffffe4e
   e:	e8 9b 1c 98 f5       	call   0xf5981cae
  13:	40 b5 01             	mov    $0x1,%bpl
  16:	e9 60 04 00 00       	jmp    0x47b
  1b:	e8 8e 1c 98 f5       	call   0xf5981cae
  20:	4c 89 eb             	mov    %r13,%rbx
  23:	40 b5 01             	mov    $0x1,%bpl
  26:	4c 8b 34 24          	mov    (%rsp),%r14
* 2a:	48 83 cb 02          	or     $0x2,%rbx <-- trapping instruction
  2e:	4c 89 f8             	mov    %r15,%rax
  31:	48 c1 e8 03          	shr    $0x3,%rax
  35:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
  3a:	42 80 3c 20 00       	cmpb   $0x0,(%rax,%r12,1)
  3f:	74                   	.byte 0x74


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


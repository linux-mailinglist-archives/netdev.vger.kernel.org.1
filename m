Return-Path: <netdev+bounces-203698-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77E93AF6C9A
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 10:17:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8EB11C21BAB
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 08:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B8E52C3260;
	Thu,  3 Jul 2025 08:17:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C032A22069F
	for <netdev@vger.kernel.org>; Thu,  3 Jul 2025 08:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751530646; cv=none; b=AUEBr22Q356HEd8GF2T9J5tRnvWT2o1uW6I4oTj1Ccr4xIN5hl/HodNwxDy/Y+kocqjr/fVtY5Xt7+jp3uuupEwdKPadTQyF+/h8E+u4fKRv9sTSCPovde1VNyyCmKhw94W8ZqZKNqAtUd7UJfzN0LfAHzhfpPsGzvc+3h9DDAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751530646; c=relaxed/simple;
	bh=ghgl+VY8cTjRrm/NDbWTnhmpUoTqUAJFdV6gZOgBmKs=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=EFqU50bfDpYYp+DRpvV4H7GB+Mx31VnN7XL3W92wbpL360Uv4RQwIhgk9395sttnfgzkbajzlI/udINaMx0eAfaieLQeBSUZAYbD/3s5QDpMAGG57oZ2pZK91TsjUVjJzKLub6yFXRvMEuqS+ogaiz4usikBfhpnf0m/e4Mnb+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-86cf306fc68so1279179839f.3
        for <netdev@vger.kernel.org>; Thu, 03 Jul 2025 01:17:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751530644; x=1752135444;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+6GNCHNANxvo+ZqabR32huRxOQaWVbJ75GQutnj3xcQ=;
        b=uMRDifrf4+LT5IBYTGmZXfd07z0mbz+Y6E7sZMzDFDsxpbK/y8zv3HhEfu9oeeDrA3
         nXstunjmgjaWDUgWLW9HBkm+Oqhhd8Arlfx6W8sKM3KwRq1BKqsWSjykBVpJ0hI0Sv0y
         YTFYb/MiZiQdg8aD+XfgFaCTBav5WC0o+6sNTA4V6Uw+ydZZ9xb/3Tmvq3HHYzW3kuXP
         30wIpwG4SEFx5Kat0ehbGhmQUXBpLqn35/zzSVWh/WzQglpgvieRupIO2m97MmyBmJoh
         MjdFQvTJ5MRV+cXXt2FhlluoyBxfQDgaIgQycnbdQr/szRTL5DvSBsfFeKoEt97iQf4D
         NeYg==
X-Forwarded-Encrypted: i=1; AJvYcCWYzy3e7kBeFKmzvx/3oBNDMuMONw0tMlV+PA31TNLhfIt7SRooXERYAlzBdVHAr+gcEHVQ+ns=@vger.kernel.org
X-Gm-Message-State: AOJu0YzleD/1eSeFnyzGaQycmuHsEk66lXaGBETnHillZh5DXcTHzbyy
	z6uEvelyPI6l3MRiBQIqg3OYcGXkqbP4D2wfmrcHwJREyOInooqnvXQH7FAE+/pK8Mvt1fJUJNm
	AmJIv+k4JVSvdg33G7Yco6RNGvS8g6XDv6Zd+jZD6C85288Hk1bSUzthfI+E=
X-Google-Smtp-Source: AGHT+IGGfqW4UJPNgdNpUu1K71s3vcT3hKkg+pELHwVxlFchLFC9soUMq5XL/LrewkXhhv8KEOGAl3zSgSA0p494hTMb111Gj7Wv
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2748:b0:876:bdb0:db43 with SMTP id
 ca18e2360f4ac-876c6a99ee9mr744868139f.14.1751530643895; Thu, 03 Jul 2025
 01:17:23 -0700 (PDT)
Date: Thu, 03 Jul 2025 01:17:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68663c93.a70a0220.5d25f.0857.GAE@google.com>
Subject: [syzbot] [net?] general protection fault in htb_qlen_notify
From: syzbot <syzbot+d8b58d7b0ad89a678a16@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	jhs@mojatatu.com, jiri@resnulli.us, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com, xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    bd475eeaaf3c Merge branch '200GbE' of git://git.kernel.org..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=1323b770580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=36b0e72cad5298f8
dashboard link: https://syzkaller.appspot.com/bug?extid=d8b58d7b0ad89a678a16
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d59bc82a55e0/disk-bd475eea.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2a83759fceb6/vmlinux-bd475eea.xz
kernel image: https://storage.googleapis.com/syzbot-assets/07576fd8e432/bzImage-bd475eea.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d8b58d7b0ad89a678a16@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000035: 0000 [#1] SMP KASAN PTI
KASAN: null-ptr-deref in range [0x00000000000001a8-0x00000000000001af]
CPU: 0 UID: 0 PID: 7207 Comm: syz.3.362 Not tainted 6.16.0-rc3-syzkaller-00144-gbd475eeaaf3c #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
RIP: 0010:htb_deactivate net/sched/sch_htb.c:613 [inline]
RIP: 0010:htb_qlen_notify+0x31/0xc0 net/sched/sch_htb.c:1489
Code: 41 56 41 55 41 54 53 49 89 f6 49 89 ff 49 bc 00 00 00 00 00 fc ff df e8 3d c6 46 f8 49 8d 9e a8 01 00 00 49 89 dd 49 c1 ed 03 <43> 0f b6 44 25 00 84 c0 75 4d 8b 2b 31 ff 89 ee e8 5a ca 46 f8 85
RSP: 0018:ffffc90003c6efb0 EFLAGS: 00010206
RAX: ffffffff89798833 RBX: 00000000000001a8 RCX: ffff8880585d9e00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff888058d42000
RBP: dffffc0000000000 R08: ffff8880585d9e00 R09: 0000000000000002
R10: 00000000ffffffff R11: ffffffff89798810 R12: dffffc0000000000
R13: 0000000000000035 R14: 0000000000000000 R15: ffff888058d42000
FS:  00007f22a32406c0(0000) GS:ffff888125c50000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f22a31ddd58 CR3: 000000007c196000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 qdisc_tree_reduce_backlog+0x29c/0x480 net/sched/sch_api.c:811
 fq_change+0x1519/0x1f50 net/sched/sch_fq.c:1147
 fq_init+0x699/0x960 net/sched/sch_fq.c:1201
 qdisc_create+0x7ac/0xea0 net/sched/sch_api.c:1324
 __tc_modify_qdisc net/sched/sch_api.c:1749 [inline]
 tc_modify_qdisc+0x1426/0x2010 net/sched/sch_api.c:1813
 rtnetlink_rcv_msg+0x779/0xb70 net/core/rtnetlink.c:6953
 netlink_rcv_skb+0x208/0x470 net/netlink/af_netlink.c:2534
 netlink_unicast_kernel net/netlink/af_netlink.c:1313 [inline]
 netlink_unicast+0x75b/0x8d0 net/netlink/af_netlink.c:1339
 netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1883
 sock_sendmsg_nosec net/socket.c:712 [inline]
 __sock_sendmsg+0x21c/0x270 net/socket.c:727
 ____sys_sendmsg+0x505/0x830 net/socket.c:2566
 ___sys_sendmsg+0x21f/0x2a0 net/socket.c:2620
 __sys_sendmsg net/socket.c:2652 [inline]
 __do_sys_sendmsg net/socket.c:2657 [inline]
 __se_sys_sendmsg net/socket.c:2655 [inline]
 __x64_sys_sendmsg+0x19b/0x260 net/socket.c:2655
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f22a238e929
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f22a3240038 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f22a25b5fa0 RCX: 00007f22a238e929
RDX: 0000000000000800 RSI: 0000200000000100 RDI: 0000000000000008
RBP: 00007f22a2410b39 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f22a25b5fa0 R15: 00007fffce377518
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:htb_deactivate net/sched/sch_htb.c:613 [inline]
RIP: 0010:htb_qlen_notify+0x31/0xc0 net/sched/sch_htb.c:1489
Code: 41 56 41 55 41 54 53 49 89 f6 49 89 ff 49 bc 00 00 00 00 00 fc ff df e8 3d c6 46 f8 49 8d 9e a8 01 00 00 49 89 dd 49 c1 ed 03 <43> 0f b6 44 25 00 84 c0 75 4d 8b 2b 31 ff 89 ee e8 5a ca 46 f8 85
RSP: 0018:ffffc90003c6efb0 EFLAGS: 00010206
RAX: ffffffff89798833 RBX: 00000000000001a8 RCX: ffff8880585d9e00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff888058d42000
RBP: dffffc0000000000 R08: ffff8880585d9e00 R09: 0000000000000002
R10: 00000000ffffffff R11: ffffffff89798810 R12: dffffc0000000000
R13: 0000000000000035 R14: 0000000000000000 R15: ffff888058d42000
FS:  00007f22a32406c0(0000) GS:ffff888125c50000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f22a31ddd58 CR3: 000000007c196000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	41 56                	push   %r14
   2:	41 55                	push   %r13
   4:	41 54                	push   %r12
   6:	53                   	push   %rbx
   7:	49 89 f6             	mov    %rsi,%r14
   a:	49 89 ff             	mov    %rdi,%r15
   d:	49 bc 00 00 00 00 00 	movabs $0xdffffc0000000000,%r12
  14:	fc ff df
  17:	e8 3d c6 46 f8       	call   0xf846c659
  1c:	49 8d 9e a8 01 00 00 	lea    0x1a8(%r14),%rbx
  23:	49 89 dd             	mov    %rbx,%r13
  26:	49 c1 ed 03          	shr    $0x3,%r13
* 2a:	43 0f b6 44 25 00    	movzbl 0x0(%r13,%r12,1),%eax <-- trapping instruction
  30:	84 c0                	test   %al,%al
  32:	75 4d                	jne    0x81
  34:	8b 2b                	mov    (%rbx),%ebp
  36:	31 ff                	xor    %edi,%edi
  38:	89 ee                	mov    %ebp,%esi
  3a:	e8 5a ca 46 f8       	call   0xf846ca99
  3f:	85                   	.byte 0x85


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


Return-Path: <netdev+bounces-249551-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A0B5D1AE71
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 19:52:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 022783035F45
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 18:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17088350A30;
	Tue, 13 Jan 2026 18:52:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f77.google.com (mail-ot1-f77.google.com [209.85.210.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B6934FF59
	for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 18:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768330350; cv=none; b=dYjnPY5jZ8VCkFCof4mrws5Pz3iICvnOuqoBJZdq1TXUsullWO8CmVsmxiVkU/GvBOmgT/vwqjA/aRszXGLnI+x3e9OVJQh9OIBDxm9G5DeAVKtABykzVwF97Intiz0es7YFusye3MB7nGMNFcRE210G+MPLsn1OtRDrWTsnS/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768330350; c=relaxed/simple;
	bh=rPUPDKtM31Oz1+08Q+B80uSMJVdhJYazODHh2Ru8Ub8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=aO9PfLjzIqnkhbtCakfRMhH4VDPDGD50ZYqClwDXrxYljd/irS1OTju3yFIiDkUIHuVkQh0fEpwaXkF0l+/bUUqxMNJ66NiFshP5ywNU+gpKSe87Sg8b5/dIMOD+Hfo3rjeOcSIxsoqJ3PcYVYb7ve4s9LDXlKgQEAlea02gsHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f77.google.com with SMTP id 46e09a7af769-7ce5218a735so22827328a34.3
        for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 10:52:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768330347; x=1768935147;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Burof2S6JX1LralHKxrdfHz+EKh0ZsaIMQ0+9MfeK3s=;
        b=LnfaH8WBz2TyW9L8rS8GKCMkphGhVz/h36JdAEkO4AFyUrgcAHhkxx8xNzd1YE1N8v
         nAixKyGjvizGqPDZezxmvcvG2umMeV1GBhtrgQNMI1zaWKXnnfLl0zPl7oTI7197PQLX
         1bs5aSA0Y2G9iNQKvJIqc9bfdhZFzrL0lEWf6j+69u19xY8hz9AOle0khRMice30oHr7
         WO5QdiW/WfzihLTd2xxTHIlux4YzI9qToA9SV+Eabnuy3bG5h+IhlbKdQDj+xFW9Sh6q
         AUnPUjhbidbYRsBi3lB6PzsCAyn0IWru+U1A9r/CRkxwJ+WxwXOD5JJ0XkgPKScpU8tL
         0u+w==
X-Forwarded-Encrypted: i=1; AJvYcCUwBQlm/zELGqzeG3Ol6eqkhvgCPKGSnX1KG+nsj7tY+aEH/mmCAEcu5XJoWyIKQu23AjrtyNE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyoo1LorBrccVrROYzvbBUwD5txboPvWu4apuNmWvoJH530KRIK
	op6C7r5Zm/aodnG/7DEHkFekh8qiaSU1bW78mKMjmIDrrPYAmPyK5FOwdV/AX01ymYgAnSdoqng
	Ki0m5ctu2bRgcMEuiq1ttqasJZSY/aUnPIW8wEsVACR5pMxZaoDltzbd4tKA=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:1629:b0:659:9a49:9047 with SMTP id
 006d021491bc7-6610068ac2dmr115029eaf.18.1768330347409; Tue, 13 Jan 2026
 10:52:27 -0800 (PST)
Date: Tue, 13 Jan 2026 10:52:27 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6966946b.a70a0220.245e30.0002.GAE@google.com>
Subject: [syzbot] [net?] KASAN: global-out-of-bounds Read in __hw_addr_add_ex (4)
From: syzbot <syzbot+9c081b17773615f24672@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    c8ebd433459b Merge tag 'nfsd-6.19-2' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=139b8a9a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a94030c847137a18
dashboard link: https://syzkaller.appspot.com/bug?extid=9c081b17773615f24672
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/4c32d0f2cb90/disk-c8ebd433.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/83d8084c8f35/vmlinux-c8ebd433.xz
kernel image: https://storage.googleapis.com/syzbot-assets/2687615751bf/bzImage-c8ebd433.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9c081b17773615f24672@syzkaller.appspotmail.com

netlink: 8 bytes leftover after parsing attributes in process `syz.1.3580'.
netlink: 4 bytes leftover after parsing attributes in process `syz.1.3580'.
8021q: adding VLAN 0 to HW filter on device bond1
8021q: adding VLAN 0 to HW filter on device bond0
==================================================================
BUG: KASAN: global-out-of-bounds in __hw_addr_create net/core/dev_addr_lists.c:63 [inline]
BUG: KASAN: global-out-of-bounds in __hw_addr_add_ex+0x25d/0x760 net/core/dev_addr_lists.c:118
Read of size 16 at addr ffffffff8bf94040 by task syz.1.3580/19497

CPU: 1 UID: 0 PID: 19497 Comm: syz.1.3580 Tainted: G             L      syzkaller #0 PREEMPT(full) 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xca/0x240 mm/kasan/report.c:482
 kasan_report+0x118/0x150 mm/kasan/report.c:595
 check_region_inline mm/kasan/generic.c:-1 [inline]
 kasan_check_range+0x2b0/0x2c0 mm/kasan/generic.c:200
 __asan_memcpy+0x29/0x70 mm/kasan/shadow.c:105
 __hw_addr_create net/core/dev_addr_lists.c:63 [inline]
 __hw_addr_add_ex+0x25d/0x760 net/core/dev_addr_lists.c:118
 __dev_mc_add net/core/dev_addr_lists.c:868 [inline]
 dev_mc_add+0xa1/0x120 net/core/dev_addr_lists.c:886
 bond_enslave+0x2b8b/0x3ac0 drivers/net/bonding/bond_main.c:2180
 do_set_master+0x533/0x6d0 net/core/rtnetlink.c:2963
 do_setlink+0xcf0/0x41c0 net/core/rtnetlink.c:3165
 rtnl_changelink net/core/rtnetlink.c:3776 [inline]
 __rtnl_newlink net/core/rtnetlink.c:3935 [inline]
 rtnl_newlink+0x161c/0x1c90 net/core/rtnetlink.c:4072
 rtnetlink_rcv_msg+0x7cf/0xb70 net/core/rtnetlink.c:6958
 netlink_rcv_skb+0x208/0x470 net/netlink/af_netlink.c:2550
 netlink_unicast_kernel net/netlink/af_netlink.c:1318 [inline]
 netlink_unicast+0x82f/0x9e0 net/netlink/af_netlink.c:1344
 netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1894
 sock_sendmsg_nosec net/socket.c:727 [inline]
 __sock_sendmsg+0x21c/0x270 net/socket.c:742
 ____sys_sendmsg+0x505/0x820 net/socket.c:2592
 ___sys_sendmsg+0x21f/0x2a0 net/socket.c:2646
 __sys_sendmsg+0x164/0x220 net/socket.c:2678
 do_syscall_32_irqs_on arch/x86/entry/syscall_32.c:83 [inline]
 __do_fast_syscall_32+0x1dc/0x560 arch/x86/entry/syscall_32.c:307
 do_fast_syscall_32+0x34/0x80 arch/x86/entry/syscall_32.c:332
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e
RIP: 0023:0xf7f54539
Code: 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 002b:00000000f544655c EFLAGS: 00000206 ORIG_RAX: 0000000000000172
RAX: ffffffffffffffda RBX: 0000000000000005 RCX: 0000000080000240
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000206 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>

The buggy address belongs to the variable:
 lacpdu_mcast_addr+0x0/0x40

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0xbf94
flags: 0xfff00000002000(reserved|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000002000 ffffea00002fe508 ffffea00002fe508 0000000000000000
raw: 0000000000000000 0000000000000000 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner info is not present (never set?)

Memory state around the buggy address:
 ffffffff8bf93f00: 00 00 00 00 00 00 00 00 00 f9 f9 f9 f9 f9 f9 f9
 ffffffff8bf93f80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffffffff8bf94000: 00 00 00 00 f9 f9 f9 f9 00 f9 f9 f9 00 00 00 00
                                              ^
 ffffffff8bf94080: 00 00 00 00 00 00 04 f9 f9 f9 f9 f9 00 f9 f9 f9
 ffffffff8bf94100: 00 00 06 f9 f9 f9 f9 f9 00 00 00 00 00 00 01 f9
==================================================================
----------------
Code disassembly (best guess):
   0:	03 74 b4 01          	add    0x1(%rsp,%rsi,4),%esi
   4:	10 07                	adc    %al,(%rdi)
   6:	03 74 b0 01          	add    0x1(%rax,%rsi,4),%esi
   a:	10 08                	adc    %cl,(%rax)
   c:	03 74 d8 01          	add    0x1(%rax,%rbx,8),%esi
  20:	00 51 52             	add    %dl,0x52(%rcx)
  23:	55                   	push   %rbp
  24:	89 e5                	mov    %esp,%ebp
  26:	0f 34                	sysenter
  28:	cd 80                	int    $0x80
* 2a:	5d                   	pop    %rbp <-- trapping instruction
  2b:	5a                   	pop    %rdx
  2c:	59                   	pop    %rcx
  2d:	c3                   	ret
  2e:	90                   	nop
  2f:	90                   	nop
  30:	90                   	nop
  31:	90                   	nop
  32:	90                   	nop
  33:	90                   	nop
  34:	90                   	nop
  35:	90                   	nop
  36:	90                   	nop
  37:	90                   	nop
  38:	90                   	nop
  39:	90                   	nop
  3a:	90                   	nop
  3b:	90                   	nop
  3c:	90                   	nop
  3d:	90                   	nop
  3e:	90                   	nop
  3f:	90                   	nop


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


Return-Path: <netdev+bounces-195494-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68C0EAD07E0
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 20:07:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B25353B2062
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 18:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A35128BA85;
	Fri,  6 Jun 2025 18:07:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF10189906
	for <netdev@vger.kernel.org>; Fri,  6 Jun 2025 18:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749233251; cv=none; b=oqrlqfMKGQF1CWz58Sirm2niLp2zdxKSIORlcdAB+D49mvTfY2idfJIC2GBBk1Yc2rlneYN51XTVMoSwCU8uzax9P1bXc+1FnhX7brMvyWoMrphaFYJ7DFApLSjNAIKPe1bUoKmDVXRmb8jBJRQMtUNjSH4P7cVpcDD1SuiVo/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749233251; c=relaxed/simple;
	bh=aTkzrlBF+7fHXVGsOtOrnRnAXid0DyRz+kGS/+Jn0JY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ja/cHBI3tBdKytFmYA2ErSWmk8oUrKOliwIaOjSqtUDkots92Xe4MCEi8mDaBkcwn+YNyeHUyElIIk67A+W/4NjZgoua/9UbDzmNyh0kdyPM2ZOhs7dVRsMdSy7lfjzO5LXTqTLBVMxjIUKB/UEv76qwOhxuY7dRGkOhsuORLUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3ddcc14b794so9661525ab.2
        for <netdev@vger.kernel.org>; Fri, 06 Jun 2025 11:07:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749233249; x=1749838049;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NdN2i83y3apiJCE5pOS2UVD4tc2Dg376Kdyc8YW5OBA=;
        b=bwu/IWgzsIi6zhO03wfqQd1IweLyvN1pDulNKaLqYAr996nMHBw2eLIftoyX3T93ul
         LF4mx0Yo5RlnB8lpBRFB1txER0jKa979dVEB5HkaqXiZ9w2kyEQHvX/UOVaUO9Zww1CJ
         IR/r9+ESYnaZfUPqvsj2xkW5vD+mV7daEUZLC4eUbPzCz16vt/tbctnnPxWeu4YnB35A
         lckl+PpnRsH9rltPOmFFYTILL45Xlaw5O9BmcINb7f8ZBOc1inHmv+yOMoYDc1cOBOd6
         fFcV2YERRV15MtE8nhCXCPCoXqcKRpqXUVBWYIyH7FvCg9uzqRz0o/jxcQhP2ZU4CjxG
         UTvg==
X-Forwarded-Encrypted: i=1; AJvYcCUKi3NVm1gIt8j+W7/j9usNgXaJX1/7Psf149wKTDlutJzQNdAMlH15X0BYrEoG13v42GRARrU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx+lVV7Ccr6Wy6VNPd7DoNH6nqKZ18eoRIIQGJ/F1B1/ZvFES5
	wWYq3WMRDVJVBU7JKlpBvlKgKXmc1Nzzu+vk2m1Szy++zoZl81qrjhjHnyIW7y5idcc0nsu/esB
	5HrWyz6gGzqweMFjPhhhZzovHgt7t0F6jEYVr5v9OnXZG/DFGhh2moD0Artc=
X-Google-Smtp-Source: AGHT+IHE6Eg/MG61GMFO7qXshttr1gq+JGkOyRcFUhFZ5p7W+5XTc748uMIeUret2q5Th53ZZv4OKfwQUR7oyOvBEYL7AriCxxt3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:4518:20b0:3dd:d189:8a6c with SMTP id
 e9e14a558f8ab-3ddd1898dd9mr22748965ab.4.1749233248886; Fri, 06 Jun 2025
 11:07:28 -0700 (PDT)
Date: Fri, 06 Jun 2025 11:07:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68432e60.a00a0220.29ac89.0048.GAE@google.com>
Subject: [syzbot] [net?] divide error in taprio_update_queue_max_sdu (2)
From: syzbot <syzbot+3957824f1e313a2bd6d6@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	jhs@mojatatu.com, jiri@resnulli.us, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com, vinicius.gomes@intel.com, 
	xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    2c7e4a2663a1 Merge tag 'net-6.16-rc1' of git://git.kernel...
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=120a9570580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=73696606574e3967
dashboard link: https://syzkaller.appspot.com/bug?extid=3957824f1e313a2bd6d6
compiler:       Debian clang version 20.1.6 (++20250514063057+1e4d39e07757-1~exp1~20250514183223.118), Debian LLD 20.1.6

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f7bcf4a3e380/disk-2c7e4a26.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3145a82e112f/vmlinux-2c7e4a26.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b770afd502e3/bzImage-2c7e4a26.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3957824f1e313a2bd6d6@syzkaller.appspotmail.com

Oops: divide error: 0000 [#1] SMP KASAN PTI
CPU: 0 UID: 0 PID: 12175 Comm: syz.3.1468 Not tainted 6.15.0-syzkaller-12422-g2c7e4a2663a1 #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
RIP: 0010:div_u64_rem include/linux/math64.h:29 [inline]
RIP: 0010:div_u64 include/linux/math64.h:130 [inline]
RIP: 0010:duration_to_length net/sched/sch_taprio.c:259 [inline]
RIP: 0010:taprio_update_queue_max_sdu+0x2b9/0x890 net/sched/sch_taprio.c:288
Code: 74 08 48 89 df e8 37 36 9e f8 48 8b 03 89 c1 4c 89 e8 48 c1 e8 20 74 0d 4c 89 e8 31 d2 48 f7 f1 48 89 c5 eb 09 44 89 e8 31 d2 <f7> f1 89 c5 48 83 7c 24 50 00 49 bd 00 00 00 00 00 fc ff df 74 48
RSP: 0018:ffffc90003486978 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff8880292be2e0 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffff8880292be2e0
RBP: 0000000000000000 R08: ffff8880292be2e7 R09: 1ffff11005257c5c
R10: dffffc0000000000 R11: ffffed1005257c5d R12: 00000000ffffffff
R13: 0000000000000000 R14: 0000000000000000 R15: ffff888057048c00
FS:  00007fc8a83a76c0(0000) GS:ffff888125c55000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 0000000029c28000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 taprio_dev_notifier+0x2a4/0x3b0 net/sched/sch_taprio.c:1333
 notifier_call_chain+0x1b3/0x3e0 kernel/notifier.c:85
 netif_state_change+0x284/0x3a0 net/core/dev.c:1584
 netif_set_operstate net/core/rtnetlink.c:1055 [inline]
 set_operstate+0x2cc/0x3a0 net/core/rtnetlink.c:1083
 do_setlink+0x12bc/0x41c0 net/core/rtnetlink.c:3216
 rtnl_group_changelink net/core/rtnetlink.c:3773 [inline]
 __rtnl_newlink net/core/rtnetlink.c:3927 [inline]
 rtnl_newlink+0x149f/0x1c70 net/core/rtnetlink.c:4055
 rtnetlink_rcv_msg+0x7cc/0xb70 net/core/rtnetlink.c:6944
 netlink_rcv_skb+0x205/0x470 net/netlink/af_netlink.c:2534
 netlink_unicast_kernel net/netlink/af_netlink.c:1313 [inline]
 netlink_unicast+0x758/0x8d0 net/netlink/af_netlink.c:1339
 netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1883
 sock_sendmsg_nosec net/socket.c:712 [inline]
 __sock_sendmsg+0x219/0x270 net/socket.c:727
 ____sys_sendmsg+0x505/0x830 net/socket.c:2566
 ___sys_sendmsg+0x21f/0x2a0 net/socket.c:2620
 __sys_sendmsg net/socket.c:2652 [inline]
 __do_sys_sendmsg net/socket.c:2657 [inline]
 __se_sys_sendmsg net/socket.c:2655 [inline]
 __x64_sys_sendmsg+0x19b/0x260 net/socket.c:2655
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fc8a758e929
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fc8a83a7038 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007fc8a77b5fa0 RCX: 00007fc8a758e929
RDX: 0000000000000000 RSI: 0000200000000140 RDI: 0000000000000004
RBP: 00007fc8a7610b39 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fc8a77b5fa0 R15: 00007ffe00d939a8
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:div_u64_rem include/linux/math64.h:29 [inline]
RIP: 0010:div_u64 include/linux/math64.h:130 [inline]
RIP: 0010:duration_to_length net/sched/sch_taprio.c:259 [inline]
RIP: 0010:taprio_update_queue_max_sdu+0x2b9/0x890 net/sched/sch_taprio.c:288
Code: 74 08 48 89 df e8 37 36 9e f8 48 8b 03 89 c1 4c 89 e8 48 c1 e8 20 74 0d 4c 89 e8 31 d2 48 f7 f1 48 89 c5 eb 09 44 89 e8 31 d2 <f7> f1 89 c5 48 83 7c 24 50 00 49 bd 00 00 00 00 00 fc ff df 74 48
RSP: 0018:ffffc90003486978 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff8880292be2e0 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffff8880292be2e0
RBP: 0000000000000000 R08: ffff8880292be2e7 R09: 1ffff11005257c5c
R10: dffffc0000000000 R11: ffffed1005257c5d R12: 00000000ffffffff
R13: 0000000000000000 R14: 0000000000000000 R15: ffff888057048c00
FS:  00007fc8a83a76c0(0000) GS:ffff888125d55000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000008000 CR3: 0000000029c28000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	74 08                	je     0xa
   2:	48 89 df             	mov    %rbx,%rdi
   5:	e8 37 36 9e f8       	call   0xf89e3641
   a:	48 8b 03             	mov    (%rbx),%rax
   d:	89 c1                	mov    %eax,%ecx
   f:	4c 89 e8             	mov    %r13,%rax
  12:	48 c1 e8 20          	shr    $0x20,%rax
  16:	74 0d                	je     0x25
  18:	4c 89 e8             	mov    %r13,%rax
  1b:	31 d2                	xor    %edx,%edx
  1d:	48 f7 f1             	div    %rcx
  20:	48 89 c5             	mov    %rax,%rbp
  23:	eb 09                	jmp    0x2e
  25:	44 89 e8             	mov    %r13d,%eax
  28:	31 d2                	xor    %edx,%edx
* 2a:	f7 f1                	div    %ecx <-- trapping instruction
  2c:	89 c5                	mov    %eax,%ebp
  2e:	48 83 7c 24 50 00    	cmpq   $0x0,0x50(%rsp)
  34:	49 bd 00 00 00 00 00 	movabs $0xdffffc0000000000,%r13
  3b:	fc ff df
  3e:	74 48                	je     0x88


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


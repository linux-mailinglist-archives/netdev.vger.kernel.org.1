Return-Path: <netdev+bounces-201917-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E00F8AEB6C2
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 13:44:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 447AE3BB286
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 11:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC5DC29E115;
	Fri, 27 Jun 2025 11:44:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2092F222593
	for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 11:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751024668; cv=none; b=T/dZ8CclGDBpk8wwJDHr/CJn9ivTqjMzVCm4UDkMCP9Uro/w00gVMChS/QfIziKnCSkKNw6x+FmJPFvp0rvRJq5NtJjt2dnRJR8nSyLLSthtd59/3m9X0H2hAhGjFD3ow/E8mFulnlyHxvqkmsJaAx4Q+LRB/WxUZhJKhOUo3Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751024668; c=relaxed/simple;
	bh=LypsnHfjUJ/MQWcPoyl8T1d6zmfjblGzB4a3dMrK1JA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=nhoyar6bZGG7be6MWQZz7thAjrRhG3zG/SkDdJZM38O/u19YhSLAoLLOtsOKDZDxys4BADKco68Ik2aMYcmd2AQ+2H5B7g7oIyTaxUYNT/UDEljM2MiH9ah2fLn2HdhxzkVd2Q0RgkXbf1eF/nWmEqaDkim94BBp4psHPhP01+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3df2d0b7c50so20815565ab.1
        for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 04:44:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751024666; x=1751629466;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LcNzehwuovaQpYuSLQaGBibTim5vKH876zH5zSg7PqM=;
        b=qeCAih4/B4z+hvNdvBnDZ7QM0bmjjvM+pkPNDMAeZ6J2jQmPuZ7UvifQ3I3Mns5Rwx
         BBMHQHdJ9Rh6sxPEZC5cF+uUtWjHj+s4WLRQZWNQOzYlu3Ay6jT7VuIy85xG0TrvkGxt
         WLwgeTFkfJA6MbFnaqcts2yu5vNs3lQkdn3eMJYfEUeKuh8XtOFuGSghyDADf/JTZVfY
         ClpIAG0vgMkBlvgiWHRZjxustlnpOqqi3JiMH1tejxbqaDrhzp8z1RY9iG6X6FjsVKCc
         iMr4rdh+5AWTqQzkNgzD1Z9NXyCH1ch5zKtlNPkOHBtFT/IEJOU1Rs2blCD6sIDagJnA
         38Vg==
X-Forwarded-Encrypted: i=1; AJvYcCU/2ET7LopZ/Ejo8hXMHwmGkMHipnwJu/sXwvmRbm0Zt6huuBiuy2BWU/hx0Pd8Me7oVHirGQU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuJf5ZqnobcHw8dK4ggJoJz7xHMID9bt/4vUmPZGsS/a2MuGpf
	o3mnNL8S9VJEMZAjRdiCiRXL28dYp7oiOF6NDuQPjGOoA5cBozF5senXtSdUI1tiOJgY5w0iQ7j
	bGg3Pc4C3XDlSEypB+mJV2Rh+X2e9Ff999rPnBjODg9EOKsvRDsAI/fH0FV4=
X-Google-Smtp-Source: AGHT+IEAfg2yIhYyQDwlT8K8xZcVXGXvfML2KOrIA1eVXjUIR6IBI5ghrW0aa5ddHuN3wR+c6aXNXEMKHStBdEPUjOxWRTkrscKa
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3111:b0:3df:2f47:dc21 with SMTP id
 e9e14a558f8ab-3df4acc64a1mr34190715ab.22.1751024666209; Fri, 27 Jun 2025
 04:44:26 -0700 (PDT)
Date: Fri, 27 Jun 2025 04:44:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <685e841a.a00a0220.129264.0002.GAE@google.com>
Subject: [syzbot] [net?] WARNING in ip_mr_output
From: syzbot <syzbot+f02fb9e43bd85c6c66ae@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    fc4842cd0f11 Merge branch 'netconsole-msgid' into main
git tree:       net-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=10d0be82580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8a808a5ba3697f99
dashboard link: https://syzkaller.appspot.com/bug?extid=f02fb9e43bd85c6c66ae
compiler:       Debian clang version 20.1.6 (++20250514063057+1e4d39e07757-1~exp1~20250514183223.118), Debian LLD 20.1.6
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=152d0d0c580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=132d0d0c580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8929e479b95b/disk-fc4842cd.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3b2cb79509fb/vmlinux-fc4842cd.xz
kernel image: https://storage.googleapis.com/syzbot-assets/60acef195b6f/bzImage-fc4842cd.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f02fb9e43bd85c6c66ae@syzkaller.appspotmail.com

WARNING: CPU: 0 PID: 5859 at net/ipv4/ipmr.c:2302 ip_mr_output+0xbb1/0xe70 net/ipv4/ipmr.c:2302
Modules linked in:
CPU: 0 UID: 0 PID: 5859 Comm: syz-executor357 Not tainted 6.16.0-rc1-syzkaller-00413-gfc4842cd0f11 #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
RIP: 0010:ip_mr_output+0xbb1/0xe70 net/ipv4/ipmr.c:2302
Code: df e9 63 f6 ff ff e8 8e 72 c6 f7 48 8b 74 24 18 45 31 f6 31 ff ba 02 00 00 00 e8 ea 14 4c ff e9 45 f6 ff ff e8 70 72 c6 f7 90 <0f> 0b 90 e9 94 f5 ff ff e8 62 72 c6 f7 90 0f 0b 90 42 80 3c 2b 00
RSP: 0018:ffffc90000007900 EFLAGS: 00010246
RAX: ffffffff89f9ec80 RBX: ffff888033053780 RCX: ffff8880277c9e00
RDX: 0000000000000100 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc90000007a10 R08: 0000000000000000 R09: ffffffff89d71b5d
R10: dffffc0000000000 R11: ffffffff89f9e0d0 R12: 0000000000000010
R13: dffffc0000000000 R14: ffff888075dfb100 R15: 0000000000000000
FS:  000055557e793380(0000) GS:ffff888125c52000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fe8999b9270 CR3: 00000000291c0000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 igmp_send_report+0x89e/0xdb0 net/ipv4/igmp.c:799
 igmp_timer_expire+0x204/0x510 net/ipv4/igmp.c:-1
 call_timer_fn+0x17e/0x5f0 kernel/time/timer.c:1747
 expire_timers kernel/time/timer.c:1798 [inline]
 __run_timers kernel/time/timer.c:2372 [inline]
 __run_timer_base+0x61a/0x860 kernel/time/timer.c:2384
 run_timer_base kernel/time/timer.c:2393 [inline]
 run_timer_softirq+0xb7/0x180 kernel/time/timer.c:2403
 handle_softirqs+0x286/0x870 kernel/softirq.c:579
 __do_softirq kernel/softirq.c:613 [inline]
 invoke_softirq kernel/softirq.c:453 [inline]
 __irq_exit_rcu+0xca/0x1f0 kernel/softirq.c:680
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:696
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1050 [inline]
 sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1050
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:__raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:152 [inline]
RIP: 0010:_raw_spin_unlock_irqrestore+0xa8/0x110 kernel/locking/spinlock.c:194
Code: 74 05 e8 cb 4e 5f f6 48 c7 44 24 20 00 00 00 00 9c 8f 44 24 20 f6 44 24 21 02 75 4f f7 c3 00 02 00 00 74 01 fb bf 01 00 00 00 <e8> d3 3a 28 f6 65 8b 05 bc 43 34 07 85 c0 74 40 48 c7 04 24 0e 36
RSP: 0018:ffffc9000445f640 EFLAGS: 00000206
RAX: 718848643f7ff500 RBX: 0000000000000a02 RCX: 718848643f7ff500
RDX: 0000000000000006 RSI: ffffffff8d982ba6 RDI: 0000000000000001
RBP: ffffc9000445f6c0 R08: ffffffff8fa10ff7 R09: 1ffffffff1f421fe
R10: dffffc0000000000 R11: fffffbfff1f421ff R12: dffffc0000000000
R13: ffffffff8f574a40 R14: ffffffff8f574a00 R15: 1ffff9200088bec8
 spin_unlock_irqrestore include/linux/spinlock.h:406 [inline]
 __wake_up_common_lock+0x190/0x1f0 kernel/sched/wait.c:108
 netlink_unlock_table net/netlink/af_netlink.c:462 [inline]
 netlink_broadcast_filtered+0x108a/0x1140 net/netlink/af_netlink.c:1526
 nlmsg_multicast_filtered include/net/netlink.h:1151 [inline]
 nlmsg_multicast include/net/netlink.h:1170 [inline]
 nlmsg_notify+0xf0/0x1a0 net/netlink/af_netlink.c:2577
 vif_add+0x93f/0x1420 net/ipv4/ipmr.c:894
 ip_mroute_setsockopt+0xe12/0xf60 net/ipv4/ipmr.c:1455
 do_ip_setsockopt+0xf11/0x2d00 net/ipv4/ip_sockglue.c:948
 ip_setsockopt+0x66/0x110 net/ipv4/ip_sockglue.c:1417
 do_sock_setsockopt+0x25a/0x3e0 net/socket.c:2342
 __sys_setsockopt net/socket.c:2367 [inline]
 __do_sys_setsockopt net/socket.c:2373 [inline]
 __se_sys_setsockopt net/socket.c:2370 [inline]
 __x64_sys_setsockopt+0x18b/0x220 net/socket.c:2370
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fe8999384c9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 01 1a 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffcd7ef3cc8 EFLAGS: 00000246 ORIG_RAX: 0000000000000036
RAX: ffffffffffffffda RBX: 0000000000016417 RCX: 00007fe8999384c9
RDX: 00000000000000ca RSI: 0000000000000000 RDI: 0000000000000004
RBP: 0000000000000000 R08: 0000000000000010 R09: 0000000000000000
R10: 0000200000003d80 R11: 0000000000000246 R12: 00007ffcd7ef3cec
R13: 00007ffcd7ef3d20 R14: 00007ffcd7ef3d00 R15: 0000000000000001
 </TASK>
----------------
Code disassembly (best guess):
   0:	74 05                	je     0x7
   2:	e8 cb 4e 5f f6       	call   0xf65f4ed2
   7:	48 c7 44 24 20 00 00 	movq   $0x0,0x20(%rsp)
   e:	00 00
  10:	9c                   	pushf
  11:	8f 44 24 20          	pop    0x20(%rsp)
  15:	f6 44 24 21 02       	testb  $0x2,0x21(%rsp)
  1a:	75 4f                	jne    0x6b
  1c:	f7 c3 00 02 00 00    	test   $0x200,%ebx
  22:	74 01                	je     0x25
  24:	fb                   	sti
  25:	bf 01 00 00 00       	mov    $0x1,%edi
* 2a:	e8 d3 3a 28 f6       	call   0xf6283b02 <-- trapping instruction
  2f:	65 8b 05 bc 43 34 07 	mov    %gs:0x73443bc(%rip),%eax        # 0x73443f2
  36:	85 c0                	test   %eax,%eax
  38:	74 40                	je     0x7a
  3a:	48                   	rex.W
  3b:	c7                   	.byte 0xc7
  3c:	04 24                	add    $0x24,%al
  3e:	0e                   	(bad)
  3f:	36                   	ss


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


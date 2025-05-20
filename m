Return-Path: <netdev+bounces-191873-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FF6FABD7FB
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 14:11:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0717B3A8694
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 12:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1081327EC6A;
	Tue, 20 May 2025 12:09:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f78.google.com (mail-oo1-f78.google.com [209.85.161.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3518D4A21
	for <netdev@vger.kernel.org>; Tue, 20 May 2025 12:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747742978; cv=none; b=SDkA57ulJFb9fuye6v3QzoR/0FvjsQ4bMN4QvroWpsLQk1de4r7PBnYTr8FJl8n5sS0QIajV8ynPMOPLSTD2eGkBZroRxzZkxJ47oXX31j3EDLBcO+Cn8eSUbx02fsGDxkII3kPZiT0L1O79qLS8XaC6lZt6dwckheVAdNbuZH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747742978; c=relaxed/simple;
	bh=4s1MXYKS4c2lwdmXpuoBhJEfVxuBazYKQs8LqDeA9PA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=myyawIOiFkR0l/19qk45JcWZcOtCIMYu3rd88fd5Rpkkqw6IU3uqQoV4/JRW8knKp7pbjxXqK3T4uRvazWBwC97rfpLYjZubAr5TtxZJ4chuoFGkF+N4siGQ0iTnt01v++N7vtdZ0wr5/3VXhp8LeZA9oYwGj29ntpgZgR7iPfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f78.google.com with SMTP id 006d021491bc7-606691c2afdso6222293eaf.0
        for <netdev@vger.kernel.org>; Tue, 20 May 2025 05:09:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747742975; x=1748347775;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xf6oI+HpUV0v8ri6idGeDRM5S4U5dFh/3If6EnGC8YA=;
        b=iysW0P4GssXUouQiMiP49p09/TaCKnNDyka0X7ojg67F4mu8hOOlX5Xhb6E+FI5bIq
         PHDu2XSbHONFzKNVtI0y53z46iY8dLcK6WUCZ+nHbbWldceHaNRmCfAfkm3gLH+RYw68
         fG5pRFdP5VRhmtZiT1zhPy1QJMJopEJMoMOn/akb+2Z4EzimiJ3M73WgjraL/2i8/ED0
         JoDihmBDixdREodnZT1TR2DFCtq66gA7oPHmEpmUHTyuaZ4WGidmcpYB5Kd07jmog4YG
         PUywWx700/nS4Ci9tAMf4FVKsIuRrcmCao4auYXw44vLw9svtbPYdcPlHp98/+Paa5WZ
         00HA==
X-Forwarded-Encrypted: i=1; AJvYcCUNe4LgRpRlEc55TrHvSiai+BuPFP57H+Kq/vU7xUrG1Tp09tdnnK1n1Yp+QVLNjWxUrTxEh7g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/anPdE5qKZ6AQyPDW7zhk2B2CSpeVyu05GcIZcRaPd4pURY7o
	AMD+gqo4s0qfu5iHV28f3cn4QX7qIVcGp7Yf6nHfikRXuy6VxBN5Re8dC0Fod2WrXzQ14JcUBx3
	SfMvKa2wJQ67B0bKfTxkAvOmz+pxxB/XtfjkTAWkqmIrUOVtF3Nq6dl5AEKg=
X-Google-Smtp-Source: AGHT+IE8VLuOxtSktBxAWPe05KDrddF5+NgoTcwjcpJwHgXR/bx9yzCIOiAZxEErBcNP8YB1x/P3Ms0kEyXm7YLwGJ1oeEjF1xim
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:388b:b0:85b:35b1:53b4 with SMTP id
 ca18e2360f4ac-86a24cd237cmr1915462439f.12.1747742964315; Tue, 20 May 2025
 05:09:24 -0700 (PDT)
Date: Tue, 20 May 2025 05:09:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <682c70f4.050a0220.ade60.09ba.GAE@google.com>
Subject: [syzbot] [net?] BUG: unable to handle kernel paging request in
 bond_rr_gen_slave_id (2)
From: syzbot <syzbot+e224b9d5803638de57d9@syzkaller.appspotmail.com>
To: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	jv@jvosburgh.net, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    fee3e843b309 Merge tag 'bcachefs-2025-05-15' of git://evil..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15f342d4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=30181bfb60dbb0a9
dashboard link: https://syzkaller.appspot.com/bug?extid=e224b9d5803638de57d9
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-fee3e843.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/bad9badea84a/vmlinux-fee3e843.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9aae70a5a85a/bzImage-fee3e843.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e224b9d5803638de57d9@syzkaller.appspotmail.com

BUG: unable to handle page fault for address: ffff8880d6bdf000
#PF: supervisor write access in kernel mode
#PF: error_code(0x0002) - not-present page
PGD 1b001067 P4D 1b001067 PUD 0 
Oops: Oops: 0002 [#1] SMP KASAN NOPTI
CPU: 2 UID: 0 PID: 12899 Comm: syz.2.2035 Not tainted 6.15.0-rc6-syzkaller-00188-gfee3e843b309 #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:bond_rr_gen_slave_id+0x1df/0x260 drivers/net/bonding/bond_main.c:4996
Code: bc 24 f0 00 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 80 3c 02 00 75 7a 49 8b 84 24 f0 00 00 00 bb 01 00 00 00 <65> 0f c1 18 e8 b8 af 53 fb 83 c3 01 89 d8 5b 5d 41 5c 41 5d 41 5e
RSP: 0018:ffffc90003c5f650 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000001 RCX: ffffc90007111000
RDX: 1ffff110092e69ce RSI: ffffffff86679653 RDI: ffff888049734e70
RBP: ffff888049734000 R08: 0000000000000005 R09: 0000000000000001
R10: 0000000000000001 R11: 0000000000000000 R12: ffff888049734d80
R13: 0000000000000000 R14: ffff888049734d80 R15: ffffc90003c5f9c0
FS:  00007fd2ddf556c0(0000) GS:ffff8880d6bdf000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffff8880d6bdf000 CR3: 000000004bfa9000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 bond_xdp_xmit_roundrobin_slave_get drivers/net/bonding/bond_main.c:5083 [inline]
 bond_xdp_get_xmit_slave+0x2a9/0x6b0 drivers/net/bonding/bond_main.c:5622
 xdp_master_redirect+0x15e/0x330 net/core/filter.c:4349
 bpf_prog_run_xdp include/net/xdp.h:657 [inline]
 xdp_test_run_batch.constprop.0+0x18c8/0x1f10 net/bpf/test_run.c:318
 bpf_test_run_xdp_live+0x34d/0x500 net/bpf/test_run.c:390
 bpf_prog_test_run_xdp+0x824/0x1540 net/bpf/test_run.c:1316
 bpf_prog_test_run kernel/bpf/syscall.c:4427 [inline]
 __sys_bpf+0x1488/0x4d80 kernel/bpf/syscall.c:5852
 __do_sys_bpf kernel/bpf/syscall.c:5941 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5939 [inline]
 __x64_sys_bpf+0x78/0xc0 kernel/bpf/syscall.c:5939
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x260 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fd2dd18e969
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fd2ddf55038 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 00007fd2dd3b5fa0 RCX: 00007fd2dd18e969
RDX: 0000000000000048 RSI: 0000200000000600 RDI: 000000000000000a
RBP: 00007fd2dd210ab1 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fd2dd3b5fa0 R15: 00007ffc29f1f808
 </TASK>
Modules linked in:
CR2: ffff8880d6bdf000
---[ end trace 0000000000000000 ]---
RIP: 0010:bond_rr_gen_slave_id+0x1df/0x260 drivers/net/bonding/bond_main.c:4996
Code: bc 24 f0 00 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 80 3c 02 00 75 7a 49 8b 84 24 f0 00 00 00 bb 01 00 00 00 <65> 0f c1 18 e8 b8 af 53 fb 83 c3 01 89 d8 5b 5d 41 5c 41 5d 41 5e
RSP: 0018:ffffc90003c5f650 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000001 RCX: ffffc90007111000
RDX: 1ffff110092e69ce RSI: ffffffff86679653 RDI: ffff888049734e70
RBP: ffff888049734000 R08: 0000000000000005 R09: 0000000000000001
R10: 0000000000000001 R11: 0000000000000000 R12: ffff888049734d80
R13: 0000000000000000 R14: ffff888049734d80 R15: ffffc90003c5f9c0
FS:  00007fd2ddf556c0(0000) GS:ffff8880d6bdf000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffff8880d6bdf000 CR3: 000000004bfa9000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess), 4 bytes skipped:
   0:	00 00                	add    %al,(%rax)
   2:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
   9:	fc ff df
   c:	48 89 fa             	mov    %rdi,%rdx
   f:	48 c1 ea 03          	shr    $0x3,%rdx
  13:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
  17:	75 7a                	jne    0x93
  19:	49 8b 84 24 f0 00 00 	mov    0xf0(%r12),%rax
  20:	00
  21:	bb 01 00 00 00       	mov    $0x1,%ebx
* 26:	65 0f c1 18          	xadd   %ebx,%gs:(%rax) <-- trapping instruction
  2a:	e8 b8 af 53 fb       	call   0xfb53afe7
  2f:	83 c3 01             	add    $0x1,%ebx
  32:	89 d8                	mov    %ebx,%eax
  34:	5b                   	pop    %rbx
  35:	5d                   	pop    %rbp
  36:	41 5c                	pop    %r12
  38:	41 5d                	pop    %r13
  3a:	41 5e                	pop    %r14


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


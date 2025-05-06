Return-Path: <netdev+bounces-188281-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87193AABF8B
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 11:32:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61DE03A7408
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 09:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D83E3262FFE;
	Tue,  6 May 2025 09:31:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0D426A0B3
	for <netdev@vger.kernel.org>; Tue,  6 May 2025 09:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746523901; cv=none; b=Lp/2TQAdq1IjPrjjZHx94to+Egp7yepMX5X5bVENqJEpIh47FOYU1T4yp1QjdlU4M513Aq6lP46Q6b7bnQfKMjl562W5ecP0s+kMP7/eFY/6h0yAvIEzSk8o/4PAU2wbt0np3Ma2NwLPAjCJtuLbFa/sWojmm3zLMCERj1emLuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746523901; c=relaxed/simple;
	bh=1UzmFVti+eJR5crKm6A18RZJGTC7kGHZxDksQrEJ8f4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=UWoQK1t7FRpj6qPFoIUNWAWrJmxVbq5jOHyQca25/svUyhBxv8aVucSS7tTrssKseTn12nauba2d8v0s//t4bFYikBP17kBoLK9aMulNGm9rxYZ0EoByMDBFriFjdH5MV/4PZ7hC/h4V9c/QKHeaP/ZvN+Sl7Sfb4yvD6RThwAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3d81820d5b3so104286975ab.3
        for <netdev@vger.kernel.org>; Tue, 06 May 2025 02:31:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746523899; x=1747128699;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uGfQic62ZK/lL4Q3/70BBo2V5MwRcewQeROGIpqqmMc=;
        b=YMR8jhZvnWqTAMaUVhJd1N/hyjbFQ5w0NwF0nZzHjTA3Z6WI+l7k3504je5W8NAtLb
         toTsUEShebnG51dLtUkZyg2M6j4l7/KNdXvtxrUJBruiygHchuWA0w+89XEdSd3PEgNo
         1Sm7439bvIUZwBncqIYYMOsWKJlGlyynMKblzyM1PBhPReUtqA15pFXKlif4enutmZtb
         Cx9vK9gbbzUqMA0b0YGGVpPqhKEB0vUQK7bdm5X/lMBNbPePQomii1JLzWY3zxwD0Hmk
         WMONfquv+j9DdTvXOY92h3/WH3qnZe3fZMsQ+u4duw69F4sdMUzBehP0HGFjZGqDxgQC
         TXfw==
X-Forwarded-Encrypted: i=1; AJvYcCXiCDUGwpZo4rV0OsXfbffXFkus7EUFIEwSTwMg5wce+ziJHYKTMdhzW+wMtsEHNWpGZPTQVV0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGQlIE9Ll9nWb2ROkQTenLSUclJjYcxAkDZeDYOk1GcBnPxXco
	CFUZa9j16YykRMavta6ojLjJSXyV2nBJ5ssWHZFURvh7ZaNQs/bjIPt3DR1LRf8C+2a1EaNlqTu
	IH2ZZ84qYYKwZWVrQ1DBBoeNGNVdQMYWSorY54w+o7RIOp4SzMcDouTI=
X-Google-Smtp-Source: AGHT+IE4sHmY6IdyiB+TQmYI+gqvAUP8gWPaS8TNVHxhDrzQLAJkpqiLgJDP+42Ni5IffGUMwUEXI2KiGA4xqhmbW7romVkT0+BJ
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fcb:b0:3d4:70ab:f96f with SMTP id
 e9e14a558f8ab-3d97c199938mr185633105ab.8.1746523899193; Tue, 06 May 2025
 02:31:39 -0700 (PDT)
Date: Tue, 06 May 2025 02:31:39 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6819d6fb.050a0220.37980e.0390.GAE@google.com>
Subject: [syzbot] [net?] general protection fault in __ip_mc_dec_group
From: syzbot <syzbot+62d432efb04ee8ce0bb4@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    4397684a292a virtio-net: free xsk_buffs on error in virtne..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=17bab0f4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a9a25b7a36123454
dashboard link: https://syzkaller.appspot.com/bug?extid=62d432efb04ee8ce0bb4
compiler:       Debian clang version 20.1.2 (++20250402124445+58df0ef89dd6-1~exp1~20250402004600.97), Debian LLD 20.1.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f29ea34ba236/disk-4397684a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1a9b70451d16/vmlinux-4397684a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3c20ac38738f/bzImage-4397684a.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+62d432efb04ee8ce0bb4@syzkaller.appspotmail.com

bridge0: port 2(bridge_slave_1) entered disabled state
bridge_slave_0: left allmulticast mode
bridge_slave_0: left promiscuous mode
bridge0: port 1(bridge_slave_0) entered disabled state
Oops: general protection fault, probably for non-canonical address 0xdffffc001fffe1ac: 0000 [#1] SMP KASAN PTI
KASAN: probably user-memory-access in range [0x00000000ffff0d60-0x00000000ffff0d67]
CPU: 1 UID: 0 PID: 1106 Comm: kworker/u8:7 Not tainted 6.15.0-rc4-syzkaller-00152-g4397684a292a #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/29/2025
Workqueue: netns cleanup_net
RIP: 0010:ip_mc_hash_remove net/ipv4/igmp.c:1431 [inline]
RIP: 0010:__ip_mc_dec_group+0x2fd/0x690 net/ipv4/igmp.c:1774
Code: 39 e5 de f7 c6 05 80 e2 87 05 01 48 c7 c7 c0 88 7a 8c be 97 05 00 00 48 c7 c2 40 89 7a 8c e8 4a 5d bd f7 4c 89 e3 48 c1 eb 03 <42> 80 3c 2b 00 74 08 4c 89 e7 e8 04 da 40 f8 4d 8b 2c 24 4d 39 f5
RSP: 0018:ffffc90003c0f5f8 EFLAGS: 00010206
RAX: ffffffff89e0dade RBX: 000000001fffe1ac RCX: ffff8880268a8000
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffff888029438420 R08: ffffffff8f2f41e7 R09: 1ffffffff1e5e83c
R10: dffffc0000000000 R11: fffffbfff1e5e83d R12: 00000000ffff0d60
R13: dffffc0000000000 R14: ffff88806a165c00 R15: 1ffff11005287084
FS:  0000000000000000(0000) GS:ffff8881261cc000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000110c2cae58 CR3: 000000007a838000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 inetdev_event+0x2a7/0x15b0 net/ipv4/devinet.c:1642
 notifier_call_chain+0x1b3/0x3e0 kernel/notifier.c:85
 call_netdevice_notifiers_extack net/core/dev.c:2214 [inline]
 call_netdevice_notifiers net/core/dev.c:2228 [inline]
 dev_close_many+0x29c/0x410 net/core/dev.c:1731
 unregister_netdevice_many_notify+0x834/0x2330 net/core/dev.c:11952
 cleanup_net+0x6a3/0xbd0 net/core/net_namespace.c:649
 process_one_work kernel/workqueue.c:3238 [inline]
 process_scheduled_works+0xadb/0x17a0 kernel/workqueue.c:3319
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3400
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:153
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:ip_mc_hash_remove net/ipv4/igmp.c:1431 [inline]
RIP: 0010:__ip_mc_dec_group+0x2fd/0x690 net/ipv4/igmp.c:1774
Code: 39 e5 de f7 c6 05 80 e2 87 05 01 48 c7 c7 c0 88 7a 8c be 97 05 00 00 48 c7 c2 40 89 7a 8c e8 4a 5d bd f7 4c 89 e3 48 c1 eb 03 <42> 80 3c 2b 00 74 08 4c 89 e7 e8 04 da 40 f8 4d 8b 2c 24 4d 39 f5
RSP: 0018:ffffc90003c0f5f8 EFLAGS: 00010206
RAX: ffffffff89e0dade RBX: 000000001fffe1ac RCX: ffff8880268a8000
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffff888029438420 R08: ffffffff8f2f41e7 R09: 1ffffffff1e5e83c
R10: dffffc0000000000 R11: fffffbfff1e5e83d R12: 00000000ffff0d60
R13: dffffc0000000000 R14: ffff88806a165c00 R15: 1ffff11005287084
FS:  0000000000000000(0000) GS:ffff8881260cc000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f228f6e7d60 CR3: 000000000dd36000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	39 e5                	cmp    %esp,%ebp
   2:	de f7                	fdivp  %st,%st(7)
   4:	c6 05 80 e2 87 05 01 	movb   $0x1,0x587e280(%rip)        # 0x587e28b
   b:	48 c7 c7 c0 88 7a 8c 	mov    $0xffffffff8c7a88c0,%rdi
  12:	be 97 05 00 00       	mov    $0x597,%esi
  17:	48 c7 c2 40 89 7a 8c 	mov    $0xffffffff8c7a8940,%rdx
  1e:	e8 4a 5d bd f7       	call   0xf7bd5d6d
  23:	4c 89 e3             	mov    %r12,%rbx
  26:	48 c1 eb 03          	shr    $0x3,%rbx
* 2a:	42 80 3c 2b 00       	cmpb   $0x0,(%rbx,%r13,1) <-- trapping instruction
  2f:	74 08                	je     0x39
  31:	4c 89 e7             	mov    %r12,%rdi
  34:	e8 04 da 40 f8       	call   0xf840da3d
  39:	4d 8b 2c 24          	mov    (%r12),%r13
  3d:	4d 39 f5             	cmp    %r14,%r13


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


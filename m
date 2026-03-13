Return-Path: <netdev+bounces-267573-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cPFeDf9qtGn9ngAAu9opvQ
	(envelope-from <netdev+bounces-267573-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 20:52:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CAA2F289772
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 20:52:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 393E63026901
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 19:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3782F1E1A3B;
	Fri, 13 Mar 2026 19:52:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC18C3B7B8C
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 19:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773431547; cv=none; b=e0Hvt46QgRBBZRSjzCGLeCg1itp3hpkEnmWzfHBL55Edy2BGf+MZHGKf5jIHfZZfxQDdn/AOL7PM8w5IOrUWCcVt5VaX0ASNlJPZXzz+l+pDymIcdL7TmJe/hlNQ9nRIfb37UQhy1qvOyCfd1KJHYXC9EWjX1iw2df3QipLJcYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773431547; c=relaxed/simple;
	bh=YApBVlUu+2S/kapEhJuQSZPcmgeIHWX8hy5i7qXFVqE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=c4IrVhxcScu0uwW4cP8OgsK2k8mlaVO3kLs+g52lNYpOIVr1trcb3Z8RrLWXEYTcwAA9EAmlTz/pLHZsxACxssNoGDKQ4/611CDVOyA0LiF+ROS1s70oKrpOYLaZqkGV7UhIgx+xbLwT8XRJojL6xoiatoi/7l2C6GOTi+07BBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-7d75b6b8500so24206658a34.2
        for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 12:52:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773431543; x=1774036343;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QlcCzVqc4HMaVVGRWjma4uIl3cVOYrUWB4AkvWKgRKQ=;
        b=WtAYUT5k5DfpYSxT1x+5KIOkPDSHycRgtEvgSi+9mJ/dVtc3t9ksUJQx6eSNMICGAC
         jhoVgWTo8madAxVYFB8zPTN/Lfh29chxuJ5PSMOBtqjlYejg7rmBKvCNIG52d4Sh+d69
         bSSle0LAegH2CbHIV1Y1qfL1VpFhPoE88wAIM+4URHFFbDzuPvwOKUwPF/0uyWrdZ26j
         JaEmTXVra9/3qItoA5AVyjCgxem0WjYSG3VDr0OWibjgZ27SGv3mMw1crAFiD+t0H1B4
         aTNfzbiOoQ0lGWQzI65cg+5HsgFPukv00qGQHzRRDfPpaPJMmZAX7prLnnZ4Viarxy4y
         a8NQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8u2eVDiMic6sndvtFbM9vI4Jg6flSkAWaphc8J7Ean364UzKx0Bw4td4dVJDhFJp1QjgXHCI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUQuqLLhgKfFZh7NG00B6foBa/Nta+s+PWdO4k6eDFH9xLUHZJ
	TGw09CVBllTt5zhsOrhzw1BreV4v5onk8e2MyjNXCu8IdS0EisIWByQkrGRBijRHUMIDooGvQMC
	P+syk9SzZOzo3ZWDP3WuRyMt+Xt4jr7ukFcHrwh7RgR6njHsFpdlOyC63c+4=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:1b05:b0:672:f683:7c54 with SMTP id
 006d021491bc7-67bdaa924a6mr3110120eaf.69.1773431543561; Fri, 13 Mar 2026
 12:52:23 -0700 (PDT)
Date: Fri, 13 Mar 2026 12:52:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69b46af7.050a0220.36eb34.000e.GAE@google.com>
Subject: [syzbot] [net?] general protection fault in bond_header_create
From: syzbot <syzbot+3d8bc31c45e11450f24c@syzkaller.appspotmail.com>
To: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	jv@jvosburgh.net, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=ccef46afa67b2b19];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_FROM(0.00)[bounces-267573-lists,netdev=lfdr.de,3d8bc31c45e11450f24c];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,appspotmail.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,goo.gl:url,googlegroups.com:email,storage.googleapis.com:url];
	REDIRECTOR_URL(0.00)[goo.gl];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: CAA2F289772
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

syzbot found the following issue on:

HEAD commit:    8004279c41ad Merge tag 'nfs-for-7.0-2' of git://git.linux-..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1593c416580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ccef46afa67b2b19
dashboard link: https://syzkaller.appspot.com/bug?extid=3d8bc31c45e11450f24c
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=172d1416580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-8004279c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f56a78af5be3/vmlinux-8004279c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/89a6ba48229d/bzImage-8004279c.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3d8bc31c45e11450f24c@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xe000080fee63d21a: 0000 [#1] SMP KASAN NOPTI
KASAN: probably user-memory-access in range [0x0000607f731e90d0-0x0000607f731e90d7]
CPU: 0 UID: 0 PID: 54 Comm: kworker/0:2 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Workqueue: mld mld_ifc_work
RIP: 0010:bond_header_create+0x150/0x300 drivers/net/bonding/bond_main.c:1524
Code: e8 25 bd 59 fb 45 85 f6 0f 84 a5 00 00 00 e8 d7 b8 59 fb eb 05 e8 d0 b8 59 fb 48 85 ed 0f 84 89 00 00 00 48 89 e8 48 c1 e8 03 <42> 80 3c 38 00 74 08 48 89 ef e8 71 81 c5 fb 48 8b 6d 00 4c 8d 75
RSP: 0018:ffffc90000b0f600 EFLAGS: 00010202
RAX: 00000c0fee63d21a RBX: ffffffff866bf37b RCX: ffff888000c524c0
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: 0000607f731e90d0 R08: ffffffff866bf37b R09: ffffffff8e75e420
R10: dffffc0000000000 R11: ffffffff866bf340 R12: 00000000000086dd
R13: ffff8880127763c0 R14: 0000000000000001 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff88808ca55000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f2fbfe3ff8c CR3: 0000000012645000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 dev_hard_header include/linux/netdevice.h:3439 [inline]
 neigh_connected_output+0x286/0x460 net/core/neighbour.c:1644
 __ip6_finish_output net/ipv6/ip6_output.c:-1 [inline]
 ip6_finish_output+0x2e5/0x740 net/ipv6/ip6_output.c:219
 NF_HOOK_COND include/linux/netfilter.h:307 [inline]
 ip6_output+0x340/0x550 net/ipv6/ip6_output.c:246
 dst_output include/net/dst.h:470 [inline]
 NF_HOOK+0x177/0x4f0 include/linux/netfilter.h:318
 mld_sendpack+0x8b4/0xe40 net/ipv6/mcast.c:1855
 mld_send_cr net/ipv6/mcast.c:2154 [inline]
 mld_ifc_work+0x835/0xe70 net/ipv6/mcast.c:2693
 process_one_work kernel/workqueue.c:3275 [inline]
 process_scheduled_works+0xb02/0x1830 kernel/workqueue.c:3358
 worker_thread+0xa50/0xfc0 kernel/workqueue.c:3439
 kthread+0x388/0x470 kernel/kthread.c:436
 ret_from_fork+0x51e/0xb90 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:bond_header_create+0x150/0x300 drivers/net/bonding/bond_main.c:1524
Code: e8 25 bd 59 fb 45 85 f6 0f 84 a5 00 00 00 e8 d7 b8 59 fb eb 05 e8 d0 b8 59 fb 48 85 ed 0f 84 89 00 00 00 48 89 e8 48 c1 e8 03 <42> 80 3c 38 00 74 08 48 89 ef e8 71 81 c5 fb 48 8b 6d 00 4c 8d 75
RSP: 0018:ffffc90000b0f600 EFLAGS: 00010202
RAX: 00000c0fee63d21a RBX: ffffffff866bf37b RCX: ffff888000c524c0
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: 0000607f731e90d0 R08: ffffffff866bf37b R09: ffffffff8e75e420
R10: dffffc0000000000 R11: ffffffff866bf340 R12: 00000000000086dd
R13: ffff8880127763c0 R14: 0000000000000001 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff88808ca55000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055e232d92000 CR3: 000000000e54c000 CR4: 0000000000352ef0
----------------
Code disassembly (best guess):
   0:	e8 25 bd 59 fb       	call   0xfb59bd2a
   5:	45 85 f6             	test   %r14d,%r14d
   8:	0f 84 a5 00 00 00    	je     0xb3
   e:	e8 d7 b8 59 fb       	call   0xfb59b8ea
  13:	eb 05                	jmp    0x1a
  15:	e8 d0 b8 59 fb       	call   0xfb59b8ea
  1a:	48 85 ed             	test   %rbp,%rbp
  1d:	0f 84 89 00 00 00    	je     0xac
  23:	48 89 e8             	mov    %rbp,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 80 3c 38 00       	cmpb   $0x0,(%rax,%r15,1) <-- trapping instruction
  2f:	74 08                	je     0x39
  31:	48 89 ef             	mov    %rbp,%rdi
  34:	e8 71 81 c5 fb       	call   0xfbc581aa
  39:	48 8b 6d 00          	mov    0x0(%rbp),%rbp
  3d:	4c                   	rex.WR
  3e:	8d                   	.byte 0x8d
  3f:	75                   	.byte 0x75


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


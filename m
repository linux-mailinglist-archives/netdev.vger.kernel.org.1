Return-Path: <netdev+bounces-263758-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cGK/J8ARqGmzngAAu9opvQ
	(envelope-from <netdev+bounces-263758-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 12:04:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BDFC1FEA4B
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 12:04:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 95AC23036D66
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 11:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEE3539FCA5;
	Wed,  4 Mar 2026 11:04:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D7A39F192
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 11:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772622269; cv=none; b=dbJ7Oz43sDByANOH4dQf/Gd7jeW6gF/xsrfCl4FOvMXZmmKV5hKNMLJW00wThQOcgojhBfG73Yf0Sq3z5SqJEDxmPOxmAgRdT+auIJKky/8ZGghJXGFF8caBU758nqXWaKUSSxSovJcm8mci4CQmqSQ39/47mU/0Os7gd+QLoLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772622269; c=relaxed/simple;
	bh=fr44pu6eP9IkM5YUt595mhZ3W4sn/W8ZQZsjYWWozEE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=rYHAcW96ieFZAxSdR8LvKNnHYE1IruZFIXDzMDolDbHd+cyUYFU0fKxqLkfmrsXE31Jas9IuCA4Y6O7HRpSBm+kZXlhyrMIzE5VMuPawng+Z78c9zj+gic7BNqPyXUTgJxzGOdw7uGGBF/qfa+1tPkUs7Ai5vuB+2mmk5ldWTE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-7d4bd83e456so76387163a34.2
        for <netdev@vger.kernel.org>; Wed, 04 Mar 2026 03:04:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772622265; x=1773227065;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U5WCXt9LsN66XnnTEurLe8lJmGdgFJdCpOL3D02k03o=;
        b=Uc+OrwWKJ0yEiEyE7U1SSf1B2NxnHR5EXdE0QoVon1yYThB45ITQwXxkx1iEkg+XNp
         e1+b6J/0ZdCz9ZZebNZDNnhFD5NOb9YBVa61u4hBUsYLEQnUKQPKa9bjND51tLywEE9D
         XfKFAUz2/ynpZkDzLI5bOI/w07HgFa6k1UEN8JG7w3227jn/FJPUTBYZih5i29RjzQRq
         4DZrYiSiSXq7dnGRCAJV6xaHQaAs7ObwwuhX5ioNlfdLC7AtVDaWLEcA7ww8awIFwPhC
         Iun0Kz8aH87gNfIuE2JeLI57XfkrQNnovJR8alWOI931uL37GzofVSL62pkdoCGJ05YN
         AxcA==
X-Forwarded-Encrypted: i=1; AJvYcCVP5RjNQQ6dReYOt93307rzls40pWVxonNvQJ3CmxS3JlO4HWwWVSK26bhOZjsBvzfJhylDXWM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFP/ODEZ/ucbpt6vzT3xeCZduieeZmBnGvjDb1mEm5NCpzLlxN
	sdPGMLrXsTilGGKwnYRn81inldxvxV6ybhdFeIFTKyQCB/g6penCq2RLRiB3fsZ2rOF4J4b9QJr
	9N999DEyFJVv+FIhYPeN3VAWDM99AoAluYoR6zvAOFi9A/5JofUnCPBGVClo=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:2208:b0:679:920a:9b73 with SMTP id
 006d021491bc7-67b176e81c1mr994302eaf.6.1772622265608; Wed, 04 Mar 2026
 03:04:25 -0800 (PST)
Date: Wed, 04 Mar 2026 03:04:25 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69a811b9.a70a0220.b118c.0019.GAE@google.com>
Subject: [syzbot] [net?] WARNING in u32_change (2)
From: syzbot <syzbot+d5ace703ed883df56e42@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	jhs@mojatatu.com, jiri@resnulli.us, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 0BDFC1FEA4B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=65722f41f7edc17e];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-263758-lists,netdev=lfdr.de,d5ace703ed883df56e42];
	SUBJECT_HAS_QUESTION(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,goo.gl:url,appspotmail.com:email,googlegroups.com:email,syzkaller.appspot.com:url]
X-Rspamd-Action: no action

Hello,

syzbot found the following issue on:

HEAD commit:    a95f71ad3e2e Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15c27c02580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=65722f41f7edc17e
dashboard link: https://syzkaller.appspot.com/bug?extid=d5ace703ed883df56e42
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12b189e6580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=134c0006580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-a95f71ad.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/cef9447ff4b5/vmlinux-a95f71ad.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a1176fe9ea48/bzImage-a95f71ad.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d5ace703ed883df56e42@syzkaller.appspotmail.com

netlink: 44 bytes leftover after parsing attributes in process `syz.0.17'.
------------[ cut here ]------------
memcpy: detected field-spanning write (size 32) of single field "&new->sel" at net/sched/cls_u32.c:855 (size 16)
WARNING: net/sched/cls_u32.c:855 at u32_init_knode net/sched/cls_u32.c:855 [inline], CPU#0: syz.0.17/5487
WARNING: net/sched/cls_u32.c:855 at u32_change+0x1da0/0x2720 net/sched/cls_u32.c:921, CPU#0: syz.0.17/5487
Modules linked in:
CPU: 0 UID: 0 PID: 5487 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:u32_init_knode net/sched/cls_u32.c:855 [inline]
RIP: 0010:u32_change+0x1daf/0x2720 net/sched/cls_u32.c:921
Code: 3d 4c eb 42 06 01 75 33 e8 0e 0e 0d f8 eb 50 e8 07 0e 0d f8 48 8d 3d 00 1f 68 06 b9 10 00 00 00 4c 89 f6 48 c7 c2 00 64 e1 8c <67> 48 0f b9 3a e9 af ee ff ff e8 e2 0d 0d f8 eb 24 e8 db 0d 0d f8
RSP: 0018:ffffc90004976fc0 EFLAGS: 00010293
RAX: ffffffff89b88e29 RBX: ffff888038a7c800 RCX: 0000000000000010
RDX: ffffffff8ce16400 RSI: 0000000000000020 RDI: ffffffff9020ad30
RBP: ffffc90004977178 R08: 0000000000000dc0 R09: 00000000ffffffff
R10: dffffc0000000000 R11: fffffbfff20232f7 R12: ffff888033a63ce8
R13: 0000000000000001 R14: 0000000000000020 R15: 0000000000000001
FS:  00005555621f5500(0000) GS:ffff88808ca5b000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffe0048eff8 CR3: 000000005563f000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 tc_new_tfilter+0xe1c/0x1630 net/sched/cls_api.c:2423
 rtnetlink_rcv_msg+0x7d5/0xbe0 net/core/rtnetlink.c:6958
 netlink_rcv_skb+0x232/0x4b0 net/netlink/af_netlink.c:2550
 netlink_unicast_kernel net/netlink/af_netlink.c:1318 [inline]
 netlink_unicast+0x80f/0x9b0 net/netlink/af_netlink.c:1344
 netlink_sendmsg+0x813/0xb40 net/netlink/af_netlink.c:1894
 sock_sendmsg_nosec net/socket.c:727 [inline]
 __sock_sendmsg net/socket.c:742 [inline]
 ____sys_sendmsg+0xa68/0xad0 net/socket.c:2592
 ___sys_sendmsg+0x2a5/0x360 net/socket.c:2646
 __sys_sendmmsg+0x27c/0x4e0 net/socket.c:2735
 __do_sys_sendmmsg net/socket.c:2762 [inline]
 __se_sys_sendmmsg net/socket.c:2759 [inline]
 __x64_sys_sendmmsg+0xa0/0xc0 net/socket.c:2759
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f78ead9c629
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff46c64d98 EFLAGS: 00000246 ORIG_RAX: 0000000000000133
RAX: ffffffffffffffda RBX: 00007f78eb015fa0 RCX: 00007f78ead9c629
RDX: 04000000000001f2 RSI: 0000200000000000 RDI: 0000000000000004
RBP: 00007f78eae32b39 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f78eb015fac R14: 00007f78eb015fa0 R15: 00007f78eb015fa0
 </TASK>
----------------
Code disassembly (best guess):
   0:	3d 4c eb 42 06       	cmp    $0x642eb4c,%eax
   5:	01 75 33             	add    %esi,0x33(%rbp)
   8:	e8 0e 0e 0d f8       	call   0xf80d0e1b
   d:	eb 50                	jmp    0x5f
   f:	e8 07 0e 0d f8       	call   0xf80d0e1b
  14:	48 8d 3d 00 1f 68 06 	lea    0x6681f00(%rip),%rdi        # 0x6681f1b
  1b:	b9 10 00 00 00       	mov    $0x10,%ecx
  20:	4c 89 f6             	mov    %r14,%rsi
  23:	48 c7 c2 00 64 e1 8c 	mov    $0xffffffff8ce16400,%rdx
* 2a:	67 48 0f b9 3a       	ud1    (%edx),%rdi <-- trapping instruction
  2f:	e9 af ee ff ff       	jmp    0xffffeee3
  34:	e8 e2 0d 0d f8       	call   0xf80d0e1b
  39:	eb 24                	jmp    0x5f
  3b:	e8 db 0d 0d f8       	call   0xf80d0e1b


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


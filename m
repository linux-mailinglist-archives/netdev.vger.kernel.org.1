Return-Path: <netdev+bounces-230968-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D1FEFBF271C
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 18:33:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC06418A5933
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 16:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9728824168D;
	Mon, 20 Oct 2025 16:32:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28FE2877CD
	for <netdev@vger.kernel.org>; Mon, 20 Oct 2025 16:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760977947; cv=none; b=W7EWoEyglA334M6c5GjcS0Plf3btZ//2qYKYRQ2Bhowiv/FhYlAAgbGDBgc7VAf36KGjkJ2fBrXIkkM7ye4EdHNHkOwkdCRiUJI6ePP3gDE3FtRabdhVAdjNaUMFEjMM/9rlZd51mvITXowJcMF+CJiNir4qBCjy2UKLJRWSq5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760977947; c=relaxed/simple;
	bh=600z495s1evJI1EY+NvxTALOA87tlhM1kkoyIBG7QkE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=i0ubRAu00Wwg7vZzdwcklpPIOjsANa11oS/KpvL+jHi/LHkpXeXMBM2tafl5vGiVBaJnm0QKb1W+rB0OGCjyrOcKFlFTLSbgNS4GAe0vRKrxUtlyG5nGm2+xC/qIHUAiPGWTtVl+K38pT9eJ3RjinDMgaKoaNpHBr5CWK7X5xyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-430c316fcb3so144060225ab.2
        for <netdev@vger.kernel.org>; Mon, 20 Oct 2025 09:32:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760977945; x=1761582745;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Rd8P69Nzz5SWptPrMJydUZ06mU/1xOSEFcFBQAWHEU0=;
        b=VM9v+Z2bqoO4p/svvPqqfZ+E93yyFuBKfCKep/oN4UeIbeLn6xUr0jOJLTG/NqZNjB
         Nhqzpy7RH6Yrd7tFexskKOjwXDzUkFVKyNA6cAJsAzU/REnk9rTc5gpW2h4uaT+TGIQj
         xVL3RAn9FUOwxjUs03YWf/tEmqp+CzGbK9yGvJ9buBpc1nCjuWRQ3WTy21jmeyl9DWzc
         uY0TTWieuUCZlwJcST439P/A0DZecT0P8rN7mHCxr6QgpFOsNwuWDo59R+vIhE8rgPIK
         C3eNo3dDdZZGzswYUdrhh5X6GjHd2XPEK5o2ajNSeQCZi931MncOTfK/eRyEbTubf5Ko
         sX3g==
X-Forwarded-Encrypted: i=1; AJvYcCUZ9I2Ytn3EMUJQcXOL3VObtDNsyfcdD2C2rR4YV8lXB2lkpV+YwkA9iHZjXEzEQN/ld+IPHhg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzttS1CMbAINJCZSVR23W/HGLq4PTNIV+D/APJEjxj+b7V1vDz8
	Wa+246ZqBDZvwFc2+TLwmnSHOJ3lB7QUEP6cYphZFDtEZYTtI145c7j5SfYbIU6sZKWNC0Vch94
	vLonL1BEammbZld5AS/81uR9RPYS39TvLMFqjTxvz0fmivJz89pGCa1HODec=
X-Google-Smtp-Source: AGHT+IH9e773xcK/yfQuSVUm4VHLKMYJTqheKgYug7CM7N/z7rmd26+pLNXizdzEx/RMXH+hrFyUziwbbvN4s5Cl8r1RO4ONjlrz
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c24f:0:b0:427:6e7f:89f8 with SMTP id
 e9e14a558f8ab-430c5263cfdmr218212525ab.10.1760977944839; Mon, 20 Oct 2025
 09:32:24 -0700 (PDT)
Date: Mon, 20 Oct 2025 09:32:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f66418.050a0220.91a22.044d.GAE@google.com>
Subject: [syzbot] [net?] kernel BUG in ipgre_header (3)
From: syzbot <syzbot+a2a3b519de727b0f7903@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    561c80369df0 Merge tag 'tty-6.16-rc1-2' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=114649a2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e143c1cd9dadd720
dashboard link: https://syzkaller.appspot.com/bug?extid=a2a3b519de727b0f7903
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1215b1a2580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=106c01a2580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-561c8036.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0e51e7b3acac/vmlinux-561c8036.xz
kernel image: https://storage.googleapis.com/syzbot-assets/431bb38ff9e1/bzImage-561c8036.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a2a3b519de727b0f7903@syzkaller.appspotmail.com

skbuff: skb_under_panic: text:ffffffff8a12f557 len:1304825492 put:1304825396 head:ffff888044b36000 data:ffff887ff6ed528c tail:0x120 end:0x6c0 dev:team0
------------[ cut here ]------------
kernel BUG at net/core/skbuff.c:211!
Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 9 Comm: kworker/0:0 Not tainted 6.16.0-syzkaller-12256-g561c80369df0 #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Workqueue: mld mld_ifc_work
RIP: 0010:skb_panic+0x157/0x160 net/core/skbuff.c:211
Code: c7 40 f9 93 8c 48 8b 74 24 08 48 8b 54 24 10 8b 0c 24 44 8b 44 24 04 4d 89 e9 50 55 41 57 41 56 e8 5e 0d f5 ff 48 83 c4 20 90 <0f> 0b cc cc cc cc cc cc cc 90 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffc900001b7418 EFLAGS: 00010286
RAX: 0000000000000097 RBX: dffffc0000000000 RCX: b46b6e5b0ea16b00
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: 00000000000006c0 R08: ffffc900001b7127 R09: 1ffff92000036e24
R10: dffffc0000000000 R11: fffff52000036e25 R12: ffff888043e08a10
R13: ffff888044b36000 R14: ffff887ff6ed528c R15: 0000000000000120
FS:  0000000000000000(0000) GS:ffff88808d211000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000c004aec000 CR3: 0000000059814000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 skb_under_panic net/core/skbuff.c:221 [inline]
 skb_push+0xc3/0xe0 net/core/skbuff.c:2601
 ipgre_header+0x67/0x290 net/ipv4/ip_gre.c:895
 dev_hard_header include/linux/netdevice.h:3412 [inline]
 neigh_connected_output+0x286/0x460 net/core/neighbour.c:1619
 neigh_output include/net/neighbour.h:547 [inline]
 ip6_finish_output2+0x11fb/0x16a0 net/ipv6/ip6_output.c:141
 __ip6_finish_output net/ipv6/ip6_output.c:-1 [inline]
 ip6_finish_output+0x234/0x7d0 net/ipv6/ip6_output.c:226
 NF_HOOK+0x9e/0x380 include/linux/netfilter.h:318
 mld_sendpack+0x800/0xd80 net/ipv6/mcast.c:1860
 mld_send_cr net/ipv6/mcast.c:2159 [inline]
 mld_ifc_work+0x83e/0xd60 net/ipv6/mcast.c:2698
 process_one_work kernel/workqueue.c:3236 [inline]
 process_scheduled_works+0xade/0x17b0 kernel/workqueue.c:3319
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3400
 kthread+0x70e/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:skb_panic+0x157/0x160 net/core/skbuff.c:211
Code: c7 40 f9 93 8c 48 8b 74 24 08 48 8b 54 24 10 8b 0c 24 44 8b 44 24 04 4d 89 e9 50 55 41 57 41 56 e8 5e 0d f5 ff 48 83 c4 20 90 <0f> 0b cc cc cc cc cc cc cc 90 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffc900001b7418 EFLAGS: 00010286
RAX: 0000000000000097 RBX: dffffc0000000000 RCX: b46b6e5b0ea16b00
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: 00000000000006c0 R08: ffffc900001b7127 R09: 1ffff92000036e24
R10: dffffc0000000000 R11: fffff52000036e25 R12: ffff888043e08a10
R13: ffff888044b36000 R14: ffff887ff6ed528c R15: 0000000000000120
FS:  0000000000000000(0000) GS:ffff88808d211000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000c004af0000 CR3: 0000000000e16000 CR4: 0000000000352ef0


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


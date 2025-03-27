Return-Path: <netdev+bounces-177906-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE34A72D33
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 11:01:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D3BA3A73C8
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 10:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6757C20DD6D;
	Thu, 27 Mar 2025 10:01:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8A41B81C1
	for <netdev@vger.kernel.org>; Thu, 27 Mar 2025 10:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743069692; cv=none; b=DMXJLudD1KiAQHWDayiM+wQkRy9IQztPHCvdKgNpft1xZbF40xQ27f0D1/O1xSxjmsWU0AFUs0ePOg//bcY8DtCmcQcoVSTF8lmHHF7vP8VE9Dm1HEEX/HH6e+5kXrvgbbP2bGFwk7VexemtETUAOAfl0qCnEeMUCBxGNTojwHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743069692; c=relaxed/simple;
	bh=j1u/b6iCpo77sQix5aePB/OgDjxe3cQtEhK8F+Ct0bs=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Mz/asg6WEIFztL6SV6U6fqDteRuHvTFSu4DpkMv9UjEB7F1xFZruH7dymamjEqr8DAIfWPm4PmV/tUj7Iw17BccmJqwv2ubR5AX5Ln6yJP/lKXn1LU5khbBSABMtsC2Xv6rs45OSay2nofDyTXxEytoy+eFFRPIFfG3oljSEjqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3d5b3819ff9so7264625ab.0
        for <netdev@vger.kernel.org>; Thu, 27 Mar 2025 03:01:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743069690; x=1743674490;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9FCTDFjot83WRhacSWxYLmYj5o4MLFgu3vOAVYbujYg=;
        b=FgmL3y2kep4EBlVq4M7dX1ryv9NuMaau1L/mCTjvaRj1VdCE3xhpYXvgtnyUlH5ig4
         jbLK3BdodD/TuEONbLawgiKr4CPjx9LOkAcROGKcu5aiJdwT2uZeXvHr6ZchOn6LAYvn
         0hnlIhci6cVBTbFyCwXOHEsS5mEYHJnGQVB1eRGcGLHS/XOD5RA+NXjeAF+Y3JSvUbmq
         XQ/xRcSoralsPYMEBq8W9TWWujXKoQDW3B4gzu3J1yls8Kq5WHyxuendCrGry1bxZhF5
         WDIYw3W3Vpvu/TtjoO1hwSptD9pPDRhyTxg3gMFi29WWv8VctohEPmDbP6ad/WeOmpl6
         J7FQ==
X-Forwarded-Encrypted: i=1; AJvYcCWPhne7v5BzdenVrV+dO07uZ6ZdE2gRd9JkrmgPmMkv7HHjihYZ7UkTf9pY717hSRSGTV4SlwE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9yFPlV+lUvL7j6dzO+XMT4AxxpbCPyopn24lSDneIdXx7X7hS
	GfSDYM/BQ5VCm474ztt9eNXkXWtnhPKlYfYRHbrzWyW7LyvgdQ4k/TogXP9LAAF1YDi6bArZr7F
	YKQNb0zIwirhtfLVJwLsaKjkPLRk8BeK5fBt4zTxSye1oAWSrZn1Bz9o=
X-Google-Smtp-Source: AGHT+IFoLzbWRAGxKnp3Q6LF8u6vpecr4X5rw2S7Dfi5RcsMZULrf0k/LG9uP0ha6SzXHmOTVZxaiPIg6mVyBWNbag8BbF2FfSyj
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2192:b0:3d3:eeec:89f3 with SMTP id
 e9e14a558f8ab-3d5ccdd5473mr31428105ab.13.1743069689682; Thu, 27 Mar 2025
 03:01:29 -0700 (PDT)
Date: Thu, 27 Mar 2025 03:01:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67e521f9.050a0220.2f068f.0026.GAE@google.com>
Subject: [syzbot] [net?] kernel BUG in skbprio_enqueue
From: syzbot <syzbot+a3422a19b05ea96bee18@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	jhs@mojatatu.com, jiri@resnulli.us, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com, xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    f6e0150b2003 Merge tag 'mtd/for-6.15' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13a14a4c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=46a07195688b794b
dashboard link: https://syzkaller.appspot.com/bug?extid=a3422a19b05ea96bee18
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=109e343f980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1037abb0580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-f6e0150b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7ade4c34c9b1/vmlinux-f6e0150b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/1fe37b97ec9d/bzImage-f6e0150b.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a3422a19b05ea96bee18@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at net/sched/sch_skbprio.c:127!
Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 5396 Comm: kworker/0:11 Not tainted 6.14.0-syzkaller-03565-gf6e0150b2003 #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Workqueue: mld mld_ifc_work
RIP: 0010:skbprio_enqueue+0x1123/0x1150 net/sched/sch_skbprio.c:127
Code: 4c 89 fe e8 df 18 28 fb 4c 8b 6c 24 10 48 ba 00 00 00 00 00 fc ff df e9 87 f5 ff ff e8 76 2c b6 f7 90 0f 0b e8 6e 2c b6 f7 90 <0f> 0b 89 f9 80 e1 07 80 c1 03 38 c1 7c 88 e8 aa 58 1e f8 eb 81 89
RSP: 0018:ffffc9000d9de960 EFLAGS: 00010293
RAX: ffffffff8a0d4a22 RBX: 0000000000000002 RCX: ffff88801ed8a440
RDX: 0000000000000000 RSI: 0000000000000002 RDI: 0000000000000001
RBP: 0000000000000000 R08: ffffffff8a0d41e8 R09: 0000000000000000
R10: ffff888043706c80 R11: ffffed10086e0d92 R12: ffff8880493798c0
R13: ffff888049378000 R14: 000000000000008e R15: ffff888049379dc0
FS:  0000000000000000(0000) GS:ffff88808c824000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fb035bc92f0 CR3: 000000000e938000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 qdisc_enqueue include/net/sch_generic.h:850 [inline]
 tbf_enqueue+0x362/0x6e0 net/sched/sch_tbf.c:258
 dev_qdisc_enqueue+0x4b/0x290 net/core/dev.c:4008
 __dev_xmit_skb net/core/dev.c:4104 [inline]
 __dev_queue_xmit+0xf13/0x3f60 net/core/dev.c:4618
 dev_queue_xmit include/linux/netdevice.h:3313 [inline]
 neigh_hh_output include/net/neighbour.h:523 [inline]
 neigh_output include/net/neighbour.h:537 [inline]
 ip_finish_output2+0xcd5/0x12e0 net/ipv4/ip_output.c:236
 iptunnel_xmit+0x560/0x9c0 net/ipv4/ip_tunnel_core.c:82
 udp_tunnel_xmit_skb+0x264/0x3c0 net/ipv4/udp_tunnel_core.c:173
 geneve_xmit_skb drivers/net/geneve.c:916 [inline]
 geneve_xmit+0x2119/0x2c30 drivers/net/geneve.c:1039
 __netdev_start_xmit include/linux/netdevice.h:5151 [inline]
 netdev_start_xmit include/linux/netdevice.h:5160 [inline]
 xmit_one net/core/dev.c:3800 [inline]
 dev_hard_start_xmit+0x27a/0x7d0 net/core/dev.c:3816
 __dev_queue_xmit+0x1b80/0x3f60 net/core/dev.c:4652
 dev_queue_xmit include/linux/netdevice.h:3313 [inline]
 neigh_hh_output include/net/neighbour.h:523 [inline]
 neigh_output include/net/neighbour.h:537 [inline]
 ip6_finish_output2+0x128c/0x17e0 net/ipv6/ip6_output.c:141
 __ip6_finish_output net/ipv6/ip6_output.c:-1 [inline]
 ip6_finish_output+0x421/0x840 net/ipv6/ip6_output.c:226
 NF_HOOK+0xa0/0x440 include/linux/netfilter.h:314
 mld_sendpack+0x84a/0xdb0 net/ipv6/mcast.c:1868
 mld_send_cr net/ipv6/mcast.c:2169 [inline]
 mld_ifc_work+0x7d9/0xd90 net/ipv6/mcast.c:2702
 process_one_work kernel/workqueue.c:3238 [inline]
 process_scheduled_works+0xac3/0x18e0 kernel/workqueue.c:3319
 worker_thread+0x870/0xd30 kernel/workqueue.c:3400
 kthread+0x7a9/0x920 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:153
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:skbprio_enqueue+0x1123/0x1150 net/sched/sch_skbprio.c:127
Code: 4c 89 fe e8 df 18 28 fb 4c 8b 6c 24 10 48 ba 00 00 00 00 00 fc ff df e9 87 f5 ff ff e8 76 2c b6 f7 90 0f 0b e8 6e 2c b6 f7 90 <0f> 0b 89 f9 80 e1 07 80 c1 03 38 c1 7c 88 e8 aa 58 1e f8 eb 81 89
RSP: 0018:ffffc9000d9de960 EFLAGS: 00010293
RAX: ffffffff8a0d4a22 RBX: 0000000000000002 RCX: ffff88801ed8a440
RDX: 0000000000000000 RSI: 0000000000000002 RDI: 0000000000000001
RBP: 0000000000000000 R08: ffffffff8a0d41e8 R09: 0000000000000000
R10: ffff888043706c80 R11: ffffed10086e0d92 R12: ffff8880493798c0
R13: ffff888049378000 R14: 000000000000008e R15: ffff888049379dc0
FS:  0000000000000000(0000) GS:ffff88808c824000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fb035bc92f0 CR3: 000000000e938000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


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


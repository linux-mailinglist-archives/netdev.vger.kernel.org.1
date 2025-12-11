Return-Path: <netdev+bounces-244414-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4438ACB6C6D
	for <lists+netdev@lfdr.de>; Thu, 11 Dec 2025 18:41:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1FF25301D9DE
	for <lists+netdev@lfdr.de>; Thu, 11 Dec 2025 17:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 107742D373F;
	Thu, 11 Dec 2025 17:32:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f77.google.com (mail-ot1-f77.google.com [209.85.210.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F4D244694
	for <netdev@vger.kernel.org>; Thu, 11 Dec 2025 17:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765474351; cv=none; b=AaRiOQR514vO8ILRvx9cGf6ckC+CvT403oD3RgBHxJ6pbEkCe2FCx+WSnyRtQwh4Y0khKRMw4hOi6UeUaKIZiR89KCA2toOvYjE8Nwt2q1D/LFkQ1HNLX9WdJSodfwxMMQRB2owuel9BGBJ8tS7jdk7fjlVrpLA/UD5TKqHiemQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765474351; c=relaxed/simple;
	bh=Pq2Bw2DWrShWwJl/egUoA7fuK84IsjNOXi32yyWsPzU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=EVXujt4QTYaxvGN+J8N0bK0yANquElY+3/XRZyOtA4uC2HxwXKXNmLX5QtWo5oCHbrehFxFhiRh3dHoEKkhGFT5esLFOqigH8sc3rujZde5a5yadbr2Q/J3OrTq4CoXbhVTG6KsA2jvVWYq/k5fbMOHs9GcEZo9o8twZe1X08Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f77.google.com with SMTP id 46e09a7af769-7c76977192eso786618a34.3
        for <netdev@vger.kernel.org>; Thu, 11 Dec 2025 09:32:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765474348; x=1766079148;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Rjf4r/ZxuzJlSfdg0JcN02rQUYZIDar/whNi6MdTSy4=;
        b=j2+gKHOTiK9lF2cGDXJiwFbZGPWMk17o5jyhvBKFtKxbXl3HnIekxEtwpS8Q7+xU3l
         m5XuTFKLBuRqL5+Vs1Hp8LpnZd58dsm/K5WwxW7nlXUVPYmHcj+hw38jARhv43LqYr9l
         e7AHhGRMXJNEv0Yu6w5iAG/1qwGaaryF6Qtxxsou1YtTutZ9+3169efWgmn/8Qsa/6jb
         fzgtV4oxijVcynB18yl59MjykdqaH1oIPJGbPAgWAu8etleuJ2MCY4161qRdLdGECNQa
         vXzU4JKEnqXsHPy7KxIrT7qTNia4BRqYk9cJbdthZ6QR8B2p42bWmUTbl5FCZolEJMgS
         ekmw==
X-Forwarded-Encrypted: i=1; AJvYcCXJZECnKc98oxOqOD68SV7beL6i6ujm8F87YowWHfCVQSOr6yK6s6Ki2IVxG2OP3syk5ybqQk0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkUYMgkey7AWoADjKeSvFreQQ8ydLNv8kp+3l7nUS+U+xRneP3
	nFjzKrFOwH2Hf+/GdUOg+WDm9MqaLgDXu4cSeZ9ciZRSDhhoGSclKQXnU3oskiKNQ2FNlZpOyMG
	pEkLRT4GcJBjWv4GnQmOYEKbLhupd7IK5xiXIqukhYKaCpkY+Qpag8VW7HC4=
X-Google-Smtp-Source: AGHT+IFF/RBlHj0qSF5akM0pBM8P+n68absJ+JwHZ3udSAtc6jvYVyO4KXuQW1F9AZF7kCKFxVQVD1ozXX5rt/fep6S8SZT9nAPn
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:2905:b0:659:9a49:8f25 with SMTP id
 006d021491bc7-65b2ad474f5mr3676704eaf.54.1765474348184; Thu, 11 Dec 2025
 09:32:28 -0800 (PST)
Date: Thu, 11 Dec 2025 09:32:28 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <693b002c.a70a0220.33cd7b.0033.GAE@google.com>
Subject: [syzbot] [net?] kernel BUG in ip6gre_header (6)
From: syzbot <syzbot+43a2ebcf2a64b1102d64@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    2061f18ad76e Merge tag 'caps-pr-20251204' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10cb0992580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=eaa3e2adda258a7
dashboard link: https://syzkaller.appspot.com/bug?extid=43a2ebcf2a64b1102d64
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14e5dc1a580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11fe021a580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-2061f18a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/28ad059bceaa/vmlinux-2061f18a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/747fcec76ac7/bzImage-2061f18a.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+43a2ebcf2a64b1102d64@syzkaller.appspotmail.com

skbuff: skb_under_panic: text:ffffffff8a1d69a8 len:136 put:40 head:ffff888059bc7000 data:ffff888059bc6fe8 tail:0x70 end:0x6c0 dev:team0
------------[ cut here ]------------
kernel BUG at net/core/skbuff.c:213!
Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 9 Comm: kworker/0:0 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Workqueue: mld mld_ifc_work
RIP: 0010:skb_panic+0x157/0x160 net/core/skbuff.c:213
Code: c7 e0 1a 6f 8c 48 8b 74 24 08 48 8b 54 24 10 8b 0c 24 44 8b 44 24 04 4d 89 e9 50 55 41 57 41 56 e8 8e 94 f5 ff 48 83 c4 20 90 <0f> 0b cc cc cc cc cc cc cc 90 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffc900001b7280 EFLAGS: 00010282
RAX: 0000000000000087 RBX: dffffc0000000000 RCX: 98444bb9450e1700
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: 00000000000006c0 R08: ffffc900001b6f87 R09: 1ffff92000036df0
R10: dffffc0000000000 R11: fffff52000036df1 R12: ffff88804ce8add0
R13: ffff888059bc7000 R14: ffff888059bc6fe8 R15: 0000000000000070
FS:  0000000000000000(0000) GS:ffff88808d683000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055555bb765c8 CR3: 000000001fd7c000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 skb_under_panic net/core/skbuff.c:223 [inline]
 skb_push+0xc3/0xe0 net/core/skbuff.c:2641
 ip6gre_header+0xc8/0x790 net/ipv6/ip6_gre.c:1371
 dev_hard_header include/linux/netdevice.h:3436 [inline]
 neigh_connected_output+0x286/0x460 net/core/neighbour.c:1618
 neigh_output include/net/neighbour.h:556 [inline]
 ip6_finish_output2+0xfb3/0x1480 net/ipv6/ip6_output.c:136
 __ip6_finish_output net/ipv6/ip6_output.c:-1 [inline]
 ip6_finish_output+0x234/0x7d0 net/ipv6/ip6_output.c:220
 NF_HOOK_COND include/linux/netfilter.h:307 [inline]
 ip6_output+0x340/0x550 net/ipv6/ip6_output.c:247
 NF_HOOK+0x9e/0x380 include/linux/netfilter.h:318
 mld_sendpack+0x8d4/0xe60 net/ipv6/mcast.c:1855
 mld_send_cr net/ipv6/mcast.c:2154 [inline]
 mld_ifc_work+0x83e/0xd60 net/ipv6/mcast.c:2693
 process_one_work kernel/workqueue.c:3257 [inline]
 process_scheduled_works+0xad1/0x1770 kernel/workqueue.c:3340
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3421
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x599/0xb30 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:skb_panic+0x157/0x160 net/core/skbuff.c:213
Code: c7 e0 1a 6f 8c 48 8b 74 24 08 48 8b 54 24 10 8b 0c 24 44 8b 44 24 04 4d 89 e9 50 55 41 57 41 56 e8 8e 94 f5 ff 48 83 c4 20 90 <0f> 0b cc cc cc cc cc cc cc 90 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffc900001b7280 EFLAGS: 00010282
RAX: 0000000000000087 RBX: dffffc0000000000 RCX: 98444bb9450e1700
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: 00000000000006c0 R08: ffffc900001b6f87 R09: 1ffff92000036df0
R10: dffffc0000000000 R11: fffff52000036df1 R12: ffff88804ce8add0
R13: ffff888059bc7000 R14: ffff888059bc6fe8 R15: 0000000000000070
FS:  0000000000000000(0000) GS:ffff88808d683000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffc5c02a230 CR3: 000000003b4e8000 CR4: 0000000000352ef0


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


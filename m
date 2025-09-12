Return-Path: <netdev+bounces-222441-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 799E0B5437A
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 09:06:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E2054473A9
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 07:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 217B328725A;
	Fri, 12 Sep 2025 07:06:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CBC123D7CA
	for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 07:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757660792; cv=none; b=RQh0HMKtj10nJBKaxdO84+3gGzr5CuBhAvkKQWzH0erGUdQTHxh0BMbyxGYMRybQlILEaFYde/A1KsFv3HU7li1eBVUhSTHCMasCR6NgmpC0LwLiGPEFtp4Fl+XLKDmSKg6Ru9gkMv1fq2dUinOsfPBGeWBeDv1A5YeOaep/YQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757660792; c=relaxed/simple;
	bh=RwHOLyhs5q8fB4z9idz6A/n+Ucus3xYu6vE3rzPaEfU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=o2Id8biPWlxF8pYmtHPGhYG8OP845dE+FlA25LQ5Pv67P4X+T0REeFHDWwdfk+RS7bSQ77jxyIn51l7qdxo0f/xAd/1aZZKNUKQkjsycC21ktQJPXHjdU2pai3MeXGpzJSDkW3oCmhxGi8p4K9Hs4C5XU9jGD3uaEm9OJQENbaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-406d2dab9b0so23709685ab.3
        for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 00:06:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757660789; x=1758265589;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lg7ihBhpULDxOBRw5vjahIiuuwSlCIhJvniZyUe7xQU=;
        b=svphAbjvTLsOQmaEzMuoj2FIw+F0eFwImFE+4A5HRqr4sglzQ2UTUaGmhFuhr8I0mY
         snTioQ0SHjAcdX9qyRVWNNRWBHv82lvdFbXliJrMk0OirXbig2zC5j6V/kCnJohNZDAW
         RX3DXk3h4gQmUKFXVfRkZAfSWhehihh1nXAz338qtCuAVqfwKQEEh/NVY43cs/oqV0lz
         kNwpIpDrM3ZtaEagYpdAMlCbwv1Kl5wr52k7COdntcGmYwMTmMB8VezIsBUlmmLmtApb
         oUn5r6joUdm0U+VdoHqkshsWe9tFhqOLuW7YyZDp7UhiENGvwASXOEz+qEfzKoVkqmnV
         fRTQ==
X-Forwarded-Encrypted: i=1; AJvYcCXpgz0vahRE/12et8E5J9I/ebh6Cgo9nsThJLj0CBxyD+lo0d81ZDdwJd5oDcTPMSDoJinthzo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRYCJvX3OOZ6Q0oisEEurCjX0UXNLxvbQzwVltKo/Jl2cWV27l
	6LQZXSmd64ovdzjcAI3oPL6IFxdaMZpxCn4n4mAfJ1Au5QBMb0IX9oI71jaMlj/8pdCn818fEV0
	fEMjB08zNjlv4FL+FV5cit+JDCaQS2Ie64W71qMa7qWuEjwkRGMEJNBt4zpk=
X-Google-Smtp-Source: AGHT+IGIVGU1dUETB6N5aiBqc/hnnsefPsTbymdoGA7QbpDBRHggxm8iX2/+W+qLKreBp4CKNdD4ULo6KEh/w3zy6CxlBL99+ltO
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a2c:b0:40c:50c:376 with SMTP id
 e9e14a558f8ab-420a4c0378bmr29448695ab.26.1757660789612; Fri, 12 Sep 2025
 00:06:29 -0700 (PDT)
Date: Fri, 12 Sep 2025 00:06:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68c3c675.050a0220.2ff435.0353.GAE@google.com>
Subject: [syzbot] [net?] BUG: corrupted list in flow_block_cb_setup_simple
From: syzbot <syzbot+5a66db916cdde0dbcc1c@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    e59a039119c3 Merge tag 's390-6.17-4' of git://git.kernel.o..
git tree:       bpf
console output: https://syzkaller.appspot.com/x/log.txt?x=1523e934580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4d8792ecb6308d0f
dashboard link: https://syzkaller.appspot.com/bug?extid=5a66db916cdde0dbcc1c
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16d4bd62580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10d69642580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/324da524bbd8/disk-e59a0391.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0fa38e1d54f4/vmlinux-e59a0391.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b1ea8074daa0/bzImage-e59a0391.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5a66db916cdde0dbcc1c@syzkaller.appspotmail.com

 non-slab/vmalloc memory
list_del corruption. prev->next should be ffff888077fdb100, but was ffffffff8edac9a0. (prev=ffffffff8edac9a0)
------------[ cut here ]------------
kernel BUG at lib/list_debug.c:64!
Oops: invalid opcode: 0000 [#1] SMP KASAN PTI
CPU: 0 UID: 0 PID: 6449 Comm: syz.3.301 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
RIP: 0010:__list_del_entry_valid_or_report+0x15a/0x190 lib/list_debug.c:62
Code: e8 4b a5 31 fd 43 80 3c 2c 00 74 08 4c 89 ff e8 1c 9d 52 fd 49 8b 17 48 c7 c7 a0 40 e3 8b 48 89 de 4c 89 f9 e8 07 0b 57 fc 90 <0f> 0b 4c 89 f7 e8 1c a5 31 fd 43 80 3c 2c 00 74 08 4c 89 ff e8 ed
RSP: 0018:ffffc90003f4e760 EFLAGS: 00010246
RAX: 000000000000006d RBX: ffff888077fdb100 RCX: 21dc4908dd936700
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: 1ffff920007e9d3e R08: ffffc90003f4e487 R09: 1ffff920007e9c90
R10: dffffc0000000000 R11: fffff520007e9c91 R12: 1ffffffff1db5934
R13: dffffc0000000000 R14: ffffffff8edac9a0 R15: ffffffff8edac9a0
FS:  00005555769e1500(0000) GS:ffff888125c15000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000200000000380 CR3: 0000000030806000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 __list_del_entry_valid include/linux/list.h:124 [inline]
 __list_del_entry include/linux/list.h:215 [inline]
 list_del include/linux/list.h:229 [inline]
 flow_block_cb_setup_simple+0x62d/0x740 net/core/flow_offload.c:369
 nft_block_offload_cmd net/netfilter/nf_tables_offload.c:397 [inline]
 nft_chain_offload_cmd+0x290/0x660 net/netfilter/nf_tables_offload.c:451
 nft_flow_block_chain net/netfilter/nf_tables_offload.c:471 [inline]
 nft_flow_offload_chain net/netfilter/nf_tables_offload.c:513 [inline]
 nft_flow_rule_offload_commit+0x40d/0x1b60 net/netfilter/nf_tables_offload.c:592
 nf_tables_commit+0x675/0x8700 net/netfilter/nf_tables_api.c:10933
 nfnetlink_rcv_batch net/netfilter/nfnetlink.c:574 [inline]
 nfnetlink_rcv_skb_batch net/netfilter/nfnetlink.c:647 [inline]
 nfnetlink_rcv+0x1a4e/0x2520 net/netfilter/nfnetlink.c:665
 netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
 netlink_unicast+0x82f/0x9e0 net/netlink/af_netlink.c:1346
 netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1896
 sock_sendmsg_nosec net/socket.c:714 [inline]
 __sock_sendmsg+0x219/0x270 net/socket.c:729
 ____sys_sendmsg+0x505/0x830 net/socket.c:2614
 ___sys_sendmsg+0x21f/0x2a0 net/socket.c:2668
 __sys_sendmsg net/socket.c:2700 [inline]
 __do_sys_sendmsg net/socket.c:2705 [inline]
 __se_sys_sendmsg net/socket.c:2703 [inline]
 __x64_sys_sendmsg+0x19b/0x260 net/socket.c:2703
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fe1b0d8eba9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc23fb3798 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007fe1b0fd5fa0 RCX: 00007fe1b0d8eba9
RDX: 000000000000c050 RSI: 0000200000000cc0 RDI: 0000000000000003
RBP: 00007fe1b0e11e19 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fe1b0fd5fa0 R14: 00007fe1b0fd5fa0 R15: 0000000000000003
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__list_del_entry_valid_or_report+0x15a/0x190 lib/list_debug.c:62
Code: e8 4b a5 31 fd 43 80 3c 2c 00 74 08 4c 89 ff e8 1c 9d 52 fd 49 8b 17 48 c7 c7 a0 40 e3 8b 48 89 de 4c 89 f9 e8 07 0b 57 fc 90 <0f> 0b 4c 89 f7 e8 1c a5 31 fd 43 80 3c 2c 00 74 08 4c 89 ff e8 ed
RSP: 0018:ffffc90003f4e760 EFLAGS: 00010246
RAX: 000000000000006d RBX: ffff888077fdb100 RCX: 21dc4908dd936700
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: 1ffff920007e9d3e R08: ffffc90003f4e487 R09: 1ffff920007e9c90
R10: dffffc0000000000 R11: fffff520007e9c91 R12: 1ffffffff1db5934
R13: dffffc0000000000 R14: ffffffff8edac9a0 R15: ffffffff8edac9a0
FS:  00005555769e1500(0000) GS:ffff888125c15000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000200000000380 CR3: 0000000030806000 CR4: 00000000003526f0


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


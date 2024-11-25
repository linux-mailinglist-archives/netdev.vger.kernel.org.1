Return-Path: <netdev+bounces-147174-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12CE49D7D85
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 09:53:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C756B281FF9
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 08:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CEAD18D649;
	Mon, 25 Nov 2024 08:53:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8216718C03D
	for <netdev@vger.kernel.org>; Mon, 25 Nov 2024 08:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732524804; cv=none; b=Q74qjB14jIPNJLFlz3qxez4fLCiZ+72CuaBvUVbbojG3LMjw2+Pm/+wiImNST9iT9ZzYpMSCJK0ZQkK0IZ1Nnvn0XwuU3qTuJEfT4boPb4Bc8fW13Z0wUpzohf1UdGerpTH7KUIsqvCkgCVScvKJII2kM7EdTUCpCQFaUu46qYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732524804; c=relaxed/simple;
	bh=WFSYxKjNoqoc71sZPnJSNpqbOFw8ioopiUEot2ZkEuU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=skJQOXP4l5ax+o/8PnhBh/5E6qPb+5BTPK06+jUeL5ZQB7L7yriszKNEbqBZ5T/m6TUHBP7Ozl0AZZpM/98VPOTGccmrPIJhm+puCYrzuxgQNYgwxutYooi2UxgtC4ZFQlkGmb0sWdjqz8NUcX9+ZDsM0hryWYZc2V2yJhDiog4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-83abe8804a5so435926439f.2
        for <netdev@vger.kernel.org>; Mon, 25 Nov 2024 00:53:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732524801; x=1733129601;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W2WcBhXVa3cN2t9c1Rh6rAuo/xeVVfx+BZaqByal3ws=;
        b=Xp+JmY/7qFVGXFqA21nrfi3uzC3jTjlfmenRMIaaWidheLomxSXhy8JIvhli9G8rAG
         BLGZusIjCE7VWXItsG4LBtRdeVdqs1FZraI5qS2cNiJBUgHDneHDJictuBZXHyMn9DkN
         U1QaxOvRgNmpDCqApNtvvgB6JgyTrFctsq6l4LcE+bnZDTu2OqVqwrUQlADJZxRu7B8W
         Bcx8wdWeR0eWE0dqvYDghbNM7p/TAvccJkPJjNn5mAMrgkKZKWlgGJLaD39m9zemn+am
         V3ZIeEzpAYqC9TpU/20d6pTS7Ek5B+HR0l/7P+0XpVMDfr2HNtkN+cJA+eopR97YKTXK
         Y6Rg==
X-Forwarded-Encrypted: i=1; AJvYcCVyj29ktcBdZJ57ryiVy38sk8fRJjkn2DeTuIPrAvMs5BoumwdM+ltrQoc9FTUDm3/YOdBFdJA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrvZpw45QAAF6XCLnl9wfTHF4rN5b/hsaJ8vJmZy1SfUcNRk5L
	D4/XHt6o8Ltzr867lghF0EaFQKnpFTPJXhJHrO7ZE8NlBY/TTizGgeJpj9dc1z9NHSWoU5RWAxI
	KZa3/kuGeYjFr0/BMnTHjDtco3JxT//7/YUiuHwkOclVWTxJ1VcZ8iKU=
X-Google-Smtp-Source: AGHT+IHT1WvLS0WfO7HxrVTEQSQZ4G3ROgNj224nA9AyntUF6dtoh5agFuQ3hKPzePbfclO8wDJsZBIrUz/GZzfJGrLxlTOoBZTl
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12cc:b0:3a7:7fc0:ee16 with SMTP id
 e9e14a558f8ab-3a79ad787b5mr134390285ab.8.1732524801752; Mon, 25 Nov 2024
 00:53:21 -0800 (PST)
Date: Mon, 25 Nov 2024 00:53:21 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67443b01.050a0220.1cc393.006f.GAE@google.com>
Subject: [syzbot] [netfilter?] WARNING in nft_socket_init
From: syzbot <syzbot+57bac0866ddd99fe47c0@syzkaller.appspotmail.com>
To: coreteam@netfilter.org, davem@davemloft.net, edumazet@google.com, 
	fw@strlen.de, horms@kernel.org, kadlec@netfilter.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	netfilter-devel@vger.kernel.org, pabeni@redhat.com, pablo@netfilter.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    06afb0f36106 Merge tag 'trace-v6.13' of git://git.kernel.o..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=111a7b78580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=95b76860fd16c857
dashboard link: https://syzkaller.appspot.com/bug?extid=57bac0866ddd99fe47c0
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=131a7b78580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=158e81c0580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/49111529582a/disk-06afb0f3.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f04577ad9add/vmlinux-06afb0f3.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b352b4fae995/bzImage-06afb0f3.xz

The issue was bisected to:

commit 7f3287db654395f9c5ddd246325ff7889f550286
Author: Florian Westphal <fw@strlen.de>
Date:   Sat Sep 7 14:07:49 2024 +0000

    netfilter: nft_socket: make cgroupsv2 matching work with namespaces

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=105d8778580000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=125d8778580000
console output: https://syzkaller.appspot.com/x/log.txt?x=145d8778580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+57bac0866ddd99fe47c0@syzkaller.appspotmail.com
Fixes: 7f3287db6543 ("netfilter: nft_socket: make cgroupsv2 matching work with namespaces")

------------[ cut here ]------------
WARNING: CPU: 1 PID: 5849 at net/netfilter/nft_socket.c:220 nft_socket_init+0x2db/0x3a0 net/netfilter/nft_socket.c:220
Modules linked in:
CPU: 1 UID: 0 PID: 5849 Comm: syz-executor186 Not tainted 6.12.0-syzkaller-07834-g06afb0f36106 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:nft_socket_init+0x2db/0x3a0 net/netfilter/nft_socket.c:220
Code: 42 0f b6 04 30 84 c0 0f 85 c8 00 00 00 88 5d 00 bb 08 00 00 00 e9 aa fe ff ff e8 30 4a 9e f7 e9 5d ff ff ff e8 26 4a 9e f7 90 <0f> 0b 90 e9 4a ff ff ff 89 e9 80 e1 07 38 c1 0f 8c 9a fd ff ff 48
RSP: 0018:ffffc90003eb71d8 EFLAGS: 00010293
RAX: ffffffff89f7030a RBX: 0000000000000100 RCX: ffff888034de0000
RDX: 0000000000000000 RSI: 0000000000000100 RDI: 00000000000000ff
RBP: 00000000000000ff R08: ffffffff89f702c5 R09: 1ffffffff203a5b6
R10: dffffc0000000000 R11: fffffbfff203a5b7 R12: 1ffff110061c5004
R13: ffff8880347742a2 R14: dffffc0000000000 R15: ffff888030e28020
FS:  00005555769d4380(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000200 CR3: 0000000029582000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 nf_tables_newexpr net/netfilter/nf_tables_api.c:3444 [inline]
 nf_tables_newrule+0x185e/0x2980 net/netfilter/nf_tables_api.c:4272
 nfnetlink_rcv_batch net/netfilter/nfnetlink.c:524 [inline]
 nfnetlink_rcv_skb_batch net/netfilter/nfnetlink.c:647 [inline]
 nfnetlink_rcv+0x14e3/0x2ab0 net/netfilter/nfnetlink.c:665
 netlink_unicast_kernel net/netlink/af_netlink.c:1321 [inline]
 netlink_unicast+0x7f6/0x990 net/netlink/af_netlink.c:1347
 netlink_sendmsg+0x8e4/0xcb0 net/netlink/af_netlink.c:1891
 sock_sendmsg_nosec net/socket.c:711 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:726
 ____sys_sendmsg+0x52a/0x7e0 net/socket.c:2583
 ___sys_sendmsg net/socket.c:2637 [inline]
 __sys_sendmsg+0x269/0x350 net/socket.c:2669
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fcc94659e69
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 61 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe0bc7a0d8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007fcc94659e69
RDX: 0000000000000000 RSI: 00000000200002c0 RDI: 0000000000000003
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fcc946a3036
R13: 00007ffe0bc7a110 R14: 00007ffe0bc7a150 R15: 0000000000000000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

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


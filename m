Return-Path: <netdev+bounces-115664-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E194F94765D
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 09:53:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94BA4281390
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 07:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0413614A4C5;
	Mon,  5 Aug 2024 07:53:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63629149C6E
	for <netdev@vger.kernel.org>; Mon,  5 Aug 2024 07:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722844414; cv=none; b=dOo12sNxKZEymaMmzF1ZS4lMDey8T/1vW/Boei+/zETzBhvq26T3MO6XMpz8btj1VVYSCInUQOQxufqOpJp7Nw10cnEKq3jQW+t2FcU8qzwsGS60ABC1F7tpOq9BHolU1bmlbGQiBa3/3FEzFxPkS7mDVdQeWFpi3wjGeiycggw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722844414; c=relaxed/simple;
	bh=Bp3rc8+B5ldb3Bqx5Ww3mPn3PoVGIkWHfPp62YhYsUQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Wev7BfXs+7PFLEvZjTcXguSUTosQybQTLqd/+w36eV2tH6GVVYvOavm4fB7sC15F8Z2JlH1ndhfe4icGdehxnziinvSBMAOr5ZuPrKjyG3gi5LZdU8Tt8OTOYo5Nhcrv3JQSyC2zlORqlAyudfhRhP7VcwOGf3M77OeFdrj+z6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-39b331c43deso34459645ab.1
        for <netdev@vger.kernel.org>; Mon, 05 Aug 2024 00:53:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722844412; x=1723449212;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/hqbRbVqhbQ+OstlrW2rds1P4zFC0nDVGhZEUadRwDw=;
        b=lHdFmbgtxT/iB6ne/zvNBJtMKTGdBLjyeG4oP0bwsUE+eMS0VwS56Qt7en0PhTXXOD
         qu5SeTkQwMjgkgDvHhXaTWhKELLAAreYtWMtirZ/1rX8nUnuRNf2/9O8IMzWlTNYQMQg
         beXqmx9WK3WvMdbcfdBJzhBiLBOZdXgIt/NT5CAHx0AWNWEjv6cXjfePCSG9mJLVGP/L
         Hz09fn/p66FxyeJjeuX6fpwGLXY2L4YTMSotQccE+a+9pTbU6Z9PJ8IayomecRzS4fpS
         utwLajGKOJzV0aUy8lKeSUKAWt93fXxJuV4bukJxOseKCYEDf2FeF1CCVKCnUhLESjzl
         /vhA==
X-Forwarded-Encrypted: i=1; AJvYcCU4SeTpMFi0mQuj/p1dYoTQ+238+BUPPNYKfF+KbI7YtCoGEFeBYrZpR8ZRdfolIXvSrrVS+gDKjPlhuJ8xvnXqF4yfDPKB
X-Gm-Message-State: AOJu0Yzlj1dOSzLpdjd7X3nw+W2cD0NcNDcsnA6+9IiyeBVjCfbd1mhg
	mDnF25ct2SQi/d+qLeiIAsJSsQUXb4c0olb3nWlGYfqnEfrt3mfTdAYRiAXlS+DGvquEttk3b7+
	W1hUFcP2scwDeSfaBFX80vgzWFsjevP9vudAZg4jYexfZGmyknzeb7NU=
X-Google-Smtp-Source: AGHT+IEDYkeqt7HFUSvX4jwT7u3O6uW3j9Cx0fOTeF17yjwzR7uc6Qvvk+lEZADqbWCTOQxP8R5+hOO3QnB+Y9ayKBEHlVldMUy4
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:19cb:b0:381:7405:7887 with SMTP id
 e9e14a558f8ab-39b1fb988fbmr9805935ab.2.1722844412538; Mon, 05 Aug 2024
 00:53:32 -0700 (PDT)
Date: Mon, 05 Aug 2024 00:53:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000367cd9061eeaf918@google.com>
Subject: [syzbot] [net?] WARNING in l2tp_nl_cmd_tunnel_delete
From: syzbot <syzbot+4316cfd66c99427ed79f@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    ce21e520fdef Merge branch 'axienet-coding-style' into main
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=142043bd980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fbd68ab0b66eda34
dashboard link: https://syzkaller.appspot.com/bug?extid=4316cfd66c99427ed79f
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e1f21962505e/disk-ce21e520.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/60dc5181e0ee/vmlinux-ce21e520.xz
kernel image: https://storage.googleapis.com/syzbot-assets/dd3a41695d4b/bzImage-ce21e520.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4316cfd66c99427ed79f@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 6787 at kernel/workqueue.c:2259 __queue_work+0xcd3/0xf50 kernel/workqueue.c:2258
Modules linked in:
CPU: 1 UID: 0 PID: 6787 Comm: syz.4.401 Not tainted 6.11.0-rc1-syzkaller-00213-gce21e520fdef #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
RIP: 0010:__queue_work+0xcd3/0xf50 kernel/workqueue.c:2258
Code: ff e8 11 84 36 00 90 0f 0b 90 e9 1e fd ff ff e8 03 84 36 00 eb 13 e8 fc 83 36 00 eb 0c e8 f5 83 36 00 eb 05 e8 ee 83 36 00 90 <0f> 0b 90 48 83 c4 60 5b 41 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc
RSP: 0018:ffffc900034e72a8 EFLAGS: 00010087
RAX: ffffffff815ce274 RBX: ffff88802b015a00 RCX: 0000000000040000
RDX: ffffc900095ba000 RSI: 00000000000032b0 RDI: 00000000000032b1
RBP: 0000000000000000 R08: ffffffff815cd6d4 R09: 0000000000000000
R10: ffffc900034e7380 R11: fffff5200069ce71 R12: ffff88802adfd800
R13: ffff88802adfd9c0 R14: dffffc0000000000 R15: 0000000000000008
FS:  00007efdb6a706c0(0000) GS:ffff8880b9300000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020001640 CR3: 000000006e874000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 queue_work_on+0x1c2/0x380 kernel/workqueue.c:2392
 l2tp_nl_cmd_tunnel_delete+0x191/0x200 net/l2tp/l2tp_netlink.c:281
 genl_family_rcv_msg_doit net/netlink/genetlink.c:1115 [inline]
 genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
 genl_rcv_msg+0xb14/0xec0 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2550
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
 netlink_unicast+0x7f0/0x990 net/netlink/af_netlink.c:1357
 netlink_sendmsg+0x8e4/0xcb0 net/netlink/af_netlink.c:1901
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:745
 ____sys_sendmsg+0x525/0x7d0 net/socket.c:2597
 ___sys_sendmsg net/socket.c:2651 [inline]
 __sys_sendmsg+0x2b0/0x3a0 net/socket.c:2680
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7efdb5d779f9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007efdb6a70048 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007efdb5f06058 RCX: 00007efdb5d779f9
RDX: 0000000000000000 RSI: 0000000020000140 RDI: 0000000000000005
RBP: 00007efdb5de58ee R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000006e R14: 00007efdb5f06058 R15: 00007ffdef381b08
 </TASK>


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


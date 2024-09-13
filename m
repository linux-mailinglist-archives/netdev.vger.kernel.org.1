Return-Path: <netdev+bounces-127993-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96894977708
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 04:49:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C14B285B70
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 02:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CBD01D27BC;
	Fri, 13 Sep 2024 02:49:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BBF92BB09
	for <netdev@vger.kernel.org>; Fri, 13 Sep 2024 02:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726195767; cv=none; b=kKypYFpqit2u6Z8m1JnXtLMWOOxlcT+8iBsWfE5gtGcLy/p7Z5de85mIOzYCKxpf53DouZkpvjxyZD/2+fDBTUfoLSP9fZQpS3vhbTlD9WtBTyyY70GPMRsdjPlXVvavwlvxBaCqeSZ1R70EXE3/SG/IYu65BAFnRNID18nGsj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726195767; c=relaxed/simple;
	bh=x0KX85Eni+Rh0AeFH72GXX5ZhraHqy9hmgGncDVv670=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Ssu8MjO/kP3lPzX3mROK5TwaSb7n7aUbj5XZT5r0BS+wSB9N0Cy3DHdwWEzPeY+i8LcNhOL9yu8kEpA5sozyQ3qrP/1OoB3w02s+2aDMOhxxm6PRM7IXsAIReEVvN5XynGhxOAqzbNfFP0z9nJUbDqeSSoTJXgG9Irq0wvhdLSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a04c905651so4599305ab.2
        for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 19:49:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726195764; x=1726800564;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jylXtxP5F5Cw039rfiu+ue6c4TyiJIjw+s934NPOJXs=;
        b=ObY+U7NrDH1cvvXGbvQTunYxcXafiow4ZpdTDd7+c38UTPE7krjF7nbj+SFE/RwyCk
         a6fMGDvVzMQVp8hy5kqNJSjKJ9DdWxykUdgjlRPpWYJ+7OXoPIiClthzBelgSRlgNCN2
         LtZO9bbQxc8+EbUUGwFoRhKDrJTLDu0J2aPN5rlrnFAeZcM/schRCzKygNfu3c1qzH3Z
         9gOYyZ5xbeR8l0gXtMnjarYIhXSV9AUBdhXpJ2lO1o6V4V3NDN9EdyzS1dVueRBscuHk
         GU+MmX1soTx5CKN7sro0b7SW91y4SvLPJcE0QSerWGnXChmRAc1FV6MPKh5cuI39dGKB
         u1gw==
X-Forwarded-Encrypted: i=1; AJvYcCVx5O2soVXVQJG+7K7QrUY3lWQH0MZBbvkWf5ZRK7Xux5S1hEUQTrB1YPXlYydYLdgfzUAZ3+I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5nPJOt7Qfz2opKde9bprk3luoUPrQCTbhboUr/8KWfCBksKgg
	M7Uk4cLHOFy48bBml0dSF1v6znMv3k9IYGdwlWGRMYC4fxU0u1mDdhBktJ/cMxH2HoeRvpIEoVO
	d+c8HzjBxneu4R+Ik45nGHi9TRZ6daZdsKwMSvLWiCxTSAZ1mgEY+/xA=
X-Google-Smtp-Source: AGHT+IEMwLeBLn/bi1hN9EaKEyCRvg7Lt9GQuvkQvyAiSzkZf2HaVtbmBgbaTOWMgTrIWFo6OCpUCj70YNfh+u+LtnUHeVzU6uGV
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20c6:b0:3a0:4b2d:6a7c with SMTP id
 e9e14a558f8ab-3a08b78971dmr11417985ab.20.1726195764038; Thu, 12 Sep 2024
 19:49:24 -0700 (PDT)
Date: Thu, 12 Sep 2024 19:49:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005423e30621f745ff@google.com>
Subject: [syzbot] [net?] WARNING in l2tp_exit_net
From: syzbot <syzbot+332fe1e67018625f63c9@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    f3b6129b7d25 Merge branch '100GbE' of git://git.kernel.org..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=144ba477980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=37742f4fda0d1b09
dashboard link: https://syzkaller.appspot.com/bug?extid=332fe1e67018625f63c9
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/a742e7b2e0d2/disk-f3b6129b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6982186745fb/vmlinux-f3b6129b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/5fd38b217bb5/bzImage-f3b6129b.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+332fe1e67018625f63c9@syzkaller.appspotmail.com

bond0 (unregistering): (slave dummy0): Releasing backup interface
bond0 (unregistering): Released all slaves
tipc: Disabling bearer <eth:batadv0>
tipc: Disabling bearer <udp:syz0>
tipc: Left network mode
------------[ cut here ]------------
WARNING: CPU: 0 PID: 17026 at net/l2tp/l2tp_core.c:1881 l2tp_exit_net+0x165/0x170 net/l2tp/l2tp_core.c:1881
Modules linked in:
CPU: 0 UID: 0 PID: 17026 Comm: kworker/u8:36 Not tainted 6.11.0-rc6-syzkaller-01324-gf3b6129b7d25 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
Workqueue: netns cleanup_net
RIP: 0010:l2tp_exit_net+0x165/0x170 net/l2tp/l2tp_core.c:1881
Code: 0f 0b 90 e9 3b ff ff ff e8 48 a4 b0 f6 eb 05 e8 41 a4 b0 f6 90 0f 0b 90 e9 7a ff ff ff e8 33 a4 b0 f6 eb 05 e8 2c a4 b0 f6 90 <0f> 0b 90 eb b5 66 0f 1f 44 00 00 90 90 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffc9000ae07a98 EFLAGS: 00010293
RAX: ffffffff8ae2e87d RBX: ffff8880797c0888 RCX: ffff88806dbbda00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000002
RBP: ffffc9000ae07bb0 R08: ffffffff8bb2ce16 R09: 1ffffffff2031025
R10: dffffc0000000000 R11: fffffbfff2031026 R12: dffffc0000000000
R13: 1ffffffff1fd274c R14: ffff8880797c0930 R15: ffff8880797c0840
FS:  0000000000000000(0000) GS:ffff8880b8800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000110c3831d6 CR3: 000000000e734000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ops_exit_list net/core/net_namespace.c:173 [inline]
 cleanup_net+0x802/0xcc0 net/core/net_namespace.c:626
 process_one_work kernel/workqueue.c:3231 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3312
 worker_thread+0x86d/0xd10 kernel/workqueue.c:3389
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
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


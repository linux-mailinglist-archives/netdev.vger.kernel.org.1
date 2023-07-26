Return-Path: <netdev+bounces-21512-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 072A9763C40
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 18:20:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9112E281FB6
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 16:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B54E3799D;
	Wed, 26 Jul 2023 16:20:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E35CE57F
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 16:20:00 +0000 (UTC)
Received: from mail-oa1-f79.google.com (mail-oa1-f79.google.com [209.85.160.79])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2AE82D43
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 09:19:41 -0700 (PDT)
Received: by mail-oa1-f79.google.com with SMTP id 586e51a60fabf-1bb72ad88f8so40769fac.1
        for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 09:19:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690388381; x=1690993181;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ja9lwwJiczR3VDcDEQG9wgS0ZmuFEIWnaFuz4pyvceE=;
        b=iWrCSPIgIkw2aXxAiR3nlf0Kf6MLQj2YbHG2kFzzpJyVKhMJi+n2Op8I7XC1SR0K9b
         ozb7mh+QdyFmhJ2lZ0oH1l/kWTeaxmQDacHTU1LVg8H4R4ko6Tv1P1tQlgInzpuTYYwe
         AU7h+JPVhmRQXpYb/bss4jIPASM/CAPrcPl4ai2lmqbZlYLrQSnwzfq5hnRiRW/WTBdU
         Pa7skC12TB28X7SgcMB7zAf1VevBzlM++ZPuGjyOI0pKSwAlkOr7Z3SjsXan6zUlxTYE
         Wcy+/74wOec6R+EKZEQIpmAFJZizkzE00WB2B/Q31lSfPXs/5I7CwYPIEGUm7XgqY9h0
         t+7w==
X-Gm-Message-State: ABy/qLawU7qF/JTmS1AkYnNGutiC5jLdsr4nkzZQ7UZuTnHkgbVaiIJY
	GTbLdYaTht30k86lrUiZPMwHKMDf2Bzw0mZURqfL1RGRoV0X
X-Google-Smtp-Source: APBJJlEn1YgXjOs36M36KnHcEy8x7JjmCEc4U9plYZLdf6dEihXYPrLzaVt4KiZKG2g1PhgJbsMMUQQ9aFylokuPb1B1lIU91EqO
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6870:3a06:b0:1bb:b65c:c28 with SMTP id
 du6-20020a0568703a0600b001bbb65c0c28mr45245oab.0.1690388381117; Wed, 26 Jul
 2023 09:19:41 -0700 (PDT)
Date: Wed, 26 Jul 2023 09:19:41 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fd316406016636ee@google.com>
Subject: [syzbot] [net?] memory leak in kcm_sendmsg (2)
From: syzbot <syzbot+6f98de741f7dbbfc4ccb@syzkaller.appspotmail.com>
To: bpf@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
	SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello,

syzbot found the following issue on:

HEAD commit:    18b44bc5a672 ovl: Always reevaluate the file signature for..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15e732c9a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8f187978508424dc
dashboard link: https://syzkaller.appspot.com/bug?extid=6f98de741f7dbbfc4ccb
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17d3d94ea80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13de8306a80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/7520f98f6651/disk-18b44bc5.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f13d09e3480e/vmlinux-18b44bc5.xz
kernel image: https://storage.googleapis.com/syzbot-assets/587382b9a0e6/bzImage-18b44bc5.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6f98de741f7dbbfc4ccb@syzkaller.appspotmail.com

Warning: Permanently added '10.128.0.5' (ED25519) to the list of known hosts.
executing program
executing program
BUG: memory leak
unreferenced object 0xffff88810b088c00 (size 240):
  comm "syz-executor186", pid 5012, jiffies 4294943306 (age 13.680s)
  hex dump (first 32 bytes):
    00 89 08 0b 81 88 ff ff 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff83e5d5ff>] __alloc_skb+0x1ef/0x230 net/core/skbuff.c:634
    [<ffffffff84606e59>] alloc_skb include/linux/skbuff.h:1289 [inline]
    [<ffffffff84606e59>] kcm_sendmsg+0x269/0x1050 net/kcm/kcmsock.c:815
    [<ffffffff83e479c6>] sock_sendmsg_nosec net/socket.c:725 [inline]
    [<ffffffff83e479c6>] sock_sendmsg+0x56/0xb0 net/socket.c:748
    [<ffffffff83e47f55>] ____sys_sendmsg+0x365/0x470 net/socket.c:2494
    [<ffffffff83e4c389>] ___sys_sendmsg+0xc9/0x130 net/socket.c:2548
    [<ffffffff83e4c536>] __sys_sendmsg+0xa6/0x120 net/socket.c:2577
    [<ffffffff84ad7bb8>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff84ad7bb8>] do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0xcd

BUG: memory leak
unreferenced object 0xffff88810a2cc000 (size 640):
  comm "syz-executor186", pid 5012, jiffies 4294943306 (age 13.680s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff83e5a2d1>] kmalloc_reserve+0xe1/0x180 net/core/skbuff.c:559
    [<ffffffff83e5d4e5>] __alloc_skb+0xd5/0x230 net/core/skbuff.c:644
    [<ffffffff84606e59>] alloc_skb include/linux/skbuff.h:1289 [inline]
    [<ffffffff84606e59>] kcm_sendmsg+0x269/0x1050 net/kcm/kcmsock.c:815
    [<ffffffff83e479c6>] sock_sendmsg_nosec net/socket.c:725 [inline]
    [<ffffffff83e479c6>] sock_sendmsg+0x56/0xb0 net/socket.c:748
    [<ffffffff83e47f55>] ____sys_sendmsg+0x365/0x470 net/socket.c:2494
    [<ffffffff83e4c389>] ___sys_sendmsg+0xc9/0x130 net/socket.c:2548
    [<ffffffff83e4c536>] __sys_sendmsg+0xa6/0x120 net/socket.c:2577
    [<ffffffff84ad7bb8>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff84ad7bb8>] do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0xcd



---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to change bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup


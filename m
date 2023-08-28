Return-Path: <netdev+bounces-30972-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E15278A4A1
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 04:35:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62623280DC6
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 02:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F1C3654;
	Mon, 28 Aug 2023 02:35:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327C3182
	for <netdev@vger.kernel.org>; Mon, 28 Aug 2023 02:35:52 +0000 (UTC)
Received: from mail-pg1-f207.google.com (mail-pg1-f207.google.com [209.85.215.207])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8328CFF
	for <netdev@vger.kernel.org>; Sun, 27 Aug 2023 19:35:51 -0700 (PDT)
Received: by mail-pg1-f207.google.com with SMTP id 41be03b00d2f7-56c2d67da6aso1447631a12.2
        for <netdev@vger.kernel.org>; Sun, 27 Aug 2023 19:35:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693190151; x=1693794951;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FifDf28yvuZJQzcHb+JuLWl+M8PNz/FpcXOqYTZ6xOA=;
        b=gSL5aXy3JVcsI/qqXwZsMAUg+bUoo6jw9Lq75HhTyUPr0D6Akj3Et9CaJgSQmHdx9e
         XHc4uCHRcklGujjltF1u1AAd/ipJNMSCRGRG43q1K6TRWjxcNMDTzdez+tqXkM10DGne
         ZT+iyh660btKBipRgbhDjFJzVL62Jw7Iu4f5QiusTMvTVT7xWjOriVB9N7RSv+5iuOQ6
         Iz4SG5Ut6wXOVs/4gkmaJH5z9ClAQf3AhH7IFsbq4NqK++5Vr+CF7Ia4AKxZL4N1hIiN
         eH9aq/8H6AAa1qJAGiDgojU4Jj1wIgqMZvoZqrcuLn4nyTbHsc6lWIjWWNAnLI49SiWG
         9ECg==
X-Gm-Message-State: AOJu0YxepY1IiCSFSkLDAZm8ORDVny1+bMhcSpRodxppIf5ClYX3CW8+
	LKu4qsv7bX24T6eFjSA6f85Jtqml5jQUAiglb6rwJIqhNrY6
X-Google-Smtp-Source: AGHT+IHnbP7U5FzNlZ6kHAL4cMXGliHk4ZBtFiDNRNVosdYIhIsFvl1za+QBfa/p11T90NI7yW3PXMyM8aXKQwlcepCd1ZgOzbWY
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a63:6d0d:0:b0:565:d4f9:dc39 with SMTP id
 i13-20020a636d0d000000b00565d4f9dc39mr4218705pgc.9.1693190150989; Sun, 27 Aug
 2023 19:35:50 -0700 (PDT)
Date: Sun, 27 Aug 2023 19:35:50 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007caf3b0603f28d71@google.com>
Subject: [syzbot] [batman?] memory leak in skb_clone (2)
From: syzbot <syzbot+92f9b5fba2df252a3569@syzkaller.appspotmail.com>
To: a@unstable.cc, b.a.t.m.a.n@lists.open-mesh.org, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	mareklindner@neomailbox.ch, netdev@vger.kernel.org, pabeni@redhat.com, 
	sven@narfation.org, sw@simonwunderlich.de, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
	SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello,

syzbot found the following issue on:

HEAD commit:    a5e505a99ca7 Merge tag 'platform-drivers-x86-v6.5-5' of gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15eea3e3a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f3c65e06397a9d58
dashboard link: https://syzkaller.appspot.com/bug?extid=92f9b5fba2df252a3569
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13597f90680000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c534ce48946f/disk-a5e505a9.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/724bbdaa3992/vmlinux-a5e505a9.xz
kernel image: https://storage.googleapis.com/syzbot-assets/47fba0663891/bzImage-a5e505a9.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+92f9b5fba2df252a3569@syzkaller.appspotmail.com

2023/08/24 02:03:48 executed programs: 322
2023/08/24 02:03:54 executed programs: 337
BUG: memory leak
unreferenced object 0xffff888120ea2600 (size 240):
  comm "kworker/u4:5", pid 5210, jiffies 4295058872 (age 8.300s)
  hex dump (first 32 bytes):
    00 22 e3 20 81 88 ff ff 00 00 00 00 00 00 00 00  .". ............
    00 80 ed 1c 81 88 ff ff 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff83e5e05a>] skb_clone+0xaa/0x190 net/core/skbuff.c:1860
    [<ffffffff8499f31f>] batadv_iv_ogm_send_to_if net/batman-adv/bat_iv_ogm.c:387 [inline]
    [<ffffffff8499f31f>] batadv_iv_ogm_emit net/batman-adv/bat_iv_ogm.c:420 [inline]
    [<ffffffff8499f31f>] batadv_iv_send_outstanding_bat_ogm_packet+0x2ef/0x370 net/batman-adv/bat_iv_ogm.c:1700
    [<ffffffff812b8d31>] process_one_work+0x2f1/0x640 kernel/workqueue.c:2600
    [<ffffffff812b966c>] worker_thread+0x5c/0x5c0 kernel/workqueue.c:2751
    [<ffffffff812c313b>] kthread+0x12b/0x170 kernel/kthread.c:389
    [<ffffffff81140a5c>] ret_from_fork+0x2c/0x40 arch/x86/kernel/process.c:145
    [<ffffffff81002be1>] ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304

BUG: memory leak
unreferenced object 0xffff888120f36c00 (size 1024):
  comm "kworker/u4:5", pid 5210, jiffies 4295058872 (age 8.300s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff81554a79>] __do_kmalloc_node mm/slab_common.c:984 [inline]
    [<ffffffff81554a79>] __kmalloc_node_track_caller+0x49/0x140 mm/slab_common.c:1005
    [<ffffffff83e54735>] kmalloc_reserve+0x95/0x180 net/core/skbuff.c:575
    [<ffffffff83e5c6c8>] pskb_expand_head+0xd8/0x5f0 net/core/skbuff.c:2042
    [<ffffffff849ccbef>] __skb_cow include/linux/skbuff.h:3571 [inline]
    [<ffffffff849ccbef>] skb_cow_head include/linux/skbuff.h:3605 [inline]
    [<ffffffff849ccbef>] batadv_skb_head_push+0x8f/0x110 net/batman-adv/soft-interface.c:72
    [<ffffffff849ca643>] batadv_send_skb_packet+0x83/0x1c0 net/batman-adv/send.c:86
    [<ffffffff8499f35a>] batadv_iv_ogm_send_to_if net/batman-adv/bat_iv_ogm.c:392 [inline]
    [<ffffffff8499f35a>] batadv_iv_ogm_emit net/batman-adv/bat_iv_ogm.c:420 [inline]
    [<ffffffff8499f35a>] batadv_iv_send_outstanding_bat_ogm_packet+0x32a/0x370 net/batman-adv/bat_iv_ogm.c:1700
    [<ffffffff812b8d31>] process_one_work+0x2f1/0x640 kernel/workqueue.c:2600
    [<ffffffff812b966c>] worker_thread+0x5c/0x5c0 kernel/workqueue.c:2751
    [<ffffffff812c313b>] kthread+0x12b/0x170 kernel/kthread.c:389
    [<ffffffff81140a5c>] ret_from_fork+0x2c/0x40 arch/x86/kernel/process.c:145
    [<ffffffff81002be1>] ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304

BUG: memory leak
unreferenced object 0xffff888120ea2000 (size 240):
  comm "kworker/u4:5", pid 5210, jiffies 4295058872 (age 8.300s)
  hex dump (first 32 bytes):
    00 28 ea 20 81 88 ff ff 00 00 00 00 00 00 00 00  .(. ............
    00 80 ec 1c 81 88 ff ff 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff83e5e05a>] skb_clone+0xaa/0x190 net/core/skbuff.c:1860
    [<ffffffff83f88552>] netem_enqueue+0xc62/0x1430 net/sched/sch_netem.c:479
    [<ffffffff83e80975>] dev_qdisc_enqueue+0x25/0xf0 net/core/dev.c:3732
    [<ffffffff83e8b217>] __dev_xmit_skb net/core/dev.c:3821 [inline]
    [<ffffffff83e8b217>] __dev_queue_xmit+0xdc7/0x17d0 net/core/dev.c:4169
    [<ffffffff849ca710>] dev_queue_xmit include/linux/netdevice.h:3088 [inline]
    [<ffffffff849ca710>] batadv_send_skb_packet+0x150/0x1c0 net/batman-adv/send.c:108
    [<ffffffff8499f35a>] batadv_iv_ogm_send_to_if net/batman-adv/bat_iv_ogm.c:392 [inline]
    [<ffffffff8499f35a>] batadv_iv_ogm_emit net/batman-adv/bat_iv_ogm.c:420 [inline]
    [<ffffffff8499f35a>] batadv_iv_send_outstanding_bat_ogm_packet+0x32a/0x370 net/batman-adv/bat_iv_ogm.c:1700
    [<ffffffff812b8d31>] process_one_work+0x2f1/0x640 kernel/workqueue.c:2600
    [<ffffffff812b966c>] worker_thread+0x5c/0x5c0 kernel/workqueue.c:2751
    [<ffffffff812c313b>] kthread+0x12b/0x170 kernel/kthread.c:389
    [<ffffffff81140a5c>] ret_from_fork+0x2c/0x40 arch/x86/kernel/process.c:145
    [<ffffffff81002be1>] ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304



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

If you want to overwrite bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup


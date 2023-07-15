Return-Path: <netdev+bounces-18051-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 84279754676
	for <lists+netdev@lfdr.de>; Sat, 15 Jul 2023 05:13:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A73DE1C21664
	for <lists+netdev@lfdr.de>; Sat, 15 Jul 2023 03:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A765A5F;
	Sat, 15 Jul 2023 03:13:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28DA739D
	for <netdev@vger.kernel.org>; Sat, 15 Jul 2023 03:13:54 +0000 (UTC)
Received: from mail-oi1-f205.google.com (mail-oi1-f205.google.com [209.85.167.205])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D9903A81
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 20:13:53 -0700 (PDT)
Received: by mail-oi1-f205.google.com with SMTP id 5614622812f47-39fb9cce400so4267691b6e.1
        for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 20:13:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689390832; x=1691982832;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aSfrWYFfOOuvEmLeDsQiplx/675CCat2k6SwRj9bpqE=;
        b=Y9kBAUNE6YC8em+2ol8w3OWO1Mxt9sZ2WOxE7rvhCwgmyDx+2oipnTzPmZcTrnxZWv
         3sdu+dxM7YWhT1N+QOK8u/l351SKeNuBGjJyiPeG6iE5+ljMVJ/91J7A1OC44cDdROag
         TA70WMUGRooNh2t1oVj9HMuUGxT1SlZ0meBREnD1XtryLD0i38ING0ZACUZ59TbsiTah
         Wde00Bp1S66dh9dHstne2+s0SC6ZfmYnASMJR2NGkLfSiPd3BTeepgctUYcov4jIyf8v
         vIa3eCwUFKLuwnUtSOH3aK1Nq1ApDOw+WMME9DemsB3F3E4TEM9/GMmuX33C+wMP9ylg
         ZXxw==
X-Gm-Message-State: ABy/qLbeKoUdAr5JPjhvrc4lcgI0tFNtQKUi7n8FCQz9sVQAhade7vKq
	KtcBsEZK6RC+nFpWAojm5HjvGMApMV2ndIjwUrjXNwKZQJAD
X-Google-Smtp-Source: APBJJlHN0BPIT8LZkDkvRBAqIkZh1f4mHHJg2tytQiA8PD1PmLvoNqND4wDbUjbqd8Vr7YTIvwnOoAyNrfybE/0WfMIiFvzBNvfs
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:151f:b0:3a3:671b:7dee with SMTP id
 u31-20020a056808151f00b003a3671b7deemr8740843oiw.11.1689390832500; Fri, 14
 Jul 2023 20:13:52 -0700 (PDT)
Date: Fri, 14 Jul 2023 20:13:52 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000075472b06007df4fb@google.com>
Subject: [syzbot] [nfc?] memory leak in skb_copy (2)
From: syzbot <syzbot+6eb09d75211863f15e3e@syzkaller.appspotmail.com>
To: bongsu.jeon@samsung.com, krzysztof.kozlowski@linaro.org, 
	linux-kernel@vger.kernel.org, linux-nfc@lists.01.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello,

syzbot found the following issue on:

HEAD commit:    3f01e9fed845 Merge tag 'linux-watchdog-6.5-rc2' of git://w..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15fe3ef8a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=75da4f0a455bdbd3
dashboard link: https://syzkaller.appspot.com/bug?extid=6eb09d75211863f15e3e
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=162f1cbca80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/441fb7ea58b8/disk-3f01e9fe.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8fa7790ba0c3/vmlinux-3f01e9fe.xz
kernel image: https://storage.googleapis.com/syzbot-assets/5e7a6471dadf/bzImage-3f01e9fe.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6eb09d75211863f15e3e@syzkaller.appspotmail.com

BUG: memory leak
unreferenced object 0xffff88811fff5e00 (size 240):
  comm "kworker/u4:0", pid 10, jiffies 4294989700 (age 28.220s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff83e1c0bd>] __alloc_skb+0x1fd/0x230 net/core/skbuff.c:634
    [<ffffffff83e1efcf>] skb_copy+0x6f/0x180 net/core/skbuff.c:1925
    [<ffffffff82c3526f>] virtual_nci_send+0x3f/0xb0 drivers/nfc/virtual_ncidev.c:58
    [<ffffffff84990da9>] nci_send_frame+0x69/0xb0 net/nfc/nci/core.c:1347
    [<ffffffff84990e82>] nci_cmd_work+0x92/0xc0 net/nfc/nci/core.c:1567
    [<ffffffff812b19e4>] process_one_work+0x2c4/0x620 kernel/workqueue.c:2597
    [<ffffffff812b233d>] worker_thread+0x5d/0x5c0 kernel/workqueue.c:2748
    [<ffffffff812bbde3>] kthread+0x133/0x180 kernel/kthread.c:389
    [<ffffffff81002b5f>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308

BUG: memory leak
unreferenced object 0xffff88810d74e500 (size 640):
  comm "kworker/u4:0", pid 10, jiffies 4294989700 (age 28.220s)
  hex dump (first 32 bytes):
    20 00 01 01 00 00 00 00 00 00 00 00 00 00 00 00   ...............
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff83e18976>] kmalloc_reserve+0xe6/0x180 net/core/skbuff.c:559
    [<ffffffff83e1bf95>] __alloc_skb+0xd5/0x230 net/core/skbuff.c:644
    [<ffffffff83e1efcf>] skb_copy+0x6f/0x180 net/core/skbuff.c:1925
    [<ffffffff82c3526f>] virtual_nci_send+0x3f/0xb0 drivers/nfc/virtual_ncidev.c:58
    [<ffffffff84990da9>] nci_send_frame+0x69/0xb0 net/nfc/nci/core.c:1347
    [<ffffffff84990e82>] nci_cmd_work+0x92/0xc0 net/nfc/nci/core.c:1567
    [<ffffffff812b19e4>] process_one_work+0x2c4/0x620 kernel/workqueue.c:2597
    [<ffffffff812b233d>] worker_thread+0x5d/0x5c0 kernel/workqueue.c:2748
    [<ffffffff812bbde3>] kthread+0x133/0x180 kernel/kthread.c:389
    [<ffffffff81002b5f>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308



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


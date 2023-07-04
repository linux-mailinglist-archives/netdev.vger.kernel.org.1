Return-Path: <netdev+bounces-15261-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DE5E7466F1
	for <lists+netdev@lfdr.de>; Tue,  4 Jul 2023 03:45:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BB981C20A6F
	for <lists+netdev@lfdr.de>; Tue,  4 Jul 2023 01:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 467DE626;
	Tue,  4 Jul 2023 01:45:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A34620
	for <netdev@vger.kernel.org>; Tue,  4 Jul 2023 01:45:10 +0000 (UTC)
Received: from mail-pl1-f206.google.com (mail-pl1-f206.google.com [209.85.214.206])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D2D5E54
	for <netdev@vger.kernel.org>; Mon,  3 Jul 2023 18:45:08 -0700 (PDT)
Received: by mail-pl1-f206.google.com with SMTP id d9443c01a7336-1b890ca6718so22698885ad.0
        for <netdev@vger.kernel.org>; Mon, 03 Jul 2023 18:45:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688435108; x=1691027108;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H2Ze2c0Kq8hkSX1P9VUvavVjaGi6+MVhTGXkCivFU20=;
        b=XanuFqMY2z8T6r8xGZGRSL62L0ebIMSkM3jhF1RMkec6wXFvgLzPMnmbjybWRgkffw
         E+vtZFcjAcB64dmMnFHpibzY6DwMm4xqCm8HnemnEvkR7AwGCZTRc5NHA4MYLvjHo2t0
         s6pTX0vFYxew1Yq/v9+K701OH5U+i+rBZcZndQB9G1XwxWxe4j4jxU4c+sJnRpd7hmBn
         Y2qCUsYTXFFh8eBmbtj2jXgPdfz+7vj7ype3AvSOrnLS/ukeL0/htMPPRnbBAlOYB1Zy
         724yrXqE5uirUUw4woNydmIykQIcEmGAMJkWC9nBOFkzK39ogk/JwY06CXiUN1NockiP
         Bi1Q==
X-Gm-Message-State: ABy/qLYKVCCqbfCNCcfBQOpPtJ2tkcbYcrvG6CoIYulh3L6QeqmZvXz7
	NMRuyEyXmc4F84BJnjBH/K+PH4SR3y80jVYBbQAKqui/vNur
X-Google-Smtp-Source: APBJJlE8AUmlax/N+jsu5a1mZQ8ukTFM+k/kgAiaz2tEeINfzgIlfRTNchLLvZv8mG+tQ/hCFEyRf6wmUezeiU6BuC2I1bTQOupI
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a17:902:ef8d:b0:1b3:cbd9:c686 with SMTP id
 iz13-20020a170902ef8d00b001b3cbd9c686mr9724739plb.4.1688435108181; Mon, 03
 Jul 2023 18:45:08 -0700 (PDT)
Date: Mon, 03 Jul 2023 18:45:08 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d97d9305ff9f6e87@google.com>
Subject: [syzbot] [block?] KASAN: slab-out-of-bounds Read in bio_split_rw
From: syzbot <syzbot+6f66f3e78821b0fff882@syzkaller.appspotmail.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello,

syzbot found the following issue on:

HEAD commit:    3674fbf0451d Merge git://git.kernel.org/pub/scm/linux/kern..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=110c779f280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c9bf1936936ca698
dashboard link: https://syzkaller.appspot.com/bug?extid=6f66f3e78821b0fff882
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16223cb8a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13f13920a80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/42ed556782c3/disk-3674fbf0.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1913e16e8565/vmlinux-3674fbf0.xz
kernel image: https://storage.googleapis.com/syzbot-assets/469804b58a7c/bzImage-3674fbf0.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6f66f3e78821b0fff882@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-out-of-bounds in bio_split_rw+0x7e7/0x8b0 block/blk-merge.c:286
Read of size 8 at addr ffff88807a302100 by task syz-executor144/5006

CPU: 1 PID: 5006 Comm: syz-executor144 Not tainted 6.4.0-rc7-syzkaller-01944-g3674fbf0451d #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/27/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x150 lib/dump_stack.c:106
 print_address_description.constprop.0+0x2c/0x3c0 mm/kasan/report.c:351
 print_report mm/kasan/report.c:462 [inline]
 kasan_report+0x11c/0x130 mm/kasan/report.c:572
 bio_split_rw+0x7e7/0x8b0 block/blk-merge.c:286
 __bio_split_to_limits+0x235/0x9b0 block/blk-merge.c:370
 blk_mq_submit_bio+0x235/0x1f50 block/blk-mq.c:2940
 __submit_bio+0xfc/0x310 block/blk-core.c:594
 __submit_bio_noacct_mq block/blk-core.c:673 [inline]
 submit_bio_noacct_nocheck+0x7f9/0xb40 block/blk-core.c:702
 submit_bio_noacct+0x945/0x19f0 block/blk-core.c:801
 ext4_io_submit+0xa6/0x140 fs/ext4/page-io.c:378
 ext4_do_writepages+0x141c/0x3290 fs/ext4/inode.c:2723
 ext4_writepages+0x304/0x770 fs/ext4/inode.c:2792
 do_writepages+0x1a8/0x640 mm/page-writeback.c:2551
 filemap_fdatawrite_wbc mm/filemap.c:390 [inline]
 filemap_fdatawrite_wbc+0x147/0x1b0 mm/filemap.c:380
 __filemap_fdatawrite_range+0xb8/0xf0 mm/filemap.c:423
 filemap_write_and_wait_range mm/filemap.c:678 [inline]
 filemap_write_and_wait_range+0xa1/0x120 mm/filemap.c:669
 __iomap_dio_rw+0x65f/0x1f90 fs/iomap/direct-io.c:569
 iomap_dio_rw+0x40/0xa0 fs/iomap/direct-io.c:688
 ext4_dio_read_iter fs/ext4/file.c:94 [inline]
 ext4_file_read_iter+0x4be/0x690 fs/ext4/file.c:145
 call_read_iter include/linux/fs.h:1862 [inline]
 generic_file_splice_read+0x182/0x4b0 fs/splice.c:420
 do_splice_to+0x1b9/0x240 fs/splice.c:1007


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


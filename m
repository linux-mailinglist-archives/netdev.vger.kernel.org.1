Return-Path: <netdev+bounces-96265-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99E828C4C1A
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 07:53:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53A19280C35
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 05:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CC9D18C36;
	Tue, 14 May 2024 05:53:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE03B1802B
	for <netdev@vger.kernel.org>; Tue, 14 May 2024 05:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715666005; cv=none; b=WPHspAF/7OqWAv388S7+X3HXGBOdeOkM+lSsbBNV0L8XLTKrzusJBDkjmv3fvwf4sGquXkDJym0toeRJ9fXTlgNJEuSTqomgLan646F9cSQcu5IEV3s65G90mSAgkacnipsRkfoOpawJaA/NQS5SRA2Q6mDvOR0wcKeB6Un+kKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715666005; c=relaxed/simple;
	bh=Tx+ZO6ZStpcgBKfJqMtByoaVvsqTZuTvEjZvNL0g7oY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=aINlNai0ldaUuv/cnF/+WCoUZ+Iff4N3tiEf5dXnP0F8XcO/VvNtvLf5+zKUeaTLIkp3K4zBnzwRoSe15pYFJSta7Td95pP0wv0BRL1ITG/hb3Fnrz8WHAI//XKeFvIVK3gd+V6+AVUUlle+P3DrhUabF69KxzLnz9CmFajHfGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-7dabc125bddso624270739f.1
        for <netdev@vger.kernel.org>; Mon, 13 May 2024 22:53:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715666003; x=1716270803;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UJS8OugN1Io4mcRudsWjqu7ocl6GdQM9o1oBO8nz1wA=;
        b=AUc3d/IEl3/cUgA2huvIzRqWdb4sT1pmPeR3cPxC+VqThbaE0SOxTFD/DhbfGkr3vg
         tjUDqUCNtvw0zf2XmlfEI/O3nLU6Q20MEFfNp4a/EA4XYKHpzf5n3SPnFjGG6pFJ8jqw
         Fm6AfeOW2WuB6Z1/dXfsiNKU9bVaIJNL3ZEMlafrCGoDkjX9Tq7x+5e79uz7OyhPg3iX
         V62rjgzkdGcpV6QwbANCjXAXhsQVKFM8Mw01VQYB47EBjh/PMMc3WJYHk1CUetC74lGM
         vrI4xkP4Q6Cu905xvQ0sdmea0gLA8MDn9EVq4zBU+DQxIp9xh9nvv3bvQ7HFrcPIJd6Y
         /CMg==
X-Forwarded-Encrypted: i=1; AJvYcCUi5QtnHIWfItyPsN6yGDpcqltAK9h5eJMFsvc9wdXtnMuiwMfFoYTX65fP0MUP5RfcUznaZt7T2J5sGWJ56mgJ/3nQuT2f
X-Gm-Message-State: AOJu0Yz5ys5Wp9sBtgdRNLU6vJ9drVyAietk/xKXtJ88NeOmn4En3Rjf
	Ah32See97Uoioq/+f/9z2iqIfPYTjabuVatVvgHpzgjGC9W8QN241HslARCoy3xFmVB2V5dvj2h
	tSFkKgZ4thTybDanyx2fM5XN9RX0mrh5IA9HDsEhAzUA18k7CMDKtqR8=
X-Google-Smtp-Source: AGHT+IEV9/8JkSZA0U1eFI0Ng6ILKQfhEkWhktf5UC+TZX5qtFeutbeYRg69tsmFypCG3MZaXBBETTrhyLDcuDs3z8nsyJ8auYI2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1352:b0:7de:de58:3b1f with SMTP id
 ca18e2360f4ac-7e1b5229103mr58422939f.4.1715666002927; Mon, 13 May 2024
 22:53:22 -0700 (PDT)
Date: Mon, 13 May 2024 22:53:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a875ac0618639edb@google.com>
Subject: [syzbot] [net?] [nfc?] KMSAN: uninit-value in nci_rsp_packet (2)
From: syzbot <syzbot+cb0a0caa117154656cf8@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, krzk@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    45db3ab70092 Merge tag '6.9-rc7-ksmbd-fixes' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1350fb70980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=617171361dd3cd47
dashboard link: https://syzkaller.appspot.com/bug?extid=cb0a0caa117154656cf8
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/232e7c2a73a5/disk-45db3ab7.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7e9bf7c936ab/vmlinux-45db3ab7.xz
kernel image: https://storage.googleapis.com/syzbot-assets/5e8f98ee02d8/bzImage-45db3ab7.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+cb0a0caa117154656cf8@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in nci_core_init_rsp_packet_v2 net/nfc/nci/rsp.c:107 [inline]
BUG: KMSAN: uninit-value in nci_core_init_rsp_packet net/nfc/nci/rsp.c:131 [inline]
BUG: KMSAN: uninit-value in nci_rsp_packet+0x2b4f/0x2c00 net/nfc/nci/rsp.c:376
 nci_core_init_rsp_packet_v2 net/nfc/nci/rsp.c:107 [inline]
 nci_core_init_rsp_packet net/nfc/nci/rsp.c:131 [inline]
 nci_rsp_packet+0x2b4f/0x2c00 net/nfc/nci/rsp.c:376
 nci_rx_work+0x268/0x5d0 net/nfc/nci/core.c:1527
 process_one_work kernel/workqueue.c:3267 [inline]
 process_scheduled_works+0xa81/0x1bd0 kernel/workqueue.c:3348
 worker_thread+0xea5/0x1560 kernel/workqueue.c:3429
 kthread+0x3e2/0x540 kernel/kthread.c:388
 ret_from_fork+0x6d/0x90 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Uninit was created at:
 slab_post_alloc_hook mm/slub.c:3810 [inline]
 slab_alloc_node mm/slub.c:3851 [inline]
 kmem_cache_alloc_node+0x622/0xc90 mm/slub.c:3894
 kmalloc_reserve+0x13d/0x4a0 net/core/skbuff.c:577
 __alloc_skb+0x35b/0x7a0 net/core/skbuff.c:668
 alloc_skb include/linux/skbuff.h:1313 [inline]
 virtual_ncidev_write+0x6d/0x290 drivers/nfc/virtual_ncidev.c:120
 vfs_write+0x49b/0x1520 fs/read_write.c:588
 ksys_write+0x20f/0x4c0 fs/read_write.c:643
 __do_sys_write fs/read_write.c:655 [inline]
 __se_sys_write fs/read_write.c:652 [inline]
 __x64_sys_write+0x93/0xe0 fs/read_write.c:652
 x64_sys_call+0x3062/0x3b50 arch/x86/include/generated/asm/syscalls_64.h:2
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

CPU: 0 PID: 57 Comm: kworker/u8:3 Not tainted 6.9.0-rc7-syzkaller-00056-g45db3ab70092 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
Workqueue: nfc2_nci_rx_wq nci_rx_work
=====================================================


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


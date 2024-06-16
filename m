Return-Path: <netdev+bounces-103843-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 000FA909D99
	for <lists+netdev@lfdr.de>; Sun, 16 Jun 2024 15:15:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C8562817D2
	for <lists+netdev@lfdr.de>; Sun, 16 Jun 2024 13:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93F99181CF8;
	Sun, 16 Jun 2024 13:15:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C576A008
	for <netdev@vger.kernel.org>; Sun, 16 Jun 2024 13:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718543720; cv=none; b=bKQyOzXh6H7q91FVBz6DBztuAJIAnawPtvOxDzpX3+wZEOy0F3uDvdYCJh2xGK4VlMzF4U0HGBHzAVeznVLMkx7hHpJtC3dHmWfeWU2G7RDGb9wIguJMo2iANf1dmSkgLaAzXSugeCRS9QyMyxv7v4oJzYQ66isYuvMbrE7aed8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718543720; c=relaxed/simple;
	bh=rujGMl43ds3KgPGEe7uVPBkGuPZoSnuts+m8Dz2+N+8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=gWoqSqjDKx6dP2XtogrLgtn1ir+OAgxPMLK+I/dyi6GxpHcTe/fpJZF3NerVqBg9vxla04RggPeczspzcL67qEose17P2nLVVtTYQTDHR4P6bsNW+gLtORBCOnbJQwGqXDQJOnB7WcvYmKS29fU9ZsyDnWL1mt6xsnCv89YGTuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-7ebd2481a89so389971839f.2
        for <netdev@vger.kernel.org>; Sun, 16 Jun 2024 06:15:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718543718; x=1719148518;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Dx9XGixapP39Ox7f/jgxQWueZhqtHuY/+w4E333XOsg=;
        b=VkoDVKd1W/dS5iwUMD+Kl66ewv7fTMyGd+IBsPipF4My0uLZhJdD01ZMPnWoVb5BEX
         y7hVjCda7RFsgPV4XJ5XBklEQWCllOr6kbX+5ydi04UB8Cvu1SaHOIIhg6w8feYrtCOp
         Qp1Rhho0dlwAhyhKfivXPrpqNbiY/KoKmL+8BMVKvfLwiiGcwSLbAJa4Cm9n41jEJJkT
         Y17mNBryvfCSUhXXFsP6W+sfkqxsrE9+4lGImqT1Xd8jB2buKsH3WiX8s3wF1VM/8xB0
         djAu/7kTih6JdZPyY57dyUV97OT7SEz/352EHvYH/WNfZlAeysVyJJQLEJlU3KqPMmz3
         Saqw==
X-Forwarded-Encrypted: i=1; AJvYcCUsVjytgPPQ0AgwP0dKRN1L0Sx5AH/SjBCuO2W2e2pqSMonea0s5d51uWlWtArXL3SKuHAYfAv1BF7TF0CPJca99wOlR7tZ
X-Gm-Message-State: AOJu0YyrtBKsLYnJ05utMg0fsneKZCasBJOb2m6eMhwf8WUH8DjORWKk
	BmtyLRWvYpRhgmb+B1XxPbJrYPsVDDt/Lml9yjwdc9CED9Q0cYbfDERuJw4Ps3KqHumK1EpDnjt
	478CR21MB0/JcLGKwR8AFea6TtijC/l4ETfCG6vEODbO2yjdslPs5480=
X-Google-Smtp-Source: AGHT+IE8U6OyTFtEEtS5CJoYCetePxZIFFilOnewN+foYtfP63I1lAiFVDTX6s15L4tJmIAp2tEPdvzBQzct4uQDQdCbTJJvi+6v
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1651:b0:4b9:8850:3dbf with SMTP id
 8926c6da1cb9f-4b988504403mr68547173.4.1718543718266; Sun, 16 Jun 2024
 06:15:18 -0700 (PDT)
Date: Sun, 16 Jun 2024 06:15:18 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000dbc80e061b01a34f@google.com>
Subject: [syzbot] [net?] [nfc?] KMSAN: uninit-value in nci_ntf_packet (3)
From: syzbot <syzbot+3f8fa0edaa75710cd66e@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, krzk@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    614da38e2f7a Merge tag 'hid-for-linus-2024051401' of git:/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1125e6fe980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f5d2cbf33633f507
dashboard link: https://syzkaller.appspot.com/bug?extid=3f8fa0edaa75710cd66e
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/89eafb874b71/disk-614da38e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/356000512ad9/vmlinux-614da38e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/839c73939115/bzImage-614da38e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3f8fa0edaa75710cd66e@syzkaller.appspotmail.com

nci: nci_rf_discover_ntf_packet: unsupported rf_tech_and_mode 0x6e
=====================================================
BUG: KMSAN: uninit-value in nci_rf_discover_ntf_packet net/nfc/nci/ntf.c:386 [inline]
BUG: KMSAN: uninit-value in nci_ntf_packet+0x2ac8/0x39c0 net/nfc/nci/ntf.c:798
 nci_rf_discover_ntf_packet net/nfc/nci/ntf.c:386 [inline]
 nci_ntf_packet+0x2ac8/0x39c0 net/nfc/nci/ntf.c:798
 nci_rx_work+0x288/0x5d0 net/nfc/nci/core.c:1532
 process_one_work kernel/workqueue.c:3267 [inline]
 process_scheduled_works+0xa81/0x1bd0 kernel/workqueue.c:3348
 worker_thread+0xea5/0x1560 kernel/workqueue.c:3429
 kthread+0x3e2/0x540 kernel/kthread.c:389
 ret_from_fork+0x6d/0x90 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Uninit was created at:
 slab_post_alloc_hook mm/slub.c:3877 [inline]
 slab_alloc_node mm/slub.c:3918 [inline]
 kmem_cache_alloc_node+0x622/0xc90 mm/slub.c:3961
 kmalloc_reserve+0x13d/0x4a0 net/core/skbuff.c:577
 __alloc_skb+0x35b/0x7a0 net/core/skbuff.c:668
 alloc_skb include/linux/skbuff.h:1319 [inline]
 virtual_ncidev_write+0x6d/0x290 drivers/nfc/virtual_ncidev.c:120
 vfs_write+0x497/0x14d0 fs/read_write.c:588
 ksys_write+0x20f/0x4c0 fs/read_write.c:643
 __do_sys_write fs/read_write.c:655 [inline]
 __se_sys_write fs/read_write.c:652 [inline]
 __x64_sys_write+0x93/0xe0 fs/read_write.c:652
 x64_sys_call+0x3062/0x3b50 arch/x86/include/generated/asm/syscalls_64.h:2
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

CPU: 0 PID: 2431 Comm: kworker/u8:8 Not tainted 6.9.0-syzkaller-02707-g614da38e2f7a #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
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


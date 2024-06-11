Return-Path: <netdev+bounces-102461-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C937E903261
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 08:21:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A5AC289D08
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 06:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B99A17109A;
	Tue, 11 Jun 2024 06:21:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC41171640
	for <netdev@vger.kernel.org>; Tue, 11 Jun 2024 06:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718086887; cv=none; b=G1yjVzqOfgjM2OMhOLSvluKmErXTZjr0ws1EST6oEZWxJqWl8Az/DZXHn87wY5Ff1StT4/I7eMgm8mqSP1GIjnJ6d9F6aSR9Xz0MJs5TSo8Vh0JSlSlOilWkHPwyhGkvqQviRFvKxafSJ1ceUzT/cgAEoK55fP2dM2qtIYohVjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718086887; c=relaxed/simple;
	bh=CqDG1xchg1Zq79fCCwKc00h20hrlWKLSZftL8B9BGjw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ZrULgn+BLtH095ywrWKYdr7xxInGrZginF6EOtNBfKAGVkEOT6z9+dVZxWk5T6frmtwj/1oO2WqeslPKhblNCN40hm6PRq33cV4tIqG4nhLhr78RoWg+C4mH1p71xoacBxAzhWHM93WDWBNypfNSw652yXddzbsAsISl70gB2cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-7eb61de14bbso431971539f.3
        for <netdev@vger.kernel.org>; Mon, 10 Jun 2024 23:21:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718086885; x=1718691685;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=whMQVx6Q5ysbxz2YokejrIpBQ9YrjYHYSvOnrc+a8nU=;
        b=jx1zV3lS82vyWgwjA8AuCDRlkV0EUHMFnjjI7FisysRTmqyXEUI8oJMpWHAGObrVKJ
         8gPXi1z06vFP/jSfPgNu9odVGD9XyooaM5sjoXky/IaTxdbuW7YkYAiKjjGWqkTUQ0/4
         KSfacdLXRvj1FqEq8PT+2RKuwI9hEGRFAkjGuY5mVXvAopqwF9R50WoIIJiZXM7ZPbt3
         6/lKYufk0DpOZLXrIRtv3BKY+N2S7izRRhL6nKgcUm3HDisvpDAvA9doXHhMwNn+bf19
         azSQMVa5SLGbWTclZJkuIDS5/kYOg2Qsfa+FtKdzpIrv+kynJxGqnEV24kWB8TdaEI72
         93Yg==
X-Forwarded-Encrypted: i=1; AJvYcCWX5flTymdxh963KtO2kV1CxjwNjEFiN0Pwnj/w/6DVrHHX2sBPULfFn0mSVzhbww0d/TdvHMVz7BLeH6qZfI5nJBIRqCMY
X-Gm-Message-State: AOJu0YwaAFPLeA3JmfOxlnkxaiMIDsF7LM2g+5AL3ueVqPtFSNdYQ6Kb
	L5UwbWGD76tJOlTxYnz+HCsZEMU02lQN3uMOroji0LBLwUMqKpbXf5OVFPXc2zERhGbFa1M8vN8
	sCtvXgnHGj9YR2YxpRjgsnYJ2BhELhSH2T+QYJEdqu2mVMnOSWVyV6EQ=
X-Google-Smtp-Source: AGHT+IFiJVAiUuTxM+9cXTrftF/vHy6bHN93ftxoWMdzTUJhAtHXBrvIE94R/4DXYeRCnJ0k8T7gGz2A5W7tQg46DFl6EbITv9hE
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8320:b0:4b7:c9b5:675c with SMTP id
 8926c6da1cb9f-4b7c9b56e75mr450968173.6.1718086884682; Mon, 10 Jun 2024
 23:21:24 -0700 (PDT)
Date: Mon, 10 Jun 2024 23:21:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000747dd6061a974686@google.com>
Subject: [syzbot] [net?] [nfc?] KMSAN: uninit-value in nci_rx_work (2)
From: syzbot <syzbot+3da70a0abd7f5765b6ea@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, krzk@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    614da38e2f7a Merge tag 'hid-for-linus-2024051401' of git:/..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=128ef202980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f5d2cbf33633f507
dashboard link: https://syzkaller.appspot.com/bug?extid=3da70a0abd7f5765b6ea
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1095a80a980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15a9179a980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/89eafb874b71/disk-614da38e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/356000512ad9/vmlinux-614da38e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/839c73939115/bzImage-614da38e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3da70a0abd7f5765b6ea@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in nci_rx_work+0x35a/0x5d0 net/nfc/nci/core.c:1519
 nci_rx_work+0x35a/0x5d0 net/nfc/nci/core.c:1519
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

CPU: 0 PID: 1079 Comm: kworker/u8:6 Not tainted 6.9.0-syzkaller-02707-g614da38e2f7a #0
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


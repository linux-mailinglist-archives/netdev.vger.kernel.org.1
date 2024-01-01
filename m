Return-Path: <netdev+bounces-60698-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BED538213D8
	for <lists+netdev@lfdr.de>; Mon,  1 Jan 2024 14:38:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB47D1C20A6D
	for <lists+netdev@lfdr.de>; Mon,  1 Jan 2024 13:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 327D04C6C;
	Mon,  1 Jan 2024 13:38:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD183C39
	for <netdev@vger.kernel.org>; Mon,  1 Jan 2024 13:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-35fcbe27a7fso104635275ab.2
        for <netdev@vger.kernel.org>; Mon, 01 Jan 2024 05:38:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704116305; x=1704721105;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8eap8sGDyCfHattzgeyRAIDTuquYNhctOM581pY8b98=;
        b=Zc1s+h+Tc5KEuHXIZcuhkbN+N2PU4zBMMS0fc8xYW+z8LFo9rdES0I4vwU9lKMRmgB
         6wyYyNRJVs526XUssiea8cpXPOpPCmVH/7TcptRddkVhZ+R9LBKjYy+hKHHkROyJtzQk
         18htTZo8qw6L/K/HYH1/2Hl2xpLqwKKwO9Wwk4uWJ4zNmUxF0jWWJ1wOtE8eFn5RfKYz
         rAgReH8khTsoq4Cp51h78JZcRW7y0j32UB5HuiHtj/1jAawlWssvbjXTrY/yldiSr6SO
         eRTh7n4IiMNu8PD05WThdtCnRFNLq9Wk1ysYftvxqHBMKpNyDKBBfhMJ9t6u6t4fsQLU
         PXUw==
X-Gm-Message-State: AOJu0Yw2Xy9CoyW+8YELRiggDlJoOM+8tjHc4+GjpbdydCRxZbOlSP6g
	/JhUX7B+Q6pFcASypS5H3ggr3ik4UZnZPEmT7MBq0l3qkEVG
X-Google-Smtp-Source: AGHT+IE2mr2MzyBIT3GSpbeKQEmyWoTHOjVEM6nd6oH4jJniInJ5g903f7YZ5JPtGOV1GLL+ntCJoBORC8tImUSk8ZmMgwHf+j94
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1b09:b0:35f:c723:1f62 with SMTP id
 i9-20020a056e021b0900b0035fc7231f62mr2340350ilv.0.1704116304981; Mon, 01 Jan
 2024 05:38:24 -0800 (PST)
Date: Mon, 01 Jan 2024 05:38:24 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000003b4af060de27f6b@google.com>
Subject: [syzbot] [net?] [nfc?] KMSAN: uninit-value in nci_rx_work
From: syzbot <syzbot+d7b4dc6cd50410152534@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, krzysztof.kozlowski@linaro.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    861deac3b092 Linux 6.7-rc7
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=136a5231e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e0c7078a6b901aa3
dashboard link: https://syzkaller.appspot.com/bug?extid=d7b4dc6cd50410152534
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=111729e9e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1018379ee80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/0ea60ee8ed32/disk-861deac3.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6d69fdc33021/vmlinux-861deac3.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f0158750d452/bzImage-861deac3.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d7b4dc6cd50410152534@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in nci_rx_work+0x2e6/0x500 net/nfc/nci/core.c:1516
 nci_rx_work+0x2e6/0x500 net/nfc/nci/core.c:1516
 process_one_work kernel/workqueue.c:2627 [inline]
 process_scheduled_works+0x104e/0x1e70 kernel/workqueue.c:2700
 worker_thread+0xf45/0x1490 kernel/workqueue.c:2781
 kthread+0x3ed/0x540 kernel/kthread.c:388
 ret_from_fork+0x66/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242

Uninit was created at:
 slab_post_alloc_hook+0x129/0xa70 mm/slab.h:768
 slab_alloc_node mm/slub.c:3478 [inline]
 kmem_cache_alloc_node+0x5e9/0xb10 mm/slub.c:3523
 kmalloc_reserve+0x13d/0x4a0 net/core/skbuff.c:560
 __alloc_skb+0x318/0x740 net/core/skbuff.c:651
 alloc_skb include/linux/skbuff.h:1286 [inline]
 virtual_ncidev_write+0x6d/0x280 drivers/nfc/virtual_ncidev.c:120
 vfs_write+0x561/0x1490 fs/read_write.c:582
 ksys_write+0x20f/0x4c0 fs/read_write.c:637
 __do_sys_write fs/read_write.c:649 [inline]
 __se_sys_write fs/read_write.c:646 [inline]
 __x64_sys_write+0x93/0xd0 fs/read_write.c:646
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x44/0x110 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

CPU: 0 PID: 743 Comm: kworker/u4:5 Not tainted 6.7.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
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


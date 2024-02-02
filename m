Return-Path: <netdev+bounces-68516-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A6772847114
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 14:26:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B8731F2B293
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 13:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 408B2210E8;
	Fri,  2 Feb 2024 13:26:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C7746BA6
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 13:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706880390; cv=none; b=ASzaZSrmkzzF6fhdUoIwLplMRvZSMiPP9aOWlms6QIoqirluDdUyKqXx8SqaumfQSywBc840e600+KIdxPQXdl+Q22eUM2j8v7AublVwiAnmsJYrDjPXd68AZ0IHap/AZro/YM9nMmIConhGLJH22nwZE+Z1ykoSlzMSpUVhP4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706880390; c=relaxed/simple;
	bh=KLxDiPiyVQp8O7VrBW9nbcoJepaggI/il2KlGnI5r0c=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=jviGkD3ot3D+4SWuzITrZcow28nhcVxyiRmfqNnT1v0heDzkbO7XcxzuDUxXy2tCzLylPywF8QhCWcTZC0AS72NhhKUT68r9igQ+jbD9RgCjpxT9liRw6FW2MWpjWlxcA2gXZ0tK6WL0cltlq8WsVHjPkWVUtURQ7/5yvy9YG3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7bad62322f0so225521939f.3
        for <netdev@vger.kernel.org>; Fri, 02 Feb 2024 05:26:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706880387; x=1707485187;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W2sCNcl4AqQHpmP9sWW84f5Es4bmxjLsfPGFyaTZ3lM=;
        b=Dk1mtekyrlaMxw6XU7QgzpvI6zc1W9k2pyESR6Nu1G3vkjgvlV0/hIrRJV777n22fC
         4yP+owcHVFpo/cTmKorbh1sg4EUVzQAezJpGHB9Kq4L1SB1J8nKrOflj5QPKyBX+Sm8+
         iQSAcqSGtWvz3zOmLp/fFRbFHPaR0NOPtngCp9kFYPSvmAhJ1XrxNc8ZaHUCi9SO8ook
         dLqpI4F2NEZ4qIGhOo39aV3gRATaqZ81G8qsglRgbF+CE8Ye0jnjfomRYaH7Q27cbF9H
         luPLIwQEnFXN2WkT90FAZ85obJZYwbzOd5sjWpLz2Y0J5iSnXo7lsgunnrdqGEvHccwo
         ALPw==
X-Gm-Message-State: AOJu0YxP/97UWQt4KgnZ2gpLomPtfOypUaYE75Fb0/J02sPI6RR/fxIC
	INgMmLNxD+/DIAoSVqktmAl3FTj7Dwnudhc03n00lUtv27OWKPmbKdSs+cn4vnnqmIf98gGUqgg
	nd5t3WHicxdzbzMElx+F4foscHw/Tqs68NjUXLO7LHFsaBKtyogACUKA=
X-Google-Smtp-Source: AGHT+IFtLrYDJfROfbo1j0plwf+ObWUzjIzJM2G+LNOWxZuOFm5NYetxCdZpj2UrAJijq4pmczxdmmk0luPV1anlrifF285KB946
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c2d:b0:363:9d58:805b with SMTP id
 m13-20020a056e021c2d00b003639d58805bmr235355ilh.3.1706880387574; Fri, 02 Feb
 2024 05:26:27 -0800 (PST)
Date: Fri, 02 Feb 2024 05:26:27 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002cf4690610660f71@google.com>
Subject: [syzbot] [net?] KMSAN: kernel-infoleak in __skb_datagram_iter (2)
From: syzbot <syzbot+34ad5fab48f7bf510349@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    5bd7ef53ffe5 Merge tag 'pull-fixes' of git://git.kernel.or..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=13c1aee6e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f3f069371247b697
dashboard link: https://syzkaller.appspot.com/bug?extid=34ad5fab48f7bf510349
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15555751e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10c93571e80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/cd1e7587b624/disk-5bd7ef53.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/62969c864f78/vmlinux-5bd7ef53.xz
kernel image: https://storage.googleapis.com/syzbot-assets/af66253a313c/bzImage-5bd7ef53.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+34ad5fab48f7bf510349@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: kernel-infoleak-after-free in instrument_copy_to_user include/linux/instrumented.h:114 [inline]
BUG: KMSAN: kernel-infoleak-after-free in copy_to_user_iter lib/iov_iter.c:24 [inline]
BUG: KMSAN: kernel-infoleak-after-free in iterate_ubuf include/linux/iov_iter.h:29 [inline]
BUG: KMSAN: kernel-infoleak-after-free in iterate_and_advance2 include/linux/iov_iter.h:245 [inline]
BUG: KMSAN: kernel-infoleak-after-free in iterate_and_advance include/linux/iov_iter.h:271 [inline]
BUG: KMSAN: kernel-infoleak-after-free in _copy_to_iter+0x364/0x2520 lib/iov_iter.c:186
 instrument_copy_to_user include/linux/instrumented.h:114 [inline]
 copy_to_user_iter lib/iov_iter.c:24 [inline]
 iterate_ubuf include/linux/iov_iter.h:29 [inline]
 iterate_and_advance2 include/linux/iov_iter.h:245 [inline]
 iterate_and_advance include/linux/iov_iter.h:271 [inline]
 _copy_to_iter+0x364/0x2520 lib/iov_iter.c:186
 copy_to_iter include/linux/uio.h:197 [inline]
 simple_copy_to_iter+0x68/0xa0 net/core/datagram.c:532
 __skb_datagram_iter+0x123/0xdc0 net/core/datagram.c:420
 skb_copy_datagram_iter+0x5c/0x200 net/core/datagram.c:546
 skb_copy_datagram_msg include/linux/skbuff.h:3960 [inline]
 packet_recvmsg+0xd9c/0x2000 net/packet/af_packet.c:3482
 sock_recvmsg_nosec net/socket.c:1044 [inline]
 sock_recvmsg net/socket.c:1066 [inline]
 sock_read_iter+0x467/0x580 net/socket.c:1136
 call_read_iter include/linux/fs.h:2014 [inline]
 new_sync_read fs/read_write.c:389 [inline]
 vfs_read+0x8f6/0xe00 fs/read_write.c:470
 ksys_read+0x20f/0x4c0 fs/read_write.c:613
 __do_sys_read fs/read_write.c:623 [inline]
 __se_sys_read fs/read_write.c:621 [inline]
 __x64_sys_read+0x93/0xd0 fs/read_write.c:621
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x44/0x110 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

Uninit was stored to memory at:
 skb_put_data include/linux/skbuff.h:2622 [inline]
 netlink_to_full_skb net/netlink/af_netlink.c:181 [inline]
 __netlink_deliver_tap_skb net/netlink/af_netlink.c:298 [inline]
 __netlink_deliver_tap+0x5be/0xc90 net/netlink/af_netlink.c:325
 netlink_deliver_tap net/netlink/af_netlink.c:338 [inline]
 netlink_deliver_tap_kernel net/netlink/af_netlink.c:347 [inline]
 netlink_unicast_kernel net/netlink/af_netlink.c:1341 [inline]
 netlink_unicast+0x10f1/0x1250 net/netlink/af_netlink.c:1368
 netlink_sendmsg+0x1238/0x13d0 net/netlink/af_netlink.c:1910
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg net/socket.c:745 [inline]
 ____sys_sendmsg+0x9c2/0xd60 net/socket.c:2584
 ___sys_sendmsg+0x28d/0x3c0 net/socket.c:2638
 __sys_sendmsg net/socket.c:2667 [inline]
 __do_sys_sendmsg net/socket.c:2676 [inline]
 __se_sys_sendmsg net/socket.c:2674 [inline]
 __x64_sys_sendmsg+0x307/0x490 net/socket.c:2674
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x44/0x110 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

Uninit was created at:
 free_pages_prepare mm/page_alloc.c:1087 [inline]
 free_unref_page_prepare+0xb0/0xa40 mm/page_alloc.c:2347
 free_unref_page_list+0xeb/0x1100 mm/page_alloc.c:2533
 release_pages+0x23d3/0x2410 mm/swap.c:1042
 free_pages_and_swap_cache+0xd9/0xf0 mm/swap_state.c:316
 tlb_batch_pages_flush mm/mmu_gather.c:98 [inline]
 tlb_flush_mmu_free mm/mmu_gather.c:293 [inline]
 tlb_flush_mmu+0x6f5/0x980 mm/mmu_gather.c:300
 tlb_finish_mmu+0x101/0x260 mm/mmu_gather.c:392
 exit_mmap+0x49e/0xd30 mm/mmap.c:3321
 __mmput+0x13f/0x530 kernel/fork.c:1349
 mmput+0x8a/0xa0 kernel/fork.c:1371
 exit_mm+0x1b8/0x360 kernel/exit.c:567
 do_exit+0xd57/0x4080 kernel/exit.c:858
 do_group_exit+0x2fd/0x390 kernel/exit.c:1021
 __do_sys_exit_group kernel/exit.c:1032 [inline]
 __se_sys_exit_group kernel/exit.c:1030 [inline]
 __x64_sys_exit_group+0x3c/0x50 kernel/exit.c:1030
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x44/0x110 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

Bytes 3852-3903 of 3904 are uninitialized
Memory access of size 3904 starts at ffff88812ea1e000
Data copied to user address 0000000020003280

CPU: 1 PID: 5043 Comm: syz-executor297 Not tainted 6.7.0-rc5-syzkaller-00047-g5bd7ef53ffe5 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/10/2023
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


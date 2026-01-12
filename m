Return-Path: <netdev+bounces-249156-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 61961D1525B
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 21:02:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 62CD9300A2AB
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 20:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D774131AA83;
	Mon, 12 Jan 2026 20:02:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f79.google.com (mail-oa1-f79.google.com [209.85.160.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B9C2D839E
	for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 20:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768248141; cv=none; b=tNqGgUrtpooCnRwxyrxaTf4U5BcXXv0QyugLUGtUAbjAZHFJWEt/XQaP+tiWlPY/6pjlToI+o23S7jd1OexpgTiSXR7m3MNiEG9Kw8IAGwbXq6t4K6mYLuCbEuISW9mQUj+nYY0e0phvNPq4ig2c2+vYHAINhCc2goNRX4DyKVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768248141; c=relaxed/simple;
	bh=yERk988J8WSuxkAUOYHeDqadc6S8MRdTfxUh4QNnNas=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=LMJ4iqvFi1xQ2NIl7cx8a00pyUKvEea0hnylpzf2taJSmz40WJfWFKQJ3CtNy9C6zWc6B2TQBXm/QoPOlqEU4GJzmIGIFdlcxXxLThlapJKdWikuxuh7QPwDmbVuY5rMPkP9KBMC143oNqKjHoGHb3tvDrflAPDy976+2m4XzRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.160.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa1-f79.google.com with SMTP id 586e51a60fabf-3fea6c3e817so13944628fac.1
        for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 12:02:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768248139; x=1768852939;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wty6kl/vaGXT/vbAntON52X8q04OV9SYetRDcXlHvvs=;
        b=vF0G/jqDNy/5+zgpMPQtDUj/kLvWCos/6SOgeglBSGUct6tk/a8RgzCsIgkk+yFvqa
         qgqt0Pet5sEIahPaG1crXaVHmQpVIvoGNugk8GY639Q3P8Xb9hxRZD88pbpo/aY32iaD
         rWsW+wzpfgrPrXB6ZsY2xurp+mQ8IrKo+bFYSeqV7fM90SiIwz9oEhnigCngnqXV7sAI
         5sKigEGnmT+qoHnZRgfIUgM26wBFgRZdjVTJsACi796kCT/jHDfEAvfXMuZQDmIaQfmV
         luoxPK0d8sqgG4TZqd0vU+bM9dWVd5ineMAHsZ0JZzB6r/G4ewKUR6Rme6APcY2GrQBm
         DDcQ==
X-Forwarded-Encrypted: i=1; AJvYcCUISznIukQKEne5S8oVyh/axZOkxKGbkEoWt53bOBCSqVJ6TGmv+PBrMjQednmptFlWvA1Fg7c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJmGEmAIaxqWfrf09uOvRMNwuU5Te+QDczySSeBmLhfgWE8s0A
	sWRfc968CZ+a+0GhX/r7jh8hy+MAuuVefsj67FM+e5gmF2YG9SYm/gFhMNQJFI0pqPHOQzwF8/A
	jfBdY9sOnds9sDZ7j28jHGuKQfw/EUUn7X/gZfSpsjvBN0OImLV5S2qbeSYc=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:2bc4:b0:65f:552e:2ceb with SMTP id
 006d021491bc7-660f29f93b0mr189331eaf.25.1768248139186; Mon, 12 Jan 2026
 12:02:19 -0800 (PST)
Date: Mon, 12 Jan 2026 12:02:19 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6965534b.050a0220.38aacd.0001.GAE@google.com>
Subject: [syzbot] [net?] memory leak in __build_skb (4)
From: syzbot <syzbot+4d8c7d16b0e95c0d0f0d@syzkaller.appspotmail.com>
To: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	jasowang@redhat.com, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com, 
	willemdebruijn.kernel@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    623fb9912f6a Merge tag 'pinctrl-v6.19-2' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=149a1922580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d60836e327fd6756
dashboard link: https://syzkaller.appspot.com/bug?extid=4d8c7d16b0e95c0d0f0d
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=137fb1fc580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14c0519a580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/a5d95462c1e9/disk-623fb991.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0305879ad943/vmlinux-623fb991.xz
kernel image: https://storage.googleapis.com/syzbot-assets/98136e3b98e4/bzImage-623fb991.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4d8c7d16b0e95c0d0f0d@syzkaller.appspotmail.com

BUG: memory leak
unreferenced object 0xffff888109695a00 (size 240):
  comm "syz.0.17", pid 6088, jiffies 4294943096
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 40 c2 10 81 88 ff ff 00 00 00 00 00 00 00 00  .@..............
  backtrace (crc a84b336f):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4958 [inline]
    slab_alloc_node mm/slub.c:5263 [inline]
    kmem_cache_alloc_noprof+0x3b4/0x590 mm/slub.c:5270
    __build_skb+0x23/0x60 net/core/skbuff.c:474
    build_skb+0x20/0x190 net/core/skbuff.c:490
    __tun_build_skb drivers/net/tun.c:1541 [inline]
    tun_build_skb+0x4a1/0xa40 drivers/net/tun.c:1636
    tun_get_user+0xc12/0x2030 drivers/net/tun.c:1770
    tun_chr_write_iter+0x71/0x120 drivers/net/tun.c:1999
    new_sync_write fs/read_write.c:593 [inline]
    vfs_write+0x45d/0x710 fs/read_write.c:686
    ksys_write+0xa7/0x170 fs/read_write.c:738
    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
    do_syscall_64+0xa4/0xf80 arch/x86/entry/syscall_64.c:94
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

BUG: memory leak
unreferenced object 0xffff8881037b5e40 (size 192):
  comm "syz.0.17", pid 6088, jiffies 4294943096
  hex dump (first 32 bytes):
    00 40 9c 26 81 88 ff ff c0 66 0b 87 ff ff ff ff  .@.&.....f......
    21 52 bc 85 ff ff ff ff 00 00 00 00 00 00 00 00  !R..............
  backtrace (crc fcd1b1c6):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4958 [inline]
    slab_alloc_node mm/slub.c:5263 [inline]
    kmem_cache_alloc_noprof+0x3b4/0x590 mm/slub.c:5270
    dst_alloc+0x5b/0xe0 net/core/dst.c:89
    rt_dst_alloc+0x32/0xe0 net/ipv4/route.c:1651
    ip_route_input_slow+0xaa0/0x1560 net/ipv4/route.c:2429
    ip_route_input_rcu net/ipv4/route.c:2543 [inline]
    ip_route_input_noref+0xd1/0xe0 net/ipv4/route.c:2554
    ip_rcv_finish_core+0xca/0x7f0 net/ipv4/ip_input.c:368
    ip_rcv_finish net/ipv4/ip_input.c:451 [inline]
    NF_HOOK include/linux/netfilter.h:318 [inline]
    NF_HOOK include/linux/netfilter.h:312 [inline]
    ip_rcv+0x197/0x240 net/ipv4/ip_input.c:573
    __netif_receive_skb_one_core+0xd0/0x100 net/core/dev.c:6139
    __netif_receive_skb+0x1d/0x80 net/core/dev.c:6252
    netif_receive_skb_internal net/core/dev.c:6338 [inline]
    netif_receive_skb+0x49/0x240 net/core/dev.c:6397
    tun_rx_batched drivers/net/tun.c:1485 [inline]
    tun_get_user+0x1dbf/0x2030 drivers/net/tun.c:1953
    tun_chr_write_iter+0x71/0x120 drivers/net/tun.c:1999
    new_sync_write fs/read_write.c:593 [inline]
    vfs_write+0x45d/0x710 fs/read_write.c:686
    ksys_write+0xa7/0x170 fs/read_write.c:738
    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
    do_syscall_64+0xa4/0xf80 arch/x86/entry/syscall_64.c:94
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

BUG: memory leak
unreferenced object 0xffff8881095d2200 (size 240):
  comm "syz.0.18", pid 6092, jiffies 4294943097
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 40 c2 10 81 88 ff ff 00 00 00 00 00 00 00 00  .@..............
  backtrace (crc e1df1ba8):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4958 [inline]
    slab_alloc_node mm/slub.c:5263 [inline]
    kmem_cache_alloc_noprof+0x3b4/0x590 mm/slub.c:5270
    __build_skb+0x23/0x60 net/core/skbuff.c:474
    build_skb+0x20/0x190 net/core/skbuff.c:490
    __tun_build_skb drivers/net/tun.c:1541 [inline]
    tun_build_skb+0x4a1/0xa40 drivers/net/tun.c:1636
    tun_get_user+0xc12/0x2030 drivers/net/tun.c:1770
    tun_chr_write_iter+0x71/0x120 drivers/net/tun.c:1999
    new_sync_write fs/read_write.c:593 [inline]
    vfs_write+0x45d/0x710 fs/read_write.c:686
    ksys_write+0xa7/0x170 fs/read_write.c:738
    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
    do_syscall_64+0xa4/0xf80 arch/x86/entry/syscall_64.c:94
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

BUG: memory leak
unreferenced object 0xffff888109688800 (size 240):
  comm "syz.0.19", pid 6094, jiffies 4294943098
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 40 c2 10 81 88 ff ff 00 00 00 00 00 00 00 00  .@..............
  backtrace (crc 4b7eec9d):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4958 [inline]
    slab_alloc_node mm/slub.c:5263 [inline]
    kmem_cache_alloc_noprof+0x3b4/0x590 mm/slub.c:5270
    __build_skb+0x23/0x60 net/core/skbuff.c:474
    build_skb+0x20/0x190 net/core/skbuff.c:490
    __tun_build_skb drivers/net/tun.c:1541 [inline]
    tun_build_skb+0x4a1/0xa40 drivers/net/tun.c:1636
    tun_get_user+0xc12/0x2030 drivers/net/tun.c:1770
    tun_chr_write_iter+0x71/0x120 drivers/net/tun.c:1999
    new_sync_write fs/read_write.c:593 [inline]
    vfs_write+0x45d/0x710 fs/read_write.c:686
    ksys_write+0xa7/0x170 fs/read_write.c:738
    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
    do_syscall_64+0xa4/0xf80 arch/x86/entry/syscall_64.c:94
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

connection error: failed to recv *flatrpc.ExecutorMessageRawT: EOF


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


Return-Path: <netdev+bounces-250319-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FB92D2884B
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 21:48:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 04B2E303D8A2
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 20:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E3282D94B5;
	Thu, 15 Jan 2026 20:48:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f78.google.com (mail-oo1-f78.google.com [209.85.161.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5505A2749C1
	for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 20:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768510103; cv=none; b=MLF5nDJffmIMimfEk9IzTXWGrJNNxq+zGD8kYcsYHxfxL3x4f55SDySHxxfz39HIO7NlRZdbUwwB5j0ALvth0h3w/570R4e7yf2rrC/WxP819NO8Yf4hpMtlkXjmWK9hAbrFH/CTQ9Xw0Q9l4v1LnmBgIciBmVSmPvWoGFj6REs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768510103; c=relaxed/simple;
	bh=zVGEiAwx7YLpCW60ytR8H/+i3S+caDzo5TkKAJ8fJvE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=qJ9mUVPj5ySZR1KCogyzKzdORxkaxgJcbGzNtjMSWGIwJrb0lwgjTD3rTrO6oyzAixWutMxSli9OmxQeRfAiYds4s/u3IhMODur+98pgQWBywwtXJ7/qkjlXP/D26U6Zi1Xhp0DWxC3DPwuznKuByt0JKMxNUC/ebvAhISCAPt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f78.google.com with SMTP id 006d021491bc7-66108d1cd11so4476167eaf.2
        for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 12:48:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768510100; x=1769114900;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZhKom9qqKQVcPcknN+ZGzSOAHRt18rVQOL6Aj/rIsMk=;
        b=oVfxxPsZDaR38/g3Rx6uu3v5O/uyHOQuRpbtISg+ni9/dwO4ugHI58BhaDtaod0RWH
         MBRnXMx37xL5WCaNPCCGpSxwchY/rcfdgbayNq5V5UJt+K317xy1Nvp/CLo045EdjXpx
         iW7b2mCjmKBVjiucNwiIZnFeM1x6Fe98YxJsbgQ3bYbvzc8k6my3+6ogSVtW/+FGjLI4
         6pM/UVGpXB+Z5vRH6+UHLuL0HV+ua6f75LH5o13bQpY/4wMNuwVWWNkostvJEHUIgty9
         nfqwFrMi95HOVtzNQw0yhz5LTXVLL2EgRhXCELkiA2lxpyoJ0Cyp7E5Ixl9MCd1jfV6V
         PuPQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6RhI6D3ZqrSUOhUaZBMapwcB6ZUjewX+vK7TlaZJcbcGw9DUogn6x0m+/k3udmHhskwu3Mwo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJs4irKyzgGumwguf3CbpGr5h6euRo/0Gxd19Rcy/mgXzzmygl
	okjJEbmdPvcAwrqugR+VDadSg3e7IQLRwEEZfcJZO7ZyA76PpPdOJ9PhzuNyJhAvrvyX8YbiyQ7
	hDZwYa4F5sqyzJvRHFxW6BJAyRMDaMMXNdnjwNojrZJPcy9vot51dV8i9DKk=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:188b:b0:659:9a49:8f5e with SMTP id
 006d021491bc7-66117984683mr401404eaf.35.1768510100404; Thu, 15 Jan 2026
 12:48:20 -0800 (PST)
Date: Thu, 15 Jan 2026 12:48:20 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69695294.050a0220.58bed.002b.GAE@google.com>
Subject: [syzbot] [net?] [virt?] memory leak in napi_skb_cache_get (2)
From: syzbot <syzbot+7ff4013eabad1407b70a@syzkaller.appspotmail.com>
To: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	eperezma@redhat.com, jasowang@redhat.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com, 
	virtualization@lists.linux.dev, xuanzhuo@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    0f61b1860cc3 Linux 6.19-rc5
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=110e7922580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=87bc41cae23d2144
dashboard link: https://syzkaller.appspot.com/bug?extid=7ff4013eabad1407b70a
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1241a99a580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=165b8052580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/fba5be00b810/disk-0f61b186.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/fc83311cd569/vmlinux-0f61b186.xz
kernel image: https://storage.googleapis.com/syzbot-assets/005d9685b497/bzImage-0f61b186.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7ff4013eabad1407b70a@syzkaller.appspotmail.com

BUG: memory leak
unreferenced object 0xffff88810a03e300 (size 240):
  comm "softirq", pid 0, jiffies 4294943617
  hex dump (first 32 bytes):
    90 dc d8 12 81 88 ff ff 90 dc d8 12 81 88 ff ff  ................
    00 00 00 00 00 00 00 00 00 dc d8 12 81 88 ff ff  ................
  backtrace (crc 2f85baf):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4958 [inline]
    kmem_cache_alloc_bulk_noprof+0x22d/0x3e0 mm/slub.c:7521
    napi_skb_cache_get+0xa9/0xd0 net/core/skbuff.c:291
    __alloc_skb+0x214/0x2b0 net/core/skbuff.c:668
    napi_alloc_skb+0x118/0x180 net/core/skbuff.c:832
    page_to_skb+0xee/0x5e0 drivers/net/virtio_net.c:904
    receive_mergeable drivers/net/virtio_net.c:2514 [inline]
    receive_buf+0x49f/0x2670 drivers/net/virtio_net.c:2660
    virtnet_receive_packets drivers/net/virtio_net.c:3023 [inline]
    virtnet_receive drivers/net/virtio_net.c:3047 [inline]
    virtnet_poll+0x7d6/0x16e0 drivers/net/virtio_net.c:3136
    __napi_poll+0x44/0x3a0 net/core/dev.c:7668
    napi_poll net/core/dev.c:7731 [inline]
    net_rx_action+0x492/0x560 net/core/dev.c:7883
    handle_softirqs+0xe1/0x2e0 kernel/softirq.c:622
    __do_softirq kernel/softirq.c:656 [inline]
    invoke_softirq kernel/softirq.c:496 [inline]
    __irq_exit_rcu+0x98/0xc0 kernel/softirq.c:723
    common_interrupt+0x87/0xa0 arch/x86/kernel/irq.c:319
    asm_common_interrupt+0x26/0x40 arch/x86/include/asm/idtentry.h:688

BUG: memory leak
unreferenced object 0xffff88810adf5e40 (size 704):
  comm "kworker/u9:0", pid 51, jiffies 4294943617
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc f18cfd82):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4958 [inline]
    slab_alloc_node mm/slub.c:5263 [inline]
    kmem_cache_alloc_node_noprof+0x384/0x5a0 mm/slub.c:5315
    kmalloc_reserve+0xe6/0x180 net/core/skbuff.c:586
    __alloc_skb+0x111/0x2b0 net/core/skbuff.c:690
    alloc_skb include/linux/skbuff.h:1383 [inline]
    __skb_tstamp_tx+0x162/0x4c0 net/core/skbuff.c:5677
    hci_conn_tx_queue+0x11c/0x1d0 net/bluetooth/hci_conn.c:3049
    hci_send_conn_frame net/bluetooth/hci_core.c:3086 [inline]
    hci_sched_acl_pkt net/bluetooth/hci_core.c:3701 [inline]
    hci_sched_acl net/bluetooth/hci_core.c:3726 [inline]
    hci_tx_work+0x437/0x570 net/bluetooth/hci_core.c:3820
    process_one_work+0x26b/0x620 kernel/workqueue.c:3257
    process_scheduled_works kernel/workqueue.c:3340 [inline]
    worker_thread+0x2c4/0x4f0 kernel/workqueue.c:3421
    kthread+0x15b/0x310 kernel/kthread.c:463
    ret_from_fork+0x2cf/0x300 arch/x86/kernel/process.c:158
    ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246

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


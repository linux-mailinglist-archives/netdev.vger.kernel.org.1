Return-Path: <netdev+bounces-82812-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 381C888FDA3
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 12:01:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9AF9297C85
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 11:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C281B2B9C6;
	Thu, 28 Mar 2024 11:00:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3DA7E772
	for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 11:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711623633; cv=none; b=ezQVu8OxrAPf8uKNYsdv1Wdtxr+5f+k33cxsd+cftxkJHmkpGiYtGUJSiz+ciZX4O+fqRqvAiqtlkw+WC163dmRwVrNjZUFgjkT/0oIhkxoBTS7+G3MChsQhVS/iuJ93QE5PAgNZv3lyjdGimatEWwj88SNUDh1F5Q4JlRpU/oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711623633; c=relaxed/simple;
	bh=gUOXYM4bVgset/nR6zi6lOb0vEGmFQamNpVwmbIXeek=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=mqRfXvVeEfG0P1aR2HKfF1LzJDbPo9rNYPGhNSaB7jSLHRJs7eQekf2LpT2+T69iu5xxOsigjdmfPfVQY/FoDJGDJn/Zsln05WrAaUAwrYWRhTDZ8ANYCc2FU4xFw5g6nlmQ7ijC+u4VbY6sZFLsjRPjku8AA0EpIftfNAADS20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-368b34923f9so5203515ab.2
        for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 04:00:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711623630; x=1712228430;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uGYy87WuxWVwPeyUOhAIs4VGtvIzvf1P5xYIpgTtD2k=;
        b=EbmjbDv7tunue8Kmw6wN1AQsSrfYeJ2XnllK316Lxy1YshAQWWmM2yJ/rhT/EiSy5D
         +84D37/0N9m7gDbai9++yEbDU1t2OTRfWndLNtIs0qY/HsZaeqYM1C+sZPtRaiyKMUaU
         49leQy/5T8VNrzIeiNjRCCIMgzaO3k1tPqxGO6mtKOOpHRU+RzvpQhKhtoJw75fxSb60
         7tMa3OKJP4GW1pj9rJxuagaWAmE1h/3pBP/xXnYmkEX1F7gW7M9uv7YaarAE0GO4YY77
         PfNayOHnl9V3xVZ/by2xd7+uH1hdayETnYIQQm4ea1+Y395Mz0iNUmPyKcOJ23LiXuct
         0+oA==
X-Forwarded-Encrypted: i=1; AJvYcCW6CtMB5zdHQ6TDIgecRw9lgWORQg1zpzG9zZdU9+Yjs/wTMF97zkjdLBv6vdiwaP7Uc38UsmyfkyTkYgl9Vic/UiTy3ul7
X-Gm-Message-State: AOJu0YwTBqMpgI65F3EOgnQJwN07DuuCNIxMybgBDmU8WAaktmHXypDY
	pf9LXxzE6H+vLu782zHgdIOxgNmsBsF5KOrvXNI3AcxqDQdl3wWvsJj2mhzp2BsmlyGY1S62wm/
	a709RAK7aqjduyycE8ZByzNklZnXR5UlHdf0ihrBNP7kljD0AwchPGiI=
X-Google-Smtp-Source: AGHT+IHAdqnznGsXhILsdv1z/RpUEu4pA+WPctS6LOwCNBu/3nlfBz44mWg0K3ux+QoiIGSVbNbG9bpwYlNbecbfxwhJTCe2CzUG
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12c1:b0:368:9bf7:6b6f with SMTP id
 i1-20020a056e0212c100b003689bf76b6fmr101199ilm.3.1711623630166; Thu, 28 Mar
 2024 04:00:30 -0700 (PDT)
Date: Thu, 28 Mar 2024 04:00:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000772f2c0614b66ef7@google.com>
Subject: [syzbot] [net?] KMSAN: uninit-value in gre_rcv (3)
From: syzbot <syzbot+1c1cf138518bf0c53d68@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    962490525cff Merge tag 'probes-fixes-v6.9-rc1' of git://gi..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=10f20ed9180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e2599baf258ef795
dashboard link: https://syzkaller.appspot.com/bug?extid=1c1cf138518bf0c53d68
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13686595180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10581231180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ef3aa69f9748/disk-96249052.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/258fffe9afb1/vmlinux-96249052.xz
kernel image: https://storage.googleapis.com/syzbot-assets/56345f303e67/bzImage-96249052.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1c1cf138518bf0c53d68@syzkaller.appspotmail.com

syz-executor114 uses obsolete (PF_INET,SOCK_PACKET)
=====================================================
BUG: KMSAN: uninit-value in pskb_may_pull_reason include/linux/skbuff.h:2742 [inline]
BUG: KMSAN: uninit-value in pskb_may_pull include/linux/skbuff.h:2756 [inline]
BUG: KMSAN: uninit-value in ip6erspan_rcv net/ipv6/ip6_gre.c:541 [inline]
BUG: KMSAN: uninit-value in gre_rcv+0x11f8/0x1930 net/ipv6/ip6_gre.c:610
 pskb_may_pull_reason include/linux/skbuff.h:2742 [inline]
 pskb_may_pull include/linux/skbuff.h:2756 [inline]
 ip6erspan_rcv net/ipv6/ip6_gre.c:541 [inline]
 gre_rcv+0x11f8/0x1930 net/ipv6/ip6_gre.c:610
 ip6_protocol_deliver_rcu+0x1d4c/0x2ca0 net/ipv6/ip6_input.c:438
 ip6_input_finish net/ipv6/ip6_input.c:483 [inline]
 NF_HOOK include/linux/netfilter.h:314 [inline]
 ip6_input+0x15d/0x430 net/ipv6/ip6_input.c:492
 ip6_mc_input+0xa7e/0xc80 net/ipv6/ip6_input.c:586
 dst_input include/net/dst.h:460 [inline]
 ip6_rcv_finish+0x955/0x970 net/ipv6/ip6_input.c:79
 NF_HOOK include/linux/netfilter.h:314 [inline]
 ipv6_rcv+0xde/0x390 net/ipv6/ip6_input.c:310
 __netif_receive_skb_one_core net/core/dev.c:5538 [inline]
 __netif_receive_skb+0x1da/0xa00 net/core/dev.c:5652
 netif_receive_skb_internal net/core/dev.c:5738 [inline]
 netif_receive_skb+0x58/0x660 net/core/dev.c:5798
 tun_rx_batched+0x3ee/0x980 drivers/net/tun.c:1549
 tun_get_user+0x5566/0x69e0 drivers/net/tun.c:2002
 tun_chr_write_iter+0x3af/0x5d0 drivers/net/tun.c:2048
 call_write_iter include/linux/fs.h:2108 [inline]
 new_sync_write fs/read_write.c:497 [inline]
 vfs_write+0xb63/0x1520 fs/read_write.c:590
 ksys_write+0x20f/0x4c0 fs/read_write.c:643
 __do_sys_write fs/read_write.c:655 [inline]
 __se_sys_write fs/read_write.c:652 [inline]
 __x64_sys_write+0x93/0xe0 fs/read_write.c:652
 do_syscall_64+0xd5/0x1f0
 entry_SYSCALL_64_after_hwframe+0x6d/0x75

Uninit was created at:
 slab_post_alloc_hook mm/slub.c:3804 [inline]
 slab_alloc_node mm/slub.c:3845 [inline]
 kmem_cache_alloc_node+0x613/0xc50 mm/slub.c:3888
 kmalloc_reserve+0x13d/0x4a0 net/core/skbuff.c:577
 __alloc_skb+0x35b/0x7a0 net/core/skbuff.c:668
 alloc_skb include/linux/skbuff.h:1318 [inline]
 alloc_skb_with_frags+0xc8/0xbf0 net/core/skbuff.c:6504
 sock_alloc_send_pskb+0xa81/0xbf0 net/core/sock.c:2795
 tun_alloc_skb drivers/net/tun.c:1525 [inline]
 tun_get_user+0x209a/0x69e0 drivers/net/tun.c:1846
 tun_chr_write_iter+0x3af/0x5d0 drivers/net/tun.c:2048
 call_write_iter include/linux/fs.h:2108 [inline]
 new_sync_write fs/read_write.c:497 [inline]
 vfs_write+0xb63/0x1520 fs/read_write.c:590
 ksys_write+0x20f/0x4c0 fs/read_write.c:643
 __do_sys_write fs/read_write.c:655 [inline]
 __se_sys_write fs/read_write.c:652 [inline]
 __x64_sys_write+0x93/0xe0 fs/read_write.c:652
 do_syscall_64+0xd5/0x1f0
 entry_SYSCALL_64_after_hwframe+0x6d/0x75

CPU: 1 PID: 5045 Comm: syz-executor114 Not tainted 6.9.0-rc1-syzkaller-00021-g962490525cff #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/29/2024
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


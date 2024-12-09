Return-Path: <netdev+bounces-150120-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5666A9E8FF3
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 11:16:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C595C1883F91
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 10:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1066621764F;
	Mon,  9 Dec 2024 10:16:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DFE72163AA
	for <netdev@vger.kernel.org>; Mon,  9 Dec 2024 10:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733739392; cv=none; b=QSL1NhA6gOO9P4EXX+N3Pxg5Mlvc9IUpWO3vjeyiGtoqT3KGmenhwoe5z/Z/WbC6Ud4ctt2QRVSJW3Wfznd+gStICOfv9aP9/wimxGcw+iA5b18Edi33Ng4ZBHVKS5ENF8SzQeYq84rA1F5wfxpwKm9ECF/QY7fsA21XgUPSolA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733739392; c=relaxed/simple;
	bh=PJcxP3+fxC6q9ATs7dsp1NERti+X1yqlbb47jI+UCPU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=acP6y7kaINe9SMMhJkEut+itl4xPG3cXJJX8ec8tsbjHLwyTzAjKXCcEu0D2BeRFYcAXllBbds97fag6qayzqR3LZgrZIWtisxFwgLsMlzqVLdK3VXUw1E1UMv4NV+W0SmcKMaLqcF8cMR+idDh48nak0+5cWHrY1iPWZrHelc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3a81828bc7cso11159965ab.3
        for <netdev@vger.kernel.org>; Mon, 09 Dec 2024 02:16:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733739387; x=1734344187;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pE5pq9rSl324xV/nji1bRov7FKMwLf1hz3L9hN/9KsY=;
        b=tbxNL8Q43XgrIC1G9WBHtZxFeEWuF0xYxgSPWFyB0UEibR+a/PWwH8quRgBe7PQx5D
         4bfrwl+HQdPsP/27X727wKCv/wPaWrP0hLhIdK8vxRwqDoWbDmTbz1ghvJ58cCYunzVK
         uKfUxV6m1ERzhkJ/mp1jPcdOJCZSMxs6QWIIiQ/F1was/3seIl2Or4tppAAiEql8yge1
         8lA/K51DGUW3td7fAl2GClUb197ZN2Rfq3SMIHjdyWZRn+aJMc7iTUXm0IyFQ+3N10hL
         QmAdEx4gGT+RRDf+2HYIY5TdqmCcqMGp65yUcfR+cEBF99cVpZ9AEvIIj6YvuTfx6DKb
         urZw==
X-Forwarded-Encrypted: i=1; AJvYcCXaKQzkoEq9aZ6yeg/pQKvN8p4l1JKfHBlbeUIKPMS37IyS2fWpxeKjiSZbSSKhD+XY1MzszUU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMTqin8i1UeMSfNz1+b20pBg0B/RcJIhzTTiGKnsBlm4zFi5bJ
	RO3sfNg/bXAnipv/yBQW87gjzUCd+4yhCl57NonBkM5ZPq2Vq4YYAk0WMgr7xZ2QGMaAgFZLTFD
	OfaVVqhfDpvcHLSFuI4qORoa9rIjI9fQU/r7BWyGdSq+GyjakrlpYcEk=
X-Google-Smtp-Source: AGHT+IHMx3fG2k1EoSAwUvPFUHFZOVBBvbomU5kzsI/82NqvgjSpKM+Wnxfrm7MijwznvxEQZUHNeCSCQKxbpXtNv+ymliah4G0m
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c26:b0:3a7:e7a9:8a78 with SMTP id
 e9e14a558f8ab-3a811e61538mr97673085ab.17.1733739387434; Mon, 09 Dec 2024
 02:16:27 -0800 (PST)
Date: Mon, 09 Dec 2024 02:16:27 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6756c37b.050a0220.a30f1.019a.GAE@google.com>
Subject: [syzbot] [net?] BUG: Bad page state in skb_pp_cow_data
From: syzbot <syzbot+ff145014d6b0ce64a173@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, hawk@kernel.org, 
	horms@kernel.org, ilias.apalodimas@linaro.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, lorenzo@kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com, toke@redhat.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    7503345ac5f5 Merge tag 'block-6.13-20241207' of git://git...
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1784c820580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=335e39020523e2ed
dashboard link: https://syzkaller.appspot.com/bug?extid=ff145014d6b0ce64a173
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=177a8b30580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17d80c0f980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/21582041bcc6/disk-7503345a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3752facf1019/vmlinux-7503345a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3b1c3c4d3bd9/bzImage-7503345a.xz

The issue was bisected to:

commit e6d5dbdd20aa6a86974af51deb9414cd2e7794cb
Author: Lorenzo Bianconi <lorenzo@kernel.org>
Date:   Mon Feb 12 09:50:56 2024 +0000

    xdp: add multi-buff support for xdp running in generic mode

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=129acb30580000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=119acb30580000
console output: https://syzkaller.appspot.com/x/log.txt?x=169acb30580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ff145014d6b0ce64a173@syzkaller.appspotmail.com
Fixes: e6d5dbdd20aa ("xdp: add multi-buff support for xdp running in generic mode")

BUG: Bad page state in process syz-executor285  pfn:2d302
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x2d302
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000000 dead000000000040 ffff888022ab2000 0000000000000000
raw: 0000000000000000 0000000000000001 00000000ffffffff 0000000000000000
page dumped because: page_pool leak
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x2820(GFP_ATOMIC|__GFP_NOWARN), pid 5820, tgid 5820 (syz-executor285), ts 62999485029, free_ts 54592867285
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1556
 prep_new_page mm/page_alloc.c:1564 [inline]
 get_page_from_freelist+0x3651/0x37a0 mm/page_alloc.c:3474
 __alloc_pages_noprof+0x292/0x710 mm/page_alloc.c:4751
 alloc_pages_bulk_noprof+0x70b/0xcc0 mm/page_alloc.c:4699
 alloc_pages_bulk_array_node_noprof include/linux/gfp.h:239 [inline]
 __page_pool_alloc_pages_slow+0x122/0x690 net/core/page_pool.c:538
 page_pool_alloc_netmem net/core/page_pool.c:590 [inline]
 page_pool_alloc_pages+0xd0/0x1c0 net/core/page_pool.c:597
 page_pool_alloc include/net/page_pool/helpers.h:129 [inline]
 page_pool_dev_alloc include/net/page_pool/helpers.h:167 [inline]
 skb_pp_cow_data+0xc43/0x1640 net/core/skbuff.c:983
 netif_skb_check_for_xdp net/core/dev.c:5041 [inline]
 netif_receive_generic_xdp net/core/dev.c:5080 [inline]
 do_xdp_generic+0x505/0xd30 net/core/dev.c:5148
 __netif_receive_skb_core+0x1ce9/0x4690 net/core/dev.c:5492
 __netif_receive_skb_one_core net/core/dev.c:5670 [inline]
 __netif_receive_skb+0x12f/0x650 net/core/dev.c:5785
 netif_receive_skb_internal net/core/dev.c:5871 [inline]
 netif_receive_skb+0x1e8/0x890 net/core/dev.c:5930
 tun_rx_batched+0x1b7/0x8f0 drivers/net/tun.c:1550
 tun_get_user+0x30d6/0x4890 drivers/net/tun.c:2007
 tun_chr_write_iter+0x10d/0x1f0 drivers/net/tun.c:2053
 new_sync_write fs/read_write.c:586 [inline]
 vfs_write+0xaeb/0xd30 fs/read_write.c:679
 ksys_write+0x18f/0x2b0 fs/read_write.c:731
page last free pid 5807 tgid 5807 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1127 [inline]
 free_unref_page+0xde3/0x1130 mm/page_alloc.c:2657
 __folio_put+0x2c7/0x440 mm/swap.c:112
 pipe_buf_release include/linux/pipe_fs_i.h:219 [inline]
 pipe_update_tail fs/pipe.c:224 [inline]
 pipe_read+0x6ed/0x13e0 fs/pipe.c:344
 new_sync_read fs/read_write.c:484 [inline]
 vfs_read+0x991/0xb70 fs/read_write.c:565
 ksys_read+0x18f/0x2b0 fs/read_write.c:708
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
Modules linked in:
CPU: 0 UID: 0 PID: 5820 Comm: syz-executor285 Not tainted 6.13.0-rc1-syzkaller-00337-g7503345ac5f5 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 bad_page+0x176/0x1d0 mm/page_alloc.c:501
 free_page_is_bad mm/page_alloc.c:923 [inline]
 free_pages_prepare mm/page_alloc.c:1119 [inline]
 free_unref_page+0x1048/0x1130 mm/page_alloc.c:2657
 bpf_xdp_shrink_data net/core/filter.c:4148 [inline]
 bpf_xdp_frags_shrink_tail+0x3ee/0x7e0 net/core/filter.c:4169
 ____bpf_xdp_adjust_tail net/core/filter.c:4194 [inline]
 bpf_xdp_adjust_tail+0x1c3/0x200 net/core/filter.c:4187
 bpf_prog_f476d5219b92964a+0x1e/0x20
 __bpf_prog_run include/linux/filter.h:701 [inline]
 bpf_prog_run_xdp include/net/xdp.h:514 [inline]
 bpf_prog_run_generic_xdp+0x686/0x1510 net/core/dev.c:4973
 netif_receive_generic_xdp net/core/dev.c:5086 [inline]
 do_xdp_generic+0x757/0xd30 net/core/dev.c:5148
 __netif_receive_skb_core+0x1ce9/0x4690 net/core/dev.c:5492
 __netif_receive_skb_one_core net/core/dev.c:5670 [inline]
 __netif_receive_skb+0x12f/0x650 net/core/dev.c:5785
 netif_receive_skb_internal net/core/dev.c:5871 [inline]
 netif_receive_skb+0x1e8/0x890 net/core/dev.c:5930
 tun_rx_batched+0x1b7/0x8f0 drivers/net/tun.c:1550
 tun_get_user+0x30d6/0x4890 drivers/net/tun.c:2007
 tun_chr_write_iter+0x10d/0x1f0 drivers/net/tun.c:2053
 new_sync_write fs/read_write.c:586 [inline]
 vfs_write+0xaeb/0xd30 fs/read_write.c:679
 ksys_write+0x18f/0x2b0 fs/read_write.c:731
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f941abf7db0
Code: 40 00 48 c7 c2 b8 ff ff ff f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 80 3d f1 e2 07 00 00 74 17 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 58 c3 0f 1f 80 00 00 00 00 48 83 ec 28 48 89
RSP: 002b:00007ffc09852f28 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f941abf7db0
RDX: 0000000000011dc0 RSI: 00000000200004c0 RDI: 00000000000000c8
RBP: 0000000000000000 R08: 00007ffc09853058 R09: 00007ffc09853058
R10: 00007ffc09853058 R11: 0000000000000202 R12: 00007f941ac460de
R13: 0000000000000000 R14: 00007ffc09852f60 R15: 00007ffc09852f50
 </TASK>
BUG: Bad page state in process syz-executor285  pfn:2d301
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x8 pfn:0x2d301
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000000 dead000000000040 ffff888022ab2000 0000000000000000
raw: 0000000000000008 0000000000000001 00000000ffffffff 0000000000000000
page dumped because: page_pool leak
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x2820(GFP_ATOMIC|__GFP_NOWARN), pid 5820, tgid 5820 (syz-executor285), ts 62999478821, free_ts 55944947211
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1556
 prep_new_page mm/page_alloc.c:1564 [inline]
 get_page_from_freelist+0x3651/0x37a0 mm/page_alloc.c:3474
 __alloc_pages_noprof+0x292/0x710 mm/page_alloc.c:4751
 alloc_pages_bulk_noprof+0x70b/0xcc0 mm/page_alloc.c:4699
 alloc_pages_bulk_array_node_noprof include/linux/gfp.h:239 [inline]
 __page_pool_alloc_pages_slow+0x122/0x690 net/core/page_pool.c:538
 page_pool_alloc_netmem net/core/page_pool.c:590 [inline]
 page_pool_alloc_pages+0xd0/0x1c0 net/core/page_pool.c:597
 page_pool_alloc include/net/page_pool/helpers.h:129 [inline]
 page_pool_dev_alloc include/net/page_pool/helpers.h:167 [inline]
 skb_pp_cow_data+0xc43/0x1640 net/core/skbuff.c:983
 netif_skb_check_for_xdp net/core/dev.c:5041 [inline]
 netif_receive_generic_xdp net/core/dev.c:5080 [inline]
 do_xdp_generic+0x505/0xd30 net/core/dev.c:5148
 __netif_receive_skb_core+0x1ce9/0x4690 net/core/dev.c:5492
 __netif_receive_skb_one_core net/core/dev.c:5670 [inline]
 __netif_receive_skb+0x12f/0x650 net/core/dev.c:5785
 netif_receive_skb_internal net/core/dev.c:5871 [inline]
 netif_receive_skb+0x1e8/0x890 net/core/dev.c:5930
 tun_rx_batched+0x1b7/0x8f0 drivers/net/tun.c:1550
 tun_get_user+0x30d6/0x4890 drivers/net/tun.c:2007
 tun_chr_write_iter+0x10d/0x1f0 drivers/net/tun.c:2053
 new_sync_write fs/read_write.c:586 [inline]
 vfs_write+0xaeb/0xd30 fs/read_write.c:679
 ksys_write+0x18f/0x2b0 fs/read_write.c:731
page last free pid 5810 tgid 5810 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1127 [inline]
 free_unref_page+0xde3/0x1130 mm/page_alloc.c:2657
 __folio_put+0x2c7/0x440 mm/swap.c:112
 pipe_buf_release include/linux/pipe_fs_i.h:219 [inline]
 pipe_update_tail fs/pipe.c:224 [inline]
 pipe_read+0x6ed/0x13e0 fs/pipe.c:344
 new_sync_read fs/read_write.c:484 [inline]
 vfs_read+0x991/0xb70 fs/read_write.c:565
 ksys_read+0x18f/0x2b0 fs/read_write.c:708
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
Modules linked in:
CPU: 0 UID: 0 PID: 5820 Comm: syz-executor285 Tainted: G    B              6.13.0-rc1-syzkaller-00337-g7503345ac5f5 #0
Tainted: [B]=BAD_PAGE
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 bad_page+0x176/0x1d0 mm/page_alloc.c:501
 free_page_is_bad mm/page_alloc.c:923 [inline]
 free_pages_prepare mm/page_alloc.c:1119 [inline]
 free_unref_page+0x1048/0x1130 mm/page_alloc.c:2657
 bpf_xdp_shrink_data net/core/filter.c:4148 [inline]
 bpf_xdp_frags_shrink_tail+0x3ee/0x7e0 net/core/filter.c:4169
 ____bpf_xdp_adjust_tail net/core/filter.c:4194 [inline]
 bpf_xdp_adjust_tail+0x1c3/0x200 net/core/filter.c:4187
 bpf_prog_f476d5219b92964a+0x1e/0x20
 __bpf_prog_run include/linux/filter.h:701 [inline]
 bpf_prog_run_xdp include/net/xdp.h:514 [inline]
 bpf_prog_run_generic_xdp+0x686/0x1510 net/core/dev.c:4973
 netif_receive_generic_xdp net/core/dev.c:5086 [inline]
 do_xdp_generic+0x757/0xd30 net/core/dev.c:5148
 __netif_receive_skb_core+0x1ce9/0x4690 net/core/dev.c:5492
 __netif_receive_skb_one_core net/core/dev.c:5670 [inline]
 __netif_receive_skb+0x12f/0x650 net/core/dev.c:5785
 netif_receive_skb_internal net/core/dev.c:5871 [inline]
 netif_receive_skb+0x1e8/0x890 net/core/dev.c:5930
 tun_rx_batched+0x1b7/0x8f0 drivers/net/tun.c:1550
 tun_get_user+0x30d6/0x4890 drivers/net/tun.c:2007
 tun_chr_write_iter+0x10d/0x1f0 drivers/net/tun.c:2053
 new_sync_write fs/read_write.c:586 [inline]
 vfs_write+0xaeb/0xd30 fs/read_write.c:679
 ksys_write+0x18f/0x2b0 fs/read_write.c:731
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f941abf7db0
Code: 40 00 48 c7 c2 b8 ff ff ff f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 80 3d f1 e2 07 00 00 74 17 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 58 c3 0f 1f 80 00 00 00 00 48 83 ec 28 48 89
RSP: 002b:00007ffc09852f28 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f941abf7db0
RDX: 0000000000011dc0 RSI: 00000000200004c0 RDI: 00000000000000c8
RBP: 0000000000000000 R08: 00007ffc09853058 R09: 00007ffc09853058
R10: 00007ffc09853058 R11: 0000000000000202 R12: 00007f941ac460de
R13: 0000000000000000 R14: 00007ffc09852f60 R15: 00007ffc09852f50
 </TASK>
BUG: Bad page state in process syz-executor285  pfn:2d300
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0xffff88802d304000 pfn:0x2d300
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000000 dead000000000040 ffff888022ab2000 0000000000000000
raw: ffff88802d304000 0000000000000001 00000000ffffffff 0000000000000000
page dumped because: page_pool leak
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x2820(GFP_ATOMIC|__GFP_NOWARN), pid 5820, tgid 5820 (syz-executor285), ts 62999472559, free_ts 55944400344
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1556
 prep_new_page mm/page_alloc.c:1564 [inline]
 get_page_from_freelist+0x3651/0x37a0 mm/page_alloc.c:3474
 __alloc_pages_noprof+0x292/0x710 mm/page_alloc.c:4751
 alloc_pages_bulk_noprof+0x70b/0xcc0 mm/page_alloc.c:4699
 alloc_pages_bulk_array_node_noprof include/linux/gfp.h:239 [inline]
 __page_pool_alloc_pages_slow+0x122/0x690 net/core/page_pool.c:538
 page_pool_alloc_netmem net/core/page_pool.c:590 [inline]
 page_pool_alloc_pages+0xd0/0x1c0 net/core/page_pool.c:597
 page_pool_alloc include/net/page_pool/helpers.h:129 [inline]
 page_pool_dev_alloc include/net/page_pool/helpers.h:167 [inline]
 skb_pp_cow_data+0xc43/0x1640 net/core/skbuff.c:983
 netif_skb_check_for_xdp net/core/dev.c:5041 [inline]
 netif_receive_generic_xdp net/core/dev.c:5080 [inline]
 do_xdp_generic+0x505/0xd30 net/core/dev.c:5148
 __netif_receive_skb_core+0x1ce9/0x4690 net/core/dev.c:5492
 __netif_receive_skb_one_core net/core/dev.c:5670 [inline]
 __netif_receive_skb+0x12f/0x650 net/core/dev.c:5785
 netif_receive_skb_internal net/core/dev.c:5871 [inline]
 netif_receive_skb+0x1e8/0x890 net/core/dev.c:5930
 tun_rx_batched+0x1b7/0x8f0 drivers/net/tun.c:1550
 tun_get_user+0x30d6/0x4890 drivers/net/tun.c:2007
 tun_chr_write_iter+0x10d/0x1f0 drivers/net/tun.c:2053
 new_sync_write fs/read_write.c:586 [inline]
 vfs_write+0xaeb/0xd30 fs/read_write.c:679
 ksys_write+0x18f/0x2b0 fs/read_write.c:731
page last free pid 5810 tgid 5810 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1127 [inline]
 free_unref_page+0xde3/0x1130 mm/page_alloc.c:2657
 __folio_put+0x2c7/0x440 mm/swap.c:112
 pipe_buf_release include/linux/pipe_fs_i.h:219 [inline]
 pipe_update_tail fs/pipe.c:224 [inline]
 pipe_read+0x6ed/0x13e0 fs/pipe.c:344
 new_sync_read fs/read_write.c:484 [inline]
 vfs_read+0x991/0xb70 fs/read_write.c:565
 ksys_read+0x18f/0x2b0 fs/read_write.c:708
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
Modules linked in:
CPU: 0 UID: 0 PID: 5820 Comm: syz-executor285 Tainted: G    B              6.13.0-rc1-syzkaller-00337-g7503345ac5f5 #0
Tainted: [B]=BAD_PAGE
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 bad_page+0x176/0x1d0 mm/page_alloc.c:501
 free_page_is_bad mm/page_alloc.c:923 [inline]
 free_pages_prepare mm/page_alloc.c:1119 [inline]
 free_unref_page+0x1048/0x1130 mm/page_alloc.c:2657
 bpf_xdp_shrink_data net/core/filter.c:4148 [inline]
 bpf_xdp_frags_shrink_tail+0x3ee/0x7e0 net/core/filter.c:4169
 ____bpf_xdp_adjust_tail net/core/filter.c:4194 [inline]
 bpf_xdp_adjust_tail+0x1c3/0x200 net/core/filter.c:4187
 bpf_prog_f476d5219b92964a+0x1e/0x20
 __bpf_prog_run include/linux/filter.h:701 [inline]
 bpf_prog_run_xdp include/net/xdp.h:514 [inline]
 bpf_prog_run_generic_xdp+0x686/0x1510 net/core/dev.c:4973
 netif_receive_generic_xdp net/core/dev.c:5086 [inline]
 do_xdp_generic+0x757/0xd30 net/core/dev.c:5148
 __netif_receive_skb_core+0x1ce9/0x4690 net/core/dev.c:5492
 __netif_receive_skb_one_core net/core/dev.c:5670 [inline]
 __netif_receive_skb+0x12f/0x650 net/core/dev.c:5785
 netif_receive_skb_internal net/core/dev.c:5871 [inline]
 netif_receive_skb+0x1e8/0x890 net/core/dev.c:5930
 tun_rx_batched+0x1b7/0x8f0 drivers/net/tun.c:1550
 tun_get_user+0x30d6/0x4890 drivers/net/tun.c:2007
 tun_chr_write_iter+0x10d/0x1f0 drivers/net/tun.c:2053
 new_sync_write fs/read_write.c:586 [inline]
 vfs_write+0xaeb/0xd30 fs/read_write.c:679
 ksys_write+0x18f/0x2b0 fs/read_write.c:731
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f941abf7db0
Code: 40 00 48 c7 c2 b8 ff ff ff f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 80 3d f1 e2 07 00 00 74 17 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 58 c3 0f 1f 80 00 00 00 00 48 83 ec 28 48 89
RSP: 002b:00007ffc09852f28 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f941abf7db0
RDX: 0000000000011dc0 RSI: 00000000200004c0 RDI: 00000000000000c8
RBP: 0000000000000000 R08: 00007ffc09853058 R09: 00007ffc09853058
R10: 00007ffc09853058 R11: 0000000000000202 R12: 00007f941ac460de
R13: 0000000000000000 R14: 00007ffc09852f60 R15: 00007ffc09852f50
 </TASK>
BUG: Bad page state in process syz-executor285  pfn:72d3b
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x72d3b
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000000 dead000000000040 ffff888022ab2000 0000000000000000
raw: 0000000000000000 0000000000000001 00000000ffffffff 0000000000000000
page dumped because: page_pool leak
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x2820(GFP_ATOMIC|__GFP_NOWARN), pid 5820, tgid 5820 (syz-executor285), ts 62999466297, free_ts 54575113729
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1556
 prep_new_page mm/page_alloc.c:1564 [inline]
 get_page_from_freelist+0x3651/0x37a0 mm/page_alloc.c:3474
 __alloc_pages_noprof+0x292/0x710 mm/page_alloc.c:4751
 alloc_pages_bulk_noprof+0x70b/0xcc0 mm/page_alloc.c:4699
 alloc_pages_bulk_array_node_noprof include/linux/gfp.h:239 [inline]
 __page_pool_alloc_pages_slow+0x122/0x690 net/core/page_pool.c:538
 page_pool_alloc_netmem net/core/page_pool.c:590 [inline]
 page_pool_alloc_pages+0xd0/0x1c0 net/core/page_pool.c:597
 page_pool_alloc include/net/page_pool/helpers.h:129 [inline]
 page_pool_dev_alloc include/net/page_pool/helpers.h:167 [inline]
 skb_pp_cow_data+0xc43/0x1640 net/core/skbuff.c:983
 netif_skb_check_for_xdp net/core/dev.c:5041 [inline]
 netif_receive_generic_xdp net/core/dev.c:5080 [inline]
 do_xdp_generic+0x505/0xd30 net/core/dev.c:5148
 __netif_receive_skb_core+0x1ce9/0x4690 net/core/dev.c:5492
 __netif_receive_skb_one_core net/core/dev.c:5670 [inline]
 __netif_receive_skb+0x12f/0x650 net/core/dev.c:5785
 netif_receive_skb_internal net/core/dev.c:5871 [inline]
 netif_receive_skb+0x1e8/0x890 net/core/dev.c:5930
 tun_rx_batched+0x1b7/0x8f0 drivers/net/tun.c:1550
 tun_get_user+0x30d6/0x4890 drivers/net/tun.c:2007
 tun_chr_write_iter+0x10d/0x1f0 drivers/net/tun.c:2053
 new_sync_write fs/read_write.c:586 [inline]
 vfs_write+0xaeb/0xd30 fs/read_write.c:679
 ksys_write+0x18f/0x2b0 fs/read_write.c:731
page last free pid 5807 tgid 5807 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1127 [inline]
 free_unref_page+0xde3/0x1130 mm/page_alloc.c:2657
 __folio_put+0x2c7/0x440 mm/swap.c:112
 pipe_buf_release include/linux/pipe_fs_i.h:219 [inline]
 pipe_update_tail fs/pipe.c:224 [inline]
 pipe_read+0x6ed/0x13e0 fs/pipe.c:344
 new_sync_read fs/read_write.c:484 [inline]
 vfs_read+0x991/0xb70 fs/read_write.c:565
 ksys_read+0x18f/0x2b0 fs/read_write.c:708
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
Modules linked in:
CPU: 0 UID: 0 PID: 5820 Comm: syz-executor285 Tainted: G    B              6.13.0-rc1-syzkaller-00337-g7503345ac5f5 #0
Tainted: [B]=BAD_PAGE
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 bad_page+0x176/0x1d0 mm/page_alloc.c:501
 free_page_is_bad mm/page_alloc.c:923 [inline]
 free_pages_prepare mm/page_alloc.c:1119 [inline]
 free_unref_page+0x1048/0x1130 mm/page_alloc.c:2657
 bpf_xdp_shrink_data net/core/filter.c:4148 [inline]
 bpf_xdp_frags_shrink_tail+0x3ee/0x7e0 net/core/filter.c:4169
 ____bpf_xdp_adjust_tail net/core/filter.c:4194 [inline]
 bpf_xdp_adjust_tail+0x1c3/0x200 net/core/filter.c:4187
 bpf_prog_f476d5219b92964a+0x1e/0x20
 __bpf_prog_run include/linux/filter.h:701 [inline]
 bpf_prog_run_xdp include/net/xdp.h:514 [inline]
 bpf_prog_run_generic_xdp+0x686/0x1510 net/core/dev.c:4973
 netif_receive_generic_xdp net/core/dev.c:5086 [inline]
 do_xdp_generic+0x757/0xd30 net/core/dev.c:5148
 __netif_receive_skb_core+0x1ce9/0x4690 net/core/dev.c:5492
 __netif_receive_skb_one_core net/core/dev.c:5670 [inline]
 __netif_receive_skb+0x12f/0x650 net/core/dev.c:5785
 netif_receive_skb_internal net/core/dev.c:5871 [inline]
 netif_receive_skb+0x1e8/0x890 net/core/dev.c:5930
 tun_rx_batched+0x1b7/0x8f0 drivers/net/tun.c:1550
 tun_get_user+0x30d6/0x4890 drivers/net/tun.c:2007
 tun_chr_write_iter+0x10d/0x1f0 drivers/net/tun.c:2053
 new_sync_write fs/read_write.c:586 [inline]
 vfs_write+0xaeb/0xd30 fs/read_write.c:679
 ksys_write+0x18f/0x2b0 fs/read_write.c:731
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f941abf7db0
Code: 40 00 48 c7 c2 b8 ff ff ff f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 80 3d f1 e2 07 00 00 74 17 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 58 c3 0f 1f 80 00 00 00 00 48 83 ec 28 48 89
RSP: 002b:00007ffc09852f28 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f941abf7db0
RDX: 0000000000011dc0 RSI: 00000000200004c0 RDI: 00000000000000c8
RBP: 0000000000000000 R08: 00007ffc09853058 R09: 00007ffc09853058
R10: 00007ffc09853058 R11: 0000000000000202 R12: 00007f941ac460de
R13: 0000000000000000 R14: 00007ffc09852f60 R15: 00007ffc09852f50
 </TASK>
BUG: Bad page state in process syz-executor285  pfn:72d3a
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x72d3a
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000000 dead000000000040 ffff888022ab2000 0000000000000000
raw: 0000000000000000 0000000000000001 00000000ffffffff 0000000000000000
page dumped because: page_pool leak
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x2820(GFP_ATOMIC|__GFP_NOWARN), pid 5820, tgid 5820 (syz-executor285), ts 62999460106, free_ts 54575122306
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1556
 prep_new_page mm/page_alloc.c:1564 [inline]
 get_page_from_freelist+0x3651/0x37a0 mm/page_alloc.c:3474
 __alloc_pages_noprof+0x292/0x710 mm/page_alloc.c:4751
 alloc_pages_bulk_noprof+0x70b/0xcc0 mm/page_alloc.c:4699
 alloc_pages_bulk_array_node_noprof include/linux/gfp.h:239 [inline]
 __page_pool_alloc_pages_slow+0x122/0x690 net/core/page_pool.c:538
 page_pool_alloc_netmem net/core/page_pool.c:590 [inline]
 page_pool_alloc_pages+0xd0/0x1c0 net/core/page_pool.c:597
 page_pool_alloc include/net/page_pool/helpers.h:129 [inline]
 page_pool_dev_alloc include/net/page_pool/helpers.h:167 [inline]
 skb_pp_cow_data+0xc43/0x1640 net/core/skbuff.c:983
 netif_skb_check_for_xdp net/core/dev.c:5041 [inline]
 netif_receive_generic_xdp net/core/dev.c:5080 [inline]
 do_xdp_generic+0x505/0xd30 net/core/dev.c:5148
 __netif_receive_skb_core+0x1ce9/0x4690 net/core/dev.c:5492
 __netif_receive_skb_one_core net/core/dev.c:5670 [inline]
 __netif_receive_skb+0x12f/0x650 net/core/dev.c:5785
 netif_receive_skb_internal net/core/dev.c:5871 [inline]
 netif_receive_skb+0x1e8/0x890 net/core/dev.c:5930
 tun_rx_batched+0x1b7/0x8f0 drivers/net/tun.c:1550
 tun_get_user+0x30d6/0x4890 drivers/net/tun.c:2007
 tun_chr_write_iter+0x10d/0x1f0 drivers/net/tun.c:2053
 new_sync_write fs/read_write.c:586 [inline]
 vfs_write+0xaeb/0xd30 fs/read_write.c:679
 ksys_write+0x18f/0x2b0 fs/read_write.c:731
page last free pid 5807 tgid 5807 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1127 [inline]
 free_unref_page+0xde3/0x1130 mm/page_alloc.c:2657
 __folio_put+0x2c7/0x440 mm/swap.c:112
 pipe_buf_release include/linux/pipe_fs_i.h:219 [inline]
 pipe_update_tail fs/pipe.c:224 [inline]
 pipe_read+0x6ed/0x13e0 fs/pipe.c:344
 new_sync_read fs/read_write.c:484 [inline]
 vfs_read+0x991/0xb70 fs/read_write.c:565
 ksys_read+0x18f/0x2b0 fs/read_write.c:708
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
Modules linked in:
CPU: 0 UID: 0 PID: 5820 Comm: syz-executor285 Tainted: G    B              6.13.0-rc1-syzkaller-00337-g7503345ac5f5 #0
Tainted: [B]=BAD_PAGE
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 bad_page+0x176/0x1d0 mm/page_alloc.c:501
 free_page_is_bad mm/page_alloc.c:923 [inline]
 free_pages_prepare mm/page_alloc.c:1119 [inline]
 free_unref_page+0x1048/0x1130 mm/page_alloc.c:2657
 bpf_xdp_shrink_data net/core/filter.c:4148 [inline]
 bpf_xdp_frags_shrink_tail+0x3ee/0x7e0 net/core/filter.c:4169
 ____bpf_xdp_adjust_tail net/core/filter.c:4194 [inline]
 bpf_xdp_adjust_tail+0x1c3/0x200 net/core/filter.c:4187
 bpf_prog_f476d5219b92964a+0x1e/0x20
 __bpf_prog_run include/linux/filter.h:701 [inline]
 bpf_prog_run_xdp include/net/xdp.h:514 [inline]
 bpf_prog_run_generic_xdp+0x686/0x1510 net/core/dev.c:4973
 netif_receive_generic_xdp net/core/dev.c:5086 [inline]
 do_xdp_generic+0x757/0xd30 net/core/dev.c:5148
 __netif_receive_skb_core+0x1ce9/0x4690 net/core/dev.c:5492
 __netif_receive_skb_one_core net/core/dev.c:5670 [inline]
 __netif_receive_skb+0x12f/0x650 net/core/dev.c:5785
 netif_receive_skb_internal net/core/dev.c:5871 [inline]
 netif_receive_skb+0x1e8/0x890 net/core/dev.c:5930
 tun_rx_batched+0x1b7/0x8f0 drivers/net/tun.c:1550
 tun_get_user+0x30d6/0x4890 drivers/net/tun.c:2007
 tun_chr_write_iter+0x10d/0x1f0 drivers/net/tun.c:2053
 new_sync_write fs/read_write.c:586 [inline]
 vfs_write+0xaeb/0xd30 fs/read_write.c:679
 ksys_write+0x18f/0x2b0 fs/read_write.c:731
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f941abf7db0
Code: 40 00 48 c7 c2 b8 ff ff ff f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 80 3d f1 e2 07 00 00 74 17 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 58 c3 0f 1f 80 00 00 00 00 48 83 ec 28 48 89
RSP: 002b:00007ffc09852f28 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f941abf7db0
RDX: 0000000000011dc0 RSI: 00000000200004c0 RDI: 00000000000000c8
RBP: 0000000000000000 R08: 00007ffc09853058 R09: 00007ffc09853058
R10: 00007ffc09853058 R11: 0000000000000202 R12: 00007f941ac460de
R13: 0000000000000000 R14: 00007ffc09852f60 R15: 00007ffc09852f50
 </TASK>
BUG: Bad page state in process syz-executor285  pfn:72d39
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x72d39
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000000 dead000000000040 ffff888022ab2000 0000000000000000
raw: 0000000000000000 0000000000000001 00000000ffffffff 0000000000000000
page dumped because: page_pool leak
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x2820(GFP_ATOMIC|__GFP_NOWARN), pid 5820, tgid 5820 (syz-executor285), ts 62999453972, free_ts 54575963863
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1556
 prep_new_page mm/page_alloc.c:1564 [inline]
 get_page_from_freelist+0x3651/0x37a0 mm/page_alloc.c:3474
 __alloc_pages_noprof+0x292/0x710 mm/page_alloc.c:4751
 alloc_pages_bulk_noprof+0x70b/0xcc0 mm/page_alloc.c:4699
 alloc_pages_bulk_array_node_noprof include/linux/gfp.h:239 [inline]
 __page_pool_alloc_pages_slow+0x122/0x690 net/core/page_pool.c:538
 page_pool_alloc_netmem net/core/page_pool.c:590 [inline]
 page_pool_alloc_pages+0xd0/0x1c0 net/core/page_pool.c:597
 page_pool_alloc include/net/page_pool/helpers.h:129 [inline]
 page_pool_dev_alloc include/net/page_pool/helpers.h:167 [inline]
 skb_pp_cow_data+0xc43/0x1640 net/core/skbuff.c:983
 netif_skb_check_for_xdp net/core/dev.c:5041 [inline]
 netif_receive_generic_xdp net/core/dev.c:5080 [inline]
 do_xdp_generic+0x505/0xd30 net/core/dev.c:5148
 __netif_receive_skb_core+0x1ce9/0x4690 net/core/dev.c:5492
 __netif_receive_skb_one_core net/core/dev.c:5670 [inline]
 __netif_receive_skb+0x12f/0x650 net/core/dev.c:5785
 netif_receive_skb_internal net/core/dev.c:5871 [inline]
 netif_receive_skb+0x1e8/0x890 net/core/dev.c:5930
 tun_rx_batched+0x1b7/0x8f0 drivers/net/tun.c:1550
 tun_get_user+0x30d6/0x4890 drivers/net/tun.c:2007
 tun_chr_write_iter+0x10d/0x1f0 drivers/net/tun.c:2053
 new_sync_write fs/read_write.c:586 [inline]
 vfs_write+0xaeb/0xd30 fs/read_write.c:679
 ksys_write+0x18f/0x2b0 fs/read_write.c:731
page last free pid 5807 tgid 5807 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1127 [inline]
 free_unref_page+0xde3/0x1130 mm/page_alloc.c:2657
 __folio_put+0x2c7/0x440 mm/swap.c:112
 pipe_buf_release include/linux/pipe_fs_i.h:219 [inline]
 pipe_update_tail fs/pipe.c:224 [inline]
 pipe_read+0x6ed/0x13e0 fs/pipe.c:344
 new_sync_read fs/read_write.c:484 [inline]
 vfs_read+0x991/0xb70 fs/read_write.c:565
 ksys_read+0x18f/0x2b0 fs/read_write.c:708
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
Modules linked in:
CPU: 0 UID: 0 PID: 5820 Comm: syz-executor285 Tainted: G    B              6.13.0-rc1-syzkaller-00337-g7503345ac5f5 #0
Tainted: [B]=BAD_PAGE
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 bad_page+0x176/0x1d0 mm/page_alloc.c:501
 free_page_is_bad mm/page_alloc.c:923 [inline]
 free_pages_prepare mm/page_alloc.c:1119 [inline]
 free_unref_page+0x1048/0x1130 mm/page_alloc.c:2657
 bpf_xdp_shrink_data net/core/filter.c:4148 [inline]
 bpf_xdp_frags_shrink_tail+0x3ee/0x7e0 net/core/filter.c:4169
 ____bpf_xdp_adjust_tail net/core/filter.c:4194 [inline]
 bpf_xdp_adjust_tail+0x1c3/0x200 net/core/filter.c:4187
 bpf_prog_f476d5219b92964a+0x1e/0x20
 __bpf_prog_run include/linux/filter.h:701 [inline]
 bpf_prog_run_xdp include/net/xdp.h:514 [inline]
 bpf_prog_run_generic_xdp+0x686/0x1510 net/core/dev.c:4973
 netif_receive_generic_xdp net/core/dev.c:5086 [inline]
 do_xdp_generic+0x757/0xd30 net/core/dev.c:5148
 __netif_receive_skb_core+0x1ce9/0x4690 net/core/dev.c:5492
 __netif_receive_skb_one_core net/core/dev.c:5670 [inline]
 __netif_receive_skb+0x12f/0x650 net/core/dev.c:5785
 netif_receive_skb_internal net/core/dev.c:5871 [inline]
 netif_receive_skb+0x1e8/0x890 net/core/dev.c:5930
 tun_rx_batched+0x1b7/0x8f0 drivers/net/tun.c:1550
 tun_get_user+0x30d6/0x4890 drivers/net/tun.c:2007
 tun_chr_write_iter+0x10d/0x1f0 drivers/net/tun.c:2053
 new_sync_write fs/read_write.c:586 [inline]
 vfs_write+0xaeb/0xd30 fs/read_write.c:679
 ksys_write+0x18f/0x2b0 fs/read_write.c:731
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f941abf7db0
Code: 40 00 48 c7 c2 b8 ff ff ff f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 80 3d f1 e2 07 00 00 74 17 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 58 c3 0f 1f 80 00 00 00 00 48 83 ec 28 48 89
RSP: 002b:00007ffc09852f28 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f941abf7db0
RDX: 0000000000011dc0 RSI: 00000000200004c0 RDI: 00000000000000c8
RBP: 0000000000000000 R08: 00007ffc09853058 R09: 00007ffc09853058
R10: 00007ffc09853058 R11: 0000000000000202 R12: 00007f941ac460de
R13: 0000000000000000 R14: 00007ffc09852f60 R15: 00007ffc09852f50
 </TASK>
BUG: Bad page state in process syz-executor285  pfn:72d38
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x72d38
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000000 dead000000000040 ffff888022ab2000 0000000000000000
raw: 0000000000000000 0000000000000001 00000000ffffffff 0000000000000000
page dumped because: page_pool leak
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x2820(GFP_ATOMIC|__GFP_NOWARN), pid 5820, tgid 5820 (syz-executor285), ts 62999447572, free_ts 54575218247
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1556
 prep_new_page mm/page_alloc.c:1564 [inline]
 get_page_from_freelist+0x3651/0x37a0 mm/page_alloc.c:3474
 __alloc_pages_noprof+0x292/0x710 mm/page_alloc.c:4751
 alloc_pages_bulk_noprof+0x70b/0xcc0 mm/page_alloc.c:4699
 alloc_pages_bulk_array_node_noprof include/linux/gfp.h:239 [inline]
 __page_pool_alloc_pages_slow+0x122/0x690 net/core/page_pool.c:538
 page_pool_alloc_netmem net/core/page_pool.c:590 [inline]
 page_pool_alloc_pages+0xd0/0x1c0 net/core/page_pool.c:597
 page_pool_alloc include/net/page_pool/helpers.h:129 [inline]
 page_pool_dev_alloc include/net/page_pool/helpers.h:167 [inline]
 skb_pp_cow_data+0xc43/0x1640 net/core/skbuff.c:983
 netif_skb_check_for_xdp net/core/dev.c:5041 [inline]
 netif_receive_generic_xdp net/core/dev.c:5080 [inline]
 do_xdp_generic+0x505/0xd30 net/core/dev.c:5148
 __netif_receive_skb_core+0x1ce9/0x4690 net/core/dev.c:5492
 __netif_receive_skb_one_core net/core/dev.c:5670 [inline]
 __netif_receive_skb+0x12f/0x650 net/core/dev.c:5785
 netif_receive_skb_internal net/core/dev.c:5871 [inline]
 netif_receive_skb+0x1e8/0x890 net/core/dev.c:5930
 tun_rx_batched+0x1b7/0x8f0 drivers/net/tun.c:1550
 tun_get_user+0x30d6/0x4890 drivers/net/tun.c:2007
 tun_chr_write_iter+0x10d/0x1f0 drivers/net/tun.c:2053
 new_sync_write fs/read_write.c:586 [inline]
 vfs_write+0xaeb/0xd30 fs/read_write.c:679
 ksys_write+0x18f/0x2b0 fs/read_write.c:731
page last free pid 5807 tgid 5807 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1127 [inline]
 free_unref_page+0xde3/0x1130 mm/page_alloc.c:2657
 __folio_put+0x2c7/0x440 mm/swap.c:112
 pipe_buf_release include/linux/pipe_fs_i.h:219 [inline]
 pipe_update_tail fs/pipe.c:224 [inline]
 pipe_read+0x6ed/0x13e0 fs/pipe.c:344
 new_sync_read fs/read_write.c:484 [inline]
 vfs_read+0x991/0xb70 fs/read_write.c:565
 ksys_read+0x18f/0x2b0 fs/read_write.c:708
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
Modules linked in:
CPU: 0 UID: 0 PID: 5820 Comm: syz-executor285 Tainted: G    B              6.13.0-rc1-syzkaller-00337-g7503345ac5f5 #0
Tainted: [B]=BAD_PAGE
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 bad_page+0x176/0x1d0 mm/page_alloc.c:501
 free_page_is_bad mm/page_alloc.c:923 [inline]
 free_pages_prepare mm/page_alloc.c:1119 [inline]
 free_unref_page+0x1048/0x1130 mm/page_alloc.c:2657
 bpf_xdp_shrink_data net/core/filter.c:4148 [inline]
 bpf_xdp_frags_shrink_tail+0x3ee/0x7e0 net/core/filter.c:4169
 ____bpf_xdp_adjust_tail net/core/filter.c:4194 [inline]
 bpf_xdp_adjust_tail+0x1c3/0x200 net/core/filter.c:4187
 bpf_prog_f476d5219b92964a+0x1e/0x20
 __bpf_prog_run include/linux/filter.h:701 [inline]
 bpf_prog_run_xdp include/net/xdp.h:514 [inline]
 bpf_prog_run_generic_xdp+0x686/0x1510 net/core/dev.c:4973
 netif_receive_generic_xdp net/core/dev.c:5086 [inline]
 do_xdp_generic+0x757/0xd30 net/core/dev.c:5148
 __netif_receive_skb_core+0x1ce9/0x4690 net/core/dev.c:5492
 __netif_receive_skb_one_core net/core/dev.c:5670 [inline]
 __netif_receive_skb+0x12f/0x650 net/core/dev.c:5785
 netif_receive_skb_internal net/core/dev.c:5871 [inline]
 netif_receive_skb+0x1e8/0x890 net/core/dev.c:5930
 tun_rx_batched+0x1b7/0x8f0 drivers/net/tun.c:1550
 tun_get_user+0x30d6/0x4890 drivers/net/tun.c:2007
 tun_chr_write_iter+0x10d/0x1f0 drivers/net/tun.c:2053
 new_sync_write fs/read_write.c:586 [inline]
 vfs_write+0xaeb/0xd30 fs/read_write.c:679
 ksys_write+0x18f/0x2b0 fs/read_write.c:731
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f941abf7db0
Code: 40 00 48 c7 c2 b8 ff ff ff f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 80 3d f1 e2 07 00 00 74 17 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 58 c3 0f 1f 80 00 00 00 00 48 83 ec 28 48 89
RSP: 002b:00007ffc09852f28 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f941abf7db0
RDX: 0000000000011dc0 RSI: 00000000200004c0 RDI: 00000000000000c8
RBP: 0000000000000000 R08: 00007ffc09853058 R09: 00007ffc09853058
R10: 00007ffc09853058 R11: 0000000000000202 R12: 00007f941ac460de
R13: 0000000000000000 R14: 00007ffc09852f60 R15: 00007ffc09852f50
 </TASK>
BUG: Bad page state in process syz-executor285  pfn:76907
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x76907
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000000 dead000000000040 ffff888022ab2000 0000000000000000
raw: 0000000000000000 0000000000000001 00000000ffffffff 0000000000000000
page dumped because: page_pool leak
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x2820(GFP_ATOMIC|__GFP_NOWARN), pid 5820, tgid 5820 (syz-executor285), ts 62999441200, free_ts 54582364655
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1556
 prep_new_page mm/page_alloc.c:1564 [inline]
 get_page_from_freelist+0x3651/0x37a0 mm/page_alloc.c:3474
 __alloc_pages_noprof+0x292/0x710 mm/page_alloc.c:4751
 alloc_pages_bulk_noprof+0x70b/0xcc0 mm/page_alloc.c:4699
 alloc_pages_bulk_array_node_noprof include/linux/gfp.h:239 [inline]
 __page_pool_alloc_pages_slow+0x122/0x690 net/core/page_pool.c:538
 page_pool_alloc_netmem net/core/page_pool.c:590 [inline]
 page_pool_alloc_pages+0xd0/0x1c0 net/core/page_pool.c:597
 page_pool_alloc include/net/page_pool/helpers.h:129 [inline]
 page_pool_dev_alloc include/net/page_pool/helpers.h:167 [inline]
 skb_pp_cow_data+0xc43/0x1640 net/core/skbuff.c:983
 netif_skb_check_for_xdp net/core/dev.c:5041 [inline]
 netif_receive_generic_xdp net/core/dev.c:5080 [inline]
 do_xdp_generic+0x505/0xd30 net/core/dev.c:5148
 __netif_receive_skb_core+0x1ce9/0x4690 net/core/dev.c:5492
 __netif_receive_skb_one_core net/core/dev.c:5670 [inline]
 __netif_receive_skb+0x12f/0x650 net/core/dev.c:5785
 netif_receive_skb_internal net/core/dev.c:5871 [inline]
 netif_receive_skb+0x1e8/0x890 net/core/dev.c:5930
 tun_rx_batched+0x1b7/0x8f0 drivers/net/tun.c:1550
 tun_get_user+0x30d6/0x4890 drivers/net/tun.c:2007
 tun_chr_write_iter+0x10d/0x1f0 drivers/net/tun.c:2053
 new_sync_write fs/read_write.c:586 [inline]
 vfs_write+0xaeb/0xd30 fs/read_write.c:679
 ksys_write+0x18f/0x2b0 fs/read_write.c:731
page last free pid 5807 tgid 5807 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1127 [inline]
 free_unref_page+0xde3/0x1130 mm/page_alloc.c:2657
 __folio_put+0x2c7/0x440 mm/swap.c:112
 pipe_buf_release include/linux/pipe_fs_i.h:219 [inline]
 pipe_update_tail fs/pipe.c:224 [inline]
 pipe_read+0x6ed/0x13e0 fs/pipe.c:344
 new_sync_read fs/read_write.c:484 [inline]
 vfs_read+0x991/0xb70 fs/read_write.c:565
 ksys_read+0x18f/0x2b0 fs/read_write.c:708
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
Modules linked in:
CPU: 0 UID: 0 PID: 5820 Comm: syz-executor285 Tainted: G    B              6.13.0-rc1-syzkaller-00337-g7503345ac5f5 #0
Tainted: [B]=BAD_PAGE
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 bad_page+0x176/0x1d0 mm/page_alloc.c:501
 free_page_is_bad mm/page_alloc.c:923 [inline]
 free_pages_prepare mm/page_alloc.c:1119 [inline]
 free_unref_page+0x1048/0x1130 mm/page_alloc.c:2657
 bpf_xdp_shrink_data net/core/filter.c:4148 [inline]
 bpf_xdp_frags_shrink_tail+0x3ee/0x7e0 net/core/filter.c:4169
 ____bpf_xdp_adjust_tail net/core/filter.c:4194 [inline]
 bpf_xdp_adjust_tail+0x1c3/0x200 net/core/filter.c:4187
 bpf_prog_f476d5219b92964a+0x1e/0x20
 __bpf_prog_run include/linux/filter.h:701 [inline]
 bpf_prog_run_xdp include/net/xdp.h:514 [inline]
 bpf_prog_run_generic_xdp+0x686/0x1510 net/core/dev.c:4973
 netif_receive_generic_xdp net/core/dev.c:5086 [inline]
 do_xdp_generic+0x757/0xd30 net/core/dev.c:5148
 __netif_receive_skb_core+0x1ce9/0x4690 net/core/dev.c:5492
 __netif_receive_skb_one_core net/core/dev.c:5670 [inline]
 __netif_receive_skb+0x12f/0x650 net/core/dev.c:5785
 netif_receive_skb_internal net/core/dev.c:5871 [inline]
 netif_receive_skb+0x1e8/0x890 net/core/dev.c:5930
 tun_rx_batched+0x1b7/0x8f0 drivers/net/tun.c:1550
 tun_get_user+0x30d6/0x4890 drivers/net/tun.c:2007
 tun_chr_write_iter+0x10d/0x1f0 drivers/net/tun.c:2053
 new_sync_write fs/read_write.c:586 [inline]
 vfs_write+0xaeb/0xd30 fs/read_write.c:679
 ksys_write+0x18f/0x2b0 fs/read_write.c:731
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f941abf7db0
Code: 40 00 48 c7 c2 b8 ff ff ff f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 80 3d f1 e2 07 00 00 74 17 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 58 c3 0f 1f 80 00 00 00 00 48 83 ec 28 48 89
RSP: 002b:00007ffc09852f28 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f941abf7db0
RDX: 0000000000011dc0 RSI: 00000000200004c0 RDI: 00000000000000c8
RBP: 0000000000000000 R08: 00007ffc09853058 R09: 00007ffc09853058
R10: 00007ffc09853058 R11: 0000000000000202 R12: 00007f941ac460de
R13: 0000000000000000 R14: 00007ffc09852f60 R15: 00007ffc09852f50
 </TASK>
BUG: Bad page state in process syz-executor285  pfn:76906
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x76906
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000000 dead000000000040 ffff888022ab2000 0000000000000000
raw: 0000000000000000 0000000000000001 00000000ffffffff 0000000000000000
page dumped because: page_pool leak
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x2820(GFP_ATOMIC|__GFP_NOWARN), pid 5820, tgid 5820 (syz-executor285), ts 62999421067, free_ts 54582851254
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1556
 prep_new_page mm/page_alloc.c:1564 [inline]
 get_page_from_freelist+0x3651/0x37a0 mm/page_alloc.c:3474
 __alloc_pages_noprof+0x292/0x710 mm/page_alloc.c:4751
 alloc_pages_bulk_noprof+0x70b/0xcc0 mm/page_alloc.c:4699
 alloc_pages_bulk_array_node_noprof include/linux/gfp.h:239 [inline]
 __page_pool_alloc_pages_slow+0x122/0x690 net/core/page_pool.c:538
 page_pool_alloc_netmem net/core/page_pool.c:590 [inline]
 page_pool_alloc_pages+0xd0/0x1c0 net/core/page_pool.c:597
 page_pool_alloc include/net/page_pool/helpers.h:129 [inline]
 page_pool_dev_alloc include/net/page_pool/helpers.h:167 [inline]
 skb_pp_cow_data+0xc43/0x1640 net/core/skbuff.c:983
 netif_skb_check_for_xdp net/core/dev.c:5041 [inline]
 netif_receive_generic_xdp net/core/dev.c:5080 [inline]
 do_xdp_generic+0x505/0xd30 net/core/dev.c:5148
 __netif_receive_skb_core+0x1ce9/0x4690 net/core/dev.c:5492
 __netif_receive_skb_one_core net/core/dev.c:5670 [inline]
 __netif_receive_skb+0x12f/0x650 net/core/dev.c:5785
 netif_receive_skb_internal net/core/dev.c:5871 [inline]
 netif_receive_skb+0x1e8/0x890 net/core/dev.c:5930
 tun_rx_batched+0x1b7/0x8f0 drivers/net/tun.c:1550
 tun_get_user+0x30d6/0x4890 drivers/net/tun.c:2007
 tun_chr_write_iter+0x10d/0x1f0 drivers/net/tun.c:2053
 new_sync_write fs/read_write.c:586 [inline]
 vfs_write+0xaeb/0xd30 fs/read_write.c:679
 ksys_write+0x18f/0x2b0 fs/read_write.c:731
page last free pid 5807 tgid 5807 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1127 [inline]
 free_unref_page+0xde3/0x1130 mm/page_alloc.c:2657
 __folio_put+0x2c7/0x440 mm/swap.c:112
 pipe_buf_release include/linux/pipe_fs_i.h:219 [inline]
 pipe_update_tail fs/pipe.c:224 [inline]
 pipe_read+0x6ed/0x13e0 fs/pipe.c:344
 new_sync_read fs/read_write.c:484 [inline]
 vfs_read+0x991/0xb70 fs/read_write.c:565
 ksys_read+0x18f/0x2b0 fs/read_write.c:708
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
Modules linked in:
CPU: 0 UID: 0 PID: 5820 Comm: syz-executor285 Tainted: G    B              6.13.0-rc1-syzkaller-00337-g7503345ac5f5 #0
Tainted: [B]=BAD_PAGE
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 bad_page+0x176/0x1d0 mm/page_alloc.c:501
 free_page_is_bad mm/page_alloc.c:923 [inline]
 free_pages_prepare mm/page_alloc.c:1119 [inline]
 free_unref_page+0x1048/0x1130 mm/page_alloc.c:2657
 bpf_xdp_shrink_data net/core/filter.c:4148 [inline]
 bpf_xdp_frags_shrink_tail+0x3ee/0x7e0 net/core/filter.c:4169
 ____bpf_xdp_adjust_tail net/core/filter.c:4194 [inline]
 bpf_xdp_adjust_tail+0x1c3/0x200 net/core/filter.c:4187
 bpf_prog_f476d5219b92964a+0x1e/0x20
 __bpf_prog_run include/linux/filter.h:701 [inline]
 bpf_prog_run_xdp include/net/xdp.h:514 [inline]
 bpf_prog_run_generic_xdp+0x686/0x1510 net/core/dev.c:4973
 netif_receive_generic_xdp net/core/dev.c:5086 [inline]
 do_xdp_generic+0x757/0xd30 net/core/dev.c:5148
 __netif_receive_skb_core+0x1ce9/0x4690 net/core/dev.c:5492
 __netif_receive_skb_one_core net/core/dev.c:5670 [inline]
 __netif_receive_skb+0x12f/0x650 net/core/dev.c:5785
 netif_receive_skb_internal net/core/dev.c:5871 [inline]
 netif_receive_skb+0x1e8/0x890 net/core/dev.c:5930
 tun_rx_batched+0x1b7/0x8f0 drivers/net/tun.c:1550
 tun_get_user+0x30d6/0x4890 drivers/net/tun.c:2007
 tun_chr_write_iter+0x10d/0x1f0 drivers/net/tun.c:2053
 new_sync_write fs/read_write.c:586 [inline]
 vfs_write+0xaeb/0xd30 fs/read_write.c:679
 ksys_write+0x18f/0x2b0 fs/read_write.c:731
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f941abf7db0
Code: 40 00 48 c7 c2 b8 ff ff ff f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 80 3d f1 e2 07 00 00 74 17 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 58 c3 0f 1f 80 00 00 00 00 48 83 ec 28 48 89
RSP: 002b:00007ffc09852f28 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f941abf7db0
RDX: 0000000000011dc0 RSI: 00000000200004c0 RDI: 00000000000000c8
RBP: 0000000000000000 R08: 00007ffc09853058 R09: 00007ffc09853058
R10: 00007ffc09853058 R11: 0000000000000202 R12: 00007f941ac460de
R13: 0000000000000000 R14: 00007ffc09852f60 R15: 00007ffc09852f50
 </TASK>
BUG: Bad page state in process syz-executor285  pfn:76905
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x76905
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000000 dead000000000040 ffff888022ab2000 0000000000000000
raw: 0000000000000000 0000000000000001 00000000ffffffff 0000000000000000
page dumped because: page_pool leak
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x2820(GFP_ATOMIC|__GFP_NOWARN), pid 5820, tgid 5820 (syz-executor285), ts 62999414838, free_ts 54582871367
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1556
 prep_new_page mm/page_alloc.c:1564 [inline]
 get_page_from_freelist+0x3651/0x37a0 mm/page_alloc.c:3474
 __alloc_pages_noprof+0x292/0x710 mm/page_alloc.c:4751
 alloc_pages_bulk_noprof+0x70b/0xcc0 mm/page_alloc.c:4699
 alloc_pages_bulk_array_node_noprof include/linux/gfp.h:239 [inline]
 __page_pool_alloc_pages_slow+0x122/0x690 net/core/page_pool.c:538
 page_pool_alloc_netmem net/core/page_pool.c:590 [inline]
 page_pool_alloc_pages+0xd0/0x1c0 net/core/page_pool.c:597
 page_pool_alloc include/net/page_pool/helpers.h:129 [inline]
 page_pool_dev_alloc include/net/page_pool/helpers.h:167 [inline]
 skb_pp_cow_data+0xc43/0x1640 net/core/skbuff.c:983
 netif_skb_check_for_xdp net/core/dev.c:5041 [inline]
 netif_receive_generic_xdp net/core/dev.c:5080 [inline]
 do_xdp_generic+0x505/0xd30 net/core/dev.c:5148
 __netif_receive_skb_core+0x1ce9/0x4690 net/core/dev.c:5492
 __netif_receive_skb_one_core net/core/dev.c:5670 [inline]
 __netif_receive_skb+0x12f/0x650 net/core/dev.c:5785
 netif_receive_skb_internal net/core/dev.c:5871 [inline]
 netif_receive_skb+0x1e8/0x890 net/core/dev.c:5930
 tun_rx_batched+0x1b7/0x8f0 drivers/net/tun.c:1550
 tun_get_user+0x30d6/0x4890 drivers/net/tun.c:2007
 tun_chr_write_iter+0x10d/0x1f0 drivers/net/tun.c:2053
 new_sync_write fs/read_write.c:586 [inline]
 vfs_write+0xaeb/0xd30 fs/read_write.c:679
 ksys_write+0x18f/0x2b0 fs/read_write.c:731
page last free pid 5807 tgid 5807 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1127 [inline]
 free_unref_page+0xde3/0x1130 mm/page_alloc.c:2657
 __folio_put+0x2c7/0x440 mm/swap.c:112
 pipe_buf_release include/linux/pipe_fs_i.h:219 [inline]
 pipe_update_tail fs/pipe.c:224 [inline]
 pipe_read+0x6ed/0x13e0 fs/pipe.c:344
 new_sync_read fs/read_write.c:484 [inline]
 vfs_read+0x991/0xb70 fs/read_write.c:565
 ksys_read+0x18f/0x2b0 fs/read_write.c:708
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
Modules linked in:
CPU: 0 UID: 0 PID: 5820 Comm: syz-executor285 Tainted: G    B              6.13.0-rc1-syzkaller-00337-g7503345ac5f5 #0
Tainted: [B]=BAD_PAGE
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 bad_page+0x176/0x1d0 mm/page_alloc.c:501
 free_page_is_bad mm/page_alloc.c:923 [inline]
 free_pages_prepare mm/page_alloc.c:1119 [inline]
 free_unref_page+0x1048/0x1130 mm/page_alloc.c:2657
 bpf_xdp_shrink_data net/core/filter.c:4148 [inline]
 bpf_xdp_frags_shrink_tail+0x3ee/0x7e0 net/core/filter.c:4169
 ____bpf_xdp_adjust_tail net/core/filter.c:4194 [inline]
 bpf_xdp_adjust_tail+0x1c3/0x200 net/core/filter.c:4187
 bpf_prog_f476d5219b92964a+0x1e/0x20
 __bpf_prog_run include/linux/filter.h:701 [inline]
 bpf_prog_run_xdp include/net/xdp.h:514 [inline]
 bpf_prog_run_generic_xdp+0x686/0x1510 net/core/dev.c:4973
 netif_receive_generic_xdp net/core/dev.c:5086 [inline]
 do_xdp_generic+0x757/0xd30 net/core/dev.c:5148
 __netif_receive_skb_core+0x1ce9/0x4690 net/core/dev.c:5492
 __netif_receive_skb_one_core net/core/dev.c:5670 [inline]
 __netif_receive_skb+0x12f/0x650 net/core/dev.c:5785
 netif_receive_skb_internal net/core/dev.c:5871 [inline]
 netif_receive_skb+0x1e8/0x890 net/core/dev.c:5930
 tun_rx_batched+0x1b7/0x8f0 drivers/net/tun.c:1550
 tun_get_user+0x30d6/0x4890 drivers/net/tun.c:2007
 tun_chr_write_iter+0x10d/0x1f0 drivers/net/tun.c:2053
 new_sync_write fs/read_write.c:586 [inline]
 vfs_write+0xaeb/0xd30 fs/read_write.c:679
 ksys_write+0x18f/0x2b0 fs/read_write.c:731
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f941abf7db0
Code: 40 00 48 c7 c2 b8 ff ff ff f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 80 3d f1 e2 07 00 00 74 17 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 58 c3 0f 1f 80 00 00 00 00 48 83 ec 28 48 89
RSP: 002b:00007ffc09852f28 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f941abf7db0
RDX: 0000000000011dc0 RSI: 00000000200004c0 RDI: 00000000000000c8
RBP: 0000000000000000 R08: 00007ffc09853058 R09: 00007ffc09853058
R10: 00007ffc09853058 R11: 0000000000000202 R12: 00007f941ac460de
R13: 0000000000000000 R14: 00007ffc09852f60 R15: 00007ffc09852f50
 </TASK>
BUG: Bad page state in process syz-executor285  pfn:76904
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x76904
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000000 dead000000000040 ffff888022ab2000 0000000000000000
raw: 0000000000000000 0000000000000001 00000000ffffffff 0000000000000000
page dumped because: page_pool leak
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x2820(GFP_ATOMIC|__GFP_NOWARN), pid 5820, tgid 5820 (syz-executor285), ts 62999408239, free_ts 54582895841
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1556
 prep_new_page mm/page_alloc.c:1564 [inline]
 get_page_from_freelist+0x3651/0x37a0 mm/page_alloc.c:3474
 __alloc_pages_noprof+0x292/0x710 mm/page_alloc.c:4751
 alloc_pages_bulk_noprof+0x70b/0xcc0 mm/page_alloc.c:4699
 alloc_pages_bulk_array_node_noprof include/linux/gfp.h:239 [inline]
 __page_pool_alloc_pages_slow+0x122/0x690 net/core/page_pool.c:538
 page_pool_alloc_netmem net/core/page_pool.c:590 [inline]
 page_pool_alloc_pages+0xd0/0x1c0 net/core/page_pool.c:597
 page_pool_alloc include/net/page_pool/helpers.h:129 [inline]
 page_pool_dev_alloc include/net/page_pool/helpers.h:167 [inline]
 skb_pp_cow_data+0xc43/0x1640 net/core/skbuff.c:983
 netif_skb_check_for_xdp net/core/dev.c:5041 [inline]
 netif_receive_generic_xdp net/core/dev.c:5080 [inline]
 do_xdp_generic+0x505/0xd30 net/core/dev.c:5148
 __netif_receive_skb_core+0x1ce9/0x4690 net/core/dev.c:5492
 __netif_receive_skb_one_core net/core/dev.c:5670 [inline]
 __netif_receive_skb+0x12f/0x650 net/core/dev.c:5785
 netif_receive_skb_internal net/core/dev.c:5871 [inline]
 netif_receive_skb+0x1e8/0x890 net/core/dev.c:5930
 tun_rx_batched+0x1b7/0x8f0 drivers/net/tun.c:1550
 tun_get_user+0x30d6/0x4890 drivers/net/tun.c:2007
 tun_chr_write_iter+0x10d/0x1f0 drivers/net/tun.c:2053
 new_sync_write fs/read_write.c:586 [inline]
 vfs_write+0xaeb/0xd30 fs/read_write.c:679
 ksys_write+0x18f/0x2b0 fs/read_write.c:731
page last free pid 5807 tgid 5807 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1127 [inline]
 free_unref_page+0xde3/0x1130 mm/page_alloc.c:2657
 __folio_put+0x2c7/0x440 mm/swap.c:112
 pipe_buf_release include/linux/pipe_fs_i.h:219 [inline]
 pipe_update_tail fs/pipe.c:224 [inline]
 pipe_read+0x6ed/0x13e0 fs/pipe.c:344
 new_sync_read fs/read_write.c:484 [inline]
 vfs_read+0x991/0xb70 fs/read_write.c:565
 ksys_read+0x18f/0x2b0 fs/read_write.c:708
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
Modules linked in:
CPU: 0 UID: 0 PID: 5820 Comm: syz-executor285 Tainted: G    B              6.13.0-rc1-syzkaller-00337-g7503345ac5f5 #0
Tainted: [B]=BAD_PAGE
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 bad_page+0x176/0x1d0 mm/page_alloc.c:501
 free_page_is_bad mm/page_alloc.c:923 [inline]
 free_pages_prepare mm/page_alloc.c:1119 [inline]
 free_unref_page+0x1048/0x1130 mm/page_alloc.c:2657
 bpf_xdp_shrink_data net/core/filter.c:4148 [inline]
 bpf_xdp_frags_shrink_tail+0x3ee/0x7e0 net/core/filter.c:4169
 ____bpf_xdp_adjust_tail net/core/filter.c:4194 [inline]
 bpf_xdp_adjust_tail+0x1c3/0x200 net/core/filter.c:4187
 bpf_prog_f476d5219b92964a+0x1e/0x20
 __bpf_prog_run include/linux/filter.h:701 [inline]
 bpf_prog_run_xdp include/net/xdp.h:514 [inline]
 bpf_prog_run_generic_xdp+0x686/0x1510 net/core/dev.c:4973
 netif_receive_generic_xdp net/core/dev.c:5086 [inline]
 do_xdp_generic+0x757/0xd30 net/core/dev.c:5148
 __netif_receive_skb_core+0x1ce9/0x4690 net/core/dev.c:5492
 __netif_receive_skb_one_core net/core/dev.c:5670 [inline]
 __netif_receive_skb+0x12f/0x650 net/core/dev.c:5785
 netif_receive_skb_internal net/core/dev.c:5871 [inline]
 netif_receive_skb+0x1e8/0x890 net/core/dev.c:5930
 tun_rx_batched+0x1b7/0x8f0 drivers/net/tun.c:1550
 tun_get_user+0x30d6/0x4890 drivers/net/tun.c:2007
 tun_chr_write_iter+0x10d/0x1f0 drivers/net/tun.c:2053
 new_sync_write fs/read_write.c:586 [inline]
 vfs_write+0xaeb/0xd30 fs/read_write.c:679
 ksys_write+0x18f/0x2b0 fs/read_write.c:731
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f941abf7db0
Code: 40 00 48 c7 c2 b8 ff ff ff f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 80 3d f1 e2 07 00 00 74 17 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 58 c3 0f 1f 80 00 00 00 00 48 83 ec 28 48 89
RSP: 002b:00007ffc09852f28 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f941abf7db0
RDX: 0000000000011dc0 RSI: 00000000200004c0 RDI: 00000000000000c8
RBP: 0000000000000000 R08: 00007ffc09853058 R09: 00007ffc09853058
R10: 00007ffc09853058 R11: 0000000000000202 R12: 00007f941ac460de
R13: 0000000000000000 R14: 00007ffc09852f60 R15: 00007ffc09852f50
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

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


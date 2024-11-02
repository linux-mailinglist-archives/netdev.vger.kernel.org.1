Return-Path: <netdev+bounces-141181-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40C899B9D77
	for <lists+netdev@lfdr.de>; Sat,  2 Nov 2024 07:34:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93D461F21103
	for <lists+netdev@lfdr.de>; Sat,  2 Nov 2024 06:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DFEA14601C;
	Sat,  2 Nov 2024 06:34:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60B8130E4A
	for <netdev@vger.kernel.org>; Sat,  2 Nov 2024 06:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730529269; cv=none; b=tRJUu513bjj3v6WXLnwFVFVBTFsOtk8L02mWfcrtzk1knrV2Sx65lWQONqnEZgCpyMU/lgpaDRvXmZgBMHYKNAIHUocL8gUL7c4/6WMUu7hkfVTdmCjPP8RXFvCB4I8I1B3KBW7c0isFbxipg9zRbcwR1CVRn5Mym04sHYDP5Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730529269; c=relaxed/simple;
	bh=adMKo1qmwuuOKwi8cDmH+2ve67ZgaMN149zvaELJ8es=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=D9GnICGAdvtQBxwLShSqDgq/hyDMTQ7ELTZpBbOF2HkcXMrTTIsTb/N8ed5qv6rdB9aX/iO52u+mXnGhR52NIesjxP7OlD6293S0f2UTX/a3CGXhAqxt4/V4mJcmVvKYgRTnpMxz/k4Gu1bfrvzC+QBkKHDgEL+D47CkZU/FnEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a3c4554d29so27126735ab.1
        for <netdev@vger.kernel.org>; Fri, 01 Nov 2024 23:34:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730529265; x=1731134065;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JdG7oARk1oegP5wJqnRv7fAy20npVJVw5n2v28j38sU=;
        b=i7IB0QGAXCbnT+uDHS3obwubSGwQLNuyZrNjvGiOmjaHpCwxj2MNqsihuTjGByaZAZ
         EwlDBLSmCk3rZnbpwopWvDd72N70D7soX6BEPp/D3k72biLitWdf4TU/+spZnf3a7szQ
         V1QWu/LzTxxkkRAIKqOt+wTHUzQuMwr7uskLUeEXMUhGnxY61p8dzjQI51XaIbfvLIa1
         JvFZ2xEN1Ax5KqCSm6tWlt4SQVp8x5FAlMR+whjkXvAUBy+mt6N4XndARPZz80eZDyrM
         V2+XkB4z4B0EID87G+2N1e7nEt1QDf5x3xkB6jypWbOAgtSuSCgvq6Fg5cFIbippq8SK
         A9ng==
X-Forwarded-Encrypted: i=1; AJvYcCV0S/xVBB1VB/UfrdTOPkuJ2AeqJBmQ5bSQ1wlGPA+6Xns8q/GVe+8fx5lc0B8awQ7Bxos5bog=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyWDRbWIOz+4YP8XIkRmrJKuXhRuGN5ZNlh2dRil9hS5vrwDSV
	/WAqjoHo8Mb3HC87aWdwTygoN1OOgMB2PxuGpxsJiugBiLKpZ9DotaBLI+zy8FZx7hLtAiFNbT9
	BULO2dJplUjzfv/F6Z9nvSJGmxEALCa4rSJ98ruJk+X67qg5ZjQmDS98=
X-Google-Smtp-Source: AGHT+IFiqHsPgo4opPZkqbW0p/8VV+k9ojyun+uxLVMKoRp9CH38DgHpzkVMHJwuCHsptax0N1gI51zHwk42dhJAdLQJAaWhJz/g
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cd86:0:b0:3a3:35f0:4c19 with SMTP id
 e9e14a558f8ab-3a6b03b0cd2mr62593755ab.21.1730529264788; Fri, 01 Nov 2024
 23:34:24 -0700 (PDT)
Date: Fri, 01 Nov 2024 23:34:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6725c7f0.050a0220.3c8d68.094c.GAE@google.com>
Subject: [syzbot] [net?] BUG: Bad page state in xdp_test_run_batch
From: syzbot <syzbot+be32baeb2433f286bc24@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, hawk@kernel.org, 
	horms@kernel.org, ilias.apalodimas@linaro.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    e42b1a9a2557 Merge tag 'spi-fix-v6.12-rc5' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1390ca30580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4340261e4e9f37fc
dashboard link: https://syzkaller.appspot.com/bug?extid=be32baeb2433f286bc24
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11ce1ca7980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11813687980000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-e42b1a9a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/964caa6b772d/vmlinux-e42b1a9a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/1912109c7a7f/bzImage-e42b1a9a.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+be32baeb2433f286bc24@syzkaller.appspotmail.com

BUG: Bad page state in process syz-executor153  pfn:346a0
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0xffff8880346a6000 pfn:0x346a0
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000000 dead000000000040 ffff88802a725000 0000000000000000
raw: ffff8880346a6000 0000000000000001 00000000ffffffff 0000000000000000
page dumped because: page_pool leak
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x2820(GFP_ATOMIC|__GFP_NOWARN), pid 5947, tgid 5942 (syz-executor153), ts 50555560392, free_ts 50198891047
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x2d1/0x350 mm/page_alloc.c:1537
 prep_new_page mm/page_alloc.c:1545 [inline]
 get_page_from_freelist+0x101e/0x3070 mm/page_alloc.c:3457
 __alloc_pages_noprof+0x223/0x25a0 mm/page_alloc.c:4733
 alloc_pages_bulk_noprof+0x77c/0x1110 mm/page_alloc.c:4681
 alloc_pages_bulk_array_node_noprof include/linux/gfp.h:239 [inline]
 __page_pool_alloc_pages_slow+0x18f/0x770 net/core/page_pool.c:538
 page_pool_alloc_netmem net/core/page_pool.c:590 [inline]
 page_pool_alloc_netmem+0xc4/0x160 net/core/page_pool.c:577
 page_pool_alloc_pages+0x1a/0x60 net/core/page_pool.c:597
 page_pool_dev_alloc_pages include/net/page_pool/helpers.h:96 [inline]
 xdp_test_run_batch.constprop.0+0x3a8/0x1960 net/bpf/test_run.c:305
 bpf_test_run_xdp_live+0x365/0x500 net/bpf/test_run.c:389
 bpf_prog_test_run_xdp+0x827/0x1580 net/bpf/test_run.c:1317
 bpf_prog_test_run kernel/bpf/syscall.c:4266 [inline]
 __sys_bpf+0xfc6/0x49a0 kernel/bpf/syscall.c:5671
 __do_sys_bpf kernel/bpf/syscall.c:5760 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5758 [inline]
 __x64_sys_bpf+0x78/0xc0 kernel/bpf/syscall.c:5758
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page last free pid 0 tgid 0 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1108 [inline]
 free_unref_page+0x5f4/0xdc0 mm/page_alloc.c:2638
 __folio_put+0x30d/0x3d0 mm/swap.c:126
 folio_put include/linux/mm.h:1478 [inline]
 put_page+0x21e/0x280 include/linux/mm.h:1550
 skb_page_unref include/linux/skbuff_ref.h:43 [inline]
 __skb_frag_unref include/linux/skbuff_ref.h:56 [inline]
 skb_release_data+0x4d7/0x730 net/core/skbuff.c:1119
 skb_release_all net/core/skbuff.c:1190 [inline]
 kfree_skb_add_bulk net/core/skbuff.c:1263 [inline]
 kfree_skb_list_reason+0x2c6/0x4c0 net/core/skbuff.c:1285
 skb_release_data+0x553/0x730 net/core/skbuff.c:1123
 skb_release_all net/core/skbuff.c:1190 [inline]
 napi_consume_skb+0x15a/0x220 net/core/skbuff.c:1518
 skb_defer_free_flush net/core/dev.c:6317 [inline]
 skb_defer_free_flush net/core/dev.c:6301 [inline]
 net_rx_action+0x47c/0x1010 net/core/dev.c:6947
 handle_softirqs+0x213/0x8f0 kernel/softirq.c:554
 __do_softirq kernel/softirq.c:588 [inline]
 invoke_softirq kernel/softirq.c:428 [inline]
 __irq_exit_rcu kernel/softirq.c:637 [inline]
 irq_exit_rcu+0xbb/0x120 kernel/softirq.c:649
 common_interrupt+0xbf/0xe0 arch/x86/kernel/irq.c:278
 asm_common_interrupt+0x26/0x40 arch/x86/include/asm/idtentry.h:693
Modules linked in:
CPU: 3 UID: 0 PID: 5947 Comm: syz-executor153 Not tainted 6.12.0-rc5-syzkaller-00005-ge42b1a9a2557 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x16c/0x1f0 lib/dump_stack.c:120
 bad_page+0xb3/0x1f0 mm/page_alloc.c:501
 free_page_is_bad_report mm/page_alloc.c:908 [inline]
 free_page_is_bad mm/page_alloc.c:918 [inline]
 free_pages_prepare mm/page_alloc.c:1100 [inline]
 free_unref_page+0x657/0xdc0 mm/page_alloc.c:2638
 skb_free_frag include/linux/skbuff.h:3399 [inline]
 skb_free_head+0xa0/0x1d0 net/core/skbuff.c:1096
 skb_release_data+0x560/0x730 net/core/skbuff.c:1125
 skb_release_all net/core/skbuff.c:1190 [inline]
 __kfree_skb net/core/skbuff.c:1204 [inline]
 sk_skb_reason_drop+0x129/0x1a0 net/core/skbuff.c:1242
 kfree_skb_reason include/linux/skbuff.h:1262 [inline]
 __netif_receive_skb_core.constprop.0+0x592/0x4330 net/core/dev.c:5640
 __netif_receive_skb_list_core+0x357/0x950 net/core/dev.c:5741
 __netif_receive_skb_list net/core/dev.c:5808 [inline]
 netif_receive_skb_list_internal+0x753/0xdb0 net/core/dev.c:5899
 netif_receive_skb_list+0x4f/0x4a0 net/core/dev.c:5951
 xdp_recv_frames net/bpf/test_run.c:279 [inline]
 xdp_test_run_batch.constprop.0+0x138d/0x1960 net/bpf/test_run.c:360
 bpf_test_run_xdp_live+0x365/0x500 net/bpf/test_run.c:389
 bpf_prog_test_run_xdp+0x827/0x1580 net/bpf/test_run.c:1317
 bpf_prog_test_run kernel/bpf/syscall.c:4266 [inline]
 __sys_bpf+0xfc6/0x49a0 kernel/bpf/syscall.c:5671
 __do_sys_bpf kernel/bpf/syscall.c:5760 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5758 [inline]
 __x64_sys_bpf+0x78/0xc0 kernel/bpf/syscall.c:5758
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ffb21d3be99
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 51 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffb21cf6228 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 00007ffb21dc6328 RCX: 00007ffb21d3be99
RDX: 0000000000000048 RSI: 0000000020000600 RDI: 000000000000000a
RBP: 00007ffb21dc6320 R08: 00007ffb21cf66c0 R09: 00007ffb21cf66c0
R10: 00007ffb21cf66c0 R11: 0000000000000246 R12: 00007ffb21d93074
R13: 0000000020000eb8 R14: 2caa1414ac000000 R15: 00007ffe38c46e08
 </TASK>
BUG: Bad page state in process syz-executor153  pfn:238f7
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x238f7
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000000 dead000000000040 ffff88802a725000 0000000000000000
raw: 0000000000000000 0000000000000001 00000000ffffffff 0000000000000000
page dumped because: page_pool leak
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x2820(GFP_ATOMIC|__GFP_NOWARN), pid 5947, tgid 5942 (syz-executor153), ts 50555556158, free_ts 50198914286
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x2d1/0x350 mm/page_alloc.c:1537
 prep_new_page mm/page_alloc.c:1545 [inline]
 get_page_from_freelist+0x101e/0x3070 mm/page_alloc.c:3457
 __alloc_pages_noprof+0x223/0x25a0 mm/page_alloc.c:4733
 alloc_pages_bulk_noprof+0x77c/0x1110 mm/page_alloc.c:4681
 alloc_pages_bulk_array_node_noprof include/linux/gfp.h:239 [inline]
 __page_pool_alloc_pages_slow+0x18f/0x770 net/core/page_pool.c:538
 page_pool_alloc_netmem net/core/page_pool.c:590 [inline]
 page_pool_alloc_netmem+0xc4/0x160 net/core/page_pool.c:577
 page_pool_alloc_pages+0x1a/0x60 net/core/page_pool.c:597
 page_pool_dev_alloc_pages include/net/page_pool/helpers.h:96 [inline]
 xdp_test_run_batch.constprop.0+0x3a8/0x1960 net/bpf/test_run.c:305
 bpf_test_run_xdp_live+0x365/0x500 net/bpf/test_run.c:389
 bpf_prog_test_run_xdp+0x827/0x1580 net/bpf/test_run.c:1317
 bpf_prog_test_run kernel/bpf/syscall.c:4266 [inline]
 __sys_bpf+0xfc6/0x49a0 kernel/bpf/syscall.c:5671
 __do_sys_bpf kernel/bpf/syscall.c:5760 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5758 [inline]
 __x64_sys_bpf+0x78/0xc0 kernel/bpf/syscall.c:5758
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page last free pid 0 tgid 0 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1108 [inline]
 free_unref_page+0x5f4/0xdc0 mm/page_alloc.c:2638
 skb_free_frag include/linux/skbuff.h:3399 [inline]
 skb_free_head+0xa0/0x1d0 net/core/skbuff.c:1096
 skb_release_data+0x560/0x730 net/core/skbuff.c:1125
 skb_release_all net/core/skbuff.c:1190 [inline]
 kfree_skb_add_bulk net/core/skbuff.c:1263 [inline]
 kfree_skb_list_reason+0x2c6/0x4c0 net/core/skbuff.c:1285
 skb_release_data+0x553/0x730 net/core/skbuff.c:1123
 skb_release_all net/core/skbuff.c:1190 [inline]
 napi_consume_skb+0x15a/0x220 net/core/skbuff.c:1518
 skb_defer_free_flush net/core/dev.c:6317 [inline]
 skb_defer_free_flush net/core/dev.c:6301 [inline]
 net_rx_action+0x47c/0x1010 net/core/dev.c:6947
 handle_softirqs+0x213/0x8f0 kernel/softirq.c:554
 __do_softirq kernel/softirq.c:588 [inline]
 invoke_softirq kernel/softirq.c:428 [inline]
 __irq_exit_rcu kernel/softirq.c:637 [inline]
 irq_exit_rcu+0xbb/0x120 kernel/softirq.c:649
 common_interrupt+0xbf/0xe0 arch/x86/kernel/irq.c:278
 asm_common_interrupt+0x26/0x40 arch/x86/include/asm/idtentry.h:693
Modules linked in:
CPU: 3 UID: 0 PID: 5947 Comm: syz-executor153 Tainted: G    B              6.12.0-rc5-syzkaller-00005-ge42b1a9a2557 #0
Tainted: [B]=BAD_PAGE
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x16c/0x1f0 lib/dump_stack.c:120
 bad_page+0xb3/0x1f0 mm/page_alloc.c:501
 free_page_is_bad_report mm/page_alloc.c:908 [inline]
 free_page_is_bad mm/page_alloc.c:918 [inline]
 free_pages_prepare mm/page_alloc.c:1100 [inline]
 free_unref_page+0x657/0xdc0 mm/page_alloc.c:2638
 skb_free_frag include/linux/skbuff.h:3399 [inline]
 skb_free_head+0xa0/0x1d0 net/core/skbuff.c:1096
 skb_release_data+0x560/0x730 net/core/skbuff.c:1125
 skb_release_all net/core/skbuff.c:1190 [inline]
 __kfree_skb net/core/skbuff.c:1204 [inline]
 sk_skb_reason_drop+0x129/0x1a0 net/core/skbuff.c:1242
 kfree_skb_reason include/linux/skbuff.h:1262 [inline]
 __netif_receive_skb_core.constprop.0+0x592/0x4330 net/core/dev.c:5640
 __netif_receive_skb_list_core+0x357/0x950 net/core/dev.c:5741
 __netif_receive_skb_list net/core/dev.c:5808 [inline]
 netif_receive_skb_list_internal+0x753/0xdb0 net/core/dev.c:5899
 netif_receive_skb_list+0x4f/0x4a0 net/core/dev.c:5951
 xdp_recv_frames net/bpf/test_run.c:279 [inline]
 xdp_test_run_batch.constprop.0+0x138d/0x1960 net/bpf/test_run.c:360
 bpf_test_run_xdp_live+0x365/0x500 net/bpf/test_run.c:389
 bpf_prog_test_run_xdp+0x827/0x1580 net/bpf/test_run.c:1317
 bpf_prog_test_run kernel/bpf/syscall.c:4266 [inline]
 __sys_bpf+0xfc6/0x49a0 kernel/bpf/syscall.c:5671
 __do_sys_bpf kernel/bpf/syscall.c:5760 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5758 [inline]
 __x64_sys_bpf+0x78/0xc0 kernel/bpf/syscall.c:5758
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ffb21d3be99
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 51 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffb21cf6228 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 00007ffb21dc6328 RCX: 00007ffb21d3be99
RDX: 0000000000000048 RSI: 0000000020000600 RDI: 000000000000000a
RBP: 00007ffb21dc6320 R08: 00007ffb21cf66c0 R09: 00007ffb21cf66c0
R10: 00007ffb21cf66c0 R11: 0000000000000246 R12: 00007ffb21d93074
R13: 0000000020000eb8 R14: 2caa1414ac000000 R15: 00007ffe38c46e08
 </TASK>
BUG: Bad page state in process syz-executor153  pfn:238f6
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x238f6
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000000 dead000000000040 ffff88802a725000 0000000000000000
raw: 0000000000000000 0000000000000001 00000000ffffffff 0000000000000000
page dumped because: page_pool leak
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x2820(GFP_ATOMIC|__GFP_NOWARN), pid 5947, tgid 5942 (syz-executor153), ts 50555552042, free_ts 50198914286
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x2d1/0x350 mm/page_alloc.c:1537
 prep_new_page mm/page_alloc.c:1545 [inline]
 get_page_from_freelist+0x101e/0x3070 mm/page_alloc.c:3457
 __alloc_pages_noprof+0x223/0x25a0 mm/page_alloc.c:4733
 alloc_pages_bulk_noprof+0x77c/0x1110 mm/page_alloc.c:4681
 alloc_pages_bulk_array_node_noprof include/linux/gfp.h:239 [inline]
 __page_pool_alloc_pages_slow+0x18f/0x770 net/core/page_pool.c:538
 page_pool_alloc_netmem net/core/page_pool.c:590 [inline]
 page_pool_alloc_netmem+0xc4/0x160 net/core/page_pool.c:577
 page_pool_alloc_pages+0x1a/0x60 net/core/page_pool.c:597
 page_pool_dev_alloc_pages include/net/page_pool/helpers.h:96 [inline]
 xdp_test_run_batch.constprop.0+0x3a8/0x1960 net/bpf/test_run.c:305
 bpf_test_run_xdp_live+0x365/0x500 net/bpf/test_run.c:389
 bpf_prog_test_run_xdp+0x827/0x1580 net/bpf/test_run.c:1317
 bpf_prog_test_run kernel/bpf/syscall.c:4266 [inline]
 __sys_bpf+0xfc6/0x49a0 kernel/bpf/syscall.c:5671
 __do_sys_bpf kernel/bpf/syscall.c:5760 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5758 [inline]
 __x64_sys_bpf+0x78/0xc0 kernel/bpf/syscall.c:5758
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page last free pid 0 tgid 0 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1108 [inline]
 free_unref_page+0x5f4/0xdc0 mm/page_alloc.c:2638
 skb_free_frag include/linux/skbuff.h:3399 [inline]
 skb_free_head+0xa0/0x1d0 net/core/skbuff.c:1096
 skb_release_data+0x560/0x730 net/core/skbuff.c:1125
 skb_release_all net/core/skbuff.c:1190 [inline]
 kfree_skb_add_bulk net/core/skbuff.c:1263 [inline]
 kfree_skb_list_reason+0x2c6/0x4c0 net/core/skbuff.c:1285
 skb_release_data+0x553/0x730 net/core/skbuff.c:1123
 skb_release_all net/core/skbuff.c:1190 [inline]
 napi_consume_skb+0x15a/0x220 net/core/skbuff.c:1518
 skb_defer_free_flush net/core/dev.c:6317 [inline]
 skb_defer_free_flush net/core/dev.c:6301 [inline]
 net_rx_action+0x47c/0x1010 net/core/dev.c:6947
 handle_softirqs+0x213/0x8f0 kernel/softirq.c:554
 __do_softirq kernel/softirq.c:588 [inline]
 invoke_softirq kernel/softirq.c:428 [inline]
 __irq_exit_rcu kernel/softirq.c:637 [inline]
 irq_exit_rcu+0xbb/0x120 kernel/softirq.c:649
 common_interrupt+0xbf/0xe0 arch/x86/kernel/irq.c:278
 asm_common_interrupt+0x26/0x40 arch/x86/include/asm/idtentry.h:693
Modules linked in:
CPU: 3 UID: 0 PID: 5947 Comm: syz-executor153 Tainted: G    B              6.12.0-rc5-syzkaller-00005-ge42b1a9a2557 #0
Tainted: [B]=BAD_PAGE
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x16c/0x1f0 lib/dump_stack.c:120
 bad_page+0xb3/0x1f0 mm/page_alloc.c:501
 free_page_is_bad_report mm/page_alloc.c:908 [inline]
 free_page_is_bad mm/page_alloc.c:918 [inline]
 free_pages_prepare mm/page_alloc.c:1100 [inline]
 free_unref_page+0x657/0xdc0 mm/page_alloc.c:2638
 skb_free_frag include/linux/skbuff.h:3399 [inline]
 skb_free_head+0xa0/0x1d0 net/core/skbuff.c:1096
 skb_release_data+0x560/0x730 net/core/skbuff.c:1125
 skb_release_all net/core/skbuff.c:1190 [inline]
 __kfree_skb net/core/skbuff.c:1204 [inline]
 sk_skb_reason_drop+0x129/0x1a0 net/core/skbuff.c:1242
 kfree_skb_reason include/linux/skbuff.h:1262 [inline]
 __netif_receive_skb_core.constprop.0+0x592/0x4330 net/core/dev.c:5640
 __netif_receive_skb_list_core+0x357/0x950 net/core/dev.c:5741
 __netif_receive_skb_list net/core/dev.c:5808 [inline]
 netif_receive_skb_list_internal+0x753/0xdb0 net/core/dev.c:5899
 netif_receive_skb_list+0x4f/0x4a0 net/core/dev.c:5951
 xdp_recv_frames net/bpf/test_run.c:279 [inline]
 xdp_test_run_batch.constprop.0+0x138d/0x1960 net/bpf/test_run.c:360
 bpf_test_run_xdp_live+0x365/0x500 net/bpf/test_run.c:389
 bpf_prog_test_run_xdp+0x827/0x1580 net/bpf/test_run.c:1317
 bpf_prog_test_run kernel/bpf/syscall.c:4266 [inline]
 __sys_bpf+0xfc6/0x49a0 kernel/bpf/syscall.c:5671
 __do_sys_bpf kernel/bpf/syscall.c:5760 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5758 [inline]
 __x64_sys_bpf+0x78/0xc0 kernel/bpf/syscall.c:5758
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ffb21d3be99
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 51 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffb21cf6228 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 00007ffb21dc6328 RCX: 00007ffb21d3be99
RDX: 0000000000000048 RSI: 0000000020000600 RDI: 000000000000000a
RBP: 00007ffb21dc6320 R08: 00007ffb21cf66c0 R09: 00007ffb21cf66c0
R10: 00007ffb21cf66c0 R11: 0000000000000246 R12: 00007ffb21d93074
R13: 0000000020000eb8 R14: 2caa1414ac000000 R15: 00007ffe38c46e08
 </TASK>
BUG: Bad page state in process syz-executor153  pfn:238f5
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x238f5
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000000 dead000000000040 ffff88802a725000 0000000000000000
raw: 0000000000000000 0000000000000001 00000000ffffffff 0000000000000000
page dumped because: page_pool leak
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x2820(GFP_ATOMIC|__GFP_NOWARN), pid 5947, tgid 5942 (syz-executor153), ts 50555547812, free_ts 50198914286
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x2d1/0x350 mm/page_alloc.c:1537
 prep_new_page mm/page_alloc.c:1545 [inline]
 get_page_from_freelist+0x101e/0x3070 mm/page_alloc.c:3457
 __alloc_pages_noprof+0x223/0x25a0 mm/page_alloc.c:4733
 alloc_pages_bulk_noprof+0x77c/0x1110 mm/page_alloc.c:4681
 alloc_pages_bulk_array_node_noprof include/linux/gfp.h:239 [inline]
 __page_pool_alloc_pages_slow+0x18f/0x770 net/core/page_pool.c:538
 page_pool_alloc_netmem net/core/page_pool.c:590 [inline]
 page_pool_alloc_netmem+0xc4/0x160 net/core/page_pool.c:577
 page_pool_alloc_pages+0x1a/0x60 net/core/page_pool.c:597
 page_pool_dev_alloc_pages include/net/page_pool/helpers.h:96 [inline]
 xdp_test_run_batch.constprop.0+0x3a8/0x1960 net/bpf/test_run.c:305
 bpf_test_run_xdp_live+0x365/0x500 net/bpf/test_run.c:389
 bpf_prog_test_run_xdp+0x827/0x1580 net/bpf/test_run.c:1317
 bpf_prog_test_run kernel/bpf/syscall.c:4266 [inline]
 __sys_bpf+0xfc6/0x49a0 kernel/bpf/syscall.c:5671
 __do_sys_bpf kernel/bpf/syscall.c:5760 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5758 [inline]
 __x64_sys_bpf+0x78/0xc0 kernel/bpf/syscall.c:5758
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page last free pid 0 tgid 0 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1108 [inline]
 free_unref_page+0x5f4/0xdc0 mm/page_alloc.c:2638
 skb_free_frag include/linux/skbuff.h:3399 [inline]
 skb_free_head+0xa0/0x1d0 net/core/skbuff.c:1096
 skb_release_data+0x560/0x730 net/core/skbuff.c:1125
 skb_release_all net/core/skbuff.c:1190 [inline]
 kfree_skb_add_bulk net/core/skbuff.c:1263 [inline]
 kfree_skb_list_reason+0x2c6/0x4c0 net/core/skbuff.c:1285
 skb_release_data+0x553/0x730 net/core/skbuff.c:1123
 skb_release_all net/core/skbuff.c:1190 [inline]
 napi_consume_skb+0x15a/0x220 net/core/skbuff.c:1518
 skb_defer_free_flush net/core/dev.c:6317 [inline]
 skb_defer_free_flush net/core/dev.c:6301 [inline]
 net_rx_action+0x47c/0x1010 net/core/dev.c:6947
 handle_softirqs+0x213/0x8f0 kernel/softirq.c:554
 __do_softirq kernel/softirq.c:588 [inline]
 invoke_softirq kernel/softirq.c:428 [inline]
 __irq_exit_rcu kernel/softirq.c:637 [inline]
 irq_exit_rcu+0xbb/0x120 kernel/softirq.c:649
 common_interrupt+0xbf/0xe0 arch/x86/kernel/irq.c:278
 asm_common_interrupt+0x26/0x40 arch/x86/include/asm/idtentry.h:693
Modules linked in:
CPU: 3 UID: 0 PID: 5947 Comm: syz-executor153 Tainted: G    B              6.12.0-rc5-syzkaller-00005-ge42b1a9a2557 #0
Tainted: [B]=BAD_PAGE
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x16c/0x1f0 lib/dump_stack.c:120
 bad_page+0xb3/0x1f0 mm/page_alloc.c:501
 free_page_is_bad_report mm/page_alloc.c:908 [inline]
 free_page_is_bad mm/page_alloc.c:918 [inline]
 free_pages_prepare mm/page_alloc.c:1100 [inline]
 free_unref_page+0x657/0xdc0 mm/page_alloc.c:2638
 skb_free_frag include/linux/skbuff.h:3399 [inline]
 skb_free_head+0xa0/0x1d0 net/core/skbuff.c:1096
 skb_release_data+0x560/0x730 net/core/skbuff.c:1125
 skb_release_all net/core/skbuff.c:1190 [inline]
 __kfree_skb net/core/skbuff.c:1204 [inline]
 sk_skb_reason_drop+0x129/0x1a0 net/core/skbuff.c:1242
 kfree_skb_reason include/linux/skbuff.h:1262 [inline]
 __netif_receive_skb_core.constprop.0+0x592/0x4330 net/core/dev.c:5640
 __netif_receive_skb_list_core+0x357/0x950 net/core/dev.c:5741
 __netif_receive_skb_list net/core/dev.c:5808 [inline]
 netif_receive_skb_list_internal+0x753/0xdb0 net/core/dev.c:5899
 netif_receive_skb_list+0x4f/0x4a0 net/core/dev.c:5951
 xdp_recv_frames net/bpf/test_run.c:279 [inline]
 xdp_test_run_batch.constprop.0+0x138d/0x1960 net/bpf/test_run.c:360
 bpf_test_run_xdp_live+0x365/0x500 net/bpf/test_run.c:389
 bpf_prog_test_run_xdp+0x827/0x1580 net/bpf/test_run.c:1317
 bpf_prog_test_run kernel/bpf/syscall.c:4266 [inline]
 __sys_bpf+0xfc6/0x49a0 kernel/bpf/syscall.c:5671
 __do_sys_bpf kernel/bpf/syscall.c:5760 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5758 [inline]
 __x64_sys_bpf+0x78/0xc0 kernel/bpf/syscall.c:5758
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ffb21d3be99
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 51 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffb21cf6228 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 00007ffb21dc6328 RCX: 00007ffb21d3be99
RDX: 0000000000000048 RSI: 0000000020000600 RDI: 000000000000000a
RBP: 00007ffb21dc6320 R08: 00007ffb21cf66c0 R09: 00007ffb21cf66c0
R10: 00007ffb21cf66c0 R11: 0000000000000246 R12: 00007ffb21d93074
R13: 0000000020000eb8 R14: 2caa1414ac000000 R15: 00007ffe38c46e08
 </TASK>
BUG: Bad page state in process syz-executor153  pfn:238f4
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x238f4
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000000 dead000000000040 ffff88802a725000 0000000000000000
raw: 0000000000000000 0000000000000001 00000000ffffffff 0000000000000000
page dumped because: page_pool leak
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x2820(GFP_ATOMIC|__GFP_NOWARN), pid 5947, tgid 5942 (syz-executor153), ts 50555543478, free_ts 50198914286
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x2d1/0x350 mm/page_alloc.c:1537
 prep_new_page mm/page_alloc.c:1545 [inline]
 get_page_from_freelist+0x101e/0x3070 mm/page_alloc.c:3457
 __alloc_pages_noprof+0x223/0x25a0 mm/page_alloc.c:4733
 alloc_pages_bulk_noprof+0x77c/0x1110 mm/page_alloc.c:4681
 alloc_pages_bulk_array_node_noprof include/linux/gfp.h:239 [inline]
 __page_pool_alloc_pages_slow+0x18f/0x770 net/core/page_pool.c:538
 page_pool_alloc_netmem net/core/page_pool.c:590 [inline]
 page_pool_alloc_netmem+0xc4/0x160 net/core/page_pool.c:577
 page_pool_alloc_pages+0x1a/0x60 net/core/page_pool.c:597
 page_pool_dev_alloc_pages include/net/page_pool/helpers.h:96 [inline]
 xdp_test_run_batch.constprop.0+0x3a8/0x1960 net/bpf/test_run.c:305
 bpf_test_run_xdp_live+0x365/0x500 net/bpf/test_run.c:389
 bpf_prog_test_run_xdp+0x827/0x1580 net/bpf/test_run.c:1317
 bpf_prog_test_run kernel/bpf/syscall.c:4266 [inline]
 __sys_bpf+0xfc6/0x49a0 kernel/bpf/syscall.c:5671
 __do_sys_bpf kernel/bpf/syscall.c:5760 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5758 [inline]
 __x64_sys_bpf+0x78/0xc0 kernel/bpf/syscall.c:5758
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page last free pid 0 tgid 0 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1108 [inline]
 free_unref_page+0x5f4/0xdc0 mm/page_alloc.c:2638
 skb_free_frag include/linux/skbuff.h:3399 [inline]
 skb_free_head+0xa0/0x1d0 net/core/skbuff.c:1096
 skb_release_data+0x560/0x730 net/core/skbuff.c:1125
 skb_release_all net/core/skbuff.c:1190 [inline]
 kfree_skb_add_bulk net/core/skbuff.c:1263 [inline]
 kfree_skb_list_reason+0x2c6/0x4c0 net/core/skbuff.c:1285
 skb_release_data+0x553/0x730 net/core/skbuff.c:1123
 skb_release_all net/core/skbuff.c:1190 [inline]
 napi_consume_skb+0x15a/0x220 net/core/skbuff.c:1518
 skb_defer_free_flush net/core/dev.c:6317 [inline]
 skb_defer_free_flush net/core/dev.c:6301 [inline]
 net_rx_action+0x47c/0x1010 net/core/dev.c:6947
 handle_softirqs+0x213/0x8f0 kernel/softirq.c:554
 __do_softirq kernel/softirq.c:588 [inline]
 invoke_softirq kernel/softirq.c:428 [inline]
 __irq_exit_rcu kernel/softirq.c:637 [inline]
 irq_exit_rcu+0xbb/0x120 kernel/softirq.c:649
 common_interrupt+0xbf/0xe0 arch/x86/kernel/irq.c:278
 asm_common_interrupt+0x26/0x40 arch/x86/include/asm/idtentry.h:693
Modules linked in:
CPU: 3 UID: 0 PID: 5947 Comm: syz-executor153 Tainted: G    B              6.12.0-rc5-syzkaller-00005-ge42b1a9a2557 #0
Tainted: [B]=BAD_PAGE
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x16c/0x1f0 lib/dump_stack.c:120
 bad_page+0xb3/0x1f0 mm/page_alloc.c:501
 free_page_is_bad_report mm/page_alloc.c:908 [inline]
 free_page_is_bad mm/page_alloc.c:918 [inline]
 free_pages_prepare mm/page_alloc.c:1100 [inline]
 free_unref_page+0x657/0xdc0 mm/page_alloc.c:2638
 skb_free_frag include/linux/skbuff.h:3399 [inline]
 skb_free_head+0xa0/0x1d0 net/core/skbuff.c:1096
 skb_release_data+0x560/0x730 net/core/skbuff.c:1125
 skb_release_all net/core/skbuff.c:1190 [inline]
 __kfree_skb net/core/skbuff.c:1204 [inline]
 sk_skb_reason_drop+0x129/0x1a0 net/core/skbuff.c:1242
 kfree_skb_reason include/linux/skbuff.h:1262 [inline]
 __netif_receive_skb_core.constprop.0+0x592/0x4330 net/core/dev.c:5640
 __netif_receive_skb_list_core+0x357/0x950 net/core/dev.c:5741
 __netif_receive_skb_list net/core/dev.c:5808 [inline]
 netif_receive_skb_list_internal+0x753/0xdb0 net/core/dev.c:5899
 netif_receive_skb_list+0x4f/0x4a0 net/core/dev.c:5951
 xdp_recv_frames net/bpf/test_run.c:279 [inline]
 xdp_test_run_batch.constprop.0+0x138d/0x1960 net/bpf/test_run.c:360
 bpf_test_run_xdp_live+0x365/0x500 net/bpf/test_run.c:389
 bpf_prog_test_run_xdp+0x827/0x1580 net/bpf/test_run.c:1317
 bpf_prog_test_run kernel/bpf/syscall.c:4266 [inline]
 __sys_bpf+0xfc6/0x49a0 kernel/bpf/syscall.c:5671
 __do_sys_bpf kernel/bpf/syscall.c:5760 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5758 [inline]
 __x64_sys_bpf+0x78/0xc0 kernel/bpf/syscall.c:5758
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ffb21d3be99
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 51 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffb21cf6228 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 00007ffb21dc6328 RCX: 00007ffb21d3be99
RDX: 0000000000000048 RSI: 0000000020000600 RDI: 000000000000000a
RBP: 00007ffb21dc6320 R08: 00007ffb21cf66c0 R09: 00007ffb21cf66c0
R10: 00007ffb21cf66c0 R11: 0000000000000246 R12: 00007ffb21d93074
R13: 0000000020000eb8 R14: 2caa1414ac000000 R15: 00007ffe38c46e08
 </TASK>
BUG: Bad page state in process syz-executor153  pfn:238f3
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x238f3
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000000 dead000000000040 ffff88802a725000 0000000000000000
raw: 0000000000000000 0000000000000001 00000000ffffffff 0000000000000000
page dumped because: page_pool leak
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x2820(GFP_ATOMIC|__GFP_NOWARN), pid 5947, tgid 5942 (syz-executor153), ts 50555527388, free_ts 50198914286
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x2d1/0x350 mm/page_alloc.c:1537
 prep_new_page mm/page_alloc.c:1545 [inline]
 get_page_from_freelist+0x101e/0x3070 mm/page_alloc.c:3457
 __alloc_pages_noprof+0x223/0x25a0 mm/page_alloc.c:4733
 alloc_pages_bulk_noprof+0x77c/0x1110 mm/page_alloc.c:4681
 alloc_pages_bulk_array_node_noprof include/linux/gfp.h:239 [inline]
 __page_pool_alloc_pages_slow+0x18f/0x770 net/core/page_pool.c:538
 page_pool_alloc_netmem net/core/page_pool.c:590 [inline]
 page_pool_alloc_netmem+0xc4/0x160 net/core/page_pool.c:577
 page_pool_alloc_pages+0x1a/0x60 net/core/page_pool.c:597
 page_pool_dev_alloc_pages include/net/page_pool/helpers.h:96 [inline]
 xdp_test_run_batch.constprop.0+0x3a8/0x1960 net/bpf/test_run.c:305
 bpf_test_run_xdp_live+0x365/0x500 net/bpf/test_run.c:389
 bpf_prog_test_run_xdp+0x827/0x1580 net/bpf/test_run.c:1317
 bpf_prog_test_run kernel/bpf/syscall.c:4266 [inline]
 __sys_bpf+0xfc6/0x49a0 kernel/bpf/syscall.c:5671
 __do_sys_bpf kernel/bpf/syscall.c:5760 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5758 [inline]
 __x64_sys_bpf+0x78/0xc0 kernel/bpf/syscall.c:5758
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page last free pid 0 tgid 0 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1108 [inline]
 free_unref_page+0x5f4/0xdc0 mm/page_alloc.c:2638
 skb_free_frag include/linux/skbuff.h:3399 [inline]
 skb_free_head+0xa0/0x1d0 net/core/skbuff.c:1096
 skb_release_data+0x560/0x730 net/core/skbuff.c:1125
 skb_release_all net/core/skbuff.c:1190 [inline]
 kfree_skb_add_bulk net/core/skbuff.c:1263 [inline]
 kfree_skb_list_reason+0x2c6/0x4c0 net/core/skbuff.c:1285
 skb_release_data+0x553/0x730 net/core/skbuff.c:1123
 skb_release_all net/core/skbuff.c:1190 [inline]
 napi_consume_skb+0x15a/0x220 net/core/skbuff.c:1518
 skb_defer_free_flush net/core/dev.c:6317 [inline]
 skb_defer_free_flush net/core/dev.c:6301 [inline]
 net_rx_action+0x47c/0x1010 net/core/dev.c:6947
 handle_softirqs+0x213/0x8f0 kernel/softirq.c:554
 __do_softirq kernel/softirq.c:588 [inline]
 invoke_softirq kernel/softirq.c:428 [inline]
 __irq_exit_rcu kernel/softirq.c:637 [inline]
 irq_exit_rcu+0xbb/0x120 kernel/softirq.c:649
 common_interrupt+0xbf/0xe0 arch/x86/kernel/irq.c:278
 asm_common_interrupt+0x26/0x40 arch/x86/include/asm/idtentry.h:693
Modules linked in:
CPU: 3 UID: 0 PID: 5947 Comm: syz-executor153 Tainted: G    B              6.12.0-rc5-syzkaller-00005-ge42b1a9a2557 #0
Tainted: [B]=BAD_PAGE
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x16c/0x1f0 lib/dump_stack.c:120
 bad_page+0xb3/0x1f0 mm/page_alloc.c:501
 free_page_is_bad_report mm/page_alloc.c:908 [inline]
 free_page_is_bad mm/page_alloc.c:918 [inline]
 free_pages_prepare mm/page_alloc.c:1100 [inline]
 free_unref_page+0x657/0xdc0 mm/page_alloc.c:2638
 skb_free_frag include/linux/skbuff.h:3399 [inline]
 skb_free_head+0xa0/0x1d0 net/core/skbuff.c:1096
 skb_release_data+0x560/0x730 net/core/skbuff.c:1125
 skb_release_all net/core/skbuff.c:1190 [inline]
 __kfree_skb net/core/skbuff.c:1204 [inline]
 sk_skb_reason_drop+0x129/0x1a0 net/core/skbuff.c:1242
 kfree_skb_reason include/linux/skbuff.h:1262 [inline]
 __netif_receive_skb_core.constprop.0+0x592/0x4330 net/core/dev.c:5640
 __netif_receive_skb_list_core+0x357/0x950 net/core/dev.c:5741
 __netif_receive_skb_list net/core/dev.c:5808 [inline]
 netif_receive_skb_list_internal+0x753/0xdb0 net/core/dev.c:5899
 netif_receive_skb_list+0x4f/0x4a0 net/core/dev.c:5951
 xdp_recv_frames net/bpf/test_run.c:279 [inline]
 xdp_test_run_batch.constprop.0+0x138d/0x1960 net/bpf/test_run.c:360
 bpf_test_run_xdp_live+0x365/0x500 net/bpf/test_run.c:389
 bpf_prog_test_run_xdp+0x827/0x1580 net/bpf/test_run.c:1317
 bpf_prog_test_run kernel/bpf/syscall.c:4266 [inline]
 __sys_bpf+0xfc6/0x49a0 kernel/bpf/syscall.c:5671
 __do_sys_bpf kernel/bpf/syscall.c:5760 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5758 [inline]
 __x64_sys_bpf+0x78/0xc0 kernel/bpf/syscall.c:5758
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ffb21d3be99
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 51 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffb21cf6228 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 00007ffb21dc6328 RCX: 00007ffb21d3be99
RDX: 0000000000000048 RSI: 0000000020000600 RDI: 000000000000000a
RBP: 00007ffb21dc6320 R08: 00007ffb21cf66c0 R09: 00007ffb21cf66c0
R10: 00007ffb21cf66c0 R11: 0000000000000246 R12: 00007ffb21d93074
R13: 0000000020000eb8 R14: 2caa1414ac000000 R15: 00007ffe38c46e08
 </TASK>
BUG: Bad page state in process syz-executor153  pfn:238f2
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x238f2
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000000 dead000000000040 ffff88802a725000 0000000000000000
raw: 0000000000000000 0000000000000001 00000000ffffffff 0000000000000000
page dumped because: page_pool leak
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x2820(GFP_ATOMIC|__GFP_NOWARN), pid 5947, tgid 5942 (syz-executor153), ts 50555523073, free_ts 50198914286
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x2d1/0x350 mm/page_alloc.c:1537
 prep_new_page mm/page_alloc.c:1545 [inline]
 get_page_from_freelist+0x101e/0x3070 mm/page_alloc.c:3457
 __alloc_pages_noprof+0x223/0x25a0 mm/page_alloc.c:4733
 alloc_pages_bulk_noprof+0x77c/0x1110 mm/page_alloc.c:4681
 alloc_pages_bulk_array_node_noprof include/linux/gfp.h:239 [inline]
 __page_pool_alloc_pages_slow+0x18f/0x770 net/core/page_pool.c:538
 page_pool_alloc_netmem net/core/page_pool.c:590 [inline]
 page_pool_alloc_netmem+0xc4/0x160 net/core/page_pool.c:577
 page_pool_alloc_pages+0x1a/0x60 net/core/page_pool.c:597
 page_pool_dev_alloc_pages include/net/page_pool/helpers.h:96 [inline]
 xdp_test_run_batch.constprop.0+0x3a8/0x1960 net/bpf/test_run.c:305
 bpf_test_run_xdp_live+0x365/0x500 net/bpf/test_run.c:389
 bpf_prog_test_run_xdp+0x827/0x1580 net/bpf/test_run.c:1317
 bpf_prog_test_run kernel/bpf/syscall.c:4266 [inline]
 __sys_bpf+0xfc6/0x49a0 kernel/bpf/syscall.c:5671
 __do_sys_bpf kernel/bpf/syscall.c:5760 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5758 [inline]
 __x64_sys_bpf+0x78/0xc0 kernel/bpf/syscall.c:5758
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page last free pid 0 tgid 0 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1108 [inline]
 free_unref_page+0x5f4/0xdc0 mm/page_alloc.c:2638
 skb_free_frag include/linux/skbuff.h:3399 [inline]
 skb_free_head+0xa0/0x1d0 net/core/skbuff.c:1096
 skb_release_data+0x560/0x730 net/core/skbuff.c:1125
 skb_release_all net/core/skbuff.c:1190 [inline]
 kfree_skb_add_bulk net/core/skbuff.c:1263 [inline]
 kfree_skb_list_reason+0x2c6/0x4c0 net/core/skbuff.c:1285
 skb_release_data+0x553/0x730 net/core/skbuff.c:1123
 skb_release_all net/core/skbuff.c:1190 [inline]
 napi_consume_skb+0x15a/0x220 net/core/skbuff.c:1518
 skb_defer_free_flush net/core/dev.c:6317 [inline]
 skb_defer_free_flush net/core/dev.c:6301 [inline]
 net_rx_action+0x47c/0x1010 net/core/dev.c:6947
 handle_softirqs+0x213/0x8f0 kernel/softirq.c:554
 __do_softirq kernel/softirq.c:588 [inline]
 invoke_softirq kernel/softirq.c:428 [inline]
 __irq_exit_rcu kernel/softirq.c:637 [inline]
 irq_exit_rcu+0xbb/0x120 kernel/softirq.c:649
 common_interrupt+0xbf/0xe0 arch/x86/kernel/irq.c:278
 asm_common_interrupt+0x26/0x40 arch/x86/include/asm/idtentry.h:693
Modules linked in:
CPU: 3 UID: 0 PID: 5947 Comm: syz-executor153 Tainted: G    B              6.12.0-rc5-syzkaller-00005-ge42b1a9a2557 #0
Tainted: [B]=BAD_PAGE
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x16c/0x1f0 lib/dump_stack.c:120
 bad_page+0xb3/0x1f0 mm/page_alloc.c:501
 free_page_is_bad_report mm/page_alloc.c:908 [inline]
 free_page_is_bad mm/page_alloc.c:918 [inline]
 free_pages_prepare mm/page_alloc.c:1100 [inline]
 free_unref_page+0x657/0xdc0 mm/page_alloc.c:2638
 skb_free_frag include/linux/skbuff.h:3399 [inline]
 skb_free_head+0xa0/0x1d0 net/core/skbuff.c:1096
 skb_release_data+0x560/0x730 net/core/skbuff.c:1125
 skb_release_all net/core/skbuff.c:1190 [inline]
 __kfree_skb net/core/skbuff.c:1204 [inline]
 sk_skb_reason_drop+0x129/0x1a0 net/core/skbuff.c:1242
 kfree_skb_reason include/linux/skbuff.h:1262 [inline]
 __netif_receive_skb_core.constprop.0+0x592/0x4330 net/core/dev.c:5640
 __netif_receive_skb_list_core+0x357/0x950 net/core/dev.c:5741
 __netif_receive_skb_list net/core/dev.c:5808 [inline]
 netif_receive_skb_list_internal+0x753/0xdb0 net/core/dev.c:5899
 netif_receive_skb_list+0x4f/0x4a0 net/core/dev.c:5951
 xdp_recv_frames net/bpf/test_run.c:279 [inline]
 xdp_test_run_batch.constprop.0+0x138d/0x1960 net/bpf/test_run.c:360
 bpf_test_run_xdp_live+0x365/0x500 net/bpf/test_run.c:389
 bpf_prog_test_run_xdp+0x827/0x1580 net/bpf/test_run.c:1317
 bpf_prog_test_run kernel/bpf/syscall.c:4266 [inline]
 __sys_bpf+0xfc6/0x49a0 kernel/bpf/syscall.c:5671
 __do_sys_bpf kernel/bpf/syscall.c:5760 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5758 [inline]
 __x64_sys_bpf+0x78/0xc0 kernel/bpf/syscall.c:5758
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ffb21d3be99
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 51 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffb21cf6228 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 00007ffb21dc6328 RCX: 00007ffb21d3be99
RDX: 0000000000000048 RSI: 0000000020000600 RDI: 000000000000000a
RBP: 00007ffb21dc6320 R08: 00007ffb21cf66c0 R09: 00007ffb21cf66c0
R10: 00007ffb21cf66c0 R11: 0000000000000246 R12: 00007ffb21d93074
R13: 0000000020000eb8 R14: 2caa1414ac000000 R15: 00007ffe38c46e08
 </TASK>
BUG: Bad page state in process syz-executor153  pfn:238f1
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x8 pfn:0x238f1
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000000 dead000000000040 ffff88802a725000 0000000000000000
raw: 0000000000000008 0000000000000001 00000000ffffffff 0000000000000000
page dumped because: page_pool leak
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x2820(GFP_ATOMIC|__GFP_NOWARN), pid 5947, tgid 5942 (syz-executor153), ts 50555518976, free_ts 50198914286
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x2d1/0x350 mm/page_alloc.c:1537
 prep_new_page mm/page_alloc.c:1545 [inline]
 get_page_from_freelist+0x101e/0x3070 mm/page_alloc.c:3457
 __alloc_pages_noprof+0x223/0x25a0 mm/page_alloc.c:4733
 alloc_pages_bulk_noprof+0x77c/0x1110 mm/page_alloc.c:4681
 alloc_pages_bulk_array_node_noprof include/linux/gfp.h:239 [inline]
 __page_pool_alloc_pages_slow+0x18f/0x770 net/core/page_pool.c:538
 page_pool_alloc_netmem net/core/page_pool.c:590 [inline]
 page_pool_alloc_netmem+0xc4/0x160 net/core/page_pool.c:577
 page_pool_alloc_pages+0x1a/0x60 net/core/page_pool.c:597
 page_pool_dev_alloc_pages include/net/page_pool/helpers.h:96 [inline]
 xdp_test_run_batch.constprop.0+0x3a8/0x1960 net/bpf/test_run.c:305
 bpf_test_run_xdp_live+0x365/0x500 net/bpf/test_run.c:389
 bpf_prog_test_run_xdp+0x827/0x1580 net/bpf/test_run.c:1317
 bpf_prog_test_run kernel/bpf/syscall.c:4266 [inline]
 __sys_bpf+0xfc6/0x49a0 kernel/bpf/syscall.c:5671
 __do_sys_bpf kernel/bpf/syscall.c:5760 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5758 [inline]
 __x64_sys_bpf+0x78/0xc0 kernel/bpf/syscall.c:5758
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page last free pid 0 tgid 0 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1108 [inline]
 free_unref_page+0x5f4/0xdc0 mm/page_alloc.c:2638
 skb_free_frag include/linux/skbuff.h:3399 [inline]
 skb_free_head+0xa0/0x1d0 net/core/skbuff.c:1096
 skb_release_data+0x560/0x730 net/core/skbuff.c:1125
 skb_release_all net/core/skbuff.c:1190 [inline]
 kfree_skb_add_bulk net/core/skbuff.c:1263 [inline]
 kfree_skb_list_reason+0x2c6/0x4c0 net/core/skbuff.c:1285
 skb_release_data+0x553/0x730 net/core/skbuff.c:1123
 skb_release_all net/core/skbuff.c:1190 [inline]
 napi_consume_skb+0x15a/0x220 net/core/skbuff.c:1518
 skb_defer_free_flush net/core/dev.c:6317 [inline]
 skb_defer_free_flush net/core/dev.c:6301 [inline]
 net_rx_action+0x47c/0x1010 net/core/dev.c:6947
 handle_softirqs+0x213/0x8f0 kernel/softirq.c:554
 __do_softirq kernel/softirq.c:588 [inline]
 invoke_softirq kernel/softirq.c:428 [inline]
 __irq_exit_rcu kernel/softirq.c:637 [inline]
 irq_exit_rcu+0xbb/0x120 kernel/softirq.c:649
 common_interrupt+0xbf/0xe0 arch/x86/kernel/irq.c:278
 asm_common_interrupt+0x26/0x40 arch/x86/include/asm/idtentry.h:693
Modules linked in:
CPU: 3 UID: 0 PID: 5947 Comm: syz-executor153 Tainted: G    B              6.12.0-rc5-syzkaller-00005-ge42b1a9a2557 #0
Tainted: [B]=BAD_PAGE
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x16c/0x1f0 lib/dump_stack.c:120
 bad_page+0xb3/0x1f0 mm/page_alloc.c:501
 free_page_is_bad_report mm/page_alloc.c:908 [inline]
 free_page_is_bad mm/page_alloc.c:918 [inline]
 free_pages_prepare mm/page_alloc.c:1100 [inline]
 free_unref_page+0x657/0xdc0 mm/page_alloc.c:2638
 skb_free_frag include/linux/skbuff.h:3399 [inline]
 skb_free_head+0xa0/0x1d0 net/core/skbuff.c:1096
 skb_release_data+0x560/0x730 net/core/skbuff.c:1125
 skb_release_all net/core/skbuff.c:1190 [inline]
 __kfree_skb net/core/skbuff.c:1204 [inline]
 sk_skb_reason_drop+0x129/0x1a0 net/core/skbuff.c:1242
 kfree_skb_reason include/linux/skbuff.h:1262 [inline]
 __netif_receive_skb_core.constprop.0+0x592/0x4330 net/core/dev.c:5640
 __netif_receive_skb_list_core+0x357/0x950 net/core/dev.c:5741
 __netif_receive_skb_list net/core/dev.c:5808 [inline]
 netif_receive_skb_list_internal+0x753/0xdb0 net/core/dev.c:5899
 netif_receive_skb_list+0x4f/0x4a0 net/core/dev.c:5951
 xdp_recv_frames net/bpf/test_run.c:279 [inline]
 xdp_test_run_batch.constprop.0+0x138d/0x1960 net/bpf/test_run.c:360
 bpf_test_run_xdp_live+0x365/0x500 net/bpf/test_run.c:389
 bpf_prog_test_run_xdp+0x827/0x1580 net/bpf/test_run.c:1317
 bpf_prog_test_run kernel/bpf/syscall.c:4266 [inline]
 __sys_bpf+0xfc6/0x49a0 kernel/bpf/syscall.c:5671
 __do_sys_bpf kernel/bpf/syscall.c:5760 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5758 [inline]
 __x64_sys_bpf+0x78/0xc0 kernel/bpf/syscall.c:5758
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ffb21d3be99
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 51 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffb21cf6228 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 00007ffb21dc6328 RCX: 00007ffb21d3be99
RDX: 0000000000000048 RSI: 0000000020000600 RDI: 000000000000000a
RBP: 00007ffb21dc6320 R08: 00007ffb21cf66c0 R09: 00007ffb21cf66c0
R10: 00007ffb21cf66c0 R11: 0000000000000246 R12: 00007ffb21d93074
R13: 0000000020000eb8 R14: 2caa1414ac000000 R15: 00007ffe38c46e08
 </TASK>
BUG: Bad page state in process syz-executor153  pfn:238f0
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0xffff8880238f6600 pfn:0x238f0
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000000 dead000000000040 ffff88802a725000 0000000000000000
raw: ffff8880238f6600 0000000000000001 00000000ffffffff 0000000000000000
page dumped because: page_pool leak
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x2820(GFP_ATOMIC|__GFP_NOWARN), pid 5947, tgid 5942 (syz-executor153), ts 50555514682, free_ts 50198914286
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x2d1/0x350 mm/page_alloc.c:1537
 prep_new_page mm/page_alloc.c:1545 [inline]
 get_page_from_freelist+0x101e/0x3070 mm/page_alloc.c:3457
 __alloc_pages_noprof+0x223/0x25a0 mm/page_alloc.c:4733
 alloc_pages_bulk_noprof+0x77c/0x1110 mm/page_alloc.c:4681
 alloc_pages_bulk_array_node_noprof include/linux/gfp.h:239 [inline]
 __page_pool_alloc_pages_slow+0x18f/0x770 net/core/page_pool.c:538
 page_pool_alloc_netmem net/core/page_pool.c:590 [inline]
 page_pool_alloc_netmem+0xc4/0x160 net/core/page_pool.c:577
 page_pool_alloc_pages+0x1a/0x60 net/core/page_pool.c:597
 page_pool_dev_alloc_pages include/net/page_pool/helpers.h:96 [inline]
 xdp_test_run_batch.constprop.0+0x3a8/0x1960 net/bpf/test_run.c:305
 bpf_test_run_xdp_live+0x365/0x500 net/bpf/test_run.c:389
 bpf_prog_test_run_xdp+0x827/0x1580 net/bpf/test_run.c:1317
 bpf_prog_test_run kernel/bpf/syscall.c:4266 [inline]
 __sys_bpf+0xfc6/0x49a0 kernel/bpf/syscall.c:5671
 __do_sys_bpf kernel/bpf/syscall.c:5760 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5758 [inline]
 __x64_sys_bpf+0x78/0xc0 kernel/bpf/syscall.c:5758
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page last free pid 0 tgid 0 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1108 [inline]
 free_unref_page+0x5f4/0xdc0 mm/page_alloc.c:2638
 skb_free_frag include/linux/skbuff.h:3399 [inline]
 skb_free_head+0xa0/0x1d0 net/core/skbuff.c:1096
 skb_release_data+0x560/0x730 net/core/skbuff.c:1125
 skb_release_all net/core/skbuff.c:1190 [inline]
 kfree_skb_add_bulk net/core/skbuff.c:1263 [inline]
 kfree_skb_list_reason+0x2c6/0x4c0 net/core/skbuff.c:1285
 skb_release_data+0x553/0x730 net/core/skbuff.c:1123
 skb_release_all net/core/skbuff.c:1190 [inline]
 napi_consume_skb+0x15a/0x220 net/core/skbuff.c:1518
 skb_defer_free_flush net/core/dev.c:6317 [inline]
 skb_defer_free_flush net/core/dev.c:6301 [inline]
 net_rx_action+0x47c/0x1010 net/core/dev.c:6947
 handle_softirqs+0x213/0x8f0 kernel/softirq.c:554
 __do_softirq kernel/softirq.c:588 [inline]
 invoke_softirq kernel/softirq.c:428 [inline]
 __irq_exit_rcu kernel/softirq.c:637 [inline]
 irq_exit_rcu+0xbb/0x120 kernel/softirq.c:649
 common_interrupt+0xbf/0xe0 arch/x86/kernel/irq.c:278
 asm_common_interrupt+0x26/0x40 arch/x86/include/asm/idtentry.h:693
Modules linked in:
CPU: 3 UID: 0 PID: 5947 Comm: syz-executor153 Tainted: G    B              6.12.0-rc5-syzkaller-00005-ge42b1a9a2557 #0
Tainted: [B]=BAD_PAGE
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x16c/0x1f0 lib/dump_stack.c:120
 bad_page+0xb3/0x1f0 mm/page_alloc.c:501
 free_page_is_bad_report mm/page_alloc.c:908 [inline]
 free_page_is_bad mm/page_alloc.c:918 [inline]
 free_pages_prepare mm/page_alloc.c:1100 [inline]
 free_unref_page+0x657/0xdc0 mm/page_alloc.c:2638
 skb_free_frag include/linux/skbuff.h:3399 [inline]
 skb_free_head+0xa0/0x1d0 net/core/skbuff.c:1096
 skb_release_data+0x560/0x730 net/core/skbuff.c:1125
 skb_release_all net/core/skbuff.c:1190 [inline]
 __kfree_skb net/core/skbuff.c:1204 [inline]
 sk_skb_reason_drop+0x129/0x1a0 net/core/skbuff.c:1242
 kfree_skb_reason include/linux/skbuff.h:1262 [inline]
 __netif_receive_skb_core.constprop.0+0x592/0x4330 net/core/dev.c:5640
 __netif_receive_skb_list_core+0x357/0x950 net/core/dev.c:5741
 __netif_receive_skb_list net/core/dev.c:5808 [inline]
 netif_receive_skb_list_internal+0x753/0xdb0 net/core/dev.c:5899
 netif_receive_skb_list+0x4f/0x4a0 net/core/dev.c:5951
 xdp_recv_frames net/bpf/test_run.c:279 [inline]
 xdp_test_run_batch.constprop.0+0x138d/0x1960 net/bpf/test_run.c:360
 bpf_test_run_xdp_live+0x365/0x500 net/bpf/test_run.c:389
 bpf_prog_test_run_xdp+0x827/0x1580 net/bpf/test_run.c:1317
 bpf_prog_test_run kernel/bpf/syscall.c:4266 [inline]
 __sys_bpf+0xfc6/0x49a0 kernel/bpf/syscall.c:5671
 __do_sys_bpf kernel/bpf/syscall.c:5760 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5758 [inline]
 __x64_sys_bpf+0x78/0xc0 kernel/bpf/syscall.c:5758
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ffb21d3be99
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 51 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffb21cf6228 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 00007ffb21dc6328 RCX: 00007ffb21d3be99
RDX: 0000000000000048 RSI: 0000000020000600 RDI: 000000000000000a
RBP: 00007ffb21dc6320 R08: 00007ffb21cf66c0 R09: 00007ffb21cf66c0
R10: 00007ffb21cf66c0 R11: 0000000000000246 R12: 00007ffb21d93074
R13: 0000000020000eb8 R14: 2caa1414ac000000 R15: 00007ffe38c46e08
 </TASK>
BUG: Bad page state in process syz-executor153  pfn:32107
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x32107
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000000 dead000000000040 ffff88802a725000 0000000000000000
raw: 0000000000000000 0000000000000001 00000000ffffffff 0000000000000000
page dumped because: page_pool leak
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x2820(GFP_ATOMIC|__GFP_NOWARN), pid 5947, tgid 5942 (syz-executor153), ts 50555510308, free_ts 50198924742
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x2d1/0x350 mm/page_alloc.c:1537
 prep_new_page mm/page_alloc.c:1545 [inline]
 get_page_from_freelist+0x101e/0x3070 mm/page_alloc.c:3457
 __alloc_pages_noprof+0x223/0x25a0 mm/page_alloc.c:4733
 alloc_pages_bulk_noprof+0x77c/0x1110 mm/page_alloc.c:4681
 alloc_pages_bulk_array_node_noprof include/linux/gfp.h:239 [inline]
 __page_pool_alloc_pages_slow+0x18f/0x770 net/core/page_pool.c:538
 page_pool_alloc_netmem net/core/page_pool.c:590 [inline]
 page_pool_alloc_netmem+0xc4/0x160 net/core/page_pool.c:577
 page_pool_alloc_pages+0x1a/0x60 net/core/page_pool.c:597
 page_pool_dev_alloc_pages include/net/page_pool/helpers.h:96 [inline]
 xdp_test_run_batch.constprop.0+0x3a8/0x1960 net/bpf/test_run.c:305
 bpf_test_run_xdp_live+0x365/0x500 net/bpf/test_run.c:389
 bpf_prog_test_run_xdp+0x827/0x1580 net/bpf/test_run.c:1317
 bpf_prog_test_run kernel/bpf/syscall.c:4266 [inline]
 __sys_bpf+0xfc6/0x49a0 kernel/bpf/syscall.c:5671
 __do_sys_bpf kernel/bpf/syscall.c:5760 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5758 [inline]
 __x64_sys_bpf+0x78/0xc0 kernel/bpf/syscall.c:5758
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page last free pid 0 tgid 0 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1108 [inline]
 free_unref_page+0x5f4/0xdc0 mm/page_alloc.c:2638
 skb_free_frag include/linux/skbuff.h:3399 [inline]
 skb_free_head+0xa0/0x1d0 net/core/skbuff.c:1096
 skb_release_data+0x560/0x730 net/core/skbuff.c:1125
 skb_release_all net/core/skbuff.c:1190 [inline]
 napi_consume_skb+0x15a/0x220 net/core/skbuff.c:1518
 skb_defer_free_flush net/core/dev.c:6317 [inline]
 skb_defer_free_flush net/core/dev.c:6301 [inline]
 net_rx_action+0x47c/0x1010 net/core/dev.c:6947
 handle_softirqs+0x213/0x8f0 kernel/softirq.c:554
 __do_softirq kernel/softirq.c:588 [inline]
 invoke_softirq kernel/softirq.c:428 [inline]
 __irq_exit_rcu kernel/softirq.c:637 [inline]
 irq_exit_rcu+0xbb/0x120 kernel/softirq.c:649
 common_interrupt+0xbf/0xe0 arch/x86/kernel/irq.c:278
 asm_common_interrupt+0x26/0x40 arch/x86/include/asm/idtentry.h:693
Modules linked in:
CPU: 3 UID: 0 PID: 5947 Comm: syz-executor153 Tainted: G    B              6.12.0-rc5-syzkaller-00005-ge42b1a9a2557 #0
Tainted: [B]=BAD_PAGE
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x16c/0x1f0 lib/dump_stack.c:120
 bad_page+0xb3/0x1f0 mm/page_alloc.c:501
 free_page_is_bad_report mm/page_alloc.c:908 [inline]
 free_page_is_bad mm/page_alloc.c:918 [inline]
 free_pages_prepare mm/page_alloc.c:1100 [inline]
 free_unref_page+0x657/0xdc0 mm/page_alloc.c:2638
 skb_free_frag include/linux/skbuff.h:3399 [inline]
 skb_free_head+0xa0/0x1d0 net/core/skbuff.c:1096
 skb_release_data+0x560/0x730 net/core/skbuff.c:1125
 skb_release_all net/core/skbuff.c:1190 [inline]
 __kfree_skb net/core/skbuff.c:1204 [inline]
 sk_skb_reason_drop+0x129/0x1a0 net/core/skbuff.c:1242
 kfree_skb_reason include/linux/skbuff.h:1262 [inline]
 __netif_receive_skb_core.constprop.0+0x592/0x4330 net/core/dev.c:5640
 __netif_receive_skb_list_core+0x357/0x950 net/core/dev.c:5741
 __netif_receive_skb_list net/core/dev.c:5808 [inline]
 netif_receive_skb_list_internal+0x753/0xdb0 net/core/dev.c:5899
 netif_receive_skb_list+0x4f/0x4a0 net/core/dev.c:5951
 xdp_recv_frames net/bpf/test_run.c:279 [inline]
 xdp_test_run_batch.constprop.0+0x138d/0x1960 net/bpf/test_run.c:360
 bpf_test_run_xdp_live+0x365/0x500 net/bpf/test_run.c:389
 bpf_prog_test_run_xdp+0x827/0x1580 net/bpf/test_run.c:1317
 bpf_prog_test_run kernel/bpf/syscall.c:4266 [inline]
 __sys_bpf+0xfc6/0x49a0 kernel/bpf/syscall.c:5671
 __do_sys_bpf kernel/bpf/syscall.c:5760 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5758 [inline]
 __x64_sys_bpf+0x78/0xc0 kernel/bpf/syscall.c:5758
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ffb21d3be99
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 51 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffb21cf6228 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 00007ffb21dc6328 RCX: 00007ffb21d3be99
RDX: 0000000000000048 RSI: 0000000020000600 RDI: 000000000000000a
RBP: 00007ffb21dc6320 R08: 00007ffb21cf66c0 R09: 00007ffb21cf66c0
R10: 00007ffb21cf66c0 R11: 0000000000000246 R12: 00007ffb21d93074
R13: 0000000020000eb8 R14: 2caa1414ac000000 R15: 00007ffe38c46e08
 </TASK>
BUG: Bad page state in process syz-executor153  pfn:32106
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x32106
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000000 dead000000000040 ffff88802a725000 0000000000000000
raw: 0000000000000000 0000000000000001 00000000ffffffff 0000000000000000
page dumped because: page_pool leak
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x2820(GFP_ATOMIC|__GFP_NOWARN), pid 5947, tgid 5942 (syz-executor153), ts 50555506145, free_ts 50198924742
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x2d1/0x350 mm/page_alloc.c:1537
 prep_new_page mm/page_alloc.c:1545 [inline]
 get_page_from_freelist+0x101e/0x3070 mm/page_alloc.c:3457
 __alloc_pages_noprof+0x223/0x25a0 mm/page_alloc.c:4733
 alloc_pages_bulk_noprof+0x77c/0x1110 mm/page_alloc.c:4681
 alloc_pages_bulk_array_node_noprof include/linux/gfp.h:239 [inline]
 __page_pool_alloc_pages_slow+0x18f/0x770 net/core/page_pool.c:538
 page_pool_alloc_netmem net/core/page_pool.c:590 [inline]
 page_pool_alloc_netmem+0xc4/0x160 net/core/page_pool.c:577
 page_pool_alloc_pages+0x1a/0x60 net/core/page_pool.c:597
 page_pool_dev_alloc_pages include/net/page_pool/helpers.h:96 [inline]
 xdp_test_run_batch.constprop.0+0x3a8/0x1960 net/bpf/test_run.c:305
 bpf_test_run_xdp_live+0x365/0x500 net/bpf/test_run.c:389
 bpf_prog_test_run_xdp+0x827/0x1580 net/bpf/test_run.c:1317
 bpf_prog_test_run kernel/bpf/syscall.c:4266 [inline]
 __sys_bpf+0xfc6/0x49a0 kernel/bpf/syscall.c:5671
 __do_sys_bpf kernel/bpf/syscall.c:5760 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5758 [inline]
 __x64_sys_bpf+0x78/0xc0 kernel/bpf/syscall.c:5758
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page last free pid 0 tgid 0 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1108 [inline]
 free_unref_page+0x5f4/0xdc0 mm/page_alloc.c:2638
 skb_free_frag include/linux/skbuff.h:3399 [inline]
 skb_free_head+0xa0/0x1d0 net/core/skbuff.c:1096
 skb_release_data+0x560/0x730 net/core/skbuff.c:1125
 skb_release_all net/core/skbuff.c:1190 [inline]
 napi_consume_skb+0x15a/0x220 net/core/skbuff.c:1518
 skb_defer_free_flush net/core/dev.c:6317 [inline]
 skb_defer_free_flush net/core/dev.c:6301 [inline]
 net_rx_action+0x47c/0x1010 net/core/dev.c:6947
 handle_softirqs+0x213/0x8f0 kernel/softirq.c:554
 __do_softirq kernel/softirq.c:588 [inline]
 invoke_softirq kernel/softirq.c:428 [inline]
 __irq_exit_rcu kernel/softirq.c:637 [inline]
 irq_exit_rcu+0xbb/0x120 kernel/softirq.c:649
 common_interrupt+0xbf/0xe0 arch/x86/kernel/irq.c:278
 asm_common_interrupt+0x26/0x40 arch/x86/include/asm/idtentry.h:693
Modules linked in:
CPU: 3 UID: 0 PID: 5947 Comm: syz-executor153 Tainted: G    B              6.12.0-rc5-syzkaller-00005-ge42b1a9a2557 #0
Tainted: [B]=BAD_PAGE
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x16c/0x1f0 lib/dump_stack.c:120
 bad_page+0xb3/0x1f0 mm/page_alloc.c:501
 free_page_is_bad_report mm/page_alloc.c:908 [inline]
 free_page_is_bad mm/page_alloc.c:918 [inline]
 free_pages_prepare mm/page_alloc.c:1100 [inline]
 free_unref_page+0x657/0xdc0 mm/page_alloc.c:2638
 skb_free_frag include/linux/skbuff.h:3399 [inline]
 skb_free_head+0xa0/0x1d0 net/core/skbuff.c:1096
 skb_release_data+0x560/0x730 net/core/skbuff.c:1125
 skb_release_all net/core/skbuff.c:1190 [inline]
 __kfree_skb net/core/skbuff.c:1204 [inline]
 sk_skb_reason_drop+0x129/0x1a0 net/core/skbuff.c:1242
 kfree_skb_reason include/linux/skbuff.h:1262 [inline]
 __netif_receive_skb_core.constprop.0+0x592/0x4330 net/core/dev.c:5640
 __netif_receive_skb_list_core+0x357/0x950 net/core/dev.c:5741
 __netif_receive_skb_list net/core/dev.c:5808 [inline]
 netif_receive_skb_list_internal+0x753/0xdb0 net/core/dev.c:5899
 netif_receive_skb_list+0x4f/0x4a0 net/core/dev.c:5951
 xdp_recv_frames net/bpf/test_run.c:279 [inline]
 xdp_test_run_batch.constprop.0+0x138d/0x1960 net/bpf/test_run.c:360
 bpf_test_run_xdp_live+0x365/0x500 net/bpf/test_run.c:389
 bpf_prog_test_run_xdp+0x827/0x1580 net/bpf/test_run.c:1317
 bpf_prog_test_run kernel/bpf/syscall.c:4266 [inline]
 __sys_bpf+0xfc6/0x49a0 kernel/bpf/syscall.c:5671
 __do_sys_bpf kernel/bpf/syscall.c:5760 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5758 [inline]
 __x64_sys_bpf+0x78/0xc0 kernel/bpf/syscall.c:5758
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ffb21d3be99
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 51 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffb21cf6228 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 00007ffb21dc6328 RCX: 00007ffb21d3be99
RDX: 0000000000000048 RSI: 0000000020000600 RDI: 000000000000000a
RBP: 00007ffb21dc6320 R08: 00007ffb21cf66c0 R09: 00007ffb21cf66c0
R10: 00007ffb21cf66c0 R11: 0000000000000246 R12: 00007ffb21d93074
R13: 0000000020000eb8 R14: 2caa1414ac000000 R15: 00007ffe38c46e08
 </TASK>
BUG: Bad page state in process syz-executor153  pfn:32105
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x32105
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000000 dead000000000040 ffff88802a725000 0000000000000000
raw: 0000000000000000 0000000000000001 00000000ffffffff 0000000000000000
page dumped because: page_pool leak
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x2820(GFP_ATOMIC|__GFP_NOWARN), pid 5947, tgid 5942 (syz-executor153), ts 50555501696, free_ts 50198924742
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x2d1/0x350 mm/page_alloc.c:1537
 prep_new_page mm/page_alloc.c:1545 [inline]
 get_page_from_freelist+0x101e/0x3070 mm/page_alloc.c:3457
 __alloc_pages_noprof+0x223/0x25a0 mm/page_alloc.c:4733
 alloc_pages_bulk_noprof+0x77c/0x1110 mm/page_alloc.c:4681
 alloc_pages_bulk_array_node_noprof include/linux/gfp.h:239 [inline]
 __page_pool_alloc_pages_slow+0x18f/0x770 net/core/page_pool.c:538
 page_pool_alloc_netmem net/core/page_pool.c:590 [inline]
 page_pool_alloc_netmem+0xc4/0x160 net/core/page_pool.c:577
 page_pool_alloc_pages+0x1a/0x60 net/core/page_pool.c:597
 page_pool_dev_alloc_pages include/net/page_pool/helpers.h:96 [inline]
 xdp_test_run_batch.constprop.0+0x3a8/0x1960 net/bpf/test_run.c:305
 bpf_test_run_xdp_live+0x365/0x500 net/bpf/test_run.c:389
 bpf_prog_test_run_xdp+0x827/0x1580 net/bpf/test_run.c:1317
 bpf_prog_test_run kernel/bpf/syscall.c:4266 [inline]
 __sys_bpf+0xfc6/0x49a0 kernel/bpf/syscall.c:5671
 __do_sys_bpf kernel/bpf/syscall.c:5760 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5758 [inline]
 __x64_sys_bpf+0x78/0xc0 kernel/bpf/syscall.c:5758
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page last free pid 0 tgid 0 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1108 [inline]
 free_unref_page+0x5f4/0xdc0 mm/page_alloc.c:2638
 skb_free_frag include/linux/skbuff.h:3399 [inline]
 skb_free_head+0xa0/0x1d0 net/core/skbuff.c:1096
 skb_release_data+0x560/0x730 net/core/skbuff.c:1125
 skb_release_all net/core/skbuff.c:1190 [inline]
 napi_consume_skb+0x15a/0x220 net/core/skbuff.c:1518
 skb_defer_free_flush net/core/dev.c:6317 [inline]
 skb_defer_free_flush net/core/dev.c:6301 [inline]
 net_rx_action+0x47c/0x1010 net/core/dev.c:6947
 handle_softirqs+0x213/0x8f0 kernel/softirq.c:554
 __do_softirq kernel/softirq.c:588 [inline]
 invoke_softirq kernel/softirq.c:428 [inline]
 __irq_exit_rcu kernel/softirq.c:637 [inline]
 irq_exit_rcu+0xbb/0x120 kernel/softirq.c:649
 common_interrupt+0xbf/0xe0 arch/x86/kernel/irq.c:278
 asm_common_interrupt+0x26/0x40 arch/x86/include/asm/idtentry.h:693
Modules linked in:
CPU: 3 UID: 0 PID: 5947 Comm: syz-executor153 Tainted: G    B              6.12.0-rc5-syzkaller-00005-ge42b1a9a2557 #0
Tainted: [B]=BAD_PAGE
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x16c/0x1f0 lib/dump_stack.c:120
 bad_page+0xb3/0x1f0 mm/page_alloc.c:501
 free_page_is_bad_report mm/page_alloc.c:908 [inline]
 free_page_is_bad mm/page_alloc.c:918 [inline]
 free_pages_prepare mm/page_alloc.c:1100 [inline]
 free_unref_page+0x657/0xdc0 mm/page_alloc.c:2638
 skb_free_frag include/linux/skbuff.h:3399 [inline]
 skb_free_head+0xa0/0x1d0 net/core/skbuff.c:1096
 skb_release_data+0x560/0x730 net/core/skbuff.c:1125
 skb_release_all net/core/skbuff.c:1190 [inline]
 __kfree_skb net/core/skbuff.c:1204 [inline]
 sk_skb_reason_drop+0x129/0x1a0 net/core/skbuff.c:1242
 kfree_skb_reason include/linux/skbuff.h:1262 [inline]
 __netif_receive_skb_core.constprop.0+0x592/0x4330 net/core/dev.c:5640
 __netif_receive_skb_list_core+0x357/0x950 net/core/dev.c:5741
 __netif_receive_skb_list net/core/dev.c:5808 [inline]
 netif_receive_skb_list_internal+0x753/0xdb0 net/core/dev.c:5899
 netif_receive_skb_list+0x4f/0x4a0 net/core/dev.c:5951
 xdp_recv_frames net/bpf/test_run.c:279 [inline]
 xdp_test_run_batch.constprop.0+0x138d/0x1960 net/bpf/test_run.c:360
 bpf_test_run_xdp_

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


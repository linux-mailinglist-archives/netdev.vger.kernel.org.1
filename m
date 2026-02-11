Return-Path: <netdev+bounces-258232-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id COWiFQpNjGmukgAAu9opvQ
	(envelope-from <netdev+bounces-258232-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 10:34:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AED34122C4A
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 10:34:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 683543025917
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 09:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C7D8352FAB;
	Wed, 11 Feb 2026 09:33:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com [209.85.160.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E23226FDBF
	for <netdev@vger.kernel.org>; Wed, 11 Feb 2026 09:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770802405; cv=none; b=ijKqi9O9X8uVFDF4tp2yc7NjMgrQ7PJLm1hEiPgVoTExFlpWGpH9e8dpFLiWY5adu+hXtX/bkyXWFj/pFUskz15iG32uSwXnhclrjqH9GL1pf/MNdqVi6exVi72jOlSpen4MGtvnCJO4kZS8bVcGYS2aKYWkqnzNq+PXBAfwZ18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770802405; c=relaxed/simple;
	bh=CIV6hLoagvtbv1tUJpke1K0ryIwXsU0MKLJAINK0sNs=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=RMbgoAWyVxcaKdmPhUROkZmoQTJlYkde4YFhi63iOxxtTYqQqITQOpv59CkPN2PDkq4PnK+MVPLDXOH1nmZb1oU0hLGBBiapgc779FuP7WJGKeV2bp4Bg+asYEQYw6SOH6js9Xz3t8VBO2sBATQt4sZvK5Z3YtBecEJh0sKihJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.160.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-4094f9a49a1so7150257fac.1
        for <netdev@vger.kernel.org>; Wed, 11 Feb 2026 01:33:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770802403; x=1771407203;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E3g0WJXP05lXN0ERetws976C8zfGXTtafPxC90nebHU=;
        b=FRSCFioowZVlyIgPviGtVhy1Qh+8OzNBLaiDNG/3zPQKjWIx3569Mts1zQMxWwmAKy
         hYgpyNDE7a8LrdFZDDdyG6t2GdbICCdzpUBGE3q03ylKCW9zzAt3+NSWpUg9HzMgnJCz
         Wlb9i4d3lePX0AcSBJGCVphXiQmH46fcUSG+UILoq3bRv3gkUr9EfUhulD+JUxOxggVt
         CQyff1BFohYm6FYerCrMTw7XCsQ1s5HN8CXqfpU2h5JdPxBmZLKRB2uCBGvEQw+mgSa7
         6peDyG4EC1axCwTsp/xiXsMVWkJTNKGz5qTBQRxYfp3rXBFjOLR32U3AZAYvgF+gF3Be
         Pm9g==
X-Forwarded-Encrypted: i=1; AJvYcCU041CMTUpCQlwwgzZasK1HdoDi1wCRKlLZ7S/JwlJkiQHxpF+BBNOlsWbs9Yy9nN2OyH1SLnI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfSWqsb4Nxu4HeDemVemCen2VC9WgB/swkSfHE0uuUQPF18ons
	BGqt3tIF9kWKOFy4nLiP3LnBXL5S+133JWJWERhRsl2S7AynZ/CkxUFDB2z/Gn2Ua4GQsVRIkS4
	HnZgnuXqmsv7+8ygm8yUPADwfuo3anLq9c2/iNJZ0XkA1tE7fterwkC9ZNIA=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:408a:b0:672:7258:c4f0 with SMTP id
 006d021491bc7-6727258c72amr2827330eaf.53.1770802403077; Wed, 11 Feb 2026
 01:33:23 -0800 (PST)
Date: Wed, 11 Feb 2026 01:33:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <698c4ce3.050a0220.340abe.000b.GAE@google.com>
Subject: [syzbot] [bpf?] [net?] KASAN: stack-out-of-bounds Write in dev_map_redirect_multi
From: syzbot <syzbot+10cc7f13760b31bd2e61@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, eddyz87@gmail.com, 
	haoluo@google.com, hawk@kernel.org, john.fastabend@gmail.com, 
	jolsa@kernel.org, kpsingh@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, netdev@vger.kernel.org, 
	sdf@fomichev.me, song@kernel.org, syzkaller-bugs@googlegroups.com, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=2c36acc86fd56a9d];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258232-lists,netdev=lfdr.de,10cc7f13760b31bd2e61];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,vger.kernel.org,iogearbox.net,davemloft.net,gmail.com,google.com,linux.dev,fomichev.me,googlegroups.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_TWELVE(0.00)[19];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: AED34122C4A
X-Rspamd-Action: no action

Hello,

syzbot found the following issue on:

HEAD commit:    24cf78c73831 net/mlx5e: SHAMPO, Switch to header memcpy
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1092c65a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2c36acc86fd56a9d
dashboard link: https://syzkaller.appspot.com/bug?extid=10cc7f13760b31bd2e61
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/9514a76ff576/disk-24cf78c7.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/5f26244320f5/vmlinux-24cf78c7.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e0823b49ca48/bzImage-24cf78c7.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+10cc7f13760b31bd2e61@syzkaller.appspotmail.com

netlink: 'syz.1.9102': attribute type 1 has an invalid length.
==================================================================
BUG: KASAN: stack-out-of-bounds in get_upper_ifindexes kernel/bpf/devmap.c:601 [inline]
BUG: KASAN: stack-out-of-bounds in dev_map_redirect_multi+0x1bb/0xa00 kernel/bpf/devmap.c:736
Write of size 4 at addr ffffc9000b117164 by task syz.1.9102/9450

CPU: 1 UID: 0 PID: 9450 Comm: syz.1.9102 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/24/2026
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xba/0x230 mm/kasan/report.c:482
 kasan_report+0x117/0x150 mm/kasan/report.c:595
 get_upper_ifindexes kernel/bpf/devmap.c:601 [inline]
 dev_map_redirect_multi+0x1bb/0xa00 kernel/bpf/devmap.c:736
 xdp_do_generic_redirect_map net/core/filter.c:4556 [inline]
 xdp_do_generic_redirect+0x669/0x820 net/core/filter.c:4619
 do_xdp_generic+0xcf7/0x12e0 net/core/dev.c:5612
 __netif_receive_skb_core+0x10e5/0x3150 net/core/dev.c:5961
 __netif_receive_skb_one_core net/core/dev.c:6149 [inline]
 __netif_receive_skb net/core/dev.c:6264 [inline]
 netif_receive_skb_internal net/core/dev.c:6350 [inline]
 netif_receive_skb+0x1fe/0xbb0 net/core/dev.c:6409
 tun_rx_batched+0x1de/0x790 drivers/net/tun.c:1485
 tun_get_user+0x2a78/0x3dd0 drivers/net/tun.c:1953
 tun_chr_write_iter+0x113/0x200 drivers/net/tun.c:1999
 new_sync_write fs/read_write.c:593 [inline]
 vfs_write+0x61d/0xb90 fs/read_write.c:686
 ksys_write+0x150/0x270 fs/read_write.c:738
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xe2/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f937215b78e
Code: 08 0f 85 a5 a8 ff ff 49 89 fb 48 89 f0 48 89 d7 48 89 ce 4c 89 c2 4d 89 ca 4c 8b 44 24 08 4c 8b 4c 24 10 4c 89 5c 24 08 0f 05 <c3> 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 80 00 00 00 00 48 83 ec 08
RSP: 002b:00007f9372ffafb8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f9372ffb6c0 RCX: 00007f937215b78e
RDX: 0000000000000086 RSI: 0000200000000780 RDI: 00000000000000c8
RBP: 00007f9372208c1f R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f9372416038 R14: 00007f9372415fa0 R15: 00007fffe06ef058
 </TASK>

The buggy address belongs to stack of task syz.1.9102/9450
 and is located at offset 100 in frame:
 dev_map_redirect_multi+0x0/0xa00 include/linux/skbuff.h:2833

This frame has 2 objects:
 [32, 40) 'iter.i'
 [64, 100) 'excluded_devices'

The buggy address belongs to a 8-page vmalloc region starting at 0xffffc9000b110000 allocated at copy_process+0x508/0x3980 kernel/fork.c:2052
The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x94807
memcg:ffff88814237e782
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000000 0000000000000000 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000000000 00000001ffffffff ffff88814237e782
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x29c2(GFP_NOWAIT|__GFP_HIGHMEM|__GFP_IO|__GFP_FS|__GFP_ZERO), pid 2, tgid 2 (kthreadd), ts 1433078116205, free_ts 1432956594052
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x228/0x280 mm/page_alloc.c:1884
 prep_new_page mm/page_alloc.c:1892 [inline]
 get_page_from_freelist+0x24dc/0x2580 mm/page_alloc.c:3945
 __alloc_frozen_pages_noprof+0x18d/0x380 mm/page_alloc.c:5240
 alloc_pages_mpol+0x232/0x4a0 mm/mempolicy.c:2486
 alloc_frozen_pages_noprof mm/mempolicy.c:2557 [inline]
 alloc_pages_noprof+0xa8/0x190 mm/mempolicy.c:2577
 vm_area_alloc_pages mm/vmalloc.c:3649 [inline]
 __vmalloc_area_node mm/vmalloc.c:3863 [inline]
 __vmalloc_node_range_noprof+0x79b/0x1730 mm/vmalloc.c:4051
 __vmalloc_node_noprof+0xc2/0x100 mm/vmalloc.c:4111
 alloc_thread_stack_node kernel/fork.c:354 [inline]
 dup_task_struct+0x228/0x9a0 kernel/fork.c:923
 copy_process+0x508/0x3980 kernel/fork.c:2052
 kernel_clone+0x248/0x870 kernel/fork.c:2651
 kernel_thread+0x13f/0x1b0 kernel/fork.c:2712
 create_kthread kernel/kthread.c:486 [inline]
 kthreadd+0x4f9/0x6f0 kernel/kthread.c:844
 ret_from_fork+0x51b/0xa40 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246
page last free pid 8089 tgid 8089 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1433 [inline]
 __free_frozen_pages+0xbf8/0xd70 mm/page_alloc.c:2973
 __folio_put+0x414/0x4f0 mm/swap.c:112
 put_netmem include/net/netmem.h:420 [inline]
 skb_page_unref include/linux/skbuff_ref.h:43 [inline]
 __skb_frag_unref include/linux/skbuff_ref.h:56 [inline]
 skb_release_data+0x4cb/0x940 net/core/skbuff.c:1122
 skb_release_all net/core/skbuff.c:1203 [inline]
 __kfree_skb+0x5d/0x210 net/core/skbuff.c:1217
 kfree_skb_reason include/linux/skbuff.h:1322 [inline]
 __skb_queue_purge_reason include/linux/skbuff.h:3426 [inline]
 __skb_queue_purge include/linux/skbuff.h:3431 [inline]
 virtio_transport_remove_sock net/vmw_vsock/virtio_transport_common.c:1224 [inline]
 virtio_transport_cancel_close_work net/vmw_vsock/virtio_transport_common.c:1237 [inline]
 virtio_transport_do_close+0x251/0x3c0 net/vmw_vsock/virtio_transport_common.c:1255
 virtio_transport_recv_connected+0x3c4/0xf10 net/vmw_vsock/virtio_transport_common.c:1464
 virtio_transport_recv_pkt+0x17a4/0x2b70 net/vmw_vsock/virtio_transport_common.c:1693
 vsock_loopback_work+0x32c/0x3f0 net/vmw_vsock/vsock_loopback.c:142
 process_one_work kernel/workqueue.c:3257 [inline]
 process_scheduled_works+0xaec/0x17a0 kernel/workqueue.c:3340
 worker_thread+0xda6/0x1360 kernel/workqueue.c:3421
 kthread+0x726/0x8b0 kernel/kthread.c:463
 ret_from_fork+0x51b/0xa40 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246

Memory state around the buggy address:
 ffffc9000b117000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffffc9000b117080: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffffc9000b117100: f1 f1 f1 f1 00 f2 f2 f2 00 00 00 00 04 f3 f3 f3
                                                       ^
 ffffc9000b117180: f3 f3 f3 f3 00 00 00 00 00 00 00 00 00 00 00 00
 ffffc9000b117200: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
==================================================================


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


Return-Path: <netdev+bounces-147190-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AAAB9D822E
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 10:26:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B048281F5D
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 09:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21AB9190067;
	Mon, 25 Nov 2024 09:26:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651E418FDDB
	for <netdev@vger.kernel.org>; Mon, 25 Nov 2024 09:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732526784; cv=none; b=BM0FrGLkBEyPzAbrZEduIz7QcliabtgQpiKGKn5arTVMLN5UE71dGOle95DDT9kfk8OBFZrJODh343P/KrOEukRmwMWS5/geiGkeC4oJiRPW5Rv+hmrErzr3WoJe6bpswqmOydPi6oLc3WOkI6QtkMh07dmPZLkw4h+lMgZFhKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732526784; c=relaxed/simple;
	bh=XNW34UpU13gVVNbFmf061mg++Yk7ABJIzNBaXgYVt6M=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=aTfEk6XjZSLvNAQe/naFhJSYfNnDniv+1G6UVOpqaTvjIQdNu6Rlc/msZA8jsVvXU5nGjdBO72Lz42s1I1vA8e83J1c3+S14NUbs53eTgLq/XnT2g1WG4th4VyWP+mKPYKVWEE4N7mzqCNYgL1VBUcuW24t9tpC7dvh8u8gw/78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-83b6628a71fso481208439f.0
        for <netdev@vger.kernel.org>; Mon, 25 Nov 2024 01:26:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732526781; x=1733131581;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LQflLreVvCgugKZlVu1EymoM+14gkW98mARLQ49Tm/k=;
        b=hQmBIdmg/Dy6f8m8IVJidEOSsmgTpAEnzPmf7wqFSerNVjaylEJg59qQVt8FMwKc5Q
         fNn+adz7doVxbMqUzHQFtaHvqvcmeSyeB+ZYcWXnvYt3PYrZW51o8N0kU1ipONM/vce/
         691yTTRcTJnCsHohFh8wJ31KEwxpwVW+54he5taCGr0EnQg+ycU8IqYENH3+Jv77+dP2
         SH/tQCdnevlsZt7ZhWwZB0+iZu16I/tysjc8LEFyi6UUP0XQmJlx1h5Lgk0JN365NtQ9
         Q+uPkvuJMvBgluLJbcELYGINBWHA/kp2af4RNRmJ+Fdkyo/GjH1zAfS6X9LM5W282wSI
         nbzQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWmkvq61SYeRI7cY+THhTMvgZ86moGZuaS10yidS7+oPG2vOck9iC8a1T8wISu0qcBJbIOJ/0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy5MD3dVxwQV+pz7S+tF+H/ft1Rqyzfl0gb1+nVXg+hxrxkL6T
	W9oRu6Df8AL17cGUEwd3Zhdb3CQJHyO4BGQL8jc98ohIGsLxAm2iRsKbYHvGMixpwkthtZG9y2d
	kkdHPiRUciY5PCXfzIup9xRkiiE0oIe2GT+S9Id7JR9LL26XMKwX2OPs=
X-Google-Smtp-Source: AGHT+IH9zcivHAX3qZUiW412AQK/jl3EtcJ75UJEkfggGschj5iWOF6ve5N05aLdpSdBc++1yxKqYaoacbQ/JNT6Q67G0HeirOQ1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:160a:b0:3a7:8720:9ea4 with SMTP id
 e9e14a558f8ab-3a79aceae85mr100669995ab.5.1732526781617; Mon, 25 Nov 2024
 01:26:21 -0800 (PST)
Date: Mon, 25 Nov 2024 01:26:21 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <674442bd.050a0220.1cc393.0072.GAE@google.com>
Subject: [syzbot] [net?] KMSAN: uninit-value in netdev_pick_tx
From: syzbot <syzbot+8b0959fc16551d55896b@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    9f16d5e6f220 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=151ec778580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=197de11c5dba9f21
dashboard link: https://syzkaller.appspot.com/bug?extid=8b0959fc16551d55896b
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d544df92b8b9/disk-9f16d5e6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/cfb277b7148a/vmlinux-9f16d5e6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b9aeb9fe1f9d/bzImage-9f16d5e6.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8b0959fc16551d55896b@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in netdev_pick_tx+0x5c7/0x1550
 netdev_pick_tx+0x5c7/0x1550
 netdev_core_pick_tx+0x1d2/0x4a0 net/core/dev.c:4312
 __dev_queue_xmit+0x128a/0x57d0 net/core/dev.c:4394
 dev_queue_xmit include/linux/netdevice.h:3168 [inline]
 neigh_hh_output include/net/neighbour.h:523 [inline]
 neigh_output include/net/neighbour.h:537 [inline]
 ip_finish_output2+0x187c/0x1b70 net/ipv4/ip_output.c:236
 __ip_finish_output+0x287/0x810
 ip_finish_output+0x4b/0x600 net/ipv4/ip_output.c:324
 NF_HOOK_COND include/linux/netfilter.h:303 [inline]
 ip_output+0x15f/0x3f0 net/ipv4/ip_output.c:434
 dst_output include/net/dst.h:450 [inline]
 ip_local_out net/ipv4/ip_output.c:130 [inline]
 ip_send_skb net/ipv4/ip_output.c:1505 [inline]
 ip_push_pending_frames+0x444/0x570 net/ipv4/ip_output.c:1525
 ip_send_unicast_reply+0x18c1/0x1b30 net/ipv4/ip_output.c:1672
 tcp_v4_send_reset+0x238d/0x2a40 net/ipv4/tcp_ipv4.c:910
 tcp_v4_rcv+0x48f8/0x5750 net/ipv4/tcp_ipv4.c:2431
 ip_protocol_deliver_rcu+0x2a3/0x13d0 net/ipv4/ip_input.c:205
 ip_local_deliver_finish+0x336/0x500 net/ipv4/ip_input.c:233
 NF_HOOK include/linux/netfilter.h:314 [inline]
 ip_local_deliver+0x21f/0x490 net/ipv4/ip_input.c:254
 dst_input include/net/dst.h:460 [inline]
 ip_sublist_rcv_finish net/ipv4/ip_input.c:578 [inline]
 ip_list_rcv_finish net/ipv4/ip_input.c:628 [inline]
 ip_sublist_rcv+0x15f3/0x17f0 net/ipv4/ip_input.c:636
 ip_list_rcv+0x9ef/0xa40 net/ipv4/ip_input.c:670
 __netif_receive_skb_list_ptype net/core/dev.c:5715 [inline]
 __netif_receive_skb_list_core+0x15c5/0x1670 net/core/dev.c:5762
 __netif_receive_skb_list net/core/dev.c:5814 [inline]
 netif_receive_skb_list_internal+0x1085/0x1700 net/core/dev.c:5905
 gro_normal_list include/net/gro.h:515 [inline]
 napi_complete_done+0x3d4/0x810 net/core/dev.c:6256
 virtqueue_napi_complete drivers/net/virtio_net.c:758 [inline]
 virtnet_poll+0x5d80/0x6bf0 drivers/net/virtio_net.c:3013
 __napi_poll+0xe7/0x980 net/core/dev.c:6877
 napi_poll net/core/dev.c:6946 [inline]
 net_rx_action+0xa5a/0x19b0 net/core/dev.c:7068
 handle_softirqs+0x1a0/0x7c0 kernel/softirq.c:554
 run_ksoftirqd+0x29/0x50 kernel/softirq.c:943
 smpboot_thread_fn+0x555/0xa60 kernel/smpboot.c:164
 kthread+0x3e2/0x540 kernel/kthread.c:389
 ret_from_fork+0x6d/0x90 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Uninit was created at:
 __alloc_pages_noprof+0x9a7/0xe00 mm/page_alloc.c:4774
 alloc_pages_mpol_noprof+0x299/0x990 mm/mempolicy.c:2265
 alloc_pages_noprof+0x1bf/0x1e0 mm/mempolicy.c:2344
 alloc_slab_page mm/slub.c:2412 [inline]
 allocate_slab+0x320/0x12e0 mm/slub.c:2578
 new_slab mm/slub.c:2631 [inline]
 ___slab_alloc+0x12ef/0x35e0 mm/slub.c:3818
 __slab_alloc mm/slub.c:3908 [inline]
 __slab_alloc_node mm/slub.c:3961 [inline]
 slab_alloc_node mm/slub.c:4122 [inline]
 kmem_cache_alloc_noprof+0x57a/0xb20 mm/slub.c:4141
 inet_twsk_alloc+0x11f/0x9d0 net/ipv4/inet_timewait_sock.c:188
 tcp_time_wait+0x83/0xf50 net/ipv4/tcp_minisocks.c:309
 tcp_rcv_state_process+0x145a/0x49d0
 tcp_v4_do_rcv+0xbf9/0x11a0 net/ipv4/tcp_ipv4.c:1939
 sk_backlog_rcv+0x10c/0x420 include/net/sock.h:1121
 __release_sock+0x1da/0x330 net/core/sock.c:3083
 release_sock+0x6b/0x250 net/core/sock.c:3637
 mptcp_subflow_shutdown+0x25f/0x8f0 net/mptcp/protocol.c:2944
 mptcp_check_send_data_fin+0x35f/0x410 net/mptcp/protocol.c:3018
 __mptcp_wr_shutdown net/mptcp/protocol.c:3034 [inline]
 mptcp_shutdown+0x443/0x550 net/mptcp/protocol.c:3675
 inet_shutdown+0x33f/0x5b0 net/ipv4/af_inet.c:923
 __sys_shutdown_sock net/socket.c:2423 [inline]
 __sys_shutdown net/socket.c:2439 [inline]
 __do_sys_shutdown net/socket.c:2444 [inline]
 __se_sys_shutdown net/socket.c:2442 [inline]
 __x64_sys_shutdown+0x2e9/0x410 net/socket.c:2442
 x64_sys_call+0x39aa/0x3c30 arch/x86/include/generated/asm/syscalls_64.h:49
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

CPU: 1 UID: 0 PID: 24 Comm: ksoftirqd/1 Not tainted 6.12.0-syzkaller-09073-g9f16d5e6f220 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
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


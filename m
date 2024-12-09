Return-Path: <netdev+bounces-150229-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C93A9E9883
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 15:13:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F8EF161285
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 14:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91FD015575F;
	Mon,  9 Dec 2024 14:13:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC379233123
	for <netdev@vger.kernel.org>; Mon,  9 Dec 2024 14:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733753613; cv=none; b=Fp/xt+aKuoYb6i8Lvp7rLvuTbIx32JCB8+EL83PPLYXHWJfzyEbwr/XqKtvqAi1RDIqkKYRllDxurZqqcFFhFtnHNeYTAV/lmrfGX/dAp5Zod3JxybkyS/rW2V9RxxnIHXMwgbNYmNeT+5zdte+y9ozg1AdLVmPF0epFeZExWGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733753613; c=relaxed/simple;
	bh=Q8KiKPDWnVRiV1tEn59eCgxEIrKUIIFVeyIXW5SbMRE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=rdK2NOan3r8cg+l1695LW9yojBGKldCDOyR+4F/CdRad754dJwtf2dc36uvn00Ne7p9zP5ihXy04eYg91cAspu1oXfN+vGgV0YtsRwL7aiuMgFo/mZfXa1Wcf51xhTVexwCQS56ZUkI9LWz34dvh26YJSixjTKw6ipePGIIa4pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3a9d4ea9e0cso8689295ab.0
        for <netdev@vger.kernel.org>; Mon, 09 Dec 2024 06:13:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733753611; x=1734358411;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FqfQZejnwPPNeLJYql7GxK8sxbbgU5PPpgplPteIweg=;
        b=eYaBYDrVNjpqZeXyWys8NdEQRSJu72HtaW5ofKsYyBI+AZ6zHnM487l4nmbs0a9iWb
         JO6j/sZEqrLYI9ksHx7b/5hK648yVpNhNwxc0MNR4ga37MjCQUYR98VCSXdB5+poiYjI
         rkV724D5LLq4VCbhN3OypqpUYLa37ROBMN/I5dsPwyIstyqsXHIZv38UY/t2Vr/POrSw
         EsPLxy39WkGb2dEpk43WIDVzHWnYUrVaQpo2nN1tANc1x0ESdbpJzS3iisE5ZgJOa6wv
         mbR7rS+fADs8i5gJeg1cWmUqbVp3Kof8Cr3rlEC5nKr8qP/3mqnAUEnxKwRSJY009Leq
         hOKw==
X-Forwarded-Encrypted: i=1; AJvYcCXwwTuhcPlpbjoStPQ9eqWEhmBSdqKWnKEexdSaUIxCpZBx5jMDwH/1KaFwnEzt+I7s2mqzzuA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyEvJWFVXqGLpSGbPRoE65UD7GMxluDS3gjAksMsD/b5co6zT7
	jfghKPEF3KnaONgo7CHzMDvUJ4cXin0mHEOt0WmtOqTTE37kDMxZBL3g0IR21tVpY2HIedX03Wm
	e4wd2vWDBhGqRZXJHQWdULHkAox4PUrfRchKUC0Cy4PYs7muUzRpRdlI=
X-Google-Smtp-Source: AGHT+IFdNbMJQCVFUtyBaPjdwWrxvV0x6N42D/JloyMkNd7GDjfUeDBz8lhCOmHtcJkfOKLmc6Y/JdjZeunT7YfAWd5VDMOCnd1f
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a66:b0:3a7:81c6:be7e with SMTP id
 e9e14a558f8ab-3a811d9d2f1mr106248295ab.13.1733753610952; Mon, 09 Dec 2024
 06:13:30 -0800 (PST)
Date: Mon, 09 Dec 2024 06:13:30 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6756fb0a.050a0220.a30f1.01a1.GAE@google.com>
Subject: [syzbot] [net?] KMSAN: uninit-value in tcp_do_parse_auth_options
From: syzbot <syzbot+6f1c2734e2f851b382fc@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    9f16d5e6f220 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11846778580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ce1e2eda2213557
dashboard link: https://syzkaller.appspot.com/bug?extid=6f1c2734e2f851b382fc
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/aa65b8056e0a/disk-9f16d5e6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/63247b6a0fd4/vmlinux-9f16d5e6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/2682d9fa97c6/bzImage-9f16d5e6.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6f1c2734e2f851b382fc@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in tcp_do_parse_auth_options+0x4b8/0x640 net/ipv4/tcp_input.c:4381
 tcp_do_parse_auth_options+0x4b8/0x640 net/ipv4/tcp_input.c:4381
 tcp_parse_auth_options include/net/tcp.h:2774 [inline]
 tcp_inbound_hash+0x122/0x9c0 net/ipv4/tcp.c:4793
 tcp_v4_rcv+0x388b/0x5750 net/ipv4/tcp_ipv4.c:2323
 ip_protocol_deliver_rcu+0x2a3/0x13d0 net/ipv4/ip_input.c:205
 ip_local_deliver_finish+0x336/0x500 net/ipv4/ip_input.c:233
 NF_HOOK include/linux/netfilter.h:314 [inline]
 ip_local_deliver+0x21f/0x490 net/ipv4/ip_input.c:254
 dst_input include/net/dst.h:460 [inline]
 ip_rcv_finish+0x4a2/0x520 net/ipv4/ip_input.c:447
 NF_HOOK include/linux/netfilter.h:314 [inline]
 ip_rcv+0xcd/0x380 net/ipv4/ip_input.c:567
 __netif_receive_skb_one_core net/core/dev.c:5672 [inline]
 __netif_receive_skb+0x319/0xa00 net/core/dev.c:5785
 process_backlog+0x4ad/0xa50 net/core/dev.c:6117
 __napi_poll+0xe7/0x980 net/core/dev.c:6877
 napi_poll net/core/dev.c:6946 [inline]
 net_rx_action+0xa5a/0x19b0 net/core/dev.c:7068
 handle_softirqs+0x1a0/0x7c0 kernel/softirq.c:554
 __do_softirq+0x14/0x1a kernel/softirq.c:588
 do_softirq+0x9a/0x100 kernel/softirq.c:455
 __local_bh_enable_ip+0x9f/0xb0 kernel/softirq.c:382
 local_bh_enable include/linux/bottom_half.h:33 [inline]
 rcu_read_unlock_bh include/linux/rcupdate.h:919 [inline]
 __dev_queue_xmit+0x2758/0x57d0 net/core/dev.c:4461
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
 __ip_queue_xmit+0x1f2a/0x20d0 net/ipv4/ip_output.c:536
 ip_queue_xmit+0x60/0x80 net/ipv4/ip_output.c:550
 __tcp_transmit_skb+0x3cea/0x4900 net/ipv4/tcp_output.c:1466
 tcp_transmit_skb net/ipv4/tcp_output.c:1484 [inline]
 tcp_write_xmit+0x3b90/0x9070 net/ipv4/tcp_output.c:2827
 __tcp_push_pending_frames+0xc4/0x380 net/ipv4/tcp_output.c:3010
 tcp_send_fin+0x9f6/0xf50 net/ipv4/tcp_output.c:3616
 __tcp_close+0x140c/0x1550 net/ipv4/tcp.c:3130
 __mptcp_close_ssk+0x74e/0x16f0 net/mptcp/protocol.c:2495
 mptcp_close_ssk+0x26b/0x2c0 net/mptcp/protocol.c:2549
 mptcp_pm_nl_rm_addr_or_subflow+0x635/0xd10 net/mptcp/pm_netlink.c:889
 mptcp_pm_nl_rm_subflow_received net/mptcp/pm_netlink.c:924 [inline]
 mptcp_pm_flush_addrs_and_subflows net/mptcp/pm_netlink.c:1688 [inline]
 mptcp_nl_flush_addrs_list net/mptcp/pm_netlink.c:1709 [inline]
 mptcp_pm_nl_flush_addrs_doit+0xe10/0x1630 net/mptcp/pm_netlink.c:1750
 genl_family_rcv_msg_doit net/netlink/genetlink.c:1115 [inline]
 genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
 genl_rcv_msg+0x1214/0x12c0 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x375/0x650 net/netlink/af_netlink.c:2541
 genl_rcv+0x40/0x60 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1321 [inline]
 netlink_unicast+0xf52/0x1260 net/netlink/af_netlink.c:1347
 netlink_sendmsg+0x10da/0x11e0 net/netlink/af_netlink.c:1891
 sock_sendmsg_nosec net/socket.c:711 [inline]
 __sock_sendmsg+0x30f/0x380 net/socket.c:726
 ____sys_sendmsg+0x877/0xb60 net/socket.c:2583
 ___sys_sendmsg+0x28d/0x3c0 net/socket.c:2637
 __sys_sendmsg+0x1b6/0x300 net/socket.c:2669
 __compat_sys_sendmsg net/compat.c:346 [inline]
 __do_compat_sys_sendmsg net/compat.c:353 [inline]
 __se_compat_sys_sendmsg net/compat.c:350 [inline]
 __ia32_compat_sys_sendmsg+0x9d/0xe0 net/compat.c:350
 ia32_sys_call+0x2685/0x4180 arch/x86/include/generated/asm/syscalls_32.h:371
 do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
 __do_fast_syscall_32+0xb0/0x110 arch/x86/entry/common.c:386
 do_fast_syscall_32+0x38/0x80 arch/x86/entry/common.c:411
 do_SYSENTER_32+0x1f/0x30 arch/x86/entry/common.c:449
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e

Uninit was created at:
 slab_post_alloc_hook mm/slub.c:4091 [inline]
 slab_alloc_node mm/slub.c:4134 [inline]
 kmem_cache_alloc_node_noprof+0x6bf/0xb80 mm/slub.c:4186
 kmalloc_reserve+0x13d/0x4a0 net/core/skbuff.c:587
 __alloc_skb+0x363/0x7b0 net/core/skbuff.c:678
 alloc_skb_fclone include/linux/skbuff.h:1373 [inline]
 tcp_send_fin+0x3b9/0xf50 net/ipv4/tcp_output.c:3602
 __tcp_close+0x140c/0x1550 net/ipv4/tcp.c:3130
 __mptcp_close_ssk+0x74e/0x16f0 net/mptcp/protocol.c:2495
 mptcp_close_ssk+0x26b/0x2c0 net/mptcp/protocol.c:2549
 mptcp_pm_nl_rm_addr_or_subflow+0x635/0xd10 net/mptcp/pm_netlink.c:889
 mptcp_pm_nl_rm_subflow_received net/mptcp/pm_netlink.c:924 [inline]
 mptcp_pm_flush_addrs_and_subflows net/mptcp/pm_netlink.c:1688 [inline]
 mptcp_nl_flush_addrs_list net/mptcp/pm_netlink.c:1709 [inline]
 mptcp_pm_nl_flush_addrs_doit+0xe10/0x1630 net/mptcp/pm_netlink.c:1750
 genl_family_rcv_msg_doit net/netlink/genetlink.c:1115 [inline]
 genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
 genl_rcv_msg+0x1214/0x12c0 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x375/0x650 net/netlink/af_netlink.c:2541
 genl_rcv+0x40/0x60 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1321 [inline]
 netlink_unicast+0xf52/0x1260 net/netlink/af_netlink.c:1347
 netlink_sendmsg+0x10da/0x11e0 net/netlink/af_netlink.c:1891
 sock_sendmsg_nosec net/socket.c:711 [inline]
 __sock_sendmsg+0x30f/0x380 net/socket.c:726
 ____sys_sendmsg+0x877/0xb60 net/socket.c:2583
 ___sys_sendmsg+0x28d/0x3c0 net/socket.c:2637
 __sys_sendmsg+0x1b6/0x300 net/socket.c:2669
 __compat_sys_sendmsg net/compat.c:346 [inline]
 __do_compat_sys_sendmsg net/compat.c:353 [inline]
 __se_compat_sys_sendmsg net/compat.c:350 [inline]
 __ia32_compat_sys_sendmsg+0x9d/0xe0 net/compat.c:350
 ia32_sys_call+0x2685/0x4180 arch/x86/include/generated/asm/syscalls_32.h:371
 do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
 __do_fast_syscall_32+0xb0/0x110 arch/x86/entry/common.c:386
 do_fast_syscall_32+0x38/0x80 arch/x86/entry/common.c:411
 do_SYSENTER_32+0x1f/0x30 arch/x86/entry/common.c:449
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e

CPU: 0 UID: 0 PID: 6093 Comm: syz.3.23 Not tainted 6.12.0-syzkaller-09073-g9f16d5e6f220 #0
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


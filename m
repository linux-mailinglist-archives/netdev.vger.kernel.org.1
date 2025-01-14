Return-Path: <netdev+bounces-158203-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D0B9FA11005
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 19:26:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF3B6188B61B
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 18:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 683231FBE9A;
	Tue, 14 Jan 2025 18:26:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58275232458
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 18:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736879188; cv=none; b=EttI9Ns07mCDs1oteW8PIYbE0lEygXq4S26rJbEviaB8SVmSKLRI/FBbRxn4IwN53XUQQxgg8k91X81TrQ5mIYkZZvYpNovV4d/OPhX5yH9gH/LoFa/0izNc/wgSwsP9wbpIaGxHk4/vE7nnTiMH0sPBR45ffkW1JEFgSo8iIrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736879188; c=relaxed/simple;
	bh=8P6BI/6sBHQUdpG7fhCrmYdmBt6P8klWaXgb82/3eOg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=TqI3DoKWJniFfc8yiSgcl6cupe0OICqYnur1ECDUTTrJq7yap2JDq+tdqAq7ggt+BgBUaeVXxvdqo1HXm92U0WJFMVcIszSmbEca/0BVjgQTztq3O7GdWX/5adtG1Xq5tqcAOX+pKcxSUfN9T5xM/erkmmAIRFfkrRm+EV1Jw6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3a814bfb77bso712455ab.0
        for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 10:26:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736879185; x=1737483985;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1D8aK1A7Z418bn3I21gw6DavuVLyHCqgXcJgH3V9Joo=;
        b=JlU4lvQEYfRLEapIXpqPQQQlDIx4verD/WERvCoplTWMeCO5pVAe2gYdqkc0DxDY6g
         sqqsda7GMUnQvs1TD+/zsbZuB9eHfNHj9u1TM2UyfKbU9BkgC7JP1ZkqJEoDKQ4G8oqZ
         P/AxCloIYIrjbmLWiiG4pMcTnN458m1iYo5Waqn3FFn4HxY9CDpvgIjypwDHQZh6d/uD
         FF1H7sBlPNPW813vXAsAI+20KLWZR12+Rg65TB4iH8Yq7anIa9F9nqYssOhOFFJkIZoQ
         DveSnR8N2mh+bJfBZMbRXY2o45ud8EIuIlGq4OyZLsvS/ochZxDq9w402PrHhmVVUGa7
         2ViA==
X-Forwarded-Encrypted: i=1; AJvYcCUaEukkqwVkhW5aDnr7mCQNcw9Qqnh9KqB+KFZ+TtMCJ/75n7o0mtbK67v7Fnuth8dOnZKn2Vg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpEG97ghQ8RpyT5mmjKZEdWPYdkrvL+AAyzoIeVfFmJH1PGq8g
	tPSGPZ3r4vqWNfrXEj8DT/DnURxCQ8xNuRoXaIHscz1o03iJcVZSsMfB3ainRVrCoFSa9TMUjh8
	LXR9i886jpTHpQvdzqROoAGMZ/2GHTdMsfk9YULY8Go9xZgq6Vu5UxOM=
X-Google-Smtp-Source: AGHT+IFA5G87C2kPQegv1gwxKpvd6orcbgVIUYx/84q34oFDg+sY4ud4zjpC1tPg0NYzH9SdHJQ8fSbP5/+4f3FKHq2SXxVl84HJ
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1547:b0:3ce:793e:2766 with SMTP id
 e9e14a558f8ab-3ce793e284cmr41606245ab.8.1736879185436; Tue, 14 Jan 2025
 10:26:25 -0800 (PST)
Date: Tue, 14 Jan 2025 10:26:25 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6786ac51.050a0220.216c54.00a7.GAE@google.com>
Subject: [syzbot] [mptcp?] KMSAN: uninit-value in mptcp_incoming_options (2)
From: syzbot <syzbot+23728c2df58b3bd175ad@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, geliang@kernel.org, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	martineau@kernel.org, matttbe@kernel.org, mptcp@lists.linux.dev, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    5bc55a333a2f Linux 6.13-rc7
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16f67ef8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b9c31a1485dceb8e
dashboard link: https://syzkaller.appspot.com/bug?extid=23728c2df58b3bd175ad
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/37805bb86a68/disk-5bc55a33.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ad56bb400987/vmlinux-5bc55a33.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f5be0f4a3084/bzImage-5bc55a33.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+23728c2df58b3bd175ad@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in __mptcp_expand_seq net/mptcp/options.c:1030 [inline]
BUG: KMSAN: uninit-value in mptcp_expand_seq net/mptcp/protocol.h:864 [inline]
BUG: KMSAN: uninit-value in ack_update_msk net/mptcp/options.c:1060 [inline]
BUG: KMSAN: uninit-value in mptcp_incoming_options+0x2036/0x3d30 net/mptcp/options.c:1209
 __mptcp_expand_seq net/mptcp/options.c:1030 [inline]
 mptcp_expand_seq net/mptcp/protocol.h:864 [inline]
 ack_update_msk net/mptcp/options.c:1060 [inline]
 mptcp_incoming_options+0x2036/0x3d30 net/mptcp/options.c:1209
 tcp_data_queue+0xb4/0x7be0 net/ipv4/tcp_input.c:5233
 tcp_rcv_established+0x1061/0x2510 net/ipv4/tcp_input.c:6264
 tcp_v4_do_rcv+0x7f3/0x11a0 net/ipv4/tcp_ipv4.c:1916
 tcp_v4_rcv+0x51df/0x5750 net/ipv4/tcp_ipv4.c:2351
 ip_protocol_deliver_rcu+0x2a3/0x13d0 net/ipv4/ip_input.c:205
 ip_local_deliver_finish+0x336/0x500 net/ipv4/ip_input.c:233
 NF_HOOK include/linux/netfilter.h:314 [inline]
 ip_local_deliver+0x21f/0x490 net/ipv4/ip_input.c:254
 dst_input include/net/dst.h:460 [inline]
 ip_rcv_finish+0x4a2/0x520 net/ipv4/ip_input.c:447
 NF_HOOK include/linux/netfilter.h:314 [inline]
 ip_rcv+0xcd/0x380 net/ipv4/ip_input.c:567
 __netif_receive_skb_one_core net/core/dev.c:5704 [inline]
 __netif_receive_skb+0x319/0xa00 net/core/dev.c:5817
 process_backlog+0x4ad/0xa50 net/core/dev.c:6149
 __napi_poll+0xe7/0x980 net/core/dev.c:6902
 napi_poll net/core/dev.c:6971 [inline]
 net_rx_action+0xa5a/0x19b0 net/core/dev.c:7093
 handle_softirqs+0x1a0/0x7c0 kernel/softirq.c:561
 __do_softirq+0x14/0x1a kernel/softirq.c:595
 do_softirq+0x9a/0x100 kernel/softirq.c:462
 __local_bh_enable_ip+0x9f/0xb0 kernel/softirq.c:389
 local_bh_enable include/linux/bottom_half.h:33 [inline]
 rcu_read_unlock_bh include/linux/rcupdate.h:919 [inline]
 __dev_queue_xmit+0x2758/0x57d0 net/core/dev.c:4493
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
 __tcp_transmit_skb+0x3cea/0x4900 net/ipv4/tcp_output.c:1468
 tcp_transmit_skb net/ipv4/tcp_output.c:1486 [inline]
 tcp_write_xmit+0x3b90/0x9070 net/ipv4/tcp_output.c:2829
 __tcp_push_pending_frames+0xc4/0x380 net/ipv4/tcp_output.c:3012
 tcp_send_fin+0x9f6/0xf50 net/ipv4/tcp_output.c:3618
 __tcp_close+0x140c/0x1550 net/ipv4/tcp.c:3130
 __mptcp_close_ssk+0x74e/0x16f0 net/mptcp/protocol.c:2496
 mptcp_close_ssk+0x26b/0x2c0 net/mptcp/protocol.c:2550
 mptcp_pm_nl_rm_addr_or_subflow+0x635/0xd10 net/mptcp/pm_netlink.c:889
 mptcp_pm_nl_rm_subflow_received net/mptcp/pm_netlink.c:924 [inline]
 mptcp_pm_flush_addrs_and_subflows net/mptcp/pm_netlink.c:1688 [inline]
 mptcp_nl_flush_addrs_list net/mptcp/pm_netlink.c:1709 [inline]
 mptcp_pm_nl_flush_addrs_doit+0xe10/0x1630 net/mptcp/pm_netlink.c:1750
 genl_family_rcv_msg_doit net/netlink/genetlink.c:1115 [inline]
 genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
 genl_rcv_msg+0x1214/0x12c0 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x375/0x650 net/netlink/af_netlink.c:2542
 genl_rcv+0x40/0x60 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1321 [inline]
 netlink_unicast+0xf52/0x1260 net/netlink/af_netlink.c:1347
 netlink_sendmsg+0x10da/0x11e0 net/netlink/af_netlink.c:1891
 sock_sendmsg_nosec net/socket.c:711 [inline]
 __sock_sendmsg+0x30f/0x380 net/socket.c:726
 ____sys_sendmsg+0x877/0xb60 net/socket.c:2583
 ___sys_sendmsg+0x28d/0x3c0 net/socket.c:2637
 __sys_sendmsg net/socket.c:2669 [inline]
 __do_sys_sendmsg net/socket.c:2674 [inline]
 __se_sys_sendmsg net/socket.c:2672 [inline]
 __x64_sys_sendmsg+0x212/0x3c0 net/socket.c:2672
 x64_sys_call+0x2ed6/0x3c30 arch/x86/include/generated/asm/syscalls_64.h:47
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was stored to memory at:
 mptcp_get_options+0x2c0f/0x2f20 net/mptcp/options.c:397
 mptcp_incoming_options+0x19a/0x3d30 net/mptcp/options.c:1150
 tcp_data_queue+0xb4/0x7be0 net/ipv4/tcp_input.c:5233
 tcp_rcv_established+0x1061/0x2510 net/ipv4/tcp_input.c:6264
 tcp_v4_do_rcv+0x7f3/0x11a0 net/ipv4/tcp_ipv4.c:1916
 tcp_v4_rcv+0x51df/0x5750 net/ipv4/tcp_ipv4.c:2351
 ip_protocol_deliver_rcu+0x2a3/0x13d0 net/ipv4/ip_input.c:205
 ip_local_deliver_finish+0x336/0x500 net/ipv4/ip_input.c:233
 NF_HOOK include/linux/netfilter.h:314 [inline]
 ip_local_deliver+0x21f/0x490 net/ipv4/ip_input.c:254
 dst_input include/net/dst.h:460 [inline]
 ip_rcv_finish+0x4a2/0x520 net/ipv4/ip_input.c:447
 NF_HOOK include/linux/netfilter.h:314 [inline]
 ip_rcv+0xcd/0x380 net/ipv4/ip_input.c:567
 __netif_receive_skb_one_core net/core/dev.c:5704 [inline]
 __netif_receive_skb+0x319/0xa00 net/core/dev.c:5817
 process_backlog+0x4ad/0xa50 net/core/dev.c:6149
 __napi_poll+0xe7/0x980 net/core/dev.c:6902
 napi_poll net/core/dev.c:6971 [inline]
 net_rx_action+0xa5a/0x19b0 net/core/dev.c:7093
 handle_softirqs+0x1a0/0x7c0 kernel/softirq.c:561
 __do_softirq+0x14/0x1a kernel/softirq.c:595

Uninit was stored to memory at:
 put_unaligned_be32 include/linux/unaligned.h:68 [inline]
 mptcp_write_options+0x17f9/0x3100 net/mptcp/options.c:1417
 mptcp_options_write net/ipv4/tcp_output.c:465 [inline]
 tcp_options_write+0x6d9/0xe90 net/ipv4/tcp_output.c:759
 __tcp_transmit_skb+0x294b/0x4900 net/ipv4/tcp_output.c:1414
 tcp_transmit_skb net/ipv4/tcp_output.c:1486 [inline]
 tcp_write_xmit+0x3b90/0x9070 net/ipv4/tcp_output.c:2829
 __tcp_push_pending_frames+0xc4/0x380 net/ipv4/tcp_output.c:3012
 tcp_send_fin+0x9f6/0xf50 net/ipv4/tcp_output.c:3618
 __tcp_close+0x140c/0x1550 net/ipv4/tcp.c:3130
 __mptcp_close_ssk+0x74e/0x16f0 net/mptcp/protocol.c:2496
 mptcp_close_ssk+0x26b/0x2c0 net/mptcp/protocol.c:2550
 mptcp_pm_nl_rm_addr_or_subflow+0x635/0xd10 net/mptcp/pm_netlink.c:889
 mptcp_pm_nl_rm_subflow_received net/mptcp/pm_netlink.c:924 [inline]
 mptcp_pm_flush_addrs_and_subflows net/mptcp/pm_netlink.c:1688 [inline]
 mptcp_nl_flush_addrs_list net/mptcp/pm_netlink.c:1709 [inline]
 mptcp_pm_nl_flush_addrs_doit+0xe10/0x1630 net/mptcp/pm_netlink.c:1750
 genl_family_rcv_msg_doit net/netlink/genetlink.c:1115 [inline]
 genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
 genl_rcv_msg+0x1214/0x12c0 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x375/0x650 net/netlink/af_netlink.c:2542
 genl_rcv+0x40/0x60 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1321 [inline]
 netlink_unicast+0xf52/0x1260 net/netlink/af_netlink.c:1347
 netlink_sendmsg+0x10da/0x11e0 net/netlink/af_netlink.c:1891
 sock_sendmsg_nosec net/socket.c:711 [inline]
 __sock_sendmsg+0x30f/0x380 net/socket.c:726
 ____sys_sendmsg+0x877/0xb60 net/socket.c:2583
 ___sys_sendmsg+0x28d/0x3c0 net/socket.c:2637
 __sys_sendmsg net/socket.c:2669 [inline]
 __do_sys_sendmsg net/socket.c:2674 [inline]
 __se_sys_sendmsg net/socket.c:2672 [inline]
 __x64_sys_sendmsg+0x212/0x3c0 net/socket.c:2672
 x64_sys_call+0x2ed6/0x3c30 arch/x86/include/generated/asm/syscalls_64.h:47
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was stored to memory at:
 mptcp_pm_add_addr_signal+0x3d7/0x4c0
 mptcp_established_options_add_addr net/mptcp/options.c:666 [inline]
 mptcp_established_options+0x1b9b/0x3a00 net/mptcp/options.c:884
 tcp_established_options+0x2c4/0x7d0 net/ipv4/tcp_output.c:1012
 __tcp_transmit_skb+0x5b7/0x4900 net/ipv4/tcp_output.c:1333
 tcp_transmit_skb net/ipv4/tcp_output.c:1486 [inline]
 tcp_write_xmit+0x3b90/0x9070 net/ipv4/tcp_output.c:2829
 __tcp_push_pending_frames+0xc4/0x380 net/ipv4/tcp_output.c:3012
 tcp_send_fin+0x9f6/0xf50 net/ipv4/tcp_output.c:3618
 __tcp_close+0x140c/0x1550 net/ipv4/tcp.c:3130
 __mptcp_close_ssk+0x74e/0x16f0 net/mptcp/protocol.c:2496
 mptcp_close_ssk+0x26b/0x2c0 net/mptcp/protocol.c:2550
 mptcp_pm_nl_rm_addr_or_subflow+0x635/0xd10 net/mptcp/pm_netlink.c:889
 mptcp_pm_nl_rm_subflow_received net/mptcp/pm_netlink.c:924 [inline]
 mptcp_pm_flush_addrs_and_subflows net/mptcp/pm_netlink.c:1688 [inline]
 mptcp_nl_flush_addrs_list net/mptcp/pm_netlink.c:1709 [inline]
 mptcp_pm_nl_flush_addrs_doit+0xe10/0x1630 net/mptcp/pm_netlink.c:1750
 genl_family_rcv_msg_doit net/netlink/genetlink.c:1115 [inline]
 genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
 genl_rcv_msg+0x1214/0x12c0 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x375/0x650 net/netlink/af_netlink.c:2542
 genl_rcv+0x40/0x60 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1321 [inline]
 netlink_unicast+0xf52/0x1260 net/netlink/af_netlink.c:1347
 netlink_sendmsg+0x10da/0x11e0 net/netlink/af_netlink.c:1891
 sock_sendmsg_nosec net/socket.c:711 [inline]
 __sock_sendmsg+0x30f/0x380 net/socket.c:726
 ____sys_sendmsg+0x877/0xb60 net/socket.c:2583
 ___sys_sendmsg+0x28d/0x3c0 net/socket.c:2637
 __sys_sendmsg net/socket.c:2669 [inline]
 __do_sys_sendmsg net/socket.c:2674 [inline]
 __se_sys_sendmsg net/socket.c:2672 [inline]
 __x64_sys_sendmsg+0x212/0x3c0 net/socket.c:2672
 x64_sys_call+0x2ed6/0x3c30 arch/x86/include/generated/asm/syscalls_64.h:47
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was stored to memory at:
 mptcp_pm_add_addr_received+0x95f/0xdd0 net/mptcp/pm.c:235
 mptcp_incoming_options+0x2983/0x3d30 net/mptcp/options.c:1169
 tcp_data_queue+0xb4/0x7be0 net/ipv4/tcp_input.c:5233
 tcp_rcv_state_process+0x2a38/0x49d0 net/ipv4/tcp_input.c:6972
 tcp_v4_do_rcv+0xbf9/0x11a0 net/ipv4/tcp_ipv4.c:1939
 tcp_v4_rcv+0x51df/0x5750 net/ipv4/tcp_ipv4.c:2351
 ip_protocol_deliver_rcu+0x2a3/0x13d0 net/ipv4/ip_input.c:205
 ip_local_deliver_finish+0x336/0x500 net/ipv4/ip_input.c:233
 NF_HOOK include/linux/netfilter.h:314 [inline]
 ip_local_deliver+0x21f/0x490 net/ipv4/ip_input.c:254
 dst_input include/net/dst.h:460 [inline]
 ip_rcv_finish+0x4a2/0x520 net/ipv4/ip_input.c:447
 NF_HOOK include/linux/netfilter.h:314 [inline]
 ip_rcv+0xcd/0x380 net/ipv4/ip_input.c:567
 __netif_receive_skb_one_core net/core/dev.c:5704 [inline]
 __netif_receive_skb+0x319/0xa00 net/core/dev.c:5817
 process_backlog+0x4ad/0xa50 net/core/dev.c:6149
 __napi_poll+0xe7/0x980 net/core/dev.c:6902
 napi_poll net/core/dev.c:6971 [inline]
 net_rx_action+0xa5a/0x19b0 net/core/dev.c:7093
 handle_softirqs+0x1a0/0x7c0 kernel/softirq.c:561
 __do_softirq+0x14/0x1a kernel/softirq.c:595

Local variable mp_opt created at:
 mptcp_incoming_options+0x119/0x3d30 net/mptcp/options.c:1127
 tcp_data_queue+0xb4/0x7be0 net/ipv4/tcp_input.c:5233

CPU: 1 UID: 0 PID: 7183 Comm: syz.2.410 Not tainted 6.13.0-rc7-syzkaller #0
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


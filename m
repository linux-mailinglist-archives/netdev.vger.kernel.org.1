Return-Path: <netdev+bounces-240751-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B2A1BC78F5A
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 13:13:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8EA914EB87D
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 12:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3201B3321D3;
	Fri, 21 Nov 2025 12:11:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A29434B1AF
	for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 12:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763727097; cv=none; b=hNHiuozZuGum7JPMmmwkSzELIbBsJBSKZ/JnF/edfxz4HzB0fe+Ov+sprUcTSlTXJ/8RXbUfH03EGnOIGbF51kCHeAQ4uYbT0TnPD1GmrTE26goLT8A1V/wysa1Bwq9NXGoJDpeoQbY6hB/tlbxKVqRHavucVXuRrX6/sqXiXE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763727097; c=relaxed/simple;
	bh=2D5fuZ4CnSOfDrMMePKN/OyKAL0l1ZNmoSbpv5mEe7A=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=dbZB6CGdJEfpoiDHj578LfATBJ44T0ToXGDVBzaLUIQV8r/Ai3lczyxrRzBWW2WMfleyo6rFRfLxYzGO9gkZPWwhc84zrWKRH6iwp0QQvCURe5H4KClzn3j2to2ipK2n1HZaLwKMJjYWNAcxxv19K2b5T93BvS2d712HRs2M+lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-43478824a6fso18848445ab.3
        for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 04:11:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763727094; x=1764331894;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zV30rAUHe9nf5njvs4h81en2iC+xQgzdRBM2uW2ZegQ=;
        b=GXiY6f7Igqj9TaEqs4jz65LDxHnQ2v5TeurbN2Z45wvz5HQcqC8uzAkWh4OkgFUQrd
         ++WhgpCv/CYkFyChOzyKWcbHvaztpYJjDi3tjVuBJO/BTzqtAcwZsJc/m8AwPBnNOC9z
         ZbI1ywrY8ug9OKuzdxpWc3EfRNcfwVQh+ERJ9AbRKeAaHiosoNFPO9SUeboJ9ixZc914
         lbrqH32MzZbt0IJNGGlHFCkP4RC8AGcaZ5lmNK2I9ENF1t1mcKBMzD7AAJuAy/x43H8b
         Xyyz/2sMfLdJ22/KDQiGqg31MnLfm0tt/wAxDmjYb1oXGRM5XYG7fiABl40GH5SPdJtU
         vxXg==
X-Forwarded-Encrypted: i=1; AJvYcCUkb7rRHdy/dkT5XS6M/cXfGjccahINK47XihpFTImRCnj6o75CxC/8GlBcK+Yqsi5Xr1GZKTU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi2UCDGHuA/AQHOOfPBhu9gtjRJqYxxFesenLvtUk6qBAV6PE8
	oKMC6gHdk4K3y28+H+q2y7YwUiQlnE0Uwgmc7Nk8PxvfwKodvYpyVyjHzkVdZMWlGy/UbqBH24l
	CZTdy3/NRpZI5FpHV6k/lX04EwUhOdyFc21djes5sjLDPcyJG2OqTcmAxHkM=
X-Google-Smtp-Source: AGHT+IHbVGWfWIxz44VI+EgtiCO1Fa4flWCMu2SCDaKm0jcgj3g6PkOE0/IZyXHe2m0xdxZ0y/2RSZVHdkSoiFzX3f0038AMJKul
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2608:b0:433:23ba:2d84 with SMTP id
 e9e14a558f8ab-435b8c1f639mr17222345ab.17.1763727094346; Fri, 21 Nov 2025
 04:11:34 -0800 (PST)
Date: Fri, 21 Nov 2025 04:11:34 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <692056f6.a70a0220.2ea503.004e.GAE@google.com>
Subject: [syzbot] [mptcp?] WARNING in __mptcp_move_skbs_from_subflow (2)
From: syzbot <syzbot+9475dcc0b42355ded022@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, geliang@kernel.org, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	martineau@kernel.org, matttbe@kernel.org, mptcp@lists.linux.dev, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    fd95357fd8c6 Merge tag 'sched_ext-for-6.18-rc6-fixes-2' of..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17220e92580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1cd7f786c0f5182f
dashboard link: https://syzkaller.appspot.com/bug?extid=9475dcc0b42355ded022
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-fd95357f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9301ea2e80a9/vmlinux-fd95357f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/13592a9d2a74/bzImage-fd95357f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9475dcc0b42355ded022@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 2 PID: 1143 at net/mptcp/protocol.c:718 __mptcp_move_skbs_from_subflow+0xeda/0x3360 net/mptcp/protocol.c:718
Modules linked in:
CPU: 2 UID: 0 PID: 1143 Comm: kworker/u32:7 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Workqueue: krdsd rds_shutdown_worker
RIP: 0010:__mptcp_move_skbs_from_subflow+0xeda/0x3360 net/mptcp/protocol.c:718
Code: 75 f6 e8 09 a8 75 f6 8b 5c 24 18 8b 6c 24 70 01 5c 24 1c 89 ee 89 df e8 74 a2 75 f6 39 dd 0f 83 d9 f3 ff ff e8 e7 a7 75 f6 90 <0f> 0b 90 48 b8 00 00 00 00 00 fc ff df 48 8b 54 24 48 48 c1 ea 03
RSP: 0018:ffffc90000537aa0 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000001508 RCX: ffffffff8b46af8c
RDX: ffff888021412480 RSI: ffffffff8b46af99 RDI: 0000000000000004
RBP: 00000000000010bc R08: 0000000000000004 R09: 0000000000001508
R10: 00000000000010bc R11: 0000000000000001 R12: ffff88806b1b00e8
R13: ffffffff9afc3e80 R14: dffffc0000000000 R15: ffff88806b1b0000
FS:  0000000000000000(0000) GS:ffff888097a0d000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000c230000 CR3: 00000000663a8000 CR4: 0000000000352ef0
Call Trace:
 <IRQ>
 move_skbs_to_msk net/mptcp/protocol.c:833 [inline]
 __mptcp_data_ready net/mptcp/protocol.c:853 [inline]
 mptcp_data_ready+0x251/0x6c0 net/mptcp/protocol.c:870
 subflow_state_change+0x4fb/0x800 net/mptcp/subflow.c:1870
 tcp_rcv_state_process+0x453b/0x6490 net/ipv4/tcp_input.c:7073
 tcp_v6_do_rcv+0x7b8/0x1dc0 net/ipv6/tcp_ipv6.c:1675
 tcp_v6_rcv+0x2ab5/0x48f0 net/ipv6/tcp_ipv6.c:1922
 ip6_protocol_deliver_rcu+0x188/0x1520 net/ipv6/ip6_input.c:438
 ip6_input_finish+0x1e4/0x4b0 net/ipv6/ip6_input.c:489
 NF_HOOK include/linux/netfilter.h:318 [inline]
 NF_HOOK include/linux/netfilter.h:312 [inline]
 ip6_input+0x105/0x2f0 net/ipv6/ip6_input.c:500
 dst_input include/net/dst.h:474 [inline]
 ip6_rcv_finish+0x1ac/0x580 net/ipv6/ip6_input.c:79
 ip_sabotage_in+0x21e/0x290 net/bridge/br_netfilter_hooks.c:990
 nf_hook_entry_hookfn include/linux/netfilter.h:158 [inline]
 nf_hook_slow+0xbe/0x200 net/netfilter/core.c:623
 nf_hook.constprop.0+0x424/0x750 include/linux/netfilter.h:273
 NF_HOOK include/linux/netfilter.h:316 [inline]
 ipv6_rcv+0xa4/0x650 net/ipv6/ip6_input.c:311
 __netif_receive_skb_one_core+0x12d/0x1e0 net/core/dev.c:6079
 __netif_receive_skb+0x1d/0x160 net/core/dev.c:6192
 netif_receive_skb_internal net/core/dev.c:6278 [inline]
 netif_receive_skb+0x137/0x7b0 net/core/dev.c:6337
 NF_HOOK include/linux/netfilter.h:318 [inline]
 NF_HOOK include/linux/netfilter.h:312 [inline]
 br_pass_frame_up+0x346/0x490 net/bridge/br_input.c:70
 br_handle_frame_finish+0x12fe/0x1f00 net/bridge/br_input.c:222
 br_nf_hook_thresh+0x307/0x410 net/bridge/br_netfilter_hooks.c:1167
 br_nf_pre_routing_finish_ipv6+0x76a/0xfc0 net/bridge/br_netfilter_ipv6.c:154
 NF_HOOK include/linux/netfilter.h:318 [inline]
 br_nf_pre_routing_ipv6+0x3cd/0x8c0 net/bridge/br_netfilter_ipv6.c:184
 br_nf_pre_routing+0x860/0x15b0 net/bridge/br_netfilter_hooks.c:508
 nf_hook_entry_hookfn include/linux/netfilter.h:158 [inline]
 nf_hook_bridge_pre net/bridge/br_input.c:291 [inline]
 br_handle_frame+0xb28/0x14e0 net/bridge/br_input.c:442
 __netif_receive_skb_core.constprop.0+0xa25/0x4bd0 net/core/dev.c:5966
 __netif_receive_skb_one_core+0xb0/0x1e0 net/core/dev.c:6077
 __netif_receive_skb+0x1d/0x160 net/core/dev.c:6192
 process_backlog+0x439/0x15e0 net/core/dev.c:6544
 __napi_poll.constprop.0+0xba/0x550 net/core/dev.c:7594
 napi_poll net/core/dev.c:7657 [inline]
 net_rx_action+0x97f/0xef0 net/core/dev.c:7784
 handle_softirqs+0x219/0x8e0 kernel/softirq.c:622
 do_softirq kernel/softirq.c:523 [inline]
 do_softirq+0xb2/0xf0 kernel/softirq.c:510
 </IRQ>
 <TASK>
 __local_bh_enable_ip+0x100/0x120 kernel/softirq.c:450
 local_bh_enable include/linux/bottom_half.h:33 [inline]
 rcu_read_unlock_bh include/linux/rcupdate.h:936 [inline]
 __dev_queue_xmit+0xb06/0x4490 net/core/dev.c:4790
 dev_queue_xmit include/linux/netdevice.h:3365 [inline]
 neigh_hh_output include/net/neighbour.h:531 [inline]
 neigh_output include/net/neighbour.h:545 [inline]
 ip6_finish_output2+0x1184/0x1cf0 net/ipv6/ip6_output.c:136
 __ip6_finish_output+0x3cd/0x1010 net/ipv6/ip6_output.c:209
 ip6_finish_output net/ipv6/ip6_output.c:220 [inline]
 NF_HOOK_COND include/linux/netfilter.h:307 [inline]
 ip6_output+0x253/0x710 net/ipv6/ip6_output.c:247
 dst_output include/net/dst.h:464 [inline]
 NF_HOOK include/linux/netfilter.h:318 [inline]
 NF_HOOK include/linux/netfilter.h:312 [inline]
 ip6_xmit+0x1512/0x23f0 net/ipv6/ip6_output.c:371
 inet6_csk_xmit+0x444/0x7f0 net/ipv6/inet6_connection_sock.c:120
 __tcp_transmit_skb+0x1d67/0x44d0 net/ipv4/tcp_output.c:1628
 tcp_transmit_skb net/ipv4/tcp_output.c:1646 [inline]
 tcp_write_xmit+0x12a9/0x86e0 net/ipv4/tcp_output.c:2999
 __tcp_push_pending_frames+0xaf/0x390 net/ipv4/tcp_output.c:3182
 tcp_send_fin+0x121/0x1050 net/ipv4/tcp_output.c:3800
 __tcp_close+0xa46/0x1120 net/ipv4/tcp.c:3207
 tcp_close+0x28/0x120 net/ipv4/tcp.c:3298
 inet_release+0xed/0x200 net/ipv4/af_inet.c:437
 inet6_release+0x4f/0x70 net/ipv6/af_inet6.c:487
 __sock_release net/socket.c:662 [inline]
 sock_release+0x91/0x1d0 net/socket.c:690
 rds_tcp_conn_path_shutdown+0x1f9/0x410 net/rds/tcp_connect.c:220
 rds_conn_shutdown+0x28b/0xaa0 net/rds/connection.c:399
 process_one_work+0x9cf/0x1b70 kernel/workqueue.c:3263
 process_scheduled_works kernel/workqueue.c:3346 [inline]
 worker_thread+0x6c8/0xf10 kernel/workqueue.c:3427
 kthread+0x3c5/0x780 kernel/kthread.c:463
 ret_from_fork+0x675/0x7d0 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>


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


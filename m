Return-Path: <netdev+bounces-129217-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF65197E449
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 02:06:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D58B51C20D9E
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 00:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A4CB802;
	Mon, 23 Sep 2024 00:06:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9806366
	for <netdev@vger.kernel.org>; Mon, 23 Sep 2024 00:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727049986; cv=none; b=jBkk5YO8uVa8SNnyyIsCjmYo7hegxeNoIQTBcanUA/rcK9CP+BWlloQvTGAut3qrqh1Vk/hNLXwehdrJS8WJUhOhPcuMhbmSXuY5qrZUuSgzYTTf+su0GU0ebwhAyxS5lWbfZAdhTgWIPkL+X9JCGLnzGImbJNZC7OJwLuZk/qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727049986; c=relaxed/simple;
	bh=u9rXPoUapOlaU2GpofbQQFx7+tCMjUDOiiOuWaTg9No=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=k/W5MqZ3gsV668IOfB0WoNMYfag5dDSvpabBqK+8g0XaME5t3x3fQJM5cz5FLy41al0dOCy7hCxMD1iN7HwUj1anOQGYx7veGoznbdykh4yzQZg1rkmWr+CfrGRGleeQIMbi5lIchhl+2YcLRK4MHkTZL+T1FtyGDfMBCx3U0vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a0ce8cf657so36882935ab.1
        for <netdev@vger.kernel.org>; Sun, 22 Sep 2024 17:06:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727049984; x=1727654784;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yQWdKNdDhsxt/8CPNHc5tRRXzIePlhhS1oOIVFgpmd8=;
        b=Smkqk0Yf3C5PdBrJ1LDQ2Pvwr0QXWaIXSAwmei8zeeh49aU+mDqKQJbdRO0TeM+CQ5
         sAVkWSOFFuCvcYEMYf1IAN9vixGrSrhPSb+zO0Io9uJ8rbH99PrCI+nEof9hwcfrtJBw
         cowLRDKE4xIFdGrXpWbdkS6tLSDfv1EOwDvF+FkPcZGtGvi2/5SEfcOg70LPT079Ot0O
         PKXf7vT1vSFkn0wYZQQekkEgeNK5FB5shfeBK1ztwZ2322CCGqf1BbxRg38FNnG4lyIh
         HSvk4unJFR3NL3g4G21y04+DN1PrYGBz0/kq0tDp1S4em+DCz4HlfS9jpQUpVj81UBCy
         WO8w==
X-Forwarded-Encrypted: i=1; AJvYcCVPYRlj2JyqCRcpR5CY0zBg4ajoC8jWCnJF3CDp96JPukqyiB9N4luAADW+NHVZFn8Bg29FzQQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyX8ZA6BSW7iQKdEgR7TaPVWimBumWy6Kvlfdgdx3ynpoyLkfuK
	ep4DXFJwR36QzGYwN5U0+98WTGe39GKfOiUaC/SwaEzBu2pHKfdl7CBJQlrMr1IfH6Pqc0rk3sy
	0GIk2Re3V0/HnKevK+3rsC/ZFfXZMajj+yXdXP04KfSdCbeW7m7osh1E=
X-Google-Smtp-Source: AGHT+IGFq9FhiNg775XidPqJcSGPujpZ+QwY2yfqANrzbOE9O/horlZnGHFL5bruOq4stOZ9kPVl/n7T5GrlyAQanNUFjz7bDGWs
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:18ca:b0:3a0:bb8c:bd0 with SMTP id
 e9e14a558f8ab-3a0c8cb0affmr84352105ab.12.1727049984076; Sun, 22 Sep 2024
 17:06:24 -0700 (PDT)
Date: Sun, 22 Sep 2024 17:06:24 -0700
In-Reply-To: <000000000000d1dd99061d4a0af4@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f0b100.050a0220.c23dd.0001.GAE@google.com>
Subject: Re: [syzbot] [mptcp?] WARNING in __mptcp_move_skbs_from_subflow
From: syzbot <syzbot+d1bff73460e33101f0e7@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, geliang@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, martineau@kernel.org, 
	matttbe@kernel.org, mptcp@lists.linux.dev, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    af9c191ac2a0 Merge tag 'trace-ring-buffer-v6.12' of git://..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=174f4107980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e851828834875d6f
dashboard link: https://syzkaller.appspot.com/bug?extid=d1bff73460e33101f0e7
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14f9219f980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=122d1c27980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/2b553a08733b/disk-af9c191a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/aa643c9f0242/vmlinux-af9c191a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d4895374e1fc/bzImage-af9c191a.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d1bff73460e33101f0e7@syzkaller.appspotmail.com

TCP: request_sock_subflow_v4: Possible SYN flooding on port [::]:20002. Sending cookies.
------------[ cut here ]------------
WARNING: CPU: 0 PID: 5227 at net/mptcp/protocol.c:695 __mptcp_move_skbs_from_subflow+0x20a9/0x21f0 net/mptcp/protocol.c:695
Modules linked in:
CPU: 0 UID: 0 PID: 5227 Comm: syz-executor350 Not tainted 6.11.0-syzkaller-08829-gaf9c191ac2a0 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
RIP: 0010:__mptcp_move_skbs_from_subflow+0x20a9/0x21f0 net/mptcp/protocol.c:695
Code: 0f b6 dc 31 ff 89 de e8 b5 dd ea f5 89 d8 48 81 c4 50 01 00 00 5b 41 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc e8 98 da ea f5 90 <0f> 0b 90 e9 47 ff ff ff e8 8a da ea f5 90 0f 0b 90 e9 99 e0 ff ff
RSP: 0018:ffffc90000006db8 EFLAGS: 00010246
RAX: ffffffff8ba9df18 RBX: 00000000000055f0 RCX: ffff888030023c00
RDX: 0000000000000100 RSI: 00000000000081e5 RDI: 00000000000055f0
RBP: 1ffff110062bf1ae R08: ffffffff8ba9cf12 R09: 1ffff110062bf1b8
R10: dffffc0000000000 R11: ffffed10062bf1b9 R12: 0000000000000000
R13: dffffc0000000000 R14: 00000000700cec61 R15: 00000000000081e5
FS:  000055556679c380(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020287000 CR3: 0000000077892000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 move_skbs_to_msk net/mptcp/protocol.c:811 [inline]
 mptcp_data_ready+0x29c/0xa90 net/mptcp/protocol.c:854
 subflow_data_ready+0x34a/0x920 net/mptcp/subflow.c:1490
 tcp_data_queue+0x20fd/0x76c0 net/ipv4/tcp_input.c:5283
 tcp_rcv_established+0xfba/0x2020 net/ipv4/tcp_input.c:6237
 tcp_v4_do_rcv+0x96d/0xc70 net/ipv4/tcp_ipv4.c:1915
 tcp_v4_rcv+0x2dc0/0x37f0 net/ipv4/tcp_ipv4.c:2350
 ip_protocol_deliver_rcu+0x22e/0x440 net/ipv4/ip_input.c:205
 ip_local_deliver_finish+0x341/0x5f0 net/ipv4/ip_input.c:233
 NF_HOOK+0x3a4/0x450 include/linux/netfilter.h:314
 NF_HOOK+0x3a4/0x450 include/linux/netfilter.h:314
 __netif_receive_skb_one_core net/core/dev.c:5662 [inline]
 __netif_receive_skb+0x2bf/0x650 net/core/dev.c:5775
 process_backlog+0x662/0x15b0 net/core/dev.c:6107
 __napi_poll+0xcb/0x490 net/core/dev.c:6771
 napi_poll net/core/dev.c:6840 [inline]
 net_rx_action+0x89b/0x1240 net/core/dev.c:6962
 handle_softirqs+0x2c5/0x980 kernel/softirq.c:554
 do_softirq+0x11b/0x1e0 kernel/softirq.c:455
 </IRQ>
 <TASK>
 __local_bh_enable_ip+0x1bb/0x200 kernel/softirq.c:382
 local_bh_enable include/linux/bottom_half.h:33 [inline]
 rcu_read_unlock_bh include/linux/rcupdate.h:919 [inline]
 __dev_queue_xmit+0x1764/0x3e80 net/core/dev.c:4451
 dev_queue_xmit include/linux/netdevice.h:3094 [inline]
 neigh_hh_output include/net/neighbour.h:526 [inline]
 neigh_output include/net/neighbour.h:540 [inline]
 ip_finish_output2+0xd41/0x1390 net/ipv4/ip_output.c:236
 ip_local_out net/ipv4/ip_output.c:130 [inline]
 __ip_queue_xmit+0x118c/0x1b80 net/ipv4/ip_output.c:536
 __tcp_transmit_skb+0x2544/0x3b30 net/ipv4/tcp_output.c:1466
 tcp_transmit_skb net/ipv4/tcp_output.c:1484 [inline]
 tcp_mtu_probe net/ipv4/tcp_output.c:2547 [inline]
 tcp_write_xmit+0x641d/0x6bf0 net/ipv4/tcp_output.c:2752
 __tcp_push_pending_frames+0x9b/0x360 net/ipv4/tcp_output.c:3015
 tcp_push_pending_frames include/net/tcp.h:2107 [inline]
 tcp_data_snd_check net/ipv4/tcp_input.c:5714 [inline]
 tcp_rcv_established+0x1026/0x2020 net/ipv4/tcp_input.c:6239
 tcp_v4_do_rcv+0x96d/0xc70 net/ipv4/tcp_ipv4.c:1915
 sk_backlog_rcv include/net/sock.h:1113 [inline]
 __release_sock+0x214/0x350 net/core/sock.c:3072
 release_sock+0x61/0x1f0 net/core/sock.c:3626
 mptcp_push_release net/mptcp/protocol.c:1486 [inline]
 __mptcp_push_pending+0x6b5/0x9f0 net/mptcp/protocol.c:1625
 mptcp_sendmsg+0x10bb/0x1b10 net/mptcp/protocol.c:1903
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x1a6/0x270 net/socket.c:745
 ____sys_sendmsg+0x52a/0x7e0 net/socket.c:2603
 ___sys_sendmsg net/socket.c:2657 [inline]
 __sys_sendmsg+0x2aa/0x390 net/socket.c:2686
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fb06e9317f9
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe2cfd4f98 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007fb06e97f468 RCX: 00007fb06e9317f9
RDX: 0000000000000000 RSI: 0000000020000080 RDI: 0000000000000005
RBP: 00007fb06e97f446 R08: 0000555500000000 R09: 0000555500000000
R10: 0000555500000000 R11: 0000000000000246 R12: 00007fb06e97f406
R13: 0000000000000001 R14: 00007ffe2cfd4fe0 R15: 0000000000000003
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.


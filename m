Return-Path: <netdev+bounces-176978-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F836A6D16F
	for <lists+netdev@lfdr.de>; Sun, 23 Mar 2025 23:29:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 403093B29EB
	for <lists+netdev@lfdr.de>; Sun, 23 Mar 2025 22:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA80A1519B8;
	Sun, 23 Mar 2025 22:29:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F5913635E
	for <netdev@vger.kernel.org>; Sun, 23 Mar 2025 22:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742768967; cv=none; b=W0lOswsWOaaHLXOy2qDNi60LxPyrvyIw9VP6Dxr0jOXVLqLsAhJr0AOLmfRRRFXEZI6sBtqgFBWDSyf7+/pglSID1Frtqh6EAZ8Nw8RAhPWnY96JwTRQSUJLxbA88Qw+BHAhVeqtkEERrVWntDPbwXoUgOd9pa1drfMS9FRfJT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742768967; c=relaxed/simple;
	bh=+jUYh885OfbSaYN0gkGWBrklf3NLx4kXWR01nBncUe4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=jqxUe6A/JiIVT1UI3zxZi5zd/gLbmpZYLHzUfDZRrrmx/87ww2dF0b+n59r4fyJsHAD5exOMCwWho7KhsF/3wERp7Z6aUbJ5pd80FXarT5nD/mxJE4CZBw6eqfZzYLOXim3O3/ZHw14gwSS/FXv4cK6Ih9LDUP8Pak6TDQnXg4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3d43d3338d7so78944055ab.0
        for <netdev@vger.kernel.org>; Sun, 23 Mar 2025 15:29:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742768965; x=1743373765;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0whirQfEp/HnVFS0TQ/d/sx4gZ3rbACrSb0zJJASSF4=;
        b=doIT7dLIzH9CzYCz6KbZ2crCTVTKN+lRW+rBC0nmjnMOIDJ4wpvPIakkKEe9/t2ypk
         C3q/ndeCDWOGCxcHGZm1WijXNgwvAA6GFJ1s1k2U2+HQ1spNK1nX0BlYf2Lts/T9aGUD
         KgctKruyK2HxyKikgT3AG7Ec3NZM1e54xaZ2LWeE2pvGaQTE9mAhVb3Q+UpLy3Fo0kFo
         BkH5Ujq+acF94vKMB3xYo3JVUSkX+fWN3ve50OZbQi+3SeiDpZeRDokaFY0Rj3fcEtBd
         erP5ciojYIpqxwnbhAmoD9HBAezpYJdRjg4oxI46u9Ss39wKj9zHn0PSd3uJzBUO+xti
         stHg==
X-Forwarded-Encrypted: i=1; AJvYcCVCqO8Gok3L0Q0K7yklF70SwllGEOM/iup1urrG8lsfMD4sK87KZK0arJciX++LIgPIBMEGIHM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxggvX8jjEdNVefQAsToqujix85UkyMpj+LlljrqutwgcUVMMBL
	49vITl4lHyK7jzinXea3u8fyDlFT5Ye19BRVPet1xLHDwcJ/hJ2NUryp0jzGnjJVs8nMo0SJQ+0
	J7Rw2WVTKGiq6pDE/yAgV6WJXyP+X+5AYZABu2nscVMTVHH2zLy+3bKU=
X-Google-Smtp-Source: AGHT+IHAFJbuIBndlkn8IzYxZyDwiVqSuXQZ53H3v0TdCZixhQBcJm0kyq7mImD8cTWCYLWjIMvpnLMiqlJXbkTcogWT+krpEMmc
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:188d:b0:3d3:dfc2:912f with SMTP id
 e9e14a558f8ab-3d59613ad08mr121544195ab.7.1742768964778; Sun, 23 Mar 2025
 15:29:24 -0700 (PDT)
Date: Sun, 23 Mar 2025 15:29:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67e08b44.050a0220.21942d.0008.GAE@google.com>
Subject: [syzbot] [net?] BUG: stack guard page was hit in worker_thread
From: syzbot <syzbot+b6d2e10bf4503ebcd631@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    f653b608f783 MAINTAINERS: update bridge entry
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=166615e4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=27515cfdbafbb90d
dashboard link: https://syzkaller.appspot.com/bug?extid=b6d2e10bf4503ebcd631
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/5dcec1e5d2c5/disk-f653b608.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/18edc4cdc334/vmlinux-f653b608.xz
kernel image: https://storage.googleapis.com/syzbot-assets/55ff98409132/bzImage-f653b608.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b6d2e10bf4503ebcd631@syzkaller.appspotmail.com

BUG: TASK stack guard page was hit at ffffc9000c1bff18 (stack is ffffc9000c1c0000..ffffc9000c1c8000)
Oops: stack guard page: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 0 UID: 0 PID: 7350 Comm: kworker/u8:22 Not tainted 6.14.0-rc7-syzkaller-00138-gf653b608f783 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
Workqueue: bond2 bond_resend_igmp_join_requests_delayed
RIP: 0010:lock_acquire+0x1c/0x550 kernel/locking/lockdep.c:5819
Code: 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 55 48 89 e5 41 57 41 56 41 55 41 54 53 48 83 e4 e0 48 81 ec 20 01 00 00 <4c> 89 4c 24 28 4c 89 44 24 38 48 89 4c 24 30 89 54 24 1c 41 89 f6
RSP: 0018:ffffc9000c1bff20 EFLAGS: 00010082
RAX: 0000000000001c08 RBX: 1ffff92001838014 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff88813fffc298
RBP: ffffc9000c1c0068 R08: 0000000000000001 R09: 0000000000000000
R10: dffffc0000000000 R11: fffffbfff2079f6f R12: 0000000000000246
R13: 1ffff92001838010 R14: ffff88813fffc280 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffc9000c1bff18 CR3: 000000002a12a000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <#DF>
 </#DF>
 <TASK>
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
 rmqueue_buddy mm/page_alloc.c:2910 [inline]
 rmqueue mm/page_alloc.c:3083 [inline]
 get_page_from_freelist+0xb3d/0x37a0 mm/page_alloc.c:3474
 __alloc_frozen_pages_noprof+0x292/0x710 mm/page_alloc.c:4740
 __alloc_pages_noprof+0xa/0x30 mm/page_alloc.c:4774
 __alloc_pages_node_noprof include/linux/gfp.h:265 [inline]
 alloc_pages_node_noprof include/linux/gfp.h:292 [inline]
 ___kmalloc_large_node+0x8b/0x1d0 mm/slub.c:4239
 __kmalloc_large_node_noprof+0x1a/0x80 mm/slub.c:4266
 __do_kmalloc_node mm/slub.c:4282 [inline]
 __kmalloc_node_track_caller_noprof+0x335/0x4c0 mm/slub.c:4313
 kmalloc_reserve+0x111/0x2a0 net/core/skbuff.c:537
 pskb_expand_head+0x1ee/0x1470 net/core/skbuff.c:2185
 __skb_cow include/linux/skbuff.h:3769 [inline]
 skb_cow_head include/linux/skbuff.h:3803 [inline]
 gre_tap_xmit+0x4aa/0x800 net/ipv4/ip_gre.c:769
 __netdev_start_xmit include/linux/netdevice.h:5151 [inline]
 netdev_start_xmit include/linux/netdevice.h:5160 [inline]
 xmit_one net/core/dev.c:3800 [inline]
 dev_hard_start_xmit+0x27a/0x7d0 net/core/dev.c:3816
 sch_direct_xmit+0x29c/0x5d0 net/sched/sch_generic.c:343
 __dev_xmit_skb net/core/dev.c:4042 [inline]
 __dev_queue_xmit+0x1a8f/0x3f50 net/core/dev.c:4618
 dev_queue_xmit include/linux/netdevice.h:3313 [inline]
 bond_dev_queue_xmit+0x147/0x250 drivers/net/bonding/bond_main.c:309
 __bond_start_xmit drivers/net/bonding/bond_main.c:5583 [inline]
 bond_start_xmit+0xcb0/0x1c40 drivers/net/bonding/bond_main.c:5605
 __netdev_start_xmit include/linux/netdevice.h:5151 [inline]
 netdev_start_xmit include/linux/netdevice.h:5160 [inline]
 xmit_one net/core/dev.c:3800 [inline]
 dev_hard_start_xmit+0x27a/0x7d0 net/core/dev.c:3816
 __dev_queue_xmit+0x1b73/0x3f50 net/core/dev.c:4652
 dev_queue_xmit include/linux/netdevice.h:3313 [inline]
 neigh_hh_output include/net/neighbour.h:523 [inline]
 neigh_output include/net/neighbour.h:537 [inline]
 ip_finish_output2+0xcd3/0x12e0 net/ipv4/ip_output.c:236
 iptunnel_xmit+0x55d/0x9b0 net/ipv4/ip_tunnel_core.c:82
 ip_tunnel_xmit+0x1dbf/0x2560 net/ipv4/ip_tunnel.c:858
 __gre_xmit net/ipv4/ip_gre.c:484 [inline]
 gre_tap_xmit+0x641/0x800 net/ipv4/ip_gre.c:772
 __netdev_start_xmit include/linux/netdevice.h:5151 [inline]
 netdev_start_xmit include/linux/netdevice.h:5160 [inline]
 xmit_one net/core/dev.c:3800 [inline]
 dev_hard_start_xmit+0x27a/0x7d0 net/core/dev.c:3816
 sch_direct_xmit+0x29c/0x5d0 net/sched/sch_generic.c:343
 __dev_xmit_skb net/core/dev.c:4042 [inline]
 __dev_queue_xmit+0x1a8f/0x3f50 net/core/dev.c:4618
 dev_queue_xmit include/linux/netdevice.h:3313 [inline]
 bond_dev_queue_xmit+0x147/0x250 drivers/net/bonding/bond_main.c:309
 __bond_start_xmit drivers/net/bonding/bond_main.c:5583 [inline]
 bond_start_xmit+0xcb0/0x1c40 drivers/net/bonding/bond_main.c:5605
 __netdev_start_xmit include/linux/netdevice.h:5151 [inline]
 netdev_start_xmit include/linux/netdevice.h:5160 [inline]
 xmit_one net/core/dev.c:3800 [inline]
 dev_hard_start_xmit+0x27a/0x7d0 net/core/dev.c:3816
 __dev_queue_xmit+0x1b73/0x3f50 net/core/dev.c:4652
 dev_queue_xmit include/linux/netdevice.h:3313 [inline]
 neigh_hh_output include/net/neighbour.h:523 [inline]
 neigh_output include/net/neighbour.h:537 [inline]
 ip_finish_output2+0xcd3/0x12e0 net/ipv4/ip_output.c:236
 iptunnel_xmit+0x55d/0x9b0 net/ipv4/ip_tunnel_core.c:82
 ip_tunnel_xmit+0x1dbf/0x2560 net/ipv4/ip_tunnel.c:858
 __gre_xmit net/ipv4/ip_gre.c:484 [inline]
 gre_tap_xmit+0x641/0x800 net/ipv4/ip_gre.c:772
 __netdev_start_xmit include/linux/netdevice.h:5151 [inline]
 netdev_start_xmit include/linux/netdevice.h:5160 [inline]
 xmit_one net/core/dev.c:3800 [inline]
 dev_hard_start_xmit+0x27a/0x7d0 net/core/dev.c:3816
 sch_direct_xmit+0x29c/0x5d0 net/sched/sch_generic.c:343
 __dev_xmit_skb net/core/dev.c:4042 [inline]
 __dev_queue_xmit+0x1a8f/0x3f50 net/core/dev.c:4618
 dev_queue_xmit include/linux/netdevice.h:3313 [inline]
 bond_dev_queue_xmit+0x147/0x250 drivers/net/bonding/bond_main.c:309
 __bond_start_xmit drivers/net/bonding/bond_main.c:5583 [inline]
 bond_start_xmit+0xcb0/0x1c40 drivers/net/bonding/bond_main.c:5605
 __netdev_start_xmit include/linux/netdevice.h:5151 [inline]
 netdev_start_xmit include/linux/netdevice.h:5160 [inline]
 xmit_one net/core/dev.c:3800 [inline]
 dev_hard_start_xmit+0x27a/0x7d0 net/core/dev.c:3816
 __dev_queue_xmit+0x1b73/0x3f50 net/core/dev.c:4652
 dev_queue_xmit include/linux/netdevice.h:3313 [inline]
 neigh_hh_output include/net/neighbour.h:523 [inline]
 neigh_output include/net/neighbour.h:537 [inline]
 ip_finish_output2+0xcd3/0x12e0 net/ipv4/ip_output.c:236
 iptunnel_xmit+0x55d/0x9b0 net/ipv4/ip_tunnel_core.c:82
 ip_tunnel_xmit+0x1dbf/0x2560 net/ipv4/ip_tunnel.c:858
 __gre_xmit net/ipv4/ip_gre.c:484 [inline]
 gre_tap_xmit+0x641/0x800 net/ipv4/ip_gre.c:772
 __netdev_start_xmit include/linux/netdevice.h:5151 [inline]
 netdev_start_xmit include/linux/netdevice.h:5160 [inline]
 xmit_one net/core/dev.c:3800 [inline]
 dev_hard_start_xmit+0x27a/0x7d0 net/core/dev.c:3816
 sch_direct_xmit+0x29c/0x5d0 net/sched/sch_generic.c:343
 __dev_xmit_skb net/core/dev.c:4042 [inline]
 __dev_queue_xmit+0x1a8f/0x3f50 net/core/dev.c:4618
 dev_queue_xmit include/linux/netdevice.h:3313 [inline]
 bond_dev_queue_xmit+0x147/0x250 drivers/net/bonding/bond_main.c:309
 __bond_start_xmit drivers/net/bonding/bond_main.c:5583 [inline]
 bond_start_xmit+0xcb0/0x1c40 drivers/net/bonding/bond_main.c:5605
 __netdev_start_xmit include/linux/netdevice.h:5151 [inline]
 netdev_start_xmit include/linux/netdevice.h:5160 [inline]
 xmit_one net/core/dev.c:3800 [inline]
 dev_hard_start_xmit+0x27a/0x7d0 net/core/dev.c:3816
 __dev_queue_xmit+0x1b73/0x3f50 net/core/dev.c:4652
 dev_queue_xmit include/linux/netdevice.h:3313 [inline]
 neigh_hh_output include/net/neighbour.h:523 [inline]
 neigh_output include/net/neighbour.h:537 [inline]
 ip_finish_output2+0xcd3/0x12e0 net/ipv4/ip_output.c:236
 iptunnel_xmit+0x55d/0x9b0 net/ipv4/ip_tunnel_core.c:82
 ip_tunnel_xmit+0x1dbf/0x2560 net/ipv4/ip_tunnel.c:858
 __gre_xmit net/ipv4/ip_gre.c:484 [inline]
 gre_tap_xmit+0x641/0x800 net/ipv4/ip_gre.c:772
 __netdev_start_xmit include/linux/netdevice.h:5151 [inline]
 netdev_start_xmit include/linux/netdevice.h:5160 [inline]
 xmit_one net/core/dev.c:3800 [inline]
 dev_hard_start_xmit+0x27a/0x7d0 net/core/dev.c:3816
 sch_direct_xmit+0x29c/0x5d0 net/sched/sch_generic.c:343
 __dev_xmit_skb net/core/dev.c:4042 [inline]
 __dev_queue_xmit+0x1a8f/0x3f50 net/core/dev.c:4618
 dev_queue_xmit include/linux/netdevice.h:3313 [inline]
 bond_dev_queue_xmit+0x147/0x250 drivers/net/bonding/bond_main.c:309
 __bond_start_xmit drivers/net/bonding/bond_main.c:5583 [inline]
 bond_start_xmit+0xcb0/0x1c40 drivers/net/bonding/bond_main.c:5605
 __netdev_start_xmit include/linux/netdevice.h:5151 [inline]
 netdev_start_xmit include/linux/netdevice.h:5160 [inline]
 xmit_one net/core/dev.c:3800 [inline]
 dev_hard_start_xmit+0x27a/0x7d0 net/core/dev.c:3816
 __dev_queue_xmit+0x1b73/0x3f50 net/core/dev.c:4652
 dev_queue_xmit include/linux/netdevice.h:3313 [inline]
 neigh_hh_output include/net/neighbour.h:523 [inline]
 neigh_output include/net/neighbour.h:537 [inline]
 ip_finish_output2+0xcd3/0x12e0 net/ipv4/ip_output.c:236
 iptunnel_xmit+0x55d/0x9b0 net/ipv4/ip_tunnel_core.c:82
 ip_tunnel_xmit+0x1dbf/0x2560 net/ipv4/ip_tunnel.c:858
 __gre_xmit net/ipv4/ip_gre.c:484 [inline]
 gre_tap_xmit+0x641/0x800 net/ipv4/ip_gre.c:772
 __netdev_start_xmit include/linux/netdevice.h:5151 [inline]
 netdev_start_xmit include/linux/netdevice.h:5160 [inline]
 xmit_one net/core/dev.c:3800 [inline]
 dev_hard_start_xmit+0x27a/0x7d0 net/core/dev.c:3816
 sch_direct_xmit+0x29c/0x5d0 net/sched/sch_generic.c:343
 __dev_xmit_skb net/core/dev.c:4042 [inline]
 __dev_queue_xmit+0x1a8f/0x3f50 net/core/dev.c:4618
 dev_queue_xmit include/linux/netdevice.h:3313 [inline]
 bond_dev_queue_xmit+0x147/0x250 drivers/net/bonding/bond_main.c:309
 __bond_start_xmit drivers/net/bonding/bond_main.c:5583 [inline]
 bond_start_xmit+0xcb0/0x1c40 drivers/net/bonding/bond_main.c:5605
 __netdev_start_xmit include/linux/netdevice.h:5151 [inline]
 netdev_start_xmit include/linux/netdevice.h:5160 [inline]
 xmit_one net/core/dev.c:3800 [inline]
 dev_hard_start_xmit+0x27a/0x7d0 net/core/dev.c:3816
 __dev_queue_xmit+0x1b73/0x3f50 net/core/dev.c:4652
 dev_queue_xmit include/linux/netdevice.h:3313 [inline]
 neigh_hh_output include/net/neighbour.h:523 [inline]
 neigh_output include/net/neighbour.h:537 [inline]
 ip_finish_output2+0xcd3/0x12e0 net/ipv4/ip_output.c:236
 iptunnel_xmit+0x55d/0x9b0 net/ipv4/ip_tunnel_core.c:82
 ip_tunnel_xmit+0x1dbf/0x2560 net/ipv4/ip_tunnel.c:858
 __gre_xmit net/ipv4/ip_gre.c:484 [inline]
 gre_tap_xmit+0x641/0x800 net/ipv4/ip_gre.c:772
 __netdev_start_xmit include/linux/netdevice.h:5151 [inline]
 netdev_start_xmit include/linux/netdevice.h:5160 [inline]
 xmit_one net/core/dev.c:3800 [inline]
 dev_hard_start_xmit+0x27a/0x7d0 net/core/dev.c:3816
 sch_direct_xmit+0x29c/0x5d0 net/sched/sch_generic.c:343
 __dev_xmit_skb net/core/dev.c:4042 [inline]
 __dev_queue_xmit+0x1a8f/0x3f50 net/core/dev.c:4618
 dev_queue_xmit include/linux/netdevice.h:3313 [inline]
 bond_dev_queue_xmit+0x147/0x250 drivers/net/bonding/bond_main.c:309
 __bond_start_xmit drivers/net/bonding/bond_main.c:5583 [inline]
 bond_start_xmit+0xcb0/0x1c40 drivers/net/bonding/bond_main.c:5605
 __netdev_start_xmit include/linux/netdevice.h:5151 [inline]
 netdev_start_xmit include/linux/netdevice.h:5160 [inline]
 xmit_one net/core/dev.c:3800 [inline]
 dev_hard_start_xmit+0x27a/0x7d0 net/core/dev.c:3816
 __dev_queue_xmit+0x1b73/0x3f50 net/core/dev.c:4652
 neigh_output include/net/neighbour.h:539 [inline]
 ip6_finish_output2+0x12bc/0x17c0 net/ipv6/ip6_output.c:141
 ip6_finish_output+0x41e/0x840 net/ipv6/ip6_output.c:226
 NF_HOOK+0x9e/0x430 include/linux/netfilter.h:314
 mld_sendpack+0x843/0xdb0 net/ipv6/mcast.c:1868
 ipv6_mc_rejoin_groups net/ipv6/mcast.c:2878 [inline]
 ipv6_mc_netdev_event+0x1cf/0x5d0 net/ipv6/mcast.c:2893
 notifier_call_chain+0x1a5/0x3f0 kernel/notifier.c:85
 call_netdevice_notifiers_extack net/core/dev.c:2244 [inline]
 call_netdevice_notifiers+0xb6/0xf0 net/core/dev.c:2258
 bond_resend_igmp_join_requests_delayed+0x63/0x180 drivers/net/bonding/bond_main.c:970
 process_one_work kernel/workqueue.c:3238 [inline]
 process_scheduled_works+0xabe/0x18e0 kernel/workqueue.c:3319
 worker_thread+0x870/0xd30 kernel/workqueue.c:3400
 kthread+0x7a9/0x920 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:lock_acquire+0x1c/0x550 kernel/locking/lockdep.c:5819
Code: 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 55 48 89 e5 41 57 41 56 41 55 41 54 53 48 83 e4 e0 48 81 ec 20 01 00 00 <4c> 89 4c 24 28 4c 89 44 24 38 48 89 4c 24 30 89 54 24 1c 41 89 f6
RSP: 0018:ffffc9000c1bff20 EFLAGS: 00010082
RAX: 0000000000001c08 RBX: 1ffff92001838014 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff88813fffc298
RBP: ffffc9000c1c0068 R08: 0000000000000001 R09: 0000000000000000
R10: dffffc0000000000 R11: fffffbfff2079f6f R12: 0000000000000246
R13: 1ffff92001838010 R14: ffff88813fffc280 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffc9000c1bff18 CR3: 000000002a12a000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	90                   	nop
   1:	90                   	nop
   2:	90                   	nop
   3:	90                   	nop
   4:	90                   	nop
   5:	90                   	nop
   6:	90                   	nop
   7:	90                   	nop
   8:	90                   	nop
   9:	90                   	nop
   a:	90                   	nop
   b:	90                   	nop
   c:	90                   	nop
   d:	90                   	nop
   e:	f3 0f 1e fa          	endbr64
  12:	55                   	push   %rbp
  13:	48 89 e5             	mov    %rsp,%rbp
  16:	41 57                	push   %r15
  18:	41 56                	push   %r14
  1a:	41 55                	push   %r13
  1c:	41 54                	push   %r12
  1e:	53                   	push   %rbx
  1f:	48 83 e4 e0          	and    $0xffffffffffffffe0,%rsp
  23:	48 81 ec 20 01 00 00 	sub    $0x120,%rsp
* 2a:	4c 89 4c 24 28       	mov    %r9,0x28(%rsp) <-- trapping instruction
  2f:	4c 89 44 24 38       	mov    %r8,0x38(%rsp)
  34:	48 89 4c 24 30       	mov    %rcx,0x30(%rsp)
  39:	89 54 24 1c          	mov    %edx,0x1c(%rsp)
  3d:	41 89 f6             	mov    %esi,%r14d


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


Return-Path: <netdev+bounces-194559-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C230DACA9FE
	for <lists+netdev@lfdr.de>; Mon,  2 Jun 2025 09:40:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7FDD189BD3F
	for <lists+netdev@lfdr.de>; Mon,  2 Jun 2025 07:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90AB81AED5C;
	Mon,  2 Jun 2025 07:40:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879581A238E
	for <netdev@vger.kernel.org>; Mon,  2 Jun 2025 07:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748850034; cv=none; b=DALJ38u2ZgQUsVhjk+m1qNHTgimSgcU81ydRDJQ60LWXr6itknekqFeCyI3NIAanUjRuX0B+4ceHgMCWRIQCWA4wlT0Eqs3JL5Jhygt+4ZaPQgmSP20CaGHC0aQD2Ik+jY9gAGteamrTyoRwDusHqWBdvNI3m5y4TduMXcUJ6/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748850034; c=relaxed/simple;
	bh=mL451OwRCLSyd8QUkL+u0nhW8XErmdIy0CNBNEUWAZk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=V7L40ETs/HFLxOgEgMmWp1SQMsOe77m35R6tDji7TsFg9mdk8BEUTJVfDmE6iBiz3egVckLXumf1qwcccJGe7xagZAtjDjP6EZdWa5PwtmFSVggWv7NHLOVBlCNxl7SisSjspBoaIBCyMT/nlfsbFs/z95UrnPWZAZRqbEk8NgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-86cf9bad8e9so321883539f.2
        for <netdev@vger.kernel.org>; Mon, 02 Jun 2025 00:40:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748850031; x=1749454831;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZCQUnJTpocwD8iCTbWh1RKqkexvVanhQOeIANSjBMwg=;
        b=YJHoYvH6hGrsP6i0VapQ3Gew48RLmTFHa4pWpMONbcY02HkO5Zq9gGygLoE9/LmGiW
         pQjcjg+GSmeeCcYshN7hCf8QTq+JkYMGqFtO45Zah8Yi0bTO0ymKigyMyZEPHT75QYoJ
         Lf9Z8zygAAnPaT/lAfVhAqtYytmaWdX2iYnLdv668ORH/AD1i3yva7L6Xpt5j2aTcC4Q
         IM3je03NlUPAdlaMjVDe0Kz1AYvfPL3HSGvNdUma0W4KRyG1K4hxuozO/T+GWaPtKehS
         MYRjC6cgB4bq4fc3M17SIFJDp5RTWfPefL/lD3IPgyyyBH/DD1DOY0rTudjHYb+Wiydj
         L3+w==
X-Forwarded-Encrypted: i=1; AJvYcCUMVYSKtk+dN30EIQVsDhPJVPHlhzzaJ9BxCTY75OuEazVLwD3bi5pRB0iHrkrvz43FaRiJH0s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIMHm88zrU7YssculJh+eMT3bRwkZ4fOGIVG3lzeyqTgZjGYsy
	dqwVzwZBn/crtBhSR6Hc3ndPzYy3vWKpFC7zvFkvJHtaUhMFfI9vVl4IOwtDoEnAQ0A2t2kFxyo
	SiPaYWCZ8IKdfhML4Vzt+hq9J0DEoCu/tSNXA+t9N4l27d/3OA+sm3f1sTog=
X-Google-Smtp-Source: AGHT+IE8Suin7637ORjoJeH3sTburMZ6FlCLViwoJ4QH3604AaqBx9IDcqJEGwN2sUK2jQCz4N3VuZIl9V3ZGwXe8rjcFwnNR2R1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a5e:d80d:0:b0:86d:9ec4:effe with SMTP id
 ca18e2360f4ac-86d9ec4f55emr486642739f.8.1748850031580; Mon, 02 Jun 2025
 00:40:31 -0700 (PDT)
Date: Mon, 02 Jun 2025 00:40:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <683d556f.a00a0220.d8eae.0046.GAE@google.com>
Subject: [syzbot] [net?] possible deadlock in dev_set_promiscuity
From: syzbot <syzbot+58c65777e7d41ac833a9@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    90b83efa6701 Merge tag 'bpf-next-6.16' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=135adbf4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=262b2977ef00756b
dashboard link: https://syzkaller.appspot.com/bug?extid=58c65777e7d41ac833a9
compiler:       Debian clang version 20.1.6 (++20250514063057+1e4d39e07757-1~exp1~20250514183223.118), Debian LLD 20.1.6
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/2dccf70158c7/disk-90b83efa.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e7a2b208c541/vmlinux-90b83efa.xz
kernel image: https://storage.googleapis.com/syzbot-assets/022501a5f90a/bzImage-90b83efa.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+58c65777e7d41ac833a9@syzkaller.appspotmail.com

batadv0: entered promiscuous mode
team0: entered promiscuous mode
team_slave_0: entered promiscuous mode
macvlan2: entered promiscuous mode
bond0: entered promiscuous mode
======================================================
WARNING: possible circular locking dependency detected
6.15.0-syzkaller-07774-g90b83efa6701 #0 Not tainted
------------------------------------------------------
syz.1.1497/11860 is trying to acquire lock:
ffff8880314e4d30 (&dev_instance_lock_key#20){+.+.}-{4:4}, at: netdev_lock include/linux/netdevice.h:2756 [inline]
ffff8880314e4d30 (&dev_instance_lock_key#20){+.+.}-{4:4}, at: netdev_lock_ops include/net/netdev_lock.h:42 [inline]
ffff8880314e4d30 (&dev_instance_lock_key#20){+.+.}-{4:4}, at: dev_set_promiscuity+0x10e/0x260 net/core/dev_api.c:286

but task is already holding lock:
ffff88805cd74e00 (team->team_lock_key#5){+.+.}-{4:4}, at: team_change_rx_flags+0x38/0x220 drivers/net/team/team_core.c:1781

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (team->team_lock_key#5){+.+.}-{4:4}:
       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5871
       __mutex_lock_common kernel/locking/mutex.c:601 [inline]
       __mutex_lock+0x182/0xe80 kernel/locking/mutex.c:746
       team_port_change_check drivers/net/team/team_core.c:2966 [inline]
       team_device_event+0x182/0xa20 drivers/net/team/team_core.c:2992
       notifier_call_chain+0x1b3/0x3e0 kernel/notifier.c:85
       call_netdevice_notifiers_extack net/core/dev.c:2268 [inline]
       call_netdevice_notifiers net/core/dev.c:2282 [inline]
       dev_close_many+0x29c/0x410 net/core/dev.c:1785
       vlan_device_event+0x1748/0x1d00 net/8021q/vlan.c:449
       notifier_call_chain+0x1b3/0x3e0 kernel/notifier.c:85
       call_netdevice_notifiers_extack net/core/dev.c:2268 [inline]
       call_netdevice_notifiers net/core/dev.c:2282 [inline]
       __dev_notify_flags+0x18d/0x2e0 net/core/dev.c:-1
       netif_change_flags+0xe8/0x1a0 net/core/dev.c:9526
       do_setlink+0xc55/0x41c0 net/core/rtnetlink.c:3141
       rtnl_changelink net/core/rtnetlink.c:3759 [inline]
       __rtnl_newlink net/core/rtnetlink.c:3918 [inline]
       rtnl_newlink+0x160b/0x1c70 net/core/rtnetlink.c:4055
       rtnetlink_rcv_msg+0x7cf/0xb70 net/core/rtnetlink.c:6944
       netlink_rcv_skb+0x205/0x470 net/netlink/af_netlink.c:2534
       netlink_unicast_kernel net/netlink/af_netlink.c:1313 [inline]
       netlink_unicast+0x758/0x8d0 net/netlink/af_netlink.c:1339
       netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1883
       sock_sendmsg_nosec net/socket.c:712 [inline]
       __sock_sendmsg+0x219/0x270 net/socket.c:727
       ____sys_sendmsg+0x505/0x830 net/socket.c:2566
       ___sys_sendmsg+0x21f/0x2a0 net/socket.c:2620
       __sys_sendmsg+0x164/0x220 net/socket.c:2652
       do_syscall_32_irqs_on arch/x86/entry/syscall_32.c:83 [inline]
       __do_fast_syscall_32+0xb6/0x2b0 arch/x86/entry/syscall_32.c:306
       do_fast_syscall_32+0x34/0x80 arch/x86/entry/syscall_32.c:331
       entry_SYSENTER_compat_after_hwframe+0x84/0x8e

-> #0 (&dev_instance_lock_key#20){+.+.}-{4:4}:
       check_prev_add kernel/locking/lockdep.c:3168 [inline]
       check_prevs_add kernel/locking/lockdep.c:3287 [inline]
       validate_chain+0xb9b/0x2140 kernel/locking/lockdep.c:3911
       __lock_acquire+0xab9/0xd20 kernel/locking/lockdep.c:5240
       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5871
       __mutex_lock_common kernel/locking/mutex.c:601 [inline]
       __mutex_lock+0x182/0xe80 kernel/locking/mutex.c:746
       netdev_lock include/linux/netdevice.h:2756 [inline]
       netdev_lock_ops include/net/netdev_lock.h:42 [inline]
       dev_set_promiscuity+0x10e/0x260 net/core/dev_api.c:286
       bond_set_promiscuity drivers/net/bonding/bond_main.c:919 [inline]
       bond_change_rx_flags+0x219/0x690 drivers/net/bonding/bond_main.c:4738
       dev_change_rx_flags net/core/dev.c:9241 [inline]
       __dev_set_promiscuity+0x534/0x740 net/core/dev.c:9285
       netif_set_promiscuity+0x50/0xe0 net/core/dev.c:9305
       dev_set_promiscuity+0x126/0x260 net/core/dev_api.c:287
       dev_change_rx_flags net/core/dev.c:9241 [inline]
       __dev_set_promiscuity+0x534/0x740 net/core/dev.c:9285
       netif_set_promiscuity+0x50/0xe0 net/core/dev.c:9305
       dev_set_promiscuity+0x126/0x260 net/core/dev_api.c:287
       team_change_rx_flags+0x123/0x220 drivers/net/team/team_core.c:1785
       dev_change_rx_flags net/core/dev.c:9241 [inline]
       __dev_set_promiscuity+0x534/0x740 net/core/dev.c:9285
       netif_set_promiscuity+0x50/0xe0 net/core/dev.c:9305
       dev_set_promiscuity+0x126/0x260 net/core/dev_api.c:287
       hsr_portdev_setup net/hsr/hsr_slave.c:148 [inline]
       hsr_add_port+0x549/0x890 net/hsr/hsr_slave.c:202
       hsr_dev_finalize+0x6c4/0xaa0 net/hsr/hsr_device.c:760
       hsr_newlink+0x7d7/0x940 net/hsr/hsr_netlink.c:122
       rtnl_newlink_create+0x310/0xb00 net/core/rtnetlink.c:3823
       __rtnl_newlink net/core/rtnetlink.c:3940 [inline]
       rtnl_newlink+0x16d6/0x1c70 net/core/rtnetlink.c:4055
       rtnetlink_rcv_msg+0x7cf/0xb70 net/core/rtnetlink.c:6944
       netlink_rcv_skb+0x205/0x470 net/netlink/af_netlink.c:2534
       netlink_unicast_kernel net/netlink/af_netlink.c:1313 [inline]
       netlink_unicast+0x758/0x8d0 net/netlink/af_netlink.c:1339
       netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1883
       sock_sendmsg_nosec net/socket.c:712 [inline]
       __sock_sendmsg+0x219/0x270 net/socket.c:727
       ____sys_sendmsg+0x505/0x830 net/socket.c:2566
       ___sys_sendmsg+0x21f/0x2a0 net/socket.c:2620
       __sys_sendmsg+0x164/0x220 net/socket.c:2652
       do_syscall_32_irqs_on arch/x86/entry/syscall_32.c:83 [inline]
       __do_fast_syscall_32+0xb6/0x2b0 arch/x86/entry/syscall_32.c:306
       do_fast_syscall_32+0x34/0x80 arch/x86/entry/syscall_32.c:331
       entry_SYSENTER_compat_after_hwframe+0x84/0x8e

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(team->team_lock_key#5);
                               lock(&dev_instance_lock_key#20);
                               lock(team->team_lock_key#5);
  lock(&dev_instance_lock_key#20);

 *** DEADLOCK ***

3 locks held by syz.1.1497/11860:
 #0: ffffffff8fa2cd70 (&ops->srcu#2){.+.+}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 #0: ffffffff8fa2cd70 (&ops->srcu#2){.+.+}-{0:0}, at: rcu_read_lock include/linux/rcupdate.h:841 [inline]
 #0: ffffffff8fa2cd70 (&ops->srcu#2){.+.+}-{0:0}, at: rtnl_link_ops_get+0x23/0x250 net/core/rtnetlink.c:570
 #1: ffffffff8f50a808 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_lock net/core/rtnetlink.c:80 [inline]
 #1: ffffffff8f50a808 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_nets_lock net/core/rtnetlink.c:341 [inline]
 #1: ffffffff8f50a808 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_newlink+0x8db/0x1c70 net/core/rtnetlink.c:4054
 #2: ffff88805cd74e00 (team->team_lock_key#5){+.+.}-{4:4}, at: team_change_rx_flags+0x38/0x220 drivers/net/team/team_core.c:1781

stack backtrace:
CPU: 1 UID: 0 PID: 11860 Comm: syz.1.1497 Not tainted 6.15.0-syzkaller-07774-g90b83efa6701 #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_circular_bug+0x2ee/0x310 kernel/locking/lockdep.c:2046
 check_noncircular+0x134/0x160 kernel/locking/lockdep.c:2178
 check_prev_add kernel/locking/lockdep.c:3168 [inline]
 check_prevs_add kernel/locking/lockdep.c:3287 [inline]
 validate_chain+0xb9b/0x2140 kernel/locking/lockdep.c:3911
 __lock_acquire+0xab9/0xd20 kernel/locking/lockdep.c:5240
 lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5871
 __mutex_lock_common kernel/locking/mutex.c:601 [inline]
 __mutex_lock+0x182/0xe80 kernel/locking/mutex.c:746
 netdev_lock include/linux/netdevice.h:2756 [inline]
 netdev_lock_ops include/net/netdev_lock.h:42 [inline]
 dev_set_promiscuity+0x10e/0x260 net/core/dev_api.c:286
 bond_set_promiscuity drivers/net/bonding/bond_main.c:919 [inline]
 bond_change_rx_flags+0x219/0x690 drivers/net/bonding/bond_main.c:4738
 dev_change_rx_flags net/core/dev.c:9241 [inline]
 __dev_set_promiscuity+0x534/0x740 net/core/dev.c:9285
 netif_set_promiscuity+0x50/0xe0 net/core/dev.c:9305
 dev_set_promiscuity+0x126/0x260 net/core/dev_api.c:287
 dev_change_rx_flags net/core/dev.c:9241 [inline]
 __dev_set_promiscuity+0x534/0x740 net/core/dev.c:9285
 netif_set_promiscuity+0x50/0xe0 net/core/dev.c:9305
 dev_set_promiscuity+0x126/0x260 net/core/dev_api.c:287
 team_change_rx_flags+0x123/0x220 drivers/net/team/team_core.c:1785
 dev_change_rx_flags net/core/dev.c:9241 [inline]
 __dev_set_promiscuity+0x534/0x740 net/core/dev.c:9285
 netif_set_promiscuity+0x50/0xe0 net/core/dev.c:9305
 dev_set_promiscuity+0x126/0x260 net/core/dev_api.c:287
 hsr_portdev_setup net/hsr/hsr_slave.c:148 [inline]
 hsr_add_port+0x549/0x890 net/hsr/hsr_slave.c:202
 hsr_dev_finalize+0x6c4/0xaa0 net/hsr/hsr_device.c:760
 hsr_newlink+0x7d7/0x940 net/hsr/hsr_netlink.c:122
 rtnl_newlink_create+0x310/0xb00 net/core/rtnetlink.c:3823
 __rtnl_newlink net/core/rtnetlink.c:3940 [inline]
 rtnl_newlink+0x16d6/0x1c70 net/core/rtnetlink.c:4055
 rtnetlink_rcv_msg+0x7cf/0xb70 net/core/rtnetlink.c:6944
 netlink_rcv_skb+0x205/0x470 net/netlink/af_netlink.c:2534
 netlink_unicast_kernel net/netlink/af_netlink.c:1313 [inline]
 netlink_unicast+0x758/0x8d0 net/netlink/af_netlink.c:1339
 netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1883
 sock_sendmsg_nosec net/socket.c:712 [inline]
 __sock_sendmsg+0x219/0x270 net/socket.c:727
 ____sys_sendmsg+0x505/0x830 net/socket.c:2566
 ___sys_sendmsg+0x21f/0x2a0 net/socket.c:2620
 __sys_sendmsg+0x164/0x220 net/socket.c:2652
 do_syscall_32_irqs_on arch/x86/entry/syscall_32.c:83 [inline]
 __do_fast_syscall_32+0xb6/0x2b0 arch/x86/entry/syscall_32.c:306
 do_fast_syscall_32+0x34/0x80 arch/x86/entry/syscall_32.c:331
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e
RIP: 0023:0xf705e539
Code: 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 002b:00000000f504e55c EFLAGS: 00000206 ORIG_RAX: 0000000000000172
RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 0000000080000280
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000206 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
vlan2: entered promiscuous mode
debugfs: Directory 'hsr1' with parent 'hsr' already present!
Cannot create hsr debugfs directory
hsr1: entered promiscuous mode
hsr1: entered allmulticast mode
batadv0: entered allmulticast mode
team0: entered allmulticast mode
team_slave_0: entered allmulticast mode
syz.1.1497 (11860) used greatest stack depth: 19568 bytes left
----------------
Code disassembly (best guess):
   0:	03 74 b4 01          	add    0x1(%rsp,%rsi,4),%esi
   4:	10 07                	adc    %al,(%rdi)
   6:	03 74 b0 01          	add    0x1(%rax,%rsi,4),%esi
   a:	10 08                	adc    %cl,(%rax)
   c:	03 74 d8 01          	add    0x1(%rax,%rbx,8),%esi
  20:	00 51 52             	add    %dl,0x52(%rcx)
  23:	55                   	push   %rbp
  24:	89 e5                	mov    %esp,%ebp
  26:	0f 34                	sysenter
  28:	cd 80                	int    $0x80
* 2a:	5d                   	pop    %rbp <-- trapping instruction
  2b:	5a                   	pop    %rdx
  2c:	59                   	pop    %rcx
  2d:	c3                   	ret
  2e:	90                   	nop
  2f:	90                   	nop
  30:	90                   	nop
  31:	90                   	nop
  32:	90                   	nop
  33:	90                   	nop
  34:	90                   	nop
  35:	90                   	nop
  36:	90                   	nop
  37:	90                   	nop
  38:	90                   	nop
  39:	90                   	nop
  3a:	90                   	nop
  3b:	90                   	nop
  3c:	90                   	nop
  3d:	90                   	nop
  3e:	90                   	nop
  3f:	90                   	nop


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


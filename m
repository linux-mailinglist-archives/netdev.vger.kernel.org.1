Return-Path: <netdev+bounces-197925-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61AD6ADA57D
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 03:21:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E89C616C461
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 01:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB9CC12DDA1;
	Mon, 16 Jun 2025 01:21:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33D38528E
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 01:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750036893; cv=none; b=iHjIObgnAbftLL+Pm6/KnXpeyCp3h9XLvoZTAxVhBnbYeF9AZ8fW0qN9BV1A8ZVhkgI5EUmoPN70N2ST8b/rbqqLg+h7fyooUJFUkuvHuW5zS6RsM5fkcEHY0OKnniZXDZLXZRRGvV8AmlWZyoWWSOwwyZFGvSdvylAXgLTZE7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750036893; c=relaxed/simple;
	bh=rT2z1M3ert7qw9Wn2QA8qckidORW36Usrm8/+NAp2sI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=LNVQjwna+ec7pjEkG+hg3zhmbNxPhYvWoLmLA0dSOyX9l2AK+WLHp7hmcNMATdSrY3id9A3zqyN4FlSaYfOs9dtfmwEU1S+SV7dU/SMZQ5kqa/baNbmW+X10uOQ5Mgy6rVwRWGc8aYoX18Im10DINMvHzxE41w4fETCTS9INldU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3ddc9e145daso65543635ab.2
        for <netdev@vger.kernel.org>; Sun, 15 Jun 2025 18:21:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750036891; x=1750641691;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sFAx0H9XBlen1wyT9im+mSE+7TS1KxEcw8TBr3kLre4=;
        b=Wlb4L9tUjxZ+6kdCbCYFo4S9HtDpGwIrchbKVnElwWbt4tAi17kvX4sHF5IabRsd7F
         UEXjD7VlEuJbzrYt7loztMiDI8k3Wvh2gnk31Lw4Tvcg0xB0fyIjCWN7G6lFfplao+4s
         n3nMQ4PydlV5Z3Pe0fhsgOMg9lPHNoFqtEUbXNh0YJTGQvI/ZnPPVvy/4mu3qLPRNG4x
         i7Fav2mTyYyDs9GUZnnkC1zFeBkIekP55mPrzhaWjYEDN4uofN+8nfJFkOaaN6pbLiiA
         iAmleFSh31oGKjRF/YYhUMx5bEKORq73FXFjrAxixXnbQAuvc/d8HZYmR9RAETyI4JFg
         16ag==
X-Forwarded-Encrypted: i=1; AJvYcCUSWaiErEVmJrwZDjLChoCxqKOTOdV/9lqrJZCcDUZkS64SgChDGS4SnySM/+eH0fFi09FZTl4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9NLYyzjib1YIZEIbVJ6eNoJHDWR293AyGVvLLoIP0LgkQpn9+
	CfMyv3k9W/ipwjCzfnJItF7v+ptUxIzAaZdfINZo6wxi0olKNJ678hQhfugmTisRFD/855TWMvc
	17CFkgWH8LC3XC6Ihl73ZbBoxP6VTaHYcbXzAUzZmrXxQLYIWLp81kOLRxnE=
X-Google-Smtp-Source: AGHT+IFT9Wf8tP6cHL+8ecZzjsWd76lg1BTbIO7APpvqR5/LW9PBtV/+RY1iNlC3z/uirew67S4jJRFSbtyffss3k41RK5ChSgow
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1541:b0:3dd:d6c2:51fb with SMTP id
 e9e14a558f8ab-3de07cc0d4fmr75126515ab.10.1750036890872; Sun, 15 Jun 2025
 18:21:30 -0700 (PDT)
Date: Sun, 15 Jun 2025 18:21:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <684f719a.a00a0220.279073.0035.GAE@google.com>
Subject: [syzbot] [net?] possible deadlock in dev_set_allmulti (2)
From: syzbot <syzbot+71fd22ae4b81631e22fd@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    488ef3560196 KEYS: Invert FINAL_PUT bit
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15ec3682580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=89df02a4e09cb64d
dashboard link: https://syzkaller.appspot.com/bug?extid=71fd22ae4b81631e22fd
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/7b039b16a4b3/disk-488ef356.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3663fcbac4af/vmlinux-488ef356.xz
kernel image: https://storage.googleapis.com/syzbot-assets/1941fbd3eaca/bzImage-488ef356.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+71fd22ae4b81631e22fd@syzkaller.appspotmail.com

team_slave_0: entered allmulticast mode
team_slave_1: entered allmulticast mode
vlan2: entered allmulticast mode
======================================================
WARNING: possible circular locking dependency detected
6.16.0-rc1-syzkaller-00005-g488ef3560196 #0 Not tainted
------------------------------------------------------
syz.1.880/9004 is trying to acquire lock:
ffff888058130d30 (&dev_instance_lock_key#20){+.+.}-{4:4}, at: netdev_lock include/linux/netdevice.h:2756 [inline]
ffff888058130d30 (&dev_instance_lock_key#20){+.+.}-{4:4}, at: netdev_lock_ops include/net/netdev_lock.h:42 [inline]
ffff888058130d30 (&dev_instance_lock_key#20){+.+.}-{4:4}, at: netdev_lock_ops include/net/netdev_lock.h:39 [inline]
ffff888058130d30 (&dev_instance_lock_key#20){+.+.}-{4:4}, at: dev_set_allmulti+0xa2/0x260 net/core/dev_api.c:312

but task is already holding lock:
ffff88805a2b4e00 (team->team_lock_key#5){+.+.}-{4:4}, at: team_change_rx_flags+0x39/0x220 drivers/net/team/team_core.c:1781

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (team->team_lock_key#5){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/mutex.c:602 [inline]
       __mutex_lock+0x199/0xb90 kernel/locking/mutex.c:747
       team_port_change_check drivers/net/team/team_core.c:2966 [inline]
       team_device_event+0x11d/0x770 drivers/net/team/team_core.c:2992
       notifier_call_chain+0xbc/0x410 kernel/notifier.c:85
       call_netdevice_notifiers_info+0xbe/0x140 net/core/dev.c:2230
       call_netdevice_notifiers_extack net/core/dev.c:2268 [inline]
       call_netdevice_notifiers net/core/dev.c:2282 [inline]
       dev_close_many+0x319/0x630 net/core/dev.c:1785
       vlan_device_event+0x1555/0x2290 net/8021q/vlan.c:449
       notifier_call_chain+0xbc/0x410 kernel/notifier.c:85
       call_netdevice_notifiers_info+0xbe/0x140 net/core/dev.c:2230
       call_netdevice_notifiers_extack net/core/dev.c:2268 [inline]
       call_netdevice_notifiers net/core/dev.c:2282 [inline]
       __dev_notify_flags+0x1f7/0x2e0 net/core/dev.c:9499
       netif_change_flags+0x108/0x160 net/core/dev.c:9526
       do_setlink.constprop.0+0xb53/0x4380 net/core/rtnetlink.c:3141
       rtnl_group_changelink net/core/rtnetlink.c:3773 [inline]
       __rtnl_newlink net/core/rtnetlink.c:3927 [inline]
       rtnl_newlink+0x18e0/0x2000 net/core/rtnetlink.c:4055
       rtnetlink_rcv_msg+0x95b/0xe90 net/core/rtnetlink.c:6944
       netlink_rcv_skb+0x155/0x420 net/netlink/af_netlink.c:2534
       netlink_unicast_kernel net/netlink/af_netlink.c:1313 [inline]
       netlink_unicast+0x53d/0x7f0 net/netlink/af_netlink.c:1339
       netlink_sendmsg+0x8d1/0xdd0 net/netlink/af_netlink.c:1883
       sock_sendmsg_nosec net/socket.c:712 [inline]
       __sock_sendmsg net/socket.c:727 [inline]
       ____sys_sendmsg+0xa98/0xc70 net/socket.c:2566
       ___sys_sendmsg+0x134/0x1d0 net/socket.c:2620
       __sys_sendmsg+0x16d/0x220 net/socket.c:2652
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xcd/0x4c0 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (&dev_instance_lock_key#20){+.+.}-{4:4}:
       check_prev_add kernel/locking/lockdep.c:3168 [inline]
       check_prevs_add kernel/locking/lockdep.c:3287 [inline]
       validate_chain kernel/locking/lockdep.c:3911 [inline]
       __lock_acquire+0x126f/0x1c90 kernel/locking/lockdep.c:5240
       lock_acquire kernel/locking/lockdep.c:5871 [inline]
       lock_acquire+0x179/0x350 kernel/locking/lockdep.c:5828
       __mutex_lock_common kernel/locking/mutex.c:602 [inline]
       __mutex_lock+0x199/0xb90 kernel/locking/mutex.c:747
       netdev_lock include/linux/netdevice.h:2756 [inline]
       netdev_lock_ops include/net/netdev_lock.h:42 [inline]
       netdev_lock_ops include/net/netdev_lock.h:39 [inline]
       dev_set_allmulti+0xa2/0x260 net/core/dev_api.c:312
       vlan_dev_change_rx_flags+0xb6/0x150 net/8021q/vlan_dev.c:472
       dev_change_rx_flags net/core/dev.c:9241 [inline]
       netif_set_allmulti+0x206/0x3d0 net/core/dev.c:9339
       dev_set_allmulti+0xb7/0x260 net/core/dev_api.c:313
       team_change_rx_flags+0x188/0x220 drivers/net/team/team_core.c:1789
       dev_change_rx_flags net/core/dev.c:9241 [inline]
       netif_set_allmulti+0x206/0x3d0 net/core/dev.c:9339
       __dev_change_flags+0x3d0/0x720 net/core/dev.c:9480
       netif_change_flags+0x8d/0x160 net/core/dev.c:9521
       do_setlink.constprop.0+0xb53/0x4380 net/core/rtnetlink.c:3141
       rtnl_group_changelink net/core/rtnetlink.c:3773 [inline]
       __rtnl_newlink net/core/rtnetlink.c:3927 [inline]
       rtnl_newlink+0x18e0/0x2000 net/core/rtnetlink.c:4055
       rtnetlink_rcv_msg+0x95b/0xe90 net/core/rtnetlink.c:6944
       netlink_rcv_skb+0x155/0x420 net/netlink/af_netlink.c:2534
       netlink_unicast_kernel net/netlink/af_netlink.c:1313 [inline]
       netlink_unicast+0x53d/0x7f0 net/netlink/af_netlink.c:1339
       netlink_sendmsg+0x8d1/0xdd0 net/netlink/af_netlink.c:1883
       sock_sendmsg_nosec net/socket.c:712 [inline]
       __sock_sendmsg net/socket.c:727 [inline]
       ____sys_sendmsg+0xa98/0xc70 net/socket.c:2566
       ___sys_sendmsg+0x134/0x1d0 net/socket.c:2620
       __sys_sendmsg+0x16d/0x220 net/socket.c:2652
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xcd/0x4c0 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(team->team_lock_key#5);
                               lock(&dev_instance_lock_key#20);
                               lock(team->team_lock_key#5);
  lock(&dev_instance_lock_key#20);

 *** DEADLOCK ***

2 locks held by syz.1.880/9004:
 #0: ffffffff9034cbe8 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_lock net/core/rtnetlink.c:80 [inline]
 #0: ffffffff9034cbe8 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_nets_lock net/core/rtnetlink.c:341 [inline]
 #0: ffffffff9034cbe8 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_newlink+0x600/0x2000 net/core/rtnetlink.c:4054
 #1: ffff88805a2b4e00 (team->team_lock_key#5){+.+.}-{4:4}, at: team_change_rx_flags+0x39/0x220 drivers/net/team/team_core.c:1781

stack backtrace:
CPU: 0 UID: 0 PID: 9004 Comm: syz.1.880 Not tainted 6.16.0-rc1-syzkaller-00005-g488ef3560196 #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_circular_bug+0x275/0x350 kernel/locking/lockdep.c:2046
 check_noncircular+0x14c/0x170 kernel/locking/lockdep.c:2178
 check_prev_add kernel/locking/lockdep.c:3168 [inline]
 check_prevs_add kernel/locking/lockdep.c:3287 [inline]
 validate_chain kernel/locking/lockdep.c:3911 [inline]
 __lock_acquire+0x126f/0x1c90 kernel/locking/lockdep.c:5240
 lock_acquire kernel/locking/lockdep.c:5871 [inline]
 lock_acquire+0x179/0x350 kernel/locking/lockdep.c:5828
 __mutex_lock_common kernel/locking/mutex.c:602 [inline]
 __mutex_lock+0x199/0xb90 kernel/locking/mutex.c:747
 netdev_lock include/linux/netdevice.h:2756 [inline]
 netdev_lock_ops include/net/netdev_lock.h:42 [inline]
 netdev_lock_ops include/net/netdev_lock.h:39 [inline]
 dev_set_allmulti+0xa2/0x260 net/core/dev_api.c:312
 vlan_dev_change_rx_flags+0xb6/0x150 net/8021q/vlan_dev.c:472
 dev_change_rx_flags net/core/dev.c:9241 [inline]
 netif_set_allmulti+0x206/0x3d0 net/core/dev.c:9339
 dev_set_allmulti+0xb7/0x260 net/core/dev_api.c:313
 team_change_rx_flags+0x188/0x220 drivers/net/team/team_core.c:1789
 dev_change_rx_flags net/core/dev.c:9241 [inline]
 netif_set_allmulti+0x206/0x3d0 net/core/dev.c:9339
 __dev_change_flags+0x3d0/0x720 net/core/dev.c:9480
 netif_change_flags+0x8d/0x160 net/core/dev.c:9521
 do_setlink.constprop.0+0xb53/0x4380 net/core/rtnetlink.c:3141
 rtnl_group_changelink net/core/rtnetlink.c:3773 [inline]
 __rtnl_newlink net/core/rtnetlink.c:3927 [inline]
 rtnl_newlink+0x18e0/0x2000 net/core/rtnetlink.c:4055
 rtnetlink_rcv_msg+0x95b/0xe90 net/core/rtnetlink.c:6944
 netlink_rcv_skb+0x155/0x420 net/netlink/af_netlink.c:2534
 netlink_unicast_kernel net/netlink/af_netlink.c:1313 [inline]
 netlink_unicast+0x53d/0x7f0 net/netlink/af_netlink.c:1339
 netlink_sendmsg+0x8d1/0xdd0 net/netlink/af_netlink.c:1883
 sock_sendmsg_nosec net/socket.c:712 [inline]
 __sock_sendmsg net/socket.c:727 [inline]
 ____sys_sendmsg+0xa98/0xc70 net/socket.c:2566
 ___sys_sendmsg+0x134/0x1d0 net/socket.c:2620
 __sys_sendmsg+0x16d/0x220 net/socket.c:2652
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x4c0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f32b0f8e929
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f32b1d85038 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f32b11b5fa0 RCX: 00007f32b0f8e929
RDX: 0000000000000000 RSI: 0000200000000140 RDI: 0000000000000005
RBP: 00007f32b1010b39 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f32b11b5fa0 R15: 00007ffcfc6d21c8
 </TASK>
netdevsim netdevsim1 netdevsim0: entered allmulticast mode
dummy0: entered allmulticast mode
nlmon0: entered allmulticast mode
caif0: entered allmulticast mode
vxcan0: entered allmulticast mode
vxcan1: entered allmulticast mode
veth0: entered allmulticast mode
veth1: entered allmulticast mode
wg0: entered allmulticast mode
wg1: entered allmulticast mode
wg2: entered allmulticast mode
veth0_to_bridge: entered allmulticast mode
veth1_to_bridge: entered allmulticast mode
veth0_to_bond: entered allmulticast mode
veth1_to_bond: entered allmulticast mode
veth0_to_team: entered allmulticast mode
veth1_to_team: entered allmulticast mode
veth0_to_batadv: entered allmulticast mode
batadv_slave_0: entered allmulticast mode
veth1_to_batadv: entered allmulticast mode
batadv_slave_1: entered allmulticast mode
xfrm0: entered allmulticast mode
veth0_to_hsr: entered allmulticast mode
hsr_slave_0: entered allmulticast mode
veth1_to_hsr: entered allmulticast mode
hsr_slave_1: entered allmulticast mode
hsr0: entered allmulticast mode
veth1_virt_wifi: entered allmulticast mode
veth0_virt_wifi: entered allmulticast mode
net veth1_virt_wifi virt_wifi0: entered allmulticast mode
veth1_vlan: entered allmulticast mode
veth0_vlan: entered allmulticast mode
vlan0: entered allmulticast mode
vlan1: entered allmulticast mode
macvlan0: entered allmulticast mode
macvlan1: entered allmulticast mode
ipvlan0: entered allmulticast mode
ipvlan1: entered allmulticast mode
veth1_macvtap: entered allmulticast mode
veth0_macvtap: entered allmulticast mode
macvtap0: entered allmulticast mode
macsec0: entered allmulticast mode
geneve0: entered allmulticast mode
geneve1: entered allmulticast mode
netdevsim netdevsim1 netdevsim1: entered allmulticast mode
netdevsim netdevsim1 netdevsim2: entered allmulticast mode
netdevsim netdevsim1 netdevsim3: entered allmulticast mode
mac80211_hwsim hwsim6 wlan0: entered allmulticast mode
mac80211_hwsim hwsim7 wlan1: entered allmulticast mode
syztnl1: entered allmulticast mode
vxlan0: entered allmulticast mode
bond3: entered allmulticast mode
bridge1: entered allmulticast mode
macsec1: entered allmulticast mode


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


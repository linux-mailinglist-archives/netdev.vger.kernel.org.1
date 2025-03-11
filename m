Return-Path: <netdev+bounces-173967-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 281B3A5CAFC
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 17:36:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C38C3B84E9
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 16:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED69B260A29;
	Tue, 11 Mar 2025 16:36:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63BFE25E836
	for <netdev@vger.kernel.org>; Tue, 11 Mar 2025 16:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741710991; cv=none; b=FnuHjMvILCyjpVcu6yUf64CzSxWnmtF9BAWBWx5783DLeX/9smrAAm1CAZ/3Ca7NVOdBAQ3yn3Lfskjc3b0aS3zoXhQcxs6Ht5W4++eyVegyCU+jV25pHDH7T0Ui3zP1LD6xxnUWwHjrrrE4eWx657leUEfjLrnCLbJ6Y0iA/xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741710991; c=relaxed/simple;
	bh=kzsNf4Zh01vd/TyJCB4EywREqHBCieiYgS6TZhj0xjk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=MCbCBMXjHSt+DAskoQd65SGqohcd75iGzfXwJo6s5/FPIG5rrgQ/xcB1htowh90fou5CcrcZcj8fssu3u1KftnSGdft450N90YqDUUVjQ49zBCAkiD04GBmfin8xS8wLgp0EFSGrJV/OlaDCB/SICKtIaMz02gaFToKQJlk7foU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-85b3f480d86so277727139f.3
        for <netdev@vger.kernel.org>; Tue, 11 Mar 2025 09:36:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741710986; x=1742315786;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XvDG1mCBdvd+lGzYgqi++Uw9Xu55XL3uw7OiqAbhe0A=;
        b=isg+JOFMan8s/sFp7agsWwdn5OSuNNHPkRIOGWpDpDgXWhTFJOT9IDVFYuTzlKbb0c
         c3sh0q6bfjHNM3GrM4JUHiDLRtXWvqtDKoCjY0Fh/QJJyHuaIRNoeAwkN/70xk+WmA50
         g0uHBGEBiiE0WGflwrOdy1KBXot5ZsyOwTnKRl87LXdlhMCQAfSIPUigE/u0aGzKkC6P
         CKJhKtUfabgUldQARyfiU6r9FYEJ4xFLfCllhIEjYKsoBN1ZqsDVxCpDOfOJHu13kclW
         OOSxw/ASk8GY8eLRyfHEAFvaGWyNG3IbWl5VFnYvwo4pyrcbSrPdfFL10uzKUj37Li67
         f76Q==
X-Forwarded-Encrypted: i=1; AJvYcCVFDuuPY+46puuXT85ayqdM4CeSjxBEAslnPAcriwXZez9ZYQv8z6+Xcc49us9I3j6UM951Kkc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzF1TfFzcFOMMg+mz+tXdAK/zN9q1kG+N9amyS74qISnNuh5lZb
	8i+Y5+Y5Tv/sTI1XelrearZB8gnSdy8U7wxmoFMXskUArT/JGnNebk48cXYcMjWEhQOCzIk+f4H
	MXij8gksL4ULbguLhMc77vYo/9Ifc+A6iZe/dLygKnkM0Yhw4RK3pCz4=
X-Google-Smtp-Source: AGHT+IEfX9x+iBRZb3hHXs/UHwzEA12kSN+kgazwubNySu1w6G9xMW49KjcbBSj+faWTOuavJczGxHPIBuyutzMaxuwkCucnNL+w
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1749:b0:3d1:968a:6d46 with SMTP id
 e9e14a558f8ab-3d44196905fmr172740425ab.6.1741710986471; Tue, 11 Mar 2025
 09:36:26 -0700 (PDT)
Date: Tue, 11 Mar 2025 09:36:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67d0668a.050a0220.1939a6.0028.GAE@google.com>
Subject: [syzbot] [net?] BUG: sleeping function called from invalid context in dev_set_allmulti
From: syzbot <syzbot+368054937a6a7ead5f35@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    40587f749df2 Merge branch 'enic-enable-32-64-byte-cqes-and..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=16b35478580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ca99d9d1f4a8ecfa
dashboard link: https://syzkaller.appspot.com/bug?extid=368054937a6a7ead5f35
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/6d02993a9211/disk-40587f74.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2c8b300bf362/vmlinux-40587f74.xz
kernel image: https://storage.googleapis.com/syzbot-assets/2d5be21882cf/bzImage-40587f74.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+368054937a6a7ead5f35@syzkaller.appspotmail.com

vlan2: entered allmulticast mode
bond0: entered allmulticast mode
bond_slave_0: entered allmulticast mode
bond_slave_1: entered allmulticast mode
team0: entered allmulticast mode
team_slave_0: entered allmulticast mode
team_slave_1: entered allmulticast mode
batadv0: entered allmulticast mode
BUG: sleeping function called from invalid context at kernel/locking/mutex.c:562
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 23629, name: syz.4.5165
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by syz.4.5165/23629:
 #0: ffffffff903f0bd0 (&ops->srcu#2){.+.+}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 #0: ffffffff903f0bd0 (&ops->srcu#2){.+.+}-{0:0}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffffffff903f0bd0 (&ops->srcu#2){.+.+}-{0:0}, at: rtnl_link_ops_get+0x22/0x250 net/core/rtnetlink.c:570
 #1: ffffffff8fed6908 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_lock net/core/rtnetlink.c:80 [inline]
 #1: ffffffff8fed6908 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_nets_lock net/core/rtnetlink.c:341 [inline]
 #1: ffffffff8fed6908 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_newlink+0xc4c/0x1d90 net/core/rtnetlink.c:4054
 #2: ffffffff8eb392e0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 #2: ffffffff8eb392e0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #2: ffffffff8eb392e0 (rcu_read_lock){....}-{1:3}, at: team_change_rx_flags+0x29/0x330 drivers/net/team/team_core.c:1781
CPU: 1 UID: 0 PID: 23629 Comm: syz.4.5165 Not tainted 6.14.0-rc5-syzkaller-01183-g40587f749df2 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 __might_resched+0x5d4/0x780 kernel/sched/core.c:8767
 __mutex_lock_common kernel/locking/mutex.c:562 [inline]
 __mutex_lock+0x126/0x1010 kernel/locking/mutex.c:730
 netdev_lock include/linux/netdevice.h:2731 [inline]
 netdev_lock_ops include/net/netdev_lock.h:40 [inline]
 dev_set_allmulti+0x11c/0x270 net/core/dev_api.c:279
 team_change_rx_flags+0x1a8/0x330 drivers/net/team/team_core.c:1789
 dev_change_rx_flags net/core/dev.c:9154 [inline]
 netif_set_allmulti+0x20e/0x380 net/core/dev.c:9256
 dev_set_allmulti+0x143/0x270 net/core/dev_api.c:280
 bond_set_allmulti drivers/net/bonding/bond_main.c:946 [inline]
 bond_change_rx_flags+0x4e1/0x6b0 drivers/net/bonding/bond_main.c:4737
 dev_change_rx_flags net/core/dev.c:9154 [inline]
 netif_set_allmulti+0x20e/0x380 net/core/dev.c:9256
 dev_set_allmulti+0x143/0x270 net/core/dev_api.c:280
 vlan_dev_open+0x2be/0x8a0 net/8021q/vlan_dev.c:278
 __dev_open+0x45a/0x8a0 net/core/dev.c:1644
 netif_open+0xae/0x1b0 net/core/dev.c:1667
 dev_open+0x13e/0x260 net/core/dev_api.c:191
 bond_enslave+0x103c/0x3910 drivers/net/bonding/bond_main.c:2135
 do_set_master+0x579/0x730 net/core/rtnetlink.c:2943
 rtnl_newlink_create+0x6e6/0xbd0 net/core/rtnetlink.c:3837
 __rtnl_newlink net/core/rtnetlink.c:3940 [inline]
 rtnl_newlink+0x167a/0x1d90 net/core/rtnetlink.c:4055
 rtnetlink_rcv_msg+0x791/0xcf0 net/core/rtnetlink.c:6945
 netlink_rcv_skb+0x206/0x480 net/netlink/af_netlink.c:2534
 netlink_unicast_kernel net/netlink/af_netlink.c:1313 [inline]
 netlink_unicast+0x7f6/0x990 net/netlink/af_netlink.c:1339
 netlink_sendmsg+0x8de/0xcb0 net/netlink/af_netlink.c:1883
 sock_sendmsg_nosec net/socket.c:709 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:724
 ____sys_sendmsg+0x53a/0x860 net/socket.c:2564
 ___sys_sendmsg net/socket.c:2618 [inline]
 __sys_sendmsg+0x269/0x350 net/socket.c:2650
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fe00998d169
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fe00a843038 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007fe009ba5fa0 RCX: 00007fe00998d169
RDX: 0000000000000000 RSI: 0000400000000280 RDI: 0000000000000003
RBP: 00007fe009a0e2a0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fe009ba5fa0 R15: 00007ffdc9be6f48
 </TASK>

=============================
[ BUG: Invalid wait context ]
6.14.0-rc5-syzkaller-01183-g40587f749df2 #0 Tainted: G        W         
-----------------------------
syz.4.5165/23629 is trying to lock:
ffff88807bce0d28 (&dev->lock){+.+.}-{4:4}, at: netdev_lock include/linux/netdevice.h:2731 [inline]
ffff88807bce0d28 (&dev->lock){+.+.}-{4:4}, at: netdev_lock_ops include/net/netdev_lock.h:40 [inline]
ffff88807bce0d28 (&dev->lock){+.+.}-{4:4}, at: dev_set_allmulti+0x11c/0x270 net/core/dev_api.c:279
other info that might help us debug this:
context-{5:5}
3 locks held by syz.4.5165/23629:
 #0: ffffffff903f0bd0 (&ops->srcu#2){.+.+}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 #0: ffffffff903f0bd0 (&ops->srcu#2){.+.+}-{0:0}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffffffff903f0bd0 (&ops->srcu#2){.+.+}-{0:0}, at: rtnl_link_ops_get+0x22/0x250 net/core/rtnetlink.c:570
 #1: ffffffff8fed6908 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_lock net/core/rtnetlink.c:80 [inline]
 #1: ffffffff8fed6908 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_nets_lock net/core/rtnetlink.c:341 [inline]
 #1: ffffffff8fed6908 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_newlink+0xc4c/0x1d90 net/core/rtnetlink.c:4054
 #2: ffffffff8eb392e0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 #2: ffffffff8eb392e0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #2: ffffffff8eb392e0 (rcu_read_lock){....}-{1:3}, at: team_change_rx_flags+0x29/0x330 drivers/net/team/team_core.c:1781
stack backtrace:
CPU: 1 UID: 0 PID: 23629 Comm: syz.4.5165 Tainted: G        W          6.14.0-rc5-syzkaller-01183-g40587f749df2 #0
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_lock_invalid_wait_context kernel/locking/lockdep.c:4828 [inline]
 check_wait_context kernel/locking/lockdep.c:4900 [inline]
 __lock_acquire+0x15a8/0x2100 kernel/locking/lockdep.c:5178
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5851
 __mutex_lock_common kernel/locking/mutex.c:585 [inline]
 __mutex_lock+0x19c/0x1010 kernel/locking/mutex.c:730
 netdev_lock include/linux/netdevice.h:2731 [inline]
 netdev_lock_ops include/net/netdev_lock.h:40 [inline]
 dev_set_allmulti+0x11c/0x270 net/core/dev_api.c:279
 team_change_rx_flags+0x1a8/0x330 drivers/net/team/team_core.c:1789
 dev_change_rx_flags net/core/dev.c:9154 [inline]
 netif_set_allmulti+0x20e/0x380 net/core/dev.c:9256
 dev_set_allmulti+0x143/0x270 net/core/dev_api.c:280
 bond_set_allmulti drivers/net/bonding/bond_main.c:946 [inline]
 bond_change_rx_flags+0x4e1/0x6b0 drivers/net/bonding/bond_main.c:4737
 dev_change_rx_flags net/core/dev.c:9154 [inline]
 netif_set_allmulti+0x20e/0x380 net/core/dev.c:9256
 dev_set_allmulti+0x143/0x270 net/core/dev_api.c:280
 vlan_dev_open+0x2be/0x8a0 net/8021q/vlan_dev.c:278
 __dev_open+0x45a/0x8a0 net/core/dev.c:1644
 netif_open+0xae/0x1b0 net/core/dev.c:1667
 dev_open+0x13e/0x260 net/core/dev_api.c:191
 bond_enslave+0x103c/0x3910 drivers/net/bonding/bond_main.c:2135
 do_set_master+0x579/0x730 net/core/rtnetlink.c:2943
 rtnl_newlink_create+0x6e6/0xbd0 net/core/rtnetlink.c:3837
 __rtnl_newlink net/core/rtnetlink.c:3940 [inline]
 rtnl_newlink+0x167a/0x1d90 net/core/rtnetlink.c:4055
 rtnetlink_rcv_msg+0x791/0xcf0 net/core/rtnetlink.c:6945
 netlink_rcv_skb+0x206/0x480 net/netlink/af_netlink.c:2534
 netlink_unicast_kernel net/netlink/af_netlink.c:1313 [inline]
 netlink_unicast+0x7f6/0x990 net/netlink/af_netlink.c:1339
 netlink_sendmsg+0x8de/0xcb0 net/netlink/af_netlink.c:1883
 sock_sendmsg_nosec net/socket.c:709 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:724
 ____sys_sendmsg+0x53a/0x860 net/socket.c:2564
 ___sys_sendmsg net/socket.c:2618 [inline]
 __sys_sendmsg+0x269/0x350 net/socket.c:2650
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fe00998d169
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fe00a843038 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007fe009ba5fa0 RCX: 00007fe00998d169
RDX: 0000000000000000 RSI: 0000400000000280 RDI: 0000000000000003
RBP: 00007fe009a0e2a0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fe009ba5fa0 R15: 00007ffdc9be6f48
 </TASK>
netdevsim netdevsim4 netdevsim0: entered allmulticast mode
bond0: left allmulticast mode
bond_slave_0: left allmulticast mode
bond_slave_1: left allmulticast mode
team0: left allmulticast mode
team_slave_0: left allmulticast mode
team_slave_1: left allmulticast mode
batadv0: left allmulticast mode
BUG: sleeping function called from invalid context at kernel/locking/mutex.c:562
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 23629, name: syz.4.5165
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
INFO: lockdep is turned off.
CPU: 0 UID: 0 PID: 23629 Comm: syz.4.5165 Tainted: G        W          6.14.0-rc5-syzkaller-01183-g40587f749df2 #0
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 __might_resched+0x5d4/0x780 kernel/sched/core.c:8767
 __mutex_lock_common kernel/locking/mutex.c:562 [inline]
 __mutex_lock+0x126/0x1010 kernel/locking/mutex.c:730
 netdev_lock include/linux/netdevice.h:2731 [inline]
 netdev_lock_ops include/net/netdev_lock.h:40 [inline]
 dev_set_allmulti+0x11c/0x270 net/core/dev_api.c:279
 team_change_rx_flags+0x1a8/0x330 drivers/net/team/team_core.c:1789
 dev_change_rx_flags net/core/dev.c:9154 [inline]
 netif_set_allmulti+0x20e/0x380 net/core/dev.c:9256
 dev_set_allmulti+0x143/0x270 net/core/dev_api.c:280
 bond_set_allmulti drivers/net/bonding/bond_main.c:946 [inline]
 bond_change_rx_flags+0x4e1/0x6b0 drivers/net/bonding/bond_main.c:4737
 dev_change_rx_flags net/core/dev.c:9154 [inline]
 netif_set_allmulti+0x20e/0x380 net/core/dev.c:9256
 dev_set_allmulti+0x143/0x270 net/core/dev_api.c:280
 vlan_dev_stop+0xb0/0x330 net/8021q/vlan_dev.c:320
 __dev_close_many+0x3a6/0x700 net/core/dev.c:1717
 dev_close_many+0x24e/0x4c0 net/core/dev.c:1742
 netif_close+0x1c0/0x2c0 net/core/dev.c:1759
 dev_close+0x137/0x280 net/core/dev_api.c:210
 bond_enslave+0x26ca/0x3910 drivers/net/bonding/bond_main.c:2438
 do_set_master+0x579/0x730 net/core/rtnetlink.c:2943
 rtnl_newlink_create+0x6e6/0xbd0 net/core/rtnetlink.c:3837
 __rtnl_newlink net/core/rtnetlink.c:3940 [inline]
 rtnl_newlink+0x167a/0x1d90 net/core/rtnetlink.c:4055
 rtnetlink_rcv_msg+0x791/0xcf0 net/core/rtnetlink.c:6945
 netlink_rcv_skb+0x206/0x480 net/netlink/af_netlink.c:2534
 netlink_unicast_kernel net/netlink/af_netlink.c:1313 [inline]
 netlink_unicast+0x7f6/0x990 net/netlink/af_netlink.c:1339
 netlink_sendmsg+0x8de/0xcb0 net/netlink/af_netlink.c:1883
 sock_sendmsg_nosec net/socket.c:709 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:724
 ____sys_sendmsg+0x53a/0x860 net/socket.c:2564
 ___sys_sendmsg net/socket.c:2618 [inline]
 __sys_sendmsg+0x269/0x350 net/socket.c:2650
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fe00998d169
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fe00a843038 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007fe009ba5fa0 RCX: 00007fe00998d169
RDX: 0000000000000000 RSI: 0000400000000280 RDI: 0000000000000003
RBP: 00007fe009a0e2a0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fe009ba5fa0 R15: 00007ffdc9be6f48
 </TASK>
netdevsim netdevsim4 netdevsim0: left allmulticast mode


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


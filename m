Return-Path: <netdev+bounces-113289-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DD4EA93D867
	for <lists+netdev@lfdr.de>; Fri, 26 Jul 2024 20:36:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D5E3B237CE
	for <lists+netdev@lfdr.de>; Fri, 26 Jul 2024 18:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED60D4436A;
	Fri, 26 Jul 2024 18:36:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3865438F82
	for <netdev@vger.kernel.org>; Fri, 26 Jul 2024 18:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722018989; cv=none; b=ft80Ifyl2cryL/AsS6SUISVMHH/z+/NMJH1xV39yXUOAfQ3bVZ2WIvv1T/TQYNfUOg4AVcuElOvsL73+dJXnytZnpdKTsyPRxxtgZABfrmHtr+rS/s3jtd4e/cVBIw/z6hQklrPJuZXRGr/0KGW243mIrqLOmXKtkY4TCSb0WLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722018989; c=relaxed/simple;
	bh=WKH5BgxiUJ5hc/0TawnXFMva1YrvHmK2+4/SJPVa7WU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=l2NiQhdIPWoivnDpzok4Msp4c4my+b4RplnXJWJc1DgBDFdmPtK0r8RWUsdlCgQuCcQDdqMFczDOTea+WJPcN1gbRfnah/UoNtjMow4gCvgirlMx8C8zHm6NkERE8VNS43wZYy9vvWpxOo4Up0cCJZNGcP9UPYv4U9+mswRUMNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-806199616d0so208171539f.2
        for <netdev@vger.kernel.org>; Fri, 26 Jul 2024 11:36:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722018987; x=1722623787;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LXUTmDkvfShi+Ru3wRXvmBuP0y61Ox5D+M6fEe2yMgI=;
        b=XVqERFykaVKSwrSsiDQ+qp9JSfNY9PB+agExzOT3O/IQYW5iIIStOglLro5zyTl+H2
         BAqcj5nlnKAt+M5A9I713egCsXlbZqfN6TGN6ZVR9m3lZk+5znw0U65RNHadQ6IDeHPi
         wIwnXQnqyHk93xaZZ5/ZmA0sCdynQAlyzn6Ok+g3zdeMBlQaD8H/+vVvlyWDm009vkUw
         xK/Kcxh5mdYosag3bnZhw9Ns+NM8z1dItbEVKfd6E8t6+N9xfb3kVVMThIRH8maYxeuE
         sZIiRIl1ibCUlGjZ45+Mg/zF+1eDuq7XeA8uKxYx+nY1aGcsZNSu9C3GVuQcxDaPn2im
         3Asg==
X-Forwarded-Encrypted: i=1; AJvYcCUxxiEbFwt1wknSOEf2KRxEC/V5GGWxrz5otgr3Ytaw9MWiQHFnwOb6jaJWEL5ByusULPn/lWa7AuR3cT/OcZdYoyBgMqR5
X-Gm-Message-State: AOJu0YykyMMo5f6IN3xju/bOCztGswICYAAzLD0IQhZLxJkbkKA7ALPr
	sDVIkZXGzBwWAVat7m4iPHp+3OxOzMatuO6dAV10k7f0EOJF6pNfjCNCgpw9OgPdLzNbG+T3hr5
	C/jqdkINfWb4zdKAeMlcDKkQaisS2Stcc/rMTSTXHrhCukhDuMXAnufM=
X-Google-Smtp-Source: AGHT+IGwsxfxkMPSYzW7wzlc5uNtrSeS/NDGHEL7SNU2t10tgEi57ZzRunHzntq1JXhj6Hz/Qqa3bTFpiuBJB+/kmq6Qb7T9q/lX
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:981d:b0:4c2:7179:ce03 with SMTP id
 8926c6da1cb9f-4c63e6639d9mr4551173.2.1722018987365; Fri, 26 Jul 2024 11:36:27
 -0700 (PDT)
Date: Fri, 26 Jul 2024 11:36:27 -0700
In-Reply-To: <0000000000004da3b0061808451e@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000009e6b5061e2aca90@google.com>
Subject: Re: [syzbot] [net?] possible deadlock in team_device_event (3)
From: syzbot <syzbot+b668da2bc4cb9670bf58@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, jiri@resnulli.us, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    1722389b0d86 Merge tag 'net-6.11-rc1' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11a8dabd980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=381b8eb3d35e3ad9
dashboard link: https://syzkaller.appspot.com/bug?extid=b668da2bc4cb9670bf58
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10e99275980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=137c299d980000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-1722389b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3ad0b42d0812/vmlinux-1722389b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/67a851e0e5f8/bzImage-1722389b.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b668da2bc4cb9670bf58@syzkaller.appspotmail.com

netlink: 'syz-executor122': attribute type 10 has an invalid length.
dummy0: left promiscuous mode
dummy0: entered promiscuous mode
============================================
WARNING: possible recursive locking detected
6.10.0-syzkaller-12562-g1722389b0d86 #0 Not tainted
--------------------------------------------
syz-executor122/5360 is trying to acquire lock:
ffff88802c258d40 (team->team_lock_key){+.+.}-{3:3}, at: team_port_change_check drivers/net/team/team_core.c:2950 [inline]
ffff88802c258d40 (team->team_lock_key){+.+.}-{3:3}, at: team_device_event+0x2c7/0x770 drivers/net/team/team_core.c:2973

but task is already holding lock:
ffff88802c258d40 (team->team_lock_key){+.+.}-{3:3}, at: team_add_slave+0x9c/0x20e0 drivers/net/team/team_core.c:1975

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(team->team_lock_key);
  lock(team->team_lock_key);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

2 locks held by syz-executor122/5360:
 #0: ffffffff8fa1e9a8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8fa1e9a8 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x372/0xea0 net/core/rtnetlink.c:6644
 #1: ffff88802c258d40 (team->team_lock_key){+.+.}-{3:3}, at: team_add_slave+0x9c/0x20e0 drivers/net/team/team_core.c:1975

stack backtrace:
CPU: 0 UID: 0 PID: 5360 Comm: syz-executor122 Not tainted 6.10.0-syzkaller-12562-g1722389b0d86 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:119
 check_deadlock kernel/locking/lockdep.c:3061 [inline]
 validate_chain kernel/locking/lockdep.c:3855 [inline]
 __lock_acquire+0x2167/0x3cb0 kernel/locking/lockdep.c:5142
 lock_acquire kernel/locking/lockdep.c:5759 [inline]
 lock_acquire+0x1b1/0x560 kernel/locking/lockdep.c:5724
 __mutex_lock_common kernel/locking/mutex.c:608 [inline]
 __mutex_lock+0x175/0x9c0 kernel/locking/mutex.c:752
 team_port_change_check drivers/net/team/team_core.c:2950 [inline]
 team_device_event+0x2c7/0x770 drivers/net/team/team_core.c:2973
 notifier_call_chain+0xb9/0x410 kernel/notifier.c:93
 call_netdevice_notifiers_info+0xbe/0x140 net/core/dev.c:1994
 call_netdevice_notifiers_extack net/core/dev.c:2032 [inline]
 call_netdevice_notifiers net/core/dev.c:2046 [inline]
 __dev_notify_flags+0x12d/0x2e0 net/core/dev.c:8876
 dev_change_flags+0x10c/0x160 net/core/dev.c:8914
 vlan_device_event+0xdfc/0x2120 net/8021q/vlan.c:468
 notifier_call_chain+0xb9/0x410 kernel/notifier.c:93
 call_netdevice_notifiers_info+0xbe/0x140 net/core/dev.c:1994
 call_netdevice_notifiers_extack net/core/dev.c:2032 [inline]
 call_netdevice_notifiers net/core/dev.c:2046 [inline]
 dev_open net/core/dev.c:1515 [inline]
 dev_open+0x144/0x160 net/core/dev.c:1503
 team_port_add drivers/net/team/team_core.c:1216 [inline]
 team_add_slave+0xacd/0x20e0 drivers/net/team/team_core.c:1976
 do_set_master+0x1bc/0x230 net/core/rtnetlink.c:2701
 do_setlink+0xcaf/0x3ff0 net/core/rtnetlink.c:2907
 __rtnl_newlink+0xc35/0x1960 net/core/rtnetlink.c:3696
 rtnl_newlink+0x67/0xa0 net/core/rtnetlink.c:3743
 rtnetlink_rcv_msg+0x3c7/0xea0 net/core/rtnetlink.c:6647
 netlink_rcv_skb+0x16b/0x440 net/netlink/af_netlink.c:2550
 netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
 netlink_unicast+0x544/0x830 net/netlink/af_netlink.c:1357
 netlink_sendmsg+0x8b8/0xd70 net/netlink/af_netlink.c:1901
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg net/socket.c:745 [inline]
 ____sys_sendmsg+0xab5/0xc90 net/socket.c:2597
 ___sys_sendmsg+0x135/0x1e0 net/socket.c:2651
 __sys_sendmsg+0x117/0x1f0 net/socket.c:2680
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f424ca7e7b9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 31 1a 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd8c496978 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f424ca7e7b9
RDX: 0000000000000000 RSI: 0000000020000600 RDI: 0000000000000012
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000001
R10: 0000000000000001 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 00007ffd8c4969a0
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.


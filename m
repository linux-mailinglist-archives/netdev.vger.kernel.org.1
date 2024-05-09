Return-Path: <netdev+bounces-94999-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A206A8C1345
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 18:54:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4AF51C20AD6
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 16:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74A848F7A;
	Thu,  9 May 2024 16:54:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8C46FB0
	for <netdev@vger.kernel.org>; Thu,  9 May 2024 16:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715273664; cv=none; b=PIS141tVXexc2oxG5WGb++pmaEQpQVX0IggJ7nTOge8KLazBUWjGIofixvn9+Ylqy9Ko7x2tI82P2y3nMiCC4yI2JJzZVM2hdnREXdh/XnM1Ne7XEebPtxwffOm+gZCWY00IPsg/e7qnkpteAEfqwhPBHqcIzGGNqdO33iixrRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715273664; c=relaxed/simple;
	bh=jRFBtIxI7p41PalXC/FldCWeMtTS5vkp+wgCQ8PDF3w=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=et4seUH0whkkuUK4g77I0Atq82LGIU6X1iSCZjNTF5QNRP/FWgrx9Q8RKat04+TVPgR+Rc/b2gW17XmN7VAg4Uw2OgP5IG3ep7NsuGhOIjmR3nWElif7blBYK1nLroEGHqmRRvSfRFpYA18r+nqUuQ/V18o3u3zoWPfWGfdxb1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-7ddf08e17e4so86690239f.0
        for <netdev@vger.kernel.org>; Thu, 09 May 2024 09:54:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715273662; x=1715878462;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AOw5MqGpBrLpd0h3l7Dpkao88gTm4e5Gux9aso7oDEg=;
        b=WtqbgNnY2rnJffYZ0COZlwISe1eQOoJrvHhn7o85l+ATYTdSxVRfAG8ICYZa111sK8
         fPn/JkRfKgC8SeBl6txaFGC3OaoFeOAprvZmesV2wKNwjOO8Y5iZZQ9H8iJs1EhZLNXP
         C8r749nBYuBuTSDo0Bn3oFFgGLdiZIYEARpHr1c8aSJTnL2wvLwR/LtmY75qbvS0oC6N
         WHGwSgxCGKtHjBBTPF/MkiQrN4Lf1cptN9IQ74zPUnMMk4QgKoDkV/ZrJ9i8KNTSxKIt
         hibb8Mb2cKI0uHJMjAQBHZIAgTqwl8fDnlnJkHRbZuCj9b0DavcUdHUNEzop7ON6w4s3
         J7MQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+ARntfmPv+cHEwi/ldzRJdOPDnTJWK9yHfabOi8KbO1VPCaKqDkxROoreZfcUblPMNbS9gC/ytlBrVNdLu5FIWjA0dyeI
X-Gm-Message-State: AOJu0Yyu0Qw6TzYgUaS/VEao9HSYi6xtlqno+bKq1SBFeWz1EMh6Re/c
	y+16gNM5Pkwr/1EjQB5/bsY/UFyaB9aE8nQ6W33ags0fzl5CldtcJptLpUEPiM1zc+1lVTe2x5H
	JE7qKAJ7m3kq89EOI2Gq3j0BDiZIDr/0Y+TFW6qH43QYqmfm3z7Haruc=
X-Google-Smtp-Source: AGHT+IH9kPxUtSsZvDI6Vhhr/vuJLi/aZxSb2xniCmpohNijvH8as43eAvI/ffq3bj9qUamE4ZW+rA374GgBSmeN+LYG6zTYTAQ6
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:13d0:b0:487:591e:6e04 with SMTP id
 8926c6da1cb9f-48955bde8ebmr14344173.3.1715273661779; Thu, 09 May 2024
 09:54:21 -0700 (PDT)
Date: Thu, 09 May 2024 09:54:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004da3b0061808451e@google.com>
Subject: [syzbot] [net?] possible deadlock in team_device_event (3)
From: syzbot <syzbot+b668da2bc4cb9670bf58@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, jiri@resnulli.us, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    7367539ad4b0 Merge tag 'cxl-fixes-6.9-rc7' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17c0a004980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3310e643b6ef5d69
dashboard link: https://syzkaller.appspot.com/bug?extid=b668da2bc4cb9670bf58
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8b1efa4e7ecb/disk-7367539a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ba7142036852/vmlinux-7367539a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/17af3ae89832/bzImage-7367539a.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b668da2bc4cb9670bf58@syzkaller.appspotmail.com

mac80211_hwsim hwsim28 wlan0 (unregistering): left allmulticast mode
======================================================
WARNING: possible circular locking dependency detected
6.9.0-rc6-syzkaller-00234-g7367539ad4b0 #0 Not tainted
------------------------------------------------------
kworker/u8:9/5208 is trying to acquire lock:
ffff88806325cd20 (team->team_lock_key#12){+.+.}-{3:3}, at: team_port_change_check drivers/net/team/team.c:2995 [inline]
ffff88806325cd20 (team->team_lock_key#12){+.+.}-{3:3}, at: team_device_event+0x11d/0x770 drivers/net/team/team.c:3021

but task is already holding lock:
ffff888051578768 (&rdev->wiphy.mtx){+.+.}-{3:3}, at: wiphy_lock include/net/cfg80211.h:5953 [inline]
ffff888051578768 (&rdev->wiphy.mtx){+.+.}-{3:3}, at: ieee80211_remove_interfaces+0xfe/0x760 net/mac80211/iface.c:2277

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&rdev->wiphy.mtx){+.+.}-{3:3}:
       __mutex_lock_common kernel/locking/mutex.c:608 [inline]
       __mutex_lock+0x175/0x9c0 kernel/locking/mutex.c:752
       wiphy_lock include/net/cfg80211.h:5953 [inline]
       cfg80211_netdev_notifier_call+0x367/0x1110 net/wireless/core.c:1524
       notifier_call_chain+0xb9/0x410 kernel/notifier.c:93
       call_netdevice_notifiers_info+0xbe/0x140 net/core/dev.c:1950
       call_netdevice_notifiers_extack net/core/dev.c:1988 [inline]
       call_netdevice_notifiers net/core/dev.c:2002 [inline]
       dev_open net/core/dev.c:1471 [inline]
       dev_open+0x144/0x160 net/core/dev.c:1459
       team_port_add drivers/net/team/team.c:1214 [inline]
       team_add_slave+0xadc/0x2110 drivers/net/team/team.c:1974
       do_set_master+0x1bc/0x230 net/core/rtnetlink.c:2685
       do_setlink+0xcaf/0x3ff0 net/core/rtnetlink.c:2891
       __rtnl_newlink+0xc35/0x1960 net/core/rtnetlink.c:3680
       rtnl_newlink+0x67/0xa0 net/core/rtnetlink.c:3727
       rtnetlink_rcv_msg+0x3c7/0xe60 net/core/rtnetlink.c:6595
       netlink_rcv_skb+0x16b/0x440 net/netlink/af_netlink.c:2559
       netlink_unicast_kernel net/netlink/af_netlink.c:1335 [inline]
       netlink_unicast+0x542/0x820 net/netlink/af_netlink.c:1361
       netlink_sendmsg+0x8b8/0xd70 net/netlink/af_netlink.c:1905
       sock_sendmsg_nosec net/socket.c:730 [inline]
       __sock_sendmsg net/socket.c:745 [inline]
       ____sys_sendmsg+0xab5/0xc90 net/socket.c:2584
       ___sys_sendmsg+0x135/0x1e0 net/socket.c:2638
       __sys_sendmsg+0x117/0x1f0 net/socket.c:2667
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xcf/0x260 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (team->team_lock_key#12){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3134 [inline]
       check_prevs_add kernel/locking/lockdep.c:3253 [inline]
       validate_chain kernel/locking/lockdep.c:3869 [inline]
       __lock_acquire+0x2478/0x3b30 kernel/locking/lockdep.c:5137
       lock_acquire kernel/locking/lockdep.c:5754 [inline]
       lock_acquire+0x1b1/0x560 kernel/locking/lockdep.c:5719
       __mutex_lock_common kernel/locking/mutex.c:608 [inline]
       __mutex_lock+0x175/0x9c0 kernel/locking/mutex.c:752
       team_port_change_check drivers/net/team/team.c:2995 [inline]
       team_device_event+0x11d/0x770 drivers/net/team/team.c:3021
       notifier_call_chain+0xb9/0x410 kernel/notifier.c:93
       call_netdevice_notifiers_info+0xbe/0x140 net/core/dev.c:1950
       call_netdevice_notifiers_extack net/core/dev.c:1988 [inline]
       call_netdevice_notifiers net/core/dev.c:2002 [inline]
       dev_close_many+0x333/0x6a0 net/core/dev.c:1543
       unregister_netdevice_many_notify+0x46d/0x19f0 net/core/dev.c:11080
       macvlan_device_event+0x4ed/0x880 drivers/net/macvlan.c:1828
       notifier_call_chain+0xb9/0x410 kernel/notifier.c:93
       call_netdevice_notifiers_info+0xbe/0x140 net/core/dev.c:1950
       call_netdevice_notifiers_extack net/core/dev.c:1988 [inline]
       call_netdevice_notifiers net/core/dev.c:2002 [inline]
       unregister_netdevice_many_notify+0x8a1/0x19f0 net/core/dev.c:11105
       unregister_netdevice_many net/core/dev.c:11163 [inline]
       unregister_netdevice_queue+0x307/0x3f0 net/core/dev.c:11042
       unregister_netdevice include/linux/netdevice.h:3115 [inline]
       _cfg80211_unregister_wdev+0x624/0x7f0 net/wireless/core.c:1206
       ieee80211_remove_interfaces+0x36d/0x760 net/mac80211/iface.c:2302
       ieee80211_unregister_hw+0x55/0x3a0 net/mac80211/main.c:1652
       mac80211_hwsim_del_radio drivers/net/wireless/virtual/mac80211_hwsim.c:5560 [inline]
       hwsim_exit_net+0x3ad/0x7d0 drivers/net/wireless/virtual/mac80211_hwsim.c:6437
       ops_exit_list+0xb0/0x180 net/core/net_namespace.c:170
       cleanup_net+0x5b7/0xbf0 net/core/net_namespace.c:637
       process_one_work+0x9a9/0x1ac0 kernel/workqueue.c:3267
       process_scheduled_works kernel/workqueue.c:3348 [inline]
       worker_thread+0x6c8/0xf70 kernel/workqueue.c:3429
       kthread+0x2c1/0x3a0 kernel/kthread.c:388
       ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&rdev->wiphy.mtx);
                               lock(team->team_lock_key#12);
                               lock(&rdev->wiphy.mtx);
  lock(team->team_lock_key#12);

 *** DEADLOCK ***

5 locks held by kworker/u8:9/5208:
 #0: ffff888015ecb148 ((wq_completion)netns){+.+.}-{0:0}, at: process_one_work+0x1296/0x1ac0 kernel/workqueue.c:3242
 #1: ffffc90003e5fd80 (net_cleanup_work){+.+.}-{0:0}, at: process_one_work+0x906/0x1ac0 kernel/workqueue.c:3243
 #2: ffffffff8f2ec950 (pernet_ops_rwsem){++++}-{3:3}, at: cleanup_net+0xbb/0xbf0 net/core/net_namespace.c:591
 #3: ffffffff8f301748 (rtnl_mutex){+.+.}-{3:3}, at: ieee80211_unregister_hw+0x4d/0x3a0 net/mac80211/main.c:1645
 #4: ffff888051578768 (&rdev->wiphy.mtx){+.+.}-{3:3}, at: wiphy_lock include/net/cfg80211.h:5953 [inline]
 #4: ffff888051578768 (&rdev->wiphy.mtx){+.+.}-{3:3}, at: ieee80211_remove_interfaces+0xfe/0x760 net/mac80211/iface.c:2277

stack backtrace:
CPU: 1 PID: 5208 Comm: kworker/u8:9 Not tainted 6.9.0-rc6-syzkaller-00234-g7367539ad4b0 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Workqueue: netns cleanup_net
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:114
 check_noncircular+0x31a/0x400 kernel/locking/lockdep.c:2187
 check_prev_add kernel/locking/lockdep.c:3134 [inline]
 check_prevs_add kernel/locking/lockdep.c:3253 [inline]
 validate_chain kernel/locking/lockdep.c:3869 [inline]
 __lock_acquire+0x2478/0x3b30 kernel/locking/lockdep.c:5137
 lock_acquire kernel/locking/lockdep.c:5754 [inline]
 lock_acquire+0x1b1/0x560 kernel/locking/lockdep.c:5719
 __mutex_lock_common kernel/locking/mutex.c:608 [inline]
 __mutex_lock+0x175/0x9c0 kernel/locking/mutex.c:752
 team_port_change_check drivers/net/team/team.c:2995 [inline]
 team_device_event+0x11d/0x770 drivers/net/team/team.c:3021
 notifier_call_chain+0xb9/0x410 kernel/notifier.c:93
 call_netdevice_notifiers_info+0xbe/0x140 net/core/dev.c:1950
 call_netdevice_notifiers_extack net/core/dev.c:1988 [inline]
 call_netdevice_notifiers net/core/dev.c:2002 [inline]
 dev_close_many+0x333/0x6a0 net/core/dev.c:1543
 unregister_netdevice_many_notify+0x46d/0x19f0 net/core/dev.c:11080
 macvlan_device_event+0x4ed/0x880 drivers/net/macvlan.c:1828
 notifier_call_chain+0xb9/0x410 kernel/notifier.c:93
 call_netdevice_notifiers_info+0xbe/0x140 net/core/dev.c:1950
 call_netdevice_notifiers_extack net/core/dev.c:1988 [inline]
 call_netdevice_notifiers net/core/dev.c:2002 [inline]
 unregister_netdevice_many_notify+0x8a1/0x19f0 net/core/dev.c:11105
 unregister_netdevice_many net/core/dev.c:11163 [inline]
 unregister_netdevice_queue+0x307/0x3f0 net/core/dev.c:11042
 unregister_netdevice include/linux/netdevice.h:3115 [inline]
 _cfg80211_unregister_wdev+0x624/0x7f0 net/wireless/core.c:1206
 ieee80211_remove_interfaces+0x36d/0x760 net/mac80211/iface.c:2302
 ieee80211_unregister_hw+0x55/0x3a0 net/mac80211/main.c:1652
 mac80211_hwsim_del_radio drivers/net/wireless/virtual/mac80211_hwsim.c:5560 [inline]
 hwsim_exit_net+0x3ad/0x7d0 drivers/net/wireless/virtual/mac80211_hwsim.c:6437
 ops_exit_list+0xb0/0x180 net/core/net_namespace.c:170
 cleanup_net+0x5b7/0xbf0 net/core/net_namespace.c:637
 process_one_work+0x9a9/0x1ac0 kernel/workqueue.c:3267
 process_scheduled_works kernel/workqueue.c:3348 [inline]
 worker_thread+0x6c8/0xf70 kernel/workqueue.c:3429
 kthread+0x2c1/0x3a0 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
team0: Port device macvlan2 removed
hsr_slave_0: left promiscuous mode
hsr_slave_1: left promiscuous mode
batman_adv: batadv0: Interface deactivated: batadv_slave_0
batman_adv: batadv0: Removing interface: batadv_slave_0
batman_adv: batadv0: Interface deactivated: batadv_slave_1
batman_adv: batadv0: Removing interface: batadv_slave_1
veth1_macvtap: left promiscuous mode
veth0_macvtap: left promiscuous mode
veth1_vlan: left promiscuous mode
veth0_vlan: left promiscuous mode
team0 (unregistering): Port device virt_wifi0 removed
team0 (unregistering): Port device team_slave_1 removed
team0 (unregistering): Port device team_slave_0 removed


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


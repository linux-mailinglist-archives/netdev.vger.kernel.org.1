Return-Path: <netdev+bounces-179515-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7CBBA7D3D0
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 08:08:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 498F27A366D
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 06:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 981642248BB;
	Mon,  7 Apr 2025 06:08:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2AF0DDD3
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 06:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744006118; cv=none; b=ZkHye8LCoV4jRd+BkygrlkJS4nC830itNl1QS3h6eUZN2shEZx+S9u4mdrKXncgWfNohCgmAdrFHj9UeErkS1NZNalmfzIsyXbuy3qhIhwpsoeC8g0FEtuSljVSY0LsMssR1rDwJ8aYXI91WibEFCtZVBlWG3fw2NeSzZJM3vNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744006118; c=relaxed/simple;
	bh=1XUFDFTQaz0LuYdxM8uPaQsUJ28Sya2ULD6CTPTaZJI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=hLXxaB7Wg3MRPph/BBu8SbPBB+zraRDe09fLxSD9yuuNQEP1EtcWQsFgm5GADP1MEns1z0oBiMXZjF0OWM9A5Bv/KUMstgLFS1yh+U5QsQirT18y+YuQvFkNIOrzD51XzKuFwciRBdpdJ4VlzSndy+9l4tSgSVlFlqzmtDESVYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3d6d6d82603so37054715ab.2
        for <netdev@vger.kernel.org>; Sun, 06 Apr 2025 23:08:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744006116; x=1744610916;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5/KgWplF9dPNYbjdfFLAHHlYvNMnSVx8I1yTmpszd84=;
        b=byCGJGZVoNySDrUSYKCyTHaj+RP7qRzpR/m+q8eVAOBHgqVloljZ1SOMddHHSTxSaA
         xs8B5PcSHZLgIbIDzPnGmD2FLacbbvhpgEBOCLjI5nZ1GjCKpXseDlKUbzsy9mTuqN4Y
         VyphuvfKrHQWtC2AeCZ+NVPY+QT+UT+1euQCI4QTefY2HkPqIy0+oFWzgHb2CzUspbw/
         iL2MGN55Pkn2NTX8+7rr7Zy7IOS9SdqPUjxFZ4RyRgMAEyotuRrzA9MyNoBAX2irqWJB
         p3S3Tae/BS8fANu9+W30dSy1eDZEEPbFn6LJDRQkrLtEtoQLc8UJmb8i18LrKG79SZFc
         4mmA==
X-Forwarded-Encrypted: i=1; AJvYcCUZRFOFezMZPVPOa5xWXuyqvwSlVBUbUNYVTSTp+/1teWLl7wyw375e11NhnXRq2E1uV6C2jXM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqvlMRFQ68ibUqYY2SousU4POgxPKI2zB98ch2XqCfb/KAO1oT
	BZdcJz7PosUFGE0eKSs3VMEPcPDS5UV4FriOmW/Xa8SNJjtNOTH0WbzTbXqZMqDcxPhm7LjB4N4
	ym5XJbbA5svtzhQQ8KWa+u8dCE9kRDyB2AxTeAT9A9aeJTeE90ehsbs8=
X-Google-Smtp-Source: AGHT+IFOu+JBb/IA55NbLTkjn0k9i5GFcRsLwDL+8WOvZiKl4NGApXhoFO6dLuk8aewfQRxrV+JvNZ+vkoPZV2Yv4HgCxjoeV4YK
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3e04:b0:3d3:fdb8:1792 with SMTP id
 e9e14a558f8ab-3d6e5876e66mr102311675ab.14.1744006115815; Sun, 06 Apr 2025
 23:08:35 -0700 (PDT)
Date: Sun, 06 Apr 2025 23:08:35 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67f36be3.050a0220.0a13.0282.GAE@google.com>
Subject: [syzbot] [net?] possible deadlock in team_vlan_rx_kill_vid
From: syzbot <syzbot+cefa9e687471ee7f359a@syzkaller.appspotmail.com>
To: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	jiri@resnulli.us, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    16cd1c265776 Merge tag 'timers-cleanups-2025-04-06' of git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12459fb0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f2054704dd53fb80
dashboard link: https://syzkaller.appspot.com/bug?extid=cefa9e687471ee7f359a
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/18e42a5dca85/disk-16cd1c26.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/866f5ebb32ef/vmlinux-16cd1c26.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4476a8f83564/bzImage-16cd1c26.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+cefa9e687471ee7f359a@syzkaller.appspotmail.com

veth1_macvtap: left allmulticast mode
veth1_macvtap: left promiscuous mode
veth0_macvtap: left promiscuous mode
veth1_vlan: left promiscuous mode
veth0_vlan: left promiscuous mode
======================================================
WARNING: possible circular locking dependency detected
6.14.0-syzkaller-13546-g16cd1c265776 #0 Not tainted
------------------------------------------------------
kworker/u8:5/83 is trying to acquire lock:
ffff888053410e00 (team->team_lock_key#2){+.+.}-{4:4}, at: team_vlan_rx_kill_vid+0x36/0xe0 drivers/net/team/team_core.c:1933

but task is already holding lock:
ffff888060b1cd30 (&dev_instance_lock_key#3){+.+.}-{4:4}, at: netdev_lock include/linux/netdevice.h:2751 [inline]
ffff888060b1cd30 (&dev_instance_lock_key#3){+.+.}-{4:4}, at: netdev_lock_ops include/net/netdev_lock.h:42 [inline]
ffff888060b1cd30 (&dev_instance_lock_key#3){+.+.}-{4:4}, at: unregister_netdevice_many_notify+0x5a1/0x2510 net/core/dev.c:11947

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&dev_instance_lock_key#3){+.+.}-{4:4}:
       lock_acquire+0x116/0x2f0 kernel/locking/lockdep.c:5866
       __mutex_lock_common kernel/locking/mutex.c:601 [inline]
       __mutex_lock+0x1a5/0x10c0 kernel/locking/mutex.c:746
       netdev_lock include/linux/netdevice.h:2751 [inline]
       netdev_lock_ops include/net/netdev_lock.h:42 [inline]
       dev_set_mtu+0x11c/0x270 net/core/dev_api.c:246
       team_port_add drivers/net/team/team_core.c:1215 [inline]
       team_add_slave+0x83b/0x28b0 drivers/net/team/team_core.c:1989
       do_set_master+0x579/0x730 net/core/rtnetlink.c:2946
       do_setlink+0x111d/0x43a0 net/core/rtnetlink.c:3159
       rtnl_changelink net/core/rtnetlink.c:3769 [inline]
       __rtnl_newlink net/core/rtnetlink.c:3928 [inline]
       rtnl_newlink+0x17e2/0x1fe0 net/core/rtnetlink.c:4065
       rtnetlink_rcv_msg+0x80f/0xd70 net/core/rtnetlink.c:6955
       netlink_rcv_skb+0x208/0x480 net/netlink/af_netlink.c:2534
       netlink_unicast_kernel net/netlink/af_netlink.c:1313 [inline]
       netlink_unicast+0x7f8/0x9a0 net/netlink/af_netlink.c:1339
       netlink_sendmsg+0x8c3/0xcd0 net/netlink/af_netlink.c:1883
       sock_sendmsg_nosec net/socket.c:712 [inline]
       __sock_sendmsg+0x221/0x270 net/socket.c:727
       ____sys_sendmsg+0x523/0x860 net/socket.c:2566
       ___sys_sendmsg net/socket.c:2620 [inline]
       __sys_sendmsg+0x271/0x360 net/socket.c:2652
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (team->team_lock_key#2){+.+.}-{4:4}:
       check_prev_add kernel/locking/lockdep.c:3166 [inline]
       check_prevs_add kernel/locking/lockdep.c:3285 [inline]
       validate_chain+0xa69/0x24e0 kernel/locking/lockdep.c:3909
       __lock_acquire+0xad5/0xd80 kernel/locking/lockdep.c:5235
       lock_acquire+0x116/0x2f0 kernel/locking/lockdep.c:5866
       __mutex_lock_common kernel/locking/mutex.c:601 [inline]
       __mutex_lock+0x1a5/0x10c0 kernel/locking/mutex.c:746
       team_vlan_rx_kill_vid+0x36/0xe0 drivers/net/team/team_core.c:1933
       vlan_kill_rx_filter_info net/8021q/vlan_core.c:222 [inline]
       __vlan_vid_del net/8021q/vlan_core.c:362 [inline]
       vlan_vid_del+0x483/0x770 net/8021q/vlan_core.c:387
       vlan_device_event+0x23c/0x1e00 net/8021q/vlan.c:390
       notifier_call_chain+0x1a5/0x3f0 kernel/notifier.c:85
       call_netdevice_notifiers_extack net/core/dev.c:2221 [inline]
       call_netdevice_notifiers net/core/dev.c:2235 [inline]
       dev_close_many+0x33e/0x4c0 net/core/dev.c:1738
       unregister_netdevice_many_notify+0x628/0x2510 net/core/dev.c:11949
       unregister_netdevice_many net/core/dev.c:12044 [inline]
       default_device_exit_batch+0x7ff/0x880 net/core/dev.c:12536
       ops_exit_list net/core/net_namespace.c:177 [inline]
       cleanup_net+0x8af/0xd60 net/core/net_namespace.c:654
       process_one_work kernel/workqueue.c:3238 [inline]
       process_scheduled_works+0xac3/0x18e0 kernel/workqueue.c:3319
       worker_thread+0x870/0xd50 kernel/workqueue.c:3400
       kthread+0x7b7/0x940 kernel/kthread.c:464
       ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:153
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&dev_instance_lock_key#3);
                               lock(team->team_lock_key#2);
                               lock(&dev_instance_lock_key#3);
  lock(team->team_lock_key#2);

 *** DEADLOCK ***

5 locks held by kworker/u8:5/83:
 #0: ffff88801bef6148 ((wq_completion)netns){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3213 [inline]
 #0: ffff88801bef6148 ((wq_completion)netns){+.+.}-{0:0}, at: process_scheduled_works+0x990/0x18e0 kernel/workqueue.c:3319
 #1: ffffc900015d7c60 (net_cleanup_work){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3214 [inline]
 #1: ffffc900015d7c60 (net_cleanup_work){+.+.}-{0:0}, at: process_scheduled_works+0x9cb/0x18e0 kernel/workqueue.c:3319
 #2: ffffffff900f0850 (pernet_ops_rwsem){++++}-{4:4}, at: cleanup_net+0x17c/0xd60 net/core/net_namespace.c:608
 #3: ffffffff900fd388 (rtnl_mutex){+.+.}-{4:4}, at: default_device_exit_batch+0xde/0x880 net/core/dev.c:12522
 #4: ffff888060b1cd30 (&dev_instance_lock_key#3){+.+.}-{4:4}, at: netdev_lock include/linux/netdevice.h:2751 [inline]
 #4: ffff888060b1cd30 (&dev_instance_lock_key#3){+.+.}-{4:4}, at: netdev_lock_ops include/net/netdev_lock.h:42 [inline]
 #4: ffff888060b1cd30 (&dev_instance_lock_key#3){+.+.}-{4:4}, at: unregister_netdevice_many_notify+0x5a1/0x2510 net/core/dev.c:11947

stack backtrace:
CPU: 0 UID: 0 PID: 83 Comm: kworker/u8:5 Not tainted 6.14.0-syzkaller-13546-g16cd1c265776 #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
Workqueue: netns cleanup_net
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_circular_bug+0x2e1/0x300 kernel/locking/lockdep.c:2079
 check_noncircular+0x142/0x160 kernel/locking/lockdep.c:2211
 check_prev_add kernel/locking/lockdep.c:3166 [inline]
 check_prevs_add kernel/locking/lockdep.c:3285 [inline]
 validate_chain+0xa69/0x24e0 kernel/locking/lockdep.c:3909
 __lock_acquire+0xad5/0xd80 kernel/locking/lockdep.c:5235
 lock_acquire+0x116/0x2f0 kernel/locking/lockdep.c:5866
 __mutex_lock_common kernel/locking/mutex.c:601 [inline]
 __mutex_lock+0x1a5/0x10c0 kernel/locking/mutex.c:746
 team_vlan_rx_kill_vid+0x36/0xe0 drivers/net/team/team_core.c:1933
 vlan_kill_rx_filter_info net/8021q/vlan_core.c:222 [inline]
 __vlan_vid_del net/8021q/vlan_core.c:362 [inline]
 vlan_vid_del+0x483/0x770 net/8021q/vlan_core.c:387
 vlan_device_event+0x23c/0x1e00 net/8021q/vlan.c:390
 notifier_call_chain+0x1a5/0x3f0 kernel/notifier.c:85
 call_netdevice_notifiers_extack net/core/dev.c:2221 [inline]
 call_netdevice_notifiers net/core/dev.c:2235 [inline]
 dev_close_many+0x33e/0x4c0 net/core/dev.c:1738
 unregister_netdevice_many_notify+0x628/0x2510 net/core/dev.c:11949
 unregister_netdevice_many net/core/dev.c:12044 [inline]
 default_device_exit_batch+0x7ff/0x880 net/core/dev.c:12536
 ops_exit_list net/core/net_namespace.c:177 [inline]
 cleanup_net+0x8af/0xd60 net/core/net_namespace.c:654
 process_one_work kernel/workqueue.c:3238 [inline]
 process_scheduled_works+0xac3/0x18e0 kernel/workqueue.c:3319
 worker_thread+0x870/0xd50 kernel/workqueue.c:3400
 kthread+0x7b7/0x940 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:153
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
pim6reg (unregistering): left allmulticast mode


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


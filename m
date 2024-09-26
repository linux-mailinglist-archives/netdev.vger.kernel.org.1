Return-Path: <netdev+bounces-129967-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A26298747E
	for <lists+netdev@lfdr.de>; Thu, 26 Sep 2024 15:34:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDFC428616B
	for <lists+netdev@lfdr.de>; Thu, 26 Sep 2024 13:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC67122615;
	Thu, 26 Sep 2024 13:34:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005F6F9DA
	for <netdev@vger.kernel.org>; Thu, 26 Sep 2024 13:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727357669; cv=none; b=oCh+e6zlJxIrA3mQEGI5/a0HLBRCshTX5odicFxpFMuObOrVFMNUIvBCGNB4Azop+lM0YKQnFHP3DXIBMWpAl9vwUjYObpmufg9pR23vsml1KYMJ/u18Ud7uRsXneiS8rJrkWenSTT1qRwkwJFvgi7DgfdhAEoJsK+cBL/qboiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727357669; c=relaxed/simple;
	bh=a6m31fOn0563FxegYjNkYtJJ2MYanowmp0G3zF4IfC4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=tFqDhZ3Lq7i4HEs7sHcohw51tnwwr52dUIbqJlRtpr4G0K/9HNOzgBn2RUBoKJ3tPy9LF852i5lkYxwfq8HtrSgs5ljBJIlqzDW8Q3qNzrg+WK8DAwFCE1G4krfBl2UuVOtJ3H91lkRYq4J6346qOWj6HekqxKRFJ3XxbZXsIDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a1a8a4174dso8766125ab.1
        for <netdev@vger.kernel.org>; Thu, 26 Sep 2024 06:34:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727357667; x=1727962467;
        h=content-transfer-encoding:to:from:subject:message-id:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SVeAGo70zZtSpVDsgBykvZ6PETeTcad9jGV2NcaOtPg=;
        b=XlOZa+Lvr8fPwW4zPKo0OVKDOttjhrtEcl1AS/vFjyt+pjmLh8L2FzomTuIWcT79cq
         zc6i2rBvUh3M2t3+isCtwbP02xNIQwYz9vubQPrbzXttVBxHZ8Vcvdl9WvGTjtpaXsF2
         WH24NCdDYoslbWSAP/6INV5OGcCLXm4gLSfH+hrIIP5C+GpQ119eBXmJ6qOKrFLHPHO6
         KBbXd8zyX0TpEFQHn973bYItTUgbuMsET7iqvXD5VBNfC+Nmv9hW8KdO819dhwLHh5lQ
         idCV+snBldDnTVqAA4AnTvgMgj3fijicOtBk9da5l7T0OvNxIhP9iJSZ3z0SG5i6PJTC
         ZNNQ==
X-Forwarded-Encrypted: i=1; AJvYcCXjVCqm3bZSFaqceWoTdWERLqY/UXjJp6U+W7BIfAFhavjKdjNZ2DfqbTfKWYBzKRQC/BFoBIs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+gINJR50q4YVpZ2WLQThYNe+jN+qi1ddic7x+2Uz02JhZZQe/
	XG6WjANu96A6DGWjcAt0hsYGNdleeE1xi9N9PRYSfaD0sIvESs4JY7Fhj8/3uu036onBzWaAf5s
	YwSG9V6sT3MxntU4uuqu5R4FJDlnlffGbfDmf3RNnZCOVZnmubl3tJnM=
X-Google-Smtp-Source: AGHT+IH+3GMJAKgvknGEdjKCbKDb5b6TCwuuRjZLo3u+bh5/K4KC+5mFCcyLbBrlj/L2TuBLFiZH75794o7w5+K9FC4Me6HbniZE
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:ca4d:0:b0:3a0:49da:8f6d with SMTP id
 e9e14a558f8ab-3a26d7e482cmr66702355ab.22.1727357667059; Thu, 26 Sep 2024
 06:34:27 -0700 (PDT)
Date: Thu, 26 Sep 2024 06:34:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f562e3.050a0220.211276.0074.GAE@google.com>
Subject: [syzbot] [rdma?] possible deadlock in siw_create_listen (2)
From: syzbot <syzbot+3eb27595de9aa3cf63c3@syzkaller.appspotmail.com>
To: bmt@zurich.ibm.com, jgg@ziepe.ca, leon@kernel.org, 
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot found the following issue on:

HEAD commit:    5f5673607153 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.g=
it for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=3D149fdca9980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3Ddedbcb1ff438797=
2
dashboard link: https://syzkaller.appspot.com/bug?extid=3D3eb27595de9aa3cf6=
3c3
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debia=
n) 2.40
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/40172aed5414/disk-=
5f567360.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/58372f305e9d/vmlinux-=
5f567360.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d2aae6fa798f/Ima=
ge-5f567360.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit=
:
Reported-by: syzbot+3eb27595de9aa3cf63c3@syzkaller.appspotmail.com

iwpm_register_pid: Unable to send a nlmsg (client =3D 2)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
WARNING: possible circular locking dependency detected
6.11.0-rc7-syzkaller-g5f5673607153 #0 Not tainted
------------------------------------------------------
syz.4.157/7931 is trying to acquire lock:
ffff0000ee056458 (sk_lock-AF_INET){+.+.}-{0:0}, at: siw_create_listen+0x164=
/0xd70 drivers/infiniband/sw/siw/siw_cm.c:1776

but task is already holding lock:
ffff800091c21ea8 (lock#7){+.+.}-{3:3}, at: cma_add_one+0x510/0xab4 drivers/=
infiniband/core/cma.c:5354

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (lock#7){+.+.}-{3:3}:
       __mutex_lock_common+0x190/0x21a0 kernel/locking/mutex.c:608
       __mutex_lock kernel/locking/mutex.c:752 [inline]
       mutex_lock_nested+0x2c/0x38 kernel/locking/mutex.c:804
       cma_init+0x2c/0x158 drivers/infiniband/core/cma.c:5438
       do_one_initcall+0x24c/0x9c0 init/main.c:1267
       do_initcall_level+0x154/0x214 init/main.c:1329
       do_initcalls+0x58/0xac init/main.c:1345
       do_basic_setup+0x8c/0xa0 init/main.c:1364
       kernel_init_freeable+0x324/0x478 init/main.c:1578
       kernel_init+0x24/0x2a0 init/main.c:1467
       ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:860

-> #2 (rtnl_mutex){+.+.}-{3:3}:
       __mutex_lock_common+0x190/0x21a0 kernel/locking/mutex.c:608
       __mutex_lock kernel/locking/mutex.c:752 [inline]
       mutex_lock_nested+0x2c/0x38 kernel/locking/mutex.c:804
       rtnl_lock+0x20/0x2c net/core/rtnetlink.c:79
       do_ip_setsockopt+0xe8c/0x346c net/ipv4/ip_sockglue.c:1077
       ip_setsockopt+0x80/0x128 net/ipv4/ip_sockglue.c:1417
       tcp_setsockopt+0xcc/0xe8 net/ipv4/tcp.c:3768
       sock_common_setsockopt+0xb0/0xcc net/core/sock.c:3735
       smc_setsockopt+0x204/0x10fc net/smc/af_smc.c:3072
       do_sock_setsockopt+0x2a0/0x4e0 net/socket.c:2324
       __sys_setsockopt+0x128/0x1a8 net/socket.c:2347
       __do_sys_setsockopt net/socket.c:2356 [inline]
       __se_sys_setsockopt net/socket.c:2353 [inline]
       __arm64_sys_setsockopt+0xb8/0xd4 net/socket.c:2353
       __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
       invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
       el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
       do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
       el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:712
       el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:730
       el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598

-> #1 (&smc->clcsock_release_lock){+.+.}-{3:3}:
       __mutex_lock_common+0x190/0x21a0 kernel/locking/mutex.c:608
       __mutex_lock kernel/locking/mutex.c:752 [inline]
       mutex_lock_nested+0x2c/0x38 kernel/locking/mutex.c:804
       smc_switch_to_fallback+0x48/0xa80 net/smc/af_smc.c:902
       smc_sendmsg+0xfc/0x9f8 net/smc/af_smc.c:2779
       sock_sendmsg_nosec net/socket.c:730 [inline]
       __sock_sendmsg net/socket.c:745 [inline]
       __sys_sendto+0x374/0x4f4 net/socket.c:2204
       __do_sys_sendto net/socket.c:2216 [inline]
       __se_sys_sendto net/socket.c:2212 [inline]
       __arm64_sys_sendto+0xd8/0xf8 net/socket.c:2212
       __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
       invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
       el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
       do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
       el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:712
       el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:730
       el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598

-> #0 (sk_lock-AF_INET){+.+.}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3133 [inline]
       check_prevs_add kernel/locking/lockdep.c:3252 [inline]
       validate_chain kernel/locking/lockdep.c:3868 [inline]
       __lock_acquire+0x33d8/0x779c kernel/locking/lockdep.c:5142
       lock_acquire+0x240/0x728 kernel/locking/lockdep.c:5759
       lock_sock_nested net/core/sock.c:3543 [inline]
       lock_sock include/net/sock.h:1607 [inline]
       sock_set_reuseaddr+0x58/0x154 net/core/sock.c:782
       siw_create_listen+0x164/0xd70 drivers/infiniband/sw/siw/siw_cm.c:177=
6
       iw_cm_listen+0x14c/0x204 drivers/infiniband/core/iwcm.c:585
       cma_iw_listen drivers/infiniband/core/cma.c:2668 [inline]
       rdma_listen+0x774/0xae4 drivers/infiniband/core/cma.c:3953
       cma_listen_on_dev+0x320/0x64c drivers/infiniband/core/cma.c:2727
       cma_add_one+0x5ec/0xab4 drivers/infiniband/core/cma.c:5357
       add_client_context+0x45c/0x7d0 drivers/infiniband/core/device.c:727
       enable_device_and_get+0x1a8/0x3e8 drivers/infiniband/core/device.c:1=
338
       ib_register_device+0xe40/0x108c drivers/infiniband/core/device.c:142=
6
       siw_device_register drivers/infiniband/sw/siw/siw_main.c:72 [inline]
       siw_newlink+0x80c/0xc2c drivers/infiniband/sw/siw/siw_main.c:489
       nldev_newlink+0x49c/0x4fc drivers/infiniband/core/nldev.c:1794
       rdma_nl_rcv_skb drivers/infiniband/core/netlink.c:239 [inline]
       rdma_nl_rcv+0x5c4/0x858 drivers/infiniband/core/netlink.c:259
       netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
       netlink_unicast+0x668/0x8a4 net/netlink/af_netlink.c:1357
       netlink_sendmsg+0x7a4/0xa8c net/netlink/af_netlink.c:1901
       sock_sendmsg_nosec net/socket.c:730 [inline]
       __sock_sendmsg net/socket.c:745 [inline]
       ____sys_sendmsg+0x56c/0x840 net/socket.c:2597
       ___sys_sendmsg net/socket.c:2651 [inline]
       __sys_sendmsg+0x26c/0x33c net/socket.c:2680
       __do_sys_sendmsg net/socket.c:2689 [inline]
       __se_sys_sendmsg net/socket.c:2687 [inline]
       __arm64_sys_sendmsg+0x80/0x94 net/socket.c:2687
       __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
       invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
       el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
       do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
       el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:712
       el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:730
       el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598

other info that might help us debug this:

Chain exists of:
  sk_lock-AF_INET --> rtnl_mutex --> lock#7

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(lock#7);
                               lock(rtnl_mutex);
                               lock(lock#7);
  lock(sk_lock-AF_INET);

 *** DEADLOCK ***

6 locks held by syz.4.157/7931:
 #0: ffff8000974142d8 (&rdma_nl_types[idx].sem){.+.+}-{3:3}, at: rdma_nl_rc=
v_msg drivers/infiniband/core/netlink.c:164 [inline]
 #0: ffff8000974142d8 (&rdma_nl_types[idx].sem){.+.+}-{3:3}, at: rdma_nl_rc=
v_skb drivers/infiniband/core/netlink.c:239 [inline]
 #0: ffff8000974142d8 (&rdma_nl_types[idx].sem){.+.+}-{3:3}, at: rdma_nl_rc=
v+0x330/0x858 drivers/infiniband/core/netlink.c:259
 #1: ffff800091c0e870 (link_ops_rwsem){++++}-{3:3}, at: nldev_newlink+0x358=
/0x4fc drivers/infiniband/core/nldev.c:1784
 #2: ffff800091bff210 (devices_rwsem){++++}-{3:3}, at: enable_device_and_ge=
t+0x104/0x3e8 drivers/infiniband/core/device.c:1328
 #3: ffff800091bff510 (clients_rwsem){++++}-{3:3}, at: enable_device_and_ge=
t+0x160/0x3e8 drivers/infiniband/core/device.c:1336
 #4: ffff0000d61505d0 (&device->client_data_rwsem){++++}-{3:3}, at: add_cli=
ent_context+0x424/0x7d0 drivers/infiniband/core/device.c:725
 #5: ffff800091c21ea8 (lock#7){+.+.}-{3:3}, at: cma_add_one+0x510/0xab4 dri=
vers/infiniband/core/cma.c:5354

stack backtrace:
CPU: 0 UID: 0 PID: 7931 Comm: syz.4.157 Not tainted 6.11.0-rc7-syzkaller-g5=
f5673607153 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Goo=
gle 08/06/2024
Call trace:
 dump_backtrace+0x1b8/0x1e4 arch/arm64/kernel/stacktrace.c:319
 show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:326
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0xe4/0x150 lib/dump_stack.c:119
 dump_stack+0x1c/0x28 lib/dump_stack.c:128
 print_circular_bug+0x150/0x1b8 kernel/locking/lockdep.c:2059
 check_noncircular+0x310/0x404 kernel/locking/lockdep.c:2186
 check_prev_add kernel/locking/lockdep.c:3133 [inline]
 check_prevs_add kernel/locking/lockdep.c:3252 [inline]
 validate_chain kernel/locking/lockdep.c:3868 [inline]
 __lock_acquire+0x33d8/0x779c kernel/locking/lockdep.c:5142
 lock_acquire+0x240/0x728 kernel/locking/lockdep.c:5759
 lock_sock_nested net/core/sock.c:3543 [inline]
 lock_sock include/net/sock.h:1607 [inline]
 sock_set_reuseaddr+0x58/0x154 net/core/sock.c:782
 siw_create_listen+0x164/0xd70 drivers/infiniband/sw/siw/siw_cm.c:1776
 iw_cm_listen+0x14c/0x204 drivers/infiniband/core/iwcm.c:585
 cma_iw_listen drivers/infiniband/core/cma.c:2668 [inline]
 rdma_listen+0x774/0xae4 drivers/infiniband/core/cma.c:3953
 cma_listen_on_dev+0x320/0x64c drivers/infiniband/core/cma.c:2727
 cma_add_one+0x5ec/0xab4 drivers/infiniband/core/cma.c:5357
 add_client_context+0x45c/0x7d0 drivers/infiniband/core/device.c:727
 enable_device_and_get+0x1a8/0x3e8 drivers/infiniband/core/device.c:1338
 ib_register_device+0xe40/0x108c drivers/infiniband/core/device.c:1426
 siw_device_register drivers/infiniband/sw/siw/siw_main.c:72 [inline]
 siw_newlink+0x80c/0xc2c drivers/infiniband/sw/siw/siw_main.c:489
 nldev_newlink+0x49c/0x4fc drivers/infiniband/core/nldev.c:1794
 rdma_nl_rcv_skb drivers/infiniband/core/netlink.c:239 [inline]
 rdma_nl_rcv+0x5c4/0x858 drivers/infiniband/core/netlink.c:259
 netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
 netlink_unicast+0x668/0x8a4 net/netlink/af_netlink.c:1357
 netlink_sendmsg+0x7a4/0xa8c net/netlink/af_netlink.c:1901
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg net/socket.c:745 [inline]
 ____sys_sendmsg+0x56c/0x840 net/socket.c:2597
 ___sys_sendmsg net/socket.c:2651 [inline]
 __sys_sendmsg+0x26c/0x33c net/socket.c:2680
 __do_sys_sendmsg net/socket.c:2689 [inline]
 __se_sys_sendmsg net/socket.c:2687 [inline]
 __arm64_sys_sendmsg+0x80/0x94 net/socket.c:2687
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
 el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:712
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:730
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598
infiniband syz1: RDMA CMA: cma_listen_on_dev, error -98
overlay: ./file0 is not a directory
xt_nfacct: accounting object `sy=05' does not exists


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


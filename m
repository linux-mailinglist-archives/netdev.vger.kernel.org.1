Return-Path: <netdev+bounces-213141-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B81FB23DA5
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 03:17:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E09F1B60404
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 01:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47286273FD;
	Wed, 13 Aug 2025 01:17:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C7529A1
	for <netdev@vger.kernel.org>; Wed, 13 Aug 2025 01:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755047828; cv=none; b=SzoFdKfGMfQEE/xEFZ5AblqKu+0tP+1CBJZU175vXKL8t+0DnaqpRl5oSu87QHKI6vxgaqtWmk+28gHvcT/47VQOO1JJAIMXDr3TKMgOsQiD97qf3Qmq871ZStcO+yP8IMavuaCdZYRfcaLdvsJL17NTB4kNHD04xdVJX6zG9go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755047828; c=relaxed/simple;
	bh=qW8R1rC2ggVU5eZOwlq4Bwsfi9NK9qB+QG8qXm9Dmy0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=PtZ4eHpMGVoJ9zpRFDhLeXqnM5mvklMVMbpkMq2gc1ip3niL5fDCVHaiUnEdctfaWH/qUWKPy+ptQmsLRcNNVnaTKuN9iZu0Ii2evjACZDaNF7fV422V4Q3u+/71RaCj/ilKszhG8/i+gHliauS5+T41lHs1UCUf20uLsTemTrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-88178b5ce20so1238022239f.3
        for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 18:17:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755047825; x=1755652625;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4bs/Lvx6G6Ku8w20OsGJy8Se/7aSuZnujRXQyJ6sjlk=;
        b=D6aEwL+VSYY5xXTW60S3/6JA/ksO+XPVWdVYlL3FndVKSdI68opwSU32HPE5zFfHaG
         t8rVa/PbqkI5zKTZlLTmBuj9xvCXqcubvM7+VdZjoIR6tQt8ZrfPe2hwn3DjTcpCSJPE
         twrveWBvI6MKxUGmKYQzL2+H1gf9ZB3nwe3R72rdZRoxh8dhIiZj0LlZKB8AqkvczGTE
         lmlFUzz6Born9XvYgam7X9kPrHc8k5sQWOsZ9Ql4ytQIh6xNZS3HU9I4e3ly0HF5FS7i
         zTbgIuO9yGPcsnxnDjduVy1Ru8Yut7H6EtF9YRLwtYkO2B2cQBqFrgYHMTbi+VwoEF+E
         U/Cg==
X-Forwarded-Encrypted: i=1; AJvYcCV+qVQCmrQUGHow8ZPmIrMw7nQR1HZM8lgVmJnNtfBo+2VVyF/PyM71q2zdkxEo9FxUY+PSLKg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx/3C3yMhzX+geAHBvDGKoBPPtxuTMWJ4FXFxCJeqBZKOlRwVi
	Mf9EsUAR8wepWYce6sSPh5IO/2okgeVMgNMK823mYk6T2pt5P6UN654i+zDduY/SE/AD0pD98Jk
	BmF2uFzLXLv0UwStfluciE8wm7yXRm2zIPyrqgaeofCTPNu649j8zw5L+AMo=
X-Google-Smtp-Source: AGHT+IFMlG/LVW1jB0Jryg7hiWAStRXD1rYK1qj75oP1ye26nxYrUlLKDXpjpqePGjPYCR2/4BwFOKfgpQKr6nkur3SJwoPPSXUW
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a5e:cb07:0:b0:881:776b:62b with SMTP id
 ca18e2360f4ac-8842969ca92mr229395539f.13.1755047825239; Tue, 12 Aug 2025
 18:17:05 -0700 (PDT)
Date: Tue, 12 Aug 2025 18:17:05 -0700
In-Reply-To: <20250813005602.4330-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <689be791.050a0220.51d73.00b9.GAE@google.com>
Subject: Re: [syzbot] [net?] BUG: unable to handle kernel paging request in nsim_queue_free
From: syzbot <syzbot+8aa80c6232008f7b957d@syzkaller.appspotmail.com>
To: edumazet@google.com, hdanton@sina.com, kuniyu@google.com, 
	leitao@debian.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: slab-use-after-free Read in udp_tunnel_nic_device_sync_work

netdevsim netdevsim3 eth3: set [1, 0] type 2 family 0 port 6081 - 0
==================================================================
BUG: KASAN: slab-use-after-free in __mutex_lock_common kernel/locking/mutex.c:577 [inline]
BUG: KASAN: slab-use-after-free in __mutex_lock+0x147/0x1360 kernel/locking/mutex.c:760
Read of size 8 at addr ffff8880434426b0 by task kworker/u4:10/1096

CPU: 0 UID: 0 PID: 1096 Comm: kworker/u4:10 Not tainted 6.17.0-rc1-syzkaller-00016-g8742b2d8935f-dirty #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Workqueue: udp_tunnel_nic udp_tunnel_nic_device_sync_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xca/0x240 mm/kasan/report.c:482
 kasan_report+0x118/0x150 mm/kasan/report.c:595
 __mutex_lock_common kernel/locking/mutex.c:577 [inline]
 __mutex_lock+0x147/0x1360 kernel/locking/mutex.c:760
 udp_tunnel_nic_device_sync_work+0x39/0xa50 net/ipv4/udp_tunnel_nic.c:737
 process_one_work kernel/workqueue.c:3236 [inline]
 process_scheduled_works+0xade/0x17b0 kernel/workqueue.c:3319
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3400
 kthread+0x70e/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x3f9/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

Allocated by task 6208:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:388 [inline]
 __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:405
 kasan_kmalloc include/linux/kasan.h:260 [inline]
 __do_kmalloc_node mm/slub.c:4365 [inline]
 __kmalloc_noprof+0x27a/0x4f0 mm/slub.c:4377
 kmalloc_noprof include/linux/slab.h:909 [inline]
 kzalloc_noprof include/linux/slab.h:1039 [inline]
 udp_tunnel_nic_alloc net/ipv4/udp_tunnel_nic.c:756 [inline]
 udp_tunnel_nic_register net/ipv4/udp_tunnel_nic.c:833 [inline]
 udp_tunnel_nic_netdevice_event+0x854/0x19f0 net/ipv4/udp_tunnel_nic.c:931
 notifier_call_chain+0x1b6/0x3e0 kernel/notifier.c:85
 call_netdevice_notifiers_extack net/core/dev.c:2267 [inline]
 call_netdevice_notifiers net/core/dev.c:2281 [inline]
 register_netdevice+0x1608/0x1ae0 net/core/dev.c:11227
 nsim_init_netdevsim drivers/net/netdevsim/netdev.c:1034 [inline]
 nsim_create+0xae8/0xf10 drivers/net/netdevsim/netdev.c:1105
 __nsim_dev_port_add+0x6b6/0xb10 drivers/net/netdevsim/dev.c:1438
 nsim_dev_port_add_all+0x37/0xf0 drivers/net/netdevsim/dev.c:1494
 nsim_dev_reload_create drivers/net/netdevsim/dev.c:1546 [inline]
 nsim_dev_reload_up+0x451/0x780 drivers/net/netdevsim/dev.c:1003
 devlink_reload+0x4e9/0x8d0 net/devlink/dev.c:474
 devlink_nl_reload_doit+0xb35/0xd50 net/devlink/dev.c:584
 genl_family_rcv_msg_doit+0x215/0x300 net/netlink/genetlink.c:1115
 genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
 genl_rcv_msg+0x60e/0x790 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x205/0x470 net/netlink/af_netlink.c:2552
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
 netlink_unicast+0x82c/0x9e0 net/netlink/af_netlink.c:1346
 netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1896
 sock_sendmsg_nosec net/socket.c:714 [inline]
 __sock_sendmsg+0x21c/0x270 net/socket.c:729
 ____sys_sendmsg+0x505/0x830 net/socket.c:2614
 ___sys_sendmsg+0x21f/0x2a0 net/socket.c:2668
 __sys_sendmsg net/socket.c:2700 [inline]
 __do_sys_sendmsg net/socket.c:2705 [inline]
 __se_sys_sendmsg net/socket.c:2703 [inline]
 __x64_sys_sendmsg+0x19b/0x260 net/socket.c:2703
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 6227:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x46/0x50 mm/kasan/generic.c:576
 poison_slab_object mm/kasan/common.c:243 [inline]
 __kasan_slab_free+0x5b/0x80 mm/kasan/common.c:275
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2417 [inline]
 slab_free mm/slub.c:4680 [inline]
 kfree+0x18e/0x440 mm/slub.c:4879
 udp_tunnel_nic_free net/ipv4/udp_tunnel_nic.c:785 [inline]
 udp_tunnel_nic_unregister net/ipv4/udp_tunnel_nic.c:910 [inline]
 udp_tunnel_nic_netdevice_event+0x1332/0x19f0 net/ipv4/udp_tunnel_nic.c:942
 notifier_call_chain+0x1b6/0x3e0 kernel/notifier.c:85
 call_netdevice_notifiers_extack net/core/dev.c:2267 [inline]
 call_netdevice_notifiers net/core/dev.c:2281 [inline]
 unregister_netdevice_many_notify+0x14d7/0x1ff0 net/core/dev.c:12148
 unregister_netdevice_many net/core/dev.c:12211 [inline]
 unregister_netdevice_queue+0x33c/0x380 net/core/dev.c:12055
 unregister_netdevice include/linux/netdevice.h:3382 [inline]
 nsim_destroy+0x1dd/0x670 drivers/net/netdevsim/netdev.c:1140
 __nsim_dev_port_del+0x14d/0x1b0 drivers/net/netdevsim/dev.c:1473
 nsim_dev_port_del_all drivers/net/netdevsim/dev.c:1485 [inline]
 nsim_dev_reload_destroy+0x288/0x490 drivers/net/netdevsim/dev.c:1707
 nsim_dev_reload_down+0x8a/0xc0 drivers/net/netdevsim/dev.c:983
 devlink_reload+0x1b3/0x8d0 net/devlink/dev.c:461
 devlink_nl_reload_doit+0xb35/0xd50 net/devlink/dev.c:584
 genl_family_rcv_msg_doit+0x215/0x300 net/netlink/genetlink.c:1115
 genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
 genl_rcv_msg+0x60e/0x790 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x205/0x470 net/netlink/af_netlink.c:2552
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
 netlink_unicast+0x82c/0x9e0 net/netlink/af_netlink.c:1346
 netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1896
 sock_sendmsg_nosec net/socket.c:714 [inline]
 __sock_sendmsg+0x21c/0x270 net/socket.c:729
 ____sys_sendmsg+0x505/0x830 net/socket.c:2614
 ___sys_sendmsg+0x21f/0x2a0 net/socket.c:2668
 __sys_sendmsg net/socket.c:2700 [inline]
 __do_sys_sendmsg net/socket.c:2705 [inline]
 __se_sys_sendmsg net/socket.c:2703 [inline]
 __x64_sys_sendmsg+0x19b/0x260 net/socket.c:2703
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Last potentially related work creation:
 kasan_save_stack+0x3e/0x60 mm/kasan/common.c:47
 kasan_record_aux_stack+0xbd/0xd0 mm/kasan/generic.c:548
 insert_work+0x3d/0x330 kernel/workqueue.c:2184
 __queue_work+0xbaf/0xfb0 kernel/workqueue.c:2343
 queue_work_on+0x181/0x270 kernel/workqueue.c:2390
 queue_work include/linux/workqueue.h:669 [inline]
 udp_tunnel_nic_device_sync net/ipv4/udp_tunnel_nic.c:307 [inline]
 __udp_tunnel_nic_add_port+0xb71/0xd60 net/ipv4/udp_tunnel_nic.c:523
 udp_tunnel_nic_add_port include/net/udp_tunnel.h:371 [inline]
 udp_tunnel_push_rx_port+0x180/0x200 net/ipv4/udp_tunnel_core.c:111
 geneve_offload_rx_ports+0xd7/0x160 drivers/net/geneve.c:1188
 geneve_netdevice_event+0x6a/0x80 drivers/net/geneve.c:-1
 notifier_call_chain+0x1b6/0x3e0 kernel/notifier.c:85
 call_netdevice_notifiers_extack net/core/dev.c:2267 [inline]
 call_netdevice_notifiers+0x88/0xc0 net/core/dev.c:2281
 udp_tunnel_get_rx_info include/net/udp_tunnel.h:438 [inline]
 udp_tunnel_nic_register net/ipv4/udp_tunnel_nic.c:855 [inline]
 udp_tunnel_nic_netdevice_event+0x134d/0x19f0 net/ipv4/udp_tunnel_nic.c:931
 notifier_call_chain+0x1b6/0x3e0 kernel/notifier.c:85
 call_netdevice_notifiers_extack net/core/dev.c:2267 [inline]
 call_netdevice_notifiers net/core/dev.c:2281 [inline]
 register_netdevice+0x1608/0x1ae0 net/core/dev.c:11227
 nsim_init_netdevsim drivers/net/netdevsim/netdev.c:1034 [inline]
 nsim_create+0xae8/0xf10 drivers/net/netdevsim/netdev.c:1105
 __nsim_dev_port_add+0x6b6/0xb10 drivers/net/netdevsim/dev.c:1438
 nsim_dev_port_add_all+0x37/0xf0 drivers/net/netdevsim/dev.c:1494
 nsim_dev_reload_create drivers/net/netdevsim/dev.c:1546 [inline]
 nsim_dev_reload_up+0x451/0x780 drivers/net/netdevsim/dev.c:1003
 devlink_reload+0x4e9/0x8d0 net/devlink/dev.c:474
 devlink_nl_reload_doit+0xb35/0xd50 net/devlink/dev.c:584
 genl_family_rcv_msg_doit+0x215/0x300 net/netlink/genetlink.c:1115
 genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
 genl_rcv_msg+0x60e/0x790 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x205/0x470 net/netlink/af_netlink.c:2552
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
 netlink_unicast+0x82c/0x9e0 net/netlink/af_netlink.c:1346
 netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1896
 sock_sendmsg_nosec net/socket.c:714 [inline]
 __sock_sendmsg+0x21c/0x270 net/socket.c:729
 ____sys_sendmsg+0x505/0x830 net/socket.c:2614
 ___sys_sendmsg+0x21f/0x2a0 net/socket.c:2668
 __sys_sendmsg net/socket.c:2700 [inline]
 __do_sys_sendmsg net/socket.c:2705 [inline]
 __se_sys_sendmsg net/socket.c:2703 [inline]
 __x64_sys_sendmsg+0x19b/0x260 net/socket.c:2703
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Second to last potentially related work creation:
 kasan_save_stack+0x3e/0x60 mm/kasan/common.c:47
 kasan_record_aux_stack+0xbd/0xd0 mm/kasan/generic.c:548
 insert_work+0x3d/0x330 kernel/workqueue.c:2184
 __queue_work+0xcd2/0xfb0 kernel/workqueue.c:2339
 queue_work_on+0x181/0x270 kernel/workqueue.c:2390
 queue_work include/linux/workqueue.h:669 [inline]
 udp_tunnel_nic_device_sync net/ipv4/udp_tunnel_nic.c:307 [inline]
 __udp_tunnel_nic_add_port+0xb71/0xd60 net/ipv4/udp_tunnel_nic.c:523
 udp_tunnel_nic_add_port include/net/udp_tunnel.h:371 [inline]
 udp_tunnel_push_rx_port+0x180/0x200 net/ipv4/udp_tunnel_core.c:111
 geneve_offload_rx_ports+0xd7/0x160 drivers/net/geneve.c:1188
 geneve_netdevice_event+0x6a/0x80 drivers/net/geneve.c:-1
 notifier_call_chain+0x1b6/0x3e0 kernel/notifier.c:85
 call_netdevice_notifiers_extack net/core/dev.c:2267 [inline]
 call_netdevice_notifiers+0x88/0xc0 net/core/dev.c:2281
 udp_tunnel_get_rx_info include/net/udp_tunnel.h:438 [inline]
 udp_tunnel_nic_register net/ipv4/udp_tunnel_nic.c:855 [inline]
 udp_tunnel_nic_netdevice_event+0x134d/0x19f0 net/ipv4/udp_tunnel_nic.c:931
 notifier_call_chain+0x1b6/0x3e0 kernel/notifier.c:85
 call_netdevice_notifiers_extack net/core/dev.c:2267 [inline]
 call_netdevice_notifiers net/core/dev.c:2281 [inline]
 register_netdevice+0x1608/0x1ae0 net/core/dev.c:11227
 nsim_init_netdevsim drivers/net/netdevsim/netdev.c:1034 [inline]
 nsim_create+0xae8/0xf10 drivers/net/netdevsim/netdev.c:1105
 __nsim_dev_port_add+0x6b6/0xb10 drivers/net/netdevsim/dev.c:1438
 nsim_dev_port_add_all+0x37/0xf0 drivers/net/netdevsim/dev.c:1494
 nsim_dev_reload_create drivers/net/netdevsim/dev.c:1546 [inline]
 nsim_dev_reload_up+0x451/0x780 drivers/net/netdevsim/dev.c:1003
 devlink_reload+0x4e9/0x8d0 net/devlink/dev.c:474
 devlink_nl_reload_doit+0xb35/0xd50 net/devlink/dev.c:584
 genl_family_rcv_msg_doit+0x215/0x300 net/netlink/genetlink.c:1115
 genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
 genl_rcv_msg+0x60e/0x790 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x205/0x470 net/netlink/af_netlink.c:2552
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
 netlink_unicast+0x82c/0x9e0 net/netlink/af_netlink.c:1346
 netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1896
 sock_sendmsg_nosec net/socket.c:714 [inline]
 __sock_sendmsg+0x21c/0x270 net/socket.c:729
 ____sys_sendmsg+0x505/0x830 net/socket.c:2614
 ___sys_sendmsg+0x21f/0x2a0 net/socket.c:2668
 __sys_sendmsg net/socket.c:2700 [inline]
 __do_sys_sendmsg net/socket.c:2705 [inline]
 __se_sys_sendmsg net/socket.c:2703 [inline]
 __x64_sys_sendmsg+0x19b/0x260 net/socket.c:2703
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff888043442600
 which belongs to the cache kmalloc-256 of size 256
The buggy address is located 176 bytes inside of
 freed 256-byte region [ffff888043442600, ffff888043442700)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x43442
flags: 0x4fff00000000000(node=1|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 04fff00000000000 ffff88801a441b40 ffffea00010d2d40 dead000000000006
raw: 0000000000000000 0000000080080008 00000000f5000000 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x52cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 5772, tgid 5772 (syz-executor), ts 159705044362, free_ts 159704611959
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x240/0x2a0 mm/page_alloc.c:1851
 prep_new_page mm/page_alloc.c:1859 [inline]
 get_page_from_freelist+0x21e4/0x22c0 mm/page_alloc.c:3858
 __alloc_frozen_pages_noprof+0x181/0x370 mm/page_alloc.c:5148
 alloc_pages_mpol+0x232/0x4a0 mm/mempolicy.c:2416
 alloc_slab_page mm/slub.c:2487 [inline]
 allocate_slab+0x8a/0x370 mm/slub.c:2655
 new_slab mm/slub.c:2709 [inline]
 ___slab_alloc+0xbeb/0x1410 mm/slub.c:3891
 __slab_alloc mm/slub.c:3981 [inline]
 __slab_alloc_node mm/slub.c:4056 [inline]
 slab_alloc_node mm/slub.c:4217 [inline]
 __do_kmalloc_node mm/slub.c:4364 [inline]
 __kmalloc_noprof+0x305/0x4f0 mm/slub.c:4377
 kmalloc_noprof include/linux/slab.h:909 [inline]
 kzalloc_noprof include/linux/slab.h:1039 [inline]
 fib_create_info+0x1728/0x3210 net/ipv4/fib_semantics.c:1402
 fib_table_insert+0xc6/0x1b50 net/ipv4/fib_trie.c:1212
 fib_magic+0x2c4/0x390 net/ipv4/fib_frontend.c:1133
 fib_add_ifaddr+0x38d/0x5f0 net/ipv4/fib_frontend.c:1170
 fib_netdev_event+0x382/0x490 net/ipv4/fib_frontend.c:1515
 notifier_call_chain+0x1b6/0x3e0 kernel/notifier.c:85
 call_netdevice_notifiers_extack net/core/dev.c:2267 [inline]
 call_netdevice_notifiers net/core/dev.c:2281 [inline]
 __dev_notify_flags+0x18d/0x2e0 net/core/dev.c:-1
 netif_change_flags+0xe8/0x1a0 net/core/dev.c:9600
 do_setlink+0xc55/0x41c0 net/core/rtnetlink.c:3143
page last free pid 5772 tgid 5772 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1395 [inline]
 __free_frozen_pages+0xbc4/0xd30 mm/page_alloc.c:2895
 pagetable_free include/linux/mm.h:2898 [inline]
 pagetable_dtor_free+0x2d2/0x3b0 include/linux/mm.h:2996
 mm_free_pgd kernel/fork.c:541 [inline]
 __mmdrop+0xb5/0x580 kernel/fork.c:683
 mmdrop include/linux/sched/mm.h:55 [inline]
 mmdrop_sched include/linux/sched/mm.h:83 [inline]
 mmdrop_lazy_tlb_sched include/linux/sched/mm.h:110 [inline]
 finish_task_switch+0x3ee/0x950 kernel/sched/core.c:5250
 context_switch kernel/sched/core.c:5360 [inline]
 __schedule+0x17a0/0x4cc0 kernel/sched/core.c:6961
 preempt_schedule_common+0x83/0xd0 kernel/sched/core.c:7145
 preempt_schedule+0xae/0xc0 kernel/sched/core.c:7169
 preempt_schedule_thunk+0x16/0x30 arch/x86/entry/thunk.S:12
 vprintk_emit+0x69a/0x7a0 kernel/printk/printk.c:2451
 _printk+0xcf/0x120 kernel/printk/printk.c:2475
 netdev_warn+0x10a/0x160 net/core/dev.c:12633
 hsr_dev_open+0x19d/0x260 net/hsr/hsr_device.c:159
 __dev_open+0x46d/0x880 net/core/dev.c:1682
 __dev_change_flags+0x1ea/0x6d0 net/core/dev.c:9532
 netif_change_flags+0x88/0x1a0 net/core/dev.c:9595
 do_setlink+0xc55/0x41c0 net/core/rtnetlink.c:3143

Memory state around the buggy address:
 ffff888043442580: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888043442600: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888043442680: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                     ^
 ffff888043442700: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888043442780: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


Tested on:

commit:         8742b2d8 Merge tag 'pull-fixes' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11ffc5a2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d67d3af29f50297e
dashboard link: https://syzkaller.appspot.com/bug?extid=8aa80c6232008f7b957d
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1185caf0580000



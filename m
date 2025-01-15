Return-Path: <netdev+bounces-158531-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA627A12655
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 15:43:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD1173A8E6E
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 14:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48C0C135A63;
	Wed, 15 Jan 2025 14:42:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695118635E
	for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 14:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736952145; cv=none; b=ONEKQsYOGDJX1PrLQHRwXo6NB8wKUAmAWb+G8t1Yd+yhj9Xx52qrEknpHbOWgGUUm80Vyemmmk7k3xSJJn7L2HQ771nTjmTbBDC8zVAGhBsPRTTp0ENdAraDDBjlehKEqgQRg/hbXCQtl1udKqUeDDRBkgDtmPrqSKWgyzQfm6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736952145; c=relaxed/simple;
	bh=YcqtB54ISEsgTnFbqzaLPDS9NBPdeQoiVd6n6UIX8h4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Bm34fW4NSN9V5H7oozGrm0BYsFTlII+N6Jgf4aawlAXXhUU01J7Qrx7Ky32O9qcm1MA83bIsH0LhX8p8g3c/qsiiDdie7D0iiNrDcLSOCZONzn/yFqTCOD+35VaUQYdYoiVJ5+1Z7C7S9RW/hliSrms1PtLryPWqyFgr1rd05v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3a9cefa1969so59403955ab.1
        for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 06:42:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736952142; x=1737556942;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d+GL1J0/v+cnNPPAGQhX+NvoEqDPg6Zj/V++ta7D31Y=;
        b=no/z4inDKpl/qXa6X8pQ+Of8yZwd4Qp/3PZ7+arqe0n7gHObLTzfuIzgMhGQK/S4ue
         DEbA4e9EMsTY0m9/7LgRVcrXLxL1fisCEOXFC7qcvDzT7F6gjDyj6J+FKNz/+jX6p04t
         ElIkJQztxbuNfrtq0ESrjOzWH8Mr/RBh2KkBINCokjmq1uMJjEFt2MSUmoiHlQQrUMXH
         qsh/R17mA/I6/S7GssVEA+OoaftH8JMrWJSuq3Jn2B5PCqUh3ct9AZw70ZZt4KMbFoCB
         CwZ4dFMoMiHlEzNsG7aRv7m9hEmRN0b7ha5sHvVTNn4io3gn6lleAZywy3weradfW1qI
         CMJQ==
X-Forwarded-Encrypted: i=1; AJvYcCX73Ib1h8rUKwKyZnJXqYJn90BKZ/jwTRSRBp9tUqyBwc8m/jiDAeKB8sVAeG6IHiDBcVWb/38=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/XqbydT660ME8b7JSE7RxeAPfv4ePiZZDXou9dLRP9w3drSnj
	pCt8yLIRkrCXI0z0Veaqr4D5fjWsDF5hNW6vgXMJcxIlNsON4DkGuDuvgl5RBp2Wk/aO/6YRfQI
	ujzJwJDEcUEr07l3jAmiZORp8aabCzYroF2x1hJGjVZIcDtJDydE7dW4=
X-Google-Smtp-Source: AGHT+IGZAuAK812WZkfJizhUT3RrffDEVMJ2k99tcnz1IWmU56WH7LjM+9+YLjZ7M61xFiyMV0eEraa5fWzZekxWX0gJy+6sNhkt
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1848:b0:3ce:8898:af17 with SMTP id
 e9e14a558f8ab-3ce8898b3e7mr17796665ab.4.1736952142537; Wed, 15 Jan 2025
 06:42:22 -0800 (PST)
Date: Wed, 15 Jan 2025 06:42:22 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6787c94e.050a0220.20d369.001a.GAE@google.com>
Subject: [syzbot] [net?] WARNING in nsim_udp_tunnel_unset_port
From: syzbot <syzbot+a04efb7a2949bb2484cf@syzkaller.appspotmail.com>
To: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    bcde95ce32b6 Merge tag 'devicetree-fixes-for-6.13-1' of gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=118c58c4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c22efbd20f8da769
dashboard link: https://syzkaller.appspot.com/bug?extid=a04efb7a2949bb2484cf
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/002dc48f8ceb/disk-bcde95ce.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7d1bae2a9338/vmlinux-bcde95ce.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c0fb5cc8ac22/bzImage-bcde95ce.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a04efb7a2949bb2484cf@syzkaller.appspotmail.com

------------[ cut here ]------------
entry not installed 17c10002 vs 0
WARNING: CPU: 0 PID: 1036 at drivers/net/netdevsim/udp_tunnels.c:58 nsim_udp_tunnel_unset_port+0x303/0x3f0 drivers/net/netdevsim/udp_tunnels.c:58
Modules linked in:
CPU: 0 UID: 0 PID: 1036 Comm: kworker/u8:14 Not tainted 6.13.0-rc3-syzkaller-00301-gbcde95ce32b6 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Workqueue: netns cleanup_net
RIP: 0010:nsim_udp_tunnel_unset_port+0x303/0x3f0 drivers/net/netdevsim/udp_tunnels.c:58
Code: 08 e8 01 b5 ca fa 90 49 83 fc 03 8b 4c 24 08 8b 44 24 10 0f 87 d8 00 00 00 89 ca 89 c6 48 c7 c7 20 7e 0a 8c e8 1e 7b 8b fa 90 <0f> 0b 90 90 41 bf fe ff ff ff e9 e0 fe ff ff 4c 89 f7 e8 36 24 2d
RSP: 0018:ffffc9000c7d7440 EFLAGS: 00010282
RAX: 0000000000000000 RBX: ffffc9000c7d7540 RCX: ffffffff815a1729
RDX: ffff88801ef7da00 RSI: ffffffff815a1736 RDI: 0000000000000001
RBP: ffff88804dea0000 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: fffffffffffd8798 R12: 0000000000000000
R13: 0000000000000000 R14: ffffc9000c7d7544 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f712e7da180 CR3: 0000000032ca6000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 udp_tunnel_nic_device_sync_one net/ipv4/udp_tunnel_nic.c:225 [inline]
 udp_tunnel_nic_device_sync_by_port net/ipv4/udp_tunnel_nic.c:246 [inline]
 __udp_tunnel_nic_device_sync.part.0+0x935/0xed0 net/ipv4/udp_tunnel_nic.c:289
 __udp_tunnel_nic_device_sync net/ipv4/udp_tunnel_nic.c:283 [inline]
 udp_tunnel_nic_flush+0x2af/0x5e0 net/ipv4/udp_tunnel_nic.c:670
 udp_tunnel_nic_unregister net/ipv4/udp_tunnel_nic.c:864 [inline]
 udp_tunnel_nic_netdevice_event+0x6a0/0x18e0 net/ipv4/udp_tunnel_nic.c:904
 notifier_call_chain+0xb7/0x410 kernel/notifier.c:85
 call_netdevice_notifiers_info+0xbe/0x140 net/core/dev.c:1996
 call_netdevice_notifiers_extack net/core/dev.c:2034 [inline]
 call_netdevice_notifiers net/core/dev.c:2048 [inline]
 unregister_netdevice_many_notify+0x8d5/0x1e60 net/core/dev.c:11526
 unregister_netdevice_many net/core/dev.c:11590 [inline]
 unregister_netdevice_queue+0x307/0x3f0 net/core/dev.c:11462
 unregister_netdevice include/linux/netdevice.h:3192 [inline]
 nsim_destroy+0x107/0x6b0 drivers/net/netdevsim/netdev.c:821
 __nsim_dev_port_del+0x189/0x240 drivers/net/netdevsim/dev.c:1428
 nsim_dev_port_del_all drivers/net/netdevsim/dev.c:1440 [inline]
 nsim_dev_reload_destroy+0x108/0x4d0 drivers/net/netdevsim/dev.c:1661
 nsim_dev_reload_down+0x6e/0xd0 drivers/net/netdevsim/dev.c:968
 devlink_reload+0x17f/0x760 net/devlink/dev.c:461
 devlink_pernet_pre_exit+0x1a1/0x2b0 net/devlink/core.c:509
 ops_pre_exit_list net/core/net_namespace.c:162 [inline]
 cleanup_net+0x488/0xbd0 net/core/net_namespace.c:628
 process_one_work+0x958/0x1b30 kernel/workqueue.c:3229
 process_scheduled_works kernel/workqueue.c:3310 [inline]
 worker_thread+0x6c8/0xf00 kernel/workqueue.c:3391
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>


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


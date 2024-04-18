Return-Path: <netdev+bounces-89012-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E21978A93B2
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 09:05:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FEC31C20A21
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 07:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E4E38DD9;
	Thu, 18 Apr 2024 07:05:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83FF23B1AE
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 07:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713423926; cv=none; b=kHFrd1UyqZ9HtxTljW46Wn42XEb7k9ydX8OYR620o1FQyfP6m4vq+IuJzEtDDdANjv9DCwVZ/H/YkwSQLHeHnFI06xUIK1qvwsYUTOmqjlq02JfCXJO+o3Z3NAZQjkAmogS40GKziFmjNeFqTjsgSZvqLQhS8O5ppe6a+FBvIT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713423926; c=relaxed/simple;
	bh=DpNYQn+w5PCxg2NVTX3F2k7d0ON6U92OktF/DlSHkkk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=cVjtVl9+Xe1gFGDyhHf9VefScyh9LXRlfXXrlifV9yxMkvWOOpdFY6x2qU06ohiKU+YtYRvVOFS3egu8id70XfHcGOAMX2sftBALRmO/Hw3G+LTgYe0TCLrlA/DHCHoSsUF0Fkgk/LPmmZvdofw9d8Xw4AhHcCgdPsIIuh6i0RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7d096c4d663so79133439f.2
        for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 00:05:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713423921; x=1714028721;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fJexf5+MbTzjj98rRE4+4iT+Akz4gMMl16XDd2wlbhw=;
        b=sqo7h2ZG2IicRYqmCDLvD1PfFmPiltFYI+1DDZ4j9hGvziOm4x4NCmFgfo/nQRuxnD
         gw81ajd/aL+bU219ha2FEvLTBqXsH0/90O5miCC4WaDQKXU90riHYCX7+31+AEbgQDoY
         d8VGb5Hp3iviu+jypPF1LUZFEECwI+hKZxsnlGqXXkSSDeK0aKcwAYuWBSe11y/LTWn6
         PgHZ1BwmtLX5tsJQ3wOnS1ljjI038KTbTImaboCRxKrvxlqRG08Ha3l2VMEQdXLXogd1
         WjBEuCt+d32LQCrBrgZZE627Y1pk/BEwYr58V8fYIEdWIKNLakUy9TWS4g7gvfPPtj3o
         tF/g==
X-Forwarded-Encrypted: i=1; AJvYcCW/U/synjDwJ0X2JYLNNiFGVbNZvb9pOaiLr94QSr9l5jWLz1gnTxHe99KMJ8G4KpASRxRtd35OG4D7cN9FE4dOuUG5TPRi
X-Gm-Message-State: AOJu0Yxu/TtkMn1By8SJ03NkODAlHOsDj+e9OxWiIC6sJjOQlyln+Tma
	DvzfwbQ7lbCUnQ7iIFchslbEU31q8ICb7Pdiwr/h7ruP/npBg9tJQB6uZdvmoAosETQXvY5FNO4
	AjiAxmMhTAlS2t7ETy479veT107FBkl6dZyKaJGULjSWXc5czCQ0iBc4=
X-Google-Smtp-Source: AGHT+IG/voBl8A8rBsNZa2Ke2raFnLDw3dJFLixYZRwXLKqGVoDMZcE3tZ5pKb/k/fCPCAcExqNHtRz5kvn146/bi0KKiFF42+LR
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:144b:b0:484:a701:3632 with SMTP id
 l11-20020a056638144b00b00484a7013632mr99688jad.2.1713423921711; Thu, 18 Apr
 2024 00:05:21 -0700 (PDT)
Date: Thu, 18 Apr 2024 00:05:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003420e806165998ae@google.com>
Subject: [syzbot] [net?] KMSAN: uninit-value in ipvlan_queue_xmit (2)
From: syzbot <syzbot+42a0dc856239de4de60e@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    f2e367d6ad3b Merge tag 'for-6.8/dm-fix-3' of git://git.ker..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=144a8d4a180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1b015d567058472
dashboard link: https://syzkaller.appspot.com/bug?extid=42a0dc856239de4de60e
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=149caa54180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10bb8e22180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/0dabc03369d1/disk-f2e367d6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/240ca250d398/vmlinux-f2e367d6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/cc38bcdb48c9/bzImage-f2e367d6.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+42a0dc856239de4de60e@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in ipvlan_process_outbound drivers/net/ipvlan/ipvlan_core.c:524 [inline]
BUG: KMSAN: uninit-value in ipvlan_xmit_mode_l3 drivers/net/ipvlan/ipvlan_core.c:602 [inline]
BUG: KMSAN: uninit-value in ipvlan_queue_xmit+0xf44/0x16b0 drivers/net/ipvlan/ipvlan_core.c:668
 ipvlan_process_outbound drivers/net/ipvlan/ipvlan_core.c:524 [inline]
 ipvlan_xmit_mode_l3 drivers/net/ipvlan/ipvlan_core.c:602 [inline]
 ipvlan_queue_xmit+0xf44/0x16b0 drivers/net/ipvlan/ipvlan_core.c:668
 ipvlan_start_xmit+0x5c/0x1a0 drivers/net/ipvlan/ipvlan_main.c:222
 __netdev_start_xmit include/linux/netdevice.h:4989 [inline]
 netdev_start_xmit include/linux/netdevice.h:5003 [inline]
 xmit_one net/core/dev.c:3547 [inline]
 dev_hard_start_xmit+0x244/0xa10 net/core/dev.c:3563
 __dev_queue_xmit+0x33ed/0x51c0 net/core/dev.c:4351
 dev_queue_xmit include/linux/netdevice.h:3171 [inline]
 packet_xmit+0x9c/0x6b0 net/packet/af_packet.c:276
 packet_snd net/packet/af_packet.c:3081 [inline]
 packet_sendmsg+0x8aef/0x9f10 net/packet/af_packet.c:3113
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg net/socket.c:745 [inline]
 __sys_sendto+0x735/0xa10 net/socket.c:2191
 __do_sys_sendto net/socket.c:2203 [inline]
 __se_sys_sendto net/socket.c:2199 [inline]
 __x64_sys_sendto+0x125/0x1c0 net/socket.c:2199
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

Uninit was created at:
 slab_post_alloc_hook mm/slub.c:3819 [inline]
 slab_alloc_node mm/slub.c:3860 [inline]
 __do_kmalloc_node mm/slub.c:3980 [inline]
 __kmalloc_node_track_caller+0x705/0x1000 mm/slub.c:4001
 kmalloc_reserve+0x249/0x4a0 net/core/skbuff.c:582
 __alloc_skb+0x352/0x790 net/core/skbuff.c:651
 skb_segment+0x20aa/0x7080 net/core/skbuff.c:4647
 udp6_ufo_fragment+0xcab/0x1150 net/ipv6/udp_offload.c:109
 ipv6_gso_segment+0x14be/0x2ca0 net/ipv6/ip6_offload.c:152
 skb_mac_gso_segment+0x3e8/0x760 net/core/gso.c:53
 nsh_gso_segment+0x6f4/0xf70 net/nsh/nsh.c:108
 skb_mac_gso_segment+0x3e8/0x760 net/core/gso.c:53
 __skb_gso_segment+0x4b0/0x730 net/core/gso.c:124
 skb_gso_segment include/net/gso.h:83 [inline]
 validate_xmit_skb+0x107f/0x1930 net/core/dev.c:3628
 __dev_queue_xmit+0x1f28/0x51c0 net/core/dev.c:4343
 dev_queue_xmit include/linux/netdevice.h:3171 [inline]
 packet_xmit+0x9c/0x6b0 net/packet/af_packet.c:276
 packet_snd net/packet/af_packet.c:3081 [inline]
 packet_sendmsg+0x8aef/0x9f10 net/packet/af_packet.c:3113
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg net/socket.c:745 [inline]
 __sys_sendto+0x735/0xa10 net/socket.c:2191
 __do_sys_sendto net/socket.c:2203 [inline]
 __se_sys_sendto net/socket.c:2199 [inline]
 __x64_sys_sendto+0x125/0x1c0 net/socket.c:2199
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

CPU: 1 PID: 5101 Comm: syz-executor421 Not tainted 6.8.0-rc5-syzkaller-00297-gf2e367d6ad3b #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
=====================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup


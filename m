Return-Path: <netdev+bounces-192630-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22013AC0931
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 12:00:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CD691BA5AC7
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 10:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8223413C918;
	Thu, 22 May 2025 10:00:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0D415E96
	for <netdev@vger.kernel.org>; Thu, 22 May 2025 10:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747908028; cv=none; b=ogEsnZ3AVPRDFLWCrQTk4pKPUTQFmyltQH6S2e4NxyC58SobS+Oj3noQkQ5b3VZd9EJo1C5HsrGgehBk9Hi+18SwkxKRIIYpxeZVmqmRFrQpu9D/fW3wEfacIY4u3L5iXX+sbxscuXXY1qNbgUdV67PEUJNOWlHF8I1foB7MAfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747908028; c=relaxed/simple;
	bh=G0s8ehLv/laQIT0Lceu4qyIEtrAWgMjq2TKbqXX99xE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ZG08czP5E2yDR5pE267BTetaHv7S+FSrcKTVQ/PWLttdZFHvheqRzF3MsG6tJWKkO3i0kEWHckvv/PaDmKq9fDMjVMXgGRN0PUu82uYb8XYaHcw1osoYadj0HJREuppvxcG/yAMnxfsEayUHO8t9jwJNY6H3GH6T3HC76z/fUM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-85b5a7981ccso656066039f.2
        for <netdev@vger.kernel.org>; Thu, 22 May 2025 03:00:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747908025; x=1748512825;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N9SPmBVOYISy/x3e5fpt7fXl47e2yZMZoJ4GUSrI/KA=;
        b=STiJ5vfUTbTK4g8ArfNs4BwelhTffEDFMsSw0f8v4DhAsNOvzG+uY/VLyo6IXPeTrz
         QVNBwDeVRL5GDdSOOwBalNPIKCjcBMQXQHZhCWfDadZL0sPgPiXn7R9vjJLCNaSyIPll
         ZoDR16sfu6m36UCaw1+Npe0XfBX6umz2xZ3hg4Bp/8iihcMcTaQGDQ8Ae8JcYy9cKG/B
         RnI+PxqC/E1VZrKp2lLOiJA2Ho2tLkC1mmsthKcQpmrTEZz31pvdbEP0KkoxuHZi8d47
         31oWu4uz+klGAWNZifm2z7ylavnS1w0eNnqLdBHgkNPoaH96vAlnevVPxrAAxJSb05Q1
         c0/g==
X-Forwarded-Encrypted: i=1; AJvYcCU0JtOhFWmjmzDwKTwEwOG8Cjprn+dovZa93Pg/Rfdtr7ejkMGA2xSZ9jVZuuUkfx5Jn1H8qKE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/YxQ6E7FedKz+uN38mVUhilw5XTyQL5lpBebHsccztHTVQvvl
	gJCw2WQATJuO2hoEFltBdG6zEUqD8+6Gg9O6XjvfnxzQGN1qoBPswB/zgaB5gBxb+CYW5co9tHx
	sQzbWLw4nyZP2O8VuVbPKQ2/T55Ob4IHVjhXDfXJ5Tz1K8eYW7rDAd2SlsqA=
X-Google-Smtp-Source: AGHT+IGeGrB5s+NjhCyMRV5Jxyd9Xy3QjecK2rDYBdUmmu9gL2eyjPpYHNoaeu5Fxlbw8G7iKIAu8EIbS6QXDi5dO9NkpCoyzr6h
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3805:b0:867:6680:cfd with SMTP id
 ca18e2360f4ac-86a2316ec56mr3262082439f.1.1747908025663; Thu, 22 May 2025
 03:00:25 -0700 (PDT)
Date: Thu, 22 May 2025 03:00:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <682ef5b9.a00a0220.2a3337.0012.GAE@google.com>
Subject: [syzbot] [net?] BUG: corrupted list in __hw_addr_del_entry
From: syzbot <syzbot+30468d31a80c716b0152@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    5723cc3450bc Merge tag 'dmaengine-fix-6.15' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1631cef4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4f080d149583fe67
dashboard link: https://syzkaller.appspot.com/bug?extid=30468d31a80c716b0152
compiler:       arm-linux-gnueabi-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/98a89b9f34e4/non_bootable_disk-5723cc34.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1e90c68d0eb2/vmlinux-5723cc34.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ee3140eb6a4e/zImage-5723cc34.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+30468d31a80c716b0152@syzkaller.appspotmail.com

veth0_vlan: left promiscuous mode
 slab kmalloc-128 start 84d20900 pointer offset 0 size 128
list_del corruption. next->prev should be 84d20780, but was 00000122. (next=84d20900)
------------[ cut here ]------------
kernel BUG at lib/list_debug.c:65!
Internal error: Oops - BUG: 0 [#1] SMP ARM
Modules linked in:
CPU: 0 UID: 0 PID: 16584 Comm: kworker/u8:0 Not tainted 6.15.0-rc6-syzkaller #0 PREEMPT 
Hardware name: ARM-Versatile Express
Workqueue: netns cleanup_net
PC is at __list_del_entry_valid_or_report+0x8c/0x108 lib/list_debug.c:65
LR is at __wake_up_klogd.part.0+0x7c/0xac kernel/printk/printk.c:4556
pc : [<808c8ba4>]    lr : [<802eaa70>]    psr: 60000113
sp : e8831a58  ip : e88319a0  fp : e8831a74
r10: 00000000  r9 : 84d20788  r8 : 84b2424c
r7 : 84d20780  r6 : 84d20780  r5 : 856ea200  r4 : 84d20900
r3 : 832e8c00  r2 : 00000000  r1 : 00000000  r0 : 00000055
Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
Control: 30c5387d  Table: 84770480  DAC: fffffffd
Register r0 information: non-paged memory
Register r1 information: NULL pointer
Register r2 information: NULL pointer
Register r3 information: slab task_struct start 832e8c00 pointer offset 0 size 3072
Register r4 information: slab kmalloc-128 start 84d20900 pointer offset 0 size 128
Register r5 information: slab kmalloc-128 start 856ea200 pointer offset 0 size 128
Register r6 information: slab kmalloc-128 start 84d20780 pointer offset 0 size 128
Register r7 information: slab kmalloc-128 start 84d20780 pointer offset 0 size 128
Register r8 information: slab kmalloc-cg-2k start 84b24000 pointer offset 588 size 2048
Register r9 information: slab kmalloc-128 start 84d20780 pointer offset 8 size 128
Register r10 information: NULL pointer
Register r11 information: 2-page vmalloc region starting at 0xe8830000 allocated at kernel_clone+0xac/0x3e4 kernel/fork.c:2845
Register r12 information: 2-page vmalloc region starting at 0xe8830000 allocated at kernel_clone+0xac/0x3e4 kernel/fork.c:2845
Process kworker/u8:0 (pid: 16584, stack limit = 0xe8830000)
Stack: (0xe8831a58 to 0xe8832000)
1a40:                                                       84d20780 84b2424c
1a60: 00000001 00000004 e8831a8c e8831a78 8155a1b8 808c8b24 e8831af4 00000006
1a80: e8831ac4 e8831a90 8155a2bc 8155a140 e8831ac4 00000000 e8831af4 84b24000
1aa0: e8831af4 84b24238 00000000 00000000 00000000 80000010 e8831aec e8831ac8
1ac0: 8155adc4 8155a220 00000000 00000000 00000000 84d20380 84b24000 84d20380
1ae0: e8831b34 e8831af0 81834e9c 8155ad84 849ef540 00ff3333 00002e00 00000000
1b00: 00000000 00000000 00000000 00000000 00000000 47b2c705 e8831b34 84e14800
1b20: 84e14930 84d20380 e8831b64 e8831b38 81836c58 81834d98 e8831b64 e8831b48
1b40: 848a5e80 854e2c00 000002ff 00000000 848a5e80 849ef540 e8831bd4 e8831b68
1b60: 8180237c 81836bb8 00000000 00000820 81805424 00000000 00000000 00000000
1b80: 00000015 00000000 ffffffff 00000000 00000000 00000000 000002ff 00000000
1ba0: 01000000 2e0000ff 8026b438 47b2c705 84e14800 854e2c24 854e2c00 00000000
1bc0: 84e14948 854e2c8c e8831c3c e8831bd8 81805454 81802128 81a5c5b0 0000002e
1be0: 848a5e80 84b24000 00000000 84e14948 e8831bf0 e8831bf0 80797b44 e8831c8c
1c00: e8831c70 8029eb0c 80797b44 47b2c705 00000000 84b24000 84e14800 848a5e80
1c20: 00000002 8180b828 00000000 e8831d14 e8831c8c e8831c40 8180b8c0 8180501c
1c40: e8831c8c e8831c50 81671994 8030cb14 e8831c8c e8831c60 816e9bd8 47b2c705
1c60: 81c00000 829e57a4 829e494c ffffffd1 00000000 8180b828 00000000 e8831d14
1c80: e8831cc4 e8831c90 802926d4 8180b834 832e8c00 00000002 00000cc0 e8831d14
1ca0: 00000002 848a5e80 00000001 84b24000 00000000 8241df54 e8831cdc e8831cc8
1cc0: 8029290c 80292680 00000000 802da2e4 e8831d04 e8831ce0 8154bfb4 802928f8
1ce0: 00000000 00000000 00000000 84b24114 84b1c000 e8831d88 e8831d44 e8831d08
1d00: 8154c5c4 8154bf6c 00000000 00000000 00000000 84b24000 00000000 47b2c705
1d20: e8831cfc 85b14114 85ada114 e8831e08 e8831d88 00000001 e8831ddc e8831d48
1d40: 815571e8 8154c4d4 829d1f04 e8831e70 e8831da4 e8831d60 80505bb4 80505568
1d60: 00000001 819dadd8 829d255c 00000000 00000000 00000000 832e8c00 8241ebb4
1d80: 81557c50 808c8a4c 84b24114 85ada114 e8831e08 85ada000 e8831ddc e8831da8
1da0: 81557c50 808c8a4c 00000000 47b2c705 e8831ddc 848a5e7c 848a5f78 e8831e70
1dc0: 82c1f980 e8831e90 829d1f04 e8831e70 e8831e54 e8831de0 81558928 8155700c
1de0: e8831dfc e8831df0 81a5c3e0 e8831e90 848a5e80 8241ec70 81a4eeb4 81a5c3c0
1e00: 848a5e7c 61c88647 84a7e90c 85ada10c 8122b314 00000000 00000000 00000000
1e20: 00000000 47b2c705 e8831e54 829d25c4 e8831e90 829d25c4 e8831e90 829d1f04
1e40: 829d1f04 848a6c00 e8831e74 e8831e58 8153a0e0 81558630 829d25c4 82c1f940
1e60: 829d1ec0 e8831e90 e8831ed4 e8831e78 8153c540 8153a088 81a5c4d4 8029ce24
1e80: 82c1f940 829d1ec0 808c9c70 8153a0e4 848a5ea0 848a5ea0 00000100 00000122
1ea0: 00000000 47b2c705 81c01f84 8578b580 829d1ed8 8301bc00 8300e600 832e8c00
1ec0: 8301bc15 8300f070 e8831f2c e8831ed8 802873bc 8153c29c 81c01a44 832e8c00
1ee0: e8831f14 e8831ef0 829d1edc 829d1ed8 829d1edc 829d1ed8 e8831f2c 00000000
1f00: 80282cf8 8578b580 8300e620 8300e600 82804d40 8578b5ac 832e8c00 61c88647
1f20: e8831f6c e8831f30 80288004 80287214 81a5c4d4 61c88647 82804d40 61c88647
1f40: 8028eb98 00000001 832e8c00 854fa580 ec6dde60 80287e08 8578b580 00000000
1f60: e8831fac e8831f70 8028f07c 80287e14 80274ea8 81a5c45c 832e8c00 47b2c705
1f80: e8831fac 85523e40 8028ef50 00000000 00000000 00000000 00000000 00000000
1fa0: 00000000 e8831fb0 80200114 8028ef5c 00000000 00000000 00000000 00000000
1fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
1fe0: 00000000 00000000 00000000 00000000 00000013 00000000 00000000 00000000
Call trace: 
[<808c8b18>] (__list_del_entry_valid_or_report) from [<8155a1b8>] (__list_del_entry_valid include/linux/list.h:124 [inline])
[<808c8b18>] (__list_del_entry_valid_or_report) from [<8155a1b8>] (__list_del_entry include/linux/list.h:215 [inline])
[<808c8b18>] (__list_del_entry_valid_or_report) from [<8155a1b8>] (list_del_rcu include/linux/rculist.h:168 [inline])
[<808c8b18>] (__list_del_entry_valid_or_report) from [<8155a1b8>] (__hw_addr_del_entry+0x84/0xe0 net/core/dev_addr_lists.c:160)
 r7:00000004 r6:00000001 r5:84b2424c r4:84d20780
[<8155a134>] (__hw_addr_del_entry) from [<8155a2bc>] (__hw_addr_del_ex+0xa8/0xb0 net/core/dev_addr_lists.c:200)
 r5:00000006 r4:e8831af4
[<8155a214>] (__hw_addr_del_ex) from [<8155adc4>] (__dev_mc_del net/core/dev_addr_lists.c:909 [inline])
[<8155a214>] (__hw_addr_del_ex) from [<8155adc4>] (dev_mc_del+0x4c/0x74 net/core/dev_addr_lists.c:927)
 r10:80000010 r9:00000000 r8:00000000 r7:00000000 r6:84b24238 r5:e8831af4
 r4:84b24000
[<8155ad78>] (dev_mc_del) from [<81834e9c>] (igmp6_group_dropped+0x110/0x238 net/ipv6/mcast.c:719)
 r6:84d20380 r5:84b24000 r4:84d20380
[<81834d8c>] (igmp6_group_dropped) from [<81836c58>] (__ipv6_dev_mc_dec+0xac/0x1a0 net/ipv6/mcast.c:1018)
 r6:84d20380 r5:84e14930 r4:84e14800
[<81836bac>] (__ipv6_dev_mc_dec) from [<8180237c>] (addrconf_leave_solict net/ipv6/addrconf.c:2254 [inline])
[<81836bac>] (__ipv6_dev_mc_dec) from [<8180237c>] (addrconf_leave_solict net/ipv6/addrconf.c:2246 [inline])
[<81836bac>] (__ipv6_dev_mc_dec) from [<8180237c>] (__ipv6_ifa_notify+0x260/0x358 net/ipv6/addrconf.c:6302)
 r9:849ef540 r8:848a5e80 r7:00000000 r6:000002ff r5:854e2c00 r4:848a5e80
[<8180211c>] (__ipv6_ifa_notify) from [<81805454>] (addrconf_ifdown+0x444/0x764 net/ipv6/addrconf.c:3981)
 r9:854e2c8c r8:84e14948 r7:00000000 r6:854e2c00 r5:854e2c24 r4:84e14800
[<81805010>] (addrconf_ifdown) from [<8180b8c0>] (addrconf_notify+0x98/0x770 net/ipv6/addrconf.c:3780)
 r10:e8831d14 r9:00000000 r8:8180b828 r7:00000002 r6:848a5e80 r5:84e14800
 r4:84b24000
[<8180b828>] (addrconf_notify) from [<802926d4>] (notifier_call_chain+0x60/0x1b4 kernel/notifier.c:85)
 r10:e8831d14 r9:00000000 r8:8180b828 r7:00000000 r6:ffffffd1 r5:829e494c
 r4:829e57a4
[<80292674>] (notifier_call_chain) from [<8029290c>] (raw_notifier_call_chain+0x20/0x28 kernel/notifier.c:453)
 r10:8241df54 r9:00000000 r8:84b24000 r7:00000001 r6:848a5e80 r5:00000002
 r4:e8831d14
[<802928ec>] (raw_notifier_call_chain) from [<8154bfb4>] (call_netdevice_notifiers_info+0x54/0xa0 net/core/dev.c:2176)
[<8154bf60>] (call_netdevice_notifiers_info) from [<8154c5c4>] (call_netdevice_notifiers_extack net/core/dev.c:2214 [inline])
[<8154bf60>] (call_netdevice_notifiers_info) from [<8154c5c4>] (call_netdevice_notifiers net/core/dev.c:2228 [inline])
[<8154bf60>] (call_netdevice_notifiers_info) from [<8154c5c4>] (dev_close_many+0xfc/0x150 net/core/dev.c:1731)
 r6:e8831d88 r5:84b1c000 r4:84b24114
[<8154c4c8>] (dev_close_many) from [<815571e8>] (unregister_netdevice_many_notify+0x1e8/0xbc4 net/core/dev.c:11942)
 r9:00000001 r8:e8831d88 r7:e8831e08 r6:85ada114 r5:85b14114 r4:e8831cfc
[<81557000>] (unregister_netdevice_many_notify) from [<81558928>] (unregister_netdevice_many net/core/dev.c:12036 [inline])
[<81557000>] (unregister_netdevice_many_notify) from [<81558928>] (default_device_exit_batch+0x304/0x384 net/core/dev.c:12530)
 r10:e8831e70 r9:829d1f04 r8:e8831e90 r7:82c1f980 r6:e8831e70 r5:848a5f78
 r4:848a5e7c
[<81558624>] (default_device_exit_batch) from [<8153a0e0>] (ops_exit_list+0x64/0x68 net/core/net_namespace.c:177)
 r10:848a6c00 r9:829d1f04 r8:829d1f04 r7:e8831e90 r6:829d25c4 r5:e8831e90
 r4:829d25c4
[<8153a07c>] (ops_exit_list) from [<8153c540>] (cleanup_net+0x2b0/0x49c net/core/net_namespace.c:654)
 r7:e8831e90 r6:829d1ec0 r5:82c1f940 r4:829d25c4
[<8153c290>] (cleanup_net) from [<802873bc>] (process_one_work+0x1b4/0x4f4 kernel/workqueue.c:3238)
 r10:8300f070 r9:8301bc15 r8:832e8c00 r7:8300e600 r6:8301bc00 r5:829d1ed8
 r4:8578b580
[<80287208>] (process_one_work) from [<80288004>] (process_scheduled_works kernel/workqueue.c:3319 [inline])
[<80287208>] (process_one_work) from [<80288004>] (worker_thread+0x1fc/0x3d8 kernel/workqueue.c:3400)
 r10:61c88647 r9:832e8c00 r8:8578b5ac r7:82804d40 r6:8300e600 r5:8300e620
 r4:8578b580
[<80287e08>] (worker_thread) from [<8028f07c>] (kthread+0x12c/0x280 kernel/kthread.c:464)
 r10:00000000 r9:8578b580 r8:80287e08 r7:ec6dde60 r6:854fa580 r5:832e8c00
 r4:00000001
[<8028ef50>] (kthread) from [<80200114>] (ret_from_fork+0x14/0x20 arch/arm/kernel/entry-common.S:137)
Exception stack(0xe8831fb0 to 0xe8831ff8)
1fa0:                                     00000000 00000000 00000000 00000000
1fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
1fe0: 00000000 00000000 00000000 00000000 00000013 00000000
 r10:00000000 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:8028ef50
 r4:85523e40
Code: e1a01006 e30f0a2c e348022a ebe4ef86 (e7f001f2) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	e1a01006 	mov	r1, r6
   4:	e30f0a2c 	movw	r0, #64044	@ 0xfa2c
   8:	e348022a 	movt	r0, #33322	@ 0x822a
   c:	ebe4ef86 	bl	0xff93be2c
* 10:	e7f001f2 	udf	#18 <-- trapping instruction


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


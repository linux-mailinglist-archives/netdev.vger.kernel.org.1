Return-Path: <netdev+bounces-291051-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id PADZJp5QEWoWjwYAu9opvQ
	(envelope-from <netdev+bounces-291051-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 09:00:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 032F05BD781
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 09:00:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A6357301648E
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 07:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FA1120010A;
	Sat, 23 May 2026 07:00:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89B1450F2
	for <netdev@vger.kernel.org>; Sat, 23 May 2026 07:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779519641; cv=none; b=rbUHaz0o+pLV/kt/6ZataVKZpwOB6M1HeZpB70DyWymWFvIW1qmT8kaW5Ax1oiGvlvyClb8ln0c7GfNLe1WCEfRuhm26zRqBRUGBIzvSu51Ys+90HoN/87mjo+50FWWMg3dVrrqHZYjrcGIua9dJ6398qDtmj5Ol+PGgHtfU1fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779519641; c=relaxed/simple;
	bh=nEUKCIqheV9yGVUoQgyGjGfDNP2bGQ9J2iPuG7OqTO0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=axVZMaTs4pMMG2ilq/ovS5U6SIsdiCDcgQ96xEGISvELCTBSsHEio6hQNnqjv7mLVKEWXHkstUNxeGPqDGuh44krYFLZ3YbShOnMXKl//XPNwHa1N07IJtngjIBRf0LCi6He4p9UQ/Q/pYGIXqLfxygDKbbFDXJrr8AMu6/N1lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-7e5e92fbe1fso4245022a34.1
        for <netdev@vger.kernel.org>; Sat, 23 May 2026 00:00:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779519639; x=1780124439;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cKv7eb7X/Cs57qN2PKvFkGRdS5W2sNayHBMdNnHDigY=;
        b=eSSl0jRtA/JNoivMRbKKlfLG0YysGcoDJBXwh5itbK37/KsNfLRY/iTJgS2+vA1k+I
         57Mu7BtUR/NdLmuTI/0C31lE9zfb7X35UUYZZK9A9guRyxhns0Fr7VpOwt/1KGcKOcut
         STHPfJZEePHvBh++Rw8DloGjJn+Lr5ARsg7hPAoXbvBo7u5VTPBuFm8qZ0sRaxBkrM94
         FtirNnNamfjt9kLrY0kd+Ppcl7z6OLcUHI6ao+z4oNfYlBDyJuAjkOXpd0uQrZq4bFHB
         vBRwgdd2NIjLE0nEwvD1nBsxRcxsvj/x+mAKFlOA8eAEo/x78lsZBbA7iHxfV8RmMvkE
         Pw/Q==
X-Forwarded-Encrypted: i=1; AFNElJ+OjhVBeTMjnnM76aem6LGZbgOzzJ91Rbq3WqJ7Jbq5jhlp/P2DO9v2VfUg1uHOZn30/M3LDZ8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7jgtvEnviqAoBbYMUFVuB0mVL9CY78ZrSJPGMtAwpR5gdQUex
	9BhoQw3/Huk/+v+wPDbvsPfITwMbWU3gxrr1PD/dgvh+bsYRrpQoBpM2peMo/GO9s1dNZlb5XKJ
	U75UjRv5pIDACmV7sClUlmJOlQts/dODpAVz/haOGa7IX+d+0yFqVyqPKPSw=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a4a:edc5:0:b0:69d:7e73:2d96 with SMTP id
 006d021491bc7-69d7eb44ef5mr3539594eaf.13.1779519639049; Sat, 23 May 2026
 00:00:39 -0700 (PDT)
Date: Sat, 23 May 2026 00:00:39 -0700
In-Reply-To: <20260522173002.2181677-1-edumazet@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a115097.050a0220.3c3a9.0005.GAE@google.com>
Subject: [syzbot ci] Re: rtnetlink: RTNL avoidance in rtnl_getlink() and rtnl_dump_ifinfo()
From: syzbot ci <syzbot+cid69f1bad2452c7b2@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, eric.dumazet@gmail.com, 
	horms@kernel.org, kuba@kernel.org, kuniyu@google.com, netdev@vger.kernel.org, 
	pabeni@redhat.com
Cc: syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[davemloft.net,google.com,gmail.com,kernel.org,vger.kernel.org,redhat.com];
	TAGGED_FROM(0.00)[bounces-291051-lists,netdev=lfdr.de,cid69f1bad2452c7b2];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.728];
	RCPT_COUNT_SEVEN(0.00)[10];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[googlegroups.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,syzbot.org:url]
X-Rspamd-Queue-Id: 032F05BD781
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

syzbot ci has tested the following series

[v4] rtnetlink: RTNL avoidance in rtnl_getlink() and rtnl_dump_ifinfo()
https://lore.kernel.org/all/20260522173002.2181677-1-edumazet@google.com
* [PATCH v4 net-next 1/5] rtnetlink: use nla_nest_end_safe() in rtnl_fill_prop_list()
* [PATCH v4 net-next 2/5] net: defer netdev_name_node_alt_flush() call to netdev_run_todo()
* [PATCH v4 net-next 3/5] rtnetlink: do not acquire RTNL in rtnl_getlink() with RTEXT_FILTER_NAME_ONLY
* [PATCH v4 net-next 4/5] rtnetlink: do not assume RTNL is held in link_master_filtered()
* [PATCH v4 net-next 5/5] rtnetlink: add RTEXT_FILTER_NAME_ONLY support to rtnl_dump_ifinfo()

and found the following issue:
WARNING in rtmsg_ifinfo_build_skb

Full report is available here:
https://ci.syzbot.org/series/583940d4-d5e9-48ca-a2e6-544edbb1d63c

***

WARNING in rtmsg_ifinfo_build_skb

tree:      net-next
URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/netdev/net-next.git
base:      1a1f055318d82e64485a6ff8420e5f70b4267998
arch:      amd64
compiler:  Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
config:    https://ci.syzbot.org/builds/513a249e-70b7-4622-8d72-6f62840955c7/config

pci 0000:00:01.0: BAR 2 [mem 0xfebf0000-0xfebf0fff]
pci 0000:00:01.0: ROM [mem 0xfebe0000-0xfebeffff pref]
pci 0000:00:01.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
pci 0000:00:02.0: [1af4:1005] type 00 class 0x00ff00 conventional PCI endpoint
pci 0000:00:02.0: BAR 0 [io  0xc080-0xc09f]
pci 0000:00:02.0: BAR 1 [mem 0xfebf1000-0xfebf1fff]
pci 0000:00:02.0: BAR 4 [mem 0xfe000000-0xfe003fff 64bit pref]
pci 0000:00:03.0: [8086:100e] type 00 class 0x020000 conventional PCI endpoint
pci 0000:00:03.0: BAR 0 [mem 0xfebc0000-0xfebdffff]
pci 0000:00:03.0: BAR 1 [io  0xc000-0xc03f]
pci 0000:00:03.0: ROM [mem 0xfeb80000-0xfebbffff pref]
pci 0000:00:1f.0: [8086:2918] type 00 class 0x060100 conventional PCI endpoint
pci 0000:00:1f.0: quirk: [io  0x0600-0x067f] claimed by ICH6 ACPI/GPIO/TCO
pci 0000:00:1f.2: [8086:2922] type 00 class 0x010601 conventional PCI endpoint
pci 0000:00:1f.2: BAR 4 [io  0xc0a0-0xc0bf]
pci 0000:00:1f.2: BAR 5 [mem 0xfebf2000-0xfebf2fff]
pci 0000:00:1f.3: [8086:2930] type 00 class 0x0c0500 conventional PCI endpoint
pci 0000:00:1f.3: BAR 4 [io  0x0700-0x073f]
ACPI: PCI: Interrupt link LNKA configured for IRQ 10
ACPI: PCI: Interrupt link LNKB configured for IRQ 10
ACPI: PCI: Interrupt link LNKC configured for IRQ 11
ACPI: PCI: Interrupt link LNKD configured for IRQ 11
ACPI: PCI: Interrupt link LNKE configured for IRQ 10
ACPI: PCI: Interrupt link LNKF configured for IRQ 10
ACPI: PCI: Interrupt link LNKG configured for IRQ 11
ACPI: PCI: Interrupt link LNKH configured for IRQ 11
ACPI: PCI: Interrupt link GSIA configured for IRQ 16
ACPI: PCI: Interrupt link GSIB configured for IRQ 17
ACPI: PCI: Interrupt link GSIC configured for IRQ 18
ACPI: PCI: Interrupt link GSID configured for IRQ 19
ACPI: PCI: Interrupt link GSIE configured for IRQ 20
ACPI: PCI: Interrupt link GSIF configured for IRQ 21
ACPI: PCI: Interrupt link GSIG configured for IRQ 22
ACPI: PCI: Interrupt link GSIH configured for IRQ 23
iommu: Default domain type: Translated
iommu: DMA domain TLB invalidation policy: lazy mode
SCSI subsystem initialized
ACPI: bus type USB registered
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
mc: Linux media interface: v0.10
videodev: Linux video capture interface: v2.00
pps_core: LinuxPPS API ver. 1 registered
pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
PTP clock support registered
EDAC MC: Ver: 3.0.0
Advanced Linux Sound Architecture Driver Initialized.
------------[ cut here ]------------
err == -EMSGSIZE
WARNING: net/core/rtnetlink.c:4524 at rtmsg_ifinfo_build_skb+0x218/0x260, CPU#0: swapper/0/1
Modules linked in:
CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:rtmsg_ifinfo_build_skb+0x218/0x260
Code: f6 ba 01 00 00 00 89 e9 e8 45 ac 3a 00 4c 89 f0 48 83 c4 30 5b 41 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc cc e8 39 dc 40 f8 90 <0f> 0b 90 eb 90 89 d9 80 e1 07 fe c1 38 c1 0f 8c 95 fe ff ff 48 89
RSP: 0000:ffffc90000067438 EFLAGS: 00010293
RAX: ffffffff8984e887 RBX: 0000000000000000 RCX: ffff8881026f5880
RDX: 0000000000000000 RSI: 00000000ffffffa6 RDI: 00000000ffffffa6
RBP: 00000000ffffffa6 R08: ffffffff8984f746 R09: 0000000000000000
R10: fffff5200000ce30 R11: ffffed1020c50405 R12: 1ffff11020c51c21
R13: 0000000000000000 R14: ffff888103a82480 R15: ffff88810628e000
FS:  0000000000000000(0000) GS:ffff88818dc76000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffff88823ffff000 CR3: 000000000e74a000 CR4: 00000000000006f0
Call Trace:
 <TASK>
 rtmsg_ifinfo+0x8c/0x1a0
 register_netdevice+0x1aca/0x1ec0
 register_netdev+0x40/0x60
 loopback_net_init+0x75/0x150
 ops_init+0x35c/0x5c0
 register_pernet_operations+0x343/0x830
 register_pernet_device+0x2a/0x80
 net_dev_init+0x973/0xa90
 do_one_initcall+0x250/0x870
 do_initcall_level+0x104/0x190
 do_initcalls+0x59/0xa0
 kernel_init_freeable+0x2a6/0x3e0
 kernel_init+0x1d/0x1d0
 ret_from_fork+0x514/0xb70
 ret_from_fork_asm+0x1a/0x30
 </TASK>


***

If these findings have caused you to resend the series or submit a
separate fix, please add the following tag to your commit message:
  Tested-by: syzbot@syzkaller.appspotmail.com

---
This report is generated by a bot. It may contain errors.
syzbot ci engineers can be reached at syzkaller@googlegroups.com.

To test a patch for this bug, please reply with `#syz test`
(should be on a separate line).

The patch should be attached to the email.
Note: arguments like custom git repos and branches are not supported.


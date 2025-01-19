Return-Path: <netdev+bounces-159613-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC297A16026
	for <lists+netdev@lfdr.de>; Sun, 19 Jan 2025 05:11:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCD4B3A6D45
	for <lists+netdev@lfdr.de>; Sun, 19 Jan 2025 04:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41CEE126C13;
	Sun, 19 Jan 2025 04:11:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72EAE61FFE
	for <netdev@vger.kernel.org>; Sun, 19 Jan 2025 04:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737259884; cv=none; b=BtiG42CbDkqw7clt2UTUYOFQdEdMJdNFMsrhR2t7sOSl9F0T2pUvV/i0LcqTIQIX1vWX2cxoejh1mYH/KvoOZ9cbi3SRMi1MSkemv5shv0vCVoj9nDy7SkHqMpkMXzw45UQ3X9uMl/T1UkU4pyYBVu7l+zyGIPRW7k38zRherrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737259884; c=relaxed/simple;
	bh=YG/GLGiiADUSprgGJZtncrCutdPRsmIdOw2QdYO0YBc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=QP/fj83AW4S/xjU5xzLgtr5xotj72sYotYYVMQg/fEPmPmWptmtgxqtY39hQZIShQbx8k3/nIZNGykfhCLeSNc781mk3q+okHXGAfpl1r8hTJlpqWpNjxza25qWapbcwb0q5VUmih4GHMRgLDr/7UvlmKWQht++NeSpbWK9SglE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3a7e39b48a2so63210555ab.0
        for <netdev@vger.kernel.org>; Sat, 18 Jan 2025 20:11:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737259881; x=1737864681;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yU2ouqUVh1gYtObA+Pke5REWteTSMcGwVyeMsYQfnmI=;
        b=qqTfMrbKD+BudVujp7lb4EZhGxum6socKdBQoFsGuzSr94kj6staolAAwvRJz/+0eJ
         WtZLt9B9CpLdNe5crMX1ii/HXPlGqcuqdlT4RMTfrP2uCHxBGDNWFmeHBCUI0xTJQ8S6
         PATpo39a/E+pVYh9TIM3WIYG5WI7MjW4op6IO1kJIpBtaH9r/lpIDztPsuArT+gPJt/e
         EYl302/mOn6HN5ElsccYwXLlmM2F8XC2EZ226NdAYNgmevi340pvP1AdxV4bs8tWkI25
         0fk4DJuapUDZ5m5qFmmAUYYGkMQ9FdICrW9utpDFyRhoUvpDGtrd4CtpVTf/DFnFyIdl
         tvIg==
X-Forwarded-Encrypted: i=1; AJvYcCUmYXcoxxHGPXS9zvtIinY9eLPD9D5dvyIbFwEdTqNCDsqZN2yhO+aMHwuEufo4BUn0j3syUzA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr9WjBIYXvdznTW68NkVg1RDY7xXHtk3tW3kdOaT8nWLKHqtCo
	WgiV2l6Ar5GJcxlp1f7LAKAXnECOvT+5SOtMKGqI7JMwN8vZjIZNuRUzLTui8b7/ABwhyyAa1mH
	so3VShmcZbkKHSWLOn9IznKgQ+LxTlPvwt6Fe3uwUiFPSMl4+k7psESY=
X-Google-Smtp-Source: AGHT+IGn/0yzXjNCsAwNyQOq5Pc8Cqii7fBfCJ9axg9+o5IoP9ewhTfo0OCM1F3tGe8bA3X0XcwekYr1bHgciygGqMZKWTudfpHx
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a47:b0:3ce:85a3:cca4 with SMTP id
 e9e14a558f8ab-3cf7449520fmr69174035ab.15.1737259881564; Sat, 18 Jan 2025
 20:11:21 -0800 (PST)
Date: Sat, 18 Jan 2025 20:11:21 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <678c7b69.050a0220.303755.0045.GAE@google.com>
Subject: [syzbot] [rdma?] WARNING in rdma_restrack_clean
From: syzbot <syzbot+65a3b37f91d0382b77fd@syzkaller.appspotmail.com>
To: jgg@ziepe.ca, leon@kernel.org, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    c3812b15000c Merge tag 'scsi-fixes' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13c2bcb0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=aadf89e2f6db86cc
dashboard link: https://syzkaller.appspot.com/bug?extid=65a3b37f91d0382b77fd
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-c3812b15.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/97c15b4b3ce2/vmlinux-c3812b15.xz
kernel image: https://storage.googleapis.com/syzbot-assets/726b9643ccee/bzImage-c3812b15.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+65a3b37f91d0382b77fd@syzkaller.appspotmail.com

smc: removing ib device syz1
------------[ cut here ]------------
WARNING: CPU: 0 PID: 5318 at drivers/infiniband/core/restrack.c:52 rdma_restrack_clean+0x2af/0x320 drivers/infiniband/core/restrack.c:52
Modules linked in:
CPU: 0 UID: 0 PID: 5318 Comm: syz.0.0 Not tainted 6.13.0-rc7-syzkaller-00039-gc3812b15000c #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:rdma_restrack_clean+0x2af/0x320 drivers/infiniband/core/restrack.c:52
Code: 02 dd f8 49 81 c7 68 02 00 00 4c 89 ff e8 59 2b 05 03 4c 89 f7 5b 41 5c 41 5d 41 5e 41 5f 5d e9 c7 cf 37 f9 e8 42 02 dd f8 90 <0f> 0b 90 e9 b3 fd ff ff e8 34 02 dd f8 90 0f 0b 90 e9 f1 fd ff ff
RSP: 0018:ffffc9000d4b70e0 EFLAGS: 00010283
RAX: ffffffff88c2802e RBX: ffff888052b10848 RCX: 0000000000100000
RDX: ffffc9000ec9b000 RSI: 00000000000a1c6d RDI: 00000000000a1c6e
RBP: 1ffff11007de21c3 R08: ffffffff88bb12d7 R09: 1ffff11007de21c5
R10: dffffc0000000000 R11: ffffed1007de21c6 R12: dffffc0000000000
R13: dffffc0000000000 R14: ffff888052b10800 R15: ffff88803ef10e18
FS:  00007f056259c6c0(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055d0f79a11d0 CR3: 000000003bbf4000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ib_dealloc_device+0x168/0x200 drivers/infiniband/core/device.c:683
 __ib_unregister_device+0x366/0x3d0 drivers/infiniband/core/device.c:1537
 ib_unregister_device_and_put+0xb9/0xf0 drivers/infiniband/core/device.c:1584
 nldev_dellink+0x2c6/0x310 drivers/infiniband/core/nldev.c:1825
 rdma_nl_rcv_skb drivers/infiniband/core/netlink.c:239 [inline]
 rdma_nl_rcv+0x6dd/0x9e0 drivers/infiniband/core/netlink.c:259
 netlink_unicast_kernel net/netlink/af_netlink.c:1321 [inline]
 netlink_unicast+0x7f6/0x990 net/netlink/af_netlink.c:1347
 netlink_sendmsg+0x8e4/0xcb0 net/netlink/af_netlink.c:1891
 sock_sendmsg_nosec net/socket.c:711 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:726
 ____sys_sendmsg+0x52a/0x7e0 net/socket.c:2583
 ___sys_sendmsg net/socket.c:2637 [inline]
 __sys_sendmsg+0x269/0x350 net/socket.c:2669
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f0561785d29
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f056259c038 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f0561976080 RCX: 00007f0561785d29
RDX: 0000000000000000 RSI: 00000000200002c0 RDI: 0000000000000009
RBP: 00007f0561801b08 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f0561976080 R15: 00007ffdce037348
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


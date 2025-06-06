Return-Path: <netdev+bounces-195458-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C30EEAD044C
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 16:56:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1233C3AFD2C
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 14:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6525D1A76BC;
	Fri,  6 Jun 2025 14:56:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7CBD14AD2B
	for <netdev@vger.kernel.org>; Fri,  6 Jun 2025 14:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749221794; cv=none; b=u83fdTSdRkzmQpeA8McZre8i9ptc0wJUmcj3c5zhOB4ENV9Yi7pqlHnaiQIkDfhFyLZeNsivCiyy00zj9kCRnd1QHJzayS522Ni3i0zmWv4Iq4L2dVz8eUWpV69zdI4CVrLDyxT0MEHBtzzJEaAv8/jDzkSZlUXj0Xbh1IqlYhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749221794; c=relaxed/simple;
	bh=Un6/u1lqCJMKeoiAiYXzAp6NLdokv78xP3NcfhlOiFM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=tfjEegry8jZX25c+gYGK1QwT8AbK0LksDTO16jg4BEVMD52wYclXm28AZjrFFbmZqs8ZZ3pNQSJtdV24r4FFqJfI4UftQO65GVu8AJ6eGifLOrIX3Su+KTOpRMD3LMLz2S2AuhkglUMQObDjLbLHlflftwUYL0eEVUqb8kKHBCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3ddc147611fso44508555ab.3
        for <netdev@vger.kernel.org>; Fri, 06 Jun 2025 07:56:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749221792; x=1749826592;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YF+eXovpI+BPFHViBf5OAfiZKlMj7V/t4795WnL00rU=;
        b=U4kBI6PCNs94JKfyk4HjNBQoiHWY14XVJYauS5wGgjygwWM6keQUWshpsD40ucEiUQ
         JvDVTVJ60Y+MDY1MUc9HBzazZLZnU3f/nEA8WC8gmP9pVJUVZWEXZFZ+0eWmhNg4OvfV
         1EZfH3sGfYJq1q8lKTBYGziGmnCNivD6ZQvYZwmBL/B67QiYHRXoee1xrm2IJ+BDSc9D
         /G+akuvkvuVr8Y7C5JkePQRdWVha95n3i3dpCC0mUDWCQnJB5S84eHWBym6x3Mz9NLNC
         4ruRpsgJE+UBptnKyyghl2mEXUa7J2g3l7Fi9MUIGawe3ZWnR9gojG9JQlzTFcmhG62a
         HrdA==
X-Forwarded-Encrypted: i=1; AJvYcCXS4sATYfwNrSSCRbWHdb9FkeVrn4qgyG/Y7yXuzxQs7xFsM/lmlyT1CSdiIIqJRmfjO1o+b5k=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb5tS3vICcC/yD34iKVNtI6ZZad2G12dNZSo0Ufz7Punsf0+Pb
	2ASDg62PITlmpHmkGZpagAr2iFmNXXj2OqOT3yTRI52lLqZ20nQlhNfEBy83q+uM/GGgWQVH7az
	MmCvimqo2sXTHB09ekw8aLepdtIahd0dU6iaF2njYjlcEUhF8kPuINlUPFgQ=
X-Google-Smtp-Source: AGHT+IFoFrrAmYlUpTD7FdSKQo72bN7Yrvawlqt2K4lsdzd6TpbdcCvkEx3s0/p4fEZWZ1kM1Nfeko7FkjTGgW4lQtakoFYCEXF7
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:4416:10b0:3dd:d348:715a with SMTP id
 e9e14a558f8ab-3ddd3487186mr12124125ab.8.1749221791701; Fri, 06 Jun 2025
 07:56:31 -0700 (PDT)
Date: Fri, 06 Jun 2025 07:56:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6843019f.a00a0220.29ac89.0044.GAE@google.com>
Subject: [syzbot] [net?] WARNING: refcount bug in gro_cleanup
From: syzbot <syzbot+9de2587cce48f5642f16@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    d0c22de9995b Merge tag 'input-for-v6.15-rc7' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1745b5f4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9fd1c9848687d742
dashboard link: https://syzkaller.appspot.com/bug?extid=9de2587cce48f5642f16
compiler:       Debian clang version 20.1.6 (++20250514063057+1e4d39e07757-1~exp1~20250514183223.118), Debian LLD 20.1.6

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b862906e9f4b/disk-d0c22de9.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c0d716f15db2/vmlinux-d0c22de9.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7ffe8e4af4ec/bzImage-d0c22de9.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9de2587cce48f5642f16@syzkaller.appspotmail.com

------------[ cut here ]------------
refcount_t: underflow; use-after-free.
WARNING: CPU: 1 PID: 8170 at lib/refcount.c:28 refcount_warn_saturate+0x11a/0x1d0 lib/refcount.c:28
Modules linked in:
CPU: 1 UID: 0 PID: 8170 Comm: syz.4.605 Not tainted 6.15.0-rc7-syzkaller-00152-gd0c22de9995b #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
RIP: 0010:refcount_warn_saturate+0x11a/0x1d0 lib/refcount.c:28
Code: 80 aa c1 8b e8 e7 52 cb fc 90 0f 0b 90 90 eb d7 e8 4b f6 06 fd c6 05 67 3c b0 0a 01 90 48 c7 c7 e0 aa c1 8b e8 c7 52 cb fc 90 <0f> 0b 90 90 eb b7 e8 2b f6 06 fd c6 05 44 3c b0 0a 01 90 48 c7 c7
RSP: 0018:ffffc9000419f628 EFLAGS: 00010246
RAX: b3f3c577eef85a00 RBX: 0000000000000003 RCX: 0000000000080000
RDX: ffffc9001071e000 RSI: 000000000007ffff RDI: 0000000000080000
RBP: 0000000000000000 R08: ffffffff8f7f3577 R09: 1ffffffff1efe6ae
R10: dffffc0000000000 R11: fffffbfff1efe6af R12: dffffc0000000000
R13: 4888ffffe8ffffc8 R14: ffffe8ffffc8496e R15: ffffe8ffffc8488a
FS:  00007f92701cb6c0(0000) GS:ffff8881261c2000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f0f5af71440 CR3: 00000000262e0000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 kfree_skb_reason include/linux/skbuff.h:1279 [inline]
 kfree_skb include/linux/skbuff.h:1288 [inline]
 gro_cleanup+0x300/0x640 net/core/gro.c:815
 __netif_napi_del_locked+0x2e0/0x3c0 net/core/dev.c:7301
 __netif_napi_del include/linux/netdevice.h:2876 [inline]
 gro_cells_destroy+0x16a/0x430 net/core/gro_cells.c:117
 ip_tunnel_dev_free+0x19/0x30 net/ipv4/ip_tunnel.c:1102
 netdev_run_todo+0xcd7/0xea0 net/core/dev.c:11300
 setup_net+0x5db/0x830 net/core/net_namespace.c:392
 copy_net_ns+0x32e/0x590 net/core/net_namespace.c:518
 create_new_namespaces+0x3d3/0x700 kernel/nsproxy.c:110
 copy_namespaces+0x438/0x4b0 kernel/nsproxy.c:179
 copy_process+0x1700/0x3b80 kernel/fork.c:2433
 kernel_clone+0x21e/0x870 kernel/fork.c:2845
 __do_sys_clone kernel/fork.c:2988 [inline]
 __se_sys_clone kernel/fork.c:2972 [inline]
 __x64_sys_clone+0x18b/0x1e0 kernel/fork.c:2972
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xf6/0x210 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f926f38e969
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f92701cafe8 EFLAGS: 00000206 ORIG_RAX: 0000000000000038
RAX: ffffffffffffffda RBX: 00007f926f5b6160 RCX: 00007f926f38e969
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000042000000
RBP: 00007f926f410ab1 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000206 R12: 0000000000000000
R13: 0000000000000001 R14: 00007f926f5b6160 R15: 00007fff8df30f78
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


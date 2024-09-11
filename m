Return-Path: <netdev+bounces-127248-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16597974BF4
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 10:00:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38BB71C2202A
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 08:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEBA013D539;
	Wed, 11 Sep 2024 08:00:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273B67DA9E
	for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 08:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726041625; cv=none; b=A/aCzxhIgR1j+M/oBqfEcS7mapi70LY526Ea8mhcHFwLt7Xa9bNm1FgGLTq+3pLweWgSyRaCH5IQjXBQ7OnxJMaxjPNEdb7eggRgGjEVQ5Dw7DlU6EOJ3RMw5hXVpWMcUzT5ETZ1Pg8arBDmb/tjW7PciaBY42e+U3atSucg6Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726041625; c=relaxed/simple;
	bh=XzSL3uEl42kiOW8dM1fvjQp68nYNKVjZnTaYr0q36HY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=nxi+9CNXWHM0fpzMklPjv2uWBUmmrZBvw+a3EIu+y2rvkLQwN4syOKw549WgJjWQNN6OmWhdL4fHwYENg+uTvDfCjYBy30g3RxfFgPdWXXkG6t/A6kLmjknvqVQCpZvWmHM2lWjROFhnmUKpmO2n0Lm6UcHnQ1zWISpS10RXKzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-82a32368e13so1532817539f.0
        for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 01:00:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726041623; x=1726646423;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t/voDSYt1SzgZmPZGI/JD1Kv6UKBK/sFWlozCEYhxZo=;
        b=Crwy6yG/cuEUmWf+Wg9IMoKAolticy9Wl5WAg1ZPITxp11qtBM8jUuOj8hDCp02uV3
         89BVzJnuVJT7h96Q5Ntpj0/uaHqk4Bik86ED1AG+780K8DBacx1Pdu3YW5cXPX9hCeSJ
         7Ah+XgJWvPrcyyZdW1oZYO5H8WgEXLTp2QRi/8//o5ptYCEvJxjyn2AQSMVZoV8lC2EN
         uPkOseZnTzLpR8mct+qtL2+nNdbbi7mZHLxnelV5R1n+EVTGLUJ+0DnqQWVGaFZLb/ej
         F1b5mpwxjl3iliQGSZYV662Dy/aDx7wJORv7cZqLtSWitaVwhnimV0TVkJxu5bUgHihs
         sxsQ==
X-Forwarded-Encrypted: i=1; AJvYcCVcBuFZ0Gx8jzmC1zdV2IfexBi5BCk9Ao2/x7dSBjCWVXlm0C/GLth2j+MTmKvd9ApFHpKhWQU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSkGr9rQazI7vxUeQ/W6V/QjDsiBnqTmmwB61LvfZB8ViCOr/A
	3nFOI0nJZW/mD/1rvk2EqCbx8/P6t82v+uw+iizYXPVJi6zDURTNGeosoRiIHgxf2NAaqQFKUY0
	4HJu88BDAZ6Y3V/ExecleHkI+fqVBT53mQUYGlrWnAJd0WOU1XQEFwiQ=
X-Google-Smtp-Source: AGHT+IEdYwRaPQ3xaDCxB93TJRyXKBW/rUBEIjOkjQ4K/N7y3zfKBL6k20KH4paA6orRPIMqJO+gRCD+4MKzLU4adaLxatvgY3DK
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:27c2:b0:82a:539b:9838 with SMTP id
 ca18e2360f4ac-82a9a256c42mr2089226839f.5.1726041623342; Wed, 11 Sep 2024
 01:00:23 -0700 (PDT)
Date: Wed, 11 Sep 2024 01:00:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d3bf150621d361a7@google.com>
Subject: [syzbot] [net?] WARNING: refcount bug in ethnl_phy_done
From: syzbot <syzbot+e9ed4e4368d450c8f9db@syzkaller.appspotmail.com>
To: christophe.leroy@csgroup.eu, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, maxime.chevallier@bootlin.com, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    a9b1fab3b69f Merge branch 'ionic-convert-rx-queue-buffers-..
git tree:       net-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1193c49f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=37742f4fda0d1b09
dashboard link: https://syzkaller.appspot.com/bug?extid=e9ed4e4368d450c8f9db
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14bb7bc7980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17b0a100580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/0459f959b12d/disk-a9b1fab3.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/337f1be5353b/vmlinux-a9b1fab3.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0e3701969c4a/bzImage-a9b1fab3.xz

The issue was bisected to:

commit 17194be4c8e1e82d8b484e58cdcb495c0714d1fd
Author: Maxime Chevallier <maxime.chevallier@bootlin.com>
Date:   Wed Aug 21 15:10:01 2024 +0000

    net: ethtool: Introduce a command to list PHYs on an interface

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1034a49f980000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1234a49f980000
console output: https://syzkaller.appspot.com/x/log.txt?x=1434a49f980000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e9ed4e4368d450c8f9db@syzkaller.appspotmail.com
Fixes: 17194be4c8e1 ("net: ethtool: Introduce a command to list PHYs on an interface")

------------[ cut here ]------------
refcount_t: decrement hit 0; leaking memory.
WARNING: CPU: 0 PID: 5227 at lib/refcount.c:31 refcount_warn_saturate+0xfa/0x1d0 lib/refcount.c:31
Modules linked in:
CPU: 0 UID: 0 PID: 5227 Comm: syz-executor281 Not tainted 6.11.0-rc6-syzkaller-01235-ga9b1fab3b69f #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
RIP: 0010:refcount_warn_saturate+0xfa/0x1d0 lib/refcount.c:31
Code: b2 00 00 00 e8 e7 09 e1 fc 5b 5d c3 cc cc cc cc e8 db 09 e1 fc c6 05 56 d4 4f 0b 01 90 48 c7 c7 c0 3b 60 8c e8 f7 2d a3 fc 90 <0f> 0b 90 90 eb d9 e8 bb 09 e1 fc c6 05 33 d4 4f 0b 01 90 48 c7 c7
RSP: 0018:ffffc900033ff048 EFLAGS: 00010246
RAX: 033d767773c83300 RBX: ffff88802f8d0664 RCX: ffff8880506e0000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000004 R08: ffffffff8155b372 R09: 1ffff1101710519a
R10: dffffc0000000000 R11: ffffed101710519b R12: ffff88802f8d0620
R13: 0000000000000000 R14: ffff88802f8d0664 R15: dffffc0000000000
FS:  00005555884f4380(0000) GS:ffff8880b8800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055c9aad930a8 CR3: 0000000052acc000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __refcount_dec include/linux/refcount.h:336 [inline]
 refcount_dec include/linux/refcount.h:351 [inline]
 ref_tracker_free+0x6af/0x7e0 lib/ref_tracker.c:236
 netdev_tracker_free include/linux/netdevice.h:4057 [inline]
 netdev_put include/linux/netdevice.h:4074 [inline]
 ethnl_parse_header_dev_put net/ethtool/netlink.h:271 [inline]
 ethnl_phy_done+0x6f/0x100 net/ethtool/phy.c:238
 genl_done+0x136/0x210 net/netlink/genetlink.c:1043
 netlink_dump+0x9b2/0xd80 net/netlink/af_netlink.c:2370
 __netlink_dump_start+0x5a2/0x790 net/netlink/af_netlink.c:2440
 genl_family_rcv_msg_dumpit net/netlink/genetlink.c:1076 [inline]
 genl_family_rcv_msg net/netlink/genetlink.c:1192 [inline]
 genl_rcv_msg+0x88c/0xec0 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2550
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
 netlink_unicast+0x7f6/0x990 net/netlink/af_netlink.c:1357
 netlink_sendmsg+0x8e4/0xcb0 net/netlink/af_netlink.c:1901
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:745
 ____sys_sendmsg+0x525/0x7d0 net/socket.c:2597
 ___sys_sendmsg net/socket.c:2651 [inline]
 __sys_sendmsg+0x2b0/0x3a0 net/socket.c:2680
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f7cf874a219
Code: 48 83 c4 28 c3 e8 e7 18 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffff97db218 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007ffff97db3e8 RCX: 00007f7cf874a219
RDX: 0000000000000000 RSI: 0000000020001900 RDI: 0000000000000003
RBP: 00007f7cf87bc610 R08: 00007ffff97db3e8 R09: 00007ffff97db3e8
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 00007ffff97db3d8 R14: 0000000000000001 R15: 0000000000000001
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

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


Return-Path: <netdev+bounces-171630-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49F43A4DE7C
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 13:56:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57C75189392C
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 12:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F05C720298E;
	Tue,  4 Mar 2025 12:56:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4546A202974
	for <netdev@vger.kernel.org>; Tue,  4 Mar 2025 12:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741092988; cv=none; b=clEGJ4Nq9W5z3ErOAbRE1JiCoQLYxfPxn8So7q4dH2Ygo/ajUrN3eZA5ZplfwFWpRRTKqt/tKxwdZvdnIofdifydDjS+0UeukaFAcRDYN2RVQGKjip2SA85F4yXr3u7iKIskK4sPv9FatKrs2QJn3aXLsae2gnoLBW3yiSWhY6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741092988; c=relaxed/simple;
	bh=tFV+w7TWY7jo9482abo8pztgev2gIXyeuH5xdFjXKnk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=p/oTCYE3GIfcJmbkMIdGF1NsBQc3RHEMzJK1TDVuAoXdNxOFmIDsbp7HLT05gy1K486GfgSmg1bA2nY1lTc1+eS+E0ZIlPkoKG69/VfANc79mCD5/aYOk4qfghS61oB8rMXopZ7BlA/UOjK0R8D80/kaQJDaYfFoAbHQDEDkeKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3ce3bbb2b9dso58938905ab.3
        for <netdev@vger.kernel.org>; Tue, 04 Mar 2025 04:56:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741092986; x=1741697786;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N2glMWByL/wI47Kll6g78vVHjREEEW+lOAunp+n8NgQ=;
        b=V4/XtjYmhhuD5dOPSAoiyhcEkvLLI31r57GoUvIBWXOy92kTHcgH12y3hvHTX5POPt
         UFRPLjSYlz1/7KaLO4hxQq/Ctq2GZ074BZqfnXonGBu7jn/0NFlV7S3fMVmHm8zuUU96
         oyR2CeHYncWtm0GRo5EB2ZrmGDUeBV/tgMJQey7GtPt3EgSP8pxlIogrg701ZAKw8mQN
         uAFUjqNrZun0wa+Hk9RgPV4cmXtmZQosKKKOD/aLp7y0l/PWNZx0Bj4PlqF8zaKw9gyQ
         mdE2R0a8UDhQmhYvLs+uJIxrQ9o1WctItfepL36WVU1vl0Q9PhaphfQRY89bZQtaVc2n
         4fuw==
X-Forwarded-Encrypted: i=1; AJvYcCVsxFbP4ByNUtEHZgTceWNu8qriQ/9QsQqhGU2ok8MW098KkR+ziU/Z4VVdxvk3OWs0wrw3t9s=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz75BvWJAILM54v6pQoiMHLNZPO8H1nmvhQk34dQLzqjzhpkPM
	nTNKUhium2CbWf3mkmtT67IjA9NWniimXdKBqnN7xiO0XFShMZ7fJU0Ut5y1UaiQrE2dnVeDNX4
	uxyibqBhwjRTacjfT9iJx30Olz6v/od9xhv76R/VIDEIh9T5+cy3E+A0=
X-Google-Smtp-Source: AGHT+IF2jahUempvW1wu7ZIejgAVLOLZLgZrMkuLxbA3N/OvkxxGK22tiHRSkjSvxi30/ndNea4vJ+QS5K+ODMDv9qxfVCzReviO
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:10:b0:3d0:47cf:869c with SMTP id
 e9e14a558f8ab-3d3e6f639a8mr165107455ab.19.1741092986385; Tue, 04 Mar 2025
 04:56:26 -0800 (PST)
Date: Tue, 04 Mar 2025 04:56:26 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67c6f87a.050a0220.38b91b.0147.GAE@google.com>
Subject: [syzbot] [net?] WARNING: bad unlock balance in __rtnl_unlock
From: syzbot <syzbot+3f18ef0f7df107a3f6a0@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, kuniyu@amazon.com, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    3424291dd242 Merge branch 'ipv4-fib-convert-rtm_newroute-a..
git tree:       net-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=17140697980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1770b825960d3ae8
dashboard link: https://syzkaller.appspot.com/bug?extid=3f18ef0f7df107a3f6a0
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=117ce464580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=157ce464580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/94c5b9f4e9a5/disk-3424291d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2c19be66773b/vmlinux-3424291d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/5defd4d4c3bb/bzImage-3424291d.xz

The issue was bisected to:

commit 1dd2af7963e95df90590fe40425fe1bdf982ae8f
Author: Kuniyuki Iwashima <kuniyu@amazon.com>
Date:   Fri Feb 28 04:23:28 2025 +0000

    ipv4: fib: Convert RTM_NEWROUTE and RTM_DELROUTE to per-netns RTNL.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15581464580000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=17581464580000
console output: https://syzkaller.appspot.com/x/log.txt?x=13581464580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3f18ef0f7df107a3f6a0@syzkaller.appspotmail.com
Fixes: 1dd2af7963e9 ("ipv4: fib: Convert RTM_NEWROUTE and RTM_DELROUTE to per-netns RTNL.")

netlink: 'syz-executor245': attribute type 11 has an invalid length.
=====================================
WARNING: bad unlock balance detected!
6.14.0-rc4-syzkaller-00873-g3424291dd242 #0 Not tainted
-------------------------------------
syz-executor245/5836 is trying to release lock (rtnl_mutex) at:
[<ffffffff89d0e38c>] __rtnl_unlock+0x6c/0xf0 net/core/rtnetlink.c:142
but there are no more locks to release!

other info that might help us debug this:
no locks held by syz-executor245/5836.

stack backtrace:
CPU: 0 UID: 0 PID: 5836 Comm: syz-executor245 Not tainted 6.14.0-rc4-syzkaller-00873-g3424291dd242 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_unlock_imbalance_bug+0x25b/0x2d0 kernel/locking/lockdep.c:5289
 __lock_release kernel/locking/lockdep.c:5518 [inline]
 lock_release+0x47e/0xa30 kernel/locking/lockdep.c:5872
 __mutex_unlock_slowpath+0xec/0x800 kernel/locking/mutex.c:891
 __rtnl_unlock+0x6c/0xf0 net/core/rtnetlink.c:142
 lwtunnel_valid_encap_type+0x38a/0x5f0 net/core/lwtunnel.c:169
 lwtunnel_valid_encap_type_attr+0x113/0x270 net/core/lwtunnel.c:209
 rtm_to_fib_config+0x949/0x14e0 net/ipv4/fib_frontend.c:808
 inet_rtm_newroute+0xf6/0x2a0 net/ipv4/fib_frontend.c:917
 rtnetlink_rcv_msg+0x791/0xcf0 net/core/rtnetlink.c:6919
 netlink_rcv_skb+0x206/0x480 net/netlink/af_netlink.c:2534
 netlink_unicast_kernel net/netlink/af_netlink.c:1313 [inline]
 netlink_unicast+0x7f6/0x990 net/netlink/af_netlink.c:1339
 netlink_sendmsg+0x8de/0xcb0 net/netlink/af_netlink.c:1883
 sock_sendmsg_nosec net/socket.c:709 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:724
 ____sys_sendmsg+0x53a/0x860 net/socket.c:2564
 ___sys_sendmsg net/socket.c:2618 [inline]
 __sys_sendmsg+0x269/0x350 net/socket.c:2650
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f09df9913e9
Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd5288a738 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007ffd5288a908 RCX: 00007f09df9913e9
RDX: 0000000000000000 RSI: 0000400000000000 RDI: 0000000000000003
RBP: 00007f09dfa04610 R08: 0000000000000000 R09: 00007ffd5288a908
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 00007ffd5288a8f8 R14: 0000000000000001 R15: 0000000000000001


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


Return-Path: <netdev+bounces-121846-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E5B95F039
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 13:57:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1360D1C21507
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 11:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9BC415532A;
	Mon, 26 Aug 2024 11:57:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3365D14A617
	for <netdev@vger.kernel.org>; Mon, 26 Aug 2024 11:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724673444; cv=none; b=fkn4zqADcGho/BV/YDQy5dDz30G6jlDs6stpd29V8poohil29nzw4HLlzDU79mMNgj2sQiQX1/5VGtx6g8WD5SF3uRLLrnyrKMYekTb5+d/TUWaGKTcRY6hjB+979mrSx38R4Xik2FLQuze3KyHE05IA6+X7LXR+E4JnumTiukc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724673444; c=relaxed/simple;
	bh=r33ve7K0Bp24Z/xmovy+0h55Hea54qCCjlcIV0bapL0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=LybSFDz7kj6ElGvE+H/tF0+/ttV1qauDgVISWx7vwxnK6R3EUSmzkJu1liqaSv0gub93RZSeeWP92R67CddbTp5f9R7KUP4SUgU2wQ/VXwitpOOyegDKzt7EBbqdjD19gEwyMzR0MfVBECT5Y17UzTseICkge+le4NrUVfFTzdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-39d4b5b9fa0so47867595ab.1
        for <netdev@vger.kernel.org>; Mon, 26 Aug 2024 04:57:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724673442; x=1725278242;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Kz60zS3szqBp8kNuEA6jcmN4z2x54AbFZkCJBwM+ftc=;
        b=pJf6ucfnp3qKQ8w7ahY0l+QPJpHN86ixQDPAzZeS4mUqO6ZVhNP4X00wDijGfjkELr
         9Yj8BycpJ5smOZNI6siSn12ZksefDBDs31uVWjxCB0jWrgWRbXg+9IIP+0yHkd6IvzXV
         cFNt7ZbtPhhF2cyUCq53iUguCC3ixQyRR+B4lBFK3uualJETJKoHe0iu/sU2shu6J8zD
         1bxMYF4cagbYtKC5AkP3UzIKe6zmBRR5LS0yDkbreQwWh9L++fPjFJ1kBWVhu7j01iXT
         q9xNIs2B/kWbeEK1L6VwaJbSWia0t4EdIKo2CUG7gCSEbhpA/Kc6Lwu9awom7D0l/Ire
         fvmQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5Kdq49bfM5YVrehqAJ1X1Y3/nHVBvf40t1LbAZh4WPS7kOEWNOvEdUtu6DgLfxu/W3pq73ME=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVJ3Lxwj+uzIK7+nxokWgddDs+euxpX619j3Dokbx8QHgP/ZNk
	C2GB9mkOUL5fqPWWLXRDlUB+Epr9mE57cOdLO3S2dqGcVOgZIlGqX/eTBGlI1bNULLHVC+hH3K5
	LGtlxo5vA/d3L6iEgksV2eNJlU5uI93EEa38cIf2cnx4GLVS0Pc+R/Lc=
X-Google-Smtp-Source: AGHT+IHhZSiWyZlvAw28soGfnGwpp8LkcEc7PiXdKkIQP/LhJU/V+Se60taSN78oQz8BOQvdicXB7J3heplpjWbNnhzPGlWibqAR
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a48:b0:39d:1a4c:b853 with SMTP id
 e9e14a558f8ab-39e3ca20521mr8969565ab.6.1724673442342; Mon, 26 Aug 2024
 04:57:22 -0700 (PDT)
Date: Mon, 26 Aug 2024 04:57:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e275e7062094d357@google.com>
Subject: [syzbot] [net?] WARNING in page_pool_put_unrefed_netmem
From: syzbot <syzbot+f56a5c5eac2b28439810@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, hawk@kernel.org, 
	ilias.apalodimas@linaro.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    f8669d7b5f5d selftests: mlxsw: ethtool_lanes: Source ethto..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=1226e82b980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7229118d88b4a71b
dashboard link: https://syzkaller.appspot.com/bug?extid=f56a5c5eac2b28439810
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f133b08fc016/disk-f8669d7b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/cfb0b52565a2/vmlinux-f8669d7b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/95ca2ede3285/bzImage-f8669d7b.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f56a5c5eac2b28439810@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 9150 at net/core/page_pool.c:709 __page_pool_put_page net/core/page_pool.c:709 [inline]
WARNING: CPU: 1 PID: 9150 at net/core/page_pool.c:709 page_pool_put_unrefed_netmem+0x157/0xa40 net/core/page_pool.c:780
Modules linked in:
CPU: 1 UID: 0 PID: 9150 Comm: syz.1.1052 Not tainted 6.11.0-rc3-syzkaller-00202-gf8669d7b5f5d #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
RIP: 0010:__page_pool_put_page net/core/page_pool.c:709 [inline]
RIP: 0010:page_pool_put_unrefed_netmem+0x157/0xa40 net/core/page_pool.c:780
Code: 74 0e e8 7c aa fb f7 eb 43 e8 75 aa fb f7 eb 3c 65 8b 1d 38 a8 6a 76 31 ff 89 de e8 a3 ae fb f7 85 db 74 0b e8 5a aa fb f7 90 <0f> 0b 90 eb 1d 65 8b 1d 15 a8 6a 76 31 ff 89 de e8 84 ae fb f7 85
RSP: 0018:ffffc9000bda6b58 EFLAGS: 00010083
RAX: ffffffff8997e523 RBX: 0000000000000000 RCX: 0000000000040000
RDX: ffffc9000fbd0000 RSI: 0000000000001842 RDI: 0000000000001843
RBP: 0000000000000000 R08: ffffffff8997df2c R09: 1ffffd40003a000d
R10: dffffc0000000000 R11: fffff940003a000e R12: ffffea0001d00040
R13: ffff88802e8a4000 R14: dffffc0000000000 R15: 00000000ffffffff
FS:  00007fb7aaf716c0(0000) GS:ffff8880b9300000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fa15a0d4b72 CR3: 00000000561b0000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 tun_ptr_free drivers/net/tun.c:617 [inline]
 __ptr_ring_swap_queue include/linux/ptr_ring.h:571 [inline]
 ptr_ring_resize_multiple_noprof include/linux/ptr_ring.h:643 [inline]
 tun_queue_resize drivers/net/tun.c:3694 [inline]
 tun_device_event+0xaaf/0x1080 drivers/net/tun.c:3714
 notifier_call_chain+0x19f/0x3e0 kernel/notifier.c:93
 call_netdevice_notifiers_extack net/core/dev.c:2032 [inline]
 call_netdevice_notifiers net/core/dev.c:2046 [inline]
 dev_change_tx_queue_len+0x158/0x2a0 net/core/dev.c:9024
 do_setlink+0xff6/0x41f0 net/core/rtnetlink.c:2923
 rtnl_setlink+0x40d/0x5a0 net/core/rtnetlink.c:3201
 rtnetlink_rcv_msg+0x73f/0xcf0 net/core/rtnetlink.c:6647
 netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2550
 netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
 netlink_unicast+0x7f0/0x990 net/netlink/af_netlink.c:1357
 netlink_sendmsg+0x8e4/0xcb0 net/netlink/af_netlink.c:1901
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:745
 ____sys_sendmsg+0x525/0x7d0 net/socket.c:2597
 ___sys_sendmsg net/socket.c:2651 [inline]
 __sys_sendmsg+0x2b0/0x3a0 net/socket.c:2680
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fb7aa179e79
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fb7aaf71038 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007fb7aa315f80 RCX: 00007fb7aa179e79
RDX: 0000000000000000 RSI: 0000000020000140 RDI: 000000000000000c
RBP: 00007fb7aa1e7916 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fb7aa315f80 R15: 00007ffc2107dec8
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


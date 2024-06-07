Return-Path: <netdev+bounces-101657-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E7D528FFBCD
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 08:03:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53C8FB23C39
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 06:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 501CA14F102;
	Fri,  7 Jun 2024 06:03:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD35C18AF4
	for <netdev@vger.kernel.org>; Fri,  7 Jun 2024 06:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717740201; cv=none; b=rltndFXuMpNdKe8oY6ehk9PYqacuc3u632aDvBXVjvNcqV0Lh2zvm/JLeLyXu8vLWO22gVmQ+oHJhWrSnX4S8AQEpNBD5dzw9GF0Y7taRSwVCGtuQ60psuS+qHRYdSDh/Ef3BUu8hBdygf+20qFE/IX5IwNIJY3K5IpLeuSsJyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717740201; c=relaxed/simple;
	bh=SFJmRzdq7tEFU8yOOe/q0W7DCeJ/QLfi2njszS/hpgc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=U9ZwkQv1kQZ0MrW4sJfDSE1uNtBYILb/CFBxDRZoZqjMKce0kTIwUS/CAJI82Z3NV59T01TA8uz4xreHnuvw4iKug4MeJ3oNraObOFRKonPoAbALtn/SsTH6leHn3Nv0oRsI8mmIbbDX2PtkTiWSmsB7/CF+U3Wie1/+lubtZJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-374ad7fa4bbso18034115ab.2
        for <netdev@vger.kernel.org>; Thu, 06 Jun 2024 23:03:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717740199; x=1718344999;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vwDqcFGW6wzuDnM1PhkLbZaSGzwhVM71SbuWVC05qkA=;
        b=XpvaM4SIfmA+Yo5M7JZ3BuTtjVq7GYeDjZKObZfHVttk6lj0Jd+SFAW8TzHQMxU5jr
         XwwSFqM3eGDKdu2KjHyYDySCoQ38V+q5MOlHyv2/apCCdbLmdq4Jgy/OnUDvKN2JcXGe
         cK67ujczF7U7UHB0CW5QkCe4DRyjuWjAYVbQXKR74V+twKJYZfR0/GeMEeKft9FcSR7S
         h8uADHU+7Yyf+Yqy9UV7wzfdZ0eZMaM1XpLRIXjYAmPRyJDk9A12ae6IrAmEcpKFVnst
         TGY8/oAq+LzuuEU28yqDBaNlhE5QxZbWn7J+kLRfDqOeHsaReLViaC9Te6fNaVLOCcSY
         xaPw==
X-Forwarded-Encrypted: i=1; AJvYcCVJQP/n+tZpPywJFdKDbc/gLeBb8PnpQqf1AKhfX12unIXdpHVw6UiKdOD07T96SRXhlqCikW+ghBbq95QB6eRXJG0COrN/
X-Gm-Message-State: AOJu0Yx7/0Wu8jpWGJ48qj7WdBz8Z1eqIA5usl8eDIRzMPrk7ljGdTL1
	ygchHFjp+rd5N6JsD69KhrPq6c0NDZaG1M0YmF2OVdcyBMu+a2Ajj7kzrGypBozvYZjPt8++P0G
	ZnNOsIFD0vHu/874fkMwNQoee9JI2yhggqM7FuCgAAMWtQQf85grlguI=
X-Google-Smtp-Source: AGHT+IEOtIL4LLp1zVxVdE2Vtemw3M/sNeD+OGVocWHXXbciZMuWddAfnaoUTsA31kNct1LoMlZnj7ao3VWqC73FFjZ/WMCz/i0L
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1aae:b0:374:a840:e5cf with SMTP id
 e9e14a558f8ab-37580234159mr1018295ab.0.1717740198792; Thu, 06 Jun 2024
 23:03:18 -0700 (PDT)
Date: Thu, 06 Jun 2024 23:03:18 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005d9e59061a468ed3@google.com>
Subject: [syzbot] [net?] INFO: task hung in __tun_chr_ioctl (6)
From: syzbot <syzbot+26c7b4c3afe5450b3e15@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, jasowang@redhat.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com, 
	willemdebruijn.kernel@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    71d7b52cc33b Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1259b316980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=399230c250e8119c
dashboard link: https://syzkaller.appspot.com/bug?extid=26c7b4c3afe5450b3e15
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/910b86eac08b/disk-71d7b52c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a5a6ad2a9a6c/vmlinux-71d7b52c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ad7485d12317/bzImage-71d7b52c.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+26c7b4c3afe5450b3e15@syzkaller.appspotmail.com

INFO: task syz-executor.3:5788 blocked for more than 143 seconds.
      Not tainted 6.10.0-rc2-syzkaller-00064-g71d7b52cc33b #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.3  state:D stack:28496 pid:5788  tgid:5786  ppid:5116   flags:0x00000006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5408 [inline]
 __schedule+0xf15/0x5d00 kernel/sched/core.c:6745
 __schedule_loop kernel/sched/core.c:6822 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6837
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6894
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x5b8/0x9c0 kernel/locking/mutex.c:752
 __tun_chr_ioctl+0x4fc/0x4770 drivers/net/tun.c:3110
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl fs/ioctl.c:893 [inline]
 __x64_sys_ioctl+0x193/0x220 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f632567cf69
RSP: 002b:00007f63263a70c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f63257b3f80 RCX: 00007f632567cf69
RDX: 00000000200000c0 RSI: 00000000400454ca RDI: 0000000000000003
RBP: 00007f63256da6fe R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f63257b3f80 R15: 00007ffc7df747b8
 </TASK>
INFO: task syz-executor.3:5790 blocked for more than 143 seconds.
      Not tainted 6.10.0-rc2-syzkaller-00064-g71d7b52cc33b #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.3  state:D stack:28480 pid:5790  tgid:5786  ppid:5116   flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5408 [inline]
 __schedule+0xf15/0x5d00 kernel/sched/core.c:6745
 __schedule_loop kernel/sched/core.c:6822 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6837
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6894
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x5b8/0x9c0 kernel/locking/mutex.c:752
 devinet_ioctl+0x26e/0x1f10 net/ipv4/devinet.c:1101
 inet_ioctl+0x3aa/0x3f0 net/ipv4/af_inet.c:1003
 packet_ioctl+0xb3/0x280 net/packet/af_packet.c:4256
 sock_do_ioctl+0x116/0x280 net/socket.c:1222
 sock_ioctl+0x22e/0x6c0 net/socket.c:1341
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl fs/ioctl.c:893 [inline]
 __x64_sys_ioctl+0x193/0x220 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f632567cf69
RSP: 002b:00007f63263860c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f63257b4050 RCX: 00007f632567cf69
RDX: 0000000020000180 RSI: 0000000000008914 RDI: 0000000000000004
RBP: 00007f63256da6fe R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000006e R14: 00007f63257b4050 R15: 00007ffc7df747b8
 </TASK>
INFO: task syz-executor.0:5798 blocked for more than 144 seconds.
      Not tainted 6.10.0-rc2-syzkaller-00064-g71d7b52cc33b #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.0  state:D stack:27280 pid:5798  tgid:5796  ppid:5258   flags:0x00000006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5408 [inline]
 __schedule+0xf15/0x5d00 kernel/sched/core.c:6745
 __schedule_loop kernel/sched/core.c:6822 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6837
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6894
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x5b8/0x9c0 kernel/locking/mutex.c:752
 nl80211_pre_doit+0xb4/0xb10 net/wireless/nl80211.c:16405
 genl_family_rcv_msg_doit+0x1be/0x2f0 net/netlink/genetlink.c:1110
 genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
 genl_rcv_msg+0x565/0x800 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x16b/0x440 net/netlink/af_netlink.c:2564
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1335 [inline]
 netlink_unicast+0x542/0x820 net/netlink/af_netlink.c:1361
 netlink_sendmsg+0x8b8/0xd70 net/netlink/af_netlink.c:1905
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg net/socket.c:745 [inline]
 ____sys_sendmsg+0xab5/0xc90 net/socket.c:2585
 ___sys_sendmsg+0x135/0x1e0 net/socket.c:2639


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


Return-Path: <netdev+bounces-112926-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EF8893BF04
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 11:25:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4525B282395
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 09:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A30DA16DC00;
	Thu, 25 Jul 2024 09:25:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192C113A414
	for <netdev@vger.kernel.org>; Thu, 25 Jul 2024 09:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721899525; cv=none; b=BsK+Mf5e45U6PEVGshJnYH9hwnvrneMBfr+EYNz1MUCuk9jCB0vXlGZ5Lb+y5at2Ko7essSARnLc8h4XoQjvLWMXCDK4WMhiLbCKc/TGDdM6DZp2cmQ1CUfojNJOZguwmfecS6GN9r/T12pSStHQxsj6zBXuGtbFid6xQXRHgEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721899525; c=relaxed/simple;
	bh=7+pTOH70jbWhWoxBAjAx7SkOLjGys8ogsCmYQxJKZic=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=e0r0DmwT8iEZmUabfhGXymGsTtXGb+uH3C/T8xEXrzj7fBB+Kd1Jsp0bgP00hKFW8JO5buQZGdfK78FC3gq/P/z94MM3ZCd6dTuXv81EhS4AWS9raVLmNC98XrGBckGa8H0FQQzjG+Lz8PQFhyLfBdosjApocusvTcRSZ9h3tzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-81f7fb0103fso49297039f.0
        for <netdev@vger.kernel.org>; Thu, 25 Jul 2024 02:25:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721899523; x=1722504323;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LjodSsB9JtA/9m/UKEOeRSgXZ/EYlSu/L2hWiwbPn6Y=;
        b=atVeChVHVBaP+j92CdC9+E8tBB7PPQP1poO7BhmMfEQqiTCIv5He+tCtwbIntDmy2V
         41b84CPc3qeKYPZT5ffNbSmFNZF8/XKd6B/6DG7fywK/p9XH7YDakg0f+F6mq9pVvbs5
         dJQOQ+KWk3yNV7xTUXWiDPL1Dw4iMa1JNQ1P+8uFXwWxrDx7AKUUKFgvOLX9v6x1Cfmf
         S4witdKvqEhHNkqwz723EI20PwJQWkUqPBC6GiSmlZAeemWGv0Wy0OZgbT2tltfW3Uhm
         udX7ybahJfmjhfv96you8znqVbxz5gA2n8tkacuZFTqlzFSjFHdbLDu2cVTzXf5dv+c3
         lK2A==
X-Forwarded-Encrypted: i=1; AJvYcCVyc4sLHU4LDm+DyBIqPUx5NxbzvoEBK2IPvqpUPa9n7mOrNI6uk3S6R0obno7l7vZrajiMVoP1qaypJoHVTS4Y+W3K93A4
X-Gm-Message-State: AOJu0YyojmL/zehb31Lzsx+DNxg1XeXVyY+VLqClkQx97mqpHpGJYlr7
	/1wptliCE2UwLEiBd61yTrSQtmiKzej5KY0NhL2YVkfQSKdYBJJjafIMk4mev1elrJyZyRcSCeb
	WpuYYkq4idWMC07ZxwyWuZi4ZslOOP1iWjRTP0naOHCnyeF7xQZEf8yI=
X-Google-Smtp-Source: AGHT+IHNZo0QRqKrtwAT4xad4uFv0IYOpncHq78GT7NoGFn/TRNjsDl6ZnR41uLR+vRJBXDevK8zogWqkZXJbmkTXJX7TYwOk3ox
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cc0f:0:b0:380:e1e4:4ba3 with SMTP id
 e9e14a558f8ab-39a1a7cc450mr1102225ab.2.1721899523301; Thu, 25 Jul 2024
 02:25:23 -0700 (PDT)
Date: Thu, 25 Jul 2024 02:25:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006cf49f061e0ef955@google.com>
Subject: [syzbot] [net?] KMSAN: uninit-value in tcf_ct_flow_table_get
From: syzbot <syzbot+1b5e4e187cc586d05ea0@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, jhs@mojatatu.com, 
	jiri@resnulli.us, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com, 
	xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    2c9b3512402e Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=11d643fd980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6bfb33a8ad10458f
dashboard link: https://syzkaller.appspot.com/bug?extid=1b5e4e187cc586d05ea0
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17495ec3980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=126076b5980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f8543636ba6c/disk-2c9b3512.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/403c612b7ac5/vmlinux-2c9b3512.xz
kernel image: https://storage.googleapis.com/syzbot-assets/88dc686d170a/bzImage-2c9b3512.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1b5e4e187cc586d05ea0@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in rht_ptr_rcu include/linux/rhashtable.h:376 [inline]
BUG: KMSAN: uninit-value in __rhashtable_lookup include/linux/rhashtable.h:607 [inline]
BUG: KMSAN: uninit-value in rhashtable_lookup include/linux/rhashtable.h:646 [inline]
BUG: KMSAN: uninit-value in rhashtable_lookup_fast include/linux/rhashtable.h:672 [inline]
BUG: KMSAN: uninit-value in tcf_ct_flow_table_get+0x611/0x2260 net/sched/act_ct.c:329
 rht_ptr_rcu include/linux/rhashtable.h:376 [inline]
 __rhashtable_lookup include/linux/rhashtable.h:607 [inline]
 rhashtable_lookup include/linux/rhashtable.h:646 [inline]
 rhashtable_lookup_fast include/linux/rhashtable.h:672 [inline]
 tcf_ct_flow_table_get+0x611/0x2260 net/sched/act_ct.c:329
 tcf_ct_init+0xa67/0x2890 net/sched/act_ct.c:1408
 tcf_action_init_1+0x6cc/0xb30 net/sched/act_api.c:1425
 tcf_action_init+0x458/0xf00 net/sched/act_api.c:1488
 tcf_action_add net/sched/act_api.c:2061 [inline]
 tc_ctl_action+0x4be/0x19d0 net/sched/act_api.c:2118
 rtnetlink_rcv_msg+0x12fc/0x1410 net/core/rtnetlink.c:6647
 netlink_rcv_skb+0x375/0x650 net/netlink/af_netlink.c:2550
 rtnetlink_rcv+0x34/0x40 net/core/rtnetlink.c:6665
 netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
 netlink_unicast+0xf52/0x1260 net/netlink/af_netlink.c:1357
 netlink_sendmsg+0x10da/0x11e0 net/netlink/af_netlink.c:1901
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x30f/0x380 net/socket.c:745
 ____sys_sendmsg+0x877/0xb60 net/socket.c:2597
 ___sys_sendmsg+0x28d/0x3c0 net/socket.c:2651
 __sys_sendmsg net/socket.c:2680 [inline]
 __do_sys_sendmsg net/socket.c:2689 [inline]
 __se_sys_sendmsg net/socket.c:2687 [inline]
 __x64_sys_sendmsg+0x307/0x4a0 net/socket.c:2687
 x64_sys_call+0x2dd6/0x3c10 arch/x86/include/generated/asm/syscalls_64.h:47
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Local variable key created at:
 tcf_ct_flow_table_get+0x4a/0x2260 net/sched/act_ct.c:324
 tcf_ct_init+0xa67/0x2890 net/sched/act_ct.c:1408

CPU: 0 PID: 5048 Comm: syz-executor374 Not tainted 6.10.0-syzkaller-11185-g2c9b3512402e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
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


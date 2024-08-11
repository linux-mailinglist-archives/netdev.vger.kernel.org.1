Return-Path: <netdev+bounces-117444-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61B0594DF71
	for <lists+netdev@lfdr.de>; Sun, 11 Aug 2024 03:29:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D7771F2169E
	for <lists+netdev@lfdr.de>; Sun, 11 Aug 2024 01:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A74235672;
	Sun, 11 Aug 2024 01:29:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11EAC8836
	for <netdev@vger.kernel.org>; Sun, 11 Aug 2024 01:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723339762; cv=none; b=QLuZDL8XkvJ9sQMrMckNCMwV6L3vQdVegaPVqCN0Q1JxuVh28N1/fP9zKhDEgbmG1xgT2xrZxmnkguZfD7euCMFnfqUm00gzo1yCRAi5EMojrdOQYYpcZz/BBRZ93AtT6y2s6uwvS6dNUUXStsK7ov779wMbyV0nildficBsO1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723339762; c=relaxed/simple;
	bh=6sJE3X/dRhKTAm0/Avn4aqo2AmKV3gAyVLwHqrKo2m0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=eqMWOJVv4LM7yzNaBz2HutPeUWDNsfc+UYCxoyi0PfrCel46yyGq7Rs7Yhz36U/0uT0YefmuEP4VFVo8uLkPiekkRdY0WJOcpayJhPTmeSm6YD/BMqeftJ5NJKCKQSfI/7qs0b7MNfp8JVxAdv+QrzlYNBAwbraR06aVH1Td/Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-81f901cd3b5so434587839f.1
        for <netdev@vger.kernel.org>; Sat, 10 Aug 2024 18:29:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723339760; x=1723944560;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=raqRTF4eqwyqlA887pjYM5q2dkGs8fVr9I0/HOMYhvA=;
        b=IctJlyNi0QfKnUrPA4Xq2Xq+XTHpXsO6gC/HOwkeIi4wbfC2FcJSr+WtYVUchxm7ly
         5vaCwNzOYBJoqhnuEjohau60nDgZevJOud+Why9oXdrwsZLs3Yd5GA5yBTa1kmoq+k9E
         jUG4FTKlQ0/tx5UxdCkESA+YV01A0A0HeCbeawjw/45uQIyFcRU1DEDab8o0q47vrf9y
         2iWaz0isr+boH11/mqJykgvWtq0NPTJ2ZC7FezvEjJRsqjB/evV/TkxXv8ZESeW7WsSq
         rcHshByf8yuS7vw6ehVBPkVuKWZoR9KZuH8jIEljRY5+UXrQ3Eu4hH9c9pxF5nhM6lnE
         vLYA==
X-Forwarded-Encrypted: i=1; AJvYcCVloNXi0Rigybw6aRQZ6Aa7ii/n0TFYmfahDBfj6yt7gJ5iPaveeLPdZj+69CuxWySc1JjeNetOkveosE988TLJ9cP4A435
X-Gm-Message-State: AOJu0Yz8m1FSx2X7D0MBgQPFxEmElMP2/rhnjx6b/gpDzh2wi2wTMzdD
	Bm/P7P9u06SPJprB7WQl25pV+4F+1SYbJg3PyI5j9HikMwPqtBdIKr6/qIL9uswpjq+mkvp9jFA
	6v2rY/0o5Zd3K2wjZGdPDT+Lef/kpR2k/K8mLluovKDIHBO3pDQFq5W4=
X-Google-Smtp-Source: AGHT+IGMUx90vGxWQEs61DG5807um1iZtHw962pACzdzeR6VMhnBxdufArTRdCImox0pZ6vzmFPzlMpjrZZsD7f9RUdW1QpzLKuA
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:629e:b0:4c0:8165:c391 with SMTP id
 8926c6da1cb9f-4ca6eda5e4emr220752173.4.1723339760092; Sat, 10 Aug 2024
 18:29:20 -0700 (PDT)
Date: Sat, 10 Aug 2024 18:29:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003a5292061f5e4e19@google.com>
Subject: [syzbot] [net?] WARNING: refcount bug in inet_twsk_kill
From: syzbot <syzbot+8ea26396ff85d23a8929@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    33e02dc69afb Merge tag 'sound-6.10-rc1' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=117f3182980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=25544a2faf4bae65
dashboard link: https://syzkaller.appspot.com/bug?extid=8ea26396ff85d23a8929
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-33e02dc6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/573c88ac3233/vmlinux-33e02dc6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/760a52b9a00a/bzImage-33e02dc6.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8ea26396ff85d23a8929@syzkaller.appspotmail.com

------------[ cut here ]------------
refcount_t: decrement hit 0; leaking memory.
WARNING: CPU: 3 PID: 1396 at lib/refcount.c:31 refcount_warn_saturate+0x1ed/0x210 lib/refcount.c:31
Modules linked in:
CPU: 3 PID: 1396 Comm: syz-executor.3 Not tainted 6.9.0-syzkaller-07370-g33e02dc69afb #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:refcount_warn_saturate+0x1ed/0x210 lib/refcount.c:31
Code: 8b e8 37 85 cf fc 90 0f 0b 90 90 e9 c3 fe ff ff e8 68 34 0d fd c6 05 0d 81 4c 0b 01 90 48 c7 c7 20 2b 8f 8b e8 14 85 cf fc 90 <0f> 0b 90 90 e9 a0 fe ff ff 48 89 ef e8 e2 e8 68 fd e9 44 fe ff ff
RSP: 0018:ffffc9000480fa70 EFLAGS: 00010282
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffc9002ce28000
RDX: 0000000000040000 RSI: ffffffff81505406 RDI: 0000000000000001
RBP: ffff88804d8b3f80 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000002 R12: ffff88804d8b3f80
R13: ffff888031c601c0 R14: ffffc900013c04f8 R15: 000000002a3e5567
FS:  00007f56d897c6c0(0000) GS:ffff88806b300000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b3182b000 CR3: 0000000034ed6000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 __refcount_dec include/linux/refcount.h:336 [inline]
 refcount_dec include/linux/refcount.h:351 [inline]
 inet_twsk_kill+0x758/0x9c0 net/ipv4/inet_timewait_sock.c:70
 inet_twsk_deschedule_put net/ipv4/inet_timewait_sock.c:221 [inline]
 inet_twsk_purge+0x725/0x890 net/ipv4/inet_timewait_sock.c:304
 tcp_twsk_purge+0x115/0x150 net/ipv4/tcp_minisocks.c:402
 tcp_sk_exit_batch+0x1c/0x170 net/ipv4/tcp_ipv4.c:3522
 ops_exit_list+0x128/0x180 net/core/net_namespace.c:178
 setup_net+0x714/0xb40 net/core/net_namespace.c:375
 copy_net_ns+0x2f0/0x670 net/core/net_namespace.c:508
 create_new_namespaces+0x3ea/0xb10 kernel/nsproxy.c:110
 unshare_nsproxy_namespaces+0xc0/0x1f0 kernel/nsproxy.c:228
 ksys_unshare+0x419/0x970 kernel/fork.c:3323
 __do_sys_unshare kernel/fork.c:3394 [inline]
 __se_sys_unshare kernel/fork.c:3392 [inline]
 __x64_sys_unshare+0x31/0x40 kernel/fork.c:3392
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x260 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f56d7c7cee9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f56d897c0c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000110
RAX: ffffffffffffffda RBX: 00007f56d7dac1f0 RCX: 00007f56d7c7cee9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000042000000
RBP: 00007f56d7cc949e R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000006e R14: 00007f56d7dac1f0 R15: 00007ffe66454be8
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


Return-Path: <netdev+bounces-168143-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74D17A3DB0D
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 14:16:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D65E63AEEB5
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 13:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4552D1F4E21;
	Thu, 20 Feb 2025 13:15:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7D61F1302
	for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 13:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740057326; cv=none; b=rctYwuIpHu9dCehhnAg684SlFxuq3A/5ZZoMikmkebDd6dEtSakD9o/Dhk4Ns/+K+lh4HOoQ3rTeOaNf/Cu0V3CKNk22yuI5V3snBbK1jeOggC7BUq4lTgsIxs5RKdeqSpNmVmTbc/YQ/hdb/O75w83vfE5Vi1SJyuLTNVpU3zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740057326; c=relaxed/simple;
	bh=4WSFl5CnShQ9cN74z+kHZd+HCcguHzL/dymTCUVCSZw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=K18qnoBDX8XmZrrTzxfoOCzOLvvkKD1cy2FE8w5+yCWZsiPhUGMV95Y646LgLwO7eVPMKfAX4g7vfztNdNho3vSzeXkCO54YYFBvo0dmEe2Hs+KNACAqH4jrUOBXZehYrflxdw8cVSg0mlExLY6hHnVOOz0M1GIGWEvE0W/OcC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-855a5457169so181515839f.3
        for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 05:15:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740057323; x=1740662123;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BWOsjaJg0OGO0bdZa/wpMaud7sFmwDEOjNkmgzF9kj8=;
        b=so4TwGWqNq3YAfYOwjtQsk29bXpEqrYEJ3e9GapLZt0UFe6hbos2monH8zRQd9/YFP
         juUGVf1cx2lyVpIq+OCI7+wrFGY13Pm8Oi0T3K3KVt7kU1akmabPBdla+VVXCURovUWm
         7QgjFcVfilqtiX55IxxG+/+amNohF8frisyCMlP6w64geo67ytgOgr/R9mX6sJ2eHPwv
         xkOplxcqqAK+M9CwiHYiUVGiS+309srZRssBsuGbR/JFWshOyuPOaSs0Ai/upPQ73LR5
         EfBlVos6oxLi5EBXiabnFV9bEDmd8Mu74FRTjOisahww0JMy8DMN5TIYuB5ZRGWSrn/u
         aJdQ==
X-Forwarded-Encrypted: i=1; AJvYcCWNLk+QBxUbg1EpfG7OMJvJQmYOgXMKeLFYPkypN4Gv2rh+SupXTBjfgRkwsSaIEl2Wmv6xpYg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPxB3c6IgFdH7NoPReJc1mpUj30nwtolkZKipVQ3YXkIT8HlUe
	t5dpmOCI/SKsWjUMaPgvqDNGJmWAnm8v0uZIkTUboOZbkvDrywyYnWPrTDo0YCLwIMS9H15scT0
	7nHVr8YXLMZa0i8JzZ9qg14IeqJcZVz8oJsISwe1MWQEkspuFyhPPQKw=
X-Google-Smtp-Source: AGHT+IHNjltYZXCeST6yBPQ6eXixWgIDCU1o3kIGAr/KjPQN9gJUXt0f4Ew+5uvXTXV09eNFoEdVyl4YPb/RpmDZiIhcawC1HDTS
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b4b:b0:3d1:9429:e5bf with SMTP id
 e9e14a558f8ab-3d28098fdd4mr213393255ab.19.1740057323657; Thu, 20 Feb 2025
 05:15:23 -0800 (PST)
Date: Thu, 20 Feb 2025 05:15:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67b72aeb.050a0220.14d86d.0283.GAE@google.com>
Subject: [syzbot] [net?] WARNING in cleanup_net (4)
From: syzbot <syzbot+30a19e01a97420719891@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    6537cfb395f3 Merge tag 'sound-6.14-rc4' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16a327f8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=61cbf5ac8a063ad4
dashboard link: https://syzkaller.appspot.com/bug?extid=30a19e01a97420719891
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10bf9ae4580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13d89498580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ae2568ec9e34/disk-6537cfb3.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/19be7179f649/vmlinux-6537cfb3.xz
kernel image: https://storage.googleapis.com/syzbot-assets/bd8a168d2027/bzImage-6537cfb3.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+30a19e01a97420719891@syzkaller.appspotmail.com

     proc_sctp_do_udp_port+0x380/0x450 net/sctp/sysctl.c:555
     proc_sys_call_handler+0x3c6/0x5a0 fs/proc/proc_sysctl.c:601
     iter_file_splice_write+0x90f/0x10b0 fs/splice.c:743
     do_splice_from fs/splice.c:941 [inline]
     direct_splice_actor+0x18f/0x6c0 fs/splice.c:1164
     splice_direct_to_actor+0x346/0xa40 fs/splice.c:1108
     do_splice_direct_actor fs/splice.c:1207 [inline]
     do_splice_direct+0x178/0x250 fs/splice.c:1233
     do_sendfile+0xafb/0xe40 fs/read_write.c:1363
     __do_sys_sendfile64 fs/read_write.c:1424 [inline]
     __se_sys_sendfile64 fs/read_write.c:1410 [inline]
     __x64_sys_sendfile64+0x1da/0x220 fs/read_write.c:1410
     do_syscall_x64 arch/x86/entry/common.c:52 [inline]
     do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
     entry_SYSCALL_64_after_hwframe+0x77/0x7f
------------[ cut here ]------------
WARNING: CPU: 0 PID: 12 at lib/ref_tracker.c:179 ref_tracker_dir_exit+0x3e3/0x680 lib/ref_tracker.c:179
Modules linked in:
CPU: 0 UID: 0 PID: 12 Comm: kworker/u8:1 Not tainted 6.14.0-rc3-syzkaller-00060-g6537cfb395f3 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 12/27/2024
Workqueue: netns cleanup_net
RIP: 0010:ref_tracker_dir_exit+0x3e3/0x680 lib/ref_tracker.c:179
Code: 11 02 00 00 4d 39 f5 49 8b 06 4d 89 f7 0f 85 0e ff ff ff 48 8b 2c 24 e8 5b 16 c8 fc 48 8b 74 24 18 48 89 ef e8 6e bd 65 06 90 <0f> 0b 90 e8 45 16 c8 fc 48 8d 5d 44 be 04 00 00 00 48 89 df e8 c4
RSP: 0018:ffffc90000117ac8 EFLAGS: 00010246
RAX: 0000000000000000 RBX: dffffc0000000000 RCX: 0000000000000000
RDX: 0000000000000001 RSI: ffffffff8b6ceca0 RDI: 0000000000000001
RBP: ffff88802f7b01e0 R08: 0000000000000001 R09: fffffbfff2dd79b7
R10: ffffffff96ebcdbf R11: 0000000000002ba2 R12: ffff88802f7b0230
R13: ffff88802f7b0230 R14: ffff88802f7b0230 R15: ffff88802f7b0230
FS:  0000000000000000(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000557010814f20 CR3: 000000000df80000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 net_free net/core/net_namespace.c:473 [inline]
 net_free net/core/net_namespace.c:467 [inline]
 cleanup_net+0x99f/0xbf0 net/core/net_namespace.c:675
 process_one_work+0x9c5/0x1ba0 kernel/workqueue.c:3236
 process_scheduled_works kernel/workqueue.c:3317 [inline]
 worker_thread+0x6c8/0xf00 kernel/workqueue.c:3398
 kthread+0x3af/0x750 kernel/kthread.c:464
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>


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


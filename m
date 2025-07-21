Return-Path: <netdev+bounces-208504-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00DF1B0BE29
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 09:55:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30E7B3AAD53
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 07:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47DA8285074;
	Mon, 21 Jul 2025 07:55:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF8B28152D
	for <netdev@vger.kernel.org>; Mon, 21 Jul 2025 07:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753084534; cv=none; b=RfZnIAU6AQBDSXQznYeoaCMm3fZKAIY3uzonD36+cjNyT2KvJ2TFvRnui0cu+buS3wccLwrUaXPS5vq86XDObi+FXdVCv/ZxRVb48pYvAxP41Cvy/uZFw5xA4hrt541sIhiQQtx9wMzDI3Tn03Es6g9FIM9BdDSZFx/xNNLHabg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753084534; c=relaxed/simple;
	bh=0lse8KOroGbQPPspT2o3Gt8TESQEfPdvvUFUEyZmqtI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=XBIXO6Z8hJT6HrZd18379q5cLoR3oANFutxfS3bqmAFx6y7nCZMvyZcXmatbfMXnfuXMJqZgtt/GW/xSC+ltgvJbYFEo4IDPvx+wUefTTVVTdvHOWckc2kdKlZi1e5kSQOqPxkOyZJeFx2q1PVr6owvpdMcV9Jf+52mQWYE0h4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-86cc7cdb86fso366483539f.1
        for <netdev@vger.kernel.org>; Mon, 21 Jul 2025 00:55:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753084531; x=1753689331;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mpGtJjSTE4Hb4CxYNFdEl6s+ZrPvAdZM8nTLITHu/AU=;
        b=TzhgxvpRc4Obvmcd6dhtH15kxmK8KFnhmHut3HyMB9aquEhMQbPuWs8sAXm7lsLOxz
         U/300TsoT2WxTTLeoP4Q2NH2i6U57wug7jI5Oci3i1nvuyFNsn9BiKfjZJtQrZxCm6jI
         QHGYWiCjVRSSw7YxRXF1h54G6wD+wnFZ55nRykQxBk5NUC/8LYUQALBAbrsHtPf4xjiN
         /EBtE78EiU2H0wjVPdtVyBC8A+qmb47HUbNA46uPapJ7VbXC/c0QwIGAZ1j3q6A5qQno
         OVf547rmfCjgVhGwu29OMR6EPdCvS+bD1PPYwZaGccancRJiSlCHr2dOZIzHvRnUVnLi
         Kzbg==
X-Forwarded-Encrypted: i=1; AJvYcCXWD+b7Ejk3d93ZS67dW3gT9I4iLZKlBF+sYi1M+xUZzZh+KEneZRFr0O5xcfq5a5ZCiYELN3s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNkUNayV0ItGjofkpFFHE6OG/BsukB4sFmTzFpK5hEk5OLjS83
	yiHtw1tDJSNNdvjFlQ3q5mmZeF5eQpdGWCIB/LfMSbCSSatxG+Zb35S0sV8ulUs4nfTSOlCUhnc
	G7iAN7nqNRID9PtFWCypb2iu2zwJ6DzIjmpIauYngKkzQ/PMXc+LsitoJOwE=
X-Google-Smtp-Source: AGHT+IFIii7JfNpq4baM+HOiCqn2j+ywL/ztT7mpBre9UykTQTr4wVD4CtdvbbnhWSyoT5DxFd/EvfOjyL0s3IfX+e1ASXPbA95t
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3d1:b0:875:d675:55f2 with SMTP id
 ca18e2360f4ac-879c28caec0mr2189233839f.7.1753084531607; Mon, 21 Jul 2025
 00:55:31 -0700 (PDT)
Date: Mon, 21 Jul 2025 00:55:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <687df273.a70a0220.693ce.00e5.GAE@google.com>
Subject: [syzbot] [wireless?] WARNING in cfg80211_switch_netns
From: syzbot <syzbot+3515319a302224e081b4@syzkaller.appspotmail.com>
To: johannes@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    4701ee5044fb be2net: Use correct byte order and format str..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=142f77d4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1a940d1173246e73
dashboard link: https://syzkaller.appspot.com/bug?extid=3515319a302224e081b4
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/5771927b98f6/disk-4701ee50.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e9e498c37560/vmlinux-4701ee50.xz
kernel image: https://storage.googleapis.com/syzbot-assets/377ae84313ff/bzImage-4701ee50.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3515319a302224e081b4@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 6759 at net/wireless/core.c:204 cfg80211_switch_netns+0x560/0x590 net/wireless/core.c:204
Modules linked in:
CPU: 1 UID: 0 PID: 6759 Comm: kworker/u8:18 Not tainted 6.16.0-rc6-syzkaller-01576-g4701ee5044fb #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
Workqueue: netns cleanup_net
RIP: 0010:cfg80211_switch_netns+0x560/0x590 net/wireless/core.c:204
Code: e1 07 38 c1 7c 8c 4c 89 e7 e8 dc be 63 f7 eb 82 e8 45 b0 01 f7 e9 63 fe ff ff e8 3b b0 01 f7 e9 59 fe ff ff e8 31 b0 01 f7 90 <0f> 0b 90 e9 a9 fd ff ff 89 d9 80 e1 07 80 c1 03 38 c1 0f 8c cb fa
RSP: 0018:ffffc9001ba67860 EFLAGS: 00010293
RAX: ffffffff8abe7a1f RBX: ffff888031530d78 RCX: ffff88802a70da00
RDX: 0000000000000000 RSI: 00000000ffffffef RDI: 0000000000000000
RBP: 00000000ffffffef R08: ffffffff8fa22af7 R09: 1ffffffff1f4455e
R10: dffffc0000000000 R11: fffffbfff1f4455f R12: ffff888031530700
R13: ffff888027fc9580 R14: dffffc0000000000 R15: ffff8880315308f0
FS:  0000000000000000(0000) GS:ffff888125d16000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007faceb4e56c0 CR3: 0000000080016000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 cfg80211_pernet_exit+0xa2/0x140 net/wireless/core.c:1671
 ops_exit_list net/core/net_namespace.c:198 [inline]
 ops_undo_list+0x497/0x990 net/core/net_namespace.c:251
 cleanup_net+0x4c5/0x800 net/core/net_namespace.c:682
 process_one_work kernel/workqueue.c:3238 [inline]
 process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3321
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3402
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
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


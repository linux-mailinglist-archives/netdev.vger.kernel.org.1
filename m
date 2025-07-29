Return-Path: <netdev+bounces-210723-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CB06B148EE
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 09:08:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C558218A01A8
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 07:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A4D125DAFF;
	Tue, 29 Jul 2025 07:08:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDCB82472BA
	for <netdev@vger.kernel.org>; Tue, 29 Jul 2025 07:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753772914; cv=none; b=Eayn5vRTGUQJf5oijl1cJVOyGTEByVbYSX6UYzUne7NA/JjUAlY8zCTtpjW1s139Ttyt2wEU7a7C7rELsQ52kVmSN2vnYbzR+Me4XbQcgmahnlfzHsehsfrmwvMBg4fhnLtJQzxC3Nj8q0+4yz7f50maOyDiOTwyZEWXmBPvYNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753772914; c=relaxed/simple;
	bh=EnkfyD1eONdwDuOcQ81d8igQbfRxCP2MfV+jpHYpfUA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ddVzk6ZG16orlKi2VBD92UaXok9yvGACfQAawk1Y5ZfSg1jkeahWUojUXqk62JRMp19qLrGeufRjgRU7poxzVevEioqbQO4ZYvoYd/1FiIm5XfQLefm5iqF5izdAEUjOrvHJ2RcH1q1p4kxBxKcyvfRE1AsqIK8qhTnyUeLjbnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-87c13b0a7beso540925439f.1
        for <netdev@vger.kernel.org>; Tue, 29 Jul 2025 00:08:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753772912; x=1754377712;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lQVoZnv4ZsTO42Vddkk5EKweteHfbTD2qSGromaUy/M=;
        b=fyf4+SYAOyH/d2udPgPLkbSwR4ppL/zrivkt9smT0UeSkD3H0x+O6inbsgbQD78aVd
         x258RKpOvvZsK1q2UcxraOjT4oy77uGsBQvCjtfe9IJTrajnvYA6sOvudTx+LRK7oONR
         vHewYd8DYYBV8u8cFEPvClVDeJJHTEE2qShC/ZctYT6ptw094WTGe4MGSrGBMqmCDOmp
         QffJhPz1tXBcaiukc9BH3x+MVjIKTW92i2pTcaVBd4R/C8i0A7AwKTIjmGVpqWynHTmu
         5znw9RveYckGbr6MXb5I9m829tGkbx+cp3CdGRPwwPrAcyM6eSTOjSQbaGQsd5wEe7O5
         ykyg==
X-Forwarded-Encrypted: i=1; AJvYcCX+PZn91NFkFHz/6Ha4Pd+/KG2CX2Zdipf7fkrMvW8/l0M2/8q6oayXb0+TUhEhaLUv2NyHp74=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJkixeYGAIoiR1ZGiB1z+TAxAMJYD84D1MRyrsawYirztoG5zh
	zOhHsamCfmxoOwahJ20oVJh82sFHtm2fXmTIW7cNWXyw2s2LWxPgS3XwwDlfOKf+K/81QUdbopI
	rOeVosrfgJjEnYSwwWpolqlY6K7BbdXRiUnGte8OVYLq06nEuTG85pg9NJiA=
X-Google-Smtp-Source: AGHT+IH4hjmux0mT79p3Xd0+N4UcVv5UJkP/3MJnwQoLoRW32xEsK6uDlCFIzzqDjSuS6mqjyn/SYWfJcs2+RKD3b7QKjVvchCv7
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3106:b0:3dd:d194:f72d with SMTP id
 e9e14a558f8ab-3e3c527da5bmr258539915ab.8.1753772912033; Tue, 29 Jul 2025
 00:08:32 -0700 (PDT)
Date: Tue, 29 Jul 2025 00:08:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6888736f.a00a0220.b12ec.00ca.GAE@google.com>
Subject: [syzbot] [net?] WARNING in xfrm_state_fini (3)
From: syzbot <syzbot+6641a61fe0e2e89ae8c5@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, herbert@gondor.apana.org.au, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, steffen.klassert@secunet.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    038d61fd6422 Linux 6.16
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=11b88cf0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4066f1c76cfbc4fe
dashboard link: https://syzkaller.appspot.com/bug?extid=6641a61fe0e2e89ae8c5
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16ca1782580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=140194a2580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/6505c612be11/disk-038d61fd.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e466ef29c1ca/vmlinux-038d61fd.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b6d3d8fc5cbb/bzImage-038d61fd.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6641a61fe0e2e89ae8c5@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 36 at net/xfrm/xfrm_state.c:3284 xfrm_state_fini+0x270/0x2f0 net/xfrm/xfrm_state.c:3284
Modules linked in:
CPU: 1 UID: 0 PID: 36 Comm: kworker/u8:2 Not tainted 6.16.0-syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
Workqueue: netns cleanup_net
RIP: 0010:xfrm_state_fini+0x270/0x2f0 net/xfrm/xfrm_state.c:3284
Code: c1 e8 03 42 80 3c 28 00 74 08 48 89 df e8 68 fa 0b f8 48 8b 3b 5b 41 5c 41 5d 41 5e 41 5f 5d e9 56 c8 ec f7 e8 51 e8 a9 f7 90 <0f> 0b 90 e9 fd fd ff ff e8 43 e8 a9 f7 90 0f 0b 90 e9 60 fe ff ff
RSP: 0018:ffffc90000ac7898 EFLAGS: 00010293
RAX: ffffffff8a163e8f RBX: ffff888034008000 RCX: ffff888143299e00
RDX: 0000000000000000 RSI: ffffffff8db8419f RDI: ffff888143299e00
RBP: ffffc90000ac79b0 R08: ffffffff8f6196e7 R09: 1ffffffff1ec32dc
R10: dffffc0000000000 R11: fffffbfff1ec32dd R12: ffffffff8f617760
R13: 1ffff92000158f40 R14: ffff8880340094c0 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff888125d23000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fbd9e960960 CR3: 00000000316d3000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 xfrm_net_exit+0x2d/0x70 net/xfrm/xfrm_policy.c:4348
 ops_exit_list net/core/net_namespace.c:200 [inline]
 ops_undo_list+0x49a/0x990 net/core/net_namespace.c:253
 cleanup_net+0x4c5/0x800 net/core/net_namespace.c:686
 process_one_work kernel/workqueue.c:3238 [inline]
 process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3321
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3402
 kthread+0x711/0x8a0 kernel/kthread.c:464
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


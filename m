Return-Path: <netdev+bounces-286456-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6BaMOOZ1AWr9ZwEAu9opvQ
	(envelope-from <netdev+bounces-286456-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 08:23:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 60ACC508826
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 08:23:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 66D0B3006B0D
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 06:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40DEE2D3725;
	Mon, 11 May 2026 06:23:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f77.google.com (mail-oo1-f77.google.com [209.85.161.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBFAB2C0299
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 06:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778480611; cv=none; b=QNhNs5FwYHnC0AwXDVdy5cKkIcAW23V2QahYQRXb/jY3JlmBNc/pIQdLvVu4Z1p8Y9CIXOHQ7QPWw2cpGvTg2eE3u0e1SbUIYXwQrl8OmTyVg+ZgRvT76Tcl4bA+hmSvMHIhgqD6cXPjMmVx2Uw9INqwCbCzmGGLwGlnPQak8xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778480611; c=relaxed/simple;
	bh=2/R7v9mNHMjP8cDFOGQ/TPV1slRjThbnyFADaLLiPGo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Gu/h3kW5oKlGV8NwVDcXoXCSuUtHutcpVWvA2FkMSTNPIQSwVKLb4fey3RfCj1R4jAuVPQrK4EzSCyS562+NJx8OuNLQiuuIW/GLi2r90B8Ql/8EMH1DJzPY1aseca7KTWqMPywJwrpeBtxg9UezrB35d8odoMfg6uffMGqNZs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f77.google.com with SMTP id 006d021491bc7-679c5ed0942so5651105eaf.1
        for <netdev@vger.kernel.org>; Sun, 10 May 2026 23:23:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778480609; x=1779085409;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VaFPG7gEHXdorxY3MrBaNDqtO3iWXxWBFIcMFjQggaU=;
        b=mu4zrjLSpjcnPPpne3qz9G9PiTHGt0lCjDU03uTE6oftdc08RM6g1Igc2T8y5Z5nY8
         e2HTcdzXrfeheuFD0QbI+sPQEYF+GO7A+JmVMyyIoZgxptkLUNEJIH64Dsl2EGbqcabJ
         E3jgxZvqzI+nTzTGou7lcPE9g5s/iPJi0jBKo7mmI+rZj/+HJnsyQ+rl1Gr/KO1p9E47
         vMcXEkUbDkLmCiiQghGmWbXoSfZD7xCrLBmlTvIUmpmlIKIzSleAFVgrP7ZfJ6ft0S6p
         hme6tySHACznAh+mjQYWZwSiFkJFK9aPqrYfm6ERz8fFqBTyYIqhrTC2agY50QlEWBVc
         WS5A==
X-Forwarded-Encrypted: i=1; AFNElJ+uUEkunpjGovT7j7xB2sc2Xvy9Yn9ay9dTJ6eyTQBR3wmiybv6AbaOd6M/Noc4P/T9tfnAXDY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHCNaw9kUYAawNODBp4DMR8uF5gxRRidbw5yVqBKRHsuD3wsBu
	kB2H6wZvn+74W+3x+8tY1rSVsOWmsXovT5LvqFMdCdRDLlx/TDU1fV2HwAiqFbO3fJm7yPD+yxO
	RMxYFUI2C23JeVQSMoKBurtT3MYlt/7dCrJ4v5lBV3EHYCmklqa/QV51I/sM=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:1622:b0:694:980a:2c47 with SMTP id
 006d021491bc7-69998bd405bmr12037677eaf.0.1778480608729; Sun, 10 May 2026
 23:23:28 -0700 (PDT)
Date: Sun, 10 May 2026 23:23:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a0175e0.a00a0220.1c3806.0016.GAE@google.com>
Subject: [syzbot] [net?] WARNING in qdisc_tree_reduce_backlog (2)
From: syzbot <syzbot+9744ccaabe337c6fb123@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	jhs@mojatatu.com, jiri@resnulli.us, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 60ACC508826
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=f2e8ebfec4636d32];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286456-lists,netdev=lfdr.de,9744ccaabe337c6fb123];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	SUBJECT_HAS_QUESTION(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,goo.gl:url,googlegroups.com:email,storage.googleapis.com:url]
X-Rspamd-Action: no action

Hello,

syzbot found the following issue on:

HEAD commit:    5862221fdded Merge tag 'parisc-for-7.1-rc3' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12a4bb26580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f2e8ebfec4636d32
dashboard link: https://syzkaller.appspot.com/bug?extid=9744ccaabe337c6fb123
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/cd9aba7e59bf/disk-5862221f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/29af9d57e9af/vmlinux-5862221f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/02749594fd1e/bzImage-5862221f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9744ccaabe337c6fb123@syzkaller.appspotmail.com

------------[ cut here ]------------
parentid != TC_H_ROOT
WARNING: net/sched/sch_api.c:797 at qdisc_tree_reduce_backlog+0x3d9/0x480 net/sched/sch_api.c:797, CPU#1: ktimers/1/29
Modules linked in:
CPU: 1 UID: 0 PID: 29 Comm: ktimers/1 Tainted: G             L      syzkaller #0 PREEMPT_{RT,(full)} 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/18/2026
RIP: 0010:qdisc_tree_reduce_backlog+0x3d9/0x480 net/sched/sch_api.c:797
Code: ff ff 4c 89 ef e8 b7 85 12 f9 e9 42 ff ff ff e8 4d 7c ab f8 eb 17 e8 46 7c ab f8 eb 10 e8 3f 7c ab f8 eb 09 e8 38 7c ab f8 90 <0f> 0b 90 e8 7f 72 03 02 89 c3 31 ff 89 c6 e8 d4 80 ab f8 85 db 74
RSP: 0018:ffffc90000a3f768 EFLAGS: 00010246
RAX: ffffffff8918f818 RBX: 0000000000000008 RCX: ffff88801daa3d80
RDX: 0000000000000100 RSI: 0000000000000000 RDI: 0000000000000100
RBP: dffffc0000000000 R08: 0000000000000000 R09: 0000000000000100
R10: 0000000000000100 R11: 00000000ffffffff R12: 00000000000affe0
R13: dffffc0000000000 R14: ffffc90000a3f8e0 R15: ffff88803d0a7800
FS:  0000000000000000(0000) GS:ffff888126279000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055558bcbda38 CR3: 00000000403d8000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000003e4f
DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 sfq_rehash net/sched/sch_sfq.c:598 [inline]
 sfq_perturbation+0x205d/0x22d0 net/sched/sch_sfq.c:615
 call_timer_fn+0x192/0x5e0 kernel/time/timer.c:1748
 expire_timers kernel/time/timer.c:1799 [inline]
 __run_timers kernel/time/timer.c:2374 [inline]
 __run_timer_base+0x6a3/0x9f0 kernel/time/timer.c:2386
 run_timer_base kernel/time/timer.c:2395 [inline]
 run_timer_softirq+0x103/0x170 kernel/time/timer.c:2406
 handle_softirqs+0x1de/0x6d0 kernel/softirq.c:622
 __do_softirq kernel/softirq.c:656 [inline]
 run_ktimerd+0x69/0x100 kernel/softirq.c:1151
 smpboot_thread_fn+0x541/0xa50 kernel/smpboot.c:160
 kthread+0x388/0x470 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
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


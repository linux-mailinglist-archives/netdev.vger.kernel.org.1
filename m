Return-Path: <netdev+bounces-72476-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7186E858441
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 18:37:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96BD71C21503
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 17:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E5BC131E2C;
	Fri, 16 Feb 2024 17:37:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AFA1130E3D
	for <netdev@vger.kernel.org>; Fri, 16 Feb 2024 17:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708105047; cv=none; b=gQRCYt367dXPTcb9Tk9raeCVcP0r4sZAfbCVAo46yu78CTR9A+svu9ddigskALVjx2SismC4Ku3gqq05v/wFq41mwNFshOgP7tR7nrcKOeOdmTKe+2Gi0VC+EoB9Bbc8XZIWth8AHMEtQU+TCBUl4wuw7Fpqpw3rzNwyPGwh47E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708105047; c=relaxed/simple;
	bh=8zgHGk2XYlc0eyYqGvAJfbnqxqiQENrlYr45nngj+qM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=hEdksTUabhHZBcKseqURaFHTk+jM8DSyFLRxHZ551D2H5UGVIEchj1KlsEOzQU5RWEVAMflxyz70Okby63TboTdDu8LoK3AG1dl4nUZFxlVyX9ImdhIWJaH0lpxuML9YBhDmTR9bGVwtec8HPj5VAhk0Ywd0bImy3o3s4FcGcqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3642ae0c610so20925475ab.2
        for <netdev@vger.kernel.org>; Fri, 16 Feb 2024 09:37:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708105043; x=1708709843;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uZRU6Lm8OXebtHymXF/bT845gS+j9fCEUbQMNuXasxk=;
        b=fo2RWB1zafHFoHogXMrGisYO69R/KN8XnHagNg1whwqCIxNgtjWHl4zi9fDV3FmYSS
         HuTYz4d7Gtf8N0LEbZfipPFtd5DQyWq6vbfCK6g4UQR7rbYsYbulhFYodhnZqyW/SgfU
         htDQ3QJ6y4FdKXSMCUT1koXnq6KaR7WjRechV7zi7D4RL/KBU8DmI06OG/AZN1zarIpv
         vJOsD+QAnjsMSSwwTjKnaxNOQg9o7k7JMzOpPk4TTj33d8gQkjvIGkJ28PNz/MKx4WeH
         sYUrF/nMZo6T/zkatyUYXX7JdvGwsNdFvUTlzJbe6YvYOAI+XfWNTK4U+AlsU1VOLIqp
         tl/A==
X-Forwarded-Encrypted: i=1; AJvYcCXFDfkfFxD95D5xeG1TOfHV9qtudQsIMaioiQhQ61dOhTzZ2FVyPaXmkEF6hFYysLCUh2dfNUk9dysgp8Rul2CIFElNW5xv
X-Gm-Message-State: AOJu0YwvzgfM9m4S0xAPGRvq16f7gv1NLeBUXYpLjbqfcA1JltIgQXan
	eyV8PMZfxg11IcaufZLP3THmrC7patChXPuA5oJG7x5EOFJ72gIsLGtw3PP6ounb+GX3S1y/V3d
	HmAJ8HRYPU2YnAzpSY3SNlesRXmSVm5+9mM5PE7vxO4/gfdygAZjWZ28=
X-Google-Smtp-Source: AGHT+IFlUi7Ug1pKYpl/xwhk2Po0PLq9/qTn4i4DlUDJuC9qfpEk75VqoJzOzWOMKWa/qnJCXnf1n4e7LlwpVcw01j+du1rEWOep
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c26d:0:b0:363:c8ba:ea5a with SMTP id
 h13-20020a92c26d000000b00363c8baea5amr344499ild.6.1708105043656; Fri, 16 Feb
 2024 09:37:23 -0800 (PST)
Date: Fri, 16 Feb 2024 09:37:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005dc7ce0611833268@google.com>
Subject: [syzbot] [mptcp?] WARNING in __mptcp_clean_una
From: syzbot <syzbot+5b3e7c7a0b77f0c03b0d@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, geliang.tang@linux.dev, 
	geliang@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	martineau@kernel.org, matttbe@kernel.org, mptcp@lists.linux.dev, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    4f5e5092fdbf Merge tag 'net-6.8-rc5' of git://git.kernel.o..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=129f6398180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1d7c92dd8d5c7a1e
dashboard link: https://syzkaller.appspot.com/bug?extid=5b3e7c7a0b77f0c03b0d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14fc9c8a180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17d0cc1c180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d430539932db/disk-4f5e5092.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6369586e33b7/vmlinux-4f5e5092.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9c1e38f80254/bzImage-4f5e5092.xz

The issue was bisected to:

commit 3f83d8a77eeeb47011b990fd766a421ee64f1d73
Author: Paolo Abeni <pabeni@redhat.com>
Date:   Thu Feb 8 18:03:51 2024 +0000

    mptcp: fix more tx path fields initialization

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=160a83a4180000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=150a83a4180000
console output: https://syzkaller.appspot.com/x/log.txt?x=110a83a4180000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5b3e7c7a0b77f0c03b0d@syzkaller.appspotmail.com
Fixes: 3f83d8a77eee ("mptcp: fix more tx path fields initialization")

------------[ cut here ]------------
WARNING: CPU: 1 PID: 27 at net/mptcp/protocol.c:1001 __mptcp_clean_una+0xb89/0xd70 net/mptcp/protocol.c:1001
Modules linked in:
CPU: 1 PID: 27 Comm: kworker/1:1 Not tainted 6.8.0-rc4-syzkaller-00180-g4f5e5092fdbf #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
Workqueue: events mptcp_worker
RIP: 0010:__mptcp_clean_una+0xb89/0xd70 net/mptcp/protocol.c:1001
Code: 8d 0d a5 f6 e9 7d fc ff ff 44 89 f1 80 e1 07 38 c1 0f 8c 87 fc ff ff 4c 89 f7 e8 72 0d a5 f6 e9 7a fc ff ff e8 98 f0 42 f6 90 <0f> 0b 90 49 bc 00 00 00 00 00 fc ff df e9 29 f7 ff ff 44 89 f1 80
RSP: 0018:ffffc90000a2f860 EFLAGS: 00010293
RAX: ffffffff8b507ba8 RBX: ffff888024ee3ab8 RCX: ffff8880192e9dc0
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc90000a2f950 R08: ffffffff8b507228 R09: fffff52000145f24
R10: dffffc0000000000 R11: fffff52000145f24 R12: dffffc0000000000
R13: 1ffff11004a6e000 R14: 0000000000000000 R15: ffff888025370000
FS:  0000000000000000(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f8a82c561d0 CR3: 000000007d8b6000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __mptcp_clean_una_wakeup+0x7f/0x340 net/mptcp/protocol.c:1049
 mptcp_clean_una_wakeup net/mptcp/protocol.c:1056 [inline]
 __mptcp_retrans+0xbf/0xb20 net/mptcp/protocol.c:2587
 mptcp_worker+0xd13/0x1610 net/mptcp/protocol.c:2739
 process_one_work kernel/workqueue.c:2633 [inline]
 process_scheduled_works+0x913/0x1420 kernel/workqueue.c:2706
 worker_thread+0xa5f/0x1000 kernel/workqueue.c:2787
 kthread+0x2ef/0x390 kernel/kthread.c:388
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1b/0x30 arch/x86/entry/entry_64.S:242
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


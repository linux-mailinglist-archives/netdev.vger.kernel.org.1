Return-Path: <netdev+bounces-248220-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 85377D058DB
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 19:32:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EA2553014A1A
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 18:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 888962ED15F;
	Thu,  8 Jan 2026 18:13:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f79.google.com (mail-oo1-f79.google.com [209.85.161.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00DFC29BD91
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 18:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767896011; cv=none; b=ctvy9I3ZerNyh5L4ZtekEUsJQlBgnijZ8jedv++tNF7SpFeOwDlR8PKFxI0KbeeathGiVl2a99Ci7swkdjnO+TBEOi/EiguxGNDFL+yw/bFDx8OB4fCb6ja2iMFt/D36x0DPc8SqSVBxJmUVjyXDCl4FnqVqdAnm1kqnZMYtl5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767896011; c=relaxed/simple;
	bh=epmOCCX7/U6vLLSYgTMlUHh6lRFCoDxZ2dRmeYo7O6s=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=oWLrDudFbSeJbzUaOCfzM5+1U4+WamtpUhYAs1VqV+7rKwmcoMBL2Dhog5tHKNc9fo1Kkq5/pHItVe6W//Pa0H1eHOvWS/QFyCcog5akwjLLWkpCvqE1Z72mwCk79PNJf2VuPqyCv2chrT0fhQS5wH6vIOOpYKcwPohR44ay/yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f79.google.com with SMTP id 006d021491bc7-65b73eb22d2so2247489eaf.2
        for <netdev@vger.kernel.org>; Thu, 08 Jan 2026 10:13:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767896009; x=1768500809;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=57vNfdcarOhFQCSjwkwna7TZn6CWb2tR8uFuTst1UFA=;
        b=CpBV8T+aWC+XC7VpyTNeCZuapeG+KFRCWHsCG52OvY+l/OIQCjr8GDC5KJgDy+uDxv
         iaxHfbhvUbeuaLFoyvBdqZaZy94WhqKG/kSqdh2zSNOJR7CWtAjfB7+m+crFsJVZiUGR
         kyUb/SuIwateflwNNWGefzT2iYvYr68XyC8w8+JodfmTaaP8jPWwU5EOCQtVztsDfoxZ
         jSm87S3xfJsDkvzlxKesgZ1HUr7amvAomuLp/owCD0nDWfeUbHaNg9NgMiKZuK5Y8Abl
         S1PpM2NrItcPq6eWd/ZbiApJyTPfh0kZJ/FblZkfeYmHG6RH5pzpIqRUNJO3/ipvZvg/
         Ti9g==
X-Forwarded-Encrypted: i=1; AJvYcCW6Y3r+8/2ngMyv1Is1BQwOP82MEMrzyM4Uy7mxyEGHRQclXOCcAvmBsL6TJupWS/VP//zZ4F8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzehLFxgBVK03jIns+TBcTj4bwdnhcc4yBhKvC1jWbgJNSFlHQr
	+/UYyKSVelyQM8y3a1sZj7bSY9/zclQrewR7AY2g0gJfCukKw57xWv5nbCJUOEgqNHJyrpAVD1k
	XcKEp+vUv8KHW2olxlTKZ2G+K8vGISHkQLa4PjdfFWQwrF/bAuzojLPr6G/I=
X-Google-Smtp-Source: AGHT+IFeBTu3K7Jrr1eTNPZgVt1dcgA/SKrPU/btJrnhrzMO7d/ERMzuJV1XcYYtg8dMRTEZWkk44MsUeCeMPLDPfKJGAva46n29
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:8317:b0:65c:fe5e:b96d with SMTP id
 006d021491bc7-65f54f7b4c7mr2006590eaf.66.1767896008859; Thu, 08 Jan 2026
 10:13:28 -0800 (PST)
Date: Thu, 08 Jan 2026 10:13:28 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <695ff3c8.050a0220.1c677c.03a6.GAE@google.com>
Subject: [syzbot] [net?] kernel BUG in ipgre_header (4)
From: syzbot <syzbot+7c134e1c3aa3283790b9@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    6abcf751bc08 net: airoha: Fix schedule while atomic in air..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=11cd819a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a94030c847137a18
dashboard link: https://syzkaller.appspot.com/bug?extid=7c134e1c3aa3283790b9
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/34ff92f72e89/disk-6abcf751.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d04633dc422e/vmlinux-6abcf751.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e0b0478317bd/bzImage-6abcf751.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7c134e1c3aa3283790b9@syzkaller.appspotmail.com

skbuff: skb_under_panic: text:ffffffff89ea3cb7 len:2030915468 put:2030915372 head:ffff888058b43000 data:ffff887fdfa6e194 tail:0x120 end:0x6c0 dev:team0
------------[ cut here ]------------
kernel BUG at net/core/skbuff.c:213!
Oops: invalid opcode: 0000 [#1] SMP KASAN PTI
CPU: 1 UID: 0 PID: 1322 Comm: kworker/1:9 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
Workqueue: mld mld_ifc_work
RIP: 0010:skb_panic+0x157/0x160 net/core/skbuff.c:213
Code: c7 60 9c 6f 8c 48 8b 74 24 08 48 8b 54 24 10 8b 0c 24 44 8b 44 24 04 4d 89 e9 50 55 41 57 41 56 e8 ce 6a f5 ff 48 83 c4 20 90 <0f> 0b cc cc cc cc cc cc cc 90 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffc900040cf540 EFLAGS: 00010282
RAX: 0000000000000097 RBX: dffffc0000000000 RCX: 577f10acb7f51400
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: 00000000000006c0 R08: 0000000000000003 R09: 0000000000000004
R10: dffffc0000000000 R11: fffffbfff1bbae40 R12: ffff88805235f510
R13: ffff888058b43000 R14: ffff887fdfa6e194 R15: 0000000000000120
FS:  0000000000000000(0000) GS:ffff888125f21000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f5ea09156c0 CR3: 00000000760f2000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 skb_under_panic net/core/skbuff.c:223 [inline]
 skb_push+0xc3/0xe0 net/core/skbuff.c:2641
 ipgre_header+0x67/0x290 net/ipv4/ip_gre.c:897
 dev_hard_header include/linux/netdevice.h:3436 [inline]
 neigh_connected_output+0x286/0x460 net/core/neighbour.c:1618
 NF_HOOK_COND include/linux/netfilter.h:307 [inline]
 ip6_output+0x340/0x550 net/ipv6/ip6_output.c:247
 NF_HOOK+0x9e/0x380 include/linux/netfilter.h:318
 mld_sendpack+0x8d4/0xe60 net/ipv6/mcast.c:1855
 mld_send_cr net/ipv6/mcast.c:2154 [inline]
 mld_ifc_work+0x83e/0xd60 net/ipv6/mcast.c:2693
 process_one_work kernel/workqueue.c:3257 [inline]
 process_scheduled_works+0xad1/0x1770 kernel/workqueue.c:3340
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3421
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x510/0xa50 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:skb_panic+0x157/0x160 net/core/skbuff.c:213
Code: c7 60 9c 6f 8c 48 8b 74 24 08 48 8b 54 24 10 8b 0c 24 44 8b 44 24 04 4d 89 e9 50 55 41 57 41 56 e8 ce 6a f5 ff 48 83 c4 20 90 <0f> 0b cc cc cc cc cc cc cc 90 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffc900040cf540 EFLAGS: 00010282
RAX: 0000000000000097 RBX: dffffc0000000000 RCX: 577f10acb7f51400
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: 00000000000006c0 R08: 0000000000000003 R09: 0000000000000004
R10: dffffc0000000000 R11: fffffbfff1bbae40 R12: ffff88805235f510
R13: ffff888058b43000 R14: ffff887fdfa6e194 R15: 0000000000000120
FS:  0000000000000000(0000) GS:ffff888125f21000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f2de99d5d58 CR3: 00000000b0bfa000 CR4: 00000000003526f0


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


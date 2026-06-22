Return-Path: <netdev+bounces-301172-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZzN9B41qOWoDsQcAu9opvQ
	(envelope-from <netdev+bounces-301172-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 19:02:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AB3B6B15AA
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 19:02:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=appspotmail.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301172-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301172-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BE9F73016AC0
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 17:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D15591C2324;
	Mon, 22 Jun 2026 17:01:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f77.google.com (mail-ot1-f77.google.com [209.85.210.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CBD53264F7
	for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 17:01:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782147688; cv=none; b=kljmzEEay2hGNJkf5b7J3KMqIwDYNKcXrgMeOLHuqOUdXmU405Xot0JU2aYEg8rjA9fsodETTe9mUAhlTm6XL9lm5aSyF3bLbHqlyq4i9NuUaD7qX6cAScINuogRM5nst6M+xq5dsXlbs2nMPzugykTYaimHsnzewUaalvSljbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782147688; c=relaxed/simple;
	bh=d7IfLOXULxFfoxCxZL6h1WiDjlcreZF/0pv22enkCVc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=eswckEyUkkgceW9OhqELf5huNlBjYMnB7PLpxtUSrAt6bDBdxNG+pdpOCpKXob27dMVDNSPd2uM6oxOOcZERvqFN3RMvVpCbHAmrR/u1AUF5ezOprzLN1vriFF28KdRcJKpjD6P9zSDwurgxm2P63hjrsSazdIR1eg1iR3WoRJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.77
Received: by mail-ot1-f77.google.com with SMTP id 46e09a7af769-7e757d8937aso8729880a34.2
        for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 10:01:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782147686; x=1782752486;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=grJrt3G4vW1MLNQdhPY5UoHK94iiFCg4Mi4xoetGlHI=;
        b=NlS9fttiiwjuFWnUbDsePxLHp+13gvhUEASwI0chk0SbyXHR1TwYHHgDv+o6EOPl+f
         buyIaj2E3sI3ten/ajRZX0GvfI6Ez+dR14mTdzc/oUUqFIAKxwKMscO/+Mb1SMWBeKmO
         2NcJRrhvRJv8Am3dKqbTyxwsm40x93QcYbZov2XaTDSPXr/MDOfcMx6f1GBNnDyZWX+g
         dmRJdKlwS5sr4f3DwsD5Jiq58ku+Y1z5HJYuYT864cOCrmbeLXzESIEd+jO9L+UeIZzH
         +4xXLsQWwPInaxYC/GpNS+bm4sasud6t4PbWgAV2T1c8W75sXsjjFS7yD2iLR/+Dbyvz
         Fs5A==
X-Forwarded-Encrypted: i=1; AFNElJ+RWYwpuMFiobYvm8EuWha7JMFgEv39NR/HwskoQ1OBVqhXr5+CB6uh7+jPbXA7wsvdSoRE9mQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz50jmZqySjOCAwfeUD03AK+hlrhIvpDbuT8ocCqhXoFySb7ySm
	DSNv8bU1fKRqdtpzw7XTKRrm9UJgFF/MrRJjlNE14hGjQZEZDmaS8NlptI9oqjCO5FO/GgviBiE
	QrfBtFyDKJSci7niBlqLQqX3Ug3Gr77fjAEEaTYKj6frEx8fG0h9Dhv0BV3U=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6830:4115:b0:7e6:f7fb:9678 with SMTP id
 46e09a7af769-7e931d5eab6mr13671236a34.1.1782147686360; Mon, 22 Jun 2026
 10:01:26 -0700 (PDT)
Date: Mon, 22 Jun 2026 10:01:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a396a66.52ae72c2.136ac7.0003.GAE@google.com>
Subject: [syzbot] [net?] WARNING in rcuref_put_slowpath
From: syzbot <syzbot+e14bc5d4942756023b77@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=6c414e1864e61ef6];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-301172-lists,netdev=lfdr.de,e14bc5d4942756023b77];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:edumazet@google.com,m:horms@kernel.org,m:kuba@kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:syzkaller-bugs@googlegroups.com,s:lists@lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,storage.googleapis.com:url,goo.gl:url,appspotmail.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,syzkaller.appspot.com:url,googlegroups.com:email];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1AB3B6B15AA

Hello,

syzbot found the following issue on:

HEAD commit:    4fa3f5fabb30 Add linux-next specific files for 20260616
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1427abd2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6c414e1864e61ef6
dashboard link: https://syzkaller.appspot.com/bug?extid=e14bc5d4942756023b77
compiler:       Debian clang version 22.1.6 (++20260514074242+fc4aad7b5db3-1~exp1~20260514074407.73), Debian LLD 22.1.6

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/bf5b803a695d/disk-4fa3f5fa.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/47871e7c589e/vmlinux-4fa3f5fa.xz
kernel image: https://storage.googleapis.com/syzbot-assets/53cd9ef32a2b/bzImage-4fa3f5fa.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e14bc5d4942756023b77@syzkaller.appspotmail.com

------------[ cut here ]------------
rcuref - imbalanced put()
WARNING: lib/rcuref.c:266 at rcuref_put_slowpath+0x16e/0x1d0 lib/rcuref.c:266, CPU#0: ktimers/0/16
Modules linked in:
CPU: 0 UID: 0 PID: 16 Comm: ktimers/0 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/09/2026
RIP: 0010:rcuref_put_slowpath+0x16e/0x1d0 lib/rcuref.c:266
Code: c1 e8 03 42 0f b6 04 38 84 c0 75 48 c7 03 00 00 00 a0 31 c0 e9 6d ff ff ff e8 fe 13 80 06 e8 49 d7 14 fd 48 8d 3d 62 f3 e6 0a <67> 48 0f b9 3a 48 89 df be 04 00 00 00 e8 40 b3 80 fd 48 89 d8 48
RSP: 0018:ffffc90000157560 EFLAGS: 00010246
RAX: ffffffff84b04017 RBX: ffff888025328740 RCX: ffff88801d680000
RDX: 0000000000000100 RSI: 0000000000000000 RDI: ffffffff8f973380
RBP: ffffc900001575e8 R08: 0000000000000000 R09: 0000000000000100
R10: dffffc0000000000 R11: ffffed1004a650e9 R12: 1ffff9200002aeac
R13: dffffc0000000000 R14: 00000000dfffffff R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff888125ed3000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f67d5f2c558 CR3: 0000000026bb4000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 __rcuref_put include/linux/rcuref.h:117 [inline]
 rcuref_put+0x15b/0x170 include/linux/rcuref.h:173
 dst_release+0x31/0x1b0 net/core/dst.c:251
 dst_cache_per_cpu_get+0x25a/0x2d0 net/core/dst_cache.c:57
 dst_cache_get+0x10d/0x1e0 net/core/dst_cache.c:75
 tipc_udp_xmit+0xcf/0xb30 net/tipc/udp_media.c:177
 tipc_bearer_xmit_skb+0x2b3/0x400 net/tipc/bearer.c:576
 tipc_disc_timeout+0x642/0x790 net/tipc/discover.c:338
 call_timer_fn+0x192/0x5e0 kernel/time/timer.c:1748
 expire_timers kernel/time/timer.c:1799 [inline]
 __run_timers kernel/time/timer.c:2374 [inline]
 __run_timer_base+0x67b/0x9b0 kernel/time/timer.c:2386
 run_timer_base kernel/time/timer.c:2395 [inline]
 run_timer_softirq+0xb7/0x170 kernel/time/timer.c:2405
 handle_softirqs+0x1d9/0x6c0 kernel/softirq.c:626
 __do_softirq kernel/softirq.c:660 [inline]
 run_ktimerd+0x69/0x100 kernel/softirq.c:1155
 smpboot_thread_fn+0x57c/0xa80 kernel/smpboot.c:160
 kthread+0x388/0x470 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
----------------
Code disassembly (best guess):
   0:	c1 e8 03             	shr    $0x3,%eax
   3:	42 0f b6 04 38       	movzbl (%rax,%r15,1),%eax
   8:	84 c0                	test   %al,%al
   a:	75 48                	jne    0x54
   c:	c7 03 00 00 00 a0    	movl   $0xa0000000,(%rbx)
  12:	31 c0                	xor    %eax,%eax
  14:	e9 6d ff ff ff       	jmp    0xffffff86
  19:	e8 fe 13 80 06       	call   0x680141c
  1e:	e8 49 d7 14 fd       	call   0xfd14d76c
  23:	48 8d 3d 62 f3 e6 0a 	lea    0xae6f362(%rip),%rdi        # 0xae6f38c
* 2a:	67 48 0f b9 3a       	ud1    (%edx),%rdi <-- trapping instruction
  2f:	48 89 df             	mov    %rbx,%rdi
  32:	be 04 00 00 00       	mov    $0x4,%esi
  37:	e8 40 b3 80 fd       	call   0xfd80b37c
  3c:	48 89 d8             	mov    %rbx,%rax
  3f:	48                   	rex.W


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


Return-Path: <netdev+bounces-188935-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B507AAF742
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 11:57:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34CCD3BE4EC
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 09:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 567391F3D20;
	Thu,  8 May 2025 09:57:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE46C1917F4
	for <netdev@vger.kernel.org>; Thu,  8 May 2025 09:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746698262; cv=none; b=df5ZUxuRZKEJ7SRxT++pOHhwOCGqF2II05vu8DDnZl7DUgswV06QTaupRklRPi1ffMRPNPvI0fQllbvH5zJl9Is4tSa9hDKD/v3Sy9KI4IWJnWxgDpBZAcCDaUWW2dO/vEl/FDjc4fESozn6+02zkGaNSz8EP5nkYGDRhiFjXiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746698262; c=relaxed/simple;
	bh=fL0PF0ciMHijpVZKIhmCRftWb3VS4iR7YkNaqgChO70=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=R+Y+WuEUhNvL4jEWFtTZvVeOcw2cC8uzzQQ7h4WzF+uVIB1dXnnAar2shEFn/5Aqn4V59GHi1NH0mQ0Vkzr1kAmMgcTthU6ioYP8NwRftnKmTyanHEIoMhITAYvSmQ3+gs8YO5ebqLo5oVwXfhrZos0C7jcG8UOF43FG/L2h7tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-85dad56a6cbso107454939f.3
        for <netdev@vger.kernel.org>; Thu, 08 May 2025 02:57:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746698260; x=1747303060;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RUCfGynVFEJKuLMrny80Q+YbM5PtJyNSmRbHwezz5vM=;
        b=vctF6p1QNbWs91+u8uffUCLpDZRfHG8TxHCETsRP1JF8QjIDM6gC1t1MLv9mPKNgo8
         zfOlUZncsdIeYa0W9dgcHVTEr66lKxeR5cs87R1q/za1nq6wmMaYBDm6BaQZZAVlamE2
         v5oKgS0BUQd+eDXVYb7w9BBcx3OkWgsZ16mmgcs39y3JoUug4I1mi6Ud52hGFWCk+mDR
         rUDTWjOKVmBOA5M4YI7JxcYfzvbca66TqjKKpzKTDfF00ddxlaPnMZWv3l5AzBwTVe8J
         68V7+SzMSgvkcDAmDRStNuqq784xoy63SwTR0MCb6OFRk3ZZcHUnlURs1br0vHw6RDmV
         tr4g==
X-Forwarded-Encrypted: i=1; AJvYcCUHmHx8dPoFdTEmhLongrEqk4SRQZ9kei7ZRpDZdS+AbLAzjqH0kRlJf/jdyUNuJJpRQUNVmy0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0aIL/8tqF4qXioELbbYVs9aPRKsmgczo/BxJiEDTFuEj5BdEj
	pPVLRxMCIaoWeueUt8zdCudiR5ngVQr/h4Tsn6bUm+kPMamAhOfrDc7dn9mOmD5XJIHlxkyQkWc
	fbnetIeul9xKcjHIbjoBPKcyRjpOSBOVv9o3tSuX4g/vzf6Xr1blD0u8=
X-Google-Smtp-Source: AGHT+IFT7VkgtPhwGFobw/iHcC09MH/+ek0+r6QttV/iOtQWwxRcqQzC4xMBMHSFJGMTImzmhcAqPlSzi3jtWCqyJhPT25+115nr
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:14c6:b0:864:617a:13a1 with SMTP id
 ca18e2360f4ac-86747453d0bmr818286839f.14.1746698249561; Thu, 08 May 2025
 02:57:29 -0700 (PDT)
Date: Thu, 08 May 2025 02:57:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <681c8009.050a0220.654ca.0000.GAE@google.com>
Subject: [syzbot] [perf?] WARNING in __perf_event_overflow (2)
From: syzbot <syzbot+2524754f17993441bf66@syzkaller.appspotmail.com>
To: acme@kernel.org, adrian.hunter@intel.com, 
	alexander.shishkin@linux.intel.com, irogers@google.com, jolsa@kernel.org, 
	kan.liang@linux.intel.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mark.rutland@arm.com, mingo@redhat.com, 
	namhyung@kernel.org, netdev@vger.kernel.org, peterz@infradead.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    f263336a41da selftests/bpf: Add btf dedup test covering mo..
git tree:       bpf-next
console output: https://syzkaller.appspot.com/x/log.txt?x=16d3db68580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a9a25b7a36123454
dashboard link: https://syzkaller.appspot.com/bug?extid=2524754f17993441bf66
compiler:       Debian clang version 20.1.2 (++20250402124445+58df0ef89dd6-1~exp1~20250402004600.97), Debian LLD 20.1.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11d3db68580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8b191964c33b/disk-f263336a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/fde84e52fec4/vmlinux-f263336a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e2686ad850de/bzImage-f263336a.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2524754f17993441bf66@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 6044 at kernel/events/core.c:10226 __perf_event_overflow+0xaf9/0xe10 kernel/events/core.c:10226
Modules linked in:
CPU: 1 UID: 0 PID: 6044 Comm: syz.1.17 Not tainted 6.15.0-rc4-syzkaller-gf263336a41da #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/29/2025
RIP: 0010:__perf_event_overflow+0xaf9/0xe10 kernel/events/core.c:10226
Code: 89 3e 4c 8b 3c 24 e9 c3 fc ff ff e8 21 77 d0 ff 49 bd 00 00 00 00 00 fc ff df 4c 8b 74 24 28 e9 06 fe ff ff e8 08 77 d0 ff 90 <0f> 0b 90 e9 1b ff ff ff e8 fa 76 d0 ff 48 c7 c7 80 b3 73 8b e8 0e
RSP: 0000:ffffc90002f179c0 EFLAGS: 00010293
RAX: ffffffff81ef47c8 RBX: ffff888011140c40 RCX: ffff88802fd43c00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc90002f17ad0 R08: ffff888011140e7f R09: 1ffff110022281cf
R10: dffffc0000000000 R11: ffffed10022281d0 R12: ffffc90002f17f58
R13: dffffc0000000000 R14: ffff888011140e78 R15: 0000000000000000
FS:  00007f2cfb8cd6c0(0000) GS:ffff8881261cc000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f2cfb8cd0e8 CR3: 0000000032960000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 perf_swevent_overflow kernel/events/core.c:10324 [inline]
 perf_swevent_event+0x2f4/0x5e0 kernel/events/core.c:-1
 do_perf_sw_event kernel/events/core.c:10464 [inline]
 ___perf_sw_event+0x4a1/0x700 kernel/events/core.c:10491
 __perf_sw_event+0xfa/0x1a0 kernel/events/core.c:10503
 perf_sw_event include/linux/perf_event.h:1537 [inline]
 do_user_addr_fault+0x12e4/0x1390 arch/x86/mm/fault.c:1284
 handle_page_fault arch/x86/mm/fault.c:1480 [inline]
 exc_page_fault+0x68/0x110 arch/x86/mm/fault.c:1538
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
RIP: 0033:0x7f2cfa85eb1b
Code: 00 74 24 80 3d d8 6b e8 00 00 0f b6 35 ce 6b e8 00 75 4c 80 3d c9 6b e8 00 00 75 43 40 84 f6 75 3e 66 0f 1f 44 00 00 48 89 ef <e8> 60 fa ff ff 8b 45 0c 85 c0 75 38 b9 40 42 0f 00 ba 81 00 00 00
RSP: 002b:00007f2cfb8cd0f0 EFLAGS: 00010246
RAX: 0000000000000001 RBX: 00007f2cfabb5fa8 RCX: 00007f2cfa98e969
RDX: 0000000000000000 RSI: 0000000000000080 RDI: 00007f2cfabb5fa0
RBP: 00007f2cfabb5fa0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f2cfabb5fac
R13: 0000000000000000 R14: 00007ffe3a7ce340 R15: 00007ffe3a7ce428
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


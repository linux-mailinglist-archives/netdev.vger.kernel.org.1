Return-Path: <netdev+bounces-228124-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F0CFABC2156
	for <lists+netdev@lfdr.de>; Tue, 07 Oct 2025 18:18:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EEC974EAD8B
	for <lists+netdev@lfdr.de>; Tue,  7 Oct 2025 16:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9716A2E6CDC;
	Tue,  7 Oct 2025 16:18:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA98A1F1518
	for <netdev@vger.kernel.org>; Tue,  7 Oct 2025 16:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759853909; cv=none; b=W5DOqkU4xNvRlGQsId9QHgulTVOZLkRzHZnH5nyv9rqRxBm63lJRdxvodHVbBoslg6wlA+NmDA5wrHVcDz1Etr+dl9dURn1vLkpSxWipdEWq5WiMd4mOYmQL/tOHN6wwfmb0E14MPRBeaLCP8rcVh9Y3PnAQNTzyqcUvegFxoDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759853909; c=relaxed/simple;
	bh=/A8IlGR2aPRQk/7uCzF0JMnWO7ZBfWRgr4joBxiC+8w=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=nfooOHGJeCk158aZJpMRFYb1/6CWxOsASYmh2YbSL1iZeDYcG3ObDNbju6AinNYkAPk7zneP8RY1SXGalPht+I8guELQ4NW0OMsjA4orjmyf3+phdTRe6Aw/iTf4ZxHbOS+LJuyW7OXSuAeGbE6/mdK4SqNsAEQoJIqstS2NtoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-42f7c8774f6so15470605ab.0
        for <netdev@vger.kernel.org>; Tue, 07 Oct 2025 09:18:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759853907; x=1760458707;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lZQxPVH9aOC3z7g2ZE6k7k0QRTdiI3Cxj6W4vp3imfE=;
        b=GydjMKfGKlC16qTl+rUwaRxp1X6biblZmvlRhTqjp/CXo40yYPvyc+ktNXi+WZCIxR
         kJCj55Plq/YMNC17+wfACDjHxe3MiQxeBsB66zyn5LNe+fuHzJz/9b5COWusX2dyCfuH
         G5bOgzPUvLsVx5FeVTsAtNLoLawntE2xBO4SEwc/PJfsL/EtmzpArXjHQjj4DWv4ZoCh
         OhtVajNb6Jbtv32JAdogXn0vplIbxJHPNjICS4PA4OPj/Isl6Q2Y/lZu+g8GWU7R/xZi
         wggk4/mn1DLsNGyRON6yFcs+xcHXJWxrAZEWpEWPNy5fraJIV4D52e+V+gNM6QyJg4Hb
         5qkA==
X-Forwarded-Encrypted: i=1; AJvYcCX3wxfG9hILdmMyd+0StVG4w0SmEjFwsGkaC43MUVPwTd32xMqHNzFkXU18ayvhZ67VE/PUYTI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwiUuv/gOMRLVBscMACFrXYgO4pDlCdShKVyEdUG1+zmwT4o8D
	RCdnBjURyAqv+MQccpg35fg3mDHZS86uaWw0XwURm8xVEo4QPFsX/eK+2ZP29ORdwzzJR74iQq9
	AXdKZL18DoKBzLJ5R3L1y4yV5OrKLiJ+tdNIGjq1lCxw/CJIGBhhdZejM9Ug=
X-Google-Smtp-Source: AGHT+IFYFag4k6egAe1JboWcm0XVijHFYgmBfoEL7zj+T1IXkXH/oCA1DCyFKaPaVedHkjKv4iGGe0COh+UGJRyYm1971qEF3neH
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a6d:b0:42e:6e45:e0a3 with SMTP id
 e9e14a558f8ab-42e7acd296dmr219474365ab.2.1759853906965; Tue, 07 Oct 2025
 09:18:26 -0700 (PDT)
Date: Tue, 07 Oct 2025 09:18:26 -0700
In-Reply-To: <681c8009.050a0220.654ca.0000.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68e53d52.a00a0220.298cc0.047d.GAE@google.com>
Subject: Re: [syzbot] [perf?] WARNING in __perf_event_overflow (2)
From: syzbot <syzbot+2524754f17993441bf66@syzkaller.appspotmail.com>
To: acme@kernel.org, adrian.hunter@intel.com, 
	alexander.shishkin@linux.intel.com, irogers@google.com, jolsa@kernel.org, 
	kan.liang@linux.intel.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mark.rutland@arm.com, mingo@redhat.com, 
	namhyung@kernel.org, netdev@vger.kernel.org, peterz@infradead.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    de7342228b73 bpf: Finish constification of 1st parameter o..
git tree:       bpf-next
console output: https://syzkaller.appspot.com/x/log.txt?x=16e75a7c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1e0e0bf7e51565cd
dashboard link: https://syzkaller.appspot.com/bug?extid=2524754f17993441bf66
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=167761e2580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16b941e2580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/48d49cec8205/disk-de734222.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0c197aec9229/vmlinux-de734222.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7f7872725138/bzImage-de734222.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2524754f17993441bf66@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 6380 at kernel/events/core.c:10369 __perf_event_overflow+0xb3b/0xe40 kernel/events/core.c:10369
Modules linked in:
CPU: 1 UID: 0 PID: 6380 Comm: syz.3.105 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
RIP: 0010:__perf_event_overflow+0xb3b/0xe40 kernel/events/core.c:10369
Code: 08 4c 89 f7 e8 a6 f9 34 00 4d 89 3e e9 bc fa ff ff 48 c7 44 24 40 00 00 00 00 e8 d0 55 cf ff e9 1c fe ff ff e8 c6 55 cf ff 90 <0f> 0b 90 e9 2d ff ff ff e8 b8 55 cf ff 48 c7 c7 a0 fa 73 8b e8 ec
RSP: 0018:ffffc9000afd74c0 EFLAGS: 00010293
RAX: ffffffff81efce8a RBX: 1ffff1100b67a3b5 RCX: ffff8880572d0000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc9000afd75d0 R08: ffff88805b3d1b4f R09: 1ffff1100b67a369
R10: dffffc0000000000 R11: ffffed100b67a36a R12: dffffc0000000000
R13: ffff88805b3d1900 R14: ffff88805b3d1b48 R15: 0000000000000000
FS:  00007fd06a42e6c0(0000) GS:ffff888125e27000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 00000000114bc000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 perf_swevent_overflow kernel/events/core.c:10467 [inline]
 perf_swevent_event+0x2f4/0x5e0 kernel/events/core.c:-1
 do_perf_sw_event kernel/events/core.c:10607 [inline]
 ___perf_sw_event+0x4a1/0x700 kernel/events/core.c:10634
 __perf_sw_event+0xfa/0x1a0 kernel/events/core.c:10646
 perf_sw_event include/linux/perf_event.h:1596 [inline]
 do_user_addr_fault+0x12d9/0x1380 arch/x86/mm/fault.c:1283
 handle_page_fault arch/x86/mm/fault.c:1476 [inline]
 exc_page_fault+0x82/0x100 arch/x86/mm/fault.c:1532
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
RIP: 0010:rep_movs_alternative+0x4a/0x90 arch/x86/lib/copy_user_64.S:74
Code: 35 04 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 8b 06 48 89 07 48 83 c6 08 48 83 c7 08 83 e9 08 74 db 83 f9 08 73 e8 eb c5 <f3> a4 e9 4f 35 04 00 48 8b 06 48 89 07 48 8d 47 08 48 83 e0 f8 48
RSP: 0018:ffffc9000afd7af0 EFLAGS: 00050202
RAX: 00007ffffffff001 RBX: 0000000000000060 RCX: 0000000000000060
RDX: 0000000000000001 RSI: 0000000000000000 RDI: ffffc9000af0d060
RBP: 0000000000000000 R08: ffffc9000af0d0bf R09: 1ffff920015e1a17
R10: dffffc0000000000 R11: fffff520015e1a18 R12: ffffc9000af0d060
R13: dffffc0000000000 R14: ffffc9000af0d060 R15: 0000000000000000
 copy_user_generic arch/x86/include/asm/uaccess_64.h:126 [inline]
 raw_copy_from_user arch/x86/include/asm/uaccess_64.h:141 [inline]
 _inline_copy_from_user include/linux/uaccess.h:178 [inline]
 _copy_from_user+0x7a/0xb0 lib/usercopy.c:18
 copy_from_user include/linux/uaccess.h:212 [inline]
 copy_from_bpfptr_offset include/linux/bpfptr.h:53 [inline]
 copy_from_bpfptr+0x5c/0x90 include/linux/bpfptr.h:59
 bpf_prog_load+0xa83/0x19e0 kernel/bpf/syscall.c:2992
 __sys_bpf+0x507/0x860 kernel/bpf/syscall.c:6134
 __do_sys_bpf kernel/bpf/syscall.c:6244 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:6242 [inline]
 __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:6242
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fd06958eec9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fd06a42e038 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 00007fd0697e5fa0 RCX: 00007fd06958eec9
RDX: 0000000000000094 RSI: 00002000000000c0 RDI: 0000000000000005
RBP: 00007fd069611f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fd0697e6038 R14: 00007fd0697e5fa0 R15: 00007ffcf5bcab18
 </TASK>
----------------
Code disassembly (best guess):
   0:	35 04 00 66 2e       	xor    $0x2e660004,%eax
   5:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
   c:	00
   d:	0f 1f 00             	nopl   (%rax)
  10:	48 8b 06             	mov    (%rsi),%rax
  13:	48 89 07             	mov    %rax,(%rdi)
  16:	48 83 c6 08          	add    $0x8,%rsi
  1a:	48 83 c7 08          	add    $0x8,%rdi
  1e:	83 e9 08             	sub    $0x8,%ecx
  21:	74 db                	je     0xfffffffe
  23:	83 f9 08             	cmp    $0x8,%ecx
  26:	73 e8                	jae    0x10
  28:	eb c5                	jmp    0xffffffef
* 2a:	f3 a4                	rep movsb %ds:(%rsi),%es:(%rdi) <-- trapping instruction
  2c:	e9 4f 35 04 00       	jmp    0x43580
  31:	48 8b 06             	mov    (%rsi),%rax
  34:	48 89 07             	mov    %rax,(%rdi)
  37:	48 8d 47 08          	lea    0x8(%rdi),%rax
  3b:	48 83 e0 f8          	and    $0xfffffffffffffff8,%rax
  3f:	48                   	rex.W


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.


Return-Path: <netdev+bounces-93659-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B7F98BCA5C
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 11:18:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E99D1C21497
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 09:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B8191422B9;
	Mon,  6 May 2024 09:18:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14272AF1B
	for <netdev@vger.kernel.org>; Mon,  6 May 2024 09:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714987108; cv=none; b=ca/4iadM5+Q7qkklWUwzQ1YYxhD39woCULf+y9Wnp79Hc8iLNAaHxrOzM84UiURDudttzxmJkTLsuUqF9VNpU/kUyXKvXPeRu8onltHdkUKSPfmDnu6rk+cnhIikjLRhaOipodq39qjSOVEKugyWfMJwe4XicLylvpwF4EeCNf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714987108; c=relaxed/simple;
	bh=bt9iG5iGEVMzCb9ZV9u/fTEswRCBi1AwDxwb5u/ZEdg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=GpNZDJ+f2WG3DXHr0Y75OpertvSsUeVbvCXDjGr2BDvKg3r9koNr/QxSdGSQc0e6orWmVAnsi+cgTj/nGNdjv2/94d1fC88mLvRRFaKuG2Y8uZ2TfMFawXiRXzbDNMUqi5n2tZmi8OpAtYK0GgKlPp68rby5+TM/JMf61sdCp/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-36c96503424so8691045ab.2
        for <netdev@vger.kernel.org>; Mon, 06 May 2024 02:18:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714987106; x=1715591906;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uvvsM8qCsWVlgVqdoqbQI/jpRNJ31DPMt8zgavOO3TU=;
        b=MQpD0Yf+EjLEaMIuv0Nn1sA0sJ+nWzCyQVK9ZHSOJcuGGO8v9TwShifPG72z2jb+PU
         VfiGWAHGYLriBOmo2mKn7Wv1N6i69XVHaVXLaDs9B2f7rUTQYUsnfPQsrYl4U2qNBak+
         7AC97NinKQvbNWWWI0ViMbpqCWy3+gC1unot+RkUjQ6tPPMTzU8tekL5ZINxD/XWHPE0
         cGnnkGI88SvmJovchApNgAxdy+RyR4nY8W7G1oXBJrd+XATH+2ZiUZIU+SMfkrcXBsZR
         oBa3WnVzZcjLCgzIrX+xFX2IeZ5ByT891kkdKLyfbKkOLkH2zD3M6QQyKfTpbNXVC7GM
         Ll+w==
X-Forwarded-Encrypted: i=1; AJvYcCXUNdgbOPXClA6KBPe4/Rh/BExNF5TyoXLBQmBzTTkLwN1uNCxHHp6QxfDvAa81PzAb3O6oeIV7y+0/kLMWUEdI7UCCjfpc
X-Gm-Message-State: AOJu0Yy9iZm3Lg/897WaNREDOurgyRRByBLj0ohFi/LpJ1uxz5M4W3nd
	285DDad39jVJ2qJVxvm+v1WJmVDSOuFRroXoAiPLOuwzvOjRJSJt1vIGxcEtBoTfPHk9mg070qG
	bZJtZZc+JgDXkBJSUWqXMpebdWC6ruDP+znFi10d09AvUe/a4vdWXzbc=
X-Google-Smtp-Source: AGHT+IE0TkiS4w/KJWa6SeXCVNKI6QPz9TkKn+ltO/oCMNBbqPg20zDDbtrb3z+mgJwLmiechhKkg3GV7CKWhwoSzPPL+gM3Hq/J
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c24d:0:b0:36c:4657:bd62 with SMTP id
 k13-20020a92c24d000000b0036c4657bd62mr646998ilo.3.1714987106075; Mon, 06 May
 2024 02:18:26 -0700 (PDT)
Date: Mon, 06 May 2024 02:18:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004096100617c58d54@google.com>
Subject: [syzbot] [mm?] kernel BUG in __vma_reservation_common
From: syzbot <syzbot+d3fe2dc5ffe9380b714b@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, muchun.song@linux.dev, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    8953285d7bd6 rxrpc: Clients must accept conn from any addr..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=1347a228980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=98d5a8e00ed1044a
dashboard link: https://syzkaller.appspot.com/bug?extid=d3fe2dc5ffe9380b714b
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/5b9c540d7f6b/disk-8953285d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/831b091085cc/vmlinux-8953285d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/97a6dd56102c/bzImage-8953285d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d3fe2dc5ffe9380b714b@syzkaller.appspotmail.com

 </TASK>
------------[ cut here ]------------
kernel BUG at mm/hugetlb.c:813!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 1 PID: 9895 Comm: syz-executor.3 Not tainted 6.9.0-rc5-syzkaller-00192-g8953285d7bd6 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
RIP: 0010:region_abort mm/hugetlb.c:813 [inline]
RIP: 0010:__vma_reservation_common+0x795/0x7d0 mm/hugetlb.c:2856
Code: f1 f2 89 09 e8 0c e6 9f ff 90 0f 0b e8 04 e6 9f ff 90 0f 0b e8 fc e5 9f ff 90 0f 0b e8 f4 e5 9f ff 90 0f 0b e8 ec e5 9f ff 90 <0f> 0b e8 e4 e5 9f ff 90 0f 0b e8 dc e5 9f ff 90 0f 0b e8 d4 e5 9f
RSP: 0018:ffffc90009c17240 EFLAGS: 00010293
RAX: ffffffff81f61a14 RBX: 0000000000000000 RCX: ffff88806eaf1e00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc90009c17310 R08: ffffffff81f61526 R09: fffff52001382e38
R10: dffffc0000000000 R11: fffff52001382e38 R12: 0000000000000000
R13: dffffc0000000000 R14: ffff888064f61408 R15: ffff888064f61400
FS:  00007fba641616c0(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055558b067788 CR3: 00000000762e8000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 vma_add_reservation mm/hugetlb.c:2919 [inline]
 __unmap_hugepage_range+0x1257/0x2340 mm/hugetlb.c:5791
 unmap_vmas+0x3cc/0x5f0 mm/memory.c:1883
 unmap_region+0x1ec/0x350 mm/mmap.c:2310
 do_vmi_align_munmap+0x11bf/0x1930 mm/mmap.c:2628
 do_vmi_munmap+0x24e/0x2d0 mm/mmap.c:2696
 mmap_region+0x6af/0x1e50 mm/mmap.c:2747
 do_mmap+0x7af/0xe60 mm/mmap.c:1385
 vm_mmap_pgoff+0x1e3/0x420 mm/util.c:573
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fba6347dea9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fba641610c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000009
RAX: ffffffffffffffda RBX: 00007fba635abf80 RCX: 00007fba6347dea9
RDX: 0000000000000000 RSI: 00000000001fffff RDI: 0000000020000000
RBP: 00007fba64161120 R08: ffffffffffffffff R09: 0000000000000000
R10: 0000000000028031 R11: 0000000000000246 R12: 0000000000000001
R13: 000000000000000b R14: 00007fba635abf80 R15: 00007ffc5b82e2c8
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:region_abort mm/hugetlb.c:813 [inline]
RIP: 0010:__vma_reservation_common+0x795/0x7d0 mm/hugetlb.c:2856
Code: f1 f2 89 09 e8 0c e6 9f ff 90 0f 0b e8 04 e6 9f ff 90 0f 0b e8 fc e5 9f ff 90 0f 0b e8 f4 e5 9f ff 90 0f 0b e8 ec e5 9f ff 90 <0f> 0b e8 e4 e5 9f ff 90 0f 0b e8 dc e5 9f ff 90 0f 0b e8 d4 e5 9f
RSP: 0018:ffffc90009c17240 EFLAGS: 00010293
RAX: ffffffff81f61a14 RBX: 0000000000000000 RCX: ffff88806eaf1e00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc90009c17310 R08: ffffffff81f61526 R09: fffff52001382e38
R10: dffffc0000000000 R11: fffff52001382e38 R12: 0000000000000000
R13: dffffc0000000000 R14: ffff888064f61408 R15: ffff888064f61400
FS:  00007fba641616c0(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055558b067788 CR3: 00000000762e8000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


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


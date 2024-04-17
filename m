Return-Path: <netdev+bounces-88646-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B758A8011
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 11:47:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F37C2829F1
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 09:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59EC1136E13;
	Wed, 17 Apr 2024 09:47:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D465C132807
	for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 09:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713347242; cv=none; b=QXVoiKvZS0TRP2I15JFd+WifZeOXwigyEl+ddJOSLiWlcxQauO+9eyPBSwjFjSLIbs0ZqO43xYjM3xD+JRvyB5uwoTFbzJge+IWfZauvDtNufHi1TJFlSoHxMvIu281Z4xWZR9iR2s5BbIZGAZETXPKX3SzAdsisZw0l0EovEqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713347242; c=relaxed/simple;
	bh=7T0jE4ZevulDuzaXolOY+mL/1dOAqMHAmX9QE/q0xrk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=OpYleSeJyWx4zY5ekpDT/eZ3iX42A34ocV6bcTcT5n2gJcEP9H2tq6+KdBZy3ItU9jaOO02vzBrycD9E6XYg3SRImMfMdh4lm6QgLVrSTX28YWUh/uP0D7WJ9PuoEvUXsFAb2D7XrdhM/PjYsTYLWrLpZrhydYv401lIDvrHXmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-36a1a2f396aso54786305ab.3
        for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 02:47:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713347240; x=1713952040;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/axdWpjvUcy29WnnMh6W6dLuZZUINorcU0gQ6Y0GJMI=;
        b=oDlVD8CDKKkWc4KRWCUHEinzuS3fAwWpUjbdxeMRIkHbFqDu73P0zXlK1JV+bALCKq
         mcJutAGO5rMMAt3iOLL0BAy2BEVkk8+1Nt0ut18KFBRgGLm/g1NNH6x1WDz0N2J4gpXb
         bWzeX8gMwKYBriug+zXOM7s6xx6C0CUP1cyuQl0te9Y31dgJKPceX9RbLlP0mTrBa1y/
         0/Kf+vOiQ+6ChLXTCG+bX9l/sHtiSNZOXnTMoJIE/Ss6eC9qwyPhcmERCc5TWr4swnX0
         JR8eerAbesJz3qN6ypGAoX0tI/XsN8c4tURDrBXQCCWE4bZ2Huxi+FNDC5Vm1wTcuAC+
         nMYA==
X-Forwarded-Encrypted: i=1; AJvYcCVlPJNsHMEWWMay3Ho8C+21dx7bjZcqiz5pR+Fabtf5qErsWzqf+On4IYAAD+BemqUhW+myrfWDTOiIXhxHdkoVPlFkEurJ
X-Gm-Message-State: AOJu0YzYRjUgLm/WqBECsq8ojec0jr4Ch1q+6/4R2KXUCxa03wWUI031
	5V3mAShxzBrZhnEsNZw9w83V01pvY8wXDd/agxKtGaalg+UdWYacsL43+Y4wgxMsfBjrTNkA0pq
	Ov897ZtSN9a/PcpKi6wMuaYvVjcpf/gAW5kMD/NQeDPjxyLmkHelFBBM=
X-Google-Smtp-Source: AGHT+IHBjI22WoUkN+g93OaYFolruxJqbuXLW/vEsANgzn74WeM5aLQzKxRfX9He5/w57A1Yq3XimXwkijYMqDumu+eSMRyXH4xZ
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d83:b0:36b:2464:bd2c with SMTP id
 h3-20020a056e021d8300b0036b2464bd2cmr234520ila.2.1713347240062; Wed, 17 Apr
 2024 02:47:20 -0700 (PDT)
Date: Wed, 17 Apr 2024 02:47:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009f0651061647bd5e@google.com>
Subject: [syzbot] [fs?] WARNING in stashed_dentry_prune (2)
From: syzbot <syzbot+e25ef173c0758ea764de@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    443574b03387 riscv, bpf: Fix kfunc parameters incompatibil..
git tree:       bpf
console+strace: https://syzkaller.appspot.com/x/log.txt?x=130e2add180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6fb1be60a193d440
dashboard link: https://syzkaller.appspot.com/bug?extid=e25ef173c0758ea764de
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12fb63f3180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14e68f6d180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/3f355021a085/disk-443574b0.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/44cf4de7472a/vmlinux-443574b0.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a99a36c7ad65/bzImage-443574b0.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e25ef173c0758ea764de@syzkaller.appspotmail.com

RDX: 0000000000000002 RSI: 00007ffd10172950 RDI: 00000000ffffff9c
RBP: 00007ffd10172950 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000002
R13: 431bde82d7b634db R14: 0000000000000001 R15: 0000000000000001
 </TASK>
------------[ cut here ]------------
WARNING: CPU: 0 PID: 5067 at fs/libfs.c:2117 stashed_dentry_prune+0x97/0xa0 fs/libfs.c:2117
Modules linked in:
CPU: 0 PID: 5067 Comm: syz-executor252 Not tainted 6.8.0-syzkaller-05236-g443574b03387 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
RIP: 0010:stashed_dentry_prune+0x97/0xa0 fs/libfs.c:2117
Code: 00 00 e8 ac c1 e2 ff 31 c9 4c 89 f0 f0 49 0f b1 0f eb 05 e8 7b 77 7f ff 5b 41 5c 41 5e 41 5f c3 cc cc cc cc e8 6a 77 7f ff 90 <0f> 0b 90 eb e9 0f 1f 40 00 90 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffc9000394f4c8 EFLAGS: 00010293
RAX: ffffffff82157906 RBX: ffff888075d4b588 RCX: ffff8880221c1e00
RDX: 0000000000000000 RSI: 0000000000000010 RDI: ffff888075d4b490
RBP: 0000000000000001 R08: ffffffff820fa354 R09: 1ffff1100eba96a5
R10: dffffc0000000000 R11: ffffffff82157870 R12: dffffc0000000000
R13: dffffc0000000000 R14: ffff888075d4b490 R15: 0000000000000000
FS:  000055555a374380(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f7c10b02c00 CR3: 0000000011176000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __dentry_kill+0xa9/0x630 fs/dcache.c:594
 dput+0x19f/0x2b0 fs/dcache.c:845
 prepare_anon_dentry fs/libfs.c:2018 [inline]
 path_from_stashed+0x695/0xb00 fs/libfs.c:2094
 proc_ns_get_link+0xf9/0x230 fs/proc/namespaces.c:61
 pick_link+0x631/0xd50
 step_into+0xca9/0x1080 fs/namei.c:1875
 open_last_lookups fs/namei.c:3590 [inline]
 path_openat+0x18b0/0x3240 fs/namei.c:3797
 do_filp_open+0x235/0x490 fs/namei.c:3827
 do_sys_openat2+0x13e/0x1d0 fs/open.c:1407
 do_sys_open fs/open.c:1422 [inline]
 __do_sys_openat fs/open.c:1438 [inline]
 __se_sys_openat fs/open.c:1433 [inline]
 __x64_sys_openat+0x247/0x2a0 fs/open.c:1433
 do_syscall_64+0xfb/0x240
 entry_SYSCALL_64_after_hwframe+0x6d/0x75
RIP: 0033:0x7f7c10aceda1
Code: 75 57 89 f0 25 00 00 41 00 3d 00 00 41 00 74 49 80 3d ca 92 07 00 00 74 6d 89 da 48 89 ee bf 9c ff ff ff b8 01 01 00 00 0f 05 <48> 3d 00 f0 ff ff 0f 87 93 00 00 00 48 8b 54 24 28 64 48 2b 14 25
RSP: 002b:00007ffd101728a0 EFLAGS: 00000202 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f7c10aceda1
RDX: 0000000000000002 RSI: 00007ffd10172950 RDI: 00000000ffffff9c
RBP: 00007ffd10172950 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000002
R13: 431bde82d7b634db R14: 0000000000000001 R15: 0000000000000001
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


Return-Path: <netdev+bounces-157049-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83317A08C7F
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 10:43:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECEEC3A8AF1
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 09:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FBD420ADD6;
	Fri, 10 Jan 2025 09:40:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11631FAC4E
	for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 09:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736502029; cv=none; b=sDPyt2dskZmzlX8vJJYL/wLis/emEp3NxBK2NG5XHd0WPxfWMVEZ2oTr3w2mb7Dv71vzIfjq0/yJPBZSwJAPU2IFX5sv/K/dx1eupSr0wp23UFgX2EYp20MaEiORKJ4/n7PeWn08RqGqssozxgg1Z1hhL6QDk2Q1xKXWZE7AEEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736502029; c=relaxed/simple;
	bh=jRZZVvPzcTLAALrJb5P5wjAXGaSTcKAGYUMOjx+n+TQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=nfBG9QlIwUu5iOvQwJxtFTjBuVIV5b9jxrx4SxpLqNDLrB8idb/ZNjeOJq22g3LA2K+p9YpbY9oT2DsEZYgt5aZIfFbP+HXCIOaM4JIhEZOL8qXB4DOgxruEoumUkhZxTUt5HOi0d9/Dfd4xxSnCDudSWN0QraxM7v5+vAw8Raw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3a7e0d5899bso37207165ab.0
        for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 01:40:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736502027; x=1737106827;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GbyatlHED5CvzhsWVXiLXPadPbtXKoYN7J3w3f52bmY=;
        b=KuFs/ioHp3ALnUcm0aVP5uhDfx1U1JRPWYFsXEUtbIRRm39rLYBA/bL0mYEPQQgMWt
         m2o/EQb1L/CBlAM7C+KQfQ8ygab/hSA1vpOIcpsvYm+umdLu73yfswf0vtyLK234n8q6
         VrQBcQtxcr4gClepTXVT2gcE1Um8uflUIJpxZrJGpGxpCDNdlQi49u//zFZI9cxQHMIc
         piSdEhYCghiMRkUZKmiMUuXUqI5BYqR+lBlQdWMEqa7bRk8FrUGCZk87ovzhfWXLzXDD
         mjSc1mzxRHqVQWEobzR9sUnVqr/TjZ2oDlVjWxZ6pxwil+5LJsxcGo+8qHdx/MElocOT
         kcMA==
X-Forwarded-Encrypted: i=1; AJvYcCWP827u36EsD6iR1qs0IHMulFhWw6ut+Jfz+utGEJNsrd+oD4BgFs0JmdoaHtRRd2GLrKMKARc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy58Tpba9TiRHEFveF034lsRjgTtRYOCAtJqXriAGTilyxDNhdf
	jhJQCyvOmxTlQZqkrCBqyXBOwKosALvQuvsBFn/zsi0Xor2fBHt5SJt5SCAk3O1uDUyf2J6yQcj
	UL8wOBEKZjjmMgx2uImM/cytOtDc2BveeoHs8gjJ7lUO1SDTpiXTg2xc=
X-Google-Smtp-Source: AGHT+IEUeApzUsKgicvoyxiVZVuWtpFCV/Ti3oZK9pDTn3lvl1UjIIp9k9CuA5NvxpHNaeIvMr3JNyv5i6LeLaIU0cGc3Z1R1uvE
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d8b:b0:3a7:e01b:6410 with SMTP id
 e9e14a558f8ab-3ce3a938943mr83463555ab.18.1736502026921; Fri, 10 Jan 2025
 01:40:26 -0800 (PST)
Date: Fri, 10 Jan 2025 01:40:26 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6780eb0a.050a0220.d0267.0027.GAE@google.com>
Subject: [syzbot] [mm?] bpf test error: WARNING in enable_work
From: syzbot <syzbot+88988cfce8f3aa42cc80@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, ast@kernel.org, daniel@iogearbox.net, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    9d89551994a4 Linux 6.13-rc6
git tree:       bpf
console output: https://syzkaller.appspot.com/x/log.txt?x=122ac1df980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4ef22c4fce5135b4
dashboard link: https://syzkaller.appspot.com/bug?extid=88988cfce8f3aa42cc80
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/9bc45dda6651/disk-9d895519.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/34e0e0deceda/vmlinux-9d895519.xz
kernel image: https://storage.googleapis.com/syzbot-assets/503e9fd75086/bzImage-9d895519.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+88988cfce8f3aa42cc80@syzkaller.appspotmail.com

------------[ cut here ]------------
workqueue: work disable count underflowed
WARNING: CPU: 1 PID: 22 at kernel/workqueue.c:4317 work_offqd_enable kernel/workqueue.c:4317 [inline]
WARNING: CPU: 1 PID: 22 at kernel/workqueue.c:4317 enable_work+0x34d/0x360 kernel/workqueue.c:4488
Modules linked in:
CPU: 1 UID: 0 PID: 22 Comm: cpuhp/1 Not tainted 6.13.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:work_offqd_enable kernel/workqueue.c:4317 [inline]
RIP: 0010:enable_work+0x34d/0x360 kernel/workqueue.c:4488
Code: d8 5b 41 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc e8 18 82 37 00 c6 05 f9 ac 9b 0e 01 90 48 c7 c7 00 d7 09 8c e8 d4 25 f8 ff 90 <0f> 0b 90 90 e9 56 ff ff ff e8 b5 c7 60 0a 0f 1f 44 00 00 90 90 90
RSP: 0000:ffffc900001c7bc0 EFLAGS: 00010046
RAX: 7f171ad72ec7e200 RBX: 0000000000000000 RCX: ffff88801d2f3c00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc900001c7c88 R08: ffffffff81602a82 R09: 1ffffffff1cfa210
R10: dffffc0000000000 R11: fffffbfff1cfa211 R12: 1ffff92000038f7c
R13: 1ffff92000038f84 R14: 001fffffffc00001 R15: ffff8880b8738770
FS:  0000000000000000(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 000000000e736000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 vmstat_cpu_online+0xbb/0xe0 mm/vmstat.c:2151
 cpuhp_invoke_callback+0x48d/0x830 kernel/cpu.c:194
 cpuhp_thread_fun+0x41c/0x810 kernel/cpu.c:1102
 smpboot_thread_fn+0x544/0xa30 kernel/smpboot.c:164
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
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


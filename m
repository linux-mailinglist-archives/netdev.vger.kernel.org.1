Return-Path: <netdev+bounces-151835-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85BD89F1322
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 18:01:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40D40282D3A
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 17:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4CEA1E32DD;
	Fri, 13 Dec 2024 17:01:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5251DF27F
	for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 17:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734109284; cv=none; b=EJP1apul8ijOW7Bl6WBfdZ4KYnpXc/v0vN/5CGw0wCc5SqEM+NYal2ju4LDtUCKeHQMikL8uxmLPxgjXqn+H15sIXvcI510Cpvr7TehJErYNXo3cOk9KamEdVUn8OzYkqOI3BBeDZbAxfvk5m892hwIOYCcpHldLaLsymKZjUFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734109284; c=relaxed/simple;
	bh=fNwFmU1ZYU6DaBZWgYShnkL+bIx3IGrt3U2exDbVY3A=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=k90OwfihPw4rOeNwn7Y0ybt6kxXVa/i8nVehBQi2MAVo2KplbwVZbNvg3JKzF/KueYt+w/ddcr2C2YPF9NQ0mqa8dKtFwSkJlugbylMYm4nNigXKmlbH/D8pdL+hOZWz5wbH196Qs8ecatQEAr1OPqTI7B560ErQl4fIDQuHaaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3a7de3ab182so39463285ab.1
        for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 09:01:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734109282; x=1734714082;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fN9g4fRBz0Uh1rTTg1D0Tz/5aeWNLSu6/EAgDIbDulY=;
        b=BcSD0XtQgpJt+8/AEsAUVNp3/oD4qx/kam1p/m2zaLvhS/ZAX6WNAvwS7PrnePKTKn
         p10wIRxXTgx/7rMID1Wff4EGM26rUhBgWRR+VbM0HovVBfP4SzxM14zpUFQ2h5Ig7YfV
         eEG+NVv+VtnhfO8fuxdEakUvrdqBd436zKDKJcP93u9UA9O8uGhHSDcRRAepg3a0/cW/
         iLGNiRcePmvh0oaJIhz21jngilLYvnn4nYAtFSzezQ2bV0KK4EM0332SICu6m+dIn/bi
         JYlf2lvXdGhuRvcHPOLfbht4rrp4+V8eQ3MxAZhOoSrgZyBZfOps13Yq/Gql2e8X7FnW
         bLPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVrO+1pOgePwPndOrHYoFw/GxaQbm3fzO8N+j3p6He/Qk745R6M+FHDqkPQ+kusxQv7yCtiTU8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6C87griTr24bLd2aoGbC6AX+yMWL3qwY/+1zE0U+GbUqniMiC
	0TsP4SUbBjlQUtmZgNA1vDT29fwl2CnsmGrA6bkl8+/DbvkfVBHqlXs9slUQbHIq88SZM267cw9
	XnAR7whRCKVpwMd08+Y7JPYqRb6RIlH4bEO2ydSmxVX73Ij6be49yJGA=
X-Google-Smtp-Source: AGHT+IFh3Ujpdz/Pj0jfc1O1PKOj7cdUoxypxLOFYxnauzwtRpeP0DVdVQpuH4DNE+rttuCzO7lxzwI8Zx4jl5fsXYoxRh2HRCB7
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:16c8:b0:3a7:81a4:a557 with SMTP id
 e9e14a558f8ab-3affa1caeabmr42862375ab.24.1734109282064; Fri, 13 Dec 2024
 09:01:22 -0800 (PST)
Date: Fri, 13 Dec 2024 09:01:22 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <675c6862.050a0220.37aaf.00b1.GAE@google.com>
Subject: [syzbot] [net?] WARNING in nsim_dev_health_break_write
From: syzbot <syzbot+ea40e4294e58b0292f74@syzkaller.appspotmail.com>
To: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    150b567e0d57 Merge tag 'net-6.13-rc3' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14edcd44580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=99a5586995ec03b2
dashboard link: https://syzkaller.appspot.com/bug?extid=ea40e4294e58b0292f74
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=173d9be8580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17421cdf980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/571ae574df22/disk-150b567e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/5a2f7a8cf4f9/vmlinux-150b567e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4a8c47c8652b/bzImage-150b567e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ea40e4294e58b0292f74@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 5863 at mm/page_alloc.c:4727 __alloc_pages_noprof+0xeff/0x25b0 mm/page_alloc.c:4727
Modules linked in:
CPU: 0 UID: 0 PID: 5863 Comm: syz-executor347 Not tainted 6.13.0-rc2-syzkaller-00130-g150b567e0d57 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/25/2024
RIP: 0010:__alloc_pages_noprof+0xeff/0x25b0 mm/page_alloc.c:4727
Code: 24 2c 00 00 00 00 89 cd 0f 84 8b f9 ff ff 8b 34 24 48 89 da 8b 7c 24 08 e8 0e b3 fe ff e9 69 f9 ff ff c6 05 e1 44 16 0e 01 90 <0f> 0b 90 31 db e9 9f f3 ff ff 89 14 24 e8 9f a2 0c 00 8b 14 24 e9
RSP: 0018:ffffc90003e1f938 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000013 RDI: 0000000000040cc0
RBP: 0000000000000000 R08: 0000000000000007 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000013
R13: 0000000000040cc0 R14: 1ffff920007c3f3b R15: 00000000ffffffff
FS:  0000555585a3f380(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000200000c0 CR3: 00000000293fe000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __alloc_pages_node_noprof include/linux/gfp.h:269 [inline]
 alloc_pages_node_noprof include/linux/gfp.h:296 [inline]
 ___kmalloc_large_node+0x84/0x1b0 mm/slub.c:4228
 __kmalloc_large_node_noprof+0x1c/0x70 mm/slub.c:4255
 __do_kmalloc_node mm/slub.c:4271 [inline]
 __kmalloc_node_track_caller_noprof.cold+0x5/0x5f mm/slub.c:4302
 memdup_user_nul+0x2b/0x110 mm/util.c:305
 nsim_dev_health_break_write+0x9a/0x1e0 drivers/net/netdevsim/health.c:152
 full_proxy_write+0xfb/0x1b0 fs/debugfs/file.c:356
 vfs_write+0x24c/0x1150 fs/read_write.c:677
 ksys_write+0x12b/0x250 fs/read_write.c:731
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f199a1a5959
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 01 1a 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffdd157ce88 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f199a1a5959
RDX: 00000000fffffdef RSI: 0000000000000000 RDI: 0000000000000003
RBP: 00000000000f4240 R08: 0000000000000001 R09: 0000000000000001
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffdd157cee0
R13: 00007f199a1f23fe R14: 0000000000000003 R15: 00007ffdd157cec0
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


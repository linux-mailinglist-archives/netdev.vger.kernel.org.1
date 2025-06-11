Return-Path: <netdev+bounces-196568-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B94BAD55B2
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 14:36:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29B9B7ACAFC
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 12:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E488B281358;
	Wed, 11 Jun 2025 12:36:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41DAF27FD7E
	for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 12:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749645398; cv=none; b=gDyxheBalTTCBbnI5i6ts3smEDtd8pFXO3cPeeunZlZvUhSA70sDd3CXdNwOHIHrJqubqbfd7dmmvADUyWWlhDYWh5eLn57vfA1bIpNZC6TFKvmP7lKr7y899Kw/mEXePhz4g924VT/I0hdZ+VcC3B/4k+S0qZmDcSkH71K/8sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749645398; c=relaxed/simple;
	bh=uCvKZDotiP9ZjEzoiagEp86OqFBjkyOM3QpgLpJB/5M=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=RYKwp+eviYDION/OQufjaLudToMzucBAPRCLlhbyq5lbz7uQxze1QRPHGW0RK78hO+gx+g958xT9VdTesvItnSQdzorb9XH53mtlRju146YEtDyk6+p/lemLM+pH1OOA7QyK/eD8+MofxxD+331wNoYor3UFBIFR7bA9GF1pEDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3ddb4a92e80so85553945ab.3
        for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 05:36:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749645396; x=1750250196;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vng/YzV4Bzb6RRDIX+KXOBf9o2CxIKJMdOrtad0eo1E=;
        b=MrYgWZAqCSb2TmPSQK490avWZ3dF3vzobRZQ7h4kkCXvg/Q2NvKRNT71Gm5M8qALHd
         vA87U6Kj7Sc6hFU0ze6oVr7uRjNuvIV4QVulVvu5BwKI8ouUwBCosySp43U0BFZ0u5G3
         N0oQ83KUR4m0uM5Ck1ThlRQ8k828nvyUoCq00ztLI3vElIpC7xhd5k7PRdlghIWl6V8q
         HveWWynJYK39JrGxxOaE2E3M7dux9qtAo4X1gs47pnZQvQJjO3XEJAR2kS/LFUhczPjS
         6oPFFqqM5mHEXIx61A899zCH61jKfxnWn/R5CvI9pmF8ch8LwMKWdQ/ZU/hjxjzOlDug
         WmPA==
X-Forwarded-Encrypted: i=1; AJvYcCUAgmmKa5shjABEbuX8+YnQS7ex8Jx3LCvCk6qOV/iaFK8/biLLSrVxiYggHL/ZN0MDmvQevQs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOA29m1iPx0rNTQYIa+tU3opcbatehCEd/EhszfWKt47bU9HmY
	umRiwa6FJUxbISyUHVhhhwMZM4rsUBs6UmTZXfv2RLI5af/n3DZPUDmHQOmZb9OCdhTk4XWa6vg
	wQ9hXbSn5xQUE/NGiZlqyX/IuQOd5qdgcXX9qfcYDPlVV5JaWDEFsRh0vjfY=
X-Google-Smtp-Source: AGHT+IEbaV9OobI4y3/HlQ3UpH4KVgxxud1pe3uzFkgBOj6OhGhqJCvoimSBn3WgN3hJwve+Y8P3FGFf+FRQvXicv53Nz12B7jts
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fe5:b0:3dd:b762:ed1b with SMTP id
 e9e14a558f8ab-3ddf42f060fmr33724955ab.16.1749645396357; Wed, 11 Jun 2025
 05:36:36 -0700 (PDT)
Date: Wed, 11 Jun 2025 05:36:36 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68497854.050a0220.33aa0e.036c.GAE@google.com>
Subject: [syzbot] [wpan?] KMSAN: uninit-value in ieee802154_max_payload
From: syzbot <syzbot+fe68c78fbbd3c0ad70ee@syzkaller.appspotmail.com>
To: alex.aring@gmail.com, davem@davemloft.net, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	linux-wpan@vger.kernel.org, miquel.raynal@bootlin.com, netdev@vger.kernel.org, 
	pabeni@redhat.com, stefan@datenfreihafen.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    5b032cac6225 Merge tag 'ubifs-for-linus-6.16-rc1' of git:/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14d0820c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=529cf323140e1748
dashboard link: https://syzkaller.appspot.com/bug?extid=fe68c78fbbd3c0ad70ee
compiler:       Debian clang version 20.1.6 (++20250514063057+1e4d39e07757-1~exp1~20250514183223.118), Debian LLD 20.1.6

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/2e197ad38b02/disk-5b032cac.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f05af0a6e9f6/vmlinux-5b032cac.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d7c0456f7931/bzImage-5b032cac.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+fe68c78fbbd3c0ad70ee@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in ieee802154_max_payload+0x399/0x3c0 net/ieee802154/header_ops.c:372
 ieee802154_max_payload+0x399/0x3c0 net/ieee802154/header_ops.c:372
 ieee802154_header_create+0x99b/0xb90 net/mac802154/iface.c:403
 wpan_dev_hard_header include/net/cfg802154.h:525 [inline]
 dgram_sendmsg+0xb3d/0x16d0 net/ieee802154/socket.c:677
 ieee802154_sock_sendmsg+0x92/0xd0 net/ieee802154/socket.c:96
 sock_sendmsg_nosec net/socket.c:712 [inline]
 __sock_sendmsg+0x330/0x3d0 net/socket.c:727
 ____sys_sendmsg+0x7e0/0xd80 net/socket.c:2566
 ___sys_sendmsg+0x271/0x3b0 net/socket.c:2620
 __sys_sendmsg net/socket.c:2652 [inline]
 __do_sys_sendmsg net/socket.c:2657 [inline]
 __se_sys_sendmsg net/socket.c:2655 [inline]
 __x64_sys_sendmsg+0x211/0x3e0 net/socket.c:2655
 x64_sys_call+0x32fb/0x3db0 arch/x86/include/generated/asm/syscalls_64.h:47
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xd9/0x210 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Local variable hdr created at:
 ieee802154_header_create+0x4e/0xb90 net/mac802154/iface.c:360
 wpan_dev_hard_header include/net/cfg802154.h:525 [inline]
 dgram_sendmsg+0xb3d/0x16d0 net/ieee802154/socket.c:677

CPU: 1 UID: 0 PID: 17215 Comm: syz.9.2647 Not tainted 6.15.0-syzkaller-13659-g5b032cac6225 #0 PREEMPT(undef) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
=====================================================


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


Return-Path: <netdev+bounces-218535-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AC08B3D136
	for <lists+netdev@lfdr.de>; Sun, 31 Aug 2025 09:02:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E0F37B0D2B
	for <lists+netdev@lfdr.de>; Sun, 31 Aug 2025 07:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF58E20E011;
	Sun, 31 Aug 2025 07:02:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3857535961
	for <netdev@vger.kernel.org>; Sun, 31 Aug 2025 07:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756623755; cv=none; b=KRugu/Bv+tIStplJk/Xc9/CaaL803AMSZPZGBmFlegNi4Gr3dgH9KuRiheHUa+eKK2lmLi3kzeAdgIhYQbW5iWwoL/vEP2Msff6AGNGQG9kurPxWsAM+TJcOrzHAiKnYJQVoE7Y+KPW8m/txskl93MVCvSupiyp5qUhj4gvyYpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756623755; c=relaxed/simple;
	bh=fuj7bIbF5XRSrJ6arXeQkMNv6g/5H7NVSpXSJgcIJBw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=uPwhDQDI0QPYzqv88F/7n5jsPuOfct5eXx3rXqXzZqbHGtqTdMA2nlHqKEhbk5N96pcAc3Jw7IHsCt6VzRKyMNBLUPRqIy/DsUvew5JTF94/cf7Q5VvFvUdKoimoDNzNkjW5jaBAJceca2Jgy2eqKfEwqyeFuO1ssRhmfEmnQ/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3f321907716so24037035ab.0
        for <netdev@vger.kernel.org>; Sun, 31 Aug 2025 00:02:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756623753; x=1757228553;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qNmc2ehAlRajGg7YcNkhUQotKYp3zQRpdUAzAU07HL8=;
        b=fSa9GR6FaeWpGoiRyAIKSRCUQgorZcM+TUuc97xfFZL0+0jsA3EWYFWMyyKSW7/+nS
         04QbdKu3orYNLUTXDuxF5CFqzKajId16hXL1o/M4Lwc4iS2CxKT4ic0cL+mSTC+aP1BX
         SK/wk/BiK4MVNp8wMHsLaG4YY3Z94jRHXPYtln8CeG3XR+ZCeg21OmuYb8DToIw9PkHY
         AYXbCBLo+HR9vCsM1kyQ/kbb7baujtUZoecE4D5F7ytqfAyXxyzC/wFcs1hYZlr1XJhw
         C+/ncXrnUOgbsjxpUNfo5j5YgG1Of22eNoBg2I9PYNRyAj2F7ZZlEKh+VhhVk84dZAVg
         T8XQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3DeU0FNgsr6W3NwtR5Vi+NfMh13hr8w3A6yV33zZGKBWSUA0t9IGlazm2oUQUE1C1vXrV1SQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/NYTQ0xFFtSHv6X0TUOe4/F+rqJdadaR7Ez9QvgcCmYBCMIHo
	v6aYoST4LBYlBieIQmTCrWqr9NmbTZC57Idp9t1rNdyu7U7yZM6i1OuIrWa1LVjYWxCeLnjt/pu
	iFKmG6KuseO9WuN29rgpUqnt6ji5T9oHYJ5QZpX5WsR+lOEmz7fo3XDIhlxQ=
X-Google-Smtp-Source: AGHT+IEZE+H+G9noA9xyVzEHtCh7P/JUH2K7q82/sgqLq8Jq68ZHjgm5D42voEDlCXMkrsIMJMYeRGsNoCTGC0uxXL52utn76SdI
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2285:b0:3f3:1321:1ed2 with SMTP id
 e9e14a558f8ab-3f400c48127mr81862905ab.8.1756623753397; Sun, 31 Aug 2025
 00:02:33 -0700 (PDT)
Date: Sun, 31 Aug 2025 00:02:33 -0700
In-Reply-To: <689e6bba.050a0220.e29e5.0003.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68b3f389.a00a0220.1337b0.002e.GAE@google.com>
Subject: Re: [syzbot] [net?] [nfc?] WARNING in nfc_rfkill_set_block
From: syzbot <syzbot+535bbe83dfc3ae8d4be3@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, hdanton@sina.com, 
	horms@kernel.org, krzk@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	penguin-kernel@i-love.sakura.ne.jp, syzkaller-bugs@googlegroups.com, 
	tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    c8bc81a52d5a Merge tag 'arm64-fixes' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1508ce34580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bd9738e00c1bbfb4
dashboard link: https://syzkaller.appspot.com/bug?extid=535bbe83dfc3ae8d4be3
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11019a62580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1308ce34580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e617000fa273/disk-c8bc81a5.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7ae3a3f4924d/vmlinux-c8bc81a5.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d68d297e1f87/bzImage-c8bc81a5.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+535bbe83dfc3ae8d4be3@syzkaller.appspotmail.com

Bluetooth: hci0: Opcode 0x0c1a failed: -110
Bluetooth: hci0: Error when powering off device on rfkill (-110)
------------[ cut here ]------------
rtmutex deadlock detected
WARNING: CPU: 0 PID: 6084 at kernel/locking/rtmutex.c:1674 rt_mutex_handle_deadlock+0x28/0xb0 kernel/locking/rtmutex.c:1674
Modules linked in:
CPU: 0 UID: 0 PID: 6084 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
RIP: 0010:rt_mutex_handle_deadlock+0x28/0xb0 kernel/locking/rtmutex.c:1674
Code: 90 90 41 57 41 56 41 55 41 54 53 83 ff dd 0f 85 8c 00 00 00 48 89 f7 e8 c6 2c 01 00 90 48 c7 c7 80 08 0b 8b e8 79 78 8a f6 90 <0f> 0b 90 90 4c 8d 3d 00 00 00 00 65 48 8b 1c 25 08 e0 f5 91 4c 8d
RSP: 0018:ffffc90003a8f950 EFLAGS: 00010246
RAX: 4a17b3cdcfcd8c00 RBX: ffffc90003a8f9e0 RCX: ffff888034b23b80
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc90003a8fb00 R08: 0000000000000000 R09: 0000000000000000
R10: dffffc0000000000 R11: ffffed1017104863 R12: 1ffff92000751f38
R13: ffffffff8af8b119 R14: ffff88802b77f098 R15: dffffc0000000000
FS:  00007f918c68e6c0(0000) GS:ffff8881268c2000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000558db6b05168 CR3: 0000000040f42000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 __rt_mutex_slowlock kernel/locking/rtmutex.c:1734 [inline]
 __rt_mutex_slowlock_locked kernel/locking/rtmutex.c:1760 [inline]
 rt_mutex_slowlock+0x692/0x6e0 kernel/locking/rtmutex.c:1800
 __rt_mutex_lock kernel/locking/rtmutex.c:1815 [inline]
 __mutex_lock_common kernel/locking/rtmutex_api.c:536 [inline]
 mutex_lock_nested+0x16a/0x1d0 kernel/locking/rtmutex_api.c:547
 device_lock include/linux/device.h:911 [inline]
 nfc_dev_down net/nfc/core.c:143 [inline]
 nfc_rfkill_set_block+0x50/0x2e0 net/nfc/core.c:179
 rfkill_set_block+0x1e5/0x450 net/rfkill/core.c:346
 rfkill_fop_write+0x44e/0x580 net/rfkill/core.c:1301
 vfs_write+0x284/0xb40 fs/read_write.c:684
 ksys_write+0x14b/0x260 fs/read_write.c:738
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f918d01ebe9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f918c68e038 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f918d255fa0 RCX: 00007f918d01ebe9
RDX: 0000000000000008 RSI: 0000200000000080 RDI: 0000000000000004
RBP: 00007f918d0a1e19 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f918d256038 R14: 00007f918d255fa0 R15: 00007ffcb32fa318
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.


Return-Path: <netdev+bounces-210731-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FED7B14966
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 09:51:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4BDE18A0985
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 07:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D948F26A0E7;
	Tue, 29 Jul 2025 07:51:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3247826A0BF
	for <netdev@vger.kernel.org>; Tue, 29 Jul 2025 07:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753775496; cv=none; b=tqNeTkfnzR7UqM+d14GUbAEbjtJ1QCRinVhTvoOOgLqfxhZkphvXlrKrtoAFodcuCGARpNxL6m/12zxFyWDjs2ZcvSLP75eELbs8bVfwHCJ1MMRcw/2pNIjesLnHtrIQnE5M1ElJVIY/5Rl4G2zOlCsJd9HaVYwzkZVTTLxtUzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753775496; c=relaxed/simple;
	bh=jcxsM0Frh3Bu1OpIClqfqFLeWmFMomNBaKrHAHVKiRA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=pUF4xYobLklNd+7d4blM7/hSmNvKENZrtgPmXGnnZ1IONLSjhtjDBTxzVkse0CC5blFt+LugBOQ7LjsuHA147CSk73PD4vO+7v9lfNNfzuYKFqHfZsSVIC75Blv7FDWAG2rX+D8yNm0DxxW6wa2suItpLoewGqqB/mSRhwv9XGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3e3f0a3f62aso2002905ab.2
        for <netdev@vger.kernel.org>; Tue, 29 Jul 2025 00:51:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753775494; x=1754380294;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nwiZttZ/udedfdRnutqiHE6++E8ELPKNs9T/xXTO6LQ=;
        b=LxKpiTVH/s+iPhPr54ATBD5VkC6oOIZ+/GZiP3GDLpKLHc7bOr7vcTF34GwAWN5tSQ
         tQ6+s2rTi2EhjgMUOTBvp/wAqTLirwl4Q3wsIqrKemiHkersrNPL6y9oapf03/mP2vOz
         3B4s6rdxrGmxAULkNPbZvWWBjRZZixndAXvP69XrdU2gT3WCh2gLVNDW5TwfkbKpL77V
         nCe79SKLP+7tU1QSApdjv2ZMbGwVj/C2QkmJPDxkIQ/2L2X9JgqzhgPhRWaYlwPZDUpg
         32+JKv20/mggd0/sVQzaNLbnScGR6ZEBZNgH25VgMP2E5Y1BUCbLPCd2lNBD+5hSwGRz
         6oqQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+WAii3MOkRAe81rolGm8oBbNvk7L56LoLev+vY5Lp+vUh9Vr1Fsc0ApDQ+9rY+txQN3mONzM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTrIXneQi4DYTZOeiAARg0bRioejRr5CYx5wpOBoW4+FgEsdFn
	XJkcxI1HR9UA+9RXdMizZhnDBTdV+WXnaIasWoahcx6QLD+lTNuqTQoEfrAfqdWpC+djBqrCQfh
	79vU5c0m6agDvrrhCCJwfCNfEYNe9XWC1i6mFf7aLebWYuqW+0l9stnZfnwg=
X-Google-Smtp-Source: AGHT+IFvSSfKpB1q9X+Ujg9aloTRo5257ymL4mV23VlrgioSXaYg5es+1vpGB7rHN1kHE0qJ2ukqwaigKEw8BM3gEYQI9XwyAY6x
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:260b:b0:3e3:d246:55fb with SMTP id
 e9e14a558f8ab-3e3d2465d5cmr194963115ab.15.1753775494338; Tue, 29 Jul 2025
 00:51:34 -0700 (PDT)
Date: Tue, 29 Jul 2025 00:51:34 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68887d86.a00a0220.b12ec.00cd.GAE@google.com>
Subject: [syzbot] [net?] KMSAN: uninit-value in pptp_xmit (3)
From: syzbot <syzbot+afad90ffc8645324afe5@syzkaller.appspotmail.com>
To: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    038d61fd6422 Linux 6.16
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=139e9034580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bc98b07dbc3d5a34
dashboard link: https://syzkaller.appspot.com/bug?extid=afad90ffc8645324afe5
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=163b84a2580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11a594a2580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/58944a2f9bd3/disk-038d61fd.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c9a849a27d33/vmlinux-038d61fd.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0de16772849a/bzImage-038d61fd.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+afad90ffc8645324afe5@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in pptp_xmit+0xc34/0x2720 drivers/net/ppp/pptp.c:193
 pptp_xmit+0xc34/0x2720 drivers/net/ppp/pptp.c:193
 ppp_channel_bridge_input drivers/net/ppp/ppp_generic.c:2290 [inline]
 ppp_input+0x1d6/0xe60 drivers/net/ppp/ppp_generic.c:2314
 pppoe_rcv_core+0x1e8/0x760 drivers/net/ppp/pppoe.c:379
 sk_backlog_rcv+0x142/0x420 include/net/sock.h:1148
 __release_sock+0x1d3/0x330 net/core/sock.c:3213
 release_sock+0x6b/0x270 net/core/sock.c:3767
 pppoe_sendmsg+0x15d/0xcb0 drivers/net/ppp/pppoe.c:904
 sock_sendmsg_nosec net/socket.c:712 [inline]
 __sock_sendmsg+0x330/0x3d0 net/socket.c:727
 ____sys_sendmsg+0x893/0xd80 net/socket.c:2566
 ___sys_sendmsg+0x271/0x3b0 net/socket.c:2620
 __sys_sendmmsg+0x2d9/0x7c0 net/socket.c:2709
 __do_sys_sendmmsg net/socket.c:2736 [inline]
 __se_sys_sendmmsg net/socket.c:2733 [inline]
 __x64_sys_sendmmsg+0xc6/0x150 net/socket.c:2733
 x64_sys_call+0x3ce7/0x3db0 arch/x86/include/generated/asm/syscalls_64.h:308
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xd9/0x210 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was created at:
 slab_post_alloc_hook mm/slub.c:4154 [inline]
 slab_alloc_node mm/slub.c:4197 [inline]
 __do_kmalloc_node mm/slub.c:4327 [inline]
 __kmalloc_node_track_caller_noprof+0x96d/0x12f0 mm/slub.c:4347
 kmalloc_reserve+0x22f/0x4b0 net/core/skbuff.c:601
 pskb_expand_head+0x1fc/0x1610 net/core/skbuff.c:2241
 skb_realloc_headroom+0x152/0x2d0 net/core/skbuff.c:2321
 pptp_xmit+0x9d4/0x2720 drivers/net/ppp/pptp.c:181
 ppp_channel_bridge_input drivers/net/ppp/ppp_generic.c:2290 [inline]
 ppp_input+0x1d6/0xe60 drivers/net/ppp/ppp_generic.c:2314
 pppoe_rcv_core+0x1e8/0x760 drivers/net/ppp/pppoe.c:379
 sk_backlog_rcv+0x142/0x420 include/net/sock.h:1148
 __release_sock+0x1d3/0x330 net/core/sock.c:3213
 release_sock+0x6b/0x270 net/core/sock.c:3767
 pppoe_sendmsg+0x15d/0xcb0 drivers/net/ppp/pppoe.c:904
 sock_sendmsg_nosec net/socket.c:712 [inline]
 __sock_sendmsg+0x330/0x3d0 net/socket.c:727
 ____sys_sendmsg+0x893/0xd80 net/socket.c:2566
 ___sys_sendmsg+0x271/0x3b0 net/socket.c:2620
 __sys_sendmmsg+0x2d9/0x7c0 net/socket.c:2709
 __do_sys_sendmmsg net/socket.c:2736 [inline]
 __se_sys_sendmmsg net/socket.c:2733 [inline]
 __x64_sys_sendmmsg+0xc6/0x150 net/socket.c:2733
 x64_sys_call+0x3ce7/0x3db0 arch/x86/include/generated/asm/syscalls_64.h:308
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xd9/0x210 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

CPU: 0 UID: 0 PID: 5830 Comm: syz-executor110 Not tainted 6.16.0-syzkaller #0 PREEMPT(none) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
=====================================================


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


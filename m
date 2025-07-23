Return-Path: <netdev+bounces-209361-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AD9AB0F5B2
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 16:46:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F09A1176D07
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 14:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAE052F2C5E;
	Wed, 23 Jul 2025 14:45:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D51C2EAD06
	for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 14:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753281938; cv=none; b=e1lqEF9VgA17uS5xZPNwPA9yZh6ZFjqyIYadcpGwox98h1PBJ+fafymnjprMx9EpmYFngosifscYIqNNJW13PrHanO85y8JgTnqwITTIQ3njEFqVCG3Cygo+wH7Sw4npJQ9wQeZPjHjYO7jqPOwmv+bZmuhXte7bGp0Ju1KHnpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753281938; c=relaxed/simple;
	bh=ytx5Wx3EuwngFK3Jxlb30QKnQtjx/IQhzvwLdRiJ5ZI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Fbsi75m8cxCK1+i0cDFCHQ3abhHD/g3icBY5q+OHbN/q+ZdEc2FVOQ0A54iwEqmjxleI1an0rzfxfM0LuNwq8OR1y2l57VUFa5AP4AgmYhR27DnGrV6b8EnYUDhrmBkAzEcK1gp4FEMZ5FjO7lh74xhnNtFfrUOZvlQ7KAaJ9JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-87c30329a56so777448939f.1
        for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 07:45:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753281935; x=1753886735;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6J0xr1uO+ygDWs1lqz1tpCMN0HmdwzS8B6enhcpsCHw=;
        b=Dg0ntWkZpB6nn8GYqlctT9bE9cULJKVKPt0hnAA8t3MaA0F86FdBviFXvcWo4iBhtR
         ENWRZYKzBz3peA3hK7C0RobwRi2mY0fd9GJyPl+ILGx0lEGOxuhD/44rog5zzGv4aoUY
         V6ttFwGTsHhoCk0QsIUqjq/ws1k1ik0R5CVdnoOAK7sBv91IrdYxyDKr1xjwpf1S4gPH
         hnEKTip7r5WvvJ2eKtwwxXSabNZ5nledmQfFJcZ/bIP+IGiZs2Yn4j8wb6fW7mqkPxvJ
         /skfof6m9SKMWSBYF+AF4DGsqkqVgV2Enio2dLyKf/7eajBTJjisVsP8fUy1ZbcIciQQ
         Kedg==
X-Forwarded-Encrypted: i=1; AJvYcCU2gRgRaWy9pZG0UJyz8CMIAmcNX9xlLTlvioDDCndzoC0h0Mo/rQvep25tUP79JduTiGvpu38=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxN6iThi8+6Kg1eSyAQ/9L7SzHEufABGrEgwmvNw+7RyVbki7W
	Mgbp0WLCcnbku5o/iH0iE9BXVveqgdE5OzVKoF1KTqjKh4wYctqhK28e7MpBRCsmK4zmDpDFH4u
	pZX5JRhsKRSGbKyBOTsOr9OsI9VWKPDJtYIRXgr0SobIXCNQDjkoqO6cpLI4=
X-Google-Smtp-Source: AGHT+IHEO6vxWGYXkHxVFE0xnGLbD9LNiGLAjgXFVnLZRGGBzHfujx3JuOmvoNgTIWxWpn48UMjMmbRlei4fFNbsiiQlSbgVau1H
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:e55:b0:879:c608:d1d5 with SMTP id
 ca18e2360f4ac-87c6506e00bmr541701939f.14.1753281935005; Wed, 23 Jul 2025
 07:45:35 -0700 (PDT)
Date: Wed, 23 Jul 2025 07:45:34 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6880f58e.050a0220.248954.0001.GAE@google.com>
Subject: [syzbot] [tipc?] KMSAN: uninit-value in tipc_rcv (2)
From: syzbot <syzbot+9a4fbb77c9d4aacd3388@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	jmaloy@redhat.com, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com, 
	tipc-discussion@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    4871b7cb27f4 Merge tag 'v6.16-rc6-smb3-client-fixes' of gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15bbe38c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5227c65742122bdd
dashboard link: https://syzkaller.appspot.com/bug?extid=9a4fbb77c9d4aacd3388
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e2e34a7999ba/disk-4871b7cb.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/834fdc8dbc07/vmlinux-4871b7cb.xz
kernel image: https://storage.googleapis.com/syzbot-assets/617fadfb9a8e/bzImage-4871b7cb.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9a4fbb77c9d4aacd3388@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in tipc_rcv+0x17fa/0x1ea0 net/tipc/node.c:2132
 tipc_rcv+0x17fa/0x1ea0 net/tipc/node.c:2132
 tipc_l2_rcv_msg+0x213/0x320 net/tipc/bearer.c:668
 __netif_receive_skb_list_ptype net/core/dev.c:6025 [inline]
 __netif_receive_skb_list_core+0x133b/0x16b0 net/core/dev.c:6067
 __netif_receive_skb_list net/core/dev.c:6119 [inline]
 netif_receive_skb_list_internal+0xee7/0x1530 net/core/dev.c:6210
 gro_normal_list include/net/gro.h:532 [inline]
 napi_complete_done+0x3fb/0x7d0 net/core/dev.c:6580
 napi_complete include/linux/netdevice.h:588 [inline]
 tun_get_user+0x4ac4/0x6b40 drivers/net/tun.c:1909
 tun_chr_write_iter+0x3e9/0x5c0 drivers/net/tun.c:1984
 do_iter_readv_writev+0x94a/0xba0 fs/read_write.c:-1
 vfs_writev+0x52a/0x1500 fs/read_write.c:1057
 do_writev+0x1b5/0x580 fs/read_write.c:1103
 __do_sys_writev fs/read_write.c:1171 [inline]
 __se_sys_writev fs/read_write.c:1168 [inline]
 __ia32_sys_writev+0x9c/0xf0 fs/read_write.c:1168
 ia32_sys_call+0x3f2a/0x42c0 arch/x86/include/generated/asm/syscalls_32.h:147
 do_syscall_32_irqs_on arch/x86/entry/syscall_32.c:83 [inline]
 __do_fast_syscall_32+0xb0/0x150 arch/x86/entry/syscall_32.c:306
 do_fast_syscall_32+0x38/0x80 arch/x86/entry/syscall_32.c:331
 do_SYSENTER_32+0x1f/0x30 arch/x86/entry/syscall_32.c:369
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e

Uninit was created at:
 slab_post_alloc_hook mm/slub.c:4154 [inline]
 slab_alloc_node mm/slub.c:4197 [inline]
 kmem_cache_alloc_node_noprof+0x818/0xf00 mm/slub.c:4249
 kmalloc_reserve+0x13c/0x4b0 net/core/skbuff.c:579
 __alloc_skb+0x347/0x7d0 net/core/skbuff.c:670
 napi_alloc_skb+0xc1/0x740 net/core/skbuff.c:812
 napi_get_frags+0xab/0x250 net/core/gro.c:673
 tun_napi_alloc_frags drivers/net/tun.c:1404 [inline]
 tun_get_user+0x1246/0x6b40 drivers/net/tun.c:1772
 tun_chr_write_iter+0x3e9/0x5c0 drivers/net/tun.c:1984
 do_iter_readv_writev+0x94a/0xba0 fs/read_write.c:-1
 vfs_writev+0x52a/0x1500 fs/read_write.c:1057
 do_writev+0x1b5/0x580 fs/read_write.c:1103
 __do_sys_writev fs/read_write.c:1171 [inline]
 __se_sys_writev fs/read_write.c:1168 [inline]
 __ia32_sys_writev+0x9c/0xf0 fs/read_write.c:1168
 ia32_sys_call+0x3f2a/0x42c0 arch/x86/include/generated/asm/syscalls_32.h:147
 do_syscall_32_irqs_on arch/x86/entry/syscall_32.c:83 [inline]
 __do_fast_syscall_32+0xb0/0x150 arch/x86/entry/syscall_32.c:306
 do_fast_syscall_32+0x38/0x80 arch/x86/entry/syscall_32.c:331
 do_SYSENTER_32+0x1f/0x30 arch/x86/entry/syscall_32.c:369
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e

CPU: 0 UID: 0 PID: 15202 Comm: syz.3.3410 Not tainted 6.16.0-rc6-syzkaller-00253-g4871b7cb27f4 #0 PREEMPT(none) 
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


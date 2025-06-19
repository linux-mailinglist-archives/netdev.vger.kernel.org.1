Return-Path: <netdev+bounces-199616-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5429AE0FC0
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 00:51:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C23D3A6DFD
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 22:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4995425E815;
	Thu, 19 Jun 2025 22:51:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8137D25DCE9
	for <netdev@vger.kernel.org>; Thu, 19 Jun 2025 22:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750373487; cv=none; b=i6P/BCFgXeL3uikH6qcr0As/xgf63vabVxECWPV7D0ZMR37ehdgxOPQZojL7QzetjH6BKNXZMpZhEtj68jrFPr1/Fp7PiQKyZSfIcTLuIw3urFGKGJwfiNKVWYogDAsaznN30tTYpZnioY0/tzYlDFGBiQLWjMxUD19J5qLwm0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750373487; c=relaxed/simple;
	bh=E231dlPcsDXUlL570mR/SLAGlvEL6LY7vMLW9MkkLG4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Ig29y8ok39VUTceGTeYXM1eDyi/8OopsrZvUhhBmtY8pwbpuhMqY4t37b6HePPuQmdaYdEhCYz37lsBK7ttP1i6YShHxtE+Pq+3vjs749aCrQijdfudWmAt/sm8ksi0FmwhYgkA7hFL/mONud+nL76derPVRWU4hGWqoX9feAT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-86cfff5669bso97984939f.0
        for <netdev@vger.kernel.org>; Thu, 19 Jun 2025 15:51:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750373484; x=1750978284;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gOVn2LxR/HNGrJBJymq/0+Mis38DXohgSBacevrZP2Q=;
        b=ZcH3sJmQpthZtUZFJQQYSkxfpppqzU/vwqKbyHXtunNlkYCBiKlH7+pWypdCssYZ7h
         Xf/CyO2Vys1BhQBbMyqy5JVYlBBEM0y/CHt4FfAqxQikYP7CGQ+lFKEHpSY95IozZIZO
         Qh+E045gLCd6Zmd8nc/L7keOC8ZI1iaNqM6zqjQK2STEzRaR0OMk9VvY/MMPiC2muPla
         v2FZfZBTMGwzbBBqbOLdI7MgCjZyEHBYvI8zytTQB6tbrqbbLmRRnUwX/VJczjW/hZDe
         4fZ76JJuYA9BwF/hhmoBQoWqRrSi+fHx4Oy7KZQifM6OLxoUJZ8lqbimEiumgpxx0L8y
         ArtA==
X-Forwarded-Encrypted: i=1; AJvYcCXULZ8rnbJjZB7q3TpYIJn9lp5V56wcwtjoLucC/iBeJqiMBEVmslNkzH0Lg7vXmQI7WI1Ryx4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6xmfjU4EtDAHX51axghsi3nP1XXBlhbwXuAdu4CQhqEC3bfHS
	LFCqJepqvh1DkncOzscUDC1O5u3U0Qo282taCw+qpzWMX5NChqZB51ZdFXf/KWpYVAtXSahmKhX
	CzbXkAcL7icNtkZwheLvKoJU9uUACo6WJRom1af2zUOL8ZcpT2xjDfQ8U9gg=
X-Google-Smtp-Source: AGHT+IGghGfxc+m5t2hhPceOIW0ddQGhqbTmEzZl83nGPagpzE9nxdU+a25td1PXHai6UPwQ8dpo1L6Uxmd4Z9Y8/xbEGiPHAigw
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:19cc:b0:3dd:b540:b795 with SMTP id
 e9e14a558f8ab-3de3954f063mr1873075ab.3.1750373484625; Thu, 19 Jun 2025
 15:51:24 -0700 (PDT)
Date: Thu, 19 Jun 2025 15:51:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6854946c.a00a0220.137b3.001e.GAE@google.com>
Subject: [syzbot] [net?] KMSAN: uninit-value in unix_create1
From: syzbot <syzbot+d0fba1a09f8c1e3ddda5@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, kuniyu@google.com, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    08215f5486ec Merge tag 'kbuild-fixes-v6.16' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11b765d4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=61539536677af51c
dashboard link: https://syzkaller.appspot.com/bug?extid=d0fba1a09f8c1e3ddda5
compiler:       Debian clang version 20.1.6 (++20250514063057+1e4d39e07757-1~exp1~20250514183223.118), Debian LLD 20.1.6

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/01c395d764eb/disk-08215f54.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/15fc58e6441d/vmlinux-08215f54.xz
kernel image: https://storage.googleapis.com/syzbot-assets/dbd5ac78ef83/bzImage-08215f54.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d0fba1a09f8c1e3ddda5@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in hlist_add_head include/linux/list.h:1025 [inline]
BUG: KMSAN: uninit-value in __sk_add_node include/net/sock.h:853 [inline]
BUG: KMSAN: uninit-value in sk_add_node include/net/sock.h:859 [inline]
BUG: KMSAN: uninit-value in __unix_insert_socket net/unix/af_unix.c:380 [inline]
BUG: KMSAN: uninit-value in unix_insert_unbound_socket net/unix/af_unix.c:403 [inline]
BUG: KMSAN: uninit-value in unix_create1+0x973/0xbc0 net/unix/af_unix.c:1085
 hlist_add_head include/linux/list.h:1025 [inline]
 __sk_add_node include/net/sock.h:853 [inline]
 sk_add_node include/net/sock.h:859 [inline]
 __unix_insert_socket net/unix/af_unix.c:380 [inline]
 unix_insert_unbound_socket net/unix/af_unix.c:403 [inline]
 unix_create1+0x973/0xbc0 net/unix/af_unix.c:1085
 unix_create+0x193/0x220 net/unix/af_unix.c:1127
 __sock_create+0x764/0xf60 net/socket.c:1541
 sock_create net/socket.c:1599 [inline]
 __sys_socketpair+0x329/0xe30 net/socket.c:1746
 __do_sys_socketpair net/socket.c:1799 [inline]
 __se_sys_socketpair net/socket.c:1796 [inline]
 __x64_sys_socketpair+0xc0/0x150 net/socket.c:1796
 x64_sys_call+0x2b98/0x3db0 arch/x86/include/generated/asm/syscalls_64.h:54
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xd9/0x210 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was created at:
 slab_post_alloc_hook mm/slub.c:4154 [inline]
 slab_alloc_node mm/slub.c:4197 [inline]
 __do_kmalloc_node mm/slub.c:4327 [inline]
 __kvmalloc_node_noprof+0xa36/0x1530 mm/slub.c:5015
 kvmalloc_array_node_noprof include/linux/slab.h:1065 [inline]
 unix_net_init+0x19d/0x430 net/unix/af_unix.c:3746
 ops_init+0x2b3/0x9f0 net/core/net_namespace.c:138
 __register_pernet_operations net/core/net_namespace.c:1284 [inline]
 register_pernet_operations+0x649/0xfa0 net/core/net_namespace.c:1361
 register_pernet_subsys+0x5b/0xa0 net/core/net_namespace.c:1402
 af_unix_init+0x12c/0x200 net/unix/af_unix.c:3882
 do_one_initcall+0x237/0xb60 init/main.c:1274
 do_initcall_level+0x166/0x380 init/main.c:1336
 do_initcalls+0x1b5/0x350 init/main.c:1352
 do_basic_setup+0x22/0x30 init/main.c:1371
 kernel_init_freeable+0x2fe/0x4d0 init/main.c:1584
 kernel_init+0x2f/0x5e0 init/main.c:1474
 ret_from_fork+0x1e0/0x310 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

CPU: 1 UID: 0 PID: 5445 Comm: dhcpcd Tainted: G        W           6.16.0-rc1-syzkaller-00239-g08215f5486ec #0 PREEMPT(undef) 
Tainted: [W]=WARN
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


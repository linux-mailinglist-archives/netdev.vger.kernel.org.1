Return-Path: <netdev+bounces-249550-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CE9F3D1AE5F
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 19:51:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AE0E53007691
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 18:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0951B284662;
	Tue, 13 Jan 2026 18:50:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f80.google.com (mail-oo1-f80.google.com [209.85.161.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE152FD1DB
	for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 18:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768330228; cv=none; b=RV9Y/rtyq0sYNCNaywINiiJyggIZ6WFOSWwa4nTr6zuW1pJSy4GL23c/SrNoXJT/atWI8kCj0hUHZiVz5PW/AV/sUAT/mDMsQI0y95IejxKT6fXZGOMXz2V7fADJ7C4j4HmNURb+pam3WDsKk0+QKRLteZs0MofHZCFCQ14aj/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768330228; c=relaxed/simple;
	bh=CPaZtlabZZadvDBnMvqkuiC+LcouVGPw7C1XjYBNfK8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=A/L9BIUFKEuS66Dn8KIs7n2F4NHU0jabBduFsCaC0LK9NJvqZg7CssfIi4G1UAoi3N6aukxUIdqZii2ZMRV8ipLfbgxc4jO0JYX5IlIIS9FKpzHFIKiJYIBMBVeBSd3vo+yuD1FtcLw9tBg6KSeou/TDGlW+yey3jTNlWcwudi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f80.google.com with SMTP id 006d021491bc7-65f6794a794so216489eaf.1
        for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 10:50:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768330226; x=1768935026;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lLWFX4rd56Op6Ev6w4wgVAXH9BmsMSbCEl4xvf6wcQs=;
        b=M74ZP1M/Jtpp0xBPgzU98M6G0JOQruWkBujkc+rSA3fc+tZ2ArmMS1lTBRcFBVpT46
         uj5vYxZ1E1Ptbs5pxsfNeuiLb2uy4e9HE0UsDe23pMLf2vc6loE0rViIhjtiRw1jV+oR
         I4jWk72PKrQr0z5FVqQPU6gJmF+Zk2760so4UqYH+gOL8duc4ZDJMEHiyBZYlJYW49Pr
         wd+rmWc9MWUi/7s9s7aEE/a6X+F2Tg6JeFRt6RrUXMWuoJVQp0ZhD9KIPgR2Zl9hJf/F
         XOilRBjoV/S6mspTw5KBjw4sJu3n5okilQ+O02nruxxkUYbzfEHbmrQDWwR0Mp7xxeak
         eErA==
X-Forwarded-Encrypted: i=1; AJvYcCVqTX7Qf6hbaT1FAi+bQYjOZ+1hq4HWKTUJV2cAVUr75nn6k7KC3SdFsPiliZQjsvX4hu3q/0Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlFdRxiHgFDher/3Se/j+YwfRPQxzm4hNTSmiJbbqh0CZKYSU3
	5Ak7yfWEhz6Rze7WaJXFM5PmP2hbWeFgn5fYWUaUQzVePnXjWao0CVF2l5oGwuHr9pn6lDIoeCf
	K2ZkAahtySeSv/nLZt9BIAZWZPNCUiMLHC/z2PB7S0+nyMx8qJpi+GHEMQFE=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:270:b0:660:fdef:87c7 with SMTP id
 006d021491bc7-660fdef9198mr544747eaf.41.1768330226350; Tue, 13 Jan 2026
 10:50:26 -0800 (PST)
Date: Tue, 13 Jan 2026 10:50:26 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <696693f2.a70a0220.245e30.0001.GAE@google.com>
Subject: [syzbot] [net?] memory leak in l2tp_tunnel_create
From: syzbot <syzbot+2c42ea4485b29beb0643@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    f0b9d8eb98df Merge tag 'nfsd-6.19-3' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1252c19a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d60836e327fd6756
dashboard link: https://syzkaller.appspot.com/bug?extid=2c42ea4485b29beb0643
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12741074580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15fba922580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/aad2d47ff01d/disk-f0b9d8eb.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c31e7ae85c07/vmlinux-f0b9d8eb.xz
kernel image: https://storage.googleapis.com/syzbot-assets/5525fab81561/bzImage-f0b9d8eb.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2c42ea4485b29beb0643@syzkaller.appspotmail.com

BUG: memory leak
unreferenced object 0xffff88811b68c400 (size 256):
  comm "syz.0.17", pid 6086, jiffies 4294944299
  hex dump (first 32 bytes):
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc cc18917d):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4958 [inline]
    slab_alloc_node mm/slub.c:5263 [inline]
    __kmalloc_cache_noprof+0x3b2/0x570 mm/slub.c:5771
    kmalloc_noprof include/linux/slab.h:957 [inline]
    kzalloc_noprof include/linux/slab.h:1094 [inline]
    l2tp_tunnel_create+0x55/0x130 net/l2tp/l2tp_core.c:1573
    pppol2tp_tunnel_get+0x134/0x250 net/l2tp/l2tp_ppp.c:653
    pppol2tp_connect+0x234/0x920 net/l2tp/l2tp_ppp.c:710
    __sys_connect_file+0x7a/0xb0 net/socket.c:2089
    __sys_connect+0xde/0x110 net/socket.c:2108
    __do_sys_connect net/socket.c:2114 [inline]
    __se_sys_connect net/socket.c:2111 [inline]
    __x64_sys_connect+0x1c/0x30 net/socket.c:2111
    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
    do_syscall_64+0xa4/0xf80 arch/x86/entry/syscall_64.c:94
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

BUG: memory leak
unreferenced object 0xffff88810a290200 (size 512):
  comm "syz.0.17", pid 6086, jiffies 4294944299
  hex dump (first 32 bytes):
    7d eb 04 0c 00 00 00 00 01 00 00 00 00 00 00 00  }...............
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc babb6a4f):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4958 [inline]
    slab_alloc_node mm/slub.c:5263 [inline]
    __do_kmalloc_node mm/slub.c:5656 [inline]
    __kmalloc_noprof+0x3e0/0x660 mm/slub.c:5669
    kmalloc_noprof include/linux/slab.h:961 [inline]
    kzalloc_noprof include/linux/slab.h:1094 [inline]
    l2tp_session_create+0x3a/0x3b0 net/l2tp/l2tp_core.c:1778
    pppol2tp_connect+0x48b/0x920 net/l2tp/l2tp_ppp.c:755
    __sys_connect_file+0x7a/0xb0 net/socket.c:2089
    __sys_connect+0xde/0x110 net/socket.c:2108
    __do_sys_connect net/socket.c:2114 [inline]
    __se_sys_connect net/socket.c:2111 [inline]
    __x64_sys_connect+0x1c/0x30 net/socket.c:2111
    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
    do_syscall_64+0xa4/0xf80 arch/x86/entry/syscall_64.c:94
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

BUG: memory leak
unreferenced object 0xffff88811b68c500 (size 256):
  comm "syz.0.18", pid 6087, jiffies 4294944299
  hex dump (first 32 bytes):
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc a2050c30):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4958 [inline]
    slab_alloc_node mm/slub.c:5263 [inline]
    __kmalloc_cache_noprof+0x3b2/0x570 mm/slub.c:5771
    kmalloc_noprof include/linux/slab.h:957 [inline]
    kzalloc_noprof include/linux/slab.h:1094 [inline]
    l2tp_tunnel_create+0x55/0x130 net/l2tp/l2tp_core.c:1573
    pppol2tp_tunnel_get+0x134/0x250 net/l2tp/l2tp_ppp.c:653
    pppol2tp_connect+0x234/0x920 net/l2tp/l2tp_ppp.c:710
    __sys_connect_file+0x7a/0xb0 net/socket.c:2089
    __sys_connect+0xde/0x110 net/socket.c:2108
    __do_sys_connect net/socket.c:2114 [inline]
    __se_sys_connect net/socket.c:2111 [inline]
    __x64_sys_connect+0x1c/0x30 net/socket.c:2111
    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
    do_syscall_64+0xa4/0xf80 arch/x86/entry/syscall_64.c:94
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

BUG: memory leak
unreferenced object 0xffff88810a290400 (size 512):
  comm "syz.0.18", pid 6087, jiffies 4294944299
  hex dump (first 32 bytes):
    7d eb 04 0c 00 00 00 00 01 00 00 00 00 00 00 00  }...............
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc c3dcc856):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4958 [inline]
    slab_alloc_node mm/slub.c:5263 [inline]
    __do_kmalloc_node mm/slub.c:5656 [inline]
    __kmalloc_noprof+0x3e0/0x660 mm/slub.c:5669
    kmalloc_noprof include/linux/slab.h:961 [inline]
    kzalloc_noprof include/linux/slab.h:1094 [inline]
    l2tp_session_create+0x3a/0x3b0 net/l2tp/l2tp_core.c:1778
    pppol2tp_connect+0x48b/0x920 net/l2tp/l2tp_ppp.c:755
    __sys_connect_file+0x7a/0xb0 net/socket.c:2089
    __sys_connect+0xde/0x110 net/socket.c:2108
    __do_sys_connect net/socket.c:2114 [inline]
    __se_sys_connect net/socket.c:2111 [inline]
    __x64_sys_connect+0x1c/0x30 net/socket.c:2111
    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
    do_syscall_64+0xa4/0xf80 arch/x86/entry/syscall_64.c:94
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

BUG: memory leak
unreferenced object 0xffff88810ac82840 (size 1472):
  comm "syz.0.19", pid 6088, jiffies 4294944300
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 22 0e aa 38 00 00 00 00  ........"..8....
    0a 00 07 40 00 00 00 00 18 ae 57 0a 81 88 ff ff  ...@......W.....
  backtrace (crc 6ae27eda):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4958 [inline]
    slab_alloc_node mm/slub.c:5263 [inline]
    kmem_cache_alloc_noprof+0x3b4/0x590 mm/slub.c:5270
    sk_prot_alloc+0x3e/0x1b0 net/core/sock.c:2239
    sk_alloc+0x36/0x440 net/core/sock.c:2301
    inet6_create net/ipv6/af_inet6.c:193 [inline]
    inet6_create+0x163/0x550 net/ipv6/af_inet6.c:120
    __sock_create+0x1a9/0x310 net/socket.c:1605
    sock_create net/socket.c:1663 [inline]
    __sys_socket_create net/socket.c:1700 [inline]
    __sys_socket+0xb9/0x1a0 net/socket.c:1747
    __do_sys_socket net/socket.c:1761 [inline]
    __se_sys_socket net/socket.c:1759 [inline]
    __x64_sys_socket+0x1b/0x30 net/socket.c:1759
    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
    do_syscall_64+0xa4/0xf80 arch/x86/entry/syscall_64.c:94
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

BUG: memory leak
unreferenced object 0xffff8881285dd800 (size 32):
  comm "syz.0.19", pid 6088, jiffies 4294944300
  hex dump (first 32 bytes):
    f8 52 86 00 81 88 ff ff 00 00 00 00 00 00 00 00  .R..............
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc bad1c2bd):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4958 [inline]
    slab_alloc_node mm/slub.c:5263 [inline]
    __do_kmalloc_node mm/slub.c:5656 [inline]
    __kmalloc_noprof+0x3e0/0x660 mm/slub.c:5669
    kmalloc_noprof include/linux/slab.h:961 [inline]
    kzalloc_noprof include/linux/slab.h:1094 [inline]
    lsm_blob_alloc+0x4d/0x70 security/security.c:192
    lsm_sock_alloc security/security.c:4375 [inline]
    security_sk_alloc+0x2f/0x270 security/security.c:4391
    sk_prot_alloc+0x8f/0x1b0 net/core/sock.c:2248
    sk_alloc+0x36/0x440 net/core/sock.c:2301
    inet6_create net/ipv6/af_inet6.c:193 [inline]
    inet6_create+0x163/0x550 net/ipv6/af_inet6.c:120
    __sock_create+0x1a9/0x310 net/socket.c:1605
    sock_create net/socket.c:1663 [inline]
    __sys_socket_create net/socket.c:1700 [inline]
    __sys_socket+0xb9/0x1a0 net/socket.c:1747
    __do_sys_socket net/socket.c:1761 [inline]
    __se_sys_socket net/socket.c:1759 [inline]
    __x64_sys_socket+0x1b/0x30 net/socket.c:1759
    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
    do_syscall_64+0xa4/0xf80 arch/x86/entry/syscall_64.c:94
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

connection error: failed to recv *flatrpc.ExecutorMessageRawT: EOF


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


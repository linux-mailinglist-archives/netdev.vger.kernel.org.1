Return-Path: <netdev+bounces-253122-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id b4QNFs1pdWlbFAEAu9opvQ
	(envelope-from <netdev+bounces-253122-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 01:54:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 89AAD7F67C
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 01:54:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CC3DC300A8EB
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 00:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B0E315ECCC;
	Sun, 25 Jan 2026 00:54:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f77.google.com (mail-ot1-f77.google.com [209.85.210.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74932262A6
	for <netdev@vger.kernel.org>; Sun, 25 Jan 2026 00:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769302474; cv=none; b=ZWxmvbeTTJzsdtG+BPFNtKxHeDH5cIaWtgDvw6SUHoY8Eli8A8NtfWpdK8Km5iikpHxGH1npbSkddzcPjnpEb35kmxFC6+bJhs4syrip7ufG//ABh4LgEUV/XXyB8L7tBnbHRhhADfVi4+hj490fV0HGv/zqFsRKKN8LA3sAb9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769302474; c=relaxed/simple;
	bh=G3SEcgfABsJ/4sjHNQRfcbwClFijO2ntq4/HEzl/1JI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=UZAgzuSJ80eDiiD0DniUXzosICqPYZHCgbyqNatZhaMNpXRHuws7qB0OTWW0oTrlscC5P3wlMmfK2FMTN6elGR/XBNGixzRaESR5yxgUaeO80O32yFQoTa5WH7PI7Lt1xC76b5FwxueI55++Ol5C4KVMfBZv83j+HEsFonl7kyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f77.google.com with SMTP id 46e09a7af769-7cfdd2f521bso4702804a34.1
        for <netdev@vger.kernel.org>; Sat, 24 Jan 2026 16:54:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769302471; x=1769907271;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yMOdJOjSHc2vjgj1/qTgqpAn1RxDG2+jjEN/so/n75E=;
        b=SCT7+0CkL3rwIiSpu/L3HgC3p1xxz+F+YXQPQ5Ch7MkVIWQdhuPY+2MuQbUGyygOrE
         +46wz1WX9YbqNBxnwlpYcgvUTKj4nuItfIrWzML/onRMpGjJGghW4iw9qF+HDDogF3ds
         m3tBVSRhX2MUNRjIZOed4Up+bqb4BZ86Al4FKqbmuVyJBSLgnB7ZG7ZavmstOGrDKDV4
         56v01/zE3XKXeLOynwamWaV8WTAY450/56apYMzNSJeDvbh7CO9VLm/npi3NL0kKkaFB
         GYvtOhH/1vOBPuMk3Cho3LTpRUbEUPwH6tDhBxbGzgtgN6FWRQQRBS0XLU+xWsyAY0eP
         ls4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVgVNOB1n6TgSd3jJzhlCWcF9WmzdxVVJHWnwI5vpshXRtu/A+p7I1wwZ8Dmc6uIhpp4BtDlgA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxA1aUIchjC3DBU44THVMboxQT5q9um5/prDh2FG/AV6/lNENk1
	XUldTf5l+UCtU+QJcvL/ESbDU6jfNpzyHHTOc+HwyMWMdfjIb3dSRqdrOJ3nkFCmqnzOtdkDwV+
	NeXoKy67JIC0VVPOowK3LgC9PyE2sfmXIwApR1gTOuLHS1trkUzu36RYZ+Cg=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:2d4a:b0:659:9a49:9047 with SMTP id
 006d021491bc7-662e02dc498mr194165eaf.18.1769302471385; Sat, 24 Jan 2026
 16:54:31 -0800 (PST)
Date: Sat, 24 Jan 2026 16:54:31 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <697569c7.a00a0220.33ccc7.0014.GAE@google.com>
Subject: [syzbot] [nfc?] [net?] memory leak in llcp_sock_create
From: syzbot <syzbot+f2d245f1d76bbfa50e4c@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	krzk@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=cb128cd5cb439809];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-253122-lists,netdev=lfdr.de,f2d245f1d76bbfa50e4c];
	SUBJECT_HAS_QUESTION(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[storage.googleapis.com:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,appspotmail.com:email,goo.gl:url]
X-Rspamd-Queue-Id: 89AAD7F67C
X-Rspamd-Action: no action

Hello,

syzbot found the following issue on:

HEAD commit:    da32d155f4a8 Merge tag 'gpio-fixes-for-v6.18-rc5' of git:/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1553117c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cb128cd5cb439809
dashboard link: https://syzkaller.appspot.com/bug?extid=f2d245f1d76bbfa50e4c
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1128d084580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10c6b812580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f0e5b9dcdca5/disk-da32d155.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e34cc0c57edb/vmlinux-da32d155.xz
kernel image: https://storage.googleapis.com/syzbot-assets/27bf793e9b1e/bzImage-da32d155.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f2d245f1d76bbfa50e4c@syzkaller.appspotmail.com

BUG: memory leak
unreferenced object 0xffff888100919400 (size 1024):
  comm "syz.0.33", pid 6225, jiffies 4294951961
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    27 00 03 40 00 00 00 00 00 00 00 00 00 00 00 00  '..@............
  backtrace (crc b7b16b39):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4979 [inline]
    slab_alloc_node mm/slub.c:5284 [inline]
    __do_kmalloc_node mm/slub.c:5645 [inline]
    __kmalloc_noprof+0x3e3/0x6b0 mm/slub.c:5658
    kmalloc_noprof include/linux/slab.h:961 [inline]
    sk_prot_alloc+0x11a/0x1b0 net/core/sock.c:2239
    sk_alloc+0x36/0x360 net/core/sock.c:2295
    nfc_llcp_sock_alloc+0x37/0x130 net/nfc/llcp_sock.c:979
    llcp_sock_create+0x71/0xd0 net/nfc/llcp_sock.c:1044
    nfc_sock_create+0xc9/0xf0 net/nfc/af_nfc.c:31
    __sock_create+0x1a9/0x340 net/socket.c:1605
    sock_create net/socket.c:1663 [inline]
    __sys_socket_create net/socket.c:1700 [inline]
    __sys_socket+0xb9/0x1a0 net/socket.c:1747
    __do_sys_socket net/socket.c:1761 [inline]
    __se_sys_socket net/socket.c:1759 [inline]
    __x64_sys_socket+0x1b/0x30 net/socket.c:1759
    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
    do_syscall_64+0xa4/0xfa0 arch/x86/entry/syscall_64.c:94
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

BUG: memory leak
unreferenced object 0xffff888146745b80 (size 32):
  comm "syz.0.33", pid 6225, jiffies 4294951961
  hex dump (first 32 bytes):
    f8 f2 85 00 81 88 ff ff 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc e7cc8a40):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4979 [inline]
    slab_alloc_node mm/slub.c:5284 [inline]
    __do_kmalloc_node mm/slub.c:5645 [inline]
    __kmalloc_noprof+0x3e3/0x6b0 mm/slub.c:5658
    kmalloc_noprof include/linux/slab.h:961 [inline]
    kzalloc_noprof include/linux/slab.h:1094 [inline]
    lsm_blob_alloc+0x4d/0x70 security/security.c:690
    lsm_sock_alloc security/security.c:4922 [inline]
    security_sk_alloc+0x30/0x270 security/security.c:4938
    sk_prot_alloc+0x135/0x1b0 net/core/sock.c:2242
    sk_alloc+0x36/0x360 net/core/sock.c:2295
    nfc_llcp_sock_alloc+0x37/0x130 net/nfc/llcp_sock.c:979
    llcp_sock_create+0x71/0xd0 net/nfc/llcp_sock.c:1044
    nfc_sock_create+0xc9/0xf0 net/nfc/af_nfc.c:31
    __sock_create+0x1a9/0x340 net/socket.c:1605
    sock_create net/socket.c:1663 [inline]
    __sys_socket_create net/socket.c:1700 [inline]
    __sys_socket+0xb9/0x1a0 net/socket.c:1747
    __do_sys_socket net/socket.c:1761 [inline]
    __se_sys_socket net/socket.c:1759 [inline]
    __x64_sys_socket+0x1b/0x30 net/socket.c:1759
    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
    do_syscall_64+0xa4/0xfa0 arch/x86/entry/syscall_64.c:94
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

BUG: memory leak
unreferenced object 0xffff888100919000 (size 1024):
  comm "syz.0.33", pid 6225, jiffies 4294951961
  hex dump (first 32 bytes):
    03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 01 00 00 00 d8 8a 17 1a 81 88 ff ff  ................
  backtrace (crc 8562c5d7):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4979 [inline]
    slab_alloc_node mm/slub.c:5284 [inline]
    __kmalloc_cache_noprof+0x3a6/0x5b0 mm/slub.c:5762
    kmalloc_noprof include/linux/slab.h:957 [inline]
    kzalloc_noprof include/linux/slab.h:1094 [inline]
    nfc_allocate_device+0xa1/0x1e0 net/nfc/core.c:1065
    nci_allocate_device+0xf5/0x180 net/nfc/nci/core.c:1190
    virtual_ncidev_open+0x4a/0x100 drivers/nfc/virtual_ncidev.c:145
    misc_open+0x12a/0x1f0 drivers/char/misc.c:163
    chrdev_open+0x10a/0x310 fs/char_dev.c:414
    do_dentry_open+0x388/0x800 fs/open.c:965
    vfs_open+0x3d/0x1b0 fs/open.c:1097
    do_open fs/namei.c:3975 [inline]
    path_openat+0x11aa/0x1eb0 fs/namei.c:4134
    do_filp_open+0x102/0x1f0 fs/namei.c:4161
    do_sys_openat2+0xc1/0x140 fs/open.c:1437
    do_sys_open fs/open.c:1452 [inline]
    __do_sys_openat fs/open.c:1468 [inline]
    __se_sys_openat fs/open.c:1463 [inline]
    __x64_sys_openat+0xb2/0x100 fs/open.c:1463
    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
    do_syscall_64+0xa4/0xfa0 arch/x86/entry/syscall_64.c:94
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

BUG: memory leak
unreferenced object 0xffff88811a178ad8 (size 8):
  comm "syz.0.33", pid 6225, jiffies 4294951961
  hex dump (first 8 bytes):
    6e 66 63 33 00 00 00 00                          nfc3....
  backtrace (crc 45e674f4):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4979 [inline]
    slab_alloc_node mm/slub.c:5284 [inline]
    __do_kmalloc_node mm/slub.c:5645 [inline]
    __kmalloc_node_track_caller_noprof+0x3aa/0x6b0 mm/slub.c:5755
    kvasprintf+0x70/0xf0 lib/kasprintf.c:25
    kvasprintf_const+0x5c/0x110 lib/kasprintf.c:49
    kobject_set_name_vargs+0x40/0xd0 lib/kobject.c:274
    dev_set_name+0x6d/0x90 drivers/base/core.c:3492
    nfc_allocate_device+0x109/0x1e0 net/nfc/core.c:1075
    nci_allocate_device+0xf5/0x180 net/nfc/nci/core.c:1190
    virtual_ncidev_open+0x4a/0x100 drivers/nfc/virtual_ncidev.c:145
    misc_open+0x12a/0x1f0 drivers/char/misc.c:163
    chrdev_open+0x10a/0x310 fs/char_dev.c:414
    do_dentry_open+0x388/0x800 fs/open.c:965
    vfs_open+0x3d/0x1b0 fs/open.c:1097
    do_open fs/namei.c:3975 [inline]
    path_openat+0x11aa/0x1eb0 fs/namei.c:4134
    do_filp_open+0x102/0x1f0 fs/namei.c:4161
    do_sys_openat2+0xc1/0x140 fs/open.c:1437
    do_sys_open fs/open.c:1452 [inline]
    __do_sys_openat fs/open.c:1468 [inline]
    __se_sys_openat fs/open.c:1463 [inline]
    __x64_sys_openat+0xb2/0x100 fs/open.c:1463

BUG: memory leak
unreferenced object 0xffff88812493d900 (size 256):
  comm "syz.0.33", pid 6225, jiffies 4294951961
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 08 d9 93 24 81 88 ff ff  ...........$....
    08 d9 93 24 81 88 ff ff 00 b3 19 83 ff ff ff ff  ...$............
  backtrace (crc c71a4960):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4979 [inline]
    slab_alloc_node mm/slub.c:5284 [inline]
    __kmalloc_cache_noprof+0x3a6/0x5b0 mm/slub.c:5762
    kmalloc_noprof include/linux/slab.h:957 [inline]
    kzalloc_noprof include/linux/slab.h:1094 [inline]
    device_private_init drivers/base/core.c:3534 [inline]
    device_add+0x72a/0xc80 drivers/base/core.c:3585
    nfc_register_device+0x31/0x150 net/nfc/core.c:1118
    nci_register_device+0x2af/0x340 net/nfc/nci/core.c:1277
    virtual_ncidev_open+0x9f/0x100 drivers/nfc/virtual_ncidev.c:157
    misc_open+0x12a/0x1f0 drivers/char/misc.c:163
    chrdev_open+0x10a/0x310 fs/char_dev.c:414
    do_dentry_open+0x388/0x800 fs/open.c:965
    vfs_open+0x3d/0x1b0 fs/open.c:1097
    do_open fs/namei.c:3975 [inline]
    path_openat+0x11aa/0x1eb0 fs/namei.c:4134
    do_filp_open+0x102/0x1f0 fs/namei.c:4161
    do_sys_openat2+0xc1/0x140 fs/open.c:1437
    do_sys_open fs/open.c:1452 [inline]
    __do_sys_openat fs/open.c:1468 [inline]
    __se_sys_openat fs/open.c:1463 [inline]
    __x64_sys_openat+0xb2/0x100 fs/open.c:1463
    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
    do_syscall_64+0xa4/0xfa0 arch/x86/entry/syscall_64.c:94
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


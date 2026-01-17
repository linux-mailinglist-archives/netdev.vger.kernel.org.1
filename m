Return-Path: <netdev+bounces-250725-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 601B7D3901A
	for <lists+netdev@lfdr.de>; Sat, 17 Jan 2026 18:34:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5FACD300A854
	for <lists+netdev@lfdr.de>; Sat, 17 Jan 2026 17:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85658296BB8;
	Sat, 17 Jan 2026 17:34:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f80.google.com (mail-ot1-f80.google.com [209.85.210.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDBC5287272
	for <netdev@vger.kernel.org>; Sat, 17 Jan 2026 17:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768671266; cv=none; b=g/G2uhvoZ9bIg/p3wzdvHqSCk2gsjALjXBcHTstwO3wqImgooMTnimWDQW/Nyuv+qvQnlpAq2dIIba8l8kKptJF5VPUQgsbcW/v86/GxfmpqMChNI/PlzLWqON6s0UYtVexU3vhMsec8mVOsO8oaz7bBkwHRCOAJ8EGtYAsjMxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768671266; c=relaxed/simple;
	bh=ymw1mnAwhQwble7fxZJZqB7dd0yr217XocbrDc/GORw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=m/ScXKoWOQzfzO2I9mnW9397FKq08Sw7FP6ptfSOopepNOiMH+VeQvEgd62AabGDmbqGuWpOBaLMYXRr3g1TvYt5g155Tf8Ksa8AkQwFaLZBaBCQlioLNDky5bu0q8gaU6z9JME4WMLzPaPAhL1BuzUHXU0GgafZj/NwvW6Puq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f80.google.com with SMTP id 46e09a7af769-7d11b35e8acso4188566a34.0
        for <netdev@vger.kernel.org>; Sat, 17 Jan 2026 09:34:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768671263; x=1769276063;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NGFV9lljasK2FVEHNn9sJ16rF8IguJgi+uaOD4/G+go=;
        b=BOSecmvd8ZexdIptmzyfnG2mEyBFMrZHPZ5HtfsM1B4sVJHh/FTN+ghJ3oC/hTlA3W
         ImPdtt8S4sSFRYFirvoUN81FTLOCvSFpLg64oqaDKZ6WwmxCptuPec/oLXkXSdSFpDHM
         dSNhrL05zC5Q8suDH3C/H/pjhXGj4LOXJEQs6x4S70rk69yVAQ4DGsPKogCdhigCRlxu
         mG2g3bLigFSt+qO5RvrhDs7A7D30nTPaEtRoGjTD8x4Z4MjeY91rK/qx7IeSPwwZV93x
         IWaP3DlzIOJp1vpxmRA3aImN0JTPlCAx1S2hNDVYX5aQY+t8LaUksRK8bld1Agr/QvEu
         MsCA==
X-Forwarded-Encrypted: i=1; AJvYcCXHhbKESDqgMjcUBk63cDiY0wL5nYvGMwHCoGCSnIGorayjtg0OYT4u+s8Wp3U7AGgDbevTEBg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsLvA08COl/BPbtgOi4Tu/Tm49dQBMj8wkCz08iRs6SKY8Bzd+
	DjZymEKwDQsoc/7A9ZcHjpeZgo0MwYHzkibOjJofUr74KCixExB3GgFLpN33v0MOmnbxTVn1MFi
	CoLtHEW9XHDTjLEEPardeUPYuFOvUajWcu1lG1hlEvMU+r5eTCG92UJFwbjA=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:6aea:b0:65d:1e7:9527 with SMTP id
 006d021491bc7-661179b6a70mr2788423eaf.51.1768671263783; Sat, 17 Jan 2026
 09:34:23 -0800 (PST)
Date: Sat, 17 Jan 2026 09:34:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <696bc81f.050a0220.3390f1.000f.GAE@google.com>
Subject: [syzbot] [net?] [input?] [usb?] memory leak in ldisc_receive
From: syzbot <syzbot+f9d847b2b84164fa69f3@syzkaller.appspotmail.com>
To: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    b71e635feefc Merge tag 'cgroup-for-6.19-rc5-fixes' of git:..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1638a59a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=87bc41cae23d2144
dashboard link: https://syzkaller.appspot.com/bug?extid=f9d847b2b84164fa69f3
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=162985fc580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1035f922580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/821cfcb36509/disk-b71e635f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/80f2b6f81538/vmlinux-b71e635f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c5a9299bca98/bzImage-b71e635f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f9d847b2b84164fa69f3@syzkaller.appspotmail.com

BUG: memory leak
unreferenced object 0xffff888109d88b00 (size 240):
  comm "syz.0.17", pid 6088, jiffies 4294942822
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 20 8e 13 81 88 ff ff 00 00 00 00 00 00 00 00  . ..............
  backtrace (crc cd2b8445):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4958 [inline]
    slab_alloc_node mm/slub.c:5263 [inline]
    kmem_cache_alloc_node_noprof+0x384/0x5a0 mm/slub.c:5315
    __alloc_skb+0xe8/0x2b0 net/core/skbuff.c:679
    __netdev_alloc_skb+0x72/0x230 net/core/skbuff.c:754
    netdev_alloc_skb include/linux/skbuff.h:3484 [inline]
    ldisc_receive+0x7d/0x210 drivers/net/caif/caif_serial.c:176
    tiocsti drivers/tty/tty_io.c:2290 [inline]
    tty_ioctl+0x329/0xd40 drivers/tty/tty_io.c:2706
    vfs_ioctl fs/ioctl.c:51 [inline]
    __do_sys_ioctl fs/ioctl.c:597 [inline]
    __se_sys_ioctl fs/ioctl.c:583 [inline]
    __x64_sys_ioctl+0xf4/0x140 fs/ioctl.c:583
    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
    do_syscall_64+0xa4/0xf80 arch/x86/entry/syscall_64.c:94
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

BUG: memory leak
unreferenced object 0xffff88810a368500 (size 240):
  comm "syz.0.18", pid 6193, jiffies 4294942941
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 20 94 13 81 88 ff ff 00 00 00 00 00 00 00 00  . ..............
  backtrace (crc 5d1300cb):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4958 [inline]
    slab_alloc_node mm/slub.c:5263 [inline]
    kmem_cache_alloc_node_noprof+0x384/0x5a0 mm/slub.c:5315
    __alloc_skb+0xe8/0x2b0 net/core/skbuff.c:679
    __netdev_alloc_skb+0x72/0x230 net/core/skbuff.c:754
    netdev_alloc_skb include/linux/skbuff.h:3484 [inline]
    ldisc_receive+0x7d/0x210 drivers/net/caif/caif_serial.c:176
    tiocsti drivers/tty/tty_io.c:2290 [inline]
    tty_ioctl+0x329/0xd40 drivers/tty/tty_io.c:2706
    vfs_ioctl fs/ioctl.c:51 [inline]
    __do_sys_ioctl fs/ioctl.c:597 [inline]
    __se_sys_ioctl fs/ioctl.c:583 [inline]
    __x64_sys_ioctl+0xf4/0x140 fs/ioctl.c:583
    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
    do_syscall_64+0xa4/0xf80 arch/x86/entry/syscall_64.c:94
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

BUG: memory leak
unreferenced object 0xffff88810a9e2c00 (size 704):
  comm "syz.0.18", pid 6193, jiffies 4294942941
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc b6200c):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4958 [inline]
    slab_alloc_node mm/slub.c:5263 [inline]
    kmem_cache_alloc_node_noprof+0x384/0x5a0 mm/slub.c:5315
    kmalloc_reserve+0xe6/0x180 net/core/skbuff.c:586
    __alloc_skb+0x111/0x2b0 net/core/skbuff.c:690
    __netdev_alloc_skb+0x72/0x230 net/core/skbuff.c:754
    netdev_alloc_skb include/linux/skbuff.h:3484 [inline]
    ldisc_receive+0x7d/0x210 drivers/net/caif/caif_serial.c:176
    tiocsti drivers/tty/tty_io.c:2290 [inline]
    tty_ioctl+0x329/0xd40 drivers/tty/tty_io.c:2706
    vfs_ioctl fs/ioctl.c:51 [inline]
    __do_sys_ioctl fs/ioctl.c:597 [inline]
    __se_sys_ioctl fs/ioctl.c:583 [inline]
    __x64_sys_ioctl+0xf4/0x140 fs/ioctl.c:583
    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
    do_syscall_64+0xa4/0xf80 arch/x86/entry/syscall_64.c:94
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

BUG: memory leak
unreferenced object 0xffff888109ddda00 (size 240):
  comm "syz.0.19", pid 6262, jiffies 4294943059
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 50 8e 13 81 88 ff ff 00 00 00 00 00 00 00 00  .P..............
  backtrace (crc 3f6ba7c1):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4958 [inline]
    slab_alloc_node mm/slub.c:5263 [inline]
    kmem_cache_alloc_node_noprof+0x384/0x5a0 mm/slub.c:5315
    __alloc_skb+0xe8/0x2b0 net/core/skbuff.c:679
    __netdev_alloc_skb+0x72/0x230 net/core/skbuff.c:754
    netdev_alloc_skb include/linux/skbuff.h:3484 [inline]
    ldisc_receive+0x7d/0x210 drivers/net/caif/caif_serial.c:176
    tiocsti drivers/tty/tty_io.c:2290 [inline]
    tty_ioctl+0x329/0xd40 drivers/tty/tty_io.c:2706
    vfs_ioctl fs/ioctl.c:51 [inline]
    __do_sys_ioctl fs/ioctl.c:597 [inline]
    __se_sys_ioctl fs/ioctl.c:583 [inline]
    __x64_sys_ioctl+0xf4/0x140 fs/ioctl.c:583
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


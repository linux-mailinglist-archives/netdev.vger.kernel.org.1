Return-Path: <netdev+bounces-244913-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 06714CC1E7F
	for <lists+netdev@lfdr.de>; Tue, 16 Dec 2025 11:06:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5CF7C300E145
	for <lists+netdev@lfdr.de>; Tue, 16 Dec 2025 10:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 728CD30C376;
	Tue, 16 Dec 2025 10:06:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f77.google.com (mail-oo1-f77.google.com [209.85.161.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8704223323
	for <netdev@vger.kernel.org>; Tue, 16 Dec 2025 10:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765879598; cv=none; b=iDhdRb4h7Sj0wWEMnGOopOfLGUxOScjHv1rqEbQ2OTP4cbQaqOl8qc5qIJjtVWJe+xTFWuuB3/5GMHChemLUwEMz3G5XQP3+JSr2AeT4yjIkEE4gwjd4TRkdFtS4lTHYGWPNuYlpC38MChCHZz8uT1nBo2jGx0+iDBy/6p1dTiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765879598; c=relaxed/simple;
	bh=Qvd1NP5Xf9TeKcs1qYesTBGue9jRZL+FCu0Kzl25spo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=JCTH25fBYF4+2WDHd8fiHpetxWY47CB6kmOgqGlODk4xy50p9tmBveEDge78BL1R962V0C/oCnp/dFCd4KKAtoPptaSNB5PuJNywgIPvBbhVEEljAsbCuRksATUsJ3nku+o/0YVF06r24/K0h3tDqm+X+CA88pROH8z7UiP+WPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f77.google.com with SMTP id 006d021491bc7-6573d873f92so3706068eaf.2
        for <netdev@vger.kernel.org>; Tue, 16 Dec 2025 02:06:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765879595; x=1766484395;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SUJpa87UrKKziuKtUiBdGUaEWcsGpioTwzn+vG4XG6I=;
        b=f/jUKAD6hyR/xb806y9gx4JjYUc3O2WWYb2OjW16lq++RRZOLw9Qo8No73mC2b+sdh
         uyKy7PtYzOIIg5pL+iE22clRzpyNtGUazU71qe7Ti7inRGrDuVAg519Uq+9MdovswHI1
         4qAJgX9sBS2MeKor0zv4D0151ulXQ4VzZ4BoGewJpV21Uk70wD+X3TQ29OGMysg2m5h+
         TiiRRCFAWxLKph2UfxTJ2fj+WcUNLp3TcWjXjvwMpcxUsaAVss8msF9lGiOG2/1Ak9wA
         aq4RC/eEJtCNrGzTicJ5qA3PD88NdlEZN2+6IRZrSRntLjorI40uLYH237AMoD8TAqpC
         2X5g==
X-Forwarded-Encrypted: i=1; AJvYcCVmz+LjUbDe1N6qYj4RiXrhbameYCGWtNMdnAVtcIKiMC8WeXZd4wIb4ejM2kzjqWTSkN666dM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs/RtxdrAR2LsrguVsKc+3cXNj7ZdmTvnghXfK/0CyyZBObcBG
	+9v18t9RvN+2OAA6BMKk7HwO0Oa1KAVO2RjC8Gim2sfR2iGaemN5h5dfpA+3LBkPo1OxvSdQtXA
	iF9oCQtgNpO7CSA2LerZwqN5Tc1gH/VEEIgTJ8P5F/wMpZV7yDY7MCmZEmQ0=
X-Google-Smtp-Source: AGHT+IG7G6T3Hen13lkGA8rw46Ci0BTT+qn6Zc2NlE4Bh+pJMOxQZ+ETXsSn5SZdkhQrKFYELYTi8O0kF1wYhens5JFzSG9VE3Xp
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:1607:b0:65b:81eb:ae5c with SMTP id
 006d021491bc7-65b81ebb6dbmr279838eaf.8.1765879595628; Tue, 16 Dec 2025
 02:06:35 -0800 (PST)
Date: Tue, 16 Dec 2025 02:06:35 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69412f2b.a70a0220.104cf0.034b.GAE@google.com>
Subject: [syzbot] [net?] [usb?] memory leak in rtl8150_set_multicast
From: syzbot <syzbot+8dd915c7cb0490fc8c52@syzkaller.appspotmail.com>
To: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, petkan@nucleusys.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    d358e5254674 Merge tag 'for-6.19/dm-changes' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11e431c2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9a0268003e02068d
dashboard link: https://syzkaller.appspot.com/bug?extid=8dd915c7cb0490fc8c52
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12dd661a580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e79f317bb571/disk-d358e525.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/cf9e2849af10/vmlinux-d358e525.xz
kernel image: https://storage.googleapis.com/syzbot-assets/73d80a967038/bzImage-d358e525.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8dd915c7cb0490fc8c52@syzkaller.appspotmail.com

BUG: memory leak
unreferenced object 0xffff888127d51010 (size 16):
  comm "dhcpcd", pid 5479, jiffies 4294951443
  hex dump (first 16 bytes):
    40 05 30 01 00 00 02 00 9e 00 00 00 00 00 00 00  @.0.............
  backtrace (crc 5546a3be):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4958 [inline]
    slab_alloc_node mm/slub.c:5263 [inline]
    __kmalloc_cache_noprof+0x3b2/0x570 mm/slub.c:5771
    kmalloc_noprof include/linux/slab.h:957 [inline]
    async_set_registers drivers/net/usb/rtl8150.c:192 [inline]
    rtl8150_set_multicast+0x7a/0x1c0 drivers/net/usb/rtl8150.c:679
    __dev_set_rx_mode+0xc5/0x120 net/core/dev.c:9655
    dev_set_rx_mode net/core/dev.c:9661 [inline]
    __dev_open+0x23f/0x3c0 net/core/dev.c:1691
    __dev_change_flags+0x30c/0x380 net/core/dev.c:9734
    netif_change_flags+0x35/0x90 net/core/dev.c:9797
    dev_change_flags+0x64/0xf0 net/core/dev_api.c:68
    devinet_ioctl+0x5bf/0xd30 net/ipv4/devinet.c:1199
    inet_ioctl+0x27c/0x2b0 net/ipv4/af_inet.c:1009
    sock_do_ioctl+0x84/0x1a0 net/socket.c:1254
    sock_ioctl+0x149/0x480 net/socket.c:1375
    vfs_ioctl fs/ioctl.c:51 [inline]
    __do_sys_ioctl fs/ioctl.c:597 [inline]
    __se_sys_ioctl fs/ioctl.c:583 [inline]
    __x64_sys_ioctl+0xf4/0x140 fs/ioctl.c:583
    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
    do_syscall_64+0xa4/0xf80 arch/x86/entry/syscall_64.c:94
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

BUG: memory leak
unreferenced object 0xffff8881282bae40 (size 192):
  comm "dhcpcd", pid 5479, jiffies 4294951443
  hex dump (first 32 bytes):
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 58 ae 2b 28 81 88 ff ff  ........X.+(....
  backtrace (crc d110b1b3):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4958 [inline]
    slab_alloc_node mm/slub.c:5263 [inline]
    __do_kmalloc_node mm/slub.c:5656 [inline]
    __kmalloc_noprof+0x3e0/0x660 mm/slub.c:5669
    kmalloc_noprof include/linux/slab.h:961 [inline]
    usb_alloc_urb+0x66/0xa0 drivers/usb/core/urb.c:75
    async_set_registers drivers/net/usb/rtl8150.c:195 [inline]
    rtl8150_set_multicast+0x97/0x1c0 drivers/net/usb/rtl8150.c:679
    __dev_set_rx_mode+0xc5/0x120 net/core/dev.c:9655
    dev_set_rx_mode net/core/dev.c:9661 [inline]
    __dev_open+0x23f/0x3c0 net/core/dev.c:1691
    __dev_change_flags+0x30c/0x380 net/core/dev.c:9734
    netif_change_flags+0x35/0x90 net/core/dev.c:9797
    dev_change_flags+0x64/0xf0 net/core/dev_api.c:68
    devinet_ioctl+0x5bf/0xd30 net/ipv4/devinet.c:1199
    inet_ioctl+0x27c/0x2b0 net/ipv4/af_inet.c:1009
    sock_do_ioctl+0x84/0x1a0 net/socket.c:1254
    sock_ioctl+0x149/0x480 net/socket.c:1375
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


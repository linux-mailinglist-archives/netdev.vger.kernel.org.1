Return-Path: <netdev+bounces-217513-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E17B38F1E
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 01:22:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9DF547AC99E
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 23:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80B1F30FF04;
	Wed, 27 Aug 2025 23:22:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2DF301006
	for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 23:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756336957; cv=none; b=dofs78pBAdtNBG7g9IQckIrEtFLzqem3omW+W3cQ7Q9TB92CJwAFfJQO0bKKwdnQQynrLUoJNduyQwU/S7YGZv7nOFMLTqlS/SxSi4VJZ88kwQfjMyHKOqx/YADKMGuPdM2lv5/XLEAu1SlBArl5yvOn5vxS62mdD84/c4Y32do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756336957; c=relaxed/simple;
	bh=0GRIOvOeVhXcTpXjeCZTG4Wm6VLWPHRblsRlooK4Ayg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=r7B1W1jzx7PiAM39sQ7wHUXRKJtK9upN7uy7P4dGBxQWX1ORBuby8s1p793Buo56Qo2h8BRDThVOMUO8K0SkUhe79OziaHFpVo+FOnHwJNVjuDl3QjxCIaTXh12vcSCYf2AtiqWZvy8IcjXWwrLowVBy89UyYFh+F/sw/LiDz+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-88432cb7627so40667939f.0
        for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 16:22:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756336955; x=1756941755;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ki+X7udoy2qkKDlMn7tVUFGA43nOQ+o8mdWuhpBpgeA=;
        b=EeQVlndMSUP38REi7u1Y3CksxF+dUWsgvtsyTSwzyIJ6NPq3ARAhwXDHOWmRYjo/6e
         Em5y7qj9Uj2P0O3jYijVHjsqdfzG4W8TiyaqN3dPEkJcKaYPvL8bqbuzXanrKDjdBjl4
         0IP/g+Jddmtg4FGragVA98rbjq4HmL0AtBHsZc91JolhsYkowfUBpWCucJfb3Nxn7hGT
         VjWK2FZuONqQWJSEnN5QW7tF+Nn+HYyBR5DSmoj5m/Pb61A7whMtXLN4SR5Q9H0A6c92
         9SAJzUTpld8Udd8o3K7qt1X8E7yhIWa9dywMyalUcQYMDrbRA2M6fL6+KRUV5brvS7pv
         Prtw==
X-Forwarded-Encrypted: i=1; AJvYcCXpkVaSiRzOW1AQ6VtkcX8b6GukfM1winwAWqJNmXEohRmGaE5OJoi2cpMlvfbtT2AoFVvEt+o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzc7mgamCifOV0sLJmIXhCd3NS2FovntRGrIsSS1ItTnikAjun1
	hgERfdq4Iik5jWlUUpgMmlHmzZZugz6B3tT6MamCvCIE2Gshz6UWTyKFWLbvpapYpquCq7UKoXd
	ish/a9MFHswzL3Qvuu929LJ4pWjz5TarLOEf9UlUJ7jAiSAuoD4fns1IamRo=
X-Google-Smtp-Source: AGHT+IH3N1ARNwZGmUjEWCZQJ81oG91H3vhlVBbtDcF1nVYElY3E28RiYQ5MQlN4AKZM4aYUDzUYwQE5O+jjny0YFPioim6so6+G
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2c11:b0:881:87ac:24a with SMTP id
 ca18e2360f4ac-886bd14dd6cmr2927042739f.7.1756336955004; Wed, 27 Aug 2025
 16:22:35 -0700 (PDT)
Date: Wed, 27 Aug 2025 16:22:34 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68af933a.a00a0220.2929dc.0007.GAE@google.com>
Subject: [syzbot] [net?] [usb?] KMSAN: uninit-value in rtl8150_open
From: syzbot <syzbot+b4d5d8faea6996fd55e3@syzkaller.appspotmail.com>
To: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, petkan@nucleusys.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    fab1beda7597 Merge tag 'devicetree-fixes-for-6.17-1' of gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17a9e462580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6ccfdce02093e91f
dashboard link: https://syzkaller.appspot.com/bug?extid=b4d5d8faea6996fd55e3
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/db03ab9be061/disk-fab1beda.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/465314c75c15/vmlinux-fab1beda.xz
kernel image: https://storage.googleapis.com/syzbot-assets/02e5480b1de2/bzImage-fab1beda.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b4d5d8faea6996fd55e3@syzkaller.appspotmail.com

usb 1-1: device reset failed
=====================================================
BUG: KMSAN: uninit-value in set_carrier drivers/net/usb/rtl8150.c:721 [inline]
BUG: KMSAN: uninit-value in rtl8150_open+0x1131/0x1360 drivers/net/usb/rtl8150.c:758
 set_carrier drivers/net/usb/rtl8150.c:721 [inline]
 rtl8150_open+0x1131/0x1360 drivers/net/usb/rtl8150.c:758
 __dev_open+0x7e9/0xc60 net/core/dev.c:1682
 __dev_change_flags+0x3a8/0x9f0 net/core/dev.c:9549
 netif_change_flags+0x8d/0x1e0 net/core/dev.c:9612
 dev_change_flags+0x18c/0x320 net/core/dev_api.c:68
 devinet_ioctl+0x1186/0x2500 net/ipv4/devinet.c:1200
 inet_ioctl+0x4c0/0x6f0 net/ipv4/af_inet.c:1001
 sock_do_ioctl+0x9c/0x480 net/socket.c:1238
 sock_ioctl+0x70b/0xd60 net/socket.c:1359
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:598 [inline]
 __se_sys_ioctl+0x23c/0x400 fs/ioctl.c:584
 __x64_sys_ioctl+0x97/0xe0 fs/ioctl.c:584
 x64_sys_call+0x1cbc/0x3e20 arch/x86/include/generated/asm/syscalls_64.h:17
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xd9/0x210 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Local variable tmp created at:
 number+0x8a/0x2200 lib/vsprintf.c:469
 vsnprintf+0xd21/0x1bd0 lib/vsprintf.c:2890

CPU: 1 UID: 0 PID: 5461 Comm: dhcpcd Not tainted syzkaller #0 PREEMPT(none) 
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

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup


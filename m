Return-Path: <netdev+bounces-189355-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1608AB1D8D
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 21:59:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04A131B6596E
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 19:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7CF525E812;
	Fri,  9 May 2025 19:59:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AFAE23E32D
	for <netdev@vger.kernel.org>; Fri,  9 May 2025 19:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746820767; cv=none; b=X3juxSHxtpaeUAasY6n1/lnmXZW/IFeK+hqdOpxmou7b671o4jOYgPBw2ZpAm+SoTjE3qod8RwQboBTQzCJ7hP/3J0Nl/p5qWueu7J4iAYr0xZtpnOg0WEKBGE00IgXdCWE+ElCLwswWnkUjd1kx45wFOO2iocembUsgXk61rKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746820767; c=relaxed/simple;
	bh=WBicAQQ7I7jD+BXfAXJcmzJUHZtYsTXi4lYFgkk6PiM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=k/tJrukUBmeLLodLx6EyBay6ItJ71A/fksMAme80txUhq4NXEsnS1D6T224esX4vry3LSDKAp0M0GLHEFvOjvlbbmAM/PJNViYK8VtTlmfAzxLU6aerH1XY0qkE2HBXXICag1b+uX/mUH8gf8lCQrxETCYNFVeoG3OlLVQ9Mbwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-85b3a6c37e2so239049439f.0
        for <netdev@vger.kernel.org>; Fri, 09 May 2025 12:59:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746820765; x=1747425565;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5HHdjPaJZATsD4Stzjdp0FvRUeXTSmH41+zYifft2k8=;
        b=E3r8oudlxk1GJeqBhFBEwehjv0/Uw31TzzEfgotWFxY4jEmuBEVLIGafyiaYv5ezUs
         9GRg2K46KBMUwvcZ/MrMMPhWKCyK73DZiYOdOQ4WmCHLI5C8q3Vb2bwDhHuvHaf8wi67
         9tIhMM3ogA3EAv/OlliWYZsVA6gEFOLp6bsC1pkruXTOlJU+tNBCDxGtqISYi7mHdgK1
         Nj7JPDugBsUZbvjvWwPMXiD6/TwCEezq3vAT/t86DraFpWWoBcNB5lHYSVAxS1ICsDm/
         rFQOiOfpSymGmWNoOQkmTJWGF27W46IYWfRPllh07KiKu9UZjZoVYM3daLkAvEKKGe/b
         6RBw==
X-Forwarded-Encrypted: i=1; AJvYcCWzvNPugoB0J7XlyZWeCiAJz14sxgDUGZZpLPPIoyOX0v8hZbsHfv+jHHCw8yZzsT5+O1PBk5o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf4rvZSp0gnaNCxwZqkODnJCDWPscBixiNeR7gaEjiY5Zmx8yr
	7Lm/E0ZHu07cHtpxoQuHH5yR4vMHWmkDPtg7+XOfq6kzYwWnM60NoM8TUW+fkWoa1CwFt+B2kAt
	YGqvrGJ9xyz5xFy8Gzj2KWsUDba/ytVO9l3wEE36ZgyANdvog6G23MIc=
X-Google-Smtp-Source: AGHT+IHeboep2/ZgtFNAhDHSbks4MCSLzuCqS7IShy4118ffGTy8D7WOEd5KBH9UtQ1fVwyRzbNH/0MfHv8FulD/cQ+t4Xmd+ijv
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:154c:b0:864:4a9c:1bd7 with SMTP id
 ca18e2360f4ac-86763392674mr650551839f.0.1746820765271; Fri, 09 May 2025
 12:59:25 -0700 (PDT)
Date: Fri, 09 May 2025 12:59:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <681e5e9d.050a0220.a19a9.013c.GAE@google.com>
Subject: [syzbot] [net?] KMSAN: uninit-value in __ipv6_dev_mc_dec (2)
From: syzbot <syzbot+4472ecce287501aa597a@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    02ddfb981de8 Merge tag 'scsi-fixes' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13a14670580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9dc42c34a3f5c357
dashboard link: https://syzkaller.appspot.com/bug?extid=4472ecce287501aa597a
compiler:       Debian clang version 20.1.2 (++20250402124445+58df0ef89dd6-1~exp1~20250402004600.97), Debian LLD 20.1.2
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/7dc8afe7520f/disk-02ddfb98.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3194559250c2/vmlinux-02ddfb98.xz
kernel image: https://storage.googleapis.com/syzbot-assets/86c7c494f08f/bzImage-02ddfb98.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4472ecce287501aa597a@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in __ipv6_dev_mc_dec+0x68a/0xd30 net/ipv6/mcast.c:1014
 __ipv6_dev_mc_dec+0x68a/0xd30 net/ipv6/mcast.c:1014
 addrconf_leave_solict net/ipv6/addrconf.c:2254 [inline]
 __ipv6_ifa_notify+0xf97/0x1990 net/ipv6/addrconf.c:6299
 addrconf_ifdown+0x1c61/0x32e0 net/ipv6/addrconf.c:3978
 addrconf_notify+0x183/0x1d10 net/ipv6/addrconf.c:3777
 notifier_call_chain kernel/notifier.c:85 [inline]
 raw_notifier_call_chain+0xdd/0x410 kernel/notifier.c:453
 call_netdevice_notifiers_info+0x1ac/0x2b0 net/core/dev.c:2176
 call_netdevice_notifiers_extack net/core/dev.c:2214 [inline]
 call_netdevice_notifiers net/core/dev.c:2228 [inline]
 dev_close_many+0x52a/0x8f0 net/core/dev.c:1731
 unregister_netdevice_many_notify+0x1106/0x4970 net/core/dev.c:11952
 unregister_netdevice_many net/core/dev.c:12046 [inline]
 unregister_netdevice_queue+0x3b1/0x600 net/core/dev.c:11889
 unregister_netdevice include/linux/netdevice.h:3374 [inline]
 __tun_detach+0x16c8/0x20c0 drivers/net/tun.c:620
 tun_detach drivers/net/tun.c:636 [inline]
 tun_chr_close+0xb7/0x290 drivers/net/tun.c:3390
 __fput+0x608/0x1040 fs/file_table.c:465
 ____fput+0x25/0x30 fs/file_table.c:493
 task_work_run+0x206/0x2b0 kernel/task_work.c:227
 resume_user_mode_work+0x105/0x160 include/linux/resume_user_mode.h:50
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:329 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x7b/0xb0 kernel/entry/common.c:218
 __do_fast_syscall_32+0xbd/0x110 arch/x86/entry/syscall_32.c:309
 do_fast_syscall_32+0x38/0x80 arch/x86/entry/syscall_32.c:331
 do_SYSENTER_32+0x1f/0x30 arch/x86/entry/syscall_32.c:369
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e

Local variable maddr.i created at:
 addrconf_leave_solict net/ipv6/addrconf.c:2248 [inline]
 __ipv6_ifa_notify+0xe6f/0x1990 net/ipv6/addrconf.c:6299
 addrconf_ifdown+0x1c61/0x32e0 net/ipv6/addrconf.c:3978

CPU: 1 UID: 0 PID: 10959 Comm: syz.4.717 Not tainted 6.15.0-rc3-syzkaller-00094-g02ddfb981de8 #0 PREEMPT(undef) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/29/2025
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


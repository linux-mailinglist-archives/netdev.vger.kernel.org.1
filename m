Return-Path: <netdev+bounces-211780-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21E83B1BB25
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 21:48:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 480DE17EEAA
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 19:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDD3123ABAB;
	Tue,  5 Aug 2025 19:48:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1ED86359
	for <netdev@vger.kernel.org>; Tue,  5 Aug 2025 19:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754423312; cv=none; b=AQ3Fc95dNMaAGTAN7C6fRCyglTsVkozcpNUhqvM4DLPgwgF0HCyd+49J2NfMVTO8QGtQ9XErxTzN0xfI3Okj/k3FfPGpJg/2bNydythANRui3bFHBHUAGY6xQh/sgrLG+UA5HVPY6kgO9HOMJ4r+4uShq8uH27U0RauQCB2GvPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754423312; c=relaxed/simple;
	bh=KdApcye60KBOAgseekhcTCUxR2HPCy7XhIzXNeeDtAQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=NcN3eNKrT+AhNOmet8f3lmEx/pE+XVxdrxcldMqr5x4JUwWmBiI0aFaGXr8QLUUr+aGz+0anGyX5PudsTUNVf+4/dI7PeS1S5oUoYEDgMZGXNwsYsva/ePxXTgk0HvDxV57GclFVMYSIVuZLd4sJFCesM7LdCNrl748rcpSLqR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-88170a3df7aso321666139f.0
        for <netdev@vger.kernel.org>; Tue, 05 Aug 2025 12:48:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754423310; x=1755028110;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Zs2euGn0ah7qTMO3mciJ66QIxphpePyNs7NtHKNe+ZQ=;
        b=t0z8BVK6LUc+Z3CpbB0xKQrOMLi6Z2srOvH5uc4luIo/vaMJX4mhzLta/Q5D2vRsRQ
         7oduNjj+eLdT0rDCwTIZH8FIML8VCE4chOW9nZTTL1df1QpLX6uCNBs4u7um0IAd8rnA
         Sg04iRoaQZjHmrGrDMz4QpEWXh5qelNFu9mWaq4TC+dQ5eLc/fjzW0BGaWPlUXog9Jnr
         TnWCAmydRZQ4awGDoVwde2Od3o5SoZ8tZOk7TCXZrXBqaRr72YYkt+BrMmoyc38Q7a3E
         sqXECQ7urKpKU3oZoOjOf0SLl8p6lI2+Tu5DbZSS2sXx5kasAfvtuKrxdAMg+ntQ6C/m
         EJDg==
X-Forwarded-Encrypted: i=1; AJvYcCW07XpfGjrtmv8DtATEyb4IlSDZvuFMTfd50GZycBkkQmFXXNxb9I3kBf11yJCfEvMrxutSCL0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg1WketP4baUkESi7pdoGemBaNMK6g4/4tRZlcl4OMhG975ahX
	WAcJ9u6BhYYweYLPnz6/pFUfxxHoPEgNnxKf/ncD7iD28A9M5H4T5AtlRUHgbIHnYpcysF1nPwZ
	Hwcnxco7DkKoATRKE5SSlNE2uH7K6BZh3rvwe+oQvOrkpZQ7o8+jAYgoYLL4=
X-Google-Smtp-Source: AGHT+IEt+3Zjc5m/kisTeqXdfnZbP+4jV0np5AlLVJcR1JfEU9710iMC3OWxirj4xpUgpsROUFzfBr7fkTS4vkiONOUTsFUCib/v
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6088:b0:881:8186:60a1 with SMTP id
 ca18e2360f4ac-8819f14b253mr13869739f.11.1754423310426; Tue, 05 Aug 2025
 12:48:30 -0700 (PDT)
Date: Tue, 05 Aug 2025 12:48:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6892600e.050a0220.7f033.002f.GAE@google.com>
Subject: [syzbot] [wireless?] WARNING in ieee80211_teardown_sdata
From: syzbot <syzbot+04851834dc894437cf21@syzkaller.appspotmail.com>
To: johannes@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    89748acdf226 Merge tag 'drm-next-2025-08-01' of https://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1603e2a2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8b51b56c81c0761d
dashboard link: https://syzkaller.appspot.com/bug?extid=04851834dc894437cf21
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/095171b2ab97/disk-89748acd.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/48866e36b5ed/vmlinux-89748acd.xz
kernel image: https://storage.googleapis.com/syzbot-assets/be4634873fa0/bzImage-89748acd.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+04851834dc894437cf21@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 1161 at net/mac80211/iface.c:848 ieee80211_teardown_sdata+0xd2/0x140 net/mac80211/iface.c:848
Modules linked in:
CPU: 0 UID: 0 PID: 1161 Comm: kworker/u8:8 Not tainted 6.16.0-syzkaller-10499-g89748acdf226 #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
Workqueue: netns cleanup_net
RIP: 0010:ieee80211_teardown_sdata+0xd2/0x140 net/mac80211/iface.c:848
Code: f6 48 89 df 31 f6 31 d2 e8 db 99 00 00 48 81 c3 80 17 00 00 48 89 df 5b 41 5c 41 5e 41 5f 5d e9 54 ba 00 00 e8 bf b6 d6 f6 90 <0f> 0b 90 4c 8d bb a0 09 00 00 4c 89 f8 48 c1 e8 03 42 80 3c 20 00
RSP: 0018:ffffc900040df390 EFLAGS: 00010293
RAX: ffffffff8ae8cce1 RBX: ffff888038ab8d80 RCX: ffff888027048000
RDX: 0000000000000000 RSI: 00000000ffffff9f RDI: ffff888038ab8d80
RBP: ffffc900040df530 R08: ffffffff8fa1ba37 R09: 1ffffffff1f43746
R10: dffffc0000000000 R11: ffffffff8ae92c70 R12: dffffc0000000000
R13: ffff888038ab8c10 R14: ffff888038ab9978 R15: ffff888038ab8000
FS:  0000000000000000(0000) GS:ffff888125c5b000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fa038adcf98 CR3: 000000003edb8000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 unregister_netdevice_many_notify+0x1953/0x1ff0 net/core/dev.c:12177
 unregister_netdevice_many net/core/dev.c:12219 [inline]
 unregister_netdevice_queue+0x33c/0x380 net/core/dev.c:12063
 unregister_netdevice include/linux/netdevice.h:3382 [inline]
 _cfg80211_unregister_wdev+0x165/0x590 net/wireless/core.c:1275
 ieee80211_remove_interfaces+0x49a/0x6d0 net/mac80211/iface.c:2391
 ieee80211_unregister_hw+0x5d/0x2c0 net/mac80211/main.c:1664
 mac80211_hwsim_del_radio+0x275/0x460 drivers/net/wireless/virtual/mac80211_hwsim.c:5674
 hwsim_exit_net+0x584/0x640 drivers/net/wireless/virtual/mac80211_hwsim.c:6554
 ops_exit_list net/core/net_namespace.c:198 [inline]
 ops_undo_list+0x49a/0x990 net/core/net_namespace.c:251
 cleanup_net+0x4c5/0x800 net/core/net_namespace.c:682
 process_one_work kernel/workqueue.c:3236 [inline]
 process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3319
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3400
 kthread+0x711/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>


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


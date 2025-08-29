Return-Path: <netdev+bounces-218092-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5419B3B116
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 04:42:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E16DEA02605
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 02:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EB6F220686;
	Fri, 29 Aug 2025 02:42:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418832116E9
	for <netdev@vger.kernel.org>; Fri, 29 Aug 2025 02:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756435355; cv=none; b=TDX+khxQpuQvbW9q8s5daZx6dj2x7Z18mX1myaUcnHRQUywLnxAExGbIoiuWFNUYKog+ySvYoXvX/vi1i3TkfFFoILMURcZJmpv297U5OZCeb8JC8rFJ49xxlUkTrJtZbIY2w3Z24+3MOpH6AL+5gSR6Hw6MfVe9YtzUaraJgsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756435355; c=relaxed/simple;
	bh=xWJxueguMQhLsIKve4bRq5Qf69S8f3sgzGYw4AsUJ5w=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=NtKY0wU4OU5gH2P9ZDMjBbWPFEHvD2Awt0WV4nvH/O6Kl//La4jARqpclhJRLvW1pVSvHKg74BrtXbkCDZOzdBKJv6t2SY/0NQlQsXBE15/ckhqRB69aT4TYxuNKoCo3NMZVPd+r0Ra0tvMTc1yiac3gcUucz7QcP9SJ4PrqHVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3f2b8187ec9so4856405ab.0
        for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 19:42:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756435352; x=1757040152;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AteGbOaa6uA4s6skh8lWv95EhDpwAW/b1BRdwjUpNto=;
        b=jZGSlUWzKsmeYZs91bqRsnlh08GY+RDxNwUCKbbYbbYJUeyrUMC4MoIicrWMu8DpyE
         ItFsrgVckElIjNhMaA2NROw5GSwb5xPjvP0Ys7iVam5XtOY/v8iA9u8Lm/zgwzE40KSI
         YBn/SSDSzf5KN9b+iYyi2CA6WkhQo8tYM81EbbCBLKd2nF3rqouZCBLnD7+D3QDG2cQv
         mG1dyLU0SrA/jdmYllhjdgk3aOLVNKNonyjRRGAJavs8Jd7ezmdK8uikcfZH2CjnIg2q
         4OKtB8/BTWf+V5hzUlz2cHIevfuLXPoYD77Png3KZw4pUguqY5cOAgMe1eVlMS0AsZq3
         7ZIA==
X-Forwarded-Encrypted: i=1; AJvYcCVBIrYHhNksjIqqvpj61O15CR+1POle1McR6HG8c8+KgK4u+US2Vdp6UfR3OZyePacQrytP2gw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzraxiLuTHmMvtZAXjjarrYRovZOpEvzanPG146BNEgzX6OFvC1
	2/FgbLIMIWVZdkeVMnyG5q6A9erHaXz5u3HQz4pzlRoPmlVP12ql5uMNvCAZvQ3oh3C9qQlt1aI
	ETvDD+UpCYZtLzrtnIET9f2gB4H+YiScMBgZRalFgfjFvgNhbAHCvk7Nr7hY=
X-Google-Smtp-Source: AGHT+IFHUDxcHt1W98GIx6uHtmlsHUoWE8sKnOp8w7L0brcyKlravuX4LDKbCjUWObDHJGr678saE301vFPnor16vv+dl5/D6rRd
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3a06:b0:3f2:99cc:5247 with SMTP id
 e9e14a558f8ab-3f299cc5789mr21993645ab.14.1756435352468; Thu, 28 Aug 2025
 19:42:32 -0700 (PDT)
Date: Thu, 28 Aug 2025 19:42:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68b11398.a00a0220.1337b0.0012.GAE@google.com>
Subject: [syzbot] [wireless?] WARNING in ieee80211_set_active_links (2)
From: syzbot <syzbot+ab36888b82c02205065e@syzkaller.appspotmail.com>
To: johannes@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    69fd6b99b8f8 Merge tag 'perf_urgent_for_v6.17_rc3' of git:..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=167a6c42580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fecbb496f75d3d61
dashboard link: https://syzkaller.appspot.com/bug?extid=ab36888b82c02205065e
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/0010173ae06b/disk-69fd6b99.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/015ec9f0bead/vmlinux-69fd6b99.xz
kernel image: https://storage.googleapis.com/syzbot-assets/402b824d5994/bzImage-69fd6b99.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ab36888b82c02205065e@syzkaller.appspotmail.com

------------[ cut here ]------------
wlan0: Failed check-sdata-in-driver check, flags: 0x0
WARNING: CPU: 0 PID: 21522 at net/mac80211/driver-ops.h:1723 drv_can_activate_links net/mac80211/driver-ops.h:1723 [inline]
WARNING: CPU: 0 PID: 21522 at net/mac80211/driver-ops.h:1723 ieee80211_set_active_links+0x2d5/0x9d0 net/mac80211/link.c:600
Modules linked in:
CPU: 0 UID: 0 PID: 21522 Comm: kworker/u10:0 Tainted: G     U              syzkaller #0 PREEMPT(full) 
Tainted: [U]=USER
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
Workqueue: events_unbound cfg80211_wiphy_work
RIP: 0010:drv_can_activate_links net/mac80211/driver-ops.h:1723 [inline]
RIP: 0010:ieee80211_set_active_links+0x2d5/0x9d0 net/mac80211/link.c:600
Code: 74 24 08 48 81 c6 20 01 00 00 48 89 74 24 08 e8 91 13 b5 f6 8b 54 24 04 48 8b 74 24 08 48 c7 c7 20 eb 08 8d e8 0c 0c 74 f6 90 <0f> 0b 90 90 e8 72 13 b5 f6 4c 89 e2 48 b8 00 00 00 00 00 fc ff df
RSP: 0018:ffffc90003c3fb00 EFLAGS: 00010282
RAX: 0000000000000000 RBX: ffff888143bda9d0 RCX: ffffffff817a02c8
RDX: ffff888079fa3c00 RSI: ffffffff817a02d5 RDI: 0000000000000001
RBP: 000000000000000a R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: fffffffffffdf818 R12: ffff888143bd9728
R13: 0000000000000000 R14: ffff8880280e0e40 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8881246c3000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00002000001f2000 CR3: 0000000056f24000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 ieee80211_if_parse_active_links+0xbb/0x120 net/mac80211/debugfs_netdev.c:733
 wiphy_locked_debugfs_write_work+0xe6/0x1c0 net/wireless/debugfs.c:215
 cfg80211_wiphy_work+0x2c7/0x580 net/wireless/core.c:435
 process_one_work+0x9cf/0x1b70 kernel/workqueue.c:3236
 process_scheduled_works kernel/workqueue.c:3319 [inline]
 worker_thread+0x6c8/0xf10 kernel/workqueue.c:3400
 kthread+0x3c5/0x780 kernel/kthread.c:463
 ret_from_fork+0x5d4/0x6f0 arch/x86/kernel/process.c:148
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


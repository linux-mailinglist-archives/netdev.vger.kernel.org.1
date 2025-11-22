Return-Path: <netdev+bounces-240909-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 735A4C7BFDD
	for <lists+netdev@lfdr.de>; Sat, 22 Nov 2025 01:06:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33B353A6D77
	for <lists+netdev@lfdr.de>; Sat, 22 Nov 2025 00:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3382DDAB;
	Sat, 22 Nov 2025 00:06:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A0610F1
	for <netdev@vger.kernel.org>; Sat, 22 Nov 2025 00:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763769987; cv=none; b=TJbajeNvpydna867s1DVvi1UEfKY6yYLgj3rqNfSzd5zdjAsCIcEJdKKxfJbB4KLFBjqXFukrw7EDiJPPAiye2qJkcRWCA++iMO7iU9zsEm+CIxsOOi+BVixD+KYB9gc+GiLllZJmXeC56Vx8j4lR87sMmbatp3mzwyq7p0DRiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763769987; c=relaxed/simple;
	bh=QMqFHrLRF2sEwwhyJw8PKqwtIp5BOzl+dOzP3Jwtxqw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=e6szAxkdrdsgcvY17w5ei2YUPCdQD6/gScyJK2orQLJhtZPyip6izS4ZpvpvV8CprEAWBQAkGLAPv+/t/fZ6b1L3weOm8M/lObvGJflPszjOyaMuNOB9dDW3btcHXJ0K7uK6Ld4aHsLLt3PJP40Hc+srwd7rVSb1hyp3VfuNvlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-433817220f5so39078955ab.1
        for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 16:06:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763769985; x=1764374785;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jtvE0OLq9JMcVYo5nnhquCGv1ot2drpBn582H3Pz9lw=;
        b=aWlAZ9y0sGtrlH2eNFXqUQkFf70Yp5Wklkf51XgY7skGmp1T/3trswWO5hwhJ8M++r
         BnGOpKGDF6Il0tmDyROIlBgVQATlR0tugrfGlJmeziMVUtSxhUHvo+FFrzBHaghOy+Oq
         CRNnXsFzhuBB9DkiZrhcKUpcec72PzWB8xXmQWkvX5sL4DnqMrpRkrIgXSw8AriEcgbt
         UjG3lrwDR2F5/nM7N7e+lk43hJ3LOzc48TyNf7Kd2LtRNldhDX+htru3/HyqtaGC9agl
         TYwJmtzNPhM74g4GdIKRuHrSs8/ah7IQHbQB8BQckLjovdmM+9emia09wKizorCs9bum
         IbCQ==
X-Forwarded-Encrypted: i=1; AJvYcCVBhMs8udpbZYYH8+jp5y0kwyo9DZ8TgOmCSv1FNqN7VZ1SFeyyqfdp5CtS7N0CgcOT7inrAwc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLVu02KL944MbAX/VGC9/YtNcRhcF/PdJ5gpJGPdEMIV0/QdJh
	i8KgLDrN5A4sCMgdukcDoXAuL7kuUb4VCTwh1Lb30Uzck2RtedG11VJt3DuuRb6wPk0Al/qcsrd
	9WgNIbfsrhpfqnHfX+o3XtvhJ0anVBAKnvuHJW9h7Aw/idr+ZG3ca4xa35/A=
X-Google-Smtp-Source: AGHT+IE+QJmDDkGIgMAu8FHV3mLKf4AH8Af+8S5eu0cnacFRZHXH2fiHHjKL6EoCgmUWP0JtQY1lnUobdb/0DC8x3l6gQ62NIb37
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:221e:b0:433:1d5a:5157 with SMTP id
 e9e14a558f8ab-435b9052669mr38134895ab.6.1763769985215; Fri, 21 Nov 2025
 16:06:25 -0800 (PST)
Date: Fri, 21 Nov 2025 16:06:25 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6920fe81.a70a0220.d98e3.004f.GAE@google.com>
Subject: [syzbot] [wireless?] WARNING in ieee80211_mgd_probe_ap_send (3)
From: syzbot <syzbot+a59b5291776979816910@syzkaller.appspotmail.com>
To: johannes@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    6a23ae0a96a6 Linux 6.18-rc6
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=140fc8b4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=14b6a9313e132a6b
dashboard link: https://syzkaller.appspot.com/bug?extid=a59b5291776979816910
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/464c2673a9ca/disk-6a23ae0a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c2986bef024f/vmlinux-6a23ae0a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4077bdc25422/bzImage-6a23ae0a.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a59b5291776979816910@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 36 at net/mac80211/mlme.c:4406 ieee80211_mgd_probe_ap_send+0x4e5/0x590 net/mac80211/mlme.c:4406
Modules linked in:
CPU: 0 UID: 0 PID: 36 Comm: kworker/u8:2 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
Workqueue: events_unbound cfg80211_wiphy_work
RIP: 0010:ieee80211_mgd_probe_ap_send+0x4e5/0x590 net/mac80211/mlme.c:4406
Code: 41 5f 5d e9 2d f5 d7 f6 e8 48 04 eb f6 90 0f 0b 90 e9 0c fc ff ff e8 3a 04 eb f6 90 0f 0b 90 e9 4c ff ff ff e8 2c 04 eb f6 90 <0f> 0b 90 e9 a9 fc ff ff 48 c7 c1 90 1b 7d 8f 80 e1 07 80 c1 03 38
RSP: 0018:ffffc90000ac79c0 EFLAGS: 00010293
RAX: ffffffff8ad4ffe4 RBX: dffffc0000000000 RCX: ffff888143691e40
RDX: 0000000000000000 RSI: ffffffff8d8f4f27 RDI: ffff888143691e40
RBP: 0000000000000002 R08: ffff888143691e40 R09: 000000000000000c
R10: 000000000000000c R11: 0000000000000000 R12: 1ffff1100b1d6ba0
R13: ffff888058eb4d80 R14: ffff888058eb6ad2 R15: ffff888058eb5d00
FS:  0000000000000000(0000) GS:ffff88812613b000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000c3dfece CR3: 000000002e504000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 cfg80211_wiphy_work+0x2bb/0x470 net/wireless/core.c:435
 process_one_work kernel/workqueue.c:3263 [inline]
 process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3346
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3427
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x4bc/0x870 arch/x86/kernel/process.c:158
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


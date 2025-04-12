Return-Path: <netdev+bounces-181918-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DCA7BA86E8C
	for <lists+netdev@lfdr.de>; Sat, 12 Apr 2025 20:02:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 919C27B180A
	for <lists+netdev@lfdr.de>; Sat, 12 Apr 2025 18:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDF82207DF3;
	Sat, 12 Apr 2025 18:02:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273CF204C2E
	for <netdev@vger.kernel.org>; Sat, 12 Apr 2025 18:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744480949; cv=none; b=mjIbyvb/MxdclB0JBYKGqtdafLr7TzAn98jthRK17rvfvNQuptwGRw2D0iNy2zSGC6r3PtS3hMzaq7rHDTvXUpEs70u81HqR6WP+G0wCwmbRNz6QTnGsVw9Kidg+jluGwgs52eqrdGcr2BYWJkqTQfdsF6dsD6f6xpC373Yl5UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744480949; c=relaxed/simple;
	bh=51Ad6r55zIAG2EioKgN8jkjfbb/A9nkqo41EgfyFvYg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=EfF7ccXFsjvnPjFR2EmL2L0YjVFr03zOtqNXBTmcGSupeUimSlXJ2c+iAoZ9QRdEF1GVV7NoGRxKiS5o9mFYkhjtRHg7zewd4f9i3fGBeFIpN90ymbrkmVSP8ru9ZIs0gGD9TGHprBSl21W6Sl5Nyf8XRcaJL2+Ajqrksuw9+nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-85b5875e250so322352939f.0
        for <netdev@vger.kernel.org>; Sat, 12 Apr 2025 11:02:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744480947; x=1745085747;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fe+O5X3r6SXWE9Xvanh9Ftrt+hAejIQy/QtT92rJ4wU=;
        b=noJnD9SlDfrAZBTIAUVm5/SEpGvKPZ0ggZ9BiD1kacLeT8b0s3Dr1MqfAmVocleXkx
         3fX4AvsjL9R5MYWc9o5i1ZSfQRK8B2L1QepYKDeBHBAeB6AFXZIZhtZLdISjEhAgbzgv
         xIrIDAyPXLv19iuVs4x+rTCUxvwKYfcP/eHN2v3vSB7Ps7+RXTgDPDiMd97fkw34SP/H
         Sv5aFMDOZsfKgPIqz5xBPbL0nitk5R/iXcyh1jZO2dW8xBCfr3UP+wSvpUJj0JcvxatM
         q94l9nPteVUDuqSz1o3+16HLN+bMdShrQbfwjVrkmnhLr66KMS/eQBJhCG8s8+lzGN64
         jw9w==
X-Forwarded-Encrypted: i=1; AJvYcCWYh4W9hymhhBlgjAzGo3niu4BtfBq2FNiXldNDPaPmaaZg5BTaJbMFF78Z9NjVs3r/Jta+MVs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2nXwE0+GX+yH4HN7CjUbDjQa+RUP+V9fLweoHoJKdHwc9c+iK
	OpFv975gazJODPN98oDmlBvH24T0y+i8U9iHMkS56EAbJp+d5eSooFyBLbZDEpsg8XK2fOhUlZm
	+7XUsDA0MhlMKzH+tQ/VNYni9kElmWRtzfdMbbyGBT443ATJfF6jt7MM=
X-Google-Smtp-Source: AGHT+IFN36koIlXi41ZK1slAgvmoyJYabtpGq7hCsPVV1D36KAqcUx8gvKbjCcIBOlwz9AqxDs5S+Hu2wd34/QEqct/YNVF3Xtsl
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1582:b0:3d4:414c:6073 with SMTP id
 e9e14a558f8ab-3d7ec1fd045mr77368445ab.8.1744480947121; Sat, 12 Apr 2025
 11:02:27 -0700 (PDT)
Date: Sat, 12 Apr 2025 11:02:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67faaab3.050a0220.379d84.0011.GAE@google.com>
Subject: [syzbot] [wireless?] WARNING in drv_set_tsf
From: syzbot <syzbot+a90b13f34919c4086030@syzkaller.appspotmail.com>
To: johannes@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    0af2f6be1b42 Linux 6.15-rc1
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=161cb74c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d444e5269179368a
dashboard link: https://syzkaller.appspot.com/bug?extid=a90b13f34919c4086030
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8909dc8a51ee/disk-0af2f6be.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e216afa338a8/vmlinux-0af2f6be.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4d21115804e3/bzImage-0af2f6be.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a90b13f34919c4086030@syzkaller.appspotmail.com

------------[ cut here ]------------
wlan0: Failed check-sdata-in-driver check, flags: 0x0
WARNING: CPU: 1 PID: 83 at net/mac80211/driver-ops.c:272 drv_set_tsf+0x2c1/0x590 net/mac80211/driver-ops.c:272
Modules linked in:
CPU: 1 UID: 0 PID: 83 Comm: kworker/u8:5 Not tainted 6.15.0-rc1-syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
Workqueue: events_unbound cfg80211_wiphy_work
RIP: 0010:drv_set_tsf+0x2c1/0x590 net/mac80211/driver-ops.c:272
Code: 0f 84 7c 02 00 00 e8 3e c3 dc f6 49 81 c5 20 01 00 00 e8 32 c3 dc f6 44 89 fa 4c 89 ee 48 c7 c7 a0 4c e4 8c e8 10 55 9c f6 90 <0f> 0b 90 90 e8 16 c3 dc f6 4c 89 f2 48 b8 00 00 00 00 00 fc ff df
RSP: 0018:ffffc9000156fb10 EFLAGS: 00010286
RAX: 0000000000000000 RBX: ffff888028bfcd80 RCX: ffffffff817ad098
RDX: ffff88801d788000 RSI: ffffffff817ad0a5 RDI: 0000000000000001
RBP: ffff88807a980e40 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000001 R12: 0000000000000001
R13: ffff888028bfc120 R14: ffff888028bfd728 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff888124ab9000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b30e0cff8 CR3: 0000000063c06000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ieee80211_if_parse_tsf+0x2c8/0x560 net/mac80211/debugfs_netdev.c:701
 wiphy_locked_debugfs_write_work+0xe3/0x1c0 net/wireless/debugfs.c:215
 cfg80211_wiphy_work+0x3dc/0x550 net/wireless/core.c:435
 process_one_work+0x9cc/0x1b70 kernel/workqueue.c:3238
 process_scheduled_works kernel/workqueue.c:3319 [inline]
 worker_thread+0x6c8/0xf10 kernel/workqueue.c:3400
 kthread+0x3c2/0x780 kernel/kthread.c:464
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:153
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


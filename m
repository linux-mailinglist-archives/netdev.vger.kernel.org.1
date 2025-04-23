Return-Path: <netdev+bounces-185011-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 25119A981A6
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 09:53:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3F6C7A250E
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 07:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53D5E26E16A;
	Wed, 23 Apr 2025 07:51:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4E626B08D
	for <netdev@vger.kernel.org>; Wed, 23 Apr 2025 07:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745394692; cv=none; b=LVq84HbQSQk3qZ1rZ+iXWeraJjyfOwHt/j4hH5QT8gnnabMSmU5/A8IYTjO1xMvvqAkaZ2JgUax8TJn2UZC94THC8PjxcTBmrv1hrrie2X7bDOUVfK4YbU/9ywCM8209C2tIkGncG3Bb1LCMXKr+JqWuWWM7elYPtB5k6GkpHH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745394692; c=relaxed/simple;
	bh=JVM+D2cPD5kJCHNUnkFYFbPV/xrj7r3Yu2JBXWM/bAw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ePHIYdlTBPpdox8T9yhqJRkqojzCBwVxcyjhbYzrS7BFHTEs7NgpWyKvtxIM2tmsIdIrBM/LmngCYI5J2rNtOkfU6YrO8N3AshKQoLzjJj9XClecGcN3HLUiBUR/2pBN0LLhYAu+hePOfKaLjear6S4ZfluR+TcLLvOcbOpwsa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3d90a7e86f7so86929175ab.2
        for <netdev@vger.kernel.org>; Wed, 23 Apr 2025 00:51:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745394689; x=1745999489;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ndzc6o3PQmddI86XNaY5hOBgE+u1I/s9h4gsKtPCnXA=;
        b=ogorzUITKxm4Xm7Vt/Or/PuV1JKYeYahvRdbA8TI6OhjJcMYzTvUVAE97vCu97mjmF
         lvWlPJHoAASmfq8qOlo91sI4Ntb7GqFnfp56hV8kZwlBJM0sdynt1bJWeaIKhWSLbaY2
         RlO2UkLEWb89hD1L2iVhocLbfuQV/uQhfJXZYqR3lZo5qXe0vmd9HR9s+4y/d4qpa+2S
         Qy0kEnNuGOYV4ORyCK/IKyWkQ5td+/kQ9dIcERvFaOz79UpAeAgBYGN/z4/2l2g4RaF8
         MW8hqx/jYcdvyfFyofDxPaNQoDH0GyGJTCmtY144YCFn7eBh7ZWALZ8m9mupkW1gTXrK
         IjzA==
X-Forwarded-Encrypted: i=1; AJvYcCWbnb2R1Fkqvvf3/HI/kVkTkVQmX3E/OuJVpNpH/9aqBIKvsjIWOWyA80QY8vDigB36YgzYysE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9ZjRVpAP81FLcNufy+bXZSD+UTchxGXnLRGNy2XekDlBsEqJp
	oir6FMJNbdjTVscE2oAfgzo3jVbg7r5B+wRZZp+wNyOvxVbhY9Yxht2ifJm0FPUXL7aMFgGB8y/
	QjbjckHcGf43xCmHK5ptsaJe6HVYjblPUTVJdUbJCatSNpgjWB+GCBTA=
X-Google-Smtp-Source: AGHT+IG5YLRkPk6ll0iD2rCSjwKFuFfurI2t2jOfecpW+WGCbVLdc1PkvWWxpmLjuN7Eii/AIBDV3eP249+/8w8J/XBuHeUt6u3x
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1946:b0:3d8:1d7c:e192 with SMTP id
 e9e14a558f8ab-3d88ed8839bmr182605365ab.7.1745394689606; Wed, 23 Apr 2025
 00:51:29 -0700 (PDT)
Date: Wed, 23 Apr 2025 00:51:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68089c01.050a0220.36a438.000f.GAE@google.com>
Subject: [syzbot] [net?] KASAN: null-ptr-deref Write in dst_cache_per_cpu_get (3)
From: syzbot <syzbot+c71bf8ad5b74c29baa2f@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    fc96b232f8e7 Merge tag 'pci-v6.15-fixes-2' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1049063f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=170d968a88ba5c06
dashboard link: https://syzkaller.appspot.com/bug?extid=c71bf8ad5b74c29baa2f
compiler:       Debian clang version 15.0.6, Debian LLD 15.0.6

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/fd977d7e57de/disk-fc96b232.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ffa0a3b5b655/vmlinux-fc96b232.xz
kernel image: https://storage.googleapis.com/syzbot-assets/44df3bd100d2/bzImage-fc96b232.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c71bf8ad5b74c29baa2f@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: null-ptr-deref in instrument_atomic_read_write include/linux/instrumented.h:96 [inline]
BUG: KASAN: null-ptr-deref in atomic_add_negative_relaxed include/linux/atomic/atomic-instrumented.h:1475 [inline]
BUG: KASAN: null-ptr-deref in rcuref_get include/linux/rcuref.h:67 [inline]
BUG: KASAN: null-ptr-deref in dst_hold include/net/dst.h:238 [inline]
BUG: KASAN: null-ptr-deref in dst_cache_per_cpu_get+0x7d/0x2b0 net/core/dst_cache.c:50
Write of size 4 at addr 0000000000000043 by task kworker/1:0/24

CPU: 1 UID: 0 PID: 24 Comm: kworker/1:0 Not tainted 6.15.0-rc2-syzkaller-00278-gfc96b232f8e7 #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
Workqueue: wg-crypt-wg2 wg_packet_tx_worker
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_report+0xe3/0x5b0 mm/kasan/report.c:524
 kasan_report+0x143/0x180 mm/kasan/report.c:634
 check_region_inline mm/kasan/generic.c:-1 [inline]
 kasan_check_range+0x28f/0x2a0 mm/kasan/generic.c:189
 instrument_atomic_read_write include/linux/instrumented.h:96 [inline]
 atomic_add_negative_relaxed include/linux/atomic/atomic-instrumented.h:1475 [inline]
 rcuref_get include/linux/rcuref.h:67 [inline]
 dst_hold include/net/dst.h:238 [inline]
 dst_cache_per_cpu_get+0x7d/0x2b0 net/core/dst_cache.c:50
 dst_cache_get_ip6+0x8c/0xf0 net/core/dst_cache.c:133
 send6+0x466/0xbf0 drivers/net/wireguard/socket.c:129
 wg_socket_send_skb_to_peer+0x115/0x1d0 drivers/net/wireguard/socket.c:178
 wg_packet_create_data_done drivers/net/wireguard/send.c:251 [inline]
 wg_packet_tx_worker+0x1bf/0x810 drivers/net/wireguard/send.c:276
 process_one_work kernel/workqueue.c:3238 [inline]
 process_scheduled_works+0xac3/0x18e0 kernel/workqueue.c:3319
 worker_thread+0x870/0xd50 kernel/workqueue.c:3400
 kthread+0x7b7/0x940 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:153
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
==================================================================


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


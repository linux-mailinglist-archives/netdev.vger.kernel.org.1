Return-Path: <netdev+bounces-137387-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B85B9A5EBE
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 10:36:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B0351C215EC
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 08:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 710F51E1C07;
	Mon, 21 Oct 2024 08:36:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72DB41D0F76
	for <netdev@vger.kernel.org>; Mon, 21 Oct 2024 08:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729499793; cv=none; b=Vf3oYhzzTaM6j3NdMhdQ3KE1S5PJNc4ar0CFyRuk6ymK5U7nOVvIhY/ks2CD0Mi8aSnah9p8NUAv3hCtA73AJGoJg2GM1+VOspd3T1WB+z/li5YF5MjbGpo/80Z1YTZO7s51nJKhwOehOVpyjBl5Cbs+lkHul390SumleeZ2h3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729499793; c=relaxed/simple;
	bh=UR/eFMFtYxFbWibbF8Q/80OBKdTt8vA31g1qMtYDjHs=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=cmGleB30u3/45te38yNDDIqVeRTJaUN01uUq/VTGm1rnyXwUPsJPcQ3V6Ayq/J8SASwB7pBzdGBRSg7HIvcug1CF5hDGsVCI2pYNy3Qs9DjQtP4kQtsksaz8FjIyBfkuCsiyHv5UKrQWAGzaXtBQ9Y8hfxaZrNydZc2BsGl+lz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a3ae775193so42714535ab.1
        for <netdev@vger.kernel.org>; Mon, 21 Oct 2024 01:36:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729499790; x=1730104590;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AU6BONPz4GZja+CAfK/WgEnWDQjALr4o8WVnrA+Tz6I=;
        b=CVN7RytTEmPTLgy2/xDAnTUEgZ1isyCqvP+5k++0MX90xxC9jxujkYGwQL0aMbHUmy
         NFbsTk8oTv0uSWMNC7xBGNvv8ddBV8n7YAxrUBCM0WhmtbPJ9zBPBDSYylZ005d0xdr8
         7gZB5Df37iIns9EHvfLtNtQ1QiiDYI8duyZEMxnSWbjeHxslhvc9BPSpoY1WFoSTIvSu
         dPL/JsBT1820GTewgHGG6542B24OuAAdGxlALSdyzMD0ZH0OZyT0TZ9HDVKQk3gkwKZ2
         mv3jNYChOJst1otiGdIMQmcN/j8y8/HlWOGmMu0Ngy37ZOWsXwXqB5lY8GyZRWL1xJZs
         UW4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVZXa1gux0Fn5oaYXWxLN68BU2veZUw7sl/a2TnBA9qnNKCO9RliHJgHOygrtuu36Uxyc4ZTbo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxitG+3o+XEMGKIi98RocyWPy+IQ6ecszXpm911QLn6tJR6g2XL
	6bsoVblNaIrBlN73eENDgXtvHgl7LU3HV50cWf7PCBsqKi7oGcbil/+8CIF+BRgIFy2/Fewq+xE
	hg60v3GDqW3HgcJRpS+Rs/cSM7lTw+FoeRVxU3KF3mYTErPpZrRbODIw=
X-Google-Smtp-Source: AGHT+IGzF32Vs2zfAM9AJGOtYsTIo2pxG3wmoCo3t6XQjvJkpvEKo0SJZJ1W7gNrsI9Gq+tUHmE3SHFxOrkJP5ehlM/YEHbO4vx6
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fe5:b0:3a3:49f0:f425 with SMTP id
 e9e14a558f8ab-3a3f3fd0bc2mr91852205ab.0.1729499790597; Mon, 21 Oct 2024
 01:36:30 -0700 (PDT)
Date: Mon, 21 Oct 2024 01:36:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6716128e.050a0220.10f4f4.0040.GAE@google.com>
Subject: [syzbot] [kernel?] BUG: workqueue leaked atomic, lock or RCU: kworker/NUM:NUM[NUM]
From: syzbot <syzbot+21814e89fd126bbfb79c@syzkaller.appspotmail.com>
To: bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	linux-kernel@vger.kernel.org, mingo@redhat.com, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    09cf85ef183a Merge branch 'ipv4-namespacify-ipv4-address-h..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=14bc2b27980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=97682d9a9859be7a
dashboard link: https://syzkaller.appspot.com/bug?extid=21814e89fd126bbfb79c
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f07fbcff269f/disk-09cf85ef.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/27b386159ee2/vmlinux-09cf85ef.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0d9909f42c33/bzImage-09cf85ef.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+21814e89fd126bbfb79c@syzkaller.appspotmail.com

BUG: workqueue leaked atomic, lock or RCU: kworker/0:4[5280]
     preempt=0x00000000 lock=0->0 RCU=0->0 workfn=nsim_dev_trap_report_work
INFO: lockdep is turned off.
CPU: 0 UID: 0 PID: 5280 Comm: kworker/0:4 Not tainted 6.12.0-rc1-syzkaller-00360-g09cf85ef183a #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Workqueue: events nsim_dev_trap_report_work

Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 process_one_work kernel/workqueue.c:3250 [inline]
 process_scheduled_works+0x1158/0x1850 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
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


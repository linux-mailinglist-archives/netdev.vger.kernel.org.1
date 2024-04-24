Return-Path: <netdev+bounces-90771-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE69C8B0094
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 06:32:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B709282989
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 04:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72C06152E1C;
	Wed, 24 Apr 2024 04:32:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41A9152DE3
	for <netdev@vger.kernel.org>; Wed, 24 Apr 2024 04:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713933147; cv=none; b=rHQ9SQtTMFyG46wSmp5uhSUcqiSv42isXpp6jn1Q94mfquFsdO3SxpeklnBDJoSxQfPhWBZGmIbYrgPB0qkPj+OAQgNF0B90DVFm6Ew7zfmYEjwqEbcsr6yefItgFTjUDqhL/tdwNC9IFl3abe01oqdZ6+MNWLtTGg30zhCD0rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713933147; c=relaxed/simple;
	bh=/LCrrqzmvWiGPIZB22bQ5ZYR27Ggafk91ccmd/t9HzA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=MNQECuhFqvG23Ayu9SeQbPZ6Hxfp4fELjKKvSN+X9SHf/h8OG4/6sAg53t3FOIqwCxqYZiENdygbrvJaw/60DwuWHXV9E73GCh2UNoWJPtPullM0dU+6Xbm0KPkI0AcbgiL1Wm7ryo6wawpzi/2mwgc4VjEb4S4cBCeJyRXfSMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7de874ec95bso85493739f.2
        for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 21:32:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713933145; x=1714537945;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j7F9q8LKnGslbaDCEPZim7I8bSQ7WXorVsXiaYhSXFk=;
        b=cIeFwpfc8VFe3wK+vsAuoWe3SwX401r8Hj8VejgCI8rPWofImxYh9QG3/uj7G5G1Kc
         9u0H3GzBJ7zvOCvb80QeagqY4leCezTELgu0ZBh+oBrqgPlK+bwlBJ8Yyca9yyjwZcme
         ywiXl/Li1ai4q+KBURO+kNiPao9pnXkxWjzxDZQFZaOFSx4sQduAx9Au8NC+VGRiEoa6
         8W4YCeTQv1cCRpHn4RKSFNsgt5zcpC60pXXaNeTjBDKe0C5v46mXka52INipUxGenpIX
         cKoHdw2Zb51WPASfr92C1383pNgh8jmYQzWrWqh/YjIuqDpN6lsJEIqALC5BhSdLIkkA
         JN9g==
X-Forwarded-Encrypted: i=1; AJvYcCXvV/A0tQsHbW7zgjFTDUHVTcLvSNQA/I+tckQjiIfyszwH4917Fw7VzWbbz1v8pJzi8CS8sQPnbE5SKBdZ2QppEOKVPz2c
X-Gm-Message-State: AOJu0YzlaOufqf81DvlT9b83qowkBbnS8xKSjDXhRO5yKxO717YA/f6U
	Znymzms3Ygkd9eds+juNALKyTKjGjFBcm8oRELRuEv7G7V8gP56oR0WmEh5I1a53oX6qLxw0Fzt
	tRbe4sUYPaddxt9O7fnO6AKgVrsfE6SKSfSqbSMvj2A7fDdApqOBDNV8=
X-Google-Smtp-Source: AGHT+IGll4l2W8rp8JECph6mthKpERioCEdWuyBfxXzO5GWc08oqoE0bx7wc2f5zOmRcOwtx9ZvbtgC/6Bzcpbbq7glgNbUu3dhO
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:830b:b0:485:7a8:4294 with SMTP id
 io11-20020a056638830b00b0048507a84294mr179480jab.1.1713933145214; Tue, 23 Apr
 2024 21:32:25 -0700 (PDT)
Date: Tue, 23 Apr 2024 21:32:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004a20330616d0280b@google.com>
Subject: [syzbot] [wireless?] INFO: task hung in reg_check_chans_work (6)
From: syzbot <syzbot+b87c222546179f4513a7@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, johannes@sipsolutions.net, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    3cdb45594619 Merge tag 's390-6.9-4' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12383e07180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=85dbe39cf8e4f599
dashboard link: https://syzkaller.appspot.com/bug?extid=b87c222546179f4513a7
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11449c27180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1749866f180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/04e2e4bee9fb/disk-3cdb4559.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/65456769dc43/vmlinux-3cdb4559.xz
kernel image: https://storage.googleapis.com/syzbot-assets/09504bbdec9e/bzImage-3cdb4559.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b87c222546179f4513a7@syzkaller.appspotmail.com

INFO: task kworker/1:0:5088 blocked for more than 143 seconds.
      Not tainted 6.9.0-rc4-syzkaller-00173-g3cdb45594619 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/1:0     state:D stack:23744 pid:5088  tgid:5088  ppid:2      flags:0x00004000
Workqueue: events_power_efficient reg_check_chans_work
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5409 [inline]
 __schedule+0xf15/0x5d00 kernel/sched/core.c:6746
 __schedule_loop kernel/sched/core.c:6823 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6838
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6895
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x5b8/0x9c0 kernel/locking/mutex.c:752
 wiphy_lock include/net/cfg80211.h:5953 [inline]
 reg_leave_invalid_chans net/wireless/reg.c:2466 [inline]
 reg_check_chans_work+0x10a/0x10e0 net/wireless/reg.c:2481


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


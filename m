Return-Path: <netdev+bounces-68518-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A6E3847116
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 14:26:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88C8EB221FC
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 13:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A3574653A;
	Fri,  2 Feb 2024 13:26:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD1447773
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 13:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706880390; cv=none; b=f9cSNoEHWKmkvj4FTiHxTTH9eab1Ev1zmhjeGpV9CuSpGA7dpK1TrI5P9Dhg2trIkzxxw8Q9M2z5j5RZ11NkXrPmJLGKY/28cylXd9P03OpuTDNa+eAq9oQOvOXHpePP3spU2BfYPuuK87pTOu1hAtuXiyjG39BS8cX/D5SqUeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706880390; c=relaxed/simple;
	bh=n9JAP/MRpfuDlRnB3q/7KienYimz56drRy6yjpqGNBk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=sey4DKG0rHVuO9rOsXqGTEFhfOMkcTAwURv20ZJzJnW1/du79lq3mr1Co7R8fsl/KcdvZCiNvsCs7qa7XwUmnpBj9z1Vf0abVssb7J95c08hcAtelIJxvl7Ssdp9vKrcQ7myWdGIlb1nN7MlRq0O5oS24gP3ZND8tycak3V764I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-363b68b9af3so2970375ab.1
        for <netdev@vger.kernel.org>; Fri, 02 Feb 2024 05:26:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706880388; x=1707485188;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t+8zk0DPxSwGdy+YMmgcVYuZNR2H0MyRvo5x5YvaCG0=;
        b=apvoKzZEmViORFT463F0RVlRbTLkRDRueYKtg1E0DdUUZbE1GA56KHhz1DnaNCPdjB
         PTZD8UcKfobXo4UTPenOpYrfTXzWG291b4T857Q8irpAic+JyG+Jmzy4zmhOcBp+8Eog
         dvEdJcwo2jmzBDGGWtK75DpBD+T01uync7TvaQ7+I9jGZZcwpxgriT0+6VG6zKIQIQg9
         tbjU8NUX0m4KJxJUfgEiwaOF+OiNgqazd5m6JzEfFV2ZRSu0Yi2yBO+K/0adMxj6ELl+
         a/O+EzVE+TvNujMC+PgsbkxCwJ1B7r39EuAKuepgvezQMFH2aXwqMHRULBXjdUDh2O0a
         icHQ==
X-Gm-Message-State: AOJu0YxgznkRddJqc4a4ojlYRAloB9poC9EgH3Zfar3rJdPE3k2EaUET
	Xs9gi4h/hEvPFg5WJwYUtmHjKZj8B1yi/4Vdr2VPyR07ioWrqtJYSu/PE0WnqaxJu7dlDbF5/7u
	y42b/A0RDT2c/NTw0kAzmb/6sMtbYzz/qHl4xzLFhgkreXd9mbhUJZPw=
X-Google-Smtp-Source: AGHT+IGeMcAl+YvWdQim1puPV6Vi/BUNQHcuzFmK7ymNoj2p5MDHFDMkujeWg/LdxLn1mItztoiLwD79SpyWQhyAPQ8viWGdhvh7
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:216b:b0:363:8e31:7667 with SMTP id
 s11-20020a056e02216b00b003638e317667mr707995ilv.3.1706880388123; Fri, 02 Feb
 2024 05:26:28 -0800 (PST)
Date: Fri, 02 Feb 2024 05:26:28 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003555920610660fbc@google.com>
Subject: [syzbot] [net?] WARNING in __unix_gc
From: syzbot <syzbot+fa3ef895554bdbfd1183@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    1701940b1a02 Merge branch 'tools-net-ynl-add-features-for-..
git tree:       net-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=15cbca88180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=43ed254f922f56d0
dashboard link: https://syzkaller.appspot.com/bug?extid=fa3ef895554bdbfd1183
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11b512ffe80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12d6927be80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/00090c03ed53/disk-1701940b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/fc03bbe45eb3/vmlinux-1701940b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/8a5b859954ca/bzImage-1701940b.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+fa3ef895554bdbfd1183@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 2863 at net/unix/garbage.c:345 __unix_gc+0xc74/0xe80 net/unix/garbage.c:345
Modules linked in:
CPU: 0 PID: 2863 Comm: kworker/u4:11 Not tainted 6.8.0-rc1-syzkaller-00583-g1701940b1a02 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
Workqueue: events_unbound __unix_gc
RIP: 0010:__unix_gc+0xc74/0xe80 net/unix/garbage.c:345
Code: 8b 5c 24 50 e9 86 f8 ff ff e8 f8 e4 22 f8 31 d2 48 c7 c6 30 6a 69 89 4c 89 ef e8 97 ef ff ff e9 80 f9 ff ff e8 dd e4 22 f8 90 <0f> 0b 90 e9 7b fd ff ff 48 89 df e8 5c e7 7c f8 e9 d3 f8 ff ff e8
RSP: 0018:ffffc9000b03fba0 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffffc9000b03fc10 RCX: ffffffff816c493e
RDX: ffff88802c02d940 RSI: ffffffff896982f3 RDI: ffffc9000b03fb30
RBP: ffffc9000b03fce0 R08: 0000000000000001 R09: fffff52001607f66
R10: 0000000000000003 R11: 0000000000000002 R12: dffffc0000000000
R13: ffffc9000b03fc10 R14: ffffc9000b03fc10 R15: 0000000000000001
FS:  0000000000000000(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005559c8677a60 CR3: 000000000d57a000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 process_one_work+0x889/0x15e0 kernel/workqueue.c:2633
 process_scheduled_works kernel/workqueue.c:2706 [inline]
 worker_thread+0x8b9/0x12a0 kernel/workqueue.c:2787
 kthread+0x2c6/0x3b0 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1b/0x30 arch/x86/entry/entry_64.S:242
 </TASK>


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


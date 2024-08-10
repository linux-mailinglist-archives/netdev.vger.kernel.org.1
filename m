Return-Path: <netdev+bounces-117409-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F059094DD0A
	for <lists+netdev@lfdr.de>; Sat, 10 Aug 2024 15:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 730671F21747
	for <lists+netdev@lfdr.de>; Sat, 10 Aug 2024 13:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ABE322339;
	Sat, 10 Aug 2024 13:20:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0887C1BDC3
	for <netdev@vger.kernel.org>; Sat, 10 Aug 2024 13:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723296023; cv=none; b=r2mOvl7uoSl9tEaOfwbTp1fKUjKkJNPHs4AI2GaMnCB0C/ipjrRNkdgujgSFzP+b+xsvtlBhWdfOBJ7G5t1DHDFnklWW1H8BDbFMF6yMwzTDlDHYrYgDjFnUpEbcMlNmQu+UUFkFuGdRBiYZ1pWIb+N2QNDvCkt+ey+s6FhCmz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723296023; c=relaxed/simple;
	bh=19oEkv1/eaXy2nNZjx2J+oCUrbBZbMQbjfsOTbXIALw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=LxpcsgzPVAnJ6aiYSbMHCWjQDTpyqeqwTZcLhjDQZS42LeorfyqQK8Vsd6qsaJ+Xee6MWyWTWztOnzC4Gzo8sBwyI47vYFxaZiCzzYTeuEElWrlLAh8Z9SjU4k3reVVY5OrScGaXsMQg/hUOYc0L4XdLoudngIuy6hNJobEPopI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-39b2938b171so35963605ab.0
        for <netdev@vger.kernel.org>; Sat, 10 Aug 2024 06:20:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723296021; x=1723900821;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Tf5N057z2TxyRabMrpFMuIe/31O3a+xUE+vz0NvPDlQ=;
        b=qtjYvPFMUCikUnDb8dOM05zTagpS5+Ivxk1yiwhh8Hoxibb5bFFrE5kNICyb0RCRD/
         VHE+VuzbMrGFPp3O1QsF9sf2gLdN69kfdMc75Xh2x1F+10NXsW62lqQHc8kWRNjmgdBo
         uqrRZsxNwvp/y6SPwFDhmT13FALA3UbNy3yHC/zx9s5hIXFi8/0rd4yKfHkCDn+WSOMJ
         ADK9jEli32GLhxHmUXIlD+yhDGfxqOqBWKcecCQEbGbGpm9HIXHO9DsFGnyf03EesYJL
         2X8oIyAtJwqMk12WZAKtZk2ptRO/B/98ItnSFxbgIOBBOAEza7kW8Wfx7Yk8O+W7eFre
         USUA==
X-Forwarded-Encrypted: i=1; AJvYcCXRlwzvpe+lugclSnjX6cjkVR+GCjTYFEzM1OQ3uJ2K//4YsBIIAzJ8m/zcIkYGPGemvbzwr9c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZ9xsUXbwe1eKaMmLOi53168KgiPR6nQf+gRoIvLwbTOiicUIM
	u8/VM+uKmU7JU3jqMhNZ02FcR89geVQ3lCFE/a9YkjefWztMLeB3uL+p6cBk6w/tizyai1HKQfb
	wB4h33fOfjnfAlYczR5aKjLJ/l90uQVK7UJK7AOYCEh3XSX5adnC6mtQ=
X-Google-Smtp-Source: AGHT+IHllZM4Et292r1oIa+zpIpSzAfPRc5d735oMXHvmC4FdYCNjl7Fpl2RVeZslYTd2vsjmbRyS0Gy5utuaFGlboA7wwJO/1MW
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d0b:b0:398:d1fe:9868 with SMTP id
 e9e14a558f8ab-39b7a75252dmr3456555ab.4.1723296021137; Sat, 10 Aug 2024
 06:20:21 -0700 (PDT)
Date: Sat, 10 Aug 2024 06:20:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002edcf0061f541f85@google.com>
Subject: [syzbot] [net?] WARNING in l2tp_udp_encap_destroy
From: syzbot <syzbot+1ff81cc9c56e63938cf9@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    eb3ab13d997a net: ti: icssg_prueth: populate netdev of_node
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=13589dbd980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e8a2eef9745ade09
dashboard link: https://syzkaller.appspot.com/bug?extid=1ff81cc9c56e63938cf9
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/451ec795f57e/disk-eb3ab13d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e6f090c32577/vmlinux-eb3ab13d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ac63cb5127b1/bzImage-eb3ab13d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1ff81cc9c56e63938cf9@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 13137 at kernel/workqueue.c:2259 __queue_work+0xcd3/0xf50 kernel/workqueue.c:2258
Modules linked in:
CPU: 0 UID: 0 PID: 13137 Comm: syz.1.2857 Not tainted 6.11.0-rc2-syzkaller-00271-geb3ab13d997a #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
RIP: 0010:__queue_work+0xcd3/0xf50 kernel/workqueue.c:2258
Code: ff e8 41 85 36 00 90 0f 0b 90 e9 1e fd ff ff e8 33 85 36 00 eb 13 e8 2c 85 36 00 eb 0c e8 25 85 36 00 eb 05 e8 1e 85 36 00 90 <0f> 0b 90 48 83 c4 60 5b 41 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc
RSP: 0018:ffffc900042b7ac8 EFLAGS: 00010093
RAX: ffffffff815cf254 RBX: ffff88802a4abc00 RCX: ffff88802a4abc00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffff815ce6b4 R09: 0000000000000000
R10: ffffc900042b7ba0 R11: fffff52000856f75 R12: ffff88802ac9d800
R13: ffff88802ac9d9c0 R14: dffffc0000000000 R15: 0000000000000008
FS:  0000555569316500(0000) GS:ffff8880b9200000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b3291aff8 CR3: 0000000074d8c000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 queue_work_on+0x1c2/0x380 kernel/workqueue.c:2392
 l2tp_udp_encap_destroy+0x2a/0x40 net/l2tp/l2tp_core.c:1323
 udpv6_destroy_sock+0x19e/0x240 net/ipv6/udp.c:1683
 sk_common_release+0x72/0x320 net/core/sock.c:3742
 inet_release+0x17d/0x200 net/ipv4/af_inet.c:437
 __sock_release net/socket.c:659 [inline]
 sock_close+0xbc/0x240 net/socket.c:1421
 __fput+0x24a/0x8a0 fs/file_table.c:422
 task_work_run+0x24f/0x310 kernel/task_work.c:228
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x168/0x370 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f0994d779f9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe09b036c8 EFLAGS: 00000246 ORIG_RAX: 00000000000001b4
RAX: 0000000000000000 RBX: 0000000000052632 RCX: 00007f0994d779f9
RDX: 0000000000000000 RSI: 000000000000001e RDI: 0000000000000003
RBP: 00007ffe09b037a0 R08: 0000000000000001 R09: 00007ffe09b039af
R10: 00007f0994c00000 R11: 0000000000000246 R12: 0000000000000032
R13: 00007ffe09b037c0 R14: 00007ffe09b037e0 R15: ffffffffffffffff
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


Return-Path: <netdev+bounces-153917-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4B1F9FA0F3
	for <lists+netdev@lfdr.de>; Sat, 21 Dec 2024 15:19:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 210E9169AB1
	for <lists+netdev@lfdr.de>; Sat, 21 Dec 2024 14:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9261F1F37DF;
	Sat, 21 Dec 2024 14:19:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E523FBB3
	for <netdev@vger.kernel.org>; Sat, 21 Dec 2024 14:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734790766; cv=none; b=hFxYM4nDIrYZUMZ4Pna3JBTnJFCM+1DaZ1SSBDSZnD7wOy31ZU6LGU40AVJ+cR8zSatGLwBSXE751A3IxFGN1Sr/K711BL/3cE3QSHJau9rlBvzaP5IF0zDgkvGsTuAhFn+XaCtYVCKMZBvfaH/tiYoS+I7VvRm92w/7FUJIGmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734790766; c=relaxed/simple;
	bh=nTFkNhV0eaATNy0xfDJFTe2P9/OiOudK/G5FzPBoP40=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ceCOsBtRxAOXK1sGLTMJogDAo6p14XolY4ATVR8eKdqP6a2IKfxwXaHMT6WVJNR7zd5q6APMLo1oN7YcSQCKZIC3WcUVjMqhaC75sGn1dsw+rGfKCLoM115MLAzZRkecWQAmja6DV8fsQY9s0ZbX8cygpDhziknEvg+86/pVTjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3abe7375ba6so51411715ab.3
        for <netdev@vger.kernel.org>; Sat, 21 Dec 2024 06:19:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734790764; x=1735395564;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9YQVhEgBv7J3tvUn1uwF626v640gjPkr9QtcuT6tahQ=;
        b=BWz5BAw3WMrrGe+QiBFkCl6OTsoDi0GJGNp+A+bjkvBb4brZL46EgWzlAtHKDbrEF2
         uFHxHhF/tYJtraIcFo60jKluAk5qariA9FmnTq1FrPn5XzI5s+WhKrWpoZ4m+rrZ6FqI
         NZKDoyZevP28At5dTcaVJIGMviPloRyBze7nCQ8XZFM97QoLPaIyJnFhgpzoZDTRj3+y
         cbTWQfuweWY9+m7qk5ZI8EMpvzme0fJM+pcqobFoIFcUF9UPcHelfvL1jVz9O0rog+4w
         VHLAx/HdGArvpI8ubuDaogIy7vPpdcIj4FaTehGQaMyRFqTNQq8lf/lH0UBSBIv7Pjmp
         GoJA==
X-Forwarded-Encrypted: i=1; AJvYcCUGxlQD+DTSEPazPHQW6I2AVJgXlDf2M//37mn6TOd4uBpT6zLps7PeKxAPFOjzJOdnir5GsQM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yym7BNyXpspXDqIs8RKNu+JNzTEGZaKHEx0BoOGeZDN0FKOBIpG
	3cSx5dGi1eA0xrI3M7TeELn5RumYYCelLU4YKMjBPVn1/bBC+IElHHBKe1CtXfUZMFHmOT7eJdb
	VVPBghee5zsBhLpwDKJzYRp0j23TelzHbgo2IKEB6hNRgb/srWRm2Seo=
X-Google-Smtp-Source: AGHT+IFhoW1RdoeXvSRubE41vBBiMjX/kFHai96nGIBFX1fa06h249wtmVXzb3J7tEn8XUe5MEV1r0Pzi4toOkMsPvL2c9wr0gXk
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:148d:b0:3a7:d7dd:e70f with SMTP id
 e9e14a558f8ab-3c2d2d5112bmr59976535ab.12.1734790764247; Sat, 21 Dec 2024
 06:19:24 -0800 (PST)
Date: Sat, 21 Dec 2024 06:19:24 -0800
In-Reply-To: <000000000000cd69c7061dfe35d2@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6766ce6c.050a0220.226966.000e.GAE@google.com>
Subject: Re: [syzbot] [bluetooth?] WARNING: ODEBUG bug in hci_release_dev (2)
From: syzbot <syzbot+b170dbf55520ebf5969a@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    499551201b5f Merge tag 'arm64-fixes' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17916f30580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c22efbd20f8da769
dashboard link: https://syzkaller.appspot.com/bug?extid=b170dbf55520ebf5969a
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1090c0c4580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10a1efe8580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/5ee1fc255de9/disk-49955120.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/24f10c9fac9a/vmlinux-49955120.xz
kernel image: https://storage.googleapis.com/syzbot-assets/211e35102c2e/bzImage-49955120.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b170dbf55520ebf5969a@syzkaller.appspotmail.com

------------[ cut here ]------------
ODEBUG: free active (active state 0) object: ffff888033d51248 object type: timer_list hint: hci_devcd_timeout+0x0/0x2f0 include/linux/skbuff.h:2741
WARNING: CPU: 1 PID: 5828 at lib/debugobjects.c:612 debug_print_object+0x1a2/0x2b0 lib/debugobjects.c:612
Modules linked in:
CPU: 1 UID: 0 PID: 5828 Comm: syz-executor344 Not tainted 6.13.0-rc3-syzkaller-00209-g499551201b5f #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:debug_print_object+0x1a2/0x2b0 lib/debugobjects.c:612
Code: fc ff df 48 89 fa 48 c1 ea 03 80 3c 02 00 75 54 48 8b 14 dd a0 7f b1 8b 41 56 4c 89 e6 48 c7 c7 20 74 b1 8b e8 4f 59 bc fc 90 <0f> 0b 90 90 58 83 05 b6 5a 7f 0b 01 48 83 c4 18 5b 5d 41 5c 41 5d
RSP: 0018:ffffc90003faf768 EFLAGS: 00010286
RAX: 0000000000000000 RBX: 0000000000000003 RCX: ffffffff815a16c9
RDX: ffff888028419e00 RSI: ffffffff815a16d6 RDI: 0000000000000001
RBP: 0000000000000001 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000001 R12: ffffffff8bb17ac0
R13: ffffffff8b4f8020 R14: ffffffff8a2ad340 R15: ffffc90003faf878
FS:  0000000000000000(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055f6d80ebeb8 CR3: 000000007c30e000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __debug_check_no_obj_freed lib/debugobjects.c:1099 [inline]
 debug_check_no_obj_freed+0x4b7/0x600 lib/debugobjects.c:1129
 slab_free_hook mm/slub.c:2284 [inline]
 slab_free mm/slub.c:4613 [inline]
 kfree+0x2b3/0x4b0 mm/slub.c:4761
 hci_release_dev+0x4d9/0x600 net/bluetooth/hci_core.c:2758
 bt_host_release+0x6a/0xb0 net/bluetooth/hci_sysfs.c:87
 device_release+0xa1/0x240 drivers/base/core.c:2567
 kobject_cleanup lib/kobject.c:689 [inline]
 kobject_release lib/kobject.c:720 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x1e4/0x5a0 lib/kobject.c:737
 put_device+0x1f/0x30 drivers/base/core.c:3773
 vhci_release+0x81/0xf0 drivers/bluetooth/hci_vhci.c:665
 __fput+0x3f8/0xb60 fs/file_table.c:450
 task_work_run+0x14e/0x250 kernel/task_work.c:239
 exit_task_work include/linux/task_work.h:43 [inline]
 do_exit+0xad8/0x2d70 kernel/exit.c:938
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1087
 get_signal+0x2576/0x2610 kernel/signal.c:3017
 arch_do_signal_or_restart+0x90/0x7e0 arch/x86/kernel/signal.c:337
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:329 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x150/0x2a0 kernel/entry/common.c:218
 do_syscall_64+0xda/0x250 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f977f68926a
Code: Unable to access opcode bytes at 0x7f977f689240.
RSP: 002b:00007ffc28c89690 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
RAX: 0000000000000000 RBX: 0000000000000004 RCX: 00007f977f68926a
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000003
RBP: 0000000000000000 R08: 00007f977f6e1049 R09: 00007f977f6e1049
R10: 0000000000008000 R11: 0000000000000293 R12: 00007f977f6e1049
R13: 00007ffc28c896e0 R14: 00007ffc28c89720 R15: 0000000000000000
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.


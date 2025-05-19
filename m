Return-Path: <netdev+bounces-191588-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F316ABC594
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 19:27:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 384C13B85DF
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 17:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EB42288539;
	Mon, 19 May 2025 17:27:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0EF286417
	for <netdev@vger.kernel.org>; Mon, 19 May 2025 17:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747675652; cv=none; b=UcqnNFdNbbDqjTqoZ1N4RCFYYa+KduRCS/WKz/5HVCHal6fAdBwYuIOUt6LeiUJ6EYpkchPChgVFH4qoG5DnPOZeo2t2t1ZVceNM5LL1TpzLzYNJMh0KaBeyT1ejMh1+TKsxuEEzMntcigMlb9l3us9PzEKFsVlERi9fRXPTjyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747675652; c=relaxed/simple;
	bh=0kAB772pePIEa78fYStfll0cavrQWzChCajzTBxnhsQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=O2bv9OSNxHGxoAr6kAcf9Ijrqj0isbB0m476/j0mexzJ5k03DTX8T/VRVXuIg52EeLuiniqmqPtSMhG3TtB97nTZdQisu45f6xLVInTosjkNhjae+0e4fjJEm3u05ANjSxWom8Vm5wBA+wrjKwXRrBa8aP8kdtEW9K137R9BxVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-85e7e0413c2so430651539f.3
        for <netdev@vger.kernel.org>; Mon, 19 May 2025 10:27:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747675650; x=1748280450;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6HQddT6eWN3F0IWqabdJeWfb4X02qL99QSl4DYJc82Q=;
        b=dzOhw/kpIeUlGCtshRy/faeoDG/Yb9tc2ntXx7Yz+vgkxAGiRCkYDdQ5ZM9wkUrY60
         EGn3dunKmYnd5nnTpb5/4yg/F5mt4jEwtwCdqAXGMkcqPoWY/3GzbkJWBQkJN/D4+wiP
         nxcp9yctHnt9NGUESzedPR/EbqqDTyW8wr3NtMj/7HP00ErIitJrcfV/cNjNRf/OR4o9
         SiVmU6MukKdlteW9MjoteIRzelUXka/6EvHJ9Is4bdRJSFyvTFcsrK5/f4hdTDlwoUmk
         8CKzkJ3qw6H5LL0OyFei2m08cW5E9VQNbq3YkcMSR3nEP4MAm/woQLFqVjZy/M3cz114
         HTfQ==
X-Forwarded-Encrypted: i=1; AJvYcCUl6sU6F4PX9EFarrwU04G/L9prAyuqd3dbiiMKYS6eqAdkkrC9ZnwknPDv56vZ/ziOGA50lAE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHhYQWJGuhNCNduBOQmPcz6TaIBvlCA5Ic5iEHGYDGFVQOosUi
	Zgq+3WZeBMtP3H2YLUYbr16+qfdbYrQuTw+6bEmMV4NdMfKuL1aLAWV8rI3ZwX65/0q/0mwNMgc
	O016ZUUA+JretZF84I4wBIyfaiLP9lkbskcxg9yd6uA9CCwGYojrRfIkqcmY=
X-Google-Smtp-Source: AGHT+IGc1hnJlRHNmLmirDP3e2VP+yy7wOrWXyz45hSuNyE0nDypeGZmPFZ3T31SkgWTsMJMf60s2nANLUVPWGUPncVETPB0UfKu
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3805:b0:867:6680:cfd with SMTP id
 ca18e2360f4ac-86a2316ec56mr1866755439f.1.1747675650006; Mon, 19 May 2025
 10:27:30 -0700 (PDT)
Date: Mon, 19 May 2025 10:27:29 -0700
In-Reply-To: <00000000000052c1d00616feca15@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <682b6a01.a00a0220.7a43a.0078.GAE@google.com>
Subject: Re: [syzbot] [bluetooth?] WARNING in hci_recv_frame
From: syzbot <syzbot+3e07a461b836821ff70e@syzkaller.appspotmail.com>
To: hdanton@sina.com, johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    a5806cd506af Linux 6.15-rc7
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14bd52d4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6c2cd7998c108ba7
dashboard link: https://syzkaller.appspot.com/bug?extid=3e07a461b836821ff70e
compiler:       Debian clang version 20.1.2 (++20250402124445+58df0ef89dd6-1~exp1~20250402004600.97), Debian LLD 20.1.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12bd52d4580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=170ab1f4580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-a5806cd5.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/114e439a107e/vmlinux-a5806cd5.xz
kernel image: https://storage.googleapis.com/syzbot-assets/28859a387c14/bzImage-a5806cd5.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3e07a461b836821ff70e@syzkaller.appspotmail.com

------------[ cut here ]------------
workqueue: cannot queue hci_rx_work on wq hci0
WARNING: CPU: 0 PID: 7345 at kernel/workqueue.c:2258 __queue_work+0xd62/0xfe0 kernel/workqueue.c:2256
Modules linked in:
CPU: 0 UID: 0 PID: 7345 Comm: syz-executor130 Not tainted 6.15.0-rc7-syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:__queue_work+0xd62/0xfe0 kernel/workqueue.c:2256
Code: 42 80 3c 20 00 74 08 4c 89 ef e8 89 de 96 00 49 8b 75 00 49 81 c7 78 01 00 00 48 c7 c7 40 cc 69 8b 4c 89 fa e8 9f 40 f9 ff 90 <0f> 0b 90 90 e9 f1 f4 ff ff e8 00 e4 34 00 90 0f 0b 90 e9 dd fc ff
RSP: 0018:ffffc9000f4d7a88 EFLAGS: 00010046
RAX: 701780e79c022b00 RBX: 0000000000000000 RCX: ffff88803d9a0000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000002
RBP: 1ffff110022be938 R08: ffff88801fe23e93 R09: 1ffff11003fc47d2
R10: dffffc0000000000 R11: ffffed1003fc47d3 R12: dffffc0000000000
R13: ffff8880437f0a98 R14: ffff88803d9a0000 R15: ffff8880115f4978
FS:  00007f9904bca6c0(0000) GS:ffff88808d6c2000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000200000000040 CR3: 000000004012c000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 queue_work_on+0x181/0x270 kernel/workqueue.c:2392
 queue_work include/linux/workqueue.h:662 [inline]
 hci_recv_frame+0x5ad/0x700 net/bluetooth/hci_core.c:2926
 vhci_get_user drivers/bluetooth/hci_vhci.c:512 [inline]
 vhci_write+0x358/0x4a0 drivers/bluetooth/hci_vhci.c:608
 new_sync_write fs/read_write.c:591 [inline]
 vfs_write+0x548/0xa90 fs/read_write.c:684
 ksys_write+0x145/0x250 fs/read_write.c:736
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xf6/0x210 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f9905433a6f
Code: 89 54 24 18 48 89 74 24 10 89 7c 24 08 e8 d9 6b 02 00 48 8b 54 24 18 48 8b 74 24 10 41 89 c0 8b 7c 24 08 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 31 44 89 c7 48 89 44 24 08 e8 2c 6c 02 00 48
RSP: 002b:00007f9904bca1e0 EFLAGS: 00000293 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f99054bf3f8 RCX: 00007f9905433a6f
RDX: 0000000000000007 RSI: 0000200000000040 RDI: 00000000000000ca
RBP: 0000200000000040 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000293 R12: 00007f99054bf3f0
R13: 00007f99054bf3fc R14: 0000000000000040 R15: 00007ffdd9006d98
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.


Return-Path: <netdev+bounces-153978-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 389439FA871
	for <lists+netdev@lfdr.de>; Sun, 22 Dec 2024 23:32:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E6771886301
	for <lists+netdev@lfdr.de>; Sun, 22 Dec 2024 22:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F4301922ED;
	Sun, 22 Dec 2024 22:32:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1F8155757
	for <netdev@vger.kernel.org>; Sun, 22 Dec 2024 22:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734906749; cv=none; b=L3GLDPcCkT7o9EbO7KrDnVesnyLcNP2L7paSS+RDKopB1lEjuXTD9JjnrClFz3y9GTz/TErfRQV6eamxQT0Yrimpd6/LxIuB8N2uoltFdu/YTU40VKQqrovLxFPusASZCv5ehewSHnITxMO1hxQy+ueEXLyOyPdaE/hIQaZ7rbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734906749; c=relaxed/simple;
	bh=WgLnk6IONhSPOz9x+JW0Gw/5twX/2CfUnm36GJ8/09c=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ESSLCYyaXdl4vMH5o5lePcAhoFy9iqXT/fZPeNpNaQNvJomn61KK1MBcuRZ6l0vUzNKMlWxYKzy2T1nTySzTPIArU//G98RGurOWIoLMEn9zOEka/07btL7/zfXoGCxgxqnsVpOrji9etRw5yrVKd2gKNDZ2k/wtuzY8QxEKHcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-849d26dd331so5418439f.1
        for <netdev@vger.kernel.org>; Sun, 22 Dec 2024 14:32:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734906747; x=1735511547;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FRsnKFAlPDwHsjYv8HbPpCEF4fsquGjuEp5r4rTRqZ8=;
        b=IRK4aaPgfoOoWqXJ3caC6Y6kfp1/mm5wddcHVwaiImEj3brD3n9AUNDNQCHKYwxJjL
         WDiXX1iv1+MGgUwULVRcVDuYNRde6dO/WRkvdwpbI5tKRd1yp+lAvVFMqOBzS3cxMsDi
         zt9BG/1jMvMn69Rf8J47biQGM6fTZZ+iMj/v7VSO7NKxtPZbFjuUZAcQRMMjL5DYIPKy
         LpmQrjGsaEBntZ4aegLgYJxtOX9xMe7lCf58iEyKppixyzEf8Ap7zZTolocIDIAGZ82I
         J24Dp1+eeRwkiChrlrb01xXSCdEmTnkiAHXUfyxXWemhBTZ6Mgsb0aMNGFa4mALJ7RFf
         wajw==
X-Forwarded-Encrypted: i=1; AJvYcCXEN7cYE+vAnZRRoVBnz4t0UgorYguiTbC+ddb9I+518aw+Oc1Wfd9Cyj9n5zGhNHy6XZHyVz8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsMqOWH7mjGJkj8Glndnq8By4SQiihggrN7GS72YDrZ2r/3zdT
	XQo8S9SWmXuJFsCun3qGdi9m0kEi7xgnaVFi0oGw2M1NWv/qTa6iaVZ8YPQxMrwjiQCRjZWDknX
	3d0kqhNfmU1vf3Q8vsAn19QxNy/2f3e/nLciNiuDt629ymMzjFblD2Qo=
X-Google-Smtp-Source: AGHT+IFtcXRT+A73PP4a4fssUvMPwH7z2yt+qGZoJpm9kTGJd4suarkBIP9s1HJlR5Sa26KW6j3/HNFTHQ3hhJXCRGq5wKDa4w+p
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1e06:b0:3a7:cff5:16d6 with SMTP id
 e9e14a558f8ab-3c2fe4458fbmr80462535ab.3.1734906746878; Sun, 22 Dec 2024
 14:32:26 -0800 (PST)
Date: Sun, 22 Dec 2024 14:32:26 -0800
In-Reply-To: <67425f74.050a0220.1cc393.0020.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6768937a.050a0220.226966.0033.GAE@google.com>
Subject: Re: [syzbot] [kernel?] general protection fault in bnep_session
From: syzbot <syzbot+6df45dd3d03e1a9aca96@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, rafael@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    bcde95ce32b6 Merge tag 'devicetree-fixes-for-6.13-1' of gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12b0fcf8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4f1586bab1323870
dashboard link: https://syzkaller.appspot.com/bug?extid=6df45dd3d03e1a9aca96
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10b90adf980000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-bcde95ce.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d1b2e8d294e3/vmlinux-bcde95ce.xz
kernel image: https://storage.googleapis.com/syzbot-assets/593ff4631acc/bzImage-bcde95ce.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6df45dd3d03e1a9aca96@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc000000000b: 0000 [#1] PREEMPT SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x0000000000000058-0x000000000000005f]
CPU: 0 UID: 0 PID: 6160 Comm: kbnepd bnep0 Not tainted 6.13.0-rc3-syzkaller-00301-gbcde95ce32b6 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:klist_put+0x4d/0x1b0 lib/klist.c:212
Code: c1 ea 03 80 3c 02 00 0f 85 5f 01 00 00 48 b8 00 00 00 00 00 fc ff df 4c 8b 23 49 83 e4 fe 49 8d 7c 24 58 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 2e 01 00 00 4c 89 e7 4d 8b 74 24 58 e8 7c ce 0c
RSP: 0018:ffffc900047e79c0 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: ffff888033468860 RCX: ffffffff8239c3fd
RDX: 000000000000000b RSI: ffffffff8b1f72c5 RDI: 0000000000000058
RBP: 0000000000000001 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000b92 R12: 0000000000000000
R13: 0000000000000001 R14: ffff88802426bb80 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff88806a600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffabd6b5108 CR3: 000000003551a000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 device_del+0x1d9/0x9f0 drivers/base/core.c:3831
 unregister_netdevice_many_notify+0x105d/0x1e60 net/core/dev.c:11562
 unregister_netdevice_many net/core/dev.c:11590 [inline]
 unregister_netdevice_queue+0x307/0x3f0 net/core/dev.c:11462
 unregister_netdevice include/linux/netdevice.h:3192 [inline]
 unregister_netdev+0x1c/0x30 net/core/dev.c:11608
 bnep_session+0x21b6/0x2ca0 net/bluetooth/bnep/core.c:525
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:klist_put+0x4d/0x1b0 lib/klist.c:212
Code: c1 ea 03 80 3c 02 00 0f 85 5f 01 00 00 48 b8 00 00 00 00 00 fc ff df 4c 8b 23 49 83 e4 fe 49 8d 7c 24 58 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 2e 01 00 00 4c 89 e7 4d 8b 74 24 58 e8 7c ce 0c
RSP: 0018:ffffc900047e79c0 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: ffff888033468860 RCX: ffffffff8239c3fd
RDX: 000000000000000b RSI: ffffffff8b1f72c5 RDI: 0000000000000058
RBP: 0000000000000001 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000b92 R12: 0000000000000000
R13: 0000000000000001 R14: ffff88802426bb80 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff88806a700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fe5193ea718 CR3: 0000000024a3c000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	c1 ea 03             	shr    $0x3,%edx
   3:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
   7:	0f 85 5f 01 00 00    	jne    0x16c
   d:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  14:	fc ff df
  17:	4c 8b 23             	mov    (%rbx),%r12
  1a:	49 83 e4 fe          	and    $0xfffffffffffffffe,%r12
  1e:	49 8d 7c 24 58       	lea    0x58(%r12),%rdi
  23:	48 89 fa             	mov    %rdi,%rdx
  26:	48 c1 ea 03          	shr    $0x3,%rdx
* 2a:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
  2e:	0f 85 2e 01 00 00    	jne    0x162
  34:	4c 89 e7             	mov    %r12,%rdi
  37:	4d 8b 74 24 58       	mov    0x58(%r12),%r14
  3c:	e8                   	.byte 0xe8
  3d:	7c ce                	jl     0xd
  3f:	0c                   	.byte 0xc


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.


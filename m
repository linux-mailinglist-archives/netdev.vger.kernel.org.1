Return-Path: <netdev+bounces-187657-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D0D7AA8917
	for <lists+netdev@lfdr.de>; Sun,  4 May 2025 21:10:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2147B18946BF
	for <lists+netdev@lfdr.de>; Sun,  4 May 2025 19:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC09124A043;
	Sun,  4 May 2025 19:10:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B0E2475CE
	for <netdev@vger.kernel.org>; Sun,  4 May 2025 19:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746385836; cv=none; b=c0PkuuL5lnViuXoIrZtU3/mefsbX1fHBZTJvogmrXAMzvKQcgAKbRPWt2u2lKQst6jDKV5SmPzX6yz4y9gbcrG+TkO+yBXgtdRPLgubXF4kw4f6mJFTG6GKlqKCRMm1UtofrgID1vxUFhryQTlKVQW5Bap9wvktr+ZX0bDsWWPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746385836; c=relaxed/simple;
	bh=vjFaoOvRw1vrMa/9VjFzL1XNP2AXqEAp/jbnc4A5WnE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=WlU2HNHs0y8T7XQgyLyEIzSyVZ+GRXBNn+NguKIF1sEO+kinJj7CBuQNnpbFVYc2gKOfZevWylEvhH7rPpozOMkdIeF446xFeNNGyp/J1cC9qpuc6OkaWvZIGwvEit/4i/xJamqnf+BZtQInT8v45WIIjD/zxDlEBY73LUdgcOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3d43541a706so32087695ab.1
        for <netdev@vger.kernel.org>; Sun, 04 May 2025 12:10:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746385834; x=1746990634;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YXjH2/nIZgFObFxlaymemrJhwERcHzwr+S1weGC2s40=;
        b=CWc1jUmOrb5o/avrmJRBTNzDhyugL4hLQj5+itULQpjXnFSq8EfvS3Z1IABi2izm5D
         0qXRLnoQ22fmTFoWsMDtqGctDTw2+MkT3wER8HpaFt00Ws9YDSHXBOKZYP0dUyHc7RZm
         k+SxkuEHD5HA95SBe/tGSqSXBDR6gn+rIB8HWLI6R1iUthNd0qCpETtDXTf9LyOc/TQR
         czBqIYv4IUPM/l5WxJ1vDx+zq07ceRtgaKqGPYfrEd6I1FJYL/vRQ/WV03/zrjdk3KaV
         +DVo2+Nbp5JCaFQboGkS6CS5XVDF8XsuqdeA2a9B8WQK/JOs0KYx60ZKZ9pUhruoRQgG
         WPtQ==
X-Forwarded-Encrypted: i=1; AJvYcCUG8e6zbngEWcMv6mAMitFdXK5Sx71yUYmmSb0m9H9k1KTA1wapISlHkN2kFBRdReIU3IUYi4M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDPwRJ8PbyQ4cvJSGg1eL7HrytmCZTdZO/Irejt1NgTYEeJVlI
	bxLFisemWm6oRTtbmePEtOw6Vh8/RQ01nOhGKEDHtyR/+Xyf8Qong6c49c8bRPTExP1U1cQsP1x
	JKHQVHP85EZ+RLECTVaCKJ9Wq+gIB65ZncyIbc+XZkbebDyTgInQCgmA=
X-Google-Smtp-Source: AGHT+IEGHAGSBDNNMdyt3lOlnWkJKKQSpukblnhOyv1hILPhcdGjYYox+zKB1++65898j2om5s110sORaVe1oa9OtaH75aLbWERp
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3982:b0:3d8:2032:ca67 with SMTP id
 e9e14a558f8ab-3da5b2733cemr44891425ab.9.1746385833759; Sun, 04 May 2025
 12:10:33 -0700 (PDT)
Date: Sun, 04 May 2025 12:10:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6817bba9.050a0220.11da1b.0037.GAE@google.com>
Subject: [syzbot] [net?] kernel BUG in unregister_vlan_dev (3)
From: syzbot <syzbot+a8b046e462915c65b10b@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    ac9c34d1e45a Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14de1db0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8f2f8fb6ad08b539
dashboard link: https://syzkaller.appspot.com/bug?extid=a8b046e462915c65b10b
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-ac9c34d1.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/29bdb2b01967/vmlinux-ac9c34d1.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e12977e5724d/bzImage-ac9c34d1.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a8b046e462915c65b10b@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at net/8021q/vlan.c:100!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN NOPTI
CPU: 1 UID: 0 PID: 1143 Comm: kworker/u32:8 Not tainted 6.14.0-rc4-syzkaller-00052-gac9c34d1e45a #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Workqueue: netns cleanup_net
RIP: 0010:unregister_vlan_dev+0x4b2/0x590 net/8021q/vlan.c:100
Code: 01 90 ba 61 00 00 00 48 c7 c6 a0 b0 bd 8c 48 c7 c7 e0 b0 bd 8c e8 3e 1d ed f6 90 0f 0b 90 90 e9 ec fb ff ff e8 8f ec 2c f7 90 <0f> 0b e8 27 01 90 f7 e9 ba fb ff ff 4c 89 f7 e8 4a 01 90 f7 e9 4d
RSP: 0018:ffffc9000600f9e8 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff8880436c4000 RCX: ffffffff8a8cf212
RDX: ffff888027142440 RSI: ffffffff8a8cf361 RDI: ffff88804b09a428
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000003 R12: ffff88804b09a000
R13: 0000000000000000 R14: ffff88804d8fdd30 R15: ffff88804d8fdac0
FS:  0000000000000000(0000) GS:ffff88806a700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005584306fa000 CR3: 0000000024c3e000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 default_device_exit_batch+0x778/0xae0 net/core/dev.c:12432
 ops_exit_list+0x128/0x180 net/core/net_namespace.c:177
 cleanup_net+0x5c6/0xb30 net/core/net_namespace.c:652
 process_one_work+0x9c5/0x1ba0 kernel/workqueue.c:3236
 process_scheduled_works kernel/workqueue.c:3317 [inline]
 worker_thread+0x6c8/0xf00 kernel/workqueue.c:3398
 kthread+0x3af/0x750 kernel/kthread.c:464
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:unregister_vlan_dev+0x4b2/0x590 net/8021q/vlan.c:100
Code: 01 90 ba 61 00 00 00 48 c7 c6 a0 b0 bd 8c 48 c7 c7 e0 b0 bd 8c e8 3e 1d ed f6 90 0f 0b 90 90 e9 ec fb ff ff e8 8f ec 2c f7 90 <0f> 0b e8 27 01 90 f7 e9 ba fb ff ff 4c 89 f7 e8 4a 01 90 f7 e9 4d
RSP: 0018:ffffc9000600f9e8 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff8880436c4000 RCX: ffffffff8a8cf212
RDX: ffff888027142440 RSI: ffffffff8a8cf361 RDI: ffff88804b09a428
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000003 R12: ffff88804b09a000
R13: 0000000000000000 R14: ffff88804d8fdd30 R15: ffff88804d8fdac0
FS:  0000000000000000(0000) GS:ffff88806a700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f1aefd735e8 CR3: 000000004e9dc000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


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


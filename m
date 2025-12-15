Return-Path: <netdev+bounces-244737-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C3C6CBDD53
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 13:36:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CAD043037CDE
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 12:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A841225408;
	Mon, 15 Dec 2025 12:30:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f77.google.com (mail-oa1-f77.google.com [209.85.160.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1948221D3F0
	for <netdev@vger.kernel.org>; Mon, 15 Dec 2025 12:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765801835; cv=none; b=lIdvSQR26qKqpYsR2iJFGq167IPPcDutLj+8aIv/dDhUEDKHizGqf6p/h4UiywOmINCeD55LB+aOU3pij6q7N+2A+pUtowHcJBJUTpTb60uVKGrxs+KAKFJW/wI/yqkaDKdDBHFkoXhOJd3E+XXVXMv4MJToxTCwJ2LWzqm+eXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765801835; c=relaxed/simple;
	bh=t7mnA1JXNIt1sowABfFOYKVU4INnCQt8fzFOmRHGBxo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=PEpGZloJMj+u3XsUn+5acTPkxYFovGvVN54gy0Jn39ZKEIFPXD0vepLp4ks5MYVfD/UVN0WpjHJJPWt6COoZea/ZvI0RQjK6rEstigphLP1jAhXqILzVTkmhl8eok9/lK/fLryop970Jcps2mBF87iX10tCW+WhJzV6RCDWY4LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.160.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa1-f77.google.com with SMTP id 586e51a60fabf-3f99d3f06f6so924848fac.2
        for <netdev@vger.kernel.org>; Mon, 15 Dec 2025 04:30:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765801831; x=1766406631;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FmkbodutDZC8hdluHMNGaoY/QA3lBOYK1JpBNIovc6o=;
        b=JMSQBlYllu3QpC4HUuRk/2kkq3bt5WqTZK0t5xRwbPQDL12Bwfczs6vXdj0b3vZSbX
         S3YOuMgUIZz50tLEYecWpi11kOom9ofQKNXlzGqfXWlzEK/pZV3QdN3BVesMzL4UGl2j
         mdLD1id7pW2njzcIEk76+Tpe9tniAEUDbbOLMwOAs/E1khD5tkdRiII61AiXlF4JxqKq
         EcXTpybCF+0ctB2io2+rleo2nl9BGN73zK/+DKUDLyekE5SjeR+uHR2tLR30634rdp04
         PxPwALCLWkUrP1syi5cbfNzxxyaaeuK8ycYJ4om6V52zzicjbWxvYgtgeu+bFgRXhP1l
         RiXg==
X-Forwarded-Encrypted: i=1; AJvYcCXsq/YaHi6qeEmbpMNspBz4m6X3WyKnf0H8HMciUZrBioz+E4JNmDbni9wbCayroZPbHHmpefA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyb4TGCX8SobiTwb2th+gLkKx97qV4zY1TtFVZFZc54v1THoUJt
	j1TsBQgY7pPBviCjYuVQq4RilaGZ42p7N/4tc+l1zi1iE8sB5i3T7eGuxYXLR+6eo94KYdZu6cb
	EhOokZzZxBaIdf/T2sX67ODtEtU4ZWk95YJzL+7+vSiIA7uAq/tYJakEbqkE=
X-Google-Smtp-Source: AGHT+IFBpHRYsDCnNt2eAl1dpSRNDfYZWXdJ00ZGq0lOAKWf1vzhcrgROGEj8y0yiOAlvGdE03Dxkp/doBRwRaci4pJ+5cVKzusy
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:f009:b0:657:5723:76c8 with SMTP id
 006d021491bc7-65b451812f6mr5115110eaf.6.1765801830725; Mon, 15 Dec 2025
 04:30:30 -0800 (PST)
Date: Mon, 15 Dec 2025 04:30:30 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <693fff66.a70a0220.104cf0.033d.GAE@google.com>
Subject: [syzbot] [net?] [usb?] WARNING in mdiobus_get_phy
From: syzbot <syzbot+3d43c9066a5b54902232@syzkaller.appspotmail.com>
To: andrew@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	hkallweit1@gmail.com, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, linux@armlinux.org.uk, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    5ce74bc1b7cb Add linux-next specific files for 20251211
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=130b51c2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b9f785244b836412
dashboard link: https://syzkaller.appspot.com/bug?extid=3d43c9066a5b54902232
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13baa61a580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e550c10060d5/disk-5ce74bc1.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/80331ba2b4cc/vmlinux-5ce74bc1.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4bcb4f82dfcf/bzImage-5ce74bc1.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3d43c9066a5b54902232@syzkaller.appspotmail.com

------------[ cut here ]------------
addr 207 out of range
WARNING: drivers/net/phy/mdio_bus.c:76 at mdiobus_find_device drivers/net/phy/mdio_bus.c:76 [inline], CPU#0: kworker/0:5/6044
WARNING: drivers/net/phy/mdio_bus.c:76 at mdiobus_get_phy+0xaf/0xd0 drivers/net/phy/mdio_bus.c:86, CPU#0: kworker/0:5/6044
Modules linked in:
CPU: 0 UID: 0 PID: 6044 Comm: kworker/0:5 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
Workqueue: usb_hub_wq hub_event
RIP: 0010:mdiobus_find_device drivers/net/phy/mdio_bus.c:76 [inline]
RIP: 0010:mdiobus_get_phy+0xb1/0xd0 drivers/net/phy/mdio_bus.c:86
Code: e8 34 1c 73 fb eb 07 e8 ed 17 73 fb 31 db 48 89 d8 5b 41 5e 41 5f c3 cc cc cc cc cc e8 d8 17 73 fb 48 8d 3d 31 16 81 09 89 de <67> 48 0f b9 3a eb db 89 f9 80 e1 07 80 c1 03 38 c1 7c b1 e8 57 7a
RSP: 0018:ffffc900033a6aa8 EFLAGS: 00010293
RAX: ffffffff864edf78 RBX: 00000000000000cf RCX: ffff88802a9ebd00
RDX: 0000000000000000 RSI: 00000000000000cf RDI: ffffffff8fcff5b0
RBP: ffffc900033a6bf0 R08: ffffc900033a6787 R09: 1ffff92000674cf0
R10: dffffc0000000000 R11: fffff52000674cf1 R12: ffff888078e2cdc0
R13: dffffc0000000000 R14: ffff88807cd12000 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff8881259e6000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f1c669c9e9c CR3: 000000000e13a000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 ax88772_init_phy+0x8e/0x390 drivers/net/usb/asix_devices.c:722
 ax88772_bind+0x961/0xde0 drivers/net/usb/asix_devices.c:937
 usbnet_probe+0xab5/0x28f0 drivers/net/usb/usbnet.c:1802
 usb_probe_interface+0x668/0xc90 drivers/usb/core/driver.c:396
 call_driver_probe drivers/base/dd.c:-1 [inline]
 really_probe+0x26d/0xad0 drivers/base/dd.c:659
 __driver_probe_device+0x18c/0x320 drivers/base/dd.c:801
 driver_probe_device+0x4f/0x240 drivers/base/dd.c:831
 __device_attach_driver+0x279/0x430 drivers/base/dd.c:959
 bus_for_each_drv+0x251/0x2e0 drivers/base/bus.c:500
 __device_attach+0x2b8/0x430 drivers/base/dd.c:1031
 device_initial_probe+0xa1/0xd0 drivers/base/dd.c:1086
 bus_probe_device+0x12a/0x220 drivers/base/bus.c:574
 device_add+0x7b6/0xb80 drivers/base/core.c:3689
 usb_set_configuration+0x1a87/0x2110 drivers/usb/core/message.c:2210
 usb_generic_driver_probe+0x8d/0x150 drivers/usb/core/generic.c:250
 usb_probe_device+0x1c4/0x3c0 drivers/usb/core/driver.c:291
 call_driver_probe drivers/base/dd.c:-1 [inline]
 really_probe+0x26d/0xad0 drivers/base/dd.c:659
 __driver_probe_device+0x18c/0x320 drivers/base/dd.c:801
 driver_probe_device+0x4f/0x240 drivers/base/dd.c:831
 __device_attach_driver+0x279/0x430 drivers/base/dd.c:959
 bus_for_each_drv+0x251/0x2e0 drivers/base/bus.c:500
 __device_attach+0x2b8/0x430 drivers/base/dd.c:1031
 device_initial_probe+0xa1/0xd0 drivers/base/dd.c:1086
 bus_probe_device+0x12a/0x220 drivers/base/bus.c:574
 device_add+0x7b6/0xb80 drivers/base/core.c:3689
 usb_new_device+0xa39/0x1720 drivers/usb/core/hub.c:2695
 hub_port_connect drivers/usb/core/hub.c:5567 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5707 [inline]
 port_event drivers/usb/core/hub.c:5871 [inline]
 hub_event+0x29b1/0x4ef0 drivers/usb/core/hub.c:5953
 process_one_work+0x93a/0x15a0 kernel/workqueue.c:3279
 process_scheduled_works kernel/workqueue.c:3362 [inline]
 worker_thread+0x9b0/0xee0 kernel/workqueue.c:3443
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x599/0xb30 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246
 </TASK>
----------------
Code disassembly (best guess):
   0:	e8 34 1c 73 fb       	call   0xfb731c39
   5:	eb 07                	jmp    0xe
   7:	e8 ed 17 73 fb       	call   0xfb7317f9
   c:	31 db                	xor    %ebx,%ebx
   e:	48 89 d8             	mov    %rbx,%rax
  11:	5b                   	pop    %rbx
  12:	41 5e                	pop    %r14
  14:	41 5f                	pop    %r15
  16:	c3                   	ret
  17:	cc                   	int3
  18:	cc                   	int3
  19:	cc                   	int3
  1a:	cc                   	int3
  1b:	cc                   	int3
  1c:	e8 d8 17 73 fb       	call   0xfb7317f9
  21:	48 8d 3d 31 16 81 09 	lea    0x9811631(%rip),%rdi        # 0x9811659
  28:	89 de                	mov    %ebx,%esi
* 2a:	67 48 0f b9 3a       	ud1    (%edx),%rdi <-- trapping instruction
  2f:	eb db                	jmp    0xc
  31:	89 f9                	mov    %edi,%ecx
  33:	80 e1 07             	and    $0x7,%cl
  36:	80 c1 03             	add    $0x3,%cl
  39:	38 c1                	cmp    %al,%cl
  3b:	7c b1                	jl     0xffffffee
  3d:	e8                   	.byte 0xe8
  3e:	57                   	push   %rdi
  3f:	7a                   	.byte 0x7a


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


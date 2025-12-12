Return-Path: <netdev+bounces-244453-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B8E2CB7DF5
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 05:39:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F0ABA302EF55
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 04:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1997F2FB61C;
	Fri, 12 Dec 2025 04:39:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f80.google.com (mail-oo1-f80.google.com [209.85.161.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56897274B40
	for <netdev@vger.kernel.org>; Fri, 12 Dec 2025 04:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765514368; cv=none; b=JG9W7yLrKZTDsUvo4h7FozvxFFjHCFT+Nb4gWxXml7XqBH8eH4ltY7aqeB5Mg50LzzUUARc56xi/IHEM/6G3UnidtWTzGR3eYOV93v6zsgkt0kDb2nmwApdszh1pqcq74xsommZ0VffIGWwt5W0BQmgKjvYv/mO8OXyezRoP3mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765514368; c=relaxed/simple;
	bh=9ZZ6zTv+CajfyfOuhr3XXOv+Z33WLu7yxw52KzzIuCQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=sNX/8/P7k0e1GOJgF8Vquv63MX6K/TzG/BgaN7kKO7ktBP7k784wYxSIflSZ4ch6rx4A5YECE19TahinP0PkeSycDGJauVTmcsoANK+XlAm+XAtQ5vMIYnGLa59GBXJEAiSzrNN1QDihHPA/B4gZYwK++LikVIjYBpQFcjnTiFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f80.google.com with SMTP id 006d021491bc7-656ceb0c967so724935eaf.1
        for <netdev@vger.kernel.org>; Thu, 11 Dec 2025 20:39:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765514365; x=1766119165;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hkEgtOwRsvbND/YC89A9Q8BjoO1+c3oG4xSuYIh3xOM=;
        b=NuanFmnHizneLcsYGYrPZQu4BSomq0U2t/MdF5pjG1+Z6wLABo8nh4Ogk8uo9XKp/L
         eLJh+OZ7FG9gKqTe/B5kRDcxc2x6SDIfOw17KEPny3NkUJ5wLEcHG08hLl6Z6AMHt8b+
         kLsChTl9A9axHO1HIb5vdZGbS0v5zSUo/+/LWfyiGNIWpifixhP5dvSGm5gbj/tFz4ZC
         cBBxT2uUNC8I42UDJbBa5qcVJj1wQLOZr04ZgViLtd+CP2kXrj49i0xFlKcnIdjhvQeT
         iqKxtR/TH6kCJQYs2Z9RYNdrC8j8ViqYgYRHzrQeIHK+oWHPLXJScax4ZNxnmI+egE9a
         j+OA==
X-Forwarded-Encrypted: i=1; AJvYcCVJLUwuJysRta9gvsQTgrwakWW5ihMpV4gQp07mvHVUcr3MeY6d+uOYsovpZHJSJkDBSIcEKwo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTmzUHGVY5v3sblsaVr7k36PQuuQTJYnWo6HLEA65KJrp1kz/s
	Tok+8JmLKDpPy9I+ZRPjzncJi0i00539EKJjBSb/0v1yzMFGni39K5DrQ6DKuJzGCQIzoErAuHi
	gOeoL8PwtNKCosSbwCG0E5aLRwNavUiNm/iXJxTEqEkJElGeFtoWR4dYgkwo=
X-Google-Smtp-Source: AGHT+IHJ5GVQfoQl6Tbt14yfAoXrwwtOvMv/ErGGhu+7lN1xUJNrTchltCQgGobycp38kz9xvGybeKqMQ7vnovUvCWv9XLehG5hu
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:2019:b0:659:9a49:8dda with SMTP id
 006d021491bc7-65b451715aemr353169eaf.28.1765514365502; Thu, 11 Dec 2025
 20:39:25 -0800 (PST)
Date: Thu, 11 Dec 2025 20:39:25 -0800
In-Reply-To: <68cd074a.a00a0220.37dadf.0017.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <693b9c7d.a70a0220.33cd7b.0049.GAE@google.com>
Subject: Re: [syzbot] [net?] WARNING in dev_shutdown (7)
From: syzbot <syzbot+c9ecf60a8adb7629821e@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	jhs@mojatatu.com, jiri@resnulli.us, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com, 
	xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    d358e5254674 Merge tag 'for-6.19/dm-changes' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1708661a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=73d2ed7b46aaccf3
dashboard link: https://syzkaller.appspot.com/bug?extid=c9ecf60a8adb7629821e
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12085592580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/1d59faedb36d/disk-d358e525.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1d120390f17c/vmlinux-d358e525.xz
kernel image: https://storage.googleapis.com/syzbot-assets/142411a13cfd/bzImage-d358e525.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c9ecf60a8adb7629821e@syzkaller.appspotmail.com

usb 4-1: USB disconnect, device number 6
net1080 4-1:0.166 usb0: unregister 'net1080' usb-dummy_hcd.3-1, NetChip TurboCONNECT
------------[ cut here ]------------
WARNING: net/sched/sch_generic.c:1496 at dev_shutdown+0x3c1/0x430 net/sched/sch_generic.c:1496, CPU#1: kworker/1:7/6098
Modules linked in:
CPU: 1 UID: 0 PID: 6098 Comm: kworker/1:7 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
Workqueue: usb_hub_wq hub_event
RIP: 0010:dev_shutdown+0x3c1/0x430 net/sched/sch_generic.c:1496
Code: 48 c7 c2 40 2d c7 8c be a3 00 00 00 48 c7 c7 40 32 c7 8c c6 05 1f 30 08 07 01 e8 aa cd 30 f8 e9 8f fd ff ff e8 70 1b 56 f8 90 <0f> 0b 90 e9 5f fe ff ff 4c 89 f7 e8 ef e8 bf f8 e9 6c fc ff ff 4c
RSP: 0018:ffffc90003f5f410 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff88802c5444d0 RCX: ffffffff89683b9e
RDX: ffff88807a4b4980 RSI: ffffffff8968c850 RDI: ffff88802c5445b0
RBP: ffff88802c544000 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: ffff88802c544480
R13: ffffed10058a8803 R14: ffff88802c5444c8 R15: 0000000000000001
FS:  0000000000000000(0000) GS:ffff8881249fd000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000040 CR3: 0000000029904000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 unregister_netdevice_many_notify+0xb37/0x2590 net/core/dev.c:12369
 unregister_netdevice_many net/core/dev.c:12444 [inline]
 unregister_netdevice_queue net/core/dev.c:12258 [inline]
 unregister_netdevice_queue+0x305/0x3c0 net/core/dev.c:12248
 unregister_netdevice include/linux/netdevice.h:3405 [inline]
 unregister_netdev+0x1f/0x60 net/core/dev.c:12462
 usbnet_disconnect+0x109/0x510 drivers/net/usb/usbnet.c:1676
 usb_unbind_interface+0x1dd/0x9e0 drivers/usb/core/driver.c:458
 device_remove drivers/base/dd.c:571 [inline]
 device_remove+0x125/0x170 drivers/base/dd.c:563
 __device_release_driver drivers/base/dd.c:1282 [inline]
 device_release_driver_internal+0x44b/0x620 drivers/base/dd.c:1305
 bus_remove_device+0x22f/0x450 drivers/base/bus.c:616
 device_del+0x396/0x9f0 drivers/base/core.c:3878
 usb_disable_device+0x355/0x820 drivers/usb/core/message.c:1418
 usb_disconnect+0x2e1/0x9e0 drivers/usb/core/hub.c:2345
 hub_port_connect drivers/usb/core/hub.c:5407 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5707 [inline]
 port_event drivers/usb/core/hub.c:5871 [inline]
 hub_event+0x1d84/0x52f0 drivers/usb/core/hub.c:5953
 process_one_work+0x9ba/0x1b20 kernel/workqueue.c:3257
 process_scheduled_works kernel/workqueue.c:3340 [inline]
 worker_thread+0x6c8/0xf10 kernel/workqueue.c:3421
 kthread+0x3c5/0x780 kernel/kthread.c:463
 ret_from_fork+0x983/0xb10 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.


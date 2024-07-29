Return-Path: <netdev+bounces-113713-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74AD293F9D0
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 17:48:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD2E3B21EBB
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 15:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90F4D147C79;
	Mon, 29 Jul 2024 15:48:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8928004F
	for <netdev@vger.kernel.org>; Mon, 29 Jul 2024 15:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722268112; cv=none; b=BHN0i4hgkss3DN383JRh235liA6P/txSlYWT41Av1bqjiMTF5ynkDPbJDuyhlyn94k5jRsnoZxT8/OrO5N4Zvl1GxhON49cJa39UNAA5z/4yqhlJ3EhtZUHUAV+J58sDsPwQZz2jEL5CDAwsZbLCghf3Gz4sL11HFRjjM0UIAAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722268112; c=relaxed/simple;
	bh=rArEl4yIOqZ59InPwfhlc6msPLZe89qV0Yi2KY08dg8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=EoBJ/2IHO0ty4fLfkSabhQyAypuQHeBqQg3BtoR4YSwjelv7c7Fv98JfqsZ7skDixLbrZNsEjn5uVTLdvw7J86VYc+3/5dT4L02Sm++z9QegTNX9L9ew2d1txy3pCQb0Erk+LVoNr8bGtdNXRqlWFgujPCf3p/ni8OuUuvF53ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-39ad7e6b4deso51945125ab.2
        for <netdev@vger.kernel.org>; Mon, 29 Jul 2024 08:48:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722268110; x=1722872910;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jA8+++3yvb+eDXrAD85K2rueOWSInRZ1QvJmqWjrziA=;
        b=UkUsq75DK0mQG9cZV1lruf4jOZ61GEc9CzqpAu287KsfjsVAdm6n2XGRKtOyKULmeC
         +ioJ+u2mvBVS8bzOCiDTUS4fLefwPo83A45CivJG/wsv/iqfZEsSZbRkmrX9qP4AK03z
         7eOM/j9uQYtlqczdvcljXkMGcjxbe1Dk2sKHxv/PSEzvKPmRLao58zi+WxkJtrjqJOQ8
         dSZrcze65NCs23ulOlNmziUSCA06NUbYshC13pTeUYn0EwOenB61WfJn8pAPq9ETcHKF
         unwGgMfJc5BoJDqkeT4pUoVKbOuEgIDkTtwI0IVX8JfGoFRso3NjueLd67f2VhizIfjb
         lnVQ==
X-Forwarded-Encrypted: i=1; AJvYcCXBVBe7ahXwgJJajLO4O5qwv7RqkZOa4yCRvVnwDq87MbwTtnUYqsb0OumMJJoUdm+33TH2xVs7b8n0wMTysngkTUHZNj9g
X-Gm-Message-State: AOJu0YycHKu8vvFkOYfJyltvo8DhH+68OgEo6K9Sy7zi62nBnokmXFmM
	jxyzxwUJ3z4nY7ovn7i3ZL6yvFlHNiVSn5V1M8bVr7NhlQiaKgsR4HSavthhiR6msYZqim0tXkC
	8UmwzE3prFZSfLc7G5Rb3f0WMy1GhpQCd/8vj8cy/4eXUetsIQweWbvo=
X-Google-Smtp-Source: AGHT+IHSo09wEPx7at03BStfZ2VRmELGpqUvIeiTtyJ7I8yfxlluwu4vCJYFIp1cTivGqT3HGF2d7nhNOr3QXQdZ/XDZ2L3SbkNl
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d15:b0:39a:ea89:22e8 with SMTP id
 e9e14a558f8ab-39aec2d773fmr5162965ab.2.1722268110131; Mon, 29 Jul 2024
 08:48:30 -0700 (PDT)
Date: Mon, 29 Jul 2024 08:48:30 -0700
In-Reply-To: <00000000000061c0a106183499ec@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e9a538061e64cae7@google.com>
Subject: Re: [syzbot] [wireguard?] WARNING in kthread_unpark (2)
From: syzbot <syzbot+943d34fa3cf2191e3068@syzkaller.appspotmail.com>
To: Jason@zx2c4.com, davem@davemloft.net, edumazet@google.com, jason@zx2c4.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com, wireguard@lists.zx2c4.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    dc1c8034e31b minmax: simplify min()/max()/clamp() implemen..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=100341c9980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2258b49cd9b339fa
dashboard link: https://syzkaller.appspot.com/bug?extid=943d34fa3cf2191e3068
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1022b573980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/6699621c3baa/disk-dc1c8034.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/22380dec726f/vmlinux-dc1c8034.xz
kernel image: https://storage.googleapis.com/syzbot-assets/04c3f45e6e2d/bzImage-dc1c8034.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+943d34fa3cf2191e3068@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 53 at kernel/kthread.c:525 __kthread_bind_mask kernel/kthread.c:525 [inline]
WARNING: CPU: 0 PID: 53 at kernel/kthread.c:525 __kthread_bind kernel/kthread.c:538 [inline]
WARNING: CPU: 0 PID: 53 at kernel/kthread.c:525 kthread_unpark+0x16b/0x210 kernel/kthread.c:631
Modules linked in:
CPU: 0 UID: 0 PID: 53 Comm: kworker/u8:3 Not tainted 6.11.0-rc1-syzkaller-00004-gdc1c8034e31b #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
Workqueue: netns cleanup_net

RIP: 0010:__kthread_bind_mask kernel/kthread.c:525 [inline]
RIP: 0010:__kthread_bind kernel/kthread.c:538 [inline]
RIP: 0010:kthread_unpark+0x16b/0x210 kernel/kthread.c:631
Code: 00 fc ff df 41 0f b6 04 06 84 c0 0f 85 93 00 00 00 41 80 4d 03 04 4c 89 e7 48 8b 34 24 e8 ad f7 56 0a eb 09 e8 06 a0 33 00 90 <0f> 0b 90 48 89 ef be 08 00 00 00 e8 c5 b5 97 00 f0 80 65 00 fb 4c
RSP: 0018:ffffc90000bd7760 EFLAGS: 00010293

RAX: ffffffff815fe27a RBX: 0000000000000000 RCX: ffff888015f90000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffff88801fcd8200 R08: ffffffff815fe207 R09: 1ffffffff269d71e
R10: dffffc0000000000 R11: fffffbfff269d71f R12: 0000000000000001
R13: ffff888029c75a2c R14: 1ffff1100538eb45 R15: ffff888029c75a00
FS:  0000000000000000(0000) GS:ffff8880b9200000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fc23f437d60 CR3: 000000007e72a000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 kthread_stop+0x17a/0x630 kernel/kthread.c:707
 destroy_workqueue+0x136/0xc40 kernel/workqueue.c:5793
 wg_destruct+0x1e2/0x2e0 drivers/net/wireguard/device.c:257
 netdev_run_todo+0xe1a/0x1000 net/core/dev.c:10753
 default_device_exit_batch+0xa14/0xa90 net/core/dev.c:11889
 ops_exit_list net/core/net_namespace.c:178 [inline]
 cleanup_net+0x89d/0xcc0 net/core/net_namespace.c:640
 process_one_work kernel/workqueue.c:3231 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3312
 worker_thread+0x86d/0xd40 kernel/workqueue.c:3390
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.


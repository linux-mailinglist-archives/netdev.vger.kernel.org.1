Return-Path: <netdev+bounces-195914-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC9C4AD2AF5
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 02:45:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EA0C16D70C
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 00:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 201FF155A59;
	Tue, 10 Jun 2025 00:45:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E643B7A8
	for <netdev@vger.kernel.org>; Tue, 10 Jun 2025 00:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749516330; cv=none; b=pOPsUF/XMEeJChLOQovJx36U+IMFeRcknKAxNaD3QY7SKHGgKxHGQmn47NDZAF7ESSnK4K5Ki/HVt3MR8J/85EraHnuda4ccDqCNaT6E/g/XuCgErU+RHBBrONng+dQ/XngdOoE8gbotW+K2JW909dhvIGYrnyOqZQtJzlxxBLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749516330; c=relaxed/simple;
	bh=SI+zsbmukKOt9jXEPpJh2/DRwJzOckFoqz3h9ACjj/I=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=O+a61iX/jQtk0fG0p/eadzFRnbUtovPLsdEuirrPXEUXdnbNkZtmqd3wQkaxSfWkp6WPCqiyHXerOUONwi7kW0CM6MeeyBdKzKuJU+09rxV0aOT5LHTPQQSiiHMXBREHMGFdGNxOup51qHQZknpeb9UxlY1I53+1E3Ceu/2OW30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3ddd03db21cso62033925ab.1
        for <netdev@vger.kernel.org>; Mon, 09 Jun 2025 17:45:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749516327; x=1750121127;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3vXw0Vx/zZXGqdGFRpZIGwheacMYUHmkGCxpuAkXY3w=;
        b=ie2oh2Y0GOQpuGw2y0U+YFUQfrS4hzhEO/ctlFSrQYCtVHnQyeaThW0dQtbr+1Zdhg
         EvyNEmPHrmuYrwrwt+JfnSvDqXz/EIOn7duaUqP4l/72PJXiUbsWJh3wClq+gTC2pe+f
         l72NUGtSjYuJveBVKRxcwP7cW9pGUjlr/0Nj8odfT8X/lDp7K9Uqp7YZsTTcLGPV8pc+
         4SotC1yz3TMTFRKkvjHYx6xZAxjMi0u+IqhuWgtzCnBofvHYyqDlcuKZO/ms/Fj/6tfp
         3ihZ86d83eoJ8Uu7eu8Sb0v6wA//YvbmP3a44wHCnXsNxcydV18KbXbOZVS0ziurH2HP
         T7lg==
X-Forwarded-Encrypted: i=1; AJvYcCXwyzP+3aWuivzIM+NZxF1ts//+LVEHvVerpGAPZLbVgfPcm5Tv64SymIvYnaOF1rfRAzGXaKk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyt5jeivf9ECR+eT7DRV41/Df/+ivaiMuZP8/p4VzTwVInrPW4J
	DswDbPpazwksp4LfWAy4FLBigM8W3lS++zPkTGnBw0oAvm+qwwOV1kRqGycwmT996hTHEIHz5nJ
	oAKP0Ni+7BbKszRXYNy2IiecBJwmG2VawHxr1tm+OcgHy5odrUq7pSsUP/AU=
X-Google-Smtp-Source: AGHT+IG2OBnA1i6KetbrOU2KhZJLLAj0AfUFlRV+R/7MI+KT/YbdHg+3ZRKcKJvS92IK6QhRyGNR+vWtZM8+Z6axgk56NhNSGI7I
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:16c6:b0:3dd:ce9b:aa17 with SMTP id
 e9e14a558f8ab-3ddede03deamr6202225ab.20.1749516327640; Mon, 09 Jun 2025
 17:45:27 -0700 (PDT)
Date: Mon, 09 Jun 2025 17:45:27 -0700
In-Reply-To: <6824f447.a70a0220.3e9d8.001d.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68478027.050a0220.33aa0e.02e7.GAE@google.com>
Subject: Re: [syzbot] [net?] possible deadlock in ptp_clock_unregister
From: syzbot <syzbot+eb6f218811a9d721fd53@syzkaller.appspotmail.com>
To: andrew+netdev@lunn.ch, andrew@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, richardcochran@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    19272b37aa4f Linux 6.16-rc1
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13bc5a0c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c4c8362784bb7796
dashboard link: https://syzkaller.appspot.com/bug?extid=eb6f218811a9d721fd53
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15848d70580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17bc5a0c580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/0ceded60de88/disk-19272b37.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/51f4990c81f8/vmlinux-19272b37.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7addf73549b9/bzImage-19272b37.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+eb6f218811a9d721fd53@syzkaller.appspotmail.com

ptp ptp0: delete virtual clock ptp15
============================================
WARNING: possible recursive locking detected
6.16.0-rc1-syzkaller #0 Not tainted
--------------------------------------------
syz-executor421/5891 is trying to acquire lock:
ffff888079fcc868 (&ptp->n_vclocks_mux){+.+.}-{4:4}, at: ptp_vclock_in_use drivers/ptp/ptp_private.h:103 [inline]
ffff888079fcc868 (&ptp->n_vclocks_mux){+.+.}-{4:4}, at: ptp_clock_unregister+0x21/0x250 drivers/ptp/ptp_clock.c:415

but task is already holding lock:
ffff8880300cc868 (&ptp->n_vclocks_mux){+.+.}-{4:4}, at: n_vclocks_store+0xf1/0x6d0 drivers/ptp/ptp_sysfs.c:215

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&ptp->n_vclocks_mux);
  lock(&ptp->n_vclocks_mux);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

4 locks held by syz-executor421/5891:
 #0: ffff88803631c428 (sb_writers#7){.+.+}-{0:0}, at: ksys_write+0x12a/0x250 fs/read_write.c:738
 #1: ffff888031c2c488 (&of->mutex){+.+.}-{4:4}, at: kernfs_fop_write_iter+0x28f/0x510 fs/kernfs/file.c:325
 #2: ffff8880303d4878 (kn->active#57){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x2b2/0x510 fs/kernfs/file.c:326
 #3: ffff8880300cc868 (&ptp->n_vclocks_mux){+.+.}-{4:4}, at: n_vclocks_store+0xf1/0x6d0 drivers/ptp/ptp_sysfs.c:215

stack backtrace:
CPU: 1 UID: 0 PID: 5891 Comm: syz-executor421 Not tainted 6.16.0-rc1-syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_deadlock_bug+0x1e9/0x240 kernel/locking/lockdep.c:3044
 check_deadlock kernel/locking/lockdep.c:3096 [inline]
 validate_chain kernel/locking/lockdep.c:3898 [inline]
 __lock_acquire+0x1106/0x1c90 kernel/locking/lockdep.c:5240
 lock_acquire kernel/locking/lockdep.c:5871 [inline]
 lock_acquire+0x179/0x350 kernel/locking/lockdep.c:5828
 __mutex_lock_common kernel/locking/mutex.c:602 [inline]
 __mutex_lock+0x199/0xb90 kernel/locking/mutex.c:747
 ptp_vclock_in_use drivers/ptp/ptp_private.h:103 [inline]
 ptp_clock_unregister+0x21/0x250 drivers/ptp/ptp_clock.c:415
 ptp_vclock_unregister+0x11a/0x160 drivers/ptp/ptp_vclock.c:228
 unregister_vclock+0x108/0x1a0 drivers/ptp/ptp_sysfs.c:177
 device_for_each_child_reverse+0x136/0x1a0 drivers/base/core.c:4051
 n_vclocks_store+0x4b6/0x6d0 drivers/ptp/ptp_sysfs.c:241
 dev_attr_store+0x58/0x80 drivers/base/core.c:2440
 sysfs_kf_write+0xf2/0x150 fs/sysfs/file.c:145
 kernfs_fop_write_iter+0x351/0x510 fs/kernfs/file.c:334
 new_sync_write fs/read_write.c:593 [inline]
 vfs_write+0x6c4/0x1150 fs/read_write.c:686
 ksys_write+0x12a/0x250 fs/read_write.c:738
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x490 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f577c6b6f29
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 1d 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffefa44cc98 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f577c6b6f29
RDX: 00000000000005c8 RSI: 0000000000000000 RDI: 0000000000000003
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffefa44ccdc
R13: 00007ffefa44ccf0 R14: 00007ffefa44cd30 R15: 0000000000000004
 </TASK>
ptp ptp0: guarantee physical clock free running


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.


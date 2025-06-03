Return-Path: <netdev+bounces-194680-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB809ACBE3D
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 03:40:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96B3E16F569
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 01:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6D9642A96;
	Tue,  3 Jun 2025 01:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gE/e9lhA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3ED4AD23;
	Tue,  3 Jun 2025 01:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748914819; cv=none; b=HQMBoUCst53/cPgRTvjoBHFqDxw8O1ajdmZBnN9jS+l9+5ZEjwFXWGPca52BR0UBC0NhF6AelUimmoauz8ANJffLxda8QEYcyereYTvprne0wkiG0q54wSMYStZuu4q1LD4Jn+c+JeHr9TNid2tHV89ZXllqdHcm1CqGTAM5rd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748914819; c=relaxed/simple;
	bh=7J0pgKaKFzBwfrvkWoziUwlIEoH4HakNQBZv0DWK9Yw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mECDI3O99sOyK8+Df/PshXZ/QlbWAYY5riIZJq4nFzLqJLKv+jTOqZyXMr2Aluei701W2frjBLSJWbrU9kwwQtkPvSb9tBk8rq7dZ5lViIg9c9X24DHSdXPasILXLkoMjNth7xo1qmcjf8r3EHYZJ7JAX/RSfcUgqNmcz2gNKmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gE/e9lhA; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-23539a1a421so24794695ad.0;
        Mon, 02 Jun 2025 18:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748914816; x=1749519616; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZOMsFmfxiEuhbyAkIqsFrzXQShJ3hfe5binJ2ysDiMI=;
        b=gE/e9lhAsNVxpQS+fFItU1mqRJndYNs0mxRwFQQB/YSeYP8GitejLKJm6aPo+eJmso
         V3iQfV9QghO8LTOsyq2crZ9RBTtOVHliWzQZ3FhFVmpiU//TmLu10tBN2FJT9TeMf98E
         Ji15lOrvcgmER1OyK/zUxfdLJaseSM0e5pHpso1R4OQfieLGVEK512IbmL/5jOP64dTW
         zJZGE/bxr4uKLO4lKiLFT8hm7CHpcbn41qPsfNcpXKJ7ZGyk9JzppuzyvOEc+oMOu7sG
         WxXDM/TjTyDk4zzGu0OzshKavV4XYluDZFTVZccevjErhvwSnjhHdbMwoiXGDuMwY+a5
         ntbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748914816; x=1749519616;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZOMsFmfxiEuhbyAkIqsFrzXQShJ3hfe5binJ2ysDiMI=;
        b=JkooWdeYNJda0HoTzrovK3cw0TZxhBII6q67sZAzvX64sB9tjGp7Vp1yVkY4oeQFAf
         sfo5JCcu1UfOhrW8IWqw2NtZcNB2WSwMwMt8WgxlmQH3WLSGvGXqPblmspQOSrbI+XLx
         HP78fViFoadvl3hX/5VNR7i7XdmnG22JFeyFECuk/2LWIhIv5zZHu9HgprT66Esetf/6
         yOd0u4yJk4su4C6PuQnuejVPGU5W87Q8pW2G+iXygZQsJdn+80wMyINZgJeB7KJtFvaU
         D3RQfyITkp+Uy7PifC5m0C2llyVeU+BhUXGmTy5DWzjWecwnRfndZc7f4bDj2+eCAClf
         QvmA==
X-Forwarded-Encrypted: i=1; AJvYcCWUexfFAaDVixRKTmiJfFfNxi8T8dwCkxGioRzD/U2hG0T/8fpziolvQmliHeC0UgswMD+bZIJzoa0eusM=@vger.kernel.org, AJvYcCXcwbH4zQw1lfW3p50FXWXUHIvnAECThvlIEyw24ulz4jRuztj/VH0E3L+HD/QChXbHa1ggC4Qp@vger.kernel.org
X-Gm-Message-State: AOJu0YyYxIqCenR+nB+4mphyBvIsKmGANGmXwPEpEdxc44VP3OQ/LvDw
	WtzyDaG27S9uW1qiLCojJjzPssQtpggF7Pm/Y8ovpFTgxDNkwqOeKMkMIIeF
X-Gm-Gg: ASbGncvaoHeadcHXhaENxppItQ1d3nhc/gR3kDgccGrPA4qfIF5tgMq22bRDDxXV+NG
	v4AITja7Sg1acWqheShe7PJAVNvNuBta9mD0W0TEcWjM83lPrPP5agwTXYiv0WLtRJGSboIW0kt
	S8/44CoTKqkb9Ij+UZ6O/FIh/2xzktJi8T+DRMzNWF227qkD/W8MtHJOxIzMqFuS11+p9F1J91t
	8xicQvamsdFXsoaYotocDP5yNKzImqAMXF2WZvCp3UsPJV64EVbqBvOoxm1a9K3y2ILJWGMff0L
	q0sOG2o2zSq4tQnpN+uodl/KL5Isb2iiCmDJbC++fn0guBds8DAoiPAvVoTAZHTfxjAb6mBd2NA
	BM/GjKAQQfPs3+UjCJ98Zv7A=
X-Google-Smtp-Source: AGHT+IHGC2egZeHelE29q8/qHezRjl/xPEwa4Q8+jO8yki5V38yAtrVwSkJnKQ9wld3cyieYg8oBhg==
X-Received: by 2002:a17:902:c94b:b0:234:bca7:2920 with SMTP id d9443c01a7336-2355f76356dmr163099555ad.24.1748914815658;
        Mon, 02 Jun 2025 18:40:15 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-3124e2b67bcsm6861261a91.8.2025.06.02.18.40.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jun 2025 18:40:15 -0700 (PDT)
Date: Mon, 2 Jun 2025 18:40:14 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: syzbot <syzbot+7e0f89fb6cae5d002de0@syzkaller.appspotmail.com>
Cc: andrew@lunn.ch, davem@davemloft.net, edumazet@google.com,
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, pabeni@redhat.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] possible deadlock in __netdev_update_features
Message-ID: <aD5Sfmu0qXuskU-q@mini-arch>
References: <683d677f.a00a0220.d8eae.004b.GAE@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <683d677f.a00a0220.d8eae.004b.GAE@google.com>

On 06/02, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    7d4e49a77d99 Merge tag 'mm-nonmm-stable-2025-05-31-15-28' ..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1298600c580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=2ea0d63949bc4278
> dashboard link: https://syzkaller.appspot.com/bug?extid=7e0f89fb6cae5d002de0
> compiler:       Debian clang version 20.1.6 (++20250514063057+1e4d39e07757-1~exp1~20250514183223.118), Debian LLD 20.1.6
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/eb4b617767b5/disk-7d4e49a7.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/d0be53c5da74/vmlinux-7d4e49a7.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/9a5769a0ff61/bzImage-7d4e49a7.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+7e0f89fb6cae5d002de0@syzkaller.appspotmail.com
> 
> netdevsim netdevsim1 netdevsim0: unset [0, 0] type 1 family 0 port 8472 - 0
> netdevsim netdevsim1 netdevsim0: unset [1, 0] type 2 family 0 port 6081 - 0
> ============================================
> WARNING: possible recursive locking detected
> 6.15.0-syzkaller-10769-g7d4e49a77d99 #0 Not tainted
> --------------------------------------------
> syz.1.2750/15558 is trying to acquire lock:
> ffff88805a35cd30 (&dev_instance_lock_key#20){+.+.}-{4:4}, at: netdev_lock include/linux/netdevice.h:2756 [inline]
> ffff88805a35cd30 (&dev_instance_lock_key#20){+.+.}-{4:4}, at: netdev_lock_ops include/net/netdev_lock.h:42 [inline]
> ffff88805a35cd30 (&dev_instance_lock_key#20){+.+.}-{4:4}, at: netdev_sync_lower_features net/core/dev.c:10549 [inline]
> ffff88805a35cd30 (&dev_instance_lock_key#20){+.+.}-{4:4}, at: __netdev_update_features+0xcb1/0x1a20 net/core/dev.c:10719
> 
> but task is already holding lock:
> ffff88805a35cd30 (&dev_instance_lock_key#20){+.+.}-{4:4}, at: netdev_lock include/linux/netdevice.h:2756 [inline]
> ffff88805a35cd30 (&dev_instance_lock_key#20){+.+.}-{4:4}, at: netdev_lock_ops include/net/netdev_lock.h:42 [inline]
> ffff88805a35cd30 (&dev_instance_lock_key#20){+.+.}-{4:4}, at: __dev_ethtool net/ethtool/ioctl.c:3227 [inline]
> ffff88805a35cd30 (&dev_instance_lock_key#20){+.+.}-{4:4}, at: dev_ethtool+0x716/0x1990 net/ethtool/ioctl.c:3490
> and the lock comparison function returns 0:
> 
> other info that might help us debug this:
>  Possible unsafe locking scenario:
> 
>        CPU0
>        ----
>   lock(&dev_instance_lock_key#20);
>   lock(&dev_instance_lock_key#20);
> 
>  *** DEADLOCK ***
> 
>  May be due to missing lock nesting notation
> 
> 2 locks held by syz.1.2750/15558:
>  #0: ffffffff8f50b248 (rtnl_mutex){+.+.}-{4:4}, at: dev_ethtool+0x1d0/0x1990 net/ethtool/ioctl.c:3489
>  #1: ffff88805a35cd30 (&dev_instance_lock_key#20){+.+.}-{4:4}, at: netdev_lock include/linux/netdevice.h:2756 [inline]
>  #1: ffff88805a35cd30 (&dev_instance_lock_key#20){+.+.}-{4:4}, at: netdev_lock_ops include/net/netdev_lock.h:42 [inline]
>  #1: ffff88805a35cd30 (&dev_instance_lock_key#20){+.+.}-{4:4}, at: __dev_ethtool net/ethtool/ioctl.c:3227 [inline]
>  #1: ffff88805a35cd30 (&dev_instance_lock_key#20){+.+.}-{4:4}, at: dev_ethtool+0x716/0x1990 net/ethtool/ioctl.c:3490
> 
> stack backtrace:
> CPU: 0 UID: 0 PID: 15558 Comm: syz.1.2750 Not tainted 6.15.0-syzkaller-10769-g7d4e49a77d99 #0 PREEMPT(full) 
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
>  print_deadlock_bug+0x28b/0x2a0 kernel/locking/lockdep.c:3044
>  check_deadlock kernel/locking/lockdep.c:3096 [inline]
>  validate_chain+0x1a3f/0x2140 kernel/locking/lockdep.c:3898
>  __lock_acquire+0xab9/0xd20 kernel/locking/lockdep.c:5240
>  lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5871
>  __mutex_lock_common kernel/locking/mutex.c:602 [inline]
>  __mutex_lock+0x182/0xe80 kernel/locking/mutex.c:747
>  netdev_lock include/linux/netdevice.h:2756 [inline]
>  netdev_lock_ops include/net/netdev_lock.h:42 [inline]
>  netdev_sync_lower_features net/core/dev.c:10549 [inline]
>  __netdev_update_features+0xcb1/0x1a20 net/core/dev.c:10719
>  netdev_change_features+0x72/0xd0 net/core/dev.c:10791
>  bond_compute_features+0x615/0x680 drivers/net/bonding/bond_main.c:1614
>  bond_slave_netdev_event drivers/net/bonding/bond_main.c:4112 [inline]
>  bond_netdev_event+0x72e/0xe80 drivers/net/bonding/bond_main.c:4157
>  notifier_call_chain+0x1b6/0x3e0 kernel/notifier.c:85
>  call_netdevice_notifiers_extack net/core/dev.c:2268 [inline]
>  call_netdevice_notifiers net/core/dev.c:2282 [inline]
>  netdev_features_change+0x85/0xc0 net/core/dev.c:1571
>  __dev_ethtool net/ethtool/ioctl.c:3457 [inline]
>  dev_ethtool+0x1520/0x1990 net/ethtool/ioctl.c:3490
>  dev_ioctl+0x392/0x1150 net/core/dev_ioctl.c:758
>  sock_do_ioctl+0x22c/0x300 net/socket.c:1204
>  sock_ioctl+0x576/0x790 net/socket.c:1311
>  vfs_ioctl fs/ioctl.c:51 [inline]
>  __do_sys_ioctl fs/ioctl.c:907 [inline]
>  __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:893
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7fa86e38e969
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007fa86b98f038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 00007fa86e5b6320 RCX: 00007fa86e38e969
> RDX: 0000200000000080 RSI: 0000000000008946 RDI: 0000000000000006
> RBP: 00007fa86e410ab1 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 0000000000000000 R14: 00007fa86e5b6320 R15: 00007fa86e6dfa28
>  </TASK>
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> 
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
> 
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
> 
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
> 
> If you want to undo deduplication, reply with:
> #syz undup

I'll keep poking this, but I hope to get a reproducer at some point.
The features are evidently changed on the slave device (since it's the
netdevsim who's lock is grabbed twice), but I can't understand which
ethtool call leads to it.


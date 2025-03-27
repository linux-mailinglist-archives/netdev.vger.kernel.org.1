Return-Path: <netdev+bounces-177969-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8FF0A73490
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 15:36:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85E67188D041
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 14:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 302A6217F35;
	Thu, 27 Mar 2025 14:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B9imn3qo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752B120FAAD;
	Thu, 27 Mar 2025 14:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743086186; cv=none; b=Zccdl5t8IIGC1abcyRS9Q030/Vn8sdvnlFPC8X/I311HoOUNggj1Omya+lsEQR4vInk1H1Stt4kq9xcIzM8wUdgQswAhSa9aDCet4IDYy3ZjYwXPSqTsWJKbe4PYbHHPzwZ9SMzoaB1Z4jyA2fsR3UKyJ4ZQpVwhbQkJP9tER+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743086186; c=relaxed/simple;
	bh=aRSJEE4LF/DgyqNP78KuA37ILgQD4/DkDEBzOXdalYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m3zHnfKVQ+8FUHNF8Pbw3yUGiALdn2nlXwTustj+9BfE1uzt+CHjSeJRn23sJNDPq8RqilZqkTbl5hvs2eapg61gLqgewvV1lDyXlBs26mCKEjtwAiXT/8XePtw0tWZueRbw9Uu2TdD2zG9zZ+aLpIY84HMKWURvBzLUplgBU9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B9imn3qo; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-227d6b530d8so21023035ad.3;
        Thu, 27 Mar 2025 07:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743086184; x=1743690984; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wCmk4hmuZJ512kbCxwIcYRx/KVLFgt2B/Rg6XnWmpH0=;
        b=B9imn3qofIk5gUlIvys2NL9TmacUxLEPIbhqOKVo5PcvlaCefmGJEBu9fgAu4Sex5a
         rbbpMpx49ZSxIl2ctFl5HRdRxfaTbGwnz00Z4JwpJY/Rz4nhmglwikFersrDeFt9YdsY
         eSNlPDCzFxRw0O/Nn/ehvmRI03Y0MfL7BeTh+UhCCuQxW/B6EsyUmecSTYMerQM9ED6D
         7QSPDdRGqsQn1n22c54ZVH3XdXI/uh2rs31bGOB6wQyNBq35udLvUuLTwgBD947Qd6ti
         /0K+Ztea2zKom8dAubCbV7CDu55lV3Jhg8t+nlbExMXDZ/jQAV8JP27ayGru4jybwxth
         UBWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743086184; x=1743690984;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wCmk4hmuZJ512kbCxwIcYRx/KVLFgt2B/Rg6XnWmpH0=;
        b=YA86lzX3o8qpdDFAG4koexsBOVJrTpx4lLSs2CZMxC7DSejpnUag2/GswMyVRE3MHj
         LXyKZFpBWfsAzf0lkMcXoJUzXlH5/NALj4ygJnvCx+bsscgm+pfT8vhhqEwXPNBd+Xg9
         zvQHNYJkNGw+6uIccSPnW4c2TDkdAvrm+W+OVgCcndhxtI3An/PIQaoA81198TKgoSkJ
         q+Sa8Bguedch39VD3uBIaQd0SOnfihZRed+gjD1WudAXlh42yN/YcugVz8iXSGRqRFF2
         cw4BiHfPzhbwylk2xIb/BfoiXiBKfJIM9kssGycbcxqZjoh8lo6mBM4lgav5GZJxi0FG
         09yQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbPi4XavMv1OMsr9qvIYAWd8qIZPOO2m7IwYirRuyQzTbZRodyXpAcDYb1FvCvJ2LfdDZ44X3h@vger.kernel.org, AJvYcCWx/inNPnxL06QeK/K/mXVLlo9Fn1Z/b/vNlyj0TkUcuqxDF8cFrck7VWzFTGc/TqmHgRv3RXSvg1IYapU=@vger.kernel.org, AJvYcCXEQjskpUB4/5wcONrkq6dt/enVWIwngUijT0FLq5dFQu+nMPZlpOplCuAXOBXKhPBfj0uF/+Ni3W8h@vger.kernel.org
X-Gm-Message-State: AOJu0YyBhubSu/iTZLCHa5t1jJ7AwPdJpa9jGo6RfomvYQUo1l9vppa6
	p9Bdhn6nXZgSq7tR6rcO5v5F6BDPkHT/2jIUmRPZV8/3R4g3AJY=
X-Gm-Gg: ASbGncsT00ArK39jCVnYlfsrPej23vh1Sh2iEUkP53EjEs45WAWGqmVU5H5Tu5wyDat
	gvrnEVnjsFwPPo3+4vYqi5HYf0ks08IxMtjQssy6Eut9GFMSXxG5orjUhSlvgxkzs1aW4aLA4sv
	lObgpq+F+JRsV3yTLDhFB1max/ZLxR7aagM3J7RgLKontZ3nGMeDls583qtmfvC5N58m/34ncGi
	3scVPZtbB7jruQzSm0BPaPSK7vjRX8/2ycIplM9bHSmiQrKpdmfB7D7pE/ppB1ipaoisgSjpcTr
	ecS5cCydLx/vvyxLe5Bltk0Bs5xH6fHPJvC0NvTuy8aX
X-Google-Smtp-Source: AGHT+IGDGrmcXz0yo6x3fW0RJOxnKZihvpxzy9pmxAKnOwTngC++Wp2N8mMvV7YeUTAcRN/VCZxolA==
X-Received: by 2002:a17:902:fc4f:b0:216:410d:4c53 with SMTP id d9443c01a7336-2280491aa7dmr60192305ad.41.1743086183439;
        Thu, 27 Mar 2025 07:36:23 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2291eec73d6sm143915ad.42.2025.03.27.07.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Mar 2025 07:36:22 -0700 (PDT)
Date: Thu, 27 Mar 2025 07:36:22 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: syzbot <syzbot+377b71db585c9c705f8e@syzkaller.appspotmail.com>
Cc: andrew+netdev@lunn.ch, andrew@lunn.ch, davem@davemloft.net,
	edumazet@google.com, eric.dumazet@gmail.com, horms@kernel.org,
	kuba@kernel.org, linux-kernel@vger.kernel.org,
	linux-x25@vger.kernel.org, lkp@intel.com, llvm@lists.linux.dev,
	ms@dev.tdt.de, netdev@vger.kernel.org,
	oe-kbuild-all@lists.linux.dev, pabeni@redhat.com, sdf@fomichev.me,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [x25?] possible deadlock in lapbeth_device_event
Message-ID: <Z-ViZoezAdjY8TC-@mini-arch>
References: <67cd611c.050a0220.14db68.0073.GAE@google.com>
 <67e55c12.050a0220.2f068f.002c.GAE@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <67e55c12.050a0220.2f068f.002c.GAE@google.com>

On 03/27, syzbot wrote:
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    1a9239bb4253 Merge tag 'net-next-6.15' of git://git.kernel..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=15503804580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=95c3bbe7ce8436a7
> dashboard link: https://syzkaller.appspot.com/bug?extid=377b71db585c9c705f8e
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=139a6bb0580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16974a4c580000
> 
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-1a9239bb.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/bd56e2f824c3/vmlinux-1a9239bb.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/19172b7f9497/bzImage-1a9239bb.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+377b71db585c9c705f8e@syzkaller.appspotmail.com
> 
> ============================================
> WARNING: possible recursive locking detected
> 6.14.0-syzkaller-05877-g1a9239bb4253 #0 Not tainted
> --------------------------------------------
> dhcpcd/5649 is trying to acquire lock:
> ffff888023ad4d28 (&dev->lock){+.+.}-{4:4}, at: netdev_lock include/linux/netdevice.h:2751 [inline]
> ffff888023ad4d28 (&dev->lock){+.+.}-{4:4}, at: netif_napi_add_weight include/linux/netdevice.h:2783 [inline]
> ffff888023ad4d28 (&dev->lock){+.+.}-{4:4}, at: lapbeth_new_device drivers/net/wan/lapbether.c:415 [inline]
> ffff888023ad4d28 (&dev->lock){+.+.}-{4:4}, at: lapbeth_device_event+0x586/0xbe0 drivers/net/wan/lapbether.c:460
> 
> but task is already holding lock:
> ffff888029940d28 (&dev->lock){+.+.}-{4:4}, at: netdev_lock include/linux/netdevice.h:2751 [inline]
> ffff888029940d28 (&dev->lock){+.+.}-{4:4}, at: netdev_lock_ops include/net/netdev_lock.h:42 [inline]
> ffff888029940d28 (&dev->lock){+.+.}-{4:4}, at: netdev_lock_ops include/net/netdev_lock.h:39 [inline]
> ffff888029940d28 (&dev->lock){+.+.}-{4:4}, at: dev_change_flags+0xa7/0x250 net/core/dev_api.c:67
> 
> other info that might help us debug this:
>  Possible unsafe locking scenario:
> 
>        CPU0
>        ----
>   lock(&dev->lock);
>   lock(&dev->lock);
> 
>  *** DEADLOCK ***
> 
>  May be due to missing lock nesting notation
> 
> 2 locks held by dhcpcd/5649:
>  #0: ffffffff900fb268 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_net_lock include/linux/rtnetlink.h:130 [inline]
>  #0: ffffffff900fb268 (rtnl_mutex){+.+.}-{4:4}, at: devinet_ioctl+0x26d/0x1f50 net/ipv4/devinet.c:1121
>  #1: ffff888029940d28 (&dev->lock){+.+.}-{4:4}, at: netdev_lock include/linux/netdevice.h:2751 [inline]
>  #1: ffff888029940d28 (&dev->lock){+.+.}-{4:4}, at: netdev_lock_ops include/net/netdev_lock.h:42 [inline]
>  #1: ffff888029940d28 (&dev->lock){+.+.}-{4:4}, at: netdev_lock_ops include/net/netdev_lock.h:39 [inline]
>  #1: ffff888029940d28 (&dev->lock){+.+.}-{4:4}, at: dev_change_flags+0xa7/0x250 net/core/dev_api.c:67
> 
> stack backtrace:
> CPU: 1 UID: 0 PID: 5649 Comm: dhcpcd Not tainted 6.14.0-syzkaller-05877-g1a9239bb4253 #0 PREEMPT(full) 
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:94 [inline]
>  dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
>  print_deadlock_bug+0x1e9/0x240 kernel/locking/lockdep.c:3042
>  check_deadlock kernel/locking/lockdep.c:3094 [inline]
>  validate_chain kernel/locking/lockdep.c:3896 [inline]
>  __lock_acquire+0xff7/0x1ba0 kernel/locking/lockdep.c:5235
>  lock_acquire kernel/locking/lockdep.c:5866 [inline]
>  lock_acquire+0x179/0x350 kernel/locking/lockdep.c:5823
>  __mutex_lock_common kernel/locking/mutex.c:587 [inline]
>  __mutex_lock+0x19a/0xb00 kernel/locking/mutex.c:732
>  netdev_lock include/linux/netdevice.h:2751 [inline]
>  netif_napi_add_weight include/linux/netdevice.h:2783 [inline]
>  lapbeth_new_device drivers/net/wan/lapbether.c:415 [inline]
>  lapbeth_device_event+0x586/0xbe0 drivers/net/wan/lapbether.c:460
>  notifier_call_chain+0xb9/0x410 kernel/notifier.c:85
>  call_netdevice_notifiers_info+0xbe/0x140 net/core/dev.c:2180
>  call_netdevice_notifiers_extack net/core/dev.c:2218 [inline]
>  call_netdevice_notifiers net/core/dev.c:2232 [inline]
>  __dev_notify_flags+0x12c/0x2e0 net/core/dev.c:9409
>  netif_change_flags+0x108/0x160 net/core/dev.c:9438
>  dev_change_flags+0xba/0x250 net/core/dev_api.c:68
>  devinet_ioctl+0x11d5/0x1f50 net/ipv4/devinet.c:1200
>  inet_ioctl+0x3a7/0x3f0 net/ipv4/af_inet.c:1001
>  sock_do_ioctl+0x115/0x280 net/socket.c:1190
>  sock_ioctl+0x227/0x6b0 net/socket.c:1311
>  vfs_ioctl fs/ioctl.c:51 [inline]
>  __do_sys_ioctl fs/ioctl.c:906 [inline]
>  __se_sys_ioctl fs/ioctl.c:892 [inline]
>  __x64_sys_ioctl+0x190/0x200 fs/ioctl.c:892
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xcd/0x260 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7effd384cd49
> Code: 5c c3 48 8d 44 24 08 48 89 54 24 e0 48 89 44 24 c0 48 8d 44 24 d0 48 89 44 24 c8 b8 10 00 00 00 c7 44 24 b8 10 00 00 00 0f 05 <41> 89 c0 3d 00 f0 ff ff 76 10 48 8b 15 ae 60 0d 00 f7 d8 41 83 c8
> RSP: 002b:00007ffedd440088 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 00007effd377e6c0 RCX: 00007effd384cd49
> RDX: 00007ffedd450278 RSI: 0000000000008914 RDI: 000000000000001a
> RBP: 00007ffedd460438 R08: 00007ffedd450238 R09: 00007ffedd4501e8
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007ffedd450278 R14: 0000000000000028 R15: 0000000000008914
>  </TASK>
> 
> 
> ---
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.

#syz test

diff --git a/drivers/net/wan/lapbether.c b/drivers/net/wan/lapbether.c
index 56326f38fe8a..a022e930bd8e 100644
--- a/drivers/net/wan/lapbether.c
+++ b/drivers/net/wan/lapbether.c
@@ -39,6 +39,7 @@
 #include <linux/lapb.h>
 #include <linux/init.h>
 
+#include <net/netdev_lock.h>
 #include <net/x25device.h>
 
 static const u8 bcast_addr[6] = { 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF };
@@ -372,6 +373,7 @@ static void lapbeth_setup(struct net_device *dev)
 	dev->hard_header_len = 0;
 	dev->mtu             = 1000;
 	dev->addr_len        = 0;
+	netdev_lockdep_set_classes(netdev);
 }
 
 /*	Setup a new device.



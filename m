Return-Path: <netdev+bounces-174027-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17166A5D0DC
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 21:39:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33C187A9CD9
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 20:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6F9826461B;
	Tue, 11 Mar 2025 20:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ShuC62T7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F4E25D8F1;
	Tue, 11 Mar 2025 20:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741725538; cv=none; b=eo9bed8sF2entjkbWFI6O8zQovKwTkcjGvVRDm4rqBofO4HLUvwPJ6SSCOjJB4mImQealoiyNhB63KeTxFJlHahpCQoA+lV49kQhRDnOtdBjYG1YKHYkpxVfHXsYGRQYrWAYx734856+PjM1Anx1vCxrmMzItTQsOB8kgbvsA8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741725538; c=relaxed/simple;
	bh=+pnE8S26cOxGQgOk2NbaBDSUShZ5aHQxiORJQlZEvpI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YkQpctPt75wLpul4r5Uw0jQv6g64Cs/82wrhXnXfSg3thkf6dQZOQOA5OPHBqB7n1UJ0th4d9QxiRVpi4TK7Be7K9x6XNm2XOpb1B/AS2uWBr+PH6cUqp/RzrxbNX4OSIbSWuKQejzKXf+kNNJ8TEdXm476aOVtNCufL934303E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ShuC62T7; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-22398e09e39so111732155ad.3;
        Tue, 11 Mar 2025 13:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741725536; x=1742330336; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/3usn/UZZtQe/TnMG89ExtGE19Z5unYRMnsTNZIsRuk=;
        b=ShuC62T7E/+RtZeWDwF0pn/QmXlJjRuelDALZyJzvMNJTdJyshQ50ybd5Oi3HYS1eW
         KFill5uKs1MFruM1kgUiJwqt3y8gV21YGpHomKRu5l8YugJ9oukj/Op9ZS50WPVaWofe
         DwHCQWyPqIxvKQGok2lL+kUoAkVxIQ02OcL6+X/daACUp8uerfkIOT7f7kqljf/vf9HF
         yvOFhQvttmN9YBrsZ1ocQmqQychomlv2cg/Jp2GezID3/raSZlMJcVwcdA7MSNNXW1TQ
         4s6hFL0Wr09eDozXYnckA9iekku1wo0HbUk4glWCy0BWBvoPlm6G2Ujc6x7knqLpPiAf
         kkCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741725536; x=1742330336;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/3usn/UZZtQe/TnMG89ExtGE19Z5unYRMnsTNZIsRuk=;
        b=ujoHBziqjRJoRbDkBBGK3CXw1TGr2HHsJsM0WjQxCprK+Xoj9sil3XbDHlVbjEhHhv
         NatvyPwYIEV3uGdqLIrJAF5U74l5pYF+QVGFZ0BQAQPt1Vtk77sBjMHgxPWh8JJlrWoj
         PsJeMkmBYAAyeI304tXeUEGIgOO1UhyLFLh3pFljHPzxnqvbehWEFmw/5AKkC138GDNZ
         PMtqa3H08fQs9geQcrIHFmzUISMeOL2c4zxNWZjKhG/GCTB4zpuaq994Cllsj/aUeP/H
         fGXVCfu2klduzRw8UFJonBqgKJJZGN37pk5+hvKnHKdA1QWZ63/Vk+mdetsteIcJ8bAo
         5moQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqxbphHwONtCrwB1xkpwcAZ5Go2npR25ypCmuyh5sHwiNMFI6wl2al1IEhB3zPBarXvied19LG/P6wMNU=@vger.kernel.org, AJvYcCWpLC/R2pxHdgozv/6ljEq7366HnXfAjl0P0fgGlzGelETL/0DRCRdMqPr5b3Et4yTxf586kD5h@vger.kernel.org
X-Gm-Message-State: AOJu0YygV6zVCUfbGreT4MWFBoD6nJTKL9KrHWVh25Nn6u4VXfPQ8ju2
	mKSTPtiVsDxMA8AFfiOvtD50AbvKC6WUSwRhjoHdmZs5/G+6E5U=
X-Gm-Gg: ASbGnctjzfAq0nCF+UBOELVcJg6cDor8xsyP2mL7fAt6gjcosAEKJyIcKDDeE9Hauid
	2BHFVJhqHYkb5CvVUUK6bK/+UiEPuIs1QjkScD7VLlEImOQ01u3tgxKYAY7v7CeY0PdoGO/Bg3B
	U+BZVEv9LP8t9nGCRrzRPbXHFxgyIaARoI5dLQX1yt/rSuGvtLF4dzxVQjPBtX+66/A97EIkrk0
	H/UehPfozc8AI+JLsvsLCMO1fa61zdMhGj/QlQV7CXVmN5mXOv9eI+VY5Oi09Gc/MEeZTlvtTTX
	9YOAnBu4trcD0D7YOA0laW+WcGdHowasZb9/Zn9s09Q/GSk4CXE8z1g=
X-Google-Smtp-Source: AGHT+IESymVby8h9hndCn9tFcuGByfZEgQYFD690GEHxqZxV2Slmr/C/ZWJ0HyJJZN0iRRYeXi3fZA==
X-Received: by 2002:a17:903:1790:b0:224:2a6d:55ae with SMTP id d9443c01a7336-2242a6d585emr291985075ad.48.1741725536226;
        Tue, 11 Mar 2025 13:38:56 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:2844:3d8f:bf3e:12cc])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-224109e944csm102691945ad.74.2025.03.11.13.38.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 13:38:55 -0700 (PDT)
Date: Tue, 11 Mar 2025 13:38:54 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: syzbot <syzbot+b0c03d76056ef6cd12a6@syzkaller.appspotmail.com>
Cc: davem@davemloft.net, edumazet@google.com, horms@kernel.org,
	kuba@kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, pabeni@redhat.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] possible deadlock in dev_set_allmulti
Message-ID: <Z9CfXjLMKn6VLG5d@mini-arch>
References: <67d098bb.050a0220.14e108.001c.GAE@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <67d098bb.050a0220.14e108.001c.GAE@google.com>

On 03/11, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    40587f749df2 Merge branch 'enic-enable-32-64-byte-cqes-and..
> git tree:       net-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=128b1f8c580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=ca99d9d1f4a8ecfa
> dashboard link: https://syzkaller.appspot.com/bug?extid=b0c03d76056ef6cd12a6
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/6d02993a9211/disk-40587f74.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/2c8b300bf362/vmlinux-40587f74.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/2d5be21882cf/bzImage-40587f74.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+b0c03d76056ef6cd12a6@syzkaller.appspotmail.com
> 
> netlink: 'syz.4.478': attribute type 10 has an invalid length.
> netdevsim netdevsim4 netdevsim0: left allmulticast mode
> ============================================
> WARNING: possible recursive locking detected
> 6.14.0-rc5-syzkaller-01183-g40587f749df2 #0 Not tainted
> --------------------------------------------
> syz.4.478/7361 is trying to acquire lock:
> ffff88807b5e4d28 (&dev->lock){+.+.}-{4:4}, at: netdev_lock include/linux/netdevice.h:2731 [inline]
> ffff88807b5e4d28 (&dev->lock){+.+.}-{4:4}, at: netdev_lock_ops include/net/netdev_lock.h:40 [inline]
> ffff88807b5e4d28 (&dev->lock){+.+.}-{4:4}, at: dev_set_allmulti+0x11c/0x270 net/core/dev_api.c:279
> 
> but task is already holding lock:
> ffff88807b5e4d28 (&dev->lock){+.+.}-{4:4}, at: netdev_lock include/linux/netdevice.h:2731 [inline]
> ffff88807b5e4d28 (&dev->lock){+.+.}-{4:4}, at: netdev_lock_ops include/net/netdev_lock.h:40 [inline]
> ffff88807b5e4d28 (&dev->lock){+.+.}-{4:4}, at: dev_open+0x11c/0x260 net/core/dev_api.c:190
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
> 2 locks held by syz.4.478/7361:
>  #0: ffffffff8fed6908 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_lock net/core/rtnetlink.c:80 [inline]
>  #0: ffffffff8fed6908 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_nets_lock net/core/rtnetlink.c:341 [inline]
>  #0: ffffffff8fed6908 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_newlink+0xc4c/0x1d90 net/core/rtnetlink.c:4054
>  #1: ffff88807b5e4d28 (&dev->lock){+.+.}-{4:4}, at: netdev_lock include/linux/netdevice.h:2731 [inline]
>  #1: ffff88807b5e4d28 (&dev->lock){+.+.}-{4:4}, at: netdev_lock_ops include/net/netdev_lock.h:40 [inline]
>  #1: ffff88807b5e4d28 (&dev->lock){+.+.}-{4:4}, at: dev_open+0x11c/0x260 net/core/dev_api.c:190
> 
> stack backtrace:
> CPU: 1 UID: 0 PID: 7361 Comm: syz.4.478 Not tainted 6.14.0-rc5-syzkaller-01183-g40587f749df2 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:94 [inline]
>  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
>  print_deadlock_bug+0x483/0x620 kernel/locking/lockdep.c:3039
>  check_deadlock kernel/locking/lockdep.c:3091 [inline]
>  validate_chain+0x15e2/0x5920 kernel/locking/lockdep.c:3893
>  __lock_acquire+0x1397/0x2100 kernel/locking/lockdep.c:5228
>  lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5851
>  __mutex_lock_common kernel/locking/mutex.c:585 [inline]
>  __mutex_lock+0x19c/0x1010 kernel/locking/mutex.c:730
>  netdev_lock include/linux/netdevice.h:2731 [inline]
>  netdev_lock_ops include/net/netdev_lock.h:40 [inline]
>  dev_set_allmulti+0x11c/0x270 net/core/dev_api.c:279
>  vlan_dev_open+0x2be/0x8a0 net/8021q/vlan_dev.c:278
>  __dev_open+0x45a/0x8a0 net/core/dev.c:1644
>  __dev_change_flags+0x1e2/0x6f0 net/core/dev.c:9375
>  netif_change_flags+0x8b/0x1a0 net/core/dev.c:9438
>  dev_change_flags+0x146/0x270 net/core/dev_api.c:68
>  vlan_device_event+0x1b81/0x1de0 net/8021q/vlan.c:469
>  notifier_call_chain+0x1a5/0x3f0 kernel/notifier.c:85
>  call_netdevice_notifiers_extack net/core/dev.c:2244 [inline]
>  call_netdevice_notifiers net/core/dev.c:2258 [inline]
>  netif_open+0x13a/0x1b0 net/core/dev.c:1672
>  dev_open+0x13e/0x260 net/core/dev_api.c:191
>  bond_enslave+0x103c/0x3910 drivers/net/bonding/bond_main.c:2135
>  do_set_master+0x579/0x730 net/core/rtnetlink.c:2943
>  do_setlink+0xfee/0x40f0 net/core/rtnetlink.c:3149
>  rtnl_changelink net/core/rtnetlink.c:3759 [inline]
>  __rtnl_newlink net/core/rtnetlink.c:3918 [inline]
>  rtnl_newlink+0x15a6/0x1d90 net/core/rtnetlink.c:4055
>  rtnetlink_rcv_msg+0x791/0xcf0 net/core/rtnetlink.c:6945
>  netlink_rcv_skb+0x206/0x480 net/netlink/af_netlink.c:2534
>  netlink_unicast_kernel net/netlink/af_netlink.c:1313 [inline]
>  netlink_unicast+0x7f6/0x990 net/netlink/af_netlink.c:1339
>  netlink_sendmsg+0x8de/0xcb0 net/netlink/af_netlink.c:1883
>  sock_sendmsg_nosec net/socket.c:709 [inline]
>  __sock_sendmsg+0x221/0x270 net/socket.c:724
>  ____sys_sendmsg+0x53a/0x860 net/socket.c:2564
>  ___sys_sendmsg net/socket.c:2618 [inline]
>  __sys_sendmsg+0x269/0x350 net/socket.c:2650
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f191f98d169
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f192081c038 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
> RAX: ffffffffffffffda RBX: 00007f191fba5fa0 RCX: 00007f191f98d169
> RDX: 0000000000000000 RSI: 0000400000000680 RDI: 0000000000000003
> RBP: 00007f191fa0e2a0 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 0000000000000000 R14: 00007f191fba5fa0 R15: 00007ffc4fecad18
>  </TASK>

This one is bad :-( If I read the trace correctly, it's a vlan device
that's being added to a bonding device. In bond_enslave->dev_open,
we lock the vlan device and run the notifiers. And the vlan notifier
uses dev_xxx methods that try to lock the vlan device again.

I will try to repro locally tomorrow. We might have to release the
netdev locks during the notifier runs :-/


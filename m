Return-Path: <netdev+bounces-178827-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 82A64A79128
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 16:25:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72CC61887E23
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 14:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1A2023A57F;
	Wed,  2 Apr 2025 14:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a749+pIR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433DE236458;
	Wed,  2 Apr 2025 14:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743603817; cv=none; b=Q66u2tdgl9X7pYLKS3pQFGseH0F/lUTZ2mHXjnRKbdqLPdkziec47n2cUZcBPwxq8ASOqDFIvcXbuaCcVHe7m7s/PnXVs5dlKgECn7ru96my+NV2n17CB7nsM4JE72NF3WkALRKxYEwqeFVDmZir+4JuUbVxoJ4AL1N+p+LhHBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743603817; c=relaxed/simple;
	bh=1FiqFLgb6Q/HcV892Sw49GKoI2NTqtGQozPUHpoF++4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uyC9fD3tum4ZJh3qdRrYMKPop49DHibG9++H486NHVhvk2opuBXWJzoLery7zh1h2hym5MxkRY3Hldh7El41p+Jm5H+Nw8yqYpGByDsN6LPCm27Z72wemuNmv1IsiDJBFBWOqMb6msu+dGU06UVs//sP+N69sDtn1ZAswRpPeWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a749+pIR; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2ff615a114bso1312510a91.0;
        Wed, 02 Apr 2025 07:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743603815; x=1744208615; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/zo96eujdMMm+kKgIG53SmzgUu9L/H/wLUWvRLLorME=;
        b=a749+pIRagXnFk8okLE9jlDcxak+QWKnwEfXDKjoazsdCdLCFFED7koxvSraa9nL2f
         +EFUYGeR0lCROg46XtNaF4eINWhZfdHd2Dmhjd/eV2zlMEJ7OiWmsmlHoup3eluDYnV/
         rAv/ZpCUOhVFDMfX58RGxUqsIsoesyGzlDoIin35wQLtKMe1AiKoQ+36T7XkEZH5hVdv
         4UAGCmQQvLsWcAo6niflL5m4/sCNKr3NPouELah7wyRyAs0Y+jkdg1tyF5/V2iFQo1nn
         ZWitS6wTZf3iLJhfmyVIiaMuHVIciC1skZPyBFJ16OY2pEkPQYW0arUI15VpBiN9Enz1
         bZ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743603815; x=1744208615;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/zo96eujdMMm+kKgIG53SmzgUu9L/H/wLUWvRLLorME=;
        b=F7Nt1YJ1mxqT39XA1g48esJ4O6L1ATFokVl538cy74YfrpRVn3qOWRqYOxYV5DrA3o
         FyRhBbKIRfnFNrNTh7Z5N5jW8TgsaLZ4NEsU+xsPpihhZd7/4VZ2P4FbFreB/UBUUyRJ
         FnhyUgGvkYcYDkRdz2XSB9CPLl+9fbgKolxNIcGM5BNYhFU7JHRws49+Nl4uCxCOOjKp
         8jmNPX2GKOalLceWNVlU7qIXUEKq0tB/ibY9BWVtP+S3OIY83zzpk60AEuisrLe08sAA
         CES+EC9QSkrmBCZcbDh3HAOPKzzzE9gWqRBozdSHBLZ4kxBiqT7513ua6tJE5IVC+gjE
         W6tw==
X-Forwarded-Encrypted: i=1; AJvYcCWVwx375U0wfEEDc+8qi+/MA/SDDjSf7CR/FqKzaA+zlc7gPHYaT1qo8toK02/RThDlFXaA4w3p@vger.kernel.org, AJvYcCXhQU3SCDBRwOpwUMVJ3DCnnU4lNHpRBQE1+i7UH8npiSadMcQ7FQ42BdeobU68v0E4x2cELbQqfV7UJKc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgDbdFUKmci3xS7MC7F6hWCJdTZlyOl6iPblzEfL6pgFdWVTdC
	DgbBhISNY16xlfYFHjv0hn1VR0oXuzTaJ3BQTlimIjdD4lKi9WtBmYVebbrdSQ==
X-Gm-Gg: ASbGncusM2Dd2c0941MMWyNHxvb7RdWKch0+bNSdpaArb1TRZaXA+9lfItAccgoi8HC
	oagVLpDQ2aE8PZq2YxrYHA6n9po7QOZwB/9FWQo/Gk2giBZvTVJ61uucLN3D4F+tXJ1SMmS4JBP
	bWBPh2IJtQtxza3nLvYuUlrhuASSw726bfSw2S6FA9cG8lmmCK1qeP9ZXrgQNjLE/9KUlgCTsRs
	6pwItvduQ0HeX/aLBP14BYoIKxhkJ/IyuxveQCLK8Y7Rl8K5EH2kFUy6uzlc200Mj0AnLr3olDy
	3Oi2A5X8tTmPaOIscpmHzoKcrgK3ZXG8iei+aGMCh8TmuXnuQZRL/vM=
X-Google-Smtp-Source: AGHT+IHB7MZiodrL8C+6BU6sToH8vvYMr+JtTUP4uILOvEle2ISW33IpGSmQfk3Smcl3TkuEn8Rnkg==
X-Received: by 2002:a17:90a:fc4d:b0:2ff:53d6:2b82 with SMTP id 98e67ed59e1d1-30572120f5fmr3175307a91.11.1743603815344;
        Wed, 02 Apr 2025 07:23:35 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-3056f83c919sm1807395a91.15.2025.04.02.07.23.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 07:23:34 -0700 (PDT)
Date: Wed, 2 Apr 2025 07:23:33 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: syzbot <syzbot+9f46f55b69eb4f3e054b@syzkaller.appspotmail.com>
Cc: davem@davemloft.net, edumazet@google.com, horms@kernel.org,
	kuba@kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, pabeni@redhat.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] possible deadlock in dev_close
Message-ID: <Z-1IZc7G1hrsnzjP@mini-arch>
References: <67ecb690.050a0220.31979b.0036.GAE@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <67ecb690.050a0220.31979b.0036.GAE@google.com>

On 04/01, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    0c86b42439b6 Merge tag 'drm-next-2025-03-28' of https://gi..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1353c678580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=500ed53123ea6589
> dashboard link: https://syzkaller.appspot.com/bug?extid=9f46f55b69eb4f3e054b
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-0c86b424.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/3e78f55971a9/vmlinux-0c86b424.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/3f8acc0407dd/bzImage-0c86b424.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+9f46f55b69eb4f3e054b@syzkaller.appspotmail.com
> 
> loop0: detected capacity change from 0 to 1024
> netlink: 36 bytes leftover after parsing attributes in process `syz.0.0'.
> netlink: 'syz.0.0': attribute type 10 has an invalid length.
> bond0: (slave netdevsim0): Enslaving as an active interface with an up link
> bond0: (slave netdevsim0): Releasing backup interface
> ============================================
> WARNING: possible recursive locking detected
> 6.14.0-syzkaller-09352-g0c86b42439b6 #0 Not tainted
> --------------------------------------------
> syz.0.0/5321 is trying to acquire lock:
> ffff888042eccd28 (&dev->lock){+.+.}-{4:4}, at: netdev_lock include/linux/netdevice.h:2751 [inline]
> ffff888042eccd28 (&dev->lock){+.+.}-{4:4}, at: netdev_lock_ops include/net/netdev_lock.h:42 [inline]
> ffff888042eccd28 (&dev->lock){+.+.}-{4:4}, at: dev_close+0x121/0x280 net/core/dev_api.c:224
> 
> but task is already holding lock:
> ffff888042eccd28 (&dev->lock){+.+.}-{4:4}, at: netdev_lock include/linux/netdevice.h:2751 [inline]
> ffff888042eccd28 (&dev->lock){+.+.}-{4:4}, at: netdev_lock_ops include/net/netdev_lock.h:42 [inline]
> ffff888042eccd28 (&dev->lock){+.+.}-{4:4}, at: do_setlink+0x209/0x4370 net/core/rtnetlink.c:3025
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
> 2 locks held by syz.0.0/5321:
>  #0: ffffffff900e5f48 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_lock net/core/rtnetlink.c:80 [inline]
>  #0: ffffffff900e5f48 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_nets_lock net/core/rtnetlink.c:341 [inline]
>  #0: ffffffff900e5f48 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_newlink+0xd68/0x1fe0 net/core/rtnetlink.c:4061
>  #1: ffff888042eccd28 (&dev->lock){+.+.}-{4:4}, at: netdev_lock include/linux/netdevice.h:2751 [inline]
>  #1: ffff888042eccd28 (&dev->lock){+.+.}-{4:4}, at: netdev_lock_ops include/net/netdev_lock.h:42 [inline]
>  #1: ffff888042eccd28 (&dev->lock){+.+.}-{4:4}, at: do_setlink+0x209/0x4370 net/core/rtnetlink.c:3025
> 
> stack backtrace:
> CPU: 0 UID: 0 PID: 5321 Comm: syz.0.0 Not tainted 6.14.0-syzkaller-09352-g0c86b42439b6 #0 PREEMPT(full) 
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:94 [inline]
>  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
>  print_deadlock_bug+0x2be/0x2d0 kernel/locking/lockdep.c:3042
>  check_deadlock kernel/locking/lockdep.c:3094 [inline]
>  validate_chain+0x928/0x24e0 kernel/locking/lockdep.c:3896
>  __lock_acquire+0xad5/0xd80 kernel/locking/lockdep.c:5235
>  lock_acquire+0x116/0x2f0 kernel/locking/lockdep.c:5866
>  __mutex_lock_common kernel/locking/mutex.c:587 [inline]
>  __mutex_lock+0x1a5/0x10c0 kernel/locking/mutex.c:732
>  netdev_lock include/linux/netdevice.h:2751 [inline]
>  netdev_lock_ops include/net/netdev_lock.h:42 [inline]
>  dev_close+0x121/0x280 net/core/dev_api.c:224
>  __bond_release_one+0xcaf/0x1220 drivers/net/bonding/bond_main.c:2629
>  bond_slave_netdev_event drivers/net/bonding/bond_main.c:4028 [inline]
>  bond_netdev_event+0x557/0xfb0 drivers/net/bonding/bond_main.c:4146
>  notifier_call_chain+0x1a5/0x3f0 kernel/notifier.c:85
>  call_netdevice_notifiers_extack net/core/dev.c:2218 [inline]
>  call_netdevice_notifiers net/core/dev.c:2232 [inline]
>  netif_change_net_namespace+0xa30/0x1c20 net/core/dev.c:12163
>  do_setlink+0x3aa/0x4370 net/core/rtnetlink.c:3042

Looks like it is UNREGISTER notifier for bond. I think this is gonna be
(accidentally) fixed by https://lore.kernel.org/netdev/20250401163452.622454-3-sdf@fomichev.me/T/#u
which stops grabbing instance lock during UNREGISTER.


Return-Path: <netdev+bounces-159480-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC09A15983
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 23:22:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7004A7A061C
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 22:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42C611B0F17;
	Fri, 17 Jan 2025 22:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YsPKB7NE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0DE1B042D
	for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 22:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737152518; cv=none; b=XMP5ZfrwlHNrKM2U3TMl5W3qSLI94qpDVE7w6eslFK4h3ilNvVyQ1ZlIBLjSWlM8EeFse4XFNxSemT2zncRVD2im1gqc9BvFwu6wK2+dszNRgNo+1b3tAl8V+tVYSZCJZQ1c6XHPowL++TD3QVM1mmPes5wKliGbzkZUqvjCcKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737152518; c=relaxed/simple;
	bh=7hKjVTcgsoWn8fwhkRoAQZi2+kPBFHP88sLo+yNmNoU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ij2bd2bE1KUYltKGC8gHJfNRvihbH9Dbo3JVJqz+vDbpPMK8xHfCTep2rRxr6lFPWxZNGF4GG6QHMs4oVWTAqjikncHdg6L9hTXuv2tvh3uV+kIqQSEx5ae87aMZ+87jO4W3CwLD4rihY+mdd0tF8NYwGWc5usek5mHTa4Nc4eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YsPKB7NE; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5d0ac27b412so3462659a12.1
        for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 14:21:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737152514; x=1737757314; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q883B+1Hz5jWmW032DWa4S/tgymd7Yel6BotCiFXAZQ=;
        b=YsPKB7NE+hKZlsfGXh4d9bKpVXfK+NiBOq5libwk5f847f17Wq+TsXpAKTisN18YGg
         o/2I5mLuFBk2rZcoxl3+l2mEGUDpyv6ByDYTm7GOvz+Ft9U2nr6l7Q4jLh5W/1oj038b
         FuPjbO1TLXikpihRsaDY5BcYG0dz5YEckoaXHw+/I5ctQjqjIZapOT1l8qbuveT0oMlP
         d7x6z65JztEsVbeB5wF8gSW295CcqJeBTFMH76gfmF4f2p5mAcTkIcalzfDA3gbQ2ewn
         yJ6ivxD9WHZrtyBado0HJTGHle0efeQxY6ahqxmqHR97QHmfJJFouTcQiog77W28K66l
         XOCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737152514; x=1737757314;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q883B+1Hz5jWmW032DWa4S/tgymd7Yel6BotCiFXAZQ=;
        b=rcyJihGHWW622Ne6oFBzWrt8YRvu7Wvb53mQ7+enpW9p/4S00plnCPQ/mXtwLZk5Jd
         /A/gvl9+UGDJw1WPRYK1S3wZxbV+jVLj4TJm0j/ksdIn9muMhb5t3KSXlfZUY53fVu7A
         LbnPMCD/jykj/A5IEJiTfEnzAzd7NrCafBmVy8Qrw7gNkyvoOs9Tauo+ryUy//cHnOzT
         HuytQZOvRbTmdn73SxgXHEP/jXLOCSoXmf9BkBqxQVIIUilBAHLQgwzfCz0GD9jNRPRj
         S9DJOAvUaNpiUy4DG+xmhnuBGYI2guozp62cSUXG/e7bszMAvttagCdy72KU0hAjtXLo
         jSBg==
X-Forwarded-Encrypted: i=1; AJvYcCUCfQ8bZ/71sMpeXsNuHtvoQNiXnW8nMs5NlOP9JtTtlNIBauTl1qZVDhaZeMLVZkJf3/Vzk0E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKrH5BIdAEV4EXUKbtX/B0zopQyoqrqisAIjLJAImlwSNynwgi
	a/F3xBHRslaklW9P2GogwbX6l9ZtSPcGU4xhJLdydsYriWg8J6b40AcwLZbh0Fblw4FUARg+U1z
	3trOE/qBO/A5m7TvMb9T6MXaSfrbgUhbmSu5e
X-Gm-Gg: ASbGncu3TeAewNjxoVDvF7AqExF3ZnSPyGhh6eiGglGj35pLUuRKMuio/wn78Js5P4Y
	kRBrYxjMuYjj7ZXKdgF99+Rx1gR4DAfFki1KtAVLR4jY2FQ8/rv6p
X-Google-Smtp-Source: AGHT+IFNvEIh5FcL5N94lVMFOyZZYUm3PjpgsVGH68PcGMEFFW/HldggiPUqrIL9tyfTc165QgAKzshDQEWdbFsjv70=
X-Received: by 2002:a05:6402:13d1:b0:5db:7316:6303 with SMTP id
 4fb4d7f45d1cf-5db7d2e36bcmr3132279a12.4.1737152514477; Fri, 17 Jan 2025
 14:21:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250115035319.559603-6-kuba@kernel.org> <20250115085711.42898-1-kuniyu@amazon.com>
In-Reply-To: <20250115085711.42898-1-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 17 Jan 2025 23:21:43 +0100
X-Gm-Features: AbW1kvbuqIVTyxD7TraWrqLjSgLpdyK9vxuEM9VzIlWpTbbgwoSlyNMzSXfwfIg
Message-ID: <CANn89i+o79p0tYH=ttRB7rQUp62fTrVXcxGQ3MN1vw9ZcoBg6w@mail.gmail.com>
Subject: Re: [PATCH net-next v2 05/11] net: protect netdev->napi_list with netdev_lock()
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: kuba@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, 
	horms@kernel.org, jdamato@fastly.com, netdev@vger.kernel.org, 
	pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 15, 2025 at 9:57=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> From: Jakub Kicinski <kuba@kernel.org>
> Date: Tue, 14 Jan 2025 19:53:13 -0800
> > Hold netdev->lock when NAPIs are getting added or removed.
> > This will allow safe access to NAPI instances of a net_device
> > without rtnl_lock.
> >
> > Create a family of helpers which assume the lock is already taken.
> > Switch iavf to them, as it makes extensive use of netdev->lock,
> > already.
> >
> > Reviewed-by: Joe Damato <jdamato@fastly.com>
> > Reviewed-by: Eric Dumazet <edumazet@google.com>
> > Signed-off-by: Jakub Kicinski <kuba@kernel.org>
>
> Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Jakub, has anyone sent the following fix yet ?

CONFIG_DEBUG_MUTEXES=3Dy should show a splat I think otherwise.

[1]
DEBUG_LOCKS_WARN_ON(lock->magic !=3D lock)
WARNING: CPU: 0 PID: 5971 at kernel/locking/mutex.c:564
__mutex_lock_common kernel/locking/mutex.c:564 [inline]
WARNING: CPU: 0 PID: 5971 at kernel/locking/mutex.c:564
__mutex_lock+0xdac/0xee0 kernel/locking/mutex.c:735
Modules linked in:
CPU: 0 UID: 0 PID: 5971 Comm: syz-executor Not tainted
6.13.0-rc7-syzkaller-01131-g8d20dcda404d #0
Hardware name: Google Google Compute Engine/Google Compute Engine,
BIOS Google 12/27/2024
RIP: 0010:__mutex_lock_common kernel/locking/mutex.c:564 [inline]
RIP: 0010:__mutex_lock+0xdac/0xee0 kernel/locking/mutex.c:735
Code: 0f b6 04 38 84 c0 0f 85 1a 01 00 00 83 3d 6f 40 4c 04 00 75 19
90 48 c7 c7 60 84 0a 8c 48 c7 c6 00 85 0a 8c e8 f5 dc 91 f5 90 <0f> 0b
90 90 90 e9 c7 f3 ff ff 90 0f 0b 90 e9 29 f8 ff ff 90 0f 0b
RSP: 0018:ffffc90003317580 EFLAGS: 00010246
RAX: ee0f97edaf7b7d00 RBX: ffff8880299f8cb0 RCX: ffff8880323c9e00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc90003317710 R08: ffffffff81602ac2 R09: 1ffff110170c519a
R10: dffffc0000000000 R11: ffffed10170c519b R12: 0000000000000000
R13: 0000000000000000 R14: 1ffff92000662ec4 R15: dffffc0000000000
FS: 000055557a046500(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fd581d46ff8 CR3: 000000006f870000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
<TASK>
netdev_lock include/linux/netdevice.h:2691 [inline]
__netif_napi_del include/linux/netdevice.h:2829 [inline]
netif_napi_del include/linux/netdevice.h:2848 [inline]
free_netdev+0x2d9/0x610 net/core/dev.c:11621
netdev_run_todo+0xf21/0x10d0 net/core/dev.c:11189
nsim_destroy+0x3c3/0x620 drivers/net/netdevsim/netdev.c:1028
__nsim_dev_port_del+0x14b/0x1b0 drivers/net/netdevsim/dev.c:1428
nsim_dev_port_del_all drivers/net/netdevsim/dev.c:1440 [inline]
nsim_dev_reload_destroy+0x28a/0x490 drivers/net/netdevsim/dev.c:1661
nsim_drv_remove+0x58/0x160 drivers/net/netdevsim/dev.c:1676
device_remove drivers/base/dd.c:567 [inline]
__device_release_driver drivers/base/dd.c:1273 [inline]
device_release_driver_internal+0x4a9/0x7c0 drivers/base/dd.c:1296
bus_remove_device+0x34f/0x420 drivers/base/bus.c:576
device_del+0x57a/0x9b0 drivers/base/core.c:3854
device_unregister+0x20/0xc0 drivers/base/core.c:3895
nsim_bus_dev_del drivers/net/netdevsim/bus.c:462 [inline]
del_device_store+0x363/0x480 drivers/net/netdevsim/bus.c:226
kernfs_fop_write_iter+0x3a0/0x500 fs/kernfs/file.c:334
new_sync_write fs/read_write.c:586 [inline]
vfs_write+0xaeb/0xd30 fs/read_write.c:679
ksys_write+0x18f/0x2b0 fs/read_write.c:731
do_syscall_x64 arch/x86/entry/common.c:52 [inline]

diff --git a/net/core/dev.c b/net/core/dev.c
index fe5f5855593db34cb4bc31e6a637b59b9041bb73..fab4899b83f745a3c13c982775e=
287b1ff2f547d
100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -11593,8 +11593,6 @@ void free_netdev(struct net_device *dev)
                return;
        }

-       mutex_destroy(&dev->lock);
-
        kfree(dev->ethtool);
        netif_free_tx_queues(dev);
        netif_free_rx_queues(dev);
@@ -11621,6 +11619,8 @@ void free_netdev(struct net_device *dev)

        netdev_free_phy_link_topology(dev);

+       mutex_destroy(&dev->lock);
+
        /*  Compatibility with error handling in drivers */
        if (dev->reg_state =3D=3D NETREG_UNINITIALIZED ||
            dev->reg_state =3D=3D NETREG_DUMMY) {


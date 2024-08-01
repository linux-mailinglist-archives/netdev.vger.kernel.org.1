Return-Path: <netdev+bounces-114807-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07355944473
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 08:28:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85C461F21D51
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 06:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B71115852A;
	Thu,  1 Aug 2024 06:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MBmy231d"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E69158523
	for <netdev@vger.kernel.org>; Thu,  1 Aug 2024 06:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722493715; cv=none; b=cuBV76n7/sHKMQZSr/9nl3lL2H2JgPDyJwX0um9wlQ1MpMl3+exg5ocFZiDQy84CxNuMnYCkWvF0G475v2DRCcJkwKfMm4ELOgOYM0C/uVQgmqi3DV6imxK9tcbOHafuI+4KMLm8m0HmsaewRABVVuLkSXKefG5II1gBUvYM/3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722493715; c=relaxed/simple;
	bh=CX0OvbedDWrepXq5Ff+fVTBJovH97z9Wq3vfLFVXQ3o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WDXd6klCWvuXT/j84HCDfSlaBcsqFrjPwJwq/MGpl7aw9E5vLL7Fu4mkV6cDlygIlCFp6Abi1/IYkEU6/ug9quNpxzs3r9hkPwmJJqO4KiVn9Umpzi9BpYPigzw+HRvAr0bWmAQyJLEjhAWFP4ZdrIHwbcqPXBfFoE21GDscIHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MBmy231d; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5a869e3e9dfso28810a12.0
        for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 23:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722493712; x=1723098512; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QYXNdhUYAatsrfG4+QxkF3cxgEI8kD4jOZrGXfLxMPg=;
        b=MBmy231d2iFxGqTOBOiKgtFfrUXqqfeLG8qD26yszCIOaZVweUcmkWdtUerINfUI4q
         TFXpu3lgZ8yy1JGhPW7TFlGH9X5U5KA0lhGHwmdGxkQGMRfeC+jOx/XM4vN3WoHxJKWq
         0Xlh/0eddEU2Xlulke1PPQj75fvvFBFZ2XwUhXE6Wqmgb5pRNZk6ZuB6PcES4HuAjD8c
         KhETl68CI2lb/ypp9+yCvQQ6QG4FxB2dp148yYJqKynCz1Mz8K61ZDM6NMPiNSa7CCbj
         cS0OqBBLu3njc5sVIhEFpdnKwoCCW9rEMSTJWhdf1nd2Vd3zm3lmlM6FFOzRJXiz1gra
         YCzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722493712; x=1723098512;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QYXNdhUYAatsrfG4+QxkF3cxgEI8kD4jOZrGXfLxMPg=;
        b=pFLZQ2Sif0GaTLdmvn7U/gifeBxfomach9XZZA/c7eyvGGLEv+vj3haL4sw8O96GFl
         LTV1nKcQEdQuVgIC1UuYH2m6uVdYp2nfRuE8e12JC7aAZH9ew0UXxf0Mes7BNQJpq8dE
         +qmjFrH0Ol/wOOtPDhTKSFE2MnY1E64aH/gMVkvQixiWdZuJqFr0i+0t9K2SRRfJKOtJ
         O4K4dxUtzeQYBQYm6fA4SM/CdhiNoc3fjFSCYh1fhmM+2sQmL2dMuU0njXtkVE80Uvi6
         9E6tJ8tt4KeBv99X2gN5HfCrAjNBegbiXzUspZyk8YFC0ckRqQlBWcoZ76WM25ylqGS7
         v7gA==
X-Forwarded-Encrypted: i=1; AJvYcCWBZe0JBa3AR3j3ZCcfl8Trbqng8y35emt7mn1Qdq27TprM/R2YLEb9tTZVd3xZYV7bF0lP4o8KNrqJw6Q1S7cZirFV7oYR
X-Gm-Message-State: AOJu0YxEb1SxCVtSaIQRdjsDEyWw/8nAlguOWO1t/O/5bQiv1yWZ1W3k
	zRw7jR0/IfafKFoUz0Nm8DFIA+XASob60GuTzm2Nj/FpSyUdmyyV672q/KcOgpTMTyER30QBlgw
	lttVQ1ap/3KpccJp5PSRfmHwsqN1pXXMxDeT0
X-Google-Smtp-Source: AGHT+IGeek4iZJETeidEv6O9lsAf47eIgvMdLrc9dZm6w3qTHSWzn95bdAV5OmXcUnhZU3W7t+DmM0qV4hBHYAh5Gos=
X-Received: by 2002:a05:6402:40c4:b0:57c:b712:47b5 with SMTP id
 4fb4d7f45d1cf-5b71bbd2aacmr79959a12.4.1722493711462; Wed, 31 Jul 2024
 23:28:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731150940.14106-1-aha310510@gmail.com>
In-Reply-To: <20240731150940.14106-1-aha310510@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 1 Aug 2024 08:28:20 +0200
Message-ID: <CANn89iJn8XT86yyvqD6ZZvjV7eAxBjUd6rddL6NNaXVRimOXhg@mail.gmail.com>
Subject: Re: [PATCH net,v2] rtnetlink: fix possible deadlock in team_port_change_check
To: Jeongjun Park <aha310510@gmail.com>
Cc: jiri@resnulli.us, davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	nicolas.dichtel@6wind.com, liuhangbin@gmail.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	syzbot+44623300f057a28baf1e@syzkaller.appspotmail.com, 
	syzbot+b668da2bc4cb9670bf58@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2024 at 5:10=E2=80=AFPM Jeongjun Park <aha310510@gmail.com>=
 wrote:
>
> In do_setlink() , do_set_master() is called when dev->flags does not have
> the IFF_UP flag set, so 'team->lock' is acquired and dev_open() is called=
,
> which generates the NETDEV_UP event. This causes a deadlock as it tries t=
o
> acquire 'team->lock' again.
>
> To solve this, we need to unlock 'team->lock' before calling dev_open()
> in team_port_add() and then reacquire the lock when dev_open() returns.
> Since the implementation acquires the lock in advance when the team
> structure is used inside dev_open(), data races will not occur even if it
> is briefly unlocked.
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> WARNING: possible recursive locking detected
> 6.11.0-rc1-syzkaller-ge4fc196f5ba3-dirty #0 Not tainted
> --------------------------------------------
> syz.0.15/5889 is trying to acquire lock:
> ffff8880231e4d40 (team->team_lock_key#2){+.+.}-{3:3}, at: team_port_chang=
e_check drivers/net/team/team_core.c:2950 [inline]
> ffff8880231e4d40 (team->team_lock_key#2){+.+.}-{3:3}, at: team_device_eve=
nt+0x2c7/0x770 drivers/net/team/team_core.c:2973
>
> but task is already holding lock:
> ffff8880231e4d40 (team->team_lock_key#2){+.+.}-{3:3}, at: team_add_slave+=
0x9c/0x20e0 drivers/net/team/team_core.c:1975
>
> other info that might help us debug this:
>  Possible unsafe locking scenario:
>
>        CPU0
>        ----
>   lock(team->team_lock_key#2);
>   lock(team->team_lock_key#2);
>
>  *** DEADLOCK ***
>
>  May be due to missing lock nesting notation
>
> 2 locks held by syz.0.15/5889:
>  #0: ffffffff8fa1f4e8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rt=
netlink.c:79 [inline]
>  #0: ffffffff8fa1f4e8 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x3=
72/0xea0 net/core/rtnetlink.c:6644
>  #1: ffff8880231e4d40 (team->team_lock_key#2){+.+.}-{3:3}, at: team_add_s=
lave+0x9c/0x20e0 drivers/net/team/team_core.c:1975
>
> stack backtrace:
> CPU: 1 UID: 0 PID: 5889 Comm: syz.0.15 Not tainted 6.11.0-rc1-syzkaller-g=
e4fc196f5ba3-dirty #0
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.=
16.3-2~bpo12+1 04/01/2014
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:93 [inline]
>  dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:119
>  check_deadlock kernel/locking/lockdep.c:3061 [inline]
>  validate_chain kernel/locking/lockdep.c:3855 [inline]
>  __lock_acquire+0x2167/0x3cb0 kernel/locking/lockdep.c:5142
>  lock_acquire kernel/locking/lockdep.c:5759 [inline]
>  lock_acquire+0x1b1/0x560 kernel/locking/lockdep.c:5724
>  __mutex_lock_common kernel/locking/mutex.c:608 [inline]
>  __mutex_lock+0x175/0x9c0 kernel/locking/mutex.c:752
>  team_port_change_check drivers/net/team/team_core.c:2950 [inline]
>  team_device_event+0x2c7/0x770 drivers/net/team/team_core.c:2973
>  notifier_call_chain+0xb9/0x410 kernel/notifier.c:93
>  call_netdevice_notifiers_info+0xbe/0x140 net/core/dev.c:1994
>  call_netdevice_notifiers_extack net/core/dev.c:2032 [inline]
>  call_netdevice_notifiers net/core/dev.c:2046 [inline]
>  __dev_notify_flags+0x12d/0x2e0 net/core/dev.c:8876
>  dev_change_flags+0x10c/0x160 net/core/dev.c:8914
>  vlan_device_event+0xdfc/0x2120 net/8021q/vlan.c:468
>  notifier_call_chain+0xb9/0x410 kernel/notifier.c:93
>  call_netdevice_notifiers_info+0xbe/0x140 net/core/dev.c:1994
>  call_netdevice_notifiers_extack net/core/dev.c:2032 [inline]
>  call_netdevice_notifiers net/core/dev.c:2046 [inline]
>  dev_open net/core/dev.c:1515 [inline]
>  dev_open+0x144/0x160 net/core/dev.c:1503
>  team_port_add drivers/net/team/team_core.c:1216 [inline]
>  team_add_slave+0xacd/0x20e0 drivers/net/team/team_core.c:1976
>  do_set_master+0x1bc/0x230 net/core/rtnetlink.c:2701
>  do_setlink+0x306d/0x4060 net/core/rtnetlink.c:2907
>  __rtnl_newlink+0xc35/0x1960 net/core/rtnetlink.c:3696
>  rtnl_newlink+0x67/0xa0 net/core/rtnetlink.c:3743
>  rtnetlink_rcv_msg+0x3c7/0xea0 net/core/rtnetlink.c:6647
>  netlink_rcv_skb+0x16b/0x440 net/netlink/af_netlink.c:2550
>  netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
>  netlink_unicast+0x544/0x830 net/netlink/af_netlink.c:1357
>  netlink_sendmsg+0x8b8/0xd70 net/netlink/af_netlink.c:1901
>  sock_sendmsg_nosec net/socket.c:730 [inline]
>  __sock_sendmsg net/socket.c:745 [inline]
>  ____sys_sendmsg+0xab5/0xc90 net/socket.c:2597
>  ___sys_sendmsg+0x135/0x1e0 net/socket.c:2651
>  __sys_sendmsg+0x117/0x1f0 net/socket.c:2680
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7fc07ed77299
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f=
7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff=
 ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007fc07fb7f048 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
> RAX: ffffffffffffffda RBX: 00007fc07ef05f80 RCX: 00007fc07ed77299
> RDX: 0000000000000000 RSI: 0000000020000600 RDI: 0000000000000012
> RBP: 00007fc07ede48e6 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 000000000000000b R14: 00007fc07ef05f80 R15: 00007ffeb5c0d528
>
> Reported-by: syzbot+b668da2bc4cb9670bf58@syzkaller.appspotmail.com
> Fixes: ec4ffd100ffb ("Revert "net: rtnetlink: Enslave device before bring=
ing it up"")
> Signed-off-by: Jeongjun Park <aha310510@gmail.com>
> ---
>  drivers/net/team/team_core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
> index ab1935a4aa2c..ee595c3c6624 100644
> --- a/drivers/net/team/team_core.c
> +++ b/drivers/net/team/team_core.c
> @@ -1212,8 +1212,9 @@ static int team_port_add(struct team *team, struct =
net_device *port_dev,
>                            portname);
>                 goto err_port_enter;
>         }
> -
> +       mutex_unlock(&team->lock);

Why would this be safe ?

All checks done in team_port_add() before this point would need to be
redone after mutex_lock() ?

If another mutex (rtnl ?) is already protecting this path, this would
suggest team->lock should be removed,
and RTNL should be used in all needed paths.

>         err =3D dev_open(port_dev, extack);
> +       mutex_lock(&team->lock);



>         if (err) {
>                 netdev_dbg(dev, "Device %s opening failed\n",
>                            portname);
> --


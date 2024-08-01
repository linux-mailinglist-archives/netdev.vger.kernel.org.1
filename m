Return-Path: <netdev+bounces-114898-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F6A6944A03
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 13:05:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82EA71C22CDB
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 11:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F62418452B;
	Thu,  1 Aug 2024 11:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X4U9a/sV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9792D183CA7;
	Thu,  1 Aug 2024 11:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722510297; cv=none; b=J0l+2dSHHt/sUpMLSgPQ51E6yEqeHc0+6G7PtQIRgs3bTC5xMppI/sxA2hGJ9HMqZ1gDKQwaTodbPAuByPLeTyPXvWkgscXbj/iFnm1Vs8ZS/kqSFsFYt9184PW5gpYNJz44rbHX85mS9fPJ/nb4Sm7NxpW+NWfGbKB+c02Z3Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722510297; c=relaxed/simple;
	bh=rMPo6jmxN3H1IPoeShOrjW8njURZllzZ97Ivi2f+oJQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BRX17GGV03U4baz+SRc8hPNYa+xmeXT/KIViihxSSO1J4UB5WkJlWzLfZfjkBGaa5psaZgnqa8pmBS8M9B4MuPV9rB0mJTblsZhbGAwS+fBfTutquk7B3E/b5hbUowPHaiP7BtqQJ5LiCdV9kkAjDHmX2qy1k3+NQ3dFSGzEieI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X4U9a/sV; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7a263f6439eso4023608a12.3;
        Thu, 01 Aug 2024 04:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722510295; x=1723115095; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mX6OLV0um0JpRGUYRfMKRvLsyg8/fSs5WKF8CDeysfg=;
        b=X4U9a/sVHAlFcDlbHt7h07nW8an1J2CYETdnIB0qi5aDdeoTgfQRZY9s8V1Ghzqo3l
         wprijvhUUNpbNonfhFC/T3q0VRrBJuJxshJ/5z13XeBVY1eInzdNq3v/NLwvNY1MjE6v
         EunuaUYL5INUE+aT6RpHz+rhf8StBubOx3WvbQuy3NOJgsuWjIJdf0XjFGwvE9M50Mf2
         dOnKTCKOCV6sK5xVIJxyYEi87A/F1RRKUn5ETFG5dUYy4InTPnSoO9VcJU6cdDE7f2YC
         Xl5C3IvqkUiDdPNI7dY43hUg7g+hGNiNMlVsYNvAtQMNYho9+jqQvT5hpe5OTCIg3rTf
         LiNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722510295; x=1723115095;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mX6OLV0um0JpRGUYRfMKRvLsyg8/fSs5WKF8CDeysfg=;
        b=iFaBYrw+lEzRly8gOPNaxXaR3s4HQBtdLU8PvwMC+5tR1xworjIDMILz2Dv2D6SnHG
         ptH8/xu9Gioms7Kx8d206o2xYRR2unaVDBz8R3NlEe7KzYK08N6p+BiEIbssCCUMOWGi
         dZb7mubp6TIz3rIilt8XcPQwpbK1VjEXRObLUXNPaglcW9r0pzxRbvM0l7Xv61lNErg1
         gaykFTd7Rr/pwparsJ/cnJkH7nHGbl9Vrnbsu0fyp8EKC48YuLlAV7sfocD4kiv2PQnd
         M2grbiW9KpqPFm5j2aHx/ycVVzEgme2YYMkvGwZtiz5g7AKopxjD56YdZihv4IABrs6Q
         sPtA==
X-Forwarded-Encrypted: i=1; AJvYcCUH7aTCSRJJHIe8AYYb2x5uFUKZLw5C+WcBsEQSu40+p0CtJN6+ex8EusTQWN2g7aKvASqvcDkjRPXDL55uk3PdnHULBRMBnsBDK+JJI4AmXR40bNX3OcFYPYri+dplHPMF+x/Y
X-Gm-Message-State: AOJu0YwykZj/sIbX40BC2tCABbXbaB97lBUwMUiE0hzHAo3d23eKk+Le
	IfetRIDsT5q1CLBnBjidw01u3pHHEHlTFS+l50E9byy7R3AVgQC30Kxh4dVd7EbLTmBIaDKu22H
	TXlitD2bw5cF2nFMCAi3cGQJ1yx8=
X-Google-Smtp-Source: AGHT+IHt3LFvXg02f7rZlJ+hrz9hG+eG57Jt5KZVDf76ighZLAFh45ElK1KichGQnDYuHulDmTvx/qrSPwRIddTRA6c=
X-Received: by 2002:a17:90b:1094:b0:2cf:c972:7c22 with SMTP id
 98e67ed59e1d1-2cfe7875705mr98770a91.10.1722510294632; Thu, 01 Aug 2024
 04:04:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731150940.14106-1-aha310510@gmail.com> <CANn89iJn8XT86yyvqD6ZZvjV7eAxBjUd6rddL6NNaXVRimOXhg@mail.gmail.com>
In-Reply-To: <CANn89iJn8XT86yyvqD6ZZvjV7eAxBjUd6rddL6NNaXVRimOXhg@mail.gmail.com>
From: Jeongjun Park <aha310510@gmail.com>
Date: Thu, 1 Aug 2024 20:04:42 +0900
Message-ID: <CAO9qdTFQHmM_zvbtYqVLGTMrBaovkmC7AM0hsU26iacmx-bM=g@mail.gmail.com>
Subject: Re: [PATCH net,v2] rtnetlink: fix possible deadlock in team_port_change_check
To: Eric Dumazet <edumazet@google.com>
Cc: jiri@resnulli.us, davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	nicolas.dichtel@6wind.com, liuhangbin@gmail.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	syzbot+44623300f057a28baf1e@syzkaller.appspotmail.com, 
	syzbot+b668da2bc4cb9670bf58@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Eric Dumazet wrote:
>
> On Wed, Jul 31, 2024 at 5:10=E2=80=AFPM Jeongjun Park <aha310510@gmail.co=
m> wrote:
> >
> > In do_setlink() , do_set_master() is called when dev->flags does not ha=
ve
> > the IFF_UP flag set, so 'team->lock' is acquired and dev_open() is call=
ed,
> > which generates the NETDEV_UP event. This causes a deadlock as it tries=
 to
> > acquire 'team->lock' again.
> >
> > To solve this, we need to unlock 'team->lock' before calling dev_open()
> > in team_port_add() and then reacquire the lock when dev_open() returns.
> > Since the implementation acquires the lock in advance when the team
> > structure is used inside dev_open(), data races will not occur even if =
it
> > is briefly unlocked.
> >
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > WARNING: possible recursive locking detected
> > 6.11.0-rc1-syzkaller-ge4fc196f5ba3-dirty #0 Not tainted
> > --------------------------------------------
> > syz.0.15/5889 is trying to acquire lock:
> > ffff8880231e4d40 (team->team_lock_key#2){+.+.}-{3:3}, at: team_port_cha=
nge_check drivers/net/team/team_core.c:2950 [inline]
> > ffff8880231e4d40 (team->team_lock_key#2){+.+.}-{3:3}, at: team_device_e=
vent+0x2c7/0x770 drivers/net/team/team_core.c:2973
> >
> > but task is already holding lock:
> > ffff8880231e4d40 (team->team_lock_key#2){+.+.}-{3:3}, at: team_add_slav=
e+0x9c/0x20e0 drivers/net/team/team_core.c:1975
> >
> > other info that might help us debug this:
> >  Possible unsafe locking scenario:
> >
> >        CPU0
> >        ----
> >   lock(team->team_lock_key#2);
> >   lock(team->team_lock_key#2);
> >
> >  *** DEADLOCK ***
> >
> >  May be due to missing lock nesting notation
> >
> > 2 locks held by syz.0.15/5889:
> >  #0: ffffffff8fa1f4e8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/=
rtnetlink.c:79 [inline]
> >  #0: ffffffff8fa1f4e8 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0=
x372/0xea0 net/core/rtnetlink.c:6644
> >  #1: ffff8880231e4d40 (team->team_lock_key#2){+.+.}-{3:3}, at: team_add=
_slave+0x9c/0x20e0 drivers/net/team/team_core.c:1975
> >
> > stack backtrace:
> > CPU: 1 UID: 0 PID: 5889 Comm: syz.0.15 Not tainted 6.11.0-rc1-syzkaller=
-ge4fc196f5ba3-dirty #0
> > Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-=
1.16.3-2~bpo12+1 04/01/2014
> > Call Trace:
> >  <TASK>
> >  __dump_stack lib/dump_stack.c:93 [inline]
> >  dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:119
> >  check_deadlock kernel/locking/lockdep.c:3061 [inline]
> >  validate_chain kernel/locking/lockdep.c:3855 [inline]
> >  __lock_acquire+0x2167/0x3cb0 kernel/locking/lockdep.c:5142
> >  lock_acquire kernel/locking/lockdep.c:5759 [inline]
> >  lock_acquire+0x1b1/0x560 kernel/locking/lockdep.c:5724
> >  __mutex_lock_common kernel/locking/mutex.c:608 [inline]
> >  __mutex_lock+0x175/0x9c0 kernel/locking/mutex.c:752
> >  team_port_change_check drivers/net/team/team_core.c:2950 [inline]
> >  team_device_event+0x2c7/0x770 drivers/net/team/team_core.c:2973
> >  notifier_call_chain+0xb9/0x410 kernel/notifier.c:93
> >  call_netdevice_notifiers_info+0xbe/0x140 net/core/dev.c:1994
> >  call_netdevice_notifiers_extack net/core/dev.c:2032 [inline]
> >  call_netdevice_notifiers net/core/dev.c:2046 [inline]
> >  __dev_notify_flags+0x12d/0x2e0 net/core/dev.c:8876
> >  dev_change_flags+0x10c/0x160 net/core/dev.c:8914
> >  vlan_device_event+0xdfc/0x2120 net/8021q/vlan.c:468
> >  notifier_call_chain+0xb9/0x410 kernel/notifier.c:93
> >  call_netdevice_notifiers_info+0xbe/0x140 net/core/dev.c:1994
> >  call_netdevice_notifiers_extack net/core/dev.c:2032 [inline]
> >  call_netdevice_notifiers net/core/dev.c:2046 [inline]
> >  dev_open net/core/dev.c:1515 [inline]
> >  dev_open+0x144/0x160 net/core/dev.c:1503
> >  team_port_add drivers/net/team/team_core.c:1216 [inline]
> >  team_add_slave+0xacd/0x20e0 drivers/net/team/team_core.c:1976
> >  do_set_master+0x1bc/0x230 net/core/rtnetlink.c:2701
> >  do_setlink+0x306d/0x4060 net/core/rtnetlink.c:2907
> >  __rtnl_newlink+0xc35/0x1960 net/core/rtnetlink.c:3696
> >  rtnl_newlink+0x67/0xa0 net/core/rtnetlink.c:3743
> >  rtnetlink_rcv_msg+0x3c7/0xea0 net/core/rtnetlink.c:6647
> >  netlink_rcv_skb+0x16b/0x440 net/netlink/af_netlink.c:2550
> >  netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
> >  netlink_unicast+0x544/0x830 net/netlink/af_netlink.c:1357
> >  netlink_sendmsg+0x8b8/0xd70 net/netlink/af_netlink.c:1901
> >  sock_sendmsg_nosec net/socket.c:730 [inline]
> >  __sock_sendmsg net/socket.c:745 [inline]
> >  ____sys_sendmsg+0xab5/0xc90 net/socket.c:2597
> >  ___sys_sendmsg+0x135/0x1e0 net/socket.c:2651
> >  __sys_sendmsg+0x117/0x1f0 net/socket.c:2680
> >  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> >  do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > RIP: 0033:0x7fc07ed77299
> > Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89=
 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 =
ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> > RSP: 002b:00007fc07fb7f048 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
> > RAX: ffffffffffffffda RBX: 00007fc07ef05f80 RCX: 00007fc07ed77299
> > RDX: 0000000000000000 RSI: 0000000020000600 RDI: 0000000000000012
> > RBP: 00007fc07ede48e6 R08: 0000000000000000 R09: 0000000000000000
> > R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> > R13: 000000000000000b R14: 00007fc07ef05f80 R15: 00007ffeb5c0d528
> >
> > Reported-by: syzbot+b668da2bc4cb9670bf58@syzkaller.appspotmail.com
> > Fixes: ec4ffd100ffb ("Revert "net: rtnetlink: Enslave device before bri=
nging it up"")
> > Signed-off-by: Jeongjun Park <aha310510@gmail.com>
> > ---
> >  drivers/net/team/team_core.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.=
c
> > index ab1935a4aa2c..ee595c3c6624 100644
> > --- a/drivers/net/team/team_core.c
> > +++ b/drivers/net/team/team_core.c
> > @@ -1212,8 +1212,9 @@ static int team_port_add(struct team *team, struc=
t net_device *port_dev,
> >                            portname);
> >                 goto err_port_enter;
> >         }
> > -
> > +       mutex_unlock(&team->lock);
>
> Why would this be safe ?
>
> All checks done in team_port_add() before this point would need to be
> redone after mutex_lock() ?
>
> If another mutex (rtnl ?) is already protecting this path, this would
> suggest team->lock should be removed,
> and RTNL should be used in all needed paths.
>

If so, I will rewrite the patch and send by modifying
team_port_change_check.

Regards,
Jeongjun Park


Return-Path: <netdev+bounces-178835-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6D4BA791EA
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 17:12:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0992816C06D
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 15:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D497323C392;
	Wed,  2 Apr 2025 15:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RcQchZ01"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76331DDE9;
	Wed,  2 Apr 2025 15:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743606670; cv=none; b=VTrEFXqW2Nb9ZHtzcVWXfw1GrMGszHKTndCJ0H6qJxEs9Q/ITX+7mcRJS8/aod4/Q2mXrLl2wGDxy4lserewDfphjjpQM3bJW571gi+yCdUrwpmByo0iNH8Ql6rcHY9jguBjy0AgSqwOR+e9BtEW11QASkuqUWX+o0FPEIH5PYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743606670; c=relaxed/simple;
	bh=Gy7+76H4H17B/nsJSguUr0yy9F6mAEGxhZdFsyG7ISg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BKcbTlBy8SShuyIQB2jBl9111Pw6ySRZFtZ8XlNE/2lPiAmAjB/BlcvUTizrQTdAwaEWbylC8ACvUXwzosZiQrMTkRyUvZiHhbXxa4iK+ajFw8GZb9XHHiNYFOfbNtiiMZ09znOVWHUdk22HzF2eXQwkBgWDuOJI3OFVREZBdkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RcQchZ01; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5ed43460d6bso10990887a12.0;
        Wed, 02 Apr 2025 08:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743606667; x=1744211467; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RnQVRJFKIGnbMQvnMcbZyyqlZ7fpMvqI3fnP7ViJsec=;
        b=RcQchZ01a0cgUhOnP1RlVVE4Bp2bS8mXLOT/S8QQpEKT1IwP0B2V4og6PmfVkZWOc7
         4gK5B18stXQWaHrcy8nBgmj+qoiLWM65Pt3rJcCkUV1ZFogadywozjUKI5op0dOqCQrC
         AyrqAvwJnYA6VJTfrMf/sXcXvY72x4IV9Zel9i3qAQclz1B9QC0bewXyA3NxOOUwVMnX
         s+GWnTgwczCag6kdRHTVc+VDUZqKNfSPoveWMOjcjNRnTxYytPPZGrNoG+uazpyRSUld
         spmdvZZFInNXvWU7EsTeoURzVF2XSQwxGVI+g7t6espYqxx0zOxf4ABop0hkX2XoTG35
         BB6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743606667; x=1744211467;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RnQVRJFKIGnbMQvnMcbZyyqlZ7fpMvqI3fnP7ViJsec=;
        b=dClTnCYtli0mVe8+j9OQj5EV/KS69bxFaqezLngyX9UT7OkyKn7aOW+pimeBub6RMn
         0n+F9OvB5PDTIvb97nw8o77r7GEt7YfOb3R3Klxeju6mknZLoCLrWzdeH4phVh8giO9u
         kbdmPSgEPIWfy9mjjNNjIVzhS/ZaXbYjZZD/PigdPnQaPYI/ufvhbjkZeC0Fy0AG9nCH
         EY0vL8T8GXmkhIQqVnCT5yShvOlcIzOeB8s0j6lLea6IxCEufWe8YZzw6p0g9tbg6iDM
         pbtLT6euhPc4IXusSKPj82eNVcm3foGKDVy4xElEbnMdxnbk56OBgtWj3PbSyFH5DAI2
         gJYQ==
X-Forwarded-Encrypted: i=1; AJvYcCX44lOwheiaTtdVgNjuIZGsNTMfW+MsToJh2qjew0tMh94Lie7X1P3v4Xv6wG+OS2BQQHdumems@vger.kernel.org, AJvYcCXGtyQjrDa9tegR3g8BgWBaTaQ5+tpBzdeVu1sU5m6RforSIEflRlhxDhu3oaL7TqRXlbR4YqT2TFTFo+4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxx+xe0olJQZ/Vkw4DGya5Gk4PYwrS0JMnTbwXQLWqUEAzC9CL3
	braLDe3FU82MNhPy1QP1Oljqu1HqwnfLRsdtDf4OXLc8aPYA4KQol97d/2caAmBeRssIhENzGZE
	TthBOw+jwnbAKWGLxM8/mA7JHDV0=
X-Gm-Gg: ASbGnctjvJjjQBXRFG6rLxk0G2Et4L7EY7Sk/O2OIYONWQkPAkUSGZlXvo+8nFAL6IH
	7aHe0F/9h4sZ2CD+M9QEuyENqekUGWbLEzY8y1ldBWl7bq67/8QWeZQuQ3k7bVWPa8nx79WO0nP
	VDHFqYWkJMJU14Et/FNpPCkJpgyJ4=
X-Google-Smtp-Source: AGHT+IH7PIqolumojeuUyy4VqFV98cZDxZBB1uv28HASBuik15Ji9hawXbZAd3GDNwWqNP5eycXzCWCaETSEX4JgrmM=
X-Received: by 2002:a05:6402:3488:b0:5e5:bfab:51f with SMTP id
 4fb4d7f45d1cf-5edfb467613mr14954234a12.0.1743606666568; Wed, 02 Apr 2025
 08:11:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <67ecb690.050a0220.31979b.0036.GAE@google.com> <Z-1IZc7G1hrsnzjP@mini-arch>
In-Reply-To: <Z-1IZc7G1hrsnzjP@mini-arch>
From: Taehee Yoo <ap420073@gmail.com>
Date: Thu, 3 Apr 2025 00:10:53 +0900
X-Gm-Features: AQ5f1Jp0po3S2C9BbKIbYSSwzt8U1T8CYHJF-GsIw5BqqWtyN-11scaPZ90QDTQ
Message-ID: <CAMArcTUfKfsB1aZAyD+vVffRsG5ZJYcKgT=jKtJ3ptKqYE7WFw@mail.gmail.com>
Subject: Re: [syzbot] [net?] possible deadlock in dev_close
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: syzbot <syzbot+9f46f55b69eb4f3e054b@syzkaller.appspotmail.com>, 
	davem@davemloft.net, edumazet@google.com, horms@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 2, 2025 at 11:27=E2=80=AFPM Stanislav Fomichev <stfomichev@gmai=
l.com> wrote:
>

Hi Stanislav,

> On 04/01, syzbot wrote:
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    0c86b42439b6 Merge tag 'drm-next-2025-03-28' of https:/=
/gi..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=3D1353c678580=
000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D500ed53123e=
a6589
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3D9f46f55b69eb4=
f3e054b
> > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for D=
ebian) 2.40
> >
> > Unfortunately, I don't have any reproducer for this issue yet.
> >
> > Downloadable assets:
> > disk image (non-bootable): https://storage.googleapis.com/syzbot-assets=
/7feb34a89c2a/non_bootable_disk-0c86b424.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/3e78f55971a9/vmli=
nux-0c86b424.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/3f8acc0407dd=
/bzImage-0c86b424.xz
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the co=
mmit:
> > Reported-by: syzbot+9f46f55b69eb4f3e054b@syzkaller.appspotmail.com
> >
> > loop0: detected capacity change from 0 to 1024
> > netlink: 36 bytes leftover after parsing attributes in process `syz.0.0=
'.
> > netlink: 'syz.0.0': attribute type 10 has an invalid length.
> > bond0: (slave netdevsim0): Enslaving as an active interface with an up =
link
> > bond0: (slave netdevsim0): Releasing backup interface
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > WARNING: possible recursive locking detected
> > 6.14.0-syzkaller-09352-g0c86b42439b6 #0 Not tainted
> > --------------------------------------------
> > syz.0.0/5321 is trying to acquire lock:
> > ffff888042eccd28 (&dev->lock){+.+.}-{4:4}, at: netdev_lock include/linu=
x/netdevice.h:2751 [inline]
> > ffff888042eccd28 (&dev->lock){+.+.}-{4:4}, at: netdev_lock_ops include/=
net/netdev_lock.h:42 [inline]
> > ffff888042eccd28 (&dev->lock){+.+.}-{4:4}, at: dev_close+0x121/0x280 ne=
t/core/dev_api.c:224
> >
> > but task is already holding lock:
> > ffff888042eccd28 (&dev->lock){+.+.}-{4:4}, at: netdev_lock include/linu=
x/netdevice.h:2751 [inline]
> > ffff888042eccd28 (&dev->lock){+.+.}-{4:4}, at: netdev_lock_ops include/=
net/netdev_lock.h:42 [inline]
> > ffff888042eccd28 (&dev->lock){+.+.}-{4:4}, at: do_setlink+0x209/0x4370 =
net/core/rtnetlink.c:3025
> >
> > other info that might help us debug this:
> >  Possible unsafe locking scenario:
> >
> >        CPU0
> >        ----
> >   lock(&dev->lock);
> >   lock(&dev->lock);
> >
> >  *** DEADLOCK ***
> >
> >  May be due to missing lock nesting notation
> >
> > 2 locks held by syz.0.0/5321:
> >  #0: ffffffff900e5f48 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_lock net/core/=
rtnetlink.c:80 [inline]
> >  #0: ffffffff900e5f48 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_nets_lock net/=
core/rtnetlink.c:341 [inline]
> >  #0: ffffffff900e5f48 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_newlink+0xd68/=
0x1fe0 net/core/rtnetlink.c:4061
> >  #1: ffff888042eccd28 (&dev->lock){+.+.}-{4:4}, at: netdev_lock include=
/linux/netdevice.h:2751 [inline]
> >  #1: ffff888042eccd28 (&dev->lock){+.+.}-{4:4}, at: netdev_lock_ops inc=
lude/net/netdev_lock.h:42 [inline]
> >  #1: ffff888042eccd28 (&dev->lock){+.+.}-{4:4}, at: do_setlink+0x209/0x=
4370 net/core/rtnetlink.c:3025
> >
> > stack backtrace:
> > CPU: 0 UID: 0 PID: 5321 Comm: syz.0.0 Not tainted 6.14.0-syzkaller-0935=
2-g0c86b42439b6 #0 PREEMPT(full)
> > Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-=
1.16.3-2~bpo12+1 04/01/2014
> > Call Trace:
> >  <TASK>
> >  __dump_stack lib/dump_stack.c:94 [inline]
> >  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
> >  print_deadlock_bug+0x2be/0x2d0 kernel/locking/lockdep.c:3042
> >  check_deadlock kernel/locking/lockdep.c:3094 [inline]
> >  validate_chain+0x928/0x24e0 kernel/locking/lockdep.c:3896
> >  __lock_acquire+0xad5/0xd80 kernel/locking/lockdep.c:5235
> >  lock_acquire+0x116/0x2f0 kernel/locking/lockdep.c:5866
> >  __mutex_lock_common kernel/locking/mutex.c:587 [inline]
> >  __mutex_lock+0x1a5/0x10c0 kernel/locking/mutex.c:732
> >  netdev_lock include/linux/netdevice.h:2751 [inline]
> >  netdev_lock_ops include/net/netdev_lock.h:42 [inline]
> >  dev_close+0x121/0x280 net/core/dev_api.c:224
> >  __bond_release_one+0xcaf/0x1220 drivers/net/bonding/bond_main.c:2629
> >  bond_slave_netdev_event drivers/net/bonding/bond_main.c:4028 [inline]
> >  bond_netdev_event+0x557/0xfb0 drivers/net/bonding/bond_main.c:4146
> >  notifier_call_chain+0x1a5/0x3f0 kernel/notifier.c:85
> >  call_netdevice_notifiers_extack net/core/dev.c:2218 [inline]
> >  call_netdevice_notifiers net/core/dev.c:2232 [inline]
> >  netif_change_net_namespace+0xa30/0x1c20 net/core/dev.c:12163
> >  do_setlink+0x3aa/0x4370 net/core/rtnetlink.c:3042
>
> Looks like it is UNREGISTER notifier for bond. I think this is gonna be
> (accidentally) fixed by https://lore.kernel.org/netdev/20250401163452.622=
454-3-sdf@fomichev.me/T/#u
> which stops grabbing instance lock during UNREGISTER.
>

I found a reproducer.
    interface=3D<physical interface>
    ip netns add ns_test
    ip link add bond0 type bond
    ip link set $interface master bond0 netns ns_test

So, deadlock occurs, and the splat is the same as in this report.

As you mentioned, I applied[1] and tested again.
I can't see any deadlock or warning.

[1] https://lore.kernel.org/netdev/20250401163452.622454-3-sdf@fomichev.me/=
T/#u

Thanks a lot!
Taehee Yoo


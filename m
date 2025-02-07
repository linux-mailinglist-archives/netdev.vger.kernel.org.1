Return-Path: <netdev+bounces-163826-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D83FDA2BB4C
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 07:25:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2222188A4F0
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 06:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F105615199C;
	Fri,  7 Feb 2025 06:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3UkY4YjF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9140E282F4
	for <netdev@vger.kernel.org>; Fri,  7 Feb 2025 06:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738909543; cv=none; b=nGnLTAZt+3FtfgINz4vV1n3oPQ2evhVDXlH/zv5P9ooITuOOmZstnR4e6zNBL0GRWj/mTlIWSWfZINvPHTAA8oIaEoWNzcY6OXO7w8bmvGIlcI6tSBJpRI4LuPbiiDwKvmwb3o5NwytgqRP8R0T5vq3UAEU3P9CytldTvGtWA/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738909543; c=relaxed/simple;
	bh=bXIZdZxs7eGXTx0vuVPDOPY4a42GVC2i0zQ1SYTcq0s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VVBI8kV7Gn82TMLaKaq7rbOj6+fSWVfKzA4sdefynY1oBQBUc6rAix7dcOsG+sogPNasuEP3CsCGMtnQNDpZHPZ/XsvdpP3inBc3I+saelmiHpllUFI/qA5AxvamsYZ2zQwmaSNsqeLpjuOZgPywo9PubMPCcG/Hz0aklexikFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3UkY4YjF; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5dcd3454922so3495720a12.1
        for <netdev@vger.kernel.org>; Thu, 06 Feb 2025 22:25:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738909540; x=1739514340; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ohdAG9txQz1CvjpN9eGq8jnDlFikXeH1JtQkxtUWyAc=;
        b=3UkY4YjFtE1LslPjOuGEmjabu2PUsDksKswHDtcO+18MvVhof1PfLOSE3Jua0Apo9T
         XvPC6Jhe5GFwEZPt+L80qrDkrX3t5FiqKvkB5CBcUT65/LvdHInih0yfiGEo8T7u41as
         6ItHoAsz5aUVO1G4eqCLnPMBGWyOOoVz3DXbEkfXedwMWbj8p++LfDBnutcgTb0rD1uO
         ozkt/EHSwjV5kqzOn+ns8+9icDefph6pPurojawYeJ8IgW8xr7BzwJeNPubViF7OM9jZ
         B3sVAF07WO5EjwAxbpqoDuZdxxUDc+IY4cSPvyDlwqBAl/ECZaiSYWu2p8qsLUgi2joU
         38Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738909540; x=1739514340;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ohdAG9txQz1CvjpN9eGq8jnDlFikXeH1JtQkxtUWyAc=;
        b=Mnz+FIfU0ReFgG7T/iuVgTIEXYsZhHMZ8bGoYFMABBk4dj/Adj1EbM67f4PHy1Jz/J
         7LGcaaQl8f9Oibu6kr0BkZjfoW07AQhhigFj+VXU2fJHZdxQm1+vVVzXXXE8abFaAC3i
         +JdEFIEyOJuZLPVwcORlYcNCaNCoTEMJkDOfoSaWznu/+GT8k9mXkSTr57JS7YqsPQwZ
         6y/CkCjmhvjSSi8N03pI7MuWeMRX2iGNevsldVhnF7xvbqf28p8GAln5okPSAUCBJn+2
         BDbkwUNZiThWkC0u5CbXMtQT3MYD9mmD2BBnsDMY1vHir5DmMtnovSvUQLJ1ifh+yl2g
         O/tQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJTSN6oXiR7UoaHwJDSTRwjbY9+X7zbbgPdrFN7WgSGYxBu2C0nQHTWFoCoDt/dGHBu+WYuug=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb5wwVxDVVHpS8Cby6asTm168JhrN4tiaZSZcJnridNDBVkGcs
	UhojeP8Y2KWZ/sIpCN+sInOXM5naR9v6TTYvatKOPC6USC5tDkJggGbtBcaKjpdQLKAj9PjRgzp
	cL4ZhGlCIbXRM40tAOzd0d3yNCYwCKPOw1Jqv
X-Gm-Gg: ASbGnct6wGIXN/j5cpAJzKim7Zb8fMp9n6disq5svGFeQt/zj7stI4WcFSySMW6S00k
	TXYzdNB6TY/KTbjiJZw7ttg0etSGEU36aK/mfEaopmqnoUqeQIUsZLG1jh7IqZ1b9nAt/1E+J
X-Google-Smtp-Source: AGHT+IHOy6k4zkk1lgJjEGd/0po3JdWoDyFBvbqJnwGFSc17G/rNURWc9PY2XoGWhlZ/Nd+lG92vDM5KLukj+Cd6qHU=
X-Received: by 2002:a05:6402:524d:b0:5d0:e826:f0dc with SMTP id
 4fb4d7f45d1cf-5de45004961mr2496096a12.12.1738909539443; Thu, 06 Feb 2025
 22:25:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5ae45813.3235.194db3d35f5.Coremail.stitch@zju.edu.cn> <207ed602.3b57.194decf3c35.Coremail.stitch@zju.edu.cn>
In-Reply-To: <207ed602.3b57.194decf3c35.Coremail.stitch@zju.edu.cn>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 7 Feb 2025 07:25:28 +0100
X-Gm-Features: AWEUYZmvr2p_d38r70-VD354-VLG9EB_FiphMDh-FJDsy4FqeBRhDd3Hm492NqE
Message-ID: <CANn89iJ63Luv43WrgqD75c5oYmSrGX-qxYwDVcqpjP8005jTew@mail.gmail.com>
Subject: Re: [BUG] KASAN: slab-use-after-free in slip_open
To: Jiacheng Xu <stitch@zju.edu.cn>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, wolffd@comp.nus.edu.sg
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 7, 2025 at 6:08=E2=80=AFAM Jiacheng Xu <stitch@zju.edu.cn> wrot=
e:
>
> Hi developers,
>
> We update patch as follows. In this version, we avoid to call `dev_close`=
 inside an RCU read-side critical section while still preventing the use of=
 freed memory.
>

This makes no sense for so many reasons.

At this point RTNL is held (drivers/net/slip/slip.c line 803)

rcu_read_lock() is not adding anything in a writer path.
This is really contrary to RCU rules to think that rcu_read_lock()
would be needed here.

Also what happens if kmalloc_array() fails ?

Please, find the root cause, explain what other part of the kernel is
not holding RTNL while it should,
then fix it ?

> --- slip.c   2025-02-07 02:29:27.551293235 +0000
> +++ slip.c      2025-02-07 02:46:57.156076645 +0000
> @@ -717,21 +717,41 @@
>  /* Collect hanged up channels */
>  static void sl_sync(void)
>  {
> -       int i;
> +       int i, count;
>         struct net_device *dev;
> +       struct net_device **devs;
>         struct slip       *sl;
>
> +       devs =3D kmalloc_array(slip_maxdev, sizeof(*devs), GFP_KERNEL);
> +       if (!devs)
> +               return;
> +
> +       rcu_read_lock();
> +       for (i =3D 0; i< slip_maxdev; i++) {
> +               dev =3D rcu_dereference(slip_devs[i]);
> +               if (!dev)
> +                       break;
> +               dev_hold(dev);
> +               devs[count++] =3D dev;
> +       }
> +       rcu_read_unlock();
> +
>         for (i =3D 0; i < slip_maxdev; i++) {
> -               dev =3D slip_devs[i];
> +               dev =3D devs[i];
>                 if (dev =3D=3D NULL)
>                         break;
>
>                 sl =3D netdev_priv(dev);
> -               if (sl->tty || sl->leased)
> +               if (sl->tty || sl->leased) {
> +                       dev_put(dev);
>                         continue;
> +               }
>                 if (dev->flags & IFF_UP)
>                         dev_close(dev);
> +               dev_put(dev);
>         }
> +
> +       kfree(devs);
>  }
>
> Best regards,
> Jiacheng
>
> > -----=E5=8E=9F=E5=A7=8B=E9=82=AE=E4=BB=B6-----
> > =E5=8F=91=E4=BB=B6=E4=BA=BA: "Jiacheng Xu" <stitch@zju.edu.cn>
> > =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4:2025-02-06 20:30:09 (=E6=98=9F=E6=
=9C=9F=E5=9B=9B)
> > =E6=94=B6=E4=BB=B6=E4=BA=BA: andrew+netdev@lunn.ch, davem@davemloft.net=
, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, netdev@vger.kern=
el.org
> > =E6=8A=84=E9=80=81: wolffd@comp.nus.edu.sg
> > =E4=B8=BB=E9=A2=98: [BUG] KASAN: slab-use-after-free in slip_open
> >
> > Hi developers:
> >
> > We are reporting a Linux issue using a modified version of Syzkaller.
> >
> > HEAD commit: 4bbf9020 6.13.0-rc4
> > git tree: upstream
> > kernel config: https://github.com/google/syzkaller/blob/master/dashboar=
d/config/linux/upstream-apparmor-kasan.config
> > syz repro: https://drive.google.com/file/d/1XV9WHwMvK4eZIPuyjiWoTpyQ0Fp=
DaUpT/view?usp=3Dsharing
> > C reproducer: As this is a race condition, a stable C reproducer is not=
 available yet.
> >
> > Environment:
> > Ubuntu 22.04 on Linux 5.15
> > QEMU emulator version 6.2.0
> > qemu-system-x86_64 \
> > -m 2G \
> > -smp 2 \
> > -kernel /home/wd/bzImage \
> > -append "console=3DttyS0 root=3D/dev/sda earlyprintk=3Dserial net.ifnam=
es=3D0" \
> > -drive file=3D/home/wd/bullseye.img,format=3Draw \
> > -net user,host=3D10.0.2.10,hostfwd=3Dtcp:127.0.0.1:10021-:22 \
> > -net nic,model=3De1000 \
> > -enable-kvm \
> > -nographic \
> > -pidfile vm.pid \
> > 2>&1 | tee vm.log
> >
> > Steps to reproduce:
> > 1. Setup a vm on given kernel.
> > 2. Execute the syz reproducer with `./syz-execprog -executor=3D./syz-ex=
ecutor -repeat=3D20000 -procs=3D8 -cover=3D0 ~/repro.prog`
> >
> > Description:
> > The SLIP driver suffers from a Use-After-Free issue in sl_sync() due to=
 unsynchronized access to net_device pointers stored in slip_devs[]. When a=
 device is being freed (for example, via tty_release()/netdev_run_todo()), =
sl_sync() may access it after it has been freed.
> >
> > Patch:
> > We try to write a patch for the crash. And after applying the patch, th=
e crash can no longer be triggered with the PoC.
> >
> > --- slip.c      2025-02-06 12:26:25.690890378 +0000
> > +++ slip.c      2025-02-06 12:29:30.554820899 +0000
> > @@ -721,8 +721,9 @@
> >         struct net_device *dev;
> >         struct slip       *sl;
> >
> > +       rcu_read_lock();
> >         for (i =3D 0; i < slip_maxdev; i++) {
> > -               dev =3D slip_devs[i];
> > +               dev =3D rcu_dereference(slip_devs[i]);
> >                 if (dev =3D=3D NULL)
> >                         break;
> >
> > @@ -732,6 +733,7 @@
> >                 if (dev->flags & IFF_UP)
> >                         dev_close(dev);
> >         }
> > +       rcu_read_unlock();
> >  }
> >
> >
> > If you fix this issue, please add the following tag to the commit:
> > Reported-by: Jiacheng Xu <stitch@zju.edu.cn>, Dylan Wolff <wolffd@comp.=
nus.edu.sg>
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > BUG: KASAN: slab-use-after-free in sl_sync drivers/net/slip/slip.c:732 =
[inline]
> > BUG: KASAN: slab-use-after-free in slip_open+0x293/0x1330 drivers/net/s=
lip/slip.c:806
> > Read of size 4 at addr ffff88805cfca0b0 by task syz-executor.2/46673
> >
> >
> > CPU: 0 UID: 0 PID: 46673 Comm: syz-executor.2 Not tainted 6.13.0-rc4 #2
> >
> >
> > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04=
/01/2014
> >
> > Sched_ext: serialise (enabled+all), task: runnable_at=3D-30ms
> > Call Trace:
> >  <TASK>
> >  __dump_stack lib/dump_stack.c:94 [inline]
> >  dump_stack_lvl+0x229/0x350 lib/dump_stack.c:120
> >  print_address_description mm/kasan/report.c:378 [inline]
> >  print_report+0x164/0x530 mm/kasan/report.c:489
> >  kasan_report+0x147/0x180 mm/kasan/report.c:602
> >  sl_sync drivers/net/slip/slip.c:732 [inline]
> >  slip_open+0x293/0x1330 drivers/net/slip/slip.c:806
> >  tty_ldisc_open+0xbd/0x120 drivers/tty/tty_ldisc.c:432
> >  tty_set_ldisc+0x32b/0x5c0 drivers/tty/tty_ldisc.c:563
> >  tiocsetd+0x126/0x170 drivers/tty/tty_io.c:2439
> >  tty_ioctl+0xe5c/0x1090 drivers/tty/tty_io.c:2739
> >  vfs_ioctl fs/ioctl.c:51 [inline]
> >  __do_sys_ioctl fs/ioctl.c:906 [inline]
> >  __se_sys_ioctl+0x266/0x350 fs/ioctl.c:892
> >  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> >  do_syscall_64+0xf6/0x210 arch/x86/entry/common.c:83
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > RIP: 0033:0x7fed56a903ad
> > Code: c3 e8 a7 2b 00 00 0f 1f 80 00 00 00 00 f3 0f 1e fa 48 89 f8 48 89=
 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 =
ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
> > RSP: 002b:00007fed578b20c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> > RAX: ffffffffffffffda RBX: 00007fed56bcbf80 RCX: 00007fed56a903ad
> > RDX: 0000000020000080 RSI: 0000000000005423 RDI: 0000000000000003
> > RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
> > R10: 0000000000000000 R11: 0000000000000246 R12: 00007fed578b2640
> > R13: 000000000000000e R14: 00007fed56a4fc90 R15: 00007fed578aa000
> >  </TASK>
> >
> >
> > Allocated by task 46683:
> >
> >
> >  kasan_save_stack mm/kasan/common.c:47 [inline]
> >
> >  kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
> >  poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
> >  __kasan_kmalloc+0x89/0xa0 mm/kasan/common.c:394
> >  kasan_kmalloc include/linux/kasan.h:260 [inline]
> >  __do_kmalloc_node mm/slub.c:4298 [inline]
> >  __kmalloc_node_noprof+0x28c/0x530 mm/slub.c:4304
> >  __kvmalloc_node_noprof+0x70/0x180 mm/util.c:650
> >  alloc_netdev_mqs+0xa7/0x1870 net/core/dev.c:11209
> >  sl_alloc drivers/net/slip/slip.c:756 [inline]
> >  slip_open+0x483/0x1330 drivers/net/slip/slip.c:817
> >  tty_ldisc_open+0xbd/0x120 drivers/tty/tty_ldisc.c:432
> >  tty_set_ldisc+0x32b/0x5c0 drivers/tty/tty_ldisc.c:563
> >  tiocsetd+0x126/0x170 drivers/tty/tty_io.c:2439
> >  tty_ioctl+0xe5c/0x1090 drivers/tty/tty_io.c:2739
> >  vfs_ioctl fs/ioctl.c:51 [inline]
> >  __do_sys_ioctl fs/ioctl.c:906 [inline]
> >  __se_sys_ioctl+0x266/0x350 fs/ioctl.c:892
> >  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> >  do_syscall_64+0xf6/0x210 arch/x86/entry/common.c:83
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >
> >
> > Freed by task 46682:
> >
> >
> >  kasan_save_stack mm/kasan/common.c:47 [inline]
> >
> >  kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
> >  kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:582
> >  poison_slab_object mm/kasan/common.c:247 [inline]
> >  __kasan_slab_free+0x5a/0x70 mm/kasan/common.c:264
> >  kasan_slab_free include/linux/kasan.h:233 [inline]
> >  slab_free_hook mm/slub.c:2353 [inline]
> >  slab_free mm/slub.c:4613 [inline]
> >  kfree+0x196/0x450 mm/slub.c:4761
> >  device_release+0xcd/0x240
> >  kobject_cleanup lib/kobject.c:689 [inline]
> >  kobject_release lib/kobject.c:720 [inline]
> >  kref_put include/linux/kref.h:65 [inline]
> >  kobject_put+0x248/0x490 lib/kobject.c:737
> >  netdev_run_todo+0x10e0/0x1280 net/core/dev.c:10924
> >  tty_ldisc_kill+0xbf/0x150 drivers/tty/tty_ldisc.c:613
> >  tty_ldisc_release+0x1ae/0x210 drivers/tty/tty_ldisc.c:781
> >  tty_release_struct+0x2a/0x100 drivers/tty/tty_io.c:1690
> >  tty_release+0xe4d/0x1460 drivers/tty/tty_io.c:1861
> >  __fput+0x2ba/0xa80 fs/file_table.c:450
> >  __fput_sync+0x180/0x1e0 fs/file_table.c:535
> >  __do_sys_close fs/open.c:1554 [inline]
> >  __se_sys_close fs/open.c:1539 [inline]
> >  __x64_sys_close+0x93/0x120 fs/open.c:1539
> >  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> >  do_syscall_64+0xf6/0x210 arch/x86/entry/common.c:83
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >
> >
> > The buggy address belongs to the object at ffff88805cfca000
> >
> >
> >  which belongs to the cache kmalloc-cg-4k of size 4096
> >
> > The buggy address is located 176 bytes inside of
> >  freed 4096-byte region [ffff88805cfca000, ffff88805cfcb000)
> >
> >
> > The buggy address belongs to the physical page:
> >
> >
> > page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x5c=
fc8
> >
> > head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
> > memcg:ffff888075c64a01
> > flags: 0x4fff00000000040(head|node=3D1|zone=3D1|lastcpupid=3D0x7ff)
> > page_type: f5(slab)
> > raw: 04fff00000000040 ffff88801d44f500 dead000000000100 dead00000000012=
2
> > raw: 0000000000000000 0000000000040004 00000001f5000000 ffff888075c64a0=
1
> > head: 04fff00000000040 ffff88801d44f500 dead000000000100 dead0000000001=
22
> > head: 0000000000000000 0000000000040004 00000001f5000000 ffff888075c64a=
01
> > head: 04fff00000000003 ffffea000173f201 ffffffffffffffff 00000000000000=
00
> > head: 0000000000000008 0000000000000000 00000000ffffffff 00000000000000=
00
> > page dumped because: kasan: bad access detected
> > page_owner tracks the page as allocated
> > page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c=
0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC)=
, pid 9660, tgid 9660 (syz-executor.1), ts 93383578089, free_ts 93076565836
> >  set_page_owner include/linux/page_owner.h:32 [inline]
> >  post_alloc_hook+0x1f6/0x240 mm/page_alloc.c:1558
> >  prep_new_page mm/page_alloc.c:1566 [inline]
> >  get_page_from_freelist+0x3586/0x36d0 mm/page_alloc.c:3476
> >  __alloc_pages_noprof+0x260/0x680 mm/page_alloc.c:4753
> >  alloc_pages_mpol_noprof+0x3c8/0x650 mm/mempolicy.c:2269
> >  alloc_slab_page+0x6a/0x110 mm/slub.c:2423
> >  allocate_slab+0x5f/0x2b0 mm/slub.c:2589
> >  new_slab mm/slub.c:2642 [inline]
> >  ___slab_alloc+0xbdf/0x1490 mm/slub.c:3830
> >  __slab_alloc mm/slub.c:3920 [inline]
> >  __slab_alloc_node mm/slub.c:3995 [inline]
> >  slab_alloc_node mm/slub.c:4156 [inline]
> >  __do_kmalloc_node mm/slub.c:4297 [inline]
> >  __kmalloc_node_track_caller_noprof+0x30f/0x520 mm/slub.c:4317
> >  kmemdup_noprof+0x2b/0x60 mm/util.c:135
> >  __addrconf_sysctl_register+0xb1/0x430 net/ipv6/addrconf.c:7221
> >  addrconf_sysctl_register+0x1bd/0x220 net/ipv6/addrconf.c:7287
> >  ipv6_add_dev+0xe13/0x13e0 net/ipv6/addrconf.c:456
> >  addrconf_notify+0x6d8/0x1170 net/ipv6/addrconf.c:3674
> >  notifier_call_chain+0x1c6/0x410 kernel/notifier.c:85
> >  call_netdevice_notifiers_extack net/core/dev.c:2034 [inline]
> >  call_netdevice_notifiers+0xd3/0x110 net/core/dev.c:2048
> >  register_netdevice+0x190c/0x1da0 net/core/dev.c:10632
> > page last free pid 100 tgid 100 stack trace:
> >  reset_page_owner include/linux/page_owner.h:25 [inline]
> >  free_pages_prepare mm/page_alloc.c:1127 [inline]
> >  free_unref_folios+0xe03/0x1860 mm/page_alloc.c:2706
> >  shrink_folio_list+0x4698/0x5c80 mm/vmscan.c:1483
> >  evict_folios+0x3b12/0x5610 mm/vmscan.c:4593
> >  try_to_shrink_lruvec+0x941/0xc10 mm/vmscan.c:4789
> >  shrink_one+0x20e/0x870 mm/vmscan.c:4834
> >  shrink_many mm/vmscan.c:4897 [inline]
> >  lru_gen_shrink_node mm/vmscan.c:4975 [inline]
> >  shrink_node+0x3862/0x3f20 mm/vmscan.c:5956
> >  kswapd_shrink_node mm/vmscan.c:6785 [inline]
> >  balance_pgdat mm/vmscan.c:6977 [inline]
> >  kswapd+0x1c9f/0x36f0 mm/vmscan.c:7246
> >  kthread+0x2c3/0x360 kernel/kthread.c:389
> >  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
> >  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
> >
> >
> > Memory state around the buggy address:
> >
> >
> >  ffff88805cfc9f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> >
> >  ffff88805cfca000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> > >ffff88805cfca080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> >                                      ^
> >  ffff88805cfca100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> >  ffff88805cfca180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > Hi developers:
> >
> >
> > We are reporting a Linux issue using a modified version of Syzkaller.
> >
> >
> > HEAD commit: 4bbf9020 6.13.0-rc4
> >
> > git tree: upstream
> > kernel config: https://github.com/google/syzkaller/blob/master/dashboar=
d/config/linux/upstream-apparmor-kasan.config
> > syz repro: https://drive.google.com/file/d/1XV9WHwMvK4eZIPuyjiWoTpyQ0Fp=
DaUpT/view?usp=3Dsharing
> > C reproducer: As this is a race condition, we cannot obtain a stable C =
reproducer.
> >
> >
> > Description:
> >
> > The SLIP driver suffers from a concurrent Use-After-Free issue in sl_sy=
nc() due to
> > unsynchronized access to net_device pointers stored in slip_devs[]. Whe=
n a
> > device is being freed (for example, via tty_release()/netdev_run_todo()=
),
> > sl_sync() may access it after it has been freed.
> >
> > Steps to reproducer:
> >
> > 1. Setup a vm on the given kernel.
> > 2. Use syzkaller to run syz repro with `./syz-execprog -executor=3D./sy=
z-executor -repeat=3D20000 -procs=3D8 -cover=3D0 ~/repro.prog`.
> >
> >
> > Environment:
> >
> > Ubuntu 22.04 on Linux 5.15
> > QEMU emulator version 6.2.0
> > qemu-system-x86_64 \
> > -m 2G \
> > -smp 2 \
> > -kernel /home/wd/bzImage \
> > -append "console=3DttyS0 root=3D/dev/sda earlyprintk=3Dserial net.ifnam=
es=3D0" \
> > -drive file=3D/home/wd/bullseye.img,format=3Draw \
> > -net user,host=3D10.0.2.10,hostfwd=3Dtcp:127.0.0.1:10021-:22 \
> > -net nic,model=3De1000 \
> > -enable-kvm \
> > -nographic \
> > -pidfile vm.pid \
> > 2>&1 | tee vm.log
> >
> > If you fix this issue, please add the following tag to the commit:
> >
> > Reported-by: Jiacheng Xu <stitch@zju.edu.cn>
> >


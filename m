Return-Path: <netdev+bounces-177971-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D8558A7349C
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 15:39:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE1F61898294
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 14:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D29C2218587;
	Thu, 27 Mar 2025 14:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h9nkx333"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA25B4502A
	for <netdev@vger.kernel.org>; Thu, 27 Mar 2025 14:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743086342; cv=none; b=WfraQr1L21b3WerKu8krRwEAiQg9Z2+FzEb54TYMz3SWiKJ2tP/0yZNBh+nvevgxDIb8pbtp+opNW9Qt/paFwx+/OPll1iEbTYSBnt0cJdCR3z3mzKWcuw6YI9WWuQVSkWF1whBh6Pj/aB1v8RDjbn4M+ynDkSNtvTuhHNPY3AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743086342; c=relaxed/simple;
	bh=x9QlGDaam6o5Bpo1hcR0eOzE9bGV7mWdb2Irs7tKTKY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mozxKXDPbmIc3fueyJB1PXkVl8H+zAB080+aZ8MFl8/EcT+Uq4BbiVtS0Dzbwv/dbxpsn2NWd3O2kXik8jFHDjU0K/DqDpF6BIHwZVBx0R1CRNuIeu6vSD3Ne+db1wnFg++aCZtc7Om0VLeox+h8bAE+zHldr4kwnJG6cUVBhMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h9nkx333; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-477282401b3so11436431cf.1
        for <netdev@vger.kernel.org>; Thu, 27 Mar 2025 07:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743086338; x=1743691138; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JmMO3C6WJRKxmjElqR4h2O/T/e04udPSOOJuOLGMb8I=;
        b=h9nkx333Ud7QKNBkTJYNHx11UdNAiNY9CEVhrXGskj8akGbCYDJyI8W5g3YYokivcB
         fUOvswSkCPsaw82IwFJy7Jl/LMKtYkfFH2g8i7XlUbgCvreaT2PX+hpWTsgj09kveqjn
         nan4hIggrM+2OvxgyDnM3rTnVb+xoZmxvE4e27IRLJ+GA+KMFB7XuBW3VKu4UTW8JfWv
         pIGcFKGlWezJq8sYjUzKX0XFYCUHkXLr+nrDupDkmMHQyQAgsWdkj6euv1J1//RYaRkP
         BgfvyItDVO1VyqUl/kEGCtr6ljwqUlDD8/kUkdKpuQsEra6hxHt8PiPB1jNnfbXiZPZr
         zzkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743086338; x=1743691138;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JmMO3C6WJRKxmjElqR4h2O/T/e04udPSOOJuOLGMb8I=;
        b=RoCNCabWNsGgPtf1Q6Eq/P1tTngNfkBCPEhIZGZJWgAvPUh9S+5U+CiFwpcHHyFm14
         8nYJ2l/G+SJgyPbuAiCUeZBvgGxEahc4INvlCc8uJf3iY9Tl0StU4A8v/HK0KavSLvbf
         +ApPQrUXS680YPnT1frqO07Jn7LsOuM6HgxT+bV2Y0sq7UfbfL8jNAd9dh2YnXz7R0A0
         QQcS9VJoPBiRP9Jb8wBZ51rl/9NL3PXF55ZXO4plBshTSLkXnf3/rieI72Izsbai9fzp
         hIuClVLP5v+5i9sXQ6XzbJvvNsvd0dq66kTK7AJm7iNBdgQFfKb86QYtkax9PpEdakai
         PFEw==
X-Forwarded-Encrypted: i=1; AJvYcCV4HOwrUYa92skbGj14/0j56ZJBMF1YmIKBKUKBJjdsdDhNYZy0yaSEPHLT7ztk8TPSr48uwes=@vger.kernel.org
X-Gm-Message-State: AOJu0YyR7dSKGbzaTjgMDjP7QGw9dNa1qGEIFBMbohB1/N8gP9dzaAly
	SV/8pL3hPCHsYR6d+E0MfbygNCbqqhF4f5VsFVG7rSbku4stw5trswDT1BejQMGJBYJXStx0Gdt
	q8FUkIeRvFeMZ9S/OigWfIQGePQwT/2hLtJEU
X-Gm-Gg: ASbGnctNsk0ucywWl+MUnuFV8wRDsF3ah3LDgHNGUUkgQacb1iBEA0DrgBY2FTJ9+V4
	M9QDZ6rTrmGWm3c9Qoo+V9c3+OLIsuByZmz64NkhZrLSKafSvwRMya/cfZl5ffNMoLIffGCWMai
	B6OWuLwTYwkZEHOakBFjDIzLycura1/cnFwGW8PA==
X-Google-Smtp-Source: AGHT+IGFVNJngEaJar1RXdAZevtiNFQ10K053IOtSNqa9I3uZ3ttSMUJPFbX/FtkzoBIjo3zwAiZxXxgVo0wA00IEqM=
X-Received: by 2002:a05:622a:4c07:b0:476:8ee8:d8a2 with SMTP id
 d75a77b69052e-4776e072fcdmr60721751cf.4.1743086338210; Thu, 27 Mar 2025
 07:38:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <67cd611c.050a0220.14db68.0073.GAE@google.com> <67e55c12.050a0220.2f068f.002c.GAE@google.com>
 <Z-ViZoezAdjY8TC-@mini-arch>
In-Reply-To: <Z-ViZoezAdjY8TC-@mini-arch>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 27 Mar 2025 15:38:46 +0100
X-Gm-Features: AQ5f1JrgTL2mJ_QuJgIZLPrm649fAWQfanOuafK0pRqr1bU-nCQUQV7h3ZW2YhA
Message-ID: <CANn89iKXRXXA392PY9uuL560JNW0ee_hGTu3xk=6X=6jRR2OkQ@mail.gmail.com>
Subject: Re: [syzbot] [x25?] possible deadlock in lapbeth_device_event
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: syzbot <syzbot+377b71db585c9c705f8e@syzkaller.appspotmail.com>, 
	andrew+netdev@lunn.ch, andrew@lunn.ch, davem@davemloft.net, 
	eric.dumazet@gmail.com, horms@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, linux-x25@vger.kernel.org, lkp@intel.com, 
	llvm@lists.linux.dev, ms@dev.tdt.de, netdev@vger.kernel.org, 
	oe-kbuild-all@lists.linux.dev, pabeni@redhat.com, sdf@fomichev.me, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 27, 2025 at 3:36=E2=80=AFPM Stanislav Fomichev <stfomichev@gmai=
l.com> wrote:
>
> On 03/27, syzbot wrote:
> > syzbot has found a reproducer for the following issue on:
> >
> > HEAD commit:    1a9239bb4253 Merge tag 'net-next-6.15' of git://git.ker=
nel..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=3D15503804580=
000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D95c3bbe7ce8=
436a7
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3D377b71db585c9=
c705f8e
> > compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for=
 Debian) 2.40
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D139a6bb05=
80000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D16974a4c580=
000
> >
> > Downloadable assets:
> > disk image (non-bootable): https://storage.googleapis.com/syzbot-assets=
/7feb34a89c2a/non_bootable_disk-1a9239bb.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/bd56e2f824c3/vmli=
nux-1a9239bb.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/19172b7f9497=
/bzImage-1a9239bb.xz
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the co=
mmit:
> > Reported-by: syzbot+377b71db585c9c705f8e@syzkaller.appspotmail.com
> >
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > WARNING: possible recursive locking detected
> > 6.14.0-syzkaller-05877-g1a9239bb4253 #0 Not tainted
> > --------------------------------------------
> > dhcpcd/5649 is trying to acquire lock:
> > ffff888023ad4d28 (&dev->lock){+.+.}-{4:4}, at: netdev_lock include/linu=
x/netdevice.h:2751 [inline]
> > ffff888023ad4d28 (&dev->lock){+.+.}-{4:4}, at: netif_napi_add_weight in=
clude/linux/netdevice.h:2783 [inline]
> > ffff888023ad4d28 (&dev->lock){+.+.}-{4:4}, at: lapbeth_new_device drive=
rs/net/wan/lapbether.c:415 [inline]
> > ffff888023ad4d28 (&dev->lock){+.+.}-{4:4}, at: lapbeth_device_event+0x5=
86/0xbe0 drivers/net/wan/lapbether.c:460
> >
> > but task is already holding lock:
> > ffff888029940d28 (&dev->lock){+.+.}-{4:4}, at: netdev_lock include/linu=
x/netdevice.h:2751 [inline]
> > ffff888029940d28 (&dev->lock){+.+.}-{4:4}, at: netdev_lock_ops include/=
net/netdev_lock.h:42 [inline]
> > ffff888029940d28 (&dev->lock){+.+.}-{4:4}, at: netdev_lock_ops include/=
net/netdev_lock.h:39 [inline]
> > ffff888029940d28 (&dev->lock){+.+.}-{4:4}, at: dev_change_flags+0xa7/0x=
250 net/core/dev_api.c:67
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
> > 2 locks held by dhcpcd/5649:
> >  #0: ffffffff900fb268 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_net_lock inclu=
de/linux/rtnetlink.h:130 [inline]
> >  #0: ffffffff900fb268 (rtnl_mutex){+.+.}-{4:4}, at: devinet_ioctl+0x26d=
/0x1f50 net/ipv4/devinet.c:1121
> >  #1: ffff888029940d28 (&dev->lock){+.+.}-{4:4}, at: netdev_lock include=
/linux/netdevice.h:2751 [inline]
> >  #1: ffff888029940d28 (&dev->lock){+.+.}-{4:4}, at: netdev_lock_ops inc=
lude/net/netdev_lock.h:42 [inline]
> >  #1: ffff888029940d28 (&dev->lock){+.+.}-{4:4}, at: netdev_lock_ops inc=
lude/net/netdev_lock.h:39 [inline]
> >  #1: ffff888029940d28 (&dev->lock){+.+.}-{4:4}, at: dev_change_flags+0x=
a7/0x250 net/core/dev_api.c:67
> >
> > stack backtrace:
> > CPU: 1 UID: 0 PID: 5649 Comm: dhcpcd Not tainted 6.14.0-syzkaller-05877=
-g1a9239bb4253 #0 PREEMPT(full)
> > Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-=
1.16.3-2~bpo12+1 04/01/2014
> > Call Trace:
> >  <TASK>
> >  __dump_stack lib/dump_stack.c:94 [inline]
> >  dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
> >  print_deadlock_bug+0x1e9/0x240 kernel/locking/lockdep.c:3042
> >  check_deadlock kernel/locking/lockdep.c:3094 [inline]
> >  validate_chain kernel/locking/lockdep.c:3896 [inline]
> >  __lock_acquire+0xff7/0x1ba0 kernel/locking/lockdep.c:5235
> >  lock_acquire kernel/locking/lockdep.c:5866 [inline]
> >  lock_acquire+0x179/0x350 kernel/locking/lockdep.c:5823
> >  __mutex_lock_common kernel/locking/mutex.c:587 [inline]
> >  __mutex_lock+0x19a/0xb00 kernel/locking/mutex.c:732
> >  netdev_lock include/linux/netdevice.h:2751 [inline]
> >  netif_napi_add_weight include/linux/netdevice.h:2783 [inline]
> >  lapbeth_new_device drivers/net/wan/lapbether.c:415 [inline]
> >  lapbeth_device_event+0x586/0xbe0 drivers/net/wan/lapbether.c:460
> >  notifier_call_chain+0xb9/0x410 kernel/notifier.c:85
> >  call_netdevice_notifiers_info+0xbe/0x140 net/core/dev.c:2180
> >  call_netdevice_notifiers_extack net/core/dev.c:2218 [inline]
> >  call_netdevice_notifiers net/core/dev.c:2232 [inline]
> >  __dev_notify_flags+0x12c/0x2e0 net/core/dev.c:9409
> >  netif_change_flags+0x108/0x160 net/core/dev.c:9438
> >  dev_change_flags+0xba/0x250 net/core/dev_api.c:68
> >  devinet_ioctl+0x11d5/0x1f50 net/ipv4/devinet.c:1200
> >  inet_ioctl+0x3a7/0x3f0 net/ipv4/af_inet.c:1001
> >  sock_do_ioctl+0x115/0x280 net/socket.c:1190
> >  sock_ioctl+0x227/0x6b0 net/socket.c:1311
> >  vfs_ioctl fs/ioctl.c:51 [inline]
> >  __do_sys_ioctl fs/ioctl.c:906 [inline]
> >  __se_sys_ioctl fs/ioctl.c:892 [inline]
> >  __x64_sys_ioctl+0x190/0x200 fs/ioctl.c:892
> >  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> >  do_syscall_64+0xcd/0x260 arch/x86/entry/syscall_64.c:94
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > RIP: 0033:0x7effd384cd49
> > Code: 5c c3 48 8d 44 24 08 48 89 54 24 e0 48 89 44 24 c0 48 8d 44 24 d0=
 48 89 44 24 c8 b8 10 00 00 00 c7 44 24 b8 10 00 00 00 0f 05 <41> 89 c0 3d =
00 f0 ff ff 76 10 48 8b 15 ae 60 0d 00 f7 d8 41 83 c8
> > RSP: 002b:00007ffedd440088 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> > RAX: ffffffffffffffda RBX: 00007effd377e6c0 RCX: 00007effd384cd49
> > RDX: 00007ffedd450278 RSI: 0000000000008914 RDI: 000000000000001a
> > RBP: 00007ffedd460438 R08: 00007ffedd450238 R09: 00007ffedd4501e8
> > R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> > R13: 00007ffedd450278 R14: 0000000000000028 R15: 0000000000008914
> >  </TASK>
> >
> >
> > ---
> > If you want syzbot to run the reproducer, reply with:
> > #syz test: git://repo/address.git branch-or-commit-hash
> > If you attach or paste a git patch, syzbot will apply it before testing=
.
>
> #syz test
>
> diff --git a/drivers/net/wan/lapbether.c b/drivers/net/wan/lapbether.c
> index 56326f38fe8a..a022e930bd8e 100644
> --- a/drivers/net/wan/lapbether.c
> +++ b/drivers/net/wan/lapbether.c
> @@ -39,6 +39,7 @@
>  #include <linux/lapb.h>
>  #include <linux/init.h>
>
> +#include <net/netdev_lock.h>
>  #include <net/x25device.h>
>
>  static const u8 bcast_addr[6] =3D { 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF }=
;
> @@ -372,6 +373,7 @@ static void lapbeth_setup(struct net_device *dev)
>         dev->hard_header_len =3D 0;
>         dev->mtu             =3D 1000;
>         dev->addr_len        =3D 0;
> +       netdev_lockdep_set_classes(netdev);
>  }
>
>  /*     Setup a new device.
>

I can resubmit https://lore.kernel.org/netdev/Z84MME6rwU6q9aJa@mini-arch/T/


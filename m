Return-Path: <netdev+bounces-161406-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1D7EA21090
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 19:13:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 686B97A1A02
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 18:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 793171DF259;
	Tue, 28 Jan 2025 18:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="prmBdiyG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F2B1C5F1D
	for <netdev@vger.kernel.org>; Tue, 28 Jan 2025 18:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738087999; cv=none; b=M3wLPNY8NSUkcHW3wOY04NWxmfUkWtNpVJ6JWQAcul3Qd2WnT0f2MEzn7gvfsBb+BQJo1rgB+/mlTB8MQlndJOpiTUf+Dus92D6Er0sPad8syli3+QwZnvaRPuTGtQ/K+bv9TXmpsBHo5hhjmI900BXQcqM3mjsROxVFnfyIU8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738087999; c=relaxed/simple;
	bh=E4n66wb1tO1CrPqADF5aDddk9iqClZWGi8GSABskhKQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UO2gYGN4KO0Cyzvryqpg+jp1lW08VE3+Bmv2VWbbUApvkzAygDQl0OyAxhQCMTMp4pKaejYbOQIed71b1KnRhmdnmMhQ79JOuMGphjL86rIxevRNN8dKhRWeRlGPva7eAjE+MbjNLUd7P0tk1nVmu2BoEVY2vHEkQeZA/ybtSbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=prmBdiyG; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-21644aca3a0so139554565ad.3
        for <netdev@vger.kernel.org>; Tue, 28 Jan 2025 10:13:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738087996; x=1738692796; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W7rzbY0nanYtvZszV/766JNaRk5IfSAQrouw3U7sLxA=;
        b=prmBdiyGWHqsQrSTsTEahCs1HW6YSSTnOhwBISXHthwlCRwfOquApmj7Kaj7sOZrUM
         aAAGIt/CyPGAO5fHflR92u7qgN3R2yeoRzRXChdpaI+N9hA1wuNi+4fLd7VcFUMIBQ9L
         6I4EtZA8uJ1KNYsOp6Iz+me7AfUzu9tjfG8lK08VD7HtM52jJbRoPIad+TbRaLq4VlAo
         73OMgvfEWgumCEcC0B9+5RFJW93FgIManFEQXfveRYe589kSVN+DBjmwbAj7jjhlXim3
         hkvfAziJ1fmzErx9T7N6YwlHC4deXh7VeOBs/mbaDfR5H3AN8yhw8RYZAvXK0aTY+fE8
         zJ2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738087996; x=1738692796;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W7rzbY0nanYtvZszV/766JNaRk5IfSAQrouw3U7sLxA=;
        b=mpJJiWdxZrHcspvOEeI2/aMImwLx+h9EtD7za0VX31moR/a4WTOkrNN8RlaCIlL0se
         MidD3l49CkpBoarDMMyyq61tCrYIRVL4zVoMb725PM3Ts2XAA5cfJ0VZ7mAzh+kOfZHc
         Zh1nZ4Epg6PWasgFItSdZ2pfCqWHdjRatA3mFyLIbiXf89fV9z9klryYsuttfJYRa5BI
         JOWv3SwU3zXtzgBcTJL5Mo+RFBrhEKxn30AitemSyXSUJCiEAoAz/mSWqEYGVEk4h9V8
         SXTePpmwgmg0oRULw+ldQC2qrRqv0JONSUDcQxz6OjrT2gwX0BXHnLZp0j5Gi/yqIa+2
         Iz7A==
X-Forwarded-Encrypted: i=1; AJvYcCXbZeqc8geIGHaiLEj/vRdfe14SF4PbWTvOs/hx7AVsubzdq1Hay/36JZQhCbe0o95D4ipgjtg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTT3avleuZ4VFSHS6u80WB93lurzCztTHUktRRRzAYm1apMZIO
	Sb3EUopS8MYpJmR0+9AJOb3hpw9vMKhQmdhKdC/AqtLKuJv2HvHlyyACRlvF+rUp+YSFFBnPlDr
	+SLw+MwzM8AH+4hhAB5F8wYd/l1ym4qylA49n
X-Gm-Gg: ASbGnctv6I35b+Glhm26ZjWx4alPNYIAhFbtIG0woz5zOvElEm/+okNOophXs+TYITZ
	yOB/da40AKvZ+VpIYYHcRgCWfId3l2ph4qVmk8BdMtjaVdj0huHPlsEMXy4Z109XOdpFIt6avBh
	PGxQTUKYTQjjWfgOJJzEqUOuQgZP8=
X-Google-Smtp-Source: AGHT+IGle3yh4BqboRfG+cJjhGTwjOdGWbLUo1zDS1S652YRZ9alCsqXtRW3oCM1iZZRgftT8iBuTSJSNlF05K6lfbg=
X-Received: by 2002:a17:902:f60f:b0:215:a3fd:61f5 with SMTP id
 d9443c01a7336-21dd7c44516mr537135ad.5.1738087994067; Tue, 28 Jan 2025
 10:13:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000c1ae9e062164e101@google.com> <6789d55f.050a0220.20d369.004e.GAE@google.com>
 <CANn89iJiQeF=7g0wFVOZ=TMUnL-7U0xvw4ZQL5H5f4+ChBp__w@mail.gmail.com>
In-Reply-To: <CANn89iJiQeF=7g0wFVOZ=TMUnL-7U0xvw4ZQL5H5f4+ChBp__w@mail.gmail.com>
From: Aleksandr Nogikh <nogikh@google.com>
Date: Tue, 28 Jan 2025 19:13:02 +0100
X-Gm-Features: AWEUYZnbqEJqMPxQh9W2tZaXAzc2i7bKqe44KKGxwgDtXQNfbAcAzOxGbxHsMf8
Message-ID: <CANp29Y6MrxrKSAWx_Hqk1_mWBSWwKy39-Z_BDK09_FW3VJfF2Q@mail.gmail.com>
Subject: Re: [syzbot] [wireless?] possible deadlock in ieee80211_remove_interfaces
To: Eric Dumazet <edumazet@google.com>
Cc: syzbot <syzbot+5b9196ecf74447172a9a@syzkaller.appspotmail.com>, 
	davem@davemloft.net, johannes@sipsolutions.net, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com, 
	Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Eric,

On Fri, Jan 17, 2025 at 5:14=E2=80=AFAM 'Eric Dumazet' via syzkaller-bugs
<syzkaller-bugs@googlegroups.com> wrote:
>
> On Fri, Jan 17, 2025 at 4:58=E2=80=AFAM syzbot
> <syzbot+5b9196ecf74447172a9a@syzkaller.appspotmail.com> wrote:
> >
> > syzbot has found a reproducer for the following issue on:
> >
> > HEAD commit:    8d20dcda404d selftests: drv-net-hw: inject pp_alloc_fai=
l e..
> > git tree:       net-next
> > console output: https://syzkaller.appspot.com/x/log.txt?x=3D14ef5a18580=
000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dc30f048a4f1=
2891
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3D5b9196ecf7444=
7172a9a
> > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for D=
ebian) 2.40
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D15d7a1f85=
80000
> >
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/5ce07c743ced/d=
isk-8d20dcda.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/66f2a9a35d5e/vmli=
nux-8d20dcda.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/4c790c086a46=
/bzImage-8d20dcda.xz
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the co=
mmit:
> > Reported-by: syzbot+5b9196ecf74447172a9a@syzkaller.appspotmail.com
> >
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> > WARNING: possible circular locking dependency detected
> > 6.13.0-rc7-syzkaller-01131-g8d20dcda404d #0 Not tainted
> > ------------------------------------------------------
> > kworker/u8:6/3534 is trying to acquire lock:
> > ffffffff8fcb4a08 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_acquire_if_cleanup_=
net net/core/dev.c:10281 [inline]
> > ffffffff8fcb4a08 (rtnl_mutex){+.+.}-{4:4}, at: unregister_netdevice_man=
y_notify+0xac2/0x2030 net/core/dev.c:11783
> >
> > but task is already holding lock:
> > ffff8880216b0768 (&rdev->wiphy.mtx){+.+.}-{4:4}, at: class_wiphy_constr=
uctor include/net/cfg80211.h:6034 [inline]
> > ffff8880216b0768 (&rdev->wiphy.mtx){+.+.}-{4:4}, at: ieee80211_remove_i=
nterfaces+0x129/0x700 net/mac80211/iface.c:2276
> >
> > which lock already depends on the new lock.
> >
> >
> > the existing dependency chain (in reverse order) is:
> >
> > -> #1 (&rdev->wiphy.mtx){+.+.}-{4:4}:
> >        lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
> >        __mutex_lock_common kernel/locking/mutex.c:585 [inline]
> >        __mutex_lock+0x1ac/0xee0 kernel/locking/mutex.c:735
> >        wiphy_lock include/net/cfg80211.h:6019 [inline]
> >        wiphy_register+0x1a49/0x27b0 net/wireless/core.c:1006
> >        ieee80211_register_hw+0x30fb/0x3e10 net/mac80211/main.c:1582
> >        mac80211_hwsim_new_radio+0x2a9f/0x4a90 drivers/net/wireless/virt=
ual/mac80211_hwsim.c:5558
> >        init_mac80211_hwsim+0x87a/0xb00 drivers/net/wireless/virtual/mac=
80211_hwsim.c:6910
> >        do_one_initcall+0x248/0x870 init/main.c:1266
> >        do_initcall_level+0x157/0x210 init/main.c:1328
> >        do_initcalls+0x3f/0x80 init/main.c:1344
> >        kernel_init_freeable+0x435/0x5d0 init/main.c:1577
> >        kernel_init+0x1d/0x2b0 init/main.c:1466
> >        ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
> >        ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
> >
> > -> #0 (rtnl_mutex){+.+.}-{4:4}:
> >        check_prev_add kernel/locking/lockdep.c:3161 [inline]
> >        check_prevs_add kernel/locking/lockdep.c:3280 [inline]
> >        validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3904
> >        __lock_acquire+0x1397/0x2100 kernel/locking/lockdep.c:5226
> >        lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
> >        __mutex_lock_common kernel/locking/mutex.c:585 [inline]
> >        __mutex_lock+0x1ac/0xee0 kernel/locking/mutex.c:735
> >        rtnl_acquire_if_cleanup_net net/core/dev.c:10281 [inline]
> >        unregister_netdevice_many_notify+0xac2/0x2030 net/core/dev.c:117=
83
> >        unregister_netdevice_many net/core/dev.c:11866 [inline]
> >        unregister_netdevice_queue+0x303/0x370 net/core/dev.c:11732
> >        unregister_netdevice include/linux/netdevice.h:3320 [inline]
> >        _cfg80211_unregister_wdev+0x163/0x590 net/wireless/core.c:1251
> >        ieee80211_remove_interfaces+0x4ef/0x700 net/mac80211/iface.c:230=
1
> >        ieee80211_unregister_hw+0x5d/0x2c0 net/mac80211/main.c:1676
> >        mac80211_hwsim_del_radio+0x2c4/0x4c0 drivers/net/wireless/virtua=
l/mac80211_hwsim.c:5664
> >        hwsim_exit_net+0x5c1/0x670 drivers/net/wireless/virtual/mac80211=
_hwsim.c:6544
> >        ops_exit_list net/core/net_namespace.c:172 [inline]
> >        cleanup_net+0x812/0xd60 net/core/net_namespace.c:652
> >        process_one_work kernel/workqueue.c:3236 [inline]
> >        process_scheduled_works+0xa66/0x1840 kernel/workqueue.c:3317
> >        worker_thread+0x870/0xd30 kernel/workqueue.c:3398
> >        kthread+0x2f0/0x390 kernel/kthread.c:389
> >        ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
> >        ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
> >
> > other info that might help us debug this:
> >
> >  Possible unsafe locking scenario:
> >
> >        CPU0                    CPU1
> >        ----                    ----
> >   lock(&rdev->wiphy.mtx);
> >                                lock(rtnl_mutex);
> >                                lock(&rdev->wiphy.mtx);
> >   lock(rtnl_mutex);
> >
> >  *** DEADLOCK ***
> >
> > 4 locks held by kworker/u8:6/3534:
> >  #0: ffff88801baf5948 ((wq_completion)netns){+.+.}-{0:0}, at: process_o=
ne_work kernel/workqueue.c:3211 [inline]
> >  #0: ffff88801baf5948 ((wq_completion)netns){+.+.}-{0:0}, at: process_s=
cheduled_works+0x93b/0x1840 kernel/workqueue.c:3317
> >  #1: ffffc9000d507d00 (net_cleanup_work){+.+.}-{0:0}, at: process_one_w=
ork kernel/workqueue.c:3212 [inline]
> >  #1: ffffc9000d507d00 (net_cleanup_work){+.+.}-{0:0}, at: process_sched=
uled_works+0x976/0x1840 kernel/workqueue.c:3317
> >  #2: ffffffff8fca8290 (pernet_ops_rwsem){++++}-{4:4}, at: cleanup_net+0=
x17a/0xd60 net/core/net_namespace.c:606
> >  #3: ffff8880216b0768 (&rdev->wiphy.mtx){+.+.}-{4:4}, at: class_wiphy_c=
onstructor include/net/cfg80211.h:6034 [inline]
> >  #3: ffff8880216b0768 (&rdev->wiphy.mtx){+.+.}-{4:4}, at: ieee80211_rem=
ove_interfaces+0x129/0x700 net/mac80211/iface.c:2276
> >
> > stack backtrace:
> > CPU: 1 UID: 0 PID: 3534 Comm: kworker/u8:6 Not tainted 6.13.0-rc7-syzka=
ller-01131-g8d20dcda404d #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS=
 Google 12/27/2024
> > Workqueue: netns cleanup_net
> > Call Trace:
> >  <TASK>
> >  __dump_stack lib/dump_stack.c:94 [inline]
> >  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
> >  print_circular_bug+0x13a/0x1b0 kernel/locking/lockdep.c:2074
> >  check_noncircular+0x36a/0x4a0 kernel/locking/lockdep.c:2206
> >  check_prev_add kernel/locking/lockdep.c:3161 [inline]
> >  check_prevs_add kernel/locking/lockdep.c:3280 [inline]
> >  validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3904
> >  __lock_acquire+0x1397/0x2100 kernel/locking/lockdep.c:5226
> >  lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
> >  __mutex_lock_common kernel/locking/mutex.c:585 [inline]
> >  __mutex_lock+0x1ac/0xee0 kernel/locking/mutex.c:735
> >  rtnl_acquire_if_cleanup_net net/core/dev.c:10281 [inline]
> >  unregister_netdevice_many_notify+0xac2/0x2030 net/core/dev.c:11783
> >  unregister_netdevice_many net/core/dev.c:11866 [inline]
> >  unregister_netdevice_queue+0x303/0x370 net/core/dev.c:11732
> >  unregister_netdevice include/linux/netdevice.h:3320 [inline]
> >  _cfg80211_unregister_wdev+0x163/0x590 net/wireless/core.c:1251
> >  ieee80211_remove_interfaces+0x4ef/0x700 net/mac80211/iface.c:2301
> >  ieee80211_unregister_hw+0x5d/0x2c0 net/mac80211/main.c:1676
> >  mac80211_hwsim_del_radio+0x2c4/0x4c0 drivers/net/wireless/virtual/mac8=
0211_hwsim.c:5664
> >  hwsim_exit_net+0x5c1/0x670 drivers/net/wireless/virtual/mac80211_hwsim=
.c:6544
> >  ops_exit_list net/core/net_namespace.c:172 [inline]
> >  cleanup_net+0x812/0xd60 net/core/net_namespace.c:652
> >  process_one_work kernel/workqueue.c:3236 [inline]
> >  process_scheduled_works+0xa66/0x1840 kernel/workqueue.c:3317
> >  worker_thread+0x870/0xd30 kernel/workqueue.c:3398
> >  kthread+0x2f0/0x390 kernel/kthread.c:389
> >  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
> >  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
> >  </TASK>
> > hsr_slave_0: left promiscuous mode
> > hsr_slave_1: left promiscuous mode
> > batman_adv: batadv0: Interface deactivated: batadv_slave_0
> > batman_adv: batadv0: Removing interface: batadv_slave_0
> > batman_adv: batadv0: Interface deactivated: batadv_slave_1
> > batman_adv: batadv0: Removing interface: batadv_slave_1
> > veth1_macvtap: left promiscuous mode
> > veth0_macvtap: left promiscuous mode
> > veth1_vlan: left promiscuous mode
> > veth0_vlan: left promiscuous mode
> > team0 (unregistering): Port device team_slave_1 removed
> > team0 (unregistering): Port device team_slave_0 removed
> > bridge0: port 2(bridge_slave_1) entered blocking state
> > bridge0: port 2(bridge_slave_1) entered forwarding state
> > bridge0: port 1(bridge_slave_0) entered blocking state
> > bridge0: port 1(bridge_slave_0) entered forwarding state
> > bridge0: port 2(bridge_slave_1) entered blocking state
> > bridge0: port 2(bridge_slave_1) entered forwarding state
> >
> >
> > ---
> > If you want syzbot to run the reproducer, reply with:
> > #syz test: git://repo/address.git branch-or-commit-hash
> > If you attach or paste a git patch, syzbot will apply it before testing=
.
>
> This repro is for another bug I think, caused by my recent commits in net=
-next:
>
> 83419b61d187ce22aa3da5ffdda850fca3a12600 net: reduce RTNL hold
> duration in unregister_netdevice_many_notify() (part 2)
> ae646f1a0bb97401bac0044bbe2a179a1e38b408 net: reduce RTNL hold
> duration in unregister_netdevice_many_notify() (part 1)
> cfa579f6665635b72d4a075fc91eb144c2b0f74e net: no longer hold RTNL
> while calling flush_all_backlogs()
>
> cleanup_net()
>   rtnl_lock();
>     mutex_lock(subsystem_mutex);
>
>     unregister_netdevice();
>
>        rtnl_unlock();       // LOCKDEP violation
>        rtnl_lock();
>
> I will work today on a fix, auditing all unregister_netdevice() and
> unregister_netdevice_many()
> and select which of them can safely opt-in for a variant which _can_
> temporarily release RTNL.
>

Could you please share what's the current situation with the fix?
The bug unfortunately keeps on stalling the fuzzing on syzbot by
causing 70+% of all daily crashes.

--=20
Aleksandr


Return-Path: <netdev+bounces-194681-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E13ACBE55
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 03:49:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9E72189018A
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 01:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B416F78F24;
	Tue,  3 Jun 2025 01:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OLEAJw5k"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D264A8821;
	Tue,  3 Jun 2025 01:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748915393; cv=none; b=rQXaf7YTSJ16Pb6IsjmuTsn5FkJubDUVmU/itIlX2k322S5r9Ob2F6QOatUVC6EneWbgvxFxBCAk18GfOZV+8gS3zCw50JKhV04q+67+ywO/t3ZIpK+2jSSFuFGcmm2Rq1doKYz4gMMdXAHGjFqvO6T2+TpfxeDRASBoC88Sq64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748915393; c=relaxed/simple;
	bh=jQ36s+vQE0lP/BEl0HnBI4RkDooCBXP27+oT9IJQPws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ML4hBrvUiEFC2lROFzW9mnWvKXJXI/E9mqQti/6MIicpwaQGqIlSKQVo6xT1n9FZNsI437HurzHvooRH06F/G11Y4K1mS8YQf1RFb9Lg+Mw4GMIbzDEMmr1L/1sewk118/cPyFIg5m7ZWoLG/8UAPGZALKA8SVmeP8JpCJ6rypo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OLEAJw5k; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7424ccbef4eso4107637b3a.2;
        Mon, 02 Jun 2025 18:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748915391; x=1749520191; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YCW3HccKH11+3S3m+H7e6f2a4XuUHkpA3KFw9twtKNM=;
        b=OLEAJw5kamYOuq0Ythl9IoJiDaaMabowikIwlKlbuq5MJcvXfycAFajmZPPk+iZo1x
         7V+hKwi1+CGV1pgeUXik9ifNGk6M197Za+6XZN6uKd3Wt5qQh67qZ9K/rYRp2yKwgLvf
         lCoYMPS4CMS6DRs34Dch6Hqd46vToVQyre30sY7900T3CqM4g9vXm0j5hwnVOIgWk97b
         Wdcib24CKbDEs3zP38Ub7daej+hQYbA2ih5x48DS1qMYUJw16wE/2RHg5PlsiTe4NrU+
         0JG5Y9jrENwrnTbXJpfEDfKZTmAY7K/uEH3Am6ehbQfOKKUw1xy/xYYEal5A5xP7bRLp
         wdeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748915391; x=1749520191;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YCW3HccKH11+3S3m+H7e6f2a4XuUHkpA3KFw9twtKNM=;
        b=QpT0RkEiar/3bKIdrnlcwlZIZKec33Lz/r0ZhZQvfELkvhO+dUhmykqqktR8s7i3Rj
         8W9cxW7svlmikuWGyG0a+/i3mLxMdXla+gu6IzmN2K/+pTRmJFHIFB63H59zoL1f7Mrv
         VP4wsdGccCueDGEotpcECkT9zlki6KFZFf5Zpk7wFHHUwKcD+u2OMmcV1tZDVc9pPsrd
         ngXruNWHECZnT6gvM0BmJ3x3loOTD4nKgzy+YOZJQ1SI6xh/ZGqap//bSNPlg7PWBTd8
         GIpVezR6Kan0MxRMOZp14NO4m35t6u7ZopJEOWDdsV3W/I3eD8VASYyLvJ6VKoXanzw+
         LbwQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCp9olf5MI3A+8j10n+Jb36SQt6BECgY58PUYtPtk8mUr5hxP8ozdQna++AjiQejt8folaaiZp@vger.kernel.org, AJvYcCVoF7y7uE9WOBhErurUDmWHM2n+2NViGCoorgRNEySGV3rLM/04ljvYnNylmnuIVno4o8hE3oOXtnAGud4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ4rOYG5eK6KLIOpl5fmioDkEEFkRsm2MG83Cw4mnHvQaApBaV
	+yTuievKwy8nF0CbEdWm34JoV+uTfAvCG62m8IgEYYUA3znOPBIfu8g=
X-Gm-Gg: ASbGncsD8OwPfr3jVUUwy3wMe3O+aDk3Fg1YRg9D29Lr3KTuWkyvs1juoBvbiFuuyW2
	TbMKhWyUkop0x00t/SIpSVL8M7hgM22+9U2wvcdHJOpXrbL01vWfAKjDHUoB1+z5JN2CHCZcEkQ
	uY5DPJY8S0OPZEy3NB241+sGyOSOpbpD1Hda0BwSRxrW3NZpT9vB3JgXmS7LhIrYQPi6yMIB2tu
	eBYMoQnXUTq8dvsTm+6ZTzDxtIUjL/Dg+8t0mSQpLQ37eGswG6RZ3yfuEpz7VrHIzdiYYFox97W
	8bVlieLK4n5RwKVRJ3qAO2XfBK3WvMjtC6O5CQd+lsX9bZecLVb8g0DOUCMYq1SbRHVlK4ZYCHz
	htyez3Zs9PIRqo1T8PfrVxM0=
X-Google-Smtp-Source: AGHT+IHbxP60Kw9+h6RgHvB3I2EN074QNnSHE0LwJWnx570UUuSzlL5l9PUsorvSKPSuqHJIvOJK2w==
X-Received: by 2002:a05:6a20:430b:b0:1f5:8220:7452 with SMTP id adf61e73a8af0-21bad120c71mr16820662637.24.1748915390882;
        Mon, 02 Jun 2025 18:49:50 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-b2eceb29cafsm5340990a12.28.2025.06.02.18.49.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jun 2025 18:49:50 -0700 (PDT)
Date: Mon, 2 Jun 2025 18:49:49 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: syzbot <syzbot+58c65777e7d41ac833a9@syzkaller.appspotmail.com>
Cc: davem@davemloft.net, edumazet@google.com, horms@kernel.org,
	kuba@kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, pabeni@redhat.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] possible deadlock in dev_set_promiscuity
Message-ID: <aD5UvenmZ4MMXYzT@mini-arch>
References: <683d556f.a00a0220.d8eae.0046.GAE@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <683d556f.a00a0220.d8eae.0046.GAE@google.com>

On 06/02, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    90b83efa6701 Merge tag 'bpf-next-6.16' of git://git.kernel..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=135adbf4580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=262b2977ef00756b
> dashboard link: https://syzkaller.appspot.com/bug?extid=58c65777e7d41ac833a9
> compiler:       Debian clang version 20.1.6 (++20250514063057+1e4d39e07757-1~exp1~20250514183223.118), Debian LLD 20.1.6
> userspace arch: i386
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/2dccf70158c7/disk-90b83efa.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/e7a2b208c541/vmlinux-90b83efa.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/022501a5f90a/bzImage-90b83efa.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+58c65777e7d41ac833a9@syzkaller.appspotmail.com
> 
> batadv0: entered promiscuous mode
> team0: entered promiscuous mode
> team_slave_0: entered promiscuous mode
> macvlan2: entered promiscuous mode
> bond0: entered promiscuous mode
> ======================================================
> WARNING: possible circular locking dependency detected
> 6.15.0-syzkaller-07774-g90b83efa6701 #0 Not tainted
> ------------------------------------------------------
> syz.1.1497/11860 is trying to acquire lock:
> ffff8880314e4d30 (&dev_instance_lock_key#20){+.+.}-{4:4}, at: netdev_lock include/linux/netdevice.h:2756 [inline]
> ffff8880314e4d30 (&dev_instance_lock_key#20){+.+.}-{4:4}, at: netdev_lock_ops include/net/netdev_lock.h:42 [inline]
> ffff8880314e4d30 (&dev_instance_lock_key#20){+.+.}-{4:4}, at: dev_set_promiscuity+0x10e/0x260 net/core/dev_api.c:286
> 
> but task is already holding lock:
> ffff88805cd74e00 (team->team_lock_key#5){+.+.}-{4:4}, at: team_change_rx_flags+0x38/0x220 drivers/net/team/team_core.c:1781
> 
> which lock already depends on the new lock.
> 
> 
> the existing dependency chain (in reverse order) is:
> 
> -> #1 (team->team_lock_key#5){+.+.}-{4:4}:
>        lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5871
>        __mutex_lock_common kernel/locking/mutex.c:601 [inline]
>        __mutex_lock+0x182/0xe80 kernel/locking/mutex.c:746
>        team_port_change_check drivers/net/team/team_core.c:2966 [inline]
>        team_device_event+0x182/0xa20 drivers/net/team/team_core.c:2992
>        notifier_call_chain+0x1b3/0x3e0 kernel/notifier.c:85
>        call_netdevice_notifiers_extack net/core/dev.c:2268 [inline]
>        call_netdevice_notifiers net/core/dev.c:2282 [inline]
>        dev_close_many+0x29c/0x410 net/core/dev.c:1785
>        vlan_device_event+0x1748/0x1d00 net/8021q/vlan.c:449
>        notifier_call_chain+0x1b3/0x3e0 kernel/notifier.c:85
>        call_netdevice_notifiers_extack net/core/dev.c:2268 [inline]
>        call_netdevice_notifiers net/core/dev.c:2282 [inline]
>        __dev_notify_flags+0x18d/0x2e0 net/core/dev.c:-1
>        netif_change_flags+0xe8/0x1a0 net/core/dev.c:9526
>        do_setlink+0xc55/0x41c0 net/core/rtnetlink.c:3141
>        rtnl_changelink net/core/rtnetlink.c:3759 [inline]
>        __rtnl_newlink net/core/rtnetlink.c:3918 [inline]
>        rtnl_newlink+0x160b/0x1c70 net/core/rtnetlink.c:4055
>        rtnetlink_rcv_msg+0x7cf/0xb70 net/core/rtnetlink.c:6944
>        netlink_rcv_skb+0x205/0x470 net/netlink/af_netlink.c:2534
>        netlink_unicast_kernel net/netlink/af_netlink.c:1313 [inline]
>        netlink_unicast+0x758/0x8d0 net/netlink/af_netlink.c:1339
>        netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1883
>        sock_sendmsg_nosec net/socket.c:712 [inline]
>        __sock_sendmsg+0x219/0x270 net/socket.c:727
>        ____sys_sendmsg+0x505/0x830 net/socket.c:2566
>        ___sys_sendmsg+0x21f/0x2a0 net/socket.c:2620
>        __sys_sendmsg+0x164/0x220 net/socket.c:2652
>        do_syscall_32_irqs_on arch/x86/entry/syscall_32.c:83 [inline]
>        __do_fast_syscall_32+0xb6/0x2b0 arch/x86/entry/syscall_32.c:306
>        do_fast_syscall_32+0x34/0x80 arch/x86/entry/syscall_32.c:331
>        entry_SYSENTER_compat_after_hwframe+0x84/0x8e
> 
> -> #0 (&dev_instance_lock_key#20){+.+.}-{4:4}:
>        check_prev_add kernel/locking/lockdep.c:3168 [inline]
>        check_prevs_add kernel/locking/lockdep.c:3287 [inline]
>        validate_chain+0xb9b/0x2140 kernel/locking/lockdep.c:3911
>        __lock_acquire+0xab9/0xd20 kernel/locking/lockdep.c:5240
>        lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5871
>        __mutex_lock_common kernel/locking/mutex.c:601 [inline]
>        __mutex_lock+0x182/0xe80 kernel/locking/mutex.c:746
>        netdev_lock include/linux/netdevice.h:2756 [inline]
>        netdev_lock_ops include/net/netdev_lock.h:42 [inline]
>        dev_set_promiscuity+0x10e/0x260 net/core/dev_api.c:286
>        bond_set_promiscuity drivers/net/bonding/bond_main.c:919 [inline]
>        bond_change_rx_flags+0x219/0x690 drivers/net/bonding/bond_main.c:4738
>        dev_change_rx_flags net/core/dev.c:9241 [inline]
>        __dev_set_promiscuity+0x534/0x740 net/core/dev.c:9285
>        netif_set_promiscuity+0x50/0xe0 net/core/dev.c:9305
>        dev_set_promiscuity+0x126/0x260 net/core/dev_api.c:287
>        dev_change_rx_flags net/core/dev.c:9241 [inline]
>        __dev_set_promiscuity+0x534/0x740 net/core/dev.c:9285
>        netif_set_promiscuity+0x50/0xe0 net/core/dev.c:9305
>        dev_set_promiscuity+0x126/0x260 net/core/dev_api.c:287
>        team_change_rx_flags+0x123/0x220 drivers/net/team/team_core.c:1785
>        dev_change_rx_flags net/core/dev.c:9241 [inline]
>        __dev_set_promiscuity+0x534/0x740 net/core/dev.c:9285
>        netif_set_promiscuity+0x50/0xe0 net/core/dev.c:9305
>        dev_set_promiscuity+0x126/0x260 net/core/dev_api.c:287
>        hsr_portdev_setup net/hsr/hsr_slave.c:148 [inline]
>        hsr_add_port+0x549/0x890 net/hsr/hsr_slave.c:202
>        hsr_dev_finalize+0x6c4/0xaa0 net/hsr/hsr_device.c:760
>        hsr_newlink+0x7d7/0x940 net/hsr/hsr_netlink.c:122
>        rtnl_newlink_create+0x310/0xb00 net/core/rtnetlink.c:3823
>        __rtnl_newlink net/core/rtnetlink.c:3940 [inline]
>        rtnl_newlink+0x16d6/0x1c70 net/core/rtnetlink.c:4055
>        rtnetlink_rcv_msg+0x7cf/0xb70 net/core/rtnetlink.c:6944
>        netlink_rcv_skb+0x205/0x470 net/netlink/af_netlink.c:2534
>        netlink_unicast_kernel net/netlink/af_netlink.c:1313 [inline]
>        netlink_unicast+0x758/0x8d0 net/netlink/af_netlink.c:1339
>        netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1883
>        sock_sendmsg_nosec net/socket.c:712 [inline]
>        __sock_sendmsg+0x219/0x270 net/socket.c:727
>        ____sys_sendmsg+0x505/0x830 net/socket.c:2566
>        ___sys_sendmsg+0x21f/0x2a0 net/socket.c:2620
>        __sys_sendmsg+0x164/0x220 net/socket.c:2652
>        do_syscall_32_irqs_on arch/x86/entry/syscall_32.c:83 [inline]
>        __do_fast_syscall_32+0xb6/0x2b0 arch/x86/entry/syscall_32.c:306
>        do_fast_syscall_32+0x34/0x80 arch/x86/entry/syscall_32.c:331
>        entry_SYSENTER_compat_after_hwframe+0x84/0x8e
> 
> other info that might help us debug this:
> 
>  Possible unsafe locking scenario:
> 
>        CPU0                    CPU1
>        ----                    ----
>   lock(team->team_lock_key#5);
>                                lock(&dev_instance_lock_key#20);
>                                lock(team->team_lock_key#5);
>   lock(&dev_instance_lock_key#20);
> 
>  *** DEADLOCK ***
> 
> 3 locks held by syz.1.1497/11860:
>  #0: ffffffff8fa2cd70 (&ops->srcu#2){.+.+}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
>  #0: ffffffff8fa2cd70 (&ops->srcu#2){.+.+}-{0:0}, at: rcu_read_lock include/linux/rcupdate.h:841 [inline]
>  #0: ffffffff8fa2cd70 (&ops->srcu#2){.+.+}-{0:0}, at: rtnl_link_ops_get+0x23/0x250 net/core/rtnetlink.c:570
>  #1: ffffffff8f50a808 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_lock net/core/rtnetlink.c:80 [inline]
>  #1: ffffffff8f50a808 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_nets_lock net/core/rtnetlink.c:341 [inline]
>  #1: ffffffff8f50a808 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_newlink+0x8db/0x1c70 net/core/rtnetlink.c:4054
>  #2: ffff88805cd74e00 (team->team_lock_key#5){+.+.}-{4:4}, at: team_change_rx_flags+0x38/0x220 drivers/net/team/team_core.c:1781
> 
> stack backtrace:
> CPU: 1 UID: 0 PID: 11860 Comm: syz.1.1497 Not tainted 6.15.0-syzkaller-07774-g90b83efa6701 #0 PREEMPT(full) 
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
>  print_circular_bug+0x2ee/0x310 kernel/locking/lockdep.c:2046
>  check_noncircular+0x134/0x160 kernel/locking/lockdep.c:2178
>  check_prev_add kernel/locking/lockdep.c:3168 [inline]
>  check_prevs_add kernel/locking/lockdep.c:3287 [inline]
>  validate_chain+0xb9b/0x2140 kernel/locking/lockdep.c:3911
>  __lock_acquire+0xab9/0xd20 kernel/locking/lockdep.c:5240
>  lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5871
>  __mutex_lock_common kernel/locking/mutex.c:601 [inline]
>  __mutex_lock+0x182/0xe80 kernel/locking/mutex.c:746
>  netdev_lock include/linux/netdevice.h:2756 [inline]
>  netdev_lock_ops include/net/netdev_lock.h:42 [inline]
>  dev_set_promiscuity+0x10e/0x260 net/core/dev_api.c:286
>  bond_set_promiscuity drivers/net/bonding/bond_main.c:919 [inline]
>  bond_change_rx_flags+0x219/0x690 drivers/net/bonding/bond_main.c:4738
>  dev_change_rx_flags net/core/dev.c:9241 [inline]
>  __dev_set_promiscuity+0x534/0x740 net/core/dev.c:9285
>  netif_set_promiscuity+0x50/0xe0 net/core/dev.c:9305
>  dev_set_promiscuity+0x126/0x260 net/core/dev_api.c:287
>  dev_change_rx_flags net/core/dev.c:9241 [inline]
>  __dev_set_promiscuity+0x534/0x740 net/core/dev.c:9285
>  netif_set_promiscuity+0x50/0xe0 net/core/dev.c:9305
>  dev_set_promiscuity+0x126/0x260 net/core/dev_api.c:287
>  team_change_rx_flags+0x123/0x220 drivers/net/team/team_core.c:1785
>  dev_change_rx_flags net/core/dev.c:9241 [inline]
>  __dev_set_promiscuity+0x534/0x740 net/core/dev.c:9285
>  netif_set_promiscuity+0x50/0xe0 net/core/dev.c:9305
>  dev_set_promiscuity+0x126/0x260 net/core/dev_api.c:287
>  hsr_portdev_setup net/hsr/hsr_slave.c:148 [inline]
>  hsr_add_port+0x549/0x890 net/hsr/hsr_slave.c:202
>  hsr_dev_finalize+0x6c4/0xaa0 net/hsr/hsr_device.c:760
>  hsr_newlink+0x7d7/0x940 net/hsr/hsr_netlink.c:122
>  rtnl_newlink_create+0x310/0xb00 net/core/rtnetlink.c:3823
>  __rtnl_newlink net/core/rtnetlink.c:3940 [inline]
>  rtnl_newlink+0x16d6/0x1c70 net/core/rtnetlink.c:4055
>  rtnetlink_rcv_msg+0x7cf/0xb70 net/core/rtnetlink.c:6944
>  netlink_rcv_skb+0x205/0x470 net/netlink/af_netlink.c:2534
>  netlink_unicast_kernel net/netlink/af_netlink.c:1313 [inline]
>  netlink_unicast+0x758/0x8d0 net/netlink/af_netlink.c:1339
>  netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1883
>  sock_sendmsg_nosec net/socket.c:712 [inline]
>  __sock_sendmsg+0x219/0x270 net/socket.c:727
>  ____sys_sendmsg+0x505/0x830 net/socket.c:2566
>  ___sys_sendmsg+0x21f/0x2a0 net/socket.c:2620
>  __sys_sendmsg+0x164/0x220 net/socket.c:2652
>  do_syscall_32_irqs_on arch/x86/entry/syscall_32.c:83 [inline]
>  __do_fast_syscall_32+0xb6/0x2b0 arch/x86/entry/syscall_32.c:306
>  do_fast_syscall_32+0x34/0x80 arch/x86/entry/syscall_32.c:331
>  entry_SYSENTER_compat_after_hwframe+0x84/0x8e
> RIP: 0023:0xf705e539

I wonder whether mutex_lock(lock: &team->lock) is really needed in
team_change_rx_flags. I did add it while converting from rcu. Adding
to that list happens in do_setlink (rtnl) and the same for the
callers of dev_change_rx_flags. (and bonding driver doesn't do any
locking either). Or hope that https://lore.kernel.org/netdev/d4047311-5644-4884-84c0-059bbb9e98ee@I-love.SAKURA.ne.jp/
happens soon?


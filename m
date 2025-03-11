Return-Path: <netdev+bounces-174025-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99435A5D0AD
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 21:21:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAF7A17AD38
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 20:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11A13264633;
	Tue, 11 Mar 2025 20:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P76rhy1+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460FD2620F9;
	Tue, 11 Mar 2025 20:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741724485; cv=none; b=Is/l5/hvyWPT2zxAxUO+SZbqXqK3A3xUV0amAX2WFEjfWNXh/5rFXQCZGcyShnk8xPhTMAg4lhLDoXnvPRhT6aJQVx9fDz7wLfrcOspTCINjRsFzPsC05k0hHjlOPMyOCAxaAzgCO8R/GN3JmPe0igWKIIb1iBIaXKCoZ0gT/b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741724485; c=relaxed/simple;
	bh=6g1VZ4JJ54Jbzddxj+x1pObccBYckO5tyWsgllTLh2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AAwO864ep7P4NDBb4ZPzmHLOjIGm0+Ky4MejEbroT7/qtN/pB9AuaucIko2PYbs5F+kCdX1+h4Lv1S1OsItwAXJH0iN8tl4yYRAHntIm7Yy2xzf135EWZ/QL3rGlfmx2Hi6LrZk01IEr6ShEJ0wWV/ksjVPUiiqH9M+nMdbbxI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P76rhy1+; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-225477548e1so65048275ad.0;
        Tue, 11 Mar 2025 13:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741724482; x=1742329282; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zrLIR0sPxlin15R9Y2KMmVEFo9WqVxmuHLYt59spjsI=;
        b=P76rhy1+g1/DHbeYlZ8ybfrKzmBgvMQQmcOC14Ji+iKZGnhwuar2bCFeqjvIca2iU2
         dgRHxd7lnXo40woP98SGr14RJekM5vt3sUjGukSeIU5rpiVzCDEplVQQHnBUIWT5OWwt
         RP/FDfwymeSoSjsT/pTK3Uj0QOknfOOU3/oP5xKVYRUmaLLmX/RrTfTdbs8oWaPQZ682
         8xfpsZcT3LUoPiQHF0rp0872aHMB6KfMCPI3DXabw71GFvzDJvZOE5qtSGOwoGQ5w3QI
         2xC0kiHM/69vp3HdY/LFDHMITgSLsKY7FydWFIlRWHwU+OMLMZRdrcvKDrW2MfUVUdvu
         ZeLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741724482; x=1742329282;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zrLIR0sPxlin15R9Y2KMmVEFo9WqVxmuHLYt59spjsI=;
        b=L3eBAbDoaKPDXn5mSL4L1RO20jJTnf90+aD5JhwuYzLMjBsyC58gt3+wC4eemNMbZV
         GRm4k9s9+EPRAgmhohEwbHbaWI9JrK2gomxMoJ5TU6KeNoomOTechJIUXlFBX8knpoCb
         sy3UTqXy85PKHmwLxzZFuA53x4hGrV3A0b+wt3ohnHAyT05tuJtDQMGKYQsM6Lks4o0e
         Y8HOC8mjr7B/A9zlktdcwqNOmTfnKx7nEYkiJFoHMMGhD2/cZAQsRwELKjOibq9qybaG
         8YJlxi45jeybIEuETcnHOxj1vorKBfDJJQ/Penk9IejW/SCfs3igJugaTzHWoM8cHrSj
         gNYA==
X-Forwarded-Encrypted: i=1; AJvYcCUTCr9xf23hLtKZJnWouVFg8QcL9kJSvdpDWQx0QXDDak0k3Ivz+zB2G2y/SJVX2Ax5YmEM6QypR7MbxjY=@vger.kernel.org, AJvYcCVa0A7mqN9dKB4x2rmsB/1gZ6yvhlv4qlvPtF82INBISrlDnQPJhcVdK0J9XCefZXhHnWf4hJfZ@vger.kernel.org
X-Gm-Message-State: AOJu0YwVGzRfqssXWC2chVcQclE66oiK3U4YjskKEPqAkNF5yrhCgk9+
	scQO8/TVnXsdlt2aHm8TyH9e85ZMqEd3agBS7dfq0LNdwJPLyZ8=
X-Gm-Gg: ASbGncvYj6/+MZREADbUReHFTCwMrG+jzKGl0Qvo7wQddygUkvvs0bkEHOQ7cUcFGHP
	FSLjuR1cLeAxb92ulVPck0I3nG3I4zLbZNDASvcn8h+qjVaASUJJvBHaMumZJVLBxxxlyVE5mzL
	HOzM6oSQUEQpqGtIEOsrRJbqe3aARurnvuoFAwtskUb0fgrg0zMO6Ob52p/z4z2TBQiU2s8qYD4
	5M8vERUoHVpcKvbgIrLwDxRAPJKdW0OUpWQlK765QyG2KRtwcSEFi14YfpS2o18fFXg9UyPEiKq
	fkv+yxIv95PsyP7NKNc+2LmWXPwr7Dg+mxVIefkwIxIs
X-Google-Smtp-Source: AGHT+IGWdYuJquS3tiJAmGKYAM/JbITm96LbUw+elS4m8ucyANswpHpxNeiLHGOMPiDpeM/wfjul9Q==
X-Received: by 2002:a17:902:d509:b0:224:191d:8a87 with SMTP id d9443c01a7336-22428aa2f48mr293332115ad.26.1741724482322;
        Tue, 11 Mar 2025 13:21:22 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:2844:3d8f:bf3e:12cc])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-224109dfad4sm102657485ad.23.2025.03.11.13.21.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 13:21:21 -0700 (PDT)
Date: Tue, 11 Mar 2025 13:21:21 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: syzbot <syzbot+2d6285cc150f4ee51ef9@syzkaller.appspotmail.com>
Cc: davem@davemloft.net, edumazet@google.com, horms@kernel.org,
	kuba@kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, pabeni@redhat.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] possible deadlock in dev_set_mac_address
Message-ID: <Z9CbQaapTggFitFY@mini-arch>
References: <67d0961e.050a0220.14e108.001a.GAE@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <67d0961e.050a0220.14e108.001a.GAE@google.com>

On 03/11, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    40587f749df2 Merge branch 'enic-enable-32-64-byte-cqes-and..
> git tree:       net-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=1420d478580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=ca99d9d1f4a8ecfa
> dashboard link: https://syzkaller.appspot.com/bug?extid=2d6285cc150f4ee51ef9
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
> Reported-by: syzbot+2d6285cc150f4ee51ef9@syzkaller.appspotmail.com
> 
> ======================================================
> WARNING: possible circular locking dependency detected
> 6.14.0-rc5-syzkaller-01183-g40587f749df2 #0 Not tainted
> ------------------------------------------------------
> syz.3.4651/21867 is trying to acquire lock:
> ffff88805e634d28 (&dev_instance_lock_key#12){+.+.}-{4:4}, at: netdev_lock include/linux/netdevice.h:2731 [inline]
> ffff88805e634d28 (&dev_instance_lock_key#12){+.+.}-{4:4}, at: dev_set_mac_address+0x2a/0x50 net/core/dev_api.c:302
> 
> but task is already holding lock:
> ffff88807de0cd28 (&dev_instance_lock_key#2){+.+.}-{4:4}, at: netdev_lock include/linux/netdevice.h:2731 [inline]
> ffff88807de0cd28 (&dev_instance_lock_key#2){+.+.}-{4:4}, at: do_setlink+0xa94/0x40f0 net/core/rtnetlink.c:3094
> 
> which lock already depends on the new lock.
> 
> 
> the existing dependency chain (in reverse order) is:
> 
> -> #2 (&dev_instance_lock_key#2){+.+.}-{4:4}:
>        lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5851
>        __mutex_lock_common kernel/locking/mutex.c:585 [inline]
>        __mutex_lock+0x19c/0x1010 kernel/locking/mutex.c:730
>        netdev_lock include/linux/netdevice.h:2731 [inline]
>        netif_set_up net/core/dev.h:143 [inline]
>        __dev_open+0x5cb/0x8a0 net/core/dev.c:1651
>        netif_open+0xae/0x1b0 net/core/dev.c:1667
>        dev_open+0x13e/0x260 net/core/dev_api.c:191
>        team_port_add drivers/net/team/team_core.c:1230 [inline]
>        team_add_slave+0xabe/0x28a0 drivers/net/team/team_core.c:1989
>        do_set_master+0x579/0x730 net/core/rtnetlink.c:2943
>        do_setlink+0xfee/0x40f0 net/core/rtnetlink.c:3149
>        rtnl_changelink net/core/rtnetlink.c:3759 [inline]
>        __rtnl_newlink net/core/rtnetlink.c:3918 [inline]
>        rtnl_newlink+0x15a6/0x1d90 net/core/rtnetlink.c:4055
>        rtnetlink_rcv_msg+0x791/0xcf0 net/core/rtnetlink.c:6945
>        netlink_rcv_skb+0x206/0x480 net/netlink/af_netlink.c:2534
>        netlink_unicast_kernel net/netlink/af_netlink.c:1313 [inline]
>        netlink_unicast+0x7f6/0x990 net/netlink/af_netlink.c:1339
>        netlink_sendmsg+0x8de/0xcb0 net/netlink/af_netlink.c:1883
>        sock_sendmsg_nosec net/socket.c:709 [inline]
>        __sock_sendmsg+0x221/0x270 net/socket.c:724
>        ____sys_sendmsg+0x53a/0x860 net/socket.c:2564
>        ___sys_sendmsg net/socket.c:2618 [inline]
>        __sys_sendmsg+0x269/0x350 net/socket.c:2650
>        do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>        do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>        entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> -> #1 (team->team_lock_key#2){+.+.}-{4:4}:
>        lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5851
>        __mutex_lock_common kernel/locking/mutex.c:585 [inline]
>        __mutex_lock+0x19c/0x1010 kernel/locking/mutex.c:730
>        team_set_mac_address+0x122/0x280 drivers/net/team/team_core.c:1817
>        netif_set_mac_address+0x327/0x510 net/core/dev.c:9605
>        do_setlink+0xaa6/0x40f0 net/core/rtnetlink.c:3095
>        rtnl_changelink net/core/rtnetlink.c:3759 [inline]
>        __rtnl_newlink net/core/rtnetlink.c:3918 [inline]
>        rtnl_newlink+0x15a6/0x1d90 net/core/rtnetlink.c:4055
>        rtnetlink_rcv_msg+0x791/0xcf0 net/core/rtnetlink.c:6945
>        netlink_rcv_skb+0x206/0x480 net/netlink/af_netlink.c:2534
>        netlink_unicast_kernel net/netlink/af_netlink.c:1313 [inline]
>        netlink_unicast+0x7f6/0x990 net/netlink/af_netlink.c:1339
>        netlink_sendmsg+0x8de/0xcb0 net/netlink/af_netlink.c:1883
>        sock_sendmsg_nosec net/socket.c:709 [inline]
>        __sock_sendmsg+0x221/0x270 net/socket.c:724
>        __sys_sendto+0x363/0x4c0 net/socket.c:2178
>        __do_sys_sendto net/socket.c:2185 [inline]
>        __se_sys_sendto net/socket.c:2181 [inline]
>        __x64_sys_sendto+0xde/0x100 net/socket.c:2181
>        do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>        do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>        entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> -> #0 (&dev_instance_lock_key#12){+.+.}-{4:4}:
>        check_prev_add kernel/locking/lockdep.c:3163 [inline]
>        check_prevs_add kernel/locking/lockdep.c:3282 [inline]
>        validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3906
>        __lock_acquire+0x1397/0x2100 kernel/locking/lockdep.c:5228
>        lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5851
>        __mutex_lock_common kernel/locking/mutex.c:585 [inline]
>        __mutex_lock+0x19c/0x1010 kernel/locking/mutex.c:730
>        netdev_lock include/linux/netdevice.h:2731 [inline]
>        dev_set_mac_address+0x2a/0x50 net/core/dev_api.c:302
>        bond_set_mac_address+0x28e/0x830 drivers/net/bonding/bond_main.c:4903
>        netif_set_mac_address+0x327/0x510 net/core/dev.c:9605
>        do_setlink+0xaa6/0x40f0 net/core/rtnetlink.c:3095
>        rtnl_changelink net/core/rtnetlink.c:3759 [inline]
>        __rtnl_newlink net/core/rtnetlink.c:3918 [inline]
>        rtnl_newlink+0x15a6/0x1d90 net/core/rtnetlink.c:4055
>        rtnetlink_rcv_msg+0x791/0xcf0 net/core/rtnetlink.c:6945
>        netlink_rcv_skb+0x206/0x480 net/netlink/af_netlink.c:2534
>        netlink_unicast_kernel net/netlink/af_netlink.c:1313 [inline]
>        netlink_unicast+0x7f6/0x990 net/netlink/af_netlink.c:1339
>        netlink_sendmsg+0x8de/0xcb0 net/netlink/af_netlink.c:1883
>        sock_sendmsg_nosec net/socket.c:709 [inline]
>        __sock_sendmsg+0x221/0x270 net/socket.c:724
>        ____sys_sendmsg+0x53a/0x860 net/socket.c:2564
>        ___sys_sendmsg net/socket.c:2618 [inline]
>        __sys_sendmsg+0x269/0x350 net/socket.c:2650
>        do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>        do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>        entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> other info that might help us debug this:
> 
> Chain exists of:
>   &dev_instance_lock_key#12 --> team->team_lock_key#2 --> &dev_instance_lock_key#2
> 
>  Possible unsafe locking scenario:
> 
>        CPU0                    CPU1
>        ----                    ----
>   lock(&dev_instance_lock_key#2);
>                                lock(team->team_lock_key#2);
>                                lock(&dev_instance_lock_key#2);
>   lock(&dev_instance_lock_key#12);
> 
>  *** DEADLOCK ***
> 
> 2 locks held by syz.3.4651/21867:
>  #0: ffffffff8fed6908 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_lock net/core/rtnetlink.c:80 [inline]
>  #0: ffffffff8fed6908 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_nets_lock net/core/rtnetlink.c:341 [inline]
>  #0: ffffffff8fed6908 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_newlink+0xc4c/0x1d90 net/core/rtnetlink.c:4054
>  #1: ffff88807de0cd28 (&dev_instance_lock_key#2){+.+.}-{4:4}, at: netdev_lock include/linux/netdevice.h:2731 [inline]
>  #1: ffff88807de0cd28 (&dev_instance_lock_key#2){+.+.}-{4:4}, at: do_setlink+0xa94/0x40f0 net/core/rtnetlink.c:3094
> 
> stack backtrace:
> CPU: 0 UID: 0 PID: 21867 Comm: syz.3.4651 Not tainted 6.14.0-rc5-syzkaller-01183-g40587f749df2 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:94 [inline]
>  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
>  print_circular_bug+0x13a/0x1b0 kernel/locking/lockdep.c:2076
>  check_noncircular+0x36a/0x4a0 kernel/locking/lockdep.c:2208
>  check_prev_add kernel/locking/lockdep.c:3163 [inline]
>  check_prevs_add kernel/locking/lockdep.c:3282 [inline]
>  validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3906
>  __lock_acquire+0x1397/0x2100 kernel/locking/lockdep.c:5228
>  lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5851
>  __mutex_lock_common kernel/locking/mutex.c:585 [inline]
>  __mutex_lock+0x19c/0x1010 kernel/locking/mutex.c:730
>  netdev_lock include/linux/netdevice.h:2731 [inline]
>  dev_set_mac_address+0x2a/0x50 net/core/dev_api.c:302
>  bond_set_mac_address+0x28e/0x830 drivers/net/bonding/bond_main.c:4903
>  netif_set_mac_address+0x327/0x510 net/core/dev.c:9605
>  do_setlink+0xaa6/0x40f0 net/core/rtnetlink.c:3095
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
> RIP: 0033:0x7fb6b198d169
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007fb6af7d5038 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
> RAX: ffffffffffffffda RBX: 00007fb6b1ba6080 RCX: 00007fb6b198d169
> RDX: 0000000000040880 RSI: 0000400000000000 RDI: 0000000000000009
> RBP: 00007fb6b1a0e2a0 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 0000000000000000 R14: 00007fb6b1ba6080 R15: 00007fff137bf0e8
>  </TASK>
> bond0: entered promiscuous mode
> team0: entered promiscuous mode
> bond0: left allmulticast mode
> team0: left allmulticast mode
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> 
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
> 
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
> 
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
> 
> If you want to undo deduplication, reply with:
> #syz undup

I think it should be addressed by https://lore.kernel.org/netdev/20250311084507.3978048-1-sdf@fomichev.me/

It is the same team_lock->netdev_ops vs netdev_ops->team_lock ordering issue:

rtnl_newlink
  rtnl_changelink
    do_setlink IFLA_MASTER lower
      do_set_master
        team_add_slave
	  team_lock
	    team_port_add
	      dev_open
	        dev_instance_lock#2 - for netdev_ops (not taken)
	          netif_open
	            __dev_open
		      netif_set_up
		        dev_instance_lock#2 - for non-netdev_ops (taken)

rtnl_newlink
  __rtnl_newlink
    rtnl_changelink
      do_setlink IFLA_ADDRESS upper
        dev_instace_lock - for non-netdev_ops (taken) <<< GONNA BE REPLACED BY DEV_ADDR_SEM
          netif_set_mac_address
	    team_set_mac_address
	      team_lock

Will keep an eye on the dashboard..


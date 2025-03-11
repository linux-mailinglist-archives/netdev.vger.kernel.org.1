Return-Path: <netdev+bounces-174026-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB4AEA5D0C8
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 21:26:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D0C617B4A8
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 20:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DE89260A32;
	Tue, 11 Mar 2025 20:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K2WchaAg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E1225BAB1;
	Tue, 11 Mar 2025 20:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741724798; cv=none; b=D29oXnj5e5sbvL6x3WgxloDNXJ0nAHa5cvfx8K8Ji9PYMzGTBtc1kFMc4e4mKmm2r/B3GLhy+MD2eqZong2uNUylh7jfRjtfB/kPZa6RnGixfRtwbwfJqSHq7GcMGFWnK+BYpozszl0wt0lHkcPgpXkR7A6IJi3ifBaXoM0Xj7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741724798; c=relaxed/simple;
	bh=6dBxEh+ploKWjPfograkgO6Hgk6wIl8H8cDVBkVGEzM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l6q89auuDUEKEoxoYi3W/jqt/SHlO9VSuN6hL4fFlu9crA9cDwAMlsBiS5R6qQCcoDET+rFeAaTEPiT0gVc7ZrzXSiHtrgGaIMxilJr5DxfrUSfYGF9OynvmaZqZj+4U7ysP4uUjzBdm8i4hckGWKkJutpkPaQp990cymCJbGx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K2WchaAg; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2232aead377so19839505ad.0;
        Tue, 11 Mar 2025 13:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741724796; x=1742329596; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HOLMW1XS/QheEP8NbYzxvgo+6eX6jNftDPbpbCrgT5w=;
        b=K2WchaAgWCib+Zh9IG83wSa7DnIk/I8vhmzdagn64cZiwJ/Vo8V6zkkoAerj7Icd2Q
         DSe0GUIZVP3cndaP3INn3BgsxYRr0o3+imgNaKWpfsogQiEhjP/HoI0af7GTOTL9Iku4
         6ZQpkHOeLpb6P2aB07wpB32H0YD1DRBrf00APZoDdJOhfxtTNo0tcWtgE7fmSSMGWEZ7
         cUcIu7mkqKfmEQglPYhFQeT4Ua2S0/X78bhCEL263ZGsfL6WHqHh/4vbJ5H62+c7YX+f
         hkPA859EnsMpOCF7pqr9g3ioFE91tVgO5/M0byxzVGzcErAK36CftH3ViXpgk8/OfkiX
         iFOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741724796; x=1742329596;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HOLMW1XS/QheEP8NbYzxvgo+6eX6jNftDPbpbCrgT5w=;
        b=B8KYR0kE29IyteTCRMyw6csFAor5+VqqOF5Na8CAaWZM/rQVvQh4HF0CgnBx2pK/K4
         hKopGNKa1RPcr2jiO5YE13QV8TsBRqcun2KmM7HsfjBKxdYL0iH7cYIjQ7XkThrDzPRr
         UDzc03IOIabZx4iicwKg7z9cjiWZwrgrd/wv4rsTRUA4w6vQFdZb6nhKeNW0zdyofISu
         qGhVrQYXQ9QGZy8uF4TjT0F/XM0ZzcwtnPBErc6IcMYYPKjq4L53AKl9mlsBbcPoqXQ6
         /TFuUqtDq5AQEWfse0ycp7HhQ8yQ7KKGfTSDUMtK+8BZMHPw+u1PGnRRAi/nm7l9BQJR
         Ohtw==
X-Forwarded-Encrypted: i=1; AJvYcCVQCih33mat5a9RUUBJ6I6vzLXhRkon4pYXlEtuugVMhLMODvT4j0/Kvm97+Z4n+A60q96JE+xmLKlEc/4=@vger.kernel.org, AJvYcCWXXJ6vzjpOtWqb8oC99bDpGDrPOJhtuH7cAmChJz5EXnLTK6IIj6icSn/ZnoL/BUEipWOsBnsx@vger.kernel.org
X-Gm-Message-State: AOJu0Yzi7xK5vRq/eokhhp4tmklPgc+4WwNoXeBHaMNGHkUNE2LOHpjm
	lF0JbU7Sq76lMlCh2TxmpLCddwBbu9OsdF0K+++SXDoKtjadgHs=
X-Gm-Gg: ASbGncuLiC4gGzCW7nkBS24gF7vEzk9LtVT/7UA+yyqCw6Ef99XbtkCh8uEKuZLHdMa
	BKWIGX6H6lFszON5tjKpuGyITL84OK1oQsnXIq9dVVe1Kzw31AqThBvm8zF7iZMlA3okqU3fAKb
	7/ACzX7rcoG7uWPDXzp6Tg/ymd0Rf3m1sYzq26thVYBYAvqx1zUGm/NDDATawJ4+e5OZknZH4cD
	kPTxJAsr0ILBl8jkFJs7ijaDhSnLPm+8wBU66dpqyEy3NJHS9F5UAhfXrK6QaBvB0Q/ZlrFPEls
	TAT1nHfBMkZpIsG7Q6Jqdr9qjyilWhTHXHdm7HWdICl6
X-Google-Smtp-Source: AGHT+IF1ph6wCu5/97I7Uf7vxBEsLSSIIvr1ntRAapQoqTQZExikc74AhRNuhXTPi6A2DoPLN4ZQhw==
X-Received: by 2002:a17:903:8c4:b0:223:52fc:a15a with SMTP id d9443c01a7336-22428bdec6cmr276398235ad.33.1741724795820;
        Tue, 11 Mar 2025 13:26:35 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:2844:3d8f:bf3e:12cc])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-224109e979dsm102813015ad.89.2025.03.11.13.26.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 13:26:35 -0700 (PDT)
Date: Tue, 11 Mar 2025 13:26:34 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: syzbot <syzbot+2393ddd2462f9a5f6d79@syzkaller.appspotmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	jiri@resnulli.us, kuba@kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, pabeni@redhat.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] possible deadlock in __dev_open
Message-ID: <Z9Ccej05uKPR6Cex@mini-arch>
References: <67d098bb.050a0220.14e108.001b.GAE@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <67d098bb.050a0220.14e108.001b.GAE@google.com>

On 03/11, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    40587f749df2 Merge branch 'enic-enable-32-64-byte-cqes-and..
> git tree:       net-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=17d22654580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=ca99d9d1f4a8ecfa
> dashboard link: https://syzkaller.appspot.com/bug?extid=2393ddd2462f9a5f6d79
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
> Reported-by: syzbot+2393ddd2462f9a5f6d79@syzkaller.appspotmail.com
> 
> ======================================================
> WARNING: possible circular locking dependency detected
> 6.14.0-rc5-syzkaller-01183-g40587f749df2 #0 Not tainted
> ------------------------------------------------------
> syz.3.4227/19723 is trying to acquire lock:
> ffff888029bf8d28 (&dev_instance_lock_key#2){+.+.}-{4:4}, at: netdev_lock include/linux/netdevice.h:2731 [inline]
> ffff888029bf8d28 (&dev_instance_lock_key#2){+.+.}-{4:4}, at: netif_set_up net/core/dev.h:143 [inline]
> ffff888029bf8d28 (&dev_instance_lock_key#2){+.+.}-{4:4}, at: __dev_open+0x5cb/0x8a0 net/core/dev.c:1651
> 
> but task is already holding lock:
> ffff8880309c8e00 (team->team_lock_key#6){+.+.}-{4:4}, at: team_add_slave+0xb3/0x28a0 drivers/net/team/team_core.c:1988
> 
> which lock already depends on the new lock.
> 
> 
> the existing dependency chain (in reverse order) is:
> 
> -> #2 (team->team_lock_key#6){+.+.}-{4:4}:
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
> -> #1 (&dev_instance_lock_key#12){+.+.}-{4:4}:
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
> -> #0 (&dev_instance_lock_key#2){+.+.}-{4:4}:
>        check_prev_add kernel/locking/lockdep.c:3163 [inline]
>        check_prevs_add kernel/locking/lockdep.c:3282 [inline]
>        validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3906
>        __lock_acquire+0x1397/0x2100 kernel/locking/lockdep.c:5228
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
> other info that might help us debug this:
> 
> Chain exists of:
>   &dev_instance_lock_key#2 --> &dev_instance_lock_key#12 --> team->team_lock_key#6
> 
>  Possible unsafe locking scenario:
> 
>        CPU0                    CPU1
>        ----                    ----
>   lock(team->team_lock_key#6);
>                                lock(&dev_instance_lock_key#12);
>                                lock(team->team_lock_key#6);
>   lock(&dev_instance_lock_key#2);
> 
>  *** DEADLOCK ***
> 
> 2 locks held by syz.3.4227/19723:
>  #0: ffffffff8fed6908 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_lock net/core/rtnetlink.c:80 [inline]
>  #0: ffffffff8fed6908 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_nets_lock net/core/rtnetlink.c:341 [inline]
>  #0: ffffffff8fed6908 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_newlink+0xc4c/0x1d90 net/core/rtnetlink.c:4054
>  #1: ffff8880309c8e00 (team->team_lock_key#6){+.+.}-{4:4}, at: team_add_slave+0xb3/0x28a0 drivers/net/team/team_core.c:1988
> 
> stack backtrace:
> CPU: 0 UID: 0 PID: 19723 Comm: syz.3.4227 Not tainted 6.14.0-rc5-syzkaller-01183-g40587f749df2 #0
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
>  netif_set_up net/core/dev.h:143 [inline]
>  __dev_open+0x5cb/0x8a0 net/core/dev.c:1651
>  netif_open+0xae/0x1b0 net/core/dev.c:1667
>  dev_open+0x13e/0x260 net/core/dev_api.c:191
>  team_port_add drivers/net/team/team_core.c:1230 [inline]
>  team_add_slave+0xabe/0x28a0 drivers/net/team/team_core.c:1989
>  do_set_master+0x579/0x730 net/core/rtnetlink.c:2943
>  do_setlink+0xfee/0x40f0 net/core/rtnetlink.c:3149
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
> RIP: 0033:0x7f79fa58d169
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f79fb3eb038 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
> RAX: ffffffffffffffda RBX: 00007f79fa7a5fa0 RCX: 00007f79fa58d169
> RDX: 0000000000000000 RSI: 0000400000000280 RDI: 0000000000000004
> RBP: 00007f79fa60e2a0 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 0000000000000000 R14: 00007f79fa7a5fa0 R15: 00007fff8756ece8
>  </TASK>
> 8021q: adding VLAN 0 to HW filter on device bond0
> bond0: entered allmulticast mode
> syz_tun: entered allmulticast mode
> team0: Port device bond0 added
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

This one is also similar to:
https://lore.kernel.org/netdev/Z9CbQaapTggFitFY@mini-arch/T/#md18c10a5f150805688531d3dc21cafe19531c06e


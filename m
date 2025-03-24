Return-Path: <netdev+bounces-177138-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0FA3A6E05C
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 17:58:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 067C01889A87
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 16:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B421263F44;
	Mon, 24 Mar 2025 16:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cNIjS1gZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B37E82620C4
	for <netdev@vger.kernel.org>; Mon, 24 Mar 2025 16:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742835481; cv=none; b=ZawAlmuJ92rpX5qQMH9uj7ETHuysxJRDSu7WTl+9HpktYRKVl41xwuAJly1B2hxmqzQqxZbotIiXuhXAdvspl5rhODj3v5q9SmaHT+lVcU0w0Js8u0tDZtca0NOZsLtNUo3PuZdKdNUvnfIIpuv3F/Zm01q+YMKngtkaGB1C0Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742835481; c=relaxed/simple;
	bh=GAjiWgg4HWPbPDZzuesmogypGDRcnSTqKozhcrydPGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tAorWFnM+ZURxQxXNmJxWx1YXlIXvbNg5L7IkJ3/I2GSAvLo6Vp3/hVVUopXNMPTq5YD1BWuJjP2Eh27Z+RbuTH3fXHiuGJz5vYW+XEjL5lHlR1cN+YYUOXTdcIY1470O9U377I7jX9xunyGGe0jPy62PNTgpUnotgxVL4OpvKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cNIjS1gZ; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-224171d6826so14148805ad.3
        for <netdev@vger.kernel.org>; Mon, 24 Mar 2025 09:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742835479; x=1743440279; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Hl5JXhB/oD5qd1jityM6Yrtw+6FmDeKJJHolJ+2qNF0=;
        b=cNIjS1gZeXCrKz64tinsDruTggZH+wVtDbTLFpNhi59G0O/agNAvsIFIqqpa7CCtb5
         pmkRgmk2MlwfNiE4xf/A+rIsnmQ68HP4ZpLAmid8yZTxF3DPtEwbLR80Rn5+SL4azoZk
         40Vnmqpd0hHDT8yS/T6bEY6yemqAWhf4w131JX1qBlVnnVLncTVXh2D84i3v5MwR414K
         k1k+Dgph4VEZyhukVQ2Pe+HFOUoVXZBe/Np4x4CLlGGheSm9in9qUP7tLek2+1NUNZQJ
         n5c0FLV8jluC1rr7V3Hvsj+RRx61oFinRIehSCNDoC9uqtQV7QkQGvaG5m5lgUZfJziy
         lb7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742835479; x=1743440279;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hl5JXhB/oD5qd1jityM6Yrtw+6FmDeKJJHolJ+2qNF0=;
        b=tdn7+4DfXwBSe4q2R4XHP76ZvpL0p9Vhms8y1Ev1CcV/bX7NqqmVvNouxkdmqzqf7T
         ujsQZppcJYpX/YLtVPLvi5CjsM4RvwOEAY3Q9tlJ2upOA3mzpN3AI3l8RSdsBiZloyRh
         esT8v6t8zg4p3isulkmm/Pfd/xWXXO6JvBX22Gz5QNmTKDkAYxiz4TMFY5DHxFsoeFtQ
         PrJE39pNI5SSrBCvaS1YZgs3iZBacZ9cNJvJn52nmodCka0Zldkinpl5T2ryEEu9EoFH
         UNXi3UOCYiFjje4aVhe0w2lffsTeDsrh3nkPNpfpeGOfskJ4w9mYtBgVTq1gt3KtBQGV
         ryyg==
X-Gm-Message-State: AOJu0Yyjp+L1B/BMAM/ecdE+W7F7d/SUtf4V5yL/SY7g2LlkdRAlotZx
	z1nZnbX75whQjf1FB4MXHammyuCqLKWyad/ZnSHnr0EA79aDjDM=
X-Gm-Gg: ASbGncsXJKgQ2KL/r28AQ/GhcX4j9rG8Y066W4IxB8QwsOkBdMNXxD69f7WPubjLdlj
	wzhsHdsLwb/mYKzBxFZLaH7W+I1H+EIq1brztQg9XVoBIW9yAvpFyQ8FhoHiFwcfWnZCj5Se8Bg
	AhknkIodaZvyGqhnHRmiF+jfhijiXDTawlpH0Murl62Syr/mxMHia7hEx4jnNaC4fd2ummrhW3F
	U6bW7OSZz1DZBuTYfzi+Iku/Tle1KTtcTvUT3jgkAw0jkLx9advV+QvTQFPn8scIheLtVThIegC
	GSkmJ/8DiI+mbpPDDJyMqAsbmUPEB1FyDzse+RLdm4T4JSfdfojQpSk=
X-Google-Smtp-Source: AGHT+IFadqbpzD4JsYCKKDm44rNLSCudtS0pgYdD383YmmV+Nxgemxz+5BlXSouhRN/021w5S+2rng==
X-Received: by 2002:a05:6a21:6182:b0:1f5:92ac:d6b7 with SMTP id adf61e73a8af0-1fe42f07d09mr21653334637.4.1742835478660;
        Mon, 24 Mar 2025 09:57:58 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-af8a284888bsm7424507a12.46.2025.03.24.09.57.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 09:57:58 -0700 (PDT)
Date: Mon, 24 Mar 2025 09:57:57 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Taehee Yoo <ap420073@gmail.com>
Cc: Netdev <netdev@vger.kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	David Miller <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Subject: Re: Report deadlock in the latest net-next
Message-ID: <Z-GPFQou5GomWCOo@mini-arch>
References: <CAMArcTX2dEs=H586fumSEv_V8_p-pcAjyyPXkcLG9WkQM+c0cA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMArcTX2dEs=H586fumSEv_V8_p-pcAjyyPXkcLG9WkQM+c0cA@mail.gmail.com>

On 03/17, Taehee Yoo wrote:
> Hi Stanislav,
> I found a deadlock in the latest net-next kernel.
> The calltrace indicates your current
> commit ad7c7b2172c3 ("net: hold netdev instance lock during sysfs operations").
> The dev->lock was acquired in do_setlink.constprop.0+0x12a/0x3440,
> which is net/core/rtnetlink.c:3025
> And then dev->lock is acquired in dev_disable_lro+0x81/0x1f0,
> which is /net/core/dev_api.c:255
> dev_disable_lro() is called by netdev notification, but notification
> seems to be called both outside and inside dev->lock context.
> This case is that netdev notification is called inside dev->lock context.
> So deadlock occurs.
> Could you please look into this?
> 
> Reproducer:
> modprobe netdevsim
> ip netns add ns_test
> echo 1 > /sys/bus/netdevsim/new_device
> ip link set $interface netns ns_test
> 
> ============================================
> WARNING: possible recursive locking detected
> 6.14.0-rc6+ #56 Not tainted
> --------------------------------------------
> ip/1672 is trying to acquire lock:
> ffff888231fbad90 (&dev->lock){+.+.}-{4:4}, at: dev_disable_lro+0x81/0x1f0
> 
> but task is already holding lock:
> ffff888231fbad90 (&dev->lock){+.+.}-{4:4}, at:
> do_setlink.constprop.0+0x12a/0x3440
> 
> other info that might help us debug this:
>  Possible unsafe locking scenario:
> 
>        CPU0
>        ----
>   lock(&dev->lock);
>   lock(&dev->lock);
> 
>  *** DEADLOCK ***
> 
>  May be due to missing lock nesting notation
> 
> 3 locks held by ip/1672:
>  #0: ffffffff943ba050 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_newlink+0x6b4/0x1c60
>  #1: ffff88813abc6170 (&net->rtnl_mutex){+.+.}-{4:4}, at:
> rtnl_newlink+0x6f6/0x1c60
>  #2: ffff888231fbad90 (&dev->lock){+.+.}-{4:4}, at:
> do_setlink.constprop.0+0x12a/0x3440
> 
> stack backtrace:
> CPU: 2 UID: 0 PID: 1672 Comm: ip Not tainted 6.14.0-rc6+ #56
> 66129e0c5b1b922fef38623168aea99c0593a519
> Hardware name: ASUS System Product Name/PRIME Z690-P D4, BIOS 0603 11/01/2021
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0x7e/0xc0
>  print_deadlock_bug+0x4fd/0x8e0
>  __lock_acquire+0x3082/0x4fd0
>  ? __pfx___lock_acquire+0x10/0x10
>  ? mark_lock.part.0+0xfa/0x2f60
>  ? __pfx___lock_acquire+0x10/0x10
>  ? check_chain_key+0x1c1/0x520
>  lock_acquire+0x1b0/0x570
>  ? dev_disable_lro+0x81/0x1f0
>  ? __pfx_lock_acquire+0x10/0x10
>  __mutex_lock+0x17c/0x17c0
>  ? dev_disable_lro+0x81/0x1f0
>  ? dev_disable_lro+0x81/0x1f0
>  ? __pfx___mutex_lock+0x10/0x10
>  ? mark_held_locks+0xa5/0xf0
>  ? neigh_parms_alloc+0x36b/0x4f0
>  ? __local_bh_enable_ip+0xa5/0x120
>  ? lockdep_hardirqs_on+0xbe/0x140
>  ? dev_disable_lro+0x81/0x1f0
>  dev_disable_lro+0x81/0x1f0
>  inetdev_init+0x2d1/0x4a0
>  inetdev_event+0x9b3/0x1590
>  ? __pfx_lock_release+0x10/0x10
>  ? __pfx_inetdev_event+0x10/0x10
>  ? notifier_call_chain+0x9b/0x300
>  notifier_call_chain+0x9b/0x300
>  netif_change_net_namespace+0xdfe/0x1390
>  ? __pfx_netif_change_net_namespace+0x10/0x10
>  ? __pfx_validate_linkmsg+0x10/0x10
>  ? __pfx___lock_acquire+0x10/0x10
>  do_setlink.constprop.0+0x241/0x3440
>  ? lock_acquire+0x1b0/0x570
>  ? __pfx_do_setlink.constprop.0+0x10/0x10
>  ? rtnl_newlink+0x6f6/0x1c60
>  ? __pfx_lock_acquired+0x10/0x10
>  ? netlink_sendmsg+0x712/0xbc0
>  ? rcu_is_watching+0x11/0xb0
>  ? trace_contention_end+0xef/0x140
>  ? __mutex_lock+0x935/0x17c0
>  ? __create_object+0x36/0x90
>  ? __pfx_lock_release+0x10/0x10
>  ? rtnl_newlink+0x6f6/0x1c60
>  ? __nla_validate_parse+0xb9/0x2830
>  ? __pfx___mutex_lock+0x10/0x10
>  ? lockdep_hardirqs_on+0xbe/0x140
>  ? __pfx___nla_validate_parse+0x10/0x10
>  ? rcu_is_watching+0x11/0xb0
>  ? cap_capable+0x17d/0x360
>  ? fdget+0x4e/0x1d0
>  rtnl_newlink+0x108d/0x1c60
>  ? __pfx_rtnl_newlink+0x10/0x10
>  ? mark_lock.part.0+0xfa/0x2f60
>  ? __pfx___lock_acquire+0x10/0x10
>  ? __pfx_mark_lock.part.0+0x10/0x10
>  ? __pfx_lock_release+0x10/0x10
>  ? __pfx_rtnl_newlink+0x10/0x10
>  rtnetlink_rcv_msg+0x71c/0xc10
>  ? __pfx_rtnetlink_rcv_msg+0x10/0x10
>  ? check_chain_key+0x1c1/0x520
>  ? __pfx___lock_acquire+0x10/0x10
>  netlink_rcv_skb+0x12c/0x360
>  ? __pfx_rtnetlink_rcv_msg+0x10/0x10
>  ? __pfx_netlink_rcv_skb+0x10/0x10
>  ? netlink_deliver_tap+0xcb/0x9e0
>  ? netlink_deliver_tap+0x14b/0x9e0
>  netlink_unicast+0x447/0x710
>  ? __pfx_netlink_unicast+0x10/0x10
>  netlink_sendmsg+0x712/0xbc0
>  ? __pfx_netlink_sendmsg+0x10/0x10
>  ? _copy_from_user+0x3e/0xa0
>  ____sys_sendmsg+0x7ab/0xa10
>  ? __pfx_____sys_sendmsg+0x10/0x10
>  ? __pfx_copy_msghdr_from_user+0x10/0x10
>  ___sys_sendmsg+0xee/0x170
>  ? __pfx___lock_acquire+0x10/0x10
>  ? kasan_save_stack+0x20/0x40
>  ? __pfx____sys_sendmsg+0x10/0x10
>  ? entry_SYSCALL_64_after_hwframe+0x76/0x7e
>  ? kasan_save_stack+0x30/0x40
>  ? __pfx_lock_release+0x10/0x10
>  ? __might_fault+0xbf/0x170
>  __sys_sendmsg+0x105/0x190
>  ? __pfx___sys_sendmsg+0x10/0x10
>  ? rseq_syscall+0xc3/0x130
>  do_syscall_64+0x64/0x140
>  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> RIP: 0033:0x7fd20f92c004
> Code: 15 19 6e 0d 00 f7 d8 64 89 02 b8 ff ff ff ff eb bf 0f 1f 44 00
> 00 f3 0f 1e fa 80 3d 45 f0 0d 00 00 74 13 b8 2e 00 00 00 0f 05 <48> 3d
> 005
> RSP: 002b:00007fff40636e68 EFLAGS: 00000202 ORIG_RAX: 000000000000002e
> RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007fd20f92c004
> RDX: 0000000000000000 RSI: 00007fff40636ee0 RDI: 0000000000000003
> RBP: 00007fff40636f50 R08: 0000000067d7b7e9 R09: 0000000000000050
> R10: 0000000000000001 R11: 0000000000000202 R12: 0000000000000003
> R13: 0000000067d7b7ea R14: 000055d14b9e4040 R15: 0000000000000000
> 
> Thanks a lot!
> Taehee Yoo

Sorry, I completely missed that, I think this is similar to:

https://lore.kernel.org/netdev/Z-GDBlDsnPyc21RM@mini-arch/T/#u

?

Can you give it a quick test with the patches from that link?


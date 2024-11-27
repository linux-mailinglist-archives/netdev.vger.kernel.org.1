Return-Path: <netdev+bounces-147627-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 601FD9DACAA
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 18:44:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED35D164A58
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 17:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F022201022;
	Wed, 27 Nov 2024 17:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lgjF/qSJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6BF82D66;
	Wed, 27 Nov 2024 17:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732729440; cv=none; b=ZWwkbhltk4rxsuh0J1/xciVjsRlMV4b1yw/97uISOd04bm3fV1vWXfiZjrwNRqGzPwdno0UktT3UDPx83ljXYl7uZUaR7FYr+NnTl4IQBPjWJpF+mDuZw4GvlmNJ+o/YE6nZpEaExs1AdMC5CbSnV2ipw2uNbsyeOshvPkORu9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732729440; c=relaxed/simple;
	bh=wB0whHn3D1g+lo/zegfVYQ2VjMYarYN9RWMfyShvLfE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ESq2DUFk695Rk/yvgYCDn9jVm0PJwG3DsiPIa4amuB2cH16jfEKDXyAswi/CD8po1SHSPH5I5lPUxXHygyDB1qltGZEs0tiVxo5UtNfWEz1TUoEvvanlgMyBWC6T5W6YWwt6mLPIQzTYYcXz3LOsgh3Fuvo5Q8y+RVWa7JJt4Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lgjF/qSJ; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2ea499f264fso27686a91.1;
        Wed, 27 Nov 2024 09:43:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732729437; x=1733334237; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0mGzRd7mwpAf0UVUKW9E40rKesP5FbNQTDyPN+u3Ovk=;
        b=lgjF/qSJs8XYMuHisJP8l+tgJNLUplLTWlZFUniNue5OcW75YmApHvziOQ99V+G2VW
         PBTGkbAAGL4ClCuTO28gYe130oFTbxisSqsE8mIUAOnZCzpCfOwTojDdgN9VM2zk1o9A
         CVYkPtapCfFbP9PfVz7aFmm/sHZlf0fYYM0ihcS0N4r8QvhJEQEu9YBNg+ARXIwz0tp9
         hi5Hqp/MMqXP7l3p7tRm/uOhPTYUHEs8p3jUTHZablfm6YYWJcbgZFwl3vUuLrsWHtR9
         LXZCAzYEEkiX9Wjjn/MB9qXkuLUu/QkBMO2FNNpDTYVO2runxJqdZJzs1QZ0n4tj01Tt
         mBCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732729437; x=1733334237;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0mGzRd7mwpAf0UVUKW9E40rKesP5FbNQTDyPN+u3Ovk=;
        b=vBru2eBKo/EDwBPIzlCfMbtx2XdSoH6FlWPDEU1/BRq2xNVJ7Ym3L6RcucbIW7eKxr
         sTNyRII709XvcG96HsntnbMOhFKsC+JibJm2YneHGh4Ce2dVNo5ck3yegZvspWWYK9O7
         DGQWWW+os8XRbhdePuuEtA/dJy0O51XeimUN53S7pHTgv8FYNQEWBWCVGHxUejcLE/1m
         BjRizOMxZfBqMitw7mglqkLLyxxPLLb3cExzmRhjphb5TpOWr3T13lWpJRrMXPnX/3Fv
         d9OAXlb+qcBImAys9pKXC6D8ApifR/p98DR2H/DpkO43QI89o4icguIwux1tliCkLOr8
         NP5A==
X-Forwarded-Encrypted: i=1; AJvYcCUS5ZKrEXZpmKPJac4h+dSt9oTBM3W7MX+AsTBzfYFwSLXlRqt8qdnirDrcUPn4Z6YS7u02cvarl3k=@vger.kernel.org, AJvYcCVuKMumfZl+/7kfS3ew2pyM7x3y6N7d9vGE2WM5wgmE24iaM4ZTsUuAodz7xAsAtUw/1d2IOkrUuqQBKW+O@vger.kernel.org
X-Gm-Message-State: AOJu0YyaqBxtLpKScBnB6tk3/lvGq4MA5EZRXDOutNHHPnzBRLNCR6A4
	pAZi0JBEmqwWFXTStZzHntu4681tir1WVtxkWjoHH6eEEmfF5Dk5
X-Gm-Gg: ASbGnct8WlmtNKFnW0W37iirRwotS7JUxQwxBUwHjQtxK/d8YC2huwBJVA0KP//qWSr
	xa8REU9cCwLo1BFIm5O//hgjZ4mPXaeNK/H1rnARQbK4XLtabqsHpnCHyxPgl6Ff+B98YwzDRlw
	zca0z87dNjGvDdHJuxTjaASxxC6M8XyTyUF1iuC8t5SFPAiBLclnl/+j5ga3aIYT31Su/C4awqz
	/rPusseadwmUZDE13QkeDrsOwDQgc5Qgus+LFR0s2pyjMZNLzG+CApILrl2jJQ=
X-Google-Smtp-Source: AGHT+IHbHuH3VnLr23U01JOZQG2dZwrWXVVhZceYeCoseWnwS3olFWwj+t9oXBwCziOzWbtry6GZYw==
X-Received: by 2002:a17:90a:c387:b0:2ea:507f:49bd with SMTP id 98e67ed59e1d1-2ee25abe48dmr355511a91.2.1732729436890;
        Wed, 27 Nov 2024 09:43:56 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ee0fad063dsm1834182a91.32.2024.11.27.09.43.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 09:43:56 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 27 Nov 2024 09:43:54 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, mkarsten@uwaterloo.ca, skhawaja@google.com,
	sdf@fomichev.me, bjorn@rivosinc.com, amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com, willemdebruijn.kernel@gmail.com,
	edumazet@google.com, Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
	Jiri Pirko <jiri@resnulli.us>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Johannes Berg <johannes.berg@intel.com>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [net-next v6 5/9] net: napi: Add napi_config
Message-ID: <85dd4590-ea6b-427d-876a-1d8559c7ad82@roeck-us.net>
References: <20241011184527.16393-1-jdamato@fastly.com>
 <20241011184527.16393-6-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241011184527.16393-6-jdamato@fastly.com>

Hi,

On Fri, Oct 11, 2024 at 06:45:00PM +0000, Joe Damato wrote:
> Add a persistent NAPI config area for NAPI configuration to the core.
> Drivers opt-in to setting the persistent config for a NAPI by passing an
> index when calling netif_napi_add_config.
> 
> napi_config is allocated in alloc_netdev_mqs, freed in free_netdev
> (after the NAPIs are deleted).
> 
> Drivers which call netif_napi_add_config will have persistent per-NAPI
> settings: NAPI IDs, gro_flush_timeout, and defer_hard_irq settings.
> 
> Per-NAPI settings are saved in napi_disable and restored in napi_enable.
> 
> Co-developed-by: Martin Karsten <mkarsten@uwaterloo.ca>
> Signed-off-by: Martin Karsten <mkarsten@uwaterloo.ca>
> Signed-off-by: Joe Damato <jdamato@fastly.com>
> Reviewed-by: Jakub Kicinski <kuba@kernel.org>

This patch triggers a lock inversion message on pcnet Ethernet adapters.

========================================================
WARNING: possible irq lock inversion dependency detected
6.12.0-08446-g228a1157fb9f #1 Tainted: G                 N

The problem seems obvious - napi_hash_lock and the local driver lock are
acquired in different order depending on the call sequence. Unfortunately
I have no idea how to fix the problem or I'd submit a patch.

Complete backtrace and bisect log attached. Bisect was run with qemu on
riscv64, but the architecture/platform does not really matter.

Please let me know if there is anything I can do to help resolve the
problem.

Thanks,
Guenter

---
[   13.251894] ========================================================
[   13.252024] WARNING: possible irq lock inversion dependency detected
[   13.252307] 6.12.0-08446-g228a1157fb9f #1 Tainted: G                 N
[   13.252472] --------------------------------------------------------
[   13.252569] ip/1816 just changed the state of lock:
[   13.252678] ffffffff81dec490 (napi_hash_lock){+...}-{3:3}, at: napi_disable+0xf8/0x10c
[   13.253497] but this lock was taken by another, HARDIRQ-safe lock in the past:
[   13.253637]  (&lp->lock){-.-.}-{3:3}
[   13.253682]
[   13.253682]
[   13.253682] and interrupts could create inverse lock ordering between them.
[   13.253682]
[   13.253923]
[   13.253923] other info that might help us debug this:
[   13.254082]  Possible interrupt unsafe locking scenario:
[   13.254082]
[   13.254186]        CPU0                    CPU1
[   13.254264]        ----                    ----
[   13.254340]   lock(napi_hash_lock);
[   13.254438]                                local_irq_disable();
[   13.254532]                                lock(&lp->lock);
[   13.254649]                                lock(napi_hash_lock);
[   13.254772]   <Interrupt>
[   13.254828]     lock(&lp->lock);
[   13.254921]
[   13.254921]  *** DEADLOCK ***
[   13.254921]
[   13.255049] 1 lock held by ip/1816:
[   13.255127]  #0: ffffffff81dece50 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_newlink+0x22a/0x74c
[   13.255398]
[   13.255398] the shortest dependencies between 2nd lock and 1st lock:
[   13.255593]  -> (&lp->lock){-.-.}-{3:3} ops: 75 {
[   13.255802]     IN-HARDIRQ-W at:
[   13.255910]                       __lock_acquire+0xa3e/0x2158
[   13.256055]                       lock_acquire.part.0+0xba/0x21e
[   13.256153]                       lock_acquire+0x44/0x5a
[   13.256241]                       _raw_spin_lock+0x2c/0x40
[   13.256343]                       pcnet32_interrupt+0x3c/0x200
[   13.256442]                       __handle_irq_event_percpu+0xa0/0x2e0
[   13.256547]                       handle_irq_event+0x3c/0x8a
[   13.256640]                       handle_fasteoi_irq+0x9c/0x1d2
[   13.256738]                       generic_handle_domain_irq+0x1c/0x2a
[   13.256840]                       plic_handle_irq+0x7e/0xfc
[   13.256937]                       generic_handle_domain_irq+0x1c/0x2a
[   13.257041]                       riscv_intc_irq+0x26/0x60
[   13.257133]                       handle_riscv_irq+0x4a/0x74
[   13.257228]                       call_on_irq_stack+0x32/0x40
[   13.257349]     IN-SOFTIRQ-W at:
[   13.257420]                       __lock_acquire+0x40a/0x2158
[   13.257515]                       lock_acquire.part.0+0xba/0x21e
[   13.257611]                       lock_acquire+0x44/0x5a
[   13.257699]                       _raw_spin_lock_irqsave+0x3a/0x64
[   13.257798]                       pcnet32_poll+0x2ac/0x768
[   13.257892]                       __napi_poll.constprop.0+0x26/0x128
[   13.257997]                       net_rx_action+0x186/0x30e
[   13.258090]                       handle_softirqs+0x110/0x4a2
[   13.258187]                       __irq_exit_rcu+0xe2/0x10c
[   13.258279]                       irq_exit_rcu+0xc/0x36
[   13.258368]                       handle_riscv_irq+0x64/0x74
[   13.258463]                       call_on_irq_stack+0x32/0x40
[   13.258558]     INITIAL USE at:
[   13.258629]                      __lock_acquire+0x46c/0x2158
[   13.258723]                      lock_acquire.part.0+0xba/0x21e
[   13.258820]                      lock_acquire+0x44/0x5a
[   13.258909]                      _raw_spin_lock_irqsave+0x3a/0x64
[   13.259007]                      pcnet32_get_stats+0x2a/0x62
[   13.259101]                      dev_get_stats+0xc4/0x2a6
[   13.259380]                      rtnl_fill_stats+0x32/0xee
[   13.259480]                      rtnl_fill_ifinfo.isra.0+0x648/0x141c
[   13.259589]                      rtmsg_ifinfo_build_skb+0x98/0xf0
[   13.259711]                      rtmsg_ifinfo+0x36/0x78
[   13.259799]                      register_netdevice+0x758/0x7a8
[   13.259905]                      register_netdev+0x18/0x2e
[   13.259999]                      pcnet32_probe1+0xb96/0x103e
[   13.260099]                      pcnet32_probe_pci+0xcc/0x12e
[   13.260196]                      pci_device_probe+0x82/0x100
[   13.260291]                      really_probe+0x86/0x234
[   13.260383]                      __driver_probe_device+0x5c/0xda
[   13.260482]                      driver_probe_device+0x2c/0xb2
[   13.260578]                      __driver_attach+0x70/0x120
[   13.260671]                      bus_for_each_dev+0x60/0xae
[   13.260764]                      driver_attach+0x1a/0x22
[   13.260853]                      bus_add_driver+0xce/0x1d6
[   13.260951]                      driver_register+0x3e/0xd8
[   13.261048]                      __pci_register_driver+0x5c/0x66
[   13.261149]                      pcnet32_init_module+0x58/0x14a
[   13.261255]                      do_one_initcall+0x7e/0x2b6
[   13.261352]                      kernel_init_freeable+0x2cc/0x33e
[   13.261456]                      kernel_init+0x1e/0x11a
[   13.261550]                      ret_from_fork+0xe/0x18
[   13.261653]   }
[   13.261705]   ... key      at: [<ffffffff82a9efb0>] __key.4+0x0/0x10
[   13.261839]   ... acquired at:
[   13.261907]    lock_acquire.part.0+0xba/0x21e
[   13.261987]    lock_acquire+0x44/0x5a
[   13.262056]    _raw_spin_lock+0x2c/0x40
[   13.262132]    napi_hash_add+0x26/0xb8
[   13.262207]    napi_enable+0x10e/0x124
[   13.262281]    pcnet32_open+0x3c2/0x6b8
[   13.262357]    __dev_open+0xba/0x158
[   13.262427]    __dev_change_flags+0x19a/0x214
[   13.262508]    dev_change_flags+0x1e/0x56
[   13.262583]    do_setlink.isra.0+0x20c/0xcc2
[   13.262661]    rtnl_newlink+0x592/0x74c
[   13.262731]    rtnetlink_rcv_msg+0x3a8/0x582
[   13.262807]    netlink_rcv_skb+0x44/0xf4
[   13.262882]    rtnetlink_rcv+0x14/0x1c
[   13.262956]    netlink_unicast+0x1a0/0x23e
[   13.263031]    netlink_sendmsg+0x17e/0x38e
[   13.263109]    __sock_sendmsg+0x40/0x7a
[   13.263182]    ____sys_sendmsg+0x18e/0x1de
[   13.263288]    ___sys_sendmsg+0x82/0xc6
[   13.263360]    __sys_sendmsg+0x8e/0xe0
[   13.263430]    __riscv_sys_sendmsg+0x16/0x1e
[   13.263507]    do_trap_ecall_u+0x1b6/0x1e2
[   13.263583]    _new_vmalloc_restore_context_a0+0xc2/0xce
[   13.263685]
[   13.263746] -> (napi_hash_lock){+...}-{3:3} ops: 2 {
[   13.263891]    HARDIRQ-ON-W at:
[   13.263963]                     __lock_acquire+0x688/0x2158
[   13.264057]                     lock_acquire.part.0+0xba/0x21e
[   13.264153]                     lock_acquire+0x44/0x5a
[   13.264240]                     _raw_spin_lock+0x2c/0x40
[   13.264330]                     napi_disable+0xf8/0x10c
[   13.264419]                     pcnet32_close+0x5c/0x126
[   13.264511]                     __dev_close_many+0x8a/0xf8
[   13.264609]                     __dev_change_flags+0x176/0x214
[   13.264708]                     dev_change_flags+0x1e/0x56
[   13.264800]                     do_setlink.isra.0+0x20c/0xcc2
[   13.264900]                     rtnl_newlink+0x592/0x74c
[   13.264988]                     rtnetlink_rcv_msg+0x3a8/0x582
[   13.265082]                     netlink_rcv_skb+0x44/0xf4
[   13.265174]                     rtnetlink_rcv+0x14/0x1c
[   13.265268]                     netlink_unicast+0x1a0/0x23e
[   13.265367]                     netlink_sendmsg+0x17e/0x38e
[   13.265466]                     __sock_sendmsg+0x40/0x7a
[   13.265557]                     ____sys_sendmsg+0x18e/0x1de
[   13.265649]                     ___sys_sendmsg+0x82/0xc6
[   13.265738]                     __sys_sendmsg+0x8e/0xe0
[   13.265828]                     __riscv_sys_sendmsg+0x16/0x1e
[   13.265928]                     do_trap_ecall_u+0x1b6/0x1e2
[   13.266024]                     _new_vmalloc_restore_context_a0+0xc2/0xce
[   13.266134]    INITIAL USE at:
[   13.266206]                    __lock_acquire+0x46c/0x2158
[   13.266298]                    lock_acquire.part.0+0xba/0x21e
[   13.266394]                    lock_acquire+0x44/0x5a
[   13.266480]                    _raw_spin_lock+0x2c/0x40
[   13.266572]                    napi_hash_add+0x26/0xb8
[   13.266660]                    napi_enable+0x10e/0x124
[   13.266748]                    pcnet32_open+0x3c2/0x6b8
[   13.266839]                    __dev_open+0xba/0x158
[   13.266930]                    __dev_change_flags+0x19a/0x214
[   13.267026]                    dev_change_flags+0x1e/0x56
[   13.267116]                    do_setlink.isra.0+0x20c/0xcc2
[   13.267211]                    rtnl_newlink+0x592/0x74c
[   13.267299]                    rtnetlink_rcv_msg+0x3a8/0x582
[   13.267395]                    netlink_rcv_skb+0x44/0xf4
[   13.267489]                    rtnetlink_rcv+0x14/0x1c
[   13.267578]                    netlink_unicast+0x1a0/0x23e
[   13.267670]                    netlink_sendmsg+0x17e/0x38e
[   13.267763]                    __sock_sendmsg+0x40/0x7a
[   13.267851]                    ____sys_sendmsg+0x18e/0x1de
[   13.267946]                    ___sys_sendmsg+0x82/0xc6
[   13.268034]                    __sys_sendmsg+0x8e/0xe0
[   13.268121]                    __riscv_sys_sendmsg+0x16/0x1e
[   13.268215]                    do_trap_ecall_u+0x1b6/0x1e2
[   13.268309]                    _new_vmalloc_restore_context_a0+0xc2/0xce
[   13.268419]  }
[   13.268460]  ... key      at: [<ffffffff81dec490>] napi_hash_lock+0x18/0x40
[   13.268579]  ... acquired at:
[   13.268636]    mark_lock+0x5f2/0x88a
[   13.268705]    __lock_acquire+0x688/0x2158
[   13.268779]    lock_acquire.part.0+0xba/0x21e
[   13.268858]    lock_acquire+0x44/0x5a
[   13.268930]    _raw_spin_lock+0x2c/0x40
[   13.269002]    napi_disable+0xf8/0x10c
[   13.269073]    pcnet32_close+0x5c/0x126
[   13.269145]    __dev_close_many+0x8a/0xf8
[   13.269220]    __dev_change_flags+0x176/0x214
[   13.269298]    dev_change_flags+0x1e/0x56
[   13.269371]    do_setlink.isra.0+0x20c/0xcc2
[   13.269449]    rtnl_newlink+0x592/0x74c
[   13.269520]    rtnetlink_rcv_msg+0x3a8/0x582
[   13.269596]    netlink_rcv_skb+0x44/0xf4
[   13.269671]    rtnetlink_rcv+0x14/0x1c
[   13.269742]    netlink_unicast+0x1a0/0x23e
[   13.269818]    netlink_sendmsg+0x17e/0x38e
[   13.269894]    __sock_sendmsg+0x40/0x7a
[   13.269966]    ____sys_sendmsg+0x18e/0x1de
[   13.270041]    ___sys_sendmsg+0x82/0xc6
[   13.270114]    __sys_sendmsg+0x8e/0xe0
[   13.270187]    __riscv_sys_sendmsg+0x16/0x1e
[   13.270268]    do_trap_ecall_u+0x1b6/0x1e2
[   13.270346]    _new_vmalloc_restore_context_a0+0xc2/0xce
[   13.270439]
[   13.270525]
[   13.270525] stack backtrace:
[   13.270729] CPU: 0 UID: 0 PID: 1816 Comm: ip Tainted: G                 N 6.12.0-08446-g228a1157fb9f #1
[   13.270933] Tainted: [N]=TEST
[   13.271006] Hardware name: riscv-virtio,qemu (DT)
[   13.271165] Call Trace:
[   13.271270] [<ffffffff80006d42>] dump_backtrace+0x1c/0x24
[   13.271373] [<ffffffff80dc5574>] show_stack+0x2c/0x38
[   13.271467] [<ffffffff80ddc854>] dump_stack_lvl+0x74/0xac
[   13.271565] [<ffffffff80ddc8a0>] dump_stack+0x14/0x1c
[   13.271657] [<ffffffff8008551a>] print_irq_inversion_bug.part.0+0x1aa/0x1fe
[   13.271775] [<ffffffff800867f8>] mark_lock+0x5f2/0x88a
[   13.271869] [<ffffffff80087d44>] __lock_acquire+0x688/0x2158
[   13.271973] [<ffffffff80086e10>] lock_acquire.part.0+0xba/0x21e
[   13.272078] [<ffffffff80086fb8>] lock_acquire+0x44/0x5a
[   13.272173] [<ffffffff80de8ea4>] _raw_spin_lock+0x2c/0x40
[   13.272269] [<ffffffff80b89bf0>] napi_disable+0xf8/0x10c
[   13.272360] [<ffffffff8099d022>] pcnet32_close+0x5c/0x126
[   13.272454] [<ffffffff80b8fa52>] __dev_close_many+0x8a/0xf8
[   13.272549] [<ffffffff80b9790e>] __dev_change_flags+0x176/0x214
[   13.272647] [<ffffffff80b979ca>] dev_change_flags+0x1e/0x56
[   13.272740] [<ffffffff80ba93a8>] do_setlink.isra.0+0x20c/0xcc2
[   13.272838] [<ffffffff80baa3f0>] rtnl_newlink+0x592/0x74c
[   13.272935] [<ffffffff80babf5a>] rtnetlink_rcv_msg+0x3a8/0x582
[   13.273032] [<ffffffff80c05bcc>] netlink_rcv_skb+0x44/0xf4
[   13.273127] [<ffffffff80ba64f6>] rtnetlink_rcv+0x14/0x1c
[   13.273223] [<ffffffff80c05578>] netlink_unicast+0x1a0/0x23e
[   13.273326] [<ffffffff80c05794>] netlink_sendmsg+0x17e/0x38e
[   13.273423] [<ffffffff80b633e2>] __sock_sendmsg+0x40/0x7a
[   13.273515] [<ffffffff80b63742>] ____sys_sendmsg+0x18e/0x1de
[   13.273610] [<ffffffff80b65e44>] ___sys_sendmsg+0x82/0xc6
[   13.273704] [<ffffffff80b662ac>] __sys_sendmsg+0x8e/0xe0
[   13.273795] [<ffffffff80b66314>] __riscv_sys_sendmsg+0x16/0x1e
[   13.273894] [<ffffffff80ddd3e4>] do_trap_ecall_u+0x1b6/0x1e2
[   13.273992] [<ffffffff80de9c7a>] _new_vmalloc_restore_context_a0+0xc2/0xce

---
# bad: [228a1157fb9fec47eb135b51c0202b574e079ebf] Merge tag '6.13-rc-part1-SMB3-client-fixes' of git://git.samba.org/sfrench/cifs-2.6
# good: [43fb83c17ba2d63dfb798f0be7453ed55ca3f9c2] Merge tag 'soc-arm-6.13' of git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc
git bisect start '228a1157fb9f' '43fb83c17ba2'
# bad: [071b34dcf71523a559b6c39f5d21a268a9531b50] Merge tag 'sound-6.13-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound
git bisect bad 071b34dcf71523a559b6c39f5d21a268a9531b50
# bad: [31a1f8752f7df7e3d8122054fbef02a9a8bff38f] Merge branch 'phy-mediatek-reorg'
git bisect bad 31a1f8752f7df7e3d8122054fbef02a9a8bff38f
# bad: [de51ad08b1177bbbb8b60cb7dd4c3c5dd50d262f] phonet: Pass net and ifindex to rtm_phonet_notify().
git bisect bad de51ad08b1177bbbb8b60cb7dd4c3c5dd50d262f
# good: [76d46d766a45e205e59af511efbb24abe22d0b4c] net: emaclite: Adopt clock support
git bisect good 76d46d766a45e205e59af511efbb24abe22d0b4c
# bad: [a37b0e4eca0436ebc17d512d70b1409956340688] ipv6: Use rtnl_register_many().
git bisect bad a37b0e4eca0436ebc17d512d70b1409956340688
# bad: [de306f0051ae947680a13c13a9fd9373d7460bb1] net: gianfar: Use __be64 * to store pointers to big endian values
git bisect bad de306f0051ae947680a13c13a9fd9373d7460bb1
# good: [5c16e118b796e95d6e5c80c5d8af2591262431c9] net: ethernet: ti: am65-cpsw: Use __be64 type for id_temp
git bisect good 5c16e118b796e95d6e5c80c5d8af2591262431c9
# bad: [41936522749654e64531121bbd6a95bab5d56d76] bnxt: Add support for persistent NAPI config
git bisect bad 41936522749654e64531121bbd6a95bab5d56d76
# good: [79636038d37e7bd4d078238f2a3f002cab4423bc] ipv4: tcp: give socket pointer to control skbs
git bisect good 79636038d37e7bd4d078238f2a3f002cab4423bc
# good: [516010460011ae74ac3b7383cf90ed27e2711cd6] netdev-genl: Dump napi_defer_hard_irqs
git bisect good 516010460011ae74ac3b7383cf90ed27e2711cd6
# good: [0137891e74576f77a7901718dc0ce08ca074ae74] netdev-genl: Dump gro_flush_timeout
git bisect good 0137891e74576f77a7901718dc0ce08ca074ae74
# bad: [1287c1ae0fc227e5acef11a539eb4e75646e31c7] netdev-genl: Support setting per-NAPI config values
git bisect bad 1287c1ae0fc227e5acef11a539eb4e75646e31c7
# bad: [86e25f40aa1e9e54e081e55016f65b5c92523989] net: napi: Add napi_config
git bisect bad 86e25f40aa1e9e54e081e55016f65b5c92523989
# first bad commit: [86e25f40aa1e9e54e081e55016f65b5c92523989] net: napi: Add napi_config


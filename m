Return-Path: <netdev+bounces-214548-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ECCDB2A17E
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 14:26:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B3174E195D
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 12:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D606831AF1A;
	Mon, 18 Aug 2025 12:23:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B52D32039A;
	Mon, 18 Aug 2025 12:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755519809; cv=none; b=svXkbzt/6geqgeEXJm1ZLuCbXjz1WY6Is58mdtnM4xoTT/T58f/BWL6c2SEcJDxi6ABDegk0dv95uq45zQo050g4RhGMDN0JIhh6bv2BHAYxGXXmw1h9icHzyJ4aYcGLWUHUO0/M4c+YG5quSI7rQGjGMxNloswe6Ggym/TAEvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755519809; c=relaxed/simple;
	bh=cNWqQt4MQ5WbtZt7THB+L+EyhqSLbC01jmaTO9WPyFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kRoUuroNSIuLzLSVX9lupXObrNDopBR/ZuisDegxy1DocbthXWF5vUL0bz3H1qUqcq20Xx3xhFnz79+YzqDFG3GWqKUcSjUesMgYA3gv9oHnGc7LHh9Lj+T0nmSLbyQ1+Lojrki5JyLmgbj8B+rco4SW1DqK+0IK4Noa0573Rxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-afcb7347e09so647661366b.0;
        Mon, 18 Aug 2025 05:23:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755519806; x=1756124606;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U6rqL6iy7ieXF8l9k3RF3H9T+sQpJgI0Ss9KmW6zFcc=;
        b=LhIZxmcnfoP3DvSJVZdF4kp3ngKSNyVFIT2H5CmlbFedRg+RtDOj5eGMql+RD7vKNp
         9vPyx05N4O65UCtrDcQR7PNntHUDLZW2RuZwsbP/+Ut1gwN2phhjJINQziblpH0saoJx
         D5hyRM77arNRJjCpicDd7/dGteXrNYRbjMSJCXsuQPJhQisYbqZn3rTISAQrw1bBL1W1
         71pyvcU3hCJt50Lw+y7zrdM58vp+7phc5TYf9ZjE+VLVg3qOZWQn/3acQeTJ+ZFK3Em5
         LZcP/PgVxMDoiYee65PqQ8tjdavyLfj5Zb53rKInb+Pdbas3Wg16vl54vXi3TXBJPo7J
         Mn7A==
X-Forwarded-Encrypted: i=1; AJvYcCU7QnrRDlIPaLlWPEyNRN5z0UVtqtmnkuzOtYiq80UB5v6g1YDfIRR8bz1zNDKVRSZNnVT+eamQoYkCO3w=@vger.kernel.org, AJvYcCUtHpH2kMI8ASLnbZTicmIeZ/IEF7KlrDsuk0C+sMo/iAjn1faZL6z6BlfeGymckVb4q5Kw1wDc@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5f71pwvpI63KzX0ghw8gf8XvcLhQRpPze3MvrtiC+W7LC+qcj
	iZlLILNFg1uSRiHhA5mjKxG+eqhUtiIyjqnZj10KTGRwBECoLcQkGrNop+DjOA==
X-Gm-Gg: ASbGncs04FvjbB5eZcnMrTCadOWxA7RQ8dBL5j339JVrKYOxH4/gPyQYwQvoMkRBeqg
	h6Pz/kYk2iUtDArfmvSbzEi9RPVrh3EUNi0EVLc8PuFA27yubkzylmSKlKvcTlaMmGyOyPE1Iw0
	tif0mGgaw1yWuCWE8A9dt5tleEBlYtShDITasd1TIgJA1TwUgSbNmgJqYi9nOxxJsFPdHEqQnzp
	aseORMJ7FC/RI2fPb3cK1GSEqCROOCSjO9vS1szFcHlVO0BE0fxJseYlxcw6OdzD7jh/Z0yCKaQ
	n4dAqu03AvIShO6HZNCHv/A8KBRHAhc/ERK5swdlO93qrT6a79bwIUF9DB146IRDMG2KGgkvdVo
	fWTK7saMK+5oTrwOcUsveIwg=
X-Google-Smtp-Source: AGHT+IEOqqd2eRXiy1eXOTzfBqOwvwXHDUFfANHxGgZqUyJ9n17gbQzGnyDvI2Pe1/7btASpZQURuQ==
X-Received: by 2002:a17:907:7291:b0:af9:1184:68b3 with SMTP id a640c23a62f3a-afcdc374d8fmr1194852766b.55.1755519805280;
        Mon, 18 Aug 2025 05:23:25 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:7::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afcdce54021sm787088566b.10.2025.08.18.05.23.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 05:23:24 -0700 (PDT)
Date: Mon, 18 Aug 2025 05:23:22 -0700
From: Breno Leitao <leitao@debian.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Pavel Begunkov <asml.silence@gmail.com>, 
	Johannes Berg <johannes@sipsolutions.net>, Mike Galbraith <efault@gmx.de>, paulmck@kernel.org, 
	LKML <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org, boqun.feng@gmail.com
Subject: Re: netconsole: HARDIRQ-safe -> HARDIRQ-unsafe lock order warning
Message-ID: <ckitlqjbhhnspqfvj4wnp4d67h7dw7gsxtntyl6skvyplgxwuf@itqjvgdwbiuh>
References: <fb38cfe5153fd67f540e6e8aff814c60b7129480.camel@gmx.de>
 <oth5t27z6acp7qxut7u45ekyil7djirg2ny3bnsvnzeqasavxb@nhwdxahvcosh>
 <20250814172326.18cf2d72@kernel.org>
 <3d20ce1b-7a9b-4545-a4a9-23822b675e0c@gmail.com>
 <20250815094217.1cce7116@kernel.org>
 <isnqkmh36mnzm5ic5ipymltzljkxx3oxapez5asp24tivwtar2@4mx56cvxtrnh>
 <20250815103308.4993df04@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250815103308.4993df04@kernel.org>

On Fri, Aug 15, 2025 at 10:33:08AM -0700, Jakub Kicinski wrote:
> On Fri, 15 Aug 2025 10:29:00 -0700 Breno Leitao wrote:
> > On Fri, Aug 15, 2025 at 09:42:17AM -0700, Jakub Kicinski wrote:
> > > On Fri, 15 Aug 2025 11:44:45 +0100 Pavel Begunkov wrote:  
> > > > On 8/15/25 01:23, Jakub Kicinski wrote:  
> > > 
> > > I suspect disabling netconsole over WiFi may be the most sensible way out.  
> > 
> > I believe we might be facing a similar issue with virtio-net.
> 
> I could be misremembering but I thought virtio-net try_lock()s.

virtio-net shows the same problem on net-next, as of bab3ce404553de56242
("Merge branch '100GbE' of
git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue")

	 Chain exists of:
	   console_owner --> target_list_lock --> _xmit_ETHER#2

Looking at the stack I see it is using try lock:

	_raw_spin_trylock (./include/linux/spinlock_api_smp.h:90 kernel/locking/spinlock.c:138)
	virtnet_poll (./include/linux/spinlock.h:? ./include/linux/netdevice.h:4684 drivers/net/virtio_net.c:3056 drivers/net/virtio_net.c:3108)

Why would the try_lock() avoid such a problem?

I understand that, whenever the try_lock() succeed, it will reach
a HARDIRQ-unsafe lock (_xmit_ETHER) from a HARDIRQ-safe lock (console
lock), which is the path that should be avoided.

Full lockdep snippet when using virtio-net:

[   16.284303] ========================================================
[   16.284303] WARNING: possible irq lock inversion dependency detected
[   16.284305] 6.17.0-rc1-00216-g059cb8675a8c #8 Tainted: G            E
[   16.284306] --------------------------------------------------------
[   16.284306] swapper/16/0 just changed the state of lock:
[   16.284307] ffffffff82d84290 (console_owner){-...}-{0:0}, at: console_flush_all (./include/linux/rcupdate.h:336 ./include/linux/srcu.h:319 kernel/printk/printk.c:288 kernel/printk/printk.c:3203) 
[   16.284315] but this lock took another, HARDIRQ-unsafe lock in the past:
[   16.284316]  (_xmit_ETHER#2){+.-.}-{3:3}
[   16.284317]
[   16.284317]
[   16.284317] and interrupts could create inverse lock ordering between them.
[   16.284317]
[   16.284318]
[   16.284318] other info that might help us debug this:
[   16.284318] Chain exists of:
[   16.284318]   console_owner --> target_list_lock --> _xmit_ETHER#2
[   16.284318]
[   16.284320]  Possible interrupt unsafe locking scenario:
[   16.284320]
[   16.284321]        CPU0                    CPU1
[   16.284321]        ----                    ----
[   16.284321]   lock(_xmit_ETHER#2);
[   16.284322]                                local_irq_disable();
[   16.284323]                                lock(console_owner);
[   16.284323]                                lock(target_list_lock);
[   16.284324]   <Interrupt>
[   16.284324]     lock(console_owner);
[   16.284325]
[   16.284325]  *** DEADLOCK ***
[   16.284325]
[   16.284325] 2 locks held by swapper/16/0:
[   16.284326] #0: ffffffff82d842b8 (console_lock){+.+.}-{0:0}, at: irq_work_run_list (kernel/irq_work.c:222 kernel/irq_work.c:252) 
[   16.284330] #1: ffffffff82683d60 (console_srcu){....}-{0:0}, at: console_flush_all (./include/linux/rcupdate.h:336 ./include/linux/srcu.h:319 kernel/printk/printk.c:288 kernel/printk/printk.c:3203) 
[   16.284333]
[   16.284333] the shortest dependencies between 2nd lock and 1st lock:
[   16.284336]   -> (_xmit_ETHER#2){+.-.}-{3:3} ops: 558 {
[   16.284340]      HARDIRQ-ON-W at:
[   16.284342] lock_acquire (kernel/locking/lockdep.c:5868) 
[   16.284343] _raw_spin_trylock (./include/linux/spinlock_api_smp.h:90 kernel/locking/spinlock.c:138) 
[   16.284346] virtnet_poll (./include/linux/spinlock.h:? ./include/linux/netdevice.h:4684 drivers/net/virtio_net.c:3056 drivers/net/virtio_net.c:3108) 
[   16.284348] __napi_poll (./arch/x86/include/asm/jump_label.h:36 ./include/trace/events/napi.h:14 net/core/dev.c:7495) 
[   16.284350] net_rx_action (net/core/dev.c:7559 net/core/dev.c:7684) 
[   16.284351] handle_softirqs (./arch/x86/include/asm/jump_label.h:36 ./include/trace/events/irq.h:142 kernel/softirq.c:580) 
[   16.284353] do_softirq (kernel/softirq.c:480) 
[   16.284353] __local_bh_enable_ip (kernel/softirq.c:?) 
[   16.284354] virtnet_napi_enable (drivers/net/virtio_net.c:2874) 
[   16.284356] virtnet_open (drivers/net/virtio_net.c:? drivers/net/virtio_net.c:3211) 
[   16.284357] __dev_open (net/core/dev.c:1682) 
[   16.284358] netif_open (net/core/dev.c:1706) 
[   16.284359] dev_open (net/core/dev_api.c:?) 
[   16.284360] netpoll_setup (net/core/netpoll.c:744) 
[   16.284361] init_netconsole (drivers/net/netconsole.c:1876 drivers/net/netconsole.c:1927) 
[   16.284364] do_one_initcall (init/main.c:1269) 
[   16.284365] do_initcall_level (init/main.c:1330) 
[   16.284367] do_initcalls (init/main.c:1344) 
[   16.284369] kernel_init_freeable (init/main.c:1583) 
[   16.284452] kernel_init (init/main.c:1471) 
[   16.284455] ret_from_fork (arch/x86/kernel/process.c:154) 
[   16.284456] ret_from_fork_asm (arch/x86/entry/entry_64.S:258) 
[   16.284458]      IN-SOFTIRQ-W at:
[   16.284458] lock_acquire (kernel/locking/lockdep.c:5868) 
[   16.284459] _raw_spin_lock (./include/linux/spinlock_api_smp.h:133 kernel/locking/spinlock.c:154) 
[   16.284460] virtnet_poll_tx (./include/linux/netdevice.h:4661 drivers/net/virtio_net.c:3255) 
[   16.284462] __napi_poll (./arch/x86/include/asm/jump_label.h:36 ./include/trace/events/napi.h:14 net/core/dev.c:7495) 
[   16.284463] net_rx_action (net/core/dev.c:7559 net/core/dev.c:7684) 
[   16.284463] handle_softirqs (./arch/x86/include/asm/jump_label.h:36 ./include/trace/events/irq.h:142 kernel/softirq.c:580) 
[   16.284464] do_softirq (kernel/softirq.c:480) 
[   16.284465] __local_bh_enable_ip (kernel/softirq.c:?) 
[   16.284466] virtnet_napi_tx_enable (drivers/net/virtio_net.c:2895) 
[   16.284467] virtnet_open (drivers/net/virtio_net.c:3205) 
[   16.284468] __dev_open (net/core/dev.c:1682) 
[   16.284469] netif_open (net/core/dev.c:1706) 
[   16.284470] dev_open (net/core/dev_api.c:?) 
[   16.284470] netpoll_setup (net/core/netpoll.c:744) 
[   16.284471] init_netconsole (drivers/net/netconsole.c:1876 drivers/net/netconsole.c:1927) 
[   16.284472] do_one_initcall (init/main.c:1269) 
[   16.284473] do_initcall_level (init/main.c:1330) 
[   16.284475] do_initcalls (init/main.c:1344) 
[   16.284476] kernel_init_freeable (init/main.c:1583) 
[   16.284478] kernel_init (init/main.c:1471) 
[   16.284479] ret_from_fork (arch/x86/kernel/process.c:154) 
[   16.284480] ret_from_fork_asm (arch/x86/entry/entry_64.S:258) 
[   16.284481]      INITIAL USE at:
[   16.284482] lock_acquire (kernel/locking/lockdep.c:5868) 
[   16.284482] _raw_spin_trylock (./include/linux/spinlock_api_smp.h:90 kernel/locking/spinlock.c:138) 
[   16.284484] virtnet_poll (./include/linux/spinlock.h:? ./include/linux/netdevice.h:4684 drivers/net/virtio_net.c:3056 drivers/net/virtio_net.c:3108) 
[   16.284485] __napi_poll (./arch/x86/include/asm/jump_label.h:36 ./include/trace/events/napi.h:14 net/core/dev.c:7495) 
[   16.284485] net_rx_action (net/core/dev.c:7559 net/core/dev.c:7684) 
[   16.284486] handle_softirqs (./arch/x86/include/asm/jump_label.h:36 ./include/trace/events/irq.h:142 kernel/softirq.c:580) 
[   16.284487] do_softirq (kernel/softirq.c:480) 
[   16.284488] __local_bh_enable_ip (kernel/softirq.c:?) 
[   16.284489] virtnet_napi_enable (drivers/net/virtio_net.c:2874) 
[   16.284490] virtnet_open (drivers/net/virtio_net.c:? drivers/net/virtio_net.c:3211) 
[   16.284490] __dev_open (net/core/dev.c:1682) 
[   16.284491] netif_open (net/core/dev.c:1706) 
[   16.284492] dev_open (net/core/dev_api.c:?) 
[   16.284492] netpoll_setup (net/core/netpoll.c:744) 
[   16.284493] init_netconsole (drivers/net/netconsole.c:1876 drivers/net/netconsole.c:1927) 
[   16.284494] do_one_initcall (init/main.c:1269) 
[   16.284495] do_initcall_level (init/main.c:1330) 
[   16.284496] do_initcalls (init/main.c:1344) 
[   16.284498] kernel_init_freeable (init/main.c:1583) 
[   16.284499] kernel_init (init/main.c:1471) 
[   16.284501] ret_from_fork (arch/x86/kernel/process.c:154) 
[   16.284502] ret_from_fork_asm (arch/x86/entry/entry_64.S:258) 
[   16.284503]    }
[   16.284503] ... key at: netdev_xmit_lock_key+0x10/0x390 
[   16.284506]    ... acquired at:
[   16.284507] _raw_spin_lock (./include/linux/spinlock_api_smp.h:133 kernel/locking/spinlock.c:154) 
[   16.284508] virtnet_poll_tx (./include/linux/netdevice.h:4661 drivers/net/virtio_net.c:3255) 
[   16.284509] netpoll_poll_dev (net/core/netpoll.c:157 net/core/netpoll.c:170 net/core/netpoll.c:200) 
[   16.284510] netpoll_send_skb (./include/asm-generic/delay.h:62 net/core/netpoll.c:356 net/core/netpoll.c:410) 
[   16.284511] netpoll_send_udp (net/core/netpoll.c:532) 
[   16.284511] write_ext_msg (drivers/net/netconsole.c:1498 drivers/net/netconsole.c:1536 drivers/net/netconsole.c:1692 drivers/net/netconsole.c:1710) 
[   16.284513] console_flush_all (kernel/printk/printk.c:3055 kernel/printk/printk.c:3139 kernel/printk/printk.c:3226) 
[   16.284515] console_unlock (kernel/printk/printk.c:3285 kernel/printk/printk.c:3325) 
[   16.284516] vprintk_emit (kernel/printk/printk.c:?) 
[   16.284518] _printk (kernel/printk/printk.c:2478) 
[   16.284519] register_console (kernel/printk/printk.c:4127) 
[   16.284521] init_netconsole (drivers/net/netconsole.c:1960) 
[   16.284522] do_one_initcall (init/main.c:1269) 
[   16.284523] do_initcall_level (init/main.c:1330) 
[   16.284524] do_initcalls (init/main.c:1344) 
[   16.284526] kernel_init_freeable (init/main.c:1583) 
[   16.284527] kernel_init (init/main.c:1471) 
[   16.284529] ret_from_fork (arch/x86/kernel/process.c:154) 
[   16.284530] ret_from_fork_asm (arch/x86/entry/entry_64.S:258) 
[   16.284530]
[   16.284531]  -> (target_list_lock){....}-{3:3} ops: 420 {
[   16.284533]     INITIAL USE at:
[   16.284534] lock_acquire (kernel/locking/lockdep.c:5868) 
[   16.284592] _raw_spin_lock_irqsave (./include/linux/spinlock_api_smp.h:110 kernel/locking/spinlock.c:162) 
[   16.284593] init_netconsole (./include/linux/list.h:169 drivers/net/netconsole.c:1944) 
[   16.284595] do_one_initcall (init/main.c:1269) 
[   16.284596] do_initcall_level (init/main.c:1330) 
[   16.284597] do_initcalls (init/main.c:1344) 
[   16.284599] kernel_init_freeable (init/main.c:1583) 
[   16.284600] kernel_init (init/main.c:1471) 
[   16.284602] ret_from_fork (arch/x86/kernel/process.c:154) 
[   16.284603] ret_from_fork_asm (arch/x86/entry/entry_64.S:258) 
[   16.284604]   }
[   16.284604] ... key at: target_list_lock (??:?) 
[   16.284606]   ... acquired at:
[   16.284606] _raw_spin_lock_irqsave (./include/linux/spinlock_api_smp.h:110 kernel/locking/spinlock.c:162) 
[   16.284607] write_ext_msg (drivers/net/netconsole.c:?) 
[   16.284609] console_flush_all (kernel/printk/printk.c:3055 kernel/printk/printk.c:3139 kernel/printk/printk.c:3226) 
[   16.284610] console_unlock (kernel/printk/printk.c:3285 kernel/printk/printk.c:3325) 
[   16.284612] vprintk_emit (kernel/printk/printk.c:?) 
[   16.284613] _printk (kernel/printk/printk.c:2478) 
[   16.284614] register_console (kernel/printk/printk.c:4127) 
[   16.284616] init_netconsole (drivers/net/netconsole.c:1960) 
[   16.284617] do_one_initcall (init/main.c:1269) 
[   16.284618] do_initcall_level (init/main.c:1330) 
[   16.284619] do_initcalls (init/main.c:1344) 
[   16.284620] kernel_init_freeable (init/main.c:1583) 
[   16.284622] kernel_init (init/main.c:1471) 
[   16.284623] ret_from_fork (arch/x86/kernel/process.c:154) 
[   16.284624] ret_from_fork_asm (arch/x86/entry/entry_64.S:258) 
[   16.284625]
[   16.284625] -> (console_owner){-...}-{0:0} ops: 2643 {
[   16.284627]    IN-HARDIRQ-W at:
[   16.284628] lock_acquire (kernel/locking/lockdep.c:5868) 
[   16.284629] console_flush_all (kernel/printk/printk.c:1924 kernel/printk/printk.c:3132 kernel/printk/printk.c:3226) 
[   16.284630] console_unlock (kernel/printk/printk.c:3285 kernel/printk/printk.c:3325) 
[   16.284631] wake_up_klogd_work_func (kernel/printk/printk.c:4529) 
[   16.284632] irq_work_run_list (kernel/irq_work.c:222 kernel/irq_work.c:252) 
[   16.284634] update_process_times (kernel/time/timer.c:2478) 
[   16.284636] tick_nohz_handler (kernel/time/tick-sched.c:187 kernel/time/tick-sched.c:306) 
[   16.284638] __hrtimer_run_queues (kernel/time/hrtimer.c:1761 kernel/time/hrtimer.c:1825) 
[   16.284639] hrtimer_interrupt (kernel/time/hrtimer.c:1890) 
[   16.284640] __sysvec_apic_timer_interrupt (./arch/x86/include/asm/jump_label.h:36 ./arch/x86/include/asm/trace/irq_vectors.h:40 arch/x86/kernel/apic/apic.c:1057) 
[   16.284642] sysvec_apic_timer_interrupt (arch/x86/kernel/apic/apic.c:1050 arch/x86/kernel/apic/apic.c:1050) 
[   16.284643] asm_sysvec_apic_timer_interrupt (./arch/x86/include/asm/idtentry.h:702) 
[   16.284644] pv_native_safe_halt (arch/x86/kernel/paravirt.c:82) 
[   16.284645] default_idle (./arch/x86/include/asm/paravirt.h:107 arch/x86/kernel/process.c:757) 
[   16.284647] default_idle_call (./include/linux/cpuidle.h:143 kernel/sched/idle.c:123) 
[   16.284648] do_idle (kernel/sched/idle.c:191 kernel/sched/idle.c:330) 
[   16.284649] cpu_startup_entry (kernel/sched/idle.c:427) 
[   16.284650] start_secondary (arch/x86/kernel/smpboot.c:315) 
[   16.284651] common_startup_64 (arch/x86/kernel/head_64.S:419) 
[   16.284653]    INITIAL USE at:
[   16.284654]  }
[   16.284654] ... key at: console_owner_dep_map (??:?) 
[   16.284842]  ... acquired at:
[   16.284843] mark_lock (kernel/locking/lockdep.c:4753) 
[   16.284844] __lock_acquire (kernel/locking/lockdep.c:? kernel/locking/lockdep.c:5191) 
[   16.284845] lock_acquire (kernel/locking/lockdep.c:5868) 
[   16.284846] console_flush_all (kernel/printk/printk.c:1924 kernel/printk/printk.c:3132 kernel/printk/printk.c:3226) 
[   16.284847] console_unlock (kernel/printk/printk.c:3285 kernel/printk/printk.c:3325) 
[   16.284849] wake_up_klogd_work_func (kernel/printk/printk.c:4529) 
[   16.284849] irq_work_run_list (kernel/irq_work.c:222 kernel/irq_work.c:252) 
[   16.284850] update_process_times (kernel/time/timer.c:2478) 
[   16.284852] tick_nohz_handler (kernel/time/tick-sched.c:187 kernel/time/tick-sched.c:306) 
[   16.284854] __hrtimer_run_queues (kernel/time/hrtimer.c:1761 kernel/time/hrtimer.c:1825) 
[   16.284854] hrtimer_interrupt (kernel/time/hrtimer.c:1890) 
[   16.284855] __sysvec_apic_timer_interrupt (./arch/x86/include/asm/jump_label.h:36 ./arch/x86/include/asm/trace/irq_vectors.h:40 arch/x86/kernel/apic/apic.c:1057) 
[   16.284856] sysvec_apic_timer_interrupt (arch/x86/kernel/apic/apic.c:1050 arch/x86/kernel/apic/apic.c:1050) 
[   16.284858] asm_sysvec_apic_timer_interrupt (./arch/x86/include/asm/idtentry.h:702) 
[   16.284858] pv_native_safe_halt (arch/x86/kernel/paravirt.c:82) 
[   16.284859] default_idle (./arch/x86/include/asm/paravirt.h:107 arch/x86/kernel/process.c:757) 
[   16.284861] default_idle_call (./include/linux/cpuidle.h:143 kernel/sched/idle.c:123) 
[   16.284862] do_idle (kernel/sched/idle.c:191 kernel/sched/idle.c:330) 
[   16.284863] cpu_startup_entry (kernel/sched/idle.c:427) 
[   16.284863] start_secondary (arch/x86/kernel/smpboot.c:315) 
[   16.284864] common_startup_64 (arch/x86/kernel/head_64.S:419) 
[   16.284866]
[   16.284866]
[   16.284866] stack backtrace:
[   16.284870] Tainted: [E]=UNSIGNED_MODULE
[   16.284871] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
[   16.284872] Call Trace:
[   16.284873]  <IRQ>
[   16.284876] dump_stack_lvl (lib/dump_stack.c:123) 
[   16.284880] print_irq_inversion_bug (kernel/locking/lockdep.c:?) 
[   16.284882] mark_lock_irq (kernel/locking/lockdep.c:?) 
[   16.284883] ? stack_trace_save (kernel/stacktrace.c:123) 
[   16.284886] mark_lock (kernel/locking/lockdep.c:4753) 
[   16.284887] __lock_acquire (kernel/locking/lockdep.c:? kernel/locking/lockdep.c:5191) 
[   16.284890] ? printk_get_next_message (kernel/printk/printk.c:3024) 
[   16.284892] ? console_flush_all (./include/linux/rcupdate.h:336 ./include/linux/srcu.h:319 kernel/printk/printk.c:288 kernel/printk/printk.c:3203) 
[   16.284894] lock_acquire (kernel/locking/lockdep.c:5868) 
[   16.284895] ? console_flush_all (./include/linux/rcupdate.h:336 ./include/linux/srcu.h:319 kernel/printk/printk.c:288 kernel/printk/printk.c:3203) 
[   16.284897] ? console_flush_all (kernel/printk/printk.c:1924 kernel/printk/printk.c:3132 kernel/printk/printk.c:3226) 
[   16.284899] ? console_flush_all (./include/linux/rcupdate.h:336 ./include/linux/srcu.h:319 kernel/printk/printk.c:288 kernel/printk/printk.c:3203) 
[   16.284900] console_flush_all (kernel/printk/printk.c:1924 kernel/printk/printk.c:3132 kernel/printk/printk.c:3226) 
[   16.284923] ? console_flush_all (./include/linux/rcupdate.h:336 ./include/linux/srcu.h:319 kernel/printk/printk.c:288 kernel/printk/printk.c:3203) 
[   16.284925] ? console_flush_all (./include/linux/rcupdate.h:336 ./include/linux/srcu.h:319 kernel/printk/printk.c:288 kernel/printk/printk.c:3203) 
[   16.284928] console_unlock (kernel/printk/printk.c:3285 kernel/printk/printk.c:3325) 
[   16.284930] wake_up_klogd_work_func (kernel/printk/printk.c:4529) 
[   16.284931] irq_work_run_list (kernel/irq_work.c:222 kernel/irq_work.c:252) 
[   16.284933] update_process_times (kernel/time/timer.c:2478) 
[   16.284935] tick_nohz_handler (kernel/time/tick-sched.c:187 kernel/time/tick-sched.c:306) 
[   16.284936] ? tick_setup_sched_timer (kernel/time/tick-sched.c:285) 
[   16.284938] __hrtimer_run_queues (kernel/time/hrtimer.c:1761 kernel/time/hrtimer.c:1825) 
[   16.284940] hrtimer_interrupt (kernel/time/hrtimer.c:1890) 
[   16.284942] __sysvec_apic_timer_interrupt (./arch/x86/include/asm/jump_label.h:36 ./arch/x86/include/asm/trace/irq_vectors.h:40 arch/x86/kernel/apic/apic.c:1057) 
[   16.284943] sysvec_apic_timer_interrupt (arch/x86/kernel/apic/apic.c:1050 arch/x86/kernel/apic/apic.c:1050) 
[   16.284945]  </IRQ>
[   16.284946]  <TASK>
[   16.284947] asm_sysvec_apic_timer_interrupt (./arch/x86/include/asm/idtentry.h:702) 
[   16.284948] RIP: 0010:pv_native_safe_halt (arch/x86/kernel/paravirt.c:82) 
[ 16.284950] Code: bd 54 01 e8 2f 00 00 00 48 2b 05 a0 8b 57 00 c3 cc cc cc cc cc cc cc f3 0f 1e fa eb 07 0f 00 2d 0d f3 05 00 f3 0f 1e fa fb f4 <c3> cc cc cc cc cc cc cc cc cc cc cc cc 66 0f 1f 00 50 8b 37 83 e6
All code
========
   0:	bd 54 01 e8 2f       	mov    $0x2fe80154,%ebp
   5:	00 00                	add    %al,(%rax)
   7:	00 48 2b             	add    %cl,0x2b(%rax)
   a:	05 a0 8b 57 00       	add    $0x578ba0,%eax
   f:	c3                   	ret    
  10:	cc                   	int3   
  11:	cc                   	int3   
  12:	cc                   	int3   
  13:	cc                   	int3   
  14:	cc                   	int3   
  15:	cc                   	int3   
  16:	cc                   	int3   
  17:	f3 0f 1e fa          	endbr64 
  1b:	eb 07                	jmp    0x24
  1d:	0f 00 2d 0d f3 05 00 	verw   0x5f30d(%rip)        # 0x5f331
  24:	f3 0f 1e fa          	endbr64 
  28:	fb                   	sti    
  29:	f4                   	hlt    
  2a:*	c3                   	ret    		<-- trapping instruction
  2b:	cc                   	int3   
  2c:	cc                   	int3   
  2d:	cc                   	int3   
  2e:	cc                   	int3   
  2f:	cc                   	int3   
  30:	cc                   	int3   
  31:	cc                   	int3   
  32:	cc                   	int3   
  33:	cc                   	int3   
  34:	cc                   	int3   
  35:	cc                   	int3   
  36:	cc                   	int3   
  37:	66 0f 1f 00          	nopw   (%rax)
  3b:	50                   	push   %rax
  3c:	8b 37                	mov    (%rdi),%esi
  3e:	83                   	.byte 0x83
  3f:	e6                   	.byte 0xe6

Code starting with the faulting instruction
===========================================
   0:	c3                   	ret    
   1:	cc                   	int3   
   2:	cc                   	int3   
   3:	cc                   	int3   
   4:	cc                   	int3   
   5:	cc                   	int3   
   6:	cc                   	int3   
   7:	cc                   	int3   
   8:	cc                   	int3   
   9:	cc                   	int3   
   a:	cc                   	int3   
   b:	cc                   	int3   
   c:	cc                   	int3   
   d:	66 0f 1f 00          	nopw   (%rax)
  11:	50                   	push   %rax
  12:	8b 37                	mov    (%rdi),%esi
  14:	83                   	.byte 0x83
  15:	e6                   	.byte 0xe6
[   16.284952] RSP: 0018:ffa000000012bed8 EFLAGS: 00000282
[   16.284953] RAX: af64f61648e76300 RBX: ffffffff813cd1f0 RCX: 4000000000000000
[   16.284954] RDX: 0000000000000001 RSI: ffffffff81fd2a36 RDI: ffffffff813cd1f0
[   16.284955] RBP: ffa000000012bef8 R08: 0000000000060000 R09: 0000000000000001
[   16.284956] R10: 0000000000000001 R11: 00000000fffeff01 R12: 0000000000000000
[   16.284956] R13: 0000000000000000 R14: 0000000000000010 R15: 0000000000000000
[   16.284958] ? do_idle (kernel/sched/idle.c:191 kernel/sched/idle.c:330) 
[   16.284959] ? default_idle_call (./include/linux/cpuidle.h:132 kernel/sched/idle.c:121) 
[   16.284960] ? do_idle (kernel/sched/idle.c:191 kernel/sched/idle.c:330) 
[   16.284962] ? do_idle (kernel/sched/idle.c:191 kernel/sched/idle.c:330) 
[   16.284962] default_idle (./arch/x86/include/asm/paravirt.h:107 arch/x86/kernel/process.c:757) 
[   16.284964] default_idle_call (./include/linux/cpuidle.h:143 kernel/sched/idle.c:123) 
[   16.284965] do_idle (kernel/sched/idle.c:191 kernel/sched/idle.c:330) 
[   16.284967] cpu_startup_entry (kernel/sched/idle.c:427) 
[   16.284968] start_secondary (arch/x86/kernel/smpboot.c:315) 
[   16.284969] common_startup_64 (arch/x86/kernel/head_64.S:419) 
[   16.284972]  </TASK>


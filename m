Return-Path: <netdev+bounces-37597-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F24B57B641B
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 10:30:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 2087D2816F4
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 08:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E61C54C6E;
	Tue,  3 Oct 2023 08:30:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC706DDA9;
	Tue,  3 Oct 2023 08:30:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1C54BC433C9;
	Tue,  3 Oct 2023 08:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696321825;
	bh=DqRTB6arV11tq5ZIytFbJxUjjbeix/wfn7i4t+l11Cg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=p7IUAPU2YHbAMKR0K3Vf1aCaHUY9pde7eYsnNi5S5FlqxF8YnylAuw+7a2VKIg4pJ
	 XllXNGTvvGmP636faPxUKd96GfuMvhYZmFdttYuiCBQqlU8wP+bbvgaMsj+5IZtYAn
	 QbJfDtq/z8qnYgkISTqB4SWVJw5gQG8sqcUKa3choBF5Y2h9xmWRrgWuXs7djL9sp0
	 lqbvPvM9TQouOKZhecCV6O/6OegexeXhWLE/WP2u34aMS0nXQt9ByqpdSVDIA7y63Y
	 iTr3mEvgkxLxrvc8vEo/P5bkajFx3FSPqH4LMwRabmiBm4moDXp1rDmUltSg+wTGWm
	 y5V8oHOJEWI/A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F3F6FE632D8;
	Tue,  3 Oct 2023 08:30:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: usb: smsc75xx: Fix uninit-value access in
 __smsc75xx_read_reg
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169632182499.2138.3290447743580809288.git-patchwork-notify@kernel.org>
Date: Tue, 03 Oct 2023 08:30:24 +0000
References: <20230923173549.3284502-1-syoshida@redhat.com>
In-Reply-To: <20230923173549.3284502-1-syoshida@redhat.com>
To: Shigeru Yoshida <syoshida@redhat.com>
Cc: steve.glendinning@shawell.net, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzbot+6966546b78d050bb0b5d@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sun, 24 Sep 2023 02:35:49 +0900 you wrote:
> syzbot reported the following uninit-value access issue:
> 
> =====================================================
> BUG: KMSAN: uninit-value in smsc75xx_wait_ready drivers/net/usb/smsc75xx.c:975 [inline]
> BUG: KMSAN: uninit-value in smsc75xx_bind+0x5c9/0x11e0 drivers/net/usb/smsc75xx.c:1482
> CPU: 0 PID: 8696 Comm: kworker/0:3 Not tainted 5.8.0-rc5-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Workqueue: usb_hub_wq hub_event
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x21c/0x280 lib/dump_stack.c:118
>  kmsan_report+0xf7/0x1e0 mm/kmsan/kmsan_report.c:121
>  __msan_warning+0x58/0xa0 mm/kmsan/kmsan_instr.c:215
>  smsc75xx_wait_ready drivers/net/usb/smsc75xx.c:975 [inline]
>  smsc75xx_bind+0x5c9/0x11e0 drivers/net/usb/smsc75xx.c:1482
>  usbnet_probe+0x1152/0x3f90 drivers/net/usb/usbnet.c:1737
>  usb_probe_interface+0xece/0x1550 drivers/usb/core/driver.c:374
>  really_probe+0xf20/0x20b0 drivers/base/dd.c:529
>  driver_probe_device+0x293/0x390 drivers/base/dd.c:701
>  __device_attach_driver+0x63f/0x830 drivers/base/dd.c:807
>  bus_for_each_drv+0x2ca/0x3f0 drivers/base/bus.c:431
>  __device_attach+0x4e2/0x7f0 drivers/base/dd.c:873
>  device_initial_probe+0x4a/0x60 drivers/base/dd.c:920
>  bus_probe_device+0x177/0x3d0 drivers/base/bus.c:491
>  device_add+0x3b0e/0x40d0 drivers/base/core.c:2680
>  usb_set_configuration+0x380f/0x3f10 drivers/usb/core/message.c:2032
>  usb_generic_driver_probe+0x138/0x300 drivers/usb/core/generic.c:241
>  usb_probe_device+0x311/0x490 drivers/usb/core/driver.c:272
>  really_probe+0xf20/0x20b0 drivers/base/dd.c:529
>  driver_probe_device+0x293/0x390 drivers/base/dd.c:701
>  __device_attach_driver+0x63f/0x830 drivers/base/dd.c:807
>  bus_for_each_drv+0x2ca/0x3f0 drivers/base/bus.c:431
>  __device_attach+0x4e2/0x7f0 drivers/base/dd.c:873
>  device_initial_probe+0x4a/0x60 drivers/base/dd.c:920
>  bus_probe_device+0x177/0x3d0 drivers/base/bus.c:491
>  device_add+0x3b0e/0x40d0 drivers/base/core.c:2680
>  usb_new_device+0x1bd4/0x2a30 drivers/usb/core/hub.c:2554
>  hub_port_connect drivers/usb/core/hub.c:5208 [inline]
>  hub_port_connect_change drivers/usb/core/hub.c:5348 [inline]
>  port_event drivers/usb/core/hub.c:5494 [inline]
>  hub_event+0x5e7b/0x8a70 drivers/usb/core/hub.c:5576
>  process_one_work+0x1688/0x2140 kernel/workqueue.c:2269
>  worker_thread+0x10bc/0x2730 kernel/workqueue.c:2415
>  kthread+0x551/0x590 kernel/kthread.c:292
>  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:293
> 
> [...]

Here is the summary with links:
  - net: usb: smsc75xx: Fix uninit-value access in __smsc75xx_read_reg
    https://git.kernel.org/netdev/net/c/e9c65989920f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




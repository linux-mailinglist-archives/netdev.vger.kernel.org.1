Return-Path: <netdev+bounces-43279-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 576EA7D22AC
	for <lists+netdev@lfdr.de>; Sun, 22 Oct 2023 12:40:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1D0CB20DAA
	for <lists+netdev@lfdr.de>; Sun, 22 Oct 2023 10:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86CC66AAE;
	Sun, 22 Oct 2023 10:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OrB1dyuz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504C417DB;
	Sun, 22 Oct 2023 10:40:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CE2ABC433C7;
	Sun, 22 Oct 2023 10:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697971223;
	bh=AmxucS0I6jpezYSp6CUJ8OIsJn2NqODuFduq57nFTjw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OrB1dyuzfdbJ/7oZW/qkEYhUCM01qzeJMC0F+gFPLAjZJqlvN1mGGAq0gmOQBp4m5
	 RVC/bcn4oJWuzKy4tm3BAiqVAU9STic0TZ8dyrkC5Mg6qWeIhGtkT18IhvH1Ojr/4g
	 dP0ic1nRnHyeGv+QxAs9E7TEf2VAb/kFWOvQne/rMRDCtANrMNj+aD5gmdDWUiSwIU
	 YqDEXGe6Tp7mxF39hHX0FJAwdMR0ApMCZL/+qY8ZPiytbLK8WfVW5trlE8R3vdbSWI
	 j0g9A/yG445tMPWGRX7U+bZWAJ3JkaMma1HXHgubfX7IXzWxufhqoDXfMTpE8Bt9y/
	 WY6E/WysvL21g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B0E3AC691E1;
	Sun, 22 Oct 2023 10:40:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: usb: smsc95xx: Fix uninit-value access in
 smsc95xx_read_reg
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169797122372.373.6344765542608925929.git-patchwork-notify@kernel.org>
Date: Sun, 22 Oct 2023 10:40:23 +0000
References: <20231020170344.2450248-1-syoshida@redhat.com>
In-Reply-To: <20231020170344.2450248-1-syoshida@redhat.com>
To: Shigeru Yoshida <syoshida@redhat.com>
Cc: steve.glendinning@shawell.net, UNGLinuxDriver@microchip.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 syzbot+c74c24b43c9ae534f0e0@syzkaller.appspotmail.com,
 syzbot+2c97a98a5ba9ea9c23bd@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Sat, 21 Oct 2023 02:03:44 +0900 you wrote:
> syzbot reported the following uninit-value access issue [1]:
> 
> smsc95xx 1-1:0.0 (unnamed net_device) (uninitialized): Failed to read reg index 0x00000030: -32
> smsc95xx 1-1:0.0 (unnamed net_device) (uninitialized): Error reading E2P_CMD
> =====================================================
> BUG: KMSAN: uninit-value in smsc95xx_reset+0x409/0x25f0 drivers/net/usb/smsc95xx.c:896
>  smsc95xx_reset+0x409/0x25f0 drivers/net/usb/smsc95xx.c:896
>  smsc95xx_bind+0x9bc/0x22e0 drivers/net/usb/smsc95xx.c:1131
>  usbnet_probe+0x100b/0x4060 drivers/net/usb/usbnet.c:1750
>  usb_probe_interface+0xc75/0x1210 drivers/usb/core/driver.c:396
>  really_probe+0x506/0xf40 drivers/base/dd.c:658
>  __driver_probe_device+0x2a7/0x5d0 drivers/base/dd.c:800
>  driver_probe_device+0x72/0x7b0 drivers/base/dd.c:830
>  __device_attach_driver+0x55a/0x8f0 drivers/base/dd.c:958
>  bus_for_each_drv+0x3ff/0x620 drivers/base/bus.c:457
>  __device_attach+0x3bd/0x640 drivers/base/dd.c:1030
>  device_initial_probe+0x32/0x40 drivers/base/dd.c:1079
>  bus_probe_device+0x3d8/0x5a0 drivers/base/bus.c:532
>  device_add+0x16ae/0x1f20 drivers/base/core.c:3622
>  usb_set_configuration+0x31c9/0x38c0 drivers/usb/core/message.c:2207
>  usb_generic_driver_probe+0x109/0x2a0 drivers/usb/core/generic.c:238
>  usb_probe_device+0x290/0x4a0 drivers/usb/core/driver.c:293
>  really_probe+0x506/0xf40 drivers/base/dd.c:658
>  __driver_probe_device+0x2a7/0x5d0 drivers/base/dd.c:800
>  driver_probe_device+0x72/0x7b0 drivers/base/dd.c:830
>  __device_attach_driver+0x55a/0x8f0 drivers/base/dd.c:958
>  bus_for_each_drv+0x3ff/0x620 drivers/base/bus.c:457
>  __device_attach+0x3bd/0x640 drivers/base/dd.c:1030
>  device_initial_probe+0x32/0x40 drivers/base/dd.c:1079
>  bus_probe_device+0x3d8/0x5a0 drivers/base/bus.c:532
>  device_add+0x16ae/0x1f20 drivers/base/core.c:3622
>  usb_new_device+0x15f6/0x22f0 drivers/usb/core/hub.c:2589
>  hub_port_connect drivers/usb/core/hub.c:5440 [inline]
>  hub_port_connect_change drivers/usb/core/hub.c:5580 [inline]
>  port_event drivers/usb/core/hub.c:5740 [inline]
>  hub_event+0x53bc/0x7290 drivers/usb/core/hub.c:5822
>  process_one_work kernel/workqueue.c:2630 [inline]
>  process_scheduled_works+0x104e/0x1e70 kernel/workqueue.c:2703
>  worker_thread+0xf45/0x1490 kernel/workqueue.c:2784
>  kthread+0x3e8/0x540 kernel/kthread.c:388
>  ret_from_fork+0x66/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
> 
> [...]

Here is the summary with links:
  - [net] net: usb: smsc95xx: Fix uninit-value access in smsc95xx_read_reg
    https://git.kernel.org/netdev/net/c/51a32e828109

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




Return-Path: <netdev+bounces-219978-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C35A7B43FCC
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 17:00:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 575DD1C8339B
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 15:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7D22308F3B;
	Thu,  4 Sep 2025 15:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EOxnHtRn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF27E308F02;
	Thu,  4 Sep 2025 15:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756998002; cv=none; b=DJ9+G8UObxPKL1Gg45vno1zwIDrvRh+wfOXvIh00hJ5rgwYY7cO27b7kI1vsyZ6aZiPwnKIFxAkIIVU1Qpbh6qOzHINEzItECpQ3iLXsXpFUjRDKwbmgpx0LU1zQNcohaABltTSPge5poeWhe/eq84jhzyji8GFa3UB7oVGbf50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756998002; c=relaxed/simple;
	bh=Vs7lM8ERt2pnPObodvSUMf49Kpxy9DaQ+gHrWZwmaLk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rIN5Re/fga/BJqmF2i0Q5gV8ZfcGcdDtkM3P45XfQOd6AYYWjM9fGTGBZ9a/sIocv62XcQjjTBUGDHdMjYhDO6Y7EQlwy8b+KQCHzQI65gB5fezB6zre/qfUCpdcHYySPlkLqAG77r0ldHnXYZedMF5YqKhmok79STOZI/gp1YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EOxnHtRn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 437FCC4CEF0;
	Thu,  4 Sep 2025 15:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756998002;
	bh=Vs7lM8ERt2pnPObodvSUMf49Kpxy9DaQ+gHrWZwmaLk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EOxnHtRnlF1XG5NJNypFOZxr9hvtbuR41wYsJAOtmqEQ1dqElJyVR5psyhmfhGGBg
	 jhk9RjekDZCOel92aP6hlmKEFmXRFcF/0+kl/Tv1D6yEkObjwpeh2GiCytHuqbToy+
	 hcqRhV+efzdWlyTQcYq3q/gKQQq2hRAbhC6vJ5oZmcRQqfQe3YKs4ufIya68DQ15Zn
	 MJ7/gghUzBr/aJG7YMfuDj5qMng/v1GlzlzsKm2Sn4iFWGmJGECJVatGj1uvKYOeVx
	 P9d4US3UAXIZY2oKKXTELYwxRal05o2WGuUI9DcQBVviXTH8oTyVsTleOTsIVfdCp/
	 7p2Vuns2hbIhw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33FC9383BF69;
	Thu,  4 Sep 2025 15:00:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] phy: mscc: Stop taking ts_lock for tx_queue and
 use
 its own lock
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175699800703.1841048.13423131207405228132.git-patchwork-notify@kernel.org>
Date: Thu, 04 Sep 2025 15:00:07 +0000
References: <20250902121259.3257536-1-horatiu.vultur@microchip.com>
In-Reply-To: <20250902121259.3257536-1-horatiu.vultur@microchip.com>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 richardcochran@gmail.com, vadim.fedorenko@linux.dev, vladimir.oltean@nxp.com,
 viro@zeniv.linux.org.uk, quentin.schulz@bootlin.com, atenart@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 2 Sep 2025 14:12:59 +0200 you wrote:
> When transmitting a PTP frame which is timestamp using 2 step, the
> following warning appears if CONFIG_PROVE_LOCKING is enabled:
> =============================
> [ BUG: Invalid wait context ]
> 6.17.0-rc1-00326-ge6160462704e #427 Not tainted
> -----------------------------
> ptp4l/119 is trying to lock:
> c2a44ed4 (&vsc8531->ts_lock){+.+.}-{3:3}, at: vsc85xx_txtstamp+0x50/0xac
> other info that might help us debug this:
> context-{4:4}
> 4 locks held by ptp4l/119:
>  #0: c145f068 (rcu_read_lock_bh){....}-{1:2}, at: __dev_queue_xmit+0x58/0x1440
>  #1: c29df974 (dev->qdisc_tx_busylock ?: &qdisc_tx_busylock){+...}-{2:2}, at: __dev_queue_xmit+0x5c4/0x1440
>  #2: c2aaaad0 (_xmit_ETHER#2){+.-.}-{2:2}, at: sch_direct_xmit+0x108/0x350
>  #3: c2aac170 (&lan966x->tx_lock){+.-.}-{2:2}, at: lan966x_port_xmit+0xd0/0x350
> stack backtrace:
> CPU: 0 UID: 0 PID: 119 Comm: ptp4l Not tainted 6.17.0-rc1-00326-ge6160462704e #427 NONE
> Hardware name: Generic DT based system
> Call trace:
>  unwind_backtrace from show_stack+0x10/0x14
>  show_stack from dump_stack_lvl+0x7c/0xac
>  dump_stack_lvl from __lock_acquire+0x8e8/0x29dc
>  __lock_acquire from lock_acquire+0x108/0x38c
>  lock_acquire from __mutex_lock+0xb0/0xe78
>  __mutex_lock from mutex_lock_nested+0x1c/0x24
>  mutex_lock_nested from vsc85xx_txtstamp+0x50/0xac
>  vsc85xx_txtstamp from lan966x_fdma_xmit+0xd8/0x3a8
>  lan966x_fdma_xmit from lan966x_port_xmit+0x1bc/0x350
>  lan966x_port_xmit from dev_hard_start_xmit+0xc8/0x2c0
>  dev_hard_start_xmit from sch_direct_xmit+0x8c/0x350
>  sch_direct_xmit from __dev_queue_xmit+0x680/0x1440
>  __dev_queue_xmit from packet_sendmsg+0xfa4/0x1568
>  packet_sendmsg from __sys_sendto+0x110/0x19c
>  __sys_sendto from sys_send+0x18/0x20
>  sys_send from ret_fast_syscall+0x0/0x1c
> Exception stack(0xf0b05fa8 to 0xf0b05ff0)
> 5fa0:                   00000001 0000000e 0000000e 0004b47a 0000003a 00000000
> 5fc0: 00000001 0000000e 00000000 00000121 0004af58 00044874 00000000 00000000
> 5fe0: 00000001 bee9d420 00025a10 b6e75c7c
> 
> [...]

Here is the summary with links:
  - [net,v3] phy: mscc: Stop taking ts_lock for tx_queue and use its own lock
    https://git.kernel.org/netdev/net/c/9b2bfdbf43ad

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




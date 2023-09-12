Return-Path: <netdev+bounces-33242-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DAA3D79D1F7
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 15:20:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95150281F13
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 13:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1C911803D;
	Tue, 12 Sep 2023 13:20:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E1E8C18
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 13:20:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7E95BC433C9;
	Tue, 12 Sep 2023 13:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694524825;
	bh=ifkOKxbXD5+s1MxmPdP70sSy7gLlcMrD2UXr9jXJRtY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=goIjyzndEet7yknzXxDWwSKuL2DHHkfpr/xS7Ll8ShEJMFY93IAXdiGiOgKkHguZS
	 3goo6MWoHlui7LYPVHLnf8EUCV6+9fzk9KcVVPHp+GO8iP39kz87dxBP3IFKHK/2GF
	 DlKvTpRqEXMev9DPz0+qX9vIkyV3tgul+lbsIuQQ30A6a9oGxvkPHzzrTPGVsFkVp/
	 He1eHxDlKBhWutJf+sO8QGojcEIxc3JHAFZi9TE/t26gcLdDR4CCHfFTkgp4HjDB2S
	 AHTYsyBVJCgwefJm2XS+sIs6qbqGAgkAL2Si567JBPX8Q8l90EwCm/PMPNmIN4hqNz
	 jtJ17xf7x9fXA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 66E07E1C282;
	Tue, 12 Sep 2023 13:20:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: macb: fix sleep inside spinlock
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169452482541.2220.8817186054224273802.git-patchwork-notify@kernel.org>
Date: Tue, 12 Sep 2023 13:20:25 +0000
References: <20230908112913.1701766-1-s.hauer@pengutronix.de>
In-Reply-To: <20230908112913.1701766-1-s.hauer@pengutronix.de>
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: netdev@vger.kernel.org, linux@armlinux.org.uk,
 linux-kernel@vger.kernel.org, nicolas.ferre@microchip.com,
 claudiu.beznea@tuxon.dev, kernel@pengutronix.de

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri,  8 Sep 2023 13:29:13 +0200 you wrote:
> macb_set_tx_clk() is called under a spinlock but itself calls clk_set_rate()
> which can sleep. This results in:
> 
> | BUG: sleeping function called from invalid context at kernel/locking/mutex.c:580
> | pps pps1: new PPS source ptp1
> | in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 40, name: kworker/u4:3
> | preempt_count: 1, expected: 0
> | RCU nest depth: 0, expected: 0
> | 4 locks held by kworker/u4:3/40:
> |  #0: ffff000003409148
> | macb ff0c0000.ethernet: gem-ptp-timer ptp clock registered.
> |  ((wq_completion)events_power_efficient){+.+.}-{0:0}, at: process_one_work+0x14c/0x51c
> |  #1: ffff8000833cbdd8 ((work_completion)(&pl->resolve)){+.+.}-{0:0}, at: process_one_work+0x14c/0x51c
> |  #2: ffff000004f01578 (&pl->state_mutex){+.+.}-{4:4}, at: phylink_resolve+0x44/0x4e8
> |  #3: ffff000004f06f50 (&bp->lock){....}-{3:3}, at: macb_mac_link_up+0x40/0x2ac
> | irq event stamp: 113998
> | hardirqs last  enabled at (113997): [<ffff800080e8503c>] _raw_spin_unlock_irq+0x30/0x64
> | hardirqs last disabled at (113998): [<ffff800080e84478>] _raw_spin_lock_irqsave+0xac/0xc8
> | softirqs last  enabled at (113608): [<ffff800080010630>] __do_softirq+0x430/0x4e4
> | softirqs last disabled at (113597): [<ffff80008001614c>] ____do_softirq+0x10/0x1c
> | CPU: 0 PID: 40 Comm: kworker/u4:3 Not tainted 6.5.0-11717-g9355ce8b2f50-dirty #368
> | Hardware name: ... ZynqMP ... (DT)
> | Workqueue: events_power_efficient phylink_resolve
> | Call trace:
> |  dump_backtrace+0x98/0xf0
> |  show_stack+0x18/0x24
> |  dump_stack_lvl+0x60/0xac
> |  dump_stack+0x18/0x24
> |  __might_resched+0x144/0x24c
> |  __might_sleep+0x48/0x98
> |  __mutex_lock+0x58/0x7b0
> |  mutex_lock_nested+0x24/0x30
> |  clk_prepare_lock+0x4c/0xa8
> |  clk_set_rate+0x24/0x8c
> |  macb_mac_link_up+0x25c/0x2ac
> |  phylink_resolve+0x178/0x4e8
> |  process_one_work+0x1ec/0x51c
> |  worker_thread+0x1ec/0x3e4
> |  kthread+0x120/0x124
> |  ret_from_fork+0x10/0x20
> 
> [...]

Here is the summary with links:
  - net: macb: fix sleep inside spinlock
    https://git.kernel.org/netdev/net/c/403f0e771457

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




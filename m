Return-Path: <netdev+bounces-108657-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DBC11924D65
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 04:00:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98C45284D43
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 02:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9C401C2E;
	Wed,  3 Jul 2024 02:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jsZVXGri"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A117F1FAA;
	Wed,  3 Jul 2024 02:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719972034; cv=none; b=W1t7siR5uUm3OCf1Ta++YJvBRoX5iHsTTHweH7TcQij41PeLbvyYvrWv2CqmnO8XZIYAfWXX4IL0pwjpeq0NluPTovS9PYjfSnChrdgt25l+SDQTbMGyeCNaVlI3MvEkzIebXdk8KTVIzqm4JodS1ObZaN/14ERz/C3qlWs2iHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719972034; c=relaxed/simple;
	bh=ddoWIzMvun+BiAae8QNh2KY6WQqqmwq7hCuAmlJwRvo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kHgFeeOfW6uqvyFZhNScxLKHL+TGSPrxvr6MskPLi0eZPvdWyGXgRmgdXQrS3UurztldxSJIwnuL0Uw0IB4SpTf5dw7dlQcLCuwsTGp5blvhaDTqQKpuhNxrChn6N14hFVlozqi51GbRHUbnaEr4k37ObEDNpf7SJFqNRfx8h5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jsZVXGri; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4B71AC4AF0A;
	Wed,  3 Jul 2024 02:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719972034;
	bh=ddoWIzMvun+BiAae8QNh2KY6WQqqmwq7hCuAmlJwRvo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jsZVXGriUXLqQVjuFYpI9QcX6hWXb7/UY4KSCr6VdQHERPLqpzcEyxKx85c3y2IKL
	 Ad+nMrBGEpT4M1AVeuvPxE/y6jcDv/k2u+OVQmT6pB1Ije3rGF6G2p6nDIwj6qHeXX
	 0JbET8ufHK5Fx4jSjlbAzGGnUnC8p2Ayh/Q88fuKMvOnRI0jefxLQeXb6OKMMfsEVr
	 aPg6GPAH6rfPBxYECA5bNdRpeheEI6G8j+xOQqxiSXei9CAPnJjDxqRswuFwZPmumK
	 +ZS4ULbCO8YRXkAEi0pxSdD9LB3ShosaqLBBpL7RLcE07ejexp5zGzgC+WHBCelLmx
	 WvLuc0W6iIDGQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 35FE1C43331;
	Wed,  3 Jul 2024 02:00:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] net: ntb_netdev: Move ntb_netdev_rx_handler() to call
 netif_rx() from __netif_rx()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171997203421.32241.9722125326402444129.git-patchwork-notify@kernel.org>
Date: Wed, 03 Jul 2024 02:00:34 +0000
References: <20240701181538.3799546-1-dave.jiang@intel.com>
In-Reply-To: <20240701181538.3799546-1-dave.jiang@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: ntb@lists.linux.dev, netdev@vger.kernel.org, jdmason@kudzu.us,
 allenbh@gmail.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 abeni@redhat.com, jerry.dai@intel.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  1 Jul 2024 11:15:38 -0700 you wrote:
> The following is emitted when using idxd (DSA) dmanegine as the data
> mover for ntb_transport that ntb_netdev uses.
> 
> [74412.546922] BUG: using smp_processor_id() in preemptible [00000000] code: irq/52-idxd-por/14526
> [74412.556784] caller is netif_rx_internal+0x42/0x130
> [74412.562282] CPU: 6 PID: 14526 Comm: irq/52-idxd-por Not tainted 6.9.5 #5
> [74412.569870] Hardware name: Intel Corporation ArcherCity/ArcherCity, BIOS EGSDCRB1.E9I.1752.P05.2402080856 02/08/2024
> [74412.581699] Call Trace:
> [74412.584514]  <TASK>
> [74412.586933]  dump_stack_lvl+0x55/0x70
> [74412.591129]  check_preemption_disabled+0xc8/0xf0
> [74412.596374]  netif_rx_internal+0x42/0x130
> [74412.600957]  __netif_rx+0x20/0xd0
> [74412.604743]  ntb_netdev_rx_handler+0x66/0x150 [ntb_netdev]
> [74412.610985]  ntb_complete_rxc+0xed/0x140 [ntb_transport]
> [74412.617010]  ntb_rx_copy_callback+0x53/0x80 [ntb_transport]
> [74412.623332]  idxd_dma_complete_txd+0xe3/0x160 [idxd]
> [74412.628963]  idxd_wq_thread+0x1a6/0x2b0 [idxd]
> [74412.634046]  irq_thread_fn+0x21/0x60
> [74412.638134]  ? irq_thread+0xa8/0x290
> [74412.642218]  irq_thread+0x1a0/0x290
> [74412.646212]  ? __pfx_irq_thread_fn+0x10/0x10
> [74412.651071]  ? __pfx_irq_thread_dtor+0x10/0x10
> [74412.656117]  ? __pfx_irq_thread+0x10/0x10
> [74412.660686]  kthread+0x100/0x130
> [74412.664384]  ? __pfx_kthread+0x10/0x10
> [74412.668639]  ret_from_fork+0x31/0x50
> [74412.672716]  ? __pfx_kthread+0x10/0x10
> [74412.676978]  ret_from_fork_asm+0x1a/0x30
> [74412.681457]  </TASK>
> 
> [...]

Here is the summary with links:
  - [v2] net: ntb_netdev: Move ntb_netdev_rx_handler() to call netif_rx() from __netif_rx()
    https://git.kernel.org/netdev/net/c/e15a5d821e51

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




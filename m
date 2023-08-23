Return-Path: <netdev+bounces-29830-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D190D784DD4
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 02:31:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D2A11C20BDF
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 00:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69AF220EE9;
	Wed, 23 Aug 2023 00:30:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403339479
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 00:30:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B9819C433CC;
	Wed, 23 Aug 2023 00:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692750624;
	bh=EcAZR6QDskBDosOSp85CYXFx7tFqoFe2r4mS5W/njWc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=aoeD9XQMebrpLTLkr1rpIxMVLCAZeVRnGf07xTS7YzZmr/SB4Fjl4HXZvXpXUNlrB
	 JPeBfiZB6MID1XBoraWYtMAQnVgn7v8rIUpzZ/Ikgdc4ggYJvnqLqw+wqgzBtrdc8b
	 lq1p2LOTAVFy0jgfg/pHIraKp6Sk3k8Jbjec6DELPKTcDqdV3zK0jF9yzz5tfpfs1t
	 CIRigpQCu2J4n9lGkQCrvr0yiMDNmslclyp6gFd5tISqIxgLjfzYFzRvFO60igWSNd
	 g4P2pufajmigR61MVqksB1oy532JlJQFKNDBBGLh24SZmOK29gxUETsqHca1bfbWDS
	 80h3hdjoWfeUw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A19CEE21EE4;
	Wed, 23 Aug 2023 00:30:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] igb: Avoid starting unnecessary workqueues
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169275062465.22438.14336724713470936708.git-patchwork-notify@kernel.org>
Date: Wed, 23 Aug 2023 00:30:24 +0000
References: <20230821171927.2203644-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20230821171927.2203644-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, alessio.bogani@elettra.eu,
 richardcochran@gmail.com, leon@kernel.org, rrameshbabu@nvidia.com,
 arpanax.arland@intel.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 21 Aug 2023 10:19:27 -0700 you wrote:
> From: Alessio Igor Bogani <alessio.bogani@elettra.eu>
> 
> If ptp_clock_register() fails or CONFIG_PTP isn't enabled, avoid starting
> PTP related workqueues.
> 
> In this way we can fix this:
>  BUG: unable to handle page fault for address: ffffc9000440b6f8
>  #PF: supervisor read access in kernel mode
>  #PF: error_code(0x0000) - not-present page
>  PGD 100000067 P4D 100000067 PUD 1001e0067 PMD 107dc5067 PTE 0
>  Oops: 0000 [#1] PREEMPT SMP
>  [...]
>  Workqueue: events igb_ptp_overflow_check
>  RIP: 0010:igb_rd32+0x1f/0x60
>  [...]
>  Call Trace:
>   igb_ptp_read_82580+0x20/0x50
>   timecounter_read+0x15/0x60
>   igb_ptp_overflow_check+0x1a/0x50
>   process_one_work+0x1cb/0x3c0
>   worker_thread+0x53/0x3f0
>   ? rescuer_thread+0x370/0x370
>   kthread+0x142/0x160
>   ? kthread_associate_blkcg+0xc0/0xc0
>   ret_from_fork+0x1f/0x30
> 
> [...]

Here is the summary with links:
  - [net] igb: Avoid starting unnecessary workqueues
    https://git.kernel.org/netdev/net/c/b888c510f7b3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




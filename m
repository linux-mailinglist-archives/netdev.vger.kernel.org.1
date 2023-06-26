Return-Path: <netdev+bounces-13889-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F08DE73D9BA
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 10:30:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E40C1C203D7
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 08:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C4833D71;
	Mon, 26 Jun 2023 08:30:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C375463C6
	for <netdev@vger.kernel.org>; Mon, 26 Jun 2023 08:30:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2873EC433C9;
	Mon, 26 Jun 2023 08:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687768221;
	bh=ccAiWs/3eraEQ/FmXZXpVZO9iT8nSRGXDpQBX/qRUU4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Bpl8M0O9ifNOuVb7Q6WwK74SYmRYfGYcU9i1FDUHvSI3uY9yY2qTLs4kWLnVkUx/T
	 VnKK+DXCHpDpvD2h+8EcZCmprIUOf9lmdsIumqlcF8Qvs1qMA60V5ScVMlj7ELVwWf
	 YkC2wQRjSCik98Pz9nQbtxxGW3zXniaNhIVSYjxxjys6s1qvzp+nUQ92Fa12UcwsrQ
	 AKgB//HhQ3XZz6XucaEi/XMrGY8oReKkWixTHBjuFkitV/A1ZkoPmkiwedvU0q0ZzM
	 5XTvx8R4qubGf6a1lUTnaUdqJEuQOkq9iL4bLirM+Zc4NcUe48LFYxFtKQwJI7qppg
	 EDZqqUAqIgMmw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 07B9EC4167B;
	Mon, 26 Jun 2023 08:30:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] sfc: fix crash when reading stats while NIC is resetting
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168776822102.25852.12583740452998430617.git-patchwork-notify@kernel.org>
Date: Mon, 26 Jun 2023 08:30:21 +0000
References: <20230623143448.47159-1-edward.cree@amd.com>
In-Reply-To: <20230623143448.47159-1-edward.cree@amd.com>
To:  <edward.cree@amd.com>
Cc: linux-net-drivers@amd.com, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, ecree.xilinx@gmail.com,
 netdev@vger.kernel.org, habetsm.xilinx@gmail.com,
 pieter.jansen-van-vuuren@amd.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 23 Jun 2023 15:34:48 +0100 you wrote:
> From: Edward Cree <ecree.xilinx@gmail.com>
> 
> efx_net_stats() (.ndo_get_stats64) can be called during an ethtool
>  selftest, during which time nic_data->mc_stats is NULL as the NIC has
>  been fini'd.  In this case do not attempt to fetch the latest stats
>  from the hardware, else we will crash on a NULL dereference:
>     BUG: kernel NULL pointer dereference, address: 0000000000000038
>     RIP efx_nic_update_stats
>     abridged calltrace:
>     efx_ef10_update_stats_pf
>     efx_net_stats
>     dev_get_stats
>     dev_seq_printf_stats
> Skipping the read is safe, we will simply give out stale stats.
> To ensure that the free in efx_ef10_fini_nic() does not race against
>  efx_ef10_update_stats_pf(), which could cause a TOCTTOU bug, take the
>  efx->stats_lock in fini_nic (it is already held across update_stats).
> 
> [...]

Here is the summary with links:
  - [net] sfc: fix crash when reading stats while NIC is resetting
    https://git.kernel.org/netdev/net/c/d1b355438b83

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




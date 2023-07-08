Return-Path: <netdev+bounces-16209-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7869A74BD03
	for <lists+netdev@lfdr.de>; Sat,  8 Jul 2023 11:13:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF9A21C20F6E
	for <lists+netdev@lfdr.de>; Sat,  8 Jul 2023 09:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E616E5399;
	Sat,  8 Jul 2023 09:13:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60FA84400
	for <netdev@vger.kernel.org>; Sat,  8 Jul 2023 09:13:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E0D4BC433C8;
	Sat,  8 Jul 2023 09:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688807594;
	bh=gZ9P9HDCtxRjAzBYTf7BRfWoRBysv6t42m/DuwfR6WE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uvh47qIzI7FyV94ifOmYyErQaDHWoQPHlvwyVD8vT8WrYFzky64DNYRiBPXnTB3J9
	 HBfFb+vnBp2pyQA7Y59YIb+zERcKI1OpCXyLbT12MW2olzV6ebTAatC00dtbAAymfF
	 iS3G71b2PAUkUKFhm1bOXkMj+ylTk4oZ0HNpbXobWJmdKY8pN/Ama6DwchtqJKxv4V
	 T8Fh0gFnw51m12r9cKeTltU5oqe4sBs8ciKEg+9kFQ3orWNYa1f8Q+StwPzL3rHnsP
	 70jsk39suRbLXV1kagKOZPC+23JyGTZY5KNvZZZOb8M39CI815u5086rjB5g7roWgb
	 SqrB1/PurDZ5A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C4B7EC73FEA;
	Sat,  8 Jul 2023 09:13:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: prevent skb corruption on frag list segmentation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168880759380.30427.3453754098888355051.git-patchwork-notify@kernel.org>
Date: Sat, 08 Jul 2023 09:13:13 +0000
References: <ecbccca7b88acfd07164623c40f93cf0842645d3.1688716558.git.pabeni@redhat.com>
In-Reply-To: <ecbccca7b88acfd07164623c40f93cf0842645d3.1688716558.git.pabeni@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, willemb@google.com, steffen.klassert@secunet.com,
 ian.kumlien@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri,  7 Jul 2023 10:11:10 +0200 you wrote:
> Ian reported several skb corruptions triggered by rx-gro-list,
> collecting different oops alike:
> 
> [   62.624003] BUG: kernel NULL pointer dereference, address: 00000000000000c0
> [   62.631083] #PF: supervisor read access in kernel mode
> [   62.636312] #PF: error_code(0x0000) - not-present page
> [   62.641541] PGD 0 P4D 0
> [   62.644174] Oops: 0000 [#1] PREEMPT SMP NOPTI
> [   62.648629] CPU: 1 PID: 913 Comm: napi/eno2-79 Not tainted 6.4.0 #364
> [   62.655162] Hardware name: Supermicro Super Server/A2SDi-12C-HLN4F, BIOS 1.7a 10/13/2022
> [   62.663344] RIP: 0010:__udp_gso_segment (./include/linux/skbuff.h:2858
> ./include/linux/udp.h:23 net/ipv4/udp_offload.c:228 net/ipv4/udp_offload.c:261
> net/ipv4/udp_offload.c:277)
> [   62.687193] RSP: 0018:ffffbd3a83b4f868 EFLAGS: 00010246
> [   62.692515] RAX: 00000000000000ce RBX: 0000000000000000 RCX: 0000000000000000
> [   62.699743] RDX: ffffa124def8a000 RSI: 0000000000000079 RDI: ffffa125952a14d4
> [   62.706970] RBP: ffffa124def8a000 R08: 0000000000000022 R09: 00002000001558c9
> [   62.714199] R10: 0000000000000000 R11: 00000000be554639 R12: 00000000000000e2
> [   62.721426] R13: ffffa125952a1400 R14: ffffa125952a1400 R15: 00002000001558c9
> [   62.728654] FS:  0000000000000000(0000) GS:ffffa127efa40000(0000)
> knlGS:0000000000000000
> [   62.736852] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   62.742702] CR2: 00000000000000c0 CR3: 00000001034b0000 CR4: 00000000003526e0
> [   62.749948] Call Trace:
> [   62.752498]  <TASK>
> [   62.779267] inet_gso_segment (net/ipv4/af_inet.c:1398)
> [   62.787605] skb_mac_gso_segment (net/core/gro.c:141)
> [   62.791906] __skb_gso_segment (net/core/dev.c:3403 (discriminator 2))
> [   62.800492] validate_xmit_skb (./include/linux/netdevice.h:4862
> net/core/dev.c:3659)
> [   62.804695] validate_xmit_skb_list (net/core/dev.c:3710)
> [   62.809158] sch_direct_xmit (net/sched/sch_generic.c:330)
> [   62.813198] __dev_queue_xmit (net/core/dev.c:3805 net/core/dev.c:4210)
> net/netfilter/core.c:626)
> [   62.821093] br_dev_queue_push_xmit (net/bridge/br_forward.c:55)
> [   62.825652] maybe_deliver (net/bridge/br_forward.c:193)
> [   62.829420] br_flood (net/bridge/br_forward.c:233)
> [   62.832758] br_handle_frame_finish (net/bridge/br_input.c:215)
> [   62.837403] br_handle_frame (net/bridge/br_input.c:298
> net/bridge/br_input.c:416)
> [   62.851417] __netif_receive_skb_core.constprop.0 (net/core/dev.c:5387)
> [   62.866114] __netif_receive_skb_list_core (net/core/dev.c:5570)
> [   62.871367] netif_receive_skb_list_internal (net/core/dev.c:5638
> net/core/dev.c:5727)
> [   62.876795] napi_complete_done (./include/linux/list.h:37
> ./include/net/gro.h:434 ./include/net/gro.h:429 net/core/dev.c:6067)
> [   62.881004] ixgbe_poll (drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:3191)
> [   62.893534] __napi_poll (net/core/dev.c:6498)
> [   62.897133] napi_threaded_poll (./include/linux/netpoll.h:89
> net/core/dev.c:6640)
> [   62.905276] kthread (kernel/kthread.c:379)
> [   62.913435] ret_from_fork (arch/x86/entry/entry_64.S:314)
> [   62.917119]  </TASK>
> 
> [...]

Here is the summary with links:
  - [net] net: prevent skb corruption on frag list segmentation
    https://git.kernel.org/netdev/net/c/c329b261afe7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




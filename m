Return-Path: <netdev+bounces-23588-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39D3E76C998
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 11:40:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFC0E281D2E
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 09:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45A1663A9;
	Wed,  2 Aug 2023 09:40:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0CB25683
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 09:40:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5AC47C433C8;
	Wed,  2 Aug 2023 09:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690969221;
	bh=bPpUbVJ8g+WfRXA8L/dbqhku1vmPtOZ22exFereT1AY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QSUj/c162+ie7S9gfe/Fu3ASh4GC3YpdvAnXOx3ZsC42Nt4cTDfEgb7VeOLUrOkop
	 2NbM1KfuEKAMsYLgC5OOmVGbpAkqT78slxmulP6ZxqmMBfHPbnCYev1gXKOsyLCE3O
	 GeNBu3cGCyOkoigjeUJ8/MxW8lYFoLp/dMjC1Mhjzhi6owotvM6IanGFKXnHgsSnc+
	 fbFyqxKdWDgU62pjiRd2Y7p3oqJpC3JIrW528C7YtqzSBf6HhvUzNeM/mYjGrg3xur
	 Q1TU4ItxSMM0uZX8AxCfP53MYPc1oFBf8hy9iw4pppS0hharQj2CQJnDhlEKNPg5Gb
	 CxL+V4Io9D8jQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 34B11C6445A;
	Wed,  2 Aug 2023 09:40:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] ip6mr: Fix skb_under_panic in ip6mr_cache_report()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169096922121.16759.10593210308395776255.git-patchwork-notify@kernel.org>
Date: Wed, 02 Aug 2023 09:40:21 +0000
References: <20230801064318.34408-1-yuehaibing@huawei.com>
In-Reply-To: <20230801064318.34408-1-yuehaibing@huawei.com>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, yoshfuji@linux-ipv6.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 simon.horman@corigine.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 1 Aug 2023 14:43:18 +0800 you wrote:
> skbuff: skb_under_panic: text:ffffffff88771f69 len:56 put:-4
>  head:ffff88805f86a800 data:ffff887f5f86a850 tail:0x88 end:0x2c0 dev:pim6reg
>  ------------[ cut here ]------------
>  kernel BUG at net/core/skbuff.c:192!
>  invalid opcode: 0000 [#1] PREEMPT SMP KASAN
>  CPU: 2 PID: 22968 Comm: kworker/2:11 Not tainted 6.5.0-rc3-00044-g0a8db05b571a #236
>  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
>  Workqueue: ipv6_addrconf addrconf_dad_work
>  RIP: 0010:skb_panic+0x152/0x1d0
>  Call Trace:
>   <TASK>
>   skb_push+0xc4/0xe0
>   ip6mr_cache_report+0xd69/0x19b0
>   reg_vif_xmit+0x406/0x690
>   dev_hard_start_xmit+0x17e/0x6e0
>   __dev_queue_xmit+0x2d6a/0x3d20
>   vlan_dev_hard_start_xmit+0x3ab/0x5c0
>   dev_hard_start_xmit+0x17e/0x6e0
>   __dev_queue_xmit+0x2d6a/0x3d20
>   neigh_connected_output+0x3ed/0x570
>   ip6_finish_output2+0x5b5/0x1950
>   ip6_finish_output+0x693/0x11c0
>   ip6_output+0x24b/0x880
>   NF_HOOK.constprop.0+0xfd/0x530
>   ndisc_send_skb+0x9db/0x1400
>   ndisc_send_rs+0x12a/0x6c0
>   addrconf_dad_completed+0x3c9/0xea0
>   addrconf_dad_work+0x849/0x1420
>   process_one_work+0xa22/0x16e0
>   worker_thread+0x679/0x10c0
>   ret_from_fork+0x28/0x60
>   ret_from_fork_asm+0x11/0x20
> 
> [...]

Here is the summary with links:
  - [v3] ip6mr: Fix skb_under_panic in ip6mr_cache_report()
    https://git.kernel.org/netdev/net/c/30e0191b16e8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




Return-Path: <netdev+bounces-31013-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F115778A8BA
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 11:20:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A98AE280DA3
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 09:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7023613D;
	Mon, 28 Aug 2023 09:20:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622F4611C
	for <netdev@vger.kernel.org>; Mon, 28 Aug 2023 09:20:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C97EFC43391;
	Mon, 28 Aug 2023 09:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693214424;
	bh=NU9wWoRGFCUTvOxZXDwDxMfB3CdZfK0srhKtdDsPObI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=P/OMU3Rc3ByZVyEpH98VlwXt1VUcE+sAz/wNskwmdUGIw28gwOkSP/OpdkFAv7Owg
	 UM757haLoUUXCsS61XqFwNcrz8ppjCMyZ5/HTlQUVfY6WrF/FU31mO5lLBlWq7LCJX
	 PivgVpqd/1+u2J70Dxl1lbYhKYjfoxLSRxExQKHjQZThgXMTAxGirxo+oq+ozHfkk3
	 owDL6+KzLAZ7jbeSzhphqsc0N9lzkI1EET0pzAV3IylN23DUhTpAiP73xqm81ltmQH
	 yXOuFEbN27DohStrLkMJSvZVlLQC2zs+GenIdsscifMeb8xKkKNZA4hmlcvFauqcmE
	 +zcMPlsPH+h/g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B7267E21EDF;
	Mon, 28 Aug 2023 09:20:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 1/2] net: Fix skb consume leak in sch_handle_egress
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169321442474.7279.946406074074622512.git-patchwork-notify@kernel.org>
Date: Mon, 28 Aug 2023 09:20:24 +0000
References: <20230825134946.31083-1-daniel@iogearbox.net>
In-Reply-To: <20230825134946.31083-1-daniel@iogearbox.net>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, davem@davemloft.net, pabeni@redhat.com,
 kuba@kernel.org, gal@nvidia.com, martin.lau@linux.dev

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 25 Aug 2023 15:49:45 +0200 you wrote:
> Fix a memory leak for the tc egress path with TC_ACT_{STOLEN,QUEUED,TRAP}:
> 
>   [...]
>   unreferenced object 0xffff88818bcb4f00 (size 232):
>   comm "softirq", pid 0, jiffies 4299085078 (age 134.028s)
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     00 80 70 61 81 88 ff ff 00 41 31 14 81 88 ff ff  ..pa.....A1.....
>   backtrace:
>     [<ffffffff9991b938>] kmem_cache_alloc_node+0x268/0x400
>     [<ffffffff9b3d9231>] __alloc_skb+0x211/0x2c0
>     [<ffffffff9b3f0c7e>] alloc_skb_with_frags+0xbe/0x6b0
>     [<ffffffff9b3bf9a9>] sock_alloc_send_pskb+0x6a9/0x870
>     [<ffffffff9b6b3f00>] __ip_append_data+0x14d0/0x3bf0
>     [<ffffffff9b6ba24e>] ip_append_data+0xee/0x190
>     [<ffffffff9b7e1496>] icmp_push_reply+0xa6/0x470
>     [<ffffffff9b7e4030>] icmp_reply+0x900/0xa00
>     [<ffffffff9b7e42e3>] icmp_echo.part.0+0x1a3/0x230
>     [<ffffffff9b7e444d>] icmp_echo+0xcd/0x190
>     [<ffffffff9b7e9566>] icmp_rcv+0x806/0xe10
>     [<ffffffff9b699bd1>] ip_protocol_deliver_rcu+0x351/0x3d0
>     [<ffffffff9b699f14>] ip_local_deliver_finish+0x2b4/0x450
>     [<ffffffff9b69a234>] ip_local_deliver+0x174/0x1f0
>     [<ffffffff9b69a4b2>] ip_sublist_rcv_finish+0x1f2/0x420
>     [<ffffffff9b69ab56>] ip_sublist_rcv+0x466/0x920
>   [...]
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] net: Fix skb consume leak in sch_handle_egress
    https://git.kernel.org/netdev/net-next/c/28d18b673ffa
  - [net-next,2/2] net: Make consumed action consistent in sch_handle_egress
    https://git.kernel.org/netdev/net-next/c/3a1e2f43985a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




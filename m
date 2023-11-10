Return-Path: <netdev+bounces-47019-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 92A197E7A38
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 09:40:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 227C0B20F3F
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 08:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 957177483;
	Fri, 10 Nov 2023 08:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cvKaasXF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 785806AB2
	for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 08:40:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0D8B7C433C8;
	Fri, 10 Nov 2023 08:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699605629;
	bh=ojxQrWRsBhV3sHjcTp3T5x/E7hta8JSK/dj7raxBMjg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cvKaasXF6zuGSq2/ojx021OnUWTt3jq/0lBpK9ce45Nn4dJk/2KhYdqg9MsGqhPZR
	 Bgb1rZe5KTIiY5ynos9qGajbp8Y2JZYX7cPPnpnn+oOBf1b1A2MGdJ+YHrbuCOwGOH
	 tPnPLIiLQnqT6Udd0bOrq8R7q+yXWldF2b5BL76gZKu8fRTaiWP8gopmuPS3NOSr80
	 6MjwIXEXx7smNsG9f8NwNNqGcyeB/OeLAdzW/x6cJga0hMz06kqb4L8fR+3acpo7WG
	 kdbsOrlZaOMrErOD/Wf0ZMDnSzNLG1z5IgsdHm2WabPpjAuRmAfiqQfiCD6HwSlAPz
	 JiAi5EkSscJkg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E7C28C395DC;
	Fri, 10 Nov 2023 08:40:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: set SOCK_RCU_FREE before inserting socket into
 hashtable
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169960562893.22093.8898446995954021194.git-patchwork-notify@kernel.org>
Date: Fri, 10 Nov 2023 08:40:28 +0000
References: <20231108211325.18938-1-sdf@google.com>
In-Reply-To: <20231108211325.18938-1-sdf@google.com>
To: Stanislav Fomichev <sdf@google.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed,  8 Nov 2023 13:13:25 -0800 you wrote:
> We've started to see the following kernel traces:
> 
>  WARNING: CPU: 83 PID: 0 at net/core/filter.c:6641 sk_lookup+0x1bd/0x1d0
> 
>  Call Trace:
>   <IRQ>
>   __bpf_skc_lookup+0x10d/0x120
>   bpf_sk_lookup+0x48/0xd0
>   bpf_sk_lookup_tcp+0x19/0x20
>   bpf_prog_<redacted>+0x37c/0x16a3
>   cls_bpf_classify+0x205/0x2e0
>   tcf_classify+0x92/0x160
>   __netif_receive_skb_core+0xe52/0xf10
>   __netif_receive_skb_list_core+0x96/0x2b0
>   napi_complete_done+0x7b5/0xb70
>   <redacted>_poll+0x94/0xb0
>   net_rx_action+0x163/0x1d70
>   __do_softirq+0xdc/0x32e
>   asm_call_irq_on_stack+0x12/0x20
>   </IRQ>
>   do_softirq_own_stack+0x36/0x50
>   do_softirq+0x44/0x70
> 
> [...]

Here is the summary with links:
  - [net,v2] net: set SOCK_RCU_FREE before inserting socket into hashtable
    https://git.kernel.org/netdev/net/c/871019b22d1b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




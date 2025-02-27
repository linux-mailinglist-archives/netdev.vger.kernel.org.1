Return-Path: <netdev+bounces-170080-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFBEBA47391
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 04:30:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B867188FB08
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 03:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24A451B85CA;
	Thu, 27 Feb 2025 03:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n1kizPDW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9E31B6D12;
	Thu, 27 Feb 2025 03:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740627000; cv=none; b=BlJxfNbBSlARD0cNzhmEow/YxS7BGeDw7aWsK8Vbw3B4gxdUl/oAzD3nIsrJ9gZcc9j4rhf/AaTysq0/+67cf5LIysWkrQ4NS6tTdIxtD2oWJXBN+7r55YopCxcEQOHKAry5baQG13XiG8ET910bw38mir/pQsoQcIZjL3MLx5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740627000; c=relaxed/simple;
	bh=P3M/o9J5qwQuFBHcLglZeHVBvBrBB5ECnJyRRwdodAs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=T20VxkZEkfSBiEcwuv8LwqxIi2KuhKrNU66ELFUM6FbUBBll2CJhNhfyx7oI6z248GI4UyW0VkbBHE4/cEkljCNjZCCU+VjawTfyi2oSErfPFiG58N537EnX+P5Chs9tCYdRC5wpY12VsHlk3aYkO86mysyfG49mG3MtCL51UkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n1kizPDW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E6F1C4CEE6;
	Thu, 27 Feb 2025 03:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740626999;
	bh=P3M/o9J5qwQuFBHcLglZeHVBvBrBB5ECnJyRRwdodAs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=n1kizPDW487iOqY05q+MrdN+MqmqrHAxOOXfKRRuoBxDOWSrH1eN8ee4Bs5D2IjKS
	 KY3wQVTuTNdgsn3OWiNLhVGt5OAG5k6jMa7iMtIeKIHyrWBffhndUNU8WdRD6A2iG7
	 d1+S0xz64zSB7/9gSMF8+ASmI2rQL+ubVlKJZQ+Ash0tX/w48zmjAV1S5f0E1mygPz
	 5upohl6ESHS4nElmK/vlWmalZK3vP4vlean2TehSBl2bntH+Jbgi4tz96+QGrCePPg
	 p3R4C61ODsfYbkb6Zma/FBJ6VggoCcNqUvGdFzHHvApQbGDyxbrs3gGuvFPMs53IMs
	 HWpRDvI6Uc6bA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C29380CFE6;
	Thu, 27 Feb 2025 03:30:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 1/1] af_unix: Fix memory leak in unix_dgram_sendmsg()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174062703126.955127.3742311492313103236.git-patchwork-notify@kernel.org>
Date: Thu, 27 Feb 2025 03:30:31 +0000
References: <20250225021457.1824-1-ahuang12@lenovo.com>
In-Reply-To: <20250225021457.1824-1-ahuang12@lenovo.com>
To: Adrian Huang <adrianhuang0701@gmail.com>
Cc: kuniyu@amazon.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, ahuang12@lenovo.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 25 Feb 2025 10:14:57 +0800 you wrote:
> From: Adrian Huang <ahuang12@lenovo.com>
> 
> After running the 'sendmsg02' program of Linux Test Project (LTP),
> kmemleak reports the following memory leak:
> 
>   # cat /sys/kernel/debug/kmemleak
>   unreferenced object 0xffff888243866800 (size 2048):
>     comm "sendmsg02", pid 67, jiffies 4294903166
>     hex dump (first 32 bytes):
>       00 00 00 00 00 00 00 00 5e 00 00 00 00 00 00 00  ........^.......
>       01 00 07 40 00 00 00 00 00 00 00 00 00 00 00 00  ...@............
>     backtrace (crc 7e96a3f2):
>       kmemleak_alloc+0x56/0x90
>       kmem_cache_alloc_noprof+0x209/0x450
>       sk_prot_alloc.constprop.0+0x60/0x160
>       sk_alloc+0x32/0xc0
>       unix_create1+0x67/0x2b0
>       unix_create+0x47/0xa0
>       __sock_create+0x12e/0x200
>       __sys_socket+0x6d/0x100
>       __x64_sys_socket+0x1b/0x30
>       x64_sys_call+0x7e1/0x2140
>       do_syscall_64+0x54/0x110
>       entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> [...]

Here is the summary with links:
  - [v2,1/1] af_unix: Fix memory leak in unix_dgram_sendmsg()
    https://git.kernel.org/netdev/net/c/bc23d4e30866

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




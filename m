Return-Path: <netdev+bounces-88542-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A56D48A79F0
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 02:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B41A1F22296
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 00:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E2A4364;
	Wed, 17 Apr 2024 00:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DT823644"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4969917C2
	for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 00:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713314429; cv=none; b=GbpXghjBLoydew8aZhZ+nQixoX7IMC5VNQOMAlljSuxUH6bK9m+zrNuMuJ4of41CUoKSVk+T8GG3sazc7I68XXwGVCSp9PdVypuUAtoqFteLZiv3eTjcJv29py0JbLUDCXmjc7afGkIuAV+zPKy9jQ7Y2XmiRFlQtP3jj27XbNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713314429; c=relaxed/simple;
	bh=UiUZLo90dLtutxjOLBEKJSWVxHhrIlISpqCwCv4mq8U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MdKSDY4WBVkG4sO16k0e1koGMq2iyDLgC4Bbn+k2bUjkoW9AVdLGqZD2DPtqVJVXt+FUCDBL0mtt2vW/D3NXNr/GOBKNir5jRU8M+odaULoskuvOmypDy26UYkJERR5IhseT8+i7EtfmOlWy/tdnlU4h1txR8ihdT28XWXfMjxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DT823644; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C6E30C2BD10;
	Wed, 17 Apr 2024 00:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713314428;
	bh=UiUZLo90dLtutxjOLBEKJSWVxHhrIlISpqCwCv4mq8U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DT823644wg7pptELNVFYe9+aZ2fXpxAi91sbsbzX/P4B21VaqM6o+2W8dEfPoQ8z8
	 hor3kpmDDGufNTei3Bkzr3qU3073Dd7GA5+fcvlENfuq37heAvJuodLnq2baE1wSFN
	 Z0m2C7wC/ynAnIxTqvm67TweaiRJiPQu3tQ0JUtAr5Tb4l6K44yU70FyaqGq5YSb0k
	 pq6Bt8049aYEciZn/eLuxnwEXLey/b8mLJpNaJrUUKG/LdqnIuLhOiuwOaX7X5FAqt
	 ByvuU/DCDjwJ0w6+oZZ6mon0HfH8eQnIVJbtv2cjgCleMZ59Kwy8SEWliOuwFeQ577
	 M25V7lCNrsyhQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B3965D4F15F;
	Wed, 17 Apr 2024 00:40:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] ip6_vti: fix memleak on netns dismantle
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171331442873.6172.4859886049897131598.git-patchwork-notify@kernel.org>
Date: Wed, 17 Apr 2024 00:40:28 +0000
References: <20240415122346.26503-1-fw@strlen.de>
In-Reply-To: <20240415122346.26503-1-fw@strlen.de>
To: Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, leitao@debian.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 15 Apr 2024 14:23:44 +0200 you wrote:
> kmemleak reports net_device resources are no longer released, restore
> needs_free_netdev toggle.  Sample backtrace:
> 
> unreferenced object 0xffff88810874f000 (size 4096): [..]
>     [<00000000a2b8af8b>] __kmalloc_node+0x209/0x290
>     [<0000000040b0a1a9>] alloc_netdev_mqs+0x58/0x470
>     [<00000000b4be1e78>] vti6_init_net+0x94/0x230
>     [<000000008830c1ea>] ops_init+0x32/0xc0
>     [<000000006a26fa8f>] setup_net+0x134/0x2e0
> [..]
> 
> [...]

Here is the summary with links:
  - [net-next] ip6_vti: fix memleak on netns dismantle
    https://git.kernel.org/netdev/net-next/c/86600ea11dc1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




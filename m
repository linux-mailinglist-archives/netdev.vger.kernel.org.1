Return-Path: <netdev+bounces-186812-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1632AA188F
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 20:01:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72AB64A3129
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 18:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9EC1252914;
	Tue, 29 Apr 2025 17:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jdypGX9E"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A8A248883;
	Tue, 29 Apr 2025 17:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745949590; cv=none; b=ER7JUI8m+EPeoTVQS++ugVe9H/MEDrXvLBaUIvf57qod6w3QiZNxNYRFJCE1iiqRU3x1Mvd0clX2eauHbHAdDGEJLDEuMQ02k/YhaP/zeAittuzSchPevrvWPdngHtfhr4iEH8zB15C55GtYwxs5+rm5tXoDhoV9vcLJx3sxr2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745949590; c=relaxed/simple;
	bh=Mlv5QPLKqqnLLlp3l4YB9mb0TbR4nnACnfhCeWOJ2qA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZsLTwHop0rjL122qlo4gv18tsGEYj2CaPiNCB577iFAvFPBqYF8Lk5WaXo7FKEl/Sp/rFIoGz3RLWkerz12m4H5WaiRrVAKdLSqt8hKDnIhnXrsB7pq/L2mFFe+6WeDin3k/bKFaWPqHHpZrgCZXXzMwJQJHYVHI6JAKkz8t1+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jdypGX9E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4733EC4CEE3;
	Tue, 29 Apr 2025 17:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745949590;
	bh=Mlv5QPLKqqnLLlp3l4YB9mb0TbR4nnACnfhCeWOJ2qA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jdypGX9EoMqhhPmCwvvegpsjmhqEgXTFWnH4WpuPGQ4+/8hsuc1tcsk2l0TpBC/zF
	 AHgeIkuc+4KzHbJWvcqnnv/0Aq578yjcI/+Jt5KQD1JRNOWfKVV8QrN6KDXYSxIK9O
	 zv1BJoArVE6EoVUSz+4Q5LSEL5B51N/2tegpShYs70D5B3iAf5BupfX8jSh3J8hXVp
	 K6rG/19hqLBSA9SL8C6Igw7FoG2/pvd5+VEDrAU6mHMzL1+lTWNvvoVU/puLKUNLQn
	 qPXonvrb5MCSQIu+XsTpNiR1vL9NT+X1Azoi/dY5zTnxIFx7tKlC9Xev74XhLUWlnX
	 xvmwew0w3wu+g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D7E3822D4C;
	Tue, 29 Apr 2025 18:00:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] ipv4: fib: Fix fib_info_hash_alloc() allocation type
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174594962925.1753982.13626856832986893239.git-patchwork-notify@kernel.org>
Date: Tue, 29 Apr 2025 18:00:29 +0000
References: <20250426060529.work.873-kees@kernel.org>
In-Reply-To: <20250426060529.work.873-kees@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 25 Apr 2025 23:05:30 -0700 you wrote:
> In preparation for making the kmalloc family of allocators type aware,
> we need to make sure that the returned type from the allocation matches
> the type of the variable being assigned. (Before, the allocator would
> always return "void *", which can be implicitly cast to any pointer type.)
> 
> This was allocating many sizeof(struct hlist_head *) when it actually
> wanted sizeof(struct hlist_head). Luckily these are the same size.
> Adjust the allocation type to match the assignment.
> 
> [...]

Here is the summary with links:
  - ipv4: fib: Fix fib_info_hash_alloc() allocation type
    https://git.kernel.org/netdev/net-next/c/fca6170f5a03

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




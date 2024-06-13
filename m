Return-Path: <netdev+bounces-103269-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC7B90756F
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 16:41:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC2AF1C22112
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 14:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C623F1465A5;
	Thu, 13 Jun 2024 14:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jzahjbiD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1BF0146592
	for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 14:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718289632; cv=none; b=qJG99GUXWy3xs92NtJLJTeCFoLw/bZhEDG0WzJQvo03SgDUDync3Qe7W54CA8JzmjHTL6myC1BcknfKSRIIBxC9LL7FngT++Nt+XPZQe+goV1Y3zTYLciehtrI0Uz8rVMCVmRGwG6md4URa/jnv5abdEJvZlkYIZeMKwANzXSNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718289632; c=relaxed/simple;
	bh=eL6jUZgUBcewlbxTa3vkHS9UtRtJR1SLX0ncG6lLXh4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Ci4W7s79v7VCQKB+SiQL/EDnBZHYDLm+vHNkG24Lo4wdKgKQPtxJiBGYUv0zFTxMw3FB4htudyTCj5u91SqvaEUxHNGjEsmSpzkbIcPXozxgvPvWhwpf8lpZMAlbcpOYYmrsQ0BG+hjSQVMoHYR1uGVHLcN4+9V7RuHW0DPsMQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jzahjbiD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 24D3FC4AF51;
	Thu, 13 Jun 2024 14:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718289632;
	bh=eL6jUZgUBcewlbxTa3vkHS9UtRtJR1SLX0ncG6lLXh4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jzahjbiDwNmpK8LHtNpyhzc10u/6kXMysxM9iBSgmJfzg/AuYBNTu2uOo0d95LgYN
	 xMmb6YUaMe7X4KWVdkK8oGqa4Q8mmpTjSwd7dlXUjwnPAmUEx2wCFWFs29Eol73SMf
	 R/cRrucKKQ2KtYZ9U0vMDn7QyrVf8QMvuDHJXHFoKHVO3u45u0O1AXREDOaFu3q515
	 xFwE+vOh9iP5I03nhdKYrGoUZaFaXCAjy6s+KSuVV7osRliNCinNkAoUJt+mgQ58E9
	 mCep9FPVbv8BZlSh9EiijYKHIQN8NkUikEj3El0ahGquUa1vPyg8J6nTen9lstV8DN
	 lndelu2ycFrgQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 10293C43619;
	Thu, 13 Jun 2024 14:40:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] ionic: fix use after netif_napi_del()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171828963106.5991.8973378919340586349.git-patchwork-notify@kernel.org>
Date: Thu, 13 Jun 2024 14:40:31 +0000
References: <20240612060446.1754392-1-ap420073@gmail.com>
In-Reply-To: <20240612060446.1754392-1-ap420073@gmail.com>
To: Taehee Yoo <ap420073@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, shannon.nelson@amd.com, brett.creeley@amd.com,
 drivers@pensando.io, netdev@vger.kernel.org, jacob.e.keller@intel.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 12 Jun 2024 06:04:46 +0000 you wrote:
> When queues are started, netif_napi_add() and napi_enable() are called.
> If there are 4 queues and only 3 queues are used for the current
> configuration, only 3 queues' napi should be registered and enabled.
> The ionic_qcq_enable() checks whether the .poll pointer is not NULL for
> enabling only the using queue' napi. Unused queues' napi will not be
> registered by netif_napi_add(), so the .poll pointer indicates NULL.
> But it couldn't distinguish whether the napi was unregistered or not
> because netif_napi_del() doesn't reset the .poll pointer to NULL.
> So, ionic_qcq_enable() calls napi_enable() for the queue, which was
> unregistered by netif_napi_del().
> 
> [...]

Here is the summary with links:
  - [net,v2] ionic: fix use after netif_napi_del()
    https://git.kernel.org/netdev/net/c/79f18a41dd05

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




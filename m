Return-Path: <netdev+bounces-129900-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98072986F48
	for <lists+netdev@lfdr.de>; Thu, 26 Sep 2024 10:50:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 587DB283265
	for <lists+netdev@lfdr.de>; Thu, 26 Sep 2024 08:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 252C51A4F2E;
	Thu, 26 Sep 2024 08:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T7zMMok6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8E41A4E9A;
	Thu, 26 Sep 2024 08:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727340629; cv=none; b=bdytDbgl7IDP7EBSk+lRqcZALDt3w+F3DONB+3UQEl7PVFjR5NWV21D9sSOlVsfPaNZOlxyh/DTA4wJODArmAsdwPyR7keimftOJ1W0LtvtPAtkqRObhh1zJsMfwTKLF7zpjYuu7/dF4t5sTecnZ0JbD+eoWNFn/HFITb1p8Ibw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727340629; c=relaxed/simple;
	bh=GcRYZc0aYdKjKzm8dqTZs423b3rVkDA/yBEu7aO4lvc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bh8t1HzeaJQFQw7+hCFyPZSj5KIAX7/HcT+xKkHglQZZLeoYcE2rDc3FWlBLs+lExdh01twNOCSr/dTfyEWck+s98xazrw8/ca7bcnlOj9izmm6h8Cb3FnLbJKAGkbSq2nd9JI15hGAOwBhKMg95xwSh9MXAvQpCYi6etzJ9Xgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T7zMMok6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79B68C4CEC7;
	Thu, 26 Sep 2024 08:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727340628;
	bh=GcRYZc0aYdKjKzm8dqTZs423b3rVkDA/yBEu7aO4lvc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=T7zMMok6AL8MgOS0GZUb2ZO196/h+wGaqUznwue4pQ1u0n66dxxYn2zOfohwAYSlJ
	 t5ZCa0rrb4FGKZVoJQN6mrYZkm2BvBijKW0EHSicYUTsAWYtwO4LdzNb/xeDaQz2hE
	 WpgBxpT2JYnliPPbOQs2ACce8ulAlU3MSVDazNzXktBkwo2GmbAAx1nzPbDskXVPSx
	 w41Q93K1IAsLRGDwziTcFHN1LV6mzw7dY23pmPA6wYylz7TJDQgLiEwGhiZtmKJj7m
	 HJVV9387mm3EtlpOdJGtCjc6ZKRUlCMCGjhbHpxD7H6Xb8ZUBOwktmQftoLxqSH2op
	 18/D98E1mvlpg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D22380DBF5;
	Thu, 26 Sep 2024 08:50:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: stmmac: set PP_FLAG_DMA_SYNC_DEV only if XDP is
 enabled
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172734063104.1173335.1175532614664829516.git-patchwork-notify@kernel.org>
Date: Thu, 26 Sep 2024 08:50:31 +0000
References: <20240919121028.1348023-1-0x1207@gmail.com>
In-Reply-To: <20240919121028.1348023-1-0x1207@gmail.com>
To: Furong Xu <0x1207@gmail.com>
Cc: boon.leong.ong@intel.com, davem@davemloft.net,
 alexandre.torgue@foss.st.com, joabreu@synopsys.com, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
 jpinto@synopsys.com, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 rmk+kernel@armlinux.org.uk, linux@armlinux.org.uk, xfr@outlook.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 19 Sep 2024 20:10:28 +0800 you wrote:
> Commit 5fabb01207a2 ("net: stmmac: Add initial XDP support") sets
> PP_FLAG_DMA_SYNC_DEV flag for page_pool unconditionally,
> page_pool_recycle_direct() will call page_pool_dma_sync_for_device()
> on every page even the page is not going to be reused by XDP program.
> 
> When XDP is not enabled, the page which holds the received buffer
> will be recycled once the buffer is copied into new SKB by
> skb_copy_to_linear_data(), then the MAC core will never reuse this
> page any longer. Always setting PP_FLAG_DMA_SYNC_DEV wastes CPU cycles
> on unnecessary calling of page_pool_dma_sync_for_device().
> 
> [...]

Here is the summary with links:
  - [net,v2] net: stmmac: set PP_FLAG_DMA_SYNC_DEV only if XDP is enabled
    https://git.kernel.org/netdev/net/c/b514c47ebf41

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




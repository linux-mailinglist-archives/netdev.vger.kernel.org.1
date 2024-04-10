Return-Path: <netdev+bounces-86419-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD9C489EBFF
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 09:30:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 962D9283517
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 07:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D8DD13D256;
	Wed, 10 Apr 2024 07:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YbL/KKXs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B4913CFA1
	for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 07:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712734227; cv=none; b=LppSOzf1Id8BQ6bmj0MkchGw54FLF3s83zQQp+8Czsq/5FGa2IOFrBCVRek6csSE242TFGXaLVVSs6txaQzh/ubQTCYBl6aB3H2y3Jdnqx7qtkBmEiacX+xAGfNxdJ6DQxn8kgy1vFeHsTYBsHzckbG/SUKbftnDAZrQZhfw1OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712734227; c=relaxed/simple;
	bh=ztxDn4fas7IPy5ph0fnOURmNjydalmi2bul+yxZwcQw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=B37gwoxXSWNjbxGWZF+qq4g3Vbsuf2b0qxUGDG5Yk6ZXTtZ6ogwMC+K9WE8vk7MkOD6YdSG4R6QBKemIznX5+hJYHZURGB7+ti1c9I9oZTVPSgsW8ZuJtShJBOFdmo+IVuc2IyIU/GpTuN12HlmN6rwhOSetPKYhS4xJa8YzhGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YbL/KKXs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4D763C43390;
	Wed, 10 Apr 2024 07:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712734227;
	bh=ztxDn4fas7IPy5ph0fnOURmNjydalmi2bul+yxZwcQw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YbL/KKXszW1wFoD+qdx20DP5DI9ETxGSudZdK/y0v3NeqRH20/rg3U+gvvkCQCQra
	 eN+tBGX6xKCcFHZwDg6iEkyn+yvbU9gs2zVhcPHYQmrrXGn61nin32Wj45cNAnJq5F
	 We6gmqHejYMoIJUhM6IMYkqncFTcmiN92JigGHimzHH+W74PYfFPtW0K7tbMY++MR/
	 7CjnVlYLU0VNccD9wuLfJEyUouerdyAry0meZOUHJMOhoKTzpsobEg8R8Ce91X2Cxd
	 KFW3MWuf8nf4G3n3iWwb/I/dzkfJZxm0w6g0Tyo93Zfflvyop2m/9jQzqr1fxwwg+E
	 HKb+6lq/jmsaw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3724BD60312;
	Wed, 10 Apr 2024 07:30:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: sched: cls_api: fix slab-use-after-free in
 fl_dump_key
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171273422722.9319.15926353601229442056.git-patchwork-notify@kernel.org>
Date: Wed, 10 Apr 2024 07:30:27 +0000
References: <20240408134817.35065-1-jianbol@nvidia.com>
In-Reply-To: <20240408134817.35065-1-jianbol@nvidia.com>
To: Jianbo Liu <jianbol@nvidia.com>
Cc: netdev@vger.kernel.org, ast@fiberby.net, davem@davemloft.net,
 marcelo.leitner@gmail.com, horms@kernel.org, cratiu@nvidia.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon, 8 Apr 2024 16:48:17 +0300 you wrote:
> The filter counter is updated under the protection of cb_lock in the
> cited commit. While waiting for the lock, it's possible the filter is
> being deleted by other thread, and thus causes UAF when dump it.
> 
> Fix this issue by moving tcf_block_filter_cnt_update() after
> tfilter_put().
> 
> [...]

Here is the summary with links:
  - [net-next] net: sched: cls_api: fix slab-use-after-free in fl_dump_key
    https://git.kernel.org/netdev/net-next/c/2ecd487b670f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




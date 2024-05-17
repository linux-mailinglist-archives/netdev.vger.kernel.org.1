Return-Path: <netdev+bounces-96839-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AD538C8006
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 04:41:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D33D1C2101D
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 02:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C9A912E7C;
	Fri, 17 May 2024 02:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FiuzXOYf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4BDB672;
	Fri, 17 May 2024 02:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715913631; cv=none; b=SzD82KORZUnWBL1wgq8m2d0Wwbrom39BLopK13+nPnFb4uIHIjRqffsII/l6WKKEzaKD2Zec97uDOEHRdP6iPFF2v6PGHN9+AegXfFblcwKkZv4SBnVZQY47mzncok6yq3HKcOnNeC+y/C/ZJPjb6qKhAlCoYIeTt/a7G8Vzymo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715913631; c=relaxed/simple;
	bh=m4eWWCmy5F3msSmJSIJTtabMQJfBd0k8Q+YIpPqOhwY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZJKVvZ53rcd/5pKZ3Rx4TJ+cNItoh49n5zO6UUVMxESGDamWNMMTehmieEKCghnOKcP4/awmHeZIRFEk/C9q4eUwdud8XA09rEtR8h/pUFQsUgumJOxVT7zOiQWfiuaHwkkK8ii2aPSR/xfzh7/i8yerqTVtKd+Iqj9xeLTZGro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FiuzXOYf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D648BC4AF12;
	Fri, 17 May 2024 02:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715913630;
	bh=m4eWWCmy5F3msSmJSIJTtabMQJfBd0k8Q+YIpPqOhwY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FiuzXOYfYj/AE9ngbeRSR9rdck4n67SAkSUPukfi8HbYBtFTC2B5KTRNVRlyxpBU2
	 RZGMZzaV4qpJmrSDG9ijOwHx8w52g5+guwYU2Nlluv4a0+1oUP49nUP9UIrCZeQsr5
	 teLae+Fi6FgfG8zySEW6wWPfMl68psq4wqd90/57Q0NVr3Ia5p1mXBJmiHQBHwAiXq
	 YZpJ6aSPR4IH3TU2uUcSwXkc60n6uLQqpQwwgCrzEFWDclVqrzen1Bhn3z1pQhls8g
	 G2SVgcXaoPbUM6KdDCr9fB+lHEDfIgliWNhYOYzWxedy8juZf+I5aShZ/igkLnmiuw
	 Crsso3pWsuvaQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CC197C41620;
	Fri, 17 May 2024 02:40:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] virtio_net: Fix missed rtnl_unlock
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171591363083.2697.864988249934553931.git-patchwork-notify@kernel.org>
Date: Fri, 17 May 2024 02:40:30 +0000
References: <20240515163125.569743-1-danielj@nvidia.com>
In-Reply-To: <20240515163125.569743-1-danielj@nvidia.com>
To: Daniel Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, mst@redhat.com, jasowang@redhat.com,
 xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 jiri@nvidia.com, edumaset@google.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 15 May 2024 11:31:25 -0500 you wrote:
> The rtnl_lock would stay locked if allocating promisc_allmulti failed.
> Also changed the allocation to GFP_KERNEL.
> 
> Fixes: ff7c7d9f5261 ("virtio_net: Remove command data from control_buf")
> Reported-by: Eric Dumazet <edumaset@google.com>
> Link: https://lore.kernel.org/netdev/CANn89iLazVaUCvhPm6RPJJ0owra_oFnx7Fhc8d60gV-65ad3WQ@mail.gmail.com/
> Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
> 
> [...]

Here is the summary with links:
  - [v3] virtio_net: Fix missed rtnl_unlock
    https://git.kernel.org/netdev/net/c/fa033def4171

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




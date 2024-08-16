Return-Path: <netdev+bounces-119070-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE68953F60
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 04:10:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDB6628767E
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 02:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 958A73BBF0;
	Fri, 16 Aug 2024 02:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QK2OCfZm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696B03A1BF;
	Fri, 16 Aug 2024 02:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723774233; cv=none; b=H2Rl64wuw5ur7lBcowYS+4IKG1TgA2f187dXGPfPUtE70KakLlinSGqc2+nJt1l0H+8RcbG9A4e6l2Xhl737L2UgWxot7FdTVDaTy77bnvCsFNzswV28o/nhESnHhnzIMqcF1A7RfiFpcpeX+eZCiIXYUeLguebTrcA+qTrmwbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723774233; c=relaxed/simple;
	bh=QhK6hhEu469h4qlv0tmDK1GAhAtGSWaNW81HxBUvmZM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=o+M4+Bj8vt3dA8s4Fce37T1oUT/WGs+kGMilYuGrigwP1M12/1i3EZpqLz7/v5y71itlI9gji90vv99eZJ6ybx/fCHLdnbMZJmsKOxAEqvqJxwEBzFqVJagfvmdUACTFVhqMqHHL2Li9cjmUT/DUCZwIBmu41ujl0Gagg3kiE7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QK2OCfZm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C631C32786;
	Fri, 16 Aug 2024 02:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723774233;
	bh=QhK6hhEu469h4qlv0tmDK1GAhAtGSWaNW81HxBUvmZM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QK2OCfZms8midELVJZDDEbNOLhICby/VLnQgdT1Uaa4Hjt5KVd4017q5ZqppEI3so
	 39AEjQVUV93bFOtsyDllcmqACVbFCnl3e5DWdEI8M0rS/TU9myaAsLrDffttZ4ROz2
	 mClbzn8HXgcOyO2g0PnnMB7ojqIl9zayN/Md0hva3WAUItrhHlM7UPfUY3rawOG0bE
	 ba3N+Q0bcdGfusmNnOxFhDusdtM9frb4TCvIwqjexUGtXmqiOYcFVZdYyytk2iiMjx
	 XEOABVRFkXIltKpJtnKLmPrz+3qP1CkokftH/Ekbe+Ry92xpH1r3QTi8tmPZj19jpU
	 RqXpx7EZIot6g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE098382327A;
	Fri, 16 Aug 2024 02:10:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net/mlx5: Use cpumask_local_spread() instead of custom code
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172377423224.3091787.3606516160819864635.git-patchwork-notify@kernel.org>
Date: Fri, 16 Aug 2024 02:10:32 +0000
References: <20240812082244.22810-1-e.velu@criteo.com>
In-Reply-To: <20240812082244.22810-1-e.velu@criteo.com>
To: Erwan Velu <erwanaliasr1@gmail.com>
Cc: e.velu@criteo.com, saeedm@nvidia.com, leon@kernel.org, tariqt@nvidia.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 12 Aug 2024 10:22:42 +0200 you wrote:
> Commit 2acda57736de ("net/mlx5e: Improve remote NUMA preferences used for the IRQ affinity hints")
> removed the usage of cpumask_local_spread().
> 
> The issue explained in this commit was fixed by
> commit 406d394abfcd ("cpumask: improve on cpumask_local_spread() locality").
> 
> Since this commit, mlx5_cpumask_default_spread() is having the same
> behavior as cpumask_local_spread().
> 
> [...]

Here is the summary with links:
  - net/mlx5: Use cpumask_local_spread() instead of custom code
    https://git.kernel.org/netdev/net-next/c/e5efc2311cc4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




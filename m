Return-Path: <netdev+bounces-221491-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E00B1B50A40
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 03:30:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14C81189470E
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 01:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 043B41F4297;
	Wed, 10 Sep 2025 01:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FIJH+jl6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08451D5174;
	Wed, 10 Sep 2025 01:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757467803; cv=none; b=TdHFiA2g8JwLEb4cCE2IQizou2RBGLPhn2omG9hyh9AG4n8AZRqOLPGEsZl8W3My46uCPn75GQWIBC8OsMeWfABd8lRhvyBEjsrXxk+tkFVpGNbHFCSfNLYeudRpM+gKEsvZS9lLt57TpZLMsFhh2NOs6piagHMp6Vhh5i8gwPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757467803; c=relaxed/simple;
	bh=fMzUZ89rUIrB3BdUFoSRAOSzYorBCqeFF+aJ+HQat84=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TqsH9e33j167HelfwTGJ96eczsG9x2oqnyCTaGmG13tjavatonCoPhaa4cSNzZq+1rKH7RbTQkgZw0stSSnoSB/R0e3DQfjwFtvJzcwKSzcVUImbbwhaMrmvCQJQI0ECgiDnjis1r3JuV34LI0C5JYgLKGYvw3zZhmR49m8IxpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FIJH+jl6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63043C4CEF4;
	Wed, 10 Sep 2025 01:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757467803;
	bh=fMzUZ89rUIrB3BdUFoSRAOSzYorBCqeFF+aJ+HQat84=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FIJH+jl63Sz0OwwkPHIQI7XYV1UB11zkmfiKz4S5tm8dzyWnFVXhh8YJQ866GEtQ5
	 oVXer4P+9Mc48t/bBkfu9NT1MhpuXHK9LKOUsblQkTdn8+KNCDMlyM4fdWqnKf2YfD
	 jmmlhxg2b1sb+ous78+K+RD1Zhvmdd8dGNdwdazx4J2tX5Qw6auF891aSd+XT9iyfg
	 e5v9b/ks0hB1I71/zo1wyYwBw3MgsSwT9UfP2KjHNfFM8SgqbOrmchjQl++nFLZqyh
	 Hl3pDD4nu/yL6Kcz66UgZVZsSipktH0nw1nZJ0U6SCUez7HuZqbaAUTDgJlik+vhGH
	 6hYY3ZJ03865A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE4BB383BF69;
	Wed, 10 Sep 2025 01:30:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net] net: dev_ioctl: take ops lock in hwtstamp lower
 paths
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175746780652.866782.7996733446987433045.git-patchwork-notify@kernel.org>
Date: Wed, 10 Sep 2025 01:30:06 +0000
References: <20250907080821.2353388-1-cjubran@nvidia.com>
In-Reply-To: <20250907080821.2353388-1-cjubran@nvidia.com>
To: Carolina Jubran <cjubran@nvidia.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, sdf@fomichev.me, kuniyu@google.com,
 kory.maincent@bootlin.com, kees@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, cratiu@nvidia.com, dtatulea@nvidia.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 7 Sep 2025 11:08:21 +0300 you wrote:
> ndo hwtstamp callbacks are expected to run under the per-device ops
> lock. Make the lower get/set paths consistent with the rest of ndo
> invocations.
> 
> Kernel log:
> WARNING: CPU: 13 PID: 51364 at ./include/net/netdev_lock.h:70 __netdev_update_features+0x4bd/0xe60
> ...
> RIP: 0010:__netdev_update_features+0x4bd/0xe60
> ...
> Call Trace:
> <TASK>
> netdev_update_features+0x1f/0x60
> mlx5_hwtstamp_set+0x181/0x290 [mlx5_core]
> mlx5e_hwtstamp_set+0x19/0x30 [mlx5_core]
> dev_set_hwtstamp_phylib+0x9f/0x220
> dev_set_hwtstamp_phylib+0x9f/0x220
> dev_set_hwtstamp+0x13d/0x240
> dev_ioctl+0x12f/0x4b0
> sock_ioctl+0x171/0x370
> __x64_sys_ioctl+0x3f7/0x900
> ? __sys_setsockopt+0x69/0xb0
> do_syscall_64+0x6f/0x2e0
> entry_SYSCALL_64_after_hwframe+0x4b/0x53
> ...
> </TASK>
> ....
> 
> [...]

Here is the summary with links:
  - [v2,net] net: dev_ioctl: take ops lock in hwtstamp lower paths
    https://git.kernel.org/netdev/net/c/686cab5a18e4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




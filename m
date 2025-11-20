Return-Path: <netdev+bounces-240291-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 89392C722D7
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 05:23:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9CDB534A7BA
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 04:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDBBE2D24BF;
	Thu, 20 Nov 2025 04:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oI+QTwEV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53962BD031;
	Thu, 20 Nov 2025 04:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763612510; cv=none; b=hw7AWxP/71B1YvZjoLqMFO36WDyxz039fGvGG1efszEUwysSAitR91otcHP6/QDqoBpvYsHNU2nNk9MXJDa4MaGy2jgC5/zH+AGhc4R3GE4U4px2RgcNIKRd3Y23+qxGvdlucYNPqtvbt2LjIkBPFvaHwMRyoBSsCvysKa6gyAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763612510; c=relaxed/simple;
	bh=yjK6BDnjzL5bblKZAJfxO3AozTNwkShgBad6/Jgxdxs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=j2Rol02PxPdeWKt9yuELkzMlp/tSK3bb7b05jY/krbLNYjWomSVst3HT2b8T7aWizqcROhrLgH1DWqTOasaleckpqssKiKdpa614iA+X3OLJppvOzmEnzF3Ew1f6Cmivrv6LEVw7GvaLe0kS9immmDYRt0IwV5lywHk1FZq62Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oI+QTwEV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D9DDC4CEF1;
	Thu, 20 Nov 2025 04:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763612510;
	bh=yjK6BDnjzL5bblKZAJfxO3AozTNwkShgBad6/Jgxdxs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=oI+QTwEVao6j+6GytTIT39wgNEkACzUuB+Kyk9A1py6+3fFzfzMEoFsh/D0ZbI+o0
	 tN9ofgXBH3rVfAF4ap2XaolWewvCk1/NxgPPld8E5krCrDrbBREPp6JSOLplzjd2wd
	 tILznxjSwU1GinI0IGgd1QxGc0J2t18OLP20IcXvBODJEpufjHxAbPuuh7cprDmiYs
	 VwK6lBN+rQWjGvDLWFbA4UNW4K8zx5GcZz4wV45sp+46KDu209RZNrGQ1pq+AQFTrE
	 8Yq6r9ox8pdyf0UVINhqfrgFYdIEmIN8o8XUsdpjmmCzAtxb+le6FTsLL48fE0cCt5
	 7yfve1awmMxAQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB1C939EF974;
	Thu, 20 Nov 2025 04:21:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next PATCH] octeontx2-af: Skip TM tree print for disabled
 SQs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176361247549.1075817.10718208559633760442.git-patchwork-notify@kernel.org>
Date: Thu, 20 Nov 2025 04:21:15 +0000
References: <20251118054235.1599714-1-agaur@marvell.com>
In-Reply-To: <20251118054235.1599714-1-agaur@marvell.com>
To: Anshumali Gaur <agaur@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 sgoutham@marvell.com, lcherian@marvell.com, gakula@marvell.com,
 jerinj@marvell.com, hkelam@marvell.com, sbhatta@marvell.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 18 Nov 2025 11:12:34 +0530 you wrote:
> Currently, the TM tree is printing all SQ topology including those
> which are not enabled, this results in redundant output for SQs
> which are not active. This patch adds a check in print_tm_tree()
> to skip printing the TM tree hierarchy if the SQ is not enabled.
> 
> Signed-off-by: Anshumali Gaur <agaur@marvell.com>
> 
> [...]

Here is the summary with links:
  - [net-next] octeontx2-af: Skip TM tree print for disabled SQs
    https://git.kernel.org/netdev/net-next/c/929ca3bceab8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




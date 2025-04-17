Return-Path: <netdev+bounces-183563-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EDE8A910F8
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 03:00:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AF554453C0
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 01:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F081E85626;
	Thu, 17 Apr 2025 00:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jxeVYZ3e"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C3B10E0;
	Thu, 17 Apr 2025 00:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744851596; cv=none; b=UGG1eom1mp2GRrnKoebnbmWOEkaWIdrSkalnvDAK3CA456z247RsmHrfK2ZJ0PdQ1+vt3cDKXQXTn4EnLwj6sgpVczssW4tz7XDFduaNnwxW1LFh45UWdp/3JUhdXQhLIbHLsb1hOD2snj90ES4RSaiADF9yGZXPqhdgWCIyOzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744851596; c=relaxed/simple;
	bh=67RXhtan4PvJfYzjmFdOzoEpY+oaXcOQN+1F2Nw8J5Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=N4FY6iHgnZ3JcE7PNcIAXb4H13nyIRlfF46/5n9syCx/hOUqh4mM5ogG2GfO0luA9CCozVsFGRctCEqkVnxqQAIthvt3hwxUYt+1B6nC+ZuULvwIWAqkd8da4VtCPt9pRxoW56qFa0SHZR2ZvOzaciPHvaUMpZ0BzxsC2+K9w8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jxeVYZ3e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33638C4CEE2;
	Thu, 17 Apr 2025 00:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744851596;
	bh=67RXhtan4PvJfYzjmFdOzoEpY+oaXcOQN+1F2Nw8J5Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jxeVYZ3evL/H3VlSYE0mQBMZgABn4q/JlO21qgxHUam38vihFX102lWhKWysCtAkn
	 ktjU6HXBA8iw3RpaU0m/XWA6wbN3Ye1XOtT7+6j/OAqsu/d2eYeqIptU5Um0h+YT+0
	 XXPEKNCba3VoRRJtBUL/uzflQU5KJsFaI4dG9/43oay5zhoMTeTRtG06PalX2HXaVz
	 GGSljjA0LauP+apJtV1Kwguc2BLXLS0K2jm7NPpm0pgquWzpS3I22sPQ2zHx+c3sJy
	 2T3DJ/RBzaZiXRUUkD4QV8VCLu827ean9qcCp/br3xOXPQfe+2ln9JSnDN/7OJVPJ2
	 UBM3GKa9EYuvQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 714193822D59;
	Thu, 17 Apr 2025 01:00:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net] cxgb4: fix memory leak in cxgb4_init_ethtool_filters()
 error path
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174485163427.3551658.3881939557825987516.git-patchwork-notify@kernel.org>
Date: Thu, 17 Apr 2025 01:00:34 +0000
References: <20250414170649.89156-1-abdun.nihaal@gmail.com>
In-Reply-To: <20250414170649.89156-1-abdun.nihaal@gmail.com>
To: Abdun Nihaal <abdun.nihaal@gmail.com>
Cc: bharat@chelsio.com, horms@kernel.org, Markus.Elfring@web.de,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, rahul.lakkireddy@chelsio.com,
 vishal@chelsio.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 14 Apr 2025 22:36:46 +0530 you wrote:
> In the for loop used to allocate the loc_array and bmap for each port, a
> memory leak is possible when the allocation for loc_array succeeds,
> but the allocation for bmap fails. This is because when the control flow
> goes to the label free_eth_finfo, only the allocations starting from
> (i-1)th iteration are freed.
> 
> Fix that by freeing the loc_array in the bmap allocation error path.
> 
> [...]

Here is the summary with links:
  - [v2,net] cxgb4: fix memory leak in cxgb4_init_ethtool_filters() error path
    https://git.kernel.org/netdev/net/c/00ffb3724ce7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




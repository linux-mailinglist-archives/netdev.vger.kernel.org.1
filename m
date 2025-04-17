Return-Path: <netdev+bounces-183571-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C67DA91115
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 03:21:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 835914475A6
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 01:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C95701C5F1B;
	Thu, 17 Apr 2025 01:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qKDEK7ox"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EFD41C3F30;
	Thu, 17 Apr 2025 01:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744852833; cv=none; b=doT9Ftfel4ASfJreeQz0l5Vi+2ChN1rpwLJKBPHtAdKiPhDTy/2Lu/oQ8L7LHvY0SQGalWber4eTWCfkIbxjI5k3bL/p3PjmQB07vfg4WFNaYeAubakU93XEOCu+e2lCNJ4hf5wMyZPCJFsFnUfVNTdRCu5/SPYFQL9qt2Lpxxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744852833; c=relaxed/simple;
	bh=L6OvPwC6RCY2Uw3n2Xw2djw6dfPOG9nzdZDx7dVQ4ck=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JaGQP4hgxLNFprqnPqZVu7BWoh6j4mQwJf/9D3KnrHwxXTtxn6aduyP70zvW2qzRTV0DjYgG0GAF1Qc9U7M1pq2hgba4Ukt56DkcY9ZDxYeGKVT/uGb3DwdA3pbrW+ricCDSyh5VJwyidEFsqd8/SmOHStFlslnlXTILb5sYHg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qKDEK7ox; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C180C4CEEA;
	Thu, 17 Apr 2025 01:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744852833;
	bh=L6OvPwC6RCY2Uw3n2Xw2djw6dfPOG9nzdZDx7dVQ4ck=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qKDEK7oxgQgcoXR20EA+TCy521Y/1HwM5dxhrKosPcqwQDdXR+7wewpeeH0Itw8nl
	 O6iF5dXBbbfcTm7J0zd1xpzAGwkjl7Qo1tx/VkhZi/bDe9XvbSip+Z5YmBDheJixY7
	 zYwvZwZb7bXGQ5aplc9sgWIao/K3+0W7REZ8v2a99decLZn/twDQtKr+NP+FLR7KU1
	 hv3g/XlJcx0Cm7Vg7SjgpR/s2lm35O7RkRAAB55rL/Ozu321MWwo+O+lPvAuBegHgc
	 HS2gRYT1Cfp6tJ4W9ncE9VLoOMDiLdPURxkxqj+FHizfKeQWKeoqpKfJglp1sVD8kw
	 3QN4yRfqRvuPw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE183822D59;
	Thu, 17 Apr 2025 01:21:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: txgbe: fix memory leak in txgbe_probe() error path
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174485287149.3555240.11283065360245029904.git-patchwork-notify@kernel.org>
Date: Thu, 17 Apr 2025 01:21:11 +0000
References: <20250415032910.13139-1-abdun.nihaal@gmail.com>
In-Reply-To: <20250415032910.13139-1-abdun.nihaal@gmail.com>
To: Abdun Nihaal <abdun.nihaal@gmail.com>
Cc: jiawenwu@trustnetic.com, mengyuanlou@net-swift.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 15 Apr 2025 08:59:09 +0530 you wrote:
> When txgbe_sw_init() is called, memory is allocated for wx->rss_key
> in wx_init_rss_key(). However, in txgbe_probe() function, the subsequent
> error paths after txgbe_sw_init() don't free the rss_key. Fix that by
> freeing it in error path along with wx->mac_table.
> 
> Also change the label to which execution jumps when txgbe_sw_init()
> fails, because otherwise, it could lead to a double free for rss_key,
> when the mac_table allocation fails in wx_sw_init().
> 
> [...]

Here is the summary with links:
  - [net] net: txgbe: fix memory leak in txgbe_probe() error path
    https://git.kernel.org/netdev/net/c/b2727326d0a5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




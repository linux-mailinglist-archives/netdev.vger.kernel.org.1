Return-Path: <netdev+bounces-214920-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 848EDB2BDAB
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 11:41:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C613D1885DFC
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 09:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A867B31197E;
	Tue, 19 Aug 2025 09:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RdmPfdaG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA84311962;
	Tue, 19 Aug 2025 09:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755596397; cv=none; b=f4IhoCSja3sqh3+RmyONqsZGqfGUOx1k1+eAyIHFuzrM2KMXU4tiumOhEcbdvKp3c5qwlFakY/EnR1OA7ICeOIkWhSEegFrlRZC81BtxhPYaxqGbHo/YZ38nv+srQ+PhAiP2kLYZZVSP53SUk8r70bt36m2YqPtPD3rSRSAw6dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755596397; c=relaxed/simple;
	bh=FEhAvhKTnQv5y2x3NKpeGdvP2hJtDaCHfPqTZIZ6rvQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pclmXs6clduq133G8/Dw8kl6r8VrwGzRWAe6tCy4oYkqruLmii9YOxGnUOXag6hvff97q5OkokdWCPqvxhMi48YhT2cz7odJli9mRhlC7akWLxvUN9CcOHq6gJLFJ8waAaNi6PPHJRx+rGPJEOD6/1RdHVqUMaKdMCkf3uAZpxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RdmPfdaG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0950DC4CEF1;
	Tue, 19 Aug 2025 09:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755596397;
	bh=FEhAvhKTnQv5y2x3NKpeGdvP2hJtDaCHfPqTZIZ6rvQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RdmPfdaGFo3120XMVXRqL52U4kuz0dp7frs5+C8PZWnDwffgZgBflKn+XIAG/+wi8
	 4sebaePZve5Ro63A95ayj0R9tTNBoDfpvexahTi64qUkP8V5VGl1jYW3We58y7IJxe
	 dbP2JN/7ZAFosq6J1eIyBeF9ysSh1vhvITuPoJxuFtFCyUlhlVUTmv93OwY1CXbV06
	 pnjYX4QVYBUy11txgeuMeyFdjQjdYolcJrdsXxKVWbdPeUb4PzvMFby6R5TEsmvN/L
	 6FDEULBjHGdHLTwGHPR34J52xFGvAnVXRkapDysNrx5WYdvQAzlZyO/ziPnVomg7xc
	 rl/tXJD5Eb5UA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D6A383BF58;
	Tue, 19 Aug 2025 09:40:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3 1/2] net: ethernet: mtk_ppe: add RCU lock around
 dev_fill_forward_path
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175559640702.3468407.17117186051389632839.git-patchwork-notify@kernel.org>
Date: Tue, 19 Aug 2025 09:40:07 +0000
References: <20250814012559.3705-1-dqfext@gmail.com>
In-Reply-To: <20250814012559.3705-1-dqfext@gmail.com>
To: Qingfang Deng <dqfext@gmail.com>
Cc: nbd@nbd.name, sean.wang@mediatek.com, lorenzo@kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, kuniyu@google.com

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 14 Aug 2025 09:25:57 +0800 you wrote:
> Ensure ndo_fill_forward_path() is called with RCU lock held.
> 
> Fixes: 2830e314778d ("net: ethernet: mtk-ppe: fix traffic offload with bridged wlan")
> Signed-off-by: Qingfang Deng <dqfext@gmail.com>
> ---
> v3:
>  Reorder the patch to be first.
> v2:
>  New patch
>  drivers/net/ethernet/mediatek/mtk_ppe_offload.c | 2 ++
>  1 file changed, 2 insertions(+)

Here is the summary with links:
  - [net,v3,1/2] net: ethernet: mtk_ppe: add RCU lock around dev_fill_forward_path
    https://git.kernel.org/netdev/net/c/62c30c544359
  - [net,v3,2/2] ppp: fix race conditions in ppp_fill_forward_path
    https://git.kernel.org/netdev/net/c/0417adf367a0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




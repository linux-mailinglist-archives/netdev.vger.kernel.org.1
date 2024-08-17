Return-Path: <netdev+bounces-119344-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94A8395546F
	for <lists+netdev@lfdr.de>; Sat, 17 Aug 2024 03:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A744E1C21670
	for <lists+netdev@lfdr.de>; Sat, 17 Aug 2024 01:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 491DD653;
	Sat, 17 Aug 2024 01:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TzjHAK4n"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250F7623
	for <netdev@vger.kernel.org>; Sat, 17 Aug 2024 01:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723856433; cv=none; b=M7/lEfjliSy4gXDmIzSUFXpjoQRvumxbpWojnEAICmWUTA4kd5naNVXACrW98bQ/yHAOS4qtHVEc/rJeS0cBKajM3Vnr1G//VIeUtHwQYOHjHeGv6OxdH9lBkYFM6yaiZvgRVuLIH227oSp/pNbYIUAneuwyu7quAYRUpb7p01o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723856433; c=relaxed/simple;
	bh=PT3kNefJ7B6ma2kRFzojUUax2x6VzLCdWV9HQ7xbQ04=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gDFTZaEnQbQQVKnBSqztqtj06hSRZR1Jrl/Sss9DyxINEALvYnl97ad7l0T+dB0oAm9caasCSkvZj3cn/PjHG2H964xjksVoyjo3R/2PNFN4J9ApzDEy4u8+K2gRt23Bwubeqc71sfyon8+rlnpUJ3ggT65g4ZMgZGi0GCsKV8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TzjHAK4n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACC64C4AF09;
	Sat, 17 Aug 2024 01:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723856432;
	bh=PT3kNefJ7B6ma2kRFzojUUax2x6VzLCdWV9HQ7xbQ04=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TzjHAK4nR/FUjVePZ62vdryQ/Y4CEDl01rv/Xss9BdDT3MiJw64GMUZMF0nJhOEGI
	 In3Vv/tIsQOagqPOmX4mc3BxXksgUzDEVIvtO2Xln7dWXHnYGgeTLfCz7ZBo3XsQFV
	 2S4SLpD2gaoBdXjwCPOkill8fzMmCWYm8Mj7UbdjvWvMGgxjP+BOoZoImSfZ4t7eWL
	 3c7HffO+Is0TC6lCISL2QKIMAEU1Cuv4V8zyD9Etc+LEtuBAv5DTJ24rGGg9FgW4a+
	 tIcyV5dV8zTzNiZb/f6vJiBeteCMWez7hBFqsHku7fUrR0+IGaBvHnGKcVEg2kcezX
	 USvEkJ1AMRpzg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33EC438231F8;
	Sat, 17 Aug 2024 01:00:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH netnext] mpls: Reduce skb re-allocations due to skb_cow()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172385643203.3669696.15606969328431040309.git-patchwork-notify@kernel.org>
Date: Sat, 17 Aug 2024 01:00:32 +0000
References: <20240815161201.22021-1-cpaasch@apple.com>
In-Reply-To: <20240815161201.22021-1-cpaasch@apple.com>
To: Christoph Paasch <cpaasch@apple.com>
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 kuba@kernel.org, davem@davemloft.net, roopa@nvidia.com, cmtaylor@apple.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 15 Aug 2024 09:12:01 -0700 you wrote:
> mpls_xmit() needs to prepend the MPLS-labels to the packet. That implies
> one needs to make sure there is enough space for it in the headers.
> 
> Calling skb_cow() implies however that one wants to change even the
> playload part of the packet (which is not true for MPLS). Thus, call
> skb_cow_head() instead, which is what other tunnelling protocols do.
> 
> [...]

Here is the summary with links:
  - [netnext] mpls: Reduce skb re-allocations due to skb_cow()
    https://git.kernel.org/netdev/net-next/c/f4ae8420f6eb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




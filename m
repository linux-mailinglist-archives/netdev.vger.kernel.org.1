Return-Path: <netdev+bounces-213902-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C038B2746C
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 03:02:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6811F1CC38C2
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 01:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9133D1946A0;
	Fri, 15 Aug 2025 00:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PFj5Cax5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2F01339A4;
	Fri, 15 Aug 2025 00:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755219599; cv=none; b=oKvHJZN+APlODc981trAKUyljLS0NzRlBM+/dw+C37S6+9zNRFWSUGXh2MSkVoC8bE4e/am6mX5r/o8TQjyLYKgeWwltCKnUHcKPhmuEb+ItLN2CW10+5elY0YujHohqkZWVfdE0Cku7eTbanWjdz3MqZV9EWb694Y/jHtYtIgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755219599; c=relaxed/simple;
	bh=fXq9fYQr5b0Htc34Fxa4t/6wP2OfZ0Z+9tGwZ93bS0Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YhUlSYavZfW2SSJUOYYZGsL5wR8eKVDgOYQixYilGDbaJ/G4mDD9HR/mblcyECGdLa4xVEYG5iYUag6lXJcjf88xAvhAxv8WJG0r63z2pC2tCF1QsaV0wZQ8G/LXu0Z/93UeQOkmM3nGN130CR4NcGaiShDb3rTtuh7P6zCVIos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PFj5Cax5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA20AC4CEED;
	Fri, 15 Aug 2025 00:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755219599;
	bh=fXq9fYQr5b0Htc34Fxa4t/6wP2OfZ0Z+9tGwZ93bS0Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PFj5Cax5HCVL/itTPnc0WZqZ6f4531EzeiKqtmDXbeeewYVA3OGW2RDR5PsXP/gix
	 GT78ZUVWIlNAd5Ed3kh8NoEZH6m3QiOLQeYIFmRUxxB0hQty96xDfDEJJvHLlezTMB
	 /w2MtIloFXhPAMVPixXbjFNL5W+RP9wIbFfap7vi3rBE20g2Z3V7Uivs2fhjTgXdF2
	 TWDlTp7vYGUbqx4fe34Y6g3tUBrq4HWIAxXkxtSdAZveQBWTn9F0g6IzegA3Xl1ioE
	 KXuKvxp/7SO3DAZCALkvdCoE07Y71FH8qZ0rKOlHNMacstg59eHm4WOyPYBn5fbQGh
	 hduetEM5qfaIQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E6439D0C3E;
	Fri, 15 Aug 2025 01:00:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] sfc: replace min/max nesting with clamp()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175521961017.502863.2162622592450676762.git-patchwork-notify@kernel.org>
Date: Fri, 15 Aug 2025 01:00:10 +0000
References: <20250812065026.620115-1-zhao.xichao@vivo.com>
In-Reply-To: <20250812065026.620115-1-zhao.xichao@vivo.com>
To: Xichao Zhao <zhao.xichao@vivo.com>
Cc: ecree.xilinx@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-net-drivers@amd.com,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 12 Aug 2025 14:50:26 +0800 you wrote:
> The clamp() macro explicitly expresses the intent of constraining
> a value within bounds.Therefore, replacing min(max(a, b), c) with
> clamp(val, lo, hi) can improve code readability.
> 
> Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
> ---
>  drivers/net/ethernet/sfc/efx_channels.c       | 4 ++--
>  drivers/net/ethernet/sfc/falcon/efx.c         | 5 ++---
>  drivers/net/ethernet/sfc/siena/efx_channels.c | 4 ++--
>  3 files changed, 6 insertions(+), 7 deletions(-)

Here is the summary with links:
  - sfc: replace min/max nesting with clamp()
    https://git.kernel.org/netdev/net-next/c/6398d8a856fb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




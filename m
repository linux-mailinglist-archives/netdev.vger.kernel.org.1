Return-Path: <netdev+bounces-191215-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A41F9ABA656
	for <lists+netdev@lfdr.de>; Sat, 17 May 2025 01:12:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95D8B1BC031A
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 23:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CE732820CA;
	Fri, 16 May 2025 23:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u1yB2tA/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352722820C2;
	Fri, 16 May 2025 23:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747437010; cv=none; b=aAbyU69nnXnnPzPjwxrUuqliCyOf5STWlYEKM1rNaHpVb1z6xYLo0ZjbmYDfFnqh2uoB4pb0kzN3n3JMUxlsmq9k/asPe7EM/7Yzkt9XzinSkVNyu+zwL0EY8UlILT6xwTTQlyQ8XNGzMk/ucnTZTh12aZzUIGkIKdYES48LwvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747437010; c=relaxed/simple;
	bh=fLGlK3kQAkfnWppM9zXW6WE3h3EJypgV6YfdG89gUkU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=n1y7qaE5dX8L62+ep+NvS6jiZAWE7qCJCG7fRIf/K+SofQujLaPNCnia4x4voja0wV1bCIbk2+p0XYYY9BqHFP3K5LJjVlhobXAuGE/WckF/x3gIO2dQXwzFgj5Lw3GzAL3ZS7hFK97JZOFpSUeol3+buFQua5GQwDxYot9NvxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u1yB2tA/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A23B0C4CEE4;
	Fri, 16 May 2025 23:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747437009;
	bh=fLGlK3kQAkfnWppM9zXW6WE3h3EJypgV6YfdG89gUkU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=u1yB2tA/kI0fUaj8euJpfOF6B23hRsV5B2GeWEVE57/cE++36Xv3eM6YsZnARo4k1
	 q3+uvFVMwD43a0esX+ZxVy0IdzBBNMPb4ct1iQMxBGX7Z3H3PEo1wKZ32h+ow1Ln5V
	 FlhwOv9XKL05qW/aP6z9zeD30PV2rUcxLKL1IlchXJEmm+93r+ruc0JOJ+ToEomFdj
	 j9MPJ5x9FygI1Qqhi03afCTtC3PUR/4Qag6lWwRNQv7LkgtT9oBN7yZvtj7FGw8sjd
	 tFVfj2i0IhDBXE+5JiCEGwFdYE8MykY+xDQNftzv6psDc8V9lA3Jq3pfBvCPeQIl+P
	 sGKuWYRdushag==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADF343806659;
	Fri, 16 May 2025 23:10:47 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3] net: dlink: add synchronization for stats update
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174743704624.4089123.10955186807105920786.git-patchwork-notify@kernel.org>
Date: Fri, 16 May 2025 23:10:46 +0000
References: <20250515075333.48290-1-yyyynoom@gmail.com>
In-Reply-To: <20250515075333.48290-1-yyyynoom@gmail.com>
To: Moon Yeounsu <yyyynoom@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 15 May 2025 16:53:31 +0900 you wrote:
> This patch synchronizes code that accesses from both user-space
> and IRQ contexts. The `get_stats()` function can be called from both
> context.
> 
> `dev->stats.tx_errors` and `dev->stats.collisions` are also updated
> in the `tx_errors()` function. Therefore, these fields must also be
> protected by synchronized.
> 
> [...]

Here is the summary with links:
  - [net-next,v3] net: dlink: add synchronization for stats update
    https://git.kernel.org/netdev/net-next/c/12889ce926e9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




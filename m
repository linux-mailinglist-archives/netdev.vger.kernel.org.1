Return-Path: <netdev+bounces-246809-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 69A31CF1402
	for <lists+netdev@lfdr.de>; Sun, 04 Jan 2026 20:16:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6524C3004403
	for <lists+netdev@lfdr.de>; Sun,  4 Jan 2026 19:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D2E5314D2C;
	Sun,  4 Jan 2026 19:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MyFSyq72"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A47C314D29
	for <netdev@vger.kernel.org>; Sun,  4 Jan 2026 19:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767554176; cv=none; b=Kr+r5exUQY/49HOGx/c2dz0Tc2EzJR/tRu5mymKU0wGtcJDGGe/bN+NajaY2C46+BNzecW8BCIy8uD0zKZFuVcY1vj62CvtLqRFA+Uu6KElewzFYkgOfjoW8/8rRV2NljhQBVDcXycI44ZGw1ly9QSXb1CNaNMrSLLUK7HT9ndE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767554176; c=relaxed/simple;
	bh=pJrCo0vRWJR63czLDU/CRO5SnwTldCOD9Vw3yVo+bFY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=H0nW+rBBATYzPMYFecfG9vfrg38nbUU/zZXERPUzYT5edJBubSob9kCKKpk/fhFxLQWwL1tJBAw4xdVF4uoaQajr/ZSR5+jhhPea+I9S/bQ04eTO64l+cjjUt1n3OxeEjiC90Z4pCFwLUBX4OGWhdZbhKiJzPEI1gjefkL5emz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MyFSyq72; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 618ACC4CEF7;
	Sun,  4 Jan 2026 19:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767554175;
	bh=pJrCo0vRWJR63czLDU/CRO5SnwTldCOD9Vw3yVo+bFY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MyFSyq728XYGupchcrJJGcSqXqmVObKF5fke/3NN1jNxa2rBWVAA0I9njKJYhnn4/
	 WupSzHwb1oeFMmd/DzLH3lBFSn77DjeffZUkHHK1Il2bUxPWsWQqXkiKzNX0LMtiIv
	 YfTbKOt6COv1raCzh0cSbqpnK0gcLVmbcvaDJ4/LNBBJQh/f0UkU0TZ77ui4T/45NH
	 98I+/qcXFk7FUNA7aOy/PsqJfdP3/HVGARFWCWdj1hrNjR94VbSv9tVJz/VQEuL62a
	 Xw6g00TBMorOOxvbsihjPUShAermhx+y9MktcIBbZ5sUA4I4aLXyHnO/kdkNtFhz1S
	 pGwKGr4joAxYw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 78897380AA4F;
	Sun,  4 Jan 2026 19:12:55 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] netdev: preserve NETIF_F_ALL_FOR_ALL across TSO
 updates
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176755397428.149133.14254102218932411732.git-patchwork-notify@kernel.org>
Date: Sun, 04 Jan 2026 19:12:54 +0000
References: <20251224012224.56185-1-zhud@hygon.cn>
In-Reply-To: <20251224012224.56185-1-zhud@hygon.cn>
To: Di Zhu <zhud@hygon.cn>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, andrew+netdev@lunn.ch,
 netdev@vger.kernel.org, lijing@hygon.cn, yingzhiwei@hygon.cn

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 24 Dec 2025 09:22:24 +0800 you wrote:
> Directly increment the TSO features incurs a side effect: it will also
> directly clear the flags in NETIF_F_ALL_FOR_ALL on the master device,
> which can cause issues such as the inability to enable the nocache copy
> feature on the bonding driver.
> 
> The fix is to include NETIF_F_ALL_FOR_ALL in the update mask, thereby
> preventing it from being cleared.
> 
> [...]

Here is the summary with links:
  - [net,v2] netdev: preserve NETIF_F_ALL_FOR_ALL across TSO updates
    https://git.kernel.org/netdev/net/c/02d1e1a3f923

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




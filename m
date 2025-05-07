Return-Path: <netdev+bounces-188525-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B330BAAD319
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 04:10:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EED327AFE68
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 02:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED2EA18DB29;
	Wed,  7 May 2025 02:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U0E1MJ+D"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C514B18C01D;
	Wed,  7 May 2025 02:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746583800; cv=none; b=jWkPnSmqxpy/qWTe6pS7QojsjQY21m7/nMg9/UW03ULJ2lJpnoJDlckdUWRgbYzpm2c/v5+kAHDFIQWlO+0u9wQJxJj6dL7LDOTAbjTEhGN6kzAu6kw+/sRItszPSRfinCQl/QUqBGL+dFtV4ucKbmBkR3OWk5y+1bPUoePCvNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746583800; c=relaxed/simple;
	bh=oEEDp+2Y0WUeQxIRduaIuRUjSY0AwAcy6BpWMhiCM9o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qtoTHxUgFK7l6rKno0i4VK+8b1Y2tl+SSIr5I2ZKGO3c+H1t4mmWPr0RPzfrAWF8HUEj5GSVoVIlaq49gQDVqdM0T9FinFgOlRsWSICuA3Doqlg0PPxTCsBSWezf+udGbNheQCObPP4E9ycsxSPTAr/B1dfQDKUV3JpAeod3VAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U0E1MJ+D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D73DC4CEEB;
	Wed,  7 May 2025 02:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746583800;
	bh=oEEDp+2Y0WUeQxIRduaIuRUjSY0AwAcy6BpWMhiCM9o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=U0E1MJ+DaEt63UpJEjUwaM8YLJHE8z7cZpfXlv+0UrhXCCXoDewlXeoqTc2/eO0d+
	 aJC0W2YBc4ycS00gyztqXlDb1LI9v895+XcGLitmfe4PwuRv7dLbOPzVWs+41fT2aR
	 rSH1wA6AzwVkc425KGZ1AvZ+bFVY/Hd09yAZHqknwoR0l6HO8qNp5rkzhN39t/iFCM
	 80D/z5xZk/yQj+eifWwoJCnkD3DuqxOHZaW1gUCqbthGNxbqLXhU6zzTRdM3EbQ5Gc
	 Fis96tJ0QUHpFpPp8cwb5sVI8f1WaDpG54D5y6XXNe3jl8TKxjsdr2Cpr1YxzS8y4V
	 xbdfNKT00isjA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71707380664B;
	Wed,  7 May 2025 02:10:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: add missing instance lock to dev_set_promiscuity
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174658383899.1710027.3440544946446238229.git-patchwork-notify@kernel.org>
Date: Wed, 07 May 2025 02:10:38 +0000
References: <20250506032328.3003050-1-sdf@fomichev.me>
In-Reply-To: <20250506032328.3003050-1-sdf@fomichev.me>
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, andrew+netdev@lunn.ch,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  5 May 2025 20:23:28 -0700 you wrote:
> Accidentally spotted while trying to understand what else needs
> to be renamed to netif_ prefix. Most of the calls to dev_set_promiscuity
> are adjacent to dev_set_allmulti or dev_disable_lro so it should
> be safe to add the lock. Note that new netif_set_promiscuity is
> currently unused, the locked paths call __dev_set_promiscuity directly.
> 
> Fixes: ad7c7b2172c3 ("net: hold netdev instance lock during sysfs operations")
> Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> 
> [...]

Here is the summary with links:
  - [net] net: add missing instance lock to dev_set_promiscuity
    https://git.kernel.org/netdev/net/c/78cd408356fe

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




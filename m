Return-Path: <netdev+bounces-228643-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E1826BD0969
	for <lists+netdev@lfdr.de>; Sun, 12 Oct 2025 20:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 97F564E8EEB
	for <lists+netdev@lfdr.de>; Sun, 12 Oct 2025 18:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FA3F2F068A;
	Sun, 12 Oct 2025 18:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CNPT7fVr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742B72F0671;
	Sun, 12 Oct 2025 18:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760292622; cv=none; b=niFEghS3hSm7ypmQgG8YP65sKOjMAsFRrr5aOjieefWdUkrSsVo5anmoHScmgzyinJ/nJb5LQKyhuiUzmbv4QIzUuvwVJQlUJ58MC45234wSVZ5BL7QaLwqNGyd7fmXqYFTWYMv4CtscaxwYkfekb18qJa+VW7xg1UEURmcOvp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760292622; c=relaxed/simple;
	bh=Bf9o7fzVWGjNhFlkfO4B2mnn67HO4oP8bajh2Zds0IM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OCoDflyixKIZdjuWlXAFi2o7GhHrNQKltW2hUKgxhdw6YgRxO6VKYAs3gEVVVQn0WND0MjhIEo2LTLw8YOsaMCsHA+U+ETdHeYNILDp73Qfj0nZAXgojY0DR3vIakaN86FY5WZkbyMGNPccrSfm99baqRCz60ub8gX95ZqOr+pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CNPT7fVr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E064BC4CEFE;
	Sun, 12 Oct 2025 18:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760292621;
	bh=Bf9o7fzVWGjNhFlkfO4B2mnn67HO4oP8bajh2Zds0IM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CNPT7fVr6rBAVfYXC8UFwKlLLrQfKWNHN0WmuWJaDP4P90D2E9iyg6k0ai0SPh0pH
	 F7h+AjJn7uIJ/2R+veqJahqDkXnEgyfvlP4JdoNQ6sdCI6CO3O2dnCwpgCkgGUdpTE
	 IgKwYGmnLwdRGQz77yFSTPTWo9XT2S+kV09ojuMkDinS4wd9gMISrdJ1ubrb+ESxfx
	 2THieOoMn0lQ5xjhMQOCkO/w5hWwb66+lbmxB86UduhKkWtNnuH6HIuHRxRc3lM79c
	 BOF5t+MeUakPwxQ8tqJ/W7CsAteqzHtj0ltGPkvmt82qtp89d69dK41e607gcLHIku
	 VF7My9prxPkLg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C773809A1D;
	Sun, 12 Oct 2025 18:10:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: dlink: handle dma_map_single() failure
 properly
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176029260824.1713934.10258751667407282656.git-patchwork-notify@kernel.org>
Date: Sun, 12 Oct 2025 18:10:08 +0000
References: <20251009155715.1576-2-yyyynoom@gmail.com>
In-Reply-To: <20251009155715.1576-2-yyyynoom@gmail.com>
To: Yeounsu Moon <yyyynoom@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, horms@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 10 Oct 2025 00:57:16 +0900 you wrote:
> There is no error handling for `dma_map_single()` failures.
> 
> Add error handling by checking `dma_mapping_error()` and freeing
> the `skb` using `dev_kfree_skb()` (process context) when it fails.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Yeounsu Moon <yyyynoom@gmail.com>
> Tested-on: D-Link DGE-550T Rev-A3
> Suggested-by: Simon Horman <horms@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net,v2] net: dlink: handle dma_map_single() failure properly
    https://git.kernel.org/netdev/net/c/65946eac6d88

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




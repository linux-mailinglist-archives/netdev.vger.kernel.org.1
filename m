Return-Path: <netdev+bounces-245333-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2046FCCBB06
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 12:54:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7883830213CC
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 11:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC17A328620;
	Thu, 18 Dec 2025 11:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UH0Q066l"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19B432826F
	for <netdev@vger.kernel.org>; Thu, 18 Dec 2025 11:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766058797; cv=none; b=HXSvQemHMkwuFK1DfnyCNAt2FitdbqUX3zDbws5n3CHxjl2AJIEUFP9Ywt3aHnVC/r/qEemkoNhfxYjzG1TBE6cvoBvyYXD92Nhe/Zine86mKnFOOpu5C7sbDuCJBf2QyB7mCfTBxCJ8NJDkAzW58Rar8UbqIjXW1XO2lJtaicI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766058797; c=relaxed/simple;
	bh=CBMSe7oWkvz04hoVz9hhsfhH+MQq8eHNt2suhlpqMbU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=k+1eqg820pvbVYcwWHkyxZcBWkpE/ztJzPDFe/3sdSYsgC1NGrT65iLhWNZJNwgsR5rqOxeu0C9Isq8vyZfhKBgvOvZtce0tHegAEpVMeaE2cDwoklF5q9hn+WZTEhKfj8m0ueyKMdn+LQ7juopmJheuTQMbCzdaHuwhxuyUGTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UH0Q066l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4472EC4CEFB;
	Thu, 18 Dec 2025 11:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766058797;
	bh=CBMSe7oWkvz04hoVz9hhsfhH+MQq8eHNt2suhlpqMbU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UH0Q066lLVb/GgLPa/2jqs97WVjonztwz/CfHhu3axkRsddDtT+BuJ5ocawhJuNpd
	 gscin6oN8E3fnvbS/TrZzo6s8DBKHQKTuRypYZJHvvT1/J61O5WATcvwE9JqChqMCl
	 i56ekFnfUiul9Q/tkXzf9Qf6brd07k1L92A7ezChPrc4WL19QWgC72oGy2qNq2ViXZ
	 aTKHZCZIQSdRBpO4nEdGQ1crAsyL0niQf3/qA1EGu9rl90UfinO9NLSDS9eLCQ83Js
	 aR+gSFI4eY8AtPTemxhbVWUucMoSkv9IO0i8CYpxFb4oRPrqu6yf81OS/VEzoF9RiY
	 eKdhm+jKTcIqw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F2BCB380A945;
	Thu, 18 Dec 2025 11:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] ethtool: Avoid overflowing userspace buffer on stats
 query
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176605860680.2917136.4856127251413117124.git-patchwork-notify@kernel.org>
Date: Thu, 18 Dec 2025 11:50:06 +0000
References: <20251208121901.3203692-1-gal@nvidia.com>
In-Reply-To: <20251208121901.3203692-1-gal@nvidia.com>
To: Gal Pressman <gal@nvidia.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 andrew@lunn.ch, horms@kernel.org, dtatulea@nvidia.com, tariqt@nvidia.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 8 Dec 2025 14:19:01 +0200 you wrote:
> The ethtool -S command operates across three ioctl calls:
> ETHTOOL_GSSET_INFO for the size, ETHTOOL_GSTRINGS for the names, and
> ETHTOOL_GSTATS for the values.
> 
> If the number of stats changes between these calls (e.g., due to device
> reconfiguration), userspace's buffer allocation will be incorrect,
> potentially leading to buffer overflow.
> 
> [...]

Here is the summary with links:
  - [net] ethtool: Avoid overflowing userspace buffer on stats query
    https://git.kernel.org/netdev/net/c/7b07be1ff1cb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




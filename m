Return-Path: <netdev+bounces-215130-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F3C3B2D259
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 05:12:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1394A7B129A
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 03:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55E2727B35B;
	Wed, 20 Aug 2025 03:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="loWF6bM6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324C527B352
	for <netdev@vger.kernel.org>; Wed, 20 Aug 2025 03:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755659475; cv=none; b=KShFyVYp8YiGjDy2r8758gtLBH2oo8A1GEmz9yNKAO7OKe3bPikaUgnTraJ3BNUZXAzFaVsL3cZdQhfwuFNbaRkaY+USewI3XiiOLJrTdt0jEweqEdRJ7lLROPoYiE26fQEy+XULJaTj8fUv00cS0a44t2tx+/tR3bi9z0BJV50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755659475; c=relaxed/simple;
	bh=j/uEqeLsfXO+jex/Y343OyBxmHKDGrMmZb/YuuriVR4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=V8Nq4ecAb7gYjGnzH5ciZ5hfu3bQRO29+DHMnXWGp9ZdQ5tGH9oJy9caJMeGZanhNkQINxIxsrSn4T1GJB5fT+jNRjt0QVVxnnJ/WrwpV7yuPFIKvNgz9UYYNHNBzMBm9Qf6R/us0cgF2roTRrjacNG8nBaLKp7/aqXe70/u4N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=loWF6bM6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB33BC4CEF1;
	Wed, 20 Aug 2025 03:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755659474;
	bh=j/uEqeLsfXO+jex/Y343OyBxmHKDGrMmZb/YuuriVR4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=loWF6bM6ssIft3hFoiq4+NqbcJradrtiNgTObJGkaemycjos7dzDL6lW8xCDkyVEU
	 RKXi2t0uj3SUinMr2tDYNbizrvpAWVBh0wgpsuEF1C6rJik2FRZ3M0hpw9p2PEQa3d
	 l5vMjhc08YIyIvdRiiTABJ0cHOlF157eSmS9jsDki3pJeKyhveY5O6PWwKRU0OG0HC
	 uXkAskG3PWdEijUyGOfMOjgqJ2o2GyOJWBfWuUQA+4A83qu0SbIZO3RLVjb8yfMrwF
	 MDqjam4MGjEQxpeXZxCoPsKxktwzTPQQh4zluYTL4jeHyWBu9u3tqDFhnxCThz0joO
	 HCAa9V6VdVTAg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD53383BF58;
	Wed, 20 Aug 2025 03:11:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] gve: prevent ethtool ops after shutdown
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175565948428.3753798.10388624355230627134.git-patchwork-notify@kernel.org>
Date: Wed, 20 Aug 2025 03:11:24 +0000
References: <20250818211245.1156919-1-jeroendb@google.com>
In-Reply-To: <20250818211245.1156919-1-jeroendb@google.com>
To: Jeroen de Borst <jeroendb@google.com>
Cc: netdev@vger.kernel.org, hramamurthy@google.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, willemb@google.com, pabeni@redhat.com,
 jordanrhee@google.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 18 Aug 2025 14:12:45 -0700 you wrote:
> From: Jordan Rhee <jordanrhee@google.com>
> 
> A crash can occur if an ethtool operation is invoked
> after shutdown() is called.
> 
> shutdown() is invoked during system shutdown to stop DMA operations
> without performing expensive deallocations. It is discouraged to
> unregister the netdev in this path, so the device may still be visible
> to userspace and kernel helpers.
> 
> [...]

Here is the summary with links:
  - [net] gve: prevent ethtool ops after shutdown
    https://git.kernel.org/netdev/net/c/75a9a46d67f4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




Return-Path: <netdev+bounces-247548-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 62743CFB9B3
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 02:36:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BC0FD30773B1
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 01:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3059B212F98;
	Wed,  7 Jan 2026 01:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="amN2SZbJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC911EB9F2
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 01:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767749612; cv=none; b=R2jmFFqv7/hIRGxYlwph976i+PgjRGvmH6ag4N5WssE8YU3IgzO9ehND/1Xz54R4JEzCfEkDD06SNrL6jkWI4VfbsfDZaoHYB4z5JZaCtVxWqjYfD2gsje77N2ZRjIQEbrlzQkTj8vhbFSkW1j46o/e+abTaZjfOaPFcsPPaV9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767749612; c=relaxed/simple;
	bh=gf05+X/ivFtITXaufAfMJ2UWAdtB4Z9Kzm+Me0X/4r8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lIjyNWTQwCSC79rAVrKsAvw5HVXQtuFT1dWxfthz8JZ2NPumPMu3atsRlApi6B8E830fG25RABZZpx/hjNFiKh1zQOFlowDi/cSWb7D01O4cmLWK67exPobMGqkfTK7wigcS0NMO6KxjBV87+AGyrFUCwqx05HVHOaALp4HVn4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=amN2SZbJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84F45C116C6;
	Wed,  7 Jan 2026 01:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767749611;
	bh=gf05+X/ivFtITXaufAfMJ2UWAdtB4Z9Kzm+Me0X/4r8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=amN2SZbJTS/7yl8/H+30ZZTGxa22UseTUvrPfyLm53JXGXUn7HwbEgSfevA8DADES
	 FUlMnwkyHYH0+4bB2Zkn2N2n7Hi5rQUwI2Id6PKXD/hzAWCh7RpXsvF7hTjEsbSmmW
	 b0eOgHfpeiGSOuVcw+8p3WrTCrBpXSrdI9xeAtXjxPkfZFZYgf0luudLxlJYqb+CLW
	 4JYWbcHeZ9dARZmifBzy00pQWIi8w0gFYBEoOtNmtBIpH/TRt0YjDOPNuET4zKYjQL
	 bVn10lb6Kprb6zVQfIzUXmTPwZD7keP5So+wAGom5N8QMKtNy1V34fi6YGhnY+UOwH
	 tN6etmRC4FL5g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3B6DF380CEF5;
	Wed,  7 Jan 2026 01:30:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: fully inline backlog_unlock_irq_restore()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176774940904.2191782.13780914287615728174.git-patchwork-notify@kernel.org>
Date: Wed, 07 Jan 2026 01:30:09 +0000
References: <20260105163054.13698-1-edumazet@google.com>
In-Reply-To: <20260105163054.13698-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  5 Jan 2026 16:30:54 +0000 you wrote:
> Some arches (like x86) do not inline spin_unlock_irqrestore().
> 
> backlog_unlock_irq_restore() is in RPS/RFS critical path,
> we prefer using spin_unlock() + local_irq_restore() for
> optimal performance.
> 
> Also change backlog_unlock_irq_restore() second argument
> to avoid a pointless dereference.
> 
> [...]

Here is the summary with links:
  - [net-next] net: fully inline backlog_unlock_irq_restore()
    https://git.kernel.org/netdev/net-next/c/27a01c1969a5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




Return-Path: <netdev+bounces-200090-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB376AE3141
	for <lists+netdev@lfdr.de>; Sun, 22 Jun 2025 19:59:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 522CB16CDB4
	for <lists+netdev@lfdr.de>; Sun, 22 Jun 2025 17:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AB001DE3C8;
	Sun, 22 Jun 2025 17:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nP2t09Kh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26EFA1632DF
	for <netdev@vger.kernel.org>; Sun, 22 Jun 2025 17:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750615179; cv=none; b=SAh8MQKm6+Nf+KltUR3nfVWPeTIXJs9J7KZRTDRdvooiPNQpRlLFA+v0MuOC+/nYT/grQ2ginA30++ZYkZ1DnAyZieF5mOD2Lkfiee6YD6G0sLJuUbYJ6XK7zhOuNdO8fv/G1et6q2f+pFYWIjrxUIlYk1c68Y7b658mKdZTo8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750615179; c=relaxed/simple;
	bh=9inf9n5DK3cQGAHk184lBUbD2YO/HARJStraQgI78sU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Kny82nyeyRK8GwnSIe3WRdmnI6GZudZgcYXRRNFLOBBoY+tOitjQb77otf7wc/QPQResx+PhFvaxeI4nGAGSXAsG5Ks4CswnVvhQV+g+WVXmCEA6gMu+kpMrxc3xdJB/FpBo68tJJczbCodjOte6FdciEafj1OlCvxtSaMMHcUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nP2t09Kh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F7C2C4CEE3;
	Sun, 22 Jun 2025 17:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750615178;
	bh=9inf9n5DK3cQGAHk184lBUbD2YO/HARJStraQgI78sU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nP2t09KhSzt6nfxAUAl5aEHDtfXE2OS+OleCP78diTzdW+OJxv772HQd14x4Ndg1z
	 2tutreuoPmgdcpoM5ZaiIwkK7pbMbGikqFhOJgMTxmNzt5URcASqhIK545zkh6Wskp
	 +21TBMdBKnKP2dAAjJtTM49zIxGOO7YtCVxbBJ7xEXvuWV56saetqBWo0/K6ZEjw5+
	 hx63rfAsshEo+oh44bQ/Bxke5f8DFG3Vdb/a+u7MeeKxD3ErLdYTYreu4EEfvobkPn
	 jOGMJNTdwUecwdfbaH/rxPTWwStZhJIZo/5n3QkS9odigz3CH5dLLnaBDaPQnYbj/z
	 6EdMV+J7gOgzA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33A4339FEB77;
	Sun, 22 Jun 2025 18:00:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] netdevsim: fix UaF when counting Tx stats
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175061520600.2114191.5131049195469929198.git-patchwork-notify@kernel.org>
Date: Sun, 22 Jun 2025 18:00:06 +0000
References: <20250620174007.2188470-1-kuba@kernel.org>
In-Reply-To: <20250620174007.2188470-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 leitao@debian.org, joe@dama.to

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 20 Jun 2025 10:40:07 -0700 you wrote:
> skb may be freed as soon as we put it on the rx queue.
> Use the len variable like the code did prior to the conversion.
> 
> Fixes: f9e2511d80c2 ("netdevsim: migrate to dstats stats collection")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: leitao@debian.org
> CC: joe@dama.to
> 
> [...]

Here is the summary with links:
  - [net-next] netdevsim: fix UaF when counting Tx stats
    https://git.kernel.org/netdev/net-next/c/5e95c0a3a55a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




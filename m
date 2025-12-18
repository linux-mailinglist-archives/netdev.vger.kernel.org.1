Return-Path: <netdev+bounces-245379-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 42724CCCD4C
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 17:42:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D1F0130239D3
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 16:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1798435C1B6;
	Thu, 18 Dec 2025 15:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l/x8UaAb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6DB735C1AF
	for <netdev@vger.kernel.org>; Thu, 18 Dec 2025 15:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766073202; cv=none; b=Hsrv3dsRM58tFQFO3XV7KCD7CaP8BXUlTvZuVj9m5LnT5ocG00+gOMj/xN7p06MnveVfYcoKm2x5tlr4iPzaQZCWUvOq1Np6oTPDWU2AuP8HQH+zLESOr2uPMCDgCicO+1zl3wG++1gUpwqqCm9JqeK6X9FqT5tLRVBwHFn8f40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766073202; c=relaxed/simple;
	bh=3e8zDr0N01tgUjErJ20SpEaudHEKPjQXUee4G45xszU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=t8eMOlxPQgM2NcVCziIOg9aXDWb7lndc6HgWNULGplpwlib0p3My+DztOzGSYXw3xzs4/z6f2PS/CHntS/UPGK7aqFbFT9F24iYoulg+EdvDiWwJfQ/BYsoTvdVN2+YmK9PA3+4+nXd1/Tqx1KjpsuZNqaF4yAcX5j4a/+SqNPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l/x8UaAb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53A90C4CEFB;
	Thu, 18 Dec 2025 15:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766073201;
	bh=3e8zDr0N01tgUjErJ20SpEaudHEKPjQXUee4G45xszU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=l/x8UaAbN5Hlf8U0h3jF7BT0AE8GlcX7nDx0T3/QJ5qf+bbjjSkMEpdifY7sbBg9G
	 N3LY/7YpF7ldVTPFJCkYm9xeY52nc9nsnOQU/qyZR0OxoV31MN3Csub5rLrWSzzvKs
	 MsrSR3iWIP4jCdhfGOMyEYbIIKcZ94iCIEK+4Nu1PoliXJZc3PTEDWVGTLfaRqP9Sq
	 DWqBW0J4rRUrqCK4wFl90sm+pmw2uv6cN5DYnkWWu/oYpef2F+E1ExO2MdHS3IXW46
	 gOf+zj+aq85lMF30mG/BX5M9pvVyHIaFKBETH/1dLPARtilIf4+cGtD5/jqW8LZ9dN
	 tGWOoqeotdtlQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F2C1E380A96A;
	Thu, 18 Dec 2025 15:50:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 1/2] net/sched: act_mirred: fix loop detection
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176607301053.3021115.5040572027984314461.git-patchwork-notify@kernel.org>
Date: Thu, 18 Dec 2025 15:50:10 +0000
References: <20251210162255.1057663-1-jhs@mojatatu.com>
In-Reply-To: <20251210162255.1057663-1-jhs@mojatatu.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 xiyou.wangcong@gmail.com, jiri@resnulli.us, victor@mojatatu.com,
 dcaratti@redhat.com

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 10 Dec 2025 11:22:54 -0500 you wrote:
> Fix a loop scenario of ethx:egress->ethx:egress
> 
> Example setup to reproduce:
> tc qdisc add dev ethx root handle 1: drr
> tc filter add dev ethx parent 1: protocol ip prio 1 matchall \
>          action mirred egress redirect dev ethx
> 
> [...]

Here is the summary with links:
  - [net,1/2] net/sched: act_mirred: fix loop detection
    https://git.kernel.org/netdev/net/c/1d856251a009
  - [net,2/2] selftests/tc-testing: Test case exercising potential mirred redirect deadlock
    https://git.kernel.org/netdev/net/c/5cba412d6a00

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




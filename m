Return-Path: <netdev+bounces-94768-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C64518C0989
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 04:01:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8197528334C
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 02:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AD8A13D26F;
	Thu,  9 May 2024 02:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SdY4z+7G"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF7D13C8F6
	for <netdev@vger.kernel.org>; Thu,  9 May 2024 02:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715220032; cv=none; b=rjDvxj5S30ZhWoIxG8FD5bctQdGbbW+yS09+SvpTCggsH+zKwXpej0toPDX+fvW4CdCdVdngRBcotGXRnRpajfKxH/mCOpyGhweqBxyqh3wPlCQ+glVs2cPR1sMXcCFFhhiJe1rPe9RsamAnkCkYTavG2MBEwrLsqHPHt444csc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715220032; c=relaxed/simple;
	bh=o4pbevIWAdv8eNGEdEfEfMQLtItSy3rMMvzp0kZYMeo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hYGIBAj7smnIOdrdxNkMtAYC7R6Rvygbv7gAmfOR8cQyzRgeQHOOjOk71EbrWu1rYHEfjlXrEHqoe6UixAORSFni7oMjVwConPOUUH41Q+VkGv+xZrxARnldyesWAL5e0LelsE5e6gZuB96hnyc00zG5QWOG0rdXwWNZTS1de0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SdY4z+7G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 98D92C3277B;
	Thu,  9 May 2024 02:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715220031;
	bh=o4pbevIWAdv8eNGEdEfEfMQLtItSy3rMMvzp0kZYMeo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SdY4z+7GL4JVJYcIxcgh1lL/pnsd5ADkyNLVoU90Ik0NjscKcKykB2KjrpjfcfQet
	 09sSGs8bUAgXspQ76Ha2j/3o5lj+Bz1qU2+1lm+Tpv6gtUQ7XTm0rjH3bo1irsZ3pi
	 0Ppu3aCmYwCSaULzQd4PW+TJ2arpGmXI8h51cUikwFaGlSolOltNCFO/9Kecm+PCK5
	 ILeSWu5N7Es96mKUXzTJrx0dFzJ8PhQovuQsYWhjnpPWppipxx3NwzmZ5ooWeij6rU
	 N1FZKa4bYF2Uy8+V37uYQzuTP4X9j94sCcemtHKrsOq7po1VUASe0ZUNU93uwMq871
	 y/xW3AurS6qnQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8EF9DC43331;
	Thu,  9 May 2024 02:00:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next] phonet: no longer hold RTNL in route_dumpit()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171522003158.32544.16276458730600064384.git-patchwork-notify@kernel.org>
Date: Thu, 09 May 2024 02:00:31 +0000
References: <20240507121748.416287-1-edumazet@google.com>
In-Reply-To: <20240507121748.416287-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, courmisch@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  7 May 2024 12:17:48 +0000 you wrote:
> route_dumpit() already relies on RCU, RTNL is not needed.
> 
> Also change return value at the end of a dump.
> This allows NLMSG_DONE to be appended to the current
> skb at the end of a dump, saving a couple of recvmsg()
> system calls.
> 
> [...]

Here is the summary with links:
  - [v2,net-next] phonet: no longer hold RTNL in route_dumpit()
    https://git.kernel.org/netdev/net-next/c/58a4ff5d77b1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




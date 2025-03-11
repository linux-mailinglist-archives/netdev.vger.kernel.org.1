Return-Path: <netdev+bounces-173830-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB0DAA5BE8B
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 12:10:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81C513A6341
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 11:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A42362505CA;
	Tue, 11 Mar 2025 11:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A2DGIGW2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F93823F295
	for <netdev@vger.kernel.org>; Tue, 11 Mar 2025 11:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741691399; cv=none; b=RS6oyAnvBTj5Jif0rTWvN7avjwFzllQc6ZPN+ZpDVNi9p66QVwiu42zdvNPj3/VHmwa0C1E0HqAyuARV7nEuNEqhqevgKXLyW+SWYt9qO+JmNtFAZAKexTFGoyqV5GF/XrvQzNc21keihdhTbVVpw5j7JTlT4neONVyL3c52rE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741691399; c=relaxed/simple;
	bh=Q8RGcdbo3x42RT43XpScecgNtUP9GiyOHuQvy7codmM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ixdFpe56QuXy4ALVjVkbkr8QptW4gjaRoWf16tqRnD3KBgAaXzyMt+MsndreMCAujxlwk2K9vjYMPnoLyAEEO2/JlB+bKlCj+lL9sxkY238FnFWl6oV95+kEiEbBgRNFQnRJGMexhe7f7fNS3+XZAQKPzsfhvsLIX0iO/gd5VIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A2DGIGW2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E651C4CEE9;
	Tue, 11 Mar 2025 11:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741691399;
	bh=Q8RGcdbo3x42RT43XpScecgNtUP9GiyOHuQvy7codmM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=A2DGIGW2Y0kKGIvhCZLBaI2rSyIc3wFtd1uOZR3hbOVme6P2bANe8ibzIfJb+QvPt
	 5OY8tIW5wE7ymUdjXiU0e/gY/tMy/0nwSTG6o89Jcd11zq6lpDieXnhV1+tVEtPGkV
	 XG6q/UwfBGvUeyfwFN3UQ4ukbOosESveWqWjYbF5G86p6dIYUVMARWTEA7ksQ23rBZ
	 o1qaraJKvKvFJRYRp254nbD126IplrzuzZ5bucL5xKYuTz6OgDfZy3fPeICJo8IfmU
	 oxirTKi+ZhCfZXlkv6DR4H3E2LtXzj422hcmmJgJXR+matn/Om835SApuLwaB8ZsBy
	 tnQGFT2FNTL1g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE1DA380AC1D;
	Tue, 11 Mar 2025 11:10:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: switchdev: Convert blocking notification chain to a
 raw one
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174169143350.3900781.4902273065149639967.git-patchwork-notify@kernel.org>
Date: Tue, 11 Mar 2025 11:10:33 +0000
References: <20250305121509.631207-1-amcohen@nvidia.com>
In-Reply-To: <20250305121509.631207-1-amcohen@nvidia.com>
To: Amit Cohen <amcohen@nvidia.com>
Cc: netdev@vger.kernel.org, idosch@nvidia.com, petrm@nvidia.com,
 jiri@resnulli.us, ivecera@redhat.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 olteanv@gmail.com, tobias@waldekranz.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 5 Mar 2025 14:15:09 +0200 you wrote:
> A blocking notification chain uses a read-write semaphore to protect the
> integrity of the chain. The semaphore is acquired for writing when
> adding / removing notifiers to / from the chain and acquired for reading
> when traversing the chain and informing notifiers about an event.
> 
> In case of the blocking switchdev notification chain, recursive
> notifications are possible which leads to the semaphore being acquired
> twice for reading and to lockdep warnings being generated [1].
> 
> [...]

Here is the summary with links:
  - [net] net: switchdev: Convert blocking notification chain to a raw one
    https://git.kernel.org/netdev/net/c/62531a1effa8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




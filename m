Return-Path: <netdev+bounces-203117-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 05439AF088E
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 04:40:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 550701693FB
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 02:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 184021C3C14;
	Wed,  2 Jul 2025 02:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vkqcc8AW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87E61BEF8C
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 02:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751423985; cv=none; b=fc927Oh+Xgu9dSX0pYMp4qpWQNMJAquzKwyaTXgTfcsFzkM78kQ6Jt6bFZitVJhLsCsJCm04RVQdopfoo6GPLpXwXyWQenoj3Kk+3L581qYuIIPKXfl6kdpEUb9FEjydGTajm60CQ58P76OqmaX/4TCJcl/ulxWxzadvJ4YUsvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751423985; c=relaxed/simple;
	bh=1RnshiMS6CZYuF+syZHasz0tuL/+4blBsAJSpJea/eU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BVjpSEM7wHoct0UJdacs5x2nPElEyTryKqbXDfDr5czocvhqjpPvlpc1H140ayFniiQjS28yGYv4pYnl97mrTLu7u0not+y3/iqGeHUJ2MrIiuJgskHL28ylwEHIpJhlRo9zagyF3XMtOT+Eh2C9TovrJm3z1OjKpoyqTOR8Rx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vkqcc8AW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F842C4CEEF;
	Wed,  2 Jul 2025 02:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751423984;
	bh=1RnshiMS6CZYuF+syZHasz0tuL/+4blBsAJSpJea/eU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Vkqcc8AW9JQl9HK0xNpQisSKZz0qWr3zVoezDE4Q3JK/ozB8P2KwMyp9eC7z7ym10
	 G2eB1Xb2kvJsJ9ud5zLn4uEYakc5MZ8GFQFIU/8mZ9p2+gM4l4wINhB3HqMEkaCr18
	 3Hhip/6uaSquzXF7bZxoUv8uDTrUUqbRvZ9UVVSBZMZheppRIUzNDdOi1UxIptI87A
	 z1ixUnuEfSUm/wBpB96ZB+2RBBz4Iix4V/yEvykki/q4EKDrHtQM1tV4K9OtG9lnLS
	 tcQyk1gmv0uakQopzCweH6Cwryi7kE8HpuPLkKThbn6KL4lpS7XnwxQ5bWBPGf+MTB
	 DL1U6Jvhfm//g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70DA4383BA06;
	Wed,  2 Jul 2025 02:40:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] enic: fix incorrect MTU comparison in
 enic_change_mtu()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175142400904.183540.117202859925248542.git-patchwork-notify@kernel.org>
Date: Wed, 02 Jul 2025 02:40:09 +0000
References: <20250628145612.476096-1-alok.a.tiwari@oracle.com>
In-Reply-To: <20250628145612.476096-1-alok.a.tiwari@oracle.com>
To: ALOK TIWARI <alok.a.tiwari@oracle.com>
Cc: johndale@cisco.com, neescoba@cisco.com, benve@cisco.com,
 satishkh@cisco.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 28 Jun 2025 07:56:05 -0700 you wrote:
> The comparison in enic_change_mtu() incorrectly used the current
> netdev->mtu instead of the new new_mtu value when warning about
> an MTU exceeding the port MTU. This could suppress valid warnings
> or issue incorrect ones.
> 
> Fix the condition and log to properly reflect the new_mtu.
> 
> [...]

Here is the summary with links:
  - [net] enic: fix incorrect MTU comparison in enic_change_mtu()
    https://git.kernel.org/netdev/net/c/aaf2b2480375

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




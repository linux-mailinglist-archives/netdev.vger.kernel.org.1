Return-Path: <netdev+bounces-163357-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3186A29FBA
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 05:40:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 776EA16265C
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 04:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7CD9156C5E;
	Thu,  6 Feb 2025 04:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bFO356Sx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A753B1A4
	for <netdev@vger.kernel.org>; Thu,  6 Feb 2025 04:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738816805; cv=none; b=YLITQ9Fb7P85Ev4Az/58SxlC6CzmrKYd06U/2OXf/el8nnO0hKiehrgqtuPfiwBgcisnsrqam+Q7roXoBP1t70eOqIDFRDSdb3ntQt9aiJrIu2YwXgkWlWBBszl4Rd9DUJVylgoQw0fIOy7LR9yOr1kUj5rUZK3ABMHy9qJtkNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738816805; c=relaxed/simple;
	bh=GM3WKWRI8gZKnLHOtE49k/Ngpm2PqMjMb0XSTJOr170=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NFcd138FdgBJWOBQaja/5dSIUc8WsonzNbeqZZ78tnUNqJcbACz91SQzFAur51EpT7/Sfrx5kap0M24b52mX4S6WO3n8WjMdV+foLqOw1YLY6A/u3nzGYp5TYJ01LfLGJbW7p5la/6c4UZF/zspZYWY7AtRvXIGffeaOFmLld64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bFO356Sx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28380C4CEDD;
	Thu,  6 Feb 2025 04:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738816805;
	bh=GM3WKWRI8gZKnLHOtE49k/Ngpm2PqMjMb0XSTJOr170=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bFO356Sxyw5qdM7L8mlRYA98tXpclZ7KgBVQ3AJAh2Ayf/X6BHIDUWvkBbdBNJwmY
	 dcamyjdtR7sEpHgdscZUSy1j8x+M1TtX0JwNirxc7hC4J2R9ejYy76hOS1ZUGZ9p1r
	 tkZR5JKM6SgrZ9KLmE+WbJ1M7mh0pSSP9EsXhyNr3wHUWfoAQs8Emb1wBcTy+yXY8+
	 rgc7pZ27IS4kX5IVxdt4kju0Qhl5BvwCKHVKe7cWUWN2q4jn/IIvI/gZS9X/tMUEgu
	 ANnZr+nGv+qNdS4ipW83iT4ffU1eCxO9Qb+gw60TOTtwRfonHUnCG100rM0dexeKAE
	 iJr9LyVEdM+xg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB264380AAD1;
	Thu,  6 Feb 2025 04:40:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/8] vxlan: Age FDB entries based on Rx traffic
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173881683280.1004532.16490678927076536825.git-patchwork-notify@kernel.org>
Date: Thu, 06 Feb 2025 04:40:32 +0000
References: <20250204145549.1216254-1-idosch@nvidia.com>
In-Reply-To: <20250204145549.1216254-1-idosch@nvidia.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, andrew+netdev@lunn.ch,
 horms@kernel.org, petrm@nvidia.com, razor@blackwall.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 4 Feb 2025 16:55:41 +0200 you wrote:
> tl;dr - This patchset prevents VXLAN FDB entries from lingering if
> traffic is only forwarded to a silent host.
> 
> The VXLAN driver maintains two timestamps for each FDB entry: 'used' and
> 'updated'. The first is refreshed by both the Rx and Tx paths and the
> second is refreshed upon migration.
> 
> [...]

Here is the summary with links:
  - [net-next,1/8] vxlan: Annotate FDB data races
    https://git.kernel.org/netdev/net-next/c/f6205f8215f1
  - [net-next,2/8] vxlan: Read jiffies once when updating FDB 'used' time
    https://git.kernel.org/netdev/net-next/c/1370c45d6e7e
  - [net-next,3/8] vxlan: Always refresh FDB 'updated' time when learning is enabled
    https://git.kernel.org/netdev/net-next/c/c4f2082bf641
  - [net-next,4/8] vxlan: Refresh FDB 'updated' time upon 'NTF_USE'
    https://git.kernel.org/netdev/net-next/c/40a9994f2fbd
  - [net-next,5/8] vxlan: Refresh FDB 'updated' time upon user space updates
    https://git.kernel.org/netdev/net-next/c/fb2f449eca51
  - [net-next,6/8] vxlan: Age out FDB entries based on 'updated' time
    https://git.kernel.org/netdev/net-next/c/b4a1d98b0fa5
  - [net-next,7/8] vxlan: Avoid unnecessary updates to FDB 'used' time
    https://git.kernel.org/netdev/net-next/c/9722f834fe9a
  - [net-next,8/8] selftests: forwarding: vxlan_bridge_1d: Check aging while forwarding
    https://git.kernel.org/netdev/net-next/c/c467a98e1de0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




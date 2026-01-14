Return-Path: <netdev+bounces-249695-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BB84D1C333
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 04:05:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C7EAC3015926
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 03:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CF1232861E;
	Wed, 14 Jan 2026 03:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M2EIj3gf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4999B2BDC2F
	for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 03:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768359851; cv=none; b=RqtMQYQeyqcYLdvBKhc6sII8JO5yzvfz7cIQjFCA9w8ywNxQovunol+g1KHOQgW/zOTZy6ouGvs6oPVOf0FErFze51q0ftry4creCpeSnaHKB1e/kdXlf/dE63YX+uywDCfUcsEgPxkLoA8UKTfA5lPQCBDPyl8X3bJWeF9PWO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768359851; c=relaxed/simple;
	bh=J7iwzGVzEFjKuyffi8fv6Bdf/peX6naZqF/0f4oKWx8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FOl8WatK3/Cad1Zov+gmkZprR2OQwqzUD6szvk8D7nGLLpQPPhEAU/NZ0QyJCVoVhKR78A/KGEgE5rcq4jb6fXd7Y+UI96nuzlHzMFBxFOsqjAc0TFjFcSYdPCg3DhCX8anCmg6LLqzL/mYr71IMlg9QSwavCrqL0H9ZNhUBPvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M2EIj3gf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0393C116C6;
	Wed, 14 Jan 2026 03:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768359850;
	bh=J7iwzGVzEFjKuyffi8fv6Bdf/peX6naZqF/0f4oKWx8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=M2EIj3gfPGcCMAUGoLPGGXjrREhMRyQBJP4gKS+3LDNd42tjTBQ/LrersPgk7YtNr
	 xU1YuvQT6qyLknERim7JKf46omnvaLBjAa15hi25vpa24DwDUvG+u7fwP/zqj6V0HK
	 TrV42rxqpPuo2oxUBT8U7o5OyxwJMFcAZi5Ifa341GlIzErOIqAnNcR+1CTtAg1cCf
	 tbGSKJPdDk+Hh0UP4UuiOUAt857kvCf1hL6enhg1RyEIJMAYhEpnamZSOgGdS0j2SD
	 Q/FFT+HuT6TJAilArYTt0vJjVi7boD1arqwzLHv6ViLVk4bWaYFkS4paPNXVpL5R/d
	 wA34OGNuTQgOg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3BE1A3808200;
	Wed, 14 Jan 2026 03:00:45 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/5] ipv6: Allow for nexthop device mismatch with
 "onlink"
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176835964383.2565069.10118878274791234922.git-patchwork-notify@kernel.org>
Date: Wed, 14 Jan 2026 03:00:43 +0000
References: <20260111120813.159799-1-idosch@nvidia.com>
In-Reply-To: <20260111120813.159799-1-idosch@nvidia.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, dsahern@kernel.org, horms@kernel.org,
 petrm@nvidia.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 11 Jan 2026 14:08:08 +0200 you wrote:
> This patchset aligns IPv6 with IPv4 with respect to the "onlink" keyword
> and allows IPv6 routes to be configured with a gateway address that is
> resolved out of a different interface than the one specified.
> 
> Patches #1-#3 are small preparations in the existing "onlink" selftest.
> 
> Patch #4 is the actual change. See the commit message for detailed
> description and motivation.
> 
> [...]

Here is the summary with links:
  - [net-next,1/5] selftests: fib-onlink: Remove "wrong nexthop device" IPv4 tests
    https://git.kernel.org/netdev/net-next/c/e5566f6b1d13
  - [net-next,2/5] selftests: fib-onlink: Remove "wrong nexthop device" IPv6 tests
    https://git.kernel.org/netdev/net-next/c/0a3419f4ba40
  - [net-next,3/5] selftests: fib-onlink: Add a test case for IPv4 multicast gateway
    https://git.kernel.org/netdev/net-next/c/9bf8345fb38a
  - [net-next,4/5] ipv6: Allow for nexthop device mismatch with "onlink"
    https://git.kernel.org/netdev/net-next/c/b853b94e8482
  - [net-next,5/5] selftests: fib-onlink: Add test cases for nexthop device mismatch
    https://git.kernel.org/netdev/net-next/c/f8f9ee9d8b2e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




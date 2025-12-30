Return-Path: <netdev+bounces-246316-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CA13CE93F7
	for <lists+netdev@lfdr.de>; Tue, 30 Dec 2025 10:44:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2F9F4300EA0A
	for <lists+netdev@lfdr.de>; Tue, 30 Dec 2025 09:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0097E2C1594;
	Tue, 30 Dec 2025 09:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QPtN6OG5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D083328CF4A
	for <netdev@vger.kernel.org>; Tue, 30 Dec 2025 09:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767087806; cv=none; b=WlgMOLd+1HvYX56Wv8lF8AfEe6jfafuRTqS8TAp/PrJt5vqib7fitvKlHV3KaT3sZTmyjteZO3r/uCd2JBvoAsw5zFyD5/DsbTNzBMB/LcJAkUmulNwpwDbsexM+ZoRrN8Ndc4S5HBDLkKJVoccNwDVTitCtooESuz+cYMKH+yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767087806; c=relaxed/simple;
	bh=Ue84SMBF1pvyjA3EGsqQWklI/ivTOy3AjNE+snwQjic=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JK0h+GedCwuPF1OgogYVuAPSR9sCPW6TgYkSRmI83wlN2iK4oTPmIELw68sVQ9TbMe1iFm27LWsXspn518VR6yREYHiHZ0mxf1JlkCZRogBVp41D8+USJ0axLSn/dO0YhKHxwegViV5c/1aqi3cQ6sue3UG5jI8AdByu6H5F0xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QPtN6OG5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A25AC4CEFB;
	Tue, 30 Dec 2025 09:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767087806;
	bh=Ue84SMBF1pvyjA3EGsqQWklI/ivTOy3AjNE+snwQjic=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QPtN6OG5CbNfyce+jU7TokNG81xXDxwaMq0+gxhaQ6MYEVewfTUuwwq4QcGZ+30YB
	 cnhwMPK0ZrTMpC5e5JtPKSZiD5beo7V6xyLxnfr5fGFG7iWyPD/bwZknsoXlJdkQAx
	 uDVXa7Ip/piZQCtLKeVi4KBdwDLCEvjcsCKbwnTeFMp1ykbJZ3OdcwxYjBhbHIG86A
	 fnktXmoXkdGsnWWzZhVdSXRRZMzagZwKH1hBsVUfaAoWQc/7friaIzNwpU5t2N9Iev
	 Lpnz15kAhvoa0yj7j8cOoyRL3pHaGMttzqNbIXfcTdw0DUXy0gKAJOTwknedZr7UN3
	 HKIZoWHmCWuxA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B58973808205;
	Tue, 30 Dec 2025 09:40:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 1/2] ipv4: Fix reference count leak when using error
 routes with nexthop objects
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176708760854.3192123.12598884931818074105.git-patchwork-notify@kernel.org>
Date: Tue, 30 Dec 2025 09:40:08 +0000
References: <20251221144829.197694-1-idosch@nvidia.com>
In-Reply-To: <20251221144829.197694-1-idosch@nvidia.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, dsahern@kernel.org, horms@kernel.org,
 penguin-kernel@I-love.SAKURA.ne.jp

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sun, 21 Dec 2025 16:48:28 +0200 you wrote:
> When a nexthop object is deleted, it is marked as dead and then
> fib_table_flush() is called to flush all the routes that are using the
> dead nexthop.
> 
> The current logic in fib_table_flush() is to only flush error routes
> (e.g., blackhole) when it is called as part of network namespace
> dismantle (i.e., with flush_all=true). Therefore, error routes are not
> flushed when their nexthop object is deleted:
> 
> [...]

Here is the summary with links:
  - [net,1/2] ipv4: Fix reference count leak when using error routes with nexthop objects
    https://git.kernel.org/netdev/net/c/ac782f4e3bfc
  - [net,2/2] selftests: fib_nexthops: Add test cases for error routes deletion
    https://git.kernel.org/netdev/net/c/44741e9de29b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




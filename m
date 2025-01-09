Return-Path: <netdev+bounces-156678-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77864A075C1
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 13:30:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA54B1889519
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 12:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79F3521773F;
	Thu,  9 Jan 2025 12:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uxt/26R1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C84217704
	for <netdev@vger.kernel.org>; Thu,  9 Jan 2025 12:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736425813; cv=none; b=cGN6+xtqo/T3muPMUW/5iEBasuylsUXz6hxDqPOZbo1LYTI/XovEffZ06WCtB51lT6PYo9PH3y/pfixPi+sCozRsTDZ1zpaHEKje3OAHOrgQfFCcll+JSzbhBDNpuJnIwT1lgtN29r6gQhMvTdjhRxA8n1ltMn8k0y++uNNtN5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736425813; c=relaxed/simple;
	bh=SVDUBkvdCXhDygFhqepo1Gj2a3qcNrSwKKJKkkWQQE8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MNFdm2cQaQZRzc+aIa73Ng+ybvlOFHzkQl3eED3pVYWa6MhaaGFISXDLulZkcpffKUmUaEUOHEtLWbBwD71RHlany5e50VwQlxlVSTiNp8Ztagdzjx7AYGyohFxnzyw8GEDTWKJk3jg103u/b2ea1MOOMv5l09OpjrFN4ENrTQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uxt/26R1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08B2FC4CED2;
	Thu,  9 Jan 2025 12:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736425813;
	bh=SVDUBkvdCXhDygFhqepo1Gj2a3qcNrSwKKJKkkWQQE8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uxt/26R14znHsHWpjaanzshsUd6/RCB1KmVmGLf+McuBAUoZAEspJI5qW2BfRCnSY
	 4IoCcYccJLuZhuyYNu8W0j/DSyrlualex7PHpzLJngG/XJn2nXdsQpybvRbRx27s7S
	 tBhRc5SyzjyNmet43yxUql+qmIOQFGjBgmyaMisnRwE+O0WV8cfBikh/hwTKaKuSBN
	 6XlTSDTjqPsx/nb9Vey4THS0kqHB10+r2SZrzQP5GJ7EQSKRkCqdjb3Jw0xV8d5hWr
	 M8qCr7UKKOUtaiMPKHkK7sEZS4bYgnqmmA+iuuSXsYygoFCyjJzyf0bAJ7tl/wWflF
	 5CrdMCj7VanpQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAC5B3805DB2;
	Thu,  9 Jan 2025 12:30:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: no longer reset transport_header in
 __netif_receive_skb_core()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173642583449.1307582.5133706319812640080.git-patchwork-notify@kernel.org>
Date: Thu, 09 Jan 2025 12:30:34 +0000
References: <20250107144342.499759-1-edumazet@google.com>
In-Reply-To: <20250107144342.499759-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, horms@kernel.org, eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue,  7 Jan 2025 14:43:42 +0000 you wrote:
> In commit 66e4c8d95008 ("net: warn if transport header was not set")
> I added a debug check in skb_transport_header() to detect
> if a caller expects the transport_header to be set to a meaningful
> value by a prior code path.
> 
> Unfortunately, __netif_receive_skb_core() resets the transport header
> to the same value than the network header, defeating this check
> in receive paths.
> 
> [...]

Here is the summary with links:
  - [net-next] net: no longer reset transport_header in __netif_receive_skb_core()
    https://git.kernel.org/netdev/net-next/c/2170a1f09148

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




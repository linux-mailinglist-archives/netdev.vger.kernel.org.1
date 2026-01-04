Return-Path: <netdev+bounces-246792-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CA7FCF1302
	for <lists+netdev@lfdr.de>; Sun, 04 Jan 2026 19:26:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 84F803014BCF
	for <lists+netdev@lfdr.de>; Sun,  4 Jan 2026 18:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B1982D7DD5;
	Sun,  4 Jan 2026 18:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mCcoV2Ao"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F552D7DC0;
	Sun,  4 Jan 2026 18:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767551164; cv=none; b=Ahtwhaz8rOzFJTbzcxB8nwvzG9VZZBJmgDa2M7tlR03E8DfSM5AAbxqtFyztuhLGJZ26KSw/NBCUZRw4oI15+HGl1aoc4rdrqsNgUndNhHmHoXxjPmSzREWjFMN+1RZJFdkhSQWs0clhLbY3gVg+Q8cp8ik3TPm6cHNz9dKLM28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767551164; c=relaxed/simple;
	bh=l49lKSRr9mv/JL0+y7qLuqhr0b4ZKkZ+dtOWdUKfR8w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kbLko//XK24XZoRJAvEb3G2KSmatDUe2VmwDQ0a8HOaBIbbVRmdhU01SsE8qkJfekeRZ/zmUM+ff0LB4ca0TKrCGa1MwyLvKQNabh3Olj6Ebf6dUZVA5n+aXm9UPdn5+Cci8XhhaRWH9VW8rYZqvUNL3sVfZ9T3xPi6UoEAuhV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mCcoV2Ao; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 171C8C19423;
	Sun,  4 Jan 2026 18:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767551164;
	bh=l49lKSRr9mv/JL0+y7qLuqhr0b4ZKkZ+dtOWdUKfR8w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mCcoV2AoQVVUqWBsEkiec/Il5Ms+XTd5g9infLt5GRuFp9ozoNjaR95E8zf/n05eV
	 1GmtYTT8CWrdS2GPYiGiTyup/RUe4E9+GD6xfOt+dpzCm0D+hOBOMVpbuwjeApCw7j
	 8g1yDNGf7i5k5tP2gDP/pqMXv0IdeynAVIQSFhSpNHRNn0JlsADmj1I9SpFLCW6tQi
	 1SNptGPZ4wtafkltv+PoIQZYUcfRGvweGCzqWZdBlCj+s864sCTWnlRVktqrjxyVc7
	 Gli9VgHQg8uKaLdL4N72ljAuYANWYQQJVOTJ4ZzJotzSU7wzQ8KmTf3K3TIEbkf2Hk
	 kMR27wBAroxDw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3B728380AA4F;
	Sun,  4 Jan 2026 18:22:44 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v5] net: sock: fix hardened usercopy panic in
 sock_recv_errqueue
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176755096302.142863.3789456679843940692.git-patchwork-notify@kernel.org>
Date: Sun, 04 Jan 2026 18:22:43 +0000
References: <20251223203534.1392218-2-bestswngs@gmail.com>
In-Reply-To: <20251223203534.1392218-2-bestswngs@gmail.com>
To: Weiming Shi <bestswngs@gmail.com>
Cc: security@kernel.org, edumazet@google.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, xmei5@asu.edu

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 24 Dec 2025 04:35:35 +0800 you wrote:
> From: Weiming Shi <bestswngs@gmail.com>
> 
> skbuff_fclone_cache was created without defining a usercopy region,
> [1] unlike skbuff_head_cache which properly whitelists the cb[] field.
> [2] This causes a usercopy BUG() when CONFIG_HARDENED_USERCOPY is
> enabled and the kernel attempts to copy sk_buff.cb data to userspace
> via sock_recv_errqueue() -> put_cmsg().
> 
> [...]

Here is the summary with links:
  - [net,v5] net: sock: fix hardened usercopy panic in sock_recv_errqueue
    https://git.kernel.org/netdev/net/c/2a71a1a8d0ed

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




Return-Path: <netdev+bounces-172403-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D66A54795
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 11:20:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8177518910C2
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 10:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AA721FFC73;
	Thu,  6 Mar 2025 10:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ltcQu+Zk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291101FF61B
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 10:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741256404; cv=none; b=k1MsnPgtz/BvnEbqFMBtFU39D8JOOMILLxRyTpVHiT4gPpRjf4VFgedTFOhGz4bJnRAoyG+Xnxn10+R3PzcaqoykTYy8jZ/KdqW0aHQXPpHhzBDY/TQWH9RKrF2vGKMWNF+zkEXWyrh8K+OsNY3pUcYwzgEfwsDDbVbCtI/fnJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741256404; c=relaxed/simple;
	bh=s9U3NeJu5xUHnVTfq44/O9SIkVPHi93p1awd9j3II5o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=m/cJwcp+xqfBEqK+I8xpWFY4UcEvTOjxz7FqNsZk1DdeZicR7zbYws96SsIuSDTDynO8ZWxr9AKko47umLrMrne0PoFi1ri5YHqA6prImDvkTt2mSQU+z1yx1BV940g7nNVY+OtLlxMxI/dAftRIO4hPNHYRedzPmTxvt6RDtQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ltcQu+Zk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 856DCC4CEE0;
	Thu,  6 Mar 2025 10:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741256403;
	bh=s9U3NeJu5xUHnVTfq44/O9SIkVPHi93p1awd9j3II5o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ltcQu+Zkf9m0Ep2Tkdnv1kkbg5TAKNGbshN48vrTbIDhnhzzEXeP5TXO3GfCWC6I3
	 G5j5Rb3xaDq2MStjc/Ew38S6PK9xpmGzbLsDe4F1pII1MmF/teTWp7yTS8kamOW5g0
	 yFPb6nnpoaKPPHGpZa/QUB/Q0to3nGzNw85n9WyTyFxsQwBHdyp0Cqa/dATogzZjc9
	 TjzlMEwgmWL2EjD37DFGrFBbVmy0kj4gFOwBRT5VQM7RG8aLdEZzgIlERhQCFk6aK2
	 b4akzyDR2LXG7wH249pmn/FOX8GS/3eC/5pWRwuxKKaFLfs+K5djzInzUXEVMMJ2/0
	 aLoI2B34cjeLg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB309380CFF3;
	Thu,  6 Mar 2025 10:20:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: ipv6: fix missing dst ref drop in ila lwtunnel
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174125643674.1536068.10690184654404944842.git-patchwork-notify@kernel.org>
Date: Thu, 06 Mar 2025 10:20:36 +0000
References: <20250305081655.19032-1-justin.iurman@uliege.be>
In-Reply-To: <20250305081655.19032-1-justin.iurman@uliege.be>
To: Justin Iurman <justin.iurman@uliege.be>
Cc: netdev@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 tom@herbertland.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed,  5 Mar 2025 09:16:55 +0100 you wrote:
> Add missing skb_dst_drop() to drop reference to the old dst before
> adding the new dst to the skb.
> 
> Fixes: 79ff2fc31e0f ("ila: Cache a route to translated address")
> Cc: Tom Herbert <tom@herbertland.com>
> Signed-off-by: Justin Iurman <justin.iurman@uliege.be>
> 
> [...]

Here is the summary with links:
  - [net] net: ipv6: fix missing dst ref drop in ila lwtunnel
    https://git.kernel.org/netdev/net/c/5da15a9c11c1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




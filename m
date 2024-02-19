Return-Path: <netdev+bounces-73087-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96FE485AD4E
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 21:40:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 448DC1F216EB
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 20:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A20C852F98;
	Mon, 19 Feb 2024 20:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZwGpWn7b"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790432E40C;
	Mon, 19 Feb 2024 20:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708375226; cv=none; b=g87uUdKlYs7TN+kPrk59Atf5mtOn+eqbQyLhVLi3T+70l6W8V6S4dalt7wkWCjKRsWw+CP9Oh0r4YO6CF2nWP6fftzPKMHoTnnx0a7+pDfK6Raf8d+7toiah2EQJjeErYOqFL36chNCgoO00MHxCR9MGbfGH2MaKGORDBk2lWP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708375226; c=relaxed/simple;
	bh=U7lK/QxgqZFx8nQ7+Dwc3ef1xihUvLtQ98Tcz07NpcA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=g7VZ+FycG7JAGmgLFs68R5TydgiouQsUnDf5Pes4TUD51ulbPPtG8BhklKBNhR0w5Rr2tSgsbesvL8dsj0EBk4wBfEE/KMOmME6NJWAHh8JcY7OxUnVPopoM2wcGZrvYmkHDxw6lSE/JHF4wBDnzq6S0/Zr//k3ZApH//S2hHDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZwGpWn7b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id F19E5C43390;
	Mon, 19 Feb 2024 20:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708375226;
	bh=U7lK/QxgqZFx8nQ7+Dwc3ef1xihUvLtQ98Tcz07NpcA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZwGpWn7boXQqk3yRS7pifDZgzDdPUTbDEx4mH8TW1Qz0HzcaNtEvqCqBbJEmHs7pD
	 79OCCfT4zjaL+Q4BygPgNf7QeAagIgdXuKmuaGkhPSWKYGRH9fw2B+K/sM6uXzcdnc
	 0ZWwj5SSGCK8y3AJ2ZKGX026/L0n/iu7WtNGEYjQZKrikR1kNisgj9apMhdOHVHehe
	 L5vAYzQImAdt3AU3rykRzbUQFRC07X9J5rbh/Zficri+7QcMaitqk5X57aCBMa1HSF
	 x2I6779FbVuLbLdm6Q4VqlreQrbMY/aooKFLUhIGOq6IAt448Oi1+39LuP/kaT0Q9L
	 2gLh0JK8oKcbw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D97D9D990D9;
	Mon, 19 Feb 2024 20:40:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] page_pool: disable direct recycling based on
 pool->cpuid on destroy
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170837522588.25032.4338620984116633204.git-patchwork-notify@kernel.org>
Date: Mon, 19 Feb 2024 20:40:25 +0000
References: <20240215113905.96817-1-aleksander.lobakin@intel.com>
In-Reply-To: <20240215113905.96817-1-aleksander.lobakin@intel.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, lorenzo@kernel.org, toke@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 15 Feb 2024 12:39:05 +0100 you wrote:
> Now that direct recycling is performed basing on pool->cpuid when set,
> memory leaks are possible:
> 
> 1. A pool is destroyed.
> 2. Alloc cache is emptied (it's done only once).
> 3. pool->cpuid is still set.
> 4. napi_pp_put_page() does direct recycling basing on pool->cpuid.
> 5. Now alloc cache is not empty, but it won't ever be freed.
> 
> [...]

Here is the summary with links:
  - [net-next] page_pool: disable direct recycling based on pool->cpuid on destroy
    https://git.kernel.org/netdev/net-next/c/56ef27e3abe6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




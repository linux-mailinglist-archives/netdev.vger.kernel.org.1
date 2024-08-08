Return-Path: <netdev+bounces-116945-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71D9494C288
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 18:21:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E21C1F211E9
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 16:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7413C190486;
	Thu,  8 Aug 2024 16:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QdYJpd7M"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5024619047D
	for <netdev@vger.kernel.org>; Thu,  8 Aug 2024 16:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723134039; cv=none; b=Pb8g0kEaHaHemOXdaSzjgrEiEXYPyo3nooiFM4XPdgqjWz8OEE2WPcOplDujiGC2fHo3mgLInxAKEo8rh75E5l4gu1W4T/69uCDkRKcx1tKUPb3BpuGKdk1nmss6o6/YYLKJaifIJ5n7W9BmaAsBS5mIUpSN54nO9v4EbFjvAhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723134039; c=relaxed/simple;
	bh=suGcuWnnfOGnm/pWJQKLvzmsM5J+UOXGkvOQ2WRqTTM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kZ7pVTn2oCVL2108/1mwyarJ6MClafLMENVwRXlgOglBe9pHQBiXKbk8to0xgjoC5G2RkkkyZMNqlHrGy1kZbApMrYjem98+zBQBjlqjr0d7+BAzWjcHjnsojEjlU5NUxrTDXL3o4pGa0SzlnJBKpSoDtvucIRU7kzBzFhlFb1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QdYJpd7M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D12EAC4AF0D;
	Thu,  8 Aug 2024 16:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723134038;
	bh=suGcuWnnfOGnm/pWJQKLvzmsM5J+UOXGkvOQ2WRqTTM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QdYJpd7MazALMKQAKT7cIySRywseXPZf79jy9cs7AdB1NAZsAedzryGjqJ6ONIjCo
	 5DaJgEEdU59+tjg7pqKi/T/Kpz6sEX7rUM1CoGFbCbpCDEBivTMaXDy+DRQOB2sQXa
	 1Uf74ZBQM1QbHv73NyRwIEqAPuYoiJry80SjOKJUoxu63V0yQGu+dUjOR+a6RGVX+h
	 na5mYMepZasCN0vmxgbQTLO1AzgNSpzLjtoBwzYXS4VpUNb21JaaCGYoF/h8Kb0roi
	 /x7P6qfga4Y53Qjzpdz/tnvm+kPjipEsiV/FyC2dVKScaYbw2x4UY+e75duqz7AR6x
	 +UbVXivm7acaw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB2A9382336A;
	Thu,  8 Aug 2024 16:20:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] l2tp: fix lockdep splat
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172313403743.3227143.13544837279013689401.git-patchwork-notify@kernel.org>
Date: Thu, 08 Aug 2024 16:20:37 +0000
References: <20240806160626.1248317-1-jchapman@katalix.com>
In-Reply-To: <20240806160626.1248317-1-jchapman@katalix.com>
To: James Chapman <jchapman@katalix.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org, tparkin@katalix.com,
 syzbot+6acef9e0a4d1f46c83d4@syzkaller.appspotmail.com, gnault@redhat.com,
 cong.wang@bytedance.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  6 Aug 2024 17:06:26 +0100 you wrote:
> When l2tp tunnels use a socket provided by userspace, we can hit
> lockdep splats like the below when data is transmitted through another
> (unrelated) userspace socket which then gets routed over l2tp.
> 
> This issue was previously discussed here:
> https://lore.kernel.org/netdev/87sfialu2n.fsf@cloudflare.com/
> 
> [...]

Here is the summary with links:
  - [net] l2tp: fix lockdep splat
    https://git.kernel.org/netdev/net/c/86a41ea9fd79

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




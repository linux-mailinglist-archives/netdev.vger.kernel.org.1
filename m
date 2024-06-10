Return-Path: <netdev+bounces-102249-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2122390217E
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 14:20:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C87831F21B6A
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 12:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D09A480020;
	Mon, 10 Jun 2024 12:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pNpHqj2l"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB1E7FBC3
	for <netdev@vger.kernel.org>; Mon, 10 Jun 2024 12:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718022033; cv=none; b=nFD6xnwLU9ihVuT83A5ZaCBtW9wdzy9OVzxeBxIL9aEjIVG5zGH7maVWPLhJ0Ny21VCjvW2+xFvlLUWnDDdWE35rbmQ7UxNh4vVUWDBgd525Qs27ptlPqIxywLNgujWi/iGGKwUebUy+UswyhTJ6ex5ZlQqsMivqfLTeaAKyoEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718022033; c=relaxed/simple;
	bh=bH2X/DXOo/kqVac5/ThyOT9o5nckFVg3RlYwkGCHeqM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=r4LwAKmMxQYRZWKnUcKelgDxPcA1sURu19gkv83t24I0px/cYYm+yCjT6hhs5ZL2vuGA41Wl+Bzp+zAfj5IAnqWGBd8eKmZ+LKfg4dxClcvEgwc7rIGphIgWqKuuuXspN3Kmwb/XOVveJGK3QtGC1OX9nSF3WArXl3210lRYxv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pNpHqj2l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 48D3AC2BBFC;
	Mon, 10 Jun 2024 12:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718022033;
	bh=bH2X/DXOo/kqVac5/ThyOT9o5nckFVg3RlYwkGCHeqM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pNpHqj2ljgA3f+Nb4JeVUY7t/syIrN0qmMaFJ+Pmw0TvNZ1i9mSmbW+e6rztW5Vfb
	 rTPSn/P6sj5WlM2jaTaa232D76D6UgOdRKSZGj0sA2swkosOKUpJr6hO4guiVKgujQ
	 EKY89HcaElJGJO9/PDc/RUomPWastEUiAuf/X04t41NZcN/Xwn7N8MqlR9I6Y6YXa0
	 nmHS/v4olZzAJtPbS0L1Z/Uv0ZN+LXcXL2J8Ih4nTXAw6euk8LEaEm8w2JqOciOuyD
	 oHrlcfKjQpAssLonNr8SwCvMyY1/Fn7mloog6ax0965yqUHbaZqWNuxbUbvOZGUob4
	 ouVDlAcJxP30w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 36F3DC595C0;
	Mon, 10 Jun 2024 12:20:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] tcp: fix race in tcp_v6_syn_recv_sock()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171802203322.2008.17795101928136841729.git-patchwork-notify@kernel.org>
Date: Mon, 10 Jun 2024 12:20:33 +0000
References: <20240606154652.360331-1-edumazet@google.com>
In-Reply-To: <20240606154652.360331-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, ncardwell@google.com, eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu,  6 Jun 2024 15:46:51 +0000 you wrote:
> tcp_v6_syn_recv_sock() calls ip6_dst_store() before
> inet_sk(newsk)->pinet6 has been set up.
> 
> This means ip6_dst_store() writes over the parent (listener)
> np->dst_cookie.
> 
> This is racy because multiple threads could share the same
> parent and their final np->dst_cookie could be wrong.
> 
> [...]

Here is the summary with links:
  - [net] tcp: fix race in tcp_v6_syn_recv_sock()
    https://git.kernel.org/netdev/net/c/d37fe4255abe

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




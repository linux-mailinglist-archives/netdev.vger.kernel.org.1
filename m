Return-Path: <netdev+bounces-99235-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 646CF8D42CA
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 03:20:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DBC19B238ED
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 01:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9713DFC18;
	Thu, 30 May 2024 01:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dfYyrdBQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734C8F510
	for <netdev@vger.kernel.org>; Thu, 30 May 2024 01:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717032029; cv=none; b=UaA2CfCfZb9f1nVBlt1RcmoZQySCeDOslD8kQYnNiywtOLFNcM+9JDmBPpebA0DAvd6Ga3GKZeNlpvO92Ghmr5UNz8WTCDqVn/js8J69zEtBiHrdY4EhEJQ32ZcA70mmRgzQmOIiPVU+udCkmtC99oIh76EzPvAwRnnd0HhoYnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717032029; c=relaxed/simple;
	bh=6pdWvSj5DZqxrc7luTtTDpKHZpCo2gks6FKcigZwWps=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bY7FUoVhL3OxfDje8jouzy+mTIWcGl6VhzbXdfFXegyEa7lk9sjYuoK4uwpInrR18X6QE7B74Lvu+m/Nt9Cxv+tVnERgIHlr5QE+enqgeTfEz2a4fBwH1gZlEBWYFu/uupRSlhTrUoneFYySirUJmLk13Q0VArifnni5Wsdt6Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dfYyrdBQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DC597C2BD10;
	Thu, 30 May 2024 01:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717032028;
	bh=6pdWvSj5DZqxrc7luTtTDpKHZpCo2gks6FKcigZwWps=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dfYyrdBQg/vhSm4umTO+VtCJJeV4t6zULKn4Bu+/7ZaIMYKIB4jeNFKJMKbWUQf0x
	 3HFg6zQSEPugg5ivqwCIBtHKzzhrSlOcXDSi3GAKNfT4wZnXwF1TSD8O6JJjM4yrqa
	 1pjWH8CW1sam2grYlIYu1TQ6zyUE/r3BnkVVZr1C1QD0tJ0RAqFH+xwqcGwWy3r4d9
	 vO16+aGS/tPnFpMcgn7qa8KRzB8wuuZ03ssoLTHKJ2LzoM3mY2R6j0/yHwAGszMpvX
	 NuT4KBEi2vwdDAFqXMjAvz+nSuPxtyL/Jt3Q8n8fk5vsbgi8rjT6n67B7e7DKs3kA2
	 bMmXbalciO8nA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C9927D40190;
	Thu, 30 May 2024 01:20:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: fix __dst_negative_advice() race
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171703202882.14088.8077644026814972622.git-patchwork-notify@kernel.org>
Date: Thu, 30 May 2024 01:20:28 +0000
References: <20240528114353.1794151-1-edumazet@google.com>
In-Reply-To: <20240528114353.1794151-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 dsahern@kernel.org, netdev@vger.kernel.org, eric.dumazet@gmail.com,
 clecigne@google.com, tom@herbertland.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 28 May 2024 11:43:53 +0000 you wrote:
> __dst_negative_advice() does not enforce proper RCU rules when
> sk->dst_cache must be cleared, leading to possible UAF.
> 
> RCU rules are that we must first clear sk->sk_dst_cache,
> then call dst_release(old_dst).
> 
> Note that sk_dst_reset(sk) is implementing this protocol correctly,
> while __dst_negative_advice() uses the wrong order.
> 
> [...]

Here is the summary with links:
  - [net] net: fix __dst_negative_advice() race
    https://git.kernel.org/netdev/net/c/92f1655aa2b2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




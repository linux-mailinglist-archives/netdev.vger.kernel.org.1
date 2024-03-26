Return-Path: <netdev+bounces-81888-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5741F88B812
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 04:11:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11D3B2C609F
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 03:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0CA412AAD8;
	Tue, 26 Mar 2024 03:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ErgRFYpu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B51412AACA
	for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 03:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711422631; cv=none; b=u3hI01oLo3hYmBVUD0Qidg2Af+rU1bZ76QlMgXQK0+UlGp22gzPq5bk1faQs/cZqGcA4+0NeoIjDiz4oH39wbyMdizGjY9XcLpnY2r6T5r2v05n9Maufp50c7JLYp7Fxi9piEoeLiZPrH/2/6hg2QJ38QhWmXsvVDRzL0koiIQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711422631; c=relaxed/simple;
	bh=PGdaQGynrnzHafYk8lraejD6U0yOzH+/gUe1QNuCJ8U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uYaPovQ1MfVS2H4OcdTeOjN6EiYyBKq5DPdZqQzU46gkaSmcz1Oh8AQc4+XQ3Er7LgFP0V7vHrl/54I9b5vSRl5tzO2m5HcGSsRsdIHKFfNiyXM+3H/hl5UJIeQa9fgNYPBcd0vkD93zwStPZT3oP054InpwjHhCZ8uEXaLxOGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ErgRFYpu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5C5E2C433C7;
	Tue, 26 Mar 2024 03:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711422630;
	bh=PGdaQGynrnzHafYk8lraejD6U0yOzH+/gUe1QNuCJ8U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ErgRFYpup5DYQGqLoBu/oBT2rO3Jum03X5dZKCkVOLGT5BOQimM0Vv7WOwwwPjfTw
	 iILyIhmD9TArxjEZyFV6gpzJaXh2uFNvujLnz3eyJwPE50KzhVKqkfQxC7JrV6OIjc
	 aN09vqSmpM2nbiC14n9jcWsFhgCUagcgmc/Luef4Db3dc1GbFm8MgdoOfZcGQXo8h5
	 jd5bbokd4rRKDh99H70AJLJ9InWJMXCY20IlwKFbU6X9HjgzMi85Yg6Qin1OAsVzJd
	 KOw8STMJKr+DI7JuUuHKZ3iiZBx4wa5v+TrHRU2O4P8Mlr5bb1H1fRYu4k+d3NCYWg
	 82aC5GxjThzag==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 444E8D2D0EE;
	Tue, 26 Mar 2024 03:10:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] tcp: properly terminate timers for kernel sockets
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171142263027.4499.16258165335643646386.git-patchwork-notify@kernel.org>
Date: Tue, 26 Mar 2024 03:10:30 +0000
References: <20240322135732.1535772-1-edumazet@google.com>
In-Reply-To: <20240322135732.1535772-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, josef@toxicpanda.com,
 penguin-kernel@I-love.SAKURA.ne.jp

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 22 Mar 2024 13:57:32 +0000 you wrote:
> We had various syzbot reports about tcp timers firing after
> the corresponding netns has been dismantled.
> 
> Fortunately Josef Bacik could trigger the issue more often,
> and could test a patch I wrote two years ago.
> 
> When TCP sockets are closed, we call inet_csk_clear_xmit_timers()
> to 'stop' the timers.
> 
> [...]

Here is the summary with links:
  - [net] tcp: properly terminate timers for kernel sockets
    https://git.kernel.org/netdev/net/c/151c9c724d05

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




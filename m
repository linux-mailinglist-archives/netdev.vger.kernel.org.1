Return-Path: <netdev+bounces-145484-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94AD39CF9CF
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 23:30:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 423651F25854
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 22:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 565C8191F84;
	Fri, 15 Nov 2024 22:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NbWKoDvY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E69B1917D0;
	Fri, 15 Nov 2024 22:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731709827; cv=none; b=gXkjYsQ8ysl6956w405gMK7D3OcwX3sROWQgqcv6e2vD3hZcow/yMOuB99C2RlJ0DO46D6+YrGPM7pKsQuBM2JThlSZ9uVrfGmy4mgirjmLDQHPo4TJTCEI+v5WgBMN25KOLb7qN1i+H74kRcpzjNhgZz7TIDd0UKQ4dudnmO10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731709827; c=relaxed/simple;
	bh=7LQXo9lDYXMlq0YAci7saYOMERvpFiYC7IL+WP3t84c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IuNd7hUYtwNNuc/HPzgCzdO+SO5hn+Oq3mJFcbJddqZ6TESqqP5xPJLMWo21TtyGP0Gv+e/ybuHoilZQzbeu8CgOv+9tcfBz+3Nwh7hyxlQz3JWT94gke2EoRcUKjqqP+zxZWsfZhXBi6AtoaYxUpX+GgMqeuPvBO4KYFD4KRjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NbWKoDvY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A37B3C4CED5;
	Fri, 15 Nov 2024 22:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731709826;
	bh=7LQXo9lDYXMlq0YAci7saYOMERvpFiYC7IL+WP3t84c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NbWKoDvYosKHjrEa0Ty4HeMuoji9s/1KwwM1Pyf8hXdDrsYjLp4+qncFO9QqIOcio
	 raLSTomP8ITDeLzc9fz8Pn/xefXqh5RgbVk6fc/T+4qsJhCXkIpBofxa+DoSnPrJg/
	 ByMGJvuZpIuLOm4f8AFQJxFuqzn3IG718net8Hugvx4lar6IHTvqQHRgo27qOVnX4W
	 F1jIDfHjNM709zee3gsRvlI0aSAMVq3RWUU4bIFDpvevb0191ifL4ba/RGRWxzNN4B
	 7PFm6lM+0vdJVmP/jSpDYcGnMLXNXoao/5mKSeudHTOTkSwROKyy5y8VRA8J7JPHe+
	 +RjGkvv6iKnyg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADBB13809A80;
	Fri, 15 Nov 2024 22:30:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3] netdev-genl: Hold rcu_read_lock in napi_set
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173170983724.2752190.16324801199055029193.git-patchwork-notify@kernel.org>
Date: Fri, 15 Nov 2024 22:30:37 +0000
References: <20241114175600.18882-1-jdamato@fastly.com>
In-Reply-To: <20241114175600.18882-1-jdamato@fastly.com>
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, edumazet@google.com,
 amritha.nambiar@intel.com, sridhar.samudrala@intel.com, kuba@kernel.org,
 mkarsten@uwaterloo.ca, davem@davemloft.net, horms@kernel.org,
 almasrymina@google.com, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 14 Nov 2024 17:55:59 +0000 you wrote:
> Hold rcu_read_lock during netdev_nl_napi_set_doit, which calls
> napi_by_id and requires rcu_read_lock to be held.
> 
> Closes: https://lore.kernel.org/netdev/719083c2-e277-447b-b6ea-ca3acb293a03@redhat.com/
> Fixes: 1287c1ae0fc2 ("netdev-genl: Support setting per-NAPI config values")
> Signed-off-by: Joe Damato <jdamato@fastly.com>
> 
> [...]

Here is the summary with links:
  - [net-next,v3] netdev-genl: Hold rcu_read_lock in napi_set
    https://git.kernel.org/netdev/net-next/c/ed7231f56cd7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




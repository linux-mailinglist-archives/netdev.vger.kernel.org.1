Return-Path: <netdev+bounces-157965-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ADE05A0FF35
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 04:30:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8FDD1887E84
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 03:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58456233529;
	Tue, 14 Jan 2025 03:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QbOFkANR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34012232797
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 03:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736825425; cv=none; b=mM8FYOTD3O1mLDw7qIfRvoMY3+K+J9ZZM4KU/F+7z71QhRMaFragSnOgxQamA4pz3Wn2Cpz03VuYysnh4xgQ+YAiFCxdPtcQN0/jFLlDtzQLYcf2S4/iPrAfY0LcOTM9PpXDP3+3twTZOVajhD0mQq6h9B19eIc5ij0w2eWA9Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736825425; c=relaxed/simple;
	bh=4MDDEGmPI966bF2QJAgwdnq8j7a3S5wwXg8hLSHwCJ4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VzIIHEfPy4X3Z2LBjE+RQfyi5gyvE/sw6R9nTEgF8JF6aSXilY7w/oA3ivO4MuYyvCsgUe5UtE7AmcZdgSbS4DUEEq0yrD6ELc4yl6JEGx70D8GjeSuOTaHif7+nOQxsfB7KR3Eb8h65Uk96ZZn98IZorQAIZCT42ZFsS+YMXG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QbOFkANR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94B3CC4CEDF;
	Tue, 14 Jan 2025 03:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736825424;
	bh=4MDDEGmPI966bF2QJAgwdnq8j7a3S5wwXg8hLSHwCJ4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QbOFkANRaoBN2XWyrFefJp/gGcme3idfg1CkejSrRIhT698wZIkqsfg0dNnh8S9J0
	 l81cMaZCBBPGKVaxnpXC26bi+8j6pQZUUuj/EsgYMRmi9GuvC0iWpfnj29ydVOyeN7
	 rCl86HrF1wj0eQXQiUOrDm95v4bCYmaislLC7jC9MA4AspmQZiupcFQ5km+YC9HL2f
	 UlCmOqbRvaB7moRPC6dO38FQNKDppifLWRZhCfigGiAY7waqY+Fmo/aGXzsM54aQTF
	 eadBovtZNa3n+olHqv0eZTm+X7wEnWcA70h7os9poTtnDomHXglea3fwxUN9zda+ZL
	 bjZ433HjszdJw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70DE7380AA5F;
	Tue, 14 Jan 2025 03:30:48 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] eth: iavf: extend the netdev_lock usage
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173682544724.3721274.8703534117396404103.git-patchwork-notify@kernel.org>
Date: Tue, 14 Jan 2025 03:30:47 +0000
References: <20250111071339.3709071-1-kuba@kernel.org>
In-Reply-To: <20250111071339.3709071-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 intel-wired-lan@lists.osuosl.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 10 Jan 2025 23:13:39 -0800 you wrote:
> iavf uses the netdev->lock already to protect shapers.
> In an upcoming series we'll try to protect NAPI instances
> with netdev->lock.
> 
> We need to modify the protection a bit. All NAPI related
> calls in the driver need to be consistently under the lock.
> This will allow us to easily switch to a "we already hold
> the lock" NAPI API later.
> 
> [...]

Here is the summary with links:
  - [net-next] eth: iavf: extend the netdev_lock usage
    https://git.kernel.org/netdev/net-next/c/afc664987ab3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




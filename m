Return-Path: <netdev+bounces-112239-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD00F93794B
	for <lists+netdev@lfdr.de>; Fri, 19 Jul 2024 16:40:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93DF11F22EF5
	for <lists+netdev@lfdr.de>; Fri, 19 Jul 2024 14:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF0F81DFC7;
	Fri, 19 Jul 2024 14:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T6DAl2gh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B139AD5E
	for <netdev@vger.kernel.org>; Fri, 19 Jul 2024 14:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721400032; cv=none; b=WUN09V3TMMF46Lylw8MCgp5u2PzDEB4QQqdn4pOZE44YiMoEzV+6hhUqrPzPUbvF9VZ7byjuOjVZNtZUx+x/QQW7ZOinDNSCvMnRJLO4klPRQFEXfoZTs8t7wIdUoqKbmV+EHn8wutxscIuICPGPPnWVDjLuHsMfqx4z9nozNso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721400032; c=relaxed/simple;
	bh=hYTAO8tBcvIjaFQj0J2eQqykTAl/Gcac9r4RmCfJs2w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=t3QMomD4AGmimu7PUzg13Kt7IBFUB/hTtc5dNLBhMHTjf8FxqTzJp5mLMW8TX6LtUT0qaZfTQ6qykylpS9UHVCronrnVfQqAPD+nrCKNW5OdhlgMvmCG0ppFmfUGZsVM6+NEqWE/BVkQsxzpBzNBpL6m5OTp8u17XfCMWA8WYhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T6DAl2gh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0E642C4AF0D;
	Fri, 19 Jul 2024 14:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721400032;
	bh=hYTAO8tBcvIjaFQj0J2eQqykTAl/Gcac9r4RmCfJs2w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=T6DAl2ghJyRpq8xVXKZFDpZxV71fHIWZ7Yo5ALOXs3enFG7oBdz53vcVyH0WJ1PB5
	 NnZdLqbfZOfZs3OXvZbp26GQzPQDkk2lfiIYmegZ3X8CoVPj61F15u69ZnU3dGE6fw
	 e24KC+cAPlGnmNUiYrO80RGaHEk85YO8B2QTVZEcJTV12wJiBRaHfsvwIziBdF3JMc
	 XQzurHYtMomjsX0qAdqch0axCg4cVs+Eg0T6jERkj0pOUd5htfUBXTFZBOBkZcM5+5
	 gcxKbBsYV49jZ7xc2Eui45tkO0VFRzb/SPgHRYN9xli/230QJEChOYVOjQBAioV4YT
	 PJud+nmC59elw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EDD91C43335;
	Fri, 19 Jul 2024 14:40:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] eth: fbnic: don't build the driver when skb has more
 than 21 frags
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172140003196.32757.15280601174885684237.git-patchwork-notify@kernel.org>
Date: Fri, 19 Jul 2024 14:40:31 +0000
References: <20240717161600.1291544-1-kuba@kernel.org>
In-Reply-To: <20240717161600.1291544-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, alexanderduyck@fb.com, kernel-team@meta.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 17 Jul 2024 09:15:59 -0700 you wrote:
> Similarly to commit 0e03c643dc93 ("eth: fbnic: fix s390 build."),
> the driver won't build if skb_shared_info has more than 25 frags
> assuming a 64B cache line and 21 frags assuming a 128B cache line.
> 
>   (512 - 48 -  64) / 16 = 25
>   (512 - 48 - 128) / 16 = 21
> 
> [...]

Here is the summary with links:
  - [net,v2] eth: fbnic: don't build the driver when skb has more than 21 frags
    https://git.kernel.org/netdev/net/c/4359836129d9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




Return-Path: <netdev+bounces-154604-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AA579FEC32
	for <lists+netdev@lfdr.de>; Tue, 31 Dec 2024 02:50:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA4153A2836
	for <lists+netdev@lfdr.de>; Tue, 31 Dec 2024 01:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD0B61C68F;
	Tue, 31 Dec 2024 01:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="niHsLlCI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80BECA4B
	for <netdev@vger.kernel.org>; Tue, 31 Dec 2024 01:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735609807; cv=none; b=dIKXG39loiaSkFwnxSbaC5ucwRZnsi0ViIV8Fz91cmNnJ3SGeUCoT1Yggtdcbhw+pB58fxW6c+GuyJmd23UUZ3keeX0veEsjcxw/OxrpfzByC73F16Wa3wkGihqiv+54m5nrviKVHYnHcZsMOxPtF3/YdaKPoS+DkBfUvAOW3fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735609807; c=relaxed/simple;
	bh=3hhvqkEwUtlGAnHGzqZdDCFDygfRWaEimyG55fkKkew=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dFVRxO9/IBAPcUtRQdTNgJRCYWjeQeuzDSOdZQ8nthUq8ZSKjOgn+MucT9zCb0rRvH8WQxv/WvEfLEl27YzELwUq91omziAvqIs5DQC8qhVkYnp/gJoQdfkpJftbtOG3xv3l5PP71JZmZcKPyVT03MbC9NiWiWHx0VOUWBunwYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=niHsLlCI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B155C4CED0;
	Tue, 31 Dec 2024 01:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735609807;
	bh=3hhvqkEwUtlGAnHGzqZdDCFDygfRWaEimyG55fkKkew=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=niHsLlCIJ8trrPuSOqz/vTdLh1Ya1NxpBY83UL61o7hllOy1v8CCLKbDp8yboYOAD
	 o2oofCzIteJRyMFXVhce+/RpFVAt2w+e1OAzN6Fl6pKIj1SlS7JMGtYyE36OaZwJ87
	 7C6TJsWscrXwNV8TZdr79HzrvzS0XmaP9DaA1Nacrn1xk6SIH1VnTnAOToqBW2FvgA
	 GNfI5hmfrELNm9cE6dgpylqAgEqNf3N06Wz8sh7yEBph19a11+onIWv05TJusfZmow
	 Sc7a9bp3c+fVt743O1qBQr6ezvqH+E9CKhe5JIpFNtIKfDshzyDAkKAiSPD4zLLuRG
	 6Z0hwiwe4l/5A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C31380A964;
	Tue, 31 Dec 2024 01:50:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v4] net: mv643xx_eth: fix an OF node reference leak
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173560982701.1484600.4723480913350402349.git-patchwork-notify@kernel.org>
Date: Tue, 31 Dec 2024 01:50:27 +0000
References: <20241221081448.3313163-1-joe@pf.is.s.u-tokyo.ac.jp>
In-Reply-To: <20241221081448.3313163-1-joe@pf.is.s.u-tokyo.ac.jp>
To: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
Cc: sebastian.hesselbarth@gmail.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 21 Dec 2024 17:14:48 +0900 you wrote:
> Current implementation of mv643xx_eth_shared_of_add_port() calls
> of_parse_phandle(), but does not release the refcount on error. Call
> of_node_put() in the error path and in mv643xx_eth_shared_of_remove().
> 
> This bug was found by an experimental verification tool that I am
> developing.
> 
> [...]

Here is the summary with links:
  - [net,v4] net: mv643xx_eth: fix an OF node reference leak
    https://git.kernel.org/netdev/net/c/ad5c318086e2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




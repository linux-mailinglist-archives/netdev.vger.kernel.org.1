Return-Path: <netdev+bounces-104705-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF83490E108
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 03:00:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3B5C2845B2
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 01:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CDC063A9;
	Wed, 19 Jun 2024 01:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ibOp04Da"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9916524F;
	Wed, 19 Jun 2024 01:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718758830; cv=none; b=a8Z+nwqYj4IC0Pi91I21tR9iOts8vZZBS4Hm1/09l5D4r19BjbQFhCkXAI27jhJfmzNYR4J77u/mnut8hAC+74AkA+8BsoNxF41PBlJs5jIoFDACMzNeHBj6sUYkMDys7WFLrDhx+HAwuwhRS6LEoo6NS+XE0yeWaLpu1mE93PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718758830; c=relaxed/simple;
	bh=MznVFIDlLNIZKJVCdbNw94H9vpcVhR/eBfZkLRSfuME=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=t2SdWE+HMpaTjBbap6LvMtXQkQzl2R02yMcsf5TE4FAqhriNA6fK+Ee93kn3dbD1q+c7El0CocvbxUSUxxxsE3lul7B5n0Rzal60rcPL9heYdbBB4HNYYDVjhprozzpt8CLfJwkD8bZa+CXGaIkH1sBgG0WPnUky1Y6/PTHCGPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ibOp04Da; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5167DC4AF4D;
	Wed, 19 Jun 2024 01:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718758830;
	bh=MznVFIDlLNIZKJVCdbNw94H9vpcVhR/eBfZkLRSfuME=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ibOp04DaxKqUDmngBASIhe5FIxeNtWrXGTJwdKDmHVEJ7dX8y5GSK1X9sT+AJum1P
	 2JSQmVEgCxOa36g/OVJaMPYpZNjs92Td4hbNDOGedW8WsvYP4zD553bROTKtPpp/Bz
	 g2qB+7R39mUPDlyAHU05qDXVntPE1ah9fX2MLTSbeRol/qHCgdzg1UxqJSW69w6zG9
	 GqZVSao/fKLyOc3u2BjRCleQC4ok4T7Bz3/pRMauVG/aNqMDtmQ4izBMfWyyAJzJFV
	 Nil9JFgGtgdfmTXShRj7p+XZBKqXPWEAw7SiYjNdVsYtJ/gmSLjBmN/LWenw5gtYNn
	 urC3OGLN/TwaQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 40754C4361C;
	Wed, 19 Jun 2024 01:00:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net v2 PATCH] net: stmmac: No need to calculate speed divider when
 offload is disabled
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171875883025.1104.10779394765419858622.git-patchwork-notify@kernel.org>
Date: Wed, 19 Jun 2024 01:00:30 +0000
References: <20240617013922.1035854-1-xiaolei.wang@windriver.com>
In-Reply-To: <20240617013922.1035854-1-xiaolei.wang@windriver.com>
To: xiaolei wang <xiaolei.wang@windriver.com>
Cc: horms@kernel.org, olteanv@gmail.com, linux@armlinux.org.uk,
 alexandre.torgue@foss.st.com, andrew@lunn.ch, joabreu@synopsys.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, wojciech.drewek@intel.com, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 17 Jun 2024 09:39:22 +0800 you wrote:
> commit be27b8965297 ("net: stmmac: replace priv->speed with
> the portTransmitRate from the tc-cbs parameters") introduced
> a problem. When deleting, it prompts "Invalid portTransmitRate
> 0 (idleSlope - sendSlope)" and exits. Add judgment on cbs.enable.
> Only when offload is enabled, speed divider needs to be calculated.
> 
> Fixes: be27b8965297 ("net: stmmac: replace priv->speed with the portTransmitRate from the tc-cbs parameters")
> Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
> 
> [...]

Here is the summary with links:
  - [net,v2] net: stmmac: No need to calculate speed divider when offload is disabled
    https://git.kernel.org/netdev/net/c/b8c43360f6e4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




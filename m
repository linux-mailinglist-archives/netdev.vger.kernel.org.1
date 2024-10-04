Return-Path: <netdev+bounces-132153-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 58365990931
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 18:30:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE50A1F22EA4
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 16:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 747071CACE0;
	Fri,  4 Oct 2024 16:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YYj1WNH4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA031CACD4
	for <netdev@vger.kernel.org>; Fri,  4 Oct 2024 16:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728059433; cv=none; b=cQHVq0ABFZTHuoOrF/CfvLwL+JX/IGBF+ujs92MrJrSeOQIKYI5xjJABekPtWd2h2GZQp9+v5cMajp7YOwvkQ1s40/o8N2L++t0lfeRfEyaRE1V8237bFfC3AyRiVZRqjgR/7vwvgq9zraWdJtEsMCsL4qjezZvoN3sBGPWbr/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728059433; c=relaxed/simple;
	bh=RBPGO1WIplFlVhFxV3nlIsh4d+fSLVhShl85yJ/ym3Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HMhirOi0gd1e/g5Z5izhRJC94NRMIluGstiX+DWS6YULyr5zTnV6FLi5a7DDBsjTMEO/yOwQsBvE1gNEkycXlracKLquLNI9+nb/Dc6nqJ3gvq1eLlIPM7yFoJcgwfyiw+iI7UtFGefaQQbzIbxhBPJeQnbPZs87dyRvSMIuzhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YYj1WNH4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23E9AC4AF09;
	Fri,  4 Oct 2024 16:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728059433;
	bh=RBPGO1WIplFlVhFxV3nlIsh4d+fSLVhShl85yJ/ym3Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YYj1WNH42wavD5ZI4cLUSUR7DmQA2eSUdIGd20fxnqT1WzseTV3dOTpHZZ+eOLy1u
	 Wdx4lT/1dHNren/syDsTfwp1xDCi0QxEzmXONKjdSpfxU8yNl+3hb7wK556jATtk5f
	 i+k3zV3fkooNKE4VBBkTo+X6vwaDpD5y+vXNAEwvw/UAkL6AjgBr7W0ZgSATfspcv4
	 l9SAJPc0vHHTsoZdxixOpm7GRb79J5Nig5pbBJEvmbj9xxU33yFajbgP3o9yYEP1Zn
	 MvKkvbzdmmsxjk9N63QM2TdJdM6zht4qZ7NZIrJ+qXbI9T4LcklkB7bM4GTxEAgyzL
	 Oa7ww5t+FoJXA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB20639F76FF;
	Fri,  4 Oct 2024 16:30:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/4] qed: 'ethtool -d' faster, less latency
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172805943675.2652527.6575043288015766563.git-patchwork-notify@kernel.org>
Date: Fri, 04 Oct 2024 16:30:36 +0000
References: <20240930201307.330692-1-mschmidt@redhat.com>
In-Reply-To: <20240930201307.330692-1-mschmidt@redhat.com>
To: Michal Schmidt <mschmidt@redhat.com>
Cc: manishc@marvell.com, netdev@vger.kernel.org, csander@purestorage.com,
 palok@marvell.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 30 Sep 2024 22:13:03 +0200 you wrote:
> Here is a patch to make 'ethtool -d' on a qede network device a lot
> faster and 3 patches to make it cause less latency for other tasks on
> non-preemptible kernels.
> 
> Michal Schmidt (4):
>   qed: make 'ethtool -d' 10 times faster
>   qed: put cond_resched() in qed_grc_dump_ctx_data()
>   qed: allow the callee of qed_mcp_nvm_read() to sleep
>   qed: put cond_resched() in qed_dmae_operation_wait()
> 
> [...]

Here is the summary with links:
  - [net-next,1/4] qed: make 'ethtool -d' 10 times faster
    https://git.kernel.org/netdev/net-next/c/b8db67d4df00
  - [net-next,2/4] qed: put cond_resched() in qed_grc_dump_ctx_data()
    https://git.kernel.org/netdev/net-next/c/6cd695706f8b
  - [net-next,3/4] qed: allow the callee of qed_mcp_nvm_read() to sleep
    https://git.kernel.org/netdev/net-next/c/cf54ae6b5920
  - [net-next,4/4] qed: put cond_resched() in qed_dmae_operation_wait()
    https://git.kernel.org/netdev/net-next/c/2efeaf1d2a13

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




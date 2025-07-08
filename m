Return-Path: <netdev+bounces-205067-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9A08AFD040
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 18:11:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1D4B5673C3
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 16:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B40D2E540B;
	Tue,  8 Jul 2025 16:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GUYiqeCa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17C92E4264;
	Tue,  8 Jul 2025 16:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751990985; cv=none; b=Vc5BeDHbtSwEWcJQuQshZUu50PEKUOiuzH1L96uUZJDmn6dciTt0xi0BCm6/fh4jarelb1cxCym9p+BkaW5F66dmcDO6Zkn3kBYEHkc2Y3aUiBOfddpdpjNiUp6nhu6GTIZA2VcG55EXI95lY2Te1Mt2ZqUAKMn1iei8bEzlzeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751990985; c=relaxed/simple;
	bh=w7uZ8LAu1UM9qlOa4hCypCdhlhhJjNzQsr0NYy+DYvM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BCxXDYqv/eQAb5Z1WDoMbmV5kNEImDdciXyXuR7gqDPH9zzZqajfuuFWAgo6U8ELU7EwzkfAmVzzTCW1qZN1R1Pplkb871djWxIg7PVa1rw+4Zq07bxTZDb3LvjieMna56FSooqjWk6Nz38L4NmxulOpoUvhPSM0+VK3NTTsH4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GUYiqeCa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6415FC4CEED;
	Tue,  8 Jul 2025 16:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751990984;
	bh=w7uZ8LAu1UM9qlOa4hCypCdhlhhJjNzQsr0NYy+DYvM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GUYiqeCa7ewmMxeJQTgKZasiENZyVFJtn0w71QUUFAi7NTPexPYDIr2+LQfExo5YF
	 neQFZFunrKl7R4LTAvHa2SzT/PInphc77Q/jaGSCJG4znEgTo9GyvgmyCVw+qHl/w5
	 NpaMg8i4rrQU+u9aK2JS5TAcxy6bg4KzacT1eJlIq2+kiznqJ3sGUzYdkb1FXU1ejn
	 Pd2+CLDO80IgZX89+87tA7nnrU7RAn02bIAc336PCFKF1MQC0owC8tIsmMs22ioQGC
	 LVxoBsB1bGCVQjRB/QwZBcxek3qkxPuQPVGjXW4MNFPh23VI3UZkVwXmZN2V7tjzMt
	 3htp0H7msVmZQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70F26380DBEE;
	Tue,  8 Jul 2025 16:10:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 net] net: airoha: Fix an error handling path in
 airoha_probe()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175199100737.4122127.16143501388505360128.git-patchwork-notify@kernel.org>
Date: Tue, 08 Jul 2025 16:10:07 +0000
References: 
 <1c940851b4fa3c3ed2a142910c821493a136f121.1746715755.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: 
 <1c940851b4fa3c3ed2a142910c821493a136f121.1746715755.git.christophe.jaillet@wanadoo.fr>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: lorenzo@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 horms@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat,  5 Jul 2025 10:34:32 +0200 you wrote:
> If an error occurs after a successful airoha_hw_init() call,
> airoha_ppe_deinit() needs to be called as already done in the remove
> function.
> 
> Fixes: 00a7678310fe ("net: airoha: Introduce flowtable offload support")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> Reviewed-by: Simon Horman <horms@kernel.org>
> Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>
> 
> [...]

Here is the summary with links:
  - [v4,net] net: airoha: Fix an error handling path in airoha_probe()
    https://git.kernel.org/netdev/net/c/3ef07434c7db

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




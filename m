Return-Path: <netdev+bounces-230621-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 806C9BEBFF1
	for <lists+netdev@lfdr.de>; Sat, 18 Oct 2025 01:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A9493BC7D6
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 23:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41CD318DB26;
	Fri, 17 Oct 2025 23:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pb1OVnQb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1344F354AC3;
	Fri, 17 Oct 2025 23:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760743824; cv=none; b=Byxt3+2s3ex9FlzD4FMR2+tvZ73x3VuFR3iRNBK3hCK8qbiWKNYwt32Z3IzAidTPCiQW0+nUQCSJQjsSiRUKMzFrM72fD1//PIrq+TH3PocVPTFsOz5m+tyA/lYvQReXYmsMeNy5dTBvud3FWZyWQ7yrWHG7vlYRa7MLxwkaHbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760743824; c=relaxed/simple;
	bh=O43bnzlHzYWF3tohh8BdhIl4bku7eCG5WrTgzFJ6OQ0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fTpH4N/Bay4DXQI+AUVkBjm3Vri4cCf2fOFC/JDDhlmzHlVf3c2cOHvHXXHvuAolAd5dvMpG6MpCFZ8k+GKzXJq+Gdwzt1X4abKy3baiyeRPu25RAaUC2h7RDSE8Xn4mrmZddC03wIGx98ogedyAbialoaR/ndiIfLW01rVyX5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pb1OVnQb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79501C4CEE7;
	Fri, 17 Oct 2025 23:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760743823;
	bh=O43bnzlHzYWF3tohh8BdhIl4bku7eCG5WrTgzFJ6OQ0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Pb1OVnQbUFYdrBvUhhnGQWX+KiAMzNE7WQEaZeNxlqLbIgqQKIRRVhoD/oknE5+at
	 /GSEs3/KKeVHhH3OosMBCoWH3enT5XgxODaD+6h0oOfFGTryPQ+4/eFQ7Q6SHmqVCE
	 xiK/BLpyNqn3qY77/eGZksFSAAkjFYudcnZm9et3QtGxi59fxpSH316lZHNr5BKglc
	 0SoulIJEncLPxLUNYyLl7KNAe76TULCn0N3wfxvYkVncRPU0I+4dH0SnTep87MuRGY
	 VWK1yOdzPlgLn6l4oY26FmgY4uNoKIo2OaM+mRkHWKgxfOvtJCfEqUuHI/PmRA7/8h
	 I3vRMezMKuTFw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34B0D39EFA5D;
	Fri, 17 Oct 2025 23:30:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [v4 PATCH net] net: enetc: fix the deadlock of enetc_mdio_lock
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176074380701.2822953.14692637268674439157.git-patchwork-notify@kernel.org>
Date: Fri, 17 Oct 2025 23:30:07 +0000
References: <20251015021427.180757-1-jianpeng.chang.cn@windriver.com>
In-Reply-To: <20251015021427.180757-1-jianpeng.chang.cn@windriver.com>
To: Jianpeng Chang <jianpeng.chang.cn@windriver.com>
Cc: claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, wei.fang@nxp.com,
 xiaoning.wang@nxp.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 alexandru.marginean@nxp.com, imx@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 15 Oct 2025 10:14:27 +0800 you wrote:
> After applying the workaround for err050089, the LS1028A platform
> experiences RCU stalls on RT kernel. This issue is caused by the
> recursive acquisition of the read lock enetc_mdio_lock. Here list some
> of the call stacks identified under the enetc_poll path that may lead to
> a deadlock:
> 
> enetc_poll
>   -> enetc_lock_mdio
>   -> enetc_clean_rx_ring OR napi_complete_done
>      -> napi_gro_receive
>         -> enetc_start_xmit
>            -> enetc_lock_mdio
>            -> enetc_map_tx_buffs
>            -> enetc_unlock_mdio
>   -> enetc_unlock_mdio
> 
> [...]

Here is the summary with links:
  - [v4,net] net: enetc: fix the deadlock of enetc_mdio_lock
    https://git.kernel.org/netdev/net/c/50bd33f6b392

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




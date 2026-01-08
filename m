Return-Path: <netdev+bounces-248177-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DD4ED052E0
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 18:49:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DD80133197D0
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 16:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD0E72E9749;
	Thu,  8 Jan 2026 16:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="STeu9Ohd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D642E92B3;
	Thu,  8 Jan 2026 16:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767891225; cv=none; b=oCb4ILjr70UJi7zXsakj0D0+sQ7haU2+7RtLLsokIAQJ+9F1A9Hdmw65FMO4+RAmtKGZaPBKRVaBEwN785P358erftkr+wk575sbxfGf3kEQWKQOv79VNzTgis4/A/jEpycQ44XCjMggQJfXMCrOMUdO9g1GLMtNEKk5Wvjhtfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767891225; c=relaxed/simple;
	bh=i6dVRJG+I1R9SW2c8nfM6ffyXlvX60SGhGpE4GiquWU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Wukw9PRdZl1zSzG5GivgqU/x13HfrntZc/HAD2eOggKmI4W3mmVDiRuC4Ph11WS+je+ovWEj2XaC5baXfEiUGhzEsXhXUEtXRBLDfktZeVt1KxinSzXYhfFi33D20JgGh/BHqJMWhgvadhx1ZmZR49ObnQouiaru9EniUSt3uEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=STeu9Ohd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2041EC116C6;
	Thu,  8 Jan 2026 16:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767891225;
	bh=i6dVRJG+I1R9SW2c8nfM6ffyXlvX60SGhGpE4GiquWU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=STeu9OhdZM+HFvZVZNNRbZClfRU5gLsbfnwwqLGLU1yQPOnSDQ+8jpLNKKXZlkZ4+
	 77WZbPUqPesVNQUStmiLaiwH/dCx3BUDXhxfq9EmkPRPgYpFhWazWfStK5O54QKRkh
	 IDIDCcz93wFO4HFWyRpx/59PT7ku+iv+/MB46idvH+AoxzlZrpPZDVOJIy+uF2obKb
	 9hbyNQnYXwT4MjaTdVop5MNMkZZV27rriJWandy4sTGiuozjI/oVomHwBZlkEvwXco
	 tSvTvAWACfzppEKv5BiSqfl2axbuq4x9YNsgpx7kykgnSO59DyUBCVBHH5Ec6mc0do
	 crfXvZhf+xT3w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B59BF3A54A3D;
	Thu,  8 Jan 2026 16:50:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: enetc: fix build warning when PAGE_SIZE is
 greater
 than 128K
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176789102128.3716059.7380953613614818892.git-patchwork-notify@kernel.org>
Date: Thu, 08 Jan 2026 16:50:21 +0000
References: <20260107091204.1980222-1-wei.fang@nxp.com>
In-Reply-To: <20260107091204.1980222-1-wei.fang@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, xiaoning.wang@nxp.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  7 Jan 2026 17:12:04 +0800 you wrote:
> The max buffer size of ENETC RX BD is 0xFFFF bytes, so if the PAGE_SIZE
> is greater than 128K, ENETC_RXB_DMA_SIZE and ENETC_RXB_DMA_SIZE_XDP will
> be greater than 0xFFFF, thus causing a build warning.
> 
> This will not cause any practical issues because ENETC is currently only
> used on the ARM64 platform, and the max PAGE_SIZE is 64K. So this patch
> is only for fixing the build warning that occurs when compiling ENETC
> drivers for other platforms.
> 
> [...]

Here is the summary with links:
  - [net] net: enetc: fix build warning when PAGE_SIZE is greater than 128K
    https://git.kernel.org/netdev/net/c/4b5bdabb5449

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




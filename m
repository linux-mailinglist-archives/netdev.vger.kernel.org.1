Return-Path: <netdev+bounces-155178-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32B33A015D3
	for <lists+netdev@lfdr.de>; Sat,  4 Jan 2025 17:40:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 899691883FD8
	for <lists+netdev@lfdr.de>; Sat,  4 Jan 2025 16:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A8751BD9F5;
	Sat,  4 Jan 2025 16:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oy5Ey4K/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E01745016;
	Sat,  4 Jan 2025 16:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736008813; cv=none; b=vFYhavqlKNKBv+4HZ3dtpDdWudacpmlCTXtI5yj5cimLRmlDrmwizQ0BQkwQYHK8YH6PouIejfTNg9+nJyq/AfOx3k46TUj9UC1+f6ZqKmLPK56y5EF00uDres0CjPlPqQexhMemGDdqBhTF/4d1Mv+7j6H4FP2UCnm1sxEsxYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736008813; c=relaxed/simple;
	bh=tCT+7Os+RfJEqwMhOzVKsW5XxM91BFqHnsUi9tzq2kA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PjcwsvCrK93qybfGAfTRARlXA2gGCfB9Iu6N+QCOn+A95fZ/K9I+w6zUuH6Gkyx1jOG9E8/kW9Ma52PySAXQ4bASXD4ndYHbKjGVmTt8bHlpqXp8Yo7rufmtnkbnVBNRQJgjcstZu8klbhpkpfUQGaOmmH3Aszg5rj9yC+lTyXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oy5Ey4K/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C8F1C4CED2;
	Sat,  4 Jan 2025 16:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736008812;
	bh=tCT+7Os+RfJEqwMhOzVKsW5XxM91BFqHnsUi9tzq2kA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=oy5Ey4K/rJxBiok5Y26aq2c/JBdNJxBbpvZS1uXWMh20I9iys5W5hqsFYHW/eUHHd
	 v6ZOaZjH0QXOtztLErB4hHvKWZ4EJC0JYqxewwkswSUuw1JL7Y1H/F8EKXFR+Al8fM
	 vfJkxYHjMO15shYbx6mNK52yMbekrMDrzerPB389rbERkWaV1Ejvz16UGeEVLhu++s
	 nqxfzuwZJCQ5j/PJPRmDGLL8E4FhT0u6U9zFCKvO13Zr88ZXEQSj4WcYgfsg5rH/R1
	 Ztmrntfq2NUoD9c6xJ8+q8lbxwVYSxNHQm3cFTxiFSSGUTSN671BANUyeixxGXbY34
	 MFTMC3T5e+i4w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 716E8380A96F;
	Sat,  4 Jan 2025 16:40:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: stmmac: TSO: Simplify the code flow of DMA
 descriptor allocations
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173600883331.2467289.14997468976709274364.git-patchwork-notify@kernel.org>
Date: Sat, 04 Jan 2025 16:40:33 +0000
References: <20241220080726.1733837-1-0x1207@gmail.com>
In-Reply-To: <20241220080726.1733837-1-0x1207@gmail.com>
To: Furong Xu <0x1207@gmail.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 alexandre.torgue@foss.st.com, joabreu@synopsys.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, xfr@outlook.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 20 Dec 2024 16:07:26 +0800 you wrote:
> The TCP Segmentation Offload (TSO) engine is an optional function in
> DWMAC cores, it is implemented for dwmac4 and dwxgmac2 only, ancient
> dwmac100 and dwmac1000 are not supported by hardware. Current driver
> code checks priv->dma_cap.tsoen which is read from MAC_HW_Feature1
> register to determine if TSO is enabled in hardware configurations,
> if (!priv->dma_cap.tsoen) driver never sets NETIF_F_TSO for net_device.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: stmmac: TSO: Simplify the code flow of DMA descriptor allocations
    https://git.kernel.org/netdev/net-next/c/356939999438

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




Return-Path: <netdev+bounces-149943-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5F5B9E82FF
	for <lists+netdev@lfdr.de>; Sun,  8 Dec 2024 02:40:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10103281B46
	for <lists+netdev@lfdr.de>; Sun,  8 Dec 2024 01:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2A4F8F77;
	Sun,  8 Dec 2024 01:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FsUEyrDI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C814D28F5;
	Sun,  8 Dec 2024 01:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733622012; cv=none; b=nF+01A3zGnc2KlL0srp1FdOIaGIZ2Z5lExXsJmqORtY980ChhgnZ/xihO8trjBZjgJOvIBEBVqFipbu9Ter1e9v12q2l/d+6d9dCVJXHk0ApNEqYdheYJkDEXO9xnzXd+28TZhXSRwkupW8dyoxxC/RbiuP78oaqLhHeV5DBWZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733622012; c=relaxed/simple;
	bh=VyiblBiYlxn7Uc7Og93Odk9bRuYvCt+pFQYcjLF4aak=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=E5UEwtYeNgb9HQK7v2nPr5quHap9RV6jKMQZzoCHNBRjPxvZ+T19AS/Rao3iUVYObY5tFMDGOwCyDngDlyXMvoqkcmmQff+95GZ9m3N7oQKoMg8WivrRk5kBZIzxx31PCW3+Wlsi86KZbdmB34hF3fm3fdaWHM3BB12oCk8mVo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FsUEyrDI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 455B2C4CECD;
	Sun,  8 Dec 2024 01:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733622012;
	bh=VyiblBiYlxn7Uc7Og93Odk9bRuYvCt+pFQYcjLF4aak=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FsUEyrDIc2ScY6FxH2CjAQDZ4naGABhNjTw5cFRzwDX6PCnQREtJYZKyrNLnHQS8k
	 wbFY7pli1+pGibZtL2W6TgPNrZbNCEtdfj3Pjt9rhKB9TDteEZ7vxK4wsPXFCpOjX/
	 0C2v/QAmDU90Sk850SOcKn63o1MZyzuK1w/snlL3GTKH7R5Vx5ARDHVgi9P6+Qns5a
	 f70ZQhrXO4PrDl2VEM858n6PF3TjNcMzKZror2MJyq4L0+M4KehUnsMIP4g3POK2FQ
	 STQbj27fCQxX9IasnwAoWofeBs5pgSa4UyoJ+vmskbwIWWMo+1hfFrzCpeDnWFlTtH
	 mVnjehQ56KCaA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE941380A95D;
	Sun,  8 Dec 2024 01:40:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: stmmac: fix TSO DMA API usage causing oops
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173362202750.3128634.12775021527593555165.git-patchwork-notify@kernel.org>
Date: Sun, 08 Dec 2024 01:40:27 +0000
References: <E1tJXcx-006N4Z-PC@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1tJXcx-006N4Z-PC@rmk-PC.armlinux.org.uk>
To: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 andrew+netdev@lunn.ch, alexandre.torgue@foss.st.com, joabreu@synopsys.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, xfr@outlook.com, 0x1207@gmail.com,
 jonathanh@nvidia.com, thierry.reding@gmail.com, horms@kernel.org,
 hkelam@marvell.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 06 Dec 2024 12:40:11 +0000 you wrote:
> Commit 66600fac7a98 ("net: stmmac: TSO: Fix unbalanced DMA map/unmap
> for non-paged SKB data") moved the assignment of tx_skbuff_dma[]'s
> members to be later in stmmac_tso_xmit().
> 
> The buf (dma cookie) and len stored in this structure are passed to
> dma_unmap_single() by stmmac_tx_clean(). The DMA API requires that
> the dma cookie passed to dma_unmap_single() is the same as the value
> returned from dma_map_single(). However, by moving the assignment
> later, this is not the case when priv->dma_cap.addr64 > 32 as "des"
> is offset by proto_hdr_len.
> 
> [...]

Here is the summary with links:
  - [net] net: stmmac: fix TSO DMA API usage causing oops
    https://git.kernel.org/netdev/net/c/4c49f38e20a5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



